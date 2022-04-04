Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796E84F1754
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378184AbiDDOmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378074AbiDDOkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684AC3FDA9
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:41 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dl5Ex006371;
        Mon, 4 Apr 2022 14:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=TomK06nRBmbtUSSnN+XjI25pOh3YgASLywZpJTHjVzk=;
 b=SXQ0oUmvp25eWxYDiqr6bKbAzeGtU3MCIfJVPgptosy3Zry01z+NgGLPkA65SdvtxQv/
 mL+kFEfZA5Aor0ot5oLOeoH8IvdGcE4HRYetMzkx82oebdhhNWUYIsx8wy2cc9DQj4tj
 CJO1AUVYizpHk5zEGfyLhBdNpbtulL6nGunX/z8XtCFsqPy/qVSLJAaOjzLBWkEO1Tzp
 4tI9t5Ztd7mIeUByVrLUEY35TpSEdL6flxUkcglTtEAUJAkPhgp/dFZev18MqMTK+KrU
 TeQkkfLtQG2j7zFO8imtXwBuWpKBVzaIQaIj7GXE5HzjkM8HP9rGTnh8Vl63G96/IfEE Tg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EaJH4008393;
        Mon, 4 Apr 2022 14:36:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c9f1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F1c2VPXcB8KQOwNU0PBwRte83elqaTlQ8UJNaY9pegZxHj9RGTlpzlGEiXXFbbVo70aBmIwE/Od1YPey2+Pm+NFWeAujkhUhGDhUV51sFSinT8D//erKzYVLjnLE6OG4yST7ahH7p3fxXJ3B8ayx8TXSE2lkX0Y4YRXE1Bb6qgX8GA4hTdDO+o2/mx2xa8366/pg9tHEGitBLfjgXk/u0cCY+y+u4l8Lsise6EDDJJxGQqFjQCHDqRGx7OxwMchUrs558EnNUYNUFx106jFNQMUtXJU+fz4L0KuggYk/FR+tjoUkjrmnJDNJH1J0aduCPMG04bTAHAUJP7byJ11Vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TomK06nRBmbtUSSnN+XjI25pOh3YgASLywZpJTHjVzk=;
 b=TGskNDwbhi+KERnJi5dP5ydN+Qv3Co0rJTcavv6/KAdV758hlWUx/TFB5tltiF8eODWii3ltni3fmwpUXLcixFcefS9A6s9tcy/8oFo7uhqzEF7ZjUYdM5MZilMEk4ZHyXgdX2Wbinf525Pow/TCfxm8LJVOxjocFHsXUqSJc2PXrpJIQvktpt3MIN2/iyt06F2EsO8B81D1jaMH1DQtEqZD8N+qJREoaN0d64EaNRZts+Xio9wo6mpE7rh80KyLnacFue73GyXIxPk8ZyWNfBeDR7aSSAyEu5zcCicwaEyWpGQsrI8i4XLAypGDlKyKafUrepp5popUo3Zz2qnFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TomK06nRBmbtUSSnN+XjI25pOh3YgASLywZpJTHjVzk=;
 b=MDCNcII1ysu0C5hOQBdNYq8vyeCeN/sCWA4gl3dBFsEVwacSNo98P+sfm54m9At12yFTQHNgwSxJd8SKUwlzpV/1Tuzu7XkLVpGFSx/LJTCGiGnAva2GHB7a03BmO7D1C6ZQqVHnI+AtftgQZh7WAv0ya4jAv7Q4izvRLt2J9w4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:32 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 57/70] mm/mempolicy: Use vma iterator & maple state instead
 of vma linked list
Thread-Topic: [PATCH v7 57/70] mm/mempolicy: Use vma iterator & maple state
 instead of vma linked list
Thread-Index: AQHYSDFK4lu03nexjUS4foHMxrEMzg==
Date:   Mon, 4 Apr 2022 14:35:54 +0000
Message-ID: <20220404143501.2016403-58-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89db8028-c8a4-4853-6efb-08da16488369
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5742B1ABB1C1FA4C206EBFFDFDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2q8zhOWwhW1dZwp/SYsOBztrfqABVgQa7jC8na4yR1zVzT8Ol7y0mcx3CPOaSVgQR7op133SHkySswZtc4dXn0/Njh+9h8/DOzK1He0OGWkHBvR7sc8FgAoP+2ACFWhJg0Bc2SewUYpax+4NAlNE9twEGHrp5qmfvyRmgnvfQ4EHL+9dLd3CRhtlCrWxo/raDsGd9AJHdLFKKHHNqD2GH/jSxdDu2p1YTV6XGwJkOUzLExEQiqDJYnE6NZCCVgG+6nj3ohfiTX/LYicEGbIpRQH+fI7D4wY68EOjDdfEX4Y0wQUl0dxPFndulUhz09KWWSdE9a3mYFiO5cuq9OcB3h9kuc/KU3NI6qN70l+gHH06NbbhCr0t6qOcMeS8w7m/0/WWvmS9LxD/ZJkpNPr9r6qZnZgm9hJZHvVvog94obW5w+u+lNxRothHVS5dO3kXFET+rRccQSyEXkNoKC7Dzp4nHoYDaIJn3dhN6LhCtX+86t9i2OQ9ivlt2JKYD5msIyfPFViWzKYlqFoYlJNWJ+EweVle6M2f+8DO2TCFsf1mxQ68LinD13B2xEFb7QuEDbukhFI8/pfciryfOipdx1yZLGc/6U+2ljdIiNC52dKVWGMz5CPIX72+mZET9Yi5Nc4HdjloDaeK3XIYFzGeJpp0db6TKzLJsj1kZx1hzVtJwiMUUZGA7wFb7otz7e0UMqiqy1zed+zgCFmAYcKPrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q9DVG6QOcqK0G2TADBlH8RrS9+oEuC2Ukp0zw65LQlHt6bBeEG1g/hmkcF?=
 =?iso-8859-1?Q?06eRj7vDbMyZkKNXn61it8zTHWyAGLEyxI+KL/kHSZX8qhZPAsSaa8eIah?=
 =?iso-8859-1?Q?KS/sPxO5S6g8Gzt7caEky1DTm6ZCBpirESMWsHY5HA79cFFdQyjrvsPzGB?=
 =?iso-8859-1?Q?TDlsJKdjoBu3G2nmajsk8y8PzIsXNwaEYyJPICukG4TlRxmTgyNs+IoVXK?=
 =?iso-8859-1?Q?PcxBB0jfd436bWUo5glG7rgPZM0TCO1haE99b+T5I3ZRU8a7+6id52blZn?=
 =?iso-8859-1?Q?wLG1YC5+A1Bf57Qof+6On3KEjPiZBoKJ2Lvof4bGl+sPTtZX+cDCQlUyS1?=
 =?iso-8859-1?Q?en6FyAszyuA1w/XK3RrDQBxZWh917epOsOo//57DHIM8Il2P6ARvqTASje?=
 =?iso-8859-1?Q?yiBY3r/Rv1g8RZC5r2nQxoSToHHWg6NZ5FLQHmc/QTClQhmSCUI/ayUtUa?=
 =?iso-8859-1?Q?B3AzMsmbs1HbH2ZLG6NmGDdKJtJeO8cktXyN85ufNP/PKL9dXjMHMI22dH?=
 =?iso-8859-1?Q?7feMpgvGgFgVlhuDmcXpNgCo4FuAbMxqRg0Vb5EhOMQpDO3bU+KMVIZsXN?=
 =?iso-8859-1?Q?3GDM5nd9j1FF+iq4BQThtjNCLe3lfn1KuvqYVgokVbj7qXj4XEf55E5nUm?=
 =?iso-8859-1?Q?HJ8T5qCXKxnZsc47G6nub4GAFC2ymqj5GOYu+SaPPuBO9+/Z+CMAqUOnDv?=
 =?iso-8859-1?Q?XO4+ZAIsPl2liXek/ciqFVD8SLClk+2zLe+WPJFmZFQyzTGBlKSP6OK5nQ?=
 =?iso-8859-1?Q?PXv+jW/Ye/i0JA/MDxr8vwT4vnSaKutQypKjdBUgQVjMd6XBp8E+jE95ZL?=
 =?iso-8859-1?Q?dmXuFgnHBuQyy/vc2m0K2cgw1CyevRxQIEiMsPhoOeSfRrHS9uaN4EpER8?=
 =?iso-8859-1?Q?IdQD7vM04bws/8h0YD7TmwlyY3IYNAjXuEQL5nXXVUhHIQusRMp+unO/ny?=
 =?iso-8859-1?Q?c0SojtjcSGgzXqOWRrA2scmHZNwRF2SMcHfz071cNu0rb0hj2A4Ho3aGZQ?=
 =?iso-8859-1?Q?Yo5yCraubfc+U2eZQQ9kBDIK11WGYQiUwbUWI/s829vyleV7Yo44CAh69m?=
 =?iso-8859-1?Q?rtuQ/Z3+8soIUFQvX4v1zJIOSh6UktkGPcMF+rhmeV99MWEB16JIB5eUXr?=
 =?iso-8859-1?Q?EKAWoKGAXh0ikUqgug/O1TlAmjrn8+oz6qwtl5NRq6ihTZNe4AhmI1qJyQ?=
 =?iso-8859-1?Q?WWUKs7hGDG3RcS1Uf5wE3QUFJiPymbU000M+1erfw85Wo/kBmuMTD7SBJU?=
 =?iso-8859-1?Q?EdgiPhIpLDxPXa/A7INQhTYwFhTtcoczjIaGp+EU3NQogJa+DiIwtPUjD2?=
 =?iso-8859-1?Q?Vs3HhcVj+Qida5l3YpTVppz31gqdH/KsM7mySuIhB5B5umFwcB3E/+ufgY?=
 =?iso-8859-1?Q?RGxVkpA5+MwsTX+sobXDw/skl8hy+QuW8M92T0Jq7cpHAVQailYhWVGink?=
 =?iso-8859-1?Q?9Dw91+UugjGmqyfvAQ3M/ci9LNmbofa3XLv58RE37g0mkRE7JaKtY8/fAw?=
 =?iso-8859-1?Q?i0EUncKRRbI2jvBcS2WbbWocwzYYClYluwMS83I3nf5BjaCbgmiY1575Dk?=
 =?iso-8859-1?Q?k959mXJo0auOuvNGf2uvI3rAMc2gT01ogiGlTaxrlpHeWrFCobTKjjeKhZ?=
 =?iso-8859-1?Q?GKxkreXIBnKyl9NPbSOiTpTuU4k5Q1VUgzMq0MEXXUqlEU0lwTOkHgQy2s?=
 =?iso-8859-1?Q?lzIk+xe0JpKzJPztRQ0oHkMaQye3NqjvDihpae/fdOAba2iutRX/h7A+r7?=
 =?iso-8859-1?Q?F2bxTYBqFaiwk3uisdONzkzBZI9+4w/x6Cw7onjXXZMjlaC6FlINRhekvt?=
 =?iso-8859-1?Q?aEzKHfxYzhjZVA0bZ+8FUUWR4aIbaIY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89db8028-c8a4-4853-6efb-08da16488369
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:54.9084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /z54Tw8zUc+WYO/yHn3RJfi/wNXy7Y+4SxTlF/duAOplOTQnAAaJ5dYRMLhOv5FH6Kxg8Q6MDxhY39zxLCmeDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-GUID: 4mO4FPcULiCSgLMWW4F2cAD-WVvrsxmI
X-Proofpoint-ORIG-GUID: 4mO4FPcULiCSgLMWW4F2cAD-WVvrsxmI
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Reworked the way mbind_range() finds the first VMA to reuse the maple
state and limit the number of tree walks needed.

Note, this drops the VM_BUG_ON(!vma) call, which would catch a start
address higher than the last VMA.  The code was written in a way that
allowed no VMA updates to occur and still return success.  There should
be no functional change to this scenario with the new code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mempolicy.c | 55 ++++++++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 24 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a2516d31db6c..a8f07b60dc6d 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -380,9 +380,10 @@ void mpol_rebind_task(struct task_struct *tsk, const n=
odemask_t *new)
 void mpol_rebind_mm(struct mm_struct *mm, nodemask_t *new)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		mpol_rebind_policy(vma->vm_policy, new);
 	mmap_write_unlock(mm);
 }
@@ -655,7 +656,7 @@ static unsigned long change_prot_numa(struct vm_area_st=
ruct *vma,
 static int queue_pages_test_walk(unsigned long start, unsigned long end,
 				struct mm_walk *walk)
 {
-	struct vm_area_struct *vma =3D walk->vma;
+	struct vm_area_struct *next, *vma =3D walk->vma;
 	struct queue_pages *qp =3D walk->private;
 	unsigned long endvma =3D vma->vm_end;
 	unsigned long flags =3D qp->flags;
@@ -670,9 +671,10 @@ static int queue_pages_test_walk(unsigned long start, =
unsigned long end,
 			/* hole at head side of range */
 			return -EFAULT;
 	}
+	next =3D find_vma(vma->vm_mm, vma->vm_end);
 	if (!(flags & MPOL_MF_DISCONTIG_OK) &&
 		((vma->vm_end < qp->end) &&
-		(!vma->vm_next || vma->vm_end < vma->vm_next->vm_start)))
+		(!next || vma->vm_end < next->vm_start)))
 		/* hole at middle or tail of range */
 		return -EFAULT;
=20
@@ -786,26 +788,24 @@ static int vma_replace_policy(struct vm_area_struct *=
vma,
 static int mbind_range(struct mm_struct *mm, unsigned long start,
 		       unsigned long end, struct mempolicy *new_pol)
 {
+	MA_STATE(mas, &mm->mm_mt, start - 1, start - 1);
 	struct vm_area_struct *prev;
 	struct vm_area_struct *vma;
 	int err =3D 0;
 	pgoff_t pgoff;
-	unsigned long vmstart;
-	unsigned long vmend;
-
-	vma =3D find_vma(mm, start);
-	VM_BUG_ON(!vma);
=20
-	prev =3D vma->vm_prev;
-	if (start > vma->vm_start)
-		prev =3D vma;
+	prev =3D mas_find_rev(&mas, 0);
+	if (prev && (start < prev->vm_end))
+		vma =3D prev;
+	else
+		vma =3D mas_next(&mas, end - 1);
=20
-	for (; vma && vma->vm_start < end; prev =3D vma, vma =3D vma->vm_next) {
-		vmstart =3D max(start, vma->vm_start);
-		vmend   =3D min(end, vma->vm_end);
+	for (; vma; vma =3D mas_next(&mas, end - 1)) {
+		unsigned long vmstart =3D max(start, vma->vm_start);
+		unsigned long vmend =3D min(end, vma->vm_end);
=20
 		if (mpol_equal(vma_policy(vma), new_pol))
-			continue;
+			goto next;
=20
 		pgoff =3D vma->vm_pgoff +
 			((vmstart - vma->vm_start) >> PAGE_SHIFT);
@@ -814,6 +814,8 @@ static int mbind_range(struct mm_struct *mm, unsigned l=
ong start,
 				 new_pol, vma->vm_userfaultfd_ctx,
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto replace;
 		}
@@ -821,19 +823,24 @@ static int mbind_range(struct mm_struct *mm, unsigned=
 long start,
 			err =3D split_vma(vma->vm_mm, vma, vmstart, 1);
 			if (err)
 				goto out;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end !=3D vmend) {
 			err =3D split_vma(vma->vm_mm, vma, vmend, 0);
 			if (err)
 				goto out;
+			/* mas_pause() unnecessary as the loop is ending */
 		}
- replace:
+replace:
 		err =3D vma_replace_policy(vma, new_pol);
 		if (err)
 			goto out;
+next:
+		prev =3D vma;
 	}
=20
- out:
+out:
 	return err;
 }
=20
@@ -1048,6 +1055,7 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 			   int flags)
 {
 	nodemask_t nmask;
+	struct vm_area_struct *vma;
 	LIST_HEAD(pagelist);
 	int err =3D 0;
 	struct migration_target_control mtc =3D {
@@ -1063,8 +1071,9 @@ static int migrate_to_node(struct mm_struct *mm, int =
source, int dest,
 	 * need migration.  Between passing in the full user address
 	 * space range and MPOL_MF_DISCONTIG_OK, this call can not fail.
 	 */
+	vma =3D find_vma(mm, 0);
 	VM_BUG_ON(!(flags & (MPOL_MF_MOVE | MPOL_MF_MOVE_ALL)));
-	queue_pages_range(mm, mm->mmap->vm_start, mm->task_size, &nmask,
+	queue_pages_range(mm, vma->vm_start, mm->task_size, &nmask,
 			flags | MPOL_MF_DISCONTIG_OK, &pagelist);
=20
 	if (!list_empty(&pagelist)) {
@@ -1193,13 +1202,12 @@ static struct page *new_page(struct page *page, uns=
igned long start)
 {
 	struct vm_area_struct *vma;
 	unsigned long address;
+	VMA_ITERATOR(vmi, current->mm, start);
=20
-	vma =3D find_vma(current->mm, start);
-	while (vma) {
+	for_each_vma(vmi, vma) {
 		address =3D page_address_in_vma(page, vma);
 		if (address !=3D -EFAULT)
 			break;
-		vma =3D vma->vm_next;
 	}
=20
 	if (PageHuge(page)) {
@@ -1482,6 +1490,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	unsigned long vmend;
 	unsigned long end;
 	int err =3D -ENOENT;
+	VMA_ITERATOR(vmi, mm, start);
=20
 	start =3D untagged_addr(start);
 	if (start & ~PAGE_MASK)
@@ -1507,9 +1516,7 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned lon=
g, start, unsigned long, le
 	if (end =3D=3D start)
 		return 0;
 	mmap_write_lock(mm);
-	vma =3D find_vma(mm, start);
-	for (; vma && vma->vm_start < end;  vma =3D vma->vm_next) {
-
+	for_each_vma_range(vmi, vma, end) {
 		vmstart =3D max(start, vma->vm_start);
 		vmend   =3D min(end, vma->vm_end);
 		new =3D mpol_dup(vma_policy(vma));
--=20
2.34.1
