Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468E754E96F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242035AbiFPSdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiFPSdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:33:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6375248FC
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:33:13 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25GFVDrU009842;
        Thu, 16 Jun 2022 18:33:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=h5qj213/soAyaTxr9tzGhZGC7+vTtu4dLecKtu69tlE=;
 b=B1Gq4b/X7f7JjQtdcGzOYJ8Ye/mPrY/zoIkwQmRZkZWlgF0NaLWX3cDa3WJQmU9oxZmd
 ARZbubzK4lhLQ+EcK962vYd+HvCzCOZgU8pYeuaxAEo9wYcfpD37LBHm3vIXjcPY9xCm
 k81wWO4pH5bNuw7RWEmm3/6Df/i6m3tmvqVgx9CszuyzS34TAY180hSslaSg49CtibvI
 dEZLrwKEnOmrHJzmQVtAUA960bRPWxNdMxJj9sjdd4KPgnvcyejyS04j9aZWORsrZUrE
 4ZXf/6R9AkpMmTsX+mWFc/Q7t01g+6Yr71g0JPWa5oOcrAe9G6d+fXq7Z/D5EfnB6eN8 bQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktm37u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 18:33:09 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25GIC1IK008804;
        Thu, 16 Jun 2022 18:33:08 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr7qchnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jun 2022 18:33:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmqHmxagvgDMDOmFPgpLkyIMtENmsikOkKRV+tFS890FAOH1nCmWSPfYL3+fHIHY3LFM49DQxtxdlBvC4oHVHwT64Mq8QgKK6cqrjFiReN+m+JvP2si317Ftb48o6iRQYA0Ld3ilG6JP3CdwPjhAaFjRGvDRC4PIbCdKmhrWwP1j6VDHhPu0Mw4fuTDt/V7SC16++AnoijitvBlG2bSY/kp8mRAPGj+TH/TKFeTDMT7kCRVb0mcqP5OykDVY7ln8XRaopgXR6e31hkpirCBWXW8QW4f7fFYHGfh+947vhcIoa4a3/U/p9N8xeBbkXP6NSk7K6D9yBQvDMvPZx79oug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h5qj213/soAyaTxr9tzGhZGC7+vTtu4dLecKtu69tlE=;
 b=Uwo4R7MBEf2ue5xwf1a9FNf1UJKKyQu1wr1K7z9gzkDuibNHnqIn3KdjkPPT5EhHJ7KIg2HESTPoUVc2q8IE7Q0iiWVOtcX+nxXItH3RY0DV+Y7VHCbsnAh9eBuha4vUOLyuAN8vssi+QJw3v6eAw9Acv9FIGUCOdvyYY6DVp0BQmuGob+ktTDwVmRGD75enYodVuuEvI/WivzZXNpMvP4vLJfUHZ7lx3KrQFqgzsXZa+U2kR8CijpoumHNTdkfJgBvUBrP2rkq2NYyrspHTjZxfvFEoh68y6dnSx1njw13OJGNliLaMIrzVaKsUYyrSN/JQ4QtalfdLpx0uBmQwxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h5qj213/soAyaTxr9tzGhZGC7+vTtu4dLecKtu69tlE=;
 b=Ab5N5c0BoVx1UYyxmo7LF3FMFP58LWN/mvnCx7JCIBunOY95jb1DoZlamCqckgVkGU4xwide5PH3Y3AMXQJ2c6OyoLBQRmhcmr0B7Tk5T2uK8wVo9wxC5zKUA2J8ctqydzSWTvQ1Wt8grOANVvFwLGeeCZca8SMc+3isei07+QM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5385.namprd10.prod.outlook.com (2603:10b6:610:c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Thu, 16 Jun
 2022 18:33:07 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::e1df:2e42:6674:313e%7]) with mapi id 15.20.5332.023; Thu, 16 Jun 2022
 18:33:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] mm/mmap: Allow vma_expand() to lock both anon and file locks
Thread-Topic: [PATCH] mm/mmap: Allow vma_expand() to lock both anon and file
 locks
Thread-Index: AQHYga+FqBmQVJ6iA02dGH5lxbiMtg==
Date:   Thu, 16 Jun 2022 18:33:06 +0000
Message-ID: <20220616183258.1153609-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6cd7f151-ddaa-40f4-e305-08da4fc6a81d
x-ms-traffictypediagnostic: CH0PR10MB5385:EE_
x-microsoft-antispam-prvs: <CH0PR10MB5385D015B54D335471E9F626FDAC9@CH0PR10MB5385.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c6OfrybAWZTN4k2cEO1bjXDqxFUINYMw01vp91EF72dsw/YuK4k8R3DR0RCO2JdPIeBjXKoDjVjfDZNbTe9UiycZftfyHiyrJJVYYCTubyxTEwZ++RjpDiJigcB6nypDnmfWEGQykCmQQB4B4DJqCPZFmziAL5IAH0TjCXv3kAtTrl+/CA62B8zG5eGpKMS8hhJ6zdKE1UzpfyXRZ1KAwCRI6oyhQSnYNgpKy/5SRCzYJ3/FZJa0561Wbt7RgQ3Lf3CF7+UaGY1r1FMoK6wBpwMjGfAFJkAfN277p9/EDmNXVKi24Mz//2Uq9B4n2Og2UgEehR1IVyt7/XUlGAov5dxiIQkjMTP+vagF311qdzQg2AjNCPQZZloMUxYgzIeuzoev3Wf15FGsMR0cMB5c52CMR/xS64WMMpHNsYK+zt4J67pUlJ2PgVxjt5UJtYAsWJ/ucaihs7M/COtg22FFjs5F/R9kshTs0iw2DqmWRShzUg8ITXKjIZYM+Y9DG5sjFa0yTsm7E40fia5/lMf+R9+R3GUbzYMxjKSfNHqtMerwHUI9CUpgx6zd3uOvmorBcXeycga4Nff+jMRdr5UOnGthbOpPxLxYLRSksEyYjk8Wz50K1sKxu8dCLPS6CweLwCgpuUTlAhIJ19Wy0bo43WeTFqmRG76uFsNBOsFSF7+920SYffrUjN1imv4tnZFDQeeatA6OToZ7rNMq8kamzQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(5660300002)(6512007)(6486002)(508600001)(186003)(8936002)(122000001)(38100700002)(36756003)(2616005)(83380400001)(86362001)(66946007)(71200400001)(91956017)(8676002)(26005)(66446008)(66476007)(76116006)(66556008)(64756008)(38070700005)(44832011)(110136005)(2906002)(316002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?n8iB+ymolUnwHPyM1ZXoAUxO7itFYmzdmnqr4qn5BnSLcKwv9+EL7vMuL+?=
 =?iso-8859-1?Q?t2bHXtgibq5yNogVipFk64Z3dCsP3UerlivaqdKxqMmRX+EL2HvKNUVWbR?=
 =?iso-8859-1?Q?SUklXv223pWS3jnBI01wHNAGuNCpgyOf61rqrWI2U6KVFc3ExMeIEK9rOI?=
 =?iso-8859-1?Q?47yt4HPylh/LO58V+sj+b7DgrsUMFmQBs571zsILBPja1ooOdbMtGL0a4b?=
 =?iso-8859-1?Q?5dHehV0kYtMqP9Kk9+tRvKo50H+UtPHq1yOnkwuk6opG72XgnVQyDUsXhd?=
 =?iso-8859-1?Q?5CWA83/0lEMABv6GeD5ZIfMIDl83Ok3xWcAi+H2nBhUL813meGxjiuWYMi?=
 =?iso-8859-1?Q?MvovKOuHsUkW9yfyCciFlYsYP+2EendRvUhzgnCwQF6MA/x2rA1hFOCyy7?=
 =?iso-8859-1?Q?TQqhbx88n35+C01OcX8LG6huuHGxA5S+DXRIpN6rVS/RJCNB0NKszXz/Do?=
 =?iso-8859-1?Q?9HJakBeFTYXUTwy0vfl7lKftd9m8jNPL6Lxbjbz7DlsaBb23ONDdixG8Ai?=
 =?iso-8859-1?Q?OYiQDvI250wZfOUzBhjBWFWSr0dke2t3Q/p1M4U2Hpb5pwDQ8h46Mid7Eb?=
 =?iso-8859-1?Q?klgRkevd3vrD6Eo74kdNo8JfGn/Spr+W3Zb9of1DHq/+i5LsvpW5zXeksJ?=
 =?iso-8859-1?Q?R+02s7LloCD1FrskHQKkJmJp50Vnz3WSNkc4G3du4XHdF9px3zCnKmpPJX?=
 =?iso-8859-1?Q?utEAfaYVeW2R45vdS7HyjFP/mgANwKYuVX7nY+fbCvZaqzXtL8NPC7+OKp?=
 =?iso-8859-1?Q?d1C3RJ0ooYbyJZWdoM8KoSXqU3+GgLv6bkm6yNMW2V5uJeaqH/5Dw+B7Og?=
 =?iso-8859-1?Q?auwkThQlYOC/U+5xF0WTUZ1iD378CD5sVeXuPMyTih+vS5ERt3bkvQPsKk?=
 =?iso-8859-1?Q?lqWQ+qhtsJAtTNdtkcMQcSxAX14xR8N/YeF70HDzY1HnYEifcKJd7Q8hNF?=
 =?iso-8859-1?Q?3vQt5yBqTE5N5gGb2kGoO26evfdFbWqR/qwPXRDiyeTguhdAJ9DdxCFUEz?=
 =?iso-8859-1?Q?FWAPehlNIORnZ2FHNAXek8b13OgAOtQ97J30bZfQHccuuF4gksAMCPuQfP?=
 =?iso-8859-1?Q?jToPyv7gL0nrTWZWpukEc1phPU06l+zSkrIpC+73qOwHjPrLT5JBy83ksE?=
 =?iso-8859-1?Q?eHmUT3zE2VRdHCPuSEc07ezZppybaB9TSGnAWLrNe4ZRlqP4LHkqyGlDcy?=
 =?iso-8859-1?Q?b1EfBu8KmU15Cv47I0hKYZ0PWYZdQH4oR/aDcpptt+dB+SDuxu8m+F//fE?=
 =?iso-8859-1?Q?MuQ33auQ8e/u7uKLASkaVXNOdm6ITjeku9qOvs7TAQsuXWLsfMAtmweCY3?=
 =?iso-8859-1?Q?GhH2DfWlHWTP2+syKnNHmhVari0gGcNVHwfznZHuF2DUwTLyMUHNBiNSPx?=
 =?iso-8859-1?Q?hoZQpYj5N6GeiotQJ7bldfjVLcCHQrl25h5IsoTKPYzWf7+AyrSI7H5dxo?=
 =?iso-8859-1?Q?7MPDkaXalc0ozIMUBv1VZ3kaZs4PWpmNH4iiHJnIoAzuoBLdVJhI6G2QL4?=
 =?iso-8859-1?Q?9o+sdaeOSUHCLGWIIa3tItfzKABbUxqwULtsKsevWZDOzVh4CRkn/tJfYF?=
 =?iso-8859-1?Q?X1kcMxYxk/A6ZfLd6JsbFt8nlAD6Hk3zEhG/4pD1Eg/RNONcwaxxpDs0ju?=
 =?iso-8859-1?Q?I6KOuY0V/Mu+tN6ljBlRd7ken7GpfMZCzrmWX7s+h9UzmsbD5zjNEyqwcs?=
 =?iso-8859-1?Q?x0LJzt3R9o0tSifGkBtBwVtmN059lerkkqiER7y/QJRz0iy2ixVmAiyJOz?=
 =?iso-8859-1?Q?z91+Dyg9FZadKjMl9etF7A0br1tbQnbIoE7PPJdBB+h7qZMlj8QpZvKTuJ?=
 =?iso-8859-1?Q?yS++UBckFFhsecu7byKxCiE+XqXjOzk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd7f151-ddaa-40f4-e305-08da4fc6a81d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 18:33:06.8840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G/HmxXeRBuIbCJxGSapGrXs44popyqndKoguBNMUhtDoJwJxLZznBeyfXyURj7h0SlPjvOvX7Ac1o8FNy6z0yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5385
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-16_14:2022-06-16,2022-06-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206160074
X-Proofpoint-GUID: 1zt7gRVP6qtXCXW5AA7hraeSzRCEBe3L
X-Proofpoint-ORIG-GUID: 1zt7gRVP6qtXCXW5AA7hraeSzRCEBe3L
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_expand() was only locking either file or anon based locks but could
unlock both.  This caused a locking error in trinity fuzzer.  Allow both
locks to be taken and released.

Fixes: a5985220056d (mm/mmap: use advanced maple tree API for mmap_region()=
)
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 5599c36283dd..315c3ca118cb 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -592,6 +592,11 @@ inline int vma_expand(struct ma_state *mas, struct vm_=
area_struct *vma,
=20
 	vma_adjust_trans_huge(vma, start, end, 0);
=20
+	if (anon_vma) {
+		anon_vma_lock_write(anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
+
 	if (file) {
 		mapping =3D file->f_mapping;
 		root =3D &mapping->i_mmap;
@@ -599,9 +604,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		i_mmap_lock_write(mapping);
 		flush_dcache_mmap_lock(mapping);
 		vma_interval_tree_remove(vma, root);
-	} else if (anon_vma) {
-		anon_vma_lock_write(anon_vma);
-		anon_vma_interval_tree_pre_update_vma(vma);
 	}
=20
 	vma->vm_start =3D start;
@@ -620,15 +622,16 @@ inline int vma_expand(struct ma_state *mas, struct vm=
_area_struct *vma,
 		__remove_shared_vm_struct(next, file, mapping);
 	}
=20
+	if (file) {
+		i_mmap_unlock_write(mapping);
+		uprobe_mmap(vma);
+	}
+
 	if (anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(anon_vma);
 	}
=20
-	if (file) {
-		i_mmap_unlock_write(mapping);
-		uprobe_mmap(vma);
-	}
=20
 	if (remove_next) {
 		if (file) {
--=20
2.35.1
