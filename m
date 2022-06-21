Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36374553C31
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354855AbiFUUy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354610AbiFUUvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:51:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530942FE54
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ29q2004726;
        Tue, 21 Jun 2022 20:47:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=BzQ1A3niV148/8mjhkNKU+zXAywBC/GdDwVUKc+XAio=;
 b=XdWkfgfbdIMYAAi7/8Z5rxRmwebvhiAzoliGPHFxRiqEGztg5hJIAm/T5RgdOB6mJLC5
 /v6sNaLbju6hj8L7B24SgWXBLIgbGSwA3M0i+cLXsv0XwE9gBG9ALZY3wQ30Q295apPP
 rXEt+BiUQdUsXuF7vVCkoChQSNb9tyoOkS3okEqeN6EBWzwoDCV+x8XbCFuFOatSjnzc
 H/qd8eRCMWHq9b2P7TqU/INt14pZ4vGX7RCqZl0KXAXiLCOKbwB3hNycqWqzewjPNEZK
 /74Jphxe9DNqn55m+TTePklB2jzTXvoQrM/cTHfxjWWU1kgadEfk11E8khXWiJGR4eRi FA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUgq027828;
        Tue, 21 Jun 2022 20:47:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp36-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipjHb7djJWab4u80LTFYBHemn07gQriToT5saiZ48tTgtV4VaxGEsDt7yoExG4TbmTBZxD4guC9pZhJKPjuzF9/yrihGThnanbzdjPBLCZ64QJZ/hFBprK8kDCNy2IuvRVpmCN72KF2xIeqDiecq/kAY9qJG+iLUQDi/2X8GfHIwozahBMDCb1bFzGFqUKQ55Kevfts+kn+C8nlJFECjFMci09sjn9OHkaaKacpwXfJ93eVCAera3zJGgADhmJZhTUb4Ed/WKTulZkhBQVcBGRzuZYQWRdBqqMAsjqcuFA7sMbVg6P9ilaNPvyFOvk0GcDSJcL9PTN4cL8QC0IAigw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzQ1A3niV148/8mjhkNKU+zXAywBC/GdDwVUKc+XAio=;
 b=bC9VMNRMzsa/D20UCzUPE4vZUcjvBggjZHvzem+O8xlw/o4acEgw+pJGVuTABKRVsLsA22vhgtpzZtFfUUTJ0W+9cJ8n7IeT0cW/BKPR0kYXZ0NM8g8I4rVMqyrCqXYDh8zGRQ/VfWzFeaSY7yN3XNamjVY4yCaCg9TWd3F9fIlffAnHqNCTv0iEFcjiNa8+tFi+yvgRkYKYGFJpFtZGng52bwyjgrQvJExcZ0VZtuk/eJ792BZA8vmuf3NZi4qH/hBk3LPQXkHNFrbDw0XH1pDuPAv7nhe7OsoKCadC/T8RHjOuxZFmrNiEN/Dvk+Sqf//+cW4FUokYdPxHWf/New==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzQ1A3niV148/8mjhkNKU+zXAywBC/GdDwVUKc+XAio=;
 b=Jn/rKPViKcJWFhXzPdolMh6OhP/x9M1TGbnc9bDdpKrgipv5+xgfUtU1E+Sx97bGTWL0QploKMCc0K+3BwCDgWbVwJvJNwCk+2ALKyJhHpd35oViZzIv14nbObyDUeVWqMX44VJuugDrb+KHR+onLW2lwdZw0RpJQO+H5MEKzV0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:10 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:10 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 24/69] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v10 24/69] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYhbAN+Sl6mjnOcEGnOIZ/LXvzQA==
Date:   Tue, 21 Jun 2022 20:46:59 +0000
Message-ID: <20220621204632.3370049-25-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 364f19d0-2e6a-4de4-c3a8-08da53c736a7
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30852C053FBD05E07CFE35FDFDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l7tdq0aOj5lazU9xmaPWIH4LK3SaIvH1OB+v2tUyYWBoB68DbXzVml0lnlJMHULXh4BROXmyL1ytmIBiJQf/IfRqy2JU102lNs91cP6FK+7WTp3N+ApZsZ1KH9GfZewlRU1bfU+nQd+3vEeetNE1ULi1wQNLoIWsRN6igv41xHH4mhLO4z6imBuPmQal5CN89NPh1y36K+UxdiGxIHIIKrJOYMI/t4MvOd3RZZRbevG3jTbg4YGNUmVnTLpcBINqUKvCVhd/1TqnVCa9JObyaChagCclHJWX20hfCp7ZZ4Q6BA97IF46bG3IQNuyViai7s/THZxnM+NwbQ+omwKLfaRBcPsKfeEIZOcqDTTNPx2nW0OFbmjEVOoe7YoZqT4KyklWL1tNziTLQZGp8jL3JGU29MAEgRSkHqyMLKtKOukHEB+k/5zOnGJjyqyPXmxaLUo8PcQiBTgRqh5vh0KTWg+WPoWYMtMEMwE6f0ofR2S3Uf50FMTPmR3IqlHBfth2PcCevygEe7hCzVOGukq3W6knCmfcWQ25GDsNf1A2Huo5AdWMZIo7YT2I2JP9LTSSvWm5WirMzc4lZOXQMG3XoIeQkcqv4rU/vp6av3EGvj6BrMnFZsJUybWFk1GHdjVpoLjR5Puqgx14YeiJvmXoOnNu6+xR0ooXX51q7aySXSWeGvOoCJDNp1JhjG55AxIQsLf5KOO2/oQi+xbmuxfHn5RU1TRJEjEO7IOLC4suVZlfdgBy+RYk0jR/RFxVLLmBPPINS7mkYRstI4OQRSOKB5ai0nqceumrRDldETG96TQWC7LzckikVH3REDs1tNaad7NrdmLGui7TshQ/nbIaQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(30864003)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sm5umozM6aO56AN6mpSrmnGwqiK8JmEAJsR84mXPu4j3cLMBPW9p7AMdp/?=
 =?iso-8859-1?Q?37hGl+1i96lGYQlRYAtDwAk6JHS8/PfwMJw2nHlfIkKMiYkZ6wRYGCuXHo?=
 =?iso-8859-1?Q?ACqJAWmhVL2/RPUQjiSylmE+yVeonwgDojsXYjOD+KommnXWyOKPUVtias?=
 =?iso-8859-1?Q?9s5ZJpPAqWv3SdE3fDfv11pMOtD3zbAgJwt06g4N02jQS19sQhPZ8AgzPs?=
 =?iso-8859-1?Q?6M2eAcwmmAtkRKvE+R+Jk3pIauorX54WPAoa8PQpSQ4kz3eBJmPBhp9x3M?=
 =?iso-8859-1?Q?p9r6YFHouiOcUGcxudu+RxoG/IXgmd44ymVlAwKgIyGFCQkLMP6klhFPr5?=
 =?iso-8859-1?Q?Ru/hNl5CoD0IhmB1+erMs7Ea1hBbTBMsoe1mIk9r/yzrQCfumk2LjeVLPq?=
 =?iso-8859-1?Q?g/SJmo/pM68kkZaIfrtEgWxnjkK4rPUE+4WE3KRaoiaOO3o9zMTMbBWTLY?=
 =?iso-8859-1?Q?bytHdHIXrPHz4Ezxx56m95lfuplMpK8EjuTfIbGhNDPPwhtp9Utt3fZ6Ng?=
 =?iso-8859-1?Q?VTi4+XOTJxRYHaBemnPEeFasIExstLwdkdm43OqT7BNZbfbpkhEfew+/pG?=
 =?iso-8859-1?Q?oVtRmLbETJOwHslFR6YGpen2EqK2G6+l/FIWa5eVfUDovA16sBblUhiJEO?=
 =?iso-8859-1?Q?OUQ6z/j9fY4x03MJN/x4ZckeCGHS+MwEWKOCk+ug4137xotrL374fyr7J5?=
 =?iso-8859-1?Q?iFsJdA3aGgrbNYZScwdrCLBKAwJxZEZLR5HhQdv6SPFfApmQxnUMwXfEBh?=
 =?iso-8859-1?Q?WGt68fu7L8zgTXaVlyP5eKyCztC6v/LYEj23MVRvcJBHGAYXzQSw6qLQ5m?=
 =?iso-8859-1?Q?J/GWhgR/a0IbOMyc+iSlxWCtEoF+b2aFzTn7NZoRmgHnoNs/lEM5jM2p32?=
 =?iso-8859-1?Q?bBLsNOLjVXHxOegrnE8M+pcmA/pzs3WYYpdzcGpRFcaaY2Io0GGKmqukLE?=
 =?iso-8859-1?Q?+UoNIGg41l0bhJqfER9UpCmrxxw1OpBBuSUkQ/E7XXQf/K51JlHdRXwZJO?=
 =?iso-8859-1?Q?gW+ByU+u55dwnXaHxnFQbXr8ftqUCf6rQ1SJGs+O8hXgWiPhxv+9O4wbWm?=
 =?iso-8859-1?Q?Yb/z+UgNVvACRWlZx6xJ/eDv+W8W8vHKRdwgtloORZe4UdWMDeSs/fVkoh?=
 =?iso-8859-1?Q?8Df4ut0MtaJMc7RRlu1ne8n1LUrKzwU+oMSRIJ+mt8lrmUajmN2DSvE9GJ?=
 =?iso-8859-1?Q?GXACIQ/+phfO8iIzsZOl2ikZfBDR2/G5sb8CcW62X69V6+btV9jzgKNmlN?=
 =?iso-8859-1?Q?l2N9VvR4JtwS1Eltb6eOLCLU1g91O8nLur0SyXr6y517xFHpZrATlTFpaJ?=
 =?iso-8859-1?Q?OCKM+sV3qLcNcFQpjf/3sbLUCz7aFFYRRTHlYF/oYy6SQAM7qV0HgF0Jgo?=
 =?iso-8859-1?Q?+abwewzh5eorwpQr6EIvM0CBxP+PoxGxh06osH9sR/X+HWbSNPaglq30/k?=
 =?iso-8859-1?Q?vvFfOerb8lTH/oHZpcF3eEyk8Whi3J8IA7ZhxQybO0kjSaKO+QNbE54oHc?=
 =?iso-8859-1?Q?OTR/brUD14aLkCPSRrwWnW2LOJHahD1Op4s4brmOkAYK80WRrIFkDIE2Fr?=
 =?iso-8859-1?Q?9PME//6iUtn9EpvYpVLCa4FT7VKDawNBDkEU3iB3Kpb96vC6ZIYwLIQDa3?=
 =?iso-8859-1?Q?JUpWhVMYmtbibLPpsCf/ShMdGeua0R89aBgQYstzj5tWEyGYutxjMWBjzf?=
 =?iso-8859-1?Q?FOOlOG1HoFcdez3d94i3tF69y5i/cj/MuiTjCY67K/Sij2bKpV88SObw8E?=
 =?iso-8859-1?Q?JL7qz4t7Pw3sbFesLfqTFfouR6nCqVyu10Z1mFIgFydB8tvTErB6324agK?=
 =?iso-8859-1?Q?9o0mSvwVmCT9rR69aGN/i+YA1epuDdk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364f19d0-2e6a-4de4-c3a8-08da53c736a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:59.0509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7o2daqBcgS8+xfmyIfw3Xo4KMy73/4xMXHIUUdIyeWp6/8evS7ou7Ait8/Q5vhKKBshwnn2z30QniI+TD0WOXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: FYJybcgbce8Y6aAr3Ubx4wjq7EyO_u0p
X-Proofpoint-ORIG-GUID: FYJybcgbce8Y6aAr3Ubx4wjq7EyO_u0p
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

Changing mmap_region() to use the maple tree state and the advanced maple
tree interface allows for a lot less tree walking.

This change removes the last caller of munmap_vma_range(), so drop this
unused function.

Add vma_expand() to expand a VMA if possible by doing the necessary
hugepage check, uprobe_munmap of files, dcache flush, modifications then
undoing the detaches, etc.

Link: https://lkml.kernel.org/r/20220504011345.662299-9-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220519020341.rr3s6b4dr7o36cqb@revolver
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
 mm/mmap.c | 252 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 204 insertions(+), 48 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9afe51a7db6c..d6549a74e73e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -516,28 +516,6 @@ static inline struct vm_area_struct *__vma_next(struct=
 mm_struct *mm,
 	return vma->vm_next;
 }
=20
-/*
- * munmap_vma_range() - munmap VMAs that overlap a range.
- * @mm: The mm struct
- * @start: The start of the range.
- * @len: The length of the range.
- * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- *
- * Find all the vm_area_struct that overlap from @start to
- * @end and munmap them.  Set @pprev to the previous vm_area_struct.
- *
- * Returns: -ENOMEM on munmap failure or 0 on success.
- */
-static inline int
-munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct list_head *uf)
-{
-	while (range_has_overlap(mm, start, start + len, pprev))
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	return 0;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -664,6 +642,130 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct ma_state *mas,
 	mm->map_count++;
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @mas: The maple state
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
+ * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
+ * Checking if the @vma can expand and merge with @next needs to be handle=
d by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct address_space *mapping =3D NULL;
+	struct rb_root_cached *root =3D NULL;
+	struct anon_vma *anon_vma =3D vma->anon_vma;
+	struct file *file =3D vma->vm_file;
+	bool remove_next =3D false;
+	bool anon_cloned =3D false;
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			vma->anon_vma =3D next->anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+			anon_cloned =3D true;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_BUG_ON(next && !remove_next && next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	}
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_mas_store(vma, mas);
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* Expanding over the next vma */
+	if (remove_next) {
+		/* Remove from mm linked list - also updates highest_vm_end */
+		__vma_unlink_list(mm, next);
+
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+
+	} else if (!next) {
+		mm->highest_vm_end =3D vm_end_gap(vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+
+	if (remove_next) {
+		if (file) {
+			uprobe_munmap(next, next->vm_start, next->vm_end);
+			fput(file);
+		}
+		if (next->anon_vma)
+			anon_vma_merge(vma, next);
+		mm->map_count--;
+		mpol_put(vma_policy(next));
+		vm_area_free(next);
+	}
+
+	validate_mm(mm);
+	return 0;
+
+nomem:
+	if (anon_cloned)
+		unlink_anon_vmas(vma);
+	return -ENOMEM;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1665,9 +1767,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *next, *prev, *merge;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1677,16 +1785,17 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, addr + len);
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
 		return -ENOMEM;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -1697,14 +1806,43 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma =3D vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX , NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma(vma, vm_flags);
+		goto expanded;
+	}
=20
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1717,7 +1855,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1738,28 +1876,32 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
 		addr =3D vma->vm_start;
+		mas_reset(&mas);
=20
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
+		/*
+		 * If vm_flags changed after call_mmap(), we should try merge
+		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
 			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
 				vma =3D merge;
 				/* Update vm_flags to pick up the change. */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1783,7 +1925,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev)) {
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -1791,6 +1933,22 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 			goto free_vma;
 	}
=20
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
 	/*
 	 * vma_merge() calls khugepaged_enter_vma() either, the below
 	 * call covers the non-merge case.
@@ -1802,7 +1960,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -1829,6 +1987,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1845,6 +2004,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm(mm);
 	return error;
 }
=20
@@ -2661,10 +2821,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	prev =3D vma->vm_prev;
 	/* we have start < vma->vm_end  */
=20
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >=3D end)
-		return 0;
-
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
--=20
2.35.1
