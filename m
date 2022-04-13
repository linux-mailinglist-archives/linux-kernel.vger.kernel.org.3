Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 079C04FF986
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbiDMO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234367AbiDMO6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:58:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998CEE0DD;
        Wed, 13 Apr 2022 07:56:10 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc2so4454796ejb.12;
        Wed, 13 Apr 2022 07:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MXDRi2nnaXpmTvbxw2dgQTuBsMOOy1/I/di9bKsVPUE=;
        b=aNT4a0hgVXfh34wZO4AZcl1QySQWNDk20i5GSbAIzd2DwalGkhx9rNpgQcY2d5X/Es
         YH7KJkEKSwa8QSOIOJZ2KTBGsURATGKY+3c8Wlr4686FygRAdCrBO+/wtuUoAn6FLLzC
         bgpnPRHuWU9oRCSpR3JE9aIgeGO/2lFWdzaNQHwy+9oxHZ3QKCsRs+Qu+7d8STG+ForU
         VQi++3nMWQkfT4ldLBdkkWSohKGnj67yA2y1MJ5TlpY4Tk2LmuS3KVPSwCHtxcn/Moth
         dY+FTaeqQxIGkOoJLGchWgxgjMGRT4eUN0MNF2a00uL5nMLLUrZoy7Fx7JABHMlxyJ1v
         JWzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MXDRi2nnaXpmTvbxw2dgQTuBsMOOy1/I/di9bKsVPUE=;
        b=JMWgBjXu51DlrRJ5s7NnjAQWPhH6f1Bz+w3mN9IAahfJ+/iaqkaj5jte0554wM3Nd2
         FQSQVYAK3+L6RnS/G3AZHpRJG7lZdPbc7rKt9SJhDq6r23NqkiqfaaLlbdtt7fR1K0R4
         GdT5IUF01PYFRk083nJhY0pON9VW8Xgojm7WLvTCimDdhDFTeIaizHhqy06aY481jn+j
         dhQPmHm8yFm+65dO9kK5rtLzob0WplICXjeN7FG9xEjdG2A5qt+ej9kILEJ3vVb1Ok2a
         sYWhsjgCLyWdVsXlM9Ca30Cb3eJGt5K7GqctaHq8HlEjlkxRwnqy+dxqrEckNeZZYfMB
         /1tw==
X-Gm-Message-State: AOAM533PN0en3Ju+C8JMbDA+WwquoF2SjYBDQjM4sqkRtuPBqnu4ah8W
        Zlw7L7oyLEqq4daH9uOZtxVfkNlnPYXuXa2cgf0=
X-Google-Smtp-Source: ABdhPJw/adFhHAFsrTBlvFb8K2Wp4aBtafuEsINtvoCqxDo4Bqx/NK9WXjmFzlIXM+HAr6LfzmtFTxoLfgW1ulNTuj8=
X-Received: by 2002:a17:907:e8d:b0:6e0:19e7:9549 with SMTP id
 ho13-20020a1709070e8d00b006e019e79549mr39432086ejc.44.1649861769049; Wed, 13
 Apr 2022 07:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220413094011.185269-1-cosmin.tanislav@analog.com> <20220413094011.185269-2-cosmin.tanislav@analog.com>
In-Reply-To: <20220413094011.185269-2-cosmin.tanislav@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 Apr 2022 17:51:57 +0300
Message-ID: <CAHp75VexJBnAqoQ53=_nif=bso0-cNj4EsTbUwKGKxfNq_Fvyw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] iio: ABI: adc: ad4130: document filter_mode{,_available}
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 4:17 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:

It's good you provided documentation, but I think the part "ABI:" is
not needed in the Subject.

> AD4130-8 is an ultra-low power, high precision,
> measurement solution for low bandwidth battery
> operated applications.
>
> The fully integrated AFE (Analog Front-End)
> includes a multiplexer for up to 16 single-ended
> or 8 differential inputs, PGA (Programmable Gain
> Amplifier), 24-bit Sigma-Delta ADC, on-chip
> reference and oscillator, selectable filter
> options, smart sequencer, sensor biasing and
> excitation options, diagnostics, and a FIFO
> buffer.

Indentation issue as per patch 1.

...

> +               Set the filter mode of the differential channel. When the filter
> +               mode changes, the in_voltageY-voltageZ_sampling_frequency and
> +               in_voltageY-voltageZ_sampling_frequency_available attributes
> +               might also change to accomodate the new filter mode.

accommodate

> +               If the current sampling frequency is out of range for the new
> +               filter mode, the sampling frequency will be changed to the
> +               closest valid one.


-- 
With Best Regards,
Andy Shevchenko
