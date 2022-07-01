Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DE6562FDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234681AbiGAJYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbiGAJYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:24:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA64735AA;
        Fri,  1 Jul 2022 02:24:11 -0700 (PDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2619FeNI003267;
        Fri, 1 Jul 2022 09:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=QXN3DsoZl4u8T0qOiYYAplYtefGxvhtLhgF9KgWLP38=;
 b=q2bFl8AYx0zogOj0jXwqQmd9ChXzcK3Pnt1bjgmbZwAvVchsztJ3FHiUuTpmEuYp/tjd
 LUp+lcQvI/V/aJryr819eKA/7rYzjiassXMuyixFmjZCDk64sL44ftajxCqa6Dnwq4CJ
 hVz0rQS2jS9KRxzD72RbvpqJVh18JB0DErhGVbx2wqIKx1NmuGQtfEy+b48AQHdl7x2Y
 r22agnsEn97sRXCe4dCNFC21XWaVQWx3T0hXBG/KZ+DlpjzrBHT7YJzIZAQwXXI0k7sG
 XIDw3QRUQC9z/acKqKaLme16YEIx1Em5Pn5I2z19P0mXGxhS8zFdBueChD18tupwNNS2 ew== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3h1x4x8724-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 09:24:10 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2619O7HI012299;
        Fri, 1 Jul 2022 09:24:08 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 3gwt0973f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 09:24:07 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2619O4IL13304288
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 Jul 2022 09:24:04 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 59A7CA4066;
        Fri,  1 Jul 2022 09:24:04 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CE96A405F;
        Fri,  1 Jul 2022 09:24:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri,  1 Jul 2022 09:24:04 +0000 (GMT)
Date:   Fri, 1 Jul 2022 11:24:02 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.19-rc5
Message-ID: <Yr69Mr39dc2xRygV@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0XI-ShGf39yvSEil4V64x0L5pWyEM4J_
X-Proofpoint-ORIG-GUID: 0XI-ShGf39yvSEil4V64x0L5pWyEM4J_
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-01_05,2022-06-28_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=964
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2207010033
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.19-rc5.

Thank you,
Alexander

The following changes since commit 21e876448792af2dd5261338907c72bdf37fa056:

  s390/pai: Fix multiple concurrent event installation (2022-06-15 14:02:07 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-5

for you to fetch changes up to d7d488f41b41a1b7a1df3c74f2f65eb4585f5d55:

  s390/qdio: Fix spelling mistake (2022-06-23 14:05:43 +0800)

----------------------------------------------------------------
s390 updates for 5.19-rc5

- Fix purgatory build process so bin2c tool does not get built
  unnecessarily and the Makefile is more consistent with other
  architectures.

- Return earlier simple design of arch_get_random_seed_long|int()
  and arch_get_random_long|int() callbacks as result of changes
  in generic RNG code.

- Fix minor comment typos and spelling mistakes.
----------------------------------------------------------------

Jason A. Donenfeld (1):
  s390/archrandom: simplify back to earlier design and initialize
    earlier

Jiang Jian (1):
  s390/sclp: Fix typo in comments

Masahiro Yamada (3):
  s390: remove unneeded 'select BUILD_BIN2C'
  s390/purgatory: hard-code obj-y in Makefile
  s390/purgatory: remove duplicated build rule of kexec-purgatory.o

Zhang Jiaming (1):
  s390/qdio: Fix spelling mistake

 arch/s390/Kconfig                  |   1 -
 arch/s390/crypto/arch_random.c     | 217 -----------------------------
 arch/s390/include/asm/archrandom.h |  14 +-
 arch/s390/include/asm/qdio.h       |   6 +-
 arch/s390/kernel/setup.c           |   5 +
 arch/s390/purgatory/Makefile       |   5 +-
 drivers/s390/char/sclp.c           |   2 +-
 7 files changed, 18 insertions(+), 232 deletions(-)
