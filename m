Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A6E57ADCB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbiGTCWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241115AbiGTCVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:21:10 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBE06B760
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:38 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1e26k002384;
        Wed, 20 Jul 2022 02:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=fgEdy4G9jiYroyxSJPdpKflQFwgNrK1nUsFALdcJByE=;
 b=JNoTk1HoTDQ6GM/IYNwt4PjWXR/dw5LbHkaLwDg8XBwJ4nJgE2DZPtvANO5P12zeg6cW
 teBEhN5VH00G4IQvOkofmmNCBLX6k617dNhQNilTJ34ElLjfVlcfG9nq5HCeYvOmXco8
 3e6ESwYt7wUYbZHTXW6NUu2z9eKKWEkBmSvUAX4vNn37u3hncRtDXblLTMm7rbU/quwV
 jxL8aV3SB5vaVw8bFfBG/oY5TC1j2/DXTQXuyD8oeeu0aU7zB0a8bVec50f9L7YI3sCc
 M/n2iwkmGbJrMbpcuZJyKyLcCEnMoOQzFlnGL9hYt9yVi+lnY6zY84uL9Z43GlidwVg8 rw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81n3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1UAld002689;
        Wed, 20 Jul 2022 02:18:31 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnuv5-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REqW4Mmq78E0BtSU8SSphA0h2sVhj/eugFu9RfW0k7q5PTEbZUSqMGU0p7MKRUgVoohEyNS9bOxGV6VoCA7WyPyr4BG/YQSEg5/sDUPHrK3I9HfDRYKJYNv1Qhq5He5COeOWjDnCsLhVlggx/9bdjM8jNZ0WL5h1yxa/IClxiZpIi8zq5NaSTPkAWmGBIi/HRjiPTDP9E1bUk6iLUqDaPdC3ExacmxutgLRANFzJLJj2xntPIPkPqwKp4LZ8APG5Uedi5M8SYJq0HiaBDmYu+p/hgUKhPbq3fS6R4NVOa3jOfhwqM86aAN38gmHY3UsFZp550g3mepkUWCPDiJUkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgEdy4G9jiYroyxSJPdpKflQFwgNrK1nUsFALdcJByE=;
 b=EJgtz86N5YiLcglIWLNwYlMx/cOUMo6GQ4ZpdZEPniBkdQ54CXkaBw1fzwBmjwQLPux+tWG4khl+Ct5coHKVxPUX3qZljUcUUuq6HL/QzX/+JnvaeY7ChVpsAB4Gva4/wCAhP5VE5Rk7XkvM27TgGwpXzFSjwysmvEXpRin+nQ/t5nGjztTQmpDMgB7XpGompGMMZDz0WA52WFJQdcBJHyUCbkP60tViGVy5Aa62Cjt4LOOxEMgqiMr3tB+urwd7AIkdFlzYFBjWGLfFlGS0NgadmaIfNZ2KUEanDZrGutNDubemOSxXezRqlM6oqzHXgA6OZVQy7Ifz4gaY9aZIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgEdy4G9jiYroyxSJPdpKflQFwgNrK1nUsFALdcJByE=;
 b=Hv89K1BZr+qFYmgnRwZqUKqqwiem/DrWaJf1HT/btImYDd9gST9URONW/3i1NmzIVbETQvtNtEVVkFYxGAdat1wEB80zPSjEcicV5O3eMuE7SkAs4G4srSrcnDqPjfOIEHgAxj94MKsYJgP7mjFHB/q3ESbTjIA6x7YG15tYikk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH8PR10MB6316.namprd10.prod.outlook.com (2603:10b6:510:1cf::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.22; Wed, 20 Jul
 2022 02:18:30 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:18:30 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 32/69] parisc: remove mmap linked list from cache handling
Thread-Topic: [PATCH v12 32/69] parisc: remove mmap linked list from cache
 handling
Thread-Index: AQHYm97ri1Hpuyj0YkOPFv5l/7941w==
Date:   Wed, 20 Jul 2022 02:17:54 +0000
Message-ID: <20220720021727.17018-33-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a05bd74-f854-4e18-01d0-08da69f62341
x-ms-traffictypediagnostic: PH8PR10MB6316:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UN8UW1fjPytajbw+E4VQv3jlpplS8pW/if+Bs8AhYqiF3Gum3QsXI3Crwtszd20G1zpcIsEUPM59aCazwZjW2gKkoSz/gcb350IjNCvb8thChNr8jy0+7b/d8V1MMSefIuGMEqta7JKgraKR7wd4z33p0ZUV3GnPLKbAjCrtC4iQkxh+nAvcoWk3hZWPmGBfJmWcAIc5hCWxiZMRYuueIVokZEBnY2XGI6hHE0PXAV8x7yWv6gLK6DZpZeHrXHK3rN8BR1LWbrHK+eS/InHLA0XELXct3oAun/vPCi/7n8BcW7JDOdwmzfanIjTN93e24TSvuKOlnrwnGpJdy+wNmSeEEa29HmVb5ysFXd2waEa1g6QFtqrEjnSd+vivXbPUsDyIMnKmVPSl3wb1mE4Yi0hRixggTJ+L+SkhrEbznT5SFKhD0yJ1vbbhsKwPu7q2lM92/eBkPQKaQ+wOvMCNJOPV47j7MgHaLBsmSVCUmX1r8rFbY4r/dEJtzlGeMut3MWgZWuchq6oP1tVw6VfLtoeXfIA7sBpr9t1krB2Xh2gPq1VaTEhTYzCD00vygvXcIluXTRgLp4hqP7dNf84U7m0Jmfkr+maWUO3fQ0KintfPBNvhA8mCQYLIajJUh+DslWtLcWHIXf6/P8L3MU+aaeDBT2XCRT4VlJRUbVTu4T8jd9YjyUhABcITyGNGIltiTzDX50oT5LhpFySTOuzA7jsDvtC0WGoMu3mFiK7WBQ9R6WGLJDiSa7Jsxio/tX+KLfOygKACvjazFeF2NjM5qNP/hFzqzWvmn9thhdis9lu2xGByTrOPVIv4zztmu5m6nIAU3WFHiW7wbxkhf7JBFN0RYZFCAj6Bdidvx3wjU7sFYcxgPqa6cY4WIRFv329C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(39860400002)(366004)(376002)(136003)(76116006)(122000001)(44832011)(8936002)(5660300002)(186003)(1076003)(83380400001)(2616005)(4326008)(66446008)(64756008)(36756003)(66946007)(2906002)(8676002)(91956017)(66556008)(316002)(26005)(41300700001)(966005)(66476007)(86362001)(38070700005)(478600001)(6506007)(6486002)(6666004)(71200400001)(110136005)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?f3jqIm9qlReR78RAHr54iDS+gD6me5Aalcr/vtAB2SmmVw2Vvck0eNbX0a?=
 =?iso-8859-1?Q?v7/jE9YlVPMniFqGFZU1ILTspZ+tfpPFqDCjVRrCB1jGtiVM4AWqCeluv6?=
 =?iso-8859-1?Q?W0PR49w61xLz4Z7ezAkjqVxL91dCHe8ojwuMtQClwDdZHRhVvnlwJv1r/7?=
 =?iso-8859-1?Q?OHodEb2/uhW+2N8ToqdgrKnHCNNJHhu5/kln7U2+IZ+4JaiOEPvZ6m3+Uf?=
 =?iso-8859-1?Q?6gEZZ+KzgJXj2czMTRhAn7u7rJQSa3LJdV5jSLA9W/TZ2Li2enMnqtQ/oo?=
 =?iso-8859-1?Q?ahYoZ+7FTtbXMz+SKJ7ND2c85jYLwu2XTRxR/xHC7TInAmpdPUOSCWZK2L?=
 =?iso-8859-1?Q?1lBzA7P1Bd2kfLvbqj0RPsKwgXoecI7e2fWweQav0DC4D0l5hmkW65Hlxq?=
 =?iso-8859-1?Q?JvvcG2Y0StDKKD/gc9p4jEe5Tmkbtcf0wLgXPJt5sN0ZfZ9zowxpM2hIIl?=
 =?iso-8859-1?Q?AsRP8tqhB4OAlTjz+QVprElUZsPE5I2B9/mdUa8sfQwewY7/v1Yov9VKXO?=
 =?iso-8859-1?Q?+fxGrE7dQbJ03O4uNYR9wl/bOulDqqC4/Gl5UH4wtoUbWSPjzMsP1YdXpt?=
 =?iso-8859-1?Q?bxl8FqgMTKn48LGKd0MADY6+c73dCYSdqhLqA+nmgKK1WzgBapBooxP8cB?=
 =?iso-8859-1?Q?NKMnSq+gefr0+d0vv8uXUUtm1qGFyK/juA/X0Dwpqv9pzVhvXu5iqPv97p?=
 =?iso-8859-1?Q?HfnIE/FzPjI/MqWeMthtsjt8dMoyUkQdiQEQMJkkdnto3RaCZzEivnA36m?=
 =?iso-8859-1?Q?kAm6IeWUMxKAgma2ZBIW2tiLh+s99UJBz+0UYupEreUgzgIM5UgEAOpMNu?=
 =?iso-8859-1?Q?v2jIKczLHad+yF13M2HtoDjP5SAiz0YiOv000pf1UNjU3eSKKf6Y6eTC/f?=
 =?iso-8859-1?Q?j6TuwxGu1IULxBVxK85DnZjzNEsr/V65caF3Z6RTyKa5fOHPF36UQtXyre?=
 =?iso-8859-1?Q?lxpepOptSTercJjz5s9gHbvU8bSrJV5qdS5sEkBKFalgK6o08wCLJJEI4Q?=
 =?iso-8859-1?Q?PARi6pGc/UtCeESuWWQmzBFN9aPR9wN73RlQVqghSPal7mZHXw9n4gL0qg?=
 =?iso-8859-1?Q?bkDRy7u/OxSyJ625F9DZIhBgpvxvV+wFn7Gb0NQxWivSffPz2tWIiHhbLN?=
 =?iso-8859-1?Q?vrHFW5vQpE3RBVbS5XY1MhQqjKNJiGoD5eBYr+sXZZVPs4NeutiT0r06Pd?=
 =?iso-8859-1?Q?PeZvIM6U7KJfp/SGJ5FI2ql7/OhozGLncAUdhq01XC9u+pPaavltX7LOK9?=
 =?iso-8859-1?Q?X5kclw0WgQR6SfiTMGd6HdTIlJJ8EW8OwasLPlN7dQuS7VV9FZ1g6ofco2?=
 =?iso-8859-1?Q?h0qp/DFQpIAcH3JARp49ZGipsSPfw4groVji9wbrpyQCha49j3cRUdK/w/?=
 =?iso-8859-1?Q?t/rGtmASRuKmK5AILLff9c0JUF5jC/KT4y5QuTiF0hzWzljF6xj1RgkJns?=
 =?iso-8859-1?Q?tMuZ17cPgAtzXNsLq2b9QgNXFJSPKHlp93ITysjbgmCcaVuJpQEla/rxZ8?=
 =?iso-8859-1?Q?DwSyKaJ/UshrqyEdUlvbsdtnvYHx7UbLOfUW84aQcI2x9XoEFhX0FKcoz/?=
 =?iso-8859-1?Q?zRSOojxKk0zVa7OYxHPd9rcV6XMcv6qz+/jgbGf3f7lyQCnR2IRYS+2Qdf?=
 =?iso-8859-1?Q?/nzig6UxkxicVHobFV13FhemTsNXJuRz03Ba83Khvsa9BCWnuu1b9msg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a05bd74-f854-4e18-01d0-08da69f62341
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:54.5244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aasaJFRWCnzJmPdiJ1F65QvPEYwMRHm+Q2jFzy5hJ4NRV5yb4wvAbJKw9usR64Q25goEUv1+s/XZrznzey2x8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6316
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: _k-tua_cBmqww8wzR-1AJ2-pFn9pTFol
X-Proofpoint-GUID: _k-tua_cBmqww8wzR-1AJ2-pFn9pTFol
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-17-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-33-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/parisc/kernel/cache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index c8a11fcecf4c..3c8679e3ef10 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -660,15 +660,20 @@ static inline unsigned long mm_total_size(struct mm_s=
truct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma && usize < parisc_cache_flush_threshold; vma =
=3D vma->vm_next)
+	for_each_vma(vmi, vma) {
+		if (usize >=3D parisc_cache_flush_threshold)
+			break;
 		usize +=3D vma->vm_end - vma->vm_start;
+	}
 	return usize;
 }
=20
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Flushing the whole cache on each cpu takes forever on
@@ -688,7 +693,7 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
=20
 	/* Flush mm */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, vma->vm_start, vma->vm_end);
 }
=20
--=20
2.35.1
