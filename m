Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A7255985E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 13:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiFXLRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 07:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiFXLRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 07:17:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEAD44755;
        Fri, 24 Jun 2022 04:17:47 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OB7OYb021930;
        Fri, 24 Jun 2022 11:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=y+/TB3VLTQUoExLIGSbsG6DcwaZ7QmUtaM15JyJhDUw=;
 b=b5BJj8wldx7xFUqkFSG4u0gNqP249CZEKbT0qaOrJqvD5wVk6Re9Y9iDy9OBIWngqpqi
 N0l415bXSZh9Vg6BA/zO7rvHB7eVwW6nbYPaJnwiVZfi67zMMLzos0ddjFLMRmwt3vMG
 PDBxvgx0xqeDsggKd8xHNnnTF66c98/2DMggeauy+9EFgjVHcACMp2ZzcZtW6Ksf60JH
 BxGkBCOVvKQBkoAwYYP5ZyVvCsh4EnnUebKuv3J6Mfxh78tpLv8ppj7vLwkSRh5wdyY9
 LdCLU4LrvLr0QkptRN5ysp9jlbv75tU07ndU6jd832zEmH3V+/VX/MTdLbxEZF3EtwV1 vw== 
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3gwajc2k6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 11:17:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 25OB6ODL010181;
        Fri, 24 Jun 2022 11:17:43 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma06fra.de.ibm.com with ESMTP id 3gs5yj6ygq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 11:17:43 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 25OBGnMi20578714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jun 2022 11:16:49 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3029CA404D;
        Fri, 24 Jun 2022 11:17:40 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EE6F8A4040;
        Fri, 24 Jun 2022 11:17:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Fri, 24 Jun 2022 11:17:39 +0000 (GMT)
Date:   Fri, 24 Jun 2022 13:17:38 +0200
From:   Alexander Gordeev <agordeev@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] s390 updates for 5.19-rc4
Message-ID: <YrWdUgyjZL10zE2Q@tuxmaker.boeblingen.de.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: CeTTPlKOC66MdeqIMH3PgxR6hYbCBRDA
X-Proofpoint-GUID: CeTTPlKOC66MdeqIMH3PgxR6hYbCBRDA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_07,2022-06-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 malwarescore=0 clxscore=1015 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206240044
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

please pull s390 changes for 5.19-rc4.

Thank you,
Alexander

The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:

  Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.19-4

for you to fetch changes up to 21e876448792af2dd5261338907c72bdf37fa056

  s390/pai: Fix multiple concurrent event installation (2022-06-15 14:02:07 +0200)

----------------------------------------------------------------
s390 updates for 5.19-rc4

- Fix perf stat accounting for cryptography counters when multiple
  events are installed concurrently.

- Prevent installation of unsupported perf events for cryptography
  counters.

- Treat perf events cpum_cf/CPU_CYCLES/ and cpu_cf/INSTRUCTIONS/
  identical to basic events CPU_CYCLES" and INSTRUCTIONS, since
  they address the same hardware.

- Restore kcrash operation which was broken by commit 5d8de293c224
  ("vmcore: convert copy_oldmem_page() to take an iov_iter").

----------------------------------------------------------------
Alexander Gordeev (2):
  s390/crash: add missing iterator advance in copy_oldmem_page()
  s390/crash: make copy_oldmem_page() return number of bytes copied

Thomas Richter (3):
  s390/cpumf: Handle events cycles and instructions identical
  s390/pai: Prevent invalid event number for pai_crypto PMU
  s390/pai: Fix multiple concurrent event installation

 arch/s390/kernel/crash_dump.c      | 10 +++++++++-
 arch/s390/kernel/perf_cpum_cf.c    | 22 +++++++++++++++++++++-
 arch/s390/kernel/perf_pai_crypto.c | 20 +++++++++++++++-----
 3 files changed, 45 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index a2c1c55daec0..28124d0fa1d5 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -219,6 +219,11 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
 	unsigned long src;
 	int rc;
 
+	if (!(iter_is_iovec(iter) || iov_iter_is_kvec(iter)))
+		return -EINVAL;
+	/* Multi-segment iterators are not supported */
+	if (iter->nr_segs > 1)
+		return -EINVAL;
 	if (!csize)
 		return 0;
 	src = pfn_to_phys(pfn) + offset;
@@ -228,7 +233,10 @@ ssize_t copy_oldmem_page(struct iov_iter *iter, unsigned long pfn, size_t csize,
 		rc = copy_oldmem_user(iter->iov->iov_base, src, csize);
 	else
 		rc = copy_oldmem_kernel(iter->kvec->iov_base, src, csize);
-	return rc;
+	if (rc < 0)
+		return rc;
+	iov_iter_advance(iter, csize);
+	return csize;
 }
 
 /*
diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 483ab5e10164..f7dd3c849e68 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -516,6 +516,26 @@ static int __hw_perf_event_init(struct perf_event *event, unsigned int type)
 	return err;
 }
 
+/* Events CPU_CYLCES and INSTRUCTIONS can be submitted with two different
+ * attribute::type values:
+ * - PERF_TYPE_HARDWARE:
+ * - pmu->type:
+ * Handle both type of invocations identical. They address the same hardware.
+ * The result is different when event modifiers exclude_kernel and/or
+ * exclude_user are also set.
+ */
+static int cpumf_pmu_event_type(struct perf_event *event)
+{
+	u64 ev = event->attr.config;
+
+	if (cpumf_generic_events_basic[PERF_COUNT_HW_CPU_CYCLES] == ev ||
+	    cpumf_generic_events_basic[PERF_COUNT_HW_INSTRUCTIONS] == ev ||
+	    cpumf_generic_events_user[PERF_COUNT_HW_CPU_CYCLES] == ev ||
+	    cpumf_generic_events_user[PERF_COUNT_HW_INSTRUCTIONS] == ev)
+		return PERF_TYPE_HARDWARE;
+	return PERF_TYPE_RAW;
+}
+
 static int cpumf_pmu_event_init(struct perf_event *event)
 {
 	unsigned int type = event->attr.type;
@@ -525,7 +545,7 @@ static int cpumf_pmu_event_init(struct perf_event *event)
 		err = __hw_perf_event_init(event, type);
 	else if (event->pmu->type == type)
 		/* Registered as unknown PMU */
-		err = __hw_perf_event_init(event, PERF_TYPE_RAW);
+		err = __hw_perf_event_init(event, cpumf_pmu_event_type(event));
 	else
 		return -ENOENT;
 
diff --git a/arch/s390/kernel/perf_pai_crypto.c b/arch/s390/kernel/perf_pai_crypto.c
index 8c1545946d85..b38b4ae01589 100644
--- a/arch/s390/kernel/perf_pai_crypto.c
+++ b/arch/s390/kernel/perf_pai_crypto.c
@@ -193,8 +193,9 @@ static int paicrypt_event_init(struct perf_event *event)
 	/* PAI crypto PMU registered as PERF_TYPE_RAW, check event type */
 	if (a->type != PERF_TYPE_RAW && event->pmu->type != a->type)
 		return -ENOENT;
-	/* PAI crypto event must be valid */
-	if (a->config > PAI_CRYPTO_BASE + paicrypt_cnt)
+	/* PAI crypto event must be in valid range */
+	if (a->config < PAI_CRYPTO_BASE ||
+	    a->config > PAI_CRYPTO_BASE + paicrypt_cnt)
 		return -EINVAL;
 	/* Allow only CPU wide operation, no process context for now. */
 	if (event->hw.target || event->cpu == -1)
@@ -208,6 +209,12 @@ static int paicrypt_event_init(struct perf_event *event)
 	if (rc)
 		return rc;
 
+	/* Event initialization sets last_tag to 0. When later on the events
+	 * are deleted and re-added, do not reset the event count value to zero.
+	 * Events are added, deleted and re-added when 2 or more events
+	 * are active at the same time.
+	 */
+	event->hw.last_tag = 0;
 	cpump->event = event;
 	event->destroy = paicrypt_event_destroy;
 
@@ -242,9 +249,12 @@ static void paicrypt_start(struct perf_event *event, int flags)
 {
 	u64 sum;
 
-	sum = paicrypt_getall(event);		/* Get current value */
-	local64_set(&event->hw.prev_count, sum);
-	local64_set(&event->count, 0);
+	if (!event->hw.last_tag) {
+		event->hw.last_tag = 1;
+		sum = paicrypt_getall(event);		/* Get current value */
+		local64_set(&event->count, 0);
+		local64_set(&event->hw.prev_count, sum);
+	}
 }
 
 static int paicrypt_add(struct perf_event *event, int flags)
