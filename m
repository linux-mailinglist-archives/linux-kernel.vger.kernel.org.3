Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E557ADC9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241249AbiGTCXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbiGTCVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4616EE82
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0JPuo031784;
        Wed, 20 Jul 2022 02:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EjydbCDeB5HpqcU6479zQpQNFL9mryyodE0dDbbTFv0=;
 b=kJhZznXlqAfxa+kFmGKKjsEuIt/l/4HeMNgyR9V5NOwARS7gx+XqE31LouMpqcehdGi2
 luVX5Y05k3tuJ6voUCJyeGNvkZhF4uVvzbmT2fLy4Goh5m2Vy1ez6xLztrrHD+smfuuD
 bTmblkZB4UEWMOLtqpBfKDmNVCc9Lazn5pnA/V/FAthW6qRWkFfcXhUc86K0XpFVDYwP
 ooejiebQWoPZlTVC5BbX6GSMtMjQcL2PP49+ARZy0nNLWEiMSBybf7spNRKCuG5OGcXj
 BYD05fs0Z6QAX3e8BTJNB2PlVpe1tMSB6LNLf4FtSZLdSkvzj6kE7l5z+jUQK2Tas4iV Zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtg6bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1QlMi039258;
        Wed, 20 Jul 2022 02:18:39 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k59311-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIz8HAlA6rceJjOJ0bYtCrDpyZyIei+9kDsON9xiTmn/QCDfdd7dNdLqzqb4azH/t3aVmHbtkn84QWDi7n5e3k+1fPdaIgw2hUnRCjw8nHV2TJOND4zhO2lMbUX9jP8BkEmJygXsu1O9f46OO+ALj3usH0JTAiKgLF8FO/5DBZxuikWM/Y9OjeA719whPlAWKDAQ029faBJxQ4Ue9ngvQtMFQ4ThH9LFIvD6AvwJySfKgm8fX+O2Y6tz8Rw6C7E41LzGBaAElSqiAzfBAjlAlwaTrjmwAY2de7mjkgCbQrFB340dDBkhpbbBj7tk7jM4E8wMLKvZSwHKX9s2LZZD/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjydbCDeB5HpqcU6479zQpQNFL9mryyodE0dDbbTFv0=;
 b=nAWm6M5pqfLTRup7Ui8qReMFqJjAaGDaEheVqqXTydw86BgxwB/b1zvP+sPN6qf8aci1BTDApKR194mfuNq36jEEBdIqWhngbScr2yCYaI2Jl5LcavOIISxfCh2VLeADJ2Nr+FqhrDbYujjlrVrhIELKV6dAg5b5gBAw526jaqciDIkSFUbxiL9Y46R9UaOsQhVVx0LeeO40/0+tGk293U5kgpD+ECLKjJzy3KMq3BQofdTTkM6ZcgCDv4/AewA2/YUQCfe4nMWWOufLA+I8E/6MTqmPtPkV7AQX/h66WoJhy6+hkHl7PR3axfzjnHgP5bl1gmAxt2ebTFOd8e0u/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjydbCDeB5HpqcU6479zQpQNFL9mryyodE0dDbbTFv0=;
 b=tnvoN40cf/8FGScxAk1/ViwBsBHoU8iV5miBiSNY9SYYo5nblbG1NGU0gB4Xt5xKpsusBYz2NFTGxVrRifIoybmwSEjQ6VChRHde+CZkQ9RXF7p2DtLnEF6i11CdyxALogx5dL4nUnb8nWT9hNpEJg+kecF6wRwS8SILWGP1wZA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 47/69] perf: use VMA iterator
Thread-Topic: [PATCH v12 47/69] perf: use VMA iterator
Thread-Index: AQHYm97uMC1XskqOqUeUyXxzns4sdA==
Date:   Wed, 20 Jul 2022 02:17:58 +0000
Message-ID: <20220720021727.17018-48-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25b2c81b-1240-4cb4-c936-08da69f62790
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vupuALZnVsIuc6Zuyl1nMg5mw8O5nGgeS27356pbzsHskdQF2Bn/UQNddZKRpO2o6VMfuA2naQsMvocbZ5cvwFVH5aKLIAh4ZZvt7z4JSjtFJklvgUZ/+JX3F/2NlJLZerR858gyngaqp8fbVRhk/QciA1FTCMbxy0hNKMcU38VBopgFY7sooV76hJ+VRCncItTlPnb3Yss+bwlp8RaG/3+60wQ9C097PDDH+p3o8FRAdvn936nIwr3B2TKSnyo7Bh00QMRb4eFDjZ4WemWE2vbGAYDrKT+j1VxIPYYJFy+bNHjU/8JwhBNhP84ntaCT+ZJMyeQw3WGKPMJ+M1X83d/dntovgFzjD1dkF9g2PluzcrDDgvvNwgxtcTGQ8e+TL2uPRJ1S/znl+5lGt6ToDlIVFUgPXVVeFmtY5XTLlDWJWEcZvavwPY2AWiYSegp9qfCiRL1QGpx/CgQk+zB0Ichccbay0Po4HSZNcwYTeNxlQPsG5NfP1rLoJVdDj4Kw4d8lxjC5VxTkYYHErP4D+t6XISA6vkfrrRJKf4DY6LWctM+2k0zvo5dPP0J6+nLQ9dvDNeCpf5Vaemz5ta/CytTY9IxXb1wpm1MoARRSKg0jBZSSs1/UM9C0C8DFBGFyPZ3L1DXodwTnCug4QjYKkhPSRxqWGWMmWaxZgn95qwzxXUO6ZvvrtioPSOgDV2eg7/o0ysRoM9Q1zgxiRqdNppia6ccyff60t7sX1UlzxeQ02mrII0Q7BLNVrj42LRlBPDWP+8aeUOIouRz0+f8FVQpRMcUV2zzlxBG3jPnJO36ny+Jc02Kg6A3MYBx3jN+SyFGWPtMazb4Fc7iiA10n7ZFdFcKUZxMbaIIxkjwMF52Ppq5pHHQ05nRH7MMArfYQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0wjP1+vmE0igAa4mgY70afq+rt2OCdfNJ+vLVuvBv+Br4Xapaup69xvEMp?=
 =?iso-8859-1?Q?v+5F68DnBzx/+UGaryYu0kT8WTmeC7d95EB6QNVqPPYr9KODuP0xEFgXSv?=
 =?iso-8859-1?Q?dxmskmvllHtV8RqGjsuokcQLyMJuku4jckbIHZ3YZQcc2JlSWb5PVJDpNt?=
 =?iso-8859-1?Q?YGueEt07bXzxfpXoDoUNpr0JGUaYf49b0YNEthqsuR2Wx9fszqVLB8/JOv?=
 =?iso-8859-1?Q?HPA0y0k8Xie1ryfyO6BXiKS/2Ed+uikzTx/qLTU5VBkHf7VhHz6Vvpdu6e?=
 =?iso-8859-1?Q?Ut62Qjq/mQZeuLzuTxEep+3tNvIkXC+6gA4evkkeVrNl+nuyccWAE9ex/A?=
 =?iso-8859-1?Q?XPjmtkdKlLatBKaLLbYFDO7hgOKJ8xYGBnzHbYRlUYPDFBgk9F+jQkHAYy?=
 =?iso-8859-1?Q?VF72Z+aZWAq3ylmGbQwjm2HydSrzrUu/F7qzvJvuSrv4jG2rp4HsbcORk2?=
 =?iso-8859-1?Q?xYAxNE/E6CUmd8dnmfiNuhjUzDpMXGfJ3L9SPFvZDPvYUDWM34JAX9X+np?=
 =?iso-8859-1?Q?gjiMqcY8xZdzPq3PS7TIwTZ2k4wyVvXWc1H3nVaR4quJJQwoJSqaqUD3Pu?=
 =?iso-8859-1?Q?fF8VgaAc0gL99GRFyy6ApgVy7Pku0meEkS7iBhUfaXzHBH6QBavetBTFr6?=
 =?iso-8859-1?Q?AAerY1m7oudanrHtYfnXiqF4SlPaAmQtPoaTWqUStCX8R7t/kJXUDvL35X?=
 =?iso-8859-1?Q?7BnUH2ZxALT/Ikw4078tld55+ZMFYlfTQM35FD7mJ+CDoASTAghhBMPPJj?=
 =?iso-8859-1?Q?gH7DLTGGLh4JJbLegSEupGDGVsVCH/PwZeczLiZWUnaQxMyQwycIlqajBN?=
 =?iso-8859-1?Q?TW+9DcXGgYy8Be4wZ0mZwfi20bJQzY5Tnsn5G4QMFADllbzukdevQo7/DI?=
 =?iso-8859-1?Q?Vi3CnEHZ8bBA463WMsBMLbqGfHuV6lndTyy+UHAnzvuzj0nqvNGrLi613l?=
 =?iso-8859-1?Q?ehkY/ZHMGUkrDrN7mz+Ctmv0ZxbQ+FPxcgkftqTrIL1yZ0n7Sil7YjV9AE?=
 =?iso-8859-1?Q?DRiAGrYQvhlQ1KmWvLMel1rWgVLwmM7+jBkAlpkKDqnv5qOYg54u18Tjou?=
 =?iso-8859-1?Q?4nRedLxv1vmb0Zv2qBntc+li4tLzmETqAKVJiay6rDnZq3RBrPsUm22Nvi?=
 =?iso-8859-1?Q?ciXLA4T/2K0Li3F97kw6/otOIlX/zMtspeKqqOryRLJlvMFVAbRAsVxmeL?=
 =?iso-8859-1?Q?7PCi1Ln71gumB7o72w1x6q8VaRDErBvlP3d1ImasMdfN8NpMfFwwxoXvWc?=
 =?iso-8859-1?Q?lpkzMzbFSzw2K8dhVs+Or7whZ2qUIU8BNNn5qZxB9G8Yld+IKyccj6pbAQ?=
 =?iso-8859-1?Q?KHhkRQhyY68c5+NbYPP/4tazERw3KTlSxJoiE1hEUd7nottmA6jRPhIRxR?=
 =?iso-8859-1?Q?cDjDXnXT9G2Hl01SVMGpZm3X8tLoUbx8OlG09m+JT1s+11sh90Yz9nXhXB?=
 =?iso-8859-1?Q?Zgig5SfJ/3GEV63mvPRR163EMQeKPpHAfG2iM+61dUnOFRtrpaxFkvP2ZX?=
 =?iso-8859-1?Q?h3s9YJwF5xdKZ1DuChEpzuGPTfvJNTKjwzNV5ZSHclPG2c1ZwxA7jq4Kvy?=
 =?iso-8859-1?Q?JyF3kJgVKlnfcV7ez4AkNNS73dQKrC+0dCQOJbEsqPgHwJdEXYfc9nrNpm?=
 =?iso-8859-1?Q?LlB0YyTpP+28f0ZE38nrBWSpil22l/WLtu5EJ+m1I2vwg2z+BBNzfe6w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b2c81b-1240-4cb4-c936-08da69f62790
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:58.8365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jf+OPhiJeAxrfdeYYaJg5aqocdLVqhFFmMFDLl8GsDRpiQxx0RZrAJf3zg2LwoLBaeW1l7R1rR4EuG2zykCRgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-GUID: ibix5kPhnUyqj9TFpZHLQJDvLNNJzzlt
X-Proofpoint-ORIG-GUID: ibix5kPhnUyqj9TFpZHLQJDvLNNJzzlt
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

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Link: https://lkml.kernel.org/r/20220504011345.662299-32-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-48-Liam.Howlett@orac=
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
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..61ad10862c21 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10210,8 +10210,9 @@ static void perf_addr_filter_apply(struct perf_addr=
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
index 2eaa327f8158..401bc2d24ce0 100644
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
@@ -1231,11 +1232,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
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
@@ -1983,9 +1985,10 @@ bool uprobe_deny_signal(void)
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
