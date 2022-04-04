Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81944F1749
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378054AbiDDOlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378000AbiDDOjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B40B3F8B5
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:30 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DoUwM014716;
        Mon, 4 Apr 2022 14:36:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ks0MLaS8Kyoov0QxjefiyJ302WOzZjkM7bM0MihpgrI=;
 b=ePyAKgfc4c57/zKxAt8DgmbzMWLzXP5QNQiZGoBsS1lB0VVAmUQwQwSJwzSEvz0+EoqS
 x1XyfWfW9x8IGyFxfwdpkUuDD38grnPA/nDqJqBVXFEWwzKySiOxRK1kL0HEaRDxz+jV
 MrpIybJBhDLMmM0D4W4XMKm12eV1W1NWpCRXvApg0zAHOa1Y47G2ZWErBlF8lxqgPE4b
 3iaX+K21q6eb9duu83htVgHMI8utqxfydboJnvyDIq7SwvhhnwUfz1V/Y9mVRyW8r6cG
 GNSUjiic8DqG01BdP50Jq7jV7aHwsl1KdcnSRPDi2a41KfW708D30sb5hs+qTLTtjcES 2g== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGceT027671;
        Mon, 4 Apr 2022 14:36:25 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVIMmQeFqVpjpoHQjp7p+FKXa9Beu7yohFUHInDYeWFR9pYc/up0vS044Ie7j2zd7kmHoz+traYS+SwS5fnloLhm5PFi7dKvWwNNs8OvMSM0ERsDFH40l1t6Pq9TiUn3NaFD+s9ACQhpwXBDyrwQJkbKCMaoK6Orl+KuwhwrJW92uswCDasSC0mTR4z8G51hfc2py9xRVI65Et3F3dp0k3tz4G6wTigmN6zFz/oBF8STwT6GrjL+GNAX9Chx+q8jdrNVGZdKL/utEPBadctQSe+kvMMYp/qexE52QuxhKCJVR1yRI7+oSoBbRun3gK/ZWvwKs9smiZs55oOWdNTFMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ks0MLaS8Kyoov0QxjefiyJ302WOzZjkM7bM0MihpgrI=;
 b=MzrlWYli8Pr3WmXL75Ct96wbupQ/iuYnDDcDjYYqEbVzGtW+PyS4PEcgC7R7X4IcMZY67sAFGvMVHOFqE4966xxBJrwa85GgaxEAENAPBx/oklklKC8Z3khGMG8eVKxR/MDZp5+StUYBkoWQb6JZK0YuWGBG5EM58lU+msPQs/K0iK51aRGLtufB6i7ysLmdMa/AxD5PGTfcwRPh2sTiteu/ZCHJXQqt0GJTskA24wetiH+sS3FHitSIQ+bRPmnZ1CjP+xvDrJA/kdcI+rtBYU/3utskw8oQXEoWn+6cjlqVjfyWawZ3uKZls3yU+rDDD+SkUDbyZM4uw/9hPMVRtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ks0MLaS8Kyoov0QxjefiyJ302WOzZjkM7bM0MihpgrI=;
 b=oG/NdPSnh2b0+HKV15+xlgmushr7dFP6UiMPObCRAsr6gpKxDPIeK6lHKWrtDnZ2x8Jv4bS0hjjslKl2jSm7Mf/QOE3Hwy0XdldrgNsSlRQ+P8Y2WrmyaMgAVVzuZ6O8rfa8r4IqAuoYj/A3lfHhiU9S0TEDp+QqEYKv02JJjOg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 42/70] exec: Use VMA iterator instead of linked list
Thread-Topic: [PATCH v7 42/70] exec: Use VMA iterator instead of linked list
Thread-Index: AQHYSDFHmNjmWAZQUEmbwXjdOO3vgw==
Date:   Mon, 4 Apr 2022 14:35:49 +0000
Message-ID: <20220404143501.2016403-43-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c73ca8f9-5701-4e3c-6dca-08da16487ea2
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB532950BBC5D9B5A018D1F1DEFDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vi66FGCtq/Mn55iG86bTx9pZI5bijM9DktOaMLukqCG3Kde53I3mpIbjK0c76Smt5hIVUJJGHCPcuMhXfYYhAlarGF3zjZlY9V4vApg37L3wtUpMaMn7/ZBo0WkqdeM+fAwdTduEulWdd4B0UAHPV54ogsz53u+t2pssfA35aKSaSXw7bFTQvCgvrXlIDNsONITe5K5ny8b8mWur6wUVyY/VETnqZONo4m5RvGWXfknH5JJO9ojYVYvGqwjayDCE0+VzCyY/Z2tySdVHRVTHG5yv8Lwcn5mgT9rgTBRfJAj38MMXbEd97+Mssa/f8pd+3RLMzf5uRg0Vkip14LtpDy2mxBwPA3AgKTRWRm4kbWtJT3fDC8+Q/75PBxk2mbF518ciVYj0EIjCGZ3S8lq/eYeU4gDg3vvFugx5ghUsKKw/a08lbXgC7qmbwmKfMpLT8NCMhZUDcfxovyhJkyLcuiQXpMOYP5/ZBZ76MoJRXx0aWjHNo74fW51k0Y/coETn7hLAfgBSv0/C8bJe3qBbZq1P8TNjzUPJ2ijXqbqp7ks18SsNoZxtEEIBGzOZy7TKijtjbhCFSzboJdWcNlVhW+lVcfAjEATbJzvQddHDF5rH6Opy3oABWpuS17a2lgmffqUjMptXgqpQcmdw2Lf+VAHQw5bZt8OmU0yQDE8nwsW1tlNIj44D4D2zGBdzi8BH6xlZtw2WxnziSiWzDrvWGw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Bun9DYd5pEgA2HiBLje4gNxIAsPP9LOfdX11eTTLDCiotkQybNezp2LpEv?=
 =?iso-8859-1?Q?WPKk0EgPuFekyqaAjBScOu1vrE8Lt/g5PmJc/fmfSReIDAY3fDHLLRH7UN?=
 =?iso-8859-1?Q?ovzeEgZN8FgpcnjqWoiQAoHShmUK94Tkab822RnztR1hxAF2C8iO72986k?=
 =?iso-8859-1?Q?SQTDP2tjVQASDRqX+eelXohyXNY2eCFymH3eZLDaxSuX/1+uh3XatF9PEu?=
 =?iso-8859-1?Q?OsCUUvwBmtrmpy9c1Hwona2LO6qftVe/G0EOsWCFkdU5nu7PXZt1Wvi4P9?=
 =?iso-8859-1?Q?NtnsmFemLOVNSZkiGpzoMABpk9AAdMQTgvYhWsOzFAyc808oLX/4A2puIx?=
 =?iso-8859-1?Q?BxeKbOV3jXSjjVJ+0lr39hH5XkBlv0DnH/E6uJufmXWaWovWWUeIUK0XUt?=
 =?iso-8859-1?Q?IWkmUmzDvELVZZ1R2QAsO/ty40/7qhrH1XBlpAh79Xq3Du0O8sWueHrMqo?=
 =?iso-8859-1?Q?4boaRDsMuP+Luqv/P6pXSqYIgAtCrrGGS5F7r848g8RAmo4iu5a0yDee3g?=
 =?iso-8859-1?Q?2wQ2jDeps/7feB0z74kTZehtkIsmSvQ6GqQ35vFtvDWMaBMftz+7hfJxq2?=
 =?iso-8859-1?Q?ngHYP+9JRbmBma7EcbcAzu2ZywOU5PQdyM2GdJzE6Cxhkdd3bxaypVhXan?=
 =?iso-8859-1?Q?oZlD1DcOM4TviCWNFAfSXTRwK83s7w/uMlfDSnndFZKeviqcLfzuEtZiTn?=
 =?iso-8859-1?Q?hbdY2xIIIDlOi48dyX60OA76+oO8yVjzkBZBdROXF5AgKXwhXZcPvnACYi?=
 =?iso-8859-1?Q?o69fw1dKTIEaCDTQZCYPmqHnrwEpawXHuCx1u87wWkFLVlwYxURuiJ57QC?=
 =?iso-8859-1?Q?B1/bRhQF+GPSB9Q9NQkIIeT4rQ4bgneb76RgA0/re33GLZ/+x/IuYy60kb?=
 =?iso-8859-1?Q?ME+R0qA6+1NRI5BVwQEQBwsN+93wol97BpTI7359w+A3eznHAWwD6Wdv1s?=
 =?iso-8859-1?Q?wwiDRUKSzINMpMUTxJZ/A4mNhQDzS9unBXMIkoqvkigyzbPxW0pQZL0pTt?=
 =?iso-8859-1?Q?Q79wlgffUB6VYeZnpdQK6ofvSelVbuo8473kRgHF/oBKI4fsEW82c6cH8z?=
 =?iso-8859-1?Q?qN4K9t6rmlQSY6XynnCwkejhQEfiL+hkVTuCh1jM3jTlFPiwoTeoP8uyyG?=
 =?iso-8859-1?Q?zm8eSjRI801eE9vAsKvI58Dthz4cGTiDyUtheIMVOBzBj+8RvrMyob/T7v?=
 =?iso-8859-1?Q?6d79MUzGOwOCEg7Px0VYNkChOZiU9I5nNooq5lEBoSeBBR0New2FoQT1aA?=
 =?iso-8859-1?Q?Bl0ePEraIYMxQnPyiHKlDP0lU6/1EVdHKJ46Ob+vuIx4PzqV/H4ysJ5VYT?=
 =?iso-8859-1?Q?JkgLkFZ7Rs9egLQaUl4bWFs902w5hxtp1ZEjXMZVntEA1oXkQL8gpFcIyH?=
 =?iso-8859-1?Q?AzCSNXHlrgl3UCukvy7IGrjitsSlffz1K8idTPXVK5H7uTQUpYsty//e34?=
 =?iso-8859-1?Q?swiDAyx3aRIqhuxWnV5WFB32Aa2yac/loY2mAxVzZsxIM7B6JG3lfdl+Qp?=
 =?iso-8859-1?Q?jTnVvJWhTBP9sdpGNL57bdxurZ8KCzJZAQBOJJqDzbeNLvrsiZEjDHr/nA?=
 =?iso-8859-1?Q?oga5Z722Y5hwB6mSf5wp56Cdxg/Cyv5hsrOaQRtlNy317IgoAXwiyQP+fk?=
 =?iso-8859-1?Q?i4dBeBFrr1U7ssKVHFNkv9mneW0+gDyfbp0iBcrHFJWW4rny+Vs34mspUC?=
 =?iso-8859-1?Q?pASK4SK6W4fcTaS3uUuvtum3vgooa9ytfgBrtEP7U6pYEZ2HtsTCJHNmcH?=
 =?iso-8859-1?Q?afGi5qtngQJpSd4isN8jHjRrd2Am0hXPDIWYoiYY2KP0rXcHCwPHl9WtD9?=
 =?iso-8859-1?Q?pHJWpUUEJ8onExzeJq90QPf5IblhEsY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73ca8f9-5701-4e3c-6dca-08da16487ea2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:49.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rBzr1kWxW/icJlhfMMoHR/JtNwHkjiHfo12iV+x974PA536ZIS4FKYvzWpT8cQUgfO+v24DMJKB+/JEjSfPing==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: n-Km8rkevqEvvFGFZqytXH-j7sTzePSc
X-Proofpoint-ORIG-GUID: n-Km8rkevqEvvFGFZqytXH-j7sTzePSc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Remove a use of the vm_next list by doing the initial lookup with the
VMA iterator and then using it to find the next entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 14e7278a1ab8..b5e3bfd52b53 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -686,6 +686,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -694,7 +696,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -713,12 +715,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -727,7 +730,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.34.1
