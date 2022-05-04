Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DD5519373
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245463AbiEDBWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245150AbiEDBSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:18:16 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A60F243AD8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KctF3024988;
        Wed, 4 May 2022 01:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=t5HJVMlCrFs371XkVWlg5pWEAxuNjGH/5NiGlW3/6yg=;
 b=X06xkcvD+GXrjBWKoZxQPWB4Fi/MNkIRKPaXG94VjDpRzAYTXc9Tkwi63K+4fzVy4Er0
 u7QtTJhN4NDHAJPn5jXnnUXne68NJ8oGtXvIWTzhV7OzNm5juMcOhnbhkVZM3QxAimTB
 seNFcRY7Al/ELg8vMHnn+nsyii2G0w3R9O+AbfDDXtsauMW68q1B8E5D3j5Mts0ZLPuU
 i5WICiOqp3uTdM0Dvrnu7CeWVsRJUy0QOvndZPqfx4j8ZFCZCyFFmeJr3O0zReWMmCgh
 VYwoiefEkfYpnp+9URzF+UHsB3fa1DzdcCxzUNPw151NfalMrTy61M2VPo5a14ASuxqC Ew== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2f6c5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AUFa023411;
        Wed, 4 May 2022 01:14:38 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9g4fp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCh6GOQMZc3Prhp8d1qeo0tDGjbJwPIi6J6iipVvbg/ka9Q7l1zWTfAr8yMYxcwWxm5StCK9llyWbkQYa5me7iNnMzlQBtNpQ/JvTY1AtEvvefa0sBConHWsaJwVrAj09aMMzIHUr2U8GDEFntI8BHdTupDJ3WOZhSCvEHdCaOfTY4MYezjljJgNwO4jezkS6Axnlo8mRj17uuXdkfPJB7ZPH6fNIGVgLVzAPezqidFy8y0uQ+Fd7tIBVJHv5z3UdmEZyUeFZ/NMmtvgVh8pXkZYTF72BLrXRFMqejaI8NqM7XnLhi38h7MvaAJ/DxVamzSwyBytQ7cwnTkKuf3/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t5HJVMlCrFs371XkVWlg5pWEAxuNjGH/5NiGlW3/6yg=;
 b=VXjXQCoyj2VIodRPe+drk8S+qa6Z0QsjtllJV2FJ0xcpceUMaTy6Z3WzvvVMd4TXtKmDh2Q2mYkKWR8I8RD2nAFKShM1wJnsZA0pCmBTTk+QmUYURxIybNGOiwumDwEmP6Qa3SK5dXi+sZDRSt8FYYUBwoPuYRFcSNuxZb6HVRc1kvMoVg/T1J1wlRL9Npv/62CfXweI0+0f4BQ/0HbudKBN7TIA9+nW8iyLvSsys7x2BR/KYuqwVwTnCODdvn7mTFSejIhu+JYZnonAk1k+PjcF22BXfQoL30G5kfZR2OuMqmH1rURiIGKRIcPAb25rYFIGK9HK61IZGRzeLWxAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t5HJVMlCrFs371XkVWlg5pWEAxuNjGH/5NiGlW3/6yg=;
 b=LKuKiVlwAKH/zDD9GaQT9fZ85EyjrA0FhMpKKiBAzKt13vQ3yaQ+Lpz94Kxt5cq3KR3JkYCfSMYzKDZYrwDKY5Jo1reV0pub+pkxCWSOnS/7KBH9qy6diCVkP8j09wx/Jdf4Hu+9jeIOQtbMAfKNgsfQjSnOHn8XK5hXxExN9qk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 48/69] sched: use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v9 48/69] sched: use maple tree iterator to walk VMAs
Thread-Index: AQHYX1Q8/nyc3nUnlEWv2xgsS/lGZw==
Date:   Wed, 4 May 2022 01:14:00 +0000
Message-ID: <20220504011345.662299-33-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d817f9c-2bff-4b0a-c48b-08da2d6b740a
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB37289AE4ACADAB02E67FA195FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UYAsg+eFUZyuiLjJ+ysq8OuTO5LwybZDuzX2Q9Jgz/QoqQp3ZGvcPNTSvzqBBLaMuolSZlXJsVZq7i4aDvk8ANgGIYCt7nf51t/ATY5yeela1Oh8dbuh0E2WB6iG0OLoL+f+nOPr/lUKPtmOug7cdaHSm4CuwGe7/aXl1YTFakjuwdZ2LIdPgdj+8qOSEAhu4Hg5MkVZ4/0ApvANWTIXrCiW6tPqBMS2i8bbvOC5wEu88RFig6VfIXOjx7jiVfa7Qhyw/msBWokNW9fc4dsg/nTc0FEWmwrVJkjuRBWn3w6cCkJJ5Cx8KOY+trE4UhTypXNAhp5etM7Ww91pwK+mkpHwf5phW6jLc7twGHEEJ9MSLd9x38l/5vbm16uH9xF7N6roEYYwYsxGDqzll2cTTmLyf+UGzRFEWQA3/7JS/O1ArhRODwvW2zWAaw9/tnLbmXwjuSrB8Bg9gAOf/dSch8tmtldDxMGjmmlKeLew2FvE61hBp75DlGLSLDYEq5n0vot6MC2VQQyXTgDGmTVQqe8sUAC9K2QJ2ckBMwNcd773xuvXgz6Qg2/ALIG5oEH+tIv1D2bVSwQSu6z4F8GUkUepc7u07djBHJSPrYWJANNydFi4mbt6p/O0ScvI5hG1ZWD9vGsMVnAxldqNts2fMzbksDgLoA4jdMKFSDNv081KP6vHrGWtg89rKA+a3D9/ZBQOsdNO2/HUsOeAtcx1Iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AeTinuEVNljbQhEqiew6zMTSmpOjEwDqSCQ+0JHt349165L4HDXVDZhHbU?=
 =?iso-8859-1?Q?k4X41YtmfCSAGem8j9Kv6sepb/zsWDXiAmINpsQdxvVVS6KJ3SvGG0DbFJ?=
 =?iso-8859-1?Q?0O+yL17+pVQrX2gf2YZx+xbUCUaTV+PfhQgqzyZtkflUC5fIBXW6+EK0XK?=
 =?iso-8859-1?Q?4VkfOIQoiKkzW1/2BZGNlKJ6ZRYM3rntw3Zv4sEGOUb3ErM4auPYcgWRtp?=
 =?iso-8859-1?Q?TMZynW2KdRP7g//QUTVnTcl9MncWKhKzUG3k0g1dXvRSDLJlfa11/FW28N?=
 =?iso-8859-1?Q?nH98SHquOCUQB1QhU6ERsKn9zQ9QDu5as7LMThvi/fYHcWCzFVTQUNs22T?=
 =?iso-8859-1?Q?O431XC9QJBvGfefCxhDCnm3ivVqw0NBaPIRDpg2yOgc3fb0TquqQ4L7CV4?=
 =?iso-8859-1?Q?k5uNZ74BkvfBPYhXZ0ydb754NZNxX2Sc4jtJ2x1rGjC/WeUG2pWcqLjDYn?=
 =?iso-8859-1?Q?7zQ1vxE78Zi/ygRBOSp9Hbrqf9S8JjsBqg6jNc1PZQdz9k3CEiLoYCWQGI?=
 =?iso-8859-1?Q?mXj36OPr+8FNOoew0FWJmtzRsx3+hZ9TCH1bt+e8ag2Pv7WEiAr5J0MNzf?=
 =?iso-8859-1?Q?m0nHYGFBslp3A1dnUrnJf+hPvkzAn8D0uznLAldmN1lEQd8BNVTpXEUyXc?=
 =?iso-8859-1?Q?07urETLvarlZmjgHgxh2afKdM3+PlUakgBJZMoRN5RPxpFaRsYH1D0yfdC?=
 =?iso-8859-1?Q?COmcHGkjSHyMAiyZlikS9BO49vuUncFORL3IIqa2PMFZw1TJDeMDHFLtWp?=
 =?iso-8859-1?Q?Ug78bAkYLs77qjwivaI1DPoPECY+sDEXyefcAo3wPO08/sr5G42jdOKhZs?=
 =?iso-8859-1?Q?FKB8l6tvw1fMEU/yrhyq2q07Gl2FbcKeymeVfAuxtYwBl1e/sd5DJrsnJb?=
 =?iso-8859-1?Q?zxtJ+D27exXw5S7lMHQIifeTE7hmPlKZWcW1iSbl6nj186V/tPvPgwWdiW?=
 =?iso-8859-1?Q?Bn2Q6GR4MUV537V3jiewFQZeIO8G6Meur7ZAgMQKXs6YFLmsvIUl0od6FE?=
 =?iso-8859-1?Q?oBTL2FhCh7/IKwHmhj9kCtfVJ8R6CmQFp0rh1xuNnXjioctOCnIYGXSRbe?=
 =?iso-8859-1?Q?Yx/vxlY9QSFp15HapgsF7CuII/72pIOSYuPz6UAFgXzcJnshA7WgVPw775?=
 =?iso-8859-1?Q?O6Mt+eFmfHYpAVHuC+fx0fkroFIh6KlbU/eyO7U/VNcWwMDZCG2dZCC6W6?=
 =?iso-8859-1?Q?6wPd7vQZkiI8z6ah50jKgVxfRygyqQOgGRK+J+j/CcJXBHm5xv5k9B4iOS?=
 =?iso-8859-1?Q?kmMOR+uicsZjKkhgTi3xyX6/ACXm62oxeNaLRvNrsnPpqULXS4WugZ+2A0?=
 =?iso-8859-1?Q?doIkxIjiIvD96Kcl/KNotDcUG/bJkpfyA0Hju1B3oTbD8Tfl/YBpq2ZneZ?=
 =?iso-8859-1?Q?rn57IuVWaFxUczT3lykkZoHm7e0+5mxl80mCK/mfj+3sM+WJDiCXrqgoXV?=
 =?iso-8859-1?Q?mOwJf0ZWx+3z4AdNamGfHH9yY5d+NM1jOX1Cp44yW8zz8FFF8FULHmyK8b?=
 =?iso-8859-1?Q?d7dJTOhq36TjRSrlPwV+2D/ps/YYNYtP+//WLNwYod4ZjqiBoxq23UC6X0?=
 =?iso-8859-1?Q?p3dmLaQLJVzjlBb8XQE1w0dBnRmDSHpHsPkLt0dWDJBtFJKMStjomKDc/K?=
 =?iso-8859-1?Q?0EaDCiJW5wb6Cgxrm8SMVnWjt9GG7XCQC1Cb4bAqvb8mmOu48NCBreJcKl?=
 =?iso-8859-1?Q?uxsbY7JnnlBYY94+DadKDg9HfaHkvvYFWVyRWr0ax80GYY/g7LQ00ic6rj?=
 =?iso-8859-1?Q?JcLIgaFq2RdNoj6KgUQNKkSOU/73KTltf+tticZfy7B2NFG9HRWw1NojE3?=
 =?iso-8859-1?Q?InqV+isU27lsJiHo/8LO+iVsbim2qyQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d817f9c-2bff-4b0a-c48b-08da2d6b740a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:00.9389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4x1tRct4tDe79YfKedIFMomlGjORE2RAwSBmedPZiDqseuxV8gjSyfv2ad/izJZPjhtEhhtVmDJDyv89r3oV8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040006
X-Proofpoint-GUID: ESyGGmmM-2aOIgCjG35j-1OyGjbFf3g1
X-Proofpoint-ORIG-GUID: ESyGGmmM-2aOIgCjG35j-1OyGjbFf3g1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The linked list is slower than walking the VMAs using the maple tree.  We
can't use the VMA iterator here because it doesn't support moving to an
earlier position.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a68482d66535..aa18f180ef7d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2722,6 +2722,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2778,13 +2779,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
+		vma =3D mas_find(&mas, ULONG_MAX);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
--=20
2.35.1
