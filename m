Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BFF577373
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiGQCxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiGQCwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3F025E82
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMOljG026163;
        Sun, 17 Jul 2022 02:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nNIFuIHx9MnDYq3P5rOQ6f7ayKbFRlKrGhcItY+G7+s=;
 b=mpBmTnkFNyciiBB4SiI8lLWmhHTrZSp0gP1VRl8Ne7rJR46ABlqhoszZhxQuX2A3QDSY
 STh9sv7w9SjzvtHMOwTXfJeZ9zrEgaFySQaGHo9+LkIlHx0iLA97ii0f1g23Xj4mlzh5
 cDjuoghora0vbia31ClBXAM7wT6hf+3FoFkz2f3IPc7jYJ/65ELbjZR6+JLshWy3dtmy
 BheClKzw52U44nL6sJqGFTq3dhLRsDDnWfRrOrQeZ8e2bFHlG7oQV5gK396t6f9+DlQp
 8LjuUZQCoj9nPO2/Cy5GkEM+CKyA9uKxTv+0kUrCUsPzCxmpugOaVTHOHYV8O0IRNEKl 9A== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMXgIh021817;
        Sun, 17 Jul 2022 02:48:16 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k1n7ky-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2lSSynP70HniX7HmAAATdc5DQ+ETXA+AFYJ8MaCl+RMqgNiPcXVIjFv/EnmaHSAzVrWxhXBd/Cy+xtqOyGNvcoj5dL47zeP6VGgtC7iWe+AmEiXbLkafnp6aRcT6I1MuGU2bHaY4A4NuBiDDeWmbGawgTVU4uvB/Sksxzd41z6ES6/zWzEJAK4/tGROQ/N3KrouYZJjXmNdbSxHiyl3rJhNZTfinB+aXx5vt6Gsd33h+W+oSi86qdT2WhOq8A/Z4btLDu4vDh+T22Ugc0JJ1ld4PCKTF3K7m1rAMzfdyNNsL+NPS5PwziiIWRDjGL/XGsebG1XMzRsLa6RgfDjnhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nNIFuIHx9MnDYq3P5rOQ6f7ayKbFRlKrGhcItY+G7+s=;
 b=B9DAS2h3mQJtbENv11fESPXMdVNiLdBPgJywmGUVRMGPr5DIITUnqU3/0H2+88XxA6eZ6Ajq96jWGg/ifZm5W5vKbgCRI8xFQ6UxjOmRpw1c86mgEJsuu/CPPpxKqnqQ+wRRTTSyWvT3/eS1pr0owzNsmvmfdDLQF5HSQ5PSX9Dp3kyi+KpJHfy021dIRDOKJdWeBB0tz6EwE2vFZp5eHcVznkqqFzdc+CUvC/N9KufWFE8866UnzBB3Tzkm3TwLSRhHWDjAX3EP317i7R8R+jem1RrAxRA+aEBItVL/y6FCNL9qkRb+l0+5GfElZcmkX+94ZwPBeeO0Lspg8F0JzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nNIFuIHx9MnDYq3P5rOQ6f7ayKbFRlKrGhcItY+G7+s=;
 b=VB+dtpSanE5mwoYEQ14ueYtzV+Bx1mb2WkkUz7hPL9iILKjQJ0D0MjsGaXPfNs3g9okN8YMoOy/yGpGIDlHhNaRVoOAnI+bNETslt7kj/Zue/gcoj29jSzD2Ofc/cFMXYIcsDMMeyNSluyZXOeW3FndQstlZ1+k70Ic50Wfo/0s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:48:05 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:05 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 64/69] i915: use the VMA iterator
Thread-Topic: [PATCH v11 64/69] i915: use the VMA iterator
Thread-Index: AQHYmYd7Afncxn91iU2pHjLwR48LZA==
Date:   Sun, 17 Jul 2022 02:46:57 +0000
Message-ID: <20220717024615.2106835-65-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56b6acf8-1848-4283-80cc-08da679ec63c
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iZSg2BB+/SrAWgJSbNm/syaO/Nn6/kpvp9RgyBEZXfmfCQv02/z852mzF9R0wInCq2am58xHeOB0orHboAhmj6n78lsOpHR+b0EZkByDH3nd6Ex+P6ig4/iJcjF+Ps1SyW7Fh1KIHEUi9qo+RtSKKoi6U4Blvcdb9Rnws7Wtu2P6AFq8Ra7u9wjyYv+/E5AGceCUbcAVVFtYAN9U6CkFsIYEIqWvtFwSaOxTPMblq2HcRhDN+4dmQIgiUBnUzfZmQsQLsAf5JTd8p3VShiEOoOHXDkqo+VBe0dDN68bhrrGeQ4bXwgiUGyoWcUOzH6IZztw9rZT8xzj5iItS1ErHnpuW7+SEUWygbK9xWOuR8379uI+nvh8T7Yz3g/Uh04WDBGrNlO0J4T+eY4+fjcOTAzPG4anj8zJncz7UCissX0n0CdCOEmrLKIdvC2YQqnNtb/r5wuXTPUTuPB3veWorAApApLDtWHpmYeZF/c/BOmqflv99amVHRbtqRX8pfuljRLtjRaX+vmHr4bfX6LYuSG+oVDaevHjEkyqWDmcwN3vVp+7+wkqZfa4XKWjoH9LMEF/hQDjsEQTbOgBcQX5FNQiltWMSTOVElH9/stTvhMa88TQwSx++jrZ1ydOHiAvgyxg7wSojcWf8U0dCbPzFZCKGwQJeZVPprNfDFasqbfeyVoxwpEJbPkPDv2PiZFi8qQKmbucPCxiIHDCR6EsHjfXvwxwKJUiSxofDgL4s11WN8cZvFI18iBzT7Zg1QRXo6TYdGxJXMQPS/lu0g1368nEY5ppoTycVzops4XU6dmKB8ZTj9rLwclOHxBQl2cINRnl19bvdHVGkFbv8BkA+v5lA8/0lWFE6S1wPcq1OjYn0HzdcW1LSqRncLJi+ywya
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OfJ7o9jKhJEperaELavXNVplPd+ek9dBS0YOgufiKVLiGBXL8C99nop3ZF?=
 =?iso-8859-1?Q?uqYVGEPdQm54Yrw+XYuWCwhjcG+J5mmYZUq7XWGgpezhIxHjlLj3HAuHyb?=
 =?iso-8859-1?Q?WJQypM5FsjZG69NOmhPwC5oYoPd91KbOnWBzNRam1Ru+jhO8bZqbGY+Frs?=
 =?iso-8859-1?Q?LdIrDorcyHprtdwJGewDH9TNLzorQy58G06pMXAq1fzF0Ln9sCQ9FWfhbN?=
 =?iso-8859-1?Q?4NhWUkJlOkz+5OeQRHxVV9M5WpbVIrB1Eh6jdmnDY/5tzG3ssYhtiulu6g?=
 =?iso-8859-1?Q?Y45P+rBFj2vg8xsY6QQiCIH02CTMjjSIDjMLgEV2+R3+n5gfe6C6SE++J2?=
 =?iso-8859-1?Q?C002lupRKxQurPk5MAe6O8PUfSVuSOMfqzy0PE0AsKXyxIr2DhglXwLqD6?=
 =?iso-8859-1?Q?HJz5kKinYvrtnPMj3OCVIdyn2fontpZMO0wbvbXbha6QgsJHo2vEFYznRV?=
 =?iso-8859-1?Q?zUmHXSkWeeGUunQqjHHYq7cH+EDWxj337/HJKt5yjuyKo6PuWdVdAfacJ1?=
 =?iso-8859-1?Q?8molTookzazYlUlPoZ8dfGBPAQzvGMR5A7MhZGe5PeFxTMhQ+vMRTNu2Gd?=
 =?iso-8859-1?Q?xmVK5TQ4kQ19NpMDv/cW6wR/22W/JWPEABxegUt9aL+RmveYVkWVvfIvmi?=
 =?iso-8859-1?Q?w1rMUwqNARL9/u8JuC2pevVxekPvdUVF4a8GA/R/a88a7/KeoCi+RkgO8g?=
 =?iso-8859-1?Q?sDE/G9W9+OaaxM/8U5HJyXHwStclbXdvc3c1hqz0MLUhRZkUrR4JO5YBtj?=
 =?iso-8859-1?Q?d7Iq8Bezj8Jd9cquUoPL1VXtxBwjsJrcISmMaEoRlWo0mWLn3n4t6PfISS?=
 =?iso-8859-1?Q?dkgdXutKCkCEtO5MT7G8TqmYUcsfL/fMM02w52ULlrzOTumjEPpw7Mno3a?=
 =?iso-8859-1?Q?taj3vvPYqpJR+ZxBQXQG2/izHLnyn23njk9yhC0MRVbOhdVx4GIeGWX4I/?=
 =?iso-8859-1?Q?S5R4rqkvk7KGr8kwqR1eB8xi7oBOp+QbEunvhkrBexUtrzOcmcKHOf1k+l?=
 =?iso-8859-1?Q?Io5rENWdRenxwzz8EPJ6DG71MbGY5AvbB6GOE0uicMO+v7cPnaUh70QR1W?=
 =?iso-8859-1?Q?UoCWiOHsjBke3GhSeQoNLl7tmCWkiB9Mwq7Isw5YZyQY1zojV/jTHYxJ81?=
 =?iso-8859-1?Q?ylISc973PezEwwRz96/YFN6jdOB5dzfN3HJktjC4/2WpGW6sAxmoGRWTII?=
 =?iso-8859-1?Q?hKnWF9oNzjcrwLLMmSz6P5m+ze70nbiJ+HQ+XtrrZVB2qRRkghJXUIF+cF?=
 =?iso-8859-1?Q?2N3VWkB+wHPYWcmz/0QWV5Nr7ypjqtvHBv/BELRt76YZ8rzCkjBWuI8ihh?=
 =?iso-8859-1?Q?DFnQOZIEgdFmOMqYY5tUG6aLgZcraOpTKl4SfD8et+/f+S53j7cNidEKHl?=
 =?iso-8859-1?Q?G/ecL9jsv7JCSM+HCesWB6PhSgmJ0Jntjqvo/FznGENAt9PnmRoBwb7x6d?=
 =?iso-8859-1?Q?G9PsDmJDmA7E1Zna1Yto+6vRq9GBahjc6tzwH1JsWeSXzsagliB3VWT23Q?=
 =?iso-8859-1?Q?tnH5jnUtRfHK1OLx3PRl6895sOPWWHZjjDXcqnyeTvvDiUHeqJg1uwQ3lO?=
 =?iso-8859-1?Q?UlboHSmclY+kknCvC0QLkUhQMR+CSFQBUGOO8xYpyyfLWWzwZ8zOAsUw53?=
 =?iso-8859-1?Q?dvWMhzUjofOE9NJiQoon7MnyYH9+eal1F6rFrAcU4BDqcIwO1Fp4fsRw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56b6acf8-1848-4283-80cc-08da679ec63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:57.8645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7itmkvoYYUArTPToU5UiECgrWGkZI23jwh6l4UuNmBrV6xIyGinHnwcZ1ptwby25ewSkqPsbYMRhrLoVc1hMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-ORIG-GUID: LK3X85ZKQ0rC3VBZ0In83aU6b3BmpJAs
X-Proofpoint-GUID: LK3X85ZKQ0rC3VBZ0In83aU6b3BmpJAs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the linked list in probe_range() with the VMA iterator.

Link: https://lkml.kernel.org/r/20220504011345.662299-49-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-65-Liam.Howlett@orac=
le.com
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
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 094f06b4ce33..a509f7da104b 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -426,12 +426,11 @@ static const struct drm_i915_gem_object_ops i915_gem_=
userptr_ops =3D {
 static int
 probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
 {
-	const unsigned long end =3D addr + len;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
-	int ret =3D -EFAULT;
=20
 	mmap_read_lock(mm);
-	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
+	for_each_vma_range(vmi, vma, addr + len) {
 		/* Check for holes, note that we also update the addr below */
 		if (vma->vm_start > addr)
 			break;
@@ -439,16 +438,13 @@ probe_range(struct mm_struct *mm, unsigned long addr,=
 unsigned long len)
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			break;
=20
-		if (vma->vm_end >=3D end) {
-			ret =3D 0;
-			break;
-		}
-
 		addr =3D vma->vm_end;
 	}
 	mmap_read_unlock(mm);
=20
-	return ret;
+	if (vma)
+		return -EFAULT;
+	return 0;
 }
=20
 /*
--=20
2.35.1
