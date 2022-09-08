Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7785B26F2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbiIHTia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiIHTiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:38:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAE6105D68
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:38:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJYTC013955;
        Thu, 8 Sep 2022 19:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=GixI24Pvd6mAjGQnH3OpXlA8MSnE6naHpcIcS4mP+ok=;
 b=UfNLYrU7ENmFBLxksiIrkIigWFsqykZpVS0JRigP3daae43mxq5Umazap3M/IwAX9klc
 AsEg0Xl55ggL9MDYwaghoTqwzRjMDGy15la2zZJ39fcNimqweO6X65S6fYB81MVmTKF2
 1LO9U9lxCb+trcVsoclxOlB7gx62uE3qwNfSBU2OdkX7azGuGhM8AUn2Xy3+u3SEi16q
 f/kwaYIs+HhxROyZ+hh/KXqbgNFB1aF8eyX7lgYOXwDs2+rkEqDVDFNbz7FdVaJiLnvI
 5eInjTzZ8MwsEmHKKeWsjH0z/LbvOloE/fO+gQawnqSFHQARImf043O8B4eNI7jjq/6W 7Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftvy1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:38:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288HtegP007027;
        Thu, 8 Sep 2022 19:38:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc6erun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:38:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUuUP5GsGEjY4bZediRZh8J7/F7zgjKHWeLjiHx+4zmwPfGjcEh1JeIQUmNVLtXMHfKWH01fsLMa4CtEOYTU/U9tVB+M6ulVgtgEgBhLioIXFfAkjk8cx83qgikRtyPyzMDo+kbb0V6hnAHIuVRgvbW/5DcRPYtV2iDeBE24TDpHXtxGkCkwF+E/WWKv3qJg/v59BBQAJg2M6rO1057R9pgWLAN/w9g0CSJksrieSeXnarBXER0XTSQyUAyF6wgoZ5c8W9b9q5Z2fWDKyHz3Cl5QJZq9WeH3YVHACKLSRDztK+bOMfkE1GbGU5nLCZbFiOrz2BU8uVQJ4Rmrdq2oqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GixI24Pvd6mAjGQnH3OpXlA8MSnE6naHpcIcS4mP+ok=;
 b=C/FN1GCPKfZLvLc4rhfNVC+EP4cnQOMqEY2+yOx3ebtXRU+c+OVpRwooKaAaJbWd9O8QNliYTPrF97DsZUVwH91oQS9F+TKmov+NNIS2uCkVj8BFtKFoGhOF4J8iBfQnU0rz1ZEHVAcyHvxBiTtJvtpfKDLNtYmSry7XJUuy+jIU91IHedryZuP1en5QfS4ON2F3QZiWs3IE5hNveWOXLe97qITqFQ/ZJBUA7BkUwxSTrxni7EiA/XMf4zu+VdDfQL4OC4XGopsvsAWFg+OARwIfW7jhShIYRU+7vsUuCcx2VeZBYO7T7p5rtcB/GbQRPqqZJtDp1T2VrddbuixTLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GixI24Pvd6mAjGQnH3OpXlA8MSnE6naHpcIcS4mP+ok=;
 b=KIDi7Pg1pdZX/CLVjxl3CswJRzKfcgkHH8xMUmQN+rfnXnduvuAKOxm3c1t8hv4UL9hh5Yzm+x4b0FMI9Da5x+fy4mYDZWZpXrmNz3wHXebATfit8OsCiWUoT7NgxPVs7mcIuczKOEbhoD8BOxq1xierDs7Xgum788kSrlrS670=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 8 Sep
 2022 19:38:02 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 19:38:02 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 4/6] mm/hugetlb: add hugetlb_set_folio_subpool() helper
Date:   Thu,  8 Sep 2022 12:37:04 -0700
Message-Id: <20220908193706.1716548-5-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0066.namprd02.prod.outlook.com
 (2603:10b6:a03:54::43) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM6PR10MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 3affa7ae-f072-4888-aa6c-08da91d1a485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gTYoQIbbKzARYFpsKaKrShC7UPNp0hZsdhOSwANKh+9YjUi8tAGOJxU/xiB4Rj/v5RKfeLzbVfvr0eRzF4qvTlsrvk4O+czX8nY7lLSuzhnKcX+hfRtD0mt2cpMSH2S7msKCOMg7oB3tKCuvmFaN5TYnZ0PmZE98717lTJURCWQvo99SHz+4/X4Ajh9PUxELp6+A4ahoYFFxauTf2vx4vEbza+W9bPSrI8puKH/6td92uJoj+K+UkHKKI6Sexs3zhmBKBPTHq83p3JBCY9Zqb/YT0PknlNwtA4WQ5Kld/XCLmCBGxRVZcKkDveuRx2LhLe0XZv2bXzMv6GklacIZO9DumsLSZRYPUW9h61bstWn8zFrgh2RQJWeA1GX/Pi/d29pJJHj23sI9rcghhqzco4nUvxKgrWBO/thu+/1TMrqNF84ISfwXQ+cwFa1fwgnA63LwVgdj5hMT8gPrtPctS2RFfA4LuIncNMqmF5FHEiNfu8YYWm0oalvSGbqbywZ4CFaK55CenesZgZ9oAj6oSF7+pN0kyzPloHepaf5kZjb3xabxGMHxK7BJtJJ6q0PkOuJyOVycT8f5Gv7WtIb3zXXYcfwO+KUw46LgzbIIV6lrLDKTHmjqvB6b8XoE6WeensJSUf+KBOguiLP6mc1VfpFhEkBsbX0nxCcQZuJsOx5o4aDBi540NUBQL9FsU1JMKEEXhWWArJJw05yCb3gXjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(6512007)(6506007)(26005)(107886003)(41300700001)(6486002)(5660300002)(316002)(66556008)(66476007)(8676002)(66946007)(36756003)(86362001)(8936002)(7416002)(478600001)(2906002)(1076003)(2616005)(83380400001)(4326008)(186003)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g3e7Iy6eCN/UE9Uz30TX0astYRoLrldTbhexdvY3+0Wkvu2iEXOZdd19TPnb?=
 =?us-ascii?Q?F5iA1cdiNbp6yjoUuV64ModOk1g1Qftajp5gW1HjmF+q/8i67EDtVkaphSB6?=
 =?us-ascii?Q?FOcIx/3BG651BR5Xs7PyyJEM99geEMI8GI/M4liJEiuw/2GlkMVm6v68K7jX?=
 =?us-ascii?Q?hxgoBcjJ4aRm0ZBxkG+Q1pILQKroayH6/7eeD48ajB3BGO2GXaPoTt2zu1sE?=
 =?us-ascii?Q?2lzbj4JhM/JdX0A/wDf34U3VY8NrPqLiYSwm6w47svrPS/UT7e7/qPh+NIj+?=
 =?us-ascii?Q?hMtYrm3x9ozBwOQSwjH2M9LoDbspDfhdHEd/Lvcf7p1chSN8t2gkJOwTKav2?=
 =?us-ascii?Q?rOZ3QaI36xH5ZF/cwTpL+84/H/yhtWnZGiQAnmQZRdf8PoEjUTZFGakbHLQ+?=
 =?us-ascii?Q?iQlbWpca+TM9janZ8flEV+FIk8Ctft0UBpXUKrDTKJbo73vqeC1Lh9+FjVEk?=
 =?us-ascii?Q?8L4IbvfJXM1C27J/JRP7EuqUzmCzQY90nsES01LL3blcSQR2MrDyujrNG2sL?=
 =?us-ascii?Q?NF6nYfkelwvN4aL9jqr941Uw+asKHT+4PTCMdk2ycysQ0NgT1KhXG4+nnmkl?=
 =?us-ascii?Q?ZxCFjGdAbEm+BbVxkzMpsLD3vFJOWn80sOHX4l+xwbDmc6XJtdCA6w+PiZpT?=
 =?us-ascii?Q?kEjUmz1UC9RHbEAjVoB2BZrhDMpS4mCGwzO7yezW4Bbw2iSWfs/Hljs3Bd4o?=
 =?us-ascii?Q?R7guC3ue5FvlFe9YKxe5PY7KCiU74bB8bkQ7o6oVgtWSEP1t5+vosDGqGneD?=
 =?us-ascii?Q?UnvCNoFhAwduSLaDX1L9F8tL2Saup1F3PBVlRgJYLzNfX02EV4IS15l05hCL?=
 =?us-ascii?Q?sR9bbi//xMCj127Cg/fNfoU2/JrTLqHiXTRhejggpUPhk0oOQmX3AKRISRQx?=
 =?us-ascii?Q?1mSsZqzn427BF8hUOIWQVgA1rBZRXJPXvaUNhMEqRpxKkXv5rf4E7sBnTcGp?=
 =?us-ascii?Q?v8Qu2yXANyAdDxnpm/i5ulqd3BcGly6MYPyMZ9m5cO8GETEZ0j/9C/4TQsOe?=
 =?us-ascii?Q?dRBEKLFegJvk+a9s5SGMl1ZgF4ZNLSRtVYDhDxUCv1LgoO0xHey5x59scHpo?=
 =?us-ascii?Q?S+aZaO2m9aH0OKPWodgHTYUkYmYygATuae714dF0/RrOSaeFGUkbcZ0jbfR8?=
 =?us-ascii?Q?d/wmHFocFwfq1IpQsRi6VQdeeH0n7EAKRO7Xgoyq2uziRhTBsQScCZTCqNR1?=
 =?us-ascii?Q?/V+gRrHwlpgi+L/R9kYQIHvwzhQkK12WYc/td10dnfOWuSYcZBRQnVStpd6O?=
 =?us-ascii?Q?GoZhmPWphJw3MWTGwwgADifLGs0PsC4kCmGXkZ/MbGQ6otoMvVX9Ay78211S?=
 =?us-ascii?Q?8/cyM2IvspK4m4au1/+TvgpiAYOeOjjaRb6GZ+PeUkYu/EIGTLFTeJui3ZsU?=
 =?us-ascii?Q?uJsC1sf44BpUoKL3NHYJ16T0ohXuWHilK2k3mdPozaJK2wbDmj/CZICfYce7?=
 =?us-ascii?Q?FLqbLfjG0RFe/QOCEsoPfc23g50q+lCAnCGnGxE5Lmg/831B0uIvNIN/Xg5i?=
 =?us-ascii?Q?U8tTQneR8rQCC+FpdANF7wY4PB2KVKOcSWzfK028GUJz7ZG5KZgl9z3U4t5F?=
 =?us-ascii?Q?0OAW71cyRSmTBbuSBEn4zv1QW5Diy8fXEz5hM6gb+ItZ0bZ8cABPB8HGHqFB?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3affa7ae-f072-4888-aa6c-08da91d1a485
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:38:02.1855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDdKBdb8p7JlaCtK0Vim9k10Ol0/BtQ0G0Am+ZvafRnSbxv4WYzHP/B+zlrq7y5TF/5Zlc4HBKgU6sTugUB99cjwbC25jjP7xKqL5cF6BOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080069
X-Proofpoint-ORIG-GUID: tgkUqdThCCp2GO0TwMxuack-AQomZGI2
X-Proofpoint-GUID: tgkUqdThCCp2GO0TwMxuack-AQomZGI2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows hugetlb subpool information to be set through a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 4 ++--
 include/linux/hugetlb.h | 8 +++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index c2e9c0cdbd81..d9e08c445e2f 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1152,9 +1152,9 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
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
index 1e7c4007386e..0bcaca694ab7 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -757,10 +757,16 @@ static inline struct hugepage_subpool *hugetlb_page_subpool(struct page *hpage)
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

