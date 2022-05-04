Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D105519350
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245322AbiEDBUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbiEDBS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:18:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ED643AEA
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KjZ6P013502;
        Wed, 4 May 2022 01:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=797m5TnHVDs8tnas1P/DnkRsDpE902N2dzwysrMsHVA=;
 b=qP3afzG9F0LIlwHIXp90yheHC1lRr+L4UFO2TaGEfiZousR64njb1azgCqMftPE/q3m8
 wBh3GYFy7ZByvwTeKarorodGtBG915EXFnop161+Ig13rzjh7QK4Zf8LOACNJK2CBhIr
 wVrBSSfBTMZjewDb4KNUay6hFhxHQrev/APcv9ktSXbQ5nAAvC7hGSjWdqsLvewLZ4lx
 EnSuGH/d3hgTIp0Cii6+qEVRAmlF1ynwEuhGloTlZWpBGnR4YJ2EqJ+5SRWJPEQoQs8g
 W1UEA/YBS0GkfLbKvUWOvkzsJuTkUnaSlXox10b4ZlIOU4X2iEcCjtjgEtkwmvbrJ/8r nA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AUFX023411;
        Wed, 4 May 2022 01:14:36 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9g4fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJuIEjq76b8arLOgWs4BiHQ50tCwskD1sf1Mr7pzLwvlBiozR2KmThSZMlaBCvZckt5UTFcDMlqO9R1nCFbEDAI10i1KJKYeUzVOAPoImIypekPDgFCzS+pWYDsgZ21OBIb+y3TTC7yGh/LMrsi4K7YeHTOv7ZhyNdetNQ8AUE4cSm7RI+pHKB5BvswE5WqQwB0e3nOobhMcIUz1fK5IascdiLtkv4rOD4MjVAZXv/OcBLRbqmiLaDQsfXBoSoujT2VLoUs1iqbj5wyWrZ/IDTtujdLIAQvWVFDKOwYKf4xNohzDDFoWQiJO0zqwiGIAu6ivEuGpf5f8K7lpRwpmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=797m5TnHVDs8tnas1P/DnkRsDpE902N2dzwysrMsHVA=;
 b=E//YORNCCnDrR1Jqr34y7vaTxQLMBiVrIonetnYfON9HJWkm9SRwhiJKCN4O94oCRlaMQ4ye/dBFM7i1LcvsvKtLA18FfAU/oG/EssMhfVOQrqbRImR+Jq5cN7dFpcpkUM8l4Oq48vXdLRni1hBfmQ/Yu43MeYLntW0bKH9bsQGJLjqaVs7gdNnBV5A6kN5HteMdnL0+zBzdsRjUvbwp/KbeJBh9kx3IJfnc495V2CSsJrcpcfgGoFyvCG7DQis3E9vWXFonzCZ+Z+1nJSB/ZPrpQZl37UY0zeV/0ZtdiqFh+KUDMP6EgxSprPxTKosJ+3YbW4X171V28JetMpGXww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=797m5TnHVDs8tnas1P/DnkRsDpE902N2dzwysrMsHVA=;
 b=PfTckn+P67YlKCO5Lk+uscKReMYoe1HPRHfbDJFaYW26xAY5A0MONHC+VGfRXoKaxOCtvO6riOzIC3q3bGnKimr1q9jzYS8EhGV7OuCsIshHp32RKuJTsClU/L3YDwGhhuu/B+S0g5I72G1XZQbEi8TJzyfsl3AWTdofwq2szwA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 46/69] acct: use VMA iterator instead of linked list
Thread-Topic: [PATCH v9 46/69] acct: use VMA iterator instead of linked list
Thread-Index: AQHYX1Q8M1ImekAzhkSm96/WKPCN8w==
Date:   Wed, 4 May 2022 01:14:00 +0000
Message-ID: <20220504011345.662299-31-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56039387-79ae-41f5-d242-08da2d6b7331
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728F886DB1EE857864AC80FFDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQtGBtezYeJAHv6FrzuXnvf+Kt1tDZZc5kocElGtNnRCWNo2xfS5miEf2tr0emXzrQuNtwYl3+ipwfmTgX4A87V6fySWprbEk6f/tDyCflLgpEMzTVv2o4sfofL1tnJZFiUErhh2kPOfDaPVwFbsbMcxffjar2xA1WQrrwb0muu1Vjc+UqcH+3CCqtcIKbTG6Iv19QNnoeuqwLtzzuggcqWPon8iFYrPKbGLsCiR+zWrRtH5SLvo7yGDR0Dz7G7pW4t8b4oAl5j5SgmYLCyM5KA/SPNgfY0VqGNuuvVYVR1oyg8akQdVXO2f8duWKRNuhDsQ0WgdPOaONOz9dtH+bhvrgIFzYpCg4Uuueb57ETe/qG4MlUxuqoiHjiVo3efOzCLp6nZRqv+H45E7ZLjUGZvpfipVr6TSUr/5ybbIATrlRePFSYsWynXxGh8m8bsr5ZAHXTNOTXv8JokFrtyNNMipsq/9gr6rkWt7cdQsAhY26EHsZcTK9j9SvGGpa02SKvrxc0R/bcJEF/m5p6TQsh0uiLX/evdKsni7L3CR/8nx/FvRIfyNx9mvjpXcG/em1ZJAWVdn9r3ajvyZZmjccjmRA2N3SeWdsLL7Lvq8drqCsQV2ucufB7fT29zeBkbZtVlSh+8TICgEjpuvlclTum93Ivp4pPza2BAsGKHjGTFQCzry0MR/OrFLoGjhjW4TbIgqgTOAQsY9kRGL+v0X/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(4744005)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BxvUx1Jx9fxF85jOQ5LawNehNx8GZRUrGvlLocKsakTuPu7op/E4kdhPaT?=
 =?iso-8859-1?Q?WuO665FGkbAJ4I+66Ib9z/xI6yOV0r23GZWtVs81pNiFZeeX/XNhHZqqGI?=
 =?iso-8859-1?Q?gznV0z1EMUfc10CRbWYKIrTIyppf6GbSL7t5kZlHDqF0K2fnCghenqwk5y?=
 =?iso-8859-1?Q?AU9OMTLNj2RWqsHEh5cGuVj5W4HJR2aVM5O2B0XKrJqC/MBObcym2cTSNT?=
 =?iso-8859-1?Q?zgF3jrE2ABwL2LSSdFRkATUODJSuJgvKoD6XSlBDWwB4PPNt9KGuMKg+Zz?=
 =?iso-8859-1?Q?DedXN5WXUJP2OQJHbbrS5H76EnP9r1e8Zuu+dEJUcIja4Hf/LE6t+DFjEm?=
 =?iso-8859-1?Q?2MR8TRugXdei+rXC07i8+mHT3DeLB74sM6V3TUFemj23qs6Pmm4gUiVHfi?=
 =?iso-8859-1?Q?lMSWm30S2SkvvABSOZnzq/M1LWmbWB1iCCW2SihmEbPwau+Eq4NPM53PXc?=
 =?iso-8859-1?Q?Sm5w6OPzensDCfAtQvpjWeYgTQZk+845/yrPtVGzrXjJpQw6TuOXVI1mBA?=
 =?iso-8859-1?Q?ck+m4TNN83idD8UbtTkmtIQzPahFMW2eyEslKta1JFyfcalasPxc6QJCY4?=
 =?iso-8859-1?Q?FX7UFkommk0FBFwNPMearuaRY0rMa/oo8UMpVYp/9mr+IRNVprm02jpz3l?=
 =?iso-8859-1?Q?nSaQLBptuUYWFUMD9SeX3Uaa1sPqGLfeim+ROrQqd3AheisyMAXp9e6/S/?=
 =?iso-8859-1?Q?UtHZF+8QL1bo4XJeGi/SR7P2DkYLaI9JFJiMhSwJHTvWvvSy02IJY3xuId?=
 =?iso-8859-1?Q?NWjZM8W5A7XWhuySUCZ7G9aZ5iTgvLfLZWPyETmhISmYQ+jjHp/523Er5R?=
 =?iso-8859-1?Q?HL7JmaBWuzGsQxCYhG8+xjCNqxEN4gmvWtfI1X1Gw2r7bvHnWVS4QIwWvS?=
 =?iso-8859-1?Q?xAPUwTzqJlsWyPTFER1M15v16mGb7KKvDjsjYn6ytthWIkRT73MprV7n73?=
 =?iso-8859-1?Q?t+PJQfNunnrN2ED4yjJRADYfVlz2EOanfsmzyyFqy/L4TJQXbxTBl+kEJP?=
 =?iso-8859-1?Q?sa58Yx3imG/BvVmh6otfE6ecvxYIbfp9y4KphS3GN6fH6dJeR90Tv32dZg?=
 =?iso-8859-1?Q?ioGojnj3oyr4jLOp2zRDaafTm1PpzZiXv0IteN0ZWmZc32vhvJmPwp9Hn7?=
 =?iso-8859-1?Q?Qsd6NEVNRJj4IeiQIlhf4xz+5vgppr0SANiJh5OZiMuKoLr5dQ0jv9S4VY?=
 =?iso-8859-1?Q?IpbscdnsM18V+rYGuxRJI0Lj1qEMUrCKXubBrrFZsMmitS80tdKAkAnWrT?=
 =?iso-8859-1?Q?amNV01Ma+r57n3tTvSpvciW5YwRGC8GXnn1VNO7SB4YG9jdzT6fX7SsBGy?=
 =?iso-8859-1?Q?kjz+RIJ9S59R1t2aNhpJBiPvW8qxf+ytdio671eE2mx0ZcsjwF0i+HOrDe?=
 =?iso-8859-1?Q?1TQnR2wllh0jgpfi86gNzAkfbJbzP1AKbBoaNV4P+26BSdVAgh48LqQbYT?=
 =?iso-8859-1?Q?puG386GrMm23knmlxr4/Az98sfbqF0IagR+755qquvNXI7oZFPpyKMm5sh?=
 =?iso-8859-1?Q?XQHUllqsFxzUOmS2sjCt1Tqy2IxfMNUGgHwuA8TaNh7EdciR/MXQs6C38G?=
 =?iso-8859-1?Q?khiohPaXAjuKvNbJtjQ88naOtYrtql2lo6E485gTTHvrjcpBPr68KkBadJ?=
 =?iso-8859-1?Q?vOZjGZbxRXskLQXS7+bAjWD1LNhG4lGxB4suE6B0XtKWI4HUS95Sar68QU?=
 =?iso-8859-1?Q?bud7JaECPBRzMoRZ9JHO3mFivB/G05znkfYAutvFEPQ6jYeTE3cvOpLlBx?=
 =?iso-8859-1?Q?a+/8PlIHZXKif6Ywi0doueORWRFw1KJbzDq1UvpYnSTO9ZEosBnLYDGYjY?=
 =?iso-8859-1?Q?UfMIIFCCS4IJh4LJztt3vXVr5vR18fQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56039387-79ae-41f5-d242-08da2d6b7331
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:00.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jh87cMrcRTUu66LUsBj20+f6nBYII11KMobKYRQIlVxqWST/j5c3JO4xkOfZnseZz0FBec1jQTWr5M8gGhUBpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040006
X-Proofpoint-GUID: UrA5vxtjO32hUMkffBjF7IsCIwZUEaxZ
X-Proofpoint-ORIG-GUID: UrA5vxtjO32hUMkffBjF7IsCIwZUEaxZ
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

The VMA iterator is faster than the linked list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/acct.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 3df53cf1dcd5..2e7bf8d41f04 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -535,15 +535,14 @@ void acct_collect(long exitcode, int group_dead)
 	unsigned long vsize =3D 0;
=20
 	if (group_dead && current->mm) {
+		struct mm_struct *mm =3D current->mm;
+		VMA_ITERATOR(vmi, mm, 0);
 		struct vm_area_struct *vma;
=20
-		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		mmap_read_lock(mm);
+		for_each_vma(vmi, vma)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
-		mmap_read_unlock(current->mm);
+		mmap_read_unlock(mm);
 	}
=20
 	spin_lock_irq(&current->sighand->siglock);
--=20
2.35.1
