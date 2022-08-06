Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6AB58B4B7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 11:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiHFJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiHFJIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 05:08:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227E715FDE;
        Sat,  6 Aug 2022 02:08:23 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2768jhnU026056;
        Sat, 6 Aug 2022 09:08:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=0o3euISHPiEteHjC1OMKd2mlhilLFyLNMqnIIHsUxHY=;
 b=dev41uGp+IsFp+MtRYa5akNEEucAft/ENiFkawRLXd1Jqt8d6CO+bBEU/gefM9SmGgUz
 9+j0o9ZAJ/Rmq9FoC7dwVpposTxA2KMcEbwGOkgcvimi2+BwAb147mD0AUKWsTMOiNcr
 4+kNhtFUmwz6cIMf4BJ2dpv/GSC/NoFum3x9HxoYye7c7s2EZzsZzc1iAzijK4Oo9vER
 5dZW7Dx8Xx6wO2aIXaVrQUXVnZsKx1050Gq91Akwjy7WBAMYbgtwb7FL/H9tlS2cVeRB
 S4yjG2s6sdue3hEC1o2E9lmOVUx8HW+FgkQN+Z3T1b+xFZ2NFebGWAz8Wg80j8rKeLyi 3g== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hsn2u0ac6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Aug 2022 09:08:21 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27690pcc031566;
        Sat, 6 Aug 2022 09:03:19 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3hsfjhr3s9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 06 Aug 2022 09:03:19 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27693VJj33816978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 6 Aug 2022 09:03:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F7E8A404D;
        Sat,  6 Aug 2022 09:03:15 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A0A4A4053;
        Sat,  6 Aug 2022 09:03:15 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  6 Aug 2022 09:03:15 +0000 (GMT)
Date:   Sat, 6 Aug 2022 11:03:14 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: [GIT PULL] s390 updates for 5.20 merge window
Message-ID: <Yu4uUqpvcXGfGpy8@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TCtJzbYRqor_0kgMnbnNPKHKiUqs9HFu
X-Proofpoint-ORIG-GUID: TCtJzbYRqor_0kgMnbnNPKHKiUqs9HFu
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-06_03,2022-08-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208060047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 updates for the 5.20 merge window.

Note a trivial conflict between commit:

  49b0109fb399 ("s390/vfio-ap: introduce shadow APCB")

and commit:

  ce4b4657ff18 ("vfio: Replace the DMA unmapping notifier with a callback")

from the vfio tree, which was resolved in linux-next and is
not yet in your tree.

The changes below were put into vmcore-iov_iter branch and pulled by
Al Viro into work.iov_iter branch of the vfs tree to avoid conflicts
with ITER_UBUF stuff:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.iov_iter

  ebbc95701691 s390/crash: support multi-segment iterators
  6d2e5a4a13da s390/crash: use static swap buffer for copy_to_user_real()
  d6da67378198 s390/crash: move copy_to_user_real() to crash_dump.c
  9ffed254d938 s390/zcore: fix race when reading from hardware system area
  f6749da17a34 s390/crash: fix incorrect number of bytes to copy to user space
  86caa4b67895 s390/crash: remove redundant panic() on save area allocation failure
  7190d84966b3 s390/mm: remove unused tprot() function
  af2debd58bd7 s390/crash: make copy_oldmem_page() return number of bytes copied
  cc02e6e21aa5 s390/crash: add missing iterator advance in copy_oldmem_page()

I also reverted last-minute these commits:

  e409b7f19172 s390/smp,ptdump: add absolute lowcore markers
  7d06fed77b7d s390/smp: rework absolute lowcore access
  6f5c672d17f5 s390/smp: enforce lowcore protection on CPU restart

Thank you,
Alexander

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.20-1

for you to fetch changes up to 953503751a426413ea8aee2299ae3ee971b70d9b:

  Revert "s390/smp: enforce lowcore protection on CPU restart" (2022-08-06 09:29:46 +0200)

----------------------------------------------------------------
s390 updates for 5.20 merge window

- Rework copy_oldmem_page() callback to take an iov_iter.
  This includes few prerequisite updates and fixes to the
  oldmem reading code. That is the series on vmcore-iov_iter
  branch shared with Al Viro.

- Rework cpufeature implementation to allow for various CPU feature
  indications, which is not only limited to hardware capabilities,
  but also allows CPU facilities.

- Use the cpufeature rework to autoload Ultravisor module when CPU
  facility 158 is available.

- Add ELF note type for encrypted CPU state of a protected virtual CPU.
  The zgetdump tool from s390-tools package will decrypt the CPU state
  using a Customer Communication Key and overwrite respective notes to
  make the data accessible for crash and other debugging tools.

- Use vzalloc() instead of vmalloc() + memset() in ChaCha20 crypto test.

- Fix incorrect recovery of kretprobe modified return address in stacktrace.

- Switch the NMI handler to use generic irqentry_nmi_enter() and
  irqentry_nmi_exit() helper functions.

- Rework the cryptographic Adjunct Processors (AP) pass-through design
  to support dynamic changes to the AP matrix of a running guest as well
  as to implement more of the AP architecture.

- Minor boot code cleanups.

- Grammar and typo fixes to hmcdrv and tape drivers.

----------------------------------------------------------------
Alexander Gordeev (19):
  s390/crash: add missing iterator advance in copy_oldmem_page()
  s390/crash: make copy_oldmem_page() return number of bytes copied
  s390/mm: remove unused tprot() function
  s390/crash: remove redundant panic() on save area allocation failure
  s390/crash: fix incorrect number of bytes to copy to user space
  s390/zcore: fix race when reading from hardware system area
  s390/crash: move copy_to_user_real() to crash_dump.c
  s390/crash: use static swap buffer for copy_to_user_real()
  s390/crash: support multi-segment iterators
  s390/docs: fix warnings for vfio_ap driver lock usage doc
  s390/docs: fix warnings for vfio_ap driver doc
  s390/smp: enforce lowcore protection on CPU restart
  s390/boot: cleanup adjust_to_uv_max() function
  s390/setup: rearrange absolute lowcore initialization
  s390/smp: rework absolute lowcore access
  s390/smp,ptdump: add absolute lowcore markers
  Revert "s390/smp,ptdump: add absolute lowcore markers"
  Revert "s390/smp: rework absolute lowcore access"
  Revert "s390/smp: enforce lowcore protection on CPU restart"

Heiko Carstens (2):
  s390/cpufeature: rework to allow more than only hwcap bits
  s390/cpufeature: allow for facility bits

Janosch Frank (1):
  s390: add ELF note type for encrypted CPU state of a PV VCPU

Jason Wang (1):
  s390/tape: fix comment typo

Randy Dunlap (1):
  s390/hmcdrv: fix Kconfig "its" grammar

Siddh Raman Pant (1):
  tools/testing/crypto: Use vzalloc instead of vmalloc+memset

Steffen Eiden (1):
  s390/uvdevice: autoload module based on CPU facility

Sumanth Korikkar (1):
  s390/unwind: fix fgraph return address recovery

Sven Schnelle (1):
  s390/nmi: use irqentry_nmi_enter()/irqentry_nmi_exit()

Tony Krowiak (20):
  s390/vfio-ap: use new AP bus interface to search for queue devices
  s390/vfio-ap: move probe and remove callbacks to vfio_ap_ops.c
  s390/vfio-ap: manage link between queue struct and matrix mdev
  s390/vfio-ap: introduce shadow APCB
  s390/vfio-ap: refresh guest's APCB by filtering AP resources assigned
    to mdev
  s390/vfio-ap: allow assignment of unavailable AP queues to mdev device
  s390/vfio-ap: rename matrix_dev->lock mutex to matrix_dev->mdevs_lock
  s390/vfio-ap: introduce new mutex to control access to the KVM pointer
  s390/vfio-ap: use proper locking order when setting/clearing KVM
    pointer
  s390/vfio-ap: prepare for dynamic update of guest's APCB on
    assign/unassign
  s390/vfio-ap: prepare for dynamic update of guest's APCB on queue
    probe/remove
  s390/vfio-ap: allow hot plug/unplug of AP devices when
    assigned/unassigned
  s390/vfio-ap: hot plug/unplug of AP devices when probed/removed
  s390/vfio-ap: reset queues after adapter/domain unassignment
  s390/vfio-ap: implement in-use callback for vfio_ap driver
  s390/vfio-ap: sysfs attribute to display the guest's matrix
  s390/vfio-ap: handle config changed and scan complete notification
  s390/vfio-ap: update docs to include dynamic config support
  s390/Docs: new doc describing lock usage by the vfio_ap device driver
  MAINTAINERS: pick up all vfio_ap docs for VFIO AP maintainers

 Documentation/s390/index.rst                  |    1 +
 Documentation/s390/vfio-ap-locking.rst        |  115 ++
 Documentation/s390/vfio-ap.rst                |  498 ++++--
 MAINTAINERS                                   |    2 +-
 arch/s390/boot/startup.c                      |   10 +-
 arch/s390/boot/uv.c                           |    5 +-
 arch/s390/boot/uv.h                           |    7 +-
 arch/s390/crypto/aes_s390.c                   |    2 +-
 arch/s390/crypto/chacha-glue.c                |    2 +-
 arch/s390/crypto/crc32-vx.c                   |    2 +-
 arch/s390/crypto/des_s390.c                   |    2 +-
 arch/s390/crypto/ghash_s390.c                 |    2 +-
 arch/s390/crypto/prng.c                       |    2 +-
 arch/s390/crypto/sha1_s390.c                  |    2 +-
 arch/s390/crypto/sha256_s390.c                |    2 +-
 arch/s390/crypto/sha3_256_s390.c              |    2 +-
 arch/s390/crypto/sha3_512_s390.c              |    2 +-
 arch/s390/crypto/sha512_s390.c                |    2 +-
 arch/s390/include/asm/cpufeature.h            |   23 +-
 arch/s390/include/asm/mmu.h                   |   14 -
 arch/s390/include/asm/os_info.h               |   17 +-
 arch/s390/include/asm/sclp.h                  |    4 +-
 arch/s390/include/asm/uaccess.h               |    1 -
 arch/s390/include/asm/unwind.h                |    2 +-
 arch/s390/kernel/Makefile                     |    2 +-
 arch/s390/kernel/cpufeature.c                 |   46 +
 arch/s390/kernel/crash_dump.c                 |  108 +-
 arch/s390/kernel/nmi.c                        |    8 +-
 arch/s390/kernel/processor.c                  |   10 -
 arch/s390/kernel/setup.c                      |   13 +-
 arch/s390/mm/maccess.c                        |   26 -
 drivers/char/hw_random/s390-trng.c            |    2 +-
 drivers/s390/char/Kconfig                     |    2 +-
 drivers/s390/char/tape_34xx.c                 |    2 +-
 drivers/s390/char/uvdevice.c                  |    5 +-
 drivers/s390/char/zcore.c                     |   55 +-
 drivers/s390/crypto/ap_bus.c                  |   31 +-
 drivers/s390/crypto/pkey_api.c                |    2 +-
 drivers/s390/crypto/vfio_ap_drv.c             |  124 +-
 drivers/s390/crypto/vfio_ap_ops.c             | 1441 +++++++++++++----
 drivers/s390/crypto/vfio_ap_private.h         |   47 +-
 include/uapi/linux/elf.h                      |    1 +
 .../crypto/chacha20-s390/test-cipher.c        |    9 +-
 43 files changed, 1842 insertions(+), 813 deletions(-)
 create mode 100644 Documentation/s390/vfio-ap-locking.rst
 create mode 100644 arch/s390/kernel/cpufeature.c
