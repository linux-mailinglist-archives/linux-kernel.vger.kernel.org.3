Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132574E8C90
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 05:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbiC1DYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 23:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbiC1DYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 23:24:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08A349F8C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 20:22:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRdKc2dtWz4xNm;
        Mon, 28 Mar 2022 14:22:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648437735;
        bh=IrJfbdSVDOXMHIujPJfxgUdZ7dHjOjq/qnrc+iRN4/Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BX+jjNrhYT7Z9e7SEGqyOvP8Dtt30pxebj5K6KV60R+9U64x/9nUDne/H8LmX5ggT
         coyfUTFgP1hGO4xI74xgZtKVU1p5MqP8xWO34ynMmjKB2womXFp3bBjvPxkLpBtrQ3
         +gTQIq4i3zneOY/8fdfwauV1DI3d5CzzqWfNbzvuHUL9CCmaJfA2wEC8acylKuSwt0
         A7x37nwbkXShqrt2AiZAe8uVFQWRH409+dXUWdEFIqNzunSuX9agc35a8IXr5j3l7I
         wRTcHd2D2dvm5fPgmoeKRezxy3FR8Zd3q9Dgo6gV6+hV64yt777OTEjcbN22jni/Yu
         gekoO3NSO0PFA==
Date:   Mon, 28 Mar 2022 14:22:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexey Klimov <aklimov@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Laight <David.Laight@aculab.com>,
        Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joe Perches <joe@perches.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Nicholas Piggin <npiggin@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: Pull request for bitmap branch
Message-ID: <20220328142152.6df1b0c9@elm.ozlabs.ibm.com>
In-Reply-To: <YkEhQiJkFmCLeYy6@yury-laptop>
References: <YkEK37hEhUcl5NUU@yury-laptop>
        <20220328131756.5aa6b7aa@canb.auug.org.au>
        <YkEhQiJkFmCLeYy6@yury-laptop>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/61Hjm_LScE7t9JHzI7oPi8R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/61Hjm_LScE7t9JHzI7oPi8R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Yury,

On Sun, 27 Mar 2022 19:45:22 -0700 Yury Norov <yury.norov@gmail.com> wrote:
>
> On Mon, Mar 28, 2022 at 01:17:56PM +1100, Stephen Rothwell wrote:
> > Hi Yury,
> >=20
> > On Sun, 27 Mar 2022 18:09:51 -0700 Yury Norov <yury.norov@gmail.com> wr=
ote: =20
> > >
> > > Can you please pull this branch for linux-next?
> > > https://github.com/norov/linux/tree/bitmap =20
> >=20
> > Normally, I don't add new branches to linux-next during the merge
> > window.  An exception is for branches that only contain changes meant
> > to be merged by Linus during the current merge window.  Even then, this
> > is very late to the table :-( =20
>=20
> OK. I'll send a reminder when the window will be closed.

Thanks, that would be good.

> Rebasing this series from 5.17 to origin/master causes a couple merge
> conflicts, so I decided to simplify your work.
>=20
> Are you OK if I rebase it on 5.18-rc1 when it will be created and send
> new request?

Sure, but please redo your testing after rebasing.

--=20
Cheers,
Stephen Rothwell

--Sig_/61Hjm_LScE7t9JHzI7oPi8R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJBKeMACgkQAVBC80lX
0GzZSwf/USYjYGv1XY1urEgfolIvpfrYEVvqGaIVp8AvL9YvppigqZrDGyiNt6p3
bmOJsk2JHYMCtQEU1kVvm8R6Ko6FxU0WFBj12ET7TeiWCaalJm4HUgYvLDRD+10r
iWQc/1Yvp6HcM+4MS/8dd6A4NMt4t8NSMVFgT8MsqtE9LnqexCThF8GDZvN02UEl
qzghWF2RtNnkjW3XjCiP5kGqjVec2LsWU/4cP3ulB7h/GCIc46GwRYBAcs27gXuf
1Kg9PpasNinjaToO0xnOn4cb0L0OiDGU/1XJwfPtiKFzjLN+Lt79O4rB3O/9sYr+
7TvB6y9omR9K+crDLKs/Dg9P++xZLQ==
=ph5e
-----END PGP SIGNATURE-----

--Sig_/61Hjm_LScE7t9JHzI7oPi8R--
