Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DB05AF4E6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiIFTvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiIFTtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6991758E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:38 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id93m019957;
        Tue, 6 Sep 2022 19:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=W48Q9i/c/1UMQBanxNkeWv60KcG85ZaQMHwIekjmtLg=;
 b=egu2x9ZsvI1eC4Nb8TZRM+A/zZviUGYDNEYuF9QgzbcIzjvYBFLO88YTmSmpa5AZcF0h
 CHhV+Ro5/qi3fxEvqk6A4DOOytOt6b5PYkNh6YTmRlXHKQg1Qi/d6rjpe2UdNhPoSH78
 R4sSmIPmEZAYgerDXVDBZ5Y85CRU+HUjJNJqU5zrFk7YgeSiCRnWyrpMPwGkNxJi7cZE
 QA7hq0O0qDuCudt2O3H+SI1nfjJ1lk543PjeJt+Em85x62+UF8PrQKCUyl97TJI5MKaV
 0Sg7Ow5ibY0Lpzs5XhOx8O/vD4WINI/CPevOv7Bmk1Aa8VeQUzUZGo7/njud1sYQ0dm9 Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:57 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HnDgo027562;
        Tue, 6 Sep 2022 19:48:56 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvw0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kr4csETAFGiMLUMTSrtClubt2UwbCHJAG81djG4DvwVL2xVgZdtnbiP6mEKOo3/0r1OhVRreYLSLrW26vBFHg0iYASqnWIIcJWnqkmyt0a70i3Ch0v1aE/CdNtKe1uZBCCXODF5PkWTmYqcts/avH9niLQKuUI0moMHQBDleB8rMmL2jbS3sGy1yccjDP0OTfr5+wW5PaygPJnrH7IiOheY2WS3DICtKQLZ4SRc2P/OiBEknUbe4EDXX/u2cI9Zg4IgQs5HdsuGWZCcNFxllIqfjxV3wlT73D5jEJ3tdDEtQQjY9r/bTsH+q6V9lFWaD6zrepOsWiZIqAxhXnv+ZoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W48Q9i/c/1UMQBanxNkeWv60KcG85ZaQMHwIekjmtLg=;
 b=TdPxbyGm1fWT2UIizkY4omcWnrISNrKg6h4XBmMdlK1H7g9tLRGjDp3dvymlilGsA3wmzZzB8AgQ6+8eJDEMDnCCTPrdmoXpAZuljWomJVMTTtFv1l8Bz9w5fGi2jeXYL4LkzRgQDsaC0bIQlCTf5V3AGAcjWDALPA77/aJw52u3L0mpF0qJdA9rWQWlULQLMjBKAEWe9NJl6iGIi8UJwhsV7zeoQtGigiDolpO3Cr+WBY5xlIRebA3EspANjExqYlyxsZ4AAv9tjzmE4fXqOuxk2qB7eOtaRNKxN3QTisDwCVhJoOPuUVTowv/6RYol4a8cEUI9cvFUHJqRA39YBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W48Q9i/c/1UMQBanxNkeWv60KcG85ZaQMHwIekjmtLg=;
 b=thKtARFj/8u2YgSq08vlVZ/q0kUi4M72RrQkYEpOibilaB3vMIoYsrw9SQg1ixt3tqj+2g3vRIWTitB0BPIJBXLgQSQm2IQJCLZyrKHhk2gZO0ms8TLhCcciJqWizSX4/StGqHW2bbnMAy4OqUWqBsqJWVPPuNb8VYoTPxSrmjs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v14 15/70] damon: convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v14 15/70] damon: convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYwimuHFlnKdm4EEK/TjXeYiL2yA==
Date:   Tue, 6 Sep 2022 19:48:48 +0000
Message-ID: <20220906194824.2110408-16-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2fe332f0-663a-43a5-e5ec-08da9040d459
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iFt77aol7oQaGKKYg+lZqNHOwhFZmNayis/aFQmKnS6ENlqS6vylntVVuK2QdoTdiuhtJ3jdMekCmQnEDLvcJLElfg9I1TMxGELezzDG76m3xZChYZuucQiIojAjiimaMIAN3UqDODRKPaksCepDFikpjSw992uc4MCOrsb9JzztJ/TwdudIjqBatWX5BDXCmUHTGqegP30Zo58zGVuwAk21OBqk2Yo7OcUIzE1RdEEbToulukoLF5DtMifyhAOmicO/tf6dQHpMuzAWrawkatUHnnwSHMiuCJxBwZKZ7zDv474sniTzuDLtwqP2EAr0bcYcEI/xrnKOAdYjsdCUvFE5FGELXDlIE5zNNKHMmujWYtleU/QaUzASxw1TK8tprIdGa0H6e/AM/cjr/XotMtSo8ty0KYUmJTm4GecqLeFHSExUvCbaKwtJKcRHdnTQbu2YZXVKSeP0+IrYoypUUZ0EGPKEod4wUTo5gwkp95H6YyhMxzU6pJOJ7HtVApWT85NJOiNovEG02xiyEMPzePmN5sGagbJj0JrFp4s9Hy1u/rO1sBiO7HyLghVzbDw879fZiZZatrnkx3WJw5q/HyUDnlGB1ANSvsFbdBnSWhMOWOLkrcT5CUoDl9minHVrq5zKUx2JKYEHeANT1qLuX4sL7HRemoyL/zF3sIn97ZP5WR+Isl8QOgZn+rc7z8O6xyDS2+5R50eS9wCO40jG2HQmaxDYp/+l4DwyQX3WreMXwRbYOJiujt5aibv14FIRM8UeTkSrToNWX3m60R3W2Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(86362001)(1076003)(110136005)(44832011)(71200400001)(6666004)(38070700005)(54906003)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rF+EaatEXZfyhgurDHzc1K0z8oTrwrlIlNKI/2XYZz/Re2r9pScs/wfjyJ?=
 =?iso-8859-1?Q?VTWijeWWn1euAAdrFFH3sA2USV4KHyeNYhHsI+DgVV1cHdYmr5f99hTlRa?=
 =?iso-8859-1?Q?6RzdAlVO3S224Q0TtjJMnEPrv7q03rHxLauAiMgKdtsiTsmvl2m2k6UXkY?=
 =?iso-8859-1?Q?+PvaouU+KenB/kZBQ4LUoQwk+f0MWKAwkdDRBqO7Fey4BGMPHspd1EvZl2?=
 =?iso-8859-1?Q?14TITRXfJX3y1lhIpgbMiAzCBd2iTzW+yav3MsA5Ho1M6gc/ePTPQPJoSu?=
 =?iso-8859-1?Q?3wZIo6km11G6hUUvUsoP4BDkRejoMxh5JWdd3QvpUvzggDhfmOPkP1Ww5P?=
 =?iso-8859-1?Q?TTW2qS9kA83WyEFtNlHZ5KcZC2TcLMYP8c8eE8NRtkoxVynYkGZG3Fj89b?=
 =?iso-8859-1?Q?9HuYtXo+z6Nom1yXVXvD3SxXvZzOsYILhuvriqrt2DXpWFJSV5aBJ9nvVE?=
 =?iso-8859-1?Q?Xx4MR1/8eF3Xhx3EpVjJB8xnE56xp469hWrrazoZDr/VLvsGyQczbOfU7i?=
 =?iso-8859-1?Q?C3kFaL91jvxSTdgsD1dni/9em0eaFCUwOapqksyXLaoEwfi8c1vQfpUtbA?=
 =?iso-8859-1?Q?4g0rs4AeN4G2AvUAj9+6EvRKiTTqDSz/mxdrRrxbmQcKiQ9KX1PxWrneWr?=
 =?iso-8859-1?Q?IfV8g8jX0Il21seNbk5SRtbHxuV5JpxUkspz/E5CWfkEFlDKZBoo1nvvRS?=
 =?iso-8859-1?Q?bcD4ls8zN2yYQ2hcFiViy8PdKr5c0FWQ6A2KMVWc2rlAndnuER2/mcJswb?=
 =?iso-8859-1?Q?fRiBI3+IN0TGMCB+o/PRaTnoPrdCncqyssayxIsbc4S2SbmC2ecjM4vSRa?=
 =?iso-8859-1?Q?jAaZp+4kn7PFr2QrsuoBNAXYj0Qbe4cGPN6MFjDUTw/qVaSz7Wg/drOdor?=
 =?iso-8859-1?Q?KNPwRV5ax3rCqFvo+rh61HE4Zas6VjEJy/+/Z7H5043n9k5D25sOcX27fv?=
 =?iso-8859-1?Q?rPX/ohPWOS6W3WQNRZPthdW6zdDu0Pr2Rn+rEDi9xpvUGrpmRowCnYz/uO?=
 =?iso-8859-1?Q?TYVCe67cpcAQU/nRHlogqrB0sBsErvkwSOg4AVZrinYJUbc0gGqSonmc/c?=
 =?iso-8859-1?Q?VZyqt9Kh1sYGmqeHctAT8vRYOooUaLyqM9JHXOJkcDCnJgVdfQngka2rfv?=
 =?iso-8859-1?Q?xVF4xu/Jh6fl38CMA0hGELsJlYsMj0RnjKf8YGz2z4rtBelqQ8bxLd8dfH?=
 =?iso-8859-1?Q?71KsalATOjHLiVNpB1RuApB2sQw9Z38/hEBQaCX58aYxojhPvjQL/hb1Ap?=
 =?iso-8859-1?Q?ks2iUP9rQSf7hXar7If3qfIIwo5jPWnxkrvL95YQqp3Tw5lnSAIx2f0E8u?=
 =?iso-8859-1?Q?nqe0UGT6ir70oP8IR5+4mkkyuSHeXHep+ovcn7FHHGlROrltNuGbM6lEb4?=
 =?iso-8859-1?Q?vPTqMK/jQRQ/w7RES/f5otw6clp/BJahwNo2eDpZpmcDUzBj5Wf24GtGDY?=
 =?iso-8859-1?Q?kFruTt3neEpLma0NK+hRr6y4NwIhynSEkgk8bcDgoW6Cvgj2u3eoKPnTA2?=
 =?iso-8859-1?Q?ZW5x1SKsYy8mcJyVIU9+eFJM0mtKfqYf7knpdYYSomLaH+DLdLJibVZJzA?=
 =?iso-8859-1?Q?hnUw34SHt6LD5mx11AeUluzej+IVU5G3Y6u2mufl/xME/uXp97S4973c15?=
 =?iso-8859-1?Q?g4apzyi9DdRROojuiD9fGUMq/zhd3BcyiGe9/jE9qittD1t9IThZf8tw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe332f0-663a-43a5-e5ec-08da9040d459
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:48.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZeWIQBw8oJCGU73pSYVFCPsqvArBzACacCJ/idG/WJd2funXJFA+cAsEGslpUir5AdxWYx7ezbbbTtuIq+KIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=980 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: AGOa4HKtfIb_6xXss8W0NfwU1VeAl6AA
X-Proofpoint-ORIG-GUID: AGOa4HKtfIb_6xXss8W0NfwU1VeAl6AA
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
index cc04d467ba23..52c7799ecc1b 100644
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
