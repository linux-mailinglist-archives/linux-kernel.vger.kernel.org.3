Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147F3483945
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbiACXkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiACXkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:40:04 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F389C061761;
        Mon,  3 Jan 2022 15:40:03 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id v4so29884127qtk.0;
        Mon, 03 Jan 2022 15:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0OBHyV0Yv0fxv0JIp0Dg+o77BaY4TFzMuQN0E/92Zw=;
        b=jfglK91yHDPAxFW7UmvQNIZ3Kb9MeAw7xven4vLGLkBIgPwJBin6posEjhgdflEu2I
         NwOfxO7RtcpObVq+lxSVAnS6Q16s4pYtSqSu6hJGeqRceig7duFgVijexrttL5knuRwH
         ksX2haCa4oOPKIe16zHaf+IxHM9238NFn4jSPn9LXK4XmFOg33OixZgsmLcEIQCqgObm
         kLe0hWpr6dfXE3cZrM2rcbICu8YRsXK9vP8UCHpkbGkSej/2lpTJ9Y1+U9igy7s+ZcUR
         k9jaF07oxbuN1eG5o1SK/djvYMPMiSWRnk+4Rl/5JsqG8MMbSNhW7/oE7nc32Km5nozk
         y0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0OBHyV0Yv0fxv0JIp0Dg+o77BaY4TFzMuQN0E/92Zw=;
        b=KH51vO79klCJ5QkKCVLDvlpu2kkPW/sm1RhVlzK5DKJUSABjjmJ4hbgXB7zyX3hiVA
         QR0de18jecAfdv1S/UWnJ4zMEiqt7NR3O+H+6QKxFupCqZh8yVEZrhnbB7l8y61VOQBV
         5HYpKROPtAJjGX8gN6FNHGp0gq+cb3HbtLNDsfsvFm0XzakaVi35EaH4ioQaU7/JYI9C
         Zcj3mYJJPhoY/N89i5snBKDNd21zIE0I8mcSoYb34VadZKkgccYeby0LodHbQbtr3hm/
         Ilvj+hyrs+Qcx6LqVTnKbkrttuSAr0bW+GeMmv2u8tZS9EQGcDmt4oeV8gwl3Il2bU/6
         TnfQ==
X-Gm-Message-State: AOAM532QEreWoBmHIcA1j1/9DyC2KQjShlbJKX9VoBMBNoBNdhj7cd/F
        SVagZ/wfBXyYyrvvf3XZizA=
X-Google-Smtp-Source: ABdhPJzhGRPuzumek58syRdqEvkjERaZvB9j7i2ee8TKYsHTfcv8/2Xw18wRIlR/yDEpPv807riaGg==
X-Received: by 2002:ac8:7f89:: with SMTP id z9mr42462922qtj.15.1641253202503;
        Mon, 03 Jan 2022 15:40:02 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id o5sm26965991qkp.132.2022.01.03.15.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 15:40:02 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: [PATCH v7 7/7] ARM: imxrt_defconfig: Add i.MXRT family defconfig
Date:   Mon,  3 Jan 2022 18:39:48 -0500
Message-Id: <20220103233948.198119-8-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@benettiengineering.com>

Add generic i.MXRT family defconfig.

Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1->V2:
* Nothing done
V2->V3:
* Nothing done
V3->V4:
* Remove unnecessary CONFIGs
* Add futex suport after "ARM: 9122/1: select HAVE_FUTEX_CMPXCHG"
9d417cbe36eee7afdd85c2e871685f8dab7c2dba
V4->V5:
* Change commit description
V5->V6:
* Nothing done
V6->V7:
* Nothing done
---
 arch/arm/configs/imxrt_defconfig | 35 ++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/arm/configs/imxrt_defconfig

diff --git a/arch/arm/configs/imxrt_defconfig b/arch/arm/configs/imxrt_defconfig
new file mode 100644
index 000000000000..52dba3762996
--- /dev/null
+++ b/arch/arm/configs/imxrt_defconfig
@@ -0,0 +1,35 @@
+# CONFIG_LOCALVERSION_AUTO is not set
+CONFIG_BPF_SYSCALL=y
+CONFIG_SCHED_AUTOGROUP=y
+# CONFIG_MMU is not set
+CONFIG_ARCH_MXC=y
+CONFIG_SOC_IMXRT=y
+CONFIG_SET_MEM_PARAM=y
+CONFIG_DRAM_BASE=0x80000000
+CONFIG_DRAM_SIZE=0x02000000
+CONFIG_BINFMT_FLAT=y
+CONFIG_UEVENT_HELPER=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_IMX_WEIM=y
+CONFIG_LEGACY_PTY_COUNT=2
+CONFIG_SERIAL_FSL_LPUART=y
+CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
+CONFIG_SERIAL_DEV_BUS=y
+CONFIG_PINCTRL_IMXRT1050=y
+CONFIG_GPIO_MXC=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_ESDHC_IMX=y
+CONFIG_DMADEVICES=y
+CONFIG_FSL_EDMA=y
+CONFIG_CLK_IMXRT1050=y
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_UTF8=y
+CONFIG_EXFAT_FS=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_UTF8=y
-- 
2.34.1

