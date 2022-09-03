Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1FED5ABE26
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 11:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbiICJgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 05:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiICJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 05:36:24 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA61DFE3;
        Sat,  3 Sep 2022 02:36:23 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2839Nxsp013070;
        Sat, 3 Sep 2022 09:36:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=GOkO7kUUsDo/h9lgcGw5jZNwdqu6IJS0Ee1s02diS7E=;
 b=rk6KaMiO3rmhEI/t37emgA1uxVJuMgGOjdpT+ckOj0bf+R3dDOn2YKoZ4vjaO832qwPC
 h0PobmO7VA/LDQpQ5Bo8+C6FmRHRmAtrhVa9FKRMDi0Wyd82mHepLTJBq4C7eL/GEe5e
 sB5j2G0HtF5c0FmVAla+vbkFQrU3Xxmck1NmOia3LoYsTh6PXhEnoBsiHhwQZi+Yz3rq
 PMMt3lQKh4Bvy8xNdvFab255PMjZdO+yAHSZKgVBkCXo3QNCsaMtEEsvc/m133y+1CT5
 6yVigbQtSzKe3iOYQ0TXUvAYN3g3SEl0zXh2lq33t4O5fl6U3zaW+5n8CHk0/xlfacQB sQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3jc48rr7wg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Sep 2022 09:36:22 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2839aKKu005762;
        Sat, 3 Sep 2022 09:36:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 3jbxj8r702-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 03 Sep 2022 09:36:20 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2839aG3k38404566
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 3 Sep 2022 09:36:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B3CB45204F;
        Sat,  3 Sep 2022 09:36:16 +0000 (GMT)
Received: from localhost (unknown [9.171.88.165])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 587765204E;
        Sat,  3 Sep 2022 09:36:16 +0000 (GMT)
Date:   Sat, 3 Sep 2022 11:36:14 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.0-rc4
Message-ID: <your-ad-here.call-01662197774-ext-9772@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1YNkT7tYqvpPYWWfv2CGnKxvO9i4ghYU
X-Proofpoint-ORIG-GUID: 1YNkT7tYqvpPYWWfv2CGnKxvO9i4ghYU
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-09-03_03,2022-08-31_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0
 mlxlogscore=609 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209030048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.0-rc4.

Thank you,
Vasily

The following changes since commit b90cb1053190353cc30f0fef0ef1f378ccc063c5:

  Linux 6.0-rc3 (2022-08-28 15:05:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-3

for you to fetch changes up to 7c8d42fdf1a84b1a0dd60d6528309c8ec127e87c:

  s390/hugetlb: fix prepare_hugepage_range() check for 2 GB hugepages (2022-08-30 21:57:07 +0200)

----------------------------------------------------------------
s390 updates for 6.0-rc4

- Update defconfigs.

- Fix linker script to align nospec tables correctly to avoid potentially
  unbootable kernel with some config options.

- Fix alignment check in prepare_hugepage_range() for 2GB hugepages to avoid
  BUG in __unmap_hugepage_range() for unaligned mappings later.

- Remove useless hugepage address alignment in hugetlb faults handling.

----------------------------------------------------------------
Gerald Schaefer (2):
      s390/mm: remove useless hugepage address alignment
      s390/hugetlb: fix prepare_hugepage_range() check for 2 GB hugepages

Heiko Carstens (1):
      s390: update defconfigs

Josh Poimboeuf (1):
      s390: fix nospec table alignments

 arch/s390/configs/debug_defconfig    | 53 ++++++++++++++++++++----------------
 arch/s390/configs/defconfig          | 49 ++++++++++++++++++---------------
 arch/s390/configs/zfcpdump_defconfig |  6 ++--
 arch/s390/include/asm/hugetlb.h      |  6 ++--
 arch/s390/kernel/vmlinux.lds.S       |  1 +
 arch/s390/mm/fault.c                 |  2 --
 6 files changed, 65 insertions(+), 52 deletions(-)
