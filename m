Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21B95AF4E5
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiIFTvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiIFTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B8CEE31
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:29 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAie024665;
        Tue, 6 Sep 2022 19:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4C8WSobZSMx76UOhfzjLUvOLUeSRxoLKRBqnIG5AGJE=;
 b=ALgK3u+S0iMQZl/lDiGVC5G3pbw2k9mWO0MgE1rZTzusXth5jGrexe26t0HOTFj+az7S
 MZGATzPG0p3e5rBTvBvsN6UIEPb0+G0cBP2po+XBY+gASfri8fwevc1TtQ2FgzzHgNSY
 D8bdNOC/mpbFdXYLkK+osD73YSoPCJkfjtmnA9uYSHPLxKZqq++CowRB/Qr3w3w78w95
 S6P2SyLNgA4HrzmWhKqqCfdZU8tR7SVhJMUVfMooUZCWWt3iG4M13/B9kg6zp8bOUNcB
 liZNA6ug1ukaUazPkF9vUu58xvRRR/hvJYa7VGWacfpPqbff3MJufEfVB6aRDK/U3N8y ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxtaet60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:03 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wi027549;
        Tue, 6 Sep 2022 19:49:01 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgdNguRE85defJwlhale5O9UPL7wfbqPTa6QFOPgCCrl25NiOg2aey3kb3z49Ur3YHlf8ZelWZeHwB2yvaAYjaIE14vx3p2E7yUYgIsBSzevJmmX6EX6HW5pb/SHoxIVAFUjE6plFn/koU2TsVMvftw/szMBsJ9E223ybCbpjgzkQXo+7JFiqdqxMWZVAkwzQiRzyBJaEasWdXIdgcXycrRU/kje5uR9Q6G1KnvSepji8gReyenwKkMGad8hc6at1Q5kXFavKvZQaQhcVqLQJhAQ4y2P7PKanlDrUovCKA2yQfeRS4Qkz31/emT/szhe/y4UBsm9rLk7yNic3u+2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4C8WSobZSMx76UOhfzjLUvOLUeSRxoLKRBqnIG5AGJE=;
 b=LEaIOWFTaIRVhwxPjYtwfztoTjQTpXDuxYxvXNS0hPoVixhx9evf5atje/71tNPpZFOv+A2wvu1r3TuuPzkygWxd+5A1hEo81sZrPFG2izq6dq+lmDBw6TQv7tt/wNKu8Dit9aS99SX84M0k5aH8WzVGabA7E1OPYKE4nDyhMBmfU+5kwtu0hBblG5IOFstgqWb17elk1+DxWsMwQDBtwqpzq/lySJlHxdvPpE4nbP72Nqky8hASCgxp/CajjsjM5PSpwvaxdll2gBV2FglVKkT/jV6qxEikdEo1eWsHs+MUfXfpUA6cNabSpV/LicV0/3bVSyVy9leroeWHkWDUFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4C8WSobZSMx76UOhfzjLUvOLUeSRxoLKRBqnIG5AGJE=;
 b=Aozg5pby98+qXRWez84tOdo2w2FV9x1c8jkDnXNAqdSK3XKL6Il+ucIDkFJD4Eq7qvmTqr9t2JiAj+wSpE/JiQClshskdrzSalbwrZ4JEgkko5MDQSHUkOvszdFc6Y9VIRTcJlX6O9D02fdsZUa37VgjsQsNzS1Tenw0OuVGRNA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:00 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:00 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 26/70] mm: convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v14 26/70] mm: convert vma_lookup() to use mtree_load()
Thread-Index: AQHYwimw4nrK0TTDQ0aMxD7+DurIIw==
Date:   Tue, 6 Sep 2022 19:48:51 +0000
Message-ID: <20220906194824.2110408-27-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 42b78e04-e3c3-485a-0f38-08da9040d7df
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WKya0/NFes2NvI+BizcaOhJ3/pZBocWxGjEVBT1tXQMXh3BVgwmMYGD/O7e3z61IgNDz1YstsXOrJ0AozrAzWVNSCAzn6Srz2SV8f7wP5BSr8htJSWNwVsd9IwzTATDB0FGBw1vQPLoIBI0/Bzc3eT4I2jmC469yCNjNfOAYcv+6P6K+nH0L1ndMiZvF5uqiNvdve9qsq3DEANv0FCO915G3Y1rCKbZ8tYWvnlA6yfZUL7yF2AXy9ue46VyFMzUSdJgZkDRuDUftsWbBoDFQ6bEE0BBaTT5cDyGHolVSdAtZarPb2iZSyImfXptC0Nx6jnjLlTOq3qH4cUM9Km5VZww39wAOpWszCH4VMIY/P6HK5pIr0x6mAlRTNSkv9cZP8cb4BfyILKqPjlHEJqCUTvEBU9y0i1FcyyK/cI168WBM6A2Z40k/hvIbJeB2bKuazMyKph3iN2ovsfsHsKkI3Ifn1cXhlhl0kxfLDKk8+fw1JesOcccCOd+5zsMyuSMpJCB5sQyU8D4BvYqHOhuwB3LobTD6y2yg+2tqSkM9sxgps1NGIK50c0ZS0M8w+YobFTolbGLtLcJeondJ803nFtvg2147J6oOFP8LqWHifdmiGl5ahyqNkXrvVmEzc5wp3IJxfEOsm26f9RERmIbjyXTxG0TY7Ul1WNUO0OBlnfL3VOMoCiaK2Tu1i8eD+wr0OH5sp4dTcQ1+1BYJf7n4b56QBruEpwIpNiqS9IJZ55R365Od8Pv8yCxk5JKYJKFnJzGwFFEy6d9j5AU5zmI1fQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(4744005)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?3XvKPqcuJnhL4vWDyz3w5ZcsSwC1jQv6l+RrNsz03nE/MFdTUwU+lrfb6B?=
 =?iso-8859-1?Q?WRaOH/xrF9+BO595/0s9ng330aKbx6C3WsPMsquYthDA9hMuS3faWe3w9R?=
 =?iso-8859-1?Q?JovH9L7aQJ04Sjooe4Sw+6eQObpmlP9OQyg8+8xmWxLx9rQ5pIIHQW0Rqd?=
 =?iso-8859-1?Q?i3xEd7nnf/qoz1RJXV39LPZWenlK6X26PlFQmL3Jw9y0r8vYpPB1LE8wT3?=
 =?iso-8859-1?Q?0+D/OIa8Wb1zY2dLERgSqIN+WmvnGtZplauXhJLl06KBCr0VDZ0HgI2PyC?=
 =?iso-8859-1?Q?hcbwbJhZyxwRSJ/il3d0NZjjj7fFHiGIzrUkrF7ivfDuVbAn5F4N9LQ0JG?=
 =?iso-8859-1?Q?rh1QbEMVVO+upF7sHdUSD7zr9ydH0qSAy23Hzi09Q0snhP+U1uz4SoI+eb?=
 =?iso-8859-1?Q?oxTXRRijFYHcpRuVVYGGcmDvI1rBkH/c+ElWBa9riOh8PhAxLuYmLqew/S?=
 =?iso-8859-1?Q?qeHFEqqDV7ffMor9Po7q9OtBkSodk3/IoVgk7f5d7q1XT0G++y8KLI+bv4?=
 =?iso-8859-1?Q?PMixq+2B1pZ0hubWewvCDE59TGvWu7HGLbDo20pD8XY7/aKNFMAO8d8jOx?=
 =?iso-8859-1?Q?FupvEnwvM25tWa7wzXVtaKwZf43KzUu/6bE5yzr+X13i5Tum0Knr7qBw+y?=
 =?iso-8859-1?Q?KxJ27lXzP4eVNg+hBbQG2lQBh/LfsmB0wauq+KaPK9GMGKNZKFmmATpSb5?=
 =?iso-8859-1?Q?feGk/UQZwAaw8dlqjdomHgrOp4Kwv+eqHdFuEHeNE+z5ohtysO6n+LXk7y?=
 =?iso-8859-1?Q?8ajjElc48Om77P7uGalth9Bj+Bb7c83kA7pIhdiZrR84f1gyW2M3Awygy0?=
 =?iso-8859-1?Q?pYpjcAdEoloNX8GFWmz23NpHrVZ6F3xn/l/7MrZhhiudIi3RfhYkgZnxxz?=
 =?iso-8859-1?Q?89wMY6jpKRZDGHzoAKHhHU4qtl0dJQmIHC/sjkIxJXI8wysQ0n2qK1ygsQ?=
 =?iso-8859-1?Q?WnT47hnJQRM9OJKcmNaN/mWbkkuUm0NdF85NBMJvSg+SeHdalzOXWZdOcl?=
 =?iso-8859-1?Q?KXI2PVIZR6XKzAtmXQn/6DxBGdesreTRxtI87KYt27xP8GuUNJApGf+S86?=
 =?iso-8859-1?Q?JizdMykeEr76CkYZ0kTda+jNKG9oX5xeNeb7hmKcc5lfoX/68/hQKrNs+T?=
 =?iso-8859-1?Q?7qKDtZDqwxbsKx7hH+WhBVjBZuMZcBhzUSW7PkF5eYar490hmV2F+rFMuJ?=
 =?iso-8859-1?Q?/k3pDMNGvt0BZXRyEBF8BQekGu9XUDtUMsluXWVyqrPZkWhu0/yTB3BmTI?=
 =?iso-8859-1?Q?HHBdcKnG4hdn9xfXsWrtIF6IZyiNA08avFaBJvFYukEsDrOiCsDX4NljME?=
 =?iso-8859-1?Q?zAi/zzfQnLQPICgopYSptYCifSRlSoopAEFo9oCOrW39PNMfai0D2RCKBE?=
 =?iso-8859-1?Q?O6PlY+7kYryl/Hr0TM07qzm8f3p7RPCIcuqI1RY3Gr0RNQKRRw3RifhmKS?=
 =?iso-8859-1?Q?4yks7aX9qQJLLE2wVZWiAz1QdWeIlNkqOIcXPXNJUlJ3zyFv03YU22vqqo?=
 =?iso-8859-1?Q?CDkKerQBr5W99mLJLBGBXbNYGxlhXPMAxFNYpSXCZvSWPdCh6yCH56L/1W?=
 =?iso-8859-1?Q?dBD9YKZsp4LkrOuhYTuRwq/ZdKCXYzcGasDaHyfZs/Xguw2Q/h5vo3vBM3?=
 =?iso-8859-1?Q?qQEvfQ5ES7rQtEF6MFWm9qUeFyK0XfbHK/g/rcEluRi/wfn91SF4EGIg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b78e04-e3c3-485a-0f38-08da9040d7df
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:51.8659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YOgEo52ueGmmXopDqylcG565RVZH72YN+ft7lqwYrLUgbjUaRv2sGVSc7OMe3kKTJtwnapfHonqvzPobOgecDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: gWmn9vXa6sUeN-enacZ_C05ixJcjSZVd
X-Proofpoint-GUID: gWmn9vXa6sUeN-enacZ_C05ixJcjSZVd
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Unlike the rbtree, the Maple Tree will return a NULL if there's nothing at
a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9ed579168f87..36d28090e8c7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2799,12 +2799,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.35.1
