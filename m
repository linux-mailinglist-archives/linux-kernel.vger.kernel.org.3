Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FEB4E742F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 14:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356486AbiCYN2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238689AbiCYN2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:28:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F56B996BC;
        Fri, 25 Mar 2022 06:26:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB605B827DE;
        Fri, 25 Mar 2022 13:26:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB19FC340E9;
        Fri, 25 Mar 2022 13:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648214815;
        bh=2O4KjMZTL33QugIf+tliTIk6QRAFlHVO1DwPuaXYgjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iWhdUiJT3cO4tkDilCRTug014BSnt0tWBrmkCHUs6+s7SMI56iLXDdcGHrmFmYtNK
         b89UpMUf/n15inNeJDa/B+7NOz/tJQe6+tITFiNjfMWGcoLwbdO1tcf7JL5tjtG1Zh
         fN+ddtA3G55ChApkBBLRiPkgdH0JuhhKj8a4p+Y5esA0VKeFt+pKZnyguVQ8ujWtB9
         GPXpm+rEkZ5p4xYrqVqxCngm5GEb8QSYK9QGR354X6Kw93kWealbxJ0u9BdfiolUgX
         8H+Jc1LmD/3YjKwBel6La0X88L73l52ObF8dz4fIgtVNwfw1tLcpUlGQbgVc03BDni
         jGDXIUey274gg==
Date:   Fri, 25 Mar 2022 13:26:51 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] spidev: Do not use atomic bit operations when
 allocating minor
Message-ID: <Yj3DG+d96RnZ25ON@sirena.org.uk>
References: <20220323140215.2568-1-andriy.shevchenko@linux.intel.com>
 <Yj25Mp2Ai0jKQtN3@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Cvp8K2FRsVv3wpDI"
Content-Disposition: inline
In-Reply-To: <Yj25Mp2Ai0jKQtN3@smile.fi.intel.com>
X-Cookie: Man and wife make one fool.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Cvp8K2FRsVv3wpDI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 25, 2022 at 02:44:34PM +0200, Andy Shevchenko wrote:
> On Wed, Mar 23, 2022 at 04:02:12PM +0200, Andy Shevchenko wrote:
> > There is no need to use atomic bit operations when allocating a minor
> > number since it's done under a mutex. Moreover, one of the operations
> > that is in use is non-atomic anyway.

> Shall I resend the series without this patch, or can you apply the rest
> if you have no comments / objections?

I've already queued the rest.

--Cvp8K2FRsVv3wpDI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmI9wxoACgkQJNaLcl1U
h9Dl0Qf/WstwE0V/nvE/sd/NW9ApQeVVeq2Y9Q9mlCciWPjJLAl45W8lULDJtkhr
4IJYIbQbaJDJbjEhV3820+XRwQgCx8ryhwYYNY4vkIdedsud/eCVypEH42UE/4NX
CfbgRUICR4zkgakc1hiPUEVDTRrrPKgLkVjlYQ4A1lc6Y1vFrR2uKTBmErwE5xzp
nq2qW4zSt/N2Wc3OuXp2t3W7pMUaYtH8C12Yhiq2Hgkusb2U2mue4vksk8tVh2F4
k+SIMyj9pUdcsRbI1BNwg1fwKW1eoTsBqY1tE1ggEOdVq7foi1uO3SuWraZHF0HM
YRPVzag9gui5soFh9qoZucs/TzT1AQ==
=ZaHe
-----END PGP SIGNATURE-----

--Cvp8K2FRsVv3wpDI--
