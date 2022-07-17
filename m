Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F99577344
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbiGQCrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiGQCqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE17E193F8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:51 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8g1T031750;
        Sun, 17 Jul 2022 02:46:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=OwU0+PG3I4NAGDE1mV7r9Ax+KkA/9ecJsZlgA0882+4=;
 b=TbJFksLPrrjBqLBcIllUiSN7aYQxX1P1p/g8o/MzdKUPX/Zcj7UyrBS+U0uYoHoCLl4X
 1G0hJBjHHuHYiN+eOrIPjFARCgtWuNh04g+iUamTA9M49TFe9AyayrZJCGSbGSotDSKM
 eT6uy+9A4TLS/sCREK9femuQhBCRGmC/coqCpqBwbALvm1ITvR8KlXpHnXyfNZR6ZFGg
 pt/l8OK+kiNlAQt84iKumwIj1td51/+paBoOGZwHPpThwuTgFV8mNOeWOk1s2OoZ7iqy
 fH1KjT4htDXz0WdrR7iyUET8h81kMPCK8Qfin+fJ3c4o1hMMe2TH1qtoSU0ZrDz4jsMQ +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:44 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImS036151;
        Sun, 17 Jul 2022 02:46:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REohy8rG8XLElh01Pf/RxNoZwxJEoRwPRyAfIVmGBMELH7oqiZB94pxtQK2WXH1lQLNSpuuxl3NpQBtYmIhjQnkfjmgDzkks9yGCi3UT3CtvznTmav2sDC8/avzcF4544+bpI0ABAuJBuJQMdf3q+U7jwyqbZzqFNcOYmKv3MVAhFFNfKcVxSJuYXbIcGZQR732fJJ+NaXMk2MoLoBg+/3k5QBHg27wJmKDAB0oPPzZNKqtoX8gPIk2O0XWLVmXFd8toTB9LNt3ly5kvLKIaGQCRL5LqkVRTEjEeBUqgtndp6piXPOT4A90k1A7GOvmJKVHWI/QdMxBUAZPoP627GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OwU0+PG3I4NAGDE1mV7r9Ax+KkA/9ecJsZlgA0882+4=;
 b=mEj/tL8eQjvcRWWtwyCXY+Vi0bVa+hqamn4jjHpRgB6s2+SwQwqL4B/SztQn1A3TEj98xd+MbwGIx7VpJBY6VkKf+OTHbn82cJlGV5SNjuOtHEmiKRek0fwyseAjIGBmQ7P5wNvM/MVhTJIHZHWZTmV/r6k0hqjRBhzAtkk1z3f1og4JrjXJSYzaTprzrMeI0Ro96FWqF7SS0mRCSzCXd6nEQI+uxuepgSbwMMf0JUh3jbVMK7iKd4AvjpNa6RVWElcrtTDn70rN6W7o4HOUENOdl5MrNzVHRJoadyFib6lD1/8myWS3gzSls/2LscT22rJDdjbQPipMQGaH1fAktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OwU0+PG3I4NAGDE1mV7r9Ax+KkA/9ecJsZlgA0882+4=;
 b=usUZBFhpNQH+FZF9Q+hbHqbRhIAR9j8dWXs1AX/TqgkIToUSiMYs75AuKuTFscAyQDWvXVG9J8RBqqiLgnQhVxDg1wrLJeInjIwj4wY2lcM4O7BL3F5GLhMWZr8EzZqREE1sgjieqbCSu/UXcfkLESodRmG1c2zJXpDEcs24CKM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Topic: [PATCH v11 10/69] mmap: use the VMA iterator in
 count_vma_pages_range()
Thread-Index: AQHYmYdwvlqmdSP7KEito1JvCo2vcg==
Date:   Sun, 17 Jul 2022 02:46:39 +0000
Message-ID: <20220717024615.2106835-11-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 70227de3-2c89-4c14-5a20-08da679e946c
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IcgEYWILB+FLhAVNDkjxV1SHo6P0XOYfehsHYkEgmlbZPrjebAr02NX7t/Z6xFHD/LWxVDpnzFmHyfPZkrKMTjfEKYi8Fn5zBjqWYum43oC5yR1FdF+xHBUKf4ZfyuJ79n99bw7roGgBUQ9OsFyz0jTasDAxzEIl/4iEDUWqQQeLSwcpJ+fF2RNvTK4wmlxvb9R9aCnjZ86TPi38HSZ7HhCx4Vr+xo6yn+vX6TkrFNsj3/mLbbiXQkBUWjuM/b0A4ydj9XPCgoWZvHBkehsH03Kx0e6kKD0PD2qhE6KR0nQmKLbq27TA/ykqdSeBVnVsF6avLAr0d0kA94KLZc+Cys+YNxYzSzSbKFRHjpn2dTfLMotqqgiF03M71pIDzEB255DATT6qiw0Cn+emXChy/oxsSz/Q/a4fvggEO14MEkS3EqMpzcTCYAgIjCWzExd6b1MMoOQNWUItfTU52xv2imWaphTTJbD+N2vOiKFd6u1fY+F0D+4dFHI6RwLheslXwzau0lpExsrBPGyQfxRHuQf1PYcz7EuP+8cIVoaGhTodxNG3LgZPlGsCqUX1v3AUw71RMY3k+VYnloJeplWu0iKq2HE0IynihbRmuxeAAMKzqqgZNzjqlBJRP/ihvp+s/WFJZSMKdZkqdwhoBAw7tgmtqXGgmrWoquR49o3qLki7rxVxDGcK0URHeZBJ/ziOuWLgt5otmb5HGksqIaGs37l3XGh8JbOmF4dWPsDb9cvYmDMHMipxWR4wgXJ6PClluB5RqEKuIIJs0BgPlO+gdTvxr/VqvCSI4B0Ee323SItRvd+VeuAfjbxsVvPzv+fGsncaNe9JJFOhRbEjGEcpCGqIo8WgVi/9fuV6cKAwV3er2JFAjKeDvTWMXSQCJHQJZjziikpZQwMUQ2F95ytV+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bVvRCA8tzEIkJWTs+QZuMarsmA4RG7XpgmajdIHH4YcCm/8H79HacgrFJI?=
 =?iso-8859-1?Q?8ZjmlokuG7usgbLH/qiB9uLIFH5x/lSvLWpA/pUn2wNADCM7rUL2UHyg09?=
 =?iso-8859-1?Q?hr8gRT4S8oX4zNPWM/ckylumDFjODBwPwf2vo1Mo8rtXf1FfogGaJ0JbXs?=
 =?iso-8859-1?Q?Y7ZCjhjaJE1KLprs9jdno7dn6IhsLjClBJkpdSgf0sMePeQdj3qo6x9aaZ?=
 =?iso-8859-1?Q?QltqfcDDOGkEuOThzePjiyYp6dkO2jsr2A8ofCi1HrqtmRVwj/iZu8Ws4g?=
 =?iso-8859-1?Q?qK+kEHcgcLVnLVPCKI/uNMmTGu5jdkmDhi3uY/7ymd/5djFXzlxHPRJrck?=
 =?iso-8859-1?Q?k2lAC7rg6azF9lwZmsmXMlerXZhUv87Hr9urvdZOW2eCWFpE2aYM1XiP7a?=
 =?iso-8859-1?Q?hCXqtKsKc7cAH/+dYUH1R9TI5FzybFohusPZcpbI64kUNm7wW8VTNopxKW?=
 =?iso-8859-1?Q?PQtC2koo6eycyGwb722f36rwThS+GMCrOrFgQlTpfqo15UsWJlZSn/q7kX?=
 =?iso-8859-1?Q?FtGYhQ2lYuB27RJNgBoSG9QuXKix8rv+l4qElDWA5T6mOZS15mUttvJ0WR?=
 =?iso-8859-1?Q?XgU/Fpt1YjMBLu1YlLBciPiHCO7hU7p0N4KhMs2XG737lUvYfimHgqTb/d?=
 =?iso-8859-1?Q?wK317TSeKIvMb2Nue0BP5jdeO/jNIXgCSlXgqz5tAX/IaVmPfhPLYBOuFi?=
 =?iso-8859-1?Q?iFOkDOaJFvaCD8v8321dJ5uFUqWnfzsrVVfGOB4UQeS3yCcvKbMetAbl6+?=
 =?iso-8859-1?Q?07VV97eOBlV6JRYKIfjuDbLvO6N8MhnDJaozUEGiIT7vqEkBGq+wLSQbvB?=
 =?iso-8859-1?Q?Yab/nvmhqLUekeO/nou0eLHKYYNWQTGUWSvgDGHjBWLZi1eoBo8S8m6Vcx?=
 =?iso-8859-1?Q?u9N1PSvXxqK5DS5mKNOEZeSpxB4qzqRW5s4HTFV6I/8UUUrY6hKO4OCVnr?=
 =?iso-8859-1?Q?sV7h84lNcq/w0QOjEp2FNUNXbofXn5LSC1xoOIDB3mIskMgNXLsMQ+aR6O?=
 =?iso-8859-1?Q?QsulpHvuJgtkrmUsmT/6WEQkt6K4s7/Hwy793cH2ABWv/rG7Qm9wDIpji9?=
 =?iso-8859-1?Q?SGc18Yj7JXVAjNUZxxQvz5394f4qXBvFr0uXqqY442oyuiHMeB7rZ2v8Je?=
 =?iso-8859-1?Q?/WeWoMRdN5F318Cw3O2H2UYJc++ye8r838wyrgzMMCdedfFl0SuuiXh+Ms?=
 =?iso-8859-1?Q?M/HsMlZzwUPRFl/JOIeRCh9kYo+3nO/ZNSVQBxwmJFSvfaDp/GqXWV/XGL?=
 =?iso-8859-1?Q?htMyBjj2jscDaprA5JDF8FvofC2Rs0QMVRfPDVgOgoIQB60B0yQcHFG7Ij?=
 =?iso-8859-1?Q?hAcTexLCZSqmczihF2SxJvczNQTNHwtpll9VWO1MKOGehAOsGQqSHPOGKH?=
 =?iso-8859-1?Q?TdVkn3qxOjULSLrv+ymjS83Yt1k5dundUWED1MHZAE+SGFnw6xDGoY3fDB?=
 =?iso-8859-1?Q?i2eSbgsCP0KbV2Zx+g/XhBek37U4Sh4SThvG3r0Q8h96Lpv47qNK3+Oiqd?=
 =?iso-8859-1?Q?I1nH8gAAWffEN9DyVXZVGw/F7xcjqcUD8P5x6Oo56gZLT3mF0TJNYfMvfa?=
 =?iso-8859-1?Q?HlLBBE1Bl15wqAUo1MBb/xoCcqECWMgg+FsWxPushvngNDivLzqmeFGcpG?=
 =?iso-8859-1?Q?4cAdOkzy64LSAC3JKEqQhj0edba90hPA1nYQdiD7vk+xNn/puy1FVPoQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70227de3-2c89-4c14-5a20-08da679e946c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:39.9751
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hej5MQyGGOd5Fh9Er2oPj/WimnXm6XzGh8j1lud7/0RhOTkEMF+xV7bbSCPJ91TKWJAUbdyRnFIGY0yNF6fKgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: BncaZxylsLhEAEatewDt_UxxJaOHtmvs
X-Proofpoint-GUID: BncaZxylsLhEAEatewDt_UxxJaOHtmvs
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

This simplifies the implementation and is faster than using the linked
list.

Link: https://lkml.kernel.org/r/20220504010716.661115-12-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-11-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 35c4478a8fe4..1ba4074c75cf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -676,29 +676,19 @@ munmap_vma_range(struct mm_struct *mm, unsigned long =
start, unsigned long len,
=20
 	return 0;
 }
+
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
-	unsigned long nr_pages =3D 0;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
+	unsigned long nr_pages =3D 0;
=20
-	/* Find first overlapping mapping */
-	vma =3D find_vma_intersection(mm, addr, end);
-	if (!vma)
-		return 0;
-
-	nr_pages =3D (min(end, vma->vm_end) -
-		max(addr, vma->vm_start)) >> PAGE_SHIFT;
-
-	/* Iterate over the rest of the overlaps */
-	for (vma =3D vma->vm_next; vma; vma =3D vma->vm_next) {
-		unsigned long overlap_len;
-
-		if (vma->vm_start > end)
-			break;
+	for_each_vma_range(vmi, vma, end) {
+		unsigned long vm_start =3D max(addr, vma->vm_start);
+		unsigned long vm_end =3D min(end, vma->vm_end);
=20
-		overlap_len =3D min(end, vma->vm_end) - vma->vm_start;
-		nr_pages +=3D overlap_len >> PAGE_SHIFT;
+		nr_pages +=3D PHYS_PFN(vm_end - vm_start);
 	}
=20
 	return nr_pages;
--=20
2.35.1
