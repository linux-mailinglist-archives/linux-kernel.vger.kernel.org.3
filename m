Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45BBD4B838D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbiBPI64 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 03:58:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiBPI6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 03:58:54 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B0D82ABD1F;
        Wed, 16 Feb 2022 00:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645001922; x=1676537922;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4y71aus8Ob7SpkYYykXhuO5i7j3UaPqtGgLoekb6pW8=;
  b=FnKSofJjr8nx6/ik2wBUPfPdtszWqWhUMBl/WIGpvXgXEMIvSqosb5h5
   y900Rb91wV6E5GW/sWjmgVIq4kEdeTtzGeRkFalq4pF3rbIgMDfXx8Xzv
   FEihIu8OBwgKubSlK/U5IdAqo8eMJFV8dpU+kx6EwFH9Zwr1YXpfepCnF
   8=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 16 Feb 2022 00:58:41 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 00:58:41 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 00:58:41 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 00:58:35 -0800
Date:   Wed, 16 Feb 2022 14:28:31 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Jun Li <lijun.kernel@gmail.com>
CC:     Pavan Kondeti <quic_pkondeti@quicinc.com>, Li Jun <jun.li@nxp.com>,
        Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Peter Chen <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Roger Quadros <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-arm-msm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>
Subject: Re: [PATCH 2/2] usb: dwc: host: add xhci_plat_priv quirk
 XHCI_SKIP_PHY_INIT
Message-ID: <20220216085831.GA15957@hu-pkondeti-hyd.qualcomm.com>
References: <1644949454-814-1-git-send-email-quic_c_sanm@quicinc.com>
 <1644949454-814-3-git-send-email-quic_c_sanm@quicinc.com>
 <CAKgpwJWEZ7275LihHqxg50cWNVNxUcGR8e7pM-V2bH=aodL7YA@mail.gmail.com>
 <20220216080028.GA13793@hu-pkondeti-hyd.qualcomm.com>
 <CAKgpwJVwTDd40ZR3tKOgVpRTNs1OjE5ssMM+Lj-Ak0CHPSAWQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKgpwJVwTDd40ZR3tKOgVpRTNs1OjE5ssMM+Lj-Ak0CHPSAWQQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 04:49:32PM +0800, Jun Li wrote:
> Pavan Kondeti <quic_pkondeti@quicinc.com> 于2022年2月16日周三 16:00写道：
> >
> > On Wed, Feb 16, 2022 at 03:16:40PM +0800, Jun Li wrote:
> > > Sandeep Maheswaram <quic_c_sanm@quicinc.com> 于2022年2月16日周三 14:58写道：
> > > >
> > > > dwc3 manages PHY by own DRD driver, so skip the management by
> > > > HCD core.
> > > > During runtime suspend phy was not getting suspend because
> > > > runtime_usage value is 2.
> > > >
> > > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > > ---
> > > >  drivers/usb/dwc3/host.c | 15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >
> > > > diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> > > > index eda8719..4a035a8 100644
> > > > --- a/drivers/usb/dwc3/host.c
> > > > +++ b/drivers/usb/dwc3/host.c
> > > > @@ -13,6 +13,14 @@
> > > >  #include <linux/platform_device.h>
> > > >
> > > >  #include "core.h"
> > > > +#include <linux/usb/hcd.h>
> > > > +#include <linux/usb/xhci-plat.h>
> > > > +#include <linux/usb/xhci-quirks.h>
> > > > +
> > > > +
> > > > +static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
> > > > +       .quirks = XHCI_SKIP_PHY_INIT,
> > > > +};
> > >
> > > It's better to create this xhci_plat_priv by each dwc3 glue layer,
> > > with that, we can use this priv to pass other flags and possibly
> > > override APIs by each glue driver which may not apply to all dwc3
> > > platforms.
> > >
> >
> > Do you see a need for any glue driver to know about this xHC platform data?
> 
> Yes. I have some xhci quirks which are specifix to NXP iMX platforms.
> 
> > AFAICT, glue driver has no direction connection with the dwc3 core. All
> > the required data is coming from dT on ARM based boards. Adding a private
> > interface between dwc3 core and glue for passing xhci platform data seems
> > to be overkill. If there is a pressing need, why not?
> 
> And looking at xhci_plat_priv members
> 
> -struct xhci_plat_priv {
> -       const char *firmware_name;
> -       unsigned long long quirks;
> -       int (*plat_setup)(struct usb_hcd *);
> -       void (*plat_start)(struct usb_hcd *);
> -       int (*init_quirk)(struct usb_hcd *);
> -       int (*suspend_quirk)(struct usb_hcd *);
> -       int (*resume_quirk)(struct usb_hcd *);
> -};
> 
> Are we going to share the same all those quirks and APIs
> implementation across all dwc3 platforms?
> 
Currently Yes. Thats why I am asking if there is a pressing need to
make this more complex than it needs to be..

Thanks,
Pavan
