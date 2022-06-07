Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFDB153FB62
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241126AbiFGKeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241070AbiFGKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:34:00 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441C56351D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:33:58 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id bg6so14454337ejb.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Din8b4ZDN1HEqW7Sqe8kkBNl+yuozkXEbwel+kwZoV8=;
        b=dZfRGo6wkdJHzd6+xUGZzUGP7iGh81wHnB2LbxM97/Mlj5ykrgb9qNqWXu5yQbt1Y2
         UU6HJQ0YjNR8MKs+1wBitE7l+r7A9c7CDIjD8oMmsN4GnZ6xoyrAjvMPohHnf0lYv8Z0
         tWalXe8fHZyApWWjqeizj5V6jMJjQ2ZdvoKtctxCnBdGPnAyRhr5fNDFZgZYKnymMfAt
         1biUyTbvHAVaCeNNijSV7oqQxK7lNMDguuiGRFOBzAe+fjCyKqcYXwgDqQtLHxZ6fq2/
         tmDedTs7a6SGyRf2ziqS3LtMeMeMrB45qvOfqE+ERX/BqpHy5b+CGIxydSLQYtOTHplQ
         OGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Din8b4ZDN1HEqW7Sqe8kkBNl+yuozkXEbwel+kwZoV8=;
        b=CD9AIoKQiTDDug+coAlkGjIrXi5XQjpcCd6KQ0SCWaUdPzHS9++7ZFsKKoonTWUVmf
         KMcwk646vytZDKrFlmzUwQXD6odWdKSalohiHtuLRs38xStTRkcXRUaf5eb2I1UvdXr1
         sxKWgKBhAN34HsB/RiFlsgIDBnNp2BADrdcJn+ugrJHY3AeMhlqSLkfYA0s7zJ9C5d6i
         7ke53fp2/lr9JtN5s0965/LendpD8VBKt3LMydm4RCieDNn/Mz8I4DSYXph2rn3lWPDL
         GuuXoaEcUT8rXlSiXgeb+b4W3cnmv3EwER0z7x1dPt8AtkGwKPcySu9JM8cWfTB6BWbA
         I7+w==
X-Gm-Message-State: AOAM533dQpwl6rTKIUrQDzcD2ZdZCuHb3aPSzf3UICWX4Ywx2MdPB98R
        PD11gClyHkZUWFH58xsXjpkvgA==
X-Google-Smtp-Source: ABdhPJz+3fvEjAfKB5gT7bcoIJU5OB2vBmnwN7ro8Vccgd2VLK0R6k+Id02ZTLH7jnGntIPJmwteXw==
X-Received: by 2002:a17:906:40c4:b0:70a:5d82:4e68 with SMTP id a4-20020a17090640c400b0070a5d824e68mr26220526ejk.172.1654598036835;
        Tue, 07 Jun 2022 03:33:56 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x4-20020a1709065ac400b00704fa2748ffsm7505359ejs.99.2022.06.07.03.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:33:56 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 07/10] arm64: dts: qcom: qrb5165-rb5: add function and color to LED nodes
Date:   Tue,  7 Jun 2022 12:29:28 +0200
Message-Id: <20220607102931.102805-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
References: <20220607102931.102805-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add common LED properties - the function and color - to LED nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index 0e63f707b911..3b480b9a9fed 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -5,6 +5,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/leds/common.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <dt-bindings/sound/qcom,q6asm.h>
@@ -59,6 +60,8 @@ leds {
 
 		user4 {
 			label = "green:user4";
+			function = LED_FUNCTION_INDICATOR;
+			color = <LED_COLOR_ID_GREEN>;
 			gpios = <&pm8150_gpios 10 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "panic-indicator";
 			default-state = "off";
@@ -66,6 +69,8 @@ user4 {
 
 		wlan {
 			label = "yellow:wlan";
+			function = LED_FUNCTION_WLAN;
+			color = <LED_COLOR_ID_YELLOW>;
 			gpios = <&pm8150_gpios 9 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "phy0tx";
 			default-state = "off";
@@ -73,6 +78,8 @@ wlan {
 
 		bt {
 			label = "blue:bt";
+			function = LED_FUNCTION_BLUETOOTH;
+			color = <LED_COLOR_ID_BLUE>;
 			gpios = <&pm8150_gpios 7 GPIO_ACTIVE_HIGH>;
 			linux,default-trigger = "bluetooth-power";
 			default-state = "off";
-- 
2.34.1

