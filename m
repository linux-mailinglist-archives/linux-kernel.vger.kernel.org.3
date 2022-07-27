Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3E58223E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 10:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbiG0IfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiG0IfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 04:35:01 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B53459A3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:34:59 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id y9so12169597qtv.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 01:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dA5j1jqryALrdC4QkJMTe/X+dWRTvz0oQv4XcBgtyHM=;
        b=lCkfuFcR4LunaAOuVYuJtg9Y7+nSXFTxPlkR0Y6zXFy5iOEATaCWXzgPpstgIDulhf
         n0AC6D3MkPIAe/aXiqUSXJsdBHIRCQvzUtQIqgImQ86JVo840DyGNeRTgGIh3hnGw+lJ
         odDbZX6dv32P66IlV4fOGNPU25gxSZX9jck+USKR3eWUgtvlDuZxBWNM0yE+n4kEk4Pi
         I3W/xQyOFsYvmsiYx/5C9emDBgrS/0K3JfessiWHTzaVnRV2+JilA4LXCLzOcmztpgiT
         syn3iYC4pxh4iJoHmRwwYidCKk/mPu++ng+1meEIYwi8Z9Ar7u4p4BUcQ4SdbeIs6G3n
         8zpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dA5j1jqryALrdC4QkJMTe/X+dWRTvz0oQv4XcBgtyHM=;
        b=urqpL/aDah7GLsK/PC8v5rJA8ONkisnZ3huwVG9oAOWa2rRanW3ubalaD/GhpR1NQ9
         KRXuX2ZZgZO5l5cbIsFGq9HwT04inraS1CMndAsXFLQkKpAYia+KR3OQUeT4bXHJ/9DC
         KgP2Qimb0UincWwCi1gq2PsBEEnW6z7/5ko7NAFhSdIauoKGJZvvZRxGltfFyib2pJHD
         h+/3nV6phfqRUmg2CiurFnFIr0aV1NPDoSe370ilgNwH/ZYChFAdgrtzGGQ95BAXTwip
         AYWZ5R+XVKAOv9iw2c2P1FT6wp77+aNl2QIeT9LONzivXQGCWAfPmUgJwt0P4A6M4cUG
         uTIQ==
X-Gm-Message-State: AJIora/E/vs0Z/Q6/z2n+TWfrEqQ615WAyMMy9nXpjle8ZZArGqn+JH3
        Nf5LYPFsgBvle63xhdTIysJHVqsckroRAf1BZk33Hg==
X-Google-Smtp-Source: AGRyM1trmWmOgcXNQisG2Jv7vVC0nCup37xjuAGBe5fvmSNzQiHe6iWbFg5N1AT0L669M3SW9/qkSNELgzYnMDrE6n4=
X-Received: by 2002:ac8:5942:0:b0:31f:39f6:aba7 with SMTP id
 2-20020ac85942000000b0031f39f6aba7mr9502124qtz.295.1658910898718; Wed, 27 Jul
 2022 01:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220726181133.3262695-1-iskren.chernev@gmail.com>
 <20220726181133.3262695-2-iskren.chernev@gmail.com> <CAA8EJpoLMioMy61np6Y8Gn+Uhb8EvgU6bwuUyouuNcDz0XwByg@mail.gmail.com>
 <79fce900-2825-45ca-44f2-9fb94b5eeed3@gmail.com>
In-Reply-To: <79fce900-2825-45ca-44f2-9fb94b5eeed3@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 27 Jul 2022 11:34:47 +0300
Message-ID: <CAA8EJprk9=xBBodf0NPhXpQNeU_Rm_wK1g4hCUJq_JaV6_JJcg@mail.gmail.com>
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

On Wed, 27 Jul 2022 at 10:49, Iskren Chernev <iskren.chernev@gmail.com> wrote:
>
>
>
> On 7/26/22 23:36, Dmitry Baryshkov wrote:
> > On Tue, 26 Jul 2022 at 21:11, Iskren Chernev <iskren.chernev@gmail.com> wrote:
> >>
> >> Add support for pm6125 compatible string and add relevant supplies in QCom SPMI
> >> regulator documentation.
> >>
> >> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
> >> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> >
> > The order of sign-offs seems incorrect. The sender's signature should
> > be the last one.
>
> Sure, will do!
>
> >> ---
> >>  .../regulator/qcom,spmi-regulator.yaml        | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> >> index 8b7c4af4b551..d8f18b441484 100644
> >> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> >> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> >> @@ -12,6 +12,7 @@ maintainers:
> >>  properties:
> >>    compatible:
> >>      enum:
> >> +      - qcom,pm6125-regulators
> >>        - qcom,pm660-regulators
> >>        - qcom,pm660l-regulators
> >>        - qcom,pm8004-regulators
> >> @@ -106,6 +107,24 @@ required:
> >>    - compatible
> >>
> >>  allOf:
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - qcom,pm6125-regulators
> >> +    then:
> >> +      properties:
> >> +        vdd_l1_l7_l17_l18-supply: true
> >> +        vdd_l2_l3_l4-supply: true
> >> +        vdd_l5_l15_l19_l20_l21_l22-supply: true
> >> +        vdd_l6_l8-supply: true
> >> +        vdd_l9_l11-supply: true
> >> +        vdd_l10_l13_l14-supply: true
> >> +        vdd_l12_l16-supply: true
> >> +        vdd_l23_l24-supply: true
> >> +      patternProperties:
> >> +        "^vdd_s[1-8]-supply$": true
> >
> > Add an empty line please.
>
> All other if-then blocks don't have newlines, shall I add one between each as
> well?

Yes, please, in a separate commit.


-- 
With best wishes
Dmitry
