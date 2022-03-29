Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C484EB641
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 00:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238627AbiC2XAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 19:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238409AbiC2XAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 19:00:02 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3051035256;
        Tue, 29 Mar 2022 15:58:18 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-df22f50e0cso3090957fac.3;
        Tue, 29 Mar 2022 15:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LWrhu1SJIKP91XWNKb4WbsxhL8e6xpsiZxtyqvL5Z0w=;
        b=Xnuj1Hx4HXaavx/eFalHV+/z3zIFtcLolNMQIWttsSwwuHN5g/KWqt4Wetzju03Too
         mcm8pnqSIutkaRMg9MngS7KJdqJl/TBdrDFMdJz37HxsaXl7EVOSCYsBtaMp/BwuUiyl
         wQ0a3LPR1EMAqiNNPwd0p2qW9/26fvkw+qMgoHWYza/y/PkYHRliwx33Lxe7OO4eko6i
         FcMHIudyk3nTPNxS7kvhQbbmexz5oWpmCBxQl6q24zKfjhckIpg+p0/8T/Gmu0Xy5g92
         2f/Am+Z1aFj75FhemntP1sGuqRdBj6/THh3DGQX8x+D99UbwjT9nNPC2u9bZhjabh6FF
         jsfw==
X-Gm-Message-State: AOAM533OuZEDdGQLJyp7Vrx9JgkN3gm2k03JdCeKowlwux0M9KGBDrMZ
        VPiPsCRt289HX3wnKh1kWA==
X-Google-Smtp-Source: ABdhPJz+emekgDFz5mKWRmNRlRNMSrX19JPwwY5w06pHDZVUQBWmNvGk1+vhyDXsbkBHNm4tAEBj9Q==
X-Received: by 2002:a05:6870:a106:b0:de:de08:4e3d with SMTP id m6-20020a056870a10600b000dede084e3dmr859501oae.256.1648594697439;
        Tue, 29 Mar 2022 15:58:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id k22-20020a056870959600b000d277c48d18sm9802811oao.3.2022.03.29.15.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 15:58:16 -0700 (PDT)
Received: (nullmailer pid 1505955 invoked by uid 1000);
        Tue, 29 Mar 2022 22:58:15 -0000
Date:   Tue, 29 Mar 2022 17:58:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     airlied@linux.ie, angelogioacchino.delregno@collabora.com,
        chunfeng.yun@mediatek.com, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, daniel@ffwll.ch, deller@gmx.de,
        jitao.shi@mediatek.com, kishon@ti.com, krzk+dt@kernel.org,
        maarten.lankhorst@linux.intel.com, matthias.bgg@gmail.com,
        mripard@kernel.org, p.zabel@pengutronix.de, tzimmermann@suse.de,
        vkoul@kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-phy@lists.infradead.org, markyacoub@google.com
Subject: Re: [PATCH v9 03/22] dt-bindings: mediatek,dp_phy: Add Display Port
 PHY binding
Message-ID: <YkOPB5W7uXkOc72/@robh.at.kernel.org>
References: <20220327223927.20848-1-granquet@baylibre.com>
 <20220327223927.20848-4-granquet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327223927.20848-4-granquet@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 28, 2022 at 12:39:08AM +0200, Guillaume Ranquet wrote:
> This phy controller is embedded in the Display Port Controller on mt8195 SoCs.

Sorry, but I think you need to go back to what you had in v8. While yes, 
the phy and controller IP often do change independently, this h/w looks 
pretty interwined. 

You could make the controller a phy provider to itself if you wanted.

> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>  .../bindings/phy/mediatek,dp-phy.yaml         | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
> new file mode 100644
> index 000000000000..1f5ffca4e140
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dp-phy.yaml
> @@ -0,0 +1,43 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (c) 2022 MediaTek
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/mediatek,dp-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek Display Port PHY
> +
> +maintainers:
> +  - CK Hu <ck.hu@mediatek.com>
> +  - Jitao shi <jitao.shi@mediatek.com>
> +
> +description: |
> +  Device tree bindings for the Mediatek (embedded) Display Port PHY
> +  present on some Mediatek SoCs.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt8195-dp-phy
> +
> +  mediatek,dp-syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: Phandle to the Display Port node.
> +
> +  "#phy-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - mediatek,dp-syscon
> +  - "#phy-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    dp_phy: dp-phy {
> +      compatible = "mediatek,mt8195-dp-phy";
> +      mediatek,dp-syscon = <&dp_tx>;
> +      #phy-cells = <0>;
> +    };
> -- 
> 2.34.1
> 
> 
