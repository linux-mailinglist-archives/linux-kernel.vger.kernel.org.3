Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C64851935D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245043AbiEDBSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245017AbiEDBRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3FF3B3FA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LNHV7032436;
        Wed, 4 May 2022 01:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=7OAEEL3OYoHefyKKACVjJqgQHDMGF1DECMzvzEd0HEU=;
 b=V6xKOAv/gILpJhJNnzMDp71nJ35o+z99uZWOma/BUl7c7gsHBcASPvCpBkkCLrLQhK39
 KVu+wnJqch+QEHdvyYvvhAOU5Wx6+EhCQto8Ofe/PQBWUEGLvd9a15xxEWZN0eflTahC
 amFt1BGNwkqKCcLKs/Z618LBdGOCJAt1r07FQorY0WlgOnOWCRHo5YyMXGYqEm3AwVA5
 68+nT4Y+a2Dhqcy83XLI2dCuK10eAGKPZsAJDjBhMEYOb8/3lLmS90rsMjTmALc8VUzj
 6k2tfb/BrG3DlW5xc78owuoZT25qTZc+8gnib8S4qSbvoGgvHi4QcqiQSeER6Ckf77R8 BQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frw0apxyk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJa013094;
        Wed, 4 May 2022 01:13:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RX37wjAi71YVSKl8HevngwY0EFVBvq0Nz4L78UMsdUm4Tg4azbubVsLbwlxsJdhi1xg2kxkE4+aLwx0bD7RxvGCerazSMHiAlQ1dANZ5fwWq5UFQlYT8C4Yt07qz7xPWCblcK0KWACH6p2+NYRJw9TDdf1MoNixXz67EcZ1NgpfPJXGTXvE6N/cRRUIblMVlGJw8LMQCoibp6a2sNpR35xMXP5QAkpc60B2G4w5OoSlm98CcHr0cZM8HlKzgBEHiF21DzLeTeiTIX0sRqVN2lk/hIdxz/NsvwpUK0tPkvq3ZhkuvoWzKf0XiHCdwCICDhuXF30jdXR0iwXYRfMde/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OAEEL3OYoHefyKKACVjJqgQHDMGF1DECMzvzEd0HEU=;
 b=MTm5c43HCBL+vnQNINVf8IcQdFZ0gQbvsVgyBZbwZufnO522/41BDkyu4W2KzCI5j+iGq5L7dqOKW7/p0BZhndef5mYsS8nqNrQJ7/+40O4mJIAuqShjjhjVK6soFpTRrlIxavNcgVbyYkgaBmramGIakj+2ZRhQsxr2d5H4noTQ8ii3Vajg4co/A5R+QdKj3yVGvX7kmv/pLMHdAzu7i4lStxb5r9GebXjbksVl3jOeVgsLIyQuAZVhaWpgDw6M9RgBVSuJa2MNo+XYSTAlDsihMap+igyS7XOri4GR7ySCDBNJKU7uKbehJHvGl0YQMMqndA0KeGG0fHDyeVxtbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OAEEL3OYoHefyKKACVjJqgQHDMGF1DECMzvzEd0HEU=;
 b=wZW4e3nDUA6yAOhNGpemvdnsBuBJSf6PHOvJ1L5bixqH69JW/acGhvz+1qdD6jyob6HE1yITIZaIOXWn0ZS0jS+loE6KnnYvwWkU/KFmBI5Va0tr276WsBYZE0HxwGf9Jrvs0b5Q2gJsM5p2x5hDy3W19G1dFTzrmgtkAh1jWtA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 27/69] mm/mmap: move mmap_region() below do_munmap()
Thread-Topic: [PATCH v9 27/69] mm/mmap: move mmap_region() below do_munmap()
Thread-Index: AQHYX1Q4P8bI/Ipbr0Wv7tISdS1qJw==
Date:   Wed, 4 May 2022 01:13:53 +0000
Message-ID: <20220504011345.662299-12-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a036382-aedb-4d7b-4548-08da2d6b5b07
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB58309611A0C2A2DA873EBCAFFDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8fQhR8ppdUS9otHxZ3aoV1o/jT7sJG6n8YHaweX+xQyBia3A2Nz4iH5FrPvsTYQhbk7ARCbMHNviAbTTEl7LHehiTgLxFUKkFgwHrTep0YTs/DQY3VIk6U28mGd3y3gzw04R4+HxPmpq4BLl9Yt71zjW5rwFU0wQDVmWuz/owv0/ONLfnFAe4vxmm3NHy4F5TPqBAssIp4Do5vSGtkDdB41lMb4wVkbAclwwswdQyXGxQD6Mk+/hxfCsPZwdhwvvwMcEhUj7vStA3yM3Tlppriau1GMqpoLWFb4kNBeS/eF9LOkxyZpXlqE8SrUrwILLNiiDss9wsLyea3LEvNuGKOsIHaFCSyBl+qJ5pL660ifbd5m8sWnntpsfijgFo7epPJeX6G/6ATuld+sRFKhCgoWwQit1fFSGWos61hDQVDwu808JVNioR7GoFTwDordumvy7i+YidDikuTDx0TkLX0lSp5pCgrFdTuj4FUBCFGb3c49P3NTsrtzoeBkjbt4+bPAO7ZOSl9hr2isuRvgXFC/rILPQfr038FSBvUaxt4zzhtHNCwiAAlXoN+g5vk2wzWHRWqcP+BjDiOhsydnjfO4Jsu4IlomjKeHCEHMa7W3/1tnYzFzuIJihdcJcXyo++OVqxcj1507EyJzflsWCa1TpVibiacjTB/QGzMVlSRemJdnzKUNeXaPa1Xe60eua6XjIcPq2CNX2wL3tZBhUpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(30864003)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XSewGhxIYl012+FRMDTrzjbJ+OOCyv+vd9089ZS8JuzapL9Bzquuo881Wo?=
 =?iso-8859-1?Q?1jdppxtYdKwOlD5NXSdH+l6Jwr4jdKWMG74u870/a07uWwEm1evwpGOYbl?=
 =?iso-8859-1?Q?1ieNzFTeF3gfCSIiSfkHb6odqMpLbgLVNm8lwCgz9ULmFG3fyIjqEAt+k6?=
 =?iso-8859-1?Q?EGIou4CrUz77AWxTmYVdxRGFezVWm5AYpJSuFpMEq8L2mPKxsbOae/93uV?=
 =?iso-8859-1?Q?pxV1rtW7ReCZpXz/VFftkLfZb4jqgYiowx1nLXn7atbplq3kXggKxLVi/T?=
 =?iso-8859-1?Q?KCMztFi8qsNEeoR9Uir0IaszdQ/0P16oeVfc5vkBpHJ7iEr7PmFokoe21N?=
 =?iso-8859-1?Q?OW2GBL/t5Lpiouc2XgbyY436NJTfQmQW6wGMXUbUI+O5gesYpePsNEUfuU?=
 =?iso-8859-1?Q?xDJskHtT4kKAaET6ej85su0jEx08+qaIU29Ib8hEZEIsNS0gvygQ7bhJnN?=
 =?iso-8859-1?Q?eNSN8E4hgt23bhxs/gePei10kaSV7u3vpHrl7O1CpjpHzSrvZu6aZsg+rI?=
 =?iso-8859-1?Q?XenGy8FAEdPHA65HH0ayNiaSPseSur1qq+MW2BEE2npZiQtL1nk+p63H0S?=
 =?iso-8859-1?Q?P6UV0Oym/4dHl+Qchde4h98kiGPUvwLM9huSJOy/HCMv4Z5uMj+TWhi+qB?=
 =?iso-8859-1?Q?sU0nr2NZ7MS7pTq/HArq4uDO01jECgQ3PuqUPT8Okb9bBF335/wCX++ntJ?=
 =?iso-8859-1?Q?V+wU5CTwbwDMzEeaWvKmpKNErdrEFnXv0qDL2QsZoVgmMZtgB+m6wBDZz4?=
 =?iso-8859-1?Q?fDzO20lRVGfupxBYXw08HI/l72wdhqAHMVbCSuiVTFdUBfr0jsdFYkXM0V?=
 =?iso-8859-1?Q?0AnFa1utPuwvug3eG0Wn8DtgmSAzpe83GKmFx/giup1H5b0DKevQUQYkaD?=
 =?iso-8859-1?Q?rVibyiKUdGRbQQRVGWsS/ghDDsMiK/lPNUGK3Lr/F7mdIc/4C6eE4Iy08b?=
 =?iso-8859-1?Q?3YsBQG0EpTF53TfrDMinsXGO5kU6vgoZ6Rjpzm5wvETvoFaZOYWdaEEFb9?=
 =?iso-8859-1?Q?BMAPysMW2sRpyPr6hf/JyIDC7wjuwU8/XdKKVENrKZhHxTof8mUXhg98b7?=
 =?iso-8859-1?Q?YT71qT08ubOlxUkubCPuc1AJmCoSxcCd4kTYYu2x0HWzmQFqbox1TXDeVq?=
 =?iso-8859-1?Q?TMVFbKSbeMSsQnXziTFIKV2j9dqlXJEPl64Rzmh7GV24OHWkGbOZlTuDsS?=
 =?iso-8859-1?Q?2MnP0i+JZdZYrQEw86xpmSiHOhGNg+OsfoOlgjt45JBpv+I2uxGGhed/rv?=
 =?iso-8859-1?Q?cXH7PkQxy1XaVjd1hEzo3pZp2MCmdvN0LEqZqlrfFAcLh/FpSkMDgAEpgZ?=
 =?iso-8859-1?Q?NbSDI8mCa8u3CATgsHej2+2ENDOd6igfh/ka47euGOY925uKxr23vfTmW+?=
 =?iso-8859-1?Q?k2Mq3pVSkt1rRQPKjhqlkX/LMeqArcD2oDPLYpB+lyoEXWOsO2VROolRHs?=
 =?iso-8859-1?Q?rWyJjSAnpS+l/WoMp/0Orbt8i/8xaMN0ZRUkaQnBi/2K1pEmWCTC653QEQ?=
 =?iso-8859-1?Q?cuWS74aFAcu7ITEp3sT3NOdjojpdjzXLFKk5HYcapZcipZ83cLJQBLAbNU?=
 =?iso-8859-1?Q?br+MDoq97PM88Vcqvgh4uD65YirdiT3nZ6YHYRV9zqHI3+LwEtLzbtA6/W?=
 =?iso-8859-1?Q?/eoKtrBWhFxHEbKhOmoxhtsIQhAWo5hhCgcu3f4AcgBkJo76h4Uk1puwXQ?=
 =?iso-8859-1?Q?WulfaTUF8t4YycN4epQ6dPkRc+5ZTbY9V1ZLbYdStFFepdFCxUV7RbvyNA?=
 =?iso-8859-1?Q?2mieq8gyL3ihYODf/VNt7uNhxqQKuZhZQM7DdEkLYBCVmZfP+XX3OQckyW?=
 =?iso-8859-1?Q?ZGd1T/dIHhXIyX4A/3X5KcFPqNOn1QA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a036382-aedb-4d7b-4548-08da2d6b5b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:53.4394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ivAmx5uQhCcEs5DK7/TA/4sLrYR/Rqf0jDMZQxPDSvNIBSHv7+bN/z3kCuESiGBzFWaL5hldxTmyHOhUyfdkAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: 0m7qeWt_F-cRrzwCYoPo6qXjdvEFCjWd
X-Proofpoint-ORIG-GUID: 0m7qeWt_F-cRrzwCYoPo6qXjdvEFCjWd
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

Relocation of code for the next commit.  There should be no changes here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 476 +++++++++++++++++++++++++++---------------------------
 1 file changed, 238 insertions(+), 238 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9b4192130814..d49dca8fecd5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1753,244 +1753,6 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE=
;
 }
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *prev, *next;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
-	unsigned long charged =3D 0;
-	unsigned long end =3D addr + len;
-	unsigned long merge_start =3D addr, merge_end =3D end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |=3D VM_ACCOUNT;
-	}
-
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX , NULL))) {
-		merge_start =3D prev->vm_start;
-		vma =3D prev;
-		vm_pgoff =3D prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma_merge(vma, vm_flags);
-		goto expanded;
-	}
-
-	mas.index =3D addr;
-	mas.last =3D end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start =3D addr;
-	vma->vm_end =3D end;
-	vma->vm_flags =3D vm_flags;
-	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
-	vma->vm_pgoff =3D pgoff;
-
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
-		vma->vm_file =3D get_file(file);
-		error =3D call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
-		mas_reset(&mas);
-
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (next) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D prev;
-				/* Update vm_flags and possible addr to pick up the change. We don't
-				 * warn here if addr changed as the vma is not linked by vma_link().
-				 */
-				addr =3D vma->vm_start;
-				vm_flags =3D vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		vm_flags =3D vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error =3D shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		error =3D -ENOMEM;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-
-	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(vma->vm_file->f_mapping);
-
-		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
-		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	}
-
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-	file =3D vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
-			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |=3D VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	validate_mm(mm);
-	return addr;
-
-unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	charged =3D 0;
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
-}
-
 /* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
  * for the search.
@@ -2840,6 +2602,244 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
=20
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
+
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
+
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
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma =3D vm_area_alloc(mm);
+	if (!vma) {
+		error =3D -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start =3D addr;
+	vma->vm_end =3D end;
+	vma->vm_flags =3D vm_flags;
+	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
+	vma->vm_pgoff =3D pgoff;
+
+	if (file) {
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto free_vma;
+		}
+
+		vma->vm_file =3D get_file(file);
+		error =3D call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 */
+		WARN_ON_ONCE(addr !=3D vma->vm_start);
+
+		addr =3D vma->vm_start;
+		mas_reset(&mas);
+
+		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		 * as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
+			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			if (next) {
+				/* ->mmap() can change vma->vm_file and fput the original file. So
+				 * fput the vma->vm_file here or we would add an extra fput for file
+				 * and cause general protection fault ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
+				vm_flags =3D vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		vm_flags =3D vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error =3D shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error =3D -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
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
+	/* Once vma denies write, undo our temporary denial count */
+unmap_writable:
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+	file =3D vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma =3D=3D get_gate_vma(current->mm))
+			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |=3D VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	validate_mm(mm);
+	return addr;
+
+unmap_and_free_vma:
+	fput(vma->vm_file);
+	vma->vm_file =3D NULL;
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged =3D 0;
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	validate_mm(mm);
+	return error;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--=20
2.35.1
