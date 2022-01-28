Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DB949F8C0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348240AbiA1Lva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:51:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231424AbiA1Lv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:51:27 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SBgkxr024913;
        Fri, 28 Jan 2022 11:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=eC8ipLLB2uI8NrXbV8X1ysNXPc3iCrj4AIcThVib9jI=;
 b=luXNgu5sJXei8SfEzJI5oJkBkl6wbU/9kKrqEhuJ5NNGQUlCLt/JZEtFih36tKTw9Qhx
 3HieB6nOpKy5oFDtoulCI1ykaeCyhT7t+0HP6HxYv7VuLzeBCC5/jNsURUxPxtjTbEE5
 kpP+ojjc447Fc54sfiaRtQHCAP2XVyq+02ePJnUlHdIIQeuNqXTc4CEhcHzJw9zofAK9
 77SH8BxSXlhJWD0AXE1qyYrf0cu3I3b1Uv3VIU2TcwuO3DurGFFRqJVrfw2X+m/FuY0n
 yRBgPFSXxNN/1r7MflrLoqaxHNkVmNBTP6urWpFYyuBggmUgcIsRLD47m5sYNmOyF/u7 GQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dvfuvr55a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 11:51:23 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20SBmVBI006861;
        Fri, 28 Jan 2022 11:51:21 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3dr9j9p8sj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 11:51:21 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20SBfZF021692736
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 11:41:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 48C4DAE059;
        Fri, 28 Jan 2022 11:51:15 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 05956AE055;
        Fri, 28 Jan 2022 11:51:15 +0000 (GMT)
Received: from localhost (unknown [9.171.48.148])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 28 Jan 2022 11:51:14 +0000 (GMT)
Date:   Fri, 28 Jan 2022 12:51:13 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.17-rc2
Message-ID: <your-ad-here.call-01643370673-ext-6058@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f9KlZ2Y-tMReijDSYTat2d6jUV8m1nmP
X-Proofpoint-ORIG-GUID: f9KlZ2Y-tMReijDSYTat2d6jUV8m1nmP
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-28_02,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0 spamscore=0
 mlxlogscore=887 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280072
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.17-rc2.

Thank you,
Vasily

The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:

  Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-3

for you to fetch changes up to 663d34c8df98740f1e90241e78e456d00b3c6cad:

  s390/hypfs: include z/VM guests with access control group set (2022-01-26 18:42:39 +0100)

----------------------------------------------------------------
s390 updates for 5.17-rc2

- Fix loading of modules with lots of relocations and add a regression
  test for it.

- Fix machine check handling for vector validity and guarded storage
  validity failures in KVM guests.

- Fix hypervisor performance data to include z/VM guests with access
  control group set.

- Fix z900 build problem in uaccess code.

- Update defconfigs.

----------------------------------------------------------------
Christian Borntraeger (2):
      s390/nmi: handle guarded storage validity failures for KVM guests
      s390/nmi: handle vector validity failures for KVM guests

Heiko Carstens (2):
      s390/uaccess: fix compile error
      s390: update defconfigs

Ilya Leoshkevich (2):
      s390/module: fix loading modules with a lot of relocations
      s390/module: test loading modules with a lot of relocations

Vasily Gorbik (1):
      s390/hypfs: include z/VM guests with access control group set

 arch/s390/Kconfig                    | 15 +++++++++++
 arch/s390/configs/debug_defconfig    | 20 +++++++--------
 arch/s390/configs/defconfig          | 16 +++++++-----
 arch/s390/configs/zfcpdump_defconfig |  3 +++
 arch/s390/hypfs/hypfs_vm.c           |  6 +++--
 arch/s390/include/asm/uaccess.h      |  4 +--
 arch/s390/kernel/module.c            | 37 +++++++++++++-------------
 arch/s390/kernel/nmi.c               | 27 +++++++++++++++----
 arch/s390/lib/Makefile               |  3 +++
 arch/s390/lib/test_modules.c         | 35 +++++++++++++++++++++++++
 arch/s390/lib/test_modules.h         | 50 ++++++++++++++++++++++++++++++++++++
 arch/s390/lib/test_modules_helpers.c | 13 ++++++++++
 12 files changed, 184 insertions(+), 45 deletions(-)
 create mode 100644 arch/s390/lib/test_modules.c
 create mode 100644 arch/s390/lib/test_modules.h
 create mode 100644 arch/s390/lib/test_modules_helpers.c
