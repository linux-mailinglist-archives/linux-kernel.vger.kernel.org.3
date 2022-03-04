Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9895A4CDA97
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 18:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiCDRcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 12:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241225AbiCDRcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:32:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F11D06FB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 09:31:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70EB8B82AD6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 17:31:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562EFC340E9;
        Fri,  4 Mar 2022 17:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646415105;
        bh=bgXevccjItadLy8SOwBdmdr0b+S8SePNjm16udApYHo=;
        h=Date:From:To:Cc:Subject:From;
        b=K8HjDl7MTcMpimx7CZZiYO4/928BMO6Pu8Vkh3fRpM7rQmxfDGmzbG0qKmXjGjv14
         DR+7Zd/s1nhUF+EyRmqjSDnICBVbX2aYW/t3P/J4ZTBuff+eFVLg6sng31Ert1lfvQ
         wjhT9yL9V2tuN5d/tC4t57GIB5mhuhiVcKJPgDNVl2dZrd2aoI+tvKubd15Y4RYBmY
         91ZzYS5FWeZtQnRtm4H5uNqSvofg1/vvmXwwoXzp6r3MW9sE+OAVOQbiuAa61uauKn
         lAIloFjcklzVy5cT22VNn036EGLD4mAo90/F1nfpObRGCgLO6nVNt+AV8ablM8d7Qx
         uzmEok3SlYKdQ==
Date:   Fri, 4 Mar 2022 23:01:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [GIT PULL] Generic phy updates for v5.18-rc1
Message-ID: <YiJM/aHDOqqcvimp@matsya>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6+g71u/0irGe+9jL"
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6+g71u/0irGe+9jL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

Please pull to receive the Generic phy updates for v5.18. Bunch of new
device support and updates to few existing drivers.

The pull is based on fixes tag you had merged earlier. I had merged
that into next for resolving dependencies between next & fixes.

The following changes since commit 9a8406ba1a9a2965c27e0db1d7753471d12ee9ff:

  phy: dphy: Correct clk_pre parameter (2022-02-02 10:33:04 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-=
for-5.18

for you to fetch changes up to c6455af548991ed22c89528f998fd965c052fb2e:

  phy: qcom-qmp: add sc8280xp UFS PHY (2022-03-02 20:06:54 +0530)

----------------------------------------------------------------
phy-for-5.18

  - New support:
        - Mediatek tphy support for MT8186
	- Qualcomm usb phy support for sc8180x and sc8280xp
	- Qualcomm ufs phy support for sc8180x and sc8280xp
	- Qualcomm usb phy support for MSM8953
	- Cadence D-Phy Rx support
	- Sun4i support for USB phy
	- Rockchip naneng combo phy support for RK3568
	- Qualcomm eDP PHY for sc7280

  - Updates:
        - wake on support for Synopsis XHCI controllers
	- Yamilify Qualcomm USB HS phy binding
	- Charger detection support for TI tusb1210

----------------------------------------------------------------
Al Cooper (1):
      phy: usb: Add "wake on" functionality for newer Synopsis XHCI control=
lers

Allen-KH Cheng (2):
      dt-bindings: phy: Add compatible for Mediatek MT8186
      dt-bindings: phy: mediatek,tphy: Add compatible for MT8192

Amjad Ouled-Ameur (3):
      phy: amlogic: phy-meson-gxl-usb2: fix shared reset controller use
      phy: amlogic: meson8b-usb2: Use dev_err_probe()
      phy: amlogic: meson8b-usb2: fix shared reset control use

Andre Przywara (1):
      phy: sun4i-usb: Rework HCI PHY (aka "pmu_unk1") handling

Ansuel Smith (2):
      drivers: phy: qcom: ipq806x-usb: convert to BITFIELD macro
      drivers: phy: qcom: ipq806x-usb: conver latch function to pool macro

Aswath Govindraju (1):
      phy: cadence: Sierra: Add support for skipping configuration

Bjorn Andersson (4):
      dt-bindings: phy: qcom,usb-snps-femto-v2: Add sc8180x and sc8280xp
      phy: qcom-snps: Add sc8280xp support
      dt-bindings: phy: qcom,qmp: add sc8180x and sc8280xp ufs compatibles
      phy: qcom-qmp: add sc8280xp UFS PHY

David Heidelberg (1):
      dt-bindings: phy: convert Qualcomm USB HS phy to yaml

Geert Uytterhoeven (1):
      phy: freescale: i.MX8 PHYs should depend on ARCH_MXC && ARM64

Hans de Goede (3):
      phy: ti: tusb1210: Improve ulpi_read()/_write() error checking
      phy: ti: tusb1210: Drop tusb->vendor_specific2 !=3D 0 check from tusb=
1210_power_on()
      phy: ti: tusb1210: Add a delay between power-on and restoring the phy=
-parameters

Johan Jonker (1):
      dt-bindings: soc: grf: add naneng combo phy register compatible

Krzysztof Kozlowski (7):
      dt-bindings: phy: samsung: drop old Eynos5440 PCIe phy
      dt-bindings: phy: samsung,mipi-video-phy: convert to dtschema
      dt-bindings: phy: samsung,dp-video-phy: convert to dtschema
      dt-bindings: phy: samsung,usb2-phy: convert to dtschema
      dt-bindings: phy: samsung,exynos5250-sata-phy: convert to dtschema
      dt-bindings: phy: samsung: move SATA phy I2C to trivial devices
      dt-bindings: phy: samsung,usb3-drd-phy: convert to dtschema

Lad Prabhakar (1):
      dt-bindings: phy: renesas,usb2-phy: Document RZ/V2L phy bindings

Liu Ying (1):
      phy: dphy: Correct lpx parameter and its derivatives(ta_{get,go,sure})

Luca Weiss (2):
      dt-bindings: phy: qcom,qusb2: Document msm8953 compatible
      phy: qcom-qusb2: Add compatible for MSM8953

Marcel Ziswiler (1):
      phy: freescale: pcie: cosmetic clean-up

Minghao Chi (CGEL ZTE) (1):
      phy/cadence: Use of_device_get_match_data()

Pali Roh=C3=A1r (5):
      phy: marvell: phy-mvebu-a3700-comphy: Remove port from driver configu=
ration
      phy: marvell: phy-mvebu-a3700-comphy: Add native kernel implementation
      Revert "ata: ahci: mvebu: Make SATA PHY optional for Armada 3720"
      Revert "usb: host: xhci: mvebu: make USB 3.0 PHY optional for Armada =
3720"
      Revert "PCI: aardvark: Fix initialization with old Marvell's Arm Trus=
ted Firmware"

Pratyush Yadav (4):
      phy: cadence: Add Cadence D-PHY Rx driver
      phy: dt-bindings: Convert Cadence DPHY binding to YAML
      phy: dt-bindings: cdns,dphy: add power-domains property
      phy: dt-bindings: Add Cadence D-PHY Rx bindings

Rafa=C5=82 Mi=C5=82ecki (1):
      phy: phy-brcm-usb: fixup BCM4908 support

Samuel Holland (3):
      dt-bindings: phy: Add compatible for D1 USB PHY
      phy: sun4i-usb: Remove .disc_thresh where not applicable
      phy: sun4i-usb: Add D1 variant

Sankeerth Billakanti (3):
      dt-bindings: phy: Add eDP PHY compatible for sc7280
      phy: qcom: Add support for eDP PHY on sc7280
      phy: qcom: Program SSC only if supported by sink

Stephan Gerhold (1):
      phy: ti: tusb1210: Add charger detection

Vinod Koul (2):
      Merge tag 'phy-fixes-5.17' into next
      dt-bindings: Revert "dt-bindings: soc: grf: add naneng combo phy regi=
ster compatible"

Yifeng Zhao (2):
      dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
      phy: rockchip: add naneng combo phy for RK3568

 .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml |    4 +-
 .../devicetree/bindings/phy/cdns,dphy-rx.yaml      |   42 +
 .../devicetree/bindings/phy/cdns,dphy.txt          |   20 -
 .../devicetree/bindings/phy/cdns,dphy.yaml         |   56 +
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |    2 +
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml  |  109 ++
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |    4 +-
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |    3 +
 .../devicetree/bindings/phy/qcom,qusb2-phy.yaml    |    1 +
 .../devicetree/bindings/phy/qcom,usb-hs-phy.txt    |   84 --
 .../devicetree/bindings/phy/qcom,usb-hs-phy.yaml   |  108 ++
 .../bindings/phy/qcom,usb-snps-femto-v2.yaml       |    3 +
 .../devicetree/bindings/phy/renesas,usb2-phy.yaml  |    3 +-
 .../bindings/phy/samsung,dp-video-phy.yaml         |   41 +
 .../bindings/phy/samsung,exynos5250-sata-phy.yaml  |   64 +
 .../bindings/phy/samsung,mipi-video-phy.yaml       |  113 ++
 .../devicetree/bindings/phy/samsung,usb2-phy.yaml  |  102 ++
 .../bindings/phy/samsung,usb3-drd-phy.yaml         |  126 ++
 .../devicetree/bindings/phy/samsung-phy.txt        |  210 ---
 .../devicetree/bindings/trivial-devices.yaml       |    2 +
 MAINTAINERS                                        |    2 +-
 drivers/ata/ahci.h                                 |    2 -
 drivers/ata/ahci_mvebu.c                           |    2 +-
 drivers/ata/libahci_platform.c                     |    2 +-
 drivers/pci/controller/pci-aardvark.c              |    4 +-
 drivers/phy/allwinner/phy-sun4i-usb.c              |   41 +-
 drivers/phy/amlogic/phy-meson-gxl-usb2.c           |    5 +-
 drivers/phy/amlogic/phy-meson8b-usb2.c             |    9 +-
 drivers/phy/broadcom/phy-brcm-usb-init-synopsys.c  |   46 +-
 drivers/phy/broadcom/phy-brcm-usb-init.c           |   36 +
 drivers/phy/broadcom/phy-brcm-usb-init.h           |    1 +
 drivers/phy/broadcom/phy-brcm-usb.c                |   11 +-
 drivers/phy/cadence/Kconfig                        |    8 +
 drivers/phy/cadence/Makefile                       |    1 +
 drivers/phy/cadence/cdns-dphy-rx.c                 |  255 ++++
 drivers/phy/cadence/phy-cadence-salvo.c            |    7 +-
 drivers/phy/cadence/phy-cadence-sierra.c           |   82 +-
 drivers/phy/freescale/Kconfig                      |    5 +
 drivers/phy/freescale/phy-fsl-imx8m-pcie.c         |    3 +-
 drivers/phy/marvell/phy-mvebu-a3700-comphy.c       | 1350 ++++++++++++++++=
++--
 drivers/phy/phy-core-mipi-dphy.c                   |    4 +-
 drivers/phy/qualcomm/phy-qcom-edp.c                |    9 +-
 drivers/phy/qualcomm/phy-qcom-ipq806x-usb.c        |   28 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                |    3 +
 drivers/phy/qualcomm/phy-qcom-qusb2.c              |    3 +
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c      |    5 +
 drivers/phy/rockchip/Kconfig                       |    8 +
 drivers/phy/rockchip/Makefile                      |    1 +
 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c |  581 +++++++++
 drivers/phy/ti/phy-tusb1210.c                      |  443 ++++++-
 drivers/usb/host/xhci-mvebu.c                      |   42 -
 drivers/usb/host/xhci-mvebu.h                      |    6 -
 drivers/usb/host/xhci-plat.c                       |   20 +-
 drivers/usb/host/xhci-plat.h                       |    1 -
 54 files changed, 3496 insertions(+), 627 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy-rx.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/cdns,dphy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-nane=
ng-combphy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.t=
xt
 create mode 100644 Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.y=
aml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,dp-video-=
phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos525=
0-sata-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,mipi-vide=
o-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,usb2-phy.=
yaml
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,usb3-drd-=
phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/samsung-phy.txt
 create mode 100644 drivers/phy/cadence/cdns-dphy-rx.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-combphy.c

Thanks
--=20
~Vinod

--6+g71u/0irGe+9jL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+vs47OPLdNbVcHzyfBQHDyUjg0cFAmIiTPwACgkQfBQHDyUj
g0f2ohAAwGLRPzSrreY665GQUbLEMWKCg428yuSp8vVvKUKfwW/4SRy0fFzsPzsF
vUhck7kGfLS0htRNVLzUD8TsgFVUE4k3l8wpjflqtKSuSb6mbw/h6fmH/8fXI9HB
9gpEsyzI9TUBHzrDx/3HFwTXuAbdl2d7KSdQ0/9+g/MyIIeoSNgKXk9qYWpSkL2b
DpMIQxIxplzDARHcScYD8Gnhu/vN37f/D+hyKw2TZqc+1SNZ8b3yJEJay+QDTGSa
EoyAzrw4qcaWcXZsS3fcUlFiKkzkJc6gJ/+3p3iYpQt67En2BYL9VyvAtET77Y6c
gznZvG77dDrHGMoCjZzWZYPTMGQMwUwcM5lr4DJE1FtWWEHGIdis2DjlNfZHXVaf
eTESzv2vp8UPN9GN/Lj4hSu4QVf4Yyugo92Sg2usV049NjuO4i1Q2mFjTy0/w2tJ
KA+eG6sOHLpJ/5xfrdubDml+uPB53+EvJI2nNkEU69D3ikxaBkDHlawC79F3piBM
Rqwzy+7uVDYjjfHJXCaMoyBMcnU5jWI7mux6G6NXoKSJaVameO1g72j6HAO074Du
uYhgDeWVYDGOuFhOeDbV76D0qO3TRC6Qn4ltH6aPq9g2M/1E1/2GeIKtCLfGDj1n
lrBe2Uh6bhojs88ekhS+FZgyG2eJUTgmSPAYeEsS7MTr3EqSArE=
=+soa
-----END PGP SIGNATURE-----

--6+g71u/0irGe+9jL--
