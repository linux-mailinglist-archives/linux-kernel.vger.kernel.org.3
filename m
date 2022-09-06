Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF15AF1FE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiIFRKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239504AbiIFRIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:08:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA9883065
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 09:56:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286GOD75004232;
        Tue, 6 Sep 2022 16:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=9nu8AsIT97IMdLKxrlU5M2PHTU4lWf/JQLEJtfxK/YM=;
 b=2Ld8mqOWznPojJi2fVeAEc5C6jX0S6GqOI3c9XblUsh6r44yEDHPwaILPc2ZkJzjqiKy
 IHNURpxM0tRTYXy2TueqkkDDkEHmeroOf091Wi3310FZjN+uV+LywqQI9h1nQC9YNhzb
 gKtDV28BnheGacvOZHbW7O6AlqvkIJddJoUgPbZapgLka3uSDzY7M2Po+DyY/0lBVJec
 s8bAmkfshhAFoQ8+2jPlvYLRIFfbuTb/mcyf0ZqWBR5f1yfHQZRazkOFC1MxhyVCWddk
 SHUxi9vqUxf5IX3GRO8m5ZojUtTTfDTwXraGQZajc5NXdBVXxUfC2TlWyAAwRzNl8cf3 Hg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1eg50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:34 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286FASQX030608;
        Tue, 6 Sep 2022 16:55:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2041.outbound.protection.outlook.com [104.47.57.41])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc35tys-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 16:55:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKRNxSeXJmgaoFVBbqnoB2sh1kWEBEI55h0llkArBhwIxZgXoCrqwBDRlXgy1iKU57pjmHf5OW9dVdbecdRYnKZvJzMd81Nm66dId7rdcC4J3z5TZR6kDxVB65wY3gcLWU6yaUIWkBqek1VaFwLIXqzzF6ClVvv4uN8U1sOsfQPrAeKFiyQ1QF1CKRh1B/pjiISLYMmqWIQFuN2yLTv/XeQecxZ6ZfyC5dXmLjE66vf0HdocT+FtlJRc/viqo8zEt6J0Ep9a3k/kolt1/oRvAPQXN09ovxWHbxRLQ3mfuAn7QMhgkwubv1FYUPB7bofmOCNwazeYbYdoxaJwvBK8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9nu8AsIT97IMdLKxrlU5M2PHTU4lWf/JQLEJtfxK/YM=;
 b=FsVs9E7u2zEtsQOFM/7jg7gsLDhZFK31yIyby14S/CVKS9lrFpRK2TmhC7oWGbBydrPOVETdt3jwvhEinx07IAn6aYkfQS9aiFQnuM7F/3EwimEIMBiIZO+yHiz9FppLpddPA82wcy1PXMM+PP0hQDhgwWwtosUgCfhybiithvaTCLnlvpOQScs5moExJ8pkxHaiNb/bQLdOUaXGM6kz4KCaScEcWj2YvyNiTdbsTaBxvHiftbzMmhK+/N0g31V9q0cG55J22VZDToFeYS8efRnfdlhze+NSh+qZ+ug7atULZ4WmnFqEXcKKM3Bc5KiAr5z1Rp5b9oEH1O1jYG7+3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9nu8AsIT97IMdLKxrlU5M2PHTU4lWf/JQLEJtfxK/YM=;
 b=VNrRffFa9l8FQ2/cGjdNuTrvu6KyRUthsOEI/4liXyhIioRGfVqylLX5/l9mw9DgBDaquxEpU2lLB22hx7dmN3090Z6W1+NR98ldfmY5lReO5nYemM062CGsL1umMvqPginXEXo8IF8xyRqggJHnAEqdw+Qtn9JEQNH+AQGShuA=
Received: from CH0PR10MB5113.namprd10.prod.outlook.com (2603:10b6:610:c9::8)
 by BN0PR10MB5078.namprd10.prod.outlook.com (2603:10b6:408:129::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Tue, 6 Sep
 2022 16:55:32 +0000
Received: from CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37]) by CH0PR10MB5113.namprd10.prod.outlook.com
 ([fe80::ec55:981e:3693:b37%4]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 16:55:32 +0000
From:   Sidhartha Kumar <sidhartha.kumar@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        mike.kravetz@oracle.com, willy@infradead.org, vbabka@suse.cz,
        william.kucharski@oracle.com, dhowells@redhat.com,
        peterx@redhat.com, arnd@arndb.de, ccross@google.com,
        hughd@google.com, ebiederm@xmission.com,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>
Subject: [PATCH v2 3/6] mm/hugetlb: add hugetlb_folio_subpool() helper
Date:   Tue,  6 Sep 2022 09:54:42 -0700
Message-Id: <20220906165445.146913-4-sidhartha.kumar@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
References: <20220906165445.146913-1-sidhartha.kumar@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0026.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::39) To CH0PR10MB5113.namprd10.prod.outlook.com
 (2603:10b6:610:c9::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afff2486-f415-4526-91bb-08da90289c8e
X-MS-TrafficTypeDiagnostic: BN0PR10MB5078:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6QWX7jsWJYIfBgX9tQO7Gvh51y0OIxG5NR6DnSWR9kZN/HEnQmaNcMz+cTYwFTXO3Jgunj1miRbFxWFkcBwbtxJkJmjAfRqzUlfdktyYBP16YcMxDYdKv/ENFx04EXCAdzy7ue0bDQn5cGoAwJ8qK8x2vXSxBlrPQ61/vzdDTHWWPwCVEGcn/nP/n+c4T8PWWgQgRXsZnjsQ7kyH4nCjvjvu9DFqBSzSpSLoJa1gModUuaJNTbpODtChw8xeEHVbAsqWsQ/hESMkWWUDCPWPvBHFlYcj9EB+OCVL/5oe0/LKO3wscxdyjIYVTBtlg16tUm3blkVZR54tup1ZBualXnokimRrPaVY6gMmDhExa7ULw4OFDzB/PsRoNoehGJw/JiYu4DDsr/3/p1fhx23omO8wh5XkXLTty8R/UGpfBxvY4e74enj7nDHY+kRHn+3jBOksvTwaGt5ciUyFbxg95cQNatsm+l2Aul3zDsgS2Fy/lJSLW5DDTquvM9P/gx0Cx89S0D72D6zcvL3mP0zRqRVbcvm4ig5Vt+fkAXSpUF+mKMhCwUrLnXoHFWB9ZWdUM/d4KmRxlKCtFqVKnMo99PI+NZWTN2yQFjoymFD2fBU6aV+mu9hKxDQkZIEE2SG9jzIvorik88yIHTyngBBaZNdOa69Vox1N983K7CFrVF/7mwBYjxXl4lSaQrmzrAxgUfEM8jwXxCffNyYMlkVDpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(186003)(1076003)(7416002)(8936002)(83380400001)(2616005)(44832011)(5660300002)(2906002)(26005)(41300700001)(6666004)(107886003)(6512007)(36756003)(6506007)(86362001)(6486002)(478600001)(38100700002)(4326008)(8676002)(66476007)(66556008)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Dq114ZGxIHiaMGqGupedVNrvV4MDwY0zX1q1VipGBwFFWV2r6jnROJnOZuhm?=
 =?us-ascii?Q?1hec1+kBkDM8v1v1dQ/kkZdSg5b4fbWL+I5C2bmv4CzVqbr/9CUo69/kxqni?=
 =?us-ascii?Q?oTrBMuwovLi623FdXoknZyGkryk9H3u323i3WBeBwwzRl7xwp1AOHeMoVoTJ?=
 =?us-ascii?Q?aW/XuOFk1BXw0USHo6uv80uR1K9ek91O+Y+Glo+4+T5Ek2ZTIEnz7wAMUbiZ?=
 =?us-ascii?Q?sL5axzyNV7XVzYv4fPpePdGYLRaDpQAoLiSvWwTRcdjJn2PdYhEaVhIG1mio?=
 =?us-ascii?Q?fiaffj7kargS36qQeG0IpcC5JUvDj3wvhutUf0B+rBiAuulaaxcKsluvFzuj?=
 =?us-ascii?Q?yjVaDN3oPPZOTXW4A6QZ42wbfSnOL74NMORY4qZTRRGM93VhyUszVuOIIUVC?=
 =?us-ascii?Q?qWI42uCmQfL+S4kCKOnHWK8lshv52eybiN2J86uI40vdnm4QDtysa1bxhn54?=
 =?us-ascii?Q?moU980t5vKRhtyCEG/X1HCRlfuqi/LrDlSjIJHXJYWmCiQ0crrKtsh+Mg9Pc?=
 =?us-ascii?Q?AK+us1z8j9z/xsD6NnhuH7N7oXEfNVyJGTFUJ9pGqdBzRs2XwyhkW3VMALaN?=
 =?us-ascii?Q?78s9mz+WBle+S7io8k7sOZXqFVbE4xs+391ffqiwdATPFoZHFJuVZ1U9VdzK?=
 =?us-ascii?Q?eHiz1g/GdrKLffs1HuR8RI905Mx1k7yH6buvUGkGPtRPPC7dy1F5GkqVeO8V?=
 =?us-ascii?Q?+TRRMpy4mTrvT6rGCuD8swIxZoGZqUWJDLqmfLChlW8aSTqbZDAjxlC7F+ie?=
 =?us-ascii?Q?mJRtvru3MMlyjMaMCQr0cYOVk3xMLIryfxVVEnCpOHunG5ApRdLX+5jiokCU?=
 =?us-ascii?Q?AkvycgNQ/iy8FnybPyNRx74zcTOX9C+vteAMQTgjRGkzMeVzWLMA7qYTgLZZ?=
 =?us-ascii?Q?GQzi7RF1mQYDQ0IdSl042wvfODqUoHBcszCcLmxvCsvbgsO5GLDSOOsi9yb0?=
 =?us-ascii?Q?RCKRSv6q6vhQHE1h25CshmXGgjkkE8gEy5VpZnu3yCUM9IuzVf8LcB/g0q1D?=
 =?us-ascii?Q?8bDrkMjyRyS/4yGDUz8jsV7KRzhli5piMb96W8BBWk5VCFQW1drMtsknd71Z?=
 =?us-ascii?Q?yGojsz87phc6ZJSsXh5BCww250yq2xYd73anDPIqorOhMIrL7wMsc2cZgnRZ?=
 =?us-ascii?Q?HSLtvWNAjL37I4bmm87ampPBcFLDYmExygxMHL0cfJ6JMz32tpn9gRk9dpuL?=
 =?us-ascii?Q?21vYBVdsUzLxRPeWvgi/7LTfD8VP4D5EUKPEI9RVKjWU5SvBmOONIvzKp0C0?=
 =?us-ascii?Q?nAUqvZzaihAUx+zxlSjUJ37z+krtjUGl++WX143YeZrKnK8hos/x8OZkRFqf?=
 =?us-ascii?Q?iMuFvIzTr3Yv29dXLnKtzwQMswUyKpCulc2UPodsf+WRZQX+qn8RNjwtgn76?=
 =?us-ascii?Q?MF2HVnDAeoXiEb5aKVpiW/0jUArTgcDZLzhkYmqrtMyIEA/63SjNdfiZDf3b?=
 =?us-ascii?Q?Urenv+1PYuZuxtIja6CoHpQg7F+2nJyOPdgad5g2CDru3jZIyCnCZERtUJu1?=
 =?us-ascii?Q?h8xXYydLSj5YHX92qILJNGq5Chp8mIgCCERRoolC82wfX76Ujw3pj8DdYMr4?=
 =?us-ascii?Q?D1stUVwYekS8HdCelH+stNC4R3ojOdw0SmLgyomfNgkLkpCTTQAnVHRNcM0Y?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afff2486-f415-4526-91bb-08da90289c8e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 16:55:32.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7kbCLjN1oVRXOkrUthOf2dZHotaOdP9uogSiQn4qoGV4wNbAAgR7xbFIoONcbDP9wgeUe+HzT6I28+4BsE+go/K2VLvRTHDSoDoxPPagco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5078
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=898 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060078
X-Proofpoint-GUID: mJXF3HqCrKIi_fde0bWo8NABj2-6rjoi
X-Proofpoint-ORIG-GUID: mJXF3HqCrKIi_fde0bWo8NABj2-6rjoi
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
index 005cb8c76b84..3602e4cda31f 100644
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

