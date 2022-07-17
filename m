Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D1D577370
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233578AbiGQCve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbiGQCt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF20A22299
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:42 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8OBd003742;
        Sun, 17 Jul 2022 02:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fjpGO59yRXHNxvODxonkJUAzy1uFnsmM021t+ph2Nig=;
 b=WuSai23nU1eOR+DJYY0Qskkivnag29oMXtwubRfrFjTPuOJZlDxiJfj3lRBOt3ZyLuSW
 I64pN9hJ3SZrtp5/dNE9nHlk48NQ9Wyvop7Q4IdLDYvRxieqOsnzG6SUdZ/wUUoT8NeD
 YWwEW7b4wu9E8x02VyJfKpYgvC/VKT5ZjYSl3IPGqJM6XdktnLAF2soJZD+UCInC5psG
 UlEFwo8kc+61pX0xHCKxr8hPtZJoojfv09TdiyIBnmLoD3fp4eBKyHKdG2TV4Ql6kNlF
 PmrxdIG22WUTGAmidZTSRmqTvUU6434TGd+DesazVOisM3J2IvIV9xeDlSBtcJTHqT+m 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:36 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxw036125;
        Sun, 17 Jul 2022 02:47:35 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dth2fgpiNP3xRDJQbg5oy3Qy156sN6eYfQDGLpuDXPGhvONXBs2yefjlNi43uAoKjXnCBRlzFn/7KDuUWMt95SpgEzUK+Z5AjupqFKQuXBgGiZK3LP9VkBUzJzkgZ22aMQiB3yoS1tcmK5O0AtzSgjpERC8LM/Zx0xpWTMM1RoIuiTasC4XBiIzVR1w03aLbLTul3Xy7KS3c5THOF7lcjXdx7IN+L90nD/a6AEag0sqVtqcisaNHxK3vpRQZ2DxlW2TZ3iyQqdo5PNdM3Y/XGuA7BCWjZAN9yFAN9EZVGy8+fwxvVVkdjF6v2e1svwpeMGcW8w8bFr0objYtrRZ6CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjpGO59yRXHNxvODxonkJUAzy1uFnsmM021t+ph2Nig=;
 b=UqRqb0cxPiOhG/XHx5av6ajpovpTMY/io2/3PhYx0w20l5bzN8MJe72EoMUmOz72/PJ38VnZlAHUs2eYUhdYmGiKlyspAwlcMJzO9POBucN1s2G9jGzhlj63QS5WKLk0GZ/y8isoIZaq2deecuw9DCNr2mRZAp4eIOmGsxx56GrSBytvpjBlxt9JFvZQ9zeIp2u9f5XYqBmqxCE6F7d0F4Buq9575ptjEDcVeuDtPD0QG6988SmIbfcB75PW95mDTANtxdpdG3J1dWjmU41nxyqNDRxYYMbkq+rY6py9PmMAnOg+JvMQPA7jz+eRAGx05ktS40+sSKu6FDQPja3J5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjpGO59yRXHNxvODxonkJUAzy1uFnsmM021t+ph2Nig=;
 b=RFJRhKuQQW64F5Zpt0ZqcGnhUwIEqloDapvHUQ9ozYBubgDuTVxWlwJR/CmuD89rDOMuzG3dkpI9T4cQuwLwN9aDAhkgVOCfNuakeMbmKNB6nfGa0c8P5P6+v8hyB9Bk1wX2IPF5ToIidFyq6y7F/kSeYEDJ7gqB1n+YdU390QM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 56/69] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Topic: [PATCH v11 56/69] mm/mempolicy: use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYmYd6iiE5M0Fw7kmcyfTKgwdRkA==
Date:   Sun, 17 Jul 2022 02:46:55 +0000
Message-ID: <20220717024615.2106835-57-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 080f8189-6fd6-4182-e5db-08da679eb2a6
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6YeqGJ27DSNrbztlEb43Dk5da4qKe2Wh0kz8aLROSWNFPoKpLIs/UaKkuwBHTJYQ4ieKas87TVHJSR9hOCREjD5DVEjYpH/Gu+/XqkK8ULX0kh6PADVJHRcxkIyMX4GBQ1E04LSpwxGngYx4I2R0p+PTuxyaE6B/NOJx3oAPjkSwaI0Za9TzV7kgwS7Kb3l+CbEyjWcOv3RzPicOCxEswA7Ym9aCOxG8Iwe9Qn4UPjles9bwtI86/eMaLsTN7fQ5oLKrHt0WVieuwHFRyJdpmzgn7F4eiYb1ncAEmYGI/oQal/5Asxy61+71mDoD5af9TIOBTmZ2kLVDNKzvNfW1H+ueouYczjDh5rZaAGMYTP+So3gKC8l0iIzrEVweuWyyLU4Y+Ce7yW+lP2aVL6L8CMTYaItJyjyknT6VdkS+pJKXfVb8Y44p9TRBStk6IBt4OfrUvaN+WgKj2TGPiXhuULzcQQ+5QmjAQA0cLxYG1ccjhhQYtjTjgHO3/zpNgVotd9lCC3NJL8hAOwJZrfGWyN7ZOyxQG+1QBtXk3SIwowofD74CSCG/Dlx8kW7jVwq5bNPDykOwnfE7GCKg3BnpbQqAQSRHLmCVRF1RL6kJ5G314ChdVU95aAn6Gl/FrBKFeG67BtBUGctVix/aAxX054kcSeYoZBBCtIerFCE7rkckAVewCZwkJQ/AxET7xcO4YTvw4lASHxQ8nnA5M5lVGz1dr1Ga+Gnf68KCAjok85WImUvASEeO0iD2r8puEpmKIELEy8pvpTdO4TRw+hYY6vmGHtbpd6hCF17mTyMMxy5mo46w3W++etlD+XgZ3kcBSWBJWc54PbuomwNvyRJOT/atw4NpqiCzktyg4FMZhLOuqBKTkjbd6MKeL8p9Szi/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?j9r88KWru9gO6gpDSguny65WNYQPei1WNh/6Fk2E3T+STA1H5vpa9rpKci?=
 =?iso-8859-1?Q?RrbAfTR0epRrY0VvFsxpVEpJoaehEBTeL37kKhFTscgCCKMI0dHoQYOdQi?=
 =?iso-8859-1?Q?NaWjmzcsWGBAxbjIvyQUgcz3uCE32bxFXiKB1g9LLnOhFKb//RiWUMGi16?=
 =?iso-8859-1?Q?t3d0wrdjSesF4kqKDxVkTEBiZL+BFahwAJSbkg2ly2A/I+uh/Ip8q/8we4?=
 =?iso-8859-1?Q?7nKi7mhj3EELXaxxTO0YXfJk/4qUkouuR5Qa/Qg5zKbfMgZfri0+2V5/TG?=
 =?iso-8859-1?Q?rO6jBfXz3jeCRgBN5u5/kSprU24b1K7z7l4NgxSE/R8aUVM64KWpGskTKi?=
 =?iso-8859-1?Q?U2HZMnnxER0exYrkA7AdiKaKpKAAJ3dXkWDq2KtbyXi1LTIgN1rK7oemxI?=
 =?iso-8859-1?Q?1doKDl1MlV+j2xChyW51FH0LUKtU7alUqnnVwF6lWUDozYdJ5kFBFq9NsD?=
 =?iso-8859-1?Q?b3dojeFMF9H9XX14BKfyDwMaF8AkYMIj0iyH6DrCE3G3ElVId+kMExvew3?=
 =?iso-8859-1?Q?qdTTBXwew89fWA1TKj13jUdhlvBqgdsZw5CikwwsyEZpFKP/83v3wKhxGz?=
 =?iso-8859-1?Q?IgZUV9ensE6zoLduBu+fQX8LmeyAgKCyT98JOLD+EJBqkETjU0q5e72avk?=
 =?iso-8859-1?Q?5mEZSw0RLsKg4+TN+3mucpoq7W1TEFzg5GVFb9E7N7509F9ObSl2X6p3Vd?=
 =?iso-8859-1?Q?eUjDeM6taZ1meUhj6W0q2Bdngko9Z4MkS071+Xx3Z4z9Ma2F67BVZqjH0t?=
 =?iso-8859-1?Q?Nn36rpM4vG/KTYeFTemV0uCYPHnBG+h1cV9WwNXIX6lzD7N90rIeTgxjSN?=
 =?iso-8859-1?Q?ByjWuD+3O7DfP5+u3JGoTItqPDuwSt+hWt9e5LxLxyA1078IVntD2knPY3?=
 =?iso-8859-1?Q?+j79ek4SdhAWYRyL5B6uL+9cMloaCy+6bGSAv2p6tFFeNqq7WPOlTdyp//?=
 =?iso-8859-1?Q?B4/e6fXSzMS5RJ2W6qEimiJsy5xhF8n8jy45VTg9HtBTwukIL6IezmO/ln?=
 =?iso-8859-1?Q?VFNBPUWKNu9UjcbBJ/wBj9IeP5FM5ONdDROLaq+cWlQFXYg6OrM3gST41a?=
 =?iso-8859-1?Q?zIsdy+SeZKV09TGgFEwda74E8TLKXMa6VVLjep2knjbmCPBSZhaE3wbCi6?=
 =?iso-8859-1?Q?XVAunCASCgYYty1fkU5opqlaDRDqOMt9vitYDldrkD0+773Mb602y/hTv/?=
 =?iso-8859-1?Q?MBvP+FcCrv4XVnwvNSpIvC7zllMywl5KEIh0UgVWqytCJhKbj5Z1JidsFk?=
 =?iso-8859-1?Q?91kaY69k1tAHa55AXXeH/TrHFy+X++9kBykjFO3zu4kEhQ8yLOcbJmv3hM?=
 =?iso-8859-1?Q?UAmfidQLGcdtj4UO2e+EA6oUdJI+okTjCffbZq3qt+CI9S2OS6i3dlEg43?=
 =?iso-8859-1?Q?MKhuS/DZ28yAU/vrIJKTykR2UmE5mHRUUgWrmFLZOhI/gGP4WJLGJUjmuk?=
 =?iso-8859-1?Q?OavGDL3sZL12UtmE8n39wdCNmFN+P8K2cIyqXM6rGjGQfj9oKoLf+N8CR/?=
 =?iso-8859-1?Q?obmCVHHL5ioYZhRYOBDouH3FqgFRhnsV10YiJF2xk6dvT2YjmLjbpFsHAa?=
 =?iso-8859-1?Q?0BcGbc3rgcgaTxZ3nhLElSMqNWZzflPZ1sPBAy7xHUA9mOTOw4M0uIzJgl?=
 =?iso-8859-1?Q?aWXxWBsC7dZZW50vweHR2tdDC6I14DIl+bPUH7XjNtWCfyjEKeSrpiXw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 080f8189-6fd6-4182-e5db-08da679eb2a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:55.4428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LhqS+64j/UCKiD7wr5wer5ygH3ToTlMjuT9Um/bjhmKRM24geKmg/AGgM+6CA/SgqiKR4YzBe0J9xcmm3IVt2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: fR7fL1h2mxfASMBj-9AvHPwCLMqkRCu2
X-Proofpoint-ORIG-GUID: fR7fL1h2mxfASMBj-9AvHPwCLMqkRCu2
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

Reworked the way mbind_range() finds the first VMA to reuse the maple
state and limit the number of tree walks needed.

Note, this drops the VM_BUG_ON(!vma) call, which would catch a start
address higher than the last VMA.  The code was written in a way that
allowed no VMA updates to occur and still return success.  There should be
no functional change to this scenario with the new code.

Link: https://lkml.kernel.org/r/20220504011345.662299-41-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-57-Liam.Howlett@orac=
le.com
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
 mm/mempolicy.c | 56 ++++++++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index d39b01fd52fe..d5993b47bdb8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -381,9 +381,10 @@ void mpol_rebind_task(struct task_struct *tsk, const n=
odemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -656,7 +657,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -671,9 +672,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D find_vma(vma->vm_mm, vma->vm_end);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -787,26 +789,24 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
+	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
-	unsigned long vmstart;
-	unsigned long vmend;
-
-	vma =3D find_vma(mm, start);
-	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
-	if (start > vma->vm_start)
-		prev =3D vma;
+	prev =3D mas_find_rev(&mas, 0);
+	if (prev && (start < prev->vm_end))
+		vma =3D prev;
+	else
+		vma =3D mas_next(&mas, end - 1);
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D vma->vm_next) {
-		vmstart =3D max(start, vma->vm_start);
-		vmend   =3D min(end, vma->vm_end);
+	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+		unsigned long vmstart =3D max(start, vma->vm_start);
+		unsigned long vmend =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -815,6 +815,8 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto replace;
 		}
@@ -822,19 +824,25 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
 			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
 	return err;
 }
=20
@@ -1049,6 +1057,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1064,8 +1073,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1195,14 +1205,13 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 	struct folio *dst, *src =3D page_folio(page);
 	struct vm_area_struct *vma;
 	unsigned long address;
+	VMA_ITERATOR(vmi, current->mm, start);
 	gfp_t gfp =3D GFP_HIGHUSER_MOVABLE | __GFP_RETRY_MAYFAIL;
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	for_each_vma(vmi, vma) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
=20
 	if (folio_test_hugetlb(src))
@@ -1480,6 +1489,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	unsigned long vmend;
 	unsigned long end;
 	int err =3D -ENOENT;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	start =3D untagged_addr(start);
 	if (start & ~PAGE_MASK)
@@ -1505,9 +1515,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	if (end =3D=3D start)
 		return 0;
 	mmap_write_lock(mm);
-	vma =3D find_vma(mm, start);
-	for (; vma && vma->vm_start < end;  vma =3D vma->vm_next) {
-
+	for_each_vma_range(vmi, vma, end) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
 		new =3D mpol_dup(vma_policy(vma));
--=20
2.35.1
