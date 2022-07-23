Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3757EF9A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiGWO0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiGWO0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:26:13 -0400
Received: from mail-4027.protonmail.ch (mail-4027.protonmail.ch [185.70.40.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B29140DF
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:26:12 -0700 (PDT)
Date:   Sat, 23 Jul 2022 14:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1658586371; x=1658845571;
        bh=2QjiAgn8HWnexWrYLsAVAdb8/F63PFHi89wsxeG92kY=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=lZLdyAhKQT2oRAPfZgaLhuZxsL80Y9uOI60qhNOBN6l4K+UAfre1PrmfKb8KwLTUA
         UC45+2Wd8sRK/3YrNOSF2PVXnLw/mBrFQIih6WNr0/i6HxwZN5bUSR8uRiJTTVu+Pq
         9Vpyhrm37LX/6F2hn/7CY+eUDUiewaw8e6wYgTUw+7YTWXn6C0KPFRP+0PyMPjqwAg
         QRhgSDVfhGn7IRtJ7NznRr0OtxQ1A72ABpEIjNYu1yyaIiY6S8LDr+La7+JJluKScH
         YxOYbyo+hwTqCPQCw/0DZ90F4rW7IbCo6meACLWv2+yZtwvdtRlZbyV2UdqPdLoK0Q
         3dddNdGEKhzUw==
To:     devicetree@vger.kernel.org
From:   "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht
Reply-To: "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Subject: [PATCH v5 1/4] dt-bindings: qcom: Document bindings for new msm8916-samsung-e2015 devices
Message-ID: <20220723142434.136458-1-linmengbo0689@protonmail.com>
In-Reply-To: <20220723141835.136196-1-linmengbo0689@protonmail.com>
References: <20220723141835.136196-1-linmengbo0689@protonmail.com>
Feedback-ID: 40467236:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new samsung,e5/e7/grandmax device tree bindings used in their
device trees.

Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
Acked-by: Krzysztof Kozlowski
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


