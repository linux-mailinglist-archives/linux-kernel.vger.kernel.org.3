Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2DB530834
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345546AbiEWEFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233803AbiEWEFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:05:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19C5637B;
        Sun, 22 May 2022 21:05:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L63df6XHSz4xD7;
        Mon, 23 May 2022 14:05:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653278728;
        bh=Fzn4hoMSmZbg4otScjy8jrN/eCp69Sk3KAuu65T0H78=;
        h=Date:From:To:Cc:Subject:From;
        b=np2nYaEFc7uz/Wfbg7Ku/8dpkEX2TSR3PdQBiQtPUE8o+HFiJQu4dWsJVggvDsJQr
         nKp3eWSMLA5zuqxr6VjuDBWqNyXT1Nhj2rzqGGIrcmbQZPjvK6QN8Dbijp6ogWZUMo
         qIKk6kFUTPcawFXKY04++2tzCSg+sjMLDz9j8CfWJYI6ux8QYq7+T0HI5pznRleu1W
         zi9DDTmowz6jCEBoEDPNZeEq2QBFdorxxJd9n3n1qO03x0wrpY0sjAm9QZWrrRweDA
         jK4sRMqIrFuKTxeyNm2Ni2q+z4wCc0n5WbWcIbxJAgUSeDfv9IzNZUmx5tZ6t9dkld
         swUAjXqjAnHig==
Date:   Mon, 23 May 2022 14:05:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jassi Brar <jaswinder.singh@linaro.org>,
        Rob Herring <robherring2@gmail.com>
Cc:     David Heidelberg <david@ixit.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the mailbox tree with the devicetree
 tree
Message-ID: <20220523140525.4ad591d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=rAw.59tZ1cA61PxWG775Ar";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=rAw.59tZ1cA61PxWG775Ar
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mailbox tree got a conflict in:

  Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml

between commit:

  b20eee62ee89 ("dt-bindings: mailbox: qcom-ipcc: add missing properties in=
to example")

from the devicetree tree and commit:

  cd285535b8ee ("dt-bindings: mailbox: qcom-ipcc: simplify the example")

from the mailbox tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
index 50f9aa72c670,dfdc72345a2a..000000000000
--- a/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
+++ b/Documentation/devicetree/bindings/mailbox/qcom-ipcc.yaml
@@@ -62,28 -61,14 +62,28 @@@ additionalProperties: fals
 =20
  examples:
    - |
-         #include <dt-bindings/interrupt-controller/arm-gic.h>
-         #include <dt-bindings/mailbox/qcom-ipcc.h>
+     #include <dt-bindings/interrupt-controller/arm-gic.h>
+     #include <dt-bindings/mailbox/qcom-ipcc.h>
 =20
-         mailbox@408000 {
-                 compatible =3D "qcom,sm8250-ipcc", "qcom,ipcc";
-                 reg =3D <0x408000 0x1000>;
-                 interrupts =3D <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
-                 interrupt-controller;
-                 #interrupt-cells =3D <3>;
-                 #mbox-cells =3D <2>;
-         };
+     mailbox@408000 {
+         compatible =3D "qcom,sm8250-ipcc", "qcom,ipcc";
+         reg =3D <0x408000 0x1000>;
+         interrupts =3D <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+         interrupt-controller;
+         #interrupt-cells =3D <3>;
+         #mbox-cells =3D <2>;
+     };
 +
-         smp2p-modem {
-                 compatible =3D "qcom,smp2p";
-                 qcom,smem =3D <443>, <429>;
-                 interrupts-extended =3D <&ipcc IPCC_CLIENT_LPASS
-                                              IPCC_MPROC_SIGNAL_SMP2P
-                                              IRQ_TYPE_EDGE_RISING>;
-                 mboxes =3D <&ipcc IPCC_CLIENT_LPASS
-                                 IPCC_MPROC_SIGNAL_SMP2P>;
++    smp2p-modem {
++        compatible =3D "qcom,smp2p";
++        qcom,smem =3D <443>, <429>;
++        interrupts-extended =3D <&ipcc IPCC_CLIENT_LPASS
++                                     IPCC_MPROC_SIGNAL_SMP2P
++                                     IRQ_TYPE_EDGE_RISING>;
++        mboxes =3D <&ipcc IPCC_CLIENT_LPASS
++                        IPCC_MPROC_SIGNAL_SMP2P>;
 +
-                 qcom,local-pid =3D <0>;
-                 qcom,remote-pid =3D <2>;
-                 /* Other SMP2P fields */
-         };
++        qcom,local-pid =3D <0>;
++        qcom,remote-pid =3D <2>;
++        /* Other SMP2P fields */
++    };

--Sig_/=rAw.59tZ1cA61PxWG775Ar
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKLCAUACgkQAVBC80lX
0Gwojgf/cR82xL5ati0hnrmEAMdVEmCro6867KtJMJGl2PLJLd0Dbu3ddup8w1oI
X45Ygca6jXzz2w5BYFO7IfkKVrYHa4nT2zy6vq7uZDUD/CczkoPCzsw3q6uU6bYO
hrkIPjVsmHLliXV34JresvCKKZ1AoSjxOxO6PT1gDAJ4zwWcgEQFw3Q1juqmi1Q3
/B2AClq38vYDdPSCPgezTqwNhAc3D9lwkbUqn8HzlVjzEtuD/dVg5P/bWpkFo5L7
eTKnxVt6KqwyrLgd2TPzEtq+RUxY2T6ik5N5MGT0p9snJbPNKMgISnflXcbf1yGy
wluyUqDDQ6BhzO7sqx87VDHGkswsxg==
=J6Cr
-----END PGP SIGNATURE-----

--Sig_/=rAw.59tZ1cA61PxWG775Ar--
