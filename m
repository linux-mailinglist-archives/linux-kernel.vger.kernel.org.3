Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1EE487BC1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348699AbiAGSEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 13:04:33 -0500
Received: from mout.perfora.net ([74.208.4.194]:60417 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240475AbiAGSEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 13:04:25 -0500
Received: from localhost.localdomain ([194.191.235.54]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MOznU-1mitcv2HwS-00PPGZ;
 Fri, 07 Jan 2022 19:04:06 +0100
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
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Shawn Guo <shawnguo@kernel.org>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 07/14] arm64: defconfig: build ads1015 adc driver as a module
Date:   Fri,  7 Jan 2022 19:03:07 +0100
Message-Id: <20220107180314.1816515-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220107180314.1816515-1-marcel@ziswiler.com>
References: <20220107180314.1816515-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:c3r6KQGKGeNTIT6j7Hnt1g1cDwAHJD/E37OZPAIuO9kfZNVCVDt
 alvZ8oiJBEyRYjOUOklSqQfF38XTFNhKkbMp2HJzWK5AlGupwv92Fnjr8wDNCtoca9TZpYu
 J23e1vka9NC3Zp/PVCjhHgGs2fQmtDZGhZeuiB7nwgst0FNc9kS1FKGn/2zIZLtKPaiFT88
 e+hRDpUTHYY47TLgXji+g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Zdfv2+b2/bc=:dbysLBn7EgZEG58YMK9yIY
 T615r4cGOt8sgriNeetEwgTOXqqe7nYszCy5FAkILvYtTYjzu3XcbIlXX/7fP0jcUOn9sW5wR
 g/Na5tpCfdr29lzecw6bpRRpO2tjWat1yt5ohUlcapNUGhrFA+D/+Y7Een8zWCbUZ3mqiCrrq
 IkPXdFoO/efWpsl1QwJBtrqIzsJXZw/3gdu0OrApi1v+5GUFjAg68Eh1f8JUcjXzx4JgXmSX8
 xgZ+2CHCR4Pko6YtHhejZA3bE4HcrdaSbJejq62dJn8nqoS1deuGJvQtslNW3eAe0YURiOkmc
 JPjqVI+q1SkENEYtVq7cuG7QRP8g6uF0kmJ//x373vIjC4i0bxbr5cpTIx0RvIJUPGKG6Kg3D
 0YgH0V39KUSq4aBozBrxlDcNnuJD0IvCLB40rPdmf2ZvxI99/eVn1RH71iTHfbb6l4RRXhcWz
 3DkHrSbLvRnWHnX8Y0Ae0ZyMSqXo9a+JaVjeShkzGb6O2DYpdWfJ5EhrMhXjVnxeDiX/1Muwm
 LQ5p8cPMSDYumb5DoflxDV+uzSXuPfeSWRX+cZ4cJNQ1NowmgO7I0QotDgGT3/BIFEr1eMdhv
 LRdeuO2wr05V/mnGCQ6MghiSveeIUxj+lS3eHNy8Jnyv0B+KWB8hwtjBYLNyIoGixGAkjB7zy
 NRsr+LssZvofQ0jBvtNYF+SG79yjk9x+vLago7wdpkpW12bv2okGe5KFAljNIlZB0B0bS+TB5
 LXb1gXh/L8SJkPyZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Build Texas Instruments ADS1015 ADC IIO driver as a module.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 86d39d8456c1..1d0fe0bd0059 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1071,6 +1071,7 @@ CONFIG_QCOM_SPMI_VADC=m
 CONFIG_QCOM_SPMI_ADC5=m
 CONFIG_ROCKCHIP_SARADC=m
 CONFIG_RZG2L_ADC=m
+CONFIG_TI_ADS1015=m
 CONFIG_IIO_CROS_EC_SENSORS_CORE=m
 CONFIG_IIO_CROS_EC_SENSORS=m
 CONFIG_IIO_ST_LSM6DSX=m
-- 
2.33.1

