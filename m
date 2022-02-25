Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2674C4E42
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbiBYTEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiBYTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:04:20 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF77187B9A;
        Fri, 25 Feb 2022 11:03:46 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id w10-20020a4ae08a000000b0031bdf7a6d76so7444215oos.10;
        Fri, 25 Feb 2022 11:03:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W0Val0Ukv5fc/tGMu5TCj12Uoxf42dXInoyYE17+MPc=;
        b=C25gahPzRh+9JeejZUdSM0CUHge2nlMIB//3uNER0MDKCcHCJlJ4Gz7sCPyBLYO0pm
         VcVUIMIGhoHc0KWcQv11lqkz40Ap0Z1ex1U598hZDvqxqkeOCkTS4Czj9GdTl//9uZ35
         Zn7ZYcU590B2RtfFXe9R+6jtJqco8c99x2g+EdSdsSNacyHYmp4cTOHjmjXFiVCx1lIY
         8GVF8pexZ0/F/+BaYbX4DHsCf0IOqOzKOIafdjeLaESVFiFyyCGtGpFc/UdrYarHgdP3
         6oi0ZwUfXVPYB75KWp+NidU0911/vrjEvpaKo3stjMckkxze/DXD6SH31ks2V4+JJGjC
         BxUg==
X-Gm-Message-State: AOAM531dkGP0Z0u2v+CeXvX2dU1ZnoKrm1Ow66RqSS+9mz9RpK/tyM/r
        WL52A7UyVeh56x9ZFsm3oA==
X-Google-Smtp-Source: ABdhPJybIyDkpZ+VSbdLMj5yQB/PISufEfhnfVZJOC1EGYTqNwHN37uTAm7DrRhyXdvzgCvwBXnpjw==
X-Received: by 2002:a05:6870:ed48:b0:d2:40f0:1c02 with SMTP id ex8-20020a056870ed4800b000d240f01c02mr2018986oab.45.1645815826146;
        Fri, 25 Feb 2022 11:03:46 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e7-20020a056830200700b005a09222e268sm1539747otp.7.2022.02.25.11.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:03:45 -0800 (PST)
Received: (nullmailer pid 1255800 invoked by uid 1000);
        Fri, 25 Feb 2022 19:03:44 -0000
Date:   Fri, 25 Feb 2022 13:03:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH V2 5/6] dt-bindings: spi: support spi-hclk
Message-ID: <YhkoEJiLMs8jfUAm@robh.at.kernel.org>
References: <20220221040717.3729-1-leilk.liu@mediatek.com>
 <20220221040717.3729-6-leilk.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221040717.3729-6-leilk.liu@mediatek.com>
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

On Mon, Feb 21, 2022 at 12:07:16PM +0800, Leilk Liu wrote:
> this patch support spi-hclk.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> index 241c0f5880d3..6920ced5451e 100644
> --- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> +++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
> @@ -55,12 +55,14 @@ properties:
>        - description: clock used for the parent clock
>        - description: clock used for the muxes clock
>        - description: clock used for the clock gate
> +      - description: clock used for the AHB bus, this clock is optional

Not optional unless you have minItems.

>  
>    clock-names:

       minItems: 3


>      items:
>        - const: parent-clk
>        - const: sel-clk
>        - const: spi-clk
> +      - const: spi-hclk
>  
>    mediatek,pad-select:
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> -- 
> 2.25.1
> 
> 
