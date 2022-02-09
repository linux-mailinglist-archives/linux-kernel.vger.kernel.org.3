Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609FE4AEFE4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 12:21:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiBILVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 06:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiBILVh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 06:21:37 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B5DE111E59
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 02:16:03 -0800 (PST)
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MvJPR-1o8BrF423V-00rKWN;
 Wed, 09 Feb 2022 11:01:53 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Adam Ford <aford173@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/12] arm64: defconfig: enable verdin-imx8mm relevant drivers as modules
Date:   Wed,  9 Feb 2022 11:00:53 +0100
Message-Id: <20220209100055.181389-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220209100055.181389-1-marcel@ziswiler.com>
References: <20220209100055.181389-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T3ALNuvBwd7E5HjqIZvVMct1MNdJkpHzT6CB6XQoFuHgqJu8rNh
 NetJrKz2F6JReYf9eRtzCbGJUZRsu2jYJLXRy0KFyZgi0WAYqkXglvlzuvZYdsfpOPLz4Wr
 dTpiA8JH9XtIRkgNKyR3nK9GOxo9c8bGTNXXqrJyRBFjXgKTy9vIJFXtW5fiyf11+++fNFy
 wIYt6Dp4mSuOwQWfm1B1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Gja8Svjjq2k=:FuMFCAcPBb8GbFzLw0N0Qb
 FccSMGRorFLtJUr1hr2NdFDX2zs3ArfDYpwk+3lxbXbNzB78NWUP/hD1NjWm94PI/C6hI8eMg
 IX+197cObtWFg1XK2tLCS7vBCmkEfTR5LgOPZQUnsRoQw2VHTD4BLKJlKdkq2p2NYxyfXYQ9U
 wXgly2CD2mSVyK/ZcnA87rdLFJ4TNJGXduAZkdtCGPdcJq+lAV2J/006H0txJ1XjarZcEYnok
 mVjATG+jWiTX4iSUph8/WJTQng1Yjxwkr2KEBW0ssKJKVGfzDCQVKOPb/JrfpWcD7tHBzuy1Y
 B1zYqRiEuH48x0EWlIKBzyYz2xa916e0jqcAw7T62iA16fkyB/OKXMlt2uY6OKYdWCf74J/pB
 BXiK/TL3bTA8nMxPWGRW/A2WiVHVHLZ7lHR9Xo7f++IJxPGhilXykND3gGv+GmCcxd+h9R2P4
 QQ6nZbwM4liL/lgQKKgPtOMy2vH7BymuLXgGwSh54SAyQcHNTsx9rURnqRe2+6T+IIqRi3qxg
 LDe9cNxhqw30ZCiyF7Qnpa7N/+ZfFyxWYDu6z/uukpVsCNl0QuBgUYJ/llo0BGR9tx+E155Jd
 7qQm2vEFZIg7dFt+iVPNxwqd8AuG/UsyNXRcmiAWR4TY6eMvPchb3ZULQPUOaG05/5MR7EeDE
 5ySwl5TqRsiBiHNrM6qFvAjFGp8MO5OTn/XWMAb9Nt/RpwMwi03wj++cKIP1YU8kLdwFf9ViJ
 76+NhCGwiTa+oI/7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable various drivers which support peripherals as found on the
Verdin iMX8M Mini et al. computer/system on modules:

- CONFIG_CAN_MCP251XFD
At least one Microchip MCP2518FDT SPI CAN controller which this driver
also supports may be found on the Verdin iMX8M Mini computer/system on
module.

- CONFIG_BT_HCIUART_MRVL, CONFIG_BT_MRVL, CONFIG_BT_MRVL_SDIO and
  CONFIG_MWIFIEX_SDIO
The AzureWave AW-CM276NF which these Bluetooth and Wi-Fi drivers also
support may be found on the Verdin iMX8M Mini (as well as the Apalis
iMX8, Colibri iMX8X and Verdin iMX8M Plus for that matter) computer/
system on module.

- CONFIG_SENSORS_LM75
The TI TMP75C temperature sensor which this driver also supports may be
found on the Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for
that matter) computer/system on module.

- CONFIG_SND_SOC_NAU8822
The Nuvoton Technology Corporation (NTC) NAU88C22YG which this driver
also supports may be found on the Verdin Development Board a carrier
board for the Verdin family of computer/system on module which the
Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for that matter)
may be mated in.

- CONFIG_TI_ADS1015
The TLA2024 ADC which this driver also supports may be found on the
Verdin iMX8M Mini (as well as the Verdin iMX8M Plus for that matter)
computer/system on module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

(no changes since v3)

Changes in v3:
- Add Krzysztof's reviewed-by tag.

Changes in v2:
- Explain why enabling these may make sense and squash them relevant
  changes as requested by Krzysztof.

 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 76334cb698af..8d2733f8a7d9 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -179,6 +179,7 @@ CONFIG_CAN=m
 CONFIG_CAN_FLEXCAN=m
 CONFIG_CAN_RCAR=m
 CONFIG_CAN_RCAR_CANFD=m
+CONFIG_CAN_MCP251XFD=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_LE is not set
@@ -189,6 +190,9 @@ CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_BCM=y
 CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_MRVL=y
+CONFIG_BT_MRVL=m
+CONFIG_BT_MRVL_SDIO=m
 CONFIG_BT_QCOMSMD=m
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
@@ -380,6 +384,7 @@ CONFIG_ATH10K_SNOC=m
 CONFIG_WCN36XX=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
@@ -556,6 +561,7 @@ CONFIG_CHARGER_BQ25980=m
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_JC42=m
+CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
@@ -797,6 +803,7 @@ CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SOC_WSA881X=m
+CONFIG_SND_SOC_NAU8822=m
 CONFIG_SND_SOC_LPASS_WSA_MACRO=m
 CONFIG_SND_SOC_LPASS_VA_MACRO=m
 CONFIG_SND_SIMPLE_CARD=m
@@ -1088,6 +1095,7 @@ CONFIG_QCOM_SPMI_VADC=m
 CONFIG_QCOM_SPMI_ADC5=m
 CONFIG_ROCKCHIP_SARADC=m
 CONFIG_RZG2L_ADC=m
+CONFIG_TI_ADS1015=m
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_IIO_ST_LSM6DSX=m
-- 
2.33.1

