Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BCE57924F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 07:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbiGSFHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 01:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiGSFHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 01:07:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7671B84E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 22:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 298C6614DA
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 05:07:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC260C341C6;
        Tue, 19 Jul 2022 05:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658207262;
        bh=b+AqkqbiH6woJiAQc0xtb404/lfJwAGw6j1VxnWEXIk=;
        h=Date:From:To:Cc:Subject:From;
        b=gzFKTvPPe1novl4h8ju/vEUt4dPs5kyi/rxdXcuwF0+dVu6r9ANrqcZ3lCcbR07Be
         N6cYx7qGnYNIs5v1iFiqCOXzbiZLHAa0rE6WwRnaVEvPjDs2OqeOAweh/EjIyRcIca
         DFso6d0aW4WqrAxSP6LI52lR2C3yvk2NARni/KnNwIGj5SwiKKHKaYgSktr7HtIGBF
         Yn0NxBEEJ+LIaV0qzWg/xr/FMIUVF34cR+ODuhCRL0qn8QvKhUz9WPmecP3yPypZqr
         5E/TiaO8DMUGndkRutDb5N/RZS+HO3ytQq3Yc2Om2lmSNDCi8p9zQpSDJa0fsfrAo3
         CrvDoSL7RJWPw==
Date:   Tue, 19 Jul 2022 10:37:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL]: Generic phy updates for v5.20
Message-ID: <YtY8Ggzsqa1MwjL5@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ppY62escyzQLMEqG"
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ppY62escyzQLMEqG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive Generic phy updates for v5.20. This contains
bunch of new support for devices in existing drivers, as well as new
drivers. Also the big Qualcomm qmp phy cleanup is part of this pull
request.

The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.20

for you to fetch changes up to 08680588d340eaad2d5028d6f24a055a118d4e7e:

  dt-bindings: phy: mediatek: tphy: add compatible for mt8188 (2022-07-15 1=
7:20:04 +0530)

----------------------------------------------------------------
phy-for-5.20

  - New support:
        - Samsung FSD ufs phy
	- Mediatek MT8365 dsi and tphy support
	- Amlogic G12A Analog D-PHY driver
	- Mediatek MT8188 tphy support
	- Mediatek PCIe phy driver
	- Cadence J721e DPHY support
	- Qualcomm IPQ8074 PCIe Gen3 PHY support
	- Nvidia Tegra PCIe PIPE2UPHY support

  - Updates:
	- Split of Qualcomm combo qmp phy driver to ufs, usb, pcie phy
	  drivers and associated cleanup of these drivers

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: phy: mxs-usb-phy: Add i.MX8DXL compatible string

Alim Akhtar (3):
      dt-bindings: phy: Add FSD UFS PHY bindings
      phy: samsung-ufs: move cdr offset to drvdata
      phy: samsung-ufs: add support for FSD ufs phy driver

Andy Shevchenko (1):
      phy: ti: tusb1210: Don't check for write errors when powering on

Chanho Park (8):
      dt-bindings: phy: samsung,ufs-phy: make pmu-syscon as phandle-array
      phy: samsung: ufs: rename cfg to cfgs for clarification
      phy: samsung: ufs: constify samsung_ufs_phy_cfg
      phy: samsung: ufs: remove drvdata from struct samsung_ufs_phy
      phy: samsung: ufs: support secondary ufs phy
      phy: samsung: exynosautov9-ufs: correct TSRV register configurations
      phy: samsung-ufs: convert phy clk usage to clk_bulk API
      phy: samsung-ufs: ufs: change phy on/off control

Chunfeng Yun (1):
      dt-bindings: phy: mediatek: tphy: add compatible for mt8188

Dmitry Baryshkov (60):
      phy: qcom-qmp: create copies of QMP PHY driver
      phy: qcom-qmp-pcie: drop all non-PCIe compatibles support
      phy: qcom-qmp-pcie-msm8996: drop all compatibles except msm8996-pcie-=
phy
      phy: qcom-qmp-ufs: drop all non-UFS compatibles support
      phy: qcom-qmp-usb: drop all non-USB compatibles support
      phy: qcom-qmp-combo: drop all non-combo compatibles support
      phy: qcom-qmp-combo: change symbol prefix to qcom_qmp_phy_combo
      phy: qcom-qmp-pcie: change symbol prefix to qcom_qmp_phy_pcie
      phy: qcom-qmp-pcie: change symbol prefix to qcom_qmp_phy_pcie_msm8996
      phy: qcom-qmp-ufs: change symbol prefix to qcom_qmp_phy_ufs
      phy: qcom-qmp-usb: change symbol prefix to qcom_qmp_phy_usb
      phy: qcom-qmp: switch to new split QMP PHY driver
      phy: qcom-qmp: drop old QMP PHY driver source
      phy: qcom-qmp-combo: drop support for PCIe,UFS PHY types
      phy: qcom-qmp-pcie: drop support for non-PCIe PHY types
      phy: qcom-qmp-pcie-msm8996: drop support for non-PCIe PHY types
      phy: qcom-qmp-ufs: drop support for non-UFS PHY types
      phy: qcom-qmp-usb: drop support for non-USB PHY types
      phy: qcom-qmp-combo: cleanup the driver
      phy: qcom-qmp-pcie: cleanup the driver
      phy: qcom-qmp-pcie-msm8996: cleanup the driver
      phy: qcom-qmp-ufs: cleanup the driver
      phy: qcom-qmp-usb: cleanup the driver
      phy: qcom-qmp-pcie: drop multi-PHY support
      phy: qcom-qmp-ufs: drop multi-PHY support
      phy: qcom-qmp-usb: drop multi-PHY support
      phy: qcom-qmp-combo: use bulk reset_control API
      phy: qcom-qmp-pcie: use bulk reset_control API
      phy: qcom-qmp-pcie-msm8996: use bulk reset_control API
      phy: qcom-qmp-usb: use bulk reset_control API
      phy: qcom-qmp: fix msm8996 PCIe PHY support
      phy: qcom-qmp: fix PCIe PHY support
      phy: qcom-qmp: fix the QSERDES_V5_COM_CMN_MODE register
      phy: qcom-qmp-ufs: remove spurious register write in the msm8996 table
      phy: qcom-qmp-combo,usb: add support for separate PCS_USB region
      phy: qcom-qmp-pcie: split pcs_misc region for ipq6018 pcie gen3
      phy: qcom-qmp: drop special QMP V2 PCIE gen3 defines
      phy: qcom-qmp: rename QMP V2 PCS registers
      phy: qcom-qmp: use QPHY_V4_PCS for ipq6018/ipq8074 PCIe gen3
      phy: qcom-qmp: move QSERDES registers to separate header
      phy: qcom-qmp: move QSERDES V3 registers to separate headers
      phy: qcom-qmp: move QSERDES V4 registers to separate headers
      phy: qcom-qmp: move QSERDES V5 registers to separate headers
      phy: qcom-qmp: move QSERDES PLL registers to separate header
      phy: qcom-qmp: move PCS V2 registers to separate header
      phy: qcom-qmp: move PCS V3 registers to separate headers
      phy: qcom-qmp: move PCS V4 registers to separate headers
      phy: qcom-qmp: move PCS V5 registers to separate headers
      phy: qcom-qmp: move PCIE QHP registers to separate header
      phy: qcom-qmp: split allegedly 4.20 and 5.20 TX/RX registers
      phy: qcom-qmp: split allegedly 4.20 and 5.20 PCS registers
      phy: qcom-qmp: split PCS_UFS V3 symbols to separate header
      phy: qcom-qmp: qserdes-com: add missing registers
      phy: qcom-qmp: qserdes-com-v3: add missing registers
      phy: qcom-qmp: qserdes-com-v4: add missing registers
      phy: qcom-qmp: qserdes-com-v5: add missing registers
      phy: qcom-qmp: pcs-v3: add missing registers
      phy: qcom-qmp: pcs-pcie-v4: add missing registers
      phy: qcom-qmp-usb: replace FLL layout writes for msm8996
      phy: qcom-qmp-usb: define QPHY_V2_PCS_PLL_LOCK_CHK_DLY_TIME register

Douglas Anderson (1):
      dt-bindings: phy: List supplies for qcom,edp-phy

Fabien Parent (2):
      dt-bindings: phy: mediatek,dsi-phy: Add MT8365 SoC bindings
      dt-bindings: phy: mediatek,tphy: add MT8365 SoC bindings

Fabrice Gasnier (1):
      phy: stm32: fix error return in stm32_usbphyc_phy_init

Geert Uytterhoeven (1):
      dt-bindings: phy: renesas: usb3-phy: Spelling s/funcional/functional/

Jiang Jian (2):
      phy: dphy: drop unexpected word "the" in the comments
      phy: phy-brcm-usb: drop unexpected word "the" in the comments

Jianjun Wang (2):
      dt-bindings: phy: mediatek: Add YAML schema for PCIe PHY
      phy: mediatek: Add PCIe PHY driver

Johan Hovold (6):
      phy: qcom-qmp-pcie: drop obsolete pipe clock type check
      phy: qcom-qmp-pcie-msm8996: drop obsolete pipe clock type check
      phy: qcom-qmp-usb: clean up pipe clock handling
      phy: qcom-qmp: clean up v4 and v5 define order
      phy: qcom-qmp: clean up define alignment
      phy: qcom-qmp: clean up hex defines

Kuogee Hsieh (3):
      phy: qcom-edp: add regulator_set_load to edp phy
      phy: qcom-qmp: add regulator_set_load to dp phy
      drm/msm/dp: delete vdda regulator related functions from eDP/DP contr=
oller

Lars-Peter Clausen (2):
      phy: cadence: Sierra: Remove unused `regmap` field from state struct
      phy: cadence-torrent: Remove unused `regmap` field from state struct

Liu Ying (3):
      dt-bindings: vendor-prefixes: Add prefix for Mixel, Inc.
      dt-bindings: phy: Add Freescale i.MX8qm Mixel LVDS PHY binding
      phy: freescale: Add i.MX8qm Mixel LVDS PHY support

Lukas Bulwahn (1):
      MAINTAINERS: add include/dt-bindings/phy to GENERIC PHY FRAMEWORK

Markus Schneider-Pargmann (1):
      phy: phy-mtk-dp: Add driver for DP phy

Neil Armstrong (2):
      dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
      phy: amlogic: Add G12A Analog MIPI D-PHY driver

Peter Geis (2):
      phy: rockchip-inno-usb2: Prevent incorrect error on probe
      phy: rockchip-inno-usb2: Sync initial otg state

Rahul T R (3):
      phy: dt-bindings: cdns,dphy: Add compatible for dphy on j721e
      phy: cdns-dphy: Add band config for dphy tx
      phy: cdns-dphy: Add support for DPHY TX on J721e

Robert Marko (3):
      phy: qcom-qmp-pcie: make pipe clock rate configurable
      dt-bindings: phy: qcom,qmp: add IPQ8074 PCIe Gen3 PHY binding
      phy: qcom-qmp-pcie: add IPQ8074 PCIe Gen3 QMP PHY support

Roger Quadros (1):
      phy: ti: phy-j721e-wiz: use OF data for device specific data

Samuel Holland (1):
      phy: rockchip-inno-usb2: Ignore OTG IRQs in host mode

Vidya Sagar (2):
      dt-bindings: PHY: P2U: Add support for Tegra234 P2U block
      phy: tegra: Add PCIe PIPE2UPHY support for Tegra234

Vinod Koul (1):
      phy: qcom-qmp-usb: statify qmp_phy_vreg_l

Yang Yingliang (1):
      phy: phy-mtk-dp: change mtk_dp_phy_driver to static

 .../phy/amlogic,g12a-mipi-dphy-analog.yaml         |   35 +
 .../devicetree/bindings/phy/cdns,dphy.yaml         |    5 +-
 .../bindings/phy/fsl,imx8qm-lvds-phy.yaml          |   61 +
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |    4 +
 .../devicetree/bindings/phy/mediatek,pcie-phy.yaml |   75 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |    2 +
 .../devicetree/bindings/phy/mxs-usb-phy.txt        |    1 +
 .../devicetree/bindings/phy/phy-tegra194-p2u.yaml  |   17 +-
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |    6 +
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    2 +
 .../devicetree/bindings/phy/renesas,usb3-phy.yaml  |    2 +-
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |   15 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |    2 +
 MAINTAINERS                                        |    2 +
 drivers/gpu/drm/msm/dp/dp_parser.c                 |   14 -
 drivers/gpu/drm/msm/dp/dp_parser.h                 |    8 -
 drivers/gpu/drm/msm/dp/dp_power.c                  |   95 +-
 drivers/phy/amlogic/Kconfig                        |   12 +
 drivers/phy/amlogic/Makefile                       |    1 +
 drivers/phy/amlogic/phy-meson-axg-mipi-dphy.c      |    2 +-
 .../phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c  |  171 +
 drivers/phy/broadcom/phy-brcm-usb-init.c           |    2 +-
 drivers/phy/cadence/cdns-dphy.c                    |  101 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |    1 -
 drivers/phy/cadence/phy-cadence-torrent.c          |    1 -
 drivers/phy/freescale/Kconfig                      |    9 +
 drivers/phy/freescale/Makefile                     |    1 +
 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c    |  450 ++
 drivers/phy/mediatek/Kconfig                       |   19 +
 drivers/phy/mediatek/Makefile                      |    2 +
 drivers/phy/mediatek/phy-mtk-dp.c                  |  202 +
 drivers/phy/mediatek/phy-mtk-pcie.c                |  267 +
 drivers/phy/qualcomm/Makefile                      |    8 +-
 drivers/phy/qualcomm/phy-qcom-edp.c                |   12 +
 drivers/phy/qualcomm/phy-qcom-qmp-combo.c          | 2621 ++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c   | 1054 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie-qhp.h       |  123 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 2556 ++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v3.h    |   17 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4.h    |   72 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h |   17 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h    |   16 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h |   17 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v3.h     |   18 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v4.h     |   31 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h     |   27 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v4.h     |   34 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v5.h     |   36 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v2.h         |   46 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v3.h         |  145 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v4.h         |  135 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v4_20.h      |   15 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h         |   17 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v3.h |  111 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v4.h |  123 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h |  124 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com.h    |  140 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h    |   66 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v3.h    |   68 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h    |  233 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4_20.h |   43 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5.h    |  231 +
 .../phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h |   60 +
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx.h   |  205 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c            | 1383 +++++
 drivers/phy/qualcomm/phy-qcom-qmp-usb.c            | 2765 +++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 6350 ----------------=
----
 drivers/phy/qualcomm/phy-qcom-qmp.h                | 1242 +---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c      |   12 +-
 drivers/phy/samsung/Makefile                       |    1 +
 drivers/phy/samsung/phy-exynos7-ufs.c              |   12 +-
 drivers/phy/samsung/phy-exynosautov9-ufs.c         |   29 +-
 drivers/phy/samsung/phy-fsd-ufs.c                  |   63 +
 drivers/phy/samsung/phy-samsung-ufs.c              |  138 +-
 drivers/phy/samsung/phy-samsung-ufs.h              |   34 +-
 drivers/phy/st/phy-stm32-usbphyc.c                 |    4 +-
 drivers/phy/tegra/phy-tegra194-p2u.c               |   48 +-
 drivers/phy/ti/phy-j721e-wiz.c                     |   75 +-
 drivers/phy/ti/phy-tusb1210.c                      |    5 +-
 79 files changed, 14325 insertions(+), 7844 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi=
-dphy-analog.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/fsl,imx8qm-lvds-p=
hy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/mediatek,pcie-phy=
=2Eyaml
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-mipi-dphy-analog.c
 create mode 100644 drivers/phy/freescale/phy-fsl-imx8qm-lvds-phy.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-dp.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-pcie.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-combo.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcie-qhp.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-misc-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v4_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v5_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-ufs-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-usb-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v2.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v4_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-pll.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v3.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v4_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-v5_20.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx.h
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
 create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-usb.c
 delete mode 100644 drivers/phy/qualcomm/phy-qcom-qmp.c
 create mode 100644 drivers/phy/samsung/phy-fsd-ufs.c

--=20
~Vinod

--ppY62escyzQLMEqG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmLWPBoACgkQfBQHDyUj
g0cJKQ/9HwHtXLS2fahAPbZFEcoP1OgBruoXO3X5KUpOv5841l9MzYgRW4YJ3rGC
YJTVr6DEdfbfh7bnU9cjQXZWI4E16lnvVBWMenvD32k7XDWSUcQYoijRx7aMmn1e
FOiqFX6/FVDQRqpPQfu+y4BIvb7c9bbHHb8PSUMt1t1DQ8o53C1UfGmnsLbnJDeN
qV7L3FnX4eo++u/rqq19S+AjontrjKTkMjLyGT9cpo84isETarLKuEcCWHoGBwli
A7vbMrFg1rFgaGEO31ZmhorgSttKtaJBHe7j5ulHa9X0j+zJzUlgI2BoN3ooKaZc
RMgjZZ8x4R1ygdqa0GLJmwEI8tDKQVZzo13hxVI+UkC5ipR5ccdrm1+/tKP9qlRL
2H4GvSWqcmzX94muZYzQiL6ZdBj1LhZTPqPAg8MZArE/ddLNQjyNc6YjE+5QJESV
h5tB8pCm3T7HibmYqlspm6f74dd4g9YcXCPeYv6qs5qCe2LECyVzr2vhoqHHb2PT
r3BHUcrMRrXY44m3Ad/nEDnLZC0rmKHFGvKSaxw4wSWa1UppHcOe5OCxEdmxHoT0
OyeADqtf9RgrzgrJOtzTgbwajDcHgfLj6zwDA7ji9avTPu/0mkuybdY0RZPAlVjw
WxVOYctqMdH6b+x1j/AUl96Nvsk9bG8MxyZznbN/WzXXBg7xtlM=
=5Sg/
-----END PGP SIGNATURE-----

--ppY62escyzQLMEqG--
