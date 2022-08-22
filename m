Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9F59C243
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbiHVPJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbiHVPJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:09:15 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29B53E76F
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:07:13 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpjjZ016581;
        Mon, 22 Aug 2022 15:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=wOg6SPmi3tJQLAN8yRYpPx0KA5qa/8+RSSNjYW0KfaZvCCtkMUvPmYO7u63ZVvnVGIU9
 BSlmqO7OyKuIAl5G2mlDNSiYJA49YMW9WRpAbpRVtA698vnfXWMmNTgg/e69c0uJ5bHx
 Xpsmm1EqoP9rYD3oFt1Yb75p/vlSYfB3LhQb+XZvBk25eEIYjoOHXWVBhW2yHtE+k/s3
 fLwhp067FcWfo0jdcIB1/0XBBxCDGOfmbNQXf+3G7e4cPYK02Z2xtQ/ZCJWPUAJBEFaJ
 QulRCguZDmsQnnI1LnpWBGt9nNtjIwv1g8OANoAKiqHeESk6OeIUC0fVtgSgQ1ZMbc4n Mg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NM5031836;
        Mon, 22 Aug 2022 15:06:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd395m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnUJIpv9WgaHPdZiDKMR0z/MKn/lfsJBHg42oqvS0qydzY5Xl6r6HiTIm5y32lgqOOCWcFR/4/gVSKr7vnGbVjVBO1uuj9fF0B0IcZKOuJEfKfNhY+GUsmkWJxlROrW9aWY6BZ+g52MHzqX12BLmGuhOCkZO5S86jDkJMqSm7KSG4k5wgMoCFjHR8NS+X8Vlni36sESNecf2LGEenXbEGalcqYDca2+u2IWz/VynBe4GVrxwyy2gA9hK2rtCRy3PmEPF5/E6cP99Ryn6ysTdSQBHaufth4jZ5RVc21P+28z1hOJSGuyIvDyrDI6U0Q6yLkzwPNq5Qunj9lk4VKj2bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=fcsqq7jwczc9G/VM6vbqYqMAB4yWbTEiGA/yalSdQ7CMNpfTMjVr7IsSwjzzX4/8hkaFVQmBiDHi7n9qSna7ZH9KoPLt9tV4z+ztGrVAQ5+PTtVBuodoFVhU9ZSnLtyI4fXJEP+EOpUbLfesatKz7ftIcQ11DKzVPKE5qPKAKI8YwPNA5kJv9KvnLUObL/lHF7JTfvCG+GY+tPTB+Dje703MJxdu6hRiQ4PRHEg0jDa6fLfRlUoQ13vOU4niss7efAJjBlAekuZTRLstV790EoRsoOssXe79f5dI+eRWdiUBWUR1x08cEzY1WIhgJpyNOxLiOFHI8zM2mojEaExzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBmcZnH4ddodl4CLWLUj3ANEEvr09zCjKUnm/mm9Cpg=;
 b=Ce6PSYiEcC5KfzSWtB0Gi1dLeNof2X3B0Wdt/E1VXizgPodsgN2xU3Cnx+2Pw4hjX5KguE7tnd0sT3KnhzVldCd4HLLotiWcOUbkvQnHf+llZKGB6vnqIlN5e5yJT6ZGPQvxBZisviPLvXbbzDxKSXZfaxCoirq/fA7oWWT3vxY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:06:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 37/70] cxl: remove vma linked list walk
Thread-Topic: [PATCH v13 37/70] cxl: remove vma linked list walk
Thread-Index: AQHYtji+tE3F7x6wx0OyjzqPsYqxeg==
Date:   Mon, 22 Aug 2022 15:06:24 +0000
Message-ID: <20220822150128.1562046-38-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e8f2df2-c93d-4649-6f91-08da844fe155
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ToTN82Ow2mNA5LN43Fw6kMqfw83qRvgsT6/qZr2q1JjqvavkQIaZpv5fLNxfjl5vv+4fbXkCpzx9p2jfui8sny9Evbb1kcSXbm2cPQs97maCES4II4GYhk9TZVRabkH3h2e7Va3KHJaXIzPoTm9dsJhB29hlKgbK/cfB/uBXdu9oQv7+Pqz8KVVgCln21P+kR1fSRpKcZoJ7RJZTRFYeoeDt6rkTv/sQat6eclgVmZwkpQx0humvzw8sKIYd1Iv2kcmpqwMCN1DBPlYXi2q/YPDVupxyztZRRcgcAH52mr6EbobmJ9P8Gy+a4GdFN1hC5LWw88v4NJJ4wAH4oxr2aTeawW7uOTFfLKySyUc9S29HYaHMqqauQAbdE9o8jFmRWjqi+YwKmV9N31FddtTC+FM8pffA6phHzOtxPviLgIwP0QlhuE+AqIRdfqHdsv9zwtlUovZrGH5Pst8yv9KujwWbAb/+jxFVuXUuslDGqyp3MUijbskI/B965FlfKu5D5SeUezm8Z9zmsRhWHKj5AVvV/hy0giu0na7/mQQZQOPr6S6X4vYLRfsR/nFIjbME+ceoFnRSai1ZPouiahdZjZdosNIhHMZImbQ9JPIoMHHf4njOahnbgLjlWkeX7fJA9JY7XGCtUy13XROEldRKIa3Yuzw+l0JNKR0Vu4Nw4UAACAwLStwItUNe3EPADlVOs171QWQTlj+BJ6U5LeuvT9y70wADb7fr1MR0/xC/4tTWSapEbD1dFJi1oJM8N8q3+I2jZwFbCr7m2jLdYn6I+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(54906003)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lV3AaXzYZECg2AmD1fjpi4WHnaEe2lV4GreLdhUj4HgvaA8qWS1ITqIl1e?=
 =?iso-8859-1?Q?RFLQyTYwwTxHBY+HkQZHp9/+1HFqJOjnBkA48D/hGZDkL63GbDdespXxjF?=
 =?iso-8859-1?Q?X5gkHcDy3FcYaMFkdC4IWg+6+3XB7GK3qTcV7PE446TiZY4nwtDNp1grUs?=
 =?iso-8859-1?Q?AQl9rcbbfEs3WzQRkNBr8vr9/CfocPUlVjTebldedlZRzrhMZsjt0FaZA3?=
 =?iso-8859-1?Q?XWnuYr5u05sba3H21ev1HK62wj7AUL54O2u37dX/z8TmfnHeVyOdtnjjqO?=
 =?iso-8859-1?Q?qEh+gN/b2eJlK5a1ilmmPHt0zn77Ap4F6uQo2Rumkj03GfauXzEEECCbCv?=
 =?iso-8859-1?Q?PjatT2TjbLjNyrTaE01OkDG6OKHYg8MWgQszVDOg0dnEJOCK6ggonmBEGw?=
 =?iso-8859-1?Q?sv3xrr+GIjZqvqpqbP/QGE1+kte+Rc+ZjQccqswCL2PObocg987wmK/HnH?=
 =?iso-8859-1?Q?y1iZY0V16f9nJZ4F67JN1GGAKs4lFMitjS38FQKh3f9IkzsUO9yLmtyqGP?=
 =?iso-8859-1?Q?jMkvtlL484vkaRrR47QG1WHh7XZWlpPXaLTG7m6A9Yw4//MIyTgo7UsZll?=
 =?iso-8859-1?Q?LY8CjZW75EpgAmjPxkEQNDdZxVNHgSJ0Oj2/lIpuuAthsb2Vuc5QHmBZ7C?=
 =?iso-8859-1?Q?jkixLRy2sAQpH45X8DiL2fkmvactyKJh0IqWoLuIPECvd6bPL1Nt/xIFno?=
 =?iso-8859-1?Q?cm8/AywltniRvTeKFcFeOm3OJ34qWdHX6aMDQaJNXmB6ayDbYZvXHezCVy?=
 =?iso-8859-1?Q?r/H7Wi4GQTc1x5MUt9szPJyOqLiYdFFuulu7TDz9ji6yuGmBUNYXelQlLb?=
 =?iso-8859-1?Q?OisamGpoDz8ru6rh/KGF4ItvG8WwRr+6WSr2tO6IqX7j9VJA1BRB2i6k6c?=
 =?iso-8859-1?Q?7GaBKWEhGrwoJSuRsvvPhLJemVzdT7jgsoImiqccRd+TnpPzdDNVG4Mkt3?=
 =?iso-8859-1?Q?kvtvrmQXuXiUy9Jsl8cz89jMgIWHN53EB1xmAjPIipgtWzR6SpE4Zvm+4b?=
 =?iso-8859-1?Q?Vn6Nk9UJc3AOXtXWiozEO5Kr5gPzjPURINTkurmIr8EO1+wI021G20YVOT?=
 =?iso-8859-1?Q?AWBr79/hwUOJiFfBDMx52+5k7A/3vYOCiVdU3ezlSyO+zAVGE5aqR+fEaC?=
 =?iso-8859-1?Q?/wmbfQo8VCHlFlo705pBIpAFjDu7qSeJeBMrqbgY1HaZ4cHbmh2zpdQMNr?=
 =?iso-8859-1?Q?qSjanJmLt7aLbQQeCdx/aPInbTTQ/YobiPry+ArcvjLdFF4mpaTqD124+F?=
 =?iso-8859-1?Q?+ScJi3U3EMoBhqjaaOTOmmwi5McMdPqrW0joLwTa1dD8IONlv9tHMds9YH?=
 =?iso-8859-1?Q?0Z1IpmFXtXIxD9/c5S98UA5PGywWqRUGd573xGFh3p8iVNMRKPnQA+kq/8?=
 =?iso-8859-1?Q?GQbUfrLTETxmH3H5AL6rumGx0WUrdvPCTtK1MssEEHR2GwbYcrlgN9kw4+?=
 =?iso-8859-1?Q?sgHkTsxR6LbSf2msMv2pWF1lrTnNrRuCpPSOq3dSW3c3ZT0mm8+skAaJEt?=
 =?iso-8859-1?Q?ZyTjKla3yrfPN5zmqlg2r4Q7HnnLTuqduXOjcNR+GuXREp7ai8/ZC17ZQe?=
 =?iso-8859-1?Q?veqLQXbIHroDm6f9/kNGzNs24iVgLVTxlR3HZMqWRrnS/2L/HOT0+lENlD?=
 =?iso-8859-1?Q?ZIPmdOS3FBi1tQ2ppp1GMUfQLYRiJk50P6DZXVyM5rWRj91cQHrDYElg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8f2df2-c93d-4649-6f91-08da844fe155
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:24.3633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hTSLmAzFocztS3Y28Kze0JjLXSkxhOdEhz48mYp4+DPl6ftvRFfNF0jvg6U/qQD5w+ZPYZT4kgdyLr2Q9fqPAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: GxGgmK3yNUfa3V3nBq88oz3ZDSX8Ao1S
X-Proofpoint-GUID: GxGgmK3yNUfa3V3nBq88oz3ZDSX8Ao1S
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

Use the VMA iterator instead.  This requires a little restructuring of the
surrounding code to hoist the mm to the caller.  That turns
cxl_prefault_one() into a trivial function, so call cxl_fault_segment()
directly.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/misc/cxl/fault.c | 45 ++++++++++++++--------------------------
 1 file changed, 15 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/cxl/fault.c b/drivers/misc/cxl/fault.c
index 60c829113299..2c64f55cf01f 100644
--- a/drivers/misc/cxl/fault.c
+++ b/drivers/misc/cxl/fault.c
@@ -280,22 +280,6 @@ void cxl_handle_fault(struct work_struct *fault_work)
 		mmput(mm);
 }
=20
-static void cxl_prefault_one(struct cxl_context *ctx, u64 ea)
-{
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_one unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
-
-	cxl_fault_segment(ctx, mm, ea);
-
-	mmput(mm);
-}
-
 static u64 next_segment(u64 ea, u64 vsid)
 {
 	if (vsid & SLB_VSID_B_1T)
@@ -306,23 +290,16 @@ static u64 next_segment(u64 ea, u64 vsid)
 	return ea + 1;
 }
=20
-static void cxl_prefault_vma(struct cxl_context *ctx)
+static void cxl_prefault_vma(struct cxl_context *ctx, struct mm_struct *mm=
)
 {
 	u64 ea, last_esid =3D 0;
 	struct copro_slb slb;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int rc;
-	struct mm_struct *mm;
-
-	mm =3D get_mem_context(ctx);
-	if (mm =3D=3D NULL) {
-		pr_devel("cxl_prefault_vm unable to get mm %i\n",
-			 pid_nr(ctx->pid));
-		return;
-	}
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		for (ea =3D vma->vm_start; ea < vma->vm_end;
 				ea =3D next_segment(ea, slb.vsid)) {
 			rc =3D copro_calculate_slb(mm, ea, &slb);
@@ -337,20 +314,28 @@ static void cxl_prefault_vma(struct cxl_context *ctx)
 		}
 	}
 	mmap_read_unlock(mm);
-
-	mmput(mm);
 }
=20
 void cxl_prefault(struct cxl_context *ctx, u64 wed)
 {
+	struct mm_struct *mm =3D get_mem_context(ctx);
+
+	if (mm =3D=3D NULL) {
+		pr_devel("cxl_prefault unable to get mm %i\n",
+			 pid_nr(ctx->pid));
+		return;
+	}
+
 	switch (ctx->afu->prefault_mode) {
 	case CXL_PREFAULT_WED:
-		cxl_prefault_one(ctx, wed);
+		cxl_fault_segment(ctx, mm, wed);
 		break;
 	case CXL_PREFAULT_ALL:
-		cxl_prefault_vma(ctx);
+		cxl_prefault_vma(ctx, mm);
 		break;
 	default:
 		break;
 	}
+
+	mmput(mm);
 }
--=20
2.35.1
