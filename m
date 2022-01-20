Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D897F495480
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 19:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377371AbiATS4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 13:56:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59364 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243589AbiATS4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:56:37 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20KGlKcE003584;
        Thu, 20 Jan 2022 18:56:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : content-type : mime-version; s=pp1;
 bh=22MMfvhDv/p8elG4TvqL0ISdKjmfjsOimXfBKYoEyO0=;
 b=ceop1Iiylvi6RB/OYsVk4TWbJkB8o1dc4moCbLtGn99lQU0pCEUQXYp4aU3B3p0ebQ/G
 mmzs6d9Svn+SRHA+m7YQn1nIOtQXsogMxHjLbUolSMzv5ulu0lfITLLPPMRgTrKpYWGQ
 +JRAeYkXazp6VStPisuiqAIEzzyrH0lD9oaFatsr7eHdUtvfhWxBELB+BcT+/E0C5oTv
 grJIaH51jgZbV+My4DgBPJgADxb3HSHlWneFYgt0B0p9M5M6T9NJtpptjEUhHfDBAugB
 Uk7wZttUfhiDX4qdOUfysFXkREJPAtjgMb57OgLxmLQlBnmLs2r4P5KJeKyaa1kFfMY/ WQ== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dqbjman35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 18:56:35 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20KIrqK7016657;
        Thu, 20 Jan 2022 18:56:33 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 3dknwa23xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Jan 2022 18:56:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20KIuUdA42992020
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Jan 2022 18:56:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 125C8A4055;
        Thu, 20 Jan 2022 18:56:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8EB6A405D;
        Thu, 20 Jan 2022 18:56:29 +0000 (GMT)
Received: from osiris (unknown [9.145.85.126])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu, 20 Jan 2022 18:56:29 +0000 (GMT)
Date:   Thu, 20 Jan 2022 19:56:28 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] more s390 updates for 5.17 merge window
Message-ID: <YemwXCXL/21UedM6@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: tehzt8EDD5ejNWlAHAwE0hxM0WTSiSSi
X-Proofpoint-ORIG-GUID: tehzt8EDD5ejNWlAHAwE0hxM0WTSiSSi
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_07,2022-01-20_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201200092
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull more s390 updates for 5.17 merge window.

Thanks,
Heiko

The following changes since commit f0d43b3a3809f280806825df2454fd83f71874c4:

  Merge tag 's390-5.17-1' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2022-01-10 08:58:16 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.17-2

for you to fetch changes up to 5754f9084f261f6fbfdcc6e57dae97c86a6ff688:

  s390: add Sven Schnelle as reviewer (2022-01-17 14:13:09 +0100)

----------------------------------------------------------------
more s390 updates for 5.17 merge window

- add Sven Schnelle as reviewer for s390 code

- make uaccess code more readable

- change cpu measurement facility code to also support counter second
  version number 7, and add discard support for limited samples

----------------------------------------------------------------
Heiko Carstens (1):
      s390: add Sven Schnelle as reviewer

Nico Boehr (1):
      s390/uaccess: introduce bit field for OAC specifier

Thomas Richter (2):
      s390/cpumf: Support for CPU Measurement Facility CSVN 7
      s390/cpumf: Support for CPU Measurement Sampling Facility LS bit

 MAINTAINERS                            |   1 +
 arch/s390/include/asm/cpu_mf.h         |   4 +-
 arch/s390/include/asm/uaccess.h        | 120 +++++++++++++++++++++------------
 arch/s390/kernel/perf_cpum_cf_common.c |   4 +-
 arch/s390/kernel/perf_cpum_cf_events.c |   6 +-
 arch/s390/kernel/perf_cpum_sf.c        |   2 +-
 arch/s390/lib/uaccess.c                |  24 +++++--
 7 files changed, 105 insertions(+), 56 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1f7658bab9e7..253abb28795b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16611,6 +16611,7 @@ M:	Heiko Carstens <hca@linux.ibm.com>
 M:	Vasily Gorbik <gor@linux.ibm.com>
 M:	Christian Borntraeger <borntraeger@linux.ibm.com>
 R:	Alexander Gordeev <agordeev@linux.ibm.com>
+R:	Sven Schnelle <svens@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
 W:	http://www.ibm.com/developerworks/linux/linux390/
diff --git a/arch/s390/include/asm/cpu_mf.h b/arch/s390/include/asm/cpu_mf.h
index 0d90cbeb89b4..e3f12db46cfc 100644
--- a/arch/s390/include/asm/cpu_mf.h
+++ b/arch/s390/include/asm/cpu_mf.h
@@ -109,7 +109,9 @@ struct hws_basic_entry {
 	unsigned int AS:2;	    /* 29-30 PSW address-space control	 */
 	unsigned int I:1;	    /* 31 entry valid or invalid	 */
 	unsigned int CL:2;	    /* 32-33 Configuration Level	 */
-	unsigned int:14;
+	unsigned int H:1;	    /* 34 Host Indicator		 */
+	unsigned int LS:1;	    /* 35 Limited Sampling		 */
+	unsigned int:12;
 	unsigned int prim_asn:16;   /* primary ASN			 */
 	unsigned long long ia;	    /* Instruction Address		 */
 	unsigned long long gpp;     /* Guest Program Parameter		 */
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index ce550d06abc3..147cb3534ce4 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -49,51 +49,85 @@ int __get_user_bad(void) __attribute__((noreturn));
 
 #ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
 
-#define __put_get_user_asm(to, from, size, insn)		\
-({								\
-	int __rc;						\
-								\
-	asm volatile(						\
-		insn "		0,%[spec]\n"			\
-		"0:	mvcos	%[_to],%[_from],%[_size]\n"	\
-		"1:	xr	%[rc],%[rc]\n"			\
-		"2:\n"						\
-		".pushsection .fixup, \"ax\"\n"			\
-		"3:	lhi	%[rc],%[retval]\n"		\
-		"	jg	2b\n"				\
-		".popsection\n"					\
-		EX_TABLE(0b,3b) EX_TABLE(1b,3b)			\
-		: [rc] "=&d" (__rc), [_to] "+Q" (*(to))		\
-		: [_size] "d" (size), [_from] "Q" (*(from)),	\
-		  [retval] "K" (-EFAULT), [spec] "K" (0x81UL)	\
-		: "cc", "0");					\
-	__rc;							\
+union oac {
+	unsigned int val;
+	struct {
+		struct {
+			unsigned short key : 4;
+			unsigned short	   : 4;
+			unsigned short as  : 2;
+			unsigned short	   : 4;
+			unsigned short k   : 1;
+			unsigned short a   : 1;
+		} oac1;
+		struct {
+			unsigned short key : 4;
+			unsigned short	   : 4;
+			unsigned short as  : 2;
+			unsigned short	   : 4;
+			unsigned short k   : 1;
+			unsigned short a   : 1;
+		} oac2;
+	};
+};
+
+#define __put_get_user_asm(to, from, size, oac_spec)			\
+({									\
+	int __rc;							\
+									\
+	asm volatile(							\
+		"	lr	0,%[spec]\n"				\
+		"0:	mvcos	%[_to],%[_from],%[_size]\n"		\
+		"1:	xr	%[rc],%[rc]\n"				\
+		"2:\n"							\
+		".pushsection .fixup, \"ax\"\n"				\
+		"3:	lhi	%[rc],%[retval]\n"			\
+		"	jg	2b\n"					\
+		".popsection\n"						\
+		EX_TABLE(0b,3b) EX_TABLE(1b,3b)				\
+		: [rc] "=&d" (__rc), [_to] "+Q" (*(to))			\
+		: [_size] "d" (size), [_from] "Q" (*(from)),		\
+		  [retval] "K" (-EFAULT), [spec] "d" (oac_spec.val)	\
+		: "cc", "0");						\
+	__rc;								\
 })
 
+#define __put_user_asm(to, from, size)				\
+	__put_get_user_asm(to, from, size, ((union oac) {	\
+		.oac1.as = PSW_BITS_AS_SECONDARY,		\
+		.oac1.a = 1					\
+	}))
+
+#define __get_user_asm(to, from, size)				\
+	__put_get_user_asm(to, from, size, ((union oac) {	\
+		.oac2.as = PSW_BITS_AS_SECONDARY,		\
+		.oac2.a = 1					\
+	}))							\
+
 static __always_inline int __put_user_fn(void *x, void __user *ptr, unsigned long size)
 {
 	int rc;
 
 	switch (size) {
 	case 1:
-		rc = __put_get_user_asm((unsigned char __user *)ptr,
-					(unsigned char *)x,
-					size, "llilh");
+		rc = __put_user_asm((unsigned char __user *)ptr,
+				    (unsigned char *)x,
+				    size);
 		break;
 	case 2:
-		rc = __put_get_user_asm((unsigned short __user *)ptr,
-					(unsigned short *)x,
-					size, "llilh");
+		rc = __put_user_asm((unsigned short __user *)ptr,
+				    (unsigned short *)x,
+				    size);
 		break;
 	case 4:
-		rc = __put_get_user_asm((unsigned int __user *)ptr,
-					(unsigned int *)x,
-					size, "llilh");
+		rc = __put_user_asm((unsigned int __user *)ptr,
+				    (unsigned int *)x,
+				    size);
 		break;
 	case 8:
-		rc = __put_get_user_asm((unsigned long __user *)ptr,
-					(unsigned long *)x,
-					size, "llilh");
+		rc = __put_user_asm((unsigned long __user *)ptr,
+				    (unsigned long *)x,
+				    size);
 		break;
 	default:
 		__put_user_bad();
@@ -108,24 +142,24 @@ static __always_inline int __get_user_fn(void *x, const void __user *ptr, unsign
 
 	switch (size) {
 	case 1:
-		rc = __put_get_user_asm((unsigned char *)x,
-					(unsigned char __user *)ptr,
-					size, "lghi");
+		rc = __get_user_asm((unsigned char *)x,
+				    (unsigned char __user *)ptr,
+				    size);
 		break;
 	case 2:
-		rc = __put_get_user_asm((unsigned short *)x,
-					(unsigned short __user *)ptr,
-					size, "lghi");
+		rc = __get_user_asm((unsigned short *)x,
+				    (unsigned short __user *)ptr,
+				    size);
 		break;
 	case 4:
-		rc = __put_get_user_asm((unsigned int *)x,
-					(unsigned int __user *)ptr,
-					size, "lghi");
+		rc = __get_user_asm((unsigned int *)x,
+				    (unsigned int __user *)ptr,
+				    size);
 		break;
 	case 8:
-		rc = __put_get_user_asm((unsigned long *)x,
-					(unsigned long __user *)ptr,
-					size, "lghi");
+		rc = __get_user_asm((unsigned long *)x,
+				    (unsigned long __user *)ptr,
+				    size);
 		break;
 	default:
 		__get_user_bad();
diff --git a/arch/s390/kernel/perf_cpum_cf_common.c b/arch/s390/kernel/perf_cpum_cf_common.c
index 30f0242de4a5..8ee48672233f 100644
--- a/arch/s390/kernel/perf_cpum_cf_common.c
+++ b/arch/s390/kernel/perf_cpum_cf_common.c
@@ -178,7 +178,7 @@ size_t cpum_cf_ctrset_size(enum cpumf_ctr_set ctrset,
 	case CPUMF_CTR_SET_CRYPTO:
 		if (info->csvn >= 1 && info->csvn <= 5)
 			ctrset_size = 16;
-		else if (info->csvn == 6)
+		else if (info->csvn == 6 || info->csvn == 7)
 			ctrset_size = 20;
 		break;
 	case CPUMF_CTR_SET_EXT:
@@ -188,7 +188,7 @@ size_t cpum_cf_ctrset_size(enum cpumf_ctr_set ctrset,
 			ctrset_size = 48;
 		else if (info->csvn >= 3 && info->csvn <= 5)
 			ctrset_size = 128;
-		else if (info->csvn == 6)
+		else if (info->csvn == 6 || info->csvn == 7)
 			ctrset_size = 160;
 		break;
 	case CPUMF_CTR_SET_MT_DIAG:
diff --git a/arch/s390/kernel/perf_cpum_cf_events.c b/arch/s390/kernel/perf_cpum_cf_events.c
index 37265f551a11..52c1fe23b823 100644
--- a/arch/s390/kernel/perf_cpum_cf_events.c
+++ b/arch/s390/kernel/perf_cpum_cf_events.c
@@ -344,7 +344,7 @@ static struct attribute *cpumcf_svn_12345_pmu_event_attr[] __initdata = {
 	NULL,
 };
 
-static struct attribute *cpumcf_svn_6_pmu_event_attr[] __initdata = {
+static struct attribute *cpumcf_svn_67_pmu_event_attr[] __initdata = {
 	CPUMF_EVENT_PTR(cf_svn_12345, PRNG_FUNCTIONS),
 	CPUMF_EVENT_PTR(cf_svn_12345, PRNG_CYCLES),
 	CPUMF_EVENT_PTR(cf_svn_12345, PRNG_BLOCKED_FUNCTIONS),
@@ -715,8 +715,8 @@ __init const struct attribute_group **cpumf_cf_event_group(void)
 	case 1 ... 5:
 		csvn = cpumcf_svn_12345_pmu_event_attr;
 		break;
-	case 6:
-		csvn = cpumcf_svn_6_pmu_event_attr;
+	case 6 ... 7:
+		csvn = cpumcf_svn_67_pmu_event_attr;
 		break;
 	default:
 		csvn = none;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index db62def4ef28..332a49965130 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1179,7 +1179,7 @@ static void hw_collect_samples(struct perf_event *event, unsigned long *sdbt,
 	sample = (struct hws_basic_entry *) *sdbt;
 	while ((unsigned long *) sample < (unsigned long *) te) {
 		/* Check for an empty sample */
-		if (!sample->def)
+		if (!sample->def || sample->LS)
 			break;
 
 		/* Update perf event period */
diff --git a/arch/s390/lib/uaccess.c b/arch/s390/lib/uaccess.c
index a596e69d3c47..8a5d21461889 100644
--- a/arch/s390/lib/uaccess.c
+++ b/arch/s390/lib/uaccess.c
@@ -62,10 +62,14 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
 						 unsigned long size)
 {
 	unsigned long tmp1, tmp2;
+	union oac spec = {
+		.oac2.as = PSW_BITS_AS_SECONDARY,
+		.oac2.a = 1,
+	};
 
 	tmp1 = -4096UL;
 	asm volatile(
-		"   lghi  0,%[spec]\n"
+		"   lr	  0,%[spec]\n"
 		"0: .insn ss,0xc80000000000,0(%0,%2),0(%1),0\n"
 		"6: jz    4f\n"
 		"1: algr  %0,%3\n"
@@ -84,7 +88,7 @@ static inline unsigned long copy_from_user_mvcos(void *x, const void __user *ptr
 		"5:\n"
 		EX_TABLE(0b,2b) EX_TABLE(3b,5b) EX_TABLE(6b,2b) EX_TABLE(7b,5b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: [spec] "K" (0x81UL)
+		: [spec] "d" (spec.val)
 		: "cc", "memory", "0");
 	return size;
 }
@@ -135,10 +139,14 @@ static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
 					       unsigned long size)
 {
 	unsigned long tmp1, tmp2;
+	union oac spec = {
+		.oac1.as = PSW_BITS_AS_SECONDARY,
+		.oac1.a = 1,
+	};
 
 	tmp1 = -4096UL;
 	asm volatile(
-		"   llilh 0,%[spec]\n"
+		"   lr	  0,%[spec]\n"
 		"0: .insn ss,0xc80000000000,0(%0,%1),0(%2),0\n"
 		"6: jz    4f\n"
 		"1: algr  %0,%3\n"
@@ -157,7 +165,7 @@ static inline unsigned long copy_to_user_mvcos(void __user *ptr, const void *x,
 		"5:\n"
 		EX_TABLE(0b,2b) EX_TABLE(3b,5b) EX_TABLE(6b,2b) EX_TABLE(7b,5b)
 		: "+a" (size), "+a" (ptr), "+a" (x), "+a" (tmp1), "=a" (tmp2)
-		: [spec] "K" (0x81UL)
+		: [spec] "d" (spec.val)
 		: "cc", "memory", "0");
 	return size;
 }
@@ -207,10 +215,14 @@ EXPORT_SYMBOL(raw_copy_to_user);
 static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size)
 {
 	unsigned long tmp1, tmp2;
+	union oac spec = {
+		.oac1.as = PSW_BITS_AS_SECONDARY,
+		.oac1.a = 1,
+	};
 
 	tmp1 = -4096UL;
 	asm volatile(
-		"   llilh 0,%[spec]\n"
+		"   lr	  0,%[spec]\n"
 		"0: .insn ss,0xc80000000000,0(%0,%1),0(%4),0\n"
 		"   jz	  4f\n"
 		"1: algr  %0,%2\n"
@@ -228,7 +240,7 @@ static inline unsigned long clear_user_mvcos(void __user *to, unsigned long size
 		"5:\n"
 		EX_TABLE(0b,2b) EX_TABLE(3b,5b)
 		: "+a" (size), "+a" (to), "+a" (tmp1), "=a" (tmp2)
-		: "a" (empty_zero_page), [spec] "K" (0x81UL)
+		: "a" (empty_zero_page), [spec] "d" (spec.val)
 		: "cc", "memory", "0");
 	return size;
 }
