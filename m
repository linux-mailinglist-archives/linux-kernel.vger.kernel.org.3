Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D4A4792F1
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 18:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237406AbhLQRjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 12:39:31 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43925 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbhLQRja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 12:39:30 -0500
Received: by mail-ot1-f42.google.com with SMTP id i5-20020a05683033e500b0057a369ac614so3759891otu.10;
        Fri, 17 Dec 2021 09:39:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6CqWlNrOLka0aKdyToug+LskjYY7PoemQ3bjr+KzZtg=;
        b=iZRdfdotvMJDHwueXjk6LqL8CKcnPD4sLlg86TJNpPeSLhgjSB+Zqu13vDClYJ06Ar
         nEBl0EKLfHW+OsGXHY5M5tyl345VATHHGl2Btd8u9V0oWAgWVkj7ImM1shTz/2HaU6Kz
         wAAZ9IvpxMxVN53khT4pRTMD8DNYllNnoVKCKbFJn8VXXaQPNZbdEllIOB8NRRM7eB+Z
         HiGZdw000A/3GICm9fbZeUyoCSAceC4r2FAEMUbuAqAze7ueQ60T1jldv0HUJdV5T06X
         fvo9HyIRi5TzOgshcKF5eIHpgj5iY7aoh91ybOJ9x7fdo1tVPVAHl1qkAwugZDNQIorM
         hXBg==
X-Gm-Message-State: AOAM531Kg3+3yxGLDZ9BVQ7qFwypL44t7I6d1UaRZYUJ+njnX20cR6Jy
        Nl+7/499j6pMq/5Sj3oUtw==
X-Google-Smtp-Source: ABdhPJzJ7IffP8HMOauST3w4PTsTebYC3yAq34aeIMeI1mZq17zd6n181Y2qAn0jQD3cXldDJYnc5A==
X-Received: by 2002:a9d:1b0f:: with SMTP id l15mr2839418otl.38.1639762769664;
        Fri, 17 Dec 2021 09:39:29 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id bb8sm1774604oib.9.2021.12.17.09.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 09:39:28 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8qm: Drop CPU 'arm,armv8' compatible
Date:   Fri, 17 Dec 2021 11:39:08 -0600
Message-Id: <20211217173908.3201517-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CPU 'arm,armv8' compatible is only for s/w models, so remove it from
i.MX8QM CPU nodes.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
Note that the PMU node is also wrong as it should have separate A72 and
A53 nodes to get uarch specific events, but that needs some GIC changes.
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index aebbe2b84aa1..b13f09ca0404 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -54,7 +54,7 @@ core1 {
 
 		A53_0: cpu@0 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a53", "arm,armv8";
+			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
@@ -62,7 +62,7 @@ A53_0: cpu@0 {
 
 		A53_1: cpu@1 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a53", "arm,armv8";
+			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
@@ -70,7 +70,7 @@ A53_1: cpu@1 {
 
 		A53_2: cpu@2 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a53", "arm,armv8";
+			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
@@ -78,7 +78,7 @@ A53_2: cpu@2 {
 
 		A53_3: cpu@3 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a53", "arm,armv8";
+			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			next-level-cache = <&A53_L2>;
@@ -86,7 +86,7 @@ A53_3: cpu@3 {
 
 		A72_0: cpu@100 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a72", "arm,armv8";
+			compatible = "arm,cortex-a72";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&A72_L2>;
@@ -94,7 +94,7 @@ A72_0: cpu@100 {
 
 		A72_1: cpu@101 {
 			device_type = "cpu";
-			compatible = "arm,cortex-a72", "arm,armv8";
+			compatible = "arm,cortex-a72";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			next-level-cache = <&A72_L2>;
-- 
2.32.0

