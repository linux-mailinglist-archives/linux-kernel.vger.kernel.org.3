Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BCD355C267
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiF0PTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 11:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbiF0PTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 11:19:10 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6DC11450
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 08:19:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25RDdDBN002132;
        Mon, 27 Jun 2022 15:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=ssiK/EL03nR15wa5XDL0cWqkXbqPb3zW+IPkbY06mPc=;
 b=cykSt5DBlI1RZG088styafsyE79m9QOLjJaY/IUP9dX/RcBUxsvHUR6li5amhpoN71y5
 O63J1uVchavd/uWG0gKbWbdokiWbIswLaRGAUEfvt0nWN1OWUTsOCYw0S+FOqLAmUhTE
 +dWZ3uAi/qJyhEoofyCUXxMB+VhRa6nFl/MhcSAdyBlzbU0rx3UnURGRW39np6h7iG3s
 vbATvb2mSK2dkw9WwrbLYHTkwhseV56Ytqu5+3NwntcbUztd0cJn3r8jZwYo9Myh0swg
 pgsmjWGw+bKT23o5uAxJdPE6Y+gQq7sKQr2ZKZko1/GGWoulOKS8mjv7rWbiOc9KoEil RA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gws52bhxw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 15:19:02 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25RF6m2q034198;
        Mon, 27 Jun 2022 15:19:01 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gwrt1hmn0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jun 2022 15:19:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrQ+K0nr0WTIdEM9eN9KLxrP9cI5CwsIeXkG6CWBcIKrXl2aHWBQaBnM4n0k4YyByTaZuvJ16YdKdP4Me5c6x+4LIhxJX6ya5tMFc/WnDEuqHdDQunsyGPBo9/tTv+XXQsCde1/d2jsI77YuydLVutGQhbdxgoAyfptSKl1eIAxHuOAGQTMmDshEZ1VAhOuw/yMzkvidhnQRL/753UqkWIP0CfJ9o2s76CtvwaJDWNJtu7215HlsLKSANsXfni9brF4Gzuu9HueL59P9JAgP3PTnF6pgqnRnWDXjnt25CPV6IzAKsAiUGbDYGd95PiwMr56oCtmQujkUGt7s5GAKtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssiK/EL03nR15wa5XDL0cWqkXbqPb3zW+IPkbY06mPc=;
 b=lPfsVtDRaTjc+Jiue3WDIBUxGWgW/P10tIwg1ggP7ZWNtaI6+1oAIsC6piIA2o0Ur/GyJls1iSzO6NWGqV9KPoIF8vWQ3DA0wHY60C12F3I83jbgole5hgcRVEpWrV6ZsJeIe2VKZQJ8twhPmlP60HTmQEVhYmgcBhg56BMf+L6RLv9JsgaN38rQ9TTpsUzwvx1zpw/7iDp8yyep3yVY7KpUcbB+JMieXSSjg8kPB8fJnOmdcNyK+2YgZ/p4ozUp9oDqGkPf0FHfE+G9MfJZuh2vWnYWecbyyN7kWV/ul9xGkooy4MFcl0Yl8xuXWCfhz0GYwV4AJCLRz3xUG52vCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssiK/EL03nR15wa5XDL0cWqkXbqPb3zW+IPkbY06mPc=;
 b=g07R82/9wlf1ibfWwqf1j7W9tyK372BBGl2HpDXsFtjYz58gIKUW7SmL54ZZGFcIeKFtlL52uMO97VgIydoudO9E+kei1MxUDCp0yCsY4Icq6udC9ObIBbl3JlgXB8V88kx5TtstqGR+mSByljl1XKE2w9wbXgdBDWv9PTOoTWE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BYAPR10MB4101.namprd10.prod.outlook.com (2603:10b6:a03:120::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Mon, 27 Jun
 2022 15:18:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 15:18:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "arve@android.com" <arve@android.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hridya@google.com" <hridya@google.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maco@android.com" <maco@android.com>,
        "surenb@google.com" <surenb@google.com>,
        "tkjos@android.com" <tkjos@android.com>
Subject: [PATCH] android: binder: Fix lockdep check on clearing vma
Thread-Topic: [PATCH] android: binder: Fix lockdep check on clearing vma
Thread-Index: AQHYijk5ai/jtwYSKECpl16NkdQYag==
Date:   Mon, 27 Jun 2022 15:18:59 +0000
Message-ID: <20220627151857.2316964-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 097ad632-9304-441c-9489-08da58505c22
x-ms-traffictypediagnostic: BYAPR10MB4101:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P7QB1ZIdxBc2B+MGfG/nUW/7hChR7J54sIGMU1UyOsckQPDS6KWMDguU4EmuJPaP3a7I1jNrFnVGsu3JAutrh/VELj8an1n97qFoRb/aruDuT8YAawmm1TVgbBJVobIyLyK5Ws/nk9euJ4RzBKSTi7Ca9LV0EslNyWyH6e23U7aLiYfjThQZdr8oRIvNxZF6RTkEfKjdjY2traSAdXFszjXob0wy6GZOMOOSKl2zIgBod5oMeCX8IAt0oiPmIEFVlgUMQ8pdQ5ikKsjxRIzTfhAIlr+6ZyzZYgKxGXxvXBtqj0LEITt98QGpzOfiUygk2vPuHaA/B3ux14hwtBJWNw8F7Uc1xol2uTZhHlQwU+2Z9jUUiHSv+S/7oKhefPyRoXYkiytF7cPYHRQ2PFZS4lMwgbKAVtufieXQ4xDpoB+WfuVZ2UY+ZJxOBI5sEGzbuAQWMRV+wCCzWpBD2MXh2xpAXQfR7kV6Qg6D5fuCD+V9vaVsq00ZDMQZVzlBskIN5UileMLiYFVYcVG1lOsCltj8cl51ZWFzuMUkcVgkN4JeynK1zPkJGpcf8kMijEviMw5BqFletbh0awf7Rge93fXIEynpIH/mgJ7ZVjmKR/koaO1HYIKUGXhzlZ/Ql9jNgeBPayugwxw4fVcZ9YdZxeGdXcSMrGFqtoPVz48X6YppohCxQ5pkw5U6rssEY73asGcOpsEq2MIOjbyGrSIxsol7+ZX0cM0vsZsX6JpZuUAQJ0v3dzds5yaZrtCJ/8B8dHi9yASigUbmq9O/mm1FNF+ne/AXyD+CIQURrlMjvWT+mXf32oVdLpPhniF+awoV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(136003)(346002)(39860400002)(366004)(6512007)(122000001)(66556008)(66476007)(7416002)(8936002)(38070700005)(41300700001)(186003)(2616005)(6486002)(86362001)(38100700002)(83380400001)(71200400001)(6506007)(1076003)(66446008)(921005)(478600001)(91956017)(66946007)(36756003)(2906002)(64756008)(44832011)(76116006)(26005)(8676002)(316002)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9GetVxHnKUt/jDvuXwmw+kn5i6YQ39ehBL55FK9CE9/HIqTxodKL8fUBi/?=
 =?iso-8859-1?Q?1MuSrOE+0skYhNCuLvv2tm8X6LoCfWgiFaiWB/BjA/1dSpjvrd26PW5jyT?=
 =?iso-8859-1?Q?wwfJygsY3Nl4cmgREookvIyQzjRw1LngduM9lDNGPdz2OBnUaVmcZud+0q?=
 =?iso-8859-1?Q?YfqVs/s9nNFaEV+6zmpwjHIm/LjhvIwrKNlRDjgfYGyAfE4GJHtbi7TaaL?=
 =?iso-8859-1?Q?y5qPj6EOTSS1BzqVafUMXj9+O0mr2SKGEvBjV2kpmUKrXbc78hTIpZqQjG?=
 =?iso-8859-1?Q?HlsanGQKtJ4Th8KZVdd+WWux+20ZD1hxgRMxXkgkF7+3Xt8DnZ10998GCh?=
 =?iso-8859-1?Q?Z+/xgAImpjuliYdVOMDS5pfiiqmdlP9pRtFkvhbFnVHKlTwSpPieY2Eck/?=
 =?iso-8859-1?Q?Gs9nKiOUk6tIKBRHe9z3xCeXzafDZ7IBKnHT2pGfV4qOIGekv97GwJogpW?=
 =?iso-8859-1?Q?aDFb4DU8AhD5WJF5ipOhhYbogKfS4ar7ePhpnZmdX81b4lXgsyCIUEZZn7?=
 =?iso-8859-1?Q?WyMsqtaTrmOnmjEVtZQRSQc/uchrEJkI4lt4EZ5KtayKdC7k0vs4q7CL6e?=
 =?iso-8859-1?Q?20wU9uN7bngzhcAXDJVEyWWERtu4gCBu61xeI6dR0PH5tPY+S3eCtIH/E4?=
 =?iso-8859-1?Q?tl2t70tpIh6rffH/XkcP4UiEjeex4HmANf2Gf21gkizlvSAuakNlJkvD/e?=
 =?iso-8859-1?Q?DXIesiPZcajYTR7Qc5mBd2u9oZc9gfxAY8hr6ETrXC2Mws/E+o7EZE+EVo?=
 =?iso-8859-1?Q?OaqUNUSHpsWWlMwOzJUp+rzhMKzSvEpPVFPG2JwHmmbJnTHDquDvq93fPL?=
 =?iso-8859-1?Q?EuyFMgjSSs4MxGw9VPGBsO6DmWJtYOjaSPtVRwnZf1Oc7YnsLCC41epzl7?=
 =?iso-8859-1?Q?2g9II0pSLZLW7o/FIewE6uI4BIZcW3dIATyOKs+F4cU7GzEQTay+uUowgQ?=
 =?iso-8859-1?Q?NHY/BPP/7A5ApTgs+VLn1sl8TF6tBNQw73PupNo4PXna7HSbg6zmu4GP1Q?=
 =?iso-8859-1?Q?JCm6RpZdjtmbIeAPhn9Szx244hk0Ngeq3vt8uYl+pXAW8+7hDj9U8vs/Do?=
 =?iso-8859-1?Q?je5BItwo0bNUjmXg6VlVDw5MkvKc/N5Zmu83pvQi9Fh/KqMsqf02RWpoNj?=
 =?iso-8859-1?Q?w19PtyWgkxyueljkiWK/kVwcsG48iDeHyVKU19LknkDMI9E2t8Qp/cJ/Qp?=
 =?iso-8859-1?Q?nch1CtEcDzSBqQtKSX94/zcDH/0lcNEpNDmpXJNHSsc6/im4YIjt6wj6qH?=
 =?iso-8859-1?Q?TjvOzX3icV+sDyeUQTZhbnQ4I5uMI8TXirUgs7pUmf0odpYUG4siUUth3d?=
 =?iso-8859-1?Q?ldQL5aBX3IYZebwj9KnhgpBHrGK1Dwbx3mVK47ID28XKPh5GsLS+OVHxGL?=
 =?iso-8859-1?Q?vtmkchQstwANrgQyGbGJ0RtyF2Z25m0P7HpI2CWZ1TvjSP1pLsFpu0P3Dl?=
 =?iso-8859-1?Q?aAtGsnxFPAzrNthtTyd46VJV1lS5NxgwbL1MA14w2e7Qd+zsWnS3MUUFO3?=
 =?iso-8859-1?Q?AmFbbF3w+leDE+8rNBgji8rFOAToz3+fljWu4i9kRh//ySpGrD6rtW4aaG?=
 =?iso-8859-1?Q?1tAoVnmtUfJIgyb8JjfXHQtna//unG+19NuNDDKSYcqd0ib/v/rjXfzdmU?=
 =?iso-8859-1?Q?ItcA+zcv4YQR1svolqo6fjqiJD/4udspQBYK+n9TKDXyisTb0W+7CTCA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 097ad632-9304-441c-9489-08da58505c22
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 15:18:59.2119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T15REgXPm/jhJiTU9dVvsYrFiMWHQYBwWaEHEF6LqgiV7Sh9oa91UMlyw8+zFIE7rKxUB6vZE/OrFSKFX1XhiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB4101
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-27_06:2022-06-24,2022-06-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206270066
X-Proofpoint-ORIG-GUID: x_0Ap5wGsHCIAcAOjVXR_opM-WDxTE5E
X-Proofpoint-GUID: x_0Ap5wGsHCIAcAOjVXR_opM-WDxTE5E
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When munmapping a vma, the mmap_lock can be degraded to a write before
calling close() on the file handle.  The binder close() function calls
binder_alloc_set_vma() to clear the vma address, which now has a lock
dep check for writing on the mmap_lock.  Change the lockdep check to
ensure the reading lock is held while clearing and keep the write check
while writing.

Reported-by: syzbot+da54fa8d793ca89c741f@syzkaller.appspotmail.com
Fixes: 472a68df605b ("android: binder: stop saving a pointer to the VMA")
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 drivers/android/binder_alloc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.=
c
index f555eebceef6..1014beb12802 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -315,12 +315,19 @@ static inline void binder_alloc_set_vma(struct binder=
_alloc *alloc,
 {
 	unsigned long vm_start =3D 0;
=20
+	/*
+	 * Allow clearing the vma with holding just the read lock to allow
+	 * munmapping downgrade of the write lock before freeing and closing the
+	 * file using binder_alloc_vma_close().
+	 */
 	if (vma) {
 		vm_start =3D vma->vm_start;
 		alloc->vma_vm_mm =3D vma->vm_mm;
+		mmap_assert_write_locked(alloc->vma_vm_mm);
+	} else {
+		mmap_assert_locked(alloc->vma_vm_mm);
 	}
=20
-	mmap_assert_write_locked(alloc->vma_vm_mm);
 	alloc->vma_addr =3D vm_start;
 }
=20
--=20
2.35.1
