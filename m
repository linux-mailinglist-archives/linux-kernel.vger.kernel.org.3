Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C441A4FFB9C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbiDMQqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237015AbiDMQqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:46:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B9768F90
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:37 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DG8P02018418;
        Wed, 13 Apr 2022 16:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=JsVCsZ+KCmGDzN0ep+0qbdTruMs46F34lLVnEpsGBsI=;
 b=ttVtbZWv1Q32wvO7Z2W5e49T8Zzo2O7gsEd6VxzTFkZjrqYFzgYTrL4IlqTDYAG+zUxL
 rMH0tJQiYya9jh+WI2gdjQr3Y7LeAxMUcWjfutTAUlcrAJMZ+i5B0Q+xWfMcJeOpibXj
 9LaqXLt6JywP8B8ZB8a5vqsbPVZoUSMD0HEYQA6YEHqEuEr4S3etvlVxlp8PsfgAuunJ
 Qq8XmZJL0dK5DvGU56/4ew1TS7MwYj4Nv6u70puGAdqGCwwWZQt225x+6FFD5tP+1cAo
 /cjoe/U2MPBzG+eJsnVPbTWW8eK+Awb86jOI4IUkuenuuI0NzMqmOXkZdn3Gcdll2MWk Lg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0r1jkf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGQLw5001321;
        Wed, 13 Apr 2022 16:43:14 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9jw4pq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:43:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOArOSNcymRypEEIFKTtcESrYHW/n8KAVTyE+WsL2E7gvuNCLn5fiYpM95O/6f+5ZU6MTErMYlsveeNbYo0Sa06kS+EvrHK31gqt+x6wyBJa7HFrPDEnuvFG8xzK031nI4rIAUCPu5yTwVRNwE/MUwY2U3EGbfPE/4e5oM6+vIUWls9WTbuFYB32gkuPYaY/4Ybu94sWwfmZ1bbBTW8aKx2N8KB8uxBN2YDAXelT5fGpjexTSkCdrcd8t9kvIjZoBjhYIvNvZWpYbUaNpukClzacXXfzjbsroBaWHRYGEim3DHqnVHN0USkR8y+8Ji7Fu1YbISoUsY7o86Jl2FfqMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsVCsZ+KCmGDzN0ep+0qbdTruMs46F34lLVnEpsGBsI=;
 b=WryFXG2qllc4wPbv0j7U4LUgwaQNF9aE24O9XW7GtwRlSJ1f3EqMPElJDmpcttHNm3VWZcVpVYLfodwa5SkLTwDNuuOKnhc5PkCuauiPcAFbexfUNk4zeNB+5nbhX/3zGFnJv6/AbaZKV2f2MsrMx2yOqDwCByDK5xZtmb2gmoynQu5i9o24KJbDEoF+5YmYA65+Z5eTeqlZrl9P3GFNA67bcEX6VFTreIjS+0kewmP2dVaBFsDZ/u3Shxil2IsoiW7YaZ8q2/FXFzBqU13dJmVxgXYxB3CHcBv+mmyQhpLGmBScdRzn4rvUJMpuuDMqKGBtqcFM3fitDVApa/ceEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsVCsZ+KCmGDzN0ep+0qbdTruMs46F34lLVnEpsGBsI=;
 b=yP+3aaHHrM8FV4H62roqMH7a49a5UIJl4kyARiKQJ3CTnzXaK9AR1iJQZ+nICx9NTfCTS1/S/jJoPBn92lUnDD9VqF12bjYNDu2gxobpj0bb9FP1v0yKGMpVYurOCQjvqXBKCQPhubBc6BBdjE7OsQcaV4bNCWbt/5W8quzvaBs=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BYAPR10MB3560.namprd10.prod.outlook.com (2603:10b6:a03:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:43:11 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:43:11 +0000
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
Subject: [PATCH v7 7/8] x86/crash: Add x86 crash hotplug support for kexec_file_load
Date:   Wed, 13 Apr 2022 12:42:36 -0400
Message-Id: <20220413164237.20845-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220413164237.20845-1-eric.devolder@oracle.com>
References: <20220413164237.20845-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::29) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0871425d-a461-45b7-c268-08da1d6cb267
X-MS-TrafficTypeDiagnostic: BYAPR10MB3560:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB356047AEA880FDBB161C04D097EC9@BYAPR10MB3560.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X8FV8RChnJJ2wq41nTD0KuYluESCWq4dJCG3KcLqvKjVbJcVNq9EYtxQ6Y5AKIBMetWKIOdG2RWJMtaPnc4u/oAtYXM1qbfSvPcKQCVej32M/R1AbJ21Yk9EAbWcic2sdD/QB1KpVmry5DN9lsGi9ztXDYyZAF743vyYn/cBm6SdCaBgvzWzS9s1vfwLY/rK3tD0URSZnz/hwfiWhcuCc/ZJ+ybNQJFv4vve2KQURlY8CxX0ppeTTXEieeJnoXwvqLEdxqKN2PJ5wiVMgvVpLTc58L1yj4pAtSxRX2hvUYWwXoC9QuyZug6IUU8w5Nm7olJyI7QkW9skBNRvJzl94ohhxBGOYmAN3ML1JT9muhZmqe25x6U+/uzXZ9Uj5os2IZuDspO/0ZXwlQBpAL8xONy405Ri5i79nFwSR76cSNFRlOTFOlBAVJV3Bv9+im+Vs9navmuqBscCNURi574uLxk/iF+eQqaoq8W7cL0IFXqnMrs+OuPlkomEde8wohJZvUUZywAvHSJe0wS1BQtYdq+WGCCOxAo+1CagekgtfSAsBHAMtRzXSrGOduYRBYJDVwwhrBTdmkBIC0BhVAIMMnmnXWzPcKAWTqwTJobvoQ3Dpxhb64s4fNtp9jVoGAnD4rQ7JLMRdTABP+T6HKqtNed44WuYvTd8lwEkKGztTrvVvdWLWZwUOFDLKnQqMomfudrr6zC6EeyWw6mrajgLrQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(83380400001)(38350700002)(66556008)(36756003)(2906002)(2616005)(6512007)(86362001)(52116002)(6506007)(38100700002)(6486002)(508600001)(66476007)(186003)(26005)(107886003)(1076003)(66946007)(316002)(7416002)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9X8EZvVk56MVmwRNG7uFfEzGFmtYkVKKppX2agrYrZPBkqT8/AtyW5lTFO2?=
 =?us-ascii?Q?nYPwpIk3TH+gxxH29lRGXjUx8++aDmbGIwn/QaHQLJleZErYvWVamVYwE2CR?=
 =?us-ascii?Q?rIuzm+58AuUgkuuvm6RuCbfUPgtg36D6WIVcnpC36+M8PPfE5scmSbL9UVCN?=
 =?us-ascii?Q?7YhRfoC1HgCtYi9a/fBWqPHsGGaQQTh0mYEhaEFB+8FPUu68iaCsseeuTDa4?=
 =?us-ascii?Q?PBvYkvdq24IN6fILsXoa9iizhxrjQaajdrhPH0zNWJJkMqhDODQVRNl73TLP?=
 =?us-ascii?Q?kNjrGjGvI4/k+JZWtrfx4M7z1MH6kHJStjrEAURgSYu5EHWgiIO1SOCCwtLr?=
 =?us-ascii?Q?byQxZgV8z04SSjaGzCCazSVNemUxieeiDVmfr4/xnMKDVmeGHoXyDUyvtbbe?=
 =?us-ascii?Q?CZtORGCvnqj1gvnT90kHLNiIgR5g2fm6MLWJnDMabolpD5DGydf1kp8Z/BNO?=
 =?us-ascii?Q?bP5H6LHtQjqGPVXw2CC1bMx/ip5ZJ7UPFhxr74/L851ZLVHYlMJmpvY2HnIJ?=
 =?us-ascii?Q?8QeM8FzwYc/TYjo8sAQkmJK9jGmLjZ7HnAmbjZpFHlXc82fbr3ccmZGDpE5H?=
 =?us-ascii?Q?v4naB/g+SQMbecBghvzotpw327YU/x1/pISwLeol01q3Y64PDi3rPruxDO2B?=
 =?us-ascii?Q?X2R+Tbb4kh1IjYdGnj2sbcaKPSmZ6daKQZdHK+B1NCAgmQOnGGIp6KGWFrZc?=
 =?us-ascii?Q?2sMiTKoWMjSHaxcawyOeQgfCbVqq9SqmQQQhZVe5s4mCur7bXrD8kdTmvucu?=
 =?us-ascii?Q?XpMWEX62Ad5NbHdjBvKV4pKlsq6/ldjCf/DmaluWRNJl/RdP9aQ3MkMNVWZD?=
 =?us-ascii?Q?HyqGv7yf438oaPq8MdvNtAi+4alvke+ectu5kE5fcG2ct96QpNR3VNETkv6c?=
 =?us-ascii?Q?CWx1S96PPVRXrFnt5HclsFb76q/u3psZFnW246ab+sb4ytoC0A2RC9MgUUDw?=
 =?us-ascii?Q?pXrPHuzqFutCLf7GQD+n37m+LhLFWTUsIFGgVFQ4gJ3As8Fw7ynNRlFfWRh0?=
 =?us-ascii?Q?8kG12q/j9KmGWVZJZI1XNVK/v87vrLiUGwDTnEq18G6QfH9fT//VGoaOV7pA?=
 =?us-ascii?Q?U9Qlx6HnN9NhjO/A4qvCqZfm5qAoIEMV35ZUEwuECbV63YiVjiBi9u+qpdmr?=
 =?us-ascii?Q?sDotY64+HCU0Ke198DtAWXa5LwJ+IBnm2u+7QZ44q0CYVm+7RYbkfYV7r90c?=
 =?us-ascii?Q?JqW/9n/yR2mNSp5M/c8O2CkEixoSnz1mVB5nZwodTnDvBYFjTouYrthcDa+D?=
 =?us-ascii?Q?tXYLqxCtpIq8Ngsd9gLz6/MMGkIbS2Od69U5n60yBpEF0zAX52NuXTq5bWaB?=
 =?us-ascii?Q?pYVEtZzBrcaiPODdh5p6FDLNRmEC6+LgO/yx8UmrEUupHYJ7o6AaWZ6DX1qL?=
 =?us-ascii?Q?opzMBUMOanBwpIPUKAH48f7caQBfUgDK+fy0mxKZ5MeLNkI6Uiww1OThKYjb?=
 =?us-ascii?Q?KIimrdJGM9FCAWeI6sW2xqGwvpW2I6VtrE1Nk4lwtPcU2ckblpnlwxsK0hHG?=
 =?us-ascii?Q?g6rJ9aJGVCpHt/V0QJPr/mcV1N7raHs64Y6fk2Sb08mWwRW+9YIqWMWEXf1l?=
 =?us-ascii?Q?tC+3sjnG6JAHxVBOd6WKouQHbYTyE95xYBf/JsSjR9LiEBit/UFkTiqegruQ?=
 =?us-ascii?Q?XkPwA/2KkPUI6mWLVoTvylVhIRz9rCE4+uGpLZq01N4ryoyjBfmci850lDy6?=
 =?us-ascii?Q?4x0nirJQD9G30r0S0x5W5pIrTHICizCNIp71WP6uyjTUBjEkHyx4U0x5DubS?=
 =?us-ascii?Q?Xov08iBSs9P4aGSiFe9omleBKDX5jOE=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0871425d-a461-45b7-c268-08da1d6cb267
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:43:11.5077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rCCpkeLCjcgIM4ADV65iARSZz2PflyjhRlxZrXGDRQxBWo8p6mNNxtHb+2qazxkGrgNdV8y+/5De2wc0C36ClLJrN3eo55YhkdkNg/gmCpQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3560
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204130085
X-Proofpoint-GUID: Ed8Jo6AoVuRwsv0ZbqM2E-ei--hyIUGP
X-Proofpoint-ORIG-GUID: Ed8Jo6AoVuRwsv0ZbqM2E-ei--hyIUGP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For x86_64, when CPU or memory is hot un/plugged, the crash
elfcorehdr, which describes the CPUs and memory in the system,
must also be updated.

To update the elfcorehdr for x86_64, a new elfcorehdr must be
generated from the available CPUs and memory. The new elfcorehdr
is prepared into a buffer, and then installed over the top of
the existing elfcorehdr.

In the patch 'kexec: exclude elfcorehdr from the segment digest'
the need to update purgatory due to the change in elfcorehdr was
eliminated.  As a result, no changes to purgatory or boot_params
(as the elfcorehdr= kernel command line parameter pointer
remains unchanged and correct) are needed, just elfcorehdr.

To accommodate a growing number of resources via hotplug, the
elfcorehdr segment must be sufficiently large enough to accommodate
changes, see the CRASH_HOTPLUG_ELFCOREHDR_SZ configure item.

With this change, crash hotplug for kexec_file_load syscall
is supported. When loading the crash kernel via kexec_file_load,
the elfcorehdr is identified at load time in crash_load_segments().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/kernel/crash.c | 117 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9db41cce8d97..47adf69c9f71 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/memblock.h>
+#include <linux/highmem.h>
 
 #include <asm/processor.h>
 #include <asm/hardirq.h>
@@ -398,7 +399,17 @@ int crash_load_segments(struct kimage *image)
 	image->elf_headers = kbuf.buffer;
 	image->elf_headers_sz = kbuf.bufsz;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	/* Ensure elfcorehdr segment large enough for hotplug changes */
+	kbuf.memsz = CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ;
+	/* For marking as usable to crash kernel */
+	image->elf_headers_sz = kbuf.memsz;
+	/* Record the index of the elfcorehdr segment */
+	image->elfcorehdr_index = image->nr_segments;
+	image->elfcorehdr_index_valid = true;
+#else
 	kbuf.memsz = kbuf.bufsz;
+#endif
 	kbuf.buf_align = ELF_CORE_HEADER_ALIGN;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
@@ -413,3 +424,109 @@ int crash_load_segments(struct kimage *image)
 	return ret;
 }
 #endif /* CONFIG_KEXEC_FILE */
+
+#ifdef CONFIG_CRASH_HOTPLUG
+static void *map_crash_pages(unsigned long paddr, unsigned long size)
+{
+	/*
+	 * NOTE: The addresses and sizes passed to this routine have
+	 * already been fully aligned on page boundaries. There is no
+	 * need for massaging the address or size.
+	 */
+	void *ptr = NULL;
+
+	/* NOTE: requires arch_kexec_[un]protect_crashkres() for write access */
+	if (size > 0) {
+		struct page *page = pfn_to_page(paddr >> PAGE_SHIFT);
+
+		ptr = kmap(page);
+	}
+
+	return ptr;
+}
+
+static void unmap_crash_pages(void **ptr)
+{
+	if (ptr) {
+		if (*ptr)
+			kunmap(*ptr);
+		*ptr = NULL;
+	}
+}
+
+/**
+ * arch_crash_hotplug_handler() - Handle hotplug elfcorehdr changes
+ * @image: the active struct kimage
+ * @hp_action: the hot un/plug action being handled
+ * @cpu: when hp_action is KEXEC_CRASH_HP_ADD|REMOVE_CPU, the affected cpu
+ *
+ * To accurately reflect hot un/plug changes, the elfcorehdr (which
+ * is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories. The new
+ * elfcorehdr is prepared in a kernel buffer, and then it is
+ * written on top of the existing/old elfcorehdr.
+ *
+ * For hotplug changes to elfcorehdr to work, two conditions are
+ * needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources. See
+ * CONFIG_CRASH_HOTPLUG_ELFCOREHDR_SZ.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ *
+ */
+void arch_crash_hotplug_handler(struct kimage *image,
+	unsigned int hp_action, unsigned int cpu)
+{
+	struct kexec_segment *ksegment;
+	unsigned char *ptr = NULL;
+	unsigned long elfsz = 0;
+	void *elfbuf = NULL;
+	unsigned long mem, memsz;
+
+	if (!image->elfcorehdr_index_valid) {
+		pr_err("crash hp: unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	ksegment = &image->segment[image->elfcorehdr_index];
+	mem = ksegment->mem;
+	memsz = ksegment->memsz;
+
+	/*
+	 * Create the new elfcorehdr reflecting the changes to CPU and/or
+	 * memory resources.
+	 */
+	if (prepare_elf_headers(image, &elfbuf, &elfsz)) {
+		pr_err("crash hp: unable to prepare elfcore headers");
+		goto out;
+	}
+	if (elfsz > memsz) {
+		pr_err("crash hp: update elfcorehdr elfsz %lu > memsz %lu",
+			elfsz, memsz);
+		goto out;
+	}
+
+	/*
+	 * At this point, we are all but assured of success.
+	 * Copy new elfcorehdr into destination.
+	 */
+	ptr = map_crash_pages(mem, memsz);
+	if (ptr) {
+		/*
+		 * Temporarily invalidate the crash image while the
+		 * elfcorehdr is updated.
+		 */
+		xchg(&kexec_crash_image, NULL);
+		memcpy_flushcache((void *)ptr, elfbuf, elfsz);
+		xchg(&kexec_crash_image, image);
+	}
+	unmap_crash_pages((void **)&ptr);
+	pr_debug("crash hp: re-loaded elfcorehdr at 0x%lx\n", mem);
+
+out:
+	if (elfbuf)
+		vfree(elfbuf);
+}
+#endif /* CONFIG_CRASH_HOTPLUG */
-- 
2.27.0

