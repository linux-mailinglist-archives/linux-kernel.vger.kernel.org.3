Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2474F59C267
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236384AbiHVPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236500AbiHVPLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:11:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7B71129
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:14 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEireB017906;
        Mon, 22 Aug 2022 15:07:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=m21AhllsAcd/MRRvV0zHZQfg2vRAHMIEsPNCbbO8Z2k=;
 b=lEeI0jQKUTrxG3Vz2dDwBqE3KFQih/TkHYAYnb2wlIxMQZMLhp7RK98pBw4zFv09/6aA
 oP1EC2KhmJBDsKkOgl7aBi3WjcAS39wvVDAHpXAbUicGXpzOSvdf2uWFbT+y4RX5nREm
 wircRxPXp9dzb2NUI9u6OGSFhBDD2qHCc9Uftjj2Kt5w9HOfQQtDMALD0ikVkz7LcW50
 yZXo4QFN8imeo0Dtw4V8dD1KwPCOk4bViqjnIL23twjbRfdvfMMGNrK+niFRGZfGxxu1
 YHjDLd1xrWCVPu6LIsLqwUfm44YxRDIVS0ZXQEo6sAAQ5KYLP8PnnDJIHxxBGm9aLgE0 Bw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt04dt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:11 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4MWn035318;
        Mon, 22 Aug 2022 15:07:10 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1u2en-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUipgr8aVVXCokXhO1niLs9K+Ozrn3tYQSIbTLlTsYb4z4UnlHx6ppD3C2gHW3iQFA3jogCGxR1gh/LyflrMZyIdFwI/5Y6P7DD2A6K2oKjCQtCJht8znMoCSga4jezdN868mrJWhxXUK04AUmhz2GZznfQMzLdsOkFsZ4DsrjnewG8GXW5JSpswjpK7KmDUmjhIpKn9VJu5jApXyT5Zx3yu8ZHc6u7k3ocrMwNP4YGhAeYipT3mliNhh0YrTjaTnfx9/HEHAgPT4qJ/bmF5QEDab272FnYR/hMbrjRrJWJ+uQIhrvAkm2wM7oJ0j65zUO1up855OcU5INetpnTxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m21AhllsAcd/MRRvV0zHZQfg2vRAHMIEsPNCbbO8Z2k=;
 b=ne1pJ42naCdwzpp8DjwnOVWRtmQAVzrj2HOKniUcpqP5cero2PVpz+Fl1MyAwJjsLN/JyOwOwPUpOWffwTNTYKmHNRMokug0VUQCLuMUNBPq1diuf816ek7r4z7gw5xIJ1dknddP3FtfgU9UZw8Kz/LbeaIaGZjcBX5ENam2+rXYQxr9KlFLg9vbCVlNfSIlm0fslccBj+AoXlKc63QYNL6VseBAZP2v40nK4hx4VPIyHc70+8reeoVcZKWt/UPn5wfh3M1JDPrjkGcvq5No7ovHAXtL1o3vlXcNt1upHfdmRV0p9DaeiFyu3A78GqY1PSiu43mdCREeEACXf2pSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m21AhllsAcd/MRRvV0zHZQfg2vRAHMIEsPNCbbO8Z2k=;
 b=UjcX9JnhHkLwuOmhZfVQoD/QfaACHgMzqtyW90eI3qguJH3OF7dBl1QeATrWyidhJLzy04yvKN3waFAtv1Ec0S1gcNBbqjz6G55UqDPgsr7t6cJxd7qlBsIEMDHAI54Ruh3x+LtE+ZTW8FdL+07nxJXkJxqIB+V6P1SJ3iV/gB0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:07:08 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:07:08 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 65/70] nommu: remove uses of VMA linked list
Thread-Topic: [PATCH v13 65/70] nommu: remove uses of VMA linked list
Thread-Index: AQHYtjjDW0UpChlwrkixEg6Be3Ot4w==
Date:   Mon, 22 Aug 2022 15:06:32 +0000
Message-ID: <20220822150128.1562046-66-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf614862-d6cb-425c-ca83-08da844ffb9a
x-ms-traffictypediagnostic: SJ0PR10MB4512:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDOBG6S1wXryt1GeRyzPn6aysSn5g/EtWHzFEzfIyvzDKh7X4GfNxoJCqaf7W8lvFVAK5xLlG2zaFIKGoVbFaESu9iJ+mVfHcVOyF17n0/q8t0iGacG9Yi6IgtvpArNsW3kvYFe1HWrP61aJBg5oUxdQfcx061i7LBh+YfzLNy06CaIa5AokCmizEhiw32/HcodfaXnUMYoOPxQjhQoGZdo0LseMYJyEcDpqu1ge04injgXMdQZ/d7jNkcZreWY+A1Dkrs8qgz1S/n29PjxurTKb9yHl5kMpXxPRPfSncA4DIicx5JTgLrpA8+1iXwD0GATd9zfdhtDmdmofPD5XF/uInxS8VnPMmhr+QbwOZGExE1lWXtGPCX+8Xbkwgdwpj6ZF8crKsXdPtdtATf+SYl3R8JMAd6jDaaRaFzOi1d1PpWKCwEk6PZ1xCPNp6CrSFlc5pgryeTqiNi1DFN1K47yG4N+8LgFk6XX4V/64ZzjWImuHUoTvmAym276iwySAKNJykENI0Wm9Aq8vnQfFxeDUizvSdx5ioJ6D8HcKiDhgE6e5fDqj6n06wBRQBYp1y6ioBW4dWooAgaYyehUu1V7lfc7IGnbc2Z8xsmx5PQvlBmn8cjID+Y/7gNfKo42rzLRTOEmrWZB3X/cYDSD2QpPqKRIf5kqrBQYsRPOvWgpfkKSZhYpWNVPIJncPOpZYfqvIzZ4Lo6esNQyhYQ6OGkibvRcyDyVWem0xD0oqDYyJiEAg+HEd10TNQtZGssBaSbi+4646EC6NUJu7s6gjIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(376002)(346002)(2906002)(38100700002)(86362001)(38070700005)(478600001)(6486002)(186003)(41300700001)(1076003)(2616005)(6666004)(26005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(8936002)(122000001)(44832011)(4326008)(54906003)(110136005)(91956017)(316002)(76116006)(8676002)(66946007)(66446008)(66476007)(66556008)(64756008)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F0r5kV6CDVlVifQO340mCoxcMRLUYtyWYEZA7CaU21iac5l7rtsbBqySzn?=
 =?iso-8859-1?Q?l5wt5hfjOMBbpr5ziOFUVI1FC1Ww3wSKqJTSBgT/q/p21LkqfcVLG21+X9?=
 =?iso-8859-1?Q?Cx9qgmRylnkdpUK29fDprOH+wmjzj9BUQGvV1VM+DpPyZG8HNIwXoTFkC4?=
 =?iso-8859-1?Q?HRn67mL5kFTZsP91rBuTwUpIrhkK/QflRDNfBHGCjkj0bD/QrrjaEnW17m?=
 =?iso-8859-1?Q?XMssd30c2M6tchNgk6zWaiy4jZrcqiYh9ZgKYo6uGEf8eNNv2ICaqPH9ko?=
 =?iso-8859-1?Q?wpYe0rtqLawjhLtgDBzUvnmx1zbtxLxGtbIj9wP20mMD7rtGh2SdSWNMnz?=
 =?iso-8859-1?Q?2+naOPFTsdKzsaH1MwzakDlzUxWBpV3dZH0FwHmIfO5vPGr53loM+Mz7Yv?=
 =?iso-8859-1?Q?M71J90kGs/ilmQQS2lju/kIVPUvO/0V/cd5iKF4d4L1+k+w6k+Sca9SF1T?=
 =?iso-8859-1?Q?zPLPvaLxgQXvQjCJllfdNX1P9MzTASwGkc5ISlBizo0c+83bwb0a247dhJ?=
 =?iso-8859-1?Q?KFKi92jT7Q0yQlKUtWdb4V8UjGotpiadjLw7Yx39UqoCY1sPvQaQAl4AoC?=
 =?iso-8859-1?Q?7BweG/5girCPC3o3y95FXgKhtbunNdhbMv0RPBk+Lq4/1z+wgYppHH2FE2?=
 =?iso-8859-1?Q?9SXikP8Dd2OXfGSCKiPpjIp/oMYPgZ5gQIFPrYPwBKyfbUfEPL834gk6gB?=
 =?iso-8859-1?Q?BuK2Pt+NTZCHUD8+l8hZokNRrP2w6l2fUOfjnWq2wcuv/nl4qZnN/5P/bU?=
 =?iso-8859-1?Q?YnjZ0vo6XUncPc24+zJIht1e9egQmPS3JMlKwOlNWjDQV34w8Uy83DYb0V?=
 =?iso-8859-1?Q?5pGvbyO6KAqXD2qZ4VUCDQVtR2k2yvje0n+yvHt8fKLulYej3c7GJHIc0v?=
 =?iso-8859-1?Q?Z4kA2wTde26Pz4nDKmzM6HBVKxbAZp+wZ1cmos6qH9NRbhZF40s84DS4RC?=
 =?iso-8859-1?Q?A0iNsnYDO6SQXrr9gkhnoSmdTHVn12K6EC0JDyhe2vkih7mNS8tKERNIpx?=
 =?iso-8859-1?Q?tHt7aERGdxzuh0hyR1+9MSQ6mJac3jtJk81Fzps2NBf16q30aVg62yKcHF?=
 =?iso-8859-1?Q?QRtpIDEmxgnYnacfa/X3TRsEhDM0eCK9ANrUN2fKbYnHM16hkMeC7/sTky?=
 =?iso-8859-1?Q?UJRaPrn1PG88BJQkbPRVVCOsRy6xjm64nZHUfCiWShmFHcVG/D/Qs6MKbV?=
 =?iso-8859-1?Q?opHOMWfHnwPn8sSNizyvraAsh/O1moooztmdTB4DOLQrzPwISRDh68LFXY?=
 =?iso-8859-1?Q?YD3Ds767nxG3neo10E1I9CltzLPDV96Hoi2LjhBYyimjJAexVmmFK79yTQ?=
 =?iso-8859-1?Q?yrUjcySI7uGRktMLq4bABDpCkzKNp1cJxczFBHGj7QWyYRj5aSoGC+5NYP?=
 =?iso-8859-1?Q?zo8W6pXhFcYg93wFQjVsJR2Xg/Ey26SC650k35MJJErcgIYlXiadw6O1n8?=
 =?iso-8859-1?Q?1KLIr6K46goOL7eo4b+06zl4p7QE0mYoPADstSqfDkG3OHyak3JoMrq5es?=
 =?iso-8859-1?Q?+XS62B8e+Q8G4kk/TtlJ3rD+PfqeRWJyJk6ZgI9hQDXVXsY7eoah1tdGVT?=
 =?iso-8859-1?Q?GxeWx/JFODY9f8Vn6D5gyHTnJuC6YpN77gLD+VsID8bUi+gA94mQtIuXur?=
 =?iso-8859-1?Q?t262qwztWMAumn89QsyPPvlChnI/MLVEGuYnTtSs5vL4z3LBiyfpraQg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf614862-d6cb-425c-ca83-08da844ffb9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:32.9096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Fi08GWG1dsyVPQcOYWlLoJAa7X4Zh5stwyhFKwUG1eyPeTbJveuNs/cTxiJ/NEVtiQjldL7fGmg0a6m+w8YQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: TauJmIh7sHe0BjQPbyO1f7pu6wafyfFT
X-Proofpoint-GUID: TauJmIh7sHe0BjQPbyO1f7pu6wafyfFT
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

Use the maple tree or VMA iterator instead.  This is faster and will allow
us to shrink the VMA.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/nommu.c | 135 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 34 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 265a444a2cc2..171faa07e577 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -557,26 +557,14 @@ void vma_mas_remove(struct vm_area_struct *vma, struc=
t ma_state *mas)
 	mas_store_prealloc(mas, NULL);
 }
=20
-/*
- * add a VMA into a process's mm_struct in the appropriate place in the li=
st
- * and tree and add to the address space's page tree also if not an anonym=
ous
- * page
- * - should be called with mm->mmap_lock held writelocked
- */
-static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma=
)
+static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *=
mm)
 {
-	struct address_space *mapping;
-	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
-
-	BUG_ON(!vma->vm_region);
-
 	mm->map_count++;
 	vma->vm_mm =3D mm;
=20
 	/* add the VMA to the mapping */
 	if (vma->vm_file) {
-		mapping =3D vma->vm_file->f_mapping;
+		struct address_space *mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
 		flush_dcache_mmap_lock(mapping);
@@ -584,21 +572,52 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
 		flush_dcache_mmap_unlock(mapping);
 		i_mmap_unlock_write(mapping);
 	}
+}
=20
-	prev =3D mas_prev(&mas, 0);
-	mas_reset(&mas);
+/*
+ * mas_add_vma_to_mm() - Maple state variant of add_mas_to_mm().
+ * @mas: The maple state with preallocations.
+ * @mm: The mm_struct
+ * @vma: The vma to add
+ *
+ */
+static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
+			      struct vm_area_struct *vma)
+{
+	struct vm_area_struct *prev;
+
+	BUG_ON(!vma->vm_region);
+
+	setup_vma_to_mm(vma, mm);
+
+	prev =3D mas_prev(mas, 0);
+	mas_reset(mas);
 	/* add the VMA to the tree */
-	vma_mas_store(vma, &mas);
+	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
 }
=20
 /*
- * delete a VMA from its owning mm_struct and address space
+ * add a VMA into a process's mm_struct in the appropriate place in the li=
st
+ * and tree and add to the address space's page tree also if not an anonym=
ous
+ * page
+ * - should be called with mm->mmap_lock held writelocked
  */
-static void delete_vma_from_mm(struct vm_area_struct *vma)
+static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+	mas_add_vma_to_mm(&mas, mm, vma);
+	return 0;
+}
=20
+static void cleanup_vma_from_mm(struct vm_area_struct *vma)
+{
 	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
@@ -611,10 +630,25 @@ static void delete_vma_from_mm(struct vm_area_struct =
*vma)
 		flush_dcache_mmap_unlock(mapping);
 		i_mmap_unlock_write(mapping);
 	}
+}
+/*
+ * delete a VMA from its owning mm_struct and address space
+ */
+static int delete_vma_from_mm(struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+	cleanup_vma_from_mm(vma);
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
 	__vma_unlink_list(vma->vm_mm, vma);
+	return 0;
 }
=20
 /*
@@ -1024,6 +1058,7 @@ unsigned long do_mmap(struct file *file,
 	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	*populate =3D 0;
=20
@@ -1042,6 +1077,7 @@ unsigned long do_mmap(struct file *file,
 	 * now know into VMA flags */
 	vm_flags =3D determine_vm_flags(file, prot, flags, capabilities);
=20
+
 	/* we're going to need to record the mapping */
 	region =3D kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
 	if (!region)
@@ -1051,6 +1087,9 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		goto error_maple_preallocate;
+
 	region->vm_usage =3D 1;
 	region->vm_flags =3D vm_flags;
 	region->vm_pgoff =3D pgoff;
@@ -1191,7 +1230,7 @@ unsigned long do_mmap(struct file *file,
 	current->mm->total_vm +=3D len >> PAGE_SHIFT;
=20
 share:
-	add_vma_to_mm(current->mm, vma);
+	mas_add_vma_to_mm(&mas, current->mm, vma);
=20
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1217,6 +1256,7 @@ unsigned long do_mmap(struct file *file,
=20
 sharing_violation:
 	up_write(&nommu_region_sem);
+	mas_destroy(&mas);
 	pr_warn("Attempt to share mismatched mappings\n");
 	ret =3D -EINVAL;
 	goto error;
@@ -1233,6 +1273,14 @@ unsigned long do_mmap(struct file *file,
 			len, current->pid);
 	show_free_areas(0, NULL);
 	return -ENOMEM;
+
+error_maple_preallocate:
+	kmem_cache_free(vm_region_jar, region);
+	vm_area_free(vma);
+	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
+	show_free_areas(0, NULL);
+	return -ENOMEM;
+
 }
=20
 unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
@@ -1298,6 +1346,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	struct vm_area_struct *new;
 	struct vm_region *region;
 	unsigned long npages;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	/* we're only permitted to split anonymous regions (these should have
 	 * only a single usage on the region) */
@@ -1333,7 +1382,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
=20
-	delete_vma_from_mm(vma);
 	down_write(&nommu_region_sem);
 	delete_nommu_region(vma->vm_region);
 	if (new_below) {
@@ -1346,8 +1394,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	add_nommu_region(vma->vm_region);
 	add_nommu_region(new->vm_region);
 	up_write(&nommu_region_sem);
-	add_vma_to_mm(mm, vma);
-	add_vma_to_mm(mm, new);
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+
+	setup_vma_to_mm(vma, mm);
+	setup_vma_to_mm(new, mm);
+	mas_set_range(&mas, vma->vm_start, vma->vm_end - 1);
+	mas_store(&mas, vma);
+	vma_mas_store(new, &mas);
 	return 0;
 }
=20
@@ -1363,12 +1420,14 @@ static int shrink_vma(struct mm_struct *mm,
=20
 	/* adjust the VMA's pointers, which may reposition it in the MM's tree
 	 * and list */
-	delete_vma_from_mm(vma);
+	if (delete_vma_from_mm(vma))
+		return -ENOMEM;
 	if (from > vma->vm_start)
 		vma->vm_end =3D from;
 	else
 		vma->vm_start =3D to;
-	add_vma_to_mm(mm, vma);
+	if (add_vma_to_mm(mm, vma))
+		return -ENOMEM;
=20
 	/* cut the backing region down to size */
 	region =3D vma->vm_region;
@@ -1396,9 +1455,10 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
-	int ret;
+	int ret =3D 0;
=20
 	len =3D PAGE_ALIGN(len);
 	if (len =3D=3D 0)
@@ -1407,7 +1467,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1426,7 +1486,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1448,9 +1508,10 @@ int do_munmap(struct mm_struct *mm, unsigned long st=
art, size_t len, struct list
 	}
=20
 erase_whole_vma:
-	delete_vma_from_mm(vma);
+	if (delete_vma_from_mm(vma))
+		ret =3D -ENOMEM;
 	delete_vma(mm, vma);
-	return 0;
+	return ret;
 }
=20
 int vm_munmap(unsigned long addr, size_t len)
@@ -1475,6 +1536,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1482,13 +1544,18 @@ void exit_mmap(struct mm_struct *mm)
=20
 	mm->total_vm =3D 0;
=20
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
-		delete_vma_from_mm(vma);
+	/*
+	 * Lock the mm to avoid assert complaining even though this is the only
+	 * user of the mm
+	 */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
+		cleanup_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
 	}
 	__mt_destroy(&mm->mm_mt);
+	mmap_write_unlock(mm);
 }
=20
 int vm_brk(unsigned long addr, unsigned long len)
--=20
2.35.1
