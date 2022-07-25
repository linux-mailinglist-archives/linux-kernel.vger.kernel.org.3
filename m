Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD14557FBD3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbiGYIzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbiGYIzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:55:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679531570E;
        Mon, 25 Jul 2022 01:55:03 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7458A66015E7;
        Mon, 25 Jul 2022 09:55:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658739302;
        bh=nenqEXGE3IZ9WGlkTsG5lPONpJPHRhKFYXZDmTqECdI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WAeB++PMD2Q3OW6jvKBbTHRH/GguC5+j7kc2/SeN3LxTUPqFMfMI2W258cB5wzNsZ
         DOgzugrOVAF9PLuE/j5mhADUphce4THMaCOXb7tY+4OW74ei1QrUHbwOebai15LGqw
         XoIH5eJqvkj3Z9STb32V7WBPAeFigUlntNvcY0nqHzAhinjWwdlfRl7lJtoYYvZBn0
         dowOlDBRF7Zlinl1Wre+aE89MvlxdV+XwfemuXkPTeULRwAYjKtZYxe1rjKhTEyQ3X
         LJOItWOrTOAHIJFh4Q9/s3083dWTXC4/RrVDDpcXRCDIlQFhuj2hY1XXeQRF6EHlnc
         67pTYig+XLztQ==
Message-ID: <bbdde7ce-4512-2e61-5e1a-e22e5cb91184@collabora.com>
Date:   Mon, 25 Jul 2022 10:54:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] dt-bindings: power: Add MT8365 power domains
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Fabien Parent <parent.f@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
References: <20220725081853.1636444-1-msp@baylibre.com>
 <20220725081853.1636444-2-msp@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220725081853.1636444-2-msp@baylibre.com>
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

Il 25/07/22 10:18, Markus Schneider-Pargmann ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add power domains dt-bindings for MT8365.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
> 
> Notes:
>      Changes in v2:
>      - Made include/dt-bindings/power/mt8365-power.h dual-license.
> 
>   .../power/mediatek,power-controller.yaml      |  2 ++
>   include/dt-bindings/power/mt8365-power.h      | 19 +++++++++++++++++++
>   2 files changed, 21 insertions(+)
>   create mode 100644 include/dt-bindings/power/mt8365-power.h
> 
> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> index 135c6f722091..2c6d3e4246b2 100644
> --- a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
> @@ -29,6 +29,7 @@ properties:
>         - mediatek,mt8186-power-controller
>         - mediatek,mt8192-power-controller
>         - mediatek,mt8195-power-controller
> +      - mediatek,mt8365-power-controller
>   
>     '#power-domain-cells':
>       const: 1
> @@ -67,6 +68,7 @@ patternProperties:
>                 "include/dt-bindings/power/mt8183-power.h" - for MT8183 type power domain.
>                 "include/dt-bindings/power/mt8192-power.h" - for MT8192 type power domain.
>                 "include/dt-bindings/power/mt8195-power.h" - for MT8195 type power domain.
> +              "include/dt-bindings/power/mt8365-power.h" - for MT8365 type power domain.
>           maxItems: 1
>   
>         clocks:
> diff --git a/include/dt-bindings/power/mt8365-power.h b/include/dt-bindings/power/mt8365-power.h
> new file mode 100644
> index 000000000000..e6cfd0ec7871
> --- /dev/null
> +++ b/include/dt-bindings/power/mt8365-power.h

Please rename this file to add the vendor prefix.

mediatek,mt8365-power.h

Thanks,
Angelo

