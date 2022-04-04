Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC9144F1717
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377593AbiDDOhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377569AbiDDOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E91B3F314
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:39 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DhxPO006378;
        Mon, 4 Apr 2022 14:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iZynPlv64DSSopa98NAEULDNTCBYyU+7V39qzhRpMtU=;
 b=yP/PwlMig6iCyzokJ0apxFBRut+sF9Scih4GcNqV2AId7w0des+Whm2FeQUxOmSWCuwp
 6I/ya/s6PPc0yAr3CKQHALHNhU1JWGqAVTX5yLca6uVhQOPSO3iWV2ODN8MWd0jTyG0N
 AS/+UvaQikPyBrdS2x6/VBZWo90jRkAiVMlJiQbmCjiPuZzeSrc9ZCiIsDDe1hW8p5GQ
 5E0x/LocsR92SPm4TxOhutmVRruZTG10yEgrhKNOeJETLHMxYnDixZYWTFSxfQBYB8by
 rYS93J7+2eGEI65L6TNLTDZUbBsfKKC2JlaP61AGVi0eI29e2XPF6IWAZ4sMnB5A/dV+ sQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGjlN012809;
        Mon, 4 Apr 2022 14:35:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2h2f1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iew2MDbQHWGvSPqmoDKF5nZYh8HMCq6DuamqOsZhTBKlzaA1xGBfJiOHaa0tAF+A7WrLQUhgiDBxFzNsKEj/cCZCAXYHLO2fOMiPqubuwNs2EzR9zwyGOAN0sHtwlW0O2WdoiCLxmDADyWyN+pTvCQ+b2Bh2c8hpMINsvr2SEmfbwXfsHnIbKlNj2aDrMpG+vUdGeTDgyJLvHF0aGSMfoIHqxJnhj/ohPJVakuusO3aO0LdE8FL3v7XwBCY18JW4Rga7U+Cm6GScDD7kBLPuRI19oRmBzZdwxTVLoR4kf0yXxxewQToRGLvOtF77AP16Shyafo0IYMJUQyeNI5yINg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZynPlv64DSSopa98NAEULDNTCBYyU+7V39qzhRpMtU=;
 b=Q2qwfwjbTWIA4fYmMS3v4JkkiRX7EZODhLzuBTQ4VaHRQC/aG7Gtaqb34CrOb+4R0PX2tYylw6iN56XwAOVxIU9S+23ISg1VcX6RrS9yObtVv0P9gx8MuF3z93M8q1p93xpr9HqubJehM4OMTf5/zg0MDPKUl1i/ASIUnuj/h3Y9yi0pCmZTp4om/5+o2xPaxABfuc+zQanG1i4cK0dooijdLV/OdrsWPEYXY+PEf4Hmk/YjW9V3nlqc79FlZzd1PALwVzMtYOAL/DPhcY21YLDYT8+o2TfRPworqQ/saKqka2BFRdkfI+USx7tHEmJtQoTNKsDka0oUHyNROFXvgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZynPlv64DSSopa98NAEULDNTCBYyU+7V39qzhRpMtU=;
 b=qiYLe8lEyNn1bWe24L+YpUbV4HLCSnCb3p2ixStZu7MBa96a4UENXRsS6tC/sciOGtUrP+do7fN5A0F+AwQQqkKcGynoQfdQXvJlBVv1LdZsRF3J6WV3N16MBCwul7v6gn8I6BlKQp/79FawVK+nePNE4FFftZYjLxbz2ul9KXM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3881.namprd10.prod.outlook.com (2603:10b6:5:1fe::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 02/70] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v7 02/70] radix tree test suite: Add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYSDE6HLncJ1CxqUyeIdL6m6iM2w==
Date:   Mon, 4 Apr 2022 14:35:27 +0000
Message-ID: <20220404143501.2016403-3-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e39b990f-b9b2-4371-2c4f-08da16485d17
x-ms-traffictypediagnostic: DM6PR10MB3881:EE_
x-microsoft-antispam-prvs: <DM6PR10MB38819292EEC86532917E5043FDE59@DM6PR10MB3881.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A9cF7+1Yg+zPjrIAPe9A8Cc+gcOQqSIBotWU+oZgP7TCXwdr5fMFv6NQBgmjcEhncpWW7BYjgFOgQa68SYkTurfJSJbo7jq6MZJKKyFlig7M/pC1RRSpA5UwdzV3PXOgq+wnM38YSrrCJEIMDaoFYKlJX0DyFlMWj5mw7x6Bq/uHOjNcnX3Fm99fXxxJ8a7Nv9C9Kk+1fDO+ZlW1V5JpLkFTp4M9efv5vge17Ugv4Td3t1TXAzH8GlenkoDDIPjOoI91p9IEdLc3vEQgK+axRmcC4XJM6jiFNCUhLw0ELsZYO/TVAfHHfc5dX/byg2T6KIjgR6KR8VASOV7Yb6AkOKEtid8mhjGpYUI2nd9o+l00Lr3+NV2UUmICdK5xvDkG5iO0d1mWnG5il2XmCi+Gj4r6fl+jIXqtjrr7mqp2zP90r/UvKsC0xeRqT/TqXNzT5CRZAVZFQ2IVk4kJjKC0lyMWsZxsrVMnEHut49qlv0QCHKmNexi2VtsCQl72j+uFaArCPdVN5crifnlve/j/3nJvF+3p2mdQF7xrSjDms6J8Vc1sB+tL9bDpmn5TBG+5uh7rhVF0n4wgMslFYX0bFstC0WsyRreqDa9lB+cvNfgvk/9bWd/840+vKwQt4EBc5lJ710MEhRV4QDUsbiPmOjblHQ1iERuklL2hsHqwVdQzyy5Hy+ENjo8GRCup911m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(316002)(2906002)(6512007)(36756003)(38100700002)(38070700005)(186003)(5660300002)(76116006)(66446008)(66556008)(6506007)(44832011)(2616005)(83380400001)(1076003)(6486002)(508600001)(66946007)(64756008)(66476007)(8676002)(71200400001)(91956017)(26005)(8936002)(110136005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sEm0bBugRmZLpAyXvyMP1I4nQ6q/OakJ7vAEscRXRFF9hfSGnvriPWsxDG?=
 =?iso-8859-1?Q?fRiSfAqEdic6BP2/VM4J3GGRUZaskXy0bnI9MKyMWMkTXPHciPTTAbVboW?=
 =?iso-8859-1?Q?ajFieay2xg04i5oxJOIVlJtEMDd4EomP1uxwY7BHMJIMNyYYWc8MnDKTKM?=
 =?iso-8859-1?Q?y8HbrATKm/M96rdb9yJ7pe0Z6sT9J60MRX8fcsH7P+Wc3UZ0lu6n+zafaQ?=
 =?iso-8859-1?Q?DxMyJ5P+vV2MxmciZeIXtVI4aqakhsk8gaa/76PYjZJW9lpUi0r8qqwO1j?=
 =?iso-8859-1?Q?FjiC3vlypZj+CGOJpWBgWgkU5Dv9JGANjApOsjMwUvYUCxaDvZbCzCz4Gb?=
 =?iso-8859-1?Q?nRNfYEG8fRIxsX1pNPeDRKwX65UoeUrFQyiQnhQxUPCq2vkT1ph8VpWy/w?=
 =?iso-8859-1?Q?i87HRgDdF4wlobvRLISi/4Q+sI+GYdTt0v90ctRBSNXKzh+FU1Ka3kWgM5?=
 =?iso-8859-1?Q?HEYRzAh+453KWqZrSI758LBe+Ajs89poHFgspj1quN1zxtFzTxZyoBkLl9?=
 =?iso-8859-1?Q?iLbRXWO9Fv32//yRxU8uAYcm+Iudt0/JMzkIiMQ0t5GIYw/LmHs8XOrsXY?=
 =?iso-8859-1?Q?Y/c8q5EUD5rfLptHQ2phR5wjkB5zOg5SldTfoa0nVGi4mTatPvHDJevLc1?=
 =?iso-8859-1?Q?msNtanqKhsAjW7Aozbt2cHx9wWNxpbR1PLLFQ53nUJgT83U0Dua/Is2u1Q?=
 =?iso-8859-1?Q?0yw5x8aIIpmJCHeOti5DGt1Z7NWY8ihxvRguR09IJ590SskytldIBXtRPT?=
 =?iso-8859-1?Q?EXfmqWG32/KXqxTl4bdJUN8T1EAR/Ki5tHR2x7kjTvzeOEBS/4L2JHSW/6?=
 =?iso-8859-1?Q?NGBloKo54GZAUiBJdi7EQJMdPCfak5GTpE8+lcVNtdq1/ocn7QIqzVaw+N?=
 =?iso-8859-1?Q?42SRy8hHwjr3P5CPeQwKvU9/+iOurgm3I+dP9qWaZPSZ/6vV81+NUeT5kQ?=
 =?iso-8859-1?Q?Z4eAHWlEUrO6RfWee2vHG5HvEdatXIb0on0ocu4E/XamjzFD2x969zgEYA?=
 =?iso-8859-1?Q?PDpOKqThDu/MwvCPS8cQv91VXTT2qv607sUGmSCQkVO9ymhXyu3a5iydyV?=
 =?iso-8859-1?Q?ZjEa5n/agtvAj0q5P6gl8EOqPIOwJ+/GYQlUPjCTxC1xw6o64aVloJ8G3L?=
 =?iso-8859-1?Q?8aDJBBBcVI99zeDM5ktM+quUYHqWp6MViGn5wrUBGIF92bmQuZy7EVu6ep?=
 =?iso-8859-1?Q?wwsqZLJg+clsfomCBtekfqJScxZoSAhuihNDsVA35ccWn8Yk/xJthVETSO?=
 =?iso-8859-1?Q?pu0wAD1MAB3dQ9f83LFFXtZdXpj2KkQ/67ChfA550jqodmCS8j4bQtuGwn?=
 =?iso-8859-1?Q?VvA4QUuMHohdLN1pXkQd74RaybIE2IHHIqsW2rDu/dBi0vv5/bw5t+Z8et?=
 =?iso-8859-1?Q?C4+DiwoGxeCUQ6tUM5X5eqqNsdPwVbQmyiu6yiuHbCvLWWVALJrNiWZxxc?=
 =?iso-8859-1?Q?80SvGkRPiZxDwuzxQq/BqZvvlbi+C91LdwOYSY8x6tP0aON+sa/7hCap3l?=
 =?iso-8859-1?Q?Wv4qXUL2qQx5mYEkl+Wj6EMI68pF44eo7ccT4zo3yxX1sNgjbXAQP2GLYE?=
 =?iso-8859-1?Q?EopI8wj4ZH1FMLPADvVcozVcbPTlHoQ+qHWbI09KycZfJiPJGHNUt7p3wR?=
 =?iso-8859-1?Q?VstimmGflX4BKxUsVzcFfgnZJTz+r37Vf30bGhQmo8/dS3Co8xHnPqQtq+?=
 =?iso-8859-1?Q?ku6LGSRYRNbY1VudlK2PP1D4vjqiQZQXAvgxGipR9uFikUYQUltvjkPF6l?=
 =?iso-8859-1?Q?UD7egLRprJhwggb6/gFcogHXKq64bXaZ7gvKcFkkvg4+Ts/O9V4a610H1M?=
 =?iso-8859-1?Q?5rl7PXHKozQJz5WqCQRgk9IGwfSuD0Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e39b990f-b9b2-4371-2c4f-08da16485d17
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:27.8790
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNWjKspaPl+X9v/whuX2IHmuUffJWjdszMfkQUZoT/d+Junf4ZW3ozoLmpZW6RQc1vOTqjiegM/qVY5tk6KbUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3881
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040082
X-Proofpoint-GUID: 5ZxZ4VVNhqWpXnNyDt9kXtPyMltOq8kz
X-Proofpoint-ORIG-GUID: 5ZxZ4VVNhqWpXnNyDt9kXtPyMltOq8kz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index d5c1bcba86fe..14e6b50e2547 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -23,15 +23,25 @@ struct kmem_cache {
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
@@ -90,5 +100,6 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->nr_objs =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
+	ret->non_kernel =3D 0;
 	return ret;
 }
--=20
2.34.1
