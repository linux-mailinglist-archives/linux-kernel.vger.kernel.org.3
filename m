Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E39D57ADEE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240848AbiGTCUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241016AbiGTCTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:19:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8A866AE1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:11 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0mq6X017914;
        Wed, 20 Jul 2022 02:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=AEhxBQoXAjXDovFqrnJmqr8BMKZ7Gxej+7d9YG+3V9A=;
 b=oEQNUCXKvItmlaCmdHkSIJ8xMHg0omwXUcmpg89cFmHmgd9UQh+HdJnQ81PnDVL4RSLU
 0sGRK/QSQNKngxMrwbSewSWTROojZotwqd4Uh2ijQpT16qYKAkJDKagUtFl4xxBzoMcM
 LK/bP5W2rZLGwPKRu9Ed/6rBygy0sB/Fc2CNQBYgenAcfCjfcJEmZbDnJhIAHXHNDPRQ
 GCxTkeMbxtk4YWBU+de2Op0fVdtcrakptEka7QoH0MQu7sTaCMr81SNgBl/atXG4VYzo
 4Ay1la6XtuYBCeVjeLHbnYV5gw+tPmI58p+m6+01M7gIYP37mCUIEU6Lz4DhqRb+9+/A XQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107t2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2CLIc002698;
        Wed, 20 Jul 2022 02:17:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnupm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfRaPt0afL4lazSnzMslkZVOjR9UfoL7IrqGBhJUpel2cv0m1x33pC8fIQmGoLVtJgWLgwN/XKa2R7YgNSmtSp/dNW5V5NHfT6sLdXjkhns5eRP1+GaVrAPaUJPdNQMg6IcRXfG6Eph1CEHC0/EL+YXKAcbfJ6l6KNf390UuazrSDwZGCWLlszn+6UTVSfZu9c5slM91oN3UBzzORKCD0BB2n3zM0WA7pSZrH4F0It2Bm9F6bscjO3ddkaaeON+cQNHhQqT+r3YfsrQcsCwEgQ930gRo9vFGdbvEnu59Cti16i2//Rk2XQquplxvsunvnCBKCIEaL//Mh4KCfo8cGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEhxBQoXAjXDovFqrnJmqr8BMKZ7Gxej+7d9YG+3V9A=;
 b=UTNq2bjvRb3u1r33hhaNswSxEFwicst8rv/3M29RFIC3oL0cSXhzdkxUr8X3PeQKSVjwT92ZrWP3ANvLFJP+80Ti7VRUFyX3cfHUqD90ry2EsIy416jxuzq+Eq3I40RWHIRw+eSVpuOMzrFuo2f1xXZRo9CNQyN39uH0hK7AIrLLZQK/OTmKYbFZSLmurDSxPGZfURgq0AQOUn500b5tDzZETL7pBtJrh31Rwop6ZEKkvhZtisMWkoSHFB9RwjesgBy+iM5Rdr7TnW77rfXuWheDLysKS9CUApklsiGveDFaqJ4GQhHwWKkVJqkNY+92vX2iP2HnPYFUGD06pPxP0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEhxBQoXAjXDovFqrnJmqr8BMKZ7Gxej+7d9YG+3V9A=;
 b=Z/OFEknjuPsS1Ea8Y59BJNnifazoDuadsvHBGp+h+jEfeUF9hUS+kUo2RLy9aBAWNFcy42z0NliRJQBw2SXWw9zMELPQkI39yN5A7LOkAk3bH9usPJ4IYI8sGWBU1ZFPHXfa4AfNBIbOPVuQOaFis/JxQqEZJja+MubJ/TyYV0w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 22/69] mm/mmap: change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v12 22/69] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYm97p/Hy2EZ5wsU+mS59bXGzbbw==
Date:   Wed, 20 Jul 2022 02:17:50 +0000
Message-ID: <20220720021727.17018-23-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6656fd74-37e3-45ba-895d-08da69f60e62
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sV96P/wq805PKkPDgE9YBmhbh2kKQJobPc/HiQZoXLVrrfFn9aKcIqF+R4MpuhW8AkCcYskoyL6GvQp1SrtttGDhxax4+h0adzx/ngdoTCxJmmP3kgS7AzH2Gm0SnbFJ69tICp1QC/UhsyxEEs8LngUEoY8PXJerytkUfD3gqgHuVB+bc2qAnvo3m5SusfEqGik//5R6lxhqDuVydiXUwpr6IlbWlVCZ7GhgrpbMKCD/6ohEeP8Rba0tahe+K8eHjwWLI8F1HtgCqBamh0wFQFo2Wre4WtSAgnq8c970ICXbOzxqR5b+Y7ZYuS635r5lmDGKmF7c5irYuQ/tcnC3do1y6Qo56NnZnDzexY2YBt4PXV2Ki5ROPoh4ZDVHUQjmow4TrSXzOaJlyBzlEBtICSkJzZyo0RSmqbYkZHn5qCZU0BG67QwH/SuHEcQysqdrpUXr01cMryf6zO8WItJNQzLuAxgOm81ANbTbrBGTBFLvFcotY9tAc1c9osEJ3VYHFeI3VjAxR43K5blR4E69JYBrMmZpWPn30CylVkRoNb1tN9uFAQPcIuo3XP7D6f6YSsB2AU77hOWKfJK5WbZII6j94XLKI9DOn6ezoZOQ10T6OoUgjBmbVFiFvjZaWqdfNMukbaZIQ7IAz15NM/w2uik66Br9TkUnYNkJgQZ+/25UmBGlmXc6OokxIZV5kLUJ3DzZ8ihOBhE//bOT+TFSQfUJwdyAGLQglRl0s5+xuWCovb88l9BNJ0O6OOcm68wUv/oYmwFmYE5EaDO17WMNnD+5q/WBJ5IeIZybs1AnFpsWY2GJ4JoIedJIsH767qLtQdtC3tOQM5OJwmdTYpAI5Z2tZV8NAzBQLBAslQfl0iTvZhAgXB5P9JjWWS0h5SjG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(30864003)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7Gc5MHas59r3QTpB8Fhle0g3wzfMBtoZYCe7aZj9xXY64lCpxXRjZ0vsZc?=
 =?iso-8859-1?Q?eSiSJy3oQDyJjvbDI+IbwvpqPLsnkh5bE0N1//Lo89pJ6y0UWGNzd555xm?=
 =?iso-8859-1?Q?cZglnRXzw0Ge+Pqgw9j7blijkmsGR2Cu0YdIc3RAVkzJMJbCUeqpC5W8ea?=
 =?iso-8859-1?Q?5CNdFEyJpVLVPlV2pivi+Re5ZA9aV4Mtob3ti+m4hKGVwp+pvWUG9y5ndX?=
 =?iso-8859-1?Q?x4eqyu9dhqqF2zvlxC47VxyHGGg27RZTcikqSLaDsvEpZ20GEr/ubCT5+/?=
 =?iso-8859-1?Q?7o1CZo56sK/1x8nbrYOuEk0iN5ImzDtYRQDNbZ702fTy59FrIL+PvVQfeK?=
 =?iso-8859-1?Q?dJvkpWIoePKXLWENWMuPAziCGYjmzGWjlAs3SD9tLZHRYiYcZ9XjQpWOI4?=
 =?iso-8859-1?Q?4BPneSTNntvwlmmj43jjKwHjs7egs7FhKN6IZxXwnn+q6De3jBxHv4FQ5D?=
 =?iso-8859-1?Q?G52wP7N7Me4C0ISZ5kHl1yne3nnnSfdr7Yg3AvGGq/MFMFhYQMj+8HWZbZ?=
 =?iso-8859-1?Q?ptZbauAnBBYVV+mdpMr7QdGnIBHNEIBGF/pDxrFazsGrCZxxhx0Ay0cGvE?=
 =?iso-8859-1?Q?3tk0VVpGKvzxMyNKf5gwrtSOGgmyHtwZHDnhxdu+jt9sJj9hgmmYG4UeBq?=
 =?iso-8859-1?Q?TC65K6G51EZ04m+yyoW1On5p/6uMaxK0jGzep0XUP9isQo5Mhw11x2DAns?=
 =?iso-8859-1?Q?GmvAIW/mEnZMJBLZhROrXdIy7Wupaa2u8p2nxX3eLztd2bu236+k3r68ZI?=
 =?iso-8859-1?Q?9IXq96bZIWJg5zJcU1eVO67721vXjc46wZjQ1CMG9x87pKra2drP5hDNk3?=
 =?iso-8859-1?Q?d0AP5qL4zRo3E1nnBRgWcZG7cYxM92e1uUZ1oETd58rJsPRhELTO80PEjv?=
 =?iso-8859-1?Q?HicEz+KaYjjmaslrLw6C+ya9gwVw3LhUavINC02Gr0SfSiO5sL1BD0g8DS?=
 =?iso-8859-1?Q?n/fPy3nBbDdqv0EcvwIvh0nQhdiv1NNGqsJlLIKljhLdDG9uWT59c2Qvny?=
 =?iso-8859-1?Q?syw5KItnSgFF9jqrudl4wB1jVPwzucGnBg3D0dre5+KIHg5ZGwXhFnb5ud?=
 =?iso-8859-1?Q?Hc9VP+StdspbfszANfPsGi0OztsSo/nfmECZx++8CTiPLDG9cFp4C4te+I?=
 =?iso-8859-1?Q?8Z6SYTQITqGoQXkf/Xano6nBpYbFSDIgpib1VpDNDzSapnO0BvMtjCmB7u?=
 =?iso-8859-1?Q?J3s0brGryibBC9FK8xnZEdeJRFwQ4dI2nqeB7U8gR+A9PRMRkeLZ+J7QKd?=
 =?iso-8859-1?Q?piihnvKN8rX/4cOLbU9Iu/6wRNNUcKa6QNUhR7xPvrHR2eDHuo/EuyEc3G?=
 =?iso-8859-1?Q?vJ/56oeaIx3kFZliyD19x55HA2t/cLPbPU9CuvxMd3Y63r8I/xTv+8vptz?=
 =?iso-8859-1?Q?J3GwREb2aSuVgaVIEgAsigsWWJiiPCiSBBp7UKZL4h+hSKou6jIbiVljA2?=
 =?iso-8859-1?Q?kLGIpMbVBZRo33hnHniM9LzFnbrKn2M+KNZ18ARMphKA7ytYhaxjMfd0rB?=
 =?iso-8859-1?Q?W1r4u9pSNiRKJEtxGO9h78AhIEWWBFu/Z0zYUzNciwOS2j9MEzqWa21hvS?=
 =?iso-8859-1?Q?Y6UZOkNUN3Y2NuhOUTjFSqoXvNSz97Z25qkWEdV+VCCEA+4jFSCu9oiHRc?=
 =?iso-8859-1?Q?X+YlZJkzuUa7cWOGYlB6TCd8dPYAqMGmjgRgbEebi2xZVcJfbfu3AntA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6656fd74-37e3-45ba-895d-08da69f60e62
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:50.9935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6orAej4kx0Mg+uO0rNNSrWVF5I0u+Kr279XQCU568+Ph56HJ7nLZMUbEUlxI0E68JDsukUpch1MBadBTMSGMGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 305kZxCLI_xvudf5AVrKHFsDbuOjk4EM
X-Proofpoint-ORIG-GUID: 305kZxCLI_xvudf5AVrKHFsDbuOjk4EM
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

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to split
or coalesce.  This avoids unnecessary allocations/frees of maple tree
nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function to
use only relevant checks in the code path of bkr() and vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra criteria
are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Add a wraper for munmap for the brk case called do_brk_munmap().

Link: https://lkml.kernel.org/r/20220504011345.662299-7-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-23-Liam.Howlett@orac=
le.com
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
 mm/mmap.c | 239 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 179 insertions(+), 60 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 02d2fd90af80..33b408653201 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -194,17 +194,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -246,35 +269,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2805,38 +2845,55 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
-
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
-
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	struct mm_struct *mm =3D vma->vm_mm;
+	int ret;
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	arch_unmap(mm, newbrk, oldbrk);
+	ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+	validate_mm_mt(mm);
+	return ret;
+}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
=20
-	/* Check against address space limits *after* clearing old maps... */
+	validate_mm_mt(mm);
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2846,30 +2903,56 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			goto mas_expand_failed;
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma_link(mm, vma, prev))
-		goto no_vma_link;
+	mas_set_range(mas, vma->vm_start, addr + len - 1);
+	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+		goto mas_store_fail;
=20
+	mm->map_count++;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2880,18 +2963,29 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	validate_mm_mt(mm);
 	return 0;
=20
-no_vma_link:
+mas_store_fail:
 	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_expand_failed:
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
 	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2902,13 +2996,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.35.1
