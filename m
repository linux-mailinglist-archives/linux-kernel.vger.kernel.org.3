Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA4D4E710A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 11:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358791AbiCYKUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 06:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356746AbiCYKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:20:38 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61E279380
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:19:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a8so14340888ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txfMDWQceDbgmOrEc+CTlnZSlzPPay3e29bbmFGpskI=;
        b=aY/UlNLKFcwQI01npAcjm/L7wOLzS2xJ9Zw+MT1p3HNACImlKg70WPLKtmacFC5gTb
         Xoc4FrJdHP7PQLoY0UEuhuaX5Vwyqrktj7Wa2sBTQwFhDG6gUhJ3ul8LMrL4sCHZ68sd
         l+aY4QkwQfvVu5ngmZ70I9/AhkbFbwIkCrLZqSNqZh8notZEpsidKFpSagPFlPM33Qrh
         MCCSJuO/jpN81ZAdQdvKAvnW8yjUimN2YyiH5G933lvB5D89+1LvRivokfNBdrebDj1/
         oG1UgkYqp4+32YQtoBGYC7OQstec+bwYQfqoXyQj5uTSkDt7jZ/3mDQzNEahw80oQ6vn
         pKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=txfMDWQceDbgmOrEc+CTlnZSlzPPay3e29bbmFGpskI=;
        b=SnFMW+kZMDAlF9xbISNJB/fFvJVD7wS53yOUVd1EGLrFDQeZjwOP04XCm066w4uUBw
         laGyhR/3PAKvgGXaHQhVdzX4s0plYG7tOhBhVUnuGbnksKUKfWuYA/xSo+lRoor7sWIv
         B+HU9fcE/GgNLo/3AktDG4xEybQCIkTfpXORT7Ikj4A6+50V49Tguj3y5TdjAFTyzybk
         BZuQp4TspfF6VFQIuNHRQew5mVDaw1IYI7Sz1WxraGHPu29FrPC3dNF4vRdYXPrsFriX
         3w/ajgLXpHwHH823TBZ4QZkeIr74NKfJwwnL13pvmdFkK7hBj7RuDCbDfi1K0QpxKN4x
         85hA==
X-Gm-Message-State: AOAM531lrn8WrIW02DCCN1LmNVMBApeUurKfYn7m8S4KyCwG6XKwpbYW
        3T5BQQLQEV2iLY8tQtrcRXxGHg==
X-Google-Smtp-Source: ABdhPJyIbsV/hWkQgXdZIzsB8nheQMLmBqixJtiigslgQjtIJpHte/2eaEQGBql+3YZPSHhcRqh45g==
X-Received: by 2002:a17:906:5245:b0:6b8:78e0:5649 with SMTP id y5-20020a170906524500b006b878e05649mr11152534ejm.520.1648203543499;
        Fri, 25 Mar 2022 03:19:03 -0700 (PDT)
Received: from localhost.localdomain (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id hr13-20020a1709073f8d00b006dff3a69572sm2122695ejc.5.2022.03.25.03.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 03:19:03 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm6350: Add wifi node
Date:   Fri, 25 Mar 2022 11:18:40 +0100
Message-Id: <20220325101841.172304-1-luca.weiss@fairphone.com>
X-Mailer: git-send-email 2.35.1
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

Add a node describing the wifi hardware found on sm6350.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 9ad30086cfcd..1e2810021b30 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1267,6 +1267,28 @@ frame@17c2d000 {
 			};
 		};
 
+		wifi: wifi@18800000 {
+			compatible = "qcom,wcn3990-wifi";
+			reg = <0 0x18800000 0 0x800000>;
+			reg-names = "membase";
+			memory-region = <&wlan_fw_mem>;
+			interrupts = <GIC_SPI 414 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 415 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 416 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 417 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 418 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 419 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 420 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 421 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 423 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 424 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 425 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&apps_smmu 0x20 0x1>;
+			qcom,msa-fixed-perm;
+			status = "disabled";
+		};
+
 		apps_rsc: rsc@18200000 {
 			compatible = "qcom,rpmh-rsc";
 			label = "apps_rsc";
-- 
2.35.1

