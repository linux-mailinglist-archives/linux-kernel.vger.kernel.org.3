Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C8557ADDD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240990AbiGTCXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbiGTCWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:22:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A77E6F7CB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0JPup031784;
        Wed, 20 Jul 2022 02:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fu3dxGWg1kX+QcWWeER3Wd2zU9wpPHCmabqApeFlqLE=;
 b=NDUnIJafkmUArPG5ouVN5x/LmAy6xGrPzeVtaLjHptfLNa51zf0qYeF0El76QSdOJmYG
 H1dX6/1jYqSa74yVhkd/GB5xqfyVIMeMg6vgnyIph8rzvr5pqHtkev4uwoTShaQd5kHr
 lXNqu9s62aiEtr2vRsZhlFzGx0QcMiJs3eZB9zVX34WCvkGcn/xSNGpezpqYhveDDWh7
 fnt7SCiN7gtSAcR80uE2CeAdRN3/XzUDHYQssiPXBBKM07YXU7+CF733SNEbxpvHgpRx
 YPH6Qv7+eIva+cuD0g8kuqoWb0N/Pi/zeYjtP0qBMaBLqbVP68JVf/vlDtvDq1Q+43u2 hQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6bp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:41 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1QlMl039258;
        Wed, 20 Jul 2022 02:18:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k59311-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrGPiPTsgAl4OUeJ+pLwUexaQ+UvnSyv1lr7wupPe2DqP1FJ9ElB8Bt1m5BGsNcNcirKfxNq3SIO27tJ1wqQbA4yTYkZZuf4uGl2DxKiL+tPDSHdx3RZ5hh2/XxDmOV6cZznhRKL0OC540Xr3vA8TNwGPpSQsIvwpayy+UK0g4QBrrY3PXvF3eR7uBtnWQdWbWmX4bKWnzlNND7x3aZarkC28/pzpqN9mKJe50pY9FYfdcf3Q3377uQKDJB8SZv+4a0oZ9ZzJSURccl9d8bDl4TVk2hLcmh1a7kr95JO69Nu0nGDLZLYob3XwmzQZAhWG8Dthjj9d910FW7uB244dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu3dxGWg1kX+QcWWeER3Wd2zU9wpPHCmabqApeFlqLE=;
 b=KGGlYoOQK5tCvQ2XzRHTmq26/CBL9ZzfKxk5wOpYzDqGAjIp5cVNEHJLlVFNSKnqh8qAfaXOGmaiAo511flNZAIxVw1MKy+6WcrYgbL8kfEMJ2bJy2TG1gdcEzHkKmS9OZan9QosjD1yAdUY2rPpvNUsyzmhNWDWQaGM0vFqFVsbo98fOG5vzHnWvkTbV2YuELykNkrX9T9TMbRLSOC/UpoJZUbVmVJCuOcMLfviSem9MmLUS1ioRR+Sa7DBoi8c87rdBCJychnKesBUgI7AQ28VNM7N2llUh6Y/OZ9D7yTnzla9eAZu+qbCvXt33Vq37Lb9ZIrERQC8rWOiYlCBpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fu3dxGWg1kX+QcWWeER3Wd2zU9wpPHCmabqApeFlqLE=;
 b=uhYbzgSuGSHQNWThzoZmF5yT1ITuScfFelPHx+wVOIDFQcQ/p1ecCSrjkacOQMDXvC6gdZlc6m/3bTMjQ+FKxgbuD4DJ24b6EZA3JqsPNkPMGqxNnZV49wJK7XaiFCnIUuJ6qg0mi0uFixSEYyu83Lxbsqewr41YgoHBkvLxk74=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:39 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 50/69] bpf: remove VMA linked list
Thread-Topic: [PATCH v12 50/69] bpf: remove VMA linked list
Thread-Index: AQHYm97u7uoeB1ISQ0qKMURxiqXmPQ==
Date:   Wed, 20 Jul 2022 02:17:59 +0000
Message-ID: <20220720021727.17018-51-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e6d0b37-8c10-42ec-1842-08da69f628aa
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WXXfVtrZnraWPvjBN9ZrhmNsyWaOA78r/DKaayykr+DV73TFgUWO+hhdMszgpEKQJn1TSFH5bxjbZ7vz/4BSSCGSNF1Q6t96LKdXYf/ediM0rI5lp5y7pR1cMz8HttJETOtjvujfwz4Y15PUf/nS9rqBwRdgjIkn7IqNwTuTi993SEtEwJcnD0rpJT/9DFydkFlNvWli6srgK1tovsjjsX5K0uiH37rCfVgb6ZWgd83c/tAr12cTPcsOU9bhBKFNwve91CnNCE7ZzwewamvTyujCqJ563whjaWu3KkLaAzfx1+YeStAh3xqiP8S3RAIOMd1/D2g4DoGS5JI5bFznRaKbZeweC4Nzbp2/nMckDlAI+kHdvjh4gDOQ+JKAnw0Hp6UYUODvRUzAJkz38jvWo71QzAamWHjgz+P5D/1bNZOnAL6ejUP7B+Ou7V4yPKzLuQeOB/8j3hrYhDtN0B5sheTyxZfh/lURHZl7n+T8RUBUJPrAKOTgCIm4MB/UHw9va5vEGQUBkDgTe/YrSa8cmRx/M3nR/+MOYTSNNd88NkOR6nq/frRKD8ECL/v+iLQ3be3U2b/PciHjuJpCuO9CQjdG7jvNZsQTTiEiRbtNm0ypbUvTWwgsfSv+2zCKDKG6J0bE9VzmU7fAllsaw59B8rgjREj7w2gSyCsMqO2xIzF27rd+qd9P+bCXI/FN6a2S9Y0dptPcNMIlQG3VHa57E1wB4HffkKriXzAE+eshe/VJZOokQmdkkvHlOcV/EhVIP8F3Ox0JIwXfwGXx4yWKDzeBNFuNh1x/0uy5xvwyMWU9XUhb6TdDwoGJCUszGgcOAq9XXT/zCTYkg/9ODZqkaNZxf9XdyBXGiWuyldEkdw2MwYJiFBiMMciUxZr8TjGb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8/nTGjxFh/1pBDMt1zU09tvXghhNGOCfMNvV+zG1XYoYgSkswFhMKr6LXn?=
 =?iso-8859-1?Q?PHNkXouLUj0nI2i3/cr6wKfZyDASq6GhU5LtADoZQI73+TfH8bO7VT6Q1+?=
 =?iso-8859-1?Q?5MYgH43R7GdF5hpl7dmHHJ31E2C+q0xUkiZtGkKkoOBwYIC+60Llgl+v/A?=
 =?iso-8859-1?Q?/ey2pAT8qkf20pKHQIMK5ekq/28EEUh0KZlCka65pbtF+nlzhAK0rGkGK4?=
 =?iso-8859-1?Q?er8ZvcYqQNKdlEtEcRPLHrMFHYIij5LJtVtxUJ30Edw0bxS3SosFMu+iXm?=
 =?iso-8859-1?Q?NVlIvSLPfeicNg5t42+KTtQt+CwGC4Xg5IOe9vHMSZ7uNPBwLYw0llDsSO?=
 =?iso-8859-1?Q?nrmqVilukz6i3jQ1w3aHFR900/u/3GHj3/2PP9kDemas9HOBnj4MvQoPC/?=
 =?iso-8859-1?Q?b4cKUl++0uZvRp3sKjXfPs5Dl+isowKQ4the5Yd0KPSvl+v5tYsgohOd+4?=
 =?iso-8859-1?Q?Lbt9SfsHrUg7j1ohB8knKa53gXfVumaB5NLIuPCxN1Xvks04uHHUeRlxES?=
 =?iso-8859-1?Q?5m8vM7Vtfggxm3ad3igr+SBUUNs5p0Ol5wMe2LTVKue9jSsJw3WRgu9RRX?=
 =?iso-8859-1?Q?RvpCGOePk5eA+Z7fRwyHohcFXF+/Ts7z6ZzAXL6XW7ul900XpwRM7EukEb?=
 =?iso-8859-1?Q?MlxQCuYGdMsoeG5gql9xgebenSZ5Xbj7qkgzRH9yz71A87HVehuz0lMtKv?=
 =?iso-8859-1?Q?XtsBUM+OgQX2FqDdxOnhOF5+EEWZlz+nxEUo2cluo5cadb4r9MMamnCkku?=
 =?iso-8859-1?Q?39I9ClxgSiAj9OR4wFEHaFnaSvuGFXMJ7qrW+KpInQtt/HS/+V9gou6bJL?=
 =?iso-8859-1?Q?/LaCEmKn+3UdOOGAqB7/uw0tsOurskvAigFfYlhjeuH+1wZrLK1YAZBGtF?=
 =?iso-8859-1?Q?cnYq1grIL8cAv8lJlq8vtjwdXW+ORUJ3eBVwEGoKpez8Q4/gh9YS6cYXJF?=
 =?iso-8859-1?Q?rV63015UQLZ5fsF6sQUWsV1u6jL05EUeyrnLzhq9EZbJitRvFGOgJYfIoA?=
 =?iso-8859-1?Q?xvDmLh1fnIFnLTO5qagFZys4cSlC53LGwNSzKkECQtsecToCTuBxDCS87y?=
 =?iso-8859-1?Q?bTwfgRN7iUDq1aMHiSr+RIHxeTwNxPhIVb9N+BfQpzFzGedZkXCN/mFh/Y?=
 =?iso-8859-1?Q?k+nnf3BcgpK2Jf3+Ga8H56wwJ1KdBLoAcWmxcXUaI+wI/4/Yz6VJcGxaCI?=
 =?iso-8859-1?Q?IL6G0Vcng1V/e3nj2ReB8jfzwUNZ0GNujh+f3dX8cVP89VQlFJAVq2vbIN?=
 =?iso-8859-1?Q?NfGhmawnQ/dIjySKyns6ZCu73LTJ1tTxEG2GB4MMUEu+of4LaPMBmlNuOx?=
 =?iso-8859-1?Q?u5ekZPpNCqb2oFFEQs/WSITGB7Futbl5I3RdVE01huNCto4zs6OmIr5sTW?=
 =?iso-8859-1?Q?TygwPSfq+naOlfPG22Sbz3/utraJ/x2Bhoh9E68+Gm0Gt4gINI4Dlx8p+q?=
 =?iso-8859-1?Q?vpChJOvz3yQG8ujq5dMVxVvr7F+fck9G2FBCxU++B9CytZNLllXwZ5WAHG?=
 =?iso-8859-1?Q?lj6BH5XxysrzwDcp/9aXEoThYZFBJD34H/W7PSDhIUhapbn8gC9b6cMPez?=
 =?iso-8859-1?Q?i3UcJNH/pVHHBAw8IWVypMpJaq1lRpfvonsws9CuZGhSOAG9MEyIzZYgAZ?=
 =?iso-8859-1?Q?kBQnBDILaPwm8wTlGkVW7dYqS2asH9EpDwoLuXuJ/WQE5+jxZySRFKGw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6d0b37-8c10-42ec-1842-08da69f628aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:59.6645
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LfYofAMKzOjJE29TZxHs5Ec5i0C0SzYe6wJp2FEAz4AKaJXxO//rzFFWGCP61l0fbioyz/Nh9dEI23hfASPdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-GUID: XEzjk0H61lG_3krEyp75tAWdgV6jnxu5
X-Proofpoint-ORIG-GUID: XEzjk0H61lG_3krEyp75tAWdgV6jnxu5
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
