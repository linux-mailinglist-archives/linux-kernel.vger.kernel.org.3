Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67FD5AF4F8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbiIFTyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiIFTvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:51:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D24A83064
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:24 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYZe029954;
        Tue, 6 Sep 2022 19:49:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FuNmZU+UMH7Y8mw5oBbNoLDQmSkii/s9w06bWHod278=;
 b=hJAvIoXoWtIMJ691vN3PM4a5u9Dx/VsQZsLObedr+pBeNQ27IcZSNXEsEeKB01DxCskq
 ZJIphcdKNZXv0FpNogdVzPSvf5a+cir80FSnc7149ySS6QVQ/7C7kH4R84Vz4MKXOp8D
 MaS1kRcs0/C5Ldgho0rJbORWgmvleE8I8XDKadpRTVaksAT5NTaGG9sywVSSYS58r8SC
 MzBatpp7Ve0L4TgePEjvuWO+FAfdrEC7vuqZu7ZaHAi/huAFBgn8onSsf1ayHc6HZQm7
 JF1DTbB4wjkCKKzZXRH8SuEj//0tqImDXY5zXMJyT2OPBAYUdzp/MvfAgjurJOZwUG40 PA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:40 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JLGjp039722;
        Tue, 6 Sep 2022 19:49:38 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7h2-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dpp7ZRIcSPVuL4EMa8/EChzZlQ90vXtiev0hesBlqvCs6Gr4cLMKtCuExQZn5+jnYkgp9aZUYVAhgeA70QgoXp29ycJ92R6WhhARca++m5mjoaZ3eiyFRO+JJVxVY+mdGTP/35+u1GwO5sfXwgXLbmKuuLW+42kgXNfSuD/8LfPvKAryvpHVT1nSg74cioq3wqD7PZvxxz0v8n5BKv9NIgjF3u4hIcHwFb9BVJp/py0oEX+WUWHFpJiNA9TdzZW7aSfU7g3F8ZWUkvoPPdaz/YXL/arzVhlJs0D/yVFPXGfwiSBSnpXPuPV5ktk6HTR/e1ONXvoUjENCoQY2DxuDOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuNmZU+UMH7Y8mw5oBbNoLDQmSkii/s9w06bWHod278=;
 b=ob0XOVWrfxFxgHoL6G0YYCJlrCStPqmvOhMUfvC+d5cjdwEbLas72IEbp3L4mG+hoqQeDHgBPXK3Iqpf3mypgSDks10Chgu0LSdjtzJjEnTsU0TEUlxVXpy1gMEO3DG9dMEVcE2F9Sfn3jESA1WTLsmtXpIH6Q21uk2ycRiKChvTaT15xnp3sPFcjQ2Z2m6k+rk+/PyqyKxMVlB4Io1BJMCIZ+pe5Pp+CkpcGaXpC4jh+NCdcXKejfudxdUmXWRIyOuhw5ZVXbCIA9B7itICQ5IyLF6FC+lzPZbAn1zC+2JXulaWgFyGO6H8Om6YmCqITicwMGc1wB0J9kRbZvNtdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuNmZU+UMH7Y8mw5oBbNoLDQmSkii/s9w06bWHod278=;
 b=BP/FjB1BbHC2YqXNbXGbPJ3s8GD4yOuoE4F4UDflPMmIS9n+u7iI+hOVl3UutGz3ZGfZJkNQjEfHCngJZOtzQHEkU33gUTZesvWm+6JQrfW8AfyqdUYBh7U9siEegoeITvdWTCfsBXqmG4DsN+qB2b+UhbB9JXPT+2o+TmyuahQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:35 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:35 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 33/70] powerpc: remove mmap linked list walks
Thread-Topic: [PATCH v14 33/70] powerpc: remove mmap linked list walks
Thread-Index: AQHYwimx5xIJItGJRk2mcitGBwUYWw==
Date:   Tue, 6 Sep 2022 19:48:53 +0000
Message-ID: <20220906194824.2110408-34-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53359466-70b5-4bf3-a057-08da9040ed39
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LwK1sYWBBfO0ciFwPsAFkHTyzTORUPBd1ZnL+MAWNPTTi2TG7U3wGL73g9uWTt9LbBiXnDKmv3XlFxknPj5H3bkKXv0JV22eUSeylSFM/whaobF2uUa41qfG568BUip6ucJ0zxXB6OMS5V9FU7RNCDCgNQfKtfcicPc+4JG/65sYe/aINRPqL/f68phDySTdPrq/FIcdpJDsFnAl5e8agNqLLKqywhTNQdJbo8+wpcDi8TWkx4tUhm/4DL7JUOj25hoiAvQ5gXxCvOJabLJjbHM1kARkG02QyNmkwSBkA8UcxLSjBiBwLvqMSftqGDlUBS64/BD0xK9XFGrumIGMjSlLytGlRh3bRo7x0NdNbCY21Ch+01Tj15XvwOY7XlnSDjXTGCQ1ekyUT9CXW934fMyt5slv25Ch5PMnhNk2Oie4EJTXLLkOKIkwqdDERbcUv4ScMwcIRcfzz0V7c32EglGyEd/KHpCqBihEt7ivfrql+GHbm8weXVZm5qlTr2M5sgL51axmPqVbGPsPNhRu1yLxVIBKK4YRITPLY9JZ8HUIKh+DUd3gnCl04tjpd+UXGrXUXRINP/F00pFL/7cnC96noNA2Nh6wf8PI4SqLlZp9zSkih0AEZ7VhMpVBLq2f7GwwlRcjEjaDBug5aFvl7i+LrQsEnwYXg9gQDhph3u3ntSsBN0gsfW/FKgs4QHgJefbKPYDh/I8tljd1qs8h5wVQwuKLMMoKyQpbbd4n57486bdhQZMRdgkx7k58wKtdglDOwA6XJKFvRwLygFhXfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(7416002)(5660300002)(38070700005)(110136005)(71200400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?q6MLiFPdglHklmPsRn/oCcMc5tVIpglrqlKskSy1J7jH4QQuxcYT1Zr+4v?=
 =?iso-8859-1?Q?QT8m+NpHKKmWzYiHwptsK70mmXbdXdPDCRbUfLS5z8FmMojh6Hz26gDOqK?=
 =?iso-8859-1?Q?GEivL2uEZkIvloXFIadck4+WAUOZFG5jgTZGimLs+tCI1BcgpxkWKbHHx4?=
 =?iso-8859-1?Q?BSBfw4DE//YmGCi4GZWkKMpWRFmR9w13tZ5/XwV5eUmFI3bgv6aEV3vsmZ?=
 =?iso-8859-1?Q?v7gbx5rMFzOJZ2bmDCpxtl2PyU06dtyNgmzcMHmkOTbTJk8RTD2Lxk5tAy?=
 =?iso-8859-1?Q?ePaBA0kpm1Qas7kgba2a17ZEP1/CMOLxSIfGCvrES697JU69uH35+eTUTq?=
 =?iso-8859-1?Q?SZhHtKTvmRmmkFc8q+kLjLDwW95gu8OWOXvXK4Olqr/7xHMgwpXEPqSalv?=
 =?iso-8859-1?Q?zSykkQb+GEq2p13FgWwMhK0TF2fYHby/wUSAIVOA1reg+9vOfOPeAdoxDQ?=
 =?iso-8859-1?Q?iXSmeL1bOXxvOEX1GMJZXIydidcb4zn1bD2rdZb2YZCxcs9PlbMAma84sc?=
 =?iso-8859-1?Q?qh4SNd8A7UpmSeI4o0BfkGKgnJCZdFbqDjH5z748zkjYq/e7RzIHlQvFDf?=
 =?iso-8859-1?Q?3WNyB9j4faO1m9tE9OO4+8lXc8bF6NMBv2bjSJc5JdvEwPbZpwWpcEZmZM?=
 =?iso-8859-1?Q?4ACDGbPdrmP7d5XiLU/TXTHsydIYbYNZ7v+pP5NPekWkt4SOInXogqQ1/r?=
 =?iso-8859-1?Q?Opvf1dDEBKh4ctWdpBQ9xuZNn6A0p7B3ZW7cr+RnwIgDjH0RlUg+IMKMLF?=
 =?iso-8859-1?Q?WVRlZXjM1jR4+sKLFFm6AK+FkBpEH8E8QPVlU7drGNhFpTceWJCOyuLGwu?=
 =?iso-8859-1?Q?tEevP6C8/8yEvYRhqLAGX1m8jxIOm06p5EYzynAj5pP3p0H7PfuH9Aoepj?=
 =?iso-8859-1?Q?f9rrklnAPbyjw7h3kWQTb+kIujGwOVwQZiuukBsYBqHD0tNUWmZs9HmILv?=
 =?iso-8859-1?Q?QUdY0oQsf0dvxFQZtXXv27DNrZa4JiMpe3/YhKsojn6IutU/zXdPPBOl9y?=
 =?iso-8859-1?Q?jb3ns+u4cLrbuyRnLp9hLf+ShTtqcvTSlsML7uUYhLLFRgbIPziEqHh2iS?=
 =?iso-8859-1?Q?MY++VwBnBEUKOiKFb6OzAh0SPEzkE1Cpi5fw6BBPS7AIYTI0Dhn8Yxsjki?=
 =?iso-8859-1?Q?H3wQ+4icBd02EZDjVSliECx6k7pbzFRycVrgxvB+BFZ2ptxqCCCxAaVqzS?=
 =?iso-8859-1?Q?JXzjD00C6v/xAFwEpd2CkUOKbWCit5zOCvFZor6MxxWBdkqf5fBdqc0ng9?=
 =?iso-8859-1?Q?Eggds3VH+vbNz7U2AxhqCwTod8fZgQraKVqOBdGd+eGnzPB6NjavDq3MAE?=
 =?iso-8859-1?Q?/Ih2A1SNhlF0nX3Lp3iP5frnup8gm41gjuW3GGvh4slNhYd1rX+O3L0c7F?=
 =?iso-8859-1?Q?bFYSQMifmyBpVxEBiVKbRBwaJqwDdFLXk0h/gEBK6wNtx0DI/zKZ8L0qlb?=
 =?iso-8859-1?Q?HYYI/uER95XQxIeXy+xpad+LrOZSlYIm7w4L7RgrpPbEghk+YzpkQtwtCS?=
 =?iso-8859-1?Q?bAI49043d9h3tq7FCZ07g1bseZH/zfdJq7cGEe/4f7McRxR9Ip0Xzt52jW?=
 =?iso-8859-1?Q?m2MiQCGK58b4DLex/4zTfEbpkgF8lMGVRetYRIacsTEMDvmmzZRBK3UN/J?=
 =?iso-8859-1?Q?vuw6uSHVONyGKYce+xHd0gC1+/bN2JEb8xAdvWlQprcosY/FTvT35+2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53359466-70b5-4bf3-a057-08da9040ed39
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:54.0220
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Xf41walkvsG0lbpK6jt31wJKxU3yIJgDC2gKnnaDBvLTzFCj7iXRxLMyYqZKsRL1Sn0lJHkMQKldX2MyoL/CHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: uJ7aQV3FSle5259LYBCTHSPyxl76J8Ut
X-Proofpoint-GUID: uJ7aQV3FSle5259LYBCTHSPyxl76J8Ut
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 0da287544054..94a8fa5017c3 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -113,18 +113,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.35.1
