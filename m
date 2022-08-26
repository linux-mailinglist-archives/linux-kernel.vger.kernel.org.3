Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D865A2E63
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 20:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiHZS02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 14:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiHZS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 14:26:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E211D2B35;
        Fri, 26 Aug 2022 11:26:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAAC1B8321E;
        Fri, 26 Aug 2022 18:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0249C433D6;
        Fri, 26 Aug 2022 18:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661538382;
        bh=+qlRjnbHsYMoK3QE6kiB3Jz6gVVo3eCKxIUxzMEtgRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mhzUWSwY5d35iJf9L5F5I50510BX9NsD4S2WE6x0E6varC3ZhrJ4UpoizZi2j1+gN
         NJ8BaetmR5YzcwGCfO2DNieytqrh/jLzDveoWZL0mD+mSoczL3H346vPZw+12d/6BL
         AS9A0BIIkapqGL97vA8DEs1nOtzX9SppeUPFBXbqSAQNauU7QutNfWbNgKfYJCdzEO
         JCAXa0rQ7Yw2sUjxfEnAeFufB0BN6GZ43N8iUlOyakIKNPwNFWxFfBJb/5+UE6dJQ/
         TR91oZ8DwsPRhRNtDXaMNybaBK4xxXwuEcsb5/yNOt6bPxj2Euz6yk1uTZq7NXlQgJ
         VHNdeD4xY/52g==
Date:   Fri, 26 Aug 2022 19:26:20 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     shreeya.patel@collabora.com, alvaro.soliverez@collabora.com,
        kernel@collabora.com, krisman@collabora.com,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sanju.mehta@amd.com, tanureal@opensource.cirrus.com
Subject: Re: [PATCH v3] spi: amd: Configure device speed
Message-ID: <YwkQTKNg1+2x2hGA@sirena.org.uk>
References: <20220825143132.253224-1-shreeya.patel@collabora.com>
 <e5ac1c95-a6b9-5cd6-3f6d-1134677f4fcb@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xf0FWGmO80sZj8xR"
Content-Disposition: inline
In-Reply-To: <e5ac1c95-a6b9-5cd6-3f6d-1134677f4fcb@wanadoo.fr>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Xf0FWGmO80sZj8xR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 26, 2022 at 08:44:31AM +0200, Christophe JAILLET wrote:

> So, if the requested value is one of the table, nothing is done and it can't
> be selected.

> Is it what is expected?
> Without looking at the rest of the code or at the driver, I don't see the
> point of this test.

No, the speed should be selected.

--Xf0FWGmO80sZj8xR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMJEEsACgkQJNaLcl1U
h9D+RAf/VR65AY/CdkxjG6ff7Hu+K9SqwRyjLj538PyR5+tIH6JjKE3IRwFEyoHe
d/SV0bLRiwnoShQYxyWZSAQk22YeOJ7/EHZZcLE094awqBJFotxhFOtHetwlcvc8
k6jVsLHY/ZBVIa5JY1hOr7UFLJXuooC8G1/PL3YwYeWogRXbG9PFZvFnC+zjP1cS
XHBIC0ao6XFrByTXrZPnaB+8BHnJeHg1YT93CE/LVVITCm60+kRRxpYThdOFJnN3
EFgQ2AZb08iBSkEBIougUBoTiZlAZm4+3UeTNPGf+odasAwodCHNib1L7Yvvk0+7
XjVvOvyQKNkCz236Ww4wxPJvbdkHjA==
=ho+M
-----END PGP SIGNATURE-----

--Xf0FWGmO80sZj8xR--
