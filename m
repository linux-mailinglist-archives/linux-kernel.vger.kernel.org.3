Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3069578CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234346AbiGRVVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbiGRVVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:21:12 -0400
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A707128727;
        Mon, 18 Jul 2022 14:21:11 -0700 (PDT)
Date:   Mon, 18 Jul 2022 21:21:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1658179269; x=1658438469;
        bh=uuxbUlzCKdnpZQ6Bkv9TYCn2NI7EQjaHey/D4Mc3tUA=;
        h=Date:To:From:Reply-To:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=IzB/Ub0GgV5wggzkvrEZqasbSUjxuJFUti94hWvwN4T9SiWQOiqfoiEZBaC+hOM8j
         j6G+owLYtmjMfyApEl7cKA/gsN17SBCNTcV3YG/0VWGiiR4LBolk3QXt1ctiL36V2J
         6T6OTTZOGHseIGqKwess0gITCrwBS3gYJ/eyOzFc=
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Caleb Connolly <caleb@connolly.tech>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
From:   Caleb Connolly <caleb@connolly.tech>
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: [PATCH 1/4] Documentation: dt-bindings: arm: qcom: add google,blueline
Message-ID: <20220718212019.1471265-2-caleb@connolly.tech>
In-Reply-To: <20220718212019.1471265-1-caleb@connolly.tech>
References: <20220718212019.1471265-1-caleb@connolly.tech>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the bindings for the Pixel 3

Based on https://lore.kernel.org/all/20220521164550.91115-7-krzysztof.kozlo=
wski@linaro.org/

Signed-off-by: Caleb Connolly <caleb@connolly.tech>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentatio=
n/devicetree/bindings/arm/qcom.yaml
index b727467e86c6..b3e1004673c7 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -320,6 +320,7 @@ properties:

       - items:
           - enum:
+              - google,blueline
               - lenovo,yoga-c630
               - oneplus,enchilada
               - oneplus,fajita
--
2.36.1


