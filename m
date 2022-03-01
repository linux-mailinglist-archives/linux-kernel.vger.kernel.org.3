Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6364C9785
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238501AbiCAVGg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:06:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238493AbiCAVGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:06:34 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1F980918;
        Tue,  1 Mar 2022 13:05:53 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id 12so17326861oix.12;
        Tue, 01 Mar 2022 13:05:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RvUrcGP8pCw7/TJMLynhh/rdscHRsNPdrB97IkHL8q0=;
        b=yPQQmx9CPyt+QSPRMvhr3hcivOFoT0jyTLMvFJxNXqMdNhCCBXQvyP78efiRe4Ma92
         D147ChcqCwAMCxYLCbCTfU7ALUk3VOq14SNEY1+Ha75qbAwILPRMnFiJtb8fZ8GH+xpc
         qxGcOOGBIaHHR253UdUqHxkpXsFR32/WeZ7XQQDXRJBedZAw3dkRjHL5qUzFEn5TwIVt
         aHVSSqzMR56ryfvahmsxxZoe24hlcRgQyGwHYgeR+d0Yk08Ba3xPkBZ/L5VCk1vyA3mE
         bK/89l3Pg19bya5e7BDIjXiCRgjabz5qS9jncey7mXxjb9VEmBQV7L+L5x6V8X17yR0k
         ch9A==
X-Gm-Message-State: AOAM5314RKn3RV4MeXKaYA4xW+Bp77RKmR66zpmG8NSVIZaeUhem9NVu
        4d6X82sZqN80+uhzPpHUyJrnbDgwtw==
X-Google-Smtp-Source: ABdhPJzuQhIRL+QqzYUla2hA8rWAddBqg7GKDV6d0BlgudpZHElfBHDWQ9f4uiTcneDeQz9SzvroPw==
X-Received: by 2002:a05:6808:d4c:b0:2d7:eda:dd3c with SMTP id w12-20020a0568080d4c00b002d70edadd3cmr15054429oik.73.1646168751246;
        Tue, 01 Mar 2022 13:05:51 -0800 (PST)
Received: from xps15.herring.priv (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.googlemail.com with ESMTPSA id l10-20020a9d708a000000b005af3e65ce95sm6829737otj.70.2022.03.01.13.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 13:05:50 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: Drop bogus interrupt flags cell on MDSS nodes
Date:   Tue,  1 Mar 2022 15:05:31 -0600
Message-Id: <20220301210531.1855709-1-robh@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MDSS interrupt provider is a single cell, so specifying interrupt flags
on the consumers is incorrect.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 41f4e46e1f85..a6bf04780667 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -4281,7 +4281,7 @@ mdss_mdp: mdp@ae01000 {
 				power-domains = <&rpmhpd SDM845_CX>;
 
 				interrupt-parent = <&mdss>;
-				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0>;
 
 				ports {
 					#address-cells = <1>;
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index fdaf303ba047..e732e3370c75 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -3200,7 +3200,7 @@ mdss_mdp: mdp@ae01000 {
 				power-domains = <&rpmhpd SM8250_MMCX>;
 
 				interrupt-parent = <&mdss>;
-				interrupts = <0 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <0>;
 
 				ports {
 					#address-cells = <1>;
-- 
2.32.0

