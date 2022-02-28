Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6937B4C6E46
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbiB1Nd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiB1Ndz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:33:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C7B2B9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 05:33:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F95DB810DD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 13:33:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13CAC340E7;
        Mon, 28 Feb 2022 13:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646055194;
        bh=yB0sPUbTKBz3OHkJ3G6+IqQ0pPTptMupgZ9LMvAJgus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zm+d71XHR+VSc9BT2Y7ITUr/pshhbUbsa3nrkjCjlgrBgxoYYw69Db8A3ozUKmNqO
         HTRJW2I/30ImkDLC6q0eMoZ++7xAamdTKRyxV01yqboWkXIghaKnsJZz9mNR01DZeX
         ldlfaRAww9UFOndzSwLBXezR66fnCxbGpx0N/7qN4oguMcCosQLvhMaCGp2UXS+EKf
         wUX4IfkfY0RcEHU3DFV8miwfZbbrq2dCcq2pUbaqhnowdSHnL7g481484O37pAkWur
         0F4Kygqa+xO2AVtwfCCuxjxVli2T52OuW0DkM6B5/l35POZRjwxtjWPy/B/RU+UHee
         g3quF9+bSxQlQ==
Date:   Mon, 28 Feb 2022 13:33:08 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH v3] ASoC: codecs: wsa881x: add runtime pm support
Message-ID: <YhzPFJabTS5UZd7v@sirena.org.uk>
References: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Q7LTR4vJwJn2BIA4"
Content-Disposition: inline
In-Reply-To: <20220225180716.13462-1-srinivas.kandagatla@linaro.org>
X-Cookie: I Know A Joke!!
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Q7LTR4vJwJn2BIA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 25, 2022 at 06:07:16PM +0000, Srinivas Kandagatla wrote:
> WSA SoundWire Controller does not support Clock stop and performs a soft =
reset
> on suspend  resume path. Its recommended that WSA881x codecs connected to=
 this
> are also reset using a hard reset during suspend resume.
>=20
> So this codec driver performs a hard reset during suspend resume cycle.
> ---

You've not provided a Signed-off-by for this so I can't do anything with
it, please see Documentation/process/submitting-patches.rst for details
on what this is and why it's important.

--Q7LTR4vJwJn2BIA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIczxMACgkQJNaLcl1U
h9DLqgf+M/Cs5pWdkUZ2HJPRzifLJs6eTrRAA1rulsnPHNTVdAkEu00XsFfql7Yv
XdJjusjNH1D6afwCaVBI0FJCy8YSVC/spauaa5JAg9ndo55oE6njzetW9T6g8q+t
nf5ZDo0DCRg1S+7EQDMKKl9LWzjaJspIYffFMBdZYw65ciTTkFODOBVLXgDwrFor
i1wWEVGNJndkIg9Amm65vDy8f0aFu7NETXU5CPFBtyrUnnULk+Ja/bjM1c1ooA4y
9La0XGfRO1krDmB7uFM9WBAq+PmLE5SDN6gNB6P9ev5pKJ9JOiXIb028+DGdm6JP
XDDeAl9+WtstMFRq9B01JiW4yM31qg==
=SAQ3
-----END PGP SIGNATURE-----

--Q7LTR4vJwJn2BIA4--
