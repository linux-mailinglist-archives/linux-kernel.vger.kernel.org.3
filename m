Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D03E519343
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245081AbiEDBTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245067AbiEDBRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:17:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86844348C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:14:06 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243Kx7fg030616;
        Wed, 4 May 2022 01:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gQniI23ich+K9gUubCMXhFBVNLmrDGKnecHOvjIFreM=;
 b=CED7CsG+z9RyhDqOTAGOFckrsaQ4yapdn1XlKp6W0mHng1WlziPgiXauoEmaF7rZ9vV8
 FbFuycMl+TWmxVSLecNtRFp5/1/zRT3GmavjSHWJTL91KmbM5IrWIR/UU/zk2AvicT8E
 6T9RzYbs2YbA7ZPaorKz6xPEQqQNMZ/dlULG/oYho88tIbXloMYG3Z2GkOS321cXOHy1
 UgLWBOL+UHB9mD7cb2Clbok9sDmJm0UngRHH69Qwhe3INYF3rIWNR/Be6HA5ATklAmsd
 pvK+cexg42M/O5qYBKo9+/n8/1DojgJlhJVyvM/W+9X2bVKqvtnKsICPugniA/Y879IJ xg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruq0f60t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:57 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BRJb013094;
        Wed, 4 May 2022 01:13:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv3ke-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls/YPYgItjYRLG+nfFuHsZ4Qxm8wAmJ5HBrI1bTRdhje2/Vfk/qOFpWZJSjYwy/A2Vk0xkScXnX37Eb0GWqhN8necsGf5aJOWewzglYYZUcL5e8ToFgGKQcc+TyFMWnf+g1zXD4OITHT6vpExTf0ZNf7BqjYV4arTEca6lgMJCT9Wz4VYghj8kKgfReARl8LlGJwof9eY8maZsxlx0YLMMuthyP2gpRewh8+x6jN471UpOAj7EDonqMItYjp8LyQpxHCGspfrqLCcQahpdS3WUvIMSQLxQm4rYLHp968l4Nb6dap9TMND060kRD/z/amr7OwQYTNaI7lIHUk7SH7Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQniI23ich+K9gUubCMXhFBVNLmrDGKnecHOvjIFreM=;
 b=O7rJh/+0sU8smuHNW8/QlXufsZORLTot8GzOP5d1R39eg5NVEzvALtjt3GwISfm9BFxOoWr3bm0AUw2lbDqiF4ZsZqIXHUrPZ5fufL8LFBDQ0tx5d1bHrsR+Ut63oiNQYVgvJUCueExetUFpKPVbg2OrOh65yJAPcrmqzCPDOwSybqWmQSapzEPrR0+4V1VtzrpFT3b6AFOoJZZdV11hxmIbOMH+6/CHW4iOhiHipp67BbKYw48OpALfrpQe5dugoDEogwR64OI5ych4Xyrq5msamZRCMq0o7OtVlBbaG5+z9RcV4iCM8UyiTma9irFrKAHrgUJJtF+Qm0jjD70MjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQniI23ich+K9gUubCMXhFBVNLmrDGKnecHOvjIFreM=;
 b=OiJniWRWQ7uDunJLaPg8Mo/My4UWDZRm6RZK0lsuNv0SsrxnRstXShYjXr0o203L1x99HZ+5djyAFahH6V0QZHNQCQgzbYIt3NckaoRD7jvTPAswq/CqmBPUT2RoiLzwpQtO6UF1smasKGkeucWCdx6Q9t2AcsaAiwQH4a9X9Fc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH7PR10MB5830.namprd10.prod.outlook.com (2603:10b6:510:127::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:13:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:13:54 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Topic: [PATCH v9 28/69] mm/mmap: reorganize munmap to use maple states
Thread-Index: AQHYX1Q4yL8DgAmWa0qTBFcC80Rd+g==
Date:   Wed, 4 May 2022 01:13:53 +0000
Message-ID: <20220504011345.662299-13-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ee352c6-c3db-4d21-4171-08da2d6b5b45
x-ms-traffictypediagnostic: PH7PR10MB5830:EE_
x-microsoft-antispam-prvs: <PH7PR10MB58305C727F5F2CABC9CBBDA9FDC39@PH7PR10MB5830.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YFcuMiCCxa7It8JRW4DgX0AeTXclzcmZqbwedkAYCndAo68PW4vizSNB8o8wA5Z43CyDOGvVISA3FECWzzyGTGiZymLQMoorNKVRsq3oytwV/tQT3l76za30/cQXPxxF3VeeNCWup0yvpNhBEXDtfmzuuDwyHGWcHbOn+kvjYBFgO70owN53oZD99Gh37ADGsIYzOPgVL7Nyw+OKg919t/vOWrbMTdDD3VIxPEUkHFtFj0G1bMpbQJLfjXfkOWDH5j37NmH9PmEGbwmOLr0Ma0wQIDuejFfM167htS6JzesM0fwo8r9WOGniv+k6e3TyypNp4gy2u+jiukKEGDKCdl37TX4Bz1tppHMdunLI0M4yWdAJodGT8tA/hDzD8THpaDD44A80ff2dZQ6QU4wvSTGUgR2JxBS7qCh5MMxfPsGgmmda4+YeOf/+GX5MfW8hcEbeUflxRgSIZKjb3Fz4OZviORX7cLaxTung1ITWCnYrtdfpjP1xVY0w1H/CvKQateEduQgeeyUqa8VTnvB+llmNjmrzEStcdv++LnLV22dWxiWHt3BiMei1vRjaid/Uq39FZwi1hGgnUY4Zh3/cU3y00S6scAR335N41iRAsWjt1a7YqRamUHxS8HmiKAwWb8TJILzEycotjGKkq4DT/h3v6HtfCxnojP8zo8kiN9K77zJnxVOOeZEcchMX1KMSxtosjFGLty16kJZKgpubQg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(71200400001)(83380400001)(38100700002)(38070700005)(122000001)(316002)(110136005)(44832011)(2906002)(8676002)(5660300002)(64756008)(66476007)(36756003)(8936002)(91956017)(30864003)(66556008)(2616005)(66446008)(66946007)(76116006)(1076003)(186003)(6512007)(6486002)(508600001)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uLCfAVBErxLKunVYdfGSiHvlHZvckW96zlxHMa7GTObDWRMTKt37PKwCJ/?=
 =?iso-8859-1?Q?Io1fduUOQkUAHkZLfTfZOrbLmzhT2Rhaf0EvTqccPe9t3IA1DHQdrai8Zs?=
 =?iso-8859-1?Q?of6D+8PICoi6qiKJacySwDfL9aSSEm9qPx8igPwZf4WFG4YQ2zIYcJh8/4?=
 =?iso-8859-1?Q?9MbH9oA+g7VrAEx6C7u1aRZtcagjB7+FI1h90mHWJIkwSinLQqwJxuyB0N?=
 =?iso-8859-1?Q?sbzAOqhxBsFxzrps056abEc6BfC/G0wLZuAQoLnT0DxPKNOC34f0hRlGDg?=
 =?iso-8859-1?Q?aew4lxJfeArHon5r8DAV6aA18/GfrW1/sS9/ygUrRmLGDgguWKWjGOZR8y?=
 =?iso-8859-1?Q?5WBwAkilDT50zqHw+qPZet7FNke2pEX9iAG+NRnTJUdEaq9My3dPWG/SyF?=
 =?iso-8859-1?Q?NntrD8q7O+WjvAvY+e+Bi6xqv5fN1Ri+2DNwjWhXE16Lw34f0nbaWmxd5F?=
 =?iso-8859-1?Q?W+/a1Xg48rnGy8+XNMzqJl6r1oarbZW6d/oKcpo7Kc1BkllkXQtV4MgiGJ?=
 =?iso-8859-1?Q?jw/xM7qz8TCEmQGCWw33JNwixaZlvH2hxGfmFY/O1y28qy3eUcCfpCD7zJ?=
 =?iso-8859-1?Q?uLstnsaM+l34EsZE+3LF5kvZFMj/aR/Dz3cxf2Tpqmg+7dHwEb110inCes?=
 =?iso-8859-1?Q?LPViKdObO11ZLy8K6GoOonsImyQVDkQEgaE76aJoF7vE/OG5J4yafFee7C?=
 =?iso-8859-1?Q?i10vJ2j489YNYitH5JJicBuYdq5JgncCp/p9Iloex1BriOzy7FXS3sBPIC?=
 =?iso-8859-1?Q?pew0oo9Ld8rjm/K3U0rG+iG0v4d11qZJ0wLD7Q6o7Wh1/XtUA38bHlMD4k?=
 =?iso-8859-1?Q?iQZj28VmFQUQnIdTQRxPiBtN7i1Gs/tejohXvVngBx5ln2rKurqIE1S4to?=
 =?iso-8859-1?Q?sHlUh2aS/SnvqKwH89rPayZJSkB8gwT9RlVGLmRdruxKSRhzZFpzdm5Rj0?=
 =?iso-8859-1?Q?0uyNgiMr6WOIU3ma3RRb+nMogYWtb1Hmz/bB1j2o/5GqY4CaAoqP43j339?=
 =?iso-8859-1?Q?dqpIWYVWKgGzH+0U+jzDYnjxuHf5VlOXYkqBbvkAAXDddzIdltVshvCpIA?=
 =?iso-8859-1?Q?bJOHeE6velG9JPeaq/lOMrkT6iBaxSeZSYYPuYYAY64c6GUX6d5cbL+4i9?=
 =?iso-8859-1?Q?H5a+Fgo2KXmOM/AP11iONlXCtkrVeXa+kPGf3w0L8ARtIOgU7wLxAbgKzW?=
 =?iso-8859-1?Q?e9z4TfxOlv8Ky4KTxJcBcKO8hm8e3XglRM/KgErAoPsybAmrQfiAslBCTg?=
 =?iso-8859-1?Q?HH89UEdH7DD46useN5VGML/flmxLgZ1ZxoMeNgAfWpTu64Hg/CubevzxwG?=
 =?iso-8859-1?Q?7kMs1bCB2C093vBMlkFneslpFRcES1n9nfzymnGgbLvXwtzknIR1EByfzF?=
 =?iso-8859-1?Q?y/J/XB4h9a6k8otRQglbO3yJBulAl85KiUVzlUyXdNspeP3PZTnNVoRX+B?=
 =?iso-8859-1?Q?NrO0HIS5UNb+D2SKBY2ls0HXb2j1pnBIxWZHCIu+nv58ZvUpsdTdC3Lrtb?=
 =?iso-8859-1?Q?/vthDTuQTRw843AlbLDjafbcJAKB1Alw2KOGCR4fFa/OGBM3lpxCZ66FpC?=
 =?iso-8859-1?Q?8LfY0rSYEeuFTus22+peA3bbicN2qndNNUIRWI6gX64pcBcz0HUTB+IvXw?=
 =?iso-8859-1?Q?MuPXP4i34ujB7PsMXnjONXRKbma4MlFQCMaAFCFWzcTqB8sUSlnn5xLOTC?=
 =?iso-8859-1?Q?Sn/AmqrzcID070GKKu98DbvxpsxbetF6TS0LPcBXHjx6crMsjR2calIMVm?=
 =?iso-8859-1?Q?p8JqLSmbbTwMjJHIsTeTWhjxS6SwuAVNhPuKZv/IF7fZO0+rAt71LMhBdL?=
 =?iso-8859-1?Q?aF7tkBFJPdgG20pGM2Bw43mphKweE0M=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ee352c6-c3db-4d21-4171-08da2d6b5b45
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:13:53.7987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2asgxlgitOpx2LvhPsZNvQHBKtZCZPJN7MASa4GqZERYofx81SD+q+3iOcN78DOqpJweUWZCKeoFxY4I7jEo3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5830
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-ORIG-GUID: 2-vqKYgSLJFx33skNmQRLXJut0UDtRpR
X-Proofpoint-GUID: 2-vqKYgSLJFx33skNmQRLXJut0UDtRpR
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

Remove __do_munmap() in favour of do_munmap(), do_mas_munmap(), and
do_mas_align_munmap().

do_munmap() is a wrapper to create a maple state for any callers that have
not been converted to the maple tree.

do_mas_munmap() takes a maple state to mumap a range.  This is just a
small function which checks for error conditions and aligns the end of the
range.

do_mas_align_munmap() uses the aligned range to mumap a range.
do_mas_align_munmap() starts with the first VMA in the range, then finds
the last VMA in the range.  Both start and end are split if necessary.
Then the VMAs are removed from the linked list and the mm mlock count is
updated at the same time.  Followed by a single tree operation of
overwriting the area in with a NULL.  Finally, the detached list is
unmapped and freed.

By reorganizing the munmap calls as outlined, it is now possible to avoid
extra work of aligning pre-aligned callers which are known to be safe,
avoid extra VMA lookups or tree walks for modifications.

detach_vmas_to_be_unmapped() is no longer used, so drop this code.

vm_brk_flags() can just call the do_mas_munmap() as it checks for
intersecting VMAs directly.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h |   5 +-
 mm/mmap.c          | 231 ++++++++++++++++++++++++++++-----------------
 mm/mremap.c        |  17 ++--
 3 files changed, 158 insertions(+), 95 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f6d633f04a64..0cc2cb692a78 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2712,8 +2712,9 @@ extern unsigned long mmap_region(struct file *file, u=
nsigned long addr,
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
 	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
-extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
-		       struct list_head *uf, bool downgrade);
+extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+			 unsigned long start, size_t len, struct list_head *uf,
+			 bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(struct mm_struct *mm, unsigned long start, size_t le=
n_in, int behavior);
diff --git a/mm/mmap.c b/mm/mmap.c
index d49dca8fecd5..dd21f0a3f236 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2372,47 +2372,6 @@ static void unmap_region(struct mm_struct *mm,
 	tlb_finish_mmu(&tlb);
 }
=20
-/*
- * Create a list of vma's touched by the unmap, removing them from the mm'=
s
- * vma list as we go..
- */
-static bool
-detach_vmas_to_be_unmapped(struct mm_struct *mm, struct ma_state *mas,
-	struct vm_area_struct *vma, struct vm_area_struct *prev,
-	unsigned long end)
-{
-	struct vm_area_struct **insertion_point;
-	struct vm_area_struct *tail_vma =3D NULL;
-
-	insertion_point =3D (prev ? &prev->vm_next : &mm->mmap);
-	vma->vm_prev =3D NULL;
-	vma_mas_szero(mas, vma->vm_start, end);
-	do {
-		if (vma->vm_flags & VM_LOCKED)
-			mm->locked_vm -=3D vma_pages(vma);
-		mm->map_count--;
-		tail_vma =3D vma;
-		vma =3D vma->vm_next;
-	} while (vma && vma->vm_start < end);
-	*insertion_point =3D vma;
-	if (vma)
-		vma->vm_prev =3D prev;
-	else
-		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
-	tail_vma->vm_next =3D NULL;
-
-	/*
-	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
-	 * VM_GROWSUP VMA. Such VMAs can change their size under
-	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
-	 */
-	if (vma && (vma->vm_flags & VM_GROWSDOWN))
-		return false;
-	if (prev && (prev->vm_flags & VM_GROWSUP))
-		return false;
-	return true;
-}
-
 /*
  * __split_vma() bypasses sysctl_max_map_count checking.  We use this wher=
e it
  * has already been checked or doesn't make sense to fail.
@@ -2492,40 +2451,51 @@ int split_vma(struct mm_struct *mm, struct vm_area_=
struct *vma,
 	return __split_vma(mm, vma, addr, new_below);
 }
=20
-/* Munmap is split into 2 main parts -- this part which finds
- * what needs doing, and the areas themselves, which do the
- * work.  This now handles partial unmappings.
- * Jeremy Fitzhardinge <jeremy@goop.org>
- */
-int __do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
-		struct list_head *uf, bool downgrade)
+static inline int
+unlock_range(struct vm_area_struct *start, struct vm_area_struct **tail,
+	     unsigned long limit)
 {
-	unsigned long end;
-	struct vm_area_struct *vma, *prev, *last;
-	int error =3D -ENOMEM;
-	MA_STATE(mas, &mm->mm_mt, 0, 0);
+	struct mm_struct *mm =3D start->vm_mm;
+	struct vm_area_struct *tmp =3D start;
+	int count =3D 0;
=20
-	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
-		return -EINVAL;
+	while (tmp && tmp->vm_start < limit) {
+		*tail =3D tmp;
+		count++;
+		if (tmp->vm_flags & VM_LOCKED)
+			mm->locked_vm -=3D vma_pages(tmp);
=20
-	len =3D PAGE_ALIGN(len);
-	end =3D start + len;
-	if (len =3D=3D 0)
-		return -EINVAL;
+		tmp =3D tmp->vm_next;
+	}
=20
-	 /* arch_unmap() might do unmaps itself.  */
-	arch_unmap(mm, start, end);
+	return count;
+}
=20
-	/* Find the first overlapping VMA where start < vma->vm_end */
-	vma =3D find_vma_intersection(mm, start, end);
-	if (!vma)
-		return 0;
+/*
+ * do_mas_align_munmap() - munmap the aligned region from @start to @end.
+ * @mas: The maple_state, ideally set up to alter the correct tree locatio=
n.
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @downgrade: Set to true to attempt a write downgrade of the mmap_sem
+ *
+ * If @downgrade is true, check return code for potential release of the l=
ock.
+ */
+static int
+do_mas_align_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool downgrade)
+{
+	struct vm_area_struct *prev, *last;
+	int error =3D -ENOMEM;
+	/* we have start < vma->vm_end  */
=20
-	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+	if (mas_preallocate(mas, vma, GFP_KERNEL))
 		return -ENOMEM;
-	prev =3D vma->vm_prev;
-	/* we have start < vma->vm_end  */
=20
+	mas->last =3D end - 1;
 	/*
 	 * If we need to split any vma, do it now to save pain later.
 	 *
@@ -2546,17 +2516,31 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		error =3D __split_vma(mm, vma, start, 0);
 		if (error)
 			goto split_failed;
+
 		prev =3D vma;
+		vma =3D __vma_next(mm, prev);
+		mas->index =3D start;
+		mas_reset(mas);
+	} else {
+		prev =3D vma->vm_prev;
 	}
=20
+	if (vma->vm_end >=3D end)
+		last =3D vma;
+	else
+		last =3D find_vma_intersection(mm, end - 1, end);
+
 	/* Does it split the last one? */
-	last =3D find_vma(mm, end);
-	if (last && end > last->vm_start) {
+	if (last && end < last->vm_end) {
 		error =3D __split_vma(mm, last, end, 1);
+
 		if (error)
 			goto split_failed;
+
+		if (vma =3D=3D last)
+			vma =3D __vma_next(mm, prev);
+		mas_reset(mas);
 	}
-	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
@@ -2569,16 +2553,46 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 		 * failure that it's not worth optimizing it for.
 		 */
 		error =3D userfaultfd_unmap_prep(vma, start, end, uf);
+
 		if (error)
 			goto userfaultfd_error;
 	}
=20
-	/* Detach vmas from rbtree */
-	if (!detach_vmas_to_be_unmapped(mm, &mas, vma, prev, end))
-		downgrade =3D false;
+	/*
+	 * unlock any mlock()ed ranges before detaching vmas, count the number
+	 * of VMAs to be dropped, and return the tail entry of the affected
+	 * area.
+	 */
+	mm->map_count -=3D unlock_range(vma, &last, end);
+	/* Drop removed area from the tree */
+	mas_store_prealloc(mas, NULL);
=20
-	if (downgrade)
-		mmap_write_downgrade(mm);
+	/* Detach vmas from the MM linked list */
+	vma->vm_prev =3D NULL;
+	if (prev)
+		prev->vm_next =3D last->vm_next;
+	else
+		mm->mmap =3D last->vm_next;
+
+	if (last->vm_next) {
+		last->vm_next->vm_prev =3D prev;
+		last->vm_next =3D NULL;
+	} else
+		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
+
+	/*
+	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
+	 * VM_GROWSUP VMA. Such VMAs can change their size under
+	 * down_read(mmap_lock) and collide with the VMA we are about to unmap.
+	 */
+	if (downgrade) {
+		if (last && (last->vm_flags & VM_GROWSDOWN))
+			downgrade =3D false;
+		else if (prev && (prev->vm_flags & VM_GROWSUP))
+			downgrade =3D false;
+		else
+			mmap_write_downgrade(mm);
+	}
=20
 	unmap_region(mm, vma, prev, start, end);
=20
@@ -2592,14 +2606,63 @@ int __do_munmap(struct mm_struct *mm, unsigned long=
 start, size_t len,
 map_count_exceeded:
 split_failed:
 userfaultfd_error:
-	mas_destroy(&mas);
+	mas_destroy(mas);
 	return error;
 }
=20
+/*
+ * do_mas_munmap() - munmap a given range.
+ * @mas: The maple state
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length of the range to munmap
+ * @uf: The userfaultfd list_head
+ * @downgrade: set to true if the user wants to attempt to write_downgrade=
 the
+ * mmap_sem
+ *
+ * This function takes a @mas that is either pointing to the previous VMA =
or set
+ * to MA_START and sets it up to remove the mapping(s).  The @len will be
+ * aligned and any arch_unmap work will be preformed.
+ *
+ * Returns: -EINVAL on failure, 1 on success and unlock, 0 otherwise.
+ */
+int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
+		  unsigned long start, size_t len, struct list_head *uf,
+		  bool downgrade)
+{
+	unsigned long end;
+	struct vm_area_struct *vma;
+
+	if ((offset_in_page(start)) || start > TASK_SIZE || len > TASK_SIZE-start=
)
+		return -EINVAL;
+
+	end =3D start + PAGE_ALIGN(len);
+	if (end =3D=3D start)
+		return -EINVAL;
+
+	 /* arch_unmap() might do unmaps itself.  */
+	arch_unmap(mm, start, end);
+
+	/* Find the first overlapping VMA */
+	vma =3D mas_find(mas, end - 1);
+	if (!vma)
+		return 0;
+
+	return do_mas_align_munmap(mas, vma, mm, start, end, uf, downgrade);
+}
+
+/* do_munmap() - Wrapper function for non-maple tree aware do_munmap() cal=
ls.
+ * @mm: The mm_struct
+ * @start: The start address to munmap
+ * @len: The length to be munmapped.
+ * @uf: The userfaultfd list_head
+ */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
 	      struct list_head *uf)
 {
-	return __do_munmap(mm, start, len, uf, false);
+	MA_STATE(mas, &mm->mm_mt, start, start);
+
+	return do_mas_munmap(&mas, mm, start, len, uf, false);
 }
=20
 unsigned long mmap_region(struct file *file, unsigned long addr,
@@ -2633,7 +2696,7 @@ unsigned long mmap_region(struct file *file, unsigned=
 long addr,
 	}
=20
 	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
+	if (do_mas_munmap(&mas, mm, addr, len, uf, false))
 		return -ENOMEM;
=20
 	/*
@@ -2845,11 +2908,12 @@ static int __vm_munmap(unsigned long start, size_t =
len, bool downgrade)
 	int ret;
 	struct mm_struct *mm =3D current->mm;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, start, start);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D __do_munmap(mm, start, len, &uf, downgrade);
+	ret =3D do_mas_munmap(&mas, mm, start, len, &uf, downgrade);
 	/*
 	 * Returning 1 indicates mmap_lock is downgraded.
 	 * But 1 is not legal return value of vm_munmap() and munmap(), reset
@@ -2984,10 +3048,7 @@ static int do_brk_munmap(struct ma_state *mas, struc=
t vm_area_struct *vma,
 	if (likely((vma->vm_end < oldbrk) ||
 		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
 		/* remove entire mapping(s) */
-		mas_set(mas, newbrk);
-		if (vma->vm_start !=3D newbrk)
-			mas_reset(mas); /* cause a re-walk for the first overlap. */
-		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		ret =3D do_mas_munmap(mas, mm, newbrk, oldbrk-newbrk, uf, true);
 		goto munmap_full_vma;
 	}
=20
@@ -3168,9 +3229,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	if (ret)
 		goto limits_failed;
=20
-	if (find_vma_intersection(mm, addr, addr + len))
-		ret =3D do_munmap(mm, addr, len, &uf);
-
+	ret =3D do_mas_munmap(&mas, mm, addr, len, &uf, 0);
 	if (ret)
 		goto munmap_failed;
=20
diff --git a/mm/mremap.c b/mm/mremap.c
index 98f50e633009..4495f69eccbe 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -975,20 +975,23 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsigned=
 long, old_len,
 	/*
 	 * Always allow a shrinking remap: that just unmaps
 	 * the unnecessary pages..
-	 * __do_munmap does all the needed commit accounting, and
+	 * do_mas_munmap does all the needed commit accounting, and
 	 * downgrades mmap_lock to read if so directed.
 	 */
 	if (old_len >=3D new_len) {
 		int retval;
+		MA_STATE(mas, &mm->mm_mt, addr + new_len, addr + new_len);
=20
-		retval =3D __do_munmap(mm, addr+new_len, old_len - new_len,
-				  &uf_unmap, true);
-		if (retval < 0 && old_len !=3D new_len) {
-			ret =3D retval;
-			goto out;
+		retval =3D do_mas_munmap(&mas, mm, addr + new_len,
+				       old_len - new_len, &uf_unmap, true);
 		/* Returning 1 indicates mmap_lock is downgraded to read. */
-		} else if (retval =3D=3D 1)
+		if (retval =3D=3D 1) {
 			downgraded =3D true;
+		} else if (retval < 0 && old_len !=3D new_len) {
+			ret =3D retval;
+			goto out;
+		}
+
 		ret =3D addr;
 		goto out;
 	}
--=20
2.35.1
