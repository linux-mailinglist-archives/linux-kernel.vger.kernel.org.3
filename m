Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17004E3479
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiCUXfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbiCUXfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:35:12 -0400
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477086E34C;
        Mon, 21 Mar 2022 16:33:46 -0700 (PDT)
Received: by mail-ot1-f44.google.com with SMTP id a17-20020a9d3e11000000b005cb483c500dso7104669otd.6;
        Mon, 21 Mar 2022 16:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iqlGJqAp9J3mBYn2W544lt1cPtvAWKBsX1sKB8vjaFQ=;
        b=8RR2NtTyRvA8kVRw1oOtA6dceP1ZDrEpEkVuOIPpCypgdP7XtvReLFuc0utca5auPp
         DmRS/yWxq2K6ESJrS3bmCb7wuZQcs/ntXt1yTKBjldE4NLIVFz3H8cmsQOXgbDAzytyK
         WGss64E10ZpcKjU5JZCZs1feOC2vvDptmD9N/EX3+R+MBxXHfJCQHMmCfJrh3D+sQ9ta
         gdOKRZOtHhco8AXGmgKI0qY51RipMEqUcWD/4q3IXNrHqfHLMHtDC1zAeTTdwtiO6kZf
         GIjkT4f19JDPNM4kHbT3FY/lUwOqWg5Ytivwk8kss4S2GQRZW8a+m37lewnC4h11+pDs
         t85Q==
X-Gm-Message-State: AOAM533V97s+JieCsanUOd0M0r4mrLjlNM9h2nOX7mq9+kh3xVPGey1z
        RgUV61czvtO/67rHH8y7KA==
X-Google-Smtp-Source: ABdhPJzxxO+k7l8znxP0vjnY2lEafBroFgaKOlvFVHd8JKFt8pjObiL7SWOFKakst91i39pW6Q1Hgw==
X-Received: by 2002:a9d:5f16:0:b0:5cb:51de:6761 with SMTP id f22-20020a9d5f16000000b005cb51de6761mr6071903oti.139.1647905625156;
        Mon, 21 Mar 2022 16:33:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p14-20020a9d744e000000b005b235f5cf92sm8228647otk.65.2022.03.21.16.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 16:33:44 -0700 (PDT)
Received: (nullmailer pid 751258 invoked by uid 1000);
        Mon, 21 Mar 2022 23:33:43 -0000
Date:   Mon, 21 Mar 2022 18:33:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, tzungbi@google.com,
        angelogioacchino.delregno@collabora.com, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v5 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible
 and new properties
Message-ID: <YjkLVwvxvOKr30qL@robh.at.kernel.org>
References: <20220319114111.11496-1-jiaxin.yu@mediatek.com>
 <20220319114111.11496-2-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220319114111.11496-2-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 19, 2022 at 07:41:08PM +0800, Jiaxin Yu wrote:
> 1. Adds new compatible string "mt8192_mt6359_rt1015p_rt5682s" for machines
> with rt1015p and rt5682s.
> 2. Adds new property "mediatek,headset-codec" for getting headset codecs.
> 3. Adds new property "mediatek,speaker-codec" for getting speaker codecs.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> index a781e7aaaa38..aa0476eedd38 100644
> --- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> @@ -18,6 +18,7 @@ properties:
>      enum:
>        - mediatek,mt8192_mt6359_rt1015_rt5682
>        - mediatek,mt8192_mt6359_rt1015p_rt5682
> +      - mediatek,mt8192_mt6359_rt1015p_rt5682s
>  
>    mediatek,platform:
>      $ref: "/schemas/types.yaml#/definitions/phandle"
> @@ -27,6 +28,25 @@ properties:
>      $ref: "/schemas/types.yaml#/definitions/phandle"
>      description: The phandle of HDMI codec.
>  
> +patternProperties:
> +  "^mediatek,headset-codec$":

Fixed string, not a pattern. Move to 'properties'. Drop the vendor 
prefix too.

> +    description: Holds subnode which indicates headset dai.
> +    type: object
> +    properties:
> +      sound-dai:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array

Standard property, don't need a type or description. Just how many and 
what each one is if more than 1.

> +        description: List of phandles to the headset codec nodes.

More than 1?

> +    additionalProperties: false
> +
> +  "^mediatek,speaker-codec$":
> +    description: Holds subnode which indicates speaker dai.
> +    type: object
> +    properties:
> +      sound-dai:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description: List of phandles to the speaker codec nodes.

Same here.

> +    additionalProperties: false
> +
>  additionalProperties: false
>  
>  required:
> @@ -44,6 +64,15 @@ examples:
>                          "aud_clk_mosi_on";
>          pinctrl-0 = <&aud_clk_mosi_off>;
>          pinctrl-1 = <&aud_clk_mosi_on>;
> +
> +        mediatek,headset-codec {
> +            sound-dai = <&rt5682>;
> +        };
> +
> +        mediatek,speaker-codec {
> +            sound-dai = <&rt1015_l>,
> +                        <&rt1015_r>;
> +        };
>      };
>  
>  ...
> -- 
> 2.18.0
> 
> 
