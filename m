Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0959EC58
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbiHWTcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 15:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiHWTbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 15:31:53 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8F8501B4;
        Tue, 23 Aug 2022 11:23:25 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id f4so10939612qkl.7;
        Tue, 23 Aug 2022 11:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=hl2ZhT5jYud6nqmuitdZrPDQAyGkFVueC+KbleXIJi0=;
        b=JrIa1OFDqt41Da0UO3IcnulL7dkdWXnYr6hnZMzWYSbcrkSN7ou30SIEnzMbJrKsY6
         u5CuHohXigZbEbyhpYK9JlS6swj+dpVrb1cli96GwuysoJtnaf2+65TX34uEdUsOtCoN
         Fr6Njl3SuprVW+ahKp2U4qoTQ3hDUR702g2c1SyBlYjS9leEBj6OQiQj0QI40xwIp8pV
         juISk+iYdvTEfJSIedYrRpGdJbMj8Zp6RupnPX6dBLSeTZSa1DM96OsTPNrOMaxdFA9J
         8dbyE9d9W5uHSlC468z302NWFPX5zLLvxWhAtaTmnaK2pV/VKA28fCze7L4vEn2F+6jT
         7DYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=hl2ZhT5jYud6nqmuitdZrPDQAyGkFVueC+KbleXIJi0=;
        b=iwSt0Q1Z3B2nElEaomzGS0zsLBw9LmjEal8PNXk0akSMFaMLULx4gFZVi70w+9xDMB
         Nu4gaWpml0i1DKUhjsu1BD/Iiw0yjuCbvH4ersHr8nJC4oBpyqlzI6YuMMybZuLbsxLF
         bbzD0XITSVQGdWjwMv5ckZrsz5WJVAYCIDPeEYUOph23/P+q5azWZezb61riBMH0NvkB
         xCoeYfzpdwO+RZwPffBEVrNL9/ljteeUPkAdl1yZF+aDDaucu2JhNQ9hkihshkUGuF6r
         2O6XDAl+RsXv3wU8HT0JmllJvHHj3K+b/2uSg6qdpl8mr623M2s6i4aCq8JYCubagJlA
         ublw==
X-Gm-Message-State: ACgBeo0UzFEKZF5TuxFS7b5rPdA2diOO+KgHbXz+aNPl8VECl9MVY0uI
        gyC2x2rmXQJQMX+wMgaqtDmiznFz0w5kd/GVwTQ=
X-Google-Smtp-Source: AA6agR6uzuFu5gu6+eBn1q09mUSGCdjReoka/EFxwiWXrFCxt/cPbOLXqEiSJanMMVL/Mgl9gFFX4Aap050CjTsOfDM=
X-Received: by 2002:a37:27c1:0:b0:6bb:41b5:2d89 with SMTP id
 n184-20020a3727c1000000b006bb41b52d89mr17033459qkn.679.1661279004133; Tue, 23
 Aug 2022 11:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220823145649.3118479-7-robh@kernel.org>
In-Reply-To: <20220823145649.3118479-7-robh@kernel.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Tue, 23 Aug 2022 20:23:13 +0200
Message-ID: <CAOX2RU4u+v9EPAPoxZmL4iGAmt+VuuxNJW-_AE7TZaFHZBTaEA@mail.gmail.com>
Subject: Re: [PATCH] regulator: dt-bindings: Add missing (unevaluated|additional)Properties
 on child nodes
To:     Rob Herring <robh@kernel.org>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adam Ward <Adam.Ward.opensource@diasemi.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Aug 2022 at 16:57, Rob Herring <robh@kernel.org> wrote:
>
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/regulator/dlg,da9121.yaml           |  1 +
>  .../bindings/regulator/maxim,max77802.yaml       |  1 +
>  .../bindings/regulator/maxim,max8997.yaml        |  1 +
>  .../bindings/regulator/mt6315-regulator.yaml     |  1 +
>  .../bindings/regulator/qcom,spmi-regulator.yaml  |  1 +
>  .../regulator/qcom-labibb-regulator.yaml         | 16 ++++++++++++++++
>  .../regulator/richtek,rt4801-regulator.yaml      |  1 +
>  .../regulator/rohm,bd71815-regulator.yaml        |  1 +
>  8 files changed, 23 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> index 24ace6e1e5ec..63e1161a87de 100644
> --- a/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> +++ b/Documentation/devicetree/bindings/regulator/dlg,da9121.yaml
> @@ -83,6 +83,7 @@ properties:
>
>    regulators:
>      type: object
> +    additionalProperties: false
>      description: |
>        List of regulators provided by the device
>
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
> index 236348c4710c..71138c611b6c 100644
> --- a/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max77802.yaml
> @@ -79,6 +79,7 @@ patternProperties:
>      patternProperties:
>        regulator-state-(standby|mem|disk):
>          type: object
> +        additionalProperties: true
>          properties:
>            regulator-mode: false
>
> diff --git a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
> index 4321f061a7f6..2b266ea43716 100644
> --- a/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
> +++ b/Documentation/devicetree/bindings/regulator/maxim,max8997.yaml
> @@ -111,6 +111,7 @@ properties:
>
>    regulators:
>      type: object
> +    additionalProperties: false
>      description:
>        List of child nodes that specify the regulators.
>
> diff --git a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
> index 37402c370fbb..364b58730be2 100644
> --- a/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/mt6315-regulator.yaml
> @@ -29,6 +29,7 @@ properties:
>        "^vbuck[1-4]$":
>          type: object
>          $ref: "regulator.yaml#"
> +        unevaluatedProperties: false
>
>          properties:
>            regulator-compatible:
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> index 8b7c4af4b551..3266cd0c580f 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom,spmi-regulator.yaml
> @@ -35,6 +35,7 @@ patternProperties:
>      description: List of regulators and its properties
>      type: object
>      $ref: regulator.yaml#
> +    unevaluatedProperties: false
>
>      properties:
>        qcom,ocp-max-retries:
> diff --git a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> index 1ddc1efd19e2..f97b8083678f 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/qcom-labibb-regulator.yaml
> @@ -20,6 +20,7 @@ properties:
>
>    lab:
>      type: object
> +    additionalProperties: false
>
>      properties:
>        qcom,soft-start-us:
> @@ -33,11 +34,19 @@ properties:
>          description:
>            Short-circuit and over-current interrupts for lab.
>
> +      interrupt-names:
> +        minItems: 1
> +        items:
> +          - const: sc-err
> +          - const: ocp
> +
>      required:
>        - interrupts
> +      - interrupt-names
>
>    ibb:
>      type: object
> +    additionalProperties: false
>
>      properties:
>        qcom,discharge-resistor-kohms:
> @@ -52,8 +61,15 @@ properties:
>          description:
>            Short-circuit and over-current interrupts for ibb.
>
> +      interrupt-names:
> +        minItems: 1
> +        items:
> +          - const: sc-err
> +          - const: ocp
> +
>      required:
>        - interrupts
> +      - interrupt-names
>
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
> index 091150c4e579..4a8a221bc902 100644
> --- a/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rt4801-regulator.yaml
> @@ -42,6 +42,7 @@ patternProperties:
>    "^DSV(P|N)$":
>      type: object
>      $ref: regulator.yaml#
> +    unevaluatedProperties: false
>      description:
>        Properties for single display bias regulator.
>
> diff --git a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
> index 7d0adb74a396..d61e8675f067 100644
> --- a/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
> +++ b/Documentation/devicetree/bindings/regulator/rohm,bd71815-regulator.yaml
> @@ -27,6 +27,7 @@ properties:
>      description:
>        properties for wled regulator
>      $ref: regulator.yaml#
> +    unevaluatedProperties: false
>
>      properties:
>        regulator-name:
> --
> 2.34.1

For qcom,spmi-regulator.yaml:
Reviewed-by: Robert Marko <robimarko@gmail.com>
>
