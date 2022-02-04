Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5B464AA3C7
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 23:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377796AbiBDW6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 17:58:37 -0500
Received: from mout.perfora.net ([74.208.4.194]:53167 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358185AbiBDW6W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 17:58:22 -0500
Received: from localhost.localdomain ([81.221.85.15]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MSLTZ-1mnorT0XWd-00TQuf;
 Fri, 04 Feb 2022 23:58:00 +0100
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
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/12] arm64: defconfig: enable verdin-imx8mm relevant drivers as modules
Date:   Fri,  4 Feb 2022 23:57:04 +0100
Message-Id: <20220204225706.1539818-11-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220204225706.1539818-1-marcel@ziswiler.com>
References: <20220204225706.1539818-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kH+5K7Es3VfXS8C/7EOIDa5q2YryXfVoF8zvruDZxxUvc3ElxE2
 C3ZHTWf3g2/pcyON80pWJW1kkIElUousaLlKTSfCSxRqMTwMpSWJ1enX39SqlSXYgGqCRkI
 2tEP/+PQsAV5ygmAFdq+TppKPoPyD0zrxGj8Czx4Jmwu1rOgDTTN2i7/Vme8Gk5a2pnEHW1
 mlVWG3mWV2d1zKvnrsENA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2VuhEtqPsMw=:yjWDls8jo9b5DhIPjTdstL
 AY6nNK/qa/KcxFEWqppPpdtVK9KR/tyckKxQCNKXvDaqQWbgYGXTsZqzhfobFYPwJu07CyHse
 rRcjqVy/tfdb7cok9UB2istU4axvVsaEieOw8sVLpvBM4ifFPz8sxQGqMWn2wDwkn2srPMbNr
 MC4Rhfnw01Di1c8K9/H1Lf2O/KN7LUAut46rMpwHKkFoB39ijKvaH/Wj1c+P20mlUpru4jJ1Q
 +EoEj9yNGeo/rx1w6sV2t8qzfhP7T88dTigdsBkDHJ73AS2dqjqXOvH0UKHFf/N3wP3og+bS3
 5+W/U/ScRpT66wfzNLKrpwT7khp1UjKBs/fq53OtI2k06c7CBQpgskvnMcqTf04UFm2n+l6JT
 wInpmbjUuHB+GAS/QQL/Q+8XBiVOMpeD6AYbjOn78bOfaPuaInFgS6lQN6YzQE8meHIxPpD//
 qnodwEXdDSBQa7F+EqUAVPc5Z4GjmIaQtRYAkXutca0j24BsW7UcjDjdOQDsBe67evaGsZSj/
 A1EnWB/sUsEkdedFrP2G3r4Vkf+RVf7/sDaobuzDegnsq7xPB/J8nuAI7+lPe1YUrFvrUjwZz
 9DjNm9QSRoQcA8stKEzkmSxis/9hKge3avQCO/NQoYuXhUAfJ4yWnm8sgIcBmTlnSS5S0BTWX
 iOpMzfUCBpoxkfFblhHJXZtgZP1v8P2d+rjLG1kDduas8P3CGI/jQnUQfcNp6TvLbrzA=
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

