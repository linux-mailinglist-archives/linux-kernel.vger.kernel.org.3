Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59DD157F82A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 04:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbiGYCIY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 22:08:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbiGYCIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 22:08:20 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BB3FD1C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:08:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id f11so9088117pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 19:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
        b=XqSF0FLr2QcdghFGdajoYosuSawd7eZdo5NaPH1hg4vLniqnKBptDuF7ihMmgpwwxg
         DpRjpjncqaJaTZWKKKXV/veHN7oedCH+J2hr2vpVY8UQm3DFFXa31omH+MC/TgExD6Bk
         Ngu2EdGqZR503533oD9SI7UCw1hA3qcWPHfdEhS163dT04JG/LWgNp6B42tW/cfQZMWT
         fqa0Bn7ocVLBtPRa2arbVyLgC+xoDrOZcuJQqrAwhZEXvq6aoQWa9ZAS7bwmUc4j4Q5g
         Xf1v3/YJdtK59O0BgkN7sTyPB9M141fbtE++wPdhUQY9HHU16g7CYuNkhJ4q+7ZeA0Fl
         0ObQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZWuX6ov4197gAn7zaYMbI8DUTRJY83Rd6vcUzJETd9g=;
        b=sZD+XTB4Gu0rLISw95hynQgH6uF/mPy/u/xxr1UXlfJXxr/shFGfMK6I6oc0Gvwb0Q
         Tzz95v4XK1U/LkJFT8Bjj0cAN0bBNLATYMy5WlUQXvTx56tCJjaOe6xtAvgpTbKgxMsM
         vxaxt3l2xC9Y76ibi9LfKEfItbSspAreYrDYhw78GrNw5rTFV8Zwo49eS6MtkcGeIVXp
         QzWHbakcnizYZBsM6ktoP43TebjqWgK67cSHm02UKHaHH7bU2s+2P+oSeoPAZ7lsFySI
         ch2zFjTOPXdX9HKcMhmiTDrI1Rcapq0E3ewOBwJwLa3xrd7EXDC4EKC7w0OiaPkzf1XS
         NICw==
X-Gm-Message-State: AJIora8VsZ0T+Jems2xxYL/+2LWhidp3j1mDtetHPWf+oAQ2TCxCmnB7
        pXUdmQImiMYiaHzfnvQueSKHQB4PYyXm6A==
X-Google-Smtp-Source: AGRyM1vu51mbhNjjI60KrfJm9SOuVAVVlovM1sCD2glOM1YO6DC3eiWv6836S+SygAu8Tt3irUvFMA==
X-Received: by 2002:a63:4a62:0:b0:412:8c83:a36c with SMTP id j34-20020a634a62000000b004128c83a36cmr9024945pgl.404.1658714898394;
        Sun, 24 Jul 2022 19:08:18 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id n7-20020a056a00212700b0052ab0a73752sm8124216pfj.198.2022.07.24.19.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 19:08:18 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: [PATCH v3 3/3] openrisc: Add virt defconfig
Date:   Mon, 25 Jul 2022 11:07:37 +0900
Message-Id: <20220725020737.1221739-4-shorne@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220725020737.1221739-1-shorne@gmail.com>
References: <20220725020737.1221739-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no
        autolearn_force=no version=3.4.6
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

