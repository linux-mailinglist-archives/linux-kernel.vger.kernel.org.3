Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 900E34D6773
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbiCKRUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350760AbiCKRUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:20:04 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5B81598C2;
        Fri, 11 Mar 2022 09:18:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KFXhs2gKCz4xL3;
        Sat, 12 Mar 2022 04:18:52 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647019133;
        bh=oqjwnwRWhuANBJmThAq3eEqUlQPU3crzj0pRuzJuh+E=;
        h=Date:From:To:Cc:Subject:From;
        b=PqvKncMeSAwXIf5GyLHrq9j6QZA8T0UnTpaJev/XW4gsKNW3YrmBsWXd8Ern78g1w
         M7aEnOYxnsJoy70p9rN25CjTPfGg/AX09JSuQ3QhA72VAcXb3HMB9SPeM6q3dsVYlX
         tb9he0hMKQkvz/3NxzbGCNTIvKa/pXjgpiWzBp5Nm+jZ2QhMLUIysnIicEo+3EQ3TF
         1OE2zzlMb3VIrisUV60/2MqlYnwZSw6tiEHBzL4HKXlzAW2GDu1ECyFFvn/vohDpCK
         19B+dVzu1cXuLES/0lILfr0eW68Qq6lqHzmVN/3e4a4G2wGAwdEDiIGeETfi+480h5
         cHw6cPLGns0/g==
Date:   Sat, 12 Mar 2022 04:18:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Richard Weinberger <richard@nod.at>
Cc:     David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the uml tree
Message-ID: <20220312041851.08e54e01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/LL3=sGF+6cVeAcrM2PpWEdP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/LL3=sGF+6cVeAcrM2PpWEdP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  6580c5c18fb3 ("um: clang: Strip out -mno-global-merge from USER_CFLAGS")

Fixes tag

  Fixes: 744814d2fa ("um: Allow builds with Clang")

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed for the future by setting core.abbrev to 12 (or more)
    or (for git v2.11 or later) just making sure it is not set (or set to
    "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/LL3=sGF+6cVeAcrM2PpWEdP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIrhHsACgkQAVBC80lX
0Gz+4wf/TZXZSii4gK6MshHRF/J7uR4j+0kZCq0mdvhxPhlovE1a6mYzyDK8VGP8
QMApwPW2yU6YtAJjIzR4CSFJFhK5u/OmDxoBaRTlxiu0LhXiYkeB86YlyDFYnyWJ
mm1mw2+0Oa/7s+GMbgXNj2TO8EOOGSAvUjJsIcrb51BeQ9neDsZBmj6Osb6BArpy
FrGc+Hsfguf9lLmjvkQgIGUHatgb9yP55Ibj4qtwUlVgKt001GpI82MFQb+MttTN
AlFCaMshCBpECYHxd/jK1cNc99BqX4JuzCaazf3/pUQ0QX3Z5AFf1kG/f8U31jXk
oNtC8PsaChsNvnphhOsnKw77mAaO0w==
=nJd1
-----END PGP SIGNATURE-----

--Sig_/LL3=sGF+6cVeAcrM2PpWEdP--
