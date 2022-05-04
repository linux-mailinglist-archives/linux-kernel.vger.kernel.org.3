Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19FC351937B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbiEDBWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245243AbiEDBS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:18:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29CE43AE8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:45 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243MOe0J026132;
        Wed, 4 May 2022 01:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ncIk/uGiIj8quCz820qQp2d/C4ot/AJNrHmIZxhnCWA=;
 b=hUSbGn2ZPxdQut6IUiistq7HF1bm0VgwNMpkeFuN1vVzjFYBl/A8rkY96eD/MC5ySGJG
 Zu6Nf3B1bj3A8FdErz8Plq9y/ZkFZBZxLsMc/dF2QKeFAk3j8VDFzGAugiicUXPVMGba
 kKD9BfYFHmghADnyQ4pKyZB9jRNudmHzVceGpL4QXScGkzJGPFInG78su53bDMctUuFL
 qWIDioL6RXk1Dh/bkOSw0o/t4AHT/hkuksHcwSwZ9xYr8uvCbvMWfhhqkfdamDAxQymP
 byl+55s+HJOpjNH5+oeMfIsAB7divsEczKOcZjcZc+AFncWZey6Axe66QbtpjRdN07Dw cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72q5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441AUFY023411;
        Wed, 4 May 2022 01:14:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj9g4fp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuAl5TCP0plBwazhSGWFoxf8+NlcUp/abQwveOta8RWUVN37DEBk6KR7D3RH/faYKpvLKhRwjYI5Qj9Mf5uWjYvrpr7tnPlpiMW5KX1Bcn3HLoKxYqZmKxDe2mJrTTRze2XPuwWI4WBqDiIcG03u/SDafUjj0LdfTUP3Xmp5LHpZBZSr3FuUH/wt2AJfjPb2ntod1+6dzSEsCyxpb8M/7Iu3wqGb/tBnx2/5BOM8cdgwtEEFHZ1YDxvGXbeOwOSvRUIxPksUxiitR2B+M4EqJeI1N/9pfopFnFv2V6cCbpsC5SJXfQPsD8Y8laT+V0ipUPRrmxgTu09RPgPX1ZVfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncIk/uGiIj8quCz820qQp2d/C4ot/AJNrHmIZxhnCWA=;
 b=m1ydJPr/SOtEdcx+B554RFAqODMqSaEjAC39JxMNmnLoSyP6WbNDvszOzY6+BvVLM+ggSdGnysbld7zQT9ZPwGUnao2Z8Oxg/i8VbXZcjPqU2ucfZK8N9ZO8N5hLVQIz2hJU/2ej6TRYDns/SxOr6j0SPwCe/5YV149SsrcY9nRVzCQ6NpTKQ1dKr8nUB+bH6GJenRkKd5broUxnuPSKsvmP84vc2ke16ZfInVE3Xgi1MCzrSGl2KBUB5KnTQ66/NErnhWnPayiIalMAkEIp/su0BI7UYXwAOPFiiUDW7jNhskn0Wc/EA5y+M/W+zzgJ3bru5Sv64UG8byO41cAw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ncIk/uGiIj8quCz820qQp2d/C4ot/AJNrHmIZxhnCWA=;
 b=DoCnmfrfKIoDFO9GXGuYiemDhuCkcGBcNk61ODrJ1eP2w5p/BlOPtTXL0OgSop94bzhtYrsvKgCg/LTFcCM50DEDMXt584FkVa0kCDRP0CUW1frkOz76bCGYF38e3/u5h4/GCtmTeOb82RVy8G2yW5sCsfw7I/A3hbMUUqmtUQk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 47/69] perf: use VMA iterator
Thread-Topic: [PATCH v9 47/69] perf: use VMA iterator
Thread-Index: AQHYX1Q8vPmiZSdqoEK/8A7Rfom45w==
Date:   Wed, 4 May 2022 01:14:00 +0000
Message-ID: <20220504011345.662299-32-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0dda8be3-159e-4405-7c96-08da2d6b739f
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728474D25A83B4D658E0AE0FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cATVVJLIUt4VJkCO9SjWYHKhFtbvzQV4SDRd+Lo8HTwidUCPFWAX6fpKdJtZLgiti5Jhg6byIe3aDklhffWo09v3Rf4Lgxgvyn+DOJkusFY+lVJG0+2uVfwVEfo22/Ex5JUkphgnZ0ieohztxZGfAPEJqyA8kRv1wtlf/7RuFv2Ck6AcS2IoFbQ3iBtpZ/kJD2gyjqJFP7O5xe4gTYsydvZPE5QmxJZOtnYwbAE1ruT3Hk5AMUJCGr69Xzxsxx+oBBI1PfXiIrICClFJ2zS6JIfuSIVFX92pJDyKpZAEsbqV35VWpTpPJszs/iC1AD2s0Hu31jie9HMRtftdaeyUm58l1ZDSwxdWFncpwmaD5ZOg5Wd0HOJSc1hCVUkEkgtCPdvx5T/TT7WgYEwy/HCXZygA+53znKw7JHr7kh80H3Mp3D111X9tsWBPDOG2g3q7d+06t9L7jM7ur7rsW5Zx9TS6D7amPIi8kZBY+v9Iior09rv+wlcBhrbY2La12/Ga7a3aSTO7WzGkR9l4lVUtoOFkHqpw1zSdhCMolZJHHrfzkFy78O/o8SQdi5H2JnrYRYAC1xpySoojU5v+0X8BVG9ESTIZYZL0bBkgF9Cg2I+eSUvmBTV2/WvHBI4I/JY1rUuzY1sGg8DVjq2vljoREvJH2b0KsxGLja4YjGdDBm94DqkNdz3WhbPlEkN6qkVMD/aWROG6bIpz3ghJfRxL7g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vM+P8hiOIdpTD4JnEblmCB8WvhJ56HiZp69EzmcH5MmQAXBc7k8lNNxBO8?=
 =?iso-8859-1?Q?o7ssNaska+BJ/hdFGepWfnMW1DiRvKZG3fm8FpEBy+tImPLaDiN3hS/G0q?=
 =?iso-8859-1?Q?8ET6MZ3bBatb8Ci9HQDXxwltXNqfQO01MXPgV5pplTPWSvTN5QA9C0lDyg?=
 =?iso-8859-1?Q?C/9WsBtbaFT/NCBkP1yWEL8FNxDyr1TXS498hdzyIM/nklOKsAsi53v0Da?=
 =?iso-8859-1?Q?EIDbZAF7mUuVIyj8G4A1QyTD+jybIhBY51mbFfMyCN9BRaaddYKHlVVZQk?=
 =?iso-8859-1?Q?8oIqleHKFhg3eAcgT7OmYdILuSbznsXeYVXqFh/UIB6Pn3iF8PIUjCBMe3?=
 =?iso-8859-1?Q?ryuZl0bNNQebGJT78UUdhmL75pJz+9mDL1bojqU2kLHpPbouTHQc77YmK7?=
 =?iso-8859-1?Q?ZsS8qfT+VHAz++E1KSIdahmgpLeMzf+phzZEoViIK21gAhEqHrWm6QRI7w?=
 =?iso-8859-1?Q?yu9sHfI5ZMJL1FAUYZTyjv0aTH2JORfb05PYEyqGFkPwrV5aSon+dVWzM4?=
 =?iso-8859-1?Q?vY3i/BCdBw6kP79bh9Z4zGkcxIx+F7FBf9EJIol0NQ/Odyop/ClqTKe21z?=
 =?iso-8859-1?Q?K6pDVrY8R2InEXWZ5vNSGTuYqUx4hHcbsQmxBd+sH/LnLyXcGgx7wrdq6s?=
 =?iso-8859-1?Q?KkomqNRF6kFsRHdF+t1vqJPo9qoJqVP+VIF9WekN0OjY6MwiqQMiHEqouJ?=
 =?iso-8859-1?Q?DZWN1mOZ/vT3dinFzAaP2usB7Nyv/mXQfOk4dmodPVU7nAY7LPZwsuDK3x?=
 =?iso-8859-1?Q?igp7t8Vz0u/sAealqJOhrEsjQb8RhPNECZNBUZ2NAtbc0NW5MEb6mopFb8?=
 =?iso-8859-1?Q?tt1kqR45wBBFb7WTso0uTP2axYQahKJ9GcikUbwg36yNxGEmJGAW7iDL2F?=
 =?iso-8859-1?Q?7gC7xz+8bj7ft+v88zw2N4rx2a5gYHXecOiyJRlWXMF3ThsQUOAj8h1YZK?=
 =?iso-8859-1?Q?g14xis9nNLLrpWSGyBELmuZV1OAt5GDDwnmv6vsBXVUdZnuXYGM/tdlccD?=
 =?iso-8859-1?Q?eJIs7VIvRzIDmSbyKl539MlZ085QXnKSSizIC/FlgIGVNn9xQQndz6h7dH?=
 =?iso-8859-1?Q?1AKcaSLYwyUJQ9Q/6jG91uu7+zDgHuXU3nHW9P8JneFxnNWaV+Epptrx/a?=
 =?iso-8859-1?Q?FEZnKzOE50aUYcLGoBNaypKqEZQyroD0wxTSlDGeLdMkV62wq2fVHiLsX6?=
 =?iso-8859-1?Q?9oxXxm0DPVuOsYsqxH1zkuym2HoRKi18AF1Vm6Pl8psvZjzqwyxgMXP0/Y?=
 =?iso-8859-1?Q?kunsT+dk/ay1FENxLoZE1MMCewMBFgD6BLt9NZhGn7h2ZdtMb2Nox7s4+v?=
 =?iso-8859-1?Q?qjhCefGB570FIK1BXivuvL6Q7gCPenvl0tmNrcqW9lfEV+NhwqK3ReYesc?=
 =?iso-8859-1?Q?L4egoNXDQ7ZW4ON3OhBqdqTGXLJP+k3/bZlL4AfHLp0IPADJxhdMDVp7b4?=
 =?iso-8859-1?Q?PG2s2bc/1Rx5XzJj8ESzSr4+sRunfj9MtMYqI1le2Lh9ttutuEP4CLSFGw?=
 =?iso-8859-1?Q?hO5d3ClQEskLbqyujIH84Sz0Pb/3fgsBvABCA9QYY6tnUIRXJaC7PP41hU?=
 =?iso-8859-1?Q?LegA+zwDQGaHYfm13NI7mNISh8lMIVeq3nWINQDUJtl9MHwfzFb4Oi9b4E?=
 =?iso-8859-1?Q?rIepkVJaDuvsDpu78i9q2vfl+P7oAA3OSUA/KCO4NSiX7v+wqcUL2sT6F3?=
 =?iso-8859-1?Q?goqTZIvHsp6KZZdoYEhe5t4QGaCUg3me4R1l+nz7mtj7AnHO+NuieGjIJ9?=
 =?iso-8859-1?Q?x+XKprSAHLsahBL4/ZZ5UWUsNVDU3NYEXs4KYIhdxyjpsJgQr+rdvUadMF?=
 =?iso-8859-1?Q?ma3BDmAhi/Jrd/LAhsvBs8rylvmxlmQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dda8be3-159e-4405-7c96-08da2d6b739f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:00.5795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DktLcHa1h9Lb3YKKyA6JP0wXz4kQ/Y8zUUxUAtdxtVne4OYFOScVfH5uchQ4kpuGv7eIto/2bh1kCaFoZkXgSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040006
X-Proofpoint-GUID: loPb_i5bQyxhCyCymiA6JpfFgPcEXvEf
X-Proofpoint-ORIG-GUID: loPb_i5bQyxhCyCymiA6JpfFgPcEXvEf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 7858bafffa9d..e2da3045d274 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10211,8 +10211,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 6418083901d4..84b5a7cdfe81 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -349,9 +349,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1230,11 +1231,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1982,9 +1984,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.35.1
