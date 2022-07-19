Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2857A703
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 21:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbiGSTPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 15:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239374AbiGSTOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 15:14:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D1249B51
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 12:14:15 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JH4AZS002405;
        Tue, 19 Jul 2022 19:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=k+BZf+ntyzOOg1yT9po8ujP+S2PlrQV+a2W3a+0bpLU=;
 b=DspbsST+OubiHud1whh/7GixEtE/C/RFIDc3Br2a0TPgDFq3G5pyQxD8EgpenyEvUfjZ
 36ZZcPqaubpRi32vnLVJJOVpTz9dRdpkVKESHaY/tgZkCQ0byNoQYqi9TrzMBVY+Detg
 55GV/DnMJVJB7I4mBwh7KYJP/tx2JgAerwsYktg354bmsovrb2CFqs7i2s7QqaDxx/D4
 OJe3mx+p+PS4JM0jFVGXtdvPggLcVxMtG1eUyUmtdm5yiRcWyT2dVSwQQTkDF9xeU6Rj
 3Qh+a1M3W7ZNr3dOw+1bLrCGsewJ6eNWax6g5gExF61D88MnoUqJEWKipBI8yJOIbXMX UA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a7cmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 19:14:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JIShfS009880;
        Tue, 19 Jul 2022 19:14:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ggsbfr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jul 2022 19:14:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtMcVXMmUIBVy5NZBG6mxEqbH1K7VZHy2obRSzpJ+Du+I1/IK2OjDaIW1lgmkAiZUiC0SnEmkg7hT6sMlOAnsrdB0My9iit2AR7BqDambXKezuqoqYewO5tKgzDHvAmdWOugeVuXvdP6PRo/j9xirHvtQU1B1W28CiSYkruM151b+Y8Ss1USOqhW+OTIH3K/NJ9eRO4FKTGw20djuswPV66zH+fIvXShdssXHYOIYiw55vY1M3adNMTT4gDzk3Qx9L2uZ7mjXSk3AJjcX+vYGdk1tQktUFln36RatyCf0wkB5/+AOanyI+0LOTOEEfiucc+08jeBD4Ezgv0OzOpmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+BZf+ntyzOOg1yT9po8ujP+S2PlrQV+a2W3a+0bpLU=;
 b=iGPmJ32xopSIpjcxhuAIOKw/M0JJ7Ds42XkhfQk2Kcj5FJINeLbqlwFfld4ZONiPF+sNJcA1GXlW8Zgdv93p2S3nXW0/cMgNO41x0JGFAlPSVFSjXqW3gwuK6Ii8TbgPc2LoByLgLERi8UoccIMFRXGcLtsQe1g/Y80Dr+R/jTJZQJ5Ygzk4YWQZ4lKrrPRbaLeQmpj+nv2aOvmUdWzP27HeGjj1MgexyOL10D0CDoV175Uvp3jmLK4CsC2PdgpGbik83lSzfwvxPPJlEeuphbhI28T+sQJihCVsda7kt7pqXuDLqHms7oHk1XCBcQTF+/n6YMI3zBtC8z3GJN5mBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+BZf+ntyzOOg1yT9po8ujP+S2PlrQV+a2W3a+0bpLU=;
 b=iZ6RL5DwjGa5hMZWRwRnK7PXS4J/KoivaFy/zbOVA6mYapb0LNGnk2PH2nQ1VOCoc2l0YsthyLyYi5OLaKqYlH4XVr9RFROtLOK+Fh/z0quGKR2XDHS5z/oveiccZTeKXfTlfvfWF9XA7qtCcz7mQiD8bOEfkE8BS+vES2dMItk=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MW5PR10MB5805.namprd10.prod.outlook.com (2603:10b6:303:192::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 19 Jul
 2022 19:14:02 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::7c45:9b1:38eb:ca87%4]) with mapi id 15.20.5438.024; Tue, 19 Jul 2022
 19:14:02 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH 1/3] mmap: Remove do_brk_munmap() optimization
Thread-Topic: [PATCH 1/3] mmap: Remove do_brk_munmap() optimization
Thread-Index: AQHYm6O0TzwYnOSDc0K3kiJ7wbgw6w==
Date:   Tue, 19 Jul 2022 19:14:01 +0000
Message-ID: <20220719191352.3366482-2-Liam.Howlett@oracle.com>
References: <20220719191352.3366482-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220719191352.3366482-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38b7e359-b8a8-4f40-4143-08da69bad79e
x-ms-traffictypediagnostic: MW5PR10MB5805:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a7xYbMB9/qBGie+MGyXF09dpvjWGnQCywYm8WY5iDrAXSUbIMK3s/cS0K6oknUlxKRxrVVqjzlJK5L7ZXhsCc2L0a7KdWwHqSMuf+23Cw6pCv9a8Pv91js186PD+5W/WTERX1DlPga81CDE5eVyHekT6Bx9xoQalyvz9IoAhDPY0KY3lW/R2aLPTyW64RQylJmKVvGd+hBp5PhqKGxVL0KVatud1DEyPvLWsaAeuhKaVtJAzhkehG8vliJJG7atYQSps7AkO33tUGixXGv76hJSv5AziqdAV0D0IDbpYNZYAzzw8qO4BWF61E1sM0sbcI3QSjhs9H/5CjvsGJbVzNOaiXgmSdn0iLDGK2CLuCBuhZEtVI7gF5cPKptsqbBgRIJx+kDLPuggMQImqI/KIlu6fT2R20UUalxRD9jNWYmnp1q7Wlqozdq9O/PgqYD0x4O75dqE/UQooFtp4UNVqaJgXuhAKm3TL7i8py2WRVEVyUpYmE92G1FhAyhi8rgyCrwW4AvMTDz0VhalpgO04bnjFyElZoiW8iRzlydua+xsTGXMcNA4PypiNOylsQKDPel5f5NDZNMOCAi9Jhyn0q81yfOgTIxBi3AgXcJeVFkj1yUuFZzVLpkYlHu+QKOJFT+OgprqR7QKdJiW/rsbIZqmK8MKnyrty7rWAFb7dPvaFnJS3enBmNpcEUBeNDEkEAw97UgZKX6fsCgdMH0ap5Aqrh+2RUi4ssfttDjqRbv2nhq03XUiPklfvrGKAGg+CgQ9EGAyC63vGt9g7Sbf/JsUpBto3fCvqihZHbPWl0Lqal/ydjrglFQQBjCrDKbbG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(136003)(346002)(376002)(366004)(2616005)(86362001)(6486002)(26005)(6512007)(38070700005)(1076003)(41300700001)(8936002)(2906002)(4326008)(38100700002)(6506007)(44832011)(478600001)(5660300002)(122000001)(110136005)(186003)(316002)(66446008)(76116006)(8676002)(71200400001)(66476007)(91956017)(64756008)(66556008)(66946007)(36756003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M9FblNSZWcZqYWVMjnQGxfSGvkqlc7zDOJlVpbViuwkumy29unkv5smsDq?=
 =?iso-8859-1?Q?Q8ixI5cAfuHXW5K48s7J286H/L8caB0BzcoaQ3djGTqjhRg6QoylhoP9yK?=
 =?iso-8859-1?Q?jScB6sALvZkv+1Fbm+sSdokYz4Ru64I0pMzvbHCjnr8yT0EN1yR7h29w5P?=
 =?iso-8859-1?Q?2gHRbTGdMEAb3DeT/JiRjvuA5UIgr5tZgSTGYIWjptDim5661HcCRxZptx?=
 =?iso-8859-1?Q?ppIZMKLaCBlktoV0J7IkchPSXFf1alfaQFOq6elxfEX2mgjWHVbbgvZI0q?=
 =?iso-8859-1?Q?4DfbM/6QZ+BY9KUCRH9QKQLGdX+uy/Uwzi/yCgVhbA5eADkAQdmppuH6F+?=
 =?iso-8859-1?Q?zoZsr1PmM7OChTrdnW6QaLbfTXMpzpX4SeWWs9LcG1nWKQNMEUGDvmPnHo?=
 =?iso-8859-1?Q?+fqy0QzudcOP29LZDgTdR18yk4fuA0biDmk7x59//gO+S5HPO5HaqeTa/2?=
 =?iso-8859-1?Q?0v8wPIH9dECbzQV5QPMxfixJXwfN5OF2H9POze3AKhq7hD6tLxOsH+Ad2w?=
 =?iso-8859-1?Q?+m6cchct89Te9VWkZfC+ZXsISKDLWcAl5QcceaEvwzZqDYQU6vdDLRxno/?=
 =?iso-8859-1?Q?Y6Zw/4YuEcKLyTHt7UWEGNy4P9G4vffAtRJtMglluCE0+M3I3CiH0mV1dl?=
 =?iso-8859-1?Q?ddmaH6lVyfzB12Yrzo4d8nj+TtfKN+3ceF6YbwYGtbnVvwr3y48wigmgCO?=
 =?iso-8859-1?Q?D2URQeSYFCdAyq+9BXADT4VMcp+krelnkyeIu0CMLvN7ZuL7qYldYAFiEE?=
 =?iso-8859-1?Q?HVl0CCGYEmAEh6jOc1oQ7u3wgaogDwvUI7bl1o4UgRdwM0/oac3WwgTd2i?=
 =?iso-8859-1?Q?kRj8tM0IYTEtwHZT7/ZCY/zXQjjKNOO+lwPSlYeNgTOOYTi1D4BByeVK42?=
 =?iso-8859-1?Q?VXWcFWn3DCIxKLIQF2Z2qqL/X/p4rLVjyxY4h1r6lswWQFlI4EE9qnl+LZ?=
 =?iso-8859-1?Q?HGsQ3EupZZKv5NvwhTEL7qiNZknRzQ18QDFla6AFWodqwIYqtlbgI7ioQz?=
 =?iso-8859-1?Q?VUtaGhYhtVj8f10QZoe9a1n7v4KdsMQm7fqi8QoWiAjnOxJn+biszQFD8I?=
 =?iso-8859-1?Q?a32+0Mbws3BOj8qQTx4YT9KAkfs97fe/8GAZ01FNtfeFW0Q/4f+f3Q4J6k?=
 =?iso-8859-1?Q?GBUUJ7mXCC+qovPNNEMpzfjKOYHvCBefUxuhHogdyuLjMjPtEjplnjgwFP?=
 =?iso-8859-1?Q?YtBbdcoiOyiG6iI2Bb6YslUm6GW1gzgsNtI6RY3H+fD5B6gwZlH9+1Q2sf?=
 =?iso-8859-1?Q?Jm9xMr7Ee+NJYX1HKax73uYDFfHscetjdUNz6gS8weH4FHqwEyxeR8aHKv?=
 =?iso-8859-1?Q?J8kEvOvewY8GbnleiOYCGkdE3iwZ0UA9JvEu0BcDbxx63Fq1stpD9v8Yks?=
 =?iso-8859-1?Q?Q1OfJlzMIf5XaI5HmUxI/KXCxHjXTUmj3P1vCQAAiLzt0Bj7OJvi/pvUbs?=
 =?iso-8859-1?Q?B4YOVOTbCPQL08XiRbI36e3+BMKLTAmCaplj3p6gnWNYgBp0z6oHXJ/QjH?=
 =?iso-8859-1?Q?PUK5H3tpawZrs7E33FltyXgwlT8gYId7hN03fmwDijIxAsYBi57w3KyAuH?=
 =?iso-8859-1?Q?bn9Tr9o485uqTCD5G74Igj0m2wN8GzR1MokwWaMfoxnlcfMxLVQ/JzW2cM?=
 =?iso-8859-1?Q?FF6NfjSJdWNIhi6eG5Cerlm4TqmVzasiwAPOx6UdQSgr05sJ4dzL1tTg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38b7e359-b8a8-4f40-4143-08da69bad79e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2022 19:14:01.9122
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ROHL2uJuyj+0eSeVBdqbNEVNX6gQmtjCinxI/kGTgo6CJBBWcY3ACaRn3K6JSIpOyR9m4ZcjFqhqbJnzOZmEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_07,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207190082
X-Proofpoint-ORIG-GUID: kVaPLjBg4cqhRZ4b-be6UMjpLAoPEhfj
X-Proofpoint-GUID: kVaPLjBg4cqhRZ4b-be6UMjpLAoPEhfj
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This optimization does not work with the locking.

Fixes: f12fee814843 (mm/mmap: change do_brk_flags() to expand existing VMA =
and add do_brk_munmap())
Suggested-by: Hugh Dickins <hughd@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 61 ++-----------------------------------------------------
 1 file changed, 2 insertions(+), 59 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2f19976ea817..4fc1b3098c91 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2861,67 +2861,10 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 			 struct list_head *uf)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	struct vm_area_struct unmap;
-	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
-
-	if (likely((vma->vm_end < oldbrk) ||
-		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
-		/* remove entire mapping(s) */
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); /* cause a re-walk for the first overlap. */
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
-		goto munmap_full_vma;
-	}
-
-	vma_init(&unmap, mm);
-	unmap.vm_start =3D newbrk;
-	unmap.vm_end =3D oldbrk;
-	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
-	if (ret)
-		return ret;
-	ret =3D 1;
-
-	/* Change the oldbrk of vma to the newbrk of the munmap area */
-	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
-	if (mas_preallocate(mas, vma, GFP_KERNEL))
-		return -ENOMEM;
-
-	if (vma->anon_vma) {
-		anon_vma_lock_write(vma->anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
-	}
-
-	vma->vm_end =3D newbrk;
-	vma_init(&unmap, mm);
-	unmap.vm_start =3D newbrk;
-	unmap.vm_end =3D oldbrk;
-	if (vma->anon_vma)
-		vma_set_anonymous(&unmap);
-
-	vma_mas_remove(&unmap, mas);
-
-	vmacache_invalidate(vma->vm_mm);
-	if (vma->anon_vma) {
-		anon_vma_interval_tree_post_update_vma(vma);
-		anon_vma_unlock_write(vma->anon_vma);
-	}
-
-	unmap_pages =3D vma_pages(&unmap);
-	if (vma->vm_flags & VM_LOCKED)
-		mm->locked_vm -=3D unmap_pages;
-
-	mmap_write_downgrade(mm);
-	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
-	/* Statistics */
-	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
-	if (vma->vm_flags & VM_ACCOUNT)
-		vm_unacct_memory(unmap_pages);
-
-munmap_full_vma:
+	ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
 	validate_mm_mt(mm);
 	return ret;
 }
--=20
2.35.1
