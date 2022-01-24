Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B292498224
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbiAXO3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:29:02 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:47552 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiAXO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:28:59 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220124142857epoutp04998ab6f08d5d98161c0e44b8063a9c34~NOzTlRXOr2053720537epoutp04W
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:28:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220124142857epoutp04998ab6f08d5d98161c0e44b8063a9c34~NOzTlRXOr2053720537epoutp04W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034537;
        bh=zvqXmhfJv9oPDwsqSeEPwarbwPgiaKdElKpBH1a75iw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bf6nwojvLAdanKC4XqAApY1CvZn9yi59uvmp29NF4dlWDmo/d6dSAj8QbQp6R6Hya
         nuz1XWT4EQbhrZ6GTSCC1yS2GrqHSh73BVsDQtVS5E363yKOJe/4hDVO8S7LhrfbCF
         LHtA9j7vnQT6wlAAZhWRH2e960U6jbZFzROual6Q=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220124142856epcas5p155f540b1eb172bc0c27b2412387e6a5b~NOzS_sVAw1531415314epcas5p1c;
        Mon, 24 Jan 2022 14:28:56 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JjC5v28BNz4x9Px; Mon, 24 Jan
        2022 14:28:51 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F7.4D.46822.546BEE16; Mon, 24 Jan 2022 23:23:01 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b~NOzNftIyL1077210772epcas5p2D;
        Mon, 24 Jan 2022 14:28:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220124142850epsmtrp130d430356c45f010fefd6944622afc5d~NOzNeA1eG2824028240epsmtrp1l;
        Mon, 24 Jan 2022 14:28:50 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-df-61eeb6453c75
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.AB.08738.2A7BEE16; Mon, 24 Jan 2022 23:28:50 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142848epsmtip15c1ccd3f647764a2e144c42813c91e00~NOzLVFEpk1062110621epsmtip1j;
        Mon, 24 Jan 2022 14:28:48 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v5 00/16] Add support for Tesla Full Self-Driving (FSD) SoC
Date:   Mon, 24 Jan 2022 19:46:28 +0530
Message-Id: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTXdd127tEg6eLbCwezNvGZvF30jF2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLy7vmsFnMOL+PyeLU9c9sFou2fmG3
        aN17hN3i8Jt2Vot/1zayWDy+/ofNQcBjzbw1jB6/f01i9JjV0MvmsWlVJ5vHnWt72Dw2L6n3
        uHKiidWjb8sqRo/Pm+QCOKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0tLcyVFPIS
        c1NtlVx8AnTdMnOA3lBSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CqlFqTkFJgU6BUn5haX
        5qXr5aWWWBkaGBiZAhUmZGdcmnKaseCNXMXti69YGxj/iHcxcnJICJhI3Dr3mhXEFhLYzShx
        eV9IFyMXkP2JUeLN/1fMEM5nRon/U46xw3Tc/DORDSKxi1Hi7q03UO0tTBKLjziB2GwC2hJ3
        p29hArFFBNwkbjR2MIE0MAu8YpK4/m81UDcHh7CAt8SfN4IgNSwCqhLXzzSCzeEVsJG4dm0b
        M8QyeYnVGw6AXSEhMJVDYsH2M1BXuEi0zrsJZQtLvDq+BcqWknjZ38YOMl9CIFuiZ5cxRLhG
        Yum8YywQtr3EgStzWEBKmAU0Jdbv0gcJMwvwSfT+fsIE0ckr0dEmBFGtKtH87ipUp7TExO5u
        VogSD4lv21kgHo+VOHX6IPMERplZCDMXMDKuYpRMLSjOTU8tNi0wyksth0dMcn7uJkZwatTy
        2sH48MEHvUOMTByMhxglOJiVRHirUt4lCvGmJFZWpRblxxeV5qQWH2I0BQbSRGYp0eR8YHLO
        K4k3NLE0MDEzMzOxNDYzVBLnPZ2+IVFIID2xJDU7NbUgtQimj4mDU6qBafmT50+ZukU3fEmP
        +LrYSu7uW/NZbzWSVlw9ejcnbtIj5rPzm1mM/8f7PuBhbtwuKlGgGauTp+Ohmq925nLINn6B
        T4IOE1XYTJo2OAhfPFG/dWfZ9c934uf8uvP9yuU9DRn6a8yM0qSmrZMT/n7x8q/LSx9fmxv3
        xOJlHbvdVgXLxlK53MMfCgp0VVZI91x2dCydbuX+4cqB5RctZtcIvb2goNHzsykylyG84usy
        xWAv4V0h56+V1p45rS8oED+T1dfR/c92he8pOU/u7+7caFw7LXD95tlfLD9MqAuOWxs+ITtO
        snu2f/sm7Wlq3TvyhNabfO470sPw7INSf/itSNVt3PPXNKT72R2U/9/zW4mlOCPRUIu5qDgR
        ANnmJ/kWBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsWy7bCSnO6i7e8SDQ791rN4MG8bm8XfScfY
        Ld4v62G0mH/kHKvFxrc/mCym/FnOZLHp8TVWi48991gtLu+aw2Yx4/w+JotT1z+zWSza+oXd
        onXvEXaLw2/aWS3+XdvIYvH4+h82BwGPNfPWMHr8/jWJ0WNWQy+bx6ZVnWwed67tYfPYvKTe
        48qJJlaPvi2rGD0+b5IL4IzisklJzcksSy3St0vgyrg05TRjwRu5itsXX7E2MP4R72Lk5JAQ
        MJG4+WciWxcjF4eQwA5GiRsPF7BCJKQlrm+cwA5hC0us/PecHaKoiUli+eHjLCAJNgFtibvT
        tzCB2CICHhJt/+4xgxQxC/xiktj39wZjFyMHh7CAt8SfN4IgNSwCqhLXzzSCLeAVsJG4dm0b
        M8QCeYnVGw4wT2DkWcDIsIpRMrWgODc9t9iwwCgvtVyvODG3uDQvXS85P3cTIziMtbR2MO5Z
        9UHvECMTB+MhRgkOZiUR3qqUd4lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnN
        Tk0tSC2CyTJxcEo1MJ2a+t9x5uR1Kem//xt91nP17p3+7anxz+2dgs/W6K241Kvmp8rVdd/u
        760mx8XPGkt1Vvz7ePHbttzwWvUpksGHDZJmTrRafE0jJHjvhO0ys2Jal/2f9nLKFIca9WfG
        D+5kTzne6aH6tFzoSUcty5PKX1ruT+XnpEmatMgrq0jNchWYejbLg0Npsv5S1rZnr3bt2Hnk
        m6Cn7aa6wLcJBgs/vFJYGVX9ZeqZnjnzn6c9MdJNUl5a8vKENkdM8MGkz9c8bjY1Jpnv435X
        ySzmZOjkl/f3xClZ0+0r54o+UIlwKryomrMsPZO39qt389nTciuinngfvpW3btW8aRslfzQb
        za9nUL4rsbSy+nvtPk8lluKMREMt5qLiRAB05XSG0gIAAA==
X-CMS-MailID: 20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b
References: <CGME20220124142850epcas5p2f82243b87386b3d49a9302c87e015d6b@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds basic support for the Tesla Full Self-Driving (FSD)
SoC. This SoC contains three clusters of four Cortex-A72 CPUs,
as well as several IPs.

Patches 1 to 9 provide support for the clock controller
(which is designed similarly to Exynos SoCs).

The remaining changes provide pinmux support, initial device tree support.

- Changes since v4
* fixed 'make dtbs_check' warnings on patch 14/16

- Changes since v3
* Addressed Stefen's review comments on patch 14/16
* Fixed kernel test robot warning on patch 04/16
* rebsaed this series on Krzysztof's pinmux new binding schema work [1]

- Changes since v2
* Addressed Krzysztof's and Stephen's review comments
* Added Reviewed-by and Acked-by tags
* Rebased on next-20220120

- Changes since v1
* fixed make dt_binding_check error as pointed by Rob
* Addressed Krzysztof's and Rob's review comments
* Added Reviewed-by and Acked-by tags
* Dropped SPI, MCT and ADC from this series (to be posted in small sets)

NOTE: These patches are based on Krzysztof's pinmux for-next branch
commit 832ae134ccc1 ("pinctrl: samsung: add support for Exynos850 and ExynosAutov9 wake-ups") 
[1] https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git/log/?h=for-next


Alim Akhtar (16):
  dt-bindings: add vendor prefix for Tesla
  dt-bindings: clock: Add bindings definitions for FSD CMU blocks
  dt-bindings: clock: Document FSD CMU bindings
  clk: samsung: fsd: Add initial clock support
  clk: samsung: fsd: Add cmu_peric block clock information
  clk: samsung: fsd: Add cmu_fsys0 clock information
  clk: samsung: fsd: Add cmu_fsys1 clock information
  clk: samsung: fsd: Add cmu_imem block clock information
  clk: samsung: fsd: Add cmu_mfc block clock information
  clk: samsung: fsd: Add cam_csi block clock information
  dt-bindings: pinctrl: samsung: Add compatible for Tesla FSD SoC
  pinctrl: samsung: add FSD SoC specific data
  dt-bindings: arm: add Tesla FSD ARM SoC
  arm64: dts: fsd: Add initial device tree support
  arm64: dts: fsd: Add initial pinctrl support
  arm64: defconfig: Enable Tesla FSD SoC

 .../devicetree/bindings/arm/tesla.yaml        |   27 +
 .../bindings/clock/tesla,fsd-clock.yaml       |  198 ++
 .../bindings/pinctrl/samsung,pinctrl.yaml     |    1 +
 .../devicetree/bindings/vendor-prefixes.yaml  |    2 +
 MAINTAINERS                                   |    8 +
 arch/arm64/Kconfig.platforms                  |    6 +
 arch/arm64/boot/dts/Makefile                  |    1 +
 arch/arm64/boot/dts/tesla/Makefile            |    3 +
 arch/arm64/boot/dts/tesla/fsd-evb.dts         |   39 +
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi    |  335 +++
 arch/arm64/boot/dts/tesla/fsd.dtsi            |  674 ++++++
 arch/arm64/configs/defconfig                  |    1 +
 drivers/clk/samsung/Kconfig                   |    8 +
 drivers/clk/samsung/Makefile                  |    1 +
 drivers/clk/samsung/clk-fsd.c                 | 1803 +++++++++++++++++
 drivers/clk/samsung/clk-pll.c                 |    1 +
 drivers/clk/samsung/clk-pll.h                 |    1 +
 .../pinctrl/samsung/pinctrl-exynos-arm64.c    |   71 +
 drivers/pinctrl/samsung/pinctrl-samsung.c     |    2 +
 drivers/pinctrl/samsung/pinctrl-samsung.h     |    1 +
 include/dt-bindings/clock/fsd-clk.h           |  150 ++
 21 files changed, 3333 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/tesla.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
 create mode 100644 arch/arm64/boot/dts/tesla/Makefile
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-evb.dts
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/tesla/fsd.dtsi
 create mode 100644 drivers/clk/samsung/clk-fsd.c
 create mode 100644 include/dt-bindings/clock/fsd-clk.h


base-commit: 832ae134ccc1c78a2f5ec81b7010dd24c3c49535
-- 
2.25.1

