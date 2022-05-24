Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3550B5332CF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 23:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241847AbiEXVHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 17:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiEXVH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 17:07:28 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7C03E5DE;
        Tue, 24 May 2022 14:07:26 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L76GN3j4rz4xD1;
        Wed, 25 May 2022 07:07:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653426444;
        bh=s989OmAEi4p3w9Bi09XinAJ1xsV0kn3UP6gq+AbmcrI=;
        h=Date:From:To:Cc:Subject:From;
        b=j+2aB3UxJ1VCzRSS5oFteNcu6nIMzoR0XgagiAJSBKCElkqHP7BOTYynoBT7wNkYk
         jto8h2sZ5dNpXWPdd71CUUvRDrqfEMHtRTiacGoiJrtyjlJHncBHAE93/o9+iiUUr7
         m/4oD6QLvsozcrtEl0rukGTB2udEcikvs3IlDiuwDWIZswV2sEIPVppD6MaXMfRy5V
         5hctE788ndt4RyQ6Sx6BF+1vxZearNbWw9f0Qku95uOr7J6t+oPS4J76VKwzv4y/iY
         8TMXZUF8oCIujo56NR54YVz9HlioO4xH/vhPZA0qqhHKb9iouIRFSu3Hg8cZVU9Uim
         DKVs5H1ZKbeMA==
Date:   Wed, 25 May 2022 07:07:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the pci tree
Message-ID: <20220525070723.426cbfd4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6zjDcR09dd3KsxmmAHcysbt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6zjDcR09dd3KsxmmAHcysbt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  5db490f54497 ("dt-bindings: PCI: qcom: Add schema for sc7280 chipset")
  ee485c61f0e5 ("dt-bindings: PCI: qcom: Specify reg-names explicitly")
  3d49f91acbcc ("dt-bindings: PCI: qcom: Do not require resets on msm8996 p=
latforms")
  e93dde4b6768 ("dt-bindings: PCI: qcom: Convert to YAML")
  ed5e8fe0db30 ("PCI: qcom: Fix unbalanced PHY init on probe errors")
  f36120778857 ("PCI: qcom: Fix runtime PM imbalance on probe errors")
  53063d1437e5 ("PCI: qcom: Fix pipe clock imbalance")
  5945b7056322 ("PCI: qcom: Add SM8150 SoC support")
  ddd0cc4df5a1 ("dt-bindings: pci: qcom: Document PCIe bindings for SM8150 =
SoC")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/6zjDcR09dd3KsxmmAHcysbt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKNSQsACgkQAVBC80lX
0Gx6dwgAhASq+SSTvdXxXwZ2HmEghuvUncpullUMwIFUbBAS/15OajMSgmimr6R4
QG6G67qZ9QJPU/IVuT5G4MKkVaDlZ/wCkJFFI5wyxTN2BMbBFIpZtrC5GS9PXmkw
ks2Z2pN98KPmauTsJYumKuEs6xd0AA3RQI+wpR14SIl6var0ueWMiUYs1Xj1fW6F
rsqBCUBkdQVcj0wxIaPJa0erjpllwGjxeyB/9wqgI69IJ7tQ9LZpB+HSOC6lmEp+
O57O4xcoDoCl/DoR1M3/5m2kxQTtvjSBSk4SYluwmqXz3Jd2H6AmmO+h88K6iYYN
3HxixM1ODZLrXgEa1f1KE1n296L35A==
=W+Ew
-----END PGP SIGNATURE-----

--Sig_/6zjDcR09dd3KsxmmAHcysbt--
