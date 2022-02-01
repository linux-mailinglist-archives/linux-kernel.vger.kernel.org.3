Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F0B4A592C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 10:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbiBAJ1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 04:27:15 -0500
Received: from mail-4022.proton.ch ([185.70.40.22]:43545 "EHLO
        mail-4022.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbiBAJ1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 04:27:14 -0500
Date:   Tue, 01 Feb 2022 09:27:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1643707632;
        bh=+2uWf9UcTSR/4vvg3PtafoJ+NVCgHeC107J37zjRulA=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=Y0Y1+ad8uEfmUqJMBEcm/DxKnTKzc8w+TsPzUnwM7iDeV9frOGDKlS9yjM1gCzu00
         qiHn2n2xP+M8Y5SLDbZvpRlEcKXvBPb7kPiTOJIBDzCgYVZ37VH0ss345F8nsIHmVL
         zgVoZndkLKuZi9ksnBzCGNxQLrSqXqm7AVVhhmAr3TzLboobsy4ei2qt2xS3+8gPoK
         TeDs52GoaC+BzhFh7QMFC7g4iHW1kFJRVZcIIzH8oRSE7A2ZxjJ5WIN/N8lXseFnbQ
         3cDt89/maaKcSSW5Pv0yrB7ZMmkPORTrzpU7cR0ZLPbybazxaJWEOXUxtdtTZV7yeS
         iT0n+gc8PNS8g==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
Message-ID: <8vOr78Nu7IEcITxWHXWTru7vu_VE9g-5v_8eotyLeJjbI-czksMS57WV2knv6sd3cMMaJSYrnPAOfnHQkj7iK-R_YYHfOvJjCCkE48dW_qQ=@emersion.fr>
In-Reply-To: <CAMuHMdXMayLLRavAJJujmPqT+Vd11dPfycqXie3w_pOkS8i9eA@mail.gmail.com>
References: <20220131201225.2324984-1-javierm@redhat.com> <CAMuHMdXMayLLRavAJJujmPqT+Vd11dPfycqXie3w_pOkS8i9eA@mail.gmail.com>
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

On Tuesday, February 1st, 2022 at 09:43, Geert Uytterhoeven <geert@linux-m6=
8k.org> wrote:

> Does there exist another simple test program for showing something
> using the DRM API?

If you're fine with going low-level, there's tentative [1] which can apply =
an
arbitrary KMS state. See for instance [2] for basic mode-setting.

[1]: https://git.sr.ht/~emersion/tentative
[2]: https://git.sr.ht/~emersion/tentative/tree/master/item/examples/modese=
t
