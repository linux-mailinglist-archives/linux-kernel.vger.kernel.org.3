Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D7A4F174C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378120AbiDDOmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378060AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A899D3FD86
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:36 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dl8LV024505;
        Mon, 4 Apr 2022 14:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=5NugQfUaIt1+oDeH7ZAsuXQmmKls647u8KnO6Vbi+Ks=;
 b=fbZaFNJZah9EDbjELHG7plna1Sxv/bKQRPR18XtCI+2/u6+64TWBSIq+Ro4i8OVg89Yj
 kZLWCIQybe69LCFC22Ed2Em+ZHf+BFpzWbLGwHLUFun67Dn9bG9IZ83eGB7lGQXAC6e7
 976dxzo3pP1KogulbfQHV+NM0EUngEcz1CWkCYxT00zkh9DHiFDQ4ywpqEmkx98mqv0Z
 Pm3DO6lfw+8mLyIe9jQ+x8z6fK0dACeYYl0ZJRwIrRmbIZN6HZI4MmY9abIYRLTj62N8
 0lSQsxDRSsoSPGYbE4Scaz824bXa71+EbjJ2I2H047eRgDQzQ9bTdK9sPeyhIq+gJbKx DA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cvk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGceZ027671;
        Mon, 4 Apr 2022 14:36:28 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeE29PBJrvUCasR56zQXZ+aqRV+sgHgj4tVSRjh4Z2uGZMOS7gOe0Q0JAbLYC3uQ+TOENX/vQ7JSc0kY1t48WZK4V0zDaIW9nyLpSyaM8Mhriquhw+mPe7nk2Ql8pu31A7xXClnC//ZPLXDbulOJhgBb9YWDtACpALjiPcGcGqlEuwHfKlf3X2aexeLPmqXhCRlqYcBVIoJxPfgVzEC+NRz+Q1gM6LSBWGkoZcW0fF0DB/xgDPEpB8mja0u3oz9rb7dZqZ2txC+B35H1iy3kDJ5q+hEckIa1e/I0hffVYCkCrO0rJ8YkoqQKWxWqiSrm858mlNnBp+7C4tAhwLnUGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5NugQfUaIt1+oDeH7ZAsuXQmmKls647u8KnO6Vbi+Ks=;
 b=WT2kU120qtcP4PwurUvIvekd8bFOL4SdvkpJMQGEcj7P4XoRG8OU4hLVeufH35hKEg9g6L0++HLPRsB8I9f2Vn29K47FInhzjMTeexlzY1rQq1x7nMxckP1ky3eCQrJJmMvbRZbBJW/kMACJzffqmURNkj+WbaAaqZ7iXilykiR1PhPq3IliXOG52KuI51+IkpOQkFjhIugOjfkQzi6KoBtSE4e+vuMNtQX9711H9LmNIzv3cNVYaNn9PfWkF5syEmDSz3VVnYesoYD+tYMCroe1cg1xqrZhwVHB66uGbrEFC8H8oJyYaUeQI3fwWKjg2lq5hL999cclS9qlAjltkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5NugQfUaIt1+oDeH7ZAsuXQmmKls647u8KnO6Vbi+Ks=;
 b=Qf4ZSAsUOWiyPVTz/L8X+i7EVgOJecBqhQdHUHj1P/T5pUytbmJqjyyVPyAlLL29gJqnWGq/vfGqHwrEVSOseS1HMWJXaFH2SG/XsVifS3CU7cBkkrKtPQ4D5KNt+JplGApox+Te/WnVzquTEpt1fC/057d1JXQItWBe5Qz2ir4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 48/70] perf: Use VMA iterator
Thread-Topic: [PATCH v7 48/70] perf: Use VMA iterator
Thread-Index: AQHYSDFItYf4p8dZkE2jWkRdwqGP6g==
Date:   Mon, 4 Apr 2022 14:35:51 +0000
Message-ID: <20220404143501.2016403-49-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bdb8498f-192b-4c3b-f1ee-08da16488032
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329CCE4007C3160F53F9AA8FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8TlJ0cTr/JrYpWPZcbL1nrzMxe3Cm3mbQQpxfWGT4XbQ4PwFPlfiYrHXymbTWszN+7Sc+0+FFOcIHdusTEqYvd8p5SVt8I5LT6KO8jrabg+5DhXXmiDeA8BT7j3hYVK6yEQkQfKPmRiFzu4V83b0wkzZsfhZq85okQFCpCAsjkkBkNja7UIga20RnQJiKiH8k5VXuBLTQDLLsb0/SfT5SyPayb7jyGtcyO/HHJ9/Ym0kaAnBcFs8qNjOuBBqhoDtLqraQUDIUcbWj8JM1TJmThcvILX/CDj4Ul3pp/DbLX+DP8py133xO9PEhbzQ5JLjxb+MV0dJ7DuzCLkPfMaKwQr6TEajev64oB/XSFR0PWRoqwlqDAdsMX/a6V3ZBYIEkYFnGuP/eDb4FwfxDj0breqaqyxDn5DVwX2CSfRByMlM7CVeJsc9FT3tzklnI6XGcwhhNnb/uuGqYZNbmpeWKnn6fnS/BjkN80J3XLnnIhXe9UR5oShn9GYu6bDn1V9S6/rWmd/o9pEbY8u9Mq4L7/1JA5KD/w56IAo+1wS+y+yA5SGbq2JPbCTgJLrjWc/G9LZTTShCdHzASPHlmlATZ919+F+aXK/WH01ElAfVDJOkAX87PpDBw/DXbpALsx9qsaFceMi3iNa68YVhie8VgADWuuM8oWV5HdUhNpXtwb0f2tw/51r5QYRJYtXCKhN/k81rJ3DRHLeXNMUq8Emkfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BOoLsfncpyWFWw/noNjMc39Pze8vZq2W0MDvJZ2I9mwpIDhAV5OrUqDFiE?=
 =?iso-8859-1?Q?6aksXYdJlmMjybVeT6OYrXve0cOt0TBSf2DzCPm1TY2f1th521njZcZUej?=
 =?iso-8859-1?Q?TC4vt0bAcrmaDZ66HVEnRlJ6R5zUXqkQaR/esE2EHowcYYEwMCrF7RH3+C?=
 =?iso-8859-1?Q?HfktGVi9zE3KXYMNFc1DDb6sMYG5N1sqJeV8rr36/tL3xKtJh2c/dnD2MC?=
 =?iso-8859-1?Q?pwPFlsJh0RIWTUllbYDimM/Y+s9YLfVP2vn5FtesS5nRjPQqPHeH95KLwU?=
 =?iso-8859-1?Q?aV9El3OgJpZldVHzd6PBU1pMUvdxyA3vgKEYBxRX3ngUC3sTp9TUA7U47T?=
 =?iso-8859-1?Q?K+NSA/G+Gq2PxrlXr3YL0WmxmfJHGcChIFm+YowpS2QoOGGnx45BklQnyG?=
 =?iso-8859-1?Q?y7dXmW+55D1ryDnHustULpQm4Nc4xpr2rlimeRaIuhe/tbACMPiBhD9Rst?=
 =?iso-8859-1?Q?blm7Eu+JVkrMcFbM8ym3ggM/qq0FxeTSgN2Gr8RzzOmXmRRBGqVCAEvmN6?=
 =?iso-8859-1?Q?DAbOHaGHgx/CafNfkEHZix5lR/PCfDAuNXvXjWUTPzjh3tZLwPEm/cqgtW?=
 =?iso-8859-1?Q?u2LkOwymedjW9mUa0HdZacHV8aVK+g4rjevSYRku2S6I4u2JFEJk9B7UZr?=
 =?iso-8859-1?Q?/zGES+dTlblZ46Ww7NdaBFfZ4Rqsw7CYmygg5hyYXdJLrSmnYqTqND7T3v?=
 =?iso-8859-1?Q?/rBuFWYuRKXFEP/sAW5kbBj/kTUeEbdiPlWXb/4uHy7tYIKn6ee4XAPv0o?=
 =?iso-8859-1?Q?mFjVKTWJiJ3qWxDPOdsTyYHC+QJoYkgIh96ANWjH5RcTftN3FuOacxH9L3?=
 =?iso-8859-1?Q?P0xPuIXxHTMRtAv2UJplzcMVK45FBGxKgijl0jGe75f6EZAAcQV6hcDrEa?=
 =?iso-8859-1?Q?Qjs+45yd409qlPj/g5o83xRWf0rwcjCeSWc7aAfTJ37kem8q6+8we1XLgb?=
 =?iso-8859-1?Q?nhw0/UBIXhBBqs/X6ljOxScZebTvuD9g4G1XCQu7VMcwoIURczInWygj2G?=
 =?iso-8859-1?Q?gAYfexiQa6TC7sIud2LB0tuf8u1S5XmsALpQY5Nj8SbtY2iVqOtTSh2Owa?=
 =?iso-8859-1?Q?wqvQgus/Y6mBxlNbzpmJO2j2YZssqpoKA8GRipBPJ9Nul+xuSB3e0Ac+uw?=
 =?iso-8859-1?Q?KflRWMcNjt1RdImRS5PXP94x2+eTdEgpOAh1YyLmcpHdBmLzNoFQbmH5sf?=
 =?iso-8859-1?Q?6ed1TH2i8Rx2qzgcij9MoaERGqCtPa7bu/v39JAWMPNSnKHJ2dsOMIYp3y?=
 =?iso-8859-1?Q?9HMVxqjdUam/71LYzlz5mdxyPsFmHwcnvrI7JeXFpCw900rusgqfRgWlMe?=
 =?iso-8859-1?Q?9AxP0swlOYyLZzTWSmDGeirXGDijMDA9TVnDzSPvVzAHUk4bOOTLPiZZCv?=
 =?iso-8859-1?Q?YWsxyaBjJxStCzDJbZ/VTPEIxnlBhAkNt8ZtymhQMvjjlJJH2fdjH+KttO?=
 =?iso-8859-1?Q?+w04824ka0J/VkkMPquNCkHXbBq+vFsQYHXKNTMJGbrdKruRE4SwUcliUA?=
 =?iso-8859-1?Q?95YNIslqdKm/lS1vg0y8xbyHZZxk0Bcclb/pqC+v+tQYG6uiqfZG7CPEWC?=
 =?iso-8859-1?Q?Fa687C/VRHHa1VYUx/szLSgV1mmVOicjJqRemts9RGEvaKFBLzruEcNdIL?=
 =?iso-8859-1?Q?UwJbInV/JQ6I9trryE1Ka7cFv2E8OHHcrG7Ylly7MjiZfkP4Tnny0eXi0p?=
 =?iso-8859-1?Q?JIdCbFG88XnH6RSmfQclxGP9OFU+SgxciNHKVQydHu/7Y+grietOuQLQEj?=
 =?iso-8859-1?Q?BUrwskFXEUEzIjoLg/Y+mVsLfvPVhlKDKZSIf4VcPusBhI0kUafSGlFQ5l?=
 =?iso-8859-1?Q?cVaO+XmV3ahZJ22YF9wEVOzePJ6jc68=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb8498f-192b-4c3b-f1ee-08da16488032
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:51.9086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fMzf2gIoIb+5dN5Sl1SZTRhk4bi9lqdjRAmVByyWUtozYFRJjVYWfHpqUVdOuvcmWygrTG+ZTs5RJKIFnm2stA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: gDVXUKt6hlIOomVklx755KO7srP9O4Nq
X-Proofpoint-GUID: gDVXUKt6hlIOomVklx755KO7srP9O4Nq
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index cfde994ce61c..19c932747e17 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10316,8 +10316,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6418083901d4..84b5a7cdfe81 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -349,9 +349,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1230,11 +1231,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1982,9 +1984,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.34.1
