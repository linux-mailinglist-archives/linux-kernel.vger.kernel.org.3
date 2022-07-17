Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC8157733F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGQCrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbiGQCqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06834193F8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8e2L009395;
        Sun, 17 Jul 2022 02:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RMXKgT8UrrngNlfhH2IbTL+hBs/nvSuEe50vU5dFwFA=;
 b=evBLa7K1HXCx1lTlV1qieIReGfSEko90XXqnkh5Ec6a70/4CqmqtQ3PqdcJzYkOFSxMU
 bER0kvMg/y9AAohKpxnshX6Onnh7FIg7jX5LXrwsZwkTM/L2bl9ukXIxSbb6wWWJ+kUz
 EEEq4jbPE/h9FGt4gl1VCnXB6JILVsMVeLC5DNmeaMoA6/Egm7OQXS5D9MEU1GQCm6lB
 J37zMT7RzkiuIrjjcznsmP1EsTqUAqOWud/eNR301VLHdIEyTENG6dxMHSwJRWJTQFlW
 MxqvZX2CWbrtq8cG/WOFYTsv6EBPSzZmuAsz30m+pO/RLqrjq2g63Mdx02b/O1jQo3cT 7g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3EE005901;
        Sun, 17 Jul 2022 02:46:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d7y0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN95pTSH7dGnDepQmqHyqO4V/fPf14tLdyg2tpH0y0HI/85wF3JVFoeES7pLDNuSD0RqSwaLDUGjABO7DRcJ7ZVGVqVyTe9gNPOXUGuOG+FjNWPkUavPNNTCZUJLcm4wvEqXcbUIHAdo0rpqI1hkLb+1b7wXh8hz7YlzHZHqn7T4PSjRArYJtnAyuUeSV6gs9Kdb3KZGO0DkrnSK5Nv2gw5G5Nre7HihBYNJF+jGdoQbXKutCbxuDp14Ac6Qm+1oZ47rX/hfuQJcbfS4lXuwCwRveZqRZw4WQiRcv0MnMijAm48W0GqQtOgO0Tn3cigtXG7u1UqVRWEosCNK7EOqyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMXKgT8UrrngNlfhH2IbTL+hBs/nvSuEe50vU5dFwFA=;
 b=Pstp/zTu5fINpvACzdJoPWwtSdeLxWsXTc6K5tj/GX11hCzqkJnwIP4ad6obmJBY/rAOboR3FbY97RHSmH9Syo27TolZp6TL845HVuinSxOYgrfw8yatSDh0ElTeFI75hxNKE6j5KfSEyN6ho8bG8qrIlqyL0vmx4AdEHGZhs8KJWTmILa9Ti3wbYwvHt2Xek0sJEc2voNkBx2KgONOQwJAFRcEk4JU2fC/ehu8UtJS4XQPCvRD6u3gd26B522aDf2zKFJPlaJNHY0oQ8AFxKkemuifHhcJlWCs83L5TUmQmPCSDvxobyQpM7AzrZhR0qbMDE2uylx8wktqNr1Esew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMXKgT8UrrngNlfhH2IbTL+hBs/nvSuEe50vU5dFwFA=;
 b=y86b66PGbzNPQp6namBpD/KRZpKXBFgaaBgKMeNUw6teVHeAFJpYybu63lSCGYq9mnVHpcfBJwol4EWPtapL67wJ4GYOqS05kwLSh9/L55eebQkm6yDPv3qLX48m3JadX7K8RR10TDL6f6k1hsjwpcyKqFhdR5WvUA41dSf3t80=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR1001MB2369.namprd10.prod.outlook.com (2603:10b6:405:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Sun, 17 Jul
 2022 02:46:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:34 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 04/69] radix tree test suite: add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v11 04/69] radix tree test suite: add allocation counts
 and size to kmem_cache
Thread-Index: AQHYmYdtxgP9kzE6cU21uD+DpOiGBw==
Date:   Sun, 17 Jul 2022 02:46:34 +0000
Message-ID: <20220717024615.2106835-5-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d803f021-80f7-4bf6-ecb1-08da679e903d
x-ms-traffictypediagnostic: BN6PR1001MB2369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3yZnnsplIBzB8ZiC4qQUc0OcVCo4iABM+h8MlMI9rBRsa4+fPqeTVoSTj5KBIwhsxciTQCEfepkYirBP4oCv03YpY4sZBMOf7SWK27bMJ239hg3bD9uqlckv3xm3hGk1nO7AGvJUGDTUZPvk8M0mhWhCEjdkh2PoGX4rtchVgDJrzUm+/jFIx00wbKtmD3c7NzhoMPv7nxqiSrV8/fB/r52yndqFU75pcw6+pM3Y+uDere8/F+WHkMaCI+mVwrVy5BywY42qPieG2vZ/rd6wzIrungeafFqQsBZ6m01K0oU0jzr6RFDsRxWrVt/23kxhKIExBp0xwOCv+mkE8OJavmGoE5ah5LXk5XEq4vfPnnf0CoFr5MKJhYxT8+vAM1jpsBLt5bUj9OpMtcVyDTmrqxG4A73suC/3q6lVb0OUtk1H5wqO04SleeH3a0FiF7vkdmJUAaF6kcF8p+rHojCRFkx4hpDNROCHMN7vzvbh51CYvpcybQK0Lx/sMjSVC187nBlZsQqmt7BvqSvssANeVnvJyKfXdz32vZU+CmR+nliuFtGomXCG2parAKbkC33OSCDzxCFQJlq5oZFSuo9dp1kN/yHFkBMwW8pbzpLiBdADLGRh74vH4EKG4wC9XEUuQoORzPGGyVeL8bD/zl3rvP5d20NNWCsf/C/6oeYk3A4IeJvTtgD0NaYlmTTsDZzwMz6+LJZA6bQNkVbUlfT42mY6Au3l7tk/R71raOy84mNshUJ5Ka8k9Sj1MMSOT7A3lSeay43slDDUuregq6wDNvrhkPBfg1uSCmvo6K94tJ286C7sGNHcL4T4eTXIp/9YBJ2ARDIb4U9eizEm5B8iVNcVcXee+oKtPT7vIhoqdm2MG0wtRmMwDHrg6u/HKOj2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(1076003)(6486002)(966005)(71200400001)(186003)(478600001)(38070700005)(6512007)(76116006)(6506007)(2616005)(41300700001)(26005)(122000001)(38100700002)(83380400001)(66946007)(36756003)(8936002)(2906002)(5660300002)(44832011)(110136005)(316002)(86362001)(8676002)(66476007)(66556008)(66446008)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?BzdyEwwC8+je7ClgHMkxow/nQPe1DJjom/H9f/iAY6YJJI612h+oYaEVJK?=
 =?iso-8859-1?Q?Nhm1fK7V3sd8k2D5e89mwePlslCJxoqyfnNFFQpdMJae+iYqYminAsb8OW?=
 =?iso-8859-1?Q?z4Cth9mTwisXcG1zyuiCvLiVKxwxRSb5SNFBNsIBPWVzQCBR/CATK9E4Cb?=
 =?iso-8859-1?Q?eq2IhYKFjdLAxpJgFGcaDky5WVoQHDc9zU+HPNuzXR7aRk6FxVYux7QP/e?=
 =?iso-8859-1?Q?fG183jZQyNZEtHeXaTwOJ2ztY+YogRdzGn8LonsLMaK45z0zDt78gG5gzY?=
 =?iso-8859-1?Q?w8LI07G7pRhG/d9McInsP7YkRp9IgnTzbnHn61pFYj2fKBcp4FcLaLINfB?=
 =?iso-8859-1?Q?K7fmfRaOko2T4geMQgUhfXIL4B0NzoOzOaCfX8UJEFFWfEYGaNxFOVDjUC?=
 =?iso-8859-1?Q?qpwVs5GWKxn99YRV5oMEde8LBmf1xQVZvXIzWHc8qXsuZP4RbEYEP32F3Z?=
 =?iso-8859-1?Q?w5m7Fgl43tbjoPWBAB6datsMrFwiQxxm+ePhV1xRgib9Nbl2u2GlzFVluQ?=
 =?iso-8859-1?Q?4Rq82Q/w6dP1ZuIMNn6pB2AkbKKVytxjdWhdYYXpliYN0MXgSHyRR4V85V?=
 =?iso-8859-1?Q?Bo09xCfFiNVRKQ+qcCk0hRe0zp0l61nAn+7ypZba4UEvg2x+RZ5n9Otp7Y?=
 =?iso-8859-1?Q?5e/TRrz479HT+0nvd2oQ3swTKM1frprGmH+dGTANc/BKb1JhQEhDeqSNfB?=
 =?iso-8859-1?Q?sGz7aiLG2ytTOzeeMavKbe6LtjAgaxsmSZybJUxQl0HCWCT98B7R7P/t1P?=
 =?iso-8859-1?Q?DUEJLZ16wUCVANSWGPD7xdUvYwRtMs0LHHUWyB8gTCsNtRAD4bQEVEx5OC?=
 =?iso-8859-1?Q?HgJzoJcUFaHPrHLfTwFBGJDfc6ZzgZ6jTGn3CqWkbBmcmgucoBEIg8xDr8?=
 =?iso-8859-1?Q?cMlpEC/JWbAmQgBa2RM1Yuy99sNdVWyMNuMF8+9brGwzOsUenerLF/Opwu?=
 =?iso-8859-1?Q?Z1kBbUIiMR6ADjwE1+JOwmKJaD0qs61STjqjmJxASOFZi6+qBQCT0Ij3P5?=
 =?iso-8859-1?Q?ivu0SndCvxLfiD/Ilvltlx04iFP0M8iBcEkAYs8fWqEVuOuZ6bkrntUs6Z?=
 =?iso-8859-1?Q?G0yOQ8XJo7z9DNwcfh3i4t4SL/PWufuaJUhsDDtH69xhsH5JYQA4LU2o+q?=
 =?iso-8859-1?Q?GXBfC4Qke6C1hdqOznrbS0wOY1TlBWWpk+xblzGGYfY/DxDk1jQNaVKHmy?=
 =?iso-8859-1?Q?2VDjNjJt8lQofIEn+4ayKWwFibneUY0qY1wbFHcBpvng5E/vb3vNM8K+nX?=
 =?iso-8859-1?Q?XVSMFXRhXAwv1yyCU8D6kPXdocbIpDERPc2pmflaJkRUw4sIvPa/yfl+lD?=
 =?iso-8859-1?Q?YJCuARhx3exZWmQAVUKaEACUGy9FWxEvrU3gbXYJQHF70ueAZGkZbJCM7k?=
 =?iso-8859-1?Q?Dz+z/NK3SHUJ2dqVtc/pyZHUkn7eDuAAkeULFpXoURoaJVZjYyRGgodbdl?=
 =?iso-8859-1?Q?S3F5uZss1tAjuIKQ6KFu86rjVzhEJfCNGAsdHV6NSbbKbMfefUzWTf4zgR?=
 =?iso-8859-1?Q?IZCKiSxVeIhooI/WeCdvsM4RX2Upe1gEgwWSLDsFCKbL9Cz66+7DSoG9R2?=
 =?iso-8859-1?Q?4cyWr8vgKL82tCuxJiYrJvQtrnfICW3ZS/GvsZEY2De6lCzSCFsTJ+reFz?=
 =?iso-8859-1?Q?b3u2UGclSJf5KIHO9uOvy7eMRlFR6kepyGxjtUaTQeytEQO9EV9GKkcA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d803f021-80f7-4bf6-ecb1-08da679e903d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:34.2568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ok5r+zjynBaADIC860sUeXa9r6DGnM0jnJzS8XKHrIJwF3/i2LrXDb7yZhcZcL5AuHD8UDou2o/SocMWLTe0bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: M21ijX26eS9LtpLcaCvYgXMndQGoZBSQ
X-Proofpoint-ORIG-GUID: M21ijX26eS9LtpLcaCvYgXMndQGoZBSQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Add functions to get the number of allocations, and total allocations from
a kmem_cache.  Also add a function to get the allocated size and a way to
zero the total allocations.

Link: https://lkml.kernel.org/r/20220504010716.661115-6-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-5-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 277aa8b70abc..f20529ae4dbe 100644
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
@@ -31,9 +33,28 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
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
 void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru=
,
 		int gfp)
-
 {
 	void *p;
=20
@@ -64,7 +85,9 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, str=
uct list_lru *lru,
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -74,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -99,6 +123,8 @@ kmem_cache_create(const char *name, unsigned int size, u=
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
