Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AEC463431
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 13:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241555AbhK3M3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 07:29:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39996 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241511AbhK3M3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 07:29:38 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAkebj001356;
        Tue, 30 Nov 2021 12:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=0mLcwm7NE5xe6OWQ4DJ3YuoMUMJXHNNFA+ZPNE5dG7Y=;
 b=AzUvUM4vd2BJpgaUnOyzAQsM2k+gFdAGjXFWLIDirYMULAhK8bAe1Up1W+peu70hZn87
 bi1vMugmgNbk0M7WXiVXEwF44d8Hqj3fnhMzcGY7PMxhVxhS6hw9U9KD6LmJd0gRSkcC
 Dsn2Cm8Dm2GOobruo97UecoRmmcEQSfsujHqfNdmzJ3hZdz+LCfw/mfD5oOZ2tLswfwH
 VMsaFjKGxeykXphdwaklIGOoSzObwhR6Ny1rgvPe2mqKFmipOng8IGG5MrpB6Ge9Tzyh
 OJvGoqszH+BFlSocvsw1AA3/YsYe0LCLs01j1N5UDEDcuPUPEL709FSEAbGRKMdmkAVE EQ== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3cnjgj9y9f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 12:25:50 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1AUCCoaA032456;
        Tue, 30 Nov 2021 12:25:49 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3ckbxjn7k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Nov 2021 12:25:48 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1AUCPkAV10879366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 12:25:46 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8577BAE051;
        Tue, 30 Nov 2021 12:25:46 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 477F5AE053;
        Tue, 30 Nov 2021 12:25:46 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 30 Nov 2021 12:25:46 +0000 (GMT)
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Egorenkov <egorenar@linux.ibm.com>
Subject: [PATCH] selftests/ftrace: make kprobe profile testcase description unique
Date:   Tue, 30 Nov 2021 13:25:46 +0100
Message-Id: <20211130122546.3622291-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: llRz0af-O1qRuMdIy5YeYwZWJU-5hfNl
X-Proofpoint-ORIG-GUID: llRz0af-O1qRuMdIy5YeYwZWJU-5hfNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0 spamscore=0
 impostorscore=0 clxscore=1011 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111300069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 32f6e5da83c7 ("selftests/ftrace: Add kprobe profile testcase")
added a new kprobes testcase, but has a description which does not
describe what the test case is doing and is duplicating the desription
of another test case.
Therefore change the test case description, so it is unique and then
allows easily to tell which test case actually passed or failed.

Reported-by: Alexander Egorenkov <egorenar@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 tools/testing/selftests/ftrace/test.d/kprobe/profile.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
index 98166fa3eb91..34fb89b0c61f 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/profile.tc
@@ -1,6 +1,6 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: Kprobe dynamic event - adding and removing
+# description: Kprobe profile
 # requires: kprobe_events
 
 ! grep -q 'myevent' kprobe_profile
-- 
2.32.0

