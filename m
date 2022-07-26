Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD47581B28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiGZUgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239439AbiGZUgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:36:37 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BB013EA1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:36:36 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id z18so11611890qki.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcZsy9YU2wor9FTm49pTcQx1YMax9xpx8t5nNjMHHvw=;
        b=mD5ODojS4ERooCgfJfZmIl+iGCoclYcJG6w6PAjhe+Tpd0JS6uSObfXtV4s4uKyR/F
         poIhJU7SVMBqfYuuTFJPcaIMGTRMXTKuGDoQMr5NjM15hZp9fz3ugncOnLc0zVSRGK/8
         tclhki/AYGpS5WTbT74GpcVTlKxkdAGMO6Fb9sYuh7RiqM71Tq6dD/97s89feM5TrQyy
         GVSECQK6bxyGcWk1EjEE/Hpwgr6eJ6IYd13m25lo/qWCZLPO3GJqaZhgiheFcoMsN3/p
         ehzKa0UWQr2ps82g9gYq5AVGF998MCJV/I5iDcs8zM3usFJHhJfKhoe+REraGV/Qkh44
         iXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcZsy9YU2wor9FTm49pTcQx1YMax9xpx8t5nNjMHHvw=;
        b=rqmA31bAYOptn0Qro/Y4dELfk7l37QoHZfRPTIKCxk2SCLBSZnmNH1Z5k6Ii5IgDlP
         T+SGbPGbRzt6MU54mQh4hfSTZH7Y+iHFAGtRKQNJeEXP/ptJYjuyRgrYTEFFLwOd7Ajc
         OKExYZXROx15DkgDFqFVuljbJlSug5XpOr2QE4iuBtbVm3efDLJ+Ai2Rm7rCpEJKFn88
         7zBk/MNfoWacneGc3AA8XsiuBw65WHJOWSpNKzz8BqH2v/zCiG6tm4cRG1M6jBUl/Iot
         eysT+1162NdkqZbZkx+G2vkqBSgUYdMifzNOH1oLKrQ9Sv1NhczFAPHvNdw+ARpF2ZLc
         4C5g==
X-Gm-Message-State: AJIora+AjrtOpLP/PcSYRQ1HJPit3gMz5sfS+XsgnxphQe/EtqtKHwqv
        5V02n/QKYHjOlXRVcx1LqTQA00h09MW0dTZ3UbpLZo351dA=
X-Google-Smtp-Source: AGRyM1tNx6kBPvBXmc3Kyq5jl3sNmdQSJwzJHB6zd3N2gvoT/PMYLLh0EmnZYTV1tO11UGjaUq2wMn3j2xYiMQvBKl8=
X-Received: by 2002:a05:620a:4305:b0:6a9:3829:c03 with SMTP id
 u5-20020a05620a430500b006a938290c03mr13508906qko.363.1658867795165; Tue, 26
 Jul 2022 13:36:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220726181133.3262695-1-iskren.chernev@gmail.com> <20220726181133.3262695-2-iskren.chernev@gmail.com>
In-Reply-To: <20220726181133.3262695-2-iskren.chernev@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 26 Jul 2022 23:36:24 +0300
Message-ID: <CAA8EJpoLMioMy61np6Y8Gn+Uhb8EvgU6bwuUyouuNcDz0XwByg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: regulator: Document the PM6125 SPMI PMIC
To:     Iskren Chernev <iskren.chernev@gmail.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Jul 2022 at 21:11, Iskren Chernev <iskren.chernev@gmail.com> wrote:
>
> Add support for pm6125 compatible string and add relevant supplies in QCom SPMI
> regulator documentation.
>
> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>

The order of sign-offs seems incorrect. The sender's signature should
be the last one.

> ---
>  .../regulator/qcom,spmi-regulator.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> index 8b7c4af4b551..d8f18b441484 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> @@ -12,6 +12,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - qcom,pm6125-regulators
>        - qcom,pm660-regulators
>        - qcom,pm660l-regulators
>        - qcom,pm8004-regulators
> @@ -106,6 +107,24 @@ required:
>    - compatible
>
>  allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pm6125-regulators
> +    then:
> +      properties:
> +        vdd_l1_l7_l17_l18-supply: true
> +        vdd_l2_l3_l4-supply: true
> +        vdd_l5_l15_l19_l20_l21_l22-supply: true
> +        vdd_l6_l8-supply: true
> +        vdd_l9_l11-supply: true
> +        vdd_l10_l13_l14-supply: true
> +        vdd_l12_l16-supply: true
> +        vdd_l23_l24-supply: true
> +      patternProperties:
> +        "^vdd_s[1-8]-supply$": true

Add an empty line please.

>    - if:
>        properties:
>          compatible:
> --
> 2.37.1
>


-- 
With best wishes
Dmitry
