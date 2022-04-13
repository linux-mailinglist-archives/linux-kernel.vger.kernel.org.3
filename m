Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF764FF5C3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbiDMLfJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 07:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235183AbiDMLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 07:35:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D063059A68;
        Wed, 13 Apr 2022 04:32:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7CA43B82266;
        Wed, 13 Apr 2022 11:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94526C385A4;
        Wed, 13 Apr 2022 11:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649849561;
        bh=gzldEAhkSlGw2gr/JMOT8tx+AqRd92XMtLA3Z5OFrPs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DD9JvnckP0MTbU2i4YW0bWhjd2OZ9uHA/i1bElQpPeBXJ3hxkiIRmKAKxqRlN1pi3
         YDU2TD3JuY3+eTM6BABRIajBIWiAt2QJrCz3wR3DvO259kF/8489CADAT+R2HOL5sl
         UnT8WFT9FNCHfKHL5AQcWizn5yXdlpkq2VvLMs9eVhgIj7yOkpSdCjwQgr3yLTA/DE
         v33Df+BSou3aMyM07cGg2KorkA6ccBPro1DrCjIAe4JGg1D/Dcj4CqWn1zW2qnm6Rl
         Rkp5aduaqpycns0FRHwMtJImgExJZgAut6AscerkeLdkkkedDOHXC016MnrBJiGGKh
         8LIQRHprvd99w==
Date:   Wed, 13 Apr 2022 12:32:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        wells.lu@sunplus.com, lh.kuo@sunplus.com, nathan@kernel.org,
        trix@redhat.com
Subject: Re: [PATCH] spi: remove spin_lock_irq in the irq procress
Message-ID: <Yla01C6MJbaieIwR@sirena.org.uk>
References: <9e12d806c5554b4ed18c644f71f6662fcf0d0516.1649813822.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9OabIZ/xS33zCkIN"
Content-Disposition: inline
In-Reply-To: <9e12d806c5554b4ed18c644f71f6662fcf0d0516.1649813822.git.lhjeff911@gmail.com>
X-Cookie: The horror... the horror!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9OabIZ/xS33zCkIN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 13, 2022 at 09:38:00AM +0800, Li-hao Kuo wrote:
> - remove spin_lock_irq and spin_unlock_irq in the irq funciton

It looks like this is the only use of the lock so the variable can be
removed as well?

--9OabIZ/xS33zCkIN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJWtNMACgkQJNaLcl1U
h9DUwAf+J1KzKpnUBAYD2uKiRJjnSozJD1uSqKu5bnfpmx4Q4SSdRMAzWnUXk52U
+x6sXNL0xzKDOvYmp+hkarALktHLNasdIKApPgjpTGGtUZTHKkFQ3AuoMyvfIsp7
V9rrJDkqvOuTA3MVjXH9T+9PDJBtCZGMWGzifGGRc3tVj5KD5NyfEDyLHvAwfqt4
H0GMvmOoyQo292rUidkKE+By1fBMaXhRn2oJeDe/ALswJWrXUeHmimGRXzLyVVwF
IgEfPt9VKdZS3slBCZz3/30hpip1uh3nKX9rUORz7tAt97rZ0D/wBcSa4FgFByQB
KGepCQoMhPNcenyiKsjbF6U4uSjvCQ==
=QREO
-----END PGP SIGNATURE-----

--9OabIZ/xS33zCkIN--
