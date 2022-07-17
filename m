Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D85D57736E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbiGQCvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiGQCt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E222286
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:42 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8g36009610;
        Sun, 17 Jul 2022 02:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=Fg3GlZzehQpqGuwrREHz5SUEjaztzrtX6qrINf6xBok=;
 b=tm7QTZI8d0mg848NiEyJBvxfmPKTWmSI4Q4g+0srcB5Rqv+/k3j+9wKmE7xGWBsfUDKE
 dtuNjhctII+dXlZPr7FURedzziRm8D6g5hP2odv25tqTXqtayzlii0EqCdb4Wmc/EgNA
 93p33LDotu0YbwiQ2HvWJ06mKitnX4VTJAZdKqU2Svm7Njba/zRJKh/RNUkiLznUpdRR
 emZci1j00bYVRnZPR7J85RgPajTmlAz9/000XQ72i4wdDFLCsGQZBG75S8oopp8ccafZ
 inyLvmJPXGqjFDkjQH1HW+o+Yz4WraXfaEBYAZiVXWYGR2lhzM0LH8cyoIEHPFFRe7iE sQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0yng-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxs036125;
        Sun, 17 Jul 2022 02:47:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHoHx/C9L6HeGNslK3L8PWGMo70btX0lMhMS6NTMGY1EQCy7uUgivGmC4r/mNqncTpYYQ42ipolAzMvUSUznrQ0MD2aLSNVO0CZVifzt3eIAVc3tg5lJgUgiV3O+B9gJH/IgTnM7u8rCxaJcFb4VJHiJIhndQDt4zQvtGwTqgxBy/NOYWe3DT87IFZWFzXyvisVc3P59W/rqqGJAiDf5+qdwFMHjt80kU3DcObDHUqe81M1NJDOYfRu0eCGZtDJ0kUJRkQzwzewfcAgrGt+yaQWS+3XQmq7/psgRiX4QAixDTbqJZkg3Xpm9LEw5Q3kVQ+SwRahbA1363DW8fTYOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fg3GlZzehQpqGuwrREHz5SUEjaztzrtX6qrINf6xBok=;
 b=N7xALj6LbualTcFAp94/yCntdCjyUmS/+heIgnfeV1Vm2x2u9/egwY72PRyfp0HTjmtjr4Uc6+lNve+OJeteXilN6x6QLSj3s0fCTK6Mj8ToPrjicUuhtlKYSk5bSyT3BpZjzlJa1emyEDLmE0nw4iwFKzFtUvvsf7xOq4EhNiYpzx4rjWnLsvbEowV6uaBUbOEAsi8x65BtVUFWMmxpfQZrujMIgXfLsBvcjitorv2N88sL3NgHYjy/muS+vw0YXhvlB8AETPDpplwIlBSi6hHFyaIPaoXX/929gyhpulF3EHB0o6H4eP5W8HWJWGKimWLFzRCNV5bKUNgPqSuE4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fg3GlZzehQpqGuwrREHz5SUEjaztzrtX6qrINf6xBok=;
 b=asaZ6RQeIgPRq8ETvKTFTQ0vjSH/yxHadIDKyzB3VlDoI8jpx9vVGzFSS13WgqZ9PSfy3Ii0TYswRXrXql2IBLIqWcUyBBWQQTmMIBie/QEltk1hiDvjrFTNYb6Fq572Y1s2D0V5kQKKQs8ewtVgGWwAre7pI53onx7/Ju0EKXY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 52/69] mm/khugepaged: stop using vma linked list
Thread-Topic: [PATCH v11 52/69] mm/khugepaged: stop using vma linked list
Thread-Index: AQHYmYd5SBKytiAXsUGzwKz4kHWYXw==
Date:   Sun, 17 Jul 2022 02:46:54 +0000
Message-ID: <20220717024615.2106835-53-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81bb47d1-0f90-49b4-7ce2-08da679eb1d7
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0fW6SVewxi4hu5fJLo0bqF/Q3ftS++VJKeCZfEVb7ZB+QQe0MRaRWttzy/ysnvEoJqDC4nTTIDwOHJMxhqs3J3tICqUvwCHjiImaR7B5zebegaHMHa+1yaTVVTlYxnKTvu9NLMKtm8VEQmL6iUJdxZ0fOt2Z2E67CBZOPymiLT646R1IpM/TlfUdu6DruwyBhJcFFmkyfzgvSPaB8pqpZ9Nbx9WwCcNqpM62ziwn16bYJn948Pm+jpt8R0etv7UcB/+UrNuCIZ8okLaY57x7/nHHegk3kfsVs+nCir6VIvfMTCfvVqqj4ST0k8ekkbxd7NVr0HXrjxFz1p0EOlAxD1o/s718Eet/zw5LMSdJUT53tXrkuDzKW+nhMt+dqzS0A9vbuQ4Ne3jaacBLkGE5BM+geD3EmBN9RZdCg+SmTl+vA0ouGm2d00CyaLjDzGaZye/FWc+lV9DtCm/hXCAGot+6IUfH3KERkOvwjdA1D5zSCFzxZ+TiYw6XlqnTBX57RjrssrC5NfKgQy0IsUzdovstn2VHL8JkMmDbL4yi6vWWhPEVGF6J0J6M9cSe4mEP7lQeGgvPty++/soRv4lIWYEcMZLRlGuKOBAsKRIKIx99mtQPNk7PdkhLJdMCAmPqWAFplCnT6xSSh3QrxLc7FDaZ/WCmtVIXBe8ETiDXGVFlpWGjxf3HtbKiKq4gm02D+QxsWtj6Of17dAPXz8/iEpLvAWHNrUTa5n7ZEcXrdNtCaWsf/SZ9LmxdzL2CG94zHicCx5UsUSFxqHahm+es37+V8SwmHSDZ8E3TAmtWPxgEqsJ+izdUVMOgkCNB1oVw+iE0xd8Djd2ayfYdAcnnKctiYURQ+t83MYj50a0GTAX68CgQvvCj2IetWtBGlMVo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ly3BUX3spIJdz+VS2OUgcmQ6J793AZhbPNcGFPHyZPJ+ZjPz1FQW0loa+9?=
 =?iso-8859-1?Q?uj8Bmm1RUHXGccyBdv7m0bS7Vyv6KkJG8+wecanUbZfYKNYL1/B8W2aohd?=
 =?iso-8859-1?Q?fkgEDAwakIDKl0tzy2j1otoU/d0514edOXho3+GDMR4BZsCdfBFaToGStU?=
 =?iso-8859-1?Q?rrwsE1K++3r3uUFN81N+n1z6wcLWkD9nNK2njkkI79jl5iBhxzb/GwSds8?=
 =?iso-8859-1?Q?xN/bU5DGqpXUseAKrf1QlohKCUCGrE9zVLlKfaDzgB++FIvNLgg4ZPNW+4?=
 =?iso-8859-1?Q?CNLLBxQlXkO8Kql1rA0kdPQ7lnIGq5BNuh9hT1O4dzX3e0r2ZRWDv5F3is?=
 =?iso-8859-1?Q?Y9rvaVzEdsLZrsCHL8oLSoZwI28Ztb4Wa3wypUbw4f6zkYj8khFgcNLoRT?=
 =?iso-8859-1?Q?E7CNxlmXT4fE8M9XvbkcC98EDx4MiLt9nrxGwYpq0OhHQ4qhcFGKTTuorJ?=
 =?iso-8859-1?Q?iYVNF2niBxLhEkKtkJ7HeeLiRXD2rdDuzxoa2gGSjprWVFjxISiaguRJ9H?=
 =?iso-8859-1?Q?3YdSSglP1sbhdjp1kQxbVpOYL8ZtQjLQ3TehLLYynZcVGQlgA0ajFN6LBc?=
 =?iso-8859-1?Q?jq0uu9h0219d2YwLxZik8i+RS8u9uTgvuwB+XXpvbCaBye7ERPSO5WWtmH?=
 =?iso-8859-1?Q?tJj8y3X4c+f0Bez3lF5VGW/Ua8suAgEIbYEM5Ym2Uq1kvDF3ZvwQgvyVF5?=
 =?iso-8859-1?Q?nx9dgul9eQXoihG8m2mOt7zcbNUhKozg1/IrTGFIBYAJhMXBpt8zc7M2NC?=
 =?iso-8859-1?Q?H2/eOc2Z9OEnbkjtoGuu1vU/WMy4ytI9EZfihwgXgoUIENsfKHvSznK+B6?=
 =?iso-8859-1?Q?BBGtIZp/CmBbJxfLp1bGoWA91L9t/Wk+pyanSKclvZEzfBv7tU+ZgVAGVa?=
 =?iso-8859-1?Q?zDpDkUhdqd5NzNf1/TXavtvDwb5ZSIJQ1S8eeOpHu69ZR3kgYlPvgknVmv?=
 =?iso-8859-1?Q?TRklr1Abybcvgtne3B0pOYGtzjCzXUBFEVVjiZLIolPpvdyvNFI/z9v8GG?=
 =?iso-8859-1?Q?v5eAqvJjI0drxI0CzJi5IEobUZvLeGtoa2MXnY/yNzbNTJj0MuPPcN5gwn?=
 =?iso-8859-1?Q?P28TTppPJQNvgfktCvIJgverhtP+vVPjD0CS+eWr/bKUyrpszFZHVU2x1x?=
 =?iso-8859-1?Q?0X11BhAmXKC/njwlcoc+5+hUkfJP1wKx6CWDWgvU6QN4Tg9AuaCHx7Iomm?=
 =?iso-8859-1?Q?omnx41chQYRH2G0HNvQrSOiz1B7+bEjJsrZpcaq/443eh2P5rEc8c/wRI9?=
 =?iso-8859-1?Q?QjYgvgPgJjDAdx9fCIqTZ0NeXhOq+1RZk5ONCdFthSxfiuCKlupz25boNP?=
 =?iso-8859-1?Q?/qnLy9t9+zeqnl17P674eyWQxMoJT7m5g/tCWXE/bf2/0tpdx7eWOsQHxa?=
 =?iso-8859-1?Q?rYDFLxPyhnaAE29545qjC1fPwvQItlpDSdHC9Z/eLVj9BISmlDTDFsPzPO?=
 =?iso-8859-1?Q?Meua3NAjrn6OGA3tT/mNYmrkkA1PamHz6SaH7ctOf38rDluwO8FNg3619w?=
 =?iso-8859-1?Q?XyWsKcCdARXtqLh6w+d11MdmCB9a/CKEIs2IlFEjSHnf3lKV25q/EWdetE?=
 =?iso-8859-1?Q?n+pEJb6HPB3f207QcsXbSUMR1pkO4bOmGUYVmDSA/+/OKdZb+iEY0dS03q?=
 =?iso-8859-1?Q?iTGynfU7dmjpcxm365ZKvDkfQEkAHy8SQWUxK0mxFq/DRFC1x+C9N3AQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81bb47d1-0f90-49b4-7ce2-08da679eb1d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:54.3335
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KT75xgpode3kb9+Mb09kBIAEHUc44Ldo5gRdFzQ3i23GJerawwpdKp+YldjZjDLLIDsLLy6e9c3rhCb7J4m8mQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: fRRLinrq6kycbWzrGWwAoAIxY5a0KRBY
X-Proofpoint-ORIG-GUID: fRRLinrq6kycbWzrGWwAoAIxY5a0KRBY
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

Use vma iterator & find_vma() instead of vma linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-37-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-53-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7248002dad9..f44ffd3bbfae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2266,11 +2266,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the next vma vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8dbd68c414d9..637bfecd6bf5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2092,10 +2092,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
+	struct vma_iterator vmi;
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2119,11 +2121,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto breakouterloop;
+
+	address =3D khugepaged_scan.address;
+	vma_iter_init(&vmi, mm, address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.35.1
