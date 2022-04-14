Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BA5501952
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbiDNRAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 13:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245596AbiDNQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:58:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74D6C6258;
        Thu, 14 Apr 2022 09:30:03 -0700 (PDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EENBAj029780;
        Thu, 14 Apr 2022 16:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=9IQFbuSyMLorbXY7Ut29J0DgE7z3TV3b6uIMPnJ2p/I=;
 b=XEZdN9vFhzgZiC2L1+5qIZVv8j7uMq4OaDBpMbnyRyCs4MkjIMypzK0geO2Id9nLCmlZ
 3BnXeprkpmv9vaSUi1gqUdoop/s67iTdl1Tvj29KSPBPXzSdEwzFTgBtXJTRzJTrDhfb
 jbl7cxhZiegzG7v6wvyCp+1WT43ER+Jv7YHs/SHDAgwzBJrk2eUBtJzi9Q1h+Fspck2d
 IGcKjbPfP30IA0qxGA+b6Xt9JEQjc1pxr6EdMFKuElkPziWHG7lhlIXeDUdgyLDlzZO2
 XtU4ExDwu+FBbvAJD0XaUpAJtGTbdsfKGzICOcNMWCyI0RerewDoxeZXW9kBNCVaKRlB ow== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3fef2mtwbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 16:30:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 23EGIW8Q005729;
        Thu, 14 Apr 2022 16:30:00 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03ams.nl.ibm.com with ESMTP id 3fb1s90ycd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Apr 2022 16:30:00 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 23EGTvk339846392
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 16:29:57 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81C384C04A;
        Thu, 14 Apr 2022 16:29:57 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36B4F4C040;
        Thu, 14 Apr 2022 16:29:57 +0000 (GMT)
Received: from osiris (unknown [9.145.172.147])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Apr 2022 16:29:57 +0000 (GMT)
Date:   Thu, 14 Apr 2022 18:29:55 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.18-rc3
Message-ID: <YlhMA5GB1dkKyu8k@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wVbfbQDVOwrHLcypmMMHchzIweztIo7A
X-Proofpoint-GUID: wVbfbQDVOwrHLcypmMMHchzIweztIo7A
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-14_04,2022-04-14_02,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 spamscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140085
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some s390 updates for 5.18-rc3.

Thanks,
Heiko

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-3

for you to fetch changes up to c68c63429319a923a3f23db64810ba608f5d20f7:

  s390: enable CONFIG_HARDENED_USERCOPY in debug_defconfig (2022-04-12 11:56:08 +0200)

----------------------------------------------------------------
s390 updates for 5.18-rc3

- Convert current_stack_pointer to a register alias like it is assumed if
  ARCH_HAS_CURRENT_STACK_POINTER is selected. The existing implementation
  as a function breaks CONFIG_HARDENED_USERCOPY sanity-checks.

- Get rid of -Warray-bounds warning within kexec code.

- Add minimal IBM z16 support by reporting a proper elf platform, and
  adding compile options.

- Update defconfigs.

----------------------------------------------------------------
Heiko Carstens (4):
      s390: add z16 elf platform
      s390: allow to compile with z16 optimizations
      s390/kexec: silence -Warray-bounds warning
      s390: update defconfigs

Sven Schnelle (2):
      s390: current_stack_pointer shouldn't be a function
      s390: enable CONFIG_HARDENED_USERCOPY in debug_defconfig

 arch/s390/Kconfig                    | 19 +++++++++++++++++++
 arch/s390/Makefile                   |  2 ++
 arch/s390/configs/debug_defconfig    |  8 ++++++--
 arch/s390/configs/defconfig          |  6 ++++--
 arch/s390/configs/zfcpdump_defconfig |  6 +++---
 arch/s390/include/asm/entry-common.h |  2 +-
 arch/s390/include/asm/processor.h    |  8 +-------
 arch/s390/include/asm/stacktrace.h   |  2 +-
 arch/s390/kernel/machine_kexec.c     |  2 +-
 arch/s390/kernel/processor.c         |  4 ++++
 arch/s390/lib/test_unwind.c          |  2 +-
 11 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 77b5a03de13a..e084c72104f8 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -255,6 +255,10 @@ config HAVE_MARCH_Z15_FEATURES
 	def_bool n
 	select HAVE_MARCH_Z14_FEATURES
 
+config HAVE_MARCH_Z16_FEATURES
+	def_bool n
+	select HAVE_MARCH_Z15_FEATURES
+
 choice
 	prompt "Processor type"
 	default MARCH_Z196
@@ -312,6 +316,14 @@ config MARCH_Z15
 	  and 8561 series). The kernel will be slightly faster but will not
 	  work on older machines.
 
+config MARCH_Z16
+	bool "IBM z16"
+	select HAVE_MARCH_Z16_FEATURES
+	depends on $(cc-option,-march=z16)
+	help
+	  Select this to enable optimizations for IBM z16 (3931 and
+	  3932 series).
+
 endchoice
 
 config MARCH_Z10_TUNE
@@ -332,6 +344,9 @@ config MARCH_Z14_TUNE
 config MARCH_Z15_TUNE
 	def_bool TUNE_Z15 || MARCH_Z15 && TUNE_DEFAULT
 
+config MARCH_Z16_TUNE
+	def_bool TUNE_Z16 || MARCH_Z16 && TUNE_DEFAULT
+
 choice
 	prompt "Tune code generation"
 	default TUNE_DEFAULT
@@ -372,6 +387,10 @@ config TUNE_Z15
 	bool "IBM z15"
 	depends on $(cc-option,-mtune=z15)
 
+config TUNE_Z16
+	bool "IBM z16"
+	depends on $(cc-option,-mtune=z16)
+
 endchoice
 
 config 64BIT
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 7a65bca1e5af..e441b60b1812 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -42,6 +42,7 @@ mflags-$(CONFIG_MARCH_ZEC12)  := -march=zEC12
 mflags-$(CONFIG_MARCH_Z13)    := -march=z13
 mflags-$(CONFIG_MARCH_Z14)    := -march=z14
 mflags-$(CONFIG_MARCH_Z15)    := -march=z15
+mflags-$(CONFIG_MARCH_Z16)    := -march=z16
 
 export CC_FLAGS_MARCH := $(mflags-y)
 
@@ -54,6 +55,7 @@ cflags-$(CONFIG_MARCH_ZEC12_TUNE)	+= -mtune=zEC12
 cflags-$(CONFIG_MARCH_Z13_TUNE)		+= -mtune=z13
 cflags-$(CONFIG_MARCH_Z14_TUNE)		+= -mtune=z14
 cflags-$(CONFIG_MARCH_Z15_TUNE)		+= -mtune=z15
+cflags-$(CONFIG_MARCH_Z16_TUNE)		+= -mtune=z16
 
 cflags-y += -Wa,-I$(srctree)/arch/$(ARCH)/include
 
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 498bed9b261b..f6dfde577ce8 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -499,11 +499,13 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_CHELSIO is not set
 # CONFIG_NET_VENDOR_CISCO is not set
 # CONFIG_NET_VENDOR_CORTINA is not set
+# CONFIG_NET_VENDOR_DAVICOM is not set
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
 # CONFIG_NET_VENDOR_ENGLEDER is not set
 # CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_FUNGIBLE is not set
 # CONFIG_NET_VENDOR_GOOGLE is not set
 # CONFIG_NET_VENDOR_HUAWEI is not set
 # CONFIG_NET_VENDOR_INTEL is not set
@@ -588,13 +590,13 @@ CONFIG_MLX5_INFINIBAND=m
 CONFIG_SYNC_FILE=y
 CONFIG_VFIO=m
 CONFIG_VFIO_PCI=m
+CONFIG_MLX5_VFIO_PCI=m
 CONFIG_VFIO_MDEV=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
-# CONFIG_SURFACE_PLATFORMS is not set
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
@@ -690,6 +692,7 @@ CONFIG_ENCRYPTED_KEYS=m
 CONFIG_KEY_NOTIFICATIONS=y
 CONFIG_SECURITY=y
 CONFIG_SECURITY_NETWORK=y
+CONFIG_HARDENED_USERCOPY=y
 CONFIG_FORTIFY_SOURCE=y
 CONFIG_SECURITY_SELINUX=y
 CONFIG_SECURITY_SELINUX_BOOTPARAM=y
@@ -733,6 +736,7 @@ CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA3=m
+CONFIG_CRYPTO_SM3=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES_TI=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -786,7 +790,6 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_GDB_SCRIPTS=y
@@ -814,6 +817,7 @@ CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
 CONFIG_DEBUG_PER_CPU_MAPS=y
 CONFIG_KFENCE=y
+CONFIG_KFENCE_DEFERRABLE=y
 CONFIG_KFENCE_STATIC_KEYS=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_PANIC_ON_OOPS=y
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index 61e36b999f67..706df3a4a867 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -490,11 +490,13 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_CHELSIO is not set
 # CONFIG_NET_VENDOR_CISCO is not set
 # CONFIG_NET_VENDOR_CORTINA is not set
+# CONFIG_NET_VENDOR_DAVICOM is not set
 # CONFIG_NET_VENDOR_DEC is not set
 # CONFIG_NET_VENDOR_DLINK is not set
 # CONFIG_NET_VENDOR_EMULEX is not set
 # CONFIG_NET_VENDOR_ENGLEDER is not set
 # CONFIG_NET_VENDOR_EZCHIP is not set
+# CONFIG_NET_VENDOR_FUNGIBLE is not set
 # CONFIG_NET_VENDOR_GOOGLE is not set
 # CONFIG_NET_VENDOR_HUAWEI is not set
 # CONFIG_NET_VENDOR_INTEL is not set
@@ -578,13 +580,13 @@ CONFIG_MLX5_INFINIBAND=m
 CONFIG_SYNC_FILE=y
 CONFIG_VFIO=m
 CONFIG_VFIO_PCI=m
+CONFIG_MLX5_VFIO_PCI=m
 CONFIG_VFIO_MDEV=m
 CONFIG_VIRTIO_PCI=m
 CONFIG_VIRTIO_BALLOON=m
 CONFIG_VIRTIO_INPUT=y
 CONFIG_VHOST_NET=m
 CONFIG_VHOST_VSOCK=m
-# CONFIG_SURFACE_PLATFORMS is not set
 CONFIG_S390_CCW_IOMMU=y
 CONFIG_S390_AP_IOMMU=y
 CONFIG_EXT4_FS=y
@@ -720,6 +722,7 @@ CONFIG_CRYPTO_MD5=y
 CONFIG_CRYPTO_MICHAEL_MIC=m
 CONFIG_CRYPTO_RMD160=m
 CONFIG_CRYPTO_SHA3=m
+CONFIG_CRYPTO_SM3=m
 CONFIG_CRYPTO_WP512=m
 CONFIG_CRYPTO_AES_TI=m
 CONFIG_CRYPTO_ANUBIS=m
@@ -772,7 +775,6 @@ CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
-CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_GDB_SCRIPTS=y
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index c55c668dc3c7..a87fcc45e307 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -26,6 +26,7 @@ CONFIG_CRASH_DUMP=y
 # CONFIG_S390_GUEST is not set
 # CONFIG_SECCOMP is not set
 # CONFIG_GCC_PLUGINS is not set
+# CONFIG_BLOCK_LEGACY_AUTOLOAD is not set
 CONFIG_PARTITION_ADVANCED=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 # CONFIG_COMPACTION is not set
@@ -60,7 +61,6 @@ CONFIG_ZFCP=y
 # CONFIG_HID is not set
 # CONFIG_VIRTIO_MENU is not set
 # CONFIG_VHOST_MENU is not set
-# CONFIG_SURFACE_PLATFORMS is not set
 # CONFIG_IOMMU_SUPPORT is not set
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
@@ -71,10 +71,10 @@ CONFIG_LSM="yama,loadpin,safesetid,integrity"
 CONFIG_XZ_DEC_MICROLZMA=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_SYMBOLIC_ERRNAME is not set
-CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO_DWARF4=y
 CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_FS=y
-CONFIG_DEBUG_KERNEL=y
 CONFIG_PANIC_ON_OOPS=y
 # CONFIG_SCHED_DEBUG is not set
 CONFIG_RCU_CPU_STALL_TIMEOUT=60
diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
index eabab24b71dd..2f0a1cacdf85 100644
--- a/arch/s390/include/asm/entry-common.h
+++ b/arch/s390/include/asm/entry-common.h
@@ -58,7 +58,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
 
 static inline bool on_thread_stack(void)
 {
-	return !(((unsigned long)(current->stack) ^ current_stack_pointer()) & ~(THREAD_SIZE - 1));
+	return !(((unsigned long)(current->stack) ^ current_stack_pointer) & ~(THREAD_SIZE - 1));
 }
 
 #endif
diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index eee8d96fb38e..ff1e25d515a8 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -200,13 +200,7 @@ unsigned long __get_wchan(struct task_struct *p);
 /* Has task runtime instrumentation enabled ? */
 #define is_ri_task(tsk) (!!(tsk)->thread.ri_cb)
 
-static __always_inline unsigned long current_stack_pointer(void)
-{
-	unsigned long sp;
-
-	asm volatile("la %0,0(15)" : "=a" (sp));
-	return sp;
-}
+register unsigned long current_stack_pointer asm("r15");
 
 static __always_inline unsigned short stap(void)
 {
diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
index 275f4258fbd5..f8500191993d 100644
--- a/arch/s390/include/asm/stacktrace.h
+++ b/arch/s390/include/asm/stacktrace.h
@@ -46,7 +46,7 @@ struct stack_frame {
 };
 
 /*
- * Unlike current_stack_pointer() which simply returns current value of %r15
+ * Unlike current_stack_pointer which simply contains the current value of %r15
  * current_frame_address() returns function stack frame address, which matches
  * %r15 upon function invocation. It may differ from %r15 later if function
  * allocates stack for local variables or new stack frame to call other
diff --git a/arch/s390/kernel/machine_kexec.c b/arch/s390/kernel/machine_kexec.c
index b2ef014a9287..6ebf02e15c85 100644
--- a/arch/s390/kernel/machine_kexec.c
+++ b/arch/s390/kernel/machine_kexec.c
@@ -54,7 +54,7 @@ static void __do_machine_kdump(void *image)
 	 * This need to be done *after* s390_reset_system set the
 	 * prefix register of this CPU to zero
 	 */
-	memcpy((void *) __LC_FPREGS_SAVE_AREA,
+	memcpy(absolute_pointer(__LC_FPREGS_SAVE_AREA),
 	       (void *)(prefix + __LC_FPREGS_SAVE_AREA), 512);
 
 	__load_psw_mask(PSW_MASK_BASE | PSW_DEFAULT_KEY | PSW_MASK_EA | PSW_MASK_BA);
diff --git a/arch/s390/kernel/processor.c b/arch/s390/kernel/processor.c
index 7a74ea5f7531..aa0e0e7fc773 100644
--- a/arch/s390/kernel/processor.c
+++ b/arch/s390/kernel/processor.c
@@ -283,6 +283,10 @@ static int __init setup_elf_platform(void)
 	case 0x8562:
 		strcpy(elf_platform, "z15");
 		break;
+	case 0x3931:
+	case 0x3932:
+		strcpy(elf_platform, "z16");
+		break;
 	}
 	return 0;
 }
diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index 9bb067321ab4..5a053b393d5c 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -147,7 +147,7 @@ static __always_inline struct pt_regs fake_pt_regs(void)
 	struct pt_regs regs;
 
 	memset(&regs, 0, sizeof(regs));
-	regs.gprs[15] = current_stack_pointer();
+	regs.gprs[15] = current_stack_pointer;
 
 	asm volatile(
 		"basr	%[psw_addr],0\n"
