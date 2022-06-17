Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259B354F441
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 11:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiFQJ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 05:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiFQJ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 05:28:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B68D62CE2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655458097;
        bh=lxm3FN8DBM/LQtAAtZ4qd37cIBuRAbivab/rs+t/ymE=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=ZlqpuQJAolicMh3LZlgrPD6chXcZthFRCP5qGBAgODb7giVx8rvPats3h73/cgqDG
         TvfqXndH5gYbgFqzdvMerrvcTUfM8Tnu3DI9CP4lHzL4GAPRBsBCnVustVTuzW4P98
         Cs6x/keV9kaQO9EcGwJt2HqYYznZDw51pkWbtKrM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.195.3]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MwfWU-1nnMbr2fkY-00yAum; Fri, 17
 Jun 2022 11:28:17 +0200
Date:   Fri, 17 Jun 2022 11:28:14 +0200
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Joel Stanley <joel@jms.id.au>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Hector Martin <marcan@marcan.st>,
        Conor Dooley <conor.dooley@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Heiko Stuebner <heiko@sntech.de>,
        Brian Norris <briannorris@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] soc: nuvoton: Add SoC info driver for WPCM450
Message-ID: <YqxJLhkCQ2WcHdAp@latitude>
References: <20220609213513.88479-1-j.neuschaefer@gmx.net>
 <CAK8P3a0-m1iQ2bP+dsoGTPZGMNBKqB5a6315jdgaT3tuR4WfTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jKjRAf+U0chs2ccJ"
Content-Disposition: inline
In-Reply-To: <CAK8P3a0-m1iQ2bP+dsoGTPZGMNBKqB5a6315jdgaT3tuR4WfTw@mail.gmail.com>
X-Provags-ID: V03:K1:AbjFIQKAkPkfwuEeVxt0fDYDtem8sVSjnt2fM1vuQjcZZXp7GEi
 J8SjMxC5qB6gXxWXqb59WqaGeGFHk3xwNQ27Bs6TaPBrxPfk3HXw8NdgPgUcAnhAOdmo1NR
 9yjvHT5JUm8NI4HsBrCehSqvKk7SOQ4xLTj52/WBFgJrjfeUlR29yfTcilD3GUt4T1mXMbV
 NbWeUSzgihFBMwoYu8muA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5d/Y/aZVbeU=:ADtktXYRoO7EKquC0v3A9k
 uuoI6bKXECBeHvo0MertvMpAWl7dO6GEJM5B9WjORcl79+Fa60x4M78+3vJcykHrWqaQVWzz4
 70L4UD7Sh+wV1lAldnh8kk9T7X4qGrjCFkaJBqq3Yo/Kk6DkVL0NBcyNoufhx0aP1t2c+e5Z8
 hx63anC7e1SmJ7hq1NFAimKT4pQuo8MBoO6+HjAdny/0hgBz7NjFkAQ13vOUNvENYswqC4OmL
 6c/Qo4Tt773H+UJLe8EUurz73by1y1Z9VAtKljZbg61FxXEVz6qD7YmCo00AoMGDvGQc5YwfL
 Y9QfcXXSnkk6U/ZNwfFIJGF5+gfnLnKbH3NrUpz0L6n95XoMPIxq3AKNQyPgMvSaA2aGBqhfH
 pnOD3NgUGdgejkxRfeNBFODqnhnO5nJ2i/GGjkE9adQupqwOm5bF1mO7lDhZaMamhGfA8HRaM
 Ljz+jqVW4QhVr3Dbc2piGWn7JGRcvL+Llnv6pZJII6lI4dew+vQ2zhbK2ijzaLPpm8sdcNoYx
 My41ZkUzvHvQqxSGASyBMsk36QK3oKAt4WVTRlTPSjk+eQaH391kgyMgaMw7QDydhlGl7Y5JN
 nGf25AYZcbi2UPN/Qf/fHNyHmil0uORW5LfhhKiUN6i6A29USrRDd0n0XHm375Rf2vqoUTp8Y
 0H1DBYMOiSJMRjFDabOLTovGWiuQHy6rKuJE/Smk6BqK3VmxhlQIM9MBXCz+n9aSSRUuJ5Trw
 G11bEk2kfQ02EiVfdnhVV5ccXUKzWyTkQXlyxvvyPu3sMg+AswciocoeoRbITlX7xUa3rO8q2
 /PoUqeWV75GhXlHQWr6ywr5zWlxzUTkqoKnf1x7obnC11KPRBUWT2zXujlyIFS+F+xJBR5QJm
 IRIK7h0fI0qZf/VZsQkiqRRHsNYcs/D9RnRJx1jGxZVIo6Sg/8q8NOJ4YJklyr5yUQtns6O/e
 e6i0D/fU40s3qyZrIGYeCmm6qGVFgi0GuZ/4Y27sbXxfwCWmHq4Q/kNTNaXnf2vf2qQOJvhrA
 QvYmcD5pODJXqvMpJLNkW2aNeXErv7ZZLllRX+OVvLc/fFfnpi/f2C85GaLw+2hviEmz/pS/c
 mCzGX4fIxbNCzfpKUJ0M1cCA1QLqj93LR0a6gl2onXZVQqbu4TYc3DFjQ==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jKjRAf+U0chs2ccJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2022 at 04:00:17PM +0200, Arnd Bergmann wrote:
> On Thu, Jun 9, 2022 at 11:35 PM Jonathan Neusch=C3=A4fer
> <j.neuschaefer@gmx.net> wrote:
> >
> > Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
> > information such as the SoC revision.
> >
> > Usage example:
> >
> >   # grep . /sys/devices/soc0/*
> >   /sys/devices/soc0/family:Nuvoton NPCM
> >   /sys/devices/soc0/revision:A3
> >   /sys/devices/soc0/soc_id:WPCM450
> >
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
>=20
> Looks good overall.
>=20
> > +menuconfig WPCM450_SOC
> > +       bool "Nuvoton WPCM450 SoC driver"
> > +       default y if ARCH_WPCM450
>=20
> It would be nice to make this a tristate option, as we generally
> like to keep optional drivers out of the allmodconfig vmlinux file,
> even if this is a tiny one.

Ok.

> Just add the trivial cleanup function and MODULE_LICENSE() etc tags.

The right thing to do seems to be to unregister the SoC device in the
cleanup function. Is that what you mean?


Jonathan

--jKjRAf+U0chs2ccJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAmKsSQoACgkQCDBEmo7z
X9v7ag//ULZktidbg2z7RnwVy6ePYuuYsXSdl2wtC3kdzVwdJwgt+0M/BezrQ1/6
lHXqtAcjtyaRtAJ5yw8fRtCEx9zdz1jL0bdgFA6CxcaHPP9Nr9NHTOSWNevFIg4w
7lj6RvlbkLie8799JAmgZDVQBzsMByQaZueA2dXcFddaANmqGTQP0RdKu2SqF1eR
IJEq78QnqjguDz+wLrnqcU4j+WWVTmZw6VCUImmQvur1X9wmJ9CvikZt0GCMhmw/
7QjTpAMGrGl/iN+b9OZrdtytbHj+YsNBlZGuTFoPLtN6hItyxb1ISLaiEKRVCVtQ
egswr9lXGrMqwK9A7435DdcmrWoYdQ/7VlbXSVwbDYNsPjZRbAy7rGsWXOsiM1fA
RPbYmoxxi2ZrLeINT900xtXHovtRM4ICWbj5uJPdLJu/IJNvRfYmYlJKisnr+xU1
RGp+97USsPZTn3pnqEKH7nAkLV3zO7LPXWsaDRAvhn1a9E5KTrKhg/yqWj6RTMOJ
trsl9UB8kKeekcP8Z3/DAjF9g8H7dR5pnpmLXSRMVBH3L08P22Ot8S8BTmELpt+F
yAZenVbFBhnVQ3huJTd6QTzAvW+q3DxCR+1eE+PYJzghYfcae1jDl8hm9zFfbn3d
rw0B0QUEf9m3aXP+lZlOrZfNKEgpQWG4napZVoPxvGtlkUV6u9M=
=8EJF
-----END PGP SIGNATURE-----

--jKjRAf+U0chs2ccJ--
