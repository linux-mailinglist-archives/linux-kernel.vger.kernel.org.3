Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADA29553BD4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354365AbiFUUr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354308AbiFUUrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A7E286E3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LIvLki007514;
        Tue, 21 Jun 2022 20:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LfwO8QcltiaaMq0EN8lknen5lRwuW3vH0gYd9c+/gOA=;
 b=ywoU7/9Nm96h7KiuLEGOeybcWq0kGTEqRWLNt8Nbq1pBjMIpYb34Kf+rS+odCP4opyhX
 oegFa/DiLJ8oSt2VoVG+ydHUGt9y3R5+Ewoq2lzxBf6TfnritNeHP5dhAmz/FkMFcdNJ
 hBUN0JvkqAJCEnY9T0e9zpCGtKNurRGeppQHN40+rYwfvA/j/boeIMqruNjkH1D9wdX6
 oFe2DcJzJeAMmO4udPcRIkwVTpr1HpNcGNcsNe6w0cdEM7E0xliVzJHEcifLXSuTN3js
 FUd35U6xWa4pTExqj4XsLYkmSR7aXWI72jxsmphw011caR/+jYiRTCQk5+UMhCckZ4Lm fA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1xr6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:53 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeb6b010844;
        Tue, 21 Jun 2022 20:46:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3vkgjp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRfJiIY9Uakoo+JtB9RFyWZh3FS8meDXsBRqLqpQB/tdyGnK/CvWGtMK51V8C4AzVWYGJccncoClX6VtLVJUBBpBoZdJ10Jz4IY6r0Da362okiBxbaOXlcD1qZMjtqgfaUfmbjCSpe4AVgwPnzRx8VuT7AVREMaDlV52UaFTAWnybfguHxGFL4MRBcX5TKaF+HqQcPK+ANvUmGoGoO42VOHozrGKhlT+WvXTtwBJ/6iMvWXpkPBIQNa6uPDnkVREoZrAHIk5OdEQ/l9YGVelSI3TILdEBFCW76fPU63mZzXCklyFpspj7uFGwU4tdnlkwAXEkxTdZbp8+Rzwdvjv4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfwO8QcltiaaMq0EN8lknen5lRwuW3vH0gYd9c+/gOA=;
 b=Vt87ogMJO9Adwj5uqPQ69NkY5MLRl0L+RnrFoSxAzWok/efTzXjQk7cGuVuGshKz3vhN5kAVK5Ota8V95c0S4eUf4bg385DhrMiGlmFkWvZxFub5Pl3gs++2XDY21VWArjdXKic68C9vRHMfINeGoFZll77aQXODE/ZHIG9u9f3AhZoDjnbsT44MqrR5ymSI4bLBk1j+Cc/LQVkYB2mf4fs1EuqNKmpjYWXigs3H47Dj39mJUAtc1BGA5ypEaKgMjRbktpMrH8yfOr77NDeJe18qR+6SLTR7dhlHmt/TnOEbvr9vGId+qRs9WUbpcSEMh+Zt0GZxahITPhlkKc4Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfwO8QcltiaaMq0EN8lknen5lRwuW3vH0gYd9c+/gOA=;
 b=NAPdQUTq2REimHnNziSN1MDQisi2PPqPAQYsNzUojxsUCEePr4xPub+0VI1yIz3DT3z9jwUMf0TDCpkQu+EtbR7bXlt8gNGQXUU62AwOhrIF0TaTppNCLbeHfFv/KbmJJoAf2S34n6Xuprke3GrD0kViFbSJ1jQNWVsBBKZ/yvA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB3074.namprd10.prod.outlook.com (2603:10b6:208:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:46:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:46:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 05/69] radix tree test suite: add support for slab bulk
 APIs
Thread-Topic: [PATCH v10 05/69] radix tree test suite: add support for slab
 bulk APIs
Thread-Index: AQHYhbAHVW8soav6GUSOJoDTfQbtPQ==
Date:   Tue, 21 Jun 2022 20:46:49 +0000
Message-ID: <20220621204632.3370049-6-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 087a3a73-a87f-4761-257d-08da53c72a8a
x-ms-traffictypediagnostic: BL0PR10MB3074:EE_
x-microsoft-antispam-prvs: <BL0PR10MB3074C34C02DEFA30DFCAD86AFDB39@BL0PR10MB3074.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ry3lB0Afk2zfml8S27oQZZT0Yxf95wq1/3uTWGh3A6Ym5APndt4dCwU7f2coAy1kj0uNiLbIiige/XltoWXGaBPROwOXwYVQhr/9qqDKHKl5x6vVTNI9JQjQsnQMJf3dLsYzdJ5wTY3brNg2/UPZ940Tbr5v7qxa0gWZO6VrVKvb3hj1ZVz1P9Z3BU6j6RNk6LwTmr4xrMI20s4sLmN9V+mHQj7qnW/+AOkLfYN4kH8Azg3ZXW09nMxRBAWQdwDp3jbs5EHzkHSWchMqbsLrqEFmoUYkLjCQNT6hWydbrj+IiTTP6QDjwJ/ThFCXbanzh93YAJs32R4ukxm0fvYsHKAnnuelacldfz4jMb7OaRrZAvwho8ibpP/COeJTu8IUdtaOK6iA0aiasiWkEEcq3JgVESORh+zXgr5fhQfnYcgHfarRfZgrerucR7oF3gKS68OgwdHm1wDNewZo0TkcrskOkdkQ4JV/aVk5Q7AzcZP9Ol3kuHHYjFa/HGOAs8cRd0mUs6qSkIDIhgvmCyJwR98EIqGuezo3KVi8ezwWi47YH43IWyzyrLoETCnKLN2FGTUJyQDpGrFj6sp0AouuyDJ5Z+RYW6/VmEMNljzIY0jvKI04JZElp5Tw6asffvnxKdXRTUsAeCwL0l24xRShIdv4xuQDhbTXS3QB7u5yTe0HE077gHnC4GgbmMafYuauHK77zwwI6cmPaKpseF76/crskcEiBs5ViHM88sDyRCye0NM/dUhjxJ711PeosVYL+0Jx94pwHRA4xR/rpukOWhzCzN6HQtkIlnrJNkqikcU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(2616005)(186003)(6506007)(71200400001)(26005)(66476007)(8676002)(38070700005)(1076003)(41300700001)(86362001)(83380400001)(36756003)(2906002)(122000001)(6512007)(966005)(66946007)(478600001)(110136005)(76116006)(8936002)(38100700002)(66556008)(64756008)(44832011)(91956017)(316002)(6486002)(66446008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cQUWFpO5F1YeuctS9wvBMtrokdQ2DgKclugrmsgkPKOElckkq9hgWtz4yr?=
 =?iso-8859-1?Q?i7OWI8XVCJqgMp5Y0/TmUQGyC3A9UNmEW07WKYC6+LLjKgLn0g7I6x4oX7?=
 =?iso-8859-1?Q?6iVTsCetRsn0OhjoJrMuVDcf31qdXlz0Roha6PcDe5BAQuwrjZZAdZwac5?=
 =?iso-8859-1?Q?8LCwyuADa/o3arnamlr8pM5AUnDQOtBjbsx1WR85noqw/C8oLOdUXjrhdf?=
 =?iso-8859-1?Q?FhHJGKoGgXqoDy3u1TXEezWuxjdOTdSxRTCA780GOjRNVIIpgzoDEywp/B?=
 =?iso-8859-1?Q?9fF0ziwZACIHbf2F/AnqhsTqgVwCfe1ThtGGvFjcdMdNiPZ8zor/Z5zmLG?=
 =?iso-8859-1?Q?lMEQXw5l66k1Ml6tTc60JxSh3y/OmkUZ0sgsnRr+mdj3wM607oUgWPfIxi?=
 =?iso-8859-1?Q?cu7eK1qS0PLXAODIuy64NolllJ7HTr+EczHu91Fkw07TTnoOAAKnEZhISn?=
 =?iso-8859-1?Q?guYaO/F/a8xATbNO4NCHg3hi/piycecaaXEDv+3cut8Sj3fgVR2LaHwvBm?=
 =?iso-8859-1?Q?lVw5DqXpgSMUNE093JmGvjve2DPiDT6aJ+xuOU4Q8MWIl9pB2e3b9NiJJO?=
 =?iso-8859-1?Q?qNh0j4VZGQdqQhBtGqT7zNvojHrxbQGNUe+o/kk6iM8KsqJZeJZH+FtgJ1?=
 =?iso-8859-1?Q?GjNlKT0miWhH3tOBUq5e282S60KezqOGAPlmZLVBCFm1NKrM4fbLNOv/cI?=
 =?iso-8859-1?Q?nmMdqocT1lblHmReDPYjjF4A0us40etId1kpSCFgyH4Tgphy8wJlzVB41T?=
 =?iso-8859-1?Q?mIiYaMSzuT+06nVaVjQOaxyVmB0/JBv248PC+UuAq34uYDMdCy8qJ98ikE?=
 =?iso-8859-1?Q?QtsLt0uLi/80/4WpJaNYpqSXqZ6cT/0ojrmLlM4qaiax5pyvpJ26hcKncN?=
 =?iso-8859-1?Q?2bfvtYOXzcdQvxjQdkQhq8n3ikXQvjRYKT+0ZLzqSEKmufuFNQWzob48pP?=
 =?iso-8859-1?Q?MKnRsQVut4TIaqleBKY1tIXalX6IprogrAM4D6UmposZ9MUa89Jsfnc2yA?=
 =?iso-8859-1?Q?7/a6NB4C+6CgNVe2nrTGOS67B9nSpOK00pRDpI3tWQO+GCFcJddibCLUdH?=
 =?iso-8859-1?Q?7+AmH6LjrdDoDbiBnqS6ts/GE6c0w5eUKZ/fOc7zvaYyGeUeghZdy6hNLj?=
 =?iso-8859-1?Q?JYaz3PBwWkxcK+CDRUmE9UnYiTVT5pHz9SHxmXHQCXhRxDklpqkJvpnqZm?=
 =?iso-8859-1?Q?W7+T4hEnDoirFCP0Lbua5QzxCBdbloeadS47bCdi+Y3WPzEIBbK46c7g26?=
 =?iso-8859-1?Q?QPYUZGSmKBre7PmmBFD+VhOygOvNtGw/H1dSUSyC8uL8spq5qyBWNtYGGs?=
 =?iso-8859-1?Q?LYncA70amoAJ6oiVKxjB+4w8hIsL+VgOMjZA86P1L81gMq0OsdxrS8JgHt?=
 =?iso-8859-1?Q?tR5jxTGWykwA63fFkkbN5xsVfLX2t7cIQiVQFBGioZfO3J3k4RIok5csWd?=
 =?iso-8859-1?Q?WVAzUdXNJrSdJyWhDWBxN5XxKE7vwltbGt7PR3DstwnhhIipzNfYyJJBbU?=
 =?iso-8859-1?Q?Jrlzjgvl1UoiBJv4zzo+4BbHLs1Z4no3qUNdoBL97VbAKRK+IsBvo8blTr?=
 =?iso-8859-1?Q?LsKCB26w58PgM9qw8drm4XP4bzQssvS1CH1rd2Ez7mS4psvU4k4Vtd2BnN?=
 =?iso-8859-1?Q?FjIsGRb2cIfUMG3Y2TXatuy5eFo7Zwa/MD+mT5VlS4PSpXV9Fl61Z5jAkr?=
 =?iso-8859-1?Q?/TeymtWBCVMI8smSta7aPeL5RxgUuvaF1PIadrOQatEPk246jgww6WJtSt?=
 =?iso-8859-1?Q?QvpQ6fz6le6nVwxiMTJJz3z/zJQy3b92Uju1++YDKx9DpM+JrCOBF5Sfdv?=
 =?iso-8859-1?Q?c/DSirPsFAUXXmXtVhmBNQf1CBxodyo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087a3a73-a87f-4761-257d-08da53c72a8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:49.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CXnjo3S0Za14AVYFfTuhN192GzC3ivounG4IySDDOSLKmtH6b1bpo9n1s5Ld8vuDANfspJSfuW8dw+/l/LtwWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3074
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: MJg_Ya8G64Wax4i6iAw06v0P17CB3Lpz
X-Proofpoint-ORIG-GUID: MJg_Ya8G64Wax4i6iAw06v0P17CB3Lpz
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

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to the
radix tree test suite.

Link: https://lkml.kernel.org/r/20220504010716.661115-7-Liam.Howlett@oracle=
.com
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
 tools/include/linux/slab.h       |   4 ++
 tools/testing/radix-tree/linux.c | 118 ++++++++++++++++++++++++++++++-
 2 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index 0616409513eb..311759ea25e9 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -41,4 +41,8 @@ struct kmem_cache *kmem_cache_create(const char *name, un=
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
index f20529ae4dbe..2048d12c31df 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -93,14 +93,13 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, s=
truct list_lru *lru,
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
@@ -110,9 +109,80 @@ void kmem_cache_free(struct kmem_cache *cachep, void *=
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
@@ -130,3 +200,47 @@ kmem_cache_create(const char *name, unsigned int size,=
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
