Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEF6470B8A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 21:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344099AbhLJUOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 15:14:06 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:45806 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344070AbhLJUOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 15:14:02 -0500
Received: by mail-oi1-f176.google.com with SMTP id 7so14662256oip.12;
        Fri, 10 Dec 2021 12:10:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PaqEpE42JwT8DXwsVY8kEv7gNunVXJQXAeFfbCH81XM=;
        b=16L9bQiXcKEXYBp06GshTXcdZkDHdgGzAPyuoEkEiSYDi+50Jb9k+Ein1GCGGH1+1w
         AKxlqP+EDDuscCtV0eb3wWM8cUtteufQuAhujr09lVkgZ7BvYkSUYg7A0vT/KKprsVdp
         y/4sDbee3H5W3tw2/aFIq9oQy5zHiq8cVOydjYikjQLhJ3jdYE4uCLK4tS3Obb24NYER
         X3sRuYlrMSJ0ZikfDSRYHWSxu/JQaLgCTMzq084KL3iSXJvYqN0vIXvB6hoW5RJPs3J4
         4NkIL3K48x45h+YcpyGqpw3xASGyCrODresKkifGG6JJEsnV+nwT78xb6XWGXM+YAaHe
         YO4g==
X-Gm-Message-State: AOAM532aiHO6qz41EdTd3PEdbwDAymLW6SC86WG9dtxJ/xMJd1ZhfcvI
        PlbDBEpWPz9XyqVCj78w1Q==
X-Google-Smtp-Source: ABdhPJxQHE8T/q7gJ37kD0SDsARybgtPjuYbEctbSQdiMZTsg/lr1mlPRTFIcqwOt2DpMwICm7YI0Q==
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr13980733oih.162.1639167026601;
        Fri, 10 Dec 2021 12:10:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u6sm1020552oiu.34.2021.12.10.12.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 12:10:25 -0800 (PST)
Received: (nullmailer pid 1813329 invoked by uid 1000);
        Fri, 10 Dec 2021 20:10:24 -0000
Date:   Fri, 10 Dec 2021 14:10:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     YC Hung <yc.hung@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, daniel.baluta@nxp.com,
        peter.ujfalusi@intel.com, trevor.wu@mediatek.com,
        allen-kh.cheng@mediatek.com
Subject: Re: [PATCH v6] dt-bindings: dsp: mediatek: Add mt8195 DSP binding
 support
Message-ID: <YbO0MKXKYN48+kzN@robh.at.kernel.org>
References: <20211202144818.31626-1-yc.hung@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211202144818.31626-1-yc.hung@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 10:48:18PM +0800, YC Hung wrote:
> From: "yc.hung" <yc.hung@mediatek.com>
> 
> This describes the mt8195 DSP device tree node.

This doesn't match the change.

> 
> Signed-off-by: yc.hung <yc.hung@mediatek.com>
> ---
> Changes since v5:
>     Remove sub node "sound" and "mediatek,platform", "mediatek,dptx-codec",
>     "mediatek,hdmi-codec" properties. Let dsp node as an individual node and
>     sound card has phandle of this dsp node per discussion in 
>     https://github.com/thesofproject/linux/pull/3239
> 
> Changes since v4:
>   - remove patch 1 with clocks as it will be reviewed and merged to SOF tree.
>     https://github.com/thesofproject/linux/pull/3237
>   - refine DT file binding files with Rob's comments.
> ---  
>  .../bindings/dsp/mtk,mt8195-dsp.yaml          | 19 -------------------
>  1 file changed, 19 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> index f8bacd50b018..33db11ee2336 100644
> --- a/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> +++ b/Documentation/devicetree/bindings/dsp/mtk,mt8195-dsp.yaml
> @@ -70,22 +70,6 @@ properties:
>        - description: A phandle to a reserved memory region is used for dma buffer between host and DSP.   
>        - description: A phandle to a reserved memory region is used for DSP system memory.
>  
> -  model:
> -    $ref: /schemas/types.yaml#/definitions/string
> -    description: User specified audio sound card name
> -
> -  mediatek,platform:
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> -    description: The phandle of MT8195 ASoC platform.
> -
> -  mediatek,dptx-codec:
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> -    description: The phandle of MT8195 Display Port Tx codec node.
> -
> -  mediatek,hdmi-codec:
> -    $ref: "/schemas/types.yaml#/definitions/phandle"
> -    description: The phandle of MT8195 HDMI codec node.
> -
>  required:
>    - compatible
>    - reg
> @@ -98,7 +82,6 @@ required:
>    - power-domains
>    - mbox-names
>    - mboxes
> -  - mediatek,platform
>  
>  additionalProperties: false
>  
> @@ -130,6 +113,4 @@ examples:
>         power-domains = <&spm 6>; //MT8195_POWER_DOMAIN_ADSP
>         mbox-names = "mbox0", "mbox1";
>         mboxes = <&adsp_mailbox0>, <&adsp_mailbox1>;
> -       mediatek,dptx-codec = <&dp_tx>;
> -       mediatek,platform = <&afe>;
>         };
> -- 
> 2.18.0
> 
> 
