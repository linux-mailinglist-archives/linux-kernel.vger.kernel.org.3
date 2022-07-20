Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AFB57ADBC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiGTCXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241133AbiGTCWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:22:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF146EEA0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0Kfc8017922;
        Wed, 20 Jul 2022 02:18:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gVKwu3mAF/BrzDydDYF3kwhOpwQY3z3J/rdlaKypkQE=;
 b=J16vrgFPZTnfRkgpl7xZltNFWXcGKjE5JNXyM6PEuqw+NbCkI/weZijelRO174ibIaAK
 kOE+WZPWJOadkKddvkp3TXOrVqcWHGqnLzbm9hM4iDHd5EBPJ9AfiJuUOIoDohEgRxYZ
 Usk7cANqvjE0Q/OlmWirJpSSOL8ZUUfzyn5eH7ZvwwWYTvorCAk/tLS3L05h0F6IKH9u
 FsnGH1db6HkOmM5ctSfU+qjjalcwwEsrnwbJoWAyV2HNUQulcclEdBevWtKhyCU6TrPX
 YTqEEa2GA1vDfxYgpFmVV3E36urEgFogHZSHq8+1nhLelWworDJQPoZdGuJhWsRLxFkz EA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:49 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K2AVgH009816;
        Wed, 20 Jul 2022 02:18:48 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1gh14ww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJWm0BZjES8tcUnDIUtYvB8Y6f5h0qqE9es9Dp0Ab4/uX4FtLKFP6uPDMob8Z0M20RDcBJmmj3qpgBm8yS0Suzlm2PLbOsnuTFy8+cvsppbsmUJAYHmDfs1zPRoYvOOPnZAtupchLnFejTG9FlbnrEmRkSjvBL1emZkRBoOBbZn2dA6JpSxzkPJqnPGrLzIKEy8KCUlTf9sj6rVM6Nt8x8oXNHvhSKjexHJOxUv/1Re08oLgHs0XUTAy3pFvEVnDfMmcTEAiT3ah3vBgYxXN4SdyGT9PzxYS3xtx6o6X9pX+rZWyk0uHdW0xS7FxMFktvhubN1rkC6obVvGPovVG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVKwu3mAF/BrzDydDYF3kwhOpwQY3z3J/rdlaKypkQE=;
 b=PpSXl41KnA25kiAlP5uGV3ixRSHpg824pfOhsg/RQEVjA9GfA4vn4qDCvids3tJqKAeIeCeaV/fihYs3JMLD+VLSnm6iP5shK7w9JoAc5wbcKBXsm0DLKbG5S23EzHKP5GxpGOEHf79aXT0tyJ9xq/AhXKRjRPzwydF8AIi7HJS3o0mSfipoX1gKTxQa23hT4Zdcfqj0j1qW3c+2pJ4ln/1vkpubiCZ67nsyfdduZwvenCc+f7Drj2ACMTwyEk+9oivQEkf/NctPI6jc4jLgZu+xQt36e8Ut4Cr7taRUhkDjiuTwPUGDbXRKyOfo1choaVfqWZCV2zhdt3BAT0Rgxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVKwu3mAF/BrzDydDYF3kwhOpwQY3z3J/rdlaKypkQE=;
 b=YUkIBDsgvbuGr1hgqsF1W/r1EwgsEpwZLi8vDX9hd25IrpkNQe8kh9DWHDDhBayJCBxrVUaW7K498z6A8npm4F8gzj24nP7A/l831cHgyCM2zT6UjUjvlND0qDO7SskvDbwhmoQslnV38PNxnDhYrc57JHY+7LGyHWuKYZaP6kA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 53/69] mm/ksm: use vma iterators instead of vma linked
 list
Thread-Topic: [PATCH v12 53/69] mm/ksm: use vma iterators instead of vma
 linked list
Thread-Index: AQHYm97vcQ295kkbHEeRQKdfpzBKdg==
Date:   Wed, 20 Jul 2022 02:18:00 +0000
Message-ID: <20220720021727.17018-54-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ea00044-6d14-42fa-29c1-08da69f629e7
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7G68acC+1jxnJ0PFmYSreQsNmEIYN0ZUZThCkqwjjbozgtzpokaCvBfSnonfIXsxBnFYklepw6ixQKmsiS4ltPR/FPPW0CjQmg6YkUlaQYVxRK6xxW9o5Q5Fyhwq2KGyS26tkF+SIoa0agzLw1YDM5XFFxk1z5g9Ma+iewVzR8Sdt1Nk7K5m/kg0mz2kvzUCx8UkX+eFhi5O5fJqHXnmEuUiN+y0R8Stqera+Rgcfh9qZ+TWl802sE1PHbw5zG05sS5jRr45/jr6i8lxmVIAumJwOQf+QND+EhUBEiudO5zatP29HbeFZw/W9myLZpWGtxxcLpro48dU9NwBZS/58IeCEtAs4VtjKynzWCXsZTKm4CmXb700g3YOe92y5g/XRTFCmIbzeU5LgoOEFHAJC5P/LPk2BlunkWYgl/r154bxCdMbVXatqLKNnB5MjYhu5g8EW+2mCU3Y26QQbrT8hTDhh+potp4acBPMVD5RSZnxLPUgzl/TACoxTvVZel0z194Xd+9OjmIsp5PXgcua6JGNuXRCeoVaELRLXTiLeaGyM2+PMuureJUrhn/nzihslnX+Vo+/Kl+6vkFXNy2mLWpYR6Sjh1wrIvyPbDmKifoEFcMtBU3Zw0Ohgb/WpPBl4JKFwp7BpLkQtlScHqjFfWbsiJJQtEDmZXWtf/wqSMUo2XEaHgLGVvd1F2hPXbwZkbxOcM2YYvY+65+mf4F1AhNJxdUA5fN7CLcZ3GM3T5TkqkzbVk2VcXGtjThMWVlFzw8uxLjUS0eYNUbPPKEwpxulZtzQ9lah4PxImj4R+C+HsG+jm6ha11vWYCr6P005vYyeMni0Hiate1DDWknfdPKGkV53Ba0bHI4mzZyWmhfVofqulSR8FNK7iALWykdi
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6hXpOHPVN8OorYfvOoqkFRW3fVF1Diz/Hkf8Brtuo22LeuG8K4qU87xilV?=
 =?iso-8859-1?Q?7IJk/Vct1WrbMNHuL/VVStFO+b+xBjGy3eSYkW78o3wo2r6DBNna/G2vnz?=
 =?iso-8859-1?Q?LlzvB8EvBSHAmVmjjO/ApWL24of9hOWP7dTY4K1b4jXLiktXzcxhYbl6jT?=
 =?iso-8859-1?Q?kDmTHKE1F5UTIm42ZXYMY+v9Cqz63zr/8kqU8JSdONekNlePvg5R6Cyiy1?=
 =?iso-8859-1?Q?ibPZda0EvJKZA3Fx/aNEYV6HuWt9vaYMwJ/0ux9WDGavVf8COEtAHsbD64?=
 =?iso-8859-1?Q?tosWVpxah+iMa2Qo5rY9Wn/8SImQA2VN0m6iDCLLW7IO/kYDGmv+tY0eFt?=
 =?iso-8859-1?Q?tOrFVFdVYhFb/t3fXy7oImEOhRm4jRNT2hmsxOfV+dUPJTN/2IvZrP227B?=
 =?iso-8859-1?Q?cPdM1uHmFSryl04PB57XEZjRAJ4SuLGU5CvwHOQb5bFRzpdfjH62DK6cPG?=
 =?iso-8859-1?Q?fsYYIzLSfzO1/ACxohPb5KWqXXZeNLWuf9j0nUabKdHx156ZEc0NxGyACi?=
 =?iso-8859-1?Q?LuR8IymszGnjF9ZtBpo+g1l7I2WhDK5AIg4wWxRKX5YsNI72ehdw3ZVvT9?=
 =?iso-8859-1?Q?QOtl1kJizWBzlEO8Ek1NdzRlveg8LgqnqA2h4tWwzvho9yhpVSz3d0iW0H?=
 =?iso-8859-1?Q?70MhezSZpEM/utRTo3Xyjtv2+RleG/SUPAPVTaMR2sS2hOXDOEKTcsSbD2?=
 =?iso-8859-1?Q?ole+5sqqWEVZ8La47HxE3kM1hNuA0VxKTtF80QSjtVS36pmV2Ft2+cPgE7?=
 =?iso-8859-1?Q?zOXRyiwbEAs+Y+ED1/i8GXN1lI3QV94jr91Sfolk8I95sAHZ2y8jK2jQ0I?=
 =?iso-8859-1?Q?eouhS/1rzkJ388mQotysU554xNYHvPN94zdQxMgbkmtfsUq24l9gHGSw6u?=
 =?iso-8859-1?Q?JO6lHRkzS1NPRXwRf5KEw3ojkj+8j2FKBv7P7TraJQaEX/+YfGpChf8uM5?=
 =?iso-8859-1?Q?Zvj4aD0eekjIkCwMBPpNPQoA4w9vxipQmryeYEuwtxyKrZXaoVlu0G0hzQ?=
 =?iso-8859-1?Q?TnIFhwB+6XC6aMUHzFQJsja35kxbgo1VPApuZkQ4TxI8n3b012aqrWaOFB?=
 =?iso-8859-1?Q?IeDKrNWOaSPVkuq5KN4J194vF+vyXSNwNt6vWgY62ekKNDhi6wwa2g0jTF?=
 =?iso-8859-1?Q?gIN1lO8LQG0r9JqojDloHxCQOVnxanefalawV5WVvEoONRUE11316UiSKI?=
 =?iso-8859-1?Q?kYkEgh9UzHRjSy0LUY3C4q4qLfrZ9kppWiJ1r6OIc/evyJaGNtU8xEwXMn?=
 =?iso-8859-1?Q?XsgIb9qyYlrY7BqalqumrVVIPvoCbHITbcB/er6uYrbyyB4aSDqG3aTLc1?=
 =?iso-8859-1?Q?jW6623IlQkYLpSd7umgYld3NeYDPckJfIIpcXH5VFanWBozvR08qVko1Ud?=
 =?iso-8859-1?Q?T0IsXBo7TyWU75Y//CvAtySahGHoh3L5/RD/qHJjocU8GHdKHpExdlLZvu?=
 =?iso-8859-1?Q?ibPIQwi7S4idxhDJ6MrXYARWivZLZEBXIg0XqENzl+Ucz3fMRIRo5MemLt?=
 =?iso-8859-1?Q?XkIoM59OPRk92DKTwgGewnX3HYeysqo/FAZeyopF84pqqXyQmKHj6rvEUQ?=
 =?iso-8859-1?Q?nJo9zmKeuQ4/H7NvEsUP05j1LAVE5nDM1elrzmypF9hQ9Cc0vJjk2qtOUu?=
 =?iso-8859-1?Q?jj7zICBhDUoDFuOXnSRjaBP5ADX32TneVcDYBXtO8iuPeDlcilyOcsIQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea00044-6d14-42fa-29c1-08da69f629e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:00.5082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7GOvam8SulYhPZHmNj0VLPeWPnR+52LDZVYMjNt10dBnW2Ykg4oHn/EEblptZWibbZYI4hw4T6I1xBs1dKERSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: HhDMPMZKCGwTWUpSh3yDglqOCZAFGRgf
X-Proofpoint-ORIG-GUID: HhDMPMZKCGwTWUpSh3yDglqOCZAFGRgf
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

Remove the use of the linked list for eventual removal.

Link: https://lkml.kernel.org/r/20220504011345.662299-38-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-54-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 54f78c9eecae..4e3d794f6b09 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -981,11 +981,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2232,6 +2234,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2290,13 +2293,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2334,6 +2337,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.35.1
