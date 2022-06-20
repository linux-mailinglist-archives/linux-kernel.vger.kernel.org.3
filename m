Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5158551FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242719AbiFTPKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 11:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242897AbiFTPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:09:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFF62497A;
        Mon, 20 Jun 2022 07:56:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91BAEB811D5;
        Mon, 20 Jun 2022 14:56:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01640C3411B;
        Mon, 20 Jun 2022 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655736998;
        bh=iuHCJsCWRrFc8xRE1pPf353DnYJkGMJluzCFMW+Nr6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Maa4UXxTdt3KZpgrG3Bdx+W/MPuQawr5e4TNJJ861YViGUrJ0N5wel/7n6wsgIZ+g
         tyve74E9CTe/JKawsgozk5sAZfqVl+m9dsj9540Z2Pk9PYPSs5N96jM6yw/0Pe+5up
         OuZUE3yFNLH9+2PHOOjek94zMLsKyEejQEJyNFhwBOArVeI2YsY3FtieoN0W3VlY/Q
         t21P/3MIqx2FNfrkU7U/0+x90M3A4gAXtFQBemeNpRHXWUzOhzCfDvmM+OqmEYu7m5
         XuoHD19cmutNfSdAPAdklL31pj7efFk1CWj0YORIyMzkVpwMpBAgpkThMdut9k67m7
         30DSA9rk+tzYQ==
Date:   Mon, 20 Jun 2022 15:56:31 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierluigi Passaro <pierluigi.p@variscite.com>
Cc:     Alifer Willians de Moraes <alifer.m@variscite.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Eran Matityahu <eran.m@variscite.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "nicoleotsuka@gmail.com" <nicoleotsuka@gmail.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>
Subject: Re: [PATCH 4/4] ASoC: wm8904: add DMIC support
Message-ID: <YrCKn6UgvdwOQqAu@sirena.org.uk>
References: <AM6PR08MB437614D88A0F44746C2B88BAFFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AbQUs8uU3Zo5uRnw"
Content-Disposition: inline
In-Reply-To: <AM6PR08MB437614D88A0F44746C2B88BAFFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
X-Cookie: Good day to avoid cops.  Crawl to work.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQUs8uU3Zo5uRnw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 20, 2022 at 02:49:51PM +0000, Pierluigi Passaro wrote:

> > > +static const char *cin_text[] =3D {
> > > +=A0=A0=A0=A0 "ADC", "DMIC"
> > > +};

> > > +static SOC_ENUM_SINGLE_DECL(cin_enum,
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 WM8904_DIGITAL_MICROPHONE_0, 12, cin_text);

> > Why would this be runtime selectable?=A0 I'd expect the decision to use
> > an analogue or digital microphone to be made in the hardware design.

> I agree that dedicated HW is required, but currently SW side there's no s=
upport at all.
> This patch is aiming to provide a way to enable DMIC on boards using it.
> Is this supposed to be managed in a different way ?

Via firmware description.

--AbQUs8uU3Zo5uRnw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKwip4ACgkQJNaLcl1U
h9COyQf/e1DSNnLS5C1cVLwYjiESEN2bZYjPBZvXZ/Nil+AvbRsE6mebr8M1RLAW
2Hhd0EnevkPtZygo8C0zz92XHbocSuNy15oYDIhYb7M3cG7VEOhqK8i2izZcs7CY
pR4TpxfAncFHht0NaOPWauJOlapDytWDmSNKtmi0Y1EXbJi86winalwy//S7Q3nO
Q/87q+YM253/joHhJK/cHMbz6ONqF1VodXrPX3SIJC40T3hW3mSqeNV/UFWkejdG
ROH4DIdG6ydfG+Kiwsy6aAVVr9Fg2XqkoEQPZzHUv3Laujd6U2Z3HgRI4eDgsOJC
hBOpo+Aw3wIT6Hjw5v4VY2YpcsD0YQ==
=elfJ
-----END PGP SIGNATURE-----

--AbQUs8uU3Zo5uRnw--
