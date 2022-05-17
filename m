Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805EC52A134
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345599AbiEQMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 08:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243551AbiEQMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 08:10:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E766FB1DE;
        Tue, 17 May 2022 05:10:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8968A611E2;
        Tue, 17 May 2022 12:10:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A33C34113;
        Tue, 17 May 2022 12:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652789450;
        bh=nHhA4pOzu1gO66uH8rmEjqJYKMiCKmWA2iGxWxEzAh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyiFZXZh5Fclcw0wS4f8o+KP7G3ckIgp7jcPSon1mtuibV9m7BrlBTwDkv+km2aSt
         9tHr2WK16Y1cPB+5H57IIMq7tvXs10aXLbZEAiDmPE4GiL1FPQkcPraUjownHlN2ad
         3XuRu/T0La94a1aJNOybBi7hY++FC+t8WzJQAVJCSG3HyvwSMIwzpnhjxPQNHi6YUr
         v/p6YPFq2SHcDdSi1Xq9L5s4W04s1GSQ32eorwaqyJifiFhXp8ce4ZOqcwnV2UZ8o+
         bJVgqW84rfpJg67bEHAOQ3B8CTHbTAdWJbw36LbHgwAePOazYKfmzzdYwn8pONmiWE
         MQE3pDTaeBVuA==
Date:   Tue, 17 May 2022 13:10:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org,
        clg@kaod.org, andrew@aj.id.au, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        richard@nod.at, joel@jms.id.au, tudor.ambarus@microchip.com,
        miquel.raynal@bootlin.com, chin-ting_kuo@aspeedtech.com,
        linux-aspeed@lists.ozlabs.org, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v7 00/11] spi: spi-mem: Convert Aspeed SMC
 driver to spi-mem
Message-ID: <YoOQxJV2xNfkkwQS@sirena.org.uk>
References: <20220509175616.1089346-1-clg@kaod.org>
 <165272636363.750911.14933122170662994904.b4-ty@kernel.org>
 <20220517110509.2e6xbwot63yl6a3c@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U/J4X9YllbQQEq3h"
Content-Disposition: inline
In-Reply-To: <20220517110509.2e6xbwot63yl6a3c@ti.com>
X-Cookie: Fats Loves Madelyn.
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--U/J4X9YllbQQEq3h
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 17, 2022 at 04:35:09PM +0530, Pratyush Yadav wrote:
> On 16/05/22 07:39PM, Mark Brown wrote:
> > On Mon, 9 May 2022 19:56:05 +0200, C=E9dric Le Goater wrote:

> > [08/11] spi: aspeed: Calibrate read timings
> >         commit: eeaec1ea05c0e0f08e04c6844f20cc24a2fcc0f4

> I have repeatedly objected to this patch [0][1][2] and you have=20
> repeatedly decided to not address my objections. I won't spend any more=
=20
> time fighting it. But I will say that you should not expect any=20
> guarantees that SPI NOR or SPI NAND will not break your calibration in=20
> the future if they decide to move the dirmap_create() call around.

You =3D=3D Cedric here.  Sorry, I thought that had been addressed as there
hadn't been anything I'd noticed on the thread for a few versions.  It
does look like there was agreement that there was a problem too :/

--U/J4X9YllbQQEq3h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKDkMMACgkQJNaLcl1U
h9AxJgf/RyBtLJoz2CPMw4giFkUWm4H5/IpwJMiB3RCFF9m6e6W5o3GrJzltpG0W
CjYHYKXfSdTnouEbqcVLyvW8MaHISL+CiC0ZIqqp1iNzqs1iE0Ej+oSPQwHA8OcO
DfvyWTyRfmB7+z9YFGRbS+uaGmwwtbJ3t7WtD2o4l28D6Nz1KM2GRaYKAbSrG8UX
hiv41q0rc2uKIMD8wUZJoqvhmGk7Rguo64aYS++ZVxOvE1hwmPq0xqceRYo8nnY8
cGI1QFxoX4kszDYF8ykJ9B5FlsjVpLDvnRxIcTYgh8JdnmUtBlDFphXL825TEkV/
HUGO7UKZIjbQ2mbgXOhFXMSFN520mg==
=Cg54
-----END PGP SIGNATURE-----

--U/J4X9YllbQQEq3h--
