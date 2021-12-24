Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A21447EF52
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Dec 2021 15:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352853AbhLXODb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 09:03:31 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55594 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhLXOD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 09:03:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1275A6206A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Dec 2021 14:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC10C36AE5;
        Fri, 24 Dec 2021 14:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640354608;
        bh=hK8fa6cRDsrkwlVMrS+4FGDDSpxP5rBcfnLDIk/SbPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tdcvfeu/Y8443O7Qo0NIPTGPDJ+a4youRSBm2Rt/vUafDTiLRt4mzanIMMHOe6xHQ
         GHx7+z2RaJ6fUn0kfem6sFdywW57uCgzbdXcdJkgus0N/gJK0lAT7YYZwYWgi7gM+1
         bXKt/j1hjrq95ZjIjXUGE7A7vA5uoCxLcw1ISrRgwviLwpkjQvPa9kh8NjTK7uoVUH
         YQOpXe9pFKkNgeSAxvCEuP5SVlEnSHMr8VcR8zSjB9vApMX6+29PgRVw2eD5u7k8FT
         bpC2OxHFN+ubra88C3YzDGQh+I3zoR5LY3wQFmqrShRcdFogmNuQF8roMO6+HTtWZZ
         IIC8dhL24vL9A==
Date:   Fri, 24 Dec 2021 14:03:21 +0000
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, chi.minghao@zte.com.cn,
        kuninori.morimoto.gx@renesas.com, srinivas.kandagatla@linaro.org,
        pierre-louis.bossart@linux.intel.com, pulehui@huawei.com,
        srivasam@codeaurora.org, lkp@intel.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cm>
Subject: Re: [PATCH] sound:soc:remove unneeded variable
Message-ID: <YcXTKTREgewfX9bJ@sirena.org.uk>
References: <20211209015707.409870-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dlC+KfgP4Eal8+6F"
Content-Disposition: inline
In-Reply-To: <20211209015707.409870-1-chi.minghao@zte.com.cn>
X-Cookie: Time and tide wait for no man.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dlC+KfgP4Eal8+6F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 09, 2021 at 01:57:07AM +0000, cgel.zte@gmail.com wrote:
> From: chiminghao <chi.minghao@zte.com.cn>
>=20
> return value form directly instead of
> taking this in another redundant variable.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--dlC+KfgP4Eal8+6F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHF0ygACgkQJNaLcl1U
h9CixAf/ZcaKYZRi/L5ncPwFD6FR1S3oma/laZ5y3FcRBOYoQz2SRTi9MncvcNeN
L5dzc8qwJU+Q8jYXKyAK6UAni4gaQnqDlnCGX8Nya6mR5gV9aFD4G6zjZjf46ZGy
JL7k1tlD9+B1eIa1EkyDU/SuD/I6tr0eRI3cTNIymZPu89Zl92gC4LJ6nlzh5mRy
PD9lqLR5vYA6OD+iWpKm2S/sCU8oG6wh6AdAleVY9pYrvRV9djrHa2jNqPYvNPpY
j+p4sQLaz02BPGQrZPO0Y7GvuWJeB5L21jxiQ3de29tLao2rB+XaLad47cQXtsSf
GE4aVlkQeVEn5N7G6vAQjTsYS5Mczw==
=41gK
-----END PGP SIGNATURE-----

--dlC+KfgP4Eal8+6F--
