Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE40577342
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbiGQCrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbiGQCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:57 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546701A049
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8glU009607;
        Sun, 17 Jul 2022 02:46:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CwME305LRq4G077O7h1TcGNIrmWe5uIjM84VsVLr1XE=;
 b=uD1FJvQVVd6tw5XUUw9N/i3J6Ee84VjLL34tON1IDH4l4d3rZRqaIB/OUOsUgM279qoq
 /p/GlkWmpFMJNpnAtxqVKCqTQVgoSTW4pJrg8crrdHs90H1XA8mrKbeGcSLci4NMQPK9
 n3NyFYiGNQz7Yrr+f4u5qY6zbUewgQtyEOQti7hIhQutiIvo0QB7hhw1Vxt6ssAAaHRW
 Okfn4LYqaC438JGSmq0iBkhNtENMPvI4bIycMPv82EmadfDkgxygYkbOB9wT+lhV4bR+
 GS9DxB5AD8ImwpouvsA4gAr3mAUHkjrcSRSp+YreXkMdaagYNFUBa0T9jxjg8g3yuHlD Lw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0yn2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImY036151;
        Sun, 17 Jul 2022 02:46:47 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLYJZ4HBOuL5SI8Zm/8eQCTvETFDnXmUetzNwo4qU8HrL+67kPHwaEI8Y9CNNXZCCDZi6HczIySUeiXTxW7wexl1Z35+Foo3wF6tajO/I2w0mVeEra5F/8jcaGH7isz2isWHYhpLcp6zYct5fr9fpejTHYyevX6TlxzlyrQDAcul9MKWk7oD+dC+m1XjFndPURLfzm5ZQBNhCw9zMqeUc5qsrmLBbSIQOWv9R0xjMmwPj2zOtMd3cWktrOX34d0xy6FqSA7851+f/Jbh9FcusAYTrsMIxtAV2hiIdAITcuLwR/RFnbDmoIRR2LpiYZV8k/EdERWyCg7pMmn5Kt96lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwME305LRq4G077O7h1TcGNIrmWe5uIjM84VsVLr1XE=;
 b=VgFRvhAWhDEfiVR5nrbS8o5ddHR44Fz28BJ4Z6nqS3+flSlyFeTEwfdODOk56no1COFmfo6NAWdxmHfx49RwvBuUnWKSf9W9I6Bx3Zq3ai+m56bClalPTdOPBPTpVdlaj85CwPu5W1iip5oyU94OacJkstgCyBQVYYdJhtB6hEHlq2s6gtmFXXNeuvGsqGVx2nzW82nUq972Ech+HP225SzPT0xjwDHBe5q9s8K/5PGD2ijDdcq5H2ZbsT6rTt0b+77Ym0z9xq2uEfKFUqhgnb3qiNZBqL4y7CzT7H4KCIev7SanqNbOvLeKemwPvA3D06a7CTZ/z5t1l92u9XO2fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwME305LRq4G077O7h1TcGNIrmWe5uIjM84VsVLr1XE=;
 b=BwJI+aBQBFyajF7Mxvquok6B5OlxheeEnKp3Te41omFg6P6H+U5k40ACtBqtShVBDEgOA9RZbWsxTIzFgqkJmBSGyrWE03MJRPOn45SMPyqnmk9w94p0ysnDXeoerCwJUA+A5gRmEdHvhKM/EJwNu4Yrkt0RKwQ0y1PdrPECNWo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 16/69] proc: remove VMA rbtree use from nommu
Thread-Topic: [PATCH v11 16/69] proc: remove VMA rbtree use from nommu
Thread-Index: AQHYmYdxUpNeS4XFt0qZx6cjdA4eOw==
Date:   Sun, 17 Jul 2022 02:46:41 +0000
Message-ID: <20220717024615.2106835-17-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e1e1e7c-fb09-4aa3-b570-08da679e9614
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5gnmu+UsxD0gjQtKHYACsmx3UY3z2VnPSxILRFlSMWIJNmKxKQSmbhXuR2T1uYhBHsgOgT50+Jrc8viF6rf1dD90t5B9z7mX/Z+5D/RvGHKO8iGwzUa6BVY79Vaqv2kfh/KM6UBwl+6hX6gYJoTDbPufamzqvK4rSCbnEZlmT0Cwjh8V8ewXAx5rSeEh9N0fn1kI5DXCTRYJiu55buEmQhjT5bY874S4z5tYclLqrAdMpYpQTGt3GiAm7NZCfRol4B3S0gmAGWd5gd5nITytZU2D87Ch+sX0QUaZl9MYpLFNO4iNKZZjFLWJDe6qB1lpU9uMY2oN4NmUfYTe0zLa1epCNAI3TG6/Lp4OfEVqN4XblXZwN469+pWcwfmvFNnCkoiAizvWxomxaeBa1G0zxHj3iOukgr8hYaQVI94YAX1Z20j8M5bIaRPkdOZNOZz726TUY/xyoZcmQHZufGZqxe+Oaw9bSEbnK4U+Rt+zlxUtKJ4sR6Hv9jvJhs4b789HkYL6QBx1CV/I27kjIogrjIalhVQ3EQj24P/NCqfxWCTLtfvoJVU4fMgUTUZbbyHnYKqwcCMfM9NmbLucAhbm6xn1r9iJvs4Yf45Dz90sKutESMKw+068YxT/vInGd6bcIvUp1LuGaTaMTRm+mBnOwYw1/mYxRTy9pE63adKIfKanXOJQT3b9C8t/wkbICgJqb5KGCV/Ez5WZCCt7bWRG7lo49z83vPmV3WeFoBGFdlD6a8dMu4bNKdgYXjrOWkNMQpkc8MCzkGrWR6i5azbVa/IKLklqK6gzDFX7g3b5bwvOh45taVpskpN7qENtr42ObpiplQpRJeM8zrB1Iq6Do97VVijgIvm/UoXQjaRW4b0hXIuqocMfzaX5t/fMibecXqCk+o8usyoa6WsHmSYwCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?yD6lloMe+FwGdLNC5upEjjk7uV+QmUeqe5jgqRk3IJ3gWD02GfXRAukcK2?=
 =?iso-8859-1?Q?gPrPyoUMkkaWdu6aP1uB7XFhL53IahcmcFotNHQBU/AFSOTfTIbJgp7zs1?=
 =?iso-8859-1?Q?H7tqK/tboMOuGFqx2L4p41DD8aZyBHo2kIQsWsFBYdl0ZkEH26vH7s42nA?=
 =?iso-8859-1?Q?j5WQlW9lF/duL7uqe+qy1jBbMLQNxPc0LqPh0oivVmltfUckxgBd6Ny7oC?=
 =?iso-8859-1?Q?zfqrGNoueZxacXCEigXeGHT7uHtVKOGd3Zym0norYXBhSXRAmG0Uuqm3H1?=
 =?iso-8859-1?Q?l2/fdrUtOeuzw95ae4yTm/h3g0IstYmxpOqOQ29bbN8hpOhwzOuGhcJhSd?=
 =?iso-8859-1?Q?ctEScOPK8B35cVsaIcON1T2JXnX/4Q+zsA/InqS58HzfgHIwCsbKGOAYZH?=
 =?iso-8859-1?Q?yz0vVpoaELFu3eOsKypx7cS/40mJuOW7lslLv2kDusPm4Hxc8WNoS/IdcB?=
 =?iso-8859-1?Q?zMMUBZx23AHVWKiSAuZpdxWQxsR0/48nWcw+nLLqkZo+j/0+sRac0z1j4V?=
 =?iso-8859-1?Q?RbC6+xsRG2ire458mvFSi6A63Y6Ox/lVzHpVbUixYSWG2EJOcslbcFi4f2?=
 =?iso-8859-1?Q?0AELUFxxTTQU9tFTIbGZUOegIJO0TeUMVo/RjsKDmFAtt/J198TyJcYard?=
 =?iso-8859-1?Q?CHFBQzqwIiXyKE173vWp/Okbt2XF13/wmBdzrOOGw1UiFF0QKEox4uDZgh?=
 =?iso-8859-1?Q?YDj78vJbB2qTQ382KuZHsOk03ckc5hgbYnqSkewCA6/aLnYasPPUtFhEMe?=
 =?iso-8859-1?Q?3oP51u/fjgu0C+rfgUafkTcjd+8PyZv9SpThnPsmWQbd1uYuVrAmBYe0we?=
 =?iso-8859-1?Q?Kjs3G58rnqOAexDRq2+jp+gvhn4F5HNVljjW2DmT6qbHXxC06UIRKP2dr6?=
 =?iso-8859-1?Q?m5axR9MqRT63u5UwzC24i9YTabHK4rHZrMuCD+C5ojZEb0+6T6oP8UAIZc?=
 =?iso-8859-1?Q?ip8TJnLAicVfGHQBdU9uwzT+civK9WgIfj8dAPYzYbiC2luxqFXL9JUXg4?=
 =?iso-8859-1?Q?m29IoyMa+o8u29HDNU6xIrFkt6G9K6XPEuamBz4pf3Cc8t3Q3PFvKrGxSM?=
 =?iso-8859-1?Q?YFYCmUe3fAaT+Cd9O4JkgXn7luTsLvbQSLSJ9YsYu2/CZjSs3CemQJY/wK?=
 =?iso-8859-1?Q?CID16Len7EA3bazTAPkuEUGSy4WFKQ1UK2/gFzzft0xe0mDQ3+PsS6G/FC?=
 =?iso-8859-1?Q?nHxKV9Lr3u8kUReQT3P/9lSytd/s1x+iM5JZ+BTcite91U6TaLgOhIz2lQ?=
 =?iso-8859-1?Q?/+pwsehYE/Qy3CCmB5Y3zpr8O3aO0PIJBQjgfR6YbwHyTSCEEakY6V9Olt?=
 =?iso-8859-1?Q?aB9+vABXyiimxNFZPPxjSSvdz2yvNucVpnf2WhM8+LJROwkKbW1Ho65+VI?=
 =?iso-8859-1?Q?L5uS+n8u3bcNjHWO2+NXoncMluvrY0hed3SPqAE4gFZyen2Yh/6+wt0Dx4?=
 =?iso-8859-1?Q?ScsKQL7GI6kq0hjvB5LEUxSggeIGvJwsDYlX9fLN6vgfEmMi9uzuMZIuXk?=
 =?iso-8859-1?Q?hRwTAxzLNJsVAzij6/FQzxVCT+ZkCqXhPwCrXseOY48Z0z1FPm+wlWFz7c?=
 =?iso-8859-1?Q?EPLdTWhE9Wld5BJ4rsWNLmuav9KUU/tcMU5XuPjoeA7nJtIzUFTKTzUmk1?=
 =?iso-8859-1?Q?aCFlAOTdxrlfGMvmOofs92dJroMdaRRL9ETTngchJ/R6rTtH14gFwAiw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e1e1e7c-fb09-4aa3-b570-08da679e9614
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:42.0062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnRk7Cxke/wFVr2HQmAWDb/mTzoEdKDBC6Z+JixzNP4uxT4PPwVuoV5K3yNqvKGPhOsSOYW/5Mp+ECVkF/zhtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: lOPuddVkzpVzQ_5MZMZVSqgoOq4QnR18
X-Proofpoint-ORIG-GUID: lOPuddVkzpVzQ_5MZMZVSqgoOq4QnR18
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

These users of the rbtree should probably have been walks of the linked
list, but convert them to use walks of the maple tree.

Link: https://lkml.kernel.org/r/20220504011345.662299-1-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-17-Liam.Howlett@orac=
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
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.35.1
