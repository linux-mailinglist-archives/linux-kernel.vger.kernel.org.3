Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1D64EEE1E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 15:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346342AbiDANbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 09:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232890AbiDANbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 09:31:20 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 115A626C2F6;
        Fri,  1 Apr 2022 06:29:30 -0700 (PDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231DEDe6013751;
        Fri, 1 Apr 2022 13:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=qmkl+q+uT18szoUD1dOretWcohg1KMIAJpMD2FHxU9Q=;
 b=dUEiWPT7zTWr/XteZRNVA2oaZ9i60ZsmnDRMlxIK2VDKpM/DlPp07t6DJ/7/DzL9d6S3
 YHkB76mC7uNRB9snAZLHN4xKclcaDDUSlAi2wKpuoKKmI9Cx1HdR4Q0Qqbse0a6oaUxo
 l9vuC91YxujEKneiOwUAHXd+aY0/0yGTZjUXFZsxophG17rj7WyZ9FRnVG7300+TN6Tg
 SnroMIQinwomPCJRdFbZIZnkRek9FsX0Bvu6tquhGcjHgtDl8YJCwDgflRxNgoefdifj
 AyFSIgGjSdCEa3GcxEyJLEgc+CMppvLO/8xq9L14cpbwWrM7BbXV4MG+Ylhe5rkewjM9 vA== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3f623qg9a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 13:29:28 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 231DDjtq009363;
        Fri, 1 Apr 2022 13:29:26 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 3f1tf9n3ts-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 13:29:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 231DHJbC50462990
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Apr 2022 13:17:19 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2877A42057;
        Fri,  1 Apr 2022 13:29:23 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AF5542045;
        Fri,  1 Apr 2022 13:29:22 +0000 (GMT)
Received: from localhost (unknown [9.171.12.244])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Apr 2022 13:29:22 +0000 (GMT)
Date:   Fri, 1 Apr 2022 15:29:20 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 patches for the 5.18 merge window #2
Message-ID: <your-ad-here.call-01648819760-ext-9805@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sYMNrpzL8zVQ0_CohnULtQ0No3acwqrK
X-Proofpoint-ORIG-GUID: sYMNrpzL8zVQ0_CohnULtQ0No3acwqrK
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_04,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 mlxscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010061
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull the second round of s390 changes for 5.18.

Thank you,
Vasily

The following changes since commit d710d370c4911e83da5d2bc43d4a2c3b56bd27e7:

  Merge tag 's390-5.18-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2022-03-25 10:01:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.18-2

for you to fetch changes up to faf79934e65aff90284725518a5ec3c2241c65ae:

  s390/alternatives: avoid using jgnop mnemonic (2022-03-28 23:27:54 +0200)

----------------------------------------------------------------
s390 updates for the 5.18 merge window #2

- Add kretprobes framepointer verification and return address recovery
  in stacktrace.

- Support control domain masks on custom zcrypt devices and filter admin
  requests.

- Cleanup timer API usage.

- Rework absolute lowcore access helpers.

- Other various small improvements and fixes.

----------------------------------------------------------------
Alexander Gordeev (4):
      s390/smp: cleanup target CPU callback starting
      s390/smp: cleanup control register update routines
      s390/maccess: rework absolute lowcore accessors
      s390/smp: use physical address for SIGP_SET_PREFIX command

Haowen Bai (2):
      s390: crypto: Use min_t() instead of doing it manually
      s390/tape: use bitwise instead of arithmetic operator for flags

Heiko Carstens (5):
      s390/traps: improve panic message for translation-specification exception
      s390/alternatives: use instructions instead of byte patterns
      s390/alternatives: use insn format for new instructions
      s390/ap: use insn format for new instructions
      s390/ap: adjust whitespace

Jakob Koschel (1):
      s390/zcrypt: fix using the correct variable for sizeof()

Juergen Christ (2):
      s390/zcrypt: Add admask to zcdn
      s390/zcrypt: Filter admin CPRBs on custom devices

Julia Lawall (1):
      s390/pkey: fix typos in comments

Niklas Schnelle (2):
      s390/pci: improve zpci_dev reference counting
      s390/pci: rename get_zdev_by_bus() to zdev_from_bus()

Russell Currey (1):
      s390: fix typo in syscall_wrapper.h

Tony Krowiak (1):
      s390/vfio-ap: fix kernel doc and signature of group notifier functions

Vasily Gorbik (6):
      s390/test_unwind: extend kretprobe test
      s390/kprobes: enable kretprobes framepointer verification
      s390/unwind: recover kretprobe modified return address in stacktrace
      s390/unwind: avoid duplicated unwinding entries for kretprobes
      s390/test_unwind: verify __kretprobe_trampoline is replaced
      s390/alternatives: avoid using jgnop mnemonic

Yu Liao (1):
      s390: cleanup timer API use

 arch/s390/Kconfig                       |  1 +
 arch/s390/include/asm/alternative-asm.h | 12 ++++--
 arch/s390/include/asm/alternative.h     | 15 ++++++--
 arch/s390/include/asm/ap.h              | 60 ++++++++++++++---------------
 arch/s390/include/asm/ctl_reg.h         | 16 +++++---
 arch/s390/include/asm/processor.h       | 17 ++++++---
 arch/s390/include/asm/spinlock.h        |  2 +-
 arch/s390/include/asm/syscall_wrapper.h |  2 +-
 arch/s390/include/asm/unwind.h          | 13 +++++++
 arch/s390/kernel/entry.S                | 10 ++---
 arch/s390/kernel/ipl.c                  |  4 +-
 arch/s390/kernel/kprobes.c              |  8 ++--
 arch/s390/kernel/machine_kexec.c        |  2 +-
 arch/s390/kernel/os_info.c              |  2 +-
 arch/s390/kernel/setup.c                | 19 ++++-----
 arch/s390/kernel/smp.c                  | 57 +++++++++++++--------------
 arch/s390/kernel/traps.c                |  6 +--
 arch/s390/kernel/unwind_bc.c            | 12 ++----
 arch/s390/lib/spinlock.c                |  4 +-
 arch/s390/lib/test_unwind.c             | 58 +++++++++++++++++++---------
 arch/s390/pci/pci.c                     |  5 ++-
 arch/s390/pci/pci_bus.h                 |  7 ++--
 arch/s390/pci/pci_clp.c                 |  9 ++++-
 arch/s390/pci/pci_event.c               |  7 +++-
 drivers/s390/char/sclp.c                |  4 +-
 drivers/s390/char/sclp_con.c            |  3 +-
 drivers/s390/char/sclp_vt220.c          |  6 +--
 drivers/s390/char/tape_34xx.c           |  4 +-
 drivers/s390/cio/device_fsm.c           | 12 ++----
 drivers/s390/cio/eadm_sch.c             | 12 ++----
 drivers/s390/crypto/ap_bus.h            |  1 +
 drivers/s390/crypto/pkey_api.c          |  2 +-
 drivers/s390/crypto/vfio_ap_ops.c       | 24 +++---------
 drivers/s390/crypto/zcrypt_api.c        | 68 ++++++++++++++++++++++++++++++++-
 drivers/s390/crypto/zcrypt_card.c       |  2 +-
 drivers/s390/crypto/zcrypt_ep11misc.c   |  2 +-
 36 files changed, 296 insertions(+), 192 deletions(-)
