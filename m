Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6994467CFD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359246AbhLCSOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 13:14:33 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35496 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbhLCSOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 13:14:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 001A962C76;
        Fri,  3 Dec 2021 18:11:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB94CC53FAD;
        Fri,  3 Dec 2021 18:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638555067;
        bh=igFrEeJpF2OZf9Jo/80sQz+WH1Z+Faa3wH+gun1zpGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qw4NTfMGNzvYUWRtyWUWBWIFfJbMRl1w+tXmritIu3cq5/GhmZFF7C1Ek7BeaO+7o
         sg2mlee98y5i72D4684ISJFsfqeJWZl45+7nNvmNYrAZaP1x2k81A9hFFeCFZp8hrE
         Wt1vOsMs0G7Op+LNIER1akRdDpHd5Qa/r4czfcErcJd4wRPAoDtT7rlGSC7d2rr0+y
         2d7cuZ9RKtiYbabKfVn30ibthkO8FYNKb/ufKjAjZD9GkYBcU81qdm7VI1YeQDi33z
         cWodv7KJTcjNzWt6aXf3pwNDX2YXSGH70wE6gGJYg8xp4O22l6x2uoRTawksDCK61a
         PLAuMJN8v+GXg==
Date:   Fri, 3 Dec 2021 18:11:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bcousson@baylibre.com, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, robh+dt@kernel.org, shengjiu.wang@gmail.com,
        tiwai@suse.com, tony@atomide.com
Subject: Re: [PATCH 1/1] ASoC: fsl-asoc-card: Add missing Kconfig option for
 tlv320aic31xx
Message-ID: <YapdtAAbrhJ8kW0M@sirena.org.uk>
References: <20211203175018.252641-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lh3+hiHCqE5cETDw"
Content-Disposition: inline
In-Reply-To: <20211203175018.252641-1-ariel.dalessandro@collabora.com>
X-Cookie: Don't get mad, get interest.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lh3+hiHCqE5cETDw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 03, 2021 at 02:50:17PM -0300, Ariel D'Alessandro wrote:
> This is a follow up of patchsets:
>=20
>   [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx
>   [PATCH 0/4] fsl-asoc-card: Add optional dt property for setting mclk-id

Please don't send cover letters for single patches, if there is anything
that needs saying put it in the changelog of the patch or after the ---
if it's administrative stuff.  This reduces mail volume and ensures that=20
any important information is recorded in the changelog rather than being
lost.=20

--lh3+hiHCqE5cETDw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmGqXbMACgkQJNaLcl1U
h9D2Cgf/R5khnlu5BvBDSME0pvpG+4+PjCkPFKi3+kdhK7Onjmyln1gLD2p/pjDl
C2EP3YXQcgiUywBXBrCblKFmsu2XQjqlCco9TcYbnmBzcmtROfr+m3vGVgsVFAtY
3R0EhJtfcHTVzhtgQokgsTNeUITGdjPFmU/VozNqdDUObyBP2VLr/l4eLtDcEWF8
RteHve4FrIcJxTQjYNMpAsIBB5ztm2l+IuFI1kAnIcfG3iDgDNaNHeENbhgKIjiU
LES7XBsQbDmO7S8svN213VOLmfUowwAL5I6mnJBZlkTPATA7zMkZnvMk8L59nnsS
rgual2IJtpkc4Viaq4BYba1kKrcWXA==
=gP64
-----END PGP SIGNATURE-----

--lh3+hiHCqE5cETDw--
