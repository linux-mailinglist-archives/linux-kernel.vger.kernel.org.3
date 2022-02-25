Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85544C4E29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 19:57:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiBYS6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 13:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiBYS6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 13:58:10 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F66260CFD;
        Fri, 25 Feb 2022 10:57:37 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id k22-20020a9d4b96000000b005ad5211bd5aso4252681otf.8;
        Fri, 25 Feb 2022 10:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x8VduacFeI2TtrIqE99cIVcfc9BkTJGt0d9uSUOVc7E=;
        b=WOew9d8LhibU+zZg6zht5O9gdJcvGFlHDftcqjeaeXzzNwsV0dR122W5LNh1WrkSab
         4YDpAyyIM/bIjody5VrjLlb0a6PHBRO08M8+fpeKcKvjQRNBQsMDAa+b3fczqcMSGyzL
         W90lN5iDc4KFnZleRMLEE7XemF/jtgphqpSHc10uxv2VgmRi7c8eCkrgQyJ13Gv5Xpeh
         1xoRGV1wxB3DzTxrlinmlE6ROLDnSUntlxLNi+FLRfG+WNRPOhuu2zEPtyidwQBynrVh
         OIYPklVmzJJFQJKC3cvn6nJd6jtIoYSbIlBAkWX/2UrxdbRl3nSZjOZSzwyI+keGTbhT
         Tp3w==
X-Gm-Message-State: AOAM532DsA9aWtYM2qXJBmx6gA5Kp4N8MM5HI/vZlNc1llrkMkvhFrEF
        vVoFsBtS1EhAi7bmJCf50w==
X-Google-Smtp-Source: ABdhPJyley6JPhi/AEjlC8FHuJ7ppAxof/WudVKlaHcQo3+Rn5IGxqe/9TCzVrCzQFJDLr4y/9d3LA==
X-Received: by 2002:a9d:6a43:0:b0:5af:6595:458c with SMTP id h3-20020a9d6a43000000b005af6595458cmr3452302otn.241.1645815456446;
        Fri, 25 Feb 2022 10:57:36 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u24-20020a4ae698000000b0031c286f2e0csm1451768oot.29.2022.02.25.10.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 10:57:35 -0800 (PST)
Received: (nullmailer pid 1247199 invoked by uid 1000);
        Fri, 25 Feb 2022 18:57:34 -0000
Date:   Fri, 25 Feb 2022 12:57:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Chun-Jie Chen <chun-jie.chen@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 01/15] dt-bindings: ARM: Mediatek: Add new document
 bindings of MT8186 clock
Message-ID: <YhkmnnIApvU7gRlZ@robh.at.kernel.org>
References: <20220221015258.913-1-chun-jie.chen@mediatek.com>
 <20220221015258.913-2-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221015258.913-2-chun-jie.chen@mediatek.com>
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

On Mon, Feb 21, 2022 at 09:52:44AM +0800, Chun-Jie Chen wrote:
> This patch adds the new binding documentation for system clock
> and functional clock on Mediatek MT8186.
> 
> Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,mt8186-clock.yaml   |  56 +++
>  .../mediatek/mediatek,mt8186-sys-clock.yaml   |  54 +++
>  include/dt-bindings/clock/mt8186-clk.h        | 445 ++++++++++++++++++
>  3 files changed, 555 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
>  create mode 100644 include/dt-bindings/clock/mt8186-clk.h
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
> new file mode 100644
> index 000000000000..373e8a100da3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek Functional Clock Controller for MT8186
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:

You need a '|' to preserve the formatting.

> +  The clock architecture in Mediatek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The devices provide clock gate control in different IP blocks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - mediatek,mt8186-imp_iic_wrap
> +          - mediatek,mt8186-mfgsys
> +          - mediatek,mt8186-wpesys
> +          - mediatek,mt8186-imgsys1
> +          - mediatek,mt8186-imgsys2
> +          - mediatek,mt8186-vdecsys
> +          - mediatek,mt8186-vencsys
> +          - mediatek,mt8186-camsys
> +          - mediatek,mt8186-camsys_rawa
> +          - mediatek,mt8186-camsys_rawb
> +          - mediatek,mt8186-mdpsys
> +          - mediatek,mt8186-ipesys
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    imp_iic_wrap: clock-controller@11017000 {
> +        compatible = "mediatek,mt8186-imp_iic_wrap";
> +        reg = <0x11017000 0x1000>;
> +        #clock-cells = <1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
> new file mode 100644
> index 000000000000..4c071dd66b76
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/arm/mediatek/mediatek,mt8186-sys-clock.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Mediatek System Clock Controller for MT8186
> +
> +maintainers:
> +  - Chun-Jie Chen <chun-jie.chen@mediatek.com>
> +
> +description:

And here.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +  The clock architecture in Mediatek like below
> +  PLLs -->
> +          dividers -->
> +                      muxes
> +                           -->
> +                              clock gate
> +
> +  The apmixedsys provides most of PLLs which generated from SoC 26m.
> +  The topckgen provides dividers and muxes which provide the clock source to other IP blocks.
> +  The infracfg_ao provides clock gate in peripheral and infrastructure IP blocks.
> +  The mcusys provides mux control to select the clock source in AP MCU.
> +  The device nodes also provide the system control capacity for configuration.
