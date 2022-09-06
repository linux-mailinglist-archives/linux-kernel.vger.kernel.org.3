Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92795AF516
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiIFTwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIFTuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:04 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA3112090
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYZk029954;
        Tue, 6 Sep 2022 19:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=3Kyqo/LGKwbyQQt4qViLOVMaLfpZgXaTxJmQmI421nI=;
 b=Lx4HAq5dwAcP6g9yWfiA1q0N87/wwx2lbP2wxd6HAI9IURU7ASH8p+/NdwxaTjbeuXGP
 +5x/fMeJbuOgA7pCUnQQSK9IDJEphbqYxtK/WvzTJgwAb6Iqc+CvxZDVaG9cBwXkO23I
 5jRI59xunUzDEWIEVMeWTXLtQVrWwU+aSSO3fMEoF09i5Q+rHxzJeekoUCleXXhqbfwD
 Hx5myau2EAyudfNc6T1OwrHsKA6n4jElccckCVoTuQVeQ5wHpJW6+QB3PE61iCiMhK5F
 qOeIR1nvseuGH1GTmrOg6iwx6kCKAjMlQn8Lg3rKTVzkNNI5Yd4cB8jyvWDbPKyidMJ5 QQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvda-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:46 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WY039711;
        Tue, 6 Sep 2022 19:49:44 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPc6Hu9A07XGxdY/Gd3ViRrIuvBcWFpsEws/WWGpNlwxeYa+Shd5yad9qbBQMBWMKZLVHf+xg+FvrD/0varzXg/0zpz/4LKz48mFdiG5QlgZp3WDZ5ZL4ay3RbMPkTrlGSuD3ZIiJ+Y1z07Six7rn2jvBPTbzFFOWUkKalevBdd3AaG+3xEIlnglk0mUEqsBKPYHR+kuTEHA3/FfKmnQbJFd20595/m5xgP4Dfd52POmPMg0lhWBY+NXRCXBi0mWyjuB59WGVslT0BmAuQ9Bk1XsO8lpFwZkZ4bMMN0RNX+MQXiHFD0gKLf+E+M8AYbiKtAeAcDBZTXFiw4OT9xPNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Kyqo/LGKwbyQQt4qViLOVMaLfpZgXaTxJmQmI421nI=;
 b=NbHBO+9MA+JFSFmySktDuhGEKbFEXzX7xH9rSsBI+FonGke0yNG+/e4GZPXY4BEA/Mx16livpYN48pIX7m81NZ3gkuPx2z8Wd3Qr5NIta2hMMyn8LHYs7o4d+IWf1yY6F4XIsYoDxn7EuJPQV88FWlrhjI0a2yHp+p+SckjEFNNwC3BzfTPmUlkYuqr7vVvoxb0YLq+MnLV+uSvglQpU6LvKZywXDop1JMntgmzCg3luW3JtNn6InRPcGG7Mv/6+/y47bBW8pNG3L11/uA+RnCb/IIR+PS4SwG09lX96xc8cwuRWWyU967ZKUErLRw6ZT+KzMgw9M1XakgC6EA9cXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kyqo/LGKwbyQQt4qViLOVMaLfpZgXaTxJmQmI421nI=;
 b=NkOitPdlKI3tUJkxlCBztjFxC7OS/MuWvNFtSYdbVzAPtYA5y8Eu1fvTnEOPTbCJ+8gW9+epU2NaXqdsUcn9+1bPZwsCZtlgfFFG+Ea6y4cbbp46YYPGzB2MIfAWSi8Xnj5JX4bNGBA87kDfX930UQrgalMHw7Pk6S7D+Q3TM2w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:42 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:42 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v14 44/70] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Topic: [PATCH v14 44/70] userfaultfd: use maple tree iterator to
 iterate VMAs
Thread-Index: AQHYwim0jjte90wPHEmf+2Y6+i9nUw==
Date:   Tue, 6 Sep 2022 19:48:57 +0000
Message-ID: <20220906194824.2110408-45-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9be2b90b-a1d7-4066-ee84-08da9040f0e4
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3JDbdJmjMIWwWbWyUu5jCFwkyGr+YH1zlM/krSvoirRFrsrmEbL7AC6zoz0sfthGbzvAQgRp1xXS1KnA44j18/urGg7a1O1znNMybajI+l1X6AaW/GCgiUfv6neJNdNcpe7x7+/aN87SsFnDvG9ftCkFZ6x0QeksmRJABg5rBCI0URdLketsCuuy5shxMBI+y7fsq74JpMQvo8DWeplQcny9mSy1l+JrU73pZelKjTO4UdBKe7E6G7q3XszbAsysyFZjxT9JdtzUs95yPRc6xrSLQUhv+o4D939cG+CffKM5Bjp6WM/as1lHhFGd5NZm3rnqiZJk9WYx9p21CD2Hi6yvHhKhTcAtGUjWiOiURbhs0ukeuxaatIOg9Dw6sdTYZSWeYe7NQUjIkUGXuX6U3F2aQTP7TIFWVCobx6j4onzbSfJywJMg7pUQg53MquUN/90uJdrwUNHBb3hSZ0XE+cGA7V+q4s0R/peo6eVduN+X9JQMhnlquJ+L6r91imzGbdwJEP8Zjs45uF9RuKafyXWtr4cBOXuZiFvarjot5esDWTpQmacLCgTY7Dirp7tGxOK+kjSxl3zzmh6A/02hh2MzX/5bRZuteUR3wvSdQHTIN4Yt7y0pLf3IK2UwGGtlEt4Gh515CNig8QwbfoZDXPtB2Nn/9kFGnfmGkMheTx446Ax4YKqYlKGokZdqQbIswLx8CyaboILjXyyOCx7bhDJKKAjH+EC+BK1b44O3WiKgArZ6iHnVSLdiBXN4RB2T43fvVamo/gM62DIAGj18Xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(107886003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Xd9yk4UTc/LK/KfeZbSUXUVMtvg+3ze+6JXDiRHf8qBkvsWndrcZ3iQB7F?=
 =?iso-8859-1?Q?XEVHlDhZPESi+wqWZszV2xcB9vgPSqBxA9gs3ot4qNGBBTv/eJHyCBOjMs?=
 =?iso-8859-1?Q?sfTr6D0fYepQPPG/jAZis78sxEVxq6vKDy8m7sJgRpMJ8PrSiYBUqNy4Pw?=
 =?iso-8859-1?Q?cwjTF4Oc3cgcIqBUxVJhQ0b/q+w5RaO6g8FUWPqdG4tjqeAlOXyNDD4rla?=
 =?iso-8859-1?Q?oBczskywHgBTBEe2LarqjphP59W0Edjl58p9cAMKL6fk0giXtqwnc07PHI?=
 =?iso-8859-1?Q?941QhJ/Wd/wCT2QJ0rdbLJTiuB9vb2YBEK0tCcTRr5ooLtbRYQLVaBtX2L?=
 =?iso-8859-1?Q?Z6WuA1M2YrYhlrd6yGKiMVuCCY4ZjsUZE80phkKA57V9AqBLKNoKwy0puj?=
 =?iso-8859-1?Q?rfzF0cKFgUfoWUUUwfpvJoH4//sLZR7y6tqKdbOJ+mSJWD5qYxTbg8xGE0?=
 =?iso-8859-1?Q?2v0YHcGtRQ/AyRqE6dRbGdYf6+XWQt5ROP4UEveNNSkbZxPoi1/77sUjRA?=
 =?iso-8859-1?Q?LobXg8T+D3j7q9zVMXGrvu96XEfzBnNzgFMsu32NRUrfn0g2W9v4q5t11n?=
 =?iso-8859-1?Q?nfsaXFWdpW6FahueuWDi/tycZ1PPafgSVKBJKKoUMCNgBSK/ttqdocbVXi?=
 =?iso-8859-1?Q?sxOWJlbWhg0WVIHS68usqBfQtv2CkF5nduw42blBsU93v/uUcSTaoY38ET?=
 =?iso-8859-1?Q?gioK2rWK1vZI3/fXi/YGj717p2SJh5aPIKDKu+uewRB101ydVK8GnsiNHL?=
 =?iso-8859-1?Q?NHtGD2VDSnyfxl6z/YB6nwmRZ6cQbiSlOfJ7RbS+Pi+HakfkK6vXlrCp4l?=
 =?iso-8859-1?Q?dtd1ez1cnR10p0ZBY3OHJ2sTw0BZEa6uLBDPXFJGjsxJR/tM2zIIbMaTl/?=
 =?iso-8859-1?Q?8dFzFrzNNl5Iv9+Kq/jOcBalMohRJdqFTwRiM9wZdEOsJNzALX9pt+NlRl?=
 =?iso-8859-1?Q?WmG+C/MkmNuvwmCYrxf24dziJrko9WK1bL+fywe07P6CgOVDrdcWFAN/yl?=
 =?iso-8859-1?Q?zl+XiU9DmiB44XZwGygRB2HWXdQPDR1OQXcQtTvmBiaqlnTrT14e30cmP0?=
 =?iso-8859-1?Q?nQTtBBDhaKGxTKYq1n1kn3W1ofw9K0RyStYHsZdXYmux/pkxF5ozn8u2ig?=
 =?iso-8859-1?Q?GTz+6eA1hH/C+WhLgTFx+bWICwGD6xq1r18uBi/+IHqJgmbjvdClT2UAYE?=
 =?iso-8859-1?Q?W/E48iYe0M47sCvSdUiZ3PZHu4TFzHjiOZEV7kYP0Ll/QV+PSNrbQH3uPq?=
 =?iso-8859-1?Q?aYizqK/DnwxRrshmsTgLSrnbySnUdX7IlrEakTja42CljOJlAxrORFFBTI?=
 =?iso-8859-1?Q?SZayunburOozC0ihXdf7tqQ3VPBrnPooFBFV79c/WeDhjp/hbgtxYDlIJM?=
 =?iso-8859-1?Q?XTtf6HGRRXMY+l6jgW7oVsqH7BfZNu7ZPWBd+bVzARW8oGMnuRRurOF9Sl?=
 =?iso-8859-1?Q?7Eio/Wqs4nL5hUK2CZBmrijJWh+4a/BgJwfI1mBKO0ii9yBdnZk/Zvfb8w?=
 =?iso-8859-1?Q?ZeHbcvwe3oBwI56lpHsZaCoqmQmKkTb7XDZbp/VonKfK89dlffCQNt5BeW?=
 =?iso-8859-1?Q?JLRI0Xxr1FdWI/ccqVr+Yn+Ne+PS0x0ae3sVuVKRUPkV94OeNFnfI4H7Mw?=
 =?iso-8859-1?Q?gbp4RNEfc8XTuzoAWH8ME81DN5PB0VlrY1T44YuXGfOf1T+cGX5qFHvA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be2b90b-a1d7-4066-ee84-08da9040f0e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:57.8968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqIuPt91kWji6QIvcOQIU04tenhU5GtiF8YkYpHtVBJ8p7TQraokoc57V7hF+w2Vawbvmp0Xr6JPaMlSATPcnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: As9OGDwdzwe6UgO1DqA5zuMX8kYwODtZ
X-Proofpoint-GUID: As9OGDwdzwe6UgO1DqA5zuMX8kYwODtZ
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

Don't use the mm_struct linked list or the vma->vm_next in prep for
removal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c              | 62 ++++++++++++++++++++++++-----------
 include/linux/userfaultfd_k.h |  7 ++--
 mm/mmap.c                     |  2 +-
 3 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 4de91ba9e85e..091d95ddf9a0 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -611,14 +611,16 @@ static void userfaultfd_event_wait_completion(struct =
userfaultfd_ctx *ctx,
 	if (release_new_ctx) {
 		struct vm_area_struct *vma;
 		struct mm_struct *mm =3D release_new_ctx->mm;
+		VMA_ITERATOR(vmi, mm, 0);
=20
 		/* the various vma->vm_userfaultfd_ctx still points to it */
 		mmap_write_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+		for_each_vma(vmi, vma) {
 			if (vma->vm_userfaultfd_ctx.ctx =3D=3D release_new_ctx) {
 				vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 				vma->vm_flags &=3D ~__VM_UFFD_FLAGS;
 			}
+		}
 		mmap_write_unlock(mm);
=20
 		userfaultfd_ctx_put(release_new_ctx);
@@ -799,11 +801,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx=
, struct list_head *unmaps,
 	return false;
 }
=20
-int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-			   unsigned long start, unsigned long end,
-			   struct list_head *unmaps)
+int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long start,
+			   unsigned long end, struct list_head *unmaps)
 {
-	for ( ; vma && vma->vm_start < end; vma =3D vma->vm_next) {
+	VMA_ITERATOR(vmi, mm, start);
+	struct vm_area_struct *vma;
+
+	for_each_vma_range(vmi, vma, end) {
 		struct userfaultfd_unmap_ctx *unmap_ctx;
 		struct userfaultfd_ctx *ctx =3D vma->vm_userfaultfd_ctx.ctx;
=20
@@ -853,6 +857,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -869,7 +874,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -883,10 +888,13 @@ static int userfaultfd_release(struct inode *inode, s=
truct file *file)
 				 vma->vm_file, vma->vm_pgoff,
 				 vma_policy(vma),
 				 NULL_VM_UFFD_CTX, anon_vma_name(vma));
-		if (prev)
+		if (prev) {
+			mas_pause(&mas);
 			vma =3D prev;
-		else
+		} else {
 			prev =3D vma;
+		}
+
 		vma->vm_flags =3D new_flags;
 		vma->vm_userfaultfd_ctx =3D NULL_VM_UFFD_CTX;
 	}
@@ -1268,6 +1276,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1310,7 +1319,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1335,7 +1345,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1395,8 +1405,10 @@ static int userfaultfd_register(struct userfaultfd_c=
tx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1426,6 +1438,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto next;
 		}
@@ -1433,11 +1447,15 @@ static int userfaultfd_register(struct userfaultfd_=
ctx *ctx,
 			ret =3D split_vma(mm, vma, start, 1);
 			if (ret)
 				break;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 		if (vma->vm_end > end) {
 			ret =3D split_vma(mm, vma, end, 0);
 			if (ret)
 				break;
+			/* split_vma() invalidated the mas */
+			mas_pause(&mas);
 		}
 	next:
 		/*
@@ -1454,8 +1472,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
@@ -1499,6 +1517,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1517,7 +1536,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 		goto out;
=20
 	mmap_write_lock(mm);
-	vma =3D find_vma_prev(mm, start, &prev);
+	mas_set(&mas, start);
+	vma =3D mas_find(&mas, ULONG_MAX);
 	if (!vma)
 		goto out_unlock;
=20
@@ -1542,7 +1562,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1562,8 +1582,10 @@ static int userfaultfd_unregister(struct userfaultfd=
_ctx *ctx,
 	}
 	BUG_ON(!found);
=20
-	if (vma->vm_start < start)
-		prev =3D vma;
+	mas_set(&mas, start);
+	prev =3D mas_prev(&mas, 0);
+	if (prev !=3D vma)
+		mas_next(&mas, ULONG_MAX);
=20
 	ret =3D 0;
 	do {
@@ -1632,8 +1654,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	skip:
 		prev =3D vma;
 		start =3D vma->vm_end;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
+		vma =3D mas_next(&mas, end - 1);
+	} while (vma);
 out_unlock:
 	mmap_write_unlock(mm);
 	mmput(mm);
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index e1b8a915e9e9..f07e6998bb68 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -175,9 +175,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *v=
ma,
 			       unsigned long start,
 			       unsigned long end);
=20
-extern int userfaultfd_unmap_prep(struct vm_area_struct *vma,
-				  unsigned long start, unsigned long end,
-				  struct list_head *uf);
+extern int userfaultfd_unmap_prep(struct mm_struct *mm, unsigned long star=
t,
+				  unsigned long end, struct list_head *uf);
 extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 				       struct list_head *uf);
=20
@@ -258,7 +257,7 @@ static inline bool userfaultfd_remove(struct vm_area_st=
ruct *vma,
 	return true;
 }
=20
-static inline int userfaultfd_unmap_prep(struct vm_area_struct *vma,
+static inline int userfaultfd_unmap_prep(struct mm_struct *mm,
 					 unsigned long start, unsigned long end,
 					 struct list_head *uf)
 {
diff --git a/mm/mmap.c b/mm/mmap.c
index 8b7e9d5afd38..aabd4f986ccf 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2545,7 +2545,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			goto userfaultfd_error;
--=20
2.35.1
