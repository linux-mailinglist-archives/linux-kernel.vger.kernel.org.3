Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CE55A575C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 01:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiH2XBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 19:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiH2XBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:01:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C3672B71
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 16:01:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27TME8xD026015;
        Mon, 29 Aug 2022 23:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=+JwZkA52pLhrm9A6weldFkMTDd2X3I7cJATagE78k60=;
 b=h2TZLt5k4sv8qmKUQWnbDQKwpOw+lFiye9xuzE2/esvCri24lg6ooq4xrqQqAdZKX1zo
 4vgZ4jXVJXMBD7vzuCkOt/vPg/3LYlfEXLT4sMl8BWCyD1smg7UNvLvXeUwrICknsPv3
 yK5oNo+9Go1vT/pdem1SHD0FVnujzvORCoiLEGMlbSYZ80eMxvifxLvQt1HIML21TdsZ
 R/TcrIjQAPEsJgWxfJmICq4PrCl3KFIF4VRqorkt6z76IkobDZuKDuyrNYXwWGIWLwKL
 HiXDTosrDAu0TKx17MKluG1yyMcXc5X27XN26ka+2DtA4A8IKKERjYnwkwihFq7xzciA +A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j7b59vqcr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27TKUgLX005407;
        Mon, 29 Aug 2022 23:00:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j79q33n1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Aug 2022 23:00:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFGJldp5/bLuuU+4snO0lQR0jPNRSypEkrM8qfTH1GVCo0tluKHXAz2NtFS20xi8Lan0s9Jc0rHGS4R2sAf2VUo+LBwBBX9cx+1tDp0kbwATDEhXVGstmDPAGkpJU1kVt6UjWRfxrGdu/9Hvk6y/E5YuMLYMSppKJ7xkRu43B5hxzL+/GOKY8TAtHJEPJNyOxf8E6D7LubbgY09V99zDWyS9j2GcPcl/MtZOUhjFTKo4DGV3B2bIWLpJh2oEwSCsNLOesnE3sbSSOzDhQNSGuoNyv7p2SEO5HpVxJ8U2YXTJToO3BVx+LZuOgXnlke49w2LZ00YDHex31xSYwEWRtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+JwZkA52pLhrm9A6weldFkMTDd2X3I7cJATagE78k60=;
 b=TDKkxfhoErr6qGINhH4Y+qhrIjE0/fTbHVKD/wqwxCEAPY69F0zlaSBG7+zwhv7Ai+XHi1hPTgkiRS9+BGPim0/yP6dFlAXm/12l5wSHv0GlJfyBT5ePS3G/sjnVRhXKnMx/qkBJUyhdsbp/u5s08nIdvP1ifGotsJRnEf2RZX7gcvjlTi0aOqgjcLLJz5XziwEspsgx6LF9/D6URKplXEZ6V8P0UbbwT9+hXelBmULSQdL9QgP3BzJBo13SAsayFpgEXAkNFbvfFUUxLkP+krLcTMU1ysqYDS0Jv4zbspadF2kpt7yeYWi2yaY08Q1ikEnIuWPO6IhvFiOgKaIrCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JwZkA52pLhrm9A6weldFkMTDd2X3I7cJATagE78k60=;
 b=lP7uwMBmsdHvwhi8ollhg4xMnCvaQvw61+9GuABVu+AWmTXjmkZJu2iB63Frl2LxVwAtLEv4cSRUXZQtdT/TW8M1lmBYTN3aVKLHkDcJ/8Iqj8Xrn+83mvKpThsrhF7/+mPtEhUJ9hYcTlPYAyMremUw9Z+OHgdgqtz4m+6KZJw=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BYAPR10MB3736.namprd10.prod.outlook.com (2603:10b6:a03:121::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 23:00:40 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::e026:dd88:fe66:6ed3%4]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:00:40 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH 0/7] begin converting hugetlb code to folios
Date:   Mon, 29 Aug 2022 16:00:07 -0700
Message-Id: <20220829230014.384722-1-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0141.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::26) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d78af17c-9dc7-47c1-dc1c-08da8a124b35
X-MS-TrafficTypeDiagnostic: BYAPR10MB3736:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o6/vXK1KK/Qmb6Oa1LyBqu0zk2ku0TyJCNtggB9naeDm90UIw3ChCj0xkYrVDGOaqMgg2cQ9r320H/1sbSZ59Ew0yyXjikkDUcp0/Z5JfNY0WFLowfGnnjobEXpGpfV1oLwNCW1+AvDeslLuEMOy6Ym06NVVOu2d/PRenwYTXv7VS8RhIbNEqOBhHjUYhv1+0C4fG885rcVXARQFMjxdzx4HhYU658mK6tDHMHW9IqH001ZCwXsv+jbdPpLWpWZYo6rGH0HZghS7t0cwxin10PlJoYoYvkI7WpIY12fZ+GzxTRyWom5iONKlPltInsowqOIOTwj2L77QrijQPZz9k6eH4ScyIoMUfkyVCsEtbKmx7+o9Ogohx95wHThiLbLa9SREVoel44E3jhn6Hd650h/KHGOGQHQv6Z62oYpmA/G9/7mv7pHxyCvwxXm6KpNrh891FLBkMVee4FzgzlWZuKHGIZkcH5v8gua3APrxBarP/k66DOrXxNWri2l4zxklP/R4hGP7ZlA0z1zGADO8JhijgZZi/VmHajyTEixCcv+++Jq/2a/9K87Zlon7TP3/2egsqginoz/td4k6SAFXcIm/n3XP+qWICCR1uoPxGhQhQ1U9Xnol3A8Zr2S9M5Cka69q2Ug97ATWbReC6yfRXc77yPBsIK0bvvzw7Oqq6h3kMawl2JaYOcSB9w/C4jtLrh07d7bDLpVrVReL9/C1TnI45zhwYCr5uIP695Vap6BUE1mqOKt+ZuXECod2zj6HuGlA8bE4iWPh/m2JlZuCPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(136003)(376002)(39860400002)(83380400001)(5660300002)(86362001)(1076003)(2616005)(186003)(38100700002)(44832011)(36756003)(7416002)(66946007)(4326008)(8676002)(66556008)(66476007)(2906002)(6486002)(966005)(41300700001)(107886003)(8936002)(478600001)(6512007)(6666004)(6506007)(26005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3FV3XMWyB07yIVe2bf8z5yIGTl+z3aBJVNBTjhIUp+H3aNOs367Mgkl740HN?=
 =?us-ascii?Q?CD72cxKImGSJYDGgMJRpv2Z2uM4I96zzkJJrODtqip3zVeAQ/JtA3sUQfx/Z?=
 =?us-ascii?Q?ows1pi9J2fCpESTTw8OA17ZII4YHOlvdoEuF3EqM1fHPXKCU2up3ydH/676J?=
 =?us-ascii?Q?xRecSuM0EiANGBHwkxBGN1gpNnzd+yxX46NxTUDglmDHIN04bP6QIjTCYOz/?=
 =?us-ascii?Q?i52wgv9OCUz4J9iTx4SS/89rHZ0xSMXVfDMF0xCyltIB9xnXIwUGRpD1Nrlh?=
 =?us-ascii?Q?pe8TCggDN/FWXqSCQpNaxfxDx9myaQoUPwv7wUJ7cmgv47JO51hpI8gFVPaM?=
 =?us-ascii?Q?nnllt8GXoskmRjD8oLwDy4/j6CQz/oyQ+nM11EgmWec++WzkykzYKH4A5Whw?=
 =?us-ascii?Q?digV+ikVvOljJuUL9+V7mmLU02Z7PBQrjat2KQirlvaTjNK2zZIWNWfYWzNT?=
 =?us-ascii?Q?WQuew8vikd9Zq5dMtbwfNl6nIPkASi4bRXXehkc1TdJAYDXoQtRiqsIDE7ua?=
 =?us-ascii?Q?gNJ7PLPzkPlD6/B9TpQoN0WB9kVBVM+yA/9f2r1wzdu7vE+nzK1LkVqp65Oo?=
 =?us-ascii?Q?hF9sJiyzS38MhIZO7SUQB0Zr0sMMZN4mkJu1v6UzUaLqEIce9yWwTCTmG8fd?=
 =?us-ascii?Q?n3sHd8sf1ECSP9irnApijhV44wsG3CN13u21UB/3xqxTUukzaAEYtZAkBxzc?=
 =?us-ascii?Q?IYFWobOL9kPJK+8rOCH0au9WMowK4QNmnLK3Wb71cgPpLTd9gGpdZGRWRr0f?=
 =?us-ascii?Q?C5ExbvlfvuniZqfxBso1JV3UdMK+igutbAOIzze2TJtLNRrSCOVPf80iHQVE?=
 =?us-ascii?Q?04jCR1b8kubHH20Pwano4SoeppnRJPSjXD1S082jd49hIr3PQRNuHbz2cmA+?=
 =?us-ascii?Q?mYcMFxhYYKMZEu6mSAkVXogaZL4ohEFVi9uLE/6Q+0ILD1UFh21FjpNMjodW?=
 =?us-ascii?Q?5uJliXlHWVjGqwgW0vclz1EvaP9DIfa3UfryJ6LhVc5mFqLJrvW0XKWsSpr/?=
 =?us-ascii?Q?GYoFDRR39kguMng/4T9yo9l5EoRSzoabIGla69bgvmnyxlS+/ajWPdpstQ34?=
 =?us-ascii?Q?NJpsg7mLF0BMigjGGcQ6OE0dbrSG6Wm+vPN6bgBeCuITBnQgnV58Czte7jKl?=
 =?us-ascii?Q?2xv/ZhSt1puybxQH7LW/NZWxIb0JjmHg2rsHNIh5CIDpQkKk0qk15mLeYvIf?=
 =?us-ascii?Q?GyPdqamh8xftmq1xSIgu6xC6+m+an3ODfMDj3htIDUP7NcMa4VM6AXD7jevi?=
 =?us-ascii?Q?JPXlMu0FmXOmib5NeVh439kGNGmuvLx4Zjh33sZJyZkLlln600O6qyrbsYe/?=
 =?us-ascii?Q?/ZzuP7u8EtaX9lnsZ5RF4iK5abwsd58QkX+ole42xeT0Es2pFFliMZ0ZVDrD?=
 =?us-ascii?Q?htz1ppb05RafvT0PGvqlvPvMN7NdpxaUhK2bUEsA5g6rZpXUwCytqEiikmNo?=
 =?us-ascii?Q?zP42qRY6TpylN+8vbc85wwbQUdOBwzriucdoY7WEqlvEerIfd70xW1hNyLx8?=
 =?us-ascii?Q?62jTr49RJ7QdOrpjcPn458KCDUDn+kpVv4lsBHAOseQiDzCB/MUD0idHvJs9?=
 =?us-ascii?Q?FVMoYSRdPp19CPfhaOxI+9BELM3mPIhe4uHok9vU27eOBjN1Nq0kUvdM+JVW?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d78af17c-9dc7-47c1-dc1c-08da8a124b35
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 23:00:40.3474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fxO+6xXp/6INhHVTgQFnY/fgudTFqzC52jgXsi9WDzlr/IguistvBZnWUnFOcuXPXNKmKPLdUEjrY1/BpwafgxqiiN48j6cw5/Ksj/no5IY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_11,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=769 adultscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208290101
X-Proofpoint-ORIG-GUID: eDDM-DHteFb4OwkX72uDstp1yFmAKdgM
X-Proofpoint-GUID: eDDM-DHteFb4OwkX72uDstp1yFmAKdgM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series starts the conversion of the hugetlb code to operate
on struct folios rather than struct pages. This removes the ambiguitiy
of whether functions are operating on head pages, tail pages of compound
pages, or base pages. 

This series passes the linux test project hugetlb test cases.

Patch 1 adds hugeltb specific page macros that can operate on folios.

Patch 2 adds the private field of the first tail page to struct page.
This patch depends on Matthew Wilcox's patch mm: Add the first tail
page to struct folio[1]:

Patchs 3-4 introduce hugetlb subpool helper functions which operate on
struct folios. These patches were tested using the hugepage-mmap.c
selftest along with the migratepages command.

Patch 5 converts hugetlb_delete_from_page_cache() to use folios.
This patch depends on Mike Kravetz's patch: hugetlb: rename 
remove_huge_page to hugetlb_delete_from_page_cache[2]:


Patch 6 adds a folio_hstate() function to get hstate information from a
folio.

Patch 7 adds a user of folio_hstate().

Bpftrace was used to track time spent in the free_huge_pages function
during the ltp test cases as it is a caller of the hugetlb subpool
functions. From the histogram, the performance is similar before and
after the patch series. 

Time spent in 'free_huge_page'

6.0.0-rc2.master.20220823
@nsecs:
[256, 512)         14770 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)            155 |                                                    |
[1K, 2K)             169 |                                                    |
[2K, 4K)              50 |                                                    |
[4K, 8K)              14 |                                                    |
[8K, 16K)              3 |                                                    |
[16K, 32K)             3 |                                                    |


6.0.0-rc2.master.20220823 + patch series
@nsecs: 
[256, 512)         13678 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[512, 1K)            142 |                                                    |
[1K, 2K)             199 |                                                    |
[2K, 4K)              44 |                                                    |
[4K, 8K)              13 |                                                    |
[8K, 16K)              4 |                                                    |
[16K, 32K)             1 |                                                    |

[1] https://lore.kernel.org/linux-mm/20220808193430.3378317-6-willy@infradead.org/
[2] https://lore.kernel.org/all/20220824175757.20590-4-mike.kravetz@oracle.com/T/#me431952361ea576862d7eb617a5dced9807dbabb

Sidhartha Kumar (7):
  mm/hugetlb: add folio support to hugetlb specific flag macros
  mm: add private field of first tail to struct page and struct folio
  mm/hugetlb: add hugetlb_folio_subpool() helper
  mm/hugetlb: add hugetlb_set_folio_subpool() helper
  mm/hugetlb: convert hugetlb_delete_from_page_cache() to use folios
  mm/hugetlb add folio_hstate()
  mm/migrate: use folio_hstate() in alloc_migration_target()

 fs/hugetlbfs/inode.c     | 22 ++++++++++----------
 include/linux/hugetlb.h  | 45 ++++++++++++++++++++++++++++++++++++----
 include/linux/mm_types.h | 15 ++++++++++++++
 mm/migrate.c             |  2 +-
 4 files changed, 68 insertions(+), 16 deletions(-)

-- 
2.31.1

