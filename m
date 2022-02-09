Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 746454AFF1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 22:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiBIVSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 16:18:44 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233188AbiBIVSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 16:18:42 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6CEC1DC05D;
        Wed,  9 Feb 2022 13:18:44 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id r27so3890491oiw.4;
        Wed, 09 Feb 2022 13:18:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ysi9tyGURK2QwhBWavXBNAH4KWOK+Ss1yM0yrY3G7jk=;
        b=LXvGnFqsrU4dYig/OsI1JmIRUWTxbu9MAJLcyzYlXQ54ODdfdfWAXWtad9r9UcrjiT
         BjZ0EGwrIib2DbUbG93lfg9PnEJ6L39DVYQJ0YlPzaFUnPtRiREOpZ5htV+c43d/SbQo
         sfjqB5bpBU4mOzGMrLHtaDhP6FaCi3QfIONVeoTlxOwG5N3Ak1Om47AMrLUG0J9RxhfZ
         dCu/E+xovKiJNbbnkHSM4m/AMl3YYdZ83cH75Riu9M3m3ki+NCjy2DIg0STVd/Ruggxc
         OfyeOA09cHicP1fEjIrh1XDHXeq+26LwtEWpqqDFVFn99+n3aZORMzA7ACio4tC30boH
         8XLA==
X-Gm-Message-State: AOAM530Aq1a2HW3EKaPzdIFh9p4gSJoSk3ifLv5s9TKZi0A5961hPADX
        Dj10wRU8chR3pa3c+JL6KQ==
X-Google-Smtp-Source: ABdhPJzaDtW2H4LesfcmHT/9rcXfGcMFnwfUDpZImmvW0LWJ0t2aBhAXoz0IFGO+1CSlXSzEgirmdQ==
X-Received: by 2002:a05:6808:208d:: with SMTP id s13mr2225459oiw.282.1644441523498;
        Wed, 09 Feb 2022 13:18:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 12sm3579222oam.5.2022.02.09.13.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:18:42 -0800 (PST)
Received: (nullmailer pid 932436 invoked by uid 1000);
        Wed, 09 Feb 2022 21:18:41 -0000
Date:   Wed, 9 Feb 2022 15:18:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linus.walleij@linaro.org, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: mtd: drop mtd/cortina,gemini-flash.txt
Message-ID: <YgQvsQbGEBgfAoVO@robh.at.kernel.org>
References: <20220131080858.1777518-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131080858.1777518-1-clabbe@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 08:08:58AM +0000, Corentin Labbe wrote:
> Drop mtd/cortina,gemini-flash.txt since it is nearly already handled by
> Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Change since v1:
> - fixed typo on syscon
> 
>  .../bindings/mtd/cortina,gemini-flash.txt     | 24 -------------------
>  .../devicetree/bindings/mtd/mtd-physmap.yaml  | 18 +++++++++++++-
>  2 files changed, 17 insertions(+), 25 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt b/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
> deleted file mode 100644
> index efa5b2aba829..000000000000
> --- a/Documentation/devicetree/bindings/mtd/cortina,gemini-flash.txt
> +++ /dev/null
> @@ -1,24 +0,0 @@
> -Flash device on Cortina Systems Gemini SoC
> -
> -This flash is regular CFI compatible (Intel or AMD extended) flash chips with
> -some special bits that can be controlled by the machine's system controller.
> -
> -Required properties:
> -- compatible : must be "cortina,gemini-flash", "cfi-flash";
> -- reg : memory address for the flash chip
> -- syscon : must be a phandle to the system controller
> -- bank-width : width in bytes of flash interface, should be <2>
> -
> -For the rest of the properties, see mtd-physmap.yaml.
> -
> -The device tree may optionally contain sub-nodes describing partitions of the
> -address space. See partition.txt for more detail.
> -
> -Example:
> -
> -flash@30000000 {
> -	compatible = "cortina,gemini-flash", "cfi-flash";
> -	reg = <0x30000000 0x01000000>;
> -	syscon = <&syscon>;
> -	bank-width = <2>;
> -};
> diff --git a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
> index f827984936f6..82eb4e0f453b 100644
> --- a/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
> +++ b/Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
> @@ -44,7 +44,9 @@ properties:
>                - numonyx,js28f128
>                - sst,sst39vf320
>                - xlnx,xps-mch-emc-2.00.a
> -          - const: cfi-flash
> +          - enum:
> +              - cfi-flash
> +              - jedec-flash

Why is jedec-flash being added? The old doc made no mention of it.

>        - items:
>            - enum:
>                - cypress,cy7c1019dv33-10zsxi
> @@ -127,6 +129,20 @@ required:
>    - compatible
>    - reg
>  
> +if:
> +  properties:
> +    compatible:
> +      contains:
> +        const: cortina,gemini-flash
> +then:
> +  properties:
> +    syscon:
> +      $ref: /schemas/types.yaml#/definitions/phandle
> +      description:
> +        Phandle to the syscon controller
> +  required:
> +    - syscon
> +
>  # FIXME: A parent bus may define timing properties
>  additionalProperties: true
>  
> -- 
> 2.34.1
> 
> 
