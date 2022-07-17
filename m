Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6227F5773D4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 05:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiGQDlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 23:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbiGQDlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 23:41:45 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8674E17E06
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:41:44 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1013ecaf7e0so15683062fac.13
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 20:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggBVtzxfc9gc43RAMioxkqR/MfmXRvl4PuqTnwzIFs4=;
        b=nnFInGpvhtMgMoFYmiSyHkh4yOHx2iqbMPzgAJF7RZGu9q2nvbbFk6EzhzpHmQLpof
         GCmXyEVDt7DGPAQ9z5wmrgkLs4rc8AzQUja51kpYQpDTRLj3FVsHzNTuiiHqA6xBbDkV
         KbGCauvaWZbkLrH3Cqd/d7RmXgd6+V8FCCcYXGZnf4Ta6Q+UHH9F4vvrDMEJ9V4uLlI0
         C61VBmkeSdyTYwiyiRa8Lvg3ok3Z8AJMXxFOtoe58LXGSC6fdzgm4n88MthkOvBKIYCC
         tOJSSBjTwZaTP9J7oZ0GjGwzDXx8h2OijofRSlxu/+EeA437S0Hzm10zJlvgglxZWt5g
         y6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggBVtzxfc9gc43RAMioxkqR/MfmXRvl4PuqTnwzIFs4=;
        b=ShosBxfjLEj/3In2rW+qnpGGzDXrURZEzKvYznukn1lGojDR04A2IvRCi1mD2vh/lx
         Mhiu3v8urTxklPnau16y59GUCLytKkr6Hvo/gn3lerquFuAmbi9nrfrGFsy6FQfyhCr5
         2wFabIl4vEKEfSSX79wV3ZSV/IJO/PbUZARhIpzD29xy5ATBFbLFIgsKW3Ni2IO3pkLs
         ZXQkNJyPAUk40X16zmFdFiFToPjlbwYd2q9nS9tzDUGZ+aDm3qeP+14t5wP6CTEdUFay
         /Mxf3h55jOLpdpJk8UUrVChblt6tnNeEol6/KuDRUTFlUFm2aOll7W8Iz1mMUSos1m+i
         yvMA==
X-Gm-Message-State: AJIora+TcYVaVqrJqri6kTs4AdJ4EqWbLzKBbYj2NYkdUzSn24bpXKEh
        rhnfFRemxnkZjN4bpKm7dNCV1g==
X-Google-Smtp-Source: AGRyM1s9Y4oC++J82QiJHGQT9GtjH9tSZoHv2WuJ0KoGK9344yvhIbM/XX0xNyKJgtOB6tRS2HjSdQ==
X-Received: by 2002:a05:6808:1913:b0:338:87ef:40bb with SMTP id bf19-20020a056808191300b0033887ef40bbmr12753464oib.221.1658029303843;
        Sat, 16 Jul 2022 20:41:43 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id p4-20020a544604000000b00326cb6225f8sm3218010oip.44.2022.07.16.20.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jul 2022 20:41:43 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, vinod.koul@linaro.org
Subject: [PATCH 2/3] arm64: dts: qcom: sdm845-db845c: Enable gpi_dma1
Date:   Sat, 16 Jul 2022 20:44:02 -0700
Message-Id: <20220717034403.2135027-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220717034403.2135027-1-bjorn.andersson@linaro.org>
References: <20220717034403.2135027-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable gpi_dma1 so that i2c14 is able to find its DMA controller.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 4afdb72cc556..62ad67370d2b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -443,6 +443,10 @@ &gpi_dma0 {
 	status = "okay";
 };
 
+&gpi_dma1 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 	zap-shader {
-- 
2.35.1

