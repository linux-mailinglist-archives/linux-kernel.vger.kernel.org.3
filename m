Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A3C5136EB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348399AbiD1Oes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 10:34:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiD1Oed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 10:34:33 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D6E9D4C4;
        Thu, 28 Apr 2022 07:31:19 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-e67799d278so5290381fac.11;
        Thu, 28 Apr 2022 07:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3Pbfgb+P+Y6uKRbvZrIbkDzsXq4uSgu+65I8ansZfZg=;
        b=W+O1TPPbvAn6BDgXEWx6bHH0BZpjwexPNSDvLGnLZImO5TdnF2ucybf9FK1ZkuCozM
         ILuRuo0ihg+KcWZ8MG21Z0FZwPiBa9Zak7/rarrajEcQ68aKDPCXSmqQ50z0Fot6i3Jb
         I4x+SatZpJQKcA7BR6C44CTe04nP+0aJ9dLROlSMt05KjU2E+peWKASv5sAote9VsSFn
         rJoyUFylxyZECR0ipgpndBEZL5+whN8YvyBaD6HsK5oACZIYha86y4dutfjqalV3Sh/3
         8SviYo2FVhAbes7FIbigPmrp2zhSi194Mdpt+O3yO3Ez1dx7hVUqRzGznc30xFNGlVP+
         xvNg==
X-Gm-Message-State: AOAM530Reu+fpWZtM6ZuvPj7UYpgmMo+dFx/rFI+Jcaca4jQfpxA016S
        2jvqh2js24DOttNYsYZR8A==
X-Google-Smtp-Source: ABdhPJx1VX5F/tJUIHYIip9Fxu6rAMhFBcqi6cHTI0eggbgDWjn/9R4RMK7nTXnkcz/rMEflMMwQ3w==
X-Received: by 2002:a05:6870:3292:b0:da:d2ff:9dca with SMTP id q18-20020a056870329200b000dad2ff9dcamr14140353oac.215.1651156278750;
        Thu, 28 Apr 2022 07:31:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 5-20020a9d0105000000b005fbe5093eb0sm31088otu.54.2022.04.28.07.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 07:31:18 -0700 (PDT)
Received: (nullmailer pid 2184573 invoked by uid 1000);
        Thu, 28 Apr 2022 14:31:17 -0000
Date:   Thu, 28 Apr 2022 09:31:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        tzungbi@google.com, linux-mediatek@lists.infradead.org,
        trevor.wu@mediatek.com, matthias.bgg@gmail.com, aaronyu@google.com,
        julianbraha@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [v4 16/18] dt-bindings: mediatek: mt8186: add
 mt8186-mt6366-da7219-max98357 document
Message-ID: <YmqlNV31FrcAyuN9@robh.at.kernel.org>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <20220428093355.16172-17-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220428093355.16172-17-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 05:33:53PM +0800, Jiaxin Yu wrote:
> Add document for mt8186 board with mt6366, da7219 and max98357.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> new file mode 100644
> index 000000000000..55e8649f2aea
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8186-mt6366-da7219-max98357.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT8186 with MT6366, DA7219 and MAX98357 ASoC sound card driver
> +
> +maintainers:
> +  - Jiaxin Yu <jiaxin.yu@mediatek.com>
> +
> +description:
> +  This binding describes the MT8186 sound card.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8186_mt6366_da7219_max98357_sound

s/_/-/

> +
> +  mediatek,platform:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: The phandle of MT8186 ASoC platform.
> +
> +  headset-codec:
> +    type: object

       additionalProperties: false

> +    properties:
> +      sound-dai:
> +        $ref: /schemas/types.yaml#/definitions/phandle

sound-dai already has a type, so drop and define how many entries.

> +    required:
> +        - sound-dai
> +
> +  playback-codecs:
> +    type: object

       additionalProperties: false

> +    properties:
> +      sound-dai:
> +        minItems: 2
> +        maxItems: 3

If more than 1 entry, then you need to define what each one is and the 
order. Just like reg, interrupts, clocks, etc.

> +        $ref: /schemas/types.yaml#/definitions/phandle-array

Drop

> +    required:
> +        - sound-dai
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - mediatek,platform
> +  - headset-codec
> +  - playback-codecs
> +
> +examples:
> +  - |
> +
> +    sound: mt8186-sound {
> +        compatible = "mediatek,mt8186_mt6366_da7219_max98357_sound";
> +        mediatek,platform = <&afe>;
> +        pinctrl-names = "aud_clk_mosi_off",
> +                        "aud_clk_mosi_on";
> +        pinctrl-0 = <&aud_clk_mosi_off>;
> +        pinctrl-1 = <&aud_clk_mosi_on>;
> +
> +        headset-codec {
> +            sound-dai = <&da7219>;
> +        };
> +
> +        playback-codecs {
> +            sound-dai = <&anx_bridge_dp>,
> +                        <&max98357a>;
> +        };
> +    };
> +
> +...
> -- 
> 2.25.1
> 
