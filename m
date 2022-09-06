Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1CFC5AF519
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiIFTz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiIFTwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24558B9B5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Icrac007596;
        Tue, 6 Sep 2022 19:50:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tsJrNwS2OG5zDmNZbRbGTard3C3QCHBbjsdQV90tTYI=;
 b=JA8JEmip8lo7HKvxjAof70aH7aeHqNecfK1vKysAjiHW7Fe4sYwtFeDURWKEc80PVLif
 e7ZJ/oPbVWidhPwj9dFih/gISgkdGfCSJoKOtxcRMgxuKEAsqZjTFsBhik/Uz8k3MzrX
 YUAWHbzYXsfE7fm3FGen7NoDIv7RR5l5Br+LTLGdo1ulQAaex8EuZG4BAgpa6kCbrLZg
 Owi5yanVlf7mWP7sqwpuM1j3dUSrhY8LAhT4w1lPq2cA4x69vosy/C0sSEfvhCR8czYy
 6JSyvDoKB7qQ9kCTrnkFbdaDxqVzYgYap+uYnhng/DgTFd+uzX3imUzSe+X0Kim+A28X Sw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwbc6uqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:29 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H893c031227;
        Tue, 6 Sep 2022 19:50:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc3ajqe-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVB82BOpKDeeOXNt4u1ovHCmGX+PBSX6ZwBAyVrw0EEEuZHD++w6MjvmhdmMZ1aceIiPUHtP1WwVstwGBGaugfrqqtgL6ad051smDns6zJ4li9p6HsJVhOZM7h8pZJ59uqnayYBo4XHCXW5mqogLxyDB6DW8uFVD1ey3aq5SkeniqM8M14EOiPBD6r2HJ774bKVRaJ/Eq12fGp6MfqPqNcOJgKljiQukrNanE/siBT5RMWna2kW4FQCl8d+joj9D3OOy+eKIeipIwhOGAyjbDdzr060jJRSW1F97gRKQIww4Sr/SgrOM5PWq0Hd/GAsQE19SevcLQHVvU5p2Z9jzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tsJrNwS2OG5zDmNZbRbGTard3C3QCHBbjsdQV90tTYI=;
 b=Ed2haxKVKiWQpz8EpdklFFe5hyFt6XlyXS96a2w2f4UPk468ChU4A44wq9zUfSBFt65K/3gvsy9SJ9RE0gNZaQQ7Uc2mPfXfKCCEq5cOiqwFxN1Hd1Gbz9ysw3qU5rsOXdr0bTjV5TN94tB9Ir91R7rCKqvQVfTQlxvYte07uzX/9q5cQXIgdLueRe0Z+h5FohUV2/np+i1ZhpZAERnoMHZLYR1MQqTKWFdIEveFnwC7Yq3c8sGHbzLqPUsHOKl+XOiRog/oCJs3ZTgDG+kZRHGErTWnDpShw4/q2lKRW2cg7g/SfF5o7FsU3a7MNvrFSsdPtotvDeC3Xx5fEKApFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tsJrNwS2OG5zDmNZbRbGTard3C3QCHBbjsdQV90tTYI=;
 b=ajSa/TT3aKmskmCe1jzi0iqXqMi40Bghuz8PTrPdMCp3wcnH7qc7phrGBYkkzkyCMcW0AUNk4qsK0CvKDzGpBbG6opEI91tYSR1Zw/WRHDDgccJD+WGY0IWaeFMZLHt0ov0erl9xYTHlpaQjOSdiqGjAPv8t+XTgyA1wJfizVDA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB4876.namprd10.prod.outlook.com (2603:10b6:610:c9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.15; Tue, 6 Sep
 2022 19:50:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 70/70] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v14 70/70] mm/mmap.c: pass in mapping to
 __vma_link_file()
Thread-Index: AQHYwim595C0T6GjmEmEBymU2vUhZg==
Date:   Tue, 6 Sep 2022 19:49:06 +0000
Message-ID: <20220906194824.2110408-71-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4db22f94-ee82-4018-53ff-08da90410b5c
x-ms-traffictypediagnostic: CH0PR10MB4876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6NWKM1reQrWBDZEsc/tAr8osIaUIN1zqi5OmCSVmyBARB2huMydIm9y6zRVcDiNhjtv/ppmZr55LAjdmua4JSZ/gk0nX1XcKKhnoE591UuHs6nd9Za2OdvflFvq8d24ukOqAx2Il6oqoZjntU0IunCd2opT7T9+FXGE7IQn48/T/258K/eCo6wAsdku8zTKwRhp4QPrat07S/h/PRiWR2l6ql8uwWLt4nMKo8zWYB8oSDrr2iroVsFyWKB0q2duU1sTyGcuxrfNgZBYcB5zK8gZYwf9jv+C7De4MAyKyjNjRR9p1JIj/p9UHwXp1McZ6+IJF5oqptM2uNffnjVoiHHeVSTERc82xTdpHQJRXEpw7dp/kCbfvixdlCz/GBK4GOVF05LRjGeETlm/e02xvl/TCZ7idneO1+dRZkGIy7i51V8in+oucslGKbEnw0AGvw6Ap2QgsuLtdW0fAfNSIXdGmbeI7NbRai7lmNm9BiF78wZil5t2aYBgt+mkJ6LSt7bYavShTCHhTsMfYGMv/mcMvg0XQFXp0i/9NO2LkefgPpIj4/ka19saKpNH2YsWeKN0Pi2rCNCOIyO8fTuXu9ow4yr4Ia26mxocN7bhRHU71CUIQBfrHUJlxzBdQfxYF73zxz0hMRAqj7+Fq1PO+uVeUmlbt9Dsga8RPwsg1aHmS37StqlQ5VQ3kN1kqleGORwyMxpXwAoEmZifWa4R/RtfDFc5ugv6It7Aofo26vzuErqyXU7FcuM89F++AGy2pQUB9FNjd71z/uccoz9l6cw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(396003)(346002)(8936002)(6486002)(8676002)(4326008)(91956017)(122000001)(66946007)(66446008)(186003)(66476007)(76116006)(64756008)(66556008)(2616005)(38100700002)(38070700005)(478600001)(83380400001)(36756003)(1076003)(5660300002)(41300700001)(71200400001)(6666004)(44832011)(26005)(6506007)(54906003)(316002)(86362001)(107886003)(2906002)(110136005)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tnzl5lYegbnHgfc/h23ok131RiNur8KccdGaEZbJQmV84jDdQjM7kHFc0O?=
 =?iso-8859-1?Q?SHD0bLsrcRTIYknM08JCHVqyEQQKNj/URMNj60LQh9BDdn/7DEx4w5OKjv?=
 =?iso-8859-1?Q?j9acVItEb/bo57jGWeUOtWd1tor0vsda5xuqB2D5CTvC8bSn/W7D6t8xZI?=
 =?iso-8859-1?Q?7Va8ojOOfu6LWuZiLDIEfS2kJxS96B+ZFhTJnSqv5G7Kno4IQVHRsM8khk?=
 =?iso-8859-1?Q?TmS2EhCXkMnkHGdgme+bkxKAdG3WAsBLb6oNUAUIfwrwkRkjtxZfvPYsef?=
 =?iso-8859-1?Q?L13oRHi41TSJxNargo7oaYdtQdXdXXvcspDJeepdIJoKQCouYLJ6l1EXB6?=
 =?iso-8859-1?Q?rgDhDyVEJmfy4u2aBHf0uiEhqURp0f2mD+gU8CYjRYa58WBgGqPlLq3ZGU?=
 =?iso-8859-1?Q?CcIUuT2oGTmNEWF9vDyOYSFUOMSI3zJp+Eg9+Kwd4Fid1/wZhX4YAmJDgg?=
 =?iso-8859-1?Q?0QasapLj7wDlk8diPF+o1zmoWNyDbiRQWA3SEUZX7yol3FYBfeUG/2F6N1?=
 =?iso-8859-1?Q?tve/VB4QnRGKWphEH6Z064Nl0l+geQb9XOllgcqdEP6pmeqjclXHKJjmbo?=
 =?iso-8859-1?Q?bkiDFCtAOI2nZrM2i0o/HqmLGUm9Ms9acMjUtM7x4vEYzDheD8B/Ww6FYZ?=
 =?iso-8859-1?Q?sNJ+vF9esr1/IOeb38FyNZ69yMNIUXcYaYJ0GHHWP9K2f6kSc451vJdsRu?=
 =?iso-8859-1?Q?nXQDhXjp7cik7jQYir1F+gqFYH7JMQf4xX+Jz44U31dpj/djrdv1Q3V7Ap?=
 =?iso-8859-1?Q?7ANeQ8/NubLnb9yQ+9K+je8pTpyifb6aHXnuSPaXB1jXugVtl/mw/e1wH7?=
 =?iso-8859-1?Q?F0p1AQdrW1gN5WSUzdfijLIejHHBB8jn7pfSk0WWThauDLgjxyAEWYBZW6?=
 =?iso-8859-1?Q?vvz0nF64EwS+cGeJQ+Mv/3B9lLvxYIgAHLiQ3Lk1+iqabG+dwkgQFX2Oy6?=
 =?iso-8859-1?Q?7pw0N6Bs0r9UPDPgRa0zeiDr+BJ0L46gruV9rfxuOjE0DQCLO2wAPNtSDz?=
 =?iso-8859-1?Q?EKkxtZbNqM1vgyER+GXSgVNyjXLWva/T0uAPUKy6bcHJECVjskeK1yA/8G?=
 =?iso-8859-1?Q?PdncXn34Q9aFbIuugGwSTJBk9whTICBF/EdRU1ow+bUJ5zRFg99ws88DK5?=
 =?iso-8859-1?Q?9nE8f/IE3O+F+dR9plGJ6Z1iGtdC53kvg3xjUYDuxmjtqwNf7GFREWTsjv?=
 =?iso-8859-1?Q?TqXeorqKuiso5Udbylrr1WbMk4kj0fVZxSMC0dhhFgNFtf53rNCTVzpKXI?=
 =?iso-8859-1?Q?PFEjI4o+8H/TYs6QgUxwCCD2iL1VHExJSPAUuLAcpf+/rMDqVT/6kj6pbR?=
 =?iso-8859-1?Q?2cfIVTVudc7tT7rcYrJrkI7Hhlrh3gvxEE4IXcMsx/qjcCVlv3Mp5tpk4T?=
 =?iso-8859-1?Q?oya007LCuzsCe4Pyx8iq+x+5WEBzKTrYkYSt6+5b8gFphV19FDjiSiowoi?=
 =?iso-8859-1?Q?/LRCD4ZIHQzN7smJO9CyF/p9zyTIhQZnRAfqkIXNzev02Dm6TSoipE+E4v?=
 =?iso-8859-1?Q?SHmygS0iPNXXEBSPRHRG5zW1CJaIaeH9CVFeKt4fk8AWqtlNPkS89wzE1s?=
 =?iso-8859-1?Q?qgZbnV2QG5Mc5U1uMaQ4HOodDpFeL6JFTyIGoclLDlI7EV8dG9YlgO2vVG?=
 =?iso-8859-1?Q?lG0qu+E1lln9uZAtNx2fbvxjd+yaYcxSQV9MeMQjUYPjOqzr1YGomsrg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db22f94-ee82-4018-53ff-08da90410b5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:06.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYnMy981sK8zU6w//4LiDXfwYPyDy2QP8MdZ6mcppV4l2ilSH+Qz4oifZL7Xx2u5ALT5DWwWKe+/C91rwmQ8OQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4876
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: bK7-hEb7id3ONE5BrlPlLXvrJRuFlltc
X-Proofpoint-GUID: bK7-hEb7id3ONE5BrlPlLXvrJRuFlltc
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
