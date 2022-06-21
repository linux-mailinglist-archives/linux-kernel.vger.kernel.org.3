Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F50553C26
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354649AbiFUUtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354575AbiFUUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95665FE5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:00 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJHFM5012606;
        Tue, 21 Jun 2022 20:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SpOKlf6DfoOCiq1uL5XpISPKxCX7JPPOY0E1jvj4P5g=;
 b=wcJSqzaLWupEGgTwmSFu5GNdeYyVTLVUJAiizhE/+sOAnsRgX1lLsuITDheh6UBGCZ5S
 l/PQDUmiZbd1ll0EAUL0V9719A+szMJ377cYioMbF+e+aIksE2mJp658f4yqhYSs4QhO
 5CFY9zzWKVUxYhHSPQqFByuGS2NGZ+ZYJVuQe3ESuJDkFeG6x9/CI3ZZCRKm3SejS9o6
 Fl54cXRr29mYPpr+xteNOJaLbql5tRWjy7vJ3LfsQdUQ4L71CaFYs5LfeDeGSDitdXBh
 R/JV+LZS+pLk7bb8hisMlxGQWhjT0Vhh+Ii/oT+bqTsDzlAExDvdC/B0PMia//3J22OZ vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6khp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhu027847;
        Tue, 21 Jun 2022 20:47:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mj+BnRu7iS8RHj60/y7MwWXLryyeUob9dn2vnHN9ce8syc9QVvDRvrQH2eKka+NAw2PIwL2PRFsm30WGRV1Ky1MnjuUdq+BzKEQXQSQkTQuTm31NM2CB+u5j6O/0vzIauBhdMJHTDe6M3phXnj6dn28q31hN88M2vH49YWqhK+lJX7z87pbgZqA9dpPr8L5+c8RNbSvKWWlBa9CqUVDJAi03lW6A5F/keUqkGhtU8tA7saZHIlwUg7uTxQcsBuxz2EsMDoTDW2IMAAtdAOC6srjSE2Udce9XLhS2C7tXS6CzaErvRA6KcsAC0dD5hQOTOyVlmhLFAZgCplZU/ScbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpOKlf6DfoOCiq1uL5XpISPKxCX7JPPOY0E1jvj4P5g=;
 b=lTaKBwDUD06bh2+JuhMIuWu7n5Q+B6RmQwqI5HMxsnnsp6k0x3pIflwO4vGWPwcml4n4v6cmFtCmfQXrEE7w6cib3yCmMo/QwjLiKEKpiKstsJArZ+BLP5B7E47N+d+7T4FljMpNh+1M/WlF2IQkJajsLurj4c3iHM00DCPCfueotcX8UmKT+baOB/AOtmfukH6h67dvql7W7wIO4eGTKFGaRz90DTo0WxvNb3la/7kpn2ttc5xpBygX1rwq12ZYZOimvQNS50NkRzaAZnNE5k0QtVG7yiWNBGlixZLDB5/ulQlwsfymkglkV6556TXYTxNvdm11gFIMa4fYymk7qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpOKlf6DfoOCiq1uL5XpISPKxCX7JPPOY0E1jvj4P5g=;
 b=Bdm6QXuCUU9uD76Ile/d2a3qqgt9VATi6RJCuCdY8V3K4fZ/mcr7Y1b2QepXgzCDWj0h2biY0UH/31jgl+Oggg3EVQUhKc3da08vxPA8QBsxrexR5CSfGbRSnkMu5sl/tY13R5lwF99APcuswxxhF+ho+/Lcl6oFHGuoneHQtB8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 35/69] x86: remove vma linked list walks
Thread-Topic: [PATCH v10 35/69] x86: remove vma linked list walks
Thread-Index: AQHYhbAQBq0rb1krjkSS4++J9+9WlQ==
Date:   Tue, 21 Jun 2022 20:47:03 +0000
Message-ID: <20220621204632.3370049-36-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1cca2342-5326-462f-5bec-08da53c74ba5
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025058EE1A681FAAEC48A2CFDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jAURqzPoMnhLNQlnukro3+CkP6k9CtgT1L4QMEQWt5y7NMqi/mJyotLgYDL6noYs3JzZL0PDJYi4ptpFOX7DT5zDyYFDs8SB+9DHN8zUDaLnn9fmMy042aKiZ/jfxX8rGtRKOVbbybdxsoy1OQjIYt1P8aAqbrFtKNeMVIvTylTKbNWV8aWZrIoQk/9Yl7l2xgpAd1MsELa8k4N8cTT9tva4w0HGCx+lzlNGvrtPZAoYpZt7XaLu8i1AYmG7L79U2ZpRz9kc8oEPXoqsohQWP1bRInNxRl3cCzrPSVeUpAK7/f5ZWZI4DdkXwkyN3ej/5LAa+NbuZyNSKbmTyopjIQ43oH9p5aRFpiv01iucz2NyI1OJykJPuusYSeGYVpS50R+tyBM2O+njF1ggEtc0hwcB8STOdEff3yFJUN9woR41WpSfYTZBE0SqeVievhgiB6VzC94R20gqgV6BIpF8Ct7bOie9TWhUK0TyF6DfckoBs6zMkYCZi97O/wi0JqsCxl4asX7DM8S5npqkRYXluTCCJMlMXOsOZh7DZeQrCmSDk1wpDYAALCRyEk2ZKetlXudnCHLNU8nNJSWbEwDH6K0KE196LmIoCFJCXf3i/nvs61yTaj/S7ULKIf7isDT6LgyFFQt0wH/5Gbh8Co1DnpmXzJ9NaCSBuA/CN1KRDWmd/kNZVct44wy0D6T+7d8IXfdrlacQ9MIy/0RXFI4AorJcuL8sFOMyvwTmIcdSPwK7UqrGQo0xB0njfBtqrS/YyoYh9170j7cN6gZCdVumQSXJiCIJ9JwGQGK4buW1dhg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mhBDm13wGY7dCNYMCH8lNAmHEfZ3gVadwSBaX1gNtu/IPoNHokYh8CczOs?=
 =?iso-8859-1?Q?5EbPWcnvAUa6VUeZHNkgZkWLPZ7ux+bqMHsOlY6mT/ph3qebLwRr2fDAXk?=
 =?iso-8859-1?Q?T1TIn9hC+0InDHrm2Gk4vm8J2BV9fcyrTM22IM4cgNkzpMBAl+T5z0vR/4?=
 =?iso-8859-1?Q?qNeOSxikpd+rcJ+/XmCJ6ux8HXXxz1K1DnTlEPoJcSYr7bzTjb7/BHENio?=
 =?iso-8859-1?Q?qMlVi4mZk7UeRETN0M2fm7nknmo0UTGiqWPHx6vVfynm2DoIc85yNZSnzy?=
 =?iso-8859-1?Q?CX33VZbYYmieX4uisRcK/AJUVASFhS4Md2MH6OVSb4JIubB+AwqA9MSBM4?=
 =?iso-8859-1?Q?VrBe0fLeuIM0WcYlN6BBIGYLSsTjKTZswJgsN2N0MJvqdvcBdFpXiS+BoI?=
 =?iso-8859-1?Q?yjPb9gwYbKdvW/rXZ/FGfBoalqtRrvb5MliyxB+XpS5T51iF1NoqbwHfak?=
 =?iso-8859-1?Q?MQDOoG8iLhdVIaLlZcgK0Jqa9FjGiduUqRWtEBYIZy+YX+J86kzWu5WZmQ?=
 =?iso-8859-1?Q?LRreWIX8VLDKdTZBGsD1nAb/nvOMB2ZfiifCXpN50kp1QiXLipdnd0P5EC?=
 =?iso-8859-1?Q?7PGGXPY7OhGjqjuD1RQH8amG03x3X5Wj0c6WhyxrjYGBk9MFoy90sdSel6?=
 =?iso-8859-1?Q?u5IZ7Lvchc8M2K3+jMmdaeQ8237fU+YAvwq+8iIenWhhZzQzJiYpSChi+Z?=
 =?iso-8859-1?Q?6DiWzq1SCbBe54bciDe7xCCHxU8IofJlqbDaAWtLTW/DHPaw+q9o4wINM7?=
 =?iso-8859-1?Q?8YUvyFDzuw6JNQ2eTkknTTkF1BVy5Nz2DBkogo/RhpC2Wl1EG59XC2vT2l?=
 =?iso-8859-1?Q?NQZjsXk8qSzONTnwDyZEKG0uXpmzz0Io900G7CJoDWVHlRiTBI9RlOgy6T?=
 =?iso-8859-1?Q?pANxcg0WanzZ6nbVnsJXJ7xn2nLVTnkk65W3+PeAclhdMLkwSJPXZoTnrV?=
 =?iso-8859-1?Q?z3P3g3DUDNrbg0CSoBxG+G9peCLIHAE68tZm1KaJ8hnb21t0m2i87WDLao?=
 =?iso-8859-1?Q?pmIzqnwK/CLZ9x2Ir/9IFutbhhhTyW5/Vage3vQpVJc4NZcxGIAHjjOjyw?=
 =?iso-8859-1?Q?wQNsDwsXcICPg76dUARmNaB4Z4MqAvoT3O1s2D+cYu5nSFp8PM1rdV1125?=
 =?iso-8859-1?Q?zBN46uNlI6Tyg3GXChHJCkWFnPP7maXrjOeSSXgWPs4H3jJEHqWGMTVcZG?=
 =?iso-8859-1?Q?rbHNgDXRGRXynGIQH3560N5fVYaiiEATMdNISXaQfOZoQrJBOGrSLTz+1d?=
 =?iso-8859-1?Q?d4hrnJ8kIkKyK3uVE0xuBKFt5OAxGlVthI5oq62PP0AK99EnF2Wb0UH18H?=
 =?iso-8859-1?Q?99Gi+CltAfCdrqPoxrFU1ocOt4NRoVRr3VAf1e0X00GQ/2SkMvJpjNMB5a?=
 =?iso-8859-1?Q?e9f4WhhEkjOBz9we3Wi0NoH4SDKAjiUC9pXA9Ruz1CbuHShWTHBUwuzWna?=
 =?iso-8859-1?Q?Knrl3RbaT9wsIGwpFsyIDf69zpC7T7iSLfG/RTU6x0kpP0sdYHM4nvZT1l?=
 =?iso-8859-1?Q?VPaTQBSOAkRk2jYQaIGeTOTtPz387Tr8n77mqYt6qtraVq0sPNu6bj/+Ya?=
 =?iso-8859-1?Q?i6zbqcVNBDoVcFCJh87cOL+xkeQfByT/U3WGRTPAchccehvC7t+Xo+74qo?=
 =?iso-8859-1?Q?J3ABS5+S15bWZk12QSnAp8UfJTKtuLonrkKLdEs9d2CxNjJpriv3myHPxC?=
 =?iso-8859-1?Q?0gHV6ROl4cp93jzwYySLOT0KB2F0w6tLPL9PyiGxAAcefV1IJjs6/WcqDG?=
 =?iso-8859-1?Q?qTl2NbsHvPoxClKXzljzO/mhdxGOje0yrf2+8QMRNPvjcEOMQK5joAvwGG?=
 =?iso-8859-1?Q?XZK2VZCQ22OoLbYJSBRKXTkcSK5krn4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cca2342-5326-462f-5bec-08da53c74ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:03.9881
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tpQld2b3A4bgLGv31hHfg7UxXAySSVUDooIf6Hc22x9feg88o4fE4uIxsGTcAeuAkUsJrnB2Z5AKmRggBZq2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: 3v0ofEcXWqoZ-BMHnSnXVvp0lVw1CKNZ
X-Proofpoint-GUID: 3v0ofEcXWqoZ-BMHnSnXVvp0lVw1CKNZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-20-Liam.Howlett@oracl=
e.com
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
