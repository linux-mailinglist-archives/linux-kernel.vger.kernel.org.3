Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792ED489B79
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 15:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbiAJOl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 09:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiAJOl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 09:41:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299A4C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 06:41:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBAF860E33
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 14:41:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A54CC36AE3;
        Mon, 10 Jan 2022 14:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641825715;
        bh=IRWKfarB7UT3aTZ8iGKekBjvvhb6auMLdXTsZCJAKhE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=atyYrExP1quHK/+eNzi+g41s0OBEtNuzulk6ZJTphsXFDPrNO8m8RH6z9LlRZ8EdA
         4lM/zxXN9UbiTTLTDuUpgEay+76ER0g39E07GcY0FFwny3LEc6Ygis1RhyRn8sDr/t
         FRyM3hwIjJ/M9L+NlsnZHOA9rXmgNUZsetlJi6Td4pXKc6FlXfABgGgyp1HglFEy4r
         E1c/IHOhyYbLt4A7T0ZKRAuZSE/kO7H9T5cm7Ouht/k3PyaGvmzAhFjfZ5rSLVPr8T
         IqqY3oa8e6TnFxzzubB8lSFaycBFbCL7NNQuv3YEyf8KA9HSLK4Kdg81DxESX/Zl3I
         lbPTl0rfedN3A==
Date:   Mon, 10 Jan 2022 14:41:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     cgel.zte@gmail.com
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        chi.minghao@zte.com.cn, patches@opensource.cirrus.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] sound/soc/codecs: remove redundant ret variable
Message-ID: <YdxFrb3r/u/ZAAQi@sirena.org.uk>
References: <20220110012833.643994-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ApzzE4PXBCVGL0Eu"
Content-Disposition: inline
In-Reply-To: <20220110012833.643994-1-chi.minghao@zte.com.cn>
X-Cookie: Do you have lysdexia?
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ApzzE4PXBCVGL0Eu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 10, 2022 at 01:28:33AM +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
>=20
> Return value from devm_snd_soc_register_component() directly instead
> of taking this in another redundant variable.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

--ApzzE4PXBCVGL0Eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmHcRawACgkQJNaLcl1U
h9BkZQf+OAhTmjfoI/kZdafc7EFfjT30BWUXU4ml6hWzhuflKB6oA3mrXlJlWHGs
u7r8Fn3Pb/oHQvYITKx+5kvbtNcya/d4dmCZ5cliRsVEy2SkcO9ndU3VtAVjiUt7
WAh92fwhmQVbAuSyN3iZ3uU5fWUshXPNQrCWIWyqrnINiadaNwVUDY9XqgY0hUiV
XGd3kMUHGRedOyPtstAla01QESWbWsDPGxCtatztmChooqf0MOzjsg1/kRIbJi24
CkutHEBlTI04yp0Op3cwUtLneaf7DE4U0VonHwPPC27Ii1qVEg3HpnAT9oT6MLC1
MpLp/D4ApBv9vr2/UD5dEWI9f1d91Q==
=l4Mb
-----END PGP SIGNATURE-----

--ApzzE4PXBCVGL0Eu--
