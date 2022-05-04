Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6351519336
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245036AbiEDBMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244947AbiEDBLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826F0434B6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:08:04 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243MdDaV019339;
        Wed, 4 May 2022 01:07:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=88WeKfwqQ2XNHCLimWBvr6icwitkGmMqyIzYBGSjUBk=;
 b=DPxlhz9c80r/k/S595KJYXOFH4b2Ofl055UYALDIRgfblZ2YE1lCN88JmKxP0NoryDri
 DDAk0lcQAY7On8kwTIvBQLOZr/CObNW7dupI1oj209J4DkrXk2mHknk428aZjP547sp/
 JUbwzKNHRBOKuRDpSF61nV8BYycZzZW97wrS9QpYK4EpcPyRW3UOqwicBzDb4aek5Z4b
 GNCacakzACFP8nWYT8GxoSQZwSl5glgdiMKZPoHw/MNGSWfpRH/sK2kI79S9DhIvpkKj
 iUS8QwlQGujMx5mRhBTackJB7CWvrVwvi3x7T7k9Tcz1Tu8PgFyICCK9rOMjNa9q1Bo+ CQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt74ay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SvL039119;
        Wed, 4 May 2022 01:07:57 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdr3-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl3ZN8KHNkw7BIydieWftptiiBqEimCxDY/O17KVB5ITrKcfzFw5RGKHxYEltbLKr4NwSkwMHqeZnkDi4e8IXJum/dn+LcjmsXuMhTqNchL2IprwBZFQupIR3bJq6tL4Irw133FtiAMMKyA/QUdDgm/OEkHn20Qrql/Vt414syqr6jcyCTep+dr0rZrd3IaIjzZUhcw/4+EU008lx/iMQpDSOvTV8us1kQGUgUgMarjJdtaGkLvNlIts/Bd9bHA2oLAwzF1v4HYM6e4dPeySxY16MN+tqLVIasbyCQmEOs/tFw0rYu4Jx2mN6IWIcy0t/1d4MQD9qO7o+kS7WNX32g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88WeKfwqQ2XNHCLimWBvr6icwitkGmMqyIzYBGSjUBk=;
 b=UAgx5zmuR+gOnA2vmfi0L1MZfPbUS2nSNt6RVJv1BeKBokvvepzPQWrD50OwZ+T3fQFX146id+hszuFyC9pUzT1/HpnX3/S6yuYKJSE2m6PRfbNy+14P8TjXxlbIZTU3TK+a1TlRg2fTC7Opbl2D3w3ggqiKQ03dc3iISVwHuZDoCPY17lFPrbCKajhgRLJqiO/bz7W+Jb6q44sZ/A9b/m3LVX1mxkdlRMn7lkjqSRZ9+dM1rKoAH80UFoma5yPxtIY9CagfXQdY91K7DTgqg1o1GYTWHV6AL4A4ErHFHa1OKOIWB+IrdfpgXcBuPuEHio/YHPFSrUlcp+js968+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88WeKfwqQ2XNHCLimWBvr6icwitkGmMqyIzYBGSjUBk=;
 b=obeEZs2pgRT/XMcqwoMsVRcFeWwc2IPdN0tTzS/H/ypV/XFNbTgIyj4sLTMvtpqjaxXEO8eeE/bYkkWv4p1dC+KeN2HtZuFSbmFi7dObJMhv3E24kNtilmxQptP6GnAekPGQs6XQ7UlN1J8AfJPVB9Fev10lof7czD74vXP2b5Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 11/69] mm/mmap: use the maple tree in find_vma() instead of
 the rbtree.
Thread-Topic: [PATCH v9 11/69] mm/mmap: use the maple tree in find_vma()
 instead of the rbtree.
Thread-Index: AQHYX1Nh5c5ZVYbTSUC6trXJo3Vg8g==
Date:   Wed, 4 May 2022 01:07:53 +0000
Message-ID: <20220504010716.661115-13-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63f012a7-d91f-4955-f165-08da2d6a8516
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB4214EC107F96602A5ADE805DFDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pwW6i1gOBh0XQWi9ZKuUDhkYmWshP/TvWCvo/kG+7cesOYznx+dMstHFavpGsIg/GXsavJCb9VLItkBWMRcq17tnV+4F6gCRLFoMAkC89+eztCF7zcJ5gIl/2jIDjTfPUJhPM9CnRRd1AYQ8KAb04sY+Y77X1eEMGYi8go3ZQ1S3646FegJ+eWRjNuGVp/Bu2p1lmeQszP9Uq5I0tLPlNJnGxmEmaLcUGD+gA74gLjtqqpmeBUZGNgJX9BGk7EgKc55Ttdngqlr6TYYQ8h9bkXrXX+PvWBze+PQ9CwXLoWe7o4hrFEvewsrNJLdRuoLWWgr/E2ji1M7sf+SKfOlU4vnEuHNRvV+obRNtlBIm+Wkw57OyQNvgEuohi56SYuaBZvYUAkzXcyPP61QG6UkOwkGIF55Q3Q4U9X1GI47gUmjn23A9yw5uGs7MlaQc7BxYDPwr2+yeoQjjEA+jevVjga1ulNMNGt8COxOqRsJIGinaUDJ982DqHO5LwauSteBzzfcjqIyyoq8qmI6/7+QGC/b3llA6geXXodUX4MtRK1CbcUvgZI72GxmozYhaKkH14TcDhFx/CJGPP8x3SqGT5liS+Y/jWOex4sNRWYCL+jcD8vwc/spZdv2TOJuzX2V6bG82+q9n7quO0nLUBERrZAqUKGs4B+Vu0ssLyEFX6tXXCCk1CrE5DGG1Ay7Mo6Q6wXRY4KIXeugyH4nkzjwUuw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(36756003)(5660300002)(44832011)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VOVG/VW0+dwaOmlwz9JyMwQ1Wg/WADzYhYglmygcYmETGYShscCF2rcgfx?=
 =?iso-8859-1?Q?0lxZNHnuglwVi8uxAOWpmWm2szJeQqtstTQvdxf+RN655+3OS8Z/pbM2rZ?=
 =?iso-8859-1?Q?hRkiZgOh6RIL4RE/+x8ocCY+zeA4zJ0XbehOLfwwMmM6AVJMtmNAknCC87?=
 =?iso-8859-1?Q?crk54Cbp/hBe8VWWZq3if52GTyIypw6s4eYXfElRpJzQNMsuZl4TaNF4k7?=
 =?iso-8859-1?Q?V2CciEVOFXU/V2eaYbTgbhGMq3/cQh/6a4d7a0Olvw03pZ2TTCawSKygEJ?=
 =?iso-8859-1?Q?rqEnx7Cw6qhFn8yNfmgTIeFMd/uwyQ97kXFLavuiGpvNdHIUV0fOjgt0zT?=
 =?iso-8859-1?Q?rg8GRK8rf6qWhlU8qwFOVjMKcF6462+36GSbiSBhxsC+Bk2DIRsWfeaFp+?=
 =?iso-8859-1?Q?09Mzid1iHLns6wphrYpJakiRggw8M4NVCwg+iCR2Muk6UpI3lm5qkV8KN3?=
 =?iso-8859-1?Q?sAX6hNmEyGJJJ9v7qdWRasJORX5aGDaXoEch5z8+KuOq4u/TA1cPUEktZC?=
 =?iso-8859-1?Q?5FN+RdqqJOVN0CdYnviFOk5eD3AHpTp7tb5DpqEAuq2RW2iDPlHtesgrWM?=
 =?iso-8859-1?Q?w8MqJFUsnF9v45HyhjBlCvrvo/ENtbrhORoYj82h/5EWgU3jHretrolF4W?=
 =?iso-8859-1?Q?3J9cG4hL/K7BBjc/hzAl+rICbQ4SCz42AC9wabAXNwui9iITIGNO8u+P2s?=
 =?iso-8859-1?Q?Fqtb0z7ot973ueLRQHnetI+GyXEMoAjY7VqO4CbjHk+Vl1hYGFAksFGYIa?=
 =?iso-8859-1?Q?vQIMlY3tHT/fCDbe3bFc6XQ/lT1+/AePir7GmfONuKvaP434If6jg7DC+U?=
 =?iso-8859-1?Q?5rdBhKFLfo+OKTXNRxK1w4/AXOfZQoSBUqUe5NBabbQJYowcWEhq8xvEXZ?=
 =?iso-8859-1?Q?cUyxA92NM6QT2Ph+8kbkAshSbQsPnyYI4JBQ8LG6k5SgGDtVfwnhcuqatG?=
 =?iso-8859-1?Q?2UGMSoNRP7a8wp8wpLhuThttHMeO5PBQGvdN5y21/4oD7kw0tllV2t/FFS?=
 =?iso-8859-1?Q?Hqe6K6fhGYYeI4mDYzfGTEZr3tP5qNCptEHFNcym1ZxGFXYpE189I4FIyd?=
 =?iso-8859-1?Q?lR9meFI71K/BAYdXeUrCp9p5pxaVpU0eVAH+Pxawnbu+3QuWzYlybehpD0?=
 =?iso-8859-1?Q?FYWar0U+6ozTQxNHyYBbL02O63cWHsNyig2niDyCNpHs1cp4b1uTUKbvgD?=
 =?iso-8859-1?Q?J6MH+fwAnaMfczFMUfU83YgPOCAhuhCmXCJ7x9zfYjBqRlm98dsqpHdyn/?=
 =?iso-8859-1?Q?7VmaEXUcfyusxnFEgaj5g49oY8pCyWLUOpz0z22Yv/gCntxZOS+i7X96NH?=
 =?iso-8859-1?Q?4mq5q3vmbL5PDJKc3oHsUj1HHLM16FS/u8pynFQvHtTY1RlrJY8anJNbsn?=
 =?iso-8859-1?Q?kQ+WVzVoPrcez7XKvO2gXdh2MyNTomJ2VV64jmmuo0L9Kg6YxGyL+4oUCH?=
 =?iso-8859-1?Q?JDTQzxC5Xxrz3Lz1rEnmjMN7kOq+IneFnNgITwFpaoF0lPPAgr38Rhxmhk?=
 =?iso-8859-1?Q?RIaLzt4me8SqTitbZ6jj7QZ+G81yTuFzFYJN+MOSiW+KpMxUI1MwSwmPPq?=
 =?iso-8859-1?Q?pJG8di/wvwQ+OKUKZtsrdRb60AQ2aGZ/YZMaekrKYuYWT/Mf1htqT+RSAf?=
 =?iso-8859-1?Q?3wZlVs6/NJwwHliuccbYzBRH7JaJ8SNO0IuWaY/7sL3Hzj0IhX92SkfNHo?=
 =?iso-8859-1?Q?8eoftO0zH4oaK7Tdtrq0TVk237y+sSO52oVDphLnTfajwLcGCGyUkMq3Ic?=
 =?iso-8859-1?Q?AdwG4mMxfF+ib87oq4ZKXmVdhGb5+FdBfpqJKP86agjTrz+wIjy6dLOA6B?=
 =?iso-8859-1?Q?h6iqwW1Sh67BZ3ysr82B+zIPCFLlDbY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f012a7-d91f-4955-f165-08da2d6a8516
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:53.3066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AlYAzeu222jqPr259WhxgOQ3Sg4rgxeU2TB7IL2SlCXaOUD7OMC5APaU/FpHsenLHw/bn28utZTiS08fmZ32w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=858 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-ORIG-GUID: gJqzkX9ZOuTBdVVMTDPCR-Kd3yVErghZ
X-Proofpoint-GUID: gJqzkX9ZOuTBdVVMTDPCR-Kd3yVErghZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Using the maple tree interface mt_find() will handle the RCU locking and
will start searching at the address up to the limit, ULONG_MAX in this
case.

Add kernel documentation to this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mmap.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 4343286a6ca1..f582478c83b1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2463,11 +2463,18 @@ get_unmapped_area(struct file *file, unsigned long =
addr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
-/* Look up the first VMA which satisfies  addr < vm_end,  NULL if none. */
+/**
+ * find_vma() - Find the VMA for a given address, or the next vma.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ *
+ * Returns: The VMA associated with addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
+ */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct rb_node *rb_node;
 	struct vm_area_struct *vma;
+	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
 	/* Check the cache first. */
@@ -2475,22 +2482,7 @@ struct vm_area_struct *find_vma(struct mm_struct *mm=
, unsigned long addr)
 	if (likely(vma))
 		return vma;
=20
-	rb_node =3D mm->mm_rb.rb_node;
-
-	while (rb_node) {
-		struct vm_area_struct *tmp;
-
-		tmp =3D rb_entry(rb_node, struct vm_area_struct, vm_rb);
-
-		if (tmp->vm_end > addr) {
-			vma =3D tmp;
-			if (tmp->vm_start <=3D addr)
-				break;
-			rb_node =3D rb_node->rb_left;
-		} else
-			rb_node =3D rb_node->rb_right;
-	}
-
+	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
 	if (vma)
 		vmacache_update(addr, vma);
 	return vma;
--=20
2.35.1
