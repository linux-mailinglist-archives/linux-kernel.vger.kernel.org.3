Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7B55AF515
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbiIFTxs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:53:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIFTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5175646E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:06 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id90t024660;
        Tue, 6 Sep 2022 19:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=NbegGSpnGpBiXo+//5i12fi0VmTrSs10noRG+YO7xeU=;
 b=fh9EsXtAMtxmfg907D3NMUKHEHMrOFVKov/ijGhLc9jfggUNoVN0IIYu9Aq+c+fu7BEt
 grqw+6O6KDk7nDY8prbIYq9hw5QgBdgcyjxYtAEtxjMBXcl9iDtMoZQSL0kmoTaDYsAt
 ANCkHuX/+GAcEzRjbdMrqNGgYSBsFaZKA3ZIryb1CYtol2WfErsQXqqriPfebl55/3t+
 HmgL7hs7W2RdRs7jdecfL3X1no9mF3mh28l+EUjeFpbCn8BqHTJiyM0S6lwImI27hRun
 kV+smm5Spo1Ts5ywLSp/1pDg7+iSc8bGlTZSoEdXXA8uykyZMh20I4Tzv2GfUtsGUpPw tg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5Wc039711;
        Tue, 6 Sep 2022 19:49:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=buhepEYvR058SpcWzxruyq/yMBgD2GWQHbeXTN+ifVh6WJmapAGD5KLMgrKwNPBL36hdrLQDAXoRdtOkKVkvPJBa4ps1hFBICZHMUch6bob/XwVPA7kyIPHn6ukIzN4V9uCg/qbuNzBE8A0yr1aDqOH545gu8+sOcWpcR/N1zBS304InfL1JOhxavJIPTgcWM3WfZPSzC3yzo0HMULMA7KPAJqLbIk7BgFhtDjfBi7eh1ozGj42iLXfcx0vjw7j4/Q82xtATlE2n5dJDXG+qoXbxH0cC/j3Tfoi0HAiFB0vky0Jvv4spQuG5ygoXkymYpC0VoIL8MC3bw/C4nccN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbegGSpnGpBiXo+//5i12fi0VmTrSs10noRG+YO7xeU=;
 b=QlaNUTQbIb/UDS04JreLYrqzIkGmN5gSsmOkzkUetnS72Hd4BTm0lLHFDIIst/cRkFqh7OvmDGXC5NVS6xfTa1h6b/28JCSVIK2U0IY8YBO/S78D2vQUr3m94fr6kj7TyKUOscMiwo1+L32GI1hMSYFyz/9n6N9Q8Ru5fQ7tlaIS0HZPoSGBiehKTYg2nNzwyRD6V2rJZnl5iAKi/B9s3SPlpy6skRh23N2Dsahegx6tnDh2ckzQ9S85zYorPihjr8n/8eWEWAQDHVafk0dlnwNaYQF5p52wpasTh9m3Z2FFTNmSzEmuC3tgEWgz2RM+n/lgaNEFfXUY8+w2ivvB9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbegGSpnGpBiXo+//5i12fi0VmTrSs10noRG+YO7xeU=;
 b=crogkfGaBrLNGUPJ3x70mUiZjTWgHEk+rVP5o0qZP9mbzsEcjbgWT7HifxlIeb/hqiSyugiiNj5Igh9r7ivlqzCi5tMX0QnOWGWFkuTPj9oVgqia7WY/OYBYKvPPL+nrStwvNzUyrcFMLSGQEZe6T++ZSq7OFD3aalDNwTuP3rc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 48/70] sched: use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v14 48/70] sched: use maple tree iterator to walk VMAs
Thread-Index: AQHYwim0ad5QNGk7eUm+mZL208hvug==
Date:   Tue, 6 Sep 2022 19:48:59 +0000
Message-ID: <20220906194824.2110408-49-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c5960e1-b787-4e8d-6219-08da9040f243
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t5FvopP+21ZhUaYbatsILMyBeQGFIto9F78XUiGxKAoAK/U5/zpwEuxwLOY6g1MzdRjRYzfyyYwAzfAMJby7iK/UKD4P1FHUDwua/12Sz4B04Ugl5h166Q6RSUvaRx58DlsxrP7PIzyrYAxTI6DF2nUfzx2Bhz0/iJAbl5ttPaPI1LKNbRTdhidogVMvFH4qT62XZMZ2cXEkfdK6gj1RO+8mtO7RVJJRV4rXIuPIZllvaRbsBF5r8Zpm/dRxipStZbfINQlt6giAq74aQqgWzrZdCyom+LG8QK52cdI3xu0Z1ji3viNS8g0UolKABlgTpUBQUl+9SZ2qrsWhuPPO/Xi59r+Z14+iCyDmfDM8wdLq8C3Ds/DlGxh10MyaEU1ZF3dUGnLDWQDAJ6DnsepjyKq6QZGaBwlcJAB4EKlMTUFgOPk/Ac06JlpXgs0yqvhp12FlBDlHdtqp6NaOaGSdHGbJ+unSYeSocGjUnD2CBFouI4fE20UzCN+HbaiABjJ6fvSNU6io4WZ9urUzTPa0vP9nfn32UG+36NzP4yMDwAL6ePxOVZOWI6O0mAXYp5KldeFKtKjpI+Ep4RM1mLfAHtOuXPpuAr2xdk4ujkZWipNvfugMfhvuSzx7+0QpHpFwvMJqOSISh6F0KLDRAcJ63KN560+RYW3ecTDfeJ2zxP82Q7z5x/+FPruAgTRXc23Q0v28NUfEbLUoJM0cZPVGKDMeaxZwxNe4XFHeOlTA68TbGdk0PhrPQ/wro4tFIgdMGYGeRWmNiBtM0x3vxbabtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?seogvsGIwtWQ92tg2tGR1aQ2C17ECtf4AI6CV9opoF1hklTLsdWfD2/4ri?=
 =?iso-8859-1?Q?0rtlAB+D1d0109wOnd6QRA86z+0n76i9lO/Qfv1+PSAJcCMl678lPY6DLS?=
 =?iso-8859-1?Q?Zd6S20WWlq0spF26qWRzFe5eOSnj7+IPfAJFNyJTw3NOFuSueLCfSYc5jL?=
 =?iso-8859-1?Q?DLCmkM3MoTokGNvY1qi36VdkPUrOkUhwhKWykbNTAqVqoxeMHzo7x74VNC?=
 =?iso-8859-1?Q?L+uYgftg5PbmOxuUNIAtNqjQd544oWnVN5u2FJGsM4ZAOb1sZ/sPZqxa1k?=
 =?iso-8859-1?Q?EUR9NtLE7X+FBgX74JVTy2BSur/yWLAmZO+EOr7PHsI4HXfUCsGqrYIfvI?=
 =?iso-8859-1?Q?sZ3LW5gZvl9Vor7ZhMdFkFkKBhTWWQ1FYnWWs+CARDAKYLH+4jgyF1wyob?=
 =?iso-8859-1?Q?ly7gigyUtF08ugBRraSxcg20Nh6ANbNg2WagZPDo55+EXt0Qkjw8vb/gP8?=
 =?iso-8859-1?Q?oKp3OhuepyFlwlI4Kxv5AMo/sR5NaWwkKy7Cbah7jcvXzqH7vtJ+7ep8eE?=
 =?iso-8859-1?Q?e6L18iNv5SRFQ9iqO+QFWrcmAXwMqhJgQjsoN5UdpSf3RF3e1vym88+15h?=
 =?iso-8859-1?Q?kX9FCS76aMXzG8hULJiSud3xKfNv7xvAzmflhvypjf4h3QG+ZtB22CjLUQ?=
 =?iso-8859-1?Q?ncf8mAj3NzRIFLelwyFvQopmfuSET9FIftT1awhKO5HKzZ5hJsdVIwacPu?=
 =?iso-8859-1?Q?m9nFycItcvf82DsjuQcC252HEpyeno2H6A3MuIPnuJR8Gyy5C4VYKHaJZB?=
 =?iso-8859-1?Q?lVsb37CLo4oTBK8j0TsHc/FoeAubcZyBXcGX48u0i6/5DNL2dQJDYg49sm?=
 =?iso-8859-1?Q?bXX0zw5Cue3aWYu94S9HT0Rs5WtIAa9NtrJNRaVHGlnj8MX6O7kBwUuR8A?=
 =?iso-8859-1?Q?4aWqakq4bd7XHH7/iUulaeNks2fnZDoWR2Mzxn4mwbmbr/YrFixaC5hZy/?=
 =?iso-8859-1?Q?MJZ+PEVhONK+Pmb6vyp5o/8XQUhn198mvgIwifjJhCr1WqwThRzuhkBVdp?=
 =?iso-8859-1?Q?5p5LQnyK7I/L6RKXALWCwZYpLWRiiEN4f42V7+Ri/XcAAXmEmGYDp8MZDa?=
 =?iso-8859-1?Q?bOYCIo2xBgn9P2ETNymmo7gVfVMjYMlMs1rXIMePZfctISZMmS1VXdrWoB?=
 =?iso-8859-1?Q?iU0W0Ak5iWViHE2hbK/HDuB5CjMKlWPea4u+XIk5Y/TWRlhfw999bGHR14?=
 =?iso-8859-1?Q?dtHsefAvK3lYtgcs0uCErD/8N+9ZmbVTVnDuXhjlIjYXKMouG6dxaAM3Im?=
 =?iso-8859-1?Q?Ng75uD8hG2Nj6LU+WBTIUKON4srBFsWyZtPdgfaswf/CdYNZNxAoGzYDFD?=
 =?iso-8859-1?Q?5jDhHFfx2WMCX4SKx2DKdtG/XPclT6Y+51qcHPPgC9cczNnz5m38lbHhTj?=
 =?iso-8859-1?Q?T4pdY5n1edt5o69F+XL4aynwcG94Wbm4Y3guVIc5qTlXA0sV37p0s7tZhC?=
 =?iso-8859-1?Q?MaqBCL1FlrDhp9DZfzKxRNe0l3BaDcaXUNjPzArAAOKX4DUHdBZr/KHbA8?=
 =?iso-8859-1?Q?+EbUlak5A3/ZX1PlDI+SSdoUOsqPJl6CFREBShztX8KylEDU4k9Pmp2wXO?=
 =?iso-8859-1?Q?UF4ye1c8CFBEfzmZeE0Gm333WafVuveYbbZL/Ggyfc5LIcOWhAZmfTucWU?=
 =?iso-8859-1?Q?8LwTPBRtqOADJow0HiIGjehLJspj3OqcSUY/vceqB8YHW4q+8ckAkyqg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c5960e1-b787-4e8d-6219-08da9040f243
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:59.2404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLGHZWBmtDslV5GBbYqa1rTew68D6sHfsp77DWK4BTC0n+qn2JRd0fSiKGIfiAIeRs0l0p/ouVVYoZ+62+tg3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: nJ6eTYg44CxxZC1tn-skn_3_idW6uZUr
X-Proofpoint-GUID: nJ6eTYg44CxxZC1tn-skn_3_idW6uZUr
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

The linked list is slower than walking the VMAs using the maple tree.  We
can't use the VMA iterator here because it doesn't support moving to an
earlier position.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 kernel/sched/fair.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0e3e08a093d4..ff49f28391ea 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2930,6 +2930,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2986,13 +2987,16 @@ static void task_numa_work(struct callback_head *wo=
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
