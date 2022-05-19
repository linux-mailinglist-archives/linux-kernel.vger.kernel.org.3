Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA2952D40E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 15:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238872AbiESNan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 09:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbiESNa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 09:30:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B611B0419;
        Thu, 19 May 2022 06:30:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tk15so9972807ejc.6;
        Thu, 19 May 2022 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nnXQ24MHN2s21yoIiJmbq+R4rIpFZ2OhNfmhoVvOlIo=;
        b=AIgqK3hPbm+oeEIPn9Pqo7jedMzkYkjM9nxtKSHkdLbqp3CIfUZYWmDfWcgwBnfIS4
         SP5D/aE9q5n8XQ9EUdTQ+bXZw1087BEvl9XMN6tH10PWkT4CRu2szi5MrS03RLzjQqgy
         HohMB1iQKIJgQ93FCQQOIwfMeXpRFvTMaSIEgRw/Z6gkQIKl9DV2aPJy0gNHJKo5CVQX
         Q9U0rc3O18uTepcfBXSd0PrDJjCYagErZO424gkoE9iF2JZ+e54d5phLRl0aOCA5SEPW
         ndzXhxtLQj3Hnrz9OFnntK1FfxPPpJuDgYVeQ5+amSQ17jB7ikwE6Fh5SD7HLJ4mwELZ
         Hd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nnXQ24MHN2s21yoIiJmbq+R4rIpFZ2OhNfmhoVvOlIo=;
        b=iZE1UcOC1HRQ4brN5l92/iGN/TrxwFSbYaYaRyKqJKHlU4fE9h/f/CCvgWcWDlXZcZ
         1SQa+77O6Nx3/9+FWxsfdMCaWg+hwDaE8qgqpCzNnYksCK8jeGjUgwA7yXjie0NmrHDU
         tYpHatB+eRXvrR+MzqeWmGvehozTwNsn9utLsiAbcgWWa/HDcTgzPwSQUpdCYW6X2hKK
         xvaVHkwE+GmDcfhL8QgKnvzMLlNprX2dDf0NQCC87/EB3Ur2O/ygT+9Cfi55iY/VYamK
         AgWj5MutkLl1wMUESUxndUq6ayX/5rZUOvVeS4d637+Vc76a9x8ERWLGgH9e2gSD56Ap
         g1hQ==
X-Gm-Message-State: AOAM533X6UI6f953z9ldvhtkU/xZfjtn0Lf42vOyXSy3ldxrdisDcnn/
        KQw4WgE59USeporfaqN9pkBQLmalaf9UNg==
X-Google-Smtp-Source: ABdhPJwyIlx8ju4DfUtd8SquiZ70oz/dJ3z1Z31qIExGBEe+IyidvnoezAvjlCsPj83zrEKQC9O7fA==
X-Received: by 2002:a17:906:6a22:b0:6f4:a226:40d6 with SMTP id qw34-20020a1709066a2200b006f4a22640d6mr4230784ejc.657.1652967025010;
        Thu, 19 May 2022 06:30:25 -0700 (PDT)
Received: from fedora.robimarko.hr (cpe-94-253-165-71.zg.cable.xnet.hr. [94.253.165.71])
        by smtp.googlemail.com with ESMTPSA id y17-20020a17090614d100b006f3ef214dd4sm2120383ejc.58.2022.05.19.06.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 06:30:24 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@somainline.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v5 6/7] arm64: dts: qcom: add PMP8074 DTSI
Date:   Thu, 19 May 2022 15:30:14 +0200
Message-Id: <20220519133015.484639-6-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519133015.484639-1-robimarko@gmail.com>
References: <20220519133015.484639-1-robimarko@gmail.com>
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

PMP8074 is a companion PMIC to the Qualcomm IPQ8074 series that is
controlled via SPMI.

Since we now have support for the regulators inside of it add DTSI
for it.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v5:
* Remove #address-cells and #size-cells as they are not required for
regulator subnodes
* Add mising whitespace to compatible after =
---
 arch/arm64/boot/dts/qcom/pmp8074.dtsi | 36 +++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmp8074.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmp8074.dtsi b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
new file mode 100644
index 000000000000..7b3c9fe705aa
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmp8074.dtsi
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmic@1 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+
+		regulators {
+			compatible = "qcom,pmp8074-regulators";
+
+			s3: s3 {
+				regulator-name = "vdd_s3";
+				regulator-min-microvolt = <592000>;
+				regulator-max-microvolt = <1064000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			s4: s4 {
+				regulator-name = "vdd_s4";
+				regulator-min-microvolt = <712000>;
+				regulator-max-microvolt = <992000>;
+				regulator-always-on;
+				regulator-boot-on;
+			};
+
+			l11: l11 {
+				regulator-name = "l11";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+			};
+		};
+	};
+};
-- 
2.36.1

