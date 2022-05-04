Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B32A51936A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbiEDBWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245456AbiEDBTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73BD44A17
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:15:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KnJSI013484;
        Wed, 4 May 2022 01:14:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YutVnEIoxxddCFxV6W/XrN/pgLPRVBdLjD5Tm/ZbBBM=;
 b=K94f3/gsQ1kX0suw129qzu1PiyoC4D6Zj1v4IindAp2e9/TaHyoQt9TOzBYxIeJywsW5
 lPsqThYXP/o3/R966OJ4/tzSlHul1DLnCVvlcGaJQeXqp06kKAxGWzJH5kWEJMxlnV7d
 wBvlf62vsicUE7aE+iOGOQywdPsp7l1FIvZXrCQPzaXdDnG/cJ+qXs8dj9DZDyNJcPBO
 f94la96IqAuk5m8eUuga5Z4ZyTP3uBSgysE4ZJalPtzoqeQzTR82Lh9N8iivV4nkuZTP
 JZ3xGUBd228WmdnfVXpxFpiVfJwHXBqV5vtjqMj0SuUC2dgAe/g4sdjgfhJ+24/Y6j+c SQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR8013207;
        Wed, 4 May 2022 01:14:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQECeDZ7r6SeXIZ678c1o6U5upPTzkTzaYDyyZodEZ6dsq5xY2L//DzYeINLJdj8ThqGJPC40Tc5e/TNDT852yQF2pTNvO6aaPOPgHX4eqPGnwFN7a00tEddw0xydl9FxSmRejpdTkeESpBnUX+XnwCD76Bp2Ito7RndAacwMuKqSVnmNc0XJhOBGsUZiJIjs/24mTHMf+LJs8NBzeDwx0p4kG97E4J3kdc++PAip8u4Dwh5+8aPgYW/7gY8VgnSS6qlVT//lJhO6WFkV7e9rAqmGTlOykF1nz8TQIzr7yasPRfYoSEGyoCDL1yUP97YHn50B4B3fKqjymp/Xl+3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YutVnEIoxxddCFxV6W/XrN/pgLPRVBdLjD5Tm/ZbBBM=;
 b=UkZxLWHTwWvjUEhvsku4FgnrXQwGZzG38/KN217E+C67ld8n6QkF7HSowuNUL/mBXs8QMO74sc2RvYDTSigdIGBmTrgAyc0NtT4f0sM6xX1H0wT7BoqXI9J4BqsOwFnOGzOg2JFWrEJj1hs/ZCJack298k79Ph8WqUPkmg8hYXocRCrZE2gV6DSWumkZqfZygUQ90w9ZkNwhWFZvPcZn9jfkUiwhEeFDpC9e4l5rnZyRHhJYMfSeh+xz/pmyqrri51+MMRLNz25Vtapm9lWGhyak6PMid5gyJctMIpBCissYU/ubYz6tO3C7t5fFTPJhQL4zXqZGVz5lVGM9so+GXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YutVnEIoxxddCFxV6W/XrN/pgLPRVBdLjD5Tm/ZbBBM=;
 b=cOYwgCSGIJoj24n6dPomtgF62YaO9qJ0R3mVyYzotUHVUmf8vk1msHLuSM4WmS0/U3vIBl16VaIR3WUiIytSkHHssTVLWHz6DOtx8Z737X4TqNEPQ/UztaV5Ln8VIwUm/M70z0xbRuJATmzuT8ayjn9q5n2zHia52ezk+P8y7wg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 69/69] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v9 69/69] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Index: AQHYX1RBmRO5roYk+EqivuVFKMNhlQ==
Date:   Wed, 4 May 2022 01:14:08 +0000
Message-ID: <20220504011345.662299-54-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4eb3893-a49e-419c-8013-08da2d6b7847
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2688DC5DD0F31F257911DB3CFDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nVrl6EASfBv+RY3h76wIyUlFYwQ5McWL9YamHdB+1t1sdkIoSyyS09RNeoIkVnF8FPiQRjUJD7GtMI3tC1IojzEQYd8IHyCMFTjSrm/oaBYJZ6492Wi3les12+qGjZL5L9FeTH5dUcBZEwDspbV0PY+4gsf+LJ1CQWAdZqRJrdun9D2uRuFexM6XAe7a8KISqmQIKGr+9g5XowXymwaK0/WvTOJxGdFTWDqXnhE5twgkYzq0qgGFtg4WeMWSZt0BsHPtp/IVXk053NimsrPQs2ShehqwNfudtYkY65PqueUXraDcP58y20kpUBR8982pACzX3y3FevqboR1lTEVETexZdcdNdgV9VqLtOPonb7p00dq2JO5Np9z1fMXQdMFWFimW5kyD8qs4hDEQu3B0GsMzQyVkJStlp/sMP9TfyMymCbwr4QNczWP6d4R48g+0lfvqUio0iCuowm8wrxSL2cwF+hw6d9nQ3WwbMBOINT4vGfWEHboka+41kY4DZCf23JtVptP6+9+G+OOxCgU9m7Me6U3uMhYB3APTpntOO8gggEAy9gDdgzKeyFLmoTFX5C3gsxhH+DJ06qOH9ezVrX3Y3n8Xv2mXKCueKCjeqlTb9sRB+9wgD0Qf1JZcKifSzgOlnC1q6qiTyty+u93EpXautZwYANqGGgXclHg7baccQ4M8xbu6V8G+u6GCNolUHbLRq/n57yo1axFRxaD2fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PvZJOkc/SRgyiUXiow8LZluZM3aLy0wxL4TtTqVuqSXX12kO5B8Co8BU0x?=
 =?iso-8859-1?Q?HkFwF4/DmGX98ytrMrd2ueD/q2N8CZlijkDnJtwydEuEIFBRRD98YFPV0n?=
 =?iso-8859-1?Q?oWZ9byMksSh/o5wr0Ob0u/fzMsIeMaZD1kbua2fK9y5WJ/+t+HS3Z048gX?=
 =?iso-8859-1?Q?mpS0KwUBD1/sNb03vUIB+ViFduuR04rV7yo7EDVGKxCXuk5A3BTW7tXe/N?=
 =?iso-8859-1?Q?A89tW7SomnghUdGskiSp7yN1gBQrxSJdgtSV3l9BdOKoET400u/oSulLF/?=
 =?iso-8859-1?Q?kwgKmtRo4Zai2jOGMpFssewsruPgXoWaL6rB2UmWyP0l4BGUXFOsIDkOpP?=
 =?iso-8859-1?Q?4LMRs6vn1Y/MMSdy3AdfNMzfZA9eQM0nu9EyzNnTB2XtuU+L0Y4Dwdtxzn?=
 =?iso-8859-1?Q?zOFxHt4G8g4PDyzDgz7K9/SdhjyYnNtM1QLN7vt+qIsg3pPJN3tW/CxKrC?=
 =?iso-8859-1?Q?UM8CQPqYYj+kRDr6OPnSsJ5uQEbyAlbtxdWEGY9/JCMIr+0YH9tXIczvRx?=
 =?iso-8859-1?Q?bJs1xRXkNhBBO14b9TO6dCxXilO/Cumnzzf89k12BC0sWEztWLZj8FELDb?=
 =?iso-8859-1?Q?mLzcO1Dj9B1/6TnGjO+U5V4JmJX3PCjnm5m2gUppk1spYJpVxXqDbo9NTM?=
 =?iso-8859-1?Q?kmPLuQ1cndh5gCa2e+aLrr8EZ4RXegoMhb4DoBtIwozGG15ezh8YdkouNW?=
 =?iso-8859-1?Q?xqC224qrpbwyJx3FgIeqtLMzpT9xfR5tNQ3hrPccBkqIEocF2vBKvZACBw?=
 =?iso-8859-1?Q?D1eHw2YGCyJVSK0NQ3/utcslecruDUe6SNmQFKzaxmNN+IOqNlzE2GB7uh?=
 =?iso-8859-1?Q?dRGNapFNwOrVkoPSJk9pC8u4QOgeXM6qDNJro1CPbB4hbM+QvbFN1s9yBE?=
 =?iso-8859-1?Q?9+CtaageFbNGLhhXUZywH8yIU3Jz3ZOCMGxNdOylirc1JsVXJwHm8c3TyH?=
 =?iso-8859-1?Q?iykYqZYEsv8hG5nWQYKQWx7nCjSvfFtmns8T6WmCWZZHHb48Rh0/upNqzI?=
 =?iso-8859-1?Q?UZZRNJHslzZRYh8/jlva2HQKgPbZYfc1xPZb1e+A7bP+46Jevlw/7yfyRV?=
 =?iso-8859-1?Q?gOYhNDUO7BTPPoJrWIISGqIXwMDdoQgF4G/1GqgHSnaZc8lqCq3I/p8sTK?=
 =?iso-8859-1?Q?KgoYA5JtlDWu7rNOiZcUsHLICxejLbJiEHg28E/mAnByB9vn1Re8TrwoY9?=
 =?iso-8859-1?Q?pmHvcpo7TZQasrQ21FkypTzTmrQEdUqeiJf1xoWTXIIMc/GRQNz5Nn0cuG?=
 =?iso-8859-1?Q?yv1N4UaR0fqLd9q6LPpcpK/puVnFQNaUaHG4hbAxczxOh+BDMUiBm6gmM3?=
 =?iso-8859-1?Q?BICreu5zZfuCcWaHLGCdcV1OntHyMnRhGosXsm073gNTFR42I1uqcNHOJL?=
 =?iso-8859-1?Q?zu7EfPyycbwKSzVKvtNaU/G205+Oq0Ufa6+v215ASMsqO7qIor2yqaWm61?=
 =?iso-8859-1?Q?CC4lq06Sm03LGqeEngUYBtrEv3sfu0eJ9ChGi/0qi4oHfoWHNPnRFKXFqb?=
 =?iso-8859-1?Q?MrfHIJHrXMzn8/HuaHnauiz+GIxIRLBH9J9m/Fr02fNqsW6CHEuFGpeA5m?=
 =?iso-8859-1?Q?y0/qJGyrwaWgBRry3lQUt9JWTneY1OwNyT6GNYVmS3T+p6xmzMgD7gXdVl?=
 =?iso-8859-1?Q?5sklkBC4o04YjEoxvKbiYVGDVdh+rEDSRPkIT7ITilVmNtLwYltN7oA3D2?=
 =?iso-8859-1?Q?TZ3ou/+7ISg7bnrvt+1kh7qxP9l2+67HMK0CjKsEI5wtPV6e5Ssg2b168R?=
 =?iso-8859-1?Q?StfiQW4SwKu/NvmW0yBm06R96UieIOAYaZJI/U6iVHXm0fxJ9dr0GIIwy2?=
 =?iso-8859-1?Q?yo94F9O9/ZJtAL9kmAJUfPkWaBrApnQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4eb3893-a49e-419c-8013-08da2d6b7847
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:08.2353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuz8WckZSdN+5qM5xzDh+6dwZcAAtlMy+52yB//GTOM0LBies6uenpuVmxI6In4eDhMO64A7suEFbdWWspQdTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: oAE6zTeW5Xt9Zb3ZhyrSTTvQtXQBNQmR
X-Proofpoint-ORIG-GUID: oAE6zTeW5Xt9Zb3ZhyrSTTvQtXQBNQmR
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

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 32d3922cec27..c4d79d901085 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -246,6 +246,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (brk < min_brk)
 		goto out;
=20
+
 	/*
 	 * Check against rlimit here. If this check is done later after the test
 	 * of oldbrk with newbrk then it can escape the test and let the data
@@ -322,7 +323,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
 	return brk;
-
 out:
 	mmap_write_unlock(mm);
 	return origbrk;
@@ -454,21 +454,15 @@ static unsigned long count_vma_pages_range(struct mm_=
struct *mm,
 	return nr_pages;
 }
=20
-static void __vma_link_file(struct vm_area_struct *vma)
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
 {
-	struct file *file;
-
-	file =3D vma->vm_file;
-	if (file) {
-		struct address_space *mapping =3D file->f_mapping;
-
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(mapping);
+	if (vma->vm_flags & VM_SHARED)
+		mapping_allow_writable(mapping);
=20
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_insert(vma, &mapping->i_mmap);
-		flush_dcache_mmap_unlock(mapping);
-	}
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
=20
 /*
@@ -535,10 +529,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_file(vma);
=20
-	if (mapping)
+	if (mapping) {
+		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
+	}
=20
 	mm->map_count++;
 	validate_mm(mm);
@@ -779,14 +774,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			uprobe_munmap(next, next->vm_start, next->vm_end);
=20
 		i_mmap_lock_write(mapping);
-		if (insert) {
+		if (insert && insert->vm_file) {
 			/*
 			 * Put into interval tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
 			 * throughout; but we cannot insert into address
 			 * space until vma start or end is updated.
 			 */
-			__vma_link_file(insert);
+			__vma_link_file(insert, insert->vm_file->f_mapping);
 		}
 	}
=20
@@ -3019,7 +3014,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	struct mm_struct *mm =3D current->mm;
 	validate_mm_mt(mm);
=20
-
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3077,6 +3071,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		goto mas_store_fail;
=20
 	mm->map_count++;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
--=20
2.35.1
