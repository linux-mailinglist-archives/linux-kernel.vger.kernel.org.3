Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51CF55279E7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiEOUbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238049AbiEOUbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:31:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C85DED3;
        Sun, 15 May 2022 13:31:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ch13so25114957ejb.12;
        Sun, 15 May 2022 13:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PaTZIap6SATi669kRyhjyKwcnCOv+7U1T4zX6WeFaro=;
        b=KmLWDVd5X6xcpiaKXRDi2fjsPUutyKu7aXWvR0erkdVmVwIPnh5jxx13W7egdt06BW
         ny7XRP69ZsA8OcyVUFatbEP0+tnWSLV2/WJv9OdgJphAlOlTdJufKW2x+BlarZeI9zNX
         baD0ZFDU2/ClXBJ0rkGX5y+P1KaOz8MuOmPY5wuljk/X4BD/rJqAD5nWMuyjSocUdaP1
         x2+QrkyzWC7LA7F40+pCc9RKjp3hWt1VNwIQu6/MTcHI+nge2h5BrcaeGQO7M2QtY7kw
         1gbkStCmV8rxj5ohpaKB4Q/2UCGWiHjCwu/x4ut1BaAFw//hlS33ocAzJ9v9Ry06tD3T
         nhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PaTZIap6SATi669kRyhjyKwcnCOv+7U1T4zX6WeFaro=;
        b=Q4OYg5VmNKB2jnvFGERFcdqISaigUFq9qHilUarXJ2xq2+5c3x+95ML97rfpi2xkdh
         ryXsUQ5j89i5Y8F0gmtgNEN90ciKKYeGrdcfB+z0Zv9t6qKi5tz8gm/KGe3M6unbVXFG
         8t/UzJZA+FkEo2UbGJoZyRlwKOob5BcxNl08tZ2LsiXvR3BefCmBk8baAivv2QlYgt7Q
         KDBlf4Qwo8JIHkWhvkcvhBKFX7OPFrMV92FydH8EeZdH68aULhFouWtQi/nyhxCL8tk+
         Y0pAvSVe8RH5KUeytqUF127+RVHVPmh43pGrsNfuPnlrS8UHWHbCTClVZgPuyaqgnvgP
         HpbA==
X-Gm-Message-State: AOAM530nuQrbgBWMM0sGF3Y0T8hZb0dhP4mKr/KuSR4t99YboMnec30x
        qwqtZI7q7eSnQgGElSiXdE8=
X-Google-Smtp-Source: ABdhPJzD011Sni2n7zKQi+0xlen0WN3fa8JAf3yBeuqk+YEjslKTDCk6c5kmwvg/aVtYdqWwzdcXUA==
X-Received: by 2002:a17:907:7d93:b0:6fe:21d9:4230 with SMTP id oz19-20020a1709077d9300b006fe21d94230mr5858712ejc.42.1652646690026;
        Sun, 15 May 2022 13:31:30 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id ze16-20020a170906ef9000b006f3ef214e4esm2944884ejb.180.2022.05.15.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:31:29 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 6/6] arm64: dts: ipq8074: add VQMMC supply
Date:   Sun, 15 May 2022 22:31:18 +0200
Message-Id: <20220515203118.474684-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515203118.474684-1-robimarko@gmail.com>
References: <20220515203118.474684-1-robimarko@gmail.com>
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

SDHCI controller claims DDR, HS200 and HS400 1.8V support, however it
cannot achieve those using the 2.95V I/O that is the default set by
firmware.

Since we know have access to the PMP8074 PMIC provided LDO that provides
the I/O voltage set it as VQMMC supply so that higher speeds can actually
be achieved.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 906468ee990e..2e8765aa8f37 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -476,6 +476,8 @@ sdhc_1: sdhci@7824900 {
 			mmc-hs400-1_8v;
 			bus-width = <8>;
 
+			vqmmc-supply = <&l11>;
+
 			status = "disabled";
 		};
 
-- 
2.36.1

