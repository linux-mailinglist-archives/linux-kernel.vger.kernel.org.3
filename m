Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5729B5A36E6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbiH0KIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232098AbiH0KIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:08:09 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BFEF4454F;
        Sat, 27 Aug 2022 03:08:08 -0700 (PDT)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27R9hcP6037962;
        Sat, 27 Aug 2022 10:08:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=8xKcbsI0WaLpBaSGpS2m5uow692Nn9YThXy2w7aZ5zo=;
 b=hjXZ1Q6znaYGZwd79q0YQMLOEavzfkveSsjx2hih0N8vtOkpqi/DpZYbyopnH6cTvs63
 DGtuywveI2Io7N6MsLzctpoZ5nB5ttqt+pO0Ir89sasmctvdoHzsqYizPYmss1V+giXL
 K89rSLPtDOm8VIQTkbEIWLIOUZXGyyBdLACFWorDhny6TiLTna1PvouYXLzJ1wb8Gd1m
 8pAOKEZXRhkFxteZEDmfktZhGDi4oVMj9sd1ddDGL8tvAbHSH+UV/TOhp89qq4cWiCSx
 yTHDUSbt1poR4zf7WFEmlsMPM7KsBGwyvTXMG2zfOhOquflXqQ01UhkuPxihw3WRtTl0 sA== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j7gvu8cb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 10:08:06 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27RA54EB003328;
        Sat, 27 Aug 2022 10:08:05 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma01fra.de.ibm.com with ESMTP id 3j7aw8r6yb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 27 Aug 2022 10:08:05 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27RA8Mto42795396
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 27 Aug 2022 10:08:22 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A6DB052051;
        Sat, 27 Aug 2022 10:08:01 +0000 (GMT)
Received: from localhost (unknown [9.171.78.213])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 4A9885204E;
        Sat, 27 Aug 2022 10:08:01 +0000 (GMT)
Date:   Sat, 27 Aug 2022 12:07:59 +0200
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.0-rc3
Message-ID: <your-ad-here.call-01661594879-ext-8999@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SdNpTUDvY4GUAJJKg9HTR1SI0qOK3fSJ
X-Proofpoint-GUID: SdNpTUDvY4GUAJJKg9HTR1SI0qOK3fSJ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-27_04,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1011 mlxscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=943 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208270040
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.0-rc3.

Thank you,
Vasily

The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-2

for you to fetch changes up to 41ac42f137080bc230b5882e3c88c392ab7f2d32:

  s390/mm: do not trigger write fault when vma does not allow VM_WRITE (2022-08-25 15:12:32 +0200)

----------------------------------------------------------------
s390 updates for 6.0-rc3

- Fix double free of guarded storage and runtime instrumentation control
  blocks on fork() failure.

- Fix triggering write fault when VMA does not allow VM_WRITE.

----------------------------------------------------------------
Brian Foster (1):
      s390: fix double free of GS and RI CBs on fork() failure

Gerald Schaefer (1):
      s390/mm: do not trigger write fault when vma does not allow VM_WRITE

 arch/s390/kernel/process.c | 22 ++++++++++++++++------
 arch/s390/mm/fault.c       |  4 +++-
 2 files changed, 19 insertions(+), 7 deletions(-)
