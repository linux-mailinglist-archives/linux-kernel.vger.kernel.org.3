Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9EC51A361
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351882AbiEDPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350363AbiEDPQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:16:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE7542ED2
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:12:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q23so2479023wra.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Q8t/4zs15J+WUhbyzSWnk3xMYZcOI1/gRBqoDJhXob4=;
        b=wi7jEkVHGAPE3FymCXSvLN550cRUAYn+sygWU7mIu1v6VRG1s7mhDZ07dA1iYbxg13
         R/Rytjl94JyOgat26pA99xa6NJJXkv9o8ASXXJYmqwBgsrHKO3jCpvBch3BMVUTuDO1s
         q182c5/7F7N1xv3HFPXMc6ERzEdT2cGvJ23dvQsQVG5u2qZcYxQWdOxvuyGnd0wgv1rm
         jOtd0psyDJ6F3bYSbcUzFT3fyQMQjq6hOacnH0TDmwlF3DbqtXcxLn4134sRyQ0CpcbQ
         dw3aG43dPDYrPKEsWqb3ILdVMpegh45O6gw08q0NqQjG90e9fZ7T2uG62sX6t8YmbqSY
         bw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Q8t/4zs15J+WUhbyzSWnk3xMYZcOI1/gRBqoDJhXob4=;
        b=VRBMtGZqb5g/qbf6B3nsH267SZza/ZSl9hW0cSuBjVCvSveiRkDtjDsFKNqRDj1I7z
         l4CkgoSIJO7rrRTIuksZX+24Sst8c1Jm8GxVimY06jwb+1MzJt5bNwcJ9FGKj3Idwx2L
         gjvUjOcm0MfDo5pZfSWQKi2boCYljcKJw5F2+r9l5GiOKMpNEuRYEBf3pUg4HAxlIaIr
         uKFpXlT9AW4CAJyiznv24pCeSk18xIMExVtWc7Ypm19MVES2HE9NtyAc68lrJ+xc83LE
         kvfoS9ZIdS6AnSAnzZBaGRA+Iebp3KMHJNgqm0+7jSfEJAdaFpR/Gdr8E/w6TCsLsN79
         Iyzg==
X-Gm-Message-State: AOAM533gcCkWsuFugNwOoaAZg0H36jiHtZtEHNS6l6fAxfcuN4tamTuN
        Kmlp95Mg+roSoAKVW54ImL46+Q==
X-Google-Smtp-Source: ABdhPJwfIvkgE9/1fAnUpjs8I+PHo/RnrTFjwqbemJe3+1Lvhwupfj7uVRIPK/HVf99hbq90HZ3bMA==
X-Received: by 2002:a5d:598f:0:b0:20c:83c9:b05b with SMTP id n15-20020a5d598f000000b0020c83c9b05bmr2172834wri.343.1651677170300;
        Wed, 04 May 2022 08:12:50 -0700 (PDT)
Received: from [192.168.0.215] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v1-20020a05600c15c100b003942a244ecfsm3898263wmf.20.2022.05.04.08.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 08:12:49 -0700 (PDT)
Message-ID: <6b231701-0c76-e7a8-bcd3-8a9c5cdc7a0f@linaro.org>
Date:   Wed, 4 May 2022 17:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lee.jones@linaro.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427100848.3525710-1-gengcixi@gmail.com>
 <20220427100848.3525710-3-gengcixi@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220427100848.3525710-3-gengcixi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2022 12:08, Cixi Geng wrote:
> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> 
> Add bindings for Unisoc system global register which provide register map
> for clocks.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
>  1 file changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> new file mode 100644
> index 000000000000..3522f3d2d8de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mfd/sprd,ums512-glbreg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Unisoc System Global Register Device Tree Bindings

Thanks for removing "Device Tree Bindings" from first patch, but such
comment applies everywhere. Please clean up all your patches (also
future) based on received comments, so we do not have to repeat the same.


> +maintainers:
> +  - Orson Zhai <orsonzhai@gmail.com>
> +  - Baolin Wang <baolin.wang7@gmail.com>
> +  - Chunyan Zhang <zhang.lyra@gmail.com>
> +
> +description:
> +  Unisoc system global registers provide register map
> +  for clocks and some multimedia modules of the SoC.
> +
> +properties:
> +  "#address-cells": true
> +  "#size-cells": true
> +
> +  compatible:

Put the compatible as first in the properties.

> +    items:
> +      - const: sprd,ums512-glbregs
> +      - const: syscon
> +      - const: simple-mfd
> +
> +  ranges:
> +    maxItems: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":

The name should be specific - "clock-controller" - so this can be in
"properties".

> +    # Child node

Comment does not help.


Best regards,
Krzysztof
