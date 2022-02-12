Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED754B34C4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:44:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbiBLLop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:44:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiBLLom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:44:42 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8048626AD4;
        Sat, 12 Feb 2022 03:44:39 -0800 (PST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21C9vf1G032620;
        Sat, 12 Feb 2022 11:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=/0i+ZkumCuw7l750dUX0MCbyV6L+zIkPOoRsbv3am4s=;
 b=V6QM05LQWxdJCm1yrGrvE72c52zBwVlsQY+zLjJOpjmr0s3Sy9yxGsgil5GJPevUo4Ei
 0lmlAnPSe0sqGTVDbA4UN9AxiFQGrEoCDInfuTDBeRqG7+QpMw93xXK98umEGow5h6ul
 KghPEFw5SNrWDQz/4mO/hrxo/USES/OXUNHAvPN3MF4Q4f5t4+MzXNxUdAEtOU4JS04t
 2NMci02CtgcaxjUhDYMgNzZUCaNgRVid9JSxFFu7J6EaM9DJlG24BDKybh2AxoxXAFYh
 k6BOljnbVyYKG5iExnMtHGGaIB9Ty2chsyPa0qKX8ZhcZC6s803+DcZPgvBHWk/v0zJD vw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e6a9h9v2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Feb 2022 11:44:37 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21CBh8n0001790;
        Sat, 12 Feb 2022 11:44:35 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3e64h99yc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Feb 2022 11:44:35 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21CBiWtO45875544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Feb 2022 11:44:32 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5BB384C046;
        Sat, 12 Feb 2022 11:44:32 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15DEC4C040;
        Sat, 12 Feb 2022 11:44:32 +0000 (GMT)
Received: from localhost (unknown [9.171.57.218])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 12 Feb 2022 11:44:32 +0000 (GMT)
Date:   Sat, 12 Feb 2022 12:44:30 +0100
From:   Vasily Gorbik <gor@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.17-rc4
Message-ID: <your-ad-here.call-01644666270-ext-6500@work.hours>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: f_Z4JoK9AtEUm-VtL3kWyC66hvSYRVMt
X-Proofpoint-ORIG-GUID: f_Z4JoK9AtEUm-VtL3kWyC66hvSYRVMt
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-12_04,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 mlxscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202120069
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

please pull s390 changes for 5.17-rc4.

Thank you,
Vasily

The following changes since commit dfd42facf1e4ada021b939b4e19c935dcdd55566:

  Linux 5.17-rc3 (2022-02-06 12:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-4

for you to fetch changes up to dd9cb842fa9d90653a9b48aba52f89c069f3bc50:

  s390/cio: verify the driver availability for path_event call (2022-02-09 22:55:01 +0100)

----------------------------------------------------------------
s390 updates for 5.17-rc4

- Maintainers and reviewers changes:
  - Add Alexander Gordeev as maintainer for s390.
  - Christian Borntraeger will focus on s390 KVM maintainership and
    stays as s390 reviewer.

- Fix clang build of modules loader KUnit test.

- Fix kernel panic in CIO code on FCES path-event when no driver is
  attached to a device or the driver does not provide the path_event
  function.

----------------------------------------------------------------
Christian Borntraeger (1):
      MAINTAINERS: downgrade myself to Reviewer for s390

Heiko Carstens (1):
      MAINTAINERS: add Alexander Gordeev as maintainer for s390

Ilya Leoshkevich (1):
      s390/module: fix building test_modules_helpers.o with clang

Vineeth Vijayan (1):
      s390/cio: verify the driver availability for path_event call

 MAINTAINERS                  | 4 ++--
 arch/s390/lib/test_modules.c | 3 ---
 arch/s390/lib/test_modules.h | 3 +++
 drivers/s390/cio/device.c    | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69a2935daf6c..5c56a172ce11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16817,8 +16817,8 @@ F:	drivers/video/fbdev/savage/
 S390
 M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
-M:	Christian Borntraeger <borntraeger@linux.ibm.com>
-R:	Alexander Gordeev <agordeev@linux.ibm.com>
+M:	Alexander Gordeev <agordeev@linux.ibm.com>
+R:	Christian Borntraeger <borntraeger@linux.ibm.com>
 R:	Sven Schnelle <svens@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
diff --git a/arch/s390/lib/test_modules.c b/arch/s390/lib/test_modules.c
index d056baa8fbb0..9894009fc1f2 100644
--- a/arch/s390/lib/test_modules.c
+++ b/arch/s390/lib/test_modules.c
@@ -5,9 +5,6 @@
 
 #include "test_modules.h"
 
-#define DECLARE_RETURN(i) int test_modules_return_ ## i(void)
-REPEAT_10000(DECLARE_RETURN);
-
 /*
  * Test that modules with many relocations are loaded properly.
  */
diff --git a/arch/s390/lib/test_modules.h b/arch/s390/lib/test_modules.h
index 43b5e4b4af3e..6371fcf17684 100644
--- a/arch/s390/lib/test_modules.h
+++ b/arch/s390/lib/test_modules.h
@@ -47,4 +47,7 @@
 	__REPEAT_10000_1(f, 8); \
 	__REPEAT_10000_1(f, 9)
 
+#define DECLARE_RETURN(i) int test_modules_return_ ## i(void)
+REPEAT_10000(DECLARE_RETURN);
+
 #endif
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index cd938a26b76c..3b1cd0c96a74 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1180,7 +1180,7 @@ static int io_subchannel_chp_event(struct subchannel *sch,
 			else
 				path_event[chpid] = PE_NONE;
 		}
-		if (cdev)
+		if (cdev && cdev->drv && cdev->drv->path_event)
 			cdev->drv->path_event(cdev, path_event);
 		break;
 	}
