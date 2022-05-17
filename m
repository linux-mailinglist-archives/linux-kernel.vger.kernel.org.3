Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253A65296B2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiEQB0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238028AbiEQB0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:26:14 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A259DE76;
        Mon, 16 May 2022 18:26:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L2JNY3nGxz4xXg;
        Tue, 17 May 2022 11:26:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652750767;
        bh=tkYVY8vY6gNXvhNcIMOR3JtLqVvtFEVE1/mN6wPOWUk=;
        h=Date:From:To:Cc:Subject:From;
        b=ZZgzEDLQnaf6r4fxEK2XvXqQ9ILLumgcUyDX9pffXKhjln/3/aaj90oI3dRgDBxzW
         c5wEPkPDRhP8maNZ+ddWJWAiHp1rXv+/sSGttzZi2NzSBcZGG1w3axvTKTGoD8vvVY
         K2Z2vtcjeqVloNTt0ncz3YJ6uAtmMmJ49DSDUzNftop/FbivS/WA//rpy9HvPIrOKu
         UBynFeylLQeoufORqJbWAZaT/SdE46o+qcLVE1RSNkNl2cN9DoRBK/vqgTwZ2TvVIH
         ClbERCLO7pnDZCUNcCRPl5FiGbhyyID2jeRMGlEVmuzfTeOMxnuPPThI8OpbRaCGZT
         3TmIiw7pyvH+A==
Date:   Tue, 17 May 2022 11:26:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: linux-next: manual merge of the drm tree with the drm-intel-fixes
 tree
Message-ID: <20220517112600.7d8d63b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/71OL0cAFBGAD+j4wVZ5FF=6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/71OL0cAFBGAD+j4wVZ5FF=6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/i915/i915_reg.h

between commit:

  54395a33718a ("drm/i915/dmc: Add MMIO range restrictions")

from the drm-intel-fixes tree and commit:

  9c67d9e84c7d ("drm/i915/dmc: split out dmc registers to a separate file")

from the drm tree.

I fixed it up (I used the latter version of this file and applied the
following patch) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 17 May 2022 11:19:42 +1000
Subject: [PATCH] fi up for "drm/i915/dmc: Add MMIO range restrictions"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/gpu/drm/i915/display/intel_dmc_regs.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_dmc_regs.h b/drivers/gpu/dr=
m/i915/display/intel_dmc_regs.h
index d65e698832eb..7853827988d4 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_dmc_regs.h
@@ -17,6 +17,22 @@
 #define DMC_LAST_WRITE_VALUE	0xc003b400
 #define DMC_MMIO_START_RANGE	0x80000
 #define DMC_MMIO_END_RANGE	0x8FFFF
+#define DMC_V1_MMIO_START_RANGE	0x80000
+#define TGL_MAIN_MMIO_START	0x8F000
+#define TGL_MAIN_MMIO_END	0x8FFFF
+#define _TGL_PIPEA_MMIO_START	0x92000
+#define _TGL_PIPEA_MMIO_END	0x93FFF
+#define _TGL_PIPEB_MMIO_START	0x96000
+#define _TGL_PIPEB_MMIO_END	0x97FFF
+#define ADLP_PIPE_MMIO_START	0x5F000
+#define ADLP_PIPE_MMIO_END	0x5FFFF
+
+#define TGL_PIPE_MMIO_START(dmc_id)	_PICK_EVEN(((dmc_id) - 1), _TGL_PIPEA_=
MMIO_START,\
+						_TGL_PIPEB_MMIO_START)
+
+#define TGL_PIPE_MMIO_END(dmc_id)	_PICK_EVEN(((dmc_id) - 1), _TGL_PIPEA_MM=
IO_END,\
+						_TGL_PIPEB_MMIO_END)
+
 #define SKL_DMC_DC3_DC5_COUNT	_MMIO(0x80030)
 #define SKL_DMC_DC5_DC6_COUNT	_MMIO(0x8002C)
 #define BXT_DMC_DC3_DC5_COUNT	_MMIO(0x80038)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/71OL0cAFBGAD+j4wVZ5FF=6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKC+agACgkQAVBC80lX
0GzKtwf+LSwY5OtuMW6tK+yxiDnG2ucVOlHcikXV0ch51Xi4IGTCtw1uqL3mbGY1
DYzhbJCDfR0zlV4Xh5AVmr9VRG8OHILN2I756HHlk9DO41GJNborf7XDrRZq+qiC
LwXk5NXIOY0G5jqoPLWdbEpgHl4k4+UsVwgK/cdXVYfHUGxCzoTbtgqqDWUO0hZF
a1fH/hv1AbkfQOA13OSL+zqqg6N0iynToEM6d3NPhZJ0Smq+uNfayT+Krkp1sYId
+pES0iewe5qwnbeExW9EQB29v/gFCMjkJcXP2WDP/HYD0KUdtJJK7qMsUdH19XCa
2LieLtxlv7wUjQ8gNcWv8WFV18HD8w==
=rdvW
-----END PGP SIGNATURE-----

--Sig_/71OL0cAFBGAD+j4wVZ5FF=6--
