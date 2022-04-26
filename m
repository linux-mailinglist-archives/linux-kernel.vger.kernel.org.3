Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38ED51016E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352132AbiDZPK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352092AbiDZPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C909815A42A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxD5011324;
        Tue, 26 Apr 2022 15:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LcODvi0z3t7+VI3ktG+P8hv7ComMeS4cyI1DWwajXjk=;
 b=ewJByxHH/eJJ6d3mZfY1nfCCdWQhJrRdCMg7RwGoYSNRu6KsKum+arhS/gx7x6iChubU
 SUJHl7FmUxCRgSL4De8KKpwHwfCau4U657kTHDNg6hd6aNQrr+GNqn3gWotfT/GIuLYp
 jaVWAqoYyBXFPAVP2kba0mmitxLG3u4FHvTsb3jwg2yToXoAmkPbTZj6Yxzb4y43gwVc
 W0jWU4dLGlnur4jnSPLCJnbPzxKfCOtvNk+h9a+enZFeS1xocXhA9wJ//n7xKKF/mn8B
 pn8qgA04gBZAsAevzPiBLRdmBZI7WgPiXV2Eeo20NBRbmCI+rbJEYWzrxdPvQ/J+JmIq wA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF554o019202;
        Tue, 26 Apr 2022 15:07:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3feud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZirs7DGNg0j+aKn8DNeYs1nsC4k3bpkguGJU8g/CxtjzbI6WXIdB2hsHnChw1DZ0uuU8q1RHkdNXep69JyeH4SVmp/1qA0EX8mLK/rXNyTr+H1pLDQKtx5YO2o3Ezvte369iH5gh+vNxc1OpIu6PcgcIXCdrHpWoVU9KMS4/kp9uN7NKKKWB4DoGpWR4fAES6/uPkiVQPjM2TfvsW/8hfYMXxG+LU0z3Ostv0Ed6gZXIzqVTZCdpqxktwI2eWjo1umnUOTQjt0PzgPocyUqJ/eJKq/Lpaepk0LXtvDfDitizJamlOrmQyzvE9zxeNPoXAxzhUTqf1LfLKo5R/rydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcODvi0z3t7+VI3ktG+P8hv7ComMeS4cyI1DWwajXjk=;
 b=hRrluocEbPIiuBPg0TqJ3q+p/IOdiO/lP/Mh0QgA46afIiPGBsJTB7A55zb5kgXmXtf1JQaBTFym4GA/lzurb2xRfqdlljf3am6RqqG5bVv7qp7t+mI0IaSHYqg58JEv6npHMOidDi0jYoKZuz6OW6uHldbMqEn4L0UVDwhTJxeCMdaG3o4cfD9bfpOY0usPTemDo8Myv0JTS5G4bBmnaUvpAzA12VED6YM7z411AbEPmEDjLk/G06DKjMc5ZrsG6L7Fkgu4Yz3l6UcN9EHc4UB+61L10wCeKoeqvL1W7Un6GoVfrd6LzHpQl7gFudAtFjHr1pob46wWixSci8rTCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcODvi0z3t7+VI3ktG+P8hv7ComMeS4cyI1DWwajXjk=;
 b=of+9s+avSQZ3UPDEcNFl6HjEGCGumXSWY18ArF1gaBrdvQdPmAi2FnzyDrJV3WLJbhst4nZNmbpvSzUCr1fYv9ioioyCdrzjrXc4nGGPfvOmZvBn4V++FM6TyuvreRV9fbghz2jrANoI2OfQ72J95X3DHbB7td0BtOPzCspPJHs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:14 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 35/70] s390: remove vma linked list walks
Thread-Topic: [PATCH v8 35/70] s390: remove vma linked list walks
Thread-Index: AQHYWX87xK3/xGbavkSspxIQBGErOg==
Date:   Tue, 26 Apr 2022 15:06:40 +0000
Message-ID: <20220426150616.3937571-36-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42287d72-54d4-4e14-bfd1-08da2796724e
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929812467E4E8C736CCFDF5FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZQJfFpOlqyw4a4gYgVMkUcUFgSYdX98YkYefCHVYJ2bn/CcnoRiW40W7YWsnPAKOlbbmuz3oUKcGX+va8D9mapYg1pBG+8yAwZKCtQxjLG0MNGqGDkcnSYAdVEDlp0TJxyXyKxvtCIhSglUxJgBIou39yN2WYXK9f4aWe/BVrb0ZIPA6y7RUSTehh4omMeKCs7QTXRux5q7TR7zItdoNtlsdv6SsiYB4f6VAmlY+6V7UPor0kZbdEumoCM8ltiLM01pcDHfipSopgTp2GQ+XKf2bARUie2J1zjdZmEFkP17TSim726VTNIVHnHTacAmVqUGWF+DsPLEOWYHpwYQTfDuR9t0b5GSJo4uH2aJtEP4Z4O4bdxITNnQo3fKQKIR/c5btzOV4FVXHuWsQ9zZ6BzYGV90PEIjd+tUZsjqbFZdeCADHaVXJwxsy2Eal2Xu0R4uFcxE59uG5E5N0zjyWJsMyryoW2SgepuO4EUrd43RzMIXGNFGmMK+pkppIoaN06ooVKLX47yjeOApO6YY+pLKGwUgZEe1nSz1UNKqDK4o1pXyVkeGD5iUZD/FsbWAheT6GdMf0iEwpmX6HUumk04Jl2fMpyIrHOyJ/lKLDvxCoPJ+MDtKqqS8lUtvy1kPmO0gp+wdz4iJCkbaxMbwzFaA8hAt2uVF0HbPLzcuDq/e7ZWt0tB4IikBZJc4c7a6jCmaPXKR1C0QldKbuNOPFSQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SdPBxR0KZjuQXr33Yick+u/MY6I6VZjIOSefdkQBeDvCR+CaCPhb5BauY9?=
 =?iso-8859-1?Q?bwcJQ2IIzI4HTg15u8Qop5bM0kYdFTt64uSPNjkJlYRsHf+ZTN8XwUa90N?=
 =?iso-8859-1?Q?9A5Vlgp1O3h3IKo7417sIPAR9iv/A588p0I9pJaCx+qEVr98dBxnEBWz88?=
 =?iso-8859-1?Q?zCP6BZLX9qDpftFczpy7hRv7C7To74RcrEjx/LNt8MyncB7D7AbOdlNUo/?=
 =?iso-8859-1?Q?0kt2oj+0YdOoC1ZZ5YdEMvc/Ogs0uahiIvbOZuDo5YwjSN0UtoXYQkXqb6?=
 =?iso-8859-1?Q?6lQHkUAmyg587KJVvc2qBLN29SuMPCHc9gRDbEqO+vsuvkJF01zFTgyBcf?=
 =?iso-8859-1?Q?Z70NzS5JKYz4aUgij3FcEFIn6FQHxE9RI6Z0YV+SdgZ/gzsn4uJWxnINGE?=
 =?iso-8859-1?Q?y43/UIgQYHj5kD1Uqux04Zel+NqOZcd2uIkwuXUlz+jWK9ewG871VzjBfm?=
 =?iso-8859-1?Q?YScHzqTtVZHLl3otYMMNZsG2xopFcS6P9PCtDQtRyVWrd6oKXMiJdocdJc?=
 =?iso-8859-1?Q?yKz5/fVqCN5ma7LbvhPo0WExKCEHpCmOw8RbPULGTIb+UdwRnsUnlC5pzk?=
 =?iso-8859-1?Q?ONOu4MtEEqUHPusWzZORmGnJ0v/R5SnlaeNknXOlsNfg01nR41n3n2aN1N?=
 =?iso-8859-1?Q?xLpZ9dTMtn/pIwOoTSlXn76h7kccSiXVaR+kNaY8L/J/XyLSyVnKnTfTww?=
 =?iso-8859-1?Q?XtCYssWt5+fyxxCnjX9zxY0iz1dC2yXfML2B1/F/+Jb7cw3RPQcw3zd6Az?=
 =?iso-8859-1?Q?nRLdq4tF1fmVwoA495ZCp1JQCIkxPh0SAHme2pHUonUd31rLTehrSSBy4r?=
 =?iso-8859-1?Q?03Yu83+SxYipd/rHsp49L3S0etSbSckvF7Wd8LLT/9ZYURd4mnDUTdYZJ0?=
 =?iso-8859-1?Q?w96CLRd680dvweRQ4M89FjFBUw90QvofFqZe+4mMF8p9ruUG1RJwVuijgM?=
 =?iso-8859-1?Q?4thyf+t8EYCwMXEIr3/cYKBI6H9F+RiF7C03QgkK8n00mvoLWgfOX/tUms?=
 =?iso-8859-1?Q?75J5sQE8OdUy5K1azHshGGmolr2VyKAqyBHhr/B11YRb4xR9DGJKkdBurX?=
 =?iso-8859-1?Q?T1qB1Vb3JjDTGK/2TUFo53066WcLyouohJS6wWTkxQsmmNP4U0xWD5LSA6?=
 =?iso-8859-1?Q?ksGl14HW0OImUVOlktmfmmJE0/wwnNwEcZSaVMMh66+eyno9I4c9mtrb/z?=
 =?iso-8859-1?Q?0jDsCom9ZHM79fm+Ie0woWoQjn6wlW2Ah6cE8GD6InSqtHS2u872geSN4i?=
 =?iso-8859-1?Q?DvlLPClkXvfION3WtYCbOs68DBI92kf2YMr3ybzs6aQhqIecJdtAxPexj0?=
 =?iso-8859-1?Q?x408oLOGzTk6J9jP710EQl0ZWbsNSnSI/b6utPbE5mPcpu+uRPb09WVaxa?=
 =?iso-8859-1?Q?mtHNCEhcSJ+i+ywEWsX8nIa4qEK0z69c4RPEg+DQv+Nb1GROSvK3o4RO9h?=
 =?iso-8859-1?Q?pWkYKT7Ojx6DxbduzzZNxdetTfuYHmZiA5c+Ouq+NC19FnkwIApllMQc3O?=
 =?iso-8859-1?Q?gJYSwHFO3hIZftS1x5p+5B5ebRjOVaEezxbtSdHWO2HgbkNwKooJSAe3OB?=
 =?iso-8859-1?Q?glg5iqUhkTkE7rv1CP6C+BVDqKh2bkKu3kB1KMa8JXtvDGbpGObCwqCtht?=
 =?iso-8859-1?Q?j3Ja5dNOfZZr8XjufcIcS7gwSbIAXRP+P2LUy+4mgZaJzvpU8s0SBBJd39?=
 =?iso-8859-1?Q?+jxdwya1Vr/Nf52OfSFlbxVftkK/DTITjc/I9WBeXXFKDPFo5D+NvUD/JJ?=
 =?iso-8859-1?Q?Vptv/VuqMVVs61J5L5TQjRFy732wBGTjU6ZmDUvEeysX/ByPpNXzhNdmsA?=
 =?iso-8859-1?Q?6i3OE1KvS5lrnPOjoeG/yWVLMfYaDdM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42287d72-54d4-4e14-bfd1-08da2796724e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:40.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ro+odjEmbbZ74d+h4zQh9UzzHY8wHBXoR7g6diI6DHtv8ZtvbFT/Y2ftRK9gDPwfyC8RprKOfc/RCD60XWAXPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: 2xsI1m8sn0TJffer96QAh9F3wEm0wE-V
X-Proofpoint-ORIG-GUID: 2xsI1m8sn0TJffer96QAh9F3wEm0wE-V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 99694260cac9..66f7e7c63632 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -68,10 +68,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index af03cacf34ec..8a639487f840 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2508,8 +2508,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2577,8 +2578,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.35.1
