Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6795E553C13
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354909AbiFUUwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354710AbiFUUsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76722CCAB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:09 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJDHro011633;
        Tue, 21 Jun 2022 20:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=MLVGhfksP+EAab+xSp/29aXNAqKokm1BBAjtIUp6Yrc=;
 b=QPRGSTiHuy6W3Hu6wD8oG6zOyZOgfRiFqqHwJ0r9D3m+u7ZGSxYrMsqhUEN0ElvjWM2K
 tNc/z3Mzt4o8zBrpVhoSd6T9EeC8U91H+qBKQyhUieBibWJWMTHucwNIiBCQdgBZzOgS
 ITmxGtf7drC5AFAoEB4ArXiGZ+egf5Vj1F+ZdFThpJB+B2GctknyHEFzGgzHViDjfHVt
 X1Cz/T7xDBBMgi754XZK+sAVqSliAIbkjuKCGJHqg4W1sLzimpcorrkGkRRuZ2EGASPO
 KPyM5OndWaQtaPTd3Jhbop7aURdZTGKfbwy3pTEN4/DDxDwPh3iBYdO8dwf0QBv45ubF 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqa9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYO001682;
        Tue, 21 Jun 2022 20:47:56 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOH36iw4qlfy0QuvhC1lN4PBTYHsI5W5HjlEGdGWn54Dyo1gL+LT3ygGJB504N7jgdzjbnjCwvLJK6GnVXifSN48KByhl2NIreDbpKya31wI+6NUkU8Tt9sVY+e1Ups2w7GVLM4Nka8Bf2YPUvnjAPnhKkoHuVccN5byhBeOZoUtsW/dH89kqrID1slvU1uNqgT8XNDGaJxoNu1Y66WUFuNASy/8fW6Jubl2WtV7ULkUdm0HFAHFmew7TC3sxCU8GS5l8dB34QG8Ec4nr/vche5TFSGklHwSB+W1WQpxYKqQ+YeQDyEP0zDFd/Z4P1Dh69GKHtc8lmZV19y/8sHfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MLVGhfksP+EAab+xSp/29aXNAqKokm1BBAjtIUp6Yrc=;
 b=aYThmJzppcz3K3YN5s+6WKk5xppXb8/2G2q99Ojl6pjEiCLtMwB5zl/CfBMMAWF462mp6jKWN3Csz/O0PwnQnsegQxsLu1MjpA72/iCrNsARhbT3VLgJ7PD1mjiK71vik93gN5jjG5l18BX7qNv82PZiNCjrdi/gprZLKfhdF1foSOWgsc30DySW+DU75jwX/f8/QPVrfzr0x575s19UdYeDKBORN9HRpOndfAlglVTSB+ik6NXZid7/7x9dUzPVacMB6S9b5GUJGp84ngRaJoI7gbKFm3tiupSVGC+IMVex4i7+S0Da4/SzRDRies0Zzcg8WPgU8ec0rmWz993DZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MLVGhfksP+EAab+xSp/29aXNAqKokm1BBAjtIUp6Yrc=;
 b=KmkCC2rVpbcxmy/jL4TnCVhZ3rBhIkx2lEGTeiXRDRYaPBZNXn3c7EHmR6L5b3z5fmUxRPOWwQXcKlFl3jMhJjmiPX41he/aAHgJmxZ4njGO0mT8fi87K7HnO6m/PQMWoKYi8SP6YCP1ytjLsm7XKHF3XFaozcayMldaLF/Pyhw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 52/69] mm/khugepaged: stop using vma linked list
Thread-Topic: [PATCH v10 52/69] mm/khugepaged: stop using vma linked list
Thread-Index: AQHYhbATq+rB7MopNkOuWjXpQl/bYQ==
Date:   Tue, 21 Jun 2022 20:47:09 +0000
Message-ID: <20220621204632.3370049-53-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 535bf2da-cdba-470c-fede-08da53c7502b
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB5392544883D394159072C8A8FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xjm7eVuO8tHl/yOuuqdlCsq5TVYWwtteW/KFZt/7UqnOuGhGULe+pHw2zzZZuwvu51L35FPns2JuVpeaOt0uTTdwIJRanBIZiivhBy9YQRfW0e6OaoC2GuaPTizF2K5GMMWNzdUQ7Y/7RdJdcRIActXCAwvjLkL5WM2fwc2wyy33kSMECxXiP2KW3McWSW0VwQMznZDhVjbsynvdPuJFD1/I1kUrHn54m3DgKERbBHYb/F/CRKJ3ROYvBAR4Q/0MmtZaSF80VfMFjtBCOTg8tz7jfBIjwz6ZgROK9CBLQ/aHl6VqrPkesgpqPxmb1xsJk4jys1+CH1w4A19to1twyNHi4w6c0WDCUpNoIH4HQATS6/o9xr9s+PVuYQDOZRdk+QK9MD4qprFoWBmMJ4vnPiSJOlrDo3YbLVUczylEVcHj23uPDiaz22LT+4dNrDf5fyARG+87z04ssyDO+zQi/Qex0E42RCheXuz4j9dyyoatGUyDXg4RFYtqx4p7CTOIgYDqMpzpeFSc9HuVkLqZqTKkuEja2tiqiF9Yx6qbDwJshD3frmU6M4HXdbvT0kDYsfAxsg6rewX1YHoJ2Ww697ugL/M/9UU6B0dM0llUogsafPvhAd5Q5lUEr2uIj3eIqkw89HbBZQW06+z6kD/itS0qg4RWIc/Y3ePNwfz28RHYiCe6MTB+nZYJEvbOkZPhCvOaccptk2w6v9ipteDqpvK9rWveVgHPm2o/3ALhlSDryBPAb7G/w0L2LCcyXZSrQMfhOlyuvr/CodiiOYqGlLQUt6QH0ue3q326lT83pYg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?THytX38RoBhiimkhpZjs51GaL3rg5W5eq27iLq5KOHd8xBalff6lHfeui3?=
 =?iso-8859-1?Q?uMOfHS/VmHQBdwttcHdjsXTSar1AHrESd4u8QsKRjDO9R8blPSoBY22ukd?=
 =?iso-8859-1?Q?MveWiFWpIXpAx/CaMab/ip3xUlQWFZWocsAhyaxhdzYhe2G0hZk2LoObfs?=
 =?iso-8859-1?Q?GDJw87FheVWlhO+Cj0eSy4O85WWqow72JgKLdsZuKXHVnBiRlhoXP+t0uC?=
 =?iso-8859-1?Q?sIqjDS64flRIWh1t+ambH5AS7AUJhYGf+/KC2nQqe6bJLrQmLhJ32zs4um?=
 =?iso-8859-1?Q?mEUSdSEsvUYPyNBW4sXeqapynxFsw39Qhlj7D2UAgjD4/eH6bpbgmqF4xp?=
 =?iso-8859-1?Q?qp7HojWnkobw3CibRDjU+xR++n326U4iG1t7HOj59fUf/8UHEFvGwnypLP?=
 =?iso-8859-1?Q?XdA4tKDIbmRJOe4UwKf+lsu3OS7TDS46lv+PftLQx4Z6sDKIwGUwDDQRtY?=
 =?iso-8859-1?Q?YDoR+SbOVhiCaR7II0Ry2Dx3LHHqy8SigtONwD3dM6UZuOMqXThk9BZFvT?=
 =?iso-8859-1?Q?wfGISFB5s/k71U7k/CQnxOGz4SnRD51CDCx2KHQb2E2Qzvau4vrDf4e381?=
 =?iso-8859-1?Q?2EKmPneUinonrbazPg24/Zi/LYqoAhFfRZ3Py3Os0YdvQq6aVSINWcZ6Th?=
 =?iso-8859-1?Q?dww/yXyP8DCBe80N9yI5fvxLvC+/YE5S0ctYaPb6fjx58NEKVKzERifIdi?=
 =?iso-8859-1?Q?LmO0hoxq8//m0xYZEykIYNkO7+rWeWYJHpPVXNBnkMpAh2/koFRV14mfWY?=
 =?iso-8859-1?Q?LKimpQbcWLf/c6pRApjt8lphxCb1XqzzLUq7YPzFoXOK6Iu/fOwpTcs2Iw?=
 =?iso-8859-1?Q?mefYSxArpAj6godRjB+eqWbUAdHEU30ia5pSaw78JKM6+zR/mcHg+j0LtG?=
 =?iso-8859-1?Q?ddRIFuJfGZD5hFDfrSl7330Nt5bVTEBdbc7mFIjH8nK6nzmYXMUgu5m5Yc?=
 =?iso-8859-1?Q?Q4eYB0+ODKIizSd5IExo46gvL5GavXTF4BBVIFvbgxc3M+9XZZA2I7dPqf?=
 =?iso-8859-1?Q?i6LlsXwKB9kEwNpi9CtuXi5xFUc/yBmPIwYT7J0chkgcXPgdwYO0ouA903?=
 =?iso-8859-1?Q?4Ntp9w0HQxzkpKGLZI9jeLDy9xZl4IRb2vorFLZz2s2Xu1tPUhPS05gRyA?=
 =?iso-8859-1?Q?UIl9wkLflajWlWuB6cLdeMl4XjCp/61SXHSvvnBNlm0tC9IgEMbsb9iBES?=
 =?iso-8859-1?Q?pEnd0WT+O3R6psCWxlcwbe0b9evbDWlYeVWOUq/co9LQWgiw64ygaH+BY7?=
 =?iso-8859-1?Q?MuzHzCGh0uyC/JulV4LyQ9cIPdTT54nEBo2fTiE+OMwvS8zCCMo92sV9eV?=
 =?iso-8859-1?Q?J28sa3cSjFQKhsxOCpg42JRP5fkPafZujiYXETKv7S+JphbYLr5SKFdwlc?=
 =?iso-8859-1?Q?Jk5gtvhaKpbJ4tbIhLI68/DtuckMUL1sOrdlIHgnf05R5GGDiEYiwlFNpJ?=
 =?iso-8859-1?Q?46t0RggX4eeIW3pqpNwzRoZEWTybU3nA9DP3Jht2jBNfsEOkA0vzgn0Gpz?=
 =?iso-8859-1?Q?oiQqa1/RFGgXRg2JxJrFEOeCpLg5gFN38a9IeONw/x1cgRiUo1ek/aS1VI?=
 =?iso-8859-1?Q?m94b7F/JTFbjdeh1Rl/gsqIrH3oV8T8XzfEODNXw5EOUMIlDs995mw1Ptg?=
 =?iso-8859-1?Q?wW/k/hhFaedQYoKt0onwA+yB4Eo5CJeNbmOPLvnzz3kxQLSXWrpUYf2DEo?=
 =?iso-8859-1?Q?HFajjbwroyM4Bk3EynhfoWbvf6IdAfJDpzLTd28ccWprbRY39W2wd5BOL8?=
 =?iso-8859-1?Q?1nWID3rAin7plmYpM5t+XKvrfLQgMrI1hvcNXaqke+7bbVpL6sH1TDWxVl?=
 =?iso-8859-1?Q?f7mCzMNaHkI1uJb1OH1bO8Ed0uIs+6Y=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 535bf2da-cdba-470c-fede-08da53c7502b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:09.9096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJcu/GfP1SPyVoSfMKZLvNfmI5DBZsfcjFUkFrldV6EWB6RWBc0OM7H5nnBQaK0poXNqgP+GEJ7JGmxwSH8Fgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: gl896U90UEoeW7rxMF84OqAavwfYSFZs
X-Proofpoint-GUID: gl896U90UEoeW7rxMF84OqAavwfYSFZs
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use vma iterator & find_vma() instead of vma linked list.

Link: https://lkml.kernel.org/r/20220504011345.662299-37-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/huge_memory.c |  4 ++--
 mm/khugepaged.c  | 11 ++++++++---
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f7248002dad9..f44ffd3bbfae 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2266,11 +2266,11 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
 	split_huge_pmd_if_needed(vma, end);
=20
 	/*
-	 * If we're also updating the vma->vm_next->vm_start,
+	 * If we're also updating the next vma vm_start,
 	 * check if we need to split it.
 	 */
 	if (adjust_next > 0) {
-		struct vm_area_struct *next =3D vma->vm_next;
+		struct vm_area_struct *next =3D find_vma(vma->vm_mm, vma->vm_end);
 		unsigned long nstart =3D next->vm_start;
 		nstart +=3D adjust_next;
 		split_huge_pmd_if_needed(next, nstart);
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8dbd68c414d9..637bfecd6bf5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2092,10 +2092,12 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	__releases(&khugepaged_mm_lock)
 	__acquires(&khugepaged_mm_lock)
 {
+	struct vma_iterator vmi;
 	struct mm_slot *mm_slot;
 	struct mm_struct *mm;
 	struct vm_area_struct *vma;
 	int progress =3D 0;
+	unsigned long address;
=20
 	VM_BUG_ON(!pages);
 	lockdep_assert_held(&khugepaged_mm_lock);
@@ -2119,11 +2121,14 @@ static unsigned int khugepaged_scan_mm_slot(unsigne=
d int pages,
 	vma =3D NULL;
 	if (unlikely(!mmap_read_trylock(mm)))
 		goto breakouterloop_mmap_lock;
-	if (likely(!khugepaged_test_exit(mm)))
-		vma =3D find_vma(mm, khugepaged_scan.address);
=20
 	progress++;
-	for (; vma; vma =3D vma->vm_next) {
+	if (unlikely(khugepaged_test_exit(mm)))
+		goto breakouterloop;
+
+	address =3D khugepaged_scan.address;
+	vma_iter_init(&vmi, mm, address);
+	for_each_vma(vmi, vma) {
 		unsigned long hstart, hend;
=20
 		cond_resched();
--=20
2.35.1
