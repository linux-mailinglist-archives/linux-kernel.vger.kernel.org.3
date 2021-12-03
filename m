Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E0B467E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353441AbhLCTtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:49:04 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49668 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232563AbhLCTtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:49:03 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B3JM9Mq029940;
        Fri, 3 Dec 2021 19:45:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=AvmOL/7dy3eBq2s8abNKFtLLigRsr8Yw7hlNUXwG2pc=;
 b=Cf/PDIHjQdyKX9QnIZUV/TKAmagaG6D1ZpiUsDFwo1hRicp04+hgaE3y8pdniG5vQy8R
 wMUHim2aQX9MMjxHDbUMkcaWSzO7fDn6JuwshRiXsccsUL8VP2YEbM4EVifDVdXnUEQy
 EX6VSw18gEypy73SoHmti/tzWleXxf1u13anInVHwUprq6QqBPRzCPPO3ilk+wvWtXq3
 tLioOI0mwh9yUqBAO/qx41ebGRJF1y0NoyJrnyqIr8bTaNdh2vzZeKAJ2BJpYcJeXhBj
 g17dgxDmzccJeKrp1SuisWj3ICoNqySHxzYppCYXCNefrlZK/HeQmCEIJWPSYGcKcz2U Vw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cqsb30cc7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 19:45:37 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B3JgHdo031516;
        Fri, 3 Dec 2021 19:45:35 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 3ckbxm0u8c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Dec 2021 19:45:35 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B3JjWmT13042154
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Dec 2021 19:45:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E4DB6A405B;
        Fri,  3 Dec 2021 19:45:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1018A4040;
        Fri,  3 Dec 2021 19:45:31 +0000 (GMT)
Received: from osiris (unknown [9.145.9.173])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  3 Dec 2021 19:45:31 +0000 (GMT)
Date:   Fri, 3 Dec 2021 20:45:30 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.16-rc4
Message-ID: <Yapz2thD1GK8yQ6J@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G4ITLETFjZNAsh3wGqw2aW6JLhGNVrSb
X-Proofpoint-ORIG-GUID: G4ITLETFjZNAsh3wGqw2aW6JLhGNVrSb
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some small s390 updates for 5.16-rc4.

Thanks,
Heiko

The following changes since commit 136057256686de39cc3a07c2e39ef6bc43003ff6:

  Linux 5.16-rc2 (2021-11-21 13:47:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.16-4

for you to fetch changes up to 3c088b1e82cfb7c889823d39846d32079f190f3f:

  s390: update defconfigs (2021-12-02 19:29:44 +0100)

----------------------------------------------------------------
s390 updates for 5.16-rc4

- Fix potential overlap of pseudo-MMIO addresses with MIO addresses.

- Fix stack unwinder test case inline assembly compile error that
  happens with LLVM's integrated assembler.

- Update defconfigs.

----------------------------------------------------------------
Heiko Carstens (1):
      s390: update defconfigs

Ilie Halip (1):
      s390/test_unwind: use raw opcode instead of invalid instruction

Niklas Schnelle (1):
      s390/pci: move pseudo-MMIO to prevent MIO overlap

 arch/s390/configs/debug_defconfig    | 10 ++++++++--
 arch/s390/configs/defconfig          |  7 ++++++-
 arch/s390/configs/zfcpdump_defconfig |  2 ++
 arch/s390/include/asm/pci_io.h       |  7 ++++---
 arch/s390/lib/test_unwind.c          |  5 +++--
 5 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index fd825097cf04..b626bc6e0eaf 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -403,7 +403,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=y
 CONFIG_ZRAM=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
@@ -476,6 +475,7 @@ CONFIG_MACVLAN=m
 CONFIG_MACVTAP=m
 CONFIG_VXLAN=m
 CONFIG_BAREUDP=m
+CONFIG_AMT=m
 CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
@@ -489,6 +489,7 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_AMD is not set
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ASIX is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_BROCADE is not set
@@ -571,6 +572,7 @@ CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_SOFT_WATCHDOG=m
 CONFIG_DIAG288_WATCHDOG=m
+# CONFIG_DRM_DEBUG_MODESET_LOCK is not set
 CONFIG_FB=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
@@ -775,12 +777,14 @@ CONFIG_CRC4=m
 CONFIG_CRC7=m
 CONFIG_CRC8=m
 CONFIG_RANDOM32_SELFTEST=y
+CONFIG_XZ_DEC_MICROLZMA=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DEBUG_INFO_BTF=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_HEADERS_INSTALL=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
@@ -807,6 +811,7 @@ CONFIG_DEBUG_MEMORY_INIT=y
 CONFIG_MEMORY_NOTIFIER_ERROR_INJECT=m
 CONFIG_DEBUG_PER_CPU_MAPS=y
 CONFIG_KFENCE=y
+CONFIG_KFENCE_STATIC_KEYS=y
 CONFIG_DEBUG_SHIRQ=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_DETECT_HUNG_TASK=y
@@ -842,6 +847,7 @@ CONFIG_FTRACE_STARTUP_TEST=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_TRACE_PRINTK=m
 CONFIG_SAMPLE_FTRACE_DIRECT=m
+CONFIG_SAMPLE_FTRACE_DIRECT_MULTI=m
 CONFIG_DEBUG_ENTRY=y
 CONFIG_CIO_INJECT=y
 CONFIG_KUNIT=m
@@ -860,7 +866,7 @@ CONFIG_FAIL_FUNCTION=y
 CONFIG_FAULT_INJECTION_STACKTRACE_FILTER=y
 CONFIG_LKDTM=m
 CONFIG_TEST_MIN_HEAP=y
-CONFIG_KPROBES_SANITY_TEST=y
+CONFIG_KPROBES_SANITY_TEST=m
 CONFIG_RBTREE_TEST=y
 CONFIG_INTERVAL_TREE_TEST=m
 CONFIG_PERCPU_TEST=m
diff --git a/arch/s390/configs/defconfig b/arch/s390/configs/defconfig
index c9c3cedff2d8..0056cab27372 100644
--- a/arch/s390/configs/defconfig
+++ b/arch/s390/configs/defconfig
@@ -394,7 +394,6 @@ CONFIG_DEVTMPFS=y
 CONFIG_CONNECTOR=y
 CONFIG_ZRAM=y
 CONFIG_BLK_DEV_LOOP=m
-CONFIG_BLK_DEV_CRYPTOLOOP=m
 CONFIG_BLK_DEV_DRBD=m
 CONFIG_BLK_DEV_NBD=m
 CONFIG_BLK_DEV_RAM=y
@@ -467,6 +466,7 @@ CONFIG_MACVLAN=m
 CONFIG_MACVTAP=m
 CONFIG_VXLAN=m
 CONFIG_BAREUDP=m
+CONFIG_AMT=m
 CONFIG_TUN=m
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=m
@@ -480,6 +480,7 @@ CONFIG_NLMON=m
 # CONFIG_NET_VENDOR_AMD is not set
 # CONFIG_NET_VENDOR_AQUANTIA is not set
 # CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_VENDOR_ASIX is not set
 # CONFIG_NET_VENDOR_ATHEROS is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_BROCADE is not set
@@ -762,12 +763,14 @@ CONFIG_PRIME_NUMBERS=m
 CONFIG_CRC4=m
 CONFIG_CRC7=m
 CONFIG_CRC8=m
+CONFIG_XZ_DEC_MICROLZMA=y
 CONFIG_DMA_CMA=y
 CONFIG_CMA_SIZE_MBYTES=0
 CONFIG_PRINTK_TIME=y
 CONFIG_DYNAMIC_DEBUG=y
 CONFIG_DEBUG_INFO=y
 CONFIG_DEBUG_INFO_DWARF4=y
+CONFIG_DEBUG_INFO_BTF=y
 CONFIG_GDB_SCRIPTS=y
 CONFIG_DEBUG_SECTION_MISMATCH=y
 CONFIG_MAGIC_SYSRQ=y
@@ -792,9 +795,11 @@ CONFIG_HIST_TRIGGERS=y
 CONFIG_SAMPLES=y
 CONFIG_SAMPLE_TRACE_PRINTK=m
 CONFIG_SAMPLE_FTRACE_DIRECT=m
+CONFIG_SAMPLE_FTRACE_DIRECT_MULTI=m
 CONFIG_KUNIT=m
 CONFIG_KUNIT_DEBUGFS=y
 CONFIG_LKDTM=m
+CONFIG_KPROBES_SANITY_TEST=m
 CONFIG_PERCPU_TEST=m
 CONFIG_ATOMIC64_SELFTEST=y
 CONFIG_TEST_BPF=m
diff --git a/arch/s390/configs/zfcpdump_defconfig b/arch/s390/configs/zfcpdump_defconfig
index aceccf3b9a88..eed3b9acfa71 100644
--- a/arch/s390/configs/zfcpdump_defconfig
+++ b/arch/s390/configs/zfcpdump_defconfig
@@ -65,9 +65,11 @@ CONFIG_ZFCP=y
 # CONFIG_NETWORK_FILESYSTEMS is not set
 CONFIG_LSM="yama,loadpin,safesetid,integrity"
 # CONFIG_ZLIB_DFLTCC is not set
+CONFIG_XZ_DEC_MICROLZMA=y
 CONFIG_PRINTK_TIME=y
 # CONFIG_SYMBOLIC_ERRNAME is not set
 CONFIG_DEBUG_INFO=y
+CONFIG_DEBUG_INFO_BTF=y
 CONFIG_DEBUG_FS=y
 CONFIG_DEBUG_KERNEL=y
 CONFIG_PANIC_ON_OOPS=y
diff --git a/arch/s390/include/asm/pci_io.h b/arch/s390/include/asm/pci_io.h
index e4dc64cc9c55..287bb88f7698 100644
--- a/arch/s390/include/asm/pci_io.h
+++ b/arch/s390/include/asm/pci_io.h
@@ -14,12 +14,13 @@
 
 /* I/O Map */
 #define ZPCI_IOMAP_SHIFT		48
-#define ZPCI_IOMAP_ADDR_BASE		0x8000000000000000UL
+#define ZPCI_IOMAP_ADDR_SHIFT		62
+#define ZPCI_IOMAP_ADDR_BASE		(1UL << ZPCI_IOMAP_ADDR_SHIFT)
 #define ZPCI_IOMAP_ADDR_OFF_MASK	((1UL << ZPCI_IOMAP_SHIFT) - 1)
 #define ZPCI_IOMAP_MAX_ENTRIES							\
-	((ULONG_MAX - ZPCI_IOMAP_ADDR_BASE + 1) / (1UL << ZPCI_IOMAP_SHIFT))
+	(1UL << (ZPCI_IOMAP_ADDR_SHIFT - ZPCI_IOMAP_SHIFT))
 #define ZPCI_IOMAP_ADDR_IDX_MASK						\
-	(~ZPCI_IOMAP_ADDR_OFF_MASK - ZPCI_IOMAP_ADDR_BASE)
+	((ZPCI_IOMAP_ADDR_BASE - 1) & ~ZPCI_IOMAP_ADDR_OFF_MASK)
 
 struct zpci_iomap_entry {
 	u32 fh;
diff --git a/arch/s390/lib/test_unwind.c b/arch/s390/lib/test_unwind.c
index cfc5f5557c06..bc7973359ae2 100644
--- a/arch/s390/lib/test_unwind.c
+++ b/arch/s390/lib/test_unwind.c
@@ -173,10 +173,11 @@ static noinline int unwindme_func4(struct unwindme *u)
 		}
 
 		/*
-		 * trigger specification exception
+		 * Trigger operation exception; use insn notation to bypass
+		 * llvm's integrated assembler sanity checks.
 		 */
 		asm volatile(
-			"	mvcl	%%r1,%%r1\n"
+			"	.insn	e,0x0000\n"	/* illegal opcode */
 			"0:	nopr	%%r7\n"
 			EX_TABLE(0b, 0b)
 			:);
