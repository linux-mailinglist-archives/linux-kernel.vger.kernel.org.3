Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736D1519360
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245179AbiEDBUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245182AbiEDBR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872344348C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:23 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243MOe0F026132;
        Wed, 4 May 2022 01:14:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lAlN4V4xXtkqf47kt8sPDWdsKuQOlDXsFEhztd84YFU=;
 b=EBmUaH6ifKR7H77mm1BTc5Fld6MvUJlscAmuQBPw5qMONpibd59AwCe4RbZ1BYt2Srba
 6MR5hgyGQtcGGJ5rsAfBWrFc7P0Eex+H4L+Vs1ss0D0NoIM5oj47CuFuu8gF88vXcz2b
 MxNb5kiLEkuVo4jM9w6ICdUXHZR6ZXSnk7qevbpYHp7RstUxDrja8WoXwWOXWSgDk89Z
 xckuInnsQ6pBOkdY+r4MRApYEt9kTHeoNL8tnG41S5iRuEkxnBaL1RnXcHsrENIiuOWH
 TjP4Usgamk3a2nZcQ44szB3y4ccQRX+ZMQcc0Foab9nBVGk/tg4pQqy8iUZngX9F6kX9 +Q== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruhc72pm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:06 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441ArQ1020035;
        Wed, 4 May 2022 01:14:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj922jf-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oG0BEMN4lmI61WWTo8lFPUNGdL6tIDfVETTQMXBdAqPXZPxbAAkEPYrD9mj/1MDDf2qmtQX9xwL1lu8ZXW6szzcWsm/xUhb24FRQrXoAy2OGWklGvg8oqgepVk2pJh0VAsJd0tGFJYlRdwP+4lZH4DzzdAuVYj7sBsPDq1AWJdkdqTlte07RvFl7gThzhbg0kCoQaiFyBF+BN5ceV2DFFkPuMMVedfs7o9iAQQipyaJMf98RF74xCBQcttbMNZdSKBlii37D6oqRjPtkl9R+VuGnQ3SiKEPSfHo+MzVgF3IA/HH9pn4EPBQ+xJrsEWIZ41LcIunR43dNtWdiTDrtfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lAlN4V4xXtkqf47kt8sPDWdsKuQOlDXsFEhztd84YFU=;
 b=l9JGwFVUZoKVhiy9pS5qwKfphvQis+2RTWwULOT09fm+e1/l8MreCP5W0uHrSyzdeyCt6XUdwXKfF+XRZJzSARp51WQG+1pVsoYt5NT3mVK3BMUUqQ7p8/JMWCxkC1ktiML+iSmgp7wRP687rBY5jgwbSoDy1O3/3ZVnPj/J+JfeVnG40ESYkgxOsVKCj07+Wk+EhvmwxH4XCGSkciHT6WIjGX8g9NHtRLz4dW0RyBPCgvADg72a3Bo7SNqXYOAGOmys0kNnwIM5UJF+4owCYd2BuaL/6ijQXHOMqYzKRY3eVyx+RwOQIelV6/ypR/5FTZr0nb6YjafE7jNZBIM8JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lAlN4V4xXtkqf47kt8sPDWdsKuQOlDXsFEhztd84YFU=;
 b=mcafuJIGphDwTPGdJHpptj8j3b8KshGpMG1bSCG4SS4j7uYW6gNSOJEpafTqWINhJeSS2qNeZe0kYJ+QNSfzTJee3G6DKBpnT65K00FnTN6sTbVq/HWvdBXqXBx3EKaraSbcybOpIusbuFXYahSXKVo8Y5RgxVAIN1aFvp8CF2g=
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
Subject: [PATCH v9 44/69] userfaultfd: use maple tree iterator to iterate VMAs
Thread-Topic: [PATCH v9 44/69] userfaultfd: use maple tree iterator to iterate
 VMAs
Thread-Index: AQHYX1Q7iGYsvmt9sEGo+1bnewIREw==
Date:   Wed, 4 May 2022 01:13:59 +0000
Message-ID: <20220504011345.662299-29-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e55f8953-6cf8-4594-d6ee-08da2d6b60a4
x-ms-traffictypediagnostic: MN2PR10MB3728:EE_
x-microsoft-antispam-prvs: <MN2PR10MB37287AB87A23B3179F66E9F0FDC39@MN2PR10MB3728.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eva28ktp9rGdkW1zdlf20jgaGqMXold9Qz8uJPhcuC0fCUVgLIcqma3SOerU123clsVWGpbp6YCph3x+zsVNLN4dCKVSOsehJzG5LdYwzKWJn8csiaHd+K0Zw9PLdZqpAtRbVpZ6sQW5fcczzpljjQm8T/iK9c9ni4hwvohopu5wyyaFDXYgdqFQSIOoCdQp59LDq2G8etssJPmmGNCjpovXzUBnjPGARFtyUrg6q/+PXxLn5ZL/mYmQ6qXb5hRKiVi8bvfRpLLBfp/tw4VJjo6mpEOTVcWWrMidAfWchzKaZd+uX/0Rjrgh9A9RgbdLB55KzFLID5iUBdxvVsC4kHOWNg9w7aSs6M1KpRfSuu+USPEnQ1Pwk8y9KoyKiQYTHEpmEIxEGPEtcSFppVOg2VU5dFDrtfmV4H+UqR44NiJv2wtIUILEID9HCcXQZKyVpNhnNdZD54yaurJtgBU0uqA1H5tWjIk8YsHs1VO5Y0ZWLYlOng4WeXECMvd6DmJb0wDb3VlryOgwl0ox+UtdZ9r/v8x1RFrxF6VhP4m3EOzGnJYujNOVfLfTAiiz/3WFEegOzfAAP7bZE5T0W+4hkffN1+b3UDTF3XMLH8tl39eozW7VlstkXZJVb/uWUqZZoQY+nfWQvy1DreS6RLsZJgFYrjlSEQ+FimZUUoP1G3ZWDp+y87txzmsXzkKQCPy/TZbbBuDkv9xNOx+5+ptbWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(508600001)(5660300002)(8936002)(6486002)(86362001)(26005)(6506007)(2616005)(6512007)(2906002)(83380400001)(44832011)(186003)(6666004)(66946007)(91956017)(76116006)(110136005)(38100700002)(38070700005)(36756003)(316002)(8676002)(66446008)(66556008)(64756008)(66476007)(122000001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/ZrxpB90Jgz8gYLBGoZZwPTNnQL6oAvgMYOi+7l1vqqLoFKK38B7XJUpnd?=
 =?iso-8859-1?Q?gEMVYgQgSq2gHP0NsXeOJfRe05tcMFPPaabKo062i0mxOt72FydiTQfAPd?=
 =?iso-8859-1?Q?McduPwXdYZGby1LOpd6qcyJv1OJZp3eKka+aI0Iv5sRvd/y8w+BlsMZt/5?=
 =?iso-8859-1?Q?mIHIwv42HZ9lOPlit2BZEaYWwDF3XtWJQ2U1sAN7png3WARzAk6w7wwklM?=
 =?iso-8859-1?Q?Qk4kDuHF+G2pIdi+ygbTGpHIWAF8BJii6SJjlblXWIZ9JWhv1d1G/F4uYr?=
 =?iso-8859-1?Q?1VnYj22Hr9+/yfVcqZ2Qf/GMRl0mnJtyqR8anFBbB44VHQexzwQMzmhXtV?=
 =?iso-8859-1?Q?DNTv0q3N5kUHN1QulIGM1zHVHzFvTE9Q4f5Bhj+p/SX2gscxLXU3/XCxvI?=
 =?iso-8859-1?Q?ynwMGQsaH/rX6NohjHV6IuXoO2cLURm+2KHUgrjPDDoETVXdmDDBarVLI9?=
 =?iso-8859-1?Q?LREmkA3gizj1EEykXU8k+V1LVZCfU2r2tDsznTMV5grdEiNm/1LlTPzYiu?=
 =?iso-8859-1?Q?S3RnhxMIG/3emktI61L9KPPPw3q3uXD5Kj6ER92OhCCO0URPP7pvxOLom5?=
 =?iso-8859-1?Q?AzX6YCs19mRekEoORFomHXv+I2TkfvLPfZuc4eRfbZ9HgXBheW5auIy7Vs?=
 =?iso-8859-1?Q?tBD9E6Gh0lQZTeDF8XXKAb0Sw/wWA4hVRYkcEHp7TUMZnRmV2Xm2oWBL0X?=
 =?iso-8859-1?Q?EPQxahSvyfYfijE7M3fNskuySZ6dsmPUe2xGRWC/KvtACrPu0IL2S5dRzd?=
 =?iso-8859-1?Q?iQIRELgcUTLhTQawM68EEvBSZrjd/LBHIRF9ikwiVt+sYJgWXFt9QpzRjr?=
 =?iso-8859-1?Q?h4/f7YD48VZGioQfQ6xn7O5piwHwUuTn7jpNutbQYhjl41xBLT7714INs2?=
 =?iso-8859-1?Q?saE2Els5ChA9UgOyNFJyMbWNDhCUoEa/AWHmNK3jMTuJ8PI+gS1sg21gEn?=
 =?iso-8859-1?Q?5VmzbBmc8Acah93TZ/4jzFmHHRghd0FRg8R96Xl1xsc8Kn1hQXdDHCLTXR?=
 =?iso-8859-1?Q?njss8EnnHHpxI3mHQUr8KsIPkMIBcoE50cDPVf1hNTTevcRPDyueC+lH6M?=
 =?iso-8859-1?Q?aJD50EKRBaB7gof7eaijJis4YKIuznZePcAM4/8xO+3+nV9Kc5UYlNMTg3?=
 =?iso-8859-1?Q?0qlex1FNr1fXUliHseDP6wUhthvjANeUsxnHgSCiVi0tXGOuHWQB2Vmq0m?=
 =?iso-8859-1?Q?4eqTu4aXx0vsMR+3WjazZUR1pbWpjkucTDmFz2M7se1X048CA0/xi/0ZZY?=
 =?iso-8859-1?Q?u5WA6JPB/OaCtIuD9ZoXHadKZj3g9j/zeQEPY2vAHKER/drWDtHzHy9l7v?=
 =?iso-8859-1?Q?ctn79xLQtMGKCuHJQWeNCWU8JVkV2rmwsMSkMxUEKmTrYsPA07KchTHCgl?=
 =?iso-8859-1?Q?J3OKD/ZPf/JSSdCU5BDsj1VXkDRJuPE+RIh0QJSEzSqQOxNyGjt3qYaXzf?=
 =?iso-8859-1?Q?tjAvuEvkt2O1amPuqSmUnGv3u3nNi6UoH9pRL1GMYYcjhiRfja795DVGai?=
 =?iso-8859-1?Q?e5xd4hE/DVY897ZVFkV1QLDYF8H79OmXNyihbQoltamPIgGkps95pxv8ti?=
 =?iso-8859-1?Q?+2vDbN1k7zm0wYAGloTO5poPVyUGJ5wFaQiGf7u8/kqV4kdR07wIgWiX3n?=
 =?iso-8859-1?Q?rJbHDzuT2eUwD4SmAM4d5QoOt93tHHxu96owRx/eFUdCW1S/R3HlAqwNWc?=
 =?iso-8859-1?Q?/qjpUhGr8s0UYxT+089GR6C4AXbjwJthECnzui2CHNGHksDmvmWY6nIm3s?=
 =?iso-8859-1?Q?/8AWnXM3N0BBtMRfucn5XpFfu7hbmCCBV5VkIPc/yXoV8onZC6+nCEU/WE?=
 =?iso-8859-1?Q?eR1PLSaB8AE5FgZERRvh3UR7lCvVVEE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e55f8953-6cf8-4594-d6ee-08da2d6b60a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:59.5640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KnHhj4Z+pd/0+CKjttQLGhnVGc4XiODB8QvLVRiGiBjhDeh+pxbFc0NBUCUybOD283MbsCxmhjVzlof3DAtmug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3728
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: JfbreoVOfaY_okC78brRoHweb94efXpb
X-Proofpoint-ORIG-GUID: JfbreoVOfaY_okC78brRoHweb94efXpb
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

Don't use the mm_struct linked list or the vma->vm_next in prep for
removal.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c              | 55 +++++++++++++++++++++++------------
 include/linux/userfaultfd_k.h |  7 ++---
 mm/mmap.c                     |  7 ++---
 3 files changed, 42 insertions(+), 27 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index aa0c47cb0d16..af29e5885ed2 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -610,14 +610,16 @@ static void userfaultfd_event_wait_completion(struct =
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
@@ -798,11 +800,13 @@ static bool has_unmap_ctx(struct userfaultfd_ctx *ctx=
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
@@ -852,6 +856,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	/* len =3D=3D 0 means wake all */
 	struct userfaultfd_wake_range range =3D { .len =3D 0, };
 	unsigned long new_flags;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	WRITE_ONCE(ctx->released, true);
=20
@@ -868,7 +873,7 @@ static int userfaultfd_release(struct inode *inode, str=
uct file *file)
 	 */
 	mmap_write_lock(mm);
 	prev =3D NULL;
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		cond_resched();
 		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
 		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
@@ -1285,6 +1290,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	bool found;
 	bool basic_ioctls;
 	unsigned long start, end, vma_end;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	user_uffdio_register =3D (struct uffdio_register __user *) arg;
=20
@@ -1327,7 +1333,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
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
@@ -1352,7 +1359,7 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 	 */
 	found =3D false;
 	basic_ioctls =3D false;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1412,8 +1419,10 @@ static int userfaultfd_register(struct userfaultfd_c=
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
@@ -1443,6 +1452,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
x *ctx,
 				 ((struct vm_userfaultfd_ctx){ ctx }),
 				 anon_vma_name(vma));
 		if (prev) {
+			/* vma_merge() invalidated the mas */
+			mas_pause(&mas);
 			vma =3D prev;
 			goto next;
 		}
@@ -1450,11 +1461,15 @@ static int userfaultfd_register(struct userfaultfd_=
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
@@ -1471,8 +1486,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
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
@@ -1516,6 +1531,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1534,7 +1550,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
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
@@ -1559,7 +1576,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1579,8 +1596,10 @@ static int userfaultfd_unregister(struct userfaultfd=
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
@@ -1645,8 +1664,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
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
index 33cea484d1ad..e0b2ec2c20f2 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -139,9 +139,8 @@ extern bool userfaultfd_remove(struct vm_area_struct *v=
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
@@ -222,7 +221,7 @@ static inline bool userfaultfd_remove(struct vm_area_st=
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
index c3609e4e6f12..572a2a474b49 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2552,7 +2552,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			goto userfaultfd_error;
@@ -3053,10 +3053,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 		goto munmap_full_vma;
 	}
=20
-	vma_init(&unmap, mm);
-	unmap.vm_start =3D newbrk;
-	unmap.vm_end =3D oldbrk;
-	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	ret =3D userfaultfd_unmap_prep(mm, newbrk, oldbrk, uf);
 	if (ret)
 		return ret;
 	ret =3D 1;
--=20
2.35.1
