Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40E1557E61
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 17:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbiFWPAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 11:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiFWPAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 11:00:04 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A94255B8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:00:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z19so12097802edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 08:00:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1I+H7mKLuciospk8XLiOwY0zoRetqfQqz09CPUbHidw=;
        b=4+UNEOjuTT2kDTMTdbBW1QEMujI3B7rcPT7Hzcx5pHVwXAhc4Mz6eDCry9sPWqeLET
         kRP5LDwRA+NrO29G2jFdmzUP3TOv31hMvTsBFh7r2tAajCddBFA/eYil8SxfNtCuq879
         Ah/J74ENxQvkS2vGuAc54nEwePygDD8JhD9hW7qSbjgP5bqfTc/MWQ/9JqfxGLrqQxhS
         VgKvxtQnTvVDUK6In+O517MASyt+1KJegVdGWqAPpa74Hoir+uNQVDlnSw0Raoskq1sl
         4YOrnZI3+pHyBVacaYs4XQjBhdD4JTGeqJwLWCScDSI8eT5URwm8dFSfukyGBENawTmY
         4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1I+H7mKLuciospk8XLiOwY0zoRetqfQqz09CPUbHidw=;
        b=k3nU3TPxJyyb/c3Xc8dOr4K0jE555DBsz7l5DXJHohLPQxTp3VFuf3Sd6sO/v9l9Fm
         5tqcpRqUq1GLx4E27IxkbVoEvSvl08jcqOn/bXVOUDdBRRh/et0pN1NQ0yeQxCs+Tq0x
         WJh9VXwDG3dKXcAoUQpRQZIZHQNQrp0Oc9T+xkXEucIFgGw3X3et3Rk++4xFeGNy1QZL
         zgLFpPyHX5sXJpDyoUtALFqR8DqRzkGBpxY6u7aHfZEZCc1dqGnhNw0I6K0fa6zUR+wf
         8rJrOA46H+mVNRE7v2pcyzccJWntJ06gIh3tXnMDRwU/E2X25xMwIknt9nVhFSfnWL2a
         p7lA==
X-Gm-Message-State: AJIora9J3pgNWHYIYsSSwcwpsi4GGXKvynHbb1NkGR6rsGSH7ztsBD1e
        vnd6I92GFMY1+TYbdhZwPYEiOPO/Cn04Q7jaUB03kw==
X-Google-Smtp-Source: AGRyM1t7VL7bhQSqgEA8UycOf9E2ObyYZrbsvOUrhuoWRmzWAIHGjQJBhDlRMa1QNh6mmLSBhtvg6rDl+1ETB/t2wDs=
X-Received: by 2002:a05:6402:2402:b0:435:3418:61b5 with SMTP id
 t2-20020a056402240200b00435341861b5mr11157236eda.82.1655996400602; Thu, 23
 Jun 2022 08:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220622155422.23945-1-menglongwoo@aliyun.com>
In-Reply-To: <20220622155422.23945-1-menglongwoo@aliyun.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Jun 2022 16:59:50 +0200
Message-ID: <CAMRc=MdcxeRAHyGw2PPL9sN8qHL=YLKHDu2TDpCUUjBdNW3Qcw@mail.gmail.com>
Subject: Re: [PATCH 0/2] gpio: gpio-sim: read property 'gpio-base' from dtb
To:     Menglong Wu <menglongwoo@aliyun.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 5:54 PM Menglong Wu <menglongwoo@aliyun.com> wrote:
>
> The first GPIO number of the gpio-sim module is dynamic.
>
> gpio_chip.base = -1.
>
> ```
>     gpio-sim {
>         compatible = "gpio-simulator";
>         bank0 {
>             gpio-controller;
>             #gpio-cells = <2>;
>             ngpios = <16>;
>             gpio-sim,label = "dt-bank0";
>             gpio-line-names = "", "sim-foo", "", "sim-bar";
>         };
>     };
> ```
>
> If I want to export GPIO from user space. I have to confirm the number
> from the debugfs filesystem. The 16 GPIO be map to 2032-2047.
>

I find it ironic that you're trying to use sysfs to play with the
module whose sole purpose is to facilitate the move away from it. I'd
like to hear a very good reason to add this option because otherwise
you're exposing information that should very much be hidden from
user-space.

Bart

>
> ```
> [root@QEMU-ARM ~]# cat /sys/kernel/debug/gpio
> gpiochip0: GPIOs 2032-2047, parent: platform/gpio-sim, dt-bank0:
>
>  gpio-2033 (sim-foo             )
>  gpio-2035 (sim-bar             )
> ```
>
> Change
>
> Then add the property 'gpio-base' to fix the base number.
> Although the method is be DEPRECATED (include/linux/gpio/driver.h)
>
> ```
>     gpio-sim {
>         compatible = "gpio-simulator";
>         bank0 {
>             gpio-controller;
>             #gpio-cells = <2>;
>             gpio-base = <300>;
>             ngpios = <16>;
>             gpio-sim,label = "dt-bank0";
>             gpio-line-names = "", "sim-foo", "", "sim-bar";
>         };
>     };
> ```
>
> This base number is always 300.
>
> ```
> [root@QEMU-ARM ~]# cat /sys/kernel/debug/gpio
> gpiochip0: GPIOs 300-315, parent: platform/gpio-sim, dt-bank0:
>  gpio-301 (sim-foo             )
>  gpio-303 (sim-bar             )
> [root@QEMU-ARM ~]# echo 300 > /sys/class/gpio/export
> ```
>
>
>
>
> Menglong Wu (2):
>   gpio: gpio-sim: initialize gpio_chip->base from dtb
>   docs: gpio-sim device-tree example with gpio-base
>
>  Documentation/admin-guide/gpio/gpio-sim.rst | 3 +++
>  drivers/gpio/gpio-sim.c                     | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
>
> --
> 2.30.2
>
