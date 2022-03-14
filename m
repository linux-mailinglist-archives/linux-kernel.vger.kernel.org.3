Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD064D7F88
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238393AbiCNKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238366AbiCNKMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:12:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074E73BFB5;
        Mon, 14 Mar 2022 03:10:58 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CB5731F43E0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647252657;
        bh=l2qnNe5aHUhWfu86E5/2cq68eWfeDDGpLfM9uDUPrGU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K9iHtFO3YwWip0ZOT4aKOEyG2RVTdYwUWSwIItK6WMSyI5hgYceO52cM/KbJLhPE1
         EVDll5oMpCznI01fQFRcsHcqX6xmcHLWAez7iMTmcria2/KMEUoRxG1/ClsxOUjE5O
         pA5BGfXJYV654DOoS+GNf88F8WKb/x1cnCm7+O02VAowVJD3cktOzfBPk6k2KyUTDg
         83bDBhEd+5KF32IW4s/h6IMlsoL7wWovQa+lhUHaNag2YTKhxK7qsMvHP7aRJcFKec
         39mlUmfpfAJYD/o9Ot2LSFmKoYzseM80gpvv/HgTUZlrwLTAqTksh9p+W5IwX67Kim
         a8KCiZdHh06ZA==
Message-ID: <242e2897-03bb-78f5-9616-58790cce740e@collabora.com>
Date:   Mon, 14 Mar 2022 11:10:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V7 4/5] dt-bindings: display: mediatek: add MT8186 SoC
 binding
Content-Language: en-US
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, chunkuang.hu@kernel.org,
        matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        jassisinghbrar@gmail.com, fparent@baylibre.com,
        yongqiang.niu@mediatek.com, hsinyi@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220314090033.25773-1-rex-bc.chen@mediatek.com>
 <20220314090033.25773-5-rex-bc.chen@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220314090033.25773-5-rex-bc.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/03/22 10:00, Rex-BC Chen ha scritto:
> Add MT8186 SoC binding to AAL, CCORR, COLOR, DITHER, GAMMA, MUTEX,
> OVL, POSTMASK and RDMA.
> 
> Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/display/mediatek/mediatek,aal.yaml    | 4 ++++
>   .../devicetree/bindings/display/mediatek/mediatek,ccorr.yaml  | 4 ++++
>   .../devicetree/bindings/display/mediatek/mediatek,color.yaml  | 1 +
>   .../devicetree/bindings/display/mediatek/mediatek,dither.yaml | 1 +
>   .../devicetree/bindings/display/mediatek/mediatek,gamma.yaml  | 1 +
>   .../devicetree/bindings/display/mediatek/mediatek,mutex.yaml  | 1 +
>   .../devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml | 4 ++++
>   .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml    | 4 ++++
>   .../bindings/display/mediatek/mediatek,postmask.yaml          | 4 ++++
>   .../devicetree/bindings/display/mediatek/mediatek,rdma.yaml   | 1 +
>   10 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> index eaf23428b30d..c5562482e787 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> @@ -32,6 +32,10 @@ properties:
>                 - mediatek,mt8192-disp-aal
>                 - mediatek,mt8195-disp-aal
>             - const: mediatek,mt8173-disp-aal
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-aal
> +          - const: mediatek,mt8183-disp-aal
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> index 7766c806c102..63fb02014a56 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> @@ -29,6 +29,10 @@ properties:
>             - enum:
>                 - mediatek,mt8195-disp-ccorr
>             - const: mediatek,mt8192-disp-ccorr
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-ccorr
> +          - const: mediatek,mt8183-disp-ccorr
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> index 0c9095b0411e..d2f89ee7996f 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> @@ -36,6 +36,7 @@ properties:
>         - items:
>             - enum:
>                 - mediatek,mt8183-disp-color
> +              - mediatek,mt8186-disp-color
>                 - mediatek,mt8192-disp-color
>                 - mediatek,mt8195-disp-color
>             - const: mediatek,mt8173-disp-color
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> index 8180ed0a89ff..8ad8187c02d1 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dither.yaml
> @@ -26,6 +26,7 @@ properties:
>             - const: mediatek,mt8183-disp-dither
>         - items:
>             - enum:
> +              - mediatek,mt8186-disp-dither
>                 - mediatek,mt8192-disp-dither
>                 - mediatek,mt8195-disp-dither
>             - const: mediatek,mt8183-disp-dither
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> index 5f1825b4512b..a89ea0ea7542 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,gamma.yaml
> @@ -27,6 +27,7 @@ properties:
>             - const: mediatek,mt8183-disp-gamma
>         - items:
>             - enum:
> +              - mediatek,mt8186-disp-gamma
>                 - mediatek,mt8192-disp-gamma
>                 - mediatek,mt8195-disp-gamma
>             - const: mediatek,mt8183-disp-gamma
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> index b470fbb1b40a..3fdad71210b4 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> @@ -29,6 +29,7 @@ properties:
>         - mediatek,mt8167-disp-mutex
>         - mediatek,mt8173-disp-mutex
>         - mediatek,mt8183-disp-mutex
> +      - mediatek,mt8186-disp-mutex
>         - mediatek,mt8192-disp-mutex
>         - mediatek,mt8195-disp-mutex
>   
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> index da999ba53b7c..4e94f4e947ad 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl-2l.yaml
> @@ -25,6 +25,10 @@ properties:
>             - const: mediatek,mt8183-disp-ovl-2l
>         - items:
>             - const: mediatek,mt8192-disp-ovl-2l
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-ovl-2l
> +          - const: mediatek,mt8192-disp-ovl-2l
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> index 51f8235f1b1b..a2a27d0ca038 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ovl.yaml
> @@ -38,6 +38,10 @@ properties:
>             - enum:
>                 - mediatek,mt8195-disp-ovl
>             - const: mediatek,mt8183-disp-ovl
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-ovl
> +          - const: mediatek,mt8192-disp-ovl
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> index 2d769422e29f..654080bfbdfb 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,postmask.yaml
> @@ -23,6 +23,10 @@ properties:
>       oneOf:
>         - items:
>             - const: mediatek,mt8192-disp-postmask
> +      - items:
> +          - enum:
> +              - mediatek,mt8186-disp-postmask
> +          - const: mediatek,mt8192-disp-postmask
>   
>     reg:
>       maxItems: 1
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> index 9a6756f185ee..0882ae86e6c4 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,rdma.yaml
> @@ -38,6 +38,7 @@ properties:
>             - const: mediatek,mt2701-disp-rdma
>         - items:
>             - enum:
> +              - mediatek,mt8186-disp-rdma
>                 - mediatek,mt8192-disp-rdma
>             - const: mediatek,mt8183-disp-rdma
>   



