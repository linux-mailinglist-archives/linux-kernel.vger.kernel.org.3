Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5165A5761
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiH2XBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiH2XBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:01:19 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB387CB5A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:01:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMDwwG006912;
        Mon, 29 Aug 2022 23:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9F2h01/pWs7VrwbiyOkSAwUuubzwCxSyEoXyTacAXY4=;
 b=ofi48oZOdMmtTMRdvI/YNQTaRBQ32oUi5XmjvamB1Y6NxfoZarMWJFWPK/7djlck74iL
 WXLqRy/Bn3BoYoZxjFoOHcrKvrczSTV1k3FxTZsapjeMWlrz3ohMf+NSVawUqCZYeq8F
 bnj5az2V6+qwqda9l9q2gtRGcjJnct9mGcRttCxLtkxtLg1ytLcesTyqTREyfuKf76xt
 0Kga0cM3zKDx2x02zhY2N6fg3fNzRVYbzCBUKgq0vJ21ZG/KF2Fe1BulNvrT8MYiUB8v
 tssWtPR8QmIWkABX4Wh2wg/xh9kwKfBbmleKlpeiJPsuqE8il36hh57QJYpag9CtsDwV uQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j79v0mtwv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKAZ2n002857;
        Mon, 29 Aug 2022 23:00:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q3cds5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a04RSctgC3Fojown4nHPiWhQ5x60aHTM0PB9zy+haTbAbpIQkpRjdW8ZL394jdLfiGQJlM2NG7B09I8EdA1Eom5hml0BfEswTrAVUK5aqCtnu4f9iBNzHADE0YU9lPxcmFFW0DwFErVY0ovCvWMsXM/WacTQJg9zpFpx+Xbmo2Q6+QZlCJXxvQAKADLGK0hPjYf7hOVmKu6o3OdoYAsNo0Qyby1jkqrzv4N088uZbEnKL4voMUwAWB4yG2hZ57dfEpVi8/vvjW8rptdHXr43+iwJDHdHO/N5s4M+T/jKM1VsY9+dni0OyCXFnryVeRJoR5I7fgETSpBj31APsgmeSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9F2h01/pWs7VrwbiyOkSAwUuubzwCxSyEoXyTacAXY4=;
 b=B2p/JzUDnF70cyMHLzCoqN1utJgWZWsQml4ltw2M3NdLzk605f/aukrfRA0X2EVktRoAGPpbZZ6uZqcltApZOFqW6dyWbyq/1z64Y841x4NxmZvQre1chJ30UJumoustAczWHp67IP0NqnHV5kNXnfb5oVvK22Fuq/rk880BO/qw47brcmVJ1As8VZ6FaC/GjQgkYDyjnVcQYMaHJI8fVljbWcFSo4XyRngUfpbW5NmBynFsom8TOGBw0FBbNGbpwHIhRoHxybnZNidD/TUf2qc4dFEtvXdiW6PBFWcGE3U9Vu3V0rzVMaTzXRfeXPdzT7tR4jQhITAGhN6k2ibZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9F2h01/pWs7VrwbiyOkSAwUuubzwCxSyEoXyTacAXY4=;
 b=kjkUuZZyU1MkBCXMGZOPhfJdESRZJrs/kFMV6zcOQwuK5z4jF239fcVE+GKOztekRir7k6oV5n71sirgeuT9T44pEKyRW0JaLEiqBTICg97h83fSMdTfhRNL1h1eoGaXFeTZR1MjgdugozKhs6AxQ6ripqKmHZZRrRKPJiaNnQ8=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:00:53 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:00:53 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 4/7] mm/hugetlb: add hugetlb_set_folio_subpool() helper
Date:   Mon, 29 Aug 2022 16:00:11 -0700
Message-Id: <20220829230014.384722-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::24) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4d6d4aa-4d10-49b9-a681-08da8a1252d0
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvoLORL0uLbYeOOYjHHS1dUT1Fdl351YRmEpXDysgT+vVh/eC37ngInAcj/Cy3BkWfCvuoCIoUGennvGBhDJUV7holFsG0PQTvBVsqC2MohWUcLKfNUP4pjPbCa5Wa3z96NaO9dWQR6I1SqbzvGOFap8CGT5S+IXSX9zaS6ZKclbUub4gGwjgkCysCZp+r5Gy7k7lU7d4gTDn91vz6sWNRxs7T7IiCAordVtg5bgyTSDL5op9uXsp8PcehyRT/tUp3B1ttV4RP3JHSCJK9WQJw2zfEPWEFVpFvx1dKSa72vTzUVJDFGs8Av6ClDPaPNla4MSB6YIiq6mRVnh/UyoByLLp2uc/ePAZMawmVn+y3k2FhpXr+ze7jJhEistDiC7M55qI0onNze5/uib2alMG+dgppwn6g25BzJEYA5uBRN0noHMdBsGWbN8kl1c7Jj+XWCe/+NALXDF8nh7tZTML7eP5RPP+uySmgyeYPWCRnqKXZDjbAbWN5IXy/QUKJvvUN5NSLdi2nZs40dOZOq11+dp7pw9WnMBz23wOwOUXALgCNf02bMIvvaT960/5oecHCoA8n4oPbViLAP2hUdxqjYlsDI3HdyHs4yj7zhX+fI+d2BB4r5QWo0OMYEYnjmtpYu2rvllL2/1dQmW6U+KwH29MYJfWPaFd8Y9Nne2+crYVyvCwhaIJX4csQ0qu16S3HpEbH1KnrmIGCdqBuVFAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(5660300002)(86362001)(1076003)(2616005)(186003)(38100700002)(44832011)(36756003)(7416002)(66946007)(4326008)(8676002)(66556008)(66476007)(2906002)(6486002)(41300700001)(107886003)(8936002)(478600001)(6512007)(6666004)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yzq4himofP/NVMJhVH06W/7EZWuJh5QuFP0N9zWJp3TytqeUFqkasPCRSTU7?=
 =?us-ascii?Q?E4MysEwL0e2wn1ZZubN5a4uR7pt+WuZT9WOlLAjjrxw/AcDELd3l/KtrwxA2?=
 =?us-ascii?Q?mvBNCLvBM/27miHKxKptEN8ncnVUZJcxnpWxfdFdBkaZuZXBjDmBMt1LUmjA?=
 =?us-ascii?Q?Ru+RyRc2ZHTycJpqIm//i3A58aNZ1ojmlULA5FSjH7NR8yXHUCzncJBlI5mV?=
 =?us-ascii?Q?91bryPybqjlVUMZMK3dgIFIIrIanCWNPqfQ1mB1ItjLJHmgDGmqIAQBCibD0?=
 =?us-ascii?Q?4L4arktrvzmOdfVVHo8Vaa39n459UiN00f9c0aYe7YzHPX9gqhm9kh8sfA1S?=
 =?us-ascii?Q?gSs/nb37HEYGe3+o0Jthoff8+tJ5Nq66DzuaF+nW1U1Kekw0WSVa0WtdsYcb?=
 =?us-ascii?Q?IQy93KFnu6tYSsLQPWyGoGn9a3a+GUf/l3hgLVGRl50x1w5Efwjfuc6uihrz?=
 =?us-ascii?Q?4Dhz/YI/fh0FCj8UmL4nDgxniemOBq9zNmKezquxJA/UifAWRzRHODAiExlS?=
 =?us-ascii?Q?ZVnr1CuuVEf3NIvhATf39lsAJYPwMGk0CFVb7nTHwOurW3QrpGQbsAzjGnJW?=
 =?us-ascii?Q?SaBZ/l84XG6QRR0KqroJgmM3AuUY2G5rD9p0vmF1ZBNm2Y639RzyltKT+vsA?=
 =?us-ascii?Q?9+gBaoe0GliSjGfQBHdXpE/4J51b/7fLT1Tg28Mr9dC6uHPfP/+mfPj6NLgG?=
 =?us-ascii?Q?MNqGU4DwWTd2Gg1Zs87LmUIeUJsj3M2tc1tRAVisD7JL3T2eYL90WCMqgzzj?=
 =?us-ascii?Q?ukaF/KDMRcW6S2t3G9h3AIX9bIde2L6MlVs6+8XjUmNH+yEcTLB+9WGoJWJe?=
 =?us-ascii?Q?CA86VqaAt4qCS59/J2M0iXOcea0/b6SaHvYv/2IALmdYGbtj22eIBUfU33wr?=
 =?us-ascii?Q?PnB0+7kCSDxx6KhB6YX9qh6b7gvV6cyGC9PD4fUWq9NnG6HRN191IJdzSF2f?=
 =?us-ascii?Q?RwIMrFFIkC7t4AC9EobR0I5YQHdmY/8A+cXEVRScFH/88UXATfTIEBJX0fag?=
 =?us-ascii?Q?Pmzm3HQl2cQpubTppig2uJpPMKPiTHpVt44XYtQ0hT5D4UWXYOQetfneVtJH?=
 =?us-ascii?Q?wY2KLM9EVCs10giHcmVd45XP06dVhxqdOfy60l1lyw7nD1orzyaJI+8m0uBN?=
 =?us-ascii?Q?RNqHHHRJk0KAdp7MNopeZLjqvAGQD6x1Ix+C+Pl4yeFTeEgi8S9Nc/P6iymZ?=
 =?us-ascii?Q?Msal3FLfaA0bm4FsxRtWZUn+BuOGJnqUG0VyAmQDrPii1wvZE+p8AH238f7p?=
 =?us-ascii?Q?4mYYd5e/ISWICBr4rXYnq33vkEhJXP3YMTwnPxvTG0oOSXVk0Y+lamJPW2z4?=
 =?us-ascii?Q?Uhz2efwTQeFuxXuFfqfA3yWiQ/EjeSO8IZfjk2sqHzQ1JfqyXtGNsepY0uh/?=
 =?us-ascii?Q?j2lEq6/uSCTDffV3Pt2KlZE+raNnHrPVDqmkhc4jr3OlXuUCoxmk63gzrwsC?=
 =?us-ascii?Q?QviPuysR5K5Nt5P68JAKrn0OmbDYeySyb3iSpG2cU/PE5NLqbmKInxkL/qzB?=
 =?us-ascii?Q?SHQH5hD2b/LoSologiQV8+WZe4PGeZecf0KOo+CMeZrl15Axb31AdNNnAy3t?=
 =?us-ascii?Q?In/Bp2Y9OIwhRXQ1U2KN11uVoX63F/rWlRPQ3ThgyV0MhHpTighQcEREB0zi?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4d6d4aa-4d10-49b9-a681-08da8a1252d0
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:00:53.0734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cslOIOjGA0uBpJBthbYRef8bvFGzVANR1kDcuoMX0zMtTShqUeSkQUpxYokpq0be7BugOQBJ5V/lmTe8QkMmocQXDIJtmIPUkU80vZVKy8g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290101
X-Proofpoint-GUID: awcsTW6QAFAN-pmBOkj8TtgQnQ--Z7wR
X-Proofpoint-ORIG-GUID: awcsTW6QAFAN-pmBOkj8TtgQnQ--Z7wR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

allows hugetlb subpool information to be set through a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 4 ++--
 include/linux/hugetlb.h | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index d1a6384f426e..3b5c941e49a7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -971,9 +971,9 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 		return rc;
 
 	if (hugetlb_folio_subpool(src)) {
-		hugetlb_set_page_subpool(&dst->page,
+		hugetlb_set_folio_subpool(dst,
 					hugetlb_folio_subpool(src));
-		hugetlb_set_page_subpool(&src->page, NULL);
+		hugetlb_set_folio_subpool(src, NULL);
 	}
 
 	if (mode != MIGRATE_SYNC_NO_COPY)
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index f6d5467c5ed8..d8742c5bf454 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -722,10 +722,16 @@ static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 	return hugetlb_folio_subpool(page_folio(hpage));
 }
 
+static inline void hugetlb_set_folio_subpool(struct folio *folio,
+					struct hugepage_subpool *subpool)
+{
+	folio_set_private_1(folio, (unsigned long)subpool);
+}
+
 static inline void hugetlb_set_page_subpool(struct page *hpage,
 					struct hugepage_subpool *subpool)
 {
-	set_page_private(hpage + SUBPAGE_INDEX_SUBPOOL, (unsigned long)subpool);
+	hugetlb_set_folio_subpool(page_folio(hpage), subpool);
 }
 
 static inline struct hstate *hstate_file(struct file *f)
-- 
2.31.1

