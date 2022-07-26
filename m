Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0EDC581674
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 17:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238545AbiGZPcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 11:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbiGZPcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 11:32:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC051B78B;
        Tue, 26 Jul 2022 08:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C05E960A4E;
        Tue, 26 Jul 2022 15:32:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0CCC433D6;
        Tue, 26 Jul 2022 15:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658849539;
        bh=gfyWAILoauhn1wKAyQ56lPP3KLjANtSN4iDI1oczkrE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RpHcoEv+bS2ZgBJjrng2OMj8+YBn0cm4+WwM+FOQ4EVvV2CNMMdQqq+ZHzEVdHKS6
         +OfXU3Eh/lu311K4SS3xTFEaL2LsPAdcBHK3Bk2RnEs0HVGik6znLM0Z1moxuAMdWk
         TOZqJwscHMZcZ1wZCFF/6qGjXK1/AIkE98C/jjasgvkfUCxUDG6RhXxZGvkeVLpcYf
         b8edDIs0IF+DnaS321d27ZPuLNc5Uey2NiX2loAtXEExrWeeSJHbGf4jXAMAua1b4x
         US46fUURVeh0EiCPKo6NfpgrjpLfeuVYlVGSE1MKDl+yDE6ITAxZcHwHiypwV8Lwwx
         jqyY/TgMkjJIg==
Date:   Tue, 26 Jul 2022 16:32:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Elad Nachman <enachman@marvell.com>, Noam <lnoam@marvell.com>
Subject: Re: [PATCH v2] spi: a3700: support BE for AC5 SPI driver
Message-ID: <YuAI/kUrL6OQG6Ff@sirena.org.uk>
References: <20220726130038.20995-1-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zfuptPbiqfz74Uoz"
Content-Disposition: inline
In-Reply-To: <20220726130038.20995-1-vadym.kochan@plvision.eu>
X-Cookie: All rights reserved.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zfuptPbiqfz74Uoz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 26, 2022 at 04:00:37PM +0300, Vadym Kochan wrote:
> From: Noam <lnoam@marvell.com>
>=20
> Signed-off-by: Noam <lnoam@marvell.com>
> Tested-by: Raz Adashi <raza@marvell.com>
> Reviewed-by: Raz Adashi <raza@marvell.com>
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
> v2:
>    #1 added missing SOB for Noam

Noam, is this OK?

--zfuptPbiqfz74Uoz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLgCP0ACgkQJNaLcl1U
h9AHdAf/TC++pyYuoANRu+wabtfwqC2ZoGl2yjTZLIw7wGPVn7rIHkbcF85SoDp/
QxKtvO1DXEshTVGOtc+2SYH3D4HYUAdOZbJaANMqTOPsvvRJQvmQVmyWW1lC+oG1
Ofw/wSMmYIa5Y1ew+czNNyNL1Q/Of0lEa4ti/06nk20n4BWZACWoLOIa0sTgexd6
ZOqiAAIBDlxJdNOXarE9fRMGbrFQO1nr2eLzAEhLhpEb37nbJZUqK4fAeVdbKz5r
waFqcLuVKkfoh9Az5C1m7RFsaz3ySW4uz43l4n4TaRggOoK/wbVF1VIUsRhltxv5
a7kEKI0JrbR/MvpI0iLtpd4J1XrzoQ==
=9bQB
-----END PGP SIGNATURE-----

--zfuptPbiqfz74Uoz--
