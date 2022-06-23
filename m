Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83065579FB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiFWMGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiFWMGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:06:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37EF54CD74;
        Thu, 23 Jun 2022 05:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4EFA61B2A;
        Thu, 23 Jun 2022 12:06:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EBAC3411B;
        Thu, 23 Jun 2022 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655986004;
        bh=prkXv/FDwz/GNUNq4CHR2FoAxl/6BZb1iYEJL1xkbaE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BFnXBFdhJh1lEppnNulL0vqhHWZWx3C8ZD67sU1TgrAwaYtOH4/87ZNE3kfl6RhGY
         VprvQ0XT8HPsHF/VKWzTXJ3s6oquywH0ZdvixsR30Exe3b3QkNLud0IilTZLokMLI+
         0a19osOwz6YrhaCp5r+2yJX/4eNELQIosHptPcP5RddDIrRBywULlaufWQUIK+E+83
         du/wLbirZfbF6ACqL0YrxqvEcdIHToOL1uloveFoRRLCT4+TTMRwpwKCNNS6s6ceWg
         rwcFLM+ve6t0AR/d4fCFB4r0JK6cdnmyX1j0lYaT+9NHLKtdZDP2zCnQaVJqNUvP90
         /gkdWTIiOvzAQ==
Date:   Thu, 23 Jun 2022 13:06:38 +0100
From:   Mark Brown <broonie@kernel.org>
To:     "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
Cc:     Amit Kumar Mahapatra <amit.kumar-mahapatra@xilinx.com>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "git@xilinx.com" <git@xilinx.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael@walle.cc" <michael@walle.cc>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [RFC PATCH 1/2] spi: Add multiple CS support for a single SPI
 device
Message-ID: <YrRXTrYN3BuShbzg@sirena.org.uk>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
 <DM6PR12MB2809F6C7D80B60556218D627DCB59@DM6PR12MB2809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GX1MXlGRjMnY7i3+"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB2809F6C7D80B60556218D627DCB59@DM6PR12MB2809.namprd12.prod.outlook.com>
X-Cookie: I had pancake makeup for brunch!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GX1MXlGRjMnY7i3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2022 at 11:39:19AM +0000, Mahapatra, Amit Kumar wrote:

> > >  	/* Mode (clock phase/polarity/etc.) */
> > >  	if (of_property_read_bool(nc, "spi-cpha"))

> > This is changing the DT binding but doesn't have any updates to the bin=
ding
> > document.  The binding code also doesn't validate that we don't have too
> > many chip selects.

> The following updates are done in the binding documents for adding multip=
le
> CS support:
> In jedec,spi-nor.yaml file " maxItems " of the "reg" DT property has been=
=20
> updated to accommodate two CS per SPI device. =20

This is a change to a binding for a specific driver, this is changing
the SPI core.

> > I'm also not seeing anything here that checks that the driver supports
> > multiple chip selects - it seems like something that's going to cause i=
ssues
> > and we should probably have something to handle that situation.

> In my approach the chip select member (chip_select) of the spi_device str=
ucture=20
> is changed to an array (chip_select[2]). This array is used to store the =
CS values=20
> coming from the "reg" DT property.=20
> In case of multiple chip selects  spi->chip_slect[0] will hold CS0 value =
&=20
> spi->chip_select[1] wil hold CS1 value.
> In case of single chip select the spi->chip_select[0] will hold the chip =
select value.

That doesn't address the issue, the issue is checking that the driver
can support multiple chip selects.

--GX1MXlGRjMnY7i3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK0V00ACgkQJNaLcl1U
h9AeAgf9E2LUCkDCU4E/2lFo/mvDwRRmJroZIW6fnmZOrL88syRRlTBEw96cjlS2
cgtKnuJ8e5/r4IMyfvsZJHClZeZS21E1T0gXmiwtc1XuU7IVYVXQwo2ym0ifW0TU
+9pQUS+jkxcAbrSW2b6JnvwS9vHL+8XM9SgJdI53BjPqiwU2S0PJH3S+Cgfk8JYU
/KRGRLoSSn6sKLxosXks+8wzQ9hLuEOWo/RuqPAhL7vsqU7CON4YYnljmdY4cjlW
QgGEvIjq7CmOJ/Z8gPm84gA2Fr8Z7B1c8CfqRr2CxGUCSWa03xHKyGu5PcYrUdRy
42MCtduzSpT5hAJ3WXITBE2g0LGQng==
=2Knv
-----END PGP SIGNATURE-----

--GX1MXlGRjMnY7i3+--
