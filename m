Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9330E5A75C9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiHaFhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiHaFhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:37:47 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F170B958A;
        Tue, 30 Aug 2022 22:37:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHXxz2xM6z4xGC;
        Wed, 31 Aug 2022 15:37:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661924263;
        bh=/aRn66M5U0K60iEcrvctLIfyDnWQ5Pco7UJCHiMCAd4=;
        h=Date:From:To:Cc:Subject:From;
        b=Z3dPJkBJv3j7BVrcxyiMOM/dvD6/cm+hQmpeXbuAa3VVXfwZoSTe7UVTGftfoz1Xj
         TuX4elyrP/kXrOzGsDr5sFdUWffVFWfwOVsP4FhlpAKRgBy/c9uU6qvhpNf8mC162Y
         KqmGjuERJiv80K4xYaGIqOmp8oE5Oh7KtfVw3TWa1Xqex+AzAFvDfNc42g1YNZb611
         W0tQAmEaoy0tRxuXYDcvE94GN2zIckeswcuMyG/1rwaEoq1JNxnKHLJYugE2LL6S0X
         DT/7kCM2XO7mh2IP3PTbDbAfR0afbtsRTPslgHoetJVIY/2duzt7sPLFYDB5rDJUtV
         qvfZOuwLYFbFg==
Date:   Wed, 31 Aug 2022 15:37:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Michael Strauss <michael.strauss@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the amdgpu tree
Message-ID: <20220831153742.48e0289b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/UT/_47Srhp+f.58u.a08D=4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/UT/_47Srhp+f.58u.a08D=4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the amdgpu tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/amd/display/dc/dc.h:848: warning: Function parameter or mem=
ber 'lttpr_mode_override' not described in 'dc_debug_options'

Introduced by commit

  280f1884892f ("drm/amd/display: Add DC debug option to force LTTPR mode")

--=20
Cheers,
Stephen Rothwell

--Sig_/UT/_47Srhp+f.58u.a08D=4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMO86YACgkQAVBC80lX
0GzjXgf/edcRuoP5x1NaiNaLqn+mvCOJZJPhkDv8o1Kt3iArcNdATsVcd1zLGzpg
p96plhE81RaT6nZZMsSUVbpW5BHBtzGIUrnRHdFIG4OJ2JBP34arySIvP0YuxjY7
ojwSXflSeo6gAUzfQGoLXuw4Dbvux1AqVY1engENpgZXbTFWCvCGX+26oyJhDcKt
u8jCIRUi/zkldm1/tnMiq6zaWqf410sy3jVtla/HijLr1qFPnP9yTtT7uzbEpBHw
nT0Oc9BJojgupZcZ3genBwVez2FMoRavE7TA82ZjJakX7/UQIopqvvPQpczhChrY
aBdqKpskD9lB8JEg8+CNW1am9ZNMwA==
=IlM1
-----END PGP SIGNATURE-----

--Sig_/UT/_47Srhp+f.58u.a08D=4--
