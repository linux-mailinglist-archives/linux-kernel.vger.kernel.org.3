Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C5F553C16
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354662AbiFUUtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354587AbiFUUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9BA60EB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ1TE7009747;
        Tue, 21 Jun 2022 20:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=4KZWQ67AUshE28m+q6FWf1wx8QpzX8jrJGhGZT0PjNM=;
 b=ztf3rlxZgSgVyoH+Y2CyUfwfTrsspaSXm9Iq4HWnwfkWpvK1tO9vkNEbMnmGQihGtwi3
 0B3Om3Ws1FLslqel+1/pusAISYs/q13ddKK4gxljzvueNL95f+UKcVeN1WAvP5ezQk8T
 F1kjkbnAJ2OBRVbzDEd4kOlG9RJ+rneosq8hY/bB7pfn6O23ND0cfRcsKCffrcp+3idV
 4jflmtnuUIZVfEHQPBs0DsgS7yeUfpxVjez9UCNFHOm0GqzoYBYJcd78X3vupA+dXx2C
 Mopi3u/ru6+u17L14z1fRgRtoPcPAYE9HE37FnSLYEGwU8ksqeGsbPc2251W42HcHGfy rg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhv027847;
        Tue, 21 Jun 2022 20:47:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6DMUeQDhEi6KWzDlkAmpRCTO90D5+dboI3sS55cTE30T502wxiTBrbeUDsaSwQEX+iuW1flaRn9mUWtTt58SGZahnj8u4Bdb8cxuYzgb16T+5iDhsbiS8po7Y5dJaeuuuT8ssBHqDBQn7jyaNnSm57Rp4QRhgJueTK5VbZOQAhiMipvdHd9ZCHJgiP0+qus2ekTwLG1UknJJmOL08AEosSl96Gac8C3S1B77cUhgPFNyTsAJHLkIWBKPyXxXnElw1qIH4U7gfBNEX9btRHzg7Zh0C3KiS6qgHyLHVFgIOzfdko+0pU4hSvt55kGIXQH7jvioF/GQRekbzRdCOIlzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KZWQ67AUshE28m+q6FWf1wx8QpzX8jrJGhGZT0PjNM=;
 b=Sz4sJIa7GaA9xORP8UFVPPlRiVUoGzrl2dQVgNyUcQBVQCinqcZXK9L6JIwOBord3T6Tpepe/Tw3PmR3FX/dG806pBSKReLOBGWGMFSvEkyPUC6+KLOGHCCLdAz/+b/W5Rx3Y3VraxNXcWd+ZKKifIoz7giW6u2p+Ycg3kwUHPItzJk7wCK46J2jiRjEMlhgKtU86KvbpqxKdeuKyHFttsPgDhT37QhTDOEVlvlrj9gi1gWjHMHKNao9L2v89cGJ6yMSx7xerw7W6c0yx7Ol684gFXfErPy5WiT8fpOwpEnG62WhHfwbttxvn7mbUneD6w4qu9xwyQFZaVorbUTEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KZWQ67AUshE28m+q6FWf1wx8QpzX8jrJGhGZT0PjNM=;
 b=c8auY/vhsKpsC0qHOta5nxzrb0Y1CGBXMQSXi1/8sq8l+av1kDlIuZ5xTmwUQISYUyWkK92jhVA7cyfHvDqSLXWinkVwzVhfzf/NHAny6PbQ4vwu+d7kMNevpK5pko6IBLsszpDKokNqU/8TNy9er1TX2xM9GjWlbdRc9CspOaM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:46 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 36/69] xtensa: remove vma linked list walks
Thread-Topic: [PATCH v10 36/69] xtensa: remove vma linked list walks
Thread-Index: AQHYhbAQdMOOfAzUkU2XTZghWGzf5Q==
Date:   Tue, 21 Jun 2022 20:47:05 +0000
Message-ID: <20220621204632.3370049-37-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a44f200-6f08-44df-310f-08da53c74bdc
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025CD75E9AB547914DD921AFDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bUjIuz1gfreF2TaIPmFfSgyxy0HT0zlj0I1j8rBTz2z4dE/7IquHEe0XV/lZsfv9rkz8gmqs1mO8woE20p0EIzDvJoukjMMiM4BME04jzjSH73W0kR2/dxca3xFRkvcU+eXL9VHeQTMmcJBw4qlYvdSGFWMNGUNExKP0mhxiyOrBrbYIvnDoIapvTu5KFD/YoBo7syn9RystCBlyQMsFjdyh4Cn7qoiRg5r8a5Ow+PMuynWOK5Lao86xbELA8aMCmzpDfb8/rscRwrpbPh2HYcmSgIpp1wSy/ngOx8bcn8tc0jrIrm97E9Z6YS6tWSOUmo2Y2hLMuWVBgmHgDUHrZiMpiKp3/cQYfgvBrFEzXIXNYqipyVX9m1OrvU/mJbvE5w0JlXwMiI30UAYNPLoMT2H34A4bWdmD6nfP6OlpgES+jgypWyyumZNRWCLaPoF6Qdl/KahkCLVo2bKHpSbmz+j0mZSEGM7rZ/NNLzoCt18g56z7Iwn9hMM6iCeM3Lnd++E0ot+pyzg/RltwfAqJNXjHnX+6Yh8YxPmFztQF5hI9I3ygx/ZPov+Vd0vv2VpEO27sqRjt9Vv6hZvA/hXw5bEKfjZ2Nv4vt/k9YOnS/7rHpL29XE6Mcgj0KYfxKZ2EPCODfpDAiBOh7QHisd/c+hWsefRMFOyOVTvmIysU3eNkjD+Sd8gHQHAtopCx9JTBseUBwnbO++ujC6uUZP8GoQzAdIScjSAk67VENdq0sufy/5QMDtmGlVGog4ViU/wdKGKvJLjp2e185ZpUmfzuT4XFfwodqeJqhbOu6MfgrUw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2qVIGiXg3tmORVhVWWpdvIAF1yYv7lwtQx7sQr4stbkgAIH4n/yxnPUDTr?=
 =?iso-8859-1?Q?Jm9lDZSGrQI9nArGCwdKoTTUuhFLmxmlKSVymgbifGETo4y6vdNW2KHlQ4?=
 =?iso-8859-1?Q?/3Er83QsYChqqsSzdzZwT3XFFqCEXT/uGYkQnJSrrwY65AsUBFocwS2IJ+?=
 =?iso-8859-1?Q?DjYlN9XzXyOZZDBaA5mkULSSv2UpyA6iwe1VjXcxrsQuXx9FalMvnRRXA+?=
 =?iso-8859-1?Q?zpnqa+4bCIsgCM40dtsYuRyw67A61GHdY54EKfZwYT1WKna0pRmAx+6/hk?=
 =?iso-8859-1?Q?2WZlATjZqbg682fhJtRrRTv/kHFmRzw7fM/YUpjW0uK8Le+ki8zbbCkhVP?=
 =?iso-8859-1?Q?8cjnIRS1G6/kJYSJxEsV4thOnLeXivJ+Lp4+riQu1kK3Om2F6gt0udVYvf?=
 =?iso-8859-1?Q?/XjZu9iZmYq+3ZEAwPuQYwr8ZvH5jFodFqqdNox9qABBAWgg+HCdUPpAfN?=
 =?iso-8859-1?Q?yQBHGMyis71dFvZQ3s+X90AsiBvHXRR8rGvZbxnwrLQGf1Oli8pJmp6Vtg?=
 =?iso-8859-1?Q?ljN2dFrI9iZYgPgtKGDbWX+JUiy5B9+D1PRH06cQSOkEk8JAHPJlAt1XQa?=
 =?iso-8859-1?Q?NSDWsyfV718qUyJlugb3nrWtOAmE9DdRf6iMHidM98BwIS0yOaojXb1CTX?=
 =?iso-8859-1?Q?8JX9+YDJu8tY0tgCtXN2wyYhJrnDq/8YWv9RmWyeQwCFki0WuPyilpIJVL?=
 =?iso-8859-1?Q?4tOIZL2XIo61+3FvpQMRTixsqV8prZq1YDu3Udbw6xs0G13VmJs7f3c7s2?=
 =?iso-8859-1?Q?rhXrg0w9ryZe4d79lZbaUqLZAbD6cc7Fn0TLhVZ8WKXOAl8spawZ5wK88K?=
 =?iso-8859-1?Q?m6EbMnhDw/sXMUXMpQP74CHSeIS1lHO2H2HYcggSHo7xQl2T9QFilX1yU5?=
 =?iso-8859-1?Q?KeosSqB9FuRK/3VO5mO2b8E4UAoAwny9MT/3QD/fUEjU7NopLzfJF/Wf2w?=
 =?iso-8859-1?Q?njYQEcIcF2zs/mpcraO9bsHSlr9RxM6PC+XZmvpzfBppJmji+JvO0IGzOC?=
 =?iso-8859-1?Q?zc4m+VAALuRI0wg3CZVj0BXHfLbK7gczpJKjsg9aI5vQfSVNpDiOfq4CQy?=
 =?iso-8859-1?Q?Pa78lMgYTdPXUi6W3D8hGuyrtvyyS0uYn8Vzyk6ASSm39FIqlIRnllQFxU?=
 =?iso-8859-1?Q?Jar+IKWp1mVD7nqpmwli6Iu3yXZ5+0YIYVSao6e3ytW5he1yrHrHQayv7J?=
 =?iso-8859-1?Q?shVT+vvoRnNL3nHN/wbm1SH1XajU4i+/8QBqVs5VO8ChA1l2PvSs2asWgF?=
 =?iso-8859-1?Q?6HtwgKMnghNaaxm68H0pRT854UX8nYPN+CPgzWvtiE850S6w224WDql8YP?=
 =?iso-8859-1?Q?2Hu6zdxUSIreqD6avKjRn1CEUHgHHdrJvpMSxpmRdNDaFpFZQj91hgHBk6?=
 =?iso-8859-1?Q?ojHEM1RDaTUg56t5UXCu9Gmr65vTQ4T8QOrwRy64G8frZjHSbfoTRfvwkP?=
 =?iso-8859-1?Q?fP/3TCy0eud1PMI67YanV7ztpQ5oLCJF6XTWw1qrx3MV8M+jDS00IhW3W0?=
 =?iso-8859-1?Q?mPV7kPFoWbD0NaaHfoDhOrRFeI3WaT2OGjqwzl/Fif9PhmojGgYLB8+5zH?=
 =?iso-8859-1?Q?Q+ceW1dRr75YOvMFPW9KHFZy9SP5McvreUXDpv/j3eztTE3J1mP5WjOMXT?=
 =?iso-8859-1?Q?4VHtPdh/SgSnE8QVtGEPjbUSltJ81GAl3ILEndZZPK3tK9gOUEun98OnF0?=
 =?iso-8859-1?Q?bl5QsVHf2qAdfsRZhlbIQ3m2kxbFpnRY/pvsWSahUJe48L2ITcU4ixv/Mu?=
 =?iso-8859-1?Q?hF1FN9ZJhJ/vbcsk+jZntIaLUQXazKi8iHB64++SrAWRVOy08JIa1q6yzy?=
 =?iso-8859-1?Q?NKF4XVAh/fiafaXe1R2EUfLswrLoDnI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a44f200-6f08-44df-310f-08da53c74bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:05.0661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9u5gqllZnGqSNWiCpzwKFbweYfuTFJQ8mDQQiMWapcCUcdwiE2iUIIEkFMOs6kQY55+PiZi7YLsWb63YNeFW6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=949 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: -J_iVh57jPlhuMUvH8bMM3NB4dCG59ux
X-Proofpoint-ORIG-GUID: -J_iVh57jPlhuMUvH8bMM3NB4dCG59ux
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

Use the VMA iterator instead.  Since VMA can no longer be NULL in the
loop, then deal with out-of-memory outside the loop.  This means a
slightly longer run time in the failure case (-ENOMEM) - it will run to
the end of the VMAs before erroring instead of in the middle of the loop.

Link: https://lkml.kernel.org/r/20220504011345.662299-21-Liam.Howlett@oracl=
e.com
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
 arch/xtensa/kernel/syscall.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/xtensa/kernel/syscall.c b/arch/xtensa/kernel/syscall.c
index 201356faa7e6..b3c2450d6f23 100644
--- a/arch/xtensa/kernel/syscall.c
+++ b/arch/xtensa/kernel/syscall.c
@@ -58,6 +58,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, u=
nsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct vm_area_struct *vmm;
+	struct vma_iterator vmi;
=20
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -79,15 +80,20 @@ unsigned long arch_get_unmapped_area(struct file *filp,=
 unsigned long addr,
 	else
 		addr =3D PAGE_ALIGN(addr);
=20
-	for (vmm =3D find_vma(current->mm, addr); ; vmm =3D vmm->vm_next) {
-		/* At this point:  (!vmm || addr < vmm->vm_end). */
-		if (TASK_SIZE - len < addr)
-			return -ENOMEM;
-		if (!vmm || addr + len <=3D vm_start_gap(vmm))
-			return addr;
+	vma_iter_init(&vmi, current->mm, addr);
+	for_each_vma(vmi, vmm) {
+		/* At this point:  (addr < vmm->vm_end). */
+		if (addr + len <=3D vm_start_gap(vmm))
+			break;
+
 		addr =3D vmm->vm_end;
 		if (flags & MAP_SHARED)
 			addr =3D COLOUR_ALIGN(addr, pgoff);
 	}
+
+	if (TASK_SIZE - len < addr)
+		return -ENOMEM;
+
+	return addr;
 }
 #endif
--=20
2.35.1
