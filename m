Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374E34F175B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378498AbiDDOnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378016AbiDDOlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:41:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F33FDA5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:51 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DpPEe024458;
        Mon, 4 Apr 2022 14:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=d/KK7+2yAPT7305Yet/cHNXmxP1Qu4NFPRC5xr3LYnCXxlbV3PIZTCQlgKUbliYoEC1c
 u7bsSqkF4ZPq+7zRbRymsj/Gr03S5nEYPWwiI/v2Ta6OaR9IIm2DnSvOaAPspyLstY11
 4ZsPBqF0rgAwJaVMIuq+Vhe8w5kq6tQSPUbGwh27zJLI0xaZ8EmIs8Ck096ZXUWynGMa
 p1g6BRAZA11g2jU7EY3EeDoiLP3hX4NFzF2j+gTCSZ4rQvFkbtcEJskUuxcOG8LvFTRc
 WBFFCrGDGzUQFb2KJyVDwtNHLyVp2gaPTX6qtjmXST/YP35gp/EsswdUjC1hPHC/yfj9 ig== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cvn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcec027671;
        Mon, 4 Apr 2022 14:36:29 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFgLhFsRA4vQMWMLVAopEn05sJlt2UstVryV2hqh9GlOQkvHKveEPcjeuVhhT5gGexDi8V/kiN5LpIMZa0pu2k6VNghbeyKanZDsmjuCcvAeg3bNJwu2KUphy7cGQqWuD2oIXLPK/L3cbrSpNbpno8u/yuE6pD36IM6DP78po4RdAEKDG8y1tyKyEcobosrAsHtBqUCXrZrM9NWYvMTlD9srD2xPbuM25ZY6dAHL7ZxJMvc0cwwaNNj5NJPLw0mYHugGkAK5m/mDNDNkgEoUCfHDlCn+m0iBlX55AC/wqjydFy6UnzP2CO/NK4s2LY7/j7zfV1Hs8I7qW41DNewE3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=Gs303QsA/3JV8EPpo6mvqxyShK9wnEyNNe6SU3PX2F434SReufl0Hb06o+k1blyUTVmWVfmx4k+Fg2+OFM49O9M/F+fDRX4a9RFSY5wK4c9m5B3kbAmDdVnl7Gi5oAr8buYXrYFEjD1l9exUlK7+HO1uAxXZRJtji8CRq1qfvbcXRJggGqDysPBy/ij6dxErFzkIegNWIbnSmUfAWS0B92nRFIWqyLOL1JyQjF/sWzI2ZjOBA8iOPvUP+yGyGueFHPPO+7LqyCcVOqL7sRASc9QWB1hznUSEuws+bPfJqHIKbTqZ6kudQgsXUGTPm2leuJAPYh8eaIBVQtNLZqH1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNNpUXAHnvfPczhaDRIEqp27wKGBx81nUV4wm7+kgrs=;
 b=KrttPUxqz7KjP75TtasXeRTFZnwSzpQcsOhJOcnYGIvmMyZ5xKNl7NMNplVMsLSUQT1fyMwUbsDp/WSGYGHlANTAUlPVRB7X/HlU7Ty+AWlZmuKzCbZzYj+YIEvdxGGzUag4Czhs5HstAZH8wlJLfit9stFczX3Akk2sf0KCiyY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 51/70] bpf: Remove VMA linked list
Thread-Topic: [PATCH v7 51/70] bpf: Remove VMA linked list
Thread-Index: AQHYSDFJ3GZSq1pFF0OGbXcsTTFY7Q==
Date:   Mon, 4 Apr 2022 14:35:52 +0000
Message-ID: <20220404143501.2016403-52-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6626f64-9d47-4885-0d0d-08da164880f4
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329A51CFABD92ADC7C68B96FDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Brlnj61/175aeIi+EAXPxEuqBCm1y+zOEi987ecJI+rth/twa/AaeqUTrViFr0RDW4hb/7wYUL+Q8rEJ1UdnRhsuLneLCQjZlbLivyz1FEwQtjzG69qXG1fAWV92PCKac2JbXFxTLxVigEvIm2j/jy6yap+QX8YoNMlwhlg3NrJ8vEoRabk4htBinfclx5gmwjChh+siZaGh8UncD435QpG/avD/+N8/Hpef+wRLLpHtUNhHsRv+E74XdUynKlzSz8DFmz7SGXfKd/zQprhp5U+FsTPZOpcDm184eQ5ZLlyu2uiP2eleR5ZZUPS1cSWc5X6SOLDxWY9F66VXB6ldoJhUMxb92BRz0PsIsro+AnDLateKoBEjduW+tnLRNuUvLR9muhGEFubFiuSgJBDZuhpKC8RJlpDxs6bkj5rKHPUU9P2zMaWxYCzztlnGduTnT2cNWHURtDP6ABdU47l4eV6DWq9jGDdua9f3hYYzOgpx1Cz6zE6rBFnS0GiE9KwkW93k4e0YOsH+HC6eRpeAYnRxdSgG5MgcW2GQCVJIm1+WdB3hDrLQGEbHp23G1zQi/lI8cVNVbHURmZ8I+4wwauTjGDnP7qXVWbyx9KyOpotm6NY4Xd6gfvDtlntiF1+5uK4XwdxBjkyiuCfd92RLRLJdni0zG9knYOEodF6hhHI8H1Jk+ptNg7D0Q+bH7geMIe9+OK7Fk/UHEhBTZG57A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dkMpnEKkrHmLen02lToVy+lX5WvE6zS2ZEJIPwDzUHbPV7GY0Rezow498h?=
 =?iso-8859-1?Q?jCmY9gBjqULebi46Mktss2KQfq7Crn9Mq4QP0x6dB1Wp2SZRyFBz3JIBiR?=
 =?iso-8859-1?Q?m/ZqDRGz1Oyzd+2fnD2S5LDYmMrUX8Z4JR9c/GZZKLE1qookKGfnXkhRNW?=
 =?iso-8859-1?Q?GLs9Jrke0NIjOzeYNxfXjdzS+RDtXdSnZMSPtpd36JHGSUkd7Mjpt9gD/a?=
 =?iso-8859-1?Q?5YT2NzN4AxRd3LMvDoh0H7afmQQQsr4Q5zxt1bP+siJUtBQgiaiPYZj+m3?=
 =?iso-8859-1?Q?zCZJX+csqau41le9bj0zvmzt20WX9+16n2r5kYDDpO1S990vTfRdK3NuGC?=
 =?iso-8859-1?Q?FQmzxNRunnnxCfdfdPdI5PtYS7V9eIs3bxd9h8i3unkGUGBxY+CCgVq/2T?=
 =?iso-8859-1?Q?C/+nwBTKM9tPV7KJtgN0GqbbqEhpiADNoTqDokAo5mzkt9mTwem7MsMJNK?=
 =?iso-8859-1?Q?nUivj3jKiWRjowrIOdLQA2ri7VC9yxngomBpI2HWdcVZVIoP3x5TYf1CI/?=
 =?iso-8859-1?Q?2Z1KGWky+XZkPoYMz7ooJhKW7XiTMPlGLlxR+hpIyis6R2q7pd2/0RtzL2?=
 =?iso-8859-1?Q?AEzyW/AU8oIAFqNS9t9ilPtrGP6UU4TyUXhS0mSaFLlUrRvN8k8drEjowz?=
 =?iso-8859-1?Q?E/9yPZs8bYOOniWMzcXTfMuDzgbdZSt9tmxYm4qer84xO6PV3bFGwATnca?=
 =?iso-8859-1?Q?AtBkAkq2nMkNlQ0bYLqzFNxd5bUWLXMkUzElDSO4Dc/KdCrwkwPv/jnsoq?=
 =?iso-8859-1?Q?lgnAke//JRf98CZb7DQWAU0gwrLk2pTe94J9eYwxBxQ93KpQFeawu7kWT1?=
 =?iso-8859-1?Q?wNCVLTT6z3RWUDRLut9ggm0LiP4ETH+9QgqNI+39K4o0u5sLVli/DTyEIu?=
 =?iso-8859-1?Q?P8MvXptfYqSveYNcB5hVGHmC0Or7MYJlzyAioIyBZlmyUz0OinoOGI7h/o?=
 =?iso-8859-1?Q?KKGPs4dkVUcY2D0Qhp3kXz9qAdD/nzT0JLh0QS//zlsaNB/GZESklCkUS5?=
 =?iso-8859-1?Q?8imWp8je9wVJ41i104RXKDqedpnZAml3nDvuFpPz6T+iniSYf7MWOrw2sp?=
 =?iso-8859-1?Q?qNuolS38afknaES5Vo3OP2+vdVLJCuD8W22Ll6WAzNtSPgWCPasHYAoQEC?=
 =?iso-8859-1?Q?K4DLJIyT7cd8vga3AbHQbGqRssad8vZBpPPJELV5gHttDtFAH4JJblqI+j?=
 =?iso-8859-1?Q?m/I9SvAW3bnsgR6ujJlFQlag/hsrIHOeLHGCztXOmWqId4SUcE2M+5/vUP?=
 =?iso-8859-1?Q?BuMcSRu6rFuVd1NzuVSgZPj+Yb2wv3+EG3ayo+Jg475tyYxZdPAAFz/MLr?=
 =?iso-8859-1?Q?nkhnkRxH8CdOcCbQY4YORmKcTfBD08jWswo/UTA/f6W8pRn056wHng2mG4?=
 =?iso-8859-1?Q?qCHhyGKfPPHB/vY3RZYH1hYI9W1nMSieFAEpGtaWKY6DWe99lM5kz68shX?=
 =?iso-8859-1?Q?sngROIoBd7EMbI+x074uyljM/2BwoupOOcsM3MMXdUf1QIWIQqs4DBSHOE?=
 =?iso-8859-1?Q?6t0nei4hh9vbvk3lg1EbakszUm8H5+tJV0znlzQND76KqC6hupra5JgBBH?=
 =?iso-8859-1?Q?SUFJ5VM+mDvPlu1mMEo5aZKLblqaoOOMSXwFhHTjo4NahcNbKlyarfj8PG?=
 =?iso-8859-1?Q?8wa2yE60NtGcvmpHOTg+QnPmpw9OCw4k5hCthvlMcjwwj4vXOnnWaE/g/l?=
 =?iso-8859-1?Q?VutX1rU3aGg6pgqq4c3/vlySVy4ExM9G0xGBbFEAIZ4hAVh73Q19PIeVs2?=
 =?iso-8859-1?Q?iUhIW8IeDRWr8StYwLAA0dWTCHPxRVmTW6yXZw/iNRDg3tQpSh6sTldIBp?=
 =?iso-8859-1?Q?JyV4k+/uDVbQh43WsN9fRzjCTdFoje8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6626f64-9d47-4885-0d0d-08da164880f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:52.8929
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEetHmAsOsQbUG5uvEg3sowKQ/8BinC7CWdmr1Mmue7wGoEji4nvJEUBG7iKn2XsYdNPJFzJAPALVfyg17eU8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: bfY-gzlKEL0mdbn8daOivop-YJDsH7zf
X-Proofpoint-GUID: bfY-gzlKEL0mdbn8daOivop-YJDsH7zf
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

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index d94696198ef8..9a0bbc808433 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -300,8 +300,8 @@ struct bpf_iter_seq_task_vma_info {
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
@@ -401,10 +401,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
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
@@ -418,7 +418,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
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
2.34.1
