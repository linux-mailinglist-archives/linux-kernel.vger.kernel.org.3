Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17E3D51019A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352056AbiDZPPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352002AbiDZPKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B541524AA
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2al015530;
        Tue, 26 Apr 2022 15:06:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8lnd4X2uYzIMBZwXBbmt9o4VesBrgsUVUuDwjTiDneA=;
 b=Oc5rO3p3926nJAA2cNsskNc6QmiEb2KJAQRWYL3aXYKXVAf5JakHoqS4j8HhBXpIJSrO
 TlYRNNsFbRm1PvLUcCvf3+PoFicwpmgfLyS1XLQMv8OJ52TiPr8KR8S5nGI2pECtjLfo
 gQSAyXP5wWrfCIxPmzjTqjpuEUROpUwJH5+ZNVE6w1c4i8zOarJr4Sp4xxU0fqb9q6bO
 uuWzB+8tYS6ujeh6kGHvuXIIWXYrwpmCe1gcqIOWaEGrPlSEUve8laHi0VzQ5e3zna8W
 h2hg0BefmrbhgBF6jvBVO4/S+YC8czESzcEg5n+uo4cjcNGaDG395lapZxX3r+nSqMzn Vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:40 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Urx037859;
        Tue, 26 Apr 2022 15:06:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktje-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWYlJijdgy6WAKtyrdaKFUvJ0VbFNpQdrlAuFNCrqyfQ4B1WNqYVBazTdnG4eFxMLy/i1dYErlrJq2dqh4KKgQcNyvLujLolASHhYtViyK0VPuBVuOQUX/SdR5hjSRr+cAefm2hDJrFyS4hSmAWz0w5ypXudCNP/sPOYnMzIC5zH4Z2vF3jSkh6aj2iiGTX/iYGM6KTcsw81vzFiUJ5EcHQIY2vbJJjbgWFEgFXaHffXYerJA5FT9+V3DM0dB1hvswX5f4CAkLrVaeolsv6nIi5B3tB+BrcE4PyfGYp80872CGDS+laj6t6kJXBnEAtcArc0A+7nXB2jhX1hV0xjHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lnd4X2uYzIMBZwXBbmt9o4VesBrgsUVUuDwjTiDneA=;
 b=RwTSZJZTV27i16cqIvwM1NzRuWsE4Gb59tocLPBObvJp5ggMTSbOv6GJ5Zjrtd5CeBdrHoRcBzk69Ia52T4PeVZ51QsnanJz7qJWjQF4ROjd+fLEbkHjXikP9dkfOq3sBKaqps+ADwLZk3bA22meQHwW0eyuuX0ASq1dnhKovcTL++0JSCSZzX2ZOeRK1lR+Kb22dJiJ75HVYiuoX9NP2pA/SaOHkU7ujchP7Mb8Jw+y9RoR8ASS3bA4PyGwNNyobDxXJRtnstZirZuh/R531Rh5UeB+0vJTbTH9Fful2z9u0RW2cw1L1ii8ei8x6NCgszyqMjGmuqEvuVj7qWLFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lnd4X2uYzIMBZwXBbmt9o4VesBrgsUVUuDwjTiDneA=;
 b=g+gZgOkbaEYArc45d4t+Yk63tE72K5kYXdDVO3c4Z5RA6jRYnA1cjQ4GRugeNjQDdghoCY+O+BYk3jzxZfr6OOuylzjVQWgci+y8QyIaaos5OkMvcBJWwSGL3wHMYooncdCXdyDMWewUc+gNJx2lZQAUIz6DjLpOX+PKrkS2LgM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 19/70] mmap: change zeroing of maple tree in __vma_adjust()
Thread-Topic: [PATCH v8 19/70] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYWX83szDzne84Qk+cPdWAgg5nZA==
Date:   Tue, 26 Apr 2022 15:06:34 +0000
Message-ID: <20220426150616.3937571-20-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73703bec-a40a-4d7f-ef88-08da27965ac3
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB467907D2A550C39D5FF27B53FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YnzYywPDmIaclurSqPjKckHB+EAsxGNJtuBqeJ0q0z3pjE51RLrcDe8hdXzob+hKMOz3cXctv58aMB+X15pW+yWLi4O3VGVJiTr+QVvry32yuiYxsa2gQR+T2gZpkvt62NWs/0Id58AGd03/zxLyLxaPu13ONEcYGnanpam/ekJoQH7z/wB8l/ZhdDRsmvfdDdRgGBPS4I39Gb4k2sykpb9qh7XjYoaH6aLIB8rTw2bsgJsGIw1CUOAQmyYh0cWdq8PEIivfxlJsG4MogkrOyb/GfCxvHL2uqIC1uvGWEJlhW+vB8nDgKa3GyZxdd+MUJ3YAisFe2hoeO5abvSqRgUz/tjHErMdQUhIO3UQGgnmIgKSd02Lb42t6DfMJmKE44AAaBUZAerD/60ZfNo/gxRSytXsladDpz2jgyxekitkWNPnaMb7YsZHYItCWUzuRY+gQyLymsZDBFdwTsc6eEI8RGm8i94qQA89uPTDbkbwDUMblRN9SQFcWTRMhHNSIqXZTEbhp5sHx9JavILg1+uR8s8TGsm58QjZafWDuLzGvHrP/UiSSauhNN/CwVpGbQ9gckl9wHC4KO+dAGsul4xzhZ9lzJAivvZwOC6/hDJyGal1Cd5zEgF1XyuyCchff+zxHhTcJQggWKd3TF9cdW/dmaFYgdia3T3xHk4airquIdDuDS1jSzv5FkDyeTLt90fUjhZ2WXPSxDThMWlx1Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i7rACvuPweWQaX4/sQqhWfdlvu5Euee3n7OhjAQtUBcY74gok7bPfneyVC?=
 =?iso-8859-1?Q?BqiFJyR4BUBqOVrfO9535OFhbYwMN7lOhxGFkTOWfbYbHl0B0cXIZa94YA?=
 =?iso-8859-1?Q?Y4c8m3sjFIRY2zb+m5xtR3vcfLPvN/3EnDXfdjmeMQtjR4Llm9w+mnj3Xb?=
 =?iso-8859-1?Q?UFnKPctSiBaGmBRIwzBLEZQ31uF1extASou5b+lmqdBSgDqUDnL/4f5fOA?=
 =?iso-8859-1?Q?2/1Rak0lF9pqX5I0/n7oFU7XBhY7/6guUIJhzvbSUVLOGNBnx24cQcjNXJ?=
 =?iso-8859-1?Q?zS16FM3nDki4vC53c0kGyIjwsYYDWmAeyj0C6cqeGRbZtozkt1ej9mU5TL?=
 =?iso-8859-1?Q?ZAibyGi13ZYz99uCxJ4i5vF36ohwkdnm9Xm9efF08vnSTzyhIKHKQzuSr3?=
 =?iso-8859-1?Q?KDQ+05gTnJfF1jqK1FNDhdb7t1ihZxYB/a71XCt2uy7oKA8eA/X5Wb/R0r?=
 =?iso-8859-1?Q?G5nubEqVboLZHVsrcu2PcRrf9mw1jq4ESh7N8Zp3BO7rx6NbgsdVpTlkFj?=
 =?iso-8859-1?Q?NxuIlASsyQjdeBzcm6R2J/GBs1N0MzZJnm313t6laadbzf6fsEpTcb57S8?=
 =?iso-8859-1?Q?+J6GWpicERIIwg2z7GA3e2mI8w487/oQdDBl9RdSlHw6xVya/Mbz3Zpun/?=
 =?iso-8859-1?Q?cNJFF6t0/jy/GG1bR7iuT8AexFBjdbje80J/2mUASafKPiC3SaMw18zv/a?=
 =?iso-8859-1?Q?eqe4R3eVrDSganWsjBLwIFixHPKVMxODuhnsVgz9UF3FyWwIeO4jb4k82v?=
 =?iso-8859-1?Q?HbdLFZmrrMkTVP+rMRAk8gAHz0mobdDt6w49OCpSOGE1AL0oBv/+DUSLtU?=
 =?iso-8859-1?Q?Q4Y8FNdoor6sSqsqYPfG3hpcoVR3xzCcAus7jNdSnRL7A51gIgwnVlE9y2?=
 =?iso-8859-1?Q?IiNvebwUEqTzpD5UQSJGRD0Gl0bNN5rspb0QPtZ6yFsaPDMJq/k3pCNql7?=
 =?iso-8859-1?Q?vrD2HBBwqn9ZWXGtz9BbNklzpRFHnPxZoCk5yr1Gt3FeDHReHJBQtoQfml?=
 =?iso-8859-1?Q?QYljH3gsEi9rvpfo0K69ASKuuJZbMieM3SqCMaszLgSyflPPjnuSzp+eK8?=
 =?iso-8859-1?Q?YtDfK+BsiiNT8UU3wJ/TOlQKTV5Lkk3VcokElTPqcxT7gMorQqQTV3Yhqf?=
 =?iso-8859-1?Q?YQagBoAAWUBGhf8yWw9DVvn3CZRpoKwL1HIztoAbD8GgbU6IfseWJC3WvG?=
 =?iso-8859-1?Q?QZ7OFA0Z2Q01RdEpSc7Q/LwHz1BOnsMMSv34w75MyDblTcB0+IMvOLQ4aD?=
 =?iso-8859-1?Q?D1K6ORe0BmYZjlH8RTN2TZla0AKX+yaoLoqD4uNElKYNwKV2SFfjrKQ4nZ?=
 =?iso-8859-1?Q?1NhVqN0jHWvkbvOSbzMOP1DUJhfNC6FDei04ZAz9Mq+jbFMORTUCsMhfef?=
 =?iso-8859-1?Q?R5NIVMSAEcl5qwxSQ8GdtB2VEHzk4m9c8yQPxyP4ivXeXg+IdNZC5jd5a5?=
 =?iso-8859-1?Q?QCIvkS04iIrtVRmfmvnssuL4IvO0Reu6X3PQ+87uCHw2O8ay8Sl71Oo2de?=
 =?iso-8859-1?Q?qOh89bsNGwybDYFOlAXC6gMKmJxCugXjmEOO2Y8Xts7dIyvOeC1i9NyJ77?=
 =?iso-8859-1?Q?3SfPjIj6AZXpafz0HXWq3GLuFlS6c99I0YE/B5ZkaP5rdhm5i6mwTGbun4?=
 =?iso-8859-1?Q?XR59Lc8zg4uv/BdA0e+USRT6UWz2zPxgMk5LPguDVoIDGJdz66BhqoekeY?=
 =?iso-8859-1?Q?BNugpVECjdkWdXmGtiLmraOQP+QDWWs6ZLQ+xSCOqYbU2jDi/FKtw54T1f?=
 =?iso-8859-1?Q?Xz8JmjwF2sNXU4C1Zc7vj74nKxwMUNFsvhRwJDMkOhd5ftUfYQ6dMLgOqL?=
 =?iso-8859-1?Q?0hJmIZPvv8D6AME7Yze224GYQ4myCTo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73703bec-a40a-4d7f-ef88-08da27965ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:34.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8qKh+VpcrTVtXMGQO3dOcHeF3kB2R3uh55gSWXgCw7RMqAQPCNndtX6Fj+waeEA/xmWM+QHIz5x6556UjKAhPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: 8leioc7f3wbSr8g65-SBBHeSK6arthOJ
X-Proofpoint-GUID: 8leioc7f3wbSr8g65-SBBHeSK6arthOJ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

The change requires a custom search for the linked list addition to find
the correct VMA for the prev link.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 622ccc28940f..ec09b68a3e0a 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -597,11 +597,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma,
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
 static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
-			       struct vm_area_struct *vma)
+		struct vm_area_struct *vma, unsigned long location)
 {
 	struct vm_area_struct *prev;
=20
-	mas_set(mas, vma->vm_start);
+	mas_set(mas, location);
 	prev =3D mas_prev(mas, 0);
 	mas_reset(mas);
 	vma_mas_store(vma, mas);
@@ -632,6 +632,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -763,17 +764,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
+		if ((vma->vm_start < start) &&
+		    (!insert || (insert->vm_end !=3D start))) {
 			vma_mt_szero(mm, vma->vm_start, start);
-		else
+			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		} else {
 			vma_changed =3D true;
+		}
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mt_szero(mm, end, vma->vm_end);
-		else
+		if (vma->vm_end > end) {
+			if (!insert || (insert->vm_start !=3D end)) {
+				vma_mt_szero(mm, end, vma->vm_end);
+				VM_WARN_ON(insert &&
+					   insert->vm_end < vma->vm_end);
+			} else if (insert->vm_start =3D=3D end) {
+				ll_prev =3D vma->vm_end;
+			}
+		} else {
 			vma_changed =3D true;
+		}
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
@@ -808,7 +819,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert);
+		__insert_vm_struct(mm, &mas, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
--=20
2.35.1
