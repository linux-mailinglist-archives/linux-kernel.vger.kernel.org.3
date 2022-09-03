Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9609B5AC16C
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 23:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiICVKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 17:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiICVKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 17:10:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693C052802
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 14:10:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z8so6914533edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 03 Sep 2022 14:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=vJKtdgXq7yuBweDmfJZUWn/nlXQ6UJlkcHeot6gA4Ag=;
        b=QO8Gsxbs5Jffjg4C1YRMcMoianiLTUpUlUfkoWl8/yhHrLOOTQR4QSLzA/k0vHZsnz
         Zuo1tLfZtixr4Mde4wRIXBjOC4o32+0I5e1l52SeKo2j8W/UKGEbLsxnjrt0TgAtVUON
         xEk4QTzMMoaDXB6N9FhnQldba+Lw/fRYG234EYfwOomOGwKg2pJQsF49iy2/vgQyYn5R
         TF2LohBi5gcsKMWl9HOuT/9y3KOONr6cJSRQfTlmQ+1NNx2OY60QjbUp8XDrrJwnX8ve
         NVHZzusYcQ6Ka2ku0oqTVnySaBwH3sCJVqVH54YDrcZQPB+ZUy6ud5zCIJgFe12dJxCs
         l3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=vJKtdgXq7yuBweDmfJZUWn/nlXQ6UJlkcHeot6gA4Ag=;
        b=4CBcG+AW1lQ6I8vjXfNpMbsmjRjm3HFguCVgJwfd9yGkY7MYycqQ1A2ZKdiW2ZrWtj
         4x0xwo5VtO1w65W68P9iLYQpLXEw1Z45I/7JAhi+deJRqFjOSit2fo/ySf0ap0WZ239L
         ldNiA/vFtebPUBXBKpKlxS4fPH90aQE07KfcLKLN91KKr2scXUD1bzuKGJXQdZ3TSADE
         ilp17QPowEhjG15zyASQjGK4X3azIKicbBxfcvlZX0jDDap3tFzyJv4I9K4A/1VZARpg
         GPPd9cuyLDqdkwCr0LIKWJELgy/xmYM4I5kX7gjTjDABzMzdtvWDYAB8K4YlqQxEA8t7
         RYrQ==
X-Gm-Message-State: ACgBeo1r8D6MfaTzJAUC/4N27fqAXmKJEgAbKp5JFz/LYkJlTqAf7rZr
        0EBylzWir+6gfxQvEziw+MThOlEjySSkKEJMrUU26w==
X-Google-Smtp-Source: AA6agR7erVlroClkeFb3zhIgBfDh5pGTzjruKq0qjH9dguKnc2JT2q8khr8k8WVHQLCYF7Ke5G38cqTdwXTD0JMDBpU=
X-Received: by 2002:aa7:d292:0:b0:447:f99d:8b9b with SMTP id
 w18-20020aa7d292000000b00447f99d8b9bmr33012566edq.29.1662239446007; Sat, 03
 Sep 2022 14:10:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1662140119.git.william.gray@linaro.org>
In-Reply-To: <cover.1662140119.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Sat, 3 Sep 2022 23:10:35 +0200
Message-ID: <CAMRc=MeURJXOrbD-xi=QfZKr9KViF-Cu5r2bWnKQAbj0dj0YGg@mail.gmail.com>
Subject: Re: [PATCH 0/4] Make irq_chip immutable for ISA drivers
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 2, 2022 at 11:40 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Kernel warns about mutable irq_chips in ISA drivers:
>
>     "not an immutable chip, please consider fixing!"
>
> Make the struct irq_chip const, flag it as IRQCHIP_IMMUTABLE, add the
> new helper functions, and call the appropriate gpiolib functions.
>
> William Breathitt Gray (4):
>   gpio: 104-dio-48e: Make irq_chip immutable
>   gpio: 104-idi-48: Make irq_chip immutable
>   gpio: 104-idio-16: Make irq_chip immutable
>   gpio: ws16c48: Make irq_chip immutable
>
>  drivers/gpio/gpio-104-dio-48e.c | 10 +++++++---
>  drivers/gpio/gpio-104-idi-48.c  | 10 +++++++---
>  drivers/gpio/gpio-104-idio-16.c | 18 +++++++++++-------
>  drivers/gpio/gpio-ws16c48.c     | 10 +++++++---
>  4 files changed, 32 insertions(+), 16 deletions(-)
>
>
> base-commit: 6ae8e1d0d5e5de922315830aea975c63e8c70b2f
> --
> 2.37.2
>

Queued for fixes, thanks!

Bart
