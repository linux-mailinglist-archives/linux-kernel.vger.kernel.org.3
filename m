Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1B6577346
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbiGQCsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiGQCrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EFD19C15
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:04 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMOljB026163;
        Sun, 17 Jul 2022 02:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nxs6Cc0dk3QV6W+mxAwWoMvB/ObRju13VWpGJSZOyMA=;
 b=xl5w/b1Z6D7bfD99R1B4Lljv9nnO1+ZQsvxBCrQ77bAKa3E5jsR5zyEcPWLzwjJ4rsjb
 T7wQ2jQTl4Sc3ObqXTmPeg/SFn8pdBROzOp2evI+b0DvXWWKIt5Rifi6D7rVTMDwztvq
 PxanT99E2cwi2WLVlrX6URbFVtAvPWl53I6mzsRcw8QKGGrWdhSMR3FUuOQjpnn6IZsD
 ty5HhiRoO1PNVSCTf7QyWRGCMlvItwJI+Qfhy8yOGd1zoU3DIW5Z5KINWDOsxoa4WV6y
 jFslOhAg6zUK7mcUa3G0Mrj4uzDtxDzcYm9ok2/z2k+pntdpDvxJHYHrQoUJDOl1TLmC OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY38d005941;
        Sun, 17 Jul 2022 02:46:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d80v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHVXJ0IyAz9fPXKBcLa19+8Us9eAiLKdF3mC0eIPzeBdKprfhhgCHZT8qYCfwJu7dH+BFYBJveAfONL97lbTeDJud9et7EJjPIWU0cy0cH3G3+Kpd+fnWL6efrZZefREg7u1c52Nw88FDVwi6v65XeLp7Ii2ktH7abk/VcNVNx8N42UsCc9EcpUZwInmaTCjocYTPzMLQs5H6yp0t7x3jAdkkWwtvkydKI7LnhwrWc2x7qKsVEeqxbeC+toYUR8yDwPEq8WRTClD8biRnjqK/YXvI62Hc962VrABbxvsToR5+gUsj61rhWLEXz5YgzZ2zq9nsGqPH+zAZD9J0RuTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nxs6Cc0dk3QV6W+mxAwWoMvB/ObRju13VWpGJSZOyMA=;
 b=R2KqwgvHY+UY/KrmgugkJlRC7kfkGYVHvha+7jDc1sJbQjrDj9AdH4LS/EMI4n4be62P+Y1d+Few73VEVnV0WVRLV7G+HY3CBV3gShARU8SCoOuYdyyDE8/6pbbgWWEVJoiwUBzM3g1joWE9SoE0uuCJPeck1nmSY5yYRNbqKrlT/5LKYxd/RZtnksHK1yUSfbiKnw2pBdPUjFr89k1hrJ5ebBuwZtjENnU7lLgF2GQZEwN1XqsroB7hz0761CBdrPaZbs1ZDjRwPMclcb0b8YOYLHbRfYjZ8V7xbrrSm8AYxsAPX9js3ZRXwZvILhdk+Nia09m1QrR5Aca3CEsy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nxs6Cc0dk3QV6W+mxAwWoMvB/ObRju13VWpGJSZOyMA=;
 b=E2YmjzjEgA6El5EhdCsCVGyGHv0DG2JLQLaOSjABwDL1Cqwm8THyj00YEcshXgJPyULdWWH0/U4irS14aOfF8AtpFffhMVoh4G0YSmAqpyIoGn3Ep7QorGXlUkTyY/pE44cUaaZvjjTdb2Lq485AHuGjTr+LTjQznrtDJSaOCMk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 24/69] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Topic: [PATCH v11 24/69] mm/mmap: use advanced maple tree API for
 mmap_region()
Thread-Index: AQHYmYdz9ozw9iQo3UGLR7+piBM9RA==
Date:   Sun, 17 Jul 2022 02:46:44 +0000
Message-ID: <20220717024615.2106835-25-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8eb9e45e-482c-4a0f-884c-08da679e98dd
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6dl9OX1GiXiyMMeIiH9rpPzdxT4KPDs1gp6KPzxVV4QVPk1Svx2STHvjmSQcwjYT0XaiDVm4qOz2BGP3S+jncgvcWHCRAF618DM7X2pDNGNLzZSFBH8iDrMLxy9tNihJ9RdWvOuqGvfwI8L5UVDcwt5+2p9ItO1j9jxpnuipA4SP2lCfQH0B+crpNVupcIoxeVKj0GLr9Or5n6L2t9ZK+mRX4GfU7hBpbY9iqY2H9vSRtP8cwsVLhsZ7vVUxjppAR3bSlOTm08D4ED2xkf1JnxihHFObWrVl1S1jNv3SACl6J8NsWNXAWG1OkXalhVZQ6b/6AN2JNrESssHj4US3P2SUUHovDmCBQmJ9gSh776PL6lY/E7UnMdvHwqyp7zqY5oT7EfEjcbfGk8ALMsGvcScSmLd2HQIMwdPopYHhMZtnf/4trzeRoQqNQp8mQQV30fXwffTKuV6K+8hPzFez1sHTidIb4ZLB1NdMM/CDq5Ciaz2Lci4xMv1x49igrWLQk1CY3QcG2+yfKUU8nXmTzBfkii5D5yiMj4OEl6avwT9j9sLjrUWiCHnDpFdh0D7sNSZ0i4G6MzDesgcJR7jS9Cip+pnPvaZSRC9roKLokgvDPGA0Yo1kIZMd6VQf2hF3hEJb780aJGxe3MejusQRtATiJi5mPQPKTVsthIDwOrHWe7A4bn2Xn/Iz4k/mr5UCPm2DYEYkyx5nafqKJYcAdo66dlbI307HkDefUzvqqAo4iYdDDKk6adDUKPl7GjS4q1hAB+V/mhwCzhMDGfQGA/RFM5cvoJfszvMdzBPWuZHv9h222ek72KMLSqCe9jDletxLCMCOaK5yxOG6tLvJMYMJDz7m37U6zi1Zt9rCvYalR4bnOdYIMA09QyKkUrdy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(30864003)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WbTmg7SGMg9JbePo3zcwSbTnvgGNEjvavhVCsnSOA3fH2i+IoXD53aUa1W?=
 =?iso-8859-1?Q?iFTKdPQghikDNPRAcywgFZy16dn042v2j/W0EM7rgZHmbbkepO7doVFPYR?=
 =?iso-8859-1?Q?DhEwHx0OfYtFxn/RE6Gq2Cyt6fJ6D1u8cROQEzA4egO7uRHCqxW/lMMxMn?=
 =?iso-8859-1?Q?7nvMVMuj2KpIHr/8hO5yyXjkRSN5FaQcrwJPc1/Wpcsc/p/AcKnHPPc+8s?=
 =?iso-8859-1?Q?xNo0jrzhPGhT4lI31TCCHX9UY03mshszazUfeY3FF8sNcEbT3UGWiP1GXh?=
 =?iso-8859-1?Q?0/iAhMOoipCcgIl+3ofe2OadXko1FmTQe7cQlW/HcDZyGcYwtli5bmwcWD?=
 =?iso-8859-1?Q?RHtitn1u7+6qtqXvLALELtEgwqhmsM8pSKBh9WGNplmYoUphiS6Ol3lfNq?=
 =?iso-8859-1?Q?r1SvTCSTrQqMN7imWzl4yd+p1oFVuzMo5wd4ictwK8YC0ro6JvkwRhfnvk?=
 =?iso-8859-1?Q?b+3l8BPW3l73alU1CfkEJqBYcaEFNDcEJtcAXF3cvMbBDvo/DEEkt75URK?=
 =?iso-8859-1?Q?UI5kPt/0MpSlG3uF3d0KKIQjsT6hw7C2A3QY7iDxV5URRLllYZoktk9Cjz?=
 =?iso-8859-1?Q?FVb6eiYR+oJt6/NjRnhJ5xOFQ4/nEXbU5utYrJR8pkVIy0Z28r5I+C4Qsz?=
 =?iso-8859-1?Q?n6+SO2u8VePrdOyZQ43Wfwb7I855L7/hbokgijkagNpAA8o5/RWa/8ndtL?=
 =?iso-8859-1?Q?/qsUSO/Lmb4DF4HLo679rzMHCISGhvo9yp3g0Ql67Y5sZCqq+aqfFD4pbV?=
 =?iso-8859-1?Q?Xz9XElHbb7zXTlh8eN4yliZIaUtVsGvmusD/dZ4HiGjNOeTsRm/VyNRk0n?=
 =?iso-8859-1?Q?UqKNsuEZLWxkkV4l3VatvPpNF/J9n6bf274dh/4onXWu0vS+PTP32aijGy?=
 =?iso-8859-1?Q?FQNW6eSCqCiarnHeR04QT6ar5JH8BZ5cJYRKlFZxU2FBXWe57fKJcBppqy?=
 =?iso-8859-1?Q?pkcw0BFUcd6TKJbSTA9M0NbwsRM51l4Y+QAmisdUFUIrg/9xcQxga6N/cY?=
 =?iso-8859-1?Q?twFkLhDLvdkEMRiaC9PYgXOdHK8w6U5BQN4Ncz2mW8UvpGZFWAixlfft8S?=
 =?iso-8859-1?Q?5LX5US5JDeOxDcxmhUvYkX/VVbfjd3nyd7LqO6L5h+bhH2glSiL4lE/4E0?=
 =?iso-8859-1?Q?NpZhE7OVELJu4XyD4Pd9P1h+99Wz8tIKas018G2GQ0M/mxNuOr5FKBMMzj?=
 =?iso-8859-1?Q?yc9B37+QEElFVAHMxKCOOl9qZUg6rDb7I11jG9WnAlka5cPqko1qxDX2a0?=
 =?iso-8859-1?Q?brqbNwtpE+kibvgfr0wMfQBG4MekOzFDMWNLzFdV15rtneyMusB/8ibRD2?=
 =?iso-8859-1?Q?RABEr5FK1WFJUFXrr7Q3qfVwEznwnjBqkum1aWHMxDowNh4QT2or5ayCl5?=
 =?iso-8859-1?Q?Z4Ifgwutet1TESdSdzK9W4WcAdUEwR57vG/kM5+CyTk7mzc4tbe8XT/EzP?=
 =?iso-8859-1?Q?AYFz/7EsKODBORvHTom7izmIWSrKiTNZ2bmmyFQBpvqe0SCCP+3GbHyB0e?=
 =?iso-8859-1?Q?nCLohJ9v2cpIiZPAblEl9zfOfuJU2jnEBEQCDGKfsXBvglQYL3ojes7fbe?=
 =?iso-8859-1?Q?yLFZJytj4tML0cIksNriougX8xxg86mwcin/eUEPFBIs9GjKFPMxpFVz38?=
 =?iso-8859-1?Q?zt+S12/Sw60eixs1IwGPBRL9UZLifiISxNqt9IG7DoRyesu/gi06c2cg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eb9e45e-482c-4a0f-884c-08da679e98dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:44.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T/yZ2SLYO1kYyzu9qxnxdutraPcl4fFBVIVA+XLIPFrl2C8KrJs0gJ5HTVuT7Tv6E/twLyOSUS1FGyAB3SzWtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: 0IAVLaEctsp6-2Xwa4f1XqxLv-ozQS5F
X-Proofpoint-GUID: 0IAVLaEctsp6-2Xwa4f1XqxLv-ozQS5F
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

Changing mmap_region() to use the maple tree state and the advanced maple
tree interface allows for a lot less tree walking.

This change removes the last caller of munmap_vma_range(), so drop this
unused function.

Add vma_expand() to expand a VMA if possible by doing the necessary
hugepage check, uprobe_munmap of files, dcache flush, modifications then
undoing the detaches, etc.

Link: https://lkml.kernel.org/r/20220504011345.662299-9-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220519020341.rr3s6b4dr7o36cqb@revolver
Link: https://lkml.kernel.org/r/20220621204632.3370049-25-Liam.Howlett@orac=
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
 mm/mmap.c | 255 ++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 207 insertions(+), 48 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 378275cc390b..f60333798d56 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -517,28 +517,6 @@ static inline struct vm_area_struct *__vma_next(struct=
 mm_struct *mm,
 	return vma->vm_next;
 }
=20
-/*
- * munmap_vma_range() - munmap VMAs that overlap a range.
- * @mm: The mm struct
- * @start: The start of the range.
- * @len: The length of the range.
- * @pprev: pointer to the pointer that will be set to previous vm_area_str=
uct
- *
- * Find all the vm_area_struct that overlap from @start to
- * @end and munmap them.  Set @pprev to the previous vm_area_struct.
- *
- * Returns: -ENOMEM on munmap failure or 0 on success.
- */
-static inline int
-munmap_vma_range(struct mm_struct *mm, unsigned long start, unsigned long =
len,
-		 struct vm_area_struct **pprev, struct list_head *uf)
-{
-	while (range_has_overlap(mm, start, start + len, pprev))
-		if (do_munmap(mm, start, len, uf))
-			return -ENOMEM;
-	return 0;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -665,6 +643,133 @@ static void __insert_vm_struct(struct mm_struct *mm, =
struct ma_state *mas,
 	mm->map_count++;
 }
=20
+/*
+ * vma_expand - Expand an existing VMA
+ *
+ * @mas: The maple state
+ * @vma: The vma to expand
+ * @start: The start of the vma
+ * @end: The exclusive end of the vma
+ * @pgoff: The page offset of vma
+ * @next: The current of next vma.
+ *
+ * Expand @vma to @start and @end.  Can expand off the start and end.  Wil=
l
+ * expand over @next if it's different from @vma and @end =3D=3D @next->vm=
_end.
+ * Checking if the @vma can expand and merge with @next needs to be handle=
d by
+ * the caller.
+ *
+ * Returns: 0 on success
+ */
+inline int vma_expand(struct ma_state *mas, struct vm_area_struct *vma,
+		      unsigned long start, unsigned long end, pgoff_t pgoff,
+		      struct vm_area_struct *next)
+{
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct address_space *mapping =3D NULL;
+	struct rb_root_cached *root =3D NULL;
+	struct anon_vma *anon_vma =3D vma->anon_vma;
+	struct file *file =3D vma->vm_file;
+	bool remove_next =3D false;
+	bool anon_cloned =3D false;
+
+	if (next && (vma !=3D next) && (end =3D=3D next->vm_end)) {
+		remove_next =3D true;
+		if (next->anon_vma && !vma->anon_vma) {
+			int error;
+
+			anon_vma =3D next->anon_vma;
+			vma->anon_vma =3D anon_vma;
+			error =3D anon_vma_clone(vma, next);
+			if (error)
+				return error;
+			anon_cloned =3D true;
+		}
+	}
+
+	/* Not merging but overwriting any part of next is not handled. */
+	VM_BUG_ON(next && !remove_next && next !=3D vma && end > next->vm_start);
+	/* Only handles expanding */
+	VM_BUG_ON(vma->vm_start < start || vma->vm_end > end);
+
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
+		goto nomem;
+
+	vma_adjust_trans_huge(vma, start, end, 0);
+
+	if (file) {
+		mapping =3D file->f_mapping;
+		root =3D &mapping->i_mmap;
+		uprobe_munmap(vma, vma->vm_start, vma->vm_end);
+		i_mmap_lock_write(mapping);
+	}
+
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
+	if (file) {
+		flush_dcache_mmap_lock(mapping);
+		vma_interval_tree_remove(vma, root);
+	}
+
+	vma->vm_start =3D start;
+	vma->vm_end =3D end;
+	vma->vm_pgoff =3D pgoff;
+	/* Note: mas must be pointing to the expanding VMA */
+	vma_mas_store(vma, mas);
+
+	if (file) {
+		vma_interval_tree_insert(vma, root);
+		flush_dcache_mmap_unlock(mapping);
+	}
+
+	/* Expanding over the next vma */
+	if (remove_next) {
+		/* Remove from mm linked list - also updates highest_vm_end */
+		__vma_unlink_list(mm, next);
+
+		/* Kill the cache */
+		vmacache_invalidate(mm);
+
+		if (file)
+			__remove_shared_vm_struct(next, file, mapping);
+
+	} else if (!next) {
+		mm->highest_vm_end =3D vm_end_gap(vma);
+	}
+
+	if (anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(anon_vma);
+	}
+
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
+	if (remove_next) {
+		if (file) {
+			uprobe_munmap(next, next->vm_start, next->vm_end);
+			fput(file);
+		}
+		if (next->anon_vma)
+			anon_vma_merge(vma, next);
+		mm->map_count--;
+		mpol_put(vma_policy(next));
+		vm_area_free(next);
+	}
+
+	validate_mm(mm);
+	return 0;
+
+nomem:
+	if (anon_cloned)
+		unlink_anon_vmas(vma);
+	return -ENOMEM;
+}
+
 /*
  * We cannot adjust vm_start, vm_end, vm_pgoff fields of a vma that
  * is already present in an i_mmap tree without adjusting the tree.
@@ -1677,9 +1782,15 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 		struct list_head *uf)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev, *merge;
-	int error;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *next, *prev, *merge;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
 	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
=20
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
@@ -1689,16 +1800,17 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 * MAP_FIXED may remove pages of mappings that intersects with
 		 * requested mapping. Account for the pages it would unmap.
 		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, addr + len);
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
=20
 		if (!may_expand_vm(mm, vm_flags,
 					(len >> PAGE_SHIFT) - nr_pages))
 			return -ENOMEM;
 	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
 		return -ENOMEM;
+
 	/*
 	 * Private writable mapping: check memory availability
 	 */
@@ -1709,14 +1821,43 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		vm_flags |=3D VM_ACCOUNT;
 	}
=20
-	/*
-	 * Can we just expand an old mapping?
-	 */
-	vma =3D vma_merge(mm, prev, addr, addr + len, vm_flags,
-			NULL, file, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
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
=20
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
 	/*
 	 * Determine the object being mapped and call the appropriate
 	 * specific mapper. the address has already been validated, but
@@ -1729,7 +1870,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	vma->vm_start =3D addr;
-	vma->vm_end =3D addr + len;
+	vma->vm_end =3D end;
 	vma->vm_flags =3D vm_flags;
 	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
 	vma->vm_pgoff =3D pgoff;
@@ -1750,28 +1891,32 @@ unsigned long mmap_region(struct file *file, unsign=
ed long addr,
 		 *
 		 * Answer: Yes, several device drivers can do it in their
 		 *         f_op->mmap method. -DaveM
-		 * Bug: If addr is changed, prev, rb_link, rb_parent should
-		 *      be updated for vma_link()
 		 */
 		WARN_ON_ONCE(addr !=3D vma->vm_start);
=20
 		addr =3D vma->vm_start;
+		mas_reset(&mas);
=20
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
+		/*
+		 * If vm_flags changed after call_mmap(), we should try merge
+		 * vma again as we may succeed this time.
 		 */
 		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
 			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
 				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
 			if (merge) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
 				 */
 				fput(vma->vm_file);
 				vm_area_free(vma);
 				vma =3D merge;
 				/* Update vm_flags to pick up the change. */
+				addr =3D vma->vm_start;
 				vm_flags =3D vma->vm_flags;
 				goto unmap_writable;
 			}
@@ -1795,7 +1940,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 			goto free_vma;
 	}
=20
-	if (vma_link(mm, vma, prev)) {
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
 		error =3D -ENOMEM;
 		if (file)
 			goto unmap_and_free_vma;
@@ -1803,6 +1948,22 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 			goto free_vma;
 	}
=20
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
 	/*
 	 * vma_merge() calls khugepaged_enter_vma() either, the below
 	 * call covers the non-merge case.
@@ -1814,7 +1975,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	if (file && vm_flags & VM_SHARED)
 		mapping_unmap_writable(file->f_mapping);
 	file =3D vma->vm_file;
-out:
+expanded:
 	perf_event_mmap(vma);
=20
 	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
@@ -1841,6 +2002,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1857,6 +2019,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm(mm);
 	return error;
 }
=20
@@ -2679,10 +2842,6 @@ int __do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
 	prev =3D vma->vm_prev;
 	/* we have start < vma->vm_end  */
=20
-	/* if it doesn't overlap, we have nothing.. */
-	if (vma->vm_start >=3D end)
-		return 0;
-
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
--=20
2.35.1
