Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C90510173
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352015AbiDZPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352108AbiDZPKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6671594A6
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:37 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT0nL011361;
        Tue, 26 Apr 2022 15:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ucIIVoug/AJl3C9YttfwCpHtLO4EP/QesK3eEnR8y70=;
 b=IH6AHfu2Hbmw3RRmfzm1F2hBnCRmSyaE94RBKMMlntqH0dMM4SKnf+08EHpFZjhJHs7k
 jE7t903/r5MU2ycHz/Z8mquBY/ZRY1oLd+TU32bu4BoEie6AQBU9DZPEUB+HA/YLeA6B
 GWiG+8234O9V/9SATtpQcafKqU+xHEmi2zaDd/8bF7FtfdmFx0AcvN6qNSMNtTw/QRCv
 pAA8DUTceMI0M0MG+qB29Ly/k+560VLVmIXhVEOYbBrErTO1XEhmoKaThcmvJGxfCfrY
 c5ukhM+AhYLKBtW3rvfSr3IVSB3S4jRHLAyk/OEaP5cPzaOgDgdDEQzYD3fkN85pHiKc fA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4ef8a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:31 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF5555019202;
        Tue, 26 Apr 2022 15:07:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3ff1x-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOF1oe/lpoDOIkYOcmJOwbr+ad1q1fmchuPhzffCEdO/p5RQrBZ9U4cXguNblTKq+aPpHCWp0+tAvGlg+dVuY/g/ElZhqjR5HJHE2u14SZ6DpA5kkD+VOyShKQhFLAlIZe4Js2sOUN3a6bkDY5Hbm54zEcLOO+LWVXHhgwE/CLgQPp8Xgp15Q0CSXGgZjIC/Vw/Mom/mL9O54MNjGrvcjDZdyBZT200pCk0u2LaZBctq+8MdkScnb1srQZFYuu8ODUD2qINLNeQ9EGk9vIN4jMZu8PPJc5A7+jhmXh61y+wcC/6+kbxZK52D6QyXFolNVUcNbHI+EyAGi8OYdoVSYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucIIVoug/AJl3C9YttfwCpHtLO4EP/QesK3eEnR8y70=;
 b=hEzv7f5mwGw3pHkhNC5ud5EyRsLkGGkspa/HCfuC7h7rj28+xO0q+rB+aYJlBOaYPIG/KCvqUW9gAUFHUqdD5D88VSH5htuFLcs7eaH6kqRj+/YQsw8wc+eGYzyKoImDtx8ywNP44xr8p6NO6eOwfp8RZZUjPO7i1mqne84Lvwo9JppDlvUnrVV+u9KDRBoyQ8QFIlXRedK/vfcN/C5VexrAwnbSJYKu86k9NmsV7vSyVDfoO6RF5C41MdpfQp0tvJE+fy49GCcSmHuiYsAN5rDxHVPXmxND1n6GvJLOGBt3fZLc0ygmF/yP7dp2bT3kyfPv7T+9Lcdk4O2+FK0JCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucIIVoug/AJl3C9YttfwCpHtLO4EP/QesK3eEnR8y70=;
 b=Ojl2IaptzWT7Vxikmrsaiangq02mZTTTN3LCqN4U9RPlT6sdj3wCAwhVd+H0Edjh2DpC2MIKo3rLhmk04wX4eHrPQXkw6EQVRm5potKYMohl2ema7BwLSJLqtuuO3XTE8lisI4nNlmtcIUOygWT0pY+oTgD6IKFsEAoPh57UcS0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 49/70] sched: use maple tree iterator to walk VMAs
Thread-Topic: [PATCH v8 49/70] sched: use maple tree iterator to walk VMAs
Thread-Index: AQHYWX8/zWnWRCpolEOQm6DJEyDmaw==
Date:   Tue, 26 Apr 2022 15:06:46 +0000
Message-ID: <20220426150616.3937571-50-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa2372dc-dc6d-4bdc-5520-08da27967b4b
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929402DE0D83434D64BF208FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nDLJo3hicyV0EpeTGsNYuZQcu38tQGyF0DtT19k4SGtDsEUe5rac9GU7jo6I6HjA9AC7uMjVLu/T7wqDIhDGbqvzN7l5oW27VsD/5GmgftfqLI4f0/MYHUjC2oKdK7Xx8VumK/2Q2YiI1N8pQzayJUtFV6sLAz671Luch//0Dxsvg5ZlQen+qWW6qF0C7I3cmJCmulOZ7ZVCUkHzUK3ocRBLrbPSC9DFbWKaGC3KimRoXmDEA8W34VOOJSDn6wkbuuE1c/ftwhrJNG5HHyJhstT1j8w3sRLFl6BII4rxLKv1V9bjU7P/mNkd5NhEchwRhXS+38gf4/Hqv8M84w4tSWNwULsa2/Gq+wWJtuyi9v+RTc6enSC2CWYCXPKcO8+HPQxvDIhLMB1v9/NIoMbTTEAspyiAWAmEKej1YxZszrvmfFrb5EXKHS7npHmy5w5uCl0jits1kAIAXwcDZc6vpP+LWPhywXWz7VS5/+acyZsS4AcuqtxwGUTQWqhbQQb7PsCdvwKzKgOldtHZamYBQh2MGSWHdqtww3jTArewJFFja30Zj1a9pvLeL56PNaOmIy7FTx0/SU/2yWI7x7aNN2O49ys9fQUgfjnBujoc4gg3C5hnzuIrF4CAKFdX4pU8UaMcjMci8jhSk6uxGjhZIUFhS1/Z5/xyRZAFl6PlXJ6lsQ+AQWvgqIVrJUWnA5ACvDT5t4aX6AmkocWAkxkTSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xn52o0DoCuQFjIzkpAMymxE7l/E97bHmmMj4Qq1y1ONnFNiUA//tamgKxi?=
 =?iso-8859-1?Q?a0g/0raeVikIxf8fP3qLz0dDn9wMg8REPEpQeAIZn8WeNcE9FBBZr3fajV?=
 =?iso-8859-1?Q?5U+un86hR2u0uEOnPfGu+u08zF2WJBgXX3HTUPoxXWDgFEMnk7ZAjrdel4?=
 =?iso-8859-1?Q?0eHP7O+PVAb6WUa89Yx8lSnDKnAvwJgxzlXMTqqWGi+BMRQCJw2/BdkCH2?=
 =?iso-8859-1?Q?WLi+cAeZn0/By8mZA4wnKxIW6Q7tEUBHgRJJLUs0R5qCNTYCahUc0ldJIS?=
 =?iso-8859-1?Q?m6F/XOTEzEPlXMzCVOdZc99AjXFoWcuSd3s7SpwVwszBj+HjzIJX+XomqJ?=
 =?iso-8859-1?Q?l7NuF/6ZtINgGp3oxY2tayzGhskN25St8m7yXt2FosCbHE6qlTKiOuac3E?=
 =?iso-8859-1?Q?anprSs95uv1skB8Bacl4lkJ7nYVfx+TVOqFPdR90EieBbA+MRTkorqeYXI?=
 =?iso-8859-1?Q?WADZGi8j+OdFyNEk0KmMUCPDIsWzSV2e1dllxnoQAgogf6mxd3op+NRMLG?=
 =?iso-8859-1?Q?bpAx8hf5/nuoduZVljwzNp6CZr7nf2N3NP5Yg4C4Z9vLBf0SoK9d0ARELs?=
 =?iso-8859-1?Q?QIuysFXkpY23OtYiCU1zL6r10JTKKvYC1l6pWaBX1rq5o2oF/dIChX3B02?=
 =?iso-8859-1?Q?x5t3evtAm1WeBDmQ+vGOERWjdNE7r1WScn6d1oucvqJhh8uucXHqnniifX?=
 =?iso-8859-1?Q?/V9L5W9uo+wnPwDNdb3PhnZ8UAJ7YJtt5YfGdgBZ4K6XIn45V5qTX86m+1?=
 =?iso-8859-1?Q?bN+gl/WIcQnyAl/+MLrYELRRWHmS9A8M1fzCLpGMwpc7w25e9qYEQ6qbro?=
 =?iso-8859-1?Q?JUijahBubuvXNajWkv6r6R5oK2exlJySLgR1dN3mZvGxdqLyw1WXZxGvFq?=
 =?iso-8859-1?Q?XmscUBdDKqSOHzVEyc633/mCWOD0y6tpqAS0ZHaHxDozBXwlEuK9N+9Afu?=
 =?iso-8859-1?Q?P6oiqzzZDhCsfKdyaKWe+evdrWal1jDulZVhxlJkMqY/Q/VcWIrIeqSo55?=
 =?iso-8859-1?Q?/pjrnuF8y38ZzsNSP/1GpVlkTC0ExYk5QPWeGa82RTW9ZEzSoDirrHeY3F?=
 =?iso-8859-1?Q?U9qmFrVQhpc6/owzk2554JQJLUjPv0j5evg1rZxKn45MnJUbsE5rwg4YjU?=
 =?iso-8859-1?Q?8TJrzsaJKa2TGNlrlRMiEi1s4hRtqNNYzucG5uct6n8ZtxeWUPdP/msY1M?=
 =?iso-8859-1?Q?l9cBBv2UDuBf0khttO0yM0+ojY17NOHb8h2CQmj+uzCJwPUYLeBBSTS1S9?=
 =?iso-8859-1?Q?p+VuIinLAWeBWweMKHbOzCBKw0GfIbfZQudAViWEJQr/xHsRhDR9jPIIJy?=
 =?iso-8859-1?Q?meppi79gEICzNN1yl2He+YiZXgPHvQC+JOoqOTNZfrpDLVItm1ZpBr/hOK?=
 =?iso-8859-1?Q?M1uVJdOpT5y6IlDFkdXdMRkdl5C5yWtO3K7eg+wovH/lMr+DHp9Kue3sgJ?=
 =?iso-8859-1?Q?dPciE0lRVNipr4Md+no2DEPTc3kk+NnYFbp+G/wPIZ1se32oRjDuRzUUWW?=
 =?iso-8859-1?Q?hxMgS0ErlEvEa2fBrih7+q2unXJK0lmGyYBVV8NG4mM3i61JTDJMxothzF?=
 =?iso-8859-1?Q?X9/jHWU/b5PMDcC9BiV4hdF1jgnsV9lH6iwZRygcA3S5je8Rayzuflwpzq?=
 =?iso-8859-1?Q?uHjMN5HwshfaXZvkQ9t70aeedCLdTXwaoH7J/bXefwN9gQPZy1sSC7I3MM?=
 =?iso-8859-1?Q?wIO73qopV5hiDHpj+VcQwwPmoCg2O3nJz+5+IwH5FAP4H3xESk2Jp/E4BC?=
 =?iso-8859-1?Q?CNchjfSiUr9GEZwbGdBukGrhI8wy2jwcqKSl3rozDm8ck80J3ZBtS2oPpq?=
 =?iso-8859-1?Q?VU+kWX729suduCaCRQ1aAXx7LjrzaTY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa2372dc-dc6d-4bdc-5520-08da27967b4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:46.0988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKNBTdTVIHFTOsm5c5K7oHER//31J7bG4u8p+MbF1XRfTki+yICy1FAnEJBD6ruWDssc/5nFqfEDjCXCh9xLZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204260096
X-Proofpoint-GUID: OusuZQHTk-FkNA3nno0BMGZjuEPkbIhu
X-Proofpoint-ORIG-GUID: OusuZQHTk-FkNA3nno0BMGZjuEPkbIhu
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index d4bd299d67ab..b8b7962b5832 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2722,6 +2722,7 @@ static void task_numa_work(struct callback_head *work=
)
 	struct task_struct *p =3D current;
 	struct mm_struct *mm =3D p->mm;
 	u64 runtime =3D p->se.sum_exec_runtime;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
 	struct vm_area_struct *vma;
 	unsigned long start, end;
 	unsigned long nr_pte_updates =3D 0;
@@ -2778,13 +2779,16 @@ static void task_numa_work(struct callback_head *wo=
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
