Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3414B24C3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbiBKLt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:49:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbiBKLt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:49:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1B4F3B;
        Fri, 11 Feb 2022 03:49:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96CB0619F3;
        Fri, 11 Feb 2022 11:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900A6C340E9;
        Fri, 11 Feb 2022 11:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644580196;
        bh=EF0Nj0+jfw+hmL60rlX3GPZQeAvFkdT57GJorcn2C+s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LJCK6YWtNBNPRCD5sV0Op6gm0WA/QbXpDupWki3+RxrW2M8pZErR3e5KIw8E6FBYm
         E8krep5rmvS5LG9N5ZWfqUKW9vaZq5DrY1G3D9WVHfdBHbDmxjJDUN2uyErX8alN/w
         wdC5AZPCgKR103Ob+eWEzbx0OFReLdASIbflGdTRNXxVrB3EEGqx8n5WZ09YKB7j1O
         GP5kCxaeBySmp3zvTyCxVK8d0nEdPIEPnyv4HWX/RUlkaW6nnfl3RKRItty9p//ze7
         Jj3Zx87t8lxJBTsInBN4aZ5Nvc+XJipYWQ2BWCwiJZPWfPgrm77UD8kO9I8foNJyg4
         Pnj0WWTDqJE2Q==
Date:   Fri, 11 Feb 2022 11:49:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jon Lin <jon.lin@rock-chips.com>
Cc:     heiko@sntech.de, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] spi: rockchip: terminate dma transmission when slave
 abort
Message-ID: <YgZNX4ZuSumZ/Yie@sirena.org.uk>
References: <20220211034344.4130-1-jon.lin@rock-chips.com>
 <20220211034344.4130-6-jon.lin@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rmnoW3paj3umB6SM"
Content-Disposition: inline
In-Reply-To: <20220211034344.4130-6-jon.lin@rock-chips.com>
X-Cookie: do {
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rmnoW3paj3umB6SM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 11, 2022 at 11:43:42AM +0800, Jon Lin wrote:

> After slave abort, all DMA should be stopped, or it will affect the
> next transmission:

Again, this is a fix and should be at the start of the series.

>=20
> [   31.693877] Unable to handle kernel paging request at virtual address =
ffffff8105a2a7c0
> [   31.694643] Mem abort info:
> [   31.694898]   ESR =3D 0x96000045
> [   31.695179]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
> [   31.695653]   SET =3D 0, FnV =3D 0
> [   31.695931]   EA =3D 0, S1PTW =3D 0

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative (it often is
for search engines if nothing else) then it's usually better to pull out
the relevant sections.

--rmnoW3paj3umB6SM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGTV4ACgkQJNaLcl1U
h9C1KQf9GVPQqLpAYXPnTVXWv2GgFuiO3xWPa4fGn6NFNruqsC9kG0ILuIzo96nt
Rt7bz7N2dqWB0CuQHZnyAPMmIe97An8dmUZkb1o4DzJVrQyQteZ1X6YQekbpvpSO
kYS7IBZTqmQckxR0xKm9Wj9Sb6N+eZ3evbKgF+rGU1eIOeC0Qvaqd6QyNbddWEfB
PuU4UpH42zkWR/tzrTM2sdZy82aylHomTEHRn1f+/bhOrPna9bn6PbV2nuJ5nOeN
g4ARZsoRuFPYXn9dBvptd/YNinUyxuOLYgqyYl+r/XDgR7CPSH44s81EnsKNYO3N
9zmtydE+XHf6scVEtKuzSoilb26imw==
=5FlO
-----END PGP SIGNATURE-----

--rmnoW3paj3umB6SM--
