Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F27F75AF4FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIFTvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiIFTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:39 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEB25F50
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYjC029914;
        Tue, 6 Sep 2022 19:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=QMIMj5rWXXWQyMVHj3d7y1V+2ga/rYS0Ii2nmbARioQ=;
 b=wZ6k7iTufSSdUHvab+2cZcAe9k8xr8cAVat18F1oQ1FsNqvAFKYr+Sqy8RhJTIQTvn9D
 f99orp1Py1rctoJDCqqT5mQKdLn+qCUffgWKokCFROT8g9UDGCtUXKA4PEspC+5bj4ad
 mYVBcBWtmC6IbOwyCCC8Ng+rTRpvgNsWXWjyq3sYo5MvqJRBCeLNI0uJnT7V0miNyMo4
 o7iHfyTlRacG9hvleZqaPOnPbiI9VjBscqwAY74qLfM0/aRg2hywsFjCrEf2ioAFsG7C
 BDSVPogmXJT11dAYFUoREmuhOnrAmys1kPL1YgxDEmSF5VxHrBq3GUDPbJE3l7euxL1A EA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvaj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8KXN023727;
        Tue, 6 Sep 2022 19:48:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kr9w-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSvoWfY9MttErvGYtPIRkbfQ8vRkpkVrHwUkZBH8ub6D0X0DzUWWMyjVPu9N+BiKWs0IlPfgaXYjPBZ/c3ymWHQ91bZFHjV80s69CHLgOXQX0K5yevlSZre7HjQX4udYK7X4R9o1hU7ALwdO/Gosv/77DGqu3/vbJVPgZrl6G7QClSZejOCtLAbi5f/uew8B+lUMrrgXFt+VxUzh41HQ56CfeHpFeNTGOMLzkNJ7e2VwIZUCWKBk1CDOBJQkqwRcP/+g9x59UJC9R+czSW0M+/GMqjsNVrF2gbVAbJrlHQLnMbMx4MOJ0LBhEh1eIWEmXa/4D1BkGWlsgPdTgGDZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMIMj5rWXXWQyMVHj3d7y1V+2ga/rYS0Ii2nmbARioQ=;
 b=byqSesHdYh2c/RkKBsD8zN0640S4KDVJRntHzd5JlGuZ5oxs9iAwQ3UscHsPRyL5d0jms3pWc0GL51Wsiu/H5LiM4DMFXYjLCJaWs2aeQWeNYB3sQljziU+n16rl3CSok0rq78ImKCc5cw6EMcjMvVPdJLfU4fHKligG5gZnuytrX2WDMbFdUPZzLHEI5vmX3oAOi+T2houSCYgtrZUUrydax7l3ADdZLNhoX4BNP39P+ny6v0ZP0Eo0oyuPt7YujEjvqq7F65QP6vqYVsGmjLDMx3GEQ846tDjpfWQpabg5aS7DvxC2yyO+lDH6cS9ykMIMIcYhonCs687P/QmPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMIMj5rWXXWQyMVHj3d7y1V+2ga/rYS0Ii2nmbARioQ=;
 b=U6DQqDwV355IT75W3kYbTxZ1422Om0Wb7zUHylkTKBjZPX1d71m/QHthPv4XhAe7j3iTlZmaptQE7L/txwqxRTHOg1KpRkgYIKTOz+6pnPoM9fjgEwFNGLOJaozz8zReNYzxiyc0SvSZDcGHL6ydhCtEFzA0sF6UcodZn/NNyTc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:52 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:52 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v14 12/70] mm/mmap: use the maple tree for find_vma_prev()
 instead of the rbtree
Thread-Topic: [PATCH v14 12/70] mm/mmap: use the maple tree for
 find_vma_prev() instead of the rbtree
Thread-Index: AQHYwimtV+BryXOU9keQfipKzz7Oyg==
Date:   Tue, 6 Sep 2022 19:48:47 +0000
Message-ID: <20220906194824.2110408-13-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c04c1b4b-28bd-43df-ba52-08da9040d366
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5K+p5FM3FnjJbjb4m3Y059lsFM4kDfVZingAwoM6Op9GcX564B1BT9u5KhSEcV0srd4H484IYXFxr5C3Eww8QaLmBZCH9BRADl4DCxi2BLQZIkLkws/GlrEjIjeywOUc2stxEGWxGvxJTxP4cvZuHZ73oj5DVQlGu2JatWm2wW2YSo58+sFhk1r1w8S4ZmxRkHGQ1dnlK0N8H2+UI0Dk5JrAMmGSfnb+PJGvjOhr+yrTKxkVsUAlpdA562U7KD8MG4PCWKv/3NYBu2HWp/vaPxLyvMaW43Hs7zp7Y6zRYRgI3+oEJ4rHgL9BHSgCvftAwZo9grS9QwCwqd9YEEiqDjzYrg/XjFnu/u5lx6jzgVZLAoJC8LHWgqAaDJDSddauI1CJ7m/YyNaxgjrAxq39JLqu3wis+u8xBQO+p+aA3XLJMLEZIL7sGqpMvqNr85AWm8R/sO5KsHpDhmcevqQY+1T34NITXwe3uOzZJakK0Vqg+D+MuWY7tSFaKnbmARFlI6w8WRuFAFcc+0tQBWucDRargDngfc3DS2FwdijGQRH17W96oz5c1jETl45mwqSijQCOaTcyU3QBakYyqh3SaqVu4FOc2n102odTrU4lkHJHmCDC5D8AKUd91WgkOD5dVUi+vpIT5v7CQQJ5FfurkHg1Xy5c1I13S9cciBmra0m5Yhqy0WdblhSaXHT6Q1RKSXmMm1ULItvJfYpP0fqOTWIXIgGzMKeOVweWMEE8gOva4BD5Pa4Qo7WAjdM+OemN9Ldy9bpMkF3UI+KjlqiXlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(86362001)(1076003)(110136005)(44832011)(71200400001)(6666004)(38070700005)(54906003)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eif/acibwH+ssR7uIZiS82vxad4oOiDnqXeH/LBdNNIRy6E1k5c8/65W9o?=
 =?iso-8859-1?Q?jWcLoTaNlEUKTtKo/KCp8Kd5TvkWZeWvyHWXaNashtURXae/KlnGhuzmRl?=
 =?iso-8859-1?Q?XK0QdQIjuIf2TPRMHwaw4zk89vExL/9C3b6H8Ar9tSsnJwHBSwTTEvD6lD?=
 =?iso-8859-1?Q?YoXtye2xBIoI+zYI9OayRb3FUwhQ8fCusJQU1h5bb1+g2bOXc0bxX4OXzA?=
 =?iso-8859-1?Q?9xfQY2iwZ+GMt4jzlxHK7Hi2coAztB6aHrbyis/vNw3hrd9nHk5id2Apr0?=
 =?iso-8859-1?Q?prJo4TJi7nqsYBDT89DE7yc0tjGGG3UKUdcbYY5p4l5PWnbnxo5l9k6yBZ?=
 =?iso-8859-1?Q?AxTbBGlSiLFbyrWo0lxhilzbLHbU+5FXRkcYArCRNWOq38ongKKhN1a5/I?=
 =?iso-8859-1?Q?w4eZf3z92SagLAMMSflP5qKPRdDImNcAfhh+l0bLk3YEDVWJ/myMrSDz9M?=
 =?iso-8859-1?Q?FROyis1oZxXPT+iQne3ttwOELI8+d8cr/MyBFpYhEOsIjLgCoVxU+6cebX?=
 =?iso-8859-1?Q?Uhs8M/kn/YqQY4S1BFVanZSsDOhNO7L3NIaC6aORLQnHUxDbiAR4L5fQ4g?=
 =?iso-8859-1?Q?8cf7tm5hQDfI4eUbK4C9T98DHZfElzVdZxXWGuOAX1RfVI8dZ7wAU7moKl?=
 =?iso-8859-1?Q?YRoyWLkL75qvs/xO/esTF1Qskp2cUWlxl4AN3c64A8PO8JvecdUMJby5xc?=
 =?iso-8859-1?Q?Zt17spfBfQcVbJB/4vRnqgXWVqDCnTJkvZSHWbWpsXpZO1WALrQsoKNKxk?=
 =?iso-8859-1?Q?xu5yclJrJ3NGgjB8FG8BrObf5tEkjQe9wVBcXcOBR64WVTBOlROcrvlwH/?=
 =?iso-8859-1?Q?U5vkb2QIn6WawZx3LXhBznbTylJJZEz3qCmOtMSiyzahxWFQ9u6ojdUzZ7?=
 =?iso-8859-1?Q?hCuLV+jb6rOhc6Nm0WmiXHMkAgzNQSvggeArErcu8izq1aI0NdC4cmjEv1?=
 =?iso-8859-1?Q?mxtkoL9Sp8kEM2NoMO2lMPNkpU3lAT6Y52a4ycwSc14Okpc5IjDzYjYpCJ?=
 =?iso-8859-1?Q?+ys3re3BT9fFavsJLAB7vR32tY36yNXM6fnM/gKH4y6IY7BN6Y2PXUG3Dm?=
 =?iso-8859-1?Q?WcVQ0psEecUBu3epkL1aq2S8fYbtNHaSfwIsxnV5PTxkSu8Ntl8LRNnpSy?=
 =?iso-8859-1?Q?oXLtVsL3jZuFskJqQir2CxOInzFcN/hW7O0Qj/dGd3iEKXvpZ4hSz9oTr2?=
 =?iso-8859-1?Q?LGQ9KMXSJuIoMMQ/1mfc1jl6kFxRZr2CNcHegT74/48hkM87fTHNsWPUAr?=
 =?iso-8859-1?Q?b3Y/9g1uONV8w2yGD1iMAeBGfzyXTvcEkbR+c7PxAKDOTBZfcanRVSOJFR?=
 =?iso-8859-1?Q?eAFQob6OrRfB+X9V2Yug2xZLa34IDXoh/ij+jHKjwFP+zGl1I2mJ3bWTuC?=
 =?iso-8859-1?Q?zfEwTDRQ/bRs2iQ047sZGUqs9O4lErTV0q6+Ntd5kC1Z2yi7PBN1rMIKnI?=
 =?iso-8859-1?Q?7M1b3RU+MvX7dX/AI2nSG6FA1g7y457P3xlP32Fu1MHjLa4wsa2dlR3NrP?=
 =?iso-8859-1?Q?Gi5f+WLh8bp4HLPF2lDSCY0lITjw5FREL8d71HPkyquP8tFtHF838sIJTj?=
 =?iso-8859-1?Q?ySOhoc0GvwUmSzYYk4NYjEkeZjtAZv6tqsvbSprzCDtmllZ7Pwloc9DUm0?=
 =?iso-8859-1?Q?EAd+XYXA/w/wFVYt2hTejtI4nunGrq5Lpnpgn7HthXk77YvJR67Be0bA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04c1b4b-28bd-43df-ba52-08da9040d366
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:47.1944
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OXfB+fbeYla6l1wZ8F6ioozr9GsQxkm/b9S0f6svjsuPqngsSQSvyPjrY/AXaleJKFN3TyW6BeRnlpre1NFBlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: q_pHyMPTEMEM6xQaY0Zay7c6fYjbJplQ
X-Proofpoint-GUID: q_pHyMPTEMEM6xQaY0Zay7c6fYjbJplQ
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

Use the maple tree's advanced API and a maple state to walk the tree for
the entry at the address of the next vma, then use the maple state to walk
back one entry to find the previous entry.

Add kernel documentation comments for this API.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 mm/mmap.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index dbbf8ee12f60..948264cd39cd 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2475,23 +2475,30 @@ struct vm_area_struct *find_vma(struct mm_struct *m=
m, unsigned long addr)
 }
 EXPORT_SYMBOL(find_vma);
=20
-/*
- * Same as find_vma, but also return a pointer to the previous VMA in *ppr=
ev.
+/**
+ * find_vma_prev() - Find the VMA for a given address, or the next vma and
+ * set %pprev to the previous VMA, if any.
+ * @mm: The mm_struct to check
+ * @addr: The address
+ * @pprev: The pointer to set to the previous VMA
+ *
+ * Note that RCU lock is missing here since the external mmap_lock() is us=
ed
+ * instead.
+ *
+ * Returns: The VMA associated with @addr, or the next vma.
+ * May return %NULL in the case of no vma at addr or above.
  */
 struct vm_area_struct *
 find_vma_prev(struct mm_struct *mm, unsigned long addr,
 			struct vm_area_struct **pprev)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	vma =3D find_vma(mm, addr);
-	if (vma) {
-		*pprev =3D vma->vm_prev;
-	} else {
-		struct rb_node *rb_node =3D rb_last(&mm->mm_rb);
-
-		*pprev =3D rb_node ? rb_entry(rb_node, struct vm_area_struct, vm_rb) : N=
ULL;
-	}
+	vma =3D mas_walk(&mas);
+	*pprev =3D mas_prev(&mas, 0);
+	if (!vma)
+		vma =3D mas_next(&mas, ULONG_MAX);
 	return vma;
 }
=20
--=20
2.35.1
