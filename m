Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21232464893
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347709AbhLAHeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:34:03 -0500
Received: from mx1.tq-group.com ([93.104.207.81]:24263 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233020AbhLAHdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:33:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343811; x=1669879811;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hxazBvuF2Dge+gmXlN0mzbv2/IlR0HAtf2ND+JgtQ5E=;
  b=J3J6ZxgclZRv84iRm9ks/iyUSByuLC4EJcgFwaYbDktTfWVfzS/u0Ivz
   xKpyHfoB2H7G0c24JHy1mgTyxVOAR2q9cXA0E4K/oPB4qIHkn26glB1f+
   lW9xbgw4XnyVMGTbelB4o1nr2VYl4PqTtf2m69+XQvk8VOXX/yMhl8bht
   czYe5o+Xa6HssPWjVYTXiNv/6qrJATSAANz6HqxAbp6AT4is0q0Io8NRc
   VD7uSvZfAfhsXts4/nBg/1zSXyNY/KMJR+Cy9cFqyIi5n8cSRbQ5mHbOI
   vHMQwh8LQvf+ReZKsOv2jRI7OvwYeygtcKPz03KL7TtzcI13A/nGPkcAV
   Q==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773238"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 01 Dec 2021 08:30:04 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 01 Dec 2021 08:30:05 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 01 Dec 2021 08:30:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1638343805; x=1669879805;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hxazBvuF2Dge+gmXlN0mzbv2/IlR0HAtf2ND+JgtQ5E=;
  b=n9dTHnCWmbVqKSH8kGDJXqQ4g1iDNGEKK6VmJIbpXKN840pwS9zpYWpP
   I6raDPDTHNbwkOAJJhbuIqUvZgHh7uRLp7aFE6sfUHmq+DFGe9bXNhzE/
   H/cwxEZClB5vXga1gPGbp9h7+x7wYhO/i5gXofh+QSVS2sx1MRgz88qog
   IQGNEeUWla8xknrpr/pFUoI8vCIut3KZCNsTLReRLe0UyLB6CZXFP2lCm
   mw6SAA1g2s8dspDCfc7O5N2F4EDFZUgL3BJ+ZxJzA40ojcWrco5WsWb6M
   eFQnn+2tgmxMwXZgnPMmHXGtDPOaigz2z8mSaWB+/yMFusztvsNdilbdV
   w==;
X-IronPort-AV: E=Sophos;i="5.87,278,1631570400"; 
   d="scan'208";a="20773228"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 01 Dec 2021 08:30:03 +0100
Received: from steina-w.tq-net.de (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 52C5B280075;
        Wed,  1 Dec 2021 08:30:03 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 3/7] arm64: defconfig: enable drivers for TQ TQMa8MxML-MBa8Mx
Date:   Wed,  1 Dec 2021 08:29:44 +0100
Message-Id: <20211201072949.53947-4-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
References: <20211201072949.53947-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the device tree in place, enable missing drivers as modules, if
possible. PHY driver needs built-in for interrupt support.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v3:
* None

Changes in v2:
* Add interconnect driver for imx8mm and imx8mn

 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 0da6a944d5cd..44ce56dd2638 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -363,6 +363,7 @@ CONFIG_MICROSEMI_PHY=y
 CONFIG_AT803X_PHY=y
 CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
+CONFIG_DP83867_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_USB_PEGASUS=m
 CONFIG_USB_RTL8150=m
@@ -397,6 +398,7 @@ CONFIG_TOUCHSCREEN_EDT_FT5X06=m
 CONFIG_INPUT_MISC=y
 CONFIG_INPUT_PM8941_PWRKEY=y
 CONFIG_INPUT_PM8XXX_VIBRATOR=m
+CONFIG_INPUT_PWM_BEEPER=m
 CONFIG_INPUT_PWM_VIBRA=m
 CONFIG_INPUT_HISI_POWERKEY=y
 # CONFIG_SERIO_SERPORT is not set
@@ -556,6 +558,7 @@ CONFIG_BATTERY_MAX17042=m
 CONFIG_CHARGER_BQ25890=m
 CONFIG_CHARGER_BQ25980=m
 CONFIG_SENSORS_ARM_SCPI=y
+CONFIG_SENSORS_JC42=m
 CONFIG_SENSORS_LM90=m
 CONFIG_SENSORS_PWM_FAN=m
 CONFIG_SENSORS_RASPBERRYPI_HWMON=m
@@ -793,6 +796,7 @@ CONFIG_SND_SOC_RT5659=m
 CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
 CONFIG_SND_SOC_SIMPLE_MUX=m
 CONFIG_SND_SOC_TAS571X=m
+CONFIG_SND_SOC_TLV320AIC32X4_I2C=m
 CONFIG_SND_SOC_WCD934X=m
 CONFIG_SND_SOC_WM8904=m
 CONFIG_SND_SOC_WM8960=m
@@ -908,6 +912,7 @@ CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_HYM8563=m
 CONFIG_RTC_DRV_MAX77686=y
 CONFIG_RTC_DRV_RK808=m
+CONFIG_RTC_DRV_PCF85063=m
 CONFIG_RTC_DRV_PCF85363=m
 CONFIG_RTC_DRV_M41T80=m
 CONFIG_RTC_DRV_RX8581=m
@@ -1175,6 +1180,8 @@ CONFIG_SLIM_QCOM_NGD_CTRL=m
 CONFIG_MUX_MMIO=y
 CONFIG_INTERCONNECT=y
 CONFIG_INTERCONNECT_IMX=m
+CONFIG_INTERCONNECT_IMX8MM=m
+CONFIG_INTERCONNECT_IMX8MN=m
 CONFIG_INTERCONNECT_IMX8MQ=m
 CONFIG_INTERCONNECT_QCOM=y
 CONFIG_INTERCONNECT_QCOM_MSM8916=m
-- 
2.25.1

