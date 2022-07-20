Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D5657ADAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241127AbiGTCSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239595AbiGTCR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:17:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5881F481D6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:17:56 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1HGGj003844;
        Wed, 20 Jul 2022 02:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=sbBpb33nkm+Z7jbG5A4u98Fzt0q/0a3alrdyha2Zx9g=;
 b=Sv6GRdkK6WmivZnIh8qfRrFyuQfLhWs7g5awm3892rGirouELFTdv3GtIF3KhhMKSVbZ
 9kDkoZC+5B6KMhKiQ3v2zXn50z1+woEMDWT5XGNHV84sqL8xlBICGZDUMXlbUZJQoDLV
 a9qQJqu2Zq47X1JGpVnZnQyDPN8jw51Zc7AJ/GOxNyVubzKlLWHBLlwvCYF8VFI6ItSl
 G/J7uF8/ZKeceUEHI+xer4veX4D3uWX8cAblc57S5+n4ltFkRsr62I+AXkwz/ZymBaMe
 z2CiHqPEkMwr7UxKsVvXn9NFPVgHFDIoaDGwy6Rlqq2fZIAclcfEB5mc/MK8j6Amxpx7 lA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs83k7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLKt022321;
        Wed, 20 Jul 2022 02:17:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccSpyAGqwoVoVaQJTFu6uBb1crnMQjzJDeDnCbd9je6/w2kdZIneSGg7cB96jUAGg3Ob6P1cgVi/AvyOupmG+hX2vugTx9WFMzPd6x9XyCF7mjyBVvsSCB3P5Cvn0AFl7GaVlnud6NSoWcMd5FGnsoq+lj2UnHts3B3IYMmYJsIFX46SiagG4qy+1cCaF6laYiLmJhl+uu0w1hY3nT5U28Vg+A+uxd2eobfJHjPuxwDZzJ5y6O8X17NIPWyuOpjaCr/+JnyYMB+ptFFOP+ZT5CNjDJkiOy27TF37J2c04X9VwLzXCLSKHlyJGBpfVc1WKB2PvYCekRCLNhmhUCnk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbBpb33nkm+Z7jbG5A4u98Fzt0q/0a3alrdyha2Zx9g=;
 b=cRSytdHYJi6KW7H4Xkk44PJ+WyBNp2ym9PnSeJn7QyTUqVQjk6khQ69msbgNe4C/wWzcq9iTaIwqeahpnnShS5O6dl7pLdRCxuC/+dqHnX+KivWDU43uyzXScs7sIrRsUyywQXflD3Pqw6L8AAkFCPsOq+C89QYzRBG36qZ4I9DJL8giywVEiQV+Cc8LSQQ89arG6EZjlEUCKoikambTrnsvG+KrPr2rbEnJTmq5KUH5sZYJOS8ksuzzczGYINueIJprOUDKal0S3P3sE+s2D/h/YGcSml14/osyMHl1k/uc8l3JaBMa5lxqOXgjoE9/3wrJR0U3VNu0FO33ex/u/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbBpb33nkm+Z7jbG5A4u98Fzt0q/0a3alrdyha2Zx9g=;
 b=PNHWMU3bJLzXBLznb2+x889JAzXvKf5oNQ2Cg3rrUecXTTfcXv4ELVAtAt/c0rvwlqzklEBVhM/lPzCFlSH1AdDQHEkDkOYG4BDG1TCV/4y+mG92eFlQIVSl5LwwEMpB0mZ7YHy2ajQEvHhXhQNzWm0Sjo/LWfpx+H/jv3GzaX8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 09/69] mm: add VMA iterator
Thread-Topic: [PATCH v12 09/69] mm: add VMA iterator
Thread-Index: AQHYm97mHRqcmaIFyUaKvHPC4PTamQ==
Date:   Wed, 20 Jul 2022 02:17:46 +0000
Message-ID: <20220720021727.17018-10-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c184c50-b87e-42f2-4c4b-08da69f60a1c
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F+oFDPdyDRnN9BCYH64kiJeZyggSWq0x3d61wbyOByf5rOXsL4ueTFLzcpZb2s+chBN7PXHKpnMwRY8ose9Q4FBjRkrf4LIHbDCXnpCqDYWn2tHAOeZaGVanWYBpRQcUUFRA/FJkg8ATMb8QA8BB1FVqWkx3dp8sGy4AiSJElQ95+wkzIC5+L3a92RPQfW6ZK7kX0U0wRnceJKljXHzL87kfMvMJpJ9ySPYsg+PE6LY4nUEV9ttSQYhEEu5nQiPOL//QRSAQM3QDOSgMLfer8m0xbAS3F4iSc4hHRemSDv2VXuySoZD6+NBfAQQ0jo2R3gNWtNpchK7GeSpAcy9sjIl6YhckBJ1ziVdN1r2RpjM8YIZsFgOXKyhM6BAaaBHBO39PHccHnb1e2X+eRHMI1oAaYm6mzhkG/H3KrFBibNhCIbttmSDQtHTlOnAjadRRVXEUzPBO8u/RYgA4ozS4wYNwtzxVr/g0WXn4hcHSsty2O0NaSqACccH4Bw8R6tn7JLiy7IvTauhtJWhqNAQ4rZIKzsbeKQFudRkJuK+V1EbD+kQsWWvkdsf65UPsv4ZP+vzH4/eghN8SuBzlUtgV+lMrjHsI2LKO159yTp/JEOlKXSqMhNUpYpZDWibZMUzKuKfyWy6uc8sX3CuRDyTq8lDVut1Q3gEEHVKo59e46AJ1pBF4cMaCFQkGj3zBV2VIYxXYyEeYz1OtpAWXW0v6wHhhhsK8guTedjj4LmhjM+WH8lT0cBJmtCeduBag86dLCqL9lnu5PD174lXYShlhEyL9gzJ2+D1LiZecoNR0QhwUFwEio0NxKl3vU+TdAwC9SaXXgG38YRoCsXw621YBB0VGiCnlzKaQpH5SDJKdfaeGsusIqmJ5TEn2cMKLHAMH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hyK9DqjRVbopU9EufngUN7bkqA5fjuilPT158WcZH3edL2pg9b6eWaFaIG?=
 =?iso-8859-1?Q?ypLGqM2ZE1qKcjc+nFnh0atN10/1zZmfRgFBSsZzbnnJ63yvB5j1mU8on0?=
 =?iso-8859-1?Q?+QUUwvWEuml+waNotQqsR3Gl52WOOAISuhZcYOOUMhNLzH/lThdn8b1bkL?=
 =?iso-8859-1?Q?FNmIxpEVYta4tYuTRcyTKjP1LAOQ7bbGSCykt7h6Zh99JDwUm05g3wKNsT?=
 =?iso-8859-1?Q?uxMxLvqCR8K94SpNlc9ilVDagVTbhIpd3rkLymnImxqIpEtG6NPe2FKQKv?=
 =?iso-8859-1?Q?ygjxj4hOCWXAy32ESM1wGlCyvu2pXWN40nTcz/hx0gpcxsZC4rrhw8C56X?=
 =?iso-8859-1?Q?NqfNSr0Rz7BwSEAvuqiddbXh48iREngwd+AhHDK2THlu5f8rXpVDG+gI+K?=
 =?iso-8859-1?Q?5QV59fQutBL3+jnNjKphU6WuchspnMM2NJzSy1UfuWnfphLpIZsH5bYFYe?=
 =?iso-8859-1?Q?mvGiHaD7ab2kMsssAHUP763XTEcUQev8tCNFiQxJMdRZ7j4cqkZ4KGkVDY?=
 =?iso-8859-1?Q?bhAbpZxGTvaeOPvorVOFhLHEs9BWczmd8dRa8wusnv48M0L6teck25H/ky?=
 =?iso-8859-1?Q?nMuMcGQVOvjhx5dMaZ+echhnf2vVB6aeyCInfWAd6p460x6N8Ca8dTUZCk?=
 =?iso-8859-1?Q?PDseBYKzgx5VO3TRBdJv98WCZflP1nlCERlA5dDR3b9/BKN+0oxEt8gJR3?=
 =?iso-8859-1?Q?WL2QtGzLcZ7r9OnswiOsn0+mDmc8N8bKiiKanNGPfPL2/534/OcqD8Ir4v?=
 =?iso-8859-1?Q?ykVoS9MdOg4kU2nTf18utxnWTXJOFNvVDJyL6NlKKoHkNxjKEgRSmydCC2?=
 =?iso-8859-1?Q?wWoA0akd7XNpkbGCJzcYSy6CNo5ECbhceX1T7GMsRyaclNyHt/H4aSpd//?=
 =?iso-8859-1?Q?6Rnpluolqtq5mdbDYAwsoL1hZUdpsaHYoamOVK31SZXhOBNwF9Ft7O8jPx?=
 =?iso-8859-1?Q?CTnueu+r62gM/pnNllv8Q2pXm+TSx6iFsvpGHDpkzJWqBWPXVykRxUHzYs?=
 =?iso-8859-1?Q?v/2w2XU+4rJ1Gi5/AbeX3yHeMDSHMsANR+hQJOorterROL6Jrk5Djt8Wul?=
 =?iso-8859-1?Q?Ej4pwSPGlGGjE/WLTdqUlSRUpmwW9FJBm2AxmDIGpz/aTdFVXvE+S1QPff?=
 =?iso-8859-1?Q?HYSRpGgmQIKicUjZ1Z5HkVFJXGikFrwnkXjaWMDGbaqYf7HdvOiOwLYPAQ?=
 =?iso-8859-1?Q?Woelak0QoHS8dweOa2jcHTobGVMsij75h59lS0dEJucVQRJrLshmB3mzv9?=
 =?iso-8859-1?Q?+oDpZT4tfRRE+986MKS353kFCl7e9QgpZRuU1VG4LMeJdvoy5OlSqsBC+J?=
 =?iso-8859-1?Q?B+p0WoibW3M3sFWWrPUO2IJGMi9axiikddh6GHM6YCubsz2uUxzR9GOEUm?=
 =?iso-8859-1?Q?UC5ykO/B6oU25m9BfbgNfTpj1BLjqCOoAO5WSHVIVTMLf89m7xFGNk+Uc2?=
 =?iso-8859-1?Q?VUhYrTBNr/7PGU/rdJYkj+jy0mY2j2YGZPz6808Zo1Xf4rFpi1pGbvhRZH?=
 =?iso-8859-1?Q?UnMyHRiDiZL2HmoCtW8laNpsW8J3FhnwpO8DFcJmazkEZAF2eA5twU3LAl?=
 =?iso-8859-1?Q?Ko7AT1y3/tgoMmNrncLTDWUn8lwWdFCgsffKH/FsGh9tHg5a1t1Oxu1fb1?=
 =?iso-8859-1?Q?8sb2eTdTkbVRa+WKY7pAanWz+l0S/gYxlzTSbtyKrvFBf4jnuBYm5aUw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c184c50-b87e-42f2-4c4b-08da69f60a1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:46.4627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4f0xB9hdWLeVP6QgfU72OBkSRXJbu5++1SMH28NETqx8DB6dGbLCLxyfTgsKetPPrVWsKKNbI9fj4SIDTKk1Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: Enf8b4KCiK2p8_Y5RMQLQA2BXreABS-2
X-Proofpoint-ORIG-GUID: Enf8b4KCiK2p8_Y5RMQLQA2BXreABS-2
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

This thin layer of abstraction over the maple tree state is for iterating
over VMAs.  You can go forwards, go backwards or ask where the iterator
is.  Rename the existing vma_next() to __vma_next() -- it will be removed
by the end of this series.

Link: https://lkml.kernel.org/r/20220504010716.661115-11-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-10-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h       | 32 ++++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 58 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index adc963765d95..dee609fe5c1f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -658,6 +658,38 @@ static inline bool vma_is_accessible(struct vm_area_st=
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
index e810aaca6c04..47fbff4d4502 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -696,6 +696,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
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
index 0e202b16caf3..ba754a3cfbd8 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -633,7 +633,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -641,7 +641,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1338,7 +1338,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2886,7 +2886,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3094,7 +3094,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
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
