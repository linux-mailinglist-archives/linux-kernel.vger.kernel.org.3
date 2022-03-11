Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6803C4D6663
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349912AbiCKQeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234822AbiCKQeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:34:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DDC107D0A;
        Fri, 11 Mar 2022 08:33:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCF70B80EA4;
        Fri, 11 Mar 2022 16:33:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86A90C340E9;
        Fri, 11 Mar 2022 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647016388;
        bh=nXDTLmoC8BE8JKKBt3JG2w6GdigCA+dZrYuxemDr/RA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MF8AUhNJgIyAMKvB8bhzDjWZCsJ/dP3bDYqhk7WCBov07ZQLBkt6L9BlQYl8bIe1Q
         d4wiFcOmNf33i5oiQRJgWf/3lc2UvSnH3Bp2+c4IB97F9YQyaehHoHA3vxTFJ7ev+5
         RCDkV284k38yfSZzcmBI238YSLnNLeQviYfHBdivOpo4EICAlPCjURJKZHiNRvS4Cs
         dfv0zdAKQ2bilNkqFG22v+o1U6zLCTbIm1TKkv5fXswm49lIFuKBvIkmLft2NiqTiw
         zXfnn55BCca9PGALC+h5xpfcp1g4ntewrpzAdpwZTOxXuMHmMS2i4dvZcOlEMPIZoR
         Q5BixrLnOUd8Q==
Date:   Fri, 11 Mar 2022 16:33:03 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Steve Lee <steve.lee.analog@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryans.lee@maximintegrated.com
Subject: Re: [PATCH v2 1/2] ASoC: max98390: Add reset gpio control
Message-ID: <Yit5v+JkYDiWz0z0@sirena.org.uk>
References: <20220311132906.32292-1-steve.lee.analog@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apjVmizt8XulXsfJ"
Content-Disposition: inline
In-Reply-To: <20220311132906.32292-1-steve.lee.analog@gmail.com>
X-Cookie: The Moral Majority is neither.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--apjVmizt8XulXsfJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 11, 2022 at 10:29:05PM +0900, Steve Lee wrote:
>  Add reset gpio control to support RESET PIN connected to gpio.

This doesn't apply against current code, please check and resend.

--apjVmizt8XulXsfJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIreb4ACgkQJNaLcl1U
h9AYZQf9EamrxEyS8lwo4jJYqN1cJ9ICPCbndKpPkymTnb9WG+afnigV3k2hQAjQ
m1XlnL0pkJu1ICTu4vMwRrIQ2jHG7dn3jLkEqMbzKwgBn4nyCLjijoeUwwPJDZLo
eI40VY3F5EnHz5I3bWCZD3N/aSYS3ZrGAbYLTZaYLOqOTrm4aatzY1Roz+hhVpgT
qwUQhy5tyXZtNEQDG2i9A7yGZdDgPQtaCdjwipk3ER72rQbcpmvrQE89fqCf9R0h
f6sc7V2m+LUSmswOLqNHPapOtRlwQZC2frn/DSwMcr9rBiOfc0i1Ut1wVNfY2Jx+
eYToDX/nA/2tpmVyALEA31UdBKN7/Q==
=okX0
-----END PGP SIGNATURE-----

--apjVmizt8XulXsfJ--
