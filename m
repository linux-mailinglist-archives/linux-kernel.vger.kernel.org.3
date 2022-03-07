Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08F74CFBB0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240589AbiCGKoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:44:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237112AbiCGKdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:33:05 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C45795A0C;
        Mon,  7 Mar 2022 02:04:34 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0F2221F438C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646647464;
        bh=akkWSIz129iQdVE9EdcCfmhbLkwDOC2Ls9BA6Lqns8o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JHetwUEXVVtlHNdaWkTB6iB5i+xvG7UClAYqgaw9WdExhIDZIL/E7/GZBs6uYKzb8
         O69agPkVKq/6eYLCL/eVhcAYxVT5Ol9LWHCP5AvHgP8LEFnRWkC/MXFYqt+cEBzM93
         D5zNh5ScTN6moPOIBfv9DS05SiyAFwlHXFbbHc0a7ofBxr/tKjxK+HfJtYqlrisfee
         irpfEhr43HUsMsbdcrnidtxcF5VDUDZEzL8vbucRIvJT5tu4cWOJ8ybloHnXOpSUvw
         YityDllj4q2LS8vtuZpcb0kPWd9z4Bmo3zr2+qLuRS11zFunvn5OyoDYaUM/gDtxQc
         /gHtBgCu+agwA==
Message-ID: <1abbd1bc-58b7-ee30-76e4-e60a842de433@collabora.com>
Date:   Mon, 7 Mar 2022 11:04:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v16 1/8] dt-bindings: soc: mediatek: move out common
 module from display folder
Content-Language: en-US
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        hsinyi@chromium.org, fshao@chromium.org, moudy.ho@mediatek.com,
        roy-cw.yeh@mediatek.com, CK Hu <ck.hu@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>, nancy.lin@mediatek.com,
        singo.chang@mediatek.com, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jason-jh lin <jason-jh.lin@mediatek.corp-partner.google.com>
References: <20220307032859.3275-1-jason-jh.lin@mediatek.com>
 <20220307032859.3275-2-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220307032859.3275-2-jason-jh.lin@mediatek.com>
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

Il 07/03/22 04:28, jason-jh.lin ha scritto:
> From: jason-jh lin <jason-jh.lin@mediatek.corp-partner.google.com>
> 
> AAL, COLOR, CCORR, MUTEX, WDMA could be used by other modules,
> such as MDP, so move their binding document into the common folder.
> 
> Signed-off-by: jason-jh lin <jason-jh.lin@mediatek.corp-partner.google.com>

Hello jason-jh,

I understand that these dt-bindings can eventually be reused by MDP3, and
this change is welcome, as duplication wouldn't be sane, however, this is
not the right series for that to happen.

If you want to move these bindings around, you should do that in the patch
series that actually also adds the compatibles for MDP3 in these modules.

If there's no MDP3-specific compatible for these modules, then you should
not move them from display, as this is documentation for mediatek-drm and
it's (currently) the only provider of these.

Please remove this patch from the vdosys0 series for MT8195 because it is
not adding any compatible that justifies moving these YAML around.

Regards,
Angelo

> ---
>   .../{display => soc}/mediatek/mediatek,aal.yaml     | 13 ++++---------
>   .../{display => soc}/mediatek/mediatek,ccorr.yaml   | 13 ++++---------
>   .../{display => soc}/mediatek/mediatek,color.yaml   | 13 ++++---------
>   .../{display => soc}/mediatek/mediatek,mutex.yaml   | 12 +++---------
>   .../{display => soc}/mediatek/mediatek,wdma.yaml    |  9 ++-------
>   5 files changed, 17 insertions(+), 43 deletions(-)
>   rename Documentation/devicetree/bindings/{display => soc}/mediatek/mediatek,aal.yaml (81%)
>   rename Documentation/devicetree/bindings/{display => soc}/mediatek/mediatek,ccorr.yaml (80%)
>   rename Documentation/devicetree/bindings/{display => soc}/mediatek/mediatek,color.yaml (83%)
>   rename Documentation/devicetree/bindings/{display => soc}/mediatek/mediatek,mutex.yaml (82%)
>   rename Documentation/devicetree/bindings/{display => soc}/mediatek/mediatek,wdma.yaml (85%)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,aal.yaml
> similarity index 81%
> rename from Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> rename to Documentation/devicetree/bindings/soc/mediatek/mediatek,aal.yaml
> index 4fdc9b3283b0..08934b10b54e 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,aal.yaml
> @@ -1,22 +1,17 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>   %YAML 1.2
>   ---
> -$id: http://devicetree.org/schemas/display/mediatek/mediatek,aal.yaml#
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,aal.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: Mediatek display adaptive ambient light processor
> +title: Mediatek adaptive ambient light processor
>   
>   maintainers:
> -  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> -  - Philipp Zabel <p.zabel@pengutronix.de>
> +  - Matthias Brugger <matthias.bgg@gmail.com>
>   
>   description: |
> -  Mediatek display adaptive ambient light processor, namely AAL,
> +  Mediatek adaptive ambient light processor, namely AAL,
>     is responsible for backlight power saving and sunlight visibility improving.
> -  AAL device node must be siblings to the central MMSYS_CONFIG node.
> -  For a description of the MMSYS_CONFIG binding, see
> -  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> -  for details.
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
> similarity index 80%
> rename from Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> rename to Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
> index 0ed53b6238f0..bf52b7b53475 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,ccorr.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,ccorr.yaml
> @@ -1,22 +1,17 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>   %YAML 1.2
>   ---
> -$id: http://devicetree.org/schemas/display/mediatek/mediatek,ccorr.yaml#
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,ccorr.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: Mediatek display color correction
> +title: Mediatek color correction
>   
>   maintainers:
> -  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> -  - Philipp Zabel <p.zabel@pengutronix.de>
> +  - Matthias Brugger <matthias.bgg@gmail.com>
>   
>   description: |
> -  Mediatek display color correction, namely CCORR, reproduces correct color
> +  Mediatek color correction, namely CCORR, reproduces correct color
>     on panels with different color gamut.
> -  CCORR device node must be siblings to the central MMSYS_CONFIG node.
> -  For a description of the MMSYS_CONFIG binding, see
> -  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> -  for details.
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,color.yaml
> similarity index 83%
> rename from Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> rename to Documentation/devicetree/bindings/soc/mediatek/mediatek,color.yaml
> index 3ad842eb5668..91ff2adcf390 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,color.yaml
> @@ -1,23 +1,18 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>   %YAML 1.2
>   ---
> -$id: http://devicetree.org/schemas/display/mediatek/mediatek,color.yaml#
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,color.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
> -title: Mediatek display color processor
> +title: Mediatek color processor
>   
>   maintainers:
> -  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> -  - Philipp Zabel <p.zabel@pengutronix.de>
> +  - Matthias Brugger <matthias.bgg@gmail.com>
>   
>   description: |
> -  Mediatek display color processor, namely COLOR, provides hue, luma and
> +  Mediatek color processor, namely COLOR, provides hue, luma and
>     saturation adjustments to get better picture quality and to have one panel
>     resemble the other in their output characteristics.
> -  COLOR device node must be siblings to the central MMSYS_CONFIG node.
> -  For a description of the MMSYS_CONFIG binding, see
> -  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> -  for details.
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> similarity index 82%
> rename from Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> rename to Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> index 00e6a1041a9b..d334050105db 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,mutex.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
> @@ -1,25 +1,19 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>   %YAML 1.2
>   ---
> -$id: http://devicetree.org/schemas/display/mediatek/mediatek,mutex.yaml#
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,mutex.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
>   title: Mediatek mutex
>   
>   maintainers:
> -  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> -  - Philipp Zabel <p.zabel@pengutronix.de>
> +  - Matthias Brugger <matthias.bgg@gmail.com>
>   
>   description: |
>     Mediatek mutex, namely MUTEX, is used to send the triggers signals called
> -  Start Of Frame (SOF) / End Of Frame (EOF) to each sub-modules on the display
> -  data path or MDP data path.
> +  Start Of Frame(SOF) / End Of Frame(EOF) to each sub-modules on the data path.
>     In some SoC, such as mt2701, MUTEX could be a hardware mutex which protects
>     the shadow register.
> -  MUTEX device node must be siblings to the central MMSYS_CONFIG node.
> -  For a description of the MMSYS_CONFIG binding, see
> -  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> -  for details.
>   
>   properties:
>     compatible:
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> similarity index 85%
> rename from Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> rename to Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> index 7d7cc1ab526b..a6f9e1b3268d 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,wdma.yaml
> +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,wdma.yaml
> @@ -1,22 +1,17 @@
>   # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>   %YAML 1.2
>   ---
> -$id: http://devicetree.org/schemas/display/mediatek/mediatek,wdma.yaml#
> +$id: http://devicetree.org/schemas/soc/mediatek/mediatek,wdma.yaml#
>   $schema: http://devicetree.org/meta-schemas/core.yaml#
>   
>   title: Mediatek Write Direct Memory Access
>   
>   maintainers:
> -  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> -  - Philipp Zabel <p.zabel@pengutronix.de>
> +  - Matthias Brugger <matthias.bgg@gmail.com>
>   
>   description: |
>     Mediatek Write Direct Memory Access(WDMA) component used to write
>     the data into DMA.
> -  WDMA device node must be siblings to the central MMSYS_CONFIG node.
> -  For a description of the MMSYS_CONFIG binding, see
> -  Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> -  for details.
>   
>   properties:
>     compatible:

