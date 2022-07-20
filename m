Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4BD57ADCD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240201AbiGTCTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiGTCSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14E465D73
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:09 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1VWum002405;
        Wed, 20 Jul 2022 02:18:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=e8L5iapCT/dd2KBlFtRDkBUol53ruDyFgw94zQ0peRA=;
 b=i7nzbVmfIy2d+GD8r20kx/OS6Vjz3zu2mbxKzxsiq41xTOFQSiBM3KkX4nUmjb2w85Qs
 uKefPvs/1q1uEj1x4Uc8ouN/LIdp2mlc8M0L6Oz3vVKUylBHPioeDTsgPdeLhStkqU5c
 x2OuM7oseTqW2lrV0kn9bvcxHTREb/NYoND2ZUm7ipl3tGmkAxkQK0T443NNP8V3JemH
 2BulS3bkfKcZ/uP4gq287x5nPSWhFK6kVqGhV9T00q4a8D7cyHePJKq1x+IPfMAQYjD7
 5VlRO5HaJOCPIB1uA1wNQERkSylZubsdESqxjMz8nIkmfspOYaw/z0vwomn2hYsF1IGB dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81m8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2CLId002698;
        Wed, 20 Jul 2022 02:17:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnupm-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EGHr/t/FrBBwj4DGTCLoq8qGLIvtshdfVDzLCwa2t7JbeBlBi/YjhvGYgddI7avrOvkz702AksDFn3LUfE46QaRWPIS/RCnmRirtCbyJ/MT2VcTcYV+oOnaZYW5xmT2rPs98prxYJvqNRvHz2X+ha3vI9vNeU4VyZluZk2vKEpHrCGlBpKde27UM5dfFCFvFi43ApVwVOnw0O6PDfzWZIV7hDI1b5See3M7it5vkahiGln1UHT0XLU3P+Z4gchLYclOpT2TbCLRVPp8EDzR9RLn2Rt2iYtOz0via+vWc3o6uval3xmnR3gIMncKbw0JDvRrCXd7UR49Tw2RuMiVwvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e8L5iapCT/dd2KBlFtRDkBUol53ruDyFgw94zQ0peRA=;
 b=b/0M5FJQDEgV+hcWHn+lgcYyDBJOHAzL8eNG4x7ZqUQ/hM5gc78vl1gLOLPzpixx9zcQAa6kFfRHi0XOFDzI533NQuH3vi67ZBAzqmWzebjU/LkHD3o9dDjrPDcP1THX+H8a6f5zPFONuSE2WImXrvf/4fTRSNlCexKhzibAL8li0+MEptTHlEruMdB4fDf61GPybFqkAtOkJqH8uso7MJxiKf5jiOuJMoztyZuQK7/OcDRSfY/2tznfuYb3fvqdXXKdwXqPiRcZzB7ottrgQIYDNkmNqWSv5QzUtoZ5FMRY1+J8INutt7/8DZnDlZ7+uPRWr7ipRlj5lBdHOFT1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e8L5iapCT/dd2KBlFtRDkBUol53ruDyFgw94zQ0peRA=;
 b=vXp8Pje10+K7TtWvS7OdXygQBJSFi9kwwr+pogbtHV3fjkKTGvkCELbSK8BG4OWqMoUpBqAyMOW/Md7CW/t4NNwdbBrFGQ0GvBJkrqmfxp4LsMMwoRy1h8MJfDMw88xdguUcnfudK2/jufY8m3SRawNHkbhTCnH2v9Rbx6Grq5Y=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:55 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 23/69] mm: use maple tree operations for
 find_vma_intersection()
Thread-Topic: [PATCH v12 23/69] mm: use maple tree operations for
 find_vma_intersection()
Thread-Index: AQHYm97pNhoHnVh8tEqLURl81dFLmg==
Date:   Wed, 20 Jul 2022 02:17:51 +0000
Message-ID: <20220720021727.17018-24-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd43da57-6ee3-4209-f9b6-08da69f60eb5
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EDIWtqmPDIW9MW97+4QlHGjsLBFofElgmuAiJnyKDGTR8ni3EWuVGL5gZyBgRiAoaabREfDU1sNDkGcdxP/qnb5ZW+iFAuP7ggMGguxJ+LnkTnV0chvGVC4BduWNbm3BCyI2UOwIeDshILUCEjrCit7UKFQv8Y3npgYz2hnOc5M2Bj85V8u35kRmzMGh0xeEQ5Rz3F97T7Du6p61iAlQoNENwBsNw2AyqSz0n9iJI4aIuLW66P9l3Zk7kEx5oe31d4Eq6U7986YUMUcyIFntbsdYNuRho7doG14dpms1FxunlIR3y1nHstzZggVIDv0jIWxE7aKG7+WW82im4Gej0MIxaarvrsm4/HE55YOOeu5B0oKOoib2XzP/AV2HFahoO+BkxZ+Hes8LEqSpLtZbdY16OIvmJwhvYLXLo9Fl2wVvYKOOkjGDJxhFODrVQjXKGogV4GyqbDcNyXTjdJeiuJ7ccv3iJ8Jz4Nv7P9vBFUeYga0Siwi3UtJ94tpS0OBAl0kyyTf5Ucc3ASm5wOxbWeCa4oQ/1W0UdocRFXtL1ftQmTtKfK4QHHprhPlHK6gIUd9W1Oqh4Z8Dfu2nRFq6B4RfvoIqxkhNGV1ePYFSawTLjuBQ8rJaMLWkijmerS56y/8EmmGxcYbRENymKgxPFQQoecTHUExPNqeSB3yZFE4T3A7A4L4ZTEE2Zj/WC5TM2IfuCUIb3+S85qgTYkUECZtG2qATbPFwqIPrV7my1esny8YZmTt7X06J3bd/plJikZNiqTr7jMsnP/myY36pe5cZWyEgxpvTIEaKDyW7YLrpHlMrt2S7EPppBlraiGMXFvbOaCPMFAs1xGRMvGhyF70b/CLHtNp0qFc07eGCr4rHZXAhowfo4pE7sOZ+lxRt
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?V526hSHLIbq1sTgvzaE7YRA7PAIupYfHovUWW+bQdBHyqPzXrYAfU1+lIK?=
 =?iso-8859-1?Q?z7QsRIDKeLvoqe1Cbp47a9ZQHxBB0nBtpPAgfoijRkN70jyROPgs85szIB?=
 =?iso-8859-1?Q?vz/ATlI/6MqulMqx+WHamL5D10gJIRV6iW0OLpzIpR7yA7SPnCSdKQN6Mc?=
 =?iso-8859-1?Q?kSEwO0KoK4z6o9VDfFn8Rvvz6b50SCuBLxiOaYTkoIcUs+ShAVi1nGQL0g?=
 =?iso-8859-1?Q?B4uIq8RZ151UpZtpymClRYiG3peNV5jIQCknapNUY+2ZCpOhzDeojPQVZ2?=
 =?iso-8859-1?Q?mCVCnEctujnMbYJrQ6Xt5iLHlG7xG19yahmliZYOLrozoN6TbTLhheiVBr?=
 =?iso-8859-1?Q?poPe4u3Dw8ZSxpNaXXE1TzuZpJr5kHlhB4CfsRyh5iR/t8NMrTRABFVrWo?=
 =?iso-8859-1?Q?bgvH9vdctlicUyagnNndjOd+TLBEB/b3NeAxewLoVCT+P7JrMUQRg+o5Fc?=
 =?iso-8859-1?Q?X07Mz0b0GiTjSvULq98uPK9ZQRSssXFNMv2VIErkpiTieVH/BxDBlyUbG2?=
 =?iso-8859-1?Q?RFyj0alQap7aDAXYcUvt7cXRDllDj23VvG/2ubCJJe1IfnwO1kUmECISgj?=
 =?iso-8859-1?Q?S9IjmwSlvDiJB/gUYgHnIDVR2a8irWS0qBl9/bOMfIh1HkQWyd86PpYQhT?=
 =?iso-8859-1?Q?gVCW154Yrsu7rWn1taIwmMgsT6W5dHp462c3sBeGMZ7MzGzfzaeXwTEtVO?=
 =?iso-8859-1?Q?9a40/3DCndZtC6UDenkLRRJ0opACGbiU5s362fjv300lme1b7IgO55Evhj?=
 =?iso-8859-1?Q?KGfFV46pw2aTDcZ+DPfGKlUj1t3AA/U29laQQWtrRvLA4RY+VtUysbDT0Y?=
 =?iso-8859-1?Q?EsZ/KDNmZxq25KOiB2PHYgWjgbyIcqbC/+8RWHghW9XZbCorqLtvxnvsu4?=
 =?iso-8859-1?Q?p6PQEihdUNlEkwmjRDkMpVwlbNV4FRWQr78rn4+YRVO92ifBUj8xXtDiCN?=
 =?iso-8859-1?Q?URfT52TQ/jD/cAKDycBiBHQMtQWehOL2zIS0v5P9uytp2jIxMnsoTl4LMC?=
 =?iso-8859-1?Q?+d4w516WOIRXEPMPZN/qoCGAvInmHoEnSU7ZSnckBaeHh7eqgPOeZjW0DQ?=
 =?iso-8859-1?Q?N9h5MD+H+R4mOSrh4rKoVP3CsEh1pP9itxJriHNACgf8TVYZbFsej5iW34?=
 =?iso-8859-1?Q?uXUKo6p2s/IEJK0SVKzL1np3lv99JKLN1hH5To8JBIbYBg4jO4u3mTaeIZ?=
 =?iso-8859-1?Q?bnt5E9/HAtl+jqsfp3kptHpSrVyA2CqSvqygGDoXfC89jCR8uJCddBFde4?=
 =?iso-8859-1?Q?gjQJIe+BLuGTElbIzJtvjTGJMU7EPjEW95nFL0tnCZVRmmngHdBmYrYCH2?=
 =?iso-8859-1?Q?LV5NmbHw+H4GX5GY6TEvUES1YZdRV4bv7YjCcmvYMuZGsV4X+NsfvCHGZR?=
 =?iso-8859-1?Q?gGqD0t1sWNrrPBdefBUcLMKP/9GkBIKKcAoMX5CfcQTUwd9zx7EaZUl6U/?=
 =?iso-8859-1?Q?tUEpWtYpqQnIdTjx1ufVzMPXjO5GGd82Ytc1PpdGgjnCzgrLGA/xN2ohiQ?=
 =?iso-8859-1?Q?w83QjzJaytKvJt3BBPRjftEjfAVVlZk/ekgYB45GFE++plgbj78NdvPKsY?=
 =?iso-8859-1?Q?G/17//n4tVWCOeHJ3+86uMA3WOucRpQgaJPPxlry1glLUKec6MHV4olzUs?=
 =?iso-8859-1?Q?wQk7AwCLbfVyLP7Y+h9Uia7HE0HNUJyakzf1z/I5Wkj+9gLjQKG6ZrbQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd43da57-6ee3-4209-f9b6-08da69f60eb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:51.3216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ff2jmcOCrlqVA/yg90uV7xnk4VseQC55RYVjGhpw9mDphFvKEI5IW8686x4LZ7K2j4ty7u3Az0rODfd84xjipw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: 81kq0FcgPzQozzO2dma99PhmWPGs9EA0
X-Proofpoint-GUID: 81kq0FcgPzQozzO2dma99PhmWPGs9EA0
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

Move find_vma_intersection() to mmap.c and change implementation to maple
tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.

Exported find_vma_intersection() for kvm module.

Link: https://lkml.kernel.org/r/20220504011345.662299-8-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-24-Liam.Howlett@orac=
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
 include/linux/mm.h | 22 ++++------------------
 mm/mmap.c          | 29 +++++++++++++++++++++++++++++
 mm/nommu.c         | 11 +++++++++++
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8207fbc6ed87..55b4b53895e8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2792,26 +2792,12 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
 struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+			unsigned long start_addr, unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index 33b408653201..636a984602ad 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2103,6 +2103,35 @@ get_unmapped_area(struct file *file, unsigned long a=
ddr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
+/**
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
+ *
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
+ */
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	/* Check the cache first. */
+	vma =3D vmacache_find(mm, start_addr);
+	if (likely(vma))
+		return vma;
+
+	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
+	if (vma)
+		vmacache_update(start_addr, vma);
+	return vma;
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /**
  * find_vma() - Find the VMA for a given address, or the next VMA.
  * @mm: The mm_struct to check
diff --git a/mm/nommu.c b/mm/nommu.c
index f2031f865dbb..b098c0251137 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -642,6 +642,17 @@ static void delete_vma(struct mm_struct *mm, struct vm=
_area_struct *vma)
 	vm_area_free(vma);
 }
=20
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /*
  * look up the first VMA in which addr resides, NULL if none
  * - should be called with mm->mmap_lock at least held readlocked
--=20
2.35.1
