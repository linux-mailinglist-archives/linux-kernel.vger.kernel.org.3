Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BED5168C0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 00:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377946AbiEAWps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 18:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiEAWpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 18:45:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BDD138BC7;
        Sun,  1 May 2022 15:42:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ks1SS5Gcrz4xLS;
        Mon,  2 May 2022 08:42:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651444937;
        bh=Ja6QUs7OnhdZ/iA7yTkwhQXIGgTj/2x9XaqehBvIwr8=;
        h=Date:From:To:Cc:Subject:From;
        b=CfL1Ba6iSDshGnfiPKOuVBthhnXSbv+veZ7znQxiqhEIqQ1vayzYY+A0zOm/gAVW5
         rhs2L0ndwqXCQQkrNc2tcMnzOx3/rMvEGj2yAui5WeOHRdUt/cUYOM3Y3Bomlo0Z2W
         sOx/NZ6Im3Q78b4iTITVQgdgRmJgaHBCcyiyVvFpeqiBZye+l1fcCwgeEN+NE8eQmH
         NlT2QavElwDMNQfDs8wwKTXiMv1grqetOT6zjnsUOU2G2zaA2S1wOhOTW4GjCAEJiY
         SNRi5qjwJcRVXIKZnX3w93xHfjE05v7s/LG8ARUvW92z80GsClA+PkOVl0y+D+J8J1
         M/Qj1UMFJfkUg==
Date:   Mon, 2 May 2022 08:42:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm tree
Message-ID: <20220502084215.22650230@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5ao83D5c4YM5zRVZjz9o.2.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5ao83D5c4YM5zRVZjz9o.2.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  e7855117de91 ("drm/msm/dp: stop event kernel thread when DP unbind")

Fixes tag

  Fixes: e91e3065a806 ("drm/msm/dp: Add DP compliance tests on Snapdragon C=
hipsets")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 8ede2ecc3e5e ("drm/msm/dp: Add DP compliance tests on Snapdragon Chi=
psets")

--=20
Cheers,
Stephen Rothwell

--Sig_/5ao83D5c4YM5zRVZjz9o.2.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvDMcACgkQAVBC80lX
0Gz5qQf/d/DCzVAzm4PFEUzW1Ps6hUYn+M7a8VbGbJyIiczaY4XVUaetO/1/xT7G
6w9RdxyW55aQOjuTV1Jk6ot9vbmiRSKY7fZA64K0Qc06u+yK9lhinBxJOO/dPwYJ
uhiBRdH8lZ6DQ3b3G5MkPjmN0qFs81CRLt+962BRNVsD2eSXPT9L9zUFBj3c+aOr
eFy8lrUHa621jhuJMUboREEU6a+xl+k5xM7auGAHvyQOISkyAi1modnbgNVah3e7
vNfkKMnUsfJNpxnNWc/PhEcSAexuh5VENJ6/BrU2ofHyVhoSnk29oxFjMMPEwYMH
SUbdDvzQll825MeJtKBdYTkpJWc1XQ==
=LCrB
-----END PGP SIGNATURE-----

--Sig_/5ao83D5c4YM5zRVZjz9o.2.--
