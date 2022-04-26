Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D99510159
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352065AbiDZPKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351892AbiDZPJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C821613847C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:33 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSxp0011286;
        Tue, 26 Apr 2022 15:06:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=o+ByL0PJy7zTSGcKiUKWOkMA3pUyB2rYRjRNo8Ut6Lw=;
 b=U8zdbdkLe80/8emPDmXx0Mp5kl4x9N7c07nCRPiqmZ4ETW3CjuT3EywV1NtxrLXGzBX9
 d0YQbIShW0uzUkdpuTfdF7yaqFTNA1u5YlhekEQAY2Iln9veWOAoziSJ1bP51hIgdnoF
 izYTUWVTrGSotu9ZvNTy8+lCBkphwnWJQR+fkdXpTHcbJZOqwEP/nATvFgX8ZYrEObYB
 a/YX/N+i3hfbcKjEKF2VKiot9lf5ZBzryWxtPZxmmo+6qZTo3n9McdfHiST5sUnB6EvB
 NDZC+Aq41w9yJYi/IU8KrBofOfJyPKs/8vjYCxqXY3NvLzQ+nOspK5XfCHIeG5AyqMxf /w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF63EY012545;
        Tue, 26 Apr 2022 15:06:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gq7k-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ck3CNEvMvAHwSkCFrgEq32scZz+sYWd44AcWFo0IQzvwSn0eBtYly8MpVZuKZ7PZxRaptGVwwBn6CDYCzuFV+rQ05rF6dz64vbPT5LfipVMWJTfJ6lyrbcAB4hcqOi574dDch6m9QGUzFNOHzejkX7ajvyucuD0Zf2H8fBgdZZAxRuJW8J5k/ovk/YqLO3p/+3w2MupgREas7gQbdL5z2sd+kgnHPFlJuLWzjN4i3q7lzfy502g1iThpxFb67BBgef+WpDAhZI55HvMLVLVt5vnBgZTfRcb1VstG4o9yx0rqRB/txaHYccfyyvXXZsIQOJWrKRby7RMt51rUDukhpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+ByL0PJy7zTSGcKiUKWOkMA3pUyB2rYRjRNo8Ut6Lw=;
 b=Ra8v7FtvgfaCh1Ymb3RthQYfRgnC0QGGh2urxxxWIJRnSnpupgnFk+kQZ92FAMmxd9ZAe6gJmfLjU1QHr4x335CAfmoI0EYJx3dIjs/fXEcCRlRpjahbZA9bCzIvkH1RjrH0vggHk1f/l1ojPsIhNG/iQlHvRpf9kEgrLF3xsvbiUHl3gibD84YIimYlVVfMsWKRtIC9Hqsc36vwlTfxZmInn+iYSViE8qXRbxrDagJRPWnt5WaDZICsiXDTWMQ9r9IcyH8i5mAclMY0pejbc92QvRaqmvC4y0+kdXGyo5Ub6Uh7/NNVIJo+3lf2L7zDo0yDTuhhUuEX1eOj7U30Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+ByL0PJy7zTSGcKiUKWOkMA3pUyB2rYRjRNo8Ut6Lw=;
 b=cvWRu3nqcRNRf8FW6X1OEoLhPLEvrpVN6+8lppCHFre9VICUebkfVQbAT6VcPlTCApvjnO5uy+byse1W5ePuIrWfTNRH+chJqk+1BQuxYv2/0u1y4/hlvS42JTUWWF3WHguXzNJnNxXteWdOiUvFxopZFx91VQdggcTQuFFHyHU=
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
Subject: [PATCH v8 03/70] radix tree test suite: add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v8 03/70] radix tree test suite: add allocation counts
 and size to kmem_cache
Thread-Index: AQHYWX8wcsFfSgmkz0Ssu3mH9lix2Q==
Date:   Tue, 26 Apr 2022 15:06:21 +0000
Message-ID: <20220426150616.3937571-4-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfe19615-0e52-46df-6976-08da27965342
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB465942C0F17F7756D416D13DFDFB9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4QzhLiBScMZ5va55fBJKc/140rlGQSajk+/f1xdkSRpWtQHeGFKxjnoswuFvX+rIs0KJepbGh8xpQjKFGH/UCDHUeT/rpQ4wZiOIJOiJAxDnq0eoAECxQ+NdR0Y2VTqWr8TsxGxDBL5zHgvomegBB6z0fbSnSSQMe3+KMvCkzfbQC0rSqxt/RIt5EUwcvn1wm+O9PHejjjVQduSyuzgt9QGu/ipCOCLKsxVpvuhd3xqnWyHiSt9vY0K5SgsFillXeraUrk1MV3clRdWBXFVGRifeDzVAf1/c1+7Pzw5Npk/ayr23a8UUMwoyEmH3iFv9/p68Fh58FZcakygd1lVixN4ZIQApBkNAx72S4GsRQMYSjfU8WC5hs0FiMI/sA041ybUvJGvnjY98Af+XN1cRR8y4E9GA/kJi0IJ/mnFwVJtCgIf921WSVgCS5xz/VFgLBohxjrlJfeD+/dWZ+9TB/62DWN77Y62zYkINagiBZpaQdHMzQOQYnRXbm+gIajnOqHwxUzMHnvzjVLELr8RGgmJrX7yuvw9UgeUv/oyiff1xMBaU74Pm17E2suD5U8718xOwcTydn3Wjw2OROFCltg/d2qsqnRDp3NS/H7SdtqWhIb2kMm0bICsi11nQ2UGGgMwRFNLtpNrIU0KOdqLDdQZtyvePxmX45ERJkzKuI96hwoWNdy3p4MTQa+A/m7szWWoIbC0Xsu5zmFn/qb10Pw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(66446008)(2906002)(76116006)(508600001)(122000001)(316002)(8676002)(71200400001)(5660300002)(110136005)(44832011)(8936002)(64756008)(86362001)(66476007)(66556008)(38070700005)(38100700002)(6486002)(1076003)(186003)(6512007)(36756003)(26005)(83380400001)(2616005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ar8C/rPZYGmCFkV3yOdlXlhsbF/9eccW7BN8DBeioR5TTOcZbzGfrvbu9m?=
 =?iso-8859-1?Q?5hfIK5iImswdNGVmif1gqnI7qP2AlAtb6sgirfJu+hPM4aU1G8h+06AyeT?=
 =?iso-8859-1?Q?3cwCf2k21jdiXeaYrNgFXybc0olyYkKwx6CaN6CkYtI45UsTsgH19MLIW+?=
 =?iso-8859-1?Q?X6UOxmKDPx6G1o7k3wGqAJt/JLEdeLJ9EKj1UhXx0wC6fxPJh9RHXqtKX0?=
 =?iso-8859-1?Q?FIBpIWB+2lPb9TldgaayRJ/yGwfPIR/6Se9tulnu+dnnv2BmWajbIVoGcA?=
 =?iso-8859-1?Q?7z87jHYPz00W6lXtoY/fe59f8I327qhhzG2U3QxBXlintCVpXdBQwfnSMq?=
 =?iso-8859-1?Q?/CrDa4XpOH8HnOlco3LdEhUPFVuCQ2XPUMD0wUsSbH7XeCBaAnuQQH6FR1?=
 =?iso-8859-1?Q?Tq5UWtNaD4U39IKhGz+xjOslD0jGiZktKFUF15r6E8rpxnCpqsUW5qstX+?=
 =?iso-8859-1?Q?aZVSzg0XTYgMwymFvU5V3Pe4DkouHB1jLZBYJ2DAQaEpbYwz2I21QwSt+B?=
 =?iso-8859-1?Q?SiqJ/NmqqQvegHnIA8im+kly+OwuLmoQaRrRscieTWDnJ8WE2J6vstHh6G?=
 =?iso-8859-1?Q?qn/6jyEdpIn5AIx3o19L6Ny/ZKQLeyfy5EAloGpXJFJEQ2Rz4ORsKo4Ure?=
 =?iso-8859-1?Q?Goz+d4Z8JAMWFALok8v7I/gOGl7Kk23RFJuHN3YXl7469ykkcxMDHwNrbP?=
 =?iso-8859-1?Q?ztLqBdImrJ2iVI8kYHvusWDMRSWsR7JcxOh5Dl1dM4/GDdBJhmLvi27tDl?=
 =?iso-8859-1?Q?/Y5f82CC3CWg5E9ZEUdQIgxsRd6fkKRo7Q8fqHzRNV615sKFL7Oj54Yh93?=
 =?iso-8859-1?Q?YL/3ncbw8sKse1G89CuQ/Ocpx36AlXr/mM9T/j9ncMei5xw6m6D/iGkff2?=
 =?iso-8859-1?Q?7K5/dhWoj2SdmZnNARv1F/HYslbDPUfEk+N7a7CHWE99BQ6GO2kAPbEDvl?=
 =?iso-8859-1?Q?T51SWJVW9W2SPHrX3oVFdSuwmMQ8Mqb2yXCPktezyKy6dQGagblGRX4bJy?=
 =?iso-8859-1?Q?Kl/tQrZ5MLEdkSi1UlpckcQESPeHHz8JCrPcm4X3WrauVCT3dUezqGibnU?=
 =?iso-8859-1?Q?M9v36g5uRJZmbtbp8APmFdRaHk3UnE5DTg0B5wbyD1xdizzg51ueuW3koa?=
 =?iso-8859-1?Q?kTjIWmfpk1sC+zMhO99MpeqTTORyAJ98xpZEbYPK6tjCYZyLm1gXHLb7Wm?=
 =?iso-8859-1?Q?wDKPNjRKY3R6cQjfVA+9Fst2Qph1gvHd5Y2sjSEP/Q4cwyBKW5kS2uUjcF?=
 =?iso-8859-1?Q?hlfcTqWiNY6ODSkUFd02p/msduwxwKCOcPcppUikJoD0p/7ZRA/nFyGMcn?=
 =?iso-8859-1?Q?Y9UVhTcTdsz0650Vqm/PpGBHU5DO9ZhGIM9wPQMZ+eGdA7eFOy52rE02iX?=
 =?iso-8859-1?Q?PlLDRCyenbFfRoeBgSZYq8jtfrsBnA6+XvVn5DV1fPiHlxeS1bvlLqdbMf?=
 =?iso-8859-1?Q?r6R8AKJmiYgOxzQcoF6DOoMvIhVrfbXQIc3IJQp9ZdSxZNZa6nHERQpm5L?=
 =?iso-8859-1?Q?/tDYA4Kc/zmWh62bXbqcqyF2ojJkaInVnCyU0CIKWC77UwkHDVMdLQD+Lk?=
 =?iso-8859-1?Q?5FrIaNuqbzAVP3ZxMHLMszC3Mg4otUQu0A0xeUe5079wLeZB+DL+U47O+Z?=
 =?iso-8859-1?Q?/0GIab+355l7nLwZ1BsfNNfBX/hBVbL2NmOFOJChpKg5e+OhTJQHMfJnQ4?=
 =?iso-8859-1?Q?PeFdNI8Ub2QBUkhmplPMPzWsGMW4dDHLybLa3DWpwkYWV4D0JsjSNaYYW9?=
 =?iso-8859-1?Q?YcSu74nLRiBeehEXTb7ifIADoaYqJBMFXRbTpu6odcM98VabQIM93CQbW7?=
 =?iso-8859-1?Q?RGRPZYUE1F8LfNe2vhXEU3RNEh4JPNo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe19615-0e52-46df-6976-08da27965342
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:21.2254
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iMD1sxiXWxijObtGYQY1gvDiVfvuB5SSS+QdElcYCdpHyLQ1MHFUFr+L1MGfWh2kO57tqI6vlGyUnTI2fJoI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: F5J66IbMn_P1DSO5y8aFJvwe67koHWKh
X-Proofpoint-ORIG-GUID: F5J66IbMn_P1DSO5y8aFJvwe67koHWKh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add functions to get the number of allocations, and total allocations from
a kmem_cache.  Also add a function to get the allocated size and a way to
zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 586fef78dbf7..e64741ef89ef 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,6 +24,8 @@ struct kmem_cache {
 	void *objs;
 	void (*ctor)(void *);
 	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
 };
=20
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
@@ -31,6 +33,26 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
, unsigned int val)
 	cachep->non_kernel =3D val;
 }
=20
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_allocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_tallocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_tallocated;
+}
+
+void kmem_cache_zero_nr_tallocated(struct kmem_cache *cachep)
+{
+	cachep->nr_tallocated =3D 0;
+}
+
 void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp)
 {
 	void *p;
@@ -62,7 +84,9 @@ void *kmem_cache_alloc(struct kmem_cache *cachep, int gfp=
)
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -72,6 +96,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -97,6 +122,8 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->size =3D size;
 	ret->align =3D align;
 	ret->nr_objs =3D 0;
+	ret->nr_allocated =3D 0;
+	ret->nr_tallocated =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
 	ret->non_kernel =3D 0;
--=20
2.35.1
