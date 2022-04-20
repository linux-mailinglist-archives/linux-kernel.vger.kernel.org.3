Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76336508D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380578AbiDTQbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379855AbiDTQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:31:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A98A42A30
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:28:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AB08B81FEF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34B6C385A1;
        Wed, 20 Apr 2022 16:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650472130;
        bh=e5Imz+TxHLznlX9U88M7vFfjai+jH/I0GDwiX3IYL0Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UIgp4zOaVTmQ8aRmJyqxecoXePj2RaDR9h0G6Ot6llYUVDQY9hgSHB4Cnqtg2719F
         Rs0XiRkByUbgGSw+b/r/E1LcuxztK3yocRjgEMHmaTnwsRH+MB6731mRqBWoD58Mn8
         JcxSGX59UPuGShfjKPMnu0B+ej7SR5m0Z0LiTnSWOET2pj9+C/OLcjt+U2pPya7H8T
         Du4NmR9mWYBMVNfBg21Tsxy4ACHXLh0nt+Bdrs9JdBavpoQ9OvHE+trVrfBv1FYNfO
         OXq0XlDOF/iOW0SeSjHavwMeZq//cZ5eyI6SAWOZ0Dx0GzyCPKA08YSjpKuocSEJRI
         uWuoi9tBxDZJw==
Date:   Wed, 20 Apr 2022 17:28:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Brian Norris <briannorris@chromium.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] regulator: core: Replace _regulator_enable_delay()
 with fsleep()
Message-ID: <YmA0vq3qkAEYGk03@sirena.org.uk>
References: <20220418141158.1.If0fc61a894f537b052ca41572aff098cf8e7e673@changeid>
 <20220418141158.2.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xg3llMBZ5/Gjbe9V"
Content-Disposition: inline
In-Reply-To: <20220418141158.2.I31ef0014c9597d53722ab513890f839f357fdfb3@changeid>
X-Cookie: Will it improve my CASH FLOW?
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xg3llMBZ5/Gjbe9V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 18, 2022 at 02:12:40PM -0700, Brian Norris wrote:

> One notable difference: fsleep() allows a usleep range of twice the
> requested amount instead of a fixed +100us.

Did the issue with the delay functions preferring delays on the higher
end of the allowed range get fixed?  That might be an issue for larger
usleep() values.

--xg3llMBZ5/Gjbe9V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJgNL0ACgkQJNaLcl1U
h9CEbwf+M2rLgFgi+K2TvPFPbmiAMpy0djbVk7VHPS51tdcFG+uy783yQ0RBocW6
lV4elYGh6jJ95Ep6KKaHO78WvZ/QYuwh/ns910EVLd+SixYFuI3BpfzYXl+KT5ys
aqdH6dC4jCN0okfRLyuM3GAixrq+OosBPEiAFyrvmK/qm+7XDAiG/cLkREKApUqW
4f9u9P3nkGm+96S2+/nBDxhby1UiCUsxQDNRSriqA5V6IE5dkSaQDjQqLAKf+C31
t3EVm6sXkMKH3j7MIq1FDXf5Rv7oKD7kerixBz7O2UZazQllM0L1HKn5w0ZTGQwI
le82AkEMe4q+d01QEOnjw1UKbjlnbw==
=NPxl
-----END PGP SIGNATURE-----

--xg3llMBZ5/Gjbe9V--
