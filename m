Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79264F1742
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378000AbiDDOlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378009AbiDDOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005C93F8BE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DoQm6006381;
        Mon, 4 Apr 2022 14:36:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wiz5TkoVDzUxYD34qvmVOjwFf0jxlCVdJES2T/qMXdU=;
 b=Sb1sSgetXF8hma3pV/S2fwM9fSqyTgQDjH/7xsu1hyPzpeC0BiwQJpF4j5SddHF2CtDk
 y6cqI0L8K4ZCW1N7bmsL+BPJjOETwEnNPs4GW15L8aQos2m5StfJtrQuyMCjARH6A95P
 F7M70/d5ShGchzXSMBlyfKTZCRmd38yrFj5N+FlqnQ5IZOIv9Y+6bKjnS9ryDV9eDqw0
 805nezfEIyoKrErtfQ4djJCU6/2MnMVBz+lzEV0qLYOnvXLtplD/aLbWM36Mos3LSytu
 M6mYAjvrnA2Wsvu2wMQC3luf873aKcxSDHOR6W1ktaGU/aeIuVQePCyNw2lzZLOvqkyl uQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcGB027665;
        Mon, 4 Apr 2022 14:36:24 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ttxi8GoTw+bIeIOxCXsTTNPSdCwH5k3y7hvOt/a568WoDvV9+iKiDsLhLmagkLdMna64+l38gJ+2dXCJOVxXJvxV1iDVX6SWxsGS+6qPgNfrZyZVNLR6gSuocDB5rFST7uKmNTeB89TMF0IujjyY6ic0Z2fakuY4qbStEidLe7CVW+RliIGm+CIXk6i9Y6LMRYrx4THs7xriF7ivDs6epAmqS4x3f/yHXLuDXGXL0hGVCioigqJGECjApl8lLuEcKB40DMVdx8s9lzgdDyFfLyMrXTEmVK4OLhWzMJa3Mxgh4012auJNWI+NTjhWBUECbrtpcdygcV07FxkFlXwMOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiz5TkoVDzUxYD34qvmVOjwFf0jxlCVdJES2T/qMXdU=;
 b=JQJyuHZ8vZ6V6WB4gMX9PVFcSMF7IPo6hlHuF8OHqHotUHLosrUHWinpQIav+Sr3INSOYq9mzToCYAM+rxGmBRFIrM7Wsm1jdKURAKhWYeJqxCCiXuIPidQ+l6OFs+0JVn4KcWR4XuhrfBVzcQAIAfuMhY8lNHy0/WrYl0LEHWdGW+hzs3Vptvj1u5frig9qCGJgzhpGfAsvkO17YolKEXQoBr/ypmg5m1uO9CS1OtyyXd8Ht5jwHi3lg0JkK2AY3qK+f/+F5gwDq/aajssVI+mx62mViIq4HT84CnPSN5mwCv9E5Q6djTgTdzHoKizdZYMc4pQHRwfcQPwHy2J3XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiz5TkoVDzUxYD34qvmVOjwFf0jxlCVdJES2T/qMXdU=;
 b=yLHUtFPT95JLh8h7BvTV0Q1Jg/MW8RlXugJdhxOYAAI9RYavq/ixAvkjNbqj++IGN4nVt30Yct2ihiCZZ07vh8Rtu6ZBB1N0WEoLTjsMp7XO8q4WOSmBd8S9+GZpZGHdiswdE+ZyeXbTWkd4TsIIqy5dR5jwwYTNTel3JQub3rU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 35/70] s390: Remove vma linked list walks
Thread-Topic: [PATCH v7 35/70] s390: Remove vma linked list walks
Thread-Index: AQHYSDFFWymBQy2Zg0yBhLjWYRxupA==
Date:   Mon, 4 Apr 2022 14:35:47 +0000
Message-ID: <20220404143501.2016403-36-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 303a6b71-9461-450a-8b42-08da16487cd1
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381F5D4093ACA414A79558CFDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xkm9kuNig8mjVOwfYDRR1fCCvYg5PGLILRIPBWyfeZmXHXGagGf9+UF31O/bOXdJQ5VhwVvEeq4ET/VBsfNkAbydXcsHXxjjr39ORImQp2oYGfAFRDzT4wf7sKyfD90VgC12UubPPesEQ9U07631FaAYn8MCywiXX0Cj/eOgwDKanI5NQODyZr7rYI3nodaz/6uDjF7fvUFzdnVQWorkhKFQSqVsfezA+0C8/n1dEoK0/Joqva0kzeE/Ewpp18QxjpQ88eRs8z7URs8y8z5cFEWDGl4xwPqy42HrHC4FxIzuEoISeNwh/b1OeQ1eOvYJ3AiRqGkv2pJzvxguCAELaJhbxrdG5TBTfxvUlEKY2l1aHtmqJi4Sc9AgrfbHezkoGe3JsChv6W1ZmjDxXfrvt7ehcPF9wayBmsMBXm/FMnHhVRlLWob8kkYu7O1k3ny+Z1ZmlIRk8ziRDs0LlEIiWAwgcTl3P9Hsv7ZXrFtEFtOX70IAcyL5EpZVuJPs8vmDho/yzgpex9VRdDrUXQuIpNsyV6j3Z65zpxRWowtZUk+iUHnFxnOBJUIlgznAOew9su82LyEVgQsaJQZio/KAsRUx/a5QuyOTg7TFEX+y8LmRDC9DEw+8AUIQjxzlFTkflkZaqfV29B6WbntzMjzEH5P0WPQxvOrbYM3IKlqwFPrqEl6Ufxh2IQWMFD2Gg5lISfFKcfs/XztdyZKZdvp+yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rLHdqlC/MvlyC5SK3c8PZRTSZAySVtYiJCjJrM6i7kDJMrTZo6OFXUpSYq?=
 =?iso-8859-1?Q?+ZzGbdcQSAM454ur7DbuEa2I4fsRxQgTPgdh3s1/Ldwf1LtbtNzeMx7JUO?=
 =?iso-8859-1?Q?hnoFEfdqEP3L50xc/VaNt1c6XvVlez5gnV4K+zqanPouoK2SdIWA7ZEmgN?=
 =?iso-8859-1?Q?KT+zLUuNpgXYBhCPvhp0co9TP9BkkUoUlk85otclcw2yHhisKCeZM2NTf3?=
 =?iso-8859-1?Q?SPe8Fsed0nq7BrrqvrKDfbieHBlsM1jdfzeS15LxA4rb8eKGNiFyJZfBGd?=
 =?iso-8859-1?Q?Rk2AzeAjXsJJ5Wp0IYza9800lGPcVVahjZyD+OdpwzPTK2/PSEXQ4Q76+H?=
 =?iso-8859-1?Q?1cA7xeTIfstrlrxLTmRGqyqBb7eeZHhWjHf/UW4HT1wRMmu4QvecM11M4W?=
 =?iso-8859-1?Q?/pOha8L0I0MA4thVMqXzC/OBd3JiD5HEqC6pcH6J0Jr3otfh5a8Eswn06j?=
 =?iso-8859-1?Q?/9MtN4WkaT9S+Nj2bvc6c+Bn7qA/2W+rqX5eyLKL3Cm4OY18I/5yhPODUK?=
 =?iso-8859-1?Q?fiOYCzvCeDzuFMyc1U+2u+8nc6BwJzZoHLd4XpiIjGLDutVYQDU2/kTqKy?=
 =?iso-8859-1?Q?8JbFUxL/1uTKQfzb5H69OvaPvhFUdDa1nwhQWMDOOYqueG2kOk4a3weTMt?=
 =?iso-8859-1?Q?8ZlEdCB2WEYD7bLfGS8mERkITifR1ysdS376MW1PHPHmRE2bkxAnwRoJyN?=
 =?iso-8859-1?Q?nkE0n6SZbhp3RKQkYOSoCQYZgvbBnRFCmONQ+374CvIkb0k+wRK6b+3LUJ?=
 =?iso-8859-1?Q?TUgExsiKYWv7u96HUHHytnzIY7htEWFF0BdkDbbgvLAlIKpq2EQRr88Tlw?=
 =?iso-8859-1?Q?WZ3PONEePHxZsZwx4cFMPjJU/q60JYI/JSD9bDpDYZzISR08b1+uQg6HK+?=
 =?iso-8859-1?Q?03kgXMjDtdmsdTG1/h+mv/sfi0cpCl4EyzVY+2IyAMDQPjhUkfSg2xwSfl?=
 =?iso-8859-1?Q?Q2QyCleKDYbX0wD/DQ26kFGnrmJVBB8KwyFQQZrVcY3LX0TOn667Qp8ghF?=
 =?iso-8859-1?Q?XEVGhFSjeNCYVotITFY4TNDNOE69bldUVKdxGaw6SfjyjR85YPbHU/OnWy?=
 =?iso-8859-1?Q?J0g4TxmxHS6IRpcmhgRqx8HB1eKSREOSZxiTt/TuABINVOeus0pQ/LxmsL?=
 =?iso-8859-1?Q?aykiu1iOGsSCNdkP8boXZGaPyoXH7ZZgsKHsiUMPV+w9XhZb9ocuwJAx3m?=
 =?iso-8859-1?Q?dk3oemFLEeCPdMa/Dx2l5Et3gmC7nFlLRRlDVoXeRflR8PfV7Cn/br4L6k?=
 =?iso-8859-1?Q?fpok0onAg7xf9V9O9PtUvysl1a9RrFW4dBq/fJP63Eo0jAvcvhJzwWqnZm?=
 =?iso-8859-1?Q?0ovKTU5A2sStPl11WUm6VnLtXywuzzqeT9R2hQvkYf1CRe0pQaYQGpOVlC?=
 =?iso-8859-1?Q?cULIDOOT333NMYr9dK6hebKaxEFsTShOOzGRzf/P9YhHv3N2BVZVq1BWv7?=
 =?iso-8859-1?Q?ozHG7VTkzddAv+wHNqKxAbh2HM6F1F+vFHIhgx5N5EIjf+zpLsCmoYS6EA?=
 =?iso-8859-1?Q?Ts7vbAdQmFiyNE0TFY0QwXAs+c6cUNLTt2SPmc/BL6N2mvDRs38lnlVywh?=
 =?iso-8859-1?Q?UilrCVteaZTeRaQSRUgYRDQHjHSQNi6HAAhEy+//Dt1QJrygv+UsUTKRal?=
 =?iso-8859-1?Q?TyWXFJ5+3f6tW393wSwKTgJPu8M6mmDG3ImxZTsCEkNbkbEOcp1vaLmqkQ?=
 =?iso-8859-1?Q?I8nTECkltWcP7qRDNCtqOzViBMNXKdc3CNtuGIj61zgVRGxcZ3YKJR6liw?=
 =?iso-8859-1?Q?IvliB2pNjgO6EqXIfTkk3BYOO3IKZVsHjJCHcoQqnxMNyyYEBbNzISIHt6?=
 =?iso-8859-1?Q?rchJz8Mxpz35ajAUFn4nO4n2QlllHiE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 303a6b71-9461-450a-8b42-08da16487cd1
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:47.0808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qHU0MA61RPlQrdUDVlxfmv5DeGeGHn/KSe11+fE170H8G7u7d+pIbAzhNpgZ8rbYKFL/HAExmSX5xkbfBCsW4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: xI8jZpTQpvbh61cLojoyXe7oIBm9ZLkX
X-Proofpoint-ORIG-GUID: xI8jZpTQpvbh61cLojoyXe7oIBm9ZLkX
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 99694260cac9..66f7e7c63632 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -68,10 +68,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index af03cacf34ec..8a639487f840 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2508,8 +2508,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2577,8 +2578,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.34.1
