Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01964C9795
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 22:13:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238302AbiCAVNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 16:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234936AbiCAVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 16:13:40 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF64496BC;
        Tue,  1 Mar 2022 13:12:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7VMX5pr0z4xZ5;
        Wed,  2 Mar 2022 08:12:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646169176;
        bh=uiuVrU3xAqSXcb0ByN0vN1mn4IK+vIadarYO43hOe7k=;
        h=Date:From:To:Cc:Subject:From;
        b=F4vuDzn3sPJo05xVGIouWXCV6ZX3qidhVKJf+It05L/iIZT6vGuaKDmK5NL/NntY1
         dgakNxELWqgvbk5++VK9Uu/u3H3IcS52m5M4hXJfzNRcD83U+LkqQ5QZ582esuuZtY
         J4/O4+7tSPwZ6VFcUZuuuf/vsrZg8c0/+IEvVT1+Q8QeQrB0/BtZF0wFiTHqZjAeEX
         7mbkAx95sYyeGc8int0cyKW7/IbkUb2rD5lKASWXj7AMhbM5Cw/0AAIKvHtlZx28aW
         O8XjoeiagSF6QLEiJqbkbGIrZhnZmziy/0kSc0MaZKp1pePzRK6ah/LRVouQ60jiRV
         9ZIlKpZ5GxIXg==
Date:   Wed, 2 Mar 2022 08:12:51 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commits in the pci tree
Message-ID: <20220302081251.76dc066b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yEelrlr1D.zu5bu1PIbCDNN";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yEelrlr1D.zu5bu1PIbCDNN
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  8423706fcd6f ("PCI/VGA: Log bridge control messages when adding devices")
  616c33aeef4d ("PCI/VGA: Move disabled VGA device detection to ADD_DEVICE =
path")
  3996347141f2 ("PCI/VGA: Move non-legacy VGA detection to ADD_DEVICE path")
  74cc9ccf72f4 ("PCI/VGA: Move firmware default device detection to ADD_DEV=
ICE path")
  7c0045edaf90 ("PCI/VGA: Factor out default VGA device selection")
  55019256d686 ("PCI/VGA: Move vga_arb_integrated_gpu() earlier in file")

are missing a Signed-off-by from their committers.

--=20
Cheers,
Stephen Rothwell

--Sig_/yEelrlr1D.zu5bu1PIbCDNN
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIejFMACgkQAVBC80lX
0GyzSQf/a1eEYJljjECs+PceHOQ6rTy/QvozJKMxnMIC6VF9Moaz/kVrxJuWymIl
NYvkumjqkc4eILUYAFkiY00RG1MXFJJNFvRripuEqeWh/ZGhYJygXdvOCLM0nfh4
mpZJoOPAiW6+RGKHnl7ZEMJ4Tgsb4Z/qArBrR4czfapnsEzPix4Bkt8Y9Zr1eUcx
0Rv0FDlrj/+EWfOla6Lqu3yafoNVxQTgrn+rYZGDB7oCn0LGsst6vf+AachUap6m
MQmnnDcJCsgxRp6WSZFTmBKQJE3wibhcnxoM4V3ug1Hb8sLFVJd34gcjgjhWTGiQ
S0NElcWjZygGOswqqyVP3Z9dPQtHLw==
=lDFP
-----END PGP SIGNATURE-----

--Sig_/yEelrlr1D.zu5bu1PIbCDNN--
