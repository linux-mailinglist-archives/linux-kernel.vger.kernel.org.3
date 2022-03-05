Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD604CE4A6
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 12:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiCELiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 06:38:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbiCELiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 06:38:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DA1CD7C2;
        Sat,  5 Mar 2022 03:37:11 -0800 (PST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2258Rh2r021928;
        Sat, 5 Mar 2022 11:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=JUE9MkZrXGHLNUB1IJSigF2Ut9A0BXyg9PBlMjVNyuU=;
 b=TaaG1FPsrtB+mMyk9f+KJc2FAvYh9hV0lfxhp3N2CNE1DMOC1IdTXDXMiqnPQwXyDEam
 kpBq0SJBPAyyOhc3Lr9c+e05pashvUBT8KJvMXt4DER+1QKb75jg8+g9xm7l9Pchcn4c
 nMs5VmpA4YwUFvH9Kukr4USfMEw5VQXV+DO7eAzu9jVZAZlo9OuXY6BzDWA41d4LL2AN
 1o4req/dhhFAt3bjgMssh8x8YyVUCJTpY3S7Utd/obLGa4zWANP5K/aeaupYULjHgZrt
 XTLpyBkjghqRXo7z6z8r2KbAPWxQywfSDovQtDSkuQMUQasLf70DBZ66ZpHs0rt5bioL Mg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ekxnr621w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Mar 2022 11:37:09 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 225BS78D021994;
        Sat, 5 Mar 2022 11:37:07 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 3ekyg90s2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Mar 2022 11:37:07 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 225Bb4GV44892458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Mar 2022 11:37:04 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76634AE04D;
        Sat,  5 Mar 2022 11:37:04 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 30D86AE045;
        Sat,  5 Mar 2022 11:37:04 +0000 (GMT)
Received: from localhost (unknown [9.171.8.66])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat,  5 Mar 2022 11:37:04 +0000 (GMT)
Date:   Sat, 5 Mar 2022 12:37:02 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.17-rc7
Message-ID: <your-ad-here.call-01646480222-ext-8975@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OIFXRh5t9pZWjNf9tHzpmns4U5wVitRS
X-Proofpoint-GUID: OIFXRh5t9pZWjNf9tHzpmns4U5wVitRS
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-05_04,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=943 clxscore=1011
 lowpriorityscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203050063
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

please pull s390 changes for 5.17-rc7.

Thank you,
Vasily

The following changes since commit dd9cb842fa9d90653a9b48aba52f89c069f3bc50:

  s390/cio: verify the driver availability for path_event call (2022-02-09 22:55:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-5

for you to fetch changes up to c194dad21025dfd043210912653baab823bdff67:

  s390/extable: fix exception table sorting (2022-03-01 20:41:28 +0100)

----------------------------------------------------------------
s390 updates for 5.17-rc7

- Fix HAVE_DYNAMIC_FTRACE_WITH_ARGS implementation by providing correct
  switching between ftrace_caller/ftrace_regs_caller and supplying pt_regs
  only when ftrace_regs_caller is activated.

- Fix exception table sorting.

- Fix breakage of kdump tooling by preserving metadata it cannot function
  without.

----------------------------------------------------------------
Alexander Egorenkov (1):
      s390/setup: preserve memory at OLDMEM_BASE and OLDMEM_SIZE

Heiko Carstens (3):
      s390/ftrace: fix ftrace_caller/ftrace_regs_caller generation
      s390/ftrace: fix arch_ftrace_get_regs implementation
      s390/extable: fix exception table sorting

 arch/s390/include/asm/extable.h |  9 +++++++--
 arch/s390/include/asm/ftrace.h  | 10 ++++++----
 arch/s390/include/asm/ptrace.h  |  2 ++
 arch/s390/kernel/ftrace.c       | 37 ++++++++++++++++++++++++++++++++++++-
 arch/s390/kernel/mcount.S       |  9 +++++++++
 arch/s390/kernel/setup.c        |  2 ++
 6 files changed, 62 insertions(+), 7 deletions(-)
