Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295CE5670AC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiGEONk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbiGEOMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0853033E;
        Tue,  5 Jul 2022 07:07:19 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y8so9686373eda.3;
        Tue, 05 Jul 2022 07:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALHV+/iLZs2nffxTGCRHNUI4guHcb4svQkIg5UgcKsU=;
        b=E8GtxnKvapahRH8ZdterhezeDhj8eFddVxsqIudi0MEay+93aHzm1wmC6VNTKW8uc+
         pKk2vyflaLfbmDPEqVMga9C99UFaeFGxumtQgKgy9nO04UOnf6UUmmvS3WHKmBem3QIK
         63OQoJgPtA4Z5p6Fdmr6/rg12o8UYDhXWrM/g/N6zBmobd+DKiH5npSTqJKM4WUy21yc
         nusZ0+U7dOchyoPi7tKc8STaQtFkYu/yhYbBQLxD3oSCap1qKH6ikyj/U6rEq7P7QpHJ
         2oji9+7g+iUm9md3t90uPAUMq6762E5fi3fxCdta//pDEHXIkLZHVbTIhcWqO1zVqHcT
         VloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALHV+/iLZs2nffxTGCRHNUI4guHcb4svQkIg5UgcKsU=;
        b=whEhBSCYxIux5dl4EYoKnNjxavlXP0niStNdB4CbkEkFXsU2ocM1qges9US4x6NE5L
         7uvYqnp3glvSnkyYfLe2jS8bp4OnoM5drdxrcWKmzIblVLPUwxhq2EPJCw4VyMv91yIm
         ojaANMUBtjxIvylEODSoePlxED5F6LkcxPpHBQSe79jbqiS4xP/YWOWg372F+CxgsAef
         m2Js4JgxTd6qBG+Y9fgrmxm49lhKp+FRFsH7qQ9AQnePNXsKQ27lIXNrnR9CWaEipiUE
         KysNavmsLNj/kb7SVyigt6PtLF0L4h4wFifHDcGH/VXhO4d7cp8ELgN1iH1Y28A+l8ql
         fTSQ==
X-Gm-Message-State: AJIora+VUOK2RQVqF+ygYwSjTlXx9+idBTRIoZXzt9W/DpXLfQOQcOmu
        /MLlTAFqf20rwXYlJAH6XZk=
X-Google-Smtp-Source: AGRyM1twU8jHFfh4rNoYRNv0V9m04ao+wqd/FGotl5G6g3iluwWfoRQVCmH6fQB7QqA2MrNZn65lzA==
X-Received: by 2002:a50:fc9a:0:b0:43a:5475:8916 with SMTP id f26-20020a50fc9a000000b0043a54758916mr14768594edq.155.1657029999391;
        Tue, 05 Jul 2022 07:06:39 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:38 -0700 (PDT)
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Christian Marangi <ansuelsmth@gmail.com>,
        Jonathan McDowell <noodles@earth.li>
Subject: [PATCH 10/13] ARM: dts: qcom: add sic non secure node for ipq8064
Date:   Tue,  5 Jul 2022 15:39:14 +0200
Message-Id: <20220705133917.8405-11-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
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

Add missing sic non secure node for ipq8064.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index 98527a7d885e..ef8faee6dfd4 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -543,6 +543,11 @@ saw1: regulator@2099000 {
 			regulator;
 		};
 
+		sic_non_secure: sic-non-secure@12100000 {
+			compatible = "syscon";
+			reg = <0x12100000 0x10000>;
+		};
+
 		gsbi2: gsbi@12480000 {
 			compatible = "qcom,gsbi-v1.0.0";
 			cell-index = <2>;
-- 
2.36.1

