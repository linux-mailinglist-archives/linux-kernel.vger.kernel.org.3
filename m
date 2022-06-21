Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30A4553C06
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354975AbiFUUwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354645AbiFUUta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:49:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3871570B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:43 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJDHs2011633;
        Tue, 21 Jun 2022 20:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=AgvsydRR0J+aa5bO2cXOZA66nIGZpt3KfkHHoHrnf+Q=;
 b=fmMB6NSUjpnNM7i6B7m2eP2GGUy20VrlTTtb10ncap0D8tcV9KVXDHeSzFPjWZQ3icED
 P7l7GWiUt82QC4NLHNpv30cb97RHRWfzpIcnPntPQFVMidw1j0+qcVOls/6xq8pdOrEN
 RZkHE6ZOqEMJDImMhk/Kz/2P5RY6gIEXQ6dnqdkAgVl7GMwpdrJxTWyrCrwt7V6Erseg
 VG9UgO6bIffbtwUW/9woQnaNJ8BYZ778jOxCiOssSgdhEFz5XBil6A2SUkKJS095Gk68
 LY9lNRdf7IkADaM31saw18Ymobx3tVdZAckYvIjECfRn/6DLo5olGLxxOH9w0i2GaA9Z NA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:33 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdwkP010169;
        Tue, 21 Jun 2022 20:48:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvv7n-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ar5VZIqpFtY54jOBEVK1nbF3hKhF8DKVrHkJJkrTWMg6H9SYlefx0NzX2kB/ldTAyoGmYbPKTKCLQQBATjjBFK6lxBPRWA9p3cmvfe4mIyF/hYdz/EtLjRjII6BwOK9E1oYVsIi7uVmRs6qe0EV5c47mY89hrCUOtn5AO8DeuzJV6d4/8yRVDlOE39gHia/E27MjYy+jbcw6SWzPss+X170XJWLKyoAUY71in4kyDVmYmC777k77QsZHbUVB0YsKhvJ3WXo2QXuUjxSLaA25pbxzVal7wOdyW1qvav7Y7gady37paaRrx0kMK7wh81SAv78dMUAkb9n2QYdFFJP7qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgvsydRR0J+aa5bO2cXOZA66nIGZpt3KfkHHoHrnf+Q=;
 b=mcQezSpVEuzCF3sOyVi4e8nfOnujCiyXxTtdCkqW4sVjWJDB/ebKIxrfKnZwmHt435ksJmvQtjEM1k9DhJcNi5R3NwYaV0AXtYzv0YIEBSelQTuocYEPws7GoKuAvULGV9J2kax4CvoC1t6aE9SwsHPVqUk5Ynzy9ogGm0rJbGi0uJF9dng6pkQM1FJ60Gh95dGK4WevHYcmhRw6xUmKNKgiQc3ENbM5w+Ak1f57PZ8MbENokxN24XPAPXSSaYDWvkJyscgxlyCBjV3ETyRPa4p4JX28BzADHrWm0Z5QrpNQD6/880CHWDQHVhhb/v0K1PTAkS0hSZF5QmSJs91YsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgvsydRR0J+aa5bO2cXOZA66nIGZpt3KfkHHoHrnf+Q=;
 b=Ml//LC/sLztFau9D68ETgrmAs6799PR1mTasWmZU852QSWMWa/j6qLP5C9sL+YxYBOw6bKm2deNKJK+ypZeGpap0wBCoEqFwFz/PKUsDTPEiezzm6jUz/jPp0jEpvzDrQ2vdysh5OwOzikn1pznxpeRBFaLS9PNIiXlgsP2WaFo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3869.namprd10.prod.outlook.com (2603:10b6:208:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 20:48:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:48:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 64/69] i915: use the VMA iterator
Thread-Topic: [PATCH v10 64/69] i915: use the VMA iterator
Thread-Index: AQHYhbAVkMuEfElzf0CM1Hfds6pmIg==
Date:   Tue, 21 Jun 2022 20:47:13 +0000
Message-ID: <20220621204632.3370049-65-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9c89f02-c5ba-4213-30ce-08da53c76565
x-ms-traffictypediagnostic: MN2PR10MB3869:EE_
x-microsoft-antispam-prvs: <MN2PR10MB38693CAB6FBF33109E0E1D07FDB39@MN2PR10MB3869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uML6dY9Zg815GInc41DLg2Afr7bM31YuBYl/l27RN/dIl/RZN/wQCi7/LgIjT07mWf9mdNJOwWujQP8hdGONoO3u5TEQfzO5mkoXGXOtZbuJiBilkd0IOMXyxJkENqD4BtdJwLCPAtC1oj5ULx/kVWtUJkRhfQrGycfY9rnnEOPVGbWNSiUb6Fkyd4PtnJfZjsE9yGAK73Y+5h96p3yLa3fg68VINBHJqJkQQhDvCr0GQu+/kG50tr4osQMg6pqxDqegcMIPX5nVPS/DH5vZFAR00+C3ZjctKf1vt1GHvIM7U91X/sK0k9ZsauD29XejbIzP/kXkaTRz/KA7TkIbLGe0OcgONOPVLCWT/Upzs+RpoX1ihZMYR9G+UnTrsCS1qaBF+O/YK+oUMy/fa9CrTqX1PmPdj3HzOsiF2w21ET0mWAavPfinojQPB1tVyRWFTX/nvma8Y9/o7EQjZKmWHR3KdndKX9s/SM9kUZj48QsWJgVpoFyXhvdQpQExGhQki9B/hK1vovw+WAi3ETRS2dCNEKW959eFeC0tSLUjEqBHy7OGc168XCRCC6ycgNM0cZHmcj6KVCHD6+c+euCvqTq9JaXTiBVnqsnuNdJGaPunqo8Wlp514mXWyWCp90mB+MjYsVDzA4cnj7ntSTPbLeClumQ8D2ZHa5IdgVEX14KKqMysZY2uwehrughRkZxXI4rT3d1XcO1G4S6GJE6gVSBcVPDdHEjUuR42+mjcZJjDTz+VeznBn7KsSNf3QTO33ZhFysObgCCaNAnxx3N0Y1E8PW1/R30GahuPjkukMM0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(26005)(6666004)(2616005)(966005)(91956017)(6512007)(6506007)(186003)(41300700001)(1076003)(122000001)(83380400001)(38100700002)(44832011)(86362001)(8676002)(66556008)(66476007)(38070700005)(5660300002)(316002)(2906002)(110136005)(66946007)(71200400001)(66446008)(6486002)(36756003)(478600001)(8936002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NpYfbTxC191KEAh0n/0LEVYxfRflBi6o9fNZumPqHxWvc7E7RbfaqaXt6K?=
 =?iso-8859-1?Q?8urs9cBjiIzB4Rl7xeyAW3nRtCwrWAx6vz2FSd5RuDdPBR+pT9qHCZYLq9?=
 =?iso-8859-1?Q?VWDWcnm//FTB0F/KUPa5auNnF4auxOjdTgXpFce3kEVNRCOrY1YRaDpaQw?=
 =?iso-8859-1?Q?4G9V+UZmYZcIwAl/+6Hnqvsv/eeNAyjbQTQviwmPI/Sd7Nv2PmDSo72R1N?=
 =?iso-8859-1?Q?DcWSQENOeyreov/pOsGIpHYVVQpzx5gVDIsPFI9RNTa8/vJnT1KENKVuqu?=
 =?iso-8859-1?Q?cdTqrLWVOsUJYGyJW7akUmGXegi/NCbyTrz9FDVxcNPEXgn1JGhdyUGhOj?=
 =?iso-8859-1?Q?32+SgA2fvVbZTFo0VfFsJfFHNSINE7LbJBhDhALfip1HunMTJFb98dPnGQ?=
 =?iso-8859-1?Q?F3vBB0/K9cc4g7d3YjRMAWWKT8nc7NE7kzyjitO0tJ8dkjjNW9Vfj0BWPY?=
 =?iso-8859-1?Q?zrM87T08A3rr4HeEIaykCW9Cmh0GMejC3YVs8pR7I1sNyNMQw4K4QsuZGr?=
 =?iso-8859-1?Q?FDpkXRmJI6fl7uxdFA7WJr6Hm9hprTJtGt8d2JKbL3iqeb43FseqqyBB0M?=
 =?iso-8859-1?Q?hgLI222XyvuM0CE8SjBb1IlRGe8wIfMZjj7189loG9w69QbIndz6S/T4WH?=
 =?iso-8859-1?Q?mv0I3W9XJrndFuBD2oFAwkTnQf5YGtvEuXQTRs4ugVANsAcarL9BGXai3x?=
 =?iso-8859-1?Q?JbuHnGkF0CxymoLAyn7mGEfBcs8BHtBXl1HWnLUTml49LNPD1nvpALyEqx?=
 =?iso-8859-1?Q?znRu6NYTqgCFTZsRxipuDreJCxHVmmTy+aWcOf3UsLfEpPPIZXqYZEMSJe?=
 =?iso-8859-1?Q?ws/CayX/3YY+/iIMAL0JjsjtOplOkfHVb+s9aGow5UT0Sg4PXPy4Jqm1FN?=
 =?iso-8859-1?Q?S63OxT2R11WnWJX9E0kyZ8iAt5gzyQOrwkMxDixQ0pmXcMzYUFM7bcsL8j?=
 =?iso-8859-1?Q?HVoFCBBDfguY1obiMv+t9zNKzyy7b8fVQd+GibQ8nbI/CglFRXcgiKO6wv?=
 =?iso-8859-1?Q?Z3RhAW8D3pQrE1ZfRNICFpFFIVXojzDMZSLZ2Rf2C46zuGIVLchUyfv3y8?=
 =?iso-8859-1?Q?ueiDVWAc4Xqfla9X5U3Ustnyl8WSSupJ4tGM1esKxGt921651fBLPDtE5+?=
 =?iso-8859-1?Q?fwAUVYdS4Qj11TfFFQXOOiKlVvlGCHf7Aif7DgyVBA85ju7uQvrEOk+TiN?=
 =?iso-8859-1?Q?b0tYNXUyC8hQpoIncHZNAvGPAp5ZMmbTibu+kkkO5afmtInNMkvnqpFC7K?=
 =?iso-8859-1?Q?CrdF5eSL78tTkTvbNzXaHxeke89Zt6N6IkNBFjBFXibzLDzP0+q8ef8vIy?=
 =?iso-8859-1?Q?g3vYep6JppS2ygScfIWqj1lXTrqPK/my/dLUDGcutvkyIWMokxVRvJYQtR?=
 =?iso-8859-1?Q?RR3EEfgrexMszZVNV578B0YTAGg+Fhvc7m32AQ1pKW1S0rvdPM5hSSqGCL?=
 =?iso-8859-1?Q?TvsZTxFCOidqMRPXKlLEikVQ+cyBNY6QH5pbcm430YBLzbp25s+V3wSKQp?=
 =?iso-8859-1?Q?+ZFNrANp06kT+3eMoYGgEHccEXeCkHoB/41ksRwnOtrl2T+OSnloCjYcpx?=
 =?iso-8859-1?Q?kRSmGg0NFuX+VAt+OjtViYAYK6LPCKWab7kix3wbuIM1LQ1CAohoXPqulw?=
 =?iso-8859-1?Q?6xsSBR4Nml5pOJSoVnIcb0YfaSCxeChzuX4ullOhaPxO4SDdo/33peFjq9?=
 =?iso-8859-1?Q?+m37Rz5dzIU2dTfJySC9XxRTGuTcsWfRu4ie6qn69vXX/f7mvMbO9Sd3vX?=
 =?iso-8859-1?Q?nGncLW4JvpSa4LesuGOOCmnspiajZfVw4JFQrfXCb92KSuUjLc7cdWsnKm?=
 =?iso-8859-1?Q?ZjU1PGiWofStOs5Yo0q+HHgMsF091Ss=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9c89f02-c5ba-4213-30ce-08da53c76565
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:13.3156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: //XYYzPccR7HZ/Ap7mIYbHlubtrfT6N/Zh+TPUKCrEAFquGIg3m8wseW6BvBYjfMtDTMXIofi53QZFFNXBv6Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: 4zhq8A4z77VHiQZDS0Unx3FRsJ52ZOAZ
X-Proofpoint-GUID: 4zhq8A4z77VHiQZDS0Unx3FRsJ52ZOAZ
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

Link: https://lkml.kernel.org/r/20220504011345.662299-49-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/=
i915/gem/i915_gem_userptr.c
index 094f06b4ce33..a509f7da104b 100644
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
