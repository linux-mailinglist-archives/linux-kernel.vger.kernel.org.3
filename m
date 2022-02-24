Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CD64C35B8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 20:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbiBXTUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 14:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiBXTUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:20:11 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343C81C60EF;
        Thu, 24 Feb 2022 11:19:41 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id x193so4447778oix.0;
        Thu, 24 Feb 2022 11:19:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cc8HWmanEpdtB8YuJu7jgI5K1qIYmoacQ6BDCjLUl6I=;
        b=Oo1m9qqiwSe7AZu6KEEP1qoc0o0RgPNC9u5/Vy1rHaELobtjDD99T9mGibDNzu7SJ8
         6Wz6XnrpAKx4em9zdAov4iNoBYyfvsdqDjuDMzXZDiRRYeOqmEExq7V8yI32Wx5d7UfI
         OMyA9gqN8chPytPBWsMKnPudkv8309Z8FBFyDDgfgGffGo5vbIOMw5chR6QhCehS46dC
         t93mjbe1kjjfUxVz+mYg3LKHPdpse7rDeu+HusV1/iVdtKCMtVlIBscjJDMDxA7Hhd2G
         BhDeDbUICfcpfsVjw4X5B6rhTINnrbkf2cHMNFkJQ4h6+zPGMkjeTGCJ2RKEOv4sFcc+
         aQGA==
X-Gm-Message-State: AOAM533seo6yo/A95AY8kldOiWTalCs11ZjwvrSlF9erchTi9Y5Ezk6N
        IccHoO+/oW+ZkQEnmW1o6pxmhQO+IA==
X-Google-Smtp-Source: ABdhPJy5kI058I2cgTCZQamlbwhD2RSanlfZAq00SNdVwO46A8RHSvGD2gvd12E/u/QveaCqpxRjKA==
X-Received: by 2002:a05:6870:d785:b0:d2:823a:94df with SMTP id bd5-20020a056870d78500b000d2823a94dfmr1860561oab.93.1645730380505;
        Thu, 24 Feb 2022 11:19:40 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f21-20020a4ada55000000b0031c16df28f9sm60232oou.42.2022.02.24.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 11:19:39 -0800 (PST)
Received: (nullmailer pid 3433528 invoked by uid 1000);
        Thu, 24 Feb 2022 19:19:38 -0000
Date:   Thu, 24 Feb 2022 13:19:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, matthias.bgg@gmail.com,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        jassisinghbrar@gmail.com, fparent@baylibre.com,
        yongqiang.niu@mediatek.com, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v4,2/5] dt-bindings: display: mediatek: add MT8186 SoC
 binding
Message-ID: <YhfaSqWInwgsu30x@robh.at.kernel.org>
References: <20220222052803.3570-1-rex-bc.chen@mediatek.com>
 <20220222052803.3570-3-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222052803.3570-3-rex-bc.chen@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 01:28:00PM +0800, Rex-BC Chen wrote:
> Add MT8186 SoC binding to AAL, CCORR, COLOR, DITHER, GAMMA, MUTEX,
> OVL, POSTMASK and RDMA.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,aal.yaml | 7 +++++++
>  .../bindings/display/mediatek/mediatek,ccorr.yaml          | 5 +++++
>  .../bindings/display/mediatek/mediatek,color.yaml          | 1 +
>  .../bindings/display/mediatek/mediatek,dither.yaml         | 1 +
>  .../bindings/display/mediatek/mediatek,gamma.yaml          | 1 +
>  .../bindings/display/mediatek/mediatek,mutex.yaml          | 2 ++
>  .../bindings/display/mediatek/mediatek,ovl-2l.yaml         | 5 +++++
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml | 5 +++++
>  .../bindings/display/mediatek/mediatek,postmask.yaml       | 5 +++++
>  .../bindings/display/mediatek/mediatek,rdma.yaml           | 1 +
>  10 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index 225f9dd726d2..3a5416937293 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -23,6 +23,8 @@ properties:
>      oneOf:
>        - items:
>            - const: mediatek,mt8173-disp-aal
> +      - items:
> +          - const: mediatek,mt8183-disp-aal

This patch is for 8186...

>        - items:
>            - enum:
>                - mediatek,mt2712-disp-aal
> @@ -31,6 +33,11 @@ properties:
>                - mediatek,mt8195-disp-aal
>            - enum:
>                - mediatek,mt8173-disp-aal
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-aal

> +          - enum:
> +              - mediatek,mt8183-disp-aal

There won't be more than 1 fallback, so use const rather than enum.

>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index 6894b6999412..8ac87b5896ac 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -30,6 +30,11 @@ properties:
>                - mediatek,mt8195-disp-ccorr
>            - enum:
>                - mediatek,mt8192-disp-ccorr
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-ccorr
> +          - enum:
> +              - mediatek,mt8183-disp-ccorr

Same here.

>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> index bc83155b3b4c..d0a4b9eb71fd 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> @@ -37,6 +37,7 @@ properties:
>        - items:
>            - enum:
>                - mediatek,mt8183-disp-color
> +              - mediatek,mt8186-disp-color
>                - mediatek,mt8192-disp-color
>                - mediatek,mt8195-disp-color
>            - enum:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> index 9d89297f5f1d..9a08514ed909 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> @@ -26,6 +26,7 @@ properties:
>            - const: mediatek,mt8183-disp-dither
>        - items:
>            - enum:
> +              - mediatek,mt8186-disp-dither
>                - mediatek,mt8192-disp-dither
>                - mediatek,mt8195-disp-dither
>            - enum:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> index 247baad147b3..6d96f6736d91 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> @@ -27,6 +27,7 @@ properties:
>            - const: mediatek,mt8183-disp-gamma
>        - items:
>            - enum:
> +              - mediatek,mt8186-disp-gamma
>                - mediatek,mt8192-disp-gamma
>                - mediatek,mt8195-disp-gamma
>            - enum:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> index 6eca525eced0..55391b5c08c4 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> @@ -34,6 +34,8 @@ properties:
>            - const: mediatek,mt8173-disp-mutex
>        - items:
>            - const: mediatek,mt8183-disp-mutex
> +      - items:
> +          - const: mediatek,mt8186-disp-mutex
>        - items:
>            - const: mediatek,mt8192-disp-mutex

All these single entry cases can be a single enum.

>        - items:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> index 611a2dbdefa4..f7f89485a5ae 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> @@ -25,6 +25,11 @@ properties:
>            - const: mediatek,mt8183-disp-ovl-2l
>        - items:
>            - const: mediatek,mt8192-disp-ovl-2l
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-ovl-2l
> +          - enum:
> +              - mediatek,mt8192-disp-ovl-2l
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> index e71f79bc2dee..110e6b2747bc 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> @@ -40,6 +40,11 @@ properties:
>                - mediatek,mt8195-disp-ovl
>            - enum:
>                - mediatek,mt8183-disp-ovl
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-ovl
> +          - enum:
> +              - mediatek,mt8192-disp-ovl
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> index 6ac1da2e8871..22c333d09465 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> @@ -23,6 +23,11 @@ properties:
>      oneOf:
>        - items:
>            - const: mediatek,mt8192-disp-postmask
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-postmask
> +          - enum:
> +              - mediatek,mt8192-disp-postmask
>  
>    reg:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> index 8ef821641672..4f1c935cdf70 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> @@ -39,6 +39,7 @@ properties:
>                - mediatek,mt2701-disp-rdma
>        - items:
>            - enum:
> +              - mediatek,mt8186-disp-rdma
>                - mediatek,mt8192-disp-rdma
>            - enum:
>                - mediatek,mt8183-disp-rdma
> -- 
> 2.18.0
> 
> 
