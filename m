Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D34A588F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 09:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235524AbiBAIeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 03:34:24 -0500
Received: from mail-4022.proton.ch ([185.70.40.22]:50556 "EHLO
        mail-4022.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235455AbiBAIeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:34:23 -0500
Date:   Tue, 01 Feb 2022 08:34:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1643704461;
        bh=ZSvajkdoeu6T/5gwHqxbSKVr0/IAOJHAte+Vttk26Vs=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=K6yFH9B8BZSho8dYMOG+Zx/RNYwz9+S71EJL5xTa3n1k0vr5bSf5Cr23bMT3aHFfN
         wF43qDnv3W5N5uIG13Qo84oW73eVxwWFFfXUoluU5hepGAvndKXKkBp9oamnrSiCtY
         vvIMcknD8Yk4GWAN57lUIyc9tgQGpw+1PlgU7/kvmzJkJHQZbmIM84+rKN2lKh5MWR
         oHSk8NjtPQrLaOQ9I49H7rT4AD6zjM7u3oE8pm53vOavrLOQqbVZi9uWlRMlwaIH43
         KA6EN8Cl6ptSAH7o0pDpmFLiWKfJ7/2q3SNcXLk2isZBiFzVY5l9ZAIQ1t/5Dxvve7
         1EGUOs3Sa4bRg==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Simon Ser <contact@emersion.fr>
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
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
Message-ID: <qmhzv6kqs6QdAOP3bNB39glOpc8eeJ6flgjfjcaBniT-shDKZkxo5uB71weGOUKxPE6dq_WBhtHmY5vMmuYwqMoHgtMWnX0ESE5R1Y5g5F8=@emersion.fr>
In-Reply-To: <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com> <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr> <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr> <CAMuHMdXKZ=BkvVqdpiNPNJgxm9SzQ3Z0n4SqV2-4oPRveybd6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=10.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,T_SCC_BODY_TEXT_LINE
        shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 1st, 2022 at 09:26, Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:

> What's the story with the Rn formats?
>
> The comments say "n bpp Red", while this is a monochrome (even
> inverted) display?

I don't think the color matters that much. "Red" was picked just because it=
 was
an arbitrary color, to make the difference with e.g. C8. Or am I mistaken?
