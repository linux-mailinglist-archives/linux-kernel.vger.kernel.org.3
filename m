Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 275264D064E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 19:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbiCGSWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 13:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244732AbiCGSWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 13:22:08 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F4F818AC;
        Mon,  7 Mar 2022 10:21:14 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id p8so14806498pfh.8;
        Mon, 07 Mar 2022 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h8VKW3KucGatzYLlN7O6KhroN7xX8cfI5ePJaahJhr8=;
        b=qXloZCd25pfaaeManAbAUBZpoWdm1OzF4/nEt00iEgN0AAK0QDo2rnZZLMRnkFKrpM
         XWCPa+YpS03+E2PAO1Z0D7BnKXi9Ay8w5uVDVIeJHvK4SEJzoJ8Sg0So4dYFj/YhUPSC
         vVF582vHCMd5D+OrGLUNs3HC9aaIfLqFXLG1gExx4a95oPzXb4KnZxDZrrc7lCS+jU4D
         gKqJlfvN2JHzKRRZ9SYluwzjvo9kRqGeGCvA/g3UdADdFQN3agjmgEgxdlc5trCg+nU4
         Ldol1lriGWAwt1DTwL0Gesn0PGrJrNcHpk0hTdp2h8Y0nRf2leeBXv3UyJNCnpKSbpHs
         +W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h8VKW3KucGatzYLlN7O6KhroN7xX8cfI5ePJaahJhr8=;
        b=QHrAixnZEAsk3plreO2xVOyM4kpKmDwnxdmZbARRQp38Oi/p72wcj2NFhQBPG4zMOp
         2RQCjPwfg9DyKrtZrio+aX28nSUsiFMlKYZKRQS14g58+C+ztCGKLrocbiQlrMpf7i14
         kqUhSaVStsPQI3JMzKz8ISFmfIeyE2N8HHp2ghgzGrFQVa7O/iAb94vU4AWD29ao7bOy
         h5VeAuo8mgznqftnYhEGXdPypKF/ixpu++kuXmt25U5jKiLZpBr3WwL0W1mJfoqMRcWE
         f9juHSB4eHsdM5WTR6JzXvlYcpO0gSP0u5eceUIi8zL6UHmhLWinyDwfEg8758/JcLXm
         1fgg==
X-Gm-Message-State: AOAM532bcw3knvG9iTkA5/zipmBgkJtkyAoiGViFGaiIfY5T9Z1ogeJQ
        gz1hOvde+aXk2JPZGuK/IC4=
X-Google-Smtp-Source: ABdhPJzXl4xFXnuTGX09muyLAhW0L0eXYapNdcDy+OXqESsWVXXd7ctu/NOFEPICzR+UZBOrDsOQCg==
X-Received: by 2002:a63:c00c:0:b0:37c:942e:6c3c with SMTP id h12-20020a63c00c000000b0037c942e6c3cmr10947396pgg.336.1646677273705;
        Mon, 07 Mar 2022 10:21:13 -0800 (PST)
Received: from localhost.localdomain ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id t190-20020a632dc7000000b003759f87f38csm12245809pgt.17.2022.03.07.10.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 10:21:13 -0800 (PST)
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Cc:     Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>
Subject: [PATCH 3/3] arm64: dts: stingray: Fix spi clock name
Date:   Mon,  7 Mar 2022 23:51:01 +0530
Message-Id: <20220307182101.84730-3-singh.kuldeep87k@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
References: <20220307182101.84730-1-singh.kuldeep87k@gmail.com>
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

SPI clock name for pl022 is "sspclk" and not "spiclk".
Also fix below dtc warning:
clock-names:0: 'spiclk' is not one of ['SSPCLK', 'sspclk']

Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
---
 arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
index 4135246b6e72..7f1b8efd0883 100644
--- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
+++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
@@ -519,7 +519,7 @@ ssp0: spi@180000 {
 			reg = <0x00180000 0x1000>;
 			interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&hsls_div2_clk>, <&hsls_div2_clk>;
-			clock-names = "spiclk", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -531,7 +531,7 @@ ssp1: spi@190000 {
 			reg = <0x00190000 0x1000>;
 			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&hsls_div2_clk>, <&hsls_div2_clk>;
-			clock-names = "spiclk", "apb_pclk";
+			clock-names = "sspclk", "apb_pclk";
 			num-cs = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.25.1

