Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A413D4A00E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 20:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350976AbiA1TcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 14:32:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41356 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350963AbiA1TcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 14:32:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5CE3B81CA6;
        Fri, 28 Jan 2022 19:32:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A55C340E7;
        Fri, 28 Jan 2022 19:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643398328;
        bh=ocTfvDJr4Az4Cqx+uznqAIEN6JNDdsu/e4U8+fXMP2Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fLyox+J5RBcTXAqWg40ECApbugLOt8XLIw+Lge3vN6ygd+erfvHm1mSRpypHS98zj
         77IHDcD6lkQoKS68XVtseIeW+yPXKrpLUQxDCEbxDrkMgblEJRQTnOrqJLf6LPcUgG
         A9zqTOze1Ph8nZMINIk7zzv7fq+O9Y83876t10p7nu1ibKVpusgol7jpjW3Z6HAdXg
         TlfXqdyglouGZGnLmm3F85ZDSU35+hPPQtc0dFm4Z6mGL2xqdh19U5XplYqxMeGpIx
         uXRMc79ZZZTHB71J5z3/KLT8RWAVxYyVJoZ/pqkXCq7f4r66kCUc+PlZ3Iuv740l/s
         KbqXWw1r9K6Jw==
Date:   Fri, 28 Jan 2022 19:32:03 +0000
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
Message-ID: <YfREsxeSSX2pbALf@sirena.org.uk>
References: <cover.1643069954.git.quic_collinsd@quicinc.com>
 <fcd130891cc1d52cb09b8bfc866ab7ef1ce3b2a1.1643069954.git.quic_collinsd@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="saTo/Nt6xCfZVkU9"
Content-Disposition: inline
In-Reply-To: <fcd130891cc1d52cb09b8bfc866ab7ef1ce3b2a1.1643069954.git.quic_collinsd@quicinc.com>
X-Cookie: Torque is cheap.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--saTo/Nt6xCfZVkU9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 24, 2022 at 04:27:35PM -0800, David Collins wrote:

> Name based SCMI regulator specification helps ensure that an SCMI
> agent doesn't need to be aware of the numbering scheme used for

What is a "SCMI agent" in this context?  This is changing how the DT
bindings are specified, at some point things are going to need to be
hard coded.

> +              regulator-name: true
> +
> +            anyOf:
> +              - required:
> +                  - reg
> +              - required:
> +                  - regulator-name

This is abusing the existing regulator-name property which is there to
allow a human readable descriptive string to be attached to a regulator.
It should have no effect other than being included in diagnostic output.

--saTo/Nt6xCfZVkU9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmH0RLIACgkQJNaLcl1U
h9C29Af+M8xJw3Zj3s5s/7+hQVGfdxlKUfEUacHNcXCVYIufDwCB14Yxr+x2nOCP
5SGj/GWXK8LaPBktM5PQBdiIKWGMjFTdQF0I2QcSUJ6rKmthttUs36u2/x80b6Hp
g+g1Gd4qZKgC9f73doy5tIA/NUmSX5RHpAQ2CG8a0BAYfxqK7lsGxfcE9bjyBHVI
YPBxVn47on7lD63G94aSa46nBWx20oLFBZYPJdtMdnFOFmEAo1KXzAEsYOMA4CU/
1ru2Rmc0FGlnDQbkaEORDiOwOz6Ae1EuoU5ABhlgnWy2v+VPLAwYEbtKEDkd7bzc
kXyAmCkb5GT3LmVU7pnqG9RVgnNf3w==
=Z21V
-----END PGP SIGNATURE-----

--saTo/Nt6xCfZVkU9--
