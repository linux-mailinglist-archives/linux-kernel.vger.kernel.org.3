Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE74780EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 00:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhLPXxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 18:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhLPXxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 18:53:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CBBC061574;
        Thu, 16 Dec 2021 15:53:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JFTTc2VdLz4xd4;
        Fri, 17 Dec 2021 10:53:40 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1639698820;
        bh=tREWjUB7Lo11JMZ2tyf9VLjqdQ4MvuTTGIoWhPSRTQA=;
        h=Date:From:To:Cc:Subject:From;
        b=hWHVsmzlxSP3QqjZ1R7sFjbvCrB6qZ5V+pawC+VIzrwFpWrbIAMRxylmXJ1Qmd+wb
         Wl8fqA+f2qwjVnbz2hNJHNcqGVnEiCJhEnOXmkZSBolHTw9XIvY7cZbklAjnJgtVn1
         IV8DSOC3Zd170rP3gzwRU4JG6FL6K9B6CdmQX/lSIQzL7fi7OD7E9wQjU8wP2ftQdO
         yRMORfInw2pHx/x53aBm4bEdvypt+2YuiX+kujS33S3VRNnOlZvCiPxw7ZL2lLYdZ9
         P7VBfVRTSPLYD3smtWV2Yh+EyYrA8jPYTMVseakYJE+9ExSi4mCNarhVLe5fPqpSO9
         Aur4oj+rIJaLw==
Date:   Fri, 17 Dec 2021 10:53:38 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Yunus Bas <y.bas@phytec.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the imx-mxs tree
Message-ID: <20211217105338.315a26b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CbBJ=od0GYrWNE5.T6v=+Tc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CbBJ=od0GYrWNE5.T6v=+Tc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the imx-mxs tree, today's linux-next build (arm
multi_v7_defconfig) produced this warning:

arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:50.3-13: Warning (re=
g_format): /soc/bus@2100000/mmc@2198000/wifi@1:reg: property has invalid le=
ngth (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning (pci_device_reg)=
: Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning (pci_device_bus_=
num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning (i2c_bus_reg): F=
ailed prerequisite 'reg_format'
arch/arm/boot/dts/imx6dl-phytec-mira-rdk-nand.dtb: Warning (spi_bus_reg): F=
ailed prerequisite 'reg_format'
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:48.16-51.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2198000/wifi@1: Relying on =
default #address-cells value
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:48.16-51.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2198000/wifi@1: Relying on =
default #size-cells value
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:50.3-13: Warning (re=
g_format): /soc/bus@2100000/mmc@2198000/wifi@1:reg: property has invalid le=
ngth (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning (pci_device_reg):=
 Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning (pci_device_bus_n=
um): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning (i2c_bus_reg): Fa=
iled prerequisite 'reg_format'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-emmc.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'reg_format'
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:48.16-51.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2198000/wifi@1: Relying on =
default #address-cells value
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:48.16-51.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2198000/wifi@1: Relying on =
default #size-cells value
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:50.3-13: Warning (re=
g_format): /soc/bus@2100000/mmc@2198000/wifi@1:reg: property has invalid le=
ngth (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning (pci_device_reg):=
 Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning (pci_device_bus_n=
um): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning (i2c_bus_reg): Fa=
iled prerequisite 'reg_format'
arch/arm/boot/dts/imx6q-phytec-mira-rdk-nand.dtb: Warning (spi_bus_reg): Fa=
iled prerequisite 'reg_format'
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:48.16-51.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2198000/wifi@1: Relying on =
default #address-cells value
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:48.16-51.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2198000/wifi@1: Relying on =
default #size-cells value
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:50.3-13: Warning (re=
g_format): /soc/bus@2100000/mmc@2198000/wifi@1:reg: property has invalid le=
ngth (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning (pci_device_reg)=
: Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning (pci_device_bus_=
num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning (i2c_bus_reg): F=
ailed prerequisite 'reg_format'
arch/arm/boot/dts/imx6qp-phytec-mira-rdk-nand.dtb: Warning (spi_bus_reg): F=
ailed prerequisite 'reg_format'
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:48.16-51.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2198000/wifi@1: Relying on =
default #address-cells value
arch/arm/boot/dts/imx6qdl-phytec-mira-peb-wlbt-05.dtsi:48.16-51.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2198000/wifi@1: Relying on =
default #size-cells value
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:86.3-13: Warning (re=
g_format): /soc/bus@2100000/mmc@2194000/wifi@1:reg: property has invalid le=
ngth (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb: Warning (pci_device_=
reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb: Warning (pci_device_=
bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb: Warning (i2c_bus_reg=
): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ul-phytec-segin-ff-rdk-nand.dtb: Warning (spi_bus_reg=
): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:84.16-87.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2194000/wifi@1: Relying on =
default #address-cells value
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:84.16-87.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2194000/wifi@1: Relying on =
default #size-cells value
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:86.3-13: Warning (re=
g_format): /soc/bus@2100000/mmc@2194000/wifi@1:reg: property has invalid le=
ngth (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb: Warning (pci_device=
_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb: Warning (pci_device=
_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb: Warning (i2c_bus_re=
g): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ull-phytec-segin-lc-rdk-nand.dtb: Warning (spi_bus_re=
g): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:84.16-87.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2194000/wifi@1: Relying on =
default #address-cells value
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:84.16-87.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2194000/wifi@1: Relying on =
default #size-cells value
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:86.3-13: Warning (re=
g_format): /soc/bus@2100000/mmc@2194000/wifi@1:reg: property has invalid le=
ngth (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1)
arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb: Warning (pci_device=
_reg): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb: Warning (pci_device=
_bus_num): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb: Warning (i2c_bus_re=
g): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ull-phytec-segin-ff-rdk-nand.dtb: Warning (spi_bus_re=
g): Failed prerequisite 'reg_format'
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:84.16-87.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2194000/wifi@1: Relying on =
default #address-cells value
arch/arm/boot/dts/imx6ul-phytec-segin-peb-wlbt-05.dtsi:84.16-87.4: Warning =
(avoid_default_addr_size): /soc/bus@2100000/mmc@2194000/wifi@1: Relying on =
default #size-cells value

Presumably introduced by commit

  0c3a5101ba31 ("ARM: dts: imx6: phytec: Add PEB-WLBT-05 support")

--=20
Cheers,
Stephen Rothwell

--Sig_/CbBJ=od0GYrWNE5.T6v=+Tc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmG70YIACgkQAVBC80lX
0Gyy1gf/f0hGpsGPoXnNSr0XV3BJxaxEmV3iGNManCWY55nYR+f8dHgs4GcDw8zz
4BmK5wADPeh+2L/0SKkwys2nZM+fjfSvoKF9dZHt4rFVdtKvuQJ9AoH5DbaujVjK
b1CJca4mXJJccAeIz2EmWdnKDelulm4KzOPucvbb0SjTFbUfytrxW4JCqqjQnq1Z
V3vYyAEa6L4GQHoqN0IhCHX033kNKq8w+Hlcw2Ly4W09VrYyn+yW3YThg8aRpf81
sa8IvCwmh4Y2Du/fSFRYhGUkm36NOzQKEDGEVlo8VmnftArRMfVQmXShZbQZYNDb
pKQ2Ho87C0+r2hwBajZOznsFyhGkSw==
=8Ke+
-----END PGP SIGNATURE-----

--Sig_/CbBJ=od0GYrWNE5.T6v=+Tc--
