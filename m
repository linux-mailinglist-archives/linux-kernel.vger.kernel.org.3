Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3EA051015E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352069AbiDZPKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352089AbiDZPK0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:10:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406CC159787
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:07:19 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDSu3W018603;
        Tue, 26 Apr 2022 15:07:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=CaLkLUhgLnfOG/PZmdUSnX0/BB1YAo5E2GWfwaLdSSc=;
 b=i8wNQYMx4ntqyzjljvNJmpWBZiZGNb4Mkcx1YorNvwg+hOpS2hcj5lFogEfyWpGtdjcD
 mzW30PRz4KDkecCOz06k0xteMDvgvDnheQZjjbztUSd+YCn+WJ5g/48PjwoAKWUdZryd
 UlLzMf7HBIVc0vlF1uzG7YKmnKpNFTLTGmS+2FohPNhZ1qJbC8APC/igJwTAD2J1LIwJ
 njtVXH+kAkf3OUANq+GC5Tb2V45L6HOk0y5LAN3a33FL64di0lhKqn7+lJAm5N8OAlQE
 L6Tl4izd6yHqe1JC6SEnmh12yKkiiDLz2ECTLbObOk9VUgF51TJigc12bILO/wi+4NtR bg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb5jxeh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:13 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64Wa012598;
        Tue, 26 Apr 2022 15:07:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3grd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:07:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDbbkKQOEwuUQoVSplneC02lFOLiaUkDuEWi0iv7Z5BKtbPju4HuQBGpQFRntmnZBrZJ0d+jD/7tQ5oqclaoTojl+6zQOJU0YLG678xUKpCl0swL6Vdse8NB4u1Bn2N5Aqvtk5dysjTdYwOhH6Se87+zsyQNNY8uWFWlnSzA/k/AlMcsYJCDuRcg6U5w8dlRq5jm3nE/8rQ7y8CL6k2c8t/6XsHcmcPgnBVBGBO9+IzvJDiPx1yze3wSOH6weetIL5p4+BlrCbezrWo1yk1c0jsumrS8QV5KnTQn9UET+pkq2QbZAh5ta5W2Vh4QGz2XEGl2vPERdcNIIWA1hhTVaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaLkLUhgLnfOG/PZmdUSnX0/BB1YAo5E2GWfwaLdSSc=;
 b=hCh9qxcuqF7bKjzi9xD3s4ezdr3Z3WgufEkab6o2YLoZafVsoBUK+ME7ND2wGzJP8PTh94au7tg6xn8tgRtHC99utyecvK+CMYJJI5gDlkqXVjdRVwtggxuzw4wp/gsRzMoHuzjjx3azWwpaYzYgpZkQQ1YXWIV73lwoGg5KFxqThIlSO6dHaxpVaziO7mY8jPXd00FMi9Isy5qMVWaQrUSmL3e7lwgPh0hNiEkD/ToP8DhRnaNnNRwbd5CNvi8kvSXSgq6uiz8E7S5SgIi1UfO9tXt7hVgNilvlqV+NtYM5rTmC7+c6pmBIvs0QTSyN9fcuwLFE6hSNcaPvEDq+jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaLkLUhgLnfOG/PZmdUSnX0/BB1YAo5E2GWfwaLdSSc=;
 b=S9uoNgrk6omo7pMZ3soqcsIdpDTDSjFYYzJKZNXm4zMneF9/V3TAosbGnKVu0XqrMrezkHT6iNZaA5lE+LkZ07Am55jFdJ+N3yG9m1ofTp76JbBEF9gzaWebVHRCPhZSaXM+1mCsh3/IxXtUfFuQvhD5t5FFF/axnkG17VqX/Ss=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB2929.namprd10.prod.outlook.com (2603:10b6:208:7a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 15:07:09 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:07:09 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 30/70] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v8 30/70] mm/mmap: change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYWX86pgrbSRfRHE22TGM91KpWGQ==
Date:   Tue, 26 Apr 2022 15:06:38 +0000
Message-ID: <20220426150616.3937571-31-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 416ffd8c-7b11-43b4-67c1-08da27966f3e
x-ms-traffictypediagnostic: BL0PR10MB2929:EE_
x-microsoft-antispam-prvs: <BL0PR10MB2929450F768C8F706897DC25FDFB9@BL0PR10MB2929.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CNM2PpLkRbeDw/FPS7TzSBlF5mn6sh7UkyDz3lzkd7uSX4XNDFiuKthBuohZ+oHElZjn7aTji0ujuEdQ29QwWBSEmvLcWnhoEXAPgr+4nT0mwcZ50N/t42Z1J8mFAdHa+2/+R32Q7xXOgIeH0faMEwc9a95EcPoGJ+qc1RD933m7CoHAnNx2B4URMnEwiKf72SOEyecknjeTIJ0WCVzCLMgD7D6wcBDg8rC7zhrzSXM0K3Ihj5jE4szsVSRSKcfKI817IhLZOU8hTgkLzu0sHPqY1ROmOJVdzPq9VVeppP0WDX9O37Geik/lZoa+2Mit1ZL9RkKknOAO+H4kB+NcDeDFLez5thsEHP8TX6LC16UxBtrGSpK4RcIvXUXy1qoQHPVOMeCpeS69RCML6HFy9nV6CjvQYZH+t6W2gkwZgS8dE3K2omXtiatgcdjCa88fi1mnIh+P3JIgCxCM357OyfaB8zyxvgDtNH2SljJ4C6nI00LhszDCuXN9/svLiZYOWrnLYUB9V7xce0D80Z4fS8H6ZWYBkXUjx6kIvdSEB+03BSR47M8UlAxafwPw8xwVnRyaCx28omdeQrAPTZevgY5AsRftZo8bQudBaAMUW+AWLKGtZ8fbrkc47t4mPzb7nilPz5ZSEwVlZx3AVPMIQiASqRkSDg+633ejoSp8cENo8HzNWNjBlEJGzqOwz/oHCIhjH0w8BW7Fp0xXxpzJfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(6506007)(86362001)(44832011)(6666004)(6512007)(2616005)(5660300002)(38070700005)(2906002)(122000001)(38100700002)(83380400001)(76116006)(91956017)(1076003)(110136005)(316002)(26005)(186003)(8936002)(64756008)(66556008)(66446008)(8676002)(66946007)(66476007)(6486002)(508600001)(36756003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WE+RzzYI5xv0lTwGi39wA4voEKa6qpJKDFWCaREQUXnzjZOFdunJr7ajwg?=
 =?iso-8859-1?Q?bbpRGu51PTUk5s5FAV2gU99TIcfGlFWhCL7mjel+3as74e2g9eV38v7Acg?=
 =?iso-8859-1?Q?sGx8RCYyVOUaW6I0V7q/CeI55T5/FH+Pa+Xd3f/UGv/CaY9SkGDLplkGbf?=
 =?iso-8859-1?Q?z2GzCkUjz3FWgEE6G0v/O7EFS5291TwJeVGl9VudUMSO/XAeiS9E5wwjkY?=
 =?iso-8859-1?Q?DAT9Wbo0Q/6SMQ5GjCoNguiMJwuYzTMuf/CJfXPqh5wIbQqefGJ4oFwXNY?=
 =?iso-8859-1?Q?F/jmYdXMRXWJ9wuJA22XaSwtUuyQ7c4bFcK4kfuCgvJelb0/gpuQirIIdg?=
 =?iso-8859-1?Q?nj1vHAtrST2GlK532buHYC1cdPJiXpnRPhSj14wXXPhCFveKXUzKy9wM+r?=
 =?iso-8859-1?Q?zD8dE51rZ9uQc75qf0Q81K5UkURKGJcNSuqK4bIbYbivd3UdXfn409r+K8?=
 =?iso-8859-1?Q?TX8A12/CkDeU31Xwl3Tf8RfzLILwAiqvlEyo8RLR8RGhE0Lk7u+lzwhC+j?=
 =?iso-8859-1?Q?fnkv4cKoiWzII6D7wr7fjTbCFfrxZtYa/CsUVdImlHDX5xeJS8/lrZVwN7?=
 =?iso-8859-1?Q?66+gK/b/kHCB0w/WybigyHWzkHrSNlCRKm3J93o5tP9Y0OhFOBPi2h3zfg?=
 =?iso-8859-1?Q?scUsMCU3pTvbxdgS8TjxfKR7knB8euTta9/BQxAlHiHH0CzEaOGbtnMu+f?=
 =?iso-8859-1?Q?rEV0e4MgioH/CTF3O8/WClzPdtVU4vGGGMxRgVBZePdTnVpUsGFWc+fPPC?=
 =?iso-8859-1?Q?RmSHrXsame0kru91D5imbKFSuOslQ9GHTAtb3h0PnGdeHD9XcI2pFzkiq8?=
 =?iso-8859-1?Q?Z+krCnnegP9UrfcdKmxZXY0+hYf4grFIAAAbpGKqpUFBhoui1XXicQoEd4?=
 =?iso-8859-1?Q?0eiBREkpPHXRbff2MEo/NEhJA4IzA4XO/+GcYeC7aA1oMe+oGIWYqXn01R?=
 =?iso-8859-1?Q?Yvi8tn8F1kU79uw0IBW1zXZEjzrP46VCy8sOpBQ0jC5dP8zbSFCUZmm/IU?=
 =?iso-8859-1?Q?jAuGqjZLh1EqecEsejWAbma3P4rruuvSVJSS1aVa32vgoQiZXg6p74np5B?=
 =?iso-8859-1?Q?344iDarPrJH+3PfEDMvGDzYL3tB/Bby76YUY7t3nr1MwiXXV8ZfppNZtpH?=
 =?iso-8859-1?Q?VsRnZKMY9ds6f2724wcm6+GYncTAi/DBLBRiLs1lPzftjRcovb/Kh5tmib?=
 =?iso-8859-1?Q?RzZX/5zJaSrfmyP8Gt8Xjs7vSRxLrVqxsM10WQ/M1XHMYifFo94oQGTMzZ?=
 =?iso-8859-1?Q?LTgYkj9VErsAbXZeeQuUy3h5l1SpmgQUqERrNOd9uzwMfVxBz3elmItqbg?=
 =?iso-8859-1?Q?24GO9wrH+nz+vC/ROSBsE8mcO/NneyI7DFOGTpr6zpsYiuxD5MM9ef4tPt?=
 =?iso-8859-1?Q?Z/NSsqX9EwDW0ypbz1K0ia8Pkt7hv/3VZIyTDeoK4t7F5DRE0QCS+rXXTw?=
 =?iso-8859-1?Q?xBOLFRk6DtFa9I71yVrSOvh96XHFBcEqiTAmuRLKLbElqLdISMDuH58w3X?=
 =?iso-8859-1?Q?r+YMaMFG4kRv3sq+4B7/TnF6+sCJo/Ytk/mGNOEVsZ9j2IhPMWxC65TZrY?=
 =?iso-8859-1?Q?KWQjQud3qE+37Tbdszy+EqGBcln4p+sUwGH8qS2KZeMuvQVzaGrND5w2Kj?=
 =?iso-8859-1?Q?nOvPl53l8q5NDQgolojHDxu8anz3+GZ5AIfMHJGSIPxhIbWYGRMj4226fW?=
 =?iso-8859-1?Q?+tgPherd5a6xWmTjqt3JwtCsI8qjM1A6EU0ndVZZZo/iCHyOKVb9QIwtes?=
 =?iso-8859-1?Q?f9JckAbYSLna6VOZZOQQyUO49Oo++ef5iKgJRCqxqPos4LA17ojZPAXN2+?=
 =?iso-8859-1?Q?UFi/O29Uo9XAstTf8IODJjI1Tekj/9w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416ffd8c-7b11-43b4-67c1-08da27966f3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:38.4743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7IK+Qj53eznq3KYn0KbmslAZLvOh4ENvdaA/0JlJwHWHy1ttAx157kE4YrN88t1zWYg/AYxRswper/T2PRcYeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB2929
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-GUID: h8ua77Dr8CvItQlTiZaEaXw3CVJrbqZr
X-Proofpoint-ORIG-GUID: h8ua77Dr8CvItQlTiZaEaXw3CVJrbqZr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

do_brk_munmap() has already aligned the address and has a maple tree state
to be used.  Use the new do_mas_align_munmap() to avoid unnecessary
alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 9f3a2192748b..a98f7c765628 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3009,14 +3009,15 @@ static int do_brk_munmap(struct ma_state *mas, stru=
ct vm_area_struct *vma,
 	struct mm_struct *mm =3D vma->vm_mm;
 	struct vm_area_struct unmap;
 	unsigned long unmap_pages;
-	int ret =3D 1;
+	int ret;
=20
 	arch_unmap(mm, newbrk, oldbrk);
=20
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
+		ret =3D do_mas_align_munmap(mas, vma, mm, newbrk, oldbrk, uf,
+					  true);
 		goto munmap_full_vma;
 	}
=20
--=20
2.35.1
