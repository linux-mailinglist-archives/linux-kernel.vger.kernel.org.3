Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EAE4EF9DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351080AbiDASd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233708AbiDASdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:33:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1546A1DD3FF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:31:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FvHlJ018522;
        Fri, 1 Apr 2022 18:31:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=o+Dqt0zbsENuTCOkZXMb7UtSXXrlQOB3YFbgnmTe+Lk=;
 b=xe5mUWWBiu4QHy5T7Y2+w5AaZkf1P1HCb1ZwmMnYEBHFKG7VlqrOA4TmbTQ4vujy2jn8
 v53l0pUctQqV95b6jbFxAuK2Mv+ekF+6GjmrpZTD36Ark1lZiPVQ6T8OTJFzyLhPpHjA
 LgM2Xm+ubbVZi6bXblQqs1t5nxfLC4y34tC3Y8p+ccHibREyktCmOkiHi7E7JCGdSXB5
 AXQuvTVWcxGlOkGerp28voALcD8xyLAPLHw3tbsyfG+ykQS1AHVFEq5EL2hx5nuBKjBZ
 uDEx9fp3Ivcd+zw17oYmV+TzLX7qEZdpY5ZCyZ3nTU5DVP2ZtIYaDEyJfNe0MPmA8BVq 7Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1se0qs2g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IUcV4020441;
        Fri, 1 Apr 2022 18:31:12 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s961qdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSJEaz81Y8aiskqbYMB342YZQnEt6iyCP03WqvVR6+RYgKUeExcYolyBeu34R38EMbONU6E3QErNiDeS+CUZltwjezapajGe2ltZ0zOSE7qN50q4xXMV+3C/KGqJ1cQEQ8586/QCK4PxSjzaeBRWsr3xqfog9PZg9dw8q8BC1gpqQY9JDku5xnwzGDyxAVQXqSuNSLmSCbFWYshIxgM6CAE4QhEeemyqEdyCKmMLPBIyk9MUd6YArX12iGrJQR56m14xo8QpZgdoGiFmhdG/Qg3L/eaqWjJZislF1xcI22DKpG0LC1/C5zBBQigKYFYQJbjvoB4Ulz8h9H0IDJ33Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+Dqt0zbsENuTCOkZXMb7UtSXXrlQOB3YFbgnmTe+Lk=;
 b=bwtyU8LJDYNu+cjOJEu67dM7F3jt4STb41n/pA800V4QinwIOT/HAGsH4XkJGuVszIq8wGEuEojIkocHNFVy8yeE8oU8HogiLEba+1mkNjeGi9SmyNY8oTUKsRmg9LT6pwYgeT+BbHsBIRUCcCcKUJ4QAKOEaNIpyCaLtyeByj7fpwrapIKMhjevJGW3+40OOBRf52PJH96XOVg4UGAnOkerRORwqwOXSyNq27YoRWfU/cz6kP2W/xuFrMEjt4mkEi7TxQJdIHCKSJijGJmmSk8DscDYrlMR6fXfpHxMgTYt+yZ0rgnF7MDWtAFzTA28uV1zVh0d/ENqKREmt/K8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+Dqt0zbsENuTCOkZXMb7UtSXXrlQOB3YFbgnmTe+Lk=;
 b=FgsWz1MvQjbboUbBPAGmudhY5t0pvYUfvtJSAPPUCyKz3av8Un8qwGbnuvc4pysHRJkK187s8ttUuQ2xNoJYf77HkbFpzo4a9UOLRRYD0D4B8BdFfW/J8o8jM3tIc492T40cG/iXnUpRCRpOKsnImAOHTokJTrCF5RyQqkEvzlQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN8PR10MB3268.namprd10.prod.outlook.com (2603:10b6:408:d2::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Fri, 1 Apr
 2022 18:31:10 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:31:10 +0000
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
Subject: [PATCH v6 5/8] kexec: exclude elfcorehdr from the segment digest
Date:   Fri,  1 Apr 2022 14:30:37 -0400
Message-Id: <20220401183040.1624-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220401183040.1624-1-eric.devolder@oracle.com>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86480e38-5fef-484a-a0d7-08da140dcb14
X-MS-TrafficTypeDiagnostic: BN8PR10MB3268:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB3268E51C82A4471FE2750D9197E09@BN8PR10MB3268.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hdxpJuLjkFrMBX9udwVN0ATm2eoX1u44ZPQMTpLYwiB6dckN9/RaYvSSwnRiCL3eOLRGacuh6csZFD7K9pNJH+ZQhkjEFflnnFxC83JBUqNLwUwUL7qdDaL2x0B50MDN0K1hoaJQJNi5Rt9XDb1D1he2S/m2Q8cjwcUe1p5pHMNuiWkv13/oOKvgfIr6xIRyAmG97f/b2Ijb8blJ8sULDXTjRkzOHSESzUmX+eTjjqAxRvkFx52M/wjEKjXGsHSew3asBcleev4Pb3r7tNSxM77VKEGEtq4bUXG74FrxPXnIn6vuRonkDWB4X6aKPHMim2ENFrdL52qwnGucfWQOSCzGUDmc24CiqYI65Awp3wbQMEmmrAsIPetdjC/tNivGYHwhbDoaNrt5PM6SAXS4yYvbU/GiUB9UgsgaAdpESDRv9mqJg7qLXB32uRJv0zx0dacymk/fBOm1WV/scJMxzteNJocYGRZQSpH7CNOw24PWi3Yq3/QUlhccUFe7m9JM5MtUGYErZxMoSVuSSIN1OSzmOxUcJqsZmfTIZPZ1mOr8Rr5t7qJMPlNuOfj99Gl+WcbAGsEYKVzzcBNLUpokWgV5rNizp7Z8vE4vPiPBqMPS5Z66KGDXofGEREaKAm7TovWvJnHVw7zwvyZdaLQNU2crlw7KbZcIsQFJUh8+fpqquHKnnn5Z3vD/dJ7B/VesxRIWuTljaskcixLG2oEyiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(1076003)(86362001)(186003)(66556008)(26005)(107886003)(316002)(8676002)(66946007)(4326008)(66476007)(36756003)(6512007)(6486002)(508600001)(7416002)(38350700002)(38100700002)(6506007)(52116002)(2616005)(2906002)(5660300002)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6XEhXALry3Pb5c/XWp17v76Jc4u0BSrhxvuFPJj8ncMDHmfnXsFUO12hy7Va?=
 =?us-ascii?Q?psgO4290Otrg7BBgf7PTUGg9RwMIXFpI8VFAcqroaNEtZ1T/cyDGpVLOf8ik?=
 =?us-ascii?Q?vZlJ47Q6kRxRtuEdFMjkGk6PYIWQYOIkwsQNB6MMORL/LbT4sMWSyVEZH3z+?=
 =?us-ascii?Q?kCAub1vdiYeDmrxqlCFBeJME+2Fjfg/qtesxq6S8/kzWeB8T/N9hF2VJn3ro?=
 =?us-ascii?Q?Vms7l9pxsZT0fHiBrcJTLIAxmsXj6ZdPSQU/Cm9WpwneF2crZ55/hUZr1lBv?=
 =?us-ascii?Q?dqRX/O2OLXjhm7hhhGGvC27igwfGP2u3hoioPQ4RUJ1KMe8GUpFlCMKzIH87?=
 =?us-ascii?Q?pmbEpjeKtzl5c0kP0aMDVzCKT60u7hV8yyhIDRGimPn86Z5bmZAU8UlbyDsZ?=
 =?us-ascii?Q?RN1jYTKuW0bOYBvwh6J9mZNnF2WGTV9l9mHJI1WC2DaIWX3JUMWsKEW3dnW9?=
 =?us-ascii?Q?96pTKaZTrlHB6Z6nkHmwO1HImc3oJ8NsBb+e39pHxATMLDP8EURM3+WIOCZG?=
 =?us-ascii?Q?VKtxvSGOVOFxaNjkQEXo/z7/AbeVYHKzbcniC/xZKQFCYU3yvOVX7TaVgOre?=
 =?us-ascii?Q?Svc/d2yyx1Z6nrrZEhbHuTrVKmkS5fscn2ASILQOE/gr76q20n/34MFNgz+D?=
 =?us-ascii?Q?IUykY50IsAUI6s5AKDC33BkKoaoG2hZ33kjQFxpe62HeXbE6B4pB4ru6Y1j6?=
 =?us-ascii?Q?qnYHORJx0UbeUR+t+t+QMsa5utJ+NC5SW6MsJdWYbTplKIYNbV8Uge+ct/x8?=
 =?us-ascii?Q?4oHvNAoS09rGH+jzD0KjAoriTyOaP8QO1lkgSkauD/Y+3arvMySdau0QJwqs?=
 =?us-ascii?Q?hbXTWW84Wl3N8HdvZji//5YrC5iAsu00oE6UQiNuoobZUiah6yleHm7goj7x?=
 =?us-ascii?Q?nDiGI2AQCHusgCJw60dYAP8xPeGGCRv7ouCtTV+bwHH+baDILm+eR0qm9xgC?=
 =?us-ascii?Q?KMIhE0WwoEBGJt0VeHxNKdhrFPeeOz3NstUbhbOQGikFTq0lwanR/aycHHDw?=
 =?us-ascii?Q?3lWnc/DFScH2Fe1gjEan58pis5EuPM1UiLr42KXyFxZag/lf3Tn+bRDDSyF8?=
 =?us-ascii?Q?xJ/575QQK3fEX/Z7qQdXTlUTtVx97m72Mc1adE4Tqc5kVljF6ShPLd64+sc8?=
 =?us-ascii?Q?2iAY4t6oeiidhS/buFmBMs/HQry/pWBhRLyc72yf/kXyCQw63sD1MtNqCst1?=
 =?us-ascii?Q?n6Srxu9BHJGqvFfY7u6M6/rmEcaSS2OASgNVG/l+lE/xaj2xdjg1A6mxTSob?=
 =?us-ascii?Q?5RkHE7xhhPL3MopC6SZ3QFaxly+m+UEQcHRKjPMQA4dqbDuaxz0pHotNiaJ7?=
 =?us-ascii?Q?GWWpMmDXOuGkDnjpqFQM6FjR5wAPJ5IYTNuZaV6BhiLdb3WLY1E1RL/0Ihet?=
 =?us-ascii?Q?JtWxcGTz/Pla5rOawgihZBPgDRhufNEBoXOXINJCQsgpUxvQ43zdrPufC/Lz?=
 =?us-ascii?Q?ZEsIRzgLSsFnwBZLJWj5Ft0WNxW7SMBXZUF4InODtrdwjlqy27lSfeIdnUrD?=
 =?us-ascii?Q?IYYHrUF7lzi4eQ//yLaAxOx5XzOOK2G+pMyU1UKHnBGgSGzAxC9SVA5s7bZE?=
 =?us-ascii?Q?aOnWZvksLTlYcb5R2uxX3wbsPBuvnEU8wCpglrvfA6flXv8MTXAvdsNAGPGT?=
 =?us-ascii?Q?VuvfAsDZ1kYJPc/PSDNnnY1xCGwjmil7YP6lrc0pkmDmu83yvDcW9aXbMKta?=
 =?us-ascii?Q?x6NhwTbKySmeV93ryGwjg26LB/DstcfI3Jn5DwqCOyNN65xMKTM3Z6XagG6K?=
 =?us-ascii?Q?hDqZaG5NncSa1yzyaBctsfkQMUzvoDQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86480e38-5fef-484a-a0d7-08da140dcb14
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:31:10.1697
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8YbbJRZ44rdhR88U5fgqiHNMgGRknCMgrnLj3TNtqM95lom15fbVsBh1YZenKgcoLdu4bQTE+dGF/d3Is3ZGSeGS0gbzTYJPiVcrkN5Ifs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010088
X-Proofpoint-ORIG-GUID: tnjTQmq1b7JlxD_PM-XbPamGPYkGr9uL
X-Proofpoint-GUID: tnjTQmq1b7JlxD_PM-XbPamGPYkGr9uL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. This digest is embedded into
the purgatory image prior to placing purgatory in memory.

Since hotplug events cause changes to the elfcorehdr, purgatory
integrity checking fails (at crash time, and no kdump created).
As a result, this change explicitly excludes the elfcorehdr segment
from the list of segments used to create the digest. By doing so,
this permits changes to the elfcorehdr in response to hotplug events,
without having to also reload purgatory due to the change to the
digest.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index 801d0d0a5012..94a459209111 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -765,6 +765,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* This segment excluded to allow future changes via hotplug */
+		if (image->elfcorehdr_index_valid && (j == image->elfcorehdr_index))
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.27.0

