Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33FD50DD60
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 11:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbiDYJ6f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Apr 2022 05:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236396AbiDYJ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 05:58:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E94927B37
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 02:55:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivQo-0000BN-KW; Mon, 25 Apr 2022 11:54:58 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivQm-0057X6-An; Mon, 25 Apr 2022 11:54:54 +0200
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nivQj-000548-UV; Mon, 25 Apr 2022 11:54:53 +0200
Message-ID: <b699a15ae2e810e20d7c388bc347f57d0a951513.camel@pengutronix.de>
Subject: Re: [PATCH v17 03/21] dt-bindings: mediatek: add ethdr definition
 for mt8195
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     "Nancy.Lin" <nancy.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        wim@linux-watchdog.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, linux@roeck-us.net
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, llvm@lists.linux.dev,
        singo.chang@mediatek.com, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 25 Apr 2022 11:54:53 +0200
In-Reply-To: <20220416020749.29010-4-nancy.lin@mediatek.com>
References: <20220416020749.29010-1-nancy.lin@mediatek.com>
         <20220416020749.29010-4-nancy.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nancy,

On Sa, 2022-04-16 at 10:07 +0800, Nancy.Lin wrote:
> Add vdosys1 ETHDR definition.
> 
> Signed-off-by: Nancy.Lin <nancy.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../display/mediatek/mediatek,ethdr.yaml      | 158 ++++++++++++++++++
>  1 file changed, 158 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> new file mode 100644
> index 000000000000..e8303c28a361
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,ethdr.yaml
> @@ -0,0 +1,158 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/mediatek/mediatek,ethdr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek Ethdr Device Tree Bindings
> +
> +maintainers:
> +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> +  - Philipp Zabel <p.zabel@pengutronix.de>
> +
> +description: |
> +  ETHDR is designed for HDR video and graphics conversion in the external display path.
> +  It handles multiple HDR input types and performs tone mapping, color space/color
> +  format conversion, and then combine different layers, output the required HDR or
> +  SDR signal to the subsequent display path. This engine is composed of two video
> +  frontends, two graphic frontends, one video backend and a mixer. ETHDR has two
> +  DMA function blocks, DS and ADL. These two function blocks read the pre-programmed
> +  registers from DRAM and set them to HW in the v-blanking period.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: mediatek,mt8195-disp-ethdr
> +  reg:
> +    maxItems: 7
> +  reg-names:
> +    items:
> +      - const: mixer
> +      - const: vdo_fe0
> +      - const: vdo_fe1
> +      - const: gfx_fe0
> +      - const: gfx_fe1
> +      - const: vdo_be
> +      - const: adl_ds
> +  interrupts:
> +    minItems: 1
> +  iommus:
> +    description: The compatible property is DMA function blocks.
> +      Should point to the respective IOMMU block with master port as argument,
> +      see Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml for
> +      details.
> +    minItems: 1
> +    maxItems: 2
> +  clocks:
> +    items:
> +      - description: mixer clock
> +      - description: video frontend 0 clock
> +      - description: video frontend 1 clock
> +      - description: graphic frontend 0 clock
> +      - description: graphic frontend 1 clock
> +      - description: video backend clock
> +      - description: autodownload and menuload clock
> +      - description: video frontend 0 async clock
> +      - description: video frontend 1 async clock
> +      - description: graphic frontend 0 async clock
> +      - description: graphic frontend 1 async clock
> +      - description: video backend async clock
> +      - description: ethdr top clock
> +  clock-names:
> +    items:
> +      - const: mixer
> +      - const: vdo_fe0
> +      - const: vdo_fe1
> +      - const: gfx_fe0
> +      - const: gfx_fe1
> +      - const: vdo_be
> +      - const: adl_ds
> +      - const: vdo_fe0_async
> +      - const: vdo_fe1_async
> +      - const: gfx_fe0_async
> +      - const: gfx_fe1_async
> +      - const: vdo_be_async
> +      - const: ethdr_top
> +  power-domains:
> +    maxItems: 1
> +  resets:
> +    maxItems: 5

Please add a reset-names property and name these resets.

regards
Philipp
