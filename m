Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5064CB505
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 03:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiCCCdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 21:33:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiCCCcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:32:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4143CA5A;
        Wed,  2 Mar 2022 18:32:10 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K8FPJ2wJTz4xRC;
        Thu,  3 Mar 2022 13:32:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646274725;
        bh=BtP6UcMsv6oDy+Kn6DtzLdHSBoNDVzYuLa4Bl1UTeWA=;
        h=Date:From:To:Cc:Subject:From;
        b=MppquPChkI8IeI+pXa3gguRcu/gNNu9SPIvfmijcV8rCnrCAE2I36W0ooBvkqmelm
         XZuHhfaanRAgECO7F1y0K2XD8m5mWUZtXtrIzqPy8DDYUfsAZHAR+wS0hA86FJqxN9
         L0ZtXUAudUg49Av+dskehjQ5QKwCMGdvAIj9WQDfokNarHqjjfwDfTDllICuYUqaGj
         X4A4znTMlLLbGAGfqmrE8qv/Edw+NU7dt0N8jvv/jKLvODfBPq0UdH6QM6Rj6NgxcH
         0J3Vm/7pF/eZsRQWzitEOLqOj8DKqBLcUhbiB97jCqmMShP84FXs9i6lzMvDrU4/lH
         UIU9wumiy1fKA==
Date:   Thu, 3 Mar 2022 13:32:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: linux-next: manual merge of the drivers-x86 tree with the pm tree
Message-ID: <20220303133201.37e454b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1svrzret69_ESx0Qstfv7QT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1svrzret69_ESx0Qstfv7QT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drivers-x86 tree got a conflict in:

  MAINTAINERS

between commit:

  895519c19fae ("MAINTAINERS: Add additional file to uncore frequency contr=
ol")

from the pm tree and commit:

  ce2645c458b5 ("platform/x86/intel/uncore-freq: Move to uncore-frequency f=
older")

from the drivers-x86 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc MAINTAINERS
index cc2b69c7bb58,a419a6938786..000000000000
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@@ -9957,8 -9918,7 +9972,8 @@@ INTEL UNCORE FREQUENCY CONTRO
  M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
  L:	platform-driver-x86@vger.kernel.org
  S:	Maintained
 +F:	Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
- F:	drivers/platform/x86/intel/uncore-frequency.c
+ F:	drivers/platform/x86/intel/uncore-frequency/
 =20
  INTEL VENDOR SPECIFIC EXTENDED CAPABILITIES DRIVER
  M:	David E. Box <david.e.box@linux.intel.com>

--Sig_/1svrzret69_ESx0Qstfv7QT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIgKKEACgkQAVBC80lX
0GydXggAhqpRFUa/rBbJHf33QQ/JulXaZAORUWSeA+hAZVH4eTsTwOiA6JuXiCPr
PQUhbzniG54t8YI1VDvSQ6/94IiwCasPR7gjeOdzJxEwhRlWdIu0woWi4X4Zq7lO
Tx5q44ZTv4rZc+BLOU6FqxA9FV/ixiWLwmZTiHHZBdgkN83JZQeGFRU9ybWAHQBQ
OOBQMTidZB7lmCgtfGgb4Zw6DIc5mmWSshvYh7Z07J4c3QDb9X1E4CopqVsGYbdG
D52jvj5l+lUPN6V1lqZ5j7nrTscWoaEZwzU+3ziM7qGVs/pAbqT298zCPO12JIPc
xKwhhVGe3JCYAz3udBhEFp7nhaDxWw==
=UsqD
-----END PGP SIGNATURE-----

--Sig_/1svrzret69_ESx0Qstfv7QT--
