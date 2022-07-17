Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C907A57734C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiGQCth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbiGQCss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:48:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E2F1CFEA
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:31 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8ghq031747;
        Sun, 17 Jul 2022 02:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oO56keZ1Mx8xMory8Av9vRhd5+/xnxyR+fmrkM7W8S0=;
 b=iQZqdoHxKM8eJi8rdWbVzxB+NrF4WGJEHyZx+7pnvNCq2ZjvZJfWUJQrsSZ8Y63uDmFc
 ho1YPmFwNyWvJJGeRDIj69R/mUAP7T/E+s1kvt0bGccXKw2M9x+4T7f95z58aDUNlTdZ
 OFw/3Fl5u9a5WQ39FPzlqekWtytq8ecHgZw85idLo6GIqLGJ96stE4OglytiEdgOrqtS
 VHo9RDHkPcs8tKVymnCjm89zq82RIXDi6Pw6in8628RJVrnKXD4avSi2RTwWTKODvCOd
 MaylgeT0YGgj7MeSfkKSEhZXDRqTCZtmMQTinwwdTVv/aS3L3tdc0wQiausN7G/ADU12 Dw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbm428y7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:26 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISC036113;
        Sun, 17 Jul 2022 02:47:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ft7HX/1hDtSQ34xpfMrJOu/jMbZgX56kSK0XUtyVEG0ShK2Ln/g/IsUwdM3l94eZg2MVHGaxdJhIuTm5+KoNCd1ovlJgQUYhoZStzj/QSWcYP/S9kvJp0M5iS64N0upz+ucIDDOMJm8HlxiR+NKWleGw3Cra99cvjRu0GuodkMYfC5oG0zVGZwy+ubsLT1OItu2nVa38pOR/LsCNf6gnu59Pjf4xrVdoe5T81PW1l3KmcnoLoDBUrtjSKIU9qlxBzFvIedEMnKt+0WqApfRJtsJ44zeOAWC4Rhi2hUt1YuD1ccfqM/dPe5paAVnJioBt4x58QrM+PEoRZaNl5OypZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oO56keZ1Mx8xMory8Av9vRhd5+/xnxyR+fmrkM7W8S0=;
 b=P+ugtVRpY7QgeU9wESrru8AaWP9OeEbj67tfXDnOe83gR1STlXD0NKeGdqn7jNJLtpbCCgtZq32THxNSCMsmeHyEsAEAqJyMjI1It+sju/FtJV1LuLDRD86tasOTVlksyv77395n05k/gHOR1ljVRvHb8VWvFZbx5jDGfBnNhaMKYgGMcPP3H1Tub+dMXoroMOllE93Bun6Z7y8umRZ5Y3HtIifcIkm2JD5Q8VFS4zxa+/IS3NCpnpPos9jziFYVN3T7ptiM/4MfVQNbU3I7cs0dEqmBWF7KcxQO9L+4T3wqfo9hCUGlSxyzls4HCz19fX5xFh6Z3W1ruY4pIQyGxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oO56keZ1Mx8xMory8Av9vRhd5+/xnxyR+fmrkM7W8S0=;
 b=MbrnvPPKFvBmVC71QJQ34+xqXuqKNhpypaQ+B1Qx2GTIe2HYMw47ioEd9Cj2pwjI2vRRLnSWye9Op5e63s5aZc3M+83jmn2/7FrJDYn8VMKC9vHEOLa6xKgTXXCEOxQ9u2hsfE1lENSXKpjqBUViJu9dZ4ZkJK8PDGmRioA10DE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 30/69] arm64: remove mmap linked list from vdso
Thread-Topic: [PATCH v11 30/69] arm64: remove mmap linked list from vdso
Thread-Index: AQHYmYd1XVGRaMZxBU6G7+CNGrp23Q==
Date:   Sun, 17 Jul 2022 02:46:47 +0000
Message-ID: <20220717024615.2106835-31-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 238d933c-5d46-4d93-bae2-08da679eaccd
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OAgIsjZQvjkC+STMn5F4n59hyOAksQQ9PZHawI4hJxakDCexWG8icufdT0cFIGlFQla98qNR9Ml+4XQhuNlYM7+QGdgdQIf19g3P1l9yRtRji1ZMsWPXkHja3saon6+BszPH8pgTR9fXaiZHXHJJQLhUHWMd+VPIs9CzOKt+gxvYa6UoBiSHqr4M9zbfPqTf1XdnVUa47O6BrH96l1c/saHkYZdP0/Efa0gDurFeN8/1NTxYrVg+2OWF/qhb+KNs/AJkcjyfaRzb7LsH+naJ93X4BIQO4qVmTupAUNikPjaFxZLiKRu68Qd0HaW7PKP4TI0zVcs1Q2yuWhg1pim/uDwqlLuplXgID6kdpktpqrzlzYTJpzfMMAgC7qc88afG80tXGpwNZMRw/WGRaDhDV9QorYLB6e6BL/M9DDYZdvlWDsNjF/RJ8qxXfPA/TPv/qxfelU2NIveEmGnMawvFA0XmlmmYdq7H52uD6Cci9vDcp6vrJSyuNcqBqtFHKqQXY4p9SvWPedaYsgDqc1W9LcPhzjLnI9tDWEWcmTX871WX3Q/GvT+CiuOxSCQWV9gl2LwJbqqePGFCI313r269zmOJJro7gG8NP7C8AETvgDK4yMUmIxoX6L6hrEeCrlu+DA/GFlv3oDq7w17F38YEj44hI3CPaNQck6ql+qLflxKvW3EC6DaRdE6JoKgPIg5uR2JzQRXJO5V2Gcu3PFs9oKyvmlyoCjD0I8hRMAaatd+Kv4Jp4kv/c6Ws8yOssTkEoAph78xLZlgs51JTziSTdlAfOfoD/AR1Dc6vEWWKiL+NxTY6Nf/2oeMu4fSCJXXtbPwdMO5ZhM8+9oVYNcjnpi3GHh6p0gtx+CoCIGuKacmvpJKpYCNBPZ3mrPJckwNE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?cDTpxy31NpFcOuqbYp2crkXo+lvlF7fLjVYxh9DfdRRR+NgH/6vZBmeSbT?=
 =?iso-8859-1?Q?oroLE4NUb92nNaHMI9uD2r0QZTEq4DVJgVscgH5k+P5zNclTU2EB/l0fQ1?=
 =?iso-8859-1?Q?qlVxlmhEOSsAiuxAn5VYflBFwxcp2AGDAaXm145JS6V3nJOjjCci2n7meO?=
 =?iso-8859-1?Q?Cc6US14+ey3u+0jM8f/ZPvsLbGuahtsWGgVCaCrDieJHYIMcf78PUN4rOZ?=
 =?iso-8859-1?Q?lsPfruC5crQJBjECSpS48dx+HJXZMIa1+dT1B4sjRGNz0RO3qzGALdJP8Z?=
 =?iso-8859-1?Q?axL0d40FsHE7DGoq+eq7aZiCaol5bemJI2kEAnrU2tslwDEpEx/KHHbU/t?=
 =?iso-8859-1?Q?ItxAqZAmuT1ln6XQCo/rlyks3vxProWDbJbXGx95QsaU2JJowogjaJDfc3?=
 =?iso-8859-1?Q?cKEfv2UDJA958vPDFfOuphhD1mEkV/cQ+EidKMmKPGePn7TuyLt2bux9kW?=
 =?iso-8859-1?Q?sBrz+d0+RYRoIC9TIvjX5zE9dkoH3BzgmVtLg0PGLTIxFXTbMdp30AB7aA?=
 =?iso-8859-1?Q?m/xrHD6mm4K6EdczgD53vQOT9sRUFWMz/G5oRA/8QMBoqhWa5kvMU3xj44?=
 =?iso-8859-1?Q?HLb/y7SQeT0srXHxKtMbTGj2PkvZDgc7e47QXleKJWSwy7n4xAPd+1hydq?=
 =?iso-8859-1?Q?Hxg6bIWjs0yEmXP8Qlhl09bHKOcQm+ApSc0GLNggL3R4jQGwclsqP1+R8W?=
 =?iso-8859-1?Q?/ngkT/73OxIl6JamJ9qh3rDk++xyra5NFYwIZmICcrFyNGG/9Y6PacZrSF?=
 =?iso-8859-1?Q?aqjAPwnVPbVGIYcRhZY9oK+zB4WdUlNp64XOqRm7/4eHebnwuYOR4BdSVU?=
 =?iso-8859-1?Q?K15cOTFZ6bWsJ30eIhFB0el6MG1HA6Il2dLsZIQSSAh4ELf6DJ1azg0Dgv?=
 =?iso-8859-1?Q?Wxk9LANyCQ6lzt7OY9uv6UrvrGapDrRcZ6XkfmmqBdKNffcr/pSI3k+AmX?=
 =?iso-8859-1?Q?4ODZEJoPKdYwT8KN/DVewPTsJRAJWSroHRrFK+xQbUHoOcg+346FUvsc67?=
 =?iso-8859-1?Q?RE1Llfu9JrZDkIBhiq+fimR5PQLAZuqVqWYyl2dXpbhjAqvpRToLssL7So?=
 =?iso-8859-1?Q?kHWZzHfDU0cOTZ11RN2F3cx5Tgb6p5CvzgD1MxJaKSQ+D7xv6zflTETKyn?=
 =?iso-8859-1?Q?ZAVqSR37Rk0WvmYoRKm492kQxNzK0bda6m8gmmSulopprtMTxFAiIOFxs3?=
 =?iso-8859-1?Q?iV09WCdeHoxYOC6cMQhnv9YnuMK36j9TBicddCl9LNDSK754t8n9LC69FV?=
 =?iso-8859-1?Q?TIQrbMK1WQEk45//JtEb3pEZof582bNNSXILWluqrMohlMlbwks5ajhCe6?=
 =?iso-8859-1?Q?+sWvSrCKMA5Sio56l6DjUBMtSLGPCZP9eQBlR1t8wodYd6j6afYRuxNdmM?=
 =?iso-8859-1?Q?T+4MCdIZfeNAc+yKPjMVdZBKGjOC3KdC7wwGlFOBMrJ3DQ2Q6OXnqQBAgD?=
 =?iso-8859-1?Q?djl5qOlvX8lCAvqK4kZ7G4nVGnCq00ebT0X7uDwQE7l2OgFa1rP+avJUpg?=
 =?iso-8859-1?Q?fWAmKxpLsURykRkb5Lx5/YZrFPcALffsVlLBdbBNLMNKgVfqSqhemiid8g?=
 =?iso-8859-1?Q?ZfS5u+mkI4S5dwvyNaXalSHhTuYjBICT7OVo99ZhZSqqSCg0c0MWm5N3yb?=
 =?iso-8859-1?Q?v1KJp72Zu7UlsCAkQrB6pzvcQPOEo6/iKWD0mQYNuwFvxtzjSrrAYBJw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238d933c-5d46-4d93-bae2-08da679eaccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:47.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9F4DX2eNPAqrDQ7WMlufAiPclHN/lKFGNa7dRkoSLR4MrXsGi8RmHo7TD9klfg7rdttNdxtxpL3OgSak5NfSzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: BR9RSwBmRpYDY5PsLUgcr5WT92Jf2if1
X-Proofpoint-GUID: BR9RSwBmRpYDY5PsLUgcr5WT92Jf2if1
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

Link: https://lkml.kernel.org/r/20220504011345.662299-15-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-31-Liam.Howlett@orac=
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
