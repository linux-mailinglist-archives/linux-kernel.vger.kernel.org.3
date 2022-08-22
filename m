Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2BC59C22C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiHVPHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbiHVPF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:05:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6C02EE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkVK3022015;
        Mon, 22 Aug 2022 15:05:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gyfR7Zm+huyR++rHptyL++G6E5plhrkpsPGQcLXyDE4=;
 b=toxt9dpa0ecDfphrmQR4A87Ft9SHjA7zBNy6M8yFz9xqF2SfBVuU1KvSjdM/xDJOjMfx
 GYZIWP4537mVQb0nIKUCy+i9dfiNgtIUspieL14pEe3UokjtDrhCjIBpNs8HaTX4T3/3
 omfzao6sgHDQ7opkKDsaY1uWIcu2abtTjTzH9MwpzuiYVRJ7f4WoP8hvEjvipX/8GHEr
 sdVI9TwwgDZ2p/yxL7fLBs+Wd4DFa4lozq1PaqvwnrER3SmLhqGVPWb57+VDit/jSx1z
 M7Jhqs1ZuaDSIE7ReTTRWrzXYIVJyVsrtahib+QWWeeoGqOd2s8HHo30yeD/nxQkkkMj aw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:18 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4MJC035319;
        Mon, 22 Aug 2022 15:05:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1ty4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWe/tkhcCLprY0aIvDCma03jCRktuqSgToyVqwk/yO0jCBpR4HjzItJ+Act/WsgWBlntByocPU7y8+43EYX3K5r/ttfwnINrKuNG5H1qOWWF2xypRMi6xXGPJUTv6J15g4lGE2GNNf4sRKZKKQA606w+uBzoCytes5Qlcoh1Hyb+f+AA7gvmn1LbTri4KUizSgE9OosUGqDHqo2zK0iPmgOhsKrSo2055wUrSFvvfuc7NZxCdue8mWLcmK98m+vp5cqECKRaUAqLyw3Kt+hnLR6lIiSUGHH3cMinTP7D8RoYn3LzMviswQ47oHXH0BXXNVkx1DtV9ejrdx+5OEiQcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyfR7Zm+huyR++rHptyL++G6E5plhrkpsPGQcLXyDE4=;
 b=LbLInoePTFShOTkCAJbkWJtAOU/MtntC49WvrDDWJ+P1syne4s8BXYZNxEC22eWWrDX10tlXZzI6Kvcc9Yh8tFGO1NJDvFCV7YgeNQ/o4Z3SKQewWxvD29Ax10GpA5FdaQlZ4LGp4CATjVtU9bskq6FKFn02MHxhMwqe7yUvUc3CchPPA02UaUWTvdQs5nDUdbbbSVzc9vrESz6f5SMtUns0iR3vS5XZtJ9ZATrvJrXiOGS5H/E8gDB60pgCUhwfhFpetRHy4+ERrLeaIVsJZY68rDXMue/zcMofcYY3ah1as9YSY/YGfvtmU/Z9jNqCq5ouYu1uWtVdea4oFx+K3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyfR7Zm+huyR++rHptyL++G6E5plhrkpsPGQcLXyDE4=;
 b=KTmvFD4qFGcxVMAyCPvIjL5FefX+pHEWD4Nt29W2duD2GiTs2ql0nGUpNWgr/MPuM3+fVX8vD23ScjEfhX/IjuLyXS35E7eXpaXx03BY2CML9VNaPziV+yCI2Yo/zM8ltOlc/z0CdKJKKtV5Ig6emwz7H8hW5yKvfCTOiH2Hi9E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:15 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:15 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 27/70] mm/mmap: move mmap_region() below do_munmap()
Thread-Topic: [PATCH v13 27/70] mm/mmap: move mmap_region() below do_munmap()
Thread-Index: AQHYtjiVMxZWuRpII0itDXdx7pll3w==
Date:   Mon, 22 Aug 2022 15:05:15 +0000
Message-ID: <20220822150128.1562046-28-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bdee62c-19f0-4e8b-9f92-08da844fb867
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ibg2/z9Jr+rlW3sE7j+wNJAQWME59lum2ACmXzCo9dg5l09FC77YgFsqB8TNwhSPRM7R5tt18s2umuWVzjsSpFHVOVuiPHiML0aeIiH+bcJHS48flsvim/r/4rOccI5NkAsJtLin9Pd0jiBB5wSUvoDmu/wRp2nG7nd0BPEuJ0T9D6tfwzn30G89HrdDIEa+qGalD4AuUGqw6PLmgCOADFz8vYvL9fZ/THr3HtvJiWS9ir0Tssq6VBhbfLguzWCzVoY+7cGiWnjPYZ8PjGDE+pgjq0OauukcYsPU1eukwnglrh0C/R+6oHqMw3EoA6hzGv29drztmhnTBP6XoOb3nK0zrDJ/4vBt0ifHzq3w8DcYwLsOcrb80c372XY8y9jrSCow/u/nUDDGujMw2BVbkebNO5zYJ3UnWuHQecnaHUNnDs8ZPyEL3/QfhWVKrc+aKw5E4ZM7s+8v0Vq+mjsw8YbnLzlDtjN6vx80prjVN7+7MV4EVMEarLoeN+HF+OKVvaVE9dywOdVk4bdJjxsgK1clc6EuyEdO8FcNz0VeYke4i9wPTN9C92dWlO6JOc+v8CZj2k6qIQqrASmQ1TK8rnTrVCcNTOZd/741fkVbP++vt/m3TUBt1uAbEzUvRteVKM72IijfgCX3W2jvzP4WZxHtTAPLh9FrsDiZFScY4iKEHA32rjsGVoW2PPgKb/1bSXGBUSMd/Es1v4uo88yHwpWRIaN8LYb5NZemJH1jY5nFz6FoYQDEZKTzqQNBBOlSsY0C5MTm8kUfTPuecUjf/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(107886003)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(30864003)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RCFRTATXSzQpPfK+YwfMTls4bA3mAr7sKB7XmQZFUpwllPc1ILWpag9yF8?=
 =?iso-8859-1?Q?ZDt8B+FLV23HjT/e96gQghMK+yz/lGiU4mjRIoF7T4kGI8UXw8HBArTkEk?=
 =?iso-8859-1?Q?rLtiXjM6WqND3EZO1pkD9LWffhXrocDPob0jvhtPyv9+IxSuCTHIE6d8ZZ?=
 =?iso-8859-1?Q?R6Yt3iNc85CJBc7neylR4q0MALWjwrhBKT0+5XqJR8qrWxxiYrzCeN8/wQ?=
 =?iso-8859-1?Q?L0ibpsTl6znntR6fhfEvkPduDb+LWuTj33z+QqtOU06gjFtmRa3x4ZTkuh?=
 =?iso-8859-1?Q?q33+zvp0mHME5gpd5OV86Bkk/Kc49105Gx98ZKQIqpcq0t9ZNyIMNfnK9L?=
 =?iso-8859-1?Q?7zrmcTlP78hrgX7ejOYYg3Hwk7VlGU1wD/pZM17FiJx7QFQ/19rrABSrXi?=
 =?iso-8859-1?Q?u0Hy9iQEt7nLyMxbFgZSda5LhJPwiiPB6Hz/48TU0+01wQCKzQSfWjSAR8?=
 =?iso-8859-1?Q?r8teUjx6cw2dn3kAgdc3A288f606OQuqLlYpsPpxVCd7qhiDBd+xRrpPQI?=
 =?iso-8859-1?Q?+bVzu09fVeeHtYSIKKeA+nUvC9sObaxR5kqbQ/YxKVvMEbpifdceCJUD7h?=
 =?iso-8859-1?Q?xaOHHo0iXg9UH8D9fy4FQ2JySgTZo3fvk40lCBy47LpV6clSKdC07teiwR?=
 =?iso-8859-1?Q?BY9kFZ3PtLmtgeiW4P4IKpTyE6lzGaX/RVObRwh3js2dZuApM5No+0FeTR?=
 =?iso-8859-1?Q?+xvK/Ve4FOgv74mvKb4WYzuTMB0GAc81WVjBtE2I674KVnZInpRMkHbiBb?=
 =?iso-8859-1?Q?tcYFUBlOC0TfU8BKH0vCf0Gqrvp9qAIiPzdJ6Sh6oomO5jqiKvRZGhNwCB?=
 =?iso-8859-1?Q?beG3HdTV4yKe+KGEG8Gq6cjWbtxqyRtqbTFLbEQvoQFm5l4gTbDK/bSwYg?=
 =?iso-8859-1?Q?O/iyI0NGuqGYg/Hx4E/FDsuq8kzzctmAhvN48jC/ZBOdcOnW4ZnS+1Ahs2?=
 =?iso-8859-1?Q?ZFk/nHKESaAcxG9BPAuUI5fp2Fq0BkxOGSQTIR/7G7CjSfJbPNJjD0ynIR?=
 =?iso-8859-1?Q?ywaTamhhx0HR6UfZ3bJ/cFOf9ecgTPAs7RMMZ2LOm6xEvkFdtrhW1+bmGu?=
 =?iso-8859-1?Q?9T205eKyjgBcvmuaWihmqbJq5zUTxom6p4RRiRk/CxIid/HqrDUdZoSzZi?=
 =?iso-8859-1?Q?Rw0JrBXmbpv0mbMpfuK3H4+jMRHovphuHHiFloID7kwF/GDBVebFjn+8k4?=
 =?iso-8859-1?Q?wO5cEbBDfVCCUaFmldYWE48+4HK48tIK06OdIbfsNxRqxFuj8Fdqa6O+s7?=
 =?iso-8859-1?Q?GUpUOewTqyNhlvzP63J7ifbr+UlAhyb0asHogHL4QcglLk0e2cCRNWqpkb?=
 =?iso-8859-1?Q?oRHPzz+mPV6BbQSDJoG3FlwB9jeFyY6EendB2QMVB87j1CgXJmcqjTIpAS?=
 =?iso-8859-1?Q?YSM5VnHtL/RgcJXyR5QL8QCPktDnPSIWJtx2bWGd5TZTgQW4HkB0dTC+Ly?=
 =?iso-8859-1?Q?aut8Jl0+yUv3GLkM6we7M65ArS431cDxKV+LfYCP74vMO+2u9XZWMhs68/?=
 =?iso-8859-1?Q?XLsWad1CLqddVCHfpBCGl5zHVOh4kuMUzilO1CIpqwfbrzlzPbP/qoCHhx?=
 =?iso-8859-1?Q?yIPCn5M8c+VHGlaceqhFEvYluSaBs+EAvdrGv9ZEsky48FWAScA2ZLYjZD?=
 =?iso-8859-1?Q?LcGDLyADVhCsPSCmiKJhugr2FjTrwwXciEmkmSRY5zD0fpnxMZkdc5/w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bdee62c-19f0-4e8b-9f92-08da844fb867
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:15.6959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6D+ROQsgkT9ssmqWDzHgFzDYxD1LTKx7p00TCzWbO4Acmj1DpDCqnnFnqaV5yE8wcGkAHdGMjNtIJb8fWNMG9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-GUID: qPWSdttqMzuTGDKp50Bu7BxB75SIFmzN
X-Proofpoint-ORIG-GUID: qPWSdttqMzuTGDKp50Bu7BxB75SIFmzN
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Relocation of code for the next commit.  There should be no changes here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 490 +++++++++++++++++++++++++++---------------------------
 1 file changed, 245 insertions(+), 245 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 90e8333ed336..0f4e21a405f6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1720,251 +1720,6 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE=
;
 }
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
-	unsigned long charged =3D 0;
-	unsigned long end =3D addr + len;
-	unsigned long merge_start =3D addr, merge_end =3D end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |=3D VM_ACCOUNT;
-	}
-
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX, NULL))) {
-		merge_start =3D prev->vm_start;
-		vma =3D prev;
-		vm_pgoff =3D prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
-	}
-
-	mas.index =3D addr;
-	mas.last =3D end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start =3D addr;
-	vma->vm_end =3D end;
-	vma->vm_flags =3D vm_flags;
-	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
-	vma->vm_pgoff =3D pgoff;
-
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
-		vma->vm_file =3D get_file(file);
-		error =3D call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
-		mas_reset(&mas);
-
-		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
-				addr =3D vma->vm_start;
-				vm_flags =3D vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		vm_flags =3D vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error =3D shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		error =3D -ENOMEM;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-
-	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(vma->vm_file->f_mapping);
-
-		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
-		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	}
-
-	/*
-	 * vma_merge() calls khugepaged_enter_vma() either, the below
-	 * call covers the non-merge case.
-	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-	file =3D vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
-			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |=3D VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	validate_mm(mm);
-	return addr;
-
-unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
-}
-
 /**
  * unmapped_area() - Find an area between the low_limit and the high_limit=
 with
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
@@ -2840,6 +2595,251 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
=20
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *next, *prev, *merge;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
+
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX, NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma(vma, vm_flags);
+		goto expanded;
+	}
+
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma =3D vm_area_alloc(mm);
+	if (!vma) {
+		error =3D -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start =3D addr;
+	vma->vm_end =3D end;
+	vma->vm_flags =3D vm_flags;
+	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
+	vma->vm_pgoff =3D pgoff;
+
+	if (file) {
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto free_vma;
+		}
+
+		vma->vm_file =3D get_file(file);
+		error =3D call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 */
+		WARN_ON_ONCE(addr !=3D vma->vm_start);
+
+		addr =3D vma->vm_start;
+		mas_reset(&mas);
+
+		/*
+		 * If vm_flags changed after call_mmap(), we should try merge
+		 * vma again as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
+			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			if (merge) {
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D merge;
+				/* Update vm_flags to pick up the change. */
+				addr =3D vma->vm_start;
+				vm_flags =3D vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		vm_flags =3D vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error =3D shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error =3D -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
+	/*
+	 * vma_merge() calls khugepaged_enter_vma() either, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
+
+	/* Once vma denies write, undo our temporary denial count */
+unmap_writable:
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+	file =3D vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma =3D=3D get_gate_vma(current->mm))
+			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |=3D VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	validate_mm(mm);
+	return addr;
+
+unmap_and_free_vma:
+	fput(vma->vm_file);
+	vma->vm_file =3D NULL;
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	validate_mm(mm);
+	return error;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--=20
2.35.1
