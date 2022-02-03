Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28F4A7FBF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 08:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349363AbiBCHZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 02:25:22 -0500
Received: from mail-40140.protonmail.ch ([185.70.40.140]:50129 "EHLO
        mail-40140.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiBCHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 02:25:21 -0500
Date:   Thu, 03 Feb 2022 07:25:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail2; t=1643873119;
        bh=rroVZy+8mm+y9NJmmSBWrLbl8QRoHIsd7+BkHgYOTVg=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=DBYP77jMHRsBppbN6FldyHmlwGym/e9QVtnf8/aiLs2zukGlqbAUVeTDAyBAf3L8k
         qQj0yyaZ/lueegbKIw3ybl4xaZFTTqpL+gHU0mcptYF+RrNIGtreBTdMDl2i1XY3+Z
         uIaou8p9z+Ry2dxRF4q6wmHudPlzg/ORZFLhw4SneLjZN+5ZTvF3pUOPUIzI6tW5+D
         h7prvM0R2Lm5mVmj/NEbIPNwNtcIpSvQ0HVvPKmn4GH0/7rv4JV5rRnQr4mwxpWe4O
         YmxQzRLLTYSPgCsQc3xOt5gEC+OPk/vnMgd0VaAm/NRw9gIfVifaPWbBP6uNRZOOgz
         ZnLiEn4eRFtzw==
To:     Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
From:   Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-kernel@vger.kernel.org
Reply-To: Yassine Oudjana <y.oudjana@protonmail.com>
Subject: [PATCH RESEND v3 1/7] dt-bindings: arm: qcom: Add msm8996 and apq8096 compatibles
Message-ID: <20220203072226.51482-2-y.oudjana@protonmail.com>
In-Reply-To: <20220203072226.51482-1-y.oudjana@protonmail.com>
References: <20220203072226.51482-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatibles for MSM8996 and APQ8096 and all supported devices
that have them.

Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 04ff0b55bb85..da6b2608f10b 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -172,7 +172,21 @@ properties:
           - const: qcom,apq8094
=20
       - items:
-          - const: qcom,msm8996-mtp
+          - enum:
+              - arrow,apq8096-db820c
+              - inforce,ifc6640
+          - const: qcom,apq8096-sbc
+          - const: qcom,apq8096
+
+      - items:
+          - enum:
+              - qcom,msm8996-mtp
+              - sony,dora-row
+              - sony,kagura-row
+              - sony,keyaki-row
+              - xiaomi,gemini
+              - xiaomi,scorpio
+          - const: qcom,msm8996
=20
       - items:
           - enum:
--=20
2.34.1


