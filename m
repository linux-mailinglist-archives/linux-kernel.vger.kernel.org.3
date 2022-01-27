Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC58F49EE82
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 00:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245705AbiA0XIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 18:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245539AbiA0XI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 18:08:29 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169B7C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id c3so4214631pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 15:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ji/SQVVMeTn1tROVJbE5IrSuQIV7umlG4sAb9DJ1rd4=;
        b=GJM/8zOZW0jPtcOYOaNBWtQ+KSUyKvUuXiUYQWTAO1rDvzd7irsrnCeZWw+gY+dvAC
         H3rxT/8/ZAQ/SJDJWN7wVaxvIf4kTQZTn0JjyYXNgPVS470n10NfGh5KQRpfBL4P9EfB
         SdBUplDn/Oxn1fbUeU8O1CKRon/hgYYO7VUyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ji/SQVVMeTn1tROVJbE5IrSuQIV7umlG4sAb9DJ1rd4=;
        b=u1HAqQ4uZcXSsel6kX24iBgYaR+YE4YRetIN1CKgjNVZLpaePpl92aGS6RFbgD9vef
         2u1X33MaurwbKNpN1uTWIjs0PPxDAW06O5wDr8EXkp/ZFBQeY5djQ7N/eK5chpNAPgGZ
         WHeH7SWKSIJQ19bac4CLVitaOVVIKDgIQOTbVkHOa3OhK/fTf29AC58cb5NJejxKNTBY
         Xvz2hq/z1tse9tFG6+1OYInYYAqGt+CcqkeAkz9DgiTsAdOxnzShtDP1BEQHxEPowh7b
         B0C8ldZxw9WDr1fE0MzDyGpwBQfw3c3DY7yoMpA2jdH1fgSc/ssmIDG0qdUcOPbhsOez
         sGDQ==
X-Gm-Message-State: AOAM530SwR6cPqQGHlJDTcLulGsTOwadGM4+/qAKxdxNYab+xeBoadN7
        2KB3sBY96RGKPKa8ksa5IbRWhw==
X-Google-Smtp-Source: ABdhPJx9wiK9xm45b/dDJyYOFbrCKmg/tP7sUb2cWXUt03ZZJppWUeBaQOtvpMF6ShLXjrrfnTWJFw==
X-Received: by 2002:a17:902:c10c:: with SMTP id 12mr5903890pli.158.1643324908569;
        Thu, 27 Jan 2022 15:08:28 -0800 (PST)
Received: from localhost ([2620:15c:202:201:723d:38a9:9e7f:3435])
        by smtp.gmail.com with UTF8SMTPSA id f12sm517852pfj.37.2022.01.27.15.08.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 15:08:28 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2 02/15] dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant properties
Date:   Thu, 27 Jan 2022 15:07:13 -0800
Message-Id: <20220127150615.v2.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
In-Reply-To: <20220127230727.3369358-1-briannorris@chromium.org>
References: <20220127230727.3369358-1-briannorris@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These DRAM configuration properties are all handled in ARM Trusted
Firmware (and have been since the early days of this SoC), and there are
no in-tree users of the DMC binding yet. It's better to just defer to
firmware instead of maintaining this large list of properties.

There's also some confusion about units: many of these are specified in
MHz, but the downstream users and driver code are treating them as Hz, I
believe. Rather than straighten all that out, I just drop them.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

(no changes since v1)

 .../bindings/devfreq/rk3399_dmc.yaml          | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index 467a7b5b374b..fd62a8cd62d5 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -46,6 +46,7 @@ properties:
       finishes, a DCF interrupt is triggered.
 
   rockchip,ddr3_speed_bin:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       For values, reference include/dt-bindings/clock/rk3399-ddr.h. Selects the
@@ -92,6 +93,7 @@ properties:
       if bus is idle for standby_idle * DFI clock cycles.
 
   rockchip,dram_dll_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Defines the DDR3 DLL bypass frequency in MHz. When DDR frequency is less
@@ -99,6 +101,7 @@ properties:
       Note: if DLL was bypassed, the odt will also stop working.
 
   rockchip,phy_dll_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Defines the PHY dll bypass frequency in MHz (Mega Hz). When DDR frequency
@@ -106,6 +109,7 @@ properties:
       Note: PHY DLL and PHY ODT are independent.
 
   rockchip,auto_pd_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Defines the auto PD disable frequency in MHz.
@@ -119,18 +123,21 @@ properties:
       disabled.
 
   rockchip,ddr3_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the DRAM side drive
       strength in ohms. Default value is 40.
 
   rockchip,ddr3_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the DRAM side ODT
       strength in ohms. Default value is 120.
 
   rockchip,phy_ddr3_ca_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the phy side CA line
@@ -138,12 +145,14 @@ properties:
       Default value is 40.
 
   rockchip,phy_ddr3_dq_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the PHY side DQ line
       (including DQS/DQ/DM line) drive strength. Default value is 40.
 
   rockchip,phy_ddr3_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is DDR3, this parameter defines the PHY side ODT
@@ -158,18 +167,21 @@ properties:
       disabled.
 
   rockchip,lpddr3_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR3, this parameter defines the DRAM side drive
       strength in ohms. Default value is 34.
 
   rockchip,lpddr3_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR3, this parameter defines the DRAM side ODT
       strength in ohms. Default value is 240.
 
   rockchip,phy_lpddr3_ca_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR3, this parameter defines the PHY side CA line
@@ -177,12 +189,14 @@ properties:
       Default value is 40.
 
   rockchip,phy_lpddr3_dq_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR3, this parameter defines the PHY side DQ line
       (including DQS/DQ/DM line) drive strength. Default value is 40.
 
   rockchip,phy_lpddr3_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When dram type is LPDDR3, this parameter define the phy side odt
@@ -197,42 +211,49 @@ properties:
       disabled.
 
   rockchip,lpddr4_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the DRAM side drive
       strength in ohms. Default value is 60.
 
   rockchip,lpddr4_dq_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the DRAM side ODT on
       DQS/DQ line strength in ohms. Default value is 40.
 
   rockchip,lpddr4_ca_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the DRAM side ODT on
       CA line strength in ohms. Default value is 40.
 
   rockchip,phy_lpddr4_ca_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the PHY side CA line
       (including command address line) drive strength. Default value is 40.
 
   rockchip,phy_lpddr4_ck_cs_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the PHY side clock
       line and CS line drive strength. Default value is 80.
 
   rockchip,phy_lpddr4_dq_drv:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the PHY side DQ line
       (including DQS/DQ/DM line) drive strength. Default value is 80.
 
   rockchip,phy_lpddr4_odt:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       When the DRAM type is LPDDR4, this parameter defines the PHY side ODT
@@ -261,33 +282,12 @@ examples:
       clock-names = "dmc_clk";
       operating-points-v2 = <&dmc_opp_table>;
       center-supply = <&ppvar_centerlogic>;
-      rockchip,ddr3_speed_bin = <21>;
       rockchip,pd_idle = <0x40>;
       rockchip,sr_idle = <0x2>;
       rockchip,sr_mc_gate_idle = <0x3>;
       rockchip,srpd_lite_idle = <0x4>;
       rockchip,standby_idle = <0x2000>;
-      rockchip,dram_dll_dis_freq = <300>;
-      rockchip,phy_dll_dis_freq = <125>;
-      rockchip,auto_pd_dis_freq = <666>;
       rockchip,ddr3_odt_dis_freq = <333>;
-      rockchip,ddr3_drv = <40>;
-      rockchip,ddr3_odt = <120>;
-      rockchip,phy_ddr3_ca_drv = <40>;
-      rockchip,phy_ddr3_dq_drv = <40>;
-      rockchip,phy_ddr3_odt = <240>;
       rockchip,lpddr3_odt_dis_freq = <333>;
-      rockchip,lpddr3_drv = <34>;
-      rockchip,lpddr3_odt = <240>;
-      rockchip,phy_lpddr3_ca_drv = <40>;
-      rockchip,phy_lpddr3_dq_drv = <40>;
-      rockchip,phy_lpddr3_odt = <240>;
       rockchip,lpddr4_odt_dis_freq = <333>;
-      rockchip,lpddr4_drv = <60>;
-      rockchip,lpddr4_dq_odt = <40>;
-      rockchip,lpddr4_ca_odt = <40>;
-      rockchip,phy_lpddr4_ca_drv = <40>;
-      rockchip,phy_lpddr4_ck_cs_drv = <80>;
-      rockchip,phy_lpddr4_dq_drv = <80>;
-      rockchip,phy_lpddr4_odt = <60>;
     };
-- 
2.35.0.rc0.227.g00780c9af4-goog

