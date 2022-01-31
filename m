Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5560A4A504A
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 21:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350773AbiAaUjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 15:39:19 -0500
Received: from mail-4323.proton.ch ([185.70.43.23]:16858 "EHLO
        mail-4323.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343999AbiAaUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 15:39:16 -0500
Date:   Mon, 31 Jan 2022 20:39:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1643661555;
        bh=dH3eoDiuTRG4LwvARMrzyrTqGWXyQvd60RD429UU8hQ=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc;
        b=fE0JQgRX7dCh1naqGopEHMcsQGpTnAZlBzyIh0sE+hfsRw7JPzXdEPCJfTjO5rY/W
         BWOHtLX6MI5SbrtO/pV2Rqk9qwsz3gR2kF6LUhSjRIDg/tLy6g6N4C3VmWJgsHBPd3
         3AqwXxVzfEef4fWRrW7B3T7br6+Fqq+vYALWDSD/AZMv7DrHn8z3idAkW1TV0yPqL1
         qD5A6hoT6S/byW/UAbi7KoESB4Rj2p0F7VKO0tCxaIVialEbbCQbSB5sTDp738oDf8
         LOZHIg5loU2mjwp0d1N+GWmtHP357U/9gBEODn3ZeYsXbf9hz7AMGjUkKpRNI7GhcF
         zpvoSvZn74xKA==
To:     Javier Martinez Canillas <javierm@redhat.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        =?utf-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 0/4] drm/tiny: Add driver for Solomon SSD1307 OLED displays
Message-ID: <wuXPJN-K-rvjoV51c4EBmTBScov8rcJTPoYmlfHe04_-4wD1khVxo9HnUsP7UFd5m4AkzGSw2hXe_c77jbSRhjEJ0JZIYwuvuIkcv_KsR-Y=@emersion.fr>
In-Reply-To: <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
References: <20220131201225.2324984-1-javierm@redhat.com> <tIMIWqepcZGntnez-1ss4Kn4K8btXnzDRL7EWd19-745WK90YIC19E_4di9RNvB3gtx-PzWEjBEGQLPNJE_x0T1yyyaWFCoFcCiG4StR9RU=@emersion.fr>
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

On Monday, January 31st, 2022 at 21:36, Simon Ser <contact@emersion.fr> wro=
te:

> This driver only advertises XRGB8888 in ssd1307_formats. It would be nice=
 to
> expose R8 as well so that user-space can directly produce suitable buffer=
s.
> It would also be nice to have some kind of preferred format, so that user=
-space
> knows R8 is preferred over XRGB8888.

Hm, since the format used by the hw is actually R1, adding that to drm_four=
cc.h
would be even better.

Let me know if you want me to type up any of the user-space bits.
