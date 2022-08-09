Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC1C58DB9B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 18:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244914AbiHIQHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 12:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240145AbiHIQHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 12:07:04 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB310A8
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 09:07:01 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279EfbFt005389;
        Tue, 9 Aug 2022 16:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=2tMJ1a24nxlWVNPlHH9vctMR8v1LeIOQw1dPI9yT+t4=;
 b=Wfix1bMZ5hxYXsJ1OCA/CAPohjx1eVwVzKcLclsK/dCBn4/tjlJoUsr8elrcS0Y3z3wx
 R+EnmIYa7EcTkdBFMaKYgnwfpFFfsTxlb7SizLNPDh/PybcFzB/Yw7lneK60wV8Da02b
 gUbPI7pNLbg78LueP8dM4HqK1V1PWYx9AtVuAu7+VHvXaluZ+fl5v/r+WVzbJkOoQXPg
 mUPm+ET1DzeqQmloNQkOw/aDWKt03pQPIu65UXq0J7tyr28vJsEvUygMyBLeNAGZbN+9
 w1Fs+pNS7UNJSWizEBUpP7B3MDFn2M9qzrcPmwpffbsr5KZKX0lN4H/PveqEVTeb/ozm gQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hsf32f14w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 16:06:36 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 279FmZgW011626;
        Tue, 9 Aug 2022 16:06:35 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hser2tcue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Aug 2022 16:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICocr7uuinw5LHb0KsdR1SX4TJqUHME2lq4hlyYAV+5dLchLa2ACU/ebDeA1I6vpBjjswuv1KmtFgperKve7sBp/arSD/FjdKxMw6rHaaXw5DXuRCVzZYkkaIHx7/84ZlGFkvPcubRO54HGw28MMQtWdfjHVEuhkrCTcUIH7TzJLZgVQCAs+H3z6xHhYGHYDAfkJPhippTcIsesdGfIp0OWOPQJ/yjWdx5ntA+/V1wZVw5iG1TTLksakQI3Mt4sagmYxqV8GYvnoCeU0WPsqBx20qRRwBEjAThT5tLVWG7JCm6Y8ce7j+kkUVvhq45wvt+T6lwoWZwTbFKFVR1ptFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tMJ1a24nxlWVNPlHH9vctMR8v1LeIOQw1dPI9yT+t4=;
 b=i0tBrK4Jt8860rlluiJEw5qzydZU/8So/2uSO1gqHqOvDvtZY+5MC1Pv8Rfd1YZu7zhn/rkh01eLutKYMTyM85et4tku7m5eh6Hxk51wgKoduWnsN34LZ7mZW4IHvevlm1MPJRTOm4Jzq3x/s2n5Auwbxw20QDl3tG8fuYYpx1NDssmAIm4RDpDq+hkk9ju7I64kps8a/EOeej827VR3qyNnMbkeCn7goIUjfqY5v6LNBbIW9s+vOEVzW/YuL0BctLOxnPTH1kB126h7Wqhom7qZB/x+P8jnsGvfbcF7iCxe/uyCMwkRCL57Khe9wiS5nXPmAK2VPk/JIh/tVFkRjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tMJ1a24nxlWVNPlHH9vctMR8v1LeIOQw1dPI9yT+t4=;
 b=nKWRjEGReQGJZvcd/pIa6EQtUYtbZX7isrolvmjD41SVriJfmtof0ea3Cv91rR4wPNWMvCLA1BbmJOn83WBf/bTHa6YmpdxjA5ytGQMc/DesXbiCzUlHLKOAni0YdMYtL6peFJZfw5s9MJikhSC25Zy7g3hhSRvYcP2WsviP9cQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB3451.namprd10.prod.outlook.com (2603:10b6:5:61::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 9 Aug
 2022 16:06:32 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5504.020; Tue, 9 Aug 2022
 16:06:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
CC:     "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>,
        Matthew Wilcox <willy@infradead.org>,
        =?iso-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>,
        Carlos Llamas <cmllamas@google.com>
Subject: [PATCH] binder_alloc: Add missing mmap_lock calls when using the VMA
Thread-Topic: [PATCH] binder_alloc: Add missing mmap_lock calls when using the
 VMA
Thread-Index: AQHYrAn9C2tDT6s3j06giZb3JwoEAQ==
Date:   Tue, 9 Aug 2022 16:06:31 +0000
Message-ID: <20220809160618.1052539-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bb4dd4d-7441-41d5-299d-08da7a212034
x-ms-traffictypediagnostic: DM6PR10MB3451:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzffuyJ5vCI/mZqOgNqtCK5/raB++FaKk63LEhH3woogOeILZy6I1DB9VPz9UrgCPtcTA1jEck75t/GkXvvfmV+A02ikD2ATylx7xS/fENx+gUnkBpGDQOQLvaCmgWWrkH1hISTAYv05pgbwrEI3mSpTCkgpA+dMNBrJ/y+XQzCDLueHBWDttu2hnmVe7EpigGeP2p4X899I5kbwpN7s8LF+zsQdJsjlbHgTAlgYhTDSLiZpbOmIX6wSAoQFvXFlR3ztryU4s4HM02GHHXiWAckdUObEwsFeLsFbRtipvCp9IimuVfcz0gfBQmF5TQM1Z4Yfr/Q2IRAjN0SBpG5OPj6TKcEHxoRl27bVr21m4zIg7RCFDMlNr53AiQxPzdLApS3JfY5+fe4GmEpHwWcCm9E3RlhqLGWeRDiIVkFk2L8bnRaNRO2fN1l+0gg2qICTB8O598HAbd0aE7fvXjkVlPH30ChEzIch5XWIWNYVU+UcshuA7PpX8LcWFkkM5yRRkvfRHWGb9C7avopO1VvY94awu4MyjxmPrZRbZEx4iretttXn73Km5+aB92BfwYxEVNN9ick+0E1sxRtQ5c2w5pgYUfre9XRznykwirI3gfm61iE8WMiDG19afiHikZHRvKvaZshqWRCX+HuM1vJsUcCnoZ82HFpD4zGe0S9tjxdlnTREngpaltYdg4XLiqM//aewTZqn9RJLT6lqS5+pre8DKfR9+PI03j311wTerDwhHlzVVkumEQ1As608vxbb3M6xNmnb94mSyEEjPDeep7h3WGJKV6xcW5DVO47vGhY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(376002)(396003)(366004)(39860400002)(83380400001)(8676002)(38070700005)(6512007)(41300700001)(2616005)(1076003)(26005)(4326008)(110136005)(91956017)(76116006)(66476007)(316002)(66446008)(36756003)(64756008)(54906003)(66946007)(186003)(66556008)(7416002)(6506007)(478600001)(71200400001)(44832011)(8936002)(5660300002)(38100700002)(86362001)(2906002)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ldjAjgPaLTbZCtAUVeeEKlHiXXFC0AYngMWpw/DAxvwdsCa6NB59BKDefl?=
 =?iso-8859-1?Q?kAO4GXWqRTPORIIZW+WyuYWfjhtN4EQkZYTcpIPQv+3517jyb4T+8hgVYj?=
 =?iso-8859-1?Q?daFA+uCdUVAXtrbTm4v0n/S3LRo/RihHwlVyg4Kx0E9EWqzrwyQ0paN9er?=
 =?iso-8859-1?Q?l3fNyWCqNIZKgYR/pBodklP0AqH7f2QpkURfQKzczXrWgLzNpmy2cwR80m?=
 =?iso-8859-1?Q?ZpuUitr5dRDCRPLRPLpUtT6C4AEHV/YYx6Ijnts+vQphEYg/XSpPqt2zUa?=
 =?iso-8859-1?Q?ubaJ1I7FUBqizH5sYRC5+e9TcILPGZPorzcK0r9izlJ/Wwzqn5atGF7+LI?=
 =?iso-8859-1?Q?FFPXGPFbV85ve2QuaB2L56fHNGfi3HgC1gSEnD0ik8lfz3hJw8HrxBn83D?=
 =?iso-8859-1?Q?wmnv/JGSANmGOJ3nCVWxRNZqGAq4fHSzuVxvZnxOsTdnc1YVhL0KD+500F?=
 =?iso-8859-1?Q?MSdVVyo/QpDukMrmSfrFbLXkHkBZXiJmIMLc0sY9TeViclI0ar7eYExDtl?=
 =?iso-8859-1?Q?NvlmrT+I82DxQXJ1JUbR5T+YXpuUATQur+RDK0TjHYzoCXVU25wrn6NVI4?=
 =?iso-8859-1?Q?9X/HLUwO4PI2ce44pkJ4XMoBpd/LwVCYnXQa4rrZMFHt6oCym4rKmJ7Pco?=
 =?iso-8859-1?Q?IeijVC4AR0K6xEjxUPdbo75OcA4KHmRx3mHFTWrAOiSpnFbqkLMgSvz3SV?=
 =?iso-8859-1?Q?FCkbdO87Z6A96nImCIH0ZGZTN+E7R27DX4atuyL3BCwqadKoavU79GQbUO?=
 =?iso-8859-1?Q?3MXXzcLkyP/9RnvS7f1QJA92V1JBWjEBH5IDpjByFCIa6sZVakLJT+TR+H?=
 =?iso-8859-1?Q?HdIV3Y4w0CTv0FTCC3Keo+QRQgO9NBaQvSLJ7c9Eg+r1HZh5vOaqTgK99O?=
 =?iso-8859-1?Q?VbfpDI4NJDiWZe68gH+Axbf5qspFTZYMTtuh8SVOYmGUTGsmlkYf/ro63s?=
 =?iso-8859-1?Q?oWGN7uIYIDfQfoEcJDoZRBbxYORZDTPD46KacpGG0BZANaQcVVjdO+Qmvc?=
 =?iso-8859-1?Q?5aca6s6DCCWtIPu4aPwYp2nXocrHkDax2vO4u4Nozux5rVkdHLgzHARwue?=
 =?iso-8859-1?Q?UiGryaioObfk+Fo0XruMdkwB8YiwSxkHCMjRVG+DP0oO8lHOj+REPnCnwF?=
 =?iso-8859-1?Q?K20oLs3SpLewFtvAUWr56wUNBN7oB9XRgejNtZsJsMlG43SNe+kkU38d6G?=
 =?iso-8859-1?Q?Fhw4H0vnxBDZRiLA0KERhiUuO+EJwOZH+fD4Qj5g0RpK21erwFpXNl3UFN?=
 =?iso-8859-1?Q?tr1COLsv1NuWmXn7uD+Sx4TKZCU0hHXTBGhs5edDmiHjmko51JBqQYLuWJ?=
 =?iso-8859-1?Q?Rln/JKiXmsEfZUdYwE1ez4/guHMsWpSqBb6Ukhd2LD2Y/jOn5+SG1gOmGv?=
 =?iso-8859-1?Q?i4+B20CKR1FbL/x1JB/Ct3jzD+Syqp87R/GzveHpgs2vznkhC9BE43StgF?=
 =?iso-8859-1?Q?ajyyoELLOAIVaZnooko56gf9uAxbJuvhszmFHgGoyrmr0cqK99k2hF+93Q?=
 =?iso-8859-1?Q?Bds1/JmGpvHGPocHBEDfKKb4oZUVdG6bExQ0k+CPbuniTd3Hb68gbVsPes?=
 =?iso-8859-1?Q?bubySZDNStCpOnlkm0tk0sQ1eN9GAMUE9BLEiNfXQnDJRjSU4TjnJ2WScg?=
 =?iso-8859-1?Q?ZfL5Ma63CTNlB4p2HLyGMFqIFWcLmI+/3E6+XPPjLBS1doOgG+JvBORg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb4dd4d-7441-41d5-299d-08da7a212034
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 16:06:31.8676
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9gXYR4emYsLzaibd/CkBJBEeJUqmuwZfRM2Q8OkrE8pdubDHlGypm/8DqElRuJgi+sRJCYkoq2mL49rxLlaBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3451
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090067
X-Proofpoint-GUID: Dr3KlibjUxyj7STrMsxjvFs88ALPd5kP
X-Proofpoint-ORIG-GUID: Dr3KlibjUxyj7STrMsxjvFs88ALPd5kP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take the mmap_read_lock() when using the VMA in
binder_alloc_print_pages() and when checking for a VMA in
binder_alloc_new_buf_locked().

It is worth noting binder_alloc_new_buf_locked() drops the VMA read lock
after it verifies a VMA exists, but may be taken again deeper in the
call stack, if necessary.

Reported-by: Ondrej Mosnacek <omosnace@redhat.com>
Reported-by: syzbot+a7b60a176ec13cafb793@syzkaller.appspotmail.com
Fixes: a43cfc87caaf (android: binder: stop saving a pointer to the VMA)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 drivers/android/binder_alloc.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.=
c
index f555eebceef6..c23cad7fe313 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -395,12 +395,15 @@ static struct binder_buffer *binder_alloc_new_buf_loc=
ked(
 	size_t size, data_offsets_size;
 	int ret;
=20
+	mmap_read_lock(alloc->vma_vm_mm);
 	if (!binder_alloc_get_vma(alloc)) {
+		mmap_read_unlock(alloc->vma_vm_mm);
 		binder_alloc_debug(BINDER_DEBUG_USER_ERROR,
 				   "%d: binder_alloc_buf, no vma\n",
 				   alloc->pid);
 		return ERR_PTR(-ESRCH);
 	}
+	mmap_read_unlock(alloc->vma_vm_mm);
=20
 	data_offsets_size =3D ALIGN(data_size, sizeof(void *)) +
 		ALIGN(offsets_size, sizeof(void *));
@@ -922,17 +925,23 @@ void binder_alloc_print_pages(struct seq_file *m,
 	 * Make sure the binder_alloc is fully initialized, otherwise we might
 	 * read inconsistent state.
 	 */
-	if (binder_alloc_get_vma(alloc) !=3D NULL) {
-		for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
-			page =3D &alloc->pages[i];
-			if (!page->page_ptr)
-				free++;
-			else if (list_empty(&page->lru))
-				active++;
-			else
-				lru++;
-		}
+
+	mmap_read_lock(alloc->vma_vm_mm);
+	if (binder_alloc_get_vma(alloc) =3D=3D NULL)
+		goto uninitialized;
+
+	for (i =3D 0; i < alloc->buffer_size / PAGE_SIZE; i++) {
+		page =3D &alloc->pages[i];
+		if (!page->page_ptr)
+			free++;
+		else if (list_empty(&page->lru))
+			active++;
+		else
+			lru++;
 	}
+
+uninitialized:
+	mmap_read_unlock(alloc->vma_vm_mm);
 	mutex_unlock(&alloc->mutex);
 	seq_printf(m, "  pages: %d:%d:%d\n", active, lru, free);
 	seq_printf(m, "  pages high watermark: %zu\n", alloc->pages_high);
--=20
2.35.1
