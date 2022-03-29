Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5867B4EAA93
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 11:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbiC2Jay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 05:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiC2Jaw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 05:30:52 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0177EEF7B7;
        Tue, 29 Mar 2022 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648546150; x=1680082150;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/6KMD7x5IdWCSeuDi2cNHClnlamv+e+Da8kYwSzDITE=;
  b=zHUoEvw+2Pfchj13Ms2EoVhPNDmxkW9QsqL7hD3nIkYRr9XTmvP4rxYq
   5oJ3ZcQsShn+Wdj9oXdxtu21XNY6J9MVBkbelByukZtHAuQ1YhRvz83ky
   5cYn7CVcpMNO3YX3WIuK/GfvOyEP966wGQK5WXXwbfa2Z9g+1qGvHRn/9
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 29 Mar 2022 02:29:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 02:29:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 02:29:08 -0700
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 02:29:03 -0700
Date:   Tue, 29 Mar 2022 14:58:59 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     "Sandeep Maheswaram (Temp)" <quic_c_sanm@quicinc.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "Peter Chen" <peter.chen@kernel.org>,
        Pawel Laszczak <pawell@cadence.com>,
        "Roger Quadros" <rogerq@kernel.org>,
        Aswath Govindraju <a-govindraju@ti.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
Subject: Re: [PATCH v3 3/3] usb: dwc: host: add xhci_plat_priv quirk
 XHCI_SKIP_PHY_INIT
Message-ID: <20220329092859.GA32726@hu-pkondeti-hyd.qualcomm.com>
References: <1648103831-12347-1-git-send-email-quic_c_sanm@quicinc.com>
 <1648103831-12347-4-git-send-email-quic_c_sanm@quicinc.com>
 <YjxjxplpOpDC2JLs@kuha.fi.intel.com>
 <4c2a28ad-b866-1b65-e73a-4eda0596cea2@linux.intel.com>
 <Yj2nPa6/Y01P5aCY@kuha.fi.intel.com>
 <4619c75c-cd34-82f2-56e1-a8bcb6d97177@linux.intel.com>
 <Yj3h4p/kmZTvMz0O@kuha.fi.intel.com>
 <fae54b27-9ae2-ecfc-69ae-40e5f5e1afbe@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <fae54b27-9ae2-ecfc-69ae-40e5f5e1afbe@quicinc.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 02:48:05PM +0530, Sandeep Maheswaram (Temp) wrote:
> Hi Mathias,Heikki
> 
> On 3/25/2022 9:08 PM, Heikki Krogerus wrote:
> >On Fri, Mar 25, 2022 at 04:33:27PM +0200, Mathias Nyman wrote:
> >>On 25.3.2022 13.27, Heikki Krogerus wrote:
> >>>On Fri, Mar 25, 2022 at 12:36:22AM +0200, Mathias Nyman wrote:
> >>>>On 24.3.2022 14.27, Heikki Krogerus wrote:
> >>>>>On Thu, Mar 24, 2022 at 12:07:11PM +0530, Sandeep Maheswaram wrote:
> >>>>>>Currently the phy init is done from dwc3 and also xhci which makes the
> >>>>>>runtime_usage value 2 for the phy which causes issue during runtime
> >>>>>>suspend. When we run the below command the runtime_status still shows
> >>>>>>active.
> >>>>>>echo auto > /sys/bus/platform/devices/88e3000.phy/power/control
> >>>>>>
> >>>>>>dwc3 manages PHY by own DRD driver, so skip the management by
> >>>>>>HCD core by setting this quirk.
> >>>>>>
> >>>>>>Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> >>>>>>---
> >>>>>>  drivers/usb/dwc3/host.c | 13 +++++++++++++
> >>>>>>  1 file changed, 13 insertions(+)
> >>>>>>
> >>>>>>diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
> >>>>>>index eda8719..d4fcf06 100644
> >>>>>>--- a/drivers/usb/dwc3/host.c
> >>>>>>+++ b/drivers/usb/dwc3/host.c
> >>>>>>@@ -13,6 +13,12 @@
> >>>>>>  #include <linux/platform_device.h>
> >>>>>>  #include "core.h"
> >>>>>>+#include <linux/usb/xhci-plat.h>
> >>>>>>+#include <linux/usb/xhci-quirks.h>
> >>>>>>+
> >>>>>>+static const struct xhci_plat_priv xhci_plat_dwc3_xhci = {
> >>>>>>+	.quirks = XHCI_SKIP_PHY_INIT,
> >>>>>>+};
> >>>>>>  static void dwc3_host_fill_xhci_irq_res(struct dwc3 *dwc,
> >>>>>>  					int irq, char *name)
> >>>>>>@@ -122,6 +128,13 @@ int dwc3_host_init(struct dwc3 *dwc)
> >>>>>>  		}
> >>>>>>  	}
> >>>>>>+	ret = platform_device_add_data(xhci, &xhci_plat_dwc3_xhci,
> >>>>>>+			sizeof(xhci_plat_dwc3_xhci));
> >>>>>>+	if (ret) {
> >>>>>>+		dev_err(dwc->dev, "failed to add data to xHCI\n");
> >>>>>>+		goto err;
> >>>>>>+	}
> >>>>>>+
> >>>>>>  	ret = platform_device_add(xhci);
> >>>>>>  	if (ret) {
> >>>>>>  		dev_err(dwc->dev, "failed to register xHCI device\n");
> >>>>>I think you should just use device property:
> >>>>>
> >>>>This was suggested in an earlier series, but was rejected as it also added
> >>>>the property as a device tree parameter.
> >>>>
> >>>>I think adding more device properties can be messy in the long run, especially if we
> >>>>need to add them for many of the existing xhci quirks.
> >>>>We also end up with a mix where some device properties are listed as device tree
> >>>>parameters, and some not.
> >>>>
> >>>>Defining xhci quirks and platform data structure in headers shared with dwc3 and cdns3
> >>>>allow those drivers to easily set any existing xhci quirk, or other possible optional
> >>>>callbacks.
> >>>>
> >>>>cdns3 driver is already doing this, but it includes the full xhci.h header.
> >>>>This series cleans up that a bit so cdns3 will only include xhci quirk bits and
> >>>>platform data structure.
> >>>>
> >>>>On the downside we add a couple xhci related header files to include/linux/usb/
> >>>>Let me know if you see any other issues I missed with this approach.
> >>>The problem here is that these drivers are now coupled together, and
> >>>that should not be taken lightly. We have a dependency hell in our
> >>>hands with a lot of drivers, and the culprit is always platform data.
> >>>
> >>>Build-in device properties may be messy, but I would still say they
> >>>are less messy than those quirk flags - you got to admit, they are a
> >>>mess. The benefit from build-in properties is in any case the fact
> >>>that they remove the need to couple these drivers together.
> >>Agree, quirk bits are messy. Any suggestion that would work with
> >>PCI xHCI devices, devicetree, and "pure" platform devices?
> >I think xHCI driver should always be able to rely on being able to
> >read this kind of information from the fwnode. If there is no actual
> >firmware node (DT or ACPI), or if it's missing some information, the
> >glue driver needs to populate software node for the xHCI.
> >
> >Right now I just want to avoid having to pass the quirks using
> >platform data from drivers such as drivers/usb/cdns3/host.c and
> >drivers/usb/dwc3/host.c to xHCI.
> >
> >One way we could do that is by defining compatibility ID for both of
> >them that we provide using a single device property (like I guess DT
> >does). Then based on that compatibility ID, xhci-plat.c can set the
> >actual "static" quirk flags. That we could already do easily. How
> >would that sound to you?
> 
> This was my previous patch where I was using device tree property. Should we
> go ahead with this approach?
> 
> https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-25582-1-git-send-email-quic_c_sanm@quicinc.com/
> 
> Any further changes to this ?
> 

Actually the dT idea looks better than the platform data. Earlier, we decided
to use if (of_device_is_compatible(dev->parent->of_node, "snps,dwc3")) check
but I feel that we should just introduce a device tree param that specify
this functionality (skipping phy init). we don't want xhci-plat to know that
this is dwc3/xyz device. we expect it to be abstracted.

Thanks,
Pavan
