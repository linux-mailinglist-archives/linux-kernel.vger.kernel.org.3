Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3404750FC32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349642AbiDZLsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiDZLsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:48:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB31C263A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:45:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83BAE61847
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:45:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09CFC385AA;
        Tue, 26 Apr 2022 11:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650973523;
        bh=oGnsUIMIoXQAQAe3B5OwF3xVCc2n7+5xrTXnU2G1hQE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gyq1tQRoN9PHiU6UIjbUpIsfJCxJCt7Vq9fQr6BNNkGgSYotaIks6dsVcT4tW++tU
         O6tLUC9mK1Sv9Xz7Dk6eL6EXsz3uDOcXsRA0AjJGI2sfpr35cD394HmhK45mw6fWjG
         ayypx5dhezKzi1TwSAJgcu10DVhk+1DG4I4YlNh2d3QK5A/AIj4q7ZWjU0ISQtWcTb
         lxXCRUc4Yq5k1Lsiato7DUKIVDUdrEw/EWyVzb3ZgH+P4kKXxXU2gMOvj2tEi5t76Z
         UxvSQ8CmO1vnLtTHKPWDChErpR72bj4LKxPhB9nJOEyRk+UZYp3FGcmm5rcCzRJCuk
         BPzw5BvrvhZ8g==
Date:   Tue, 26 Apr 2022 12:45:18 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>,
        D Scott Phillips <scott@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/sme: Fix NULL check after kzalloc
Message-ID: <YmfbTkbk3IQrKwPK@sirena.org.uk>
References: <20220426113054.630983-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xJOjevB+s9JKXmbs"
Content-Disposition: inline
In-Reply-To: <20220426113054.630983-1-wanjiabing@vivo.com>
X-Cookie: I'm a Lisp variable -- bind me!
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xJOjevB+s9JKXmbs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 26, 2022 at 07:30:53PM +0800, Wan Jiabing wrote:
> Fix following coccicheck error:
> ./arch/arm64/kernel/process.c:322:2-23: alloc with no test, possible mode=
l on line 326
>=20
> Here should be dst->thread.sve_state.

Reviwed-by: Mark Brown <broonie@kernel.org>

--xJOjevB+s9JKXmbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJn200ACgkQJNaLcl1U
h9Aj7gf/WQu2rYZ+wRzlr/TJlc6w0hpHdo5EFx0qFWPTwmPwW66+aTbjNdB1uUzK
G0+xCWlSp4yeMpgTIV/S6+D+7ir08ix+dVmXpZ/knK8bDmqNqmwednk+gXppTluj
+5mwQdssFHIFC/DJKHVSjaddTA2Ys+NRF28bRf6mOsrRctQVMIsVqxd7zZh9zwl9
6ldEVoTbOU2IKQwBg8R1i1WvwOLQd3kzJVKFiNIWxAV88n5/6tTrUltZxBVs+sLI
RtMwMMEd6hag9Hvls3/WQjrMs8QV3QAMj2/3fJgxvM0WL4ttpdzkKiiF6D4SpZ4E
WlwaX68xuYcyjsWeRd9RTLreJE7ILQ==
=R+d/
-----END PGP SIGNATURE-----

--xJOjevB+s9JKXmbs--
