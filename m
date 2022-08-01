Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3F55867D6
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbiHAKwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiHAKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:52:29 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 448EE29803;
        Mon,  1 Aug 2022 03:52:28 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s206so9356847pgs.3;
        Mon, 01 Aug 2022 03:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1+zvFjvjZf1WXQC9+iCFiiUb93JkcfGfa2IxHwe2fOA=;
        b=VNUjTKm13wfj24ap78DlMZVMElCnn7kIr+3VsTjeEfZzKaARcXJMo/pJmIZSYnlIE3
         tzUxEMhN/heggErO2Umsfls4cyDivjgNVLtqpubdYk0H2iSYMmZi1KIk+PpDrZh+iz0q
         RIxjS5hQXd1SjDBfycx1IPxFsK0rLKzlyH6ocdy9UqViFbeMMmi1690lgslaEj8w9Ouu
         /iiY1lYjEAG+8HREsunwtNmf+Jw36TBbWOzljWPNNh4aMCqmXMgifwpAuPdM31LL/oh8
         8f9qoFsrlAXrOEtcYJwr1wg6LtcV3YAI7ZItpVD4KWKW3TGLL1luHH/itr/PpKkcPwGS
         1P1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1+zvFjvjZf1WXQC9+iCFiiUb93JkcfGfa2IxHwe2fOA=;
        b=FDzfjhxFbLVx3cwxYJ1VCtEIZrypUyD6OHHOOBIrhUgfp1ANKs3b1D88bgFvHHUO7l
         IMKkZineyUllvt3WcCbAvhyfxdPBPdC73N1UHxU1xTxzqOBwCcgrALV0LaZgrtnbY5Za
         J7FAlWLip4LUol444y1KA+6er5OzUpUeftwdERB7CWX/fGsfELAF+VIYSo97W7HGXiSX
         Z8i0E+9XT0yZJUXVS4RuSTOOr83c1bmZ9bxlAEU3wioX0ilxgZ0DoZBU4azQxdTXZ0ka
         x9OdFFvhA2VRiigepOA5+3eBod3qJkdYoYB9QtuQPpxAx7rtMXfycO9ISabxtBEgSC6z
         EjJw==
X-Gm-Message-State: AJIora9kbNejQG8XIrmEJRd4e4gPbZ/NwBS2Xhn28RPmMeYCaZbAiT/D
        HF4bc+m5o08IxAgGrBN25ahm9TkB3pklYedhbVNrxd9Boxo7rQ==
X-Google-Smtp-Source: AGRyM1sv37v5Hk+L2tOCiqUuVEMnF8+2HFUZ7PSVXSmiljZ+YdGarEsBPJrVkpXcpZhE/DSkkZonOrm7zRnG6geK0vo=
X-Received: by 2002:a05:6a00:188e:b0:52a:af7f:e715 with SMTP id
 x14-20020a056a00188e00b0052aaf7fe715mr15495962pfh.2.1659351147607; Mon, 01
 Aug 2022 03:52:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-2-nagasuresh.relli@microchip.com> <a431ac00-ee65-df7a-674c-27f13fc7be82@microchip.com>
In-Reply-To: <a431ac00-ee65-df7a-674c-27f13fc7be82@microchip.com>
From:   naga sureshkumar <nagasuresh12@gmail.com>
Date:   Mon, 1 Aug 2022 16:22:16 +0530
Message-ID: <CAH_iE_03fHMbCwGPsE_CmbokRh5cW_bEaX8RodK1ovWeTSHuhQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] spi: dt-binding: add Microchip CoreQSPI compatible
To:     Conor.Dooley@microchip.com
Cc:     Nagasuresh.Relli@microchip.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Thanks for your review.

On Mon, Aug 1, 2022 at 3:54 PM <Conor.Dooley@microchip.com> wrote:
>
> Hey Suresh,
>
> On 01/08/2022 10:42, Naga Sureshkumar Relli wrote:
> > Add compatible string for Microchip CoreQSPI controller.
> >
> > Signed-off-by: Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>
> > ---
> >  .../devicetree/bindings/spi/microchip,mpfs-spi.yaml    | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> > index 7326c0a28d16..b65f4e070796 100644
> > --- a/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> > +++ b/Documentation/devicetree/bindings/spi/microchip,mpfs-spi.yaml
> > @@ -14,9 +14,13 @@ allOf:
> >
> >  properties:
> >    compatible:
> > -    enum:
> > -      - microchip,mpfs-spi
> > -      - microchip,mpfs-qspi
> > +    oneOf:
> > +      - description: Microchip's Polarfire SoC SPI controller.
>                                          ^
> (This is a capital F btw)
>
> > +        const: microchip,mpfs-spi
> > +      - description: Microchip's Polarfire SoC QSPI controller.
> > +        const: microchip,mpfs-qspi
> > +      - description: Microchip's FPGA QSPI controller.
> > +        const: microchip,coreqspi-rtl-v2
>
> I am not sure that this is the correct "hierarchy". coreQSPI has a
> subset of the registers of the "hard" QSPI & the same driver works
> for both at the moment. The "hard" QSPI is based on the FPGA core,
> so I think this should be changed to something like the following:
I have added each element for each controller separately.
but the below one hierarchy explains clearly about the cores.
I will update the bindings.
>
> properties:
>   compatible:
>     oneOf:
>       - description: Microchip's PolarFire SoC QSPI controller
>         items:
>           - const: microchip,mpfs-qspi
>           - const: microchip,coreqspi-rtl-v2
>       - description: Microchip's fabric based QSPI IP core
>         const: microchip,coreqspi-rtl-v2
>       - description: Microchip's PolarFire SoC SPI controller
>         const: microchip,mpfs-spi
>
> Unrelated to this patch, but a
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f4202a19faa1..887bfee5c7af 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17526,6 +17526,7 @@ F:      drivers/pci/controller/pcie-microchip-host.c
>  F:     drivers/rtc/rtc-mpfs.c
>  F:     drivers/soc/microchip/
>  F:     drivers/spi/spi-microchip-core.c
> +F:     drivers/spi/spi-microchip-core-qspi.c
>  F:     drivers/usb/musb/mpfs.c
>  F:     include/soc/microchip/mpfs.h
>
> Would be nice too.
Ok.

Thanks,
Naga Sureshkumar Relli.
>
> Thanks,
> Conor.
