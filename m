Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5627577366
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233543AbiGQCvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiGQCt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47E6220F1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8OBc003742;
        Sun, 17 Jul 2022 02:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=gVKwu3mAF/BrzDydDYF3kwhOpwQY3z3J/rdlaKypkQE=;
 b=Me8kOB6AckNG+4AHibAMWOq6wfdtXEVN/SFiJpsJG4Joi3SFw/q1ehemIQbP79rwu/0Q
 IJVv7qrNFUigtb/Y19Etwbx9K5uBltnVy1stD3JE2fayeIXDZr5S41gmUPXD9f0UMINE
 Cs3u7ITq6+fQzi5g/o6ghqzGXX30uwMovlm0xsYcN6iMnXPuQwT54BXQKltN0LRpop5C
 JqTGIKtwgbYLiJ13NFqLfPj+xHwvoMkPFdt8C9NYybhN/FOoTsrhQQlE7TmSeGFf8GGY
 LWqLWmHkzGiTGwXTzSJdoN/p04GyqHkqSDp/iq+Qq17QVVAMWfXRtPLgWxp/0htUgGyK vg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs0x2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:34 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYIxt036125;
        Sun, 17 Jul 2022 02:47:33 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6au-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvXN3b2AmMEVVIpBEXp7010sZ8zSSDOzG5gB+EUTsIKp65JGshrJoa6TP0vOqqgEdjRWypzuE8x6SMyvy49Gf5gkGvob4vIiy8t8Jm7NEDK9FT3z4Ck9F7V/lhowdJEYCs2UVJ7OHKvjr0rRKIr6BjUUf8NieN/tzFX5YSRcba6FIqbDsUfNgwwRBBuO/yjA0P3cLMNSt/Y5ts54ZpUMmvC9zuTU/bbYtZJi9SNYbAY+WTFqIaIF8D+7BDUyd66oqXX4fVeRkHUVRiPIsnmchN0H7TO8O+pBm10L0rHWroFdyDFT2nN1XyXdOhUaVjMKQg8+Nt2879vAHOIjvRFOgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVKwu3mAF/BrzDydDYF3kwhOpwQY3z3J/rdlaKypkQE=;
 b=oCnia650DOV5lD8vi5BT+NEHguxBEMycIIlMgzowUiNyBn/YtwRzlhxY3EL9LMhP/xtpR1pF05F84cKYPeZkQ0NXvo3rUWbM3jROBqXrvwRcdCuEPDwXa+vMRscBiBpb6C2pXkeHYlPubZtHSAby1wub/Ji7sQrVMcJKer3xJ8LvwQ1vIkxsUZMy/+357QvQcbI/b5Y6BxwbXVQvknhYnNvCU5bu+B7CyQ7731Fn4rUaFjGe74FzEwJF4k49+wfLyW8EXG0PVFFhrHeG86bizpQuqfu04argdk5eplXxKrqSpBGKNfuzStH7Yzq4sJj3/ywzoiUWFmPa2VetKa5PzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVKwu3mAF/BrzDydDYF3kwhOpwQY3z3J/rdlaKypkQE=;
 b=TjUZyODf8IAEB54H8IZJzb2GffaYmz1mYw8xeUHJER9M6ZTAf4HgSRDM90RJUrKmdbB+7CAxxcceq52+GcFiGpp4JMlcikIgEVSyJ40Chw1sunMzqDexunq9KDicYGLhciAvV9NpUAsoQqqYoJMK5bBQzf6klZmjC0EMS6IhKoc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:47:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 53/69] mm/ksm: use vma iterators instead of vma linked
 list
Thread-Topic: [PATCH v11 53/69] mm/ksm: use vma iterators instead of vma
 linked list
Thread-Index: AQHYmYd5PG73IiVjkk+SAHrjt/8oZg==
Date:   Sun, 17 Jul 2022 02:46:54 +0000
Message-ID: <20220717024615.2106835-54-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 965d8c29-4c24-417b-efbe-08da679eb20b
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PIUCscPNtvnZTO/2GP2t4vvfZm30lNUVGuCf1qeYwg9urjzWYkRvhSzkcprJ1f8bc5YbhKRBOXAmNhsWxtRYDjjvhliCGM+m6v1hhSuL8uO0v8hiOTq0gvT4gd+H+bgVBuW/rZiFXODCjMYNu8vXAK62uTEHfacXviwt0sJ46X+W1VQL7W9PlQFoZ3TC0LKW/IG4VIdxLq0+yowfP+2EJdwBaGZmFVx/nVRgju4j7gBubFJ+21Dw6muV/uZs5OVX6bKP4ACpZ5UTSMzfIjisc46nEI+YrWVv+mI41MYcBtQafIb2COc+1to8I0ybVKN4SGx8snrDPpPY1wzB/sK5GAD+Qgjt3ai5+Qy1NI6bHUKQ8iWab3dAwSKYxQZVUScP2IwcluDj7WwKBHC281ea3vHNdJPlBii0iEPeZHLyMNll3jWPCQAaILfjGgunDMFSOYt9ilKOYV2yUFG0q4MUVnVAiyYBf7CsORAmVRaT1ZroEaE9tEqisyTZJeGez671OJ3s8+VhaI79kpta835C1iorhJOYurZ2R0iSqJMbutCTBm1JfjRtvyMojLkBLzasP0Kg7XzaALIscomynCAxGR77ip4njXmJbKAPh5qdiEnl+A9wK1vc0xMK11vKQk00Bal/b413QBikXUlGmMRSFCS2tt+IIqLTgpdndldJ2UxSzNZHVJoxv199Mlpz9WtDu1J8oGACG7LwTfzWJnfC7k62XXVJDiFE/FuOAAtT/IMPEMu77gdnPwe1sa3/c8JgeCou+zGBjfOyLkYXGgBislSW4NsyNq1AGu41kqSPSwZmcSQjomV6orMNxG35Sy1c0bASBZxi41Z5s3LoEg8ElBodttETuFzCBk3ytbqRUgtHKCnQykmea59VOguy/+Nu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iowQmyGzuCYtBesz1ctA9WBEqesh/wsUvAh+mn6IxBtDRKZ6wM0lxHIVt2?=
 =?iso-8859-1?Q?pevOeD+Vdk5HDfvmI3NmgKrzS4c5zfdAH1gU8vyTXEUljfKcgKVcO9W4l6?=
 =?iso-8859-1?Q?0x54S/YTNueawCrDJBkT5Sh5/O3UXzWG0MzQ5b4H4JNQGv+sagfdan7YSM?=
 =?iso-8859-1?Q?+CYbZpYoiHDYBH5KPJd+lwswf6rzmNckrAL4IkWDryyqv2sWGs7O84mLjB?=
 =?iso-8859-1?Q?2GbJqONuwxSlYrlmSLYmv3ZbaHA13ktOtKL/L9PbSHm0/b4LKM6+h31SJv?=
 =?iso-8859-1?Q?FXbsycuh3I/Aj9fMcsCzJLaIdnHscpj6jOYnM6DlAB1AGkwUBAH2I769Hv?=
 =?iso-8859-1?Q?D7CLXtdoBbBJ5DYjzM8EMciMxArMUvOHv+8W+vH73axYwqCOe9WveMjhUn?=
 =?iso-8859-1?Q?h7LjA4F40+aNMQt3rW4XMVdl9hIJ7jSulsdVxtYqDeDSSkWxllffzL9Brf?=
 =?iso-8859-1?Q?zm+EcoSzc5hPtoLOQLOwwN4KuEvhLxOgCbkm2opNLjqlCfnNK+M3vfck6F?=
 =?iso-8859-1?Q?kjg8BtDWi/zXPSilYV6x4TYdSCIDUikN2bIJLqAd+RLVD/jpiaN1Xihn9p?=
 =?iso-8859-1?Q?ZmXOeo62DLWsosu5bxF7hYTeczddpy4VNCbr0F5xe1JJZI+R2i2H/aTZLt?=
 =?iso-8859-1?Q?b1tcrnesmT1hWPtl5GgnuA2/F/MxOKoEzh0uzSUY/Nmy/Sqw9GcKbULjP3?=
 =?iso-8859-1?Q?EBsK5IxdJs9VMyKGCHG90jjIWADBr//vSf0o6LI3etaLx7LlaCnwe+cXuV?=
 =?iso-8859-1?Q?dmSVyf77EgVI//oyAKX8NkY9dCKi5fi9wnsDXx99P0mfV7KCVY+EEpHYha?=
 =?iso-8859-1?Q?23rHpI6leHEv6tdHuZjT9lx2lFvz60UeTiOUb+Xhrjzi3iIXgyll5CTdHi?=
 =?iso-8859-1?Q?fKf+gN1k+Y/7+jKbZrcisABpVVBqXA37UT9hFttVSi0U11G5uR2v+UEm1X?=
 =?iso-8859-1?Q?ycee6x/4sznrYqDNKc9phCfSoTe6WKMGm1NKwwlMTjffVaLTu/4Y6NwOJK?=
 =?iso-8859-1?Q?DBEVh9BaJtofx67deh+3aQAogoVpRKUaVALI5k7ORwNl/rZhDfFGCgDWIP?=
 =?iso-8859-1?Q?1fC83+ntVHfCkXbgBJeNyb/+yGje1xiWMaV33sTUYZkak3WQAg5jvZ6+zW?=
 =?iso-8859-1?Q?JEx75jk12mIgyfGfuHVhy9ZBM9lsxR4tXTgn/9pOXfoEHRiYQpMa45lmm2?=
 =?iso-8859-1?Q?KGJ4EPwMdh1n5QNfLBjUa+jHC8qJBsRpD1tc+Q3FU1OsVy2xXucWabMlsV?=
 =?iso-8859-1?Q?yPCbI/WO2XDBAXptE4aaYefOxmkeAe9gfiFCigO9esbghMzeqBxYZBLR00?=
 =?iso-8859-1?Q?JXvJcKJfBG+aev7w252a0aUCjgXFm/sVnsNQTpOyguMn1zFPcvKotu92/m?=
 =?iso-8859-1?Q?jgw9PaWjaiNhBe+Plr5Hp6KEsiGrpuZ/Gbk42cbb3fpA6tymxkvvPjfgQX?=
 =?iso-8859-1?Q?N/sKT/RAGKjlpYP7vd94NFDZW66Gu0eKTkvC9uI+7FoMImzuM0cL20yjxG?=
 =?iso-8859-1?Q?xOcoVYm9iML6ZWGbl//UrQ28jn9xAeg+IpI18gmEOvCrf2iqFvmY8PplcH?=
 =?iso-8859-1?Q?zrIxg7pFKXLlHrSBLPghNXW+wogJlhP9+Lcpt5xijd8yMlKQ6OAx7qkfXg?=
 =?iso-8859-1?Q?BSNDm/2TC7jfz+d//UrohPWTvaPEPhWDlKXfD8mfVcAtJGoNSLpnPqow?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 965d8c29-4c24-417b-efbe-08da679eb20b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:54.6148
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j4csmMDRTZROCAlbNk1XbQJkIxQpCKDzklguREDcDVmIfzK2UOqLFvuCX66SAvnnbCRM/BxAegyXHVObk2E8kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: exe3-WHjwjvkvCquhLOmDp-1uFeIRikD
X-Proofpoint-ORIG-GUID: exe3-WHjwjvkvCquhLOmDp-1uFeIRikD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Remove the use of the linked list for eventual removal.

Link: https://lkml.kernel.org/r/20220504011345.662299-38-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-54-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/ksm.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 54f78c9eecae..4e3d794f6b09 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -981,11 +981,13 @@ static int unmerge_and_remove_all_rmap_items(void)
 						struct mm_slot, mm_list);
 	spin_unlock(&ksm_mmlist_lock);
=20
-	for (mm_slot =3D ksm_scan.mm_slot;
-			mm_slot !=3D &ksm_mm_head; mm_slot =3D ksm_scan.mm_slot) {
+	for (mm_slot =3D ksm_scan.mm_slot; mm_slot !=3D &ksm_mm_head;
+	     mm_slot =3D ksm_scan.mm_slot) {
+		VMA_ITERATOR(vmi, mm_slot->mm, 0);
+
 		mm =3D mm_slot->mm;
 		mmap_read_lock(mm);
-		for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+		for_each_vma(vmi, vma) {
 			if (ksm_test_exit(mm))
 				break;
 			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
@@ -2232,6 +2234,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	struct mm_slot *slot;
 	struct vm_area_struct *vma;
 	struct rmap_item *rmap_item;
+	struct vma_iterator vmi;
 	int nid;
=20
 	if (list_empty(&ksm_mm_head.mm_list))
@@ -2290,13 +2293,13 @@ static struct rmap_item *scan_get_next_rmap_item(st=
ruct page **page)
 	}
=20
 	mm =3D slot->mm;
+	vma_iter_init(&vmi, mm, ksm_scan.address);
+
 	mmap_read_lock(mm);
 	if (ksm_test_exit(mm))
-		vma =3D NULL;
-	else
-		vma =3D find_vma(mm, ksm_scan.address);
+		goto no_vmas;
=20
-	for (; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!(vma->vm_flags & VM_MERGEABLE))
 			continue;
 		if (ksm_scan.address < vma->vm_start)
@@ -2334,6 +2337,7 @@ static struct rmap_item *scan_get_next_rmap_item(stru=
ct page **page)
 	}
=20
 	if (ksm_test_exit(mm)) {
+no_vmas:
 		ksm_scan.address =3D 0;
 		ksm_scan.rmap_list =3D &slot->rmap_list;
 	}
--=20
2.35.1
