Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1605759C24A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiHVPMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236408AbiHVPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03003F32B
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:06 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEphqe016577;
        Mon, 22 Aug 2022 15:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2uV31u87AF3Rn/66BNAjxej205z6QAkR7Nr9q92DzJY=;
 b=C0lmGhjZMv49/wpsqaTikMJv5qVP1YbNt8H9fnQXQSabClZQHh42NAaRrboeh3SYal8A
 D0dce6Z9HIohUNEoPuzx8+ue3b0pf+orJizHYc4u/cFFyxuiTTyiCAkRE28hp0yDFr8t
 9V0lI6GA/68eEgR8i+VrH9URp2emZHYxfiTrK22OfbuGCPjP+DJlDRPS4HseqyVo1ySo
 7AikUtNQ7eC4hRz8+hvDhrZoZQ8WSP8/cA32u8uGE6LdFtWCZFFN9maVJxKgUjJEYiTw
 G4kHVLmXdMzbRyYi7HZ15sFI5uNp+XpIsY5mkuPcDKeZiCo1uo8QYsCf0+uYp2T2u2ii jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681jr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4Na3026712;
        Mon, 22 Aug 2022 15:06:31 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8bef2-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So/Y6QdcvCS8+3EJzQHLDYSKZJod2OrzEk45+7tt10N/Sy4XEzMgP4QMMUf3YbaRscMCx5hsGPGLX4NABwS8ee+27b6j4MZfti/9NPpx1BW6tPw3nS+cZo4P7SZDXG5R5CsUbJblynMiz4m466m+JsNHazZxSrJvcnthz2UV/LE1sy510KL6nVolPbeVedI4CmvIUhSuPI/5ZAC8JfcTvFmRdaJ756A5FhnjCUML+NROjJtQENfMLL3OCr3aRaEqhEazQr7Ytw+ePEsI42CV+5g7cJed1Pcx0b0Bctne6shw8j8V2NsWtmn77xEfi1nzIxDwTyyd/NCfet568DUwEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2uV31u87AF3Rn/66BNAjxej205z6QAkR7Nr9q92DzJY=;
 b=lOV1ymbfuS9xVx5Wn4S9C+s9eM87JGMp2N5ox0rI7t06VOUZp6yfXg8lSy20i1iQvIBtkkL1px/G0llzDZYJKTIFryyaKGMXitGRvMjQ2wz4P9p1nHV7A/sIFqWfACFE+i8EhnMlbosAErYjb8U/ZWcDnzzlT8uMD70KDGrkNQV905rJOc0pVSH2262JzpAyaQ9FdKNHnpTzZxf8D4BkFKMYd97YlH9PwInKdhqqOUTa0n1nR+WFyzAd78gGJryJAZ0T1HALGmZvNwC/piFgiCVNJkm7/cntD8ii2xlJA+1pv1hQcE8yDeTKzTv9kEOzv0bPdACCSgUUU55GvnWLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2uV31u87AF3Rn/66BNAjxej205z6QAkR7Nr9q92DzJY=;
 b=BYgWN1UCltvGfM3BBXszVL94kyq+jRXLd9hEc1lXfHrvp8V2CuSgsxN+3ysBPri2e4FUaJBt6ieWLPautn8vtOQ+74oCV3IeUhzBjV0DnTzz/SJgsnUHCrx2bVCqtBKXft9DclcG4P2l4q60rWy8sDqRVIeVD2VaxybZpJBzKyQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ1PR10MB5931.namprd10.prod.outlook.com (2603:10b6:a03:48a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Mon, 22 Aug
 2022 15:06:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:06:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 41/70] exec: use VMA iterator instead of linked list
Thread-Topic: [PATCH v13 41/70] exec: use VMA iterator instead of linked list
Thread-Index: AQHYtji/QwRl6lvy/kGVRJT22U2EOA==
Date:   Mon, 22 Aug 2022 15:06:25 +0000
Message-ID: <20220822150128.1562046-42-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34eddaeb-bd4a-4daa-ac02-08da844fe27a
x-ms-traffictypediagnostic: SJ1PR10MB5931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /iudbGW9GOf5hAotlm+pXbK9WGaYsPvra4q2C9FsjCNKb7m4bj0gf0DATsgRNCNexBt8PpVijvtxkDJ16UO+pM+zGiEvFT7eI6/mz0z9HPKWCyp0J/nDlyBJSimkhuC9Ai8f1iiipev245X/CgCuwrI3oxCzceYPeHP/YC0nqJTCvy9alqyi9xHx1upDqS5BKPcxt4CXb82KHGqbab/jaEBff1CFeEz0EeJCicFHdWmh0BHtLo2/3GfWbVpc/H6KxWoCl6kMzmsVSvyNZ7nq0DDir/B/sfwi+hGaT65MuU4DNBXnT/aymWrdR1CnLbEdbAuGEVl0M6jFtPH9s1fHdwytZqwS52d0UjDBucRVr6h0CkM2oUsbSvkzRpJJuMkf4AsTzfUxhkR7zh5A4rHVrVVQ7e583LimT+iRfD5C/3H+BjOwXlLvVBmQlZEOd01Jb7gftJNZUJEXBSW+eEGDr3NXJaA93obuaATnI736yJhUfwkBjobROG4U7SJoPFXVcm/EJa7I8hv3D0sJxfgCDcXACO49vQjcQUv/8QH4yzU1oVetv2ClV6Crj0pb6y5Mtav80RNeTPh9ofzcuexS6UDkW0Fr7m0QHh0sPSmcfzhpU/QBCpZaqzjP2B3KRE7p+wHNVVdj5i6emeyZQlNz/NPX+2+qDOggHqIFLRwEhWsOgZFAY14LIry9gXX4vOddLkwzcVaLWec+nQueXywAX0yNxIGhuq6te/O+4hiWU1h/yxVn8MROzSpSRs2jPAv+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(39860400002)(136003)(346002)(110136005)(83380400001)(6506007)(54906003)(6512007)(36756003)(6486002)(26005)(5660300002)(478600001)(41300700001)(107886003)(1076003)(186003)(66946007)(66556008)(66446008)(44832011)(4326008)(64756008)(86362001)(2906002)(8676002)(71200400001)(66476007)(38070700005)(2616005)(76116006)(122000001)(316002)(8936002)(91956017)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hxV5Pq0QYwxh3h4c6qH3Oq5UbKJdWkCMvgtNL2qyvfRQQu7BW+oUt+vLA3?=
 =?iso-8859-1?Q?borO0pt0vjgkNYM4fkT8t7t30+tF9hh67wSC+IzvtWHU+DxXb2Hh51/aeG?=
 =?iso-8859-1?Q?/yUZRJIWyqmJW3J29rdaEImnlW8wgTuA1030O6Hghtqw0+frSi52v0tfuD?=
 =?iso-8859-1?Q?Rx6i+b2DglZ5+q8IPuAgz45ULloHmany0b8SJH9AOVT8TbMRG0hVeIATqd?=
 =?iso-8859-1?Q?BFpV4QBOU8iQTMpaR7doRDYcueDh7smX8hmeK4Bi9SVcT95UpCVNQuT8uI?=
 =?iso-8859-1?Q?xT1rZldx8hp81zs4LbG3/dPqPcoWPB07YS5e/iiz2IKjfWuWVstDO2VuDE?=
 =?iso-8859-1?Q?3fPZokT2SjWYuR/6k4ayawrTTxBTe+0iREFT0YUC6Tc23i3Mw4zosQxX/o?=
 =?iso-8859-1?Q?CTPshEPsMN3NcG1PFgypNLGT70QWTdfHyqmhRbLoZ1AG+ekKLXdDlXCq/2?=
 =?iso-8859-1?Q?KLztEzX2LOz4qmOZsbXsIXloGMr/9q+N8HyIvlFTND6yh1r3YVR779X7IG?=
 =?iso-8859-1?Q?G+zlX7TFtl1CfXNVUaLKtLHnKfWXocPCEjE+FuiLVqxPaKFkjZheFAKWOd?=
 =?iso-8859-1?Q?4yCPkGEvvVYNjNq5bo9ukbzKV1ebURg2sIDyqeyETKVYgD7s2ZkpZNUZwX?=
 =?iso-8859-1?Q?saJXOdDxrBYGZI5OaF5BLVXtqu3YVwU4PTXQsg2JvmhOfnl5xxCv4dEs5g?=
 =?iso-8859-1?Q?j0pJi56ilJWJw/iuu5KHy8+TDlQXYyIb8KC6aqKijaPByHSZ3d2B9S/Vxx?=
 =?iso-8859-1?Q?XYgk4n+t5+dOfZ3bQIDtTI2qN/vrYNjPsaSSpLKHke5PrAHxcBEwxLT0Qb?=
 =?iso-8859-1?Q?XuQKNdYlRXzbkPRs4SzXAYNqbESXHQA5uIN+FwT/imuCvH9m/3aKdGe/Z4?=
 =?iso-8859-1?Q?tVDA8qM+PZMkwQEoCta8FucaZ0d3urZEliqWVuB1dyfCLGeEkZYr2T7MzT?=
 =?iso-8859-1?Q?ODkXvWdB/AugJtDNsMsSnaG/FQQz7d+QP2BK1XiOW3/5P+pz2wT8zipEeF?=
 =?iso-8859-1?Q?T8GbhLIX9i9efeT4ma24ItiZvXh+MEinBVfzPMcs03b1s+wO9woP0hhxqk?=
 =?iso-8859-1?Q?074VkLSS5rneAmdDR+h/+QY8lSxLPgfQODrq5U7Z40LaJm/B4CEw6hkpD3?=
 =?iso-8859-1?Q?qTCG4Gn1eaYdgfbXyBRaIeX5m80vdNzDx/9BYGTLa3RzRDd6SWkZI0Ilmj?=
 =?iso-8859-1?Q?+18YMPpWejmAmqtC+oJy6eNT93g6rOBhxfEoGBuBxRmwqSqjDjjD5sFqiX?=
 =?iso-8859-1?Q?jg9Nj2zQ+0iVstgR+dMbgQ4qGzpA5lLVN6mowxZUiuZjZa/QO69ldxhlna?=
 =?iso-8859-1?Q?sE8v1nF3dJu9UTkuEbsVpbHOtMK7X1qi0MYq/pPyT9NiuXaWY9gudkNpxX?=
 =?iso-8859-1?Q?hmfSXZx1+m76/0csNaeYP3NhPvKLKvM7DKk4Dw6eg1EhUDA3Wu7C7rVK3n?=
 =?iso-8859-1?Q?Om1QfDyGA2ttu1GCWS7P8hY/Qab6CE+jrjneEqTjURg3iGloBbyUYKKUu1?=
 =?iso-8859-1?Q?HMkXk8Snfe0iZIsx+CUIS7GXhv3TEXydoqqPDzjrJoUN9c7fYL3gpn1aN0?=
 =?iso-8859-1?Q?D0FKvGXZ/2nCn59IiyVxpkwNMkduG5WwVMBzMvU20QO9ewPGOOZCpyVhk+?=
 =?iso-8859-1?Q?HAtYMNeuMGqdHp71gjsMpUVH02ujnuDPtAY+d8le2c3nzqprBu1cn/0Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34eddaeb-bd4a-4daa-ac02-08da844fe27a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:25.4882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VoFJGF9rJ66NHz1Own0aN5c+6t2LksPwWKCTn5Two7wJje2B+8TAm808ov+y3/gW9Id7ci9brQ8jtP+BKKn6aA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5931
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: Pzvn2_P_Cu6SwWJekKlViilhhCnYgGpC
X-Proofpoint-GUID: Pzvn2_P_Cu6SwWJekKlViilhhCnYgGpC
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

Remove a use of the vm_next list by doing the initial lookup with the VMA
iterator and then using it to find the next entry.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/exec.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index 55879fb1ce46..dbc61a4d4c62 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -683,6 +683,8 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	unsigned long length =3D old_end - old_start;
 	unsigned long new_start =3D old_start - shift;
 	unsigned long new_end =3D old_end - shift;
+	VMA_ITERATOR(vmi, mm, new_start);
+	struct vm_area_struct *next;
 	struct mmu_gather tlb;
=20
 	BUG_ON(new_start > new_end);
@@ -691,7 +693,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	 * ensure there are no vmas between where we want to go
 	 * and where we are
 	 */
-	if (vma !=3D find_vma(mm, new_start))
+	if (vma !=3D vma_next(&vmi))
 		return -EFAULT;
=20
 	/*
@@ -710,12 +712,13 @@ static int shift_arg_pages(struct vm_area_struct *vma=
, unsigned long shift)
=20
 	lru_add_drain();
 	tlb_gather_mmu(&tlb, mm);
+	next =3D vma_next(&vmi);
 	if (new_end > old_start) {
 		/*
 		 * when the old and new regions overlap clear from new_end.
 		 */
 		free_pgd_range(&tlb, new_end, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	} else {
 		/*
 		 * otherwise, clean from old_start; this is done to not touch
@@ -724,7 +727,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 		 * for the others its just a little faster.
 		 */
 		free_pgd_range(&tlb, old_start, old_end, new_end,
-			vma->vm_next ? vma->vm_next->vm_start : USER_PGTABLES_CEILING);
+			next ? next->vm_start : USER_PGTABLES_CEILING);
 	}
 	tlb_finish_mmu(&tlb);
=20
--=20
2.35.1
