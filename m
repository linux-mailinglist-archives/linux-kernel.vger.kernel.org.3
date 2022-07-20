Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A4157ADD7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241417AbiGTCWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238823AbiGTCVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D076D2F9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:44 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JKVfLC030723;
        Wed, 20 Jul 2022 02:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rZuLsjHuQm40XojwKu3tEiPqr0dSvLlE9++tFcqOprc=;
 b=zzyamyp+VjE2NdYNJdxCav3msJCtL08KYbaGqR3EFz8h+q8+itysdVxuhUp0CQEZm/Ym
 5mjNM8VmZ8PDIU0dO1NuPOi3hP0eDo9tDaJFEC00xGB3O94gM7mhOuk0hUJRzXpdOXgr
 zu4W1nVV1Lz9/a60cr26W2jUvcke4BZ2zKbsn+73oMUdH3rq27cd9YTuLEHVmBtXW/KT
 KIxnZ4EwsnJZdRhO2wPPyCYD004AESRDucrj7IEfzRldiudep9jDh8nNwJiEj4pW2aeI
 ohtUGKRlMEB2Sr6gHErjSC7g2FuDZn0P5iC4cqLpMKTKcUzqjDmwAGzbBsWqfsepQvN3 tA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc7ywb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlp002689;
        Wed, 20 Jul 2022 02:18:36 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuwg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V2EluLaT1AXKjVeQEAjHcnsAqNjCizMU54e/HPIWgKFqbpc/ISdC0Gg2Veo4sOGM0dHW8Y+Q5Nx5UqDVrmopaMcN4Dh4Ah+jHDjnFfjfk5Vfi3NqDBARaYX20ZRnEFQnXTWa2p0adMIFGnFjWrfTsrkC+FVzmo15i4TNOWK9S/TewbG4YVUHrGaahxIX8mbcbOGWD0Yp/pU4GboOLS4X3kf+eD1EUDn0mIu648J+h6WkD8SMNAITAawKNerTLaqmRzYrj2SBh2RYe3wrGQZbm2iHP5SQX5sn+4shBEvY27iJD38G8WJrydKVou9g6z9HiQEfEU9d4CIvnpgL4p/sow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZuLsjHuQm40XojwKu3tEiPqr0dSvLlE9++tFcqOprc=;
 b=drM6z5NF3XvfGTK+5sNcJ1SyKstn4p0FKN3arOA93x8p8STltjDme/PU+3/tBw30bMbuqky94fhIYY3h1ZxPK0LnvpmUoRFphQrfVB1pfh5utJg6/HdQt5VlANoh97I19/bmxHX1O4IweM00eLrtlFZT8E2Yq4tpattbII8LHkPGSffydv9DyjKQFtJCvDjX8xs6qF5DMdZTNB9kGEOlEEtJZE67fM6jA7HhxJDTlgJYbZcI3q/4X/yoJrhrEL0mufYnOBM36CO1alEqvgayWxFghwvUAIou0oDq8QsEMh4HvmGzKjkWZQLXFKyJfqbWpNhfMGo2Pvqdmj+JFNst4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZuLsjHuQm40XojwKu3tEiPqr0dSvLlE9++tFcqOprc=;
 b=IJBycQhsjs7ludunfMgqa7UxN4u8NK+grL1VdyFF83AeT8zk3IYQiFGQgDWG4q9+0lCgiNZkKCBLpDwhH0XYAZpMiXZy9wtH0g510Lq9Qg+nBz8qKYZDiOIVqkfgKTM/lnnQkHHAUMqVVX147S6z03ogQBXQcfspGjnMqNH8POQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 44/69] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Topic: [PATCH v12 44/69] userfaultfd: use maple tree iterator to
 iterate VMAs
Thread-Index: AQHYm97tWWnNtu4IiEeNEdXnKR8rcw==
Date:   Wed, 20 Jul 2022 02:17:57 +0000
Message-ID: <20220720021727.17018-45-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7083172-b397-4682-ca1b-08da69f62666
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n0+o1ZcdkuvLUBZScIVB50BW9erXNUWJcFPdPfRCo1DzLBTHvd09ZEtBjlusacIEt+6G8CXys/MQ+OrQP74ICVmR9avy4/hxN9Jms5UtGAXUUOskQwF7fXY7sb3Wfm8Xxf0hpdMLDRdD3HCjEdFYWisg5vHPCU+tFX1esylw+mAeLRqhCGYLlvtaqlrefC7k7Fti9acv3yiNvOtYw0RoJptBwIXcNz5ZwYvQU2enI3egPjD9LZtq9P3p/ko23W17y9vFkEv2AA0+HigtSwg5YwvtY175vPenyq7/whq/a9sGECfsyGw/jOIpvr5EvTm1Bz4EzVskVQ2snRgMAImwWC7XCV6Sv0HNiJUYs8NJCQ0oppAIoZTAysdcWC1QRfVm87imC+J3ZYnk7QW1vN2ym1QAvdIZE5Wq1z1w9YWh77fd6YFlQmVGKHWxCT8SKrS2DcpLLWoup0Px6UbON4Il8lGcwfhbHp1D0DyHFlO2r0ppp9r3MyrqeeSupH5HtGpuusOr1x9eS8UK8B1rvK5LlR94BfHy29uOHKqgevzJQfpnD6yhzlnizACiCSFbBTeaq/uHUoyxbjcra92RfQ/1mgLg3umG5qjJ6KtKEXG7TRuV09CChxIhP+Bvrn4oGOEu4pICAm9LQWLHL98hbPT0Z2yRc2iYpVmxxuq1DL3KVV6PPk00b26m9P0KReFAcILLiiiuxNA3SVGDNSGSXuG6w4sZW3zSDutngQXt73AEyWbbjvlLm5macW14uu7F88CaAJxCzKqmYPb0f+SGSFFdBdZFYYz885vDZ+6KyCmGjyL3QsWkFrAzD8uWnWp2KyvgOekbG/wQ3RpKqP7/CqS2qTGyzMudeiB4kcLq2M4W874Aeop3+4qwg/062vKcXkMv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TVl9ZeyMxvXRuXhkPOTMI1MxssLYvp8TBKmA6BKCN9aEQms3HD0hDEJiAW?=
 =?iso-8859-1?Q?A3zcTpPcIoeiS8ruFXemKoJg82S8sZhqc1cbsaxSY5UbCrZ8/K7By3O/IT?=
 =?iso-8859-1?Q?PDBFvI7WqIW2yZIarV9asnY1mVME72bglysluDumIkNhREFWAe36BAxZOf?=
 =?iso-8859-1?Q?OnQ2tE7CGPPH4CQrWymRxiSJ1lp+Y46IdK5/M1EI000n332dLc/5P8aEBt?=
 =?iso-8859-1?Q?Y0eMCUy+k2Dur2LqZ8krGK3WJ18VGPwnctoQ2ykYNqVQWKxT2BwI49pnJ6?=
 =?iso-8859-1?Q?/qsI1u1UqjZYnLY5TWhj7xmr3jdgS6utDClj1l63L9dFlyLK77rAZO75fe?=
 =?iso-8859-1?Q?NYSPHNn9RYIB7BUPG3AN1z+F16m4BCe/HOkw9NXq+Cz0L/fcDxXRYnLD2e?=
 =?iso-8859-1?Q?PkVccqbIYe7nFNbmlg74j/N4p2PE1+yvDcnXzofNSSee4Di+RAe+LkvR9X?=
 =?iso-8859-1?Q?+hDKoM90wDkdMV1giLqA2u8qpR9uy5/G6KSHesOdEb8iJnqukpyctqvcgL?=
 =?iso-8859-1?Q?zai9Vgb1jmsTV8wlEvVazt2KybA2FcA/7Tjf7TA9QQ27szS366Kl/N8DzN?=
 =?iso-8859-1?Q?6VHk5ggDMeLJqxdvYsU9Xv4OX3MGdyUd7DtjkyazNm0U/EsZUTCp+wiRLF?=
 =?iso-8859-1?Q?zOlrhkPDqom5JB9Ryn6zuy6vjttcyo+napNOcPIlZIq9NFzEl2N9WZJxcP?=
 =?iso-8859-1?Q?hNFh8QgCjyJhBxmUt8+GHf1z1APUq1Z7l078hc4+RfH+rWbtzWwSPJLp9L?=
 =?iso-8859-1?Q?ViCohNZoAiUvQVNN0I81zBTvxatpKrzk5Jk7mz19mmbIkZEbfeQLgVy50B?=
 =?iso-8859-1?Q?oMZgjBvJAwT/ZYFYeVIZp5rOZyjhCV/2OucT+ejVCxEz7h1CfArOy9N45Q?=
 =?iso-8859-1?Q?K9TcfsWudbF4vmCEduPoFBlodMG1q534O5n2kCLXlkKNNKjVZocEeo5HSy?=
 =?iso-8859-1?Q?YjKqB8P20HQ9eXbvQUoDwgC+spaq7gwQcj01csBLVcjcHwMgvySo3Mvnq5?=
 =?iso-8859-1?Q?uva9Fbz3mTzjCwMvhQGFbRE6SMWCJrSUcEDm2pFoT9jKZRuNqBtQsuPIZm?=
 =?iso-8859-1?Q?lQQlB5pb/f8tnso9s4Eshg4/opVA2spEhW6kg+S1QfMl/+z63WeR5w20N5?=
 =?iso-8859-1?Q?hIj8Ikvn99lSrjbN5bY3TI9UT+CArsEsMVE8Uoc4qdT4tgjkRhBQ+gwcya?=
 =?iso-8859-1?Q?bjB+Z2LOOL7M579bOnSzp8XCUJNaJABPJeMLD/HSdlJPCqqtzY29LrO41R?=
 =?iso-8859-1?Q?HXIkmtBNpwJsbHaIyCYJ0+X2y5FdUHSXp+7Jxdl1vfYfwcn+MONW9yeXYj?=
 =?iso-8859-1?Q?ZA3XS1j8gCrhWJYSUXN+hyIw+kjTenYkr7VFebfAhNeXKCTXyTvV5GZLbU?=
 =?iso-8859-1?Q?wVWsCPD0FFzat/HhNtMTnBgpD5MVimvlIZrSdbGwds0SiAgMXfLBjKvsPE?=
 =?iso-8859-1?Q?boefgQqYvDgOtUvbAS9NZHb35HaR91mycBuPCV3+DJyNz/K0pRk4lRYXTI?=
 =?iso-8859-1?Q?sZ4M1ogqFOR5UY7TGUbrJGkjuUh10L1W8UcEREpPknFVnrbrkvCAzrtLCL?=
 =?iso-8859-1?Q?8AsgcJkJq5A6aKa5/cNKeU3S8Im+r/w91dz9Ztj/6Q6rVMk/D5Mam7cSRC?=
 =?iso-8859-1?Q?gL2NW9DzjDHLHsLlJcEOS/Qvy6xyAfus0Bb+KmxWMwe7CUGQgYecr4qQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7083172-b397-4682-ca1b-08da69f62666
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:57.9772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAY8omypntFDEmqhPddvVs0Drda4j9GGf270oz4bAAvXvH02Bg/cN0aN2e4Rt+mAsyTpgOs6D5AqnftzTP8T4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: GExYgh7pAwzUcgEzhyqyu9dkS_U7WuK1
X-Proofpoint-ORIG-GUID: GExYgh7pAwzUcgEzhyqyu9dkS_U7WuK1
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

Don't use the mm_struct linked list or the vma->vm_next in prep for
removal.

Link: https://lkml.kernel.org/r/20220504011345.662299-29-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220615164150.652376-1-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-45-Liam.Howlett@orac=
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
 fs/userfaultfd.c              | 62 ++++++++++++++++++++++++-----------
 include/linux/userfaultfd_k.h |  7 ++--
 mm/mmap.c                     |  2 +-
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index e943370107d0..fe6f283d26d5 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -613,14 +613,16 @@ static void userfaultfd_event_wait_completion(struct =
userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm =3D release_new_ctx->mm;
+		VMA_ITERATOR(vmi, mm, 0);
=20
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma) {
 			if (vma->vm_userfaultfd_ctx.ctx =3D=3D release_new_ctx) {
 				vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 				vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
 			}
+		}
 		mmap_write_unlock(mm);
=20
 		userfaultfd_ctx_put(release_new_ctx);
@@ -801,11 +803,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx=
, struct list_head *unmaps,
 	return false;
 }
=20
-int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-			   unsigned long start, unsigned long end,
-			   struct list_head *unmaps)
+int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
+			   unsigned long end, struct list_head *unmaps)
 {
-	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
+	VMA_ITERATOR(vmi, mm, start);
+	struct vm_area_struct *vma;
+
+	for_each_vma_range(vmi, vma, end) {
 		struct userfaultfd_unmap_ctx *unmap_ctx;
 		struct userfaultfd_ctx *ctx =3D vma->vm_userfaultfd_ctx.ctx;
=20
@@ -855,6 +859,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -871,7 +876,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -885,10 +890,13 @@ static int userfaultfd_release(struct inode *inode, s=
truct file *file)
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
-		if (prev)
+		if (prev) {
+			mas_pause(&mas);
 			vma =3D prev;
-		else
+		} else {
 			prev =3D vma;
+		}
+
 		vma->vm_flags =3D new_flags;
 		vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 	}
@@ -1270,6 +1278,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1312,7 +1321,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1337,7 +1347,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1397,8 +1407,10 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1428,6 +1440,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto next;
 		}
@@ -1435,11 +1449,15 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			ret =3D split_vma(mm, vma, start, 1);
 			if (ret)
 				break;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
 			ret =3D split_vma(mm, vma, end, 0);
 			if (ret)
 				break;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1456,8 +1474,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1501,6 +1519,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1519,7 +1538,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1544,7 +1564,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1564,8 +1584,10 @@ static int userfaultfd_unregister(struct userfaultfd=
_ctx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1630,8 +1652,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 732b522bacb7..eee374c29c85 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -173,9 +173,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *v=
ma,
 			       unsigned long start,
 			       unsigned long end);
=20
-extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  struct list_head *uf);
+extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long star=
t,
+				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
=20
@@ -256,7 +255,7 @@ static inline bool userfaultfd_remove(struct vm_area_st=
ruct *vma,
 	return true;
 }
=20
-static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
 					 unsigned long start, unsigned long end,
 					 struct list_head *uf)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 29494ff6c0e6..c257f183affe 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2587,7 +2587,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			goto userfaultfd_error;
--=20
2.35.1
