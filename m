Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2BAE57ADF0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbiGTCUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiGTCTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:19:18 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C17A67596
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:14 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K119o4017919;
        Wed, 20 Jul 2022 02:18:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=cBkBHOmygAX+25E1ukSEan68MQoRL+aUWPj3WDJYs4s=;
 b=zUn/PkOeTKu/covUedzFyJwSJhxvQ69qrlvgrjWRzoTf+U/HBzcTIom7maKg/OwqVJJ7
 rdtjohSDwjQcGGtFlXLp8Y4B6pLme7JueAWivcI7rROumO5axg9kDZ5nN3E7Qcib8dB7
 wELUj67qQvB+qt9rPQX3izk1FEkhet3yMZhqCj3SbllloMgDAl4UI5qNawsESgDbWgNR
 jAEnA4f6OQznzDvHC1LXtFnDYsyq5R/pxeaqixSxMpwgn8WLySlImnKuuM3VsuCuQN4a
 sc9lLH5U6zeogqyx6IH1NxGc1zaPzoz8wuQ5uEdkzvzJShcscd5/3+sNygtX3PlstAGS Hw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107t6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNxcPx022260;
        Wed, 20 Jul 2022 02:18:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseaqp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmGZz26ciAGvFIGQAiyszDDmb/xmVXFmhLik5L9Z85cxa8ZZqVi1xS8pO1I06/CsnC4GnIuFyv3l+Fgwlk3QYLXa0sJMPPwFwzpZoAwvFPBPUmqMykuZ5LQ0aLpRIgrbsVISYZRtwzNipN6G8WqFvruqY+tN0H7hdrAZDvzHlz18UvA3xSPF3i3yMErSz+WFu/CH6s0VsOaPCtveC3WBUdRoOIJbRGWl9zXhLpZLhqQtO+BgOVk7Ee/jhHJHPiSVeokqjJ6PtDp0TyXDVGHJXVak6Xvz+iS+YRnvI+BdlvAIeWI6uyi7MPZHCk30/QQL2dj0shDVfstalcmWtKc6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBkBHOmygAX+25E1ukSEan68MQoRL+aUWPj3WDJYs4s=;
 b=UVcKvC2qJ2h9qu5uAKdQIQUEWnKJjaWNBDjfJA48GIRd3MgiFzKK4mA/+wrgkeTKtlJkBEU5W6szKzVvlO1fHzgv4QVE9++PQzcTfYOW1kaWLbBM23kmaMH3pN0P4UbtRSnvoQFF8ys2F7Hm9bB9msYSLm2Vqe+PVHFkJu7jN45tZAsrMbw1ZPJv4+mz3FwwoEML8cK6jfcjvacX9C2lWz+Smltg069pb7OS7ZwFST0l2pLpvvN6VeB8tiURpp+UWZtLSHCeUGnDTbRfE/USxPGhrfwA5w5Z5akN1EJuRw/LjObYsfT5yI4MhMIFusAooE67X6VrxW6rg6XSEjrGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBkBHOmygAX+25E1ukSEan68MQoRL+aUWPj3WDJYs4s=;
 b=rgclyEm0Pm1ICOYO8Ej6nD1uaif5xmwc99ihDV6RSnpGv8xhmBklbTDO1J+XQPeZcRHeGeeN8I2pfRvCrBFT3h2E/9O8b5BLOwRMwLEt5ZHS9uJqtjxEB1S7XJZF2b+7wqE9osWrbJxoJSXzxzlnUvc9oCmakoUD+I+DnaXIIWQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:56 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:56 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 24/69] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v12 24/69] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYm97plDcJKVB8vUabWXtRJU8RsA==
Date:   Wed, 20 Jul 2022 02:17:51 +0000
Message-ID: <20220720021727.17018-25-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20db6a79-9275-4167-f55c-08da69f60ef3
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zOB6yi8H6DrHMnE8wCImLMMZBmSVEP3dr2dsynG0S3AO5Fj7ua+KV+/Lt28zJs3QFpLpxUL4FBfqu5oPcnn2e9qCYOlYglG/9N15ZZsKZuQF6oeZJHwaUvlcsHF/ftKORkxjBhaV8GaY0M/PFZsVClhGeHs4cjcD+BiXdhZlF6T/dzrMcj5aLRFE36H3aTa0exAUgxXpXTEPMbT6lCBIBHDq+/L9Bv/n8YU/+pm4+rvQ71Anv39ONO2cQsvxexgY10m1jRPuUmkWZ7lS/XF/zO1Z0wjZ9QjfQLkxw8uP8p64w92+qXUn+IhcjQJ/lKjF/gsBwA4DIVVmtF2x11Z7LYbSyrrj9WocnxWU/ov17SHXCrpMmkOmSQkFWIdCjtQoYnnJStAMcL1Y62nrdxWYKYTij9XzCriFhr05sYuvwM3Vq7oNuy1fltzRsCz3ZM7gUZBcM8hCY1Tkj6X+QRc5MNMfyQHkZ9k51lX1lgQIkmsHVaPZcqvbLbhal844Swb1yuJ5iiqqyepkonliZ2ni58z8UzrpDxLW/TTpRBLiSll8nulC2cAamiBUeOl1jpMY3t0w+DUCHU7spYw+Lxi2MnmHZDzaKn8fz/XoJYqrXaYB05HumV/TAOFq1frPS/I5zlWum8MJO+Tm2Gh+AsBy52iBNnwICH/y5IzNG4dhR095dKON/WbGu7TobVV8NKmfyisMGQf091zn/8wEh5Tl20qCj/h5ZgqEAwFfvUZXZX/DmbhlrCWhpSQubB5WeokmM+fJVz+G1RU6utYbAab+cQP371To68jjAC47SZ60CKXWhxUSnyiVkKH1R0v+Xmkw2/CnR9OPhLk/kYQCuwZDZDtmcwLwSrLgf2ndZCeAyjEsQ8TGWJlSgz2q86IIlzL2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(30864003)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Fa5WN2EiaLLkZN7xJYHeZt2jzUF2t8KI72zASJPTu0zhLEzlaE7DMvOBZi?=
 =?iso-8859-1?Q?MiVGxYpyY9j4bbvR/0OFuGvbEPaSNOs/hHqlI5fiHG1SMSiFOoDCV7GL5/?=
 =?iso-8859-1?Q?0mazq5pgE0JTCysXwqO5hBTq4x6z1ZK6AjjSRiaq9V8c6BaGX49q5fDfZT?=
 =?iso-8859-1?Q?+doiKQVEQpFyfetux7cYdnFiBInZZnC46rgzrBZKfPgbsYdrl7x3oZVKo8?=
 =?iso-8859-1?Q?3owdeLwP2YHf6swcIsPLBI54CD1422xwCjEPq00mbW+kH+9pB8Tq54wPaR?=
 =?iso-8859-1?Q?my6fV1rtaaqQY3HPxXXTbu5/kOreIa63TeF97uE+vqaKc1oSg02UIcZ1r6?=
 =?iso-8859-1?Q?TwB85DvCELDnllB1Dtr5tlKt7n3gcV7cN3a7RXrDxgToAikFWXhUG95Uv8?=
 =?iso-8859-1?Q?0eBys1Xp2PPUIGU9BBTvcdXD9LesfjsgzQhCW4cBYiO2F630ayG1eczEm8?=
 =?iso-8859-1?Q?4eXucrU/M/+putBjIxnB0OOPRpTSIS7psf/Q7FOmZw/J8XJHBEH8XMldck?=
 =?iso-8859-1?Q?BK/Swn69AxKkNltiSix5lOunhFS2hmZM5Pw2yVFd331o5wl2hqduMlADb6?=
 =?iso-8859-1?Q?J3pGy4HyfMuwtsXODQdfbZI9xD6nnz/t3Yk4ypzMO7HuRjmhHTuGwUL7tq?=
 =?iso-8859-1?Q?klHH0G56PJZ4d/XXAK+5Admj+14CSX6Vv0c01o+7kTb118/uwRkxeX4m3S?=
 =?iso-8859-1?Q?RMXjor9Lsw12JOLugOEk1UP3MMPZDfzN/JpWwDRl6lw3TlRsy7IuOzT0JJ?=
 =?iso-8859-1?Q?FX4gUXx6Me+cHbQqUlo9mSK3Ye55puaTBjGOq1DHEx6sz+mN5UoLJRyZh2?=
 =?iso-8859-1?Q?1LXe2s+vfBQcp8THvG2Qt2ZLCQrkqGv1j8ljWgKn+ByPPUYYelBtxFaBE+?=
 =?iso-8859-1?Q?DUGAmpXIN++pQDEyBn4pTb6bzgOYmELdrP8UeYGQIwz838TJ3vu3Tr3TPY?=
 =?iso-8859-1?Q?yvWyhYXgwWcCi1qcihfqDLVKz12KMbdP94LY6Hwkc3j+/J8vybSqvZPqq2?=
 =?iso-8859-1?Q?8Ctt1kxO1y5cCe7uC6MbT2SVQs13WHyhtvhk2ayOLtcKpq2yzBSOA3zMIr?=
 =?iso-8859-1?Q?H0fP8qzDouo3n1A2IWUwpIswbMuNbg3G3KBC5PW7Uicglf8Eq/ptYtHOLX?=
 =?iso-8859-1?Q?fUPzBcdRIP23fn1BCk7O9jlWoP1zOcoLs9HrieQyb9Ka/cVAfhiAZ3EdBf?=
 =?iso-8859-1?Q?YS98Q+l60qKowIiRLyF1vIIKwpObZyR5lSdQB2Di+4iN00+84GT5aVfngy?=
 =?iso-8859-1?Q?0PGjNxGqgKyX9Q7K36k/0DWyoJCwi3jqUYeGTaPzENxZKKwGbEWxwgbwAM?=
 =?iso-8859-1?Q?kvp2GaQg0SlTOPjRa58wM3in0KkSjXo8It9tp+LEnGYCVkLvg6kVjiiqbX?=
 =?iso-8859-1?Q?hg03aWd8s9Bpph057oWoyAvDc0t0QpsLCnO1mYf7DR2oYMBn5nVKbahv9/?=
 =?iso-8859-1?Q?ogqeQakpbhnBLdes5pDaC7kl+4pWDMP59Mp4sUmlv02zz3eGoo+ItbgOSF?=
 =?iso-8859-1?Q?VfU+UyNAQuRbvKbJTQBzy7O+U2uOZs/hccBmw9xkBWmFfU0W8MkxSZ9O1t?=
 =?iso-8859-1?Q?1nCbuBBGZn+t3cbHFuHp65teHEhJv+ryKRh5fYFzbglM6vdDHuFU4A7feq?=
 =?iso-8859-1?Q?ttauB8yfi2BbmFD52uBwM8ILLSlAbhJnVsJ46PifwiXm2xHgrdNaaUJw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20db6a79-9275-4167-f55c-08da69f60ef3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:51.7434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9ZKUqj4IuoCsmg+e/md7ZLvvYl2MOZeI3bHyJKVcuQ7kP36uKWOtkF5BR189jP3tNkoe/fBk08FoJiNLN816g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: WuTrsPWDe6bzBEvl6Wf3vH6ZmOihf0EU
X-Proofpoint-ORIG-GUID: WuTrsPWDe6bzBEvl6Wf3vH6ZmOihf0EU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Changing mmap_region() to use the maple tree state and the advanced maple
tree interface allows for a lot less tree walking.

This change removes the last caller of munmap_vma_range(), so drop this
unused function.

Add vma_expand() to expand a VMA if possible by doing the necessary
hugepage check, uprobe_munmap of files, dcache flush, modifications then
undoing the detaches, etc.

Link: https://lkml.kernel.org/r/20220504011345.662299-9-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220519020341.rr3s6b4dr7o36cqb@revolver
Link: https://lkml.kernel.org/r/20220621204632.3370049-25-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 251 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 203 insertions(+), 48 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 636a984602ad..3b140ce313f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -517,28 +517,6 @@ static inline struct vm_area_struct *__vma_next(struct=
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
@@ -665,6 +643,129 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct ma_state *mas,
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
+			anon_vma =3D next->anon_vma;
+			vma->anon_vma =3D anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_BUG_ON(next && !remove_next && next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+	}
+
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	if (file) {
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
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
+
+nomem:
+	return -ENOMEM;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1674,9 +1775,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *next, *prev, *merge;
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
@@ -1686,16 +1793,17 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1706,14 +1814,43 @@ unsigned long mmap_region(struct file *file, unsign=
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
+				       NULL_VM_UFFD_CTX, NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma(vma, vm_flags);
+		goto expanded;
+	}
=20
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1726,7 +1863,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1747,28 +1884,32 @@ unsigned long mmap_region(struct file *file, unsign=
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
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
+		/*
+		 * If vm_flags changed after call_mmap(), we should try merge
+		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
 			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
 				vma =3D merge;
 				/* Update vm_flags to pick up the change. */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1792,7 +1933,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev)) {
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -1800,6 +1941,22 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 			goto free_vma;
 	}
=20
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
 	/*
 	 * vma_merge() calls khugepaged_enter_vma() either, the below
 	 * call covers the non-merge case.
@@ -1811,7 +1968,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -1838,6 +1995,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1854,6 +2012,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm(mm);
 	return error;
 }
=20
@@ -2675,10 +2834,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
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
2.35.1
