Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5766352DE6D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 22:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244253AbiESUcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 16:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiESUcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 16:32:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3EE5DD29
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 13:32:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E516061BEF
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 20:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB260C385AA;
        Thu, 19 May 2022 20:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652992320;
        bh=n23XRFUFMstCGk8mn6a//a0qUBX/Svoko9l1F+IHrPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lhjUgOWemoX82K6Ic18VuKLtgKoTBowUGJirOki8ui8abJaz6XBivJMANlENRZLXp
         mAx0PYNBD5andrcuN38p1V6qeXPZyDGdPv+NUGUYbE9RFoj3Xq7LLhKQ8IKy7iA+SH
         Q7FMAWRdC4hh6BriJhkZXlcXPbglugcSCfnsgppPaTi5H6/I/AaE9oa8cPTf6TSiJt
         IxK9E8ohbKMT/v8yVassG1EBSSLHlZwz3gHD5I8b7M8MONF1PaCRrYZZH1D3y0GDRp
         1DKQOKuqd0wy1ji+VgXkvcVmdMxKuIpEifAxwEtqpiCYFFYPVPFNN6nvvxjW97iwnV
         DVN+xoNVi3VQw==
Date:   Thu, 19 May 2022 21:31:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Alexey Khoroshilov <khoroshilov@ispras.ru>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: Re: [PATCH] ASoC: max98090: Remove unneeded check in
 max98090_put_enab_tlv()
Message-ID: <YoapO3yPdW6Sa+wF@sirena.org.uk>
References: <1652980212-21473-1-git-send-email-khoroshilov@ispras.ru>
 <YoZ+dmprwb5Ohto3@sirena.org.uk>
 <fd58c07c-488e-1c90-a755-194f714bbe45@ispras.ru>
 <YoaEXWGEY4s14je+@sirena.org.uk>
 <ce6853a9-6789-f151-3193-59b7dd73bd27@ispras.ru>
 <YoajesD+D1W3ZV7/@sirena.org.uk>
 <4080eabc-5e56-905d-d994-84ee57c2cf31@ispras.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fYcmQXDXRAF+pPBh"
Content-Disposition: inline
In-Reply-To: <4080eabc-5e56-905d-d994-84ee57c2cf31@ispras.ru>
X-Cookie: Some restrictions may apply.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fYcmQXDXRAF+pPBh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 19, 2022 at 11:13:00PM +0300, Alexey Khoroshilov wrote:
> On 19.05.2022 23:07, Mark Brown wrote:
> > On Thu, May 19, 2022 at 09:27:25PM +0300, Alexey Khoroshilov wrote:

> >> Do you mean something like this?

> > That looks about right.

> Should I prepare a patch or you will do it yourself?

Please send it, you already wrote it - may as well get the credit too.

--fYcmQXDXRAF+pPBh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKGqToACgkQJNaLcl1U
h9A08Af6A1cyQi40qAdJmheJWDP8mFvjmJ336RjogFvj511AZW/XY6JzWTrpqgDC
3DisrlCMjtnhgvN3jNz43lKFwoJY3pxozLUTFMg93ZxkL4WFPgXWVo3yrTG/DMiw
qpo3D6mmEzPHp5iKGIUWsTSknhSuSmXc8RbLujDl8cEPrUf46Rd72cyCcQVqX/gU
V4yBYWMMwEhevx9e3TmMuSH/U2NGU2ad17JiUiZn/5nRhhGv/q4bScVxNGUt7hRJ
FMtLiELr/Zf4jJuFIhGKMMoAkDE/nutbG1eavHi/vlyG99Jf8EGfTUgGl7cGQRGa
sdpiKzPj1JdoFPxHMv22a50C0jVSOw==
=M3zP
-----END PGP SIGNATURE-----

--fYcmQXDXRAF+pPBh--
