\name{partitionNEEGL}
\alias{partitionNEEGL}
\title{partitionNEEGL}
\description{Partitioning NEE fluxes into GP and Reco after daytime method.}
\usage{partitionNEEGL(ds, NEEVar.s = paste0("NEE", 
    SuffixDash.s, "_f"), TempVar.s = "Tair_f", 
    VPDVar.s = "VPD_f", RadVar.s = "Rg_f", 
    Suffix.s = "", ..., controlGLPart = partGLControl(), 
    isVerbose = TRUE, nRecInDay = 48L, lrcFitter = RectangularLRCFitter())}
\arguments{
  \item{ds}{dataset with all the specified input columns
and full days in equidistant times}
  \item{NEEVar.s}{Variable of NEE}
  \item{TempVar.s}{Filled air or soil temperature variable (degC)}
  \item{VPDVar.s}{Filled Vapor Pressure Deficit - VPD - (hPa)}
  \item{RadVar.s}{Filled radiation variable}
  \item{Suffix.s}{string inserted into column names before
identifier for NEE column defaults
(see \code{\link{sEddyProc_sMDSGapFillAfterUstar}}).}
  \item{\dots}{further arguments to
\code{\link{partGLExtractStandardData}}, such as \code{PotRadVar.s}}
  \item{controlGLPart}{further default parameters,
see \code{\link{partGLControl}}}
  \item{isVerbose}{set to FALSE to suppress output messages}
  \item{nRecInDay}{number of records within one day
(for half-hourly data its 48)}
  \item{lrcFitter}{R5 class instance
responsible for fitting the light response curve.
Current possibilities are \code{RectangularLRCFitter()},
\code{NonrectangularLRCFitter()},
and \code{LogisticSigmoidLRCFitter()}.}
}
\details{Daytime-based partitioning of measured net ecosystem fluxes into
gross primary production (GPP) and ecosystem respiration (Reco)

The fit to the light-response-curve is done by default using the Rectangular
hyperbolic function, as in Lasslop et al. (2010)
Alternative fittings can be used by providing the correspodning subclass of
\code{\link{LightResponseCurveFitter-class}} to \code{lrcFitter} argument.
(see \code{\link{LightResponseCurveFitter_predictGPP}})

While the extrapolation uses filled data, the parameter optimization
uses only measured data, i.e. with specified quality flag.
With the common case where VPD is missing for fitting the LRC, by default
(with \code{controlGLPart$isRefitMissingVPDWithNeglectVPDEffect = TRUE})
is to redo the estimation of LRC parameters with neglecting the VPD-effect.
Next, in the preditions (rows) with missing VPD are then replaced
with predictions
based on LRC-fits that neglected the VPD effect.}
\value{\item{Reco_DT_<suffix>}{predicted ecosystem respiraiton: mumol CO2/m2/s}
\item{GPP_DT_<suffix>}{predicted gross primary production mumol CO2/m2/s}
\item{GPP2000}{predicted gross primary production
mumol CO2 / m2 / s for VPD = 0 at Rg = 2000}
\item{<LRC>}{Further light response curve (LRC) parameters and
their standard deviation depend on the used LRC
(e.g. for the non-rectangular LRCC
see \code{\link{NonrectangularLRCFitter_getParameterNames}}).
They are estimated for windows and are reported with the first record
of the window}
\item{FP_VARnight}{NEE filtered
for nighttime records (others NA)}
\item{FP_VARday}{NEE filtered for daytime
records (others NA)}
\item{NEW_FP_Temp}{temperature after filtering for quality
flag degree Celsius}
\item{NEW_FP_VPD}{vapour pressure deficit after filtering
for quality flag, hPa}
\item{FP_RRef_Night}{basal respiration estimated
from nighttime (W / m2)}
\item{FP_qc}{quality flag: 0: good parameter fit,
1: some parameters out of range, required refit,
2: next parameter estimate is more than two weeks away}
\item{FP_dRecPar}{records until or after closest record
that has a parameter estimate associated}
\item{FP_errorcode}{information why LRC-fit was not
successful or was rejected, see result of
\code{\link{LightResponseCurveFitter_fitLRC}}}
\item{FP_GPP2000}{predicted GPP at VPD = 0 and PAR = 2000:
a surrogate for maximum photosynthethic capacity}
\item{FP_OPT_VPD}{list object
of fitting results including iOpt and covParms}
\item{FP_OPT_NoVPD}{same as
FP_OPT_VPD holding optimization results with fit
neglecting the VPD effect
}}
\references{Lasslop G, Reichstein M, Papale D, et al. (2010) Separation of
net ecosystem exchange into assimilation and respiration using
a light response curve approach: critical issues and global evaluation.
Global Change Biology, Volume 16, Issue 1, Pages 187-208}
\author{TW
Department for Biogeochemical Integration at MPI-BGC, Jena, Germany <REddyProc-help@bgc-jena.mpg.de> [cph], Thomas Wutzler <twutz@bgc-jena.mpg.de> [aut, cre], Markus Reichstein <mreichstein@bgc-jena.mpg.de> [aut], Antje Maria Moffat <antje.moffat@bgc.mpg.de> [aut, trl], Olaf Menzer <omenzer@bgc-jena.mpg.de> [ctb], Mirco Migliavacca <mmiglia@bgc-jena.mpg.de> [aut], Kerstin Sickel <ksickel@bgc-jena.mpg.de> [ctb, trl], Ladislav Šigut <sigut.l@czechglobe.cz> [ctb]}



\seealso{\code{partGLFitNightTimeTRespSens}

\code{partGLFitLRCWindows}

\code{partGLInterpolateFluxes}}

