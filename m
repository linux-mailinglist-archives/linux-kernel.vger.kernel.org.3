Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2334BC49C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240672AbiBSBj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:39:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiBSBjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:39:25 -0500
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8225B8CD93
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:39:07 -0800 (PST)
Received: by mail-oo1-xc2f.google.com with SMTP id x6-20020a4a4106000000b003193022319cso5718847ooa.4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=RjemXSV75Vw9palHMQyo5enZxXAZmf41kHPQ4eZELJo=;
        b=AyMfeiJMS0vSJv5HMaokxLm+QZ9zNKlhrrZ2aY8umxmkCsSlQxiLiJRO4UxQhtW6HJ
         i15x6OajGsIHWsKHFrrm+PiEJXzsNY/bpsizuVIYqNYyvN7nbdFT3CgtdaGoZjovHBcY
         RnWEe2eyoThWh0g2DZxHfLGCfURX9iuwfyfmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=RjemXSV75Vw9palHMQyo5enZxXAZmf41kHPQ4eZELJo=;
        b=G5seEjRgiEK5/C7ZGoXkMhn74UDZYnj9f/+Pvl54Oy4mNfN7KDsJKJbcHtz/ydth0l
         gFrUmucHocYZ1EZ160HIaaAdwvOI8Hhzo/NrS4GJF7czpy1Vy2d7ntlNp2Qjy5k1bbm3
         ZnBh6WuCrb53ehJRT6Sndu59Eq8OIg1nKRGBjI3Itd0I7Al6NAGaLC9Edmzm3eg1NvPL
         b1EtcyLE/BKKwYLtm2JdUq8ytdQ++9v6itxzCfjEPwJLOukab/ovn3+g7t7K3eDY6wZF
         9q39zhlmsXdErB6+MC+xgOKP4g3Cak2WjoNqe2vUXxeskxna8jbQMoeqa9c+sGMQbekL
         Ug7Q==
X-Gm-Message-State: AOAM531NDLD4gXe+KyyO52dc8mun1VPh4yLY18eGpwNzhAJ2CClqUyL3
        pXZ4HrAGfE8GlQ/sI69Qiv49EqOyVP8IYJ3sjl8Z+Q==
X-Google-Smtp-Source: ABdhPJwXxe1c3WauETFWf8LaaMFkHaOzvltuFdBobBGGMqsHsPktQBUX+6qtWVkVyHL9zO0d5lroDGq4n/a4iXlur7c=
X-Received: by 2002:a05:6870:631a:b0:d1:7d97:806 with SMTP id
 s26-20020a056870631a00b000d17d970806mr3779181oao.8.1645234746846; Fri, 18 Feb
 2022 17:39:06 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 18 Feb 2022 17:39:06 -0800
MIME-Version: 1.0
In-Reply-To: <1645182064-15843-2-git-send-email-quic_c_skakit@quicinc.com>
References: <1645182064-15843-1-git-send-email-quic_c_skakit@quicinc.com> <1645182064-15843-2-git-send-email-quic_c_skakit@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Fri, 18 Feb 2022 17:39:06 -0800
Message-ID: <CAE-0n51X=LJMjDb9KS0rqQDqLR5srzxCOJCRS4oJgPSXbvaSiQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/5] dt-bindings: mfd: pm8008: Add pm8008 regulators
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_collinsd@quicinc.com,
        quic_subbaram@quicinc.com, quic_jprakash@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Satya Priya (2022-02-18 03:00:59)
> Add regulators and their supply nodes. Add separate compatible
> "qcom,pm8008-regulators" to differentiate between pm8008 infra
> and pm8008 regulators mfd devices.
>
> Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
> ---

Is the register layout compatible with SPMI regulators? The gpio node
seems to be fully compatible and the same driver probes there for SPMI
and i2c, so I wonder why we can't extend the existing SPMI gpio and
regulator bindings to have the new compatible strings for pm8008. Is
anything really different, or do we have the same device talking i2c
instead of SPMI now? Possibly it's exposing the different hardware
blocks inside the PMIC at different i2c addresses. It looks like the i2c
address is 0x8 and then there's 16-bits of address space inside the i2c
device to do things. 0x9 is the i2c address for the regulators and then
each ldo is at some offset in there?

> Changes in V2:
>  - As per Rob's comments changed "pm8008[a-z]?-regulator" to
>    "^pm8008[a-z]?-regulators".
>
> Changes in V3:
>  - Fixed bot errors.
>  - As per stephen's comments, changed "^pm8008[a-z]?-regulators$" to
>    "regulators".
>
> Changes in V4:
>  - Changed compatible string to "qcom,pm8008-regulators"
>
> Changes in V5:
>  - Remove compatible for regulators node.
>  - Move supply nodes of the regulators to chip level.
>
> Changes in V6:
>  - No changes.
>
> Changes in V7:
>  - Removed the intermediate regulators node and added ldos
>    directly under mfd node.
>
>  .../devicetree/bindings/mfd/qcom,pm8008.yaml       | 50 +++++++++++++++++++---
>  1 file changed, 43 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> index ec3138c..6b3b53e 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
> @@ -16,7 +16,9 @@ description: |
>
>  properties:
>    compatible:
> -    const: qcom,pm8008
> +    enum:
> +      - qcom,pm8008
> +      - qcom,pm8008-regulators
>
>    reg:
>      description:
> @@ -44,6 +46,21 @@ properties:
>    "#size-cells":
>      const: 0
>
> +  vdd_l1_l2-supply:
> +    description: Input supply phandle of ldo1 and ldo2 regulators.
> +
> +  vdd_l3_l4-supply:
> +    description: Input supply phandle of ldo3 and ldo4 regulators.
> +
> +  vdd_l5-supply:
> +    description: Input supply phandle of ldo5 regulator.
> +
> +  vdd_l6-supply:
> +    description: Input supply phandle of ldo6 regulator.
> +
> +  vdd_l7-supply:
> +    description: Input supply phandle of ldo7 regulator.
> +
>  patternProperties:
>    "^gpio@[0-9a-f]+$":
>      type: object
> @@ -85,13 +102,16 @@ patternProperties:
>
>      additionalProperties: false
>
> +  "^ldo[1-7]$":
> +    type: object
> +    $ref: "../regulator/regulator.yaml#"
> +    description: PM8008 regulator peripherals of PM8008 regulator device
> +
>  required:
>    - compatible
>    - reg
> -  - interrupts
>    - "#address-cells"
>    - "#size-cells"
> -  - "#interrupt-cells"
>
>  additionalProperties: false
>
> @@ -102,13 +122,11 @@ examples:
>      qupv3_se13_i2c {
>        #address-cells = <1>;
>        #size-cells = <0>;
> -      pm8008i@8 {
> +      pm8008_infra: pm8008@8 {
>          compatible = "qcom,pm8008";
>          reg = <0x8>;
>          #address-cells = <1>;
>          #size-cells = <0>;
> -        interrupt-controller;
> -        #interrupt-cells = <2>;
>
>          interrupt-parent = <&tlmm>;
>          interrupts = <32 IRQ_TYPE_EDGE_RISING>;

I still fail to see what this part of the diff has to do with
regulators. Can it be split off to a different patch with a clear
description of why interrupt-controller and #interrupt-cells is no
longer required for qcom,pm8008?

It really looks like we're combining the binding for qcom,pm8008 and
qcom,pm8008-regulators at the same level, which looks wrong. We don't
want to describe the least common denominator between the two bindings.
Why not make two different bindings and files? One for the interrupty
gpio/interrupt controller device (at 0x8) and one for the regulator one
(at 0x9)?

> @@ -123,6 +141,24 @@ examples:
>            #interrupt-cells = <2>;
>          };
>        };
> -    };
>
> +      pm8008_regulators: pm8008@9 {

pmic@9, or regulators@9? The node name should be generic.

> +        compatible = "qcom,pm8008-regulators";
> +        reg = <0x9>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        vdd_l1_l2-supply = <&vreg_s8b_1p2>;
> +        vdd_l3_l4-supply = <&vreg_s1b_1p8>;
> +        vdd_l5-supply = <&vreg_bob>;
> +        vdd_l6-supply = <&vreg_bob>;
> +        vdd_l7-supply = <&vreg_bob>;
> +
> +        pm8008_l1: ldo1 {
> +          regulator-name = "pm8008_l1";
> +          regulator-min-microvolt = <950000>;
> +          regulator-max-microvolt = <1300000>;
> +        };
> +      };

For some i2c devices that appear on multiple i2c addresses we make an
i2c client for each address in the driver that attaches to the node we
put in DT. I suppose that won't work easily here. Either way, it would
make it much clearer if this existing binding was left alone. Is there
other functionality inside the i2c address 0x9 register space that isn't
regulators?
