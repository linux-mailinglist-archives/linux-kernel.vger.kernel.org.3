Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066A45AC10D
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 21:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbiICTIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 15:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbiICTIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 15:08:34 -0400
X-Greylist: delayed 557 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Sep 2022 12:08:33 PDT
Received: from mail-4018.proton.ch (mail-4018.proton.ch [185.70.40.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BBF57E3B;
        Sat,  3 Sep 2022 12:08:33 -0700 (PDT)
Date:   Sat, 03 Sep 2022 19:08:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=connolly.tech;
        s=protonmail; t=1662232111; x=1662491311;
        bh=iURgxyu9ob4++N5UHicPVjw94qeA3C2soRlfY+K5wPk=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:Feedback-ID:From:To:Cc:Date:Subject:Reply-To:
         Feedback-ID:Message-ID;
        b=Pb53YiaSOfwtRJGfhelyHt4rQRkpIUiz7lx95feravHcOKKH/bEGOwGzxy7W1M3vM
         yXMBaRnECFnSHhvr4BKFur1qgkEriYm/k5Dc1DYumrETedoU6HoszP2N9e5SjN+NIU
         Kcl7WG+XexCMMHllIcNkvccN9m48rlHwdzrCgbd0=
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
From:   Caleb Connolly <caleb@connolly.tech>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Reply-To: Caleb Connolly <caleb@connolly.tech>
Subject: Re: [PATCH v2 6/9] dt-bindings: arm: qcom: Add compatible for oneplus,billie2 phone
Message-ID: <180096cd-9205-96b8-b6c4-a2a900166ceb@connolly.tech>
In-Reply-To: <20220903174150.3566935-7-iskren.chernev@gmail.com>
References: <20220903174150.3566935-1-iskren.chernev@gmail.com> <20220903174150.3566935-7-iskren.chernev@gmail.com>
Feedback-ID: 10753939:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/09/2022 18:41, Iskren Chernev wrote:
> oneplus,billie2 (OnePlus Nord N100) is based on QualComm Snapdragon
> SM4250 SoC.
>
> Add support for the same in dt-bindings.
>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Caleb Connolly <caleb@connolly.tech>
> ---
>   Documentation/devicetree/bindings/arm/qcom.yaml | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentat=
ion/devicetree/bindings/arm/qcom.yaml
> index 19c2f4314741..63cc41cd0119 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -54,6 +54,8 @@ description: |
>           sdm845
>           sdx55
>           sdx65
> +        sm4250
> +        sm6115
>           sm6125
>           sm6350
>           sm7225
> @@ -670,6 +672,11 @@ properties:
>                 - xiaomi,polaris
>             - const: qcom,sdm845
>
> +      - items:
> +          - enum:
> +              - oneplus,billie2
> +          - const: qcom,sm4250
> +
>         - items:
>             - enum:
>                 - sony,pdx201
> --
> 2.37.2
>

--
Kind Regards,
Caleb

