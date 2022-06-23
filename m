Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75E7557704
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbiFWJqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiFWJqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:46:40 -0400
Received: from mx.kernkonzept.com (serv1.kernkonzept.com [IPv6:2a01:4f8:1c1c:b490::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AAC49925;
        Thu, 23 Jun 2022 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IQ3Xf3SVicxiqe6CbASmgF2tTElLTO5CpJ3b3KI9gXU=; b=BwCRwbSbyOiTVsbPtSCZaY9U4k
        li8ptFTla2r30QfcCPT3WUjKPIGNoQDa4h1wlrppt6c65fc4ylV8hL3IVvLA8qErr2ltZTHyr7Jrl
        KQeB9Ij2aBJVGoqRGn+bH6kY6VnfYFjyVrbbLSGBzDxP5rBrpf4R1n3EjwSeiVntSC+yPk/wK6Ho5
        OJeWisYaqVqhzMj7Rh3DyoRkKWjla8iDU+qZMYhhuTlWHH8qBLhTQG+PHhxETrhmJaSfJ8SILgjAT
        Qetkj2RmGglXPOkGd3PpOLg8e/HNFEjgya5PnyiQtW24u0fNLnR89abFHOXpaCc6l00TfeRiYb8om
        CqETklPQ==;
Received: from [10.22.3.24] (helo=kernkonzept.com)
        by mx.kernkonzept.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.94.2)
        id 1o4JQ1-005qg2-M5; Thu, 23 Jun 2022 11:46:33 +0200
From:   Stephan Gerhold <stephan.gerhold@kernkonzept.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Subject: [PATCH 2/3] regulator: dt-bindings: qcom,smd-rpm: Add PM8909
Date:   Thu, 23 Jun 2022 11:46:13 +0200
Message-Id: <20220623094614.1410180-3-stephan.gerhold@kernkonzept.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
References: <20220623094614.1410180-1-stephan.gerhold@kernkonzept.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "qcom,rpm-pm8909-regulators" compatible for describing
the regulators available in the PM8909 PMIC (controlled via the RPM
firmware).

PM8909 is very similar to the existing PM8916 but lacks 3 of the
regulators (s3, s4 and l16).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
---
 .../devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
index 6a9a7eed466f..c233461cc980 100644
--- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.yaml
@@ -30,6 +30,9 @@ description:
 
   For pm8841, s1, s2, s3, s4, s5, s6, s7, s8
 
+  For pm8909, s1, s2, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13,
+  l14, l15, l17, l18
+
   For pm8916, s1, s2, s3, s4, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
   l12, l13, l14, l15, l16, l17, l18
 
@@ -78,6 +81,7 @@ properties:
       - qcom,rpm-mp5496-regulators
       - qcom,rpm-pm8226-regulators
       - qcom,rpm-pm8841-regulators
+      - qcom,rpm-pm8909-regulators
       - qcom,rpm-pm8916-regulators
       - qcom,rpm-pm8941-regulators
       - qcom,rpm-pm8950-regulators
-- 
2.30.2

