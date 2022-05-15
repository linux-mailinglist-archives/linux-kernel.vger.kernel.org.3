Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493E7527A48
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238229AbiEOVB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 17:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiEOVBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 17:01:06 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2369DFC0;
        Sun, 15 May 2022 14:01:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id m20so25211083ejj.10;
        Sun, 15 May 2022 14:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiaVpz1eUfDqE52UW9rfQ/0tpqjiTOXtuh3HRB0EhLk=;
        b=UlQ0Wf4tAlxYudfXwS23LRgu7dEtmTUo6YZPEmJB3AF6ca0mvh5MF0ywA2vOD7bHQh
         CekfjhGkXVJpcqQ2GevOtNV5QHVIEneEtijwSbig0xXpEucR+qO7NdPN3QeiIyJszPzc
         2T5KV0sl36xM8NMfPJ7AdRCr4H7KzynVtd8zIYUaH51YVyFNedh27Y/kp5dEE17AopTe
         tqLUjB2QfcilRCICW+O90HzNz56eS+fi25DTL1og+HzzfvahvnoZXLk/7uY9hr/j8VYa
         auaiP4+wOb1XY16iKWyCNIDHd01Fe9GxwpkAaiowHaP1OloPbKZ1PjTCyiqATiVQfR6V
         lOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiaVpz1eUfDqE52UW9rfQ/0tpqjiTOXtuh3HRB0EhLk=;
        b=PzCiuAHVcNdn94A+Qnq6vZOf6C42UBi0PCGYgotn1Oe2qoB2lFsA5VF/OluFxvfxgj
         /ZlBsb7gqCCLIB5Z1y4r+y6dlxjZT5MOtDoWbSH4pC3aYr+CTdXC5V6W9KK+T+dzvUYY
         IMd6OPgCQh6T6YQIsEC84uaBXBDtFzXzyUncfS+HxPdJAqQdEPggJcaguYOHv2rX0cpF
         uEPUjywleMqxI9RPVnFlpc2+PdOlkYqv23V4nFpve8swhflrerF/qMkGgDoBGbYCF60I
         x5Jx2gH0yt6MlS6p5+GeRwVLQB3dHhDMHh7KJw15VchABz3v+El6fH7hienjQfcv58Xq
         TyZQ==
X-Gm-Message-State: AOAM533QC9VO5akF/zROeGHBNYczc/XTdtKkCvZySQzOOKSh7ECpjPKV
        Sg0Rrq26ev8B6rHj0qtchyU=
X-Google-Smtp-Source: ABdhPJy32tmp8NybQjxKq745ldaozsmbaAs7o3W5RY1yw4zX9siucDBSA5IoMjvGbdeQ6Pvy3b4L7A==
X-Received: by 2002:a17:906:58d2:b0:6fd:daa7:3a6e with SMTP id e18-20020a17090658d200b006fddaa73a6emr12977265ejs.0.1652648463193;
        Sun, 15 May 2022 14:01:03 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id w12-20020aa7da4c000000b0042ab649183asm28917eds.35.2022.05.15.14.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 14:01:02 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     bjorn.andersson@linaro.org, agross@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tdas@codeaurora.org,
        absahu@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v4 11/11] arm64: dts: ipq8074: add USB power domains
Date:   Sun, 15 May 2022 23:00:48 +0200
Message-Id: <20220515210048.483898-11-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515210048.483898-1-robimarko@gmail.com>
References: <20220515210048.483898-1-robimarko@gmail.com>
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

Add USB power domains provided by GCC GDSCs.
Add the required #power-domain-cells to the GCC as well.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v4:
* Alphabetically sort the GCC cells properties
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index ba81c510dd39..4d278151cfcf 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -382,6 +382,7 @@ gcc: gcc@1800000 {
 			compatible = "qcom,gcc-ipq8074";
 			reg = <0x01800000 0x80000>;
 			#clock-cells = <0x1>;
+			#power-domain-cells = <1>;
 			#reset-cells = <0x1>;
 		};
 
@@ -610,6 +611,8 @@ usb_0: usb@8af8800 {
 						<133330000>,
 						<19200000>;
 
+			power-domains = <&gcc USB0_GDSC>;
+
 			resets = <&gcc GCC_USB0_BCR>;
 			status = "disabled";
 
@@ -650,6 +653,8 @@ usb_1: usb@8cf8800 {
 						<133330000>,
 						<19200000>;
 
+			power-domains = <&gcc USB1_GDSC>;
+
 			resets = <&gcc GCC_USB1_BCR>;
 			status = "disabled";
 
-- 
2.36.1

