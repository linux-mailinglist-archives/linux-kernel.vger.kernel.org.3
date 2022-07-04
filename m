Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515BC5653FC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbiGDLog (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233326AbiGDLof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:44:35 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704F91144E;
        Mon,  4 Jul 2022 04:44:34 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c13so11328989eds.10;
        Mon, 04 Jul 2022 04:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQcJjn3ARqMYdbJS4pFTA/MzxJjJFrNvD2Fd+FyIdLc=;
        b=J82RESsgpyi60Sh+2GrZYuT9yfI1t7J2JZueRAa7XOUxIHXCRtKl3MVO39k8/jDZma
         8qwBP6QzwCZwq/KEIuVIv/rWBypsRVTcRN46+lOOVQWmpi3jtZkZvqtTRC+jaAhgoDml
         i7DP+FDdsruaU3qE0z7d7HGEuoraph87kzZXpMxF616UAgbi+vEAKLDo8ih1pPFKbMv+
         IvsFoNyxafwUPYxg402sN++0jMau/SkEpBbJJ1nozPIbtZeEMTDA3heW95jl6bIYqUX5
         o4fiiPTOgx36IX7rBUZciSHP785YH9nJEQwKGiFuRvea1jtejo8pvMDlLeT1jQmNYIA3
         9ffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQcJjn3ARqMYdbJS4pFTA/MzxJjJFrNvD2Fd+FyIdLc=;
        b=e2MlratgFJ0OXv7ZONngfno1RBSoxpnIJSTJzH4+Bc0kc11Rw2ROHyCn1H7itvCzqY
         DD/qlfp+1Ubq4LaEswaRUGoXph4yvxtQQ1Z/y/2wuA8V44db/7zKZczgVogiKJ3KHx/7
         n5DbUVEFfI42QJZIQtyF2/JT/EcKW9Lbd0r4f72Wu2YYVM5w6FaBbcI+m2Kll2BywsVk
         hFowYgEeoksYcdaqmHDDGWpbo3pbxI2LtHOL/NZDll7oXyISSfMFIgWoZL08XlIT/6Op
         cty9+AzNiVPJQS77Hd9K58Gx+T0neIQIJtZkFqC31ExtYWYftFbDGdBFFH6mRwMZhojA
         Vk4g==
X-Gm-Message-State: AJIora+6yK0aPA5q/9t+FPAtucCO7qVtft+VuzY+/Ur1F9IveQHabxjI
        5zZyXX/5FPxncr76Ozv3e8Q=
X-Google-Smtp-Source: AGRyM1vO0kQ0Ha+Weh4x6l5lBfn+LY0Ozv5LLsgQhd5djBXhAvFkvfIPEWYOoNBgMw0XmjEMp/6k1A==
X-Received: by 2002:aa7:cf01:0:b0:435:5ace:69cc with SMTP id a1-20020aa7cf01000000b004355ace69ccmr39287328edy.251.1656935072999;
        Mon, 04 Jul 2022 04:44:32 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-90.xnet.hr. [88.207.99.90])
        by smtp.googlemail.com with ESMTPSA id e10-20020a056402148a00b0043a1255bc68sm3704582edv.94.2022.07.04.04.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 04:44:32 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: ipq8074: add reset to SDHCI
Date:   Mon,  4 Jul 2022 13:44:30 +0200
Message-Id: <20220704114430.625365-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add reset to SDHCI controller so it can be reset to avoid timeout issues
after software reset due to bootloader set configuration.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index ddafc7de6c5f..d685ca1969a3 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -482,6 +482,7 @@ sdhc_1: mmc@7824900 {
 				 <&gcc GCC_SDCC1_APPS_CLK>,
 				 <&xo>;
 			clock-names = "iface", "core", "xo";
+			resets = <&gcc GCC_SDCC1_BCR>;
 			max-frequency = <384000000>;
 			mmc-ddr-1_8v;
 			mmc-hs200-1_8v;
-- 
2.36.1

