Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0185AF51D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiIFTzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiIFTwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A76A0620
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:43 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAjA024665;
        Tue, 6 Sep 2022 19:50:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Ofq0r9tv8WG6MaH/Kzgbm8soGh96DPJQwoND4sCdjI8=;
 b=1MG+MQDyp7Q5ETOZ88cFSSoryZkDV2acoVcI2f5P6OtjhcfumCJRrVw90G8rD7FQSmsa
 zTHR/paGaHrcLwagxKVbws7ZJcArPm0BqxhibZd5N4R0EhpWAhCGijcp9nxqLduQSxOl
 hutHPsgJqio2Sddr1v5RpdOnKViDlRTSAOYwJjg1uhtAuKyaB75GJFO8rxiWIHmcJT4T
 0hdmRRa8yhAHnQx66AvQVAdChQh2w/g6Inpg+qDJ9popfQPVe6q5tnUmAIEkXT0A/Ob4
 EJ+fN8G3/cxcjBYx9svyEN4WPDX2fU1mMIzKEIUtsEhjdm8A5jcT7ukiLtWJka5rpDV0 RQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:26 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8hVY027546;
        Tue, 6 Sep 2022 19:50:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kxfb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJ5sL3scvrUMQbWTkN4sILlCmJ0siem5LeeSsKt1WLbX1joSHVaL/tNUD9Mkm1wgAP6zF7QP/tEGiaP7ZjjI5sCmT13EOG+Ai7GeNEnFRefJoGt+TsOIIjiNqP6ZJX9tYLg42i4DuP7gPl5KDGRo8b9sptpuq/zfQg12aysw6K8kCafe1QzF6xd42ZmqnaUNW6i81JKSkGKI3l7ImHsz8EPCvccR3v+8+lNCC9/dbmizj314oFR02i/ZpzasrivgVS+zTEov081luf1QwOBCvH045MgVdpf0Id/7yHnUMHImdfuyJjqaH9ZVUsoE0UPEoCYdzvHVGOrCcJaNtcK08A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ofq0r9tv8WG6MaH/Kzgbm8soGh96DPJQwoND4sCdjI8=;
 b=e7YGnCBMM5cZMsPRzoTcxSsJ5eikP9XsPJOyH+3mWc56EfiF1H/4u4JP+d1azrDlNFQibPd3Y4LpvhPSM0+WKv+J0ovKuQASQ7Q35wq32n7mJU2dizH5hpIWPLugSPFi8spi7UktcaWDypS6yiP0hWpi9UnGW6J34ELOuE0bGWgKUOmkHNOw0wGON0ndGTyAPvShRdVGpoCrGHTXwPgoZ1F0ltoepWyZHOrKu1CwsATZaqNHVT9IBB9xFVeCxb9So/aYX5tNJTUf3utBCqZeTk9PtOvEfL5GenFmidIPqqys+VG870PcY7m+oGKHl3Tmoy4yx/+aTTVpt5kjNUEQ7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ofq0r9tv8WG6MaH/Kzgbm8soGh96DPJQwoND4sCdjI8=;
 b=DSGgh+PL9orjeX93ImoSdgLQgDWqBM/g8P1m9ex+arRF+bPZl5UnIQPxaPqz56ovTT+CW+OhVzKUNY4SRubFLexOJ8BHldmjShhcyIBRIWj+I1kCazjA3roujONnIOVqbR5iIfuLx3VE+y3oYZX4fGxEGylU7z2xfPqlShn2tzM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:50:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 65/70] nommu: remove uses of VMA linked list
Thread-Topic: [PATCH v14 65/70] nommu: remove uses of VMA linked list
Thread-Index: AQHYwim4T8c+LB+VU0+AKrzYG957dQ==
Date:   Tue, 6 Sep 2022 19:49:05 +0000
Message-ID: <20220906194824.2110408-66-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4cf69de8-7c39-4500-f027-08da90410905
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5mabmq1LptqDX1f/mV1R5PDI76jQc88jaugoiilHq2EYVa/4R9USbeG5AvDuu2Uw6z0H4GEsrcrkTKUx70kgZsBveilg+wlbQd3XOonfu6mwnFlPHwVMqUCyIx1szINrYNawvfpPqBy9WCMRUD6kMK8hpKofbGHW0jy/I3coQClrVliHeXeMNEfPsz6yLJf2grL2+wmEyV0aSB7EekYu32VwT7wEmTNENQaOUiYdZGJTQFJu8sQ/RgkV1FyswDQUTETz48XlcJeUGOrCnvCruPZmJxLyxmT48m9yNWwKxwMtGxWbq3Z+ZlN5nuzbh36mHZyAU9hUTqAKcvijL6RnT7PpibglImyAPjyFdmiGL6q8NDJD5YjdJ3IorF0XhbeG1ln1KytIJCdrYrC6504+1UxLxbqClvFiYCJOwHfwrCvf4dcD/nnkihRfZgDkKadaKaX4gyh+jbk2ptOwRqCGrv5O2Gf4ypZSJxD0hYq80VUpVmpwfyUhEGc6ZErSO4nIzZzI3CF5wUBWP3PT8D54q0FZOcCaRF/J4BMY6QJo0bHNtDhxv5YcoynFoZ5dLF+4Z0/N1ikxj+KTvYyCCQG1bZ0FyHNjK85JgItiHoagCwVatSwdnWv5RVN/aPRYYQtVEp7a4lPPx/qOmGZoRKLDpn8LfOAYqTHr8xILRsHvsf21nRVm/DzhvVjmgC/LHLdaRrIU3ofRVw3nXVr1vbdSk+/6fGr2sKZNxt2abVA0xjvS3ghASrL1ue1rGlNcL4VPQq4GuMPU8sMupMMVohPKgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NEqj8+yMm+DGoMiFIGTIZEsLiViyDf0Ief1WNmam2mTCeMAGt3QKeeYVbO?=
 =?iso-8859-1?Q?Vm2/vkOI5EpM4GqU7U7cIU+IIxZa3szIep2xKBnDGeTODLcx3Gdq/J9frm?=
 =?iso-8859-1?Q?qZ9LExkufRnTpjMs3QvwkWpcPptH4X00MN/jAuCBLQUOStiDxxuQMBreKI?=
 =?iso-8859-1?Q?iKvu8aSutfEd3InyrAwJWwG0pS/AufSOACCnYo5ez2quD8+Nsj1YLHkAKK?=
 =?iso-8859-1?Q?SwVkwczC6V9GZJ+LxlDejH5JxmxR/5H71+ZkrnNOOuio3hJk442aw5eWsY?=
 =?iso-8859-1?Q?ToGa0oy3a4bezGAgbcmj7FWOigvtpsm13Y7QhNPftNW3Pi/7Q8Q8HB3Eu9?=
 =?iso-8859-1?Q?8ePCjxMlNqT+qARHiUFCtYLAa/Lh0+U94Jkn6MPKHMx4VMCV7hPjsid2Oj?=
 =?iso-8859-1?Q?JkDYfeBrYNq58Gdbo8N6XpYReg0XaVKrcE7OR0jm8NdKfu2cCMRhuJc71a?=
 =?iso-8859-1?Q?2jwxjagbs9PYRqQo/KbqJJ39pbLe8keeusJlEgnZ6Zg3yi/rdNVgDD/i73?=
 =?iso-8859-1?Q?YqcH9WduYKmJheeTd7t9sJQsIIb7kxeK1ZK/pHkFjLM7o3Z+OShxVwgq4E?=
 =?iso-8859-1?Q?Nq2PqvlJJTr7DODPgNtnymQZeXq3ixGPcyVQL63WT0hx4wQK3xvkoBHA54?=
 =?iso-8859-1?Q?nBiR5oUJPjVvskejcjToX+9IbJrRijmQbqrUN4hV5gIfuOrsHUHql8hWD7?=
 =?iso-8859-1?Q?TOMS7jAZ8eLap+ydqv9uCCmRE0KrQ/I3qRwY8E2ILSvbruW+pLf1l22f4H?=
 =?iso-8859-1?Q?8gO1bup5+bHMBOBStS9AJp0Cw8wH6OM94YBbit9R9YmkOUKQiNbcP0/POX?=
 =?iso-8859-1?Q?n39Fdhr0IHOpPn9tt2rPKAC6RaWVr7LgRVnQRanHzfvEaXf/2xm2sq1wgq?=
 =?iso-8859-1?Q?BzP1yz0Rnr0Ufb0l+Pa7xBnjW/9IkrfC+AYJfr2+JppjB1AJ8H7yz+YnoU?=
 =?iso-8859-1?Q?xc8ZfkBaHr5kF8l2td2Q6+d+jp5NMbc3Ql53hZlmVdjoe0lXh3rIcTOrjM?=
 =?iso-8859-1?Q?Q1jkUDZrzX9/r4MbHUJw3/1nhhBglLyhlbmc2zK5q3mHFS1mLPZISgtlVt?=
 =?iso-8859-1?Q?bwssfyz6uxXxBUe8AHaehGLCPoUnEJDRm9vW0hTfqjErFAU2sChQvb2dG7?=
 =?iso-8859-1?Q?2TMF+DuQUAwdkAcarrkfn9uJVd8TjalwdeZtMJptc9imZ9qczABV671PLW?=
 =?iso-8859-1?Q?9gAKiceRzo4ubDdbjNX9ic+AmgraOUHR82J/i47Sy2mcHBUZA7vNhf75+D?=
 =?iso-8859-1?Q?xXJcWDzbgiN0b/uLXCgz/78D1QbpKENMooReH3NlOSSPAvyu8Kv+uIjGza?=
 =?iso-8859-1?Q?G4vzmkHHOamtgPuQR1KLquDtqlI1yRvfz3CrcS9a+ENXIE3BtFTS6L6G1r?=
 =?iso-8859-1?Q?qnnYDvz/BLVcUcz06lhKanLfbw9JClKigj/lKPiJLt+qK4SgdcV1YAnNje?=
 =?iso-8859-1?Q?NZEMvVA4QiTqNrZiMEvN8NtVW72GjndDu5KoCWXP0LcaW0B8WBsSuIfMaS?=
 =?iso-8859-1?Q?VbeG8SXxhrO0Xmre73vJLAbYE6X75f4QE5emuWQGxtBw15dV2A7aVVgvfu?=
 =?iso-8859-1?Q?mTTIFaluq+cCypF5RHedFcmYsa5YlME6oJBb3q+tIVZ6a8Oz+Qb/1Ye+oU?=
 =?iso-8859-1?Q?eUy3DrEir0Gttr26eHu4j0+RnyrlaUqtxlaVaUHb2ncrvenqdMmaqRjA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cf69de8-7c39-4500-f027-08da90410905
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:05.1307
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvG/VZYVq+7Hm93bRckxt97UmjLs1nohCF7Mw7HDD+H0ymsr9dPYi9OKf2IfHHSsB6UD5N7483llA4L2Nzcugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: hKhWdmRn4dOckKE0A4BCX4Oe0nvwPSYc
X-Proofpoint-GUID: hKhWdmRn4dOckKE0A4BCX4Oe0nvwPSYc
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

Use the maple tree or VMA iterator instead.  This is faster and will allow
us to shrink the VMA.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/nommu.c | 146 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 109 insertions(+), 37 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 265a444a2cc2..269df51e9226 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -557,26 +557,14 @@ void vma_mas_remove(struct vm_area_struct *vma, struc=
t ma_state *mas)
 	mas_store_prealloc(mas, NULL);
 }
=20
-/*
- * add a VMA into a process's mm_struct in the appropriate place in the li=
st
- * and tree and add to the address space's page tree also if not an anonym=
ous
- * page
- * - should be called with mm->mmap_lock held writelocked
- */
-static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma=
)
+static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *=
mm)
 {
-	struct address_space *mapping;
-	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
-
-	BUG_ON(!vma->vm_region);
-
 	mm->map_count++;
 	vma->vm_mm =3D mm;
=20
 	/* add the VMA to the mapping */
 	if (vma->vm_file) {
-		mapping =3D vma->vm_file->f_mapping;
+		struct address_space *mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
 		flush_dcache_mmap_lock(mapping);
@@ -584,21 +572,52 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
 		flush_dcache_mmap_unlock(mapping);
 		i_mmap_unlock_write(mapping);
 	}
+}
=20
-	prev =3D mas_prev(&mas, 0);
-	mas_reset(&mas);
+/*
+ * mas_add_vma_to_mm() - Maple state variant of add_mas_to_mm().
+ * @mas: The maple state with preallocations.
+ * @mm: The mm_struct
+ * @vma: The vma to add
+ *
+ */
+static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
+			      struct vm_area_struct *vma)
+{
+	struct vm_area_struct *prev;
+
+	BUG_ON(!vma->vm_region);
+
+	setup_vma_to_mm(vma, mm);
+
+	prev =3D mas_prev(mas, 0);
+	mas_reset(mas);
 	/* add the VMA to the tree */
-	vma_mas_store(vma, &mas);
+	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
 }
=20
 /*
- * delete a VMA from its owning mm_struct and address space
+ * add a VMA into a process's mm_struct in the appropriate place in the li=
st
+ * and tree and add to the address space's page tree also if not an anonym=
ous
+ * page
+ * - should be called with mm->mmap_lock held writelocked
  */
-static void delete_vma_from_mm(struct vm_area_struct *vma)
+static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+	mas_add_vma_to_mm(&mas, mm, vma);
+	return 0;
+}
=20
+static void cleanup_vma_from_mm(struct vm_area_struct *vma)
+{
 	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
@@ -611,10 +630,25 @@ static void delete_vma_from_mm(struct vm_area_struct =
*vma)
 		flush_dcache_mmap_unlock(mapping);
 		i_mmap_unlock_write(mapping);
 	}
+}
+/*
+ * delete a VMA from its owning mm_struct and address space
+ */
+static int delete_vma_from_mm(struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+	cleanup_vma_from_mm(vma);
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
 	__vma_unlink_list(vma->vm_mm, vma);
+	return 0;
 }
=20
 /*
@@ -1024,6 +1058,7 @@ unsigned long do_mmap(struct file *file,
 	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	*populate =3D 0;
=20
@@ -1042,6 +1077,7 @@ unsigned long do_mmap(struct file *file,
 	 * now know into VMA flags */
 	vm_flags =3D determine_vm_flags(file, prot, flags, capabilities);
=20
+
 	/* we're going to need to record the mapping */
 	region =3D kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
 	if (!region)
@@ -1051,6 +1087,9 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		goto error_maple_preallocate;
+
 	region->vm_usage =3D 1;
 	region->vm_flags =3D vm_flags;
 	region->vm_pgoff =3D pgoff;
@@ -1191,7 +1230,7 @@ unsigned long do_mmap(struct file *file,
 	current->mm->total_vm +=3D len >> PAGE_SHIFT;
=20
 share:
-	add_vma_to_mm(current->mm, vma);
+	mas_add_vma_to_mm(&mas, current->mm, vma);
=20
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1217,6 +1256,7 @@ unsigned long do_mmap(struct file *file,
=20
 sharing_violation:
 	up_write(&nommu_region_sem);
+	mas_destroy(&mas);
 	pr_warn("Attempt to share mismatched mappings\n");
 	ret =3D -EINVAL;
 	goto error;
@@ -1233,6 +1273,14 @@ unsigned long do_mmap(struct file *file,
 			len, current->pid);
 	show_free_areas(0, NULL);
 	return -ENOMEM;
+
+error_maple_preallocate:
+	kmem_cache_free(vm_region_jar, region);
+	vm_area_free(vma);
+	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
+	show_free_areas(0, NULL);
+	return -ENOMEM;
+
 }
=20
 unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
@@ -1298,6 +1346,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	struct vm_area_struct *new;
 	struct vm_region *region;
 	unsigned long npages;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	/* we're only permitted to split anonymous regions (these should have
 	 * only a single usage on the region) */
@@ -1312,9 +1361,13 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 		return -ENOMEM;
=20
 	new =3D vm_area_dup(vma);
-	if (!new) {
-		kmem_cache_free(vm_region_jar, region);
-		return -ENOMEM;
+	if (!new)
+		goto err_vma_dup;
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+			current->pid);
+		goto err_mas_preallocate;
 	}
=20
 	/* most fields are the same, copy all, and then fixup */
@@ -1333,7 +1386,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
=20
-	delete_vma_from_mm(vma);
 	down_write(&nommu_region_sem);
 	delete_nommu_region(vma->vm_region);
 	if (new_below) {
@@ -1346,9 +1398,19 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	add_nommu_region(vma->vm_region);
 	add_nommu_region(new->vm_region);
 	up_write(&nommu_region_sem);
-	add_vma_to_mm(mm, vma);
-	add_vma_to_mm(mm, new);
+
+	setup_vma_to_mm(vma, mm);
+	setup_vma_to_mm(new, mm);
+	mas_set_range(&mas, vma->vm_start, vma->vm_end - 1);
+	mas_store(&mas, vma);
+	vma_mas_store(new, &mas);
 	return 0;
+
+err_mas_preallocate:
+	vm_area_free(new);
+err_vma_dup:
+	kmem_cache_free(vm_region_jar, region);
+	return -ENOMEM;
 }
=20
 /*
@@ -1363,12 +1425,14 @@ static int shrink_vma(struct mm_struct *mm,
=20
 	/* adjust the VMA's pointers, which may reposition it in the MM's tree
 	 * and list */
-	delete_vma_from_mm(vma);
+	if (delete_vma_from_mm(vma))
+		return -ENOMEM;
 	if (from > vma->vm_start)
 		vma->vm_end =3D from;
 	else
 		vma->vm_start =3D to;
-	add_vma_to_mm(mm, vma);
+	if (add_vma_to_mm(mm, vma))
+		return -ENOMEM;
=20
 	/* cut the backing region down to size */
 	region =3D vma->vm_region;
@@ -1396,9 +1460,10 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
-	int ret;
+	int ret =3D 0;
=20
 	len =3D PAGE_ALIGN(len);
 	if (len =3D=3D 0)
@@ -1407,7 +1472,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1426,7 +1491,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1448,9 +1513,10 @@ int do_munmap(struct mm_struct *mm, unsigned long st=
art, size_t len, struct list
 	}
=20
 erase_whole_vma:
-	delete_vma_from_mm(vma);
+	if (delete_vma_from_mm(vma))
+		ret =3D -ENOMEM;
 	delete_vma(mm, vma);
-	return 0;
+	return ret;
 }
=20
 int vm_munmap(unsigned long addr, size_t len)
@@ -1475,6 +1541,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1482,13 +1549,18 @@ void exit_mmap(struct mm_struct *mm)
=20
 	mm->total_vm =3D 0;
=20
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
-		delete_vma_from_mm(vma);
+	/*
+	 * Lock the mm to avoid assert complaining even though this is the only
+	 * user of the mm
+	 */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
+		cleanup_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
 	}
 	__mt_destroy(&mm->mm_mt);
+	mmap_write_unlock(mm);
 }
=20
 int vm_brk(unsigned long addr, unsigned long len)
--=20
2.35.1
