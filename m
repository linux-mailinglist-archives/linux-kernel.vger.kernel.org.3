Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442E64E78B3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358116AbiCYQLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbiCYQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:11:52 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DC8A5EAA;
        Fri, 25 Mar 2022 09:10:18 -0700 (PDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22PG7dWc032129;
        Fri, 25 Mar 2022 16:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=pp1; bh=8rrpCPo+fbyuo3L5SEhjysmR/OlR5h1aa1LODjwnA7c=;
 b=A4dz3vleTlTcETEWoG+KLbromNSwF2pSCtKNnY2iVtUipP+t9GLtzfx0L6MUHlKxNMIw
 ybgen3G29Myg39v8DfDqI2lp2CqugdldEQUgtsNAttPJbK2w8pERUPCC0YB2NXlwuAl0
 /d3ppbKA1XtsO2CzsU3QnH30RlJXhOJ+vQE8+AAZ6T78s3vHHAAlaE3suglBd3KzDqPX
 i247sR1+hPLFypE+qNq60w/92kQYgTbcUhhUYtbSRAwANSMWOfXIbEp1BpmYhN086RkL
 B3Yq+uwslguH2+tzyeuSXpxW369pxANrepmaaS+GTHF7NZsPWgjIQ4GkRfkZ+7BYOra4 uQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3f0p8nts9y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 16:10:16 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 22PG7cdD004498;
        Fri, 25 Mar 2022 16:10:13 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3ew6ej5pea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 16:10:13 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 22PGAEDZ46334278
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 16:10:14 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0D0FB42049;
        Fri, 25 Mar 2022 16:10:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5ECE42042;
        Fri, 25 Mar 2022 16:10:09 +0000 (GMT)
Received: from localhost (unknown [9.171.14.216])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 25 Mar 2022 16:10:09 +0000 (GMT)
Date:   Fri, 25 Mar 2022 17:10:08 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 5.18 merge window
Message-ID: <your-ad-here.call-01648224608-ext-2557@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xAIk4I9URcdT3OK4-m96D-y6r0s1pAGN
X-Proofpoint-GUID: xAIk4I9URcdT3OK4-m96D-y6r0s1pAGN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_05,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250088
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.18. There is a merge conflict with kvm
tree you've pulled already. A change had to be included in both trees
as prerequisite for other changes. Your tree:

1a82f6ab2365 ("s390/uaccess: Add copy_from/to_user_key functions")

will get conflicts in arch/s390/lib/uaccess.c with the changes from
s390 tree:

432b1cc78e98 ("s390/uaccess: Add copy_from/to_user_key functions")
4efd417f298b ("s390: raise minimum supported machine generation to z10")
731efc9613ee ("s390: convert ".insn" encoding to instruction names")

please simply take the version from s390 tree (removing bunch of code from
arch/s390/lib/uaccess.c file).

I also had to pull our fixes in, to resolve dependencies and avoid merge
conflict, hence there are couple of s390 MAINTAINERS changes in the log,
you've already pulled with our fixes for 5.17-rc4.

Thank you,
Vasily

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-1

for you to fetch changes up to c65f677b62d6180cc174e06f953f7fe860adf6d1:

  s390/test_unwind: add kretprobe tests (2022-03-10 15:58:17 +0100)

----------------------------------------------------------------
s390 updates for the 5.18 merge window

- Raise minimum supported machine generation to z10, which comes with
  various cleanups and code simplifications (usercopy/spectre
  mitigation/etc).

- Rework extables and get rid of anonymous out-of-line fixups.

- Page table helpers cleanup. Add set_pXd()/set_pte() helper
  functions. Covert pte_val()/pXd_val() macros to functions.

- Optimize kretprobe handling by avoiding extra kprobe on
  __kretprobe_trampoline.

- Add support for CEX8 crypto cards.

- Allow to trigger AP bus rescan via writing to /sys/bus/ap/scans.

- Add CONFIG_EXPOLINE_EXTERN option to build the kernel without COMDAT
  group sections which simplifies kpatch support.

- Always use the packed stack layout and extend kernel unwinder tests.

- Add sanity checks for ftrace code patching.

- Add s390dbf debug log for the vfio_ap device driver.

- Various virtual vs physical address confusion fixes.

- Various small fixes and improvements all over the code.

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/setup: preserve memory at OLDMEM_BASE and OLDMEM_SIZE

Alexander Gordeev (6):
      s390/maccess: fix absolute lowcore virtual vs physical address confusion
      s390/sclp_sdias: fix sclp_sdias_copy() virtual vs physical address confusion
      s390/dump: fix os_info virtual vs physical address confusion
      s390/dump: fix old lowcore virtual vs physical address confusion
      s390/maccess: fix semantics of memcpy_real() and its callers
      s390/smp: sort out physical vs virtual pointers usage

Christian Borntraeger (1):
      MAINTAINERS: downgrade myself to Reviewer for s390

Halil Pasic (1):
      s390/airq: use DMA memory for summary indicators

Harald Freudenberger (6):
      s390/ap: enable sysfs attribute scans to force AP bus rescan
      s390/ap/zcrypt: debug feature improvements
      s390/zcrypt: CEX8S exploitation support
      s390/zcrypt: handle checkstopped cards with new state
      s390/zcrypt: Support CPRB minor version T7
      s390/zcrypt: change reply buffer size offering

Heiko Carstens (32):
      MAINTAINERS: add Alexander Gordeev as maintainer for s390
      s390: remove invalid email address of Heiko Carstens
      s390/lgr: use simple assignment instead of memcpy
      s390/mm: use CRST_ALLOC_ORDER instead of number
      s390/ftrace: fix ftrace_caller/ftrace_regs_caller generation
      s390/ftrace: fix arch_ftrace_get_regs implementation
      s390/extable: fix exception table sorting
      s390/ptrace: remove opencoded offsetof
      s390/ftrace: make use of epsw to get psw mask
      s390/mm: add set_pXd()/set_pte() helper functions
      s390/mm: add set_pte_bit()/clear_pte_bit() helper functions
      s390/mm: use set_pXd()/set_pte() helper functions everywhere
      s390/mm,pgtable: don't use pte_val()/pXd_val() as lvalue
      s390/mm,pageattr: don't use pte_val()/pXd_val() as lvalue
      s390/mm,hugetlb: don't use pte_val()/pXd_val() as lvalue
      s390/mm,gmap: don't use pte_val()/pXd_val() as lvalue
      s390/mm: convert pte_val()/pXd_val() into functions
      s390/extable: sort amode31 extable early
      s390/extable: search amode31 extable last
      s390/extable: move EX_TABLE define to asm-extable.h
      s390/extable: move extable related functions to mm/extable.c
      s390/base: pass pt_regs to early program check handler
      s390/extable: add and use fixup_exception helper function
      s390/extable: convert to relative table with data
      s390/extable: add dedicated uaccess handler
      s390/bpf: encode register within extable entry
      s390: remove .fixup section
      s390/asm-offsets: remove unused defines
      s390/signal: fix typo in comments
      s390/traps: get rid of magic cast for program interruption code
      s390/traps: get rid of magic cast for per code
      s390/irq: use assignment instead of cast

Ilya Leoshkevich (1):
      s390/module: fix building test_modules_helpers.o with clang

Janis Schoetterl-Glausch (1):
      s390/uaccess: Add copy_from/to_user_key functions

Jürgen Christ (1):
      s390/zcrypt: Provide target domain for EP11 cprbs to scheduling function

Niklas Schnelle (1):
      s390/pci: make zpci_set_irq()/zpci_clear_irq() static

Sven Schnelle (1):
      s390/ftrace: verify opcode before applying patch

Tobias Huschle (2):
      s390/kprobes: Avoid additional kprobe in kretprobe handling
      s390/test_unwind: add kretprobe tests

Tony Krowiak (6):
      s390-vfio-ap: introduces s390 kernel debug feature for vfio_ap device driver
      MAINTAINERS: update file path for S390 VFIO AP DRIVER
      s390/vfio-ap: add s390dbf logging to the handle_pqap function
      s390/vfio-ap: add s390dbf logging to the vfio_ap_irq_enable function
      s390/ap: driver callback to indicate resource in use
      s390/ap: notify drivers on config changed and scan complete callbacks

Vasily Gorbik (17):
      Merge branch 'fixes' into features
      s390: always use the packed stack layout
      s390/test_unwind: show tests as skipped if unsupported
      s390/test_unwind: minor cleanup
      s390/test_unwind: add "backtrace" module parameter
      s390/test_unwind: add ftrace test
      s390/test_unwind: fix and extend kprobes test
      s390/entry: remove unused expoline thunk
      s390/test_unwind: avoid build warning with W=1
      s390: remove unused expoline to BC instructions
      s390/nospec: generate single register thunks if possible
      s390/nospec: add an option to use thunk-extern
      s390/nospec: align and size extern thunks
      s390: raise minimum supported machine generation to z10
      s390/nospec: move to single register thunks
      s390: assume stckf is always present
      s390: convert ".insn" encoding to instruction names

Vineeth Vijayan (1):
      s390/cio: verify the driver availability for path_event call

 MAINTAINERS                            |   8 +-
 arch/s390/Kconfig                      |  97 ++--------
 arch/s390/Makefile                     |  29 ++-
 arch/s390/boot/head.S                  |   1 -
 arch/s390/crypto/chacha-s390.S         |  20 +-
 arch/s390/hypfs/hypfs_vm.c             |   1 +
 arch/s390/include/asm/ap.h             |   1 +
 arch/s390/include/asm/asm-extable.h    |  53 ++++++
 arch/s390/include/asm/bitops.h         |  12 --
 arch/s390/include/asm/cpu_mf.h         |  13 +-
 arch/s390/include/asm/crw.h            |   1 -
 arch/s390/include/asm/diag.h           |   1 +
 arch/s390/include/asm/extable.h        |  46 +++--
 arch/s390/include/asm/fpu/api.h        |   1 +
 arch/s390/include/asm/ftrace.h         |  10 +-
 arch/s390/include/asm/futex.h          |   1 +
 arch/s390/include/asm/hugetlb.h        |   4 +-
 arch/s390/include/asm/irq.h            |   9 +-
 arch/s390/include/asm/kprobes.h        |   1 +
 arch/s390/include/asm/linkage.h        |  18 --
 arch/s390/include/asm/lowcore.h        |  26 ++-
 arch/s390/include/asm/mmu.h            |   1 +
 arch/s390/include/asm/nmi.h            |   1 -
 arch/s390/include/asm/nospec-insn.h    | 141 ++++----------
 arch/s390/include/asm/os_info.h        |   2 +-
 arch/s390/include/asm/page.h           |  30 ++-
 arch/s390/include/asm/pci.h            |   3 -
 arch/s390/include/asm/pgalloc.h        |   8 +-
 arch/s390/include/asm/pgtable.h        | 233 +++++++++++++----------
 arch/s390/include/asm/processor.h      |   7 +-
 arch/s390/include/asm/ptrace.h         |   2 +
 arch/s390/include/asm/sclp.h           |   1 -
 arch/s390/include/asm/smp.h            |   1 -
 arch/s390/include/asm/stacktrace.h     |  10 +-
 arch/s390/include/asm/timex.h          |   6 +-
 arch/s390/include/asm/tlbflush.h       |   4 +-
 arch/s390/include/asm/uaccess.h        |  67 +++----
 arch/s390/include/uapi/asm/zcrypt.h    |   2 +-
 arch/s390/kernel/Makefile              |   4 +-
 arch/s390/kernel/asm-offsets.c         |   8 +-
 arch/s390/kernel/base.S                |  25 ++-
 arch/s390/kernel/cache.c               |   7 -
 arch/s390/kernel/compat_signal.c       |   2 +-
 arch/s390/kernel/crash_dump.c          |  58 +++---
 arch/s390/kernel/diag.c                |   1 +
 arch/s390/kernel/early.c               |  24 +--
 arch/s390/kernel/entry.S               |  18 +-
 arch/s390/kernel/entry.h               |   1 +
 arch/s390/kernel/ftrace.c              | 102 ++++++----
 arch/s390/kernel/ftrace.h              |   2 -
 arch/s390/kernel/head64.S              |   1 -
 arch/s390/kernel/ipl.c                 |   2 +-
 arch/s390/kernel/irq.c                 |   2 +-
 arch/s390/kernel/kprobes.c             |  43 ++---
 arch/s390/kernel/lgr.c                 |   3 +-
 arch/s390/kernel/machine_kexec.c       |   1 -
 arch/s390/kernel/mcount.S              |  69 +++++--
 arch/s390/kernel/module.c              |  12 +-
 arch/s390/kernel/nmi.c                 |   1 -
 arch/s390/kernel/nospec-branch.c       |  31 +---
 arch/s390/kernel/os_info.c             |  12 +-
 arch/s390/kernel/perf_cpum_cf.c        |  11 +-
 arch/s390/kernel/processor.c           |  22 +--
 arch/s390/kernel/ptrace.c              | 164 ++++++++---------
 arch/s390/kernel/relocate_kernel.S     |   3 +-
 arch/s390/kernel/setup.c               |   3 +-
 arch/s390/kernel/signal.c              |   2 +-
 arch/s390/kernel/smp.c                 |  10 +-
 arch/s390/kernel/stacktrace.c          |   1 -
 arch/s390/kernel/sysinfo.c             |   1 +
 arch/s390/kernel/text_amode31.S        |   1 +
 arch/s390/kernel/topology.c            |   1 -
 arch/s390/kernel/traps.c               |  16 +-
 arch/s390/kernel/uprobes.c             |  16 +-
 arch/s390/kernel/vmlinux.lds.S         |   1 -
 arch/s390/kernel/vtime.c               |  13 +-
 arch/s390/kvm/kvm-s390.c               |   1 -
 arch/s390/lib/Makefile                 |   1 +
 arch/s390/lib/delay.c                  |   1 -
 arch/s390/lib/expoline.S               |  12 ++
 arch/s390/lib/test_modules.c           |   3 -
 arch/s390/lib/test_modules.h           |   3 +
 arch/s390/lib/test_unwind.c            | 274 +++++++++++++++++++--------
 arch/s390/lib/uaccess.c                | 200 +++++---------------
 arch/s390/mm/Makefile                  |   2 +-
 arch/s390/mm/extable.c                 |  50 +++++
 arch/s390/mm/fault.c                   |  20 +-
 arch/s390/mm/gmap.c                    |  22 +--
 arch/s390/mm/hugetlbpage.c             |  36 ++--
 arch/s390/mm/kasan_init.c              |   8 +-
 arch/s390/mm/maccess.c                 |  24 +--
 arch/s390/mm/page-states.c             |   1 +
 arch/s390/mm/pageattr.c                |  33 ++--
 arch/s390/mm/pgalloc.c                 |   8 +-
 arch/s390/mm/pgtable.c                 |  44 ++---
 arch/s390/mm/vmem.c                    |  19 +-
 arch/s390/net/bpf_jit_comp.c           |  54 ++----
 arch/s390/pci/pci_clp.c                |   1 +
 arch/s390/pci/pci_insn.c               |   1 +
 arch/s390/pci/pci_irq.c                |   4 +-
 arch/s390/pci/pci_mmio.c               |   1 +
 arch/s390/tools/gcc-thunk-extern.sh    |  24 +++
 arch/s390/tools/gen_facilities.c       |   8 -
 drivers/s390/block/dasd_diag.c         |   2 +-
 drivers/s390/char/diag_ftp.c           |   1 +
 drivers/s390/char/sclp.h               |   1 +
 drivers/s390/char/sclp_cmd.c           |   3 +-
 drivers/s390/char/sclp_config.c        |   1 -
 drivers/s390/char/sclp_sdias.c         |   2 +-
 drivers/s390/char/zcore.c              |   3 +-
 drivers/s390/cio/airq.c                |   4 +-
 drivers/s390/cio/crw.c                 |   1 -
 drivers/s390/cio/device.c              |   2 +-
 drivers/s390/cio/ioasm.c               |   1 +
 drivers/s390/crypto/ap_bus.c           | 328 +++++++++++++++++++++++++++++----
 drivers/s390/crypto/ap_bus.h           |  24 ++-
 drivers/s390/crypto/ap_card.c          |  11 ++
 drivers/s390/crypto/ap_queue.c         |  19 +-
 drivers/s390/crypto/vfio_ap_debug.h    |  32 ++++
 drivers/s390/crypto/vfio_ap_drv.c      |  23 +++
 drivers/s390/crypto/vfio_ap_ops.c      | 151 +++++++++++++--
 drivers/s390/crypto/zcrypt_api.c       |  53 ++++--
 drivers/s390/crypto/zcrypt_cex4.c      |  71 +++++--
 drivers/s390/crypto/zcrypt_msgtype50.c |  12 +-
 drivers/s390/crypto/zcrypt_msgtype50.h |   4 +-
 drivers/s390/crypto/zcrypt_msgtype6.c  | 119 ++++++++++--
 drivers/s390/crypto/zcrypt_msgtype6.h  |  13 +-
 scripts/mod/modpost.c                  |   5 +
 scripts/sorttable.c                    |  43 +----
 tools/perf/arch/s390/util/dwarf-regs.c |   3 +-
 130 files changed, 1940 insertions(+), 1413 deletions(-)
 create mode 100644 arch/s390/include/asm/asm-extable.h
 create mode 100644 arch/s390/lib/expoline.S
 create mode 100644 arch/s390/mm/extable.c
 create mode 100755 arch/s390/tools/gcc-thunk-extern.sh
 create mode 100644 drivers/s390/crypto/vfio_ap_debug.h
