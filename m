Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE61159C221
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiHVPGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235931AbiHVPDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197452B27B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:40 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkIt8027901;
        Mon, 22 Aug 2022 15:03:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uckKB6Yqy9YaaIEN/knQ81xvkf/bWICYIXvpz4gKzzM=;
 b=Nqb3VGo6JiONXgdtWiObiLUp37R/N3k+7uGOwV2RZahy8ykO3XnB/2Ptlwke+iqY+er5
 mt4MHv7FvF0tp3n9GTeR/cPHW98b7nWw1zNHyJ69yPYQx145xeGPmkCj9f2pG8vPDNVU
 cLyEvKB7YuEwrOAEO9GTsSoJ7x+YIITN7urNWNDEDWK95oMV88HwIJJWCfU1sGgBjdBv
 uOBBrRH9C6MMGcmsNlKcHuxeMOLmLJgxVQZwChj2DvZfkvxz5haxqo85Z7XKd/ksrjhk
 080V7HaquD3gLrOVSybB/cipwUHHX08e4vBArCvoPwy76/zCblBtPnTzyRXBqnsGLOR7 fQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4axv8946-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Ok3035558;
        Mon, 22 Aug 2022 15:03:18 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tv5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JW6ZKFs+AL5C86P85AEHRdipvh7XeAcDzd3aeZ69p3mueJj85BlbnWvmwg2umcAVroz1DeFvRSaRTIq4v/p58dDgOlTWsekZToHV5sGPXhNVYkErcNED8AyyIs+KEbEuVOXGXQR7BlgOBWf9ZrwiRj2UmthJ/QnRZkGk/wL48xDx0h36pHgakRRk2ul6Wzx2ntQ4LVuRC2gwmdlOUFsIHDb3EKsP2s2uELAJXz03w2MzYmyLO/oC3wmiHNe3HkSjEYvOg4V1nGEjV+2wd0ChpbMeghMCl1mzyo8kph8dintJ+dkg2tel5IRCSnF+lmSogD05cnAm7AQ3pChLKO/gww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uckKB6Yqy9YaaIEN/knQ81xvkf/bWICYIXvpz4gKzzM=;
 b=nEEaNAE7WrrB4tuoKrS0Zx0hCackP3eqQcC13uM988KV+9K1vk5fZMshmaT1pWtVbnn8JrgXdTr/QUXLKWpjxGoLw56LduYygD45osSE1XCs+0pKQthonxPp+qQx9So4HPQRHg400hTPaZcKIWyUWCsFvqpuGypqLVS3Zlctiw7IMQeuzVV8wwgU6JCfsGHWF8+eFstW3vRDYKH2Tlo9D8fPZRl+o9KmrhS0RmVNxJavqX8reqB1kUPPtGaqhmMNdompurNDRA+OIKz8+PNO0gkAVHyyewZjvcoM0NJQMFkucWRHmdhkom245te1j1N4AxBbHvOBoIlYCENxAqXOng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uckKB6Yqy9YaaIEN/knQ81xvkf/bWICYIXvpz4gKzzM=;
 b=yv77rfQ5pZPUeAMg50vhqo/otG9q5zKhn2xe5/MD7xOjUtleZHgEhf7CkZFLf/d2/zy0xx4+2TTkqsm7yZPqv+rDXA3ZjmGjus1mTteRoEz2wzbjpPFv/KOpeqJYWaiKft46z99b8KvADKt+9lh89QP33wv6mloyxdHAJSSTV6Q=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:03:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:03:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v13 09/70] mm: add VMA iterator
Thread-Topic: [PATCH v13 09/70] mm: add VMA iterator
Thread-Index: AQHYtjhBa/Rm1xlZtEuFOKm9WN5vog==
Date:   Mon, 22 Aug 2022 15:02:54 +0000
Message-ID: <20220822150128.1562046-10-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1938535-7c27-449f-7d2e-08da844f70ca
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Keu607TPseW6HGypNt6hYERij9UQEk+ysM4AglrIeLOJ9b8W+wrO1bGztfLcSudzBiCKE5IG1dhkTt2UliszaB4PetOUjpcd2dNIRrC4KA9+UXleJbQmtb12EjJiomy2c2PnQpiYkRmcUkoiI1GpRP7fsJfJJj6Hq3S75eVMfNhvX/pm8dt7KV9AcD7xTSJ0JWmsLqPrK1VnndIkc68CDVSBFSJj/26Gx5QtjgFfa0WJiFZdnmqhEaPmZb7T3BEft8qiA9plVbhRGT5y227DyWnpfDPcwYJ3Krkcm+qBXvc9MNaGGOQL+Mwf12WcLOb9ALsJ27lZ7M5tke9PCh9sYOCPlQN/l9TR4gWiCmPV0Vv7qIiSHb8AWdofugI3JKKr34IeVt1EpY9HIUUNW/kJLOUyHSg2rysLyHfBB9Y0gjBJO5RoIucWV/gFh5D5dirhIFxYt+iYDdc7WuzQb3XJ9VUsTLgbjJuflD40f5QU+jqH1f/P/hOwvJ6LkCFINcyQn0lNM+l9vTAMlPto6vns5Y5fxMJYK4Zpjlsav0H8q3ALwk/SfkLR8F9d9wwcyvftXKzoUlNDQv/FPmZhU3CRFFp/2yPKxVB+r9I68xEuUEpO9NrzFDLYCiAbrhA/FyiS5LtTfXdNLANu36kTTWr+u2zi5g0+YGhnX21zdvqHSHOGun6/EennQxNImaT+NHpF/MUhP6zqKGt1W7AZblvWp2JqBakXd2j2XQxOy7NSdXkjydrfDue2Mw88D04Z6uzvIadRs0Y1rdbpAtUsAr8TDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?VZWxGWMbUGwJlGxtICvS/2BCHucaz7q0o9mW2qvOBX9T8oLqVdwQsjvS7k?=
 =?iso-8859-1?Q?25gNafK1f/koDK3UrmKvLCBw2xFa9thhdfTs4R3o9VOXlCw5jqx56ZmvhC?=
 =?iso-8859-1?Q?+O3Dsh2GRn3Y3gTmkUNBJHMT6RO5JmheoKmvHHgEi4DsX2ZKOMMKOubw+l?=
 =?iso-8859-1?Q?PNtvbvnfJ6aeCaW8Qwp1V6FieHZB0czw7rwa4uyET9RFFoPDyc88Rg1ykX?=
 =?iso-8859-1?Q?qJVEHBzx68OetkRq+wTJjiEkUJPrPx/mOBQ+9DHnk/s+hUA1jEN9/hWpOV?=
 =?iso-8859-1?Q?yUqLkefa11wH5RXSzVhSgWmyGagiVHZG489ZBIjfdi/Jt8eyKLa67NSbiv?=
 =?iso-8859-1?Q?A4zH6TnqWTgr1cR13/4OsAT6B5SZnv5HBVjzE2Md/aCynsmWNong8feUVf?=
 =?iso-8859-1?Q?psUAyVb+JzLFT4T39kcjgPBQ5wNFsPwB4x3T080UqhIul/FFVLNqu3myb9?=
 =?iso-8859-1?Q?Qrjeeh9W52GB/YpgiF1Tguiy05XLi14cbMucxu7fLej5RQbGCMZhpN2cJX?=
 =?iso-8859-1?Q?i1JGjgI1/lMdZy0G+CfO8OZiTGT63Af4ilsIOfyg1+2OKtWc25TFIEuxfv?=
 =?iso-8859-1?Q?FrHeZOFt0hqDJKtUs9iBatQIHny7AMymxr1u/A35BYpTQAbcvAyZiUfkuS?=
 =?iso-8859-1?Q?A6JyuWkUpm8OgnibVJnloUD2+C2hSoYT3bCRHFMD9JD/fmv6zZclJU3aNS?=
 =?iso-8859-1?Q?q0rLK2myCTj4gbvZKNoUNQ0m1mTNfXYLAgDG08P3RqEQn3wQa9s5GDsTTo?=
 =?iso-8859-1?Q?FrEv2P6KBDDRwidgsW/6HTCvBVM9aHspV3IyyaCSO09cdtwLwG/KJ885s3?=
 =?iso-8859-1?Q?7gcd1pQ37soKMpuDHVaOyXoyhBYmOkQOa1dKeU8T7GuTjFw0sNdpRcXt3w?=
 =?iso-8859-1?Q?91JbjtUhgdZ0ZQa7HPXkJBN5y1pmgZPSCXlwu9TX7UWAp8ncZi0FIWW797?=
 =?iso-8859-1?Q?FeV8h8w4txNy6fInwXfLZp96BP2P/VcRkaivgyy0WAfQJv6uAzjLxfTo/K?=
 =?iso-8859-1?Q?xR0JN8lB82xTyJxwWbkHdSLtAErHBSyH/NELjwKzxVT0C3h6ABf3909jfT?=
 =?iso-8859-1?Q?g6RbyGGNU1xgnpBEdtcbarj49TDdKG8JI26V2RwrbSBwc2Vc43wFB9SLu6?=
 =?iso-8859-1?Q?IN4wSVfmrEUeVyO8SqIaQjesPR96Hq+cgyYEWkSlBAxzbg1gBrqVTLW5sR?=
 =?iso-8859-1?Q?kTbWEmSIoiguoAynu3ESy7XqWU2S+HImymdsVVM97M3FVT/QXeKz2A29Tb?=
 =?iso-8859-1?Q?LDJKXZQhbvKPerN0WC2R2TAGGx6roqOmFq9EKvyK3UEu/ANNZsyNC81rU7?=
 =?iso-8859-1?Q?ZUcdrPUweSngsUO+Aahw+SlxJxOa3tlzuC5DP56Nx4bC1vOxoYR6oheWx4?=
 =?iso-8859-1?Q?5b0YeNXYYgCNIOv7d0OKK8QcF0SCG6Smd7Ku7AeDjRTbCoZ2gCNyWLzsQI?=
 =?iso-8859-1?Q?RJw/OThjeDsuYTmQ8kvGAzzdNv/3g+osNfPjx9AIDUXoPAcIlraeF7eKET?=
 =?iso-8859-1?Q?+P4gPlLMTAzlnAhJQxd9gyweHfmF3ND0bu2+AI03zzChoNkTEEXm6UqOJN?=
 =?iso-8859-1?Q?Hyp7/1UnQkJeL3tZc46cVay687/nQo6bkzTJOXsjsZHV+egJEYi8xRIMlW?=
 =?iso-8859-1?Q?an2MuGRTtzr/aNgtetqrO/xCAREdAR9R7/m7qlY+orKm6Bs2IFa97+2Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1938535-7c27-449f-7d2e-08da844f70ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:02:54.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FwfYxBtdq6/ZN95gsVFFy+N5JirzjSdV8a0irA3NYYm1iP3SmgoYUQsZPFqmVop1JO8P7k5HXbBoSvJj5ja9ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-ORIG-GUID: dYSzt7qK4OsTYzspdDT788nqqdN_e1Hc
X-Proofpoint-GUID: dYSzt7qK4OsTYzspdDT788nqqdN_e1Hc
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

This thin layer of abstraction over the maple tree state is for iterating
over VMAs.  You can go forwards, go backwards or ask where the iterator
is.  Rename the existing vma_next() to __vma_next() -- it will be removed
by the end of this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h       | 32 ++++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d24a6cd6c48b..352f5d9f212c 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -661,6 +661,38 @@ static inline bool vma_is_accessible(struct vm_area_st=
ruct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
=20
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
+{
+	return mas_find(&vmi->mas, max);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return vma_find(vmi, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+#define for_each_vma(__vmi, __vma)					\
+	while (((__vma) =3D vma_next(&(__vmi))) !=3D NULL)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(__vmi, __vma, __end)				\
+	while (((__vma) =3D vma_find(&(__vmi), (__end) - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f5d6869912be..a249a7d5f5da 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -778,6 +778,27 @@ static inline void lru_gen_use_mm(struct mm_struct *mm=
)
=20
 #endif /* CONFIG_LRU_GEN */
=20
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, __mm, __addr)				\
+	struct vma_iterator name =3D {					\
+		.mas =3D {						\
+			.tree =3D &(__mm)->mm_mt,				\
+			.index =3D __addr,				\
+			.node =3D MAS_START,				\
+		},							\
+	}
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	vmi->mas.tree =3D &mm->mm_mt;
+	vmi->mas.index =3D addr;
+	vmi->mas.node =3D MAS_START;
+}
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 5115eea6a0e6..20718645d82f 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -586,7 +586,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -594,7 +594,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1291,7 +1291,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2843,7 +2843,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3051,7 +3051,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			goto split_failed;
 	}
-	vma =3D vma_next(mm, prev);
+	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
--=20
2.35.1
