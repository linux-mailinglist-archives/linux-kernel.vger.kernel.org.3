Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83EFE4F176A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355201AbiDDOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378240AbiDDOmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:42:37 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DF93F8AC
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:37:14 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dr7fc012451;
        Mon, 4 Apr 2022 14:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ZMlPaq50oXQXLKB52IC0TtUoeu3zrpoPaZ20vEYDgmY=;
 b=pkJ64rHry4hYFBvtwSJROn5tCuwMXuOQ0CZ12NMh8oqY9nWv4Am7JLbfEGVcODuiA1R+
 UOQuAR0IetEI3HWXdm5DqRlehGAn++BOr9K1WnPGil3tbfAqeCHG4jY33bBYL6Ye5WTy
 cq9o8RYuzdjYHcnc8OzZ4CUQr6V7zyWwoS+2pb2vlauW6bvQt2MAWk0RBaXjr2xSCFg5
 aEckNmbtDyK9W7LB0+OGfczUt/+i9IGChnE5WmqvdFfAKbcsAfNCk2ZdQ3/iDQj9AiNN
 RxqqMUiz7psBMB8lVpRnHUiRnpLAij2MZb70Ts+tHCVd9udxo2jP/67JY/lOYN/sOiO6 9Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6cwcbbsa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:10 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234Eajoa011889;
        Mon, 4 Apr 2022 14:37:10 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gw9p-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:37:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHhDWD2LddipJl1wQyRp1s02WFN74c1dQ2jv412AC8FuTTdZ9gSxnp3yodiKelo9ufLc/F9VoGhPZD5qiedK28Wng9+pkXALEDeFSeEXr7Y/9iEDfLXcQOy75eGaJmh+oXIgCX7IXNSTZNUO9VBe39bs4YxqyIqfpaGIsaMUf7VHyMqSyO8CA0GTNyCCS6hVZmifr5fV3nnMbFjWo9FSFjzSEQ8839axVOvJihEpx4jnSCfpENvXmndvjhsOn4PVwI+vwVKOkKndOS0eZ1Cw/o8cjrfyY5CfnlSwHpItcG4Kpm1HLZPEcuj7IQetRh9rHsxjESPH84qFOscvdP3EPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMlPaq50oXQXLKB52IC0TtUoeu3zrpoPaZ20vEYDgmY=;
 b=KL43Rgk4XtsPkSHmdBIMDkaUbZRBh7tkMWVGGTj97oO6CHSs46/IGEuY+e8k4blkEfyGABBYXMEq9lSzFLsGUDnreTt2uEA59eT0Pm/CuwG3nKcNRguPEiTTsjVC5lukk0wR3V0LWgUnHekaK+krFQFiP+dQgVp4VXm7gRwg7gY64hfjhDysDrTfn3GhzoFK7AnaMmS2Hfd4AAFrhvn0l+hiVXN4D94FuuA/53YN0ETIPeAfTP9q1oER6rqxV7/lBkwghmiI6RKuMUHsqp3SnGqByH7uX9bvAiy33Njq5Drtw1YaRCl0975FjNWVheUKei54nqvWNz4O+WSyN4KXfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMlPaq50oXQXLKB52IC0TtUoeu3zrpoPaZ20vEYDgmY=;
 b=S3j/UFVcoUxJBKW5amGV2EibxT1AXOGhGwBduXvsVpN7l0ZZY6sE8rfy++IPw6yvxVaYR663aeU1+UBhV/T2JSgoZWjW7smFGp7l+JAfjyg1NLZb/GlpIUBG2HQ35uoS1Nma2mKg60+auNl3Qqj4aFLcAzTPjDeG50Deb7Utlpo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5742.namprd10.prod.outlook.com (2603:10b6:a03:3ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:37:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:37:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 66/70] nommu: Remove uses of VMA linked list
Thread-Topic: [PATCH v7 66/70] nommu: Remove uses of VMA linked list
Thread-Index: AQHYSDFM349cFpyBFEa6H92VbfwAxA==
Date:   Mon, 4 Apr 2022 14:35:58 +0000
Message-ID: <20220404143501.2016403-67-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a37f689b-7eaa-4eff-5a5a-08da16489818
x-ms-traffictypediagnostic: SJ0PR10MB5742:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5742D24BBB1FA77B7D76F0B4FDE59@SJ0PR10MB5742.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uaXyFglIYyyIcvGoYX173qjuBF2S6LYy2BRQB2C2e1Cfi8p0QHtrlM+ZHrvqSY5SSQEjOC2bHJi0GtK10DfKeUbQ4G+4oz7BsoPWwUgsJNMAyT3qS0L7SE7/gl2dkoeR+/3D28+lmpOoDmZxchaHuwXYpKQBih1qh7N/w8xFLLC9YwZkmKuUQk6b09YZck60YcP7HkQeEIH9QoefZd7rdTS5Q/o41TZCAboLiwrAAqTW2gyElv9/i00F7qka4LX8SzEb15ien+tY5ssMVzLf5cXfCZhyNDLD/Txuk3Mlj9u0DUQ67gYiUY0/d2W1LFGMYMQotGIxHE6htfTnsl6D7Y72rdhsOyWJFWxgYyEDi7i4PHi1COHoVcABcJbgMl0IyUBg9RAUlSgWRixKA4/YQj+KKhoLsL4kVEDHtBe3KHoA3xq9xx8iDyQp6hTSYmHg+9lX0f6GucewDyZBKyyztslYROrz+7mA6wxkw/XC9385tn+ods90avmuObPeHQiOuuxNNJRHuSk7P0T6wlzeie6xigRkuJmqf25sQB+0QbAU+PB+XDbG3ZtLwQSe/0HOA4dRYYMShRZhb8ROfpCH7EBy1AbydRDdw8bZnRYZkJPzldPuUV5fjVktPBI2+V+9YpKER3xMHtCg7q828XGJHEHA3dvBdHLs2MqXxf+vsaMAhWLJx3PbVbSuxoihtr7P9Yc4TGekVH9XO1lBNLNLTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(122000001)(2906002)(44832011)(71200400001)(83380400001)(5660300002)(64756008)(66476007)(186003)(38070700005)(8936002)(316002)(1076003)(38100700002)(36756003)(2616005)(110136005)(66556008)(66446008)(86362001)(6506007)(91956017)(6512007)(508600001)(6486002)(8676002)(66946007)(76116006)(6666004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gMYn3/87SQY5eBq9rfMca5rMJBOIbbZAGQY1HiC2CVfd0GnpwmcE92PnRv?=
 =?iso-8859-1?Q?jhN1KbqlAJ/a6KmqqZ3bwsN0H5ZTJ1vADQY8/QRzrHnzsEJhS01vmMdjz/?=
 =?iso-8859-1?Q?F3u60gSdz5MKOieRzIgBcN2ZH0R8Sh7p7JPzrzzTy807LBFkOCI9SdIb/m?=
 =?iso-8859-1?Q?9QTdZ3qVhxgur7kmYeyEkQd0MsaL6E0ly10HA8p8y0c3g3GcXsp+zV3ZiQ?=
 =?iso-8859-1?Q?N7n2MnaFyIOuQcMnJ9MPPCx9r7jSuA816tlAFyRb4F6vxn42uQ77j54gjW?=
 =?iso-8859-1?Q?NyLgTXp2mY+LTf7vpluXVpbn48sSCfVriPy6m7CCb9rGJBXv1FuX2FIa5k?=
 =?iso-8859-1?Q?PGYxI9pLSwwL21PUGn8qMh+peVnnYfYIml3sFMtxgHKuw2JKG7UvfEM3ky?=
 =?iso-8859-1?Q?zmhpG0HY1DV1XTNICIe9Fct1gWixRjnJn6O69vt+z2mWWbZvsTihR2JomB?=
 =?iso-8859-1?Q?XsapG1ezIufLdlGdrEbZsJOAI1UCGsvy0JRFauH7Efpt399PRR+PipbBne?=
 =?iso-8859-1?Q?PDhe8Ba9vzAt/py716ALUt+qN8kcYjvzPaXUoJ+E3GUsoOvogzk5OM4q6l?=
 =?iso-8859-1?Q?B9nPjeIHJeJZsykDAb6KuMNSKWwPDzJkHliD+icoB+sk9ODlv1730XWx6O?=
 =?iso-8859-1?Q?G9UMeFLFZVYrxKjPwj4cOdE0KX++xd2x5jbf9iHVP7RPoDw0nqS4CJb86M?=
 =?iso-8859-1?Q?pKdj4Ebl/1jeLmFxLhmTgPBGllbUhauXpVylR/lksMPlMPhvUdOU0wm1K+?=
 =?iso-8859-1?Q?HHD57a1TwnXnz3ScIIaYXmzCjXR2bf4x2De2abL5Shpqh7+v3LRzFdnMcN?=
 =?iso-8859-1?Q?o0FETJ2eYyqy2anxzu30ihClmh+PXAcJ8HpNQJp3hFeWLkQhu2hKMpRVCV?=
 =?iso-8859-1?Q?vuVLZJA3d0v40/bNu9Tx1p7J+Mu8TcLWNu3X5pwog5JYpnRtkfovpQEpGj?=
 =?iso-8859-1?Q?5tvfd4dLrhvUG17uFnWDB/H2lDBpkV6IhfEfKxo5nivxz/e6Ys1o/C/lwY?=
 =?iso-8859-1?Q?R+IMH++3SVAAmsfkeNmomYCilA67fzrKPJyjniCx/D8CrTl3nTsnqxpnY9?=
 =?iso-8859-1?Q?baEI+57m9uLC7CmdTV7brFIHahyvbzxz9IfXLsg+C4Ao+Mn+ozKWkooSEv?=
 =?iso-8859-1?Q?ZRihNMB04Ni7xsNkkn45Ejrb9rJg46TayKRJpACoWZN5WOO5VmyUb4o5xe?=
 =?iso-8859-1?Q?i0Ynro4StYx3WdG9pLc9BKvz2hbPreLoTD+Ynw3FgG20eyTLINW6E/lEYA?=
 =?iso-8859-1?Q?1sEH/a+F7MkojgRUAEg7u0MlsyzyGwmJ9Ta77rfm5XNREtea3G+ElEdyFf?=
 =?iso-8859-1?Q?Vj8mAq/lT6If7TPWRz1/aVQHFgptM0TP81fZx84EpQQdLhluI3WvvQEJRf?=
 =?iso-8859-1?Q?zJ/qD+NM47sHHA/2r/KbC5tQu+9wTmZIwzz9gupddtFYGbJlRxVbUHs0WH?=
 =?iso-8859-1?Q?meg6xwQQHnfog2PkEjgH9CqT3JTaNNLYebDdQHaBj/9SPoQenXDvsOxPeF?=
 =?iso-8859-1?Q?rF1aI7K3HOfgUu8L0dayD9GVd3pBitWfTSeyzbHBGdy/5IWraXCIVxCM8P?=
 =?iso-8859-1?Q?dVnwHBuJxAvAGzG1vAvh4bJtFx2nY9tBg/Ef9eFFPZONhN2C/deexd5p24?=
 =?iso-8859-1?Q?goQo5O1CV0xp/T91hJx0KCipifRP20ZL1nikYyt3LP5czx0NTYxeitXFmh?=
 =?iso-8859-1?Q?ZiYmZVGySA1JlU5gKDywv0csrxmOMLLkEzA59TSySH5WKk62wMgAR+Roh/?=
 =?iso-8859-1?Q?BjrHY+LxCSkPp/Et9XzXgJRnag4Fv7Yu2RpwMHU272j9QxalXh4Jz7/zMy?=
 =?iso-8859-1?Q?B6Df2G2aS2owBmM8V8hpzvgmJ+egI64=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a37f689b-7eaa-4eff-5a5a-08da16489818
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:58.1582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eKT242rx6RodQohFm0Woiq96WgypavpeTksMrWMxxxhqnUJla6mWTahHf5z+vutH9N+r03hpVt2L8V0ajvR7kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5742
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040083
X-Proofpoint-ORIG-GUID: 7OohxPTBP_vjgq5zoh53JwRXiAP-jWB3
X-Proofpoint-GUID: 7OohxPTBP_vjgq5zoh53JwRXiAP-jWB3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the maple tree or VMA iterator instead.  This is faster and will
allow us to shrink the VMA.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/nommu.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 26a9056e508f..645d11d3a8ab 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1381,6 +1381,7 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
 	int ret;
@@ -1392,7 +1393,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1411,7 +1412,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1460,6 +1461,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1467,12 +1469,17 @@ void exit_mmap(struct mm_struct *mm)
=20
 	mm->total_vm =3D 0;
=20
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
+	/*
+	 * Lock the mm to avoid assert complaining even though this is the only
+	 * user of the mm
+	 */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
 		delete_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
 	}
+	mmap_write_unlock(mm);
 	__mt_destroy(&mm->mm_mt);
 }
=20
--=20
2.34.1
