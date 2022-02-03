Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57DEC4A831C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 12:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350207AbiBCL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 06:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238011AbiBCL2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 06:28:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DC4C061714;
        Thu,  3 Feb 2022 03:28:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEA19B8339D;
        Thu,  3 Feb 2022 11:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDEFC340E4;
        Thu,  3 Feb 2022 11:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643887715;
        bh=COBWLwcvaTKIWzrOUANpuFO9WSzhU9FhS0VUHIshlV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KX4egKwcJHnFYFMcluZjjHnbkdk1/gVrGHQHLahtyR3oV2gFSQSskLLiR6xgRoy8Z
         X+nA7fl5bITNU3brrXT7HvyrL/ncs1/2xOwr8EGf+Dzy7k228bLkzWaFqCOnNMBVQQ
         vZUIMXUQLdDmL33jTUg7cCn2NWMi7xB6UGyG/T7Sdt7aJ6mKK9Sd/b1FK5FWzvgq+Y
         mY3stX9tHGzc/whzQfnKrFQRfG2J0sy/ac4u2qfBlStBpkhan8sCw5zEMKx6KG7cen
         pBN9KQtNRULx9zjr+Y9pJ18U6Ea+9NaM1HUaSa7Cdv6AIklINZUrgfDvCysGm/bPsv
         WElpX3oY6h8Cg==
Date:   Thu, 3 Feb 2022 11:28:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
Subject: Re: [RESEND PATCH 1/2] dt-bindings: firmware: arm,scmi: define
 support for name based regulators
Message-ID: <Yfu8XulvWQbpQoBR@sirena.org.uk>
References: <cover.1643069954.git.quic_collinsd@quicinc.com>
 <fcd130891cc1d52cb09b8bfc866ab7ef1ce3b2a1.1643069954.git.quic_collinsd@quicinc.com>
 <YfREsxeSSX2pbALf@sirena.org.uk>
 <8355035c-6d90-adfd-c4e1-7bb37a2d8055@quicinc.com>
 <YfrBharI91QYkPR1@sirena.org.uk>
 <532aa931-2471-8fb3-0db4-7ab8a60333e8@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FHEHOoLIGiZXymy0"
Content-Disposition: inline
In-Reply-To: <532aa931-2471-8fb3-0db4-7ab8a60333e8@quicinc.com>
X-Cookie: Prices higher in Alaska and Hawaii.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FHEHOoLIGiZXymy0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 02, 2022 at 04:09:43PM -0800, David Collins wrote:
> On 2/2/22 9:38 AM, Mark Brown wrote:

> > This seems like a scenario where the DT should be being generated at
> > runtime along with the virtualisation of the platform?  TBH a setup
> > where this is an issue feels like it's asking for trouble.

> I'm not familiar with runtime device tree generation.  Could you please
> point to an example of it or documentation for it?  How would this
> handle kernel devices on the VM side which need a phandle to an
> scmi-regulator DT subnode in order to get a pointer to the corresponding
> regulator device at runtime via devm_regulator_get()?

I believe qemu does this for the virt machine.  I'm not sure what you're
seeing as particularly complex about generating regulator links in
particular though?

--FHEHOoLIGiZXymy0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH7vF0ACgkQJNaLcl1U
h9DDlQf/YzYI3j06uft9Q3I/6yHQsgA1u1k5QKi5P1/6CCVe1u9jdfsaqOkfERqv
9ccQrebFf9XObnh7/UjdJmQn9+QrDN9iWRah/6relqDKvVBZY8dtsRVhPNnDhr9w
U+GBwujVRrY/F6mVxK2wst8PqsWlxpf8BC12NY52c7fKgF8cm54mEUVNpIBrAGun
9eGAl5GqqfFw0a1FlS3eCzDUmv1ptqI+DWXanrUQLhLejUpfiVwLxQmFqXkOitL5
6uH+oZ8/xYYOHS37NK4nXzVY+uonIvw5AghpXC0c3cGHGqHjTGE6AVlDfkG+9jGW
leW8W1h5fAeK60ebJ7sOibX+OoIU/w==
=xs8h
-----END PGP SIGNATURE-----

--FHEHOoLIGiZXymy0--
