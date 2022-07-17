Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4411A577351
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiGQCtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiGQCss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:48:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C83C1CFED
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:31 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8l9h005050;
        Sun, 17 Jul 2022 02:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fgEdy4G9jiYroyxSJPdpKflQFwgNrK1nUsFALdcJByE=;
 b=2JGXE7OJ9tgEMGDKG7KpFcBGHrFQ1JbxY87baxPb1K2iei0u7j2K+yAtTI2d1IwEkV1v
 YE3Yv/RiUGv4BxR/JCLtNfQS7KJuhDgSIMu3mMMk3AYFawDpnOv4cE2DBOch4DoPqBWB
 oGfx0Gqvhp+j10FI0Svmf5nSai0lnzvliEtmktP1ZRWnWOLdCbWGVgNwS+bIdhuckPjL
 wtCMtKqgBXJjYa/e9ADFPwtr1t8xBMUta7ayZlDstA7AR8detV/gosTSBVJDn4fYOIxE
 RgGFuCgqUtPpCN8xBa0vaCB8v6KmpG6yx95NIT9urWPYaDuqjBjr0GR9E8z64admWTxY 3g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x24-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISE036113;
        Sun, 17 Jul 2022 02:47:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=grV9LEieERhE4AIZ4rs+VV4tfx2q8cEhXPQWXbZFuKm4CYxBjgdS8wyVbNAu+DWUNrYF9G8ZEaL4Z3c90VTXV9D3Je1pB4BwoXIukFdDwWPvZazJJ+N3uO7tY8yY3bNZ/SvOIZEWzhbb7Odw3h7gChlogaxupdFrAiG1Q7EU3p9uio9t7bw061me8UywKFsZjHYShzjuBlLLNr4bmsruJ1fbYKU1aF/RKqrTCDE5JXa7RSMbDpaRJoXAVvPEYofCqJfRy3R4clEsJkUbAgaFzzIkucmcSz/upRfCgMgcdXpnm5JCF+URZIXPAdMgPrS85fHFtBUZnM48wrcu9OcT1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgEdy4G9jiYroyxSJPdpKflQFwgNrK1nUsFALdcJByE=;
 b=WgUveMvL9i+fISU7ryy4iTgiWFsHe3y4kUSeluzmvZlihE/U7QvelJqbs18PoQ/zoFbvlM8c+vC6HaTCG7K2tQayhOfq80U7z0Z+8WdU2Zf2kTC7qK+zKqfaJ38PJu6D2NNy+vSWWh7bsefF2ZwlOpPC4cPO3dlcTjl3aaOi7g4kcqQ/pWELqOI/Yr2GDzqKbC44hSnlUaq6yRPeVQId/otJQ338NaNF5UzIMbF3NzEw19VhmD6NmRGOElE5wwApTzOWoO668gWgKK6/70hZrCcN7uwZXoi42qM9aPoN7P/xTBYsM+oiTgwOM39T0TaSuOKNAqg/SDSH78OfpdS1Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgEdy4G9jiYroyxSJPdpKflQFwgNrK1nUsFALdcJByE=;
 b=bl4urb57wJThwCb1f6XyCPuDThjOeUiTxlAPoUt4XDZ37SqoxBus0HFWHG1Ra3LIlMXhHnmTvMoegivmqcUXgYtrYrmUtGW/tJgio1kZpXduBxXLk1fFAblXKmYnqvPjCtq/6DWqawAq2cb0J6co+zwvQTcBJJ3iiQQ37rFsiGw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 32/69] parisc: remove mmap linked list from cache handling
Thread-Topic: [PATCH v11 32/69] parisc: remove mmap linked list from cache
 handling
Thread-Index: AQHYmYd1MoMeU0G9ok2TA8e3xFqSWA==
Date:   Sun, 17 Jul 2022 02:46:48 +0000
Message-ID: <20220717024615.2106835-33-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d8e6d96c-cd4b-4e95-dbf1-08da679ead31
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fu2Hoq4SKN7OoklXQFFUtYp0heFWWqgwAmK5zeLLZNnoXhEYZONsyDLjF6LC/tiGM+q8hxoKKBECR7hHEGKDJD0/Dq4cH7yDiWM//F0KI6dO6LnUJ0CUjtnOZcqC0KvJgB3uRPzCVDD5ODF15ArYI3a+QJg5UM/OaBhTSRPy5fNCB8jigVmTAERZU6d4wlHrTR+UgS3Vb6/0mMbOjOGYdvqcNo79fbCQur4oVUhwDNT9RPk43koARQGEQsO5uwXtwILnWIbBnd7PyuJ491TQwLXraxnVUBwH0RTZ5xvyjNmcoWJvc7dzNR/L6exkSdb0KvThfDvyCZLcL2AqtN//1cMdrh+/gKjgeq6qLloujdjmZ2oJf5MXltVVmQJluxtNbuW7UJuIZDcc/RN/B4sAWTIfpN21JJXE9AW+ueQ7RALosE8qSXIOodwtdG6JZztWeNrtD1EFFZhg5VMxDIdK1MAehKUXTKrg/tB/Oj14RB/OEFHFAUJTsSvwkpPQuq7AVmM8d+JlBawmK4OchDvsmsQ8dNEYUlX0wRJQxdzNBMlPxi7+Ahrz2fljwBfPzfYON5Wltt5OvQgvznHJZ9gmsZIqZWMCg8m2TOIL00D6JU2L0dxU2JqsJqT5DS9yuSGpmT25obnQJGkYbVrzkkAhV+ojK16yOko3lGl6gfUIgx9iHLUJIcpBF1H3z2PvFz5foDQC1JwTMg7gi5yvI0q2tsVcLjg2hfY2YgarX7ezTRqLdkLLDKMCTbGFBFiL1EO9md5nqx5s9r0bJxcgQoNadqrR5ZTdbtpzpjdkPDEEWThhV04pgAIaxmkhmlotTGU9qpTlhdpF2UgA5dQCbQFAX0lvHrEFPy2WGWN8nIgJ8W9umKkTXpyzh+kBGRpH29WL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2tiWvDNAFFCDdOZsr9EH88GWKmjxaDgaEhalVdQtq1DIChFkD107fDn5fu?=
 =?iso-8859-1?Q?ZFbIkqkXyuA+IsUdIE4tdjjgTgDAQyiqqFKAldtW8eXH6h2huUdy1WAfWZ?=
 =?iso-8859-1?Q?AO2ZoZeutfBp0XS/Pco+z0EOLFRyJb/9c4J53CgaD63ihB2Ab8s1c757JU?=
 =?iso-8859-1?Q?82FBdtTigfQuaFnjaXrWzg/hipwi331IK/1ES7OAyZAJVGyFs+QwyggwUx?=
 =?iso-8859-1?Q?Sc6Vq9iZcguVRFG9fncHAQZqW3EbL6LBjsSDAdU+PYl52+n7KETCd1Lcc3?=
 =?iso-8859-1?Q?BdBxCqEDddNpZifA/E6ZgGPUAWfQXiDlOnFcIK3G7+kGuUjeStu4yX7NZ1?=
 =?iso-8859-1?Q?l0YE5s96XppFpM9RP3/4z1SN/B6rSyxI/OEd3g0ISYmd6jR3gsfQWVSS+R?=
 =?iso-8859-1?Q?YelXX/beH5dwFtDZCB0DG5ZwBgMjq6cMgcFeljQc1St+RrYd8yH+ma61Wm?=
 =?iso-8859-1?Q?JKTz2oT1LPb3u9nVZ+ViFP81YHQqniuCXuabhQB1sNCPsp7A02lAAbpoWT?=
 =?iso-8859-1?Q?hOX0apeiQgzKTUVMEyvF/XugX2Ti1jI3UTxC/bDx2PoSGlrwgE3YlBEewo?=
 =?iso-8859-1?Q?uJiyk545byTq11DJCNxGsrK2op9vM4fYmo4aBlxWaygPX4S3kBoigkItk3?=
 =?iso-8859-1?Q?SKHyIfcQy8/OAZe/QnbQej3Qfxe1h4zu5+6rJqSNb1CVi+JBkRi+1OLBx6?=
 =?iso-8859-1?Q?vAiP8LuWV/AIF8w0VA82DIf9bqNmEu41mX6WjOzKv1Jvyd9tZJAqCpNdci?=
 =?iso-8859-1?Q?NmhvYZnOBBvwA4RoNrC85hVaeWSmIchRuUb9lMV9q+WIjpwgaxvj/6CzR7?=
 =?iso-8859-1?Q?mkSl4EZpNRMkCIHyB/e36U3zLvP7ZUbjO8K9ka3mWt3D+sga0n06DAIyrG?=
 =?iso-8859-1?Q?z9dYpuT+kExmend24CqIcAkJBCPbjOkDkhpiN4iaRvP0m5dUJ4NVJtX+J6?=
 =?iso-8859-1?Q?Yi+YcUM0uvjlFv+ZjaAoPQWWsen3yQNNo345cnT1LhfTOdisEMERpqfAwe?=
 =?iso-8859-1?Q?5iIxLwezsEas01bVFTKraoidCPdi/jkoo7uSr5vW0wv6DATZQnMIW8NUD5?=
 =?iso-8859-1?Q?3l3CwB0r9K26Hv27HlQczY1LjoR59pujcV5HWd05bQFE/nleSYQLva7Fzf?=
 =?iso-8859-1?Q?f5p18I0S9LcisQfwDa9VLBRxiYoSOzXQGC+R5c9WtGuFOZqQ4+DKHOWUQx?=
 =?iso-8859-1?Q?t7bCOYHGXIoqeeaL09u3DRl7cRIYVSpqLBJ1mCSKSmxx8y7EFCF+wJfeT2?=
 =?iso-8859-1?Q?mnBExxMjU8qSySkRni35geonz5SRi24LWK7TlwcaeNMQUud2mfDGppk/N6?=
 =?iso-8859-1?Q?T0j0JhqlrDZjugtq98SGfjTrOjx3NFRS8gIFp0OKEqsx85slT0EyBW/+UZ?=
 =?iso-8859-1?Q?diWVrPoRRSjnoOW76EHFCZVYNI1E7F7wimGi5tDzJV0hJuZfuHp2njcNNG?=
 =?iso-8859-1?Q?5XVS91AdYTKw7wvs3Pza7hFR3wIRtr7s+4UYD2aI7HIIaoWbzLeoEkFrgm?=
 =?iso-8859-1?Q?w63fRnDzpib3UHZ0DUFss/tVxx02846x2bbXRy4vmh3d5u8UdkIvbCiDhE?=
 =?iso-8859-1?Q?sQbxqkwMI+yKqQoXbUbgtRQhdrooLyltisBO8KH1O+R8vibdNb6h96s3Ns?=
 =?iso-8859-1?Q?6h68OcPOT5Zu/AxLkc1se6ZCxMAKoHbbnQTsYzgXsZHvHMf6g4sZcoAQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e6d96c-cd4b-4e95-dbf1-08da679ead31
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:48.1464
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6s88/YuGHmaZinYAafO3bX3O8o0Lu8VFpujckcukWwKXXOr/gmOd9OTfo7RRyCgVqAr3JbGMIjAVCcvMYhFaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: rzmGVMQfY2cIvPuaXF4bHhmByM76iTCc
X-Proofpoint-ORIG-GUID: rzmGVMQfY2cIvPuaXF4bHhmByM76iTCc
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

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-17-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-33-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/parisc/kernel/cache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index c8a11fcecf4c..3c8679e3ef10 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -660,15 +660,20 @@ static inline unsigned long mm_total_size(struct mm_s=
truct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma && usize < parisc_cache_flush_threshold; vma =
=3D vma->vm_next)
+	for_each_vma(vmi, vma) {
+		if (usize >=3D parisc_cache_flush_threshold)
+			break;
 		usize +=3D vma->vm_end - vma->vm_start;
+	}
 	return usize;
 }
=20
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Flushing the whole cache on each cpu takes forever on
@@ -688,7 +693,7 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
=20
 	/* Flush mm */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, vma->vm_start, vma->vm_end);
 }
=20
--=20
2.35.1
