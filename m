Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D834EC55D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 15:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237334AbiC3NSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 09:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345832AbiC3NSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 09:18:03 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE173054E;
        Wed, 30 Mar 2022 06:16:17 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g20so24371382edw.6;
        Wed, 30 Mar 2022 06:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gs1vvcOmyeHWU2nvibJ9wj8P9a0Lnd/nEA7xnnwe/Uo=;
        b=S8gSdguyuYFeXvjQIF+N/KzFb5HSb0C6/XOwjXe1zZldnlDNiaxAUWaNvatdZSJ1T/
         DthKq0Wy4wRSeXYFnxTGBmI/Jb7lYzpDafiYhjDvtQZsbK39peu/8dmph4Oo0fAGhygU
         TErQRp6v6FAPVFmv6MOZgLiDa5Dzs0j37cvQrn3glhZEFNrpgaVzsOJ8DGkqVVOF75lE
         j85VMXD6+A7XhHwEVw2GpjrpvndWtUw8XmZ00uOnVMmOAscupQaCK2CEV+6yBTl3x80m
         B9XJcoKLREPpXXoK26KH21Ep/8npIyicj+zRj693C8m25q1JXFnGqBMCrjhPsQUTHKIz
         I2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gs1vvcOmyeHWU2nvibJ9wj8P9a0Lnd/nEA7xnnwe/Uo=;
        b=4nQlMJIfqzks4eCWNRejClLxyOmwzhdLmv5bM2qp2DFnWnkjfgIOCxj8b+D+2dZTsO
         sdVSfjb3ct0PDoA/aAGMbwTL2NnryENNcjASDXQLwy2TchgtXI0hzSdR+neZlE0uM6bp
         TBw5kRVzajS/sQEuQQuPlsL0hMZROM3hMceFYB2JEpySI6ZSMn3Ph/If45pcOgW9uMiP
         vq3HvGUjZqXT++xbv3Gno6VPKnM1cJ8RYDAtTsdl0W9WWgh94YhEO7gvvuNUI3l3CIOs
         Uo1VG6bXmIQqVvOdCMLwsqQjy5fiz2R5VYfqLcHryd3RRtAEEOdmvYS1A8fjm03YIIOG
         BiIQ==
X-Gm-Message-State: AOAM5327C7TyzrBsVwHRzqUW2dLaIRNWBzmQV9XfMJTgBeq/J5EJKVSU
        t7mSbiaiUXNlRGO/vzS29+wjnxxCqJM=
X-Google-Smtp-Source: ABdhPJxVHm9ajeOgUb7tlHvniIns/o2Y5rSQXdlfG1g7ZiVmjRT/qHDSX5u7MblMemJiINN8BKtiEw==
X-Received: by 2002:aa7:cc96:0:b0:410:b9ac:241 with SMTP id p22-20020aa7cc96000000b00410b9ac0241mr10577416edt.246.1648646176461;
        Wed, 30 Mar 2022 06:16:16 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ge13-20020a170907908d00b006e09a005d73sm6603476ejb.31.2022.03.30.06.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 06:16:15 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de, zhangqing@rock-chips.com
Cc:     robh+dt@kernel.org, krzk+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/3] ARM: dts: rockchip: Remove bogus "amba" bus nodes part 2
Date:   Wed, 30 Mar 2022 15:16:08 +0200
Message-Id: <20220330131608.30040-3-jbx6244@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220330131608.30040-1-jbx6244@gmail.com>
References: <20220330131608.30040-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "amba" bus nodes wrapping all the DMA-330 nodes serve no useful
purpose, and certainly bear no relation at all to the actual underlying
interconnect topology. They appear to be cargo-cult copying from a
design misstep in the very early days of FDT adoption on ARM, which was
righted with the "arm,primecell" compatible, and the last trace of the
idea finally purged by commit 2ef7d5f342c1 ("ARM, ARM64: dts: drop
"arm,amba-bus" in favor of "simple-bus"").

As such, they can simply be removed and the DMA-330 nodes fitted into
the normal sort order.
The node names should be generic, so rename it to "dma-controller".

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rv1108.dtsi | 29 +++++++++++------------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index eceaa940b..c158a7ea8 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -85,24 +85,6 @@
 		#clock-cells = <0>;
 	};
 
-	amba: bus {
-		compatible = "simple-bus";
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		pdma: pdma@102a0000 {
-			compatible = "arm,pl330", "arm,primecell";
-			reg = <0x102a0000 0x4000>;
-			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
-			#dma-cells = <1>;
-			arm,pl330-broken-no-flushp;
-			arm,pl330-periph-burst;
-			clocks = <&cru ACLK_DMAC>;
-			clock-names = "apb_pclk";
-		};
-	};
-
 	bus_intmem: sram@10080000 {
 		compatible = "mmio-sram";
 		reg = <0x10080000 0x2000>;
@@ -259,6 +241,17 @@
 		status = "disabled";
 	};
 
+	pdma: dma-controller@102a0000 {
+		compatible = "arm,pl330", "arm,primecell";
+		reg = <0x102a0000 0x4000>;
+		interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
+		#dma-cells = <1>;
+		arm,pl330-broken-no-flushp;
+		arm,pl330-periph-burst;
+		clocks = <&cru ACLK_DMAC>;
+		clock-names = "apb_pclk";
+	};
+
 	grf: syscon@10300000 {
 		compatible = "rockchip,rv1108-grf", "syscon", "simple-mfd";
 		reg = <0x10300000 0x1000>;
-- 
2.20.1

