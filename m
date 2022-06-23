Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20F7558A9B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 23:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiFWVVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 17:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiFWVVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 17:21:32 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FCB4D258
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:21:31 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id eo8so839896edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 14:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XXr3wvfzyPEEB6ageHJZCwuCmEqrP5Y6OCseOgyEFs=;
        b=1taa7fGzS0gwwiZZZMghFVWNNBD1llCsgooIA2VHj0ACeTQSu5DJsqavaUQLBx/GNc
         oveXSh33asHduJoA8f87sIF4sYudQi/oKjL+1cYTd7cYb1k05SJ/u/9jeyZoJBkBC7PU
         mE+/aREHomvvpd5YRJmbQKmErtLQZ09ocAyhX22DvzoAp705CBEgs1Uy83W/KN5vlTDW
         stRGodkF253VTTmAfgTgtAdH3vnnsSQ/A/iKfzsPziEvqwL+RE5GdfRwZw7ZHSanz/ED
         Ycluk1Gn1hTjoF3E+tFattpXKMs4v7Hyo+dN7f/a/aeZQJkCeQwNcUiVsOQDKvSPeLlV
         t50g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XXr3wvfzyPEEB6ageHJZCwuCmEqrP5Y6OCseOgyEFs=;
        b=P4hD5KqK5sbwjErqvbiXmECihG0Hvn1vsmdJ4HPlywi9UqyHDXVj16m7Z92MIjOyAS
         +5gKHPqPTcM+2rvrQHR5MyHLdqu5OxaUK6yVwYQUS/zQb+TVJVPdyEQdfHCZ7ezsBgVW
         hfGhTEY07qf9qvs0dsBZfIB9TMwRZklu+ob90TSHA3WlHA0cW3eb6KuIUfHJrPgJNwCC
         opyMXoW5Ga9tKcXjK4pWBtr0KkINiN+w6I8NSEHD1RfVEs0gqKB7wpSg7rgqxKaZLq5a
         goPoWCnO64YAms3f2mr6OKaUkNrK7K3M4nGoUQGgwpnEmVs/bddvy5CmeaBYdGVOym6K
         jjFQ==
X-Gm-Message-State: AJIora/rf+FuHLK/aNtXRes2qmjKvDNFR6DfohhokdOl+sd25ep9sB9x
        9ZSkN0P52fVf+nWVJ0SMltArykTMxkxYwZ4F2uG93g==
X-Google-Smtp-Source: AGRyM1tIomF/CV81BQAJ3q4sAaFjsJj+DjqtGKsjlsj/RS3fVXAqHWOMzY1sdoaCaCn4BhusN8e2ERzS4C62EHigcTM=
X-Received: by 2002:a05:6402:18:b0:435:9a79:9a40 with SMTP id
 d24-20020a056402001800b004359a799a40mr13135974edu.328.1656019289606; Thu, 23
 Jun 2022 14:21:29 -0700 (PDT)
MIME-Version: 1.0
References: <YrSnkBodv7TYvtMb@posteo.de>
In-Reply-To: <YrSnkBodv7TYvtMb@posteo.de>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Jun 2022 23:21:19 +0200
Message-ID: <CAMRc=MfT__UTcVx8r84qFTh3raroB1Cyp0dPrbJ9L6eYO_LGRg@mail.gmail.com>
Subject: Re: [PATCH] docs: driver-api: gpio: Fix some typos
To:     Tom Schwindl <schwindl@posteo.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
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

On Thu, Jun 23, 2022 at 7:49 PM Tom Schwindl <schwindl@posteo.de> wrote:
>

Please add some description here as is customary in kernel git messages.

Bart

> Signed-off-by: Tom Schwindl <schwindl@posteo.de>
> ---
>  Documentation/driver-api/gpio/consumer.rst   | 2 +-
>  Documentation/driver-api/gpio/driver.rst     | 6 +++---
>  Documentation/driver-api/gpio/using-gpio.rst | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/driver-api/gpio/consumer.rst b/Documentation/driver-api/gpio/consumer.rst
> index 72bcf5f5e3a2..de6fc79ad6f0 100644
> --- a/Documentation/driver-api/gpio/consumer.rst
> +++ b/Documentation/driver-api/gpio/consumer.rst
> @@ -114,7 +114,7 @@ For a function using multiple GPIOs all of those can be obtained with one call::
>
>  This function returns a struct gpio_descs which contains an array of
>  descriptors.  It also contains a pointer to a gpiolib private structure which,
> -if passed back to get/set array functions, may speed up I/O proocessing::
> +if passed back to get/set array functions, may speed up I/O processing::
>
>         struct gpio_descs {
>                 struct gpio_array *info;
> diff --git a/Documentation/driver-api/gpio/driver.rst b/Documentation/driver-api/gpio/driver.rst
> index 70ff43ac4fcc..6baaeab79534 100644
> --- a/Documentation/driver-api/gpio/driver.rst
> +++ b/Documentation/driver-api/gpio/driver.rst
> @@ -119,7 +119,7 @@ GPIO lines with debounce support
>  Debouncing is a configuration set to a pin indicating that it is connected to
>  a mechanical switch or button, or similar that may bounce. Bouncing means the
>  line is pulled high/low quickly at very short intervals for mechanical
> -reasons. This can result in the value being unstable or irqs fireing repeatedly
> +reasons. This can result in the value being unstable or irqs firing repeatedly
>  unless the line is debounced.
>
>  Debouncing in practice involves setting up a timer when something happens on
> @@ -219,7 +219,7 @@ use a trick: when a line is set as output, if the line is flagged as open
>  drain, and the IN output value is low, it will be driven low as usual. But
>  if the IN output value is set to high, it will instead *NOT* be driven high,
>  instead it will be switched to input, as input mode is high impedance, thus
> -achieveing an "open drain emulation" of sorts: electrically the behaviour will
> +achieving an "open drain emulation" of sorts: electrically the behaviour will
>  be identical, with the exception of possible hardware glitches when switching
>  the mode of the line.
>
> @@ -642,7 +642,7 @@ In this case the typical set-up will look like this:
>
>  As you can see pretty similar, but you do not supply a parent handler for
>  the IRQ, instead a parent irqdomain, an fwnode for the hardware and
> -a funcion .child_to_parent_hwirq() that has the purpose of looking up
> +a function .child_to_parent_hwirq() that has the purpose of looking up
>  the parent hardware irq from a child (i.e. this gpio chip) hardware irq.
>  As always it is good to look at examples in the kernel tree for advice
>  on how to find the required pieces.
> diff --git a/Documentation/driver-api/gpio/using-gpio.rst b/Documentation/driver-api/gpio/using-gpio.rst
> index 64c8d3f76c3a..894d88855d73 100644
> --- a/Documentation/driver-api/gpio/using-gpio.rst
> +++ b/Documentation/driver-api/gpio/using-gpio.rst
> @@ -44,7 +44,7 @@ These devices will appear on the system as ``/dev/gpiochip0`` thru
>  found in the kernel tree ``tools/gpio`` subdirectory.
>
>  For structured and managed applications, we recommend that you make use of the
> -libgpiod_ library. This provides helper abstractions, command line utlities
> +libgpiod_ library. This provides helper abstractions, command line utilities
>  and arbitration for multiple simultaneous consumers on the same GPIO chip.
>
>  .. _libgpiod: https://git.kernel.org/pub/scm/libs/libgpiod/libgpiod.git/
> --
> 2.36.1
>
