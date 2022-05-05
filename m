Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5308951C870
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiEESv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382993AbiEESur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA5FDDB5
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:47:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245G35dJ013484;
        Thu, 5 May 2022 18:46:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=DxNXWyUVClrtCV/SfEUzi9BjfEFl7ZCNKGeOpgVrmsw=;
 b=nU79mhSDCLZ/xP2SpQBF+KoTeBbLRNlbOQWd0ZEXh1jLuoxce/tSyMrbRxylEY6aiagn
 mf9hIBySJJndF9bd/f1LDOgqjsM4yxq9ss1ePmrCxNDj+n51hWeG05IulE4vV3kbWIUn
 5FDYPp2SWMu323JikBPDbKR1U7JUK9zlw/IAJ3uIJa32Qqzeq6JonQ806QFfT50OewCR
 j1lUUFcNlK8bZ5rGaDKso1JQOVvhSM/Xr0Gnveplq2suBRMmLEbLR41O0zz3gtdKmSmJ
 sI6ZldHaYVVSbG9PfIbQOcLV2GTdEFAGq6dLpZLsfWiYHp1Iiy7NahMo+fOLPjMyhJCp sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsm8sr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:30 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245Iit6h004697;
        Thu, 5 May 2022 18:46:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj522d7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX4LfueO6+uEaH6CSSNFnqSscdbrrWZdDsgQp7+UKWyWI9125Bt+2zoYQraodC+NfQUce/MO2YdL705paSorJoyiJ5ug6UNYCDFdWj4AuAT4IzOGChKmYdBFB1fAmd/NH/RpVNC5BlWgTjGJvBDY5+pVJlYUTwm6ePiirONs9BM66AMi/UHe4f0c33QCSiaAQS2QWYBMGmlhQk0PBLv3T7RHobvCppN9vlignV5wDaPih1cB5FAZ9U2UxoAvdfmY8OACuOaVlYkBXfv+5kOJ4RqM11sP4tmNJhoA9jaLykAG1pbf9G0FWaCHDfofz0vYjG2YORmYjgETaraaF3pbbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxNXWyUVClrtCV/SfEUzi9BjfEFl7ZCNKGeOpgVrmsw=;
 b=b5Hoq/qxE4G6E3bdX3DZbl1eq0HltG5WjyJY6IwKmQmTe+DFJOsjJUTwHtf7kdf/6jA3m2r2LX+rcp5jpUSyRATersZx/A9t+aaU/z/6D6QouoNJFvdMR1gZ9Cdvuf3NsCZ3NtWxSE0Dgwc9O/2B0FhQJp7EEXbfGOcRnHtywb7JMvPnM0IYKV5M4SOEs0vJqB2+6a12cXAiLMuf0nDXb6KywRq3rIcPopkiaw2AJKbaqb+xwCWrWK1xw5VpVNxbQCSkUCS2yJsDACSTkXKblx4BoTcIYoScBAtvxaIBBmiFQ7oKse7OA/PC09CvzVkCpUmU0SDc7IMsFlkHqT63zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxNXWyUVClrtCV/SfEUzi9BjfEFl7ZCNKGeOpgVrmsw=;
 b=FgJ+ZmdE+OGvufGVc9ynAnSI/cKc1xCVXAz0CarvZO57FjvvLDQsfY6s/h540/KziaNqUMc7F9WXWZgLSUvVWwrHoNSXIm1HK3QurbiScLEz/gs7hSq4ELZXaFdVtRRi+t4xekcE2BBwznQYLEepSATtNvVU4b8a0Lj4J81Y+S8=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BN6PR10MB1875.namprd10.prod.outlook.com (2603:10b6:404:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:46:27 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:46:27 +0000
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
Subject: [PATCH v8 1/7] x86/crash: fix minor typo/bug in debug message
Date:   Thu,  5 May 2022 14:45:57 -0400
Message-Id: <20220505184603.1548-2-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 23923069-d060-48b1-e525-08da2ec78f9f
X-MS-TrafficTypeDiagnostic: BN6PR10MB1875:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB18750F414C670DE1047972E797C29@BN6PR10MB1875.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JYbNY3wAJuyXNRj6IFmRfR9ZrreXZhKS5ClP/NUPQX4SBBZeEnpmGjqxI0VYlxmi7mfXoXfFZix6vUekWE4qPWF8J3pH9yKVhtYIv75rRPobyakWT6zaODLxThPi6WP344eQF173bRQuDNganxmEXSsD4YMmrPtYaogFOw3+yGZx2cPV3nO9NYymAVepXyU2aVdIIwF3po/8XBlCaBoc5i8fFAm1ii2NPFVAoM4XK6kjP0JPmQfzq2Y8BIqe8B/lJ9IYD1+0bKiRdbg6biTtcRw9jIlfcSE+zTcA6TLealYfpmHbo4CAffUZ4bOzsqMgkEZjprguTSyzoBVGFHHgYleLb4AY1B24Pj+cxyUf4+smfTvUpdwFuKvUvDTMFfYfSjCo5nf1DOgkoSIk8PknRRjF1p9Ukeg4cdfvg5f7WBE9Mk2mUCEHTdq2ageSfTUxP2pU1QT8GJdekBArLpXwlUyAkLEOqinrz87Z2WhYjDgPqgfFb1Y1WMFlUNYrxEAuobGTQcqhamPiMfJDYsfdGvO77kh4gbN5kMMclhGXNrrnr9Jr+Nj2vRo5X7gsAGe5OU8/0bCrS7wQevm7sSOTnrHNekDRZwXpZyMgSgVBHH0AAbc9HJKZuuD2EkmZtCfoU71oPaquV95rgQyFgefKBHpx83LkCKgJqAdsvbdHXQCKfPv7laTox3np+2saMz1VC2nVdGLwG1x9MMt8LlF9Zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(52116002)(83380400001)(26005)(66946007)(4326008)(66556008)(66476007)(4744005)(6506007)(8676002)(5660300002)(6666004)(86362001)(2906002)(38100700002)(316002)(7416002)(36756003)(38350700002)(8936002)(186003)(2616005)(1076003)(508600001)(6486002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvRwBlvzv3+NeOztGKw1xUzgJdjxTnO2EfDaeoo2IC6c8rWgxyg2gT7ChMR3?=
 =?us-ascii?Q?rLjlYP84/Rvu1fNuYUT2TSW8bxeVVQ45Hd6hemvVoAwFFcb5BAlDq/oseHJa?=
 =?us-ascii?Q?M0dTnfndCQqYslkpn5WkWEWbcCQJnNK7Cp4irIM+59+dN66QS8ubdCzsWbis?=
 =?us-ascii?Q?8oFhT4Bvw8h//EvQBpa9AF8RWbdqwvH7TwQwIKTYdVVqmdgF6Ngl6Nm8DvWR?=
 =?us-ascii?Q?k8Fk+B5Fi1CeDs2LdDGK1UcWOw8cLV7ZQmxH+LlbLO9m3x/zQvZfvDRZjzD4?=
 =?us-ascii?Q?HWw6QIBmId1VkqbYKYwSWeCcl27DJZWgaxzYS5yq2FuSSV9ri27zqOE1bbZP?=
 =?us-ascii?Q?8qNs9sIFAFlMhCuFTwmD6/vIOfEIQffhTt/frjlzp722L7LzZky3GfA6NNBb?=
 =?us-ascii?Q?0NrCF3hZFM6+pLzWuFllh8+zhlaDm2aw2Kn8bZRuc0oCnywF7PZHuSQGVo0W?=
 =?us-ascii?Q?aeoFvoSnDrnOiB3zXredOKJ0agtwLFhZ6h89tmp/IWnydX+2OlbLzCZkfE8u?=
 =?us-ascii?Q?gqw4COUg3HzD1ZKRyFDd/WTuK1ykG0dN4Gs40x8dQa+jiQAha3XYxJ4MHiAj?=
 =?us-ascii?Q?Wo3AIdy5FEsLcMBD01qpvXbUSX/3onEUR0jfJWf6xYGIA9mdtDCvxJ4S1n8E?=
 =?us-ascii?Q?OeK6P+V+ljO9HrwZ8KKeIE+dBEMiJPQdBCcDhjXZIlUdt8OpPFMuX5uyhTMP?=
 =?us-ascii?Q?49ZrmTo85NEiI6TSEUgCuxQHA1K1mhPsH8QCcE8k8vocGk815HDon/LNuE8B?=
 =?us-ascii?Q?3C+jZqcguPu5laN7n0kKM6neTHSH4BeTRDujOD9QPv0WsSNw44ubVXnoxTSP?=
 =?us-ascii?Q?u86ZaUJ0MndypxF0wxx+BPYpUTBY94u2r07O/yDdS71438q746tECoG8g75y?=
 =?us-ascii?Q?FYGreInKSIj1XYjcICS83yhhzGL1zUN+7FZrbbUMDaGYDx4TLOT2kl0/19Rf?=
 =?us-ascii?Q?Br7rouukVnLXelWmBz3JGXgkU0qDdMULrQNRFI9dpqcrGxYfaiil/2bmd0NV?=
 =?us-ascii?Q?eFadkpQlgW4UUDNWHM7GZN2YpaPiujDDKnSGGOweDXoGn+Yyzlb9QiG4g540?=
 =?us-ascii?Q?4U7bh4uJCqmxnm+yVAhUZJAFZwkMDj616yiPBl6R51A3Cv4lPXBmALWpZY8T?=
 =?us-ascii?Q?hUnQrMMF+SBdHhtseaVblw80RForEnvgg11S50c5XA/+oPCvQ3nksP1YYr49?=
 =?us-ascii?Q?826vOoEdLRRGt5TUTW8Nv39QGvHph1XA+/mbTeR8Fab6wbGUrM4XrGhuJpTH?=
 =?us-ascii?Q?g/EMzGN/PwHzHN2PiAvUp8Ff93Yd2z4QDKdBmj2AWIOuz3LzDU3GO+jRq8a8?=
 =?us-ascii?Q?z2iBDuShmhmrTxvDqF1yyNp8X7dIYkAh/UBeJ8ncURUeEc4WicwNue13WESt?=
 =?us-ascii?Q?QKz1zVr+8sNb3iR3Hg9WhRIOK8c8xIAhDSbzbbDcPJLBxQNnuIcd6rOpejLk?=
 =?us-ascii?Q?QJHYOTGSMypzwaGByF23C8xh/GVX6W1ZQNKKEDJ7E2GMhjLlL8dt3RTH2+6u?=
 =?us-ascii?Q?JivFcvPQP3zGx3aJJGFuqYusgjEj6JS779VZGVb9vjXHwtA8RlvZoOTkhojX?=
 =?us-ascii?Q?dYvHALd6LMw09ZK64OaZOUFf7iASsfzzIzT0gSaq7E65JF+hlLP38JhMzQTA?=
 =?us-ascii?Q?sy89ykfbgK9//p3YpqAvFjyyX+L3z5KUv0jNmf7YCcKXYGFyPfofOErdoTcs?=
 =?us-ascii?Q?2O6108ei5HFq4PT0jk6qmbAs9WMdLsF/xXLfOYBPyGNEJqMrhzoErhR27DrH?=
 =?us-ascii?Q?nCgmZ2V8TYXjmGqiaZyz3QL3K3dqnEA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23923069-d060-48b1-e525-08da2ec78f9f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:46:27.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPFXXluCjEsKSgeCFaAbI9PSLI4zxjwNlZRy19zeJt6MWS6l0Sy5ibkLz9K6phi8oJujLFHoc8tGFNxwtLhbcSwNez6uZqtu7aQGqk317kA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_08:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205050126
X-Proofpoint-GUID: 16K8EgvjTcHq2r2Dg0SuCwziFUhVrd5i
X-Proofpoint-ORIG-GUID: 16K8EgvjTcHq2r2Dg0SuCwziFUhVrd5i
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pr_debug() intends to display the memsz member, but the
parameter is actually the bufsz member (which is already
displayed). Correct this to display memsz value.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 arch/x86/kernel/crash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index e8326a8d1c5d..9730c88530fc 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -407,7 +407,7 @@ int crash_load_segments(struct kimage *image)
 	}
 	image->elf_load_addr = kbuf.mem;
 	pr_debug("Loaded ELF headers at 0x%lx bufsz=0x%lx memsz=0x%lx\n",
-		 image->elf_load_addr, kbuf.bufsz, kbuf.bufsz);
+		 image->elf_load_addr, kbuf.bufsz, kbuf.memsz);
 
 	return ret;
 }
-- 
2.27.0

