Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F89B4C4E43
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:04:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234098AbiBYTEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:04:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233836AbiBYTEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:04:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326E01B6E20
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 11:04:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1ECE60ECB
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 19:04:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C30B1C340EF;
        Fri, 25 Feb 2022 19:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645815842;
        bh=FGWX3tQZnONYjuyTlSiJH7HJYvm5zOr5BDZ3J1C2Wes=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dj2vm/bN8/N3qyj/MzHC90dNLqhySp1xFAMpQ6QerZyaQ9pYEDE/iNolqnQmxLWTr
         ExJRIHEvC+BTFSU/sdUngmmUcAugcnk3ITDvzeMcscGXTfrIJC4kT0XiBH2i6f1PVa
         7FH18zczyJS5BVH4esgd65zDkFxylrUpsuWyvTpdXtd6a58VlhG04NE1NdzpjYBisb
         DDaeC/IxB8CZMykaEMcT2FakrtTPAvGf/R7TskUtiWW8IvLtbiOBWUVMuH9svEXTxm
         ychUkEyzrWCbrFNKhJbCoIpOaJ5LSV2sc4QKy+Pdmza/4saMDFbmXcI5Dfa96b4ln/
         brYFOW/WJ9GVg==
Date:   Fri, 25 Feb 2022 19:03:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     "Mukunda,Vijendar" <Vijendar.Mukunda@amd.com>
Cc:     alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
        Alexander.Deucher@amd.com, krisman@collabora.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>, wtli@nuvoton.com
Subject: Re: (subset) [PATCH 1/9] ASoC: amd: vg: fix for pm resume callback
 sequence
Message-ID: <YhkoHJKRuD/ZIM5+@sirena.org.uk>
References: <20220223071959.13539-1-Vijendar.Mukunda@amd.com>
 <164570533555.1194769.3668536221336070255.b4-ty@kernel.org>
 <d4b3f072-198b-0656-0b0c-134ccbac0d58@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MYKvWGQhoA7WrGZ+"
Content-Disposition: inline
In-Reply-To: <d4b3f072-198b-0656-0b0c-134ccbac0d58@amd.com>
X-Cookie: I smell a wumpus.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--MYKvWGQhoA7WrGZ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 26, 2022 at 12:02:53AM +0530, Mukunda,Vijendar wrote:
> On 2/24/22 5:52 PM, Mark Brown wrote:

> > [1/9] ASoC: amd: vg: fix for pm resume callback sequence
> >       (no commit info)

> This patch hasn't been applied to tree.
> Should I re-send the patch ?

There were some issues reported by 0day that should be fixed but yes,
please resend with those fixed.

--MYKvWGQhoA7WrGZ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIZKBsACgkQJNaLcl1U
h9CaWwf+JhRhuK7lBTxTjMMpjUpDrVmgxMex8heMiXlRwpYaIR2zc6qmT/1EowKh
40mD7/EYjgXkVgyOCL0+uO2f/QbbJioJEEWgA5h6AorB+v+cFMXGF1rSb55St/1a
grQm5GUlzBTz0vhod/yMBd2YcCqn8pttKdFYsduAU6WTCc4Y/VDPqVaVZZab8AH+
j+tAl78QAcpWg49fiG+T6OTPXaxway/fGehaoY0U/ZpZXLOvfC15HLldgSKS/t5K
ZJVa/0KB4DJCGNIbQtgONHNob9WuHfbwnWH7ilEMVgvO4Krr0JrmJCrWn6A8HXos
Q2II9wSxh/R/7V2x+PC5pc1wv8ww3g==
=OrUe
-----END PGP SIGNATURE-----

--MYKvWGQhoA7WrGZ+--
