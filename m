Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A66522E62
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiEKIaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237797AbiEKIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:30:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADDCB18B965;
        Wed, 11 May 2022 01:30:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxkNoPdHtiw+cQAA--.6S3;
        Wed, 11 May 2022 16:30:09 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangtiezhu@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 2/3] MIPS: Loongson64: DTS: Add Loongson-2K1000 DTS related smp support
Date:   Wed, 11 May 2022 16:30:06 +0800
Message-Id: <20220511083007.17700-2-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220511083007.17700-1-zhangqing@loongson.cn>
References: <20220511083007.17700-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxkNoPdHtiw+cQAA--.6S3
X-Coremail-Antispam: 1UD129KBjvdXoW7JFW7Jr4DtrW8ZrWxuw4rKrg_yoWkJFc_A3
        WIvaykGFWrJFZ3ta48Xr4UJFy7u3yUA3WfC3WDWry0qasI9wn8JrW7AFWDKrnxGFWaqrs8
        XFWrWr48AFn7KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY02
        0Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
        vE14v26r1Y6r17McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
        r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8ZwCF04k20x
        vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
        3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
        AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAI
        cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUoVb9UUUUU=
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device tree node and connect it to the CPU nodes.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 .../mips/boot/dts/loongson/loongson64-2k1000.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
index 8143a61111e3..3b765c063d7a 100644
--- a/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson64-2k1000.dtsi
@@ -20,6 +20,16 @@
 			reg = <0x0>;
 			#clock-cells = <1>;
 			clocks = <&cpu_clk>;
+			enable-method = "mmio-ipi";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "loongson,gs264";
+			reg = <0x1>;
+			#clock-cells = <1>;
+			clocks = <&cpu_clk>;
+			enable-method = "mmio-ipi";
 		};
 	};
 
@@ -44,6 +54,11 @@
 		compatible = "mti,cpu-interrupt-controller";
 	};
 
+	ipi: interrupt-controller@1fe11000 {
+		compatible = "loongson, mmio-ipi";
+		reg = <0 0x1fe11000 0 0x40>;
+	};
+
 	package0: bus@10000000 {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.20.1

