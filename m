Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAB4553C33
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354774AbiFUUuh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354604AbiFUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9852E12083
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:04 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ4NhJ004714;
        Tue, 21 Jun 2022 20:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tvs7CSFXC1VPnyrfd0DOnFK1dhedtGa/BS1QvJHKxgU=;
 b=j64xjQeAquB6GIkwqE/SmKeCZIytKX9kHqjBwBIkJFjfTut36mxjZXJ+e6owrf0s27CX
 ztfF5NNkeFpSYdjTIM15ZzyDLCD8YFLb5FBqsT+JOuy/JVPWezhVJI8vJC8zXsEQNP+/
 SvsNctwCeseoyhP+0LXXuGw55vURygv/hdRB5yCBvgs2u9aLH0994pXRlWxJ7vwRMs9P
 s34g2eQO0iC+IhQhACnPaUsvxHciJV2pyL4O746fb91atddVG0S1x35rnp4QXOVy9KNt
 SNeJaeycm/Al8q7VG3WojpToqK6kfR1ZHeTwNJqlMb1vsOBjXaYI6PKEam/8+q+tmJPv eA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnx0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUi0027847;
        Tue, 21 Jun 2022 20:47:50 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqV88OntIO5a9Q/FJECppsBqnfkefYZd5Z6lkt1hAc+zcT1boB7UCU7ePmwgG9YOUDkN1LUW5RH2E0nnrCnesuP57Py/voytqPa/muLC0wMtvKly4tJfKdvDWBbLCCuOlTHlZ5kYE06SZxOr205vBYmoLxRYQuhAwXYc02tzizgflA/Y05WaI/F9iK6V+5BIlPWxI8pbKZiisbgKSqouDvF2tsxkDDp1yZew0ymZqGFgw1JeFw7QWysRBI83W/p10jHB1Wb8k2wSjHKUYIA0Tj+9hsL7q8f1ORN3Y7xhx5EpeEkOElLAZ6Va0/4YGJGEZk3i3uEuGogusWb6/wwIWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvs7CSFXC1VPnyrfd0DOnFK1dhedtGa/BS1QvJHKxgU=;
 b=O+vgidUIhrVQtTgd+aXnBZJ+n7Om8p+GkPLYSj+M3C02tRiW5deVkjJxdonk6xW/mQ5amL3Cc+bJlINA1zXOcAuvP/8OcxEIaN/qvHNfHrUgn2QHPROHS8opvRjrPSW7RWtiT5nAHAcCcEPrd8fMhPOnb9YFlA8KdXEwDAy01sQbFnv5TSKsfCsqDu2RYMGhsD+vEAzDK59YbFn8s3dcOY9ja4DXlk5MvQwRZkU2SmfaQjtmYTz0NcCuyAhZyr9JTfk9I2V4sawy4hdquh6zlayuxfu1Lx2Cai1Bitje2XHSiKl82ifjU15kMJNKdxcuDd7/yOoobiLOd9W6duoYzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvs7CSFXC1VPnyrfd0DOnFK1dhedtGa/BS1QvJHKxgU=;
 b=XHK3mqHgeo/lFK2MgRpiuFGDlDjXo1mV6gFOI4MtL/UA75lvjqgym8EOX9CkiUqm2HOFpowTAOC7cT8Zla1Nnum84cNxe0qIaMUgvomimjr4iMU/ukPUML0FCctvPcoBhh932KeUBVj3mmaKN5GC6/7+9240bsjyql4VZkazx8c=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 39/69] um: remove vma linked list walk
Thread-Topic: [PATCH v10 39/69] um: remove vma linked list walk
Thread-Index: AQHYhbARBlm4gN8y8Uep/1bQnEdRXA==
Date:   Tue, 21 Jun 2022 20:47:05 +0000
Message-ID: <20220621204632.3370049-40-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 290c194c-a778-40cd-e7ee-08da53c74cb9
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB40254DA3A4C49CF69265F4C5FDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iIKnOpPZ+BU4XWeIg7St4uG3VFNWqARFrZiUE5Z2AodlrqMnAHpBRok8hy300WWv2gG+xZUw5Eoq2e2VkkdVns8gYXp9zurSHBC81X9Z3gTgAJ0f3kQEaQ5RhTNLP+1GOhs5wVynjNwNjvWuPesrDPrzcgzZOLM0XRCynDvUT0mmN+7fRoj4DUgEaLGDToe9ifn77NlrUBT+Y7kZ8gwxaCmiOe3Dsc/5Tshtnump6zO13/oxNJ2ksn6pwFDIuF5xsuveD0BS7HwI+JtBTNacaUDm9iyyGIqxrYX5ILsnCF0Gb1gmNdTy3Sf7M2A4ZafcR8vtUQM4CbaEIJ3JSA8ZLmiJC9/wHGT+/1w58llebcYg5HeM4Xp1PSyztnm+T0Ybi6uudpmt5LXMN4eW65vPBN9ybWzeXKfDk4EKx2i9yy5WYg3pPY8FozKgCgiPro3DxOyzTfXeuPU7sbdRbNgbyOnBAtmuyIW0l8giGsIikjQRatW+67zAY358szZ2GsZAcBBhPrF21jMnMmee5JtylJNFq/M2sEDNXBrYIf1NZUfiyJhXMByXPr9ny4YrzciwwK9jbeMbXf4jhGXHSwERNYNPvrGejqd3JxHfP3kDpKaugAsaiJnh/m5vYt8henmDYxZ89EbdtwXB92O/Uae70RNDMUmqxbvj+cAqcaQSdLkB/AmLU1y5R1mWT0cZtCqRiQqQWkEXKOtkIejJAMJa2KypEgoxhW4RCyoOs6KN8RzIlnIBTXu1H5rtZg/XFwG5qlIpgQENurfQJpKBvGEWrggHXzuuA4M8IeXXXPx/x4U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7Rr8xp/5FgdIZsxzT5dg/ZkdRbWBFzYxp/ffOmEgJ935Jh7BWfAq3aKDod?=
 =?iso-8859-1?Q?Xn60aF07NVxMmIVtbUGkcqoSbzMc+qVap4eb1nrx2kKsc00NLPtamMaPFA?=
 =?iso-8859-1?Q?6UwchuvaFdlCXE/042R+Hq7u1RAGOfvQg6q7kYNMYRSxQ8ExkAYyE1VcvX?=
 =?iso-8859-1?Q?OVV1o+nBQd64D+2nOVXKkyON8uGL8b4+9HROzeU5PzSXgm5ohDzluAq5WY?=
 =?iso-8859-1?Q?NaOLnrq7UtrnD6kOiKXr8GAqLKWlJ7WV/3BmiJubWKf549Mwzsks6JlJlc?=
 =?iso-8859-1?Q?cHk7aaEPqZHXBxFPZIs8YqXVKGC+K+25hU7eJgXDD+F5jHEAy/90fCLOfD?=
 =?iso-8859-1?Q?T578wSRikD5rLXHQZnp+qCNHPUMhWq54diP+/zukk7szTf6RUbpFL1BE2+?=
 =?iso-8859-1?Q?Be6vxRs/jb+a1poQczESuxT680wm7RpgSNAO+XIijXzl6TOkpwNc/MbekR?=
 =?iso-8859-1?Q?ybQ54s7T3DrOqsyOgJuA2V2kLbgqlKDdHV0x8QOgStLcsSNPpAbNXltFaU?=
 =?iso-8859-1?Q?Vor0r/uezgkvCsuuBcjM2sshTSTxRzvvgfh2I+gDjHc26qKnjglLZof7qb?=
 =?iso-8859-1?Q?Z6MlbD827VG1wxpTxUC7Iqjm/fUrzaGURfJosTSGlS1L3pqaAMV+l06aXL?=
 =?iso-8859-1?Q?2WpFLQ+3bZ8PUCNe/5ku9KezDFV+hIYHkrp6wb/4tW8w4Dj0g4PBoYf4ai?=
 =?iso-8859-1?Q?j6HuyaA6VSF2zISKUEo8L7gYXPRpocdONVjM/d5esYjcXHO3rsHTj8NFeP?=
 =?iso-8859-1?Q?Rtjz22FH74dtzO+BwUOJRRnz5ZQQD+cwO5gX0zQjXYC6KTFk3JJlHiEj6Q?=
 =?iso-8859-1?Q?AFa8t0FGNJW70lOevdcS3pSo3SBbcae8B1LauRVGMfssgLamlupEhSdGE9?=
 =?iso-8859-1?Q?HvFWxHXRTy6xG0fx92Yxu+B4nNUvnmd9Al70F1N2OD/d0oFidZoDlB6GlP?=
 =?iso-8859-1?Q?+vHp/bg9gzha66vTF8CcIDFtjuVmBANAACPoGT4GjcZhxLYTePMaRI8Rbr?=
 =?iso-8859-1?Q?q8Akq6BjaP+GbGyRkALeVBWHJxuZVNn8hx3zrnV2s/HP4pI/yW6oAZbqVp?=
 =?iso-8859-1?Q?DPd4kwUG2gtj6CRguNuk0xYkcqrBzlHt/IpVqb+MkFUbLannI17O4zAr5V?=
 =?iso-8859-1?Q?/Fyl8mUQkxJa1XcSg1g4BFwtxA+PXL3EkT/7J8cRhhAfb8ZJKP4JbIiXsf?=
 =?iso-8859-1?Q?UyHjFltJy3rycbJiWokGYM9Qi//BGzNQyTRSykftHtRXV7K2DmPJR1JJvO?=
 =?iso-8859-1?Q?RZbC4YKOy/rydlYM/235HGJP4ufmF94qp01EOVfgQzBq0FfyxwWU/I2UMa?=
 =?iso-8859-1?Q?ZmPNdejrGZo44NnIuhJd915FDeVGhGU1RO7v1IFf9yzEX/izHbWyg6aDTz?=
 =?iso-8859-1?Q?FUCBfQkUHdRJdhCsLmCK57+PIQzLBmbOM8r8haoVVocVoXNwznnkkQPD3q?=
 =?iso-8859-1?Q?gsxW8DR4U/A6261IKFcWA9gHiq3gzOcb3uFaYT3rwbo4JOZeDQ6HvIkd70?=
 =?iso-8859-1?Q?mE03Gd8928gy8dfX1a58Law55TVsdiGvBn2L/FA/gzm3HYa9Zny/w/aLUW?=
 =?iso-8859-1?Q?ZZBkmJ02Dc1avSLB8vP2Jrb1Jom2HSgNiQDyZVdENbphH8TqvSLVx8ehzd?=
 =?iso-8859-1?Q?9LUQNAA0X0PNy2baLaaE1V7rLaYOtxuqXDmZbXCKsg1A3IugfApMZhhz4V?=
 =?iso-8859-1?Q?9dWULXI7YsI7btS+cPLfB0NlFfQZr1ptk3nuhORKKxjU5jYq/3Ne3NsDkJ?=
 =?iso-8859-1?Q?ea81QHWaWPvNYAvhUyHPh8UnGpK7X9VJnRopqGoC/+xRXhqVxEYRYQH1uJ?=
 =?iso-8859-1?Q?oPlBxVoVRWTlMycBRDlOIVO6q79sa8k=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 290c194c-a778-40cd-e7ee-08da53c74cb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:05.9411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: leyWtodU1cam42+DYhL55z6Z4xi9IBhNxMgdzi7lyyTBwzxcEwPJCLWv4h5m8jGjUONIWpLNEPIZk/WyUD13Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: ipByM8Z7w9da3xB3Y1nbUSpti5VEZ4xP
X-Proofpoint-ORIG-GUID: ipByM8Z7w9da3xB3Y1nbUSpti5VEZ4xP
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

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-24-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/um/kernel/tlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..ad449173a1a1 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.35.1
