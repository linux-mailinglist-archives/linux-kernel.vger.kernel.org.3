Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A8F48F327
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 00:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbiANXlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 18:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiANXlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 18:41:06 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D8C061574;
        Fri, 14 Jan 2022 15:41:05 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JbHqh13vGz4xQq;
        Sat, 15 Jan 2022 10:41:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642203664;
        bh=Ft4fKhCy/uILQiu+5fAS/dvvxi4E7qK9PwnWq99FxBc=;
        h=Date:From:To:Cc:Subject:From;
        b=hIdCMbvUSSztnVTrLOBX+uATvlkrVoqAf/t+m83viOrUIkFeOGyHBXM+J3yHZthqb
         KPbl0g+NseKMeO+vBT5xMxtTE2Zy6gbyCY2I/8NWNhONXStBGboO1Ff/ShFl1CIyUn
         Z39bfwXUSGMiT+OWti45PiTMIQhWxgusdLxX+HtVbzHrHkVbxoly9iX6CrtcbLIvDm
         p/jYuwDF15nssX5L+BrlHLFDaH+0IyZW3aKkEXUCcgwIuAsaEOyE++IdiUGqsZy4mQ
         c4BEqxezWLycSUw8X8MKRzo5wfeMoc+6TRjh03uMeegGG7AMO53YoNRJdHioOX3IdA
         kPsaEb6+wYUXQ==
Date:   Sat, 15 Jan 2022 10:41:03 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>
Subject: linux-next: manual merge of the devicetree tree with Linus' tree
Message-ID: <20220115104103.7fa71b2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2ICeBVUJ8K4W7I20qL9zcvf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2ICeBVUJ8K4W7I20qL9zcvf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got a conflict in:

  Documentation/devicetree/bindings/vendor-prefixes.yaml

between commit:

  2d6a1c7d5772 ("dt-bindings: Add vendor prefix for WinLink")

from Linus' tree and commit:

  ea800bc1bd93 ("dt-bindings: vendor-prefixes: add Wingtech")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/vendor-prefixes.yaml
index b3de81e8290f,a2efbc26d945..000000000000
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@@ -1338,8 -1332,8 +1346,10 @@@ patternProperties
      description: Wiligear, Ltd.
    "^winbond,.*":
      description: Winbond Electronics corp.
 +  "^winlink,.*":
 +    description: WinLink Co., Ltd
+   "^wingtech,.*":
+     description: Wingtech Technology Co., Ltd.
    "^winstar,.*":
      description: Winstar Display Corp.
    "^wits,.*":

--Sig_/2ICeBVUJ8K4W7I20qL9zcvf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHiCg8ACgkQAVBC80lX
0GxP8gf/Xg/Yuew2BuHhNEL2TkZUc8euKrJxao08cr6r5i3GDHhdgjoeTCuGU1xR
L/O/bmm5XzGqCPTKVT0m4m0Fy3aBs0riagjFvXaAYGJrQaifUSXULAw/gitUeYRb
UKONYoxRyJ/3DBbAH0CqoNANxWPpkTHakcv5Sy8Bk8svqU5LGjE8Ym+btJziruqz
PvnMRiZkplzV/LXWGFABlaF92f+/DIaCLK+tGODydclWDJaTxBHjqFtOULNx/K/E
7sZ3+uLReZs7yl6euKgBzlyG+tBNlBQ0k2WOkfXr/g0JSTeVVp+loAlS0QjTF/WX
k0eOhN/Wnz/vL7vPvaoVQwxBXr/jeA==
=t4hD
-----END PGP SIGNATURE-----

--Sig_/2ICeBVUJ8K4W7I20qL9zcvf--
