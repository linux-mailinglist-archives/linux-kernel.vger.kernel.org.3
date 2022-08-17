Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1806C596688
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 03:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238081AbiHQBI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 21:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiHQBIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 21:08:54 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF8088DE9;
        Tue, 16 Aug 2022 18:08:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M6qf65dL5z4x1P;
        Wed, 17 Aug 2022 11:08:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660698528;
        bh=LUg/enxzkpqUwdu5NRFRjdbpN+QIjNkxosjH6GUlvB0=;
        h=Date:From:To:Cc:Subject:From;
        b=tC0D2NVixMDh1YGScBwc6a2ih9tplXBai56rzLH+RVkz0zt5ILrFyRwQ2jF2yjZ6b
         a69lzDHtzjYnVIUpINVLh9WSYTS/wGx+T9xCOW76RaK6Q96b2Q4bKAWt+FyKcRkLLC
         eC2KhGLq58DoGv41lkPrGbc3Cx+ICr38pEg1cje63UyVUF/TSA/foaOO9nbEVkKtMO
         sFZXy57uLff7SJg74bACWA6ty/jU2a15t/j5CD1w1k0kdh9Mrj0dWn5h39TDNR+xgY
         dixoWqJygVIr1vnpo9/cXr/MBd6YhbpZd/+QSFbYv+WOc0qr/fgiYSJz8H9ObT9B3r
         Q7CinQEWNsiVg==
Date:   Wed, 17 Aug 2022 11:08:45 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Lee Jones <lee@kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: linux-next: manual merge of the mfd tree with the i2c tree
Message-ID: <20220817110845.768796fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DRPU39zWXUo8_apUTt2Sg2m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DRPU39zWXUo8_apUTt2Sg2m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mfd tree got a conflict in:

  drivers/mfd/intel_soc_pmic_core.c

between commit:

  ed5c2f5fd10d ("i2c: Make remove callback return void")

from the i2c tree and commit:

  8a8cf3dc6419 ("mfd: intel_soc_pmic_crc: Merge Intel PMIC core to crc")

from the mfd tree.

I fixed it up (I removed the file and added the following merge fix patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

=46rom 9c5f9919c71c84b77d607e6a27b65c1c37462a3f Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 17 Aug 2022 10:12:19 +1000
Subject: [PATCH] mfd: fix up for "i2c: Make remove callback return void"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/mfd/intel_soc_pmic_crc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_crc.c b/drivers/mfd/intel_soc_pmic_=
crc.c
index 40f14a0c0790..b1548a933dc3 100644
--- a/drivers/mfd/intel_soc_pmic_crc.c
+++ b/drivers/mfd/intel_soc_pmic_crc.c
@@ -214,14 +214,12 @@ static int crystal_cove_i2c_probe(struct i2c_client *=
i2c)
 	return ret;
 }
=20
-static int crystal_cove_i2c_remove(struct i2c_client *i2c)
+static void crystal_cove_i2c_remove(struct i2c_client *i2c)
 {
 	/* remove crc-pwm lookup table */
 	pwm_remove_table(crc_pwm_lookup, ARRAY_SIZE(crc_pwm_lookup));
=20
 	mfd_remove_devices(&i2c->dev);
-
-	return 0;
 }
=20
 static void crystal_cove_shutdown(struct i2c_client *i2c)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/DRPU39zWXUo8_apUTt2Sg2m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL8P50ACgkQAVBC80lX
0Gzq4wf/QztN08zVCiShRljmxwW4rRNRYJqSHa6Txnc+3cePSDD8K4tDgZwFpsiC
aBKyw3EZoesuzHMab8b22Jg5qYGbBnRheGon+yp/URDsedVNgIS5e3Yh4CfGRG+N
rEYlf4B/B2MWSBGqrurU9rKsrKgQPLFur9Pog8X+ujnR7jybkkSr3V8IxXofg9AZ
Un3Lz4+wV2P5TYkiXDI4F/Hzq0xvYR5DxlThnkIms488z15+AnWRKmyY1oxl1cw7
bNtk6jgfcaeZzzPD88hMNRM4zm8fl/Wt+XEzDqK0ReRjDuWXP5EcT3kO9Y2+RgmU
QWEm8sHKX1BM7p73CmO2GX78CQQfgw==
=DZAc
-----END PGP SIGNATURE-----

--Sig_/DRPU39zWXUo8_apUTt2Sg2m--
