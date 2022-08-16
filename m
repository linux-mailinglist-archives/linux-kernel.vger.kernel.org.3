Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80461595CED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbiHPNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiHPNNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:13:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB27543DC
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:13:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55F0661367
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 13:13:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F6BC433C1;
        Tue, 16 Aug 2022 13:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660655628;
        bh=9wKthVRVsCVGq0aDuXQ5eyERhMDjocE9giRzIGPnX1k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YgOP+DZ+PRRpOYb1FNo82atDXYoF9Iozvefd8BWLw0OExfWG4mhWwsgwqseAhRRt6
         vxbW83bYN0E9w27AJd96CWX3f2kVISJ6KLjGsOQnZIYYjo/89mLLTRAKQ6AnXDN2xe
         R5V6Lni420DSdy1L3e/tYV3GJglgKJH9BcMjL0HxIKEAtuMAhIFIUu9Qo3LZKgkNz5
         nNC9NwjfTAHznEQ4jRg+oDxsqBEcVaP9K3MBdsPPlae5tYC1eGJyrAWMBfduNhqLrp
         mRBJLcXSpYbdXNA/oloTN+MVn9yf3rip6zyRL+E5IN6VjU2IYo2n8hreF/PQscFRNd
         lBV+5eskJM/8A==
Date:   Tue, 16 Aug 2022 14:13:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2 v3] regmap: mmio: Support accelerared noinc operations
Message-ID: <YvuYCO4uuw+O0PN9@sirena.org.uk>
References: <20220816130823.97903-1-linus.walleij@linaro.org>
 <20220816130823.97903-2-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="umxQ4vV7gOWTDg3i"
Content-Disposition: inline
In-Reply-To: <20220816130823.97903-2-linus.walleij@linaro.org>
X-Cookie: A bachelor is an unaltared male.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--umxQ4vV7gOWTDg3i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 16, 2022 at 03:08:23PM +0200, Linus Walleij wrote:

> ChangeLog v2->v3:
> - Rebase on kernel v6.0-rc1

This doesn't apply against current code, please check and resend - I
already applied some other patches.

--umxQ4vV7gOWTDg3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmL7mAcACgkQJNaLcl1U
h9DdGAf7BwXVFEPGHGTU1muy8brNepS2RUrO4GYlbOH6ozq5dEVBZ8yygOCwO9vG
HnBfFuDLgYx4XW0BdFUpZ8V0cKy1mK2oMIf2fb5lv7C6/FFCkdWXDMr8kRg+sgaV
HZqUa2/xO4ua/sdpL1Xo/aAlFmihXvla3cEOgqd/gpdiFQdddvw0vEWc5ALS9MlM
0mcNaypKqTRpU0WdI9wVLCxBw/isbxivV5yIQq6BzULtPo/zbYsrLOk2QjTRBJOn
QqQWWyJehwNTuXbGwljGphne6y84stBl+IQ0ki+3iEHUHLxkO935xMjxVifqjy08
b/WMZqFaZQ3nDIvWhP82EAYh5+O7RQ==
=lRfY
-----END PGP SIGNATURE-----

--umxQ4vV7gOWTDg3i--
