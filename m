Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4967A4F1728
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377985AbiDDOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377922AbiDDOhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:53 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 475033F33E
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:55 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dl5Ed006371;
        Mon, 4 Apr 2022 14:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tqdAhdQveTTuQXEwi8SOd4sjsf8Rk4hsOI6v7clSrtE=;
 b=x6vuohcYf3hHihPGYsaatOmgVVp8+8xYhUeEkRKdY5pqOQ2YfQjOjsFgIenYV6eSMzr6
 EqpeS9q04rsI3cnnc8Zu/6U0lysTuB5W/9UAe27i4q2IWC6c0TExKbrFuvXd6FXOl/Xx
 11VtJFA1Yvh54KMP9f5VmtP5VRBSSFTyDTaRuDnNfQ2C8AfCDjo/PS0jdtPSirDj3P6+
 WXE6pZcrdbq9iNEr/ggek31YRheeJwuG2Z6QdMbeOJMnp4dFyRmtxe4tPuU73FioQ+P+
 ahJ/xNKri/P5kQZmiIaltQpt2C/Y9XstlmP06xluSj8o6E9HeQ9u5pNPD4udsYGbBkgw 1A== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6d31bf1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:49 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGQE4028988;
        Mon, 4 Apr 2022 14:35:48 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx2c8h2-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rkz+RMjxRvG/BtnzH3qlIs1SJa+oqddd3w63b5GLsulYnpRf9vGhjlBcD5bNOjLyv18alC+BhiI41VrGLZyvZIFIGTJqTJXGZXKTrzLwJZ9WYNwfDNkD+FmL0alm74ex/wikxKuxxnyFsDXhe6a25BACdHH6rddUIayzVxJy63p0uchJD4vFs9yi34DwSKbm1agoQaIjYHrAV9KgJE319KR9sSzq/ugxIkufDnnd9IiORM2OihOEUaI1Yn2BTk2TraUL9nSKSCXcA4is+O3w/pRT5af2vx3U/DoYSYq/wJRPmFK4DjjdOHWBfcYtDgKwHUabTZ6WXZaJlgokD60qxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tqdAhdQveTTuQXEwi8SOd4sjsf8Rk4hsOI6v7clSrtE=;
 b=SN26uqnIq2W3c2ESgxaUWhIu0Khp5h/vMh6scoiKeK5fZ4HYxUp2HVjuQdffqCIawbisVXo291/umCNFmLv+INcs+z3rCvw26sR442xe5Nx2JNRkMTdBtXmrGN223qBJzK+2pdMMhdTaaU492Q4EaymGN1+egGn+xzlXFNVM2Vb3fGBSRVv+4h4gyFmvQ4ARooEvCq0CK1aUCS+DrMidG5kTcg+WoCaV00yVlb1Xk2rYINpdL272dRw+7zaCsVtqJqjDhF2+07UyBGbxDuitEJ7liR7gAvpK0zCtK+oMhs208X16h0hj6iML01oEOSkSQHuDYnVMEDTdpuM+BO3PIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tqdAhdQveTTuQXEwi8SOd4sjsf8Rk4hsOI6v7clSrtE=;
 b=aSBy5DOyg1OKM2sT3KI0rDVHuo5zTjUVOjgrtR4RTLqOoVpM5Teyi9S6QIRhbYvDoxijL+/4x+5NgNm2utrc2bgDhcYCKBrxHz39fNJXr/+vfRHc4B/AvDsBczNRpwv7nqmrQEWueOz8q8o9k6UDsEhZENMxxqsFTmiJ5GFjhv8=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Mon, 4 Apr
 2022 14:35:46 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:45 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 24/70] mm/mmap: Change do_brk_flags() to expand existing
 VMA and add do_brk_munmap()
Thread-Topic: [PATCH v7 24/70] mm/mmap: Change do_brk_flags() to expand
 existing VMA and add do_brk_munmap()
Thread-Index: AQHYSDFDssQWuGyYn0OzYUNXbaBIPQ==
Date:   Mon, 4 Apr 2022 14:35:42 +0000
Message-ID: <20220404143501.2016403-25-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 84450bec-2efb-429f-584c-08da164867b7
x-ms-traffictypediagnostic: MW4PR10MB5812:EE_
x-microsoft-antispam-prvs: <MW4PR10MB5812FA9CDBF3BB0F2FD0CE73FDE59@MW4PR10MB5812.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rXkGXmSjbT5P686ESaOYdth2Nyz0SZ+dVat2zeFouwiZ2P3OO5FiC+75SAbZbO4Z/Y/h/J2ty6afJSZuycXBHE6lgeyn1Esp7bz/mjTz9fPZ3K0wTxIl9w0d+aFPBB7bNROLouzllspaY9Q7DxkxTZZi3aEBG0t/ZbN+Kg9qJxFwVoteuuY1PTXmSmDsYyCbRu8LHeV95uzPfBBmLpEDNlFDRKRKZwU6GvmwKsYrlTPzmcl+YoAKNJwVRONdXO4sH6Rnbfr3chp6hK2Rln58hos5ES0/F4KbGvGp33qHALp1Zv0xWgXIvGieNDqm/m/6BqsCvwVqcVectvHTKYGpAmKelhFydXgrCrbzxOMOkeMPulPuqJNVPaaFanofCPtRi4ez6Qpm0TZuifK5yNK3EPiPNwkgYjP9+COTbiskkpAOljpfwSm0CvcZnukWfQybapzmiqLTqukmdqrBeB8f+ztWjniHx2qN1iXRILzyQhxrkq0u4E7Rd2ECoRhk+PR5xyWlgyjTfJqm4BsK6/fTn9RleC//OYgmNGBGTWcyUrJhL3bH7rxOsNHTTEXYyVRRWoC8GE6/Lh4M6OdtboxaSVEXsvU2VlGvK6JzwwnP+hkYzvwLjAzJz81OgdXV+13yTSeHMG6WH75C1M+b5kLzHZ8BI6L6fewLe0IMc8ueA962MMx7gMpBn5nqEvOWC+7EmAi+HlXPWzST+qMWI1ZSDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(30864003)(6486002)(8936002)(1076003)(44832011)(83380400001)(6666004)(508600001)(5660300002)(6506007)(36756003)(71200400001)(2616005)(2906002)(186003)(91956017)(64756008)(66556008)(66476007)(66446008)(76116006)(66946007)(6512007)(38070700005)(86362001)(38100700002)(8676002)(316002)(122000001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?TwbRrsPBvI0lU9rXvhR6tZWNLVRija9Yv3sA1h0wNrLjCPJUO5QWRwUUEa?=
 =?iso-8859-1?Q?IGhtczHo+qUXuY1KnMztjmi8XkCSZfpu1byx448X1uAcl329/ywMEilw2W?=
 =?iso-8859-1?Q?Iw7DUZUxmor56qvu26QDWy+DQPpHAkboajCiLojGv+brI3HIMdKPoBtjg7?=
 =?iso-8859-1?Q?lNx3WDBCmtJ6O/iZUI8vV5ZotcUse3E8aieYSX4GUZCow5sJIvVAGCcCd3?=
 =?iso-8859-1?Q?ZUPpdO8vi92c/01gk8n60SnM4TxtGLiLn4LVaVaL2vqD54PWQMo09P7Qdf?=
 =?iso-8859-1?Q?B4PZUoQo9zskJvbvdnfXgFoSB31ZjgQiInOsMPPK5svEscsWBPbjHeSI++?=
 =?iso-8859-1?Q?tVwAK21QooGCDCWlDvT4E5WW55cVxtJIS8E53R7hoWUn2QgoplQDKciiI5?=
 =?iso-8859-1?Q?d7b8x35dcYNQK5vTPViOMyGHCJZDz9J+gBO6qob11H1gia9l9EaSESQ0gs?=
 =?iso-8859-1?Q?kteMwcSvLNnAdr0qxGXV6/DnAq01QAdzgJgp/h78NNf107SzD6Gbdn67Db?=
 =?iso-8859-1?Q?s4XQPdQZmm6EBhujB7zpEHXi40LrhebhYkZpa/iYXd4RgqacjwIC2Lep3+?=
 =?iso-8859-1?Q?a24+E5UgaJvxdk6aPbBPDnSJWRpAbVSG//aNomQMdnVeynU3jUEvzsROQU?=
 =?iso-8859-1?Q?FiSRLxOBLk+SAH88kDXqE9LfOeBTADl0DKhKUUzsHd/Qd46w7XZr3o4KxL?=
 =?iso-8859-1?Q?snf9jGjatFV1YuZrohIT22G8agcssAhBXFb6PscjUWHXtNhL6p25NrgzLv?=
 =?iso-8859-1?Q?wWy7ZRNWqfhiir+nZmqNbsJ4klFY3gmSlGa3laZcBaBMTEZ5guB93BkD8U?=
 =?iso-8859-1?Q?Ra25ViI9vQb6OERKp3PXpQZ/XqgBlF5xHqj9CqBioweintwC8cDCUpW3Nc?=
 =?iso-8859-1?Q?ipRZ4T4JJpHy+8oVOnVYmn2cueZ3gFpz+O/ehMjnTCaq7hAiQcUit8je48?=
 =?iso-8859-1?Q?hENcwFo9/nhycmAZ1vpyN//yFATIl2iXmiXyvCTrxef2M3VKR4yuIQzQaU?=
 =?iso-8859-1?Q?7QLXezC9wjyMfVJ3IbQ9oAUgdxyyHSt7iqiixYD/IFAc50xBfvZBHGsNs0?=
 =?iso-8859-1?Q?g/qNiHXOswRUgExHAFxxcOuXHTFeSBjyI99krDi2wEr+DdPC98s+SM3OmQ?=
 =?iso-8859-1?Q?6ULQeJdsJIiOrGXxVIie6g4L4ytqIgunSS9eLa10UnuUKMIeFXNDX4beZx?=
 =?iso-8859-1?Q?UkL+LbLWVia90KZpJf1eYE4bJQXMlzsgoSSekqzQUaUMpsy1LGi8bMYcy8?=
 =?iso-8859-1?Q?SBEE/HDjnYKP7EfQBp//Yrmxq60anfH1QLD3rLT0E6e+5mw1Gvii3aRNgT?=
 =?iso-8859-1?Q?Y3mPAJFYwcezaLB+8kC6PrtKiLfXUZiFrZDAZ1KVDCmLU4tVhzMQz4vN8s?=
 =?iso-8859-1?Q?NcOTj2MTHhF+c9xBP3dnx56AmuR0iHw1jpOxffRfRGPXTLebk3EdQgh2Bo?=
 =?iso-8859-1?Q?rZbjTBQah64lLnsCMkjMjJoAlWrL27NuSjwpekqqewdOL7HtzSqnIp5qAW?=
 =?iso-8859-1?Q?/I/HHX7Uc0nb234ahTk8GR3YyZCluib3LB6AgQEu/jGfl2VM55voCj3Rkl?=
 =?iso-8859-1?Q?P68B13Ih+DKv4sm7HY7wYfZtjhuMKkekPqOYVGS21hhvmvDeXhPtxoWf7l?=
 =?iso-8859-1?Q?XHKkfa+s2IwG6zNSB9prYCDIuU/7V2/+eTOX8nBAnv4baTRWmX+xOB0IfB?=
 =?iso-8859-1?Q?ytohgMdsVixpWXJY9oy8wc/BLr8DKITgANDsPf86DHKhpeLJxR1eGlaoy9?=
 =?iso-8859-1?Q?wKeVkhL33o1hVFkUJkr2McBZ9U2/VAkjAWFTmHpiAVqjdRY9pfNEBUIOG+?=
 =?iso-8859-1?Q?+ZbwYFLKUoEw5MLVcTTaAy/y74meZaw=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84450bec-2efb-429f-584c-08da164867b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:42.6124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enkWd7LYoU8pjfYHjSLoPdnP9iu/vCiy/cqU3pU0+v8X1z5BhLwvX+jZEm9140+X6YLEBE3hklAzwWBSS1aRFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_06:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: HZKZNaiwnNPd_daTMCy-KpPImeuIVgcO
X-Proofpoint-ORIG-GUID: HZKZNaiwnNPd_daTMCy-KpPImeuIVgcO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Avoid allocating a new VMA when it a vma modification can occur.  When a
brk() can expand or contract a VMA, then the single store operation will
only modify one index of the maple tree instead of causing a node to
split or coalesce.  This avoids unnecessary allocations/frees of maple
tree nodes and VMAs.

Move some limit & flag verifications out of the do_brk_flags() function
to use only relevant checks in the code path of bkr() and
vm_brk_flags().

Set the vma to check if it can expand in vm_brk_flags() if extra
criteria are met.

Drop userfaultfd from do_brk_flags() path and only use it in
vm_brk_flags() path since that is the only place a munmap will happen.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 283 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 227 insertions(+), 56 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7b4db8decfd2..e04614d7eaba 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -189,17 +189,40 @@ static struct vm_area_struct *remove_vma(struct vm_ar=
ea_struct *vma)
 	return next;
 }
=20
-static int do_brk_flags(unsigned long addr, unsigned long request, unsigne=
d long flags,
-		struct list_head *uf);
+/*
+ * check_brk_limits() - Use platform specific check of range & verify mloc=
k
+ * limits.
+ * @addr: The address to check
+ * @len: The size of increase.
+ *
+ * Return: 0 on success.
+ */
+static int check_brk_limits(unsigned long addr, unsigned long len)
+{
+	unsigned long mapped_addr;
+
+	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
+	if (IS_ERR_VALUE(mapped_addr))
+		return mapped_addr;
+
+	return mlock_future_check(current->mm, current->mm->def_flags, len);
+}
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf);
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *brkvm=
a,
+			unsigned long addr, unsigned long request,
+			unsigned long flags);
 SYSCALL_DEFINE1(brk, unsigned long, brk)
 {
 	unsigned long newbrk, oldbrk, origbrk;
 	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *next;
+	struct vm_area_struct *brkvma, *next =3D NULL;
 	unsigned long min_brk;
 	bool populate;
 	bool downgraded =3D false;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, 0, 0);
=20
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
@@ -241,35 +264,52 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
=20
 	/*
 	 * Always allow shrinking brk.
-	 * __do_munmap() may downgrade mmap_lock to read.
+	 * do_brk_munmap() may downgrade mmap_lock to read.
 	 */
 	if (brk <=3D mm->brk) {
 		int ret;
=20
+		/* Search one past newbrk */
+		mas_set(&mas, newbrk);
+		brkvma =3D mas_find(&mas, oldbrk);
+		BUG_ON(brkvma =3D=3D NULL);
+		if (brkvma->vm_start >=3D oldbrk)
+			goto out; /* mapping intersects with an existing non-brk vma. */
 		/*
-		 * mm->brk must to be protected by write mmap_lock so update it
-		 * before downgrading mmap_lock. When __do_munmap() fails,
-		 * mm->brk will be restored from origbrk.
+		 * mm->brk must be protected by write mmap_lock.
+		 * do_brk_munmap() may downgrade the lock,  so update it
+		 * before calling do_brk_munmap().
 		 */
 		mm->brk =3D brk;
-		ret =3D __do_munmap(mm, newbrk, oldbrk-newbrk, &uf, true);
-		if (ret < 0) {
-			mm->brk =3D origbrk;
-			goto out;
-		} else if (ret =3D=3D 1) {
+		mas.last =3D oldbrk - 1;
+		ret =3D do_brk_munmap(&mas, brkvma, newbrk, oldbrk, &uf);
+		if (ret =3D=3D 1)  {
 			downgraded =3D true;
-		}
-		goto success;
+			goto success;
+		} else if (!ret)
+			goto success;
+
+		mm->brk =3D origbrk;
+		goto out;
 	}
=20
-	/* Check against existing mmap mappings. */
-	next =3D find_vma(mm, oldbrk);
+	if (check_brk_limits(oldbrk, newbrk - oldbrk))
+		goto out;
+
+	/*
+	 * Only check if the next VMA is within the stack_guard_gap of the
+	 * expansion area
+	 */
+	mas_set(&mas, oldbrk);
+	next =3D mas_find(&mas, newbrk - 1 + PAGE_SIZE + stack_guard_gap);
 	if (next && newbrk + PAGE_SIZE > vm_start_gap(next))
 		goto out;
=20
+	brkvma =3D mas_prev(&mas, mm->start_brk);
 	/* Ok, looks good - let it rip. */
-	if (do_brk_flags(oldbrk, newbrk-oldbrk, 0, &uf) < 0)
+	if (do_brk_flags(&mas, brkvma, oldbrk, newbrk - oldbrk, 0) < 0)
 		goto out;
+
 	mm->brk =3D brk;
=20
 success:
@@ -2706,38 +2746,115 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, s=
tart, unsigned long, size,
 }
=20
 /*
- *  this is really a simplified "do_mmap".  it only handles
- *  anonymous maps.  eventually we may be able to do some
- *  brk-specific accounting here.
+ * brk_munmap() - Unmap a parital vma.
+ * @mas: The maple tree state.
+ * @vma: The vma to be modified
+ * @newbrk: the start of the address to unmap
+ * @oldbrk: The end of the address to unmap
+ * @uf: The userfaultfd list_head
+ *
+ * Returns: 1 on success.
+ * unmaps a partial VMA mapping.  Does not handle alignment, downgrades lo=
ck if
+ * possible.
  */
-static int do_brk_flags(unsigned long addr, unsigned long len,
-			unsigned long flags, struct list_head *uf)
+static int do_brk_munmap(struct ma_state *mas, struct vm_area_struct *vma,
+			 unsigned long newbrk, unsigned long oldbrk,
+			 struct list_head *uf)
 {
-	struct mm_struct *mm =3D current->mm;
-	struct vm_area_struct *vma, *prev;
-	pgoff_t pgoff =3D addr >> PAGE_SHIFT;
-	int error;
-	unsigned long mapped_addr;
-	validate_mm_mt(mm);
+	struct mm_struct *mm =3D vma->vm_mm;
+	struct vm_area_struct unmap;
+	unsigned long unmap_pages;
+	int ret =3D 1;
+
+	arch_unmap(mm, newbrk, oldbrk);
+
+	if (likely((vma->vm_end < oldbrk) ||
+		   ((vma->vm_start =3D=3D newbrk) && (vma->vm_end =3D=3D oldbrk)))) {
+		/* remove entire mapping(s) */
+		mas_set(mas, newbrk);
+		if (vma->vm_start !=3D newbrk)
+			mas_reset(mas); /* cause a re-walk for the first overlap. */
+		ret =3D __do_munmap(mm, newbrk, oldbrk - newbrk, uf, true);
+		goto munmap_full_vma;
+	}
+
+	vma_init(&unmap, mm);
+	unmap.vm_start =3D newbrk;
+	unmap.vm_end =3D oldbrk;
+	ret =3D userfaultfd_unmap_prep(&unmap, newbrk, oldbrk, uf);
+	if (ret)
+		return ret;
+	ret =3D 1;
=20
-	/* Until we need other flags, refuse anything except VM_EXEC. */
-	if ((flags & (~VM_EXEC)) !=3D 0)
-		return -EINVAL;
-	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
+	/* Change the oldbrk of vma to the newbrk of the munmap area */
+	vma_adjust_trans_huge(vma, vma->vm_start, newbrk, 0);
+	if (vma->anon_vma) {
+		anon_vma_lock_write(vma->anon_vma);
+		anon_vma_interval_tree_pre_update_vma(vma);
+	}
=20
-	mapped_addr =3D get_unmapped_area(NULL, addr, len, 0, MAP_FIXED);
-	if (IS_ERR_VALUE(mapped_addr))
-		return mapped_addr;
+	vma->vm_end =3D newbrk;
+	if (vma_mas_remove(&unmap, mas))
+		goto mas_store_fail;
=20
-	error =3D mlock_future_check(mm, mm->def_flags, len);
-	if (error)
-		return error;
+	vmacache_invalidate(vma->vm_mm);
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
=20
-	/* Clear old maps, set up prev and uf */
-	if (munmap_vma_range(mm, addr, len, &prev, uf))
-		return -ENOMEM;
+	unmap_pages =3D vma_pages(&unmap);
+	if (vma->vm_flags & VM_LOCKED) {
+		mm->locked_vm -=3D unmap_pages;
+		munlock_vma_pages_range(&unmap, newbrk, oldbrk);
+	}
+
+	mmap_write_downgrade(mm);
+	unmap_region(mm, &unmap, vma, newbrk, oldbrk);
+	/* Statistics */
+	vm_stat_account(mm, vma->vm_flags, -unmap_pages);
+	if (vma->vm_flags & VM_ACCOUNT)
+		vm_unacct_memory(unmap_pages);
=20
-	/* Check against address space limits *after* clearing old maps... */
+munmap_full_vma:
+	validate_mm_mt(mm);
+	return ret;
+
+mas_store_fail:
+	vma->vm_end =3D oldbrk;
+	if (vma->anon_vma) {
+		anon_vma_interval_tree_post_update_vma(vma);
+		anon_vma_unlock_write(vma->anon_vma);
+	}
+	return -ENOMEM;
+}
+
+/*
+ * do_brk_flags() - Increase the brk vma if the flags match.
+ * @mas: The maple tree state.
+ * @addr: The start address
+ * @len: The length of the increase
+ * @vma: The vma,
+ * @flags: The VMA Flags
+ *
+ * Extend the brk VMA from addr to addr + len.  If the VMA is NULL or the =
flags
+ * do not match then create a new anonymous VMA.  Eventually we may be abl=
e to
+ * do some brk-specific accounting here.
+ */
+static int do_brk_flags(struct ma_state *mas, struct vm_area_struct *vma,
+			unsigned long addr, unsigned long len,
+			unsigned long flags)
+{
+	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *prev =3D NULL;
+	validate_mm_mt(mm);
+
+
+	/*
+	 * Check against address space limits by the changed size
+	 * Note: This happens *after* clearing old mappings in some code paths.
+	 */
+	flags |=3D VM_DATA_DEFAULT_FLAGS | VM_ACCOUNT | mm->def_flags;
 	if (!may_expand_vm(mm, flags, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
@@ -2747,28 +2864,51 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
 		return -ENOMEM;
=20
-	/* Can we just expand an old private anonymous mapping? */
-	vma =3D vma_merge(mm, prev, addr, addr + len, flags,
-			NULL, NULL, pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-	if (vma)
-		goto out;
-
 	/*
-	 * create a vma struct for an anonymous mapping
+	 * Expand the existing vma if possible; Note that singular lists do not
+	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	vma =3D vm_area_alloc(mm);
-	if (!vma) {
-		vm_unacct_memory(len >> PAGE_SHIFT);
-		return -ENOMEM;
+	if (vma &&
+	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
+	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+		mas->index =3D vma->vm_start;
+		mas->last =3D addr + len - 1;
+		vma_adjust_trans_huge(vma, addr, addr + len, 0);
+		if (vma->anon_vma) {
+			anon_vma_lock_write(vma->anon_vma);
+			anon_vma_interval_tree_pre_update_vma(vma);
+		}
+		vma->vm_end =3D addr + len;
+		vma->vm_flags |=3D VM_SOFTDIRTY;
+		mas_store_gfp(mas, vma, GFP_KERNEL);
+
+		if (vma->anon_vma) {
+			anon_vma_interval_tree_post_update_vma(vma);
+			anon_vma_unlock_write(vma->anon_vma);
+		}
+		khugepaged_enter_vma_merge(vma, flags);
+		goto out;
 	}
+	prev =3D vma;
+
+	/* create a vma struct for an anonymous mapping */
+	vma =3D vm_area_alloc(mm);
+	if (!vma)
+		goto vma_alloc_fail;
=20
 	vma_set_anonymous(vma);
 	vma->vm_start =3D addr;
 	vma->vm_end =3D addr + len;
-	vma->vm_pgoff =3D pgoff;
+	vma->vm_pgoff =3D addr >> PAGE_SHIFT;
 	vma->vm_flags =3D flags;
 	vma->vm_page_prot =3D vm_get_page_prot(flags);
-	vma_link(mm, vma, prev);
+	vma_mas_store(vma, mas);
+
+	if (!prev)
+		prev =3D mas_prev(mas, 0);
+
+	__vma_link_list(mm, vma, prev);
+	mm->map_count++;
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
@@ -2778,15 +2918,21 @@ static int do_brk_flags(unsigned long addr, unsigne=
d long len,
 	vma->vm_flags |=3D VM_SOFTDIRTY;
 	validate_mm_mt(mm);
 	return 0;
+
+vma_alloc_fail:
+	vm_unacct_memory(len >> PAGE_SHIFT);
+	return -ENOMEM;
 }
=20
 int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long =
flags)
 {
 	struct mm_struct *mm =3D current->mm;
+	struct vm_area_struct *vma =3D NULL;
 	unsigned long len;
 	int ret;
 	bool populate;
 	LIST_HEAD(uf);
+	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
 	len =3D PAGE_ALIGN(request);
 	if (len < request)
@@ -2797,13 +2943,38 @@ int vm_brk_flags(unsigned long addr, unsigned long =
request, unsigned long flags)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
-	ret =3D do_brk_flags(addr, len, flags, &uf);
+	/* Until we need other flags, refuse anything except VM_EXEC. */
+	if ((flags & (~VM_EXEC)) !=3D 0)
+		return -EINVAL;
+
+	ret =3D check_brk_limits(addr, len);
+	if (ret)
+		goto limits_failed;
+
+	if (find_vma_intersection(mm, addr, addr + len))
+		ret =3D do_munmap(mm, addr, len, &uf);
+
+	if (ret)
+		goto munmap_failed;
+
+	vma =3D mas_prev(&mas, 0);
+	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
+	    !can_vma_merge_after(vma, flags, NULL, NULL,
+				 addr >> PAGE_SHIFT,NULL_VM_UFFD_CTX, NULL))
+		vma =3D NULL;
+
+	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	userfaultfd_unmap_complete(mm, &uf);
 	if (populate && !ret)
 		mm_populate(addr, len);
 	return ret;
+
+munmap_failed:
+limits_failed:
+	mmap_write_unlock(mm);
+	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
=20
--=20
2.34.1
