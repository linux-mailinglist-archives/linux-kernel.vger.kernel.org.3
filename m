Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6364D547C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 23:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiCJWTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 17:19:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbiCJWTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 17:19:40 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8ED94F456;
        Thu, 10 Mar 2022 14:18:38 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id o106-20020a9d2273000000b005b21f46878cso5036537ota.3;
        Thu, 10 Mar 2022 14:18:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uVBl4IjExhMMGQyqVZdtBYxJhbtlhf7V3EID45rNLsk=;
        b=WIfaa4MTWFgPdWVPTIhscW20nxEv2YZRBZ6MKNUK6tA6jh7CuKuXJza6CnlyBR5zII
         YH37ztxy/f5SihWbQpbvht0FiVj5DQco41fFOGD0bUC9CQ4CIp7J8cjjHO+FO7RvlgSo
         Y30P8PLWwTLXveBxecjVxrn492bZhaj+a2B7ZHqwfk1IqqPMmHFioSGnGZNq+Vd+WXUK
         6JxXYSH3IES2Hhy1Qx3RfUnWdsy8t7iEmWK/W0JSHqmeFOmgzEEqNa1XPOhRMPCFhHop
         aFlU5bPBlR1zUCYhHwkuxufBGOqnpctoeNXMiyrJBK6GC3f3D8De0LWjk/KeR3kGVv3U
         xdbQ==
X-Gm-Message-State: AOAM533cVcQ4qmfod0yfrIYWqpiXMRoxHy9KqWpBpqeU8tBaG/3GOoPM
        NhNOml8Dvh4HIi7xji62mg==
X-Google-Smtp-Source: ABdhPJymVHkEV5XxQpBNmw5S/gpv0K8uSPo3RhUKisPITsq2PFiS19pD2qkEoukGiphCl2E24hUkYQ==
X-Received: by 2002:a9d:77d7:0:b0:5b2:29b0:70cb with SMTP id w23-20020a9d77d7000000b005b229b070cbmr3556144otl.276.1646950718003;
        Thu, 10 Mar 2022 14:18:38 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i126-20020acab884000000b002d9f958bceesm2925916oif.41.2022.03.10.14.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 14:18:36 -0800 (PST)
Received: (nullmailer pid 2185267 invoked by uid 1000);
        Thu, 10 Mar 2022 22:18:35 -0000
Date:   Thu, 10 Mar 2022 16:18:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Trevor Wu <trevor.wu@mediatek.com>
Cc:     broonie@kernel.org, tiwai@suse.com, matthias.bgg@gmail.com,
        alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aaronyu@google.com,
        yc.hung@mediatek.com
Subject: Re: [PATCH 5/5] dt-bindings: mediatek: mt8195: add
 mt8195-mt6359-max98390-rt5682 document
Message-ID: <Yip5O3t0Ymyc2h+p@robh.at.kernel.org>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
 <20220308072435.22460-6-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308072435.22460-6-trevor.wu@mediatek.com>
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

On Tue, Mar 08, 2022 at 03:24:35PM +0800, Trevor Wu wrote:
> This patch adds document for mt8195 board with mt6359, max98390 and
> rt5682.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../sound/mt8195-mt6359-max98390-rt5682.yaml  | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8195-mt6359-max98390-rt5682.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8195-mt6359-max98390-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8195-mt6359-max98390-rt5682.yaml
> new file mode 100644
> index 000000000000..7ec14d61b109
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8195-mt6359-max98390-rt5682.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8195-mt6359-max98390-rt5682.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT8195 with MT6359, MAX98390 and RT5682 ASoC sound card driver
> +
> +maintainers:
> +  - Trevor Wu <trevor.wu@mediatek.com>
> +
> +description:
> +  This binding describes the MT8195 sound card.
> +
> +properties:
> +  compatible:
> +    const: mediatek,mt8195_mt6359_max98390_rt5682

You have nodes for each of these components, why do we need new 
compatible string for each combination. You can figure out the 
combination by looking at each of those nodes.

Second, why does each combination need a new schema doc?

Rob
