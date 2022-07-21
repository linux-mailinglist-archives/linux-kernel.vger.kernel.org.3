Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFB6757D6BF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233630AbiGUWQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiGUWQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:16:43 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB9A19C1C;
        Thu, 21 Jul 2022 15:16:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lpn3Q4HRDz4xGC;
        Fri, 22 Jul 2022 08:16:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658441794;
        bh=kFeJUu85GewLppY0RIt8DS0OhaFAkTyEUtGKA4W/In4=;
        h=Date:From:To:Cc:Subject:From;
        b=DROt4CwCZ02uEw3njYblGbseKyMAbQ1VdCP3IM0FbEs7Zyy6/XwcuDoHGegKrZrVb
         D1++jIS7knD3zIXnG0KW1yto7/UjaJoZ7gBBbJKFD1rOV2X7ycXVbA7VeIoKNQmvD7
         jrac0CFQq1wteJHW88m6bH5jLLlaet7xtVnswKrHsApx1SrXUBbw8flaidS0i66f+1
         zzung94XBW8nE/c572uKC5aoXLNwqlibvU+Un+o6RBCYdvby9n4au3xSCD8iloJPq3
         0UkiIwGEeE4p1qLgcllFyw28b6xulBR3R5xYeQMU4X3MUPOO/rpDAtlMWZ92VEhia/
         LzeOdH5yoL9fw==
Date:   Fri, 22 Jul 2022 08:16:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the fuse tree
Message-ID: <20220722081614.07e3261a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NMK6869ZzKqlQ_UhKDqYuzm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NMK6869ZzKqlQ_UhKDqYuzm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c8d80924ae02 ("virtio_fs: Modify format for virtio_fs_direct_access")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/NMK6869ZzKqlQ_UhKDqYuzm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLZ0C4ACgkQAVBC80lX
0GyVTQf/VNYj8r/e7dgv5CWfYdc4CQ1+RQX3ekoKhvV121gUMVsmmlMglMBqwIVN
SG2KSuCFX67vSC907Vt0z1Hc7HxXgdLsj1/N+B08gzs+weK0pU1Byd7DLiHwmdvI
1EVfEh56xSOp1Bs4CF9HzG4Ue8k+HHQlzrUCIBv1M7Ia9GzSGTrZKNPIPGacmA2q
1dtaw9OJGWDX8vSQNviKWgiE2TwKlYonofnjZkJOCL9gQIPf2Rj36KY7nfXB4s66
in1c18Mi2NRORPL4AiwBH+EB9phtVq12LM79k+TWkCBVq/cHKLF66MczOPrvRPCW
JoAb2Ra4CQ1sFXCjV8Cj+XWlnJfy0Q==
=5bxL
-----END PGP SIGNATURE-----

--Sig_/NMK6869ZzKqlQ_UhKDqYuzm--
