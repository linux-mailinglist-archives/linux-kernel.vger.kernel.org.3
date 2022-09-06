Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6185AF4CB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiIFTu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIFTti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:38 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3421154
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:23 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdAfJ020044;
        Tue, 6 Sep 2022 19:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=8KP67ZGokpyV67iVM/3UgdeQWWwKE8hk4jRPoCG+JZA=;
 b=jPhyDhwsYepzAAU+JpvRf54GWTOv4U5utj5RhdLZFd2+bjn5IjQRO5bvvBWnKUv7UCeI
 R4RhPVup6/RETEBZNUcO14o5E6dvIt+JQE9xF9x9eg91ieeagt5jFVv6y4uQ8R6P6kpe
 mVf5V4yESbApUFZ3n6doH0Xu0QASTa+AOR29FBu5sf1111ODxMly8lKpOEPnlxil1x1d
 Q9YHcitQFjSMFSEgHD0PM63FUjXGRVKBVS61paQT1ODwryyLZd3L92/+XwoCskXRZoKB
 FvJWI6ohx6uXT9LFmW2VVMOU9jTn0Mh2UtvvCohDxpH3MCXpXfjJJls/i5h02iQyu+IX Qw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbwh1exk5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:56 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286H8KXP023727;
        Tue, 6 Sep 2022 19:48:55 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kr9w-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:48:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTZkmGu9MMWsYBZkrpVjXKJbYEMilxijSGWURgfm1TEwnn/A6toUU0jgJ4x+y1L7lnRGUBtpjijqCPMi7Q+5lEXHzMpoLZQOlWmd3pCp2rCW00Wk+X7NHGbYeoyDlicv9A2VLn53qJzKS8G5kbALUCBaD2vQSoHyQkIi7PsD7labXP8qx5VRb2cPuvUX9stxvzTliC25CeY5hLtx3OATKTmblaGcR0QIm8UIGfDSodgf5hwquISz2oevifSAMyzNjoEtfEIsr+rlEvEy3Bqd0K5X3Y3AWhzyYOnDt/jIzSYkcK6MiP/cGome4kqoYlTfGJJSin4YkXUIg8vi5ybl5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KP67ZGokpyV67iVM/3UgdeQWWwKE8hk4jRPoCG+JZA=;
 b=UsdRXeEFmfOJ7+2rj6k8ljbQaVMQZTNeQ653VpyjgQ1EEGFPcxNwRLzCe+d1j5d5ojcSHcvAYZOJpnPltxmTGwFi1wTcz4kmjrMR8uJIjYY9SvKH2LYgux+43fT3ug3ySxJn/lbutCcldnZg3511xL80ngbup6oFJAafiSlyNmon9lkth4YylZEhYHIpAG5Ar9c4Id0tzICnWlzX6sM4ang1jmepDjgyTYZCJEWs9x6ptkklyz57BELsJT2wjgIrR9DxnZmRhCKZLNxf/BXESdqc9xD/pvcpO/484f1PpQ4GcIoEZauennXu9TBDet2BMqn4pkOhjIQJ3+Hu17Ao+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KP67ZGokpyV67iVM/3UgdeQWWwKE8hk4jRPoCG+JZA=;
 b=I9TkkbcZC4Dthvh8PnNwd7qRBLHF9bY8DOBpyxgKt7xq8MC8+rl77mp/axC3VU+dM0rAHaaTlZdGHwke6QFIpVIJbgHSFGsR11yf+kSrXa7pG/XCTHDPLjPakPsgx6KbYvW3LSDL4WKNfqeHAE5q2uVGoCLzURWd2/pKjr4kDSA=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6183.namprd10.prod.outlook.com (2603:10b6:8:8b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:53 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 14/70] kernel/fork: use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v14 14/70] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYwimuAkXXFCtnHUWF8xTpawvWmA==
Date:   Tue, 6 Sep 2022 19:48:47 +0000
Message-ID: <20220906194824.2110408-15-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e1dd136-0030-465b-e9e3-08da9040d41b
x-ms-traffictypediagnostic: DM4PR10MB6183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7yG+8jZV6LWkavVowUAgJr4VR6lVXbTtaHrEDbzEo2Vm2FPpRUvw7gv4ErBwFq9f4e57zpi7q5VPM0Oh+WaVcyeXTiM46i67u0mCTq95K2vZX+25j1aT4Zv+sDzDaVTVEkapNMXOhTAv4OyeCy1xiNn8aFBvLz6B1sRa/m+3hEqdXCrQaivFLxLChlGwVowGiWlfI0K3GkkyBXWuhfpORtZISJKGPH1pnsFUyyp++PkZSMiDtDyMpbcniaaDInBKXLr3LmdknViAEWfc4r3uykXLlsHf7+b1pnXcsFqiqyTQi6K8bdOZdO4t1yXhODzvdTdaGxQgGddJ8GcMPHdxCis3thu64vd7JPO4KA56Tm8eOg1Ku6tbIWLCV7GIy1NbXuX4FSBdNJBFs+rDms8wi8LvHwICTogy4EGrrVl1dCcpUljP8O13Mr4kj1DUhxvD04M2cm6rvYRjnJDnkcLWZpJ2WEDBpoeoRsT3oHEQltXaZQz9i1nUxWW1D6Cve7Dck2RyKcS7sAlbuDeKdTl9DvbjQtwsG0MCmYs1SHiPOvBmK31/Vlwj/arzVBxVXAwNV9Hv82euptilS1FcnzqaEbknMWMgWIOPNkudfKLBtdG2auCQSKG9WQCJt25807BEyhVhM9g6RIyasqxH7yr6ZDJ6a/OdW3QsdLMKkBBPNaS5GeGRW7f2ENyrSrkdF91y0l8JCc8GT4pAHUpLrV/dL+sT/f+2Dz8Dmfv0EhUhM7Wu4b21FxBxcmTTiB0CjAbTigS77rLYVStTtd0pz+0Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(396003)(346002)(136003)(66556008)(38100700002)(122000001)(8936002)(5660300002)(76116006)(66946007)(66446008)(66476007)(2906002)(83380400001)(8676002)(91956017)(36756003)(2616005)(186003)(86362001)(1076003)(110136005)(44832011)(71200400001)(6666004)(38070700005)(54906003)(26005)(64756008)(41300700001)(6506007)(6512007)(6486002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YZAjZLF2QNxrf0ZsSJ9QKwM0GJeElG7fJtCqZ/K6pMpPYSAS1D3U7BnT7B?=
 =?iso-8859-1?Q?sAdCik/mNapoJeR1NX8uaAb4fcqN8Op2jVKyO4A92dwK4DAZwe8TMixMyn?=
 =?iso-8859-1?Q?r716oWkOnLmSoSSmpdvaMTiU7snq3uHDDAqSiSppJ3lkQ4nKYzgcgmBv9r?=
 =?iso-8859-1?Q?Rz68LaCwpa2PGafr4kr8SMLfYUZozQhBJTf6VyM3kTo1lAlF5O2pBjTF8M?=
 =?iso-8859-1?Q?E8b1NUP7CiB+KilQsHh4YwpobBNSOIk+G5+Q1wYGpMCLoI2/Q6b3dnHVnq?=
 =?iso-8859-1?Q?ca8X4vKK833CEsjX3dAxIBbkZjskVB1eGu12aLT8oN0GCTd24CeENHFU8j?=
 =?iso-8859-1?Q?JXMhvIp33wAMEbSsFYOCujyysCU33K6qIH8V5W3TO5U7XwmOUk/rc2tQFH?=
 =?iso-8859-1?Q?zJG++ojBfSqTi+FowN26yFLe3RdDXonlOTcD7wJwvxwyoXhPfLV+ZyPv2H?=
 =?iso-8859-1?Q?ZhZnev/7FsFnWK1DbZskkR+2MktpoaNeX5ddDMLrOabQy99Q3N1H9rVdmX?=
 =?iso-8859-1?Q?Akb9dFSMUx2KeM46pXjmfwiJvlz+2ne40iej2gmxwHUjEdRsMSzMoqPjhD?=
 =?iso-8859-1?Q?8+PUryD6U75vEMoFwTVNc6Ox7acjs+0nkKfYI9f5allargjrILergJfYTy?=
 =?iso-8859-1?Q?z9JldzA1MPf+puc9fkbypwLmMpMOTVpCqURzH1OOwip6uPttqZYJzqHiCg?=
 =?iso-8859-1?Q?WjvKY8W2F//r2tAUehL+9LHYTy2yjsP6SLAoN7TOS1yXdwYxfJ7bOLoBsb?=
 =?iso-8859-1?Q?2jEsaCeB5YBQHI56HKYMkoDEuBx8PCIg4l6kr937rcvOHufeUGk2OK3VmS?=
 =?iso-8859-1?Q?n29nxUl+iy3Le0OYdg5sB8zSjnk8YcJkJooePL+cMHfEvW0hbMBkutYq0M?=
 =?iso-8859-1?Q?tAhezgbpdVp7XW2kZLcbClZM2EAPXr0seCNux/PIIe+Vd3BFuODCjei0uN?=
 =?iso-8859-1?Q?tYjk0MfB4BWw3cZtYsY0n9pfV6n2BnRx3VtZhCRZqg0IDtx+zLH9ie/xDs?=
 =?iso-8859-1?Q?Gig1tVAJHK1544Cga5nafb7aL57VWDbfXvqLb7ciMk9vWdc7CiiBy9Uzg3?=
 =?iso-8859-1?Q?rLK+S/mITqICJsPVUkpnPnyXR6lPqUHQM+SyJzvlDw84ovtB7qg+pRXi6z?=
 =?iso-8859-1?Q?/xtT4JBFDzr5DhT2zPIhuOss/6W8rwyKMJh9SyhHwctj0Vk/1wPzV2Lwws?=
 =?iso-8859-1?Q?D96BycdpSpS6YC+/PGkaOKoet1SX6+OHP54yGlNmjW2pRe7v7/5WkinMsD?=
 =?iso-8859-1?Q?ewUHtltRG9JP7IDWt1+wcqygqFwh5rSzEGic01jSF2o2G6e4jWwGfi4MUz?=
 =?iso-8859-1?Q?siI27KoQOD3hngMKltkTYFBlYYoxbr4JSxYL8IoEQI4C5whhlcE4VhmkuW?=
 =?iso-8859-1?Q?sRrbSEPUXEJa0ryuSAJwYGYwMj0+YIoQRqgrwHb9VvVdRDbaHroFvPiFPY?=
 =?iso-8859-1?Q?NqgW/Y7gleJ2UO6oawhk81OGNJwqEZpArTnHERhYsIT1rrD086l9IaUzsM?=
 =?iso-8859-1?Q?GNanDDSCVMASXGOpCjfigR6hlpFE6+TtfPI2XxflAs1kr8ETIQFJK7o9Qe?=
 =?iso-8859-1?Q?E/KtgZ5awwIdSxtrGUuxINo9NrQuEILYroBQhSRVwCwrL/kuDUIwWSWP8j?=
 =?iso-8859-1?Q?/nwbu1cnLjvronwIJkrp+odpgZoL0z97C9R2WB+EWYuuIONrbJFx3pIQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1dd136-0030-465b-e9e3-08da9040d41b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:47.9287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G7g+InrP89VJXrHW2x1thlxP2NVbAZVWREOR8KtLB5NY9HaM6ZSPcsuk3pqK2I64GxtenuX0zI5RmU4COUmohA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: 7Ri1idEE8N1wtKiScIX9wmsTz8RtN-1E
X-Proofpoint-ORIG-GUID: 7Ri1idEE8N1wtKiScIX9wmsTz8RtN-1E
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

The maple tree was already tracking VMAs in this function by an earlier
commit, but the rbtree iterator was being used to iterate the list.
Change the iterator to use a maple tree native iterator and switch to the
maple tree advanced API to avoid multiple walks of the tree during insert
operations.  Unexport the now-unused vma_store() function.

For performance reasons we bulk allocate the maple tree nodes.  The node
calculations are done internally to the tree and use the VMA count and
assume the worst-case node requirements.  The VM_DONT_COPY flag does not
allow for the most efficient copy method of the tree and so a bulk loading
algorithm is used.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 15 +++++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a458e5f73fee..fef2cbdb44bb 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2603,8 +2603,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index 273364207f17..16970c346b5b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -583,8 +583,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 	struct vm_area_struct *mpnt, *tmp, *prev, **pprev;
 	struct rb_node **rb_link, *rb_parent;
 	int retval;
-	unsigned long charge;
+	unsigned long charge =3D 0;
 	LIST_HEAD(uf);
+	MA_STATE(old_mas, &oldmm->mm_mt, 0, 0);
 	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	uprobe_start_dup_mmap();
@@ -620,7 +621,12 @@ static __latent_entropy int dup_mmap(struct mm_struct =
*mm,
 		goto out;
=20
 	prev =3D NULL;
-	for (mpnt =3D oldmm->mmap; mpnt; mpnt =3D mpnt->vm_next) {
+
+	retval =3D mas_expected_entries(&mas, oldmm->map_count);
+	if (retval)
+		goto out;
+
+	mas_for_each(&old_mas, mpnt, ULONG_MAX) {
 		struct file *file;
=20
 		if (mpnt->vm_flags & VM_DONTCOPY) {
@@ -703,6 +709,8 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 		mas.index =3D tmp->vm_start;
 		mas.last =3D tmp->vm_end - 1;
 		mas_store(&mas, tmp);
+		if (mas_is_err(&mas))
+			goto fail_nomem_mas_store;
=20
 		mm->map_count++;
 		if (!(tmp->vm_flags & VM_WIPEONFORK))
@@ -726,6 +734,9 @@ static __latent_entropy int dup_mmap(struct mm_struct *=
mm,
 fail_uprobe_end:
 	uprobe_end_dup_mmap();
 	return retval;
+
+fail_nomem_mas_store:
+	unlink_anon_vmas(tmp);
 fail_nomem_anon_vma_fork:
 	mpol_put(vma_policy(tmp));
 fail_nomem_policy:
--=20
2.35.1
