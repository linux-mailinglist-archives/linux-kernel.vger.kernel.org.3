Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324914E8EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 09:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238726AbiC1HIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 03:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235517AbiC1HI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 03:08:29 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D05B052B0B;
        Mon, 28 Mar 2022 00:06:49 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id z92so15724837ede.13;
        Mon, 28 Mar 2022 00:06:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bWHNH/EfXpoNd6GDO+NCVI8AReob2nLGcB93Fy6VsBU=;
        b=HGgVkuhVWivmPBLSISJL3YLvYy9oKFi1Bx+GvT4GFLzfY7Cnb44h0f+9tBjqbgXYNV
         K8q7T0kQn8PyMPvghT09LoIst+2VIVN1aGVyiMPXCsRmWocfINCLFlCnbiwG0NgNyacx
         vgInjHe+eOu3ueuvZz0nJ+X1j6AsrkvJfH6hXZEj/piJVaxiD4pv293TKwI7eoxJVExw
         OM1G6CWoDw02MMr2mCxkuIJaQMtgoM7CSDbtXayysOYJLFFwSWdPPgZvWmu/mHeGiluT
         bdkG1Z4UGd+FYbenkLbj3ocsAGbgQR+UWzc208B/MG5BBJ4JSsRstzodKVggz3ovDX96
         BEQA==
X-Gm-Message-State: AOAM531lToNovJSKf2nokdxWvEhS5xaLMQmLa09uvASzA4SkPp2qIbUn
        YyFf9zRIEQg5rGJd6JZScno=
X-Google-Smtp-Source: ABdhPJyIknQbldb2sxGzz5k0GbACmYk7LHZl4P9ANNwRnBbA6fgve5eGIekXkq4wWYc5UHkwHDUhEQ==
X-Received: by 2002:a05:6402:3496:b0:419:82d5:f1d9 with SMTP id v22-20020a056402349600b0041982d5f1d9mr14537977edc.36.1648451208200;
        Mon, 28 Mar 2022 00:06:48 -0700 (PDT)
Received: from [192.168.0.162] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id k12-20020aa7c38c000000b0041939d9ccd0sm6618012edq.81.2022.03.28.00.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 00:06:47 -0700 (PDT)
Message-ID: <da414b44-1bec-5918-84f5-9dfff2009f41@kernel.org>
Date:   Mon, 28 Mar 2022 09:06:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH v2 3/6] ASoC: dt-bindings: Extend clock bindings of
 rt5659
Content-Language: en-US
To:     Sameer Pujar <spujar@nvidia.com>, broonie@kernel.org,
        lgirdwood@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com, peter.ujfalusi@linux.intel.com,
        pierre-louis.bossart@linux.intel.com
Cc:     oder_chiou@realtek.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <1648448050-15237-1-git-send-email-spujar@nvidia.com>
 <1648448050-15237-4-git-send-email-spujar@nvidia.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1648448050-15237-4-git-send-email-spujar@nvidia.com>
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

On 28/03/2022 08:14, Sameer Pujar wrote:
> The rt5658 or rt5659 CODEC system clock (SYSCLK) can be derived from
> various clock sources. For example it can be derived either from master
> clock (MCLK) or by internal PLL. The internal PLL again can take input
> clock references from bit clocks (BCLKs) and MCLK. To enable a flexible
> clocking configuration the DT binding is extended here.
> 
> It makes use of standard clock bindings and sets up the clock relation
> via DT.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Oder Chiou <oder_chiou@realtek.com>
> ---
>  .../devicetree/bindings/sound/realtek,rt5659.yaml  | 53 ++++++++++++++++++++--
>  1 file changed, 49 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
> index b0485b8..0c2f3cb 100644
> --- a/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
> +++ b/Documentation/devicetree/bindings/sound/realtek,rt5659.yaml
> @@ -29,12 +29,28 @@ properties:
>      maxItems: 1
>  
>    clocks:
> -    items:
> -      - description: Master clock (MCLK) to the CODEC
> +    description: |
> +      CODEC can receive multiple clock inputs like Master
> +      clock (MCLK), I2S bit clocks (BCLK1, BCLK2, BCLK3,
> +      BCLK4). The CODEC SYSCLK can be generated from MCLK
> +      or internal PLL. In turn PLL can reference from MCLK
> +      and BCLKs.
>  
>    clock-names:
> -    items:
> -      - const: mclk
> +    description: |
> +      The clock names can be combination of following:
> +        "mclk"        : Master clock
> +        "pll_ref"     : Reference to CODEC PLL clock
> +        "sysclk"      : CODEC SYSCLK
> +        "^bclk[1-4]$" : Bit clocks to CODEC

No, that does not look correct. You allow anything as clock input (even
20 clocks, different names, any order). That's not how DT schema should
work and that's not how hardware looks like.

Usually the clock inputs are always there which also you mentioned in
description - "multiple clock inputs". All these clocks should be
expected, unless really the wires (physical wires) can be left disconnected.

Best regards,
Krzysztof
