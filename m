Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A5E4F1738
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378090AbiDDOkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377995AbiDDOjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:39:03 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 673853F89E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dj3YN024447;
        Mon, 4 Apr 2022 14:36:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ThrdqM2l2Ye0kGJPJR28COWU0WDU8BpCLuABqiYrLPM=;
 b=nIem4BfXfVjeOKnVd5NWyUGfXFnRVI9FoyBFowJh9X60SesSnLmVOyE4VVEDWq8j4HxU
 2969BDGLjWjWuFnaHZKtRK3xPtrmcOl1zwFo793hY/JPzTQr4QGLN25PiOFwETq65rCv
 /XV1PJy/qq+/ejgmyR2R4g5ZZJYDRZ9w5V/02nkN9n5cY74YgfSssTHFywOM6v3276t8
 3qGZzYx1FR+L4+dHlZ7RWbo0nhRNrNfWG3zOqLU12a02SqeugABRaPRubbwg75aYmwq5
 YZNEQ7c+vm0h5TU9iHkxsynB467D+k5XtPA8LB4LIFCpxDZ7/lDt7bFxzQ1H9+dSJmVi Qg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6f1t3cuv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:23 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGcG7027665;
        Mon, 4 Apr 2022 14:36:22 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn5h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVRlnxwdx/qW+nj1HVA6WVTdanAWy6HbBPsaD/U/Yl4XNM6FHNdbTbH0N7HqzqxMwRVhKuAp2BBGZLq3cin5XT/dB+LPK8QsVhTUDZoitecut9Elq4LFq3ai6iaeG9jWYfN51+OMsFl/z+1dMLyvixG2BwEbB4Hq0a6D81wFALECUjNRtOk0CGox/Faap2B/NKOogBkf++K7HglhWxkBhAFfPtJVeQbsAONMgDKIj5myx3sSAXsmm2EMaLM71ilbuEz6A3VT8yR4YlIBQxui566CN0O2ELgyuOLKV7JeJNhLUmO84JbKDEib5dPRW/zzmCaMUcAr3wRDR4/QH3pStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ThrdqM2l2Ye0kGJPJR28COWU0WDU8BpCLuABqiYrLPM=;
 b=oW3UWa5+kxWQaIjEkwa9ZEQB1FXsjXVziiQLaYsLAk9qy9urVBhZqdvPA1lDeT4kvK4cMLoFagk8zIAigI5CmiZebzh1u+Jm68YHpJSQA2XJScbY8k+bCOdBkDH8/yrtFEEBDpGuaXwuhxj0pDOuGlVXOq/zrBiKZjuW+ktbA+/ImjMo1VYyv356Ph69uZg2B1hSgrO+9GsvJahfzVAOAcfL3eF+PMTBoeZp0uuomCDIhRf0TkBlwQhWV59D5+fnM+GthFg9IMZNr5ddTF3xuuVrlzT22cZCk4dl4fGyP76VYUxOpHBQEmruB10OA9z35Tr6O48aj1gEsIeR+/anwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ThrdqM2l2Ye0kGJPJR28COWU0WDU8BpCLuABqiYrLPM=;
 b=B4k0OA86QHsBd2OKuk85a4OIfH+4Q9QeOGMa8kfmtPTlzsDc113mqE+YmgxJ+yvYw283jLwqtf9qKTUiaRefFTMP3aFU87QvqR4qhNorl9YsTrXyc5yD4vzby7Z7A50V0ySAWnOgIC0ukYXIffDGHIChTxZxQJ268HQHoGUgzls=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:19 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:19 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 31/70] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Topic: [PATCH v7 31/70] mm/mmap: Change do_brk_munmap() to use
 do_mas_align_munmap()
Thread-Index: AQHYSDFEW0cd7zhmd0GjVuKcZnH5qQ==
Date:   Mon, 4 Apr 2022 14:35:45 +0000
Message-ID: <20220404143501.2016403-32-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7fd5454-c64c-41db-b15b-08da16487bae
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB13813014A961ADD068E95C18FDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jHnGIjpgY5IFv0edAJ9G7SD9OA7dGsu2Eue4/q/8Tbfu3/ToUJIeBSswz7pqXEZjoigigI2VBAF9xCXfXOOek07vH8KpqrQqsyNfkhg7fp6u2qHBWWMuOeItFoI41rge/qdvh2TWK0/BsSaH66nqXz0swdBYbSsDpf61ifWFivYQFdmaFGfF3Cbgjar94MyNggdv1YsOO6tpc94pK3pNdFtDrY+Tv8MZOABzaoW45QV/XykFLZIOOH+CkEp26wjPQoxhvP6YHj7nFJNgw8WURrU/z7rZ7xGX0iaHmjHK7KaqchDr9qXoXLGpOSwaEySTT6+WdZeR7INZQc0Q2mseoxrLDsIH5HPbFktk26iYiZCrEW+tFjD8pXNRUabNnHsTJooTwvOXx+e5pwReitO+9VZHGDPFx9ChxpeMbvDdjJhTIdgncnLVF/ryzZvnuVv3yzm4jH3T0tDiEPHYpM801iWIU7mv0Oy/TGTpJNtT9ELOoChmTMjN+KX4kvMdG4Ud6wj6/ybZovDk63JxPleD/IwMXuqcmFCO2+wsWyeTPeBDOXohZPr2BR398LSJB8WDxGV0T5Yimz9Vw/ctkanigThHi2bYTLrKoYrEEIwZAOgKHj2XKUR8q6c9BlDAUk5R1MCd45DmOxUfx/jynh/5UFPsbQq1oazoaU2OV7VMYABxagueliOcBxpwCGmqk0X657rMFhiJo7PyhU8MAK99wQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(4744005)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gCmOilokyiE7D52cod3ndEhHpsmGjn5oUKoKXx0IWIyDlSziUcWoZTIcp0?=
 =?iso-8859-1?Q?fajWddWLf7VoIC8+FKPz9Otk2uIGwAtE979lyyWa0td37tdqQD+6XotV07?=
 =?iso-8859-1?Q?L/A8V844eHpFGtqN8+0rNYGfAMwE6aoXBeFvNHXG82dIiEThCSjUZ/m00k?=
 =?iso-8859-1?Q?fUXbC0cU2fI+z8XyNHGZRMrYzoD1RQDcp8eNJpBsqSrCLGLkaXOGWZwfyx?=
 =?iso-8859-1?Q?qMHxEF9TyTP6rHWDGibywtAmovI7EasUAQGhLjB4udFM1NUkT7v2onSk2W?=
 =?iso-8859-1?Q?cCxjjqsCDafKUsYcDlKSKmV+soQoLeC70/3bppQSUTz2ENth1YrDi+HXnL?=
 =?iso-8859-1?Q?4I+DQRVvCcGfUTOJWHiAe2rTi1ZqvPL/T6ZIGFubz8/7Fr8GVSjk5CTjtw?=
 =?iso-8859-1?Q?t6TLl9E6sKTfwlJ8cPInRPRfM4UotscNFD7WG/2I2Hryqf8492cnDYSI1O?=
 =?iso-8859-1?Q?7ZfAxiiblX2+TAS4CypxmcjCCD1lypOtuBMbY84lOSg1jOcBszW4kJBWTh?=
 =?iso-8859-1?Q?SrTAOatYMzBEgk3DW3fjYjKvugUHeQrZITuL7p8hWgxGUx80XXU8LqVVpV?=
 =?iso-8859-1?Q?i46NrQaluemo6D0boUiZrRqS37EQIIvixuL15GH3jweDrMQLlGKTIDhq0/?=
 =?iso-8859-1?Q?kcXMRvgupfYPoNUm1k/K2c1tfXILZj8APx439mgBuMs0BrG+gY4nn9BPNQ?=
 =?iso-8859-1?Q?gjaK7fdr+xFIakR5tYs5SH0tfkbay3TGICYbRb7FzLpmSY/ZttuJQLDEMO?=
 =?iso-8859-1?Q?hwSNT7UnSRJ5LwEPFDh2o5hKGNac+jTNZNadiBbIZ0yJ032OUklIFb/Xc9?=
 =?iso-8859-1?Q?haPpNTdb/IcRcTN9DZ42468kENOuNYER1KnkLRC8zj5mWzZfXew9EQtfYg?=
 =?iso-8859-1?Q?H5KcyVMZvGr/Tucbm2me2Z19AGSevilFC8GNEyKQaJfMfSV3qIv80qUhSh?=
 =?iso-8859-1?Q?Gh/pWVrHJXYpn2QLLKskcalJO8fJGiO7HxPciksZcjialdK7cLhNJIH/d+?=
 =?iso-8859-1?Q?wlBdCEib4JWmLi7RQ4/Nx0lK0uQliQyyhobaxE/ZWESfFTymDW4FU0Xu0b?=
 =?iso-8859-1?Q?u14jRvof9BL8L66q1zSiaRAe9spQq5NFoTXaaIj41fr14nDqvPRjMQrhfy?=
 =?iso-8859-1?Q?c0cZLVx1EKbln31sKo+QYgw4h1iow3UwY8ns0n9mj70V3nXzQ8GMNPlmpN?=
 =?iso-8859-1?Q?Gc0rxn2uDqv45awWSuCpE5VUu26x3AL7RaW9xo58sMRI/1KJky9nzn5X8b?=
 =?iso-8859-1?Q?2LDLBpJPB4CVjdXr6i4UFO246Cnxw1ZAiFT5/XzzK+cqX1IY4ldjr7RuzI?=
 =?iso-8859-1?Q?MvEAc/udrWGTJeq3k2Yl2HvcOqlTpFSEo5fMA/Pxji5s+d1VjQ2xydjt6p?=
 =?iso-8859-1?Q?BoBncmRIf1U/9BzGzgT7JMtf1nuTkIDxi1wOIRXwOhsnOxlsd/JX0x9KZF?=
 =?iso-8859-1?Q?Ef8rev+MLv0DsE8Uy+bEzRVLfqsmFUBgllqKb5KWnXPGIKjNpTkak6YeRD?=
 =?iso-8859-1?Q?lTcB+IW57Vqba/ovAy5xggOvFsUZSYcpqOQXvEs9mi0E3/KLkYDffBQJbC?=
 =?iso-8859-1?Q?AmbxVo0wD3j8f68yA0zMAbwr5MUt2sTZiKX3+zQzmyKUowifUpO5JhChTG?=
 =?iso-8859-1?Q?fwrVP/JcXYIIiFa9Zz+AI9/u1QtuEBuexAc9mPqmuIcZNQiuo3PFJiJwz7?=
 =?iso-8859-1?Q?A47B+bOUHt3B2WIOkbSQ7BAaeqaQiocGsF4AM6nBqZA8MCVyZZTnOLEq8y?=
 =?iso-8859-1?Q?WthkBgegccvGWwgveh5wXYqElO5IZ23cd3g6Ab47SLCKpTIVaWxdBYES7n?=
 =?iso-8859-1?Q?iDNNR9fbL0RN8E7deuoR/2yq7rt/2BA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fd5454-c64c-41db-b15b-08da16487bae
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:45.5965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z408GgzY3FhduYMbBoxtA44RfIheOBWOMSs7rVTeWBZ4OHqco11d2NI84nXcemdQ6rxbH9pT3KJ0l0/hzplNKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-ORIG-GUID: a0ZJNLZ8k0hD2lgZE-3b5ikqxNBlBJ42
X-Proofpoint-GUID: a0ZJNLZ8k0hD2lgZE-3b5ikqxNBlBJ42
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

do_brk_munmap() has already aligned the address and has a maple tree
state to be used.  Use the new do_mas_align_munmap() to avoid
unnecessary alignment and error checks.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6770b8a54ce4..0c548c7bbfe7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2972,14 +2972,15 @@ static int do_brk_munmap(struct ma_state *mas, stru=
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
2.34.1
