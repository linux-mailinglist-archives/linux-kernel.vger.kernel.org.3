Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4F057ADEC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbiGTCXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240756AbiGTCW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:22:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3B06F7C9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:19:12 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0mq6f017914;
        Wed, 20 Jul 2022 02:18:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oBGOn2+rRH/THsbd/cZjknoeJP1q+qBnIiBF+da3EBo=;
 b=txxRVdmmUipnOl5B48YIISuD/yJq4ajrbMM48+VVCbFRRNE0wV5juWP5SJwBC0IbQyOp
 o9ZsRAgKNfTBaFOX3Mcc9UXqZLhWZnJILtvGeNBk6owXZjkBn1JcUcArAeeOYjwGTfzj
 CQGFriBjNAHxOeQsooKGCxdTPJvTwCG7kHb7wXR2fxAVGfgKSDDEeyeQXjZnAl8HZvsW
 cYisKZeSU0jQqSC9+EO8jYPU+bSBHdFfWrOdpIWEbvtrEqr+fjN/xmctN73m5vNXbcJu
 CdV+l9YV4kts0Shcz17VGReuGLXNK+aLLX2FFSWLgT2fLU7/qHOQaBERG16ehMh6F8hS 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx107u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:40 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1QlMj039258;
        Wed, 20 Jul 2022 02:18:40 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k59311-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvdnYt/h2lTj3tPlxSozCvwLSDPJy1/ToRMcAar6Qq2cfgF659XngJ/OkijRuFdsLpYXJLlUnv+t1hIeDWNeueJjKY2Pmv8hEzvubpuvdzCeyUyWZQoXh4jSlA2K+Pr4hpbjH0+MdI3bcm6QUmBH4JBrx5M1KC1ltJIRoRN68kbNsYd56Pw0UYwCMMbkGCkF0vjNPcXYZx6C40XyCyGQcX3RoIGO6GcUNjdykV54xF2ZHy5W98/W6ui21H/vFtkajclZuKeRkS7l3FRYnfFtdTzjfOGMCqLitcEzd5/pUM0vmMLcbzpVfAvLy2adykleDz70lz+VrDHzburcXZWdXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBGOn2+rRH/THsbd/cZjknoeJP1q+qBnIiBF+da3EBo=;
 b=E35zi6nYZxWB8AbOMcJq93jlEF55sJKU+tf9G4TsNqwWjHQI9xfOpKIAlyDZGJ84d95SQ57SCoj5VtyU5mU00GJRtyUtgggsRbOnNxPwSe0QfHg3NHHmG/kyqN7nnlx5N+haLNhfAksFVWPAr9LmMM1jpiemlj7n+Ttv5+yEjjgfoMNlWOaukvitSHRVKbORLHXU4cs6Sy2ZeThAv/GV+q6o1vnC0ThKRcTJfrV5DWPpqfa1ws1WL9Xus+28DPfx/sqBYDF1VAwENgaFfC7q4sUq8o4t0ZdyepNrmUi1PlXjAXTSsS1ipw7TnNIws42+iPa29wVzpYiQR0idyHY+9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBGOn2+rRH/THsbd/cZjknoeJP1q+qBnIiBF+da3EBo=;
 b=YGLE9GZoFws0iWpNiocUSq0V24g5X98l/8RPn6yQoOye0oAVm+gjDlHvZ0Ey6JGZHzkudBZecbOAu9x+wSM3TdsgFs8764LshS8jHXpGShxk3Y3zTcSg7L1vaQGSdDSZlN95aFlvWLEE5xGkuEGMdYLNpTdabZzeo1z8wLzYx3M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB3797.namprd10.prod.outlook.com (2603:10b6:610:6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Wed, 20 Jul
 2022 02:18:38 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:38 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 48/69] sched: use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v12 48/69] sched: use maple tree iterator to walk VMAs
Thread-Index: AQHYm97uEDJDG0A1AUmrnukzZag3Vw==
Date:   Wed, 20 Jul 2022 02:17:59 +0000
Message-ID: <20220720021727.17018-49-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 980cf325-fa78-4126-72dc-08da69f627fe
x-ms-traffictypediagnostic: CH2PR10MB3797:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +Gm68ArUyAX/rJuIxmYjnulEuYzFnIzf0sGAYefRl1zkbbqEHGTA9jzkXdV0xjYglAKEj1dHx26lbL3kGdaPpRdo6NzFaBZ4dOdPWbv5NANL3puoSOFn9W7M/ORzhGYmN9etC2noFsNt9G8x0QTmALlzCuUHYE6q1Lf2fQcvCTpua73Ib4XLKj55ubMYy2tawoaZXuU5MAzJtxFssRDiF4uFxctdfI6cRhoYu/5Uystv24+fpTSJ4+uKuP/glfRXcd8T8C25qL+qWp4ysTNIdzCOTgza2vwtMXzshJDbqTaCOcAh7Bn8MgGjYEc0TeMVeL0DdXUymTcjbVFkmi+itjL8UZU02WNZ9spdFVBID2PKGD/V63+Wd0xNPukrmzGjvJB2DYCvCc+oOwUdMfZrCaTl3BCQou5SLoHEsRv1eUibi/ijRpcoMWdTQ5zz8dyxrr1ovNrfrZfjfZC/kvIp+DWrGmgCG/yzGzO1koFAoyEu/26NXUCQiEWwozxeE5EVBvTVrBtqcWawF36+Oj073pwxwvt6KtBdhlq0E6LPpEAb0WxE/jcrY4sl3bQULQO0q/DIpVuX8MUu/7nbY7tG5nz2X3ALk4TQiXmGTOHlvq9Cw8j6IK+bTGGJud48+GDQE3sYKbPQ2bCiUMGSbJsbHVKyEZ/G0CKSHlRBaOxmPHa3plwMzjxjexjscuIDCfg6c5z6N0E4YPJjoBPu+wWVtGI2wqXjSRsGDNOX7FNE5yAptMQ1e3EN9SUE/bpVZaczoy6iJewOoKz+VMEV1uQ441wogOK6RIix6LqGeH4qVEjnW+Epkr3Aa2g8QLy3ozqRrL1z4uCsUAcjzaN5dyeL69k/KeReDge/0CgxIEpKqpgbWkIP6Vy8Dr2PvSAoMT43
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(376002)(346002)(39860400002)(91956017)(38070700005)(316002)(122000001)(83380400001)(64756008)(66476007)(71200400001)(66556008)(66946007)(76116006)(38100700002)(36756003)(110136005)(8676002)(66446008)(4326008)(6666004)(5660300002)(26005)(6512007)(8936002)(966005)(478600001)(6486002)(44832011)(2906002)(6506007)(41300700001)(2616005)(86362001)(1076003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PEeaDMYN+f8nDW7yIoWRbg+FefrJrXFvxWHoPhZcW11yoMlYbXr5wNeUlZ?=
 =?iso-8859-1?Q?pgaS4Zb+v7U8TkWeVQvRuS6xU09VIXh2+BslnJ5Y4XBS6dmqaF1steqSC9?=
 =?iso-8859-1?Q?GP30zCksaISZiAaxwSzsUrl1m5Pq1D/FoTMpSJOot6aA964eeqbzXajNaB?=
 =?iso-8859-1?Q?umDtPQcLA17R06CelEKRt7BBKeCULTkSuCS+3zJjpEI5fngeJ8vDsfJyMi?=
 =?iso-8859-1?Q?eEbQoysLxqDIhLDewJRUg6hckKi+GqSXfWgGHqrGpMU/sIlCjEnZ5Q89vM?=
 =?iso-8859-1?Q?6M8g/tEUCMdME7h0jp9Uu//eUwbq+k6OXfV7tjMP6RsMKfXsFzPYiRv5vm?=
 =?iso-8859-1?Q?Gn32yFpQfh9bL7DLCtTy00yX3menMQIy6mGz5O3gjjQrVPyhQABgFI9CN2?=
 =?iso-8859-1?Q?pOtOqTlmVJtqlwCMwCunwOMjNos7/BtYAlOUE314Gli9UjFRTo0zVW/mmX?=
 =?iso-8859-1?Q?SJ3ceDfvqxgj10kwdG4QBHkOUaCTRrp+zNivxm/Byps03xs5fhqDzgkmvj?=
 =?iso-8859-1?Q?U72XVrxK1beTb7F9w7F8ReZHFkXv9ZVByx2qtdBy0DkGOG2LxiamhJI/jx?=
 =?iso-8859-1?Q?pESTL89EZVtYe6IGi3lQHyixXfe22Scm+KDCzJ9+OLGfiR0se6PvlOY1xX?=
 =?iso-8859-1?Q?b5tzGENd5YFbVtYTg/64xmO/F9ECpte5tDDxeG2gvK2mNtrhl6MhoNZnm2?=
 =?iso-8859-1?Q?kv0YJdrcjRlONrQlvt0YtW6z4+R461L9ABWZ65VesNNuliBPcJiV6nfT/0?=
 =?iso-8859-1?Q?zSuJJnVT5mU32rcqwqzA4bPTEFrJJ67pjcDwIjmXNsB4XMmOACtquGav6I?=
 =?iso-8859-1?Q?DgXY1lUxBREXQ7doWOD1IHG8QKvulj7wPqqcUl+EOj/Dgx4bpsrQ/y6fu/?=
 =?iso-8859-1?Q?+ZEI5Z5iFmlV2w9NoI4wjmZadxaCkF7viz+8fwLdyiAyCMClaTFGlJXxWq?=
 =?iso-8859-1?Q?wwpRmNUvNS8cDLqV8GPeOoHHmcLt/q+ESUd8NFQiTD5R+eKTQ3wi9TxCRF?=
 =?iso-8859-1?Q?xGNu5pzKfhEQjW/yj9xQWlqZld7/F5c6awKhcpdW0m7ADpZ0/ctxyinREy?=
 =?iso-8859-1?Q?oAyDyy+YSXCBYaa+4nCWuYz7GEBp0vCIT/kUg/sMIln4FV6Dbs92UYhXp2?=
 =?iso-8859-1?Q?rgW/P7HDP7em6Mz2V77t3bPkh1UDwf3jgE/Ql98LgjanTgE6x7iKSYKjeY?=
 =?iso-8859-1?Q?L68iHnCMTyZ/xiETX6WvgXgf5Wk99AZaF44Jcg477BM5j2k4k4kUWAsrku?=
 =?iso-8859-1?Q?RHbcsEiC9GKdliDgi/SmsPMQS+JFAltRafmryyYsTsipjmFcXRSZ2zoLXe?=
 =?iso-8859-1?Q?gVql8J98gKeDBqwQb4grvO3sTMr+zz8SafywUeBM9bYqwXbAcGFr2LBb7k?=
 =?iso-8859-1?Q?CspkW8rPF6ZjO3a07xak4iZWwZOYlSUPlWPbB/qUPsR4lf/OobyLuDSqif?=
 =?iso-8859-1?Q?BRXJq0VWc3Y2lwQF3CD9NdCrt7YPed51iEqV4tZPqKmU7qXK/vf8CxeCz3?=
 =?iso-8859-1?Q?SGJvKKdWUsSh6CHFDSzKiaPC6+mx0bK/w/W2YjRya34o+VZ2QRvwVQcu9n?=
 =?iso-8859-1?Q?ko1B6vLxBO04mQ6kfNINGU96Qg+buYh7qy9Trph2buT449WseG4etHf7DV?=
 =?iso-8859-1?Q?unMNufX5tGmqixHrbOQbwa4TY/rU/nOWwDPhhwE3g97+zKShkTSmAYfA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980cf325-fa78-4126-72dc-08da69f627fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:59.1490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohmgHJG+iQ5GzNsh31LsZlPDULiwMcc1c9EgBoNekS8yaJ3rH1a7w8eqS2td+MZqu9IqeoL6rY0dva5ThLjKfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3797
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207200008
X-Proofpoint-GUID: FRUG40C6IpOY1bkOXURtAUiKGMkbahp8
X-Proofpoint-ORIG-GUID: FRUG40C6IpOY1bkOXURtAUiKGMkbahp8
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

The linked list is slower than walking the VMAs using the maple tree.  We
can't use the VMA iterator here because it doesn't support moving to an
earlier position.

Link: https://lkml.kernel.org/r/20220504011345.662299-33-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-49-Liam.Howlett@orac=
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
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 77b2048a9326..e8202b5cd3d5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2734,6 +2734,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2790,13 +2791,16 @@ static void task_numa_work(struct callback_head *wo=
rk)
=20
 	if (!mmap_read_trylock(mm))
 		return;
-	vma =3D find_vma(mm, start);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma) {
 		reset_ptenuma_scan(p);
 		start =3D 0;
-		vma =3D mm->mmap;
+		mas_set(&mas, start);
+		vma =3D mas_find(&mas, ULONG_MAX);
 	}
-	for (; vma; vma =3D vma->vm_next) {
+
+	for (; vma; vma =3D mas_find(&mas, ULONG_MAX)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			continue;
--=20
2.35.1
