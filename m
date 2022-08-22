Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A129459C21D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbiHVPFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiHVPDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6CFDD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkVZp022022;
        Mon, 22 Aug 2022 15:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uNT6qz6kdwLzgbd1sTPY7yBKERxTnRvjhCBl78lpypo=;
 b=bijRkeIxhssLOwlRDTxcKxJ4cCKeIJ388miX+s/hW7igjcPyZAy1edlmxIUTA1FQTKfu
 R9YtEnQSXZARuDRD3LahEKFPU+16z+MJkco+Zi81iE2SDHsE914Ko7bSSWC9x1S1VqKC
 8Qg0pvPKSoeSlMF5Zmgq596WpJiHTKKpl6sZuzkQxjiNGPTYkorc6ICeDeBBw1ECe40o
 ShHNCGS+C1FkEeNDaOcxOpNiXIwyRM+m3uWSAYz0HRA7OF58ZbCoFTeQCqmpxa9124HF
 eId4ZYQ3QBxOk10WzCY86BVOUZ/BZR9l0pYPZYS/lGL5pWE/EupwMPeIKWL8MrYJ/5rs yA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4OkC035558;
        Mon, 22 Aug 2022 15:03:22 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tv5j-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S8ir2zPBl15N8J3CxAg9klxF1L0PpURe9IfDR3thiE8aH5Z2p3Sk4tPuu5qO/waROu+f64qaI+SWTBBYoPbRSfl/ss1+8+PmWJs74kDNuqMFW7A4j+PQuW14lqSXUrSFcN5TlrZrKhVrriLc7APrIywSsZFAkNAMLfyVpV0F8XSSsw2jeZ5yO+TiPEmUNPDVPZpsGZ5lBxU9SpTVcHVVufCssTmBdEToWYUko6xG0NPVUUi1P7k8sOK2QLeRaGzsvV4Gt7T+hXTH6mGBDGWm10//AJS317CcYQyYUfidvw/EHPpLhYLuxDR5Yl5WAO21HSR3+CPcnn+djcQeZ6CvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNT6qz6kdwLzgbd1sTPY7yBKERxTnRvjhCBl78lpypo=;
 b=hW9WS8QAj9/3M/y6maqI2BC3u7mvMDTi0ecn7Q6yYHYCbvmz/vvmjAJiqw8Yh7+1oggMjKXXOHtntxEwEU8PGSE34UMobZ64uDaaStckh+WIoDi2a3dGpx5hBGst3X3Xo5ohHb1KWQzdOmyUD2jKtZEpymO2hfR9sn5ipPXNCANajAnQZrOmNFCcu+7iWtP29Hr5KmnUAGZQzWNCifTt6px7Rn+zjSQjfPwU8kcEWirhtuqdmluMva3VnKSD250jUmuw6M7XEwz2Je2gpzB4Ge1EchtFCO7lZs71bmCu5DXH0gGBSmuNj8hIoRYF/xIc2OUhrhdFWvpZ580Z6nsN1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNT6qz6kdwLzgbd1sTPY7yBKERxTnRvjhCBl78lpypo=;
 b=keeP2AN2JYL3VU2MqNKAaxIlDZ4jAomlXGWI31KSr+Yf7iQK+50DQH+6vVsI0YhYVg/8+daJ9XnoeIwU0AXZs7/cljK4pvQ++DdBj7sM2HFvNlSZqdBE10kNV3GHgThPaHKujReo3+lGwiAr2RJcE9nCmhdT03r+YzNe1soEiv8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:03:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:03:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v13 15/70] damon: convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v13 15/70] damon: convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYtjhOVPBW63PBkEOyMBGu4CBuUQ==
Date:   Mon, 22 Aug 2022 15:03:16 +0000
Message-ID: <20220822150128.1562046-16-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87a59aaa-f17c-4676-911e-08da844f7331
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: irL/NbD4fEdzm731XauYBrGf0lYe64s7YOot0kEshx4su7mV84s1W8fP6GvfYbMYdNPf7TxrR3Zsq0MoaQaBdzrqY/8/20T0lfyCo9A7Et3H+DjpUK/uXqsDyL1YdVJmzqDdOP8B3+PMCCY5vveca6EPqDfWxju1AqBo1/UEwnmXdo8Qk8uPetPKnmLAytnbrmQ+dK74u0YiP8WjoCh6eW5ds1SKFuRrE6izKZqdMZ1RpEaBbOtX0tnWOhLdFM7l+PnvEzn6QBXfxK96UwQ4IbyUvWwGD4NJ5x0IPwXAQgBNmB0g8CzCcOGBCAkC05v1rFvjUQXH3bm6dTBsNLhKUDV9gE5xO/ioFzG2c9woCaMfHiheEMd7h7eRJJ8Z90YMOr3Jb8DM0YKhyFmilBBppSDnczCxft/RhiM+kAdozVH+g4TdWcesQEngRw+Fet216Yup6Mkhq2aV0cQyaMswYjU321DnR6vvITTaNwLgb9wDuwKx6wnrL6lcVcBnGHQn3pA9WYa5fZeUFIRj5EW2PML6zfZWVaWTxbiKTIwBMBCUdntZ1aZuUEWlktJfWPAHOaidGMGL8EPzb36IwNhRWyqvGeOIWHx4H9tpB7SYe9ZusfV1bSMHAiodn/kxpiWiaP3IuS1+WXJbajBhQTU4oeaEcqewAVq7SHfWD+SAzvjoNzvLW0i6eU6MJN72DkQZHqEFXpjMopvEBJQbh5poNT4bhYY8ThcEGIKq5z/ZHXluai6pp6pBqmJJxLPveq37tNrdKClCJBDfcomGiXjLXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V2eJPBpeps1vyqwVWhUJR1uFlVFHMGBC9H273YRvmeCSbcWGMpFFVyYyTP?=
 =?iso-8859-1?Q?Ebf3wWfvzKIQZztihgqAHLdw/7JL/2TrghRMJ9cg5pK/phdGZVBWi7Ab8o?=
 =?iso-8859-1?Q?5j+ZH3aMKnucH1PWzjmH1As+aHx8DGQ3XIE4gcrjFwD4jLSM5Z1fBmd0T8?=
 =?iso-8859-1?Q?H3t3ghrf8vSTkEDcI5TvQVmiIHFDEzu1XPxXhkPadz8sAa9FJ0goRGIgDs?=
 =?iso-8859-1?Q?mxwI1IpPQXdk6zLc0iVwkJMdgcxdMdd9nT4gUzPJxr4s+YHHDy1Swf43sO?=
 =?iso-8859-1?Q?X9rdpMCTS6UykuzI284z8caCVDFaiUcZDHpSAfS9GROw4TuoHr23uIHqAo?=
 =?iso-8859-1?Q?FfyafPrZXP1K/BNE7v18QGL8aYSoL6k1LVP1YzpZMT92eodGJFEu4pGtUs?=
 =?iso-8859-1?Q?at4WRWKMXX2O+Z/y/lgoLouPZ0pSgEj9Tbw6NfWBu8Muur/plEN1u1mASk?=
 =?iso-8859-1?Q?CEPApdqeLoMZNWxICPF9MLHshtZgccngJ2Gh/vHyWThx0RAT7DuUVX115d?=
 =?iso-8859-1?Q?Jep7/lnkEXP8t+yc8/Xgl/fMzGoGxgtkpEhaK1usJEHwXsI8MHqZDRrzbW?=
 =?iso-8859-1?Q?mSvynEy1vyhWzecCtaxNyB+evlImVAywylqTu/P5bIS73VmoGVHnxQUj2Q?=
 =?iso-8859-1?Q?RWiBRO8SSeIDqa5fHxHrK+Xrfgqntt1eaGxjPe8xRMTvMfbBueMPrh1dRp?=
 =?iso-8859-1?Q?HMuDAwi80AKcViA1T4eAML0vNBcc4TnlDabyZgw6FU2UBNlmGbaoZlQU1g?=
 =?iso-8859-1?Q?ZzwLKzYE7R7eT0f/YH5TgtkC3IoFWSzX1Uwnk1zZlD0iAYeGLjXVV04Lmr?=
 =?iso-8859-1?Q?sXZgbek0P2k0qHYhWCik5c87H3NOxIzqTHzlk1nEV+MKRQm2ya+dC1Dopr?=
 =?iso-8859-1?Q?dpAv4JJuUR0lII32HUH2AUkrntPJaGHoP0t+DQkYEfuDJ5RiZd1vCfrGTx?=
 =?iso-8859-1?Q?XBm9/q4hg9Hf7FFHIMZWgrWsMF90pZ4Eur1kd3VEwMeOeTWiQ1Igi4JBO+?=
 =?iso-8859-1?Q?rimLnoP3dvy4uXDeDXWQwpUUf9j3kAKHRex2oNDsC3IB89LKrkSiQAFZK+?=
 =?iso-8859-1?Q?X5p8NktQdAC7QaGRw5yQzyewbO1tpip32j+6qI0zzwRnlYqsFouhmJfbci?=
 =?iso-8859-1?Q?xP6Prb8gxTv5ixCSs4BbgSYaob94OvLH4gkzKzBVMcil/ccGKbsnNkEKz0?=
 =?iso-8859-1?Q?+eT1V/a9rWP/ejyy8LOu4xP5SUUe+xbInPG5A3dA12OZPmG8U5xdYf28Mx?=
 =?iso-8859-1?Q?sies9n0etwlJV3vkS4N3uk9P7FWFPioCp/UXUm1jxqiJaciwKv+K3k1LTL?=
 =?iso-8859-1?Q?azxXg/FNDf5tNnIUyaWfO4CcI39/gRB4t96Bu75PRe4QbrWEtqP0gJ2jTy?=
 =?iso-8859-1?Q?X6omLLmuTra9DmXpBgr2kaSHFdcvrt2H3v3j4rH/ZH7SeivBfz8bRVdUC+?=
 =?iso-8859-1?Q?Dyn2MnF/vpSvvtBojSJe6Y2Gw0LoRrOMjamDmzaMvSJdtgVC9nbDM3Cp0D?=
 =?iso-8859-1?Q?Ckq7SBX/E1oDKhNqoSd9ErFRemP2DBKE5ffUZdL0J+kqXiUSR2IVVRaWdv?=
 =?iso-8859-1?Q?O7h5XtsDwMmui7RUGr0+OOUfvbUgA60wiXaAswr6vSBrR3odU+pQojXd3+?=
 =?iso-8859-1?Q?vWGNpC8YJa2CC2fKSevCf/z3h46GiCqN5syzikEeMKnlmJgcaa8+KJ1w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a59aaa-f17c-4676-911e-08da844f7331
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:03:16.6415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dHYa47cKx7bxrJfZr8a0sufVof4a4hypdF387IX30bq8iFIIe+RbHhObYR3wU/MivOGxSQG3/Y/VVP5+NBNlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=969 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-GUID: PKUGoX_2JGEP9p1gXf0QzdqaQi9Nw2Vn
X-Proofpoint-ORIG-GUID: PKUGoX_2JGEP9p1gXf0QzdqaQi9Nw2Vn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/damon/vaddr-test.h | 36 ++++++++++-------------------
 mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index d4f55f349100..bce37c487540 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -14,33 +14,19 @@
=20
 #include <kunit/test.h>
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
@@ -72,6 +58,7 @@ static void __link_vmas(struct vm_area_struct *vmas, ssiz=
e_t nr_vmas)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
+	static struct mm_struct mm;
 	struct damon_addr_range regions[3] =3D {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] =3D {
@@ -83,9 +70,10 @@ static void damon_test_three_regions_in_vmas(struct kuni=
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
index 1d16c6c79638..95769ba14262 100644
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
