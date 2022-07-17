Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF70577352
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233351AbiGQCtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbiGQCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD7C1D337
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:32 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMPmK4031700;
        Sun, 17 Jul 2022 02:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SRA/1SZj6DZmRnf4xBZCV+CzOr6m1eQvusd8VlWkgRg=;
 b=Y74IVv5471ZHpDTQyk6hMG/ZZOJjzVQzx5bzU5gb4zbbs9G2Pey1quiGd7YzO6wIFjNe
 gptjO2sPihcZoarMj/7OPF472924EZu1vFVQRA2fNm/3rSAEEPE6qToySnfFVVRDhe/C
 Af2Yy5rL+xZbMbzb4E0Byg1kAQP7V4CBx0XvKQc2o/9bhGdX+15iBEOXUUJpFgyLoKl+
 nUL20EKCnV0MqaSX+aRj4nWvFKoay+aNsVMaBHBcbqAJPGtIfQvR9VG+aRjgDul+Klqe
 cdkQ+wyfdY3+9ssBMAuMPezNjSHWhC6Usq68nwQJgrksv0HqtURHewJKdj2PethItrz5 KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0uf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISG036113;
        Sun, 17 Jul 2022 02:47:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBtfIaesZ76fRoCxgazyftYeDAO+k+psF3heShGqwPmFrv0lldZsWrB4Mac5aROvUmLQXtOqbzfGDMFwjNXJmD/PnJXpGzdQhIa/82PC/1vX5w+DzZ2XShwYlLDarwpxe9VaMLCL8VyklYxDEYxqBaVck+V1HeMMoopRlwkQ3JHlt3vi+0f2J9LS88UpoB4ASQu1cQ5b/PDguBSZFIliekzdBljAkwyo/0WhZIHjiK3DMQXoz4SbVj3iuO3tyh036iCKxr6RKu27x6mi17tJwUehQK8tmMJtkyP2fR6S8HcSwahUQ9vxJynPXR68G5M+hHSIpCJmSAdTutaOMCX/fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRA/1SZj6DZmRnf4xBZCV+CzOr6m1eQvusd8VlWkgRg=;
 b=PVbdwhAhMasx+8m3q904uD7A2G9AYZPSrk9L2eGOXQ/GlNnr5WmBYnvuayAbSo/GUM9wOLPjjbGCILG2sTnyHsUJz6JeZwyTOaLLjgbJZ5mrja+41bsSjYVUX3AsFWN3sM028pitjMkHZ3R55rd6myd3ga9LC3r/OwafWdHZAdZ8LR04QOuIrL5UcH8NbSHM4PNqPaYa5LN3tOpmygIThn/RPiFWzd3C7WeqaL8yhxLd7e3mipaVVtLdSg3Mid2wIKwHuxW4gEE1xWHsugVAmMy8OM4zY9eRh24s28u+yd4zlEsTmUfeGN7AOTEQLn4QBejY/rtXrpx35mkHVo/j1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRA/1SZj6DZmRnf4xBZCV+CzOr6m1eQvusd8VlWkgRg=;
 b=m/8Z/at61uMHCK6W5Fgdrm/UXzbzHQsbxG4XT0dRuEVu/9Q2Lns2xAs8F/ridG3J4jG6rQoKEVjkOhv8n0Iv1L1rfpj5MIGiCknguITSj9gbs0TPyogGyKbxfTzcwi43D7GKJGuYg4RyGnpKmUzyp86AdVN4Z46bDyvUSpBkEKQ=
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
Subject: [PATCH v11 34/69] s390: remove vma linked list walks
Thread-Topic: [PATCH v11 34/69] s390: remove vma linked list walks
Thread-Index: AQHYmYd2/TP9s2+7SEW0wSQ8uXJd+Q==
Date:   Sun, 17 Jul 2022 02:46:48 +0000
Message-ID: <20220717024615.2106835-35-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ec042bb-8007-425d-af22-08da679ead87
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jEbUgRXg1Gjv5oqW7N3zduf6d4Iw6I8T7rZOrIHf+mC9EngocQ3xrwYbJ/ZoFQW0ae5fzBq3k+tAd0Oo3H2GiqcwQL9mqBqY36BisVlOqgtjqrQfNLOPWd+MtJRFoPdWobc/yeE9DBO+oNykwjCp3POwaLuc+Fmsy+w5fVpfjvr1a8MQ4gIsL6IjIc76yl/cf4bvpF70/ASJtn8xBJh5ExK1H0bMFxdH8jx4PTnHUIfHYbmVthXNWL0mzwi+pYLlgudjEdMqJFnOuLtaM3kZ+Ygs5TL14XxpcUGMmvlxHvHt6yAB78nRT5vZGTt1UvqKnwoY/OAIkGkEHa/bB9uwHSFhcs5OtqZPjSyqiRvqTnyzmWu92n7o/cbmTeykCQxJYP+qwvGaXv1yCn6IEDDQBH1Nos5H37B5Fa1twcKdu8V0avdILxotvdfc9LWwCCA9OKGuNuxKLHSQ3OP+f1S4DbWAlKFeUt06iXIV2T43LxwahayTc6zRbEJJvuVu8pKfTjKxW8Et6XrurGiW+/rlCqHX+pcbk6BfLMr7ciihi5wKNwlTrJMmn5kA3WTCXguy2nWRgls90lQHhSTwVjTcEjBHg6ctbIJgnhmqFijvTm7jm8kWZT+KIOSrFbdsqacMBhVg+ud4ZVNvjR/lW7qRILEMZRhCYFNWqZgQneWsNSEudPo1N6JL29z1xFYaBh2Dq9zH88bl3LYXVyG4Gj5nEdc5Ry/0wjzvpJDEQIGk7hqzWSlcIIqRKzo46hHRmRfpKpxiG/C1MkpR4IH+yRAUSo5XdBX4CMCSw8RASTxg1G8gB0CmY8VSxvRTwCzFOskBBAqDt+NBrrqtAwYtavQHA+U3EBovYpq3kBUS8U7tWPxuaIKwttPi2lPsIph5CvLo
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RkcLW1QuOwSM9dtvmIWXR9r7x9/++PTbNY0r+CR9g4qz79h995mUcrD/HG?=
 =?iso-8859-1?Q?Kis+Yugfx434/W/bEB4OBu3EQ+KDNZlHXgj9qe17Vb2bvFBw5u10MFWyuJ?=
 =?iso-8859-1?Q?4j8ZK0QCYpAWS5a61XpJ2Jh3AZPLg9U0W5Uq+UA99GSuEudASCUFa9awEA?=
 =?iso-8859-1?Q?j6+3gBN63fdbraMj4ZSOXaJy6PVfClBVhd8jCURk41co7aoKvvB5hbHHoZ?=
 =?iso-8859-1?Q?9fPEoXIZtIhuUdMM0TpugPYxNux3XPM+vqGc5uaHv/q4AxrBNwotofdAL/?=
 =?iso-8859-1?Q?InSWNc3Af8rpV/Z20LSYqNx4azv6zOM9UvtS68IkeawidvE4Uh8B1Rvjg5?=
 =?iso-8859-1?Q?g9Iz4VXc2B4gA3thztchWgeT5ikKpet4Ttj6uUzW2mdl9lSVJ5oasUAoFV?=
 =?iso-8859-1?Q?wYX7oiA9ol/z1/c/aEr82KARbASwsw0bB9Bl6ZvTMvW249WNJ/pdXAoog8?=
 =?iso-8859-1?Q?2LVahKnXHUHg7wGRWFb4LdSyDxDunZhaNvsbf8tUBvfPCm40+OqPsSLsVw?=
 =?iso-8859-1?Q?LOZxpaBL3mfyUs/8O5ruZxtfCcA6TlgSFIB7ymjZPE0mncR9rxR28Pd0wF?=
 =?iso-8859-1?Q?ixm7lW0mztcxFXwZAij/19z3Y6zCnnSe7NpSmg8nvUEoHAdBFB4fmsbQlX?=
 =?iso-8859-1?Q?+ro89Gal/x/ZQMArt/qmweF/Ns2dsuEJm1y5Q+ebsDWw15qHfY0uqlgLJd?=
 =?iso-8859-1?Q?TKc2+ilrwVz0Rn5mhP8xTUjQHjLilcXLS8iJuF/3P17gviC2xJVp4TMZ5s?=
 =?iso-8859-1?Q?I3+AucXQ1oLb5CSkNPN1OIVdDG5fhJfjtwCmg9hSx5ZA9Ax9bWHunbqYbd?=
 =?iso-8859-1?Q?iQLKkkQZHlfvbbBct/asEJ/bsj3ThdfI4/MknF+TQuNWohFAyg9idWl2zJ?=
 =?iso-8859-1?Q?x+CV8epAlCQ3ly3PPoAaBTjn23P0q5u+5P6vGNnVXjQ+B/9bO9V/d7c9pi?=
 =?iso-8859-1?Q?4tS2QEqkyz6OqISExEXheage4L50AAaIVJtX72D5MLPybJNQMNvc2x8HkU?=
 =?iso-8859-1?Q?C7xfDHc8HKqJjy0Gj6yV6QZX/seLXWmNPCVdQ4SgoCjmsN1Os27c8TyHNL?=
 =?iso-8859-1?Q?q33zWRx8ES+DMytX7dlJVA6CJgcJq4eZngSVSQi83b611ssgtiPxXa77Xb?=
 =?iso-8859-1?Q?iWT4vNbTzwgUHDFv6po2g40YtCtT4WyHdXc612qjojyV4mR06DgrzI1yRP?=
 =?iso-8859-1?Q?QlomjEE9scT0dKgoFOBIpUk70JTUvSFrAw0IoN+oGDMMrLeqey4CmqVuxn?=
 =?iso-8859-1?Q?STqWa281IAZIRqOUiwuuVk5eTCyhYzmdJKCUWYI6PYQIv/LLCAs/6p8QBu?=
 =?iso-8859-1?Q?L8fSHoChcoubsSGR9ziIAzU+QuepP5ZhA1kWuAZ0RsWlt/jl20buKvjNfh?=
 =?iso-8859-1?Q?bYjC44jYDxW81yab6SsocquZvyyGHJTDMIujSaRFdoBinOqExU05oinUpj?=
 =?iso-8859-1?Q?sowJ9zN3IPSYcSn+TsRHg6Jcah6yIxDQa5zDP/7xYgzpP896EqED9jJzrt?=
 =?iso-8859-1?Q?PegbMLoNwidYgn+yPmobMcOWLer03aIZNFkhrQCaAUHbgRafan9YmZ+Gly?=
 =?iso-8859-1?Q?bpb7BSHbBuyhDeMe6Cnrp0Q5MGTKHYjXym6bhcYhD5s/wlvbqu3JwaUr1i?=
 =?iso-8859-1?Q?YAAnA9J7Na3daJ70UDX0Z6NXG8+0jSsQO21BgTGd3T8n1pngR6SWwf3w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ec042bb-8007-425d-af22-08da679ead87
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:48.8808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgdlBPQ57nmxXtUJqmzplUpDsl7u397MiC6d/bVHmrC+y9/UAW3xgfBc6r1mPVLV+WeioG7UYsZHvWSaghhBFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: sdXh-vA_X72kg_-3LTSkaud20sJ78klC
X-Proofpoint-ORIG-GUID: sdXh-vA_X72kg_-3LTSkaud20sJ78klC
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

Link: https://lkml.kernel.org/r/20220504011345.662299-19-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-35-Liam.Howlett@orac=
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
 arch/s390/kernel/vdso.c | 3 ++-
 arch/s390/mm/gmap.c     | 6 ++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 5075cde77b29..535099f2736d 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -69,10 +69,11 @@ static struct page *find_timens_vvar_page(struct vm_are=
a_struct *vma)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (!vma_is_special_mapping(vma, &vvar_mapping))
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index b8ae4a4aa2ba..6e24f337eac0 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2515,8 +2515,9 @@ static const struct mm_walk_ops thp_split_walk_ops =
=3D {
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma !=3D NULL; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		vma->vm_flags &=3D ~VM_HUGEPAGE;
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &thp_split_walk_ops, NULL);
@@ -2584,8 +2585,9 @@ int gmap_mark_unmergeable(void)
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	int ret;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		ret =3D ksm_madvise(vma, vma->vm_start, vma->vm_end,
 				  MADV_UNMERGEABLE, &vma->vm_flags);
 		if (ret)
--=20
2.35.1
