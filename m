Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1155153C8CC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbiFCKfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243761AbiFCKfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:35:51 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4693BBEE;
        Fri,  3 Jun 2022 03:35:49 -0700 (PDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 253AINDM017529;
        Fri, 3 Jun 2022 10:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=KrF/6NdORb5t9M1zK9SmmWbSKjZRrMIB2uKQIGHIFJo=;
 b=PxmDhQe2pbbCDaWlmeLislDzKdhK34hByl612MJNhGoid9YrD9jZFNjW9Ethhq/OqxyZ
 kmPEngx7/v6ZMrTns6Q9fxNXjATflU6Y0ZzN0Q8yCcxl2W70AZF6q42nhdxzGlwyoBAf
 ffse3Pzr5Lppucb7bhDAOidJEzJU1BPXvMSpuLSqau5BU00VQ84o3M36vw7tnbfflZNw
 bXZBIMWi0d7hmphBp+cXdBVLyUDUISTCz8y/e0w44mZ0efd295prr5bon80JqagQQ7uH
 1hBMfXC6iW8HMSyEw58TzJou2FjOwoIhIl+Khvjl5k5rlySkzouYcTnnjNQgt57f/awL 2A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3gfge5881b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 10:35:48 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 253AZlqW013713;
        Fri, 3 Jun 2022 10:35:47 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3gbc8yp9rn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Jun 2022 10:35:46 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 253AZhIU35127698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Jun 2022 10:35:43 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94B2452057;
        Fri,  3 Jun 2022 10:35:43 +0000 (GMT)
Received: from osiris (unknown [9.145.50.93])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4C61052051;
        Fri,  3 Jun 2022 10:35:43 +0000 (GMT)
Date:   Fri, 3 Jun 2022 12:35:41 +0200
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 5.19 merge window
Message-ID: <Ypnj/R48mToD7WZL@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oZcCA2zYdX6aaB1BpyTNKp6YRqjFlvfy
X-Proofpoint-ORIG-GUID: oZcCA2zYdX6aaB1BpyTNKp6YRqjFlvfy
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-03_03,2022-06-03_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=5 mlxscore=0 bulkscore=5 mlxlogscore=667 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 malwarescore=0
 suspectscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2204290000 definitions=main-2206030046
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull more s390 updates for 5.19 merge window.
Just a couple of small improvements, bug fixes and cleanups.

Thanks,
Heiko

The following changes since commit 94d3477897481b92874654455e263e0b1728acb5:

  s390/head: get rid of 31 bit leftovers (2022-05-18 13:31:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-2

for you to fetch changes up to e0ffcf3fe18e0310221461c08969edec2cc7628c:

  s390/stack: add union to reflect kvm stack slot usages (2022-06-01 12:03:17 +0200)

----------------------------------------------------------------
more s390 updates for 5.19 merge window

- Add Eric Farman as maintainer for s390 virtio drivers.

- Improve machine check handling, and avoid incorrectly injecting a machine
  check into a kvm guest.

- Add cond_resched() call to gmap page table walker in order to avoid
  possible huge latencies. Also use non-quiesing sske instruction to speed
  up storage key handling.

- Add __GFP_NORETRY to KEXEC_CONTROL_MEMORY_GFP so s390 behaves similar like
  common code.

- Get sie control block address from correct stack slot in perf event
  code. This fixes potential random memory accesses.

- Change uaccess code so that the exception handler sets the result of
  get_user() and __get_kernel_nofault() to zero in case of a fault. Until
  now this was done via input parameters for inline assemblies. Doing it
  via fault handling is what most or even all other architectures are
  doing.

- Couple of other small cleanups and fixes.

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/mcck: isolate SIE instruction when setting CIF_MCCK_GUEST flag

Christian Borntraeger (2):
      s390/gmap: voluntarily schedule during key setting
      s390/mm: use non-quiescing sske for KVM switch to keyed guest

Eric Farman (1):
      MAINTAINERS: Update s390 virtio-ccw

Heiko Carstens (9):
      s390: simplify early program check handler
      s390: generate register offsets into pt_regs automatically
      s390/kexec: add __GFP_NORETRY to KEXEC_CONTROL_MEMORY_GFP
      s390/uaccess: use symbolic names for inline assembler operands
      s390/uaccess: use exception handler to zero result on get_user() failure
      s390/uaccess: use __noreturn instead of __attribute__((noreturn))
      s390/uaccess: whitespace cleanup
      s390/stack: merge empty stack frame slots
      s390/stack: add union to reflect kvm stack slot usages

Jann Horn (1):
      s390/crypto: fix scatterwalk_unmap() callers in AES-GCM

Juerg Haefliger (2):
      s390/Kconfig: fix indentation
      s390/Kconfig.debug: fix indentation

Nico Boehr (1):
      s390/perf: obtain sie_block from the right address

 MAINTAINERS                             |   1 +
 arch/s390/Kconfig                       |   8 +-
 arch/s390/Kconfig.debug                 |  12 +-
 arch/s390/crypto/aes_s390.c             |   4 +-
 arch/s390/include/asm/asm-extable.h     |  91 +++++++++-----
 arch/s390/include/asm/kexec.h           |   2 +-
 arch/s390/include/asm/processor.h       |   6 -
 arch/s390/include/asm/stacktrace.h      |  11 +-
 arch/s390/include/asm/uaccess.h         | 217 +++++++++++++++++---------------
 arch/s390/kernel/Makefile               |   2 +-
 arch/s390/kernel/asm-offsets.c          |  26 +++-
 arch/s390/kernel/early.c                |   5 +-
 arch/s390/kernel/{base.S => earlypgm.S} |  33 +----
 arch/s390/kernel/entry.S                |  23 +---
 arch/s390/kernel/entry.h                |   2 +
 arch/s390/kernel/perf_event.c           |   2 +-
 arch/s390/mm/extable.c                  |  39 +++++-
 arch/s390/mm/gmap.c                     |  14 +++
 arch/s390/mm/pgtable.c                  |   2 +-
 19 files changed, 289 insertions(+), 211 deletions(-)
 rename arch/s390/kernel/{base.S => earlypgm.S} (52%)
