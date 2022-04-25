Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC5950E4FA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbiDYQEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243170AbiDYQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:04:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D7010FDC
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:00:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3543DB818A7
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 16:00:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A2BEC385A4;
        Mon, 25 Apr 2022 16:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650902452;
        bh=qiYmrQ20MKDWg1snu9b8DO3wenapaGeU+JhlqEU5XL4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrwFjXYq5E46lSsIDbTvmV+T+LUq3mrCLABmVXV8MAWFN5ct9G1H3wtocmUAGHeSz
         D2K3NmBId6yjst8B9blzlAdStWHkD6bbD4sk8Qlp+uJUAWE/qWDr3MdKhCxX+FMUay
         C5+KbBwkJbqvJ/FJoi8ollt+qnAcEPYO9TNvU5SamE7JFex5j4yIuz3HVnmVN9hH3P
         Fe9R15lWvfjxceHNkFTnLSQycPc/fVTdGLi8lcitt9v2xYCQ6XIJKBSi262pyES6j6
         UjhZ+WNL/QILZoYq6gPWJfGVV9aqC4fIBCK2nlvXnBRzcrtysRDwJOj4r80DaZ2cFi
         idXHla7M2LX7g==
Date:   Mon, 25 Apr 2022 17:00:47 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        alexandre.belloni@bootlin.com, sha@pengutronix.de
Subject: Re: [PATCH 1/2] Revert "ASoC: dmaengine: do not use a NULL
 prepare_slave_config() callback"
Message-ID: <YmbFr14wI6qoNJ0b@sirena.org.uk>
References: <20220421125403.2180824-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="k+MPFSU5/RcDk67f"
Content-Disposition: inline
In-Reply-To: <20220421125403.2180824-1-codrin.ciubotariu@microchip.com>
X-Cookie: An apple a day makes 365 apples a year.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--k+MPFSU5/RcDk67f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 21, 2022 at 03:54:02PM +0300, Codrin Ciubotariu wrote:
> This reverts commit 9a1e13440a4f2e7566fd4c5eae6a53e6400e08a4.
>=20
> As pointed out by Sascha Hauer, this patch changes:
> if (pmc->config && !pcm->config->prepare_slave_config)

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--k+MPFSU5/RcDk67f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJmxa4ACgkQJNaLcl1U
h9AFNgf/WwS6xweS6qV95cLfmYic7buazN1dEMvcR/XgOmXtFYCGTzZvZHkpCzm1
4QN0Rp1rPXwl58OVqHYQq079GlNXcWrBpmkR5hVIs3tCk58ldE+zO7TDOVL+rN94
djItDzzJHVddxXkja6q7E0FZqaIhZyjNSyGpw2jmSkqvQbeWLUHhApenTjUCv16D
4XF6fx5Or+zEgc0fX+FU0Uq15bZM+/vRE0G6TjXWpKVvmZhTHVZ26kWkVHylporE
XPWS+d9KKp+tvt31UrZnFukNZ6RhrtDQ2pts3hW1U3oxepSqk6M8MQh5crhLyVN/
bAA14SqLGcjTNzI/fF7Te12Z8zVHfg==
=mIXA
-----END PGP SIGNATURE-----

--k+MPFSU5/RcDk67f--
