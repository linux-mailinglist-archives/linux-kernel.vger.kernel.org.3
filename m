Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C21519352
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245028AbiEDBU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245178AbiEDBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2C74348B
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:23 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KjMlG013507;
        Wed, 4 May 2022 01:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=EaeqlB2PelExQhyJVVbDPyVJ4zG7Jb9T64R1btZZCwST9ZqEk5cLioiyrxSXAyIrWwJA
 sBQOEtIQICcKuuMrkO9Mcg4YsK3Jd5eUKL7tZoaXBDR4L0sGFbSsgCQfmUfuDbejgIxw
 lNR4WPFUyyk4U7UGyn7w8gVc65nOu6cWSZMgLqIvDiTao6XWSKUGWHTzUl3wveCulxQY
 VzHx5IXLTBe43hTKchOE/7XlNDqDfdn/QeB0hSD41KhOItUleUgbx13xY61Qzl4dkrUt
 4DYteJ8l/bDw0uT9pfGPpKj5og4K8xtIkk/bof6YAHDP/aXRiUZQmV/H78gHXIwqr+V3 vg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6es-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:07 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441ArQ2020035;
        Wed, 4 May 2022 01:14:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922jf-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwkO0pGN3l4oMX9wr6naFvPxCCyAOTBAUEJew/GCK2VBgMG2JZkpSfqtk/YqrIEr0R5FpBngmcZxGtn2YePRPfBzuBuDPRT6DidLWy6BJtijBQm3+8KyOpMCy0uuP9wz1is6kcUiMAahqAwPAaqCuPwu9zPb+LvrGGwMDChLg/xdhjZ8ITm4FK3+0gJ5U05GoAzkHtDEV7cMMS6wEuX34l7iNDiUroqNFIF7QX4/Uqg2/nl8YEzhD+4m+PCzh+2tv+9aCMXnZQZ8hu8bEW0WAcSlmwYO/62xocq2MUp/o+9h6ZNNlgCDAD+4oPm7d/k2gTNDspQkL/isKNg1TFUpWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=mCfKaKfC5g5V1WMu7+LIr/eTiUmF3RgO+4f6DpG3LBYfPiTXPR0LLIkLd3XMUbkuiCb/TSid6epInz5LB4hn5R1yRHrArv7KjFpc8T9rUuuqbCcqrZuxwFmCp5d6bI6ah13bkNQqM4Um+6mN5+fbTYBW6vEhhqycGlklXTRR6A6ibVTxbKsJBVSEaLZZC3gaONVvMc4SeMTitSFdgKqRkaCFrWORTfE0LvNkQTNJpoMnZjMOsxHwnmktjRJz9Zt3f26RJr6zlZbywfb9wASWwS7Czi2XP34ywIDFE/DC0IceBHHURHKvimjgdBqGGE98t2J79NNb1tq4CN8gLIqchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47yOljL6/6aYkZ3kT4JADxwdilgAuazCf0w688kEYr4=;
 b=xa+Am67f8kk6cHpZc7FE6PgyirQYJufGhZT3QBfwA4vrbcHstvWETxhcddBAUpm+0rNcxxIbCs78Hn7ThaV0y30SxF8bd6l3nk6vxiKBqJMYOsuIsA8sufGFFzjAzx4TnDOZ7NUGReGihYSh08uD2AsMld+joZLriupusO7HN8s=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3728.namprd10.prod.outlook.com (2603:10b6:208:115::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 4 May
 2022 01:14:03 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:03 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 45/69] ipc/shm: use VMA iterator instead of linked list
Thread-Topic: [PATCH v9 45/69] ipc/shm: use VMA iterator instead of linked
 list
Thread-Index: AQHYX1Q8JJmXt9j4t0q8kizP1OeS0A==
Date:   Wed, 4 May 2022 01:13:59 +0000
Message-ID: <20220504011345.662299-30-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 521d7658-309e-4fee-47c0-08da2d6b60f8
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3728935FEB962678B31F8C68FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /jqv5Kfo1htglW3FATFZSpxYeEQHZH14CJeh2DxibPJwWNIqDB7b+qKA+iNUgmD8JhW/fPLbPv4eWlly9mdTlQoTxtwwHGzG9B3lrgRn1r2LVwKVz7y1izV4WRIVOaqEGiCnEa07KIaqS2dL2we/M70ueaxhoqxb7Cf/5i9W7fczhbohvyWA9q5AlgQYBOocuNdngln/Ajx9w9IMDADKroNQH7WnR6DQXl91jOlJB6qUjftdTgUf7eMqkYOiXYZCm/5a0rSFQorDNOcH+S/gpPe821V9Q5F+aXIwdrPc/icpi84mmF9Qh4YDoe0tyrsR8MvvZJHyEUlGfnyV246Pki+5uPDyVOB60iqwVdINdp6wBCr9mc9vok2V540reCZNvD8kujA4gA6aVU2rg2WpUjJt8GaieR5SqdhRhH9ivPJQtTTEkyiIaiaQoQ+8zaA/YjTUBo95YgyEmRfVABdLgOCAeOIFVpZaXWpselMPXfpV6IgchvL+f0uF+bHOFvH03xEEh8S+sTWsiEzIBAFANXfYSyHbLUfBLZF6n6AM1/c4wT930Op37d1V+kWNIKd2rpVmg64H+H+ef+b2K9I5rHhh+HbbYFxLZo1wg8+Hpk2pJGfjH4PpkhlZuTSixtCWBDcDx6FuIubgZXZ6LMl04nmsN4xMn6wJrx23CqL+bWdNpMFTMDSLfnScmZaSPJyvgZAwPdZdw+KKY1V9B7PB/Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WDJR2SziXkfvDqPW7wCjqB+If7Z/+BqSdvEMG7No5XtDrN6dxAJ4MMk+m0?=
 =?iso-8859-1?Q?fZuWx/mBTv8XafKyPaQdu83Vunm+VrYThOiO47uYZ/gUJif50xigfLQMsJ?=
 =?iso-8859-1?Q?9qzjtMj5tq3/CbEPCdt5ky/Y0GjlVCV+FzZ7dIFcgQXSna2d3MRiJhoddq?=
 =?iso-8859-1?Q?JJtELnzVqjc0DhvKz+nKbEE7zGGiFuidi/GcW4WzIC2FbmjtqKbxbN0EPb?=
 =?iso-8859-1?Q?5yAdFgG/4F2VWQtxsMBJmXowphw7PGA1Ne9KnSEwDATENbJa6ElEhKIzLL?=
 =?iso-8859-1?Q?IJ4LsHeyiFymH3Y8JJ9Bze0fsxRtX5l4agQaG5L01nc+4j+/1XyS2KPYbn?=
 =?iso-8859-1?Q?OeajnBJXPMamoilwsCMz0wtjvzjtw/GeolG0VLtQeQwn7+NK1n8h5/mcal?=
 =?iso-8859-1?Q?/DsWUBxM9ceGSbbb6YOvQKfRjOQm2Y4BA1FTNLxqBr+hV2E8Z0uZZ7xpnN?=
 =?iso-8859-1?Q?HQlvPo6GzAQSagwlej6VW6929XTEnwdVEN+v7BbbV6GXtZAwp4BhShnnS4?=
 =?iso-8859-1?Q?/7v/hwyRG3tJuBe9yQaxeva60M3sJjD7W6B43RFolMSyVKngLDIx7RzI5x?=
 =?iso-8859-1?Q?9yk7sBzQomLE2Ij8W9LXzEcgesfnKGmd9xV/4sg8igENdO91I5IV4itvfQ?=
 =?iso-8859-1?Q?laWUYBuiioOUQxG/KCwNJYw5mOGJ2+/rM1NEndFPqo4HVufeF6Wd+21mhr?=
 =?iso-8859-1?Q?ovzfOt99LoYbCW7JH1geOZszzvMX0kPktV4OZcifChHvEQaWdh5c/ybN9U?=
 =?iso-8859-1?Q?O8ViDl9Jqd5GDOZm7Uo6ua2MOlcJodN0dQ7JLbStsZ4kODBWwx4i5c/0rc?=
 =?iso-8859-1?Q?VJ8dEesIakNggcLVUIW8YrqC8yOmNR2JTDedcm+e1/MzzZKgyP0z28xt1l?=
 =?iso-8859-1?Q?YzeZUwOPBx9EBsL12sLlheZHs6m1d09x2F8gBZ3rl3gC11I4mMVTVqj+EP?=
 =?iso-8859-1?Q?nM5avYWoZkNdNJYF32EEGOepB6OatSz4tpFh9GwgHFiNKvvg67otWmqKCc?=
 =?iso-8859-1?Q?rxA8MEn/YHfEUTyHOir9GdPyn1Rf/+pbh+psf9vY8tjWqSXjNYffkYulaw?=
 =?iso-8859-1?Q?QAB/vmKVdENLESCV0kzTFJTMtiq8HtMGkNM7p//Bs74F2SJwlu8MHbyTBK?=
 =?iso-8859-1?Q?nrHE8dHp6DE4rwBzLgXpLQdt1iI8DEu5N2+HFlpHnm6atsIgtWcjqmLc+s?=
 =?iso-8859-1?Q?fYd1ic85ccWI+kZqngrR9b0bw4rwQCvG2CJ5E90aCHGDGECBj9mw1MDS5K?=
 =?iso-8859-1?Q?Bo4udr9iLdJ+gUvM2MlzJ4G0eoJZ63Nn95mruH1wOYSXazfq7tlZ0ADbWK?=
 =?iso-8859-1?Q?LxuiFuazbTBX1Bnsr0Hj9HDI3mE5UgT5qjvwEZgArcC1G2FwF3rJDGCVJy?=
 =?iso-8859-1?Q?CmR0mKuUdaTaPUdNnYQRTlmICMyNGNoXtRVTKERS9GiPoKIDXUB4gYlK8i?=
 =?iso-8859-1?Q?5QT20DyPfN/ed1ad9r/XzCHW4HsToT4UNzrXKW1kvVsDTJsu60EN3+YTKI?=
 =?iso-8859-1?Q?O+9I6bwkZ4ZiVoDkBNvscMRvpfGCg5gqlnDoGWMaupttnCdLnSNdWcH1tB?=
 =?iso-8859-1?Q?JxltAsM4GU8rw216pBZgWqwO88iVAHUovt92XJh9aM8IkJAVxsHIp5yC0z?=
 =?iso-8859-1?Q?G9gnOmxhT8ZFfgpJqnZvChqriPTZOpCJ1FOpYaLxd76+BK/YjElief6rhb?=
 =?iso-8859-1?Q?chHxRBgRyRQEDwtnf8dMroTtu/uOCqM7dvft3lAEJp13MJ5yo6yTsKy2Ug?=
 =?iso-8859-1?Q?4MWKoFg2qXpKN0Az3PYOQnVMAHh0WRy0IQly56bRoFlslA3jbXAy5F5F5K?=
 =?iso-8859-1?Q?FRJPMIevFlgSEVRgLV7kK0RjnCc3HWM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521d7658-309e-4fee-47c0-08da2d6b60f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:59.9233
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIiHie2jyxKTPVq+Y64cV38C+ld9FArYex7NFash7gQmLzYRJnX6YiAkm/RvfeQApHFshph9STE04+axELNcRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: LnJ1059x--L2HSm6XcZDn0imy92NGPS2
X-Proofpoint-ORIG-GUID: LnJ1059x--L2HSm6XcZDn0imy92NGPS2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The VMA iterator is faster than the linked llist, and it can be walked
even when VMAs are being removed from the address space, so there's no
need to keep track of 'next'.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 ipc/shm.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/ipc/shm.c b/ipc/shm.c
index b3048ebd5c31..7d86f058fb86 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1721,7 +1721,7 @@ long ksys_shmdt(char __user *shmaddr)
 #ifdef CONFIG_MMU
 	loff_t size =3D 0;
 	struct file *file;
-	struct vm_area_struct *next;
+	VMA_ITERATOR(vmi, mm, addr);
 #endif
=20
 	if (addr & ~PAGE_MASK)
@@ -1751,12 +1751,9 @@ long ksys_shmdt(char __user *shmaddr)
 	 * match the usual checks anyway. So assume all vma's are
 	 * above the starting address given.
 	 */
-	vma =3D find_vma(mm, addr);
=20
 #ifdef CONFIG_MMU
-	while (vma) {
-		next =3D vma->vm_next;
-
+	for_each_vma(vmi, vma) {
 		/*
 		 * Check if the starting address would match, i.e. it's
 		 * a fragment created by mprotect() and/or munmap(), or it
@@ -1774,6 +1771,7 @@ long ksys_shmdt(char __user *shmaddr)
 			file =3D vma->vm_file;
 			size =3D i_size_read(file_inode(vma->vm_file));
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
+			mas_pause(&vmi.mas);
 			/*
 			 * We discovered the size of the shm segment, so
 			 * break out of here and fall through to the next
@@ -1781,10 +1779,9 @@ long ksys_shmdt(char __user *shmaddr)
 			 * searching for matching vma's.
 			 */
 			retval =3D 0;
-			vma =3D next;
+			vma =3D vma_next(&vmi);
 			break;
 		}
-		vma =3D next;
 	}
=20
 	/*
@@ -1794,17 +1791,19 @@ long ksys_shmdt(char __user *shmaddr)
 	 */
 	size =3D PAGE_ALIGN(size);
 	while (vma && (loff_t)(vma->vm_end - addr) <=3D size) {
-		next =3D vma->vm_next;
-
 		/* finding a matching vma now does not alter retval */
 		if ((vma->vm_ops =3D=3D &shm_vm_ops) &&
 		    ((vma->vm_start - addr)/PAGE_SIZE =3D=3D vma->vm_pgoff) &&
-		    (vma->vm_file =3D=3D file))
+		    (vma->vm_file =3D=3D file)) {
 			do_munmap(mm, vma->vm_start, vma->vm_end - vma->vm_start, NULL);
-		vma =3D next;
+			mas_pause(&vmi.mas);
+		}
+
+		vma =3D vma_next(&vmi);
 	}
=20
 #else	/* CONFIG_MMU */
+	vma =3D vma_lookup(mm, addr);
 	/* under NOMMU conditions, the exact address to be destroyed must be
 	 * given
 	 */
--=20
2.35.1
