Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA1957ADDB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241107AbiGTCVp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241088AbiGTCVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7356C103
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1FaEJ015096;
        Wed, 20 Jul 2022 02:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CnNADhKjYBH1MFV5klbefHTM86YPP7N4zYExGYQsyRw=;
 b=NvUATak4Cx5Q2kXzHL6ffWJgzzB0wYkyCkuZlqPpOwtc/B0eY7ZZUpBP4s90jk4L8bg3
 3WSPqixsKl6w0WU1DRLbPo0coQUs02GQNqFToMVcp7DbFkv9XBprH6jDwuTHVoHwNjjJ
 eZxxhOaSrXilUNBJCh4RJe7hSzzV8GFjnPEIIeBxmjQJz0PBhz7rKpOlrpkHAvPWWN7W
 CwJX5DtzGV69wRUmccHDW7yp5ZybJ4U9MsMDKf/78P1+RF1iJ4nsmYQdIJwp+UHlC2Zq
 LNmg3/KfqtgEzyQfTXucTGMDyv6JhzX6EKwpkvLO4RB+mD4xpjz57GhL60dzlyiVTa0F 7A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42g54j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAle002689;
        Wed, 20 Jul 2022 02:18:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCdZnGFCsR0OW80nIWkwMa/eKnN/fCVt38NEBwI9Io5ugH5l1e/TZqI07IMlQIqLdYGCo6nfWcL7WNEjWXEQHAJwq4fYj3c75JOwGqEpkS0I6jwZx+nqbviShSQ2nv+GTCNoPmgAz15aoaGWK86yPni6hU2Bkv7e5t9PIkp11oYy/EU9whzCLyj290qkz/mWaHfNaq6OXdzdmSNQ1gs6w1awy+CF83rpahFZGsKvGA8DYQv9wC6vcP8/ZxtksHfFvq4qBN8LfgCe5Kcz4usW+12l7jVnKKwp3G182FJiGKsEuIBH3cuTOlzq+9D+UY0RDxcRjCobHvV5RjiVn4ZFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnNADhKjYBH1MFV5klbefHTM86YPP7N4zYExGYQsyRw=;
 b=kKTDGWJZw6sPkIc6YMW0979R8kl7ZmCQUEzEGrafu9tkg2sK+iI7DoiY1SEms2Q43JwkKGsv+vhPMl4Qt4QULPc3oZ2RRac6T6LTbF8ECtuWKA5Kh/OnVsXOeThwvSgX3HnIIFbU7Nzfo1EP0F/BOZ3GkPigkkXfoftS1x+BEMM4nnpqxeKjgSzmkl9IwEq5IME+Q9L2573VHq2Y6cZt13WxYb96XHPCoVcp0G2HlrbumYwTJmZtLVdCgQpoi3PGAupl6yW/DyOdnjcY7Q1iMWWm/Qmr6BAB0AAN5fcsHjG1aWhHhjV3wx7KJQMV4H5wyTjG7ZPJUjX295vaoaNFDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnNADhKjYBH1MFV5klbefHTM86YPP7N4zYExGYQsyRw=;
 b=oEfJJfx8McBTyFoCBrKs/5+gxHzSlVHvsafLZiuGPoNi7+NgrA2G50OpxAos8GEQps8bm/M6bFCwmdl+BmtYAhBmcumjYwczKfohh1EHIgVS0ibF27u4U91oWaU6RRZozQXnRSI5ZtlTYp151AGZJIkt5e2wbMwI+8fRUc6sLoQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 33/69] powerpc: remove mmap linked list walks
Thread-Topic: [PATCH v12 33/69] powerpc: remove mmap linked list walks
Thread-Index: AQHYm97rTj/ZYYGWiUOvogSCZUFe9g==
Date:   Wed, 20 Jul 2022 02:17:54 +0000
Message-ID: <20220720021727.17018-34-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3ac4bf0-e1fe-4b18-86b5-08da69f62388
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PCCvZMrDD5fRHE7UTQSYK89FGXC0XKdtCSKAQO3gvzFsOD7WIdngq2I2V5lG7AkGLMv3JNZso5UJPWI8PQ4uh686iHNRyW4MsZG2F0uNNXoEqAYPENNizPyezWXUlaaM8f3NC8zJd1nnPOD8zrxa1Kqp+sRjqbQnVoi5EBokHKuUkrq+nx3C34fsZfNawAOQGk3tIiaHOa0kv4/ALqQA8KjeGVdCQByU7uXewcQhIUvLOU1SJ9NMVAoMI3UI0sMujjHc/OJ41/hGTY8wud2ZSfhEHexz9SJuSPD+HTxEuM1fAQa6EPSZqSZFZoIqDsqZRIUlZR68yTbbKfM8HlTHqku60pDmLSc1458HZJMeUD7erEG6OsW+NFYvtzcPNN9QWxi9t2BLDolRWFdXOpwCd9KQjFbIxMinQVEiy2OszB9t6ssNb2ndzsTXi93bpiwAo4HEcjUIHVhOqQB8WR+3MvcsDVf8sm+wkUIgV5PL6baJEbLnBW6GliCujHl/6HPIFMTFqD5NHivwjgNwZYJRwRC+rkDfToTa2A70Gdc7fr6Lf0g4wix7UaAy6NPPBas9Jew8LnXaJKmgrd+Twzo9b7ajeSjGk8R4I3zwr+WQZO0OYbRq3s1E/A/U50XM7PhMnLS+52KJf+9hXEHRDDzfrW6Z0AbmGeqGvHkAmMCmVpAxaG4yachuiF1rg9lzqny7I0UIgNlTR0UWtbZAV5sjOtAOxN46HzkmK5C280KyfLBqreph4PaEjIt388weZso8t/zH8p6H4isQX/R3tZwKHmpeldl+dZ3K57IiPXvWnw8Nm2/fBlQKhn7zz3773lMMDa5p6XgOp6YZkdzrRrKenIn9uXbvEwMh+SLQaYN8eXcOZxA54pIo9c8hbN4cepII
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8Wgil/VU9frqrmUyBKlg6GBwL7poACKtbr/36dL28W93/E7hw1uW4Mkn+p?=
 =?iso-8859-1?Q?L1wltQdRm6eY65htZQEyZuAlZ+PFyFwA5NFsoI4DyEu8ryNkRPF3G9UcWU?=
 =?iso-8859-1?Q?Vk+6Vi26ubp8CTVZSpMhNz11/8wlOIwGmdKp0YXRS3bjvUe7rCKvjlQCjq?=
 =?iso-8859-1?Q?ia5bq+C0QLVylzAdIKSiLiDHN0ghyLx7QWM05+uGsZ9C0+cON1nPNkDDTw?=
 =?iso-8859-1?Q?VtoL5uNbFJwZ2c4ihkUBdxR7ZGLEQCvkxfuJ7jDyT4UYyv8mctPxLOu3K7?=
 =?iso-8859-1?Q?281OFy20iLWFU1DOv8vsukyk3veBCNaQINPXC6Shf78gH14Uf0swg+dvoV?=
 =?iso-8859-1?Q?ZNhQXarTpLEaVd1+oqBQYDpuYqRTC8P79ec8GB3H4blIWMpfTryjUTDt6a?=
 =?iso-8859-1?Q?Os+qRP5ODYUMH7dHeuWVRKkBSVnlH+ayGy+9DkUHxEuQM6/nqE2sKJ7yvI?=
 =?iso-8859-1?Q?x1bEPEHcW761hLnQw5Moz2ir1Qz83gn3XqTg+XsyesP0t0O5f9eyyG+Dai?=
 =?iso-8859-1?Q?5mzXJ0E/IjbFSZe8iE7oRm+f8mHXAGTiDEDKYgvnqVpnoGgdoAMbBrlPwk?=
 =?iso-8859-1?Q?KI58q7apIV9oGXNN75FKWHISiihZeoum7IefcLLON8YsNMZ2wT8Cv7GSNp?=
 =?iso-8859-1?Q?hCkf3/gTP/P2CXiTK5V7B0kA+/JX2AJ814F/Fwu3d+FScVyqK/Vhuogm5I?=
 =?iso-8859-1?Q?uyo17YK++V8Cf9CksbM866tB9kKjTAtKPbCGLi0tSRorSUk7Q58IfeLpVl?=
 =?iso-8859-1?Q?kdrBOWv7M4woS4MwP4ZO8yG1SL2NKlobdhj3mzCbpmimcN6KFk1ZZgWe8r?=
 =?iso-8859-1?Q?jntALOAxgyPD413HPL6dbMl7uE7fTlSnxvpWbx7+5zVArMVL3HPw3vxMAl?=
 =?iso-8859-1?Q?u/euIyP1ZOJdP1UxJNIk4KPy3cOW0jHmwo4pcEcXx36iwWxsNruZTeAuhY?=
 =?iso-8859-1?Q?Fud4zFky3CaZHasqxWAOLwxwLGJy+YiLJtd0CKaHjfRZZM5zfwaX7rCS6o?=
 =?iso-8859-1?Q?+pHsAzD0iCwd/hcRq4egPD0jBWc36RGvtBx3f5Dx3DvzJxJBjQ27fFo6Zy?=
 =?iso-8859-1?Q?HK666/OTdJYAf04RfRlmL0uIXg9ov7KlFXBv+eTVPikzfeCVZgA7kajZ0X?=
 =?iso-8859-1?Q?djjiDXBQ5umKwsCSgZ1VpVpBrazLmWnRDGuOSabZS4HSSobJBWmjQY6uIl?=
 =?iso-8859-1?Q?mDdzzfK2/o6/XPM+qPAW7UQlinwhZFeZE6E8E1rwTTGSilGebFDjED8na4?=
 =?iso-8859-1?Q?rSNzjZV7iCuQCo7mETtpUNKKUnWcYsDJfup3WpyMe/3OJYgJTP/jG/xBMk?=
 =?iso-8859-1?Q?GeP47xGDihDADVFtQ9GAvm2cergWylkN4j/YhNCLbldjloEjBNz4ljZdVL?=
 =?iso-8859-1?Q?ok6zQqQBKe+ktmDHxtM28SV+JZ+NHkcbMAVwmPLy4M6Nzy4BUZBf3yYbkM?=
 =?iso-8859-1?Q?Ls6gtkGzyjVZqxQQUAuEoLOOfGIgecCtp6a+r0m+076gOTrbO7ItViatK9?=
 =?iso-8859-1?Q?KvOgO/6YNWB20c66AWl5yr1A0MCsrzQozjbmOWXbZqbTFid4Pft8gY5PO+?=
 =?iso-8859-1?Q?AlAfdTvCkuVTjnJkJHA7uxonZVD80TjS+XWSSiD+0U9rNIi2eQ76KZUPGR?=
 =?iso-8859-1?Q?deYB1QFg61cO6ZVkuRQR9lVEieqTt6Xpvsbdes1WkaS8W7v5yesmIqhw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ac4bf0-e1fe-4b18-86b5-08da69f62388
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:54.8681
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eg/gSOY8HNk5r8Cok7NK1C1TliqNvQuFBKTEur8r7tn4lxuUteau3XMQzDqlhI+JyxC9XCqceJbgZbRZev8/iA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: qVpHdXa9uPHQF0h8qW16xxF-wuywhcx7
X-Proofpoint-GUID: qVpHdXa9uPHQF0h8qW16xxF-wuywhcx7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-18-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-34-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 0da287544054..94a8fa5017c3 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -113,18 +113,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.35.1
