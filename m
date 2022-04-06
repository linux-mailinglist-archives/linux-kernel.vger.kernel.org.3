Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6623C4F6003
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbiDFNcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 09:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233242AbiDFNbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 09:31:40 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E43D241A23;
        Wed,  6 Apr 2022 03:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649241062; x=1680777062;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7BOmvCdRFAv/gY9HLfk9ydO5M6LQp2SsKGE4WkQrlLc=;
  b=nByM+B6gHEMR/xbC/yLDCQxPt8iCeZ0sPAsXmDTz9KAsNDgnunECuSBG
   XTRlUkluQHtrr+UXPX9CuAVLS8KNpVmk28vIvCPq75Tne0HXIDtfC/TS1
   +mk7ELQkxhQMvYVOMr3kaCbOxavTa9/PvG1fhA/D0J55YxTWZgrejeAhu
   eR8fYuhvdvnqv75s3mQayQdOxa656Etvo8B5LpVjMz6+ejxFe9TAiSG6s
   PXZL00+GLQDe1+3Nko/JrTw7VUceHSdxutRNBLdLKKskbNw0J52MXHYqS
   iTqxr7//ThYy77GzmKJ+F6rw3NIjr7ZuzEgESdHlY5EfF6FnQmfMirXeg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324179482"
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="324179482"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2022 03:27:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,239,1643702400"; 
   d="scan'208";a="697319921"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 06 Apr 2022 03:27:11 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 06 Apr 2022 13:27:11 +0300
Date:   Wed, 6 Apr 2022 13:27:11 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>
Cc:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_ppratap@quicinc.com,
        quic_kriskura@quicinc.com
Subject: Re: [PATCH v3 3/3] usb: dwc: host: add xhci_plat_priv quirk
 XHCI_SKIP_PHY_INIT
Message-ID: <Yk1q/05wfFULey2C@kuha.fi.intel.com>
References: <YjxjxplpOpDC2JLs@kuha.fi.intel.com>
 <4c2a28ad-b866-1b65-e73a-4eda0596cea2@linux.intel.com>
 <Yj2nPa6/Y01P5aCY@kuha.fi.intel.com>
 <4619c75c-cd34-82f2-56e1-a8bcb6d97177@linux.intel.com>
 <Yj3h4p/kmZTvMz0O@kuha.fi.intel.com>
 <fae54b27-9ae2-ecfc-69ae-40e5f5e1afbe@quicinc.com>
 <bd694ef9-be57-79f1-e95e-5501c396be25@linux.intel.com>
 <YkWNpTLjh2weX9Mk@kuha.fi.intel.com>
 <20220404082516.GE29680@hu-pkondeti-hyd.qualcomm.com>
 <20220406062543.GA10801@hu-pkondeti-hyd.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220406062543.GA10801@hu-pkondeti-hyd.qualcomm.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 06, 2022 at 11:55:43AM +0530, Pavan Kondeti wrote:
> Hi Heikki/Mathias,
> 
> On Mon, Apr 04, 2022 at 01:55:16PM +0530, Pavan Kondeti wrote:
> > Hi Heikki,
> > 
> > On Thu, Mar 31, 2022 at 02:16:53PM +0300, Heikki Krogerus wrote:
> > > On Wed, Mar 30, 2022 at 08:47:34PM +0300, Mathias Nyman wrote:
> > > > On 29.3.2022 12.18, Sandeep Maheswaram (Temp) wrote:
> > > > > Hi Mathias,Heikki
> > > > > 
> > > > > On 3/25/2022 9:08 PM, Heikki Krogerus wrote:
> > > > >> On Fri, Mar 25, 2022 at 04:33:27PM +0200, Mathias Nyman wrote:
> > > > >>> On 25.3.2022 13.27, Heikki Krogerus wrote:
> > > > >>>> On Fri, Mar 25, 2022 at 12:36:22AM +0200, Mathias Nyman wrote:
> > > > >>>>> On 24.3.2022 14.27, Heikki Krogerus wrote:
> > > > >>>>>> On Thu, Mar 24, 2022 at 12:07:11PM +0530, Sandeep Maheswaram wrote:
> > > > >>>>>>> Currently the phy init is done from dwc3 and also xhci which makes the
> > > > >>>>>>> runtime_usage value 2 for the phy which causes issue during runtime
> > > > >>>>>>> suspend. When we run the below command the runtime_status still shows
> > > > >>>>>>> active.
> > > > >>>>>>> echo auto > /sys/bus/platform/devices/88e3000.phy/power/control
> > > > >>>>>>>
> > > > >>>>>>> dwc3 manages PHY by own DRD driver, so skip the management by
> > > > >>>>>>> HCD core by setting this quirk.
> > > > >>>>>>>
> > > > >>>>>>> Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > > >>>>>>> ---
> > > > >>>>>>>   drivers/usb/dwc3/host.c | 13 +++++++++++++
> > > > >>>>>>>   1 file changed, 13 insertions(+)
> > > > >>>>>>>
> > > > >>>>>>> diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > > > >>>>>>> index eda8719..d4fcf06 100644
> > > > >>>>>>> --- a/drivers/usb/dwc3/host.c
> > > > >>>>>>> +++ b/drivers/usb/dwc3/host.c
> > > > >>>>>>> @@ -13,6 +13,12 @@
> > > > >>>>>>>   #include <linux/platform_device.h>
> > > > >>>>>>>     #include "core.h"
> > > > >>>>>>> +#include <linux/usb/xhci-plat.h>
> > > > >>>>>>> +#include <linux/usb/xhci-quirks.h>
> > > > >>>>>>> +
> > > > >>>>>>> +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
> > > > >>>>>>> +    .quirks = XHCI_SKIP_PHY_INIT,
> > > > >>>>>>> +};
> > > > >>>>>>>     static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
> > > > >>>>>>>                       int irq, char *name)
> > > > >>>>>>> @@ -122,6 +128,13 @@ int dwc3_host_init(struct dwc3 *dwc)
> > > > >>>>>>>           }
> > > > >>>>>>>       }
> > > > >>>>>>>   +    ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
> > > > >>>>>>> +            sizeof(xhci_plat_dwc3_xhci));
> > > > >>>>>>> +    if (ret) {
> > > > >>>>>>> +        dev_err(dwc->dev, "failed to add data to xHCI\n");
> > > > >>>>>>> +        goto err;
> > > > >>>>>>> +    }
> > > > >>>>>>> +
> > > > >>>>>>>       ret = platform_device_add(xhci);
> > > > >>>>>>>       if (ret) {
> > > > >>>>>>>           dev_err(dwc->dev, "failed to register xHCI device\n");
> > > > >>>>>> I think you should just use device property:
> > > > >>>>>>
> > > > >>>>> This was suggested in an earlier series, but was rejected as it also added
> > > > >>>>> the property as a device tree parameter.
> > > > >>>>>
> > > > >>>>> I think adding more device properties can be messy in the long run, especially if we
> > > > >>>>> need to add them for many of the existing xhci quirks.
> > > > >>>>> We also end up with a mix where some device properties are listed as device tree
> > > > >>>>> parameters, and some not.
> > > > >>>>>
> > > > >>>>> Defining xhci quirks and platform data structure in headers shared with dwc3 and cdns3
> > > > >>>>> allow those drivers to easily set any existing xhci quirk, or other possible optional
> > > > >>>>> callbacks.
> > > > >>>>>
> > > > >>>>> cdns3 driver is already doing this, but it includes the full xhci.h header.
> > > > >>>>> This series cleans up that a bit so cdns3 will only include xhci quirk bits and
> > > > >>>>> platform data structure.
> > > > >>>>>
> > > > >>>>> On the downside we add a couple xhci related header files to include/linux/usb/
> > > > >>>>> Let me know if you see any other issues I missed with this approach.
> > > > >>>> The problem here is that these drivers are now coupled together, and
> > > > >>>> that should not be taken lightly. We have a dependency hell in our
> > > > >>>> hands with a lot of drivers, and the culprit is always platform data.
> > > > >>>>
> > > > >>>> Build-in device properties may be messy, but I would still say they
> > > > >>>> are less messy than those quirk flags - you got to admit, they are a
> > > > >>>> mess. The benefit from build-in properties is in any case the fact
> > > > >>>> that they remove the need to couple these drivers together.
> > > > >>> Agree, quirk bits are messy. Any suggestion that would work with
> > > > >>> PCI xHCI devices, devicetree, and "pure" platform devices?
> > > > >> I think xHCI driver should always be able to rely on being able to
> > > > >> read this kind of information from the fwnode. If there is no actual
> > > > >> firmware node (DT or ACPI), or if it's missing some information, the
> > > > >> glue driver needs to populate software node for the xHCI.
> > > > >>
> > > > >> Right now I just want to avoid having to pass the quirks using
> > > > >> platform data from drivers such as drivers/usb/cdns3/host.c and
> > > > >> drivers/usb/dwc3/host.c to xHCI.
> > > > >>
> > > > >> One way we could do that is by defining compatibility ID for both of
> > > > >> them that we provide using a single device property (like I guess DT
> > > > >> does). Then based on that compatibility ID, xhci-plat.c can set the
> > > > >> actual "static" quirk flags. That we could already do easily. How
> > > > >> would that sound to you?
> > > > 
> > > > Sounds good. 
> > > > 
> > > > > 
> > > > > This was my previous patch where I was using device tree property. Should we go ahead with this approach?
> > > > > 
> > > > > https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-25582-1-git-send-email-quic_c_sanm@quicinc.com/
> > > > > 
> > > > > Any further changes to this ?
> > > > 
> > > > By dropping the DT part of that series we get a similar built-in device property
> > > > solution as Heikki initially suggested.
> > > > 
> > > > How about adding the compatibility ID device property that was just suggested?
> > > > Then matching the Id in xhci-plat.c against a static table containing Ids and
> > > > xhci_plat_priv structures, with the needed quirks for dwc3.
> > > 
> > > There was a comment from Pavan. Is it still possible to get this
> > > detail from DT?
> > > I guess that would still be ideal, right?
> > > 
> > I was suggesting if we can have device tree param like the patch sandeep
> > pointed out.
> > 
> > How would adding a compatible index to usb_xhci_of_match[] would work
> > actually? I ask this because, dwc3/host.c creates platform device and
> > it is not associated with any of_node, so of_driver_match_device() called
> > from platform bus match method does not work. one way to achieve this would
> > be by matching against sysdev. Something like below. Is it acceptible?
> > 
> > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > index 649ffd8..bd5d055 100644
> > --- a/drivers/usb/host/xhci-plat.c
> > +++ b/drivers/usb/host/xhci-plat.c
> > @@ -126,6 +126,10 @@ static const struct xhci_plat_priv xhci_plat_brcm = {
> >  	.quirks = XHCI_RESET_ON_RESUME,
> >  };
> >  
> > +static const struct xhci_plat_priv xhci_plat_dwc3 = {
> > +	.quirks = XHCI_SKIP_PHY_INIT,
> > +};
> > +
> >  static const struct of_device_id usb_xhci_of_match[] = {
> >  	{
> >  		.compatible = "generic-xhci",
> > @@ -167,6 +171,9 @@ static const struct of_device_id usb_xhci_of_match[] = {
> >  	}, {
> >  		.compatible = "brcm,bcm7445-xhci",
> >  		.data = &xhci_plat_brcm,
> > +	}, {
> > +		.compatible = "snps,dwc3",
> > +		.data = &xhci_plat_dwc3,
> >  	},
> >  	{},
> >  };
> > @@ -274,6 +281,15 @@ static int xhci_plat_probe(struct platform_device *pdev)
> >  	else
> >  		priv_match = dev_get_platdata(&pdev->dev);
> >  
> > +	/* allow private data mapping with the sysdev compatible */
> > +	if (!priv_match) {
> > +		struct of_device_id *match;
> > +
> > +		match = of_match_device(usb_xhci_of_match, sysdev);
> > +		if (match)
> > +			priv_match = match->data;
> > +	}
> > +
> >  	if (priv_match) {
> >  		priv = hcd_to_xhci_priv(hcd);
> >  		/* Just copy data for now */
> > 
> > > I have another question. Can't we now just assume that if the sysdev
> > > is the parent (or grandparent), then the phy initialization should
> > > always be skipped? In that case we could just do something like this:
> > > 
> > > diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
> > > index 649ffd861b44e..1018b33488046 100644
> > > --- a/drivers/usb/host/xhci-plat.c
> > > +++ b/drivers/usb/host/xhci-plat.c
> > > @@ -212,8 +212,12 @@ static int xhci_plat_probe(struct platform_device *pdev)
> > >  #endif
> > >         }
> > >  
> > > -       if (!sysdev)
> > > +       if (sysdev) {
> > > +               if (sysdev != &pdev->dev)
> > > +                       hcd->skip_phy_initialization = 1;
> > > +       } else {
> > >                 sysdev = &pdev->dev;
> > > +       }
> > >  
> > >         if (WARN_ON(!sysdev->dma_mask))
> > >                 /* Platform did not initialize dma_mask */
> > > 
> > > 
> > > I did not go through all the drivers that carefully, so I may have
> > > missed something, but it looks like the only drivers that can have the
> > > sysdev as the parent or grandparent are cdns3 and dwc3.
> > > 
> > I cross checked and these are two drivers that are creating xhci-plat device.
> > So this patch would definitely work. However I am not sure in future if any
> > device created via device tree would want to use this feature. For now,
> > it looks good. It Mathias, Do you see any problem with this approach?
> > 
> 
> Can you please provide your suggestions on this? We have discussed about
> 3 approaches here other than the whole platform data refactoring done.
> 
> (1) Introduce a new dT property and expect dwc3/host.c to set this property
> to skip the phy initialization.
> (2) Allow platform private data match based on the sysdev. The diff I sent
> in the previous email.
> (3) Heikki's suggestion of relying on the fact that the users of phy skip
> init can be tested with sysdev != &pdev->dev check.

My vote is for option 3. That would allow us to sort this out properly
later. I will in any case look at these drivers when I send the
software node PM operations patch series.

thanks,

-- 
heikki
