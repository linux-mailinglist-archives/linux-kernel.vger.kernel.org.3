Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF4D650CC02
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 17:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236177AbiDWPyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 11:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbiDWPye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 11:54:34 -0400
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E206ED76C2;
        Sat, 23 Apr 2022 08:51:37 -0700 (PDT)
Received: from g550jk.arnhem.chello.nl (a246182.upc-a.chello.nl [62.163.246.182])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 8839BCEA99;
        Sat, 23 Apr 2022 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1650729096; bh=qLIOA4+GN/rEaYoq66qSa1FoW0TIjsK8MKQeZO+mi6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GBHYLZygBSn5JGVPFR6Pt1QJ/CapOWK7cBBKCtHseNSeYZf5U8kdji7ZR6LvOEcnw
         KLcUfd0AjfvZ/z2+n4BVFPXc22rYVmHzB3nVRzR89l+dejudkgwtIcuRkwjtrlVlTC
         MlTSvXrVKLh9PPMcqr57FpXatoTLp+N774s+wgK4=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] ARM: dts: qcom: apq8026-asus-sparrow: Enable ADSP
Date:   Sat, 23 Apr 2022 17:50:58 +0200
Message-Id: <20220423155059.660387-4-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423155059.660387-1-luca@z3ntu.xyz>
References: <20220423155059.660387-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The customized reserved memory for ADSP is already configured, so we
just need to enable the node.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
 arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
index 818c1a201227..215613c65250 100644
--- a/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
+++ b/arch/arm/boot/dts/qcom-apq8026-asus-sparrow.dts
@@ -59,6 +59,10 @@ vreg_wlan: wlan-regulator {
 	};
 };
 
+&adsp {
+	status = "okay";
+};
+
 &blsp1_uart1 {
 	status = "okay";
 
-- 
2.36.0

