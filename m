Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFD9583C71
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiG1Ksj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236441AbiG1KsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:48:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB94CB71;
        Thu, 28 Jul 2022 03:47:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4141D6601B41;
        Thu, 28 Jul 2022 11:47:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1659005232;
        bh=52n7PHwmDL6kd/nck7jvKAORL1LBHXn0wmr3omuwlBY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AFvQ9LOuwaw0rEK8BdCFvFrI6MdC7fwdOpvPQQ9YZTCAUefSKlOMaEnCMKmsOMA/h
         mvIavrISnspLyNInaQ2/X3/bLjCdaGCVV1f6/7iVcBwTaaaTNgk3eCFeFzyPRyVzHs
         tzKupXQkpH93I7E6mSVwpD1lKfEdnbmwozdWJEbaFfggd04L0dUJ3HTsmD9T0SBuoI
         MpGOV515alobiIHhwlS9TYyEBHcNMaIZwwpYYR4I4RYrNq68FKKW/rOtvDTYGeO8T8
         6RCE5ZBJZZwrDmenZz6Vq375eMkKcEAdwhRE1YJrczdWD1EcnxnreKMYz2XDfqDNFu
         hwAHD1WZXEjHA==
Message-ID: <caa39600-d56f-9748-9a93-aa9be2f88924@collabora.com>
Date:   Thu, 28 Jul 2022 12:47:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/2] dt-bindings: pinctrl: mediatek: Add support for
 mt8188
Content-Language: en-US
To:     Hui Liu <hui.liu@mediatek.com>, linus.walleij@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        jianguo.zhang@mediatek.com, zhiyong.tao@mediatek.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220728084951.22102-1-hui.liu@mediatek.com>
 <20220728084951.22102-2-hui.liu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220728084951.22102-2-hui.liu@mediatek.com>
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

Il 28/07/22 10:49, Hui Liu ha scritto:
> From: "Hui.Liu" <hui.liu@mediatek.com>
> 
> Add the pinctrl header file on MediaTek mt8188.
> Add the new binding document for pinctrl on MediaTek mt8188.
> 
> Signed-off-by: Hui.Liu <hui.liu@mediatek.com>
> ---
>   .../pinctrl/mediatek,mt8188-pinctrl.yaml      |  224 +++
>   .../pinctrl/mediatek,mt8188-pinfunc.h         | 1280 +++++++++++++++++
>   2 files changed, 1504 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
>   create mode 100644 include/dt-bindings/pinctrl/mediatek,mt8188-pinfunc.h
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
> new file mode 100644
> index 000000000000..87c72b621188
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/mediatek,mt8188-pinctrl.yaml
> @@ -0,0 +1,224 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/mediatek,mt8188-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT8188 Pin Controller
> +
> +maintainers:
> +  - Hui Liu <hui.liu@mediatek.com>
> +
> +description: |
> +  The MediaTek's MT8188 Pin controller is used to control SoC pins.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8188-pinctrl
> +
> +  gpio-controller: true
> +
> +  '#gpio-cells':
> +    description: |
> +      Number of cells in GPIO specifier, should be two. The first cell
> +      is the pin number, the second cell is used to specify optional
> +      parameters which are defined in <dt-bindings/gpio/gpio.h>.
> +    const: 2
> +
> +  gpio-ranges:
> +    maxItems: 1
> +

Please allow to specify gpio names

   gpio-line-names: true

after which:
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> +  reg:
> +    items:
> +      - description: gpio registers base address
> +      - description: rm group io configuration registers base address
> +      - description: lt group io configuration registers base address
> +      - description: lm group io configuration registers base address
> +      - description: rt group io configuration registers base address
> +      - description: enit registers base address
> +
