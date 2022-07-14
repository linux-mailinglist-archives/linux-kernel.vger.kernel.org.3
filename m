Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34125755CA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240281AbiGNTWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 15:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240142AbiGNTWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 15:22:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10C445984
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 12:22:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D9FE621E8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 19:22:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0780C34114;
        Thu, 14 Jul 2022 19:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657826523;
        bh=ApKDCy2uQ2WkGx78PRaDpliR92Gh90kOwLI3/2Ax2OM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bes/uGKHSNJcXqy1rQGpdlk/nG6DzhjUZiOK4OGlYbsc6zSbCkN9iDQBMZ0IAt5kw
         KSN7C0HHkvDgi8j2uvFW5JjQ6fUVltodUjGRe91jkR7RnHcO6rQMwB4VU1+V7xMR1A
         EFuTLJahi9sSJN7c/VdtgYTPJmv6wQQDp33z5wOK8aLe4GlVys+lKawQIv1ZR8PvtZ
         u17rCzYbzfBvnnb9AribORHRh4UG/Cu04He8po5ZwctqVrMwEdDcEt/LVVVZHyB/8H
         jdYyRqKdf0bnlq2NG6aTO6xVQ7LEscxhvJQKBx7cXSxwiYCcXNxyqotj71WcnJSf9Y
         Azxb37LPbf0Wg==
Date:   Thu, 14 Jul 2022 20:21:58 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 4/4] ASoC: codecs: show PING status on resume failures
Message-ID: <YtBs1jwgop756z6T@sirena.org.uk>
References: <20220714011043.46059-1-yung-chuan.liao@linux.intel.com>
 <20220714011043.46059-5-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UsiKUEcK7+JgvMri"
Content-Disposition: inline
In-Reply-To: <20220714011043.46059-5-yung-chuan.liao@linux.intel.com>
X-Cookie: The devil finds work for idle glands.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UsiKUEcK7+JgvMri
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 14, 2022 at 09:10:43AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>=20
> This helper should help identify cases where devices fall off the bus
> and don't resync.

Acked-by: Mark Brown <broonie@kernel.org>

If this is applied to the Soundwire tree it might be good to get a pull
request in case of conflicts, though I guess they are relatively
unlikely here.

--UsiKUEcK7+JgvMri
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLQbNUACgkQJNaLcl1U
h9BSSwf/XJSrK1HOq2K7KapWhyPic1n5KsMoLhPDDcKtScol/q1KVSACfzp+05XC
arAh5he+7Fp+gNlpSMBizJCl3D/7A/Kh3hGp3xapNWioLqOl3G3sYusgyG7qpIlY
Czz3j8BJume7aDcMKhTMFuzLwIztRjak9g43SB6ouBEMqMeeMPYtHz6Co1PA/v9y
Cy82P8zcnh7KjXAmE3Fg5/LLiYeZxJQ+s4iYNezfZbqSUAzRMXEX+4UQ3C0nI1bZ
8KC/fqQiFqvklMuubBFEE1UezhVEzoZx44J2hWgKKeinZ1Ax7GjKFFVlGCrwDmvn
JTbHjdbra2SwFMzD4yb2DBA5piMDJg==
=2j9p
-----END PGP SIGNATURE-----

--UsiKUEcK7+JgvMri--
