Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79655525C55
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377796AbiEMH3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiEMH3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:29:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85C7A2A1535;
        Fri, 13 May 2022 00:29:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L00dq2NV6z4xLb;
        Fri, 13 May 2022 17:29:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652426976;
        bh=amBoUhAchuiKZLMpzSpOqMbdV/DoM2H/tnnKlO0EPgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e+PZmhjqeVy35zXpWfpmXn6hzAvj9cBX3QihjtQlY9Pf4p9SqK+Nju1zzbXfhBJ91
         zNS/CZh7xWm/+NImbNnSfGXWkKpCIlUv6zKlIVIjEuS7VUF23c25DUNsC0K5vOC86D
         1PA0LWE1e1m107qbphn0ozs0Yw/0yJOC4YFj7hgWiBaC9KfnqAjuswFcol8eVEZpmx
         2WNpkPlCf/1ScdCMshxe547kbFyBU+5z98pPTz6393e4FZWkd0+YFYUx4x/h3uNjo1
         Tta3ALV6dCuWNV5eJCU7wu8EzHwFVsjUT0YThRHunnq0hsoxfhxkaEruqr9hAxSlD7
         q14lz+HXS0AFg==
Date:   Fri, 13 May 2022 17:29:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the arm-soc tree
Message-ID: <20220513172933.5dbf4ffb@canb.auug.org.au>
In-Reply-To: <20220506085815.5a3cfa83@canb.auug.org.au>
References: <20220506085815.5a3cfa83@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+oID1gv3YK/8R5EMEQLZBIi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+oID1gv3YK/8R5EMEQLZBIi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 6 May 2022 08:58:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the arm-soc tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:
>=20
> arch/arm/boot/dts/bcm953012hr.dts:57.3-33: Warning (reg_format): /nand-co=
ntroller@18028000/nand@0/partition@0:reg: property has invalid length (8 by=
tes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
> arch/arm/boot/dts/bcm953012hr.dts:62.3-33: Warning (reg_format): /nand-co=
ntroller@18028000/nand@0/partition@200000:reg: property has invalid length =
(8 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
> arch/arm/boot/dts/bcm953012hr.dts:66.3-33: Warning (reg_format): /nand-co=
ntroller@18028000/nand@0/partition@600000:reg: property has invalid length =
(8 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
> arch/arm/boot/dts/bcm953012hr.dts:70.3-33: Warning (reg_format): /nand-co=
ntroller@18028000/nand@0/partition@1000000:reg: property has invalid length=
 (8 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
> arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_reg): Failed prere=
quisite 'reg_format'
> arch/arm/boot/dts/bcm953012hr.dtb: Warning (pci_device_bus_num): Failed p=
rerequisite 'reg_format'
> arch/arm/boot/dts/bcm953012hr.dtb: Warning (i2c_bus_reg): Failed prerequi=
site 'reg_format'
> arch/arm/boot/dts/bcm953012hr.dtb: Warning (spi_bus_reg): Failed prerequi=
site 'reg_format'
> arch/arm/boot/dts/bcm953012hr.dts:55.14-59.4: Warning (avoid_default_addr=
_size): /nand-controller@18028000/nand@0/partition@0: Relying on default #a=
ddress-cells value
> arch/arm/boot/dts/bcm953012hr.dts:55.14-59.4: Warning (avoid_default_addr=
_size): /nand-controller@18028000/nand@0/partition@0: Relying on default #s=
ize-cells value
> arch/arm/boot/dts/bcm953012hr.dts:60.19-63.4: Warning (avoid_default_addr=
_size): /nand-controller@18028000/nand@0/partition@200000: Relying on defau=
lt #address-cells value
> arch/arm/boot/dts/bcm953012hr.dts:60.19-63.4: Warning (avoid_default_addr=
_size): /nand-controller@18028000/nand@0/partition@200000: Relying on defau=
lt #size-cells value
> arch/arm/boot/dts/bcm953012hr.dts:64.19-67.4: Warning (avoid_default_addr=
_size): /nand-controller@18028000/nand@0/partition@600000: Relying on defau=
lt #address-cells value
> arch/arm/boot/dts/bcm953012hr.dts:64.19-67.4: Warning (avoid_default_addr=
_size): /nand-controller@18028000/nand@0/partition@600000: Relying on defau=
lt #size-cells value
> arch/arm/boot/dts/bcm953012hr.dts:68.20-71.4: Warning (avoid_default_addr=
_size): /nand-controller@18028000/nand@0/partition@1000000: Relying on defa=
ult #address-cells value
> arch/arm/boot/dts/bcm953012hr.dts:68.20-71.4: Warning (avoid_default_addr=
_size): /nand-controller@18028000/nand@0/partition@1000000: Relying on defa=
ult #size-cells value
>=20
> I don't know what caused this now.

I am still getting these warnings.

--=20
Cheers,
Stephen Rothwell

--Sig_/+oID1gv3YK/8R5EMEQLZBIi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ+CN4ACgkQAVBC80lX
0GxWawf/aR3e1ZdCSDAIxLd4A7nYxaIkdZ+29L+cGnukIOLND+soF1SwQi5P29o4
yRx9xzaOJWri9mDYuJvkT5wvkL8k3Fy3kyQbevhGGe4WcjnA81M9h/E9Zc3BYwK3
tpXCR5zvMHbfPJH9uYO8aIsgabhsQBobKPf734vh4up2cme+0pNZhKXE3sCm8Edg
e4pBHoYDoQJKUVb+Sfck5Vkt23dfvjLoPH+TYlZFlqs+0NxeLER8XoYsb0t+hGNf
SLs0zwcVVGL3WEeRS1YiRuBLCDHILzYHvlHm2RHH36XgKRli1Uos3Y3ZyT3QcMEF
1MDafRhQPoQOQLG9ece4SHR4zJqC7g==
=TPsA
-----END PGP SIGNATURE-----

--Sig_/+oID1gv3YK/8R5EMEQLZBIi--
