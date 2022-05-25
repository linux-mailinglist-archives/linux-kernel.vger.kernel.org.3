Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8B53467A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237925AbiEYW3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiEYW27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:28:59 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A3FAA;
        Wed, 25 May 2022 15:28:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L7m1v2f7Zz4xXF;
        Thu, 26 May 2022 08:28:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653517735;
        bh=8sw0EjH/yh4w8LPwC3xKzJioRAkW2JnXa+cOOSbYv8A=;
        h=Date:From:To:Cc:Subject:From;
        b=YS23RNjAFEhnRbC2Gs4ktZ9kqVe6AyQABs6s/Odf8T1LL01Ic4hVqggyYVpjtzMKT
         JeWB54NhvyXI9JUUwSeBjzyjve8IBXuRTE+CCSkkG9sJdAV8p4rq0cUW/lvrCNoCGx
         EcHiYW5I1SXU1DLEHycSYptOkJm2FMqe4Hc1u8g47XE0ZiTPAhyUwxvYr6fSRDHt/k
         oEegGexvojEzEoG3bs6dxw0lje4AjsmDyztHrePGzX8FyLxezanmeFzuvpNXyS1Y8b
         4WiBYL+Sv9DWt68UhVOkgDhJfrhUl79cYaoTZbiIUhHy48THFZCvQMCHO3A89riYzY
         1nAeoOlBBVGog==
Date:   Thu, 26 May 2022 08:28:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20220526082850.5869472e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ghwb6o.H_z6TVvxam3=ChPf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ghwb6o.H_z6TVvxam3=ChPf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  e281c26b08b3 ("Merge branch into tip/master: 'perf/urgent'")

is missing a Signed-off-by from its author.

And for some reason, it is not actually a merge commit.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ghwb6o.H_z6TVvxam3=ChPf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKOraIACgkQAVBC80lX
0Gwo+gf/a4W3BDP7/Z3HDm2zxFuQacYEQhi/oCth/qOLtYzyM9kUyOrywhixabIo
bn3VXYztL3vs4uTPp6F3hME0ZdLvzP0hX3H5cC/91qk19MWKwgVl60DFVZCuAjah
lsypWxq1tDNqxKMPfjNcAmQP8NqtCPCRriWniAwCMGm9Z86C996mWGuBrKJdp81h
Ayip/HywEb3KoO7yUbNsBUWaTnJJ5mnAkvQHEcEwnMlXzSscNP46G35sSAzZm4qZ
UUXViqlm/unl8W/iiiwXIuA4oKamaGKJ6N6kDR2VR48DSSjadXpFsuIpEbgcQZ4+
Y//tKALafcnyRqSmcUk7Ms9j3J/jqw==
=63zc
-----END PGP SIGNATURE-----

--Sig_/Ghwb6o.H_z6TVvxam3=ChPf--
