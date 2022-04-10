Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6255B4FAF6B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 19:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243784AbiDJRx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 13:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbiDJRxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 13:53:22 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A43A4B427;
        Sun, 10 Apr 2022 10:51:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id mp16-20020a17090b191000b001cb5efbcab6so3999678pjb.4;
        Sun, 10 Apr 2022 10:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=shhc4vVqv9l2wKwY0kN4Lkjnnu+qZsCnM2eNImBcqfg=;
        b=bcE2u1RIArkVJNfBPsCQpccUXwypnRC34pmxKHpsrqCyZfsgqlMg52IB13pPZCE3MF
         ROLkD6adTktEjsXYNvjQ9bcKyyMWAnhgRhks0fyunsfu9S6V6Ve3E13ORpDMkq14HCKF
         8Ldp2YFDEGCu/sYKbBDIfllHA61bMB9xnNkDHmMg3Czo0tC3eYkHjBkjLlQpREkw3bqP
         bG9+SVGD/ohFX2ckUFfQDPJBldg8/zAF9VQkxisbqoYAaKSRyFJsEa5biZEQ+5i+MmIp
         TJHpzougHK/Zs6RgAK2FD1plFZf6LICtzr765+08SQudksAET5dJGRpe74qVKNBFesch
         gYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=shhc4vVqv9l2wKwY0kN4Lkjnnu+qZsCnM2eNImBcqfg=;
        b=lc70h6l/JTt6P9mBk1hGy/FNDKCe3mv97vihMSB+GY7olzrRxbJjvvKvwSmilJ8vx6
         efYJmxFP+f4IDNgaXvmz7qDhlcEAkj8zHjQY30t/WP+XfCxEphHsyk01/yRqFFtBUcUL
         ih9kXEHEkOuS7bom63DKSy7W5q+P2NUd7VrHJ19AQo9jMymqssv+WE12rAVT4vqDegoi
         8sAQUn5MD6uaOOk5sZCSlA4vVHS2LBo+x8PJ/Zmp4jS+N6tu0gp2HM2vHAMW5ad1xDQM
         yMhZ7st6m6j5/cQe5oS1CimicVNeV0ggv6R029U1t5DSi85ZVU51iRNW07W+vQ1iR7bw
         vbug==
X-Gm-Message-State: AOAM531h0Hl+XGfGQWqtDBFGJFaKJHsYg22GgahZ4exDBAFQ3PSfnHJl
        dKzVlYAUJilmIXhuiTgwmk0=
X-Google-Smtp-Source: ABdhPJwYvlu4TVUOjicYzrunzFDAozQBBLzGAXL6fmapBXm9n0ygCqT6eJgTR4EeecTJIggewpNJ+A==
X-Received: by 2002:a17:903:40ce:b0:14b:1f32:e926 with SMTP id t14-20020a17090340ce00b0014b1f32e926mr2713863pld.170.1649613071406;
        Sun, 10 Apr 2022 10:51:11 -0700 (PDT)
Received: from localhost.localdomain ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm32283286pfc.3.2022.04.10.10.51.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Apr 2022 10:51:11 -0700 (PDT)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: dts: qcom: msm8996: User generic node name for DMA
Date:   Sun, 10 Apr 2022 23:20:53 +0530
Message-Id: <20220410175056.79330-4-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
References: <20220410175056.79330-1-singh.kuldeep87k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qcom BAM DT spec expects generic DMA controller node name as
"dma-controller" to enable validations.

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index f0f81c23c16f..bbe677b9e5bf 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -707,7 +707,7 @@ tsens1: thermal-sensor@4ad000 {
 			#thermal-sensor-cells = <1>;
 		};
 
-		cryptobam: dma@644000 {
+		cryptobam: dma-controller@644000 {
 			compatible = "qcom,bam-v1.7.0";
 			reg = <0x00644000 0x24000>;
 			interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

