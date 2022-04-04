Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B248C4F171C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377683AbiDDOho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377585AbiDDOhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3999E3615C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:41 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DkEsl004895;
        Mon, 4 Apr 2022 14:35:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3hPJ/0FVLMRuh1Xziz5PTlsGFOJkvH6AV6BG1Fg3gF8=;
 b=KvL1RXkLmzgyJ8C3dBmce4pM431p1CIRNtnxy7FTduEHvWryiY1Pc0OuK4dibrj9fH0Q
 Sxry1gaNTsa/n7sSG37v+d5296eBrIqzRdNdlRqgSsyiDn4pDmnwFBjZ5QNkAOe87UYR
 1ARGZ1MCSzv9Dck4me2OA3tqzjgcelgozLqQKZs2qB7akToqowZTjiyvJAM7512ztzk7
 ohQ9O+GLTk2EMdXfyKjcfPB3ltiLHh9hUDAdMgj3iLzBy7lTc+7yztY+tuH2tIpQNPAo
 cd/DdPQjV5AQHVtz773nLHieIbzEal4ip8CjPp8qtBVzpUeX6iu7T9n0iUZJ6txRu7Wd Bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d92ud0d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:32 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGjlO012809;
        Mon, 4 Apr 2022 14:35:31 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2h2f1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVa0EYl4XFnY2JTyFWqwAoRa31QTKv0b3iklsplmhUrCEF/x+PkUVQssVjZMYNH3rla/vMJkWYYruPqNaB/eu4xKvK1bXD7JZCx0uLXJ+cXD+zOnnXyTwM05eLx+UJOkTyzn7oA08afMFJrPz8lfiqtZFrMjAfLDCA3YwwIVmA6EnXotfZBhkm0kNAZuU7CcphhB8k9bbvc8eVd+3UuB8JVLyfHo1dyJmTRSv0F7kjW79AVndGs1a0TdjDNSI18FhLWU+NIBl90gx/dPSM8qxa5g75nI7MAqCXa32gI4JIgUbY6c9rsDl5j/dCMdrDnftIwCqgwIu4m2Uj9IcajWMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3hPJ/0FVLMRuh1Xziz5PTlsGFOJkvH6AV6BG1Fg3gF8=;
 b=Iukja9hOr7mRmEWYYULiFaF2OcrAu5Fp1JIjEGoK0ajPnJzNNY3HZ+ZjzNTWnJNUlppCtY478oCSP4M62dWrRejNwbP72xUC4Aff7H+vfYrdIMTOqqKGcpqV2WQezcLW5fTfk3n3cTYv7tJa3eX8Fz9pkRtvykiaiT/H0Kgb6UfmGqnM5jCGyRHgYFOc1jIcIein+C1knNI2B/2g11q2+D9TGf4Gtyl5ka8LlrHaQzwwjTXKxodQ+Z9W3RaeILgvB8xcet9ISE/Bm/QFBN/xd3ueD3WK1vpsfcycnNs0cRgW3IHDdGjObuXNXXbg811HG0qtcwA3DumWrbEjUCfjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3hPJ/0FVLMRuh1Xziz5PTlsGFOJkvH6AV6BG1Fg3gF8=;
 b=IT8iBEowlxkSAb9KQb97cuG/MADVS9B4oB0/XuBqeSHu8t2NXMg5EArM6BsTCmZ0Os/cT9U7HMEzdG+UXwkNOKhpJWkIWp0GfWtpcf0jKHh6ibK1ypOMK1sUeLhwJp7L4tyguuZY0dsiqrAcjwmMzrfIr2A3Y5FvACdE4h/sjY4=
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
Subject: [PATCH v7 03/70] radix tree test suite: Add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v7 03/70] radix tree test suite: Add allocation counts
 and size to kmem_cache
Thread-Index: AQHYSDE6qerxQHITgUWXaRjwPU8LtA==
Date:   Mon, 4 Apr 2022 14:35:28 +0000
Message-ID: <20220404143501.2016403-4-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 016b4888-0f2b-4b87-2666-08da16485d74
x-ms-traffictypediagnostic: DM6PR10MB3881:EE_
x-microsoft-antispam-prvs: <DM6PR10MB38813CBFA13D9CBE20794834FDE59@DM6PR10MB3881.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZ7zZkInTh0SV4RVRpesPFqK35tbGu4JrsFWAgwXpm0M4laSL1j4VUBZB2DNx1SpMdMSHgWoVg1XxYxcml8H/u3vwiATVSV66a1FT2oTC99s0fRN5Cycb6GHQt3YrJ2RDZPUYIBVwPRWhkXmy8fe/gQR2SgHkMyUHM4rZgldnCGpVUwNW/whAwKbA5/JB4RkYNCHiw9USx3ZY7ctN1YnXQ6o73lx8Y9X+/gMNz44HJS98SRY78dKyZZrTD/GxgAYPJINT+DLmE+EeHVmPZqNealeQRLRj3kBm0Vt3S7gad4m/NfjMTe4NAOupSR39jzgR5gGSVyngR7NSLNjdeCHQxQQg0YD8il2aYTUicXMsWnddWOXgqaZ99OQ6IyuasMUA4BtQJKcM/EL5f6Hv5tVqTW7xkpiMErWHlZc76gHbdCzCC6iv6eSDnHHcNzJ1m5Ylj4H3c8kVL2LHbeScbz8282/eNCGf9XynXyOCknQpePDeC5steV3yv+AI0+yqlrxs5Qe+JNPVoQUQm5I0Uk6x+DlDLmgclpUEzT2W73qGUmknWeJLbGHvpqcAo+YmGrQ73fyMFwQhzMBJTTFQyQurAqGJ0r8/cYPZrCop/Oqda5SAfjjGLKKuJCZ3FBWmG3rpMmxdr1iTcla2HtXfQ4HAybkXupRDvFpqxkGv5wDrtiQoXmAIAXLdQG1XtWiNyYu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(316002)(2906002)(6512007)(36756003)(38100700002)(38070700005)(186003)(5660300002)(76116006)(66446008)(66556008)(6506007)(44832011)(2616005)(83380400001)(1076003)(6486002)(508600001)(66946007)(64756008)(66476007)(8676002)(71200400001)(91956017)(26005)(8936002)(110136005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wfM8oRi7bARlX4G00cMT430NfWm4QgiaJ1wTycxvspBdwX0QeA/tf5pLDQ?=
 =?iso-8859-1?Q?AH/E+jw0/06gPrbQ+yqBKap+s8VjPBB3/qwL6dE14Xp9dFHrvXwT14FPBU?=
 =?iso-8859-1?Q?2BWV//s5Rb2wtCccG3w3qeuPwXDWQ2I9uWQ0RUISEfFKL2ZfitIqeRSDhr?=
 =?iso-8859-1?Q?TsRs0zVkATmsd59B+RbRNF7KMGA/E2uTMWh9zH7+PQl1KWNiIoMcZibtZq?=
 =?iso-8859-1?Q?gPj2QCrM7oi6AD9hM1Jx43Kvvvn/mO34VfrZpf0+czz1tczJPDoAGbCNM3?=
 =?iso-8859-1?Q?4Upy8xpvzBsZ6+ybjEnGwpPmSzh5fM4o44Q5WDNTaYjp6Co2g/H3MtxMV2?=
 =?iso-8859-1?Q?UgJonePb2siGUP7SnDGG1gfLj45hb22neKl7OnYFwdP49pOn8hJM38DZYQ?=
 =?iso-8859-1?Q?jnFQ8o5pQ/Hsvgy4b65KQo3Cm/NWWr1sOJGvu5E2RBQXa6QB/pzJ6rzDy+?=
 =?iso-8859-1?Q?3BUalLBnFX1F4PhZuNLfYk8I7/87pZFQUvBVYdMdMVhCSzslocnC5oYAzG?=
 =?iso-8859-1?Q?/WtYs8PLtMfDcQtEmFeQbN3qWXlIoRJSK4TZRGvYZ0jPvDhbDVMFyNHFzf?=
 =?iso-8859-1?Q?RLGefjWBBOvMbijLFGqsSYHlw7uj3oijJjAGoRGvnMDV79cdtoVfadXxfa?=
 =?iso-8859-1?Q?sC9f8u19LEXSCObdHadu6p8zjHtX7c8UaWNlIC2Bku2Gl+ZATBtGsKNoTK?=
 =?iso-8859-1?Q?X7a6uXgOGlfLNRTNbdcD4Vv9ZhKmM/xpU84nUlp6ZEtyQDU1KDRmSf9t13?=
 =?iso-8859-1?Q?hZcDL0voGTRSJBKmBDcvWWILKVlpx2AcrAWbckw+g1y6gwu9ycwIib4kOX?=
 =?iso-8859-1?Q?HpAtOW77iqUXZsNG2o4Fqhu0TQ+XZKsEaGA7yP6qFisDwUgRtyBsZjZPFz?=
 =?iso-8859-1?Q?IXbQUQTfSTMv59PsumlAF91CVtHk+d6+dRuWD5s5/j3JVjQixhR91ZEaP2?=
 =?iso-8859-1?Q?/Kfmuh/nU7LHTZEdDZWoucTZKE1JC+Jt9P0/KTxXNSe2QABXkjPtWM0T4J?=
 =?iso-8859-1?Q?i02YN7svr4NV7Yrn0Qc78q4SXRUtksT4HzqcgSwqheB6h5U/N90Mm/nE65?=
 =?iso-8859-1?Q?JjEu6fGzZFMqOa8A+oRJRYNjzh60V1JW891ts7Lhl7bJvddPk4kRPSHVIj?=
 =?iso-8859-1?Q?VRPnIsmRcn6BN9unlNR1X9MTlwrHssKBsWnpOG1rgwSx21Fkfd0kMrEOcw?=
 =?iso-8859-1?Q?+i6HKbgliF19VM6am2VCVZ1zPypY33aPQySCTi+fDanxhXIJXR8Xi54wZU?=
 =?iso-8859-1?Q?+1BnWQiBkJBxXVdt7egYKHk1FHZZ16ZAmOnzNxFexesP2cpiVglu5pZvwl?=
 =?iso-8859-1?Q?2FUQjTADwRex+A3J4kMrT2uqhHSdJS2PmQQLTR/ZWET+6VH+1x8yfBseuT?=
 =?iso-8859-1?Q?yByuYAFHJaA+hlXx5UWPTrGXye/Or9XbAIq6lLuXm2/gQuUr7X7BPrzAID?=
 =?iso-8859-1?Q?n/Q23eOAXeYAV3cpSlnwtJMSEUoCncpA99z7CNIoEAxPtp7NZOzspvRwZ/?=
 =?iso-8859-1?Q?uQXLD97KvZacXLut4Lyq9whsxb4HU2ezm3NR/kseRo8SZSKftqgnLberma?=
 =?iso-8859-1?Q?kMXcStem6VqmeaD89Ulm3KxpY3XifVm5n5VRPUGlEDurpE8mkyH30hlput?=
 =?iso-8859-1?Q?Gf2QxT7iZRt6COncypn+3AG8UstiyobvknwNMxDi0Bk8SN/CQlksk8oHYf?=
 =?iso-8859-1?Q?7O1Dt8sgCvdLNQT7mtMgRdt/RpbkVkul9LXBxQJ+yPoyztMfUL4xMkzoOf?=
 =?iso-8859-1?Q?NXrcfaj/cNnMVasMGp1dLT8YV3v4R1AJWTCj5zcY2CL3jfgvLn/ZMw9cIX?=
 =?iso-8859-1?Q?JPL1iSgNeFzW2XrtGDhPLibrh24mS/0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016b4888-0f2b-4b87-2666-08da16485d74
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:28.4883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +K5MUtj/UVTPF95t9u5MwoXdBupYyxOKtpJ1ods8adll179B8ZeoCbJWoIdeKX6sfgpbuzxExzoyU7EKKEvbiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3881
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 adultscore=0 phishscore=0 mlxscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: NXvwcmMcKDkfEOsUx_XG6iNuhV8n_tzw
X-Proofpoint-GUID: NXvwcmMcKDkfEOsUx_XG6iNuhV8n_tzw
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

Add functions to get the number of allocations, and total allocations
from a kmem_cache.  Also add a function to get the allocated size and a
way to zero the total allocations.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 14e6b50e2547..f20529ae4dbe 100644
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
@@ -31,6 +33,26 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
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
 {
@@ -63,7 +85,9 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, str=
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
@@ -73,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -98,6 +123,8 @@ kmem_cache_create(const char *name, unsigned int size, u=
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
2.34.1
