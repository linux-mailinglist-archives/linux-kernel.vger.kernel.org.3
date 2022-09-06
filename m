Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4578E5AF795
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiIFWCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIFWCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:02:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAC998A68;
        Tue,  6 Sep 2022 15:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5499BB81A6E;
        Tue,  6 Sep 2022 22:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF485C433D6;
        Tue,  6 Sep 2022 22:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662501720;
        bh=ylBcyli4K47L4sCG6iztFPiU4Pl14tn0xxsRkalII3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FTRbo0W5TPfFLldf29bpW/bQzzhpTMFTN6t9raF/Q1UZyBEKfTvroHaCXyaB/OK/o
         aKdOZynbt5QvcAbzQoRy8w5AI6oAz60GNnfS4Rmz8cvtssCBljhz/GeVqRD4n9xBUE
         vXmUGGe475nieEIH9k5gwkHVXkcXt76iR3S9OVG3AXBtI1VHcDH7WBEf3V5rFuElOM
         Su4jDsDZC2u2h1q/VGIOM4PaSr1+h43OMceF36+TbOCKVmIcJE+Ew5LdvlGEjBZOQ1
         fffcISiah0Sw0sM5xLE2mGg//5w5dAxKMFC5qhzXhNZO5PjcXYu+3xuLDhTyaHuvfI
         ei9XYUB1FWmjA==
Date:   Tue, 6 Sep 2022 23:01:55 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the arm64 tree
Message-ID: <YxfDU0oDU5510em9@sirena.org.uk>
References: <20220907033142.1fe410e2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="M0lV5QyiYzuG73Jd"
Content-Disposition: inline
In-Reply-To: <20220907033142.1fe410e2@canb.auug.org.au>
X-Cookie: divorce, n:
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--M0lV5QyiYzuG73Jd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 03:31:42AM +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> Commit
>=20
>   000aef672bf2 ("kselftest/arm64: Install signal handlers before output i=
n FP stress tests")
>=20
> is missing a Signed-off-by from its author.

Resent a version with the signoff added, sorry.

--M0lV5QyiYzuG73Jd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMXw1IACgkQJNaLcl1U
h9Cclgf+Kfj3Lfvi2bWVRrTYrTjxR4iq10k4v4hk5d1jRQ8Es9TTrX9PL2ksc1Jx
CqxRndrOKBgJPkZ+Tz7MLvGB381GJJ9/tw8Ku4tndIdxaML6hKA9kWQ3cq64bz8V
JxRFkE2/i2quiSUEFksIWtSnziDily1cwWCqnKStfjWAWN5LePGMP30s0uvUJD/i
f0GIgaDeAJxXHlPKY0+IIAVqVrFdLoePkd4V0cI6xGLDdZlRVSn3QfRQOCX+EnQw
pOH0UlIeQZxlXNRNsNlCcBnh6PXsGcv48kPGMUyNkM/S788H4HkQ27eTQ1wpi2mr
KnW/mOGmb1Ew5IX+iEL6MHaaI9psug==
=1CId
-----END PGP SIGNATURE-----

--M0lV5QyiYzuG73Jd--
