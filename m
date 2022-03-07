Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BAE4D0BD9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242917AbiCGXQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238337AbiCGXQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:16:29 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAB13DDCA;
        Mon,  7 Mar 2022 15:15:33 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso19895109ooi.1;
        Mon, 07 Mar 2022 15:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AI7+nqdRFcGCglUrZMOmz1VIH3qVmbPTfJ/l66ayM3Y=;
        b=rtbKvBPVCdyzqn+lsHNRSSPVE42XhvMHzdsH1qpQWQSlwNHTv3raqOzlACicxGqhmT
         EN+Mx/BtfvwDDRIPfMCex528orQXl7j17J3uzXz4Xb6cwe0/7EXJa8LH6V9s0//1jILS
         bvIcN812K65kyaijciEq+UkoGy0antvW4itkhAw2O+6KA/LrKlck5XjRypZqWmK9/nWj
         bQZoWl/Y/x+C3sh1aiyNmAziqPhya5y5c7xf7aTEaHT9vI1v8p4IucWcSmf6UuSVG6Ka
         O3im3eQp6pDPVj0Zq6BjtD4v8+9oax0mhM4Q4VWTJfxb34Y0XRyE8je1Uj2OaQHwC9dD
         5YtA==
X-Gm-Message-State: AOAM530uOaWp+aMY4TNlxMVxV+WDvnKdgNX2iAfn/X0mr/yCUI0ic/0q
        q9txR+ZUQst85OLGZSjUng==
X-Google-Smtp-Source: ABdhPJxeFOFFe9Vq2gohlV5XyQjqZbVfPdy2gBMuBEd/YoU/2W3BbN5NDiSR16FW9csAOMqydlNNvg==
X-Received: by 2002:a05:6870:a986:b0:da:b3f:3279 with SMTP id ep6-20020a056870a98600b000da0b3f3279mr741000oab.297.1646694932365;
        Mon, 07 Mar 2022 15:15:32 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj27-20020a056808199b00b002d49b02cb41sm7268602oib.22.2022.03.07.15.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 15:15:31 -0800 (PST)
Received: (nullmailer pid 3443222 invoked by uid 1000);
        Mon, 07 Mar 2022 23:15:30 -0000
Date:   Mon, 7 Mar 2022 17:15:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.or,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        stephane.leprovost@mediatek.com, khilman@baylibre.com
Subject: Re: [PATCH v4 2/7] dt-bindings: remoteproc: Add bindings for the
 MT8365 APU
Message-ID: <YiaSEtqLAAYmBYgh@robh.at.kernel.org>
References: <20220304161514.994128-1-abailon@baylibre.com>
 <20220304161514.994128-3-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304161514.994128-3-abailon@baylibre.com>
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

On Fri, Mar 04, 2022 at 05:15:09PM +0100, Alexandre Bailon wrote:
> This updates the Mediatek APU bindings to support the MT8365.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  .../bindings/remoteproc/mtk,apu.yaml          | 45 ++++++++++++++++---
>  1 file changed, 39 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> index b640aa96d678..388352ccb2b5 100644
> --- a/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/mtk,apu.yaml
> @@ -16,7 +16,9 @@ maintainers:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt8183-apu
> +    enum:
> +      - mediatek,mt8183-apu
> +      - mediatek,mt8365-apu
>  
>    reg:
>      maxItems: 1
> @@ -26,13 +28,11 @@ properties:
>  
>    clocks:
>      minItems: 3
> -    maxItems: 3
> +    maxItems: 8
>  
>    clock-names:
> -    items:
> -      - const: axi
> -      - const: ipu
> -      - const: jtag
> +    minItems: 3
> +    maxItems: 8
>  
>    iommus:
>      maxItems: 3
> @@ -69,6 +69,39 @@ required:
>  
>  additionalProperties: false
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8183-apu
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: axi
> +            - const: ipu
> +            - const: jtag
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - mediatek,mt8365-apu
> +    then:
> +      properties:
> +        clock-names:
> +          items:
> +            - const: if_ck
> +            - const: edma
> +            - const: ahb
> +            - const: axi
> +            - const: ipu
> +            - const: jtag
> +            - const: smi_cam
> +            - const: ifr_apu_axi

Keep the first 3 clocks the same as prior h/w and keep at the top level. 
Then the if/then just needs to set the number of entries to 3 or 8.

Rob
