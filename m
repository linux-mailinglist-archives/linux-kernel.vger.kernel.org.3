Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92827553C2F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354752AbiFUUuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354603AbiFUUs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6DB11460
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJLc3T012614;
        Tue, 21 Jun 2022 20:47:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=T25kQFHtcXW9mNlOv3XqORmMb4WkW5gZWh8Ti/IHIV8=;
 b=YiLhIJccbptgs8bVQW4s5bmF7SRq6/tvSye7GGqLZ74jweKLtgTFi0/JaJ9NsKNNGb+q
 jbJbw7GT92nMDQnx00ov57KEJazm2wIgI9xNUuWXn0K85Yokdn7ixWdSIiiWWsETXu1g
 9IUBqecPjgb7FMa4YQDlWG2TJh9ekHF9E2Q9MuxiN9shBF+cDTPU3tf3m4/jGh9Yab9g
 HGLnV4p07z6W6SPaYk55U495gx2PBOD3gCk0noIKc/+tNfUkhY9/mzchzNJq4pvnqjAR
 Mz9g4GZ2OdAYgZYQ7ECfdb2zDgaeUvoFJMOZVW4cj+l2Fj7JE4Qu2yTuW1nbvvGI0bTd 0Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6kht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKehRG001620;
        Tue, 21 Jun 2022 20:47:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutsv-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtuSp50+XRXhULj9jk6WrNR31PTZ1d7VE/e/XMX389s7Jum+hzDxeeXnHpkFUHrR5tNjl33ybrTenWiNhC4nmqGnxfKKwpCQNuFmjHDrZLgT3ZaF6cRikM+qOyj0vl64ffqPL/FtqI34HVRYFNVfMXc3S5toGTGvehnuQBHEqR1fhzSwvXfXI5DByu9kcocC0FhEy+uysiGlFLGEUDvqqF3fo1rZgb6Li0b3QZJIxBXB/QvzMIA9ayQslpziXzGidptaYDTeZ8/O29+NT+tK8gKcXyTRgD+kWSF2wrT5vSZUnwdOvjlP2wQiTBT3hjWcLwEj+GbR2kM9VbGDWxdmmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T25kQFHtcXW9mNlOv3XqORmMb4WkW5gZWh8Ti/IHIV8=;
 b=mAULTzwOfxIo2caaW28Wb3v5VaB0W4ySdiU3NxBUtxq0K578WtFB/cxjbc09CDFBYuUpzT8E5Udn9m7d10lKfd8X6jjZON3tlAbrQcGP4BHi0R94VHmvwGjAuRsEswgEt7z03E0/WOux949DsL05Nvt8jJF7V5OXvm2Ml3N00Y6KOK5954Z6JHBCDj43cStq/pb+JgpJZr8JaV14ulTdJheUyV2O/Kom7a3shrmOTkNXh7Veg3fGw+SN91YLtS0KAJ5rhUFoWgOWuv/XUD+ue+4+QIxtQVCf1fnUkgsDbfRsKaHtJOIunrnMqfBYBYzXG7x+QKv6mkMsnIj1OF0WMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T25kQFHtcXW9mNlOv3XqORmMb4WkW5gZWh8Ti/IHIV8=;
 b=oLdKO9VQ9Z1KBOS+Vaqei8ED293J/38C+W8tY5eMzumOVLq1jticDjjkyUBqhU9hngBHXP1WsyzM9R5zPdoMRXxRdV0pt24ipqQTI1I8S7ICc29qDCANRNtWd1ODmZR1cVP0S/P/+v59h2vu0o1ibTbixcyvnpK9YeNf+kr1evY=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 42/69] fs/proc/base: use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v10 42/69] fs/proc/base: use maple tree iterators in
 place of linked list
Thread-Index: AQHYhbASsjXw9ANtU0m/Wm3dtiPnZw==
Date:   Tue, 21 Jun 2022 20:47:07 +0000
Message-ID: <20220621204632.3370049-43-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df26c39a-cb50-41c2-9ee9-08da53c74d97
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB4025667CD15C0C9E6C861F46FDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tvUlTBsq9+G6pWHq0Hzn8PVh1AL3x1+Z6yd0EZ/KszfEuzDu1DTKSXrJocjKbAMKknuwP2k1oLs0Wzy8IbNu745pLIW9LR6UzRrVfU2sVsjz4CQDGsuQ20VGgm4lf3LSz0jhQFksPqz5/xKwB9a6nVSPt7OWyz14A6ANPu6wNhamSEzeQdvm/1vvTGYY0Qh+jYAZSfWeHoaZ8x4mcpehTAQDMLNeYnTgahrtUaXA5EeOg3p6IQo15yGilRKJClBdBB5wK7cvKEFqXd+NC/uFYPJ0AwwfSPVMdX/p3kMWc4LNp4Hn2IoGQGtMmpZP6H8Y6TTEu46IjhY1grGLeHvnl+qB0fBwBhQ/ei9KclbIUkGdo0VGyQdRLn/xhbWm2USAq+Hpn9RYAMjoC3qAHornZsR5/bP/mnN30FNaYjjb3vzU7Kq1+0/bRdqUizxE2NaxHYqoIee1ju7fZ0dsQv27iOh0sfzPu0ieNmnZ86Ptu70mggbpOSD5VgWJH5ixbY4I9dQPISIKJHDMsO5rlsLK93+dok5m+ntcu7d/IjuGv10zW5R9cP6mPCo1YNGR733m9mddsW3TRkEjzRmZ1dapp97usF4oUtomcxCQWF2VoKGKESjwJrHT0w/cP6qcnE73de8jVQmn9m3NWQc+E40Ng0yyX5CAuSItJWSX9Q/FKy9llYszIBTkmGpf1pzkqbSFbWUZTG5qUJEsFzhFpbz7a/yl22OCR3vrK388lXUw3hKgq6FjfpbtXzUB9+W/Hzf0OZSIrNaV+3Fs6kJxcvzLtnFp6h1fmWg2UFvIWQ3ZRIk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bCMtYMshNtm59/lGoio6WgQWuQSsaB2Asm29UpgMkv6N3dkBItM+D2HfDG?=
 =?iso-8859-1?Q?BD8i2mYRb5iNbalXge+I/88a6vGvMw/jArKuvO7UOIGI+3zxqHhKf8D7N+?=
 =?iso-8859-1?Q?U/ELsMS1pdOZG9ojFvKW8//RY+F1Iw0WCgrp24pAeg3YkBvdpmr0zRnxGO?=
 =?iso-8859-1?Q?LAJNTZy2UDltw/P8kIJCNLhLJF76VrxF+PfT4jNH+zVS1J+hvsscnomR7t?=
 =?iso-8859-1?Q?SL9ZaAJ6ovDbxcFiJOl3op6rVrIZd3PZWuaDVaYCZC8pdfHue9QDRfKP5N?=
 =?iso-8859-1?Q?RVi4sAoy9rKG0lorcoku/1YoglVWBPklup3yA1J1Whyx8EtBKPV9HbpRYV?=
 =?iso-8859-1?Q?PyY6MciHfO+oVQgeWOhCJ26P8/XtBfOuXUYVQAH7817H1p1wnWbMTkWFLM?=
 =?iso-8859-1?Q?0YpPYv16CPBM6KZ5UXtea+IAh8SnTbSQqenuB1EYNuqO0ze8gThvRF7hi+?=
 =?iso-8859-1?Q?uhL3lx9JkOVPKENpzZsUVV2TarduhCOp5CIWd4IQISmiDbPdYY2tYK4dLC?=
 =?iso-8859-1?Q?GIk60sIawkRyq+ejbSfpHxjK915lqjmRv3gsidqUbvlcHWmypXE85sokLr?=
 =?iso-8859-1?Q?yKXQiyTJtkM24PX0Vc2j9S/ppvVQ+grEBPnLceSgZazaA+esC4oD76+vbW?=
 =?iso-8859-1?Q?AwS7up5JYdcKDVSoOm2YDeA32464AQ+NL0LN1BQGEnz8unipVv84g5nAf2?=
 =?iso-8859-1?Q?gYhUYDohSF3HYjp88hV2DPrVkkex6zZoEc43LNjwIs8ls76OfFFn72BUv9?=
 =?iso-8859-1?Q?VeGg1/GyFJiREQ3A/vldrSUnbjPn9uJwD4prsKU79Dpr2qrC6TBfoZ/wui?=
 =?iso-8859-1?Q?po4MFEXn38OVTXRDq5GsHrPWTDP41acHppdKnWCF0A0mCfnPZzblAdByvJ?=
 =?iso-8859-1?Q?h2Sfadgk9RxBSUr44S9c7gn0DZpiuIAmmMFc7TQ6UEWeqCxV84kD9kqITg?=
 =?iso-8859-1?Q?TgeaIQtFXfeRegst7D3A9+MGmfirAcP7pyapPMtm+MMPLC1Ln3snI1zpHq?=
 =?iso-8859-1?Q?Y7HluNbmvvozEZk/SVqaUnyUCK/o7YqCPgbb7iONRDnehi53LEsSJhaIHu?=
 =?iso-8859-1?Q?Ev6V9WA+TQ9SOYtO7uAbAxk6s9QAQkuQvvsirVfXmkZUgsu3SuHtVhV0Et?=
 =?iso-8859-1?Q?qYZ66py204tHzyG7mHko1XkzIAhbf2GbC2mHsqlIiqW/0DQX+U2oVn6zU+?=
 =?iso-8859-1?Q?g3iHE+ttDsQRyUu2WySGDr1KJc0U1AD8yjC0EnINbWzsyjCyULH0EvePr+?=
 =?iso-8859-1?Q?2DWTJQ2u7ml/61ba/Im8nMDZTxz6WtGmqHSdqsOOtoqyR1pvszONPWyAtd?=
 =?iso-8859-1?Q?VX1pyi2cIA/t7bYjTzi/2nD+vLHzvZK7xXzaTKzOeWZfc/HHbiEvrLFxX5?=
 =?iso-8859-1?Q?FQDSzItehoMZQcSIRTssJ0jJTWLpG1gBXn5oeU7kL6lDKs05+Xvhpc0ulJ?=
 =?iso-8859-1?Q?Ax1F5teu9V58oALRPzpvYFzoOwHelmui2QCQZxFVQZ+nSlw2r3hviV+lfS?=
 =?iso-8859-1?Q?hB2f+NGW4AI23F51aQCKFWEWvnkwPtZbRrZIBTrIfwYB4uH53D56zb4yBl?=
 =?iso-8859-1?Q?hLU6L07/oicHuSZtubWrE7VNSFHGplb7EakJlmIRm0Bw6yTD3yqRAid2ye?=
 =?iso-8859-1?Q?hLPso5mNIViqM0PStX+3EOggD2CCOF+p1JNa9iYzr3lrYIYDbxmABd5Yrc?=
 =?iso-8859-1?Q?jrGKhgiZ7wCUjNd9rdDkGLaCW+ahYFfXBxA7cxcEzCgWnPppQmqvIh7kFl?=
 =?iso-8859-1?Q?01whlDtIqiQtSKDlnjr0VA9nXFekvsIHViwePYOAKPsxR6pa9YE5SixWk0?=
 =?iso-8859-1?Q?k1eLVKftNN5tnq1qphekKL95ccOXTB8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df26c39a-cb50-41c2-9ee9-08da53c74d97
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:07.0504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yhfodVg5XdyXZxm2/eWZm/N9+vPZJCpe1u9HnIr1d4yw+NoK1rlvcrZ5gwLfERGWqLWbBPhs29iMjvrPcywK+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: UiMRpjGAdmLon18tEvNYa1cG9lU2kPiq
X-Proofpoint-GUID: UiMRpjGAdmLon18tEvNYa1cG9lU2kPiq
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

Link: https://lkml.kernel.org/r/20220504011345.662299-27-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..617816168748 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2322,6 +2322,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2349,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2360,7 +2362,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.35.1
