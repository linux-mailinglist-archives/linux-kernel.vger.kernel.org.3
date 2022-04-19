Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEBB507C05
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358058AbiDSVlk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357589AbiDSVli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:41:38 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA393879C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:38:55 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id i20so33450768ybj.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lpixaXj6qNPyfuQi+711f00czQF/Nnw+LVQXzBb+S8Q=;
        b=F9g5t4HgbUdVEO+7E0ZaRfMM+SEy8iU+ns1cW1A9oOsOFSSwkkuANuzTMzZmRjMKtx
         No4Q1IoHiqt9yd6rB84MXHA+yXX6YwSNUiO66pvOO5eMIFO7uEtJlyPpRqVKtDKZIUak
         iwWZN0L8aq9SVoLAoPswC9n7QVWCW+F+R3XIXHZ1ywr4IWivMjByCVzO7jtS1yMaQGh4
         ygPAIOfmqRqoziZ4QlKCxcWJ2C98HH0SprzpWLQ/FQ+Zu/eXifGBrPPlWgvct9cOBIfa
         0v4U0L9yQZi8bxosZ9TIsRr50S/J6T5vJXHVjubMKBqYfGQXVXVWz2/9pZFmP1t612dR
         B/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lpixaXj6qNPyfuQi+711f00czQF/Nnw+LVQXzBb+S8Q=;
        b=C1aBMBCIgQfjIXxIHzo3ZGo/eWyqcZrqaAGJsNLSnzaqeXE1BEjoVwLA808v79/mi+
         to0r+FJ3xw3ObuePHL8qiIK+KtjEBK1VF0riq5dxbAG1kaMtqMf2SvqZ/I0hAIEtFOxt
         d1zNbvRR5Gdtd4Ov1XkOumwAkueEWl3cz6+iaNrHBv9B1KchjP1hl5aWOtIkBiIv09SS
         xXebY/QCO+yyuoptIgKJZZSfv2O53liQTI9+Xu0E3evvZwfnTvKMLdm2hEmLiUdANYay
         JWn41FnOyjF5HnFkGHfsa78auh8xfDbtTToqHCTD4cYcD66RAZAIWrV3fEb1ywVm4qZV
         DIcA==
X-Gm-Message-State: AOAM531YAd7xLFOqEDE+ZqpUQbr346uMJMuMgOGXtPUYB7EPWOymEfAa
        eCVmCdpGQH0U0GxP/xZnQKTLYHkxcZQSf83z/vFL3g==
X-Google-Smtp-Source: ABdhPJxLVTTgwCGxy+lO7TQGdgaHtKXCvsmRfdXfncWdJZBji/2RvB6wApY4h1lwCArWlAwDJd3CkXS8AyglvAtlQEk=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr12447288ybh.492.1650404334359; Tue, 19
 Apr 2022 14:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbUWE8knM=9uUVLTX792Y8_J1aPj4KtFh=yJxaKi+ZqRw@mail.gmail.com> <Yk2PE7+oEEtGri95@smile.fi.intel.com>
In-Reply-To: <Yk2PE7+oEEtGri95@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:38:43 +0200
Message-ID: <CACRpkdbqfNiWQG6ayqMXACby4xkW0pY6JhdYE-x+pWkSxJU5TQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node assignment
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Scott Wood <oss@buserror.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Wed, Apr 6, 2022 at 3:02 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, Mar 28, 2022 at 03:16:08PM +0200, Linus Walleij wrote:
> > On Wed, Mar 23, 2022 at 6:43 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > Let GPIO library to assign of_node from the parent device.
> > > This allows to move GPIO library and drivers to use fwnode
> > > APIs instead of being stuck with OF-only interfaces.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > That's a nice patch.
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Thanks!
>
> Can we have this applied now?

I think Michael Ellerman could help with this?

Michael?

Yours,
Linus Walleij
