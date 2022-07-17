Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCABF577360
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbiGQCv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbiGQCt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8B7220ED
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:41 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8oqx009632;
        Sun, 17 Jul 2022 02:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fu3dxGWg1kX+QcWWeER3Wd2zU9wpPHCmabqApeFlqLE=;
 b=EwjhfSli8zSRRj3ehQglNhMPEbl6PmFFODm+732Jtk3Rn1HBrr8Ol2qUg60T05+DoKJl
 IYyAqiZRcB1KTUuMY7R0LgJA/9Js/dOiHVQtsb4LT1iuZO74DTjATcaRhc5Kqj3CV/zt
 NmxWWWgkSWQwu2gyZtdOqmQoZcgqEBpM6ZBbjBivVEVCQYEiLm+iiVq5E8PmXauH7tzA
 srL773OohaIh+trsTeO9QbAV58dS/+4N4pJeRwlES70392b3+WKC0US++0NhcIeJwMyx
 WNJm2mULicEoH/ZNku2RZDb4hzDqsXWC/q0nyakIx9pU1vPG1xekMgulQsovupbiJEx/ Og== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0ynf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxq036125;
        Sun, 17 Jul 2022 02:47:32 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqCHpt+PzXY+xq7ILFe/3Ft9qrtGykC81KxT3NALLjiwVs4WnC8vLj6J0Mt1Zyt3Q6a5IfgEnIQTcVk6QCbw5gBn4VOsIzAMS4oq6JYkEHHsZ9oSclPnBxGaCsnbK59RUlB8189cN6U8pp8TQWOXaYCArLx4ZlaiVie8gFxLMI1/E+NNdMaxOAnsU7R7IFnJlniDkLFwLvhXVitUTYBxU+l577L1qdPvN8+uqlC2wqTvUNW/J6lxBFWFz0GRumM73wW2r0Cz6H8rGBK2xUwIpL3/ot1XlvOshyVVQBGS02K4OosVRXRFwVHv2uaBdBI6N2qmRCL2gxGg3era1lZUSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu3dxGWg1kX+QcWWeER3Wd2zU9wpPHCmabqApeFlqLE=;
 b=mo5wU3ZXcTFzhAsH0EJuSyBKrwHXxbzuhDuRoitTJNaAlvZeiAnw6H9wrChIl0I1UY4IfyoUHR18N4T1SC7U4ehQJYhe64NsWnmJpBKhd1iFuMiPDLk6C+x4w5Oy+pXu8DE20s0d77GSTeq1xFwLtu6KkVtiy/53RTkOBP4DT45qBnsyF6SA8qczU1AW1VoBxzKge6KERxid1rHVQVevYJQIO7IpvqBvel1/UsS1KulJ2766bQT8nGSB0b5STKkc/qvY7AasWz5c/2J6rT2vXNabJQDR88Ln6reihq2DCnEE+217VCPGhxrfxYQNH5yrw9lZVpFDft0EfS+KDPqg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu3dxGWg1kX+QcWWeER3Wd2zU9wpPHCmabqApeFlqLE=;
 b=FtimOv28eNxn9iZzi52NPoC2itMNZCl0TA/GfEOIjeDf4Ox43wg5/UbQfMVggCUKUIL1FA7cLcoTRjfxG85lzmQ2k9z1fqQexDloFODY8oIohyFqEQY15LHI0tNT+AX7ZSvjL7dT+Vm0W/YZlfZYD//R28Vf2L7IWLbRW22Y/yY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 50/69] bpf: remove VMA linked list
Thread-Topic: [PATCH v11 50/69] bpf: remove VMA linked list
Thread-Index: AQHYmYd5wamGPPBm3U2JfrRAKWaldw==
Date:   Sun, 17 Jul 2022 02:46:53 +0000
Message-ID: <20220717024615.2106835-51-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 01e80d68-746c-40f2-d295-08da679eb169
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6+HFlOTttmFNY9UQJGLPxF/L0VKZwnh8oCco/hoTpPRS/GZJttDI8fhZZqSwJcppftQA4Vxdhzovs0s2vGBRhyvxKteMQrPOiT3BwMCpQg1w/zMLvK7LLrxgY7YMu9JaVitlKGbZlDui67PuomQASalM4Jq0gO7bMGESTMBqLf9sobd4Qt8HWLNetv423r9S0lsAk9e4E8ZP+iL7Trjmg1u6axcQ791qT+ElZxAPo365Wp4v17rpIWN6ltDdtGEkOEWMDlnjj98eLO0q9ATjtsAi0r3esLIEN/aG+ohcDat5jun6KnaU+u0c4tOcQpfJGpPXnngSYJo4UkyoSYENmup1+bvetMfZ9hMxT5t0WXNnWnZzNukPPrRXyZ/iNufdTTXFqnySi5b7HCKTZAPbyJ8SRh45FnFKl18gzCMatnT8gRJ3AlnvBjD9+TTTuKJH2j40Do5XW4c0ODaPxbQEi9IU5t1Ea9uifKxN7bRjkE8PKscKX+tJRFgd9M0p8gkbO7MGrV/r3qjMVA0Y+w9n1ozNZRWp0IFu+CWAW0U4e1M1Mcjq1LyvirYelyWfv8ymDBN+QdQ3Bf3U9T06348fx5VKxW/P5PsaVA4RvHW6vXRGkA6Enw1GYgr3ZQnPnuJ4K2s1+QY8JeDpPB3KOmsED44QOpWAF1b+j4ZsWVV2Fr8Rw5Ub7Zb1X+iHUvypqhAJZ5+lAIXuLQ8Ga+k50S++P1V1wjY6BAAempqhJTsUPpRhYsUfAIPej+3DGBswlxW7YinkpHmhGgtifP19cWiS7tFPtslACE2pLe5qQMcRSIgoTJY8Aq6caqx6AJfutSNIgHCTP4iGCWlOxSQynn4RLiAXtys4n7UT2b7ourbi9oOXE7kcFH6FDxeFTSYp4gDm
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vJii79FttELkkr92ZVNuOahcsgMrKKJynh2oG4p8sqnC0argw3+VuAzKdD?=
 =?iso-8859-1?Q?k+4FbBievMvBWqQoXzX9pK93lGx1EPHeTRmt2wjT+cE5B6xlOggaWClDlL?=
 =?iso-8859-1?Q?FMuYld9HoeZe+1ME4qsCn3+KP3nWlkTCDbbaMrMV9hcsr55+xqUITALmNz?=
 =?iso-8859-1?Q?XLkjZTUu+aSXhKojrQkNuj+vrPID3akf0tUE4yRD16ftPJS9U/yxSaM3/3?=
 =?iso-8859-1?Q?DImAjaRuZ9BcDolLHGL/4ygzi3H4C0gB+/XNWd693gZFN+J3kXX3uUJYJ3?=
 =?iso-8859-1?Q?R42i5OrUq6G8zcIigf02pgD8nvqsxKEhRNTy/iduKkjKEF9BobllDz9U6T?=
 =?iso-8859-1?Q?iajy+nhATn5BsMvM4d8zxH8mV5uMfH/F1UZg+MKb0vIgSSuoLQ/XcV1f/A?=
 =?iso-8859-1?Q?Lx6may0yRf9TId1TTxC99/2o2u0ucv7ILH0TVz82qIRSIR52fjIieoF+fC?=
 =?iso-8859-1?Q?3lA66CI6nufDvu6OHc+2kboi+VZA3+x4DGCOuxUqwXycrPj5yffdIJJhgr?=
 =?iso-8859-1?Q?BcZamGQSVKux1QxROn6KJvE023qPPeHbcly6D9plmWFodbjktp9vQKpwJO?=
 =?iso-8859-1?Q?G8bmSDtl8I4o2ikOiuq5XLuzhIrJXWu22vri+uyYuDvzfkKK7HMPnGpWBi?=
 =?iso-8859-1?Q?iH3125L5SxQG2qi5BiPzV+gygxHUVdndwrNU6m9o6p9bbPwB3wAcfi3vGE?=
 =?iso-8859-1?Q?0j1dckrxtl1JRgpdbwRrWkcj6+z36ZUKSMzjYsQKzbqLKybwkMMKMC2UQY?=
 =?iso-8859-1?Q?N3XTYjO1wyAEkSTmMbgIZKk6M101SZaBlPZMqruht/wHHfl0RX98eZ7hf4?=
 =?iso-8859-1?Q?L1fACd5k2Cp66gkjubm3+V+d6PeqRjXXMIyWkDXhNI3nqU8Tyu7uiTHjVc?=
 =?iso-8859-1?Q?U4OIB/zDJAiPafMJ/ZctzWRXFKzYxLA/MG5UqMxPmitLbE7WLYLxQyJSsc?=
 =?iso-8859-1?Q?SGRB9cE9nagD3MdoYvgf4Zj0Id562erB9/ZAPrSSQ04EFUFZMFFqaeB9F7?=
 =?iso-8859-1?Q?90GLOmHXruhsaGpAvHIGG07aaYIt3LzXTdRtbZoK4YEwzLd85tL0i5cXQ6?=
 =?iso-8859-1?Q?OwqsjJL1xfXnSvNXajcu6LxY3H9q1v3/yWAmEo2XxM0fvM3e/SN9k7iHPD?=
 =?iso-8859-1?Q?oLPOzZR4ZXiJvqJ7p1KLQAHvrc0bv7qe3CeK8y7qSqkTe2N+g/Bcqvm2q2?=
 =?iso-8859-1?Q?h/A0vJZyepf0CPT1Ys1TLObmKEkYEXG7H7mxSoyBPvampi++iAIWl3+uZf?=
 =?iso-8859-1?Q?LNKM81S3rMZJ8oM1hU86/X2oFCMePmbr8HfvsgL+IToEjb7dIZUg3DbqA2?=
 =?iso-8859-1?Q?DFJlCOrcCBWdy2LEzSMwVdOTuoRX78Ieo/NFKU6y62TAcoz5NwNjddmvdZ?=
 =?iso-8859-1?Q?5z0X3lFgdw2W89DV2l2G4mG6GjQCFJdzOyL9fyOy6yVnLLBNzY+IKyH3yP?=
 =?iso-8859-1?Q?UjzoNHm6gdvDPdzs0lvX5kzUNY6vDknnL1gY8uPJbrwGgb/OdhV4HcNvSn?=
 =?iso-8859-1?Q?LRDLcj/SC8hDnFQ2uIBwlK3zw1oAopoQE9jttn89FehBD/iAaoEwIB0wXW?=
 =?iso-8859-1?Q?TSfotZfiM9UHd00Dsg8a3SqqXs+xB/K9FJ0+s4ZFJgOvrsR9GUZq+bhJ6S?=
 =?iso-8859-1?Q?/ZNG2RMp0KY5o0ZNgf4Gu3JDSaNH3TRywx6SVfik1mYV3YEzNOxanCjg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e80d68-746c-40f2-d295-08da679eb169
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:53.7554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oln5wCFD0d6trpJ4OhOvYeO5avKlNm3aLOwWE87x6/RofC/SIj/GotVAshKmQd3EN7DdJV2papJjFI0tk1wBDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: LoE4k_KlLtknNMYSmF5I5ZR6hIRb7Qw7
X-Proofpoint-ORIG-GUID: LoE4k_KlLtknNMYSmF5I5ZR6hIRb7Qw7
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

Use vma_next() and remove reference to the start of the linked list

Link: https://lkml.kernel.org/r/20220504011345.662299-35-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-51-Liam.Howlett@orac=
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
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index 8c921799def4..1c8debd42dc9 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -299,8 +299,8 @@ struct bpf_iter_seq_task_vma_info {
 };
=20
 enum bpf_task_vma_iter_find_op {
-	task_vma_iter_first_vma,   /* use mm->mmap */
-	task_vma_iter_next_vma,    /* use curr_vma->vm_next */
+	task_vma_iter_first_vma,   /* use find_vma() with addr 0 */
+	task_vma_iter_next_vma,    /* use vma_next() with curr_vma */
 	task_vma_iter_find_vma,    /* use find_vma() to find next vma */
 };
=20
@@ -400,10 +400,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -417,7 +417,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D find_vma(curr_task->mm, curr_vma->vm_end);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.35.1
