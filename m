Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12853553BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354397AbiFUUrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354342AbiFUUrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3A0286E3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LIxVWi007491;
        Tue, 21 Jun 2022 20:47:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=k1HPgLoQZBDBwIGdM1+dtC+MaxiPvf/NQciy81idY8U=;
 b=HWcrJ31jjXMR5nVguULpNDgvEJhJDnwmnAMIec1MJEpWTleQ/JgUEjw976RgzpVy8vzd
 3rOvKEQlK2mKTOV30YxtcMT13JUnYsfhmfT35hKBgTXYSWDD0D+jm0WCQ4cIAVbu5GM4
 yx2JpWXLwYe7HOhU4DvrN12mcSXlCXdcIqOBZbAGauiEO2RVPDff/aQtBuvRHaTdFbod
 VGjrdTVrCwGvYnoXZUxcjt29iH2IM2Qcbi1bVuVz0o1RvIynZ7yI6E/eRthIGB+nq6KV
 oBz/t9VmEdvT6AaOodWaliBiXv81gJLBM5G8KJGpSiiGHUYAPLnxOIArI0wuommgbzWG ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1xr7k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:07 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhV027847;
        Tue, 21 Jun 2022 20:47:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JxiOy3zRFHdbcO91wlqOCeYd9HH4wZzaDB69LPZYzeGVPgEfuTpWwYSrfYAIc4PZ5GjSVfllIudpGQt4aXlTwIRG8Jm73wdauAhseHjQ2vtF/3QLiaOdI35kE8YxkdIz5oOFl18BoDFuGcXuIGUUFXulRyikzhV5CEpL683xsjpqYB0QmdrfjLuQc7lrtXe06NT05v60kPrGjCYzvblbYnh/TQNGK7zg21PBEPmLGJtiWtxDGWTuvTqVrRijUXagTNKOTC3v2DQObPLX/8lzfanFrawcMDgJ7qJp3XmcvL1xyK6YH2T8BrIzJ0ufdR6CMqycNIaOrpa6fC8M+AMBMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1HPgLoQZBDBwIGdM1+dtC+MaxiPvf/NQciy81idY8U=;
 b=XnU/dS6b8c+63epv70sK9iWnLpiMXWF4RrndesbwLu//hPfs+8q4OnVEMEG3FaOnB0fKNGL7b4uU5mnUBDAOcXBwJaWcr/9Bs+63xz22mNCTCWBKygjRFB8ytkeKXarVWjX26fafsxyvn4zxno5XqYcEliHfbMJinR+a3aj6SDU5LLUgEEGn/AVqDUpNK78bfHVu1p69StjiBRJXt0NLAsgEDARIpMJnoDryi21joJ3NNl8HBYeP8TE3A1rQqaHT49RRbLnu6ahDZdY/bn5yqtUHmIpqFRXLo9Uj7GV+odoCZZeMKBRF34Ylax4nCj6F2wFSo3WgGBo6H798Nf1Kyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1HPgLoQZBDBwIGdM1+dtC+MaxiPvf/NQciy81idY8U=;
 b=R4N03g6CAme74jycquSEVugkbGeOxYep5SGO2qcTVlMoTTCQgbEVKPa260Euh93BeYKT+pcC22TnEykB1gdwsqX+VnGjq1W1CJeQX8MJXeEhyk1Qb3Bwi1U4Lxhf6OLDPk+/scmVnRDJh1j/95GSaqg9OzrGrQkUC04YcehBlOI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v10 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYhbAKPwckVgdT3kiIP9lsHoyywQ==
Date:   Tue, 21 Jun 2022 20:46:54 +0000
Message-ID: <20220621204632.3370049-11-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6308f77-d349-4c65-7e5a-08da53c73137
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB3085F0FCCF7FFCF571490ED2FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /Q8onWQTRmez1FSaPcuxdOXkCBQgUQHsiRZFV/jw2ESNg840aLsG8eqNL9H3I7cKq/XWS/951o2Kvv+pCDzR182hzj9R15aULn3cVTtrL9JIS59WrWtK4kHQepcLUViLxDpkD0NAK15ANj869/1p/cG9uQlzVKUbYR6HNVxWG0MCqG4tvu4zBQ84Jv3J83BtDWBtnDaIeTvX8z5gqj+sdYIw4J7T68KA2NBVRtS3w9l6FbfdNtj/FIs89N+O5LYjWYkcW2BXYXqt0dCyT2/rlM4FMqM0vbOXd/5LDzeF9A9CGON6BTC592Q8QKHVgcYo7GS2mJPgZXju14fyDJ4YADwJLjswx4BK7irj4Uoetqpvj5ks2NqmX+faZRzAtfasgXrDZkYwFzJBFBEmgxlhtb+ECe/EZGFMQ73v5nxvx+/SqnhfSsWgFOHKDTpQ4XKunEhCcSOPaCM9bKYYOa5DKsu1vrkLscRgQU2V07lLOTrlcfWIpPQM4K3tfjLROcYaek4CF/7VNgIoWUv1l3zGXCHba/d6Y0eoYH3w4soU4hDh0w7aTDd71BDHDXI6NxV7tYfdEsX/9Xx7J+2/+3wGef+m2mW6WGwO818sMalOAZc9qXEbrb0U6KH2/bdJ4+8dpUIT0lBKGFa1536v1G5fOmQ+tt0/tuE9T/nu8+BLcrUMrDvSKIwMSGHpC3gdK+lK46AwJI6NqDmnpJgnuXz9BVK4OQrdNfzmmjH0mkEV6RGuvrIE9sq9Bdu9O/BfwkZRut6+snExhMW8yhQdr/X9+Y5YIrwxLEGizT7tkVw+IOw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TKob0d1HYVMJb3n8Q0/szE70E5Xu3Kx1VVJe6x+FZi/TRvtlcxePWLN/fd?=
 =?iso-8859-1?Q?rl2Iua4wbe/lScdOhUhdtxL1JWHKAcvnAhHoRliGyW42M9A7X938wh7rST?=
 =?iso-8859-1?Q?KewZ7TslZrLmOaetlStQNh7v5TNRE/ACulkQ0AWZTGMbE4hiu175oVHOl/?=
 =?iso-8859-1?Q?4eGh7bUA4x13UeM4lZQd2MjlGyWCSeqRlR1EO36lId29jAXH5ynO2zRESB?=
 =?iso-8859-1?Q?TBjb4k1qoTE7JVw1DkBF+WdxLx7TvurBdqDQGJQuu3OxcK+wdJuND/MYnU?=
 =?iso-8859-1?Q?hZju9mArV7cuSvhC47Ee735/4Ut5q53OwKUCDvMOyZ5mPR0SNCDj7f5eqE?=
 =?iso-8859-1?Q?pNwfmsDeiGzAYpEKlWCuTO39AptWMjs4zRsBSjD8sMdhJsrtZF+uMEIgNo?=
 =?iso-8859-1?Q?9DR3YHliJ0qPFW0Fpd9ucYk5EhVXANQf6NT5mJwwiiZb05dUP+lTdtoTnH?=
 =?iso-8859-1?Q?EGJxMXb4N/RFANh23kh0E7gIHiMgtiODFgHrhA9cX3vk+ZxSpGMl9ST9pN?=
 =?iso-8859-1?Q?pEeax0re67ESN/SVP6aucP5fOGcBfT0pqFoiBQkCOQkP44DgY6qP+yyT9Q?=
 =?iso-8859-1?Q?Eq/HXNdyluzewTc0sE4lsjbE33P4SdCuYP6wJA+ExGH7Va/dzYO8KKWCYc?=
 =?iso-8859-1?Q?N7fhj6cnWY7/rHfodOUphaP1qWp1x6NP3S+DDJfzVQdGRbZjbsLG3PwyvK?=
 =?iso-8859-1?Q?4zNsKzn1Sdg2euqiRSXADrPUbwYQXvGze98X/1Sah5JglgY2q+i8Mow9w4?=
 =?iso-8859-1?Q?V0YXEJOhjuA9EELHMtVzyE8m3/QiNrVRbboy3baBelAcIy0o4kl3sLbceE?=
 =?iso-8859-1?Q?g1jP+xnxOZ9pkrhd1KoUmfXcPW+jaV43xJahqH+OrymAYXL7aLuDn190oq?=
 =?iso-8859-1?Q?ACL6GRXHEv6omFmTSGc0jCUXxSX11uDEPtQYfH6l2334HLNP1ayw1GjLeR?=
 =?iso-8859-1?Q?FEdfT7br7kOo+RkkBp3QcU80B5jyN5FkFWzQABCspcRDufkJecXxaTeH2I?=
 =?iso-8859-1?Q?LAqQSvntEE+aktNeDMALkxdAN2btMWFta5fqywYMW9V7D1v5amZjVtGPsh?=
 =?iso-8859-1?Q?Vbpql6F2xTVYbJJc0WzD1wePf7xK4fLEci+t6Mp5f0MRP1t3GzJSe403G+?=
 =?iso-8859-1?Q?l1yawFjk9C989Xycqep1PtR62McoCzMr740njMZFCZFjo8erXGkePNuojK?=
 =?iso-8859-1?Q?9bycpa+9aY549UitgG9dUvK+PIfynYyCdy+Scq7OP6E+YHkjeXfGLo3tw6?=
 =?iso-8859-1?Q?tYFtKBFzKX4/a9m7xlfwlDW+yFzE68UdUCC8BV/DkMeaG0UEaiOu1cCrAu?=
 =?iso-8859-1?Q?jCpbIrPZwU6mjxL6zTxqZ5K/8T6furqKCdbT+o7S/7xDd07/3MrlxVz/Cy?=
 =?iso-8859-1?Q?FgHV4TRtsb8aMAHhitWibhzjhAuca41D8bQYz/tQuhzW5GEbjFIoraovyc?=
 =?iso-8859-1?Q?mXx6cJr8MSvHlMGEaBdz8aqX7bk3onuHjSq3cvoY1lt4snG8wLWv1aPMh0?=
 =?iso-8859-1?Q?Kzj99MqsazC3T2Ld1cn/t8XtADnspHXgEdOgGyU5gR3K+ENO1lo+Sh5SKl?=
 =?iso-8859-1?Q?5fzLAMK4DxCBtxjSmZ9fU9c6uFMeNCFlbDoZRkPHAHlj3v3ShxzdO6gxJT?=
 =?iso-8859-1?Q?AKIbYA0m+j2YrNIPglcqkrA9/11iFw6OvKSlzLb68/61tt52/L0u6bRAjQ?=
 =?iso-8859-1?Q?0wWdciJOAKJaKNlZGKUIIezFUakvwB0rFO5FZYkYwW+8vYme/hFdiu1WJy?=
 =?iso-8859-1?Q?zqazF9UQvuxBmlK9bucmzqax7OF47lEe2QmYmlufF29RJTqZb8NMq72LxM?=
 =?iso-8859-1?Q?05B/fGaOQHVeFNvXoDiVBYaY4fXeCZ4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6308f77-d349-4c65-7e5a-08da53c73137
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:54.5668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wOLvsnCBA3w0ULhk3ctE25HZ7GpiZISf3jCIA8rbvShwBcodR1BbZmvJvdYqbuYVcxM0N1Pu2Ag9CXvlutGTww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: Ch6R9lmp7jes5X1H8FXPeb-yCU9vFZdu
X-Proofpoint-ORIG-GUID: Ch6R9lmp7jes5X1H8FXPeb-yCU9vFZdu
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

This simplifies the implementation and is faster than using the linked
list.

Link: https://lkml.kernel.org/r/20220504010716.661115-12-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6be7833c781b..d7e6baa2f40f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -675,29 +675,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
start, unsigned long len,
=20
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-	unsigned long nr_pages =3D 0;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
+	unsigned long nr_pages =3D 0;
=20
-	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
-	if (!vma)
-		return 0;
-
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
-
-	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start =3D max(addr, vma->vm_start);
+		unsigned long vm_end =3D min(end, vma->vm_end);
=20
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+		nr_pages +=3D (vm_end - vm_start) / PAGE_SIZE;
 	}
=20
 	return nr_pages;
--=20
2.35.1
