Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8318D5AF4CA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiIFTuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbiIFTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F064F110A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:22 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdNt5014161;
        Tue, 6 Sep 2022 19:49:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8Vm9MiEnLwOaBpOKSWQL/dPMQV/3pJcDIa3zeILpj6E=;
 b=bf79IXWn9Xn7zQ9baDn4gE/nMPeDAnzEoaWZbe6ofEj1FACZz897xa/xdjy7uPteo7AQ
 SN6YfEjNzJ1xoy+MhFg0LeMS47oL3HhbGA8QiZM/kyTjDESFibwh9soz3S0aA1v1bdV4
 2JZYWHA63JaZZmlnrpYCSifyGsM5QIjdBGL0+2Ps3in9iYvxTgP7P/JhoLVmEpi7aywJ
 4AcIwiqptwSjFvRGDJ6BM95KfWKbZTb1RtgjHIei3HhBAy1bfirCbHA/4uHtY51dkIDS
 gKz9uVYIEsA4vz5inuUcwkgMzRq83p143PcaXOLdU90T/GoNJiipb9H/j1/HuM+qdYV6 jg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eymj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wh027549;
        Tue, 6 Sep 2022 19:49:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/VDJ3vaUeQC8s2syRKW49uyVpJgmbO9boTbe8X+n8xKFLsO47IhMY+de9b9Z5YZK7/YukaPG7kirQkvWkHynzbedbDO0f8KoduiOx8TcYzJq9mNxbxRlyOQElsK+wM2KCbcB2Tbt8yeB2ysjqB9SNkeRh1k7gha2oXDXsr6w/lcLWMWYdcyDwTR8IXHwB32aMWICopC9hjLaEroCVWumZqLkNiNyqPfzerjwy9YIIl7D+1ZTTAJlWCR1hwfOeBiyx9K68nB+Up8khoG9mQmkDk+8+iEJFYG1HeQPyTdwLyMso8zzWQZwSJU8Jg29vX/4GFb7DQCD8KN+8I31CfS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Vm9MiEnLwOaBpOKSWQL/dPMQV/3pJcDIa3zeILpj6E=;
 b=idsZdqJ/JLLOrmTQ21ocSJ/UbmouMPNMTBMagdVIGy7mCPHWGqHCYCDxjts4MqwOxTs5UWIWRsOw5DTWq1pJYmz8wkxhDP1Or4Joy9mO3PYEfWJ7xhsBpZ+Q2tePTHAwYeTQ0S9TxJRqcKh+rsGYMPHpHGbK2n74KvQkUdE4rr6HcJRYElc0TeTUPJnOgxXxCPTJPRscnDcNcHM9SurHI+XXHZJP1npXjxVg18FKgemqJZsEyQK3A/v5rSrtO3b65RFkfxhrsAfCkkypQywU+2YBRqk/hRCu6FW/OtfONbgMhpwd7Uyb5vTIwkhMCyCP9mvUCL5kILlCF/bKRn66lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Vm9MiEnLwOaBpOKSWQL/dPMQV/3pJcDIa3zeILpj6E=;
 b=ts3yvVYTLfQDM/IxTtNo8Nk6/oqTW03M9FBK4yR2XwhD7W37kW5YMMy/RLsFnHgtufSmUPVJQcCNu8rdt+K2BMscYoReRNKXsWrZQuOCaNnex4pHf+lukNnyAK/o0comxjDnaHd3mMeQXSAgqhZtrvk4vF5enociWatrPdgJGhQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 24/70] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v14 24/70] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYwimwQomU0SRJH0m/VY+GxqQXPA==
Date:   Tue, 6 Sep 2022 19:48:51 +0000
Message-ID: <20220906194824.2110408-25-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99b049ef-176b-4a49-dda6-08da9040d748
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RuoD3oWTlLpPJkwo8PelTI1J1L300ibVI8XWw2wg9s5SlIyyxTZGVwD8RKFQwxR18NvfZKUpzV616fTbh5lEXgFcYFH8YwCgfe3VbPL3JD49k2KuXGsJveWxp64xo/ymJca6yungBFuQeT90RMCfQnQB71fYgPNivlT+wGOUp+pQ84jU1JQ9r+xMv34NXFKoTXYDJgCQ9R//FcE09RC44PPP/+HKaQGoOEfkuMo7+UVP26rrJwffAugLBvc/EGMHZjilC0MHkhyuf6shZNHHyZZQG90GB7q1DYM6lWVawEYffUSIgra4uZJXpS8oQFMq3XN2LXd9XvtuEzQdeZvN0aAGGptdlV4vBW6BGsYM5Uz15v2khn6Tmd/+5dBMUa9ycyTDjd2P/5NBiWpc5ASX7vSi3rwwYwkb3d7uZGoRdSadGbaQg04it1AtphUuymPPfYnhjUJU0U5wmDwBs0MmzCmX39PnHfbCooEWR5ecAG3vhjxe1JGY0DtggkAaSnZef84mcaVKhGHr9YJ2J4NsRIrRHwp6YExCi7DvUOnStgnPwYNc1tJXlPH0vbUbDekXBo01hOg32G80uFHfaSC/xR1qfznJSbfsKwuz6OGf27FZRzqJliCFvuNXSFNv8auUDdCGnTsPRVMQWw549LLofAn8qFuAkdTwlsiyvk5GGaEQvnrpCXz/hKmxBVLpBpScH1ll8S/3s2b16xJwCYzADFzuPPV4Xas9arfgtplNdiexi5jIOxq3mchDhLmo1RJ5ob0UL9YqB6slQifRFk1qEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(107886003)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(30864003)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YUwK92dWi9i/YO+CjVLUCh806tX39L3a9+fp1rcnIvH4DgTS6r87TmlfZ4?=
 =?iso-8859-1?Q?9s8dZgFCcexRddWxzGKNlRAKqTjSxJxeFvm8kR3a50LcCkisyGcBoCMmTh?=
 =?iso-8859-1?Q?oDUCI0GOstMmc8ZJZYJb6JiNC1SM2GvnBvu2tZYGZsvIXUQYgC1EbZ3ngn?=
 =?iso-8859-1?Q?rQRc3NE7a8b79tnkaiEH6OVSsTraNuaDd6AT2gscOlrkjbA42u9Cp+O1Xk?=
 =?iso-8859-1?Q?ObQKMFRiB24Q2FGrC20lza87cfroekIHlXz58vOHuM2ULIwlv2wPk4TbJT?=
 =?iso-8859-1?Q?zxlZT6QaCWFWCmEs/Wrm46CHQAFtvOV3V6XbapL5slSOuQBxGVr51VKJF7?=
 =?iso-8859-1?Q?mrPURScAy+pt+LSlYeDjpvzq8sqVMMlqyD/CLSRXF1pXyMD41V6WVdNKAq?=
 =?iso-8859-1?Q?2jwMuLTSVRvwFbGuIA37uUdlHlQoJzHLL9vIfi0A6l5qDbTiTuz36moUyR?=
 =?iso-8859-1?Q?cB788XoWSpqZMTqi6xX9JMmXwxm8PfgbK1yttJV1Ekxdz/QsaHAkZonL6G?=
 =?iso-8859-1?Q?Lqk0UNsGsJCy2Sf6WLxck7Kjp9sw8/y3F3QGvWxPCoX09gTJ05NP6uZT8x?=
 =?iso-8859-1?Q?b/ogBt4AqjKFty4qCWBZPKb+U7jjIvrlTn4WACzcHKc0dntZLgFfwukEuW?=
 =?iso-8859-1?Q?IKVOpmQVIBuQXoFYGyRtXH7AzWXIR4oTzvnCru6GkH6qULBxF034XnMX4W?=
 =?iso-8859-1?Q?IauZPJWR3OYird1ZkoF4X/X4hjh34nNf62OU/H5bmcZ9J+DAW9xB3rbMw0?=
 =?iso-8859-1?Q?W4cDIiJEYM9kxteGk5sCZJAaeyV2seM+ReuID50llSmT4Bqc/vP40HdX1t?=
 =?iso-8859-1?Q?+z8CvsJdClnOsOI88kBaougaApgWnEntQo6zcoozu4FbE1g/xJt2zzInp9?=
 =?iso-8859-1?Q?zn0UPbSn3iqpbSQTiI7RoQ2Wjb0/mR4elMUBbRC2ED/sQmaRioS1hXsjCw?=
 =?iso-8859-1?Q?l2P4p7aF98BUjoLx49PwyrXXB4+JHivBhu+KDCB+c6DwhriXPv/gniTfdF?=
 =?iso-8859-1?Q?Pz45XZ8Jt/FBtXe5rVEb+0H+Nsget9d3PpKNOYj04XiwQbqW80RB7OqQp4?=
 =?iso-8859-1?Q?Sa/1AT1oom+yZDxP1dhqBPzvED8tTI+gl+nAXIMnyPh96iy6SdzJ4/fzaA?=
 =?iso-8859-1?Q?qrVyHoDRq11VjtOPLN4SrAvgqD5ToSByFqdG2S1wrN3mo49SG2nCw27HIs?=
 =?iso-8859-1?Q?8kgayYFiwKnCRqBTW3P6uiBzqiFrnnAprlSICh7CPEEfucTMPB2J9Vd1cQ?=
 =?iso-8859-1?Q?5SaNa8xeG2FOM/v4LcFdXnmSsszZHBLRm97c1mHFl6d6vOTXgZls+gng2V?=
 =?iso-8859-1?Q?E562daQTMOMZ46Sd63b6Ckifhl40NxztcwHr0HeyenzcxycfUC2n6qqZJo?=
 =?iso-8859-1?Q?QFfDBnsG4PJWPRkPTrJeEFpz7xtgbOWFBoOEvt440v2F34mxkqgbWHkYRp?=
 =?iso-8859-1?Q?vJgpeUVRoiV3S5qfJzXxrkwYAZD29ZWPl1zVzUiqqSYS3haA9gjHuQe9kU?=
 =?iso-8859-1?Q?1jOUBIoC0H2UV5lw49rTSNKRwKorIWVRnXU1SD5b/vgJjXk/N15BHnue6w?=
 =?iso-8859-1?Q?mHWK8yEQ7M5+Uq5cO20v6BLbVRmaXlkzAXzHpsqKE6ylZSq0Ur7hzQIdFA?=
 =?iso-8859-1?Q?SqLz6I/dFMiSZOdlBen+6RJ/0I/0VJ90qoMDQQO8Zt96qKYFy8H3FI8w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b049ef-176b-4a49-dda6-08da9040d748
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:51.1941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52PGfa/wmh3od9Y2ekWrlBkC0y41uUiusUEl5XxxaIFxlCqnxF9ndJTsi0MUM4jE9czPiIeUm5nf/G3JP2erkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: P8_Wt6DQEeULAgcUSTzFv9AXUE6JgaR2
X-Proofpoint-ORIG-GUID: P8_Wt6DQEeULAgcUSTzFv9AXUE6JgaR2
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

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 251 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 203 insertions(+), 48 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 699af34c3573..7a1adc916957 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -470,28 +470,6 @@ static inline struct vm_area_struct *__vma_next(struct=
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
@@ -618,6 +596,129 @@ static void __insert_vm_struct(struct mm_struct *mm, =
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
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			anon_vma =3D next->anon_vma;
+			vma->anon_vma =3D anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
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
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+	}
+
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	if (file) {
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
+	return -ENOMEM;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1630,9 +1731,15 @@ unsigned long mmap_region(struct file *file, unsigne=
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
@@ -1642,16 +1749,17 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1662,14 +1770,43 @@ unsigned long mmap_region(struct file *file, unsign=
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
+				       NULL_VM_UFFD_CTX, NULL))) {
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
@@ -1682,7 +1819,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1703,28 +1840,32 @@ unsigned long mmap_region(struct file *file, unsign=
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
@@ -1748,7 +1889,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev)) {
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -1756,6 +1897,22 @@ unsigned long mmap_region(struct file *file, unsigne=
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
@@ -1767,7 +1924,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -1794,6 +1951,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1809,6 +1967,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm(mm);
 	return error;
 }
=20
@@ -2632,10 +2791,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
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
