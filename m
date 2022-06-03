Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C5B53C7D9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 11:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbiFCJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 05:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243178AbiFCJrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 05:47:22 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0913D55
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 02:47:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so14901832ejk.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 02:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmlvkluiSNMj24D7hJPq2KWkb3UetBzXUSitChCIpTg=;
        b=RaqsjKpGbIoD8x44wAMevrMZhgC+gxnWT0bU2purC+/B0SEvyuWziiWNzzZQiDANlb
         NL/SOkwOyYwSdhKUQLFosatZsxO0Z1mm701fBAXkXqQ+YLRGmXqMRg7cr7Fqgfn/FQ4G
         Cx/d5mnDae60/QIGBwN13vBST2fv/231WUzkzD5zbuP3mquwvpPA6iCx0hvw/otlgrZB
         pTsPP37CZ1LWuh1Y9nqvmaDG7xT4zezrllKvI+HYxgsQO8kA2ZLDWdxL5ULORQrUT7dd
         ZoAm/LU6hGQ/UegRhUhh/erylJ1s9DTCfaHGq8v9oI+QNUGtC+W6/qnL2542z8065uCJ
         9DBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XmlvkluiSNMj24D7hJPq2KWkb3UetBzXUSitChCIpTg=;
        b=h/cjbDyaLRFfaESauwZusG6tTEpOKuxinI9mSU+n3x5lvTRw934Z3dxmHFAkWneSrf
         OOqywKn8WI0cNO694YWUQzSXnmetqIeldEBp+QGiUwdgDyJJksRcgPBBFrRB1BwDbjSb
         OicWut543nen6QTZBxO1O6xNtf/2yhw0E5qNfC/NoogKX/wlDo70ceaKLt4anpdRLd1j
         A2+XQBnpR8SXS6U/dxIRtfGf6zEOoZqxgbNPvgC8RgCB51zKS8jqUxJ/aLT+nvJONY5/
         FlwbKrNSS1YUWB/nlRdN4+J1Q+K2NwzcMRaa96Tcl/SOBeYlTUs/RBbqZLC0ChEBgpVe
         l6XA==
X-Gm-Message-State: AOAM530jfCsRdnvBftHBOk3uPp6evg5tzsdOekvYX0GUH5qxNbfkmON3
        /Ih1G5ufp+cnkv/57r5FyHFkeO1i+3er/g==
X-Google-Smtp-Source: ABdhPJxu2JHMNp3Ryhwmps+2Sr90KjZ1hzGL9fUOJkh0TNMfX3qkXqH1irY9IA+R8Yq04ByvZ1ZEFA==
X-Received: by 2002:a17:906:6a27:b0:708:1282:cbe9 with SMTP id qw39-20020a1709066a2700b007081282cbe9mr8052825ejc.186.1654249634363;
        Fri, 03 Jun 2022 02:47:14 -0700 (PDT)
Received: from otso.. (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a15-20020a170906274f00b006f3ef214e42sm2661009ejd.168.2022.06.03.02.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 02:47:13 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845*: replace i2s reg with constant
Date:   Fri,  3 Jun 2022 11:47:09 +0200
Message-Id: <20220603094710.64591-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it easier to understand what the reg in those nodes is by using the
constants provided by qcom,q6dsp-lpass-ports.h.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts             | 4 ++--
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts           | 2 +-
 arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 0e63f707b911..f627d6b7311b 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -830,7 +830,7 @@ &qupv3_id_2 {
 
 &q6afedai {
 	qi2s@16 {
-		reg = <16>;
+		reg = <PRIMARY_MI2S_RX>;
 		qcom,sd-lines = <0 1 2 3>;
 	};
 };
@@ -838,7 +838,7 @@ qi2s@16 {
 /* TERT I2S Uses 1 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@20 {
-		reg = <20>;
+		reg = <TERTIARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 194ebeb3259c..2fbb8b024646 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -609,7 +609,7 @@ resin {
 /* QUAT I2S Uses 4 I2S SD Lines for audio on LT9611 HDMI Bridge */
 &q6afedai {
 	qi2s@22 {
-		reg = <22>;
+		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0 1 2 3>;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
index d88dc07205f7..7dd103d1ef6f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-xiaomi-beryllium.dts
@@ -339,7 +339,7 @@ resin {
 /* QUAT I2S Uses 1 I2S SD Line for audio on TAS2559/60 amplifiers */
 &q6afedai {
 	qi2s@22 {
-		reg = <22>;
+		reg = <QUATERNARY_MI2S_RX>;
 		qcom,sd-lines = <0>;
 	};
 };
-- 
2.36.1

