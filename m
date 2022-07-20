Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF49657ADAC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbiGTCSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238774AbiGTCRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:17:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A39A47BB1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:17:52 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0mq6V017914;
        Wed, 20 Jul 2022 02:17:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NgDCkHFnu1X90UETZOOKf916fjPinMgGhhoyEGzlRL0=;
 b=1RqBk2OCOgFr/r7S+VPS2NMbI3thduV7uGhrPU4qI+s/RD+wcdqn4CPXh4tTcLjoQMtx
 1iP1ijma2q1J4nCCnYs4p4toIm0GTeuM+WLODA1oGbDhs5siCdpiuNsWpfe1YRrND4kT
 NfPVTLNGQH7rmdpIB8iKeDl8L2fCPzQ38Ls6YZPglk8OSplIFNVbTLEoV6SiQG6U1ree
 sYJDht0Fkm4j4oRqjMarFOHrj9o7hOZsGE+UpWRVYzvkANhyJWQ1jP7y3vbzOQFk4B4d
 YqicXBZGZHXwC+X+5DBkNkSD3IeLG4e2F6RS+m3WoomZNINeb72HTtdwOuNkqe3oUTkw jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107st-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:45 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0rIv4002688;
        Wed, 20 Jul 2022 02:17:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnukc-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=girDvb4UoYqAVwfwmU2l9UyXqdvgU8Mane+7ohM33/xB/T1YjobdJHsf1pIWBIhZecd9lBAqAmvl8+APDSYaFSqWZlCXNgfS4LOVln1X8ZzI2aizt92qWzNB/qTvAxHZ3Nc4c+vIJt8c1o9nsFNn5pPZ9SGqtZjlNDt1bl4B3NkAhrUixfSh8sbHQXZz/XlSb0pLH5I2N9hcje/DYPbh76Pn6WiR1IXl+C46mt1xE8Tr9Wot7bVTFGPLy1EV89M3v5Vm06IUFbZNU1uevmbEra0ST2kI/1QHictdVJP6bgkoRYXBIgQ+7HFYOEUtpuqB+bbO18qrq8LxrtDdV0Ehqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgDCkHFnu1X90UETZOOKf916fjPinMgGhhoyEGzlRL0=;
 b=Q5x9WWXGMSxaPaIKNEnPpRHDMjZIfEdLsw6d/3DNPkmAW4r7w12oRJ8/wncghIXvqdy8qKI0lES4oowRwj/IEXQTaTTqtYTkpQ1EYnYUlc5PmC3oeXciDu03hR6VNDWe1IzH8UX6hQhpPVvilYz273F+U5qfq3rsNNkNMjaL1FQFPYuGkkrz3PXzZY/NkP1lQVhyishlY4IoYlIwzuSGNYQP2e/9R/IW0VTs70G/RybemITsLQ59iXyRcBrOI7/lPTYEJvZ5mjB0eGpi6lCUtH4feY6ghRFWcKfH8AVs8Grqh2oq/wY1Y8HY7JzhniYsxLVdi2ktVkEMSrEABND0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgDCkHFnu1X90UETZOOKf916fjPinMgGhhoyEGzlRL0=;
 b=CUHAycN1DVsHubU6ZEqaMjrV8Ps9MEL7v/g4FNEO7Xu18Uq7GMqmEz5G+qQAW9fhgfFTaC6jovjXhz2qKnfPzHP7IBApwqsjOzsyjhzUEjwz/M/sea2Cw/T0MOAG0X7LnkKw4mg1UYNoylYTaR4cbWHR7pMHWuSmva0acuHinp8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2889.namprd10.prod.outlook.com (2603:10b6:5:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 02:17:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 05/69] radix tree test suite: add support for slab bulk
 APIs
Thread-Topic: [PATCH v12 05/69] radix tree test suite: add support for slab
 bulk APIs
Thread-Index: AQHYm97jKvIH9gXk6U6E0WbvNIWVIQ==
Date:   Wed, 20 Jul 2022 02:17:40 +0000
Message-ID: <20220720021727.17018-6-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2cab8807-ceaa-4dee-5693-08da69f60641
x-ms-traffictypediagnostic: DM6PR10MB2889:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wuB7P6O4zB3EadGbb89/h0G0Fh0JRaNXlnVmmWiELj4uq+g9eGv5uihcX0owbyb0D2o7WomWzUJdeYJ873Dak/JHfFr4Y1lJFpP24FbbYW9Emy96hIo+4pr1cIAbTgmlRrM7Q5wbVUaqJILblkl3a2zWMIffxueESHnpFlyrnaUeKNj6PCcmdlSzI74lf88w5mlgbrctwRHJk9QWosSfu0ppLyiQIziQEhLrDx50DGPnrZ9dpsbWpC01LloXZu7qAc37Le5+oCrxxsa7SPlPKk2rFbu0ilMY5iA6JQXBNh90jWBNoL9mT3DofUCvLLB7yKduZ9R/+LAoGClNlclLhgLfSHq6amyCCf6vjgmQgzdpw6lSNFe80dVlE1Y7bP9G8f89nsKvld7TLToZ0/apznIXQ/vlwjSTXr7A1GfXqp4Nuc4SovDoOEJQ2n1gbv4ya4V71j2aH5wNvSWKiCxbnWKna7NfgX2X2yZiijRPtBQWopLqBtAItKt1bnhXM0mCHCc8C0U8+pF0SXqCdrL1xiykvXGNgkCkxBNFFaCAHC9KaCK47bGxV+lh6VblSWHZeHq5cv+qehg588Le7x9XcfTnZzrerFLvwmDWv+rHbdhp27YcAwS8npXjLHZ3X2DohR28F+Bu8Vz0BaH67VVqgsyCn504ytD6iawKX4nosBdwBQG30GfqnzpGGz15OFZi132cZQqFyWpblCjVN58FPSY/RsJU4sZN/a3ZlFtSFDetQjxhnEWqUuLd3oeBXZnzbosELR/rJXFmrl8Qc5wOu4VegVTHimrArcXMr7YGlPB/0fHd28mZczvqWqzc+IWWZCA1KZM4o08LfyeIz/gxVPjXQxjeG4CIhU2C/nkYAza9FsiOYXtOoY5ZFzobEF3h
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(8936002)(5660300002)(76116006)(44832011)(64756008)(66476007)(66446008)(66946007)(66556008)(8676002)(4326008)(2906002)(91956017)(122000001)(38100700002)(86362001)(38070700005)(6486002)(966005)(36756003)(71200400001)(478600001)(41300700001)(83380400001)(316002)(110136005)(186003)(6512007)(26005)(6506007)(2616005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ywtJLOxyetZ2JWC8Y5jHRoYje/XMrkSouaWAc0XyjbxxBbjBzVGsEynvNo?=
 =?iso-8859-1?Q?xnml2FiBSvIywrXv40/bpSp+J+wo6DIVNjonZu8zfkn5SzpJEc+d6qhA1g?=
 =?iso-8859-1?Q?YVeWcjGmCzX8Z7JdbjM2WSEZG5vSxQUjOwLNmuR7d0V9PSCOy8b/nClJl/?=
 =?iso-8859-1?Q?nsO91hdlK0zCsF2nf4mJVKv3QimjIdui2R/BL0puvNk68TIExZm9ekcSwX?=
 =?iso-8859-1?Q?7NERhu3N5OlrK0Pddbt//m0hrOuUjdyAH60VALua1JQYMuqH8y0HCsH7Uf?=
 =?iso-8859-1?Q?nDtppyfZ3F6a/sgSk/drCEYIXIqTK3sVVN+FYYq1L9FZ0e5V2FH5GJl2+Y?=
 =?iso-8859-1?Q?qlW+uFWn48r2DeXmESGww0FezydsH6zCWIOIcYl5MdaSg71kmh2BshW7Oo?=
 =?iso-8859-1?Q?J3yiqWd/aXtKLIV5o+ALtnYTCg6MT71gc6Obdh83x17cSgDTG9WrwdW7Nz?=
 =?iso-8859-1?Q?kCaXwt9uAWvx9cY1IetWGXAzulTLvLzTUyVuaoQNxZG+OGuK+Ps6KQA2NR?=
 =?iso-8859-1?Q?d0hB2mXlqf3YxFTVUK2ASZUDg4Ec5yquuM9bmtzmSLvgYDQQk3LA+mEgWS?=
 =?iso-8859-1?Q?H7tw6HBLCwUAdk0s0VAOe1X/K5t2pVNHHNYMl+ak5XOMroNDgrbUnKinwM?=
 =?iso-8859-1?Q?pxlqQ7EMrsTr6IsrPdN0tm3E/eFNf+/OTYRuT/rzulp8HyIjAHReyAPMsh?=
 =?iso-8859-1?Q?Q0ifLRNOy7jBSkpETSIOBEsLN4KJo7IWkKlB3UoeVAESJUpNJ5lI2knQb+?=
 =?iso-8859-1?Q?nn9IQu/bjJx9U7TIkB/0kqn5oFCpQYr+l753WYRzJY2cWO0QY3ZnQl4XAK?=
 =?iso-8859-1?Q?AsmmpKroXAnVHLSBhimil+V5YC2+hdfnKCdKancWY5q+xqO2bLBn05PlQ2?=
 =?iso-8859-1?Q?5oLD+HQM1bZKULJjBVCqrPhKDvjAswrwPSK77ofgLICOxn+HS7eXgNzmlN?=
 =?iso-8859-1?Q?RX+e3oWKpfRkcEAN0YUDqZVir6XeAi96Vnw7UqPyjj0gQ+F6G3xvjWNaVx?=
 =?iso-8859-1?Q?YxwesFtzXOXJw5VK5ZRFbaHRTiUrigG9p0Rsb94AI41xaW9SSydtON9Blx?=
 =?iso-8859-1?Q?/Sf+Q1GRlNJ9J4GO3819ZL0Xxmk8kTj8smpXkvwyuPabOk+UYMDGsVa3ot?=
 =?iso-8859-1?Q?2vFWUr8++AtnLbLbJethZRJaVaLzp9qAv11ERRm8XIGatBrIbjmdYCgnyM?=
 =?iso-8859-1?Q?31gUL2ONpRqpHawF4D+vv7w7zs8YdB7c+YMLVu5FY+C7sqQKxRse2t2biz?=
 =?iso-8859-1?Q?1VWhoYxEqLJdW4t0yfIEezL6laWoGdA9hwGn80w5GXQog08pzKZQJuRiHz?=
 =?iso-8859-1?Q?Mdf+TKRglOym36LaNb3do/SoRXHsyeCqTaoIMrH//KT/ieB7TT43FU7Al5?=
 =?iso-8859-1?Q?mmx53dfN++Za/AINOvzywFBw65+ZPh6n8CAEmrYjdaH5dxmnsa/FLT9r3Z?=
 =?iso-8859-1?Q?rZ9dG0nL4vGwuz3f7TFvmxcKMnkNsZfN+GXcnwYeOfvvjr6yGlWwC8OU+v?=
 =?iso-8859-1?Q?tC/XG/OFAZ+IiAc+rmICd8ilE0aZmj9sttRSq3A1hE2br2IIMqcu4/muqo?=
 =?iso-8859-1?Q?J3QWp/XOFxy/eCRIQXtDnHaBTrk6Fw9oxHXRJ3zBW2pKsi2p6lLdMx34C+?=
 =?iso-8859-1?Q?YNa1Y02TpnUPROzMaQfGXoZiYGzVSg7vnrjush+DV73bQz3M9bOMD0fQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cab8807-ceaa-4dee-5693-08da69f60641
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:40.7132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hpq5e02b+3X/PDck8IOqdwjvLDCDlCgGdCLikcohAP04ohGIYlflJvhGH8LnaYuczYgdckZ6s+zg1yEz6jZSYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: e64JhtAhE9LGEVw5ZyTxFLvUCwYvXk_M
X-Proofpoint-ORIG-GUID: e64JhtAhE9LGEVw5ZyTxFLvUCwYvXk_M
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

Add support for kmem_cache_free_bulk() and kmem_cache_alloc_bulk() to the
radix tree test suite.

Link: https://lkml.kernel.org/r/20220504010716.661115-7-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-6-Liam.Howlett@oracl=
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
