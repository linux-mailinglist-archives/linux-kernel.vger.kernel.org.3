Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207454FFB98
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237008AbiDMQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236977AbiDMQpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:45:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E54C967D21
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 09:43:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23DFXJU2012784;
        Wed, 13 Apr 2022 16:42:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=fgkcK0NyXPpEH2V9VpFCA1ccEUsofW/2j145eLTwY+u0UZf7DTmAjlerRcE9k2bsUGWk
 /wBUbD5J9rBxFmIsn2zUa4GvoI/z++spNg297z9Au9RRsqt03LBH9tnlDD6kuLb62vZe
 Yt7Ynqm0Oly46M99C4fBPYIBjKWjTgmcV9PeulsypKPeKlhR9Gzd/QYEdmKO3rnlfJch
 sFJc9cv8ucCmEXzEdojbtUlgM7PHqNohrNOR0BlFCg6Q1IXvbPJcwokSWPYgc/2yE0kb
 I6QHGBWx3ceGSXyV3A0DlmwZp687bKbte/493WD3zzcZYaFl1pRrg6dX6kI9YTtDbCEa YA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb2pu2rax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:42:58 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23DGRQLC008425;
        Wed, 13 Apr 2022 16:42:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fb0k45r31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Apr 2022 16:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBPC4XBOjQDesXd7S1tjl6GFAIdveYfA+IZoO8D+2+N9g2SQwsMkLDPNV7eoW91qs+cWJql9xtSrYu9w4N80U2KJZn7DJjm3pUgilpc3HOUj1Dz2WdP5iQ7fd10KI+hSu47uHbitUkg/b8bY6daKXeQK+K5F1RWxYiIbmBIrY6nsHqZQKyv2v6MTVVDZmXut5Qqm7E75WvnD9bTnJsgt6PMe1Ouij8uTHMEFdeX8wdP8qGAki4NGD6fepLcvQ8MC9g0ZxHYZun1+ZCsUcbELvEJH55XzEgK4LP7LMF3PIgi7D/U3D4lMKxtFNaoeAW9/eCcTpNIROHu4c8TnMmb//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=jOZ93g3FvlNZStN3rB0tZ7uEI/AOUmjDjOJqyMkw6y2LnD+BBx8pIjWpxFfKyQGqp1v3fYqQKB73PQk7lI6+dW4sM2CprBTtuS1WIGIopG9kXCc+ZDLZgr3lAT9mHQMCfgDcTucQFrVbRRZXZx5thu1nnvgMKLom+AXPnFN9Mw2qCFQKrEDntFulBCfBnLwlC1HAd8XFc+ZVsCMLX7ttwHY6a23qY0RCvdHr9PtTOMw37XqKJGVCOboT3CHtKG6jSqYF2uVhtLIpHaGEhlxJx4SP5nN0TOdx7HU4Ab6UVT4tllkwAXbaVcw2ZppwdgVi5TxiHGcx71gYM3KL9/x6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZgkuZ8r/VymLdhLJB2PMa9DE7jwyd1kzggyTkOXJs4M=;
 b=uooCY0b022V/POSlpBjKRsvqE6BFKxWJzmKNa4Gr0fy2Ehg2XzVjC/cTiMK3dY4/Dgfhb336z800dDsHyxuYTauz9zHaUDXq+pmKyh6fK7+EtuNMuBeYA5xrWLURCdMvoQtZcHDHDgnD+TA+/oY1voSIimpUu52WZpFFoiW1CjQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BYAPR10MB3560.namprd10.prod.outlook.com (2603:10b6:a03:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 16:42:54 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::65fa:78de:f4d:1a5c%3]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 16:42:54 +0000
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
Subject: [PATCH v7 1/8] x86/crash: fix minor typo/bug in debug message
Date:   Wed, 13 Apr 2022 12:42:30 -0400
Message-Id: <20220413164237.20845-2-eric.devolder@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1bd8d276-be0d-401a-c573-08da1d6ca81d
X-MS-TrafficTypeDiagnostic: BYAPR10MB3560:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB35602A7E01242DAF345E2CAF97EC9@BYAPR10MB3560.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JERVDt3/ZY3xe5Xl7QfJv3SaDKV84DiInywtpRiQrlvSta5War3MYacrOJuC30fxdeWasnIR9CgvNUQVVLXhcDGSCx/srdWh4LG/5YO85zSlhPDdjXRY6S7c00mJbcsgTLhdRleBW0dx5UOH+o6FtU3xXgOR5nyR+wcO47oSapCi1o2u/LOaWjjljRI8PxWjQ/Lj9nAwHEPIxI1PjESHtEHkXpBDxSwSdrYuMGYesyFQiPyX0hhgbv8BfARm7gUnTdrt9M6o3WYaKPQxF1hNaO7nHBgr2/BBA5ZWZlr7+Er8FIbhokOsk3iBRvDP8c8E9gd42/hrGrLsGbbV037/UepywthPpj3z14ZVqs5if2GXQw/CqpA35jrgeNpOLJik/3t5Cqg/rTYTEjX1yqfykHLQRPcR9PhNpdnuUC7E7Ftx8iUIh/XEAiw11m0jVnzQFAHOOyvD6/Xf9TGlhQniki52TMydGyhc5QYISJTECT27kwHp5qddaWLLiVdVQPy7dVtSRs26Hg2K8H0+hH67y8j0RSMlgJOQr4ZEWAVblhar792SLAK7IqEGg3e5FspAygQJ3U2CeQlULXc7zXjtBtFjN6ocCz9wWOH+NI28wTyvKnk6ELzb4L4irkbQtFL5t/0PeSwNwd3RuByPx8y0Apu6NeI3/lSnejaXQdz4fibwNPS3r9+Fzh7qH09XoCe4pCDEj3zrlZ3hKs0PXyAa2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(83380400001)(4744005)(38350700002)(66556008)(36756003)(2906002)(2616005)(6512007)(86362001)(52116002)(6506007)(38100700002)(6486002)(508600001)(66476007)(186003)(26005)(107886003)(1076003)(66946007)(316002)(7416002)(5660300002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TwVWrxPyCFyvbG6tHObRn5P3Zt8iipKzTLxXl+xNRxnTWvspR3lVo8scjikV?=
 =?us-ascii?Q?Yk2lgYHxfRbqfYNoWC5e0cW+7n/vlbnRvkIcH+VvNQqHWdV738QEUyR2N2Zq?=
 =?us-ascii?Q?ogV9+mj2Uuzod2rgL34DKxLG/85AACZmM27xSLL83iFuAaXkS3kDgC6r+7T+?=
 =?us-ascii?Q?jMXNsVhLioPaInm1tOx3x3wn9vG21OsSSCT2vInsc5Sc2CAC1I13c0A09b6N?=
 =?us-ascii?Q?a67GmsLC8f/ILQ+dqt7Pfg2/EaMH08Wk9JI5gGIGakEYjoXm6QxoYxfhhVhw?=
 =?us-ascii?Q?qrq+Ie+Mmlx3k3ROGJr153uL5xd+V2u+tE7+ylQY5MRXv+dKihRQLByfjxxO?=
 =?us-ascii?Q?1HbB0CelkCjl73NDzql3znUaZ+5+Hpx1qdFjdTVvPCLJDYl185rbAqHfvFI8?=
 =?us-ascii?Q?LvQHJjeEdGOtqEDK1uApbBF0oxySwRkNE1iDZHMJ2KzpclYFyMUODma4lrfz?=
 =?us-ascii?Q?uHEk73yUhSDgyZE+OrHBWfqt7NeGAntzz7DhPNkO7nD/qK/ARyVyhPX9DRqu?=
 =?us-ascii?Q?J85zG+hBGiQ63FPtMkvFaDyyRFmE10y0E99TXJkqVTPm85hbuT+2CyXPJbNP?=
 =?us-ascii?Q?Ci5KCeBT0M7mYJgtouuOaDFJemJSu3Imh9n9mHAh0TJWL8I5BzdmR+E6LAan?=
 =?us-ascii?Q?n26ti7BYcw88Tn/UyaLD/pZt4QnktksGGlLhHaf9BS/wTl9aASH3tUlOww2d?=
 =?us-ascii?Q?XJa8CDZ9JYO7reo4GzjgYOQRP0XLETnFRUHTJcZV2OBy3dMd250yfe83lQJz?=
 =?us-ascii?Q?X+L48Ldd8btf8db2hNRhBYSxeYVfyb7ZCGIhZ0iIZBW2RoCy6bKahOBMcis0?=
 =?us-ascii?Q?14gtEzYrwcw9hsODW89XCMtlwScBA6bSv1D/xK+4iS/9+OlaNLaUZgjUBBec?=
 =?us-ascii?Q?/S7M+aDlveAd1j+TW/KlBVXdwV+L4mmSScqJMK/2strlIZR04WlPnaGp+h6/?=
 =?us-ascii?Q?6lyqLQBfKjQ5QrOfooKgmRJcRT2oPYxnxRNAJATry/MttFx5sAoU1W7HmY93?=
 =?us-ascii?Q?zzuqn+tdiEfCOM8Hm7aX0MdiBEATkAGUnz48FUocabnvO7F/zTKhf3K1eaHi?=
 =?us-ascii?Q?Oz8xmZ7uz2FPemnIRcSShBsR03X25FnxRoRoHk7PAPt2+Y4a/kkqOaa7UpRi?=
 =?us-ascii?Q?iqgqfO9oegBkxGlGbeO54l2UkNl+2blExK5huubzIohHWDwNRknLBqHoOKwn?=
 =?us-ascii?Q?R9hJYTS41/b212V67bKBUDFb+16H5x5VY2j0/sCnhPNIytOljZkEZtCjgP3b?=
 =?us-ascii?Q?aSQ+/LgVIka80aqnA2OH8oIOOGR1b41cu0AeL7H+aK5dzGPprxx37ioqEHEZ?=
 =?us-ascii?Q?d42YDur41VtYOLuPBdk9zmMP5HaXjVR0goXAOcaUIk+KyRp4Fsq58WS4VbnF?=
 =?us-ascii?Q?vpFUo45IlPJJfMVuH7Ai5v+ZAmo/RrMoIzN55lSwb/c1Cw6kgT4GK560lEPc?=
 =?us-ascii?Q?1jm4Vd56W4en9gSwz8pgC2pkE3XA8lwb/OKsnV6s/NMc5RFWuY4P14IejI9r?=
 =?us-ascii?Q?pLYiSpG1yf99lYRXBgM+LOCPK1SrR/V2SOJGqwpxj+JRh9qNFQw23gUpBVjT?=
 =?us-ascii?Q?h051K8Ak9b796NLAuG/6OOtMqCgQH14WbzXma2Le3L+5L3aTstacQ7g5mhl4?=
 =?us-ascii?Q?5nSA0KcLeA2zCdcR9Z3fFqu0hUILHnyRrM0MNuS9OxvwGdYoPmjN15b0gqfT?=
 =?us-ascii?Q?8lYGWsSYxsjUMH1tqOE+pEcw7XLHqJO++u+qDrEArcRpMe9tOZsUk4NyBpVr?=
 =?us-ascii?Q?bHnwhxCKdl6+PIivOvPcuH48KUUm/V0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bd8d276-be0d-401a-c573-08da1d6ca81d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 16:42:54.2105
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L2aM/RV5AxW1wcgsM+vSzV6TNGm1M0Orc9Wzk84bwsUGPKzHJ04kzGKRLPTFJWa4BMVm8byw431+SSnzxBlmWxZwcyWYn74jLDisd3G84dE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3560
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-13_03:2022-04-13,2022-04-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204130085
X-Proofpoint-ORIG-GUID: vzi0pRSwzQwiflG9BNTHUKKkgvmNkE57
X-Proofpoint-GUID: vzi0pRSwzQwiflG9BNTHUKKkgvmNkE57
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pr_debug() intends to display the memsz member, but the
parameter is actually the bufsz member (which is already
displayed). Correct this to display memsz value.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
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

