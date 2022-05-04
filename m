Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE4B519355
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343494AbiEDBTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245082AbiEDBRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822B643494
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:07 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KTQg8030007;
        Wed, 4 May 2022 01:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=LcODvi0z3t7+VI3ktG+P8hv7ComMeS4cyI1DWwajXjk=;
 b=WpmhzF+uEHYjul93qqndMVg3lbcRsGju9s9Lz+0S3xwir7XfxEQmq9Tlp++nDfR+7no7
 n8xhAuJXEIC77tMw2q1pr/MlY/sSfVobfwyem80N+IDaLatlgc4S44RXejBn0oujaYKi
 LKKHibONm1EjKkqZJUR58rFU4SMGtv/dYFU3CCuv2ZxuD1Et58YxqTdsMwSZGDATyAVq
 BGYYVlV+NWFOm9nWbHJ2qwUb1HZvF/mTc1aVeyBtzegXDWxVPovsysZQzfRGLVJdnFdq
 sn6rTYaG+rImL7dwuL8JhSnNpCZKMEmiLQ+TaUAQhBRilFMkzUNNwXuv0UotNFTd3dUd +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f61d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441Ato7020100;
        Wed, 4 May 2022 01:13:59 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2102.outbound.protection.outlook.com [104.47.58.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922he-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiA+PTqLmPP3UaBoOdWpIEEy5VL/wP4yTpfAGgMO3Kviweg5Shfh2rRjor+0waaDeUTJXeGN6nmNa8xmM02Deoey4p3izuff9kDb2TDYOE/BKHtFASHAw2dk0NkqwugXAniXLSd+Z3m6rcL9RAlj6E2jylepqhm8ZnQ9wITkJMn7VsPsgtZWkvSnIHvxkg5epmEuAz9gpmjNniFwi5+F3Na8SL3uGQjKx/olrR8ieFJcNanhl25xgmE7eNRu6mc96F4vKtiQpFu/CLlX4fvDlLWNnuWp8nBWLglARlVzYeti25Hswlk/bgd0LuGQulKBxJnPd5xHD1En8NlSFSJEeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcODvi0z3t7+VI3ktG+P8hv7ComMeS4cyI1DWwajXjk=;
 b=lMDIuu5ixuOArftM/iUD1Rm63natR4617Fix8zKMUb8gTtuSQLtgxk6s2YKexOeK1oe1qlzsd9NBNg8evY8JAU43+DQv06NgNeC1cLFVGcxZpWcCwN5ge2rj++v7sMRazhYEXLILIq46gQHZ0Tz+AD6YTAS70uIvkKMF2UHR0mZW8CBw+WWBdb5h6U+j3PsB5WUq3ZymBNiy7sCU5NdAV2k80P/XAu2fACZ6gVsyKcSm6EEjkjWhBQ0LEQiurGihSPUjHGG84tq8NMJnL3hD73RhVksWFd3mnImp48eo08aITDvAiU5HB5p20oMwX/+u9oD9IvORcfMjwXz5cJ/m7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcODvi0z3t7+VI3ktG+P8hv7ComMeS4cyI1DWwajXjk=;
 b=rCGu78qD5eaNuVuoep4OJQQETjXuImC39m9rIliC8CLBGUF7U4TgqpHwS6lodCCegAmQncw+CotTwb4Eg3fzdki19miyTNeOqPD2/K0aG2I44MpooiJZ/s9BuyiaA622uvO0qjw0Bnmon4IW0kg9PRYrzatr1nrbxEhFkYdB+n4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:13:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 34/69] s390: remove vma linked list walks
Thread-Topic: [PATCH v9 34/69] s390: remove vma linked list walks
Thread-Index: AQHYX1Q5r87Vu6bkgEO4R/OeAcaPug==
Date:   Wed, 4 May 2022 01:13:56 +0000
Message-ID: <20220504011345.662299-19-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca6e3307-32d1-434f-e6b3-08da2d6b5d39
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB372835103F9A402ABDF6A69EFDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gB73Z83v0srBzxd0Sei+DnuBBNnDvEmREOze8fWmWkO66WV+TjXmi2JsT2F9uks7ICuBEDy8X+EBsuOjO5sNLi6LpqMe88ackwNlYigSHRRrzSy4HOzGGcoxB/q1VuZMcnXIDnbQZDMmnE6sT7sEkP+3E1Yw2uEZ1vOKaK27cCvLNiLavOJbx/Dyhw9fwWMMDBCeNE2G1Q8+z9i5r7yTobn86uTOZUmHfaqOLfaRFy5guZMvLOraRw/TU+Ug4wxaHkJ0zFMEjjVPhBdpl1e/ASlz2VAAr8Sp+ZVNlMCdJAsrZmugQ2C+dVvd1m7/eRfcMLfTal9BqRW6bxtIq3QKNp8qC8s+EE8WJZhlsCQ6yhZYCWEsRrUxF22tkug8f6YLWhZWrEJVgf+ePkwMzzTmbfDu6NYvxcX/0HLnWuWj8O7Kzl1gnxHrSxfNWnniRrv22ERBU837NUHi7LTssOHu5N3o/MXjbwMkay8sBNgMKZa9AIyn8QgSdCb+sxXQndtF5W06znIMH0w7pOoGfRcB7nqxRq1P2YAPqIPWce0VFitwiSe9WZQTNSvum+jHSnbTXsuY51TI1r+xulDKAifV+baAVCUuiapiAhQoVu4jjJykvjZ+BabD5sRw6QpOYY4Z3O0vAMgHd2H0Av/QEGwd4kwrWBPQL3FxMEPon6k97chcovHGjqyxLIm3bDCAFBvtvK2YkiPKTW2jvv0P1th3DA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oDXR8jGb2ykzQy5yeL4rS50YxAycZsMiSdjcgnljpvPEMCp/qJBxO6YFPE?=
 =?iso-8859-1?Q?kDjLGAwY7aXQXPv0NTFhUMwFS7P8WhXzChDcHPQhfSVqlQxJ3oA5mqKyMu?=
 =?iso-8859-1?Q?2E4AyN48fCpJzIb1+VHefe0TZp+SHEqn1Pxu26bVWvKEpIHwy2A+eCECqr?=
 =?iso-8859-1?Q?QAbhQJb57XwfVjRXBr0wrGHSGRDFBIzZVSsFOh9/jK5a7RKV3yfVhiD2zk?=
 =?iso-8859-1?Q?MCdGBkf0K9Nr66mfbE9Se+sjfhsDheIv3WFWuxxAPXU0CJNYGDGBoy7H3B?=
 =?iso-8859-1?Q?FLc2pupgJtWX/ClYNA9vqzEYnroP8/TP15tpTJcd1JdUaZU9WyBL/GAudN?=
 =?iso-8859-1?Q?wySo+aVWbXMfWTIY9nDBhcRXZyyhjeXzKTF2QTfp3RSMvysefYZ5djaiBE?=
 =?iso-8859-1?Q?CuJ7O/Y+eZuUryqjmOS2IbSuDNfpFJcgT2Tg8ISrdfYG6ujQfkBTpNGUJa?=
 =?iso-8859-1?Q?tLr8l4Nfklh45z1xpR0mdeghU7N0l0dAtt8WwgE2E30kgDnkzn3/uwbwfw?=
 =?iso-8859-1?Q?HoqAzDuArw/+lCbUMFEvxdyzgOSUjtKXY9AFJnj+0o+f/jfRtFXadUfnsz?=
 =?iso-8859-1?Q?iyLr/+Xh9sV+Qw67VR9nFVXaEKMB5hRla/eUwMVJajKKcxGEdG7pFC2IHT?=
 =?iso-8859-1?Q?pNqZlUxHm0zcOWS8xJd6A8V6JTdb/WjxAb+8hAxFeB3G3k3wX8J8omvqOE?=
 =?iso-8859-1?Q?14PmEyCalH0xd5gLBvsxesyMRRL1YUIat8PJ25yf19RsiB7M6q2pSDNARC?=
 =?iso-8859-1?Q?ZeTTVhy83wpYe13B8TBHDQmt/EMXPLIS1dCI8PcXrQGxvRADBouj4B2iLs?=
 =?iso-8859-1?Q?IRsLNwc0Ym2NYx7gXFF3e7g7cSmPoxXRuj6O2gEjKXkFp0ZCw50yH8mKur?=
 =?iso-8859-1?Q?dAK+Co219fPCTF6HqcIMSxiiC9PUEAbjXA24LYPi+YujmrgPwSuWPfzFv4?=
 =?iso-8859-1?Q?16ubjUtbwhb87B7KhJMCQgBPeeESgtcgxK63zSdEaRMpmkkJ8aU2Oon+Qk?=
 =?iso-8859-1?Q?nzrP3xnlXxQwnsUTH40ZX1sdWA1yE2kbP0/BVmNegYhaLi+OpIn86GSZfo?=
 =?iso-8859-1?Q?g9GWNUCzlyxY38J7TMVwxSSzQo9eOAn8sp1strwk0fMtJ6ioNn+N0oXgVY?=
 =?iso-8859-1?Q?GwRFEHWyoJ4OR9EwEUdpAGmn6FkFxQaNDoZmT9ZWeohekW8sHwUAX4waGh?=
 =?iso-8859-1?Q?ZcZ6+r/Xv/l6b4qKWqrtooFv9ZOHOika4L73UZEf+yC7ZSO+3Ei5g7cp/M?=
 =?iso-8859-1?Q?GLWT8lgSpTH/gyvBXPsjIJ9eFvJt4AF9fi19NO5DpzWI9WLUX32gLtmRbe?=
 =?iso-8859-1?Q?bfIngXFGJ4WAM9BCtSEo/R0jA/zsYWxt6Zds8wdHjImGsZT7cBGQzHMSgC?=
 =?iso-8859-1?Q?sf2lO95DYUFl4k2JWCVNBBxl+lmLthBQPIuCdcKQADNA1R+nycj0qHCqez?=
 =?iso-8859-1?Q?yWYwzdWMcnjQ/XhAVoZM8NaJUE5uzkOgcdp7t0IM4F1GgxvxqDBqhEOvoy?=
 =?iso-8859-1?Q?TC8yUI6QLJPexJTDqBHhGrIZRrCLmaPqH1NO6fv+nRsrSswazJlC2kBiDz?=
 =?iso-8859-1?Q?dZeIJ46gYIMwzB1GlWxk8BtY8lIECTEfzJDoGG2zZsqnIxdXbqOx57cCZo?=
 =?iso-8859-1?Q?X7m+LUkR/NL+jSUWmbHFn/LeR6AOIb41U/VVUuN5EOfWepxE7ii7mEzrfn?=
 =?iso-8859-1?Q?PzbESiRba6jYmsKR7EMry28uD7j7pC9h2vWHvLcaNRNbcNrhjVSxR6hTBF?=
 =?iso-8859-1?Q?pVfZXag/roh1gXwRGbMtx0eq0CguEYZ6ijunHSj+FE+bNYaypWUIcglRr9?=
 =?iso-8859-1?Q?2YNByZjnB+O+ohhWLY546sG2upfvFso=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6e3307-32d1-434f-e6b3-08da2d6b5d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:56.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNSSyGjYSfAC7jNtCq1+k7Cbj4yeG5duklmZqj09WJbG78ixPsRefDlTykOKoTRjWEhUxSzBm/GSYIEGz8xUoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: zHa2kb4jepNBbRxlvev_0-qx6LHIwi1k
X-Proofpoint-GUID: zHa2kb4jepNBbRxlvev_0-qx6LHIwi1k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
---
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 99694260cac9..66f7e7c63632 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -68,10 +68,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
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
index af03cacf34ec..8a639487f840 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2508,8 +2508,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
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
@@ -2577,8 +2578,9 @@ int gmap_mark_unmergeable(void)
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
