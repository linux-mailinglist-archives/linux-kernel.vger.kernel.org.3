Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A798E5603C6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 17:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbiF2PCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 11:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiF2PCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 11:02:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F31E1E3EC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 08:02:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 154F3B824F6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:02:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE84C341C8;
        Wed, 29 Jun 2022 15:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656514948;
        bh=YrW0MclUMyY6HcWXjSnuuUFbvlixqKQGRTLyrIyuaNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pv37R9NP3xjH54c2qAdGqhH0HdmWOME93RcwiKVRzc5Fp9XVH7wL8ynWDb03uSjhz
         OTSpIzqZGIpqPRHSEqyv66o679VemE0pL06v/QS6jLnbua/06ux9/QArO7nAOa6W6H
         nQ+PThkNL2P6Y28zO5td1v+t4zqssiWFPqQowauXh1u28O9eiLj1hXtL71IhgmbtW4
         /dr/7MpJbYA49tTmBqB+dD8uBrOo0Vfsz1l9hs0zcxn5swV9xkvs6rhNq5Dr61Q/zj
         FaYmXsLr/Ikz23Afr8paaprehEjSfytBYI4yD+xkEwpphAPnZM5xq50A/3dw8CY42y
         WyLeDh1+Iqglw==
Date:   Wed, 29 Jun 2022 16:02:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: codecs: wsa883x: add control, dapm widgets and
 map
Message-ID: <YrxpgF2B5W7fyYVy@sirena.org.uk>
References: <20220629145831.77868-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CQe+J6NOIs3++col"
Content-Disposition: inline
In-Reply-To: <20220629145831.77868-1-srinivas.kandagatla@linaro.org>
X-Cookie: Booths for two or more.
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CQe+J6NOIs3++col
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2022 at 03:58:31PM +0100, Srinivas Kandagatla wrote:

> +static const char * const wsa_dev_mode_text[] = {
> +	"speaker", "receiver", "ultrasound"

Idiomatically these would be capitalised ("Speaker" and so on).  Sorry,
didn't notice on v1.  Otherwise this looks good.

--CQe+J6NOIs3++col
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmK8aX8ACgkQJNaLcl1U
h9B68Af+OSwqjG2mYULXNLPfUr5eNb4DI+Y6bHPZFcuyEnRugPAEnGTHmOSj1ysS
q2GQrCsTJTm8dByTkopi1uIHgetJIy9vb7rItZqE2GK8BHb3Ne2KUxKL3XkX7g5C
+OSchkZVjHjDuwJ4NPmTLWUrpFbQcMrCnrM3+pWhFNqLE69mg8DioAaer1wWjBEd
E+6piqi8E1AyQlV+sOGe94sUXWVP/REM6wEKOKd90SMXSs87XYLbOb179k6YkSyy
iO2qgO1aif6QYJcNm4NdprDvwnXEEcP6s/PAqsEfqoQ8mggt0EHfBRZ4ri0Cn8mz
DETkg0CsWMM8gEHA16POeG5NImOVOw==
=jykd
-----END PGP SIGNATURE-----

--CQe+J6NOIs3++col--
