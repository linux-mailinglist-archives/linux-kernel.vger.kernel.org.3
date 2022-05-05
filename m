Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D03451BCE1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354904AbiEEKPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 06:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbiEEKPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 06:15:38 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFDF2B246;
        Thu,  5 May 2022 03:11:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kv8cs580Sz4x7Y;
        Thu,  5 May 2022 20:11:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651745517;
        bh=oqVv6WChkGRtGeqjxFGg/bVM6eSZ/2luXPF0CgB//u8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UeefQekqQmLJTeiXDMytDwTtWd/1DQi6MNP+JuMUACb5fS3DCkISZq7wP3kbFlsGp
         0wpDRUtqgz9qX/VRaJAg6K6qPxTxlhC+zwIKYF2uX/wtapw9TGfGCv9SwPRv9w4S2/
         OsP4o1x//hBKRllln6/apE2E9r1YQ7OO7xdLaM5Rh3Fik3zKN+CgLyNNLbGQkWfhPH
         mOufNgPFiwl8BTo4Akf+8yrjsyvH4aH7XXldgAXbqR4CLeKlPRBG7Zta8n2IUFolQP
         Jt4ke5o0iXw21WKFRtfPJ5LYhVNCwluadNzs0sJPSDTC5EhBuS4ifkUT+DEQLNqw93
         LR2liqbgB58ww==
Date:   Thu, 5 May 2022 20:11:56 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoffer Dall <cdall@cs.columbia.edu>,
        Marc Zyngier <maz@kernel.org>
Cc:     Oliver Upton <oupton@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the kvm-arm tree
Message-ID: <20220505201156.65decdc8@canb.auug.org.au>
In-Reply-To: <20220505201005.7ab164c0@canb.auug.org.au>
References: <20220505201005.7ab164c0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TMMiU5HySIcAymubg3bMA4x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TMMiU5HySIcAymubg3bMA4x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 5 May 2022 20:10:05 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the kvm-arm tree, today's linux-next build (htmldocs)
> failed like this:
>=20
> Sphinx parallel build error:
> docutils.utils.SystemMessage: /home/sfr/next/next/Documentation/virt/kvm/=
api.rst:6175: (SEVERE/4) Title level inconsistent:
>=20
> For arm/arm64:
> ^^^^^^^^^^^^^^
>=20
> Caused by commit
>=20
>   bfbab4456877 ("KVM: arm64: Implement PSCI SYSTEM_SUSPEND")
>=20
> I have applied the following patch for today (I don't  know if it is
> correct, but it does build).

oops :-)

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 5 May 2022 20:06:34 +1000
Subject: [PATCH] fix up for "VM: arm64: Implement PSCI SYSTEM_SUSPEND"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index deeb95dabc64..e5d685d4de11 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6173,7 +6173,7 @@ Valid values for 'type' are:
    the VM.
=20
 For arm/arm64:
-^^^^^^^^^^^^^^
+--------------
=20
    KVM_SYSTEM_EVENT_SUSPEND exits are enabled with the
    KVM_CAP_ARM_SYSTEM_SUSPEND VM capability. If a guest invokes the PSCI
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/TMMiU5HySIcAymubg3bMA4x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJzouwACgkQAVBC80lX
0Gz8WQf9HYGDRHl0NkUHN/rwPB4ryepQYLThcmHXAKRlr94xWTyc+Ko6neIbGc0r
HP2x2SbgqAi/HKh0gLpG717QyhVCfYS4PECOstfx1Bt5LyNh0lU9GQFdcBbFjhqP
yHdZtGv9UgoM4C7Q2GAwoH10ie8uEWQ3N/qRdQMQ0i3s5HsArrmJYxRcFMrecpH6
4DjxpY8u9bXV0m7EmayfRp0Bm/SykAfKNGTGm4gHHOjxtMwQ8lpCLpkeekAm+W3/
iw5IOU3CKL8EEtdYanqaCmDMp70OiCBkwKQQxGEQwcU08GokWUoXdFXBaUfoduHd
grZLWSzGVaanhsZCX5Eak/QHuY41rw==
=xEu3
-----END PGP SIGNATURE-----

--Sig_/TMMiU5HySIcAymubg3bMA4x--
