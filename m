Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219B157734D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbiGQCt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbiGQCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12061D33A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:32 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ92Ni024333;
        Sun, 17 Jul 2022 02:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SdYhLLbTokPx4igwQMzpHn0cO51ilcToNbUdwiR3tEA=;
 b=zpcCqb6Dj7FnQsuj2YD21AZoE/KM1WPR/tFhHu+uuAZDmKhy0xZ2yA0wwedezRwHAzU+
 Dn1WoFahv4FxD4Xp4SbZmtAFlBaR3aMPB4VEzwhQBfLI0Kkcfv/+MbHbw/FHlmyytQOG
 k665E1nxFaORfB6YESfMHqFszBVKVgkALUgo05QZMEtmZGIvkKuoIyFFRO7YlS26AUYQ
 1053GYG4yqpaS76ho3mWtiCkza1FXGA5iEim5ElckEr1cJFpZ1lW2uvSbfCCP9GDdYTk
 16OVLhaFGYfTF+xhf13ylDhWSHrdiInzIIHlOHDza5fQk7Wso+kJqmYjgeqRTZ/k/45E Qg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvt8xdp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISD036113;
        Sun, 17 Jul 2022 02:47:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z11FkEGCLCTy7/rdaqDUhwR8GKb1MqDOTaF1PrQOGT69+dLVxaqXwowkxM3t1Q3q6ZCBVZkhPeL51Z3j6tyzMsuu+hG+kH2qnkG7oY7IMl0Wv0mZJ0xtmYCVe3m4ekHfPmO0ja7ADKyCOZeWkVFvo+UjZtu3/5QTitni1//L9TxnOjfbBFq3H6mgh38YSxnYyOfDlVeXeroCxihHqBqT7rEyQWlg+b4/CxyRux8yE85AHncRPkuLYET1h5seu2moWUbDmwWhvqbqa/82maKbD8PfS4twFOqTf7QOJ+FHseaGfwHE+1sThDRUl5mizbN+RWmX771rxxzmbxpcdKVFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SdYhLLbTokPx4igwQMzpHn0cO51ilcToNbUdwiR3tEA=;
 b=Mj02+B6iot+0V3M2jKTfz2IN/B8ChOmn8wGxQ5LyhOGjCxTABLDsds2aDifrrHuHnPvFqNkHoqBqvzjQFADCqR8QQ4V4MVYjtVx+rLzGDI6KBCMFn7B/XUtgOFjDAgarTsj9pra+mLDJ5dC0oazZQwp2uA+qZBjXgSVNmhN6t07xZpt3/TN8+BK39L5GtjYG9u5cOhPLEJpfYOq6mKeDkK2PSWdwXacBAHGDAo7gmkz0cvWo8Q9RO/6sT8hoXoVnFT+s2V3RSyCZ5iDqppyr+39D+Ki1tQmyyZGKBR90Gbt3DfTpvT2t5TvQzjo12qNogDeEFgf44CZDlkXBAxv1Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SdYhLLbTokPx4igwQMzpHn0cO51ilcToNbUdwiR3tEA=;
 b=kPPHtwfG3RosDH0hWe3rWxs7oGqqI4eyg5nNfmerFKPSsbmf/CwYYcn769cbvWw+xCV9iiMDlC5e7Hv9QJ/tUXW5PdTO16v0I++3VYWKS/EysOZTF6LF+HReB2ecTVJHveilm8FLpTv3qkiv81p/p0ZQAjA1bcPm6cVSg+jxka0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 31/69] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH v11 31/69] arm64: Change elfcore for_each_mte_vma() to
 use VMA iterator
Thread-Index: AQHYmYd13AFdr61eakGkqxQDxpolNg==
Date:   Sun, 17 Jul 2022 02:46:47 +0000
Message-ID: <20220717024615.2106835-32-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de386c30-979c-4471-9017-08da679ead04
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1P4+ygPeVo6J8wtFzsBhzMwrrZnW2EhemupgEovhLa7adRmDX3ZmlF8c7GFg0UApP6ox+YQZk+h5Z5j9ePh8zLTfYgyWsjZAOtWKvan47mm0kCDZzhv8xDIznTlLpPt5/RC1G2YYDvxHts7FyZDDMZFDdNlshvVEj8FaSaW3qC/ceyyDOlVSTO5JBTYMLhSufhsPk7T2VfA0rhTZ5Jr1Rj3D6Ys5RUksGSvzUDor4rZ7/Js/tZRUULiRHL0m7p4jjLoTmSwfxkMrySYEnvaYfkHDk1/C5+Wjh0jf52SYGwk191aRuXUGST0z7C0Cm9UXrYO5Px66Z4MOI+vbqp4QEjBDxpYNcAwLJqJchSATGiEDyvrXMStdLxiof4b5Fd5HrePm43J+zN/0v5nzy8jJkFOS6khQRLHM5NGgO4Pl/eCZ8A+sNWMcQR9UfUjUjHmzr8Upe3+TnjW7j+sVavhkG8bkn7lnYiUeD4tNjGa86EANNnUtyrVUZkn7HvJOWPgGaMUwobXtlMFYyQhvnlPZ9aI0ifBeev+QSbCNeTT8RFYOD9zaJqkBJbX7c6lyP+4jNIthLmpkj2hs3wh2ijPT2rig6bhzuI8K6aKil/3a50qVvxAxkAZVXXE5ERvEtpvZXGEaXYlLMdNDRHXbYyPZxvBLM0KnW30Z7FwI05XvElNy0fbBKrGAipNDBlz4GN0uMgnh93T1U+LBI7lNjFhik1W06QWzsM1C467u2xKL8s2+xp+XWbwQLmRwXYofXwdWgcg9yasqGhjnYu75NqBvdL1CgNtePOMt1BoFCTNlSvo/8dNLrfBvShUlRnu3Ml8tgTN1kPyWXQ+fPBPc4zakh3THg4Lxp14Y+Ru0ciA//PecUZnqyXQvv7mVgGNXEv1E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IOL33DI+uHBcxHQSv3xOLcWqMPIM7Q1yqTgW0lQAMPXaPgYmOO7TuZZ/S5?=
 =?iso-8859-1?Q?gTwE6gFtU/Q2nuzvnX/G+gZYFbkPj9XWTbq4DE+NFrLULdn+DEJkQtchuP?=
 =?iso-8859-1?Q?pedgInt0LToC4yuIfnrIndQNus2GMDVQNqaX28vVcNI5iiFv60Wj77lKA4?=
 =?iso-8859-1?Q?UntWk0iP7r8T0zHcxsHd1ANT0SEPtjevCVXKaUeUrHdJ4gl4l4cp03XCdF?=
 =?iso-8859-1?Q?sLhazLyjfcG6WWIoLa/WsqS2MRuRrzbrNOWKaSLaY6ahS2ox1rZfJ8AOVy?=
 =?iso-8859-1?Q?7gSuzG6XsIhxox2KkktOTZkE2ag/BczjU4MYVKhzX9OOs/ufY6KzXeIVQh?=
 =?iso-8859-1?Q?VTKtBxCe1dGYLMI2FFKcij1/sccArJUo4tEhsZWdixCeRYOoj1Idcrwj/L?=
 =?iso-8859-1?Q?TW9oVicnjVz4IFZVOD4fMLfdtD9B5ZRRhVYRe490wiSH2df7Ck7K53OHSq?=
 =?iso-8859-1?Q?lm2rppPtoq87sqyFrNqcDprJV2trdyK/ejwnPjGEPj1OzUpUU3PP21DS9N?=
 =?iso-8859-1?Q?ITIebRfzyKQsosHpWHnatsPRPP8HtRWR3DkWloEyObhSs4YbC0mQ9IXxW+?=
 =?iso-8859-1?Q?JhQhCnQ/xvAc6WuvKieflw00iv8THh3GmPDtnMJHM+cR4Sd4kHy7LECinn?=
 =?iso-8859-1?Q?2Y/KWNtqKO49g4BMQabJ1+G3bW+InaJ4QAWLxk05aGA4hMQVCrXufqnBqK?=
 =?iso-8859-1?Q?iI8xnWfaccumpjktfIVXZRLoNe8DMICeDs8YvkKKN9Oa14XMGeDbbhIIH1?=
 =?iso-8859-1?Q?POhTDhPEV9Nm7qjToQRP2kPdbcsgQRYowW0vpcfkcaQMxBMOv/7o1/RBUK?=
 =?iso-8859-1?Q?loJZWx6kDLiPhsfl1ECYhPQvOdwGAWoMZPFYUI6Q7CCdWfjnAChhEIoyZn?=
 =?iso-8859-1?Q?HXcy5/PKp4n5MRviezbUx4ZTDMnl+ozhYs3LUWBX4dRsqa8ao7R0gL6Ntd?=
 =?iso-8859-1?Q?bdRkrI9ziuD0B83T83xoEaJo/hMZh+C69MfgaRTptTPAyqf92bgjbUDVJc?=
 =?iso-8859-1?Q?wPgIg08MOULGQ0BfZNOjTHjUJ44wgIGJPQhUZIlVNwNdPl7PRn3ZgS8D9z?=
 =?iso-8859-1?Q?qlrRncV4IWYfy4oq8kiVyFn1RhhZTREsRSLX+49VgsdOADnkPEaiNs8wbh?=
 =?iso-8859-1?Q?yfZOEuuvenpiARTgPcYiBA0xKPmkQjoWeBOh/4TMZVkvTpaMgwCk6UwVVs?=
 =?iso-8859-1?Q?5z3xs5LRruC6JV0PKeN0ui8Z9e6T5Id712R/Lkw6e68GoxgUiCJc/89xkM?=
 =?iso-8859-1?Q?vw4vKUWZ4G4TCQMADov8UHvpyzNiFbOwWkHTOi6517NQ3XnoVR9XWwAhMT?=
 =?iso-8859-1?Q?ocmrrW2qCBNkVN1+x3JCJHSQl9iSKW272WqMCbzbCEAe1oTwiDP1cPrxdd?=
 =?iso-8859-1?Q?SeJLDRF64Cx9bCdyAKA6wfhzeT3yVQrvXII30tb7/PVHRzcRJCq6vIL0T/?=
 =?iso-8859-1?Q?w9vKQXY1dPxEki3Iu4t94Mw4Wk1QB1SRm9r9ez4/UgiLlfI7W8BSQBoD0q?=
 =?iso-8859-1?Q?/RE9vAnO4a/X6fm2NIaWAjra3K5nwYTsXehviD5gVJpyV02l12tKh3IXG6?=
 =?iso-8859-1?Q?KatcVDOsQ0J+HCf0G1XW6B04VvPjgirndKdQUHzMZNBDoy3AF27BlYULQO?=
 =?iso-8859-1?Q?YwYjYGhrQi3RBJ8pnHBoy1/0EhcxyGAOuf+anFOtYXwIszl4W3TywP6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de386c30-979c-4471-9017-08da679ead04
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:47.8027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzyJROJVxc0zGfI127y7RlfYWzBAz8WdT7QPTtzxcXcrIbvzGJ1bJLqASOqfON1DwVIkjXx3+dImXFe3FY+KLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=870
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: wfnfEaDTSKDW1vdQL56lqDZUolvOCnYN
X-Proofpoint-ORIG-GUID: wfnfEaDTSKDW1vdQL56lqDZUolvOCnYN
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

Rework for_each_mte_vma() to use a VMA iterator instead of an explicit
linked-list.

Link: https://lkml.kernel.org/r/20220504011345.662299-16-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-32-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20220218023650.672072-1-Liam.Howlett@oracle=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm64/kernel/elfcore.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 98d67444a5b6..27ef7ad3ffd2 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,9 +8,9 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
=20
-#define for_each_mte_vma(tsk, vma)					\
+#define for_each_mte_vma(vmi, vma)					\
 	if (system_supports_mte())					\
-		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
+		for_each_vma(vmi, vma)					\
 			if (vma->vm_flags & VM_MTE)
=20
 static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
@@ -81,8 +81,9 @@ Elf_Half elf_core_extra_phdrs(void)
 {
 	struct vm_area_struct *vma;
 	int vma_count =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		vma_count++;
=20
 	return vma_count;
@@ -91,8 +92,9 @@ Elf_Half elf_core_extra_phdrs(void)
 int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset=
)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		struct elf_phdr phdr;
=20
 		phdr.p_type =3D PT_AARCH64_MEMTAG_MTE;
@@ -116,8 +118,9 @@ size_t elf_core_extra_data_size(void)
 {
 	struct vm_area_struct *vma;
 	size_t data_size =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		data_size +=3D mte_vma_tag_dump_size(vma);
=20
 	return data_size;
@@ -126,8 +129,9 @@ size_t elf_core_extra_data_size(void)
 int elf_core_write_extra_data(struct coredump_params *cprm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		if (vma->vm_flags & VM_DONTDUMP)
 			continue;
=20
--=20
2.35.1
