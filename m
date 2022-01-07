Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38E62487FAB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 00:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbiAGXxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 18:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231855AbiAGXxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 18:53:34 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC01C061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 15:53:34 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i8so6999365pgt.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 15:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EC6Yy1tAZPwKkwKJYGHE/vqhf31r7sL2lK9QflxCMkc=;
        b=l6MDdTSWAeTxNGvEd93nFWHohs6kDg+tWO7s+yzY75uQRjE/BUZL1kjNK+KjgI9a9t
         aPx/i6Iaen1SS2wobC8fW5PqQBGs6sokNQFaN+A0zHsO5gxsScGMZ1kAu4i9Dn7irHmw
         FyyZCrIBRJwc3h2FllmUT1etPGBlGUa7w0YSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EC6Yy1tAZPwKkwKJYGHE/vqhf31r7sL2lK9QflxCMkc=;
        b=b167u+3LlgT8jGc/xDL6TSfXno3UKGv2JkbIg5ZvTsBMN/LYRfmhTz/TK00yovPf4m
         OGIa6XpRbiRvZJNqsAsIx0vVe6i3zjqjjs/S/NOMRfljDHLMEhin3NgKx/yZ39XxOFy/
         61X1xOwslFA6tk8bjyEMgaDjehu5yQ03qqp9wcSNGe0/IApPlsHINhq83sCodbmXK4ag
         rgjRTIjaFc2GxhwnhrCUcb0QRZ6j0iLXE1/qJeplsdTZHdiQ04SW+nt+fwt4xQqmlXCs
         53mBw0VvtHX5K+KYEp/4x69NWGsEAeWRlz8G+HTbJH/Xea8QcEb8rl0NUpk/XKSc4yar
         r2zQ==
X-Gm-Message-State: AOAM5306xdT0lZi0YyBcv07j+OlUjPNX54c076JTL1NZwGYcnv3RTyEX
        ompx39lj72ILT+5iNASUN+Uuyg==
X-Google-Smtp-Source: ABdhPJz/zuh06SfcYdI8C2pwHxKqrqYVX1iKu5qlgzfHoSrOLowcEYEFERoS9ljANAwquYdmLD+jnQ==
X-Received: by 2002:aa7:9799:0:b0:4bd:49ce:8bb1 with SMTP id o25-20020aa79799000000b004bd49ce8bb1mr555903pfp.74.1641599613569;
        Fri, 07 Jan 2022 15:53:33 -0800 (PST)
Received: from localhost ([2620:15c:202:201:db:1c60:693f:c24e])
        by smtp.gmail.com with UTF8SMTPSA id s12sm43682pfk.220.2022.01.07.15.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 15:53:33 -0800 (PST)
From:   Brian Norris <briannorris@chromium.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-pm@vger.kernel.org,
        Derek Basehore <dbasehore@chromium.org>,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: [PATCH 02/10] dt-bindings: devfreq: rk3399_dmc: Deprecate unused/redundant properties
Date:   Fri,  7 Jan 2022 15:53:12 -0800
Message-Id: <20220107155215.2.I5ba582cd678d34c03d647e5500db8e33b7524d66@changeid>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
In-Reply-To: <20220107235320.965497-1-briannorris@chromium.org>
References: <20220107235320.965497-1-briannorris@chromium.org>
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

 .../bindings/devfreq/rk3399_dmc.yaml          | 42 +++++++++----------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
index f12f34d93378..6bb411dddb7b 100644
--- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
+++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
@@ -58,6 +58,7 @@ properties:
       finishes a DCF interrupt is triggered.
 
   rockchip,ddr3_speed_bin:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       For values, reference include/dt-bindings/clock/rk3399-ddr.h. Selects the
@@ -104,6 +105,7 @@ properties:
       if bus is idle for standby_idle * DFI clock cycles.
 
   rockchip,dram_dll_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Defines the DDR3 DLL bypass frequency in MHz. When DDR frequency is less
@@ -111,6 +113,7 @@ properties:
       Note: if DLL was bypassed, the odt will also stop working.
 
   rockchip,phy_dll_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description: |
       Defines the PHY dll bypass frequency in MHz (Mega Hz). When DDR frequency
@@ -118,6 +121,7 @@ properties:
       Note: PHY DLL and PHY ODT are independent.
 
   rockchip,auto_pd_dis_freq:
+    deprecated: true
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Defines the auto PD disable frequency in MHz.
@@ -131,18 +135,21 @@ properties:
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
@@ -150,12 +157,14 @@ properties:
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
@@ -170,18 +179,21 @@ properties:
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
@@ -189,12 +201,14 @@ properties:
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
@@ -209,42 +223,49 @@ properties:
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
@@ -265,33 +286,12 @@ examples:
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
2.34.1.575.g55b058a8bb-goog

