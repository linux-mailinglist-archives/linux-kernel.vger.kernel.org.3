Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1FE5215BE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241946AbiEJMtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241933AbiEJMtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:49:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EB954F9E;
        Tue, 10 May 2022 05:45:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9EC7B81D19;
        Tue, 10 May 2022 12:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E830C385C2;
        Tue, 10 May 2022 12:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652186725;
        bh=6Tfsp4itt1Mc3PO44t815pdkzz8WkX2HTQRq8Fx0SZw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VCU5SEB1Qol28GTL2mHwXApm+Hc0wPXWT55Emw2+4xCbWXbIF6CUBSpoJ4odwKQ6V
         6UWFUMhHTNnNSWGciRePfWWeZ3MutAMA7f3F6rddeb1b+wHN928/a1Pz048PahIeFS
         2z8u5WeTBx0me0A2xRg9fhAZRqOYh8XcTgw8v/1HsIVhwHNFwWXtz/YojQjeS5wxuO
         llX/z/N2nE42clXfqQ5HtQJs/DioaBMYnXDSDuBzXCq9g5b5+sDTZ1BsEP88SBdu9k
         imexGaCSXnu8Orgtj0IqJHODzIdfZDuqptQIZUEpM4LaMvCLaVPMuA0ojh2e6B8sEk
         3XD/ygF74XGbQ==
Date:   Tue, 10 May 2022 13:45:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        matthias.bgg@gmail.com, zhiyong.tao@mediatek.com,
        colin.king@intel.com, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wenst@chromium.org
Subject: Re: [PATCH] Revert "serial: 8250_mtk: Make sure to select the right
 FEATURE_SEL"
Message-ID: <YnpeYGbo7JJK0lDk@sirena.org.uk>
References: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FZQV7cHcKQJUXSUX"
Content-Disposition: inline
In-Reply-To: <20220510122620.150342-1-angelogioacchino.delregno@collabora.com>
X-Cookie: I've read SEVEN MILLION books!!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FZQV7cHcKQJUXSUX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 10, 2022 at 02:26:20PM +0200, AngeloGioacchino Del Regno wrote:
> It was found that some MediaTek SoCs are incompatible with this
> change. Also, this register was mistakenly understood as it was
> related to the 16550A register layout selection but, at least
> on some IPs, if not all, it's related to something else unknown.
>=20
> This reverts commit 6f81fdded0d024c7d4084d434764f30bca1cd6b1.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---

Reported-by: "kernelci.org bot" <bot@kernelci.org>

--FZQV7cHcKQJUXSUX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ6Xl8ACgkQJNaLcl1U
h9CCcgf9GdWINYkwQNpa49JWR+D4PX3vyDYOvAMhApkx2tIGvJiHQ42wCUjXN5G9
9uGCwzkhq1g4N6ppRhhr2rHaTTHPIwi0J/KaGIGuCMEiFu2MiqmTVmPjXkZ6X9KJ
TvlW1Q+d9qc+fAdqagKU3py8jQMVY/kEFwXTPE2s6NhUf/TxujQbuSHX4JhJ6CiU
NtMkMsALrNPQXu0L+7WI1+u84gRGpDalpQpBcPhAZVSuCGUMFUCMKRr/J5PotKoS
l89HHcBvjyz5IRUtaHnZ23ermw6mOrS9dEAn8jWXSIy7vqhHDHNLfoDMa/loIcMu
/BhdI1rOs34c3ZtwqzhAT9Tk66Af0g==
=wDoc
-----END PGP SIGNATURE-----

--FZQV7cHcKQJUXSUX--
