Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C30A75AF509
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbiIFTzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbiIFTwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:52:07 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B12C85A80
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:50:34 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdYVg029915;
        Tue, 6 Sep 2022 19:50:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=1gGgnmnzZTiH4CWqaOQaOlKOGm6COOZTpG7+W4yswJA=;
 b=2aWtbXKMgiT10BHZnPq+pbCBcH8IaCSGzQ2XONod+rwz6ej1ulTpiOZncH5WKpfDmnQb
 +vIXzEWTKu99gwItq5vfDSkr8VFXtQgne8WXkcZsjxeRRTQg7ttiOflrPFoLjGhsG0YO
 NDL+krFmcx0H1AyvcknVcfNDrXhPQ7X7KQbF7EEwH9V/EfGrdBQnp+l1Bvdp4V+XvPmN
 KScr7RrzBO0QGzD+bbWw29gQ4elGIb7aCtaySpm0obVQ5HSxIIIXfG7JmYjAHW/CKE+9
 YZ7BX30lHS/8xmz/T2xqJhQRtNtkdxj2AApYfqJMfwVAV4T5ZZNrkna5KVM7HbA2fyXF gg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8hVX027546;
        Tue, 6 Sep 2022 19:50:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kxfb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:50:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCZpJb5BrD740GUg1W4RbEqUCswK1JzJCJrksg8HzO9Wx6r4oBKnoQud2X/xirinSqdDYNE57H3xidK8N32ueAueQ258ptIiXS23+7ZwgBS71yTaCiK4eB1O2Zq93HRH1AUBlnD5CkQJasSs6ZC+UvF9qR8OSM3Rf+vENbfcJHKDaVfTFOv6+ebkW2QG4NTE8SrFFiO+y3YcSHxGzvwsDJmVeGISco29vYg2CwzPR6Qx0xF+E9lWgoQZbH3PUyWtGAqXHfQDTvjttrhvnASET8qjOZroZaTPMswdjYVH3iVUAugbZhvBZkL39uFvyTiRiJqx0D4Bnv9bLJyUBGWv5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1gGgnmnzZTiH4CWqaOQaOlKOGm6COOZTpG7+W4yswJA=;
 b=AVvG9pkFKGwfgRUEBQ86H/uB69Imn4DpDSqwmmM0ZPuKGUcq+gT6T9uXAW/TaQ7eVFDlB6wSoiJcPjWOYiG4+5iQKR7Lvlez26Gl5NWfjKBD6/g8xWd53SO9MHqPJM81Ub+5vScaJHBUHk57z2chfhW3aa5TGQzve553J1KpJCtSLLyc49+lZVSCbrlbY3XARho1Ytd5JXrK9M5fIHmiZKwz7/zeBLDDz0hj06Rh5C11ArRQJXTE+xmy81VrraFQkrXBL3PecvTCUdHx4xgzn5s+sPRBf3ekepO2QUGRRbz3WIFifdPNDrBqqzjysjI3kBBC771455PmLdIpS5O8Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1gGgnmnzZTiH4CWqaOQaOlKOGm6COOZTpG7+W4yswJA=;
 b=lUTZTxJ77T/VNKlyKuEZCeyT10uCBolnpgCwpyILC90uTwUvgelU7mvQxBB5uWBq23hv8sogfCV+cRh/unuQ1OO0MHD13HDk6jwdIr4v1wCK/hi39K1GxNZo4+iPXweCH0TIrCiYe72fJ6m9JuQ97ODxy3D+wflegb0OcZTUquE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:50:22 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:50:22 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 64/70] i915: use the VMA iterator
Thread-Topic: [PATCH v14 64/70] i915: use the VMA iterator
Thread-Index: AQHYwim4yrBrHAT0vkuRmQupqHipNQ==
Date:   Tue, 6 Sep 2022 19:49:04 +0000
Message-ID: <20220906194824.2110408-65-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 930eb981-3605-4233-0883-08da904108bc
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C7HrE8eXxPIiboO6Xmi/ktckhc+hcGU95NhzQ1jdvVg3rjCyAqVZ9ldYWpg8HGCYJSU1LovSwK1DoecktN0NWbiVQwN0LLQhoHE2duo6iDeGPOFmwBefWgR1e4IfS9ToGSqGj6bS/gz/XADgdNuxB3Coj5bIka9CIxHwiaV7j0xa01MSVr4Ji4RA4W195Mq3mjUW8n2pNPhIxr8gmly/9gVcNx7uBcmyQ/BQZ+zCdS1zwTlcvdZftY4va4bqGr72j3F35vQEGuC/ruCjDR9z3MqttQ0ixF+C+OyJkiJmfuYax7LB8br9IFzxKGrClgs7Od87EcT1kVIefgMSdI4JTdDlMbz1F35blO7Ka/sl56/rW3WAo2m7odRqO1LxeX7cbfRizfV+/qkcraBCjkSHEi8/b4dryGZELYj6LKqFuyc2+7sB8Y/B+kgQNyoFgpnadcZBwzHFp2V/6dDITy3RjRbo7J0IiJy01WfVzkKxqMj7wTty1L6iSB1pcNikEfbT/U1jHTZobG8a3AtPzhd0btvXlpNbaCZbEKpsjbQmzRZDk3jpTg7OOYUo4v3uf1yoP5gtaloaGmiezGrNs1XjrEcTEbaTEq3ZCKqQurD38WEXFpbNFcbtQlm93xXyuHQCHpU4ROY+PsXTlDQwFjY6LT3WgDCv/1v2Ptwy/f4AR2Lv/jwhBp8qFtgMyzbrrPELgwlX2K2lVyPpEX/wK4I8Mj2V1UTqivDOvA/KyDh1Mlt6xziHCG0SGvk1mn57iW8RCuiPEuILN/dS2xdryGqyqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MCHomsxWksfGzOJz4322R8btc4n+I/EO4mLJLNsKgh562MV7++ybHTjg1f?=
 =?iso-8859-1?Q?Mh+mJ7+ycc5uIi/+BtJJOJUgPBiS1VkNU9snKR+9rrUlXEt5a5KJZFTRfE?=
 =?iso-8859-1?Q?Ve8jOQW0wFHFSQ7rVi4o1cozN1tss0aw7DYGElJPvvcUZqcjK4tdtzsm28?=
 =?iso-8859-1?Q?xb27eDm0Cu3ZRoc1LmzSfMx4oegxZtfhoH8Tb7EMBNjBpr92u4km3Ppda4?=
 =?iso-8859-1?Q?33GUJoUW3IoRP01SU/wyuafzf9FtPZhrMo6HgQAMN5d0QkoU3sOe9+iW9E?=
 =?iso-8859-1?Q?s7U51Z3vZYeomJDhNvZ6qoAKhVUwpReMRECjjryEYPIE7/FfI035kIS5vc?=
 =?iso-8859-1?Q?rwpmf93BE5ioMHrNpYq9jOR6OnQJ43z23WmystCzYxu1gKUAsQANU3BEjc?=
 =?iso-8859-1?Q?xQ/rtS+R9dBMKMHyOZ3N8isgWq97z5JGyxvFrEs/R5wmgV18UUzWCAtwBM?=
 =?iso-8859-1?Q?m8P9pWuIeVbcn85z6QJsbZ9S6OTv1RBwrL/0JWMT2UYVJnyI/ARR6n3vzN?=
 =?iso-8859-1?Q?CLYnYLOkvASq/S1rv6qyeiV6yNEexCrovrgbIpITmLn22PM8zKKEV/xdEM?=
 =?iso-8859-1?Q?6AqHnqOtDXnwtApft08o+LOEw3p1q6BE9/SQOtRTc1MFSzBfv/SVuvhJHq?=
 =?iso-8859-1?Q?ALtLw+kTBBwp0RE+p+OGKQgQ1iQe3WkUjejktop8zZ02T8tzOhHf5futbp?=
 =?iso-8859-1?Q?uU5s/1h8HQxkEVXAUk3ttN8eOpjfSL19K5vibTDCq2h6Ffykabti97nO6/?=
 =?iso-8859-1?Q?Gr8LqUs2PiCaWIkS1ZK4FipYaQ40m1lYDaKVxrwp67Uw1w/4wG/haiLRer?=
 =?iso-8859-1?Q?X2jS9XSPMeacwoIvN6wpWTmkNNOTwJsDqYjmEc/gxkGokHiWuLpzEeqNRj?=
 =?iso-8859-1?Q?Hj2tlbgJqILLIZfdvNTuhOgmgE7XdX0VjeVgR9/3Cn0QtPj/cmXkQIP1ag?=
 =?iso-8859-1?Q?i/HOiPWtZQFICVsou2gcKnZQKYIEUHX5/BWKe7WM9zGR5MFLEA6pcn7Vnl?=
 =?iso-8859-1?Q?ISteFljajTIdmcFm0a1kN08nGs4kOK2wMYgp5fVzFqFqg/A1mMHpy7go6Q?=
 =?iso-8859-1?Q?NHad6fxLP+ijiY9e5z5eUCKrNaei3AYPRFFu5PYt0J49k3oCK1TeMRUKRn?=
 =?iso-8859-1?Q?M59C0nCr/WZJxNVFRElfRajX6BIXwFsL5fbkBNmk1lRxEAkA05Aru4Pz6p?=
 =?iso-8859-1?Q?yaf2+AYJMJZpdYzoHnu3Y8FoREL89HasPPftgXLsn5yeNqHORJk7k9NOu7?=
 =?iso-8859-1?Q?wkuCHBDRd2IGHR2TX0pmTrHfoQRMqFWimn+bbhJcz16SM5qC+DFec5N2pw?=
 =?iso-8859-1?Q?VwsJXviVHD1Ubdgm/iiWEGxBF9C/OLVQ0rLS3+mypUjKo6wguP3U9V52M6?=
 =?iso-8859-1?Q?HxbRNmsxicT39CMcAJCzkn7hDxH6XcoitpD12OdX1JSmNLJc325At7UJe3?=
 =?iso-8859-1?Q?fTSkljIyaJIwmdgQXP64YLoYEQfVENI5FAfWPMbxhTwslbvRNoT8TpuwO8?=
 =?iso-8859-1?Q?E5ehdDgm9edKhTWHcXkT6FCGHNh+RGsVZIYsBjg27L74J2h6AVaoHsh93t?=
 =?iso-8859-1?Q?f/6cXqd1gSfrjzPCkMthLOfZuDbzXgwIF3SwpFki2IXCV9EJ2MrW9L/UmD?=
 =?iso-8859-1?Q?rXaBRdr63u8Z+ZGjDNvgrLRp7hH6Y7eaXWV9LzcdE0cZthQv45PCSZGQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930eb981-3605-4233-0883-08da904108bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:49:04.8494
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: inMNe62d5iRG0cZVIC6+5/NBC2gcsoBSINxg4lAm+d/sPQxluva6ravdYsmQeyb64sGfDp4OBnDTeeTs9jN3bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: VwYfNipivTEHSSN8kTB1dCRCf962oVZZ
X-Proofpoint-GUID: VwYfNipivTEHSSN8kTB1dCRCf962oVZZ
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

Replace the linked list in probe_range() with the VMA iterator.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 8423df021b71..d4398948f016 100644
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
