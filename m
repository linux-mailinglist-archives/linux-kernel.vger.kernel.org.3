Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22DFD49F081
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345042AbiA1B1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345028AbiA1B05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:26:57 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13B6C061714;
        Thu, 27 Jan 2022 17:26:56 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JlKYk3xXtz4xcP;
        Fri, 28 Jan 2022 12:26:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643333211;
        bh=aAjIfzo4A4A8Ms6f79436CT8Pjp3tnjPz5RVwJRWUl4=;
        h=Date:From:To:Cc:Subject:From;
        b=T4dNhqKAJlS++pVWE5mLP3PgpMsgUOiswE+0ST5YT4nRzcpRAPJbBXFyOw2Nnsj85
         HgvcCKFgQ3/q+RllMYtq6NODPsGtw0F3YsQqM85VTf+LToUtDY/9QVb0RBvxtjqUBX
         zmJs406UtSn7NYvKuC7Y61s53vwaLoCe8kEStRdOqtiKgcU+GMn8mcX6ldN1ogGHyt
         uYk5YYsqDy6V4/TSitiM8cS0oWCNQExrkCgjMvrUmbqxJ9+EKoNP1LYl1TyxvsSibe
         ZgBCQnkHtsVsz8xZGliNph8CEMMTLQ+P5vxiYqtgB5yacXdsmZfUMFYzXF3XAG5Vjf
         ohHJ/pIdqEBhQ==
Date:   Fri, 28 Jan 2022 12:26:48 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: linux-next: manual merge of the phy-next tree with the qcom tree
Message-ID: <20220128122648.4c94b120@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/w_kT3C5hUF/k4IEMS76OfXG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/w_kT3C5hUF/k4IEMS76OfXG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the phy-next tree got a conflict in:

  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.txt

between commit:

  c04421c68fd4 ("dt-bindings: phy: qcom,usb-hs-phy: add MSM8226 compatible")

from the qcom tree and commit:

  e7393b60a14f ("dt-bindings: phy: convert Qualcomm USB HS phy to yaml")

from the phy-next tree.

I fixed it up (I removed the file and added the following merge fix patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 28 Jan 2022 12:24:35 +1100
Subject: [PATCH] merge fix for "dt-bindings: phy: qcom,usb-hs-phy: add MSM8=
226 compatible"

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

--Sig_/w_kT3C5hUF/k4IEMS76OfXG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHzRlkACgkQAVBC80lX
0GyvaQf+I9MlD4vJKF09tucOeyLLHDL+1mmbhnNv98y/LZ868F89eI1LdrFeIV3+
cSjVjPLVbQDyX+Jro05mLy/IUg3DiPWByp+HY8CWji0eGTP0veiaV60pDdl7b4if
jHP5dnVrcIB5CCGlyilXJEl2gZF6ACAzgi2IiUXg1kPsVGtXlSwkLihC/eiKPD8J
RGi+B3tMV0FLBg5DjoT9Mg8Zjnd9XRSCQINt8F/aK46OwgWp18vizJmpTnPY4/dy
OtcOWlyGAHy0DcUqQBKNnHfDp7Ao3+nzRPXHTq7ZzlnjWyrE5GiybXo//GDEK1CU
Hq5q5zuFtBU2T6w0vRw8+4oIk7MeGA==
=diR3
-----END PGP SIGNATURE-----

--Sig_/w_kT3C5hUF/k4IEMS76OfXG--
