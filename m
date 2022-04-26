Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAF10510188
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352404AbiDZPOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351973AbiDZPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:09:57 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FC155707
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:06:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT2Oe015535;
        Tue, 26 Apr 2022 15:06:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=cw0jWqKFpto/WJzdD3ZdKFI8VtHuiIR+6P/1Ymk7Nxg=;
 b=ts5EODCHAVxzWgkZV9zWypJ7HCdPBZBkWyYvNYnORu6b6jyq+8hVckeEhOMnD5+kUIJX
 xoGUhjY2PIpURHF0vRY4MeVuh1mVVUmhd9DHuFdZ9udWArXLkGRT1JnWqFapJGz5Lrvc
 p2CixWbDIRBGjW5XY5R/IZIxmtM4APTkH0Bj5FsfoDOUEphwAq8MCPW3/s6a4Ln83iMk
 fTdHF1g9m3VD744ctlpAcL9vwqi27HInPEs0tqF94hMpThOxHjOVO1ZWCKW/1btzBnS4
 hfOjOoJhjxW6HTJsZzxZFB39CGaFBHZ3bzxy102ir+2yv8C+7EDiEjWo87nZRLQzJTAq gQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:34 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF55Np019220;
        Tue, 26 Apr 2022 15:06:33 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3fdte-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8lWH3vMXvR9y3nwJLWjnSDaOrlJTUmdZgymyoe469i8rJCNdmSFHdlX3AkrGkZzRDWS7kPOxdFP+3xpl4UlKBYDmMj/IFr1NorVCWyfHT1lxZTBHtClq5iH4bRKCFAxyKwY4lMLsdxPu1Xbm40qusPAKQDS+MHgFKS8uaHkoAgKvs870acCcwmJqycl/ra0n2rjzpb6K8Anh/uiVVD48P1DnoF/NYT3qz/RYwEONBETMBC/pHiLnusmzUMM/ez7DTR5ubX7EPgd6/zVhI+DeoGg9UMWleEfNFAvevtKw77G0Hi+yE2N1/tXKwF8Gj29A64r4FbuBGR5+8Sf6XL4+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cw0jWqKFpto/WJzdD3ZdKFI8VtHuiIR+6P/1Ymk7Nxg=;
 b=P3cBcmZpZEMg/MnTxmR9I3eQ9O6UVPeVQBiKkH6ptShWb7YU3vsXORABjvBb1Rofh/x66i70jjQllczrYSsyZtSuGNpji29oMlHMt82ehzKBoqJ6+lEGCUZ3+7wl80VyS9mHc9zvQfWFvPPplW9SoQHvl9/G8MAxp4gPJDHlu5x47JRHZlyZk4u/VWrkABQj0DSB5yKzavnC4NMz6M9ftnVIeGnsdHmHmADXB/LG00n+kpygw05OuVmrrcgy/wDKtfPLDp1jt6eByVt+VuPdYdHdAybNP9IZ3rZctu1ekqfHHNDJ6jxID0ReLNNuNqIZfyiLZQJD14GM7PavmUcdFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cw0jWqKFpto/WJzdD3ZdKFI8VtHuiIR+6P/1Ymk7Nxg=;
 b=TzxrlP3JWCDB+6cc7131fWO5S0GbN7VK0n172704IlawRKGMq0DNUNhaAkwZA3XmwV6Hcda5O/pOaJp4IU90dIs+KoNw8NOFIjgrW6rjY1Xk+jo93Z8gpXD87fAZlx8O6xHAsD+m6i1CDXJBgSH8FGPtA9SVtKeJsUq4SKYQFvU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO1PR10MB4659.namprd10.prod.outlook.com (2603:10b6:303:6c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:06:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:06:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 09/70] mm: start tracking VMAs with maple tree
Thread-Topic: [PATCH v8 09/70] mm: start tracking VMAs with maple tree
Thread-Index: AQHYWX81Ij72y3+yo0GVRPQFyVno7g==
Date:   Tue, 26 Apr 2022 15:06:29 +0000
Message-ID: <20220426150616.3937571-10-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 582b3c46-9531-4144-7b2a-08da2796583b
x-ms-traffictypediagnostic: CO1PR10MB4659:EE_
x-microsoft-antispam-prvs: <CO1PR10MB46597E920C24C9B00151BD15FDFB9@CO1PR10MB4659.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AnEkM4eT2n9n663q/FMyxy1TH/id3khxZhukQkTzDgSgEPjv6WADVvWpKCEw8UPwRgG0vdNzl17ZE7kDA7GhVaedaIc5duw7LJqerGC8C+R48QwT53Y2pe7VDMcsIc2GqFGO5vQXeoNVNPNQE7p2pF5fDe0j9C7pShi0ABqCgXk+X54tWjfOzgl+NEhVksJ18V0T8wwJqyHBlR+TLV1wLb3m/yNHV/IohCUsN1JTiSdiyqGJLOr/TfP6dJiIhwMB4AcdCEYNEeLG9QcxKBKbqVE+Jix+F1+KFbx3PvzSoK7vVkVxgL04fPONZYGOo4e3a/MOFLNVjWb7cVNuevAQSp+GRsts/xuQ0pxfRhDDOz05P2X8zdGh4YUBAdmJUlC24SQ6U/R1MA/s4WnU5s7MSBG6HxbSvl9qHWcZm5UKtPhzUXCGpZwP21nsVxCDBOGC6dsaOCXJdamKs+xXHV8vkVeF5e354b/qsL1m4yOiquZchICot7NqRC7PSY/aW/ycfgS2BvRyDLBriQPuId6BasPk97NLNuSlCr76HSPViP7KGA5KlSwnGkzF/yYFwNxma6mBm9TDWkTGiGxuqW5MaLqz4Z3CffijTlxfhVqVc6fLC+CExyJbGaZmMbbra7H9vVxisO3t35Gw+TLWovEpvaqE+CTKZuUrdZLV7Wv9nTzI0Ta7Wgvw4kYXBLdN2JS9wv/zzzJX8JDDjHxFtMTD+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(66946007)(66446008)(2906002)(76116006)(508600001)(122000001)(316002)(30864003)(8676002)(71200400001)(5660300002)(110136005)(44832011)(8936002)(64756008)(86362001)(66476007)(66556008)(38070700005)(38100700002)(6486002)(1076003)(186003)(6512007)(36756003)(26005)(83380400001)(2616005)(6506007)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1DT+Ghw3i3pwrUyib8y5PrVI5DT/C6qYRlB3tw0XkQjWSX7f0vhjqEwrlg?=
 =?iso-8859-1?Q?NtoBOEh4SCHstCUgux7LN+GtbwD51IhGnrOa8Tt0bpq78vw8oS9R3KXFLT?=
 =?iso-8859-1?Q?w8vqEVZ9FFSbm+jtK1q5lzU7+/oZbhRvMEpJKlG0NdHMMjCiN5fiFkhfbw?=
 =?iso-8859-1?Q?Mu5iIsVmUVm5TFyaJIUZq7Z4EQj1YTHZ9L4lqK4vbpO0Iq3tVeR9yUBBBL?=
 =?iso-8859-1?Q?qBTZnJExWhwN8dKyGMe0EmaiJP0ihNkMesXaIi1zzmvpuBSSwIO5qrkRSJ?=
 =?iso-8859-1?Q?K90XopTyQ+8Af5YEnopXfefAmdTW/wLqsVsG4cIMctpvGxrcdTPkPq2YQZ?=
 =?iso-8859-1?Q?8bKbzfC36dTgIbILLDGUyHN1JZ3QbuxHtAi7xuHUDXCqxT3eopyZf9nDzR?=
 =?iso-8859-1?Q?IR2L7IDlgxH24jqbXz+S8nKgyHiFAmLcPT8X6MM3ZsVOMxebx73jH6Evd1?=
 =?iso-8859-1?Q?bA33O1zDyc+7a7cgDZaOVaS6powxUio1effzWhXcGKgnzAAXhCRWwF6JrD?=
 =?iso-8859-1?Q?TwqGmUyEaVaQhBj3y1zm3n4LgQjQEotl//CUgZkeEQqA6wfJN2hPO8PUbC?=
 =?iso-8859-1?Q?FR4PYkJSTpbfM4a1cff0MaMp1LXaNXxRzWKjSFXTbsfqC0YxovpqOSWWKt?=
 =?iso-8859-1?Q?DICzvHzy+R+4qkcufrTu4vbJjjCaB+erXpg2mobYGVCLJnV1ERAWUYMEXr?=
 =?iso-8859-1?Q?FNRhKm5cIdu3XakYpqDImI9157wyooFf+NS8D1Dlutw3mtUhu0RKXofBRp?=
 =?iso-8859-1?Q?9k2n95kzXPjxTM4OUizumwSvyOvrVe8PmIaKwpYAqef/qsCLbCJ9GpcwB5?=
 =?iso-8859-1?Q?Y0lN9xcYISx1PC2RkT4CLwJFhCEpfq1dXtPDTaCNIFFdR20knee8IkX60F?=
 =?iso-8859-1?Q?3nD2wC+yVrh/lLySskxKzT5gnifIxz5T8jhuxf42UxPO30PGnzNpr9p4Pr?=
 =?iso-8859-1?Q?cvkfl7heLv2wFs8c3jWmZ4IETiGIfu29qCWOzcnrLJXwsDIulY7J8qUPiZ?=
 =?iso-8859-1?Q?gCVCHAkPQxpAIEv+E3+jZtf4bt8lpxf/GdyvWJlkGCi728sA+XqDyf5OyM?=
 =?iso-8859-1?Q?F0Rv+6NvbOpoiJMYqfHVKZb1rkI9SuBmygWo29FHLaV5DuVk8i05OvfilN?=
 =?iso-8859-1?Q?bVOWhFTctd9zPG9947LcUi84dlKCrEnqIQgpNzkB1WEymBZo0QDVdYl22T?=
 =?iso-8859-1?Q?YqLYbxNnTc5b/UwY3fqlK09CQKnN3fq83oR3XNDdmaBdSRyABtqKpNnWuX?=
 =?iso-8859-1?Q?+JvxKdpuTAlb0fOYO8sMRl56RK8F3Xj8KVKxKPXJG5nIbbw4ie8WIGkkUe?=
 =?iso-8859-1?Q?TZLf3+wE1aSXgLHs5kT+EautNxkGCi4LG5dFWAAAoQ4UUys8FRCIV7uv3a?=
 =?iso-8859-1?Q?Lq+AzaILpk+nFi/d7D1dfHm7m0ZFqUlfmbUWYUb9HmEQMfQy321PEkIujq?=
 =?iso-8859-1?Q?8A4XsqplqJjJZQ/8Y3PFS6XTUmRabm9q1O/9SC9gTXDIa5UGZM3dX/6mid?=
 =?iso-8859-1?Q?vfpSbWhDG65dfHYC2egE2EWY2otKPorpGKZlDFXUQcspm1Fr1kFZVj+ONS?=
 =?iso-8859-1?Q?jNOmvIcpQjAge+grId6jm/DBodTAxCIO8B6qBEWaKSVYKJdvQxQ+kRxhx5?=
 =?iso-8859-1?Q?0D3/MQmW1XNaHNVkHCubacRsWz4nTmBkxW0y8cwZtr1nLTmLBDiLlpLQum?=
 =?iso-8859-1?Q?WVSZ8OLraazjCM0HQemv/2teLoTTBtBoPWmXsPlVnsxb81yyTdxX02cyOz?=
 =?iso-8859-1?Q?M+L0bBfiAWX0XQtaLQqG+kbZvDtf9Oig6x+q+xVP6vJWm1KVxBr3ZOex9n?=
 =?iso-8859-1?Q?l+Ww6V4JcRP1aYzLwVEiG57RImpiYUA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 582b3c46-9531-4144-7b2a-08da2796583b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:29.4749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bfow75yvMtbczrTR7UtJW59aqW0QdsMHLk/WxryPyCezuiA3tTQK/Fjw7P4WcEytmjjPUIo+RgF0hYyPJBKYtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4659
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: RpM5qzckqr_9M4thGuByHMcyjDLOibgL
X-Proofpoint-GUID: RpM5qzckqr_9M4thGuByHMcyjDLOibgL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Start tracking the VMAs with the new maple tree structure in parallel with
the rb_tree.  Add debug and trace events for maple tree operations and
duplicate the rb_tree that is created on forks into the maple tree.

The maple tree is added to the mm_struct including the mm_init struct,
added support in required mm/mmap functions, added tracking in kernel/fork
for process forking, and used to find the unmapped_area and checked
against what the rbtree finds.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   2 +
 include/linux/mm_types.h    |   3 +
 include/trace/events/mmap.h |  71 ++++++++++
 kernel/fork.c               |   5 +
 mm/init-mm.c                |   2 +
 mm/internal.h               |  34 +++++
 mm/mmap.c                   | 256 ++++++++++++++++++++++++++++++++++--
 9 files changed, 361 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c
index f9af561c3cd4..859e8d2ea070 100644
--- a/arch/x86/kernel/tboot.c
+++ b/arch/x86/kernel/tboot.c
@@ -98,6 +98,7 @@ void __init tboot_probe(void)
 static pgd_t *tboot_pg_dir;
 static struct mm_struct tboot_mm =3D {
 	.mm_rb          =3D RB_ROOT,
+	.mm_mt          =3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, tboot_mm.mmap_lock=
),
 	.pgd            =3D swapper_pg_dir,
 	.mm_users       =3D ATOMIC_INIT(2),
 	.mm_count       =3D ATOMIC_INIT(1),
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 5502e176d51b..92a765d8d3b6 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -55,6 +55,7 @@ static unsigned long __initdata rt_prop =3D EFI_INVALID_T=
ABLE_ADDR;
=20
 struct mm_struct efi_mm =3D {
 	.mm_rb			=3D RB_ROOT,
+	.mm_mt			=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, efi_mm.mmap_lock),
 	.mm_users		=3D ATOMIC_INIT(2),
 	.mm_count		=3D ATOMIC_INIT(1),
 	.write_protect_seq      =3D SEQCNT_ZERO(efi_mm.write_protect_seq),
diff --git a/include/linux/mm.h b/include/linux/mm.h
index a9f1491048cd..4024ccc94c71 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2579,6 +2579,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* mmap.c */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index eabb90ae6a26..0953add99518 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/completion.h>
 #include <linux/cpumask.h>
@@ -470,6 +471,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
@@ -658,6 +660,7 @@ struct mm_struct {
 	unsigned long cpu_bitmap[];
 };
=20
+#define MM_MT_FLAGS	(MT_FLAGS_ALLOC_RANGE | MT_FLAGS_LOCK_EXTERN)
 extern struct mm_struct init_mm;
=20
 /* Pointer magic because the dynamic array size confuses some compilers. *=
/
diff --git a/include/trace/events/mmap.h b/include/trace/events/mmap.h
index 4661f7ba07c0..f5c1626f3bbb 100644
--- a/include/trace/events/mmap.h
+++ b/include/trace/events/mmap.h
@@ -42,6 +42,77 @@ TRACE_EVENT(vm_unmapped_area,
 		__entry->low_limit, __entry->high_limit, __entry->align_mask,
 		__entry->align_offset)
 );
+
+TRACE_EVENT(vma_mt_szero,
+	TP_PROTO(struct mm_struct *mm, unsigned long start,
+		 unsigned long end),
+
+	TP_ARGS(mm, start, end),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(unsigned long, start)
+			__field(unsigned long, end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->start		=3D start;
+			__entry->end		=3D end - 1;
+	),
+
+	TP_printk("mt_mod %p, (NULL), SNULL, %lu, %lu,",
+		  __entry->mm,
+		  (unsigned long) __entry->start,
+		  (unsigned long) __entry->end
+	)
+);
+
+TRACE_EVENT(vma_store,
+	TP_PROTO(struct mm_struct *mm, struct vm_area_struct *vma),
+
+	TP_ARGS(mm, vma),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+			__field(struct vm_area_struct *, vma)
+			__field(unsigned long, vm_start)
+			__field(unsigned long, vm_end)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+			__entry->vma		=3D vma;
+			__entry->vm_start	=3D vma->vm_start;
+			__entry->vm_end		=3D vma->vm_end - 1;
+	),
+
+	TP_printk("mt_mod %p, (%p), STORE, %lu, %lu,",
+		  __entry->mm, __entry->vma,
+		  (unsigned long) __entry->vm_start,
+		  (unsigned long) __entry->vm_end
+	)
+);
+
+
+TRACE_EVENT(exit_mmap,
+	TP_PROTO(struct mm_struct *mm),
+
+	TP_ARGS(mm),
+
+	TP_STRUCT__entry(
+			__field(struct mm_struct *, mm)
+	),
+
+	TP_fast_assign(
+			__entry->mm		=3D mm;
+	),
+
+	TP_printk("mt_mod %p, DESTROY\n",
+		  __entry->mm
+	)
+);
+
 #endif
=20
 /* This part must be outside protection */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..c81993dff42c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -696,6 +696,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		rb_link =3D &tmp->vm_rb.rb_right;
 		rb_parent =3D &tmp->vm_rb;
=20
+		/* Link the vma into the MT */
+		vma_store(mm, tmp);
+
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
 			retval =3D copy_page_range(tmp, mpnt);
@@ -1107,6 +1110,8 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 {
 	mm->mmap =3D NULL;
 	mm->mm_rb =3D RB_ROOT;
+	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
+	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
 	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
diff --git a/mm/init-mm.c b/mm/init-mm.c
index fbe7844d0912..b912b0f2eced 100644
--- a/mm/init-mm.c
+++ b/mm/init-mm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm_types.h>
 #include <linux/rbtree.h>
+#include <linux/maple_tree.h>
 #include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/list.h>
@@ -29,6 +30,7 @@
  */
 struct mm_struct init_mm =3D {
 	.mm_rb		=3D RB_ROOT,
+	.mm_mt		=3D MTREE_INIT_EXT(mm_mt, MM_MT_FLAGS, init_mm.mmap_lock),
 	.pgd		=3D swapper_pg_dir,
 	.mm_users	=3D ATOMIC_INIT(2),
 	.mm_count	=3D ATOMIC_INIT(1),
diff --git a/mm/internal.h b/mm/internal.h
index 6ec89b4f0bc8..92734fc9b90d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -457,6 +457,40 @@ static inline bool is_data_mapping(vm_flags_t flags)
 	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRITE;
 }
=20
+/* Maple tree operations using VMAs */
+/*
+ * vma_mas_store() - Store a VMA in the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to store a VMA in the maple tree when the @mas has alread=
y
+ * walked to the correct location.
+ *
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline void vma_mas_store(struct vm_area_struct *vma, struct ma_sta=
te *mas)
+{
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_store_prealloc(mas, vma);
+}
+
+/*
+ * vma_mas_remove() - Remove a VMA from the maple tree.
+ * @vma: The vm_area_struct
+ * @mas: The maple state
+ *
+ * Efficient way to remove a VMA from the maple tree when the @mas has alr=
eady
+ * been established and points to the correct location.
+ * Note: the end address is inclusive in the maple tree.
+ */
+static inline void vma_mas_remove(struct vm_area_struct *vma, struct ma_st=
ate *mas)
+{
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	mas_store_prealloc(mas, NULL);
+}
+
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
diff --git a/mm/mmap.c b/mm/mmap.c
index 13e8ef8f81f6..4512f64a30ab 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -384,7 +384,70 @@ static int browse_rb(struct mm_struct *mm)
 	}
 	return bug ? -1 : i;
 }
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+extern void mt_validate(struct maple_tree *mt);
+extern void mt_dump(const struct maple_tree *mt);
=20
+/* Validate the maple tree */
+static void validate_mm_mt(struct mm_struct *mm)
+{
+	struct maple_tree *mt =3D &mm->mm_mt;
+	struct vm_area_struct *vma_mt, *vma =3D mm->mmap;
+
+	MA_STATE(mas, mt, 0, 0);
+	mas_for_each(&mas, vma_mt, ULONG_MAX) {
+		if (xa_is_zero(vma_mt))
+			continue;
+
+		if (!vma)
+			break;
+
+		if ((vma !=3D vma_mt) ||
+		    (vma->vm_start !=3D vma_mt->vm_start) ||
+		    (vma->vm_end !=3D vma_mt->vm_end) ||
+		    (vma->vm_start !=3D mas.index) ||
+		    (vma->vm_end - 1 !=3D mas.last)) {
+			pr_emerg("issue in %s\n", current->comm);
+			dump_stack();
+#ifdef CONFIG_DEBUG_VM
+			dump_vma(vma_mt);
+			pr_emerg("and next in rb\n");
+			dump_vma(vma->vm_next);
+#endif
+			pr_emerg("mt piv: %px %lu - %lu\n", vma_mt,
+				 mas.index, mas.last);
+			pr_emerg("mt vma: %px %lu - %lu\n", vma_mt,
+				 vma_mt->vm_start, vma_mt->vm_end);
+			pr_emerg("rb vma: %px %lu - %lu\n", vma,
+				 vma->vm_start, vma->vm_end);
+			pr_emerg("rb->next =3D %px %lu - %lu\n", vma->vm_next,
+					vma->vm_next->vm_start, vma->vm_next->vm_end);
+
+			mt_dump(mas.tree);
+			if (vma_mt->vm_end !=3D mas.last + 1) {
+				pr_err("vma: %px vma_mt %lu-%lu\tmt %lu-%lu\n",
+						mm, vma_mt->vm_start, vma_mt->vm_end,
+						mas.index, mas.last);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_end !=3D mas.last + 1, mm);
+			if (vma_mt->vm_start !=3D mas.index) {
+				pr_err("vma: %px vma_mt %px %lu - %lu doesn't match\n",
+						mm, vma_mt, vma_mt->vm_start, vma_mt->vm_end);
+				mt_dump(mas.tree);
+			}
+			VM_BUG_ON_MM(vma_mt->vm_start !=3D mas.index, mm);
+		}
+		VM_BUG_ON(vma !=3D vma_mt);
+		vma =3D vma->vm_next;
+
+	}
+	VM_BUG_ON(vma);
+	mt_validate(&mm->mm_mt);
+}
+#else
+#define validate_mm_mt(root) do { } while (0)
+#endif
 static void validate_mm_rb(struct rb_root *root, struct vm_area_struct *ig=
nore)
 {
 	struct rb_node *nd;
@@ -439,6 +502,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -683,6 +747,36 @@ static void __vma_link_file(struct vm_area_struct *vma=
)
 	}
 }
=20
+/*
+ * vma_mt_szero() - Set a given range to zero.  Used when modifying a
+ * vm_area_struct start or end.
+ *
+ * @mm: The struct_mm
+ * @start: The start address to zero
+ * @end: The end address to zero.
+ */
+static inline void vma_mt_szero(struct mm_struct *mm, unsigned long start,
+				unsigned long end)
+{
+	MA_STATE(mas, &mm->mm_mt, start, end - 1);
+
+	trace_vma_mt_szero(mm, start, end);
+	mas_store_gfp(&mas, NULL, GFP_KERNEL);
+}
+
+/*
+ * vma_store() - Store a given vm_area_struct in the maple tree.
+ * @mm: The struct_mm
+ * @vma: The vm_area_struct to store in the maple tree.
+ */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+
+	trace_vma_store(vma->vm_mm, vma);
+	vma_mas_store(vma, &mas);
+}
+
 static void
 __vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 	struct vm_area_struct *prev, struct rb_node **rb_link,
@@ -692,17 +786,22 @@ __vma_link(struct mm_struct *mm, struct vm_area_struc=
t *vma,
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
=20
-static void vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
+static int vma_link(struct mm_struct *mm, struct vm_area_struct *vma,
 			struct vm_area_struct *prev, struct rb_node **rb_link,
 			struct rb_node *rb_parent)
 {
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct address_space *mapping =3D NULL;
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		return -ENOMEM;
+
 	if (vma->vm_file) {
 		mapping =3D vma->vm_file->f_mapping;
 		i_mmap_lock_write(mapping);
 	}
=20
+	vma_mas_store(vma, &mas);
 	__vma_link(mm, vma, prev, rb_link, rb_parent);
 	__vma_link_file(vma);
=20
@@ -711,13 +810,15 @@ static void vma_link(struct mm_struct *mm, struct vm_=
area_struct *vma,
=20
 	mm->map_count++;
 	validate_mm(mm);
+	return 0;
 }
=20
 /*
  * Helper for vma_adjust() in the split_vma insert case: insert a vma into=
 the
  * mm's list and rbtree.  It has already been inserted into the interval t=
ree.
  */
-static void __insert_vm_struct(struct mm_struct *mm, struct vm_area_struct=
 *vma)
+static void __insert_vm_struct(struct mm_struct *mm, struct ma_state *mas,
+			       struct vm_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
@@ -725,7 +826,11 @@ static void __insert_vm_struct(struct mm_struct *mm, s=
truct vm_area_struct *vma)
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		BUG();
-	__vma_link(mm, vma, prev, rb_link, rb_parent);
+
+	mas_reset(mas);
+	vma_mas_store(vma, mas);
+	__vma_link_list(mm, vma, prev);
+	__vma_link_rb(mm, vma, rb_link, rb_parent);
 	mm->map_count++;
 }
=20
@@ -759,10 +864,13 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	bool start_changed =3D false, end_changed =3D false;
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
-	if (next && !insert) {
-		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
+	validate_mm(mm);
+	validate_mm_mt(mm);
=20
+	if (next && !insert) {
 		if (end >=3D next->vm_end) {
 			/*
 			 * vma expands, overlapping all the next, and
@@ -845,6 +953,12 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 again:
 	vma_adjust_trans_huge(orig_vma, start, end, adjust_next);
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		if (exporter && exporter->anon_vma)
+			unlink_anon_vmas(importer);
+		return -ENOMEM;
+	}
+
 	if (file) {
 		mapping =3D file->f_mapping;
 		root =3D &mapping->i_mmap;
@@ -885,17 +999,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 	}
=20
 	if (start !=3D vma->vm_start) {
+		unsigned long old_start =3D vma->vm_start;
 		vma->vm_start =3D start;
+		if (old_start < start)
+			vma_mt_szero(mm, old_start, start);
 		start_changed =3D true;
 	}
 	if (end !=3D vma->vm_end) {
+		unsigned long old_end =3D vma->vm_end;
 		vma->vm_end =3D end;
+		if (old_end > end)
+			vma_mt_szero(mm, end, old_end);
 		end_changed =3D true;
 	}
+
+	if (end_changed || start_changed)
+		vma_mas_store(vma, &mas);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_mas_store(next, &mas);
 	}
=20
 	if (file) {
@@ -909,6 +1034,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next !=3D 3)
 			__vma_unlink(mm, next, next);
@@ -931,7 +1058,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		 * us to insert it before dropping the locks
 		 * (it may either follow vma or precede it).
 		 */
-		__insert_vm_struct(mm, insert);
+		__insert_vm_struct(mm, &mas, insert);
 	} else {
 		if (start_changed)
 			vma_gap_update(vma);
@@ -1028,6 +1155,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1181,6 +1309,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1256,6 +1385,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1735,6 +1865,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1849,7 +1980,14 @@ unsigned long mmap_region(struct file *file, unsigne=
d long addr,
 			goto free_vma;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
 	/* Once vma denies write, undo our temporary denial count */
 unmap_writable:
 	if (file && vm_flags & VM_SHARED)
@@ -1882,6 +2020,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1898,6 +2037,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1914,12 +2054,19 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+			   length);
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+
 	/* Adjust search limits by the desired length */
 	if (info->high_limit < length)
 		return -ENOMEM;
@@ -2001,20 +2148,31 @@ static unsigned long unmapped_area(struct vm_unmapp=
ed_area_info *info)
=20
 	VM_BUG_ON(gap_start + info->length > info->high_limit);
 	VM_BUG_ON(gap_start + info->length > gap_end);
+
+	VM_BUG_ON(gap !=3D gap_start);
 	return gap_start;
 }
=20
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long gap;
+
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	validate_mm_mt(mm);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
+	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+		   length);
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+
 	/*
 	 * Adjust search limits by the desired length.
 	 * See implementation comment at top of unmapped_area().
@@ -2100,6 +2258,32 @@ static unsigned long unmapped_area_topdown(struct vm=
_unmapped_area_info *info)
=20
 	VM_BUG_ON(gap_end < info->low_limit);
 	VM_BUG_ON(gap_end < gap_start);
+
+	if (gap !=3D gap_end) {
+		pr_err("%s: %px Gap was found: mt %lu gap_end %lu\n", __func__,
+		       mm, gap, gap_end);
+		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
+		       info->low_limit, length);
+		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
+		       mas.last);
+		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
+		       info->align_mask, info->align_offset);
+		pr_err("rb_find_vma find on %lu =3D> %px (%px)\n", mas.index,
+		       find_vma(mm, mas.index), vma);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		{
+			struct vm_area_struct *dv =3D mm->mmap;
+
+			while (dv) {
+				printk("vma %px %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
+				dv =3D dv->vm_next;
+			}
+		}
+		VM_BUG_ON(gap !=3D gap_end);
+	}
+
 	return gap_end;
 }
=20
@@ -2313,7 +2497,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2387,6 +2570,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	unsigned long gap_addr;
 	int error =3D 0;
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2449,6 +2633,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
+				/* Overwrite old entry in mtree. */
+				vma_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				if (vma->vm_next)
 					vma_gap_update(vma->vm_next);
@@ -2463,6 +2649,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2477,6 +2664,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct vm_area_struct *prev;
 	int error =3D 0;
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2530,6 +2718,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2671,6 +2861,7 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	vma_mt_szero(mm, vma->vm_start, end);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		if (vma->vm_flags & VM_LOCKED)
@@ -2711,6 +2902,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2763,6 +2955,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -3011,6 +3204,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3060,7 +3254,9 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	vma->vm_pgoff =3D pgoff;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if(vma_link(mm, vma, prev, rb_link, rb_parent))
+		goto no_vma_link;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -3068,7 +3264,12 @@ static int do_brk_flags(unsigned long addr, unsigned=
 long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
+
+no_vma_link:
+	vm_area_free(vma);
+	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
@@ -3114,6 +3315,7 @@ void exit_mmap(struct mm_struct *mm)
 	/* mm's last user has gone, and its about to be pulled down */
 	mmu_notifier_release(mm);
=20
+	mmap_write_lock(mm);
 	if (unlikely(mm_is_oom_victim(mm))) {
 		/*
 		 * Manually reap the mm to free as much memory as possible.
@@ -3131,9 +3333,7 @@ void exit_mmap(struct mm_struct *mm)
 		set_bit(MMF_OOM_SKIP, &mm->flags);
 	}
=20
-	mmap_write_lock(mm);
 	arch_exit_mmap(mm);
-
 	vma =3D mm->mmap;
 	if (!vma) {
 		/* Can happen if dup_mmap() received an OOM */
@@ -3157,7 +3357,9 @@ void exit_mmap(struct mm_struct *mm)
 		vma =3D remove_vma(vma);
 		cond_resched();
 	}
-	mm->mmap =3D NULL;
+
+	trace_exit_mmap(mm);
+	__mt_destroy(&mm->mm_mt);
 	mmap_write_unlock(mm);
 	vm_unacct_memory(nr_accounted);
 }
@@ -3170,10 +3372,25 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
m_area_struct *vma)
 {
 	struct vm_area_struct *prev;
 	struct rb_node **rb_link, *rb_parent;
+	unsigned long start =3D vma->vm_start;
+	struct vm_area_struct *overlap =3D NULL;
=20
 	if (find_vma_links(mm, vma->vm_start, vma->vm_end,
 			   &prev, &rb_link, &rb_parent))
 		return -ENOMEM;
+
+	overlap =3D mt_find(&mm->mm_mt, &start, vma->vm_end - 1);
+	if (overlap) {
+
+		pr_err("Found vma ending at %lu\n", start - 1);
+		pr_err("vma : %lu =3D> %lu-%lu\n", (unsigned long)overlap,
+				overlap->vm_start, overlap->vm_end - 1);
+#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
+		mt_dump(&mm->mm_mt);
+#endif
+		BUG();
+	}
+
 	if ((vma->vm_flags & VM_ACCOUNT) &&
 	     security_vm_enough_memory_mm(mm, vma_pages(vma)))
 		return -ENOMEM;
@@ -3195,7 +3412,9 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_=
area_struct *vma)
 		vma->vm_pgoff =3D vma->vm_start >> PAGE_SHIFT;
 	}
=20
-	vma_link(mm, vma, prev, rb_link, rb_parent);
+	if (vma_link(mm, vma, prev, rb_link, rb_parent))
+		return -ENOMEM;
+
 	return 0;
 }
=20
@@ -3213,7 +3432,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 	struct vm_area_struct *new_vma, *prev;
 	struct rb_node **rb_link, *rb_parent;
 	bool faulted_in_anon_vma =3D true;
+	unsigned long index =3D addr;
=20
+	validate_mm_mt(mm);
 	/*
 	 * If anonymous vma has not yet been faulted, update new pgoff
 	 * to match new location, to increase its chance of merging.
@@ -3225,6 +3446,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
@@ -3268,6 +3491,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3275,6 +3499,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3411,6 +3636,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3433,10 +3659,12 @@ static struct vm_area_struct *__install_special_map=
ping(
=20
 	perf_event_mmap(vma);
=20
+	validate_mm_mt(mm);
 	return vma;
=20
 out:
 	vm_area_free(vma);
+	validate_mm_mt(mm);
 	return ERR_PTR(ret);
 }
=20
--=20
2.35.1
