Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34546577354
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiGQCr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiGQCrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259801A801
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ9Jhp024541;
        Sun, 17 Jul 2022 02:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gkXp1BPZGIPwGhc6F9COGavwszXwlOU49pgOQhgiwZQ=;
 b=poMJ3MLnIy9wWK7CMzMLOTK6rJqyVwOoqewJPsOch/pKpvUIAkQfu3Ct3/gSWLF6o02n
 /9OvILjcKxO8njVxQ6jCsyuBrms6hw5ranhJa1KWtEKmjc2uJHxQf5mEpQw9D9rRE7Uy
 Hx4ZMKgFvGOJB/66l2wD6y10nVIUgOFlMfChillysRk67ZvuOt1R17vHIFsMDOQoiz0g
 +MvRxMpn1MTTW3XjYzyP0Bg0Z+Wdur2nUp+9Lequokalt4RDYTJf3zbjNjCvvjsW8GIl
 vx804BKIH3CHrNHJucDs9ZeKfk+d/JZmSyr60UNiriAZg6eGKyAUC8+0u6xEYVZuSgIb vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvt8xdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY38c005941;
        Sun, 17 Jul 2022 02:46:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d80v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ofzD1+4T3JWTH7r1/i47mmaPVTFU8dnqzOyNSkosuZJJhSYc7G7QsQZ2RhR1wQ0c/1GEyfzoaLqgQI0WprYJ3/7OD7c527V38Q9eZKFTyIJyZBlVv5zcydn93tBNWe+hGjFVbmd9XPxh+eaikeDUfo0nPHqgRfTnK207piOUx+BfOQiOEKFAcDAuuJ7WvwXzqA+9I9ag6iDvLHDc97KJcYs6MuWkgWmNOCw68SzqyoqrFveVKpeARvxRBQq4jx4zQRZwlCB53g6QhyDSNZ8fwWuRX4oKaiVbjA4rtz35h7op8EBj/TIJiNO9kqn5wZZpSQvcHhgIGODDGeO8wkZOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkXp1BPZGIPwGhc6F9COGavwszXwlOU49pgOQhgiwZQ=;
 b=lzbTgbn3W4WH/zmfwvoQAePeK9QjG979mJLOhsbSenuvfod/hfv8d82EP8q52gaRKJ1nE2f6HNQ591OMX9OCc1hYh52r9V5QjAIA9lzPoXa/YdVos7JMOY80HwF4nlBcJp9p7h/mPQIduB3Aqa7kHvnM3dl3tk6Kr1Utpis34dYDYt3eT7nw2oWNQ9kTj6ktZtoLnhkhfCwVT1f5VPYyaTh6q3cE8XLVV7934emKWlusA/OnZUMwLgswkRLN4LlYdTDufYMsZY6rmNVo2EdVwpMCoDM8FrfZyUSsSeqIpnasS/fO6n4kcwTBFwkjVQPWZJuqV6P3kazKbl7wLBwgOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkXp1BPZGIPwGhc6F9COGavwszXwlOU49pgOQhgiwZQ=;
 b=sMME69VWk/0Z2/Lqb7RTCQHQtRX8xVQBMIqzMQCxEGxA/0oYuf+3qTWLINIrDO7ewyCL877mBiB8IDHlstpxQ2knKdiZpRpsU0axP3gs24pyMy3GR6goJCp9G87nUHyIvrtHJ9hzcsWR1x7F4ZKvg2+Z4PNNqfDuwl5x/P9ZOxg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 23/69] mm: use maple tree operations for
 find_vma_intersection()
Thread-Topic: [PATCH v11 23/69] mm: use maple tree operations for
 find_vma_intersection()
Thread-Index: AQHYmYdzdmx4mBu7fkql9efdAg92rQ==
Date:   Sun, 17 Jul 2022 02:46:44 +0000
Message-ID: <20220717024615.2106835-24-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 443ed970-6f2c-4b20-920e-08da679e9842
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fhQNT6L87TNuqD5Hj/yheS0i6YYBZ+SvUul+naMFRR3WslWnLUTH3XWwFJyTk/K7CG/tV7XYJ6S++GoEpxf+iRnoJy8MJtIpIGhbhSkcx/BNhzAXOmSjC6/lZpt+CoR63QtOAFJT7P0KcMAaoBMrZy+iLJBMf+F+XCTF507yDRQFhgNTtjs83KrWOIRBdMKY7XNQGsTvhQuydxsb7LeTYhHhUjRz+BnwVHEQfATybBs0OEONhgBlkho2/J9rd3BArvHzfAGqjf+JR6iQj8CY/UTshN6gS03bwy+WjM6kZJzC43BLpuyZLtx6pS/o+qxw3el0ZFJ6Mfcpp3Fag5yIbijj1XkXVkSu4L8S3GEcfq5iJGXsOv5+8E6XRrY1tI1/B3NytQYf2UtW915TmP3S2UwgMTVD8Y2L3408umc8grudxnxsTy3idTZ77UoymW4xsfMl5UL1XS4qXcfLRj0B0Yaqx5TIN0HS7dfCWL96hnQM7zuKJvV10D9chgl/w0LC5tDTyiryyt7PvIGbkvT+ovlGR4Pdz8Y1YARJc6qZT95x9w04qeXm7LVg+h9EU6yZ+hxObbT7ZbeHjkLaIL8qsskRJ3k1VRvcAQueZGnkRlPKTZfIyEkIeFiEfxw36oYLni6qFzprcXRnDgyqBRwsYujOzU3U58GWL/3RlXZ95vjFcs+y4KBTUdo1gXnNL81afuJIdQlcsYa2p/oWmss35lP4Ef00t4ofnNkB5UJKtCNYgbcQu84kb28TVA73stW7AyMSaP0mcJSBbCXZDRoN+g8MainjvQCB+wPS3n3z1sOFuaIiC8YvyJTKxxxIEK/dGiMRZhGWXhgjKOKaOAhHwoA+s4thQMTDBKCQeIrEv0hHs+A7lVaNK0oB3XXeTDYTCp365zwHI8pycAHSV02GtQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wO2nzQYCgZVPu56kUK+YWygZcxTPsy6qNBjo+eiGgds9SjddvLgt8rL2LN?=
 =?iso-8859-1?Q?hdJg7nXnKHYvwHhwKmvqS9kUoQxPhqDJySIBQX9dNLtKKlSxgFXL/h0eeQ?=
 =?iso-8859-1?Q?BQriEHU1E75UbIc3tZbd2Uqx651U2mYOuEZydvP85JgtfU0Ec8COEaDZaP?=
 =?iso-8859-1?Q?Vd2ly/JF77G5xfrYSsCzLZ2EB9Z8HJ3YgL+dNlVGJanaE6Hl1Tokj2Zqi1?=
 =?iso-8859-1?Q?EScveHX7CfyEMlsDiK4G7LoOuALfor9nTTpT7/VCqoAYjhGRcb0kFaYpZy?=
 =?iso-8859-1?Q?VcH1ISa0zKeGqNRBygzyriOuYpDjH/8UiS/wz0kMLJoa2pUD1uHai3Opa8?=
 =?iso-8859-1?Q?YE//kkpXg7K2H205/EfxlECpBkpvQ/sNYdzPyfZTS45gvGQ+57tRj5HGqw?=
 =?iso-8859-1?Q?TxwzVsSe952cZmQTd25zDFY4QEbnnV/gtvs7UtGFJhvvKvLkRhAeQOm1E7?=
 =?iso-8859-1?Q?zxFQkZTfSoS7XriV7ypVJ7n6SMgIPL6PNKxegjAZfdILhCIrgpOOs3RHUj?=
 =?iso-8859-1?Q?xXfPZ9j0574o+hEyKUN3TG/kJqJGbT9P6XdVEZwjPGRMulixgh4qQhmHJi?=
 =?iso-8859-1?Q?9rx3uPD1El+KrogEqbLXyA2Di0BxMOaP+s5HDiC5VXP05p8omGnpRMWrND?=
 =?iso-8859-1?Q?a/XXbfJCACBQ54dRtVI/ZeHOJJ+wuhl0AFASMP0IHxGTa2vNVztZfX+kOC?=
 =?iso-8859-1?Q?LlpdC7B4iBen2Ji22koLCnFbqzIrSf+r3V1ATgKC6I33YKhWkpcUPYFTcN?=
 =?iso-8859-1?Q?8mxWCmilSHyeCdKpl2n7xb1DQRkBKVzL4vjf5DSF/DKD8aQP7qJNvw1xvF?=
 =?iso-8859-1?Q?WFD77gTuJe+vTIYYr7UtZUV7RITMxXDb1dqOgYryefly2FN4CBPe+HrXT+?=
 =?iso-8859-1?Q?AQ9ztkvHQwkQL+57coubDKH2OC3lauU7bkR8cNFmMtnoonI2ePX5k71kp3?=
 =?iso-8859-1?Q?YctTebXZJ7SSFKxhlE9I0/JGIrjlRyfie0Qv1wNADpAdhSBQ0HhZVH66Cj?=
 =?iso-8859-1?Q?uzk59FIbmTN2jF77mIPKsmBX1RXD/TblEIsuIEB1AhRTtXQ2kl3bzHyXZv?=
 =?iso-8859-1?Q?Pfbg1W4Wevkv5TNYryaUAqnNKw8rQqGgwcyh59U+dRGOgjwPqIprqvNCYP?=
 =?iso-8859-1?Q?b/U0A1GgYhUw3aYre2GvR801LE7qLejrMZYiZHehx09loPcbH6hvQiCq9j?=
 =?iso-8859-1?Q?n/Sc5IyNogvLnvgqG3TnQmsiEqoiOw5f1debWaWStuokd2CQXPi3E/zmvu?=
 =?iso-8859-1?Q?W8gdv75ODCyPnIaGMT6tcOeCzn3diQU6GHEmNZ0JiZZ4EgSFmVzwTVQFGR?=
 =?iso-8859-1?Q?V5ci3+maYaPFQE/GwxUIGfYDEoll9+uD8aYwZoSAN4POHVQ4+mlKGrpAoY?=
 =?iso-8859-1?Q?rSFPeRvNLUxLE1Djh4C1vvYG/0GQjhY9kqLpFfFYT6JapGQFgRqqg4fEU2?=
 =?iso-8859-1?Q?2NlMLq9Kl0+ZNldKhDuq5+8deHSa0zlVz0uGvYWDI3i0BZwoBmIsop+Y6t?=
 =?iso-8859-1?Q?S50+CNjBsdPx9CppkWGl+O4Y7EWtrh6qi3d+5TIuC1ty2+Mat3tgBWEREL?=
 =?iso-8859-1?Q?8+f5K/D/nG7HTxFGDTbmc0W0rdUebY05XnrJHUa0lhqNWnvVGiHm+1EY2P?=
 =?iso-8859-1?Q?MPEw/M+mO2Cc1pi0xSBppbUrw9MxfEsJpOPEL70Cu468hj7sk+Ok2elA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443ed970-6f2c-4b20-920e-08da679e9842
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:44.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hq2jkzucTTh2p7/+EnUpRqNKXVONnJvm5acRW1HJHXXTQON8BefYrk/5CVsgVndgkrdON3vbQQeUXZeFGdvLGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: 0jOAdhb12ME4mOGwY3JG0MZF9u0Qq8fR
X-Proofpoint-ORIG-GUID: 0jOAdhb12ME4mOGwY3JG0MZF9u0Qq8fR
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

Move find_vma_intersection() to mmap.c and change implementation to maple
tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.

Exported find_vma_intersection() for kvm module.

Link: https://lkml.kernel.org/r/20220504011345.662299-8-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-24-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h | 22 ++++------------------
 mm/mmap.c          | 29 +++++++++++++++++++++++++++++
 mm/nommu.c         | 11 +++++++++++
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8207fbc6ed87..55b4b53895e8 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2792,26 +2792,12 @@ extern struct vm_area_struct * find_vma(struct mm_s=
truct * mm, unsigned long add
 extern struct vm_area_struct * find_vma_prev(struct mm_struct * mm, unsign=
ed long addr,
 					     struct vm_area_struct **pprev);
=20
-/**
- * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
- * @mm: The process address space.
- * @start_addr: The inclusive start user address.
- * @end_addr: The exclusive end user address.
- *
- * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
- * start_addr < end_addr.
+/*
+ * Look up the first VMA which intersects the interval [start_addr, end_ad=
dr)
+ * NULL if none.  Assume start_addr < end_addr.
  */
-static inline
 struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
-					     unsigned long start_addr,
-					     unsigned long end_addr)
-{
-	struct vm_area_struct *vma =3D find_vma(mm, start_addr);
-
-	if (vma && end_addr <=3D vma->vm_start)
-		vma =3D NULL;
-	return vma;
-}
+			unsigned long start_addr, unsigned long end_addr);
=20
 /**
  * vma_lookup() - Find a VMA at a specific address
diff --git a/mm/mmap.c b/mm/mmap.c
index 7570e008ef52..378275cc390b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2110,6 +2110,35 @@ get_unmapped_area(struct file *file, unsigned long a=
ddr, unsigned long len,
=20
 EXPORT_SYMBOL(get_unmapped_area);
=20
+/**
+ * find_vma_intersection() - Look up the first VMA which intersects the in=
terval
+ * @mm: The process address space.
+ * @start_addr: The inclusive start user address.
+ * @end_addr: The exclusive end user address.
+ *
+ * Returns: The first VMA within the provided range, %NULL otherwise.  Ass=
umes
+ * start_addr < end_addr.
+ */
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	struct vm_area_struct *vma;
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	/* Check the cache first. */
+	vma =3D vmacache_find(mm, start_addr);
+	if (likely(vma))
+		return vma;
+
+	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
+	if (vma)
+		vmacache_update(start_addr, vma);
+	return vma;
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /**
  * find_vma() - Find the VMA for a given address, or the next VMA.
  * @mm: The mm_struct to check
diff --git a/mm/nommu.c b/mm/nommu.c
index f2031f865dbb..b098c0251137 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -642,6 +642,17 @@ static void delete_vma(struct mm_struct *mm, struct vm=
_area_struct *vma)
 	vm_area_free(vma);
 }
=20
+struct vm_area_struct *find_vma_intersection(struct mm_struct *mm,
+					     unsigned long start_addr,
+					     unsigned long end_addr)
+{
+	unsigned long index =3D start_addr;
+
+	mmap_assert_locked(mm);
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
+}
+EXPORT_SYMBOL(find_vma_intersection);
+
 /*
  * look up the first VMA in which addr resides, NULL if none
  * - should be called with mm->mmap_lock at least held readlocked
--=20
2.35.1
