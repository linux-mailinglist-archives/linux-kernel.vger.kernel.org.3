Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00AFA519368
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240030AbiEDBV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245367AbiEDBTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78AB443FE
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:56 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243LZnIU026110;
        Wed, 4 May 2022 01:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VbAgCFAt6JvLk3hS6Gx1zdb65kbp1hha96mUQ9g6SRE=;
 b=QaO6fzREavHuyr9cHgNtrQKdzy8rEjsyrq+4TUkg/ktZFFr74cETPXXpLKbYiW/nM8Th
 JjdV3xAg+n58i4NS4zDbaAzWd+6+M3eSpVYyBOm8Z4qYRgMK4WR7K/3rG6bmxs8nawB5
 7+zFAGnsrFsBQNUQlDo8s6D2BMG6q34icUdM3s3E6uP8lzbmxZ/pGrDVOV1hOXMw2KAo
 bxbWGaCM/8phN2xaiZKHgCwIc8coD4mscppoIImyzGAjpxZpJft/rkBXxUhSCVGJWbvl
 ey2uLpTTck9qBQODX+TgHrEOrwJCXwmmbutmF+NkaGOZlTjRY3jEKa5yVnaopSLiU9zu kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72qb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:42 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR0013207;
        Wed, 4 May 2022 01:14:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlCwkdJaXsW19i/Gt8r/A9Y+JiHLh9tgfbeMRW6JqYz4fiOmDPt9XtInbej8qUSnTpZ8NTwHt+2HEN5EI4DBOxpHcg7s0s09hmwC7LeTRhotUbYWbLdB/F0rvG/TmtStUHz2gFBqr2uJKX6zXriJU2aZnzgJKkdr52ytBxjIAajw2n/9JlSPbxy7akz2LYnsJHnd2YfK7kDiIDwY7tKRIO6N8l0+JjKm59CGXb6zZK0x50CWtQt64mMNGLpfNHGVK5YGLKdWCjhZm5RrbC+8iuyt9o56sax897bJNXYvhZRJSgxAnOC+mXXvurqPss6xrMvKwXWXD8e9Z0Tl+qx0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbAgCFAt6JvLk3hS6Gx1zdb65kbp1hha96mUQ9g6SRE=;
 b=bmv9QxMc/zHyTMs+nupXKG100v86idx38gTXwYidjZAuKGVE+AlfmPYw+OSvigqTZRfR2PAjtTdUPHSvbwvQAy/zfrNvARWFENnsqKMlSbz7nNgTzWGOuN3HeWYrVucjcm7nWxEBydSYQ2kt2daAsZW+A0T6Jww8GtRh0MrY6g406awwa6RX1bOszlIxLmGhLutS33K1XVMZJSMhvxylg8lDwqYLzC2Lg/oWbm0g6sTyplZ6LbYHPKKqoPQCGZDAWrDpjTJtgoCp0lWoQFgphEJnyRVjI+q3+mN6c6Q+tiri5b3vOLy2Y7CZNhulCoUPHFVFuN8sUBqkwiijhJxPCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbAgCFAt6JvLk3hS6Gx1zdb65kbp1hha96mUQ9g6SRE=;
 b=NJn5+oBdIx1O/mmJBaRAhOa1OgS14oWBwxA+C0h+HsjNWr/tCYtQTJov9W1MKjmjDn/WshtHkZ3SSCPf0lWzyHF+RkYh749f6OZbixdCwnYDKhZL+QwVacaoodUc+Zr1qX7V16wc3LLOvZ4ObIAeMA84b5+SIICPCzpe94k0bU0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 55/69] mm/memcontrol: stop using mm->highest_vm_end
Thread-Topic: [PATCH v9 55/69] mm/memcontrol: stop using mm->highest_vm_end
Thread-Index: AQHYX1Q+wP5H7hiJVEmW4UwLVkpN5g==
Date:   Wed, 4 May 2022 01:14:03 +0000
Message-ID: <20220504011345.662299-40-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62a86670-bd5a-4b95-e487-08da2d6b75b7
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB2688C9F32162107FCAE603BBFDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MN9i1drmTTe/Aqv1hIXDG0RN3/D0LQonRHNK3jKf0uwl4z29LsKd/VUuPAKdpMwoV8Ea4rkPr1y7AXt8C26xEAqFWHWDKl16Xg3EVRgSA+kts+cCpBtwnZe19F4COyUjJO6B65jN7Tvo+N0RF0vfeFq2Q4BNu9sIFCvtVil4xdhJrYmlp6+OWjs9/i1x06fXQ1xPUXqaJyD/rrHsZuzBznhxdIYXb+dJrKjZyFCAsrIROhQlOEwlu9hkmRZGofv3VfeYb0N8KWKjOF5Bl0kx8ZkQPxm9vphC6oEfp3BXZG+NPNvvB1foGcQJwQj62camu5g5tGVDwjsb4fo/qFzXtPs4r6fxtxwZ9jckKK/1lVpgh91UbQPU/xC7mgHL2/GWnCrYsOkebdDaVJHPmp0Tau1ht10uIcfM2xHtZO9F9ZTvkweU8E4HNaRaR0HYJpdj1/Oj4TcWp/W9LnN2B5sS1BCf5Q4ZwBGv3n+4W8qV5WNKXmYHVsrwr72AeYWLL+2y4y5J9VyuCHyTVJ47Q+J6gWzJaxhnPCfP5LpT+z1neS80h9RCZStnb4RLOvXfJslct6HUzW24F+rjq3/jvWF2awbnQL9mK8adLbXBnaypA2GjEqVESK7ANW8oQx3LKDxVaatErcbxTlg3MGNMaIFdw+iw1t48LsMc3shviI2br3BZIBDDn0D/cLUztVON+KVu9s56NNL0zICEd41YXnE/sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?FeWt+XuUtFN9PeKetMxlJ8gouVtebZWDG1MM5RVOSmxC54lRy8jVxcgrBn?=
 =?iso-8859-1?Q?8ghOXjqBjYh/JjNuKvto1yi1k9ggu8wm7ONfK4aEL4Za/Vf5TfHFBzIR/V?=
 =?iso-8859-1?Q?Ntnf+divoQiCRxRVcjkTA/6Is0G51ZQJxnqrE0We8K0DZR2ts+1W69z8vT?=
 =?iso-8859-1?Q?2dtfn6bImrOk5NjVhcuAt2z7dhJK5LIw3Uv4UQOJCVJFosV/2XducDqSeE?=
 =?iso-8859-1?Q?PG7HR6WC4W86Dq1xvVt3dZl6SI5sIcvCr1pt7iMPm2oLzTlROL6FrsACBv?=
 =?iso-8859-1?Q?civWHECp8TYSDHsVCwXuH7lKs/T4ky4Q/O3Q6JNJXb3f7MdpXLPlaLgKXz?=
 =?iso-8859-1?Q?Ev8o2aQD6TwQs6WyhlRpSfMxI4gh9iQAKcicX4Qe5EECDjKC9KLEId+Fju?=
 =?iso-8859-1?Q?KpTOHQo+rawLRqnwpT4o/a03rFRP4t9qJHs95m6x8WUheVb7nytH6LJ7qc?=
 =?iso-8859-1?Q?UTnP348iVME9Hn4nNSCeEIu+EjAlDFElj8OCd+oLslt1Zm04T/Ca3mOk4U?=
 =?iso-8859-1?Q?0jEYViA/lF9l8EPQU+62JkKxcTfF/h4Rc45pVT/V8XcG3nwCVNZd8i6N68?=
 =?iso-8859-1?Q?5kh/is4W39Qlb1sO3Cm03Vf1xfQ6a9GphxlbBJ839VBXqsX82QN8qI0sZf?=
 =?iso-8859-1?Q?2D/I2BK9ux7Pz/2c5diASch/MiiDnycLshvkBrD4XNsQGkZHd6OTa/lXO8?=
 =?iso-8859-1?Q?sold5SfVcWZv/Z3xFptIrXJ7sHCY6YB3XMAtiR/yT7gFkzQjhDCZpaIGUb?=
 =?iso-8859-1?Q?xURAzYuqzY4Q6yB3IzTdXD83H2iP/3QiRCtK9r45tNaBn3JuZj1VyvyXHR?=
 =?iso-8859-1?Q?jsk9EJ2Vyxrme1BvTwu9HJ+dh7iwwpKW4LvSjt8kpPeQUUdzOIMO3bch1p?=
 =?iso-8859-1?Q?TInv/Jc+plinVKlCBX303eoG/0VMSfzk7xjjOO1UpRG82Fb2CELcwoi00Q?=
 =?iso-8859-1?Q?ZAYfxAsAs1AXew/R9q7/hV32haH9JX1mnIUiiXpv/a6b7je2l50Nz2e/hW?=
 =?iso-8859-1?Q?8j1+6j9rKWtoIw+UL6eoLagI6iYCGpC+vUk8eXbhb6HEWZeFdAadO/KDw7?=
 =?iso-8859-1?Q?+x5NeoGYLf3GXUWSYGpwQYPf1nnVpA0dlnR/SyhZAXo41t+GxPg0z55Vnj?=
 =?iso-8859-1?Q?RCciYG3S1FzH59+RaSZNaRUJPZm0VtJN0k4ReHw7ykp1DclkF8wKk6oOCu?=
 =?iso-8859-1?Q?hHzkwCn82DLeZ1qBr1MOKkGmNlSSEc9hQEw1bGPQapAMDunRrF6q8NTsmy?=
 =?iso-8859-1?Q?+3eCFBfew4azJoNVnvErYyy65qW0jAx7ciD3x8T7L7zuM3HlvVaDN2dx5E?=
 =?iso-8859-1?Q?KAZOPyPhR4F1gPHn6Q5Pyzh+lfjPKLVjYq8ztqcsvOZJ4ZRVSaOpdTUxvj?=
 =?iso-8859-1?Q?qOHcXWdV9W93QGCrVL0+7M9Uchgc7cFNwIT6yj9oGkmRVg9ydBomp0IENq?=
 =?iso-8859-1?Q?fjfTi/6AADOVrawcJ13OaDRcKxVYbllD5hRUH2vnqBDkEUqN/2rYzmKPDl?=
 =?iso-8859-1?Q?qk48W+gw7O6aoHR1t/wXv4wpdvCre3YzH87BhpZzcYmo1XkZ3hX2dnHRM+?=
 =?iso-8859-1?Q?brV5vKXnvkvFcvx9qmdFacAUvfIPJrxW1wtaMZ0sm9IhoZmziNsQPzgTNg?=
 =?iso-8859-1?Q?lQUGcpFkcRqTb67OhGOGBtHRpxZBE0HGB+V7XnCPswvmjdD+GxxCfU6TxI?=
 =?iso-8859-1?Q?YaMymX+4jFT7ZqcqjcBl4td0Lf+nXfjXYsynBnKnnEB9hsvNfrE6OS7uX5?=
 =?iso-8859-1?Q?ttn0AlbNCxaB3+lR9bM+zStkjgmUNgWYkxvDHpVwMoIXWAHBepiPJoq8zo?=
 =?iso-8859-1?Q?LanN+x6B0lzSROZeKI1Ap1JjQu02y5w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62a86670-bd5a-4b95-e487-08da2d6b75b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:03.4387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2XEjbXZGBLbP0SNABn6x643ffeQt23sP+cNwonOVXMzWPFnu3SSaFHGufg3OfcZRM1B22+CESaUG3aYkwfJ2jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: odp-ja5A3GXfEyQ_xsr3nfX3V6U1VVQ9
X-Proofpoint-ORIG-GUID: odp-ja5A3GXfEyQ_xsr3nfX3V6U1VVQ9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Pass through ULONG_MAX instead.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d180ef985b17..ef0cc6111512 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5755,7 +5755,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, ULONG_MAX, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6053,9 +6053,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, ULONG_MAX, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.35.1
