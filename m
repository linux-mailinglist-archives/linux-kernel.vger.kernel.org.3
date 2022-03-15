Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09914D97D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346697AbiCOJjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346723AbiCOJjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:39:36 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D781D0E9;
        Tue, 15 Mar 2022 02:38:21 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 172021F436D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647337100;
        bh=2g+bi31SH2nt5LwkrpZcDsw8tRwzI6EeAAglevEM+O0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WVFUcQ7oKf62TwQkqJBIiau9mLy2Y7iMN9owG/L9eJtno70/6cwNGoySPzg7A5Zgs
         vSWSnJMZtP9+uWNPWu7Adei8JWaabvsolehkcPuj8yxc9svrJ2oiE4wXrABPtRmh0v
         flZlEqntv9hVNofoeDB3EpyvjPJR/JU1BNyDIVtK5Xp7nNZBVgBQg0NTfhgngN9L8a
         Xh/zZntxQG5vZFFv02CXCZksgzbuFBv/GSHbwm275ixE1iHnmx9oR+KWQmkchrQAks
         sGjM7pSHBpiKI5DOOfj/TandHt2yQ+PPzv4QNQNmwHDdX0R82+XaZpNx7vQyu+OcDw
         +o85KkyHv1Yrw==
Message-ID: <140282ef-5174-b86b-cca0-559c24fec2c0@collabora.com>
Date:   Tue, 15 Mar 2022 10:38:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH V4 2/6] dt-bindings: spi: Add compatible for MT7986
Content-Language: en-US
To:     Leilk Liu <leilk.liu@mediatek.com>, Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220315032411.2826-1-leilk.liu@mediatek.com>
 <20220315032411.2826-3-leilk.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220315032411.2826-3-leilk.liu@mediatek.com>
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

Il 15/03/22 04:24, Leilk Liu ha scritto:
> This patch adds dt-binding documentation for MT7986.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   .../devicetree/bindings/spi/mediatek,spi-mt65xx.yaml          | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index bfa44acb1bdd..7247a177466b 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -30,6 +30,10 @@ properties:
>                 - mediatek,mt8192-spi
>                 - mediatek,mt8195-spi
>             - const: mediatek,mt6765-spi
> +      - items:
> +          - enum:
> +              - mediatek,mt7986-spi-ipm
> +          - const: mediatek,spi-ipm
>         - items:
>             - enum:
>                 - mediatek,mt2701-spi


