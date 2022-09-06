Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361A55AF4C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbiIFTt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiIFTt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24BA2A82
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:18 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYjB029914;
        Tue, 6 Sep 2022 19:48:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NtONvX9JVH0tbWktqIJYRovUYQEMbjAc2UkD0SznAfo=;
 b=Z6p53a5aFKy3cspz9JZBNecu+fNl2qfqbWriZzlusQmw46Z92AXCqq53cK+bkZkWFRcP
 FgMr2w+Uvn8Uqlql5Cya6Gj814CIb9/Bb66fu5ocwF19c2qx1djZOXIi/RjS39DzFCd8
 ufqd1JqrjhW/gyOtSOaDwuQ4diFslUWvnpw6qiG4oyylRCEjXdBHBI90rQaS0H6NYK2p
 1e69plVsM9Ro69M+Jnj27Lijf5B7n9cz9pwsIBZxI5wTenYRAZGDa9zPjVxw3hG0GkXB
 1xNDPgjuWr0BR1Inj0EMNhLJVxCE9MZFiEjgnT7AhqozMs4EISUr5Qc/yLi2RNSd6zCU Ow== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8KXL023727;
        Tue, 6 Sep 2022 19:48:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kr9w-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBKTVByc77EdLqVPkw9ghYLnm5JVpdcVaYUf2S9stb3M7Ku6rJwOVj+MfGR1uUuDPknqTwBNdH7sR9r1VhDgJ/TReK1ggHjq7/DiD+FGeNWUo6e4gccI5RS9WwK9pswFFizj9M2fW0xSP4B0cUGB1ceUP+37Ve70akC+lMVPManoUw1q/9k6xnWRYJ88rfpX9bRmbXEb87Zv57nVCluDng3LvO9vUiwquvFCNI5L0v+M4QQz3CE6f8iBdDPDek4ur1RQy0SBk5CCS9JJlgFdvTNrZmuoEjny2fuHjKk+iKjVooPzjYyYw6apU+tamvkiggOtzQB4JYlcmf3bqTxHAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtONvX9JVH0tbWktqIJYRovUYQEMbjAc2UkD0SznAfo=;
 b=T/PIo1yCPRFfgfJ9rysI6LiaEQRFloYPpaMqI8nagSDUzNRKZMgkQhr0F5pLlzbmqNPKYH4S71jyOoOPJ6uJo6iS8QqZ1AbDTV8u531nY9XBr9kisuFmuWhN3ujjcw9mUVkCHlwSlB8RaRjdRYiYtxUToqhQ1Fn6ZYqIPKnD80rhmvaTUer1aoHXGVZB6EEqG75g/jGrAqh6E5li9gduQxGmehplIVESBEZh/+cPrxYKZ+fSQ9Qa1nK1hJ/1eMZYz7/qkM/0bFA6U8XOxEDskeT5JT5aeIJPS/JQTW1qqmh/ENEo5iyTGN6h/PtbnL9bsYU+SIB+0LcSYsbril86Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtONvX9JVH0tbWktqIJYRovUYQEMbjAc2UkD0SznAfo=;
 b=tGoMM99b34PDzkG5rm15Qcq51YfHscjvZ2GfcukUFaoEmJ6VIBFY7gcFMhF4V6d2akNrUdYa1aLyihLD5VZNnrd7xgL0qTwfQ0UU7vySUjAU2iIq48yK+oA9sLcVPlWDDbctmJ76PbapyFelgwJRYPHfHqR1jtMlW2vPxekSIe8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 10/70] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v14 10/70] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYwimtCpoDIcdKFU2YMeuUYYkSNg==
Date:   Tue, 6 Sep 2022 19:48:46 +0000
Message-ID: <20220906194824.2110408-11-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05b0e375-3ed6-4e14-0181-08da9040d2a8
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g8Wu54bt4IoXogFpne+iANUaIB2A3ybj5UC1TIDLX3WAOTk1g/F2ydbilEi0qUcynOb75Q8o5Iog9MOMwf2OuxguzLh3reQiq3AJ+SQcIlA2jnZ3VfQ3YK1srm1R5bQN+NE1OrRET6+b29OeBCWZeTlAklf8d6GssOYqk6WtvRnr3Na5M8xE8F/ZgWW06W9MRzlImUt5ECH6ReQydk8zTgs6gGPf5eK8q59X7OJal9fdu91BCkujyn/jL4hGF/z2X7nfI5N/n3r5Sp9ChXdtw2yKyYxqzUN/LCsuciN+dPktPen/GZ4DwkrpxHmQ064UATF0WzgaVUbqUYziD/MiNku3Y9GYaxp3CCh5g/OtQXJyRPJMRz1f4FQ37K7xcPeQfFL8Gn4NQ+E7jNnJs7nqlE4FDvA0gz0KYRovwonN+4doZ02SLh577TnBs4dfWY876qIbsoYpFnvHkE2tBl6RpBMsqPSZF344N2BLgHTPdtqd6km9yQ+y2fUXgVFQHRkzgkeyiAPkLPmpFpc6AVxyy7ni+QVOF3Fk5Jwvx2ZQydKMtGvIwgZV5XtIqRonGOtHCNix+b9uGnYotZBV6BNVV1iRH3PxMqdOMZ7Rtz2QqJKUZvuykgh+lZ/6hnH367GEGvoDo0lfYWwN9HycOmNxTXGKZnq/XyCsl3w6WKByY2Kr1s31YoiYv8KzXLW7k4GrUKperPd2uktuwESmNLEb4lXO8D9ZJD55dm6C+amcWBnDWtJ3Sa7noOGlWb8hS0RVHx6C+FCo98iTkY2FazZIgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(86362001)(1076003)(110136005)(44832011)(71200400001)(6666004)(38070700005)(54906003)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8Cm1Hd/h86szRNba4Gss/G+yDCHza/AwIqnLH8Ly/rBpDxRIWXB65C8coP?=
 =?iso-8859-1?Q?D7OuYNAPKXuiaD0GH7uJsdrifQVOsABLBMaXKTimFdSshaieSmC3sDKzw7?=
 =?iso-8859-1?Q?B8tQeULFQSYYkoeJaLgMNMhYe/UmcQDzAY+1bNHTnStiOEj4tJbVESBwOd?=
 =?iso-8859-1?Q?PYp16QCXqpsvvtvRKpxQm3QNW190rhF5VJr81wT3kZAyoV6g7Eec/Nn9Y3?=
 =?iso-8859-1?Q?dWzEKSy7Uc10g4UcxLsWcujRaflYdL4y+tY7sc0l5MBb9sSLJGBaWsttsb?=
 =?iso-8859-1?Q?EkLfnX1I3L2MQvbY4q2C6D3NSLrdjTUaFJzbE5ckyzqTUuh/b5pA6mKc+r?=
 =?iso-8859-1?Q?JITOncLdueJczaRaM+C5NxI+UApjj6P6JNwbKuUXpmCaWJTaDOLTx9O2mk?=
 =?iso-8859-1?Q?3QINg04tls76N2YxwQwD7ULMPwv4x7VH0tcCK+srOjpeTebctK1bt57cTZ?=
 =?iso-8859-1?Q?tIp+5XX3at/PF1pxKwBiMaQ0x12sQtutU/Z9knWqRL7A1NK3LqhF7z+yrK?=
 =?iso-8859-1?Q?lQdWYurnYc0drwaWbHjx+JDE9x5Ga+wv4nNIx4HqDV9Lh1uLhIhawIIJxM?=
 =?iso-8859-1?Q?zlgCzpfiJtVpiAYEzB+3+uQSYx/PLy0SCqlFP2NP7XWAfDBdMkT2YgEeK1?=
 =?iso-8859-1?Q?QllxJ0FhVyoIgMG5k9jHqcNvHbB/CM0+uBL6zvxTWmM1kKToPP72cfteNv?=
 =?iso-8859-1?Q?7T9ZT/0xcVe3BlJD85MeLzw7rWrtzbLHOIZrlRLYeBPX4rl3/ELJv0iNZh?=
 =?iso-8859-1?Q?FHK27twzYjwG81M2ygj0QRVhlZDkOPuOrNgs1TBRtohpaVNg9TxjEuDznc?=
 =?iso-8859-1?Q?QWkJKdouKJTsAwhUMQTRaz8LYL+E+TETAxzyTAPBOFyOF4i/M06RhPb9UP?=
 =?iso-8859-1?Q?J9PGmqQa9Fzo2ZP2AUslNXMZ2oWcMaBMsxlXlXRjhLLepfchrCStFfvPE6?=
 =?iso-8859-1?Q?h7C4k3xwnB0UQJ2rT/lj54q/1EmpoZYbA64e3ImdZUq5GM6NzN9j3jCFgb?=
 =?iso-8859-1?Q?C17+CVYh3Q3L0T+HRgcuVDGTK0H8gzhS2FJaW4ALPncpdPlJS5hEBz/MzM?=
 =?iso-8859-1?Q?sRIHGe6D7mPTRefqprNndpiqpwGt9ZhHinUhp6Ru+NTN9/dzZrUdRUKOVZ?=
 =?iso-8859-1?Q?JayCXbmUnf390ZCgpRMQkOywaTFAMjFj7YA1G2AvJGEu+v+EwwPyq9Q1ii?=
 =?iso-8859-1?Q?5rObuPfgTJX/iaP2WUZZzBEv0i2IT8Dz/FiWdRLEhCf8mzfKPcTqOpmynK?=
 =?iso-8859-1?Q?uAf/Hs0/q1FdyXfApu5B7slAfIYtSqGwkHiKhSEB+VQzPsKFFfqxkpeRGz?=
 =?iso-8859-1?Q?jfZl3612x7fF7TK5nhABMJ/XFFvylfz8WxnA4rNQDLTkqfWNdtWdPSX6eB?=
 =?iso-8859-1?Q?kRo+AjNvvfS6sjvz6vTeSYWNsFHt40eRruFPDHtAsckTKwwbT2VUnIg9y1?=
 =?iso-8859-1?Q?oU3eJwPkBZ7F4Zjnsx50ozDtFN6kSbo/9lSb0rV5FVdLRssVUf1pv/aSVt?=
 =?iso-8859-1?Q?WC/8rqpTgRjJH/cvNyQ3VtDfNucYRemmid6Q+mdZ8ep6ygQqd/bIpXyjLN?=
 =?iso-8859-1?Q?Odx1wZAmlarzmjnQqHXuT1crCAtbAxy9zWCwdAzVDVoxPx0ZYiROostD+A?=
 =?iso-8859-1?Q?zM/IrxAT0+7sPZCtuYDMP978qUoXIpRM87S/GubEhMMizetQ83nvZ+GQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b0e375-3ed6-4e14-0181-08da9040d2a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:46.4913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5pMbOxSw+z0gFpAdWkWjn5B4OlsVk4H8S6L9jitBGneAokHSSB0Sq+LHHF/HjvwSGx4BDZ8eduB3BX/ho44cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: Bxv-fSoYTuhni7GCb2VJXI_JBh9SQ59f
X-Proofpoint-GUID: Bxv-fSoYTuhni7GCb2VJXI_JBh9SQ59f
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

This simplifies the implementation and is faster than using the linked
list.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 20718645d82f..f1b07751a1e4 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -629,29 +629,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
start, unsigned long len,
=20
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-	unsigned long nr_pages =3D 0;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
+	unsigned long nr_pages =3D 0;
=20
-	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
-	if (!vma)
-		return 0;
-
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
-
-	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start =3D max(addr, vma->vm_start);
+		unsigned long vm_end =3D min(end, vma->vm_end);
=20
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+		nr_pages +=3D PHYS_PFN(vm_end - vm_start);
 	}
=20
 	return nr_pages;
--=20
2.35.1
