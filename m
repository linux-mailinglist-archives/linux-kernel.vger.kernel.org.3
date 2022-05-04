Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86D0519374
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbiEDBW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245462AbiEDBTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:19:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAFA44A1A
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:15:02 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KjMlM013507;
        Wed, 4 May 2022 01:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=eh+V74m1VMYVwSuCRNb1CBSFn2q1JG1SE3YqCwcro7I=;
 b=tKRbLdkE3weXxtSYixGGqZJqe+ZAFhNJqi0TKkFrOuU54VVUMCQ7vMY6ib+lFURZYY7z
 K/gWTTj7fD1iewSMpdMHlWEok9hCOVS5E65822iNYU7XQqoxvGj7gzjhR/CPd4bmyAT9
 DYmsIfqdFtvZeuy4T8UDzOGamxZz/ObdDq1R2GSAzhrEc1qgPIC2CCb7b7rUt8pS9/Zw
 Qjy1I20xK0dEacJxMAPt2kgXfdlwGaOnUnblePXQ0/ega7UDAT++2DCP6J/07glMnKhK
 V0GVMhgRF2VnSSpQ2fHRhdKHwvXBJ9J9BXTacZMIzsNdEtpqk7C38aO9omCjjREmk6z+ kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsf6fp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2441BXR6013207;
        Wed, 4 May 2022 01:14:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fsvbmv41r-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:14:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVZvU8sO1civVagqfVvEUTGjPueh3vAJl6MzbtBIAo+MZ9CkL7DMeLr6o6DxJLmZGDWGfYqbKyPKxLLSpLW4z/V8GI/Q/7a8ELnaLrqFR616tOXv+Vg+Bca0NVKtzTdXyCupyYuo0FsBBfFsHlMtXZOlSt/nal1qsQvrNCy2OB2c/iZP1FN4mKXxU46vVhpoFtK4HvHr1m7UFguxKaHmGEWngb8mZaw77zWK6D/0HFOJf7tiVlck2dpfoJ17OLHpd+kf+89T3yOXaQwByuSwWCfkTVdWe+ltgB79nJYhWDazO9hJf7tvqxHRhq0NOW+WsgCS6vYZ6Vhr7P4aWeN5rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh+V74m1VMYVwSuCRNb1CBSFn2q1JG1SE3YqCwcro7I=;
 b=SOr0Ir5iaaK05Lo67D8ijkXdsdMNpwDwMSmQGE1vo1ZVJQ+asr36x9B2saU/sARchEbIhwHASHRmmvHr7IdBO39tTU+A5uZN8dA/C0xK4Rk2qorGzwvRCF3jRqe3vRf8JwRHWqzam1IL3RCJnMb5LZn19fAUsCtgeuNXZEw2RjJLqz4eGAV/eJXAz5op//iNjli8SY/LJa95gnldxgbvn/T1xgQlQQz+U0t+BIC2yzKy/M3XFt8zYKoHaNDTi5qtBknptw/30obpW5cikQM2D4kbZN8CtHOk7b5wWVysvvWEEz45wVxDuAOlg4Ccq3BXPpJ0aDen5EgruoESMwtJOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eh+V74m1VMYVwSuCRNb1CBSFn2q1JG1SE3YqCwcro7I=;
 b=Ywnn7Xe2t61CF8RGNTtKalzcB670yviWVGlUtB10Uay/5B8nKeC2bXI/hD/lkf/k/XpuI4q8mm0x0jBhvy68yPrQnZf8SCNUreZpRaDNP9X++/NlOECPQ9sBlZvqDBncHUDF+XOB3kNb0aic9zPRnVoVXzb2LyHbE0BHGoQppjE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2688.namprd10.prod.outlook.com (2603:10b6:805:4e::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Wed, 4 May
 2022 01:14:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:14:41 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 64/69] i915: use the VMA iterator
Thread-Topic: [PATCH v9 64/69] i915: use the VMA iterator
Thread-Index: AQHYX1RARWarpS6vBEWTZSCRH8obcA==
Date:   Wed, 4 May 2022 01:14:06 +0000
Message-ID: <20220504011345.662299-49-Liam.Howlett@oracle.com>
References: <20220504002554.654642-1-Liam.Howlett@oracle.com>
 <20220504011345.662299-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504011345.662299-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c042cb39-844b-452d-ddaf-08da2d6b775d
x-ms-traffictypediagnostic: SN6PR10MB2688:EE_
x-microsoft-antispam-prvs: <SN6PR10MB268899089843069CBA1824D5FDC39@SN6PR10MB2688.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nIqRl3MVHq8B46f27FFqyJgqkJ7/p3th9wkdzgWQo1cwm/DaM223v0Lx4Arsg4wbi6sKAPTGYtQzTveAngEYb4cRaJYdGUdUqhOG+QNoz7C1EXprellZknCPtSqTyXM3dDbI5enk6R7YQD1oPi7y1ZTSPK+C4Y2b8rRdBQEPBq0sDHHTAWCwXoLMtCRxzIXLYcmyyrDGgOY4vUiRNN4vXtQxlieh48q/3x7KjhHg0zRs2uXcd/16PdT7mvPdrmPDeNucFsm7o60p7GsL6CNPw55OZq+JPPnWfaRVJiCuoDa7ctW4KyvjqeJxrbhmATlAGTYIDGHakUkbyCXzQJxrzOIgBDrGftOfMdWwr4Fm3QP4KPELIuRrqbSoF4IuneEDywQwSE2L1INt6X/S/ojWd2dDYFCau6ykby5f9LVOjvlM3zhCN2eU93KCPTKLEsggAeasl7KZyWB3Jaq7xp6DodF/ZWWHYJZZoWgX72XxWHxVVoGaF2OAoym6Sv5hfa4x0RbblSfk6BWMlh/xiHHvaUVztokQWJaqtvr7rvTDjN06b2cYNiYEpmog6ILLz6follmgePaLk4TmZEiM4d1GFSCRY8dLjW+4XaAQxaYuEVYGtI3bccfhQS7Ir2UyuFUhizWlmD09EVtxYsbuMaMQ0cNgVMceAVqQA2p7KHolhhO0NvO2v3eetWerShnJ8OsQP8e0QzMx+egixrzO3Q2jwg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(122000001)(1076003)(2616005)(66476007)(8676002)(66446008)(64756008)(38070700005)(36756003)(316002)(38100700002)(66556008)(66946007)(76116006)(91956017)(110136005)(26005)(6512007)(71200400001)(8936002)(6666004)(6506007)(2906002)(86362001)(5660300002)(6486002)(508600001)(83380400001)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?18516OYbxtfWL9aOaKYjO3uTOc12A5B4cMi6mgz7ZQOET/V8itDaWDuCBG?=
 =?iso-8859-1?Q?M8YlIUM2+N5j3CQziSUWfBpYVPQ/kguHJ7Hrl4I1k4D5qh0cskhmEZTBEt?=
 =?iso-8859-1?Q?oXBJqqXOoTu8ND4AkvAo+Cx/igsy0F62+ivkLrsRid2SRp8cryl2KBVrYh?=
 =?iso-8859-1?Q?L5dc4T/GO6ggfIAbnHFfqvKF1mkf8m/AzFYOPRTmK8GX6NoTY2AjAIksKR?=
 =?iso-8859-1?Q?ry1HW4r5uQRMeEDMLJ7gOyclsXs8/ySTeM/XMgwOoGto1C3Kk5owR2Ph59?=
 =?iso-8859-1?Q?zr9Slhc70E2g55ATqeYQplaTYWSnY4sKG35QQdn8c+1TL60GJCuPoj8WHH?=
 =?iso-8859-1?Q?n0hJZ3g8zNdSR0d+QsRieeN5D4vHoq3NiEMHk84MpTYbwcv9uwwPJi8eC8?=
 =?iso-8859-1?Q?phNcalEtGdeUkUyXDoaUw1DlJDYWPAFsfQBXMMtq9GdBOBsK23ORS4ybI4?=
 =?iso-8859-1?Q?XcPisXgiE4YUjqzSdadskYt69Ae9qN9GRz1oTf0W4DIirSCm8OjLJgjr7e?=
 =?iso-8859-1?Q?nrloQ9no+ka0kq+++7OxjAvKc/cSk5HqUWO0yRE6ABwazrJFPJ3eHnk96U?=
 =?iso-8859-1?Q?fKbhzmoVTw6nlE8GJN+OHa176elDl9+x8Y8PVGNCBg42/pCN8NV11t3eG3?=
 =?iso-8859-1?Q?DvfkQdDo0V7VvOGiM2vFnw1JqC/HDVx5ayXOFejajHjgUAyPfd0y5rlRs5?=
 =?iso-8859-1?Q?xd+pWwmRTJ6jMkueew+t61mb9VgJBdONgrlnfxe3VivjN8LumfOfhmrOPd?=
 =?iso-8859-1?Q?frgwGnquLZdMpLjlRDNy+7D8Yv5AHpEgteCwpHrSMbUqkHOFBUnZKkDA2A?=
 =?iso-8859-1?Q?gr/zvS5uvjabTbIlqBoBh7cERROFzSpNtyBRk8Y9SSOwTvPJEnqiKCddP8?=
 =?iso-8859-1?Q?Dms/jyEgMh3X+UEATtjn6VsLF0boTn4giGqUffglQbiSp/jefPjPgcW19c?=
 =?iso-8859-1?Q?cvhEcHs95uqC4yz18wSN735gukBK9M59bY3ig58szT0+l7WCuk2pyV+UvM?=
 =?iso-8859-1?Q?PI9i6ltNrGI7TbZoc640WZIN/Jpw/3VwvRv3eZxuGFfaOCJusmECcz34Gm?=
 =?iso-8859-1?Q?c2vS6B8JrtsTA8j6/Kv9lfLl3vnx3Z0RCf1QdewhdAbCaf8ImuXgcPmNqV?=
 =?iso-8859-1?Q?1W+Z5u+CUUvXtYkKgpPcKbdye+kEqFf8TxJf3i/c3mHWNXsAMTtP/rtkEs?=
 =?iso-8859-1?Q?HpvaQlxUoapZn9sHMpjoo+1uJLpdWk8qV+jcsuH5RDbtWObGj6BnNUzELq?=
 =?iso-8859-1?Q?yUXyAptZQmOS+BfLBb6Kt15pXs41z61ZR5KQwOtyHSoEeFLAMLfh95/Dhv?=
 =?iso-8859-1?Q?eSIBbpQ4BZpvtluREdf0PFFfvV2f2ob6T6ewEG+QZwFnyudOaVYKgjtctd?=
 =?iso-8859-1?Q?nWJ8ekM4GBpZtLQzmO25NBGkF2i6I/DZ3wI/zjUoZMQx1UCRON0Ruk/bXc?=
 =?iso-8859-1?Q?sB9v4kSsgBKv3audb3icbTsZCxIN028vzYkaLfodqdi6fO0lSQUoVS52Fu?=
 =?iso-8859-1?Q?FQq4vhKQ8mjPnx9aJBd02Wn6GyW2sOjEqARHTid9d+6Sb93BO9D3+SqlNK?=
 =?iso-8859-1?Q?ytvp8ov6NjVEmAIKEJD5dVUUpDUtDMizQ3AdjZkJO9v2jABUjkosHSMQOp?=
 =?iso-8859-1?Q?TCN7iEL6uIW2wxAmZd6Ki/uCDh587O+udmKRafuO5RI4NC5pZYJoVWLDs+?=
 =?iso-8859-1?Q?5HaZ4amXrsgqyRJgID6BCl1NLSOTC65oVAl4lEyvAAj81ArSS+N6ZttOPP?=
 =?iso-8859-1?Q?CbPrzLCQ5TFS7tisM4CIN8tjy7mVPN2J094+W8u/hOrUR8OZn8GTVoUcl1?=
 =?iso-8859-1?Q?pasFgCaVzYJj5PG2dJOtAkDK5LllnCM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c042cb39-844b-452d-ddaf-08da2d6b775d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:14:06.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wQkpboWXLop6sf8FMC/mlKSQlr4GWgAL9ry3cCPSQyCRnOh48Xk24kpL3s+U60p0WebnAFRxGoGDYaZFOUXGkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2688
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205040006
X-Proofpoint-GUID: Jmcwu5beoskNrmGLARtBR3arhQGDCPS6
X-Proofpoint-ORIG-GUID: Jmcwu5beoskNrmGLARtBR3arhQGDCPS6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
