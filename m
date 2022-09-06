Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E895AF4C9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbiIFTuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbiIFTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7FBAE
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:21 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdJM3014146;
        Tue, 6 Sep 2022 19:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=rKGeczfh0HJVHc7V9Kp6oEwxdGSgV0fqZ9jQ4a2xKQY=;
 b=O/PS7uCcw4kCkRbwXu9cAzw9VWyQTUoqm4k+JlZZKxcNfprFUAPxeV/qzIm6PIFzBa36
 ZGZzViJ4h7acMuMfO1guLid3OkHxxtfgMjD8Rz53x3XLPW7DnKgTZH/ysR9IFAz3Me1O
 qtT2ePNNt6HuLX/GWzSloi3VUKBsQ6N7pQmnXdDyKG1E10klDwUTE2x3iswDtNduK80k
 HD9GoiFBq0gl9V7rvmn+SSJYSoYqgyLYqVc93L6Cy3c/GjMOi/e4dprcEQxf4mBCur4g
 IhvtnnS83TiH0UaJ1xCZiuUvlyNFERNiL2QEtfzB0FKw6rg+dMNMMoorN/qF0OTNnOBV Gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwq2eymg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:00 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9we027549;
        Tue, 6 Sep 2022 19:49:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doorKENIR2VmdmzkjZp0tanzh9m8bq8Dib6NgOLVZhlbq7vZiDVTvpAB+y1F5GseY+9KXUC34vtRttF0PGXGeVDhTtLbqN2vFXrMk/9qBYbu2ZenrFzp0ZYkmGIQ6UJVFwzGLRIf5YMut/5KO/TT1fj4wjvm1Zsdw8uWZePhio1v5dN+fcSZ+K7ivjQ3tAkrekMMc/kaJGchejdrooNhhqc4+DGwRhZBLng0O4vz++eDzXfitN35f5xAqPTl07W1a5AK3gvH0//4BsOwgiUoCqNM1A6Db9Lwyda2Jidhyf/9Wc9i/qXbbe9tff08j/UATtizgp/vb1v9+9T2KqHsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKGeczfh0HJVHc7V9Kp6oEwxdGSgV0fqZ9jQ4a2xKQY=;
 b=mytVFpjZK4UrH5anSm5Y1esY9Uvu2blqDj7gxTaWTvcpgJJ0jX5R7W8/iKULUWQNgE/YCtXq9SKPG6Xs6j/6xmslpRwsBPaB3FY3mgd7MQHmzd+d8cK7l/eXW3f0Qf+muNbZd6nLdgbUg74mUDrBQ1m9TFaX89v5aK0rqu3OIheSf7Bk32WAgyOuT0XXJ0KlrsGtyS/vloqUGW7+l49haGsfhtfe/4IRkDEIhMBC0hgzhL3bhUQCEI3QEWrHqW/ssWA9FwFbFnURnSTRUyqsBssGbOHn6oXkjjHIJUFr5FNSIEkiB0WJHaXeaL3o0I4flFRMcs8+P9OkMrB2nqLLaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKGeczfh0HJVHc7V9Kp6oEwxdGSgV0fqZ9jQ4a2xKQY=;
 b=Eymc9jYAXZprqFFPUzrhlRwMBYQXTK+2qCa6j+gog0qEv3wt8kuNenIlGQiUlnIeArXRlecHX4U8hv0OmcmUi3p+Spdvf/uXN/h2Eookgr3JIgtyQIrvo/bdJJOZ1+FSWKyAueBRPDQafuTLnSWD1rL55bDN0VjSBg0Zz/Y+NNs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:57 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:57 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 21/70] mm/khugepaged: optimize collapse_pte_mapped_thp()
 by using vma_lookup()
Thread-Topic: [PATCH v14 21/70] mm/khugepaged: optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHYwimv2H2/v9EJrk2v83ypfKTEGQ==
Date:   Tue, 6 Sep 2022 19:48:50 +0000
Message-ID: <20220906194824.2110408-22-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9917b50-05d9-4620-74af-08da9040d679
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ho3a8DaUVjAuxset/v1ebop7gx8dcn5hy414bDz1kcWOYAeH1M1t0qg3uMXQ+DGIYIhzEg5fu9BNZYBjlZRTIiGTvOTfV745NIsZQxLRFqvwPni/WDU3wZDjWxYNXF+ReDZkpLDaeoWg/sIjvgvIiUByRozjaG7LqRc7rhtcj/N+LN8XKwTZ9+CqqRMCwDEMn0yERuWwH+BWpx/GJg2QjPnmcao7LltcyRavL01fmyYU23L8kxuBdJ+EBxdewn38am58aabDaKaiRGljZlBZ2p3cBkQIFrlHR8102JNVSsikGY7hFA24OLt6FjIeCwHXAq4qaQT7h2L5sLZGNeGksd0z8S0NoNUv7yxDBLbI9CkP47T3C8FDN+88eYVxbpQG3jbllNun0fNjJeChR1cCVfIzvDScLJdVZcFrnSTKRiuPG1IB0dQzgylg1h2vb+ygc4mT9ABLk0ftSQ8zYo9OAJXBwHBFqziffvOfbLX/Cba0/vJ35XB7uZTnc29IFQHPwTton1LaDuz+hZxNcmUbz/QeyThPd2g10hwdbrPhQ7Oj9+sZ1nTKMLT5LvQcVhox+xGbi6TIQYWUKRrgwMOI3jcEHgOV4wYu/NtS+GHNFuID75nDJ7bOCeFW/XnvT0FtryW/VqXFZsILvaRDPFsJ1A9kjDaJzMxyfCJzvKgCsA0el/olJlah8oZ3oTA11aHA6mj3MMeDFxOvLKyglMWkMt2yCJ0XSMl184GwxXoWjWFhMLK9NTO1LYLtweVx+2XAkA0MaUyzOCAFMYLE7Isd3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(4744005)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7NXW2oPha0EK3fH/19J4aLviHhat3myoE56qmwjpd/pToK2InAVACvNW28?=
 =?iso-8859-1?Q?p8Y1BItp1o1GiX6VnwIHFYrMu37eakNsXqkHtVixW63AGkmOcg9teYNr3t?=
 =?iso-8859-1?Q?JRMn4vO9EBU78jWzb3oakS5w4SPnGaHNmAd7CBifGlJFlMYwWTIECjKjur?=
 =?iso-8859-1?Q?2N3Dsob8lTP7LxrZQyGB/76w/uJSXK3nbsTpRY8tehJjtc47BNqvqnT92j?=
 =?iso-8859-1?Q?b47uYJNeAHBBT662t0iZMcP172uIqZiAQXCVH+COitQz2zt1Jamy9iU/DX?=
 =?iso-8859-1?Q?1+mWLeRAH2ixmKipwzw7M4GRDgcdfFOj5gi98ECHAnX/2LG/HNcWRvfDQ6?=
 =?iso-8859-1?Q?yC3Tl+2YZJygcWzlacDp36gq0U1Xiil6nHyie6QN2kANjKaq73qAvrEl/X?=
 =?iso-8859-1?Q?Wu59K7ALMEgFvQCOMaihsZJgnGxX4pPHXW71AWbK16vw3SAlzZy+2Br3Ib?=
 =?iso-8859-1?Q?wlKTiY110up1LwLkVJ936E4LBCOIbYpKJ/CzWtKeBAUMybITirhfQ7utHl?=
 =?iso-8859-1?Q?bOVePgS92U62K/c9jbFjrCrHsy/0xcmU5+GRBfBWkASPupJEcj1cmrHU/y?=
 =?iso-8859-1?Q?J2DvVOYnF1mbBCH/wtkHVcV2YDQAz6sf9liwd9hgdDGuPqcmZpkD2vjaG/?=
 =?iso-8859-1?Q?jbGWH5T1HG/EVtCZnzMUh34zv1Hi08Kd3SdQsADca1qcAa9Udh6+46+bz0?=
 =?iso-8859-1?Q?yuyodftpK2raz4Kd4dPo3euhpjL4W1d5gYMsvYx7eg9skcXIqjR9LZLkMv?=
 =?iso-8859-1?Q?RhrWzu/45PBqV0QB5Hce5HUd2Ba8BiHNL6Q5eDBWV4dbX7PypNn1Z80E7u?=
 =?iso-8859-1?Q?FlXTRsEtq1H2Y+2xYTG8qCo7RyWOAqOvha8UJrAbMwC1UECL/sbeSKFUBU?=
 =?iso-8859-1?Q?Xi2ey+agk1wJm8fUd+miJqh4y2oj9w1WB8R8SYMYkWRSPx2uq27hGqRqEz?=
 =?iso-8859-1?Q?cWzKMMVLS8lmLJQfzkpvDVc6nzlZIuvj8jaUgbobtYMPCANdI/zRNRS4p/?=
 =?iso-8859-1?Q?D/Xg2VolHwGAhWN8f7Ie0e0hegOMSzx9kRwcWSqDo7GBYXWSj3oR8kxcBW?=
 =?iso-8859-1?Q?iKyVB4wgPUuAh9Ej+D50P1X/mA7WLwPmBVajgZ8VjvdVrECyYswJ8yRB6R?=
 =?iso-8859-1?Q?GPEjgqWpqwa/h6Rnn6aYdyB1VBL9JMCxygL/xrhcJ+16qUieR9ZaDKFKYB?=
 =?iso-8859-1?Q?ZXs/a6oTrJv/D8J2Rk0mZ+m/qzU/qYLkgsNZiAp2m0oeQDBD5expE72MPW?=
 =?iso-8859-1?Q?rXfoeEsQlvzJhF9qQfT0ipUgz7PF18TeXsSWHe0lQ2VkB5GQs4AIL+vmXx?=
 =?iso-8859-1?Q?oKMUESS8Tcw33UwlBNN2At+LqSP1y/wjJQf/KWQt+pFpcbyUOXhuQDmRtW?=
 =?iso-8859-1?Q?Q9JTL9GUBlfUe1KJkD8/XDzH2VprzjOoxiFMEch9ztPTZwR7zr44QlMmHX?=
 =?iso-8859-1?Q?TlDDQAamGTDhCYyPdt147d5dGwOtS3KI/sO/YEFd+rp6MDHrTpdocs/3yV?=
 =?iso-8859-1?Q?ixkN3L7BtDAYB9Qd4d3muleDcyFCQ53JYYSKeVaZ2NPvOoVB1soRzLi4kC?=
 =?iso-8859-1?Q?7lKmP5ERpZxkJdcv0G/g5E4YG15QyYMwlNQcxHb3osBvw6iGLCjD68I403?=
 =?iso-8859-1?Q?WR5ZZ9wmEGLQOfOKjChDhg+mvUWcDEDkJ1mJEzOZ+fBdgOTRgod/tvhA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9917b50-05d9-4620-74af-08da9040d679
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:50.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ntkuJ5WdlaNSj4a6kS35HCLB2uIXuIE6kbNvcfQGp+6/WKVn1wENPak3eXc5yBSVUn73e5LQoznPX7YmVpQu9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=846 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: kEh6cFQv6J1KOYqbOmIOS1eG8Mu6fnCZ
X-Proofpoint-ORIG-GUID: kEh6cFQv6J1KOYqbOmIOS1eG8Mu6fnCZ
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

vma_lookup() will walk the vma tree once and not continue to look for the
next vma.  Since the exact vma is checked below, this is a more optimal
way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 3e64105398c3..d3313b7a8fe5 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1392,7 +1392,7 @@ static void collapse_and_free_pmd(struct mm_struct *m=
m, struct vm_area_struct *v
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd;
--=20
2.35.1
