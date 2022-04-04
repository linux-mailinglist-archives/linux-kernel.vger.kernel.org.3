Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3804F1720
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377858AbiDDOiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377798AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E13F32E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Do9YO012570;
        Mon, 4 Apr 2022 14:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=RujkReZOeGGe4uYbUOQBurwu4L9ZZMMn9jsISgD35FE=;
 b=Py7MgcQr0OuvZ1Azyhi51HfWqAYoYahfZSOf7nLH4lTmQ/2Lb6Z5V0MaH+bmMGZsoUad
 9ywpi7NNwIoScmWVNCe8DGZyrToEiUXahPpoGtAcwj/0dsyLImnHWxa0F8ZgXml3zRTy
 mF1Lgglez+B/MhhzE1YheOQjxGMXt86noOpjY2Hw5R+xQbmcO18JKQgSURnWYCP1/QG8
 YkoofqepLlBwgPGMolo2n4hg4PtY0KAOWEC/vWrB84I7a6kD/UpGC1oSO7wdL3pNfArK
 Xq3QgYY2nDeKTvLuJnm4k0Dn+Nf1Bc2elKUGXOr5569SNDqieL6araFoD2VSgqwIux3r 8A== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbnh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaSZ034390;
        Mon, 4 Apr 2022 14:35:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mh4q-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1S7po5r3wfa4G+4EnjDpsijkjEFbNc8erwmHPIQl+jiVDHBFNcGVQlE6ELPCrrwfsr1HHhBAGqJjevjkpFzcXoPFcJwiV269vXk13BXuu5sFI1cUw+9dWuSXWXzJeD/bzs5+6NgFHO1TaOVxiS4M2c6wVN4gPrCtGSFekJkvgLaUopRVlVR9QbeUWnLUVKuejqToLfaZBapmrBgSKaUlhiqpnUuNcr3z8bKL2qPZEfKtSScmcSuS5Lr5yWBq9l5oxX+UqiW3L38N0hjBILwkBGxnJdgqNeo7HjPGg5eMvCG27onea3UC35T4g33qzMcInYGcSE1tdLpofEBIjrLqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RujkReZOeGGe4uYbUOQBurwu4L9ZZMMn9jsISgD35FE=;
 b=GUG1f1XXFhO69sLxYJPlJ4gRnPezWDEIPwklMfoX3Dv6Ys6YGg8P+hyX2S+KgfdxXLNnnbetjDTiQSxd0wGcGE8puUPxH/xVKmXjza7Bihptumy7WwQp60tY+VtJrD8HJVloMKAym7AlL19qYHosuh2SvNuq597mA7ms0iDdwaETlgr6lQPt3LUonPGOFZ58pjK+XUI1B7qHdAQbP8ziuizrE5EvGzvixIkw05pMy9vE869nnc/0y/uh0PRpHC4ZMdS4wWTCm05XL5347GgZC2/k3h1fWlaHiICUgL2OV7lhvkscB/aZnVxuYu5JnfqmNPsBE8cUzG2E8HueKRWKWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RujkReZOeGGe4uYbUOQBurwu4L9ZZMMn9jsISgD35FE=;
 b=am5Vq1OTOi2ohFGU2rGr205nXiAuOHmWYjlQoyzqoEY/2FqCbbAG+8SIErce6aQc9QPI5HzkFxc/iadnkfJDy34wl9bFXcDA8IKirU0zhjUVvPa5UAJsiGac7RimW8Mw3NbmhyAm1vFHJADZGVeiCLK+pZOIboN3KfNQURCwp00=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 15/70] mm/mmap: Use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v7 15/70] mm/mmap: Use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYSDFAen4st7ER2kWGHOsCiXomtA==
Date:   Mon, 4 Apr 2022 14:35:38 +0000
Message-ID: <20220404143501.2016403-16-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 80c14332-6429-4292-d945-08da1648649f
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812DB8B6E4D6A02298004A0FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Mvze68eSz+bS/CitH6tlwHwZg4xlDCnymITDdBiPFBBWaeZuFRLzv07ynrCqk11zITFJOMaFioSuKFP4+XvZZyoXshjEQ/PY3FTZkAKc9uJ+OyqmyXmPB2NM6/zxkTXWQ3LvRe2dzNt8idqA1VvqASWuZYppBzTwp5Tl3joT0caDPQAQQegJwQ04T1/ru8MXd19xfHHsP4BGLqh5M+HdlUT1C5WxWnrQm9AcRfn1B0OOSh98FQbM6R7NxSLhGSjzbgnJhA3ldyk4FBMY1XujYmVpAJ6VOIuOANGATa3WA7iXdL/E49Zj1V7zE1b2c/lrB+vb8k/RIYGjvJz60ECCNF58MR+h8aQiAOfIVJl9iBHqmW33L0Lt+RMOLV7su471yyd4ms9dsJMOOVdP/SE5cts0ry90l1+u4t6WdUQ39q7qrnq/ZrdRNzgkDq09XbWTgFXQBlqpj3pkxMXi4PCPilhak2y5zEWqtrO4LcAWAg8o4HC0L9NxuZbY6D55qhvmh5t14pqy7HVMV77v+luIylsOVQHAbw+o6BL9rmGmpaybTgORDqDSp8FMsVpqMHJ2NCaVGEjgCw6evVMnk8aItHXzYwZ/aHbPwaM/HcNbdPw5z6KkAxpFCmC8cCWoRaeNUvaBVrDEX9vfo3BuWUMABE1QQ5i0MFnEd3qILchPYsOFAS9O+w2WUHd1J5x3YCq1/CwgkP2cnUolmXptnba5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?k7oj4Rv1WgYAh13kjj6Weg9JPxRygPSNZhzES60bNEdzcSP/91qsge4UPA?=
 =?iso-8859-1?Q?HnAbWKwGoIbZkfW0BKk1budQFrwyjjb+5CfkAp1pbSR0m9Z0zYC3x8aAmk?=
 =?iso-8859-1?Q?JYHsQlcDlsnFVwUix+8AW3iKbmcFh7Biqhq2wbdlsQrlEaIMbbKsXHf2MP?=
 =?iso-8859-1?Q?Sjvkm/nnEPE+/Na0M7LV60G2670k+/mZS7auNGAQrdBRKGZgIUyHcVUfAm?=
 =?iso-8859-1?Q?tkCWcw6t0RbaGglc5cvop3kErZftvX4Gr29BFOwOfv66yksMaqiBksWP8j?=
 =?iso-8859-1?Q?MU4p/twWQlHzVFfT/h3vrJH5OunBNIqesZuL6tM7LRd5zItixr0tgfn8lo?=
 =?iso-8859-1?Q?KZVnrwv5EFAZIorWwcbnD5+aevW3iqYLOtWK1lS4WkDSlk1hKTZ+0r03x4?=
 =?iso-8859-1?Q?h7WU+SuzBsQOtwL0cHfZc3d0tt0uRThIBuuTiGRGg1H2ZT+f5O0GMdkVPK?=
 =?iso-8859-1?Q?qrQcuoFGGZ4DxQ7POQRq7c7SCFePVJ3Ybe7je08k9POqxfju8oJNLsxBll?=
 =?iso-8859-1?Q?sknb5tbjFsxbUWi+wzKwZuCj0l7FQVYDJWSgqdSDeHulHz7s5WFUH3RidF?=
 =?iso-8859-1?Q?0OYrBZExIaHJ7xLZNmNplCr/cbJHZCWf//AOVNnactvtvdrs1YlufKpLrL?=
 =?iso-8859-1?Q?NKSaKwInGkxlupA5n4BdDAuk1sJf9B94FdL/B7T/SIemCFAE/GAB6x8Iov?=
 =?iso-8859-1?Q?f9VbGqRVqoxXgf0JLZyM5rqIMoleu603U6nBqg9OsjyGk+pLHRVoBfO4hx?=
 =?iso-8859-1?Q?Q2Fm0X8MGpsb/65jS9i9fTrIUv68nmQdrdIXH8Z/Mlgj1MB/1z87D2/qRc?=
 =?iso-8859-1?Q?Ci8JjnpkGKpDjzU8AfA6K73ayGPrmANB9jHG+hfx/7xEJjD+KosXOafDiI?=
 =?iso-8859-1?Q?fzDBZV7LLOBdclRObROGI6+ili8GeiVgzu4zX0lcUVrkmh39YWza5aOJlt?=
 =?iso-8859-1?Q?P4VKlyxXEtNugYxRKsaDzBNO91iwS0pmI03are/dp/VVFXarj/U//DPRgB?=
 =?iso-8859-1?Q?qW+P8Zvvk2j+RPQASi8Lcr07eqVOVcVnxRwA71Q58QV6k0jhpFrBgcqAIx?=
 =?iso-8859-1?Q?J1Wwl0QMZOjlj1IBF2AHGrHvNxoKfHMOA6VHi5LGlQqs4ZPdH20SQ8/U0+?=
 =?iso-8859-1?Q?AR7QAzwjvRBm12WNXp2uie98p0/9H2cGe/3UfUH7BklYAVIr1f6goC/usN?=
 =?iso-8859-1?Q?0/mnF2vZijmS/CaTl37Zu28BZgMedibl57PPRXxoizcw+WW+6i6Bx652LM?=
 =?iso-8859-1?Q?MalzTnQ7sjhxPmRMUDREg3wTOdD1vh4hP+p9734qkCf+PcPkizHO5arM0b?=
 =?iso-8859-1?Q?LsJlDUhi788rnRcChp/zx4IrRjlENJ+XMRQoR+5uZ6a+ewD0KKs6CCks7w?=
 =?iso-8859-1?Q?eaxHh0ummbW0wR5EiH0x/cgqmAGbfvijSxeLFkKwucjtB+rkOYIxD6hjBQ?=
 =?iso-8859-1?Q?ynehgp9nysb3x69hAHLiMFbHl6FND9L8DaJ3p/RSRykDyR98QwVndLTv/4?=
 =?iso-8859-1?Q?fdt2njY3bIGljXM8CoOz5u8FuVmVXNR/iOqKsrsyAZnEa/UoBipt6FtApj?=
 =?iso-8859-1?Q?n6I91UGHDGBg+NekwZ1Qda0ZvR4yLJFoBKAfzARMOBHTpntaQqppBkNZrz?=
 =?iso-8859-1?Q?kUe667fbeMCgnKiarnAR53HZ6RAuAUdnZIyU9MGB1vSFV1vPbUCwxvCLLZ?=
 =?iso-8859-1?Q?FL+pADGi3Wzv163yjD2yIvdbn2rsnN7rwbntWC+8WgWwKz+y+7CuZc+PoB?=
 =?iso-8859-1?Q?vV/KlkDhLn50GOHRcrQZUbZpwOwskVlRmjj4JCiN3pl6zPzMqG4U8H/quc?=
 =?iso-8859-1?Q?Oi1H0b2WW0Gr2+9T9UWpaicI57E8hHA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c14332-6429-4292-d945-08da1648649f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:38.7532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: swuFh7WsswsCILRa4gWJOyTGOa1INMNN5VXJCO4n5Z+ryswfc0zOi4hpdzwVPkyMvYmrGAeC+HPLtlrczVldvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: HdjgAB8AkwQdXDYErCqI9Hu05nDt_7OE
X-Proofpoint-GUID: HdjgAB8AkwQdXDYErCqI9Hu05nDt_7OE
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

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 253 +++++++-----------------------------------------------
 1 file changed, 32 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1b6d7667b45d..8e236030c0b5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2000,250 +2000,61 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
-		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
-
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
=20
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/* unmapped_area_topdown() Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from * @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	gap =3D mas.last + 1 - info->length;
-	gap -=3D (gap - info->align_offset) & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
=20
-			while (dv) {
-				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.34.1
