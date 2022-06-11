Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97FD5472F1
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbiFKIgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbiFKIgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:36:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DB593454;
        Sat, 11 Jun 2022 01:36:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LKrlz4DS0z4xYN;
        Sat, 11 Jun 2022 18:36:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654936608;
        bh=e3Kyw0ErufC/jxE+5LgoHIdsUrJDSoZz5Nv9xbiqjLk=;
        h=Date:From:To:Cc:Subject:From;
        b=tkj8F7D5//zjdf+ooS/UaOIriaSodcZOVT6fGLcQolvVk8NXkZG25wG9uT7aXvQS3
         wmnPN5mD1x95/cmxlwVopNxDIlv9n5lMpBzvqeHKgysfOyj3cX3IHvbwdm2OqYwfJY
         WIGuQUxJcGDQ60h3NkLp/tYC+l5u2d40YH4RH9MRy6hSdMZ15LyQp1R3fO82VLw3LR
         jT9mMfSTNuw3PGo4mf9wwttABoMim7F3wHqmoeh3g7ksa0FtK4tEQ8uCKlqY+OPxVx
         xSFZkAGQD6ZPm+hK1EDCJudQlD0ayrGqPVZtNXQGMm5vdO44bDnvj8lK/GLkLgqZHL
         cyCl8ysygjo2w==
Date:   Sat, 11 Jun 2022 18:36:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the fscache tree
Message-ID: <20220611183642.0a519e07@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/t=UjC7boy8SlfNfW.OvS5fe";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/t=UjC7boy8SlfNfW.OvS5fe
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d3b63ddec3f8 ("netfs: Further cleanups after struct netfs_inode wrapper i=
ntroduced")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/t=UjC7boy8SlfNfW.OvS5fe
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKkVBoACgkQAVBC80lX
0GyTZwf/TNZ2VzSAsdZ/W/WC+JC3ECP+LrQShpOLiiDC+pEZ2sB/VRJ8RAde/3ZV
oldi57kcRblUT/mIfXGhBygYQSJQKyfUVJWigG9tT/XMyjuCY80xucsFXaMDhKsu
+UHXe/jA9JSEpL0E1n3r8Plns6J66IdvoaJSoYCg8kzsJXVzRNdT4Ao/cCPZSWPg
YKwjEhNMuB6F3FeCAXAj5fUMhnlpLyZO2Qg+Xa8sWMjFjf9cgciYKgpyIDqCaCtt
FoLwcGhmjY9T7tMWVqUTiPtiM8MRaqxHor+XMVJ7toUq6FppOxpgDn/+fqtQDQ9Y
VXpy/jKyvmDbB333+0NaOlAua4SCRg==
=TZPv
-----END PGP SIGNATURE-----

--Sig_/t=UjC7boy8SlfNfW.OvS5fe--
