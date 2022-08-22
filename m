Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E581A59C27A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiHVPRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbiHVPMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:12:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C112C3AE7C
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkP1x022949;
        Mon, 22 Aug 2022 15:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CH64GcY3oAi9l2u8VeI4he5UYZeaebKJ/ZXa08BvPw4=;
 b=ho7TR/9ONHcV72iGQCPclAdJdTXhU/Q3yx4RCmGMe/A0DoTl+ecdn7mdwes08FE96uTN
 nAklboTAAqBAowZsOJ2D75r9IwC4OQxph5VNf9h+Nzc+FoaGMWcvxM+i3Zxqj4YOGXLs
 J/C1zY2ROgVChH9EB1lkB+wTGN3kUQkptZ5eEvMQpxyj9p5HU0UspO+Tb8faD/C0+Afq
 GUE/nC+GnVlHvvxkE2RWGBBIuvCuMaoUfNEu0SnmiWEF0d6HRa6H/D5YPDFrKDgNbN0Z
 w1eH3LFmsJDIk31cB8m0bSv6npjqRNW4oy+Fl+jq0x3F8YUvOqvxb9+EYu2hzr2uNap+ +A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nan031868;
        Mon, 22 Aug 2022 15:06:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHWTx/a7QXEXhni9+BmDMH/ILYBjXsBwOFVsDEGQX8PXjHdaOsgD0VHFXmMidUoox271Z4zNR6F07h1w1eY2MTVQiJrYeegT5lniim2tYbVSfgGzGiliJOubLQXAuvmevemQt5K0ja0jgN0WMIN6W7LPyl7QK7bVGMpmYfa+i4+ALC45txg9aH/IpjAqdvNaHpx9/r+gRzaHsxxKK1cIxccnakAx3tQu5owgrQ8mfp/dEhO6+hwcmzoqeQpBJCp4c2ICJTfFdaVXYVGhcKfUlqvwdO6ntlkFYvU+Xs7lhmK7Zz8YR788pOdmZrV3dLvIdHHyakJUQHlwqnZTjTTVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CH64GcY3oAi9l2u8VeI4he5UYZeaebKJ/ZXa08BvPw4=;
 b=bJD1Rc2srOveKyqI337FTrRoaEkmUjxvRNirlmNAorYE8kWijQSqcrqSPnui4VngSZKVnRmXJ9JMYtYYlogCiO5uhQdEY15+bzVH+ejpsdtFgQMnu3NjDT+e/Pv69n9M61bZOpSVA6BrBA3pddoUZXTbI449BV8TZyuz+QSOykYi7lCLQfP4gvocRIJJ+NQokq2fH6yFwfCnWVof7J5YVfVVGtVxBfC5g/horrEtRdMGCuQOTKfGUotH77qRWJi5+du6L8zqBCFJKrfvcQ/ji/ahPw1zNTPGKQEWJxd1kflH7cBk38SwJbfm53pkqOeMPD1FPzLQWj8iBOZTX1TCAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CH64GcY3oAi9l2u8VeI4he5UYZeaebKJ/ZXa08BvPw4=;
 b=QaJHzYtec8lAiRl2+TvMa4iXwMM+nN3h1v72RfXcqm7hW7vutwnO5MWv+MKM8Y2FedgTnEtPzso4gllWD3ExlV58pbqC+VDgcHNGesDMhCPuuY2/NUEKI4TMXoNGTZebcjzoc1x+F5mG8xR3yb6ZCB+o8RgC8ovV04LTFGB1hPw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 53/70] mm/ksm: use vma iterators instead of vma linked
 list
Thread-Topic: [PATCH v13 53/70] mm/ksm: use vma iterators instead of vma
 linked list
Thread-Index: AQHYtjjBpoadXE9nQ0e5H0KbayLp9A==
Date:   Mon, 22 Aug 2022 15:06:29 +0000
Message-ID: <20220822150128.1562046-54-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ecef3125-9218-4297-5f64-08da844fe609
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVcmj4zBu95NYzmlp7eDZoGwtTYddJYq/nqb39Mpr2EeVtVJd/iHHXdCT30iWlDPA/zWNQm05+95t7XzCQu/cYuUMpNlBTVMsqvyBgjvDfs3T0h1HDTdowWutCWOK7YfjBiJfyVfDAdT6RM+MDNvGf5HIzx5QnEfn61opN1qze0BwpDFnI8F0exE5rD8YqPlnTSqf+/z9HlpoJYN4m66s44exaxjFCafcFiaXeVPfqjci0r1ATAnfFu48Ef/8uEy9Z4X7uNDu1psvfKRhmgYTJlikxQmnLO9LgbWiCS1qp/dHq09/JPKrQjub+Ah/jF2qfpteVMBYV5yD3UAo0h9ySG1l1XawZLUxuzPn7C1QPnzqUMsU0SO1W8D/Hf/K/jFln9dIBRgjMk0C4QK6C7lXiUIVF9rlVsacTx+Gp8kZwP8MG+1p1EulRF9ghOf7RYcM7Iz6PF+4IS/uSf8l4NzI/MJLzHRtXlp1JEGa62qNGz86yMYs6deNoQU6PzHrWEr8UrcGVL732HVPgBHyeZ1aQKL/OCN8N2qwe0cQuN1rIVctZ5O8omrddvsSDQMaxJCvKeQ4RKz8s8aK4R4Kuw+ldGTz/Who5jnjOXan14kXKetd01zAV46adFsg4PHS9SH8rXHxAaikNS1YdXiMTKrr+V10USf+nu8i8zAxaoreGJVu4gKapcbV8qGro4qCVVlQVSIKUOxKiYePRcusfEpK50Y+Chblu1SVG0lUmpBYFb1m4emfO186461iZ+ruz6NtsqJtIyJHxPFh3JMt0yXOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(107886003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZMbwGVGJZA5JwPdLszdO29hdf8Qb0NGqhPJn3UFQoY83vzwoJElD8OwrY3?=
 =?iso-8859-1?Q?4es30VrSNISvkDAyVARJyyOe1QEfPm7kQFe2mlTnmdUTZGm4ezQDlsPIxJ?=
 =?iso-8859-1?Q?QsLLZ2K3d73TVsGfTWQroucty+ZAocN4ncQQI1RXTustLVmegetWkvw2nB?=
 =?iso-8859-1?Q?F5u55WU6R8osn0FP9sKnnfiKSG6BxfK8r/is6hqfCOT1oTGmZLCAU0qpyp?=
 =?iso-8859-1?Q?CUrMwMebfTLK4dz8NjrHT4u2XSw+UTQ9LHI+wjcvv4HJNiLVwKZxy5kl2g?=
 =?iso-8859-1?Q?mG5qqpLJmSLSX1lyOs14j74tN6fWBoH5LoHoIuY7UoBiIMyxsxYKwztkfC?=
 =?iso-8859-1?Q?kz9XPfdWoIPSPx7duhnOAYo/uhPTEro6mKFbNKXUf/y87PjwTKnR1SujTo?=
 =?iso-8859-1?Q?Ml1i682S+XF43dzDlMPCWw4jMqrfxFmGTsHvdepXwa53q9PGhVHthBVAsq?=
 =?iso-8859-1?Q?VI5JClwSuAfe01h60RP1T+H3GLCkT72RDYDy4dGcB6//m5biYfG4GRANL4?=
 =?iso-8859-1?Q?h1xOqGBRVqcN9eSgOiF9XS8d7M8+nxyReeHqCALaj+Gqd2IIXS0TbU/EjN?=
 =?iso-8859-1?Q?y8nN1yDbdPSG1CNTpan8EIh3GD9/LB1+NRVKDEcIQwTgmz4qXMRie9y3ZJ?=
 =?iso-8859-1?Q?zBNnwA8zNwV7gLJ5rbGwnfkLG6JylwnNoKhPozXmYM9XlaLruKJgTlTZZ6?=
 =?iso-8859-1?Q?n0LRYELe8gsoGcWczpAvRcoeNJ7+y8NbK8O8rkE3dr9r5Ci27/eO6YfC3l?=
 =?iso-8859-1?Q?B8zrb9/dUBARoMWs4CfC1UIzQL9XuGxcPE7rwvE9YXMT2RhRnNfJjjlYk8?=
 =?iso-8859-1?Q?ORsrMnAC9cHcjgmTspXb0UYA5+SlS12hjY1XkihrRGMd1UdLrq7xzzH1no?=
 =?iso-8859-1?Q?1PgzJKNDHLnlSZx60IyGi6afo59ccc5LDA6MLrKZRD1rcmfODryWu5iBp7?=
 =?iso-8859-1?Q?/BHsmyQXuxHzyoNnCHvd0yY84ECndqefFcjXFGHvAki8zHLhTWuwk1/Mww?=
 =?iso-8859-1?Q?wIwvGJbXPKjDc/gRHeoNRaAxpMQxrxTLEvjx5bBvfkXtLw0ronId9x+bNc?=
 =?iso-8859-1?Q?oocjNc6MU85PyKEKtCbRmyXoWas2PoVOFAVTR8nl9uJrusnELtPZO9l+Ku?=
 =?iso-8859-1?Q?QQO4Y1Yd21sCYQq+0heYjtLutaXxBjggGnsrcw8JCfbsEUsebYX+PwXSeh?=
 =?iso-8859-1?Q?FW5z8DeMQhqYrDWNnT1R8ZXVTMdqA/iat8U7cuOloa786+kZ747vjKLBuw?=
 =?iso-8859-1?Q?zSOeDuZ6qFMaAO+AH1hTpHcHGwnEcCK0SScbSzYWPb5t+J+aoodLrL4/si?=
 =?iso-8859-1?Q?1vhgAolvZFSH0pHq0BkGtADhRxFJnG36E68JYrZseE4eseoi/AqxrFehJ7?=
 =?iso-8859-1?Q?dCD8iJu4BfGQqfU/P8ncJaVrejeDHQIeTxfiXSVQa93DJfQeuLTYKig+n9?=
 =?iso-8859-1?Q?UE1dj6pjXVTDl8JbzqoILrXOJCKe+y31YIWFq3KpUEERUhVL9vhhD0GSkP?=
 =?iso-8859-1?Q?uQIKccB+EU7nM/DtUlaEiA5HEP1ZtgUxSHFUUOJBB4T7OXotbs8KrgKDdz?=
 =?iso-8859-1?Q?2CZId6h8V5WMGdoeuUiFYIjEosPOywJHzgVZyjGpkJlcw588pHxEu+6bO+?=
 =?iso-8859-1?Q?XEY9eC5IADQAQxPNERWZeWc2ZFfVj6sw+DwbEwugdMJt+XXFIbvcaz+g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecef3125-9218-4297-5f64-08da844fe609
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:29.0974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UeOjDSU2KKX165WbQK4/muxzSTA0IxxNq8Qw47CAKxPH650C6RfMNuDKqobDHMMJX03aCbXSWJuc2vk72AA1DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: OwWOG9-ANdoKPqifqSDnN_jHtdLLBZtM
X-Proofpoint-GUID: OwWOG9-ANdoKPqifqSDnN_jHtdLLBZtM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove the use of the linked list for eventual removal.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2f315c69fa2c..a98bc3beb874 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -981,11 +981,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2242,6 +2244,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2300,13 +2303,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2344,6 +2347,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.35.1
