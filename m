Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3BE59C21A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235866AbiHVPDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235836AbiHVPDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:09 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070B37FB6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirFi017918;
        Mon, 22 Aug 2022 15:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=kbmC4/QcWE1bfwbvpTh1yBb2ZOHks98TPC/1s31WLkxElYCvD1NKXdZeH6H5RUl35Pe7
 bxbEhxK2Wn0iEq0AwjiC7SwTJ0Vbt5hWkG3ZpgOv6yH2svqI4/vG/Tts0LEuj2oQu/Tc
 J6FkB98C09pdu1nIyTeBj/5jl++XOcKw5WfaOPEQsGaySlKS+h8ngoRGbPEJyXmwXZwA
 Op4xh7z7qyaOkzCMmqlvEFeLq2qLhloZTBiJDRllB7PrcSFSOB/nK/Y418MSHeGBG+9E
 7MgltfLJ1LqeM03lJweAHTX+J0fuhNAy593Ttnly26h91oeVGPZYP9q66AYPpm9aosaV BQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt03sq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:02:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nf4037763;
        Mon, 22 Aug 2022 15:02:54 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mkg37uv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:02:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dle41PhvsnGHr4Rdse1Ti1FgSbKZidjoeqHcZQqmA32Imd9uVj/R3HRPMFAQzGVHhsc2UelOk4m8pC/f3NdTNYYuG71ISwa9SRcTQwcsXAd+CsyZ801DmJ7l0Vv4ovZJEyNt/I9NcQZ4KTldwtzuuzkzCemdhQp+em9Rhglakd1wdk+aG983J5JKygnkXrPqlEdM0VxybJKXBo84rHl3JJUp9mAIQNhnaSRGN0O9G+YK02BY2HcRDezABZOLePDXBvE2nswCBku1+4HVe3OiklUf9VUHHim0zoh1YeDoUpRAg1lcHHC8fWWLa25Jet3Lq15D/omsTaCcv4Oq4xRTHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=SDYOGDvXw9UsA901CI37pvNX3O5n4ENM4ljCi77agni0J/0msC590q40+UyJ8NKtOnVQy/+IQzzZ7q5hEx9oyjDxwhpsZtq0ssMTq9j+yg6V1CGhaNhbonrssMrjdATQ1ziNRATAIRvypyjSzRxzeOY2VBTcaY7JtVNs6jgvSA6iPrJuwA0C229t31j4aLfpawPiXRiEaCeRWUDpQ954Z34m7KyUk1uIZKUBFW7YoZhBV6CL+Nc84IJXQpAItn9HhzZg/rf98hMO7agRhTkcD2mmWTOY+6YCzsDDQ9At/tkZDVmSDTdLNtFpbP2HabVtIjc5t8puMiEkbR0DvBI+jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eX6NLsXus/aCvKX6/hTA8FBB3wGYhEify+xnO2FUW8=;
 b=fFDsI9tE3Bdo+9hQ7/6wl2lvmQFsoW0MeLDoyolqMFyIgvH0Ac+vL9EsQcsFnFGf+4I2oZdaakpZ09BrjQ05+3DYHwJzljGcpRUd0VMLDAAZeGkHgM4zF7ZIY1OHUbXFWjPuThSdzX47/C18bA+326kMZzkJGkyn9tINACJB0Zs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:02:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:02:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v13 03/70] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Topic: [PATCH v13 03/70] radix tree test suite: add
 kmem_cache_set_non_kernel()
Thread-Index: AQHYtjguBsf7SNeGTEKaCz8sP0LwfA==
Date:   Mon, 22 Aug 2022 15:02:21 +0000
Message-ID: <20220822150128.1562046-4-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f9d955d-b8ed-4944-4b8e-08da844f593d
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zcqEpn2Bd5ab/KqhgrNfo3YW9mo+8B1Fumx3WT9K3TAtWtgSLv56P7HEfnzTaIxaEVCEZY3+qZeqfOu7L8k7qLrOrZXlRAuCOKHj9PPsVON5qUMrw3xYyfZa5gQX6kHwty6ZqH3/zqfR6USB5BoLXljqQ+mlm2HGoHS2id3RKRfF61GjiYmRk4RKCV4A0CPK8j0DpUIrfa8/uy1sMUERGC+N+oanJSq7q19x4vlNlIsHIK8qAP0Uz+wGb7zfqC+PTVMjRsg8oTPZG+NQWWUb/uU30d7/UkqM5NxofFSBLnfxuNTAoeliXlAysrkoSWCapzIlKNbNa1gfL/r/dVAUX+sF/IxAjyyzIIhHHAK4Wc9bBiFSneCsZX7BxB+VKDhAbFjlUJhyFdb+RSorx77Mrfy3fhIvUgGafM5Hin/vfXNZPpJZa9xohOQtNomxGYu9D2xwxpUIeNZJWwsbU9W0ur6IMRVUZVrrtsZIkCJjCuJ7R49TRhL7+B7Tw67MR6nJZ19HG0MHLoP9ZshUkYef22T1unL/tVOXODwdN6tUR2kVqRhlh5+WW0VOoqbblf2MId7APivxoZkqoFAoRY6KiHpkM0NnCfwMaI87TFT2qenC+GY8l7QZMjXkBgDnkID4vToFkjUIuLVkW9/79FiPZ6plEcM1CTwD0meyDzIC56HC+sQChA8+RFoty1sp1KcsjCLPgnFM9w4o0q/tZrVkQGEXDxpceZiKiIIcSRp3JRMiW1+sHhiLfhbpzrVScdTI+t8tB8meDHBJIF40Q8J8Gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tHHvh29bhuLNu44jLQQU0n7aQa4BHvtAVOty8iJmedmHCtj/QjmFET/UG5?=
 =?iso-8859-1?Q?dlRwYtYpwR50nRALEf5bxJDYSlmkPcsfT1ZCh+R1kzExveKqqTSURwZb+L?=
 =?iso-8859-1?Q?kojd4CT38EhOc+1bWW11vKAIBs9iAjKTDSqrvqcR+qqD/87nFWYyh0vHAq?=
 =?iso-8859-1?Q?zqk8K3AL/9de+KvNSMCydbsGn9Z0qU4GMogNh07nmAK1SHhTKOPU0axeFC?=
 =?iso-8859-1?Q?363mVzVpXU5aCGeIOPlNo1gFjSnLaY/gFhsX86uz2L7AXLUR7jzEzlqRF4?=
 =?iso-8859-1?Q?fEoGZdxUFjBvv7e2g1lMHmdwTa4wrdOHzw07X3UzrG6fxfoknuHY+s3lRU?=
 =?iso-8859-1?Q?6Hrpw5ebpHIZkmuUz1wxTQzF59emQgYwACTBJ9kiZSnTK3iu8dGJlW/0JS?=
 =?iso-8859-1?Q?jkIRl2t0azYxHzxYcfAb1sF9C1FEuUBqfenR2ZuVGSWzy9TmIvANtT2hyD?=
 =?iso-8859-1?Q?TVTn3Rs9eeiy5shpZVIUADOI/n9WVllE5Uqmxm6tMuNuJrmiXfQn6cr79r?=
 =?iso-8859-1?Q?TEnzr2ho3okYVG8b+ElG2pmuKcDgsAoHiCyMfKVip/dCATDHZymP1R7KB3?=
 =?iso-8859-1?Q?CGZU8si7uZygExyeUGnlHs+aoyParguR8c4f/8ZutNDXODMtsQL6Q4z4kE?=
 =?iso-8859-1?Q?czEy9JJkRpFw1jfNa4oqcygnkPyFL9390p1r4LW9r4ZIUiQJHHxhEop7BA?=
 =?iso-8859-1?Q?U7HlUp3HpmJ5DjTV6lTffmDsg34olrl76GLA0nz5bD/gmfkrMpYW11pZy3?=
 =?iso-8859-1?Q?Z15FlPNh2hI0sFMbIBQFZiMgNj6+z4nRtOW5bz22airJKk2QXyp8vBWaIj?=
 =?iso-8859-1?Q?SIrMae9K/6x5OwdpjH3Y/0qYIG0F185v00/np5KQEhEBpARVgReRQ/u9vG?=
 =?iso-8859-1?Q?14OpkKplzs0nBJqnKtrqi/b1vK75fhVrae+RX2vhXTjsKaN+o3cccnzYQm?=
 =?iso-8859-1?Q?EkwOkKxTNRmta+/a8xhX5RCPn3K7aVllxCUGbGxht8FVuAYdaRcaxAANZs?=
 =?iso-8859-1?Q?KqEUWgQH3UJzJIT0uYy3Mv003gsenezvRb3UjTBG16/MimJMNbTAuoiziR?=
 =?iso-8859-1?Q?F5B6c8R/85g1kL8rsJzducC+J0ddaDsuyCKemo03ibnstjrSlKmP0NrRY/?=
 =?iso-8859-1?Q?gBMGIVHMtclvMB51SCqfMIJINKTAkBVfEhIE6tRPJkEsrnXYG60WbOsRwR?=
 =?iso-8859-1?Q?9bwOCzWNtuZ/Ktas1sf3UnpAn4I3757nZfZeUUdDJhub0OrtlyLMegr2vR?=
 =?iso-8859-1?Q?lta5He05bDY2WkN7LD/0g7A+HrjAZBe1wJZFDYHj6aQ5vym6Fnz79eRaRE?=
 =?iso-8859-1?Q?c5Fh4V0iz8g+MLRYmRKdvJh+gtw6hQZrTwGv13GF96lrLLcP6ZaG0sXkf3?=
 =?iso-8859-1?Q?5dAl5ZOL9Ihi9LiOljnGXsQdkxPe1svOFev8MOQFt9jnmSVez6dAHb4yah?=
 =?iso-8859-1?Q?Lh5oAhXO3qAjWpMFuwzcdmUSmzprXOibhwauLBcZOvui+gLFRo/DsAM2TY?=
 =?iso-8859-1?Q?l8yskHemjgcIJSXxaZyGb53SnPqjTcilIgWF25xI/Qpan7S9b4NiBS+/xN?=
 =?iso-8859-1?Q?hS43lwWvsCGsKaNKiBZJJvGS+/IIVL8hHCiKt0eCU5hNJhdBJJNB/ptxKs?=
 =?iso-8859-1?Q?R6wnGIVVrVXtv0FIzNK8m5sBtnbiOPHDnqwyzIw44mLXsm5ER0u+Q/gw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f9d955d-b8ed-4944-4b8e-08da844f593d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:02:21.3953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KFKGy3a0Lwo2dN38/sOoHTIeePRLD62JEjPcnq8J/+C9u06LN/eQKEmo8lzT4vuu8jCvlysiGf7VyKOs0vS1hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: LP-fatTJqdCrXOIJUcFwi1i_Z7PTdZdC
X-Proofpoint-GUID: LP-fatTJqdCrXOIJUcFwi1i_Z7PTdZdC
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
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
