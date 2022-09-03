Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852615AC064
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 19:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiICRnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 13:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233411AbiICRnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 13:43:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8A459277;
        Sat,  3 Sep 2022 10:42:48 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z2so6554812edc.1;
        Sat, 03 Sep 2022 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=JDrZS7nIxZE+ezQqB81Z1cPB0fQz6+CPtIEDV16ecMw=;
        b=AVzRfZ9j/eRqoXzbxolv+ggxe31oc4gKut1Nq33z4jpIR8ujsD5kQoN834UgXTJ/ES
         Bl4vOPHPwfUEjFkHbVRSEA284eAFIEKrwxok2Y9X3ebrba2DXJDe4irtL/9Bce7740PB
         CqxoZPGFzM3i4FlWijZX+YtSZhpUTWHCf1u3tlyMMOWaSjCNB+AFI2emLRUV2+Twx0WL
         UIi4Cy87N3Tzyy/CSFsyhoJANzdoPrrcWDy1U/udM3XJVX26QYgAUPifVmbVGxsLWKde
         BqhA7ZKNgc0HgfpL4OZfSFQ6179Wyn/Hl66i5jF/SPicwiTBQzXLFRM5PHm6lzFltPdn
         tOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=JDrZS7nIxZE+ezQqB81Z1cPB0fQz6+CPtIEDV16ecMw=;
        b=qakdGto/wGvjAEu8e9+uGjDCDwBXgu6AN/5ctpx58dz6ipPfC0JBFAFouqiWllQg0l
         p4TVq5kpO+gBPZyZksmqH0ht1kDqc0Iiq+h05HRKrvbk3oTSyVh5HhciTGuGHaEfkuel
         S7hcjYjQv3Oq9ZkUWjJO872gOr3MwntbFNos5i019e2cJZ7wtvswQZi3DK7B8bvmU6k7
         NF7v82bdMVIMXuV2eRZQ5HEUOpkG13aGg4w7gQv/nve3SSACDJHQqN06OtxNQUQzcbOh
         2hqyhn2EdiAeGlXQ9OWiZFeaYpFpRhDjHm+3miT+l6YIksdwzBg0RNFAAw7b/MQWP0Dn
         LBDw==
X-Gm-Message-State: ACgBeo0VDh23kS1mhnVdBNT5X50eMV1vcXTRPiKh3mXU2fTq3/9UIKGu
        nADi73XuuG7HVHEObTkenUw=
X-Google-Smtp-Source: AA6agR7rZxBLaJOlCb8oRCon6utgdm+qtDeuPaDcZLyHw081QlQAVTq2hfU97I/7JbRB2c9HBkbAuw==
X-Received: by 2002:a05:6402:517:b0:447:ebb2:1f2c with SMTP id m23-20020a056402051700b00447ebb21f2cmr32629085edv.283.1662226965222;
        Sat, 03 Sep 2022 10:42:45 -0700 (PDT)
Received: from localhost ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id j2-20020a17090623e200b0073d638a7a89sm2757799ejg.99.2022.09.03.10.42.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Sep 2022 10:42:44 -0700 (PDT)
From:   Iskren Chernev <iskren.chernev@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/9] arm64: dts: qcom: sm4250: Add soc dtsi
Date:   Sat,  3 Sep 2022 20:41:49 +0300
Message-Id: <20220903174150.3566935-9-iskren.chernev@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220903174150.3566935-1-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com>
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

The SM4250 is a downclocked version of the SM6115.

Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
---
 arch/arm64/boot/dts/qcom/sm4250.dtsi | 38 ++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm4250.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
new file mode 100644
index 000000000000..8cadf813e55b
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
+ */
+
+#include "sm6115.dtsi"
+
+&CPU0 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU1 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU2 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU3 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU4 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU5 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU6 {
+	compatible = "qcom,kryo240";
+};
+
+&CPU7 {
+	compatible = "qcom,kryo240";
+};
-- 
2.37.2

