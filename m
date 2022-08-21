Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAF159B5B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 19:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiHURuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 13:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHURt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 13:49:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B4E17E12;
        Sun, 21 Aug 2022 10:49:57 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id by6so8736137ljb.11;
        Sun, 21 Aug 2022 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tLYVuxhekI0KOsYotvxE+Kgdxmejr6Xy78RrCK136Ao=;
        b=oFF8NIShAZGvRV2blwmNfW/ZfonWvnbfYd5ttHgVfxlJH6iDdup4z8m9/npa/6vSmu
         PkF0Sf29ni0+dDIljlFW65naz2m1EWvXC6LEbXRtJkv7szHQtGC4pz5JFESptki7pcXj
         zIUQZ5ch5KOhi8f0oNZacmI5cvEmF4UWAdfJ+7GUCfltwF9c4L9fSDROSRpl5rslrn+b
         m+jMA6b0v5xdEYzuumkSjone5KJ04xNuIFW79CgdKzQmtppD/nkWARhFKIDCKaCy5Ln6
         qMKCkjOlNDRFRXxJzLFanT6CdefFpPjxZgMGn2x/lyvU7ggMynruHMktDb/iQ6KlVVow
         83Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tLYVuxhekI0KOsYotvxE+Kgdxmejr6Xy78RrCK136Ao=;
        b=jnYYWLAGwj/+NfrFhJIUrEajy2tSC0r38oHdZBrNRSgZWvPe7gZHqTjVkuhwxKQ2xE
         6wIXbNBsDTleq0VL9Kul1TsRSMAFFkhRXjj10i/3g5ne2Yydrto58pin9zVCLy3x3231
         Dlv6+sauOJldBkYch/dEs1kb5ltcdvQzqaiFcMeZz7kJvbnaDV0os0L0kMQ1dNdOmjKh
         gtrrHA2Omxzo3cZIAGCwgcAU7niNHVd6RQdi1E/pcmEI9Tz67mnU+tHDS7p1rsicDyx/
         75SqnMgNQGmH3P43yojg4skF2PTKS/DdKeKFTo8BjGQVCLdkFrTxqnC2D85fSqiSrxIE
         Ts3Q==
X-Gm-Message-State: ACgBeo165gOGFvjXwGYYaLmRJHpBW6GFoXyosesAOwB4vhCs9Y+Fff4x
        CL7f/jeU6E4mOoJixFxuahI=
X-Google-Smtp-Source: AA6agR5nAeNcHicAEyCie+REXBxjdJ7/RIcmfUJ9DJKrrL6dDfIqKBDFw3Wt+K8jDdCjcY3ghVxC0w==
X-Received: by 2002:a05:651c:546:b0:25f:dd42:5d08 with SMTP id q6-20020a05651c054600b0025fdd425d08mr5051330ljp.239.1661104195766;
        Sun, 21 Aug 2022 10:49:55 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id c15-20020a19e34f000000b00490b5f09973sm1568893lfk.92.2022.08.21.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 10:49:55 -0700 (PDT)
Date:   Sun, 21 Aug 2022 20:49:52 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Brad Larson <brad@pensando.io>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        blarson@amd.com, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, gsomlo@gmail.com, gerg@linux-m68k.org,
        krzk@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org,
        suravee.suthikulpanit@amd.com, thomas.lendacky@amd.com,
        ulf.hansson@linaro.org, will@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 04/17] dt-bindings: spi: dw: Add AMD Pensando Elba SoC
 SPI Controller bindings
Message-ID: <20220821174952.5i5pfftxt53dmqv3@mobilestation>
References: <20220820195750.70861-1-brad@pensando.io>
 <20220820195750.70861-5-brad@pensando.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820195750.70861-5-brad@pensando.io>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 12:57:37PM -0700, Brad Larson wrote:
> From: Brad Larson <blarson@amd.com>
> 
> The AMD Pensando Elba SoC has integrated the DW APB SPI Controller
> 
> Signed-off-by: Brad Larson <blarson@amd.com>
> ---
>  .../devicetree/bindings/spi/snps,dw-apb-ssi.yaml      | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 37c3c272407d..403d6416f7ac 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -37,6 +37,15 @@ allOf:
>      else:
>        required:
>          - interrupts
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - amd,pensando-elba-spi
> +    then:
> +      required:
> +        - amd,pensando-elba-syscon

Please add the "amd,pensando-elba-syscon" property definition as I
asked here:
https://lore.kernel.org/lkml/20220704131810.kabkuy6e4qmhfm3n@mobilestation/

-Sergey

>  
>  properties:
>    compatible:
> @@ -75,6 +84,8 @@ properties:
>                - renesas,r9a06g032-spi # RZ/N1D
>                - renesas,r9a06g033-spi # RZ/N1S
>            - const: renesas,rzn1-spi   # RZ/N1
> +      - description: AMD Pensando Elba SoC SPI Controller
> +        const: amd,pensando-elba-spi
>  
>    reg:
>      minItems: 1
> -- 
> 2.17.1
> 
