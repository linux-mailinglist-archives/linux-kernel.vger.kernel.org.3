Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B523B59C22F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbiHVPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiHVPEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:04:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9619A3AE5F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:04:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirGP017918;
        Mon, 22 Aug 2022 15:04:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ddj2FICrVCtFlnyoGw3HPuEX/F0/JqO/TZfzNPxhAuE=;
 b=yldH9uWqxOxlDbOy8wPXKPhKm5fXtxvOXihyiBRqMnuSwH416qFvF4WCsFQlQij3F4Kf
 EeCtuWqky3aD9ySnD29yCQom8MouE17U9Ze6CeS+pHzx5TMiXfR4v8PTThIx2S8/mxOu
 W3Gqhjh5XZeoKDOws288SA0j0L4Tkn0y+ulj1Y6vJmnAA4Y77xDbIsvLcpaNb1Et4ef4
 jPNx3+QWgVqTfCWrIzNr1ZMGA2CQEmruCtUZ5QtTGBqLEZdTRtUKM8DlUHZQT86prZEd
 zY//lzkKxxQNrnWModNmhvO4kdCLnM4uQhmDY+1DL3MeRYXOT2x8GuNH7PxEj4cIvKB9 bA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt03xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:04:29 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NR3035397;
        Mon, 22 Aug 2022 15:04:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1twtv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:04:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cz/vfnxK/8qbS31F5sa+xyJSt9U99CUl4Zsug3tnjzi17joUDS26PozIL3d2PaQHBPZ0g1F5cnIM0b5fWCu0Gp8Z8Jbo8G4X58qCQLXO1by74p92vP/a9wZ5fIr2324sc0wNXE9siBmKsdJ5BGl/x+geSnD7M44qTp4rShRvxHsDi+Atl95wTlURzBIC5ViCElwGkCIX295f2lg7syLW0FoLcI4kUPYexr4mfcOdrNxscLU16ON95NV91dGhhC+/qV2Sy4+jfGOUVk1FH7Heg8tGrirJOCTvdaSgAh3P2LqirYitWwq2j71GbPXJt6u1xr/88YclKpZFKT2KKd+aew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ddj2FICrVCtFlnyoGw3HPuEX/F0/JqO/TZfzNPxhAuE=;
 b=C7vQwHQHfq7G8m0/ER6GMQvlirDqJ7ptXkpnnpZ+GL3GmVI5bfTuwerCCZqW8cot2e1qcACHIrPyUSBDWXdZXYSGnZC4uTyQfh1nqsy4oE0zK0Wv801AS7RmNg20c/3ugif6VIsco2TBCy9iDm1YZBhbQzS+rSuZ0C1ccq8Us6Nrwmfze46juWKhZirnl60prztiGFVEwlASRW8SzMvS/lzr80LSHpteMZdJFoBhyma94TBVb07v4zGoW/qANSizYIkIhs1AsN0bLR6Pn+hhOKiQe5inqcoEj37zxObsITgG+ZSSlXdKnsIS0sCLARz1TbP71ygPBp01/B7w3lrLvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ddj2FICrVCtFlnyoGw3HPuEX/F0/JqO/TZfzNPxhAuE=;
 b=Ysx7YaOO14EAQpVsQR57zJvm8/6r5MzEztTxk56QGHBQX7fknDlBHyni9nrB6F3IZsLG1I70u9dXgdhtlLKURQYFCCVHLrPILeSiLGzVqM31mZCWM0J4BZULltkl1St64NDtqMnK0hyPP30mGz+LsC6CZXW4smMrCOWO/i+hWy0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB5418.namprd10.prod.outlook.com (2603:10b6:510:e5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:04:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:04:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 18/70] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Topic: [PATCH v13 18/70] mmap: change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYtjh41TNK0ix2lEu4VB6qiG0EVA==
Date:   Mon, 22 Aug 2022 15:04:26 +0000
Message-ID: <20220822150128.1562046-19-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2f4a683f-1d0e-4632-2f19-08da844f9b0d
x-ms-traffictypediagnostic: PH0PR10MB5418:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7GpAUh2WirB7GWVoxtvcTALexJjdFQ+hO8Zkd41sIEoOXsE7LaEcM7OS05wcOfxm4KPh4G7HRBd19tXwl9vGaAZl+eoTqNj171F7ndy5Ac6gCJRgHap/ObWhGcmx5cbrVikQFSHWVdbsUcUW+FJN2OqX5PWftddx9YOClEpzBnHO3Iq74H41NKuUarG4HPsOGDt/dygIY9wQptB3C7wbHH6R3GAAI20YO/oiJNH4Wy86AaPeAUyjPOTcl57Fp54acPq0SaHZ+j+4rFR8B2lpm0uZfD/mlDx4mII78VQ+jXKNXydefEHzWmFmT0IK7FWwx5zS6ig+N1SbDsfYr3Wmfg6n4eEJKPZPmJiKt0HdOL+v1hK2wKmaFA7YqSrh5IPVDjaTK8rwBPRx4XiM1a6Vi09DILe1pJcv25fBYVv4GZ74v4SVuNclKGy+nSBLI6puZWXh10MqK1j2G5zxGassQYKpXCdgTma/4hDVJcpzvjgWZtuH6eQ60UQ1T9VbRvVokZRbRPbV/NtpjDmTsELAUK0mQWzbqIcg5rSy3eLwjPnxLczgtF+6CpML1AzFVqXI7mMZ8MGMvufRzv0bQnF3nglxXisEAH9BYDKvEa+AhKH/D0xWOhsT9ANbARBrDqFq9odZR6sJS0rVwOIGB98xRI44M3pCZs8RWEtgj6v9xeMqG7SqtB/13Z9axMHbndyxWfo131fSElbR2LWlr9SZA9WnYZ12AX6BKD7iAUdONB6Q6U0N0NLYGypfJdOQFqNnF6xMmGCq9b9SM8bqeM/xA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(376002)(136003)(346002)(366004)(83380400001)(6506007)(6512007)(2616005)(26005)(2906002)(1076003)(186003)(38070700005)(86362001)(8676002)(38100700002)(122000001)(6486002)(76116006)(66946007)(41300700001)(44832011)(5660300002)(316002)(478600001)(36756003)(54906003)(110136005)(64756008)(66476007)(107886003)(66556008)(66446008)(8936002)(4326008)(71200400001)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yuFVPa/J1C/qekgEFNzZN0QfUzWOkZmw181pjRzZKOqQ51R55enzabY0eq?=
 =?iso-8859-1?Q?kqRYPazxzcRblb4KPa8i8yaL8PMZaMJbo/7g4UXaUsEFTtaZk7GtAWBFXB?=
 =?iso-8859-1?Q?F/DSxQs3a+FL3DFR2ntbX/h/mPYw7XO4VORhpcq5vHOcm9fvaZsBZ3S4TY?=
 =?iso-8859-1?Q?m1ybBDl4qeUHYxvTZsX8spBWGC91AAQ9QhMK05k290b7YxavUev/I2H5Ob?=
 =?iso-8859-1?Q?hHZ1go7SL3/7uCSb/ADJpj365lwqIm8NS+fVsRg1fP8mXHQIYDpDElya5X?=
 =?iso-8859-1?Q?897f/4ZGJfp7nEgGZg15MotoB/G+rUhgVUEruyyR7kXoDF2VcFYYy26Sq4?=
 =?iso-8859-1?Q?EUuLvEW+2InPceKfDtEjuGVKo6gVPuQKkWd3h5gomS2NO/S2Go2BnTpvGV?=
 =?iso-8859-1?Q?JvOlZji7wTOhNePhiXW0ROtTDyL/eYVNx8Rcl4jdMqtGtdeeDDaqr3jBon?=
 =?iso-8859-1?Q?nyVcpWgrygUSalT5QIYXsumaQm18NDv/1ZJhEBOy+7h1y86J+zIddVXhjG?=
 =?iso-8859-1?Q?Bi8JEIp7RkFrwsphN/AKOtohx6/moYv/cMrrFclYfvXfRcNMeLss7/bEup?=
 =?iso-8859-1?Q?8ONZrZavx6GNYxyOtDqnjtiSE52/fjOiBh8Q/e7HEGMncxoTeAhBQRGhhZ?=
 =?iso-8859-1?Q?S+qlOckfQeASIqZ4G4CSQM0W3WF8X/q45ss5KJL5Bbu8cSib+jgTFw9s+R?=
 =?iso-8859-1?Q?XzTCzNMGtRFJ0MAE7uzSzWyNqTQeEDcSWMpyA8hangFmjPEzzBLcVF4hGo?=
 =?iso-8859-1?Q?QuigLRY2RG4OuRN+fR4BCZJ+sNt3Xd3NsCAuBGz8G0QZOj0fYUV/8m1DY8?=
 =?iso-8859-1?Q?fMR1IGAu6JJjx/6WAOOLW4Rbrg93BUVgV8BXCNlrPaqpaTcAJM5ZMmW7JZ?=
 =?iso-8859-1?Q?Oj2jnvyrb3KIKl/UifOx6ZSSX5VPf3MT8IM1mhO9E+k3JQf+ZS43jq513f?=
 =?iso-8859-1?Q?+FEKWUroOur1QX2i254tXQeGAfK0Ixodcg42WzvIzwP+tJFyss5aphmJS0?=
 =?iso-8859-1?Q?i6ciiIeNoEgw7yVsgGG+cqOf53tG61dNY5KEm9NftwEcwGhPNHrodSM/A3?=
 =?iso-8859-1?Q?59F40d/qnhs/A+RbiqS5gUiXLgdlkrpjiXM1A4tQP7XiHDn1JLeWJTX02e?=
 =?iso-8859-1?Q?4QapddppdUD9p0I8vm+SjlvAX6T/siSK7kkTLJRNJeCsj6tMgpTl/9jpmh?=
 =?iso-8859-1?Q?8u8YpEb/18TKFvPeBdGWqCveXZYW3OjRaBUtKzcg1UOSZKU/0pOX0LGQGq?=
 =?iso-8859-1?Q?zO9cMbjhNrhmmYZNqUqVJJNVFn3/Lux8bvuM5noUS/ZgZJUbultRsTcZ/0?=
 =?iso-8859-1?Q?XGv7ipS5w6D4D29R7/z7gFGGaUvkEZIwoGUKs6f7WpQ0E7kIvEEhhOyMNi?=
 =?iso-8859-1?Q?KD58TzkG0TIj+ru2fNV4PPIx85n2frtRdu4hH7HI6gAFl7efmZ5EZ8/I98?=
 =?iso-8859-1?Q?VNJqlUob8wU2534Tx0YAhx33ppUDF5kgswNVefoedFKt7bGtuoNtlw+xYL?=
 =?iso-8859-1?Q?JwSpSkT7avxZJ1FyUhkvSDkbiJ86kzPVUFT4PaNMVbh46rfht3H7erj8ve?=
 =?iso-8859-1?Q?DdDxWsKGdH3lL2WV+F+rPy7rBpR7goW0bEvxi91LvlFTF6no1drIJppoO3?=
 =?iso-8859-1?Q?YalVl0A2XWb3LFBGNgt6uKPcuWok4X4XV9G7sM2agGrvO2BqdYSpmrew?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4a683f-1d0e-4632-2f19-08da844f9b0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:04:26.4336
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8bgboN8/eJ2zWMTXKZXF+UdFnbTqYGO8pv53put8d1WK+/t3fuk8ziLP3dV25w1tsF3fJOrgMVoX6G20jvF7QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5418
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: fw2joZYXYqhmmUwRpFxecb1L3bbwpsgR
X-Proofpoint-GUID: fw2joZYXYqhmmUwRpFxecb1L3bbwpsgR
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 mm/mmap.c | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f60d83c7f233..52a774e70e5b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -567,11 +567,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
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
 	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
@@ -601,6 +601,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	int remove_next =3D 0;
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		if (end >=3D next->vm_end) {
@@ -728,15 +729,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
-		if (vma->vm_start < start)
+		if ((vma->vm_start < start) &&
+		    (!insert || (insert->vm_end !=3D start))) {
 			vma_mas_szero(&mas, vma->vm_start, start);
-		vma_changed =3D true;
+			VM_WARN_ON(insert && insert->vm_start > vma->vm_start);
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_start =3D start;
 	}
 	if (end !=3D vma->vm_end) {
-		if (vma->vm_end > end)
-			vma_mas_szero(&mas, end, vma->vm_end);
-		vma_changed =3D true;
+		if (vma->vm_end > end) {
+			if (!insert || (insert->vm_start !=3D end)) {
+				vma_mas_szero(&mas, end, vma->vm_end);
+				VM_WARN_ON(insert &&
+					   insert->vm_end < vma->vm_end);
+			} else if (insert->vm_start =3D=3D end) {
+				ll_prev =3D vma->vm_end;
+			}
+		} else {
+			vma_changed =3D true;
+		}
 		vma->vm_end =3D end;
 		if (!next)
 			mm->highest_vm_end =3D vm_end_gap(vma);
@@ -783,7 +796,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, &mas, insert);
+		__insert_vm_struct(mm, &mas, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
@@ -870,6 +883,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	if (insert && file)
 		uprobe_mmap(insert);
=20
+	mas_destroy(&mas);
 	validate_mm(mm);
 	return 0;
 }
--=20
2.35.1
