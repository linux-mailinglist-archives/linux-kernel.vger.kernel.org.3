Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3825AF4F5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiIFTxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiIFTuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AD9804AC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:00 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYVR029915;
        Tue, 6 Sep 2022 19:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GJ+7dVHdLllKMNXTH8C4IlcGRwqY5aNlvrMEbXEver4=;
 b=ObTpfPtUt66X8crW7FdP2tWi6I58zZd4UIPkOufVBji7fH8GK0xHhk9bwHgs8tc/P9iC
 LWCV+oL6qX08wtOcU3XPvGeHNIfD8CmLUY0OgePchwizjxG2ZSb+9oMr7cvOyirPK/dw
 8/wiaNxzIUw8VNAj74rwSGiFyIWqZmSSvtx98wD23IMf9TaL9lT5dUdmwN6vtTDnTiWb
 9HPgmSWYdRB/WlhkR30S0GEt7yxyGIq1H6DL0eftLxLHif/5xjABtJOh/o7YqMa3nvio
 IDRGGliumFgQSfHT+Zp5xxMj6I9i4fAI+6Ehk87OycfMx/V1Of5E1kDlQOwKLR69PNVO OA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvd3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WT039711;
        Tue, 6 Sep 2022 19:49:42 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8ceZam8PMr5ccs2q7NjztM8X8d1Bn5PATGm1ajOgvLukFV4U/WQfbw3SMpvOKdVlCojqGuBEcPrst43K/MAuIkZI3ACZOmvGG39gCCZfa9pe0Q8LG8dLsC1mlZwQkxGsFULYV6ggwmNMpl53WWaQn1gHTGtIFWvkqjojPxdNm5rEmcLBO9aAgz4vsAj8LJWw6aIX7D+ibbUemfA0cp2a81OMo8PRnGPNQla9hW1uBg0EBlf7P/XNW+2JF+hmYcfvdRHkQmZSs93oJe+bWuoZkPGE0rG5fTV/pdxf0nP84Lq3w5+O6cMG+sN/CuCiEUBjjJSUjslIPY3NGNWqxsj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJ+7dVHdLllKMNXTH8C4IlcGRwqY5aNlvrMEbXEver4=;
 b=cr6rdfsDM4Ec256jYQ+vM7ZnM0S3mRk8VocN1rVLCd37nv0Yjz9sudE/wH8MG+F8PZm3thJCMd5rH56oXlBrgmmbklqs5VcXPhBjdCl9tyla1p4L7vlBKK7/fe1T3yqSa03RiBRCVZGnwMrezkOfDIh7q60DqLFPEEo5qJ7RUBg/ONTIExYte/Z6n6LcIpWHBemStRnQZfHrrqfnzqJDV6MYf5S+SPX7ANj2Cv+vIOPA5eiWU8c7zDX3X5oayRFCex9OnWv2isihriUkw2LfvV1sFi2FIE2i83eUClFd0449yBup8HJVSF6jDHA+wHyOVicQ1am9O5v++9XI/5lI3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJ+7dVHdLllKMNXTH8C4IlcGRwqY5aNlvrMEbXEver4=;
 b=HOJ2NkfYHZaosyPB6ArgIv7GxPXS4qWYZgT9yd/ia3sxy+4ZrKofqxltKsKC3CNRfQ852/4kfgFyo+KT2lesGIZ+Vfa9plzYOmcGdY/fKIfPDNcu6GDlKrt0HTBYNN43cq0GobLokyc28oZubNcuEEvuXh01USwXEG/04TQ/U9U=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 39/70] um: remove vma linked list walk
Thread-Topic: [PATCH v14 39/70] um: remove vma linked list walk
Thread-Index: AQHYwimzdULrjjO7wUaT0xKVMKskAA==
Date:   Tue, 6 Sep 2022 19:48:56 +0000
Message-ID: <20220906194824.2110408-40-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af2b36f8-81cf-412b-1c8a-08da9040ef46
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y4WMskcYBciY1JZuSDldNxFr6QHygbEFWTM59AEA+afWBxSzzEXflbRbZoCq612aFJaIoD2YSC/dqCiTv2RGHamI36HT7KnElyXSiv3r3U9J7zpe8NONY90IrVbp3JdkOQpr41oOIP52WQ3RZQulJXs/MXX7CqHbmxMh7R9RbM954yCEhdu8Ak37OggT52hqnjRT9KrwOHocnNsfSUx8G6voOeguNHyesrSjSIcZJ6PtxraUeAD+/csQ8aQjD088krmYum6sdPz8myoTT321CgltcXIA1YyxLA2akqd7LwORuJVpqRdRTp7YNdc8TF0RT9ZNS/as8j+mJfURmMdQ0DoZdfV3UuUnSZ48XUx+sLsl+Oe+iShcKmXyJNWNfvayax6suD/yVIMMYmLWLIGTM+0WG/BruLcNwJbJk9SmN5GCk/i3Y/P7Do7w+hL2E9vxihE9e0CV7KdKs+iTsR55ikiysD1sh90/RmPmbuv+CFfeEq6eRYuFkaOCKTSTv9RG8GHQxMh4K9j0j/tFKlOXLBK6IEB0DE4/OYf21XxQ4gG7hoLpXZmAf2jkevp1vQpF8FotVObkxC0nYAq7OhdAVhWX3A61CaqjcvSPi/VrpOBuJIhwDAhX/w4MqHiEeOALlbWh/dROtm5qDB6e6254UMhOVGt3rY5LxNUdJtQRt47WivlGXHCj1QYpQvqxjb9KUHjKlRaWz5CFQ6HwVTyfDLv9gEWroc8idU5s24z3exPwatvFrYn8JI7HDQj12d47N0DN2/t3kCZPlZu7eKYXVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?CDXm9qQfkqqeVl3ZW7sUOjylGX93t2roRWpDm204YJLjwnHUA5r1+roOi2?=
 =?iso-8859-1?Q?XyxuGYnsUYC8JeE/BGrCjp9X7O+QxJpoiu6iAr4NJNAc6bbtGkY4W0Ocle?=
 =?iso-8859-1?Q?WrWMZ2mlPOnq4JAJXQU5phXXP6DZN5hsH5WCrFXLaL7d1s0Kr2n5mnArOE?=
 =?iso-8859-1?Q?h70HtAwvzNZyy9nrVF2VjrRx/cpkLWDghZgBENu3sdibC2Uxv+1ww4Wmmk?=
 =?iso-8859-1?Q?vjUGJCf7jh3+3//m5LoWXsEhKXhDb+CYhxRY6friIV+dP4ayJW0nsLbA5h?=
 =?iso-8859-1?Q?PkeWNf5a7XQq2aH/iZQjxQqJ8RBbmnbB/mH53TjjUbAdg3yqrkth9br/sj?=
 =?iso-8859-1?Q?RNbKw2pNsxqvnwxJvSd2JHoyuvj03xyWcFlTArQ9su/DB0j+rPjy4WDyCO?=
 =?iso-8859-1?Q?7PLWft0qtsWn1lHWuTuAHfPQfqqOA2/Z4ZZgm9oGGLRMK/0Ukw0T8DQuOL?=
 =?iso-8859-1?Q?unD54qacpIedDc24Nh/ANqhg4V0q+Zam+Hkxd2oFZfJ7qNMYKC+yAD5SyB?=
 =?iso-8859-1?Q?0YfZ8Cxr/u4USSFINsWN1OXTQMXCe1H/CXIW68kQzmwKHuJg8bUo43sJJ4?=
 =?iso-8859-1?Q?ymdUdEVDG9UbmSMzs7PM8yQwdwmGS/ISzHEWuNn5VaYUFjVpqo0kG8O9Xo?=
 =?iso-8859-1?Q?qKmO1dSQUKyrQYotwguVMOj35Cq7TEZCBsIzw0lSVKO8m4pdU6cn5ge1WM?=
 =?iso-8859-1?Q?OZwUXWk89RgByYDF2UbK7qUSDA8P8M47eFf+F/tbv9UCAsvuPs8mIJZxkS?=
 =?iso-8859-1?Q?5LsAEXBd7I62Tsl72Lkz2O+Uzpwskv4cfgQkfvPG/IMeqUnh+X0j8ju1ge?=
 =?iso-8859-1?Q?6gMiCRfb/+RRjPIqEMZXwbek/HSh0gwc3erF0VsMgLt7yGKmhMPSviuNP3?=
 =?iso-8859-1?Q?6iwkJk9plkxocWfSfIsrQowxZil5CwkD0+USYrIBEPX0dyJe0HmnKr5L8L?=
 =?iso-8859-1?Q?1ziw8CCnxHzJzFrGAgHzgryZpRhqaZfcyNF02GYFxnKPxX/2s49tqNP0tN?=
 =?iso-8859-1?Q?9RsK9Enp9EPiYfFL+dkT7OEfSxyu38JN1tNhMgfB4Gs5mQeVvGGcdqqsdu?=
 =?iso-8859-1?Q?bEre64yQmcfI036aJSfmxDzSrYsbRxVE81276+Dm6moz4ULB0J2j1C3uqX?=
 =?iso-8859-1?Q?EVERVzXuJmPbtCiYW0TV+o1UVD5NP+d9wwfOQmLjsAXDeq39cMcJWOD1Ww?=
 =?iso-8859-1?Q?ifVp+sDr8unWPgq+zkAe9mPRdF6YOaCXmqGuJZ9yBrfiycJbLv7z5X28r7?=
 =?iso-8859-1?Q?1Xxsg5vD8MVLVhla+RhT/oHBVdcW5F0N5Q5PeE+yYZltrFKN3b3bEGirUq?=
 =?iso-8859-1?Q?qip0QNGhZugn373Tnk1kAqcxUSBALgqJE8V/pkfEw9znuQbj4Rsd+6pza4?=
 =?iso-8859-1?Q?YTineU2jTyaO1HPiShXBtrgX9gN00S858zHaFW0aIdfVJgQfEzhIHf11J4?=
 =?iso-8859-1?Q?R9w4mDA8zIopnB5cSs9jC1sxXIrs1Jkfv3qN321d1v0Qq+47k/HUPAHKlf?=
 =?iso-8859-1?Q?o7p6D/xp1Up8pIlw+4NiG/DrXhAvtYE1r1kw4p4YbAv/6Zz5wk5qxuEIr4?=
 =?iso-8859-1?Q?71WO3BxOFX3oBXUFlxD+8IbQ2rjRftN9kHlZqPuALzqx7e1NftUiVlhgKJ?=
 =?iso-8859-1?Q?luyy4CyyVH70ckLD3A6KQxzOxqcKPcf62f8ctLFFSxkgji34UaA6az4A?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af2b36f8-81cf-412b-1c8a-08da9040ef46
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:56.1156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHlZeGzUkLdCif4qdWKDBV1X0DO7HYwXs8yAgRyRcT3hjwZBbyBb1DtatiTjwXkEjEn68s0V2dUSKSmztb93kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: lf6zPRcBhB6ch09qKKo7GMOGApqB_AZD
X-Proofpoint-GUID: lf6zPRcBhB6ch09qKKo7GMOGApqB_AZD
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

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
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
