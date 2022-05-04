Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7433519333
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245095AbiEDBMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244985AbiEDBLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11896434BE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:08:05 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KnGuM029440;
        Wed, 4 May 2022 01:07:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Cv8myIjZOfvIlULL8qjTGQaN76z/ZSIoLC0i+L+fVgQ=;
 b=TEfS1rFM160152Oqoc6Iow8VnJ3p8CREsS89ONSdDoktb+0ezL13nzDgJ8k/VQ7+7HZS
 UG4bS/nYgrPHyDKps1FcUxOTei+zZDRKMz1AMSD+HJ9EE/A6Y+vo3rIF95W3mWuXqARD
 OTnWitA8JhuaUyf+wDvFbo+DzKuGRm1oRC6bmndDYVULr32j7UMSDM2mtfecB2jeyvGA
 YLbU8bJuXCvyiW0vjrX5P8aNslFpd0F71XM2Z0+Px2+S0DODRk37XvpvDsQL3UuOzZsT
 cGXKBpqPE8/+G8tl3u6yAuVUOI6kg0ol66QM+FEhduxT1j/uiWFU8VKybQkF7DGFr5dX 9Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f5uh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SvM039119;
        Wed, 4 May 2022 01:07:58 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdr3-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naDeg44kvXw1yO/goamRQbUvW+4z/floTpmTw8QUNoIX5SrcfVeDlaXZNU4MUgGrA6t1ICJWvB+anjEzhZFJ2jiYVIt6z0KcBKHonVkUxceOHTmDHs+He0xVq1XW/XnlK4Z6B8MezksBCHZi8Z6dhwKGGgtOwJEXHgqlaVWtHrUvwu7BYVkeAvSFUGyv84ELlSDxODv47Nt6SnSjRo2oDML70pI3Q2RFLCRDa23UMnJrMP24DyiFCifO0GhUEE06jTisvGpMEGaFGUurSp/i/I0Wkfl6OTpjwpYZRJrjX8wK836ZTD7lk//lkrLTETLOiet2gAlV99ryh+vA4biz8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv8myIjZOfvIlULL8qjTGQaN76z/ZSIoLC0i+L+fVgQ=;
 b=USwBCrqXvhHzUWN3HlQ8GZXJIrHz1qDCyG6OCCLimwQZpcztY0NxGvqji5sVDd8VdXmyHS3rjbLvyKTAXTxTcrZf20wO1JX70wTcgRG9o5SIPeHPSRN++QhVLcUzZQhpTsGfuojRXWo7ylSJB2+1sguUDV0zyZ5rbAqX1nmcPfmaNzge8UdZyCEekb17QiUk2xAoMZD2KdWgRsH57oidxRlqklhx/859wxdPZ/+NtGwBNKMUotcuRZ6fih98gOqmaUkfOic6S64g6L9OIl44k4RzT7m/2RhfpbqiByHjRS5xxAdbtEp2mGoePl3kErRRCKctpNZHg4EP/yUBRjTJXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cv8myIjZOfvIlULL8qjTGQaN76z/ZSIoLC0i+L+fVgQ=;
 b=FAht91GN3vglIt7FXqLo1xekZ4zqxMIp6VQ3UqcHstZiwWHp+mJ1bopvQ31IH/DfIG+ZjWBdloemKbYxNPY0Lk9qIulXM9CZx+Wzxoc5K7LzXy2JcF/86ycZEFjvGCwGoC6/10YIn+edzN4aEyvjl4Sy4pGrXfpS0YaXT0AaH3k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 12/69] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v9 12/69] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Index: AQHYX1Nh/LTdV4mXI0WB2ARQgN7clw==
Date:   Wed, 4 May 2022 01:07:53 +0000
Message-ID: <20220504010716.661115-14-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7515d7c8-2cec-4e84-1454-08da2d6a855c
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB421459896322F11A5FB09E40FDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ip+1tdmIs3tBhPSPTVL9IrA1xIrKXql/7srkRZL0s0VXiuIyMYajTh5xJvzo2KIb7EI9RNnIA1dNgnq93K5d7jK5hXIPa/BOUc9w4kwg8A2LgE+YaAenLhPU6I3uNS6fC9r8qga9gMi4jAV0XA1xoPcwt+GczRxNPs9i+GSRBoOIBl8EJ87w2wO+Y/WfDEL38wxYRztYeRAo/1QmHfJL0+xKcWDFXZoYFDo0Y+w13TMzFwtZgSuRQHSAp9IaocM1E2SoD9APZ8p9Op8uGWZ9ILwX0CIAo/62usQMG3RjCJycklhCLWGW7/1+nKwJizASCxCYH5jOv71AQp/uGZoeYGqm7K5k5ExQ8031YcbSYfqMYUMGtJKvOfCVkRG7oWcC2TI9WZn3Elz2CJxKqbBAQYrp4tXQaWccaaQpKT9g03qSvN/zV4nCruPrKmQ95VdZWCNR98DZ57Wv2RmGjdTurSBGGOTW4eSP3TeHM8pGe4FJOGFzbm23TaxEIDq8zOehbrbgSb8zmEMERuz2b4GJa4D44V+Vtqi6Pq+Q79aFAKFcP61YmcSOc1kSf6Zwyw2g4p0fqfbcVBtvUs8X5gNfJt5Orf3S36tn+7Nqt5zEZXOaB64OyxshFNXrxx9JhBj6pjFr7R7Yfa44iU5nAZdRhduXj+47E9gcYGKsbJmKcHhYYlMXK7ltORMsEZCiGu05tFfFCQVTuuXSpgoqnWDbpA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(36756003)(5660300002)(44832011)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qljiFkzKMU8JO0nxDjv5KE9L8cKdq6kpMAgCnbGTodHX28mnx3lTxoQVrb?=
 =?iso-8859-1?Q?8ODUrn96RJUroeMh8Tn6JZkCRK3tM3DBqpspS9uQ/z+KMaK5Rb8Fd7F6E7?=
 =?iso-8859-1?Q?PPBKpKa0blfhwJP95NCHC41JAZs3Mer8pdBLePZZKeYVjeAks3S8V8+oqL?=
 =?iso-8859-1?Q?J+HKMS56mzw2KZ+53mpeq3/k/8doVSlku0zsRGW1TEJCnb4pGtFnvcuncC?=
 =?iso-8859-1?Q?jNF9THa89m31/idlPSEqrPHRQX+G/UDtUAzIYDXxyEiY05BMBRwGqSxVHI?=
 =?iso-8859-1?Q?6x3DQLhMGvacnkyUsWQnOMKfE16o674i2LOOAFTteQSzFdzwULFU29jKar?=
 =?iso-8859-1?Q?NDTqpe43i3L76rtXRjG8gj9oCYb/SbNlgdOfTgEJtnCPMAhZ6SODYeLQsM?=
 =?iso-8859-1?Q?/FKXPtrXOHAe0qVeX8tLVyzABat5ymeMskqQQE1zizJDSdrGQA++yYCJSq?=
 =?iso-8859-1?Q?EZwCNZCaOXQoAjPd+dg5xp8532gbgE3Eg42Y4LWPvoTF1It/A0EjdNNXJx?=
 =?iso-8859-1?Q?loxXZ61CD/l06cZ2s7Gdd1BC96DpKufkmlpa8ygUZ7zcaJ1HSE+nlCoUQE?=
 =?iso-8859-1?Q?lcOupQewyXmDtErLwKYJCqRvyydf42epOcrZAwpOL4xpCAkOOEOmjvEGbE?=
 =?iso-8859-1?Q?wI7hbqlLsj6l3IizSsw4X2zkkh1wXhYFr4EaE+AFwL5GQGk+pfTDoAohR6?=
 =?iso-8859-1?Q?VetVPdAKrTyBocVpEJx4pGyuBKHjJT5YmWFyXZLQfhanAM27NP8YlCawCz?=
 =?iso-8859-1?Q?szGD6w+l35FH+nVxs8kFSuYUZt2wi+mRrvE13obYm6RaJQvJBuJsljdSDt?=
 =?iso-8859-1?Q?V0Z+BL/FTBOoTD0ETnqhh82w9Ls4r90I6fr1Qkf13FHjqsvWt6WLwcHh6C?=
 =?iso-8859-1?Q?A3/JOwd0RHY3WCzvPwySV5c0edHMnbf14c7MQAAE8htAByAl6mmJxiJYI9?=
 =?iso-8859-1?Q?UjWQcvQufeKrRgEJWbBTXdNtMh8aomeiDosZabQvcd/UVnXqOmK4Oax+31?=
 =?iso-8859-1?Q?tSmUg7NEUbSXIhAXlbFewJuoxRezSFAotyGcakafL/pgmd7UrQ1J5QorO2?=
 =?iso-8859-1?Q?og/+88pQKjpm1HrSOjJVt0va29DFFaNSiVLctGLY30r1l8SYfZewxNOW7Z?=
 =?iso-8859-1?Q?+FGN+XP994pivhTx6BNtplCxq44ZrcNb41pSVcwzSJeC4opDRkuN1UWwZE?=
 =?iso-8859-1?Q?YSUAwdvswrqxgD5FhD1V890kTKeK70l9DEvrqACL52tZP1CgJSDTptlexb?=
 =?iso-8859-1?Q?vcoOit7iUciExPspDiAUMcuOvWsvzXv3IvK+T6DnDzlRAlGOeE03b3cJOe?=
 =?iso-8859-1?Q?dPYStqEISp6XabBxQYLVBZlC+sonbM/lqzmwvSdOdqKBNVMWOuAYZTl9ro?=
 =?iso-8859-1?Q?AJd6y1XrDfXH6VG9Vf+MWMkCnfvoFZV3M6HSiar21lNYkhZfy7rVrxV9Gn?=
 =?iso-8859-1?Q?nrbkSjOMgyoGPNX7q3nJwu+wUBs+GxeRQ+pfVVdTMHUeJKSUl3n/l9fapk?=
 =?iso-8859-1?Q?oOPUj45X584IeDt/ROEgjKrHcHcdvkvNyoQldK9x2F7kz8dPEjXuoYsz4I?=
 =?iso-8859-1?Q?eP7o5IUgj0pxgW2kIyMaWVZ3SvZ+cLpXiT9Jljs70VT1G5r9oAbN5pTJil?=
 =?iso-8859-1?Q?9fKa12eFXQCAjjkyfm2SGkS+UnOeE1paUVkVUTFvF6uP+MaOceiatA8lKW?=
 =?iso-8859-1?Q?Y8ekSVeEbUo1ycZ9usoHgM3nhR0r6PKUwyre3/MhG2k90TI/PgcBd2QqzP?=
 =?iso-8859-1?Q?/vBgIMVcFzkNcK7jwMeS7ERlGR3pl4V61yfucBKi4mR/XwPQ/OoB2v5+cf?=
 =?iso-8859-1?Q?c0bDjemCj4gs0Z/ijFlSGtrvp1nq8dU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7515d7c8-2cec-4e84-1454-08da2d6a855c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:53.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uT0LEq32qW1rHcEZoxqXANgD1P3Y5yhVRgqfV/n75vEWcQIA09XHbOLkyhuNEgljtKhm5sG5/riSWd7YVs1Ypg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-ORIG-GUID: oP8_B7MkCzTDu6qOyH7sGP7ZIEqjpTEQ
X-Proofpoint-GUID: oP8_B7MkCzTDu6qOyH7sGP7ZIEqjpTEQ
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

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address of the next vma, then use the maple state to walk
back one entry to find the previous entry.

Add kernel documentation comments for this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index f582478c83b1..7ab07c67da71 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2489,23 +2489,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Note that RCU lock is missing here since the external mmap_lock() is us=
ed
+ * instead.
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.35.1
