Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75BD0519349
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245082AbiEDBUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiEDBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AFC41618
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:22 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KnGv4029440;
        Wed, 4 May 2022 01:14:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=h3Ms/12Gbt4y0rVLFx+f+g4wA/cJ/I2AJUkj8AqbHTM=;
 b=aX7wMV7VlYe42R3q+ItsKo4x49TLyAS4Zjfc9mvg1JjKcg9sOjaU+Qk+z+XWQVGnEcO6
 1SPLZ0doDelRG3z/UOvMoKCikOfYvQO1lEl/9PIe9sqVaf6xRKKPRZXdtW+ppBpcbyx7
 5r/kMSLWHInTqBwmEIg7UKOjoizsNlrKsRapEY+72D6WSEtXkP8hHJeZ5y/0GxtHvGET
 lT29DFM7ARf/AvfId9I0SVn80u8sGaNqvH+ph481Ca60c1ZMOIU9kUnH4UxfsSl/nPdr
 dgL2DwUIJTKsY2i1te/P6bvP/gKSr8t9tRS/Jo16vEuO5JgWMrs0NU4Y9SFkZH4A+CYB yg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f61k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:04 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441B1bW020210;
        Wed, 4 May 2022 01:14:02 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922j7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2NvSNbgFuHCC40EiEMbG7wjBAE0aeQeSPNqako+5c+t77WKhGHtcW2KThPiKvAQxwrjPFFB4C+K+oYvvFOCTPlPlTw3nqFZd9Na/0znfIlISk2j0JJkukrazOikiaaXEpNk40RKnKLd0aSzHfGTiETWw6i6sN5AAVRPc1Y96pPuQKPQJzr+1kiomPwzGvoUqGBc14K9va9iBRhjdVJJv13dLw33x2BG8L4uCb1jPzv970PRpKMEXKQlWvNAWPHX7bweW9QsG6vgc/3eJSGc1I3PrO4ziUsOmkUFos+rVos1qklclAswZaomEa2QhZPiTTHyQfOg2ABBBnq9er+Qag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3Ms/12Gbt4y0rVLFx+f+g4wA/cJ/I2AJUkj8AqbHTM=;
 b=fj07MeMvMtWDwPrrWXOSoOTdmOi0ZmegDB/AamwrwLXGFjetu4XuHesd2kCFlBFkVDWGWCO6y1sxATkXqpiED+hcPZQk1f9woZAOXZggwYPD/E1nS7A9x6gfqDCdcr3Ds/eRreizN3M2c1IwXA5d2RxZ63LqnKi0Esz36Niabj3O5o/1XLHEErmEGIAri4GvFqLc7OigCthIN26tiI2ulJiNJU0s4gGyiDJpH/lAcV5KiLZBgfR2rvPexpyb0nijq24PCkJpMNiKiH5txvj+KpClto8n2czT2PURkRgLTFl+ht3lmoDZizUHE4XaGLhKkjr9PqpLboxRKsz4PUs3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Ms/12Gbt4y0rVLFx+f+g4wA/cJ/I2AJUkj8AqbHTM=;
 b=LvGFrlitP+Hm23Ec5Vb/2sbODiUrFM2V2EsLLlCStffUPHTnkQRtg8NMbc8QS0TnVBvESBbQ/ONfBso3HFTY/IV461uIxL9RZbKh1XYM4CQ+qEJ39QOjfI2wJ0RKeGgbEpfCW2bKLwpgZRLKTkAhsVxSUMKHE6VGqjE8AAV3nfw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:01 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:01 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 40/69] coredump: remove vma linked list walk
Thread-Topic: [PATCH v9 40/69] coredump: remove vma linked list walk
Thread-Index: AQHYX1Q7wGmcIoXHn0iBSV5d6D7C9w==
Date:   Wed, 4 May 2022 01:13:58 +0000
Message-ID: <20220504011345.662299-25-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bff78b5-69e8-4ca0-4ebc-08da2d6b5f52
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728C8616DD0C96988A2C7DAFDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sD/tgTyGYx5OPyGfOmAgZouW3r3PEubd9AmTt2cvuC4onq1unGdI7WxD4fmU/bdKUSlMDlyVK4BAEbV58ER8hImmaW6xy4WZvuP9c1FipJxWY5WCKhnTtqybOoNyfxt+hRfVi89RFRwZkXjfIGx+wTV5DKmKmsg09il1YgjmQI3KrF9fP3o92Ox4HrAfZZAx/EBas2batg88lrsESKqSIhu0scLICQFgc538IljvIoTuwH1/JBWKNkXMkj/rUNR3RpAOFWHMXA8SUOrZaXKoIr11nOVQXdBJvGX4dKsU2rnDeM7yfEok1SgJHs1U2FPYKxWPy0GxVOCwRe8yNwOXhlTn30MbA6UN2OmZawTPVAzCM728qR/3PYVMKzUMrse8DwwHcJ6GPBgQu9QtsASZ2iqpm5x2xpd9qIjdqXqqtYcuaTuyhqAtLdisxZDj6f+lAQ08RsssYWX2+7f4RUVH+XWJ3QOKxOJJenjxiacvgGYCyvUj5FFD48FUTsafNiRmRZTMDteFlQ05doiNZnMqEbVJ19Qm94OBZDEkt3jvGHlospTyKL+C2AqLAJ1tZPF0tikDqNNlisQtOLJSybeNhc1zu8ZQq9rvK11h3ARyYMh5Y7ZIwLf0LoNOAq0pTeO+YHDZO20hp2jWut0vvIS7Kd5U+kFn+QCsQoDPOotrSC4tyGhvd6zaowoTB1HFUPCEm7SwgAv5GMKhwYCdfpJWig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lDhGuoJ+RLOARIW17Xd807OUSO496epy6x58sajZ8Pfi4ah00HSsQwtaWV?=
 =?iso-8859-1?Q?WkvkZwunkwl7XtW8JMnsJ9PwbxMH2VRvO0DKC+jpD/X6D8rKuYFUVaGRdY?=
 =?iso-8859-1?Q?bEqOOB6UljBooLdDMuS6OyxP/iOs3PSmGK2KKZBR+1rgFnX8L0dSmDgXe8?=
 =?iso-8859-1?Q?eHQdrOimbq9ugbT75dp0a/UsrcRFdlEadka9jCbvPv73CLOL89TlJ7B7Ha?=
 =?iso-8859-1?Q?ipWf60CEt9BVUocGq/d+TwCgrjOEvTuuRBcDKdPqIpfN0n8JlcLtPpg260?=
 =?iso-8859-1?Q?snNqHRUBhUSgL2KZXSfgrjpMRd0+WG088H/WknEIzE6s6fZOCJyOp85j4g?=
 =?iso-8859-1?Q?lCC0we2C13xDuh13Y2fSmFnNAqtOJtdzgvHHoNTgUB41Xt9Rhhif2th0vG?=
 =?iso-8859-1?Q?e401xZprLr7PDVMBcrZTpFKkTWhweVQjUblAY7ttfB1qAMkMrD6bFtg/5T?=
 =?iso-8859-1?Q?DBpro2gZkNAKX4ftkrQDdy0CznCTXtuAUqL/wlkQkcS06EzgKkSEyZ/44I?=
 =?iso-8859-1?Q?fpgBUbSSo6N/ehXlqIMrdjF4qvrCneSZtUwTcV2usLas9rFvrsQxupBNbi?=
 =?iso-8859-1?Q?Yjfh3Im391CtIUqnrfbxRq3eGf4jfHUXFFhLmXxoQPOeRYJdmL4eaaHPOg?=
 =?iso-8859-1?Q?D2DGfJ5xVgzrmamKQ3XNMBOcv/IrlTfEUik5DynKTjTfPuimdVF6WGaz4y?=
 =?iso-8859-1?Q?7nfcR4ituPdIpqeGlMuzyXVMk/zJjDkPFlz3m/WLWqNCHcN3eoDFhigErc?=
 =?iso-8859-1?Q?ucDfC4YHvyXC41OQJBmO08y31TVZQvv5aCxNN7hheEAcRe5atYMPPvXPmt?=
 =?iso-8859-1?Q?LO5Fe9T5Pz+6zLKkPtwTIQXdC5Ss3vJ2PEmHqg/u/3Iw47iTsIojjYsFMC?=
 =?iso-8859-1?Q?eiNUhaYkJ1dYntSq9ct0hUJKDgWIf+3hedlOw9Ro76+OZP7a3ssKaoOVSU?=
 =?iso-8859-1?Q?A2zMhJWT09uUh3Hum54xyEUHWvK73h00VmR0S60N1xJ+que6TpzpYdp6Ax?=
 =?iso-8859-1?Q?3GxsDB69TXfExSiyLYTOnsSgIN0WVXLnxG0YpUcG6HYVOFB8BJqUAHtv3r?=
 =?iso-8859-1?Q?jof+X1Ae6VyBl7vpse0YSISgRyptLx7HCulBzkRbTyr/in7XoD8WldlKFU?=
 =?iso-8859-1?Q?Bx+3ie9qOSsXE5xUVw5VzfpnhrRQDzILIS7hMkISRjZzm+xVndmtE8x7NE?=
 =?iso-8859-1?Q?SMWiFnWMiW0P0zRBbEPcZ+gfVpRInsY4W+acZ54HhG3nXSzCDtigaZx5iF?=
 =?iso-8859-1?Q?Ph+Fu2a7Y4tB+mt3XgEiz3QqK3JCdhgN6AEC9ZqyZ0QvhvSoIXyxj0yQaa?=
 =?iso-8859-1?Q?1Jqje1GT36qmuf5IY1WjtcfTRbbb059JTjYwN1guzSVCyx1wLpg2F3VPzn?=
 =?iso-8859-1?Q?UnIHfMCmiZ9nEESvAdk7RLQQSIBia9DAFiFLEvNMxdJv5g3BkX3e9vLiur?=
 =?iso-8859-1?Q?porXamvz+xY9IdirSSVazuMGc+mAOyWSoVtPFnxkI+h8uJcB+mVkvn5qJ+?=
 =?iso-8859-1?Q?xxdR+DyzLY6naVpFi/1Sw5bnpcDpy/KcnRdkuCjJoDLVG2H7vwHNc0I5rL?=
 =?iso-8859-1?Q?iMpBuc64iasHxnWxMBl+hGEqYdCltrhmnYwnUxUqqJthnX+od081Bwfvqs?=
 =?iso-8859-1?Q?R/cpeDe9u0KcET5RGW9BibyQIh6ohJbk67dZH50tQnqY98RQo/85gsmQ52?=
 =?iso-8859-1?Q?VNxdIk87TbXQBWokK3fdqv/4WcwlozJs8QI+4564454UWqPAhW5xptgCYp?=
 =?iso-8859-1?Q?X7xf1j3aDEV7bMB69PiAZ5pGR1eDrgdKywZ9VeG87ycwpd6X3ZJ+hbnKv4?=
 =?iso-8859-1?Q?m4FRplKSwFg2mElpLmK1WOwRqyMuY5E=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bff78b5-69e8-4ca0-4ebc-08da2d6b5f52
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:58.2828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcm+dF1e0icaovIlNnzSFPnmLIaeN9tUyasbWBaGHqIb9ePkJyVYyUrPTSOVra0qwHVRd27m86L1YUJVtLglGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: ESaEWV5c8WppviWvifZDnT46YbQvN7yp
X-Proofpoint-GUID: ESaEWV5c8WppviWvifZDnT46YbQvN7yp
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

Use the Maple Tree iterator instead.  This is too complicated for the VMA
iterator to handle, so let's open-code it for now.  If this turns out to
be a common pattern, we can migrate it to common code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/coredump.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/fs/coredump.c b/fs/coredump.c
index ebc43f960b64..3a0022c1ca36 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -1072,30 +1072,20 @@ static unsigned long vma_dump_size(struct vm_area_s=
truct *vma,
 	return vma->vm_end - vma->vm_start;
 }
=20
-static struct vm_area_struct *first_vma(struct task_struct *tsk,
-					struct vm_area_struct *gate_vma)
-{
-	struct vm_area_struct *ret =3D tsk->mm->mmap;
-
-	if (ret)
-		return ret;
-	return gate_vma;
-}
-
 /*
  * Helper function for iterating across a vma list.  It ensures that the c=
aller
  * will visit `gate_vma' prior to terminating the search.
  */
-static struct vm_area_struct *next_vma(struct vm_area_struct *this_vma,
+static struct vm_area_struct *coredump_next_vma(struct ma_state *mas,
+				       struct vm_area_struct *vma,
 				       struct vm_area_struct *gate_vma)
 {
-	struct vm_area_struct *ret;
-
-	ret =3D this_vma->vm_next;
-	if (ret)
-		return ret;
-	if (this_vma =3D=3D gate_vma)
+	if (gate_vma && (vma =3D=3D gate_vma))
 		return NULL;
+
+	vma =3D mas_next(mas, ULONG_MAX);
+	if (vma)
+		return vma;
 	return gate_vma;
 }
=20
@@ -1119,9 +1109,10 @@ static void free_vma_snapshot(struct coredump_params=
 *cprm)
  */
 static bool dump_vma_snapshot(struct coredump_params *cprm)
 {
-	struct vm_area_struct *vma, *gate_vma;
+	struct vm_area_struct *gate_vma, *vma =3D NULL;
 	struct mm_struct *mm =3D current->mm;
-	int i;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	int i =3D 0;
=20
 	/*
 	 * Once the stack expansion code is fixed to not change VMA bounds
@@ -1141,8 +1132,7 @@ static bool dump_vma_snapshot(struct coredump_params =
*cprm)
 		return false;
 	}
=20
-	for (i =3D 0, vma =3D first_vma(current, gate_vma); vma !=3D NULL;
-			vma =3D next_vma(vma, gate_vma), i++) {
+	while ((vma =3D coredump_next_vma(&mas, vma, gate_vma)) !=3D NULL) {
 		struct core_vma_metadata *m =3D cprm->vma_meta + i;
=20
 		m->start =3D vma->vm_start;
@@ -1150,10 +1140,10 @@ static bool dump_vma_snapshot(struct coredump_param=
s *cprm)
 		m->flags =3D vma->vm_flags;
 		m->dump_size =3D vma_dump_size(vma, cprm->mm_flags);
 		m->pgoff =3D vma->vm_pgoff;
-
 		m->file =3D vma->vm_file;
 		if (m->file)
 			get_file(m->file);
+		i++;
 	}
=20
 	mmap_write_unlock(mm);
--=20
2.35.1
