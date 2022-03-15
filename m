Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAC74D9425
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:52:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbiCOFxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239679AbiCOFwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:52:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE68049F0D;
        Mon, 14 Mar 2022 22:51:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHjFy07k0z4xRB;
        Tue, 15 Mar 2022 16:51:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647323496;
        bh=JL3qPG79Sr2Y4eycu712fjbW83NobsBalx/XzRU79Ik=;
        h=Date:From:To:Cc:Subject:From;
        b=dCGPANzHpehEHrWcflKcL9tonj5uvFdh3SO76dI5r8sl4xLLq3mgvfSHYztr/hxoe
         qtWjWRop+1gDVwav2plJJkCju7/Yxg/ZgsRaIexR9bgj6NY3TltP/cm0o7eEdegl/s
         6m330WMYjccOYKOrgZuCN8emzs5ut11iQH+2JFCBTVkpd+53ksTAcXlbgTanaIT6rv
         oEP3lchqCW8Akc1QdBWTGprlMiGggc8A8mFfMrgkpT8TAVjVZ2Bc0yldUrfONuFa1q
         dA3NoQSMAvFpJy6/oYkwMt4PurXZwatSBRKjFEFzVlcKsf9VP+0jEFUivjChLjBR1T
         2cjpPpi+Xj0ww==
Date:   Tue, 15 Mar 2022 16:51:33 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>, Vinod Koul <vkoul@kernel.org>
Subject: linux-next: manual merge of the char-misc tree with the arm-soc
 tree
Message-ID: <20220315165133.5b720984@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vlQWi6Spi=EEm0AnZUqo5ey";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vlQWi6Spi=EEm0AnZUqo5ey
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the char-misc tree got a conflict in:

  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt

between commit:

  c04421c68fd4 ("dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 compatible")

from the arm-soc tree and commit:

  e7393b60a14f ("dt-bindings: phy: convert Qualcomm USB HS phy to yaml")

from the char-misc tree.

I fixed it up (I removed the file and added the following patch) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 15 Mar 2022 16:48:51 +1100
Subject: [PATCH] fixup for "dt-bindings: phy: convert Qualcomm USB HS phy t=
o yaml"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml b/D=
ocumentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
index a60386bd19b2..e23e5590eaa3 100644
--- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
@@ -38,6 +38,7 @@ properties:
     items:
       - enum:
           - qcom,usb-hs-phy-apq8064
+          - qcom,usb-hs-phy-msm8226
           - qcom,usb-hs-phy-msm8916
           - qcom,usb-hs-phy-msm8974
       - const: qcom,usb-hs-phy
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/vlQWi6Spi=EEm0AnZUqo5ey
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwKWUACgkQAVBC80lX
0GzG6QgAlhDh7mcaLuRSpI0SaVPGJLNJ8ungAyYqoIMPNPnnQ9fKQdoPw6lSqY+B
NMAFMlJGoVvg6KDAP6jF7/74eyYKUp2UNWAgbdzTjYyicsqssaeHBEQEo2nAkVlw
OJMVnrKeVtaUoEszR8sLzFQSpgC/A0eXg9h0QLdn+cVGFssUZRIPQohZjYgx3ey+
3/3tUz6z/KEKp8k7U0OC4AwdNeviOaXl2r/1ZqEU7VB04t85A1mDRazInlyM0WIP
PtSLKLT9rZWSKqpYl93zJ/ee6lL16CsTuopHxrpotvAVQVlO7vRF0EU/q8HTzp1S
qYAmSvKA33E29lBsnS4rx43UuIMWZg==
=g458
-----END PGP SIGNATURE-----

--Sig_/vlQWi6Spi=EEm0AnZUqo5ey--
