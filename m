Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 568FB51933A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242666AbiEDBQW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiEDBQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:16:17 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF447B75
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:12:39 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KctEm024988;
        Wed, 4 May 2022 01:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wMnXYZ6ilXCCmNJwmRifegQ+iz/dSmHFhbRUOQ2lNXg=;
 b=BFSRW9wEgqnVVu/t0IDQWGUBa0GmdZTfO7Ev0j0ng+bdcJiAyQX7seAv1zlIPxzW1aVn
 Vt5SogMtCFrrP3nvfzZszBDynIipblkxtXYyx4Z7O7PhuDxzLv0R4+eu4lBYFHkLUFi9
 +978JFc+Q9RIaDvszeExWSrVVbTBZE0uHtbSZZV5TP4pvP1UgUHTc4o+oH5yyhje1A0l
 txMQMUjnXFOOZ8jM02o3W6S0AQ/DmvNubi6Ctm/8kCtUf4oKm5Bgev01cz16ahxZFLuT
 LsR+CNLGDetUgSEXsb3SMc53EHQWOp/0nSinHgnxlhHGhGJFVlcTZ4x/QFSmrbOff2OC Uw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6a9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:12:28 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441As5n020085;
        Wed, 4 May 2022 01:12:28 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9223a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:12:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV02A98bHCXj/GCk331MgxzerwEX9mltNwHxyEC1XOP+wZbbq1l86KRBHmEivjqAKyRWElv2sNsrb0lDNHcwtPny7h3CecKjEoufZE3LH0CHo5WdQbI741/aKYu/65PEJAU0zhXBOmaqjvVSXDPtYgAC+X1yqyHTUyhGpIYcyKAGTCpwMWHSC8RL4E8v6c0ey9p5HfEYbQgMHrbRJgLUqFXg0GOWE5Q6V2DUh379MNGLA33O6mBHOgwiCpq3UhhA9DTqfq1b9TFXGyeZQXhQM4yn14CK5jrkneabUdZL5Wcsq4Csb1UhNZkap/Ry5xmcLeLcgtK/sClZWgBPo8/bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMnXYZ6ilXCCmNJwmRifegQ+iz/dSmHFhbRUOQ2lNXg=;
 b=bc5j457y4jYDmSG7XhdCPHjEU9h5Zb02+4ADjJXVIhDhfS0h4FjmIYM5gvHpJ8v7duMMS+7Mnx7aphtfC/2ktCw3Z3EW2jZMFTbBYbrwsDitA+gJhTYkvvIcKIyy55P2/aStFLt6jX/zpugOO0tTXNeUeJ5ZIpXHHuPrSHlDCzUn9v5M8UOjQMkEcXPAo9TeFb+sqeOYpm1QqtyJbpHHeHHm0jUshBtg3tW3WrbUDB863lrzVaKEuT+C7POsmS9SLCXbYkQDW/u9Jm/6wCxxKJbs4DyNZELQziKaAATRSqmQCdvWbTiINuzS9DwwnOPmwVxqdQsPtFSuIr6RnHTPYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMnXYZ6ilXCCmNJwmRifegQ+iz/dSmHFhbRUOQ2lNXg=;
 b=MVEMXXHaCjw9iayVJ5TTtXfCOPya5DiJTjs7Q3DBagG3Xl5EoSWIa4kEs36KNskcTabJeJ1hXzv3AZFWCfJX//JT/2ue/v1vzYWQeYT87XGO5qxdUG4ZSDXDGxLPT1+Wigw5O6C83EJaHV87FbTvSl4DzX49/mTpaeQq9SJLLkA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:12:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:12:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon@lists.linux.dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v9 15/69] damon: Convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v9 15/69] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYX1QE+HvcVvuhWk2ltHXx1nzXSg==
Date:   Wed, 4 May 2022 01:12:26 +0000
Message-ID: <20220504011215.661968-1-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504002554.654642-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3a9024bf-e8a2-4fa4-a46c-08da2d6b26cd
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB58301804B0BEA1BA808158D8FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pgg1b/Sag2KxliTD+rmYG0L/GONovo2z9V7yZCz8ngyoORAO7UHktGsxA8g7J4pglnDLCyZpG4V1WWvdDSzZrv1tA+4l9PNyu7z82de9dCR9qigBc9ha6y7EAIdtHAHJoeu/QliJO3RlGU+ad+S1UJyehN4qtJMBovklcE1xttw2j8ymWhc0Xh4HU5k8lNk11oJ801RZ1Z4W/ucbbIXFM+UAvJMbMsf9HgPO5qLF1VIrSwjz87zJOpyn9oeIhLglYdm0LsV7hBS+QQaLzbgPTT2ck5GLCYTojXjoBU0NRj/IKmS3Lez1yOau3QK3xM1SAeZGJUDQEtGBg+E7IVr148dvsGFV43ff4B5LoPAYMoDGsG0KAwdoTOS6fEJgwJJNt8S4U/7clRbJJRion0yQqoXomOeWmaC6RobJU7m7bbVh3d6k3L4WgHoYNSwljXzffsMxi8NEaDWBaRg3MBQs6rSytmlC1pBTQlut4WQ+vwJ1AauQ6n9vP4HHbiP4RxMWMAu+hqx7lRKHs3c6eCYPcst6KMM8J38Dqa2U+m6q09/8kCql9L3wPt21FNTT+IPuzQOtrSNdCnn16xABqJLS53Qek2XLCzKtkFh2e6IptWgeS+YO1HVGGhTtP9XVjb1XWCxiabQ0DiCX1HFKcO7wN4TlrEnBSR4bpXZc1SlbnyOxFh/eWogsQy8uOWGszJfwZ0u9XDBoyMQ18OOxOgncSw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/mD2xn3N0kFKerH7RPBlVX6XtmIn7IRqpXB3JPP/P8s0w0A+D8/73mHZlS?=
 =?iso-8859-1?Q?Z+L9oE9jERdAXMRmQ12jbZjTKH8ma92Ac9J7cMpU/bLaQIbSi0tyubuMxj?=
 =?iso-8859-1?Q?+QFJ2PH0xgamKHy/IGEGT3mY6a5aGi1M6kPixM5mFtGG6Wu9+TuTBXImOM?=
 =?iso-8859-1?Q?G3h9DINdqreh8SZRHV8jeByprd8+hcdSo9pScqUieWZvIAafAmR3Ykxjo7?=
 =?iso-8859-1?Q?iSHCLINYppkr4kwhGz2TRVgdUk/ESL44HX0eqcRm6Fah+9OwDkO6sw93BY?=
 =?iso-8859-1?Q?Fm94UORdOOZvKruRvibYrCcJMODVZoExafgd5dyOARPx+OBJGskKu1Gvk9?=
 =?iso-8859-1?Q?zrVMkMUcUFUM/c0cqQF3jSVlaXYcOTEzkmYDr1DW6+q/h+4XZwa4kDkMEH?=
 =?iso-8859-1?Q?kx5h53QvzXFdUpFLtUNPdas4ToDGw8z+GhxzFU50+JmhL9ngRDEEQsfYzR?=
 =?iso-8859-1?Q?uJDk71oxqBQm7XseLfQn9Vh0CVjIH4ieWkW7UoHjNzHBkLMxWRp4RkyQF5?=
 =?iso-8859-1?Q?EfrQGyoVCrTyNoLHTPezw+wX9pTqvkMnEKgok6iGQ4UDUPCMbere3LQazD?=
 =?iso-8859-1?Q?8QCbzoMof4OOsKF5xwsE+b1CB+cECLORP/vzqu7O0lGMg0bzxZ+tTcHKTW?=
 =?iso-8859-1?Q?gv0AKbHLz7dajRugoFoNX3+eehuZAMlDftAMQJkBT6vUgHyfDDBnXuMYWz?=
 =?iso-8859-1?Q?dSV3kzPZ2ike9z88yTqsxf4g0992INBEmCNCrHQ9rW8GVE7QtZDgTzuo62?=
 =?iso-8859-1?Q?9FRuoU9JL9A0NmzAEuPE/6n7gJ6d/TdzNtNrzHmLegPbfVEm4RPTgu+fCZ?=
 =?iso-8859-1?Q?eYjSAZd70HZtJhyaHwcO3fmxzsxND+B87t9glzMVIGwjfZ+trX33GfDq9f?=
 =?iso-8859-1?Q?7JuX5qb41RxuwXnitmQyiCoKIrnMme/EQFEURQL06a7ru3COCLd7NiHG4v?=
 =?iso-8859-1?Q?F3iHFtUHd88Offksb6HBsiTraGPJiD7Y4QbA43n1GRfZs3QOvgAMQW++KI?=
 =?iso-8859-1?Q?VuZF1kkM76GztRVAQKm99Ku3TrAPik/gGAizC360+i1EemioN1l36WASgP?=
 =?iso-8859-1?Q?s4BJNZEqAdZVZyQQW8edLC8SDjipWob2UpOSKEMYzlnIwoNAIfQ9VIZ0db?=
 =?iso-8859-1?Q?X5crqMEAB6QnelOzv8Z/r9jm/GO6d/HrnBaUhZpjoaWb11rPjEa9kaBoL4?=
 =?iso-8859-1?Q?bqmaPSAAYzPsJ/VfT3ykLFAG2bNHFzbFLyGjNP8D39rcc+kcDPkTvDIKOJ?=
 =?iso-8859-1?Q?yNM9ktAw3417JPFuakXjKSAiiPtAFexS4q9+/GzYkOV8Jl7NxVO13NOvpT?=
 =?iso-8859-1?Q?gKZzKUCJXor8se73KriKn8YxirrIIjDfhhWItfgL0qkDRHp9wtBXFBQhsQ?=
 =?iso-8859-1?Q?pZf6pb0t6keAj2Aa7tX5aX/pJOdvrMqn8S07RZaBWQfzpkit+42kZal1mD?=
 =?iso-8859-1?Q?FQTfOfB59PwXO6j09XxzVehqrPwfRHE2ZX61e7hN1DqpQ9SR+ny1Rb6a4N?=
 =?iso-8859-1?Q?GM/C/BMUixJPwPz53psPmpGeP6aYkk1rBghUVaP2a4zI/TFWryCL2rir2i?=
 =?iso-8859-1?Q?kpHHeSkSd3cTfEHfk9pHnOeRUyMQIY6ZHCvjgJjZt5dySnuNHG/QnHkl/A?=
 =?iso-8859-1?Q?6NcmCt3Bt7ev1IECweUUotSxK6214hK10KfQsF6dSFdW4fjBUfTgYxrze0?=
 =?iso-8859-1?Q?8smGFyUvIiRsr1y9ZMK0XuCoMtGWtWa1XGaSovguokV/nrKqh9gOn8DQVK?=
 =?iso-8859-1?Q?E/JVtxKN6MINILJg9caU9qWV6zQ7bWP+oR/UQN9MOQfP4557QsluwoJM2L?=
 =?iso-8859-1?Q?362Ppq+belpvFqKcfIB1iU+I7SxtWUQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a9024bf-e8a2-4fa4-a46c-08da2d6b26cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:12:26.1795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mdjtnHRLR4OkPoHsMzDNz5DqKLmeJKxAOL7mlWlx3LQKCW69MfthjJoOCrjt+TJI+QxOnJVHfSrSOZmSuh7+sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=798 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: xM11dKXUrMJiEHMfD0cRDmHNUGg5mIge
X-Proofpoint-ORIG-GUID: xM11dKXUrMJiEHMfD0cRDmHNUGg5mIge
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr-test.h | 37 +++++++++++-------------------
 mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
 2 files changed, 40 insertions(+), 50 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 5431da4fe9d4..dbf2b8759607 100644
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
