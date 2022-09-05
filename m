Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 492A45AD7BE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 18:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbiIEQnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbiIEQm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 12:42:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BCC61705
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 09:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C4966139D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 16:42:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F4FC433D6;
        Mon,  5 Sep 2022 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662396175;
        bh=ofMIlFd626hGnUnboJkZEEUtEXPdrkIL6ZPCOm2bYOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rpo8q0KBfj9SC5purKcAV+ErKFencFzGfWmknDo9og64dr2jBJegpm2rdeznXuq3g
         owtZQNlnD311DWhaS967QHhrXLDojjdgCB32jL4NWLEsApWt1z+Mgknpqz6E2DgTT5
         W71WSgccfp+AHKV/QZwccQv73T7IX6m2xhT+Gkp58EPf7VlNL98B0seSJiB4XvVRCI
         FrIGGF3HXw2VA4bqFZ4J5f5k8ufkEEcNEjgsJshC4tE5z37awXo0xxT3LU08jTRzU6
         zbmKEq8pMjb4rLC4mBraTuxus7i5p8WX+cIQTCg9fuw36cwgLBFNvetTtSE4uYJNQE
         lMDllkoy/kqww==
Date:   Mon, 5 Sep 2022 17:42:50 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Martin =?utf-8?Q?Povi=C5=A1er?= <povik+lin@cutebit.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, Stephen Kitt <steve@sk2.org>,
        raphael-xu@ti.com, alsa-devel@alsa-project.org, asyrus@ti.com,
        Charles Keepax <ckeepax@opensource.cirrus.com>, navada@ti.com,
        linux-kernel@vger.kernel.org, shenghao-ding@ti.com
Subject: Re: [PATCH 0/2] Untested TAS2562 power setting fixes
Message-ID: <YxYnCoWzCzMCGpEQ@sirena.org.uk>
References: <20220825142226.80929-1-povik+lin@cutebit.org>
 <166239232739.736206.17258746656389143736.b4-ty@kernel.org>
 <C600ACEB-C64F-4501-94E4-17B4FD0A8918@cutebit.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EoXYJhccnS9/KYaw"
Content-Disposition: inline
In-Reply-To: <C600ACEB-C64F-4501-94E4-17B4FD0A8918@cutebit.org>
X-Cookie: What's so funny?
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EoXYJhccnS9/KYaw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 05, 2022 at 05:45:09PM +0200, Martin Povi=C5=A1er wrote:

> Texas Instruments is shipping me samples of the affected
> codecs, so I should be able to test the changes on hardware soon.

> Should I find regressions, I will report back.

Ah, that's great news.

--EoXYJhccnS9/KYaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMWJwkACgkQJNaLcl1U
h9D33Af/QSb6Pe1owP1mrK1vVJUDtrHI6iUyUdFHPK24FwuUl4JkDGiHhWaaA0xn
kP24h+f3Kad02l5UM02y1IwVJipW7J7/VmPOrdi4evrNQ6qdXAeiEauHhAMsnRnO
9HGdCnqaGytdYK8Q01ZN0zuYq4QEOTIDCMXgWgwIjEPgPH4kdEe4KXeAjdn9ks+T
oIrequRljgRTyhoj1+s2J2Hj9Cm+KJXOJBlhxr3HkVWftWztKT+GP6MipBwXJcmk
2gf21m0YM7MRY1dWNZEEjeHLPUGl4f8QRikx2gRqbgV8uOS7YihpCs4vAclTZ2y8
Es3gD+1UVr5RTCVZyRFQXT5ZWXFU1w==
=4sYU
-----END PGP SIGNATURE-----

--EoXYJhccnS9/KYaw--
