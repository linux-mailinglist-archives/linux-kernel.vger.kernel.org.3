Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55374481BD9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 12:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239094AbhL3L6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 06:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239054AbhL3L6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 06:58:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A240BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 03:58:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42B4761694
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D411CC36AEA;
        Thu, 30 Dec 2021 11:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640865512;
        bh=zi/2L2367ZYP5k3jhseWEg8yYfdUQjKqLJETqjQ9Soo=;
        h=Date:From:To:Cc:Subject:From;
        b=H+WQqnJQxxshWj0toQrkMPkLnMG4qUJ0K4FZS7IIjpCm6h7j83ImtL20XV9GrFUf/
         BpeIoB0gJG3gn0gtd/PcV2mvnV2SgGoOR7iUoEgktaetqbLDKQwY7kk+l5ZermKSER
         LdmDoPGmDl4mEDg2YYcYtOCb9JHJQdj1A/Q305G5DW4Q0EA+xzADfdqWqxcb7cI0DB
         +6CeSzybJS3ClEiauqhnG5BfwE+ovnXKKUwpfmXg2USMXVnY3NtW1d9OJE6HqHzVZx
         /l9tQwtDKqHb+VGmqbNDwl3gsUtFrmqVZpUxikerRyF2+28IRR617EPOqjg1qyunf4
         MsqxZ7G20EYxg==
Date:   Thu, 30 Dec 2021 17:28:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL] Generic phy updates for v5.17-rc1
Message-ID: <Yc2e40P2pQrCl1Gn@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="KJqeocnZDCCswLy5"
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KJqeocnZDCCswLy5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive Generic phy updates which includes a bunch of new
driver and new device support.

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.17

for you to fetch changes up to 09d976b3e8e257ff44405b6506bbaae6be1a6b3c:

  phy: cadence: Sierra: Add support for derived reference clock output (202=
1-12-27 16:35:09 +0530)

----------------------------------------------------------------
phy-for-5.17

  - New support:
        - Qualcomm eDP PHY driver
	- Qualcomm SM8450 UFS, USB2, USB3, PCIe0 and PCIe1 phy support
	- Lan966x ethernet serdes PHY driver
	- Support for uniphier NXI & Pro4 SoC
        - Qualcomm SM6350 USB2 support
	- Amlogic Meson8 HDMI TX PHY driver
	- Rockchip rk3568 usb2 support
	- Intel Thunder Bay eMMC PHY driver
	- Freescale IMX8 PCIe phy driver

  - Updates:
	- Cadence Sierra driver updates for multilink configurations
        - Bcm usb2 updates for Phy reg space

----------------------------------------------------------------
Aswath Govindraju (1):
      phy: phy-can-transceiver: Make devm_gpiod_get optional

Bjorn Andersson (2):
      dt-bindings: phy: Introduce Qualcomm eDP PHY binding
      phy: qcom: Introduce new eDP PHY driver

Chunfeng Yun (5):
      dt-bindings: phy: mediatek: tphy: support software efuse load
      phy: phy-mtk-tphy: add support efuse setting
      phy: mediatek: add helpers to update bits of registers
      phy: phy-mtk-xsphy: use new io helpers to access register
      phy: phy-mtk-tphy: use new io helpers to access register

Colin Ian King (1):
      phy: rockchip-inno-usb2: remove redundant assignment to variable delay

David Heidelberg (1):
      dt-bindings: phy: Tegra194 P2U convert to YAML

Dmitry Baryshkov (4):
      dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
      phy: qcom-qmp: Add SM8450 PCIe0 PHY support
      dt-bindings: phy: qcom,qmp: Add SM8450 PCIe PHY bindings
      phy: qcom-qmp: Add SM8450 PCIe1 PHY support

Fabrice Gasnier (1):
      phy: stm32: adopt dev_err_probe for regulators

Guo Zhengkui (1):
      phy: qcom: use struct_size instead of sizeof

Horatiu Vultur (5):
      dt-bindings: phy: Add lan966x-serdes binding
      dt-bindings: phy: Add constants for lan966x serdes
      phy: Add lan966x ethernet serdes PHY driver
      phy: lan966x: Extend lan966x to support multiple phy interfaces.
      phy: lan966x: Remove set_speed function

Kunihiko Hayashi (8):
      dt-bindings: phy: uniphier-usb3: Add bindings for NX1 SoC
      phy: uniphier-usb3: Add compatible string for NX1 SoC
      dt-bindings: phy: uniphier-pcie: Add bindings for NX1 SoC
      phy: uniphier-pcie: Add compatible string and SoC-dependent data for =
NX1 SoC
      phy: uniphier-pcie: Set VCOPLL clamp mode in PHY register
      phy: uniphier-pcie: Add dual-phy support for NX1 SoC
      dt-bindings: phy: uniphier-ahci: Add bindings for Pro4 SoC
      phy: uniphier-ahci: Add support for Pro4 SoC

Luca Weiss (1):
      dt-bindings: phy: qcom,qusb2: Add SM6350 compatible

Martin Blumenstingl (2):
      dt-bindings: phy: Add the Amlogic Meson8 HDMI TX PHY bindings
      phy: amlogic: Add a new driver for the HDMI TX PHY on Meson8/8b/8m2

Miaoqian Lin (3):
      phy: tegra: xusb: Fix return value of tegra_xusb_find_port_node funct=
ion
      phy: ti: Use IS_ERR_OR_NULL() to clean code
      phy: mediatek: Fix missing check in mtk_mipi_tx_probe

Peter Geis (5):
      dt-bindings: phy: phy-rockchip-inno-usb2: add rk3568 documentation
      phy: phy-rockchip-inno-usb2: support #address_cells =3D 2
      phy: phy-rockchip-inno-usb2: support standalone phy nodes
      phy: phy-rockchip-inno-usb2: support muxed interrupts
      phy: phy-rockchip-inno-usb2: add rk3568 support

Rafa=C5=82 Mi=C5=82ecki (2):
      phy: bcm-ns-usb2: support updated DT binding with PHY reg space
      phy: bcm-ns-usb2: improve printing ref clk errors

Rashmi A (2):
      dt-bindings: phy: intel: Add Thunder Bay eMMC PHY bindings
      phy: intel: Add Thunder Bay eMMC PHY support

Richard Zhu (3):
      dt-bindings: phy: phy-imx8-pcie: Add binding for the pad modes of imx=
8 pcie phy
      dt-bindings: phy: Add imx8 pcie phy driver support
      phy: freescale: pcie: Initialize the imx8 pcie standalone phy driver

Ryuta NAKANISHI (1):
      phy: uniphier-usb3ss: fix unintended writing zeros to PHY register

Swapnil Jakhade (15):
      phy: cadence: Sierra: Use of_device_get_match_data() to get driver da=
ta
      phy: cadence: Sierra: Prepare driver to add support for multilink con=
figurations
      dt-bindings: phy: cadence-torrent: Rename SSC macros to use generic n=
ames
      dt-bindings: phy: cadence-sierra: Add binding to specify SSC mode
      phy: cadence: Sierra: Add support to get SSC type from device tree
      phy: cadence: Sierra: Rename some regmap variables to be in sync with=
 Sierra documentation
      phy: cadence: Sierra: Add PHY PCS common register configurations
      phy: cadence: Sierra: Check cmn_ready assertion during PHY power on
      phy: cadence: Sierra: Check PIPE mode PHY status to be ready for oper=
ation
      phy: cadence: Sierra: Update single link PCIe register configuration
      phy: cadence: Sierra: Fix to get correct parent for mux clocks
      phy: cadence: Sierra: Add support for PHY multilink configurations
      phy: cadence: Sierra: Add PCIe + QSGMII PHY multilink configuration
      dt-bindings: phy: cadence-sierra: Add clock ID for derived reference =
clock
      phy: cadence: Sierra: Add support for derived reference clock output

Vinod Koul (7):
      scsi: ufs: dt-bindings: Add SM8450 compatible strings
      dt-bindings: phy: qcom,qmp: Add SM8450 UFS phy compatible
      phy: qcom-qmp: Add SM8450 UFS QMP Phy
      phy: freescale: pcie: explicitly add bitfield.h
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add bindings for SM8450
      dt-bindings: phy: qcom,qmp: Add SM8450 USB3 PHY
      phy: qcom-qmp: Add SM8450 USB QMP PHYs

Yang Guang (1):
      phy: cadence-torrent: use swap() to make code cleaner

Zou Wei (1):
      phy: intel: Remove redundant dev_err call in thunderbay_emmc_phy_prob=
e()

 .../bindings/phy/amlogic,meson8-hdmi-tx-phy.yaml   |   65 +
 .../devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |   92 ++
 .../bindings/phy/intel,phy-thunderbay-emmc.yaml    |   46 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   18 +
 .../bindings/phy/microchip,lan966x-serdes.yaml     |   59 +
 .../bindings/phy/phy-cadence-sierra.yaml           |    9 +
 .../bindings/phy/phy-cadence-torrent.yaml          |    4 +-
 .../bindings/phy/phy-rockchip-inno-usb2.yaml       |   44 +-
 .../devicetree/bindings/phy/phy-tegra194-p2u.txt   |   28 -
 .../devicetree/bindings/phy/phy-tegra194-p2u.yaml  |   44 +
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   67 +
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    6 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |    1 +
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |    1 +
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |   21 +-
 .../bindings/phy/socionext,uniphier-pcie-phy.yaml  |    1 +
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |    1 +
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |    1 +
 .../devicetree/bindings/ufs/ufshcd-pltfrm.txt      |    1 +
 MAINTAINERS                                        |    7 +
 drivers/phy/amlogic/Kconfig                        |   10 +
 drivers/phy/amlogic/Makefile                       |    1 +
 drivers/phy/amlogic/phy-meson8-hdmi-tx.c           |  160 +++
 drivers/phy/broadcom/phy-bcm-ns-usb2.c             |   54 +-
 drivers/phy/cadence/phy-cadence-sierra.c           | 1312 ++++++++++++++++=
++--
 drivers/phy/cadence/phy-cadence-torrent.c          |    6 +-
 drivers/phy/freescale/Kconfig                      |    8 +
 drivers/phy/freescale/Makefile                     |    1 +
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |  237 ++++
 drivers/phy/intel/Kconfig                          |   10 +
 drivers/phy/intel/Makefile                         |    1 +
 drivers/phy/intel/phy-intel-thunderbay-emmc.c      |  509 ++++++++
 drivers/phy/mediatek/phy-mtk-io.h                  |   38 +
 drivers/phy/mediatek/phy-mtk-mipi-dsi.c            |    2 +
 drivers/phy/mediatek/phy-mtk-tphy.c                |  608 ++++-----
 drivers/phy/mediatek/phy-mtk-xsphy.c               |  140 +--
 drivers/phy/microchip/Kconfig                      |    8 +
 drivers/phy/microchip/Makefile                     |    1 +
 drivers/phy/microchip/lan966x_serdes.c             |  545 ++++++++
 drivers/phy/microchip/lan966x_serdes_regs.h        |  209 ++++
 drivers/phy/phy-can-transceiver.c                  |    4 +-
 drivers/phy/qualcomm/Kconfig                       |   10 +
 drivers/phy/qualcomm/Makefile                      |    1 +
 drivers/phy/qualcomm/phy-qcom-edp.c                |  674 ++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                |  313 +++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  104 ++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |  260 +++-
 drivers/phy/socionext/Kconfig                      |    2 +-
 drivers/phy/socionext/phy-uniphier-ahci.c          |  201 ++-
 drivers/phy/socionext/phy-uniphier-pcie.c          |   70 +-
 drivers/phy/socionext/phy-uniphier-usb3hs.c        |    4 +
 drivers/phy/socionext/phy-uniphier-usb3ss.c        |   14 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |   10 +-
 drivers/phy/tegra/xusb.c                           |    2 +-
 drivers/phy/ti/phy-omap-control.c                  |    6 +-
 include/dt-bindings/phy/phy-cadence.h              |    9 +-
 include/dt-bindings/phy/phy-imx8-pcie.h            |   14 +
 include/dt-bindings/phy/phy-lan966x-serdes.h       |   14 +
 58 files changed, 5464 insertions(+), 624 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,meson8-hd=
mi-tx-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8-pcie-phy=
=2Eyaml
 create mode 100644 Documentation/devicetree/bindings/phy/intel,phy-thunder=
bay-emmc.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x=
-serdes.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.=
txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.=
yaml
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
 create mode 100644 drivers/phy/amlogic/phy-meson8-hdmi-tx.c
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8m-pcie.c
 create mode 100644 drivers/phy/intel/phy-intel-thunderbay-emmc.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-io.h
 create mode 100644 drivers/phy/microchip/lan966x_serdes.c
 create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-edp.c
 create mode 100644 include/dt-bindings/phy/phy-imx8-pcie.h
 create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h

Thanks
--=20
~Vinod

--KJqeocnZDCCswLy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmHNnuMACgkQfBQHDyUj
g0ddcBAAkQ4VvTkejx5WUpuQLYaswja+uxvxjjGVQDLm9mafKAGzeea4OqLC07DN
r6VuYHSybmsNkZtn/cZ0q8O/womB+IoeXnV2qtXC0BgdlmAS7e8mdLiHXDQclwsa
YyI59abFOfPoaYpqTvNxObusavYNp0S464i7VQ/dpIcq3ts3AV6GJ6T8cx+zqx74
77RJyQEif0/CXPBRER9dgCq70YHTCK8gSQkkcu9MaKaBM3EvO9VV0AeMbcS5HrxN
Ay+byzCLw6o+WxE1wtkfAEXZs6SeRB/0Na09p+7bBTOBxrGdvTTI7qjjbOFFKxwL
L+qbDXvjPwkTZdbRtCR3LuQsgXY0HHjshfDL4V2+62aGqCNGQGUY1/V/rIfWaPzQ
HFBrZeQy2bXFwmnv2MEkiT5OeyhDVhRSUQaJG8mk4HHLVhOF78O3wUPexNzyO7vc
RFZrKrIclDRxm2gss3NIUu/JJexgd9Nt0sEgDkBwDec+0nZ6qM/T3EIeX+MPSRXt
eZ+FtLIlFgLc7WbyoQtO64IChCQ9t0tLhOp7I9e3+GghiY6zVZE4FDPhQLgromxm
Pe9EbfXPA/BnpAiAPSjhaJ1IWGX0v+rs2NA3YJ+RkvPmPM/q6F1ECfVSaQTOxyxI
TpiylJkv05re/QPH3pBjE+XDpXcfnGcR6I5OU2LqtrrDSAsnk6g=
=N0yk
-----END PGP SIGNATURE-----

--KJqeocnZDCCswLy5--
