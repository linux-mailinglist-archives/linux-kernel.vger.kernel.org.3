Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91F5A553C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354714AbiFUUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354453AbiFUUsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B47D9E16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJLc3Q012614;
        Tue, 21 Jun 2022 20:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=W6mEJyr2hxfZjGMQffZpiyQB3+2xGd1dXeM3BPPS7kg=;
 b=u7OMr82f0ztvHxIfpc5B+mNlF53JQwEtaz1uBvC6HJeXd5ujKTpPDEvjdoGips+G3YMn
 YOp9cyDly19Hc01ndT+ueMqS1MN9SeU1lnnS5KIaYTcwPA+iCS3MDQzPvlWQoMzKtXnf
 DYhz1N+MCbwlYTQ5VZ099guOXIWCzKhl/vVUaz3hcah9nJZURgo0L+9C0yP+ka+p7zog
 F28xwcF08E989PoliVWJ9NqyqBlpElnRgQGzUaGHfb0Z8St/SrE+36plpLpdz3dzqtax
 65T/VFkeut01cMHbK+qmzRVxn+wtVwt5ChY69uinDNyHLJ+gjcNyvSovceNeVUibZwl1 wQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6khd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhp027847;
        Tue, 21 Jun 2022 20:47:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coT+KXedUxI8vQinZtNGfIKcE8/RfaZ7yPBxMY3nc2M8tOlKlo90OvQfdy93Q81uoVOV8nYUhqkcGXUHedBIP7MkVd3TBrjOMXKbnK5j5HAL833rXzkjDWSGvlDdM4Stph9VL93UWvlnqxb9LfhzBcbOUchz/bb0MxKhYUHcYB9QeT05RFPRtUMKOIhu03bnlBGlZEAQW+jGq/6tiG61UL4LqqfERQk/OsxflblKtrNLKAOeZsHl2JLGd7/IiL9TyPglh5mVXz9nbMjbuMsatq7pKkzKC3h3KjX19Jk3xdOskhXedsMbDgKxuJXK7z37uCC4GlZ7ioa6JVzPFEG4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W6mEJyr2hxfZjGMQffZpiyQB3+2xGd1dXeM3BPPS7kg=;
 b=bL676kF8r5WOH4ZWLH6bjJfegZZmHwICWiZwqBx99n+wQnRbDxHG6scMczzEklTcEejx9R6KWjfKNy3GatXMguojqdmvuHRQMDsXu8XHHK0VO5KLaHYPuPqXyvn1L3UJfXkCntYFhK1ybrLbm4FhOl9PwBrSLJvWx/ADeVhKofzh7X6aamCtP1UaCCdrSExqMYO8L6ANll7YcInFGbj1IGFqJLm5utPVarr6X2Skrt0WXLmBA9tXwi0tZQbubYDJb7eGCv0mMynDzlWRV8o3bkRnvehHqHYJdHIBzAOFF53zOZQbX68fdu6vjiZqso0/kDGd1zuGmkZXAYPN3TLHfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W6mEJyr2hxfZjGMQffZpiyQB3+2xGd1dXeM3BPPS7kg=;
 b=Jb2lxUCQc7/4J+lUhhPduufYkOhH5LaFqlNkh+D14GyFWYBrRrU6w15Och7MfjZZ0HL/1/jfEsQKNqCRCfwvuv5ZrZmObLkegvfvJkvrWKr36qYUYWnm7DE4EHjwYLXoPmevrtoJuYnzZCbY2+MsHPuceshMQZ24ab1N2h+y1EA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 30/69] arm64: remove mmap linked list from vdso
Thread-Topic: [PATCH v10 30/69] arm64: remove mmap linked list from vdso
Thread-Index: AQHYhbAPSJCY5ZS39024PLpSk+x2Sg==
Date:   Tue, 21 Jun 2022 20:47:02 +0000
Message-ID: <20220621204632.3370049-31-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9404b25d-d880-42a5-4a8f-08da53c74a49
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB40255149A062CFBABCFD1592FDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EuYG4HutSn31EIvKZ8zr+T2/DidYyAkJVvXz5IkibytuCJJMVv1RkRaGPR+g2Hfwx36HoYgD+fDPuoXAKWglYK/3LN52ch8BCRxXeLgbJznHL9ax9oaHVVPvoHBTiVUUPIu42Urw8//h+gtiwYYMtugItGw4MzmaiM287BcDbyE7hSn5hl8veBMXM9QEALpaDEdmlFdTdeGEJAPgNAjlYoqML8I/J8763Xl78OQqcRgTDllGTMie46Y87T8Fx9VCzTNaY7/ndIXoRhVxPyiv5CjynkL+44KHAL7lRsNR0Qo9AftU6lTI1GCIlv7fZv05chGBN+A8QIjZYN/zgGHBDdPljSSbc8bWaMDJWH+E2c/45v3bZiR1/c2uSE4FnvU6p23K2d8JmLPwWFw30O/hMwyXzSwyLHjzipEL1v7si4mfi/pKQVtiRqZQr8M36ZsFiuLeH7A8jv7+BPCKWDGHUvsE4bXVZq31jQXpnMYhhrN3qt6P+KHOjFnPK4NG2r5M5VILPnpnFZlr707sL8tBLqoYrL3zVnwKQ+SRG2lYy+KbHLIjUFYkh37AxejrWKg00hgiNbZYCSHhI/8U0b6utLMHQ2c6iWQobVaIvRdRNgRQQckSEXkzr8gqLQNRxXUJu4H0RzD610ylO4o3g6YgB962YBvrN1UReHP2dw4jGMrUuOTCLUQITe7liptRDFk4Yr7prXw5R4bTvh5DkfdcTKSFfzTIteWVFaZvxDUy6C2kQussFagT++M+cjv3MVy3NkmUMAmptofsIEvAcg+l0fOR2nRpoqJStUnCbFfW3rM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tc9jKo+gGUBF1t9EMvzOWhJmOtzitg771p7Q1ZktrgRz16ZYc6w635NbTE?=
 =?iso-8859-1?Q?n73xOIEq8J50ODMU+jUOW4HWrdEJG5UL61ejxqsp4AG81RxdXQESgbCitK?=
 =?iso-8859-1?Q?TnN1nZ4gL026FEh4cn/K0M/A01I54H8JEO52I7tnIEaqe794Q/26ZBGpOV?=
 =?iso-8859-1?Q?Wk2JpUJeL/lV/IE22XZmKRKWKh9ExRuNrX2Fkfc+yzTZULwa2DfqR/QEfH?=
 =?iso-8859-1?Q?jnco1nfGsS3gGMqdRiCpyK51KcvUGC8jVjRq82YwGING3WD60bg10jVJHY?=
 =?iso-8859-1?Q?BvY9xAfRPt5VoEXj5GJuZsjEPv6jMcKzkDZn4mTDQ7Kx5GwMCsFo5Gj4Bb?=
 =?iso-8859-1?Q?B4fBF877U8Ia0ZuOkReNqVPdnMjbJARLGMte8vu0zXAEA4ZLGiSpfWtY0f?=
 =?iso-8859-1?Q?KFm8C1MzKFeDnYW6LeTAQpndeDv5mtJ91s3Mn47yA/jIuGUbs7XxXsrefD?=
 =?iso-8859-1?Q?aPG5ojLDcmL70ICsMFFgE4EkT4XZmjDQDuhwDkmlxWRTQXvdA2h7xZ067y?=
 =?iso-8859-1?Q?zeaYyuPxRbU/EUfS7fIezOB24so/MfLy/qK+XETHkFDl3K6tmJjiqbs4eW?=
 =?iso-8859-1?Q?zMXLVr6N2zhQB19iZwbAlCH4R09hK3WFiHArhV2SV3fU2zvUIAqh2tzMmu?=
 =?iso-8859-1?Q?u1peP6TXkKjx0+QaUr+HP7YNt+yTJELIMbH9m2eJLXL8yNJ7JlXjVHeM4s?=
 =?iso-8859-1?Q?hN135+thmyRrNT6AzkCCiZnlOB9ijorFmo9mTDD6VZ20IAAQBRKB8E2yrD?=
 =?iso-8859-1?Q?JvY+7ND7Mh8rBZB0pWIGC8FAE5LGL/BHkqDW/6J3OGZ1QRPeaAPYdvig1F?=
 =?iso-8859-1?Q?y8QdlOe/RF5FpKoBxkz9Tt2/uNiSH3sswDRWIsaAkF5XDUvY4zIhrUNIFg?=
 =?iso-8859-1?Q?MXf2hU6yngcgBXt4ZQ1o5NclxvjXyyRNFR0UqoXSmGUakyQfywIqxjAkBr?=
 =?iso-8859-1?Q?gDZC28mB9ioGfTNPe/J5AvQv4uFvd4fa/Nkdq+4nEoGeCtNN+Ko3zLmc6Y?=
 =?iso-8859-1?Q?P62nXWCRdQWlFO6QuUUr2OfimK/zttXg7K11KcCwxa5Z0MPBahtKGAmssb?=
 =?iso-8859-1?Q?aaHVW6WX7YXd0eBfEm84nqzdtqbtlg7IdnUkkhNY0uZdS+Ukqwk1ujleMe?=
 =?iso-8859-1?Q?8xSoR1ikttw8UMgccGtU2LTUXrWPIgh+D9jBG5W3g/m39r8C7BTulQ7fr6?=
 =?iso-8859-1?Q?d2NAMTphWZfMKtvHsvFNThd+3XPur7ctyqfJ3R5d+ZlAVhy/0mC8nw4M4I?=
 =?iso-8859-1?Q?T9FF/jaHF/JhGy8LFCAXPV38rMJ2AJOcCZ7rzKzlpwJQt8/ZfgyYwUcXx5?=
 =?iso-8859-1?Q?F5mDFsAGT6x9reLIoK7zTrScz80O8j7yGaJUVzl1E1CJaZdqr9878m6yHx?=
 =?iso-8859-1?Q?YZ6ul094KB9ZeIAueS3P5/olu+QfSMNgWeIfHgEG7m46VeR3icjRvh3eMS?=
 =?iso-8859-1?Q?Jm7XcEjK1LRPOQ3I3/d5GwEFvKrffnMpUn/biNuf0Wm4Qia5R8p1l9zlV0?=
 =?iso-8859-1?Q?w0Y5jjYjgjDHqSof7KUoBrGBV85kWHrdTLmS3xYZ8iPGrp40VJxqj92QsW?=
 =?iso-8859-1?Q?B69vRLt5sX0DaOdgSrrO8SgR3+oZxgQjxTdnQlbHuz1WUK1ieuivPnfFcF?=
 =?iso-8859-1?Q?imUitHKo6MRWsekGPMq/Lc/Jjr47COAild/x/ASef6RcXsnaz97gUSy+Hw?=
 =?iso-8859-1?Q?qEfLmuuqtn5qyqrgfeg2jCCeeyi0iVWINonCXeXgihSUNBNJSMuEFoZyDe?=
 =?iso-8859-1?Q?Zclu0lJfdhG7N7f5n9sK0xYqvvpqF4oAqPvucrdqFefpWlRjrTHhw2nRXQ?=
 =?iso-8859-1?Q?P6AsFWrrSVNdeW+HyK+tOeq0S+WwKC0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9404b25d-d880-42a5-4a8f-08da53c74a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:02.5194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+QzfeRswYRONM3KcCopg2lxzd3xyaTDqiBhiq6VleUV985sAwRAGG0eDGGuRajnAUbZIDx4IhiK2nf34P54IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: Q3bWDeWc44X4IxANSIxQ68MfGUXVQIYh
X-Proofpoint-GUID: Q3bWDeWc44X4IxANSIxQ68MfGUXVQIYh
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

Link: https://lkml.kernel.org/r/20220504011345.662299-15-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.35.1
