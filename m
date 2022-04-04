Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020B24F1733
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377977AbiDDOkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377659AbiDDOhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:43 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7EE3AA44
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:46 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dj3Y4024447;
        Mon, 4 Apr 2022 14:35:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=id8Qwo9oOgn5CP/tFzNKnIuKZiCAmdbA03Dzp8iVo6Q=;
 b=rRZ3d/kr/n56IQq0Y41C+uWfghnH/Q8ts4TxtV0osDiSJpJtwFnHHPNE6K+Q7wfgni2o
 3Zqfn4R5Kfj9rynjSfLLBcvvMz1y9YTxVFJ8d9yVvbP5gT1XpyqDgmP07T8ReeMXA1BT
 Cq7g5LxZVZd7a3mGDf+52K/7Lm8eVPJ3AVB2+z7MVKVtBLVmZBeZ2vONl8A70yOP/3QQ
 WsxHEqAbeZ+A3fhMnvVFo3/74jSIqsYX8NLOzyA9GHkuMPzEMrrz9M0BHQDhO2N9n6Tb
 C5FXpcRylBf6VhXSlDKP8Zsb3r2zsoN+i0/J1MFmtK6KlJKhPOVpwKXlRvLW0Fmgo65U vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cs1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EZaYb034331;
        Mon, 4 Apr 2022 14:35:39 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2mgyc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGCxZ8A2nGYq6hGgpWuOLRyDInCKuW3UzfM2FqGU6qTXai2jbPpHvgVn1L7F1whA3KmLMmbRakqNBJBx2T1PiUMY52SZEOKY/UfpOIriXPImy9/0bKGKSAkMxBbFLILPuiEJL/UwmrQH1zhb6TjdlO30WGh5EUhHudbWVkNewxhU9rueAhMT6R93AL3uMVzPUSAb2wlPOfShEFdE9d++5o/mxjY8Qu8zgqnc+sreB9IsPt88tqBrc/nVLx/vhQ6reqfaXPKBj6qBLw0ORkY/nqKHuJ8aqiSnmVLMuVyZGnfBtYCTS1RcbDQ+hP2KzpEyGJwN/SWz1+1ksA/A8iRTLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=id8Qwo9oOgn5CP/tFzNKnIuKZiCAmdbA03Dzp8iVo6Q=;
 b=Pu9yz/aRqHgzw/LFyWGA1XCYdvQbYvy7yeJ06d752x565ZAO8HF+gYX9Sy7BfAKVTnaPWj8SJ0tXHovBnR6Hjz2mj9os9+kzQpuW1JvZIbC2gHP9FwS9ara9z5+sqJ1UzjjcecRhyWrj8rWdEo4EgqW74Fi/DQ2QiqtjTXVBb8VZuR6TVeQfuCvKW/4eihEMgZ8WxVOjynE5zdPThL8kNocmD7bW5BwLkzOtMzOIsLZDAHALUGgAW7Z6i/CB41nr6tA1aduyOxyFPPTPphgvAJTfjxKQ74V2BkinPivrJnKHz8g8jSFh2x+pTMsEgadYHjCZz3DM68tQUoerDM7ULQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=id8Qwo9oOgn5CP/tFzNKnIuKZiCAmdbA03Dzp8iVo6Q=;
 b=GCV3spATBnW1taUaG72L5+Z9hvTCLFPz8hq0GAuUzHIT1K0dofZh9yhbcSNpI2DhZnbLnitqCJhk4+6QNhS1Wn4I2KhDfxiislXMJsBHnZnzwQAEPZHQYhPstQz2UJiTqim9NDFirChzrk5Iz9P1duGP2YgrottFg9+LFhN5gVE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 09/70] mm: Start tracking VMAs with maple tree
Thread-Topic: [PATCH v7 09/70] mm: Start tracking VMAs with maple tree
Thread-Index: AQHYSDE/jUBWCpuRs0eEwL33F/6MSw==
Date:   Mon, 4 Apr 2022 14:35:36 +0000
Message-ID: <20220404143501.2016403-10-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a578d788-775d-4945-361c-08da1648628c
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812B563D6F1985FE8A74F49FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nIJt192KI2l+pckmOX/+LXS41VOzDxFiND/OpPmI94H7X+ov6cjVYr40kof0ADeyPKCWOjSRSXYfzJnvDwfIKIMasaOpVLmiQYvRmUiRe+mEOJunYhn7pwqForndLWhdLA2VVskXZCnKT6shaJQlhNO9CP/Tm/HqeIFRjRYD1AJQCKJsSC/kLdtCkLFciSHQAhGZRdqdUJoEV0VsowcrEFe9LN9DkHB45RHjiAj01EH5LknBOwoJub2LcFUuCR8b9U1Cxn11kMRPNgH417yw53nKel3ibNFmjRq9ZA2ZMnXTdunHcnRs3wU98KmvdHDwdXodlXRZCsIJhgcsgIt3Efozms20bSv3XX08ZgiX43lBsb+RH6gb7xGha8DCzitEwlylN/QNaxxeYMbXcEkX7BcCu8RgCo4qafh83hbPE3lfUn/qgXzQvV+90cwMXxy3jMcAKsP5Toy9QQ/kZCNEccuqFW9JFd8dSb1zbXd8haDZJn4DX3Exop6YMMDnfURqArozYtGLIHzXTfX9MuXAY426s+XgKdWiMBSm9od9NTTHaxPS8J7ZV9Sp8uCrn26xVoR6PpQ0E5g9QxORO7BXX0XV7QeY6dWU/QGZBc3o2jnWbtUNEXb3DYIuGFa0sxDU43CVK6KlPcRXzc4h0NIKQTI6eEvmt5yrxSGuQJsjPb9vEfLbaLf8RI4vxsG1sbkfTTH13FzItuW0EnTDKHxDLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(30864003)(6486002)(8936002)(1076003)(44832011)(83380400001)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0tVswB2QnuVVZ2+2h/fTRmEGLroLS6foZ6Ymuo2ziN9ZEhMliaYKUPSbEv?=
 =?iso-8859-1?Q?m8L4+I4WjVqx7sybUD9yNjUe2ikgoIR7U8pBJZowhU5d6Admnf8Xg8Akax?=
 =?iso-8859-1?Q?XdcUbhWrxFt7GnKXQj6a1tfaayjk1RICJCtrlp2/G4pacO4U4LU5oryxTP?=
 =?iso-8859-1?Q?oYdiRMnRTyYoqKO2N6u7wbIWsg7d/uothX9d0MIgeNYcnGrcg+/E9zHezs?=
 =?iso-8859-1?Q?MNCHPkTMHIpNA2umWVqUI52XjOSZzojjinT9lbeUyxi1SUc34O/9SafMHz?=
 =?iso-8859-1?Q?S6XSHzal1kzna5/32DINcvki7LVLXvNbEMMx5K0ggE9NUEBfUeWfxt4kVO?=
 =?iso-8859-1?Q?5772Km/DlaaULKbk0w9a+u5iHUzSuya1julgXRfGoo0JrvHKkI4GuMQkHP?=
 =?iso-8859-1?Q?qB4Ije45dnN35DEnbieZS1lJGnljzFLCUm2/EcGvn/X75/MQusy3sQrKH2?=
 =?iso-8859-1?Q?jkajGwO/NQUb/qJzeqQZsImgQdGCGHpLq3QabyXQ+BOl2WYAYBYmU/vrkp?=
 =?iso-8859-1?Q?Vp/3rbsTXym2iJ8ooOv/K/KDvy6bxgAD+5qabzjku6lmiuZmxdZLLc1PHc?=
 =?iso-8859-1?Q?nwrvHco6kFvF3S3mn728XUrd4L9BxABkxnwojmZvMCUYimKMcTqgb9F+Hi?=
 =?iso-8859-1?Q?rKJoJm7rgYssiZ5kFZWVOH3ER7WdDHUemS8ok4BZ7kV6t4cr6QVsfVlDKu?=
 =?iso-8859-1?Q?fvHXw7god3lM+gAYdEP+qLSmxoHFUDKJblQnBxjxCkdFE5OUi/b7h8fHM1?=
 =?iso-8859-1?Q?ReVc6ca2NpfqcOapyq00qCDtT2b8pYL6WsqeYvhhGJ8/IdjM6FMMDr/fY0?=
 =?iso-8859-1?Q?/ahREqvRRSxTGAJ/2JN36Ygxi1zjyN5B+ZTgpDkl5Asq0D4cfmQxjylWqD?=
 =?iso-8859-1?Q?vyw6Pw8bwlNtbB5NKPzEBiSnYhEtwmpyDvK0qfNdPS06hhGU+ds25P5kun?=
 =?iso-8859-1?Q?A8jF3s1Kuw7VBSQ5RRGXW6BQHLw2sNSnaYQ+85IwTbmqbSNMc1vjvhHbY/?=
 =?iso-8859-1?Q?EqpK/UMWuFcZfhYe+uMhfsLGcIdnDGyIyvWpD5vAdjKer10F1n3OuJEsg2?=
 =?iso-8859-1?Q?X7tAHfu5QzZ/ifS8ypXngp8dvMq5NMBzgZe2XUWiSur49j33QwyVBAqgZW?=
 =?iso-8859-1?Q?xreGKl+s/E3jHIe4AFTOZ4mtuGqam2IXEKRMrNwcQz/9BIMC0fyVe4+XhM?=
 =?iso-8859-1?Q?Hg6XaDmTarjF0PDjr+YMGjXp29DpanwM5Q6bA/1lCny15jJFZqVcwQm1tU?=
 =?iso-8859-1?Q?c5ktJultokuW8o037uxKulOdh6jXDzXsIWeW4yKf0VL203YtjMJ1M+JSwo?=
 =?iso-8859-1?Q?Cknj2IBPZjmCM+s96J8Tjl0CxfzJI2rhpDo7yadHnnL5WNyIEUiODVSuIa?=
 =?iso-8859-1?Q?stzh1TU+8L3jTEzAOnF2yU3pUAHlVLk6NIxmRUNmwQjcnxw7lfeSOVElWR?=
 =?iso-8859-1?Q?UcqEOf14pfB3FSVD+GtcILNbSByduEek4ck04oBNRxr6g9d2U0xTE83Pmn?=
 =?iso-8859-1?Q?+E5uKktrK8fiOLNQV2y7rOLY97ES7AWIjfe6GWYWFmxwe3eqX6Q+2ZDlrN?=
 =?iso-8859-1?Q?3wlGXLpJvvxxwwAaUUCH3maJCY7dJRbScH2CBKeD/ciWYmRIuN0rbBGRz3?=
 =?iso-8859-1?Q?J5O2yGul5y79aKGhI2z5AYAkL3lYvJL6GEdoMLnntjYXUS8oBwOsyWMpfe?=
 =?iso-8859-1?Q?gsFzy2D6HIFG/BmnpvfL48U2lsffuS+8+0W3W/jJTqn5T1NDfGnAA5+5QN?=
 =?iso-8859-1?Q?WqbkiR+CNjd/wbDsnnbSgh05ucJRh07EnlCkTv9UhIznhnDGRtjXf0yKcg?=
 =?iso-8859-1?Q?FBRumgNRaUIuFgjtFELsQtFDpb4HOtU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a578d788-775d-4945-361c-08da1648628c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:36.0503
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fZBBWMb1TD8vuiJ+K1+vlfUGxy71my09l+zKBp50RwhqG1VX8luEvFz3SrIbLSVUYs5kMIPysrn7j2m02G/9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: 6VodYXDtQhvoSUCTtOqE5Ib0eV6IgpT1
X-Proofpoint-GUID: 6VodYXDtQhvoSUCTtOqE5Ib0eV6IgpT1
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

Start tracking the VMAs with the new maple tree structure in parallel
with the rb_tree.  Add debug and trace events for maple tree operations
and duplicate the rb_tree that is created on forks into the maple tree.

The maple tree is added to the mm_struct including the mm_init struct,
added support in required mm/mmap functions, added tracking in
kernel/fork for process forking, and used to find the unmapped_area and
checked against what the rbtree finds.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/x86/kernel/tboot.c     |   1 +
 drivers/firmware/efi/efi.c  |   1 +
 include/linux/mm.h          |   2 +
 include/linux/mm_types.h    |   3 +
 include/trace/events/mmap.h |  71 +++++++++++++
 kernel/fork.c               |   5 +
 mm/init-mm.c                |   2 +
 mm/internal.h               |  70 +++++++++++++
 mm/mmap.c                   | 202 +++++++++++++++++++++++++++++++++++-
 9 files changed, 355 insertions(+), 2 deletions(-)

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
index e34edb775334..d21e4fdbe1a0 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2577,6 +2577,8 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
+/* mmap.c */
+void vma_store(struct mm_struct *mm, struct vm_area_struct *vma);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 8834e38c06a4..5efd9a095de4 100644
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
@@ -476,6 +477,7 @@ struct kioctx_table;
 struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
+		struct maple_tree mm_mt;
 		struct rb_root mm_rb;
 		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
@@ -664,6 +666,7 @@ struct mm_struct {
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
index cf16280ce132..8221f290d047 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -394,6 +394,76 @@ static inline bool is_data_mapping(vm_flags_t flags)
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
+static inline int vma_mas_store(struct vm_area_struct *vma, struct ma_stat=
e *mas)
+{
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+	/* Make sure no VMAs are about to be lost. */
+	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+	struct vm_area_struct *vma_mas;
+	int count =3D 0;
+
+	mas_for_each(&test, vma_mas, vma->vm_end - 1) {
+		/* Rule out vma_expand */
+		if ((vma->vm_start !=3D vma_mas->vm_start) &&
+		    (vma->vm_end !=3D vma_mas->vm_end))
+			count++;
+	}
+
+	/* vma adjust may overwrite a partial entry or remove one */
+	BUG_ON(count > 1);
+
+	BUG_ON(mas->min > vma->vm_start);
+	BUG_ON(mas->index > vma->vm_start);
+#endif
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	return mas_store_gfp(mas, vma, GFP_KERNEL);
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
+static inline int vma_mas_remove(struct vm_area_struct *vma, struct ma_sta=
te *mas)
+{
+	int ret;
+
+#ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+	/* Make sure no VMAs are about to be lost. */
+	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+	struct vm_area_struct *vma_mas;
+	int count =3D 0;
+
+	mas_for_each(&test, vma_mas, vma->vm_end - 1)
+		count++;
+
+	BUG_ON(count !=3D 1);
+
+	BUG_ON(mas->min > vma->vm_start);
+	BUG_ON(mas->min > mas->index);
+#endif
+	mas->index =3D vma->vm_start;
+	mas->last =3D vma->vm_end - 1;
+	ret =3D mas_store_gfp(mas, NULL, GFP_KERNEL);
+	return ret;
+}
+
 /* mm/util.c */
 void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
 		struct vm_area_struct *prev);
diff --git a/mm/mmap.c b/mm/mmap.c
index 3aa839f81e63..ebdee54b92e3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -376,7 +376,70 @@ static int browse_rb(struct mm_struct *mm)
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
@@ -431,6 +494,7 @@ static void validate_mm(struct mm_struct *mm)
 }
 #else
 #define validate_mm_rb(root, ignore) do { } while (0)
+#define validate_mm_mt(root) do { } while (0)
 #define validate_mm(mm) do { } while (0)
 #endif
=20
@@ -675,11 +739,42 @@ static void __vma_link_file(struct vm_area_struct *vm=
a)
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
 	struct rb_node *rb_parent)
 {
+	vma_store(mm, vma);
 	__vma_link_list(mm, vma, prev);
 	__vma_link_rb(mm, vma, rb_link, rb_parent);
 }
@@ -752,6 +847,9 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 	long adjust_next =3D 0;
 	int remove_next =3D 0;
=20
+	validate_mm(mm);
+	validate_mm_mt(mm);
+
 	if (next && !insert) {
 		struct vm_area_struct *exporter =3D NULL, *importer =3D NULL;
=20
@@ -877,17 +975,28 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
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
+		vma_store(mm, vma);
+
 	vma->vm_pgoff =3D pgoff;
 	if (adjust_next) {
 		next->vm_start +=3D adjust_next;
 		next->vm_pgoff +=3D adjust_next >> PAGE_SHIFT;
+		vma_store(mm, next);
 	}
=20
 	if (file) {
@@ -901,6 +1010,8 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned =
long start,
 		/*
 		 * vma_merge has merged next into vma, and needs
 		 * us to remove next before dropping the locks.
+		 * Since we have expanded over this vma, the maple tree will
+		 * have overwritten by storing the value
 		 */
 		if (remove_next !=3D 3)
 			__vma_unlink(mm, next, next);
@@ -1020,6 +1131,7 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 		uprobe_mmap(insert);
=20
 	validate_mm(mm);
+	validate_mm_mt(mm);
=20
 	return 0;
 }
@@ -1173,6 +1285,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	struct vm_area_struct *area, *next;
 	int err;
=20
+	validate_mm_mt(mm);
 	/*
 	 * We later require that vma->vm_flags =3D=3D vm_flags,
 	 * so this tests vma->vm_flags & VM_SPECIAL, too.
@@ -1248,6 +1361,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 		khugepaged_enter_vma_merge(area, vm_flags);
 		return area;
 	}
+	validate_mm_mt(mm);
=20
 	return NULL;
 }
@@ -1727,6 +1841,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	struct rb_node **rb_link, *rb_parent;
 	unsigned long charged =3D 0;
=20
+	validate_mm_mt(mm);
 	/* Check against address space limit. */
 	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
 		unsigned long nr_pages;
@@ -1874,6 +1989,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
=20
 	vma_set_page_prot(vma);
=20
+	validate_mm_mt(mm);
 	return addr;
=20
 unmap_and_free_vma:
@@ -1890,6 +2006,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 unacct_error:
 	if (charged)
 		vm_unacct_memory(charged);
+	validate_mm_mt(mm);
 	return error;
 }
=20
@@ -1906,12 +2023,19 @@ static unsigned long unmapped_area(struct vm_unmapp=
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
@@ -1993,20 +2117,31 @@ static unsigned long unmapped_area(struct vm_unmapp=
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
@@ -2092,6 +2227,32 @@ static unsigned long unmapped_area_topdown(struct vm=
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
@@ -2305,7 +2466,6 @@ struct vm_area_struct *find_vma(struct mm_struct *mm,=
 unsigned long addr)
 		vmacache_update(addr, vma);
 	return vma;
 }
-
 EXPORT_SYMBOL(find_vma);
=20
 /*
@@ -2386,6 +2546,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	unsigned long gap_addr;
 	int error =3D 0;
=20
+	validate_mm_mt(mm);
 	if (!(vma->vm_flags & VM_GROWSUP))
 		return -EFAULT;
=20
@@ -2448,6 +2609,8 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 				vm_stat_account(mm, vma->vm_flags, grow);
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_end =3D address;
+				/* Overwrite old entry in mtree. */
+				vma_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				if (vma->vm_next)
 					vma_gap_update(vma->vm_next);
@@ -2462,6 +2625,7 @@ int expand_upwards(struct vm_area_struct *vma, unsign=
ed long address)
 	anon_vma_unlock_write(vma->anon_vma);
 	khugepaged_enter_vma_merge(vma, vma->vm_flags);
 	validate_mm(mm);
+	validate_mm_mt(mm);
 	return error;
 }
 #endif /* CONFIG_STACK_GROWSUP || CONFIG_IA64 */
@@ -2476,6 +2640,7 @@ int expand_downwards(struct vm_area_struct *vma,
 	struct vm_area_struct *prev;
 	int error =3D 0;
=20
+	validate_mm(mm);
 	address &=3D PAGE_MASK;
 	if (address < mmap_min_addr)
 		return -EPERM;
@@ -2529,6 +2694,8 @@ int expand_downwards(struct vm_area_struct *vma,
 				anon_vma_interval_tree_pre_update_vma(vma);
 				vma->vm_start =3D address;
 				vma->vm_pgoff -=3D grow;
+				/* Overwrite old entry in mtree. */
+				vma_store(mm, vma);
 				anon_vma_interval_tree_post_update_vma(vma);
 				vma_gap_update(vma);
 				spin_unlock(&mm->page_table_lock);
@@ -2670,6 +2837,7 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct vm_area_struct *vma,
=20
 	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
 	vma->vm_prev =3D NULL;
+	vma_mt_szero(mm, vma->vm_start, end);
 	do {
 		vma_rb_erase(vma, &mm->mm_rb);
 		if (vma->vm_flags & VM_LOCKED)
@@ -2710,6 +2878,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 {
 	struct vm_area_struct *new;
 	int err;
+	validate_mm_mt(mm);
=20
 	if (vma->vm_ops && vma->vm_ops->may_split) {
 		err =3D vma->vm_ops->may_split(vma, addr);
@@ -2762,6 +2931,7 @@ int __split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	mpol_put(vma_policy(new));
  out_free_vma:
 	vm_area_free(new);
+	validate_mm_mt(mm);
 	return err;
 }
=20
@@ -3010,6 +3180,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
 	int error;
 	unsigned long mapped_addr;
+	validate_mm_mt(mm);
=20
 	/* Until we need other flags, refuse anything except VM_EXEC. */
 	if ((flags & (~VM_EXEC)) !=3D 0)
@@ -3067,6 +3238,7 @@ static int do_brk_flags(unsigned long addr, unsigned =
long len, unsigned long fla
 	if (flags & VM_LOCKED)
 		mm->locked_vm +=3D (len >> PAGE_SHIFT);
 	vma->vm_flags |=3D VM_SOFTDIRTY;
+	validate_mm_mt(mm);
 	return 0;
 }
=20
@@ -3158,6 +3330,8 @@ void exit_mmap(struct mm_struct *mm)
 	}
 	mm->mmap =3D NULL;
 	mmap_write_unlock(mm);
+	trace_exit_mmap(mm);
+	__mt_destroy(&mm->mm_mt);
 	vm_unacct_memory(nr_accounted);
 }
=20
@@ -3169,10 +3343,25 @@ int insert_vm_struct(struct mm_struct *mm, struct v=
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
@@ -3212,7 +3401,9 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
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
@@ -3224,6 +3415,8 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
=20
 	if (find_vma_links(mm, addr, addr + len, &prev, &rb_link, &rb_parent))
 		return NULL;	/* should never get here */
+	if (mt_find(&mm->mm_mt, &index, addr+len - 1))
+		BUG();
 	new_vma =3D vma_merge(mm, prev, addr, addr + len, vma->vm_flags,
 			    vma->anon_vma, vma->vm_file, pgoff, vma_policy(vma),
 			    vma->vm_userfaultfd_ctx, anon_vma_name(vma));
@@ -3267,6 +3460,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 		vma_link(mm, new_vma, prev, rb_link, rb_parent);
 		*need_rmap_locks =3D false;
 	}
+	validate_mm_mt(mm);
 	return new_vma;
=20
 out_free_mempol:
@@ -3274,6 +3468,7 @@ struct vm_area_struct *copy_vma(struct vm_area_struct=
 **vmap,
 out_free_vma:
 	vm_area_free(new_vma);
 out:
+	validate_mm_mt(mm);
 	return NULL;
 }
=20
@@ -3410,6 +3605,7 @@ static struct vm_area_struct *__install_special_mappi=
ng(
 	int ret;
 	struct vm_area_struct *vma;
=20
+	validate_mm_mt(mm);
 	vma =3D vm_area_alloc(mm);
 	if (unlikely(vma =3D=3D NULL))
 		return ERR_PTR(-ENOMEM);
@@ -3432,10 +3628,12 @@ static struct vm_area_struct *__install_special_map=
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
2.34.1
