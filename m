Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE0D57ADE0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235154AbiGTCTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240994AbiGTCSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3B48E95
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0mq6W017914;
        Wed, 20 Jul 2022 02:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zqRrn7Mis9LlyuQp4YTfy99I18loFpNVtNtizigiyz0=;
 b=ljsP2nqj74Kh1yRJkYd9RJUCt10Eek1B2r+S9kdHDOV83UhVQ0GDxTIjAvDKt2Emwwej
 +V9tfbMgBioTuZRdnTCKggWdSWisCeBSpJlRMYpVsmo+TWbVKFtJb0Orf8meZcSws6PF
 nT5AifNVqIT5FDPOHPUf4f9pbAm4BL+sN8qO6JwyuVTmcK1TwNJj4BMxCIqh9ZB0cmJz
 aOYqI+ySjuOvK3etJBluJ5cKfsh0PHKr536KrtE657H/PTBmlI26S3gm67M4+eyvzpK9
 TOX9YXjwp8eO6V81x1tyj4T8DmOPzebcuS74xqb31T4qq8w1Sfh9RKAs5CXW+SL58nU5 vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107t1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2CLIb002698;
        Wed, 20 Jul 2022 02:17:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnupm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U8m6CovJjn+UB0u2Hh1AuTvNVmfkcsGUcTlfGLh4yJZ4pbFjEHvEIVaFtI8ADY/D1tU6sbVXTmcjor7vtqtZb+bEsE90IJf03gojBbjvvENT2NGibA3xDSxkj09XB/znalkZoDVvpFRXeUIitMBK+GT8dKULT9VX38K1XlGFNU2gMQwXkyMqdimGuBIcvlMX2KZGII1wkuWvYvuxXAE1RFRQi3vTpuWBhvL+IPqpR3MedW2GrQLfSwzRd1proMs6FJGG/3WoZoqQxNp2Jm+8BR879Bf74DoOR0mPcnuQCpFiy142h78w4GOcJl0nhh84IW4AkjPxBYBbvBCfR2NeXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqRrn7Mis9LlyuQp4YTfy99I18loFpNVtNtizigiyz0=;
 b=LCu7JHmOGlqWNhPMkS0Sow0x7g1pAcZ0SvB4dpdwDJLLeLjkSLBthHAkUC4+78NVD8HLVUYl9VK8pfAP+wOLtxIg45I8QbTzclMH1HDtpcIhmxFKk08Ko6h2j3vuQPWQNj5A8ant9FP1KC9t1Zj2OY8NKTDTnkrSU6I08Mz15vqJJ/K4JbviytGqOOfw9nGvqdosTkHZXhyqzwW3Y3SEjcWN/BdXWfHSJlJaHGzLqajM+ZoUlKyrM3DG9z3HFmPW0Oxhp00tWrj56w+98895DCMc4Fg770Fzi8n8sn3Q3QxHxzP8qReBYqEjV08s/HeoLMbgHEx8chHzXbKM2ELixA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqRrn7Mis9LlyuQp4YTfy99I18loFpNVtNtizigiyz0=;
 b=nsFBJEw2bmOvuBzPZswmrj15JIiPUzm6GMc44knLeNcWXv5ZGQDDvvOMCMQt48NuL4Kta0IoDfyeJr/5vBgVapQQVH70Xu6CPVdugibGGkgZ+n+OOmgVG+raWQOo3bfhkyST4vsgQq/F704BWQO113d/2yzWUl2txYayw7Z7sZQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 21/69] mm/khugepaged: optimize collapse_pte_mapped_thp()
 by using vma_lookup()
Thread-Topic: [PATCH v12 21/69] mm/khugepaged: optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYm97pZcMtud8hME+xQzxx/jT2zg==
Date:   Wed, 20 Jul 2022 02:17:50 +0000
Message-ID: <20220720021727.17018-22-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1110aafb-19cc-4418-547c-08da69f60e0a
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mgSRwRMWsxQfzV2oJHl2WYmQb5AzLdn27PbqMbaZoooNWff0mL2E+GEAqORJNzOOYuqptm9rHyLh5Goeam+SWdb4P3jeQnm+vhL0n7jl+x/cExnnzhHUHTquJsa8BvikZEvQRc1X5wHohPW/2MMBTQBhBfkIFn0axcX3y2AP9+QmSxbm+63FudDJ59cmiZM/m45C0b50j5nxZCYz3MmgO4FLPibUplx7KEuzPULvTZV6jMzfHvQX/cmMygwlSI/+QF8oYcW8M7FrdfA05VjVsZVhfRZOmMac4EDLqwxbdZ1DuzRVJ7Q9gJC9ldN/HNPHPfwejl98mHZgVdECDDmQfFOl/fDuELIsBxrLIoURuaDqmrhXF5QuJsHydncbs31EByBURjsK0eodJJECVW5YKIAQj40tQjCP58iusgV4V1JLKRQVRtSaux9BW+UrEwJl1UmMGUoKKc5/pg/1wd88drbm/NrDrKzsNekn2M25tbYRV4e2cCaaXQRzoTc+WeNcRaQTcBleynmZIlYPRdlBWiO8kKhr7caxdASCe/xivs267obdQDgi9w3/3Rmp4yvwtfx75Knyr6e4E9ABhKV4Qlz5D8b5v5LwgEgj1KzywF+Kpu59K15GJOUSGQgpjHksrNnE19mD31fPcz+/72Ri2uu0z5GSiqq63LmaIk2G3gMRS9pFGnukEKhE5SN3RjgYmxhd08ynMMxQ9PS9Ld/PPtkNLxCiUzME03RnpAGaL/WSb+JH0PjslJzT6pblr6UaL3UxHMMImB0L13kHUJ5LoikXCPvQgUWVXGaVMqU7SdJyDo3vsONKmBbMXY3nfl9I+nLb+KOwhpEQChp40mIsrEMwnDj4OszdaX85KPRdSNjV18fSlLqv1K4qTCJRVjaS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NR+ZRCGVIyE4yQjlp1qBbqbINbN+ImUp3ly1EwwQO9FRK73vrvn1hEhRIJ?=
 =?iso-8859-1?Q?UUGnww47Ka50W8OsGxRq/rsUttMldwFOUDaUfEfUrRSYvy87y2Rgnb4sXh?=
 =?iso-8859-1?Q?4GpCH8bQnZ7I4Y1PlpIQst2f7C9WwgbiI+NrE/ZQT0fKr/oTgIelyCqRbB?=
 =?iso-8859-1?Q?VcBzDRV8zVtw9y9O+IRWAe4dGNHZ1Vr/TujiPO7hvjfZdHzfL/7ijUB2cb?=
 =?iso-8859-1?Q?udsib8pVazgd50HbtfWCSGgMhoznmAHTFqJsl48cfGPWype8U36/AjPQeg?=
 =?iso-8859-1?Q?CYIfeLG5uLpEbqJard/qPs8VPouBxe4397vHfupvsM7le6P3NFFbY0otKs?=
 =?iso-8859-1?Q?MxP4VZql37wpDzJG9YPOWMi9BpqwhIjcb9sLDvo1IpxMYQdArVFxUsuqpe?=
 =?iso-8859-1?Q?m2/KB/N/fx/+Ijk391YDuwmjgeeEUgUYw1sO6xO1EZ80a4UJS8djSnewqI?=
 =?iso-8859-1?Q?LKiaPva1f2zaB8Kz2H0LBFwqlATrgOIKLUxFqUzs7XsTMWR2PPG/5iv9wT?=
 =?iso-8859-1?Q?0DZwJseja4EC24hHCYu3ei1p259Dqpw/2AHtygaqXLJk5XDc1QHHKMB6Bx?=
 =?iso-8859-1?Q?nR4sTRr2HdlzY2C52kLaD8Qe85eB/sWbCqtjqyw5Y1jflNMm5FW0O9miIU?=
 =?iso-8859-1?Q?/J0emdTDhcqyfhN1ChS6CNVMOLlidMcgWhVfdakIZoiEM4aScKBVCvAfbV?=
 =?iso-8859-1?Q?jyp6hQwgLxSflHt1CL9FaZOC0o4Ye3BR6KSHVxYcvS9duDZ9uOlTp/VdKh?=
 =?iso-8859-1?Q?58EtWh1CX4r8vK7FFKlbgVw1QpMK+3o0O/jfoFz0OF2VFkXSAJOohKaVRF?=
 =?iso-8859-1?Q?XHDoDrLvavoTn63OikMfqPPllTQRBxNdsUDjyz4HwN4DYu3duCEcSyZT+J?=
 =?iso-8859-1?Q?XvwFQCzYfo96SbbSCWID4Ig+ZB0AjydmsGBTzm9ipTciF5KmrAClsxV05N?=
 =?iso-8859-1?Q?DcNIcu4u2uwy6QgQDSK8UfR7yOkr22sG/Ncarm/0e0Qkwm6vd1bUeu8nmR?=
 =?iso-8859-1?Q?G9fujzA6xgTyPgVFTWOVnECtYnmeS2LYcGcaxO5hX8SO21Yppu2d0Ga3JV?=
 =?iso-8859-1?Q?wO4g/4/3J2vCX3165bVw1ob/FKCnob9HynSJE+bmNRA8rv3tuJqT3TZybX?=
 =?iso-8859-1?Q?HFUfRMQUwhAdg6yMBb4bp9EtMx+0UxqPdA5j7wW5U93edR6nw/9lFfPjPy?=
 =?iso-8859-1?Q?DrhE6Zk/763Qu38MxlVyR6+6mRFywYvA6oXP9wzfiHSl7DueOhHAyFakBx?=
 =?iso-8859-1?Q?IVNLLkJOZpPFa9esxvelyhLDdaeZ70GBqlX1aFq0QwwR5kFOXCBd83asaG?=
 =?iso-8859-1?Q?UWRlnjajz2QfTS3dRoq5iOPndgkLEQ0dqoAE1FUjbfMdsQfYKpHTwIFzIA?=
 =?iso-8859-1?Q?LTYnUx3hqXzKvhejHaHJ+Oj3JlAwbQqIMu5kN45X04lC7WCzirswJ+gFIX?=
 =?iso-8859-1?Q?KgHl61wV9g+DDzzxIrA3Lu2zs5UR0WDYyaAl+jx3DYj0cIwNs8hx6D8a+v?=
 =?iso-8859-1?Q?xRcEH4MCeN/9SxIIL0wgOPPHO2sFeE8CGwPMISzkYIJxqq3v3vOnj7udyC?=
 =?iso-8859-1?Q?yLh91Mn1AIaGlnCi4ZC2yLLkzjZkEVtT4RcNUrQqSzsElUvutJ4qv9jRuc?=
 =?iso-8859-1?Q?Z860iHOerzG9LR9HUpzFvKUFQjTCqyF6GyHR3CEM6zc/2vTbt5+eU9FA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1110aafb-19cc-4418-547c-08da69f60e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:50.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Q3ZwyZvZVZmzR/+ZHEobK5txUBLZ26rTBcYJ04wBOpoR+3s763G9m+c7VSICraev/jaQ0VxcX2ETOdT2dpycg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=847 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: AAdhX5zYHaZdLgyZpyX3IqskyCvv-ZzH
X-Proofpoint-ORIG-GUID: AAdhX5zYHaZdLgyZpyX3IqskyCvv-ZzH
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

vma_lookup() will walk the vma tree once and not continue to look for the
next vma.  Since the exact vma is checked below, this is a more optimal
way of searching.

Link: https://lkml.kernel.org/r/20220504011345.662299-6-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-22-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 16be62d493cd..8dbd68c414d9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1426,7 +1426,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
m, struct vm_area_struct *v
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
--=20
2.35.1
