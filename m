Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046535674C9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233117AbiGEQt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiGEQt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:49:56 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B961C91C;
        Tue,  5 Jul 2022 09:49:55 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4244D66015BA;
        Tue,  5 Jul 2022 17:49:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657039794;
        bh=O8jFid3HFahUb6CdvHaa5HDpKka2L1ZdaQ61QOug694=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V8wRfYT+p8U2kki+8gVIOMH8qrhWZdeUXZ3zh8edA5On+1977a/tPGDlt5HSWbkXM
         WqgL3BVXmCdpvJVnEmU/kyXca09aKSa2JF/cPUybSj89B+hVUxGNK6i7AnKOGkmcig
         j+N1Si6n6rkUbPnkif7i0P7iR/UNGy/mmLgvhhMTcsxqsCFxe9rkbpUmhhp9BfPRr1
         LWW12vjnsCz+a7sA8rH6zmQzHd275mUSku6bEVsbZFhoEvYUm6K7yZQtLyJhyMObQ1
         h92pCxPRInF63LdDsUbcgUAV0VJvkgcWKnqsH/vzkHuTOwbT5tCHh7vSZHVIY1oEGX
         9eix4tSIEjAFw==
Date:   Tue, 5 Jul 2022 12:49:49 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Add and use
 drive-strength-microamp
Message-ID: <20220705164949.x7k542iugl6uffpx@notapiano>
References: <20220630131543.225554-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630131543.225554-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 03:15:43PM +0200, AngeloGioacchino Del Regno wrote:
> As was already done for MT8192 in commit b52e695324bb ("dt-bindings:
> pinctrl: mt8192: Add drive-strength-microamp"), replace the custom
> mediatek,drive-strength-adv property with the standardized pinconf
> 'drive-strength-microamp' one.
> 
> Similarly to the mt8192 counterpart, there's no user of property
> 'mediatek,drive-strength-adv', hence removing it is safe.
> 
> Fixes: 69c3d58dc187 ("dt-bindings: pinctrl: mt8195: Add mediatek,drive-strength-adv property")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Ideally we'd prevent using drive-strength-microamp together with drive-strength,
like I intended to do on v2 of the patch [1], just as an extra sanity check. But
that could be added later on top, so

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

[1] https://lore.kernel.org/all/20220531221954.160036-2-nfraprado@collabora.com/

> ---
>  .../bindings/pinctrl/pinctrl-mt8195.yaml      | 27 ++-----------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> index b0fea44403e7..85e96a5e1708 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8195.yaml
> @@ -100,31 +100,8 @@ patternProperties:
>            drive-strength:
>              enum: [2, 4, 6, 8, 10, 12, 14, 16]
>  
> -          mediatek,drive-strength-adv:
> -            description: |
> -              Describe the specific driving setup property.
> -              For I2C pins, the existing generic driving setup can only support
> -              2/4/6/8/10/12/14/16mA driving. But in specific driving setup, they
> -              can support 0.125/0.25/0.5/1mA adjustment. If we enable specific
> -              driving setup, the existing generic setup will be disabled.
> -              The specific driving setup is controlled by E1E0EN.
> -              When E1=0/E0=0, the strength is 0.125mA.
> -              When E1=0/E0=1, the strength is 0.25mA.
> -              When E1=1/E0=0, the strength is 0.5mA.
> -              When E1=1/E0=1, the strength is 1mA.
> -              EN is used to enable or disable the specific driving setup.
> -              Valid arguments are described as below:
> -              0: (E1, E0, EN) = (0, 0, 0)
> -              1: (E1, E0, EN) = (0, 0, 1)
> -              2: (E1, E0, EN) = (0, 1, 0)
> -              3: (E1, E0, EN) = (0, 1, 1)
> -              4: (E1, E0, EN) = (1, 0, 0)
> -              5: (E1, E0, EN) = (1, 0, 1)
> -              6: (E1, E0, EN) = (1, 1, 0)
> -              7: (E1, E0, EN) = (1, 1, 1)
> -              So the valid arguments are from 0 to 7.
> -            $ref: /schemas/types.yaml#/definitions/uint32
> -            enum: [0, 1, 2, 3, 4, 5, 6, 7]
> +          drive-strength-microamp:
> +            enum: [125, 250, 500, 1000]
>  
>            bias-pull-down:
>              oneOf:
> -- 
> 2.35.1
> 
