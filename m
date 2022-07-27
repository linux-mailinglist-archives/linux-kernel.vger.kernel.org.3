Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B01C85829C8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbiG0Pho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiG0Phm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:37:42 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A80E240A2;
        Wed, 27 Jul 2022 08:37:41 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id y197so12986894iof.12;
        Wed, 27 Jul 2022 08:37:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QAXqhb962aIF+ftcFUwpirKPlbeHs216pD+9zgAjWEc=;
        b=75a81m1Ay2PAY57CWeSNeM6nyw/X7Ni2kEZUhHKyYyeLW4f+88bsMcKJKP7oi/y/c1
         BsRcN3w0VuVeQpR1L6/4xedBsJHwAve6WHRvHtdyDkkL8FkGYXXo5v5UWP6rbcQR7Z7L
         iEiF9jbTcsEm4OhkvtkeFSZrUiIQ07d+SuMMbvcBTkdFN0l3mx/lRPCIODmyeyfmIi1u
         uQdRdmHM5Y8hCm/MxSD3uPYoVmlXzQ6Hc8n/NIN+7lVarmpdYzjpSEj1N/+aYlPPi6pi
         /OzZ7wMn47F4Q2FDolTcplJ7k/GlYH2FjwpGmarcIuG3INj22znL0D/dMZbCES2wci8D
         jjag==
X-Gm-Message-State: AJIora/VMota+NJhUrFYkTd5gVynYj5scD2pjy7/TQQpdLajtvQw2Aw7
        itFazi/TU6NauAWI9Q9zOqq8Km80wg==
X-Google-Smtp-Source: AGRyM1tl6GnTMx3GlitMQd3fxo7OT+8coqpF56gCqFXYRfojqWHVJci7W+cxzUvJrchYWakZoUqlOg==
X-Received: by 2002:a05:6638:3801:b0:341:68f6:932 with SMTP id i1-20020a056638380100b0034168f60932mr9412207jav.71.1658936260750;
        Wed, 27 Jul 2022 08:37:40 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id a6-20020a92a306000000b002dc0e7027edsm6877117ili.32.2022.07.27.08.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 08:37:40 -0700 (PDT)
Received: (nullmailer pid 2717776 invoked by uid 1000);
        Wed, 27 Jul 2022 15:37:38 -0000
Date:   Wed, 27 Jul 2022 09:37:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: clock: renesas,rzg2l: Document RZ/Five SoC
Message-ID: <20220727153738.GA2696116-robh@kernel.org>
References: <20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726174525.620-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 06:45:25PM +0100, Lad Prabhakar wrote:
> The CPG block on the RZ/Five SoC is almost identical to one found on the
> RZ/G2UL SoC. "renesas,r9a07g043-cpg" compatible string will be used on
> the RZ/Five SoC so to make this clear, update the comment to include
> RZ/Five SoC.

It's either the same part or it isn't. 'almost identical' doesn't sound 
like the former. Unless it's the former, it's a nak for me.

Litering the drivers with #ifdef CONFIG_ARM64/CONFIG_RISCV is not great 
either. That's not great for compile coverage and they have nothing to 
do with the architecture.

> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> Note the driver changes [0] have been already queued for v5.20.
> 
> [0] https://patchwork.kernel.org/project/linux-renesas-soc/cover/
> 20220622181723.13033-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> ---
>  Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> index d036675e0779..487f74cdc749 100644
> --- a/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> +++ b/Documentation/devicetree/bindings/clock/renesas,rzg2l-cpg.yaml
> @@ -24,7 +24,7 @@ description: |
>  properties:
>    compatible:
>      enum:
> -      - renesas,r9a07g043-cpg # RZ/G2UL{Type-1,Type-2}
> +      - renesas,r9a07g043-cpg # RZ/G2UL{Type-1,Type-2} and RZ/Five
>        - renesas,r9a07g044-cpg # RZ/G2{L,LC}
>        - renesas,r9a07g054-cpg # RZ/V2L
>        - renesas,r9a09g011-cpg # RZ/V2M
> -- 
> 2.17.1
> 
> 
