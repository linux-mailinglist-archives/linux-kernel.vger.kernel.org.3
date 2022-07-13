Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2093572EB1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 09:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbiGMHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbiGMHE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 03:04:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC16BD39F;
        Wed, 13 Jul 2022 00:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D7F5B81D43;
        Wed, 13 Jul 2022 07:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25950C34114;
        Wed, 13 Jul 2022 07:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657695894;
        bh=4hvIqPkLZHlf/Zli4Xt0SSiNQfDfOXa81PyHxoExwXU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pwHTkt2sGRghejHc455UUcXoVbBf6B7PFBs1Fb9f2WnHvneqzF/P10xLeunYzas4e
         8H+FaCShzTnvzNQUz1a959qSryqs+d/wVi4qG51Wv07J/fQkfdBFmxncp8+IzB/zvF
         wxf14MpaXV9vg+YgWT/EeVE9xMtQNWq5BDm/66bVq2kreBCVkAovX/iNGNp1f89XxV
         P2Q9zfeMUe8Y4nUBGiatu8suVqWxknpVzVObhQOoj8KFMVlYrteB9CQ0aoKd81BGss
         HI2SCtQy3+wP0Pt+/RxECXWtKpKGPIuTUDuPA5shHOaIuWcb/Va40Lvpad+7V2NmR3
         bHkaYK+kUPy0g==
Message-ID: <c403edcf-0c33-225c-8bbd-3a49e90a9a73@kernel.org>
Date:   Wed, 13 Jul 2022 09:04:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] dt-bindings: firmware: Add bindings for Samsung smc
Content-Language: en-US
To:     dj76.yang@samsung.com,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>
Cc:     "javierm@redhat.com" <javierm@redhat.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Sang Min Kim <hypmean.kim@samsung.com>,
        Wangseok Lee <wangseok.lee@samsung.com>
References: <CGME20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71@epcms1p8>
 <20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71@epcms1p8>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220713045357epcms1p8ccfe1c489edfd066d0e41ff928c0af71@epcms1p8>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/07/2022 06:53, Dongjin Yang wrote:
> Add an devicetree bindings for Samsung secure monitor call service.
> This driver is used for SoCs produced by Samsung Foundry to provide
> SMC call. This patch supports register read/write request to secure
> monitor. Also, SMC call request which uses shared memory to exchange
> the data between kernel and secure monitor.
> 
> Signed-off-by: Dongjin Yang <dj76.yang@samsung.com>
> ---
>  .../bindings/firmware/samsung,smccc-svc.yaml       | 31 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml b/Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml
> new file mode 100644
> index 000000000000..427c42a6cd75
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/samsung,smccc-svc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Secure Monitor call service
> +
> +maintainers:
> +  - Jesper Nilsson <jesper.nilsson@axis.com>
> +
> +description: |
> +  The file documents device tree bindings of Samsung secure monitor
> +  call service.
> +
> +properties:
> +  compatible:

Please add SoC comaptible followed by generic samsung,smccc-svc (so you
need items with an enum and const).

> +    const: samsung,smccc-svc
> +
> +required:
> +  - compatible
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

No need for blank line.

> +    samsung-svc {

Generic node names, e.g. smc.

> +        compatible = "samsung,smccc-svc";
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 20133dcd8ce9..6763746c349f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1862,6 +1862,7 @@ M:	Jesper Nilsson <jesper.nilsson@axis.com>
>  M:	Lars Persson <lars.persson@axis.com>
>  L:	linux-arm-kernel@axis.com
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/firmware/samsung,smccc-svc.yaml

Does not look related to Artpec. Shouldn't this be under Samsung Exynos?

>  F:	Documentation/devicetree/bindings/pinctrl/axis,artpec6-pinctrl.txt
>  F:	arch/arm/boot/dts/artpec6*
>  F:	arch/arm/mach-artpec


Best regards,
Krzysztof
