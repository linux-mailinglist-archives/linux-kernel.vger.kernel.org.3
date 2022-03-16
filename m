Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE054DB499
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 16:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357136AbiCPPPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 11:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357096AbiCPPOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 11:14:53 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A90831511;
        Wed, 16 Mar 2022 08:13:35 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 742F01F4466C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647443614;
        bh=73T++O+sVkacU4ezH/NiQ+RPX96Kc4UTdJpge0w1oUc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8xv51AkPzaaqrsLUi79gX/sGO8573lhhu6mIJPPvjiT0ZAJ+fBFL3Mauc4GXINpn
         KCyQwKopdWRJn2oONF4qwg9RuYMrFs7ijIBwk0GM6xMuTKn1dSwHfWIobPzZ65ByH4
         7dRUECr4C2vCvrGlnKLD+cx2EOlkumftlehbWBhGsenz0JVflcB35QkN3YnVyaG+hC
         KI9mvVxP7KEAjR1sDHpi4vWHW6ThcYJqCQklJWRcIX3T9AD+QUmQWfLQ/uGoDCau4N
         9GACDa8tzWsrNsyEiWBqKjkV11e2WxN5ZSBXou0+kLFhMVItfivtQpihCiLC9I5Lbg
         QtAwriJ2WEkGg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH v1 02/10] arm64: dts: mediatek: asurada: Document GPIO names
Date:   Wed, 16 Mar 2022 11:13:19 -0400
Message-Id: <20220316151327.564214-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220316151327.564214-1-nfraprado@collabora.com>
References: <20220316151327.564214-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the gpio-line-names property to gpio-controller in order to
document the usage of GPIOs on the Asurada platform.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---

 .../boot/dts/mediatek/mt8192-asurada.dtsi     | 228 ++++++++++++++++++
 1 file changed, 228 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
index 277bd38943fe..e10636298639 100644
--- a/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8192-asurada.dtsi
@@ -21,6 +21,234 @@ memory@40000000 {
 	};
 };
 
+&pio {
+	/* 220 lines */
+	gpio-line-names = "I2S_DP_LRCK",
+			  "IS_DP_BCLK",
+			  "I2S_DP_MCLK",
+			  "I2S_DP_DATAOUT",
+			  "SAR0_INT_ODL",
+			  "EC_AP_INT_ODL",
+			  "EDPBRDG_INT_ODL",
+			  "DPBRDG_INT_ODL",
+			  "DPBRDG_PWREN",
+			  "DPBRDG_RST_ODL",
+			  "I2S_HP_MCLK",
+			  "I2S_HP_BCK",
+			  "I2S_HP_LRCK",
+			  "I2S_HP_DATAIN",
+			  /*
+			   * AP_FLASH_WP_L is crossystem ABI. Schematics
+			   * call it AP_FLASH_WP_ODL.
+			   */
+			  "AP_FLASH_WP_L",
+			  "TRACKPAD_INT_ODL",
+			  "EC_AP_HPD_OD",
+			  "SD_CD_ODL",
+			  "HP_INT_ODL_ALC",
+			  "EN_PP1000_DPBRDG",
+			  "AP_GPIO20",
+			  "TOUCH_INT_L_1V8",
+			  "UART_BT_WAKE_ODL",
+			  "AP_GPIO23",
+			  "AP_SPI_FLASH_CS_L",
+			  "AP_SPI_FLASH_CLK",
+			  "EN_PP3300_DPBRDG_DX",
+			  "AP_SPI_FLASH_MOSI",
+			  "AP_SPI_FLASH_MISO",
+			  "I2S_HP_DATAOUT",
+			  "AP_GPIO30",
+			  "I2S_SPKR_MCLK",
+			  "I2S_SPKR_BCLK",
+			  "I2S_SPKR_LRCK",
+			  "I2S_SPKR_DATAIN",
+			  "I2S_SPKR_DATAOUT",
+			  "AP_SPI_H1_TPM_CLK",
+			  "AP_SPI_H1_TPM_CS_L",
+			  "AP_SPI_H1_TPM_MISO",
+			  "AP_SPI_H1_TPM_MOSI",
+			  "BL_PWM",
+			  "EDPBRDG_PWREN",
+			  "EDPBRDG_RST_ODL",
+			  "EN_PP3300_HUB",
+			  "HUB_RST_L",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SD_CLK",
+			  "SD_CMD",
+			  "SD_DATA3",
+			  "SD_DATA0",
+			  "SD_DATA2",
+			  "SD_DATA1",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "PCIE_WAKE_ODL",
+			  "PCIE_RST_L",
+			  "PCIE_CLKREQ_ODL",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "SPMI_SCL",
+			  "SPMI_SDA",
+			  "AP_GOOD",
+			  "UART_DBG_TX_AP_RX",
+			  "UART_AP_TX_DBG_RX",
+			  "UART_AP_TX_BT_RX",
+			  "UART_BT_TX_AP_RX",
+			  "MIPI_DPI_D0_R",
+			  "MIPI_DPI_D1_R",
+			  "MIPI_DPI_D2_R",
+			  "MIPI_DPI_D3_R",
+			  "MIPI_DPI_D4_R",
+			  "MIPI_DPI_D5_R",
+			  "MIPI_DPI_D6_R",
+			  "MIPI_DPI_D7_R",
+			  "MIPI_DPI_D8_R",
+			  "MIPI_DPI_D9_R",
+			  "MIPI_DPI_D10_R",
+			  "",
+			  "",
+			  "MIPI_DPI_DE_R",
+			  "MIPI_DPI_D11_R",
+			  "MIPI_DPI_VSYNC_R",
+			  "MIPI_DPI_CLK_R",
+			  "MIPI_DPI_HSYNC_R",
+			  "PCM_BT_DATAIN",
+			  "PCM_BT_SYNC",
+			  "PCM_BT_DATAOUT",
+			  "PCM_BT_CLK",
+			  "AP_I2C_AUDIO_SCL",
+			  "AP_I2C_AUDIO_SDA",
+			  "SCP_I2C_SCL",
+			  "SCP_I2C_SDA",
+			  "AP_I2C_WLAN_SCL",
+			  "AP_I2C_WLAN_SDA",
+			  "AP_I2C_DPBRDG_SCL",
+			  "AP_I2C_DPBRDG_SDA",
+			  "EN_PP1800_DPBRDG_DX",
+			  "EN_PP3300_EDP_DX",
+			  "EN_PP1800_EDPBRDG_DX",
+			  "EN_PP1000_EDPBRDG",
+			  "SCP_JTAG0_TDO",
+			  "SCP_JTAG0_TDI",
+			  "SCP_JTAG0_TMS",
+			  "SCP_JTAG0_TCK",
+			  "SCP_JTAG0_TRSTN",
+			  "EN_PP3000_VMC_PMU",
+			  "EN_PP3300_DISPLAY_DX",
+			  "TOUCH_RST_L_1V8",
+			  "TOUCH_REPORT_DISABLE",
+			  "",
+			  "",
+			  "AP_I2C_TRACKPAD_SCL_1V8",
+			  "AP_I2C_TRACKPAD_SDA_1V8",
+			  "EN_PP3300_WLAN",
+			  "BT_KILL_L",
+			  "WIFI_KILL_L",
+			  "SET_VMC_VOLT_AT_1V8",
+			  "EN_SPK",
+			  "AP_WARM_RST_REQ",
+			  "",
+			  "",
+			  "EN_PP3000_SD_S3",
+			  "AP_EDP_BKLTEN",
+			  "",
+			  "",
+			  "",
+			  "AP_SPI_EC_CLK",
+			  "AP_SPI_EC_CS_L",
+			  "AP_SPI_EC_MISO",
+			  "AP_SPI_EC_MOSI",
+			  "AP_I2C_EDPBRDG_SCL",
+			  "AP_I2C_EDPBRDG_SDA",
+			  "MT6315_PROC_INT",
+			  "MT6315_GPU_INT",
+			  "UART_SERVO_TX_SCP_RX",
+			  "UART_SCP_TX_SERVO_RX",
+			  "BT_RTS_AP_CTS",
+			  "AP_RTS_BT_CTS",
+			  "UART_AP_WAKE_BT_ODL",
+			  "WLAN_ALERT_ODL",
+			  "EC_IN_RW_ODL",
+			  "H1_AP_INT_ODL",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "",
+			  "MSDC0_CMD",
+			  "MSDC0_DAT0",
+			  "MSDC0_DAT2",
+			  "MSDC0_DAT4",
+			  "MSDC0_DAT6",
+			  "MSDC0_DAT1",
+			  "MSDC0_DAT5",
+			  "MSDC0_DAT7",
+			  "MSDC0_DSL",
+			  "MSDC0_CLK",
+			  "MSDC0_DAT3",
+			  "MSDC0_RST_L",
+			  "SCP_VREQ_VAO",
+			  "AUD_DAT_MOSI2",
+			  "AUD_NLE_MOSI1",
+			  "AUD_NLE_MOSI0",
+			  "AUD_DAT_MISO2",
+			  "AP_I2C_SAR_SDA",
+			  "AP_I2C_SAR_SCL",
+			  "AP_I2C_PWR_SCL",
+			  "AP_I2C_PWR_SDA",
+			  "AP_I2C_TS_SCL_1V8",
+			  "AP_I2C_TS_SDA_1V8",
+			  "SRCLKENA0",
+			  "SRCLKENA1",
+			  "AP_EC_WATCHDOG_L",
+			  "PWRAP_SPI0_MI",
+			  "PWRAP_SPI0_CSN",
+			  "PWRAP_SPI0_MO",
+			  "PWRAP_SPI0_CK",
+			  "AP_RTC_CLK32K",
+			  "AUD_CLK_MOSI",
+			  "AUD_SYNC_MOSI",
+			  "AUD_DAT_MOSI0",
+			  "AUD_DAT_MOSI1",
+			  "AUD_DAT_MISO0",
+			  "AUD_DAT_MISO1";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.35.1

