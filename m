Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAB3553BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354476AbiFUUsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354428AbiFUUr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE7B2EA0A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:27 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LIxkdi007500;
        Tue, 21 Jun 2022 20:47:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=n/PBdIiWR7q8C7kPWIBb81RpjPQB2i6fkp8e98H0DKE=;
 b=pgBXXJ/C/LD32FrmApEqSExSW7vA0+KJZ07KSb1LdWCoBbKi7h/sAOUrWdOLXX4BJ8f3
 ZYF59CmbxIWTyzGD1/GCZiXIjkSisVrq8CuDtl/tvaTxwWyAgJeMsdrc+6W31aS4LlBq
 xB1Rb7pwAL76UPWHT/gMpiSewpQl93TigJ2Ky0xsRyv6Oo0EchsWgc0012+pSGolqELu
 lXRE5pAqRAGvmke/iVi2oaPYgXckoSZRVzRnEGxKBWp1s9jn/EIoC0rMUXrktDcf8lOy
 cbLrk3jOUKz95MwseclHU8u0yFsxG3IQnfAMEb4f1QeYHqCVbtyGGXbTuGQpFXniZWMc OA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5g1xr7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:13 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUgp027828;
        Tue, 21 Jun 2022 20:47:12 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp36-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnDXRIYJ51gzMiJJTy9p4A/YlD4vUEfkDdDNwKEPbedpp97/kQLu7HcswvvucJC+pHQ2Y6fspmWjnfUSJp6/Ga05qbWT67heLLOq8Pc/nbOFTUm+80u7iGTTsG3P5QbWCM89/CDugWIfYKI3xKqvT2XTyG304KjPWoUSgXH77qTW62edzC50551YcDMyeyH5X36aLGbHISv1sl/FSyo28WKCOYFGMSoVISNj7evVo19FoTZrlesdR99p6uvE34x+R1gfEEJudHiFEfymaOTRNerGtydtxYdWMn4mor35o9r+Cf27tPYzgqDACUUwSVpeehYVh0AJRWb8rn4QglKAgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/PBdIiWR7q8C7kPWIBb81RpjPQB2i6fkp8e98H0DKE=;
 b=BOeZptFRvJ7E/vgUXwRdoOf7AJOKZmqDaX3dNSXUBFt03tNHVfxEeq6IKUhX4m4HIlwlcS/5xTKTuRTTlUBy7ocKZf1S4YCpfJBWLAYhMKT8DLHLI2BlnuzKXKHH4Gg8aMaSiTm4xtIPbbthfwIsevuYRMF3cNAAlTmdC7pApKcokQC3On5+DR1lBsoc83NKgCDEBwszxqPRRjTsRlQ3X+gELZ4jazor/uvosOOGBIM9Kpt5aPQfNoef/EmS0S8+hpbONc+fx0O6T0gbnOHT92IVyfGeuaOUDtB8bNomvIdNKXYOLJ3LJE/yuJz0y7jr2x+gkkQUck1rnz55bF1x1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/PBdIiWR7q8C7kPWIBb81RpjPQB2i6fkp8e98H0DKE=;
 b=qMHJ69Y2CC/fFNq7g9KWl3odTL0lXrqDRUmkVggyaGo0LQc6N/7yDZx6Ti4f1nmnHlvlXeJWvGJIVFCV3gctcx3JaT2w1DcTqhSXGTaFVYAwkkZIEKRlGqZFpcyDpr6JIAqEQ+qqDvjVGp/BoOnT1IVbtja4GVynCQj9Au8Utig=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 23/69] mm: use maple tree operations for
 find_vma_intersection()
Thread-Topic: [PATCH v10 23/69] mm: use maple tree operations for
 find_vma_intersection()
Thread-Index: AQHYhbANt098lNnLWEeQZ03sBBBwYg==
Date:   Tue, 21 Jun 2022 20:46:58 +0000
Message-ID: <20220621204632.3370049-24-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ad691f6-2b1e-44cd-c797-08da53c73669
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB308556F81D0D95794346E413FDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 39jVqtozUd2OebwfZ7vu+kGg9CALvpOdtOifUCrQ7nPTH4RH/eUoUP5Au5hoxcr2FdGmJSVAjuzcJ9u+EZRipAeAJmox63Eh+aWRFcN6OEzE1LheAV/z1cvo1zOCWUWbM0n1snQVwCG2DUD4TzaGXpndP9Tg76qeVbSKrp2RWiVitFafmcd/z9LhIGlJJ18cJz3GAdQaOK5s/oFKbAPqISDKbqjAqw4U1s7oH47CnI+PlpT5VAIWbJgUVBAnAc2/6ok0gAfC8C1TOTAtBAha+4YVtMCJe/Da+/igGAQ4jeFUal9yO6uM2suGLT67tsQuI8tB1ISFqnWN6EUk8gdiAXUdV2OxFTWESS4mZM4AMJv6CGkwcu+/lWkFesDSzhk/jZrxnQhBWlncGUi+inZbbw+5bV4wkk4CcEe9ItuzOFfHtXHzkCX6Pg9cV7Hbyv5cdanQVUvtGQhNbJpjYgQ/zp8ZxTXRCEqN0sCgNs+OGp1UaZpb4mpPAPtvVsIHfkQWlL9bollhN9bC5wLBYi59f6dHzfbkcbGApW0z+Bp2TB/uSX3f8SY1mzqpLPycGg3ykHwMoTZwib5wY1peUMHQWIh5iuofciT2/2r4AtokkkEWg0NVpf/67rW6YP37haoAt6gTQHzr3QeOkXzCoJt7oNVsTqCBxciart1T8oAVym44LgSxZnI9Tp7n9hXWIZVg3f5DtkG/m6hheJfgBG3UaNC9/bvYxkE+GjSvVtTEYevuTym7SfcBD1fcSaDL4+YqfIn0DijzqMoggVvQfCxhllHQoVjDlbx0TPdwID0kM2M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yWoR8fl0aHEvTfFMSpEXxv3QT2WiBNmYEl/o9MBkARrEuR8f9Yeulr41w0?=
 =?iso-8859-1?Q?nJg1dipBDzbg1TL5CErfZ/khA1pa9HsZf6ghELhESCalRHUa0TSXyj3TAL?=
 =?iso-8859-1?Q?ELZtuek0E8tRcf3jmj8iVQIb54zvEZJxTBmQABLGpvjl66vl+AI1Z1T/mn?=
 =?iso-8859-1?Q?xL/4IC48ZgFcpK43FaFlJqars9RtKUMrgEtdDmrD83V/8Fjzx5B9LIRAaz?=
 =?iso-8859-1?Q?bOBmTTOBXCrfXRnoQtKnH6CBKHfYu8RN+mdqIDKrHREy61P02ijkOK0ZJi?=
 =?iso-8859-1?Q?Q5+El0uSfsZN/39DU0oiQOeAIWwT+6jsw3ts4sApdBwzxftBChAZhlLzKf?=
 =?iso-8859-1?Q?5iEPGYzIzmK6BZW/AktyxfHGqy3rhcQL9VK/+xcPfp715+P9w6bsdMobcr?=
 =?iso-8859-1?Q?ZkCXAvRL0a6pdLPHJ3+Pcg9uO+NvxQt2aFzWrhWwRW9JBoQb+tcEzNMv/w?=
 =?iso-8859-1?Q?fRGHFnuA+b3HC0OBPuScW70M2NFOTELB9yM24ElUebpEyYwiYnnRV5y+S4?=
 =?iso-8859-1?Q?Jfe8rbRPlD8C9dNwkpLBET+6jkxWb/9eJVGHks2mWOh+YaC92Sx4FBSl2O?=
 =?iso-8859-1?Q?NUT28pB91HyxRSh5ps6PMGw3R+ZFP40ewc0NR+rFSaYvmCUzbM4pwi2nSn?=
 =?iso-8859-1?Q?7qwzobMFS01X1hBDauPL2RqD6+eunT+GY6VYBPEI8BesRhRbeHkNRDOqXt?=
 =?iso-8859-1?Q?29lRs3l+OMqjoNTHx8qLCBwYOvboe5ftX6iFTunDprtA1wXIQ/aVoQev6J?=
 =?iso-8859-1?Q?G9levvLKQ80WNJcrvZbsa8RbeI+6ltmKK0+fnRvfA0qb7mgqRHtms0CYWP?=
 =?iso-8859-1?Q?Fr1s+mK1qgI42ieuwMCgd5Wj4Y9pBU03Tcpj+zRTZ4Cao1WF6aPtTdDaDc?=
 =?iso-8859-1?Q?/HRlq5AAv1tXKb9IOSYxJyGG3XMAYObbEdtV73DTz4IBqxUjvoYv/VcC2a?=
 =?iso-8859-1?Q?QiJ3+vAWtIT07F+VVviiGIaqPksgb8MHn0AO0CaKXzqlIbr9BgGXceqWmH?=
 =?iso-8859-1?Q?G3fHdNVzb1Gh8E2unAF2A5OQR4DJvde88bVH9vA/TNWNLaoEvrXSnqLmnC?=
 =?iso-8859-1?Q?z7L+BES34La0NdsgzF7eKPiU31UNPeIruM7nqvFOgxKsBWwH2ouILm4L5k?=
 =?iso-8859-1?Q?YfgSXhWMkWbrxyyln/NrllG83zziF0YINUQIudMhivbjnS77clx/qYuR96?=
 =?iso-8859-1?Q?3AlivW+X/m7qTftHhsxdYBc048lueX/ro50UqoVUL5TMUVyDBmZK0hJPJW?=
 =?iso-8859-1?Q?ppkgG/qFh1xIqW+iVwOL6qPTjMXLsQA/G3AeYz5n5itFtU/6wZGYN7MUnt?=
 =?iso-8859-1?Q?ULaE/x7D1OvJhCloTUkol+apq9+Nv+/A1K1tpIuTGcikb35HT9RqKfrmC0?=
 =?iso-8859-1?Q?XU2xbWnhgajnQUsVvRYEg5gpQYhJkmzCI257pcCdxtlE0roh2bZKskb6Ah?=
 =?iso-8859-1?Q?oFlPCfcuVK2U10ozaV892SJjZWHeloPzUTpS+y/TSWxy5D/HozSZ8u+Zo9?=
 =?iso-8859-1?Q?/Xke8Ac2Lfn/ZOQec/jzfCSy0HtRhY0MNggO59R3Dv4ofKA6trkasKkkBV?=
 =?iso-8859-1?Q?nLinSAHDexZ3XD/BjJBvNONoOYiyxE0Uv07AO+etFRpnA+gMcXv0NpslF8?=
 =?iso-8859-1?Q?pYmTwgOZb8Rkpenvw6XwIDMZug95pBQ4vusXKPBSNnyDC3/sqFNwSDHgu4?=
 =?iso-8859-1?Q?3IWoIlq5FxeJ7RqL1WU9CBO7ebggTFdUyy5CrIYTmcy76Gdwdvl0zqBBMx?=
 =?iso-8859-1?Q?lshc+sRxQTxDM8e4Y/QQhAK3U+s9F3YuSLW0Q8P7yOZGUxd4s93LuVqmsw?=
 =?iso-8859-1?Q?+M2LDUb/aAUdxgaVwUlb989EHXIdZAQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ad691f6-2b1e-44cd-c797-08da53c73669
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:58.7541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zRtSxxA0B9O1pdmrRkWCqU2+/5bn/39ttcfQY27h1lhlCY3LwNjfeBmx9BMX1m5xGYfb2XM0O13wExl2YHqlgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: WbEVbLjuK7I48FHm_S6TK0RveJ8HDVCp
X-Proofpoint-ORIG-GUID: WbEVbLjuK7I48FHm_S6TK0RveJ8HDVCp
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

Move find_vma_intersection() to mmap.c and change implementation to maple
tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.

Exported find_vma_intersection() for kvm module.

Link: https://lkml.kernel.org/r/20220504011345.662299-8-Liam.Howlett@oracle=
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
 include/linux/mm.h | 22 ++++------------------
 mm/mmap.c          | 29 +++++++++++++++++++++++++++++
 mm/nommu.c         | 11 +++++++++++
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f15301bd7f99..b0a84f7c79fe 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2791,26 +2791,12 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
 struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+			unsigned long start_addr, unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index 784d38ee8d94..9afe51a7db6c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2092,6 +2092,35 @@ get_unmapped_area(struct file *file, unsigned long a=
ddr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
+/**
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
+ *
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
+ */
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	/* Check the cache first. */
+	vma =3D vmacache_find(mm, start_addr);
+	if (likely(vma))
+		return vma;
+
+	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
+	if (vma)
+		vmacache_update(start_addr, vma);
+	return vma;
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /**
  * find_vma() - Find the VMA for a given address, or the next vma.
  * @mm: The mm_struct to check
diff --git a/mm/nommu.c b/mm/nommu.c
index f2031f865dbb..b098c0251137 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -642,6 +642,17 @@ static void delete_vma(struct mm_struct *mm, struct vm=
_area_struct *vma)
 	vm_area_free(vma);
 }
=20
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /*
  * look up the first VMA in which addr resides, NULL if none
  * - should be called with mm->mmap_lock at least held readlocked
--=20
2.35.1
