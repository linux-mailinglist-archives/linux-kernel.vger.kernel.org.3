Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBB6B57ADE3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240870AbiGTCS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241177AbiGTCSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F32648E88
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1Kttu002392;
        Wed, 20 Jul 2022 02:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CwME305LRq4G077O7h1TcGNIrmWe5uIjM84VsVLr1XE=;
 b=b4XBwZfWpbrGmiUyOvPNcDxOlZJ2enJoRmv5Ql4mismCgTdL0wmvoHZiAnRaniKi5k+Q
 MbTaz7ay2ovYv7i6gLzRk2QzKxc8d/MgULzLblWyh7ahaeAp7hKVBL3ZsXRjB3uWKcJE
 x0L8IrSXGiCI2Z7lyLSh5YQAVoNm+U7nyVEwsc1wM7oTezT8sL15P3hisWrcAfRM5xvU
 hzzFxfikyUsWXckS/YsEHu1lMlIIqpfBt1W2H9tDsNJqsED5GV3+RVIL9yrmga2vsU+y
 h/SGt3aVrlIxMKs3a/tyvnRGxBIEMti3UOM5/qrhuj9Zl2ECSwbcwHx2uELOGdAX+gph Rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:56 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLL3022321;
        Wed, 20 Jul 2022 02:17:55 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVtKNs+TI02H5x+WAdzUh5ZRVQFh14kdXEJ9s7PVK0BTK5E0dyxI8qW7rMYhrduHWJRg1XoMomnK8FGQalocdljXOlKe1+oED0XGbjGosFxqfdhHMyydJ3kfmHYmRN/9jQ49F5bb4wjRrt9gaNwuHIa3X4FCHkj98VhKUEgthds1uyvm6O96/oBqPFq9lkQbU42K5uu3W75pS+52EO0GkWlt5Mp0QuxHGZW/WlTAaR6GALLSN4Ol3+GkWFWF8X0Wv1jwkCD4tJoWEPyiZT6rXETWbn9z0LTUbAErrcCPBv2xeYy3SdZrneiV5fwPGtcAUwhSWVfrP5MupalYu1Arcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwME305LRq4G077O7h1TcGNIrmWe5uIjM84VsVLr1XE=;
 b=iFg+6ATiYpnVjtXQtBIQT2e4Vc7kmCczEkdMI84Iqy3jVA7ndeR8Xg3IzXzMfBbEHPwbaxfJcVtLjPJFMe8SxbZz4FBUpctmQEhb5KeavKIpUosvO7P/abrGdn5644EINtDdy8KVHzKE94nR90dQzXLQV1+pxpGifIcAPA9+rN5Wlne8qIaQcxdishmOVaQHY6s/ViwlfwlOSYjx2qT02ohEG3ju2t3rnPUuILiI+4exjPnciAwEknrB0HGP94s1AFT0raUdZqtL16xe0YQKOsbOeQ54gWsJnS640qt6oSHFAYP5m2oI0ltBcZVCAc2IzeXXE7slvOOmCA0GE2xNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwME305LRq4G077O7h1TcGNIrmWe5uIjM84VsVLr1XE=;
 b=WqcuyLVwqGRTFNzKVUwJaflV2AnXE/qU+JEwwrM8XiS1cZrLQxodg/L0wFHE+8xrdKu03lkifxVZJy/32u9H6Iyz9+H1AZn4ZqbXfaux722imoipHW93wyRXipcNoU5rGhi/MaWJuuRI1yl7xUdQOO32T6ZX82fam/7SGh1W07M=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 16/69] proc: remove VMA rbtree use from nommu
Thread-Topic: [PATCH v12 16/69] proc: remove VMA rbtree use from nommu
Thread-Index: AQHYm97oeQ6gG46sBkuQDQdfN93VbQ==
Date:   Wed, 20 Jul 2022 02:17:48 +0000
Message-ID: <20220720021727.17018-17-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2da864b6-16ad-4082-ae55-08da69f60c53
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c1rSlmEtR1KbOkeVPJGV4NZ3kGfem/I3JTEJbgA0UW8YO8OSXOjUCxxK+ON+yuLx36nw/Nhx0vy42eMNnBqIoX2T0+gu3pVO8Z4kZkqc0iBYoYNkCHLbVT/gjt+YuBEndKUKzCQQcMXrLyW+F73T55xOuKvlgxVDSIIboKtO8LNelhq/lkhaQm+naY29kU8COGsob5981gYpNansta8+yY6Z3DhgGdjLJ5AyD1kxvZW2vVJhnUP7TbRF4nQuctqGO06Lm4Tep0g0852xmISbrW+0sFXO/tE9RHr5ZCamKk43mJlm1sNMZ57FTpyRkaqE7toZpx38vYBwsTjkbbqIT8DquVoEuSVos/NbQ4Bd5GW6d1MwkR2DifsIMKdqm5+dHl6SOpx4qjRSGlNHoucEn6K5dGk2MRk+Ly1QeIXekBDCtGEHhYkdJ6I5ZKYvZoRKrbW3nDhX6FiupbYg2ybl6yANckxoDp2vjIxTj7ViaZwLjBJnry1EBJl/6kbLnnW21kpXwyzWXvWR28NVzbXJ1rMs89GI6bEENNZGnxpQoWSB/2iQWtxmQOwxuxp9L+mRMHogQ7FO4/Umuadz+7eS3WG9ujzNJRM2FdmG+voobdkgghyEBgbdsmO5L1IayB98T0b+IHknW7mQbxbqleBpKMvt5ViUBuNzCIV3mIjUGoIp4JS1M8+MH2RThSBZNmBSy+U/1YuZnB9P8nlJ4QqJ7WVK3lME/lofit+rgZx/wqw+ULuvPIEpLrCRHg59e/uTG6f3RaL33UFjZFdqwsStsrMSlg7qb/T/5+SWYrk8eumbtIEn3CmFnvTl7Foi5K1swwSyG6VMHHYLVtN7tR1QFB0LSVAN63HYkk0316EhWa82kzJ8kGzEoTwv4OWytGwn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ex3sYwKlDI0h1/cXJtdzSu/RjglVr8rD1tW4phghuTbdgbeMWjEPin56vt?=
 =?iso-8859-1?Q?+647YLoWzT58SuLKt68bQfSkRw2q2KZuciVEx6es1rJgjl/VFgiYFjfRri?=
 =?iso-8859-1?Q?zD61cA99Zosh1vMd1wUCcRi/rYKifHNDCwykOLQwgfXWWMJw7yk/eLZsuj?=
 =?iso-8859-1?Q?YkfcvgR77Y81gSPfCdnIICRenYqVJBoX4ldrhX/yzwSS3sZwsvTq1kbjpd?=
 =?iso-8859-1?Q?RZQ3UXzGjeBt6I6bNi6LL8AC7+Ex7ENslQ38avw0n4sXfJRlrjA29JeGz+?=
 =?iso-8859-1?Q?aZ8OtoKU3Aaery47ILAW3y/N3yR5ncE6D49RuXnzpAYA+RLWXm7piuz65q?=
 =?iso-8859-1?Q?7jKjBUrWCRnc2IA9q22nV9mrcllWWzANO4IWY0sLy1ihmUMbRr2vs9NoFI?=
 =?iso-8859-1?Q?NrKPYcRMXqiAnII1bGZ7KIUtQhWM+RkPoRRr3N+udiRbTPnNbdlU4TUG7t?=
 =?iso-8859-1?Q?hF759crjdyViAwNp2kvm4REShMR87MTpRL6+o/LJ53VHlvh530wGAAnfMe?=
 =?iso-8859-1?Q?FXfdnKZI9wH0wMlIJ02oiw0d+uflcDZsVV5RmFn0wFdqtGhHn+s7vhIeOT?=
 =?iso-8859-1?Q?r6euR4iKZoZZ/RAquFNcm/kAvhEfSbr1PLJV/5kBURDlxZtNbeaPa6cLgB?=
 =?iso-8859-1?Q?YINXv2nqtz6HWASYQ62cHGezrth796GCveo/76V88G3TiExHdDZa3Z90N8?=
 =?iso-8859-1?Q?GE74M+quZNNLyOjyJ93ejjDwTXs40epGsFILOfOlXEqb+9b0ieplbzM5AW?=
 =?iso-8859-1?Q?U5sUQ0eyQ34BTx3kXm1ukVShQ3xvho/5/hm4sfElUCjms8akP0MpthrlCw?=
 =?iso-8859-1?Q?MsoOtqhAZP+9XdGhqZGhjqaH6RHhA0invPjxAnW5IvXSpY6J74gtANp0lK?=
 =?iso-8859-1?Q?xDo8tXaoL0jYpDN2PibdMCfiZ0vL8kzV5OpEULSI75wEdnSJfQ+/7vxUyS?=
 =?iso-8859-1?Q?/IcH5LN8Wb+dRX4EbviDuUUz0WylwKWKkZpRLM1ASFZ417eq4inlB1aOkv?=
 =?iso-8859-1?Q?btaeDP0eNTsiU7Aw9FnGhDBpU5nAUYUFW3DfY/1U5NupQmArlPPzK3c8wR?=
 =?iso-8859-1?Q?hzqItCvd1S6NM9orHBM4epzE5Yo7Ec1VbPIDE15UEX13tgH+iwCmVpxUEj?=
 =?iso-8859-1?Q?MdOCGoobTBEqrZQwOMnzqOosfyyRVVOel6n6U9b+KzGSTC9mXbiyw65F8O?=
 =?iso-8859-1?Q?KBW8PnMWGyQfVVMqltE7i7I8Wqsjfzb+hUhVvXGls6xk8HswMcEc4l/0ev?=
 =?iso-8859-1?Q?vqYOeIH179xqESon22zJp6d0fSohlh7o4XKj3+U97RA/O3jduyLVEaLEQR?=
 =?iso-8859-1?Q?YD8e1HK+PAeIyALA66UdeoTCJ3mSTIYEI6reGqmxdWJWGXamGdf5rOIGo4?=
 =?iso-8859-1?Q?94EXLgL+JVjuoEIGhD0qdOd6W97e+omF64dTkO1gkthRozzplxiFK43f1V?=
 =?iso-8859-1?Q?FjqiYKfpVknFr8TQUnxWAi31lPwC4BRdu5e0/vk62RjYcwzaG945cYc79D?=
 =?iso-8859-1?Q?u8hN27+lq0WLnK2iQjXuawR/udRyTZ8Ye1c7DOEoP4YqcoFW4R00Ci+bV0?=
 =?iso-8859-1?Q?5XlFyiV0dCkYuCy8TtQY3kCTwYHrfRObr3jxfNv243rgCEAqXBfC3xqCpw?=
 =?iso-8859-1?Q?omgxZtaSXXEL36GdEqkgG8HTsOS9j1vgzdWsHto7aK5oJY8LWuQMYLoQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da864b6-16ad-4082-ae55-08da69f60c53
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:48.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjcLEdzFIkjAgz7Z63nnOl+vG22wboZmn2R2HUQTbfJcl1TMtsmGOAblN6XNgC5yzCbIHIRxRUJK00mti7zu5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: B5XCANR1Oh6BURPXAR9CFwZBNzS81uAM
X-Proofpoint-GUID: B5XCANR1Oh6BURPXAR9CFwZBNzS81uAM
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

These users of the rbtree should probably have been walks of the linked
list, but convert them to use walks of the maple tree.

Link: https://lkml.kernel.org/r/20220504011345.662299-1-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-17-Liam.Howlett@orac=
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
