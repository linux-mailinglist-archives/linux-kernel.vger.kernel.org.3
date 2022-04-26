Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB23510172
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351935AbiDZPLu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352112AbiDZPKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15FB158F53
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:30 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT30a025784;
        Tue, 26 Apr 2022 15:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=x3woQ1ohVkkF2Z6Q2MPQOByk/2munWxVyPe9CuEyLkA=;
 b=K45C0ZmIQzNmyuKSYcm/uNu765inr4nuzciDiUFBZKfC646WzjUX3JfvGpQ43PUqkDcF
 4HcX5Uqc3NZsOM6TdWhVAXyBaS/N+a5cKz/xXef7hxQMnt9+8qcvqiKTMf+RVQS0LP1V
 l4kTXySC8N27qEDAkH64ZP4rvROOT8Uk3hTMsWoW7H3gwmP2S2zfOuMYDKvDDpXwGGGR
 qKf+B2bI6xGIAiumwzLx9fSvJfCThJhrhw/pHVhSPaRH9vFXi7HX9T5D9hj4qAFbdDVX
 zs3BzX90FGO6UlAMMeR0x6i16L62RbtJpSXBPFX8d773y3N6+hv8e6uHtGk3LU30RrA0 Bg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6Uo6037883;
        Tue, 26 Apr 2022 15:07:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjkugm-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEzpbLgJLRmbZvH+CyIvMJm37kt62JPeh6foWv+liW2Vq77ZjTMVyuz/f7+mo/yqrTd0NCtBkBvXunax6qw0DjUeiMP3hPd5q08JeCjFJGpNmG7/ytlRok8wlh3XobGF506A8phPXYUdmTefRWxI+ZHbTb7HveT0ajZYvfwJ9C3kO9RejX8/n7menW6lkHFp0fk0Burm+9PpNtzVlWzQldISm1RJSl38KbV7J2LtEHv5XpczAIZErRI9/vpdtSNxNiuT0ggmvj1YHKw+lbmJhpiDPGzYcvE+az39lBZWu2h2+tW/0hxVIhd0P0JENylNVzTaF7SBNbN/wmXoJlZbzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3woQ1ohVkkF2Z6Q2MPQOByk/2munWxVyPe9CuEyLkA=;
 b=RcRF0aKOtI36Qv5rGpWb+Mv0KrJH5xU8P4u0IUoXSb38mPQEC+iO3wjJv9/llDCNGMs9A3PO6tYVgVNBesgN3nQpV0HoCo8jnIsDmtRIVWKhbWSWwoF/ARscwyekGYLa8j0666e1QBD+tW2AAe33/F0QHH7eIktNj90g2GWjS/D2KIyFa1iD++UgylDOCRLuIYTVM+lU/AUSXIAD0ckZMc4jh1V3dQS1D0kEl21TPs4HF4+kIAZ5WNNI561EjSwjPBJLaXl7LnzR7l9H7/nRRrpJdaKk24kKlIluUhM3LollIfghfTNJ8haX8KbKJrLv+WaODDC7OF+Rz0q1Lv5ulA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3woQ1ohVkkF2Z6Q2MPQOByk/2munWxVyPe9CuEyLkA=;
 b=pjnf4zhRlM8V4a6CYnnIbPad09w9L0IC0Stfv/XbnmU6f4x5veEvtqLCuyV58dYgFaRA9IfyHbI5tcOlkgmSxtZFdI0RPHP2jeECU4vKtpBF/TnNIBbHXykJk10XoLLNego9NNYY/1PngTnAC5OrmXBFLhzabUHxEus/KIn38Rw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 42/70] exec: use VMA iterator instead of linked list
Thread-Topic: [PATCH v8 42/70] exec: use VMA iterator instead of linked list
Thread-Index: AQHYWX89Tijjk6Njj06yjN2Z5rC9Jg==
Date:   Tue, 26 Apr 2022 15:06:43 +0000
Message-ID: <20220426150616.3937571-43-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e88b6b5c-81eb-4b0e-e44b-08da279674e7
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929C912BE8B8D4A967FF258FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: utwflvS5a7Un937iDZhd6DmRJBe4lAFeFi0m1ZwhCPrFlW5YIiexP2u0OMIF6vFOVpNCpseT3xJ2TXWEHujPy/eK2tkZhZlR22PCqryYxoxnDUuiSi/VtbzApOfjYsh4ol59eCkIaNSgHQ878i3tslNCv7hJjD4Ay/9+ccwPssrj0EgNq4tomiyAlMS8Ru7h1wb+rpRYfjb7pbPa6Nz4j84K5DNfkBIPc6RlGlYo/W7SoAIyQaCDNDTRv04I9/7zEH8Pv+7xwWzOGaEqlv3QEtxmM34ei8wnvk8AMLonJpPQwpVSmvCg5Hq7oM+tt40zv/cSsqZFsgdniitXJXEffKfmuo/CpZ3ZQ+BeI1hL4X8/hDgpvOfgu1YwISapraTyBDTYZFGzEa8UFNPyeAIw28dnIjoygf7sgYmfOf9d4DHbK657ZeeaOQcc5T6veuDm+tFQBIdmS0tL4HJwNvVFJgJJufC/l2IV6fVdLhvq46OTjCP12I5yWEtNhujrgxJAPPx4LZInDuC8DSkr5OZAjicVDiv+GgqUEUzZi5EzZR1zit1itOHBiWEwWZagmjXBkJlVcREyXPtHfj/nYBv0kt0ASz9orz4DzT6cNOQyNr4UEs6abj4gIMABF+x20OXsOvpd1mOxmElgqPiaBe9p8MDgNzriE9EQ79ndZRJZMwhTMnF1kFyY3tFvAo3Bg7A7R9UgAe/nqufS/tHZ2dPQuQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YQ7CHwFocEqGE4N+w2XFwvfv7Qa6C9ZRyxA6OZRLuTkv3v/ZU/+OT6n/is?=
 =?iso-8859-1?Q?2GdJ4mDwr1Xk4GxuaQA5qc6fIcrYz6j5IL9GBd/N4HfzTo60CpvLgVp8tQ?=
 =?iso-8859-1?Q?9Tj0xymul6KMLz6ueJHD329dplxIx5ZN0jJLu9GqpYkI0EPt/Ny73XUIH9?=
 =?iso-8859-1?Q?mndY1tsTvxknJPaO8T1brxMnwmJm1ggf0eymN6yUwrzuQgQyMym3EP+0sE?=
 =?iso-8859-1?Q?UEhKe++tWi0WewsJI6b3ZGVUoVMykybLfNmaaunhobyphLypzVT1OT6SSq?=
 =?iso-8859-1?Q?vFdNNrCjSeGy22SwDTxPYftI72oH86BE2JySZi5c8JTSCcFcdExDUO5fNL?=
 =?iso-8859-1?Q?tEiWZY/+4Sp4gsATCjeI5fgQo+7MFdlgwHeUEaDdO/jq4IvNfUzB9ZglDO?=
 =?iso-8859-1?Q?2BM0ToLl3UnbNhTB6G/6OG32LrVwFa82GhPgQze3cY+NEZHdZErhfXYP8t?=
 =?iso-8859-1?Q?1ry2YHnckcsdQ7dL6ADYB4t/1+TjumX/oy8nHdKkrpzgZ/IJJgPZKdMmOC?=
 =?iso-8859-1?Q?RVou3vPK0XQZweAwXDc8SuOjXe2MmLfU0y3uR7mD15rpnBe6kdZEmuKNn3?=
 =?iso-8859-1?Q?ZfWtEhNHXI3MNbP7rT7jA1Yqi2mZPym1I4G3OZCsRtZgecibWSb5vI5k2c?=
 =?iso-8859-1?Q?SzRWy6MyjO+LhUA1qE7fk0NsEec4HAnhjOSLkguNcDKe7HyREGzlgabNsx?=
 =?iso-8859-1?Q?4NwZQHecEj4tRMsJKqKYulQtxE7g5HesSxKy60fZ8q5Vuvcm9RIF0Y85i5?=
 =?iso-8859-1?Q?KcfPo4zk+2tsY6GBXobPbYsEY926bFO1dAJ3nh51NNPdKXlDS5YYY+PoFr?=
 =?iso-8859-1?Q?WfGCj8gZAP0sXS3Ew+JDqlqTVpbcIy/pAqOSuJEwr2tbqm3pQ86mfMOHeT?=
 =?iso-8859-1?Q?EzED5TFmV5wy+uaWXaCsvklZLxKGIq2ZNf40MVwivkdB4t37bv47EPVljY?=
 =?iso-8859-1?Q?j3Tg0te8XOheAUtz/MIpaP5wr9uQ+Z284AfBeF7idX9U7qgWnNqRiODl3j?=
 =?iso-8859-1?Q?m9Iees2UjNJWlzQw1l7eO5F2ZUBXu3TX2R3Yt8rAYFb0EsoaipzVtTwSc5?=
 =?iso-8859-1?Q?NrWB+7f/H+utNJUxUF6eaB7VV3FHBbcZs8y4HRxuyW8qYAZ0hA1TBGNiq/?=
 =?iso-8859-1?Q?b8UCUZloh1WutFrBVRiqX+jleZGnR3iEmXe3t4faDG4sqbnVFp10vWWeiy?=
 =?iso-8859-1?Q?UAFtEZtev2CEO5JsBWRzdwDslgu3TRScfb5QImItAapdf6RhIrJqmaMywq?=
 =?iso-8859-1?Q?JQ0ZSlQmM9HCrw9FkY4W5Hgye6SLvaikMiMw/bp2b2r/HI2zkKd4cVs0h0?=
 =?iso-8859-1?Q?M7sAr5o1poLQwUYiTN9nHkXQr2sNK9INX0CI0oLtAtPUMEOW9imvKPTa3D?=
 =?iso-8859-1?Q?5Zt2d8zP+2Hby/+djfKDRR4f7nU1kCYY/KYv6RX4QVyRjpFaSFYFwgY1dD?=
 =?iso-8859-1?Q?unRmpnl2sLWTSi4miuHeS0a9lAutEKBLz+WIa5dkClkqzGe0cMI7jPz+pp?=
 =?iso-8859-1?Q?loiGljjpW6YT0Fqc5R0WZtmQhuY00Ef2AeV7eSccnFGIEqgMjQFbQ13OKS?=
 =?iso-8859-1?Q?Ly0tM+ObXWEflzis8PrKrEMqwqcVHpqRqYkmXNJ/lmIk3Sjq+EZ/4xPWRL?=
 =?iso-8859-1?Q?obIUNGNny0YQV3Jv4mzDUm4iu1N/gH/yJO8skd2ytXqql7Y3UFqGGW+Ebq?=
 =?iso-8859-1?Q?Rtc4PY6wiXHptspilSlnv65kACScuQTXQ+ZXqj8W2GR5VwktYNm/ImzhVF?=
 =?iso-8859-1?Q?rvv03h27QMrYs/On7jm+6F2rAr028OBE90OUwixjbNJak5Fwi3icOI5dYk?=
 =?iso-8859-1?Q?HzqIHbECv/Z/y5n9dd5ngWwMO3ocBDU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88b6b5c-81eb-4b0e-e44b-08da279674e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:43.3958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IvsxRO68P6pXhicSg8P4xirqWpoeQXZHn+BEw4VTWllXARLYmaXme6Tiac+qfklTHPfKYK55TSnQEcNwFrwvGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: Y5YouCcfSUt87yu_p2IzBtPJcYLq2US-
X-Proofpoint-ORIG-GUID: Y5YouCcfSUt87yu_p2IzBtPJcYLq2US-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove a use of the vm_next list by doing the initial lookup with the VMA
iterator and then using it to find the next entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index b856224b8535..ceef14608ae9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -686,6 +686,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -694,7 +696,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -713,12 +715,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -727,7 +730,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.35.1
