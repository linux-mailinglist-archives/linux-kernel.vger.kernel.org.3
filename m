Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B9359C253
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbiHVPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiHVPKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:10:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEF43F1FD
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:08:11 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEkObw022938;
        Mon, 22 Aug 2022 15:07:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tsJrNwS2OG5zDmNZbRbGTard3C3QCHBbjsdQV90tTYI=;
 b=jU4pT1LNZNMKXEGiZ/vS0tBDCjHlr6yEuQ8RCjxB9S62L+RmBpsGB2rU513M7DEpPLaU
 vpZpdji0kKRfsycpyvpTMy0CknW+zVfi9pdHMqsEwYNOfTaH1mUJFqpMDoJPrhGDYA3U
 eOO4tWqnI/GwsfewU4HJvJr8nbera8k1lPpY+xUJ+mgRrPNmrPR9XSCAl6o7oQRKc6Tx
 3qT1Jx2jcRNO1BYy39vUxD1K5mRFJ/ckBfF58N+LuK/m1TIsZBjlLO7Z/nvsLpn/03FG
 Ik0OICC/qS9BR0zt9k0HOuBMtcPK/hIyUucR62e4aPzZVTrzcdL81HvJT8c+JFWielCP zA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4ar8gbtc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4OFZ005069;
        Mon, 22 Aug 2022 15:07:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mn3u1uj-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:07:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijpzowmryWUimi3p+aFcXJcler0uW292P3rjlJ7+XWG8ZCAxhzPvYTbOdVjXl2xtVjDCYAUISoWx0gKB7zHBuZI62feAX08GAFc+rN9ce7SXkHg4j4zWW2Z49cNZxCHn2xsxV9/+WAygi2yqDbA9bEUYvFin5MaUO4kqTRpY0q14Lggn1rLPHnmJAtK5qKc4SS4uwiI0pcK/5LY6jPqQ113jmERe1mo5p3Tk5LJuO2t1Lln+4kn4d9CQAMB2tpD3654IL5EptEKsb6VWMOX5p/qhbbqZrtqG//VaIXitFPq0P5S5rd3KfSzL8t1t4C9pum1WtYgXtwfV3FMIwX4twA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsJrNwS2OG5zDmNZbRbGTard3C3QCHBbjsdQV90tTYI=;
 b=KDsBWyXJ4RAx4NXmNcuePzxAf8b822x8QR0zmfuoPMP7dtSC4MorJVvPDr/tJojkhYW29FD3BpXI7+TjH4MUi0F2H8l3CFzC8RMY6vIBq3DXCT3uXSb3gkE9I/atAfON8kCHz+/B7Yrap7eVUtAw6i9V9MBtuLzduNLitxTvgSbIHJvxmrwIPJ/5MJ3TbuHLlzykKbGKoIcmY5X9nd77ZrOiAOWVp1fNr8WyWaLzXd2Jm+eYFPXcYW4iRDPm+YRYhRnsL9iPlFj0AMCN53btURIS8vQVkoww6n+nbsfBbu/tm/xm/UCBB6bTfsYQS9zTNXvFaksyDdkjVWvlMDl9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsJrNwS2OG5zDmNZbRbGTard3C3QCHBbjsdQV90tTYI=;
 b=GdFQJpRQDdcEc13iyRz3sZTDBUeyy+BXoxZIFv9DrV5p8HFrFhBFY+/in+mfpcuvGF/8Snpc53VQVYfIF90ocpv+GwzaOy6Gb4IxYMzvOfUuO9auFmcxLLE/K+AmspbL0TogRihKeslLEzD3+2ApoaXGaUrWQ7ZiF5KiLmMO1m8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4512.namprd10.prod.outlook.com (2603:10b6:a03:2dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 15:07:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:07:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v13 70/70] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v13 70/70] mm/mmap.c: pass in mapping to
 __vma_link_file()
Thread-Index: AQHYtjjE86QeqUMRBUGxCsJkeA0J7A==
Date:   Mon, 22 Aug 2022 15:06:34 +0000
Message-ID: <20220822150128.1562046-71-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eac7b861-592c-4978-eca0-08da844ffd28
x-ms-traffictypediagnostic: SJ0PR10MB4512:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FMt/vQedm0iXbMeUu7/sUOqzeX9uZhALDY+uYh3oMYuJnY6uP3L7ExsiJsoGtR379OVGBEjnMRQs3G/OCFIt+H0aaVDUwJnk/9a+hF08iTBqlXVuI3x5z7lPJ194k9EwcwBJusSlHRtqj358YJm2l5aIeKpaA+OU6/PTl66Lyzu4GU7oO5mJweTSfW3j8dRwy0yOym7ojgNoWJMfAicZr+BJxeVgupCXpP6JxXOKs6YqWilesd2v70rNQK+bjzsXF+Hc5L8+GwScTAkopKU5DPbZNN8iQr7SUTM9B2bKt5hzfP0qDD3fIVZPAWH1sAu91oEQG7QmA4PSepgfoY8xJetWyAyhxFrcSTiJipZK2h4Ib8HJGjqIR9QJQlZI+Dtjsdvuww0RCOcAfoosvcJxB/3oG1GeW9asw4KImWayeTSt9Ovhtqax0mK9jX8qeQDzNfQ+iKWs2b/qkqmPomhmuoQi/a1A4Gla5z6wniAokrHxYPdzUsKBO6rJZhf6od79HGD55BGG70CUQ/IseAAcytHNa7Y+Xa6fWCN7pNVrU2VpoHkjSNOv9Fk5Upa+S9bsFW0kNtZuxKJUvYCyNpxhkRO/LRfe9UQcL8Tt67xhbPkL27xJYrYZpK7LD4fLg0Mv16jMHWlVuuQhfGJ00jdJhxwZ2kWiTphYV+MU8GgbCYPZK7BEHWiGdeY/m6Ax208nxwGRtCUylYDEpqVeRtnNRroVB5c6Sx7zVK0921e02jdO+IGhuAUQgAZqccb8i4SR4JpOLq0ldZctAjEdFgPrEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(376002)(346002)(2906002)(38100700002)(86362001)(38070700005)(478600001)(6486002)(186003)(41300700001)(1076003)(2616005)(107886003)(6666004)(26005)(6506007)(71200400001)(6512007)(83380400001)(5660300002)(8936002)(122000001)(44832011)(4326008)(54906003)(110136005)(91956017)(316002)(76116006)(8676002)(66946007)(66446008)(66476007)(66556008)(64756008)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?28hVgYnPL49jJEPazxAcn326i/XDJMz/FcAGTMwDPiRu95wNU0mdbwqbWH?=
 =?iso-8859-1?Q?Avpbjiaps4PfmCArUE+Eqvmi4uERjwmKaveT0ZOJm/5cHOne9b5qIIzCQ6?=
 =?iso-8859-1?Q?KWkOfA8gIvAoa6wc2SfHFyomI/ldrL3ICItCrA2cBC0fvYeasC9RfHxATy?=
 =?iso-8859-1?Q?o8JPikfCY0zmI5vfEt3trGJVo1LeHXD3/Icz0PYIxaba122biLydbyCubM?=
 =?iso-8859-1?Q?YxA+5HBId7wjUFo9yfvXsI0CF7j7s2rgG9oX8foSpcoilE+z0JWRit32SI?=
 =?iso-8859-1?Q?RFu4A1O9NbfPssPMd8O4iwY6x9cc7X4KnRwv/AIaepwpw8ebhaXnfQ1jFc?=
 =?iso-8859-1?Q?z6+1vImJHhnX8rKTsuXwLawU/UKtN2h+K5UC7a8DIYX9akcSqjNm4iSAZr?=
 =?iso-8859-1?Q?Pk3vhkLr9y12l3qD+WDK7uEoYqxOuMbpMa12g1YLhMMg/aSU5sTIrDTM+R?=
 =?iso-8859-1?Q?yj/egL93gJK12YmYrsFPqdvgm5jm+x8r29rK7VPUoiUYMioktE3pRl1IMq?=
 =?iso-8859-1?Q?ARW5Y1J9suV/Fqe04i6bHs1Ww+7Z/JY1uphdjlyjSAnX8Chq5lWuMdNjOF?=
 =?iso-8859-1?Q?R+9w3hkhNAno+EnSMe9poeeYwUDFpbz+p8NgRc2ocgS+Nkqy6VOe0NOHdD?=
 =?iso-8859-1?Q?2mfgix1xRA3H/9FzV6pJW+k37avcXGIx1QEk415SOhMOyCEVErUunFBXhE?=
 =?iso-8859-1?Q?TyTJetLjCQbBZ/PxlsgGCFEHvZxEmO0+Ncj8fS8g422LNFYMIBGnabGlOA?=
 =?iso-8859-1?Q?feAKteXJWe794LCs4/35zqEWowGGoxYb161hXiFTvntgZTxNbDXu5kxO7M?=
 =?iso-8859-1?Q?YnVtLzzbiv2kB4OOgSisSQZu/t0CAHN+cnwzrKfs26V+CzdiSsgHnOEKQ8?=
 =?iso-8859-1?Q?c1SFG2UiSgks/6DVLCTlA2q9R3wCgvU5g97vHSeOu/F4XFNVtJMguIHsb8?=
 =?iso-8859-1?Q?KwZnofuUnUpOGZ0Gd9S04DthzXV0007aIeVpdT3AfR5SrrGsLwYzoRdGVr?=
 =?iso-8859-1?Q?bOc7NE1MpIXul6jcnGzBwW3guJcujSgvHez7NzbkA3XBvtx3Q1bevS9D2Z?=
 =?iso-8859-1?Q?fx2cnSOOxuZdnzVsOzK7Y/53Ep37eICxv3bDTMSzEJe8n7sbCqp4XiAWqt?=
 =?iso-8859-1?Q?1gkHTA5+kYFo/GdGsYzpwofLFACKTl/9o3vVLEckHA1E7bLG56afPF83RS?=
 =?iso-8859-1?Q?89oEtdrRrgX/P5J5IiZ8Z+GvyXu4DLM+cRPQHJt7gTKCKeyHBaVI7YPQ0G?=
 =?iso-8859-1?Q?zBxGN1srjpjMYWWP8KP/VpYFOicttTLMALk4AkiYnBHmHysbfttdP8OmIG?=
 =?iso-8859-1?Q?QklV0BP3vaQIZ0ZnJKB30lc8t+Ibi6FCISQlfFkFIjCPEz4SwnH7otPtN2?=
 =?iso-8859-1?Q?kaZF0P/BojFr9iU5WA2Mhh0v8SOYpvmRpNwnaaclt4xdExnjNUo4HgtKAw?=
 =?iso-8859-1?Q?3y+behYlLCuZxvdjB0/Q7xHNYvWahzFxOtEaAlVkDfdOckzqGD5PbBly2D?=
 =?iso-8859-1?Q?k5cUvKnNh7Y4uhtQQQ2RBFDCWzFEK4iEAYJa9JNT9PJIE9eLUeUklWE7sO?=
 =?iso-8859-1?Q?qSaImZb4GQgatZ67Tl2VA2QzW/LBjND043SqW+Df3WCtDgJOdICP03pDGE?=
 =?iso-8859-1?Q?iY+2b/5jyqcJqtLSk6uu6+4y7IZ0c+DdHSe5pDAsgynXCLRRKa9Z4JMA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac7b861-592c-4978-eca0-08da844ffd28
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:06:34.4251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i5krG9PtyA4bIRqFi34XGiBbCTwQGR/wQIKaSDBc4ehm2wgZ0yeNZ9bnpPDScbWQaqKokeGk0wIDuHxboMmanw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4512
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: Azst037EvyVQODeGYJaeBdUS6iYwePix
X-Proofpoint-GUID: Azst037EvyVQODeGYJaeBdUS6iYwePix
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

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5070af64b99d..fbe8b52a90a3 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -407,21 +407,15 @@ static unsigned long count_vma_pages_range(struct mm_=
struct *mm,
 	return nr_pages;
 }
=20
-static void __vma_link_file(struct vm_area_struct *vma)
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
 {
-	struct file *file;
-
-	file =3D vma->vm_file;
-	if (file) {
-		struct address_space *mapping =3D file->f_mapping;
-
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(mapping);
+	if (vma->vm_flags & VM_SHARED)
+		mapping_allow_writable(mapping);
=20
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_insert(vma, &mapping->i_mmap);
-		flush_dcache_mmap_unlock(mapping);
-	}
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
=20
 /*
@@ -488,10 +482,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_file(vma);
=20
-	if (mapping)
+	if (mapping) {
+		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
+	}
=20
 	mm->map_count++;
 	validate_mm(mm);
@@ -730,14 +725,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			uprobe_munmap(next, next->vm_start, next->vm_end);
=20
 		i_mmap_lock_write(mapping);
-		if (insert) {
+		if (insert && insert->vm_file) {
 			/*
 			 * Put into interval tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
 			 * throughout; but we cannot insert into address
 			 * space until vma start or end is updated.
 			 */
-			__vma_link_file(insert);
+			__vma_link_file(insert, insert->vm_file->f_mapping);
 		}
 	}
=20
--=20
2.35.1
