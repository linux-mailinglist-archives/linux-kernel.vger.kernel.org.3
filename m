Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF39657ADB2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbiGTCTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbiGTCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:06 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AC2509E2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:00 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1WMOO016723;
        Wed, 20 Jul 2022 02:17:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gYalewqnYI3w4MZ+GOI6ZQ5Xq/4Qf8LhGEq2BaDftgA=;
 b=voTOnNy3IhVxqP2nYCR+eOqEx4QRE+d1fAsi/571Sw1QRT+93Mz7LXf3rc+xmyMOjlsG
 jl1yDf/06jK2y3ITEKeZFUNrGJxhxKIsEl8VWq9WpDqr8n4I5TuK8FoBdMekge8jOV8a
 E3Jc6YNHpoAv/lW/Pw8WFcuJTY92PWkkrMQjit+XmgVzazfNPrCuEie2yEQbrM+TIjBT
 +sQbGk7NVWkA9vjG6jtxoazhy9UsmdLskRLYIbnoRUEXdozUkrh5Kc26UL1vdAYP9Zn0
 KgAFF5Jjp0MkqO285zQVfFLnyypfKCP5p8q5qEl3MFL4VoD7evTKp6DqXkdRkZ+KaNWi Yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm42g541-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:51 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLKu022321;
        Wed, 20 Jul 2022 02:17:51 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fP+UIZ1o/nAZaYSktiHXLp0NaJ/EdUtU+D2mZeH25tdNQWs+QZcICokywFQq8TI/BoIUIe2Iz4k2OCf5kTdU9h9OBNtjPdvR3Mr5qyfR3QehTQIWl45EueBk9X6HcNQJm79YqVn7jNlFI7YxUCN11Lc3ImmihRjv+4P6UlepxBWy5hx4Ym/yPj6rcRAKtNKdxaem1DaSXpt05mOJDtD3c/IFGXuovSuKyfqQ+CuTLNdAw8di9fNOcd1fp6oAtQGrAEJ9K5K43sSgAzoqN+MxUKH+6bAozJ4geiI8rVRP2/VElHXDK8+QxbsEHetJrZ7R79YFtifKnjs8DWMpAtWfoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYalewqnYI3w4MZ+GOI6ZQ5Xq/4Qf8LhGEq2BaDftgA=;
 b=JkBhSAWYzwT4EdteNm+Y7fToNLY3/S/R/RP51w5vzoMK48b501iEatsc8Xx4gvErkVqbsCtSKnrOWyEswMOHCTEqZSHpxSWy0YZk1rGm+9TfWK2OY3tOV42l8Q1FBVRW+GPH5o+hz8+gU74JOwR0hsowsgyT+qDA57UpijOVusa5faCz8vHD/s1NZtn/0KJ85izkNv2IM6YyzRuC2s4xOWiAfNCjL/S1vFVKAafCGN66dfin8bqu6O4iaym5tPapEMkT6xYp6wn9bPzBcg36MrJf9F/PkQTr5gAZZ98qJjBvfL1O71fOA2PRZ3nDzTxqbDOYJlf+fcDWaNNK9qfTAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYalewqnYI3w4MZ+GOI6ZQ5Xq/4Qf8LhGEq2BaDftgA=;
 b=I+nYGuntQwtJ8tD6bDeCob3Gm393R1itfxp2H6QkcLxkWF9KVVuZs74Ew5abE9tNFtnb0Z+XZ6cD/elDpIQLCpQ22m8rnY3NTVwntsmEi0J7kC4rF7s9/MohTtwdQIRBrxYgBLyKbtUAAeMosmd0PZQnZw0tFo9Q4YMI03pf8h4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 08/69] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v12 08/69] mm: start tracking VMAs with maple tree
Thread-Index: AQHYm97mkLAkGOHngEOceAlHl5MTvQ==
Date:   Wed, 20 Jul 2022 02:17:45 +0000
Message-ID: <20220720021727.17018-9-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ae1d869-06af-4aee-f084-08da69f609bc
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XhClAlc8YVLn5mV4CF/OQBfhOFhynj35M22bLt3rA49RhwAdBhjt8pK+fCgvN3O8oescnPN0gqVQriznVMx293u1c9OIBSQzEWvAmp9bsK6ytJt1oBSpD9BBFOakz4g5HU0qFhZDM0Bt5ie7lXOhmZ9iGe+IiJTxRUzXy3t4Q71dWRvuIDIKQ6863yPuedHIqu5y9I1M/K4atdX/fd1/qsr+kjNiquZhyCs1QlJUvJ9UNuV0+z4cyAY9NVZ1gV7N5pA/enwMhgDply9muaPRPalI4k39PCiOyEvNsNhVbmvEAnsXr72Kb4RAPbCaEPemW+dWfV0H4aRXtISigWYspN/lqOHQP4RX5NeX8KwBpEttXSCHNl2wLVIXGc53FhwF/8FTpgyJMbsqp68n+Qc1qLUEJWqByfcU4jsUh0ZtpDID7BXZVviTwsNgrctkGAqxExL66JXdsbwmEiV572kSYik2jDKmY1f+oxvGDwqimRu6+CDSsKjjkSvszlr/UzWCMHk4KBzP9VlX8QW2hNY3i8gT+6vKnyfw6rluAzCbCSF49aSvvZH+Exsf5DuPeHBC15ajDMWgkyY0MixfSGPZ/Dd+K03PTRNjvnVVPz0rMEDsdqMIgeV9s9DQ49ohRKiRjrLHLsaiJCN0kBz/nbNPjKLdNVaLQp+oTeU4Yqd+sImBOI4eNmo3vl1545j/dF9nUJahqC9e2qfAZSZOkm6zEUkJ+oW3pr9NiLvc3xvHHmaYjjJfIB+FDtIK7OfejDo/Y6XzTAUUW3wE3mXsYkL4juQl4HM//nVnjITxJBktY5H0sNl+CN8OIJD9YyrSeFEJnKweLFJHHbyqS/9ml2ofk5zn/KZQPQg93k1tST0UfE4WMywCQpVGFuVfPMrz9tE7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(30864003)(4326008)(64756008)(66946007)(76116006)(186003)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XMx6G8UsvmX3J+8fBl42SiqI919kWSf3FgcOY+ipjtm7Z0xGXW/U9xBWMQ?=
 =?iso-8859-1?Q?miOPuvpdp1BwssJucCT/oYRfqMkDZVp3zuYvv+2gmuz7s3329rGN3PGuUO?=
 =?iso-8859-1?Q?myPhOY7qOspF/MnoKFx5mSCtE6FCJU08/VHeaBWbgDoFnEYdu0ShODi4/s?=
 =?iso-8859-1?Q?lzVjXyvQIbEUF4fYHV4pCA8pjW734o2ZRhHXOqTgp6z3KHF/ptjMCZOkeB?=
 =?iso-8859-1?Q?siDE/kHz8Ri6nBtd+4ZTXmaV/tffUijBZSJU0/6MBUr0MC1WOwQGbnlhx7?=
 =?iso-8859-1?Q?hlUiJ8FCZSYG0VHA2I67mzRU4TINFduy07gtllu8tUliZ38mHMEHltUEEU?=
 =?iso-8859-1?Q?pfJNOTU7KG+HKJHPbebZE7kUnwHWJCJKBdqedD7B1/U4HYrgkHVmDZRosF?=
 =?iso-8859-1?Q?GwGxQP/QGFQdmEnSi5XYagM36Zp4yhA8z7QPYjcmea3xYis85KlHIFb0pR?=
 =?iso-8859-1?Q?rltMYL0hXvTCHZ2kcWIR+YbDRq+CQ2/hGXlopWI/6WWWy0TeK2w5XAWW0C?=
 =?iso-8859-1?Q?jLGyyzfJrJKRLgcEQrxB8K2K7+gd9vTPT55Oia3ZG9ioREl54w/Jzn8vuz?=
 =?iso-8859-1?Q?e+iU5u8UPOhDxQ9ySDPPvCUcIsTsvTp+xzEfp1md7MMhcCfNKrGMAv+sMb?=
 =?iso-8859-1?Q?6XgIUg2+dUCv1BmlvL5yW+sPCB6Lhf8cp52WFXU6kllc95XHg0AhWNm+D5?=
 =?iso-8859-1?Q?tz+crpBZtSrDB1Z2L8EYcY2+F/yxad838fpPl8dkvNkfWO6WjHNL1uM4kD?=
 =?iso-8859-1?Q?/sKUYTwHjEjrfQ7SxAKB3pkPgK3U9kbh6DNl1aO9Of1aNqeTcV+oZGa3A9?=
 =?iso-8859-1?Q?WlC/Yt5vJh/PVIRwKF7B9kDJRfzivKwhMjjNvlpR9w0GafSfCfyqVFJQiE?=
 =?iso-8859-1?Q?VdTHz14aWtKUYIWOoHjTt7l73gi6pLQu4MIVOm2265CCvtgkAriHv1g+d6?=
 =?iso-8859-1?Q?mjx4ehDAb0vHHZh9Aqt2gL8iQ3TKL9NJhpRo/en5NXaPJxjIONIytxvCou?=
 =?iso-8859-1?Q?8cVSD8GMCMQKEGk0DPN2CCtm5fQwnbqCwpVNc/cZKsuGqj19UlC992r5FH?=
 =?iso-8859-1?Q?ZFDKsCi8/ugBfTZ9bKbwsUHW7S2SVODL75pP6SvCdy3bvHeTxHFVM2a1HW?=
 =?iso-8859-1?Q?sFfYjgPIzcFrfWOzxox4ljSBrSCMxTmdHBg8578B7KNjvpdEs71yqfCer7?=
 =?iso-8859-1?Q?BfQ7s3LiVt8vrNp/B2qaLtkOzxUx8QhAoAVfKP0RM9QZU/Gb9AIHYbbUiI?=
 =?iso-8859-1?Q?KeY5xnDMp6J4+mpcjuy3ZLJdkM+optYZjsmoF/Jw/aNo2Hdu5SG2KGCvJa?=
 =?iso-8859-1?Q?UrN3WHuTcjmnL0UX+EnWN7DPFvf2c90lRtS/y9SVWI80shCn3Xroc9eWB+?=
 =?iso-8859-1?Q?BSdhwRRLhyeP3C//oMPR8gF9FsNo1Lu00XgmeHMQZqrbJRVznd6Fk4Xiga?=
 =?iso-8859-1?Q?Mjso2D14UaqJwdj0RCX90jjfi22XoMzdusumGBmEsAfGsRBfBlUQDqUTEq?=
 =?iso-8859-1?Q?Q/eceYgoFoVt+U2qF4E6m4NZ11kac8UOSB7t+82lKnb5BlcK5fWa75UpRJ?=
 =?iso-8859-1?Q?l3qkxrX/QXBlMfqMgkhJ5eDYC+m/o0fragvmEH8BIlWq5+NLSIo4jrC/QL?=
 =?iso-8859-1?Q?lqvvefwduApfeI5cQXk9bFvO49mLNKjF4kG7d4RXEXTRNWgahZal+yyQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae1d869-06af-4aee-f084-08da69f609bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:45.9627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BmQk+eoMjqcMFxkwZvO6s3W/oj5NqtxkxcYvf60oOZ1aDgRy2sWsE3BMUGEifEIlXxrEC2N/wHy5RnV2ORP5lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: sQrZenJ2sK0jvThqUvQ_mHQrDakHVlV_
X-Proofpoint-GUID: sQrZenJ2sK0jvThqUvQ_mHQrDakHVlV_
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

Start tracking the VMAs with the new maple tree structure in parallel with
the rb_tree.  Add debug and trace events for maple tree operations and
duplicate the rb_tree that is created on forks into the maple tree.

The maple tree is added to the mm_struct including the mm_init struct,
added support in required mm/mmap functions, added tracking in kernel/fork
for process forking, and used to find the unmapped_area and checked
against what the rbtree finds.

This also moves the mmap_lock() in exit_mmap() since the oom reaper call
does walk the VMAs.  Otherwise lockdep will be unhappy if oom happens.

When splitting a vma fails due to allocations of the maple tree nodes,
the error path in __split_vma() calls new->vm_ops->close(new).  The page
accounting for hugetlb is actually in the close() operation,  so it
accounts for the removal of 1/2 of the VMA which was not adjusted.  This
results in a negative exit value.  To avoid the negative charge, set
vm_start =3D vm_end and vm_pgoff =3D 0.

There is also a potential accounting issue in special mappings from
insert_vm_struct() failing to allocate, so reverse the charge there in
the failure scenario.

Link: https://lkml.kernel.org/r/20220504010716.661115-10-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-9-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   5 +
 include/linux/mm_types.h    |   3 +
 include/trace/events/mmap.h |  73 ++++++++
 kernel/fork.c               |  20 +-
 mm/init-mm.c                |   2 +
 mm/mmap.c                   | 353 ++++++++++++++++++++++++++++++++----
 mm/nommu.c                  |  13 ++
 9 files changed, 435 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index 0c1154a1c403..71c54ad3868a 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -97,6 +97,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
 	.mm_rb          =3D RB_ROOT,
+	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock=
),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 860534bcfdac..1eddef189d68 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -58,6 +58,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVALID_T=
ABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
 	.mm_rb			=3D RB_ROOT,
+	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
 	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cf3d0d673f6b..adc963765d95 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2581,6 +2581,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* mmap.c */
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
@@ -2644,6 +2646,9 @@ extern struct vm_area_struct *copy_vma(struct vm_area=
_struct **,
 	bool *need_rmap_locks);
 extern void exit_mmap(struct mm_struct *);
=20
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas);
+
 static inline int check_data_rlimit(unsigned long rlim,
 				    unsigned long new,
 				    unsigned long start,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6b961a29bf26..e810aaca6c04 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -481,6 +482,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
@@ -676,6 +678,7 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
=20
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
 extern struct mm_struct init_mm;
=20
 /* Pointer magic because the dynamic array size confuses some compilers. *=
/
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..216de5f03621 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,79 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mas_szero,
+	TP_PROTO(struct maple_tree *mt, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mt, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct maple_tree *, mt)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mt		=3D mt;
+			__entry->start		=3D start;
+			__entry->end		=3D end;
+	),
+
+	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
+		  __entry->mt,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_store,
+	TP_PROTO(struct maple_tree *mt, struct vm_area_struct *vma),
+
+	TP_ARGS(mt, vma),
+
+	TP_STRUCT__entry(
+			__field(struct maple_tree *, mt)
+			__field(struct vm_area_struct *, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mt		=3D mt;
+			__entry->vma		=3D vma;
+			__entry->vm_start	=3D vma->vm_start;
+			__entry->vm_end		=3D vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
+		  __entry->mt, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(struct maple_tree *, mt)
+	),
+
+	TP_fast_assign(
+		       __entry->mm		=3D mm;
+		       __entry->mt		=3D &mm->mm_mt;
+	),
+
+	TP_printk("mt_mod %p, DESTROY\n",
+		  __entry->mt
+	)
+);
+
 #endif
=20
 /* This part must be outside protection */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..1840da0732f6 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -585,6 +585,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	int retval;
 	unsigned long charge;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	uprobe_start_dup_mmap();
 	if (mmap_write_lock_killable(oldmm)) {
@@ -614,6 +615,10 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
 	khugepaged_fork(mm, oldmm);
=20
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
 	prev =3D NULL;
 	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
 		struct file *file;
@@ -629,7 +634,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		 */
 		if (fatal_signal_pending(current)) {
 			retval =3D -EINTR;
-			goto out;
+			goto loop_out;
 		}
 		if (mpnt->vm_flags & VM_ACCOUNT) {
 			unsigned long len =3D vma_pages(mpnt);
@@ -694,6 +699,11 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		rb_link =3D &tmp->vm_rb.rb_right;
 		rb_parent =3D &tmp->vm_rb;
=20
+		/* Link the vma into the MT */
+		mas.index =3D tmp->vm_start;
+		mas.last =3D tmp->vm_end - 1;
+		mas_store(&mas, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval =3D copy_page_range(tmp, mpnt);
@@ -702,10 +712,12 @@ static __latent_entropy int dup_mmap(struct mm_struct=
 *mm,
 			tmp->vm_ops->open(tmp);
=20
 		if (retval)
-			goto out;
+			goto loop_out;
 	}
 	/* a new mm has just been created */
 	retval =3D arch_dup_mmap(oldmm, mm);
+loop_out:
+	mas_destroy(&mas);
 out:
 	mmap_write_unlock(mm);
 	flush_tlb_mm(oldmm);
@@ -721,7 +733,7 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_nomem:
 	retval =3D -ENOMEM;
 	vm_unacct_memory(charge);
-	goto out;
+	goto loop_out;
 }
=20
 static inline int mm_alloc_pgd(struct mm_struct *mm)
@@ -1111,6 +1123,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
+	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index fbe7844d0912..b912b0f2eced 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -29,6 +30,7 @@
  */
 struct mm_struct init_mm =3D {
 	.mm_rb		=3D RB_ROOT,
+	.mm_mt		=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, init_mm.mmap_lock),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
 	.mm_count	=3D ATOMIC_INIT(1),
diff --git a/mm/mmap.c b/mm/mmap.c
index 61e6135c54ef..0e202b16caf3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -381,7 +381,71 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
=20
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt =3D &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+
+	mt_validate(&mm->mm_mt);
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma !=3D vma_mt) ||
+		    (vma->vm_start !=3D vma_mt->vm_start) ||
+		    (vma->vm_end !=3D vma_mt->vm_end) ||
+		    (vma->vm_start !=3D mas.index) ||
+		    (vma->vm_end - 1 !=3D mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %p %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %p %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %p %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next =3D %p %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end !=3D mas.last + 1) {
+				pr_err("vma: %p vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
+			if (vma_mt->vm_start !=3D mas.index) {
+				pr_err("vma: %p vma_mt %p %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
+		}
+		VM_BUG_ON(vma !=3D vma_mt);
+		vma =3D vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+}
+#else
+#define validate_mm_mt(root) do { } while (0)
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
 {
 	struct rb_node *nd;
@@ -436,6 +500,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -680,6 +745,56 @@ static void __vma_link_file(struct vm_area_struct *vma=
)
 	}
 }
=20
+/*
+ * vma_mas_store() - Store a VMA in the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
+ * walked to the correct location.
+ *
+ * Note: the end address is inclusive in the maple tree.
+ */
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	trace_vma_store(mas->tree, vma);
+	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_prealloc(mas, vma);
+}
+
+/*
+ * vma_mas_remove() - Remove a VMA from the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
+ * been established and points to the correct location.
+ * Note: the end address is inclusive in the maple tree.
+ */
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	trace_vma_mas_szero(mas->tree, vma->vm_start, vma->vm_end - 1);
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_store_prealloc(mas, NULL);
+}
+
+/*
+ * vma_mas_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ */
+static inline void vma_mas_szero(struct ma_state *mas, unsigned long start=
,
+				unsigned long end)
+{
+	trace_vma_mas_szero(mas->tree, start, end - 1);
+	mas_set_range(mas, start, end - 1);
+	mas_store_prealloc(mas, NULL);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
@@ -689,17 +804,22 @@ __vma_link(struct mm_struct *mm, struct vm_area_struc=
t *vma,
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
+static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev, struct rb_node **rb_link,
 			struct rb_node *rb_parent)
 {
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping =3D NULL;
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	if (vma->vm_file) {
 		mapping =3D vma->vm_file->f_mapping;
 		i_mmap_lock_write(mapping);
 	}
=20
+	vma_mas_store(vma, &mas);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	__vma_link_file(vma);
=20
@@ -708,13 +828,15 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma,
=20
 	mm->map_count++;
 	validate_mm(mm);
+	return 0;
 }
=20
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and rbtree.  It has already been inserted into the interval t=
ree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
+static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
+			       struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
@@ -722,7 +844,10 @@ static void __insert_vm_struct(struct mm_struct *mm, s=
truct vm_area_struct *vma)
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		BUG();
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+
+	vma_mas_store(vma, mas);
+	__vma_link_list(mm, vma, prev);
+	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	mm->map_count++;
 }
=20
@@ -749,6 +874,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 {
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *next =3D vma->vm_next, *orig_vma =3D vma;
+	struct vm_area_struct *next_next;
 	struct address_space *mapping =3D NULL;
 	struct rb_root_cached *root =3D NULL;
 	struct anon_vma *anon_vma =3D NULL;
@@ -756,10 +882,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	bool start_changed =3D false, end_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
-	if (next && !insert) {
-		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	validate_mm(mm);
+	validate_mm_mt(mm);
=20
+	if (next && !insert) {
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -788,10 +917,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 				 * remove_next =3D=3D 1 is case 1 or 7.
 				 */
 				remove_next =3D 1 + (end > next->vm_end);
+				if (remove_next =3D=3D 2)
+					next_next =3D find_vma(mm, next->vm_end);
+
 				VM_WARN_ON(remove_next =3D=3D 2 &&
 					   end !=3D next->vm_next->vm_end);
-				/* trim end to next, for case 6 first pass */
-				end =3D next->vm_end;
 			}
=20
 			exporter =3D next;
@@ -839,9 +969,11 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 				return error;
 		}
 	}
-again:
-	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
+	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
 	if (file) {
 		mapping =3D file->f_mapping;
 		root =3D &mapping->i_mmap;
@@ -882,17 +1014,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
+		unsigned long old_start =3D vma->vm_start;
 		vma->vm_start =3D start;
+		if (old_start < start)
+			vma_mas_szero(&mas, old_start, start);
 		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
+		unsigned long old_end =3D vma->vm_end;
 		vma->vm_end =3D end;
+		if (old_end > end)
+			vma_mas_szero(&mas, end, old_end);
 		end_changed =3D true;
 	}
+
+	if (end_changed || start_changed)
+		vma_mas_store(vma, &mas);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_mas_store(next, &mas);
 	}
=20
 	if (file) {
@@ -906,10 +1049,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
-		if (remove_next !=3D 3)
+		if (remove_next !=3D 3) {
 			__vma_unlink(mm, next, next);
-		else
+			if (remove_next =3D=3D 2)
+				__vma_unlink(mm, next_next, next_next);
+		} else {
 			/*
 			 * vma is not before next if they've been
 			 * swapped.
@@ -920,15 +1067,19 @@ int __vma_adjust(struct vm_area_struct *vma, unsigne=
d long start,
 			 * "vma").
 			 */
 			__vma_unlink(mm, next, vma);
-		if (file)
+		}
+		if (file) {
 			__remove_shared_vm_struct(next, file, mapping);
+			if (remove_next =3D=3D 2)
+				__remove_shared_vm_struct(next_next, file, mapping);
+		}
 	} else if (insert) {
 		/*
 		 * split_vma has split insert from vma, and needs
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, insert);
+		__insert_vm_struct(mm, &mas, insert);
 	} else {
 		if (start_changed)
 			vma_gap_update(vma);
@@ -956,6 +1107,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 	}
=20
 	if (remove_next) {
+again:
 		if (file) {
 			uprobe_munmap(next, next->vm_start, next->vm_end);
 			fput(file);
@@ -977,7 +1129,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 			 * "next->vm_prev->vm_end" changed and the
 			 * "vma->vm_next" gap must be updated.
 			 */
-			next =3D vma->vm_next;
+			next =3D next_next;
 		} else {
 			/*
 			 * For the scope of the comment "next" and
@@ -993,7 +1145,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		}
 		if (remove_next =3D=3D 2) {
 			remove_next =3D 1;
-			end =3D next->vm_end;
 			goto again;
 		}
 		else if (next)
@@ -1025,6 +1176,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1178,6 +1330,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1253,6 +1406,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1732,6 +1886,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1846,7 +2001,13 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
=20
 	/*
 	 * vma_merge() calls khugepaged_enter_vma() either, the below
@@ -1886,6 +2047,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1902,6 +2064,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1918,12 +2081,19 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+			   length);
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -2005,20 +2175,31 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
=20
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap !=3D gap_start);
 	return gap_start;
 }
=20
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+		   length);
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2104,6 +2285,32 @@ static unsigned long unmapped_area_topdown(struct vm=
_unmapped_area_info *info)
=20
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap !=3D gap_end) {
+		pr_err("%s: %p Gap was found: mt %lu gap_end %lu\n", __func__,
+		       mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+		       info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+		       mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+		       info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu =3D> %p (%p)\n", mas.index,
+		       find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv =3D mm->mmap;
+
+			while (dv) {
+				pr_err("vma %p %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv =3D dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap !=3D gap_end);
+	}
+
 	return gap_end;
 }
=20
@@ -2326,7 +2533,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2399,7 +2605,9 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	struct vm_area_struct *next;
 	unsigned long gap_addr;
 	int error =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2423,9 +2631,14 @@ int expand_upwards(struct vm_area_struct *vma, unsig=
ned long address)
 		/* Check that both stack segments have the same anon_vma? */
 	}
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* We must make sure the anon_vma is allocated. */
-	if (unlikely(anon_vma_prepare(vma)))
+	if (unlikely(anon_vma_prepare(vma))) {
+		mas_destroy(&mas);
 		return -ENOMEM;
+	}
=20
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
@@ -2462,6 +2675,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
+				/* Overwrite old entry in mtree. */
+				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
 				if (vma->vm_next)
 					vma_gap_update(vma->vm_next);
@@ -2476,6 +2691,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
+	mas_destroy(&mas);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2489,7 +2706,9 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct *prev;
 	int error =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2503,9 +2722,14 @@ int expand_downwards(struct vm_area_struct *vma,
 			return -ENOMEM;
 	}
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* We must make sure the anon_vma is allocated. */
-	if (unlikely(anon_vma_prepare(vma)))
+	if (unlikely(anon_vma_prepare(vma))) {
+		mas_destroy(&mas);
 		return -ENOMEM;
+	}
=20
 	/*
 	 * vma->vm_start/vm_end cannot change under us because the caller
@@ -2543,6 +2767,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_mas_store(vma, &mas);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2554,6 +2780,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma(vma, vma->vm_flags);
 	validate_mm(mm);
+	mas_destroy(&mas);
 	return error;
 }
=20
@@ -2676,14 +2903,17 @@ static void unmap_region(struct mm_struct *mm,
  * vma list as we go..
  */
 static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct vm_area_struct *vm=
a,
-	struct vm_area_struct *prev, unsigned long end)
+detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
+	struct vm_area_struct *vma, struct vm_area_struct *prev,
+	unsigned long end)
 {
 	struct vm_area_struct **insertion_point;
 	struct vm_area_struct *tail_vma =3D NULL;
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	mas_set_range(mas, vma->vm_start, end - 1);
+	mas_store_prealloc(mas, NULL);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		if (vma->vm_flags & VM_LOCKED)
@@ -2724,6 +2954,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2766,6 +2997,9 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	if (!err)
 		return 0;
=20
+	/* Avoid vm accounting in close() operation */
+	new->vm_start =3D new->vm_end;
+	new->vm_pgoff =3D 0;
 	/* Clean everything up if vma_adjust failed. */
 	if (new->vm_ops && new->vm_ops->close)
 		new->vm_ops->close(new);
@@ -2776,6 +3010,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -2802,6 +3037,8 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 {
 	unsigned long end;
 	struct vm_area_struct *vma, *prev, *last;
+	int error =3D -ENOMEM;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
 		return -EINVAL;
@@ -2822,6 +3059,9 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	vma =3D find_vma_intersection(mm, start, end);
 	if (!vma)
 		return 0;
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
 	prev =3D vma->vm_prev;
=20
 	/*
@@ -2832,7 +3072,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	 * places tmp vma above, and higher split_vma places tmp vma below.
 	 */
 	if (start > vma->vm_start) {
-		int error;
=20
 		/*
 		 * Make sure that map_count on return from munmap() will
@@ -2840,20 +3079,20 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * its limit temporarily, to help free resources as expected.
 		 */
 		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
-			return -ENOMEM;
+			goto map_count_exceeded;
=20
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
-			return error;
+			goto split_failed;
 		prev =3D vma;
 	}
=20
 	/* Does it split the last one? */
 	last =3D find_vma(mm, end);
 	if (last && end > last->vm_start) {
-		int error =3D __split_vma(mm, last, end, 1);
+		error =3D __split_vma(mm, last, end, 1);
 		if (error)
-			return error;
+			goto split_failed;
 	}
 	vma =3D vma_next(mm, prev);
=20
@@ -2867,13 +3106,13 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
 		if (error)
-			return error;
+			goto userfaultfd_error;
 	}
=20
 	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, vma, prev, end))
+	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
 		downgrade =3D false;
=20
 	if (downgrade)
@@ -2885,6 +3124,12 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	remove_vma_list(mm, vma);
=20
 	return downgrade ? 1 : 0;
+
+map_count_exceeded:
+split_failed:
+userfaultfd_error:
+	mas_destroy(&mas);
+	return error;
 }
=20
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
@@ -3024,6 +3269,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3073,7 +3319,9 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	vma->vm_pgoff =3D pgoff;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent))
+		goto no_vma_link;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3081,7 +3329,12 @@ static int do_brk_flags(unsigned long addr, unsigned=
 long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
+
+no_vma_link:
+	vm_area_free(vma);
+	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
@@ -3170,6 +3423,9 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D remove_vma(vma);
 		cond_resched();
 	}
+
+	trace_exit_mmap(mm);
+	__mt_destroy(&mm->mm_mt);
 	mm->mmap =3D NULL;
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
@@ -3183,12 +3439,30 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
m_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start =3D vma->vm_start;
+	struct vm_area_struct *overlap =3D NULL;
+	unsigned long charged =3D vma_pages(vma);
=20
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
+
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
+
+	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
-	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
+	     security_vm_enough_memory_mm(mm, charged))
 		return -ENOMEM;
=20
 	/*
@@ -3208,7 +3482,11 @@ int insert_vm_struct(struct mm_struct *mm, struct vm=
_area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent)) {
+		vm_unacct_memory(charged);
+		return -ENOMEM;
+	}
+
 	return 0;
 }
=20
@@ -3226,7 +3504,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
+	unsigned long index =3D addr;
=20
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3238,6 +3518,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
@@ -3281,6 +3563,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3288,6 +3571,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3424,6 +3708,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3446,10 +3731,12 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
+	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
diff --git a/mm/nommu.c b/mm/nommu.c
index 9d7afc2d959e..5af0b050eba8 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -545,6 +545,19 @@ static void put_nommu_region(struct vm_region *region)
 	__put_nommu_region(region);
 }
=20
+void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	mas_set_range(mas, vma->vm_start, vma->vm_end - 1);
+	mas_store_prealloc(mas, vma);
+}
+
+void vma_mas_remove(struct vm_area_struct *vma, struct ma_state *mas)
+{
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_store_prealloc(mas, NULL);
+}
+
 /*
  * add a VMA into a process's mm_struct in the appropriate place in the li=
st
  * and tree and add to the address space's page tree also if not an anonym=
ous
--=20
2.35.1
