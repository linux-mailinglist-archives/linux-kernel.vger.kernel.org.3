Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08B859C23F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbiHVPG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbiHVPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:05:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EEDB2EE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkP1H022949;
        Mon, 22 Aug 2022 15:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=9D8v7pjZHY1AiW7bTKpkvIWPlwwP74MTcN/6/skSowg=;
 b=zysAT6cmRROEPID4nkrVPHH4ma7nPTiL2x602nhPbjo9+T0LziB26wdQjU/qR9M/9wWj
 dyIiOKCkVK9DaGoN16wEhax9oswZQCMLVnYk2ZltPTSbQ/G2UZb0vrbUoqOuomVArrgd
 /Dk+ORnMfaOaaRcqzPLP4fOjW4uAjiixAoEKwaVPWRu7ZlbUyUHjE8FKLrHqykvpG/Gu
 vpJMYlZLwb2C7zHQBxAhKwfkOE6Th/TGYkw4Ohv7HkkWBRmXKTIcJz5UJFh+wKLJKQpp
 hYYEaNd2q4XuUd/RwFCUyZpJWhWSIamEcd5FEggVVjudWso16wo2tTzeNUfmrdj0ISOE Zw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbgh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:09 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4kIe025311;
        Mon, 22 Aug 2022 15:05:08 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn1uags-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j2cbBAngl9+umQQVXJ8rvv8YO0ycMkkmexHf2nzaFIzcLsDApP3I3i62lomun0g17is/PPg/N7CDEiesRfe/WCcheb9l/Ns5dMdX0dq1sfTADY1L2TjsHfOMRpG5yB+caRJ8/koUKy6TSyNwromdOuweLjU1RBcwlEByAnYuDscLTAc1xitxNzN9emR70OE7NPJTlI3D5PomReQTOtvOzJUdmdSiQKUiz7rEfjvtYGzILTVVLEs388alFENrn8x3Lwb6HQYwk4NKd7WLOsWxJ7qLCPB61hezKyp5cQVIsCYFGJeN7kmssqEtEisd6dnUQ6hCB2eZfSFzVPpuNy5Hfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9D8v7pjZHY1AiW7bTKpkvIWPlwwP74MTcN/6/skSowg=;
 b=oSh1pwDK/ecDBWLdF2HGfX90GHx0RzXt2LTS2FE4xB45fUw2BebkVMPpKGpB2A4k0LnQaywaNvGYgpY/j7Aoh0IShzkJ/BvEUVdwnz3Y/VKJRlVXmErd9DAtypvojaA0quVLtlKRrpvCJJgvHBbJZZxejc7TCSDILf7IjagJU6PX9563eQDTWAu6GRWBKhTwTpMS2wSilPDbPBOdWEYaJQ54Hx8nE+0vSg3Z5ofxiBpfafIepUl7lMzbnKpRUd1OcFZQYxJGIBV3w6Ug7Ul5Dcxq2pD5heMRvKoz890lwKGQsZutCFngr/GoYpq1D5z+GVOU2OiyQkxPUHHJliAfZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9D8v7pjZHY1AiW7bTKpkvIWPlwwP74MTcN/6/skSowg=;
 b=KxdrQPKfj3FyDWd5KOIN+Iai7FPNik4zDEFoXdBGG4wJnexnF7BiZicXxOsBZcPRDr935nLfzjRyE3Hc1mEZDWCuxcFezF7xCT3Q+4uacdIhYDyHb7LqEsUyDrEGInXJN26W4ooWRos4yR+kr6OypxfJyxwUvU6kRj9N3Bfqeac=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:05:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 23/70] mm: use maple tree operations for
 find_vma_intersection()
Thread-Topic: [PATCH v13 23/70] mm: use maple tree operations for
 find_vma_intersection()
Thread-Index: AQHYtjiQIJtHizHtn0GldQjMrH9Oew==
Date:   Mon, 22 Aug 2022 15:05:06 +0000
Message-ID: <20220822150128.1562046-24-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e88836bf-86ca-451e-2fc0-08da844fb32e
x-ms-traffictypediagnostic: DM4PR10MB6063:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W2iQl7gVmyJK2CpkyqvIbvrG+uF8oluH8yg34xFFy9qCEFXvPBXR9FZwdjl0MyPVC2PgBwhiEUbSR67J7RISzcoR8xdUR1RzN3bURWtB0Z6rRj7FerRuuoauyP2WsQjKApAqxK8CMKGu4KcSP8H5EjCOQRtNpFPzHEjh8FfvLXT3yQIkS9bnLztSGY6zic7oQTdcK2Opa75HEwGNpxE+mYH5lDSAb+RV4SAq5l0tkgcR86XzVa6/rsyR0HjcD6N+tGxvsjjy242tRPsO+uD/EkcJzlXpBjFJto1cuCTBz9faoIWZ5COqpUVdHs4RaS3810Nbr7gVX0yuGx492OTcDNiFO3jXpGEsWP5hI8CV0OyA4ndnHqq4bg3xqHoKlArCiNahawiVJn78bESRvESbA3hoxQb7Rg4gU0IYWHf8TBlkHvoghQqxzb1ZFLelhsOex8N7v7S438hGBZBDrAIQI6bpvhd6wmyaTggGV3l/xS/55Jhye6TcnCEcNx5IHYX6sCrjKKxp61rQp+zAfQnYAPyo0JcyOi4CpNGfavFNG7Jv1mtvjsZA/tqMD6tHeB2KypqP71I8HMdYTglIjpU4L42hnrpjV+6iEfb1VQ/ZyEeD/nNDKwte2GbTtwed6TVguQV99pcolqd7vrZPb5RgkKLOgxMEBy3ZebvonygZ/6R1wEE/rtHpkZDITqIpq1sWgrOiz05v2TidhGUZvLFlEeo5L5l6qaPgNBKz7mRh07C3hQgPRastuqktEuT165G1dSfNpObgerN/Xk07Z6kDxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(136003)(346002)(86362001)(38070700005)(38100700002)(122000001)(41300700001)(107886003)(5660300002)(44832011)(8936002)(110136005)(316002)(6486002)(66946007)(66556008)(8676002)(71200400001)(64756008)(66446008)(66476007)(91956017)(76116006)(36756003)(1076003)(2616005)(186003)(2906002)(83380400001)(6506007)(4326008)(478600001)(26005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1EHy+LngvIv9gaomSHFGHqsqHLzJDEVDsXG4LPTkabhjbCEH42KX8CZ4Q4?=
 =?iso-8859-1?Q?NnLk+j9MsV5dbSJ+bwcYBRWeL8fxsB8+dPUMTytAuFbgSK/OtecMmm9Z6m?=
 =?iso-8859-1?Q?5uwOC6JD055Y7nmZzxY+7IOnRfu+n9YjQaJ2wdtB+UKfB40be/Uzg5kcSu?=
 =?iso-8859-1?Q?Nq2RvhCm1MjWgGk6SVvFCZ3l9UL8LmPv6/TgTk5nITzKkk51afgpMz/2uv?=
 =?iso-8859-1?Q?PZltwqudRp8+G5fFTTgBPSeqhiyhY6A4YCe6jvgvxG9TEA2k/sH1vUCY8b?=
 =?iso-8859-1?Q?6zMRYMYzU0/VhK/XMymkO136oXjSsAmeqjrwYYg1yYjZQ2k74+xvkwr/Y2?=
 =?iso-8859-1?Q?2FYKZw4GQ4xNZGorW+fodjhHAL2mPp5C3XCaWz+Qv4Gtg9XiYzw+dmFBTc?=
 =?iso-8859-1?Q?S5lwOs9cMpcX9hcABvY2mlVrKXRfKrTNEWG9RxULlTuf0DeZZGOVfFTUKL?=
 =?iso-8859-1?Q?ju7f+YxtKoS6HaZMUFyi67uUvCt2x3i069x/suhYWbKQJDN1V3Z7TjUpx+?=
 =?iso-8859-1?Q?G06z08G6Mhaat89JgbJjdMCPccM9mZe6b/U3/6emb9+xW54zmomblHcyqm?=
 =?iso-8859-1?Q?9NQ1SuSCBzWwZFbmoS+8LW53mErZQ72k1zqj9zBec4+CJcdydYbjJqVZmg?=
 =?iso-8859-1?Q?v+UYIA0sEnXmIaseTNV1wPjvdBX370i0umn69Q6zJsMbfkdbuZO4E3iiz5?=
 =?iso-8859-1?Q?oNOWD0jcnfKwFsbxwiJfVanPJwtjSZ0ZRGaJCJKWViV/XDOgR0XLIARujc?=
 =?iso-8859-1?Q?OtGzXoVLGwdNLIry/JEKDwaDR6kiq4MBfKN4TF0+Y76nledzgU1FF+NOam?=
 =?iso-8859-1?Q?Hk81f3NvEQLP+eM6lH5NU2WSQecmuS2rPMZM810AI1FuS8trfYLXYTDNpK?=
 =?iso-8859-1?Q?yz7VLskdmT08VbIK9JHbyEVXKhk7WVBj1ssuKuH3iWRP1nCjzOdjx73weG?=
 =?iso-8859-1?Q?nVFN95RxQx3NqT1xuGtUl/MlbILHiybvnt0AXXbabF8kzF7GcU32eXSQ2R?=
 =?iso-8859-1?Q?ccXM7ErL0FKPVECPfscb6i2id/DjMxfbVPINmbwm1DffbeB+SENWRhSZL0?=
 =?iso-8859-1?Q?zyWC8yWrQpgyAyX8tXFS+vzp8ZBIxfyTVsU+QDU8+nadgHo6Yzvbnc4AYX?=
 =?iso-8859-1?Q?ueGaWnZkIWJhq6vctKADSKfExcADn0ZCNr3bpeAyeXpqYPvUrL07MgipCt?=
 =?iso-8859-1?Q?DpPJlJ8LfckV+qaU6cw6pc2wMzD33AQOlpFevTO/JgomyCAjnYq8B1OKnI?=
 =?iso-8859-1?Q?nDLeCKb3P54OfiwgpDsFfCuuOD1hoyphyaG8qqYyycODBw0lzrAmCZlRZm?=
 =?iso-8859-1?Q?+4mMoDXHYLVIXStD8UtMpEJuSFOH0geKiA4A7cCWbdz+P1CXMyMOqm+hbM?=
 =?iso-8859-1?Q?sVlWpbr62n6rpIuqRXTYFhmyIOcLOKXwmNwPLg/xc6jxOi0X72Vqw2aQUB?=
 =?iso-8859-1?Q?0CtWXTEnQfbUszaEfTz2IPnKwbWUvgvKbfXJyee5C1O1ImbwDHjvIJBt+0?=
 =?iso-8859-1?Q?uZNPc+I0evCGR55CwRm/1aL+5SPO2ChDc8+LUKK+gXuD1P/7UNo2FRnZSb?=
 =?iso-8859-1?Q?o+kD2vXZee4YhCaZTvAHhEQ4Cy9m1ZYRN5Mxoilv9cKQvA64QwSF5kMu6M?=
 =?iso-8859-1?Q?z6MwYmC5fHQfCFQjxktnDzid3kMCtMYyAC1Ivh1/xieCHaMv8GoETxug?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e88836bf-86ca-451e-2fc0-08da844fb32e
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:06.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1O2kN68paFp2LaMx8cqCbwaVTOAcpdJnS8q9yRcgDuZ6NPaPY/pa2L+guZ7JILC2XAf8mEOkfhoih+TPP9kRbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: mdOpSF4dC44TPX8YnlxYxOJVtwtv9nsR
X-Proofpoint-GUID: mdOpSF4dC44TPX8YnlxYxOJVtwtv9nsR
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

Move find_vma_intersection() to mmap.c and change implementation to maple
tree.

When searching for a vma within a range, it is easier to use the maple
tree interface.

Exported find_vma_intersection() for kvm module.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 22 ++++------------------
 mm/mmap.c          | 29 +++++++++++++++++++++++++++++
 mm/nommu.c         | 11 +++++++++++
 3 files changed, 44 insertions(+), 18 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d53d236f7869..88e89f38825e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2770,26 +2770,12 @@ extern struct vm_area_struct * find_vma(struct mm_s=
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
index 3479c9e88eb9..57391f99afe9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2061,6 +2061,35 @@ get_unmapped_area(struct file *file, unsigned long a=
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
index 321c7e6718a8..2702790d05d3 100644
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
