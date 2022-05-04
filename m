Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3228A519365
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245397AbiEDBVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245388AbiEDBTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC0644747
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:57 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KnJSG013484;
        Wed, 4 May 2022 01:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AiQGQQKBHlC4NOoZffg90TrtQ7kvvHftMWgpm46tkKU=;
 b=dvfmWUZz0pQRxyGn8MIW1Mge6Jt+wE+W8iGe9d+V3lP+fX/hqBs/WMG3wwMB7llps5BE
 Fqe2jHzgFZ5gCZm9ZzS06pmHNQ40Rci5jV0OyIw8oMEtVh6WmakJ2tTJnAfVwGPMb8be
 brwVrW/ykLwEuCYdP9g1/pPpQs5arfhhjtdM6Cny+QnxLQ6ge/vfBITPLauO0AY6QWdn
 54eDlaOhh+HWJsr4ICjSTqMuujmh+5lsYBQ72zu+G4FDpbOOpladgKeX4QHviL89/X47
 qpqno7JoBU9QUcxgrO7FXMpVXydfuFEGOhPOBZN8my0sz4d7zk4JHAFVGRSbt8OOaM1/ Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR2013207;
        Wed, 4 May 2022 01:14:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HPaSlJigt2F59Eso2ekSSM6Mwib0LpK071hg1j/qYSun63JRTwLbYqALtJOqlgKja7aVKEEwXukRkCy+mvj20TOqQUik8lakeACtfGnx5mHg2efJT6bVbEA9xPhd4x//3yUbVO6RhkYJVMULwkD+nWPLYjgBrqpencbl5GJZ3Wd6bSq3WAq2vF2DFsvYeIQ03VCXiNL22vIvALnq9MTBuQIvLUmt8JvBcEEg/xdY5883sm+5lS3XIg3cYZFz67zFyTiLXuwt+w56wTVN0fCeTICECgZpHbLI0TN4h7AOBxXODXovJOvPIzjn0rETVYE4IwzDtlQjPm4QEmnOBrQvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiQGQQKBHlC4NOoZffg90TrtQ7kvvHftMWgpm46tkKU=;
 b=e0Joue0qQUmPtvCo7HbpIdGJMru9KwO7Oq9EJX2gkOjWk6KKidf7OSfwDdMfZMXiGxSR3r4iU+OuCVrGUVNbW1EXeTSiQYqazjTucTjJU8VifoFpIzDw1zOYrPhvgh9RWf7S/GhrbYIt7JlaTqRvkCs/cpj13zt/MA/4W+brPE8UaUxhvwdkBN1uyrU+vy272+zcgUTJht3ECixrsoJfT+tDoXipQ0FBUeNooJLF/RJlXkQJcxE658I1y6EMSExH8y8fo+7x/WHnqi5M6Gm6jTgEdArGAcfmen8BEcTpNb53Sf+vsKCnbFRo501mKmuI+fHrIuzTsLhVuxGvWyYzig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiQGQQKBHlC4NOoZffg90TrtQ7kvvHftMWgpm46tkKU=;
 b=s9FKAm6kb7pM8CROk2rpsrnuFdb6lqrK1wzX/hf44/0pyewGvkT2Q3J7NTJDKEQYvcD0QCGeoP195KlM8YLSfSsYCN3CLi+9ekSnr1v3OlKy32gPkcMxrGNPBvaCzKsEyltrZmFJ/icLDY1myYR4Ns9vxs+d+J6Us9kd0CHA3YI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 58/69] mm/mprotect: use maple tree navigation instead of
 vma linked list
Thread-Topic: [PATCH v9 58/69] mm/mprotect: use maple tree navigation instead
 of vma linked list
Thread-Index: AQHYX1Q+0TbYZ4y0a0uy09szJ+SEGg==
Date:   Wed, 4 May 2022 01:14:04 +0000
Message-ID: <20220504011345.662299-43-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac958bcb-e722-4bcc-c83d-08da2d6b763f
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB268889F562DB58D9A817A491FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SXQ90p9er9EkTBJe9i/yelfnxhhj60d38icyE1aJHagD/QNYK1NIDfoVK6vrJoKRHOKuaXIA/hTU2D++HZxJJ4CQvI3MM9rOEILLQr0xHbp4yyjluTfxdeKe7Eab327dRC/y3B6TQknkMrDJsJ/YQMh59mOdFisYnFtswA3rz2PxKGYXQZeCW4U32LUrz8d52t3B1y3/DCJUBghUNLe2jkVQjqH1Vx0QKI/RQNFMeBjylyuX9aFCKzmtwSAK3i2vQp0daQbciYUkqJrtw7mRYYsSqC+7zkEiBuMbQddDC7FZ1Fwy+ZwElsOtalM8j1yQB/FMiq0EN0f67P/ofz6+e6XB61ZCP12J+4C1VX6Dbc/0/piPKsaJdW2FzeMaeRbHhtvnWEG7YQ3ZQj46l7PCvS13dHEShYsqBKK9twR7iZBOX0cooaV3aq6/XEVpD/TeT/cE9+xvyJRlDGcAil+Hg8vZjy41jGZQmNap8bxYH6X+w6M74FKTXONO9wleoT93m1sxM1DsvrLk7gWMprnPS7CELyek6yRRu1GmVauDKw+IJ9xOJk33TWr5XCq4BLvH1slvTDasVF1bKs0+sU60P6goKjT0oIljlFQ8qUruqgYq8tNwrxvMa2hdoApbmxkLRnpmhg+XK2+WOZBEU9FK2Fp5DMA6UEJRkxJNug/tUk097h5b3cJlgCsSy7lVOs7M/XABJ9DfphCQTUB8KKkS2A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IOFgQmccKZC5JWCYWcok2eSI3k+QmP2bMGFoanr6fRZ2rLNUGNdC/I5d+9?=
 =?iso-8859-1?Q?oV+1slamvnnr9WKzBmZUnldWFmb2aVuGTJO4Zo89LJgucB0QOgRHFOAkkK?=
 =?iso-8859-1?Q?C7UqFHNJ0XFby4G1XQJUwMaYOHU//KGsrpamA2hVjj2FRlv3JhH27YCK2n?=
 =?iso-8859-1?Q?Sj2enMpNqd7q2LdCsZfjLA2Z3lFeq0rhY2oV9PFgrj/Lk25PnAiWuDniQZ?=
 =?iso-8859-1?Q?66co9t3za89GEwO3Xhqm9Blbl39QrJPBF10840eG36LO2HU0JP3cb523kN?=
 =?iso-8859-1?Q?Vzj09Z0ktFg5ZPcOZZf8E4DvKo/bS7NFP775GX5tWAdCynEBmZHtDSAzDU?=
 =?iso-8859-1?Q?6L6PctoUToed2XQKqZfQah37yM38msVKdjW/GxjCOpAmU/sUAqZuAbDpuT?=
 =?iso-8859-1?Q?tVoXQPHku6gT8o5ZtVOJJeS/pRGzRH+S9lqd7gThtEXpI8uQBdFwkGUM0v?=
 =?iso-8859-1?Q?fqhTc/d/STUSrVNkfYsUltt6DbaIBqL0cxlzsuhAgCIyEpJCoCcFZoJWdD?=
 =?iso-8859-1?Q?LcMQjKopG7eo4NFDSVriZxcJWoXItVu6L+ODb+Aqh+DmzcykRh+vqwsvIN?=
 =?iso-8859-1?Q?KTnsM+Zc+FuGO6BZtQWXryCxanFGtvOfSNU0U9DCuVZPCd2EhK0xXx/+wp?=
 =?iso-8859-1?Q?9sPTxhmBWmLzN5FiiidE9zGNXr0p0ZIbnaqFWgp3+lUNuob1+K62+WL75f?=
 =?iso-8859-1?Q?hKz4yg58CPGUEfosAuTqIwysl8UXPIzbitlLKTNNj7ICPt5GM0fZnsWIwn?=
 =?iso-8859-1?Q?JQKOsY7tiPqmkRD/OF+lEBBHlXb14pPHbojZn++UmrSSyIxrGuKTg567X7?=
 =?iso-8859-1?Q?hkHXBwvHLkTXHvqjGExuifjodjjv5xQ/OWZ7w5ot7Rf4X7MVOXeHH619XO?=
 =?iso-8859-1?Q?ymmI0xk/5dq6T25c6yx4y2QbwqQWVcJRif/fF7ceo1/GNsDWBitkhlLPoP?=
 =?iso-8859-1?Q?0AjdT93jh8ywy4Q4nDa3JpVX7KRsjteff7AOnQW0w2HyjYDU9BFVCs8ARC?=
 =?iso-8859-1?Q?7piNP5sEmMxP9M6YbYeVhL9XJ4qUMOCjGtWDvJ+JCEIjd+EmgBmGUrup3q?=
 =?iso-8859-1?Q?EAxNdAb0SUL8jXgggspDu5inoXcc/4Mv3BqTJW3z4PsMzG+ljLpn8QrlIl?=
 =?iso-8859-1?Q?LTsVkberIxJcyl0g6+Bkjd/F7W+VhzJB7Lt7KAKQcy4NU/Ffzi+w5yYX1w?=
 =?iso-8859-1?Q?Cftj4rMmW5P5wYmdLMfQstjb7ULpP4yY11TAtVu7RvmHveJaEzYSv/Q/7k?=
 =?iso-8859-1?Q?DSDqxszwJ6xs2cFi3BuHi1jRMtregVk8wJs4bKJnuRLc5ifaYg+dzFuxy5?=
 =?iso-8859-1?Q?8pf/D6QBs7HGsnrxSK6wglvAW0Us67m6Qydw4JEMWacjP1K5CFOQxXIZmG?=
 =?iso-8859-1?Q?LW1SgM7PsW7Qq7ThlCIpUAmNVpkpoKSQjGDdb4hcmWcYBqWXKEnzdlMFpu?=
 =?iso-8859-1?Q?cUZRKO2tds96DtgNUE82deAbFLPOLB0wMV9tSZDA9KjzpwBirSZaeccD6G?=
 =?iso-8859-1?Q?cgI2AN4dA3aAUaQDyhiXGxIJEr1lqYF9OqppVXgApvyAUsp0Pw/u7GvcLk?=
 =?iso-8859-1?Q?2PPqVVQ2rDxUQZnLUkB2CY+ToR9UJ1OZb+wxfuQ1VulGbFj6KT7brtgBko?=
 =?iso-8859-1?Q?RdnUxWD7/4vK0U1+1Am+W98bCJgEA3UZyUJHzbJyXuQHeWMYNopojf4h3F?=
 =?iso-8859-1?Q?+IEVzOvdXO2+60Y4EyqQa1UTxAhjh/yXCvyLSo74chO+drHDGQdQkb/tNB?=
 =?iso-8859-1?Q?m2j7zcjtHLvoEYQ4g3Go+9jUsneYDppLfJ3Mgo4xFp72DalTsAREe6Ey39?=
 =?iso-8859-1?Q?kubCw6rpIL7BHYsXV1aC/ZXr5kHnpM0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac958bcb-e722-4bcc-c83d-08da2d6b763f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:04.4386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CyL1300DZUuoCGSETAV6/wRDWQ+9qXE85uWx27hMOjJN/VmePoI1iZTpKNLSCO/z4sjLGfWU0SkIhXuLRmbgZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: YuohclX5hn5m_gsNyX-bTMbXSeNlKZQr
X-Proofpoint-ORIG-GUID: YuohclX5hn5m_gsNyX-bTMbXSeNlKZQr
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mprotect.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index b69ce7a7b2b7..81e5392ab13e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -539,6 +539,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const int grows =3D prot & (PROT_GROWSDOWN|PROT_GROWSUP);
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
+	MA_STATE(mas, &current->mm->mm_mt, start, start);
=20
 	start =3D untagged_addr(start);
=20
@@ -570,7 +571,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -596,7 +597,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	for (nstart =3D start ; ; ) {
 		unsigned long mask_off_old_flags;
@@ -658,7 +659,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			goto out;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			goto out;
--=20
2.35.1
