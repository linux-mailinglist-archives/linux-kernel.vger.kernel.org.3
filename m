Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52B174E60A3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348899AbiCXIv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344084AbiCXIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:51:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AE06541B;
        Thu, 24 Mar 2022 01:50:19 -0700 (PDT)
Date:   Thu, 24 Mar 2022 08:50:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648111818;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtF4Qim2vbB/9LwGjXpFwYho21gKLFj0rEAKlcM6YQE=;
        b=IVSGY+ANKe00zyf+9G1IW+0/vKxqfjZD+XtNuiyKFCnirYPNv8I2+4fRNOAmprkBv9XD6P
        4hO4CbPtZyX7zTlrO60cfax7JuL0viBNHBYcOzIOvgmkXix1WwZ3VUnR35tgNc8zyqCmLj
        8btcrm2v6NWuqmS29j73uJ3JwXkc89PNech8mu16K4GzDqbYpqOAd8kMFBFPrD/o/yU2cd
        lhbKxPl4yUrJcFNVvBkUtG8/AYi6Tn/ybnFZ0gIba9QLYMM+wtXzIp8m0fhB5FWysldUmZ
        kasrOEtTqeknQu78e1/RQ4jf8SS3IO93OgvTdP7L5Js/3yDOPhUWbSRIWcQw4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648111818;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtF4Qim2vbB/9LwGjXpFwYho21gKLFj0rEAKlcM6YQE=;
        b=Cin8sR3IMC0r3RaXgGAyB88Yz5Bbp0zGoOliIgFJI54Zr/QuLEdEEoywwGuOOrpNSaPsqy
        yXqRrpqIsWleYWAA==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/config: Make the x86 defconfigs a bit more usable
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6PkRPjnHE@gmail.com>
References: <6PkRPjnHE@gmail.com>
MIME-Version: 1.0
Message-ID: <164811181676.389.2059677983505845292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     aee8bf2d5aab5e7cc24fa90238930fd14d72e580
Gitweb:        https://git.kernel.org/tip/aee8bf2d5aab5e7cc24fa90238930fd14d72e580
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 24 Mar 2022 09:31:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 24 Mar 2022 09:32:20 +01:00

x86/config: Make the x86 defconfigs a bit more usable

 - Use 'make savedefconfig' to refresh & regenerate the files
 - Add in KVM boot enablers
 - Enable the cgroup features most distros rely on

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YjwsUT/6PkRPjnHE@gmail.com
---
 arch/x86/configs/i386_defconfig   | 50 ++++++++++++++++++++----------
 arch/x86/configs/x86_64_defconfig | 38 ++++++++++++++++-------
 2 files changed, 62 insertions(+), 26 deletions(-)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index 4b20852..fde771d 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -1,5 +1,7 @@
+CONFIG_WERROR=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_USELIB=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
@@ -11,23 +13,30 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_RDMA=y
 CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
 CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_MISC=y
+CONFIG_CGROUP_DEBUG=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
-# CONFIG_64BIT is not set
 CONFIG_SMP=y
-CONFIG_X86_GENERIC=y
-CONFIG_HPET_TIMER=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
+CONFIG_NR_CPUS=8
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
-CONFIG_X86_REBOOTFIXUPS=y
 CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
 CONFIG_X86_CPUID=y
-CONFIG_HIGHPTE=y
 CONFIG_X86_CHECK_BIOS_CORRUPTION=y
 # CONFIG_MTRR_SANITIZER is not set
 CONFIG_EFI=y
@@ -43,12 +52,15 @@ CONFIG_ACPI_BGRT=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_X86_ACPI_CPUFREQ=y
-CONFIG_EFI_VARS=y
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
+CONFIG_COMPAT_32BIT_TIME=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_BLK_CGROUP_IOLATENCY=y
+CONFIG_BLK_CGROUP_IOCOST=y
+CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -103,12 +115,16 @@ CONFIG_IP6_NF_FILTER=y
 CONFIG_IP6_NF_TARGET_REJECT=y
 CONFIG_IP6_NF_MANGLE=y
 CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_CGROUP=y
 CONFIG_NET_EMATCH=y
 CONFIG_NET_CLS_ACT=y
+CONFIG_CGROUP_NET_PRIO=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_MSI=y
@@ -119,13 +135,16 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
+CONFIG_EFI_VARS=y
+CONFIG_EFI_CAPSULE_LOADER=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SPI_ATTRS=y
-# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_SCSI_VIRTIO=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_ATA_PIIX=y
@@ -143,6 +162,7 @@ CONFIG_MACINTOSH_DRIVERS=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
+CONFIG_VIRTIO_NET=y
 CONFIG_BNX2=y
 CONFIG_TIGON3=y
 CONFIG_NET_TULIP=y
@@ -170,6 +190,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 CONFIG_NVRAM=y
 CONFIG_HPET=y
@@ -181,12 +202,7 @@ CONFIG_AGP_AMD64=y
 CONFIG_AGP_INTEL=y
 CONFIG_DRM=y
 CONFIG_DRM_I915=y
-CONFIG_FB_MODE_HELPERS=y
-CONFIG_FB_TILEBLITTING=y
-CONFIG_FB_EFI=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_HRTIMER=y
@@ -219,6 +235,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_DMADEVICES=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_INPUT=y
 CONFIG_EEEPC_LAPTOP=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
@@ -240,6 +258,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_9P_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
@@ -251,15 +270,14 @@ CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
 CONFIG_SECURITY_SELINUX_DISABLE=y
 CONFIG_PRINTK_TIME=y
+CONFIG_FRAME_WARN=1024
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_DEBUG_STACK_USAGE=y
-CONFIG_DEBUG_STACKOVERFLOW=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_SCHEDSTATS=y
 CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_WERROR=y
+CONFIG_UNWINDER_FRAME_POINTER=y
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defconfig
index 38c52e4..6978450 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -1,3 +1,4 @@
+CONFIG_WERROR=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
@@ -11,14 +12,25 @@ CONFIG_TASK_XACCT=y
 CONFIG_TASK_IO_ACCOUNTING=y
 CONFIG_LOG_BUF_SHIFT=18
 CONFIG_CGROUPS=y
+CONFIG_BLK_CGROUP=y
 CONFIG_CGROUP_SCHED=y
+CONFIG_CGROUP_PIDS=y
+CONFIG_CGROUP_RDMA=y
 CONFIG_CGROUP_FREEZER=y
+CONFIG_CGROUP_HUGETLB=y
 CONFIG_CPUSETS=y
+CONFIG_CGROUP_DEVICE=y
 CONFIG_CGROUP_CPUACCT=y
+CONFIG_CGROUP_PERF=y
+CONFIG_CGROUP_MISC=y
+CONFIG_CGROUP_DEBUG=y
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_KALLSYMS_ALL=y
 # CONFIG_COMPAT_BRK is not set
 CONFIG_PROFILING=y
 CONFIG_SMP=y
+CONFIG_HYPERVISOR_GUEST=y
+CONFIG_PARAVIRT=y
 CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=y
 CONFIG_MICROCODE_AMD=y
 CONFIG_X86_MSR=y
@@ -41,12 +53,14 @@ CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
 CONFIG_CPU_FREQ_GOV_ONDEMAND=y
 CONFIG_X86_ACPI_CPUFREQ=y
 CONFIG_IA32_EMULATION=y
-CONFIG_EFI_VARS=y
 CONFIG_KPROBES=y
 CONFIG_JUMP_LABEL=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
+CONFIG_BLK_CGROUP_IOLATENCY=y
+CONFIG_BLK_CGROUP_IOCOST=y
+CONFIG_BLK_CGROUP_IOPRIO=y
 CONFIG_BINFMT_MISC=y
 CONFIG_NET=y
 CONFIG_PACKET=y
@@ -101,12 +115,16 @@ CONFIG_IP6_NF_FILTER=y
 CONFIG_IP6_NF_TARGET_REJECT=y
 CONFIG_IP6_NF_MANGLE=y
 CONFIG_NET_SCHED=y
+CONFIG_NET_CLS_CGROUP=y
 CONFIG_NET_EMATCH=y
 CONFIG_NET_CLS_ACT=y
+CONFIG_CGROUP_NET_PRIO=y
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_MAC80211_LEDS=y
 CONFIG_RFKILL=y
+CONFIG_NET_9P=y
+CONFIG_NET_9P_VIRTIO=y
 CONFIG_PCI=y
 CONFIG_PCIEPORTBUS=y
 CONFIG_HOTPLUG_PCI=y
@@ -116,13 +134,15 @@ CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_DEBUG_DEVRES=y
 CONFIG_CONNECTOR=y
+CONFIG_EFI_VARS=y
 CONFIG_BLK_DEV_LOOP=y
+CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_BLK_DEV_SR=y
 CONFIG_CHR_DEV_SG=y
 CONFIG_SCSI_CONSTANTS=y
 CONFIG_SCSI_SPI_ATTRS=y
-# CONFIG_SCSI_LOWLEVEL is not set
+CONFIG_SCSI_VIRTIO=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_ATA_PIIX=y
@@ -138,6 +158,7 @@ CONFIG_MACINTOSH_DRIVERS=y
 CONFIG_MAC_EMUMOUSEBTN=y
 CONFIG_NETDEVICES=y
 CONFIG_NETCONSOLE=y
+CONFIG_VIRTIO_NET=y
 CONFIG_TIGON3=y
 CONFIG_NET_TULIP=y
 CONFIG_E100=y
@@ -162,6 +183,7 @@ CONFIG_SERIAL_8250_SHARE_IRQ=y
 CONFIG_SERIAL_8250_DETECT_IRQ=y
 CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_NONSTANDARD=y
+CONFIG_VIRTIO_CONSOLE=y
 CONFIG_HW_RANDOM=y
 # CONFIG_HW_RANDOM_INTEL is not set
 # CONFIG_HW_RANDOM_AMD is not set
@@ -175,12 +197,7 @@ CONFIG_AGP_AMD64=y
 CONFIG_AGP_INTEL=y
 CONFIG_DRM=y
 CONFIG_DRM_I915=y
-CONFIG_FB_MODE_HELPERS=y
-CONFIG_FB_TILEBLITTING=y
-CONFIG_FB_EFI=y
-CONFIG_LOGO=y
-# CONFIG_LOGO_LINUX_MONO is not set
-# CONFIG_LOGO_LINUX_VGA16 is not set
+CONFIG_DRM_VIRTIO_GPU=y
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_HRTIMER=y
@@ -213,6 +230,8 @@ CONFIG_USB_STORAGE=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_DMADEVICES=y
+CONFIG_VIRTIO_PCI=y
+CONFIG_VIRTIO_INPUT=y
 CONFIG_EEEPC_LAPTOP=y
 CONFIG_AMD_IOMMU=y
 CONFIG_INTEL_IOMMU=y
@@ -237,6 +256,7 @@ CONFIG_NFS_FS=y
 CONFIG_NFS_V3_ACL=y
 CONFIG_NFS_V4=y
 CONFIG_ROOT_NFS=y
+CONFIG_9P_FS=y
 CONFIG_NLS_DEFAULT="utf8"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
@@ -257,5 +277,3 @@ CONFIG_BLK_DEV_IO_TRACE=y
 CONFIG_PROVIDE_OHCI1394_DMA_INIT=y
 CONFIG_EARLY_PRINTK_DBGP=y
 CONFIG_DEBUG_BOOT_PARAMS=y
-CONFIG_KALLSYMS_ALL=y
-CONFIG_WERROR=y
