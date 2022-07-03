Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 180E1564A95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiGCXam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiGCXak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:30:40 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 579B760CD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:30:38 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so6962837wmp.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 16:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i7LHTpr0Qs02RYvQ9FK25ZUcGAVk+CMPhPkGyyYYc0=;
        b=j7Cmflw53KduiV35so5cn/H+v2MNimUPIwYB6wsv6zgwd4ruUhjsO+mAWd0WB0VGCk
         D/ZcVy0CFw1UWNHXkVmrY3i75IPJ2JS/afY52cOU8XgDjhgg/e4VPRDnUbvry2ZndDC7
         qGr9vjL5SzwPqHjNiYJl5YH2UeldkdAAOdhGOViAohPa8Piwod3U5LiVIIJVYbEXgq0R
         e1TdFaJuQkb1hZDm/zHqB1ytmIouhMBMNHXYK8TXFbUMHJRj5B3xC5Z3i7XbqjExJefX
         VV8UoPqfQyt1sAd0hoo+GHqqhRPSaBYZ/tCNG/MSWq0zNjyUvfHezwTftBhRmEl32gg0
         E2rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i7LHTpr0Qs02RYvQ9FK25ZUcGAVk+CMPhPkGyyYYc0=;
        b=rvpkEQzreHAF4kCSB12yz2M8KIaMccerreTYxT2wEEpPHiXYUIAqMPJiUv1J6TQqmX
         WyJkhNTayIthnngJCNz1wZqJUOpAQrCNU7ehEQCGdeASctLUj/5eiGSdbzYlSyNyShRG
         TvIQE5BgHVLWjL+IFl23uyMFRVtIQ1F4nwxfTrEQjDAyVymN/fTNQVv/3esDeCv/NYG3
         Qz5swKGcTJjQttUEXj6YSuub3H538Jr1ZlXfO3DiFy5EpjsV8ys3dgokUTOuR7nn1JOf
         RiG2gzkwq3ujKwyL3CsGBJZh4xsQko9eqvUnYYNwIpDib2l0/4Wj6etrqMImsUYlDkPO
         u2ew==
X-Gm-Message-State: AJIora+8Z4bYXdWBO928/qDKxfmqEfI1Zu5s+0FgyDL2BKvX7ud8cLQ4
        T/jh0SWp8j7tvQDlecvfos0FP5x9ZGCmfSkfJSUHhQ==
X-Google-Smtp-Source: AGRyM1tMZmiXO90YVYtu4pSInZXF086cJpn/vm6bxdUWdK+8vIdFOCPpmeeMu9PaNCmghLGklEhRSKTstzUf942tBDg=
X-Received: by 2002:a05:600c:3505:b0:3a1:9fbb:4d59 with SMTP id
 h5-20020a05600c350500b003a19fbb4d59mr4530172wmq.165.1656891036902; Sun, 03
 Jul 2022 16:30:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220613195658.5607-1-brad@pensando.io> <20220613195658.5607-7-brad@pensando.io>
 <20220614213036.GA2660642-robh@kernel.org>
In-Reply-To: <20220614213036.GA2660642-robh@kernel.org>
From:   Brad Larson <brad@pensando.io>
Date:   Sun, 3 Jul 2022 16:30:26 -0700
Message-ID: <CAK9rFnzyKz3BHfMp8ENu+BxY4xyp3iNvnMW_M2KTPyPrfL_RNg@mail.gmail.com>
Subject: Re: [PATCH v5 06/15] dt-bindings: mfd: amd,pensando-elbasr: Add AMD
 Pensando Elba System Resource chip
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Cooper <alcooperx@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, blarson@amd.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Gabriel Somlo <gsomlo@gmail.com>, gerg@linux-m68k.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Pratyush Yadav <p.yadav@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>, samuel@sholland.org,
        Serge Semin <fancer.lancer@gmail.com>,
        suravee.suthikulpanit@amd.com,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Will Deacon <will@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Tue, Jun 14, 2022 at 2:30 PM Rob Herring <robh@kernel.org> wrote:
>
> On Mon, Jun 13, 2022 at 12:56:49PM -0700, Brad Larson wrote:
> > From: Brad Larson <blarson@amd.com>
> >
> > Add support for the AMD Pensando Elba SoC System Resource chip
> > using the SPI interface.  The Elba SR is a Multi-function Device
> > supporting device register access using CS0, smbus interface for
> > FRU and board peripherals using CS1, dual Lattice I2C masters for
> > transceiver management using CS2, and CS3 for flash access.
> >
> > Signed-off-by: Brad Larson <blarson@amd.com>
> > ---
> >  .../bindings/mfd/amd,pensando-elbasr.yaml     | 93 +++++++++++++++++++
> >  1 file changed, 93 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> > new file mode 100644
> > index 000000000000..13356800b1cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/amd,pensando-elbasr.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/mfd/amd,pensando-elbasr.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: AMD Pensando Elba SoC Resource Controller bindings
> ...
> > +patternProperties:
> > +  '^reset-controller@[a-f0-9]+$':
> > +    $ref: ../reset/amd,pensando-elbasr-reset.yaml
>
> /schemas/reset/...

Changed it to
       $ref: /schemas/reset/amd,pensando-elbasr-reset.yaml

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/reset/amd,pensando-elba-reset.h>
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    spi0 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        num-cs = <4>;
> > +
> > +        spi@0 {
> > +          compatible = "amd,pensando-elbasr", "simple-mfd";
> > +          reg = <0>;
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +          spi-max-frequency = <12000000>;
> > +
> > +          rstc: reset-controller@0 {
>
> Only one child does not make a MFD...

Looking over the approaches for other SoCs with an external
required controller (cpld, fpga) this appeared to be an
acceptable choice.  This device is accessed by several
different utilities/programs via /dev/pensr0.x, CS0 registers
for a variety of control/status, CS1 designware i2c master/slave,
CS2 lattice dual i2c masters, and CS3 for flash.

> > +            compatible = "amd,pensando-elbasr-reset";
> > +            reg = <0>;
> > +            #reset-cells = <1>;
> > +          };
> > +        };
> > +
> > +        spi@1 {
> > +          compatible = "amd,pensando-elbasr", "simple-mfd";
> > +          reg = <1>;
> > +          spi-max-frequency = <12000000>;
>
> 'simple-mfd' implies there are child nodes, but you have none. Is this
> complete?

This function is a designware i2c master/slave for board peripheral
access.  Removed simple-mfd.

> > +        };
> > +
> > +        spi@2 {
> > +          compatible = "amd,pensando-elbasr", "simple-mfd";
> > +          reg = <2>;
> > +          spi-max-frequency = <12000000>;
> > +          interrupt-parent = <&porta>;
> > +          interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>
> This one has interrupt but the others don't?

Yes, this function is a Lattice dual I2C master for transceiver
management.  The spi to i2c driver is not included in this patch set for
essential Elba SoC support.  Removed simple-mfd.

Regards,
Brad
