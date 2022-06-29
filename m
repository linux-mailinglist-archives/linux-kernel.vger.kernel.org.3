Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C862655FC51
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbiF2JmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232626AbiF2JmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:42:15 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7AA3BBF1;
        Wed, 29 Jun 2022 02:42:12 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-31772f8495fso142491457b3.4;
        Wed, 29 Jun 2022 02:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dphcQupyROJ0Vn2I9eMkRI2C8/cYPFXlsrEJa1A+m0I=;
        b=a1XiGPRO6e6y+8vP5WdeYTRMcJgI+OmZ++oaD8yEl5YH8A2xu7z0J1zk8XS0wQ6Jd+
         +OEaJH6R0USSh5v9xfu+Qy8GVhWbNSdYui7NILY24UiyI8qNVPJyKPRHlpptugXH80pI
         Ktrhpt8N846eFVA+pQYvWIbGEHdHfJbcMQs3V8ne7pf7blupiDhIupcC3MHpG6H0hc6/
         3icptYNu1nHCt3flqp8Xlr+6KNN1ETxPbSFV2xnCIdsk1QNChgIIDhUwpX+8cAiuk881
         a74QGO4d2sBMKWE1oP8i1qGvbwY9Ag69Nqa7oty3h4DzSNMJmX3oJHneTidSxC5/VXd0
         bqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dphcQupyROJ0Vn2I9eMkRI2C8/cYPFXlsrEJa1A+m0I=;
        b=XghSYN88X0OYm+O/W1sOlIWmGF5+ibGJR18BKBK+cSKAVcH4edurOB/Pe/c8Sp1Per
         bWRZffGQUZ3iO+D8UROKMZ+v2nFJ6FCQ3f0jZi8fz6Bh/uAxwcXhacK43BgHiFkKYONV
         FnxVc+OXq0IBihOr7XXYn7vEAeeUJXVlQrIQDYor/llFWMAwFLp8PojYknQ8zmGhznnr
         j9zO/Xyw7Y0Bof0ZWeJDhZ1wcMKl3fnZqHnBWXzSwo1f/uikCV+aj1E64Rghir3iuxaM
         d+gGvJnEjiB+kaOnjw07NR6kDX/pH4rUE09WI14bb20GA3vOhzGrnQPAvYsseirGwjg4
         mHuA==
X-Gm-Message-State: AJIora9jDnjzYKzZZQnoD07nv7Eq7tMOrgszo7bCSLgPeh/knJyUB6vi
        tO5G0lAUGdTDPrJsbNQAq1mfMrcE4nCSqM9b3YonFrKFU/G4LA==
X-Google-Smtp-Source: AGRyM1sEWvOA8TWINKJbJeT2jByQgHuAnrXH2xN0IXetoXTufJfBjPcAm9m4hgZMsNOQvfMKZX/jCEL4z+4DkyI5KKg=
X-Received: by 2002:a81:6fd7:0:b0:317:964a:c7a4 with SMTP id
 k206-20020a816fd7000000b00317964ac7a4mr2875304ywc.131.1656495731432; Wed, 29
 Jun 2022 02:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220628144649.3957286-1-cosmin.tanislav@analog.com>
 <20220628144649.3957286-3-cosmin.tanislav@analog.com> <CAHp75Ve6f0dfMmctAwZ3UTA98MDs_injKik2C=wXpJ1zJyiPxA@mail.gmail.com>
 <7fc0292d-1d93-4ae8-2947-9444ef48a19e@gmail.com>
In-Reply-To: <7fc0292d-1d93-4ae8-2947-9444ef48a19e@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Jun 2022 11:41:30 +0200
Message-ID: <CAHp75VeedgEymKY9UwMjnS7XL8rdj2TNhLA38JjY=f1_4np6fg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] iio: adc: ad4130: add AD4130 driver
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

On Wed, Jun 29, 2022 at 11:28 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> On 6/28/22 22:17, Andy Shevchenko wrote:
> > On Tue, Jun 28, 2022 at 4:49 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> >>
> >> AD4130-8 is an ultra-low power, high precision, measurement solution for
> >> low bandwidth battery operated applications.
> >>
> >> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
> >> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
> >> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
> >> selectable filter options, smart sequencer, sensor biasing and excitation
> >> options, diagnostics, and a FIFO buffer.
> >
> > It would be respectful, if you include given tags. Why didn't you do
> > that? Any significant change that has to be re-reviewed?
>
> Sorry, I sometimes forget about picking up tags. Maybe Jonathan will do
> it if everything else is good.

I see, you may take them automatically by using the b4 tool.
 1. Take the Message-Id of your initial submission (v7).
 2. Run `b4 am $message-id`.
 3. Drop the previous patch from your tree either by reverting or rebasing.
 4. Apply the new one by `git am $message-id:ish` (see the output of
`b4 am ...`).

In that case all tags will be picked up automatically.


-- 
With Best Regards,
Andy Shevchenko
