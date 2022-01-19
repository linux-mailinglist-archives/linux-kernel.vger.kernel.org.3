Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3545493674
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:40:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348201AbiASIkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348416AbiASIkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:40:06 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D210CC06161C;
        Wed, 19 Jan 2022 00:40:05 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id m3so6595862lfu.0;
        Wed, 19 Jan 2022 00:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=SXQq9rN5zBUkQKNE0Ivp3Pzg3xcm4M4u40k+sMdUxTA=;
        b=fhc0hK1/WnEzeZqe7BKS8KCMrfuRKaA+bBGmof8JOE9+6GMUmkvTZgBVPmfSf5c1D9
         rQg8D0i7Rqz4NFAewNNakJ7w0oDxbJk7l/Z+B4yetE5iyMYPwRxZjnlfc0csJmsgzrpN
         Uikj9y79xNJZYEvwNs8ctv9mO6YCzruThn1OlFMkpJ7pXRaau9pYeBoC0KmJIAmZWgQl
         6pC4QyFi+b2/5PNP3niAP/0Gh8VTGVECB1zxNH3xw0f5sViQ+nO+AD1DfriZ74Lj+wXW
         vCfkd0D5RYfRiQqLjoCQbXen4jXTUdaksg2/R1ndVjxLzPVedPs9DeZ27zCm4CFB6huU
         +deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=SXQq9rN5zBUkQKNE0Ivp3Pzg3xcm4M4u40k+sMdUxTA=;
        b=A5/FFCXsnBIZyUH2/Z/5O2z4k9kMbjUZu5WWUWG9CmWFLsIAJJC9Dj4ez/FCcvKNNW
         EyY4ZGlbmKzmOwBumakL/HbOAiTbdwduOuEtehzI01WZi0Rmq7u0R0HN6WPh+JjT+LeY
         Moq6gbIvavcuJBr9QMoH1H+LJu9BjL1jdzSbF8ESEzMqdnsN3z8Or4xWUMD7vxa485k4
         jPm4L61WxUsJciDWe+x5lk0YxE76XRmsEjPKIu6ZnTpQk0EsldxwUl3agFEsK9ckYYzX
         3IMJjWqjQFHQ+Xw89vq7j7vcOwNQGs4MDxyh8tGewTgXJJ7Z9mQKiuBacO3ac39M0W8S
         U64Q==
X-Gm-Message-State: AOAM532w8VKJF3dQsisE4UjZB777R1Bvvcp8KgkAwAW4jb/HdLYYEat7
        URJ6I9VcC/Es3i0JO4JzjI0=
X-Google-Smtp-Source: ABdhPJwxq0qLxjcvHPejq/3Va1n4aFFKdh6SzZ39AvI96pEeJFP1ic33G48wGqCvRn5McCgtLxEgIg==
X-Received: by 2002:a2e:5801:: with SMTP id m1mr12246227ljb.164.1642581604046;
        Wed, 19 Jan 2022 00:40:04 -0800 (PST)
Received: from eldfell ([194.136.85.206])
        by smtp.gmail.com with ESMTPSA id k21sm1451287lfu.24.2022.01.19.00.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 00:40:03 -0800 (PST)
Date:   Wed, 19 Jan 2022 10:39:53 +0200
From:   Pekka Paalanen <ppaalanen@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Sven Schnelle <svens@stackframe.org>,
        dri-devel@lists.freedesktop.org, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Helge as fbdev maintainer
Message-ID: <20220119103953.75138bac@eldfell>
In-Reply-To: <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org>
References: <YeG8ydoJNWWkGrTb@ls3530>
        <c48ad8ae-aea5-43fa-882f-dccb90dde9a4@suse.de>
        <87bl0amc6s.fsf@x1.stackframe.org>
        <20220118103323.4bae3a7d@eldfell>
        <20220118095352.xsb6fqacw4p276c5@sirius.home.kraxel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/bND91UWGGOh_7.dIQvYk7JE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/bND91UWGGOh_7.dIQvYk7JE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Jan 2022 10:53:52 +0100
Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Tue, Jan 18, 2022 at 10:33:23AM +0200, Pekka Paalanen wrote:
> > On Mon, 17 Jan 2022 19:47:39 +0100
> > Sven Schnelle <svens@stackframe.org> wrote:
> >  =20
> > > I also tested the speed on my Thinkpad X1 with Intel graphics, and th=
ere
> > > a dmesg with 919 lines one the text console took about 2s to display.=
 In
> > > x11, i measure 22ms. This might be unfair because encoding might be
> > > different, but i cannot confirm the 'memcpy' is faster than hardware
> > > blitting' point. I think if that would be the case, no-one would care
> > > about 2D acceleration. =20
> >=20
> > I think that is an extremely unfair comparison, because a graphical
> > terminal app is not going to render every line of text streamed to it.
> > It probably renders only the final view alone if you simply run
> > 'dmesg', skipping the first 800-900 lines completely. =20
>=20
> Probably more like "render on every vblank", but yes, unlike fbcon it
> surely wouldn't render every single character sent to the terminal.

Yes, and since 1k lines of dmesg is such little data, I would guess
even an old machine can chew that up in much less than one refresh
period until it needs to draw, so there is only going to be one or two
screen updates to be drawn.

Also, since X11 does not have vblank or frame boundaries in the
protocol, a terminal emulator app will do render throttling somehow
else. Maybe when it temporarily exhausts input and a timer as a
deadline in case input just keeps on flooding, would be my wild guess.


Thanks,
pq

--Sig_/bND91UWGGOh_7.dIQvYk7JE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmHnzlkACgkQI1/ltBGq
qqeVcQ//b/3acJqaOlvPPa2ubpvE2sLqP9JGlaV2ADN6X12IuC9N8dxIvV/Wt5J7
XrK47knUS0THSys+KigeUJa5bVTwquZLkfWp+eBECsyNulcv0PMFIoWHSCQBWHfO
smfyj0Do0UIPPUc0dG0Gawf1ye0oJPuo4xfwu5k2SE6fJa/Tm8ofIG3pq5GJo5a5
zUp9rIzDN7BclCKi/xQyXL+adyy7Mbe9/Ww6R0jFreMA4IBcNsDHqtGqI+OwIAEr
LHmZHG3QwA/rrBl+lO8AkoW3+2ym43IQESV0qDWHKeT9LNw3ua2N2loNUjarNaom
oxjzjyCII8o7ftiVdgeYJyYnaBcQP8NiOWOjWIXG8IrJwWp3nXEkvkeQMeQ5eqSP
ZbErx/2IPgbGKpS6PrMaSKeJWdkGq7xlnb8aSOmFdpmjvH7dHvHfR2ouhts028p8
f9PP7JqnIkPDaM0VDrdS1/m2v8N7gzwvDR3B5k0YHSHl2jtZbZmifStakeC8Emzu
A5XDQVgy1BjJw99cICtbZOhNkdOQQmmoLozN4vWgU2sm2axE9SnOMXh9QGVzja0N
CBbhu+mnNi51jtrBb8pfQV2sKhxaMtNi57hEaChcQbLFENbkXkjPgYdjVc4Ybsyq
BBeklMjSeiIvc/pdux9iykReqh6VzE1MR8OdB1OTs+b91fWBBSo=
=npdH
-----END PGP SIGNATURE-----

--Sig_/bND91UWGGOh_7.dIQvYk7JE--
