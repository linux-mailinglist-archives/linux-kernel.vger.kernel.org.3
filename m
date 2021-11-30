Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0188E462C01
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 06:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbhK3F0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 00:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhK3F0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 00:26:33 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B806C061574;
        Mon, 29 Nov 2021 21:23:14 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J39bh2frLz4xPv;
        Tue, 30 Nov 2021 16:23:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638249792;
        bh=AY/M4NUG4T26XTi/dQxhh+B6YO/lMi7chtE6OLocACw=;
        h=Date:From:To:Cc:Subject:From;
        b=GJR1oS8WXsqxYtIehFDRKvtMHc7iIu8mpR7YvWnsC2P3sgzymPe83X2sJC9ChaAR3
         ALpSgQyGqE19dLIe3cBw+COm4C+HCRaa73RV6QY1OQQbwiwu29NvfRbn4Y+sK/DuuA
         NqXJsi4nuKGWMPNgaxxPrVIjTQfMKZ67CFG6Ut33bi7oN/Cr88/Tc5p3iNvinJpWGY
         aFDjh1MiyTLKuD95RJMODkiaduQ0BhOxuzt8qMC2bxDC+7bY1KnLRzApmgtkFjlp6w
         Cx635GnR0DVBwvPn8tuBqQj2T7f31QG1ptLtOnm78T6FW9EsFxN783QOwbxb6h1hpC
         ygpps8+aMubtA==
Date:   Tue, 30 Nov 2021 16:23:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the fscache tree
Message-ID: <20211130162311.105fcfa5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pL_2/LJKRsl1QuWfMzGHYDa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/pL_2/LJKRsl1QuWfMzGHYDa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the fscache tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/filesystems/caching/backend-api.rst:417: WARNING: undefined l=
abel: documentation/filesystems/netfs_library.rst

Introduced by commit

  b3c088faf78b ("fscache: Rewrite documentation")

--=20
Cheers,
Stephen Rothwell

--Sig_/pL_2/LJKRsl1QuWfMzGHYDa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGltT8ACgkQAVBC80lX
0Gyq8wf/fKXgRhGFlLerqxBpIFRTUipYbtV8h2UGy+rWiLJsAPPYpB+4EcNraAM2
LEWlhzkyrQUYSJ620PdlVFxPhMWHucoT2LHEY7I7vZ0be5fVxwgzjaGspHCfNYo2
bNNtb+X/Iu2AgoyfbqcagOPKyAJBnwXEYkZlA5SbCB8MMmYymQj+xnJBbItwx8aF
tXoRSORrtvnpuLaf3Eo2eU9B+6pDjVQj2/CJVrHin286aRuZogz0y4HucHxH7qkX
b/MiZbRZhY2tdP5K4GCCvcmo8HHURsn4COHCtNa74jqhplrMHLTFb0xyJUk3GOvq
sTZ1aDpC2KnlUoCs9lRVHNSwU6dOwg==
=WNT+
-----END PGP SIGNATURE-----

--Sig_/pL_2/LJKRsl1QuWfMzGHYDa--
