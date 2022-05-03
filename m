Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED325190D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243370AbiECV73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 17:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243501AbiECV7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 17:59:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ECF201B0;
        Tue,  3 May 2022 14:55:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtDKq1Tz2z4xXk;
        Wed,  4 May 2022 07:55:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651614944;
        bh=LY44pL4bHcPwg5vWXbfg1uMYPVVZjpJdXvsEqWGqKXA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Y5qxRjOuFKWiKh16ES4rDpUwictacmihSMNJUiisbMamPjVDj/0MvBMgP8GFHUSDE
         jKe4FGGN6EIWrrBAxFr25UN8JaQ4NoC2dIBA+DnW2/tv430vdTOZv7L9zy/YsMMDSn
         0OBJseIApUnFGGF5DR+nCc/eHp0bENUI6Wth4gDX3WvoFwN3khZ7V10NaQTKsOfSfT
         dw4NDgb/eGt+dPI6AWc8q7eEAtxnWnfhAt6l6qp07GwlkI5lcaMiTSizRbFmbaTMmy
         z/H2LB0/j7V3fVtwUS9GmemHASfLzxCWwAf4rX/VMOgE5FnMu1Ey+K/f1JmaiGRmtB
         lMt0IQmGZH/AQ==
Date:   Wed, 4 May 2022 07:55:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Florian Klink <flokli@flokli.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        ValdikSS <iam@valdikss.org.ru>
Subject: Re: linux-next: Signed-off-by missing for commits in the hid tree
Message-ID: <20220504075541.30c8aba1@canb.auug.org.au>
In-Reply-To: <20220503212210.mqv3kxderfxesrue@tp.flokli.de>
References: <20220503073428.219a0ed8@canb.auug.org.au>
        <20220503212210.mqv3kxderfxesrue@tp.flokli.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2v3Oa9NobykQeNRGVsQN0rs";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2v3Oa9NobykQeNRGVsQN0rs
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Florian,

On Tue, 3 May 2022 23:22:10 +0200 Florian Klink <flokli@flokli.de> wrote:
>
> On 22-05-03 07:34:28, Stephen Rothwell wrote:
> >
> >Commits
> >
> >  5c9b8fae88bc ("HID: lenovo: Add note about different report numbers")
> >  a0a5c2a69699 ("HID: lenovo: Sync Fn-lock state on button press for Com=
pact and TrackPoint II keyboards")
> >  24401f291dcc ("HID: lenovo: Add support for ThinkPad TrackPoint Keyboa=
rd II")
> >
> >are missing a Signed-off-by from their author.
> > =20
>=20
> Yes, this is "intentional"/expected. See
> https://lore.kernel.org/all/20220121124116.cj6xtxvzw7rbkcs6@tp/.
>=20
> TL;DR: ValdikSS doesn't want to use a real name, and asked someone else
> to send this over (what I did).
>=20
>  From my email linked there:
>=20
> > It seems the "real name" requirement only applies to the Signed-Off-By
> > (not Author) field, and sending a contribution provided by some other
> > person is covered by (c) in the DCO 1.1.=20

Thanks for clarifying.

--=20
Cheers,
Stephen Rothwell

--Sig_/2v3Oa9NobykQeNRGVsQN0rs
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJxpN0ACgkQAVBC80lX
0GxGGgf9EpA12x4Lr7bn1vmprWRudRHpSJ5eO/kBx/GtYQ3mX07pjHwzmoz85Wy/
Jj9urFa/cPP1A1ZkaJgEiapJQWMjTo0UNVsHGQhBkqnFhBPIWIrOIydmqEh0isxx
4ITQw6tyBADhFv0kY1UW4aq/WUll0YhRwxvmj/brmSWv6IO4NwQ4zlmISjpGlwxp
DhjdZdWjIw+vTpObn+EEaoJVe8WEk3UHBvtVXc4i6DaWSvWfUIs4nGRj9yVajCJC
fAtzcLIHzvkdxMiiUM0i3B4bH0tbz9eViYzVaOo1edPAwsGTNIY5trr2MK3G0exb
W6HMYRPjAkhh/y6+DWl53/wiaPnSmg==
=gaaf
-----END PGP SIGNATURE-----

--Sig_/2v3Oa9NobykQeNRGVsQN0rs--
