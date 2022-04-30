Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4908E515F48
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 18:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383120AbiD3Qia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237942AbiD3QiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 12:38:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9C36FF72;
        Sat, 30 Apr 2022 09:35:03 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id n8so9528063plh.1;
        Sat, 30 Apr 2022 09:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EyGOhUWTiu5u131oTuoKOtQFl2U6BDUbmbvuOTx3toc=;
        b=Zuuwy2M6G2TwFQUNnapePqiqchEQ9b1DK7KVD30MpVWCQCOjgd2YOrl9FAD9LiaJnY
         IDl4V5NC0EGSiZWubq9qnjmrDkhVcX6TVMFGInVD68debHAM8Ku4TJTNb8YoWqwzPlpb
         24XNGR3crfXm/eytqO6nEM89AVC9XuOaJtvN2sHdIUsk0ZI1E2kBDIYy6VU31pemikrT
         EsJac+JYKxGk//S71HMS+Cm9v+NAocdh5qutNBLoUfGyl8X6XOjPoRg0Kfbe7W8QeNzg
         T3J3ndqs16qdEAkvTJz96ayfh+cTPgCxj7r3nb9xg5sklbySy2goTWsVL/vSj7eaR9/9
         nVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EyGOhUWTiu5u131oTuoKOtQFl2U6BDUbmbvuOTx3toc=;
        b=gj8j4vKs151M4MWqi6LGmifEo4sw+pBxz54yYitlW8XsFHFtBaRM7gyLjBRT/qHu5g
         EOiR3iPhF9ck7LgqEVH/cdjHQZgHS1c2VjMDs4a+SFnY0D0Bf4JhGv+i0RGJEA+uj0iK
         DdHg1dvWT6FYcP6+P7DbS+H8qfw+oex6PaRWc99o2CUZphfw0KgYx3DVfoTpUJJPLdWH
         xtmOllGgn3BNCSSchNDlPCCXVotNibUydPj7Upx/l/IUqODeLwHzhFgCT5HcftrdkuMX
         y7Z1mQAuBa7yf5o//p2Vb5nb9C0x7BfLJKp9F/K365XNaKA0rWTkZzv8D52nqDqcFftx
         Zyhg==
X-Gm-Message-State: AOAM533yt1Cfw+e/qUcju8Qsd8iBo9SsuQglqbvMGo+WId74+TMZiniZ
        sQyIGHt/+dL9FYGeJPj72Hc=
X-Google-Smtp-Source: ABdhPJzpINsjuBEKWL2ROktmfsUJ53AY3PCTX+D41hWSE2ffksbSXCdPFcmTn6RkP6Uz/RB1YfHK7A==
X-Received: by 2002:a17:90b:4a49:b0:1d2:adce:8a89 with SMTP id lb9-20020a17090b4a4900b001d2adce8a89mr9816215pjb.43.1651336503290;
        Sat, 30 Apr 2022 09:35:03 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:c0f1:53a1:ea79:5d2f])
        by smtp.gmail.com with ESMTPSA id t13-20020a65608d000000b003c14af50606sm8401152pgu.30.2022.04.30.09.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Apr 2022 09:35:02 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-mediatek@lists.infradead.org (moderated list:ARM/Mediatek SoC
        support), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] arm: dts: mediatek: add mtk-snfi for mt7629
Date:   Sun,  1 May 2022 00:34:52 +0800
Message-Id: <20220430163453.537061-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device-tree nodes for the MTK SPI-NAND Flash Interface
to mt7629 device tree.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 arch/arm/boot/dts/mt7629.dtsi | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/mt7629.dtsi b/arch/arm/boot/dts/mt7629.dtsi
index 46fc236e1b89..6f231e2ed68f 100644
--- a/arch/arm/boot/dts/mt7629.dtsi
+++ b/arch/arm/boot/dts/mt7629.dtsi
@@ -286,6 +286,27 @@ spi: spi@1100a000 {
 			status = "disabled";
 		};
 
+		snfi: spi@1100d000 {
+			compatible = "mediatek,mt7629-snand";
+			reg = <0x1100d000 0x1000>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_NFI_PD>, <&pericfg CLK_PERI_SNFI_PD>;
+			clock-names = "nfi_clk", "pad_clk";
+			nand-ecc-engine = <&bch>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
+		bch: ecc@1100e000 {
+			compatible = "mediatek,mt7622-ecc";
+			reg = <0x1100e000 0x1000>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&pericfg CLK_PERI_NFIECC_PD>;
+			clock-names = "nfiecc_clk";
+			status = "disabled";
+		};
+
 		qspi: spi@11014000 {
 			compatible = "mediatek,mt7629-nor",
 				     "mediatek,mt8173-nor";
-- 
2.35.1

