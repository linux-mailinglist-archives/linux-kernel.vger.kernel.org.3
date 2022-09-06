Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82835AF50F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiIFTyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiIFTwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE59857D4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9Ke014060;
        Tue, 6 Sep 2022 19:50:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=BDRb2xJBiKRjubqVNDS3BBo6JIFYlEZXCh06Gkb2hqI=;
 b=cCgFWYkPdCbbLJD5YSMfSah8ToHSrGy5ceznPxiWxFNikgsO2KCvpjjWiL2OoNTSKB4x
 XaYP9X7DN6ELpDyGiYCWtNl/imqGWT/uleNPuyT7/qSx/EU0z5FnSilA085CiZCaqxSx
 l1MhToFyfppwWr2HpbUW4HyrGWDnsDiYYRa5EcNIEEavwpQgVkrwRp6COYhGT5X4ao2L
 ESkyHVC9I151y5msLazLfUQh2yq49ncuWAZuQloAfRRDeKrcOh60M5kfTAiD42cPAdyU
 W5npGoSLzgv2k2J2hP97IFpLyTy/IoLJZQsxmgUaH1rMdHYiL/wVD3huZ6mr3pOq0VKg XQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eyq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:23 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H2KIk031383;
        Tue, 6 Sep 2022 19:50:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ajns-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMj+LdGzk3rkTsvVMx2zXLN2Uv3UmmCSYqFBYJXFx2lK0GEJOwC7D0bVsYm6rxGJR7obvHVbF08AqRkZSZhPR9zk/zSejc/wRCRD/kl13wmIYRKmO6GsglwT2Pn5op24D0Zb1ZICuU7STrCI0y+L/xXoA8Q6FTGzfLGtmN9c8uW6YJ+Q7MfapLPVrNqr/mHfnljRZJyvCsz82KarDjTspPT568EHZTUChpg9jwbQXQqYwsL47SdFGL8G/8GamNBvjTWR9TOp5pCUz2ho2TLKVQwQlOwmcImIr1YWhiWQSfX1YX0rLu7FeOqXRZPlt8+lkbJh1d3gfJcS8cfg8k1KXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BDRb2xJBiKRjubqVNDS3BBo6JIFYlEZXCh06Gkb2hqI=;
 b=Tj/Os55t6BBhmzrAOgCyV8o5iwwAijwdV0ko/gtH1yxMW0BrRY9IFgSumKeSizqMooXbhxuMmwD3qJ+RnyK0tcrYv0HASy3knTSNkWjFZ9N7ODlX7HLbmhlNjcrBhTXEDsvMEJP6ha4iBaZVGtB0FYHPQcyrb/r/9cG99xpbU2V+IYTYXUq93lzQ8X60rAzPfZpnAkoGuSivexXz5PtjnfBF4IoIa6NyXv0hKyMYbQl3KCI7CEMR0oyqmeJAXbZP6KFpKm0YEpykCDrSVvIM1HvURVPa32qUiyoc6Mg8TDwDbrEtFKvyiLcfFaib68Xa0wPd79i++CLjXVUj40Sl8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BDRb2xJBiKRjubqVNDS3BBo6JIFYlEZXCh06Gkb2hqI=;
 b=snSKSE5AqlMJwQ71nj/hNRbykDy/K9n2lHnRP+Wnls2l9XdUD6wq36TNPEF2m8M1vDya0qN3f41yOQkKaJ1QPSFCM5j+f/9fHvtBx/HE3yaFwzOz9XE3/JwgF6RBNZ/u5xP2LQSXog8Kx9pbdWFIScyZh7CutA1fB/RzLzkWMDo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:50:20 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:20 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 61/70] mm/oom_kill: use vma iterators instead of vma
 linked list
Thread-Topic: [PATCH v14 61/70] mm/oom_kill: use vma iterators instead of vma
 linked list
Thread-Index: AQHYwim3MerNwbaMskeb/bUEsoWh5g==
Date:   Tue, 6 Sep 2022 19:49:03 +0000
Message-ID: <20220906194824.2110408-62-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db3bb110-4a01-4d1f-7930-08da904107e5
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GEwVhTpQ6jpFMRJlMe4zoMxw9jDNhrSg6AIZ5RR1oLbwoGGAm/xcA3atInVGAdL+lLaODs+G9r21aHLzTPWa4sb82X3GkCT7ZhN0BPFgDdgVVhcpHvBFizxJiMUF61k3mWYwP7vrVGrc6v/2dsKOSq5j14ctU0JJuv5CsrQpA8qizScWNj+6QdrMKhwBYRhUB/VUnsTBrbwbr2GnSFy4ScuX0Rc1XEE76K00ofivtVfFGmN7mLSX1YBTh/8qAe3vvmK1ZY3gAjaPTT1f0bzVTkCGJq63ee+tIoEGbCD1J/Gpo1qqDgdo+Ehx+npRkMV8766XSPdkSXIhIPFfbtabEuS/UGLSCgj/oJBha8pJmiHthIzstDqHndyTj9ZCn1c9QFpBPBPfYNztDBnLJWWHxNuMzCocVkxeBsgb0HEMn6gWCbd7jGe1c3swgqTsCmDAgQQGRVdLMNIstbgtspMgHJVr42N1WDcUpUCUFM+M4xQ5YIDx4VYxFmH75cbzVmQGl/86FX7R0TWLuedMc9QyIfDO0dlC10R5kieiQRLtXTEf01IsN2SGExEBkk2nVSRnTuHLF1usNy2i6B/h4SiQ8QX+iREA3dTpu1B2x/JuLb82Uc+SiDQoPzHAlFT6hL8hstDbEncYXcllNZl7xLcp1q+fUpeGS+zMKb+VazfJ1R8seNVyzUNt3Wj4GR2qstFFyLlp5W1qtUE8L8iuHOi0gWNcce8sRk+C54CcwULoVXo25FbtI61qnP8FvaosD0SONQ1GO1cJjr6/m/5102Qs0Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(4744005)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PAqaV4Geeqaw8YHDjVic1mDhJyVTTaZwokRUKuuSmqsRbJfKxDv4nLclNl?=
 =?iso-8859-1?Q?uvPTiwlWlBV+8mKiRTlOo1Fu3ZxamKBO6hA2rgcLAcekPO6Po9+Uh5N8bo?=
 =?iso-8859-1?Q?Y8neaZ5m2dGc3XkI0fFtWLTi/NUxobVrGLT+WmajIEpUZv8arQnm4mhxqP?=
 =?iso-8859-1?Q?pUSZKFmbF9OjEOFSf9XytyT9GtZXQD3KhYDNrcYLaCVfrHTxOkbBo8p0Cv?=
 =?iso-8859-1?Q?nsB2lYKJZZAcfjEVzoN6Tc/3p6YAYY1FPjlciGeRd1kXo0D5KPzausU2yt?=
 =?iso-8859-1?Q?maDMY56s35YLPyeKEGCcgXorLeoyW8szJx7Nos5ZCz+gUQ7uLEeCYEUMEG?=
 =?iso-8859-1?Q?6cd2avYBsqW3S7vl7ignEv3Wf9g9k++ZN9ctwGz0obQxDpuJMvigUdDeAH?=
 =?iso-8859-1?Q?64apIFWmp+mGnE/Da0BaHTrLnpkDHh1WIWhRko/VJW50XzJmoz/o/lm6iU?=
 =?iso-8859-1?Q?29IZnoqjm++5q+rNWu+cInNZHpCQFIFOZYzdQzkNZ75emN+OaB/LgR8f1e?=
 =?iso-8859-1?Q?PACW9+Nsfcx87tp0gJOHnkYDkppWBpEbFwn6trMz3tWprOoxQuJhVA6Eo1?=
 =?iso-8859-1?Q?6MY5AnBjWxCnhja02hNRWUCIvXU1/DlfB7ic/EoqXLYVp8KRgghKAkIC03?=
 =?iso-8859-1?Q?b89hV/fgTCsEw/ZBndEyTYsy+Vtppf0Q8pj+HWMbtb/+tKNMI1lpWPW+3m?=
 =?iso-8859-1?Q?yy5xUXltTiVaV4/o0WJoqPzqZV7F1ms1u2PzRzLQl1149AQSaB8vpkg1hn?=
 =?iso-8859-1?Q?jnIZ0UF4IMPGFqeSQrKCDjT8uR5aQxdWmqg3CkdTwQnNGzj2iK+gHfGm/E?=
 =?iso-8859-1?Q?fp5fcJ6Hh9mdkZDCHJKTSooCVtzWU1PuAvW2ijMPvB2nPdU1CZkZZWsX71?=
 =?iso-8859-1?Q?3v44LwA/TujzhZc24L4PSoHcOJCO+HT4jq2WYMaDJ2xdsI7z7x7sKCPSI9?=
 =?iso-8859-1?Q?QBO8OPCjLBGvU0mA9IlwoidOdxtaF0ecw2HXX/k1nHj3x5gbtKrp8rujh0?=
 =?iso-8859-1?Q?+su7FwGl8suak9QMzTMaCQKZqRTGXryBar8M5Ty8YhA0qDrJqohbGfP56u?=
 =?iso-8859-1?Q?gecl5UFBKNpRmvJVPK1TRQIOIlYDKcefbtXsneV6nnvVkhx9WLsTIOn5DE?=
 =?iso-8859-1?Q?uVdejanrnmxNEMduEGnotd9XybJuDMjxczsMW7FWO7hljLW5sxjThTliDm?=
 =?iso-8859-1?Q?XkCHjWpkh9364dTSYnRNT1FfnYnQ2zhlaHtiYyV2GcfiunKB9L0RgxKfjL?=
 =?iso-8859-1?Q?tQbkBs5peURjpDOlwvvMHszCMmuC9Ihg5ljpQvWtq8bEryRf9V60+gMEZF?=
 =?iso-8859-1?Q?q6OX1gaawiT1oaWC69We3986vkcTUnLo9fpjU/nKlKmk+aVbzVruWEWmiW?=
 =?iso-8859-1?Q?/Tm0WJH1ezt+q5r8gUApoxt9L+2TKC3n2zX497XXHmb8R5paVZkvvSkN8W?=
 =?iso-8859-1?Q?mc7jiQiNYFMcAY558Ft/RlKGmM9Rwdxdt00+9raH74Epr2Hzed6gXL3i7n?=
 =?iso-8859-1?Q?Sm5V3I2Rp5A1jTrnUDq2xHDEP4zz/IQ/XsFw79yN0QbPnhfGeZaHuDY++n?=
 =?iso-8859-1?Q?JZnCQ6GjA/sMN6tyFxFOy3ia4WQl2vnpROQ5G0NsqKr7uaj2YUscaqaJH7?=
 =?iso-8859-1?Q?gstxB7SM5vgQcEGrGkhiufYiJnquE1NDTz/CxNbW7CUIi/0cBv5ITxfw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3bb110-4a01-4d1f-7930-08da904107e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:03.8807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yg7RnwP5+0FKvWWcztbsxwY8puZFTJ64gculb8mQIrPq/KVy7yBLsY3bTU+/buNAVJGv/lJfGOfA5knZMHYMDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: dL6t3-Kvgp8-atxZLvndNoYKekXSHKn5
X-Proofpoint-ORIG-GUID: dL6t3-Kvgp8-atxZLvndNoYKekXSHKn5
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

Use vma iterator in preparation of removing the linked list.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index c08cffbca0d9..6811aa48a98c 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -513,6 +513,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -522,7 +523,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
=20
--=20
2.35.1
