Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDF159C212
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235871AbiHVPDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235834AbiHVPDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CAC37FB6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpjhw016581;
        Mon, 22 Aug 2022 15:02:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=1NvKdlaM9pkdeX9ZSEFjyLHZ0i+lXWP69aKcSonyOtyikE6AXys+4J1OA5wuHzY84hiS
 Ghgi+1Sy3S/89D9SZ1d6xM0tM/YhApTr2QqAp/CipV+hsYadglkz6YumjfR1IXgfQdQ/
 waMDr4pt0i5Qx9/7LwOz9IcrYUdn+i4PYBefwuV0dyCbAhx1XTGQh28BQt1RmzQXrYs4
 7dkiD54LePUtzH7iq8qnX3uj/v9wnsfViyPf7IEzMs2y2cQSqCqHMirc4JQKdwFn4cDz
 RvEpHFMQAVEd92ofgRLGks+YHOwcCOqm8v8l92asaBmgbWID4o4jg7LzkLn4Y3e835Uy NA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx68144-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:02:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NjN031906;
        Mon, 22 Aug 2022 15:02:56 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd33u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:02:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5/5lzMx8AnE9TZRvxe+UNqOGuAasodsy/GMdT1aIg4OjXFtJNrWVNyHxRz/s6hR9AefU2ItZAMRt9Q7HaMIRz8W6SxYGjf2/NZYlr2n9B+G2cxpJ3SHpsknjqA2yLOhKEub89HG/+Fkg99EEakXxbowq/obZ4MrRas1VDUgkyZQ5kgNkgeMEy5ZrGBliusZp2RF3RQr5SyCvSysG+keyvU0fiZK0cQ+KXtdZhtMk1Yxl4+SEkFJ07N1Umpa+NIftxDciRZ1Tvj+N21nwc3yQhxihm7QmdyYBbdl9oSE7Na4x+k1/MNkLwToknNYKZAJNA0gmAt7OS4x6iK/kUWtSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=ELJpuXMtUW945Hla713lZXODpHOzIKJ8q/Df3biuKtADtrWhpLeKl90/nCO0w0ZTg2c+pFFmkaTZay1xSXTefHukrrzKIgKeouKl16OuB1ES8fIZBQaUaChqyAzpprt6+l+m4fUTu5AIL2TQuq6XfWtP4JHYBSxXfhLKaVatIpJdTZmaj4lDKj76+iOtikN7/rPqAMBwFYpK9R2IWOODJne/K1PYSLAweGF62EAaL9Ta09UcAx5VgtvnxNDvduNYRVuucii8fkxGcigzilR0M2MT3xVPSd7lalmkSu7JtIkNNNUm+YgRgkYQdJTom7XB9nNDuXlacbcItFWhRgR9zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zdg9+sWoGZkw0EzPgXiv4utF7MHRTxU2EsKAJH1H/3U=;
 b=WKo/lyMcsPmw2DPGyDlGcbLfCZGVGog56FAEygEZH9vTT5o9Pz6kfmvpt8rWN/mSS+fM6PEuQvX5Is6eIw0ftR6MlDmLFbvSuTTuOgwGeRUlriDOEZhp5j8fzcc4WwtdDH/58fy9DOIn3hY2xzCOUdEkZ3JNUtSsFEuLTp/6Oao=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:02:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:02:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 04/70] radix tree test suite: add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v13 04/70] radix tree test suite: add allocation counts
 and size to kmem_cache
Thread-Index: AQHYtjgwv2OAyjxZpEef0hRr17O+6w==
Date:   Mon, 22 Aug 2022 15:02:25 +0000
Message-ID: <20220822150128.1562046-5-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29f4f1c1-6ad6-4e57-62ec-08da844f5dd9
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AVv1s63s4uPRPfb2QVgsqsbvQ09Bey6vvH+ycylOwHYDigYbSZKuqPeBXVPIsPfgZqWRFe31ngPDa1IaGbUiFIoOVyHF2hB6+g5enW516Q0csj6dnb7Wqg9qNiBXUObN86iSOKNbSqmlbEyv75THVWJJzeHzPD5+D/CGjrUdTSKoqgfR4xCDAsO1nJoBzmW/nhvThhWDCml4cZtsmJ8rTbsE0M3rLoQiuY1PEfKfsxMmbLdNSxg226/gBbiQ02ghfIqyDkNnTH7Z9kcsQOBmH5yLdYkDZrArXFMUI3+ljo1zol+GslT7IM5MpAxgJMbEZHYPimfNNYwiRaTJH89nRx/OSZydWlQjWqSnReILhcC69OBuvh6PV8SQhQq+I5dzT40B5es9mDrhAFpiJW6aoQYYApHY4YMApHH+9HyQM+uN4gKn+/DIYhO6MtxAAIvhAL4bcTgrvXbadqMe9ZAmlyUHBBC5QajAC6ED0ISBvQ51Qqz2Gtvp5PUJZb/U3LHDCNAotn9k8VLsgEfsGPVY+W4JUzbTqChUYCXwd+oQETrQ/wUpom1pK5aAXurCNBdx21ySX3e/7naOc2NjmkRGC3QG6Rzko7oIAMEOnn+0RwyKUPgiOo92mJIHljyLTnc+tJ9G7MDqegTkCn1V7o7xxXMNGtDOA2NZEMBgs+0kVY5CJux6o4IPMZawVrIvjotUnjIS6f/I8slmywPsbDBJoJlcNgK6FH73wfZ0jXSQtM3SmsCORwcu/wB0+oS1pvDG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?41laMsMfZWkGEarTR4JD+bYSxzhgd8t8IC0jLazA255omAugtyMK4o58xG?=
 =?iso-8859-1?Q?26XprUUtF+Lnm1DedDYfxxEIPDPiTZ3WHmSixeOHyvDUXFXtb8FiTk/t3y?=
 =?iso-8859-1?Q?sKLQKJxYuF8GkGNkkF2QMbgi8KPF3cDvREgwAQGouvLAg0WskAhjIudC0x?=
 =?iso-8859-1?Q?jOBzCLzSOitASbQqpWMVQRd16GKUTAb9vaYp/uUdU8MIUKRhkgmplrHdjF?=
 =?iso-8859-1?Q?5hWiOpTxy6ntffQCfzUug5SQcB4xTa1qrf/d/lEHX9NBPh2lZ3DBeNXBAc?=
 =?iso-8859-1?Q?XAFJxbsEJIoUN/yMs/p3v70G1WDWmRe6NxRBbT1AdAwe6aqfVrDZhUffGL?=
 =?iso-8859-1?Q?BKqngvcOZYol0DuzvscOw2wDlT8vTk/QNKVB+jTYTzqgblg7le3EG28xNC?=
 =?iso-8859-1?Q?ESL+Q4AlY04hy1qmeQHiFYl8Kdr0tq2/wKnbq/v7SJ7n10byqS1auWa8xT?=
 =?iso-8859-1?Q?9Tau/R2ekWb6VWiCkn+zPq/ZeFJCKGVazSicAA6B4IlifxtCvfSGBxunD+?=
 =?iso-8859-1?Q?nmwlHjSl6QhvCe5VUoE4cP6ccX6WCt/grNRpvTiC6H8FSTM/tA+a/QCM0/?=
 =?iso-8859-1?Q?yEBQ4p5pMhnxRaaFBFkvn0NWg115uRD07AwrErkb76HZEf1eiE00eEC9RM?=
 =?iso-8859-1?Q?oZOquflExXtv8a1FPuj26kFyIv5IRsqpS0Sd5fKA5Ngao3KykNdZGZTJQE?=
 =?iso-8859-1?Q?czPiGLB6ezenG+50JLXe1TXWuC492RxHikNJOL0aZaLGqc57ep+EjU/IWT?=
 =?iso-8859-1?Q?AIZTzH9kAUnLD8cZYLW0kLFTohTQK7+WmoB2yw9DWFwUmhM3z0lbc0hv3p?=
 =?iso-8859-1?Q?li17YzjgRkAkZ2n3pNrfhGQ74EzdJgQ3CXhJKey4qOCrDzmOrFNeFVTMtg?=
 =?iso-8859-1?Q?u53htq2SYTqvghfZ0akfYTl0/k5lgBGv4XV6g3w40cRQzlPBlEZZwpX11l?=
 =?iso-8859-1?Q?inspmTqg2ndDHxC0rPEXj8XVnq0ZDbqgK/8DHjOOEJU3cDC5/Xz0ULyPEr?=
 =?iso-8859-1?Q?QOT+XT4xYAY3IpEqXCsEUWqhESW7bL/NXbBN508U5GTVs5d72DUf1ZGC6Z?=
 =?iso-8859-1?Q?zjEWvvuJLwIWJDK97fdigc5qsFdFuL9dNozhuLxh0FH3Ic1xmfaTPEzMEY?=
 =?iso-8859-1?Q?mSIUCxTb7Ie0gO5PpEAKe4x8FW0oKb/WooswE/1g9XZ3WOtnDSi/K2QGyE?=
 =?iso-8859-1?Q?lnF8mybv48Q8FYvVcoP6jD2REOJbsl9TBoUA0gXQwdn8srZpNCLwn/uf90?=
 =?iso-8859-1?Q?gLT2/k7M4Ix5cNJMnzH/Z1sTBVXwanHgl1tpWa/dXmI8nDdSjBjym/HerS?=
 =?iso-8859-1?Q?3Ec10euI5uU1kJaStlP5s5dprn44PAEmdfLfGAOB97K7gLzv6mqTiGKmUG?=
 =?iso-8859-1?Q?Lz2cYq5lyPfn0cNWYXW8RICowwj48ShzOMbhirtV9KuILGjNveSn3O4oaf?=
 =?iso-8859-1?Q?XzrhwmKTP6W7Q02OANvQqzGaQvhsKJt8eEEoApmcFaT8cd+oFUSNADm4f7?=
 =?iso-8859-1?Q?Io+WqvmkQodZWUBHGkEEG4iNAAuGLXHO1/yvk5xPvzx4HABE6mrF6cU9cE?=
 =?iso-8859-1?Q?coJHF7VlagXg2r0uAzr6T4vEDZXQYJv8gReWHog6kRT6znj7lSaB9fHWFh?=
 =?iso-8859-1?Q?EeiGjw/DRUXQxF4DDoePgpnb53zfjBFv+6M1VNVUlM4+IGM8XKy4ZYxw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f4f1c1-6ad6-4e57-62ec-08da844f5dd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:02:25.9263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: et+3NO1i5HhoOM/NR5PFc9bxvRPNvL79I74nSHJlVEnJi71JfCACk5d4RmH8NfrVnqVE9+SCPwpmi/OUiqopGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: lKBfht-IaWR0pgq5REptXqwI9GeTVoO4
X-Proofpoint-GUID: lKBfht-IaWR0pgq5REptXqwI9GeTVoO4
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

Add functions to get the number of allocations, and total allocations from
a kmem_cache.  Also add a function to get the allocated size and a way to
zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
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
