Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A78A9530F2E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbiEWMcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 08:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbiEWMcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 08:32:16 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E29340F5;
        Mon, 23 May 2022 05:32:15 -0700 (PDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24NB0Y9j006560;
        Mon, 23 May 2022 12:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=QLxGwyhDTk7XoTo7BgtigfqnQX0lyzx69SyufptLLQs=;
 b=kbn2L7fpJ/hZBjTzCQU7q2wINhtSlum4HhoLLXlVxOvimFIOnjrVK88d+d0KpDtybe81
 dVTVB+5HK9CSFmoKrph2T3WcNDlR0KlQlX3yTQq2WAv7E4vFIGM8liIuZICp0bH+ZUiC
 46cGZH1BI4PS10BNxX6t4oyuJX3qZ3YPnYWoYoRrT9hk5yusJ/xhjNgbPy80m3VPxvJ7
 bUceFlo+qHuzxZtHemMznjJVu4MgA6k+Q6reiX39JKnHdjjPnYu8OOd4coAV3BcT7DEM
 rPDKNo+0JBBQ+mxFJqakssv5TBxcglhL9izMhw5LTWlMKADBp7QHbNK0modBxrpKkguM iQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3g87vvurp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 12:32:13 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 24NBbLt2003472;
        Mon, 23 May 2022 12:32:12 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3g6qq8tb2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 May 2022 12:32:11 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 24NCI4OV50004342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 May 2022 12:18:05 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B0389A404D;
        Mon, 23 May 2022 12:32:08 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65527A4040;
        Mon, 23 May 2022 12:32:08 +0000 (GMT)
Received: from osiris (unknown [9.145.75.188])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 23 May 2022 12:32:08 +0000 (GMT)
Date:   Mon, 23 May 2022 14:32:07 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.19 merge window
Message-ID: <Yot+xzLZETNTxNo+@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9i3Hc0IpuPiZ5F9_y744cQ8FAmi-WkvA
X-Proofpoint-ORIG-GUID: 9i3Hc0IpuPiZ5F9_y744cQ8FAmi-WkvA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-23_04,2022-05-23_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=502 phishscore=0 adultscore=0 spamscore=0 mlxscore=0
 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205230067
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull s390 updates for the 5.19 merge window. Note that this
contains one small patch which touches generic entry code, and the
corresponding pieces within x86. This has been Acked by Thomas Gleixner
and Peter Zijlstra.

Thanks,
Heiko

The following changes since commit af2d861d4cd2a4da5137f795ee3509e6f944a25b:

  Linux 5.18-rc4 (2022-04-24 14:51:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-1

for you to fetch changes up to 94d3477897481b92874654455e263e0b1728acb5:

  s390/head: get rid of 31 bit leftovers (2022-05-18 13:31:07 +0200)

----------------------------------------------------------------
s390 updates for 5.19 merge window

- Make use of the IBM z16 processor activity instrumentation facility
  to count cryptography operations: add a new PMU device driver so
  that perf can make use of this.

- Add new IBM z16 extended counter set to cpumf support.

- Add vdso randomization support.

- Add missing KCSAN instrumentation to barriers and spinlocks, which
  should make s390's KCSAN support complete.

- Add support for IPL-complete-control facility: notify the hypervisor
  that kexec finished work and the kernel starts.

- Improve error logging for PCI.

- Various small changes to workaround llvm's integrated assembler
  limitations, and one bug, to make it finally possible to compile the
  kernel with llvm's integrated assembler. This also requires to raise
  the minimum clang version to 14.0.0.

- Various other small enhancements, bug fixes, and cleanups all over
  the place.

----------------------------------------------------------------
Alexander Egorenkov (2):
      s390/sclp: add detection of IPL-complete-control facility
      s390/kexec: set end-of-ipl flag in last diag308 call

Alexander Gordeev (1):
      s390/smp: sort out physical vs virtual CPU0 lowcore pointer

Guilherme G. Piccoli (1):
      s390/consoles: improve panic notifiers reliability

Haowen Bai (1):
      s390/cio: simplify the calculation of variables

Harald Freudenberger (4):
      s390/zcrypt: add display of ASYM master key verification pattern
      s390/ap: uevent on apmask/aqpmask change
      s390/zcrypt: cleanup CPRB struct definitions
      s390/zcrypt: code cleanup

Heiko Carstens (21):
      s390/nospec: prefer local labels in .set directives
      s390/extable: prefer local labels in .set directives
      s390/vx: remove comments from macros which break LLVM's IAS
      s390/boot: get rid of startup archive
      s390/head: adjust iplstart entry point
      s390/boot: change initial program check handler to disabled wait psw
      s390/head: initialize all new psws
      s390/ptrace: move short psw definitions to ptrace header file
      s390/boot: convert initial lowcore to C
      s390/boot: convert parmarea to C
      s390/entry: remove broken and not needed code
      s390/compat: cleanup compat_linux.h header file
      s390/preempt: disable __preempt_count_add() optimization for PROFILE_ALL_BRANCHES
      s390/alternatives: provide identical sized orginal/alternative sequences
      s390/alternatives: remove padding generation code
      s390/entry: workaround llvm's IAS limitations
      s390/purgatory: workaround llvm's IAS limitations
      s390/boot: workaround llvm IAS bug
      s390/boot: do not emit debug info for assembly with llvm's IAS
      scripts/min-tool-version.sh: raise minimum clang version to 14.0.0 for s390
      s390/head: get rid of 31 bit leftovers

Ilya Leoshkevich (1):
      s390: add KCSAN instrumentation to barriers and spinlocks

Julia Lawall (2):
      s390/crypto: fix typos in comments
      s390/hypfs: fix typos in comments

Niklas Schnelle (4):
      s390/pci: make better use of zpci_dbg() levels
      s390/pci: don't log availability events as errors
      s390/pci: add PCI access type and length to error records
      s390/pci: add error record for CC 2 retries

Pingfan Liu (1):
      s390/irq: utilize RCU instead of irq_lock_sparse() in show_msi_interrupt()

Sven Schnelle (7):
      s390/mmap: increase stack/mmap gap to 128MB
      s390/vdso: move vdso mapping to its own function
      s390/vdso: map vdso above stack
      s390/vdso: add vdso randomization
      entry: Rename arch_check_user_regs() to arch_enter_from_user_mode()
      s390/stp: fix todoff size
      s390/stp: clock_delta should be signed

Thomas Huth (1):
      s390/vfio-ap: remove superfluous MODULE_DEVICE_TABLE declaration

Thomas Richter (2):
      s390/pai: add support for cryptography counters
      s390/cpumf: add new extended counter set for IBM z16

 arch/s390/Makefile                             |   2 +
 arch/s390/boot/.gitignore                      |   3 +
 arch/s390/boot/Makefile                        |  78 ++-
 arch/s390/boot/boot.h                          |   6 +-
 arch/s390/boot/{compressed => }/clz_ctz.c      |   0
 arch/s390/boot/compressed/.gitignore           |   4 -
 arch/s390/boot/compressed/Makefile             |  86 ----
 arch/s390/boot/{compressed => }/decompressor.c |   0
 arch/s390/boot/{compressed => }/decompressor.h |   0
 arch/s390/boot/head.S                          | 366 ++++++-------
 arch/s390/boot/ipl_data.c                      |  84 +++
 arch/s390/boot/ipl_parm.c                      |   7 +
 arch/s390/boot/kaslr.c                         |   2 +-
 arch/s390/boot/mem_detect.c                    |   2 +-
 arch/s390/boot/startup.c                       |   2 +-
 arch/s390/boot/{compressed => }/vmlinux.lds.S  |   9 +
 arch/s390/crypto/des_s390.c                    |   2 +-
 arch/s390/crypto/prng.c                        |   2 +-
 arch/s390/hypfs/hypfs_vm.c                     |   2 +-
 arch/s390/include/asm/alternative-asm.h        |  76 +--
 arch/s390/include/asm/alternative.h            |  93 +---
 arch/s390/include/asm/asm-extable.h            |  12 +-
 arch/s390/include/asm/barrier.h                |  16 +-
 arch/s390/include/asm/cio.h                    |   2 +-
 arch/s390/include/asm/compat.h                 |  25 +-
 arch/s390/include/asm/ctl_reg.h                |   4 +-
 arch/s390/include/asm/entry-common.h           |  14 +-
 arch/s390/include/asm/ipl.h                    |   6 +
 arch/s390/include/asm/lowcore.h                |   5 +-
 arch/s390/include/asm/nmi.h                    |   2 +-
 arch/s390/include/asm/nospec-insn.h            |  12 +-
 arch/s390/include/asm/pai.h                    |  74 +++
 arch/s390/include/asm/pci_debug.h              |   7 +-
 arch/s390/include/asm/preempt.h                |  15 +-
 arch/s390/include/asm/processor.h              |   8 +-
 arch/s390/include/asm/ptrace.h                 |  29 ++
 arch/s390/include/asm/sclp.h                   |   1 +
 arch/s390/include/asm/scsw.h                   |  83 ++-
 arch/s390/include/asm/spinlock.h               |   3 +-
 arch/s390/include/asm/stp.h                    |   4 +-
 arch/s390/include/asm/vx-insn.h                |   6 +-
 arch/s390/include/uapi/asm/pkey.h              |   2 +-
 arch/s390/include/uapi/asm/zcrypt.h            |  42 +-
 arch/s390/kernel/Makefile                      |   1 +
 arch/s390/kernel/alternative.c                 |  61 +--
 arch/s390/kernel/compat_linux.h                |  89 ++--
 arch/s390/kernel/entry.S                       |  40 +-
 arch/s390/kernel/irq.c                         |   4 +-
 arch/s390/kernel/machine_kexec.c               |  10 +-
 arch/s390/kernel/nmi.c                         |   6 +-
 arch/s390/kernel/perf_cpum_cf_events.c         | 148 ++++++
 arch/s390/kernel/perf_pai_crypto.c             | 688 +++++++++++++++++++++++++
 arch/s390/kernel/relocate_kernel.S             |   3 +-
 arch/s390/kernel/setup.c                       |   2 +-
 arch/s390/kernel/time.c                        |  12 +-
 arch/s390/kernel/vdso.c                        |  55 +-
 arch/s390/kvm/priv.c                           |   1 -
 arch/s390/lib/spinlock.c                       |   4 +-
 arch/s390/mm/mmap.c                            |   4 +-
 arch/s390/pci/pci.c                            |   2 +-
 arch/s390/pci/pci_clp.c                        |   2 +-
 arch/s390/pci/pci_debug.c                      |   2 +-
 arch/s390/pci/pci_event.c                      |   3 -
 arch/s390/pci/pci_insn.c                       | 108 +++-
 arch/s390/purgatory/head.S                     |  30 +-
 arch/x86/include/asm/entry-common.h            |   4 +-
 drivers/s390/char/con3215.c                    |  25 +-
 drivers/s390/char/con3270.c                    |  31 +-
 drivers/s390/char/raw3270.c                    |  15 +
 drivers/s390/char/raw3270.h                    |   1 +
 drivers/s390/char/sclp_con.c                   |  26 +-
 drivers/s390/char/sclp_early.c                 |   4 +-
 drivers/s390/char/sclp_vt220.c                 |  42 +-
 drivers/s390/cio/chsc.c                        |   4 +-
 drivers/s390/crypto/ap_bus.c                   |  96 ++--
 drivers/s390/crypto/ap_bus.h                   |   1 +
 drivers/s390/crypto/ap_queue.c                 |   7 +-
 drivers/s390/crypto/pkey_api.c                 | 149 +++---
 drivers/s390/crypto/vfio_ap_drv.c              |   2 -
 drivers/s390/crypto/zcrypt_api.c               | 215 ++++----
 drivers/s390/crypto/zcrypt_api.h               |   4 +-
 drivers/s390/crypto/zcrypt_card.c              |   2 +-
 drivers/s390/crypto/zcrypt_cca_key.h           |  58 +--
 drivers/s390/crypto/zcrypt_ccamisc.c           | 272 +++++-----
 drivers/s390/crypto/zcrypt_ccamisc.h           |   6 +
 drivers/s390/crypto/zcrypt_cex2a.c             |  11 +-
 drivers/s390/crypto/zcrypt_cex2c.c             |  10 +-
 drivers/s390/crypto/zcrypt_cex4.c              |  44 +-
 drivers/s390/crypto/zcrypt_ep11misc.c          | 168 +++---
 drivers/s390/crypto/zcrypt_ep11misc.h          |   2 +-
 drivers/s390/crypto/zcrypt_error.h             |   3 +-
 drivers/s390/crypto/zcrypt_msgtype50.c         |  31 +-
 drivers/s390/crypto/zcrypt_msgtype6.c          | 340 ++++++------
 drivers/s390/crypto/zcrypt_msgtype6.h          |  26 +-
 drivers/s390/crypto/zcrypt_queue.c             |   2 +-
 include/linux/entry-common.h                   |   8 +-
 kernel/entry/common.c                          |   2 +-
 scripts/min-tool-version.sh                    |   3 +-
 98 files changed, 2553 insertions(+), 1534 deletions(-)
 rename arch/s390/boot/{compressed => }/clz_ctz.c (100%)
 delete mode 100644 arch/s390/boot/compressed/.gitignore
 delete mode 100644 arch/s390/boot/compressed/Makefile
 rename arch/s390/boot/{compressed => }/decompressor.c (100%)
 rename arch/s390/boot/{compressed => }/decompressor.h (100%)
 create mode 100644 arch/s390/boot/ipl_data.c
 rename arch/s390/boot/{compressed => }/vmlinux.lds.S (94%)
 create mode 100644 arch/s390/include/asm/pai.h
 create mode 100644 arch/s390/kernel/perf_pai_crypto.c
