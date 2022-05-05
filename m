Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8A051CC60
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 00:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386524AbiEEXCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 19:02:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386483AbiEEXCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 19:02:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3C8B5F26A;
        Thu,  5 May 2022 15:58:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvTd528d6z4ySt;
        Fri,  6 May 2022 08:58:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651791498;
        bh=ulHf3pZ7Bcd379ocJhrqh4GtTsz+fjXWpoCg96g0S4E=;
        h=Date:From:To:Cc:Subject:From;
        b=r5d0ocPCpwsX6BAJ6EbWnPBHc3Vor+zsV51/sX3Uidapy5YjnwyNC8FH8P1Cfd/nv
         3uPE//Y4aCzC2frvNt3ANbHnzz3KLyUX5Q+uAsJcAzwux8FG3MiDUxWDkqF7MzdwNe
         5ZhyzSUysIRryvrMd4nN1kVq594XK4tyWfMqQKOXzH+f8O/jxB14XNkQSXFIMPohOQ
         3FPFuX1jDPob6eGeXvT4FiwyNx2Q63yr9VQ8bagjoQiA+LFlO30+tT94K1LMoYO0p9
         BUh7/+Fk7BpHBPigT7wm3L9VSNe/QGU9Mee7/O2u4wExYz3uzPaQzB3ni71hgZhc+X
         8XcQa/QCKOjQg==
Date:   Fri, 6 May 2022 08:58:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the arm-soc tree
Message-ID: <20220506085815.5a3cfa83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/gHF8k2jQ5Od62eB7rhX/E.2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/gHF8k2jQ5Od62eB7rhX/E.2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm-soc tree, today's linux-next build (arm
multi_v7_defconfig) produced these warnings:

arch/arm/boot/dts/bcm953012hr.dts:57.3-33: Warning (reg_format): /nand-cont=
roller@18028000/nand@0/partition@0:reg: property has invalid length (8 byte=
s) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/bcm953012hr.dts:62.3-33: Warning (reg_format): /nand-cont=
roller@18028000/nand@0/partition@200000:reg: property has invalid length (8=
 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/bcm953012hr.dts:66.3-33: Warning (reg_format): /nand-cont=
roller@18028000/nand@0/partition@600000:reg: property has invalid length (8=
 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/bcm953012hr.dts:70.3-33: Warning (reg_format): /nand-cont=
roller@18028000/nand@0/partition@1000000:reg: property has invalid length (=
8 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_reg): Failed prerequ=
isite 'reg_format'
arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_bus_num): Failed pre=
requisite 'reg_format'
arch/arm/boot/dts/bcm953012hr.dtb: Warning (i2c_bus_reg): Failed prerequisi=
te 'reg_format'
arch/arm/boot/dts/bcm953012hr.dtb: Warning (spi_bus_reg): Failed prerequisi=
te 'reg_format'
arch/arm/boot/dts/bcm953012hr.dts:55.14-59.4: Warning (avoid_default_addr_s=
ize): /nand-controller@18028000/nand@0/partition@0: Relying on default #add=
ress-cells value
arch/arm/boot/dts/bcm953012hr.dts:55.14-59.4: Warning (avoid_default_addr_s=
ize): /nand-controller@18028000/nand@0/partition@0: Relying on default #siz=
e-cells value
arch/arm/boot/dts/bcm953012hr.dts:60.19-63.4: Warning (avoid_default_addr_s=
ize): /nand-controller@18028000/nand@0/partition@200000: Relying on default=
 #address-cells value
arch/arm/boot/dts/bcm953012hr.dts:60.19-63.4: Warning (avoid_default_addr_s=
ize): /nand-controller@18028000/nand@0/partition@200000: Relying on default=
 #size-cells value
arch/arm/boot/dts/bcm953012hr.dts:64.19-67.4: Warning (avoid_default_addr_s=
ize): /nand-controller@18028000/nand@0/partition@600000: Relying on default=
 #address-cells value
arch/arm/boot/dts/bcm953012hr.dts:64.19-67.4: Warning (avoid_default_addr_s=
ize): /nand-controller@18028000/nand@0/partition@600000: Relying on default=
 #size-cells value
arch/arm/boot/dts/bcm953012hr.dts:68.20-71.4: Warning (avoid_default_addr_s=
ize): /nand-controller@18028000/nand@0/partition@1000000: Relying on defaul=
t #address-cells value
arch/arm/boot/dts/bcm953012hr.dts:68.20-71.4: Warning (avoid_default_addr_s=
ize): /nand-controller@18028000/nand@0/partition@1000000: Relying on defaul=
t #size-cells value

I don't know what caused this now.

--=20
Cheers,
Stephen Rothwell

--Sig_/gHF8k2jQ5Od62eB7rhX/E.2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ0VocACgkQAVBC80lX
0Gz74Af/bAh/Nxuf7Iqp0ZYFzVlW+zeGkD7xS0U6n+Z6pPWDplHM2J0tymMU403v
X9NWgfyyWh93IzFniQZ8+7eGI5Y+6FGkAmNYU/6WciN+VAx0z7fzdK0HMVsFWB/N
+aOrCpP+eR5fZovYfixHzGB0FRx2LMBi/PZTt8/4Vz/oUHaewszQUx2OvayVTzl5
ZD+sW0KhGkXiTyNiRrdzrG1GkPjh/S4sQUKoVO89BLOr4iglZHcM5bZo9qOF248Q
OuTG2g5RPOsg34IuybNudgrAEYQQ2LShVYPsiTMPXTz6m6GTgjfuTu2iWdCtc6qI
KSICnyqP/mtXt/382lmc5EelNeWuUw==
=Ct30
-----END PGP SIGNATURE-----

--Sig_/gHF8k2jQ5Od62eB7rhX/E.2--
