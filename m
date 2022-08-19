Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFC19599D98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349480AbiHSO20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349541AbiHSO2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:28:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2421E32;
        Fri, 19 Aug 2022 07:28:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2312A61199;
        Fri, 19 Aug 2022 14:28:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABEFC433C1;
        Fri, 19 Aug 2022 14:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660919294;
        bh=W6ZfbKa2VF0MiVjMNZj4uo2J9tIHd+e1pEfszl8HrnY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F7aK1+c8laxCqDdunn8O7uTKalWW8Lz9Isned6yIgCNuZnPcEmhK/XcSKoAFXa+21
         +TXBc82RaKwCQWvmvRfnyiXsIkECmEl8vXlJas0QQEXghJhrjPHX5BlZGGJOTk64EV
         45TDsZGyNsvrADmdHtyqCAzkrIG6nh6L+srEjmNrNxI61GZ4xfT6+zSBu4sA62vV8j
         HHLGWgnhw8Ma2PhmduPuzhiaw6yT9HolBaZ4OxVKO1vbj9Q6vumpLUAiMnzjWHtHj3
         qpV4IK1GhR0O+IwEE98pzNw7P1jJk0zVzqg4mVOdReMX8oKhmHhapk0EGp8UDZSCKW
         SMKhUs10DPbGg==
Date:   Fri, 19 Aug 2022 15:28:09 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     sanju.mehta@amd.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        krisman@collabora.com, alvaro.soliverez@collabora.com,
        Lucas Tanure <tanureal@opensource.cirrus.com>
Subject: Re: [PATCH v2] spi: amd: Configure device speed
Message-ID: <Yv+d+byNXO3z9JaF@sirena.org.uk>
References: <20220819123630.368462-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aqSctdl6o5lEG6db"
Content-Disposition: inline
In-Reply-To: <20220819123630.368462-1-shreeya.patel@collabora.com>
X-Cookie: You may be recognized soon.  Hide.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aqSctdl6o5lEG6db
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 19, 2022 at 06:06:30PM +0530, Shreeya Patel wrote:
> From: Lucas Tanure <tanureal@opensource.cirrus.com>
>=20
> Number of clock frequencies are supported by AMD controller
> which are mentioned in the amd_spi_freq structure table.
>=20
> Create mechanism to configure device clock frequency such
> that it is strictly less than the requested frequency.

This doesn't apply against current code, please check and resend.

--aqSctdl6o5lEG6db
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL/nfgACgkQJNaLcl1U
h9By1wf/dl7YskCYF6ui2/ddg+SJHt1UlD1E2IOf3wutpmHEecl04Fs4Q3HGBVGY
UBlrVXlRIpJr1wvGQ43qK2Upnmj+36qEwnjyHShe5cK+d5vPVRM0bo4irahG0XUe
cOvqWeNNVhInq7dKWt/DVM4KiutfJVlrOmMaH8s2voNQ7ec//AGZMiOk1/Hd4aXL
u2rO22NRZuTInjJDZSUncg66eFgBUzRJ7ezAhp9AkXp0ikbjYDdFAtV/u1AoLX2q
1aoY1W+ghLHZV25JoS6IBnnGpDnrnMqxIdFuRLEdgJGoDvJgqAv4vN0tLeNEK64M
iz/jNzM62HxJuwsxRUBKCjv6IFR43g==
=yBzS
-----END PGP SIGNATURE-----

--aqSctdl6o5lEG6db--
