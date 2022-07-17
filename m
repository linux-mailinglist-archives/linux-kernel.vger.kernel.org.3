Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BF0577335
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbiGQCqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbiGQCqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D198193F8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:47 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8rqt005737;
        Sun, 17 Jul 2022 02:46:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NgDCkHFnu1X90UETZOOKf916fjPinMgGhhoyEGzlRL0=;
 b=kfSm8dMP6NtGQFS1iGOWr6SFVMJwJCBNybwHhDYdjqBGvYiZNTYpfrflowZMcC5OKNmS
 NC7IEOxYdUCOwtCLXbDZoRy5N5e9S/AmvdNDHUpM6E+iyceLX7HgHj0puhjkzw3XhTBW
 Wlsw/tVJq/V0zEmODVvJhlG08WqZI+Mbb3tu7wNOcGZ7J3FkwQXYTHCVJT1uPsf0DXqm
 0BRHoDZ6Lp/bihTonq/yKThgHHa+1qEKehmkT+Bcn3FV2r1BcsB3vph0PVmMBFi27ruu
 TLpJb8pej7gfl6O+EEHfxb4YtHnJ7Kib3yzbLvH+MERXjedBBqZLO5H7fxw9O4zQsPSH mw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3EF005901;
        Sun, 17 Jul 2022 02:46:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d7y0-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V8YEIsakmZfAv2soTPspa7LXSD2vBd6grf5CqNCYVPxOlLIrwd1fmCZnppCQ+fjYGSjsxcjA0wDnOQERCdlsO19JTJ7E4vDdS1TEsjW/b9k1FZzgTLKwozKhPjfysDAga+ogqvcW3md7mEBrXO2aNDddzrbppeDySMVt+P2/zDGGSM98ke2R1hvnVMqnEYBrWKItz6nGLoa4YAUveKweJqqpqPc/MBrosYQTcKgoMlYgcsyhkfuLN0mKUbHi2t3IE6p4yKQsY8Ln1M/SsRLWuVWv51nL9UpF78N/HleN4DbyoMC5OLEkdmTYTWf6CAhCFJHXPBPId28lBHtxBV4Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgDCkHFnu1X90UETZOOKf916fjPinMgGhhoyEGzlRL0=;
 b=aeOptOTpdbAqfJq9yUm6tNS+jYVLnAOBPaX4RYIru2OluCfU5vPQGhIemlmMq0u4tCnbLLQhC3nUvT7th7uDVYVJSCBpUpmoSUa1Es/W1lihD6+89onUmZJugYUgf8uNKG/sVl+YW/Fw3WTDjYL693oRUIdUsraxD0pVHZaiQK0FXLEbVkcroMYmbmblllYLAJ+2WUazqxuorStA+wJ8V/4CyRCRo3f5r+EWbPY1OK25uaCcj8M6Rog+Yi+50MUtQZJxPL99/mEhrC4D+WI7F1MPk8i+gtfpPKEyYdMmEO50rmQboea7EV1vVHOljxrYWxOH61LkB6Sxxu3nPDwl7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgDCkHFnu1X90UETZOOKf916fjPinMgGhhoyEGzlRL0=;
 b=zHyKZo+sQ+Axma3lGb8ky7D9GC+MeBgEyIcb+nD5AXUq73spM9G6MMAjbeJizuqqyfPPvi8DUe1Q+9d+EPfWU4IYeXU1C/pfyYOy4TJVw45JvA8yel4Xyeo4qO6Yin9+3guygdOmZbVeFqqghgrqrfWE1JXvE3V7mvuheLVF2EQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN6PR1001MB2369.namprd10.prod.outlook.com (2603:10b6:405:30::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Sun, 17 Jul
 2022 02:46:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 05/69] radix tree test suite: add support for slab bulk
 APIs
Thread-Topic: [PATCH v11 05/69] radix tree test suite: add support for slab
 bulk APIs
Thread-Index: AQHYmYdtD2flDxRwgEyEpF6f5TXMLA==
Date:   Sun, 17 Jul 2022 02:46:34 +0000
Message-ID: <20220717024615.2106835-6-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f48678fd-c4c6-47cf-0fbf-08da679e9083
x-ms-traffictypediagnostic: BN6PR1001MB2369:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jQA8qEooOk2LRo9IdVbaETqJsixfcA60Qt9PJSEemBVnGkyKqlHkM94dCqCVwO1viOKJarX9WdgB0qREY0sRpfd096PIvZusMm5bWQZVZWu/HIoOyRwK8iR96deDybcjDfpqkhd+U/1cmKf1bQ3viS8ldEyYDLd4nA3s4unqxz8h5dS94QgHCvy16zPTwuGlXt7o9sLfuzOq3kfhz4Z+3hSEoZw7f5Sa3pgomg2l0fJVzNAdG+0KdvCsmjTiY0BGceq55hKUzIYqF8rlAvCol2uYd8Vvh88qtV+teaDjR/6UmWPekG36e3dFaaORa84XWSP/Vn86BUfdmmvr9jOKIX5L+kuhTLA8qR4y3U/949KsV5rNOBBQbJ1FXF5/CAzQ70+jLsWYCBmBEcJFO/xBRteL5nBtg8VHj3TA9hnRvFWAO0jGddQfjxlM65Wq+S5NvH17+ReI58JV7v69TxMeITnr2mcIi4eBlGFUjqawuKm5T9ESVfHQu9fN5xWsGE5eRHl8BlQa1xBEn+Q+/LKUQrhXDBsv+aJqfjDdiLw+OKv537sMzpCoYoae8nV/5k/ThEPkAS7aBy9nxdDj5gbBDGWADxoGVyD9wNgCYfOHE2eJ7CLfIoOuNcNsdGNqQ/Yu4NFzJqejWvdGn/ojxu++eCj/E52HAmIlhloscg/fqV/MwDzTln5aX4+d2ZWmasZT73PkSh16dfUTlqzbpwKpmiCLVwbVfL0as0DQ/tiI6pCWkk25PN1myKbMI3Ztzyh1MaqsKrA87UrZydlbJyCEi/Qs380hvFU3+S2GACTUyrv50YNl7IhqyK82uNkXYlG5GARhw4L7zG2Aw88jp47gtaajkBWJJ7WJ+4P4DN+m+NIeY5QIZ/INCXyaK6wHI0Ha8NbCeD6FZ4VX5GxDbYfIBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(396003)(376002)(39860400002)(346002)(1076003)(6486002)(966005)(71200400001)(186003)(478600001)(38070700005)(6512007)(76116006)(6506007)(2616005)(41300700001)(26005)(122000001)(38100700002)(83380400001)(66946007)(36756003)(8936002)(2906002)(5660300002)(44832011)(110136005)(316002)(86362001)(8676002)(66476007)(66556008)(66446008)(64756008)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0VknF8MOnB6Anjpeq4cbSbvL0IB/KysAL2JBCx31n3s+50rR6kvAb9i81h?=
 =?iso-8859-1?Q?cJxSRJBNairLMBt9ZBE1d78dQmavU6mHswYmupnEnFA1y3xqfRNwm9YDg2?=
 =?iso-8859-1?Q?Vg6PI27q0twStLE67h/lt19+JdNDgOxEOs9iUrAcIXmSFdJ8jIZIXlQf1n?=
 =?iso-8859-1?Q?3+W8kyAs3L0E0l+PDun1sbQmOSOe1VID8Pf4wjSc/YU/7qpAgrmI38l+Gz?=
 =?iso-8859-1?Q?43oZlwBWfSbkTgpMBkPYXPMm7wjVyfnUrZXwxF5h9bpyLyYKXjG8GrGdxA?=
 =?iso-8859-1?Q?nBPbp2lDcoB917pSe0lg3LsxjLgoM1VG8mXGsBh+9jWvWB/Sj9H6D5u2aB?=
 =?iso-8859-1?Q?c9lb1fYRBHJARlNBvuB9BAMUA4b0R/+EhfDmokzJe+e4dG1GK5T8MVkjoV?=
 =?iso-8859-1?Q?2YUiePZ6ElQ/rw28HJmVGtHckb/l3WWaDnf2++E7gMY2Hda6cFPGkux0qQ?=
 =?iso-8859-1?Q?XA4UVcRHYYIwyhy8RW84FGhxmwHuLwpwqBQiPLpXA7u5I4zQ7ssA2EysHW?=
 =?iso-8859-1?Q?FlOIt+DaOQBBA+dVxt1z8gQwR3QCrCQHvykz55/kIhgYzpadMawi4k/mbZ?=
 =?iso-8859-1?Q?f9Tmk79eZDZBuJb4ZsKfFqv48R3wpVNbsYRnD/lQbhjD4nDKDb7bzN9UV7?=
 =?iso-8859-1?Q?G+8VJHPuArPzXyaSes9lzc2Yj6KXt94g0a4s912ZI+r42DGc7RC89W5n8M?=
 =?iso-8859-1?Q?rXZfyGfPAwb3CxHiIL/akOeQhyY4NTa4fU/ehAuoSWW7CksLBC+onXNSbg?=
 =?iso-8859-1?Q?IkiA3A6CBgH/d8U0Rv6YsJvKxqts6EUxqou0exb9aF3yatSKOA4PPbC7lB?=
 =?iso-8859-1?Q?28XQsJJ9CgzByVU5HXCQcrAjwqIZNwou4DI1N/kAWIktYpYCC6OHy7rse4?=
 =?iso-8859-1?Q?c3tri3DwFQOtf/xyDTt4LXsxBqQZa1aQWGYjYUA+yGo99EzudgB8t8kULE?=
 =?iso-8859-1?Q?79HQJuof1FbtMo0W1E4pTBYaUZfVTIoB1KVk1+XUM1ynh2dJiRHcJ9jSPU?=
 =?iso-8859-1?Q?1QC9FHe3UmsAvutrXI9WFqPWhtKyuVUU6TaRaIHjxs6jhyCwQGdSlM0KOn?=
 =?iso-8859-1?Q?RBaQobqG98KNfvXke1oReNG/zT0w1If3Qjnuq/J0SFoohyBFF5KJSdGpVs?=
 =?iso-8859-1?Q?r7CYc3rsMMOEqenB2+xkOdcB0wI3xnizBwCuUPSjmR4XQP7tam8SeA6vW4?=
 =?iso-8859-1?Q?E2/qH5p3VQlHVec3foh2oK2N70n/jq0ErVTgxdAQ6DPQHMv590HOpv8gxa?=
 =?iso-8859-1?Q?KReAW1OUXNGBSl3V2cEtU+TXzxrzkKEijI5XKfWlNw+RhuEfpwqVnDBSeY?=
 =?iso-8859-1?Q?+7f8VVGvZ0evngCRKJS9Q+qc1yob3HEHWjvK0WV4D2KYwpL/dpPtpXX2IS?=
 =?iso-8859-1?Q?aq/+fgn7yjHQDpqtN4JCAhFHblz+NpoBG0pXNGH5HNrkCXXUbW8sZKFxY4?=
 =?iso-8859-1?Q?0XlSEc3qp2nKqNJi1D01+hizuJRXfg4uQjZeeH/O2YbbsKHa+shkie+iXY?=
 =?iso-8859-1?Q?VKgnvABVeXySlIM2bDq47UC07mwb323QX2JWGKbW+ULWXnp+xnNqb13MJR?=
 =?iso-8859-1?Q?SNcM8pJaSvxmcFaNbjrAOAtuibs8i6RnrYoz868NbBKAqn30jqbn/Ej/gy?=
 =?iso-8859-1?Q?R/Ksi5V9L/x2nfzK8FMg28rTdjLVGYm1uu6NXLK1kZsv+H6qW6MoR5dw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f48678fd-c4c6-47cf-0fbf-08da679e9083
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:34.5849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QjkBsOydcwvAbXpg/ldYBxEPqfL35M/+JcrbMrap7ssas64LjDWF1nnbW0POoiDyBrn5qfIZdzQX5SoeU1mPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2369
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: 003QpYvRShUTLOLNOY54yYehE80iQOo9
X-Proofpoint-GUID: 003QpYvRShUTLOLNOY54yYehE80iQOo9
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
