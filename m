Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01FF5670AB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:13:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiGEONh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233681AbiGEOMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:12:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8B5D46;
        Tue,  5 Jul 2022 07:07:11 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id d2so21893646ejy.1;
        Tue, 05 Jul 2022 07:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5OS8iU7ckkLSHaqIlbeZBVviyMeZBZWBd3YMMJ6ry8s=;
        b=ITXSjr6Hx9JXRQKMyllhYYZzuJ1REHHD90EP3obKhtLGFRZNWMWQqZnLw2JnLRQT4A
         /QHKlHBp1arBKI+k172O52LKDqCh0oUesKoY2gcpTkRjPbn9hUUL6wEkhkpwrNU+lrFO
         G4erj7vXKZ7rb755akVNGI29habKFdPXpESfvubP7iEchUUE2JmiNzZ7X9ADxMsLd9Dq
         Ts2CPmITFPNmnFz+8ogLP1dpUYJND72e0jx9gSYWGwD3k5fG/H0DeUKtpMfcMzS4lR0E
         I1DdLgeBcjGs7KYNRI53e1U6EwA8e+YfFp8geR2/zn3pR8jgny22nyMKBhlSatYCjNv5
         KEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5OS8iU7ckkLSHaqIlbeZBVviyMeZBZWBd3YMMJ6ry8s=;
        b=LW9vZXj878s7ZKUGADc/f5cM02qKOnjZ2hcn4hRfV430oAioZmbaiJvLkjZQxlNmL1
         8/84NgyUUSxzfAfduPum/v6ayqA4CGqwpfOaWEjCTSKfISmDWr2VRLx7SiUk9Mv6o607
         nLIMgiKy0MWk2W3eQd1PB76lsol18KIiDGWafuGRcDJm+6u+510nTeoa/ip6gvkTrGvR
         SXOFc7QXXzxbWBnRhOE+xb1aidUGJVewFBju06Ev/ZYNRDYEId1Qz1quP1QqizC05uIs
         XqDx+f7zsFpTyosS0rvQRngzznvzXAnk0r8qHEPdKeeGwzhXI6VnlVGVVIh38/8dPCnx
         neLg==
X-Gm-Message-State: AJIora+TDNOgHAhsZGet14FAjw47aFayL/CTjELeLVBfRQpsUKvRtmxN
        E6/5Iw6Vqah2gUYukcUyRR8=
X-Google-Smtp-Source: AGRyM1uzISHMsdteQlV7VGJjOxdRKXpM0QKKYgz7fqjdlytM0Og1nfnajqac+KlDbo0HDg/rrQyM9A==
X-Received: by 2002:a17:907:6d92:b0:726:cbdd:465e with SMTP id sb18-20020a1709076d9200b00726cbdd465emr35238204ejc.155.1657029994799;
        Tue, 05 Jul 2022 07:06:34 -0700 (PDT)
Received: from localhost.localdomain (93-42-70-190.ip85.fastwebnet.it. [93.42.70.190])
        by smtp.googlemail.com with ESMTPSA id ku5-20020a170907788500b0072aee605e0esm399709ejc.60.2022.07.05.07.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 07:06:34 -0700 (PDT)
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
Subject: [PATCH 06/13] ARM: dts: qcom: enable usb phy by default for ipq8064
Date:   Tue,  5 Jul 2022 15:39:10 +0200
Message-Id: <20220705133917.8405-7-ansuelsmth@gmail.com>
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

Enable usb phy by default. When the usb phy were pushed, half of them
were flagged as disabled by mistake. Fix this to correctly init dwc3
node on any ipq8064 based SoC.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Tested-by: Jonathan McDowell <noodles@earth.li>
---
 arch/arm/boot/dts/qcom-ipq8064.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom-ipq8064.dtsi
index b2faa4a067e9..9c32c637ea46 100644
--- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi
@@ -1177,8 +1177,6 @@ hs_phy_0: phy@100f8800 {
 			clocks = <&gcc USB30_0_UTMI_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
-
-			status = "disabled";
 		};
 
 		ss_phy_0: phy@100f8830 {
@@ -1187,8 +1185,6 @@ ss_phy_0: phy@100f8830 {
 			clocks = <&gcc USB30_0_MASTER_CLK>;
 			clock-names = "ref";
 			#phy-cells = <0>;
-
-			status = "disabled";
 		};
 
 		usb3_0: usb3@100f8800 {
-- 
2.36.1

