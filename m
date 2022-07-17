Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC1EC577353
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbiGQCts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233251AbiGQCtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:02 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032C1E3D1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:33 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMOljD026163;
        Sun, 17 Jul 2022 02:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=CnNADhKjYBH1MFV5klbefHTM86YPP7N4zYExGYQsyRw=;
 b=co+4EbGYrFl+yf1pH/k3XFa+bST9oPDOMSEPD5CT4KwGVRATbeyxBB3pwD5B7T2oZCfG
 nLVnMVzvf386OwL/K8aCvEgfQO1W32ijKdljQwJZ4HVhVmC2PHwFdyLF1JQ/SacxyxaO
 Z5FIyCwNfJs5scjrT91yRlDchnBSUu1Hm1n78M3wtr5Xr+quoBi2j6K2/c3XsBgFrrC4
 bW/Fl+PwmgGJOLUuZx2e/IvRvnDocK6s/0peuiGQ/cQQYHZ/eAWcOh3bRnXF9Vk5RR62
 Ta0lVTisirZuAoHbWxajA627r0xqQomycKyM5dbXT1wrSvcaBy5REUWCXGut8M8XsDvA Hw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a0y1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:27 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISF036113;
        Sun, 17 Jul 2022 02:47:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RhLmtI7nfEsksq0/hIZCXjAnO1xETIWeqUf0JuAUGOZZsODL/d7EmmqVMBMr8KGgHrfAIL+vn5nUVyHIfTUdwxRNDChC9j4uwEe5wewUvDjY49en87zH8K/MPzTicLWymP8rT5FYxiXwnsVGZsRJQNfASTfzbkGaTAlN4SsJEf53UK6yhAneS8E2DJ71/jx/1d0KsCal4Qq87Y3S8zCe4Ert3dWtxkPG9SZYzV5sZinac7fCut15EksMXLEBRcjMxoIgaDOLicHKlToarYJ8iBs7ZM/vOMEz04FR2g8Fqx/e64G1hyttoUnIdJOWLkR83dWB36IsfdVs80H8Ft/UTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CnNADhKjYBH1MFV5klbefHTM86YPP7N4zYExGYQsyRw=;
 b=jUisFt4Mfz3pl+vk6xmHaP1jVb2jota2T+YJ9h25uj8LCGQ/GLlrx2NSdXV8Cn+4NpPq0+GZHmim9ULaHPpmMUiDFSUMFvJadz69bhXenycUJkDwuJA7N4G0326t65ltvcjKQkxotirhMJzPS+42jqKOOocdtoErQ9ct8o+5STiJpFYZnIcaEopVootoah4kfxTyPHxG7PvWMyvR5exnLcOPrVj9JBDK+9sRsyYB9B5oFiP0mwcr5n94OzjclWTlPi5R4IIl2bfwgqWnkieqErm327vx6bYi+aOkBkaKjs+m3ny89UrJrjDch4jIsYee+wuuLs3FlgG5ugjP2J357Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CnNADhKjYBH1MFV5klbefHTM86YPP7N4zYExGYQsyRw=;
 b=PrT71UbiFMRuuETW49FC/TGXBXLz+OUvNZpufZVK3b/t0j2n1QbMi0xHXm6X4ZrXanXIwK6pdvVs05PctMIB7wNpIBRqhiaqmT6g268VAkIPAjpEIeJxFdXADeOjPbE/QXQyLAB+nS8tkM41Z18FvaOZMpPv3t24QxagnYIf70E=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 33/69] powerpc: remove mmap linked list walks
Thread-Topic: [PATCH v11 33/69] powerpc: remove mmap linked list walks
Thread-Index: AQHYmYd1bD1BlHswgUOpOlje83oYDw==
Date:   Sun, 17 Jul 2022 02:46:48 +0000
Message-ID: <20220717024615.2106835-34-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72302601-d6ba-4216-6341-08da679ead5a
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DL1D6y7y+nTkw1iiHdEkyoOdkSL9Cu/2NpqGtU8G6+FROzCGYCUdZw/bWUtgI+nXmH8+EZt0I9sBfwtJ06yIrFJC41ng1+1+NPFQnynyLScy2qFWmntP+L7qDxmoan+BCNuj4xzM5xw3u1D8uLtxXmQCfLt/69seCwODfBKH97LE7oFy2sn7E0T4zFnLz7gz6stVtmw3b6NvXgQCv7NWJB7jUXIGEnzD/pDJXPYN+oEdER6LgiKOLeI05w6bwyl18p6EQgK9lr0JsJ3oaQkjWg8qTFyimxS8wYidgWoeU7Hj8Qgh6sDLJtsziyZQPYn/eTpo6KOilhPd+HfSs6ZTM0fgsZdCgVZPv1XqEcrR8T9RyiprW/r+nZ8As5+7oLBVEQsUl7RKXHteRLgiLe3xGtmJo7FaxBwO4cxpJUQnN/m7I7wwlKhToMuLBrEUAQUIlttVZ6VQUi8LnwNprMSSY05OtAabC7e4G7ESSagVozfFrhK79rcAJ68qmvu1+cgslOr4tVkTCCWWhS3p9POqqNzChwU1KZQ+uL7hA85sde+w1P17ACx0uAWCsYEvonAv/FwNudmciA2AI852wTN10E6N1ciFaP3HiiuwxAdtCXC9o+cKO9lqSEkLTdk7EVhaKRdLyLwUTKbLuIQIUd3bx6ofRwn705vaQ9woo6KWzSQvblbWfhgo0hKciGf2yL59XvnOAWEIBlwPLzMdfxzjQy3h0be/wN58HmOpR07j/vYgs9KOEYey5Ecch16iMdlppvgH5gIuAVvvBxOOzKMgKXTPJF460CMiv4Tk9LfwXmXt98Y5eXJm/xh4ISKo1/agMNKmFN8A4iG42pZ3e7iXKucQuhSE1QWGs4XPYHt5KMPKXjey4HmOCVmuKwBRhuNu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iahC+dVF5FJ6a94h15s0PPdXHdUYx4dN0axkdgrq1ufuv4Tf4uHnTU2T1S?=
 =?iso-8859-1?Q?SPXntNfzLd89f84AalKzVTOmNjuoSLXweLvE3p/sk6bo5CxUkzxei0xWj3?=
 =?iso-8859-1?Q?njvIldEGTkoBq/DXdtAuIP8c00O81h/ma1xyPulrb6cPErX5Ux2p8Mq558?=
 =?iso-8859-1?Q?Y/uBBgMIbY/rXYL0Y2+JGyh2p+qXRk+wi7s5HeQSWLQqwK/lgupgQpluaK?=
 =?iso-8859-1?Q?fnbfewrZ774caaXMoCdqhrXYUlz9enGNhAOk+vUDhxFppOBMHqdBkOKJfd?=
 =?iso-8859-1?Q?y0NSF0D6l/WdyUrBj5a1rKDy8MU6HSPrzjTS/kG3FFCOR9Z8J2jo4+26w9?=
 =?iso-8859-1?Q?N254s6dNO0/b567fi0M38D0viYAcu6Zs6q9REhZk0u/VQ8r/4NXrjbxfSy?=
 =?iso-8859-1?Q?xp7I4lPiD/NI7Xq2DcAcTcxFQIaH5IimpgX+ieSsIU1SFoYsg+u+25WNYP?=
 =?iso-8859-1?Q?mnif2oF9EuJU6YaHKcRUWAwI0adeLDzF5g2r63a1J4m+opy9ro6JqoQISO?=
 =?iso-8859-1?Q?vlzUOYnlMcUNsZVrIPrVchdOM92+FtXWhIj8dcAf7TrhF/yO4w8SwhJ+iF?=
 =?iso-8859-1?Q?/w8rBhdFhMXBHYGUyXQbm7nSexfjqfb9bxKP1VH0zmGWTGL2l93NN4NDOT?=
 =?iso-8859-1?Q?UDU1XIKJ45PxNoo7/RrWwCOvh/Mpd83sAYGrA6ZdSTK0jEkiCIhmTxoq1y?=
 =?iso-8859-1?Q?fS1dK+WyodhR5oKmzuDOSkx+5xLApbu6WnrCNws6Pi8GhuT9W+SYlzHz29?=
 =?iso-8859-1?Q?DMiqQXiks5k4NU3zLfRiPvQRN8ub4NX+b+QE8advr3r0fkAoM0D+P9MQ85?=
 =?iso-8859-1?Q?EUa3fSKXrHmmx9QwaoiUzkkacB/cGFSMCzzc1ofLhq1TxWydJBLBjZaDI+?=
 =?iso-8859-1?Q?bCGU8vmzY8+bcyK09KJfBb3gNv1UJSgptBb6RtkXJOVZE43HT3yl9kmUig?=
 =?iso-8859-1?Q?i0AwSFiUwL88bHfZVJGNZBYjkZTMfvSy2Mim+TY+nhEQJgDwpMA6dfVbGr?=
 =?iso-8859-1?Q?zDZ0J+Ik706qlneF988DtZ4g0Z+h5pDLPkI198MRMUQitW326HCcfUIC7d?=
 =?iso-8859-1?Q?w2ZCwDR2r9kwOjZjhx19KvJHEMUvjD/7RYezQZUSZFT/bRLMS9dCpjL3Cp?=
 =?iso-8859-1?Q?f70bxHjE8yZ8BptH3KL3XoAaxsyvh0plDpxhzmeVzifkhShk7tAdOCfbLc?=
 =?iso-8859-1?Q?wzmlwjMXjOywXKMGHWKWB1n3x/DWehQEKc7nqHWaZVT+Tlo9OrJ2pKsfNW?=
 =?iso-8859-1?Q?2e5FiUNsOFpo721Vo52Hf3aDyIOsvt+qf98hGIFLogo+GZcbXFQoPaoTp9?=
 =?iso-8859-1?Q?dfSVn3BBQ3hbh8VBlMkndamP1CsqX8ZZW8RglHSkiNvpICtEqRzEhvmwO0?=
 =?iso-8859-1?Q?wC7Ix+OlZIs3EmtgkHvoRJrgx7eZ/T4UsiBsVRPfATCdeDmRQOVntCQLuK?=
 =?iso-8859-1?Q?/whXSKcuhVEMXXxBMYcD9qozer1IQiWRBDNf8cXYbW5xCXEhX+4i7XagBd?=
 =?iso-8859-1?Q?XSfffXEvoakhFoP6hgw2MvQA3sH7LA2mc+it83VICQMgVDsGH8askDWZwW?=
 =?iso-8859-1?Q?Lnp44fqTcxk17qFeQkilBb94hgsVxPTfDYZTl6g9f7D/AJuQ9qg1DJLhz1?=
 =?iso-8859-1?Q?a9Hv3qvaDOst5DI0EzUHcc+wXDlOi8g8SolTd4ATyhFd/5JwXSCnil9Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72302601-d6ba-4216-6341-08da679ead5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:48.5527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vJJ0MPPmNgNj1QoQ69GP9Rawqu9mbqNU0I0GmkfUHSS7rgyr1e4uQ1vdsO+jbbO0Q86rGQRPZlXrgZFBxgMH8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-ORIG-GUID: 4b4n-elwiKHuZtd0sYCV1mNebKVq54cC
X-Proofpoint-GUID: 4b4n-elwiKHuZtd0sYCV1mNebKVq54cC
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

Use the VMA iterator instead.

Link: https://lkml.kernel.org/r/20220504011345.662299-18-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-34-Liam.Howlett@orac=
le.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/kernel/vdso.c              |  6 +++---
 arch/powerpc/mm/book3s32/tlb.c          | 11 ++++++-----
 arch/powerpc/mm/book3s64/subpage_prot.c | 13 ++-----------
 3 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 0da287544054..94a8fa5017c3 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -113,18 +113,18 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_spec))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
=20
diff --git a/arch/powerpc/mm/book3s32/tlb.c b/arch/powerpc/mm/book3s32/tlb.=
c
index 19f0ef950d77..9ad6b56bfec9 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -81,14 +81,15 @@ EXPORT_SYMBOL(hash__flush_range);
 void hash__flush_tlb_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *mp;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
-	 * It is safe to go down the mm's list of vmas when called
-	 * from dup_mmap, holding mmap_lock.  It would also be safe from
-	 * unmap_region or exit_mmap, but not from vmtruncate on SMP -
-	 * but it seems dup_mmap is the only SMP case which gets here.
+	 * It is safe to iterate the vmas when called from dup_mmap,
+	 * holding mmap_lock.  It would also be safe from unmap_region
+	 * or exit_mmap, but not from vmtruncate on SMP - but it seems
+	 * dup_mmap is the only SMP case which gets here.
 	 */
-	for (mp =3D mm->mmap; mp !=3D NULL; mp =3D mp->vm_next)
+	for_each_vma(vmi, mp)
 		hash__flush_range(mp->vm_mm, mp->vm_start, mp->vm_end);
 }
 EXPORT_SYMBOL(hash__flush_tlb_mm);
diff --git a/arch/powerpc/mm/book3s64/subpage_prot.c b/arch/powerpc/mm/book=
3s64/subpage_prot.c
index 60c6ea16a972..d73b3b4176e8 100644
--- a/arch/powerpc/mm/book3s64/subpage_prot.c
+++ b/arch/powerpc/mm/book3s64/subpage_prot.c
@@ -149,24 +149,15 @@ static void subpage_mark_vma_nohuge(struct mm_struct =
*mm, unsigned long addr,
 				    unsigned long len)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, addr);
=20
 	/*
 	 * We don't try too hard, we just mark all the vma in that range
 	 * VM_NOHUGEPAGE and split them.
 	 */
-	vma =3D find_vma(mm, addr);
-	/*
-	 * If the range is in unmapped range, just return
-	 */
-	if (vma && ((addr + len) <=3D vma->vm_start))
-		return;
-
-	while (vma) {
-		if (vma->vm_start >=3D (addr + len))
-			break;
+	for_each_vma_range(vmi, vma, addr + len) {
 		vma->vm_flags |=3D VM_NOHUGEPAGE;
 		walk_page_vma(vma, &subpage_walk_ops, NULL);
-		vma =3D vma->vm_next;
 	}
 }
 #else
--=20
2.35.1
