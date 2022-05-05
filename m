Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD97F51C862
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384523AbiEESvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384735AbiEESut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA31334
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:47:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245HnBqu026132;
        Thu, 5 May 2022 18:46:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=gZ3p8DhzxO0W8r0rFIuniDxHiilMlBf8tYXAVPlI8P9sE11QGSXeJv9MfymeTEGvtAN8
 s2krzFotGtv+gYHUj0fGz0BO1lM86puowftZbP5i1h0uKKNopyo3Z4XuTIOSYRN8c5ab
 063aZJ/XgJOkkXiLAUZfau+TzviOihWNCQnlM2AjGevyQy2uNfmVSOmO/mBzNOmRHCbL
 zHjuULif7pqKlAL38bknQ+foou66OxfDFlrpMsvX+jHaSyhIFpglEpkVnbxaraJRPn57
 Dr2cUAvz9u1yIjHVt3sloNovhgopX0LSQnpgFlWR7qpDu+OHM+zz/cYvQpnkPJzeF7LF /Q== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhcc092-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245Ijb5r016833;
        Thu, 5 May 2022 18:46:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fusah5r79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mkUzO9XiJ//CfjPNOKINq3994DqfKnfDccRT87tfYTLvUpsWHZOhHeAubfGa7z3d2mFnw85hLEq/a+DmZbRkozA4G1TM2P4ovqH5MLos4EVX1FJt/rlqIZpLEsRdZ0ZgJLBHFueffbQOme741uB5m7N/wUi6jGyBpcrtTtEEiIwQeIybmRjKOuf9b5ATf1A5hYs+q9sj9gWw9ATCy/9dA4cNKRuRnNlaML7I6nLK6YY410tkZduZvx3b70gDDYlEdM7wdopdNRn23MzOZPJvMiJwyjz7oE3MeJ3FGnJPknNAtkg1JdF59UxIHgcEpjgZ8ZXB1AbS10BRi/ts7Y875A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=XPj+2jULbdhZmJ4HWsxOlUaq10wEZNYVcYmK2O5XQTV3KTaIvRgg/NUTVbCL/NZDZXkZvaAetRVPMOX/lhw4T8a8ijhCG2fquReI8nhyzhBysbg9oo2bXuOkl+SCuhgkFbJ9pnZ/WJsOtKEykKZdpwAmP2M2B3adPJcGnQMDumAShEBf7hcrR2EfvXoDEGP4ibIvZCRr7LBuq+CNKCIHnC4YBI/WnEgdUFvEh6EX2e1swQEjpNWNafp9dsd8DFSKgC7jDgsNlYWjqhBKky4P0nFQkTUfZRTXuSY6ekWFSnHPXk85dhxuRKH3AYqbyw+66BJYGrR/GEBDjPzZRXxywg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxXZzc9NcifzyJJKkdbQviqwxZpGWXRW6ied8c1WuVQ=;
 b=B1NLKmEKh+QQ9XIXUFS6J37eCpaXC9wl0FZTDmnDJb9ojAgrzfdpDk+dk1DiMasML1snbVuwjKGAZFDMZAS2OhwNr1JMb+u5trkrhBOR4QYjM5V760UU8EBVMgPf97SbXPItH1UeEjRU8z/E36k4AiFXK2cPX8rmA2qczlij4wg=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BN6PR10MB1875.namprd10.prod.outlook.com (2603:10b6:404:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:46:29 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:46:29 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v8 2/7] crash: prototype change for crash_prepare_elf64_headers
Date:   Thu,  5 May 2022 14:45:58 -0400
Message-Id: <20220505184603.1548-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220505184603.1548-1-eric.devolder@oracle.com>
References: <20220505184603.1548-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5f4dc83-191f-49ef-31e1-08da2ec79116
X-MS-TrafficTypeDiagnostic: BN6PR10MB1875:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1875F598C7E99D2FC2C8879797C29@BN6PR10MB1875.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1wQYbIPh5J1T3JDaonHZ4pi6kNBqBQkSb0/rDptpbE1qrNk0IQKo1Zlui40oh8y9mHT4VDKh0BNICLBTf3ipXfKUG/FFTLAdvlU+Mfhoy7zQrYDkEaQbmQatrxRII5/JCDUvv1x63Jzy7j/dKoXVPJXBbo2jgY2KNzCtXLw5AeAIn5dAsBODq3xqc0g7PoXPhqK0L5nvLziNBTCBuztFk+ZWoDBygB3PplV5l6Vl0DRjn2tYJNJoZO7vrbfx6Agbhek59o5Ni37kFZVgEUiOd6ZfHWBhwA328uD0lZh5UQd/O7AN2/ryyiqWJC8eemm5jHJ8FxnYZzTicAb/7nfuFg0fIOQAGQG/+UVoQ4DYvtfpjiWD6i+g4qHT47vbEi7OHVsOrRN8Q4S6ESXzPwR2pftl7SX59sOHqRxIDmE+qiiDonZvsxoItyWmJ16GZSLXP18cK5sQkzZjLQipQqzq6RhLkrKubfayt7idfH7viCIrrhG/VUzBhEz0wCL3pb75/qH1vK4P+5c+551bSeCqBnyov1/izSOO5P41k59OShKZQhMj43Eio33ql9tAgIFAUL6Vhay+WvEJvF/hJX/hUQmxtfP7pyZD8JB3xY1tR0jtm5URVG24lQZVxNrNOEek93fjJIIWGzCSrUIK6YkPKeB75rudhPlwL1fzUHbbKs/ujHEI6mNBR9h2siWbTTANs5L/fkKjPafwquWhRL79g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(52116002)(83380400001)(26005)(66946007)(4326008)(66556008)(66476007)(6506007)(8676002)(5660300002)(6666004)(86362001)(2906002)(38100700002)(316002)(7416002)(36756003)(38350700002)(8936002)(186003)(2616005)(1076003)(508600001)(6486002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xlKiwDM9gF3EYDWoh0iLMV1tsLwHKT0d9nxJyHf3Iduf6GL5sQbDR8j6t5qs?=
 =?us-ascii?Q?Vs37BQKPvdBOn1Uco9s5tJBwf4PSOAIuN3wZ81kk75RvmRzmPHhPb2zu49F6?=
 =?us-ascii?Q?JHQ+gcZ3jbp3pv76SMBHCXUZtkNgVNjpgFh41DFRgsw5tl7khXSl/5sUifn6?=
 =?us-ascii?Q?TydMai1QQJNZJUPybnD6OFmZ8DHT28KG57YZxIJq3BnbY7c1Xj5OEUp2FcXF?=
 =?us-ascii?Q?2kCZeG0CijJ45xi5b+jH0AXN6EfPTPzEpNo6b/73rulNDM7g24H2QOZJ5abB?=
 =?us-ascii?Q?zSaRpOhgODrim7jMS55gSdklGQpWFYVnRwjsmUJ1Dz8pDbRpA8HR3cKbvAo1?=
 =?us-ascii?Q?YDyNqukv4RYzNW9Qr1UXjyxQGJeG4dI3muaVcAv7ZN0uKEYZCkd93HbnAExv?=
 =?us-ascii?Q?fgqYB/qo0jCE37CUAD1nkQIcNwoT1igb/yjEX6g/vhK+239IRazk0qzkpIWU?=
 =?us-ascii?Q?UkIMWvu5jXbNQqak5sRdEjBSOcnysq3JGgZkGXCIu6RMWCEYcDKeU6mHptyL?=
 =?us-ascii?Q?v5MyVdGQHLy+zJ8S4vZ6LLzvbR9xpUSzJmNjjzgGCBc/i6jcQFiYX1oKeNlX?=
 =?us-ascii?Q?62Qy1sII5vkDyvtIq0lGcMMpdXxl5U2RdcMWPCE+XB7F7f+hY4LfS5BUgZ7B?=
 =?us-ascii?Q?yBjAtNtjddnfoDCdfPpt+xt/TptehtEJDq10m0sA8SKTEE8XOePqyrlqij6H?=
 =?us-ascii?Q?Y5XqQccz2A/Aw5UnVuWc98T97EjdLRA6pG420J1h3th1jv3SyBg66TFMPW/+?=
 =?us-ascii?Q?WLVSLAi024V1j80I8oQCV2fw0WY3p9YaLlHVCemC1IGpaO0llGPtlLJj6xcB?=
 =?us-ascii?Q?TQez8nO5blbX7ABUuZ3D+aIqyotnInTjc1fEhZdorNBSfBxhlNpqB/mvzxrV?=
 =?us-ascii?Q?C2PhEbFuuAcHiNZnieh9Jle/+j5KOy9RPxHm1F7ItNygXxVnyMLHiqQz+F8P?=
 =?us-ascii?Q?BgT4jMmZCWqlVopwbKtGt98bUxTinsRV7VMgLbaDpCqreYe9wUprKP5ERhwC?=
 =?us-ascii?Q?+Ilw6uSYV/i4j1y4D4TW/qs8oIokVeZxfXxL5DNXTrwjW9MGM5uRM5R47D04?=
 =?us-ascii?Q?1osqo3S41SvAIAfIw0p0S4cnE/5757ocfAQodSM7HpSfaL8/MF3mOJBWe+7e?=
 =?us-ascii?Q?mUcKWnoknnuDlJA3bjF7ueIeKrqn5lYCSIoLWw0HXYua1/fXXrywJ0Y/nB6B?=
 =?us-ascii?Q?V/Fz4AS6zBIouu7mNT7ismQs6YKK+0dtHZImXMGTQ1G6nk4uuGfUSe+GdUu4?=
 =?us-ascii?Q?qFHEJLaxkkNs/BS5wTo/93UTvBFS2XOqA63G5HOxQUA9fc4Vg0vgAmW70sxs?=
 =?us-ascii?Q?68dLFbfPLkDYftQCMpHa1fu/gZwFhb4PtHzR5kry5aF8uRlEQO8QyWfMoHAD?=
 =?us-ascii?Q?9WxQgWfqy0QsTrJT4HcYqLw5WD7poILddbwniRms9oWp6Rs046ANQ0pAvPir?=
 =?us-ascii?Q?Moq9ja6AE7IRwP0QctUJoCVsVCp3ctZQQ74Fb6Ciy03qaNtuUzen016wMszl?=
 =?us-ascii?Q?TJ8wG4j5U9kiPzDlrRkOCtz9G5nd5KhwkF1fT+BJb8PSRQa+CxcCgURfozVb?=
 =?us-ascii?Q?Jq4ia51CpILPKfI1xq5l8nLvmp3UQDwsEq1DMlAwIneajL1gC+Ydq83yHtWi?=
 =?us-ascii?Q?jLuhZgSLxwujmAa/oFUc9fMYefGz4+G/196Px+OdbBmQI33eAxv1SqwMQ1IQ?=
 =?us-ascii?Q?b1U1bdsLJGKfmVOMUk0be/bMGWsfr/FJp+wXOtUq0h/mKEx++mmJ1PRYcz+g?=
 =?us-ascii?Q?Cfded+u2VocMGFhYy5GHUqC5zVCJgm4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f4dc83-191f-49ef-31e1-08da2ec79116
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:46:29.6054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cIonltKX+gzMKKwpnz/oSGQml4/k/3BT7bl+OIi3qIEiIC6TT6/MIChPjrQ/g/+kN1qIwU5XRBFPlXl8cD9cKhT6SwQXIcL/B8y8nUKms8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_08:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050126
X-Proofpoint-GUID: 1YiBT9c9wmfh0SoH4pI9qxQOaohbyLsb
X-Proofpoint-ORIG-GUID: 1YiBT9c9wmfh0SoH4pI9qxQOaohbyLsb
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From within crash_prepare_elf64_headers() there is a need to
reference the struct kimage hotplug members. As such, this
change passes the struct kimage as a parameter to the
crash_prepare_elf64_headers().

This is preparation for later patch, no functionality change.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/arm64/kernel/machine_kexec_file.c | 6 +++---
 arch/powerpc/kexec/file_load_64.c      | 2 +-
 arch/x86/kernel/crash.c                | 3 ++-
 include/linux/kexec.h                  | 5 +++--
 kernel/kexec_file.c                    | 4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
index 59c648d51848..7dbafb42ecf2 100644
--- a/arch/arm64/kernel/machine_kexec_file.c
+++ b/arch/arm64/kernel/machine_kexec_file.c
@@ -39,7 +39,7 @@ int arch_kimage_file_post_load_cleanup(struct kimage *image)
 	return kexec_image_post_load_cleanup_default(image);
 }
 
-static int prepare_elf_headers(void **addr, unsigned long *sz)
+static int prepare_elf_headers(struct kimage *image, void **addr, unsigned long *sz)
 {
 	struct crash_mem *cmem;
 	unsigned int nr_ranges;
@@ -67,7 +67,7 @@ static int prepare_elf_headers(void **addr, unsigned long *sz)
 	ret = crash_exclude_mem_range(cmem, crashk_res.start, crashk_res.end);
 
 	if (!ret)
-		ret =  crash_prepare_elf64_headers(cmem, true, addr, sz);
+		ret =  crash_prepare_elf64_headers(image, cmem, true, addr, sz);
 
 	kfree(cmem);
 	return ret;
@@ -96,7 +96,7 @@ int load_other_segments(struct kimage *image,
 
 	/* load elf core header */
 	if (image->type == KEXEC_TYPE_CRASH) {
-		ret = prepare_elf_headers(&headers, &headers_sz);
+		ret = prepare_elf_headers(image, &headers, &headers_sz);
 		if (ret) {
 			pr_err("Preparing elf core header failed\n");
 			goto out_err;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index b4981b651d9a..07da6bf1cf24 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -797,7 +797,7 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 		goto out;
 
 	/* Setup elfcorehdr segment */
-	ret = crash_prepare_elf64_headers(cmem, false, &headers, &headers_sz);
+	ret = crash_prepare_elf64_headers(image, cmem, false, &headers, &headers_sz);
 	if (ret) {
 		pr_err("Failed to prepare elf headers for the core\n");
 		goto out;
diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9730c88530fc..9db41cce8d97 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -265,7 +265,8 @@ static int prepare_elf_headers(struct kimage *image, void **addr,
 		goto out;
 
 	/* By default prepare 64bit headers */
-	ret =  crash_prepare_elf64_headers(cmem, IS_ENABLED(CONFIG_X86_64), addr, sz);
+	ret =  crash_prepare_elf64_headers(image, cmem,
+				IS_ENABLED(CONFIG_X86_64), addr, sz);
 
 out:
 	vfree(cmem);
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 58d1b58a971e..f93f2591fc1e 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -227,8 +227,9 @@ struct crash_mem {
 extern int crash_exclude_mem_range(struct crash_mem *mem,
 				   unsigned long long mstart,
 				   unsigned long long mend);
-extern int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-				       void **addr, unsigned long *sz);
+extern int crash_prepare_elf64_headers(struct kimage *image,
+	struct crash_mem *mem, int kernel_map,
+	void **addr, unsigned long *sz);
 #endif /* CONFIG_KEXEC_FILE */
 
 #ifdef CONFIG_KEXEC_ELF
diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 8347fc158d2b..801d0d0a5012 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -1260,8 +1260,8 @@ int crash_exclude_mem_range(struct crash_mem *mem,
 	return 0;
 }
 
-int crash_prepare_elf64_headers(struct crash_mem *mem, int kernel_map,
-			  void **addr, unsigned long *sz)
+int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
+	int kernel_map, void **addr, unsigned long *sz)
 {
 	Elf64_Ehdr *ehdr;
 	Elf64_Phdr *phdr;
-- 
2.27.0

