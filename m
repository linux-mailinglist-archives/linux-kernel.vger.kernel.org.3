Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0476553BCC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354251AbiFUUrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354156AbiFUUrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1176523BC4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:07 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LIxkdY007500;
        Tue, 21 Jun 2022 20:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YyZwMn6aFX47dMDv8u9s7PGdM+lWdHwRUgRt/yo7psA=;
 b=RTAIdfpG+tjtYgi7SIlzemAh+f5ZBloL3Sqh930s0I4gOiufx6BAmYfZDbRUQq+nsUoF
 NLW/Y5e9a6uPvgZaZY4ggX1fNkBuFF79h026vT8jJZmwX0J6KinKJux5Yz4mAknjauau
 LOUBNssaWVSzvawgRCNQrpMXIpsdd6ah4zODOR0YoGGpZjKRXA+KlQtM0qmPbeAarCpR
 ukgTggx+ppoibpytPycpVFizoa7uuei8DQU1FXjS7ncNtHdRrqj7WCwk9PnEr2lY/MC8
 NDITlEhhoYV0hB6DLEhgZBoHEyNfg1OabP3tYPMnt/ZkFscM0quKt39DuKP36CoITmZ4 ng== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1xr6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:51 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeaMZ010747;
        Tue, 21 Jun 2022 20:46:50 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3vkghq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XFEOlxfx7FIijTzwEJmpfTxKvP/GqvvMp1JNGGOVr3PIiupYMNSG9SNV0GfH+tBmixpUmdFbN9699L2/C5ukIzM6v2vVxBln0pkaOrQZljat37ahkxkPIMyIO4SpVHfTdh+qpnAegISI5KKlBEnQ6DKybEJdtegMSWIua6GlqxXXV54nBiL6fzh3HM1w3886LaV+mwM3ugV+CB2Sz5Zo2d4WSYWsenXA29uwY7d1/vxm1K3CIU/MO2a/VBNRhsCWz2WQ7aCrKi+9dGaTGVC2Luh3m3J6mpksbOlKGtcuPyxVcjI4dGhvUJmKWihj7YnfGghZ/NevZj/U9JwYczaIzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyZwMn6aFX47dMDv8u9s7PGdM+lWdHwRUgRt/yo7psA=;
 b=ZJKnrSEmLFpb7rzaC3PCE5Xjx+ia23a8V1drtzOU+/lQPzL4nK1QhXa1QKxyLZgY0AdGVFegYUhBfJaFqMxlvpkSZz1OABNJ4WTMbGCQUjdsuMtjGYIWfToYQhEVhFY6wddVzIBnxHhr1gp2SW1XBbxm165KOtnRpKOZXgFUACY+7Jjd3U/ZmspVgxd//yRZwX08GRriZX5bmx2ZxA6qrTdJUpJV9tya6opFKGVW2zMdiU4nqp+aOMUNqTSzVTYv7iaE8HI+hIHiacNp/pXa8iNLT7iyh4/C9kzw9u8rOYizcwOBha2LV4GGx7XkOzCip9XotK/8vYn7tq9O/LUyFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YyZwMn6aFX47dMDv8u9s7PGdM+lWdHwRUgRt/yo7psA=;
 b=O9G84259dZEjnxHgklh93QSpRIbR2A/1LcbaQnR2E8158WxblVFS+0aCbAlEJx8xw3Ct4dUVDZVngWHiau19HLzPLnb3LTz2yW5zREZ+zO72IxgHtB/KxgfjhNo8yHCLd4eAg7EEl9i3vVzxGTP/Fjo5jKJ6I/NRw6Xx2QPK1J0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB3074.namprd10.prod.outlook.com (2603:10b6:208:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:46:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:46:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 03/69] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v10 03/69] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYhbAG7k5fcMkHv0auAFDmPmtMMg==
Date:   Tue, 21 Jun 2022 20:46:48 +0000
Message-ID: <20220621204632.3370049-4-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48f473c2-bf63-4ef3-583b-08da53c729d7
x-ms-traffictypediagnostic: BL0PR10MB3074:EE_
x-microsoft-antispam-prvs: <BL0PR10MB3074E197212415EF04B2685DFDB39@BL0PR10MB3074.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HJlZJnGrOYSsODjz9YBWTMMCQp7QkutBHsloks4EVQv0NLSM7kPjSDOz3u6h4RWJojCAlNfbwZt2mCfp5w/IZBaV6KagnFTQj38zk2LYVkmeJXaWJO3MTXsDeqK4ChOG8EukP+Ur2WK6RGNziO2ERGZg6FfsJeVHEopvcNS5NbwmXj+EimX0deeKhQWv07/RP1Wb/dHJ0IUk2l3RwCYnr/4U5G8MQ5W+HxSbukj8XRrCgTThYGf4va4MVrDDQPudqMLoY/6pfVbGPAoMN7BrcD/h+IKZvpz3wMVNf6Q1Nm+WgFWAxcysvVlzZnur92X4OkYaYB3Yh1ejlbO/i70amBRjWfEynJ7/uAV+2U44JykATWSs++zNEexTQ9qutW5vtsY6V2TTq743Uwv5uynksGkoWpkka+QJ9hh53j3S5dw9xodZnZGgC0+quDd0fhKPvJNdDCLGwE53YurNfIiaP9Q/51d8fiZvEgwL1bLbK2CWgUsBWcdmIfa12m45clGbk7rOTo3t5ZnuPg7aQvp3WeuzxI3Hcu+7j/mAxHIFtbSFP96wRJf+7K2HeL2xOA3EpxqFKcUCv5dFaAjXNh8yJgdA9aoWTYEFzC65iIy3wvfcnmNEE4haYgthXf7xyPIOELbPKD5X5OIqhCkSlnE/NeaISZ1+2NidGf+vaxdMlrKdfxlmljU3a5IQ7ny0WViVHXfHW+2AITslkLXleaoWAXowcT442UDdUKI5ET96lz4+nAvdRJ/cbNFlMwswqawfRgHpbKzonOA7g0NlMGPHKZTz/FucO3fE6Atfwy10Mss=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(2616005)(186003)(6506007)(71200400001)(26005)(66476007)(8676002)(38070700005)(1076003)(41300700001)(86362001)(83380400001)(36756003)(2906002)(122000001)(6512007)(966005)(66946007)(478600001)(110136005)(76116006)(8936002)(38100700002)(66556008)(64756008)(44832011)(91956017)(316002)(6486002)(66446008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UghXaIWG1LXUxXQJ6YFjTLeLKCbM05eA1+0yVLDDD3k4rgbVhHRcEujwUK?=
 =?iso-8859-1?Q?rHJhUIr2pShsePFjBQgZQrgVAeh/ymazy53S1yBtGWTqzNnd1Ws6bhrhO5?=
 =?iso-8859-1?Q?yhMMp6OrFztgEqVfvBl+C7ts8yJIkc6yeC4X+043FbyGgXj5qc/ui+/11V?=
 =?iso-8859-1?Q?/hcY2c31AEQVG1cplFUaCX1Tc6ch3vndWK1jZdHWtqtrYZQkNcKb2UrwP3?=
 =?iso-8859-1?Q?Nh/vme9f5jRpS4mIGE+R7FBGLAi42i+RMDMWoPYf5882wjBQjtFzsaGzZh?=
 =?iso-8859-1?Q?S8UFR+aVRnGGo5245gJ7iL554OCcXwvHHo7PzdWjYQPnO14eN0tIhpc+t8?=
 =?iso-8859-1?Q?JQ4DDdEIGisej4ILSLOKqXIRWTsslSR/Lvv2DVpI+i5wDacvmUdq+Y6mIp?=
 =?iso-8859-1?Q?PjyOBdUtXCU4qeA7C99xh4HybuacEiKuMKr2YQ7dNNWB2CgYck2Xd6yftg?=
 =?iso-8859-1?Q?jRsG3LeFNPI6B8TLilGKAVmrosPfm3DSUmx+7UHDDTbGbrbztYv/+aw3IX?=
 =?iso-8859-1?Q?7PZ8F+zUTbm9nsHPs+5Vc7GPADtnc7uqGftasFE4oHQyCbAK11VS/H/XG8?=
 =?iso-8859-1?Q?UhsMa8cEmVSo64lU16MskSzStaicWNgD6io9ODXU91SHGNA9J6sZUNlrrd?=
 =?iso-8859-1?Q?OR7xIuqTEWwtG3XfPnnOY1/z3qC6szHhO96mWajfTqm3ncIDu7qtsrXUjz?=
 =?iso-8859-1?Q?xdlhK9NocRZcaUmOeqgvtF7YK4H3b+PkzCzJaLHR92kB14wuJU8sPYnFQj?=
 =?iso-8859-1?Q?t+M1O4Xc6g5QxWf6COPhSW9IIMfgGlGueikzeSUtiQ/jf5GV1wheuhaeCs?=
 =?iso-8859-1?Q?7ea6YxEEIJlRFtRw4eijCWqwrbE1GEI/QNhEYcfx+Lk/4QzxaBgfBZwMFD?=
 =?iso-8859-1?Q?xHHyqkhR9sUjSzWtHx0DDsK7wuCEehJtH9g0eMy76OJBI/lHPkMnhv5cxc?=
 =?iso-8859-1?Q?7FQdJYKJFPUbSJXnbiUPBvjgGm/qcommq7YxD4C2QVBlfwQAcyiqxaGL8K?=
 =?iso-8859-1?Q?GuaQ+g4ueLa8GdEXgq5cKkrbi1qI/FmBBcOMj8sqyAC8utYB4YDp7QwqF1?=
 =?iso-8859-1?Q?RnxiaLeXaNjEUJ7V0wP7+P5tDI64SXCyhNYGNlvWbbLUnEswlVyvSWcwq2?=
 =?iso-8859-1?Q?7pwSUlt9U9yHcRLKVDmCEKQyl2/TGm81rVaodWFFk2M/A5jpQlQ/Rt4JxB?=
 =?iso-8859-1?Q?zhyQbkg+pVZ8zFe17H31t0DERWzZ7PZz5SzyZGUVRhLURzRXagnAMfzijp?=
 =?iso-8859-1?Q?x5XeWwNBNeU9U1o1S3dogwAumPOiBPjJn/CYQ0wr+Bp/iyAVM2x5PiHXFz?=
 =?iso-8859-1?Q?SgS2uQDkmDC4nw+3jdG9w8wFw48Pn8brdVXVo3idEz07qGs4eEm064Z0Bp?=
 =?iso-8859-1?Q?vGYO6CmuYr/w1QZrV81p+LZwlAfsGKR0Q3Zf/cVizUXbKlyAT6lDQcOrN3?=
 =?iso-8859-1?Q?Sm9/XeGWgczn6a2Nc1kJ5Grw+Bq6PGeR+ir4MNNA/1zePXO+NtB9zL9R8j?=
 =?iso-8859-1?Q?zDT6T8UU/14UCgVpWNiIPsRroozHXHmFOxuRTyN0WmyNwy6dMg3/hzhatW?=
 =?iso-8859-1?Q?loDAB0tPixASSwZWGfxumg3xFiguRBfVS/8CKN0RnE0D3cFnn5xn8MyXBz?=
 =?iso-8859-1?Q?Bez0Mh5Ra1jD5nedQ1k9zq9nAll5pkIhel+4/GjHa0HbciRoqAXboLj3A5?=
 =?iso-8859-1?Q?YR4pXrk1WAAY9pYroz21+vZ8t3bWP7FlMlT+nAzfa7Z+fQnMhuNhVY+06l?=
 =?iso-8859-1?Q?3T2zRogk0CDXEiIdatAYzbsmWR0Jysu0cBJm78WgGlRWphEuTVDAg/LWs3?=
 =?iso-8859-1?Q?s7gmaKaVjEGmv6gmzj25K9lCPbqVhPQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f473c2-bf63-4ef3-583b-08da53c729d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:48.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p9cAmSV/AdquFc3S5qi1ScaBr8z7vBtKwpkapYpT7kT+0KqB0KFcQifrgaBZAuPZwv3wPDNa9r8ZJcCLn+3x3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3074
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=985
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: WSGhUdYJz93crvT0WCBX9Ls5V8uqA5c0
X-Proofpoint-ORIG-GUID: WSGhUdYJz93crvT0WCBX9Ls5V8uqA5c0
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

kmem_cache_set_non_kernel() is a mechanism to allow a certain number of
kmem_cache_alloc requests to succeed even when GFP_KERNEL is not set in
the flags.  This functionality allows for testing different paths though
the code.

Link: https://lkml.kernel.org/r/20220504010716.661115-5-Liam.Howlett@oracle=
.com
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
