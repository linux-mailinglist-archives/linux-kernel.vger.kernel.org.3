Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6433A46AB3D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 23:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356373AbhLFWNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 17:13:48 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:33179 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356335AbhLFWNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 17:13:47 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J7Hfx0fPLz4xZ3;
        Tue,  7 Dec 2021 09:10:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638828617;
        bh=nbRzrKtwGc1LfnjV9Mv2BvSCBXu6ZLArXBHABBdGRwA=;
        h=Date:From:To:Cc:Subject:From;
        b=OxUG4a16lypHW6dQzctKhZ8rDbX78e4QXoODDybS1bmnXxbn/OJ0feN8guvYVcPQP
         bYar9+4GlPcX+fR/uT2y+HTn4UaOA+6+W9fhmgu3Jw9MQrtyNGD7/rZgujMjbiRR09
         +6AcF4BJYvjH3+bCvrIyDRHWBrqsETQR7XrreGRQ34ypk5eFXQfSlRT/q3QM++C3mc
         C0d4AOK+t91i1IHVf6+jBxHtnwQDwnaBU8wbP2I/a0DreQMhKKT2uED2pdNVrieX2x
         lJYUyRYhOGJ8kgY6k8d5zf5m15dIkOTeUUkxnAB/Wj4h/7kt3qO2TH4Q0kiBFp3r39
         fHUSvS3wRZ8MA==
Date:   Tue, 7 Dec 2021 09:10:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the imx-mxs tree
Message-ID: <20211207091014.06063422@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rgYIl+yO.CJ5ABRAZsxPK.J";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rgYIl+yO.CJ5ABRAZsxPK.J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

Error: arch/arm/boot/dts/imx6q-yapp4-crux.dts:24.1-7 Label or path codec no=
t found
Error: arch/arm/boot/dts/imx6q-yapp4-crux.dts:52.1-7 Label or path sound no=
t found
FATAL ERROR: Syntax error parsing input tree
Error: arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts:24.1-7 Label or path co=
dec not found=20
Error: arch/arm/boot/dts/imx6qp-yapp4-crux-plus.dts:52.1-7 Label or path so=
und not found=20
FATAL ERROR: Syntax error parsing input tree

Caused by commit

  a4d744ac2bab ("ARM: dts: imx6dl-yapp4: Add Y Soft IOTA Crux/Crux+ board")

I have used the imx-mxs tree from next-20211206 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/rgYIl+yO.CJ5ABRAZsxPK.J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGuikYACgkQAVBC80lX
0Gy1CAf/YCtguGJIheikGDrjswKkj1DuYOSfYLTh/xyNdj7Wmhq+3d0BTnEOJQuN
CYkhfJHqOhsJBmhfvu1pUP01/fi41qJapzu06IQ1K8ystwMeJFfPMYHsw8G08A2H
GbJF5mIDsJNIfEdjjfwLfNo1qfH26dXMVbmRNkaTELjnWezs2phLDPxTaVqy3qEv
PGzBIoyHW1BJW47XscDwDiQ00pcv47XK2eLLja3/lh47GOSlS9eEsRvyOsNoPidC
YEK9tCXtOFc0zY63r7ave3yGJdOXnAsqPGKjaRRdZm6GNAVbg6JnoJZHIZrFe2Af
h6jjP6i3EYHYaLnx+4xb7fct5Gh8Dg==
=NZS6
-----END PGP SIGNATURE-----

--Sig_/rgYIl+yO.CJ5ABRAZsxPK.J--
