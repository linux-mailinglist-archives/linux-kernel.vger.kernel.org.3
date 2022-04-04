Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109634F175D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378122AbiDDOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378065AbiDDOkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:40:09 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFBC3FD8F
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:36:36 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234DoQm8006381;
        Mon, 4 Apr 2022 14:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=yt4FOeIN6pQgvou7xSS4vzWV1Ihn9///H9n57LgKqkA=;
 b=hmdJdvPrtXFV6wnLw7POl3ARsB9mQ5NlGx3O12sGWb7F4RzJVev1M51HMHWU52Wr8wVS
 QpKWUvz+Qht8fKztfG8a8EUKQXXNUeu7PIOW3xXfACowU8MyTA8ekffaqhFtSqJw/IES
 96ZCBQVyiUeUTRkrfsliizTV+HMyq4x6KCkh7sYb6gYNfzRvXVd/Xj67wKNqRoLM2Uh+
 7iBKBvIEQwAwcifhifMe1TxW6iqRUP1sRLpG4so5WJ7H6gEztWwcLWvCHPnJidVj17+h
 jKiCaINF8I9Oh0Ee2uFUJI4QEkuvYEwhCrffBdceum+CoUVEQdvUpCAXsQLDWUtBzj+d FQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf4m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:28 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGceW027671;
        Mon, 4 Apr 2022 14:36:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2gn97-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:36:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikeHqG4gL29FhQu1b8gj7krdfsddlZOEitRGM/9BFNGBv/1+3K3NOiIhcAW0Cl9/22YZAMRPjj/l4V6k5bQywKQAFynFNdIlEWw/JHLJL0IIc9Lg2pBl/En0dibJdeR3RHxdG847Lz7nPFSIdbsptxl+N4c7fBqhBQYVvqTeRPhiy7Ifda8IiWwQUd5yFVXVzsIuzD04/k9RVg/2LGAUxqTTKhZd3Dbsxd/or854H9/rZsxsG3UUB/Rh1yfoXJzmSd14+T/tYCicafYGMinsXJhpGkPs80AweojfhK1mfmL4Np5v1LsOyBP+vWVHZ59XDos/h4E/xX2Ib2obHGK0AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt4FOeIN6pQgvou7xSS4vzWV1Ihn9///H9n57LgKqkA=;
 b=jbotWWaFSqSm2W8IR0OTp+3VJFxq+wmbh0RtLncb/JW7t8BPv7yPbz3PhbbwSKpwW1qhZCH5QHOZq/1fHabhUTVsDP0QDNLjqsd/577L5O7moQaaurvWJ1RfH54qc3Gze/lrO/ZDqszyjpupzAn2jsatfbvq588flwby0WnCK88iNbA0eC1XhAkbcDgbVQVC2bIncuq6CiHoBzTXttBbTW2NdTMR0FeuvC9FiJS0iVPavGA7uODyslQHJFWXEqwRPXwuVeeoH/DkODhPj6L1GJTF0exuf/6EvRb/jvD27PjDhW33fZRTAft4jtQw/1k2AL5292y3A0/70pBrXQ8JbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt4FOeIN6pQgvou7xSS4vzWV1Ihn9///H9n57LgKqkA=;
 b=S48zg4Jf+e2AUmHYDj7w6z7Hk55hfQoaWfrvV+RQ6kP1tc72z5uhvZg3QI1M29PMRwDA1gQxhV1UBEml/TrUHnsXTR77uRkhiqtFpxE+YB+zRGLkLJC3ky/gaPDyhP6ddg8sPZNCtKjRMDXiDzzb+wqXJEBrNoXKnIrJFc1uRI4=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5329.namprd10.prod.outlook.com (2603:10b6:208:307::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:36:25 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:36:25 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 45/70] userfaultfd: Use maple tree iterator to iterate VMAs
Thread-Topic: [PATCH v7 45/70] userfaultfd: Use maple tree iterator to iterate
 VMAs
Thread-Index: AQHYSDFIvZYf8qdEX0am1ON/LmJDmw==
Date:   Mon, 4 Apr 2022 14:35:50 +0000
Message-ID: <20220404143501.2016403-46-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: db3767ce-f3bd-4649-d6c2-08da16487f71
x-ms-traffictypediagnostic: BLAPR10MB5329:EE_
x-microsoft-antispam-prvs: <BLAPR10MB5329B1FF930DAA2A9D9EF7ADFDE59@BLAPR10MB5329.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zGq18JchnyuxzVOViq634V1X3JTP7eXcPz5q81wEzRnvzS37+0lIgzVoISFgSgzgzB+SB/b5qRtGGNCqRwEBk5yQZUariaEoA26RGyAuwDekXxMvD+L2xAQfUgzWv2n0QN6vqjVfhovc6HPzGeW9KFdMUrJWbMfg2qsGZMbLS97kVPxQ6SeN4OH1Tb/8DwuUoN45BVCDJOTRwk8mrArjC3hg7eJxFIVhhhV3OSA+ushEzKSGQZO6b3z06qP9GAvnCZ1CwxI81X81rE+pZBUiconafSx1oAr9PxogHACla6XeEykjIo0Ha5iESwTtRoYw8agvnQ2vHIf/dDMyBNqrZ/r9qbGwuwvw16jLDUnmTnBEs5RLF/P0rug1hZagAu0izqXLCD3njlZbhIYuBpvBxY9ct/VqFTptTNu7ISLtnxVrrF5p+jkwyMs8qoWUVJRjcAE4449bbv6H8KA4LZVomgZG10ZSKFaguYBRan5biC6xF1dWyemyGJrL5aR8PHJNAkvjcsN85N+2Gs3Hw8yZmxD3DSrPDupSXb5rOM3MtNItn32cV0zgSBMC/HvwO0XKVbjmnH3B4UjbmvtzJ7pYLEPs3nbdIdqY+ezuQ2dVI4Nso07bB0BvsaD5tXhJtAa7eOIHApCj8bvPKFq+6dwByFq+ZTtIqNtZUChRsffoX9HI6Xlg2oWeVp2eod52k9g5satU+IPrrKzx850n8FOBXQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6506007)(64756008)(76116006)(66946007)(66476007)(66446008)(91956017)(316002)(83380400001)(38100700002)(66556008)(6486002)(110136005)(38070700005)(86362001)(71200400001)(6666004)(6512007)(122000001)(44832011)(26005)(2616005)(1076003)(186003)(8676002)(8936002)(36756003)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?8VLOj2tEJfy/GvPTcx2CF3m4Urfkfa3kY0FeTbZm0dlmKAyB24Qne/v1fK?=
 =?iso-8859-1?Q?rDK+0VCPuVf0+lXm6uJh5RuzN6xmUYVvvkrqOGHF7rARA9qDsc3BtBAYrs?=
 =?iso-8859-1?Q?jVfTKkHFGLFiPA9yGD+vCJwsncgvxd8EgfQ3oD2EONjK1FyxnRsDFhGZbD?=
 =?iso-8859-1?Q?7Fc6esu8cnAIU7EKGTkSbjzxm4ghTHdrd54n2/NSxgPpR4WzVIYwDL1xJW?=
 =?iso-8859-1?Q?OVzyHbWkdScY4Wb3vwcS57kLyKMPpX79P9FaX/ZZPcZcXV96/hFcPe3Vtb?=
 =?iso-8859-1?Q?jmLt/eNHlfflgnJyQ2Dp4sPrCH3+eeuW2DPCQZ68VNpEEwAn6BwyUJxsKu?=
 =?iso-8859-1?Q?7A04FcOHGgblX5+KZHjfpVNp+ik0MHitGwgJo+x5TLC5z5tddihcEOXO0J?=
 =?iso-8859-1?Q?ShL6T57GK6II3iLg2LgS1RZqCm14qmnd5dNJvHWF6VdXIMzrggpOfeyGVh?=
 =?iso-8859-1?Q?XOLfBF8VytoSElBNAbaPT5Zgqc5qnGL02PMxsCPnax/CNhEV/RIDwAwqJ6?=
 =?iso-8859-1?Q?lOPOkqKU3RKrAVGNN2K6yMuuZGNYBUfbZPdtkEd1dFESV7+03QAUiysmOx?=
 =?iso-8859-1?Q?16WYpvKFgHEKyOBfEMf3os3pOm+Tw8OEhPzASxEI+GbkBT1FblogA0qbmR?=
 =?iso-8859-1?Q?aFVIQN4NVkJWYIgElIpecbcIZu9p2WkDhwP8jCdk7j9JH4IrQ4l25tOh8k?=
 =?iso-8859-1?Q?uxl86MqIGFYABV41xEGquipJrg8NbszgHYTKlplgFKtP0FSd+bHPonEQf7?=
 =?iso-8859-1?Q?evSYpAYTL0bnexHl4YuxQcT6ZUJFI14m2ShbwkmdONAjeFjrzLjJfcrklE?=
 =?iso-8859-1?Q?7nFKj8RKU+/ybyZOLHDWnamJicrBLilwoInZL6RNrncexL+bH/TBQ84Jpt?=
 =?iso-8859-1?Q?Hdf6RcnXLe8sM5b4ZPTrnqSju3GkOqmjMDHnt/8l/XdT0dSz0nSEjNbP0o?=
 =?iso-8859-1?Q?2A+n1JBskDQC427b0F1y5qXPfLzO7sLeVOKqq+jeCBdg+5Uoh2rblGVkx1?=
 =?iso-8859-1?Q?fQr6k6G4jIG2zUAcF/PxeDmqRtx6B2snJ5KnjAr8piqMUcpl+K/sMfn0IG?=
 =?iso-8859-1?Q?C/r5sCNGQnUPvLA1tMPxPr88jAK3cTx98hkhklQi5cZCwyqrMhTuF7kk+U?=
 =?iso-8859-1?Q?qHcl5V5HoPdAd1WgZ16mI1B2dZ7cqcrT8SRPpTcXgKfmVHhQPmfknQTFAW?=
 =?iso-8859-1?Q?mS5vswdOD8gI6Gj409N0CQqFWrFjH3jdmVx1kIAsgMZ+UJmzr1e0NMURp/?=
 =?iso-8859-1?Q?wzcolvpwATRg98CoGFy0LIPSFMUi4GfdG4/nLS4nkCyr7f7W6wJymbm+3V?=
 =?iso-8859-1?Q?7dgQMUDXS9Xy+SIiCzd3IHPHJfZ0f0UZBiAF/paWtJcBl6E2f1JLLr4uep?=
 =?iso-8859-1?Q?mA2Jh5BZCid4me8lR+yP7DUoUoQufP/xmrabKVvB+A7Q07LHbJmExqLmxc?=
 =?iso-8859-1?Q?QgvHbFq4CKG7MX7hSB3C+WTCL5kIrnxhcsR9d5Jds9gf9DFCFpf6AwmtzL?=
 =?iso-8859-1?Q?CvRZhmobpc1zXsR015TCWb9ZMJZgazcryKRGLiZJgRE2kHmSGHMFyAvL+F?=
 =?iso-8859-1?Q?WqMXtL+vlV0z1pUEOp0/Vq1slyTa4bOxPo0ldKivpU2kF387B/lYPAz0Oj?=
 =?iso-8859-1?Q?5X2h2lFunv8f21hlfyVqm1kSYys+5KokfCDPtioEywz4OA3JSPBxsLwk+e?=
 =?iso-8859-1?Q?OthzwQS2JRinWkIwrCtsR2JAyg61+JSf7w3xIrFSXlwU1lCROtlt4kDRI8?=
 =?iso-8859-1?Q?2km9bUbMGP8N7HUjPNrMponRmospU2eQAIo0qPL/TrsQT12uUjESt9o+f4?=
 =?iso-8859-1?Q?3pacOO1nBsOfUe90b4QGjAY/2Ho4Gro=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3767ce-f3bd-4649-d6c2-08da16487f71
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:50.8149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3d8qwVuigGNzGZIDXJT0qvgEzdcCC5q6exfYfst01uH+3deby6Tr63O7qLpk1X0zmLy3EeXrRjqzY4Ehm9Hw1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5329
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 bulkscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: uLdpODvdX-E-Ogi9uKQpwucSnDkyKWDr
X-Proofpoint-ORIG-GUID: uLdpODvdX-E-Ogi9uKQpwucSnDkyKWDr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Don't use the mm_struct linked list or the vma->vm_next in prep for removal

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 fs/userfaultfd.c              | 49 ++++++++++++++++++++++-------------
 include/linux/userfaultfd_k.h |  7 +++--
 mm/mmap.c                     | 10 +++----
 3 files changed, 39 insertions(+), 27 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index aa0c47cb0d16..f4bf95660536 100644
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
@@ -1471,8 +1480,8 @@ static int userfaultfd_register(struct userfaultfd_ct=
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
@@ -1516,6 +1525,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf =3D (void __user *)arg;
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	ret =3D -EFAULT;
 	if (copy_from_user(&uffdio_unregister, buf, sizeof(uffdio_unregister)))
@@ -1534,7 +1544,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
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
@@ -1559,7 +1570,7 @@ static int userfaultfd_unregister(struct userfaultfd_=
ctx *ctx,
 	 */
 	found =3D false;
 	ret =3D -EINVAL;
-	for (cur =3D vma; cur && cur->vm_start < end; cur =3D cur->vm_next) {
+	for (cur =3D vma; cur; cur =3D mas_next(&mas, end - 1)) {
 		cond_resched();
=20
 		BUG_ON(!!cur->vm_userfaultfd_ctx.ctx ^
@@ -1579,8 +1590,10 @@ static int userfaultfd_unregister(struct userfaultfd=
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
@@ -1645,8 +1658,8 @@ static int userfaultfd_unregister(struct userfaultfd_=
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
index 0c548c7bbfe7..d648b551893e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2499,7 +2499,7 @@ do_mas_align_munmap(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		 * split, despite we could. This is unlikely enough
 		 * failure that it's not worth optimizing it for.
 		 */
-		int error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+		int error =3D userfaultfd_unmap_prep(mm, start, end, uf);
=20
 		if (error)
 			return error;
@@ -2984,10 +2984,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
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
@@ -3000,6 +2997,9 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
 	}
=20
 	vma->vm_end =3D newbrk;
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
 	if (vma_mas_remove(&unmap, mas))
 		goto mas_store_fail;
=20
--=20
2.34.1
