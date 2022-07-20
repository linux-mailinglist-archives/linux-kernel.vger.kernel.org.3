Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A702C57ADE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239215AbiGTCUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241099AbiGTCTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:19:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8524866BA5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:12 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1e26h002384;
        Wed, 20 Jul 2022 02:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jjuC+9MW9xZpfMJwM7YXBwJkaZD3Gt/cc+ZyVcrVZMA=;
 b=wudaBFjbnTSc+0N9vUnB9840j/Yoc0+8ch7xPp7rxj4FdgpXNl4eJBkBg00PX/CZgIjb
 iEsi0doIUrEm5+txeowVL5NudpxaTLth0fQC3wLFQQkTakVMBN3P1NXpmUv+UXtaNMLb
 yvS8ZmTrgJqgnVTwtJBM9UoYEOaGrtSQWpflqwXpmbQvnoRFdF/ut7tnZdiTlkrIqRGY
 Ch1/jInC1fwL40j7rgbVA9OO8vEt9fbmVMTeeR9Kj8R2RHw97KTP0uQKxV7mjkOoXWWu
 6CdrQQ3sXOO/5ESD2rL8Vu/WGd5+aGOnhROU0Q0YcR80hEJqfZiCRqXb2eV47Li+4jba RQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0bGDx009891;
        Wed, 20 Jul 2022 02:17:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gh14ng-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHXOiecf6FBgKlpfdXqik5CWfva5Y3eRqrPJsaGh0h/pZnhBpBsL/MxmdhAP4sxeqPwiPluxGCWDPiiGrJAhNhwS6m7rWoGIcSG0UK7aUrARiHFPtpfJ8rqr1dhH2AzR1V+5Xg6l0I9Uko8SiMJBa3UcIDzBPaGoSckOQPNxoDItNIjZ+pTMotSTLwVlUQki0USuKG6z6SJiQg9YUlO7CIrdz4YU3lcupLsXouvTbRIZtDamoMyY5XJu8lh1G7Ub6HbEn4kJ74oR4BPjs43iB3X14uV3Cq1b5jbDaIlMIsLCXJAu7ZELQ4by8TpZEX0/HAdcKtxXIaTnqpfU8KjMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjuC+9MW9xZpfMJwM7YXBwJkaZD3Gt/cc+ZyVcrVZMA=;
 b=BvwOFJHfLBF+vdVHHs9R0fibetqoKppE8tqLWh28v/gc1XjNMIb0t4Mhximo0WnWfV+WnEgmRlOdBLnXsc9BrZaetUs1jKu+VHze56dUXGzCHSaNZtPNuG1AaXZKc45Fk30HZ8gqzATho4tgUIWsgrU75/9biBGdwijhZFvS2fSwMY8rlgMTqdCe6vQRmSmf2TsEF8hftwp/Bkv0OwooGnnhtUu/R9AY75UowCAKt1mS6Zpjp7Gr6EAxZNLkga7G/o58/1ZxqoIa9iq68PFxbxNe4Wpoxmd6JylaLEcmwGFB8WC0aEdjZZSHVOoPWsUgyBZCUE9mAK4sWkjVvM6P9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjuC+9MW9xZpfMJwM7YXBwJkaZD3Gt/cc+ZyVcrVZMA=;
 b=aZ6lrCXXyLcgg7NjNvHR91u0Hu9/UDko+8npoTA9xY2+4IwZwIrSdJrFHoz8xt9c8pyw4ir9WEg6oXUyzXGOmDeS80rJCLJ5XQheNhZa8Inn9hM/jErzThpUkc4yR0GOzrbxJegCN1zrdtdlLTOUwHm2OsXLXo3mSpz4u1sxotc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:17:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 27/69] mm/mmap: move mmap_region() below do_munmap()
Thread-Topic: [PATCH v12 27/69] mm/mmap: move mmap_region() below do_munmap()
Thread-Index: AQHYm97qmUB2urr7JUaeKA/65zT0Ng==
Date:   Wed, 20 Jul 2022 02:17:52 +0000
Message-ID: <20220720021727.17018-28-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1ae3f75f-a123-417f-f65d-08da69f60ffe
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TJj3XPy10gdyIqLeZWH2LCXgBiO/KLYEr0sm4CvuG0BRCJ9nXVj3GeKOZn4viCY0PLJjLBpOIUEPtJVV76sZDrZEyLaq+pDpqYJa/P0QzRzhvWPEcVCncIJDjn6M5YGqeFW3zKDhBGmCB78QOAW1iF6qtuMiCYHuju0hUM8vd3CVRh0veJNLXWKBiK1PLUvCJ1UoG1bDDIjBc7SQY3LQJBXKAeVI664Bc55G9wpf7eEToeFKuC1uAGCf8Hn6KMfAkrHQd4KjrVu22j2CegBVbESgaqCYxouzC/DIXyApC7I2tIf//trqJZtuBh+J/WVzdnZHp5i+X8VYXTX2zxu+/WztxXltDzXe8/Bi7itRE74w8K0jN4EXEYBRfSGrtoSQsLFM7jbitW6p9vQEpLQG0GOxVp+fpvHho/TEGK3xyXGJKv51uZaT5siQFhzYxjaPFxePOWqhdTNskWXvgivhc8I/6ecBBbiaw9mWzluNlFSV3G5KrenVYw16irf09gC7ivE1+GDrhKa1q4Ou6KlST789VeKtUAbLhIMVIt6A2KtCOMzZ4qBrwsmCh/786hsLIXeDszV33u5AUpKwN6b9mpFaSNVk05v98x5gT1+Kcsk+of5m6TWS1atlptE3WOnb2OGcO3c0kjGZgarPuqjoeosMG0naa3/tujBH1nbUduCwdwX/v/hh6+Qh7EGdgKdy6GEHUaIh5xx/61pe92LhdoTGoY5vtlUN1WIKROUqk5AWthqC06NnSqq+imdberkMWoJv/SjrNCsETzz6ndZl8LD82APnd+BYxpG4pGjuFGHjj8/MnQkruMaqx3Wbbo+0qldEDmsAJLfgd6jPGzhEadGCuGqjp5P15CHk4LlgzOwfSYawlyz3rFbgogUx3YT0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(30864003)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?COTdhFwonNyJxVZwKmaaq+i8PRlSyshTSag5FnpmwcWto8AiSMxkv0Zlk5?=
 =?iso-8859-1?Q?ThT1+f3QnKdsDX+xfh5lAhHSywB4XkdBP5sYgt0jjdLgpJhXIihZrcCijh?=
 =?iso-8859-1?Q?bZ+0+YBUEb6/yIwbKSdJQUsVunOI4pkMA+rRdnLyAN46bI39AxF1v5IS+P?=
 =?iso-8859-1?Q?5dn89uRETKYkLSDaE2tO9VgAT5k9IVtaerffvCIktPK19XaAP134ENFQ1E?=
 =?iso-8859-1?Q?4PLNNnEZsI2hl0+NdY5o/eCzXgfc7wmFZv3+NefiJ8IOOZ9+eFDsq0oJAf?=
 =?iso-8859-1?Q?YCWhg1z2gPExH+4Mq+SgnYNH/7qZ97IH8YcACJugBmv5o0px1+XTgUSw8f?=
 =?iso-8859-1?Q?QTLaXidhk9gdryEQDCn8B5ekgW0rQvH9dKfI3dqivhxG4/F6qJW3LV6856?=
 =?iso-8859-1?Q?vox+5Ty+Lv/EomQ+gVvG/fjT7N8WdSH44tyRL/baPb0vB4Zr8/B84p29fA?=
 =?iso-8859-1?Q?VAIgBJSAeIa7hlVHqRq7IlY/9wNdtncqcGnsRQC9CB5t0/yu9LdLcJXFTL?=
 =?iso-8859-1?Q?pNqQds5FB2benLWgmxOXvzo4ErUMlrg7/fmir7ZX54Y3g+zwfSN/bUsZty?=
 =?iso-8859-1?Q?Tuc/LdmHxQl6qcmIPozcIVEvEIQldPvP4N1xQf55ajMbwPuHKQTmDHqJta?=
 =?iso-8859-1?Q?xgMeX0kl1OFpNq30YtuRVo/sgx1Pon2MD4VVtftQdx9tgT94SKxiCkg1CZ?=
 =?iso-8859-1?Q?yP4o7RDCwbRNz0qtXKLzecJA/uJeP8JrcCx+NIKI3F6+A+UCw4Hqcutee5?=
 =?iso-8859-1?Q?gkfUYBUaCpDf6js6VIwSKNZocFkTE/RyBBy7FZPW3RekLoLoHwbNI+e0+i?=
 =?iso-8859-1?Q?deuKVfDgPc/vTG0ixt749d4ehwpFDudbZovoEe/PuARiQiJ4ZKuv60rR/W?=
 =?iso-8859-1?Q?cHzOowkEuayQAUwrYOpkLZizwdggNPzAAXvn7f8ecMenspnf84xWcWx9YQ?=
 =?iso-8859-1?Q?4V+epqI/L9PSqjUlmgeF6M8m0zGITV9R6M6/Xdw9s+iCzUolRiWqaVI//3?=
 =?iso-8859-1?Q?ungVxbRB2S6eIhq5zf48NW4CMBHCtaTHCs7NEKnrWCC4G9iAbgiLBs7Sod?=
 =?iso-8859-1?Q?A8XLjNH1IRYhBdhXviZ3U4ZduSVZ0kCcrQWkRnX725hbeHW1ibZA4aQ+5A?=
 =?iso-8859-1?Q?M9eIs8p2WCFxUEVPr3Ot5l6pxbN6ofoJBel8tK3QZmcdAByxhaEk7iLaX8?=
 =?iso-8859-1?Q?D+Y+krcfI8tH7PVt9XxNPtDjt3yZTHOuT2xuhe6gGx7Iv2ck9cE7fgqMlU?=
 =?iso-8859-1?Q?XmemwPIvdbe5e/OiHSNHlt8BxfZm4pBNNy3a4+AbK2Q+NiKdlHAELa2u02?=
 =?iso-8859-1?Q?/iZDGL8J1wLmd7UwKUAU6BfKjkNlkqVJEryBwnYoFoQ9PhVVpHQwCP0DuD?=
 =?iso-8859-1?Q?n9A6Mp81A1I/ZCV9/crnhQ/o8vVw3w2hRJicUAg3yEzC82fDntVdVveSfH?=
 =?iso-8859-1?Q?5pRu3DgLnFlECpwzHbdfqI87HraiJ6Dt7n2qIc5o8VF5UC/vcfODa39cqW?=
 =?iso-8859-1?Q?XB+YEH/rNxqYY7evFYIqNajYONTzJ1/73CXSkzivI9vmJT4EGtSD0lHy4n?=
 =?iso-8859-1?Q?bCPpb++8P5M7NthDT/vCY8B+DP0nOkcdFnFim5GpDbo6ktdOyUeBFAg70X?=
 =?iso-8859-1?Q?D3/SQ1ms4uOElEb/tyqteny2KlhCZ6mpiC9uFwXIGmLqCjD+um49WEpA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ae3f75f-a123-417f-f65d-08da69f60ffe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:52.9620
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ek39Ip28YAhg74CG0ptRdalvMOdQDIaX8kGK78M8Hhay7nL94Bizg2vJ05d+9R6dziMdrtBf6y/atGwq97ljSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=919 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: iFElMpXnt3F2Eg4chxTOYJq2WuqpanSk
X-Proofpoint-GUID: iFElMpXnt3F2Eg4chxTOYJq2WuqpanSk
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

Relocation of code for the next commit.  There should be no changes here.

Link: https://lkml.kernel.org/r/20220504011345.662299-12-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-28-Liam.Howlett@orac=
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
 mm/mmap.c | 492 +++++++++++++++++++++++++++---------------------------
 1 file changed, 246 insertions(+), 246 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 26bb60318066..0cde534a8f9f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1764,252 +1764,6 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE=
;
 }
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
-	unsigned long charged =3D 0;
-	unsigned long end =3D addr + len;
-	unsigned long merge_start =3D addr, merge_end =3D end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |=3D VM_ACCOUNT;
-	}
-
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX, NULL))) {
-		merge_start =3D prev->vm_start;
-		vma =3D prev;
-		vm_pgoff =3D prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
-	}
-
-	mas.index =3D addr;
-	mas.last =3D end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start =3D addr;
-	vma->vm_end =3D end;
-	vma->vm_flags =3D vm_flags;
-	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
-	vma->vm_pgoff =3D pgoff;
-
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
-		vma->vm_file =3D get_file(file);
-		error =3D call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
-		mas_reset(&mas);
-
-		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
-				addr =3D vma->vm_start;
-				vm_flags =3D vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		vm_flags =3D vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error =3D shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		error =3D -ENOMEM;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-
-	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(vma->vm_file->f_mapping);
-
-		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
-		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	}
-
-	/*
-	 * vma_merge() calls khugepaged_enter_vma() either, the below
-	 * call covers the non-merge case.
-	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-	file =3D vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
-			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |=3D VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	validate_mm(mm);
-	return addr;
-
-unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	charged =3D 0;
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
-}
-
 /**
  * unmapped_area() - Find an area between the low_limit and the high_limit=
 with
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
@@ -2883,6 +2637,252 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
=20
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *next, *prev, *merge;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
+
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX, NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma(vma, vm_flags);
+		goto expanded;
+	}
+
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma =3D vm_area_alloc(mm);
+	if (!vma) {
+		error =3D -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start =3D addr;
+	vma->vm_end =3D end;
+	vma->vm_flags =3D vm_flags;
+	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
+	vma->vm_pgoff =3D pgoff;
+
+	if (file) {
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto free_vma;
+		}
+
+		vma->vm_file =3D get_file(file);
+		error =3D call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 */
+		WARN_ON_ONCE(addr !=3D vma->vm_start);
+
+		addr =3D vma->vm_start;
+		mas_reset(&mas);
+
+		/*
+		 * If vm_flags changed after call_mmap(), we should try merge
+		 * vma again as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
+			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			if (merge) {
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D merge;
+				/* Update vm_flags to pick up the change. */
+				addr =3D vma->vm_start;
+				vm_flags =3D vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		vm_flags =3D vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error =3D shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error =3D -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
+	/*
+	 * vma_merge() calls khugepaged_enter_vma() either, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
+
+	/* Once vma denies write, undo our temporary denial count */
+unmap_writable:
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+	file =3D vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma =3D=3D get_gate_vma(current->mm))
+			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |=3D VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	validate_mm(mm);
+	return addr;
+
+unmap_and_free_vma:
+	fput(vma->vm_file);
+	vma->vm_file =3D NULL;
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged =3D 0;
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	validate_mm(mm);
+	return error;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--=20
2.35.1
