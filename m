Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9B04CBC7A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiCCLYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiCCLYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:24:05 -0500
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net (zg8tmty1ljiyny4xntqumjca.icoremail.net [165.227.154.27])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0BD9512E775;
        Thu,  3 Mar 2022 03:23:18 -0800 (PST)
Received: from localhost (unknown [192.168.98.254])
        by app1 (Coremail) with SMTP id C4KowAB36FDLpCBiuLw6AA--.16098S2;
        Thu, 03 Mar 2022 19:21:48 +0800 (CST)
Date:   Thu, 3 Mar 2022 19:21:47 +0800
From:   fuyao <fuyao1697@cyg.com>
To:     Rob@scg, Herring@scg, robh+dt@kernel.org, Maxime@scg, Ripard@scg,
        mripard@kernel.org, Chen-Yu@scg, Tsai@scg, wens@csie.org,
        Jernej@scg, Skrabec@scg, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     =?utf-8?B?6bqm5YGl5qif?= <maijianzhang@allwinnertech.com>
Subject: [PATCH] sunxi:dts: remove r40 can node
Message-ID: <YiCky/6luAPcmiEB@scg>
Mail-Followup-To: Rob@scg, Herring@scg, robh+dt@kernel.org, Maxime@scg,
        Ripard@scg, mripard@kernel.org, Chen-Yu@scg, Tsai@scg,
        wens@csie.org, Jernej@scg, Skrabec@scg, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        =?utf-8?B?6bqm5YGl5qif?= <maijianzhang@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: work_work_work
X-CM-TRANSID: C4KowAB36FDLpCBiuLw6AA--.16098S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF18CFWUuw4xWF4fGFyDZFb_yoW3KFb_Ka
        4fGa15WFWrArZ8trn5Jw43Jw18Zw48C3s3X34IqF4UJanIvws5XF4DJa93Xw15WrW2gFZY
        yay5XF98tw1Y9jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbs8YjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E
        87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24V
        AvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xf
        McIj6x8ErcxFaVAv8VW8GwAv7VCY1x0262k0Y48FwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r
        1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkIecxEwVCm-wCF04k2
        0xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI
        8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
        xVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
        8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
        aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IUeeVbPUUUUU==
X-CM-SenderInfo: 5ix1t0irwzlqxf1jhudrp/
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

it does not have can in r40/a40i/t3.so delete it.

Signed-off-by: fuyao <fuyao1697@cyg.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 03d3e5f45a09..dde803b6ada0 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -936,15 +936,6 @@ i2c3: i2c@1c2b800 {
 			#size-cells = <0>;
 		};
 
-		can0: can@1c2bc00 {
-			compatible = "allwinner,sun8i-r40-can";
-			reg = <0x01c2bc00 0x400>;
-			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&ccu CLK_BUS_CAN>;
-			resets = <&ccu RST_BUS_CAN>;
-			status = "disabled";
-		};
-
 		i2c4: i2c@1c2c000 {
 			compatible = "allwinner,sun6i-a31-i2c";
 			reg = <0x01c2c000 0x400>;
-- 
2.32.0


-- 
Technology is exciting

