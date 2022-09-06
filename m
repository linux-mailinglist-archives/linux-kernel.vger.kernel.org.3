Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A103E5AF4F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiIFTwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiIFTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2352B786C0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYZg029954;
        Tue, 6 Sep 2022 19:49:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=pBApEGvbVXF92BIwFg9Brlkrk8UlVdTzk7cQpqnTWws=;
 b=SqUx3FL7AokuAfGoRVjI85MTQOH7QE4LJOhmxuN5AagO81FPJsNHM3tz+hAI2njOTHSr
 s1w3djpGA9PMarSxg9NsvBz2thLJdmbO4pwoSn9Kq84/IUlaUeB/myufuAs5y1+Zri2g
 BvKK6UfOYJpf2dbXWKhciRM1PzRvZvJfWsspy6QIhNxeN6bpA3uOQjzGYW93y9w1zAb3
 1avR/LxeIBu+tpbhfkNJdvLXKWskrCbUuFWy/yyYXbky9oe0kIHsTL1UFtauhu1ATsRC
 V+j1vuC+CLrWQhx9deH9AycN82rXUiXxBXUY6CEIHPILCpRcN/3pPIm71UQI4d+Hqtpy /w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WP039711;
        Tue, 6 Sep 2022 19:49:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxhToB3539Y2gegTW9frDfcbIufBor4Mai13JybGf1+VoivZbyzhtZHJGDTUMoQURylkG8ekjyuTe0KBZK5ilkKIu7bT+/ZyFzj5eCurYyA2GVuxISk60i5t65dLK/kVCTiw5kMR/vnCtzsTQ9rRD4QFBXUAGURlX9esE8dtmYWuQ5csomqf7Z2WdnLUseisR9M6RGKNzVDPrnVrXC2kw16IzSHgXDUmqXbKI4s4UNMBWfYuEXLjEIvdR+YZz0qe1DqGGhE/lTAUuTF+pvQ9e0+RjS5/Zd23Ty5qd4sTD6puSgPMhqB2pqXL6uEdH/lDeZzwsQ7ID/6M8yAFLe9bgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBApEGvbVXF92BIwFg9Brlkrk8UlVdTzk7cQpqnTWws=;
 b=XGmLOTaXREcw4EcfqkeaGqMaiBl5aZh2eFn/jhJJNLLtOEXf3hkWYdX4FKPnr2Hsfu93Nk3xW2rfmvW32Na2Upl4EmRa4O9oG8kd8OF/A1uPc1en1gGTOFn45tEMh90hfik7BZ76uOo3+rpwkhUApKzn5YuHMSvkzjFzV2mmGRcGtMUcIqILdXaMcb3e46lcLkOqJh+6DWPtcPx6O7M8DjvZBrr1hD9uDJxLscyhAa7uO8zr05eYczXS7/4dv27Eh1dpDMuR0Q0TTS88qd058f7MPi2w20M1Vh9Oxfzwa/hyTGK6Ar9+MVotOQWUz9ROal4TO0IGePNFPAHDLDC6aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBApEGvbVXF92BIwFg9Brlkrk8UlVdTzk7cQpqnTWws=;
 b=ak6Kz6HIYuhViWQ2M9Nsoh+2UMyRDIdYUBpy6ckIYJxiVsMVQk1qEbAaaeBkz63P+K8LUOaAeM+07giZkOjGi1v1jaabBfmSLVvjAK2pE5fVAk/fAVUfkPSigEnyQKAQK9P9KQCLNn46nOznCTgQhJBOlVOcjYTWt0WFj/Bz3/0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 34/70] s390: remove vma linked list walks
Thread-Topic: [PATCH v14 34/70] s390: remove vma linked list walks
Thread-Index: AQHYwimx7yHW9WZ7nkWwMOHVsWp71g==
Date:   Tue, 6 Sep 2022 19:48:54 +0000
Message-ID: <20220906194824.2110408-35-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1640c5a2-1893-4a2a-9c63-08da9040ed77
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0M7+OI3EYiTA+YTM5f2KrYNdWa1QfoLi/umK0joNs/Xyl4x4Xn4a3Q1H52IB1SSgmjv/YWb5g9RssLwXUd7Ju2V4YAl5gXUk4TFgHG2XuhtmIfLMespbaN9cwRUorNu6uo/IIN1eOxt1X2x4kNTOTN6uZXFSRSgLa2zxlXv7qWkRt+MTepGq1NlfIXuyjKQj+EbumO4bf/EE6F7MJQ1z34xQFWd64jFXjWwaZpAk0D6N1iVME2rJHNxJyteqPDIftQyBlm8nu75SPzt/ZHMbpWyoh0CWthesG+Aa3p7ius/4w2fmSRko4niY07rPTn/crMXLdgfclWIPaR64tUFTsCcSurfiKOpHWl1tYtBSmw+1QDCPwTbKqWQwi9M0NA+r7YvJOSiPSHGsuZTLRgkmC499saHy2ZzKJN5LI/fopYnlWVVlGrfWVTo+38CnWWs7ofYTzbZSSj0hneBBdVNolpH8fp6BfxWoAhe2LlWS4yKSrtdl7QOzWXP0qfUAaLNI20NNz4NKW1wdZqPjb+NZyyqEZ4keswXFcyMTOtFiPBXE808cwHsrKl0KwujiCnKFdCAv70zJy4ILYsvpkp8q4p+Y01zX/R4rAtypNpH2e7k8mL0fLpNAcQIDZ9bbA+Hp3OLEwmRyxLvqkBrLimBXK7tQu03Smvo8nnKnr8KS6oaQMq12f4J4cLALsPLdL5ftU+Q9rDFU+zicZdIUmkKchaTpTz0uIAuLSeM/z0RChLOrhELUtZi4++ba67QTTefVwU3Wgq/0uOD+UeNJvrXOrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uX4L4+O0jHtJliDsmeTY5WgfWUx+oUrhe3M+isVoXMy/gFmkqMMR/5OFdU?=
 =?iso-8859-1?Q?oQc4Ew/5Xao/O9CU6qtX2eP5wLosB1ObfqDxq/5h1DIxa7O2z9wpGxiQQy?=
 =?iso-8859-1?Q?fqb5Fpd6odivgfyeiqvAEKFg7ihq6VRmBorBWt0vFF+ypLWaHNEflO9dGb?=
 =?iso-8859-1?Q?AFHYlC76z+j1kWZiZkaXHMu4Zfik4i21imfStn9IADyy+aYhiNhkUIeKlv?=
 =?iso-8859-1?Q?x7Qwo0/MA9ox1iQcl0gcaL/wDE1HHNB3PwI3KL9Gy7KQfPXzL4yWpbXDVJ?=
 =?iso-8859-1?Q?+2UStWjv3w+0mQE3AuozMvZoRFxDvl0MJLL5FXcFOAmhPfLAomoLIPcI8t?=
 =?iso-8859-1?Q?F6uR7J4Owu6LTUfup6xprYK0Bn626xZxnj1fe7dYDDY+F5ZescxCbuXrCO?=
 =?iso-8859-1?Q?QTDFnDc+u63jfI7c+VclVUIX+nLNQ6kdkMD180UYTefSbw4tnOj5WzG4Ii?=
 =?iso-8859-1?Q?A3n0NppwK6h2puig69KhL1F8hs5w5IAFetBAgeyFaSia48EMUU5cul9elo?=
 =?iso-8859-1?Q?pguJHbvwHwLiGZ9TusmSOOmEXfXlijZ1FoefDCUjt8YQwFmWq1NEyV9kfo?=
 =?iso-8859-1?Q?iQQO7ctqz4Nh7XeoBr5fRgaV4Cze0EC2RHJ3PzWN0T9czNn9qMNB+sWXlW?=
 =?iso-8859-1?Q?e9JNOK7O2NCZtJ+C/PQsM93EiT+jWgLZzVIzsJzXvTABkvfkx97XrzmqYJ?=
 =?iso-8859-1?Q?bfKdOVbDHBThXALdEk5ciXUIeCjxdkK6BgheGoPZQZYS0IsAp99jtGyWxu?=
 =?iso-8859-1?Q?hGqEQ/N62J0h1RC07HhQZGHWCV/GUiy29sUMKx+BZ3m76bcmeHWzA/MB91?=
 =?iso-8859-1?Q?GkevNkQzuBSuhl1+dy2GLyhmlZlLiZOqwTw7wlfk5iJN8jZxwXu5NS71U4?=
 =?iso-8859-1?Q?Wf+GCCfF8+66PmZpGWXy5htTAQ+Ey3MqiSRmsNJCQVxsPWRu63eV8/YRS6?=
 =?iso-8859-1?Q?Ddc3Qzx8EXXrJUyYSAPpgRfglr6yqv/Xw+uzVhsFS6fDr0+dny0GUOQf/Y?=
 =?iso-8859-1?Q?7BgTxr1UuYEeED5wFK2nN7m7g4GLQ96Xgh/OTmZpXgJR7v8FpR3shz+LVR?=
 =?iso-8859-1?Q?yOb10h5rxumFX3Xxi08k+SQQttUopPCinbvbZa+AdWGKG7QBHhpJmSDmCO?=
 =?iso-8859-1?Q?MlhKHgPpbzkqB+6N+akX+4Xc4pa2iK2vxc9vdIqAdhOMv+zV+jwwDAkaCq?=
 =?iso-8859-1?Q?AffOKNh5HaYNyYjgSn2zKHYeKhraZ+Jw/yhhPD9kXwpuPohPNTutSWMy5m?=
 =?iso-8859-1?Q?c8QGZku+veqX52Ejj4a6d+53zdJ0uvzDuw3JmjOCAFhY9mHSkMJFp4ABg2?=
 =?iso-8859-1?Q?NxplrRuyGMAXsoPEWV8FVsh9AyT4kesqSudjLmm3PJZivYmS9Zf+/pZVnU?=
 =?iso-8859-1?Q?+l3M4e7H+T5KLFw4VLu/av45wzQtDSq6GNiRaILy9Mkkuq/fi5g2sEf/Su?=
 =?iso-8859-1?Q?T4ANtWPy//ieGwkD8ejNSYaEbWyv633kcFcPRtJnOrBH1mCY/n+ZzUcMm/?=
 =?iso-8859-1?Q?8921Ag9pmd82tNkGEM4ADgaSIXKN5G+4JPYzGk+qVXraljsHPHMQn01K3n?=
 =?iso-8859-1?Q?SLWbyYhDe4Rep9Lkg2MkJMaYIxb3ZlgE8pNpEdH1sjLatLmg2Q5d/Wz9vZ?=
 =?iso-8859-1?Q?m6ej3oYFFhyj+ZVVJ0UXCDaAqXYsHDCmMWtqE/TP2ezHGjIaEKU3VDyg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1640c5a2-1893-4a2a-9c63-08da9040ed77
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:54.3970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HMkNNlV8QPzpy3fGoFb0Ph0nPGZG/neQulByn7BdMzu//t1XLHB5Hy8KPXXFW8D3D0WptxRHZpSGEG24TqiTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: I5xJVudibNZASZFBum75hpiVqxeSBqHi
X-Proofpoint-GUID: I5xJVudibNZASZFBum75hpiVqxeSBqHi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 5075cde77b29..535099f2736d 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -69,10 +69,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 62758cb5872f..02d15c8dc92e 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2515,8 +2515,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2584,8 +2585,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.35.1
