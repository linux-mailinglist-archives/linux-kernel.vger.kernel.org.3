Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E3D4F8873
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiDGUeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiDGUds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:33:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA004309733;
        Thu,  7 Apr 2022 13:19:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6285E61EE6;
        Thu,  7 Apr 2022 20:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5399FC385A4;
        Thu,  7 Apr 2022 20:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362761;
        bh=wvHGj64vM91wOSns5JUHgnqOAZgSjEKinirx8jhxKd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t5DgHjQgoqHqNuZb2QtQHc0C6KsSiOmZ9XfSoMKdXgFN2AtX48ABEVES5neyB/NPL
         hwQl64kgzDVVxbXrvrEzTJqlTPab4bPrWUlcSjga2pjZMqVDw9ocq3bXQmMCqFfOVj
         sT7eEsVE6coGnEUZZ+8fBkCig5ezjWD5zBAqNQD3aceNVFh4NfczC9VhVQpk0Z2ADx
         O08pte6MXlMhdJupzb1gefKDS2vG4lADTYQ7ZE0FQpkpnbv1X/VbtA24ai6DXogXop
         Cnw1AM1HgY4nLEBiUsc7yBimPPSApWs84MRnCxvIa0WEZsUNjPttkUCfXoJOnAwti5
         pOSqY3xAWLbaQ==
Date:   Thu, 7 Apr 2022 22:19:18 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] clk: si570: use i2c_match_id and simple i2c
 probe
Message-ID: <Yk9HRrUUsuoUXHzk@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-10-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kPqjyEbTekpyxS2E"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-10-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kPqjyEbTekpyxS2E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:30PM +0200, Stephen Kitt wrote:
> As part of the ongoing i2c transition to the simple probe
> ("probe_new"), this patch uses i2c_match_id to retrieve the
> driver_data for the probed device. The id parameter is thus no longer
> necessary and the simple probe can be used instead.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--kPqjyEbTekpyxS2E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPR0YACgkQFA3kzBSg
Kbbtpg//eNtYue8ZV+wmhYbFjOZoVRFjh03T5lcDjvOG1rhNjGfRd/n/4E+XT8wP
1q7sElHnyYjvnTEdDD1WAyB/kXJyf+VoVdAkQ6ighzfzw9XEPtLuLyKRSwHpKsVh
UUh+ddzXO2mIKx4es7rKQ1/mJs1ugG5eZvvz6WljgtE2YC6TARf3sM8feywxONDT
rhSAJhNzD0HKRQ5wM6DeYKB3yxEtKbUhY13jkmSxEonHmmV697rEukDrAu6uPJCY
sh3WlbzL5HtnZNYVbGgTMxZfpucO+yj97BaenyXUb1h2r3zUGE2cN2CUuLqoQZ5n
eIAK18r/UVTlWLXKGFCCt/b5AoD/hODOoooH8e3OjU+PvKYUVa3bQX0B+33Y3wtT
GUFycnbpJeQFR1vCwl+Nqdh3MgeKYV0cc4i1+WaYz90Jj2OaP+tW0+/wOcLNQcmL
ewc0TeNanFKjlKhq83ejBNQGyQtC/14fkLvQRfMkIJM2eHN+Jp6rRyimtiCB557M
nw/Kh6mcudWHvuPnERh+z3FzGgKu6zZWreZ8KpYRYIazahoaXMsGS2gZ16AiRIJ0
cs9WxPAgyr4e8mo8vmCVxeoE2FGFVsy+gx2esAhcvENzkjiW7VZGFLf6lfKVBl1w
73aWr5+6ktyjF9jf42lWWi5J/B6c2jTrwqR0oDwPgC3S5RCPWus=
=RGSs
-----END PGP SIGNATURE-----

--kPqjyEbTekpyxS2E--
