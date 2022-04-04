Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF534F1727
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377970AbiDDOjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377936AbiDDOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01933F891
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:55 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DpNE2014737;
        Mon, 4 Apr 2022 14:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=fe3RXsQEcjkVbu6kOUngRhnERrNXxe1LYTzJRHyKf9M=;
 b=G+6j4PucXI3TPyKK0wd5eaCba5nS9YGJCSN33XkRbCxzrFQvYlXhoX5kEo2wlP487MRR
 iCce19ZS3f2OriXkuwLmfcDmqtZt3mgBPOeGV6QIeXq9xLWSbGFuYfzA9fjoJoNGfY63
 kfB30cm6C0ctbyf/nxQfQhujNVE5ZJBoJbdaZsYmcIiptfPz88+L4cmWPqpBJWrYCHJ0
 fxJx6GNy2DHeFvmpNZdZ7LTPJ+ag0PPR0ljUJCWaLQpAwhkIMCcO4fChJTCOyIcKPwNZ
 gwa/tPP0S53AMyr1tptyqEsh3/zuejiZajmGCFek55gzvL4wV40X/9Ty4snYYfUDckUn 3Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbuh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:51 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGkPg033647;
        Mon, 4 Apr 2022 14:35:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2guqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dswc/YCmJPF/pOWmVZJh9qhgMMtk+lTGFoBLhbJkoX05RW8n/v619ZGYZ0nznuiKl4TwZM5aXt3yySxExec+GRHizvAQbd9XAkPqJ6q4F9C+E5nsjcaitS9aoasUQuemiMZ3nFX1mg/vcYwG8OVxW3ThCeXq0OssF+owmnwpeIUb/f9KFDYi8vJlm4j6HzvoaIozSz9eiuMjMaKd7SiyvzxpLeKXVPMLBpDpHGVuctYTBdkaPehD74++mSKQYuup98Tgx3ypVwEgcIriqOPxIGQTY3pND8hbKoXi9fxZ6YCtW2Jdnq2m+UIUQHTVBFKUKNd/ozRoWETnWC+YkWZBWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fe3RXsQEcjkVbu6kOUngRhnERrNXxe1LYTzJRHyKf9M=;
 b=nLygdsVJAHUqavTuCAk3nlI+sWcoOm+Fbs+0+4jdw4QuPe3XruR4N7D5Wfn3G+nYFMZ6SSpubLKCYRpu9LMqy/Pmvse0gOMNF679Zl41OPaS0zPyzIxrs4gRmaQ1S8t97gfgkQ6O43pyl4UT1Ew/vh4oT00mxmeypL04BasqnTMunAVT6fHcOrTsgHRNIXHO0n66IXTaKTU+Kd6fAz/e5r3zjrPTXqpGJnaTHFzCzOlBI4nlpFE+DGf0ZFcSQgsMf0TB1ljOaJNpkXrNriyPLzlqNbfAO4Ejfjeih8cNCpWkaTVO93gYyp5R/cUinSgBS9GzLs8Vj2Xq1UWI8QM1Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fe3RXsQEcjkVbu6kOUngRhnERrNXxe1LYTzJRHyKf9M=;
 b=vfAKYcVK2HDgij8UKpaebWxJiFgx9qubtm8dKz/zDZ7KBVGkFblF+VWINNg/IQbqZm6oLjeBp+gbIrVRzhfDSdM0af7CYD0V/eMLEjBhJN4KWmWLPWPJL2MRhKCt5Zv3Ys9seStzIoZJrlTIHXS6emn5H+OV1MNHY7I/Zz6lFdw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 26/70] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v7 26/70] mm/mmap: Use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYSDFDzZid47DekUecu9wIMdQJOA==
Date:   Mon, 4 Apr 2022 14:35:43 +0000
Message-ID: <20220404143501.2016403-27-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bf9b0cb-fbe4-43fc-c338-08da16486867
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381BFFA097356A5B7AFFFE0FDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U5JFAfJZNrjGZkqIGL4S510Zj99fl6fYCtzaCiCEPoNg2F3TGA+fqhEU6eP1NKoz/UbolfXbCcHaei4hfEiIFI6AC9Wmp7rAsCdCdWRyuITAFPWF2z1laqq2/XhD2pTXYE6m1bg8w+4EF+Gn/yN0qluNbYxkYHBIynRJcLJ59s9QdqC/bnToAHiheJCdZwooo1lISb1NVW94FoEB6bbGgNX1KNokXcIXrbmX8EjdvQuVn7f18Q8QpqrB9c5Qk9Pnp4lJ4VQ+yg/uy8YM/deBRdbMSBdb89FSC3u6dmv5JL32GcI2Vm4xvsck5qzZizuqboDhuCWhiUc0nlNCVm5YVlLb3x6Dbvqd3JkSv5Q0MoQfYxumXwy6KpHz2etFbDrct748tbwYI+A2QwdSh6+qgnw2bqqLOUidEc6LICUZWSZIWcGiN6STNDJCkr2NP85UWHrSt1FlK9nbik8x1X5gOt//MeuQ2cNMqdO2u1LxXEfEC+bKJ0XzUUccQDYcWa/Gpg6SKdcpokAnU84K6x5Tr3w5NJsuy75n2KkU7grrVBt7YctAzkSfs10M+fdck2P7K8fnKL28x06txsHGciEUeJjiHB5GLKb7n5c91msxoJnvP/tEoD1PO+Zs/A0tXcRsz+uWJamexppqXvSXxfwiuFfSQRth95LdaQmuLi+aIyxse8XClH2+jc21zu7XB6HdZ/tihgvWgoPhfKnasWiKUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(30864003)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?C9RQTucfeXVESEfz3jp9XQvya4/v0rHtaALmN+3aqMXplQJQuSxguD4fvG?=
 =?iso-8859-1?Q?mAETb/lJUAYyjhZGENFKJCpVEYgZTBp4XxFW8zqgLHzTkwsXITV/xNsNkR?=
 =?iso-8859-1?Q?Tr7aqeQdkU1UlX9AbQttwdUOvVVVyLpcjKI87dSqsx/DpEU5hoWO2J97cU?=
 =?iso-8859-1?Q?fVkNQ7lYGxT/JOUIeQv2wwka/QmFQyVoLEHYdoSp3VapJNw15V5EvHkZoM?=
 =?iso-8859-1?Q?Lgs+sVLL/gEly4ko2cTuPv7sio5imsdkreWSlpi3TeqFA1aufvzlZRaYSO?=
 =?iso-8859-1?Q?FGxHc9+rS51+rE7GtYF6CSnDJ2QesoEVFs/XviE79i9dJPnj0IyPQ92Hdo?=
 =?iso-8859-1?Q?WtB4USkSOC52+P8cRlIfk36Eq10mkQGj/LiTxAzJHBbvfehNJJhnLgDhhY?=
 =?iso-8859-1?Q?SjbqHiMsh/SYY+Yce6RZaeSu9HGG8o6TgAEcKwaHVXXQeKg022EwNvY4Bd?=
 =?iso-8859-1?Q?NM/ZK+HoxpT4QBFYiw3EitGFs3cDZ3Urqb7DhEFVafmUobm4BUjyWpbVvY?=
 =?iso-8859-1?Q?vhRTn5VW2ekMCWC4BvyWNzIb0TjzdIC0kj6UyJlpiAtgvzYreaQUhSdA0I?=
 =?iso-8859-1?Q?tf1eiv2ygzMiKJKD+Hrw6Uxe+Eg1swF+iKIyznye1yoyo31MA7Rr/goI9W?=
 =?iso-8859-1?Q?JAzqdT4PqseBulATxZisHqYS1/d1aimiFcenA/ASculpw38eJLfONdrW9y?=
 =?iso-8859-1?Q?xu46COafvmluj3O1kXhSUiTbbZaL+p4Ci0H3fZNlK+n6xkz+IthGR6Io+O?=
 =?iso-8859-1?Q?IyAVVv4kFBaEe88XrXWYejuKdTSlnrpZ+4snjNCw1Car2unyEnybZPQ4zJ?=
 =?iso-8859-1?Q?7Vwtz1ompX6TBpZrFfDfksrC6Zs4Lca5GXLuER37bnCOZH2KgzCd92Gq7n?=
 =?iso-8859-1?Q?LUnGqxm5QVTN9zxgdPlFuE+9CBGLRWElqp8QGFvZxgNEPjtyGsXCdyDkaB?=
 =?iso-8859-1?Q?8OjZJZPHJJJkS1HFnbQZ8NlRMfH1GhmHiovqKHyKB0QdF6C2ICrsfFlJWF?=
 =?iso-8859-1?Q?9ZZizsLD294CunX5o8qAYyRXEK4yXJ6jW7IENj51aEf5K81Kio1aT9UIHg?=
 =?iso-8859-1?Q?7R7/TbLe9AQDD4KHFYbHNjxPaAPVxWEqPuef9ojGJDwveYj26Bh755zIKk?=
 =?iso-8859-1?Q?d60ZuBEeCb/LMlnD+6z/q+V3sjQKR6+sB1/fkWLWoIcnsfLDy7iAtK1UUr?=
 =?iso-8859-1?Q?b2yBmzgXzmYrNSTohchdXt33OK0n6xPf5XhstgBbV4u8R8L97ONo4s/Sj7?=
 =?iso-8859-1?Q?67PrOdQYhJBpETtBq/8xTfOynJTRfvC+ZXO84a65fAp4iAv0LNqn0zDs+H?=
 =?iso-8859-1?Q?Clgdz0sZ9QCHxN81Cu7X3AzIgt9smiABymHIIh++UqDFv96hCb4MChVbsj?=
 =?iso-8859-1?Q?qZutG7+I5q2UfDvKp1Azx3eIIHau/OGWuzuv5vm06hv+RrKMSq/Um/SP1i?=
 =?iso-8859-1?Q?vaZof2MdgahG7E8BSNAftrHhiqPUxfx/bG9WUFOqBi10podbuuhyI/yR9P?=
 =?iso-8859-1?Q?aJRkdAC3xleadLEyvF9Dvi04cBsYRB2O012FND8A5fGxsCQ1q5Vd4XccRe?=
 =?iso-8859-1?Q?xVEORKioOUJ+gofLiyZbDw4BjG2yn6dA40pr+F+b3TkDWsrBil1U1lMjed?=
 =?iso-8859-1?Q?B4pwO6vYM5wcF9sumcKlJgifbCEywkiiyqfw2fw8K8fVD5PIkvEjHUmdrI?=
 =?iso-8859-1?Q?v86pvR4vkGMjSinYlPgOFahoC7IN68c5ZRv5swAxSI7jlhVm3+6U7GvirM?=
 =?iso-8859-1?Q?RrA33h8uJ/bzHzMc+4E6T3v6hZ80DEzgWK5ggbiixt45imYwMbNNH/nAI3?=
 =?iso-8859-1?Q?ghVd1IrRM/ADQR2Mbm/Ivc4zRNidjRQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf9b0cb-fbe4-43fc-c338-08da16486867
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:43.4873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gI+9mZjqBeNhTxx1nyNgugQUp1TeNKiJj+tg2jPPlQC/Wgijh7tCi556E2R/avTQIPaoG0bXMN3wTAu6NbOK7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: DQjyRXnPAxEdy7qtgwSD6hePVJUR8LOu
X-Proofpoint-ORIG-GUID: DQjyRXnPAxEdy7qtgwSD6hePVJUR8LOu
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

Changing mmap_region() to use the maple tree state and the advanced
maple tree interface allows for a lot less tree walking.

This change removes the last caller of munmap_vma_range(), so drop this
unused function.

Add vma_expand() to expand a VMA if possible by doing the necessary
hugepage check, uprobe_munmap of files, dcache flush, modifications then
undoing the detaches, etc.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 234 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 187 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 1e6a72147480..be5ecb515d1e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -511,28 +511,6 @@ static inline struct vm_area_struct *__vma_next(struct=
 mm_struct *mm,
 	return vma->vm_next;
 }
=20
-/*
- * munmap_vma_range() - munmap VMAs that overlap a range.
- * @mm: The mm struct
- * @start: The start of the range.
- * @len: The length of the range.
- * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- *
- * Find all the vm_area_struct that overlap from @start to
- * @end and munmap them.  Set @pprev to the previous vm_area_struct.
- *
- * Returns: -ENOMEM on munmap failure or 0 on success.
- */
-static inline int
-munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct list_head *uf)
-{
-	while (range_has_overlap(mm, start, start + len, pprev))
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	return 0;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -634,6 +612,117 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct vm_area_struct *vma,
 	mm->map_count++;
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @mas: The maple state
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
+ * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
+ * Checking if the @vma can expand and merge with @next needs to be handle=
d by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct address_space *mapping =3D NULL;
+	struct rb_root_cached *root =3D NULL;
+	struct anon_vma *anon_vma =3D vma->anon_vma;
+	struct file *file =3D vma->vm_file;
+	bool remove_next =3D false;
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			vma->anon_vma =3D next->anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_BUG_ON(!remove_next && next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	} else if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_mas_store(vma, mas);
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* Expanding over the next vma */
+	if (remove_next) {
+		/* Remove from mm linked list - also updates highest_vm_end */
+		__vma_unlink_list(mm, next);
+
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+
+	} else if (!next) {
+		mm->highest_vm_end =3D vm_end_gap(vma);
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
+	if (remove_next) {
+		if (file) {
+			uprobe_munmap(next, next->vm_start, next->vm_end);
+			fput(file);
+		}
+		if (next->anon_vma)
+			anon_vma_merge(vma, next);
+		mm->map_count--;
+		mpol_put(vma_policy(next));
+		vm_area_free(next);
+	}
+
+	validate_mm(mm);
+	return 0;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1623,9 +1712,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1635,16 +1730,17 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, addr + len);
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
 		return -ENOMEM;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -1655,14 +1751,43 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma =3D vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX , NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
=20
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma_merge(vma, vm_flags);
+		goto expanded;
+	}
+
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1675,7 +1800,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1696,28 +1821,30 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
 		addr =3D vma->vm_start;
+		mas_reset(&mas);
=20
 		/* If vm_flags changed after call_mmap(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
+			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (merge) {
+			if (next) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
 				 * and cause general protection fault ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1741,13 +1868,28 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev);
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -1774,6 +1916,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1790,6 +1933,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm(mm);
 	return error;
 }
=20
@@ -2584,10 +2728,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	prev =3D vma->vm_prev;
 	/* we have start < vma->vm_end  */
=20
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >=3D end)
-		return 0;
-
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
--=20
2.34.1
