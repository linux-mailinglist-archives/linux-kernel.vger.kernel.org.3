Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F584EABA5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 12:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235404AbiC2Kvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 06:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiC2Kvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 06:51:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CBE019;
        Tue, 29 Mar 2022 03:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A478161164;
        Tue, 29 Mar 2022 10:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AD4AC340ED;
        Tue, 29 Mar 2022 10:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648551007;
        bh=7ZLP9DUzWPlUi8XNl+MiJfBY6TO+lDRFlb4OqkVbP+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j3aeKPgOMMv9OvqAvV0Tx3Svpt82Xxq7kEcPvCZSQvN1s7c/lQicWX0ulWamF8MDn
         hGmkAdAvKgtMpMFH5K6USnmsvd2tV7Kd/aMSHZd+88jYs34/0qCvzIfLOVg5U/EcSI
         BJHwezlJaJlV4mTAUrbwXsp40opfssrcKg+62P0EgDvTOnwbbXUDHA6LA7I6/4KPwY
         tR0O7OQMMSRJ5m5woe+SN0OC5DVAde2jx1fVbHje9R41yQFuQl7u9INjsOIngIljr2
         tEuklk0aJAio8HtBAGJ+K75SZbLllUV7sw8IrUU+A/Ypvz8Vmfws1Z0k0BqM8+0+8i
         sR/3Ps4ukJ5fQ==
Date:   Tue, 29 Mar 2022 11:49:59 +0100
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-aspeed@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tao Ren <rentao.bupt@gmail.com>
Subject: Re: [PATCH v4 03/11] spi: spi-mem: Convert Aspeed SMC driver to
 spi-mem
Message-ID: <YkLkV2mvHJ/EyVMn@sirena.org.uk>
References: <db2f4ec0-dffb-805b-ec5a-24bf724e8ab5@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1574B9/rboLu0+nG"
Content-Disposition: inline
In-Reply-To: <db2f4ec0-dffb-805b-ec5a-24bf724e8ab5@kaod.org>
X-Cookie: Available while quantities last.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--1574B9/rboLu0+nG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 29, 2022 at 10:56:49AM +0200, C=E9dric Le Goater wrote:

> This patchset was sent a bit early and commit 7f852ec58af6 ("mtd: aspeed-=
smc:
> improve probe resilience") was applied after which conflicts with the rem=
oval
> of the aspeed-smc.c file.

> Would you prefer a rebase and resend ? on -rc2 when the tree is stabilize=
d ?

A rebase on -rc1 (assuming the change makes it in there) would be good.

--1574B9/rboLu0+nG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJC5FcACgkQJNaLcl1U
h9Brfwf/YGBbo7xm4jOlh2sAz+nAtFT+tL8ytILbSbuzuigt3u7EYOz51lPBDNM4
fy5qaOoAnw1rZHWxKoqrBRO1thIoQ444umt+kmR6QJXMNBhWFXrTiD6qbGPJY7KX
4eQi0MsHi4WLsXPdI91sHJuuWhgpvFe1adUqPKffqwTyMwCE+eTq7WB1pcbETEyP
OOj2HsPanXwIwW2hHf6IoohKlWRzb/zMCFxX/xxYYGMyHM0iW3Cy4O39xId4v47I
IKoe57VdcZwxv8kZs2Eivxz4JhXgwxBv9rVmECYMWnIPSDd39eVhRpPXnf4dIWRL
qqD5BVycLj+WHh0Cfwo8129wxzde/g==
=zub3
-----END PGP SIGNATURE-----

--1574B9/rboLu0+nG--
