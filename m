Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23294510165
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351968AbiDZPJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351888AbiDZPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF44136977
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT16x011396;
        Tue, 26 Apr 2022 15:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=i1pAOpsHGEBKNj5j0VNRq51NHqWkdyg38NshCQQAREg=;
 b=sSZQa3DDiTsJBVP5tAF/FzjfEbQ9m70UCDqr18cCBUn1+FkU6XRIxh3qXngX6oh0bKPG
 8cdTyPjcavzu8Rl4NxiXoujFBtQbjmUqcBMUlB4A3M0SaioONZUup8LfKb/0WFwUkkXJ
 nUy7BinEUxWqnxY5pS2rSXPk0RtG3uSGnRNqYKX0uq2+r33iAaqRAwCZrQy8Mxi9kJha
 Qp17csURxWzMACgNYMKbIXSxO+zPJCbs+Pgmm7vl0afzE/lBEcNs9G5Ho2H9AnJ3iJm1
 hVAVgkx6OpS+ms4QDXmzY5/AIkYKCiReAMXO2jnO89s4SDjpVgBkJu3U6y3D9maBM40Y mQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF63EZ012545;
        Tue, 26 Apr 2022 15:06:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gq7k-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzjAukJZODQtK1a69G/9TjVEmIsnuUy40jXUXGzAVOsMolHGxiTNbTDGlcHmyiEfCZz6YOxHe9aeFeQUVYiyZWGF04HF5RpTMXe8dvkR+jgbSq4qg2ttZ/iKP472alIT2Po0Rid24Zptq9LkXvILxh10BZbW36gIpbEbtWkdBVJGG17JwE+kdPZb699pRUQ4DFr3OKAixCVKys2Qaa92xoSWjVhYD58xDXhjq8vytu/D50adL5dHje2KrxWEqG7zWcwD9wAWQkgBrZ+ZWRhpNgoALqb6h3rsN/bSoPf3jRwKaUgPOZt4e509G3+Vfp+Jq0aZ435x0GDvwoVBt9giIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1pAOpsHGEBKNj5j0VNRq51NHqWkdyg38NshCQQAREg=;
 b=UXg/JyrWMt82SOPz/7E61LyoExJjIChICJ2LNOfc72JiskoxM9o6YHxFVyQrDZWVJQ0lFsGxvsMnoOuzKEr1o4GVIphcQHJjFYFWYo86LuFOpqHQhhHdIcDu1xYhlXX8JKkmE94PVko4kOQxNMPpwJIrkBDI9kjxkYVx2uAW6uOFZ0bc1JB7QTw0EapqqdOWsiQ5D5KtKN2BYo2BeVSG9k9MyaqWZn8eu9X4wjmRlQ6AQEL5O2YrbWUvynF4Eh4QV4y/m9YzPfJzgsnEliBCoMlLcNN3CQ7zDmHOSit3b5HwTvNmNT+lAks3c0UPzNhBR9OK99OxxPYizYZNhTfNUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1pAOpsHGEBKNj5j0VNRq51NHqWkdyg38NshCQQAREg=;
 b=kow6uYuToqwTl6vWUwS9013oZAKoEt/htopPVdi5eedueQpcSI60fN5/F6C/3VifHeO7FIRvB7DI7oBddaRmY02poCH2CNusJYNQ5TL3mleZVc3O7Q3sYhRHeFQlpC8vkS3SuUe1oLVH2fY3W1m9ljMr486nznCX36egbKqO1q8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:06:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 04/70] radix tree test suite: add support for slab bulk
 APIs
Thread-Topic: [PATCH v8 04/70] radix tree test suite: add support for slab
 bulk APIs
Thread-Index: AQHYWX8wX2HYRl6it0CUr4nXU/s+Cw==
Date:   Tue, 26 Apr 2022 15:06:21 +0000
Message-ID: <20220426150616.3937571-5-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09a444b5-9c3e-4443-3ca0-08da27965398
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB46594BFDD856C140A26C5384FDFB9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wqzVKDWf3662Fv22TemfgOaxpLuiX6hWKcah+LqEYgHwBX4b3Q3MNV1NU84LNqshvzTLLirZWSkhyfuKNVmeWREb68qzAMbG+2vIasQodCP+wdEu9J1AWd/v0uA9abx2WzlnccYHdCJxVGAZ90E+DQJ5A2C4JuVrxk79FfM1B1MBX1ftMADAUzZ/KL73uN+8gSBDEiyIsBu4vXOZs5B2IsCppe7UkeZKrDAOdXEEQeyunX2Q+fA+rUaO2ksqyv/eYeBJ1WOMemQcRDSw4uxsTZ7YsNcv039KGERrzunqTIeUNvMvkFYMFA0OEv9VFN4eo8NKAq/QoXYTscExRtlAc6rC4NyHfPMZdwSxACbR4FrZLd2+c/Z29cg7j5XF6NNs8KNcIanf8s7PlpTI6/G8bli2Sll2yJJD8k8ndTX4P8oy2aNzhURejX9SOBE6qH5WbOyysLYbQJrH2ETsUhaP8tjtElqfu+TEL2ZY84XG54u0zCax4XxM15aFJYQ2tOTMPXIoLEFsM7fZOLaPatI1XahpQCwBcqJyo3JjkkcGbgWbsHepIp6RzyYl2YjVQKOxVLO/YdML8KYLFlZ1mmkMYJFSl4Pbe4H1Ocr5eSVQlRq1zUUC+WYhL+CTw0aPEOLsBlSer7/XOmfSt1KLo9k1Mg5XdsSzjuDDf4j0xsQEsGjML66mgg71UatWBll7WDYaDQMK41zJrt9p/Xs890gr0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(66446008)(2906002)(76116006)(508600001)(122000001)(316002)(8676002)(71200400001)(5660300002)(110136005)(44832011)(8936002)(64756008)(86362001)(66476007)(66556008)(38070700005)(38100700002)(6486002)(1076003)(186003)(6512007)(36756003)(26005)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZGsjYmFPqLwDt4H1hJzB1etoMw91PJ4jySgCkWN5hNbPR3hNh3qVwyvCVx?=
 =?iso-8859-1?Q?eLuMjLi0J0Lic9uwmuslCnj8OE+QsVfe6u6nAcVTsS380xbWEuy1VX7q5t?=
 =?iso-8859-1?Q?nU2KSLs6zBvJWtYmrG5cLq7Hq2Y2+Bhgndzh/+Mh9ympvFRo5uGc/pk7yP?=
 =?iso-8859-1?Q?egCdyKN1nY340A8L3XJN8Yrzrtiwj+J2DL1mIB9aPf1MY1lUNu3U5klglz?=
 =?iso-8859-1?Q?iHjVNI/kj2T6AUYHoVGKIeHokTO3BUdWYZnDRBKB7X1EHCE6Xe7/moYIeI?=
 =?iso-8859-1?Q?ZtNoYpexLto5WKcSKfT+8dr4PCQT4lbwC4gg59+S9aWlbKhFwoyjSXXpwc?=
 =?iso-8859-1?Q?4An7+9o8zhIEFxC0kNIIQFjcNgHNybC9kEH4CX+gcMPimYXZ2Fva/PeTMD?=
 =?iso-8859-1?Q?8Ch5eHJBJNqkz2/t5yqyPtZ9ADFsldJDavJGNz4O8k48XIsV5zZRA+MD43?=
 =?iso-8859-1?Q?420ISgbgxH1IPuOZAbSDM292Xj7If3sJiYNS4AHV4qHx/j0V2RtFy0teF8?=
 =?iso-8859-1?Q?lpzHCOdwDjsrWtqMitOG9SkyL/29TT9xswoKakK83QnbRnh2uWPNDO25gj?=
 =?iso-8859-1?Q?RjRGl6sjPkiDDQ/Drmg55aPepZeNnaWYlO79lzwx32m9YeZmgyeMhKYy6k?=
 =?iso-8859-1?Q?YFQjE8UMYqU1phlGLeRMu5090AflvPBVS3KjpD/9UE9mdwB3SAg0u5S769?=
 =?iso-8859-1?Q?AU4xH6zy1MG9+DrPvlDWJAb+8whwdmZPCoi1I0IRBLabxnaw+WPkrppeoA?=
 =?iso-8859-1?Q?3PvjgnNqDRWPEwn2QYHhFd3r9HR76ksCZFMuT5jxGKySFzfSGyjgG/KEVT?=
 =?iso-8859-1?Q?dBwmcdhbMgqa2sLyuatWge0pEZ3PEXo/W5Q+bA5RGklO4bAUM84c9EuMLO?=
 =?iso-8859-1?Q?os2DYmBRxb8RiF/8Y2MYtaDHMlDwjG1Cj5xtbZtqKpPJMusdfZFK1aq5cE?=
 =?iso-8859-1?Q?vTTcUsd9q5220Gvs5mz1ZMAne+/ScNVd1OztFmMzdyju4cpqMiJCwkoaB8?=
 =?iso-8859-1?Q?gV3jLH+m2xPfYAEyylQ0C6hxPDZ023ZAAoTASE16rIDmzR65TzhylLiop5?=
 =?iso-8859-1?Q?8Tm2Vi3jOud3vm4hlcHtn2tL+rT5X0gSGgf/vfFMwt5jAv4o1gTOl9cK84?=
 =?iso-8859-1?Q?HvhgRJwvTCGPgeU+9jkvKrAHy1FJ8ASXhFpxm+9NczakfniBysNO8GrKw4?=
 =?iso-8859-1?Q?+9iSXqYklxVM4Yf9EFicwNv3pmTqFe9/BtN+n3ci7RsX4iAjD1RRc5Oy/x?=
 =?iso-8859-1?Q?atsiimgoF7ide3/50PX8Qt2CUw6NXDge5swLEr+BSkhe+F8MN7xqXrrYVR?=
 =?iso-8859-1?Q?zprtay7oyjf9Z8wJTfx+FsuH0eG/qYT6amdUjH0trTDi8C46m9Pd34E/3y?=
 =?iso-8859-1?Q?NWLXTei5ZLrCKe3CijebOx21+k8H0iOzZ2m8xAIkvKKEI7f752mlbPu2zM?=
 =?iso-8859-1?Q?64vUPD+XC0EO+AQnj2pm6ZfB0hjAzVC/5ZF+zyChLuHYb8a8qLDc/DntMG?=
 =?iso-8859-1?Q?QUXunpgMwsIJ8rY9TPpJF9sCXIRnz1NKKEiyQxZS5GCZEG4A2eRyOnlmMc?=
 =?iso-8859-1?Q?yFF4mp67r0IqTVnl+0bHeYbn2cTVEBjaJFWZWRrqv1EElwxawvZ5/7wrXn?=
 =?iso-8859-1?Q?jKktILrv/dHPy7qlTnm2C5j7zyjnYAuPCk8+aNXc0ANktlM6H2lEPDGJxG?=
 =?iso-8859-1?Q?dv8zj0tZVP2pj7GNsmiY4/ZyhYYYPswMIKJkWgpi6p9DN9zzIF3RCqUIS/?=
 =?iso-8859-1?Q?IXIk1rjIpY1wwRnPLMhw4Mdo3ujQHreOmasPvB1Yg4lo27+tnyzJ1SnfnO?=
 =?iso-8859-1?Q?dScmp89+m9M/o7nPiJrSEBUvj7OKGxA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09a444b5-9c3e-4443-3ca0-08da27965398
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:21.6160
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N9LuQBqqQXdr0MLFjCg0xyUGacICosnHPA02i1tI3LUjsgjfhDSKQoRS27VrVO3FlHjZKUZbjBAiN0anShhItA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: 0IaMsFNV5X-4O0S_AvTh3yDId7-2pcRk
X-Proofpoint-ORIG-GUID: 0IaMsFNV5X-4O0S_AvTh3yDId7-2pcRk
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to the
radix tree test suite.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/include/linux/slab.h       |   4 ++
 tools/testing/radix-tree/linux.c | 118 ++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index f41d8a0eb1a4..232218412573 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -35,4 +35,8 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
signed int size,
 			unsigned int align, unsigned int flags,
 			void (*ctor)(void *));
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist);
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **list);
+
 #endif		/* _TOOLS_SLAB_H */
diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index e64741ef89ef..75c416ef8618 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -92,14 +92,13 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int g=
fp)
 	return p;
 }
=20
-void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+void kmem_cache_free_locked(struct kmem_cache *cachep, void *objp)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
 	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
-	pthread_mutex_lock(&cachep->lock);
 	if (cachep->nr_objs > 10 || cachep->align) {
 		memset(objp, POISON_FREE, cachep->size);
 		free(objp);
@@ -109,9 +108,80 @@ void kmem_cache_free(struct kmem_cache *cachep, void *=
objp)
 		node->parent =3D cachep->objs;
 		cachep->objs =3D node;
 	}
+}
+
+void kmem_cache_free(struct kmem_cache *cachep, void *objp)
+{
+	pthread_mutex_lock(&cachep->lock);
+	kmem_cache_free_locked(cachep, objp);
 	pthread_mutex_unlock(&cachep->lock);
 }
=20
+void kmem_cache_free_bulk(struct kmem_cache *cachep, size_t size, void **l=
ist)
+{
+	if (kmalloc_verbose)
+		pr_debug("Bulk free %p[0-%lu]\n", list, size - 1);
+
+	pthread_mutex_lock(&cachep->lock);
+	for (int i =3D 0; i < size; i++)
+		kmem_cache_free_locked(cachep, list[i]);
+	pthread_mutex_unlock(&cachep->lock);
+}
+
+int kmem_cache_alloc_bulk(struct kmem_cache *cachep, gfp_t gfp, size_t siz=
e,
+			  void **p)
+{
+	size_t i;
+
+	if (kmalloc_verbose)
+		pr_debug("Bulk alloc %lu\n", size);
+
+	if (!(gfp & __GFP_DIRECT_RECLAIM)) {
+		if (cachep->non_kernel < size)
+			return 0;
+
+		cachep->non_kernel -=3D size;
+	}
+
+	pthread_mutex_lock(&cachep->lock);
+	if (cachep->nr_objs >=3D size) {
+		struct radix_tree_node *node;
+
+		for (i =3D 0; i < size; i++) {
+			node =3D cachep->objs;
+			cachep->nr_objs--;
+			cachep->objs =3D node->parent;
+			p[i] =3D node;
+			node->parent =3D NULL;
+		}
+		pthread_mutex_unlock(&cachep->lock);
+	} else {
+		pthread_mutex_unlock(&cachep->lock);
+		for (i =3D 0; i < size; i++) {
+			if (cachep->align) {
+				posix_memalign(&p[i], cachep->align,
+					       cachep->size * size);
+			} else {
+				p[i] =3D malloc(cachep->size * size);
+			}
+			if (cachep->ctor)
+				cachep->ctor(p[i]);
+			else if (gfp & __GFP_ZERO)
+				memset(p[i], 0, cachep->size);
+		}
+	}
+
+	for (i =3D 0; i < size; i++) {
+		uatomic_inc(&nr_allocated);
+		uatomic_inc(&cachep->nr_allocated);
+		uatomic_inc(&cachep->nr_tallocated);
+		if (kmalloc_verbose)
+			printf("Allocating %p from slab\n", p[i]);
+	}
+
+	return size;
+}
+
 struct kmem_cache *
 kmem_cache_create(const char *name, unsigned int size, unsigned int align,
 		unsigned int flags, void (*ctor)(void *))
@@ -129,3 +199,47 @@ kmem_cache_create(const char *name, unsigned int size,=
 unsigned int align,
 	ret->non_kernel =3D 0;
 	return ret;
 }
+
+/*
+ * Test the test infrastructure for kem_cache_alloc/free and bulk counterp=
arts.
+ */
+void test_kmem_cache_bulk(void)
+{
+	int i;
+	void *list[12];
+	static struct kmem_cache *test_cache, *test_cache2;
+
+	/*
+	 * Testing the bulk allocators without aligned kmem_cache to force the
+	 * bulk alloc/free to reuse
+	 */
+	test_cache =3D kmem_cache_create("test_cache", 256, 0, SLAB_PANIC, NULL);
+
+	for (i =3D 0; i < 5; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 5; i++)
+		kmem_cache_free(test_cache, list[i]);
+	assert(test_cache->nr_objs =3D=3D 5);
+
+	kmem_cache_alloc_bulk(test_cache, __GFP_DIRECT_RECLAIM, 5, list);
+	kmem_cache_free_bulk(test_cache, 5, list);
+
+	for (i =3D 0; i < 12 ; i++)
+		list[i] =3D kmem_cache_alloc(test_cache, __GFP_DIRECT_RECLAIM);
+
+	for (i =3D 0; i < 12; i++)
+		kmem_cache_free(test_cache, list[i]);
+
+	/* The last free will not be kept around */
+	assert(test_cache->nr_objs =3D=3D 11);
+
+	/* Aligned caches will immediately free */
+	test_cache2 =3D kmem_cache_create("test_cache2", 128, 128, SLAB_PANIC, NU=
LL);
+
+	kmem_cache_alloc_bulk(test_cache2, __GFP_DIRECT_RECLAIM, 10, list);
+	kmem_cache_free_bulk(test_cache2, 10, list);
+	assert(!test_cache2->nr_objs);
+
+
+}
--=20
2.35.1
