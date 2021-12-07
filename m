Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C7946BC2E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 14:08:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236859AbhLGNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:12:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45188 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbhLGNML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:12:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6964B81757
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 13:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F560C341C3;
        Tue,  7 Dec 2021 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638882519;
        bh=F/fKPrZyU0Us2AwQLVOm7PVNFqhIL/DCq08fX5U079g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgyETY26JMkK2rPd3KETqwzJtFKtha6lCdv/3XD+UUxn68MNPLNW0eSTdwqsYLWsm
         Ht/YdrHOq18UH3RrM5jpknDUONfXqE+sADTEnxBZBwU27dfWo5tU9nfFEKc8tL4He1
         exEXNWYB2/W00ospNAsc73LGuQIBdlFiije08TCQfgOFgUtsBWCb9dd6xjpCbHUGcv
         uI54WfuWEncPP49g1baY2ot0KQ+o+VKLOpJN1hWWrZtxXQ+LOuAj5tq334PdgtYEpf
         TLNGFK1ML6Yaftdp1pxbb4OyjmWlwl9ZqiKtu9O3JfqaIBnRPGlHhQKqIKJUZybZI9
         IkF3S1nm+K7CQ==
Date:   Tue, 7 Dec 2021 13:08:33 +0000
From:   Mark Brown <broonie@kernel.org>
To:     =?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH] ASoC: soc-core: add the driver component name to the
 component struc
Message-ID: <Ya9c0d/X0z1QUVN6@sirena.org.uk>
References: <20211206095920.40552-1-kory.maincent@bootlin.com>
 <Ya5lplIoyhKsqFmZ@sirena.org.uk>
 <20211207094732.3be5befb@kmaincent-XPS-13-7390>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5MYbYLXEWzFbrHqI"
Content-Disposition: inline
In-Reply-To: <20211207094732.3be5befb@kmaincent-XPS-13-7390>
X-Cookie: Only God can make random selections.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5MYbYLXEWzFbrHqI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 07, 2021 at 09:47:32AM +0100, K=F6ry Maincent wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > Why is one device registering multiple components in the first place?

> Because the sound components are more and more complex. Why they shouldn'=
t?

In what way are they more complex? =20

> It seems to be already the case:
> sound/soc/codecs/cros_ec_codec.c
> sound/soc/fsl/fsl_easrc.c
> sound/soc/mediatek/mt*/mt*-afe-pcm.c
> sound/soc/sunxi/sun4i-codec.c
> sound/soc/soc-utils.c

Quite a few (I think all?) of these are quite old and and are the result
of refactoring from pre-component code rather than modern drivers, it's
likely there is no concrete reason for them to behave as they do.

--5MYbYLXEWzFbrHqI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGvXNAACgkQJNaLcl1U
h9D1vwf/WQeUnLt47+xN/hYRPXv4uwS7J4Sxig4UAKgRuuEvgicbcorrZGgO0ag9
fxRHkkGPKGBySIntd+S5lAjVY3WPDNa474hMJgI2rfqshgRCAQ77GG85QbW/XZ85
foGcx5vkTDGi/NW6unO2sFWkBjtYIkzdlJpPYZMOJeRlsFqeOyrGmnAsQKQQ4uzQ
i8VKky9LpEmMmbW+POVuV0jQ1Uvz3Zkk5MTwTDDauMsdCT+FzpWQu+oWjRqhePG2
RPfhWbGYhiDJmUIz07Mk+jVfUM7N6in1CNgZO7HmxfZnObR5QDfiM7mRkILkyQ5J
sO8bZoaOotmrfE13OkQQPxMonOJAww==
=arkY
-----END PGP SIGNATURE-----

--5MYbYLXEWzFbrHqI--
