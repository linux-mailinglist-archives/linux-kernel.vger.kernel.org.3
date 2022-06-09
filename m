Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D496B5447A5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 11:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242104AbiFIJec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 05:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234972AbiFIJea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 05:34:30 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1CB1D01C9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 02:34:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so35235108ejj.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 02:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V00S6RIlLw/XlryCtnGLUCT1UyFL8GwBHHHmfaLtRjQ=;
        b=H7a1XEerxRHzmv3lekwWcxkuFmyr2YEq0ctxzQdNl1BRtFRR0EpQIt0JUi8dR86l96
         ITowpVjKSgSdbHAoFsrY7fiRDpWKLXfdnjsylOTUdxZCvHNcGxzuq2rArpAI26cykLQI
         Qg5gG2rwgd6JKqraj8Rm405Ck3y0N3DNpQ1h1diMWdhNhPzhTBjrZ8EXy4a3vUnuUFwC
         jBA3Bo/ZAOiU8joRtjLQ+OsBcNWoOozt/m5KYIWBVTjBTMXVJeIuIdy2cUu4anMU4Ld2
         mLP3jOFHdCcYAcADb8jqBs4G21m5c3hAaHhtZ79qQVIshXhHiOa0lVTHrh1Y4pBNObw8
         TzEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V00S6RIlLw/XlryCtnGLUCT1UyFL8GwBHHHmfaLtRjQ=;
        b=rsSj5ld78fF6WxyYYD+uUMnzAmggq1LsuGcz3+/1vaOqP50pu1NUWe88MpEp9l/f5N
         hPXw9FLLWWtCmtc5ma2UXLjMd2vKXVh2VCXSQJkeXC38ts9jcOaBLM62l85Z37+9mwQG
         /CoWOpVDbTdsEdotFixFSuxDi3tTm9HhzQIBplxIzONzi6InE5ZWN1MKpSu+wtGE+NMp
         O8EyBx01nORjzyUCoRIWUaEUxMOBrPO7KCYid+m9IdLYp6og4WeHSzF/X9RrpnJ2MwAT
         gd2JvHzsJMH5nPzuhwLVyzGY2GLYRD/9IoBOmXVDB+wPk44vVGI6EQKhro+FEAk8Kimt
         WXfQ==
X-Gm-Message-State: AOAM53372QDsOEM9Y+JavylLZ7ihAsi73hWkOFMzVSjbj4WF7YamnxA9
        fbjHkxTK0LrAkIcc5xsff+gmGm2U76r7+vbzREiCI2Y6Luk=
X-Google-Smtp-Source: ABdhPJx9wh5mgQuA/plhLvGR9odnRMKNZuw+e7p5cqq6yzPGSyolfIGb13lWdprIfBt5HNxP+ZIRY9K+Qp1dNJ8VVX0=
X-Received: by 2002:a17:907:3e21:b0:711:ea36:914e with SMTP id
 hp33-20020a1709073e2100b00711ea36914emr9489374ejc.101.1654767267471; Thu, 09
 Jun 2022 02:34:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220520164726.60638-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 9 Jun 2022 11:34:16 +0200
Message-ID: <CAMRc=McdOQUwb7U_G_p57cFWiF5Pcmo9pM3QwnUr9a3O-X28kw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Fix kernel doc for struct line
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dipen Patel <dipenp@nvidia.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 6:47 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Kernel doc validator is not happy:
>   gpiolib-cdev.c:487: warning: Function parameter or member 'hdesc' not described in 'line'
>   gpiolib-cdev.c:487: warning: Function parameter or member 'raw_level' not described in 'line'
>   gpiolib-cdev.c:487: warning: Function parameter or member 'total_discard_seq' not described in 'line'
>   gpiolib-cdev.c:487: warning: Function parameter or member 'last_seqno' not described in 'line'
>
> Describe above mentioned parameters.
>
> Fixes: 2068339a6c35 ("gpiolib: cdev: Add hardware timestamp clock type")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpiolib-cdev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
> index f5aa5f93342a..d0dc68d04059 100644
> --- a/drivers/gpio/gpiolib-cdev.c
> +++ b/drivers/gpio/gpiolib-cdev.c
> @@ -421,6 +421,10 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
>   * @work: the worker that implements software debouncing
>   * @sw_debounced: flag indicating if the software debouncer is active
>   * @level: the current debounced physical level of the line
> + * @hdesc: the Hardware Timestamp Engine (HTE) descriptor
> + * @raw_level: the line level at the time of event
> + * @total_discard_seq: the running counter of the discarded events
> + * @last_seqno: the last sequence number before debounce period expires
>   */
>  struct line {
>         struct gpio_desc *desc;
> --
> 2.35.1
>

Acked-by: Bartosz Golaszewski <brgl@bgdev.pl>

Feel free to take it through whatever tree is appropriate.

Bart
