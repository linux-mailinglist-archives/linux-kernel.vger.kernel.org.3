Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD5A4A7179
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 14:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbiBBNYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 08:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiBBNYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 08:24:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733B9C061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 05:24:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0793961775
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 13:24:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF1D3C004E1;
        Wed,  2 Feb 2022 13:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643808249;
        bh=o6TpSr4Ebs/+aowtxCYwb/J3cAptbddaw6esQMuHyjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vowr6KxsTAFZ/Qbfyh3ZFG4lXeNL8GcrZobttR9UEm5bZ8uQZ83SzEAn+dNLbWncm
         hrDQYW4JLHTeC3hVZmWpdDpuWoIZuoKdnVSBZJCJMIwCLM9Ck3yJUpTNtRNFc9bQex
         p4CZaRPcczfds1+r1+0JfRAOHmeNKVNTSihX1Bv9SO7TRImvfynQ6qlcQVj8/hyUSg
         bP/ekIefc9EpzlQpqtRq8fvbg+zRwEmdgWRakpvYr7YsZn+QGOBcs584lodGu0MFTS
         WqFoEbRTYO+FHFpA2UOssRwGLcZAgJ6jH30bqZij/s9icsa2KNTrXhW4jzZgCUBMR8
         nWofKzcMsRhKg==
Date:   Wed, 2 Feb 2022 13:24:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@protonmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Ye Bin <yebin10@huawei.com>,
        Frank Shi <shifu0704@thundersoft.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tas2770: Insert post reset delay
Message-ID: <YfqF9Da6uVHUEA7G@sirena.org.uk>
References: <20220201234612.74401-1-povik+lin@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XCXfCLWUe2PIQvtF"
Content-Disposition: inline
In-Reply-To: <20220201234612.74401-1-povik+lin@protonmail.com>
X-Cookie: Quack!
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XCXfCLWUe2PIQvtF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 01, 2022 at 11:47:18PM +0000, Martin Povi=C5=A1er wrote:

You've sent an encrypted mail to a public list, perhaps someone can read
what you've written but I can't.

--XCXfCLWUe2PIQvtF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH6hfMACgkQJNaLcl1U
h9CFLwf9E1zLiYCHBrbPXnsb4rsXtr1d9L4C2s44AaRo6tRmH+4UfOg9ZsG8NXgq
0oM9GXK5Al/+Z8qPD8oKpqS57GjDUWviB7e/JE+41RQ/vg91PSmq++/JhAICeN7n
PBX78DFBdQg7+yNT//TZ/L5/qZUJlPku0KEuNHHUN7TrsyHsPwaf5iEvFc8cHnd3
2ih85rDTS8sUUldB9+5vjwAZyJiVaxlzzFZ0/Fz/eKud2FsuQ4R1pMI7mEwLZQMr
rOBoyZNTwwKxt+VjTfwzFJ8EKXvqulzfCmCulzcPk11a+Px3P7fNmdvXxcpRrbun
SYkRsV72/p3UIM7gslaZ5g6hAwhjeg==
=9Mrz
-----END PGP SIGNATURE-----

--XCXfCLWUe2PIQvtF--
