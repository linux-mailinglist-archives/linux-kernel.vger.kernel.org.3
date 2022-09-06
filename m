Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF4375AF4BF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiIFTtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIFTtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B3AE985AC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdbYf029984;
        Tue, 6 Sep 2022 19:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=DlNKLbKaGZRxitRZ8jvB/TyOnLy5wqHutYr7wCgIIfA=;
 b=r5cFJqWSqoucf/BYO/CvHeaEKGeok+gtHHTEmccWw7Sjn1Lp/dSJvYymIZIfeUAPfCf7
 sAzlmE0m4CQ5N4atJYx8Gyzvli1Sf48ghvLKA1vqnnN1RaIFS0v9fErP38ahc1VY5ik7
 HPQLcvi4BNrsYjk1cOf1y04idh0S/SWFxLMfI/cDN2wrfnkfp5wlRFaTtEmplcyxk8hA
 bO8qivc3Gn028uRjIp53CN3s8NZSZosEnMVeMpshiPVFuKBGflqG38GjCjFT44Pu4RIc
 NSYgSk8BuUmndCSSknflo6e/FZXL/KTVhDOuPjPtdQnJUxTrHYFhBW1qMGpyQoXI4DVl 4g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvah-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8KXM023727;
        Tue, 6 Sep 2022 19:48:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kr9w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvT5hehI3rrZrM9l4vcegw5goV3b3J1QpuwmRop/n1IUcivk4sLx7mKjyU6qoKFIaeN4rqChYgXw9XqGcS+9TZDCH3wsWo79OIaQdP+CCgl4/GxxQ0RvZt5t2DGZLSkiIQDzT4AUt1bQK7qsn54rApJGOUUNoM20jIoefCMj4aabRDIrEQROwO0biQwNmETkVFfqE3an27GzwRwW6GYvd6ez/u8HcqJRE2bvYB3GMclAqbjisnCBEkXOanEdursL39A8bqtvCkw3avwOOFH74Bx8Dyx4te1QA4WNt0himGJPX9qzagBNQDYCNfFmHtspWcvxCB3szkd5vrtOSsmVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlNKLbKaGZRxitRZ8jvB/TyOnLy5wqHutYr7wCgIIfA=;
 b=np53SByWcEXm0gtjxwdavTr8qyp9G3ID/A/LPOXpHuhUOxDBjFaL/M3vUC8RLEJ1w1ANhEbyrcwxiT835TMbnO1ITSwudKxX2cMdoF5nsAs9/f2YhMuOPBG+fCRsHx+Uf6u1IFT8Wc4LelPnVnSdzXzYPqXQg90B1uOAPj8X+x6VbrD2xIAIM4GdDNSb7fZcb1UHEE8zOAm+BOWRHiFHjYoT8N397+xID5lpio7XJmof1qU9Cw9l4etEksjW9OeY12aMo9NpGBSIE0l9RynGd2MXbc3bFG+uIJgbJ/GBc2GTijzlgUvz2LMMtK9W2ZVGi8L6ntvRa1fFVp2MZsIB2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlNKLbKaGZRxitRZ8jvB/TyOnLy5wqHutYr7wCgIIfA=;
 b=PEjzciZr7MnnaCGdNYRSR+TRIUIph/FpX/g1dIdPVzoX2oSz9rUenEJDwbSVf71Ll87UEOqXzcJ1BSKE3Wp4jvYCAhLGSk7JdcciMaUNV5gK+0U7Kz1KlbtKkrzss9JRtiSzCAyuBYM3TCwiNYtp3TV+xUFK+mZlb/DgT3UWjOA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v14 11/70] mm/mmap: use the maple tree in find_vma() instead
 of the rbtree.
Thread-Topic: [PATCH v14 11/70] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYwimtFDD8ED6GNki3AfZmcbWXGQ==
Date:   Tue, 6 Sep 2022 19:48:46 +0000
Message-ID: <20220906194824.2110408-12-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0023de7-3da9-4dd5-c23e-08da9040d2ea
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1qMUejKNprFmFWtkMkmjgNNeDiFUVO4YTbwH/klnMlbGUXGm/GkBS1yv2AwGb+rdZhkKNRFPFhmwIE0HI3OX8yzcmwExZKTq6raIm5aE+3WtBkXpDiYd+o8RYBi0Yo2NA5LhrRsO6P7q5p8fyJJJx5s6lci21BgZFq5uz3Omby19ukDnKJXjXpnESfrjQmPOmn0yvzFW3xs+QnENvZ12A3gEDiNm00HUL+ECgwsJ/WRAzjc0A+rbxe/bai+ZcJ+Zq7rXFY0XZZanDZ+UIbDPl+94e0SrRHnJqDe8ILK9XL7X+hRZ/a1bbLGd7Y2g/XHLi7mn9l9pUufG+cbBO9GMUaW8wUqLRaPEoOIAf4ddxZSIjzY8Blaqe6ho6FEi9zI0BwrCXxlXQ4TOM8Zhx4E4UjtpCvVeKXKzMMnUKIV42M2YZctuHxggHBdcnDohaR9NFwuS8uHlyOX356oVkrbsb3WRTI6U37JZzq7lzrllJvfrgQQfErdtipUp7jSt1nlCtr4Twn8UX3JLTArFhAuUFF2QFakCJylvJqEacGZ7uCX2VrMX2OSnnghTNz+AQSil7pweCqTLyfCxQw0nkKPC8AjWeE2KJ7gkzHWm9gupIhYnAmQVmy5TvQcsv7r5f+/zpAne1FkQDYDLOPlFsBEMo0xpV5Ww3w2Fvnb3HTbdoE2tdU/hMLZi/3CP15Id8crAc92x7VaSYSzdXNiY86292YIOiN0aTtp8sxn/BEFiZfB14Bdhdb6EHFdgJzg7XhSHosJcPDazm+8fe/sC15p7EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(86362001)(1076003)(110136005)(44832011)(71200400001)(6666004)(38070700005)(54906003)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Kd1xd7CMtOKO1IG8R/9cZbRNXlBbs0o1OHBDyzzWKbJEJwwC4qzlx3tIXI?=
 =?iso-8859-1?Q?WvIt9kucLwZ+t1QYejtRJZ3cgajH+SgOFQG0Vb2VSAj6YRGo1QfPwiLvU7?=
 =?iso-8859-1?Q?8nDrQNqReA5Uw0xm2Zgq5hCDLb+P4lfszlvZccp0cv8QS7Hc/v33k4dZ8b?=
 =?iso-8859-1?Q?0nBLU3h5tj2mJyheAc5jc5blqBoh0TNwIOF3K3PiYXUJKW9yt2kQ3AcwDc?=
 =?iso-8859-1?Q?qfP9/pg0+Jppt+X6z59Dw0qm04h6qIeqojWWF82TZU94CwWqOOcuAmEliE?=
 =?iso-8859-1?Q?rxRKVEymwHFBjO5KJVdgmZrxyzQK+b/9hlFJAXfcx1HyE1+k4PboHu9TiX?=
 =?iso-8859-1?Q?2us+1At9GUxGcYvPWKwCMGJthaAPKAZ99DwkJ91qdNPF4q+MP8qhqGSc3w?=
 =?iso-8859-1?Q?U0439EHbicB6AU30K7ZQA6U1QerXhViFrcRWkKFNU71ZOE2xBvkg0xFCn6?=
 =?iso-8859-1?Q?Q0ZYblFPFNd+Uyq/u2gR9drvjf3nq9AL0C0njRLdxalfFnjCqQe1t/Mlgx?=
 =?iso-8859-1?Q?x+VWHv473P/achRPwXYCj1iZAzxIQQpsGmptoYLfFB8tsgOWJenphlScwl?=
 =?iso-8859-1?Q?LcPMY43Th0XkR5779zrzYXn30gTjLs0yJTTss2kTfk0yWuItGp0uakk6xP?=
 =?iso-8859-1?Q?DvzouJgO/z1sxQTojJEhi+PQzHc0Y/NzGIiWbOdIRP0uUcVg3vVFOG1zoZ?=
 =?iso-8859-1?Q?rTGbW1LO92VBXcqKt8zRelfLZ+QfSkzx1MfhiO+CUd8xcqzLEjzOpzVG6E?=
 =?iso-8859-1?Q?VBiS3K6D2KBXGBtQ1ohelZdC+FXeFQ488FO6VX0V8+5oe/tIvnSJztHydH?=
 =?iso-8859-1?Q?mJi+XeWFGPGZHA9mgIPuXVHDhhGwL3D+VvTWHunielRrZD7jZE9+aoHPAL?=
 =?iso-8859-1?Q?nG7pIIxdaIMBUGm4hfGBuFdzjA/dF8HWZI60WnEnBsJTARpPfSZ6bJvBRd?=
 =?iso-8859-1?Q?VtYD8Ts7PXcgJsQzEJJa9Ssr1AlvZUof1dkhcMQW+D0FobnbP1kvI4cofb?=
 =?iso-8859-1?Q?gj4bbmMwpNb6EtoOY6m7TTa9WEZqAwJ0DXgATxD1yMiw5vTtoonz6djZ2g?=
 =?iso-8859-1?Q?p6ntM0Duc0BSkKHt51DTqABEapi3/Dd96GIuSoPXq18l7uMtN6Ix1nA7pQ?=
 =?iso-8859-1?Q?RmqGGNvYdCMmLIdecn7187oiZzqA897P3z6mcNWtTRog+9JKMKjNvmwDdh?=
 =?iso-8859-1?Q?+fBsihFx11Iq++3ynihmqSbypjcSmOGV7zp7UsovaHMI2NzM0q56SGp3TH?=
 =?iso-8859-1?Q?ITI368LfrL7AnPqO0cGlEO1vPCIXAhyOGtLWqcFWbW+Ew26tZe5axpjbvo?=
 =?iso-8859-1?Q?eJscHWItpFZxT7pcqB6ddLEV50lGjtOmbN7FVyDDVYMARipgtyEFfApliy?=
 =?iso-8859-1?Q?jcAsnniKP7nKwkb2tRu1aeNzKAhuHaWwVex5TG8nRPUBHZLFiBiJdcqCzh?=
 =?iso-8859-1?Q?3M5jSNxu5s145qaZg+w5y4FNzCg2xFpxFQLyv3FpJxNWtD/Fm/a4ygO+jK?=
 =?iso-8859-1?Q?+yxGKKUQ/7safjyJJJ7kwL4CgrEHfdMXMwgG8B74wFfjpXhbMSXQpUXGze?=
 =?iso-8859-1?Q?CaKK9n+76xaCVdmWiDI7MP22inT2GCBiek8lhzZUlsZfmNCPsAAnyEurcd?=
 =?iso-8859-1?Q?T/9bofLA4BmCetIfow+hOZpgXNylFu3GjOW2/qTcDevf0KFbCqYbs0BQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0023de7-3da9-4dd5-c23e-08da9040d2ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:46.8194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZdWkS/Rpkj36pFmErK9VbKe8Is6oZTXtY8T5WQmWjXkbZGAmoKGPBoLdqt769pbyoDEhdy0xzC0ofwGRQU0yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=836 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: GZmpDEkLUa0G0BYFoQQLj1L20KxoaJcu
X-Proofpoint-GUID: GZmpDEkLUa0G0BYFoQQLj1L20KxoaJcu
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

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f1b07751a1e4..dbbf8ee12f60 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2449,11 +2449,18 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next VMA.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next VMA.
+ * May return %NULL in the case of no VMA at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
+	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2461,22 +2468,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.35.1
