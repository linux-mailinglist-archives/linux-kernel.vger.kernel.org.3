Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAE5C4BDED2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381247AbiBUQtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:49:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiBUQsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:48:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED93237CC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:48:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C6A8B81250
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28549C340EC;
        Mon, 21 Feb 2022 16:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645462108;
        bh=BThUCu0i2KzEThjx4kOkeAs58jVnLKmkyOcT/U/ZjVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ch6hIqKdgafNt6HMmiSruSDLFBaBsJWXFhrE1Tg7FerOk8nsFaXG7t/Ta/oT9H20g
         U9Pmk5PelBxcDLGTaaYsbX5bfG6pozHckJIwt2sSh6rrh4K27oax4iKudK9pYxk/AZ
         Zj2/eyOFVeeDWXwOBa5fRCpEEb97DzcxQA8E2o2YwQi/jg7Yld/pLXQXqvnDBI5jkN
         05aylnZAaFy3iicTK9RJSbPgTWO3KxtN7e7PuGCmLMsrgOY7TSKMW61u9f3iPRi9M0
         f6G22sCKPNlIHMFhF09gazzytZQrEWehjcR10yWrfdDACfBztUsRp1tfjr62jgsg4x
         0kzFR4+Sr5UMA==
Date:   Mon, 21 Feb 2022 16:48:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, quic_srivasam@quicinc.com
Subject: Re: [PATCH 09/10] ASoC: codecs: tx-macro: setup soundwire clks
 correctly
Message-ID: <YhPCWDmS2PV/AD1E@sirena.org.uk>
References: <20220221131037.8809-1-srinivas.kandagatla@linaro.org>
 <20220221131037.8809-10-srinivas.kandagatla@linaro.org>
 <YhOx+nQ/G+HNRXbq@sirena.org.uk>
 <d8f1db40-33ce-671c-2041-5f12608afee5@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N8HrxkquhfNLRnQ5"
Content-Disposition: inline
In-Reply-To: <d8f1db40-33ce-671c-2041-5f12608afee5@linaro.org>
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


--N8HrxkquhfNLRnQ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 21, 2022 at 04:11:56PM +0000, Srinivas Kandagatla wrote:
> On 21/02/2022 15:38, Mark Brown wrote:

> > A lot of these commit messages sound like earlier patches in the series
> > introduced bugs which isn't going to be ideal for bisection.

> Yes that is true, I did think about sending this as a fix.

> Adding a fix tag would not really make any functional difference as we will
> be hitting the issue only when we enable pm runtime in codec and
> SoundWire controller, so I did add this as part of pm runtime patches.

> Without runtime pm the clocks are left always on, so it worked so far.

You still need to pull this before you introduce changes that cause
trouble, not after - it needs to be preparation for those other changes.

--N8HrxkquhfNLRnQ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmITwlcACgkQJNaLcl1U
h9BBWAf+LiLVaYi+pxISHIxMrZP/doKcCZFWS0PzcOWi4Nb1xxw5zfEHUYdnuscg
iPY6VOk8AVaU84YBgus5cN2YAZNT6lbbZwMCRNyGMps7vJJNLQuCQjPeekPzqGCM
VZfsV1bTMk3tkfQlSw+sixOxX8AVtEcOFyttH+yCt6s2PB2r4MZZrGiHi7kpGJil
Yq1NMNBdlsiFPdiWFmtlndqBEJlavMB17QG9lZjxC7mpUxT0zUPVRlevMp+0Q0/8
9gguv76axuD1+1N029zWYYjpTJYHXPSSqC1Zg1Yu9+V31w9lGpLcnMJAcmcEtYjq
Bbi9CcIy8mUff3ccxwI8lShQftioOw==
=5fQu
-----END PGP SIGNATURE-----

--N8HrxkquhfNLRnQ5--
