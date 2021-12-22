Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9EA47D909
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 22:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhLVV7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 16:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234030AbhLVV7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 16:59:50 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E040C061574;
        Wed, 22 Dec 2021 13:59:50 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JK6gR27d7z4xbd;
        Thu, 23 Dec 2021 08:59:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1640210388;
        bh=TklSx10aW0pHnE233yn87br6m+Ruo2on2shB4yYZkiA=;
        h=Date:From:To:Cc:Subject:From;
        b=RxLoN727VZsOOkkOpjHaMdnRFwscAhkeoR/5foRtoOwlRYSiC2PDTf/NaBU9Jb5rm
         w64uM0l9gMvPW3pAGOTsh9YfBlGZOBt1fk8asrsPLWQLbQ94qEPPPIopLjy5+uO6nj
         eP1sY6farBAbQKnEuSqgC8P/OUweGNHGY/ZEacZ6tgiFJ1J21Zsy8JkDJtyrYLdbXT
         RDUCk74lUK351PBgWFMnmYcuOTvG2iRxeSVMOIQx+mhd/mXWxI/s24L/09X0AY2RVC
         kpPwIpzGf9lPuB3oiT6vWXytZN6e0o26kBFSPdVLed4xHz/1NEWgrboDgui26YxNBC
         OPCd42hPV/JFw==
Date:   Thu, 23 Dec 2021 08:59:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the arm-soc tree
Message-ID: <20211223085944.0095eaf5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4DpgRW6knj1wx2f5p4ku0FS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4DpgRW6knj1wx2f5p4ku0FS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:109.4-14: Warning (reg_format)=
: /switch/ports:reg: property has invalid length (4 bytes) (#address-cells =
=3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_reg): Fai=
led prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (pci_device_bus_num):=
 Failed prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (i2c_bus_reg): Failed=
 prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dtb: Warning (spi_bus_reg): Failed=
 prerequisite 'reg_format'
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:106.9-149.5: Warning (avoid_de=
fault_addr_size): /switch/ports: Relying on default #address-cells value
arch/arm/boot/dts/bcm47094-asus-rt-ac88u.dts:106.9-149.5: Warning (avoid_de=
fault_addr_size): /switch/ports: Relying on default #size-cells value

Maybe introduced by commit

  3d2d52a0d183 ("ARM: dts: BCM5301X: define RTL8365MB switch on Asus RT-AC8=
8U")

--=20
Cheers,
Stephen Rothwell

--Sig_/4DpgRW6knj1wx2f5p4ku0FS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHDn9AACgkQAVBC80lX
0GyaeAf/WPrbTYp0eDL54QOzju9jt121EbbKjsU2jpj2BC3U80Hsed2r66fcmYkJ
WaUIm0VojkPQXMRD9Zw/4qO58tzFl2oEYPwNA5N+R7cv4Mpm0ysazrkpU0g3IWw4
TTFMOTAhwvcxKZVjbKHAKre98bQ3VWbmPfCQuhHmXmwaMwZtwnbGdQ+faRJrl71U
vz7bXDekUwsmqxFAGGpQMOau48oR/TqmPYgk7SieDBHe9k1Xck8ZLry+RMdzV3QA
9xtH0cOXBYMS9Pw5VYmxA7VFxtxPPAG2ehtlrY76HcNWwVn9fKoNsk04qsgyIyUj
7QCkOCNY6We4FVk1pH3m+LCUPut+Tw==
=UBpu
-----END PGP SIGNATURE-----

--Sig_/4DpgRW6knj1wx2f5p4ku0FS--
