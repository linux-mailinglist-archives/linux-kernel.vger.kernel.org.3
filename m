Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354084D8F77
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243061AbiCNWYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbiCNWYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:24:09 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CDCB65
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:22:58 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d07ae0b1c4so181311947b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rhuYdbrWYoIGnfqjj6FN2yUEIp0vHYyHRziBaZQGHB4=;
        b=VGtO2G0tbYp4Ucz5jWwhr2ObSsOeNj/ZeDhLsin+0yblMRQ3HaoO29UkTGW05xonoJ
         nkNYV/TywzTeImI3EYau8hPjVuAJAkUIBxrxUGkFyC0nf41ASzcFp4zBuLrQ6Ib5cXMB
         0WZ0YxeuKex6EjfJhV6+oYTGBoklL1RwfOBYvtQO68EvgMgs7yMchlfmzeJlXCWiQf6H
         L4JA9JbDj/kIQgyIFAZEp9SvdzdxztmpV52lCrNhx4vws0EVajDQt2/mwxOwKpFmEV1h
         PDd0KZ1I13LM1//omsCY3TMpP/rqxzprDRYPZyUnPU0K/K6proJeUWTWIhVhi1BS01KE
         YdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rhuYdbrWYoIGnfqjj6FN2yUEIp0vHYyHRziBaZQGHB4=;
        b=uXZGXzJ7PrM/6e+WNib8ekUqjuKjYmXOX/OGXgTNUrX1C750vu+AvfeV/BroSbZ3NC
         Wxh6NkZHxZkc4EZMCyFT6yhdAl+pqeFes/pmlufije8PxAgdE4bRMWG45Z5B6logE85g
         0U7tBB8RW59+aAXEwTNX+QrI7ZJGIquMjmwraFVZY7rxA01NhGd/jwHecbUDeKWxsm13
         nWha45jWRewePaKwvociokIlxSJhbkzYDv2QkxSWKVXGt3yPD1rCbuz8S/ZjC09zbRlz
         rq30W9JyxNPzrQRBM2dLiNsZ/zp3HpGYXIFXonJ39vEjdnuExfqHHevsZc7K7uuqJvE2
         hT3g==
X-Gm-Message-State: AOAM532PR/yP0gwsWQgl8nclNblKQaCWfVLXBaEL3sQR14vP5xYfGKLE
        mnN8Dlhz/3u6ajuOrkuLjK7m256CY9FiOoTd794Y/w==
X-Google-Smtp-Source: ABdhPJwyUqVchcQ1smDM/cvxYJGMLszguMDdoBtvSm3aWEFbsaTbsYySVmXsdnUj9aP80tBauyQQ+4fFm58wxT/NjG4=
X-Received: by 2002:a81:9c47:0:b0:2db:9e18:6e75 with SMTP id
 n7-20020a819c47000000b002db9e186e75mr21192173ywa.437.1647296577566; Mon, 14
 Mar 2022 15:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220310150905.1.Ie0a005d7a763d501e03b7abe8ee968ca99d23282@changeid>
 <CAMRc=McbY6vK_M9fP7Hzg8LE9ANOZKN49hmBFn92YFH+2ToM8w@mail.gmail.com>
In-Reply-To: <CAMRc=McbY6vK_M9fP7Hzg8LE9ANOZKN49hmBFn92YFH+2ToM8w@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 14 Mar 2022 23:22:46 +0100
Message-ID: <CACRpkdb-W10YAQff_dTUL7B-DH01Z9nn7cE71Zv5xjALtDGQ1g@mail.gmail.com>
Subject: Re: [PATCH] gpio: Drop CONFIG_DEBUG_GPIO
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Brian Norris <briannorris@chromium.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Mon, Mar 14, 2022 at 4:00 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> On Fri, Mar 11, 2022 at 12:09 AM Brian Norris <briannorris@chromium.org> wrote:
> >
> > CONFIG_DEBUG_GPIO has existed since the introduction of gpiolib, but its
> > Kconfig description and motivation seem to have been off-base for quite
> > some time.
> >
> > Description: it says nothing about enabling extra printk()s. But -DDEBUG
> > does just that; it turns on every dev_dbg()/pr_debug() that would
> > otherwise be silent.
> >
> > Purpose: might_sleep() and WARN_ON() should have very low overhead, and
> > anyway, there's a separate CONFIG_DEBUG_ATOMIC_SLEEP for the
> > might_sleep() overhead.
> >
> > Additionally, the conflated purpose (extra debug checks, and extra
> > printing) makes for a mixed bag for users. In particular, some drivers
> > can be extra-spammy with -DDEBUG -- e.g., with the Rockchip GPIO driver
> > getting moved out of drivers/pinctrl/ in commit 936ee2675eee
> > ("gpio/rockchip: add driver for rockchip gpio"), now some dev_dbg()
> > calls are enabled in its IRQ handler.
> >
> > Altogether, it seems like CONFIG_DEBUG_GPIO isn't serving any good
> > purpose and should just be removed. It can be supplanted by dynamic
> > debug (which post-dates gpiolib) and atomic-debug facilities.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> >
>
> I like it. It's true we don't see many of those DEBUG constructs
> anymore nowadays and overhead for might_sleep() and WARN_ON() is
> negligible.

I agree.  I have something similar for pinctrl, maybe that needs to
go too.

Yours,
Linus Walleij
