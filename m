Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4B24870B8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 03:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344912AbiAGCq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 21:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiAGCq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 21:46:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3928C061245;
        Thu,  6 Jan 2022 18:46:27 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JVSKB6RpJz4xts;
        Fri,  7 Jan 2022 13:46:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641523583;
        bh=ZkYFyl4ojtU9uYF94it7zWIo8pn2EQP2M9rmgHCBfwU=;
        h=Date:From:To:Cc:Subject:From;
        b=EvjJniDIGszm08oz5lS/Lv9+pJ8E3D82qi+AhpuhbUUTI7RHLDVr35WfQp0KiaEi7
         /mDUBIMD1mpOnLgQE4w/vRJHJvKByJnbRXzfb2ZFIv8wcewQ14Yf/SJc17vDr98fBj
         WNW3rDlq9b0kfg01XzWb5DYoSEUPApiQx283Uz/q2UoYXaW7rO5MxUFIGUroy0zAzS
         uBnYYb4j+gftvLMGboDAvjfZFwnLlvXgrCsI9jzTqGF9KcVYm2YEvm825PmqGTMnzv
         ZajTaiBdghCm6372sZpsSJDMWjODf7AhVU8Qy+4CPRG9uU5akVxCxaO9NPsWg3YvQj
         8Qti1lwF9r+uQ==
Date:   Fri, 7 Jan 2022 13:46:21 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: state of the nfsd tree
Message-ID: <20220107134621.7814487b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/R05/Lu/5BP.okjeZPRkFH+e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/R05/Lu/5BP.okjeZPRkFH+e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

I noticed commit

  a71baee992c6 ("MAINTAINERS: remove bfields")

in the cel tree and was sondering if I shuld remove the nfsd tree
(git://git.linux-nfs.org/~bfields/linux.git#nfsd-next) from linux-next.
Maybe I sould rename the cel tree
(git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux#for-next)
to be the nfsd treeas well?

--=20
Cheers,
Stephen Rothwell

--Sig_/R05/Lu/5BP.okjeZPRkFH+e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHXqX0ACgkQAVBC80lX
0Gzw/wf/RZy3GNt+lkB5hxKtr+dvGBze6MczKvPVlnxjFq1YpNr3XfmZcxeMrZBh
8xTcMhvCefxYbHXSJlSbom5ESe/gNyuVWQrhOZZTtZzXiXNafp/dSBRKX1F9SImg
7iUIGfUliSHg72/p8BMnII5hAByGrJOsRQDCvlvQ5ER8euJTKOg2A5gMLbcwAjhE
/H00rMc3IWW6mBleh5wuLfxJoH5UwzlHn2qENpmx5iLSIZGtLqAxI9xUPysmK5qJ
Xzw5RcBr8DYBLp4LE4+FyOXNErtljfjjMXya63dDZOTEvFiDoL90yAOFJ4xoycee
vS4u/pN5m8Q7Gqcjv65qX7bz2wx5VQ==
=v5dq
-----END PGP SIGNATURE-----

--Sig_/R05/Lu/5BP.okjeZPRkFH+e--
