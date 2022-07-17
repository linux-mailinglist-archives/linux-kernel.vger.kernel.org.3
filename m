Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD7D57735A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233393AbiGQCuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233271AbiGQCtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED331EEC6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8glV009607;
        Sun, 17 Jul 2022 02:47:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UA7JQTZ/EY25+xzPCgfxRsv7LOWbOF6vDNGzVSDECso=;
 b=q0KaIliYYc89J4urKNgZAV+hvQDajAvl4aRwS/qwQi6vTK94AwRmWS0ClBQv3/VvDo0R
 5Jlursfz7ZPkVfCpr8/4BZ/wVfhe31CmUGHqmMhu1VrgyJ0Nf/bNU9SxJ1Uwj6zOYkVE
 3zWL//7L7/vJVOO1ShwsuPeu6pRLHyC/HFeYTkxvJ8sBnqm3C2TQ7OgpRrrzohsS8fLe
 aDSpSLda3OSdGt233k3dmvlkGurTdPH+Iq1S+u9ep3ni61olKtJj4dscoWHKwUxF7GyD
 cLqzalRwC49DvN+QFPA9fF5pb527AoRLMSaUQpn7lWyPgRpypV3oh3xJzhh7BH/9S9ne 0A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0yn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISI036113;
        Sun, 17 Jul 2022 02:47:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMZjzX5IYBHev64cyHuMVXs6qpjHyQkeYmu/kyQCUTA4pnksHSsheYT8c1dyQ2gMW+03vePu44bONqtDOEedVFVymA+f6qwdUZmJd7VMKFJeKPjJCPg3wzFRJxDXipBM6DaRazHzknFmcyXz1bMvoDB+kXtVm0IMGY6gEDfSBQ/G3c4bPxr6vKTXMc24hJ/px+EcyeMy94DHXVG/od6DcJDQQNoaZVWbCt/tHHkVpOEG7nIgqdnajZF1h4c4WgriK3Zb/fuFnnq4Sx2ufwlxl2MMGFGdC7uzGCFq83v6LKZXiHX+mazRsMe4dp1mDIruI3cwXx3APMpwIthLm4l3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UA7JQTZ/EY25+xzPCgfxRsv7LOWbOF6vDNGzVSDECso=;
 b=EjSBI+XZcqMAr486unqtygswm3aAZMVhYncwm+b3TjePToNPj41c9e53SXxu7Fbmb2wX8dpV5+wU3N71gf9ynITT1v3R67BSmRPMzCUFB3tintL3QMfz/AL2u/99DxcXJq+mOJx+uITY7SmeKzj8aALrksuMECg5LZw1BZODxK3yHWr+0MQktAzbwQKeeToa60zQlmigRXW40OQyHr0OrLhuFbKRnR7Tvp08qjDlVuyiZ4F7jdq1YxR4awNiKS+Piw5mu13DG9Y06Un1o51K7ny9lwQahqkzXmu5b3sE3OLsfyF7B988Ik5PSRD6TCNxgXqocgxm/FSpPIDqX3EYww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UA7JQTZ/EY25+xzPCgfxRsv7LOWbOF6vDNGzVSDECso=;
 b=pFzuEjQZ/wFvNgFMPZuWO5/TCRog0qyM82kNGEVb/gfVui97rv2h9ZragYZdoYerg6936STJHuZ4qb1gNPki+OZwabKDcTw6cDPQUZ7DAyz7SNDpvaCBM16iFCRXXlSVPDLG2Woqe1e+0q3aFJz6AixDv7VoUXWm9QCrYqb4yO4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:24 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:24 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 35/69] x86: remove vma linked list walks
Thread-Topic: [PATCH v11 35/69] x86: remove vma linked list walks
Thread-Index: AQHYmYd2qqopNrYXgUqXh7uskCWCUA==
Date:   Sun, 17 Jul 2022 02:46:49 +0000
Message-ID: <20220717024615.2106835-36-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7bf512e9-f3c2-4084-21f5-08da679eadbc
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eaq73rHIN7/OG8qdXTT0Xza4Dqqg3BgHx+sAaJ51t2aIN0rMdqfQgmdXDnKIkcibSjNvpvRT6sauJzp7n/Ayvi1TvSI+hGrBoi7Ys2owOwNpnuV2YgaVq7TzJr79zu0n7lszdX/5LsFgHldk0aPmvVvHnEW4FCDAumQ0ki0LrU+45m64Oi+vdqvnEDo9bufiZ9PodU3DtiCmn7I4Vmuy4cuqTAw+BCcYsm5qYAPuw48jtobPBoA9rgx+4/7/EqBxZ2pZ8Gvz2/FpFIAIo2z0HIVc9/Xq54i/UdwkOFvhYS8eqLjKNzfWNrfgWBEebnKvoC0UoRgJenRNjklAvZ8jp1wHsyjVoc/mG7yw1Ux6Q5hfHVHiQDk1uoEEcSgwnGgKCjERi2BlTxBDbEQJiV9F3KYiTUOn5BeUjGePRXTT3JaTG7aOgnKlq5U0TpZEsOYgDPzFAvNq19kFBtM/Ty/nhbPNtJKuve0QEaKwsA3U7PxKIj3QSunfR8q6AgODFlSs/M6Zzn4dNtdoneYWcHlQqK6fp5CT0B2v47lzwP2jOXzdN3O/jNx1tDRDKCCM9Rvw6D7RjLb3TedftL6h1XGO3Ha3xU7OckN6Th1BUTnlaCxdB/ETE8wyPTp648gPnULDF8Te/XDvi+8IpINByuwI73txC4ZEFEoh24UjFYTPioBRRWOWIpgUSvsEkqDZmVlg3K9YjA1y0ZscldcZvJJi8+Yyi6CTFpYIvdyY7hPuy6OOfwqDV6TCZ/Fz47C5J3KHofnLC8cQwRsf2uSaeL9/7EcTOn23Tw15sOR8qELRMDdyfDtwPjKJqmD2RaPF9UA1/4pJk4wYzRKlUidulRJvYF7zSmwM8IbdPQlyVrOG5b7ppzatQjjsUm+fsQPpDRGv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MX2BipS2eqNXkKQmqa89A2T44/NtSTgQu3j4wV0hdB89SfS4DBsbrhzWwh?=
 =?iso-8859-1?Q?gRhy0S0ehx6EeXoR7uwcHv2yQ0x/sCQOXV9ubb5WcgYbxmsDChH3DPRobR?=
 =?iso-8859-1?Q?Rzr1/JMA6y4NSTemLdh7vCmF5+D7ob5sjqCg0q8sppvI941/hlsCitNe8O?=
 =?iso-8859-1?Q?Wr4JDSZWQKtp2BOZubXLAksQsjdxkfQ9koX3saaTDw6bWgUzpyJkZ3L0pK?=
 =?iso-8859-1?Q?S3O1mwDE07wEVKYMhOzoOOthbFvDLBhscxPQ7o8FqGlFoEG2FJfMtB6SRd?=
 =?iso-8859-1?Q?7xeF98Fx9DCfQQwomdcHDBr7FDVohGHCkTKp6BKGR8Flg7OvtK5dBWacpt?=
 =?iso-8859-1?Q?RAt3kgO8a/Etj3bccoPFmLfBqkDYmBhKg3G39QsHEpLt6AxtejVI+Ar3/G?=
 =?iso-8859-1?Q?HHA2LafsZp6xG1BcFv43A0bbqN4GLi2l/zk2upBLkNAhaDy1YYQdA5jPR7?=
 =?iso-8859-1?Q?ppQivuR7BUFeGXVe1P6BWJGMPaa/N0/V9hshufn4BYy3WSagDo4S/Ge7ZW?=
 =?iso-8859-1?Q?QD1p15cVhZe2qDeFaAPIclmys5SGnS5kYDcw0+nPQefZHOb5fJ4FT//lck?=
 =?iso-8859-1?Q?EF4B2VVJg6L8f8Bak5SA2BMI0pe3X9KSneXSFI9cwNfhRP20n1ZbqIR5Kd?=
 =?iso-8859-1?Q?wJSt5O0Yia5HudKRlJY+qTZw02XEngImuTsoOpWS+SbTlNoljW5qSWEFoo?=
 =?iso-8859-1?Q?B2X8QS9c8Ajk8JGhBMfQIlZqlIay71CYrWuUSjksN/n/OB1nbntuUltV74?=
 =?iso-8859-1?Q?+XpDuRvkuOQLXD5Ai25tA1wVQvLr8ZjeDfRZbbMsR8hcakOUpXnfnOi48S?=
 =?iso-8859-1?Q?l6HUPbsKqJ5XsQijklkiSQneaTNI2y5CNRCozTLWQkV+i8165cadCJuWA1?=
 =?iso-8859-1?Q?j5lt2AjN/S++CQ2YsQpk3N9+GnI0tvUFX0df1N89y2BF+syLyAGq6xw2fa?=
 =?iso-8859-1?Q?BGjz8vw57IvApSVOBQJUpGU5A4utgkUySjV07yDUu1GhTB2JUgdplVQQyh?=
 =?iso-8859-1?Q?5yI2MboymPgu962UuBz8vJWQRsoD/0TVdB2my9FP/l/m8Uj75zMd0lMj1B?=
 =?iso-8859-1?Q?554iGyRQQL3uT4hJ1OQHmKgZPQA6jTKhJPgy3n3QAfMi3dkSrbq3xRnz00?=
 =?iso-8859-1?Q?U2A0LsHLxMkX3RRYAzb0QKs2r1i6O5y9mdP1NbWmdGOKf6u9Usfau2qQYn?=
 =?iso-8859-1?Q?dp5AAWdI+IFMWvVqctbie6GqqpMKnxCYMVk4gsuuHnBCnBNLymqoLT5P2C?=
 =?iso-8859-1?Q?oRiWdaiY8z7Qhhx8sMRbg94jkjQlX3CEXplW4RrABbEkvih9RH6eQ9SBwH?=
 =?iso-8859-1?Q?glRTQS1JxVg0o6AhLr5q1/AO9DNku46rSr1zhjeIzKXxwq2jaeryIHzb0h?=
 =?iso-8859-1?Q?DCwNnQGNjzNa2tY+JUq43CgIjC36stzHsEOg39Tr8ULRGzs2veYmODbq6B?=
 =?iso-8859-1?Q?tgFSF3Clt2A1/4Jv5smgEChpKwY0C44NHYQuwUA1yDVXorIYuYQ37+rcAu?=
 =?iso-8859-1?Q?B2gtNQ6aBYbuIjO0uX1UU6QDbLz+S1P7iQ/gURqjZW2ZbVsBVKUPt6zrU9?=
 =?iso-8859-1?Q?nNanFVzG+Nb14m332+7aAFWe82ZOccZQcXvQOiUCxcq+wp800ZpQRZ3Yg8?=
 =?iso-8859-1?Q?2MuwpqZiuJPDV/gSWpaYz7J4ji7uvFIrP7kWKbtjc3cg+ZHJbRK9K9nQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bf512e9-f3c2-4084-21f5-08da679eadbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:49.1776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Etff9emBM+Xw0XDedSkvTRUZAMFKy2bvPYCofNLnNE6+7da0+lXANhKjIkGSK4XeuL2k3jit2h+vybTjXzYBjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: RrJMALQG575cNePNMTh6jZCSW2PDgXGs
X-Proofpoint-ORIG-GUID: RrJMALQG575cNePNMTh6jZCSW2PDgXGs
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

Link: https://lkml.kernel.org/r/20220504011345.662299-20-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-36-Liam.Howlett@orac=
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
 arch/x86/entry/vdso/vma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 1000d457c332..6292b960037b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -127,17 +127,17 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
 #else
@@ -354,6 +354,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,7 +364,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
 			mmap_write_unlock(mm);
--=20
2.35.1
