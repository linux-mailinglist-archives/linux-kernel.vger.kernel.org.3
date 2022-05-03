Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B72F518D9F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbiECUAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 16:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiECUAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 16:00:17 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516EE3FBFD;
        Tue,  3 May 2022 12:56:42 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id i27so35425809ejd.9;
        Tue, 03 May 2022 12:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8D8Zb3AbrRdlYOjMRwAdaA0keCtGvT87VpUtEaSReTM=;
        b=jFHJ2gEr/0gyqoZwP1LOX662mQO3rjZbZ6ZrgsxMPuuKgLTTkGK6v7/a909RXlL35q
         yPp53lRlieYrNPEFTRwEACq9HvnUKoxcGt4o2YwicrZE/jsE0hbjI1Lo1G4ZqwAS4vBY
         pInWnBdczwb38m3V+mbFQ/mnC1fPexOqv4mFwEgtxakL0QgJdujpZN92r7/PN+7a78Nk
         xOFwh+0asgdiXwSpKudEryL0LkxeEOuAFdzMKbodLbVWnvUvoLcWwTvyT689U+towvvG
         qojJQLaCs6n2EfufJVJOSYNoTmejSErqrjYH6jXGnvlC57pAtGEtmcnzV6UT5EB9VjBl
         uWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8D8Zb3AbrRdlYOjMRwAdaA0keCtGvT87VpUtEaSReTM=;
        b=IxjafrxuAa6UzfJZY7VSsxsyDqfSEkYUhlO7va/2uVuOqNxnIPyOwZ1JyfdGivEM4v
         42F1vbCAKJVkPw1XRlGx6QFFWm5wdHr66x/h+wvwHLO+JRVm1+helpQc9FXbx9yLbWRR
         zCMtxWy67HD3c/x9TrnEDLwMMXTE4JArHIEjxM1pkv8HYk9F5h9nZpLCGpUKG3rHz/nu
         U085vnyB62NTZ8lsBGBhY05gt6zCEyjZngW6FVFXeupRLqaRSIPjYSaQdPncCd1wM0WZ
         bYxyVcqxZ04zGbva4FIExMCqBPjhW5tsQJ4IgxNufT3IOFm23t4Oi9c2FHWCkw8b1RGV
         DSAw==
X-Gm-Message-State: AOAM530rIwcvUolihp+F9T9uq2f1sp1d7YrFw3hRIbP71TlFaUB5x+yU
        ddaEQKflmFhL2L2r9JneKi8=
X-Google-Smtp-Source: ABdhPJxxLAJcm8pdy1HkCsFZO+90Lpf1sBnKst873AvjaTviI180lxgWX5kNsbKrq4Xr9iBzDqp6TA==
X-Received: by 2002:a17:907:2cc4:b0:6df:a036:a025 with SMTP id hg4-20020a1709072cc400b006dfa036a025mr18044123ejc.554.1651607800847;
        Tue, 03 May 2022 12:56:40 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-149.xnet.hr. [88.207.96.149])
        by smtp.googlemail.com with ESMTPSA id i8-20020aa7c708000000b0042617ba63absm8229270edq.53.2022.05.03.12.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:56:40 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, dmitry.baryshkov@linaro.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 6/6] arm64: dts: ipq8074: update APCS node due to clock support
Date:   Tue,  3 May 2022 21:56:05 +0200
Message-Id: <20220503195605.4015616-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503195605.4015616-1-robimarko@gmail.com>
References: <20220503195605.4015616-1-robimarko@gmail.com>
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

APCS now has support for providing the APSS clocks as the child device
for IPQ8074, so update the DT node to reflect the expanded register space
as well as add #clock-cells property as it now provides the APSS clock
that will be used for CPU scaling.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index dfba87f2b295..96de58fb7736 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -970,8 +970,9 @@ IRQ_TYPE_LEVEL_HIGH>, /* int_c */
 
 		apcs_glb: mailbox@b111000 {
 			compatible = "qcom,ipq8074-apcs-apps-global";
-			reg = <0x0b111000 0x1000>;
+			reg = <0x0b111000 0x6000>;
 
+			#clock-cells = <1>;
 			#mbox-cells = <1>;
 		};
 
-- 
2.35.1

