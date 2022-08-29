Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D255A575E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbiH2XBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiH2XBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:01:17 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E677A76A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:01:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TMEFqb026106;
        Mon, 29 Aug 2022 23:00:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=lW8zNuSY/NFrf1FVX5OwmJ4d3miAC8eCUXfdH0INUJo=;
 b=XULPc/oKC2GwP2tDN2isW+GoYhx4QRAmkbMaGE3ja5xVUDdpFP+KoV+IK4MDSySJDtXq
 +DMhy2Qsgf5djHCcaAnydhOl4z4/JNO4SBygUD1Yc7ipYGW6NBdulwosJlmUkNawIjlX
 XjDdtX7eZYpb5AWddUDb9Mixv0Ec3Ns5wSMmHJIdAFr0S3+13jP2074dBFLaTyMXreH4
 fUUA7iZ0t38vVZODeiv2is0949k9RoRr8GsNKMxcAHQ0OIz2MBWa8fR3tHsSNYrgccbS
 IzCMwTQY30VCxZ9XOI12lcH/t3Wpg1aqD4qaY+AhEh82xcsTwejmJvc7Qik/vJjgk9cK uw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59vqd9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKAZ2m002857;
        Mon, 29 Aug 2022 23:00:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q3cds5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SzC+aytyK8Qv9f6fq/eK19MXQ+bZLcaHi9rHDFUlzgaVCpZsTTqTHaKbpPWpdDqMAM49AU6qQi307GXemBsgPCfeWySfLRj7p0SERnZCgMCrUMXGdKj5CUqXV6M2jfDAMMVbXb3LBuwbjug1Dfln+qcfpFOFb0QknuIKycb6wIUvy0SVemKCWD1ivVJwwsbdFgLbhsS7gEq4S8fBT6kdEFaT8ZVNl21K6u6k2AR7+MrN/WZs7C6Kxo8e4UsaQQEKbkXk2+eoi4Zydbs2Q1wCGSevqCuOewduUjSPv5YL981NXmhgaxDFwnA15WaJf4Am7Y5tD0J074n8h2g5k/wnkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lW8zNuSY/NFrf1FVX5OwmJ4d3miAC8eCUXfdH0INUJo=;
 b=dTIz1rNCLIEUxcDB7i39LzFnUWLg2EZi0vOpCS20Wp8KNSFqL5b5gS1iKZc0rKBZnrEm/Kc0S5nOdVyoA5+ear5tA5GJW4GJ0XuJApHmGxlleWn1YkWT4fZS/t6jw21n259DgmYlkrn7KeswyAPbBrHveCXXylfvuUVQnfGiZodMjrocvGnLuXgPbnQizjx6wuWsnwusTLFS8sB7NH1/FkKuKJ+oMjB9HVQE37eA0AFz2rc0+4sXw1iPAb0K0bRaQsIWUTOSFgZOCcEqj9k4ieGV4kLuoyUjmnDBS+cZkDPkVdSyc8FXoga1GD79habkp1uI3k2kMwI4dnowk85JJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW8zNuSY/NFrf1FVX5OwmJ4d3miAC8eCUXfdH0INUJo=;
 b=oQNXQ4/6IcPBwyihpArEDJA1C4GJMrXGWrL/8Ao9bX5E6WpCc5TjNdpESoZjGLW2LLGzbByLoyAJe2Y6m1mggOJYTrIR9eUHwIQ8s5ie6TP7ZDtDpvsKJY678iciCnxP+ay1tYPR0Yeh4f7QDXQq8bqIJ8eXV578NkGILlGQ++Y=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:00:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:00:51 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 3/7] mm/hugetlb: add hugetlb_folio_subpool() helper
Date:   Mon, 29 Aug 2022 16:00:10 -0700
Message-Id: <20220829230014.384722-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
References: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0044.namprd07.prod.outlook.com
 (2603:10b6:a03:60::21) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7eba70e4-0d28-4b72-fcc1-08da8a125178
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mMfpG8YO+BFgd0z5CMt/Zi4gL6ijYfJKIYJJ2R2bZHkICS0evUvvaV2JhRgS6SNpzUP6jEIAoVKCTkCDlpmHNcrXyhNx9l76LPdOq2lQ9W8Ad0Fp+fpCoBbn/OVZt7+CWEiQmai+VuFQbvntgcVrvKrP7ymXMCOB2gIEX9AgO4W6AO03gUlLbdDdVnrQ3lyUFxX6qu/srS0jVPYdO1U7xXOZgxT0OPPUcpOigZFNclg3YoUkrV5sQfYPp9B/kAyJAd1CKq+zfaxSOA5i1MeFhSJX0pUOxOwBkqNVJmtYqdt8iSEk+57Wep8XcddzfWO0mzjCAP2yOTudBxwdbjj9aiGzhk2iHKuYwsFMyqNBtpWQ9rugb6pnpL68/LDVhece3LIukxlWTc4YsikTGg5hjxRTY5EwTayiKBM9qKXvf6MrICpWoTdHtN007svrCsSID5jBYtsIuQInPxZVQoc6IPlA6+ZFSBcvGWtomVOs+BjkcqhpzdVbICclCDVJBcDLkIJt7mS0/iNYeDbKT+PqmpK6jymnxW+oAXBUd/hNnKhcuyNNIU9+/rmQCGBeo0cQfZEAMFF+7jn8GvId9SNU6Ld8XyuNqm3g4cHgxxAJrq8cuDkOQ0C67Fh7AKjxLT4Y37U+CzVG9bvzbSxcyRALRMgRSU3bUfmH3zXeC5ChA6ORCiDeU+4MKM2NJtr5c1DAuZOhrqndh8KVQIpdZPHKZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(5660300002)(86362001)(1076003)(2616005)(186003)(38100700002)(44832011)(36756003)(7416002)(66946007)(4326008)(8676002)(66556008)(66476007)(2906002)(6486002)(41300700001)(107886003)(8936002)(478600001)(6512007)(6666004)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WZEbXhupuJxfiPljylUJJ1KXHsdnBa1K1s/uUfG14GV0GbH/9qQAysz5X/nK?=
 =?us-ascii?Q?5XQX50M9QpPwdLYoYXzt+jmqVhewbZk5aub32iwWtKXr/8Y6syF+zFrw6A0x?=
 =?us-ascii?Q?zEZE5Empl5Igb9s4ldVK6w32veJcYPN5zgB5DdaEB15nDLxGrIvHDUM3M+3V?=
 =?us-ascii?Q?0RNk2nDrgEjd86sGhKG00+Yxakbu3FJaVDox+xC9opkuffXjNwBB+LHXY6eD?=
 =?us-ascii?Q?hgkG/50eLLbUYB5Rjq4cNYgEZ40Hu5v9AZpcYvU0A2UJsf2XLXcnONhjdtPd?=
 =?us-ascii?Q?b3khTjZg28jEunK1F6C1RQknQXLd8htgp43/5SyXy4FeuYf72KJAm86tQ4re?=
 =?us-ascii?Q?L5eb0Ss/dICSRR+UtbItNLz21nBEEoEJKoMxAoWZ+cgB6Rxood/dvFWBrSvS?=
 =?us-ascii?Q?vrsDdKAPnM90gyOKJTi4IAnW3DPViqCz8+lOOo2L3oA8BRwjCiQgq/5MjqdA?=
 =?us-ascii?Q?lnFLEwrTE7V7/ALuXSNGOwCO8vrgC27bE+i+jJmQ40jRe9c64046GSf5VE/Y?=
 =?us-ascii?Q?v4LOV+nPoZL9DIIpidzykzBb6UZ/W9s9HZzQfNTnRoEpPbBYvORsVb4NgnVH?=
 =?us-ascii?Q?B9QagE7UZVh6MLirc/knYWRgFscLfyM+xLe5UR7XudBJS1CdoflwMLGfo+Uk?=
 =?us-ascii?Q?Txac7SmbzWPZsYgGSsFhZ9FrYfCRT7pzLxbPZsH2oNhfY3efWJOpTVsmt7aS?=
 =?us-ascii?Q?AeES7/fNsATfg5FuAU4Ikdb6GFaS37Apr5wzDLBerfcxpcTk6fQzVudvYmee?=
 =?us-ascii?Q?4bvLJ62/XnVStTt2r8rsV/dB8zz1Ro4+pOVby/sqwfUs46D4OCLcemgfDH5X?=
 =?us-ascii?Q?HjMnE7ZcwQsVU5+YNnKuQWT6BCwpnVa+2ut3IQbRHaBXUljNAFk4JuXTimyc?=
 =?us-ascii?Q?pR2kJtC8IshSIw+NFbZSgX0FtnRsIIpmtVjzCS5hOsgUsgra7yT/qGFtMb5O?=
 =?us-ascii?Q?g7wucgA0RlcPx284kuVvadbuh5pQWnm2RkktX8Dzlkm3I1NuXT209ythfw9C?=
 =?us-ascii?Q?OzPRj5mSM4+y9wRnaq502O0PsTQLuyV00YlFnKwf9pc51sZJirlrwFzHp5iz?=
 =?us-ascii?Q?7GObF4uNZkkPeXzd//06loY20G3k4b4Y5sz7gBflMYF7+xRS7RuWGT47aI5D?=
 =?us-ascii?Q?31dyav7O0L13y7doLAUhQzkWETzvLXxwO9txspMk8pefKTWKxZG0xTcM1ibw?=
 =?us-ascii?Q?5+0r2zsNlvHHqcueRtyO9aqV+dQPaY+/RIQAgApougRvYbSF4BJ72gb1YWHS?=
 =?us-ascii?Q?VfUZZ9D7o2RkUp5sj7lYEA+0aNpmgnG6csXE0ZSYlfS+AHJOH6YimlnESx0P?=
 =?us-ascii?Q?hd+ezYpahzW28TRXWguQrUFYr9p0i9f2lVxRbHoLJg7Ff+htmBb4x0mRSaXe?=
 =?us-ascii?Q?UYY0rLnjmzFrjR39srC0y1aA0Nvbq6FcQ4Su5HZ9YqPrDlIX6/Z+sNe/6Ne9?=
 =?us-ascii?Q?o4wvwFI6ux/27dSXXzEDAj0r9IMOmgZYAVgSWjxgypenKow76UAnlVb7RQk+?=
 =?us-ascii?Q?GMw+cq9HrUkBNdFf8rlGjcGnYU8z9hPvEv8Rm4iGj6UgRt+p9chpeNmP7khC?=
 =?us-ascii?Q?6xRz7+3hYmFPx7ZRn3J1JDvSEbhy6J3YxiKmp1G9unRdplLJDaEVS53E4YMi?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eba70e4-0d28-4b72-fcc1-08da8a125178
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:00:50.8368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrST/ChD0SEZHLWG1Boy0r+9zYet11dbh02+iXDCrZscoZVoTfBGGm4l0UOa3w2aFMEcNhPL8Kkk4bNKWA27eTfVgnwCz8KqZrUUQD1e4mA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=889
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290101
X-Proofpoint-ORIG-GUID: wy_tesyjY2TTG69T0lq97ToNFHEQCYdd
X-Proofpoint-GUID: wy_tesyjY2TTG69T0lq97ToNFHEQCYdd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows hugetlbfs_migrate_folio to check subpool information by passing in a
folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 4 ++--
 include/linux/hugetlb.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9326693c4987..d1a6384f426e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -970,9 +970,9 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
 	if (rc != MIGRATEPAGE_SUCCESS)
 		return rc;
 
-	if (hugetlb_page_subpool(&src->page)) {
+	if (hugetlb_folio_subpool(src)) {
 		hugetlb_set_page_subpool(&dst->page,
-					hugetlb_page_subpool(&src->page));
+					hugetlb_folio_subpool(src));
 		hugetlb_set_page_subpool(&src->page, NULL);
 	}
 
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index c0a9bc9a6fa5..f6d5467c5ed8 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -709,12 +709,17 @@ extern unsigned int default_hstate_idx;
 
 #define default_hstate (hstates[default_hstate_idx])
 
+static inline struct hugepage_subpool *hugetlb_folio_subpool(struct folio *folio)
+{
+	return (void *)folio_get_private_1(folio);
+}
+
 /*
  * hugetlb page subpool pointer located in hpage[1].private
  */
 static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
 {
-	return (void *)page_private(hpage + SUBPAGE_INDEX_SUBPOOL);
+	return hugetlb_folio_subpool(page_folio(hpage));
 }
 
 static inline void hugetlb_set_page_subpool(struct page *hpage,
-- 
2.31.1

