Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0346477C2D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:06:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240797AbhLPTGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:06:43 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:41668 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhLPTGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:06:42 -0500
Received: by mail-oo1-f45.google.com with SMTP id a11-20020a4ad1cb000000b002c2657270a0so17917oos.8;
        Thu, 16 Dec 2021 11:06:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CG56Jwgd9cUomWDpy5o7T6p7P8N4Uke3kC1sOxkLV7I=;
        b=NJo63fqujfUGbla2oC2+uaT+XYslPVZgqm+dlq8AVDjlHyiCgPcIqLSrMqzEfMl5TS
         GyivaNG0cUDqoCUe78wrPWvTAbcgCmObxStyawURXjPe+9nLjsm99Z2NvWY9afmguiw2
         3kWXgHsDMD7MvDRR3W50xykoIggn8kKntw6+Ucye1NC/lcahS4HicWFUqh0ogKc5dfB6
         DvKNw9eTFVQMoh3B85rn2eQiPywLnJJQXllNmdVqXMLhmB5+C1zzOOZayJ+xa+MLzRWW
         4vRwAtctJ3EeWjkLMm5Hc9/HdIuNtAEFtBrebDQfuA+PGV1UIiSUgqQWa4gAnftVoScS
         7Mfw==
X-Gm-Message-State: AOAM530hgTBZ48/BrMuHYhpiKh9SXRX3iexE3GJKPIQ5G49ilbyRGwAF
        hfEMKM5rQHnT5r93PmD0NQ==
X-Google-Smtp-Source: ABdhPJw/lKVAgvYYodsYmDHJIPLbu+J7eSYgLLi1L5y8TZtPzYt8+RFx+b/nx3iF88MBdKkrVbZ9WA==
X-Received: by 2002:a4a:e50e:: with SMTP id r14mr12353606oot.27.1639681601738;
        Thu, 16 Dec 2021 11:06:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 184sm1132342oih.58.2021.12.16.11.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 11:06:41 -0800 (PST)
Received: (nullmailer pid 579625 invoked by uid 1000);
        Thu, 16 Dec 2021 19:06:40 -0000
Date:   Thu, 16 Dec 2021 13:06:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, jiaxin.yu@mediatek.com,
        shumingf@realtek.com
Subject: Re: [PATCH 2/2] dt-bindings: mediatek: mt8195: add clock property to
 sound node
Message-ID: <YbuOQOH3esG1pFQU@robh.at.kernel.org>
References: <20211215065835.3074-1-trevor.wu@mediatek.com>
 <20211215065835.3074-2-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215065835.3074-2-trevor.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 02:58:35PM +0800, Trevor Wu wrote:
> clocks and clock-names are added to provide MCLK phandle for sound card.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml  | 12 ++++++++++++
>  .../bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml  | 12 ++++++++++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
> index cf6ad7933e23..b57c856d0cf3 100644
> --- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1011-rt5682.yaml
> @@ -32,11 +32,21 @@ properties:
>      $ref: "/schemas/types.yaml#/definitions/phandle"
>      description: The phandle of MT8195 HDMI codec node.
>  
> +  clocks:
> +    items:
> +      - description: phandle and clock specifier for codec MCLK.
> +
> +  clock-names:
> +    items:
> +      - const: i2so1_mclk
> +
>  additionalProperties: false
>  
>  required:
>    - compatible
>    - mediatek,platform
> +  - clocks
> +  - clock-names
>  
>  examples:
>    - |
> @@ -44,6 +54,8 @@ examples:
>      sound: mt8195-sound {
>          compatible = "mediatek,mt8195_mt6359_rt1011_rt5682";
>          mediatek,platform = <&afe>;
> +        clocks = <&topckgen 235>; //CLK_TOP_APLL12_DIV2
> +        clock-names = "i2so1_mclk";
>          pinctrl-names = "default";
>          pinctrl-0 = <&aud_pins_default>;
>      };
> diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
> index 8f177e02ad35..e4720f76f66b 100644
> --- a/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-rt1019-rt5682.yaml
> @@ -42,11 +42,21 @@ properties:
>        A list of the desired dai-links in the sound card. Each entry is a
>        name defined in the machine driver.
>  
> +  clocks:
> +    items:
> +      - description: phandle and clock specifier for codec MCLK.
> +
> +  clock-names:
> +    items:
> +      - const: i2so1_mclk
> +
>  additionalProperties: false
>  
>  required:
>    - compatible
>    - mediatek,platform
> +  - clocks
> +  - clock-names
>  
>  examples:
>    - |
> @@ -54,6 +64,8 @@ examples:
>      sound: mt8195-sound {
>          compatible = "mediatek,mt8195_mt6359_rt1019_rt5682";
>          mediatek,platform = <&afe>;
> +        clocks = <&topckgen 235>; //CLK_TOP_APLL12_DIV2
> +        clock-names = "i2so1_mclk";

Being a virtual node, how does it have clocks? This belongs in the h/w 
device that consumes the clock.

>          pinctrl-names = "default";
>          pinctrl-0 = <&aud_pins_default>;
>      };
> -- 
> 2.18.0
> 
> 
