Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E91519359
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbiEDBRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbiEDBRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:31 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9803531348
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:13:57 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243L4Hl0018680;
        Wed, 4 May 2022 01:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=ABgmNuG1ZoymVkkpjdIgBJFVKKE1NJspn9ag3Q26Ep4lXe1cLVd/3SbIbJ293O1uXNWn
 w110FkWinyAHBCQZ86eYGmLEWCD5ejE9AvsFwE7yL/6l/ln2I5PtnrAevmHbxEjxG1wT
 awARnDKq33On9FesiHOqbx2FxFo6Vzwevn+fwEliHD75im8MgmxqQWdQKcY/EBBonUff
 Rr0i3TsaqAErwfIix+h+hzkFcl51Yo3114eWqeVjfyNUa/UjiOAde42gGm38KaNEPLm4
 GJfVqx+7pJRaOXAlcVHhnCUBh0+ROpvk53+fca6QnNIFqy5s7OwDyaasjhCyTZZGGOZb gw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt74ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:52 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJP013094;
        Wed, 4 May 2022 01:13:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7tFDccd57MIq+t2TNopnvuTQFkbQtfZ0bZnmX8DQ2uBZfxyCbr3suSmNpHqLAvkpUTBFNl4C0nyjZd+0XU+Z8Z5w1Ta2iqwyIr/OcwmgzTJtv8vdf0wYTCHJSdqulJO1riTdnvxjwHQCAnNFmBvWyoo2B4H6JA7hVj7kevaT7qH6rYl72irwaa5SWoh1P9u76fxReSHFP+NGaMHDaDtuKDs3pmcxjfcrH7Asa1aMffZoQ/ILH38xp33ltc2nk4OgFQ7B5kCm28vlz7Wu3Lt2S2g1Yl1MdWhUHYqZtghExcUgAaLBSMYGPEL/udT+OkJAKyvTlyp2Fzz6NvQnaI1+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=W0ACyDE83AASQsSwEIyPs+t8mAi85POgO5oshV0G5vQbT9VTN9G7HXSGik/l7+7uX+Hb15ugbSEp0UdmqWn6ZZCFWSxCbm7rUdikjHia0S8kh3FfSiwhajU4IiaVKoTWTKS4zXK+JyG28ThYr6SbmOW8GrMxxZreaU5Yx3Wsyne+cVMLn4zRmJKd4wFrwC4SA1+jh9D32UTBwSDitr82SjZRvRDd6DlSCRuA88wi1cfzRnDlhvec93GdFOwmlIXXHG7QvoAO783EsAQpDxilyHEBewq9TcuqmmAv0T0yVIBtey6nVh4SG7zJgXfahX8s13rrNqBh3fhWvvLm25Ii7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+PxLWd+b/ySh0+LKvwuaq1AXYixHSY9W4j7RUhjs+Q=;
 b=mj4LqT3R9oLWZQXXmoZOKGqyhF4zglRMB9nLndSkGFaxppOvSr1K3d41A4LdiK3f5zIXr9cA0dTvLp3HS/iHbO3V8NPsQNZUEOdEq6JXOIHeU7fnLRxUaJ0kMDkPUDa1hEk+uQn+u35qbEom3kXZkHm88ICiTYJaP7FW9TkX0Rs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 16/69] proc: remove VMA rbtree use from nommu
Thread-Topic: [PATCH v9 16/69] proc: remove VMA rbtree use from nommu
Thread-Index: AQHYX1Q11b3lP4PU/0O+Ik1X3e8Ukw==
Date:   Wed, 4 May 2022 01:13:49 +0000
Message-ID: <20220504011345.662299-1-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504002554.654642-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31c3b192-91bc-4826-d2ad-08da2d6b585f
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB58305D5B6D8F752F7BCC25F3FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Oj3yumaeWRlZdyUztu8z7bYLKkGZf3O0L6As4yS8FcANAbT/gzZmfPMpYTFZXvwAgvOu61Iqr7IURMmvlXnZL07Cop3Tp3s5j7azBtOxjZy7YeJ92+dENZdcMq5gDqGY2QWnKZ6Tho0eXwHs4C4AGx8eVKSnL/nmMiLFcaJuPrbjvvTng1BOs6yl/LpDpRcntCa2P6ekZ30xauviG47C8lt7WAIP8b4mHptS5yGHkv2GDJjUCTeMdeDqyEaFiqhTWLQVXJ54d33Eq5Ln+aU2VdVqScWpSxHaQcjGN82uA2Pk/fbEY1eSjXvL4Wbg7RbZ2kBU8VFN2NymvPG0UA2MUMWvCUvHB264LBlrXLe1Vu3pgGNLg24THX8sKxrDTpcUOrl6wjYu3ySlPBfEdTFSjpBzqfHVcYDl1+1qY4EdTWtMSgD6PM1ZboGz8E+rTokiVnY0oEmfOksx00AE255apBfOlbm5rz44rEvNpgQC2h8HnmK0dukeI/9LbM2U9KUwEoq3Kp7Z74V5tL0tkJc/GlH803cj6InD8E3XqYFF5vs2YmZCv+w4G7tEX59T8Un7d/kedBYeXaQ/lOVNxoj7p58gz9jgt79FsbwzmHYwLQ84pV01K4qca0IzkcsA8Q8MIIeCCemtkL9GgugDInGenoe6LnALTCh2QeZxJLSLrMLC1ZxV9KKM/SG2x5OpAPTYqNhWFUunfBetZJYolLqaUg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XNPQ/dDDQPlgmh8A88P8jjc3ki4CNhwpBCXjxq78flNUJhsAkpkeLnHTOL?=
 =?iso-8859-1?Q?TSBl3+MZ3bp9mbsfD3SLQZHkWb5d/9JGHQkwV3GwHHNdJwHUB5RdUuMPk7?=
 =?iso-8859-1?Q?SJHzjE0iydzymq101P/EzObDsKsG+2g1xpCYJgdXVVFqNBFQY5Z9/vDjrP?=
 =?iso-8859-1?Q?3suAAlM+VGS5DDPk3KbfIqPX9uRLbrTmwVXvJA65VK+RvNP5YCdLnPRVU/?=
 =?iso-8859-1?Q?EPFDFTBjDdmb5Zv/kkGquUC6k31qPPpykySUsAkuT/EcmsL1gRz4kKSEFT?=
 =?iso-8859-1?Q?bPuCo85LuKtKqadK9u18m9c8RrncbKaBkh+0CR16GKId2yQ/8o926Y1/Lh?=
 =?iso-8859-1?Q?pJFp7QQqFaAmKAL15wFPuXMiXJeMxS7AAYTF70CJGqp90EYRdqYL8LEpLj?=
 =?iso-8859-1?Q?Doin9FQd3UVXRYWKkyGqy0MbyqyJhicnBecYX9RB5EIa/XmQIz0XF3Ck1t?=
 =?iso-8859-1?Q?+ma0eB+qEgocXkOpExDT2YkP2C78qHgQIDoIFhPAdi2D2XbKqyX/FyZvMH?=
 =?iso-8859-1?Q?B1En3HzHWfRDZS6wHgMi/egcDt0vTkFKl2kaYyccbl78HuocZQX/pw9RpL?=
 =?iso-8859-1?Q?5/XhGhp58eKU76tGK7L/BoUiCjnRtWC1FGYQ33Z3/aHcepL1+6hvbpTRVO?=
 =?iso-8859-1?Q?3n/HYsdldeDZy4KKqdWTJvZhn29Kz0fXFOnnjItXq6q7hkfqmZQr9dCwcG?=
 =?iso-8859-1?Q?yTv89CfDNisljAdHhS7X3sgU/rcZ794SN4VlmjaWdSiCa83/fs3IyOSrBD?=
 =?iso-8859-1?Q?/C1MCFITZdmuAaVy95Is677Asj9qdYmCYElJs/5VTELZLqkkdLAGA2BUOW?=
 =?iso-8859-1?Q?hqBykKD3bwB02Ro5lUdn2euIgW1g0T/4cjJK7M8DCFWnquW+dwkT0VYOz4?=
 =?iso-8859-1?Q?mK2OrFJ8OSsOZbvthWqm9fbCSx7r3AMeQmrbY4On7qWxp6kDhs8VBeK+5X?=
 =?iso-8859-1?Q?JQHNNPh6pYYmZAQq62HQ/1a7X2eDusvkNJ48SHrS3IVXpsA7OyVocWpq2W?=
 =?iso-8859-1?Q?QS9fvk5ewy1yho86hYRygauk1nP+msq5ZZstdCZirvXIFxQCR9KiVA+Qv0?=
 =?iso-8859-1?Q?CdFMJWmRbZG8kN+UpGjKjv+MuC66+kUCyqRtwJbKn4hI4GMUbsZP1Wke6m?=
 =?iso-8859-1?Q?97bCcUCck1y5kMe4L9kcSu0Y9ql4Y+3FiP/q/hk1yWdTNkzCGonBZBxQNF?=
 =?iso-8859-1?Q?UNcak+2hSKDA5GQZbkK9sZ7wWLtQQpjVpEhf0ytZeDWv2HYFBIBAZ509Wp?=
 =?iso-8859-1?Q?R7mlyUSk1H7SWskRnhGaZdJ714N7UAQ/eknPf1PG/aA/hK5fNn31jmLQNv?=
 =?iso-8859-1?Q?+H3WmjuZ5RIN48QGJJTt46y2MPkYvaxICxCGPKoDQN5ogHihDsXXEPQbqe?=
 =?iso-8859-1?Q?NwhTd4ohlTsgq8WVmaBW4F+DjQyaHVfADB4ANtrzEziU+5Cl5HZr44e8s7?=
 =?iso-8859-1?Q?j9CJf1pGf9QPaytt25PJcGdp+LxqA2O5KSj30yCMe0aJtuvjkgQ338Wz+B?=
 =?iso-8859-1?Q?D1TbseE9VsulItAkvl0vti+unG8MswFCBDLus5rGsSu6BrgjlmDw6+btt7?=
 =?iso-8859-1?Q?Q7x3abJYz3SREmZTCmiNqszGDKFWE5VIvEnZpwUaEXz6pKNykPH3VXnJeQ?=
 =?iso-8859-1?Q?ioQEzDdGy9LllUIjaOpAo9C0Ew1SeUN8qJ15nTt13oR+AC+MqKL6nyihGK?=
 =?iso-8859-1?Q?sQ1TIq9URDB8+mmx6CnN0r1bMyqfoh3uc8e/yBCnzIaq4mJZxwJWFoowvh?=
 =?iso-8859-1?Q?6+fDsmYs/PnaJ+e8N7XaYr7MYPQOjs354RNnl5dQSwA+WRfAXkaW3n/5J8?=
 =?iso-8859-1?Q?7aaQtNxVBJxACjyJACXTKVgjhB7GB2I=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c3b192-91bc-4826-d2ad-08da2d6b585f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:49.3303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfrUDSofeG6IYlSjhrM0LofklkBWbdWP0AfiOQz4S5MaDRHSh/B92zRZseu0P6JdgxcU7qKctehgwjnjCyk4lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: JO50EmVZCEcuTqXhJ4qbnLmIh5mfEw7H
X-Proofpoint-GUID: JO50EmVZCEcuTqXhJ4qbnLmIh5mfEw7H
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

These users of the rbtree should probably have been walks of the linked
list, but convert them to use walks of the maple tree.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/proc/task_nommu.c | 45 +++++++++++++++++++++-----------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
index a6d21fc0033c..2fd06f52b6a4 100644
--- a/fs/proc/task_nommu.c
+++ b/fs/proc/task_nommu.c
@@ -20,15 +20,13 @@
  */
 void task_mem(struct seq_file *m, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long bytes =3D 0, sbytes =3D 0, slack =3D 0, size;
-       =20
-	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
=20
+	mmap_read_lock(mm);
+	for_each_vma(vmi, vma) {
 		bytes +=3D kobjsize(vma);
=20
 		region =3D vma->vm_region;
@@ -82,15 +80,13 @@ void task_mem(struct seq_file *m, struct mm_struct *mm)
=20
 unsigned long task_vsize(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
-	struct rb_node *p;
 	unsigned long vsize =3D 0;
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma)
 		vsize +=3D vma->vm_end - vma->vm_start;
-	}
 	mmap_read_unlock(mm);
 	return vsize;
 }
@@ -99,14 +95,13 @@ unsigned long task_statm(struct mm_struct *mm,
 			 unsigned long *shared, unsigned long *text,
 			 unsigned long *data, unsigned long *resident)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	struct vm_region *region;
-	struct rb_node *p;
 	unsigned long size =3D kobjsize(mm);
=20
 	mmap_read_lock(mm);
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p)) {
-		vma =3D rb_entry(p, struct vm_area_struct, vm_rb);
+	for_each_vma(vmi, vma) {
 		size +=3D kobjsize(vma);
 		region =3D vma->vm_region;
 		if (region) {
@@ -190,17 +185,19 @@ static int nommu_vma_show(struct seq_file *m, struct =
vm_area_struct *vma)
  */
 static int show_map(struct seq_file *m, void *_p)
 {
-	struct rb_node *p =3D _p;
-
-	return nommu_vma_show(m, rb_entry(p, struct vm_area_struct, vm_rb));
+	return nommu_vma_show(m, _p);
 }
=20
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
 	struct proc_maps_private *priv =3D m->private;
 	struct mm_struct *mm;
-	struct rb_node *p;
-	loff_t n =3D *pos;
+	struct vm_area_struct *vma;
+	unsigned long addr =3D *pos;
+
+	/* See m_next(). Zero at the start or after lseek. */
+	if (addr =3D=3D -1UL)
+		return NULL;
=20
 	/* pin the task and mm whilst we play with them */
 	priv->task =3D get_proc_task(priv->inode);
@@ -216,10 +213,10 @@ static void *m_start(struct seq_file *m, loff_t *pos)
 		return ERR_PTR(-EINTR);
 	}
=20
-	/* start from the Nth VMA */
-	for (p =3D rb_first(&mm->mm_rb); p; p =3D rb_next(p))
-		if (n-- =3D=3D 0)
-			return p;
+	/* start the next element from addr */
+	vma =3D find_vma(mm, addr);
+	if (vma)
+		return vma;
=20
 	mmap_read_unlock(mm);
 	mmput(mm);
@@ -242,10 +239,10 @@ static void m_stop(struct seq_file *m, void *_vml)
=20
 static void *m_next(struct seq_file *m, void *_p, loff_t *pos)
 {
-	struct rb_node *p =3D _p;
+	struct vm_area_struct *vma =3D _p;
=20
-	(*pos)++;
-	return p ? rb_next(p) : NULL;
+	*pos =3D vma->vm_end;
+	return find_vma(vma->vm_mm, vma->vm_end);
 }
=20
 static const struct seq_operations proc_pid_maps_ops =3D {
--=20
2.35.1
