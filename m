Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A187577365
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiGQCwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233577AbiGQCwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05E1F25E84
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:30 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8e2Q009395;
        Sun, 17 Jul 2022 02:48:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QFFWvjBrVBfXldt27a+R8CiZyZq0yB0Cupd4KyZFQH8=;
 b=S3gLvFnsr/zFgu+elnxy1U31nvb2M2pwHi2KP2BwD6vtumI+A2fAUSm3n9+G7wC2+Z4u
 42FC4XVyFBuF1Tcpfq8Cu4mahE2L9UaN/vsHnlhpIxG8Z7cpZ6SrwtzEzTn8BRAkFk4J
 h6IGsrmijJWB/csBYKExdyFxMMwy7YywTwMBEYSyqZ/mIcIcu/pqkh161fFQmzspMmtg
 iarD0COno1a+RcNh/PXDtjm1qCptlQG4cHWEm2yhSC8O+FH9Oqzded78R/2k1W/yqgSJ
 4vRCMDkHApB93IOVZ/+vyubLNvb9Rkk2Ty2QVbmKSHg8eIq+KpHQkIJNUYqZ89o6gLCp hA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3Ka005908;
        Sun, 17 Jul 2022 02:48:16 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d8cg-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STezcL/91b06OcrQ0tfdEVPGBDwA4nELcvJy12C6P0xrslF7yX+6PyF5wH+zBVia5QdFtAAPzexVXdPdyAfkX6lZOQ3K9mbLcozl+xwr95e6xYyWmKjy0RIdS4BsznySaWlwRnMf3klLq4o0oors5wMiCGe+JwmgGRnJzz8Ogyqj1zVNPHwxoaEBwqRJQ42YLNTElfuLSBqBVIzLRcsvpMfKV0OCEdjqX6P/Ku8VH7TzxqrCOHmTgugE1LfiKYVbF4ZIxtcx0YHaw/LkcFiLal+YGSKmiu5erBOhWDhoovlG4h6JBjBVvlmg/KHrnQdw6nrH8gvEzacvSE3M7KMuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFFWvjBrVBfXldt27a+R8CiZyZq0yB0Cupd4KyZFQH8=;
 b=mKc7EBD1pusp4ildjxYMVXEi3PspFO4e2llV6DTGopXNyxJhVcD9/SWutp1KLeOZAPLgnGlFZTk+xgQJOLmYhGPTxlh4jo32oKXnlvy3PEyTwubfFfYhUZ2C9e7DyuNxZ9QPrTk+6/C3kxLwUr9nLREgNufi4RFlyCWYu/snjfSD1T8vKgBcZBImvgXzUAttXnmJng+AXDx51wEdafg2dmV9+BUtbffEXtXXH15bidmcaIIGcCGNIDYx/r8jQUXYPe+TH0WsbHfrUaEKHUsx9gTliIckjFqaBTCanVAKteNM1AyMt0x/SGMj3P9rWppuOF6CLH3+NiJJxle0hAMpJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFFWvjBrVBfXldt27a+R8CiZyZq0yB0Cupd4KyZFQH8=;
 b=yP/55xf7F9i4vFZv8wVSgPCytVXhrE2FW22aR7e5q6t4GeKfUNLD99M84gFZAnu63YLGbgXlT7NDYsTPuiZ0jUE88Wjf0UbEtDilUJTTdUaItExOA7l8ZfoOkt2pjmpZ9Sk6T23bzIYAEfRIsC10Ku86GK9PlJhNQ12/LThl7yM=
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
Subject: [PATCH v11 65/69] nommu: remove uses of VMA linked list
Thread-Topic: [PATCH v11 65/69] nommu: remove uses of VMA linked list
Thread-Index: AQHYmYd7DK2KBLRtPESLnbUqANfoiA==
Date:   Sun, 17 Jul 2022 02:46:58 +0000
Message-ID: <20220717024615.2106835-66-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d965ad8-ab75-4ad9-9158-08da679ec66e
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMpJeXDb6X2AhmWQVXEbBzh0mc0GXSh5DJ/koctKT2ojocy4UxF25ESTsns6NhqbdVTFzRWty001RBy3ClBWk8NDS31o2OwxOkmzLh4Ke/vzHSvMHWzIId5ZdBIcSqxUHO0I2SsAWdeRjEVZ5hF7BkmykaW3NDHTnTfs0u6mm6xlBoF78DnBaadt+Hp/1pf2VZnOz5v88e6UsBIUC+U2dsd1rgzU+aPff/qd7AgQrnLj1y2Q0R4xlCciyEzjRrSBz0mRDZsWBD76J7Rlmd3oauTlKQYesg/mJOaF/j6dQ0aRlleKZeKhp7XWh2TIr48agRJqX4GrPZXpUUlKMPpSsfVmGtFZYtNxauLGMHE6/kownEwkvmnMi+0FQ9PFARkgYK502gnVHNGlUGVT1QfdO6KM9x/29MTx46YZdNS1GmlNyLFI68iskQFkrnc1Ckl9krq+3KyfeqRPG97zUgp+jcSiTSXAJUBl0sIFAEGURa+UQ3k7HJxwSQEbT7y97qtVFgh1KGdyh6cNsKf8tuQqoT8UY8IpXdjLM7Y1IBOgfnCjB34rNyCKyOcXGdok+enPc5DUYfXyvJi1Tdxk0iGLiV8z3YoxtqlSRJB9rkXVyu9d+kkyDoZjfftiPZ0HPbCwCPI4LqdCxRyXJ+aF0YSbNmXPhk9ZhGJ7jHDJKKn0FQx3zjrwdb4dFRyqOf0N5GJrKP07xkWOGSgfjm0c1oT3S+owFKULK/3P5XiDTmfQxGq/6NUuYXiMY13FA60JRD0UPvXQ35yVzDLdYDtcsw//inVw6M1D6mtNT4MfZnwejM8kVW6eGPN7rpKp/m8AlTowYaqoxvKO5HMaY0Mo4AlB255XPAQuHVNmcQ08nQmKzJmtCQPQhk0sVZqSaq9XkH8+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?DnlMRh/pEEGn0xf1oE/CxIFNjIpoQDtQywAytJrpOwWSv7UFQabQn9OQ7i?=
 =?iso-8859-1?Q?PJFkZxwCvJUkihlO6JYjxv2jsxbGUY/2IceTwA6RcPAiPWyXzIdC7cComy?=
 =?iso-8859-1?Q?gvRaHWOMRF23WCIkA4imURkNKYkHwX7YOgbCyZ/VaDuWxqtxPNVOc2tmKl?=
 =?iso-8859-1?Q?nkh2dPQB/7v/CAtBlXDIt42q1ZHKaf2W2Ey6q4H5EzaLjIm8U8Upe5AObj?=
 =?iso-8859-1?Q?q0hf7DNBGjPGZn8RoqEwK1pdlJECaaGKA7ca4bQZJm+OG0/h9RWYPjCCLI?=
 =?iso-8859-1?Q?mMKrNakft6dDXGBLBvi+GikKb+n2wo9xMtG9EcA1U2hAN2mTDjlbsRL/yu?=
 =?iso-8859-1?Q?liezxDk1SPidhwMONeum2FJKsfkkCqJ+asHjuLeLyM2JsG+d1qaoA8zAyM?=
 =?iso-8859-1?Q?HdhtymkAI+7+C7gSHBWNYzrmnUlVYDnOHo3Z668hh6mSTaFZUsBP5Ce3DE?=
 =?iso-8859-1?Q?J7LKpJK/PBmdFEkyRr3i44QWAF5GcCQPRJwJIlMj3kdLx+PonwtvMkGNgj?=
 =?iso-8859-1?Q?XGJebNEPqxz0tQxUbd+4135cMlFqm7/fbF1wZxFx0grcZXyIJg9OS3GKfe?=
 =?iso-8859-1?Q?P9cDbWpXWYogC6k+MneZeImftQRUZHyyp4ORBFBBMRA/90yuO/wFGc49I9?=
 =?iso-8859-1?Q?GcUTaI10BpVS/ovuM9tOzyxJxe7DTyjexipPHJnjPKmLNtb9yQ6DA2W/jm?=
 =?iso-8859-1?Q?UZ37FXWokba+B0z3l1MdjDVBHwdfCqh8L8+0mDPEzrcwAohJZaLePN8RUO?=
 =?iso-8859-1?Q?jGf+8U2t/Hvx4PgyT2nLrmCiX8cDu2MEnVZ062z61LYf9U6ba3D0oqo28G?=
 =?iso-8859-1?Q?Lk1p26a7cwBSdaKnO7qhK+BDjnlKHHwH60+qeg7W7d4udhRQHqvVko4t3a?=
 =?iso-8859-1?Q?/X1/0fHm1PSArj3juQB3zBJnE948J+gyBiy8vyswCO+m3jg9+VuVgaWCnh?=
 =?iso-8859-1?Q?994Z8TJzZHmxdIa8FQV9YB2zgodf9aXwaEaahevMltm+GEefCFso7x490g?=
 =?iso-8859-1?Q?01Ce2xTcz+luaFVLXS5SgRDAAKze4G525JO/Bu9+MFXJE/qZmL+0TCN6Eg?=
 =?iso-8859-1?Q?HBHLqmhxkZSWr/nwD2n3f4mZrUdMkV7jcnvcGDiC4OpeC96prNGpj/PtWu?=
 =?iso-8859-1?Q?tg6oe/ZCuCXMGnGiqF/FVdpKUqYyYFoeDZ5KE/hq90Rwh2cTMVrZeQNrov?=
 =?iso-8859-1?Q?S814mMAoIkZgijYW47u/9m+MXS3V3d5EMHbKAb5OeW84KbUEbLA3pk28/V?=
 =?iso-8859-1?Q?hQPauVHloh78CMhxGotuHWgSw7djPkIzJiPLU0AwDv59jgDvcTgULcRJ8h?=
 =?iso-8859-1?Q?j9k9x7wNS0+LV/hlJwO8Z7TkTRSeiXwTdGrvqZwh/72t7zDHN+ygOGn0Zs?=
 =?iso-8859-1?Q?OG0Hcq2zC76UpMyJR3oxOJ7T9E5eVDqgoccqw/CgMe2TYNSPGwHuVw3lUd?=
 =?iso-8859-1?Q?txE/gyUh3ND9b4HUfdu0OqlX5vWEKzOLXGbLf+oqYepxR4Py7B05oJfg08?=
 =?iso-8859-1?Q?LPoRS3rjIWOdGL9qqXYQCbeONgIu0NH8wbo7vq1p+zvTSnwJaUeM6GSBrs?=
 =?iso-8859-1?Q?+ppUzYoTLtVh3ffu14WW9vGG7qBkYMWhp9RLvYqwjGmUxVTmZueSFIZOLt?=
 =?iso-8859-1?Q?dDKFu5vcvriuDlVXfQvIwk2t3/DTE+7rbUayOiEq2/kfbagBaRNFhLyA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d965ad8-ab75-4ad9-9158-08da679ec66e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:58.2083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Aw14VTYfZ1wOKTkJXreNHIhx4cQtkoTnUXkuiD8zFUyd/vfnlarkByo7Pf+mr93FAip+8nqCu5ihwHcQXxvsQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-GUID: rtZ08uus0q1y5WboVUZicC7C9O9dOk4D
X-Proofpoint-ORIG-GUID: rtZ08uus0q1y5WboVUZicC7C9O9dOk4D
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

Use the maple tree or VMA iterator instead.  This is faster and will allow
us to shrink the VMA.

Link: https://lkml.kernel.org/r/20220504011345.662299-50-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-66-Liam.Howlett@orac=
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
 mm/nommu.c | 135 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 34 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 4ae252a785dc..f6b187090d95 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -557,26 +557,14 @@ void vma_mas_remove(struct vm_area_struct *vma, struc=
t ma_state *mas)
 	mas_store_prealloc(mas, NULL);
 }
=20
-/*
- * add a VMA into a process's mm_struct in the appropriate place in the li=
st
- * and tree and add to the address space's page tree also if not an anonym=
ous
- * page
- * - should be called with mm->mmap_lock held writelocked
- */
-static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma=
)
+static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *=
mm)
 {
-	struct address_space *mapping;
-	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
-
-	BUG_ON(!vma->vm_region);
-
 	mm->map_count++;
 	vma->vm_mm =3D mm;
=20
 	/* add the VMA to the mapping */
 	if (vma->vm_file) {
-		mapping =3D vma->vm_file->f_mapping;
+		struct address_space *mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
 		flush_dcache_mmap_lock(mapping);
@@ -584,21 +572,52 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
 		flush_dcache_mmap_unlock(mapping);
 		i_mmap_unlock_write(mapping);
 	}
+}
=20
-	prev =3D mas_prev(&mas, 0);
-	mas_reset(&mas);
+/*
+ * mas_add_vma_to_mm() - Maple state variant of add_mas_to_mm().
+ * @mas: The maple state with preallocations.
+ * @mm: The mm_struct
+ * @vma: The vma to add
+ *
+ */
+static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
+			      struct vm_area_struct *vma)
+{
+	struct vm_area_struct *prev;
+
+	BUG_ON(!vma->vm_region);
+
+	setup_vma_to_mm(vma, mm);
+
+	prev =3D mas_prev(mas, 0);
+	mas_reset(mas);
 	/* add the VMA to the tree */
-	vma_mas_store(vma, &mas);
+	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
 }
=20
 /*
- * delete a VMA from its owning mm_struct and address space
+ * add a VMA into a process's mm_struct in the appropriate place in the li=
st
+ * and tree and add to the address space's page tree also if not an anonym=
ous
+ * page
+ * - should be called with mm->mmap_lock held writelocked
  */
-static void delete_vma_from_mm(struct vm_area_struct *vma)
+static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+	mas_add_vma_to_mm(&mas, mm, vma);
+	return 0;
+}
=20
+static void cleanup_vma_from_mm(struct vm_area_struct *vma)
+{
 	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
@@ -611,10 +630,25 @@ static void delete_vma_from_mm(struct vm_area_struct =
*vma)
 		flush_dcache_mmap_unlock(mapping);
 		i_mmap_unlock_write(mapping);
 	}
+}
+/*
+ * delete a VMA from its owning mm_struct and address space
+ */
+static int delete_vma_from_mm(struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+	cleanup_vma_from_mm(vma);
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
 	__vma_unlink_list(vma->vm_mm, vma);
+	return 0;
 }
=20
 /*
@@ -1024,6 +1058,7 @@ unsigned long do_mmap(struct file *file,
 	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	*populate =3D 0;
=20
@@ -1042,6 +1077,7 @@ unsigned long do_mmap(struct file *file,
 	 * now know into VMA flags */
 	vm_flags =3D determine_vm_flags(file, prot, flags, capabilities);
=20
+
 	/* we're going to need to record the mapping */
 	region =3D kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
 	if (!region)
@@ -1051,6 +1087,9 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		goto error_maple_preallocate;
+
 	region->vm_usage =3D 1;
 	region->vm_flags =3D vm_flags;
 	region->vm_pgoff =3D pgoff;
@@ -1191,7 +1230,7 @@ unsigned long do_mmap(struct file *file,
 	current->mm->total_vm +=3D len >> PAGE_SHIFT;
=20
 share:
-	add_vma_to_mm(current->mm, vma);
+	mas_add_vma_to_mm(&mas, current->mm, vma);
=20
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1217,6 +1256,7 @@ unsigned long do_mmap(struct file *file,
=20
 sharing_violation:
 	up_write(&nommu_region_sem);
+	mas_destroy(&mas);
 	pr_warn("Attempt to share mismatched mappings\n");
 	ret =3D -EINVAL;
 	goto error;
@@ -1233,6 +1273,14 @@ unsigned long do_mmap(struct file *file,
 			len, current->pid);
 	show_free_areas(0, NULL);
 	return -ENOMEM;
+
+error_maple_preallocate:
+	kmem_cache_free(vm_region_jar, region);
+	vm_area_free(vma);
+	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
+	show_free_areas(0, NULL);
+	return -ENOMEM;
+
 }
=20
 unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
@@ -1298,6 +1346,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	struct vm_area_struct *new;
 	struct vm_region *region;
 	unsigned long npages;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	/* we're only permitted to split anonymous regions (these should have
 	 * only a single usage on the region) */
@@ -1333,7 +1382,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
=20
-	delete_vma_from_mm(vma);
 	down_write(&nommu_region_sem);
 	delete_nommu_region(vma->vm_region);
 	if (new_below) {
@@ -1346,8 +1394,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	add_nommu_region(vma->vm_region);
 	add_nommu_region(new->vm_region);
 	up_write(&nommu_region_sem);
-	add_vma_to_mm(mm, vma);
-	add_vma_to_mm(mm, new);
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+
+	setup_vma_to_mm(vma, mm);
+	setup_vma_to_mm(new, mm);
+	mas_set_range(&mas, vma->vm_start, vma->vm_end - 1);
+	mas_store(&mas, vma);
+	vma_mas_store(new, &mas);
 	return 0;
 }
=20
@@ -1363,12 +1420,14 @@ static int shrink_vma(struct mm_struct *mm,
=20
 	/* adjust the VMA's pointers, which may reposition it in the MM's tree
 	 * and list */
-	delete_vma_from_mm(vma);
+	if (delete_vma_from_mm(vma))
+		return -ENOMEM;
 	if (from > vma->vm_start)
 		vma->vm_end =3D from;
 	else
 		vma->vm_start =3D to;
-	add_vma_to_mm(mm, vma);
+	if (add_vma_to_mm(mm, vma))
+		return -ENOMEM;
=20
 	/* cut the backing region down to size */
 	region =3D vma->vm_region;
@@ -1396,9 +1455,10 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
-	int ret;
+	int ret =3D 0;
=20
 	len =3D PAGE_ALIGN(len);
 	if (len =3D=3D 0)
@@ -1407,7 +1467,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1426,7 +1486,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1448,9 +1508,10 @@ int do_munmap(struct mm_struct *mm, unsigned long st=
art, size_t len, struct list
 	}
=20
 erase_whole_vma:
-	delete_vma_from_mm(vma);
+	if (delete_vma_from_mm(vma))
+		ret =3D -ENOMEM;
 	delete_vma(mm, vma);
-	return 0;
+	return ret;
 }
=20
 int vm_munmap(unsigned long addr, size_t len)
@@ -1475,6 +1536,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1482,13 +1544,18 @@ void exit_mmap(struct mm_struct *mm)
=20
 	mm->total_vm =3D 0;
=20
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
-		delete_vma_from_mm(vma);
+	/*
+	 * Lock the mm to avoid assert complaining even though this is the only
+	 * user of the mm
+	 */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
+		cleanup_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
 	}
 	__mt_destroy(&mm->mm_mt);
+	mmap_write_unlock(mm);
 }
=20
 int vm_brk(unsigned long addr, unsigned long len)
--=20
2.35.1
