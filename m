Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9741B57736F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiGQCuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbiGQCtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:25 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1B2182A
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:40 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8OWs003733;
        Sun, 17 Jul 2022 02:47:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=oBGOn2+rRH/THsbd/cZjknoeJP1q+qBnIiBF+da3EBo=;
 b=CtjNC32mzAW6qTV7TFNYlpPIl/UnQmhEo1i44Fe7QQ7swWG9RCje/iEvSyl57CwWIaGb
 y3uWupGauTq0Wayfy9TkqyHZV3kz/F1d8uECpK34Qy8SUDkCZsGKZmJ9xqfCx6l09Rfv
 HzhjrUIrb2/2p17wT2jWWkW00mEyL+p0S+gObnTEGkQg3xfLZkjHkwfkZsNqp9pDDkC6
 MQWA6sCn90Nmvr9BtlRL7AdTt7FhPWjhMZgU6NkLqKhR53Yo0V1r1F3byGn+b7y4248h
 Ln1CFf907EWQG45BFe5RHqUwcv48y9oYSng64uelkVdGBCZwyKx8hqe2s4AvFTKPivF0 9g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x2b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISV036113;
        Sun, 17 Jul 2022 02:47:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRsq42i0HMdAuTqtSXxJgojs9JRf3RID9EdyJWcOT5mN4CGmrpgD8j2W3trHmPJGjJLFrnu1hlmu3QkS4ysncSOf3vZ+5XkQ2gMMUx/PVFaCr7ArIh8arqpbFGod+gYSsBHThatOi7LXdcy9pB4vBcP7L4nWHNly3LAnvZR+Nta+WJAu7b/5KNAl/FVys9E5VD3UeO2WD60hURAsjWGEDwpITohOTLBIeQY0L2+t6i7OpM8fqprYvrEEcUIM817OD9QlDJI+t3VieyJJ70r+k6aXHE5tofM2K0Xudg0WVX7+OPHaBfr2JTvuygTfoEzKQWV0gKf6geu2GaivHO2WjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBGOn2+rRH/THsbd/cZjknoeJP1q+qBnIiBF+da3EBo=;
 b=avAVZ6vdCso4ikYen7+KZclOmAIcNoDJnG7lXNjBJTTfCPMz6pocKaWxD6as90249Bl989dLZ4FIo2tW9arbnpmOBYomwjqi/KrXouZGowWvJDoDjHG9nkBkt5xzCdkkZkAbzvOKKg82GRSMaM8Z7oMr4j2VnvK6L1EVKYcUpV/WbNkrL4iC83Vc4EhdxPAj5phC4OB+YkpjNEOh86yedy1pt016Ol23TaqnbSe+1+YBILCV8H4Iniw1d0AmxcSs9lymvrQSLcdqsnTMVyPs6dCM2Z1mA5XlsTrfc7i8yD020Onmc387zYRWr7iubFWJjxTvSQfIsxxE+w5evQt0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBGOn2+rRH/THsbd/cZjknoeJP1q+qBnIiBF+da3EBo=;
 b=fpG7XEVb4GuAuxodjtafON1f9ktWrfWgOhND7DDLcKvnZsqSwgQjg1cK0nj5FCu1uVvSh0BuYJproRWu+73swNQcR7bPf7DAQuE+69lc4pt6i7gur3GijZWODJbDNZODpg8i+pKXoiY2ebU7lqC/dt87AJYbg+N7r4KecEc1WEY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 48/69] sched: use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v11 48/69] sched: use maple tree iterator to walk VMAs
Thread-Index: AQHYmYd4R1T1u0ViKUGx93yOhL10aA==
Date:   Sun, 17 Jul 2022 02:46:53 +0000
Message-ID: <20220717024615.2106835-49-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73d3fb40-a6ce-47f7-b384-08da679eb0e6
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zSSyjP3fKwXibxcwYLSnab4oIw4yPndKXX6mVuQthwWulJ7U7KlM6GDRBk73pBGljav/G+7blSpXWhh3TTfR9vp604ArHapPYIZymNT+JEDkY/hiMbjZcoxQNK85EyfbtmCZZCThDshQjtDwegjUqTBmX6BHCuOnUDKC5Xk57NTVa+YeOxVSRwaD2yATPYFE/nbJhbVpZA+qqrgh/vsxdifQ1a5xJS1Z+w8rvJR5/Y34LEr4t+J8jHtgak1zXOKJBJ9rYbq02VC3TYlhsQuzL2V3Q1FOI69p50St1vxNlEZ6N/nqdxBtBTe49p+9DAHkVNY0aVhXHglXoYyiUKv0Gf1RhQ6JFc8M10SlXzdDRkGcp8w/3FgL0BD6LilldvT2t+keCJnzUwqare9m0caMaOb2UzmoL1ih5FDHGItlcpytc5QbJ3hv85BbslEJE685FR4Ztx5saZ0t/89Kd8XpT277DoHfuTuXiYOSUdWb553Fv7ZShs0ORIvbf9GcJbSXHWxM2B6Ln7lkOrPUzbROAeh+dN8cDXqSmq7nvqf3Kx40RzzGe96bp5n2KsIIqh2MFkKxld3WC+tEqdDvGGOcgwWiH8frxDWXe8oYq4GvgWpWgr6o/obyGJl7cwKAGYg6+4CR9gxwwnhJir/OBZto4W7gItNdwJED8fY3zbGiM8S5Q1UlGfzJ/UiW+MP6Wwtc0Rx70WJ1RKZyWYbPGeIb1lL7+6cHKy0pDM5wqsqDsivY7nj/qhl/m99BBwiAVsaiqtcBpwSklpPk2z00qdaHESe35c7x/8arwZNJFEPilOovCwQiseD1AqSGEy7rhp20fkAgs0smwHxGkbgrtemNH9YF+txGNgdfwQk5PvgoD6wUT8QB9ciq6nxgYBQqndbk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5kN/dzEQ8Pr0qYs12ZFZ1GN4Z2KKLtF2+CTmpfuQVeoldR0Znb0WlUMWha?=
 =?iso-8859-1?Q?xABRGC4uhQtCHKmU9xiV5wWNPnsRBv/ByrxFGfOdQnykNmk+/gdVWVxvJT?=
 =?iso-8859-1?Q?kbH0pzm8vHg/K+W59z9rJ76k7EKmGEeXcHH8rT8PZMO0jGsR9LRAZZDxeE?=
 =?iso-8859-1?Q?buB7Qb9xOwNH2ajVdp9nCa+8IeY+o+/hcLtc3zNwBj03MakDJ9mlzPCQgs?=
 =?iso-8859-1?Q?fiSjayWMzn6YzEbDlKIoyOewVAtGUSO7Sc2RvJICq+8OU2Qf4FMd31zRXx?=
 =?iso-8859-1?Q?wAZ/T6lIh1kz3y6K+ddJ1jk5LlQ75HOOK6kERtXfevTBlRXGfhsSwWFCjx?=
 =?iso-8859-1?Q?H7uybqrclpJ49U706/H7rvjXrObTbxCUIfBzHQWAAO53OmyFoe2maTjL4+?=
 =?iso-8859-1?Q?DhCiNv2YS6T5ODNycIXByp6Ln1JsygpsKp7Dj+EjEjgHFFIz/5MaCncsaI?=
 =?iso-8859-1?Q?YHwYCMa8MG5jy4CWv8gZWYlmLGKRNa+dmsQhT2Vr45PxSao+J16l6IAWc2?=
 =?iso-8859-1?Q?pANTfpFwF1oXlX4Geaz+yzxH4hWFPV4Zz+k2a3LMm30qwhLIRygEDkgO2Y?=
 =?iso-8859-1?Q?mokPOcMOgBK49V/16JKX3ZxVJHNn/BWW0C1e9EuRjfAy49wMekIPuHAzyA?=
 =?iso-8859-1?Q?P2KgJVpfF7JKkh9btcaP0mOxvTPXBF30RvRYg8FbJAEOK8Brwk+SR5Y6Rf?=
 =?iso-8859-1?Q?zojFy/RWkP2pSXX2adWabRUcjP/9bLcoiwswBbQ9g7PH0Dv4zh14syzUT6?=
 =?iso-8859-1?Q?ImAZ8ng17XLbuPIIsd+CXrmvTjlP+vL/0n6xZij3FvTamACTRAlgBALKer?=
 =?iso-8859-1?Q?A0Lvz1taNcHXQiJ7ISW3VhgUWE6iZD519NW79pBNhMOi6Y/6nwsURnPxAS?=
 =?iso-8859-1?Q?qzEuUO7JKwo+skI0MGUqVc/FznTGSORK1IImJvYUwOC8puP8h6Hm8dVaHL?=
 =?iso-8859-1?Q?1QAq6puFOh7JFSbBkS+MqMjoIfHvO9ZlAkFhJfwrLc4dRPccccaUIzG8tu?=
 =?iso-8859-1?Q?g5ISjzPvn8GwWcf2RPjmQaKbcc7QTgqFQFBgYbadt9rJoEPQvz9CpUGHJp?=
 =?iso-8859-1?Q?YAYDjXqimBRlvk0yhfj0KbF2fC6yjYi+J2ACTUy4hFeAQljlAz/HD8Qa6u?=
 =?iso-8859-1?Q?bANj1yivPX6S6wGWUZIxOOQE5QA88geJfqdDvge/yxMGvX1LXPIELupZa7?=
 =?iso-8859-1?Q?7EA9l02Dp8B5oH4RtKmHDVjRNPCkjXxoXpEdmdTbE/TlxheyJJAkBMcHvq?=
 =?iso-8859-1?Q?epSZwGdxmAnlSAcVKVCoE3BF3xLBQd1Kou/MVp0wUIIl19n6iRR3scNc8w?=
 =?iso-8859-1?Q?2WCQOtnyGY7BPu8i3vwx9+cjZeXUTvYteSxUS2ldOJbR48e5hGtZ7auQzB?=
 =?iso-8859-1?Q?YwgTteqZAJfjtC+4vGfd2YnAMy7pBj5rdXXDIgo90YiWIY9MbcQN21Vmyq?=
 =?iso-8859-1?Q?ljBRxsBqJ5jGf/LvF2jEaO4xCZWiMTJH0+86YE8tJoM9Kcj7V+9y3qX+2w?=
 =?iso-8859-1?Q?gzYyOKen3gXJjJOAoCmd4VvXR/JGBabbbm1Z8HB41Wv0u6Sn2iSMOjSj1A?=
 =?iso-8859-1?Q?a4g/YfE9sX0RG9bfp1FDFSxYyuO8L+z6AnoRxZ+LJktwa561W9z2qE5ksI?=
 =?iso-8859-1?Q?gifECGyRrRR3rNWvCAA+smhghhEIk9nCgub5s+5l0i3X4ZJed+4AHL6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d3fb40-a6ce-47f7-b384-08da679eb0e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:53.1305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CQ8hy8e0Nn80YD9d0gWvJD45hSjuzUzjDY/APwvE4dtqKluwfFC0as/DtmVS7fc5zfsJHPNJsyd49mB7lwCP2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: mWCeVw7hp-tRN0EPDUbG-EFdDqK8lcVj
X-Proofpoint-ORIG-GUID: mWCeVw7hp-tRN0EPDUbG-EFdDqK8lcVj
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
