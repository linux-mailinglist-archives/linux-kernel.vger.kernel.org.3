Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17874A5896
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbiBAIhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:37:11 -0500
Received: from mail-vs1-f42.google.com ([209.85.217.42]:39782 "EHLO
        mail-vs1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbiBAIhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:37:09 -0500
Received: by mail-vs1-f42.google.com with SMTP id a7so15124832vsc.6;
        Tue, 01 Feb 2022 00:37:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4vrfqDZv98izNocIMjPY/vNKpLIW8vGPDDyzaE9lmNM=;
        b=2xEbzTJUDlnWwgB6mmXSFNXNZC2qJtEofolFK9EfG4t394ZuGhPXj0qlOr2UWxwUMQ
         lTuYgwYVmaY65C1eQD3nauF2ODiYDTiBMYOlaaYYu6Id2lmhh1a8MGqP+Rs03Qy/yNJG
         Ug1WpnEY1UrKHf3Bzq0tjDz3py0r+hOGWVMiWbnnrjvK6d/Ixb15KNaKX8+4BLOAig6U
         FGK3geD7YGGSYB6SOMIQtkl0KNFwzwxMGs1k81OXwDxpKRoZh/m+N2G7fjkFV+oMi7iD
         vuJA4UlMEFJG9hJmxu8a3OxVV+glEDHv5hpNNZRlq+561lNMMuaCOtVNK7iJigHZowVq
         pRdA==
X-Gm-Message-State: AOAM5307CxFvmwVftByOq4fJ2ASqQnShyInOfmbZNJCBg+erVPydjFoD
        v+FhyWVa47nHv1LNfhAxDoB1REn07jjT8A==
X-Google-Smtp-Source: ABdhPJzc1bPcs9RkJVEwtvb6PBf7KMRMWgHhMOEF8tdwvtRbEMCTPP0hSvf7JC/2dahjas7JJMSXOw==
X-Received: by 2002:a67:f8c4:: with SMTP id c4mr9146947vsp.79.1643704628391;
        Tue, 01 Feb 2022 00:37:08 -0800 (PST)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id v201sm4948791vkv.54.2022.02.01.00.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Feb 2022 00:37:07 -0800 (PST)
Received: by mail-vk1-f179.google.com with SMTP id m131so9961940vkm.7;
        Tue, 01 Feb 2022 00:37:06 -0800 (PST)
X-Received: by 2002:a05:6122:c8f:: with SMTP id ba15mr10046534vkb.39.1643704626599;
 Tue, 01 Feb 2022 00:37:06 -0800 (PST)
MIME-Version: 1.0
References: <20220131201225.2324984-1-javierm@redhat.com> <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
 <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
 <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com> <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
In-Reply-To: <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Feb 2022 09:36:55 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUHhUkPhq8M0d=p5EgH8bBz6EtH4drajKtQHE0121V1uQ@mail.gmail.com>
Message-ID: <CAMuHMdUHhUkPhq8M0d=p5EgH8bBz6EtH4drajKtQHE0121V1uQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
To:     Simon Ser <contact@emersion.fr>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?UTF-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Tue, Feb 1, 2022 at 9:34 AM Simon Ser <contact@emersion.fr> wrote:
> On Tuesday, February 1st, 2022 at 09:26, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > What's the story with the Rn formats?
> >
> > The comments say "n bpp Red", while this is a monochrome (even
> > inverted) display?
>
> I don't think the color matters that much. "Red" was picked just because it was
> an arbitrary color, to make the difference with e.g. C8. Or am I mistaken?

I'd expect 8-bit grayscale to be Y8 instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
