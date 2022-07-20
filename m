Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C1457ADB1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240936AbiGTCVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbiGTCVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7DE48CB4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1FaEI015096;
        Wed, 20 Jul 2022 02:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oO56keZ1Mx8xMory8Av9vRhd5+/xnxyR+fmrkM7W8S0=;
 b=uQGBNVrIaNp6krNyJdO5PLcZwCh+y8aDkZVbnKWegtHBwnhReXeBGNOWdEcIMApgioHD
 lmdWxXZDdFQ1caOYi8ABIDuv8RsF/BYyD6aowUbuxkScxdG3mQIyef2RISs4Jxpxb9Z1
 eZ6YX1WGvAU7NFShTJSk0CbKZOY+jII6f0L2y2+QIdJ9GDwxkhhuok8tunUEZ6nFKhQv
 891umCoseqWYvNy/IFhmFqpxWFNCZex5fBC4ZORpEEOG9WkmuDnw0A8H78bWpyP9T4R3
 oUjFKyokf5F00jKVOAZ+y93L0Qca6GBWxib9lMWPyyjb3z+kERB8OojOdguR7YT+U0zW Dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42g54f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:31 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAlb002689;
        Wed, 20 Jul 2022 02:18:30 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IkLmdt9URN4pDZZeNIA2vi4wTezQKjD98mt+vlQIkhmTsWsbBGC1EMM3doKNb1kBSZp2cZY8rT6OeAS9Oc9YZybx7aG5aqBKmbEZJK83PNJVfNBnz9hkHkb/pP5Du/ObSgh6EvZ6iZZqnpOy+izKWj3Gvls/tGlQVQBY5/xWbxKP0zn6KL42IDF2zgSCkgaE60VzzwD7jqpMuKz9a5JT1uHH8cY3YfTDzZql21NfMYnUChMFaWCrto4AZXlY6EPOKW8nmviW0P0foz1BEbKFzMYj6PKnXduLZACUAwILNSm1ZHvDgMv5XW/6Zw+aQT0F37uZfDDws2PtC7Ovt/1ecw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO56keZ1Mx8xMory8Av9vRhd5+/xnxyR+fmrkM7W8S0=;
 b=MPZhID11Iqe0eLj3tR3MA0MWw3kLAsEN3sYhLNUibHocZnPiemEU0jd6Ax6ROh4X9Rv21gf1h4gVMLc8lusRynm+U63hMTYeC5sCZ9XSPvgsJgbJnzYHCakAF/bJkr42gElZqL3l6czlVUio11PFIctZWIT10Ap0KrA46xSJS7H+JHo4yJb+Dhtp90ZNN7QPicP/2eFNWzg5U54bU90BzVWXPrTt8XXmVbMnHPOsjsCKcK2Hn8nQFq4SrKxf0bCnKlGa35lybLIkNf7GWQsFGbmC1n73FVnMDCNf2RsUmKSDs+DVCSZk/U/W+kb3NP4TDK6nvRoD2KPUWrH/mqQPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO56keZ1Mx8xMory8Av9vRhd5+/xnxyR+fmrkM7W8S0=;
 b=bGtKBPmr6YJPyaPPBLQv752O35zmK0Mm55U/yi8KgUSOQ7LBqDzBWy81K4h4aLM7dsQWFnMM46tWr6bMryIFNUlD//aVJrc3st/540IUKt3iG9z+gn6O9LfaIUVAFaesGFFDCfoA1FFLFmsiYg5EOGr5PWvvP+ObZ6xiAR9wE+A=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 30/69] arm64: remove mmap linked list from vdso
Thread-Topic: [PATCH v12 30/69] arm64: remove mmap linked list from vdso
Thread-Index: AQHYm97r9dMcB3LNDkak+iX3nE/vQw==
Date:   Wed, 20 Jul 2022 02:17:53 +0000
Message-ID: <20220720021727.17018-31-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b5267d4-926c-4e25-5a5b-08da69f622b4
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NxXEMNqsoOL7t/wnXv//0OpeKI0IAsWvXT40oIMi63yg/3XFQqMDah2fDxT7t6Ur++D8rFaD7ANGXZ9WbV/UIRPmdM8xUzv4Sfj+iqvt8QBLDw1xvBKjrPzcYPJZfGeCe8mpe71mnH45xD7DRI2e+lgheZTRI3lu67mhCdwl9GUgQrKVm6fXo+w2G4J9Cm81SG+3G4rvd+JcjRogSn0rfnwmuWedizKtUTmezt875amRXS9lPtKieHdXawX9Y5ISpFDM10+1g0ldMIRAN6o7afmxi7iV13Y3PjicVuaqoTkT8UFrNkMVDWcZOWntrLRVxJen2VvzSz9g07jCuN6jrd3uQRSYodXpfelVIFauczFF5L8L/z/rcWkoeXBNx/1VNZW2i8i1UQqsK8o5No0tYGx9NedB1EzMPeTpsYJZxx3NxaEXePs+aGZBU8ni6YBwq8EOhDIj2DhEE+QQ1X/8yT+8UJmUmGRvK9SqKpge7EXTC79oRSKbYN624W3x5gIN/qWfRJfIEw5w6322tN1WvDEmHQ0gBR7YopT1Tcn2tzUQK3c4GrGcX9Qus3zf855NYXfHKxg5RT63mnkfmJbWUHKnb96DXy7tq1I18gksjIuvBEzQzcIoKnIEOOExy21mlhC0M78lJDXRE7YEAQ7s13OdFzbbaVHTZgJ3vbrTF9jGIHNXdhBSQOIRSdu1uJl4T0HPZlcrPN7hazrdUk5pPEuIblqYERLvGJRFGK0eEYnV3AKj/9cageQfDRrEYEYJYtsbXvtraAvTnLXvPVKxqDi14gizerrsvGLjKKqTl0lHIPD10im7QZPM0FoNH3O1gk/1DR5MR4bsuMvxkG0kgdS/Y76oPLQfa/+ItDmsV9ZaZkRUdqpC1Ayg70r8ChE4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gelXOPar52SA9TYTCMM8sWHDZKKcIj4n8vB1ObaYGDWYS2brAlDrQmISms?=
 =?iso-8859-1?Q?bZ4MgiC1WZvBCr9uIaPscgad+G5ZwCnWc7scfUwwUfyC08rlC1urO6e2TG?=
 =?iso-8859-1?Q?TpsOmF4wT71Hnt9bnS/3DJHpnt+4CSi0XI0E+0OI8QBR6IwdLFrSpne8aj?=
 =?iso-8859-1?Q?L67im7b3tYdG/9n/yssAsbfBHUNWzhlzik2pfUeSsxbzUU76jJ2q8DFAg3?=
 =?iso-8859-1?Q?f0lQy3cYALHzYSyzB9cgdvPCOjUO6KrzJjViRVNY8wFGxVHJk8jlMxvhHl?=
 =?iso-8859-1?Q?q5iwdCP8GMKahveiiCO1KPm4H+SxjN4zFWgUBXhNnjptOlLBlDZn07Anfh?=
 =?iso-8859-1?Q?YW1W5XN60CzlHvFd6LrUGX0DYCpgk1KAe9TA6EBUPMxRfmBF9nrJeulgJo?=
 =?iso-8859-1?Q?PB40K7wHPWckgAWM5x//PcPVum6mJgrr6QbFFWzmoGZAI+eYngiRHKeiTp?=
 =?iso-8859-1?Q?KgrZJtcoz5Yvya9VUO0dCuiHau27+V0To+X3H8vdLHkDyqqhG1Y67IWcyQ?=
 =?iso-8859-1?Q?s+acQ5I6viN9Jed6AYtvJb6qN8JLS52uxRpt9hTyeUTmgn2uqUXseZkKdk?=
 =?iso-8859-1?Q?MfaN4c9FnahLZweYTI2vyMt0evrC8pwE4Pgdv1oF77IkxV9TJ8MQvGuG55?=
 =?iso-8859-1?Q?PKoaw0uO+ozuTQFGdmWos2yXRyGW7fPXPlsV73tuNBSmYD+3BMk7TW5+Iu?=
 =?iso-8859-1?Q?svftHaKsKLUiz1T4QorGtFkG7oaBfY30D6p/1t7r5cs1ngrkT3rsXFYtQ8?=
 =?iso-8859-1?Q?hyBTKUrMIdPQ0026zuIDQbUsVXTB42YEIGDXwQnxaen0n3gcN0yqob3WWf?=
 =?iso-8859-1?Q?iNz/EZntIg0ewzWssZuA83FBDEGnqKoQqo0oFFcChMPlm969S7kMJFjn86?=
 =?iso-8859-1?Q?OZXUW8RHYsrL5benKulNA/fewrQrCIcZ5ZnqdnEnuf/fE7WFQwcD9GfSRX?=
 =?iso-8859-1?Q?vemeb/QxcwzTQGVKMgDIB6DSLsehGfWKE3OKtApRD0F8Bfiiy2xXFcExwX?=
 =?iso-8859-1?Q?uZP41OjanL6nyy9agVHUnqSnB74+2DBBlyuDLO9rVM/0PbqNEjyhGaU1VI?=
 =?iso-8859-1?Q?5LsedPBwigJTaIJgw+Rcy3bu6mpgVgZebV5o82jezuDuPPx8MJ1dTKORBU?=
 =?iso-8859-1?Q?Z7E7ObAFT01Jb0oRE2DMRvDnncvksOLQVTTld/FIoucG8k2wMi+ya6rnJw?=
 =?iso-8859-1?Q?10+6vlQwo7DQWzO/MGyMRfFY1yssH3ihw1DG8uGwtK3IUQEND4+7s4Pynd?=
 =?iso-8859-1?Q?P2SM7dT8lH302lpqWeW9dgoZqc/T02aVq8XCeabXotWS+PydLtCUAkbt+5?=
 =?iso-8859-1?Q?G+qNtSET5/tlWd4+uleFYF3R75Onm6a0VhLC5+Lqq/Gum73IjcxfIEmvkv?=
 =?iso-8859-1?Q?iaAi9+t1avBavdcGrgWasnzhiYhY9LRZdR/x0xFlc3mWYEvYF4EiVdZySw?=
 =?iso-8859-1?Q?viQKLJ6pK7+sOxIeIOGZQ4tjhduXoelzL/9pqgo8grBFYAsXxYmvjjsScz?=
 =?iso-8859-1?Q?1CVFulc5OjCNOSKONFYxKGdn38o5V1YjYbxLyKNw60G9ya/Is/kkCMKFI7?=
 =?iso-8859-1?Q?BkCBwPFAYuoaH8EBePI6+TMe2VOgSnohJZ6lNO56cAc9iO8qbCG9lcYnqh?=
 =?iso-8859-1?Q?uhSse9Gd+brcq1lRrdrPoAc1sdcHGGo/8z2GiOGr/qbXToyel5ILOedw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b5267d4-926c-4e25-5a5b-08da69f622b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:53.8682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Igk/K7l1Sw0yRyVJm3shqjcwW/ECumqDJF7JcI8mD9u3LGBiG9my2LukZVCcxdnFx8X4zoW2OsICXXorTnc8Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: rGI0jpvyRtst7rKUb0nBrCgy43PEp_Lx
X-Proofpoint-GUID: rGI0jpvyRtst7rKUb0nBrCgy43PEp_Lx
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

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-15-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-31-Liam.Howlett@orac=
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
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.35.1
