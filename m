Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A6A56CB82
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 23:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiGIVQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 17:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiGIVQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 17:16:48 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B4DE031
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 14:16:47 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso1671663pjj.5
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
        b=o6vJUaK5s3FRRIr1orvVL8DhPS6tgH7MkcPUxL62UVIkJj/miqCG73eUkcn/J//J/h
         BLcv0ikNeOtsh4fq0zRSajFCXzJzwlEmIaEkgHOtaaKSr+luwEsEit3MD591YFAmlKfr
         FOzGjIgXDeuHsHaTxL8+aR/ZlIu88MtaeE/k+5w2cyU1WRQHJkVy1yZB7AV60BgAysxh
         JS8t2InMRmP6rvGbrRHcsP7Ib3LUqAyyYdfyZg8QwUR3kX7Ou4i9s+UVfFb4dug9orh7
         MuQBIo5RCa3A75OxusFOcB5++d8w4OVt+6Etsds6+MmGgKV/OQE2GvmBdrPEy1/+UzaV
         xvQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
        b=bzPTpzrHo7d4Ci6eFZp7kreCgz6GteYR9elTkfjITGtcb0jvzQEpbAbKoAevEv3QTs
         FFSv6v55ERb0IVR+H+CtHn500YjZ5SaAZWF2mN94nMSOfEIKxuwDSEs/PAMCPNivE9Xu
         CenLA99iI8BdGE3SXUplpRTPoGOCIMozEFqPpAPyi0E16rMnbmmwEpdRNF7KB3xLst0N
         fAg1V3VvPDz4Rk07F8QqWPF8nUUPzq7d8gMh89YDuud+Eb4Lx9EMGz9eTEXXuG9Q6F2+
         1NK+5aCMr2IXWTXDV1ldyUWFuH2vQ7pSEgOFO91KZBBtVpODYJzQotTm5IxaqhGYxihl
         bHIA==
X-Gm-Message-State: AJIora8GJNhwPJW/XoYz9cgF6zY9eDBJrQ4YfBrHOr5HeN8dMtk6go+d
        HwLjLq1XyGkJYmSmlRZUNIL5eJXqr0c=
X-Google-Smtp-Source: AGRyM1uvjZnIh0oHuLg51QGQVl97sMhJ6t+Q15UlazhWY7up63kdsrc+Or8FTQhBwmQT1qjcWn6smQ==
X-Received: by 2002:a17:903:22c7:b0:16b:fa15:63d4 with SMTP id y7-20020a17090322c700b0016bfa1563d4mr10623100plg.2.1657401407139;
        Sat, 09 Jul 2022 14:16:47 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id z16-20020aa79490000000b0051c6613b5basm1901097pfk.134.2022.07.09.14.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jul 2022 14:16:46 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Subject: [PATCH 2/2] openrisc: Add virt defconfig
Date:   Sun, 10 Jul 2022 06:15:49 +0900
Message-Id: <20220709211549.1163327-3-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220709211549.1163327-1-shorne@gmail.com>
References: <20220709211549.1163327-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been developing a new qemu virt platform to help with more
efficient toolchain and kernel testing [1].

This patch adds the defconfig which is needed to support booting
linux on the platform.

[1] https://lore.kernel.org/qemu-devel/YpwNtowUTxRbh2Uq@antec/T/#m6db180b0d682785fb320e4a05345c12a063e0c47

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/configs/virt_defconfig | 108 +++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)
 create mode 100644 arch/openrisc/configs/virt_defconfig

diff --git a/arch/openrisc/configs/virt_defconfig b/arch/openrisc/configs/virt_defconfig
new file mode 100644
index 000000000000..c1b69166c500
--- /dev/null
+++ b/arch/openrisc/configs/virt_defconfig
@@ -0,0 +1,108 @@
+CONFIG_SYSVIPC=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_NO_HZ_IDLE=y
+CONFIG_LOG_BUF_SHIFT=14
+CONFIG_CGROUPS=y
+CONFIG_BLK_DEV_INITRD=y
+CONFIG_OPENRISC_HAVE_INST_CMOV=y
+CONFIG_OPENRISC_HAVE_INST_ROR=y
+CONFIG_OPENRISC_HAVE_INST_RORI=y
+CONFIG_OPENRISC_HAVE_INST_SEXT=y
+CONFIG_NR_CPUS=8
+CONFIG_SMP=y
+CONFIG_HZ_100=y
+# CONFIG_OPENRISC_NO_SPR_SR_DSX is not set
+# CONFIG_COMPAT_BRK is not set
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+# CONFIG_INET_DIAG is not set
+CONFIG_TCP_CONG_ADVANCED=y
+# CONFIG_TCP_CONG_BIC is not set
+# CONFIG_TCP_CONG_CUBIC is not set
+# CONFIG_TCP_CONG_WESTWOOD is not set
+# CONFIG_TCP_CONG_HTCP is not set
+# CONFIG_IPV6 is not set
+# CONFIG_WIRELESS is not set
+CONFIG_PCI=y
+CONFIG_PCIEPORTBUS=y
+CONFIG_PCI_HOST_GENERIC=y
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
+# CONFIG_PREVENT_FIRMWARE_BUILD is not set
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_NBD=y
+CONFIG_VIRTIO_BLK=y
+CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
+CONFIG_ETHOC=y
+CONFIG_MICREL_PHY=y
+# CONFIG_WLAN is not set
+CONFIG_INPUT_MOUSEDEV=y
+# CONFIG_LEGACY_PTYS is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_OF_PLATFORM=y
+CONFIG_VIRTIO_CONSOLE=y
+# CONFIG_HW_RANDOM is not set
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_SYSCON=y
+CONFIG_POWER_RESET_SYSCON_POWEROFF=y
+CONFIG_SYSCON_REBOOT_MODE=y
+# CONFIG_HWMON is not set
+CONFIG_DRM=y
+# CONFIG_DRM_FBDEV_EMULATION is not set
+CONFIG_DRM_VIRTIO_GPU=y
+CONFIG_FB=y
+CONFIG_FIRMWARE_EDID=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+CONFIG_LOGO=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_INTEL8X0=y
+CONFIG_SND_INTEL8X0M=y
+CONFIG_SND_SOC=y
+CONFIG_SND_VIRTIO=y
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_ITE is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_REDRAGON is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+CONFIG_USB=y
+CONFIG_USB_XHCI_HCD=y
+CONFIG_USB_XHCI_PLATFORM=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_HCD_PLATFORM=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_HCD_PLATFORM=y
+CONFIG_USB_SERIAL=y
+CONFIG_USB_GADGET=y
+CONFIG_TYPEC=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_GOLDFISH=y
+CONFIG_VIRT_DRIVERS=y
+CONFIG_VIRTIO_PCI=y
+# CONFIG_VIRTIO_PCI_LEGACY is not set
+CONFIG_VIRTIO_INPUT=y
+CONFIG_VIRTIO_MMIO=y
+CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
+CONFIG_EXT3_FS=y
+CONFIG_EXT3_FS_POSIX_ACL=y
+# CONFIG_DNOTIFY is not set
+CONFIG_MSDOS_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_EXFAT_FS=y
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_UNICODE=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
+CONFIG_FTRACE=y
-- 
2.36.1

