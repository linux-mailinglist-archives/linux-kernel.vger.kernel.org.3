Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C90A5AF505
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiIFTy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiIFTvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:51:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D67D816AF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:09 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdbZ3029984;
        Tue, 6 Sep 2022 19:49:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=wft9YTWZ//khPNyIGGbmwJg+fnMHVzSC1hPHptCZuSI=;
 b=kIO+KLhSFt08CklOrxTWiJSGpL2VPezPqLWTRIPjuu/SbZMnfOJEUrq5GzzO/wM2Zwf2
 zrNn0PeZx2Zy5zCZuhg/B7nV5bHLC0yP07Ng551mEP0vkX9WxW+ATEhODClKKGzURI/z
 09j8Aw/HdaD0DrEkvgNgob/sgS+kqkj+MydeHeOla0uT6nYgTWu6kRVuE3/Q8ySk3GNj
 e+VDO2zS+j7L6FFVgiPjGshaOf828BBXll8vs0dnynEHHh76wUf9+TQLobi2p43tKuUB
 eaiU0gBHtUbTKmx9LFMvqoPyVoREd6wFjh2J59h+pEZWnXHC8OyscWdICdGowTYXUsrX UA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:50 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286HF67S031251;
        Tue, 6 Sep 2022 19:49:49 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ahkd-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdomeAuFIe2cYcMSlxIv/kSfzVgYOeu0UclcRpv1Qhf08JsFwOYo0jHqe7QypPBXfSeLxrkO9KeRk3knnVb9b0OAGctEjtFcVZ6mT5eqDKfw5ot3+FuoqrO3qL+MlX178BAXqZZEspVKeiNy8axvEVzG1cI2ogpz3Q53nRXEzJKRl6ls0RK0G/y945mZL411TuYePB9jR8/2e4V8xcSNVY4BDwBRREhF2N1PVev2xmIeJuaRLYhmIHg2m2GPTRl1CMfeV9pWViksGRrnKMazxZNjEMa5VRHosdfDnvkIakEzGfj5dKjyqFp+A/I83L397ziMrw8I2ZNs+6eL4t2c5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wft9YTWZ//khPNyIGGbmwJg+fnMHVzSC1hPHptCZuSI=;
 b=iHu2obQ0y4KwVc+Hql6+xVpsl6TSENM7PPOEQ/V+XZAIwUiknVnsP9E1bzQkeTen72rdB0CsH8h4exzpZTeUIC2BYE7d1hBNIMG1rULAA4pSWrbxn04obwWj9TXFIhDF5Ru0rVFJeRThIHKa2QN2j9NYPBwjJOZPqWa+65qaMCTc6a+98qVNxOW+eTFfdBtBIi7RBaFDOagShQZNvDmjRBnzbe3GN68uEuf1jiyzp8gNv0qb0iZrFff8YvCDHTtMmzqJdiJEkVft3RUCQ59FEnmDZSObycTmZuJsS5A406PtLpxYf3VGKaZGdVZYhu7Se+sl9m+Efr6tTqi4Cag8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wft9YTWZ//khPNyIGGbmwJg+fnMHVzSC1hPHptCZuSI=;
 b=LSQ6rUGh53pKfNX8OREdzDbVqWhyy0YDDzYyPNSADJ+gwaHkDpiC/TgSKs0dx0di3dwps8Kr+w4eRQ37jW8KIWeuoKpLyUsDOm5ALwUh5nZcc3xHTPQX6uHajsiBXE+I20gZg3hnWGiiPQ7A/zM5Ga237Z6/1QMafeXWBYaivS0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:49:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 53/70] mm/ksm: use vma iterators instead of vma linked
 list
Thread-Topic: [PATCH v14 53/70] mm/ksm: use vma iterators instead of vma
 linked list
Thread-Index: AQHYwim2QU9g1tP86E6PnzevrF5RnQ==
Date:   Tue, 6 Sep 2022 19:49:01 +0000
Message-ID: <20220906194824.2110408-54-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6baa6c38-6075-4acc-bd47-08da9040f3eb
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YZfOtXZ8IrPPIeBCeVZTj+iB71se4FoeMf6wzu1/PDJFn67DC2jtfUx65oAricGIX+FnOUHGyY704mZFjV3O2XzlFmhUXIScgSHbL4LbZb664ReCJ3wTnm4OSmxwORxu729mTHi/ij1xULV8hh483Y9TaGskav/7rtMqMvdv5VZtFd2jC7l+xkvuIXQFF3mapVxhnu7/NBginYAlCdXg/qs2yF8oGW47Ut/Xvn6Rr0cTzHN+LC9zhCGuEljCpKZ4JJTkcd2nkm93DbplzURb+dnqQbBY9qojR/Uz50E0SewaJhU07cj4IALYlLJDi1QuCx9B6dzFuN5EDBI3jdKcLqfSy1a6C4PYesUqGXiR1joJ7CdoKVgcijKcS29FUU+y7WFEtjY99HbB4mpVenBsMxy6/LB5w3nLgPFSJUXaecFLaJ4sk7y7VsFmYjOWcyXgF3bWSQ7rYio/Rn2Tf2ywf46QQ+QuHwjShS5ZctpfhoElidZx/6eFWwF++uZIE4QBFJclAAAx5vmLbs1ekMIS4qHD2sPAMkg4+s2ABqz2xcgmcvjPlkCMctBgESPDFyJteh32VW3u1R9rR2rFai6wKktgXD63lQYmzzvEsko9zqsPGwucfGuqW/45SbFLDZ70tHGlWysNTCqmdubBsVDAh2m0xn+RErcu22ZlXC1efm8nqgCA6hQgkIjlJoVnux0isSm8r7ULgw9JlIDD3QHqZUR6RZ0kPjHu/DJto4IucgrsgF7MfnSQS7wjDmL6Tl3ed/wJW7nN3TUPnBlLfQKuJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?U/BGBjMjabiEkGUrKoqZqU1/ROz4YDsI2Jrhr8OExCAoUtyD09ZFBvKYjs?=
 =?iso-8859-1?Q?AumtD5W+03jko3gmI4Ol38HzZ+Xo4vvW3NNkQEvTPTjOr+mEyKo8I8QS5V?=
 =?iso-8859-1?Q?JdMJpqxIz8akmx/5Q4OmRu41qR8Hn6LGhmJdOQN9nWSLZTT0vA0/F151KS?=
 =?iso-8859-1?Q?kMViiGoBso/tbDx4BcwpdKXPwlyAQeoEbwTzI5+4TWTtV6Ld3K32fWM0oP?=
 =?iso-8859-1?Q?Iz/UDu86rmky6woSTDLj4xfyFg6FDrvhOYN1BSudo8f8peSYhkEtn1A1qZ?=
 =?iso-8859-1?Q?xY1gtScGhpap1aZOiDQZWTGhTcf2SXYZzd+tVDVId4CmGxTrg2AczIxx4O?=
 =?iso-8859-1?Q?Miq+1FUcEQ9v0qkoZBGM28IlC1XKtO0+vTa1EvlP7ANxTeVzPYzmfC1qyW?=
 =?iso-8859-1?Q?Og1uRBHHieETMupS1Ffl8104qXgWmXV3d+prQGZayCmI7NZ5laE/DKtQv0?=
 =?iso-8859-1?Q?YeHq2borHQYaElcAjdzPiXXBq65jUYpqPx3iFIUlwXuBzRpEYoWj8Hfjfw?=
 =?iso-8859-1?Q?S/iLnygG5wMqi1FWahr8xU2XtRTMvfwxt2+CDD6QHC4HjJAROKt9P/WJNC?=
 =?iso-8859-1?Q?wqiDBNTtYItAkRKhiP9kA9KOv5FX9LoBkY9MVKWQQ4Xc8DOhyelvhsxtGe?=
 =?iso-8859-1?Q?VpVwZ4USbv1LPmhPR8FJExDXw0GT6sx2fN44XBcU5UOX8X01vTt2/1QjkQ?=
 =?iso-8859-1?Q?1QpIxLOZMdzTZPIXOIcjeUgZC2UkV7h6FlRfH5eJxucyAFq1WaYNGqjrKD?=
 =?iso-8859-1?Q?ebZ3QhRDDq70/qteTXfb0A0eAfuli+df2GBvONn0Het1IbIdL3JCErTNKj?=
 =?iso-8859-1?Q?7BOohxeVys/A02ztu2U4EBU0OwB29rKDzFp/ewyfiS8aObDqyAxiJz5nom?=
 =?iso-8859-1?Q?ABahLKj4DCdOg+Wd0fxhJyCEcNEcOzWcLqxTJNWKJ65XKW7+qPvSnLM6sr?=
 =?iso-8859-1?Q?PgrKgFpfD5iky6+Xfmmi2idqCJvdhTfF7WmwjtEpwtsGXGuazVJQV3Xp7Q?=
 =?iso-8859-1?Q?fQqt9M8EyB6E6QVZSV+7JJ//PiKVdthJ6gD8eubzr7Tj0KbRbwEmzlL5lu?=
 =?iso-8859-1?Q?7ZrZRYFz3SiZ722UJwQl4Rh+1nq/6gAST+/zl6LKpAJNopujJIFAxNSSUv?=
 =?iso-8859-1?Q?+4/pMvdziebFvfa4oyPCHSldrz+4i08gKr1wxjrBqf20U2vfhQnfSTO3CO?=
 =?iso-8859-1?Q?cKN62qFauMB4s8+I4xxdXPTd/lU8zEg261giUNNNIfcDznYJbU5Hb4mq0Q?=
 =?iso-8859-1?Q?wvhqVmLjj3tyopcDH1bJTuCGOSOXExGP+mwWhFRSNROKzavGHtsaB3R7na?=
 =?iso-8859-1?Q?D+oOEd6w/JR4RClIWK+dtgdGM8Goe5ed1MSR6d1uckvGySDgZf7edbJnUg?=
 =?iso-8859-1?Q?eKYZb29Hvhu4btlDHOgwmvT+zgrtcpktt6vtRZ7dn/7oMVEc41321e/DO6?=
 =?iso-8859-1?Q?zkWQIgAZMTwvgFy7mOY5pp4m7YM04Yl/dKUMS/WIuPeOsVldfcnNxmc8xl?=
 =?iso-8859-1?Q?dzH2I4oWFk8XIstYq7YTAC67niPwdsSWsSEMqnNm0tvbnu37cCibkiFFn6?=
 =?iso-8859-1?Q?JrEN+fLl9idSQxWwqfro9+JzCHIIpl2AwUSm1+DLd8cFpBfmf8YIB9S2eM?=
 =?iso-8859-1?Q?Bxi/FuKgEZ6Bt8Z+KE2y7YWxYOG66wQ0G7f2QGMMiD71q2vbJDunTH5w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6baa6c38-6075-4acc-bd47-08da9040f3eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:01.1466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dFDnaV4ETGLyG6kx4DKtISyNfqBKmkiwGEkkUEqWxbit5+XK8i4IcZXk9/V/AkeQIO67N9rat6hXXYttQ2fcww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: Nf0j8RXqz5Lgqt8Dwm7rF44Ip087w5EB
X-Proofpoint-GUID: Nf0j8RXqz5Lgqt8Dwm7rF44Ip087w5EB
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

Remove the use of the linked list for eventual removal.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 2f315c69fa2c..a98bc3beb874 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -981,11 +981,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2242,6 +2244,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2300,13 +2303,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2344,6 +2347,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.35.1
