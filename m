Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBAB7510191
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352315AbiDZPOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351901AbiDZPJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B135313A2D3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:34 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSt9c032133;
        Tue, 26 Apr 2022 15:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=EmGVFcBu7ZvzrfK5VcFH5+ahIZTHegUM8kiQwZ7fyzU=;
 b=OmV0XXkrRftlwgJN2G/z+c09o3JpuX7vaDixEjpCBxHe0byJ+jZlZppG4DXCXBhLhZX9
 l6raGFmn/slgyRuLi6QCpHc2cqGZfPVbhcRdwRzSb145vvem6/ybFbLuXSmpy/4ba5EB
 O3Pr9YlZTOIIY3q9TiUe6UKFZS5ramd599snSrkPyt13BxKDNOw4LNZEQM0w61MwfMwG
 4ChrLcG9w9OgafSJgkA4pZlIuwDYwNov3pmfgpkp7aZqAl52bgDahgkbmwgXV6axTw5M
 EmmACHkYdWGD7YqESYbIrT8SLKQO9GR8XH036hYiN4WRhCCnjIaRCnfxjuL1R7Z3fI00 Wg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb0yx4xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF63EX012545;
        Tue, 26 Apr 2022 15:06:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gq7k-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SB+zo08OtEfPIm/m1CpZryXIzSCHeRXkYDsG2aZUPc9a+lua+T23HO6r1r3Mi89nxSW3kdQsxzefh4hN8Ma/BjHn5l34hphFj+jBpqYj3meXx2ZhvFY5JSKv6nhqMAHl35Sh5azCDogO4beGjqtsiP9o2tht/F0QtA6zUGIyA6CXLoHULjDt6u0orgN6ItVwVu8+cZnTPbAWnlRiPWuownXzxyvo0YEiv/pHz0G+eOGaZpOM2bTEaD//wzC45i6r+QpyPlvFw3jO3m8OgYxV96z0bhgVJf92k3lQrAfxiTro8dSbtsbCcnlg7XGK8SPci9kYIASgBB/j/vxNEq4h7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmGVFcBu7ZvzrfK5VcFH5+ahIZTHegUM8kiQwZ7fyzU=;
 b=IqfcogsBHZdGGKbQF7pO9+6QkyBewAskZKMwhB0XmrQfQbfF1GH7IAf0In4vYbrj6hy2WrL7xZedWdxhZuBFKEZX4n/ZZgvbAaN83gf3BQv/Jg0E+IzodC14XYUWoWlWc9UIjd0bCcYtnyM3PajdLR1mvivHLw5rKVfWwYkBpSwjaZFJmUprxILuCP2FYBt+NQVPX5it7jzKQ1ZbmcnVya5C0RtDxiiYIT6Z/MZsiektbo6ss0VyFzx52vD5LJQPuv4l31bbilP8AvsP1t/mJ1PHiaIxXWUVHzvDXvohEEsE0fmcamqT5Y0xOukychwEhe1iVIdEYKHaNbbxLovTKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmGVFcBu7ZvzrfK5VcFH5+ahIZTHegUM8kiQwZ7fyzU=;
 b=ROa+/OhhJs/NLbGNGqGKqGX62RxHlXCCUIVjfdu1oHmfrE0PqlRDxpIBc9GfMGeKT7B63GCinnSDMGBD3/LYXfHfAxiKKOs4M0xEddVNyU0NUySfaT0nrnEyXe+NK2OEAp7GqNGO0IIxNOj+ioCLXZAZEke0sk2dRL6r/jZj8m0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:06:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 02/70] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v8 02/70] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYWX8vkuiIbTeal0C0zwmjGj8HiQ==
Date:   Tue, 26 Apr 2022 15:06:20 +0000
Message-ID: <20220426150616.3937571-3-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9c161e5b-656c-40bb-5af7-08da279652f1
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB46596F05D0AE8258AB2B9C51FDFB9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g676Q7oFBWOqEtUFuisXBwHwg0hR5hwxCGFBA2KRCElq5+rH1FQWZUptHn8RIQ5Hf6JLhir27sccYe00UMyS8XvLdnTthqDTQXzH2IwbzV3ks+t2VnpleRruyjit3QoIqTTJYdEbiFpBhiBEqEoNv2GwA/paokGJsvmSb6BSs/gaP1+yQayCM/H/86LuhCwXUG7Kcjadi76sIVo+liYxkyOHdvFw3A6sCPmT03rNrmko3hlRe4qT90ak64Fpx4vPoHCrs0Y7hHoOTn9ne6JYQdH6jK0pXHp1CnUNF1dSAQWsB3sF/eOygPwkeQL/AepCyklTBYKVjjzbwzZQ4TPlg6ZDmkYnWmkb3NVMQJirjMsjJwvrbsMvwj40gvZu1ppqH6QUaEsJqRemmr1zz6WKN3rZziGaP1iBUNVLpgQORtCTM5j3j5tRD2QFDZkuDHNFcSOYoUuV2IZG49L4LAzMEYbl5UHu9LBNbU6R92++Mf10Yan0ix5mlrZ1pMkSGNXGQC1ts1LsmcNtoTbCBEZCFjf7MdJW5WAscKiI5WOoI5e97IMhvP3ZQlifbFjbGVtLbctIdbAlPnRjAUS6uEbdK2WA90guhAtjlV1nXE/6PZDhABasToaBalEUeJ/D2zLDi7MA1BOCNi6OJDW4ayfJiwGQkpeq5QUNDaJEaqfj110PC8TB4zeG4UG7MAo9Dmqw6MStqXTTEBC4lgRBQWcYEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(66446008)(2906002)(76116006)(508600001)(122000001)(316002)(8676002)(71200400001)(5660300002)(110136005)(44832011)(8936002)(64756008)(86362001)(66476007)(66556008)(38070700005)(38100700002)(6486002)(1076003)(186003)(6512007)(36756003)(26005)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?g91ZnKZ+8jb2eb1rns6zhrVkBVOHKaQ8HnHrmSAAGJ5IIOgWaT1BOp53By?=
 =?iso-8859-1?Q?IEFkIH7vXH0XvdYO8HZImFc3oaaF0M8sxoBZRNUXIiwLWSdMU2ZcD3FGgl?=
 =?iso-8859-1?Q?JBbNuc5Z28RFCPqDhAhnlVwCP8bQ90z8hsVq5L0CxHaKRZXwX0pntaCxtL?=
 =?iso-8859-1?Q?7vcTYPbP9ZZrNBhR7hvZdrB2KezldQbtQCAS4Ej0PMlzTKt3f9DvH4iWXs?=
 =?iso-8859-1?Q?XN5KonNBd+tX5cQKZkmSvLDIyHmX63TOFUZmUY+68DqFV8EHxa8sldO1Xb?=
 =?iso-8859-1?Q?KtRNBy3oisFGWr0xNmOlKTieui++JzUn8ibGGG0f01No8DISlRZ/3K5hGf?=
 =?iso-8859-1?Q?SrVZ5F7CRTv9Ctx5z8y8xsjFhfsJUjvYL8zsACrT03QkujXtdsm4yCYur5?=
 =?iso-8859-1?Q?xdu9Xce19rkdmd2WnZHBfCNlf/qWjo0n/fjDYc3EkdMoc3rKlCzgLN8vsC?=
 =?iso-8859-1?Q?mC5/eh++4tVqFMOOSN+vBbu+k2B2P7SnFT+lq+vqEtCpwk1ClEMB7cZdVs?=
 =?iso-8859-1?Q?P4fhk/irdStrx/HHnFm83owzsz8iiQBSv9qVNdajWXuwE9HBcjkkVyNOMV?=
 =?iso-8859-1?Q?njCNi4+5tImKelbyQOfD4ieo0vjtPH/taPgfyPYmXbQtUVeRVTYDgdaoFP?=
 =?iso-8859-1?Q?LvhW0HodVh0mTxjTBZz0N1hQ8tJedNNJUqNb5VGgoNiXJTGx2e09OYD+6p?=
 =?iso-8859-1?Q?QX0nIrkuCG3Moyr32ED88K+BGRgBPauIRJ0DymYyDpnkbbeD9wsYwqKEkw?=
 =?iso-8859-1?Q?GXk4CO68dLGwCbVEWdzQUJdfQjTrJ8WC1cfnEQgT36HQDjNoJodtWdTb5s?=
 =?iso-8859-1?Q?HC5rYHQLdoFP0deI5Pb20FQRSh21zxWha5J0ZbT6IhwSDarWieKefrpXiq?=
 =?iso-8859-1?Q?4kSdAURvK+EAIHq65KBvnN99w2lGdH8ZhLWWk9sibMNk1cjNIBbMGIQPZf?=
 =?iso-8859-1?Q?6FyLrW/bEQM3u8pcf3nth0zbBMnAfIITrOaoAvxE/tjYps40p1FNgLGQjF?=
 =?iso-8859-1?Q?Vt1YuJwTmZVKBstaHJaWW9hCKtJKZHZt7VxudDIEDcsLjb0cKhj4QMdLOr?=
 =?iso-8859-1?Q?GOP8RaE1qL8+NBr6nLxM5rkWtCSPgcDHuMGOhD7rMkTCAay2IZH8psnteH?=
 =?iso-8859-1?Q?agF3IuSxG6Gb+ym+LExGnbNxQEyR6nkTV+U0HNvSihHlB+AsCqq86h/PXG?=
 =?iso-8859-1?Q?69lFDI7xRgWI+hAE+KymX+kNLTd88+QYYoKQEO38aFlOwF+fhSEtbSTqL6?=
 =?iso-8859-1?Q?8aodVyVsILgQ7geQWaZOWNsh90pERN0V82CXeffAxu7IXAu4QIfqnTEHOf?=
 =?iso-8859-1?Q?OJgh54kRzccc/o9Ew3XKLOIqey6+5sWXBoXZqfXNZ5wrso6JvQDzjpM+Sb?=
 =?iso-8859-1?Q?rKXTSoYjkWjDB14fVkJ1ctOms1ZIgqBGNXW4Fvsi83g4f62ypfKhEAuGyf?=
 =?iso-8859-1?Q?2g9Y5Q3dPcakruSEQJix846Tv+U8n3cuIgK3xjbezLMpvvkKhGma0cSBRy?=
 =?iso-8859-1?Q?BiMN0YkSz4J14wJascPsqYNTZazrNkiq8NfIxNNnjX05YbLYOuG7xDYOhj?=
 =?iso-8859-1?Q?fqjfkWDp8mGeFdQk4xnS/F3MZ4tR5TcTdi9V0hBRbsfddu0YPByZa8J+7o?=
 =?iso-8859-1?Q?WbJ+vatbYVHB3MxIAOhD3tsXfRiF2MSLKT0jSoQlkjfEuqDciV2xYnp895?=
 =?iso-8859-1?Q?eMRjJnOP0xdHblk8dV9NY4SzynsXywmYCrx6xvkFVYjcfSvorfdZmMaazf?=
 =?iso-8859-1?Q?x5BZmiWcC6TDBho/YvOjqlKlV/HJ4a1/cfCLb+AH7WZC3JTNMF6JXMhVeJ?=
 =?iso-8859-1?Q?46tFGqInd7nU3/xtMqxrcni62t79hZo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c161e5b-656c-40bb-5af7-08da279652f1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:20.6786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hYYC/wkTKFru0flzSoad9OYA4F9JtaXzfP6QqA2vYZvbaIYSMUBZUCGVpBDMVt7v9SnfHGFQllPOdu4IM4auLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: hC_qNfto5j_j-VzZcje0Uz7KNrNGDWOt
X-Proofpoint-GUID: hC_qNfto5j_j-VzZcje0Uz7KNrNGDWOt
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 tools/testing/radix-tree/linux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 81539f543954..586fef78dbf7 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -23,14 +23,24 @@ struct kmem_cache {
 	int nr_objs;
 	void *objs;
 	void (*ctor)(void *);
+	unsigned int non_kernel;
 };
=20
+void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
+{
+	cachep->non_kernel =3D val;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
=20
-	if (!(gfp & __GFP_DIRECT_RECLAIM))
-		return NULL;
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (!cachep->non_kernel)
+			return NULL;
+
+		cachep->non_kernel--;
+	}
=20
 	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs) {
@@ -89,5 +99,6 @@ kmem_cache_create(const char *name, unsigned int size, un=
signed int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.35.1
