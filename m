Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DA555C95C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239565AbiF0MAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238844AbiF0Lwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:52:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF74DE87
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 04:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C5A76114D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 11:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E820AC341C7;
        Mon, 27 Jun 2022 11:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656330354;
        bh=VwADrRZxFk1rx290fAkceHuvRfDBtWvrEJXtxd3r2+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qo2nk0KSOwfsUGuWeIrmyKqTCUNAZIDAkfFoNw4Ut/1aIDOAkKWq1iK5HF8Gixklm
         tIpA6xPXFAax0TtCIKCzysoM2W3chXUDd7SU0IfqaZJRKe4oirtcAHGbMDjMkNO8FS
         34UrMWzSWeZyCuR/EBXumonWH9+Vh69wM6KSUDogqgDgNZTHWGR1eFGAgkRBGwpcfv
         /MuJ7eBMf/I2PV/pYtzFpbfD8PDee+vkuzTZu9vfob4uzjmz8DihrT0JXV059ItckD
         SycYYkUBL/OqBIqQDAq5AdevAEnvStSYyiW2W0njPmEYhfWhhvEWEdFdZrbr3AsleN
         yVf+TLN+wsInQ==
Date:   Mon, 27 Jun 2022 12:45:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        s.nawrocki@samsung.com, jrdr.linux@gmail.com, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: samsung: s3c24xx-i2s: Fix typo in DAIFMT handling
Message-ID: <YrmYbZV4mj9d9++t@sirena.org.uk>
References: <20220627094335.3051210-1-ckeepax@opensource.cirrus.com>
 <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cGrbKaug4SaBI0GC"
Content-Disposition: inline
In-Reply-To: <803785ef-42b7-647c-9653-702067439ae9@linaro.org>
X-Cookie: Your supervisor is thinking about you.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cGrbKaug4SaBI0GC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 27, 2022 at 11:49:46AM +0200, Krzysztof Kozlowski wrote:
> On 27/06/2022 11:43, Charles Keepax wrote:
> > The conversion of the set_fmt callback to direct clock specification
> > included a small typo, correct the affected code.

> > Fixes: 91c49199e6d6 ("ASoC: samsung: Update to use set_fmt_new callback")

> Where is this commit from? It's not in next.

0b491c7c1b2555ef08285fd49a8567f2f9f34ff8 - if you can't find something
search for the subject, people often get things wrong.

> You should put such big patchsets in your own repo (e.g. on
> Github/Gitlab) and feed it to linux-next or at least to LKP.

The size of the patch set isn't really relevant here, the same issue can
apply to anything that can be built in more than one configuration.
People should of course try to do things that work but equally we
shouldn't be putting procedural blockers in place, we have integration
trees for a reason.

> This way you would get build coverage... because it seems the build was
> missing in your case.

That coverage has apparently also been missing in -next for several
weeks.

--cGrbKaug4SaBI0GC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK5mG0ACgkQJNaLcl1U
h9BVlAf+OdXMLIbXe5mSgKiE3F5jvcMaD820Gt9mVcl9LubefegZsfo7YwlfYblG
T9PiPgq0pwJOjh2fYmW0ISNuL3KqSgd3PCyOs9BkRCj0ELAtDn15G3UGVtjwEQjH
h70i8Iy4MbZQu8CZEBen+earhLqXvuqe3dH27eJUyDjSCHzvOq7zkCfeFS6JCXFQ
02I5/NBZGYC6r71IYGlpgRhMj94/PYKhnvhyfh+1dnVLEC9WD3eAZOB1YRfLDcBk
jv4XUFP81VyzcGlNbj6K57AMPMGNWFo5R0K5oYPTwUx6ytuSdx/+kAXPIWuG2eLH
iMgqgebuD6gmWiew3VdW9sJF6uBj8g==
=G3oz
-----END PGP SIGNATURE-----

--cGrbKaug4SaBI0GC--
