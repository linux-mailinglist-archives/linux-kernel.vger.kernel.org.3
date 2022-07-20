Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3596657ADB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241495AbiGTCYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241510AbiGTCXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:00 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19D44E628
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:20 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0JPuq031784;
        Wed, 20 Jul 2022 02:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fw8iggsZKrpj6KZCqzPE7XQWA07OTVo/TPN3GDUGa0Q=;
 b=D4sARxURucH4UwhAcgvkiWe0vR00FAxdlFlPzXdUUY68RzCxIitLBpxo2YdIhTa/BIrS
 hStMgYFJT21FotFKeKtVeJfUmeE9dkZv9dyBd78YURZX1NC7BXDDz6g/823feiANpvqH
 yMdQwZmD+2TotUeamEFyTrKuVMCicgX0tDgI8DnojM4m20+gxCZOTDloCwKvK7npHBqU
 Opo///y+P6C86fUZ/22Vje/EpAvqhscjILLGAwgheiLUookSHcLy0AU9A1h9V8F818MR
 deNVitN+g7SHrFSCnPFzQXdZtaaXqSAG0V1QPMmfgi4+AIUm8G7H01T/lqRHWnuQ/3fy fg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6bq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:46 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHEna007944;
        Wed, 20 Jul 2022 02:18:45 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3w3kw-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVJyIqhZx2LUHjI0z6+S99wy+30uuxu1KE1+6M8BJUduYeV+W0+EOQtyYocRWH+9hjswB7Bju0e6HY2CJYCIrGblaSexoPRni1bld19+k3r0JixIS/ktk1KFwrnI+xOCX/UAReUKIFboCT1Arodf3L6pt3dL8YiAOvPJAtYkhdqEcD/JbHhoJl422xt/DFx6eeIeROEBkpajesnQ3lgtyMx2SmI+cvRDme+/aFEgPU/+mMmjIEaFICT3PRtamr5GN8INQNIlDRv4la2UUj9l2TaN7A9BsNNoNLOzgtaB7eqsq8njHER067DrPzlN/yCyJ2uXp19NluT5+mDJIDhtpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fw8iggsZKrpj6KZCqzPE7XQWA07OTVo/TPN3GDUGa0Q=;
 b=AXcxgtr5n1szcV4wwKirjW0Pcx25gGClVmo2iv6IPKsfSJwhEva9eP0xEufym9wVn/i/5hmUdGCiUAxyO7oqhBNE1gbCT1ZaQAjXk6/sn3LxXflmcoVnKBOZOnnWclb5P9xvjAmdr2YgdnGd4ZbzMZr2BCoQ9STKrgX7h8799Yn+8n+EVEc/I327zU+o+X3/P/eOrwCPrn5J6BvjKfcSGENGijSng2jnb9A3s/5wVEM0dzzfJTyhuK8io4U1mkjxkS9Xw5rWm6tXMMTfLKp1ifvgV/g1PGIsCGnKFXfa9T9FmBMTye0QUztdWU5+rh8j0rMSE4OSlNmRBGDlHy0XiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fw8iggsZKrpj6KZCqzPE7XQWA07OTVo/TPN3GDUGa0Q=;
 b=rW4MdKPy2QsXrd3Ubat0t7k14BgukXHVJbEpatrS2B1LRoxOu819K5+MnJ4PkD6296mzEV3qZWhL0wirZH3LBuBV23Ql4Thj/Fvm1UeF+VrCtzsaN/eN4fWXQLV9IMurMtuO4CDomtctfBVlbYiTAkzU3bQeuDMyljsc78bzzPU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL3PR10MB6233.namprd10.prod.outlook.com (2603:10b6:208:38c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 02:18:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 57/69] mm/mlock: use vma iterator and maple state instead
 of vma linked list
Thread-Topic: [PATCH v12 57/69] mm/mlock: use vma iterator and maple state
 instead of vma linked list
Thread-Index: AQHYm97v8Wbn2YCWSEaq0szTMkwUqw==
Date:   Wed, 20 Jul 2022 02:18:01 +0000
Message-ID: <20220720021727.17018-58-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0006fdf0-9983-41e1-26cc-08da69f62b30
x-ms-traffictypediagnostic: BL3PR10MB6233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G9QJ0+8Lp0MYIBbchIJwiGHGC1FZUgfZC3Ipp8wOkHx8Wb4JdQuq/jvwuFwFsCFcif2pHEjxG+wN4Batzv7RMqo/jjX7HQNBttuVnoPexKNAwsG/8qe5CgBVelj2uJCIscb0qfYCfc0J1ZsTTIt2k5ewLmNYVEuuZ7WhVicV4efoSBxHuvFFtN1pjW+A+L0zDvLPwhkR40KatKUF9wkO4y3/zts3SVeoQ/HLueDVkIeYgWF4dv/2x4fIuKDUcvecwm4UeRl02cQKEA99bhUmsBQwhnQ/PB9gXBFrQ4+tXzi4PpHGqQH7iyKVokwBxLhuPW+QNlQ7U7ZpFFlgXLf8qFR/OMBzH7jA/4oWDuUVEMO5zhZlAfC9Ub6xjdvDqXd9fiIqtB1FVGw1sZaStRaZJ+6Sxzqq+JZgNbOEiT5xQOUVYot67OwWRfE3UtlVUUmpz3cp86xCwksrzE6mgZTvmy5iO+vC0HH7iy8h7VkYQODbp4m9weG2sW+TYRXW5Zr+d8mDkVeMsgygOr0o7p1Fu1FkNT7CCFunoKfq9HMZ0aP06hYThwsVRiZmxM7Tdix2gGHrzrL9zXXdWxyNEhtdPZwVbXBHH8qi4kSkCqX5wQmPo2UGGgj5LnbEjB4015vTLXgw2TxHR7Hh05jUV1JjK9kuOqMXJ2y4YacLbqMUF6R/VKHzuvHw6IN4p6ImZ7wUennV77V3peAeBrM97Xn/NHpNVCRobXdn8ZFpLPvPik4h8IsUlhgmd/wpKi1+kX5ig/M4q00VtcQyfXTVHDzBvZCfAGxHiVinU2MZiOE/2FpmxLsP+Rk1kmHWumgGthMKDCOaD99EjetlA+TmmirHBR/cW2hmg4SgumB9WtPkGFRZbjjH3KzfbUZKqlj0ZWJ1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(396003)(136003)(39860400002)(366004)(186003)(6666004)(2906002)(41300700001)(6512007)(1076003)(38100700002)(6506007)(26005)(2616005)(38070700005)(86362001)(83380400001)(122000001)(478600001)(316002)(44832011)(8676002)(4326008)(64756008)(36756003)(66946007)(5660300002)(8936002)(110136005)(66476007)(91956017)(66446008)(66556008)(76116006)(6486002)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5bXhoCSA+irfC7D6wlI2yT7xcoMVz3owjisqjdMdyBej1IhliAi3k2TR+2?=
 =?iso-8859-1?Q?FbQWB/FurJ5uepnMx+Ql+tOXBetadvBX/alA5PolXyGMGNPRWtk64p02+R?=
 =?iso-8859-1?Q?8wi+v6lqYGRSh50Qw4tBRSDpjORd7H7WN44yrEC8F01qUe4yvnMT9/W7Nc?=
 =?iso-8859-1?Q?Wg2txKIkxGjsk468uALXNG9wtPQIaQJY1MH4u16tZ45nXNqprdDMi44Rx4?=
 =?iso-8859-1?Q?vNXNCRab7tS1ImeavPx8GN+609NudGFjQ+RYqA6Dlme9C/TdsR1769JJTl?=
 =?iso-8859-1?Q?+MiTPh0In7QW2o+j80YoVWtaUtWJUYrPSLIcZTnH4W0EHiG7GnEzQrDxJd?=
 =?iso-8859-1?Q?eOWa0Utg8xUpUcgnOJxfdfuz/kYV7Hk7NSY90DcAbBmdRubtYymbFl1hVw?=
 =?iso-8859-1?Q?cA1bspcyOBX3bHvqMywpYnVSQ0QqhpnpHbtDX1oeBjb3yBEEIaAWcorvbX?=
 =?iso-8859-1?Q?kfyixcaaBNRyCwCfWgclBiBmruIqtS36dFqCdmJNccWIU3fR2+S0xXT8Jg?=
 =?iso-8859-1?Q?uIUYKfb2QozwU7BrWwPSMsLdx2KMCFUtcPB9tLjG9Fe2/7e89Zmsn3zyyZ?=
 =?iso-8859-1?Q?pNuSnKtKZcW0iVQ1bKLF8EhLI6PoVUUS4hRP7s2LTx2t3jLBd+wOrZGz3P?=
 =?iso-8859-1?Q?/PSTsxrB7gPZhfG8E5VosgN6HWpvQSTAOCM0U+NweKMp0wvUnvKgFNHQXa?=
 =?iso-8859-1?Q?HNlyJblVwgbLB0DFdcn752uTqcMRGXPGVZbeJrz8lFBPMjDMmT61dvxWdV?=
 =?iso-8859-1?Q?uExNBZR2SjUHPPz0be03xB9EY+lRIrrLZW+vh5sUKlLO/aGsEej1w0br/q?=
 =?iso-8859-1?Q?pBgsYgD1j1J4u6mx5dNwArD8TkiStoxfD6Waw/ceh0wV23+zPji6xRT0za?=
 =?iso-8859-1?Q?aw7sfbqUMHEXgiITeqYW6Pwg/La3MTg3bvZxxhApQlHnXAPV5yIjR8fupI?=
 =?iso-8859-1?Q?ukt2iWjlh+d4XmERX5sYxXzFM31JvuRpIQRexO3fZ/LOFT9bkshCbMGR29?=
 =?iso-8859-1?Q?fM5o91Xlhe7+sjUfzbTB+qETY0w5bHTdHF01RuFSFKoxl1kzMNGJBidU4C?=
 =?iso-8859-1?Q?hgaP+JATa9XGV/RcsT99tX/g63nuSaAb8yCIMPMa7jxdHcdCbifwRnyfe1?=
 =?iso-8859-1?Q?zczMfblPiKkg4ENFwjvaHIoTXrJC7a96nOeNQ5xXP3oPlsKv58wSbfXEwr?=
 =?iso-8859-1?Q?L5cGi0dCWP5zGxpkOeWpTbGDEQ/tJjWQ3A50QQVo4edgUX0je/thWucI6m?=
 =?iso-8859-1?Q?XFAt9XarYDQFaUiWNmvR2fVZeJFV+ch7RkSfbmmZux9HRaaF9CrctwFtBb?=
 =?iso-8859-1?Q?m/0ZkHgVIXbpTmhfWqMtLqrg0p9dHXV0I0sywz/kppxNCO49ZYEs2ypF1W?=
 =?iso-8859-1?Q?3sR5d8u6jDqo4zRnEnKmJocOey4WFvODwNQ1Q4r47S0EVK7oS9HyTA6/qD?=
 =?iso-8859-1?Q?o0xGANFYET2vupdP9HLA/gldGv1NudIFWhAhvGv3WTfHMfcwMEL2QrXSim?=
 =?iso-8859-1?Q?dps6c5/MZbqZy4WeRLSlfWTfTUpqMc4QXxz60vLc17/irIla0g4QFExjHK?=
 =?iso-8859-1?Q?NtbZBJBn0qW4rb898qoG5USfRT9/sSmtyGUxHztZw0f2efO+2LTBSQQy/1?=
 =?iso-8859-1?Q?9J1X+/Juin/r0c1fblAy3ZILkA5FS5qkUrtyilKpVmOo88FVxsELU/Qg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0006fdf0-9983-41e1-26cc-08da69f62b30
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:01.6331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ifrby1QzpbY6x+CWAN33QedIqIpOMulgyGA1WZlz29EiHqsx0iG/3xWzYB8/Ku3K5EvA5Lwm/M9PKMlh7NDkvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6233
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: AZ340EIytn0Pc1XWjVATJ5_-XT0nRgKU
X-Proofpoint-ORIG-GUID: AZ340EIytn0Pc1XWjVATJ5_-XT0nRgKU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Handle overflow checking in count_mm_mlocked_page_nr() differently.

Link: https://lkml.kernel.org/r/20220504011345.662299-42-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-58-Liam.Howlett@orac=
le.com
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
 mm/mlock.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index 716caf851043..c41604ba5197 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -471,6 +471,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 	unsigned long nstart, end, tmp;
 	struct vm_area_struct *vma, *prev;
 	int error;
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	VM_BUG_ON(offset_in_page(start));
 	VM_BUG_ON(len !=3D PAGE_ALIGN(len));
@@ -479,13 +480,14 @@ static int apply_vma_lock_flags(unsigned long start, =
size_t len,
 		return -EINVAL;
 	if (end =3D=3D start)
 		return 0;
-	vma =3D find_vma(current->mm, start);
-	if (!vma || vma->vm_start > start)
+	vma =3D mas_walk(&mas);
+	if (!vma)
 		return -ENOMEM;
=20
-	prev =3D vma->vm_prev;
 	if (start > vma->vm_start)
 		prev =3D vma;
+	else
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		vm_flags_t newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -505,7 +507,7 @@ static int apply_vma_lock_flags(unsigned long start, si=
ze_t len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(prev->vm_mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
@@ -526,24 +528,23 @@ static unsigned long count_mm_mlocked_page_nr(struct =
mm_struct *mm,
 {
 	struct vm_area_struct *vma;
 	unsigned long count =3D 0;
+	unsigned long end;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	if (mm =3D=3D NULL)
 		mm =3D current->mm;
=20
-	vma =3D find_vma(mm, start);
-	if (vma =3D=3D NULL)
-		return 0;
-
-	for (; vma ; vma =3D vma->vm_next) {
-		if (start >=3D vma->vm_end)
-			continue;
-		if (start + len <=3D  vma->vm_start)
-			break;
+	/* Don't overflow past ULONG_MAX */
+	if (unlikely(ULONG_MAX - len < start))
+		end =3D ULONG_MAX;
+	else
+		end =3D start + len;
+	for_each_vma_range(vmi, vma, end) {
 		if (vma->vm_flags & VM_LOCKED) {
 			if (start > vma->vm_start)
 				count -=3D (start - vma->vm_start);
-			if (start + len < vma->vm_end) {
-				count +=3D start + len - vma->vm_start;
+			if (end < vma->vm_end) {
+				count +=3D end - vma->vm_start;
 				break;
 			}
 			count +=3D vma->vm_end - vma->vm_start;
@@ -659,6 +660,7 @@ SYSCALL_DEFINE2(munlock, unsigned long, start, size_t, =
len)
  */
 static int apply_mlockall_flags(int flags)
 {
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma, *prev =3D NULL;
 	vm_flags_t to_add =3D 0;
=20
@@ -679,7 +681,7 @@ static int apply_mlockall_flags(int flags)
 			to_add |=3D VM_LOCKONFAULT;
 	}
=20
-	for (vma =3D current->mm->mmap; vma ; vma =3D prev->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		vm_flags_t newflags;
=20
 		newflags =3D vma->vm_flags & VM_LOCKED_CLEAR_MASK;
@@ -687,6 +689,7 @@ static int apply_mlockall_flags(int flags)
=20
 		/* Ignore errors */
 		mlock_fixup(vma, &prev, vma->vm_start, vma->vm_end, newflags);
+		mas_pause(&mas);
 		cond_resched();
 	}
 out:
--=20
2.35.1
