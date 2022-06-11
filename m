Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D47925472DE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiFKI0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiFKI0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:26:08 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0471B10BD;
        Sat, 11 Jun 2022 01:26:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25B3w5l2029706;
        Sat, 11 Jun 2022 08:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BtS8nygjSQylZS9hvjnpn8QUoZvoRh4UVM+vmoCkVjM=;
 b=xmrmrHzEP2PSstbGTJQ7K7rkTVX0oPucnLd59iTSZICEGlF7uRwynb4qRikEKlFdGZcQ
 HU6xQyD6X7fkdT1Yi62VBYzHvitcu6qGgQeTlmpY4/OdsxPgnJtwtIel+uwnkOkhkZ7Q
 bub2Ir/GwUOSoCplJgj6WSxdAegVUH9xUtjaZtu9Ni6iR3YxBDw6Q92KQ8v6/kMuhCMi
 swkUUKW7WACYffOmplM8zQRE/BaYOlqD5DMYk3xz5bAVl50Klc8zwc+R8p8so3kL3LYb
 K0spS28/dH7fsaic2pmiQHqW3oXgdgXyG3QEgOfJIcwD6QG4G73maOEHRE5/uzYHmRmY nw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkkt86dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25B8BWGZ022098;
        Sat, 11 Jun 2022 08:25:36 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gmhg6sukc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 11 Jun 2022 08:25:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IVnAdSurfSS9uCF9Dyzp8QKIIc/nZsUiDY+yAGFCz9AovhuQ0yRD+POVvE6HUlnzlT2gUyLmygtdLON1gRdQsaiuQ6nM7aYp4tIbDmuSoFAHM2cj/xMGJlNrnbg3EblAcXKxXqN4LufdtT4Enl/f9aRZ0iKQ3D3QGYTziMazHUEhSRnyr37wtAH2lKHrhTch1iHjlzt1i+AUJcp750I8JnyM9qrtNQI0ou9POrrSZ8gAnbbyMW+QWD4HhOH4IiT05BheFm2WsA4jASmtyU0Gysc2R5PdsNCvi+Q8WySSUbOd2WfPvvNkbQnCg225ayYZwpWSAKnE7pVmBIDNz9qR/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtS8nygjSQylZS9hvjnpn8QUoZvoRh4UVM+vmoCkVjM=;
 b=bCgpWl+9/ZGLc8uh+ujP8pq5v9QVThxE4mW0Z5+9fBOk7lws1yNG67jSGcNUTHecSsuOoNSsKjJ2x7qUpAG/dVXj49PXRFiSLBqYshkTsVEPIDUYYI31tlzv3AXfCoYoK4zOPQ+IaM1jH9jGSCYKch1VdJtNZFOuOI1j2jwaKUQUMtfXJfDY2lQ54hyP/xF3R3Be7W/eMH07Yc5dJZ7VlfAa+4a/zXfPgF006/U8mQ/DFg09QjAu6juyXETWd/DPeZgvAy5mphR+I/3jxTZxDLRZDrrMFVFEDqGOf1rvJIsJZaHkXLddI7jUzix6o+U5tpD4C5fpQVK+2CLj3nLW2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtS8nygjSQylZS9hvjnpn8QUoZvoRh4UVM+vmoCkVjM=;
 b=bAcm+ATGy7RlJQUDvZNamzMFY5On2sxeRrc06Io2wYGQp7D/eYBhOtBKemTInzeLMbgw/8RoCkCvdSi75M8laU5twCK93GWPDomiu8GDW6z7siR2IHhs0OTxdD++SHHWdf4SOam+H9NoqKtisJ/PKsIyYjwAWjmHsWEahVuSA6I=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BL0PR10MB2945.namprd10.prod.outlook.com (2603:10b6:208:33::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sat, 11 Jun
 2022 08:25:35 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::60b7:5604:cc5d:54bd%5]) with mapi id 15.20.5332.015; Sat, 11 Jun 2022
 08:25:35 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     iommu@lists.linux-foundation.org, linux-doc@vger.kernel.org,
        x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, joe.jin@oracle.com,
        hch@infradead.org, m.szyprowski@samsung.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        corbet@lwn.net
Subject: [PATCH v1 1/4] swiotlb: remove unused swiotlb_force
Date:   Sat, 11 Jun 2022 01:25:11 -0700
Message-Id: <20220611082514.37112-2-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611082514.37112-1-dongli.zhang@oracle.com>
References: <20220611082514.37112-1-dongli.zhang@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0092.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::7) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06ff5a60-27ee-4ee4-5598-08da4b83f50a
X-MS-TrafficTypeDiagnostic: BL0PR10MB2945:EE_
X-Microsoft-Antispam-PRVS: <BL0PR10MB29458836AF04146C9C075433F0A99@BL0PR10MB2945.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tjKcG3QMotVLErF1O1Ghf3wCRc8HsPLr7gIe/YvoJEJSCNwWhA/SADJ6T16GRHSaL5kvPulOTzHzBDKaaQOD0MSlCi67Z3Y+C5lJKqueMRw6M1XfVvQe6GW8H5QaWyvD9jOjmFlWEJL1JGkrmhbvCMp69WLYVeuaPJ6wWF4vQgXOOv7Szmc5XIVZdp451RdLd4YTE/w1kpsNYLDQiXBUAcu2dz+nzBtJJYib4NiOr9ec5AERpqIZOzgmpfEdARco5ZqaYA7DpRkSZj38iLh9iL/G/7IoB6VCetaydSa7drMlzcmwfdpQAmA/SREdXBGL+EyiNyl1Ju/+LuOCrPcTV6joQPCJ9aBNHcYY6Vzrga9njD/aaKI1HHKlUBYbpz7aS2RIjb88a6+L0VWufgt022TII2TgX8KWRpdpI5yGr6NjAjVnfD+aR6TqG1SiWqDI6IqjvfRlKaVKCCI5tRRG5VrQxHyprIa3PITZJhYTroYd06dTtFXLLslthr99cZvnEdm2PflLRyqcHe0YSrnTT2FKlLgfLeWnVBpMkO/bUYJHmVX6QXI3uqiUiFns+cW7Vg/tgEV+zDwApiZhe3YC+omXq/67TpJm633bLiR/PVHHcL9qWwDLjxrDoq3S5PoBOyr8oCYotGyqId5P+jaXLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66476007)(26005)(66556008)(8676002)(4326008)(1076003)(66946007)(186003)(36756003)(316002)(2616005)(6506007)(6666004)(44832011)(7416002)(38100700002)(2906002)(6512007)(86362001)(4744005)(83380400001)(508600001)(6486002)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lUsnsgJB5FOMHPoTwXb+Nx65LloexpHi7d/rYsCpzSIj0ceTKA+uyM+nhq7r?=
 =?us-ascii?Q?SBNjaRf0J7c+79u/tzLZRUZOO+Fb1Pcv4vwB9nQ98y+7xfcaRztQqq+Q9W9l?=
 =?us-ascii?Q?el2/nILVHhJwJwxL7B9N898I40JWSAFf1VT91PXo1MrhE7Md0Dv9PwqizvtT?=
 =?us-ascii?Q?xKC1CNpIrUxLjOi8/yrAbDswxE/fO/TXTqF59mvYGzW9nkRbMOXuqQ+ZAMBT?=
 =?us-ascii?Q?NN6YXSt5hKuGQ5kbh7+OF/yY9nYQ+/+jm5DQXTGjWeeqBzQKoeufZQcSbA3d?=
 =?us-ascii?Q?hUDFyG1/0X2dq6yCs+NLW1y7KIJxLebsC5LldyvkPR2eK8pNAwqOlENXVi62?=
 =?us-ascii?Q?eC/38s/uw2QvwdfFsolLOzE/LdS1SkxF6oCZUkHNnbmCWy59Io1scSJDY5b0?=
 =?us-ascii?Q?EEOYd+SN0aq7FeZ9odidBwIytfSFOauWZAwQlQNCFdEyb++zoniSLHM1egHG?=
 =?us-ascii?Q?LyMODHxtjMASjfUHVJTiBnYLC3hncLSh0psF2AqP7OSxr/Bzkoxnf93Kt9I4?=
 =?us-ascii?Q?UHTEhGDCgxJr9fHciM0UnTLHP+CMyEDuuzHp4PTDrMCpp3MstV2RuaCh9PO8?=
 =?us-ascii?Q?56BDkp18HzFbyvbeGjufK13W/F5QgyTuU9JprUPUC8k8O7n74cBVP4hq83u+?=
 =?us-ascii?Q?rxCCsZUg0IyiJtQoGabFHEhKSd5KtNXENCm4q10ZLdH0OTDbx7TWzpi/6wL1?=
 =?us-ascii?Q?gqNouYciGZOqot4YPXweHrzfXKsa/LKuieYL+nkbE1Z7kdSvPFpRg7NT2mG/?=
 =?us-ascii?Q?5gBuD/mydKEnY7XuQyYndQdqpfhj1Mg4zwTdGeZZIHn5XOaO90/NHAqpPP/X?=
 =?us-ascii?Q?L8XgVh+Iy+FYqRFKbRDzCJ4JCh4oEO8CFllIyUAKG9YwVUTKaByFvIKbTUH3?=
 =?us-ascii?Q?5G21tee6hO1moSn0lS/sZyISg9sPa0MYqpMa4Xuw6sw8GTPxwtbHK2xZ56wC?=
 =?us-ascii?Q?HK6w8IySCH8dDKx3BXFlD9mon0D51jusUhRowlbbHZpLBDeJo5zwZy93GOt2?=
 =?us-ascii?Q?Sy+3SbkH7XeM643bOEONd3jEQGxhB+h5WS8uBECrIv4xO1GwkreISOf9Nr+R?=
 =?us-ascii?Q?RN46AcrXDwn2E3SSH6ADu8ymrFeJo1svcCiq2OFwXrfIFQ/EfFnmBfyQaYqk?=
 =?us-ascii?Q?KC0uSPqe8g/FM0J3RtiFUQ5BVmHGhDY/PDjgR21zepVfojHmJlHMOHcItvI3?=
 =?us-ascii?Q?biRKQTYhMqN7b1bMDOrutdLWWTSfsZqjKffZXjBGXd4MfyLHRA/TeTNR1RGp?=
 =?us-ascii?Q?MahWFDodMGmOaDpP9Q3PwppiPLmyc5lLZpid3yo8tDNliQRK8ncZoytGiO1G?=
 =?us-ascii?Q?8ELXbGclDZ05aLdM6FYM/0QvYaV4RnKzP9thcKYOLLyRulEnNHjaXM4xDDoR?=
 =?us-ascii?Q?9m+vcGrVe4c/Oa0eGSwo3gSW7VyU/I61miFmskMTP+JhQK3I0CsTj+pdWnD8?=
 =?us-ascii?Q?VD6EEy+ccP/1rbTKItXGp5Jm2pt7h8kMJDcbsD1R0at72FpQidpx1tssiSe+?=
 =?us-ascii?Q?osmfhWi6LnUJct+1MxPt/Jz7laZrP6h2FNSW7up78KxxTofjzzS0PhdsypJF?=
 =?us-ascii?Q?PgrwSBZb6FvU34VwvidEqpDmVF1juyfFSAJ3KegVM0F5n9S7mVvdBni13zHP?=
 =?us-ascii?Q?1C0IMX0frULmmRn+wpQ18yKTQz9E8MEDawCm/9XIWv8BgbZMYB8pwRzh2LTT?=
 =?us-ascii?Q?dgL10FdFaRAQ2shTOQOyKwfRpcpz7evejFS78/65/aL4hFmy+OS4UCNAivLq?=
 =?us-ascii?Q?GJ+61oItegqXCHS40Z+jUl3RAjcKn0g=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ff5a60-27ee-4ee4-5598-08da4b83f50a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2022 08:25:35.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qVSfGI+SKISJUo+8LgZXUmJiaQzf7625pXlOxeuG/lSz3W+AvssFo7Nqq5Anf0oCqtLhAK2ChUWuq4Od9LVRgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2945
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-11_03:2022-06-09,2022-06-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206110032
X-Proofpoint-GUID: 4IE3bbVIfK4U-VFTkYZDSp9lgkDNOygB
X-Proofpoint-ORIG-GUID: 4IE3bbVIfK4U-VFTkYZDSp9lgkDNOygB
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'swiotlb_force' is removed since commit c6af2aa9ffc9 ("swiotlb: make
the swiotlb_init interface more useful").

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 include/linux/swiotlb.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
index 7ed35dd3de6e..bdc58a0e20b1 100644
--- a/include/linux/swiotlb.h
+++ b/include/linux/swiotlb.h
@@ -60,7 +60,6 @@ dma_addr_t swiotlb_map(struct device *dev, phys_addr_t phys,
 		size_t size, enum dma_data_direction dir, unsigned long attrs);
 
 #ifdef CONFIG_SWIOTLB
-extern enum swiotlb_force swiotlb_force;
 
 /**
  * struct io_tlb_mem - IO TLB Memory Pool Descriptor
-- 
2.17.1

