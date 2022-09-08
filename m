Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89095B1D5A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbiIHMlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiIHMlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:41:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786DBC6EAB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 05:41:03 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id z17so9643236eje.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=7Cc3JjRoygtSTXogpO0wdGB24mbzR+AXN+9ZoeSda84=;
        b=j8VC/Ra6EgN8dGVA8AGrHXrS2XVoT2RFYj7AiY9Kg1ZrZOYenCJQ9ZZs/P1OwLwVgE
         GYRrhQiMJVpqNMgAhWw1VEkgfMZ2XbKsAM6JyAwCDuwCGGyCdUB8UO3jI3V1j8qUJI3m
         GXxk1zOW1GrVfDFB0NIYfVSouOMvgM5GObi3+cytemoNKSwZzHgtdZ9mOztX59/725+m
         XKDckNZWnY2Zm7u59hgL4tcFpPWEnKVQ1mim/jbUPo1zgVaCVgEfcbyOhmfgOLx0OjTu
         57FHnlFYgrmQYGm+4ts84xs9kVOaO9z4+KedejqfIzApOVBGVSYyB07+74yYKDi6K0mL
         jLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=7Cc3JjRoygtSTXogpO0wdGB24mbzR+AXN+9ZoeSda84=;
        b=CsqZ23cVRdKpltuPaM6yFMrvfugpycbhF38K9cvPGjdcnCVWeHUlf0xZ1MJoFgVCCl
         g15ZRJS8fdGzdwkrHh44CzlMtcQhw2PHPA0dg3/dtAVGizXfnPY/JRXrLTeVTv7sBApT
         Q53A89XVhOYMxpHSdMA/wId0SLcOxVBnzY4Rv8sosOcmvz81l9Rx6dW0DaDev8aCvGel
         DJbCcNCKsGl/bQGPN91OAFTkEhVfMdFlxWtA07VtHr9oB2SyutrrTkTfyTKgw3M8jOp5
         u7bqijS5JVoICnGK1xG3HY508QpDWidVda1wOkfoqwCNs1cmhfKNg/8DrakGPyrRG7G3
         fEGQ==
X-Gm-Message-State: ACgBeo03T05jIjjkJyJISKQAWNX+B3imnviCBVbDwX2BZJH6Wm4BdZgu
        3qBWi8BdkOCG6MDNE9pREb9Af99IARv5xc7JH07sfq/ONXWuVwLe
X-Google-Smtp-Source: AA6agR4ePYuOmtxrt0CjkIai+xgdE7eucVDz1eLZcaM3bclYP+MlyvscuYoZ4xtEj0w8eM8TXWU86P2R5T/DfYJ4pZ4=
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id
 nb9-20020a1709071c8900b00741445375bemr6018030ejc.208.1662640862005; Thu, 08
 Sep 2022 05:41:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220715044948.434149-1-cosmin.tanislav@analog.com>
 <20220715044948.434149-2-cosmin.tanislav@analog.com> <CACRpkdZVkXM-8DZjTaOxnS05Wz5GHon0sK1g7hDbz5SDJf9A=A@mail.gmail.com>
 <06476041-e8d6-7030-2f46-ace964c42513@gmail.com>
In-Reply-To: <06476041-e8d6-7030-2f46-ace964c42513@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 8 Sep 2022 14:40:50 +0200
Message-ID: <CACRpkda=JdgBqFvY_7q_Zv0HJx1wmtMEfB9heycy5PuEE4mrSA@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 9:03 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:

> >> +  adi,ext-clk-freq-hz:
> >> +    description: Specify the frequency of the external clock.
> >> +    enum: [76800, 153600]
> >> +    default: 76800
> >
> > This looks like cheating, i.e just outputting a clock on that pin
> > and ignoring to model the consumer.
>
> You got this wrong.
>
> The chip has 4 operating modes regarding clocking.
>
> Internal 76.8kHz clock (clkout can be used as an interrupt pin).
> Internal 76.8kHz clock, available externally on the clkout pin (clkout
> becomes an output).
> External 76.8kHz clock (clkout is an input).
> External 153.6kHz clock, internally divided by two (clkout is an input).
>
> This property is used to choose between what frequency to set the
> external clock up with. Indeed, if the external clock is not present,
> then exposing the 76.8kHz clock using the clock framework would be fine.
>
> Maybe you have a better suggestion about what to do with this?
> How do I tell the chip what frequency the external clock is, but also
> tell the clock what frequency to use? It's a bit of a conundrum for me.

I would imagine not specify in the device tree what frequency to use
at all.

Instead use software for that.

The clock provide for the clkout should provide

static const struct clk_ops extclk_ops = {
        .recalc_rate = extclk_recalc_rate,
        .round_rate = extclk_round_rate,
        .set_rate = extclk_set_rate,
};

This way the consumer driver can issue clk_round_rate(),
clk_set_rate() etc to make the clk driver determine which parent
to use for the consumer. Likewise .enable or .prepare should
then mux out the desired clock.

> >> +  adi,bipolar:
> >> +    description: Specify if the device should be used in bipolar mode.
> >> +    type: boolean
> >
> > Can you explain what this means? I don't understand what it would
> > mean for an analog device / AFE to be in bipolar mode.
> >
>
> Range becomes [-VRef, VRef], as opposed to [0, VRef], resolution is
> halved.

OK that makes sense, put that in the binding description.

Yours,
Linus Walleij
