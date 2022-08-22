Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634259C21B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbiHVPFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbiHVPDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE3318397
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:35 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkItD027901;
        Mon, 22 Aug 2022 15:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1kNb/4PZSO1OENQH4kGsfc+HhKZTvRmam3cOhRQymGI=;
 b=YWovA3Ugy3Rg67SfmvGXfHPRw1q1T2y42G+rSafDDFKh+CBzbLmW+wZOVA+SPNloBoJJ
 eHyIPG8U0+6tESE3f8aLBFDoMKIQ4mKkRPLkVMEOpVj5G8htID05aFO0oDiIA+fFgmml
 2mFQ2QH50YuvbvU5GCvp6O/qp8EWZSuPB/Uo9kCX614KQQKPckm2kk7xR1KxLcFPqVdO
 +WmV+0LASVYvieOokUqunja24/hYSJJHkx9V1FdBItEmuldn6AS//1aQ2y/u09KZLv9v
 A4eA6oWNTlpF9E5SK9H/HoUlLp+LcpVCzhGaYqMUR3W+draSsCWfQ4nFwJfTObh9wQUa kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4axv894e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Ok9035558;
        Mon, 22 Aug 2022 15:03:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tv5j-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIqt8F9vm7pEOrGd/nJXY5MYEdeA62sLpvo9hQ0oIVUzviElkl0XagaHh+siQ8JSppHeZEXvyplKYyzPQptT7WISBYfBZi36HDWeV8b2CjOk7AWuChOk8HDncvnc8zeu0NyHiJBL3suSnmOxDirmZCjK3fxkiPFUWFC1Hv/YQZBkjFI7Dr6VV5aUrLeM2brQRZ13SmBV6OAlHM0XOz5nMp7zZM+y6XAEAfnbRtH0wY6lQcHOAuXMvSa7yzxGhGnJXy8RGbEtD9drGkDAX81S9mPMdqHqPJdCIxafgFyqHaBk0VALr/djUDyvfmto0rumEVwnBWGyn4BkX7W9sEMQpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kNb/4PZSO1OENQH4kGsfc+HhKZTvRmam3cOhRQymGI=;
 b=hCpWkgUdv9eR5ZdkNEMHOc+ZQkaBXkF+bI2S9Or0iSh/QD3wG/CS5/odptzqDm8IcRo74wbK4Q0mGbwxJqLJ598YfIlhFe+sxcKVkYeX4L2ygqw6IjgJE+IQpXhEwjviZ6aKkoAwGHDjgh4PTLjX4lcKqTCN5UC97+8tMH/1+Br3t65GWlmTVxtKTkBrWxodtTn9CTKNwUbVrEN6CPgXrgkI+ohg2pXIaX4UVRuUNKBD49Fz5nuoZpXs0PuDOSTAn5QOlzCSkR3V3c6KY+a4zosV70RbKTsTY9Q8/aIinb2NLFYkX1CX7lBF/EgHBF6dn8BJurEs2Xx2QjE3ZzD8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1kNb/4PZSO1OENQH4kGsfc+HhKZTvRmam3cOhRQymGI=;
 b=EDBElAH+c7gWWfzhtCy1VcW1tBStsMUjzg2br00pLyRqucS501j7nKWexknXmhqh/nCgthBPSlvbqZkeQ/+yppuz0QtMCmMQ1mtmVsWP7JzsJJAvYGoH+zz92Cnmjnqe7SApfMe1WSQKa/8wQj4pn+E4Vc/LrWxBez/qk0NzheU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:03:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:03:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 13/70] mm/mmap: use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v13 13/70] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYtjhKte5JvgDGdU6rKD2l3hgfpw==
Date:   Mon, 22 Aug 2022 15:03:08 +0000
Message-ID: <20220822150128.1562046-14-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f669573-0a37-49f5-6194-08da844f727c
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Kn8hA3roae74oZH9BSLZNdLbQ+hfNNFeh/JmcXwlbYeRnRIr4dTTaOTFaGmnrUFV6Fa0/ojeB/yqw1xXwEf/pV8gC6Ny6LT1DqlXmLtUC2Q07B/1RIHorKxTKMqooHuR+eiF/McQ7klW4JgDdGvSe/hwhOIjhak9qc2zTq1W6N0IGsW3T/zuCoyWfwericj8Erym1D2gSOY01SvfK6oeXTiulsjSX3osF/VeaBpS++vZBU3JDhxXulZxL+bz1yVxrw2Wbtr8YMRtqn2wHIK7tdOP04sFC63hlJWY74NurZGCpnHQUV+nMCrDn7tJYiP4RDTMgLydh1gYUGBbEpA7a8NhJsbFLTvL7OCz3OuO3JV5W6N6b8kRhWD1ORXQ4FZQL5IA8Sq5cWXZv03lRuOkA5q9aRfoeu2c3MPum0Lh57+HJLMyK/TKw0kiRlLlnQjJNbYnjdICUQY3CDNSwz/kWHXCZ5Z/QBJJXgFhdjI+jjpkJyCvi1bevbojsDkQqIOvNKyf5e2g6ujQAujtKrsmbyQl7D/emq8vfdCgu9rnOgr5PzCbtboBNpU2kGz9zFv5pCf1w8vA6WiaaVhCL6rNE6i5OOkb3vzqUojSEfjiJoLiFSVzrH3RBWpwZ4m5dTPeoSNyavOSpgmoXDgpLIT2fhL/8t+8pm1pDpQ0MetyfQaR96Samx01NvCdEdqkmJpD21rU1EXQyoQXo+usVwsJ1DT0zqQTJPjoNHDPp5lAFXHRIGBWsFTBJs/ag471OyFxHpDLwvNPiM+SatZWy0STQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gLSYugcTvm+1G5ABYgvZhnXkb49d19rKPXlef8cL9MMS6wPtYhD0byhiuP?=
 =?iso-8859-1?Q?oz3WCmDLFXkVhlkw1+lrzUWHB+oRQ/q6YAEfPyYDnH+n6omp0astFKbexW?=
 =?iso-8859-1?Q?boBh5ICoAP83IYbMgJu7oJsn6jREdcSKjrs0Ow2NKfrPgcZozcJi9QPlhs?=
 =?iso-8859-1?Q?qatC5TzOu2BAH7PaafsvP7sYWYZqeD7Jh+m9pm3Y7UqeB00nVytqC4Fx/o?=
 =?iso-8859-1?Q?KjZxTwvd+jKcR6ob1QM2Nky0gRhZloisP4Ri8BbOu6kp2WTB6cvb+Xirwy?=
 =?iso-8859-1?Q?UOpiAWGQdglSeCYCPDcZfremvDtWPUESuC1T6g7y7ae8kuQcHQ41FqYBVG?=
 =?iso-8859-1?Q?pdG987iX+lDrm5MJFqhSpreLyioahDbLMxczcmqYl1up9iZS6SjVp9WUdN?=
 =?iso-8859-1?Q?OLILJwqKbj3Iit2LAfAyYEJTyQqXNwiewdDf0BcUc7Pln/rj1UmYjVuUo7?=
 =?iso-8859-1?Q?tOCG6ZFujDoxa8pk8w/wkiq3tmp0aCWjVQJs1wvbFtK/PK3zlob/QEMRf+?=
 =?iso-8859-1?Q?aUQ77OAVQ/ZesTt5llyWjXdDwl8BAV0trRuSKuF9bVc1Tt/4wCkpAl9F/r?=
 =?iso-8859-1?Q?vYG3TTmQ8l6Nfqi5k5vXp4O5oHbBIVLrcEK44jVUbR6KvZ2laWHu7f2zEi?=
 =?iso-8859-1?Q?iDnD0fmPxVi+VcHCRS9bocSN+s1lgbYwQyb9TiNS1cvImhs+5Bhhpxq0pQ?=
 =?iso-8859-1?Q?h73Vf0zmMZtEZTpJJt7FyOmKoNkn6PGwvFmBP7mc25/Kcp/pXwfbb3PGQU?=
 =?iso-8859-1?Q?g23/U3YEwYGqg54tTATYnUcXHp+z5JGpdNPXkAMH5j5l1PtyBnBMuJD5jJ?=
 =?iso-8859-1?Q?Xjs2PLlit+4YEx98ycxYu+s8JmU3ZzShENNkmjc5rycvOsts2hIrxuBcXj?=
 =?iso-8859-1?Q?JFpaJZw8Ga7QHjlgdGf/BLgyBxslhZGQ48OYXKQwZp6dHdIdoRT2gso5YM?=
 =?iso-8859-1?Q?sl/9zXSMGsbnCKuC8V5nJhWw6DnvqKvX1/UBKvBwBcgNu/rR7Ik/Cv0qMT?=
 =?iso-8859-1?Q?/9B6Io44KpdBD/ICZKhENnZIzWwa0FSUm0/TuDYCo8FkZy1eW9Q67feoEc?=
 =?iso-8859-1?Q?S97Wi1ctKvbU0b0ttiG7MjV2NIm+di+d9itToWRnxEIRMs4SxqzBwAb8cF?=
 =?iso-8859-1?Q?cLstL9qTBMd4OWayQu/S8nfXiX4Aq6uobU/XTx59ZB1/dW+TkBAj6ZfrL4?=
 =?iso-8859-1?Q?Dy7CN28kLXfhW7Kl9lIwmxq/+Y0umAaHkFv0tinpSqI7QoNm533QksIk9G?=
 =?iso-8859-1?Q?AylSW1O61Uqbg4NhiWARVj3AwMzfyghC/LOUF/jYg4c7k42glrruYkZSKA?=
 =?iso-8859-1?Q?EXq4843xO5VkS2lxArZVqLT0GfjNxy5Ku8AlVetrB2wj977O21eKVbcPhR?=
 =?iso-8859-1?Q?QpMPJApRHm9hdrxjbX75HT3JyylaM2lKseZV4SG5hfogFtMgfp9nuDdPc1?=
 =?iso-8859-1?Q?ZsVzP6ICVfz1hRZ7hNpEfnRpRp1KqCRaELHs0c0jSgKjSa7IgOrFAPkmfM?=
 =?iso-8859-1?Q?1OHX3TFjiVRdo+358PlVZdque/RRTYYzG05Y+25JpBh/W4g+MUdXqzxv7q?=
 =?iso-8859-1?Q?Bfo3nqYRWW7Y1sZ6i6YYfreEHXzuD2cDEFd5qGI+L1onCC2OJUvlLAMjZW?=
 =?iso-8859-1?Q?70MM46gU2LtciCAvUFFOI4qEkv/Fl0mxMPH+c1a7z3RwlzjbGzgEP2Pw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f669573-0a37-49f5-6194-08da844f727c
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:03:08.8608
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IIufdW6Sr0F9jtS1jSttcfID0LwIIno0UkVL7FF604chmuTv+5IdzJuGdtluZEphW9Cj9TOpclQP+jBQt+Hs/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: c_774RR5AUiVeKAdq6phVJS0WDoOnX6m
X-Proofpoint-GUID: c_774RR5AUiVeKAdq6phVJS0WDoOnX6m
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

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 255 ++++++++----------------------------------------------
 1 file changed, 34 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 948264cd39cd..68ee2958c0be 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2013,250 +2013,63 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/**
+ * unmapped_area() - Find an area between the low_limit and the high_limit=
 with
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
=20
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
-		return -ENOMEM;
-
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/**
+ * unmapped_area_topdown() - Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	gap =3D mas.last + 1 - info->length;
-	gap -=3D (gap - info->align_offset) & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
=20
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %p Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %p (%p)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
-
-			while (dv) {
-				pr_err("vma %p %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.35.1
