Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0D957ADB6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240010AbiGTCSy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239365AbiGTCSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878B2599E0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:01 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26JKlqhb030726;
        Wed, 20 Jul 2022 02:17:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=XH/TN7gBJ3OXti9gxwmGjrCIxV4DxSH+OzJJS/kyWLc=;
 b=LiQXzx8LEkuc3GCKTNR3hih3YTbLL/9DVlYwF3gC/plIJc15noWwpPRH6Sp71C7hN+0J
 eDrqdj5u7Eo8HfeA++1uZ1lkz38c7J/jAcvn9cKX9HNjUyP8D7pn0LKHWOB6t0UMXyuX
 leNqqKn+VGzEq/KUgMyA7FvdM3HBJo9kMzkIP5L6yIji4QcckInMdYvqIJb8OYi57wE8
 j8+cMXzwn3LLqJt9gxp7kvuPbn+hyA/WSKnn3FzbBZIVvEd39PAJQhriRpxlsMbcAMDP
 2jI2zwucdA8CSkjvNADtpDP/LbhZO67Ac4M9TZ3y9Kf2lpYTwvpgTYD73P0bm2+63Kz9 cA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc7yvr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:53 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLL0022321;
        Wed, 20 Jul 2022 02:17:53 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IksNJGHcC7mHW2P73ORm8k7/mcLPvZW22KpClbUqQW1T2Eam2fCKYRsPznqNqdRVqF3sDTweknB089SJH8pd91ue7YUM7ux3O/TO9lLaoO0UZed7sl3YbtDSQRfHHy3Orxp5j3RhaW1E9CBhxG7CK14BFFvtDqnnmRRoVVbZi6Adh5MxKXNl6C6dArs00FfxEkNTJCB/Iwcy3HCDxIuKBINSArlTxO/yflOceD3qsSRcg9xdE+aqHkuPz2YqZePomvoXKoTG+ibe/peB5OcFS1amNriUmqZcdL0XIKaFgLKuTspKhhEL8Cu224zhv0qG4mSoPMopF1fI8RvyNPHTwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH/TN7gBJ3OXti9gxwmGjrCIxV4DxSH+OzJJS/kyWLc=;
 b=kzQpZvFyaLgQlSSAOrhpieuS1FFateuQPiavzgRG+siWwWKLSYFVHOEtAbqe+xtXCoY/Gf/6lCOtyXBmek7ZjsefFWZ45mhCzu3lGvQo/xzNQEX+bsFz5lwTp23mQgkvzAi8wvxUsaTbPOHZjV0g4G09sxVbCQrCKguX/DEyTeVnF/rvWNf+vdIVgRk/IlDPJiCb0zvOco0vrSNNjK0YuRGCVnrO+DGl333/Xl19SQPKGEeNx+VQ6GRz2cpVleHK7yVoolMMsvM1eSvci0pU4lSW1Q6wPjQVYpnBaQa5kIhFQ61/L7+MKEzFdSxhqRs5IANiVQw2tssX3gcb0C0o5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH/TN7gBJ3OXti9gxwmGjrCIxV4DxSH+OzJJS/kyWLc=;
 b=Cb+ViEKdcn2LEI5JVE4LMACEoOY+rzvoRmvrxrsA8+a66UhYTb55YtwuA1yke7+5QB8qP7kfllFoaS0g1hNJjdbP+iAQ7txU/QWtG1gtWSbVERRjN8PqwaieHvHRoR6Xt9TzxVStW/SCOogT6ao7f7or50/slBMowlKHqjPnUgg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 13/69] mm/mmap: use maple tree for unmapped_area{_topdown}
Thread-Topic: [PATCH v12 13/69] mm/mmap: use maple tree for
 unmapped_area{_topdown}
Thread-Index: AQHYm97n2PEqoIQYDEuB64QieC+b+A==
Date:   Wed, 20 Jul 2022 02:17:47 +0000
Message-ID: <20220720021727.17018-14-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2edd73c5-537a-404f-21f9-08da69f60b5e
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: athHb7PT0FonQ5NKuD6iL05ooJmBfKPOnL20zNQE3wJS+s+HtFMEpb+b+uibKD0/434+1xLDny+pGYySadmhOuzfBAPBgiGVeOicrucSgFTED8SawLfkhBbDcnwFDQn99lj0vTQ4CvzcV1+9JR4e1M9+13w8LljSunBa2rTtdLEp7uhglYPJIR9RPp87SWsCRSSuBMxeDekjf6WHCo2+b2XUOsR3eBhZNZWS6CkV1ZII6U8vaxvyFb2ZPipDy/diGLMbCaqFyyDB0+KzHTlDHmBmAyp6P7xTut+lYyiRnhjhebx9r2mUhAXWTuNAjNxLr9bq4zYAj6tfST1TPwqfsFXRX6twDovJVNYErO49X127IuAe1Xm5Zq5ELYNbLlu7H1k/cCsEIq9WnHGRxJZLwBSvyPrC4cKty5PVkKSg3x3v9h7B+W99BDlAoDo6yMmarJ1ARkCpWTnk/jynM/hZlTpGappbkAriaMYnMc5GpqF3qj9iZGj0oUvj8fHHtq8pQCmdcYYmnM7u3GIePVBOjqoZsgqMFZweqmGHQZtGfKLOuVa++33+tHPm5XEFe2t7QILZW5LIK34p4FZPojF2SFiMbu8HhqX2ggbtAdgbjg/2Ie2zJs5aJG3vQ7+OeIhWTnroBwBvisieKtiw4nW7Vf6Lp/buPjiDoFkw19QnYu4Olh/7kjWNh0qviX9Sg6M+7RorkHYzYhLjRD9f7+ErEvdD0mVbORL5AiMOOpNmjTj4usGAcaHjz/WKFQZojG1q/pIOk9Ia0P3V7PZ6zvseG9cDdo57jZIabgGM77PvbVWdUE/22B1bjEfuXdWBdJg5T3YiHwy78UvsIGXFY0UG9WQC6f5hpPEoRTO2y8lM/LEGOxs6aJ19U+Y6q8MTEMbg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QvDsqzy8nKng+Xjn5by4oQGUwxp0odIifi64BDcoB5mh08qQ7MQoGnkvRj?=
 =?iso-8859-1?Q?ZJjX6eXsrp4p//btF9L3X4vFkd8XZhmfNtco1ziihs/2ETnDhFcMFvRAb1?=
 =?iso-8859-1?Q?F5Ny3VMvexvrjrk8terpTnwad0UPRVWhuhvqbDMQml00LKDFxLnBQpehpo?=
 =?iso-8859-1?Q?M12y1SCrSqjN3yAYSuzJqLqyq9x1fq3A6UNJh/u3VIPHgg+93WC1sdARNn?=
 =?iso-8859-1?Q?HQgc5iPjrCi4KoftJm/Fp6IyOyJql8u2u15xazQk+vwI2ojd8el9KMX8co?=
 =?iso-8859-1?Q?52XB2AhvE3TVGohtk+CoHEBSLXRjz4YfIXHCzkJThJYxT0EmJkfgHx2KeG?=
 =?iso-8859-1?Q?gsGhLqF+SgigGrhb89/rSR+S6UIKDrzDWRbVMeS8pLZ0njCwrARC47UY1d?=
 =?iso-8859-1?Q?6YBU52OufiXUPo3v719zV+gUGDUPy1RuwIzLmUyXG/o6l4JlOQMk3BMYlz?=
 =?iso-8859-1?Q?8FMt/0sfbDu64jgOC5JokwkDp8BxFfjsDFqSWqQgkG/2b7sSsQaDJ/jn8R?=
 =?iso-8859-1?Q?3rgIYIut6iBbfHfbXwvrf5DoGeLatuOt89wqQiuQkd18y6Lri09iXlqX7w?=
 =?iso-8859-1?Q?WB03xAO3nAqkAQkpokRGmuev52g9DbbmDGWU6j6rBxGGajrRnzdg9NRz3c?=
 =?iso-8859-1?Q?LBW0S4wKzQRwEUgOpfqbUpGbw7YeIjyYlkMXa7ozVwmiBcpk8IinnFXbps?=
 =?iso-8859-1?Q?5XB5enEQ3oKmEjkQtgRbFJyFpeBM43cV+y7qHWvr8sz+DaoO7f39zvbED3?=
 =?iso-8859-1?Q?oQFAnVqGRmG9RylmejhzS9DLZnui3Mr0zpIXYFYJFfPeP6celtnXcOTEIS?=
 =?iso-8859-1?Q?3ESTKONIZ4K2A/t6+f7Y0MenK2pGoxvjK3SjnLFPU8V2QAal/vLlP+TtER?=
 =?iso-8859-1?Q?j82PimTPFUEi+gnCKNLsrzOAQSRydNvuftRRmihzm0iG0KbiwfFuQZ9QpU?=
 =?iso-8859-1?Q?cfc+qiMEueJbWqRvs8kyDct4ND5Fymbm32dk08u47dseSfTpP1FRFjetHX?=
 =?iso-8859-1?Q?jTcxBQE8l8nbSweh7B4cvlO0ZLWLWtkpF2tj3QcmVyMKWYskfoDqRLnd1Y?=
 =?iso-8859-1?Q?U/LYnTI1/csL/jr4kcPESuOm0qq7CF7riacaYI21uDrDw3BIF/Z82hxM1z?=
 =?iso-8859-1?Q?sRM5+8J+rROamicCv5MFGJEONwGh21ObT/aWF0pfkabMWNSFArFDbZDIe5?=
 =?iso-8859-1?Q?DK8eb1xcRV1dXjEeELUzOofl9gYX56+vMICy8uFkICmzux2aWNVoy3Rqdg?=
 =?iso-8859-1?Q?pNvbWQaHc6E5IcVYIYJctJvr7iw1PixXJMCey9ziDGX6/qPPWs4Yfh8KC0?=
 =?iso-8859-1?Q?DaA0vKNkQp80fDxfNlXqRrhsJ61N1Vc+7OGKSsCgG8r6cC9hducrKuMCFH?=
 =?iso-8859-1?Q?GT4fS/rTDWMDTr66TT7F+zwg6PhUEHRwpeoBMYpyxMICnpDePO6oibZ6RP?=
 =?iso-8859-1?Q?jR/lqLlrL7qCydeGmlabQBf9NjPSkG2PBUH/P0Ks4ITlYoAg3OX+nUESm2?=
 =?iso-8859-1?Q?xhk0lWGF40i+j+KjhzeLkFdKd3pnAR34DXlg7mt/y6nC4GYoVW/Rou8Uae?=
 =?iso-8859-1?Q?Eg4Fba9xOsAwjJSRwO8tI87QuSiZ7c/sH2qKteCRssD/C8LdF1WQfXQpdL?=
 =?iso-8859-1?Q?TcTSEHmKJeXl6TrxRUCmiw4UVbg2eCgQEhSmd6QiyLi6zvzQx8+KIO5Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edd73c5-537a-404f-21f9-08da69f60b5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:47.8063
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q7nvq+iop43AZYK7k6pqvsm/GcH01C9O+M15/1R3fBMUgB/bWCkhEvpz2vTw1lqCjmcstp2Je0BgE0XLr4i+aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: t2lTl7pKVjHma7BSFtIPgEiI2hpNhPLx
X-Proofpoint-ORIG-GUID: t2lTl7pKVjHma7BSFtIPgEiI2hpNhPLx
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree code was added to find the unmapped area in a previous
commit and was checked against what the rbtree returned, but the actual
result was never used.  Start using the maple tree implementation and
remove the rbtree code.

Add kernel documentation comment for these functions.

Link: https://lkml.kernel.org/r/20220504010716.661115-15-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-14-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 255 ++++++++----------------------------------------------
 1 file changed, 34 insertions(+), 221 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 12abf6a75690..ad90839f7f1b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2058,250 +2058,63 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
 	return error;
 }
=20
+/**
+ * unmapped_area() - Find an area between the low_limit and the high_limit=
 with
+ * the correct alignment and offset, all from @info. Note: current->mm is =
used
+ * for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	/*
-	 * We implement the search by looking for an rbtree node that
-	 * immediately follows a suitable gap. That is,
-	 * - gap_start =3D vma->vm_prev->vm_end <=3D info->high_limit - length;
-	 * - gap_end   =3D vma->vm_start        >=3D info->low_limit  + length;
-	 * - gap_end - gap_start >=3D length
-	 */
+	unsigned long length, gap;
=20
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
-			   length);
-	gap =3D mas.index;
-	gap +=3D (info->align_offset - gap) & info->align_mask;
-
-	/* Adjust search limits by the desired length */
-	if (info->high_limit < length)
+	if (mas_empty_area(&mas, info->low_limit, info->high_limit - 1,
+				  length))
 		return -ENOMEM;
-	high_limit =3D info->high_limit - length;
=20
-	if (info->low_limit > high_limit)
-		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		goto check_highest;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		goto check_highest;
-
-	while (true) {
-		/* Visit left subtree if it looks promising */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end >=3D low_limit && vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-check_current:
-		/* Check if current node has a suitable gap */
-		if (gap_start > high_limit)
-			return -ENOMEM;
-		if (gap_end >=3D low_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit right subtree if it looks promising */
-		if (vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				goto check_highest;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_left) {
-				gap_start =3D vm_end_gap(vma->vm_prev);
-				gap_end =3D vm_start_gap(vma);
-				goto check_current;
-			}
-		}
-	}
-
-check_highest:
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	gap_end =3D ULONG_MAX;  /* Only for VM_BUG_ON below */
-	if (gap_start > high_limit)
-		return -ENOMEM;
-
-found:
-	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start =3D info->low_limit;
-
-	/* Adjust gap address to the desired alignment */
-	gap_start +=3D (info->align_offset - gap_start) & info->align_mask;
-
-	VM_BUG_ON(gap_start + info->length > info->high_limit);
-	VM_BUG_ON(gap_start + info->length > gap_end);
-
-	VM_BUG_ON(gap !=3D gap_start);
-	return gap_start;
+	gap =3D mas.index;
+	gap +=3D (info->align_offset - gap) & info->align_mask;
+	return gap;
 }
=20
+/**
+ * unmapped_area_topdown() - Find an area between the low_limit and the
+ * high_limit with * the correct alignment and offset at the highest avail=
able
+ * address, all from @info. Note: current->mm is used for the search.
+ *
+ * @info: The unmapped area information including the range (low_limit -
+ * hight_limit), the alignment offset and mask.
+ *
+ * Return: A memory address or -ENOMEM.
+ */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *i=
nfo)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	unsigned long length, low_limit, high_limit, gap_start, gap_end;
-	unsigned long gap;
-
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
-	validate_mm_mt(mm);
+	unsigned long length, gap;
=20
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	/* Adjust search length to account for worst case alignment overhead */
 	length =3D info->length + info->align_mask;
 	if (length < info->length)
 		return -ENOMEM;
=20
-	mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
-		   length);
-	gap =3D mas.last + 1 - info->length;
-	gap -=3D (gap - info->align_offset) & info->align_mask;
-
-	/*
-	 * Adjust search limits by the desired length.
-	 * See implementation comment at top of unmapped_area().
-	 */
-	gap_end =3D info->high_limit;
-	if (gap_end < length)
-		return -ENOMEM;
-	high_limit =3D gap_end - length;
-
-	if (info->low_limit > high_limit)
+	if (mas_empty_area_rev(&mas, info->low_limit, info->high_limit - 1,
+				length))
 		return -ENOMEM;
-	low_limit =3D info->low_limit + length;
=20
-	/* Check highest gap, which does not precede any rbtree node */
-	gap_start =3D mm->highest_vm_end;
-	if (gap_start <=3D high_limit)
-		goto found_highest;
-
-	/* Check if rbtree root looks promising */
-	if (RB_EMPTY_ROOT(&mm->mm_rb))
-		return -ENOMEM;
-	vma =3D rb_entry(mm->mm_rb.rb_node, struct vm_area_struct, vm_rb);
-	if (vma->rb_subtree_gap < length)
-		return -ENOMEM;
-
-	while (true) {
-		/* Visit right subtree if it looks promising */
-		gap_start =3D vma->vm_prev ? vm_end_gap(vma->vm_prev) : 0;
-		if (gap_start <=3D high_limit && vma->vm_rb.rb_right) {
-			struct vm_area_struct *right =3D
-				rb_entry(vma->vm_rb.rb_right,
-					 struct vm_area_struct, vm_rb);
-			if (right->rb_subtree_gap >=3D length) {
-				vma =3D right;
-				continue;
-			}
-		}
-
-check_current:
-		/* Check if current node has a suitable gap */
-		gap_end =3D vm_start_gap(vma);
-		if (gap_end < low_limit)
-			return -ENOMEM;
-		if (gap_start <=3D high_limit &&
-		    gap_end > gap_start && gap_end - gap_start >=3D length)
-			goto found;
-
-		/* Visit left subtree if it looks promising */
-		if (vma->vm_rb.rb_left) {
-			struct vm_area_struct *left =3D
-				rb_entry(vma->vm_rb.rb_left,
-					 struct vm_area_struct, vm_rb);
-			if (left->rb_subtree_gap >=3D length) {
-				vma =3D left;
-				continue;
-			}
-		}
-
-		/* Go back up the rbtree to find next candidate node */
-		while (true) {
-			struct rb_node *prev =3D &vma->vm_rb;
-			if (!rb_parent(prev))
-				return -ENOMEM;
-			vma =3D rb_entry(rb_parent(prev),
-				       struct vm_area_struct, vm_rb);
-			if (prev =3D=3D vma->vm_rb.rb_right) {
-				gap_start =3D vma->vm_prev ?
-					vm_end_gap(vma->vm_prev) : 0;
-				goto check_current;
-			}
-		}
-	}
-
-found:
-	/* We found a suitable gap. Clip it with the original high_limit. */
-	if (gap_end > info->high_limit)
-		gap_end =3D info->high_limit;
-
-found_highest:
-	/* Compute highest gap address at the desired alignment */
-	gap_end -=3D info->length;
-	gap_end -=3D (gap_end - info->align_offset) & info->align_mask;
-
-	VM_BUG_ON(gap_end < info->low_limit);
-	VM_BUG_ON(gap_end < gap_start);
-
-	if (gap !=3D gap_end) {
-		pr_err("%s: %p Gap was found: mt %lu gap_end %lu\n", __func__,
-		       mm, gap, gap_end);
-		pr_err("window was %lu - %lu size %lu\n", info->high_limit,
-		       info->low_limit, length);
-		pr_err("mas.min %lu max %lu mas.last %lu\n", mas.min, mas.max,
-		       mas.last);
-		pr_err("mas.index %lu align mask %lu offset %lu\n", mas.index,
-		       info->align_mask, info->align_offset);
-		pr_err("rb_find_vma find on %lu =3D> %p (%p)\n", mas.index,
-		       find_vma(mm, mas.index), vma);
-#if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
-		mt_dump(&mm->mm_mt);
-#endif
-		{
-			struct vm_area_struct *dv =3D mm->mmap;
-
-			while (dv) {
-				pr_err("vma %p %lu-%lu\n", dv, dv->vm_start, dv->vm_end);
-				dv =3D dv->vm_next;
-			}
-		}
-		VM_BUG_ON(gap !=3D gap_end);
-	}
-
-	return gap_end;
+	gap =3D mas.last + 1 - info->length;
+	gap -=3D (gap - info->align_offset) & info->align_mask;
+	return gap;
 }
=20
 /*
--=20
2.35.1
