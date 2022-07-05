Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A355670A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiGEONb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233672AbiGEOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BAD21241;
        Tue,  5 Jul 2022 07:07:06 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id d2so21893482ejy.1;
        Tue, 05 Jul 2022 07:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8POPGOoalJEDoVB7FyeJm3aaNudn+ZEBs/q1mdYbxo=;
        b=dBl3IeRm8p+6yFyU/KO66pMGGN3AvwjxO9U3ySsBl9VzQVOqKVjThdEdGaoI9Wn8sX
         8TYfGquDfN9ZnPV1gxFpaKJe5ihkOaSCiYErwf6SnG/wDSMTSTWE0j3CG5KKpsLy2VVK
         Las1HeM/i+4DI66FegpBArF+XUl+FuJJd/bJOrW1wUIHumx2mu8KK0GDhJJKx9bRQDMi
         J0twGMvsr4HWnotGH9afDf9fIeOZXU1YdJYv8w+FD15u+QrbHQJsueoYWDz2YpzCC4kN
         6bP6T2PbExFUQf8b51vdPGpobE+YhAzxqKQAqR8n8V8Rqi8bIniFNFJr4wHaTsvABgoA
         8+Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8POPGOoalJEDoVB7FyeJm3aaNudn+ZEBs/q1mdYbxo=;
        b=XJH/ulyGqSIz+phOmfFTcKK1FPhrfFC4qlgbKpkSi5fhUaQ9Y70dl40BmKm6QpCDRx
         tMci7mBB47AZpOuCEwyXbOxgLdV7KmvvNI8F0Z/TaMVj7cqadAbNd+XbVm3NQDMQO3u6
         JDTtM3z8GLKaePUH0SJ3CN2fV8orsM8y13/PRP2XsVBKjTVG55NRfesipe6SbqL1xMzU
         OztkW3oX9SgJUa4QB0Dt8PzySk689opW4aL6jetOJ3sx4kRIHch4lbxc63a0SA25kOLJ
         NI5Gke6UKhzIB0HCBqZ6xnvERZvoAQWqbsv06VYLzN+RDmFyXOcnneSsdflstjsXHEE3
         SWow==
X-Gm-Message-State: AJIora9EupA6d0Tge4Eg0WyNipj70AHnXuPJ1hj735HQxSDW3vx+Qv50
        MpEFb7byWyLB74oVXaxZals=
X-Google-Smtp-Source: AGRyM1uYu3lz97knSinfL+8eoA6sbRTTd21mV21TDnA7+5qVm50KcAEbrDSiyK4zU5SdIeS1MhFgrQ==
X-Received: by 2002:a17:907:2d09:b0:722:f0bf:ac26 with SMTP id gs9-20020a1709072d0900b00722f0bfac26mr34532638ejc.77.1657029992760;
        Tue, 05 Jul 2022 07:06:32 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:31 -0700 (PDT)
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
Subject: [PATCH 04/13] ARM: dts: qcom: disable smb208 regulators for ipq8064-rb3011
Date:   Tue,  5 Jul 2022 15:39:08 +0200
Message-Id: <20220705133917.8405-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705133917.8405-1-ansuelsmth@gmail.com>
References: <20220705133917.8405-1-ansuelsmth@gmail.com>
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

Mikrotik RB3011 have a special configuration where the regulators are
not the common smb208 controlled by RPM but they use a TPS563900
controlled via i2c. Disable the smb208 for this specific device.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Jonathan McDowell <noodles@earth.li>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064-rb3011.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
index 9034f00f2bd8..f651e813d75a 100644
--- a/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
+++ b/arch/arm/boot/dts/qcom-ipq8064-rb3011.dts
@@ -218,6 +218,10 @@ led@7 {
 	};
 };
 
+&smb208_regulators {
+	status = "disabled";
+};
+
 &adm_dma {
 	status = "okay";
 };
-- 
2.36.1

