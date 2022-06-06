Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20B9F53F075
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234440AbiFFUqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiFFUpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:45:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0891B0403
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:39:40 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 256HJ0oK019941;
        Mon, 6 Jun 2022 20:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PkuCAOvPHyodxuo0lxQ/4fnpf2Sh3u+TVEsU5WG4ZLs=;
 b=LhFr3xc+QIi15yT9Oae9jpSpHxcWNa7awPkHbOFwS/eXR10XrE3j65CBCqCofBrBHHbt
 piCd1h4vtKRJp9exHz/FYOV/Uml6HYiMNbOxW5G5FIHNeNNr6UIfRI2P+k8OFaXCjjDO
 VFqumIizmDokNx+2C+UZL3qmWuB/RFrD6sxLmkz8NUws7RiiK1tlMUaVgPJA2Amrngxo
 pakBkPK6/sYCOksrZPqKdZ9mP+ts1FK5yNqZsykWDNwA3dtS7PBEHrHAmC1j93hooJYR
 n7yf+a13unHl8fySdckNM5s3ZPI0j2nfsex/ExhCIoG41xJhl/RQaPnPn3h4rDf26eYh 5A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ggvxmtg0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 256KFsx6016233;
        Mon, 6 Jun 2022 20:39:16 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gfwu80ags-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 06 Jun 2022 20:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnDBrCtK6LKuHOl42KCS7T6PGO7zifUYgzXNNXK5LWziScwsq2T5hqpEmfyhgHATvGN4Aml1uL9wC5ECYgem5uIzQoqW0oRQAw9VfAhmyYDehmpmq88mDAkHKAs/u39uKCe4m4AT56TDSGDkgqgG3MlNM5zhcdl56IR9uXkkWNqyXKUksDE2RPkasjCyi3XNT3/iXk+pll/ja2lMNqqsK14SqiRkoYrkzCccrSE+UXKBZAY/hcW0KD5nsGM115sU5PQq46sJft5vpABHsdbV8Rn8q+9uRJnaOdjYcD5DaJ/qWiGUw+Nk7miKCRdeVBAzlNiEqdECK4AzJa6acpFU7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PkuCAOvPHyodxuo0lxQ/4fnpf2Sh3u+TVEsU5WG4ZLs=;
 b=eF90TXRyDnmFWdtu4ilRqMuwroGER0z3OeQVbtuoqjPjDiC8vEA6R6OpkhmacYorfzl2u14p7MD0MizXEp2f48e1LTuDlXVqMGhTzS39JtGKmRV1MQgfc81EJLCwCiIZvnm2tuPGe5H3qExnXa7jDyPAw5JAvUO4vtX+cZoe8cyiBGQw9AO+Bxp+oYtQFh+QK21ihiJLzdh4xY3a0N/5FRvakO5N8WON/H4C414wqwINYryYtjkaSce5jA7Jp9V/50oZOQ+d9nWlYLy7fmbchBy82uA7o1KrobHmSugws9oJL/iGxnMns2ZV17Ho7EUmxCaaasrrhcsaGoU70Gcabg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkuCAOvPHyodxuo0lxQ/4fnpf2Sh3u+TVEsU5WG4ZLs=;
 b=T6qXXSaCbuPiXtpDyT/YpbXBkKsfpZZ3L0ZbMJVlW6glRAHk7GQVOp8IkDoVY0TsTsO6N1JeK1/vxv8/ULMw3C9fVf7+OMpc5vgiXK/sOU4P9RCnO/yO9mZgcixGxAwEYtna9Vgo7Z8I7HjEr1n3rpiV0h+D0/wZVJTU0l5RQSc=
Received: from DM8PR10MB5416.namprd10.prod.outlook.com (2603:10b6:8:3f::19) by
 SN6PR10MB2734.namprd10.prod.outlook.com (2603:10b6:805:41::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5314.12; Mon, 6 Jun 2022 20:39:14 +0000
Received: from DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08]) by DM8PR10MB5416.namprd10.prod.outlook.com
 ([fe80::49dc:6a95:a2d5:fc08%5]) with mapi id 15.20.5314.018; Mon, 6 Jun 2022
 20:39:14 +0000
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Cc:     torvalds@linux-foundation.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, mingo@kernel.org, luto@kernel.org,
        tglx@linutronix.de, bp@alien8.de, peterz@infradead.org,
        ak@linux.intel.com, arnd@arndb.de, jgg@nvidia.com,
        jon.grimm@amd.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, joao.m.martins@oracle.com,
        ankur.a.arora@oracle.com, alex.williamson@redhat.com
Subject: [PATCH v3 20/21] vfio_iommu_type1: specify FOLL_HINT_BULK to pin_user_pages()
Date:   Mon,  6 Jun 2022 20:37:24 +0000
Message-Id: <20220606203725.1313715-16-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
References: <20220606202109.1306034-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0176.namprd13.prod.outlook.com
 (2603:10b6:806:28::31) To DM8PR10MB5416.namprd10.prod.outlook.com
 (2603:10b6:8:3f::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5685fea1-4242-4edc-19c8-08da47fc9e54
X-MS-TrafficTypeDiagnostic: SN6PR10MB2734:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2734B1C71B105B7CF49C37B5CEA29@SN6PR10MB2734.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5yhIKur8HwoTUn0EmJLNAfSLUBvLlaN5yZkCuQrFQO5s+xKSTGoZqUAuz0wIfdDJ2QHXpzaVW0z92r2SHbauzLIxHVtj7WrDOFEgVgMFZt1UG04vPiq+L9/Hf9wdlInNrt3ImaSxrqBRx7hEWB0qk40jkNi3BlNtTc6vVt82Uwm9f9247JENLOFV+JYcdWFA7FSHGhdixfUhVdjjrR2QVSgfN9NuJsoomHISy4E6FJ5t3xuKX0D0eG00lGcBx67lLCnm8ZR4IB8eCgxhcWXNDgXA1gHsRvIaJ4uMYwVv3V3dNMhsp613a3cxf9IdJi5hkSfmk+A4oXsg0OCuuBVAQlow1T3P7eeGn6qWTyv5aFApvzZrieKe/khjcw6BmynDhzOzqmKliJu7x4wfz9RbRMUSC9EQsrriDOZKeEA/YptnWC/BAZ0dutkBqJcgXejtJhMWUP19NxpNXvYZtgZUZC8kXk3+49bJDdFV8igjcSduZlujUZAuH6aNjwrSZbgmZBa+M0skzR1H5KOxh9MwVde475LikmEPMoJ4eZevGRsQO1tavvmJEkNBSpm1AJr+c070h7Tfm9CC4P0Tvablu2xHy4sg7ty/Vy81Pog1WIy5UDsEXAhyuSqCVXz9Xb5LS0+6+NsQt1vtAogC1uaQUOucFvFV2u0fL8wRtiSexndKXJZgkIYUGbfPK5xjqVP9tzh8DaFOre/Ok+QfParocg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR10MB5416.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(83380400001)(52116002)(4326008)(2906002)(6506007)(1076003)(8676002)(186003)(508600001)(4744005)(38100700002)(38350700002)(86362001)(6486002)(2616005)(103116003)(6666004)(66556008)(36756003)(7416002)(6512007)(26005)(316002)(5660300002)(66946007)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8num74lPgp/AFnZ626oETUsU2MYjBLPZ4LX7fGBD6XUw0AFgPbXJPDJcYrog?=
 =?us-ascii?Q?O28tmTtKg2CRqR9m9z+g3pMqEkAHkTM4lMeLhQ7d/GNFebqPueJhLk21HCsr?=
 =?us-ascii?Q?eQCHP9h3IQW5A4Hj/QxL9lf1F+cvzWJn44c8DYl7roBI9AWgykQdS6pXTG8j?=
 =?us-ascii?Q?XXM5zu7YUgmtQSE9jOFP6Z2OejW8jijutSE3cVbePZdYY2CfX6cthjnbWnfK?=
 =?us-ascii?Q?9QAd8mi0poOcDyCZnGtfR2lQZ/lCAmTJ5j3gwQQ0so1OcQbLDTT5kWqiM7dW?=
 =?us-ascii?Q?+ATxtVDSa2V1GHgcbHqc5SAAFpwhnTHOWILA2RPQv5IUfOP+pZ0Ow0L64Q7y?=
 =?us-ascii?Q?4d+QM7/TrH4S+PcZyLrtsVxT7KChKNDzQhNe6A02eLzvzhonx3OFE5ju82mH?=
 =?us-ascii?Q?P1FOQYF4tgMQYfqb3OWJjjfT/nepYMaqDFZaU3wHqFhRxfR0GzgtnaurCKtj?=
 =?us-ascii?Q?kqeef1LuzUdk9lLgMYqf7/tzY5R1EKTO3uMRiIaEx2o0vTPEVqTRKm4QJFjo?=
 =?us-ascii?Q?6WCVYajeF83P+7+S2HB255dxVLDSHMQWH/ohDtIBUM56L3Qjxg2ZHswaXexQ?=
 =?us-ascii?Q?VmR/4HrOZPov/DaiYfZ1boxfg5jK2j5kphxqyV4F6Zl5safUEpZ7y/5EO3dT?=
 =?us-ascii?Q?FqB2QfrTAB+m64Qi8oJarNV51z197JTPh4z3N+C5tC4/ncRqRTivq7ssxcRx?=
 =?us-ascii?Q?TIzGICe5Tb819PBHvrWpCFGeb3cxvrxv1TC/TuLoUwlWcB6rOspkO7xv0byD?=
 =?us-ascii?Q?YnHXo+/iIrICxkHJ2SdwvDEOi2ALOqNHmZ/9hNL/x4gGLIN4BTD9ydMHUrbs?=
 =?us-ascii?Q?D8IzlLqSpg7FpdtcjUmRcH2A1qCOM3HwGv25l2TiT+vEX3dgxlsuqlg6emv1?=
 =?us-ascii?Q?SIc73wXR044ru8vs+EGKnG4IcrvdpRFGwdwCYEr17nT+ESqffz1k82BJ7W8Q?=
 =?us-ascii?Q?OBIdcZdVJYXNhpfQ0WSux6tN0apZfXVigw98KHXC8QCQ2NG5X1RYgLnYk87O?=
 =?us-ascii?Q?YONroo3mdCwGI7QTKz9WiTNUFyTPdoSTE4mw4io7HQxPl7BybsQCl6PMLaoE?=
 =?us-ascii?Q?IKeyt9MX74DB7C343VSSgN/nZWRKDpL1ogdSj+QJTNbPEowc0eH808gacpWa?=
 =?us-ascii?Q?LgZjorHXK1aUJQQVwKONWZylcAlho8+f+0gd4WrLbYPxZMS0VHHZMwhUlJTP?=
 =?us-ascii?Q?AFsPrFX7jV7oYaMEfjDyCp6YRjoe68+eEi3xyw270DXVRaBTT1i/C5uevY9H?=
 =?us-ascii?Q?I00XkwK4Ptt1LQWQKjW7kfye1EdIs4WZ8IXeyqwvjzykqKwQrQHazKJyQPqa?=
 =?us-ascii?Q?c/CuFs9h47g+bdhmIR+Wb/aBjxHiS4fV+8lC0O/21A99ZQ9IDttL25uw57jr?=
 =?us-ascii?Q?QswCkNdPyBaIvVDpZ0keSYnFnxgBJtEz14wC9f4m+xcknALsGVx1TD9cVx77?=
 =?us-ascii?Q?/ND8BfeDEtpxV2WQQqDYkJwU86f3PDrq2u3mq0fB/z0P4kbMgJI/GfS3bXUR?=
 =?us-ascii?Q?6efbDXqzxb6HqCffrUpNdXiJ+aTztb/QyFqhkK/cac/C6+MJZh0po6I5YCmR?=
 =?us-ascii?Q?GgCaGyi0qfydZUYFuPBZfWS3/PvkadJC1gB2XiY3TZHrtIe70CLCig/HG5C3?=
 =?us-ascii?Q?cAWfXk2+K2+307RYDyY3xh7KPthkazmpXIZ2WsETSSIRTc6fD17FbaKjtLcz?=
 =?us-ascii?Q?2aljrLCF/7OSYiS6gWhDycMy9+6kuPYfo53hWOBzc/pStNGSIrWWQlZiNIA0?=
 =?us-ascii?Q?4F6pGiHJoaE2IMi7TgvE2MCRrudOljU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5685fea1-4242-4edc-19c8-08da47fc9e54
X-MS-Exchange-CrossTenant-AuthSource: DM8PR10MB5416.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 20:39:14.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJIi+75btb6esrWQJjL+WL4rRszu3Ygc+KqmeGwcM+K1W+z5jV+mP6Y6SetwgKGEu7jwaebwv+2HYTrm799+LHrIO2/BDbiP2uiiewlejg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2734
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-06_06:2022-06-02,2022-06-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206060081
X-Proofpoint-GUID: BJIfJo3FwDi-f3Nj_S944Ik_UlToqORL
X-Proofpoint-ORIG-GUID: BJIfJo3FwDi-f3Nj_S944Ik_UlToqORL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Specify FOLL_HINT_BULK to pin_user_pages_remote() so it is aware
that this pin is part of a larger region being pinned, and can
optimize based on that expectation.

Cc: alex.williamson@redhat.com
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/vfio/vfio_iommu_type1.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 9394aa9444c1..138b23769793 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -553,6 +553,9 @@ static int vaddr_get_pfns(struct mm_struct *mm, unsigned long vaddr,
 	if (prot & IOMMU_WRITE)
 		flags |= FOLL_WRITE;
 
+	/* Tell gup that this pin iteration is part of a larger set of pins. */
+	flags |= FOLL_HINT_BULK;
+
 	mmap_read_lock(mm);
 	ret = pin_user_pages_remote(mm, vaddr, npages, flags | FOLL_LONGTERM,
 				    pages, NULL, NULL);
-- 
2.31.1

