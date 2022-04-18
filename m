Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11393505EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 22:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347813AbiDRUxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 16:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiDRUxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 16:53:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D1E22BCB;
        Mon, 18 Apr 2022 13:50:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KhzbR5Ytqz4xR1;
        Tue, 19 Apr 2022 06:50:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650315028;
        bh=SS5Cca4Z8dJ5+9PU174i07hmpYDNtbxInWUQuq4jRLw=;
        h=Date:From:To:Cc:Subject:From;
        b=FzVjx1M9Kc9v0WYugrCOQ9SE5n/ZcTM6qRmQBUKrU9OuL9Q+ACFy2VALCSuOY9IZo
         FutFeC3rEYSWPaoWNR1XRNhjQVt7uVf2SB80JAoWe4xgxvNMzce4Wmzlr/+cS8l4KQ
         rNkvdJBTDTlIIqH3wnZaB7L0QNfR3FJn4BZGMdVRMXUe2bJ/UCfYoE/n6prZEAGuV7
         usP070+HumEfguCjnbT8Owuhs5aCuMVoOjellWApn4XswhMoTln+SOSzsjHckXd4Jh
         kPBQ/8Z+cbJmyyMgEU7xysggj4hAkpSsPcdvEurQgNRNe/FTwOcVswbqXYopjTe/sn
         nO2v1Di80pRbg==
Date:   Tue, 19 Apr 2022 06:50:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the imx-mxs tree
Message-ID: <20220419065027.1046eb04@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2maBIVva9AUfCA74DICl62U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2maBIVva9AUfCA74DICl62U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a5b99c8fcd1b ("ARM: dts: imx6dl-colibri: Fix I2C pinmuxing")

Fixes tag

  Fixes: 56f0df6b6b58 ("ARM: dts: imx*(colibri|apalis): add missing

has these problem(s):

  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also, keep all
the commit message tags together at the end of the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/2maBIVva9AUfCA74DICl62U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJdzxMACgkQAVBC80lX
0Gzc9Qf/bX/03ka14Qj0a6nVx4MjL8KmlPqz/Rp3Two5G7ETIZUr9t4JioDJTCKb
VIw5mQWwTiWi6/LfER95AsMMWvczmK3dAJXXxf5wdguA3pexAM8oEZyvyjZA6UGk
DoAGRRUSLTK/JaVxBmuRIylI77eIwrOsttRnfGT3wg3ZIXNdzCfteLxeiApngzIv
MRYsK4wu8ayFGr+QaG9u6SpVYWsv40NzIe2qTr++po+YLskvrxrfdY2GnTSP4VPX
R6COxh+ogJ3oDikczz/Tauqk489BDxDg2cOk5qIk7mFhX2ZUfARB1N9xwF8AnIsx
D+FzwQAikCxrvHt2Yktkl+/qeMOXsA==
=M6GS
-----END PGP SIGNATURE-----

--Sig_/2maBIVva9AUfCA74DICl62U--
