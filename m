Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDF8577341
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbiGQCrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiGQCqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C4B19C1F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:53 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8l9f005050;
        Sun, 17 Jul 2022 02:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=WcMcAslgmPwZ7juCxkEu25aXPR0nrmunfSU2xJ+bkCA=;
 b=lp+VMncyBn0fnImuCx7tX+OuoRDuGAkNKjJa8tJRijoNdrK1AHKmY+9gP/Nhq2oY1l3P
 M2rchiK6xFrjYl13r77ZfRoFbLm0DhWMSgQuvaB2FqYbHWPb7BNPmWvjKGzjPU/3dTyK
 j8eDjKSWsH3DjkAMxxzhQ8MUU36Fo4RgEOZuX9QJN86NayF254k/cwS2Y7bc4wExKXXp
 vmDuf/RxrkUDImmydtEadtEAYjKy0gIiJddgZyK5L9iRm/Kcg/8z5TWu2ZVJ+FB81j5X
 AAvFO/PFFS05qsGA3qwfZtcBue2tZjc3UQD1BAKhi0rCyFdDqBBTCbYbT2Oizm5dIzT9 Tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImU036151;
        Sun, 17 Jul 2022 02:46:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZvHZ8BhVGoJREdXirBPnsBtVqsIcgCEGOgEdnEz9CmUY8JwHlNAu0ecmw6EiJO9vHN/qfeQ32nlrPhUNSCb5N12x4QQ57Y3YkwfFX+3lNkccmljKVSzMP9kNEajed57BD/YVW2GMwkBOJhMJeDv+wpLMtn72W+0NflbckAhSw8X/wuRngybGlJ4OgNULKZsXMYYgQ9/iPjEUD8Ln44vZeApmvmzNeasHntn0CooV8sivWYkBoDCcXRz551CbB4cdvsPhoKY4X0xC1L7ChIJ6/AmFnnaBUxFtK8gUhfRnxAQDmrSsOT4MKocGKu6G1tOnarOf9Q8u4ljJnwMWMXvhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcMcAslgmPwZ7juCxkEu25aXPR0nrmunfSU2xJ+bkCA=;
 b=eg2Sf6ZC3CPfblfQ1ZLb2iS1HR7SGzujBdhICfgoGuEv1QTMiB8CicZmDK4WjPsJxgiLM0xSKsWzB+jd97voF+O0g2xUQVYzLtpJHkucesDRrg+xdpFff41URWdLzy5RqYDEwrJLck05ziCVYMR0zTb2dHtmUbKSqOz2HmmRj5YS09J/8GboNXlHfEa6SNPpOHsfKiDDQDB0Li0baxGUEUb5hm3duesThaqSCnkPRZ5U64spc1oomC+FGOWcGh+172UiF/LNtWlTFD6BDlPjYCfHTXKiIuN6dphQ6R8NLG01PHlMUzJ8VL6z+fWv3V3PL8XE3rhlAgGFz/+O2XmhCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcMcAslgmPwZ7juCxkEu25aXPR0nrmunfSU2xJ+bkCA=;
 b=GCSnlT6FV6P7xO1cP/s13+gee3NLvRwRP6BnBlRgGsUVCElxcVypggqnt796XclYpgHqLY4psB+bIx5spyKT25LPBOpVUA0EAu8QSRyrDbCcgbWvLRTOayXBaAtn6MlS0UkZD6Aud844S3iPbkIFeA0CeX0ZbHkns23TZ/1Om38=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 12/69] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v11 12/69] mm/mmap: use the maple tree for
 find_vma_prev() instead of the rbtree
Thread-Index: AQHYmYdxe6N1gqcEKEOB78jX1l1qbw==
Date:   Sun, 17 Jul 2022 02:46:40 +0000
Message-ID: <20220717024615.2106835-13-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9739b19-232d-4c0f-295a-08da679e9500
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m3QGEJF3EzQaXUybhbt3ciuOPKxv4BQJLVUZ7SYAyVEH/kgl4T6cgO926QTq1wGkjBBWrSeikujdFiuSikzbh5mPKnpC/WgD/TEocSs0q4Poz2EuFCQZ/1XOtpTvsge2HOLQLpdLCeyiQEXw7iBIMiUiEfJ9VA1p95tp9VswuQvU27oNCe8w6QGlXfrrmUxZYLcOJqSS19aIzvaFP0TxQBdGD5ZidJ9k2IgK2SM1rKeAqqS9bdxqmma41k7JVaWVxOD9pazP+jaeFhQ6RNhdOXm28+ETfJv376gwKGqVsj8usiEocDsxZB0hamkTOo4xbFgv3E9Wvh67uNu/y8wyz5pLLqnzJrwGE3dGMUW7WsKLnxQ9gNgC1WRBTUqKLISl0duw6w9e5XtWcH1emZgGRRAFNg603QVXqK7SBJiUSHGsBIm9fB+rzi7M2F/aAxhCkuIRocbf9n9ue78HKf0oGpF2PfM98zPN13BnaBdY7dnfw/G4KOSoE9JNhEzuC7ctQunmyk003Zm8pYEay8V1YKu2bjjd7zBI9aQvpKpCH//joV24V3UVMsY7ZrUPQWn1bYRL+R1NZDARR8P59BLQR6zR4LanKR1a/tsPx0yC2ULmQhKWpbAQJNef2RSvjgHyzQLH3Dz8iz20Ugb0/68cBYyLxpgT6vvjCMx+oq+rzDQbvDuF6pymsmhl+J0Mvtp2TPYrNMqgkrpLIjd1DeZ7KwSApLlR2SUv9VRvd4ZBYeBSloVTyUh+pXXg4RUBRN80WIfSP8Rh73tSBg8xJxftTIzQuOyc5krUSISkR4QLJqL2COmkZQC9c26BNcqIbVLDNevwgJQVsfXVMqGog3ZloPo2k3a6Na9qMMaT4MnZhBzpa4TBr31uscj247oMoEp110WW7YioqAnZWLH9D/euDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N/qB3w6BijCEIJQUrMMNst4XXGt9Izk2avu+E8/6SqBvuC3iWBEXESkWUG?=
 =?iso-8859-1?Q?/uIn8FBUz/sbYFF3r1TNZ5xcrhuR3AnixdP3hWW1ageuRiEv4pEBBgrzTI?=
 =?iso-8859-1?Q?JSL+gugqZjFEJo4zlD3nRAXuba9CiMv95ahRq4OrN4w6RX/S104AKGfAwK?=
 =?iso-8859-1?Q?EqQYp4U42EfriPDcQlOXPO7H2AeYDlTUuRUrZzJeWAqIOx7dOErYWxIqzh?=
 =?iso-8859-1?Q?/+cNr5XF/cEwq1chFKU2Oy1Yzka7YSgv7qS8pzhfltlB8znYd3ZzuRqi0p?=
 =?iso-8859-1?Q?K4nRCWj4odfUGJum/BAFYJqDXZL3hDp3upH6rWCpeosGAAVv2PzPiQFgYN?=
 =?iso-8859-1?Q?k8G+P+BuMFpDORgIZMB/wdHhq07X8hIeZJVqGOsWzdUyR41v73DK6SFC9d?=
 =?iso-8859-1?Q?DGi80Np8z0I90MdKHEIKxgwLaMKH4NBTZUEcn0zix+jlp1AcfIvnS/4Fvj?=
 =?iso-8859-1?Q?qHBIx0a24pyfxoE9j31StLluZuwddHh6tEoP3FvpZvQ/NTI/c7iznEaYm3?=
 =?iso-8859-1?Q?aND3wpTiG4nwc86TxpPfF+SUNGO3LqpgWeRSOQkcPh8DWi9k+aj8m2gLV1?=
 =?iso-8859-1?Q?fFadtYaAu1jNyv+xIzBFGe326qQqWaVyTQ6/C92yiqWtHHnd/0zDG6P2iz?=
 =?iso-8859-1?Q?zBFnXaad9hbGPLzAi5+Z8Ew95wCXv3I9Lyz/nYXQRnBwZjD58g2jJqahT8?=
 =?iso-8859-1?Q?T5EhnwqrZ2CSNx3LwavTcGvBVnYnQW84/UbZMhy57Ub4rghWAj1VE4Gb+A?=
 =?iso-8859-1?Q?8eslACz35G/HEItMb8v91gqyh7UMS1+3E+E6MKiPA7ttUW4TJq9b9BBLL5?=
 =?iso-8859-1?Q?+HJlaWi1sFPuGb4R1SqtzVbgX+IBDNAP5aTuOSmPrPdzAyh2eS9kqw7kcN?=
 =?iso-8859-1?Q?lx3CsixCsRR2eweKY4ivE4sfPSQ5Ydz1i7iU+okVETIC/L66hoRaKVv9aM?=
 =?iso-8859-1?Q?KXJBNoC1MtKoeWxIRWzvosTlnbIjDwua295fXqKWKHyqMXPtMT2MbA9ppt?=
 =?iso-8859-1?Q?iRDpsGDDtHDclu4iAKtxakyeHo1B8NpQbc1XUgB3krx0Alf9kzQ31Fj3UC?=
 =?iso-8859-1?Q?jd/QKEnhr71ZfbRECfdJT+WhmWyF0TkUa/mCIYY1Q5v8CQTRlp3ZgeVBzd?=
 =?iso-8859-1?Q?/t0I0wWpmV8tyDmvAqWZt+V+d43pnNhgw+CVBmtFCQ6xlJ1iHZp8FfKL6B?=
 =?iso-8859-1?Q?LWvD0iTAmpL/bv/rAAogfiZfemt7yl4eDk3A6R3y/XbXix2gG5Hki2EiJE?=
 =?iso-8859-1?Q?rqGUoetujcWeb+JEw3xtqiwuB5SV1wW+FDT40en4UYAcr9tLLo1YMsfTQ2?=
 =?iso-8859-1?Q?4oefqyKI7QjvzEgAmHuANPaJgH5Iaf7VPb8pS7a7mKEJFRXY5Hsxxt/nWp?=
 =?iso-8859-1?Q?yIi5miPnCW+kt7dycOLnz5G1ev2daiwnDrNx0hEPSRLusA1fYbQEVdGOj4?=
 =?iso-8859-1?Q?C5RvLY7z0YKr3PTF/u1171jgarZTjmXwJAyVhAeFELckYPCKbwDM/WlDa/?=
 =?iso-8859-1?Q?KJ6c22fV09/dyZ51DNPcJJ1mkQG/sIzsWlobI7xWGV/pnPAJ5py5nukE+j?=
 =?iso-8859-1?Q?CIA5XmYPx0F92z2CSQMzCdlAvr/w70+Woupx7db57/aadgKmCMIrrtfqla?=
 =?iso-8859-1?Q?vTfU8aqQHoMhDqmkAMoatjkRWoBgdtBLRWdNhiQJquBpCz7RgHC9JQkw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9739b19-232d-4c0f-295a-08da679e9500
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:40.5688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xfZBtMQB8tfaVJLLmu2Qh2zbSvUf9LAq6lKmd8Nifcoe+3QPORRsS82ndhpWchiHM92mOh9EYRUIcEhUnEimJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: hjesZXSfHUmNBr22gFkVTaUzmG4XTmGq
X-Proofpoint-ORIG-GUID: hjesZXSfHUmNBr22gFkVTaUzmG4XTmGq
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

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address of the next vma, then use the maple state to walk
back one entry to find the previous entry.

Add kernel documentation comments for this API.

Link: https://lkml.kernel.org/r/20220504010716.661115-14-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-13-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 96ff32ff97cd..dcf4887c0181 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2520,23 +2520,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Note that RCU lock is missing here since the external mmap_lock() is us=
ed
+ * instead.
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.35.1
