Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A71553BD5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354504AbiFUUsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354451AbiFUUsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACFFF2EA16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ2U9a018663;
        Tue, 21 Jun 2022 20:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+S0uTUUwXqWYj6ZFhYSlEB+PEU5tgeqPuy2kgEl7tk0=;
 b=sdUIaPxdKPAr9SIB/PT00vE3CxkuFkcVPCmGmIfr4we+bVrBh5qbkePxSRVdp0OJEoCk
 dxx3xlyQ1x/7po6jUG1Fy20QO+JwkgTHlhdTGb3hnTfLdymO/Yr8ASbsjZzVMMJjWBGw
 Y09r61Wkn6z+4AView4n6U8yjoIVuMMMB2IpxZrSCWeIHf2vb1Rop5HEZg8GEIBTK/ac
 4DK8a3wMWCiqwfok0vC6kVVOBDNQZUbD20XvPoQV3jxPn5CEHOgaLf/UXMkylpHMxnpc
 axQa5BUv5xJfKBvxiahqaymoPj65w7bBxbjyjiYOAfOUkzqmUORouXbcmCrAl5ctIcH3 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6asxpwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:15 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUgu027828;
        Tue, 21 Jun 2022 20:47:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp36-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRGnl8N5N1GMsWO+PPpCk2KmdRx+ocjh69NC4dwpASYWO2MuPfW4aNPNH6HW+yjLZ3pG3PTG4J1KToOlD4xeA9jJCIvt6r7a+aorf9DkXrXtoDxsEZWZoC41Rotbg4Twa8ZciCb9YK8+jQnbewB9GZY5qhuiqMn55amofewi4+7na+kAXFwS0v9O6ukXCd9gJuRBw4bIH/pAch/epTp9G0uOo6v18LUVkp43YbY+8SbAmsxWvozgBWyXeJeARqT7a7jEhx18H7bqq6iLlcKw9Y2hLMtnH/oR/CHDxBwfyUCe3xYuQE7RHaWaLpj0J7Phx4pW8xvvpKPX9oteS4WweQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+S0uTUUwXqWYj6ZFhYSlEB+PEU5tgeqPuy2kgEl7tk0=;
 b=QK7gSYeegoIMlib5H4jU+V0gk+CAkfw6jbAtU+zD8FP00c0nsz7aVrR43Ubu6iwl5UtrWkzvcsq5UAphMYxjvuE9HBcZwNsbbEEtHFfRowCxNOWfqqDVk2ZO1oPVdjepgFbJKAsWWiU/fmNg6gsx6/1JitHNj5QBpMtEpVM74C0GHpuxkhLjCunPLONpaGGDy+Ap0r6nGl1shim8QiFl3m+mIDSY04OcnSbS2tizi489Fh7IXa9TsD9dpkNJizFfOFTlNjSiDd4yagHFGpk5KX/xggXPQKM7/WcBcaDnuYOMy8E8AqVzjVABL0Bhye/d/08Q1rCjE5Tdt99QPB1yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+S0uTUUwXqWYj6ZFhYSlEB+PEU5tgeqPuy2kgEl7tk0=;
 b=OqVZp1UEsmdiMwjjbSSDg8P2IlOLgsCkJJ7pRpePLQtCZDOOJDl4uqQKp5it46oywyLFWHZaiZY6d8RU5yOGX+rX1FOWbRAGTA75XxaQyG3yFJWbR+CaN0JNL+kQ7rYlvu/BqvRfsm5A6Odrb4QI+Tr/fVav45IVAzgpqXp1vAo=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:12 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 27/69] mm/mmap: move mmap_region() below do_munmap()
Thread-Topic: [PATCH v10 27/69] mm/mmap: move mmap_region() below do_munmap()
Thread-Index: AQHYhbAOETsqHXRdHka8H9DHdEY6Pw==
Date:   Tue, 21 Jun 2022 20:47:01 +0000
Message-ID: <20220621204632.3370049-28-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 278f4eb9-2676-4f2c-f154-08da53c7377b
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB308575F6E8092AFD9B91473DFDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4b62okSo/XhPIdjso58mhcM4SCbGyaZyCjXbQxOq6Nx2Ev35UAB6MUzHyNRGmIRVw7gHu6zZ2nXHwnjhbWiT6ixoUirmaPW4cYWu1w7Q1BeXGcZqgUfMKa0uCsK5UFICigCHbRBaJyRn8XeqdpYV/xSUPalh/Xh5ROEd9tPzjjtPEOeV740hEkdG82EQq0xlBvQtq2Y+boMWhMHCRYQ7E/8Y6fiNoR+2kGwrijEmSW9sDBlQ3GlBv1R2y1OSu3tLzvmypYEK9o33nKs8FxEyp6BmgXAT1ABADMpAkc3yJHZx7rE5BKHgMBgrWgW4AFBFGF7djrsK+O0mY3r5PsAVNFMNsKQUu31Ie0/tm/4wwsgdHP5lOBSEMXx5LtTFp4qEwQDPEYeOlloBHzU3hMP1M5mPCF9K/auAqdoYMza3p7hHelXIoQ78mg0HtdFHNPWrwcZOgwR0rQ9/Pqozt5iIFPzq2XMO5st/L8iivMDh60d61qK9zBwavllJX82a2YKVFjaCQLyh4XdCrJ6wk4EtiGldNLwrqRrIztjI9B4s/ZVqESNSX92jOVcPDyemiubqlVk1RZrZfaASaY8YURWBhVXLTcPfYwTRd2Gdj/4JG8Jv68zPmO7Rk/FA+qx/jentKxZU+U2nvyzzxYfwCB2e3hBGFABEECppqomjq8zeCCe79ZAUWiMz7B+TeZe7cRpFoF9k68ujjwyW/v6A0Nq/QKurit7wHo5s21wmH+r+0i2mZrtwK+6QG+Nk5yDBZyJucRIGm9aJ7DCk1xNeVDA9thwklx0q90rfJUBDRsRK/xM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(30864003)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?MU8zDPax8fs+K3EjXzM58gaXf9vXchgmYmUX0C9bcfFFf8Q5iwZHrsXMDP?=
 =?iso-8859-1?Q?PN0kfcyTD1x0c3UMQH2RQgOZuH9ZCHXfjEOVWGSrDiJa9XnpytWVDVrbvc?=
 =?iso-8859-1?Q?+Ge36DeCfclG9bJR0ydhhj38Ui/UJcy4IUvX02RN4LPmD+IQD7nKAy9x+g?=
 =?iso-8859-1?Q?YV0yAUIqjHSiMESW1SyW3d0LWrLg5nwcsy3A9gRtDKB4K9DsXIf0wRAyo9?=
 =?iso-8859-1?Q?PdrcWzOGkr4E8heDrOS1njTPc6Turz2VWyCbRyJr0eTlO1c9NbRX6L54MB?=
 =?iso-8859-1?Q?1utDEQ7NVVv835CUVNdguHjhbU/Xt+ZAoBCSt7Uj6BnqISt13PKBvNluCR?=
 =?iso-8859-1?Q?K+mzMCNIRBrRLqbsO9+Iv3I/Vb5NaHbLJDr+K0WzIBsCeFSg3aEeOcLMcd?=
 =?iso-8859-1?Q?2Ba3agN23F/zCAMP2QZmQ8CM5cOzFzdWx0rdeyL9runA8ZE2GC/QzlrzIB?=
 =?iso-8859-1?Q?NXHNi5FNK8jTIWzLmvM+/lyEEZdFXgjcAxp6RQ6SEK/liEG15KaQ9p6KA/?=
 =?iso-8859-1?Q?VFbajvC/BGFh8Sh3qD7HZDdQr5OWJyKtjE/WjkZBMsmdTCpOeaB/Gl0bT+?=
 =?iso-8859-1?Q?4VqYxDiLkSG1+gyhQXFtRHO9Sk66p28gPgOIKN+dvc6X8z++e/olyxS4Ga?=
 =?iso-8859-1?Q?iKtl0/Ah69TpolzJA6NSI641XyGkdItYjx239RBihdkzVgS+wtxvQqkSho?=
 =?iso-8859-1?Q?jZHu9G6mqoDalxaF3r9tu4XVmJ6AoLYEHBdkOltOF1OQ5WwlbBn2tnbkSl?=
 =?iso-8859-1?Q?lJ7elF7yUxyqIS1ric/kQcpF3c4Aoi9KYTKnKkKLd8FNvbB+wH/muWJ4kV?=
 =?iso-8859-1?Q?/D5q9cCQFJt46cpyIHF7qVeOrfouRjPJmytcEC4TjUpO/e6qTY2PofYBQv?=
 =?iso-8859-1?Q?idgBfsgm6kxZiY0Tn8s85vWYvTwM32inRW5YK1UC/ymLOFmUdj4AHVQps8?=
 =?iso-8859-1?Q?dQMMZURGZgdIOnom6T41rPTBXjqXIfWOEI6bYVD0lo0uYH1l/NX8rRrkFl?=
 =?iso-8859-1?Q?TLVuWjYANu+q3p8e3NTGhX9fepOzPv782ToVsT2NfMLuWeJba+Y8cODylY?=
 =?iso-8859-1?Q?RykwrUJxkDJX03ncOyWwxeW+mZKmt7or/v0w4L6AJVU5AeuyJo7uSkBQBL?=
 =?iso-8859-1?Q?yCbtrdHzd5hmJUkij15sqdN/X2ktcsJgC0Q6ehOC9+9JPLzJzBNs9zmpiY?=
 =?iso-8859-1?Q?o/4q2b36N3VJa0Dzf494ZWwyJD/SnOLyn3YlvahJltw6UHIqhZ5CN5yT1H?=
 =?iso-8859-1?Q?AcC4mTKRGHMlL9Y9hy+wuK7KQFtcZoLhL1BafStKw/PfgXIb9TCRI0vIiJ?=
 =?iso-8859-1?Q?9hES+NpotDBsmmTGRuCRQvuT+FLRn7hVOhcWKBh3fW5CN/CK4lBJ2m9FWq?=
 =?iso-8859-1?Q?sUogRLpz7elMQGMMmaiNDLdVPdLNVEdGMehzIqAKQo42BLc/4Vk5YBZFNG?=
 =?iso-8859-1?Q?kEXOiQoZx8YQ5FH1uJa0xmdDBfvtPV+svsKibgrFZoAYMYBcZejrWuA/al?=
 =?iso-8859-1?Q?WqOmY/1AWIEJli+23m3h7j9YHcESlsJ/iqE7jTxKDaOfn8sGxr1XfKZZQh?=
 =?iso-8859-1?Q?qhqNJtV5Ly29wsJb/eW+lBAW8m3b/b5ZF4hkfM27qHyA7XJnBLlH03spZB?=
 =?iso-8859-1?Q?M83ctIbXp7ii6f/uhep+ow7GDiCDPsdM14iPecN21ifLEZH7Ng45riOXjS?=
 =?iso-8859-1?Q?dif8+nWYmNF8hhIFWUdg8PWfCV8Bn5oI1Kg9KcionjaW9s329oFoH+z/5k?=
 =?iso-8859-1?Q?f8Od5QiVOKhr0nKH5Y1h4p7Tax8z4a4zz4XQ9XBF0Y6E1QW1n1SAxKlOmN?=
 =?iso-8859-1?Q?H0VU0IXaK8cxB1czAkqLvrzZmKjVC0c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 278f4eb9-2676-4f2c-f154-08da53c7377b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:01.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ct5fqTzzcE2wCuoeAJZwh5N0/3BeHLM11ByEzitM8OWCwfJ2TBU3CJ65n733zmIyLgGTuqjoQ5pKKRfBluI1pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=906 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: SuabWsI37-GaUHB0vCT2phuP2F_s8Jg5
X-Proofpoint-GUID: SuabWsI37-GaUHB0vCT2phuP2F_s8Jg5
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

Relocation of code for the next commit.  There should be no changes here.

Link: https://lkml.kernel.org/r/20220504011345.662299-12-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 495 +++++++++++++++++++++++++++---------------------------
 1 file changed, 248 insertions(+), 247 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d87b18b49a3a..4e0eb2f25324 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1756,253 +1756,8 @@ static inline int accountable_mapping(struct file *=
file, vm_flags_t vm_flags)
 	return (vm_flags & (VM_NORESERVE | VM_SHARED | VM_WRITE)) =3D=3D VM_WRITE=
;
 }
=20
-unsigned long mmap_region(struct file *file, unsigned long addr,
-		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
-		struct list_head *uf)
-{
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma =3D NULL;
-	struct vm_area_struct *next, *prev, *merge;
-	pgoff_t pglen =3D len >> PAGE_SHIFT;
-	unsigned long charged =3D 0;
-	unsigned long end =3D addr + len;
-	unsigned long merge_start =3D addr, merge_end =3D end;
-	pgoff_t vm_pgoff;
-	int error;
-	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
-
-	/* Check against address space limit. */
-	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
-		unsigned long nr_pages;
-
-		/*
-		 * MAP_FIXED may remove pages of mappings that intersects with
-		 * requested mapping. Account for the pages it would unmap.
-		 */
-		nr_pages =3D count_vma_pages_range(mm, addr, end);
-
-		if (!may_expand_vm(mm, vm_flags,
-					(len >> PAGE_SHIFT) - nr_pages))
-			return -ENOMEM;
-	}
-
-	/* Unmap any existing mapping in the area */
-	if (do_munmap(mm, addr, len, uf))
-		return -ENOMEM;
-
-	/*
-	 * Private writable mapping: check memory availability
-	 */
-	if (accountable_mapping(file, vm_flags)) {
-		charged =3D len >> PAGE_SHIFT;
-		if (security_vm_enough_memory_mm(mm, charged))
-			return -ENOMEM;
-		vm_flags |=3D VM_ACCOUNT;
-	}
-
-	next =3D mas_next(&mas, ULONG_MAX);
-	prev =3D mas_prev(&mas, 0);
-	if (vm_flags & VM_SPECIAL)
-		goto cannot_expand;
-
-	/* Attempt to expand an old mapping */
-	/* Check next */
-	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
-	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
-				 NULL_VM_UFFD_CTX, NULL)) {
-		merge_end =3D next->vm_end;
-		vma =3D next;
-		vm_pgoff =3D next->vm_pgoff - pglen;
-	}
-
-	/* Check prev */
-	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
-	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
-				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
-		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
-				       NULL_VM_UFFD_CTX , NULL))) {
-		merge_start =3D prev->vm_start;
-		vma =3D prev;
-		vm_pgoff =3D prev->vm_pgoff;
-	}
-
-
-	/* Actually expand, if possible */
-	if (vma &&
-	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
-		khugepaged_enter_vma(vma, vm_flags);
-		goto expanded;
-	}
-
-	mas.index =3D addr;
-	mas.last =3D end - 1;
-cannot_expand:
-	/*
-	 * Determine the object being mapped and call the appropriate
-	 * specific mapper. the address has already been validated, but
-	 * not unmapped, but the maps are removed from the list.
-	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		error =3D -ENOMEM;
-		goto unacct_error;
-	}
-
-	vma->vm_start =3D addr;
-	vma->vm_end =3D end;
-	vma->vm_flags =3D vm_flags;
-	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
-	vma->vm_pgoff =3D pgoff;
-
-	if (file) {
-		if (vm_flags & VM_SHARED) {
-			error =3D mapping_map_writable(file->f_mapping);
-			if (error)
-				goto free_vma;
-		}
-
-		vma->vm_file =3D get_file(file);
-		error =3D call_mmap(file, vma);
-		if (error)
-			goto unmap_and_free_vma;
-
-		/* Can addr have changed??
-		 *
-		 * Answer: Yes, several device drivers can do it in their
-		 *         f_op->mmap method. -DaveM
-		 */
-		WARN_ON_ONCE(addr !=3D vma->vm_start);
-
-		addr =3D vma->vm_start;
-		mas_reset(&mas);
-
-		/*
-		 * If vm_flags changed after call_mmap(), we should try merge
-		 * vma again as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (merge) {
-				/*
-				 * ->mmap() can change vma->vm_file and fput
-				 * the original file. So fput the vma->vm_file
-				 * here or we would add an extra fput for file
-				 * and cause general protection fault
-				 * ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D merge;
-				/* Update vm_flags to pick up the change. */
-				addr =3D vma->vm_start;
-				vm_flags =3D vma->vm_flags;
-				goto unmap_writable;
-			}
-		}
-
-		vm_flags =3D vma->vm_flags;
-	} else if (vm_flags & VM_SHARED) {
-		error =3D shmem_zero_setup(vma);
-		if (error)
-			goto free_vma;
-	} else {
-		vma_set_anonymous(vma);
-	}
-
-	/* Allow architectures to sanity-check the vm_flags */
-	if (!arch_validate_flags(vma->vm_flags)) {
-		error =3D -EINVAL;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
-		error =3D -ENOMEM;
-		if (file)
-			goto unmap_and_free_vma;
-		else
-			goto free_vma;
-	}
-
-	if (vma->vm_file)
-		i_mmap_lock_write(vma->vm_file->f_mapping);
-
-	vma_mas_store(vma, &mas);
-	__vma_link_list(mm, vma, prev);
-	mm->map_count++;
-	if (vma->vm_file) {
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(vma->vm_file->f_mapping);
-
-		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
-		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
-		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
-		i_mmap_unlock_write(vma->vm_file->f_mapping);
-	}
-
-	/*
-	 * vma_merge() calls khugepaged_enter_vma() either, the below
-	 * call covers the non-merge case.
-	 */
-	khugepaged_enter_vma(vma, vma->vm_flags);
-
-	/* Once vma denies write, undo our temporary denial count */
-unmap_writable:
-	if (file && vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-	file =3D vma->vm_file;
-expanded:
-	perf_event_mmap(vma);
-
-	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
-	if (vm_flags & VM_LOCKED) {
-		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
-					is_vm_hugetlb_page(vma) ||
-					vma =3D=3D get_gate_vma(current->mm))
-			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
-		else
-			mm->locked_vm +=3D (len >> PAGE_SHIFT);
-	}
-
-	if (file)
-		uprobe_mmap(vma);
-
-	/*
-	 * New (or expanded) vma always get soft dirty status.
-	 * Otherwise user-space soft-dirty page tracker won't
-	 * be able to distinguish situation when vma area unmapped,
-	 * then new mapped in-place (which must be aimed as
-	 * a completely new data area).
-	 */
-	vma->vm_flags |=3D VM_SOFTDIRTY;
-
-	vma_set_page_prot(vma);
-
-	validate_mm(mm);
-	return addr;
-
-unmap_and_free_vma:
-	fput(vma->vm_file);
-	vma->vm_file =3D NULL;
-
-	/* Undo any partial mapping done by a device driver. */
-	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
-	charged =3D 0;
-	if (vm_flags & VM_SHARED)
-		mapping_unmap_writable(file->f_mapping);
-free_vma:
-	vm_area_free(vma);
-unacct_error:
-	if (charged)
-		vm_unacct_memory(charged);
-	validate_mm(mm);
-	return error;
-}
-
-/* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
+/*
+ * unmapped_area() Find an area between the low_limit and the high_limit w=
ith
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
  * for the search.
  *
@@ -2870,6 +2625,252 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 	return __do_munmap(mm, start, len, uf, false);
 }
=20
+unsigned long mmap_region(struct file *file, unsigned long addr,
+		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
+		struct list_head *uf)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
+	struct vm_area_struct *next, *prev, *merge;
+	pgoff_t pglen =3D len >> PAGE_SHIFT;
+	unsigned long charged =3D 0;
+	unsigned long end =3D addr + len;
+	unsigned long merge_start =3D addr, merge_end =3D end;
+	pgoff_t vm_pgoff;
+	int error;
+	MA_STATE(mas, &mm->mm_mt, addr, end - 1);
+
+	/* Check against address space limit. */
+	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
+		unsigned long nr_pages;
+
+		/*
+		 * MAP_FIXED may remove pages of mappings that intersects with
+		 * requested mapping. Account for the pages it would unmap.
+		 */
+		nr_pages =3D count_vma_pages_range(mm, addr, end);
+
+		if (!may_expand_vm(mm, vm_flags,
+					(len >> PAGE_SHIFT) - nr_pages))
+			return -ENOMEM;
+	}
+
+	/* Unmap any existing mapping in the area */
+	if (do_munmap(mm, addr, len, uf))
+		return -ENOMEM;
+
+	/*
+	 * Private writable mapping: check memory availability
+	 */
+	if (accountable_mapping(file, vm_flags)) {
+		charged =3D len >> PAGE_SHIFT;
+		if (security_vm_enough_memory_mm(mm, charged))
+			return -ENOMEM;
+		vm_flags |=3D VM_ACCOUNT;
+	}
+
+	next =3D mas_next(&mas, ULONG_MAX);
+	prev =3D mas_prev(&mas, 0);
+	if (vm_flags & VM_SPECIAL)
+		goto cannot_expand;
+
+	/* Attempt to expand an old mapping */
+	/* Check next */
+	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
+	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
+				 NULL_VM_UFFD_CTX, NULL)) {
+		merge_end =3D next->vm_end;
+		vma =3D next;
+		vm_pgoff =3D next->vm_pgoff - pglen;
+	}
+
+	/* Check prev */
+	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
+	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
+				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
+		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
+				       NULL_VM_UFFD_CTX , NULL))) {
+		merge_start =3D prev->vm_start;
+		vma =3D prev;
+		vm_pgoff =3D prev->vm_pgoff;
+	}
+
+
+	/* Actually expand, if possible */
+	if (vma &&
+	    !vma_expand(&mas, vma, merge_start, merge_end, vm_pgoff, next)) {
+		khugepaged_enter_vma(vma, vm_flags);
+		goto expanded;
+	}
+
+	mas.index =3D addr;
+	mas.last =3D end - 1;
+cannot_expand:
+	/*
+	 * Determine the object being mapped and call the appropriate
+	 * specific mapper. the address has already been validated, but
+	 * not unmapped, but the maps are removed from the list.
+	 */
+	vma =3D vm_area_alloc(mm);
+	if (!vma) {
+		error =3D -ENOMEM;
+		goto unacct_error;
+	}
+
+	vma->vm_start =3D addr;
+	vma->vm_end =3D end;
+	vma->vm_flags =3D vm_flags;
+	vma->vm_page_prot =3D vm_get_page_prot(vm_flags);
+	vma->vm_pgoff =3D pgoff;
+
+	if (file) {
+		if (vm_flags & VM_SHARED) {
+			error =3D mapping_map_writable(file->f_mapping);
+			if (error)
+				goto free_vma;
+		}
+
+		vma->vm_file =3D get_file(file);
+		error =3D call_mmap(file, vma);
+		if (error)
+			goto unmap_and_free_vma;
+
+		/* Can addr have changed??
+		 *
+		 * Answer: Yes, several device drivers can do it in their
+		 *         f_op->mmap method. -DaveM
+		 */
+		WARN_ON_ONCE(addr !=3D vma->vm_start);
+
+		addr =3D vma->vm_start;
+		mas_reset(&mas);
+
+		/*
+		 * If vm_flags changed after call_mmap(), we should try merge
+		 * vma again as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
+			merge =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags=
,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			if (merge) {
+				/*
+				 * ->mmap() can change vma->vm_file and fput
+				 * the original file. So fput the vma->vm_file
+				 * here or we would add an extra fput for file
+				 * and cause general protection fault
+				 * ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D merge;
+				/* Update vm_flags to pick up the change. */
+				addr =3D vma->vm_start;
+				vm_flags =3D vma->vm_flags;
+				goto unmap_writable;
+			}
+		}
+
+		vm_flags =3D vma->vm_flags;
+	} else if (vm_flags & VM_SHARED) {
+		error =3D shmem_zero_setup(vma);
+		if (error)
+			goto free_vma;
+	} else {
+		vma_set_anonymous(vma);
+	}
+
+	/* Allow architectures to sanity-check the vm_flags */
+	if (!arch_validate_flags(vma->vm_flags)) {
+		error =3D -EINVAL;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		error =3D -ENOMEM;
+		if (file)
+			goto unmap_and_free_vma;
+		else
+			goto free_vma;
+	}
+
+	if (vma->vm_file)
+		i_mmap_lock_write(vma->vm_file->f_mapping);
+
+	vma_mas_store(vma, &mas);
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
+	if (vma->vm_file) {
+		if (vma->vm_flags & VM_SHARED)
+			mapping_allow_writable(vma->vm_file->f_mapping);
+
+		flush_dcache_mmap_lock(vma->vm_file->f_mapping);
+		vma_interval_tree_insert(vma, &vma->vm_file->f_mapping->i_mmap);
+		flush_dcache_mmap_unlock(vma->vm_file->f_mapping);
+		i_mmap_unlock_write(vma->vm_file->f_mapping);
+	}
+
+	/*
+	 * vma_merge() calls khugepaged_enter_vma() either, the below
+	 * call covers the non-merge case.
+	 */
+	khugepaged_enter_vma(vma, vma->vm_flags);
+
+	/* Once vma denies write, undo our temporary denial count */
+unmap_writable:
+	if (file && vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+	file =3D vma->vm_file;
+expanded:
+	perf_event_mmap(vma);
+
+	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
+	if (vm_flags & VM_LOCKED) {
+		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
+					is_vm_hugetlb_page(vma) ||
+					vma =3D=3D get_gate_vma(current->mm))
+			vma->vm_flags &=3D VM_LOCKED_CLEAR_MASK;
+		else
+			mm->locked_vm +=3D (len >> PAGE_SHIFT);
+	}
+
+	if (file)
+		uprobe_mmap(vma);
+
+	/*
+	 * New (or expanded) vma always get soft dirty status.
+	 * Otherwise user-space soft-dirty page tracker won't
+	 * be able to distinguish situation when vma area unmapped,
+	 * then new mapped in-place (which must be aimed as
+	 * a completely new data area).
+	 */
+	vma->vm_flags |=3D VM_SOFTDIRTY;
+
+	vma_set_page_prot(vma);
+
+	validate_mm(mm);
+	return addr;
+
+unmap_and_free_vma:
+	fput(vma->vm_file);
+	vma->vm_file =3D NULL;
+
+	/* Undo any partial mapping done by a device driver. */
+	unmap_region(mm, vma, prev, vma->vm_start, vma->vm_end);
+	charged =3D 0;
+	if (vm_flags & VM_SHARED)
+		mapping_unmap_writable(file->f_mapping);
+free_vma:
+	vm_area_free(vma);
+unacct_error:
+	if (charged)
+		vm_unacct_memory(charged);
+	validate_mm(mm);
+	return error;
+}
+
 static int __vm_munmap(unsigned long start, size_t len, bool downgrade)
 {
 	int ret;
--=20
2.35.1
