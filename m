Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C6959C263
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236394AbiHVPNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbiHVPLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:11:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11DE5FAA
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:17 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEirI4017918;
        Mon, 22 Aug 2022 15:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=81hLR2p41Wme7z5ElJv/3Isbxe8k0CndgU0ZZQSJKT4=;
 b=MRe2ww0n1l9ySQlcMCoCVHQUFzBrBcgaZ/CQHNQ78GnVNFnasivI0bzgA3NydoFese1t
 0uiX/zM9NhO7h9dPK/2TvedxVMzfSAtw8lL7aRYqQJEuZ2KkWlaS5LFx6QZe5g7yphNF
 xQROQjChgv8RfpggZDrUcw/g8uCEfWNOWjLbjVYVPXpP7833q/PvUNVWFP0BW5vGxwYd
 SCFOu/qQctjOTayRt3wkMU7q8lVJaKzMHRTLMpTTeXMZ6YFL4OnWNMMBGRlYfLKqzWnc
 NFycY+C6akQVaECvj61UFGQSuafGfOnz1Cuai0oi1AFFvjPcgzPc7oamipLJ0BkiRHF5 3A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bkt049q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:33 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Nag031868;
        Mon, 22 Aug 2022 15:06:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mjd3986-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bkQ2moZpeEFoSPZC73Z5wqyJPVfEVj2Feah3448FCQTln7f73509qTGz5Kqk6lP7dHXbx2RWIXxTemI/F7pUDbR0xYglaHbbHw5/L3zFY0eJoXBQ2gMqEUTvDG4ODU8YA9RsPZVllZ4voOeQZa5jt5H7dbeNwD/F/Ihy1Vw/Cr5ztkC3wSlSTzREZrZBb3MZpoZwjE0HFVECDgwusQMrMvI1FIPT7cxD+Us6pzWCo83S7kpqadfUpQYYBv5VWvSyI67XK6/ZbSGfpP/YPYCW3rfs7u09wwzmhZJmcwp0Z6gQYxpMqw40m2i7ynhd3wB3nULktYU4Dh2l5fXQ01ef9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81hLR2p41Wme7z5ElJv/3Isbxe8k0CndgU0ZZQSJKT4=;
 b=FMglnfDH1pybDPpChqRVZ/bCqCP5WD8XKK9kjwdoPC893wO/V5kdZBwmiAOUFkGqXNAO12shkk/wTCq1jh4z46tIh4QX3LRt/rzXS47q2BUxjTK8VqFDrjksahiK7kLCdQVLCVomWU/daz5cPWdLwIz9hIbt0foIBp6/8OAyApayLbUWe7Mlz0l+fT1smHxHflecrMpjxXkzBo4qclkFN4ZtpbqKbIs4dfAI3MzxWKh/NhsF3eigQotZP41BBTaq7VSUDKiZxS7qcET/1zPyXan6rglDRpEDjKwlXkFzMaR1CM/37wWrZSw9SAQQIxVe7UP/aDKZjd0sl3ZYmwsjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81hLR2p41Wme7z5ElJv/3Isbxe8k0CndgU0ZZQSJKT4=;
 b=GfQ11S3AvMD1xDuTQ/W7EedppyofhchnT16WCSF51G6rFDAeQg+H7je5FSFnnnzxBSs1ryTgD2ORxMH617JvijCcdLO14IelMVoqTh0uGIYquaRuCRqT6U4GUyuADAsGVxyMovQBL1WtANWRpMgi65rFcwmmsszLJnpflX2iRYg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR10MB1433.namprd10.prod.outlook.com (2603:10b6:3:e::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.21; Mon, 22 Aug 2022 15:06:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 48/70] sched: use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v13 48/70] sched: use maple tree iterator to walk VMAs
Thread-Index: AQHYtjjACsPOJqyxnUW2LCMZZAy3mQ==
Date:   Mon, 22 Aug 2022 15:06:27 +0000
Message-ID: <20220822150128.1562046-49-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b672c62d-e798-44a7-9bb3-08da844fe4bb
x-ms-traffictypediagnostic: DM5PR10MB1433:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GVYfe6/Fya82G+OQTFpVSVF7swJ+XrVr22cZ8sRztWAzO4wa9D9fm8DR250J7G/m7o6sGv4ILeb1MKdsU/nNDxqyen3d+RNNgfEALU15z38WS6/f0JvX8ShKzdnhpxHSb4NhmbPVHAizYbholwARbdsonjvmD9IKipUcZZs+WW5d43jz3DeradEyPhux1CD+S8TloSS7YNbO/lKdcGff/8ySMTtk/6B0qa/8p+kBM1+FlJykTs93o48CNtc3TUjyBdd3VUpFvwh4KBj7+2QhC6+Vtnqf07OeMgmHxkbDO8o5FybVjOKYdIbHxGFUzXdV8M1gLAH/r/hGcqD3YSyWHysMksZye9UFzSqJWeTR3T0wtARXCUY5rjU4crdGarhLBXqMqNkqzVpOOpbUrQK1NIpigCopPvVXQm1GUqclJbB/4vN53PRPqUnbAd4wQD6kAJS8kBcFK5giSZ/3AVIOfb+wfx7OPeIw9bpc1UvgI/0Kx7+0Lnuv7Rxl/46Uyy5+/YolVNxbvO0B7res4qqubVL1TMy9UiQ4BtVQlCa5yFk+pJmk4YQ5xWf7Ef8twIB78lQn1HqbbvxbRmjmgTc2PTAvBb45E7IHgtcjkKUcGapsAKuNdTmlJlvUPAxnCYN2Qubaj2DOqxhQMfOdUnm4caLlRoyxm1Mt7SgXb686eiaKU05Gbomh0hfxHfnXxKyMALmELeHI0TPa32q54QT87ZAvIhENlskQ6eHvil0FiXiBmqm7Lxv2ZhYpLoFxLwcv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(396003)(136003)(39860400002)(366004)(5660300002)(8936002)(38100700002)(122000001)(36756003)(41300700001)(44832011)(6486002)(6666004)(316002)(71200400001)(76116006)(91956017)(110136005)(8676002)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(54906003)(478600001)(186003)(1076003)(6512007)(26005)(83380400001)(2616005)(6506007)(2906002)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?nSIJz5sXnt6AKIgOlpCv7bs4PqT+Et9NbcoRJy5FNqw/Dxv/SEzzzdm7Cu?=
 =?iso-8859-1?Q?XrBYuNY4tfpuG2zFqiojiUSXNIkOV/qODd7wJpYy303qnICDA1PWmnHtOO?=
 =?iso-8859-1?Q?fW1etYUuerHItA1LsnH9+bYJrrPEm7T0fkUZVKTgFIfrlBGMcaJBlsc3R9?=
 =?iso-8859-1?Q?lKvIdtD2mdn6iv7M5FQQ8afluzwWIsTk3sAIEjsPMhj+4skiMjSXf/+WyE?=
 =?iso-8859-1?Q?Cl0sb+1AW/lignNfFgeBP7AFhXGm0E6BlwRDYuB5aGoR/pitBUAh87RFOf?=
 =?iso-8859-1?Q?Sg/0VNW7blXNDjeJr3Q2TXPEtEan6VyyzakNVP1+1hs/iAbuRb4FloGMY/?=
 =?iso-8859-1?Q?cZ15si/T/wKjhUCMNrE30ZmwjrWWUAgJi4VY1MJnv1VnhDB/9qt2mQUAos?=
 =?iso-8859-1?Q?xHYeT/E/ogrGy/4eIRNwt46J9pYSNgLAWcIcA6tupQI+rwEeGtzktboV9V?=
 =?iso-8859-1?Q?NXQzJOKbJ11i7J6JiAv0IKJ18CizqqqQ/JEZbH4cgcFzJadgxNgyoZggc5?=
 =?iso-8859-1?Q?33IiPAYtBfPntQI6SGc1Cyt+ekj4K+gws1VvNgLFgy58y94DpNmmO+jFAn?=
 =?iso-8859-1?Q?02IyUHiURh0L5qrCnp6RDclqwrX64gkLrx+CiZLD3s/Hr2EXFT2bNBfXRD?=
 =?iso-8859-1?Q?ipsA/wpg1tU5SOngozcOEVpHx87j5cxEqxUhQ0fJp+uQifR4v+8nSHJrcv?=
 =?iso-8859-1?Q?BiFhOxNAG2TVxG+NjLvXpAq6D6SYv7doEZBXcgK70m1nfAR0oZfELGjKvJ?=
 =?iso-8859-1?Q?bNX7NcgEEBzQsoIR7t4qFPMLVAuSNkxChRE3Zo/3NTPjjx/eQtEPSfT3ta?=
 =?iso-8859-1?Q?ghXWWrnNAcpT1zMlTemZko2QD8R/21f00iIrkjTPEfhcQ0UVnmOS2zhzeI?=
 =?iso-8859-1?Q?tkz0l8FEI1nSEsiBM1vLN8GMfliIfYmGWHDgghVtPBBwaWpdfh1aHYsoJr?=
 =?iso-8859-1?Q?vh+croHByAVu2oqjuMUM1E0+1AuAVzfUvXI7kd4ioiOjiG0jIZwSmksr5H?=
 =?iso-8859-1?Q?t1+cPjO3QskM/Q5qJ6jyTTwMnXAHsY3l5kdsNDWzuHci/t8pdW7YbGmLgY?=
 =?iso-8859-1?Q?9M8+1L9ClJqG2lj9PmutCejk3bxgfeDaeFZ3LPwAJldfp5KwiILWD6PUbD?=
 =?iso-8859-1?Q?PDThIR2iQf/FOCOo8IlNVB1SIrjqBwJHA/pryEpKZ5q4FsoxwzYTd1QST7?=
 =?iso-8859-1?Q?sIkWuTRqSwkHmgSDUZSJrT0/o0mbrupzU3NLxWfz1OzIyCqSuJayp5oMTH?=
 =?iso-8859-1?Q?atgyQQP3P0pZKy6mmKE7m0OIvChjT1gNMSvNSg2Z9K43goJbNZYyoD9AAz?=
 =?iso-8859-1?Q?I2uyo2eneXWxVPPjO696qpt44PzOsgtDUF4n7AmWTBG8mbwlMqmaKZU9aj?=
 =?iso-8859-1?Q?X/nz2pLuoAQN6wDcHtsUgong4gjZIIqGkNEdy2wacPXHer/zmFT0UzdI07?=
 =?iso-8859-1?Q?CBLJp5yJhhY/w0ZDqSJC5Vm9cIyfC7a6VZ2UGXNiulMo647DWSvaHV5tr2?=
 =?iso-8859-1?Q?8aLTN4UrkBCS8I/Kw+ww8R2yNJL9JrA4lh2YV0HchGRjjSzn3fCCi0REOB?=
 =?iso-8859-1?Q?QH4F3xGqZW866O/XGthH9EWRhWLMFQV7Z+fFcgqidBgM8m8ivKc4qZB597?=
 =?iso-8859-1?Q?HTZYmg5bpFdod0gdjdtN5rtIq1wSCbyS6nIhbQ8s3IAvMEKvgcA/AZBw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b672c62d-e798-44a7-9bb3-08da844fe4bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:27.6287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXjOwjWx9kQGQNojrNBEkzIkBx/5p22Ab8dkfjViubU9AJt8s/0zqyUX3z9oPqIclRGgQV7Iyi9sJOtpgmWtyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1433
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: -tIZ9C3vTrClyC6BmhJ12BWCFX_EZaRq
X-Proofpoint-GUID: -tIZ9C3vTrClyC6BmhJ12BWCFX_EZaRq
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
index d642e9ff2829..c0c0e691d426 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2929,6 +2929,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2985,13 +2986,16 @@ static void task_numa_work(struct callback_head *wo=
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
