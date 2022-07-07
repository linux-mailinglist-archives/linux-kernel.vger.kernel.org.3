Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DB756972E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 03:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234554AbiGGBKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 21:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234150AbiGGBKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 21:10:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6389E2D1DC;
        Wed,  6 Jul 2022 18:10:08 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id d2so29904447ejy.1;
        Wed, 06 Jul 2022 18:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LtHOAiNlZopaglJkN3YZQP1ZzTvW1XNe+F16bbBv+9w=;
        b=DMdPnyk2HPEGpEfA7lK9rnaYMs8A5/OdCN+m1cpqJevumKvkbB8mcvooRjbN/QFrpj
         D8+8A++9ZJDPrPIsKLGqzxfC/dMT0yRy2isdp0YH0htSWKKILW5wuTMiUxJj14+V/wsp
         wL8OPLbWulNaamjwQsvKCaRcyCI5jK08I1HmswVVPzcQY8hMJ5S+ljR3HRmh2+e3/qwN
         Z3KXjUqCqpZW1T3OZvUjiUHPuLAJY3p6NaXoVrBB2qeYnoaCt+F7Li7pPj4GLoTx9hDd
         v0suJOy7RnK1AknSGXKndTsMc+oOIGZ0GEiOM+ulOYu1BRTUqpk/RT4zx3XQCOAxypav
         Zczw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LtHOAiNlZopaglJkN3YZQP1ZzTvW1XNe+F16bbBv+9w=;
        b=iZlbfFHW9EEbGQNmuSN7XQPtqPtzOucVws3ejD1rY05PYeIXGlYYVeikz2LNpLWdEm
         STXjJ0B6ymIiP/X6COm4VJg/sOL27hdBKO1orrWBBb8UNbKQyTa+RxvvFkZdiWH8vlj1
         lpoIuVdJ6XLeGqq4UpMtCx1WEt8GfeNUX5xHD2u0K65mGefxXwoi7e3xPKhzfmWqV6Et
         l0TQa/MAc5rxm/2ucYno4scoBXhVpq8kMsYvv2nIL/ecOi3KigrRKOzXwwCORmwTk34m
         Thx2IC85mNdCpb6IAe0Qema+ir4+4nI0btM379gIRQurpucqhJqFMY8cVvFwaGIGXj33
         6tcQ==
X-Gm-Message-State: AJIora8O15uW1k04t6PKQUw0JKgUTVxpEM1piG8I1x5YiaS2SrKzP9hm
        xMDb7v2clnDC6cDditoYV8w=
X-Google-Smtp-Source: AGRyM1sLckaDEU8GiRvO1p2D2lOQb5keIcvvsdtCOpHtsNA6DmdSwcn4lwruXYOkKUqpaCn02nSi6A==
X-Received: by 2002:a17:907:1b03:b0:6ff:78d4:c140 with SMTP id mp3-20020a1709071b0300b006ff78d4c140mr43610220ejc.554.1657156206858;
        Wed, 06 Jul 2022 18:10:06 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id u17-20020a056402111100b0043a6e807febsm6915464edv.46.2022.07.06.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 18:10:06 -0700 (PDT)
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
Subject: [PATCH v2 3/8] ARM: dts: qcom: add specific ipq8064 dtsi with smb208 rpm regulators
Date:   Thu,  7 Jul 2022 03:09:37 +0200
Message-Id: <20220707010943.20857-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707010943.20857-1-ansuelsmth@gmail.com>
References: <20220707010943.20857-1-ansuelsmth@gmail.com>
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

Add specific ipq8064 dtsi with smb208 rpm regulators.

Qcom advise to use this configuration but it's not mandatory and OEM
can decide to implement their own regulators.
smb208 regulators are used to scale CPU voltage, L2 cache voltage and
Ubi32 cores.

There regulators are controlled by rpm and to correctly works gsbi4-i2c
require to be NEVER disabled or rpm will reject any regulator change
request.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi

diff --git a/arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi b/arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi
new file mode 100644
index 000000000000..ac9c44f0c164
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq8064-smb208.dtsi
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "qcom-ipq8064.dtsi"
+
+&rpm {
+	smb208_regulators: regulators {
+		compatible = "qcom,rpm-smb208-regulators";
+
+		smb208_s1a: s1a {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+
+		smb208_s1b: s1b {
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1150000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+
+		smb208_s2a: s2a {
+			regulator-min-microvolt = < 800000>;
+			regulator-max-microvolt = <1250000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+
+		smb208_s2b: s2b {
+			regulator-min-microvolt = < 800000>;
+			regulator-max-microvolt = <1250000>;
+
+			qcom,switch-mode-frequency = <1200000>;
+		};
+	};
+};
-- 
2.36.1

