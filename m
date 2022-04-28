Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E26512B90
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 08:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243823AbiD1Gbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 02:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235906AbiD1Gbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 02:31:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3F238BF2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:28:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a1so4344888edt.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 23:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xf+dx9QjYu+pZFxcusNu2q2NMrhvf7rKxX/txAvOgA8=;
        b=SmGjZc6C2GaYPE1mr+lRp6swuqnB23B7pO1RtWV7G63RcVAtguIaQW3avKvKMGr299
         dXAmWXFp88Yfih4v23y1HF9lDEjFodDt0fFh8TaL3aFqcR48EMFLtTYkZNOlZGBz/vlq
         BWP7DC0ht9uzC7fcj0+KgBwUbwPmMJPwzne1hyhNlfKOlIdsdt+mFTbhDg2vFKS3fNFS
         fRdATMjOJ0jHZccl6YQZulwWZPo7q5k7jG8URtCU+a3BQiO0uMfmJfZHb2wIr0RbCVhO
         ZB6jSaoUWxjwawIhflU+LRYStPL6YIgdUCztLfV4rtUZ8V9nA/XtV5Aw+C3+KUQkcDOd
         37Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xf+dx9QjYu+pZFxcusNu2q2NMrhvf7rKxX/txAvOgA8=;
        b=HOTqgN27PY+2DkXZInOs3vEuEWRD9wOpYOHkFwYyL9vHwCXV/YaDBY+qHDqQloZD1I
         kZoMYjkYGwzUDhOHSAeIxVo9OSdwFyfY7fmknxtFQUFI21LVEkYX3c+5H0wuVpZzKJhE
         0NHZ0JNmLmj5xChz8OEDZ+/zT99AG61fKoFNhpiXvk7HzqGH3KnKtdy88cNnYeSJCOul
         nTYMmkQgvurB6NJjBwWssAwHMG8zr/6NE99hzGwJmPguTd1xDoSsopkwS+I0m8fgFuce
         NQXGzUe5UhYPh2uyqK+OthKbB0iFvdMxt49cEehrOoTz2zroV9o6V+2O7cwVtzgMEIze
         gRkw==
X-Gm-Message-State: AOAM533YgSXv4O0a1Pu3sHzBJow213B1rxA7Q3P5j2fhLTZxFxzcaHZF
        Ps115uQH8fVo8SlgjLjsvPuHrg==
X-Google-Smtp-Source: ABdhPJzhJ78iAFYN62jRZOQ46v7YE/NpmM9iMnwuLOFRVbW/FrLtPIu4pqBes6dv2Zk6PHzYfO78yQ==
X-Received: by 2002:a05:6402:190a:b0:426:1d8a:55e with SMTP id e10-20020a056402190a00b004261d8a055emr5065981edz.63.1651127294534;
        Wed, 27 Apr 2022 23:28:14 -0700 (PDT)
Received: from [192.168.0.159] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id b16-20020a170906709000b006f3a8aac0eesm4351745ejk.0.2022.04.27.23.28.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 23:28:13 -0700 (PDT)
Message-ID: <ebedcf5f-9b75-253c-f560-5ae5b8175634@linaro.org>
Date:   Thu, 28 Apr 2022 08:28:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC
 bindings
Content-Language: en-US
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220426232444.1761869-1-bjorn.andersson@linaro.org>
 <20220426232444.1761869-2-bjorn.andersson@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220426232444.1761869-2-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 01:24, Bjorn Andersson wrote:
> Add binding for the Qualcomm SC8280XP Global Clock controller.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v2:
> - Dropped clock-names, in favor of forcing implementation to rely on index
>   based clock matching.

Implementation does not have to use clock-names, but it's useful for
humans. You can drop it, but I think it makes life of reviewing DTS more
difficult.

> - Updated descriptions for a few clocks that only had their clock names.
> 
>  .../bindings/clock/qcom,gcc-sc8280xp.yaml     | 129 +++++
>  include/dt-bindings/clock/qcom,gcc-sc8280xp.h | 496 ++++++++++++++++++
>  2 files changed, 625 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,gcc-sc8280xp.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> new file mode 100644
> index 000000000000..bf4f9dd3ec85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sc8280xp.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,gcc-sc8280xp.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Global Clock & Reset Controller Binding for SC8280xp
> +
> +maintainers:
> +  - Bjorn Andersson <bjorn.andersson@linaro.org>
> +
> +description: |
> +  Qualcomm global clock control module which supports the clocks, resets and
> +  power domains on SC8280xp.
> +
> +  See also:
> +  - dt-bindings/clock/qcom,gcc-sc8280xp.h

Still not a full path. It makes it more difficult to validate whether
the path exists or not. You can put it in <> if you prefer to skip include.

> +
> +properties:
> +  compatible:
> +    const: qcom,gcc-sc8280xp
> +
> +  clocks:
> +    items:
> +      - description: XO reference clock
> +      - description: Sleep clock
> +      - description: UFS memory first RX symbol clock
> +      - description: UFS memory second RX symbol clock
> +      - description: UFS memory first TX symbol clock
> +      - description: UFS card first RX symbol clock
> +      - description: UFS card second RX symbol clock
> +      - description: UFS card first TX symbol clock
> +      - description: Primary USB SuperSpeed pipe clock
> +      - description: USB4 PHY pipegmux clock source
> +      - description: USB4 PHY DP gmux clock source
> +      - description: USB4 PHY sys piegmux clock source
> +      - description: USB4 PHY PCIe pipe clock
> +      - description: USB4 PHY router max pipe clock
> +      - description: Primary USB4 RX0 clock
> +      - description: Primary USB4 RX1 clock
> +      - description: Secondary USB SuperSpeed pipe clock
> +      - description: Second USB4 PHY pipegmux clock source
> +      - description: Second USB4 PHY DP gmux clock source
> +      - description: Second USB4 PHY sys pipegmux clock source
> +      - description: Second USB4 PHY PCIe pipe clock
> +      - description: Second USB4 PHY router max pipe clock
> +      - description: Secondary USB4 RX0 clock
> +      - description: Secondary USB4 RX0 clock

Duplicated name. RX1?

> +      - description: Multiport USB first SupserSpeed pipe clock
> +      - description: Multiport USB second SuperSpeed pipe clock
> +      - description: PCIe 2a pipe clock
> +      - description: PCIe 2b pipe clock
> +      - description: PCIe 3a pipe clock
> +      - description: PCIe 3b pipe clock
> +      - description: PCIe 4 pipe clock
> +      - description: First EMAC controller reference clock
> +      - description: Second EMAC controller reference clock
> +
> +  '#clock-cells':
> +    const: 1
> +
> +  '#reset-cells':
> +    const: 1
> +
> +  '#power-domain-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  protected-clocks:
> +    description:
> +      Protected clock specifier list as per common clock binding.

No need for description. You need maxItems, though.


Best regards,
Krzysztof
