Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5705366CD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 20:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351836AbiE0SAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 14:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353462AbiE0SAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 14:00:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0AF5044C
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 11:00:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RGA4KE007173;
        Fri, 27 May 2022 17:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2021-07-09;
 bh=GwnebTzOd5wOseRW/GGVCpRp/qP0tcU6Vg3nLISbrpI=;
 b=dBeVkQgnGItGMNHBJL0tjsELF0e8bXbIOqUVfyOImmsOCfxgThk+2JuKYK7JS5vm702S
 QprPYaXZ6F2iOFs7u9Vz5NfFMfHD3p8Yv7gyLKWJFbeErlIp3X+C+EwlkIgXdAU7nZL/
 StXbY81etx7TS19rhA5gP4hRKF1PONehdsrAdMEeyglVncgk5J/QsFTRZTHEgjx6hF5M
 bZzI1vqOrGwnrNKCoQTOhAQXzc41jjFILuiR6extRG640ZMSA5nRmW1hU/f/35MrBvqF
 uZEfrJrl3ORTamL52r+iaC7TNxXn7Lk67u9eblY4pMPVGB876b2Z9vBwdZxNthfAD8S8 Pw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3g93tdyqhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 May 2022 17:59:15 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24RHo4Sm007602;
        Fri, 27 May 2022 17:59:14 GMT
Received: from bostrovs-us.us.oracle.com (bostrovs-us.us.oracle.com [10.152.12.19])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3g93x1xpnr-1;
        Fri, 27 May 2022 17:59:14 +0000
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, sstabellini@kernel.org,
        oleksandr_tyshchenko@epam.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com
Subject: [PATCH] MAINTAINERS: Update Xen maintainership
Date:   Fri, 27 May 2022 13:57:05 -0400
Message-Id: <1653674225-10447-1-git-send-email-boris.ostrovsky@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.874
 definitions=2022-05-27_05:2022-05-27,2022-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2205270087
X-Proofpoint-GUID: QhWoUm9D1nSCVjvVtXBiIk70L5n3x3dH
X-Proofpoint-ORIG-GUID: QhWoUm9D1nSCVjvVtXBiIk70L5n3x3dH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to time constraints I am stepping down as maintainter. I will stay
as reviewer for x86 code (for which create a separate category).

Stefano is now maintainer for Xen hypervisor interface and Oleksandr has
graciously agreed to become a reviewer.

Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
---
 MAINTAINERS | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6d879cb0afd..b879c4e6750e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21549,23 +21549,29 @@ F:	arch/arm64/include/asm/xen/
 F:	arch/arm64/xen/
 
 XEN HYPERVISOR INTERFACE
-M:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
 M:	Juergen Gross <jgross@suse.com>
-R:	Stefano Stabellini <sstabellini@kernel.org>
+M:	Stefano Stabellini <sstabellini@kernel.org>
+R:	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
 L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip.git
 F:	Documentation/ABI/stable/sysfs-hypervisor-xen
 F:	Documentation/ABI/testing/sysfs-hypervisor-xen
-F:	arch/x86/include/asm/pvclock-abi.h
-F:	arch/x86/include/asm/xen/
-F:	arch/x86/platform/pvh/
-F:	arch/x86/xen/
 F:	drivers/*/xen-*front.c
 F:	drivers/xen/
 F:	include/uapi/xen/
 F:	include/xen/
 
+XEN HYPERVISOR X86
+M:	Juergen Gross <jgross@suse.com>
+R:	Boris Ostrovsky <boris.ostrovsky@oracle.com>
+L:	xen-devel@lists.xenproject.org (moderated for non-subscribers)
+S:	Supported
+F:	arch/x86/include/asm/pvclock-abi.h
+F:	arch/x86/include/asm/xen/
+F:	arch/x86/platform/pvh/
+F:	arch/x86/xen/
+
 XEN NETWORK BACKEND DRIVER
 M:	Wei Liu <wei.liu@kernel.org>
 M:	Paul Durrant <paul@xen.org>
-- 
1.8.3.1

