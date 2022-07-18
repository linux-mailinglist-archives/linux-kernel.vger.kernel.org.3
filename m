Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB095783AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiGRN0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235123AbiGRN0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:26:37 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A697A12A9E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:26:35 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31c86fe1dddso107032577b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vq1nfsdA5coq6n5SWADtW9niUwKkaHcu8n81CtS/PhQ=;
        b=dTUf55RM5WdP0LTR2NDp2XkkNrsELz1sG8vCGKO87mJJQ9FFaySJP6oqtMelslTt5Q
         zPFPI6yFZ49+BtPSbdN1wiergAigi+MOud/TEM4wbeTMyEV87ZLSKgaT5iLuXYWL8wTL
         yYLGmjGXWUEHeow734wqjY86NeBlviK8c0m/yOEq0XZsZyiSvYjheiSXyvhWYGTR2Pb3
         JawabQL3CJ1gREnbrlXqZQqz99eYZ9qaUzSqDwcBIrGXyycOK0WMN28u7DLycUho1SqH
         d1ywL1Fp/5wrj8bT12OjUAS29wCC+jLL5YND+XCG22JBqRUefkvUka2WfbfXxwVWyOwY
         JeoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vq1nfsdA5coq6n5SWADtW9niUwKkaHcu8n81CtS/PhQ=;
        b=bfHRr1Bw0DmuWSVLpVcEZVAOIid1YYRRZelDDDtHq0881ETTAgSktQdU493xAB7b0U
         f+CK7KOakvSp3/S0shNWUek04wuXPZ5oP7ssizTOX9k/BKmsVhN0Pm05nOUy8a1C8Mmw
         Y6uL82T9J3LcpDYYu0Ab/DJ4SZD6CUWBXl7kZTytO8WnOCCzteC1TG2ytlUBtmQYQTHM
         93bEdhggVg1c0jV32rRBc+2BjmqiKuzPDM6fxKitG7GT+QaZmX2wWHcOwgaezHSKlP+v
         IoR2jPks6SL42yT0do0aOV9BQNF8omoo8yB2nPTEsvw0wuBE/cqX/Or5raYLCbUM0ADL
         MJNg==
X-Gm-Message-State: AJIora9oPD4KLQMwOIFlPyDLPHmVAikGutYjnwMy9dpTvnjWsP3pqdKE
        vaefTkl8SK+TBTxmjMoSJ7AHO93LFKJAIK4XBwHpZA==
X-Google-Smtp-Source: AGRyM1vNXtk6hbtKSVS4tozHK4fF3mWDNBu6r9gapXG+u0NKNyochywe+71HfJC7PRKWGUqwSTcw6FD+Abyo42NezGA=
X-Received: by 2002:a81:5b43:0:b0:31b:aed2:f563 with SMTP id
 p64-20020a815b43000000b0031baed2f563mr30038159ywb.115.1658150794803; Mon, 18
 Jul 2022 06:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220715044948.434149-1-cosmin.tanislav@analog.com> <20220715044948.434149-3-cosmin.tanislav@analog.com>
In-Reply-To: <20220715044948.434149-3-cosmin.tanislav@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 15:26:22 +0200
Message-ID: <CACRpkdZ+KQqUKeevuXgcKLiK85STDeZFh=D47LMvyZb-o-Wbcw@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] iio: adc: ad4130: add AD4130 driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cosmin,

thanks for your patch!

On Fri, Jul 15, 2022 at 6:50 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:

> AD4130-8 is an ultra-low power, high precision, measurement solution for
> low bandwidth battery operated applications.
>
> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> selectable filter options, smart sequencer, sensor biasing and excitation
> options, diagnostics, and a FIFO buffer.
>
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
(...)
> +static int ad4310_parse_fw(struct iio_dev *indio_dev)
> +{
(...)
> +       int_clk_out = device_property_read_bool(dev, "adi,int-clk-out");
> +       if (st->mclk && int_clk_out)
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Cannot expose internal clock\n");
> +
> +       device_property_read_u32(dev, "adi,ext-clk-freq-hz", &ext_clk_freq);
> +       if (ext_clk_freq != AD4130_MCLK_FREQ_153_6KHZ &&
> +           ext_clk_freq != AD4130_MCLK_FREQ_76_8KHZ)
> +               return dev_err_probe(dev, -EINVAL,
> +                                    "Invalid external clock frequency %u\n",
> +                                    ext_clk_freq);

As mentioned in the bindings I think this is cheating. Just implement a real
clock abstraction and take the desired clock divider (1 or 2?) from the phandle.

See e.g.
commit 639d5661cc808057854681685ecb596406dbacce
"clk: ux500: Implement the missing CLKOUT clocks"
for an example, it is more complex so it should be a copy/paste/strip
exercise mostly.

Yours,
Linus Walleij
