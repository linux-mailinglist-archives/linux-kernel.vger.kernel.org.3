Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6ED57F10C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237628AbiGWTAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiGWTAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:00:33 -0400
Received: from mail-4319.protonmail.ch (mail-4319.protonmail.ch [185.70.43.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DAC14004;
        Sat, 23 Jul 2022 12:00:26 -0700 (PDT)
Date:   Sat, 23 Jul 2022 19:00:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658602825; x=1658862025;
        bh=Qd8Vn3xIJoBHXVYSlX6tuPCxnvx2GtvwzIJMcrzHXF8=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=VSZ3NfcEHq8hRF5W++vHTjdjIOO+OLE99U8dSAjYm6rAbLUG9Uz0b4CclXKv29mPT
         svVQunS4yvvqTMjgAhnm/TqbZ3lGBe9kUrUSumEtUWkJO/yhMh56w9Q/J+wO1kxTdG
         eR2CPHMINPfqX6vf9loZ26DxAdGTXFHl+c1umJEnsiDwICJcbpQweTJ4kD4EBDwcuZ
         ni4BrX+o7yyvJvpNrX+ch9al7hHYcNtW+q32As+vlOGaQDMQW1ZAFcGs4ULICMCcJz
         fCT0jsjf4/ey6BmjkNORiPQbUkT8zJzj4feTkm2byDmw21pPU2PAVkNv/0ke7JmeTO
         U9aveiiqgCS+A==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, soc@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH v6 1/5] dt-bindings: qcom: Document bindings for new msm8916-samsung-e2015 devices
Message-ID: <20220723185845.203622-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220723185424.203340-1-linmengbo0689@protonmail.com>
References: <20220723185424.203340-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new samsung,e5/e7/grandmax device tree bindings used in their
device trees.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index 5c06d1bfc046..b004f42bc277 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -164,6 +164,9 @@ properties:
               - longcheer,l8150
               - samsung,a3u-eur
               - samsung,a5u-eur
+              - samsung,e5
+              - samsung,e7
+              - samsung,grandmax
           - const: qcom,msm8916

       - items:
--
2.30.2


