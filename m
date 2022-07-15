Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDB35764C5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 17:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiGOPyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 11:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGOPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 11:54:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991E261D5C;
        Fri, 15 Jul 2022 08:54:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35A0962135;
        Fri, 15 Jul 2022 15:54:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4EBC34115;
        Fri, 15 Jul 2022 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657900456;
        bh=5daCr9QK24Hj+RUwhhq6jII9Hqcph8xnR3ZzTxWqL1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYpNxXxCNO7Q/dPoOq3aAeCPsQ3Az8oDxckCVf2lTsgFb1OwUbsRgPl7L32GEa4YC
         9t8kbfwtOxmJGEVdh7pR6jQjjBzEamEfqblSQtxndBRnmhX+emy6GsfUAjk7BavTEp
         ooh+TU5bskMLvEd2hQwsBkvqG0pkqbGkJ/hb8CyRagp+RHHonYcGJMbAfpymKp3zV7
         TDntmKYo0lSQoD62KovtiMX8SD2u1uI+29K3PYjaAM3ZwrsRWvaZbY+jAWW8nOGm60
         AgCOZb9EOmrR702cJ8fKuW+WKT0lVV6A4hnImGxj/qyI5hA6dhoI8fgmUbPlxmMiiu
         AZAHUibkIm5Hg==
Date:   Fri, 15 Jul 2022 16:54:05 +0100
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
Message-ID: <YtGNnT2cP5HIayp3@sirena.org.uk>
References: <20220606112607.20800-1-amit.kumar-mahapatra@xilinx.com>
 <20220606112607.20800-2-amit.kumar-mahapatra@xilinx.com>
 <YqHfccvhy7e5Bc6m@sirena.org.uk>
 <DM6PR12MB2809F6C7D80B60556218D627DCB59@DM6PR12MB2809.namprd12.prod.outlook.com>
 <YrRXTrYN3BuShbzg@sirena.org.uk>
 <DM6PR12MB28091BEB013B6F1903B5CDE3DC8B9@DM6PR12MB2809.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WLnYk1lIzSJ4ADtF"
Content-Disposition: inline
In-Reply-To: <DM6PR12MB28091BEB013B6F1903B5CDE3DC8B9@DM6PR12MB2809.namprd12.prod.outlook.com>
X-Cookie: You dialed 5483.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WLnYk1lIzSJ4ADtF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 15, 2022 at 03:35:49PM +0000, Mahapatra, Amit Kumar wrote:

> > That doesn't address the issue, the issue is checking that the driver c=
an
> > support multiple chip selects.

> To address this issue, in spi core we will check the number of items=20
> in the "reg" property of the flash node(which is nothing but the=20
> number of chip selects) against the "num-cs" property of the spi=20
> controller(which is total number of chip selects supported by the=20
> controller). If the number of items mentioned in the "reg" property=20
> is greater than "num-cs" value then we error out.

> For eg.,

> rc =3D of_property_read_variable_u32_array(nc, "reg", &cs[0], 1,=20
> 						SPI_CS_CNT_MAX);
> if(rc > ctlr->num_chipselect) {
> 	dev_err(&ctlr->dev, "%pOF has invalid 'reg' property (%d)\n",=20
> 							nc, rc);
> 	return -EINVAL;
> }

This would check that the controller has at least the number of chip
selects specified but it would not check that the controller is actually
capable of using more than one chip select at once.  We should be
validating both that the chip selects are available and that the
controller can do something useful with them (and probably have an
implementation in the core for doing so via GPIO).

--WLnYk1lIzSJ4ADtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLRjZ0ACgkQJNaLcl1U
h9DvNgf8CXWe2TL7deZzQsKFmwm4r44oFp98ORLdX9fjwHjXyvyWACyJHEKdf/DO
Tpngc2qCEoBpumurCNRrB8sUI7w6GoikYd0Q25+u6ggKF1Qr5bgkPr+jWVyEx9PY
XoJDU5nqv7GTLDkc88KG1pf3yyebiJfkyG1ZckcE0Gi7CMtVjTbPTJ9D+wFptMQM
FiHctGpxjWx6GNDefyyO7Rdc7f0brEiDy5WoRoLGRlF2RoKGOEUtjtPBNkoFQVSl
ldtIrzip4BxzLTfeDayqEyi2MRHqYlpYCH6gtlMVsRGwNq2fNejEa3KhSo4evar3
vql8mcvRgsrJgTDzC/aBH1VojkTC0A==
=AAV5
-----END PGP SIGNATURE-----

--WLnYk1lIzSJ4ADtF--
