Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A8751018F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352194AbiDZPQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351988AbiDZPLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:11:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3C516096B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 08:08:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23QDT1NV015475;
        Tue, 26 Apr 2022 15:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eh+V74m1VMYVwSuCRNb1CBSFn2q1JG1SE3YqCwcro7I=;
 b=EL2vSWFI0CfY6LZQGrxQrD8WgBLHH/APi6W6oqQrseYjAfKSxyxkqAeOC6Rzw6op2n1B
 B0eJt9afq/S5uMcfmFUmTrn6rShgwS/yBVEk2MOyVyk3VA2jOvMmrlZqLsrL66DWhOo5
 BHmuJ+BgXd0dY+cJcC8BSUmWyNdrGZZ1m5BMBU7dZXqS80sI6IVJNZzqLR0H23b6C/Pp
 KhALbfpRuBgjgKzy5V2A1Eqbtbzu7VC0y6HSUK5f6cNv75++LuHi3vEQuql+MryvbcxM
 pgQyLYzN0zNaDR6Wn411SH5QO+k/Aa2muF7S9Bhe/8VIwDpQ8uTdhCqA/UAnby4wUXfw mA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmb9apbtx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23QF64vj012575;
        Tue, 26 Apr 2022 15:08:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w3gsfk-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Apr 2022 15:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5R/Q1InA+wgGx0AaZ+uYcSFg3FSvBI7wSk2GZ2JGCZY9BZSJy9aE3gytD/IEBFNuFlLhR658rA29EmhmCMp085mtbs3toUKtEiJ142Q0w1lI1O4SImpJlM9218uPsYMVQr66HE3yaK1Hp7JuZzfwy6QFY+mJGVWtC5mFY7YUYH/78l7t9zd+Gz2HqJ7Y+5XYpTRS2MkIDiXXtN9U6WW59vOno6gBF6HAX+znTZ2GHhLjOnSA5S73w3GeEhASgc5ltwu7sb5ksuRUbg5Wx6duNkU/8jo8mpQmG9VudDNVkJnZWLoCu1d5/C3sTeWhSckhwCZYZho6CUs9UANwC7MJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh+V74m1VMYVwSuCRNb1CBSFn2q1JG1SE3YqCwcro7I=;
 b=Ivxf7ig74JmUA+AKMDbXFVvtOo5fycxDzfuay0UGi7L0/rbTav2q7yb+DSaE+wZQhgw7dlT5THI/PG3rc6IYYw1u5eAmWrqeiIL9AfbCXOP2GC+IMXc0DstQ7qXpUQ7aBisxs0Or+u77z/Sl758xhI/eee5ddgKYEkDtdES77qeK6BWzMoSGLPl6GZTWHTGKZUJQQ95ww9MB3T610IIcWdy/lo1kWwhVWAoXMTtixLd30RaUWySWVTc7DzraQPKGjCvc7asF5WvQ6SaYJk47b4ONIM+0wacs3ZAKlp6BfS8PjMs0HF4xDD36Rq6iWUjwHymW7Rljy53zrDtIHOWyBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh+V74m1VMYVwSuCRNb1CBSFn2q1JG1SE3YqCwcro7I=;
 b=nKbCoFDibXTC1RXJQLgcyYIWpjdSEcAyHzDtTUUUpSUdKg3o+HDvSwzqMad4ko5/xuKWT/+woHCd2pxY0fdd9CSrs92BrTh2KMkVmLoNaEUUQEdUO+rsC8SfeBJbw3jORLoq5rtYysoQ1MjohQU/X0+uiHd+stxan+uq0y0Mmsc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM5PR1001MB2377.namprd10.prod.outlook.com (2603:10b6:4:36::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Tue, 26 Apr
 2022 15:08:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 15:08:07 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>
Subject: [PATCH v8 65/70] i915: use the VMA iterator
Thread-Topic: [PATCH v8 65/70] i915: use the VMA iterator
Thread-Index: AQHYWX9CQunraxQZ+UedGAi1NnHlDg==
Date:   Tue, 26 Apr 2022 15:06:52 +0000
Message-ID: <20220426150616.3937571-66-Liam.Howlett@oracle.com>
References: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220426150616.3937571-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 344149f2-e4c5-4c96-e15a-08da2796922c
x-ms-traffictypediagnostic: DM5PR1001MB2377:EE_
x-microsoft-antispam-prvs: <DM5PR1001MB2377ACF5E8AD26D446054E2EFDFB9@DM5PR1001MB2377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e7MibElDVgMARbhim1Rnf1cpgPHyw9U/EQjm7pa0slHhtWR5nTNBDWlMjDwrAwqUrrjUrlUPDkMz6x8dMRTATgiXkrkkgpVsin2ANwL4kQLjJ6FixieR3B3BixIzP5tRPCLzAT9NNUvfycTqk85YjIUtu30HgKLOxmJNOtmIQ8t+YV1dr1qDUCdjori2Dq1XfVrBYH5IbhkEj4V+afaeOsvWAwTbUv764WVDFiEXahVdP2APDH+oQykqdgC9iyPhmNJRQ55+o8dTs5+ofI8OnbEB6IYcS8Ow+/14MC3KElT82Z1y8aI5soZR5BII5O1UPvgPZMdswZ4HRKrgHSHS0l8jNGVnXcAQMAZfwnvFpqlbN3f/KAgcfnNh1a+5c83RQrPa3bhxzGOtUzXAEm08JC29qOGo2ii5iuBYWFfAjMkKPBqRrbRQ2D8+OTFAh8fSG6vXPLJyCls2fa8zF2eXM6gzjWUCRswuP1Oy63UyS8wFk1/TZAtzmhx6G+gJOiUbNpGP5q9PCPTq0uu3mb7cqP3X67Q9KFrpukMqDwMFHHzsGckWYKK8BmOUBC+J4cRFvPuOJdfzYzeg2XrXNpWokFSHgrdoF8bKOEt6ESZB04C77AE/lMO/AixYLeGsUULL3RUpiTcQ9wrCCvjsiG1W1+/j87cwWz79upTX0JBfBVkKNThGS5Sm4bjN7QZYU7c3PddisbBYPGzduM54fpvY8A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(2616005)(83380400001)(1076003)(8936002)(6506007)(26005)(6666004)(71200400001)(76116006)(6486002)(86362001)(508600001)(186003)(44832011)(6512007)(5660300002)(316002)(122000001)(38070700005)(38100700002)(110136005)(8676002)(36756003)(66446008)(66476007)(66556008)(66946007)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dJktUPa106oiFWY9EExoZc/Y/MbNcWRXwAeKEV1urQsf68GIAv+/saGgY7?=
 =?iso-8859-1?Q?jcIVTPYou4BUHgbrCX9dC1ZWoLmUvHTImr5UYOStKjhbneN+4d67MKb/w6?=
 =?iso-8859-1?Q?h7B7nBlCt5Grqq1pR9iZ3ThxkPOBDqvDyy//+Xix3wFPVZCnff6YULYltg?=
 =?iso-8859-1?Q?FwfdcPaw9XJzd+lCiTGsAcIXYfWt8MKfc94tBSnKNnIHv6rjmYjIJqG2N0?=
 =?iso-8859-1?Q?SGRfMTiHckSs0a47zFLhXQBnGUwDjooXTJagUC9LMUlqIbPCFJFftavkyU?=
 =?iso-8859-1?Q?x3ljuac7qcvowWl9COv4RowMD8n3QatejyxIX+MV44PLWmqupwwjwFRmDY?=
 =?iso-8859-1?Q?N0kFrI9qUMQ9AgtrgrNCWk5968YZP5FBl2ftFLmbXw+4JnUF7pw4APRJUf?=
 =?iso-8859-1?Q?P5jHM/Rt4dW2ceeCDNYYNHETtoTotd81krkWBAGuHqCLeyqzKy8tiOjtEY?=
 =?iso-8859-1?Q?FeuwnLtlxwxs34OPlCn2wDv1y03iZc9PcSMeL23TmS9AhUkdsJB0lCJo+K?=
 =?iso-8859-1?Q?HZlmHZye+nnbG0NnWUYopSHWG7qylGcVgS8M2W33pQ6AmOTnj3n7yUXbFH?=
 =?iso-8859-1?Q?H2nUIJv0iRMYNLdqrGDEH+4Ie67QTC4ft2ArKglkY4i6PjVaACCdkh3rmi?=
 =?iso-8859-1?Q?0WklnQfvwpeTJ86SKivXOhDPxymhp8C5iYpAJVIxdNw/0nvvsjdpTr8hLp?=
 =?iso-8859-1?Q?c9xYj7yRFE83m2ABwuNdVE6zmb9VucqPYiXHw1Yhfv40uYCNfsyfUQRLXB?=
 =?iso-8859-1?Q?PKlE7cxo1MmGeaIWhA0GO5sfLbYs1mXgiAmrQ/Gk8obBuMhYTtXlVEF9HI?=
 =?iso-8859-1?Q?ktGxY8ict/EeZF3q+YJtY+boDzGjV1iEgQgRcp5zYm/qrjsQInl7C3NPVV?=
 =?iso-8859-1?Q?INMrdr5m8lHPW6eoIlVW6zKFKOljfPq4jGlv8xx9BYBfWqokdGyKyhULLS?=
 =?iso-8859-1?Q?1vex0kItW2hCSgg/tMS6IpjlQu+1XurPOi8Gmb1EtPtWVnrCDeNktNoG/Y?=
 =?iso-8859-1?Q?2HkJ4XbWxfngTHNDsElN09IHv26Q9s1F2DJSwKqtf59Qn+XVt4NrXPCdLv?=
 =?iso-8859-1?Q?DF/erg2GxqriVsz5NX6vuVsXg9o91+RKUyVNnjrCHSqr7HlpJFxv8ZqzsC?=
 =?iso-8859-1?Q?Ow3YMSBwAaeEbmMsNKjS0xX7ISytXA5FXo5zEO4OzQ8L8orEnITwNU9J2Z?=
 =?iso-8859-1?Q?XkFeMi47RVuU5DDywnLCMVTLfdFY0HyFlrK/fn42Jm2YRSBMgplvjW8QUZ?=
 =?iso-8859-1?Q?gZS7IqxR5zyAcBpMG4hYZiHNFNT9fBBpYM3wjxMC6DSOuZWd3R51yvDgt8?=
 =?iso-8859-1?Q?2s6IoUVysMfdLh8yKIPY9PvWLRX2YLPvByuXISIW7PkhB8EyE06zXg2kgs?=
 =?iso-8859-1?Q?IDYwPFf8/8x+Wf4URU3Z1eoHRaUXbJEgIsccXt6QGw1yVMAcK1BPvNauMd?=
 =?iso-8859-1?Q?DoDaCdsC0hfPPafQpqqudci+4rrqgtzdYSRG1shJIOLs1bY0WPn/CC5fTC?=
 =?iso-8859-1?Q?xFeaWk+KKA4vK9x76aZMuQnHnuL1mAB439T6JYfhvHyGCombDCYCF0eQt7?=
 =?iso-8859-1?Q?Js26DNz2uMhk2vdhgpdeBPXEs+PU3GZ2SjOGMR4MLNMA6Nw246gJJXAUXG?=
 =?iso-8859-1?Q?uBOviwkVtawm0g4LZUflsFw//eVy0tDDHGNGbfrSrjvAu+XDYrjhaEcaPA?=
 =?iso-8859-1?Q?VVRYE6hoFng2YHANOf99+Y142o6VJ/jyj6wd6ZwOcDj3jkPvSfg0dq3dNp?=
 =?iso-8859-1?Q?KLi7pX47/yep700aRhMRRvDSiAoTocPLH9QmAFclB+xNGbbt+N9DMWSpFT?=
 =?iso-8859-1?Q?jLN8hhqCLKGtODZZHKFrfuLoNQex8lE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 344149f2-e4c5-4c96-e15a-08da2796922c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 15:06:52.1765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4GdhaVP+MAQyM0Hk2aFlsjmwquvLM9NzauGmVdNMm9zbAKOmP5lAMjregBAwbbplb/puoU/u70ltCgVRrBfVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2377
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-26_04:2022-04-26,2022-04-26 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204260096
X-Proofpoint-ORIG-GUID: z5lp8sRPxtakqZD-HLBneX5ikGmC7QSo
X-Proofpoint-GUID: z5lp8sRPxtakqZD-HLBneX5ikGmC7QSo
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Replace the linked list in probe_range() with the VMA iterator.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 6d1a71d6404c..e20ee4b611fd 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -426,12 +426,11 @@ static const struct drm_i915_gem_object_ops i915_gem_=
userptr_ops =3D {
 static int
 probe_range(struct mm_struct *mm, unsigned long addr, unsigned long len)
 {
-	const unsigned long end =3D addr + len;
+	VMA_ITERATOR(vmi, mm, addr);
 	struct vm_area_struct *vma;
-	int ret =3D -EFAULT;
=20
 	mmap_read_lock(mm);
-	for (vma =3D find_vma(mm, addr); vma; vma =3D vma->vm_next) {
+	for_each_vma_range(vmi, vma, addr + len) {
 		/* Check for holes, note that we also update the addr below */
 		if (vma->vm_start > addr)
 			break;
@@ -439,16 +438,13 @@ probe_range(struct mm_struct *mm, unsigned long addr,=
 unsigned long len)
 		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
 			break;
=20
-		if (vma->vm_end >=3D end) {
-			ret =3D 0;
-			break;
-		}
-
 		addr =3D vma->vm_end;
 	}
 	mmap_read_unlock(mm);
=20
-	return ret;
+	if (vma)
+		return -EFAULT;
+	return 0;
 }
=20
 /*
--=20
2.35.1
