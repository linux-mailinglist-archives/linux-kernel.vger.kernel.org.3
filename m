Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601374B5085
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353452AbiBNMpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:45:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbiBNMpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:45:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B90249279;
        Mon, 14 Feb 2022 04:45:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCE86612ED;
        Mon, 14 Feb 2022 12:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE8FC340E9;
        Mon, 14 Feb 2022 12:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644842707;
        bh=bENJeR+x1hewo5SXEkg+eU+QMy/o0kQuzxn92Tj+Ujw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8pAhfWRRefHvlTSDWZG9jvZTKBtI4xxE8U8KgO8TaE+/DwDGNQ6OyuzN4aZ/N3h5
         RabIOFejGpLEfDRLzZX86oFQbFXUs/KNt/vU50PPbDsV0sv+ApF/JinHIiX10RnzCB
         0slZoVl/60QOq7wNvbumH+36N1+ap2y4Ad2PkBd7XGHAxFqKZeTW9Nef1yw7Mm+XdA
         1v1RUtOYZwUWnm4JN8a4lDPBuSr4p4gMdRhudNommhULBV/c2GG7+f+JZIhmv1v4UU
         5L8ylnYtiOMCLaDDqUpPMvMPfhvEqowqqShTuQONVaJ+sNzbCLzDe2s2D/16pwZsqM
         I7Ieepq5K5ZRA==
Date:   Mon, 14 Feb 2022 12:45:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yun Zhou <yun.zhou@windriver.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Xue, Ying" <Ying.Xue@windriver.com>
Subject: Re: =?utf-8?B?5Zue5aSN?= =?utf-8?Q?=3A?= [PATCH] spi: disable
 chipselect after complete transfer
Message-ID: <YgpOzw2rq+vAIPBU@sirena.org.uk>
References: <SN6PR11MB3008AF5619B0B026836FD7429F2F9@SN6PR11MB3008.namprd11.prod.outlook.com>
 <YgU1+cIlANAkJCAL@sirena.org.uk>
 <19c69765-8584-2e6b-25b8-7053a5afa5d4@windriver.com>
 <YgVH310gQ1sK6dlr@sirena.org.uk>
 <a5aa6dcf-e3dd-e8ff-edcb-edad96f8ddfe@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wRPnpe16ZvnyZi7u"
Content-Disposition: inline
In-Reply-To: <a5aa6dcf-e3dd-e8ff-edcb-edad96f8ddfe@windriver.com>
X-Cookie: Am I in GRADUATE SCHOOL yet?
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRPnpe16ZvnyZi7u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 08:35:33PM +0800, Yun Zhou wrote:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> The focus of our differences is what the role of cs_change is.
> I think the direct effect of cs_change is to change CS to inactive.

During a message.  At the end of the message it does the opposite.

> I also investigated the role of cs_change in several drivers, the result =
is
> similar, e.g. spi-mpc52xx-psc.c, spi-fsl-spi.c, spi-bcm63xx.c,
> spi-mpc52xx.c, etc.

Individual drivers may not respect chip select at all, never mind in
this specific way - in general any driver actively managing chip select
is going to be unable to implement the full semnatics of cs_change,
possibly even most of the semantics of cs_change, due to hardware
limiations.  If a driver has full control over chip select it'll
normally be able to implement a set_cs() operation and just use the core
handling.

> To sum up, there is no indication and no requirement that when cs_change =
is
> true, we need to keep chipselect active.
>=20
> I hope you can seriously consider my analysis. If what I said is wrong,
> please
> correct it.

 * All SPI transfers start with the relevant chipselect active.  Normally
 * it stays selected until after the last transfer in a message.  Drivers
 * can affect the chipselect signal using cs_change.
 *
 * (i) If the transfer isn't the last one in the message, this flag is
 * used to make the chipselect briefly go inactive in the middle of the
 * message.  Toggling chipselect in this way may be needed to terminate
 * a chip command, letting a single spi_message perform all of group of
 * chip transactions together.
 *
 * (ii) When the transfer is the last one in the message, the chip may
 * stay selected until the next transfer.  On multi-device SPI busses
 * with nothing blocking messages going to other devices, this is just
 * a performance hint; starting a message to another device deselects
 * this one.  But in other cases, this can be used to ensure correctness.
 * Some devices need protocol transactions to be built from a series of
 * spi_message submissions, where the content of one message is determined
 * by the results of previous messages and where the whole transaction
 * ends when the chipselect goes intactive.

especially (ii).

--wRPnpe16ZvnyZi7u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKTs4ACgkQJNaLcl1U
h9Ajtgf/WhAK57FjMjFqtGO9eYw8mP9uee3W7G1rmQTIHI9B/WsSQY5PwGdGiudw
cDcAN8vF3xnSEAfnIo+weGQkZJjwfwYgB2LHF7dBlp1Tj44+JGsGY9gGXxf0+iOn
IWW6cznDeMuX+y/Hqvlh/pcwNUn3qgT44utItVBzZH97zgGFyWZIW3JUVSn+PPR4
KNOqQPEfpj4ujZIK8MDadTyg9APQNrURZyadus/WjeLZs935Eu0ISVvy99wSdTRh
F40yO0nKKdu1TqfVVcDRacaRUg2/XpPnZ/lf+MMOrDMTf3N+9ACeS5vIeXxK0WEk
sAD5sdDgZcdqdKeTrhLxkUTCKH/eXQ==
=K+20
-----END PGP SIGNATURE-----

--wRPnpe16ZvnyZi7u--
