Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC13A522E65
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243712AbiEKIah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbiEKIaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:30:22 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B26B118B97B;
        Wed, 11 May 2022 01:30:19 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxkNoPdHtiw+cQAA--.6S4;
        Wed, 11 May 2022 16:30:10 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, yangtiezhu@loongson.cn,
        zhangqing@loongson.cn
Subject: [PATCH 3/3] MIPS: Loongson64: Enable CONFIG_SMP and set default NR_CPUS to 2
Date:   Wed, 11 May 2022 16:30:07 +0800
Message-Id: <20220511083007.17700-3-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220511083007.17700-1-zhangqing@loongson.cn>
References: <20220511083007.17700-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxkNoPdHtiw+cQAA--.6S4
X-Coremail-Antispam: 1UD129KBjvJXoWxuryDKFW8Cr45KF1UKF1Utrb_yoW5ur4Dpr
        4fGFWxXay8Kr1UKrWjkr4DGasYqayDJa9FkF47Aw1Du3W8Aa13Xr1Dtr18JrWUXFZrXr4r
        Xas3Kwn3Aan8Ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
        x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
        0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
        IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
        Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
        0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
        IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
        0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
        Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjTRijjyUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/mips/configs/loongson2k_defconfig | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/arch/mips/configs/loongson2k_defconfig b/arch/mips/configs/loongson2k_defconfig
index e948ca487e2d..74353a4254eb 100644
--- a/arch/mips/configs/loongson2k_defconfig
+++ b/arch/mips/configs/loongson2k_defconfig
@@ -20,7 +20,10 @@ CONFIG_RELAY=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_EMBEDDED=y
 CONFIG_MACH_LOONGSON64=y
+# CONFIG_CPU_LOONGSON3_WORKAROUNDS is not set
 # CONFIG_CPU_LOONGSON3_CPUCFG_EMULATION is not set
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
 CONFIG_HZ_256=y
 CONFIG_MIPS32_O32=y
 CONFIG_MIPS32_N32=y
@@ -95,7 +98,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=m
 CONFIG_BLK_DEV_LOOP=y
-CONFIG_BLK_DEV_CRYPTOLOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
 CONFIG_RAID_ATTRS=m
@@ -144,7 +146,6 @@ CONFIG_TUN=m
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
-# CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_CHELSIO is not set
 # CONFIG_NET_VENDOR_CIRRUS is not set
 # CONFIG_NET_VENDOR_CISCO is not set
@@ -163,15 +164,16 @@ CONFIG_IXGBE=y
 # CONFIG_NET_VENDOR_MICROCHIP is not set
 # CONFIG_NET_VENDOR_MICROSEMI is not set
 # CONFIG_NET_VENDOR_MYRI is not set
+# CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_NATSEMI is not set
 # CONFIG_NET_VENDOR_NETERION is not set
 # CONFIG_NET_VENDOR_NETRONOME is not set
-# CONFIG_NET_VENDOR_NI is not set
 # CONFIG_NET_VENDOR_NVIDIA is not set
 # CONFIG_NET_VENDOR_OKI is not set
 # CONFIG_NET_VENDOR_PACKET_ENGINES is not set
 # CONFIG_NET_VENDOR_PENSANDO is not set
 # CONFIG_NET_VENDOR_QLOGIC is not set
+# CONFIG_NET_VENDOR_BROCADE is not set
 # CONFIG_NET_VENDOR_QUALCOMM is not set
 # CONFIG_NET_VENDOR_RDC is not set
 CONFIG_8139CP=y
@@ -182,9 +184,9 @@ CONFIG_R8169=y
 # CONFIG_NET_VENDOR_ROCKER is not set
 # CONFIG_NET_VENDOR_SAMSUNG is not set
 # CONFIG_NET_VENDOR_SEEQ is not set
-# CONFIG_NET_VENDOR_SOLARFLARE is not set
 # CONFIG_NET_VENDOR_SILAN is not set
 # CONFIG_NET_VENDOR_SIS is not set
+# CONFIG_NET_VENDOR_SOLARFLARE is not set
 # CONFIG_NET_VENDOR_SMSC is not set
 CONFIG_STMMAC_ETH=y
 # CONFIG_NET_VENDOR_SUN is not set
@@ -229,7 +231,6 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_NONSTANDARD=y
 CONFIG_HW_RANDOM=y
-CONFIG_RAW_DRIVER=m
 CONFIG_I2C_CHARDEV=y
 CONFIG_I2C_PIIX4=y
 CONFIG_GPIO_LOONGSON=y
@@ -243,13 +244,9 @@ CONFIG_MEDIA_USB_SUPPORT=y
 CONFIG_USB_VIDEO_CLASS=m
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
-CONFIG_FB_RADEON=y
 CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=m
 # CONFIG_VGA_CONSOLE is not set
-CONFIG_FRAMEBUFFER_CONSOLE=y
-CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=y
-CONFIG_LOGO=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_VERBOSE_PRINTK=y
@@ -336,7 +333,6 @@ CONFIG_DEFAULT_SECURITY_DAC=y
 CONFIG_CRYPTO_SEQIV=m
 CONFIG_CRYPTO_HMAC=y
 CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_TGR192=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_BLOWFISH=m
 CONFIG_CRYPTO_CAST5=m
-- 
2.20.1

