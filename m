Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F76A564B82
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 04:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiGDCLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 22:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiGDCLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 22:11:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AF75F5A;
        Sun,  3 Jul 2022 19:11:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lbq6t5vKGz4xD0;
        Mon,  4 Jul 2022 12:11:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656900695;
        bh=XvTwYgl+mOq77qa6qrmMnu0/CRb7qWvlypvNQpB13Vc=;
        h=Date:From:To:Cc:Subject:From;
        b=KkG0TOXa7+wiLnJMw7f7nwrZX99gPdbZBBuIKzus1cV+iAzNXlv8dYsBkYaI7u7qB
         6JcJ/gQsBsGTFnIWwwhvsnFDaQcRv+BP1OZ318j43p8VA2x5C0mLx8+4Eq7/QJ9Dq8
         W4ws4ZGjyymSE7at+7+fVCvAnXCyqcuEt8m6G/cnRrmhwD4Bb9pYQBXM10d+vpasFW
         dbt5WzzH8Vs8l7jdjOKc85P+MoPjIS0Ev6Fp+wIcNWbdlDoSYi8uXWDUv0dwvzwaJy
         QF0rOFKWIxxMAYv4Ia8w1RdKIJ4XWGnpiBaQNIArglSXe0Vs33XT5IZ+pDIGryWecW
         tvwcmISQ/fA4g==
Date:   Mon, 4 Jul 2022 12:11:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the dt-krzk tree with the qcom tree
Message-ID: <20220704121133.33f82aea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vpb3=6Jtz3PUKKH0yAMcZBa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vpb3=6Jtz3PUKKH0yAMcZBa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the dt-krzk tree got a conflict in:

  Documentation/devicetree/bindings/arm/qcom.yaml

between commit:

  bbd5a6891908 ("dt-bindings: arm: qcom: document sda660 SoC and ifc6560 bo=
ard")

from the qcom tree and commit:

  4fc3efba3205 ("dt-bindings: arm: qcom: add missing SDM630 board compatibl=
es")

from the dt-krzk tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/arm/qcom.yaml
index 4dd18fbf20b6,02087bb1f698..000000000000
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@@ -44,9 -46,9 +46,10 @@@ description:=20
          sc7280
          sc8180x
          sc8280xp
 +        sda660
          sdm630
          sdm632
+         sdm636
          sdm660
          sdm845
          sdx55
@@@ -548,11 -282,14 +589,19 @@@ properties
                - qcom,sc8280xp-qrd
            - const: qcom,sc8280xp
 =20
 +      - items:
 +          - enum:
 +              - inforce,ifc6560
 +          - const: qcom,sda660
 +
+       - items:
+           - enum:
+               - sony,discovery-row
+               - sony,kirin-row
+               - sony,pioneer-row
+               - sony,voyager-row
+           - const: qcom,sdm630
+=20
        - items:
            - enum:
                - fairphone,fp3

--Sig_/vpb3=6Jtz3PUKKH0yAMcZBa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLCTFUACgkQAVBC80lX
0GymRggApNMd7aAHJ7AjfvKtKhWTL62CCiImUSVwW/6aL0+Jazc7V4j4wAJ6PhGU
RbRoDcZN8ROhVrSzDpeEIqHNYR86F8/ca7lhhT+c3t3ADeMCSUNJZ6Om99wJeAO5
aeqEDtEErDmzAYvFGXIfLm0XCGthP5CwTqKffyDwn0/elo9FO1L5qWVt9xiUZ+Nr
qxH4TItgb71H9FffZGUsrM0wDyFnTjD7jzLR4yYHK3qxMiSjFpZdM5sBMr+Hu4Y2
l9bA9xA1fggJgnJci0fjPpKoIcbM2eJj1tRMrs1jxNGod+j9twygMPahibZhqySG
sv1LjYJF5pwtBKepd+rpU4KMwfB7pA==
=Fqyy
-----END PGP SIGNATURE-----

--Sig_/vpb3=6Jtz3PUKKH0yAMcZBa--
