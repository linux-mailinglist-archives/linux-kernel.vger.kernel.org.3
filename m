Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 086A65124A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 23:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiD0VpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 17:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiD0Voz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 17:44:55 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B1890CF0;
        Wed, 27 Apr 2022 14:41:42 -0700 (PDT)
Received: by mail-ot1-f51.google.com with SMTP id c17-20020a056830349100b00605ca7d1deeso1964163otu.3;
        Wed, 27 Apr 2022 14:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8TsqhMlD8DfHQiAjIFiLwWUPyhOj7fzWY9COQimF+14=;
        b=6jZ6XbI+6nwmx6SspDdu/bYHCBWF1Wtb+s8+h7fCXFICSZVNdRqMKQ3RtD2Xxe0fVV
         iL6gxeZ+/bCJ2ZeMibxdxCcdiYgC7QasL9mLBEs/zVkbauzpikJ5wN5LKo+RrCQs5Ln9
         ld12BSgyk3n4ELdQAzKDJy1PgTZsxwdvwl7/30q3I6eg2iHZ3lKRDpEWcZLif92cmo5i
         i51LIRbK1iuPcp7fjtvG6F/RoMh7CLceE4bSAMF1SEVJtfTbHzTZfOkIu25r14u3WxlU
         QCRKOtC2oCbUI2b6+64S4uvS9efs9lkWn5mHnAG0hTPH6TR3OZkRJNe5BQ/HkLkKEENy
         m6dg==
X-Gm-Message-State: AOAM533Z5DnoxzCEc/A+2O6STBz6uXwQHfolhIqm6ykLvQU20WwA+6cv
        Mem8xy3OKPXJ9acEzFWa2A==
X-Google-Smtp-Source: ABdhPJyVaHjPlZa/IDYPuEiUrxwWWb/m5vuMEGbEknV79DmMykxEBvRbLgnIRLda89Vu+m0aXDUg7Q==
X-Received: by 2002:a9d:5f15:0:b0:5af:5928:d5a1 with SMTP id f21-20020a9d5f15000000b005af5928d5a1mr10750692oti.343.1651095701638;
        Wed, 27 Apr 2022 14:41:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c9-20020a4a8ec9000000b0032438ba79b0sm7137555ool.0.2022.04.27.14.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:41:41 -0700 (PDT)
Received: (nullmailer pid 712339 invoked by uid 1000);
        Wed, 27 Apr 2022 21:41:40 -0000
Date:   Wed, 27 Apr 2022 16:41:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add AD4130
Message-ID: <Ymm4lJxumCPQKIhB@robh.at.kernel.org>
References: <20220419150828.191933-1-cosmin.tanislav@analog.com>
 <20220419150828.191933-2-cosmin.tanislav@analog.com>
 <Ymc+urR3N8eLLKxl@robh.at.kernel.org>
 <a4ba3f7e-6d03-36c7-e98a-3bed7db69fc6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4ba3f7e-6d03-36c7-e98a-3bed7db69fc6@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 03:47:13PM +0300, Cosmin Tanislav wrote:
> 
> 
> On 4/26/22 03:37, Rob Herring wrote:
> > On Tue, Apr 19, 2022 at 06:08:27PM +0300, Cosmin Tanislav wrote:
> > > AD4130-8 is an ultra-low power, high precision, measurement solution for
> > > low bandwidth battery operated applications.
> > > 
> > > The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> > > to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> > > Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> > > selectable filter options, smart sequencer, sensor biasing and excitation
> > > options, diagnostics, and a FIFO buffer.
> > > 
> > > Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> > > ---
> > >   .../bindings/iio/adc/adi,ad4130.yaml          | 264 ++++++++++++++++++
> > >   1 file changed, 264 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> > > new file mode 100644
> > > index 000000000000..32996b62cd20
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> > > @@ -0,0 +1,264 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright 2022 Analog Devices Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad4130.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Analog Devices AD4130 ADC device driver
> > > +
> > > +maintainers:
> > > +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> > > +
> > > +description: |
> > > +  Bindings for the Analog Devices AD4130 ADC. Datasheet can be found here:
> > > +    https://www.analog.com/media/en/technical-documentation/data-sheets/AD4130-8.pdf
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - adi,ad4130-8-16-lfcsp
> > > +      - adi,ad4130-8-16-wlcsp
> > > +      - adi,ad4130-8-24-lfcsp
> > > +      - adi,ad4130-8-24-wlcsp
> > 
> > What is lfcsp? wlcsp seems to be the package type which generally
> > shouldn't be part of the compatible.
> 
> lfcsp is a different package type. Sadly, lfcsp provides less interrupt
> options. On lfcsp, dout-int inside interrupt-names actually only means
> DOUT, while on wlcsp, it means INT. This is why we need to distinguish
> between the different package types. I can't think of any way around it,
> see my reply to Nathan for V1.
> 
> dout support is not implemented in the driver right now because when the
> interrupt pin is configured as dout, FIFO interrupts are unsupported, so
> the entire buffered part of the driver is useless, and extra logic is
> needed for IRQ detection then.

Please capture all this in the binding. At least enough I don't ask the 
same question again when I've forgotten about this.

Rob
