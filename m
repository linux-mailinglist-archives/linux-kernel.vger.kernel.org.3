Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376415531A3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349796AbiFUMGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348773AbiFUMGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:06:47 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0C92B24C;
        Tue, 21 Jun 2022 05:06:46 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id h23so26978178ejj.12;
        Tue, 21 Jun 2022 05:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIvJMdQn/cBqnDvtzgtOjH4SsP+GQUhFYvsFWjOXHDM=;
        b=H4kXQ+xTTa/Hyrvi3hVFraWBPj3KNV91Iwe4g19INSDVkUZoBtwsfhYckycQaeHeUA
         rhDkA1kCmys5yWumgOaVBhNG7xoVxhWi1n4tJSxW5SHcnuRwqOj66mR3YqWcE5zJ+Xy9
         bnnVZZwiwI94wCBYxCxsrEUosmdZOSspJyjFLIfyJB4w+1UloI93LzyrcYFCXx8QV7qd
         WaNkPb51ohVK3enSaP+7T+yrs+BgoljkXhUGRad5/j738lWnU20PwXVRXBm80M/F0leM
         5B3CULjnt2390435dTSUKcxenn+IY90G/dJa6D9hUb5O1KOZbreX2oQEX+kiCbbAcy+U
         GZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uIvJMdQn/cBqnDvtzgtOjH4SsP+GQUhFYvsFWjOXHDM=;
        b=xD8sB97tJ6yA9e4nbLkNfL0NWsZXXw+Upw4p/r1QImw1oYBrX2AoNS6080P49scIKd
         8aRlxki9eEp5uGtd9qIVDfJsAUE8jC6aLklMrPHErDCwvuVsLIBN19oic5M1loQRVwm/
         +TxhSSL2bcxE0opIFgJVeZV9qyang28zyi8mhVbZcrtyRLb96kZraos6sNrxPfbQ/VXV
         SUXN59dnQlSO3jFaxIPDTR4u8vcUCcI/PZq6pjb67YK9kqJ2HUY7Zr8Xh9jE5rINUMtB
         h9TjgJz32SyH5r1jJ0uwubm3HpYkZxPpZ3QmXAA/jFKMZ0jaMIU/LMOFXgSOtlO/3znZ
         kBkg==
X-Gm-Message-State: AJIora8JWtiZoLW0F/ppH2CxN/vjDqTmHai3I5iB6Jj/6cuss7DvvZEb
        iVBIFdczVDDM+G1VrrTLI0A=
X-Google-Smtp-Source: AGRyM1so+nJD+Zkt6+BQ3wIJ/ZbCHw1Klgyeljh6VxhoKuOnqeWAvQtHFPAeC53G98CI38TjB5TqmA==
X-Received: by 2002:a17:907:1b0d:b0:6ff:22a1:d58a with SMTP id mp13-20020a1709071b0d00b006ff22a1d58amr26604955ejc.293.1655813204987;
        Tue, 21 Jun 2022 05:06:44 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-99-158.xnet.hr. [88.207.99.158])
        by smtp.googlemail.com with ESMTPSA id b17-20020a1709063cb100b0070b7875aa6asm4798424ejh.166.2022.06.21.05.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 05:06:44 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH] arm64: dts: ipq8074: fix NAND node name
Date:   Tue, 21 Jun 2022 14:06:42 +0200
Message-Id: <20220621120642.518575-1-robimarko@gmail.com>
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

Per schema it should be nand-controller@79b0000 instead of nand@79b0000.
Fix it to match nand-controller.yaml requirements.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 34f79860b3c5..7e683aec3ab3 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -736,7 +736,7 @@ qpic_bam: dma-controller@7984000 {
 			status = "disabled";
 		};
 
-		qpic_nand: nand@79b0000 {
+		qpic_nand: nand-controller@79b0000 {
 			compatible = "qcom,ipq8074-nand";
 			reg = <0x079b0000 0x10000>;
 			#address-cells = <1>;
-- 
2.36.1

