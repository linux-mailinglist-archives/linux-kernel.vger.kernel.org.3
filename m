Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE4B57FDA2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 12:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234607AbiGYKgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234562AbiGYKgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 06:36:02 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752E91055A;
        Mon, 25 Jul 2022 03:36:00 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 817D266015E7;
        Mon, 25 Jul 2022 11:35:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658745359;
        bh=jEQh6kA6cG5l8Za0dnxbvc3C991fy8Px0Uzw5Xq3bXY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=iRyB95T2NEuTF+YHchnVkWaT9MeJrFWEHlwRmXCxBg5+S9wJrJh3SMNo783Om/Xqe
         LVWzCV4wsoRfy8I14Es5TDCugvgxzCDsKGU3SBC4vkPU3kdAlRvw7NCiXSOOtG6S9h
         iQY3DN8sTKYurDBZm4dU+5BNlE4BrVeN57GJ6bJsB+CVB3aAO6JMWWhovVxR6SJE9+
         B1/HL7WcKcDov3k/YeUO+ZdADFx8Fl69dNGc295BHPsRhx0a1NEdiSG+f+5vyv/aHD
         6Y2PoP6kxMLtMqls0LmziKVJYxmI8VNX+TflvUipBzGoi7imrdfVKMOskR7cFVKyke
         7v9TE6FJrgfdg==
Message-ID: <6a36c425-ca49-c7ec-69cd-f79dcce5bedc@collabora.com>
Date:   Mon, 25 Jul 2022 12:35:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: mt8186: Add gpio-line-names
 property
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20220725100253.10687-1-allen-kh.cheng@mediatek.com>
 <20220725100253.10687-2-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220725100253.10687-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/07/22 12:02, Allen-KH Cheng ha scritto:
> Add the 'gpio-line-names' property to mt8186-pinctrl, as this will be
> used in devicetrees to describe pin names.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> index 8a2bb8608291..6784885edc5c 100644
> --- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8186.yaml
> @@ -28,6 +28,8 @@ properties:
>     gpio-ranges:
>       maxItems: 1
>   
> +  gpio-line-names: true
> +
>     reg:
>       description: |
>         Physical address base for gpio base registers. There are 8 different GPIO

