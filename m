Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18151015F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352110AbiDZPKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352094AbiDZPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9993815A419
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:21 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDStXp032115;
        Tue, 26 Apr 2022 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Tduwvyfq/dvSfzA4XTpBo9xMupTavFx8l5v3mBwm76Y=;
 b=JmHG1kDiX/aCODeCw265d9MmUvBvzNedq0qiVYaGNx0eCQNOs8dHsrsf+s0czOg/gKnX
 pYq+6UhXGNw//jb2kXyeg9R2jHDPZ1WNrtfz7AeBfWD4jaAaWLYEdsKZO2MvudQAU9W6
 24vAe+ApnNow3/yxAZWFGKEBj/WK98k+Xw/ox+VdXhF3Jy4mVm8U+cAC3Bb+UaD7ryK8
 ANs1h9oYsJhPXD+NipI+jfjt+TBOtgog5mSj5IBe3qPEkUvug0PZc1Ya/F5/Qtup13NG
 kHxJ47bYQ72IjqZONyJev7Ah4Oor1zlo9I66O7eTj3JixnrcL5NAGXdnxkxasj23Lzjq eA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx4yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:42 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Urv037859;
        Tue, 26 Apr 2022 15:06:36 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drRS7fObmHFfSMR92Sd573PUmbYyJXbt31+CbOJNrIJT20T0R+O5czGhfr8Js0uhKzi1+9+pMOqUAeiS86/xw2ehZdC7wmEi0imc+gIcZWPwWYwBKVTCpvsdmQogZLP5HpUtSPu+wTDczYqdvNL6SSu68cUQkiOePCKwwmtwjLRmVt0//N7ckkRE/DgULwQ17/khVFbmi9aQsJ/GeBHu6RiZKW7CyXdcMLqDzfYG8UGVYniOl1G9BoTUhIPi7fYbst6wLyIe9PwT7CS7Fxmd/n32CZFwfpCA09Gh44ETAvIqo9sfC1GHRXJNrzbJedkaaPnMZ+z9qlxfpcIa+d6LcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tduwvyfq/dvSfzA4XTpBo9xMupTavFx8l5v3mBwm76Y=;
 b=WOVfFd1NOJpCTbgIP0cBlW30jl2xKPaXoATTXKEuZzmHNS7J3969GVdux9RGh0BqLrE+HFZ0wFS0NXs0KsH4U/28eQTeHsCUDJb366rlm+nHXCGaJW9mVdHq0k2Mdjnx4qnDy311SPEQAVDdSxQMpz3sEiibLZIwqYaTbqEmO+Laq0T+nQzLiXVPjucwrAbvwNyq/if1LmVRUzL2b29swmx9f8q4s8JgFvz9Q+T/MOAZCdebxMHgg8S7SMgYD+XPjFaSm26vyxuEefLDs71d7JNJRANi1+DPu4RIETTVxHbTtAvjnxvESAw8zW7Rm7EhGulPspuJutp+MldptrM0bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tduwvyfq/dvSfzA4XTpBo9xMupTavFx8l5v3mBwm76Y=;
 b=UVXXtErNN7sHNCwSz8E0FYv3eKvsIX0rWHIoTWJt5ER1BYP6SQ2PaTneUbZYI5C71GIGb0R+a511ro6tlhdeFv6UqEuVwFpTcxBeqJegnTRq7lhxqt+UXuos/i3WOIvdqL1mYhXuXqtYCfJ2YYCvny81jF3+Uvoar/yuCa3GC0E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 16/70] damon: Convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v8 16/70] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYWX82z7jXBMR74E2ousynRE0nHw==
Date:   Tue, 26 Apr 2022 15:06:32 +0000
Message-ID: <20220426150616.3937571-17-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03d62b91-1675-451a-d461-08da27965a02
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB46798B94262F35EABBF41F9BFDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GN1ZHZZqAlVgz2lbEpHI3ogylctEE+d7iCIe3r1kPI1EjGeR8zHn5CYgdBT52aUpXvHB1v9QVbuVoVxiBmNof02otPRkReMQLjD1rDfiQoPNbkVw4zVubfxaiRGc9GrVOXPbwgCwvhnfGK8SPBPXJlikv006JpmM6d9SKWJXwp/xxWwr9eYl1W9VU3blqZIdGhgxAuCNn1Y4tSXfAlUGObhHgAvl3MZ8LL4TNjPsxz6RDnT+BQ6LsY2lw6Tu+VvbX49//SxnRusD69zfFOa/c6Xy4NvHZk+7H+ccid/CwklXQFnr8ncZ3aCjg+gTTpMgl6P2ZhgOw7Au2LrOsIS2uuAiz0MNmzBu4MoQZCylY81jTuICamzfzK4T/N9xwHYwwbGymHDXC47iTj9oeQ8Z3U2nNtILvy9DBK00N2o7rV1iVetE3F1Jjj8E359bpsyFl11i01QMGlbZ/UmVq6TVhMxSk1YJUbNMeRIgdKReNMwyJCkS9I7zML7RJCXCqglEeXJ5r/c9E81q920uxL/n7FGk9lh7rFNmmy7T8937oTALdqdK4boJH2JoBeZtEjebMp4FvAaMS2ozZLWAVLGFw2t7rTTekXxX1334jjt6reREgG4tSm/FxKk2fqJ6GbU0qH0Obt8ryHA+lBkAJMPnGEXVS+OcfX3ZK5z+iDewO8jRkXPjtbflg2f1+7uLY+YEnh0tExuM6q8ynR2eKeaYyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1aFn9++ETMqIx8SMCoCfaFdUmE30GGEiJgV8MKpqnpwBvDWL1bOb+51WY4?=
 =?iso-8859-1?Q?EwjlrHZYEG5Kgr2FZxq9cmOni3efApJ3DDKsbVSsOr8xu3v7vV0HzcaUAm?=
 =?iso-8859-1?Q?pmFwgLRA6SMG6QYzUTK4GVTyNTtbgG0fxEYWTrKH5Bnj2hDt46/QGnaNwu?=
 =?iso-8859-1?Q?EPfyHgGEt8hwCzQqe6MhnlcRWVP96YuFI3dXtgz+OhvVNgg7u6qdKObEwz?=
 =?iso-8859-1?Q?rCQWlj4flpzQSRT06rmPEHJCqKIliUVvH3QXCSiyf5u83t85UsXjaHU2Yh?=
 =?iso-8859-1?Q?YIh654XwFYOWi8/m+Tn9PpiBU64ZDi2mcagoLm7EjFpvz7PLI1D71jPSbD?=
 =?iso-8859-1?Q?F3RCLLS56ltgG9BrA2Rq4HvnYeKMTr4wM+pxrk9e3wF7S6SatnoxkXYAIU?=
 =?iso-8859-1?Q?StrLiW49JYPMWbb0iCDOIpKHUH6KMwaNBCGc2Lm4UF2efQ6lFV+LJEP7c1?=
 =?iso-8859-1?Q?fhIBNP5RBhtwycv+t8bgXYuMUQUx2GQFx8sPXtODjfF2iIa61SID5bhjRi?=
 =?iso-8859-1?Q?fL7rFh8/DquWdiFMdEQ8lzxbNOExjhLuXrbizEvLsCpTriTcscVWYqwKld?=
 =?iso-8859-1?Q?PwqL7leCehtAoWGJjQZ2swEBii/geKGKMI3wWOW736+8VnYVhg//jbl+OS?=
 =?iso-8859-1?Q?D7ymRVJDUVEtMoa2fc8aQz5Bcv6SI5uJk7pzlWXe/QGz/kN0gAZJ6qDED6?=
 =?iso-8859-1?Q?Cyc7X14XvL8+jfbFRATVFB1BkCAMvR+FsRUg/PCpr7DXwqqRSme+6tVeaS?=
 =?iso-8859-1?Q?e99a5eOCqvzmHr1P6GO9pfLEKpIqVhYNOh+DjkcrYLm8xGUXMdzLNFY0xq?=
 =?iso-8859-1?Q?Bm7cZKFVdg19NL12fjCTqysP0OH0QRsCcLam93g+XNQ6JnSxHaNB+t9zZN?=
 =?iso-8859-1?Q?aGm3FR6JOJvSRVaGsIXfaKZ+paC0clT4Hf51UO+SznFhcR3GxOtJT1G4Qr?=
 =?iso-8859-1?Q?l1gohCmch8J4G3DXvvYi1UyiSVsU6A3syDNpheC/0fS21OzZeBfQWv6rU8?=
 =?iso-8859-1?Q?bP//xKPk2wTJabQMEOFJC5eGTggIweV1/G1yqEi8CCBzyAE8hQOE0tqiAb?=
 =?iso-8859-1?Q?kaoaTI6Djx31rFfenUgxt1mwpDR8iX5PToy17YrgpZg1wGs1JzDcUwimmo?=
 =?iso-8859-1?Q?RO8/T9J7E50agUtUWdKqmvuW8TGqrronq1RNsdQ67Kv81lsCrQGXl1BP16?=
 =?iso-8859-1?Q?7pyz/3/UhPtys1kIEH3K+jW/SR4gcNm62OR9Hx2twRaltNlUYCPiadjgCE?=
 =?iso-8859-1?Q?zmlN8o+e7wakK+W1gfyR+02CUsewy5DI+MEAFylyR1HofG7a7uy4QDpKkT?=
 =?iso-8859-1?Q?D10XxLE8UheHaR6u6HAN76jpPqSeEYzkpkVmBYApezUbFB//ZhK4XKgOR7?=
 =?iso-8859-1?Q?F9xPbN9zPDXXuFbfWYY/QHZpZpe6382OQNETHV4C0uNsybu9gpOijgcrOu?=
 =?iso-8859-1?Q?PU20Nb3vInETJsnQcyNtwMbLuxBkFWtszwyrU/GnibMOknYgj6gwVJLwqS?=
 =?iso-8859-1?Q?2mDMyReDvitbi3+zMf0Eb204wOVppuN+Uc43i13Gh1qGfyopdUMKnMFMuj?=
 =?iso-8859-1?Q?x/FIJ9XUuwkV0DiY4tqz9uJUCsnn0T8KqTXdFq2KMgnKZKNYAShHFHE4q1?=
 =?iso-8859-1?Q?N7YrTAWWBrqxeamu8/60wfgpSnyCkPLpmBXGoOvnpRVdA5pl7BVch9MRq/?=
 =?iso-8859-1?Q?VG8wywyHAtyko1oxwzinVgDiS5nOYJRiofP1QW0NAc9gNuCTLOcxHDQZWv?=
 =?iso-8859-1?Q?+NF+fPBHlJvq8x6lG/dEqsl3Txch2uNaj2eK1Mfj1isjPKcOyQ+q1CC52C?=
 =?iso-8859-1?Q?CFmx5B7N0uOLhRJ5U0tdukAGzVV1CzY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d62b91-1675-451a-d461-08da27965a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:32.4278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zrzHz0XZSqceQQoDG1/U2h+qF1mg0I0eZGlrIXcXnYTijEbzxHalipEuPeQsEGbGD9/+1sC4Dieyip7TIbMITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=856 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: t0UA8O4NcUsNDaDRydCUiE4v0s_A8Cep
X-Proofpoint-GUID: t0UA8O4NcUsNDaDRydCUiE4v0s_A8Cep
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

This rather specialised walk can use the VMA iterator.  If this proves to
be too slow, we can write a custom routine to find the two largest gaps,
but it will be somewhat complicated, so let's see if we need it first.

Update the kunit test case to use the maple tree.  This also fixes an
issue with the kunit testcase not adding the last VMA to the list.

Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/damon/vaddr-test.h | 37 +++++++++++-------------------
 mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 1a55bb6c36c3..d071635483a7 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -13,34 +13,21 @@
 #define _DAMON_VADDR_TEST_H
=20
 #include <kunit/test.h>
+#include "../../mm/internal.h"
=20
-static void __link_vmas(struct vm_area_struct *vmas, ssize_t nr_vmas)
+static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas=
,
+			ssize_t nr_vmas)
 {
-	int i, j;
-	unsigned long largest_gap, gap;
+	int i;
+	MA_STATE(mas, mt, 0, 0);
=20
 	if (!nr_vmas)
 		return;
=20
-	for (i =3D 0; i < nr_vmas - 1; i++) {
-		vmas[i].vm_next =3D &vmas[i + 1];
-
-		vmas[i].vm_rb.rb_left =3D NULL;
-		vmas[i].vm_rb.rb_right =3D &vmas[i + 1].vm_rb;
-
-		largest_gap =3D 0;
-		for (j =3D i; j < nr_vmas; j++) {
-			if (j =3D=3D 0)
-				continue;
-			gap =3D vmas[j].vm_start - vmas[j - 1].vm_end;
-			if (gap > largest_gap)
-				largest_gap =3D gap;
-		}
-		vmas[i].rb_subtree_gap =3D largest_gap;
-	}
-	vmas[i].vm_next =3D NULL;
-	vmas[i].vm_rb.rb_right =3D NULL;
-	vmas[i].rb_subtree_gap =3D 0;
+	mas_lock(&mas);
+	for (i =3D 0; i < nr_vmas; i++)
+		vma_mas_store(&vmas[i], &mas);
+	mas_unlock(&mas);
 }
=20
 /*
@@ -72,6 +59,7 @@ static void __link_vmas(struct vm_area_struct *vmas, ssiz=
e_t nr_vmas)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
+	static struct mm_struct mm;
 	struct damon_addr_range regions[3] =3D {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] =3D {
@@ -83,9 +71,10 @@ static void damon_test_three_regions_in_vmas(struct kuni=
t *test)
 		(struct vm_area_struct) {.vm_start =3D 307, .vm_end =3D 330},
 	};
=20
-	__link_vmas(vmas, 6);
+	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
+	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
=20
-	__damon_va_three_regions(&vmas[0], regions);
+	__damon_va_three_regions(&mm, regions);
=20
 	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
 	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index b2ec0aa1ff45..9a7c52982c35 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -113,37 +113,38 @@ static unsigned long sz_range(struct damon_addr_range=
 *r)
  *
  * Returns 0 if success, or negative error code otherwise.
  */
-static int __damon_va_three_regions(struct vm_area_struct *vma,
+static int __damon_va_three_regions(struct mm_struct *mm,
 				       struct damon_addr_range regions[3])
 {
-	struct damon_addr_range gap =3D {0}, first_gap =3D {0}, second_gap =3D {0=
};
-	struct vm_area_struct *last_vma =3D NULL;
-	unsigned long start =3D 0;
-	struct rb_root rbroot;
-
-	/* Find two biggest gaps so that first_gap > second_gap > others */
-	for (; vma; vma =3D vma->vm_next) {
-		if (!last_vma) {
-			start =3D vma->vm_start;
-			goto next;
-		}
+	struct damon_addr_range first_gap =3D {0}, second_gap =3D {0};
+	VMA_ITERATOR(vmi, mm, 0);
+	struct vm_area_struct *vma, *prev =3D NULL;
+	unsigned long start;
=20
-		if (vma->rb_subtree_gap <=3D sz_range(&second_gap)) {
-			rbroot.rb_node =3D &vma->vm_rb;
-			vma =3D rb_entry(rb_last(&rbroot),
-					struct vm_area_struct, vm_rb);
+	/*
+	 * Find the two biggest gaps so that first_gap > second_gap > others.
+	 * If this is too slow, it can be optimised to examine the maple
+	 * tree gaps.
+	 */
+	for_each_vma(vmi, vma) {
+		unsigned long gap;
+
+		if (!prev) {
+			start =3D vma->vm_start;
 			goto next;
 		}
-
-		gap.start =3D last_vma->vm_end;
-		gap.end =3D vma->vm_start;
-		if (sz_range(&gap) > sz_range(&second_gap)) {
-			swap(gap, second_gap);
-			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap(second_gap, first_gap);
+		gap =3D vma->vm_start - prev->vm_end;
+
+		if (gap > sz_range(&first_gap)) {
+			second_gap =3D first_gap;
+			first_gap.start =3D prev->vm_end;
+			first_gap.end =3D vma->vm_start;
+		} else if (gap > sz_range(&second_gap)) {
+			second_gap.start =3D prev->vm_end;
+			second_gap.end =3D vma->vm_start;
 		}
 next:
-		last_vma =3D vma;
+		prev =3D vma;
 	}
=20
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
@@ -159,7 +160,7 @@ static int __damon_va_three_regions(struct vm_area_stru=
ct *vma,
 	regions[1].start =3D ALIGN(first_gap.end, DAMON_MIN_REGION);
 	regions[1].end =3D ALIGN(second_gap.start, DAMON_MIN_REGION);
 	regions[2].start =3D ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end =3D ALIGN(last_vma->vm_end, DAMON_MIN_REGION);
+	regions[2].end =3D ALIGN(prev->vm_end, DAMON_MIN_REGION);
=20
 	return 0;
 }
@@ -180,7 +181,7 @@ static int damon_va_three_regions(struct damon_target *=
t,
 		return -EINVAL;
=20
 	mmap_read_lock(mm);
-	rc =3D __damon_va_three_regions(mm->mmap, regions);
+	rc =3D __damon_va_three_regions(mm, regions);
 	mmap_read_unlock(mm);
=20
 	mmput(mm);
--=20
2.35.1
