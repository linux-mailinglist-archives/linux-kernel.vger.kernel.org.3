Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564F449FD7F
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 17:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349918AbiA1QCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 11:02:20 -0500
Received: from mout.perfora.net ([74.208.4.197]:41115 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349917AbiA1QCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 11:02:12 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MUpdy-1mjsVw2fWe-00Y8Cr;
 Fri, 28 Jan 2022 17:01:53 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] arm64: defconfig: enable verdin-imx8mm relevant drivers as modules
Date:   Fri, 28 Jan 2022 17:00:58 +0100
Message-Id: <20220128160100.1228537-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128160100.1228537-1-marcel@ziswiler.com>
References: <20220128160100.1228537-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nBh7XuqTDiKj76ABVxjfEbFGjBAelZz/FYxRnqyonqZky3/oIPs
 042VXEUdc0Z8WzwzVaF/U1c4Sb79bQA9Ss4T/PJDGpz/VxdOg8W6tzxc0acCY6uUUborToO
 AOqAL1NKD7Gh47YyYu2ccwwsIIQASeK1GqTWuqz52SNV7zDYk03Aas/u3TTaJVjSmhUoGI5
 bNj2M2lf3+SkE+E4az//g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qXnpUXme5X0=:lYeSqKYS7Zaqm4AVOOGENi
 gcHLRmqn8MK/GHGnEHqRTHC2oFswxzDeTv9qTuRipDMoMHVtG1swfDDuxXVMJjydTtXWWBYik
 i1WCFmeGHxbg3qtGxw8s2wPQPsNn7Kvsi3slhvXIjsDZ417eh+bJqQiiLNlcwGwt0MeaUwHi0
 bQOCmXf6tr0BBkHuaMu93IFmiM+G0DfIBsPpor53hd3TV9ef/qZqhWMJtmSM6r+ecq/r7YRmr
 zAeaHf/SQI4KjVr2+WFOnyNP+eakCVx3zrzW1TB1wjUWz4949y0cJxrTW2xGXSH8tOHg8lj9L
 VU+87VbFF2REINFKdSc50c1VQAFs+ldq1MYVWH0Q8hUkRC6WT29JZaBHEbDSdi9+9Lhl0duWJ
 W82oXTamvP4W4QkU9MQVicVe4g2JjsHS4OOKKcUssRohQDADqMHWUrHxwhKTBGiaBa8i0xIJc
 Q+di/eUy4+0mGjM6fPsF4Qrnqty4ygvrmRn0+GjnAuzXDK8YDw0W83wXBuCfuetVoMdTgkesN
 AMdoFMZXXVLMo77kG0ipd3SCRQm0nOFslLTdwogBAuwSZ3Z+kUslAM2/JFNHevi1cHUQD7M+3
 uSvJ3azXr+OlAlCJUAn/sg1+PmR8WcwjvyHBJZUMKdnQG3bziswPMIna3fr9dh6F2h00xKFaT
 u6ThpsHC9EgDSO3JioY7vQ1qW/42AsfZD+wrGpO8XKS0U0qLO9duGwk0RAE3REJpyvnRRDY3D
 gCQ0c9d3fwe3lcwW
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

