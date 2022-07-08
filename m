Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F82256BAFE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238376AbiGHNi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiGHNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:38:53 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DDF275FB;
        Fri,  8 Jul 2022 06:38:50 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b11so416007eju.10;
        Fri, 08 Jul 2022 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PfwS4GGde9mWJV/0ULh/19pUwGMjrZxv0owgG9wqUNk=;
        b=X5Lw9rsmvSRSWD0YiP1xPs5KDgIX/IOsTpwzeytS4Xfo8HFc38JTK17a9eTiRN+Mux
         XAVEFe0OXf230oHIKZXEw8bPYMd2Lovovh7BtZR/gZXmaSb+7AYhlyU03pEMN/iwozCL
         fcSRNERgX5oKg/5ZdZudryEezOiRDVBGz8vns8yISFSOwmCLHmVFUCrd0iy4q/Y8E8rj
         C753NashyGZIZnCiON7DTmGr/bFpU4bVKZQH1B8QDtBF+oSHJWOV94blOm9IlMKV2ZiN
         ZCte/HKBeUTlwNPF5XCYIomq0Pq4c3pNCuusSj/HiTKIvb81VZSZETA2LHBeApaUtrfS
         BP5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PfwS4GGde9mWJV/0ULh/19pUwGMjrZxv0owgG9wqUNk=;
        b=QbRgb/1IGOy/1rOMRDWVlszhXgvDEpCjYnwQMHRzQMvg1mpCRxHCcBE1nH7ra1gnfv
         FkYAZhXMeZBa7COpOaMoyNSuNcCnW5nk3i03+9s2bsiptQFTToH3NQ1Re0BX7vWu0NN1
         Q/waKLvXXRbDMj1Nb/L6Rn3YtHceQJRymIxqcil81VF63N6jYQv/HEoEQZfuSmFkpNzU
         drNSI0UKBPfmXOSwZ6oLi+1ypfzqRfS7+hrTDlE5IKHkkRcfH/J/fB7wljqxlFdo2FKT
         QIZZgEzFX0d4D0AXuF/xfl8zts4/3bntuvl6/XCScHcSYoBlrv4tzJOuK32shyxb63qC
         6TDw==
X-Gm-Message-State: AJIora/VF4z5hczwbgPXKH4ApyS+RCTjQqCkDKAsBT/5ux3jGHBpt3xn
        uFM0FkGWe9ufRF7/jSmV1B4=
X-Google-Smtp-Source: AGRyM1tVx21c/odUuQlbedhO7DAKKPjC5OODlvkhc4H5byEROgd+PIldd4maYHhM0MHdnlfjFUwpPA==
X-Received: by 2002:a17:907:75f3:b0:72b:1cde:2a00 with SMTP id jz19-20020a17090775f300b0072b1cde2a00mr3626863ejc.147.1657287528982;
        Fri, 08 Jul 2022 06:38:48 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-96-250.xnet.hr. [88.207.96.250])
        by smtp.googlemail.com with ESMTPSA id d8-20020a056402000800b0043a71c376a2sm9583016edu.33.2022.07.08.06.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:38:48 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH 1/2] arm64: dts: qcom: ipq8074: add #size/address-cells to DTSI
Date:   Fri,  8 Jul 2022 15:38:45 +0200
Message-Id: <20220708133846.599735-1-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
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

Add #size-cells and #address-cells to the SoC DTSI to avoid duplicating
the same properties in board DTS files.

Remove the mentioned properties from current board DTS files.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts  | 2 --
 arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi | 3 ---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi      | 3 +++
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
index a73909a24935..9dfa2eefef29 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk01.dts
@@ -6,8 +6,6 @@
 #include "pmp8074.dtsi"
 
 / {
-	#address-cells = <0x2>;
-	#size-cells = <0x2>;
 	model = "Qualcomm Technologies, Inc. IPQ8074-HK01";
 	compatible = "qcom,ipq8074-hk01", "qcom,ipq8074";
 	interrupt-parent = <&intc>;
diff --git a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
index ce86d9b10d69..c67181b173ca 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074-hk10.dtsi
@@ -7,9 +7,6 @@
 #include "ipq8074.dtsi"
 
 / {
-	#address-cells = <0x2>;
-	#size-cells = <0x2>;
-
 	interrupt-parent = <&intc>;
 
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 83f42e21ff43..73e7e9aad194 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -8,6 +8,9 @@
 #include <dt-bindings/clock/qcom,gcc-ipq8074.h>
 
 / {
+	#address-cells = <2>;
+	#size-cells = <2>;
+
 	model = "Qualcomm Technologies, Inc. IPQ8074";
 	compatible = "qcom,ipq8074";
 
-- 
2.36.1

