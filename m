Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5059ABB3
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 08:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343506AbiHTGPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 02:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiHTGP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 02:15:29 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6744AA4D5;
        Fri, 19 Aug 2022 23:15:28 -0700 (PDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27K5xfQT004628;
        Sat, 20 Aug 2022 06:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=zPAf3Y8+ic/bcR2GCV4JDBK3HcwH7lLdPNCVXZ+f3Ng=;
 b=mP9kRRmPeuQkYOQLS0C9l2vJkIMhZoxQIiXOabTo4eNIqBZ1/fEbkKyMt4BIfT+NeaQ7
 GbPgyCsRC1mHU1PvkjHmZ4ismEpbnS+HdolaMT625RauOTpyYsyo4RFK5Q/ap9iPX/lM
 bPpmng3zH5b1Jiq8glE3l5xUHZVYGoyAL0ZVUI3u285PMaND+2kWAegz0nqyTIwVSGrQ
 yo3Zw19WJShzQKruxjPBisMVxk9lGbntYLREt/XmXVOblX7Cov6d6jJJDvMmDNx/Ll+3
 48b7uUbJbswwLozAFoK9lSIldbtTeJkVnIHBmabaBBKD6Lh8HAnYLabX7Yr9852JtoHD PQ== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j2sy109jn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 06:15:27 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27K65EkJ031370;
        Sat, 20 Aug 2022 06:15:24 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma05fra.de.ibm.com with ESMTP id 3j2q8983sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 20 Aug 2022 06:15:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27K6FLZc31850960
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 20 Aug 2022 06:15:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21740A405B;
        Sat, 20 Aug 2022 06:15:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E153AA405F;
        Sat, 20 Aug 2022 06:15:20 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sat, 20 Aug 2022 06:15:20 +0000 (GMT)
Date:   Sat, 20 Aug 2022 08:15:19 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 6.0-rc2
Message-ID: <YwB792JxY0ZO7NBC@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: eLu5EHfp_uGsdstFQAVz2BWAuWA_ZWqi
X-Proofpoint-ORIG-GUID: eLu5EHfp_uGsdstFQAVz2BWAuWA_ZWqi
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-20_03,2022-08-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2207270000 definitions=main-2208200023
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 6.0-rc2.

Thank you,
Alexander

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-6.0-1

for you to fetch changes up to 0fef40be5d1f8e7af3d61e8827a63c5862cd99f7:

  s390/ap: fix crash on older machines based on QCI info missing (2022-07-15 12:23:48 +0200)

----------------------------------------------------------------
s390 updates for 6.0-rc2

- Fix a KVM crash on z12 and older machines caused by a wrong
  assumption that Query AP Configuration Information is always
  available.

- Lower severity of excessive Hypervisor filesystem error messages
  when booting under KVM.
----------------------------------------------------------------

Harald Freudenberger (1):
  s390/ap: fix crash on older machines based on QCI info missing

Juergen Gross (1):
  s390/hypfs: avoid error message under KVM

 arch/s390/hypfs/hypfs_diag.c | 2 +-
 arch/s390/hypfs/inode.c      | 2 +-
 drivers/s390/crypto/ap_bus.c | 3 +++
 drivers/s390/crypto/ap_bus.h | 4 ++++
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/hypfs/hypfs_diag.c b/arch/s390/hypfs/hypfs_diag.c
index f0bc4dc3e9bf..6511d15ace45 100644
--- a/arch/s390/hypfs/hypfs_diag.c
+++ b/arch/s390/hypfs/hypfs_diag.c
@@ -437,7 +437,7 @@ __init int hypfs_diag_init(void)
 	int rc;
 
 	if (diag204_probe()) {
-		pr_err("The hardware system does not support hypfs\n");
+		pr_info("The hardware system does not support hypfs\n");
 		return -ENODATA;
 	}
 
diff --git a/arch/s390/hypfs/inode.c b/arch/s390/hypfs/inode.c
index 5c97f48cea91..ee919bfc8186 100644
--- a/arch/s390/hypfs/inode.c
+++ b/arch/s390/hypfs/inode.c
@@ -496,9 +496,9 @@ static int __init hypfs_init(void)
 	hypfs_vm_exit();
 fail_hypfs_diag_exit:
 	hypfs_diag_exit();
+	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 fail_dbfs_exit:
 	hypfs_dbfs_exit();
-	pr_err("Initialization of hypfs failed with rc=%i\n", rc);
 	return rc;
 }
 device_initcall(hypfs_init)
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 8f1d1cf23d44..59ac98f2bd27 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -2086,6 +2086,9 @@ static inline void ap_scan_adapter(int ap)
  */
 static bool ap_get_configuration(void)
 {
+	if (!ap_qci_info)	/* QCI not supported */
+		return false;
+
 	memcpy(ap_qci_info_old, ap_qci_info, sizeof(*ap_qci_info));
 	ap_fetch_qci_info(ap_qci_info);
 
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 0c40af157df2..0f17933954fb 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -148,12 +148,16 @@ struct ap_driver {
 	/*
 	 * Called at the start of the ap bus scan function when
 	 * the crypto config information (qci) has changed.
+	 * This callback is not invoked if there is no AP
+	 * QCI support available.
 	 */
 	void (*on_config_changed)(struct ap_config_info *new_config_info,
 				  struct ap_config_info *old_config_info);
 	/*
 	 * Called at the end of the ap bus scan function when
 	 * the crypto config information (qci) has changed.
+	 * This callback is not invoked if there is no AP
+	 * QCI support available.
 	 */
 	void (*on_scan_complete)(struct ap_config_info *new_config_info,
 				 struct ap_config_info *old_config_info);
