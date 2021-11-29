Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67138462522
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233751AbhK2Wfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhK2We6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:34:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D2CC03AA1C;
        Mon, 29 Nov 2021 10:15:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C0EC1CE13AB;
        Mon, 29 Nov 2021 18:15:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6452EC53FAD;
        Mon, 29 Nov 2021 18:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638209755;
        bh=4ZvxN/3yB6BIkS5mjsWCkybDGiWY3Py98ZFJY+s6Vj4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E3PEpP+W+hDsvuPyeAajJimQVmbwxj2vGUyUBwsK5ThTOCuv+YHmnBNMyLUG7G8rF
         5o01BTshaoBe4BVtxyMikV3YpDda7S2O7n4eJe7DEADKrRJkrc8hg8g9lx+h5AYnRp
         JtJNrW2SfymVAqN0xI4bM+fie8mRqdne78USgugV5E5JwVWJT5abjwphwrAcmT+OwE
         ZL4CZ2ydWXwx6fSODO6V6qeQ5ytH7zXy7etv/RfSxAqg3b2nnPSHcxLwwyF2ldGQPJ
         0pgUSn0IkJKU1xSBqlha2PjmY6Uigr9n+kpysW/wNU5DBimNjt+01icl/evZTh+Ifd
         D9pEACPTwiJdg==
Date:   Mon, 29 Nov 2021 18:15:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Add bindings for peripheral-specific SPI
 controller properties
Message-ID: <YaUY1gKnyoOEvo/M@sirena.org.uk>
References: <20211109181911.2251-1-p.yadav@ti.com>
 <20211129180935.nmymboy336hllly7@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qhLQH2s+5hgBKos4"
Content-Disposition: inline
In-Reply-To: <20211129180935.nmymboy336hllly7@ti.com>
X-Cookie: Thank god!! ... It's HENNY YOUNGMAN!!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qhLQH2s+5hgBKos4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 29, 2021 at 11:39:35PM +0530, Pratyush Yadav wrote:
> On 09/11/21 11:49PM, Pratyush Yadav wrote:

> > This is the best approach that I came up with with my limited knowledge
> > of JSON schema. It has some limitations that are mentioned in patch 1. I
> > don't know of any better ways to model this. Suggestions are welcome!

> Do you plan to take this series through your tree or should I poke Mark=
=20
> about it?

I'd expect to take it through my tree but please allow a reasonable time
for reviews...

--qhLQH2s+5hgBKos4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGlGNUACgkQJNaLcl1U
h9BdUAf8CPx2aYIuPUWc4Ka8OhpPDQXy+JJkgrtPsqFeOqDqSk2dwAUHat/zea2+
GJatBwnEcSdBPtjJ9Lhu7MOI+Lj4255qllxHtem4dr4HtKUhFPFzxrlfaHpZ7b6g
g3ilAzVvilA/svq+UldUzrI2X0x4eJx9vfb5DU57IJV55iYzKokCLUfcUxXPwGWi
LXNwGOX8Gd8I+o9bnEUeAakeac+UEl0jwfyzea9wQb7+9QovJAFt0EfxnZ5aXXSL
9Mg90x6V6YzzL06tntkPs4FNF7N5QrS+Lnb3temdqn21Wr3ezdCuf9wHwizXzyCz
SA+x9BeNFM4Z6o72ym0004LMiYmb9w==
=4TaM
-----END PGP SIGNATURE-----

--qhLQH2s+5hgBKos4--
