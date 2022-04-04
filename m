Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7490B4F1724
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377941AbiDDOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377844AbiDDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40853F33A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dl8LD024505;
        Mon, 4 Apr 2022 14:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+lgTl8g/L7/OzSIPq6zVlGhpUeTh36dlbLHmFwvO+CA=;
 b=CN4+/xB/Nb/72QzXMypk3+V3pYu2Umyr/h549dPRlhBSaz0xaAMt962+xWE7uiWump+s
 AAH9glHxRqMT9JOP3iEWu8uHPZDh0BVOckZTL9uxKUJ3kB8SuCqf2yBxpG5yXO+8O4De
 mMz5FGOuKavmPlHi5bvLYFa/r9P7+lOIJm+nn+WdJtt/lRQzSNiOjW/lVzB+g1kGlCNn
 LipPMArluQkofKGzQzMqgqfPlO4hcVC1w0bqz1xRibuws7vvJUi2ZVMujc4IovzNju8U
 TvUeAWbCrDIbDHQvQK7mXxFIwrEt5drhtypA/fXJRx1EGvsj8BS34geQgRwRY6u+jFfw fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3csd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGQDx028988;
        Mon, 4 Apr 2022 14:35:46 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c8h2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kud9P4LcxyC1gBRWfSqpEAfk/R839AT9czweDhdpoRzGNaN/9Jf6OZnK4m0/jmHPrdcom3zckg9pwf3i0A3QfmcE9MQBGOBhLRC1HG8pV8RK/E4hmq0OD5kpHqFs7L2M1+trLkPzNp3idAFHwVKsD7Ed2G2xh3rUf0TuydSLi4NB70byhjD5jKSKBnJhxntdfaHAAG07cv/8fZidtexEsjQReyQ9WPAk27kesHSu4yG0GHK5YXPLxKx5731GSO03ldnjPBCa+jwK2+XAuqC3HLX0ESio+7NUlfcqi5LlJvjWAD1nOseaoOJh00yl75jUQ6EHh0tcytLR+2uELSuxzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+lgTl8g/L7/OzSIPq6zVlGhpUeTh36dlbLHmFwvO+CA=;
 b=KTxImpjnDoWRH4ULBPne8WzVDtnhEGabl3dUkOTmjamK9NvTTcsDgGH99YCduzMDPBXCdz8L9r12HiqJtERT0PgH8sDsr+xAs5xl0uQMYdUCQLcGkM2r87iMH0wvxB4zq7j81Pos2mu4GWL1szihgq377ekXFPEb892L4WwbodLuKYSvoYlCbxhfkTRJcVnXV+M+yKiTCbmDQR06E8g/MslDElhsCqlbxJoxfFQfIXjSWHgLgOgSk42iO+ch1mUxRvJPjn/VjP6lzd6EKynh/XG/dh5nxwx3PZCgXXaPCGxG4fWuDPH+MwjsZ8IQlembU71OmKxLWqQ+E9oeeZ9Z5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+lgTl8g/L7/OzSIPq6zVlGhpUeTh36dlbLHmFwvO+CA=;
 b=xG430I6YBUfpepPqCDJ9c7DuVnEPtZDAxp8O6Pi1ZX8mutck5Lypfj8rBDqZA9our9JoRep/wUkl1AWFh5XUDw7d45pmNbyWPtdCmdg8XJKPCLXbMRsdl/u8dbcoQsJN6veGhfrYawJqspIQrNmNGXrY0tbMmnvABL7NUGRc2eg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 20/70] mmap: Change zeroing of maple tree in __vma_adjust()
Thread-Topic: [PATCH v7 20/70] mmap: Change zeroing of maple tree in
 __vma_adjust()
Thread-Index: AQHYSDFCY9u0XF89l06Lljz0pmIDsg==
Date:   Mon, 4 Apr 2022 14:35:40 +0000
Message-ID: <20220404143501.2016403-21-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea16e48c-d361-4b13-826c-08da16486656
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB58123DDA11BAB797A3836FC3FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MnDuTb0WpJGwFlrNr/cT/Jg0khl9ZdVMAbxgUOVrqWJaLCGF77XB+kzF3d7nV3cM64QSxTI6R8vgMh9MMJ1TvTusRS8KR/SByG1SH+KXt2ybnz80PpGyoVn041vertqlaeigydQmlTgSVCxvByZZOdYuSiv0+c+72I12T2qqoR7j6GszRnnpKDWt6cmLfRlvpJqa5AwUPA7g3H7KF50EXbtVmIXXZFFSij2U0LbyTMJ4SbXDSAusqVrhZ+8pZ0UVri4YB5Qvhq0vfxW/nToVJk4bBFO0JfEClqWapwCWO72/KPMzbKP/DgnA5cOY6Ul8K6fIPTALbXdW2lGmB95pKq5f4PMBkPtIwr4rEu6jhSf9GBxF64XU16jPq1vlkk+HFdD0sHHTZr75gvGZrQMe/lUBUWw36rerqOKamUw2TKuFEpXoAtvLYO+BjOTTpwOYhrdMkZN9ZK2weXGMjrhfkn0+wOUUpbWn8qzyFX6HH+od9lsQYHkA5llDL9Sowy9cJ/nyC0LBU0n/O3eMF+moUf+JgAv8YMXEtLh3bTmKLYm7CvfBOksawhGbi4yiy1vLWx+ZExGmFoGv1s/QSrGCZNbNgPaQruFT9d0HRjKvF8Qc57f5X+YC6xj0WJugH+gqpLerond62JyUfdCRTyQNscQOGK4zbvo+g4QpFaQr0eXaHld2/lN0Y7CkYE2gdPQuXYH3QhW/igceQVBm3EQaMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?aX5M4N3koPoy4SbmxTABnUSEDb4tA7/+iEnHXm7zPzSrKXYy/8pgUwncbV?=
 =?iso-8859-1?Q?EED/oQiAQyM3xoVTYhCHGrBbKn0IKM6sfuzHuFDJDSURm2erzHnw1yne01?=
 =?iso-8859-1?Q?d92+BwkMJqpIZsauKwZ3lRjEclcHcRQz/+DPt1I/peUe0RgjgyHaN+1cz9?=
 =?iso-8859-1?Q?6mv/hCDj9CBZ2mq3tetcGy/2u+9bgnpmZZHa6Ri+uY2/MpUaNF0/tPdvDW?=
 =?iso-8859-1?Q?A5QGNQzu9yq1xulutOStLlQbl3+/iHB7bLwCR4uqhCSv5OUUhGrhaf5YFT?=
 =?iso-8859-1?Q?427t3OQodxCbUjqNAhjZaXaPofiNEN6sHRWLj9DgJEE2SZThI0nLy9g/qH?=
 =?iso-8859-1?Q?lTd793k3LkD7GKnl67qx2mPe+QseOVPqBmbrXgyr8nRQB/tW5tnOfQQyi3?=
 =?iso-8859-1?Q?iTI9HdUUvwhGme4bD8ekw45sjWN5D20S0a00h+EjL3h06i3R1e4nf2hfRm?=
 =?iso-8859-1?Q?xK99mzgWu/BT4/LzpvsdnqpZh/wjy3AgXx9Ro38DgGrMvTCiYvvhtBZiDo?=
 =?iso-8859-1?Q?25W+68tWHrezcUDEUqRxENV8S36PVynn0t7qCXaCCgQFs+lzoryOozu5rD?=
 =?iso-8859-1?Q?/apbe66RyaSFgxxfbVpeg0rOli/L1q7oVeLtjPlbwJNe4JWOIeoqkMN1ht?=
 =?iso-8859-1?Q?CxJQzeO4GCUWN6rv+D5d6v99I2eBTGL2eIhUjnFsWQq1mGQMoD7EgGk1RY?=
 =?iso-8859-1?Q?IZSCyN9nh5JaNoJVL90z3pZeGK24jJ3PNTe3doYtoRWmxvQ1vAExI5+nVw?=
 =?iso-8859-1?Q?zC9cVIY60xgy6VnYYgROwo9LsTiSSaxRTpcXrCMtY3o+MlpeFwOYtHez5L?=
 =?iso-8859-1?Q?nmugVvfAdsDyF5osOhkxFUTmnUm/Dar5kDc6amKCEibYUmvbPVyyV9qXNh?=
 =?iso-8859-1?Q?NVhmJmKYtOyWpKpEEgb5s8DNF+ioQA88zc0+rXxFzDorKXwDMIxFdj/0Iz?=
 =?iso-8859-1?Q?beYYlIwZmBpIM3SjzeNATkWMl89kkYPj6eS2h+538oZHfWF+434uI+BdAK?=
 =?iso-8859-1?Q?fvdT01ZuQVJXI4ZW3m4FzZD8XwvMSf9x75BqQXryLJM3gv82hseQmspVCg?=
 =?iso-8859-1?Q?gV+t1Cc5VhH9nwtOQDsG1RIXN/BzJU/jS8Unf3GxQFZVZq5X5N+nlVRqEb?=
 =?iso-8859-1?Q?woSstiOeI26JW6YvzxzGKzoi2T2YA2hX+213OEj9c5u1kuRovM2ERyjtKS?=
 =?iso-8859-1?Q?KrpSakVeSTmY+WWs0tFQPEOkfs6VZ8X+7c5eKAzH60YUhn07qRPdjL9QV+?=
 =?iso-8859-1?Q?790pTVRPHQTda+yXbIim9y2GAipzL1LYSDRDc47umivwG3x2cKzLpj685X?=
 =?iso-8859-1?Q?pwKt8KjsRcjpujyFe1CGpo5UHBZIKvaP6VyPnN0py7oU4nGWuVZXwJ0F8u?=
 =?iso-8859-1?Q?dIuZBSPjYvBRVt2yOtmzwQvVEhWWVAdUwIq293BSetI5//DEV3Sx2ZijUe?=
 =?iso-8859-1?Q?cg2rohen4JsG4YlsMKPT3/bIXIVFqYFzq0mYrHTj6lLZZ6uQTIYvXOu7JJ?=
 =?iso-8859-1?Q?a7Gdb+2c+O/K7S9nthPtWt2cTQFQytv1rnDLuWe7Y8hbS7ugK9RKQqU4FS?=
 =?iso-8859-1?Q?apO9thNGVOXrAu+kYLCDUxBiVn32Gk4S9KStcif/oZx3o6YDtsFHS2PP7o?=
 =?iso-8859-1?Q?Algs9pQBkwXTFm3OebseGHAQvMmhz/+wi+/7YV44I1I8wYKVQTgjAI+NJK?=
 =?iso-8859-1?Q?yPtzyOSEtXoyINRZHp7NOyXOlg1smm02bwNQDDWa8gpcIVnTHqI3R8Gl7M?=
 =?iso-8859-1?Q?KeSublm/rj7wgJQxLg8Ki/lE42eyRc2BBANZLhnK9vL0yDsMsbxFJRozeO?=
 =?iso-8859-1?Q?T01h1H3i6v8vC2CYqV39TotnbCbxAzU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea16e48c-d361-4b13-826c-08da16486656
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:40.9718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LpZJaefY2UOfWW8Th38DEGBOW7ePqWrcYzODdiYdVbLbV5E35dngz2qKU5zXr7Ebf+/A9BxigISBv0qrjn/Wrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: okYwL_AxrvLo7VtUlbinDo6xvOFZB2u6
X-Proofpoint-GUID: okYwL_AxrvLo7VtUlbinDo6xvOFZB2u6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only write to the maple tree if we are not inserting or the insert isn't
going to overwrite the area to clear.  This avoids spanning writes and
node coealescing when unnecessary.

The change requires a custom search for the linked list addition to find
the correct VMA for the prev link.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f8b84d957284..7b4db8decfd2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -582,10 +582,11 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma,
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and the mm tree.  It has already been inserted into the inter=
val tree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
+static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma,
+			       unsigned long location)
 {
 	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_start);
+	MA_STATE(mas, &mm->mm_mt, location, location);
=20
 	prev =3D mas_prev(&mas, 0);
 	vma_store(mm, vma);
@@ -613,6 +614,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	bool vma_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	unsigned long ll_prev =3D vma->vm_start; /* linked list prev. */
=20
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
@@ -739,17 +741,27 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
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
@@ -784,7 +796,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, insert);
+		__insert_vm_struct(mm, insert, ll_prev);
 	}
=20
 	if (anon_vma) {
--=20
2.34.1
