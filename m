Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45959C21C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235978AbiHVPFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236076AbiHVPFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:05:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143842F021
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEiroo017910;
        Mon, 22 Aug 2022 15:05:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=xVXf0vgJwCvU8nYFzkaENM4ujXXBQZOB85n1lqbhL3I=;
 b=whX6HV8JGQUO+03fv+fvh77HnMx9t8t1722G2+dLr9iz801fetk8anx3F7RruGcpxPFV
 FShrFvrfW0m49GQOUAXRloeLLX/c6HWpdGJPcgM46jJuXqR34P+I0V6pi/kcrulUs/o0
 Y4B2BB1itKut88XzHBki0r7FPH+ZIzkb4upjdJIW9lEwV+VSViTYdB60IHbTq0WD0Boe
 yXKSZifZ8qs6p/3gAwL/1+x/78I+wlsgpFkHUbJiVf+QV1jb9Z1q9s92zjf/FOU3uUf1
 vIYKTjBefIOLKxMLw4fi/UiKof3kwKiUSyylYhiJofE/JaffHBgjJg7jJD13oadrqiW9 xQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt041n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:04 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4NBE026692;
        Mon, 22 Aug 2022 15:05:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8bc7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7YeLl9x5NBdPmf7EzoQjrIFwaoRNRZlfevN8Qjet1Lsye0B0M1BABeZ0G0UI31IhHVz9E6TmC5UPS82KHe65OyI5sXn2OYHT8BLboILUZZzfZ3BzD759pMnVgMWQ/6PAiwodK9tf74swF77CzueEYibnierz8PEHGrOVMcN6v6K099YijIj5xh52ZPpgG7SXEpcJYmxpuYMNmHMFMi/XJ/Xnx7p9cVbsrSy6mJiPuWCVUtiPPtxriMIrLBtbIU4j31c7zEBOViTbh5VKmIaordpYiTxXcdpVgfXijUWgJU06l3nKHoqM5BZ0t9A3ZS7J95t9NX4XqdKbhLvYsmnDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVXf0vgJwCvU8nYFzkaENM4ujXXBQZOB85n1lqbhL3I=;
 b=bBnGkKvfnUsacqiIJMVa6bFSQ5wRKSSwEis7y1ogvVFDvwLa/PfFr6Mtv8Hyj4EyewbUW0jhNZJHAZSLS1Mwcwp2qQu/MVZcZq7xGIeff8NeFAa6/ZLhg9MBZ5g98K2QQBpazkjvwkmh5PlBk8PlpVuzn9joSPQ4BMPj2m4NAz41XyexfteKFnTbBDU8k/wowPqFSZ5ntTYtmfa9nIxmkYrsaVO15y+rm0VpOPUQ45HjU+zk9Nx1wT2RdE9zvTZrqI5/nhZ9wDOVzVLnIaDpL7aaB4xi6tNd/PVqqo4Fwi3R2n3qDSJE+4hKPL4g0j/xWBr7vIUf5qwK0falZq5oHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVXf0vgJwCvU8nYFzkaENM4ujXXBQZOB85n1lqbhL3I=;
 b=KHy8Dhb6VSs7YT10XXoQ8BDD+LwMHRXuCgP52CUsAbUbs9NcKZBqhjQ0ff2HEfJOqK7CyxguxfsZVNdZqXJAY2qHHdAzcQhXmFXlxTv8vsM1tXUxmRH5L6P7zM68D2xeNXq059EyJxZFwC18udrxu9iPOLsoMC6OarkTMdUhS4w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:02 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 22/70] mm/mmap: change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v13 22/70] mm/mmap: change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYtjiNHXnkkFdMJEKn+4RrekXb9w==
Date:   Mon, 22 Aug 2022 15:05:02 +0000
Message-ID: <20220822150128.1562046-23-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b65a7429-4586-468b-8616-08da844fb04d
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pdA3js7t5vbntUN0hVtv/FuocaAOMQp9whCU6z2CVtfT4jPlVvGHoxeHYgUvtwTjanttt7ZjWSn04EJNroSO/FCX1OUlCmM+wI7Oh4iuR3W32shatxYnSc/h2Fbmfb6V0wmt6/ptllRSvgfzyqzPuCa3KH314jQvOi8nqP7W9CVr5tb4wLknRBAsojakN6zIFnM3d2WlYaT2uocrrRPMfogE6HGkuR33q4SW7yE24UffrmIYeIMVOnH5vzlanFaNb0uru5r6CsiDpaWZgyYxNA8JtquWCtB2mLNfLgrkZeh2E8z7vWIwBILjYcDZbHNDKBoPNpb6COBCiT+ZOs47mfTO4P+8P5889GiKWl4u0qcGhbIoQV+gSOt2x4FfNVtBThdiyC5vKm3A8MDjI4ulqMxNS8LrO6kCI1UZtc0RR+bWcdI6HE+uk/cBEsSMKVeho3PfbVHrAU1hHZF55JG9py+B7+8RvTfGTfUN04nVxPrsIu3IRDl7sfUbWL+MuUCJMq8gDSl3hVUBaoFjXM+8hB/2nAN4VWq5SbAnLPgUF24tBpccohjQvjPCTuT/BBpFeKmwA8Y4+dS2F3o31l6JR5Kg1MpvHRh0xXXfE/nBt40MAUbGqKfOwi2KxeeVMW0ro5/4g8hFeKg/XAsbzXukiVqCqhPv2yv7Z2L1i45+B87rdE43HHbRB6KDE2Svc2pJZH8SRrJJIYartkuGjdfXIpxgArSRtOWv8THhYuxRYOL/BP511Xy1GKo84EnaIvfsY+lhzVCJ976wFPUzPDr7Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(107886003)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(30864003)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KzNy8n01SsysZk80FsQLUvLA+LrKUty8LZzjHdsk84438U9O6evv7DUWFw?=
 =?iso-8859-1?Q?H1AomrMeinDL6fvardsB6vpeR4ponvdhnLIBQpZOm4XeDuFAaMW6A8yB8Z?=
 =?iso-8859-1?Q?JJXHr37y1mEqojdYGl4gnr08ZaaNre2rOuYeFfdzBdFUIXdKT9a+r5EP/3?=
 =?iso-8859-1?Q?F7jFFrY74iDIVRFB9BVM8ITqrdr/LkQJet9qcWN07oajYwoTZR7qtGuf1S?=
 =?iso-8859-1?Q?8bMgoEZGutB1p3IIfSbdUST6NsKgZ7+NS35i0ViQ0vu+o/rvhEw5yGb0K2?=
 =?iso-8859-1?Q?lc8gsfAWmilPdi0ec3tIrlwllsUJ93fE6SbGxqpvxhMTIFDGUjnC+0f8TW?=
 =?iso-8859-1?Q?C+MP9fv9Ds9DILJWCY4eE4JASuhXqPGSv9R38gyQaq2cpzy2+DEq5S3kew?=
 =?iso-8859-1?Q?3ltkVmnPF+sdxyhENLu4PRRlrNH0XbkrYK41Y5PldO0JodyOioPs5undtU?=
 =?iso-8859-1?Q?7/CvqlpAD5qInAC7lSxhZp6UNIwzOFJumzkGYtW39XZUAgISzhBsArutMH?=
 =?iso-8859-1?Q?LAJwa4VdZqpFVbLCotAAaXM74JWLzkAmcWpGWVvyfdXgFowcLku08FmrL2?=
 =?iso-8859-1?Q?tjLvBxmjIX1v+17jmsdfwp9i83cNP9KmuhLX1iinCzAzcl2OQ0ogSinJTA?=
 =?iso-8859-1?Q?Kw3bidRrfnMNp4YvJcm0ohBHPFTpirIhhAKuIG6cR+Y1upQps/A++Bt5Tb?=
 =?iso-8859-1?Q?W58b6RviVKXWkYEjSiPenaLWd2WgIsyTBC9zgKGZbcMSxvXcGhKlhPp2O4?=
 =?iso-8859-1?Q?p2wM7FXooJ9dwjB4U9OpletMXNMpXoxVKuzbFQhvX6iJrCVScD0Rd05ZhG?=
 =?iso-8859-1?Q?3YpNYlfXCGUJ9kwzacFnTwAdZ7/mIVLn31oU20lbmVkzj+nxLjX9MegXfi?=
 =?iso-8859-1?Q?jHj2uH9sqABBc+nhC/V6zL05jUnxPrK4lKySm0SPkVLa8XCppAxFlH4Tkt?=
 =?iso-8859-1?Q?6qU1EOSMRzQfilpivgOtzvbEGJzj9FhkzSPzPd/l/Q+hI4W1aV/tm0j7kC?=
 =?iso-8859-1?Q?kbPnCCadh2X5CNKnYc4OzaUrFuD2p9aKSlsHGFywey2MbYyOaqsS3mAw9T?=
 =?iso-8859-1?Q?OgtIkVVXxxj3CLVw2+Igzxj4KEmLVbd6On7dg7weNqnXRhVCsBP5JtdfvR?=
 =?iso-8859-1?Q?z53JO3v/23GEWqFkf5EAld9f4/t6r54C1zuvuAiooiyLiVcdqtFJkVQIOo?=
 =?iso-8859-1?Q?QE2ZJxN5Bzy1tZUi1CWyS42Zbhnym6jfIf5+hZ1D5hXGjOFsmW3r3uL9Y9?=
 =?iso-8859-1?Q?6ozLR0I9L07COW+qL0MOEBBQYFwpMbgz1f12lA1tRB1DtJyzxbmvHjgZon?=
 =?iso-8859-1?Q?OMBIQ1/qOzO4Dq7sS2z96XoBifNyB6oNmWGpEd8nznlWoH/U8NSOTHoWkW?=
 =?iso-8859-1?Q?AZEA835+WuIrDRKFf/jgn5cGj/Sk9YanMrOyCKT200gUFz7J1X5z/UkhxH?=
 =?iso-8859-1?Q?Q7xWx7mrCQMSqLbJH9euRlcz7MgAlXtKU/JUIqKf/SnAi4NVT96zbHgXfu?=
 =?iso-8859-1?Q?4e9GLq9OFY4ecINJrKFKZOHd2Z1mg02d2Fp5AkkiJjt2+2EU/tZGn0vOTQ?=
 =?iso-8859-1?Q?ZRfslMVWXR8BvmgSCLQUO4tFUw4dtu64h29KWm4A+gp9B/qYam84Iuq1Ht?=
 =?iso-8859-1?Q?ju6LZJX9oyo77DqgqhajR/fjhstRaOt3BjKhLI2L7K1z0VzA0AuD/hUw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b65a7429-4586-468b-8616-08da844fb04d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:02.1187
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i6kJw9KtFdAvcJ8/g38eUEu/mk/u19JJfUa7laFmV86HyRLZDo9cDeQ1ezWcM0UzwFql7H1x3WyztFt7l1RjSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: OIljAECABIMgRLgbYu-xhaPEhVkRGCIB
X-Proofpoint-GUID: OIljAECABIMgRLgbYu-xhaPEhVkRGCIB
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

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to split
or coalesce.  This avoids unnecessary allocations/frees of maple tree
nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function to
use only relevant checks in the code path of bkr() and vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra criteria
are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Add a wraper for munmap for the brk case called do_brk_munmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 239 ++++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 179 insertions(+), 60 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 52a774e70e5b..3479c9e88eb9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -147,17 +147,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -199,35 +222,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2762,38 +2802,55 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, st=
art, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
-
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
-
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	struct mm_struct *mm =3D vma->vm_mm;
+	int ret;
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	arch_unmap(mm, newbrk, oldbrk);
+	ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+	validate_mm_mt(mm);
+	return ret;
+}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
=20
-	/* Check against address space limits *after* clearing old maps... */
+	validate_mm_mt(mm);
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2803,30 +2860,56 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		if (mas_store_gfp(mas, vma, GFP_KERNEL))
+			goto mas_expand_failed;
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	if (vma_link(mm, vma, prev))
-		goto no_vma_link;
+	mas_set_range(mas, vma->vm_start, addr + len - 1);
+	if (mas_store_gfp(mas, vma, GFP_KERNEL))
+		goto mas_store_fail;
=20
+	mm->map_count++;
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2837,18 +2920,29 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	validate_mm_mt(mm);
 	return 0;
=20
-no_vma_link:
+mas_store_fail:
 	vm_area_free(vma);
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
+
+mas_expand_failed:
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
 	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2859,13 +2953,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.35.1
