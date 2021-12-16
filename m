Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05D47712A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhLPL4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:56:07 -0500
Received: from cpanel.siel.si ([46.19.9.99]:36686 "EHLO cpanel.siel.si"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhLPL4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:56:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
        s=default; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KVRmAD9FlVOEDBVZnzgzFws+L1j5LpO7FvkCdPb2RUQ=; b=KVO2S2OGiE9XhA3xpKCAq6Mso5
        T3/g7Ob4Tvfk7rrWWG6P9VHt9uanTPGJEDMjLPO1kGuTVLfuvZPwb7u7ctleCGPCJAkSNg2qj4keV
        edam6lu8rVcNJLMEK9bxyqEsjdjWteXwlAH8V4VCVV+zkFuwQAwsoXO+fDiIpeig0WiJ+VFmvfsjm
        X9TFxjWpHlLdJqJLcVm9aw/v7ZrB5z9baNsjFwrCelTzkTz5By8sfkydp2vBGf5OtgRJr8Qf7FuUY
        mVcPRNQQQ4NStixQ5KaCMZ/14xRvo4j1tGfodd1DjcEhnEyd8KuJBKP5n99o6MUVmsYNwRc6nTcnf
        RVQvTXwA==;
Received: from [89.212.21.243] (port=49574 helo=localhost.localdomain)
        by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <andrej.picej@norik.com>)
        id 1mxpMc-00HBtw-2k; Thu, 16 Dec 2021 12:55:58 +0100
From:   Andrej Picej <andrej.picej@norik.com>
To:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org
Cc:     festevam@gmail.com, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, y.bas@phytec.com
Subject: [PATCH RESEND 1/2] ARM: dts: imx6: phyFLEX: add missing pmic mfd subdevices
Date:   Thu, 16 Dec 2021 12:55:28 +0100
Message-Id: <20211216115529.2331475-1-andrej.picej@norik.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: andrej.picej@norik.com
X-Authenticated-Sender: cpanel.siel.si: andrej.picej@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

phyFLEX PMIC DA9063 has also RTC and watchdog support. Add both
mfd subdevices so they can be used.

Signed-off-by: Andrej Picej <andrej.picej@norik.com>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index f3236204cb5a..2ec154756bbc 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -205,6 +205,14 @@ vdd_mx6_high_reg: ldo11 {
 				regulator-always-on;
 			};
 		};
+
+		pmic_rtc: rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		da9063_wdog: wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
 	};
 };
 
-- 
2.25.1

