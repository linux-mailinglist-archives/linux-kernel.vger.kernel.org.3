Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0D157ADC1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241145AbiGTCVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241090AbiGTCVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC56C116
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:38 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1lw0C003839;
        Wed, 20 Jul 2022 02:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UA7JQTZ/EY25+xzPCgfxRsv7LOWbOF6vDNGzVSDECso=;
 b=EmdKIT4t0g/fgV/s22o0/yGHadGHZv8Imwd/TNWBm6UpyiWpaHf/ngEmCiPQ0sZiEJJT
 VdGBtwqWlJLlQfOqfw3zqRrHE7xdh65rQPncLU9qo+NWN75t24GM7fyW+MAC65DkRI1y
 ukro5I+FPvahSd9d6ejkeBaXq4CP6j6s+r5qfmZOxEOgiAh+wo4ZhR/Irnm2tsF8UU8z
 dUSJHW5K7sxwX84/Jk8dpmgh6QWjCp+l54jkCvmDHdMeJbiS8NzizrsUBaWXcX74ZuzP
 mn5Ah8MlcV4EYSFhhyLwRCdO1qQKzpjGTefLTA+c+WF94RyHr7D6mmkG5xpqC7OTINpF VA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs83kr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlg002689;
        Wed, 20 Jul 2022 02:18:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2xPxW/buo/a/Yc5jDN1eFyLayOSZHoM4G3HXsxeFSe6GfbLAa2XikhC4PUyhnlSYnkeNzLoWoXWmxwlq6nFKOzwhCT0hDg3DzkTqyv6i4HNdLUm5X0oZ7TWbb2wu6mFSRja73rWM8tosB9/p4o15Qb41VmqPGwC3OuN4Mhg3M67p3sTTHtawBi31tKLLF6pZDzsYUAwxyD4RxjNXHZA9cYOGmTl1AVptl0tbqoQNiko6Mopyedz3xWILGJJeoIZuUem8Np97QZOEgFuPWu0aujLiqks4faOt89jwYvmtfQitLbZHWeQXJVSRyJVsXkNVLvbZUGesMlc/c8DSjTtAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA7JQTZ/EY25+xzPCgfxRsv7LOWbOF6vDNGzVSDECso=;
 b=KdfUrA9/+CTz16DbgOrG6bkd2dFdyaTUZh7VMJ7wtUaZ8t30Kzu/OCbDLqO4NMlYGEq98a4ESaJ8iWZmAi6q312/IItsRxonJNU+HS/jct2y2HJP7ER2ZiRp3861HUiRej2MHFLLre9LQdebp6+nPNj9pyrduwXzKp0qDSCOXtca+qc4G8VJ6X0V/XpO8vH/AjY+9YhZfy3LKbCF0tRQsdKpPZhHyfWyRay+bVkg63NnT83jqz8wA0xkIQvYXEtPYiCz1NBhb5njHWyleXpLXgTL01gnyQnSC0EevETXuPO0jXsfHI1FPx8+dEtPJ7JhAqvcvRzErbdQViuLtdMhDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA7JQTZ/EY25+xzPCgfxRsv7LOWbOF6vDNGzVSDECso=;
 b=wehR/LMKblZmHEOfLgcqQW3K/4wwEHydP4emS8t+AbFC/EyDqDNkGiDMErQjvocgj2PGgFlV/owLDptur/6RVuqH7GsreHJ0sabsDMmFn+mO/q9lhRhmCF9Sco2mdvIgtJrLG0g7BCeWESek/h30wyTApZuQZ/Me7WaKw3IsSjQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 35/69] x86: remove vma linked list walks
Thread-Topic: [PATCH v12 35/69] x86: remove vma linked list walks
Thread-Index: AQHYm97sFCn8keb6BEuCXyMIjt9bLA==
Date:   Wed, 20 Jul 2022 02:17:55 +0000
Message-ID: <20220720021727.17018-36-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62edf9c4-0ffc-4d30-cbeb-08da69f62412
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y3yabNb3I9LAHxafT7dVaTVn81SF5L9+vC9AgD0m43TrgVtNDeNGRoU+5fjhgQ16CUvJ56hsejTPCt8DpEzj5uq9WebfLZHWxJXjhIwFasqOdrwiQkxKBOeofsidDL82F8I6dkEP0RExuiFRyzgCWTbzuacVK5j6FsywNhlr5RmRURxn1tqgFPWn3cqHArzIVepOb2YtSFrI7uq79l2PbETjlGBdtycMVXadK3L8i5CFDwlo7PXOUGvcTTzeg1TAfMfGr6Y5FGwzYA2YExv9vxd7fji9MmGH3MnO9MrDZfI35HFFcSXKKSPh3z2XS2tcdhsF5v2t3Rsj5Fo5fzQqJcoljpMHU46TZ/N1pQ52Xxb3ERZ/sXDcytTnyAtCeRyoHcoiAvumDmFPShrS/riGhWIUYFP/V4P65RJkSYsxjrn+4IGIN6cDXv+93iMJcSd6t3YnXqn5S56up9M3RtApeKUsDfw+z0I/lz8bXw9Y+sMlU7oiog9Y1xKDt1iVxNAaMosUBnvM/Y5qKFoTKNWpiiMAmthKx/oPQnCaVv/nGQ3MlgvEeafKxkhkkVB2bbGRNrpMwmG8+VvaXgHolq5uxcW8EVAg7cFqH9+yHeOmJuc1NDwMDobYSClqAV07Wb9rdoHFlruNDAelWj1Uo3xK4O7CxEiyP7QBRRCmyspCrWdL7oMH0V0UJq68i+nS4euEAaOs944LwMZXtmohXuOO4nXU+f23I+tE7Eo89GRSRKBXawH4OzdWnfxmG3DBKKE8QzEf1OqcGe8IMN7GG2j187AUrRU3xvpGtyxJt3HEt+q3Lg39Ggs49vyRvjOwnDf64LvBI2pqBumxUCn6CogmSqgPs7eT/+q3rowh09fo0uY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d4f2fsdbdJh5hXptHq6JiF4FNFxCm5SaYLanhUsWPiAme0JOzV3iQmkGDm?=
 =?iso-8859-1?Q?KwiCvC6zD2lUk3qQ9in+oGRsZjM2qbbbsLdriCBagsrvLQYUwRLERx7+bX?=
 =?iso-8859-1?Q?tdUkSrH5U+D+QHIFbcx8/kHAKK4MaPVSDEJXvbWP8C688auw11B7EhCfZb?=
 =?iso-8859-1?Q?YGNebgNzPzH5OUfeB2HugELNGrk0046zCkP1647/FkdIbhjhcibt0Bmmlz?=
 =?iso-8859-1?Q?Y0OmZpBnp0NS+UMNA+j9CuuP4fA94Y4AXtbnB/MRDGpHlvN79uzb+MOO12?=
 =?iso-8859-1?Q?5mTHsN3+H7iUDII8WgJ90rWqjBpgYd6vjNN8f956APWGRFDH1HUtYEXwgo?=
 =?iso-8859-1?Q?7wm7o+staMs/B8axmMmp8HQw2VX6OcFZ0UlbDT98ch3sJPWVAxBcoxidri?=
 =?iso-8859-1?Q?L9u3CmPoPSvtdUUY9wD28kcb4FC/pYY65Ng2jm4QCz4zAov6EFwgpsuXuZ?=
 =?iso-8859-1?Q?GowoDaDkWRgrKL1xLuk0T4UGgrW2gjsJx6o08AGtL4bvhGWBpvjXfTUAj0?=
 =?iso-8859-1?Q?31am2T92G2qCdq+cMgfQOCJf/PFBLQcBze51dOs6r9x9Dit0pYIDwGuPbx?=
 =?iso-8859-1?Q?8ybnXgWFcp9KXwsgrm0fV/bFQQf4zrtqk7/+cUEnLtjdaQZtYzegtudmJJ?=
 =?iso-8859-1?Q?5bV0m6xT/UPx+2Wr7T1nbsIFeDwxvLIOtzu2uxdgXQXDLmfThetyki8Y9m?=
 =?iso-8859-1?Q?Nlw6J9B01Jl8V7XZZwW9YB/NFpyOZdbb2nfsHvM7V9gjQFq7y9n5V25ocR?=
 =?iso-8859-1?Q?jF14l90Vt6vvHoEbyllOHgKwzuOx6iNlxdeQfc4Gr51AIDrvKIinVLIQVs?=
 =?iso-8859-1?Q?SyR9o/kzFG6PsSkOibmBcELt/8xLh5chEIM+OA6YNJi85yZ5ePV+wbr6mQ?=
 =?iso-8859-1?Q?dohBiwEJbNVjSaOcDAkoJGqhdXiRQNOVn2gBJK7bk0hloudnzRPpvPQ8F2?=
 =?iso-8859-1?Q?tTImznIj/RaS0tRpPeerK6D5VxriVR1FNYhMBzRfcDDHoY2DGH+bhXxnPC?=
 =?iso-8859-1?Q?q6pKeLC1Kp0sba183IAVHYaBICqbt6srn6LSDZH0eALo6Gp3P4gj9KeOeb?=
 =?iso-8859-1?Q?JgW1UWUKbXLzfuGtRBawzYe6Qny4daXocgHWMcs6QZqZPOiIP8G5KH4hlZ?=
 =?iso-8859-1?Q?4tlHHPYKj+Ye1cIm0PWELWo75c58+ZG/LUYsk5fIQvFJQRj5cUuR2ClW1f?=
 =?iso-8859-1?Q?lXsoiNbzqosqwambTvF0ipizAGzSS2WdAhPR2hrgkL+SwlQdtz3wOoSZ8T?=
 =?iso-8859-1?Q?DOBSHC+dpGhnxqTrTxesfhzHJdDaXnJQPtyQ92uONQlXWfrzaQN+pJ2AeL?=
 =?iso-8859-1?Q?U2Yg93mb6zVWZ4qbM5T5iLPlXG9BX4JXXhBwOnQl/s5DcAZ1vywBEPv4k4?=
 =?iso-8859-1?Q?3IQLcqVwacV3K9oi6RnovHhKNs/f6pKLjUl2WkZC0gr+JIi43kr2aXqYbL?=
 =?iso-8859-1?Q?hXsENd1fOvdoM8/FRlqdQjZ2P/AxCam6BztwbgtyoCiBk/Yb9O1IZG3UWt?=
 =?iso-8859-1?Q?fgRfwDM/wjtpuURhR3uyRohzw2/YaNCITimTaoYh/rdQ5KhMeHlBIXZuAC?=
 =?iso-8859-1?Q?1WyW3dfA7fiLR/tWdryIEvwa13iRPS7cNiFm3768fMryvPHxNN3bnHJfB6?=
 =?iso-8859-1?Q?FBY7rdIePysP5LsqAtTdMRP5MUSYPvT2tzGGEs1/RvWReQzLOqC+dUYw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62edf9c4-0ffc-4d30-cbeb-08da69f62412
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:55.4774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tv+af70oPz1/SauLCEBSXufd8W/gNo9hoqrpjX17o4fNtQR/PUd2htaf1NPnh64ca8lqkllTHDWWPB0sUboI2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 5JghqJnK17_gQZjEPFSSyK8wboWtg0uw
X-Proofpoint-ORIG-GUID: 5JghqJnK17_gQZjEPFSSyK8wboWtg0uw
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

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-20-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-36-Liam.Howlett@orac=
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
 arch/x86/entry/vdso/vma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 1000d457c332..6292b960037b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -127,17 +127,17 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
 #else
@@ -354,6 +354,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,7 +364,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
 			mmap_write_unlock(mm);
--=20
2.35.1
