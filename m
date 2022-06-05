Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1209453DEF3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 01:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351808AbiFEXdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242272AbiFEXdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 19:33:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A191A26AD9;
        Sun,  5 Jun 2022 16:33:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LGXwv5WLRz4xD8;
        Mon,  6 Jun 2022 09:33:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654471984;
        bh=JPHMTeH21eKoR6W4I7iPxQFNUAWKvjAR0yL1d7vOOzE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BLYut8s6Ay2afK9HjI3jMOJoi8G7H6A/e4GZLwnFwJ10qGpchdtkW2PTUmdld6tv2
         jpDlZrCvHR5VIUuFiBCMhDi/NERnXPZxdxlOsIrwUFLaqGsy8nwriO3iSMaLMmozCI
         +uQpZcsUD+1YlC9Sni8S+A9y43OZI+VoRlNG3QF+sgUWb0D/5MvETPml1PHqqha38V
         NaIPUmqgE5hXtbg4WlGKE10Usy4wwMKv8yDPAAto8yzEwlr/sECt0+AoIINupN7zJC
         qqVLYn3KZRrn84Kl9CxU347+VlsFjAlt19ZY+MxCCZEtBPhtoJnUeCPfyHBD6WRw/3
         dHvsW+9Y5DTEg==
Date:   Mon, 6 Jun 2022 09:33:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the pinctrl tree
Message-ID: <20220606093302.21febee3@canb.auug.org.au>
In-Reply-To: <20220318183101.16b8d056@canb.auug.org.au>
References: <20211027220118.71a229ab@canb.auug.org.au>
        <874k92bu4q.wl-maz@kernel.org>
        <20211028080331.6d199082@sal.lan>
        <20220120142539.6d1fac12@canb.auug.org.au>
        <20220318183101.16b8d056@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/j/Z+F3kNQCDQiZbzMTn7/sf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/j/Z+F3kNQCDQiZbzMTn7/sf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 18 Mar 2022 18:31:01 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Thu, 20 Jan 2022 14:25:39 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > On Thu, 28 Oct 2021 08:03:31 +0100 Mauro Carvalho Chehab <mchehab@kerne=
l.org> wrote: =20
> > >
> > > Em Wed, 27 Oct 2021 12:10:45 +0100
> > > Marc Zyngier <maz@kernel.org> escreveu:
> > >    =20
> > > > On Wed, 27 Oct 2021 12:01:18 +0100, Stephen Rothwell <sfr@canb.auug=
.org.au> wrote:     =20
> > > > >=20
> > > > > After merging the pinctrl tree, today's linux-next build (htmldoc=
s)
> > > > > produced this warning:
> > > > >=20
> > > > > include/linux/gpio/driver.h:284: warning: Function parameter or m=
ember 'parent_handler_data_array' not described in 'gpio_irq_chip'
> > > > >=20
> > > > > Introduced by commit
> > > > >=20
> > > > >   cfe6807d82e9 ("gpio: Allow per-parent interrupt data")
> > > > >=20
> > > > > But may actually be a problem with the tool :-(       =20
> > > >=20
> > > > I guess the tool doesn't like having two fields that are part of a
> > > > union documented together... Happy to tweak it if someone tells me =
how
> > > > this should be written.     =20
> > >=20
> > > Yes, that's the case. See, when you do:
> > >=20
> > > 	/**
> > > 	 * @parent_handler_data:
> > > 	 * @parent_handler_data_array:
> > > 	 *
> > > 	 * Data associated, and passed to, the handler for the parent
> > > 	 * interrupt. Can either be a single pointer if @per_parent_data
> > > 	 * is false, or an array of @num_parents pointers otherwise.  If
> > > 	 * @per_parent_data is true, @parent_handler_data_array cannot be
> > > 	 * NULL.
> > > 	 */
> > > 	union {
> > > 		void *parent_handler_data;
> > > 		void **parent_handler_data_array;
> > > 	};
> > >=20
> > > The tool will understand it as an undocumented "parent_handler_data" =
and
> > > a documented "parent_handler_data_array".
> > >=20
> > > It has to do that, as otherwise it won't get cases where people just =
adds a
> > > @foo: as a template but actually forgets to fill it.
> > >=20
> > > The solution would be to add a description for both, e. g. something
> > > similar to:
> > >=20
> > > 	/**
> > > 	 * @parent_handler_data:
> > > 	 *
> > > 	 * If @per_parent_data is false, contains a single pointer=20
> > > 	 * with the data associated, and passed to, the handler for the=20
> > > 	 * parent interrupt.
> > > 	 *
> > > 	 * @parent_handler_data_array:
> > > 	 *
> > > 	 * If @per_parent_data is true, it should contain an array of=20
> > > 	 * @num_parents pointers with the data associated, and passed to,
> > > 	 * the handler for the parent interrupt. Cannot be NULL.
> > > 	 */   =20
> >=20
> > I am still getting this warning. =20
>=20
> I am still getting this warning.

I am still getting this warning.

--=20
Cheers,
Stephen Rothwell

--Sig_/j/Z+F3kNQCDQiZbzMTn7/sf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKdPS4ACgkQAVBC80lX
0GwGjQf/Wpxw16OGellQTN1Pi7+LZv4dT0ZGhL2c5FwQJxKYcGMyrljxCvU5pWot
xzunVUcaed1twyrAZw6hEmWPobS1tBuXcSwGUZAKQmH/zS5obZZ9B534qHTXkSDg
mIvx/xi9EW//ZG51tzbE214iSnD9S01ZJQw5PRm5s621/QAfPGFyHmEskAAx5S0p
xohvRT3l1Q35PJLeFHovPFIQSmbTCV6SObtUWxAJNpnh+x94uI2nCq1z2CXWtB2p
2rUmyCB7XLSsr5LI9pLu8dVpeCGfrnaakKploIhymAsQ07ZDSv7ZwoWu/Ig8/NHa
d6UKuIDmpHzxowhNHlBP+GfOs1xu/g==
=9smW
-----END PGP SIGNATURE-----

--Sig_/j/Z+F3kNQCDQiZbzMTn7/sf--
