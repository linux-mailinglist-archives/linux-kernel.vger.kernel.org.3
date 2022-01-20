Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38C949531B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 18:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377333AbiATRXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 12:23:46 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:43917 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377233AbiATRXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 12:23:44 -0500
Received: by mail-ot1-f45.google.com with SMTP id q13-20020a9d4b0d000000b0059b1209d708so8428050otf.10;
        Thu, 20 Jan 2022 09:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Yz8oe3/XyaBDZ1FQ+X/VGUOc8sD+gbn465Mchm1UfqQ=;
        b=1TGnIsFB08oMr2j6jyQflrUpdNJtKbWo5QJWVZpw4op8xYi61770CjQAq+tWBQ1R2G
         lUYnIPIc72ulBazYUvEJ3Y+/cBfMeLoRAh+2pL/eiJpJ8KPv2gyQnQKiE4vHLBfFZiAq
         ZWCLBBWtqLEWNCidq2YIjtHgd0vfMgv1XV49d8XM4pRA+mPyQmdPVCAbyt3JMeIsHs8U
         J/UXEqsr8gjsnAVaHbqgV01WbC+TTSmGOdQgD0QN1EwCxYmX+DNR4Tg7p0RNFWf1W92v
         XKTkpSgd/kv7GV2ZbNFX76VkjzclNLv9ZSbYMZwPlUp9GIe/fFmthPTv8vluj3ZVDkHA
         hg2Q==
X-Gm-Message-State: AOAM531MI9p2ty7ppfPTO3Hkpe4lc8Cfo26zP7ejSZpLzDGd1u157DGV
        VqQTPDWwuGujy+Cc2JewCA==
X-Google-Smtp-Source: ABdhPJyblAA+uazX1XKWS4X8uBADnmian8HYprDWsr/jbPO9u1MTKLJ7kUh/QsbpMphF8X02EjzEPA==
X-Received: by 2002:a9d:6255:: with SMTP id i21mr21988579otk.363.1642699424031;
        Thu, 20 Jan 2022 09:23:44 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id t3sm1278960oou.48.2022.01.20.09.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 09:23:43 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: watchdog: fsl-imx7ulp-wdt: Fix assigned-clock-parents
Date:   Thu, 20 Jan 2022 11:23:32 -0600
Message-Id: <20220120172333.1628990-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The schema has a typo with 'assigned-clocks-parents'. As it is not
required to list assigned clocks in bindings, just drop the assigned-clocks
property definitions to fix this.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml     | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
index fb603a20e396..4ca8a31359a5 100644
--- a/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/fsl-imx7ulp-wdt.yaml
@@ -29,12 +29,6 @@ properties:
   clocks:
     maxItems: 1
 
-  assigned-clocks:
-    maxItems: 1
-
-  assigned-clocks-parents:
-    maxItems: 1
-
   timeout-sec: true
 
 required:
@@ -56,7 +50,7 @@ examples:
         interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
         clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
         assigned-clocks = <&pcc2 IMX7ULP_CLK_WDG1>;
-        assigned-clocks-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
+        assigned-clock-parents = <&scg1 IMX7ULP_CLK_FIRC_BUS_CLK>;
         timeout-sec = <40>;
     };
 
-- 
2.32.0

