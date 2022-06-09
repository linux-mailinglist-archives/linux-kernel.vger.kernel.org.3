Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E0D544E97
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbiFIOUU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243588AbiFIOT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:19:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2520F24AC9D;
        Thu,  9 Jun 2022 07:19:58 -0700 (PDT)
Received: from notapiano (unknown [169.150.201.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D51F166017AE;
        Thu,  9 Jun 2022 15:19:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654784396;
        bh=IGskQUzMVf3MzyO5y7ZT7G+KdfE9vPrMiktEA7GFgYA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlRMs5kW5b4iU2ZLeEfP6jBr1LtN1syhRX3o0xPqAdaydhDzhfNl3DGRnSdnbC+AB
         PRv+LTW1UFUdWBpQ2bsQOSRozNkWdYKVUeC69HiP+6/3izv/iXQ9BWUiNP/9HqJC3Q
         dzVkodprlPUZHIQyylbAVunC74S64lADKQKupaAIsQ9G0nYl7dN28bvG+EHxDkfE/q
         2Pp+WPxwiwChBKMq7gImqcsPaNTuTSs4oivcNE5eypIx54bnabZ718cbYMmYbkrZof
         JGjcPalmCiC5v63bpzpYvOsU7XIGcVui3p+RJKXndNx0TlqVPxaaz90Z3Z9BW+vL2R
         RxL8vyKohIyJg==
Date:   Thu, 9 Jun 2022 10:19:49 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Guodong Liu <guodong.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 1/2] dt-bindings: pinctrl: mt8192: Switch
 drive-strength-adv for -microamp
Message-ID: <20220609141949.j5h6esqjmoal3y2m@notapiano>
References: <20220531221954.160036-1-nfraprado@collabora.com>
 <20220531221954.160036-2-nfraprado@collabora.com>
 <1332454e2733d48fdf2396bcaed37bc3e33616b5.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1332454e2733d48fdf2396bcaed37bc3e33616b5.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guodong,

On Wed, Jun 08, 2022 at 04:08:13PM +0800, Guodong Liu wrote:
> -----Original Message-----
> From: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> To: Linus Walleij <linus.walleij@linaro.org>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com
> >, kernel@collabora.com, Nícolas F. R. A. Prado <
> nfraprado@collabora.com>, Krzysztof Kozlowski <
> krzysztof.kozlowski+dt@linaro.org>, Matthias Brugger <
> matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Sean Wang <
> sean.wang@mediatek.com>, devicetree@vger.kernel.org, 
> linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, 
> linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
> Subject: [PATCH v2 1/2] dt-bindings: pinctrl: mt8192: Switch drive-
> strength-adv for -microamp
> Date: Tue, 31 May 2022 18:19:53 -0400
> 
> Commit e5fabbe43f3f ("pinctrl: mediatek: paris: Support generic
> PIN_CONFIG_DRIVE_STRENGTH_UA") added support for using
> drive-strength-microamp instead of mediatek,drive-strength-adv.
> 
> Since there aren't any users of mediatek,drive-strength-adv on mt8192
> yet, remove this property and add drive-strength-microamp in its place,
> which has a clearer meaning.
> 
> While at it, add a new 'if' block to validate that drive-strength and
> drive-strength-microamp aren't used together, since they're mutually
> exclusive.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <
> angelogiocchino.delregno@collabora.com>
> ---
> 
> Changes in v2:
> - Added 'if' block to make drive-strength and drive-strength-microamp
>   mutually exclusive
> - Changed commit title to be more precise
> - Dropped Fixes tag
> 
>  .../bindings/pinctrl/pinctrl-mt8192.yaml      | 35 ++++++-------------
>  1 file changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-
> mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-
> mt8192.yaml
> index c90a132fbc79..c8092b218f2f 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
> @@ -80,31 +80,8 @@ patternProperties:
>                dt-bindings/pinctrl/mt65xx.h. It can only support
> 2/4/6/8/10/12/14/16mA in mt8192.
>              enum: [2, 4, 6, 8, 10, 12, 14, 16]
>  
> -          mediatek,drive-strength-adv:
> -            description: |
> -              Describe the specific driving setup property.
> -              For I2C pins, the existing generic driving setup can
> only support
> -              2/4/6/8/10/12/14/16mA driving. But in specific driving
> setup, they
> -              can support 0.125/0.25/0.5/1mA adjustment. If we enable
> specific
> -              driving setup, the existing generic setup will be
> disabled.
> -              The specific driving setup is controlled by E1E0EN.
> -              When E1=0/E0=0, the strength is 0.125mA.
> -              When E1=0/E0=1, the strength is 0.25mA.
> -              When E1=1/E0=0, the strength is 0.5mA.
> -              When E1=1/E0=1, the strength is 1mA.
> -              EN is used to enable or disable the specific driving
> setup.
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
> 
> Can't remove mediatek,drive-strength-adv property, I2C pins will ofter
> use this property

Yes, the point is that they should use drive-strength-microamp instead, which
does the exact same thing while also having a clearer meaning.

> 
> +          drive-strength-microamp:
> +            enum: [125, 250, 500, 1000]
>  
>            mediatek,pull-up-adv:
>              description: |
> @@ -138,6 +115,14 @@ patternProperties:
>          required:
>            - pinmux
>  
> +        allOf:
> +          - if:
> +              required:
> +                - drive-strength-microamp
> +            then:
> +              properties:
> +                drive-strength: false
> +
>          additionalProperties: false
>  
> Property drive-strength-microamp and drive-strength aren't exclusive,
> just i2c pins support drive-strength-microamp property .

They are exclusive in the sense that both drive-strength-microamp and
drive-strength shouldn't be used on the same pin configuration. The fact that
only i2c pins use drive-strength-microamp doesn't have to do with this, and is
perfectly fine.

Thanks,
Nícolas
