Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6E45AF50C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbiIFTx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiIFTuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE780F7A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:06 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYjZ029914;
        Tue, 6 Sep 2022 19:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7N8JCa2g2lf1em2rWSLx//NSbUzOTVVgGzz1o4lCCv4=;
 b=hh3v+HEPVNCDjb7Co3GGwFtVHVRvjnxMsj2i/HtXJ7W9MbpB3kDVnPakan9z3sgYsD8P
 1dqdjlpU6hvIHJHMsHZaF6QIqm0hcP/5nXduqaArkd7wtY9ZANMi1mZsJXR9T5qdfrVt
 d2yejkUPwml9ekq1pr0HekurNYqtuFRmGHWRY1v9DSSGxgQf6y65DHNcM0JKuZZwGvMB
 5CZ5BRJsjozZVbW9rUCvQZ08ptwx7Pcmd2PxlsFSYX9bghnvsjrFzUeBJ5L6v/cp0vBY
 /BbtMf2pj2IVwrrHIKuRPW5SI2jXQC1ocpKUNAtkd0kib5u2e1C4sAnt6iY1IbLkEoPM 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvdg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67X031251;
        Tue, 6 Sep 2022 19:49:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UeXtOnZ37V31r4RTwKFyqALKSMrtS0ZccUA1WQYDZnHDplvHcPkXaSsQU2cDpLZBs5T6J9NbLWWDCd449FjOMDSuaCuFKw1uIutELLPDcowRQvXFYryw8uBk8lnUdoBEg84r+UhAXS/5NJr9v31Xz/nJmMA1j3TCpE808HobwMAih7dnuW04kCEMEsIHnDqA1RBFC7YHjjlxyVdar84tgepPebe+paEqJ/XnXw2/USirfpROemr6TqYnoS0cSFoTtf/LB9tyA+r7jSWAjHt/WUiquoh0QJa7TEhtSjfQbUt5fYoDajzJHVMmAbrUypWMiHnsLDY+pSQNwY23ixae8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7N8JCa2g2lf1em2rWSLx//NSbUzOTVVgGzz1o4lCCv4=;
 b=Q9rBdIxLyHFaQqIhVhQyRTXOnvxY4G198ReZcRUvWAlb0SyN2hH61gBaqYYlsifIbprefiqOr09eGXHgfyaVNuVBND1OVpa7jjwgUYmuWYea5e/MIfps7Wzk7FLQdN5tFKlUVFOpLII7jx6PEMj+JHCKJOEyn9dQ/ijskJZ8ftz5iC3XjTUj7gsA/eP0o+Q2Zi3u3DYBblztEyG65zV/Q6ElNcWGHc+uglR8rWRSVtrO0M0jKay+ZAgU1kll6G6+WUglBbDIXYXJPgcQDCoUj2xlU/Y7tM0vyAtdnOZudmeLqAIKLvs1ONllLwa0zfKYc49sBcA90ALX3w3IMB4Oyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7N8JCa2g2lf1em2rWSLx//NSbUzOTVVgGzz1o4lCCv4=;
 b=Mz5+6dXhB8wsT2NAj8Qcnzta6O11ktDLwzgpYZrUustDnGZE7j1Bg6yRxw9w6cTnugXX4SP06k/JN19R5/SbjbFAfuCxh8U/hs5mytTDm76X5qnuCAyHiJqgiqr7RV5OUJfMAOuv219hcfBehU4pePrj92yGSewSTRW+573coVA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 58/70] mm/mprotect: use maple tree navigation instead of
 VMA linked list
Thread-Topic: [PATCH v14 58/70] mm/mprotect: use maple tree navigation instead
 of VMA linked list
Thread-Index: AQHYwim3KUNzm8XkwUqHosmeqJgucA==
Date:   Tue, 6 Sep 2022 19:49:02 +0000
Message-ID: <20220906194824.2110408-59-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 922bec4a-fa81-4948-82b1-08da9040f51a
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UgB/E+jTC/sfK7RZMWrwbn+IZRlQH+Cj06UUlexNKe0Y7VLMYcikkRmCArTvmooAncEM03DeAZgChx4v+qXqVVAPSIEgij5xVbl/jhAlF5poDHsfHHCHB7uQMNktb3u3u8OHUOnGv/ukxt4dL1BTd5S5A3M2kusd1JQPFU6+7bFKpULqo3ddDHwhIaHqZnh+kMKJ3HJUblPe1awiijbcJzPZvKbiQEnqkG90uP9i2nJZ26hqc7gKU1J+LfoqB/OJc617Nr6QcQbDmgg6yUWXyBMsqoDD++lb5yIO7RMHpRTy094pb2608YWXWxBEPDa5FNPfOXL7B251lLlie7xmPF1KVtfmmN6vym5UA2sA7meqeY0t5UL3oSBjDtBM9r6uMxcQvnJQGrmuuVsjnSn8OVPUS5DGo3+5uJ79etfHQxptxlcWoipLSM4ESHfj3hNXo2q/jzODUUfy05J0+rs5CysrkC+jfY7JwHsyA9YEjSQR9MwHhqrkv9zAmf0KueD5s2YGqopPNqdw/RTE7/lipOBWAeABDTGzmnS9YZbr4pUcj8Aiwm1iCc0JU5vp/eNjkAa2c0fUnsFq/1Cjqx10yhsN0i4tl/h2vsjtYMHjLVkhmqquP8+b2G3q3IQc0eCkF1vy0wy3wsEX5oKljdSRgqOtJkiNoh9FZDBKIJKvq6GrfjCh3xTyJrB43dUnNTF19bHbEyJe8XQN1gtyxmSgloVShYSoENHWSMay/k4Tlo89K5pc9DCYxwIDSxT9iKVm/7wQnV+PQ4/C6YF4YG22yA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?G2vISEqmgW05EnBIXyeW9S3w/xwUP89O2TMy1U/uY54Bv+LxESTypl6aZ1?=
 =?iso-8859-1?Q?oYRabhwuh3EyR+fUW9Co/gKad0CcS4z96fY+mG0Fj0k0leijobXlKolIqY?=
 =?iso-8859-1?Q?KJX9JKIBGH+/123Ce2wL/g+Oyr7UbDTSD7QZ/G2zcbOKvQWz2Z1yCpcYor?=
 =?iso-8859-1?Q?JplMQVSSzzzinIlSxDcMo5P3MNdglP/DYfrcSjekUDFKRfpHYi6hPvSMUg?=
 =?iso-8859-1?Q?fIWI7DkXrPjme+SfE+ioAlfu034NOboIOPEXsfJC8Fsy/Y/uo32trmDYne?=
 =?iso-8859-1?Q?6A+3fdxnfy/vn7W+buRt75iTZYBoJlvhGzJHt1Gu+nvcQKl62s1kMPJTka?=
 =?iso-8859-1?Q?1oxAOonWlrqA3ywruQFV8DthDlguIzXDhQFK2mmuL2y/zKFXRqpwkXthyA?=
 =?iso-8859-1?Q?1+9u4yTiLViJIJiPQYfJpAb97V0QJ2mvQI+RPe9YEjv+6L5H+wHkGHPPln?=
 =?iso-8859-1?Q?SkDGQQftSuhnwXbfzGFkLjgLsAaZnK3OWoWq8uHU/dKN9A66uv595He11x?=
 =?iso-8859-1?Q?VHnhbeawVMw6V8XHWObctxODovNhqnXISpEb+r6CpGF0qbt/4Fb3eyfVoO?=
 =?iso-8859-1?Q?xiTQNKCvP3B9QPlM8ERVkV7Syh2cVAei9UPzOe42p/IhUdDZi0Jeaj+27Y?=
 =?iso-8859-1?Q?yEbW1JPrY6zR3rrMZmsRDJsmaYD32J/aLhu7Xn3M4BdFj8BkC/4wi6CYLM?=
 =?iso-8859-1?Q?yyGO7YwODYySzogMl3B7R7Xi2aeZLD9zJuv3agA53EwTIeljD6K5DMjxc0?=
 =?iso-8859-1?Q?dgBINOAOmlXsOGcJzLVHcnIqSSETSgceWzjRLbI/DuiSCyGP0YSNt+PLCV?=
 =?iso-8859-1?Q?b9rQeM2XXsMjVRgYr3Q3UYCU54Z1WJ3FEyiQpCFl/Fq0GktBVsvcH6df/u?=
 =?iso-8859-1?Q?ONjUnt9LfW4LRI5EY9KBO8xk1FbDwUXEB9+UZGqCK/W00+FdkuM2kvQt4g?=
 =?iso-8859-1?Q?iqjqBrMAkJXSbDRu95wJEhxnH/oLqJ9vDx0cmskYTDnpqV8aE+UPU81OcO?=
 =?iso-8859-1?Q?tmcrbnMBzc++Kwku6qjwISQphs4aTel+x/WQE5uVkNr5HgNrUf/qjaNAbC?=
 =?iso-8859-1?Q?zqit6kXCpg2H/zfk/Zj68o2Cxsgogba8rVhdN32NEhNmtQzEBe0PRPuyNw?=
 =?iso-8859-1?Q?15miz0sXVPJClhBp1ZDiwadAihQLpt2u9EGgP3WLGfoZ0wtn4f0okXCboY?=
 =?iso-8859-1?Q?w2crrssolWpXgOF1S13N9fej4PyNwfKcBp1Y3NijJSN6yuQJm45L9GeJCe?=
 =?iso-8859-1?Q?IsDonz6X67tG0PMjkkmiy54JtLLy7gA54QjM7dfzkJtJ9Mh1dMGanGpEIX?=
 =?iso-8859-1?Q?9gvzPftcu1IatMqMapwPGoiiMt9vIQolvc5QKn4SIgjVZUvMZGgv8lffNh?=
 =?iso-8859-1?Q?QOYuVCjQFKiY2prR2nktf15kLV9kEoggXePKMsMcoSOcaOBq49DV/BJOlN?=
 =?iso-8859-1?Q?LiBJbhgctb08xd/vcwLQMZ32D35PVTzDFa+/RtWpowc2T/pFo/gEqXog42?=
 =?iso-8859-1?Q?aU/P7Up3FNBjrGe+ooEiHdRntJAN/SthBF2jIpJH7XXBRlz/W/im2fUHcO?=
 =?iso-8859-1?Q?0Gt1ljP1wwrUK8lE4YsvOsRqHV0X62l4PdhpFDjtYDtqstn92v+fAXvoNK?=
 =?iso-8859-1?Q?aaVcirLcrku1QL5q3CrVnyJqYf+S7Y+hFW9361yVDis8aqDgC/AXTzbA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 922bec4a-fa81-4948-82b1-08da9040f51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:02.9433
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ea1Ytkn9waMtN5XQGSgQ8Mk0y6s1XTti+ZBSpjIjVx4kEQ+5igUpsfjKQZvtLmmKyJR5I31lMb+arUPF4rGSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: dd_WkEOeAXAkoyz_txnG8yyQTnrArhoC
X-Proofpoint-GUID: dd_WkEOeAXAkoyz_txnG8yyQTnrArhoC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Switch to navigating the VMA list with the maple tree operators in
preparation for removing the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mprotect.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/mprotect.c b/mm/mprotect.c
index 1bdac9337fb9..3c79796be65e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -675,6 +675,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	const bool rier =3D (current->personality & READ_IMPLIES_EXEC) &&
 				(prot & PROT_READ);
 	struct mmu_gather tlb;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	start =3D untagged_addr(start);
=20
@@ -706,7 +707,8 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if ((pkey !=3D -1) && !mm_pkey_is_allocated(current->mm, pkey))
 		goto out;
=20
-	vma =3D find_vma(current->mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	error =3D -ENOMEM;
 	if (!vma)
 		goto out;
@@ -732,7 +734,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 	if (start > vma->vm_start)
 		prev =3D vma;
 	else
-		prev =3D vma->vm_prev;
+		prev =3D mas_prev(&mas, 0);
=20
 	tlb_gather_mmu(&tlb, current->mm);
 	for (nstart =3D start ; ; ) {
@@ -795,7 +797,7 @@ static int do_mprotect_pkey(unsigned long start, size_t=
 len,
 		if (nstart >=3D end)
 			break;
=20
-		vma =3D prev->vm_next;
+		vma =3D find_vma(current->mm, prev->vm_end);
 		if (!vma || vma->vm_start !=3D nstart) {
 			error =3D -ENOMEM;
 			break;
--=20
2.35.1
