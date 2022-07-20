Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98057ADA9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232770AbiGTCSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiGTCRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:17:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC835459B7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:17:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1VWuk002405;
        Wed, 20 Jul 2022 02:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wKhhnkwkM2GXAHBza4WWAtPG0tasxLWA0VDvgftdQYk=;
 b=N/DSUQlcwWGouMknyKAV+MAgwUT5NNaC6bij8FggiE09Bh3enPlfUal0StdgooCNQLWl
 rpWWW9pWN+169s7eAj+4CP6/hyDpcG6t37XOGuBE5W7yhjP4JEtaoXQeQpS8hs4i2ig7
 CVUxU7+5DT3DLa2nU4tqetvqv2AU42mnaWZpdAgBVIK+XlKWGYtW8JbAHLgs5wRN9Ca5
 Ls+6vV6ukVwhGV0knWE5zejHBirGFZVMw7UqLNkcr0ePIbee5zcYfCBJF3l2/cdxgCRe
 7RJB0CVHlIbBNzDvx1QiL2mFTQN/t2nppuTvBY9Xp2vRX1DUFkkejNUZrh63nY2r85ub 6g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81kx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0rIv2002688;
        Wed, 20 Jul 2022 02:17:42 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnukc-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cqhaI5EXmNF/n8XAfLm1LUCvfL/5ZxhkWGwAhUGrATAtEHRWFYPkxx09soRPn4pFVaZx2owj0LGqjQNL6/4c4gI2kLEIP5bRX/EOtmTmCwWyGQC2sG6bzeDut/5PSAdh+U9BSO/KL7cVgGk0uHhuy3speIT/sS4i0/vIuqQLuaM7MZtLaRYmOMCAGIL6Cd/QOwJtgbai6Kgm3KXNZh3/ha6KbTlmK6MiGUEag7QPjMRLqM9oATZxHMkSL3/vO3OfMXxSXgfWWGgq4oc8mH/ju3GhfGiKAi5tluc8ew3tmsqDlg+qVk0jhEfDIi67aceeolfm1bhDuJaoqGRQ8naHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wKhhnkwkM2GXAHBza4WWAtPG0tasxLWA0VDvgftdQYk=;
 b=nQpRZj/KOFBPoAOYzHlksl+Aahx25lYSWCQ+Z+G0AoD2qaK5/3WD8MgjvGo7YzvPUleoxwCWZtkrbXLCjE5pX+/kzORCPmnsXSiKzHmKC340h9HAPFsbN/c0VUYYD6ijpD2U+V8pdDoF11DgYXKs8DgMQBNpfq297l/Rt4uqBr6bpe5yMnO0Iq5B7dUBll+ZcRFUOctkWRRsxOvYa30EnEWL3ULYW88i27qn54BDtRkJqUF2Ae7v8UfEVrt9vFmkMx5et/dKZvJruJlOLvNV4mIr5b35VhOSVL/9VR896Y3ibTrU9rkF9pC+ex+0GKP2jVrxAFkDPEvaGmTpKxvRtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wKhhnkwkM2GXAHBza4WWAtPG0tasxLWA0VDvgftdQYk=;
 b=j7PEQ6jMXIy2tWQ5KsER+gCN5meddfxY4kIRDmfGaplGxisq7p6MMH8B7RIBgEo/bloeIiaV/c0bWQyYlI0DNz1wkX8xiV5eO335Z+/+hpx5zIDIh2IX4eJOUtmfApe9VYmrLqF1rHAh1C/XcnYOsy4tKw3JK9w54M6pUndOubI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2889.namprd10.prod.outlook.com (2603:10b6:5:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 02:17:40 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 03/69] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v12 03/69] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYm97irKgQEC1clk+NAelvdp/t3A==
Date:   Wed, 20 Jul 2022 02:17:39 +0000
Message-ID: <20220720021727.17018-4-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d3c664a-0426-4fbd-4d03-08da69f605b2
x-ms-traffictypediagnostic: DM6PR10MB2889:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KEgApIVnOi0acSDZPw71jZ48eBgF3M5L03uNWSThkCzBRrSwVuzzpgLYavJTcIfhIhEBXb70VEadfgzXFG1PgWqNOpT/b0k3sjgsb94eVHZkbBnUYQA1VGPYkew+E+/w7EBi8ZaI+o2Ann9l53lJWy1NIBj66iPmjQpQb30wcff9gY6qE1IKGtgkh3jYm8bDcZS5ZJjPuQaX4ShQz6QpIrEqEGY382TwAARXYzFj4jCdA5aWAVNoeLmTwNkYcJbOc/MGQekQbYBCYlGHNfWrzpXhTTA7Np5wfUJQEdFlRL+2zKlQFmg4RIKWA1jhNXozbpoVdo6jmWffWlaefvLRp4SVC9UF+AxS3znNh3+h6mB6Fpj5lwPv5FmQES7SOID/pyoIlb2dtPwvUU/B2BY7eLeJ26SYENyxvC/elSr9uaTorErraPWbA+jKDfxcS5YspKU2vwFDi7KLtdwu5DL88/f+ug+X+NWaHw86n+Te9vMgvYuMXGVel8thZvo24dnk7vHVbCRwPEmA/5+gW7uRQKM9SvTw54l7YVnutwYzJX55avDXXDefTK9tb6C2G2s35+b+/H5F/E3PcOnks30E/18XzCMxou7j65stcVdUvebLrldJdd0Pqv6epgAACdhTZtiDqurtkNjdcoORW136QJLFvCTASH8Kbe8rSGrjRuE7oBF4bz39ZCYQDyA8fHVQLSbvwzJOoT4iRZAVOesMjclT0lbVu16Xfly0QARAg2/i8OWyRjQbqA1PQqjgmUT4FTWQ9nokgaNUl//Xw/iiOwsGVDpXyPQkHlQqVBwNG0lf0w1S0k6t+mzm3fCDCS1T0x3qTulfz4LIaB5bs8rTJgUHneFewj5xX3m7JH1DY7xpE2XFzJIqQWVAG2AtJv6X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(8936002)(5660300002)(76116006)(44832011)(64756008)(66476007)(66446008)(66946007)(66556008)(8676002)(4326008)(2906002)(91956017)(122000001)(38100700002)(86362001)(38070700005)(6486002)(966005)(36756003)(71200400001)(478600001)(41300700001)(83380400001)(316002)(110136005)(186003)(6512007)(26005)(6506007)(2616005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wMBCZjlAFY2G373ymcoux3CGsEBXWLopcLxm4U5BhZvYaa9necZybwnNX8?=
 =?iso-8859-1?Q?9KQo3MNYDxmfNBbF/MFJr9uTEDFrG/PlEFb1mXSsiyMVoYaAUHrIbsy+Jk?=
 =?iso-8859-1?Q?9GY/mFk2sQJiK7WyWUnDa0X6N3meGi5ahz/5rMcKbsQ8I///XXZEy9h1+H?=
 =?iso-8859-1?Q?PaB1fdqbnENC3pwtwEbCZeN6ZqqTmTSP2pTS27wRYoEZ93lryzxxXgVdAI?=
 =?iso-8859-1?Q?NZgZrgLnVToylPq0j/1xNXlOGWc8XxZn5oW0dGZj44fv2X+0CKx69SDT7y?=
 =?iso-8859-1?Q?61ESkh4JqxH+SFJQgDDibrneOvSki9N2jkVg5rnaCWrRaEtlCIvTDYUJp9?=
 =?iso-8859-1?Q?ajB9YU3+WKeeBHjl3Sf4lu9vFYqjyAGqnQoiFjrtvA1/nCUBcYDdr7UdKf?=
 =?iso-8859-1?Q?3geGEmGWnoKIKt9Acr0GXij7emEBaKJph2r6zhihnLLe9zpcnncFbUot0J?=
 =?iso-8859-1?Q?KEolBHYtgYHz7fecjIklac9TIySDqVkumFLlcZdZYjljkTZb9J5O6sFgx5?=
 =?iso-8859-1?Q?xZVdpDvh6gEkfBPwc4hUez9X1N7phkfOlLy1qMAIHArrJgGK7jJQxB+ZZW?=
 =?iso-8859-1?Q?9EIiP1dZHdP2X7uT8ft1rt5pngA8zJG3+WuI8Dr/KJ4CToqJDQOKHuIXIZ?=
 =?iso-8859-1?Q?Ih1BM0NuBgnB1rBUVOQVq05dmcV0vaksDy/K4k/txncQ9VQIGjKoqtrB4l?=
 =?iso-8859-1?Q?mlhTmhb/QUP6ueFXp1YeU6PXdx85EhcV5maYGyF2PMI3QJVKndUxnduJrT?=
 =?iso-8859-1?Q?jRvDH3Hpgh/jqCQgoS0b0NaNAX1WxLMGONEztcdPtdWoaRfGpam+ixX4qH?=
 =?iso-8859-1?Q?H08DQKtBdbAZBKnHOQmQMEKWhlxSUEjS6MBZV9msTSdO4GOu0Z6CjJbf0H?=
 =?iso-8859-1?Q?WvOKeGMe97A7lOPLTxucImn8A59rter1X0jvq/Rpv9vgOZBOW3E5TnZUEL?=
 =?iso-8859-1?Q?lBhIvv+GpyMbJHZBN3mI70a+AKFh3Y3QZYyKb4oI2C9JQ4L9Z7sH/5Nx1C?=
 =?iso-8859-1?Q?GqPQh7ZYy6Q1757B8yBazGXz2TCoEK2eutXczviF8wPnska6gwkBD3w7xP?=
 =?iso-8859-1?Q?t1Ozz287Rcg8RKFrtObHcqQ5aL33gYdT8udlVr0MQ4ZWgAv58dXndL5Awt?=
 =?iso-8859-1?Q?VfXraxGM+QcUnz+HihKjkiMS5WBEfudMBO3J8+LowOJ1WT18a2DvzTlD5I?=
 =?iso-8859-1?Q?wKV2/0tbCOd0+aR67pkZ7ZMtDS2G9Pr259NP1dl/dsCDXEsdd14zmlQdy7?=
 =?iso-8859-1?Q?eYAzYqn5HGQUApxk6oShyu6zG1S+9ylEy81FV5ERxpgRhc7AZ089DJBosj?=
 =?iso-8859-1?Q?IoKGqV6V5N73l/GIktK3N309GIS3cKjSGIryLYamTBz/j0yiY/jQrn39ul?=
 =?iso-8859-1?Q?G/x1NG0+3N3CUSpT0iziyKfe5l7+YwgxjJ6tJxiMY8WcHZPT1L1a7O74WW?=
 =?iso-8859-1?Q?asmVFatA9jk6+awevpdi6rFSMRwMDqFJy/yEZUfdo2QyHdNFdkRcmjmDu7?=
 =?iso-8859-1?Q?Yqmg5ZEA9F03tnHc3/yTBzjUY8wLZkq38pEwO5s9VA231x2k76j56inVqt?=
 =?iso-8859-1?Q?6PzumT6rx+75IADyJToAT3YMvwrYD6unkIqeMbxTC2C8sykCWqn9xFsx9g?=
 =?iso-8859-1?Q?kY2jl6LjwFLTH0/fPW6G6ulcT19E8trr+BvffV7Aph511Fx15FwxXrNg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3c664a-0426-4fbd-4d03-08da69f605b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:40.0101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CAN4wC/LbnrQWnQS+O/ls6vbe0Lh3yK2y/UOEsgFXT4nXhP8cXlLBACNmXIYIG1PE8FUhF3GFQYbT9x4loKiLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=991 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: YPX0WXJA7TvbF8IJMdaW1Za39OhqfQQ1
X-Proofpoint-GUID: YPX0WXJA7TvbF8IJMdaW1Za39OhqfQQ1
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

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Link: https://lkml.kernel.org/r/20220504010716.661115-5-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-4-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 tools/testing/radix-tree/linux.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index d5c1bcba86fe..277aa8b70abc 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -23,15 +23,26 @@ struct kmem_cache {
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
 void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru=
,
 		int gfp)
+
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
@@ -90,5 +101,6 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.35.1
