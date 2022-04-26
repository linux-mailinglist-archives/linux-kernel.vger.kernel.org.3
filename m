Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97FA510171
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351962AbiDZPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352057AbiDZPK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9341115978C
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:19 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT4aY025790;
        Tue, 26 Apr 2022 15:06:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HwAGCtpbwgLGsu1rCnMMsCQ2nMj2Dmh7jGriP+5uWhY=;
 b=Ob/8Gjzz/yvjMRVS3LsE+V2w9gkY0OkcBK15KITf1XDqx8aCf1+Adm+PsOfSflASAMHl
 OUCwSmS3Zg7sfZf+O9T453F4R/IE4LoyprZG5t+rAcAloWIHO1V89RZ1/sx7eO8XKJ+8
 nj+P5u1kUTIAvsIKMZRuQRjB3BZQN3PxUzlKSiuRTEUWfdKHB9euYs2NNZ0GA0nPOROY
 EbI5pPRs90yXFKauq2NmFxLCfJb+ATaHH6mzmOjGEzgBObW8/+0RLMn97v+i1z9z7+Rz
 yiAzO4icMSIvjaLobw8Mq70EyAJpEw+X7KaFZqZG1W652RsWVezap0yzO1lUcusUyTnA Lg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb1mpdcc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:41 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF6UNt037819;
        Tue, 26 Apr 2022 15:06:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fp5yjktqn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3t6wH0TspHDeUiCJScm7hn2Nd0UKmvC+hqAgawwrpAKni59eyHgOEluVTq3rGvrJjn56Bi29HQQb00RDVRbeq7zz4HGMLBUkT6o4LRp4mYivrJ0xcXmA0DKMSVoJ7Yrjf4c+4+bcIX0GJWf4f2JOtEJ/rbNNuZwDpfVH2HOPysb02gSSTxG+cb6n/xmv2JMzl6K/UF24kC2R/nagAMDRg2yjBSvFd4hW4oyEKcW1DrjD+O8J5X2lO94dxU2ZHi7OMBpD32pnbSDtxjQvW+k5c1VF/V539tDWQJNuGeSmF9pfHcpOrrTuU4UKIDuirPvOArtqhcxXL4cqdxbvEpRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwAGCtpbwgLGsu1rCnMMsCQ2nMj2Dmh7jGriP+5uWhY=;
 b=cBwjWRqv20nmViVp2ohwG2c57qHVy21l4uYK0PwxQSLkxVKJcHirZZJSTNIgQ/Kv6v9CaeUFFbAzt925G2z/i3lPc9cGoYvjNjLmT98GzDQl/scfjdj7GieI+++BD9eA3vyE7506LHpA2ffbUl/JQ55XR0D/y/90ZUB+KT+8zcSqQfeP5FpiViLzCMlvazYe7UhHlbc9nSTApgyBzDnhZdUp8Rt1Qjbe0L97YYuldfMiuTD6K0hERAqLQSV3p0GerHk3XOSpg7gMeDxpZGc3J1WegDl50hrj7WfNzNv8JEeShEAK6y6xWuUgnS4KSegmlSTmVdDe/RAKnhY6wLoWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwAGCtpbwgLGsu1rCnMMsCQ2nMj2Dmh7jGriP+5uWhY=;
 b=ZU9/w+ROrIn3Dwx3wIlgVM/F3qXe/Zf+e24TocpQqEyQ7fyCpD7cKZi+DKXLjKbCrrfn5LfsVAq3HHrnckXCV7nUHXNZM3w7Ef3Mw1ArK39GpRyuaDIVtmYyvFAIxYsE+fqSbRvzYEHqQ6xeqsJpYRLXihLQ3EqXVxmBTmo44gE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4679.namprd10.prod.outlook.com (2603:10b6:510:3c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 15:06:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 25/70] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v8 25/70] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYWX85FN9pJkEu4E25/Rd/2oQ9Mg==
Date:   Tue, 26 Apr 2022 15:06:36 +0000
Message-ID: <20220426150616.3937571-26-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 275a0f7c-4e21-4fc7-00d3-08da27965c20
x-ms-traffictypediagnostic: PH0PR10MB4679:EE_
x-microsoft-antispam-prvs: <PH0PR10MB4679881EE59799AF0A2E5538FDFB9@PH0PR10MB4679.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P/aF3/0IodGZhCIxZ7kymDRSst0vWGalUdUIJzzUW4zy/n7uKDBbQ3DttcvFaTTLnePb/BGzZXz5CGbT3XyMxOYje2TvV72VoU1j+EgGmYQgQXRm/pL80QcleFS6S4pipwwVu6OR6Wb/3usJ31sgfI5uMs5SZUKrwPLJworaPhF26AqOLepGRBgFP/G7vNxEikRbu1hesxDPL/uIHwVUcZIOFTE1+P0lahDMiTzZ3eEJvFATwzG7jPNtHNv+3NIIbMWXDxxBaooWnCSZGxP0xfDNwItRFA2eG+GTXfhhy2ilJlmhPFi/bQTb45kEEov1JToL8upq3N2MvxA5/NwsaxNJd8tjY+VzF9V7wAB68atkmMqrzu7BldFTUdNJAjtR5hMImiyVthcDoEptvgtS6Oa25yod0lBArf80Svqk6k2fwEdCY+ilX9H64C4SA+J6vujoM4HZ1Z5ZjOpINP5TLdnPLL70fWkfyuAUc4l4vK7Dkgxa6AlrVg4Z34QDQmp0iZS8XGC7g9VnIUqBZhtCBtUXhAUiVvDlerBUhh8scl/cpKob2v2+6QIojLBo+jgXIKukXwqJsDvXXfGf5GIdAm1y3KYMdvxgFnLYbzsZIYRTqZEKRXsEf+g535QP+u+dPM13p/XpqgXQrcNNQ7U8d4Le37kertRm+sQqS6pLnIZ3YPh6xqOTq+ImfHVh4iln/mZqZtqQU13/IB37rOj6fA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(5660300002)(66476007)(38070700005)(316002)(2616005)(30864003)(122000001)(38100700002)(83380400001)(2906002)(66556008)(76116006)(66946007)(66446008)(64756008)(91956017)(8936002)(44832011)(6512007)(186003)(26005)(1076003)(71200400001)(110136005)(6506007)(6486002)(508600001)(36756003)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?sLCzdivVOH0yiv7XgJ24N8oODjH8Dlexj+t/JCyReyur5z75PUxqc9HgGG?=
 =?iso-8859-1?Q?MZhGz08kSrl0bHEOoErGNk1N6MHL0qPWtA6Pa7cM03w64q7akvsbQuSYfy?=
 =?iso-8859-1?Q?aqUkV7j4uPXOBrvdSonBoRG+7BIxR4eYEsi2U9ats+KYJj8T0cQ8W3nTCB?=
 =?iso-8859-1?Q?g52CfReuCYf1A5fNi5YcEMtX9c99ksRp5h/5DvlY7SWMjOXOaUg9o/c1oB?=
 =?iso-8859-1?Q?/kDf4TExAcTORbqEPkMmkGd26QqQddX0gDqKlMZrNqdLkSN8nDJcPhnT10?=
 =?iso-8859-1?Q?5XuikCYPar3QqNNFBDIAlglNh40k6uOIl41+3m1sa8BfrQlRNCDIwgdllm?=
 =?iso-8859-1?Q?o7X6ga+ujUHl5dvAgMcCO2BkKdf2f7zOWZsmOO/118DU9HYVcEjF/n1B60?=
 =?iso-8859-1?Q?WbXvFTZ5cl07i09HUrV4QFCgiA8Fa7tZYV6Raj5VTSX33uPDLM9O1JZBZ5?=
 =?iso-8859-1?Q?GIq1pP/DQsnbSigSm0xklBM+FPgTWji8djeYxabUztvW3/xkCVfDqAYTj8?=
 =?iso-8859-1?Q?YBodtmRWhrQIdrnCDWOUL7Px9EM0IIhsnX344vx01wEnZyc0vADyVIOBRv?=
 =?iso-8859-1?Q?dxUudo8JMV5TbA4nQIRjCebHyVAgZp3xH+mBIJFfWTzTH+hmtmXIa5Umxd?=
 =?iso-8859-1?Q?JHXv2lCQ/2I3i53Qn677zvxKaf5Vrtbabm1TDmL2CCAEwyn39cyqYkJymV?=
 =?iso-8859-1?Q?6Iw55+qamY2sfFR7gt4oFeLaQ7DdpOyjirj675j6Yxcs+WTJ5utUvW8txf?=
 =?iso-8859-1?Q?vqqA9gG4t61I4c15wO/Hv4YtEzkl8812s2DCALAH4Qes3qwrrm/9gzYAEp?=
 =?iso-8859-1?Q?nzbju+T13fuXpqQx0S1I31TviE99sWvbMJhT7zxoIGUePsVTAfkfatXnvh?=
 =?iso-8859-1?Q?LHIC0FxX27iF5mFbH8axpdjchzKAI1IuwoMHCo6rnuOZZCz6UaiziEl0gX?=
 =?iso-8859-1?Q?OznF5b+yaWAfhNtMQI4P3S7zKE/tqKSRPc8g5TRM762R6Qa2MWMwoI8pbG?=
 =?iso-8859-1?Q?V4kDtMt/WqBFyhZjlq9zqQS/d8G6UnAbiaDfH585i06fGunJkdeGn20Ihj?=
 =?iso-8859-1?Q?RujKAob7vuC9f45PdpJOVAcTjXB2KeAof/ENP7nrmOA2Irslr8LPyyWp+q?=
 =?iso-8859-1?Q?R1O6Fl+K9Qzeim6xeaqPQ2J2wxP46luIivacPumptN6GlEj/I/hdxbmtaN?=
 =?iso-8859-1?Q?COF3vF2oFEbP1dXHD4MXd/iCiumWWchdYS0OHhIXJ97o6WUP8/2uURSu5a?=
 =?iso-8859-1?Q?cilZvANsZp1dXHNTFmsps3H1r31okLbcFiJniaJ+e6EK2IpSH0XE28Xzk1?=
 =?iso-8859-1?Q?R+tPLsHjerqntt8DN9p2gX5aF6veDSOxVAYgMrmM+goKGoaTuwWAoEXVTO?=
 =?iso-8859-1?Q?8/B9MJTvWiBfnuapyV4ZxviuutGzl3gmgoS5rF43LguIdDCUH3rr1at/BH?=
 =?iso-8859-1?Q?zHQ1MRT5mtRG+ioHr2m4vVAYxFT0WqkaFRh02GfBfQPt8djNs+aZYwsRA3?=
 =?iso-8859-1?Q?NO3LxxmXGoJDtXOKzdRIiJTvTnSCWtoIIrPU1W9ZKNQ7reDHZxRwnpo/G7?=
 =?iso-8859-1?Q?DRE8kKN8KjDMZCw5SKqqKAPaNKt5TKNd8vKemV3E0dDSQBfiqdsyfPgCLB?=
 =?iso-8859-1?Q?HWTToeDBPPUkI9IkR544ImrnHFL1vJwxxtMxP9mMS0d9QhsRmiyhLjIrkW?=
 =?iso-8859-1?Q?uszsfLvpnEw1ryvffimqMOEOMZk/xT5CldTwNnQR8M9P0FdHf9DvLO0ZRZ?=
 =?iso-8859-1?Q?EeQd2KFWGcyeGxxyHAW73ngv9rd3O3KAbCDzkByDjIWYaV7F0qXKxzG0sF?=
 =?iso-8859-1?Q?bnYizC6REtkVQlbXmUrbbgUNbVcIEoc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 275a0f7c-4e21-4fc7-00d3-08da27965c20
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:36.4744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PrK8siBa9HLpKMYBAcuz5w3GF2OrX3m8irRMdrNOBR4bhi4Kgb5I2pLmFpa5adLC1AKIc6BAORmRRLCJtBBkgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4679
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: CS2FehUSQFNwap1RME7l6PkkK68mRLFm
X-Proofpoint-ORIG-GUID: CS2FehUSQFNwap1RME7l6PkkK68mRLFm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 245 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 198 insertions(+), 47 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 843fddce316f..2d7d9c26c57c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -519,28 +519,6 @@ static inline struct vm_area_struct *__vma_next(struct=
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
@@ -649,6 +627,127 @@ static void __insert_vm_struct(struct mm_struct *mm, =
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
+	VM_BUG_ON(!remove_next && next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	} else if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
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
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
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
@@ -1649,9 +1748,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *prev, *next;
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
@@ -1661,16 +1766,17 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1681,14 +1787,43 @@ unsigned long mmap_region(struct file *file, unsign=
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
+		khugepaged_enter_vma_merge(vma, vm_flags);
+		goto expanded;
+	}
=20
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1701,7 +1836,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1722,28 +1857,30 @@ unsigned long mmap_region(struct file *file, unsign=
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
 		/* If vm_flags changed after call_mmap(), we should try merge vma again
 		 * as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
+			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (merge) {
+			if (next) {
 				/* ->mmap() can change vma->vm_file and fput the original file. So
 				 * fput the vma->vm_file here or we would add an extra fput for file
 				 * and cause general protection fault ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1767,7 +1904,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev)) {
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -1775,12 +1912,28 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
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
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -1807,6 +1960,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1823,6 +1977,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm(mm);
 	return error;
 }
=20
@@ -2610,10 +2765,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
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
