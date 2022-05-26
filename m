Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B3453492A
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 05:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344404AbiEZDCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 23:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbiEZDCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 23:02:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B30A5006;
        Wed, 25 May 2022 20:02:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L7t5d4YdFz4xD7;
        Thu, 26 May 2022 13:02:29 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653534152;
        bh=Y1CWBrTGeBug7/NRRfM5Ch83WIwakEjgYsahfyMDPPA=;
        h=Date:From:To:Cc:Subject:From;
        b=pFawtkQGTV/y66bZ1SLwz7dvat11iqg5B3nFfUnA7VlvTtEIEepq0OddtFxpVlnlT
         b+igWxlpbqp6BLl0MtrL0iHWNJ/s5Dt4MgMXxW/ryFaR7oUQE8PBnpsS/YZqIA5teY
         vksqUXUChZsCqXd2zTAP4PU93HJukWh2DxoXz/pAo9PHWz0cvfT+6puSHIE/vImws+
         7bBl3m1xp/3mqPH9uFy0iy9YlKoStfMxXjnpEnzHhuPsHeXtkGk91IhkUXwbD44nJZ
         +ce7LKc2TJrIpsEAhmI1xfTnotIz7jBGNNxfETOrv7cw/gtGHWHB0Z9rBVFwiTVR+e
         kGkpy5E62rKwA==
Date:   Thu, 26 May 2022 13:02:28 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul@pwsan.com>
Cc:     Guo Ren <guoren@kernel.org>, Guo Ren <guoren@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: linux-next: manual merge of the tip tree with the risc-v tree
Message-ID: <20220526130228.332e59a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ugnS0S/C+hwX6FgrZ2SYL2n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ugnS0S/C+hwX6FgrZ2SYL2n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/Kconfig

between commit:

  0cbed0ee1dbc ("arch: Add SYSVIPC_COMPAT for all architectures")

from the risc-v tree and commit:

  758cd94a0e16 ("x86/Kconfig: Fix indentation and add endif comments to arc=
h/x86/Kconfig")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/Kconfig
index 98eaa8870f28,4d610ae216ce..000000000000
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@@ -2869,7 -2861,11 +2867,7 @@@ config COMPA
  if COMPAT
  config COMPAT_FOR_U64_ALIGNMENT
  	def_bool y
- endif
 -
 -config SYSVIPC_COMPAT
 -	def_bool y
 -	depends on SYSVIPC
+ endif # COMPAT
 =20
  endmenu
 =20

--Sig_/ugnS0S/C+hwX6FgrZ2SYL2n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKO7cQACgkQAVBC80lX
0GwVhwf+Ih7Sk6dvVrNDkZ7ishMucMzwdtmcwP6ICHXD8UlB9O5HDnf94gmVl9cK
sDLJE0Axx2kShnpXl2k9K1xBywQzDkEKH5oMJPyKDJTgDNMez68NP+hZQ08iiSdk
mHu957rSMzAHIgErtOTCV60aig2QyL3d6A0/JuuWqHeDbRt9OrY6DE2TYskhvCQk
bOBO4XMqkYEILzAE1Dv09hgKXMdGyoGwhk2S1xSW4CHdbHxMdye8NN3khwLVaUmG
C05VuJmkqQUJNfKJA5Ql5l0e4R+XFjT4VpPtGt1utOpubeUh7ljSZc6OMMu/9rZG
J5GPOX4cGdOuRkOSbJ8g99vTbxjBMw==
=nVH8
-----END PGP SIGNATURE-----

--Sig_/ugnS0S/C+hwX6FgrZ2SYL2n--
