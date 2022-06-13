Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1597F54A1CF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 23:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244882AbiFMVwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 17:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiFMVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 17:52:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF9D38B7;
        Mon, 13 Jun 2022 14:52:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMQK458Gmz4xDK;
        Tue, 14 Jun 2022 07:52:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655157144;
        bh=5HHX31o+k4qbX7zPWevVGl9YIIAqDkOXYpujf8Bm5TE=;
        h=Date:From:To:Cc:Subject:From;
        b=q4YVHFFr+Pk7N0kTZ1Q80MFvct+0lCRofI2kdmpiICFDq9ldYlRzfuWF3R3HhdIoq
         LJgp8GIPyLIWhqG6Op2S+nI34iZovMtFe2/6D2YNZuFfGc0Ws4X89+X/wBdIsHOma9
         kGs0/L+qWYhKAPOGcpZwLLjQTcehL9EFwL5Oub1goBA0Y8cxdrEmaUx3SfCs/dBxPV
         5CZBUpGhLvIOlVEu8PwJ4AyAw1o9k1OMTNhiOHC41l5tiRzHDxsjRQ4CZ/7dXvvtVB
         CmMr26VVni7zgyeH2dPSGDnYEpgJmoal7g0IWZK4G/v3WVydOAn8AYW5HQ0vm13oJm
         aqoNfUNbOfXKQ==
Date:   Tue, 14 Jun 2022 07:52:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: bad commits in the v9fs tree
Message-ID: <20220614075223.5c2ea764@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r19VvcKNGz6tSEya1Spl+t.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r19VvcKNGz6tSEya1Spl+t.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  04608d78b66c ("Linux 5.19-rc1")
  9383b9134c66 ("fix the breakage in close_fd_get_file() calling convention=
s change")

look like they were rebased or cherry-picked from Linus' tree.from
Linus' tree.  From commits f2906aa86338 and 40a1926022d1 respectively.

--=20
Cheers,
Stephen Rothwell

--Sig_/r19VvcKNGz6tSEya1Spl+t.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKnsZcACgkQAVBC80lX
0Gw4cAf+OJhmOXRsmX6aEyy/V4av8Dvr3v15X3Tcd3O5yITN+W4isBz+WV9L9VYK
fQa+j2Y84YIoHxE2WMQTXvplSuvvQKcTeL2Orr0i+A7JGhCQ31xt5UDNKeByOloQ
ZE3nxjUk5c2lf+E2VdDR7BRksAHvxyF1NaTAmWkcUA3iL+LxA3SRxuapcbQSLLDv
1jjuTK1px2Llak+se5vGDrAtF8vvCDO55x40Yl3d5g41T846p/XrxsbTbHjkCStw
OiV4z69Xu7s2/bXoCZKPhgSF2+LiJAX4PspNX4dcqv5MpbI9gDzx4KaxkPsXWI7j
Tv92ap59mGEDUlj4ZSLZw2QGlvLalQ==
=uy2D
-----END PGP SIGNATURE-----

--Sig_/r19VvcKNGz6tSEya1Spl+t.--
