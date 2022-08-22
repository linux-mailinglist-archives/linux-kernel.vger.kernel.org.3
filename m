Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE92D59C224
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235890AbiHVPHb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbiHVPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:05:37 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A6C2605
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkUsC022008;
        Mon, 22 Aug 2022 15:05:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=Hs0XqIQQmOSsD2hO9I9qDyRPEbFwE/D9vtavdyMcqCxMbTa61oCbrvegdOtH7Iqsy/vR
 tPQW6EdqMaJB9TbpsgyP+YuJsmUqVVkZQOA6nPqiSbmfGCrEVszIb3jkyHOwl9wrPhcE
 jZkycgPBxkD1JJ3W3y6UknYJagXuQ7Qpx2NJzS5jPNfOj8gSP2z92dIlury0q7vNY9qV
 7NhinYjMFYCTeBjrMwcDFiE/hOab09MOLV2U3JA6h4jQEWDjPf4UqjvVUYq1Q8wGpFG/
 pDrdCZ/isxexIUmKrFMmIFTIEzjQm/XX+uoVlhocqRCXUz4CQmq4qOAcsP4nlsM3RDDL Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4btmg2q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:23 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4l4a025335;
        Mon, 22 Aug 2022 15:05:22 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn1uawa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro+DBL98oDjJtXw91WLBqHHzvIibXf3pl6xlmBpgNtTzjQqy45UdJgPHAmqS6By1XJv5ONI77N8NKJbmzqyeFzr635TtoHj/nW5YObWi9DaY+6GsJ2EEVm/c5mof46bNSojN1y+IgnbM83fM0VsZ/o8ylS4/Y7Fns8NV7E8ftJwr8I8nFLJ+qUKe36AxVZWUKRJSnW3dnvoWqyRfsgXG4Cq0Uf5nbtYtONGvqQPgFPLdJnQLQ2KMyjdtmFQnBzZW+oipuc+UafmKIiHzf2IqEXBgsBYTv3oAeJQGT+ic3aIpNoAeOGX7jXoSgpHWtrQef80Uwd8k6XKp5+VVvYG8EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=fnKRqm/FRoPwbgLhvpSk54xKN2dHvi3pfwxua9RjMnKNSjd1PTpvL9GvoNSde1HYsSKU7IYNoaZYsBybbXNkG9kXtiHDrY0OVbUi2nZbUtHbSfGTTiuy7Frsd2MdyY0RorIxWzjU1PNHzilHav2WCZuOVhKeFO3kicetNqiF3g6jJ5Qcc0X+QUFl4sZx/L4EOGbK9LHTchhqUB840YaM//vOr4PCB7Odw1qCBNZUmSPiLFHsPKysT2TTFDh7cXm0NHevL/tTKioToyNzyxOwbs9CFv9pho5G0otjE0ouQ7SHQl4KLOQgi9mwwDsfr9w7X5I+sgZpld6MUBzqdPhDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b56Z6rNYl+jTxxBz+9XdChUJVjcaDZsODTDrlXoyXMw=;
 b=vAEWGB18L5HwoGV2Rmfd4fdfj8o/llXtxNXct8FMVXs30b7BKi7SMQRUz/LxRQO0KnuE4xYvcRkCSi79BxVkBAdq3JSkRHvCV1o5cfkD6wDrqBBgiIoYAS+7NqPLTQaJD4m+BHgyRf2b1Cd51t6guyTaXPeN+NkDz/vEh763HSI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:21 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:21 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 30/70] arm64: remove mmap linked list from vdso
Thread-Topic: [PATCH v13 30/70] arm64: remove mmap linked list from vdso
Thread-Index: AQHYtjiZYfkkL1LwzUC2FvUYZNkHnw==
Date:   Mon, 22 Aug 2022 15:05:21 +0000
Message-ID: <20220822150128.1562046-31-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7304845d-4dec-4c78-932d-08da844fbb94
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1/LI2DoIllk8kH2PCpqGV4Xa3CRejluykeogCzvBv+8tZgfnmNmooehRKrdom0mO0/wsmvnv3ToVPWqnnSMxLQiCqRL3TdCIrqSDyi9+ExIi3nmsB/nRIobYMHOS+bUgtuW1pY7VuInpx0mTrXIqEFLp6Vreta7KqPB6KJ3TfdVeqhO0vfrqGE2t9Jsji80RyT8FS8vwwjWjOhzTTL3mmt+i29XobeyV4+mnTcgysdXev8QwVKS9WhBFGd5oU3ACBfpN/M42/JVvpcJo6VX99unS/O82a29koTc7WlJBtCctY2tqDGQn3MympcPg+R8mRGgzpYFhNP820oeBcwxhkXesRcrQH2F5yf8obWHJpZ+kkby/VVLnQ2H8tFi6pnv5kBYU3zKW3uewhtuLzGCS20kYKVsjq2uOg2nsxlYJFq0r2UYPvTSFF74WlJ7MrBAY1aRC2txO31V/aNl6+mXffyC6mANFy4hLdaOy6cu8ncoXj22RpG0bNd8YNMqsWp/A4IuhmV+6Xn8s3lid1LJZsb0E/04JFKJ+vZjFERSWMaTp8uqQfrPDmUxsQod4y+vbrHxFrgSQoxu+yYn92mF9Q6zxO5fK2fnc3ELA51L6q+AaWoDf1gU+9yMmckDAVkILSIqcOYQk+ul8T8fMxjjqjyn7cxHzLDsuyCYSIrIOFvcu3naFDTkrcR6OE5unIGiOcSLgc6DBYf1UmBfvMPWqsRAc71ARbwkteEq3faciz2GLdfB4NUXZsRDV2jYWTCgO/9E+cgoJ8By1AIujezYJig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(54906003)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(4744005)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2TUGJ6EZQ0Ow2j5M/qRtmhj1E3Wo441c+Nd/7vtaKngpsE6+Cg7iO+R+Q3?=
 =?iso-8859-1?Q?OScgMdXEKi8SGKpk0lzNj6xK8yvZtbtqKiTdnAAc1LkAUKZW2LZA1GVJfr?=
 =?iso-8859-1?Q?AokP9DK0T2VFwEmWT/s2diyq4nrMrVVjKobe2EGRnmEMVQKhujlq5RselJ?=
 =?iso-8859-1?Q?BMZU69JTB2bYpSW2pBUg0rZQJkaQeoAnoCsuD5bMiX39dzj7Y1IESdkTls?=
 =?iso-8859-1?Q?7in9rRw3QLK68GeJBWjk2Yf/z5kBQIPbo3Jw36HpoTn7DYgeq2Z2xyqFdH?=
 =?iso-8859-1?Q?AfwGsC9KFh2IqAfbs/Pw01wIkoPWgAqfB5j4DlcRAvcDKMNr206a6hhYG8?=
 =?iso-8859-1?Q?xodw/DLPQ5l6lAghCNn2jK7uZUTVu++JuMoGa2LaS076jx/zGVR2thcTdB?=
 =?iso-8859-1?Q?17/77sh554pwmWBM1m3Ji9ElwdaTa3Kq6s9wl0g9V4aKKJYGMHQCPhRhRE?=
 =?iso-8859-1?Q?bufkWL4FJEcmlK+WCA86fuQ7Gxco97/pY63cuPzljMCMgk3mmTlLeQhGRG?=
 =?iso-8859-1?Q?2Iw0lRG8ypiAveltAyHeOJljIB4QdmfjtWym+cPw7N+Sa+LljO5mrHCOwi?=
 =?iso-8859-1?Q?AIis/vERh00mx/202MFZxTcwYFnBp+4Hvk83pdIyMw8PowLWXMASr0FcYm?=
 =?iso-8859-1?Q?0X8omgixC94GuWX5OJldvXZJ2RdB0UGQyHvP/kDSoDJuMjOsZjyrxShr2T?=
 =?iso-8859-1?Q?te16ula4txdiAt3af22PzY8m0VBTIU49uc3ujP9aMeohneWnN3WiqJ9txv?=
 =?iso-8859-1?Q?IkMPhZS0yMqGmtuWAespM2VQAwH3hIc/viJl3mW9wDNq9sTb8dMf/3X2ho?=
 =?iso-8859-1?Q?U8KmNAuBURILyrVqyNztS9b0bK8ppUyJAoHuBsPlNq6ROMXCexqo/vp+mF?=
 =?iso-8859-1?Q?ZBBQOUsAHelKZnf2Qg2ElOism0NzTG+pmTTI9zJ1JitPFopCJrcXO+iJj4?=
 =?iso-8859-1?Q?2FqWQXIysS75qSY5pQ/Vt7DytPhUyPnlkjA/GjGbhoWmXcuV/MBQ8Zjs8z?=
 =?iso-8859-1?Q?LDPrPGihpIuYIKoa58S9QQ8ALSeno8AY/DADUX/4rk3BiMIOOwufvTTCmi?=
 =?iso-8859-1?Q?u86QyXOldObEDQwfknbnq5eU264va5T7CMDNpzsVow90gHmo109zMuft/T?=
 =?iso-8859-1?Q?hpg3SAsQoOz6X9kl06xw7+sooAZpKEKJBdo0PsAX7hSclbgRwYbZF4I8nh?=
 =?iso-8859-1?Q?lkEdi9CDS53Slabre2XmmOKiTWOR3a6ZpEV0WTzDx/TkhQJsKsK4Y9RSyN?=
 =?iso-8859-1?Q?zznhv4EdS8HG2Hfhy1YlyIA6JhIkPneBXGk612BD2NEB7ZCGh/8dDjdu+B?=
 =?iso-8859-1?Q?Km8KzMvvo5WFgf/Q9HbTsq2rbsAUkPKmVYyFKTu8Rr480XK52TGxdUSmOy?=
 =?iso-8859-1?Q?sxiihwmwimu52sKFqkPbTCLa39HDKoJxUuiIG+a5zuA9G9qSQVoqvIL4GU?=
 =?iso-8859-1?Q?LIEFfyu2lU1qtaWjtGUVUwpTAc4R/2ssF2BWeK+auIZvS+WIQ4Vu1CnVOB?=
 =?iso-8859-1?Q?Hqwoths8THOhw7rVmZjSsY38qUX1PMbEt8dXH/LGkJcC3gF/s71Bt3CFfC?=
 =?iso-8859-1?Q?KvMV5g2K15opeMsPDLenBu0437k5vbZUUyDJfAZ8/QmHRgTDa7U6fpL6wG?=
 =?iso-8859-1?Q?eGJ8tGOiGVW9+YWhjtXQoBPW1Ca7HKr5XLfaB9q9LxGwq9zt1iv8PHjQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7304845d-4dec-4c78-932d-08da844fbb94
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:21.0393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X9O+6ST8Pp8b5+WmVqdBrRGKvzvnafMMFRvVGtEPEUTqq2GfHmPoSWrCBU/YIPx3r3+JqgAQjpJ3NhMzkgrb0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-GUID: KDEelEQZ5c1e5ErZxlwtYUI8uvdQAa7t
X-Proofpoint-ORIG-GUID: KDEelEQZ5c1e5ErZxlwtYUI8uvdQAa7t
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/arm64/kernel/vdso.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index a61fc4f989b3..a8388af62b99 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -136,10 +136,11 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, vdso_info[VDSO_ABI_AA64].dm))
--=20
2.35.1
