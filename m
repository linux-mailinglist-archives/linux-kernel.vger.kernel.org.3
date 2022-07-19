Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F53C579501
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:10:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237091AbiGSIKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236926AbiGSIK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:10:26 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA03FA1C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:09:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id z23so25681851eju.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5cTYTqWaTMF9MhTCmeKhpWnFSKz6cFUJZCFLS451Ws=;
        b=xLyoJ+VAQX96XbLh3R+9UyAd9edhCXgdgOCpMgqxnJQJvZ85fC7ZY3h8bNW0nRGe8q
         EjnRKmjoIe0KqrAgtWPz94bTCKRiFC8Spy1as9hRHyl28m5noVAmvA/uOYqCnrpu2zxI
         vFP5DIrfStJcsO53qfBI8LpfryOl0oWlanh26fCRmcMY/cAcNKaiKB7S6Apa8FEj0IAV
         q1jomyFIkKSBQs7DJkAUdMqL49jiVlF+l/V1KDwNv5RY0QyE+m2mjY7Zp7tgsR2ZveIz
         Sy736+zV9uRn7AlFt+MvSM/FgJQYo+px0usaf/58aSUctZjeYlDy7EqOWq81dk0uD8v+
         5vnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5cTYTqWaTMF9MhTCmeKhpWnFSKz6cFUJZCFLS451Ws=;
        b=p3yPQYvObZDUsgA8DHwpeOhDI1sGKNcW99M0B6O5nSX94UaWe/2c3ssVYEMJ36Ikea
         kl0vPG2bp7PFZ20lWDlQI6w+bcLSoSKS6fhJtmZx9bS5RD9hInvkwcn8UFcYalHNF418
         Uwgkh9qCWK+mxQDS0M2Q2ENA1aV/61gpLwhXI4v54D9QcLAU3iXUrpgjccC+otJY9DL5
         62SLCBunytl0kDM23gqWWVK8NBQuW93exKr5lVIwberCaqIdxaqlVpJFQSxtSZWr/0s2
         euzYlR+gWRVDIMhIHsHw48AfB7kTMUzihNSoVGw+M+j5yJ9J88u0LJ9g3pzZzZqBfPnl
         nU5A==
X-Gm-Message-State: AJIora9acWojrKfvQAxKRrgMnJ/O1xV1lhnwp7wxYhQXFwjBsriruK/G
        kMwS7iA1LMmUXeA8t13TxW1P7DzqwOeM/I5hLCmzGB8Xg1I=
X-Google-Smtp-Source: AGRyM1vGnJuGuq0kxjJXfwngw5016nfoq4Vr8Pxr+v8bkiocsiRhgEVWdAtOlGpQ7mAoo+1HzxdHVrzxmLsKX6xG5Iw=
X-Received: by 2002:a17:907:1b16:b0:72b:8c16:dac0 with SMTP id
 mp22-20020a1709071b1600b0072b8c16dac0mr28429198ejc.286.1658218183931; Tue, 19
 Jul 2022 01:09:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657907849.git.william.gray@linaro.org>
In-Reply-To: <cover.1657907849.git.william.gray@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 19 Jul 2022 10:09:33 +0200
Message-ID: <CAMRc=MeoZ9tp_AJPqD8DWGa_HJojwSrwfZMbTv_6uRq-dSMz9w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] gpio: Implement and utilize register structures
 for ISA drivers
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Hentges <jhentges@accesio.com>,
        Jay Dolan <jay.dolan@accesio.com>,
        Fred Eckert <Frede@cmslaser.com>,
        Paul Demetrotion <pdemetrotion@winsystems.com>,
        techsupport@winsystems.com,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 18, 2022 at 10:56 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
>
> Changes in v3:
>  - Updated contact information in MAINTAINERS
>  - Added help text for GPIO_I8255 Kconfig option
>  - Move include/linux/gpio/i8255.h to drivers/gpio/gpio-i8255.h
>  - Include "gpio-i8255.h" instead of <linux/gpio/i8255.h>
>  - Include linux/types.h instead of linux/compiler_types.h
>  - Add underscores for *PORTC_LOWER* and *PORTC_UPPER* defines
>  - Move (offset % 8) expression to a port_offset const above the io_port
>    const in i8255_direction_mask(); this should help optimize assembly
>    instructions on some architectures
>  - Implement an opaque i8255_state struct to organize and access i8255
>    device states; this replaces the control_state array passed to
>    various i8255 library functions in previous patchsets
>  - Implement and provide a i8255_state_init() function to initialize the
>    i8255_state struct for a consumer
>  - Use a spinlock within i8255 library functions to protect access to
>    i8255 states and synchronize I/O operations; a spinlock is used so
>    that these functions may be used within an interrupt context
>  - Export the i8255 library symbols within a new I8255 namespace
>  - Update the 104-dio-48e, 104-idi-48, gpio-mm drivers to use the new
>    i8255_state struct and I8255 namespace
>
> The PC104/ISA drivers were updated to use I/O memory accessor calls such
> as ioread8()/iowrite8() in a previous patch series [0]. This
> patchset is a continuation of the effort to improve the code readability
> and reduce magic numbers by implementing and utilizing named register
> data structures.
>
> One of the benefits is that we can now observe more easily similarities
> in devices that share similar interfaces; such as the i8255 interfaces
> used by the 104-DIO-48E, 104-IDI-48, and GPIO-MM drivers -- as well as
> the similar interface used by the 104-IDIO-16 and PCI-IDIO-16 drivers.
>
> A new module supporting the Intel 8255 interface is introduced to
> consolidate the common code found among the 104-DIO-48E, 104-IDI-48, and
> GPIO-MM drivers.
>
> [0] https://lore.kernel.org/all/cover.1652201921.git.william.gray@linaro.org/
>
> William Breathitt Gray (6):
>   gpio: ws16c48: Implement and utilize register structures
>   gpio: 104-idio-16: Implement and utilize register structures
>   gpio: i8255: Introduce the Intel 8255 interface library module
>   gpio: 104-dio-48e: Implement and utilize register structures
>   gpio: 104-idi-48: Implement and utilize register structures
>   gpio: gpio-mm: Implement and utilize register structures
>

Hey William!

Are you planning to submit a fourth version anytime soon? I am willing
to take it for the next merge window if it arrives soon - like
tomorrow at the latest.

Bart
