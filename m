Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019504E45AD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240151AbiCVSGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240139AbiCVSGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:06:16 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D4A68FB3;
        Tue, 22 Mar 2022 11:04:46 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id r23so22743001edb.0;
        Tue, 22 Mar 2022 11:04:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=yUGdPChqlMnmJr7+nT7tnY1D50Ebcwr3w5rWWrqf40w=;
        b=CIOFOZQx4zdOe4d4NIIqpVP5Yq1ty27SDvU6wjlMS8Xj5WQ6fGCmloUrh9KoAbFL46
         aPVaxfn+ZzGDJCXvptGu6syWlRMRnpPivPMUceJQSXq7fofz1+TDfAW6OQGTOK1ywlXm
         Q+8W7YebVVqswWLNSdCUgLpqwOVbM9i7P1JD/5lKoGLeBnlIt5Bh/Ejm8ny20yLcaPEX
         UwfK0gOOg6mfGhAT4qpDeSuBFX/S5ZVoquFtI8BNivU6jpVVdQ0cbmPHu/8YGVO0hxVO
         uIt5zGI0vvbeg3kiqO4QWDf72H/mRvauX1QOalnWkT4jkKJe3a+bDGZwS5LsA+zFDd4M
         M6Dg==
X-Gm-Message-State: AOAM530Ka57UnF4ThBuOPegWqrSrUI5JFGpVcCXcPzS10U9jD9XkdP+n
        y4wAQDfhe397Qqo+p4ob2AbQyc8S/Y4=
X-Google-Smtp-Source: ABdhPJxpvvbq796bCqV6STafM0YifNN5hFUdSKEsnrkQBhgt4VCbfYE88mVKE9CnC5U9f10Xh7Zkyg==
X-Received: by 2002:aa7:d7cb:0:b0:419:43f:efa9 with SMTP id e11-20020aa7d7cb000000b00419043fefa9mr25170220eds.75.1647972284741;
        Tue, 22 Mar 2022 11:04:44 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id hr13-20020a1709073f8d00b006dff3a69572sm3870244ejc.5.2022.03.22.11.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 11:04:44 -0700 (PDT)
Message-ID: <90ebea0b-1d67-98dc-2b49-a6e3b97a2c4a@kernel.org>
Date:   Tue, 22 Mar 2022 19:04:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 21/26] dt-bindings: crypto: convert rockchip-crypto to
 yaml
Content-Language: en-US
To:     Corentin Labbe <clabbe@baylibre.com>, heiko@sntech.de,
        herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20220321200739.3572792-1-clabbe@baylibre.com>
 <20220321200739.3572792-22-clabbe@baylibre.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321200739.3572792-22-clabbe@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 21:07, Corentin Labbe wrote:
> Convert rockchip-crypto to yaml
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  .../crypto/rockchip,rk3288-crypto.yaml        | 84 +++++++++++++++++++
>  .../bindings/crypto/rockchip-crypto.txt       | 28 -------
>  2 files changed, 84 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/rockchip-crypto.txt
> 
> diff --git a/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> new file mode 100644
> index 000000000000..a6be89a1c890
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/rockchip,rk3288-crypto.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/crypto/rockchip,rk3288-crypto.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip Electronics And Security Accelerator
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - rockchip,rk3288-crypto
> +      - rockchip,rk3328-crypto
> +      - rockchip,rk3399-crypto

Waaaait, what? Only rockchip,rk3288-crypto is in original bindings.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 4
> +
> +  clock-names:
> +    minItems: 4
> +
> +  resets:
> +    maxItems: 1

You missed reset-names.

This patch is quite different than previous, in unexpected way. What
happened here?

> +
> +if:

Please define it after "allOf:", so it could be easily extended without
changing indentation.

> +  properties:
> +    compatible:
> +      const: rockchip,rk3399-crypto
> +then:
> +  properties:
> +    reg:
> +      minItems: 2
> +    interrupts:
> +      minItems: 2

List interrupts. This is really different than your v1. It also looks
different than original bindings and you did not mention any differences
here, nor in the commit msg. Either explain in commit msg all
differences (and why) or move them to separate commit.

You seem to change the bindings a lot (new properties, different
constraints, new compatibles), so this should all go to separate commit.
Now it is just confusing.

> +    clocks:
> +      minItems: 6

You need maxItems. Everywhere.

> +    clock-names:
> +      minItems: 6

List all items.

> +    resets:
> +      minItems: 6
> +else:
> +  if:
> +    properties:
> +      compatible:
> +        const: rockchip,rk3328-crypto
> +  then:
> +    properties:
> +      clocks:
> +        minItems: 3
> +      clock-names:
> +        minItems: 3
> +

Best regards,
Krzysztof
