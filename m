Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84502587E93
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 17:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbiHBPHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 11:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiHBPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:07:03 -0400
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1A426AC9;
        Tue,  2 Aug 2022 08:06:59 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id q14so10857024iod.3;
        Tue, 02 Aug 2022 08:06:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=x3XCynuR0M/TShCzZqty0IPaAPxLKscWE0q3SESViQY=;
        b=sZ2/KGY4P5ArWjEmWyxYN+gLytq0vpghkwgxQ78Gju8M9hRoHVIBr1BGWh5nRdhB/c
         sJjdfCwP6Zl9tVyNkMN6rxXVivhgiYKdVuvQNUOLR6mAhgVuL9AW4lsRHvKD/QintXQZ
         oUHSS5vypdxvdndsmmxEYBcAcjhz1J5pUMiDf+cP9q4SWBmQdB0ikjw5ux0FoJdYnGiY
         U+Z3CboyoW4srCHwc0tioFOhaP9K3x8PwZ7EGKGzX8ws0gSEclgaalsD6PaALsQI1qzd
         buSlkwWFeUDCZGD3J6hGN6K09KknjNdloDDvjXgArj5tx7EqrqksfxvoobN+u2eLTcnj
         eEYw==
X-Gm-Message-State: AJIora9BCqN5o3GAbZzMjQ2izScku/MeKFmyk0+QlbfrCVMeZMq0b7we
        KOmZ8N+YPNr3qH0j4IyuSg==
X-Google-Smtp-Source: AGRyM1sKUi6tiTehYE0cNjPculTasu4AM874RxolsEPrxNCFivhQUiMOpXnNKOlKQq9dYYA+GOxGFQ==
X-Received: by 2002:a05:6638:1305:b0:33f:7e59:4bc7 with SMTP id r5-20020a056638130500b0033f7e594bc7mr7940473jad.316.1659452818161;
        Tue, 02 Aug 2022 08:06:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q28-20020a02a99c000000b0033a29ec646dsm6568358jam.4.2022.08.02.08.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:06:57 -0700 (PDT)
Received: (nullmailer pid 112022 invoked by uid 1000);
        Tue, 02 Aug 2022 15:06:56 -0000
Date:   Tue, 2 Aug 2022 09:06:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/4] dt-bindings: sram: sunxi-sram: Add optional
 regulators child
Message-ID: <20220802150656.GB86158-robh@kernel.org>
References: <20220802053213.3645-1-samuel@sholland.org>
 <20220802053213.3645-2-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802053213.3645-2-samuel@sholland.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 12:32:10AM -0500, Samuel Holland wrote:
> Some sunxi SoCs have in-package regulators controlled by a register in
> the system control MMIO block. Allow a child node for these regulators
> in addition to SRAM child nodes.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
> Changes in v2:
>  - New patch for v2
> 
>  .../bindings/sram/allwinner,sun4i-a10-system-control.yaml      | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> index 1c426c211e36..cc57836b2906 100644
> --- a/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> +++ b/Documentation/devicetree/bindings/sram/allwinner,sun4i-a10-system-control.yaml
> @@ -56,6 +56,9 @@ properties:
>  
>    ranges: true
>  
> +  regulators:
> +    type: object

This should reference the regulator schema.

Also, it's preferred to have 1 complete example here rather than 
piecemeal examples in each child schema.

> +
>  patternProperties:
>    "^sram@[a-z0-9]+":
>      type: object
> -- 
> 2.35.1
> 
> 
