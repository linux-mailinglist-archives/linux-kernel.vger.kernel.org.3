Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBF04F1722
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377879AbiDDOic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377811AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986C63F338
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DpPEA024458;
        Mon, 4 Apr 2022 14:35:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=0wrZF/kcIlxHItSc2EbcpuGpVY0q3wvULZ/w0Llmifw=;
 b=W2Qc0+qXkDotmHVbWxqHT06BDoca0AgdE4Nua/ASqBHJUt/XmRIB723+4ajx2onaTYPm
 0QsNdM/ZuYv16rm+A/y7nWVZ3FJNu5jRj458bg/PfFW6L0qVg4iy1SLUGMp5kE2iPuT+
 4TdfmHaZXVezg2Bu87Vw8SkiDkmvyCOcegT62XJuyVbx9OCpArrmIaPycJgor83ZWjF6
 VfQuPudLSNtwPtoIKb7dPHPwAdgFrcvob0cjZgtcdqHBsmV9hIJ1zFv5D4moF+Zhi95u
 es2ax3e7sMS52cnlom0pSpA37vgs99aeIfhTy7Esd6PHvLHRtBmC6ap9ugIK/L6soTeI 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3csb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGQDv028988;
        Mon, 4 Apr 2022 14:35:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c8h2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHJrOZwhln5Sc6bv+bWe/PPt2oFcEQMxNLj6lSNCPlFag3mCd4dl4IIrNSPXzUlG7nDsHW47IxaRQUcJ875uwRM34EWRNv2p2iyAwStpiITKk0sthNcR+rgbCyyY+UgPrKv4OsYlfK1lotM8YWWQDj1TrmI9KiRFd6i3X9WDNixHP7Ojcb0QP/Hug2ICNLuzddZvpJ5uhDDktwsAOWi6XeYaLsSqWV+5gD0ZJw6o7FvNYVe5jna134e64O1cHwjYlmqj4JmZWlE6zkIb3vTKKWyrQo81LZgG6R9UXi65FW76D8NIl3mE62oy0g41HlO49XXPscyzNE0xOkbnOMsPlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wrZF/kcIlxHItSc2EbcpuGpVY0q3wvULZ/w0Llmifw=;
 b=hCJgQojm8o52jxOKqg3ebWH4rBA8ToZcSKz0pslTRd9PNd4cc5lYeOr6oaUQExJ91eyiPoQNOqbySvjqFaQznl5dec2UXAnNunovdxV+zXRy9ka1U12zNtG1bJPznV2Lk6WXZMbW9MR3CtoF+Ee+LkkxvUF2RMc/WMOVr9CqCv0j9SkUP3xMC5GBb+ABPYW79jNE2tsj0ZmhRjDSL9CenEGdgJ5sWq0jYgrMVunv3kaIHwrYjWhf9s7QSziM0PY8hsBVsPjEURb66oaSv1W8x9FAs0Q0VP892E+goh5PQGCrD0ghWOGX8V4wWFbxKeyaXz+Ab4INO/qhRPEHbj0XRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wrZF/kcIlxHItSc2EbcpuGpVY0q3wvULZ/w0Llmifw=;
 b=TtuhQQs63o5EpqGZgspiIaJoO5E6sX4z4WFnp7KyUNHPq7rdjsiVqB5lxO2FPzFJbulDZpJk7hWckT3aYqlOuVh5JnWWLKmubjs09wA7016yRWd7/xT19zXV5V0dMSZjJTQjFfdzQpnQo27gS0iC15+wz225QoLkYxQt5X5r6Fo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 17/70] damon: Convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v7 17/70] damon: Convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYSDFBBGkz7qns4kajr4hF4pBHFw==
Date:   Mon, 4 Apr 2022 14:35:39 +0000
Message-ID: <20220404143501.2016403-18-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ada4c80-1489-41a9-a68d-08da16486552
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812C166DE505F43AE4115EEFDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZVnIBfzQA3qVU9k2iBupLL7Uzjw0lQCXBy7nYER7CQmSXk9oM9bUOoSvYMiJR/A3DsLXjWq5+JBVVduM4ofXPmVFTg9ofrunGIYKHYPKklmVybrDAM5SGnvuEx0KaV/qQMpZOHq9BYRq5VXm9yXFPz/Xg8eJudyJpWhyS0ixcYx4enTpC7BdZyEXJUkOh27dXtuGuf+X55oeeLP/FA0G2lEtFmrJqiV7Ft41tI/SI4afgXGp/LiJEzWDMn5HR8SUlYWzgwnFFaTguIqIzdoXoS4eDfgT8osMqnJ3HdcJd1R8CU8j6ANm0s8W4HLWdZksRFdNP1G4NnHDqOhXePpT99I0M2kXHBag9z3j2SdCUknYKj+NbTep6py3Pec8pla+2rM9fH9IxCn3osqc7PdwfiRQ61+lJDYr91Gi2QJalNuJ/XQW1uUBP20ZQZM+/MC5D3L0/EEStdC7WgYYCDosRPU7OMBu5i4W0ulodCE8yxpcWSyH7HOVLVrB0mPdVKquuOmyXM2o9CmOGDGJnRwxY3/W3BrCB9pzK3AetoBHpiNpctl7yeeujCvd/Kt6wocWEnJw07ZaH0q/iT41Tu+aqjnJOaTQ7uN5B5wRiKeHv/G+hIbR8DKmaH7sbzgxOmqynLCUCNfX2Jy3U52BOE4zkzdvtxUmNl/MIfKh/2T84rK845wBOtTZRpkRhHt1ktPAtCqa9Jjsp+Vtnlot/0JuhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hCxpAUVbsrQfiWWO4UuY3MmoqtHmMIHCLLPXM0/pFnmUvT2OyS/6tqkDQw?=
 =?iso-8859-1?Q?hHocnqSFMjFxOFeb39UWS6TKsr8egOpvqMQTB9GIg/SchANEyH3La+xENe?=
 =?iso-8859-1?Q?7J6l8wjJoWCvykIsrWfaSpyyYWNJStoZL3b+n1Zwg5rjJS7On4/LbnAGtN?=
 =?iso-8859-1?Q?bno83JFBs3g0k8zZKavHMcpSHI9saQdzTvh87wXrLVE+F30LYJH705FVdH?=
 =?iso-8859-1?Q?FMbsgXyF9hg5qzaK8sPA83su83oDeHOBtvKt7cmax5Vomt3GsZ8wN/HqDL?=
 =?iso-8859-1?Q?66Kmv+yynoPsnU4Z4tf2zoYP4jyOSn2mv82JBRG5Ed+DAn7O5TPO8joLfT?=
 =?iso-8859-1?Q?KhCANF57AodIiBurTIaC60RLFHsZvVBOqDpy8hi7CaYGE2btIIY3LMfluv?=
 =?iso-8859-1?Q?0YIT6mUuMlMGOSs+2nQ28LWerA5oHA2HqE2Xu+5Kuz3N2UE/TyHOXrSGmA?=
 =?iso-8859-1?Q?SqoIGI3lcn37tgIQz5M5T4KpxPP6Y0qQTWce7jl+FeRoFsGbqHoaHFlyTR?=
 =?iso-8859-1?Q?IoEreHkMbYeMdicI96K90mmf/PiJskIwPBrLwadLVxw1a/nzicTdEIe/mx?=
 =?iso-8859-1?Q?MdORvgS7whkDOsv11kLvWNireH053W7JSpwlV12hV5dl2cPTHP+nNa/DHW?=
 =?iso-8859-1?Q?yprq4S2uDQeTpQTDdCmd7AFRfOpY0BbvKLIZ9uHa1NLlAeoyOl3G3df5Qi?=
 =?iso-8859-1?Q?qWxrhVIzlsvjFzAw937ZmElNFvUgxWSk4EAmvASdTeZ7nSVpEhiIwzAL75?=
 =?iso-8859-1?Q?xxQtSuFRWYV9QV4X9v5x2Nlg4j0/bg9hBixeQDhq2i7s5qYpQR858an1F8?=
 =?iso-8859-1?Q?N2DwgJQJq2m5OtIRTzdZ8os2QSApVis/d0HcCLdPzKedgUVvxTfEoauOh9?=
 =?iso-8859-1?Q?jyB8pIJeHNBnmmem7SgYNOCeRMjrGTrJ1b6H5bdj6VlzQRYm35lsV9V1Fs?=
 =?iso-8859-1?Q?8H0RHnScr64vnvI7lZ2u4Ii1ehIWV9c45e3xCYLGFW4iyGVzkiJv2DrOuE?=
 =?iso-8859-1?Q?eA4djyGkezwfwbTQsYeutlFTofKxWVpJJ1vf06LXj6gVhaRS43UEcab4Dl?=
 =?iso-8859-1?Q?QpYOut58AOFI6oFB+oGuqk/xEEd8OPh7S/OIHc3MN7/lJ3dAMR7z/OYSbI?=
 =?iso-8859-1?Q?rgx8/RNn4FFiW3PG0FF4C6Xz4TZoRxwgUDLVEIsLkF41/Z87+lOKBwlISB?=
 =?iso-8859-1?Q?Jtuz9hsp+boXL79fFV47N1yQs95euog9BTuOj/2z7Nx3atuNu6sXlIRc3W?=
 =?iso-8859-1?Q?qiDIMkS5wXxwnaJVr98z9nHK/65/zVpFArkpBECyWAlDZ7EDuPt0Iyz5C1?=
 =?iso-8859-1?Q?VpLw6bhSlqFxVqAauMbqPS9ppU5oWuJ7Jl7XyygshvCsuz0VKmYBQA5Tc7?=
 =?iso-8859-1?Q?ulLdRSUPcuB/dNhN86K7XseYGaHd0UKnRNGKt6OhTm5jCcttSvD3QlI8/b?=
 =?iso-8859-1?Q?HUyVsVyGQuTdHDdWdasrUlKCPahl/YBYjwac6TkRONsRzDntjyv6IX/DZe?=
 =?iso-8859-1?Q?0y1WzNXYUyIXFIuqKZ4bhNvBXpFVWEl24loe9k24jOA1gmvsghyYaimNrN?=
 =?iso-8859-1?Q?jSs1Q0PWbCUsPWBR88b2mpAiJNMM/u3bZXCEzf7xQbUMPiCVdKym5Ihip9?=
 =?iso-8859-1?Q?2B9BgrwgjVgKlLRF+cessVp8t/VQ3WrGhXcWX2fJYlTTwkjJnbiiV7TiYP?=
 =?iso-8859-1?Q?UAxCYsSohrb4ffticX0OIzmj+Pl9AqdhwdRioNythXVY7ZKQ/2BwbtiTPZ?=
 =?iso-8859-1?Q?hEnzyHNAxIf2z70D1d37ahA6mHrAlFhdJ6hlj+ceP7pRWBPmDA+d2ZyY7+?=
 =?iso-8859-1?Q?x2kpLsWAL2UoAgM40fSUZsQng4oJnoc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ada4c80-1489-41a9-a68d-08da16486552
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:39.5188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5hiv93rFZ2qBR23EefHWqO3DUQwvEa7X0Nw26+0cdY7AgLGQQtdGhT8WOQEEEu7ZOHGx9LHR5plJida5X9M5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=844
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: 1mD_ikSGnhGsc9YAcd9D9DxonemkOAFu
X-Proofpoint-GUID: 1mD_ikSGnhGsc9YAcd9D9DxonemkOAFu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This rather specialised walk can use the VMA iterator.  If this proves
to be too slow, we can write a custom routine to find the two largest
gaps, but it will be somewhat complicated, so let's see if we need it
first.

Update the kunit test case to use the maple tree.  This also fixes an
issue with the kunit testcase not adding the last VMA to the list.

Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
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
2.34.1
