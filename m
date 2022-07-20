Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AC157ADD3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241299AbiGTCWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241149AbiGTCVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6D96C126
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:39 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JKVfLB030723;
        Wed, 20 Jul 2022 02:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=VjO+QY9BIMwTt2eiSzdiJ52Z9YWqkR93FraspttOc4I=;
 b=PSHYs+de4sLN/qHRAafLnL6qps60xup1hlxFSRt8j2JEkMOlSvCo3RskRs4+9Oz28W6m
 mWydSTbhsQjbqzb518asUl3l5pG4zn5WxoJDRm1AO7UE9mxDWFBJOVIQhbTtoseiNJC6
 ozC3TcKR+gfTyCoj/Ky9RR3rmyO9JQTaH5N1TuKnEclNGYVNspkPRLTWazPQlaLpuVA4
 itKabvL9tEA9E8K+fruZoFeBhpysobohNlqCmnRUHUXSppoNkTAQB9ij1Tc32DSmUQmB
 YLZa6YYOjM3dkc3CKsL7B1c7Lt/ELTHPpjPGBQJNljz/fZxDADiSvayxgsjEC8ibsIlj rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc7yw8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:34 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlk002689;
        Wed, 20 Jul 2022 02:18:34 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoM4aswkXjug/MdJPPAPhB5CNZpnjl1+LsjDVooooREJAKM6O0CqqkHB+PoVD0pOf0Lzophxbrtb0TVFoCCYpM37hS7vCSTQmRbmKylv5zr2ZzMM0xPry86lXO15UmaxLwQAOkJ8Q5/4mLFFRm/6f2snztAtZRZEhIPSsyHAZmksE+qvbJfNqkcTOVxKXYqTyYjpOI3ytYY2FEKCnVGFEBBmfIP4Vk+GzgBPhO8BufapJBu+O05NzZZgaqHHVNeznIkK43BPkW+Im+UuFP9Sq2l0KonQhPx1/GjwfhM4UrMmlZFCv0K+ihUO3yUpSTfqC5vGnCJ3MjRpx/wjXct/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjO+QY9BIMwTt2eiSzdiJ52Z9YWqkR93FraspttOc4I=;
 b=WtLnlwVI86QOi/BFoquhlEcTSReMOp6vCriBkb6DvYxdJ/koZfl8DUKOxHQhHolnDPUdk591eVRADlmtXdzo1P93vIum2xtzI9BXwCsSDVbFo+ma+xoZ5PoDhVrPmSdV8MmL31UVS5aDgY1I+ytCwALar1LqxTA9+RpAQfIPToO5IqsKYLDNauedoFBxmjFMZZuVeAs3a6PsgRyavrRZRDTAV6SYyMnLSBRbUfT6EaUe8LQnDr4jqHyNsDRMUBaB6aabjrgwho+TZtiqTlbaNmFdssGetC6chxAK9wTqbzXKfNl5JPZz8YFoc0uBXYqAodyty3RIS3xfZWnZjPtSXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjO+QY9BIMwTt2eiSzdiJ52Z9YWqkR93FraspttOc4I=;
 b=gzrPXP3Ag34ggEyhE+WPoPJjvKoXjO+5sWKjRthyT+y/WbykKqc8xxtaBHCZxYZQ8iK8LeEUg5XqgV/wVuuZmHoExL4MlSNXFz/N1cO3FDST6P+FCSIHfpVlyiM2nRhpUhFw7MsCyNt3asMDuWFx1jWJPy0bTjHzJIMKJwjbraI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:33 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:33 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 39/69] um: remove vma linked list walk
Thread-Topic: [PATCH v12 39/69] um: remove vma linked list walk
Thread-Index: AQHYm97sCyD0rjubJUedlmNR4cXrAQ==
Date:   Wed, 20 Jul 2022 02:17:56 +0000
Message-ID: <20220720021727.17018-40-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bde32f8-bb62-4ae1-91bc-08da69f62522
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3AELTlRF0J13ToK0NbUqSoN/quDZ8cESJI7xAOmNBaZBKKNjzR1gISr85KuACmyGl5+dF2s0sAcsR2RyRA9nhqXM1LB6Iyn/xg/M3M78nmxNTjgijEQROr7nkGOClkgpX0VfNohZ5VS7Da9rXZFiAnF6ZUvT0LPGQe+koVANa/yGFSbawMjSiQDHA+t30zlaXlG4V2BFqaWlYt20FbSTo1Qx9oNx8gEjxnHSXJQXGWiqItTJNHQrwjoqWK/IjsK7GljOBmtDG+8hV7HXPRFtU5Z48LFfwcQvTKAwCzZ3DzuVmuLtvt/wlHgLHXHJclWSmPFq3Geac3dskA6giA8i8eNCQ02B7tM+VgyIujr1vgKW2a3pMpQZKVVKJskXJUyysOZRoPO3ZiGeJZ0QBJWqatjMI/d8sP2YqU8/pKkMdv/1lQE6hZf60S8Ar+b/cduOwdONsDUbldZIrzWHiXjaLa9d3IjBq6ejZRWe4XW5B2joDH2o3xgbpe1LH87ztMUAmYzgnG5pv3sH4aAgw7hIsdps00QhstQpQkwW2fD/2aKM8M1FZqy3CZgE1Mp8bhs560E7jnIM7QT4qE+4i7JZX6R2E+MgKAqAT9XSWwW9endWUCso3HzKkAjJDGPEaqzt8AJKpPxXBK9RU08joCC5qSqYjrqe81EhbktUHtvLsgkKlgK6aVBgIEFbfgo8BDtMryuLS2h9SHHO9DPMnQeyjK07YGRUh4aGdpHdu/BDIWASbWxjF+yJDvrUxGMWBMF8JYI4nxXHDnxDeq2zauBsa5E6YKuS/3Hqefss3uf5X1St6Gu5jMXPlsJtQibyLyiZgaNRcOr61m3zOjCCGPERhgYpWvLG5uPKH+WZOZ9AQEmxZJFsVi3R3r8nJVV4Ci2i
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ribJmwcWd56YcBPwvQnfxT5Ii1fLavzJ8Sq9BJgSakmgwnoEBI1mCfvVtt?=
 =?iso-8859-1?Q?oIXUqndkqyDEStM3T+VIUs8jFoz2TMEF6TeMntWjrUkjLh7qloN8uPVpOx?=
 =?iso-8859-1?Q?B6dEzh3FpKMyKbP39SKtlhpgQ3XvsIfIeGRK0X02kiygFsLUrbtexjLj1C?=
 =?iso-8859-1?Q?SdEbsczUK71t0m+9l2taUEFRCjW/nH4M0B4oOozLKo2+jMEkrN2Eh3Qam+?=
 =?iso-8859-1?Q?vb2tAAEYFehGPQbc/bST/iok2FQnxlmLuH2eUkFhHy8DtxrqhFp2w37O3T?=
 =?iso-8859-1?Q?wXYcIvDXJKPqwbebvzH/IHeXQCQPx30bOEq13HzfrX3DWBKfBxq/FJboOT?=
 =?iso-8859-1?Q?kdasp+07piC8HxFpRJezGr3ONyT3IULbkJ37ZdNF0erIySO+aDIkep5GZB?=
 =?iso-8859-1?Q?iENrS8saawgjI1Fh0LupmZNDWiZX9AkyDykhAUk9FBbktmd0cxlmd+cAox?=
 =?iso-8859-1?Q?O++M5k2ho0Vd33P8zzm14sLkJ9vJBtBKCOqSHyCfXCNPxT/IdnDxL9eZF6?=
 =?iso-8859-1?Q?bhWuNw6m4PSZVbxEilrxqXqff1NYO1uHTawISpfHWfEA/hPuP+/WWcIs2b?=
 =?iso-8859-1?Q?pmmDlXIrA/RP3sf9Fb2elVmQ+Z6VxHhLB4YakpH8BXS89aDFtlvDDPmsRI?=
 =?iso-8859-1?Q?Asr43qSXLkYj8wMuGActBKkkzGLLH4nl181ZIcAyN/56/ib/0YXxEZHwa8?=
 =?iso-8859-1?Q?Ng9DkKzTNJ6fP4L4xvPXziIv/5DFZEMG81Hb1pNpX8YtvMMoKf4b7GoGkI?=
 =?iso-8859-1?Q?ZVeR5B9zmv20BBQzqVqJT0b9F3PmGt8N07WE+hyhqX/XgubONnHPt5L6w0?=
 =?iso-8859-1?Q?lpSBO+/Ir5WtU1Gs6QyLowNkuS1DmcOBWIFpsIP9jWM7Ll7B8PniDOtWUW?=
 =?iso-8859-1?Q?Lj4Hdhni2ZW//JDDQ6fuXHFV7wvnKTiBbp2LrubYT197URlXVp2SFUFCJt?=
 =?iso-8859-1?Q?C0KaCFXyTsmJcYc8wzi6LVsPb4jlbukSPSLmXLgG1N34reYIVvEk6GgM00?=
 =?iso-8859-1?Q?oIqM6dyFg2O1rQ1bm/CWlDXHORIlsFgoKgqXioH9fdWGj7mSxD9ooE1MwG?=
 =?iso-8859-1?Q?/i7I7gYqTZEj57rgMFHzztS1BCdCE2K8gL+Phjrc9ZHBhMOhCS4BNoAgyn?=
 =?iso-8859-1?Q?yWqTq+52SEUqq4sNUJzzZOKvFwv+WKXV60IzIp4drWFvlMnRM3cFpFFS6i?=
 =?iso-8859-1?Q?qn3+pqbisPsCHZGYrHAZ1bLDBpOABvvcFMOGOVYPJYfH3HEXgXGK+hmNtr?=
 =?iso-8859-1?Q?Hy4wbbqXpVLMrIXPaQTVtR1p/EfAK56NbBK3lplm2PrrkS+DpcrYO+c+CR?=
 =?iso-8859-1?Q?NU8hMESJdp6IXy1eTEWJa2NskvJuyjg+7zGjT/ZteLRKFBgQ2LqohE0j0+?=
 =?iso-8859-1?Q?wvudCu85X8E+elasjvXmt/7YaPUtnKYUSV5yf3tkmMbY6lgLEqN8vfES04?=
 =?iso-8859-1?Q?mkBz5C8UrNbzeVVzIdhD5bdNy8WsqTnEBt/D/QqJsQTz6Y2nR8v2wggJds?=
 =?iso-8859-1?Q?33QJE4V6E2KaAlxSkN5w6tzq4VZwhfUBdca3vR7BCb1YDwE2yC03M4Zb/L?=
 =?iso-8859-1?Q?8bjo1gkBnsSKpYyaaT21+ka9fNKVe930DsIdoo28cB0HRFkTheOAqDI5mM?=
 =?iso-8859-1?Q?COXPOBdfg0ZP8ab7JVAsDopjcrNPWe6nNKMYW3YijGizrM+IA4F20BbA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bde32f8-bb62-4ae1-91bc-08da69f62522
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:56.6180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9jnDa9fv4fLUoxUeupQrgqAvzT3CGkbMAapGoMnGYExedLgVU+8FQlWKvVUN14SmH/tS+tI3yHWPIGH6h3Mjiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 3H5TpPkzZAyAaX-ej5BjQcNH8rnKbBwf
X-Proofpoint-ORIG-GUID: 3H5TpPkzZAyAaX-ej5BjQcNH8rnKbBwf
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

Link: https://lkml.kernel.org/r/20220504011345.662299-24-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-40-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/um/kernel/tlb.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index bc38f79ca3a3..ad449173a1a1 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -584,21 +584,19 @@ void flush_tlb_mm_range(struct mm_struct *mm, unsigne=
d long start,
=20
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 0);
-		vma =3D vma->vm_next;
-	}
 }
=20
 void force_flush_all(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D mm->mmap;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	while (vma !=3D NULL) {
+	for_each_vma(vmi, vma)
 		fix_range(mm, vma->vm_start, vma->vm_end, 1);
-		vma =3D vma->vm_next;
-	}
 }
--=20
2.35.1
