Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 921EB489003
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 07:07:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiAJGHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 01:07:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230451AbiAJGHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 01:07:39 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20A42hEB019579;
        Mon, 10 Jan 2022 06:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=xRCHIJw4fwBY+2OYsV0u7K9th9v7WxMwIdEg8ZJ4CKw=;
 b=OS+Al7pExv8xN7CsJ+drgKdJrZTAWrP36L+wnstynwUzka1cxVLJcQ3FGa+WDfx3ifdq
 Hy20u1xuB6/BkeTGbXB3d017+RFUV3yF84Yt7G8Bk2jXXZytT6yYyPlDSe8qtsUGRNNJ
 h3VvFoeSzeZwBohVHicgAYh2qaUYt6VMF0/mBFmyspa8NuCq53ytIIsIgU5THfBdP0Es
 qOD9FQed6NHwrEqNLXXn76dCJ6qzY2AmIwRG3YLfivTIgntuH32rL0PXfOYZpYnXQGi+
 ID1Gv7fgoMMEnWjr9OtYSiTJLeN0vD+MhzgoZw39vsiEfk2l+58MAHTHPs2Nul7JW0Vd 2g== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3dfm04ar3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 06:07:28 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20A63YEO009530;
        Mon, 10 Jan 2022 06:07:27 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3df289gk0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Jan 2022 06:07:26 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20A67NN429622616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 06:07:23 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 63F4D11C05C;
        Mon, 10 Jan 2022 06:07:23 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 24F7411C071;
        Mon, 10 Jan 2022 06:07:23 +0000 (GMT)
Received: from osiris (unknown [9.145.76.99])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 10 Jan 2022 06:07:23 +0000 (GMT)
Date:   Mon, 10 Jan 2022 07:07:21 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Andy Polyakov <appro@openssl.org>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.17 merge window
Message-ID: <YdvNGdx2O4u3hFwn@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qgEbrZT0AmbQ36gVtESGLtFavYTf6-mN
X-Proofpoint-ORIG-GUID: qgEbrZT0AmbQ36gVtESGLtFavYTf6-mN
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-10_02,2022-01-07_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1011 bulkscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201100042
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull s390 update for 5.17 merge window.

Besides all the small improvements and cleanups the most notable part
is the fast vector/SIMD implementation of the ChaCha20 stream cipher,
which is an adaptation of Andy Polyakov's code for the kernel.

Thanks,
Heiko

The following changes since commit 0fcfb00b28c0b7884635dacf38e46d60bf3d4eb1:

  Linux 5.16-rc4 (2021-12-05 14:08:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-1

for you to fetch changes up to 0704a8586f75663cf30a283bbeeca09eb4e60a07:

  s390/dasd: use default_groups in kobj_type (2022-01-08 17:44:05 +0100)

----------------------------------------------------------------
s390 updates for 5.17 merge window

- add fast vector/SIMD implementation of the ChaCha20 stream cipher,
  which mainly adapts Andy Polyakov's code for the kernel

- add status attribute to AP queue device so users can easily figure
  out its status

- fix race in page table release code, and and lots of documentation

- remove uevent suppress from cio device driver, since it turned out
  that it generated more problems than it solved problems

- quite a lot of virtual vs physical address confusion fixes

- various other small improvements and cleanups all over the place

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/sclp: release SCLP early buffer after kernel initialization

Alexander Gordeev (4):
      s390/nmi: disable interrupts on extended save area update
      s390/mm: fix 2KB pgtable release race
      s390/mm: better annotate 2KB pagetable fragments handling
      s390/mm: check 2KB-fragment page on release

Eric W. Biederman (1):
      s390/exit: remove dead reference to do_exit from copy_thread

Greg Kroah-Hartman (2):
      s390/sclp_sd: use default_groups in kobj_type
      s390/dasd: use default_groups in kobj_type

Guo Ren (1):
      s390: remove unused TASK_SIZE_OF

Heiko Carstens (14):
      s390/vmcp: use page_to_virt instead of page_to_phys
      s390/nmi: add missing __pa/__va address conversion of extended save area
      s390/mm: add missing phys_to_virt translation to page table dumper
      s390/diag: use pfn_to_phys() instead of open coding
      s390/cmm: add missing virt_to_phys() conversion
      s390/pgalloc: add virt/phys address handling to base asce functions
      s390/pgalloc: use pointers instead of unsigned long values
      s390/ap: add missing virt_to_phys address conversion
      s390/sclp: fix memblock_phys_free() vs memblock_free() confusion
      s390/smp: fix memblock_phys_free() vs memblock_free() confusion
      s390/uv: fix memblock virtual vs physical address confusion
      s390/disassembler: update opcode table
      s390/crypto: fix compile error for ChaCha20 module
      s390/crash_dump: fix virtual vs physical address handling

Juergen Christ (1):
      s390/zcrypt: CCA control CPRB sending

Julian Wiedmann (9):
      s390/qdio: remove QDIO_SBAL_SIZE macro
      s390/qdio: improve handling of CIWs
      s390/qdio: avoid allocating the qdio_irq with GFP_DMA
      s390/qdio: clean up access to queue in qdio_handle_activate_check()
      s390/qdio: clarify handler logic for qdio_handle_activate_check()
      s390/qdio: split qdio_inspect_queue()
      s390/qdio: split do_QDIO()
      s390/qdio: remove unneeded sanity check in qdio_do_sqbs()
      s390/qdio: clarify logical vs absolute in QIB's kerneldoc

Niklas Schnelle (3):
      s390/pci: use phys_to_virt() for AIBVs/DIBVs
      s390/pci: use physical addresses in DMA tables
      s390/pci: simplify __pciwb_mio() inline asm

Patrick Steuer (1):
      s390/crypto: add SIMD implementation for ChaCha20

Tony Krowiak (1):
      s390/vfio-ap: add status attribute to AP queue device's sysfs dir

Vineeth Vijayan (1):
      s390/cio: remove uevent suppress from cio driver

 arch/s390/configs/debug_defconfig |   1 +
 arch/s390/configs/defconfig       |   1 +
 arch/s390/crypto/Makefile         |   2 +
 arch/s390/crypto/chacha-glue.c    | 100 +++++
 arch/s390/crypto/chacha-s390.S    | 907 ++++++++++++++++++++++++++++++++++++++
 arch/s390/crypto/chacha-s390.h    |  14 +
 arch/s390/include/asm/ap.h        |   4 +-
 arch/s390/include/asm/diag.h      |   4 +-
 arch/s390/include/asm/nmi.h       |   6 +-
 arch/s390/include/asm/pci_dma.h   |  29 +-
 arch/s390/include/asm/processor.h |   3 +-
 arch/s390/include/asm/qdio.h      |  25 +-
 arch/s390/include/asm/vx-insn.h   | 117 +++++
 arch/s390/kernel/crash_dump.c     |   2 +-
 arch/s390/kernel/dis.c            |   1 +
 arch/s390/kernel/machine_kexec.c  |   2 +-
 arch/s390/kernel/nmi.c            |  43 +-
 arch/s390/kernel/process.c        |   1 -
 arch/s390/kernel/setup.c          |   2 +-
 arch/s390/kernel/smp.c            |  35 +-
 arch/s390/kernel/uv.c             |  10 +-
 arch/s390/mm/cmm.c                |   2 +-
 arch/s390/mm/fault.c              |   8 +-
 arch/s390/mm/init.c               |   3 +
 arch/s390/mm/pgalloc.c            | 244 +++++++---
 arch/s390/pci/pci.c               |   2 +-
 arch/s390/pci/pci_dma.c           |  26 +-
 arch/s390/pci/pci_insn.c          |   5 +-
 arch/s390/pci/pci_irq.c           |   6 +-
 arch/s390/tools/opcodes.txt       |   3 +-
 drivers/crypto/Kconfig            |  12 +
 drivers/iommu/s390-iommu.c        |  10 +-
 drivers/s390/block/dasd_devmap.c  |   3 +-
 drivers/s390/char/sclp_early.c    |   2 +-
 drivers/s390/char/sclp_sd.c       |   3 +-
 drivers/s390/char/vmcp.c          |   4 +-
 drivers/s390/cio/chsc_sch.c       |   5 -
 drivers/s390/cio/css.c            |  19 -
 drivers/s390/cio/device.c         |  20 +-
 drivers/s390/cio/eadm_sch.c       |   5 -
 drivers/s390/cio/qdio.h           |   7 +-
 drivers/s390/cio/qdio_main.c      | 210 +++++----
 drivers/s390/cio/qdio_setup.c     |  22 +-
 drivers/s390/cio/vfio_ccw_drv.c   |   5 -
 drivers/s390/crypto/vfio_ap_drv.c |  79 +++-
 drivers/s390/crypto/zcrypt_api.c  |   7 +-
 drivers/s390/net/qeth_core_main.c |  36 +-
 drivers/s390/scsi/zfcp_qdio.c     |  19 +-
 48 files changed, 1703 insertions(+), 373 deletions(-)
 create mode 100644 arch/s390/crypto/chacha-glue.c
 create mode 100644 arch/s390/crypto/chacha-s390.S
 create mode 100644 arch/s390/crypto/chacha-s390.h

