Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D32948BBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 01:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347228AbiALAbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 19:31:07 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:36743 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347113AbiALAbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 19:31:06 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JYT4l6NLcz4xmx;
        Wed, 12 Jan 2022 11:31:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641947464;
        bh=eGWiuVFBisnDmbb6Z82keERvFmUzmkgkjh080+uAVj4=;
        h=Date:From:To:Cc:Subject:From;
        b=dfJAnqzPkGzQFc4W/tfKhr8WxrLtFJFEj4xzRAhmXWwuDAMgawIAIRDTB0F9Oal1p
         17Xv0jnYW4JLnVcAicbPugNI8v69coywllBdjHG/t63UdGBPVoSUrMpqO3RoTEflt+
         onoaaNtRVg0/Lm5OSVeFUbZY8eZCGp89QXZJ9+0nC9l+HK72qY3ECVAwF1N9rS2IUd
         siIIsgoQvAHppky14MtYyNCOnaWSFOXiI/DGfR+7mLznYYnd0bUMcrYsZ3NnUP+oBl
         roHvFY9NBDm74MGr3LZd9/2SSi4TXOVxaeb0/9TGffp5Act0C5YbD+lENsKLI19+9u
         krfoaxrHu2jRQ==
Date:   Wed, 12 Jan 2022 11:31:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Yinan Liu <yinan@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the ftrace tree
Message-ID: <20220112113103.7e03448f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yHmrOeaaL/IhgbC3Nk4PLoS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yHmrOeaaL/IhgbC3Nk4PLoS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the ftrace tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

Inconsistent kallsyms data
Try make KALLSYMS_EXTRA_PASS=3D1 as a workaround

I am not sure what caused this - maybe commit

  4f1f18311591 ("scripts: ftrace - move the sort-processing in ftrace_init")

I have used the ftrace tree from next-20220111 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/yHmrOeaaL/IhgbC3Nk4PLoS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHeIUcACgkQAVBC80lX
0Gx9fwgAg8JFV7QXUJDl7iwqjuFgrw+3eQgQn6ImcFG9uDSkUhBgvCjcVLKhHMwZ
NrTAwDI5Phldj+FasEDRmn7AOm2Xe+pv1ThhCHVAb7G+x5w/XaGLLfWkQ9Djb+a9
7QAw+wTVzj18t43cXlAmhvqOrwnIz+jYdOQcsCNiLcpFz+Kz9EywyU28faTR6JBo
2+h7uZoK9W0dzmmlSEciWN17XKegp9qU2bQTyFtSePBQEVkrHf8GnkwDdQlzUk3D
BRbsPKAo54vVaaHQdoW4WL+kHRt0aLz8a39VU1iLv+dlGM/4UH3Olsii014IInh3
Ftue5HwMEU+NHMilp3F0Q6+9kUfcmg==
=SubM
-----END PGP SIGNATURE-----

--Sig_/yHmrOeaaL/IhgbC3Nk4PLoS--
