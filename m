Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC1B48EB71
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbiANOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:16:25 -0500
Received: from mout.perfora.net ([74.208.4.194]:54187 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241494AbiANOQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:16:15 -0500
Received: from localhost.localdomain ([81.221.144.115]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mdb8U-1myZDK1ypQ-00PLca;
 Fri, 14 Jan 2022 15:15:54 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marek Vasut <marek.vasut@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v2 09/11] arm64: defconfig: enable verdin-imx8mm relevant drivers as modules
Date:   Fri, 14 Jan 2022 15:15:05 +0100
Message-Id: <20220114141507.395271-10-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220114141507.395271-1-marcel@ziswiler.com>
References: <20220114141507.395271-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:i1HkJBh8IEppau3Wg2gYlMqFBt7n+Khd328siNanzh4MGIyTl6m
 d5j2u06DjXPFglXVjXOAv8AHm4nwt1b0w2HafqDn9vgg6S6NlbJkhIN77ehLWTsLxUHpX+D
 XZEvb35FhgLh1UKgEfXrY0FOriV3m/a7xOwBgnzGt5mdNqG0rhPAJxlAfNtJ4Pc35CwZrJ3
 7Q7p8lVnqDsZQYcM5gzIg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1fHTbDG3mCc=:oyuGq8mVQbmn2eUXSH1TBa
 IcoLRWrFWwlfLCo/UX5C5O+hNTYtht5fp8QZp/vXNQ28GYmH8J6kboaj3QJO8Mre7pkcT6qUy
 A35Z0VL6E2/xLLpxHucIuoR2uUJ3X6bJ+8On4BMjvadDJHRLhUdodz7wDRXjgE4AorMrSPvST
 6CYR75gALkgFd3tTD4/p8Bdyeuh8q2xg3YfLt5uyUwE+29g+N0San5l3XNM+HwLp5Ue/ncX71
 W6n0/nf9up+vbHXWStezrlFuE0yRcBO6IIRDbAuvnMJOZZYto12ystNO7AYkQTMYoAk6OF2bE
 IGXUwLHa1gDT0WOsGzMMnZ+QmEiF02M9iyWkAC6dt8qqrBds06kj9GsKPsFyRzUmDvMDn2zPr
 crAquW7mOfUcK+LVV6hOoHIIhL7IGYWtKHha6+ou8qOPg2lNIywZDRlkJCF/TbVxwQEwPuESf
 ug+3YII3w6XO1jmhjbqkTPMEiu5B78caqZFLTCdZMpzAJEDjT8lFYN2pYeo0fS0NOuUr2uj9v
 P9NmPOA6hqRT44iNjeiAYTW+LAjt4QtQL5GB/HxDx+C3xXda1GWj7UnV01tWW5lMSs0HeukzK
 g2vUO5RYQkYLlpRGkBA8JPYJaLilP3wZDz5bOE9ql+nsanftIOMBdn2JICWR6qmTCMSkRsca3
 Oh8M+h02jGQQNlqVPJ4kZiN3RA9ScAmlw1TnxjAiWXNwkfJIWTl0T8SYc+GS2qtl0DmY4+zU2
 3YtuJrOgc4zisAGS
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

---

Changes in v2:
- Explain why enabling these may make sense and squash them relevant
  changes as requested by Krzysztof.

 arch/arm64/configs/defconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f80d7fb53b7e..6f4507b30916 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -178,6 +178,7 @@ CONFIG_CAN=m
 CONFIG_CAN_FLEXCAN=m
 CONFIG_CAN_RCAR=m
 CONFIG_CAN_RCAR_CANFD=m
+CONFIG_CAN_MCP251XFD=m
 CONFIG_BT=m
 CONFIG_BT_HIDP=m
 # CONFIG_BT_LE is not set
@@ -188,6 +189,9 @@ CONFIG_BT_HCIUART=m
 CONFIG_BT_HCIUART_LL=y
 CONFIG_BT_HCIUART_BCM=y
 CONFIG_BT_HCIUART_QCA=y
+CONFIG_BT_HCIUART_MRVL=y
+CONFIG_BT_MRVL=m
+CONFIG_BT_MRVL_SDIO=m
 CONFIG_BT_QCOMSMD=m
 CONFIG_CFG80211=m
 CONFIG_MAC80211=m
@@ -379,6 +383,7 @@ CONFIG_ATH10K_SNOC=m
 CONFIG_WCN36XX=m
 CONFIG_BRCMFMAC=m
 CONFIG_MWIFIEX=m
+CONFIG_MWIFIEX_SDIO=m
 CONFIG_MWIFIEX_PCIE=m
 CONFIG_WL18XX=m
 CONFIG_WLCORE_SDIO=m
@@ -554,6 +559,7 @@ CONFIG_CHARGER_BQ25980=m
 CONFIG_SENSORS_ARM_SCMI=y
 CONFIG_SENSORS_ARM_SCPI=y
 CONFIG_SENSORS_JC42=m
+CONFIG_SENSORS_LM75=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
@@ -796,6 +802,7 @@ CONFIG_SND_SOC_WM8960=m
 CONFIG_SND_SOC_WM8962=m
 CONFIG_SND_SOC_WM8978=m
 CONFIG_SND_SOC_WSA881X=m
+CONFIG_SND_SOC_NAU8822=m
 CONFIG_SND_SOC_LPASS_WSA_MACRO=m
 CONFIG_SND_SOC_LPASS_VA_MACRO=m
 CONFIG_SND_SIMPLE_CARD=m
@@ -1087,6 +1094,7 @@ CONFIG_QCOM_SPMI_VADC=m
 CONFIG_QCOM_SPMI_ADC5=m
 CONFIG_ROCKCHIP_SARADC=m
 CONFIG_RZG2L_ADC=m
+CONFIG_TI_ADS1015=m
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_IIO_ST_LSM6DSX=m
-- 
2.33.1

