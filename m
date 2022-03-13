Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85EE4D74F6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 12:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiCMLXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 07:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiCMLXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:23:50 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A913972D1;
        Sun, 13 Mar 2022 04:22:42 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KGchs2rJXz4xL3;
        Sun, 13 Mar 2022 22:22:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647170557;
        bh=toQuUX0+1tbhGCs8uNeZK9bJs4Uo+89Is7lsSPHk7/o=;
        h=Date:From:To:Cc:Subject:From;
        b=tb8mjKi6f5Bl5+Gwhd1bpV3Iwa+gsyUcyDRlDjTNo21VI0So47EQiXlYItEH/3Doa
         aety7f9CnouVYZ65T80Dm5RV8zzLcrQH02xcQ3/jpTtiXt45130zEt+oaTDwrf/zzo
         xPS0sRagMvS0FVqXtGpe/uN+ie1Hxe59wRX1McNEXpU/FlOMgSVnPOA4ce2kuR41lb
         qNGqcoh3JOIA55fR1jioeOwz5iHYr3BDetQBEDMF8fU7/Zj14QDPBGY7JA4M42/hKd
         AmDF4hE4zwU/3C+4ILI2M5icGi+qDaSwSKaa2o289klw8LosiTjOmOVajbOzx0bFwy
         tMQhZhBt6RDnQ==
Date:   Sun, 13 Mar 2022 22:22:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the ext4 tree
Message-ID: <20220313222236.0115644c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Re4sorI9BGUs.O_SRwwseYJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Re4sorI9BGUs.O_SRwwseYJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  077d0c2c78df ("ext4: make mb_optimize_scan performance mount option work =
with extents")

Fixes tag

  Fixes: 196e402 (ext4: improve cr 0 / cr 1 group scanning)

has these problem(s):

  - SHA1 should be at least 12 digits long
    Can be fixed for the future by setting core.abbrev to 12 (or more)
    or (for git v2.11 or later) just making sure it is not set (or set
    to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/Re4sorI9BGUs.O_SRwwseYJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIt0/wACgkQAVBC80lX
0GzPIQf+Jc0Ewej4xMWZuFrsYBjXkqz+oA3C2qmzDUB+3KeSiEW7CBC3JT1L41A4
S17n+UDJAai8+5RyvSKRg8fQwL7TourtNVArjpDV5S76gxlirNc27m6SWdXKyHHc
94yyDRG90wpNGK3cN+Y3R7g9XnD0ieNh1BxQSak7Z54MAoivKnX41289adpAtpIu
p1n+h6T3mSxaIJHR+0oovnT7Dyb1oRH5YzyDktSlGiwajqF+a/t8NBlSqniRsrQf
/6ooJG7gqL1oerti6g2a7XBN0graZTzM1P0iFrrNR4mb+Zn8cUwhi6Iprm1v6roi
xYU6wFCsL3Jtsu8NpbBkwzZRix3LEA==
=8EqZ
-----END PGP SIGNATURE-----

--Sig_/Re4sorI9BGUs.O_SRwwseYJ--
