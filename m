Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB4D5AF4EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiIFTyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiIFTvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:51:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8173B11A11
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:08 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Id9gu019965;
        Tue, 6 Sep 2022 19:49:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=4kDpsgtkgL3Ct4lkxrpca6erbMOFUDqDSRHv8gdCqwY=;
 b=PhF3onM6vq5NHD0gwoXza/1B00qz5kT3z3GP18Zl/Je+ujuETID6CNC87/9RwyrrXtUu
 L95uprdJbtF10WhK+Ma2MnK6yN2rkX1QkJ5YMTxtpbYVZebXpHRnlIxTSergQlcL0N0G
 NxEcXlanZ9QSDX+0xSS3w2rv+PxCwv+dEJbm+8k5fXiQWnuHuum2YrVre5/awaMBq/7l
 wQqCpyRtD1FB1hL6l4B1mkQS08QBMt5cbdK6SwYhtTiEIXEFkLEad458Yc+ISTe4XIfj
 ulkKZcJI/ej+LpJ1J2Kng5YzfRTO8SAXR048UQ7tAlGXp6DoH2EnX50Sy7aVck/073eA kQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exnn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:47 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5Wb039711;
        Tue, 6 Sep 2022 19:49:46 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B84PsOsB5NE+mp1jIZ4eDEVU7/aRIvVULbh4LxzJWwxR6/MJquCDTRIqo5UBQyyQsuEF06QfXDkkjTrH9tPfDLa1Qsc0AO4T7EQeq55vmY7M5iuJgwQVkgIxeN42DQjbM+iQjcWxHgIlKfcFBnnbYGnG/zutJS5cYiaJbpPehDMv8gDp4auBvTvJQ7tOSM1jPNOn1vVigbPlVO9HoSvH7p3IX0QVRzA3GfSNRpufXByFKwyFb/+2Ss/ITyUu7bbJnlnmGk3p8IOPQqRxy96226zYTa6W4WMtHt+kRJsPy81y2P/EXVeHwxoNsVInp/FWzQlbMjULcbQgVo49JFGQNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kDpsgtkgL3Ct4lkxrpca6erbMOFUDqDSRHv8gdCqwY=;
 b=lj9DZ0ltFIrysA0M29E38hRusYO7A7ZxlKsqys6cF0j3FZb85zlddYPvOY819JHiY8FvGYkN3/GIdaHkesg+NzlnQUqJAX5pa0wPyHoWkThY3dZ5ncRKCQcsJoZO/SG6asO+R83TGvrKMttH/+mHbhV4w3fAqaew02DVZQjM9Bn2swihYfUuBRWfR6fwYb4MqHN3q9VLYAqOTJAbD5c69njhQMEOPrrOYFu0pMMH1sFlp9tr47p2UFkC0r+suq6CMX6oJrQejFOtBtycq4H1R0LGOqzP7pG6dlbZ2DmXB1SwjB407uRu/fcjccHrkN5raSU+ihWDsVfbeUQCYY24+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kDpsgtkgL3Ct4lkxrpca6erbMOFUDqDSRHv8gdCqwY=;
 b=XyjnSjXMD9SjFu+PjIlAJSwGA8bKCmbmgCK/g/RjTv1XJTnZWZM+rsFMj1XgiPrX8qokN+N+kT+NCEbYxL6ab60E+fnbJh3zBYIlWSc7dwkf+6SnmJGPxdIInazn/GM0rcKf5kt8weBRW38l0Ns7D1bzbJDNrDK70XuUfwAAGZ8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 47/70] perf: use VMA iterator
Thread-Topic: [PATCH v14 47/70] perf: use VMA iterator
Thread-Index: AQHYwim0FXaKGQOGmkaNNac6AIUmtA==
Date:   Tue, 6 Sep 2022 19:48:58 +0000
Message-ID: <20220906194824.2110408-48-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe2b5e06-bd04-4473-90df-08da9040f1ce
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HYPyQweGPuFJZBHUwDIMyYA2nBXuSNLxUyXMLgG3bsPCpkihFqka0w7RhbVCooHCJKWP1G3HQgNZI2ZVY5Mz6juQ0RelVphGbiJfWejn8856kLuZB2UKX5sF/PYGbKbjmg8vSqosaQjZDRDMpEKGpR8muy6CLxipQWv60auKaQ9v/jt4w+NjIN9uye600SCw9NwjDAhLWTFh0mrxf1dfoApDIZCNtNKeg44RrlJTJT9M0jLNmLl05B1+jNOyjB/ugysxAfCa1CEYw//DGhu3FlCG/GuAxlK5tYCHk/KtNpzgFbH6pOkVmIO7NlUxKbXIhK2E6/EluAkkOd6kEdM4UQ4cp9pN3Fzfee8Ut+PNP/heourowHcieGkrFYKM44iELqTjjcnqvaR7ZoBIxI4Q3s57El86rJiia/bAZNRCJ2hNPswZJcjfRN7LsYN3fHX7WOndKu4dogHAUXHdHifX1VAlyzfuN1c4y7gW7lEJYso/KE/ono6ICfAlxmto0P2VSyhK0ecFr6rMpbqUOpjlYLFjtix3nE8DZxeUCxk/lHKqhyAAKIVfis+nrd6KHWqnQrwg8xZwiMH40hm46iCJiNsSvOkn8nnO47MZIBW8bdTm/3I85Di9LfmiTCEkwLY6EwhrdgibpmyB6cseGk1wIKPchRBcxRMSteY5UBP8wjvGvM9Ofmdml63V7azJ+6WMlQTpTPv0ZfC/3UlUTXxXPN1MPH5zDet22E70iYpnNbudFoihFpDJKG4vya7qrizAeJanPknrAqh0MOUxfeplcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ypz25oF4lYJ2ywUUFGBRzQE2qem2CI856B4azgH5hbk8x0cmIVyHw4nfNI?=
 =?iso-8859-1?Q?JYHCG8MfciNW3p3Vcpdq1tpMxv+fPh/c41qRiq0yc31AkNNk0FbRD2FpdC?=
 =?iso-8859-1?Q?CB7HBW3e9udlaEQqTK4ekwefowsF9KM4ykhIo813a3ZKvRgERBJFIakBCQ?=
 =?iso-8859-1?Q?msNifNvCrphJPQWz720jpbHPaNrZ8hJ82rHyPRAp4RqyJvyKvPnkXPR3a8?=
 =?iso-8859-1?Q?tcgF7YiB6lwT7Nyr0klFb0IFaiWNdSfrqkRUzcoKOnfRLdNxc+XBWojajF?=
 =?iso-8859-1?Q?dO448XMyZ0bNYKqAFwp70TbcwV7D+q99FOEFGIA01kIs3sqsBD4z28M1Bn?=
 =?iso-8859-1?Q?v9Qn32RmmLegfGdktfIxX2epFEzF/Y2j2SEUKw+kYo/IOQe83f3CxYnmNS?=
 =?iso-8859-1?Q?EG3oUX2AMWZadsDKBVFzXawz2yHULooP16LE4wSfMEC+/cTFekcLy3zhtd?=
 =?iso-8859-1?Q?fjeIGk8aXAfWUMOsetLcqRZnORK0mnRcFGrvy632yWtA7pePpc2ZJjzg8B?=
 =?iso-8859-1?Q?tXLle9GRSIAmCQKTJFRPILg646LvBI5WlUIby8fluWMVQcs00pDktjwY32?=
 =?iso-8859-1?Q?9sj/PleyEmhr0bTO/YpeXw9UB6+IUFFbCjUf7j50vawWVxAHElFQm8l7zR?=
 =?iso-8859-1?Q?NhegXyaC1sYRSM+YmSOPpr3g12LDq4NK6nUcSq2VD3KQgh5eM2eVdqA+iv?=
 =?iso-8859-1?Q?G7cqEEDJJRrhw8AUB2+jTfgql3OEY15X94iWXoyrN5P3bKPAMc50yqtcsc?=
 =?iso-8859-1?Q?NHaIzVBMi7i+QMydcvRdhBkdFqEC2SV/AN/7vaXAaXBn2B7qB6fA9OXaGL?=
 =?iso-8859-1?Q?ddtSeEJuQPrBM0e5Idhs1O+95lo9pm1edhbSHCMSjszi+LVPzt2/pE9R3F?=
 =?iso-8859-1?Q?uizezwyE/ScBWOCYxoLUjKDSN0QuMJGg9Zs8w3ViAfX3Gom/jgVw499wbt?=
 =?iso-8859-1?Q?s+gCSlSVtrqCWxukX0AMWYXTgDBdSySzYn8oeO7gYDPM0R9KSD1JPwzhtS?=
 =?iso-8859-1?Q?W9lGS06EorByOHZpGD6FZO0IVA/LtAGbnyPqCDCKW7ROVnrf4vdRVIZbQX?=
 =?iso-8859-1?Q?2lR8w/BWbHIS/I2sh3PEaJ8PquvN64zO297sFm5r9RHyBgeRtFZ2iMEIlQ?=
 =?iso-8859-1?Q?F7eGcBoUet9LlHCD2wqePdQHPhnh9J72i5SerupZ45sIhWi/crEzdSNzhI?=
 =?iso-8859-1?Q?1sSgUvboONMT4WlDryLhBzs8BGbBYklgAj0FjWd/W/I+QpcBHgwPprzjot?=
 =?iso-8859-1?Q?jLWhDCW53RUyrjMFrBKnkjE3wFKJNnrDt8j9XoF/zyVWP81ITdldN7Huws?=
 =?iso-8859-1?Q?yiFeFTO25+6WYSVfVkNyJMj6Wx+UQc/Ua0oL3kNb41VGSev+3PSoxsOIF2?=
 =?iso-8859-1?Q?JnxuM09MsT/850FrPZcESSKF15IrRYI8m1IuTbrifQ1PV+ezX0M3NVNL93?=
 =?iso-8859-1?Q?q3xY7GD0j8LFyVxWnWDPStjULlu5AjfZjbJp6VOISq3j6m+lF3GxkxEr04?=
 =?iso-8859-1?Q?PnCtvPOhWDVqRY5Yc7VXU7yw4a50LJ+GA/xdmpmIotoX+ePc/i7LlNPX+U?=
 =?iso-8859-1?Q?++4Jmf3ol2cCa+TjbD+ZPtmcIWlRPi0l2IqSZWeBXHfLW/rOq9cQuhiUmp?=
 =?iso-8859-1?Q?rmPETgCh098GmgdQszrpnakmevD7khqcHEWKeTCZ6iR7GJcGf4SvIJ6g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe2b5e06-bd04-4473-90df-08da9040f1ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:58.9748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FH0dDw9lkoNNEXMRsVI2atMhiNU3rKhdzn/Lxs6nSvF72cSNFdZ45+g9xpqb89NdcrgYUXoshYEsOb6p2xGMlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-GUID: LPzRHk0TlOwu5UY_cruIE7vBOJJf1UsC
X-Proofpoint-ORIG-GUID: LPzRHk0TlOwu5UY_cruIE7vBOJJf1UsC
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

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2621fd24ad26..101c5912c3fc 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10229,8 +10229,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2eaa327f8158..401bc2d24ce0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -349,9 +349,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1231,11 +1232,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1983,9 +1985,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.35.1
