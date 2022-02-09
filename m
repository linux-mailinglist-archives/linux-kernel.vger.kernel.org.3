Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D884AE99B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 06:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbiBIF4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 00:56:52 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbiBIFyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 00:54:10 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7321BC001F62;
        Tue,  8 Feb 2022 21:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644386051; x=1675922051;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=nMU9hhVuD0UKbbB3+cdpNgdQzdxARgy1cblO3m86d/s=;
  b=PDuEHwCxZoLhElcMeGu26FONcE/Bceuv/6S4UuTosFDDhAhgrFQxLqQm
   okZpMwGznw3nhWX1sYkyeYEtWehyuM9l7raJgv+UJ/077zX8vMslHmH31
   Poze7glRsCvuPqvq+1KYA1bPl0UWr+27UJrUEus6OjhCiacbnmYiVVlEV
   Y=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 08 Feb 2022 21:54:10 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2022 21:54:02 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 21:54:00 -0800
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 8 Feb 2022 21:53:56 -0800
Date:   Wed, 9 Feb 2022 11:23:52 +0530
From:   Pavan Kondeti <quic_pkondeti@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>
Subject: Re: [PATCH v5] usb: host: xhci-plat: Set XHCI_SKIP_PHY_INIT quirk
 for DWC3 controller
Message-ID: <20220209055352.GA22550@hu-pkondeti-hyd.qualcomm.com>
References: <1640153383-21036-1-git-send-email-quic_c_sanm@quicinc.com>
 <Ydb79/twbxLDJB8/@kroah.com>
 <d17330f1-d85e-b8c2-9e87-10d109c25abb@quicinc.com>
 <YfE9s06CIv1P3bA/@kroah.com>
 <f45f5952-e31c-5e9d-2560-064199beb29f@quicinc.com>
 <ca306d7c-d816-3cbd-8c65-2c3619739d47@quicinc.com>
 <YgJB6bGm/y7C0oo/@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zYM0uCDKw75PZbzx"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YgJB6bGm/y7C0oo/@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Feb 08, 2022 at 11:11:53AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 08, 2022 at 03:34:22PM +0530, Sandeep Maheswaram wrote:
> > Hi Greg,
> > 
> > On 1/27/2022 10:28 AM, Sandeep Maheswaram wrote:
> > > 
> > > On 1/26/2022 5:55 PM, Greg Kroah-Hartman wrote:
> > > > On Fri, Jan 07, 2022 at 10:27:59AM +0530, Sandeep Maheswaram wrote:
> > > > > On 1/6/2022 7:55 PM, Greg Kroah-Hartman wrote:
> > > > > > On Wed, Dec 22, 2021 at 11:39:43AM +0530, Sandeep Maheswaram wrote:
> > > > > > > Set XHCI_SKIP_PHY_INIT quirk to avoid phy initialization twice.
> > > > > > > Runtime suspend of phy drivers was failing from DWC3
> > > > > > > driver as runtime
> > > > > > > usage value is 2 because the phy is initialized from
> > > > > > > DWC3 and HCD core.
> > > > > > > DWC3 manages phy in their core drivers. Set this quirk to avoid phy
> > > > > > > initialization in HCD core.
> > > > > > > 
> > > > > > > Signed-off-by: Sandeep Maheswaram <quic_c_sanm@quicinc.com>
> > > > > > > ---
> > > > > > > v5:
> > > > > > > Added comment to explain the change done.
> > > > > > > v4:
> > > > > > > Changed pdev->dev.parent->of_node to sysdev->of_node
> > > > > > > 
> > > > > > >    drivers/usb/host/xhci-plat.c | 8 ++++++++
> > > > > > >    1 file changed, 8 insertions(+)
> > > > > > > 
> > > > > > > diff --git a/drivers/usb/host/xhci-plat.c
> > > > > > > b/drivers/usb/host/xhci-plat.c
> > > > > > > index c1edcc9..e6014d4 100644
> > > > > > > --- a/drivers/usb/host/xhci-plat.c
> > > > > > > +++ b/drivers/usb/host/xhci-plat.c
> > > > > > > @@ -327,6 +327,14 @@ static int xhci_plat_probe(struct
> > > > > > > platform_device *pdev)
> > > > > > >                         &xhci->imod_interval);
> > > > > > >        }
> > > > > > > +    /*
> > > > > > > +     * Set XHCI_SKIP_PHY_INIT quirk to avoid phy
> > > > > > > initialization twice.
> > > > > > > +     * DWC3 manages phy in their core drivers. Set this
> > > > > > > quirk to avoid phy
> > > > > > > +     * initialization in HCD core.
> > > > > > > +     */
> > > > > > > +    if (of_device_is_compatible(sysdev->of_node, "snps,dwc3"))
> > > > > > > +        xhci->quirks |= XHCI_SKIP_PHY_INIT;
> > > > > > > +
> > > > > > Why is this function caring about dwc3 stuff?  Shoudn't this be a
> > > > > > "generic" device property instead of this device-specific one?
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > This quirk is set only if required for some controllers (eg:
> > > > > dwc3 & cdns3).
> > > > > 
> > > > > Please check below commit.
> > > > > 
> > > > > https://lore.kernel.org/all/20200918131752.16488-5-mathias.nyman@linux.intel.com/
> > > > > 
> > > > That commit has nothing to do with a specific "dwc3" quirk anywhere.
> > > > Why not set this flag in the specific platform xhci driver instead where
> > > > it belongs?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > There is no specific xhci platform driver for dwc3 controllers.
> > > 
> > > dwc3 controllers use xhci-plat driver .
> > > 
> > > We can add this quirk in usb/dwc3/host.c as cdns3 does but that requires
> > > tying dwc3 and xhci driver .
> > > 
> > > https://patchwork.kernel.org/project/linux-arm-msm/patch/1633946518-13906-1-git-send-email-sanm@codeaurora.org/
> > > 
> > > 
> > > Regards
> > > 
> > > Sandeep
> > > 
> > > 
> > Can you suggest any other method to set this quirk for dwc3 controllers.
> 
> No idea, sorry.

Sandeep,

I agree with Greg's comments here. The compatible based check to detect dwc3
controller is not elegant. Your proposal of adding a device tree param is
overkill, I believe.

Greg already gave us a pointer here [1] which I feel is the best approach going
forward. We know that xhci-plat is being used by drivers like dwc3, cdns3 and
these drivers need to expose their xhci quirks. As Greg suggested, why can't
we move xhci quirks definition to include/linux/usb/xhci-quriks.h and directly
access from the glue drivers? The attached is the patch (completely untested)
for your reference. It will prepare the setup for you to add the private data
and quirks in the dwc3 host glue driver.

Thanks,
Pavan

[1]
https://patchwork.kernel.org/project/linux-arm-msm/patch/1633946518-13906-1-git-send-email-sanm@codeaurora.org/



--zYM0uCDKw75PZbzx
Content-Type: text/x-diff; charset="us-ascii"
Content-Disposition: attachment;
	filename="0001-usb-xhci-refactor-quirks-and-plat-private-data.patch"

From 59d674ad513a647254d9f0f74b3b58546f9536d3 Mon Sep 17 00:00:00 2001
From: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
Date: Wed, 9 Feb 2022 11:14:08 +0530
Subject: [PATCH] usb: xhci: refactor quirks and plat private data

This refactoring allows drivers like dwc3 host glue driver to
specify thier xhci quirks.

Change-Id: Ia9f6347c3e752d8f75bdeafb914d335629a26900
Signed-off-by: Pavankumar Kondeti <quic_pkondeti@quicinc.com>
---
 drivers/usb/cdns3/host.c                           |  2 +-
 drivers/usb/host/xhci-plat.c                       |  3 +-
 drivers/usb/host/xhci-rcar.c                       |  3 +-
 drivers/usb/host/xhci.h                            | 60 ++-----------------
 .../usb/host => include/linux/usb}/xhci-plat.h     |  5 +-
 include/linux/usb/xhci-quirks.h                    | 67 ++++++++++++++++++++++
 6 files changed, 80 insertions(+), 60 deletions(-)
 rename {drivers/usb/host => include/linux/usb}/xhci-plat.h (74%)
 create mode 100644 include/linux/usb/xhci-quirks.h

diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
index 84dadfa..02634d9 100644
--- a/drivers/usb/cdns3/host.c
+++ b/drivers/usb/cdns3/host.c
@@ -14,8 +14,8 @@
 #include "drd.h"
 #include "host-export.h"
 #include <linux/usb/hcd.h>
+#include <linux/usb/xhci-plat.h>
 #include "../host/xhci.h"
-#include "../host/xhci-plat.h"
 
 #define XECP_PORT_CAP_REG	0x8000
 #define XECP_AUX_CTRL_REG1	0x8120
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index c1edcc9..23e0de0 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -19,9 +19,10 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/usb/of.h>
+#include <linux/usb/xhci-quirks.h>
+#include <linux/usb/xhci-plat.h>
 
 #include "xhci.h"
-#include "xhci-plat.h"
 #include "xhci-mvebu.h"
 #include "xhci-rcar.h"
 
diff --git a/drivers/usb/host/xhci-rcar.c b/drivers/usb/host/xhci-rcar.c
index 9888ba7..cbcb6ba 100644
--- a/drivers/usb/host/xhci-rcar.c
+++ b/drivers/usb/host/xhci-rcar.c
@@ -12,9 +12,10 @@
 #include <linux/of.h>
 #include <linux/usb/phy.h>
 #include <linux/sys_soc.h>
+#include <linux/usb/xhci-quirks.h>
+#include <linux/usb/xhci-plat.h>
 
 #include "xhci.h"
-#include "xhci-plat.h"
 #include "xhci-rcar.h"
 
 /*
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 5a75fe5..4e80d08 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -17,6 +17,8 @@
 #include <linux/kernel.h>
 #include <linux/usb/hcd.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/usb/xhci-quirks.h>
+#include <linux/usb/xhci-plat.h>
 
 /* Code sharing between pci-quirks and xhci hcd */
 #include	"xhci-ext-caps.h"
@@ -1846,60 +1848,6 @@ struct xhci_hcd {
 #define XHCI_STATE_HALTED	(1 << 1)
 #define XHCI_STATE_REMOVING	(1 << 2)
 	unsigned long long	quirks;
-#define	XHCI_LINK_TRB_QUIRK	BIT_ULL(0)
-#define XHCI_RESET_EP_QUIRK	BIT_ULL(1)
-#define XHCI_NEC_HOST		BIT_ULL(2)
-#define XHCI_AMD_PLL_FIX	BIT_ULL(3)
-#define XHCI_SPURIOUS_SUCCESS	BIT_ULL(4)
-/*
- * Certain Intel host controllers have a limit to the number of endpoint
- * contexts they can handle.  Ideally, they would signal that they can't handle
- * anymore endpoint contexts by returning a Resource Error for the Configure
- * Endpoint command, but they don't.  Instead they expect software to keep track
- * of the number of active endpoints for them, across configure endpoint
- * commands, reset device commands, disable slot commands, and address device
- * commands.
- */
-#define XHCI_EP_LIMIT_QUIRK	BIT_ULL(5)
-#define XHCI_BROKEN_MSI		BIT_ULL(6)
-#define XHCI_RESET_ON_RESUME	BIT_ULL(7)
-#define	XHCI_SW_BW_CHECKING	BIT_ULL(8)
-#define XHCI_AMD_0x96_HOST	BIT_ULL(9)
-#define XHCI_TRUST_TX_LENGTH	BIT_ULL(10)
-#define XHCI_LPM_SUPPORT	BIT_ULL(11)
-#define XHCI_INTEL_HOST		BIT_ULL(12)
-#define XHCI_SPURIOUS_REBOOT	BIT_ULL(13)
-#define XHCI_COMP_MODE_QUIRK	BIT_ULL(14)
-#define XHCI_AVOID_BEI		BIT_ULL(15)
-#define XHCI_PLAT		BIT_ULL(16)
-#define XHCI_SLOW_SUSPEND	BIT_ULL(17)
-#define XHCI_SPURIOUS_WAKEUP	BIT_ULL(18)
-/* For controllers with a broken beyond repair streams implementation */
-#define XHCI_BROKEN_STREAMS	BIT_ULL(19)
-#define XHCI_PME_STUCK_QUIRK	BIT_ULL(20)
-#define XHCI_MTK_HOST		BIT_ULL(21)
-#define XHCI_SSIC_PORT_UNUSED	BIT_ULL(22)
-#define XHCI_NO_64BIT_SUPPORT	BIT_ULL(23)
-#define XHCI_MISSING_CAS	BIT_ULL(24)
-/* For controller with a broken Port Disable implementation */
-#define XHCI_BROKEN_PORT_PED	BIT_ULL(25)
-#define XHCI_LIMIT_ENDPOINT_INTERVAL_7	BIT_ULL(26)
-#define XHCI_U2_DISABLE_WAKE	BIT_ULL(27)
-#define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	BIT_ULL(28)
-#define XHCI_HW_LPM_DISABLE	BIT_ULL(29)
-#define XHCI_SUSPEND_DELAY	BIT_ULL(30)
-#define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
-#define XHCI_ZERO_64B_REGS	BIT_ULL(32)
-#define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
-#define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
-#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
-#define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
-#define XHCI_SKIP_PHY_INIT	BIT_ULL(37)
-#define XHCI_DISABLE_SPARSE	BIT_ULL(38)
-#define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
-#define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
-#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
-#define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
 
 	unsigned int		num_active_eps;
 	unsigned int		limit_active_eps;
@@ -1965,6 +1913,10 @@ static inline struct usb_hcd *xhci_to_hcd(struct xhci_hcd *xhci)
 	return xhci->main_hcd;
 }
 
+/* For xhci-plat drivers */
+#define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
+#define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
+
 #define xhci_dbg(xhci, fmt, args...) \
 	dev_dbg(xhci_to_hcd(xhci)->self.controller , fmt , ## args)
 #define xhci_err(xhci, fmt, args...) \
diff --git a/drivers/usb/host/xhci-plat.h b/include/linux/usb/xhci-plat.h
similarity index 74%
rename from drivers/usb/host/xhci-plat.h
rename to include/linux/usb/xhci-plat.h
index 561d0b7..0612258 100644
--- a/drivers/usb/host/xhci-plat.h
+++ b/include/linux/usb/xhci-plat.h
@@ -8,7 +8,8 @@
 #ifndef _XHCI_PLAT_H
 #define _XHCI_PLAT_H
 
-#include "xhci.h"	/* for hcd_to_xhci() */
+#include <linux/types.h>
+#include <linux/usb/hcd.h>
 
 struct xhci_plat_priv {
 	const char *firmware_name;
@@ -20,6 +21,4 @@ struct xhci_plat_priv {
 	int (*resume_quirk)(struct usb_hcd *);
 };
 
-#define hcd_to_xhci_priv(h) ((struct xhci_plat_priv *)hcd_to_xhci(h)->priv)
-#define xhci_to_priv(x) ((struct xhci_plat_priv *)(x)->priv)
 #endif	/* _XHCI_PLAT_H */
diff --git a/include/linux/usb/xhci-quirks.h b/include/linux/usb/xhci-quirks.h
new file mode 100644
index 00000000..57ae0b1
--- /dev/null
+++ b/include/linux/usb/xhci-quirks.h
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * xHCI host controller driver quirks
+ *
+ * Copyright (C) 2008 Intel Corp.
+ */
+
+#ifndef _XHCI_QUIRKS_H
+#define _XHCI_QUIRKS_H
+
+#define XHCI_LINK_TRB_QUIRK	BIT_ULL(0)
+#define XHCI_RESET_EP_QUIRK	BIT_ULL(1)
+#define XHCI_NEC_HOST		BIT_ULL(2)
+#define XHCI_AMD_PLL_FIX	BIT_ULL(3)
+#define XHCI_SPURIOUS_SUCCESS	BIT_ULL(4)
+/*
+ * Certain Intel host controllers have a limit to the number of endpoint
+ * contexts they can handle.  Ideally, they would signal that they can't handle
+ * anymore endpoint contexts by returning a Resource Error for the Configure
+ * Endpoint command, but they don't.  Instead they expect software to keep track
+ * of the number of active endpoints for them, across configure endpoint
+ * commands, reset device commands, disable slot commands, and address device
+ * commands.
+ */
+#define XHCI_EP_LIMIT_QUIRK	BIT_ULL(5)
+#define XHCI_BROKEN_MSI		BIT_ULL(6)
+#define XHCI_RESET_ON_RESUME	BIT_ULL(7)
+#define XHCI_SW_BW_CHECKING	BIT_ULL(8)
+#define XHCI_AMD_0x96_HOST	BIT_ULL(9)
+#define XHCI_TRUST_TX_LENGTH	BIT_ULL(10)
+#define XHCI_LPM_SUPPORT	BIT_ULL(11)
+#define XHCI_INTEL_HOST		BIT_ULL(12)
+#define XHCI_SPURIOUS_REBOOT	BIT_ULL(13)
+#define XHCI_COMP_MODE_QUIRK	BIT_ULL(14)
+#define XHCI_AVOID_BEI		BIT_ULL(15)
+#define XHCI_PLAT		BIT_ULL(16)
+#define XHCI_SLOW_SUSPEND	BIT_ULL(17)
+#define XHCI_SPURIOUS_WAKEUP	BIT_ULL(18)
+/* For controllers with a broken beyond repair streams implementation */
+#define XHCI_BROKEN_STREAMS	BIT_ULL(19)
+#define XHCI_PME_STUCK_QUIRK	BIT_ULL(20)
+#define XHCI_MTK_HOST		BIT_ULL(21)
+#define XHCI_SSIC_PORT_UNUSED	BIT_ULL(22)
+#define XHCI_NO_64BIT_SUPPORT	BIT_ULL(23)
+#define XHCI_MISSING_CAS	BIT_ULL(24)
+/* For controller with a broken Port Disable implementation */
+#define XHCI_BROKEN_PORT_PED	BIT_ULL(25)
+#define XHCI_LIMIT_ENDPOINT_INTERVAL_7	BIT_ULL(26)
+#define XHCI_U2_DISABLE_WAKE	BIT_ULL(27)
+#define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	BIT_ULL(28)
+#define XHCI_HW_LPM_DISABLE	BIT_ULL(29)
+#define XHCI_SUSPEND_DELAY	BIT_ULL(30)
+#define XHCI_INTEL_USB_ROLE_SW	BIT_ULL(31)
+#define XHCI_ZERO_64B_REGS	BIT_ULL(32)
+#define XHCI_DEFAULT_PM_RUNTIME_ALLOW	BIT_ULL(33)
+#define XHCI_RESET_PLL_ON_DISCONNECT	BIT_ULL(34)
+#define XHCI_SNPS_BROKEN_SUSPEND    BIT_ULL(35)
+#define XHCI_RENESAS_FW_QUIRK	BIT_ULL(36)
+#define XHCI_SKIP_PHY_INIT	BIT_ULL(37)
+#define XHCI_DISABLE_SPARSE	BIT_ULL(38)
+#define XHCI_SG_TRB_CACHE_SIZE_QUIRK	BIT_ULL(39)
+#define XHCI_NO_SOFT_RETRY	BIT_ULL(40)
+#define XHCI_BROKEN_D3COLD	BIT_ULL(41)
+#define XHCI_EP_CTX_BROKEN_DCS	BIT_ULL(42)
+
+#endif /* _XHCI_QUIRKS_H */
-- 
2.7.4


--zYM0uCDKw75PZbzx--
