Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2022A47A307
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 00:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhLSXhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 18:37:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhLSXhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 18:37:08 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74F5C061574;
        Sun, 19 Dec 2021 15:37:07 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JHJz61xLwz4xZ1;
        Mon, 20 Dec 2021 10:37:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639957026;
        bh=pGrAYrdRSK4vbJk8irRgKPzCCDR1U6MQqrRLL5FqJ1w=;
        h=Date:From:To:Cc:Subject:From;
        b=dJL4cAVxCUp5LrOEfRrSjfGjc89tPXpoK2JRuqVO3Pw78F+cGjzCSsBJH+tj6ouht
         ZWadnZ0dNO9NN/SI+qVLRoKl/xa8CKMbcMKB4DHIWQK9SPEvtSvVgL8t++cyBErGKm
         VW0dfGmXqPQvgmk+eeNvliMPo8XMMwJUrMme/K4dfjNtFk+a8X5WNmwQRcWH/IAwKr
         s3K+UTSf5NYBHafPEm0tgE4v4bq441HGwKNnt7iEzAny3OSg1E8gD9vqP9fUhlwtFC
         vuFbIlDeWQTOcAVZ9B+/3nS6aPt+Gw+p4yvxJhhpc0W/qEBOYWcUQ7805GUtrkzY9D
         /UTbQIcdVETyA==
Date:   Mon, 20 Dec 2021 10:37:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the cel tree
Message-ID: <20211220103705.50305f7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/0QXhnoaDTAkNnqn8G2cVN4/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/0QXhnoaDTAkNnqn8G2cVN4/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cel tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

fs/lockd/svclock.c: In function 'nlmsvc_lock':
fs/lockd/svclock.c:474:17: warning: unused variable 'inode' [-Wunused-varia=
ble]
  474 |  struct inode  *inode =3D nlmsvc_file_inode(file);
      |                 ^~~~~

Introduced by commit

  8628027ba82f ("nfs: block notification on fs with its own ->lock")

--=20
Cheers,
Stephen Rothwell

--Sig_/0QXhnoaDTAkNnqn8G2cVN4/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG/wiEACgkQAVBC80lX
0GxZfQf5AdWFnVkagY5qrM5zYJGyR35UwfgE7ik3/rp7RB0Qqvn7rraxrhia2ajs
1LboFKRSSmpCSFCDoKw1vbIpYNnF0Ttk+SikZARMoRBVpkwjkfUuHLmoJn8kdipo
b3LMQjjNqgWne0mYCT64ZPXtv3Lr/rhSFLuAaXk+eqRHxy4gloU+mMPSCxLa35++
TAuppygdDlF6rgToCnBfz5habRQx+n+eXL9pJSBLc/FALqGVnUIgYLYmE3vRiVeT
jJ9OKR+aO/uAlQuIxd8nbz/Od//FUypeme25v0ZvZzPl9TkEfzURteNhccnGpMNN
qjoB2DzhRrQdD07Ep9ynw+KFWp01Gw==
=RdCx
-----END PGP SIGNATURE-----

--Sig_/0QXhnoaDTAkNnqn8G2cVN4/--
