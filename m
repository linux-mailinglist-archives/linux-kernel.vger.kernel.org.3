Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F7357ADDE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbiGTCYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbiGTCXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:23:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DE66F7F8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:31 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0mq6j017914;
        Wed, 20 Jul 2022 02:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=HWUXcuL4AsWHQVehjtOBa4GFj4pClJGpa6SXsXP0Aro=;
 b=qz9QL4/f+TjB9UnfunGyIsItavNAsRyntsrg5z8q09xjMdKbDl/oVnqGUx7t7UyKDJaB
 f4iAHAjuxuHLBO7cnZsrOD06RLFBXbDn1YyrN+bxaFpWppP6quRnuwncBtB6xo+IoX7b
 OHZCORdOqdF0XquY2J//O+2qnH+DUIYVE/U9yNTyl8qZqiAVOJQEmN66py2gSWH9gG3T
 htIDvlrTI4rWDAjj3bhQ3EeaGLPo4d2W6KTwZzLISb7HE/XRMnguyD1KthpD0jvzO2nX
 qCiHJDEJAx1q9USKrVkC484fTRKbPUJSWQ2DngM921XXJYEtx+LWHkpn+lWj5TLS4Uo5 GQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:23 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1x7al007828;
        Wed, 20 Jul 2022 02:19:21 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k3w3uu-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:19:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlZUetKEKowSLZW0spnVtsetlbfnWNB9ZhyNk59eR6vvqXE/ZAlpoNWLZjQ5bCTP/nh7oXTcIsJabfSMzSc8f4qGuBMBk/m+0q2tHjXM8QqRSpWdSRbjFCFvlGdi2SQ0pf39aTaWNQmgITXCsM/0UzZ5c8gW8SgR/kvL1MmgEEeQK89RXaCaUZ8tTgn7Q7E9q8qYD+nk6Tvle/djsgLWSdaIadq2HrSKbKuLCncBedgskW2Q6bRdGeXVUl85x+B/pTrDTbvXnxCB3w2N8qWQknuwol6c8dbkeEfiZeRKpXDHMoexBUjBy0f4RdoVYLPcXd/IDbEOW4qDdGd2V6e7aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWUXcuL4AsWHQVehjtOBa4GFj4pClJGpa6SXsXP0Aro=;
 b=PR8gzzU19BjOKEigj75SOAMqS28+1WTxdA+QgN8QIm+gZVlZv3gV8wfUXUVCU/0fnVV9c8/6cDmA1MB/5owRuC29OPBQv1PwZIMXal2pm4+4lRK5EF07iqbfokkCeSjndYhC2TF7z0LUeUa6d9SdmDoEyVSCjDI6LGYLAWFzvud99CTg/8BLJ96pY+qxEJxNeS7oduYATFQCCCf3l3lap6EgSC/xwdQp9zBuzKpf/te/fPnWePFoOQspGfw9/lnw530FMSjDyYvIoi3IBh21VnE4YAdvxBix4OSMNQ9EItnFQvxC8DnhwCO9m/eEHXywW0qKk/F8u1zVpAvCsclUMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWUXcuL4AsWHQVehjtOBa4GFj4pClJGpa6SXsXP0Aro=;
 b=cBbdmH3cImOWXEjBVWWI/+f3r2TEAJqT+3VsIjeM2QmwFXwpVpW0na7Lvoy+OkUraFUvmacVt5wMglPd3HK97QaF3hQbKforMFUlE2ArWquwO9VTLmSC9NpbQbrm1uwrIjDIZfbXAI1hRi+5MzBSZzmcoiHmEH2XqDlZg0zRR+8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:19:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:19:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 68/69] mm/mmap: drop range_has_overlap() function
Thread-Topic: [PATCH v12 68/69] mm/mmap: drop range_has_overlap() function
Thread-Index: AQHYm97xnmHfoirxI0uqnFoF2QeH0g==
Date:   Wed, 20 Jul 2022 02:18:04 +0000
Message-ID: <20220720021727.17018-69-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5be3ea4-2aea-4c69-0680-08da69f6413b
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: imshtbBlmt9iF5Kn1xAc6mh0cDGDf2Wz1x24Fqh0nEVdBFHVyOmnU003zd2opYcP63OLFbLpVXG72krk2im8Xcy0Kscvhfkv2ZbFfB+Opj800QpEBqfcODVvXVYULVf0zRF0OL4pyuqQsfsV66JvjwSU9j53TI4YdLIgz/Ur87tD0snOm+7y6dcU79HwQhy1U68TgYOSYYLs11MTbHTuiWicigK+QeLCUGoxZreuqRz4TIOzCC01GqIo5/Lp0B5VcLf+GGirkcz74+3w0gwC4ow43+kD1kJGBCGUP27yGyvX2T1rSwasMffEWRmQ4rrUcSurVtL2RNtP72ZjRx8l/NfQOS/nQPqjm7Le/OlTNU5gCO23PKGkzGJMCoNjeICLHbmqmuA+tre26WFPLLQc+PsA4r7XdccW+KpZR5jxn4x0cEAzLI+PvbScAWx7OXP2Kj35bZ2WZ5A0ngY6PAIMNeOfuY64EqXHB6Mxf+szy9rfBmclnfKRL9K4B6xFhbmVcFyYQhyt34JCSrXETnSpPmPRTsxy/e9YGbc1zXLNKr0Zlm1bkyTUvOh1OgeQyOZIi/Uz1/c+E3mCTfWtKfUlXA9+E0HpTihLsXcW6nUttjgPzJDJPkDS4CbtKJ5EdR703kolb+5FOYid+YgNeWuDX8FG3QJWsUc89pzCvtr4pMGEbRDDTCUgm+ubuAM6X7TLGpfrLwpVjmcpBaIGXinVi4l10qayVkTyazQfcuXwxSc8kEpVFkfHtkEaf3JetkcbthGmdv5wUNDB7rEX/fpMCYh3VfyZ+NhYL6KqF9dy8z+tEiKLUhEYhw8yFKj2E9UnWzrio42vHic3bQYmXPLiQFq0TQxJ8dYXG1Hdc8x9zYAID7Gk1WYMu3CckIMyZ3D8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2xX6XEa14fsYw8A+TLL6JO9bRfrg5JEO98BodtAacxwGmgv3QZMfOtf9Rv?=
 =?iso-8859-1?Q?/DLIZkmCsZ4haJUb+vUFpbhSa5P4ue0+nZ4F+uZZEG/SiFwciSzjCt+JpR?=
 =?iso-8859-1?Q?x4i+YIctde2Y8GaSsaSuHhv7ebl02i3t2SHJXzU40c4ewsG522V+ocsCcq?=
 =?iso-8859-1?Q?U9hmTS+7oWSi8ZTLb2pYmzLI4HP6rUfnMlcPJ2GgdeDtAFEBRz0h/LRtKe?=
 =?iso-8859-1?Q?KHgNePUATN1j/D8fvQpuVx1gO36HEi3Oz763TwPey5Tx4tsBvLL2FnFzT9?=
 =?iso-8859-1?Q?u8XzYLkmOZMGFs9H8gYewCrPGXUyacsxMtYO5JJY9/WhbpFdh1GbZiFxlT?=
 =?iso-8859-1?Q?Z2oruoVtvRHlL/SHB99Fk1B+gSQCux+W7MK//K8FWXb0idKEpztTeWgKf/?=
 =?iso-8859-1?Q?LScZu6Qa5VlN4unnJL+m0wLJXp/kkjEArfMwCNoTy4ysweRHok0vanzVmM?=
 =?iso-8859-1?Q?4lFbCR5/lzmrnoyT8dh22OfWsgLrneTIOSGMXDPKmJeSUyMX8hGmAax66L?=
 =?iso-8859-1?Q?hdke+Hcfgcg9Vu2PsHlYLJ9eWLQ6g8cNAJWse8MTSJCg2u8zrCoRnXs53L?=
 =?iso-8859-1?Q?uVNnASIgmKs6o1xg7/VC10QTyt0RilRyPHN6XEqoC5HfnUUtdJMYb/SC78?=
 =?iso-8859-1?Q?HPOmpWXsycijVSD7rKZKUskUUVoLd+XNFECrhrg6MAmOXV8eIqvekh1qU/?=
 =?iso-8859-1?Q?lOfwviq/ltVSPN++TvbWjAFhFCuVMJHfEzmVV7GiIbV8F1qM/RRnUwJx/P?=
 =?iso-8859-1?Q?1yemsDPgEqSInxhFYKLY2HI/b3tntR9IWXbemyUnfKiRotFERSRWVIhM6b?=
 =?iso-8859-1?Q?M5fvxiczauqEUK7wlIHjZcOY6sxUQs2GRnSt3X9uUZ3Rgct+DwlrSfzLHB?=
 =?iso-8859-1?Q?9EQeptbHTkZ/cwrD+y53sfNtfH2lrfC+x+/G/Sx3wspKC8CXIiBe/xZig/?=
 =?iso-8859-1?Q?MdniO4WdPh/oWqNN0NNNX9s1ykfOQ39P/PLFxOfLzouGqnaaZqFayzaXZS?=
 =?iso-8859-1?Q?rgyeIGSCFcY4+78lWIHCygSFUawCH/QWtw6fzcBUbs6klvjxZ0/EZ8z3OL?=
 =?iso-8859-1?Q?wM4RYG3BzT1QM+OV+hCB7/OMZLcs9HR27HO7M7CPnsh9eWPUJtk4WEA8nR?=
 =?iso-8859-1?Q?+haOJ+6p9tDMueYVeI5S1pgUBrnYrIVZtkdoe0xIOGxLvwgmJSfb+waLc9?=
 =?iso-8859-1?Q?c3VKQBEkomvEppxMvB27sHWM2u8NPqw1Nc6oTvw//P9Dwejs2uv2qmafh8?=
 =?iso-8859-1?Q?IOHHV7nIaLRPWQ4JdiiNmfEQ7D6t4ylqq7Jlp4ssaOwKppuKkCAxN+hv7D?=
 =?iso-8859-1?Q?X0GDyJSM7lgoNnm6A8WSP6nNSCsYKWBLHuIYDEM/oEqRA1KzoRZTLEP0OY?=
 =?iso-8859-1?Q?NlqPN0KxgAwx8wMMgVj46N3rlg4x2j28s//aoQjIKOSYRyxZ1tS92q4Sy6?=
 =?iso-8859-1?Q?jzje/5bR9zxt/go506Vkqqn7AH2HpLpMgAd9RT/jcwdzIyw2H7XHplGYWu?=
 =?iso-8859-1?Q?xFPmHSd+1hIi3QOb3a991F+RtGgCwpX3CUaqZ2AiiWxIruYc/DzkuwBU2+?=
 =?iso-8859-1?Q?Xp9H5gKl1/E0ZBpbJa2AZUb5VbV4hTaTNYuADxrVBFOwbvImC9t8slcWcg?=
 =?iso-8859-1?Q?Usr63FrjKQbjZGhKYgonHDQLUYvBaAe0YrKMVCZBPRql6gyaIy6YsURA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5be3ea4-2aea-4c69-0680-08da69f6413b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:18:04.8359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nj5cwa/dnhhlSje6W1UDMyY1Xx7QJ4VRdAXxytSJ2dov60qO96kwyh2hd4NOm6zh32EbUMlumkepvEC0oTCRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: e_yG4i7k9kMh_AxN89Ewrk2XXGlozMaA
X-Proofpoint-ORIG-GUID: e_yG4i7k9kMh_AxN89Ewrk2XXGlozMaA
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Link: https://lkml.kernel.org/r/20220504011345.662299-53-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-69-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d5ee450578ed..a9ebe25c5b09 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -437,30 +437,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3221,11 +3197,10 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
 	unsigned long charged =3D vma_pages(vma);
=20
=20
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.35.1
