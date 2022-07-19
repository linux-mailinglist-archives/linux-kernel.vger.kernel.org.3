Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7482F57A49E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbiGSRJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiGSRJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:09:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E51DA46
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 10:09:13 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGgXWk017922;
        Tue, 19 Jul 2022 17:09:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=hbeTTVcNkj9pgUeT4saDe5MhvsNLuaYSmEus/DTpIXM=;
 b=C8TUtbOLCELF+/Fnm+teq+1OUvp8T0fZget2odlgbqK5PsUmzq392aWT963BI+Ay3wxq
 hAD2WqPfdNTaeLi92Gpqiyyhs2/iZpsKI6Qa7NUsovxQthkCPoywFXIRvnu/Jc4004Ag
 wt+pKCF5X9Q//2z9y3hYOV9tG4sAiNkMV5hqdb8ZNfjr9GKZ6A9DDB7Kgbgg/OJc1NM0
 puw3VA8yX0etnmlUk8rQTJutE1iok6EKiajKBgpBjj8i7GTF3Imn+SF2ZQ/cVkciGsBy
 Wp7LGUtUdxdQBZ3QVtCgFD0HzBgOUtMJHBASWlH4yIdJ5dISuzaav1YrN6MFaety7g9B wA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0y8bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:09:04 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JGK9FV009891;
        Tue, 19 Jul 2022 17:09:03 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ggpjen-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 17:09:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsguebEke6NLxNuL+rF25NT44p0yoGV6D5JzNNtOAcuJdDHriCIQSX8V1EA4UkxDmSW30527WOKrPRV3Q36whmOLRiexS+7YH6D4erwgi4d8ms4ccJseeOt1MtU3r3GSQ+wt5kQ5r3aCmCyYGI0upsRneuchi+0iTdMawdNxEf4moBNqDYsCEm/INjxOIZ8gwDcYgg8Fple/RA1V2K62GfFdbTU2bcExaTRHdonpGh+ysjfVmB8V3L7irUhpv/Sszr+PiuB01B1GcPUGWB0v8xY32d6IFCBQqXWM9wmBbM0n12FbyeROrpu1qA4Pm8lK3r9fxstDmeGTxKY+kMK4bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hbeTTVcNkj9pgUeT4saDe5MhvsNLuaYSmEus/DTpIXM=;
 b=EiE8HqC/SubjVYJ96Fw5vijUz7cCbyUt5sMM+bh3cdthgpCbj0tbaAQQk1ADnkTpRJNp3q0+Urg4XGomHmXrXQ2QPIKH+70DhQHcZKdYtZkcXRwDB50IwUSwTShiA6COqUSHsiycaT1elWA+MXI5CBTXzCc4y1/r+UbT7Jr6mC1sB2akLWqP0uJGq0nxKS6pcy+uQy4yCFk0MGjJcqyM2U35V3zxjUntIiXI/ijwMy40OKEi9GjmsIIkavFMCC+ql55pZiorWpylmOmggCam5XQo3HZggGR+T4TgaT05JK2502eKOPOrVUyqfKKi6mFRuV+d20w1n4MLybBf8ZUwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hbeTTVcNkj9pgUeT4saDe5MhvsNLuaYSmEus/DTpIXM=;
 b=pkcC3x3s3vCyNbO+7GYAEpvijk8RpCMksxKBNaYwyUXzMESrXCUfJsbxd9Kj8fxkGzw3tIWpk3Rxe86TQYqlJQDuffBcZLXJZZonTKm7JSTptDPWtECvcu0E8Ez1IqpVTglsGSB3WnrzQ9sBUflqEqk7tgdatpkpNtzmFS4HoOM=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BYAPR10MB4101.namprd10.prod.outlook.com (2603:10b6:a03:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Tue, 19 Jul
 2022 17:09:00 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 17:09:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH] mm/mmap: Drop VM_BUG_ON() until better tested
Thread-Topic: [PATCH] mm/mmap: Drop VM_BUG_ON() until better tested
Thread-Index: AQHYm5I9qMwYSQQG7USVEU3IejWBbg==
Date:   Tue, 19 Jul 2022 17:09:00 +0000
Message-ID: <20220719170841.3298839-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 448ea9e3-cff8-46e4-98b4-08da69a95fe9
x-ms-traffictypediagnostic: BYAPR10MB4101:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yRg1E6GyT9XE5neTMaeNHbA+QnS+OkZEhFyKIMuiYc8hlvOTELlyZzznB0b4wevsyoBqpuOA7C2ap7+PKs+rXBVaRI8AOeg9WWytdJbCBNlxlJXwjl4UcGuSIRz9jTB6SkE+uSlTWBZRB1QwUt2ffwz37elnCjCQUg9OKNrPP9lBq3ufN4L5nahrATHdEzBY8StCgw2WvnvdEe8YM5z8/flwhzad6k9ZxDBCSSvmy00aljsy8ewFRAC56H5s8Iq6/dW21xuSSzzGsYQG++Vixizvr0W0dhN2VwCnh4NFHefIo54XbgnuNngQW9zqqjYMySAkXZsdh7znMB8Qm402WdpBdx4UGMNAcIrRFIlU4R4lPx/LGIxnXewIK3tJNmr40BWvqOlCl4xdCY93HHeC0p7rJbEb+w747HfkalBhKgAfzYpPHtm6hs8Zwy4Wv8sQ9/WA0ZmVLxa9t1+dP6v4A071iEZTD+dKCRH3ASnf6HyQDl5MzplB5izxmmY+bs/0bVaTXOFypQMcpMxZ/DLLrnRFBR26OdKNuQM3rOJRnHXcaB65/HWNhnY0oBCJ10f31SzudHpvsy68k6rFU2Q4T9BUFK/7ZbtVwfa0ERAypIFVR1yQDC3GXxC64wuRm2cB7Sy8uPk36d6qYitfL9G9JuRH1qZ3CR4GTR5vE1rRe4T9B0ClBf608xkNK9/vbP6ETbm7s5M3xQ8q/HWQ7OmZBqqlKLLiZDn/+azBL4pugN8+2wWR59oRKKr0qSX/ooom8KTepmZcftHuJ55t2SrrlXkNMGdIAGSSwIr/gyj1gQCxNTVcHUOaE/ReBz1UdRkm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(396003)(346002)(136003)(8936002)(86362001)(66476007)(76116006)(66946007)(8676002)(66446008)(66556008)(64756008)(38100700002)(91956017)(110136005)(38070700005)(36756003)(6506007)(122000001)(316002)(44832011)(41300700001)(26005)(1076003)(186003)(2616005)(83380400001)(4744005)(478600001)(5660300002)(6512007)(71200400001)(2906002)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?stDNqItXRRUJc4tz5Xdb5eHgWfsFt+GlOZCC8E096SKK63sXwVYPVCMpJ6?=
 =?iso-8859-1?Q?gJWvlRQpgWZRMZom+1Jj+H6DMEWB9VlfYJDFcvq4wYUiakpDjveQb83ob2?=
 =?iso-8859-1?Q?4YaQdE50XEnP4hJ4JPsifD+8RIfZcMxwYvADqrnQNwjNEVAPXzKVQC8bYX?=
 =?iso-8859-1?Q?Fn3WqjxdyA5TcTXObe/FUdGZQ2ZyJvvH82sH+eH8MREIMEUpaeoKyHwcS4?=
 =?iso-8859-1?Q?84OLkHmrxZVjUvDZidtXZihOfuJKhcd4OuhtIIr7cX1XW4Szn8PIQ+3Wv4?=
 =?iso-8859-1?Q?ACs9xBZVPHO/TeixSk1Z2gss8LyuLu9pzvIcxHc0v3fgZOsFVIFlunJuLS?=
 =?iso-8859-1?Q?rIRWQ0839UHQ6iHsGZQkq7oGxUfkljYhRLVSMxXxk2cIKNiV+E1WdIlgJx?=
 =?iso-8859-1?Q?Ri9Uab+liAKVc5LHyoXd3RDf/ObMytHceXV0511nYbgt+eNoSRdoqJxmiH?=
 =?iso-8859-1?Q?LFK7jTWlcjOS315SLqcNYABX05GSF+0tqD2qFXCVt+sSo2yFSaK1jynd5l?=
 =?iso-8859-1?Q?OWsc8xnF2zs1whglVfHv1r5958LZfY2xVaSqbIsTRnQ6T50EPGAb1TYWOP?=
 =?iso-8859-1?Q?+r96DN8JpwHG+BhYuOj/+Fx/Zqiuwzi00j7lyjQO1fkj6NFcjF+X9nQKn1?=
 =?iso-8859-1?Q?eU26aqgO2jINrZDzZulCNuhJxYdKjxzwqKAu38Lv2Yxc839b1cOZmvVpEX?=
 =?iso-8859-1?Q?2J2iqyy2VX1q/kZwxbRN5n5PhdbT8ulH98QkmU++FIpyS4LoazdPsSbI4e?=
 =?iso-8859-1?Q?3SRIf1174pZhJ4Z3S6As9LB0hnPXAwuY+2jEWc0EGY2SM4p0TjfBx8kHYB?=
 =?iso-8859-1?Q?SkyN1WM36Z9cZoDo8kRtLbgSSIYn1iRx/qEjOTZl7uFymS2y/bLPKisYb4?=
 =?iso-8859-1?Q?gM1UHLksYyqk9KHElFhgq6jV7zdAYUv/pHuPrdLflOGBKMnhNHPWUXKWUF?=
 =?iso-8859-1?Q?h4awnXr3N3U+1fH00Vd2plDSy8qGv3MMM4NXqj+M7xWsU2vocyKetAk4qU?=
 =?iso-8859-1?Q?b7wBEblCfyAXZ38U2QR8CYK0toJRzkI/EhMKc6r7G+liHlADUtHzbXZ/xK?=
 =?iso-8859-1?Q?JqvskvE//b/5NFIYshFUIymv5IrVt9IJA7UVv6NaPWvSVKViTgqLsDiWZ7?=
 =?iso-8859-1?Q?MGPaHKYddN3vZMytMKygqSK/MW/Zt74Dkuo3ZiIyd5dD3rmaZSvopebTdi?=
 =?iso-8859-1?Q?34/aOBV8/eiQxEv0dhByEbtls/TpoWaXrNoExM7JmW/BI/GbfR0RsmHStx?=
 =?iso-8859-1?Q?Tu56c0Tis93dyT4Qa3G2PPqXlA2fwgq1+ucDpaZyoBAnS//Nlv0D2FyVNk?=
 =?iso-8859-1?Q?CZjWb61MMnQPCyM3muMElkQbyYJosX8C+zEskM6q04eHBW4h8N7xv3wodC?=
 =?iso-8859-1?Q?Czt10lhcaa0ElZBFHjjDeAA3BzbEEmsRSpmuYOCrmG3aBlWH+5hc5/PVMa?=
 =?iso-8859-1?Q?IDIcNSel3smtRKw55cRppDoeBqO6T6Lr2XglQbetAE+m75AYmw8135C9oV?=
 =?iso-8859-1?Q?WPqgtgPnff9aAXnhbBn1F47Yp7MQgv+Hy20Vn+Bp09rj88AxYpmOmpSNMZ?=
 =?iso-8859-1?Q?lBNqhp2JjiOBxVQ2eN7ZTOQJaLccHfvTUIBYPAO2sGFv9O6JVVRv7u9v/F?=
 =?iso-8859-1?Q?cD/8Ohqvoqqv+ijcBExeqQUwx1QTSVAppGRYCnrjTOtkWnGrOze3Tsfw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 448ea9e3-cff8-46e4-98b4-08da69a95fe9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 17:09:00.5724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZGK3UtmXghadTdBbs7bioxzpAdn5Y5Q6OyjYG4PDEdVcnhYkJyJBsrYtLlEgg3owthSsWdgy5Cn0H8GgdHd2Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4101
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_05,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190072
X-Proofpoint-GUID: goa4F_o-gsOn6nfHrMfWutoQIVFi7v2H
X-Proofpoint-ORIG-GUID: goa4F_o-gsOn6nfHrMfWutoQIVFi7v2H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The limits that the maple tree return are trimmed so there is enough space.

Fixes: Fixes: 06fade172129 (mm/mmap: use maple tree for unmapped_area{_topd=
own})
Reported-by: Yu Zhao <yuzhao@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8c09d1a44081..b0edf7b70872 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1627,8 +1627,6 @@ static unsigned long unmapped_area(struct vm_unmapped=
_area_info *info)
=20
 	gap =3D mas.index;
 	gap +=3D (info->align_offset - gap) & info->align_mask;
-	VM_BUG_ON(gap + info->length > info->high_limit);
-	VM_BUG_ON(gap + info->length > mas.last);
 	return gap;
 }
=20
@@ -1658,8 +1656,6 @@ static unsigned long unmapped_area_topdown(struct vm_=
unmapped_area_info *info)
=20
 	gap =3D mas.last + 1 - info->length;
 	gap -=3D (gap - info->align_offset) & info->align_mask;
-	VM_BUG_ON(gap < info->low_limit);
-	VM_BUG_ON(gap < mas.index);
 	return gap;
 }
=20
--=20
2.35.1
