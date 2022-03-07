Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8214CFC5C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbiCGLLO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241895AbiCGLKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:10:35 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7EA5373E;
        Mon,  7 Mar 2022 02:32:49 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 75C481F43920
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646649168;
        bh=PesHG5E9XWbmSJlu7I167mK5yVdbSK02UCAMGo049pQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Dw5qXgQNfkLcKFLIdYteeaVz2PeRPjWRY/Y0R8CXAB/5hXopw9c+kg+ANQXd+iV9G
         EPNAP9xDxiEPo2IEgk7Hi2tGGluboOOm/FZGeyxRkvhUcHnWn5AJZdlgxIuh1LkWdg
         0fnXNz8PwHnQcqOuf+rDwI44j186+HSaz5B5Xvn6oW2kQ8Q4vnkhc844IAm45X04Gg
         oCFPYxo7bmVWbXs20PUvlNfVn9/dp/FzCwK8biefNwLL83o2tX7lYGQto7YVIP+v95
         HMslHNz0F4DIlgiRQpDT1jsoN2ayKflymDDDGdDRIRqMAwqnHmb2xMt2ZUjCJBeNVo
         En4ZaIuBYE2qA==
Message-ID: <b3950b6b-bfbe-da80-90cc-1a836958f931@collabora.com>
Date:   Mon, 7 Mar 2022 11:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V3 2/7] dt-bindings: spi: Add compatible for MT7986 with
 single mode
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org, Rob Herring <robh@kernel.org>
References: <20220307065230.12655-1-leilk.liu@mediatek.com>
 <20220307065230.12655-3-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220307065230.12655-3-leilk.liu@mediatek.com>
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

Il 07/03/22 07:52, Leilk Liu ha scritto:
> This patch adds dt-binding documentation for MT7986 with single mode.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index bfa44acb1bdd..48024b98408a 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -41,6 +41,7 @@ properties:
>                 - mediatek,mt8135-spi
>                 - mediatek,mt8173-spi
>                 - mediatek,mt8183-spi
> +              - mediatek,mt7986-spi-single
>   
>     reg:
>       maxItems: 1

I think that the best way to do this is to better organize the compatibles
per-hardware, here... or the compatibles list will eventually grow out of
control for little reason.

Since "IPM" is a new SPI controller IP, I would expect more and more MediaTek
SoCs using it in the future, so here's my proposal:

- Add a generic (const) compatible "mediatek,spi-ipm" to describe the hardware
- Add an enumeration with "mediatek,mt7986-spi-ipm" as the only member, as to
   prepare this binding for the future.
- Single and quad mode can be expressed with generic SPI bindings!

Specifically, you can express that with "spi-rx-bus-width" for SPI_RX_{....}
and "spi-tx-bus-width" for SPI_TX_{....}, so you don't need different compatibles
for "mediatek,mt7986-spi-single" and "mediatek,mt7896-spi-quad".

Fast example:

spi@12345678 {
     compatible = "mediatek,mt7986-spi-ipm", "mediatek,spi-ipm";
     reg = <....>
     /* Quad mode */
     spi-rx-bus-width = <4>;
     spi-tx-bus-width = <4>;

     .... etc ....
}

Regards,
Angelo


