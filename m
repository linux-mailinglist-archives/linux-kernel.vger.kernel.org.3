Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB62257ADB4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241672AbiGTCYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241684AbiGTCXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45FC1709A3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K119oH017919;
        Wed, 20 Jul 2022 02:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QFFWvjBrVBfXldt27a+R8CiZyZq0yB0Cupd4KyZFQH8=;
 b=DsldPbbYFiHeA0VyAy3gHQICcgB6x5Ou02u9lMyyzVk/xH9NTzAlXjFU7p9UsJEfHNUR
 oaJLgwQRsuqGeJ3DIXJV/VrQNHswDTNRQ0IBB3kOYysmRlghM+IaYB/s117fn+8nZjbJ
 WtufmDswaJHzDmBWfCZehk7uBSkAYSDB01ga4Wyp3A9QuVnmjRb19wVbZ81BdANFMAVR
 kON1R75XJciuTRoS8Ffwli374TLJoi9GVcZBfvdP7ufunUFdjObp7SuesFDSK67Q/liR
 nf7MIJX//XNIiHIT4rhibXFZRFQwOv/1MzcSKiCiQfKdzb1dmowiA9m8F7hEkmFnMrsB tg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107v3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:22 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1x7aj007828;
        Wed, 20 Jul 2022 02:19:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3w3uu-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0Fe4gc9DoXrsxRuXcCmDD+87QjSSC6i44cd0776jJMRJxHY1yX9uMTBmzt5bV7YOG7Q1TlXH3Hyxo015Nbsnpmll0J2XM3QftzoFN74q0IGDf4rVLdo+rUNF+Z7riybNqyClYPtPgZ36y5a6tksVRE/8arVP2V2vAA799WJ5bDqMQtfWx5V18iYlI7rUJumzT68nlOcL7YwDGLy92I424kLh9qFMzpiAU6aiadptTzJcCHoDuZ5oDfOBFCJgV6LVM1/xYT5GAB/5HMOlveb/IX8AWgzK4pBHSQaQOQwvUujuBrhe+7+WejRk0HapDx/dJ8GVGzIes473ezj6T0D8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFFWvjBrVBfXldt27a+R8CiZyZq0yB0Cupd4KyZFQH8=;
 b=nTNbA+7WiHK/BAaVYtqXFXytqU05O/AwR5hPSQ/uIL2MYhgpJLiSv/SkUGQsbeMmLXOnfTjdeL4Lp7+gBlUMvI8T9gLEqNZFlMf09CygzqejTKu5ef9/jtEjUpKd7T/yAld3c/FR3rAVjY6w+x41Rq7TGx7vi+AVHGke0HqFBfje/lDvwBXA5wnMtfxIiJ37pyF0NdJOoYRnufeXlZs/MBtPnQDN9wN4Bu1RWBzfGAyTVjUzArcjwXklD+5m5nd9K9JxGLsis0D1SMoeb3Dj1SAIYf2HdC+EvY60azfFYCLUD9QX+EqLt0E6naWH6cn0caWDS0oe2sxy5DoVMPW2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFFWvjBrVBfXldt27a+R8CiZyZq0yB0Cupd4KyZFQH8=;
 b=VXvLo0yliW0qDCDHkkFOIHVpGwK8duvzHJxy+CTD48db1ulebJg+DJhCfs3S3I7slgzkpucNcMMn1CNlUAktm51hDkPtEDpMQIBFn27hSk7IYH9k0EyjDE180WL119bGFazGtEfcHT7I45/7HO5tR62HlY9UrmMXRKPDj9PD9rw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:19:18 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:18 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 65/69] nommu: remove uses of VMA linked list
Thread-Topic: [PATCH v12 65/69] nommu: remove uses of VMA linked list
Thread-Index: AQHYm97xn6jWqBizAkKk6+P9Vw0tfA==
Date:   Wed, 20 Jul 2022 02:18:03 +0000
Message-ID: <20220720021727.17018-66-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 849fb0e8-3700-4fa6-9493-08da69f63fdc
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7kqCB7Kl046soxUsATSNFwEJxDAiiJJXcB6g72n3AoU/fL5P+ftfAaXDpbfvL6HCxShWH2RZK9b7I4EzdAyfheZJQYVYZIRdmTTmVB2CZ1VpGd5yMks4ZL38U0DlxwHzfjX3hVrBEVPnc/Lqiw19v4lMxMMJXtbw0vWyF2lMcXgrv0//5hyBEQCefJjDYmrjspvA4+FiBnzIx0iYpgHLIebstnVB4oAb/HQhRbu2dBIkWrYzcncdutq9mnS9xAMKaUg2dGWyxU4Q9jqFM/2wp3qNGxop+m/eKRRSU6I6Z2dO6tPxTlE5wQo/NRjTJz0CAKd12m/PM03wcdxHeUIDkadSC7QngjNOvGkuauNyhtrRjNdT9+A0yEkFF2KftYmI2GoFdzQdzy3hOeOgoj+3ekO5Ed++AOcisrL7RzaKYRBk7+4f9CDsyRapn5HsTUoGyspeo5OZj829z4JsVjobiFwrmD19AYtGrdZxTkpL3f8+rEmvX1UUqUNVvkOwjmMr8lDmMsmEQ3u/MpA/RZPKX6AYYBotPiyErQz6pnSWFcPNwjFhnvYC7V+gbDRHAu4G5A1hHpBFmYPVy0LZzU6CcxSNUO6Wue/Gx93O3Fj2dsnqXepXJ1B0lKiv1GeRA751ZDClJbTzyRkpAC/GD3WEok0xNORa2YRlzlXx0z8D0qkv8kPngdoxLApF1xpMjFw8G1rvtbK141FtD2BU/sCyYyngcvnQIcBqd+EBuBux30dQaViDIL8+FjnTRfXlkuX8oiN5dtoz0uiq1TURtMzP3Dp6fDTj1K98hIOBXiuZwXqf9Ed6WjhdNMgNOo4pcm+56EDWGBVM4OtPs8uzBnvpb0c0pEMdw5K8B5S05MSoGCkGHqY4VW/LcmiUku/1o1Lb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+fjZ/B2MEyBj/anaLPtPeLJrvvQySgXAk0ti7+73t6Vvfm60Rf9zxd2v0g?=
 =?iso-8859-1?Q?9ESFMLfEe6SQLujUzOiVOsqYj0YnawddE7apgteMRvVB6K3ps9XJySEGIQ?=
 =?iso-8859-1?Q?M3E9Unnm8z8vngBMF3krUjJ9kb4i8Ybl4pvyMW4j9RLUb/ECr0CPmsF1RN?=
 =?iso-8859-1?Q?lN4l+hZTZUKUZhJjx666ViVtJV0dzitUU48lfoOUSSR5YQDp593Suq3uKp?=
 =?iso-8859-1?Q?3V7gsDJIZz727sEORT/9PQnIUuz0NonESmWr1VtrcrIg+eA91ZkoBFdq+N?=
 =?iso-8859-1?Q?lU3vovS23S+TzefijCiOJJXctZDecbUTSFU0jBX45bveh4roYJVmbPmaVj?=
 =?iso-8859-1?Q?qlbPv89pfWvStkkrBkSxZq9Ua9p3NV9qqUU6PdTtQ55mxKtRMN/4YfJa+O?=
 =?iso-8859-1?Q?AX8ZWI+VrQhaTNJHfualNMr2Co8vxKpfyRPyk9aEDFpfvL9HRf/6shwTTk?=
 =?iso-8859-1?Q?8XIW0px+I4t/LV2mPeEV/rKBKhN3RuU5tEF/7nwKvtwhPlLprIoi7b/oRW?=
 =?iso-8859-1?Q?72qre3XR+mc3qik2+7Y1ax9CdKe3/DLK5yejtklh3UVeRFiygEky+yHJAp?=
 =?iso-8859-1?Q?DehsxNp1e7ZxP7Uz56Q8UUOzFVCHbu2rttiQjDdW0Pi+bnklYe4BDXUKpZ?=
 =?iso-8859-1?Q?KkMQECF7gpLThFZMQn91dAv/s4ajDP0Zc+8Oq0Vyn+DtVICSlO696xa1Zk?=
 =?iso-8859-1?Q?lVJw+xXyKZTM5buQPHMnx5pQfSxGI0JXigHD7BWEz+nHV7tBw+LAax+f4g?=
 =?iso-8859-1?Q?aEGC3ZNOitecxCcgFqdof7tF5TzGXfWI9bEQ9M2K3/1Lhe01SATO4fZRJV?=
 =?iso-8859-1?Q?Klgm/X5TFjYpwcfbL2rNjF2pD+MsMNOj2vGi82iHzmQZbi86p2VgbdpKBE?=
 =?iso-8859-1?Q?a8EYpN8ZDu3ucITdtyIKIzxuRgKUoeMCbLwvG+Py2LQHjDws8BOH0S0VQV?=
 =?iso-8859-1?Q?kklR7fnBGTgKPdlbv37C7zyNNIDVdPUR9q65/+PG9hij03MSStO/jwOVeQ?=
 =?iso-8859-1?Q?HVMs8khyFjySVJD6ym+S3forWCDR4+XIXOlG1eOi6QWv3labWGAO/dlFLv?=
 =?iso-8859-1?Q?fBRNGbEIflRdebrvTfdTDKrPPigz8T3zKlLrbqZBFolpEs9TX4FlT/Ilyq?=
 =?iso-8859-1?Q?vU/BH/Cqy1D9jq0YMy1GGeS1Fb48QG6/12ivr4K75LBnEfDnOoB3IkwfEP?=
 =?iso-8859-1?Q?jmjHodD/zh85zqj3aQ+IECQMac0x0P4nlObsUhddq3WgeK8+YnXW1FA1cc?=
 =?iso-8859-1?Q?I9LYtPL8b6Z1mfmCoVJwMcktapf8Q48cvcm15yxTvkULzggP6t2eBbvVgM?=
 =?iso-8859-1?Q?sU0OGPuL4fO+sD/HThNPFnhHtvlnRM1XKAgM1dM2C4j3Ohno4vvPxdDywy?=
 =?iso-8859-1?Q?BJCHM1Nks72KPEcSSYWv5ltVLknQh179Qus9Yvii+43MX/3qj2ctv195oP?=
 =?iso-8859-1?Q?d2y53oDkQruD1EgBbL5L13q1ag0BeY2V77LhZtIbBA/uIr/TFN0p3ELEsj?=
 =?iso-8859-1?Q?KQ8zt7et7Q1SvPR0EevIVQC2+c1Fbuik32QYrCRgODQmMssKAEI/zMeCU7?=
 =?iso-8859-1?Q?mOex4f7vTVPYV3YzXyvh16eb77inLf1Z4ZfxhqqExt1XstIq9VjxTOtW2u?=
 =?iso-8859-1?Q?ElqwMK2u2yCoFpNlmgLxKkk/m1/MGA8qndK+JrXikBh30r8/8wViHK0g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 849fb0e8-3700-4fa6-9493-08da69f63fdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:03.7735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jw+vDCg39vqoh5/B/pZCk7JLQvtK7zuNowdsiX/LaOJINCt15j+OsdXpkg94EEPCUKFzXXHKK+qUJPbx0YgvMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: afTRGoiwUBs8NyA2_HFdToS9Y9es0qem
X-Proofpoint-ORIG-GUID: afTRGoiwUBs8NyA2_HFdToS9Y9es0qem
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

Use the maple tree or VMA iterator instead.  This is faster and will allow
us to shrink the VMA.

Link: https://lkml.kernel.org/r/20220504011345.662299-50-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-66-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/nommu.c | 135 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 34 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 4ae252a785dc..f6b187090d95 100644
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
@@ -1333,7 +1382,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
=20
-	delete_vma_from_mm(vma);
 	down_write(&nommu_region_sem);
 	delete_nommu_region(vma->vm_region);
 	if (new_below) {
@@ -1346,8 +1394,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	add_nommu_region(vma->vm_region);
 	add_nommu_region(new->vm_region);
 	up_write(&nommu_region_sem);
-	add_vma_to_mm(mm, vma);
-	add_vma_to_mm(mm, new);
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+
+	setup_vma_to_mm(vma, mm);
+	setup_vma_to_mm(new, mm);
+	mas_set_range(&mas, vma->vm_start, vma->vm_end - 1);
+	mas_store(&mas, vma);
+	vma_mas_store(new, &mas);
 	return 0;
 }
=20
@@ -1363,12 +1420,14 @@ static int shrink_vma(struct mm_struct *mm,
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
@@ -1396,9 +1455,10 @@ static int shrink_vma(struct mm_struct *mm,
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
@@ -1407,7 +1467,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1426,7 +1486,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1448,9 +1508,10 @@ int do_munmap(struct mm_struct *mm, unsigned long st=
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
@@ -1475,6 +1536,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1482,13 +1544,18 @@ void exit_mmap(struct mm_struct *mm)
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
