Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5525059C215
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiHVPEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiHVPDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:03:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234532CC91
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:03:43 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkbm8022045;
        Mon, 22 Aug 2022 15:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QMIMj5rWXXWQyMVHj3d7y1V+2ga/rYS0Ii2nmbARioQ=;
 b=c0wdBbAvgLjmiLOcCXo2s4dIvFirtoy5S4wDM+0IVgobw7S2Mop4b/ZyUOdJ+3NoRb+w
 UwBhe3BJ4fUuAscTczqXSs3O5VP2PedY0IpbCw3St+aoeKyu7FeiYYPoghXJzFTUdwZg
 9GpmjMUWwIyxFWq1n/CUmGgd99BJkfbQM3VBx69Y8JEWZp/UukILCqXxweiKWHeK2mvh
 KJxYhHbg+QjRp+h9oTVmt3j8l4RAbtu4RQ/x7Mi3ry3RnmHEYVBYChbY4pW2dH4icTUd
 CM9Rm/mnYw2C/DmlDkbF0sGuazR5WHRmN2mDcSz+2JpHtMNiLzVIxA6X7FdHDs9MLa6j rg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2aq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:21 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Ok8035558;
        Mon, 22 Aug 2022 15:03:20 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1tv5j-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LX0RKphaueMhSIU6jMEpLZZ1RKQK+vdrqjFLW8qQXwfelfVvEd5YdjAQYBNZ6Twk9yfWq2Fthu2DUfL0T3pm5bjB/jcaFiS9U5h32MeuwPjsyXKIFsdlNuEXaNcKfKYFmwgRhyttEmb4oEu2/Q47fhx0kId477DtIGIzSmKkBReKUQuInns+vi5vF9lU/ZKFEOwtfSOntKGTCxPfoV5B1fuSCNEZI1C02As20bCBq58PaXsnlvQrLOeoaJr/RFuquIfjEi2PHQEwEzFa9f5hdEAYYYXnGRWEyTmWNUgiNZSrWj/E5/+7DVa0nmt7HCMOWOZD551xiUQUwQxAYYT+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMIMj5rWXXWQyMVHj3d7y1V+2ga/rYS0Ii2nmbARioQ=;
 b=Mo17B/cEZq3ouFcaNeepzhoqL6HCKJ5bPtjPoyhYPSslo5ZMPOGjoKkzvTefd1IJGaaFJRBKcYK39QjiV3M/LS54TuMw8eHAFFSH1If2Hm3gRr4sHuKolcDYiKSUsqLGjx0w3e+SvXF8128d4Eox8rHslfde9IRkTzQpuy3xrUo8ehVLZ3VcUJ07B7ks7uu5il3sS3ULS5gEiAPzsxvliserzGkjAGDHkuBx1bUGTNBzsCVH4nh3ieAu4xfq1/+jhR3tS4mn9McZvs5PtoHGww2U5ZubXIUhVQFCT0su/adLM5qpMUF35HDCLSVKesNosvRbGclTOzbwo5rxqhmkoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMIMj5rWXXWQyMVHj3d7y1V+2ga/rYS0Ii2nmbARioQ=;
 b=mktKW2WnVJMak150geW0YS8as5kJIcbWtpJlDfXyJZfJd25bFhsmMhuHYPe5f7ofEGltML+V/kuGQQOGbQeAGpBmcCiRLsXBfqI9XjpTcfMosFc3HEHJ9ywaiq5nUmhfQa7Bs+/+mQgOJutS+A2k44c9i8OJ1hKkzNvkEP3qxb0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BN8PR10MB3506.namprd10.prod.outlook.com (2603:10b6:408:ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Mon, 22 Aug
 2022 15:03:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:03:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v13 12/70] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v13 12/70] mm/mmap: use the maple tree for
 find_vma_prev() instead of the rbtree
Thread-Index: AQHYtjhIYt3v7s7AtESip6pUI5M2HA==
Date:   Mon, 22 Aug 2022 15:03:05 +0000
Message-ID: <20220822150128.1562046-13-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c3c69bf-5f06-4fd2-9072-08da844f7207
x-ms-traffictypediagnostic: BN8PR10MB3506:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kOwziTIBTqOs/Hm3cwdmNU7/U40vaHlsvWFL2EGufQ7+9S64gJhLZeIy/J1fGRbk3WHqtqolrT0DpqNqteEYwZSybyOqG6ClK0/ufmKRYbk7TdT8tQ0ZwDU8WK4O2VpKcqU/GPkkrSWHMr8MKOr4TC04X+Ho3zpaKfEamfD+YjBsHinzPOd3VFEaOVxuH1ODAkBmG74jJ6G3WfkBjtWkU2+Kxohrk8tUse3lyZjmKtJituMv3XNLS+X2YXC5t5PCWY+T6ZJ34dI3fFfqFul5DADGO+OUyhhXsfE/9swaJQjHS0q4uW84BwlWNZdV18lSlQYKgLc76Pv0IqtX6ZWbO3icGBt9PVrDtglvRm+lyh5dPjpyPOAkAMs0euBE4037www9kbbBXI1vrpwbPGJCBsdp8kNDcGRF3vbgZh1KVThgks7w3t33kK0nBJ9LRoZfUhX5WxV1AHiKYGbcrYZWwEL8wTYfKCCYgi+WV+zAvxLbDow5cOvmTuYY6FgtGqQILqtvslLmX0OQXaLi2wJhSjG8c/jUYmVwlsINSMD4jq2BGhZW3WksIDdCbYs8/Tk6Vozl+fi4ZFyQ63EUYq/2kmEDwIB8oJGrOlkJxGZPP1RJP9K6VA3I0fhg+EWa0LEQtt5MJyC/x3OToHbbN06nFB7SJS4jqCck85bYcxBHsLWk/aY6ok55SfjO8vGNgjjFq869RdUZdR2p9F2xS4A2n6cBBS/tnWyyA30zpSA85yIa41xa0RVQ2p7FTEY3runo/tG0UQ9iVeATKG973N6HUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(396003)(366004)(136003)(38070700005)(83380400001)(38100700002)(66556008)(36756003)(66446008)(122000001)(66476007)(8676002)(4326008)(64756008)(66946007)(76116006)(71200400001)(91956017)(6666004)(8936002)(26005)(6512007)(5660300002)(44832011)(6506007)(478600001)(6486002)(316002)(54906003)(110136005)(41300700001)(86362001)(1076003)(186003)(2906002)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gQtnPOIT95kfXfFOwOOZJYJNmgozd/Ax13g9rFfV0Pj67q7/WwpFyuBmEG?=
 =?iso-8859-1?Q?ZrGqA9W+NKtgLy+N+d8kqJS2gPeOgnoUtrYDKpk1bTA47yuKN+Js7BCsk0?=
 =?iso-8859-1?Q?urkAgfKa9l3Qe5RUHJuY0KgVLyj55nYvAQxJcZhbvDBmqyGQxNLoA2tllv?=
 =?iso-8859-1?Q?wOJD05bbhskoQE2c8jcr7AnhJQRXFUCZ+sAFAwN6c7h2d5+VChZTmnuNET?=
 =?iso-8859-1?Q?oJz3llF9h7Duh/Jsw4tpawPnX6pCNhwQuD73dwTGzyToTOSMAlBHf7XHwy?=
 =?iso-8859-1?Q?tFL6SXxudXaJodnwBBv0hqGy89g8phpCypHD63SDgBXtMCUPeBDUfH/0s/?=
 =?iso-8859-1?Q?Jm2MrAAQjpyO+hrrnHwph1mx8Q7ZXB0BnX+R7oEMJiIw42iIDbIntGTAcg?=
 =?iso-8859-1?Q?oiH6XnU56FvT+WwoUYngbukuXR+dieqbIOiJM8Bgq2yIsJoJvXTpgUZksq?=
 =?iso-8859-1?Q?Mf3OjEZfuj0NC1b1P10W2kvBzTqSdakP7MLuDa62kn4MV0aFogii+gLDzs?=
 =?iso-8859-1?Q?cYupQjOhTPLnDVZgwuZk/ST6L5jDnTSI/aX2apcBW3xuDPl/CPG4o6P0i6?=
 =?iso-8859-1?Q?EO1XlopYLSVr+FQqudg/0SdmzMho6AY1cJjsgqi6uaq07mgjqxHED20IWR?=
 =?iso-8859-1?Q?PbXpi1c98WA8EjuTA2kM/0ZIGtmQrsiRBkdt9Wcf9lv+bGy7Vq6dzm1P+1?=
 =?iso-8859-1?Q?esxHAZu+mCMwqHXt+cD/bbIPGWHNA+ltrQirqs3O0L358Mul0HWPkGCxIj?=
 =?iso-8859-1?Q?g7+BJyNWdMSlSqrgOe5WMi8rXuh6TSmfD6SfClqsn8aCC01b0CsN7VFxyC?=
 =?iso-8859-1?Q?0heDfSjYAWsbTuKDOplD2szzcgNhVhQvIVYEyY2g9X724w0nCpqlaiGFr3?=
 =?iso-8859-1?Q?6eHZhE8ra9yyG++PyqdIkXGHBmGKsILXSA5DzsfljWOMvylsc4Bo0p9nqX?=
 =?iso-8859-1?Q?GrCMmgMaJamnCJz5qgaeAZDVHKsfjH8zxwI/2HXEQIzoWiAgM2ltHTSN63?=
 =?iso-8859-1?Q?UHCqJ4ngFsQZl0XvfAEma7WBXJVRUydoHm1ejxySZ0DmkAWB01RIH5f9qB?=
 =?iso-8859-1?Q?nt3OwilsQrqoMXL8QWqkuAqNcslwe6HvoeJ0Cy/0fPwActVaFjI54qtNsV?=
 =?iso-8859-1?Q?cUuUFBzweAQldWCfchOjQR1rUJUaMkvRwdp4sjdNBGwPqyLHiN/dJ/J3LR?=
 =?iso-8859-1?Q?bSstEfhTVzF7WROME6gdwP4fIx1iV9u/O7oYXp3ohrFXxTTSTJmTraHlxY?=
 =?iso-8859-1?Q?l6kbe8AGTR7tjRMIcBtG95cDQsi062mhSpPiVDvSJWQKLPypoHu2iTKkQb?=
 =?iso-8859-1?Q?C6yd5Zm9CkK5IBBM0o3wQrHAfgUM2Wr+KmuJ4hMNMRzIXx3oNdsA2dmAPg?=
 =?iso-8859-1?Q?sg+TxedIebj3p3HBx8dd02+OApIiPOiYyImPzxF/1/Tql/cBMGxd3ON0m+?=
 =?iso-8859-1?Q?nYKrl9MWEG9kuxRwi/AeBWdGIZA2uPxXkZYQ3YyQ+c9E9RJlmrLwAPQn/u?=
 =?iso-8859-1?Q?5GujX227UVvFhzXIXiE5vnP5ztBfdzCbV7dW9RD+xaEk5YDUe9o0irVDx5?=
 =?iso-8859-1?Q?skyA2c5JEV27jYays0Kbbh6K9hXtWkx5sNRU6Xu3/znPP+VLxjEbFs/3fo?=
 =?iso-8859-1?Q?5dlRGgNYGptwGNABNqjx/OFhHOZd5ZUV5emfSxm7uREHWjtaT+lwyuAQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3c69bf-5f06-4fd2-9072-08da844f7207
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:03:05.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0lJGBuXYzh8/Zk2jSq/jreB2jUePj8zIHDzxPrdVnjBzB9diJeh19rH/7mGxLGGAXFPjxDiV3AuoGlIG3mMxZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3506
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=998 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220064
X-Proofpoint-GUID: fn6VD04Li1Cnvkyv8KxvJ9_-lKK5RR5X
X-Proofpoint-ORIG-GUID: fn6VD04Li1Cnvkyv8KxvJ9_-lKK5RR5X
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

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address of the next vma, then use the maple state to walk
back one entry to find the previous entry.

Add kernel documentation comments for this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dbbf8ee12f60..948264cd39cd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2475,23 +2475,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Note that RCU lock is missing here since the external mmap_lock() is us=
ed
+ * instead.
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.35.1
