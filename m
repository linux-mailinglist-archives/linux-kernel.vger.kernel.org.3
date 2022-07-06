Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C3F568778
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 13:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiGFL6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiGFL6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 07:58:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091BE28E39;
        Wed,  6 Jul 2022 04:58:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8503B81ADA;
        Wed,  6 Jul 2022 11:58:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1D5C3411C;
        Wed,  6 Jul 2022 11:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657108687;
        bh=qLDZmf82pSEzijMgkJBI7W2YEoKytRATtV3eRCBECjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikQuvgzLpPlwXXbdW2AHtdb6Kvu5+y9zCjct172Q2Pb6jgezFI/YlONUznm56Isju
         i1R+rkGSMks61MkaxnYL+taHyOZl7dEWfexYF2C2dgTjcGMYxa2WZgyE1LL7rc1GrW
         N0JDtFJgTxAxs/UBOAYYQsYeFsums3+qzj37czpL+DmGq3EvYA5EFxTqCwkseUZh95
         2lDZHswNDMZp8/Uy22zQfpx6UMGT/slwlZ494LaFatrfA87/LKtdbum0/nPi9K3no0
         Dgtr4jhXgsKjLrfkZ7ee7mny6wOTMhsnD9xyejOjF+KICbGrsXl6vP0RlNcWBDEiMD
         6SZs58wWw5rdw==
Date:   Wed, 6 Jul 2022 12:58:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     nandhini.srikandan@intel.com
Cc:     fancer.lancer@gmail.com, robh+dt@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, mgross@linux.intel.com,
        kris.pan@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com,
        mahesh.r.vaidya@intel.com, rashmi.a@intel.com
Subject: Re: [PATCH v5 1/4] spi: dw: Fix IP-core versions macro
Message-ID: <YsV4yU42in8qqQrw@sirena.org.uk>
References: <20220706042039.5763-1-nandhini.srikandan@intel.com>
 <20220706042039.5763-2-nandhini.srikandan@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NS/SuwMhgyH5tobI"
Content-Disposition: inline
In-Reply-To: <20220706042039.5763-2-nandhini.srikandan@intel.com>
X-Cookie: Only God can make random selections.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--NS/SuwMhgyH5tobI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 06, 2022 at 12:20:36PM +0800, nandhini.srikandan@intel.com wrot=
e:
> From: Nandhini Srikandan <nandhini.srikandan@intel.com>
>=20
> Fixes: 2cc8d9227bbb ("spi: dw: Introduce Synopsys IP-core versions interf=
ace")
> Signed-off-by: Nandhini Srikandan <nandhini.srikandan@intel.com>

What is the problem and how does this patch fix it?

--NS/SuwMhgyH5tobI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLFeMgACgkQJNaLcl1U
h9BpHAf9H+C6F2j6Q79hU8O50TRg5YaiK2g7Xd6QwXbY08B55VQqOGYQEqVEKHP6
j9DhIr6glSpc9yD/idZyKWQdSYh9aD+/d2mS3FBF31h2aLC+XwsunKMvX8eUJX2h
1rjsN5kL5X/rMdkxqHaFp8baHZ849tiiQNlxFoh/lzQX+1MsBhnD3IjD9oaOF4x3
SstVjtZ+zlXncT+yTIrRaApHb9eb9EKIC5DI1s4plB2TTm5/FoMyjLZgfX2qVOcM
gsKvi96pEUzU2++f7IkEv0/izlRTseVn4zvdORB6Pu4t/xhmpkwsfSYfVo9dAGTK
YTSWCwwSro52sfNJ0KdDERTQLScvLA==
=DvNR
-----END PGP SIGNATURE-----

--NS/SuwMhgyH5tobI--
