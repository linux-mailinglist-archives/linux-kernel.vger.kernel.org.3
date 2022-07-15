Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676BB576925
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiGOVnn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiGOVnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:43:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F0088752;
        Fri, 15 Jul 2022 14:43:35 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FJpwQc019889;
        Fri, 15 Jul 2022 21:43:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=g6gKrC0SyGpdDwDvywZHGJvJKARTqu53v60tvFRJWkc=;
 b=X6Xpx/fF8ZwvS7HP7eZaThGg4fFiI/wq0nqqbVfj54ddlibRCl4fuawQC7EMWXMxwCWI
 tAj7XHQZQ+/Ith1fTRw96UWm9g2rZRWknsnFiLFzy2PkeSsLpI6tW8vTMkLlGD3/Ygil
 UTc+pasxHMf9r3c601tyH/Tm8jkSXYdfOQqP/+C87Exu7rFCcrS4TK4EieLOmDxNKYZB
 sr1WPSas8RXp2OYeIwDhuQ+dO5Uaf1Cx9AFEaJcvftAJd8gXV+9SZ73XU3DHNtcs0vE8
 QDHFDYiMFCTWnMvqoiGvwIXclb04KlFG21ZRjMitQt/NZVapkP33sHWZwDF5WXsBEgvU BQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3hbes6hyw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 21:43:34 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 26FLaFrK021474;
        Fri, 15 Jul 2022 21:43:31 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma02fra.de.ibm.com with ESMTP id 3hama9hr3v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jul 2022 21:43:31 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 26FLhdAg29491546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 21:43:39 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7B8D411C04C;
        Fri, 15 Jul 2022 21:43:28 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4BCF811C04A;
        Fri, 15 Jul 2022 21:43:28 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 15 Jul 2022 21:43:28 +0000 (GMT)
Date:   Fri, 15 Jul 2022 23:43:27 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.19-rc7
Message-ID: <YtHff24djpjhFL66@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: YV8XLXj_aobkItn3HocIN_fcUwkg803B
X-Proofpoint-ORIG-GUID: YV8XLXj_aobkItn3HocIN_fcUwkg803B
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-15_13,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=901
 phishscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150095
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.19-rc7.

Note, a patch in linux-next has different description and misses Fixes & Link:
"s390/ap: fixes bug in the AP bus's __verify_queue_reservations function" vs
"s390/ap: fix error handling in __verify_queue_reservations()" in the pull
request. Otherwise, the patch is exactly the same oneliner.

Thank you,
Alexander

The following changes since commit d7d488f41b41a1b7a1df3c74f2f65eb4585f5d55:

  s390/qdio: Fix spelling mistake (2022-06-23 14:05:43 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-6

for you to fetch changes up to 2f23256c0ea20627c91ea2d468cda945f68c3395:

  s390/ap: fix error handling in __verify_queue_reservations() (2022-07-06 17:43:29 -0400)

----------------------------------------------------------------
s390 updates for 5.19-rc7

- Fix building of out-of-tree kernel modules without a pre-built
  kernel in case CONFIG_EXPOLINE_EXTERN=y.

- Fix a reference counting error that could prevent unloading of
  zcrypt modules. 
----------------------------------------------------------------

Tony Krowiak (1):
  s390/ap: fix error handling in __verify_queue_reservations()

Vasily Gorbik (2):
  s390/nospec: build expoline.o for modules_prepare target
  s390/nospec: remove unneeded header includes

 arch/s390/Makefile                      | 8 +++++++-
 arch/s390/include/asm/nospec-insn.h     | 2 --
 arch/s390/lib/Makefile                  | 3 ++-
 arch/s390/lib/expoline/Makefile         | 3 +++
 arch/s390/lib/{ => expoline}/expoline.S | 0
 drivers/s390/crypto/ap_bus.c            | 2 +-
 6 files changed, 13 insertions(+), 5 deletions(-)
 create mode 100644 arch/s390/lib/expoline/Makefile
 rename arch/s390/lib/{ => expoline}/expoline.S (100%)
