Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA179578365
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbiGRNPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiGRNO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:14:59 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9B27B31
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:14:46 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-31d7db3e6e5so106251667b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTmwQhC3USDI8IN4iaZ/dk9RvPfB5wu0rM57dbrKez4=;
        b=wVNLjgWAhVdmBCdnlBVBQ/7c/Ch/F5E79wR9s7P3DE64D07BEPQNwtHL8rwC37szxl
         yX6SrZdQxe8sfnBn/YUuzxb0ofre9tJcGweEtYOOVqJ+VsJ3k2sO7h1IGj5JFnBVVKYF
         e8vjgqgA29moVWTeXxFwvJnpzf0I8lm6rtONmNss+VTlrCyeT5ZGMLVGz4p0WQqEcvxs
         4xzwZGhBt1KmU7Mx89K3feNwXHUZjTyFZoUsTlsxFUOrC38DEB+HJZdAY4SrRk6BuguX
         Kzr3KNOqGIVQ9Ix6HiRDN9yoA69dadR3ObcmMYMOi6yjWfBnSEfjPk5hWLRcLkcrumQ/
         XmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTmwQhC3USDI8IN4iaZ/dk9RvPfB5wu0rM57dbrKez4=;
        b=B5pNi9mUnzyFO/d+YKyKbYfnrbve5gZHBc5XYrfPlXZju8hac769hY8QYu58L5iiJE
         81kiM4BPtDFS6xONLlE8FOYmQ743rUEuJhE7N3oaLy7STrUjBbr1M5zMUQUTQYyLDcc5
         5p2fJCKelU+BF57MZPkkaQtIveMNVdUVqzAR89kQ1z440ETsaRw+NHheC0YBTAuc/HJB
         lOlLwoCAnIhp8nWSfUwbyW2FJm9sLkQKpFibfhRkYX1ayuyHOyMWf5E6IqdizrFhEf7H
         /ZgdHqgFORraZh2UIeLZhX6KSdHj9jnXRicKNmhiMFE4FOleQIxw6aVhK6Yay+SKz2gk
         wcsA==
X-Gm-Message-State: AJIora/ynIp29ih4xdWGNPzG6vGLDcyrUy1EY6XQJMwwD5OrG94zls+N
        qWw/UK6tLdslJeyQGKsP11cFPfTMvMQhAwiKqSF+fA==
X-Google-Smtp-Source: AGRyM1tIllmHvOjnAykb6ET0EILH+ku3SZfxQN9LD/0uQkJ9mwybQVzLcYeLzeZe7bTaJ8/0MUTJg5RbDbzq++pXhG0=
X-Received: by 2002:a0d:e885:0:b0:31c:e456:c054 with SMTP id
 r127-20020a0de885000000b0031ce456c054mr29955115ywe.299.1658150085862; Mon, 18
 Jul 2022 06:14:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220715044948.434149-1-cosmin.tanislav@analog.com> <20220715044948.434149-2-cosmin.tanislav@analog.com>
In-Reply-To: <20220715044948.434149-2-cosmin.tanislav@analog.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 15:14:33 +0200
Message-ID: <CACRpkdZVkXM-8DZjTaOxnS05Wz5GHon0sK1g7hDbz5SDJf9A=A@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] dt-bindings: iio: adc: add AD4130
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Rob Herring <robh@kernel.org>
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
> Reviewed-by: Rob Herring <robh@kernel.org>
(...)

This caught my eye:

> +  adi,int-clk-out:
> +    description: Specify if the internal clock should be exposed on the CLK pin.
> +    type: boolean

Okay, but would it not make more sense to just imply this if the clock
on the CLK
pin has any consumers? Like update this setting in hardware when the consumer
does clk_prepare() or so on that externally routed clock?

> +  adi,ext-clk-freq-hz:
> +    description: Specify the frequency of the external clock.
> +    enum: [76800, 153600]
> +    default: 76800

This looks like cheating, i.e just outputting a clock on that pin
and ignoring to model the consumer.

Shouldn't this rather be a clkout subnode with 2 #clock-cells
and the fequency set in a cell in a consumer phandle?
Like how I did in
commit 7335631fcd5eecfa84555bd57433e6446d06ad21
"dt-bindings: clock: u8500: Add clkout clock bindings"

Usually it is the consumer that requests a specific clock and then the
producer will respond.

Certainly whatever is consuming this clock needs to be in the device tree
as well, and then this is the right pattern.

(In Linux you will then use the clk framework to manage the clock and callbacks
but that is irrelevant for the DT bindings.)

> +  adi,bipolar:
> +    description: Specify if the device should be used in bipolar mode.
> +    type: boolean

Can you explain what this means? I don't understand what it would
mean for an analog device / AFE to be in bipolar mode.

Other than that it looks very nice!

Yours,
Linus Walleij
