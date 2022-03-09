Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B704D3BAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 22:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiCIVFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 16:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiCIVFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 16:05:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B0F6663E;
        Wed,  9 Mar 2022 13:04:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1228461995;
        Wed,  9 Mar 2022 21:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72EA9C340F3;
        Wed,  9 Mar 2022 21:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646859841;
        bh=RfLA32mA/murgiHE8SOZv5jaYWx/3+9ErBr0WZ4lPTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LAx2mQWmWs+5gq+eJaTb2mbiw/sENGorsRSUnloVVu+VWMe31UhBhgv5N42qtb7VK
         Xf5ZcNMGQfkGGcQKpBjMdaWRq0+FGFlp9y3skfepF6k/DMp0Nbc5OfzrMJh5W/Wqbp
         YquSBrRpg8FMnJBopqUxJ7xg83N55NUQxr1dmURRJNuuLVIRij98nlhzHjkjYEokWK
         TF1UVXEi4AMj5v0PJ6nykz9rReRo7sWHCc73dXa1NfuIhVN+fzvNuShYThco0mefKu
         W6rDBjZn8QkZdIqW8FUuX32+iNj+cDPzVKfYI1R9uWi4AoOpmrnZuRV8i8i/syJOye
         B4HKWZ16oAVPQ==
Received: by mail-ej1-f54.google.com with SMTP id hw13so7387342ejc.9;
        Wed, 09 Mar 2022 13:04:01 -0800 (PST)
X-Gm-Message-State: AOAM530xga6J5GlhPh1S9LzSlnb9GJcT7R4mgZMIK0cVUGExgbkxF6No
        KGiwCu9oCJgPd/seX/07oRY0BMnx9VZrs2p4TA==
X-Google-Smtp-Source: ABdhPJwa+3bXHhGQDGTsXk88j5+6SbD977Mz29I8j6MQNYuu9KBHFEZWTDPTS/5YS11/grej2n2ucE5NbLAYSxOI6PM=
X-Received: by 2002:a17:907:298f:b0:6da:b3da:19e with SMTP id
 eu15-20020a170907298f00b006dab3da019emr1506838ejc.423.1646859839710; Wed, 09
 Mar 2022 13:03:59 -0800 (PST)
MIME-Version: 1.0
References: <20220111174805.223732-1-krzysztof.kozlowski@canonical.com> <20220111174805.223732-3-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220111174805.223732-3-krzysztof.kozlowski@canonical.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 9 Mar 2022 15:03:47 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+cNrh=o7RL=2SH5888=YU9m1QhA5q+eCTFXVbbw57oJA@mail.gmail.com>
Message-ID: <CAL_Jsq+cNrh=o7RL=2SH5888=YU9m1QhA5q+eCTFXVbbw57oJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] dt-bindings: extcon: maxim,max77843: add MAX77843 bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 11:48 AM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> Document the bindings for MAX77843 MUIC/extcon driver, based on
> Exynos5433 TM2 devicetree.  These are neither accurate nor finished
> bindings but at least allow parsing existing DTS files.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/extcon/maxim,max77843.yaml       | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
>
> diff --git a/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> new file mode 100644
> index 000000000000..f9ffe3d6f957
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/maxim,max77843.yaml
> @@ -0,0 +1,40 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/extcon/maxim,max77843.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX77843 MicroUSB and Companion Power Management IC Extcon
> +
> +maintainers:
> +  - Chanwoo Choi <cw00.choi@samsung.com>
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> +
> +description: |
> +  This is a part of device tree bindings for Maxim MAX77843 MicroUSB
> +  Integrated Circuit (MUIC).
> +
> +  See also Documentation/devicetree/bindings/mfd/maxim,max77843.yaml for
> +  additional information and example.
> +
> +properties:
> +  compatible:
> +    const: maxim,max77843-muic
> +
> +  connector:
> +    $ref: /schemas/connector/usb-connector.yaml#
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/port

Now failing in -next:

Documentation/devicetree/bindings/mfd/maxim,max77843.example.dt.yaml:
pmic@66: extcon:ports: Unevaluated properties are not allowed ('port'
was unexpected)
  From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/mfd/maxim,max77843.yaml

s/port/ports/

> +    description:
> +      Any connector to the data bus of this controller should be modelled using
> +      the OF graph bindings specified
> +    properties:
> +      port:
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - connector
> +
> +additionalProperties: false
> --
> 2.32.0
>
