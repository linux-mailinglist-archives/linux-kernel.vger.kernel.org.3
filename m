Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28C65B26F3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 21:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbiIHTiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbiIHTiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 15:38:13 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294E2105D7A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 12:38:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 288HJM5Q012359;
        Thu, 8 Sep 2022 19:37:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=x9IXHmhmhTdttML4IMmOPJ/UboAqGKu7hHbCKCzkhzo=;
 b=uo+Tt1uap1CUC0VqLOaAFl+Hi88MQHbI16YapTjdygEsqnugJIKewdHd9zrJZ6MF/Ukm
 l61j+ctcBc5X2T38ZTVkb4ivTfAk8Ee8LHClU9WiD8CrfvsPnBAVYV8+WIvFKBa28Xb1
 5zDs5NfR/THGjn4excs+teVxaLloqqbokKly1r85Ls4YMWJaOQXTesX86dz76QKMsHG1
 rOfpqiak1RAexxSPqbdCHTmwNZEq6vrreVoRJbFWF17Gt7Lx81KzS+MtByRiDKEedHme
 4kIF9itjwg3+Iri1B4LotTxWzH+DTLivIdy/fR2Sol7htsc22572BigaL3k/zuA5Qwbs +A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1mykj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:37:55 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 288HbjCg028189;
        Thu, 8 Sep 2022 19:37:53 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwccq37w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Sep 2022 19:37:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMDtB/ljzcj1xo9aeehhrsYvUvSBWtUaPbWNyq6he8F0wXTG2Q1aP7HMpgzo1aUzmawywt0WSxLcydH2uCtok+PhpqFGpPoKFpG+KLil3JD3zVTcChwVTfJlOCqVLPZSUaJMsgyBQrxEFNQZjzeEpjf5bzKPrZLHrukHNe/e5OMO2k1/XeLGlbP93uBqfq1J5j0KLCRgageu/PQs5W5P/C3+Q3uM7g0F3Z5i2yN/pHFNih0uJYIv+ApISYh0SnLJ0RmiwwQ2S3LxEoTIcIsvCuK5m68PtcUY9WIfvosoMM+GILmkxZ9IIwsn8Oq4tvTiPj2ndAfPRePUf9l5OOky0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9IXHmhmhTdttML4IMmOPJ/UboAqGKu7hHbCKCzkhzo=;
 b=bwKRlqPx9shGvjoj7+lZB+E3UXllQyFVyIB16m+39YDcFk3/KnUnJnjYmBnF0WQHGm5jMAvxnBD0LdKm9NFbcZrY5IMqFccBOLQHP0kHWbasYeSWvEkgfdzomvj0axlJLb7uqy+6y5SNNTu/k6SgURqhje7rjLllagD+TdY9yUEeYfK7ln53yx+QkO5dnkk0Z0V4hMwop2CsK/MO3SgzjPh2efqbmNkr/CanGMHaFpOh0LZLHxRqHjiZXh+gJ8X+qiVm95EYt3kEa9goBXsp3LSMI91cfuMmi9ktzLXEmZWeGS+7y5xfizIyOh4qXWC3bPvy48RPJRO2xCItmeL13g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9IXHmhmhTdttML4IMmOPJ/UboAqGKu7hHbCKCzkhzo=;
 b=NcWhBk26fvjxZBHAzzg98oppkBm8sKrRA/FSnq8T3B/P1UrbMxLtK03RZY3AkrgezwEJhhxW0rwNHU+tG3L8NyjjR162sSHhiYhsWWfijMACzbuTJy9WbaDI3xoUCKWF4hMOrQIVjvNmAkReUGticvpmCG3DfMacxes6t414TD4=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by DM6PR10MB4249.namprd10.prod.outlook.com (2603:10b6:5:221::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Thu, 8 Sep
 2022 19:37:51 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5612.016; Thu, 8 Sep 2022
 19:37:51 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v3 3/6] mm/hugetlb: add hugetlb_folio_subpool() helper
Date:   Thu,  8 Sep 2022 12:37:03 -0700
Message-Id: <20220908193706.1716548-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
References: <20220908193706.1716548-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0070.namprd03.prod.outlook.com
 (2603:10b6:a03:331::15) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5113:EE_|DM6PR10MB4249:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd107a6-3a4d-48d0-7225-08da91d19e0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GqORY2cCZsu6aE+YQvwtjRLJ3ysSHPM4laO1+tdqAinV4mZYVWbv1XavX2iPnDg+tT6zOw1U0tOlj2EhC3KdEsNKnWDMMwILSmRggtzW0CBuSppp+mMQbNr/XjNEyLBd/3WhCxmP0kASefr3L8VewB2uSzrpK5Vi51nQLWhdz650isGu1FDQm6+mjRO7quyM0HHMhi4JS3w2wFS0lbjdGSLOnhuL5ACCQgRvUccc2huyIBW/6RpAPPD+a9pjXB9e43DxeBCS7HycXHyG5IvO8D7j/ISX0trIXlntHslBLKYhkqqdySTpxDJBRMtVNA04o+XFZYa2w/E82GfGnvoAD8o4tKse7769PeSpT7f9f8M9/nyssd0p3lMfOJDs6fM82FIxiR3FmGPzg1ERUShzztD9TFW/2dVEWIyS0iJTG19k326n7O53zpka3/9wwsLrjX8jxklEGCitbTbwbSzlB/Vdu86HAXHVUEQcZzHHLnP6Q6o4YK3YK7ODsWsoPn2xOgcBfdRbFP/sxRJjm31bYo5SFIx86k2kK/csTIr4CSGEfiEQOJzHa6Hqvfn1MkO9pzgNYFdPw9LJNpZaXcv/7VHGG3pOC37YwZMbs6FUqy5GzvKFKFeIpBd/uLd5Yg8kwnazL5Y+7jf36dK2sOZ/8EhZ4ifzJQnPWzGJUowBYNKVqn0H5YoOD4mCpnUnyYZaQF5AIp03IDQV6444uYevbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(6512007)(6666004)(6506007)(26005)(107886003)(41300700001)(6486002)(5660300002)(316002)(66556008)(66476007)(8676002)(66946007)(36756003)(86362001)(8936002)(7416002)(478600001)(2906002)(1076003)(2616005)(83380400001)(4326008)(186003)(44832011)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sbOx/8R2ZxWET0njJG3mR+7hFaAs2uh0d4H0tmA8Vm9WxG36ZggeIz0NQxyX?=
 =?us-ascii?Q?W1DURBFwTwskva7zL9Ly+oMK7jrf9lYecwNqnWBESZk4YZT1hTMC/s9Xj2yW?=
 =?us-ascii?Q?zM0FXBKQpy7AUWnfTpnN+QqnbpoZsRzlel9JX1FtV8x8MwZoowfjFJ3j9/Hk?=
 =?us-ascii?Q?UFfBJyGbWe5TjanqhAys25Vf3L4ypWUs44uvRhosR+CCGrKoItiEPvCOo0c+?=
 =?us-ascii?Q?2OJekWTtjONM5gMLz2YHjjpeN4rqGXNzF4jLhpHe7jde4HxysH4XOmpxvPmJ?=
 =?us-ascii?Q?n9fEFUqo+TCj+4ZqhZvGcD3S8VEzYXN1mNMspK0EpU3pR7NAbC8fbEBSvK7y?=
 =?us-ascii?Q?Y1EfRRgvdOSVG3okjTiVulx6e0zlUhIxwUbPeqejxbmWV/5RGo/zFOvX72GD?=
 =?us-ascii?Q?i2M+dbM+xzvjk4vQDXgmJ6G2PqXx4Q13Zh3ya5IV3UChQCX4mdQsvMAqisFB?=
 =?us-ascii?Q?0v3mmLwgEvQUDYfrcAoEKbk5WUBjqXpDznTspALfO+zsLyAFRPzZ7KfjL92W?=
 =?us-ascii?Q?T6yvpZw+glGBDKrsFUNbu4zY+PutjdaDJsgKkIsEpuLXWrKCzBt+PSYLoXwX?=
 =?us-ascii?Q?Au7oy6uISXPjQGt98/LnTr0xKMlQBOM5UjwJmQW5FsZEwCzXdfT5fP52lugh?=
 =?us-ascii?Q?YcXlxKTsVvqstfRbwgxfvwxAy+/+6GbFDIq6aA5mFC7m1UE5iziZv23JTehe?=
 =?us-ascii?Q?d+zXMqucGPEtOERi9aU45gJyWfoUZcT/v7kYQs9FdbsyiM8wmXZ8qVWibAHn?=
 =?us-ascii?Q?zeklixhEiI2otbeyNOBC8j+WmJBt2w/qpoK1hAaeYsz9oLUL2ocixJ3vTrW9?=
 =?us-ascii?Q?5DNfEBdrD22+FsOm7f4gxF4X3tQ1OGTz5kuS6tspGjkwz0FvbInEOB+w6BNZ?=
 =?us-ascii?Q?nBgu3L/uBQADuo4BTq3cdszpL0NUYFbBsdl6Sf/ZCK7I9t50dl0SrGLxv8gz?=
 =?us-ascii?Q?plf140rGZIRTFnraFPzCfVQjLTswChAawWaoYIRAnvxCEKp4AOliLmVLCN6J?=
 =?us-ascii?Q?gwjHzrZ6WhH7WNUtCOLFO+y6N7oEF8Ohdaa8pfWKl0tHleU9nM2i08byBrWn?=
 =?us-ascii?Q?uruD/e/QChXQNysQWYQOEjirHMWJ9EzPeylXHQtJ1QBhO81QqENBIe12UpDh?=
 =?us-ascii?Q?/O832uNG/secjP9Krn/Edgc8zigGHSX8oPz8rwohMTtfC6rbPhdd9OHuBESm?=
 =?us-ascii?Q?uj+LWFdMS+taIKWyYVWpwQUXGXumKn1sAAEmObKXkQLOduORx6itiM0H636U?=
 =?us-ascii?Q?Hd4TMBWIrQw6Mfob+CJITNQ1C0CgpJKs0pw71SyaByfB1GJbGabXyNhofsIJ?=
 =?us-ascii?Q?vbe/j6JW0QmUeAkYUkSAJfa0EN2ZyS2hy4Tq9HC2QHU3YOnQxDWoFw6TPO2+?=
 =?us-ascii?Q?8GpaUMq+AP5i6HeLU1B6djeLTjd4wxKq4f4raVz/0o/ke+X/VCrFqLLZm4Zz?=
 =?us-ascii?Q?pHWAMM8XVXvcVAtsOYWyejLOHs4w+vClGF3n1bEyTr4ASX2iiC8/dVsqtOCu?=
 =?us-ascii?Q?NiA6Bvt3zlv3GfSSfiv/8HiDxVSD1lIaHAWYXy4M8Okx+odOzXMVZjeZFtK7?=
 =?us-ascii?Q?rXv36X9HJ6bk2lcKtVAnLLnONon4nA28hjn3rlbMhciFHQ6wxyImxQ+MwOoR?=
 =?us-ascii?Q?eA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd107a6-3a4d-48d0-7225-08da91d19e0e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 19:37:51.3535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpc7FYLR1C0f4fhM61JZMlyFas7dE3k68gF6RPsGHAFv4j9HGVpgUnYqcEK+n1UDnZ5kXOBPlP9t4QnpfifPtBFZJD0LqUATV8/nxqPOnf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4249
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-08_12,2022-09-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=973 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209080069
X-Proofpoint-GUID: I2Y8PKsF4sINBxBrtZJFXU0rwcUyP2Mg
X-Proofpoint-ORIG-GUID: I2Y8PKsF4sINBxBrtZJFXU0rwcUyP2Mg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows hugetlbfs_migrate_folio to check subpool information by passing
in a folio.

Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
(cherry picked from commit cd9e187858b45b890097cfcd0b2eb4bbbb9a59ae)
Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
---
 fs/hugetlbfs/inode.c    | 4 ++--
 include/linux/hugetlb.h | 7 ++++++-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 52d9b390389b..c2e9c0cdbd81 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1151,9 +1151,9 @@ static int hugetlbfs_migrate_folio(struct address_space *mapping,
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
index 0952ea50251d..1e7c4007386e 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -744,12 +744,17 @@ extern unsigned int default_hstate_idx;
 
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

