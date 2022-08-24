Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDEB59F3A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 08:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiHXGiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 02:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiHXGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:38:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8828DBC82;
        Tue, 23 Aug 2022 23:37:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MCGch0ljkz4x1J;
        Wed, 24 Aug 2022 16:37:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661323076;
        bh=xfsz54neIsbrMNPgb1aEP7SYAkuqpgjxW49Iaa7G2WY=;
        h=Date:From:To:Cc:Subject:From;
        b=oxvW/A6RBuR7zJZOBvESj6ynjVPe4htN17/Z5RBGdFzGF6rjOcTjdm3YckHRhpxq6
         ujcuBz7kxNAMbm5+kgtB2TbrCvbYH3nEupg90dSeOgI4KguHjLmf2b8Zt6nf0MKc0n
         Ukj8nHPI4dItWkPaKVANZ1ILtzvhD4+sx2yhIfZT1M3GKBRaS3vOsSFSjil/IitFTY
         IPLsiak2Zvvn7gKJfFy4O8etP39tH/DP803snyQA3OsCsY9dSP6RtTw8Z3pN7p6pY1
         4diFCwa6rcMqi1qx70xgF11CC8WKVzODYC8GNhDC1HlWkVUBkEOsbrqU2RzqxO67Gt
         2G3XHbk2DzO7w==
Date:   Wed, 24 Aug 2022 16:37:54 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the cifs tree
Message-ID: <20220824163754.1c082f1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r.2InO=eXSVVn=A=Psz+kDc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r.2InO=eXSVVn=A=Psz+kDc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  b044b4dd6048 ("smb3: fix temporary data corruption in insert range")

Fixes tag

  Fixes: 7fe6fe95b9360 ("cifs: FALLOC_FL_INSERT_RANGE support")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

--=20
Cheers,
Stephen Rothwell

--Sig_/r.2InO=eXSVVn=A=Psz+kDc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMFx0IACgkQAVBC80lX
0Gyuhgf+Iyfiu/ART5E1bS3RZbXklNEYZTgzci06JGoMYUxUA7hCcj7+bHfQasq3
27BbiYWh+J7Ml1uDUyFP9hK1TnvEbEDJiz3lV+NwHyuhHzKIV4XChwtNQzFZcwhF
j8XS/7WgyznSKvIx5UF0f68qYJttvZbnBkQgJpemqLwD2dFyzT8oPBobImfj5GWS
/+9wu1Zirb+qGh7n2GExe9Cmx51XrEs8sEImx6ZWo7bakPyh0G8yiq2DgSB08gUT
kmXXwcScc9LD0SX6sASvRg9dqRMb6UCeXP0zFG+e2N9jVzX8aiSA4uZKfJLwoefb
Ag2KrPEDTp+CAJFsHS0SLISN8JOcoQ==
=iXBu
-----END PGP SIGNATURE-----

--Sig_/r.2InO=eXSVVn=A=Psz+kDc--
