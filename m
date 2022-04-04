Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0744F1740
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378099AbiDDOkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 10:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377954AbiDDOhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 10:37:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31108D54
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 07:35:57 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 234Dk3NW014690;
        Mon, 4 Apr 2022 14:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gRqqqaKEfgDSdpF5bYH37DwDYYngrwo8jk1tUNu+0sA=;
 b=aRi+OJo3iAtyLB8PNLBnojeUNl2Faxex75VfKp7amMv/TgX2TXBGElFQ8lN9QCYEZhjY
 8ntZ1xx47SSjScDaZ05QJylF3evZj7ArndqhH2Dh4mPwmXHEN2cSxdbL+QVxWCM9PckQ
 gyZjfAYUEXcuMzcHr4tXNF66etFBgXCU7f8ceRVPGXf+dzheNAYuIYOjk9GgzX2qzRdR
 a6tG/dUp9lXUVAKEH8/b+iJ8lC1PKpGYZjVf8ps2pnCrEtbMGgUmc1Eaq2mMKugnK+m7
 J+vj8F4JrNxhOkQwirraaehHxYQip/Fsr2j0Xolhhl2UQ5RbKl4BEYzjuA/5pywjp+Rf Bw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9kbum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:52 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 234EGkPj033647;
        Mon, 4 Apr 2022 14:35:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f6cx2guqq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 04 Apr 2022 14:35:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ag/lGvoT51YKKQKeuq4+a8a1JTUorov5nBoSQLo6L8adVPxj91Zl1Bp+YFM0SHejBUMEJL31jxoz95IO2Elhm5JhZifAA2nHW32NWwvTL0LSRrU64Ngaw2wsrYWd4Ws+UrV6SlAWlo7YrQeuOwBYVpYhXF1/smurPmmeloTjXQWEFhjjLIr3Pb0hhR4O3j66kLaKQddcpuowSZQYSj99ZcZjm3jfpGBtKIv/xjzi6JCD5uPl2xj6ne7Q9BQadV9G+xudbGFBZ7tK/BTqWp7W+48S+18jz+Uz79Q4bjr4bOrj3pdl43cV9W+YGm/9nRdktVHqY6otZwy3cFv9Gynl4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRqqqaKEfgDSdpF5bYH37DwDYYngrwo8jk1tUNu+0sA=;
 b=cTauKTbqyG1QFZypD/Vhb8FtEDHkI94NxdbmPi/rBSO0LoUu7BAaMBtQ4VT9QMJHe/YhJmdOcN4dGeGtr8aD1sY2CtB5I2odu51tCESDYY+2KjFgKiuCWUQZsggxCbOsYmCI3LNInvNEWGNg31zlCadZf7rft7nfw1q2ERN3mI2SphDGkJPkhgbXfHnAi0Bfy5uHN2sYhqSjrBoEAa4XOr5yAse/AYCcCkRiOZaV6pHG741skgmnuC+d5Au/lrLEvVilsZJ19J0zp8lBqwF9aU+s2pOeK6TVyAAgHzlPCpu+eI55UNW8rlfliOUMIrk9riBsD80QLO6K6GbdzxHO4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRqqqaKEfgDSdpF5bYH37DwDYYngrwo8jk1tUNu+0sA=;
 b=AlVbtEYbCjZ/FCxgpXYAHO39qowBDpphS7jeAOBipkAAbE8wejfSvYY9U1SLXMv+djdRBrz6rYp0APelUVAldVz9t0ziFGrWwCbltd/0kFrIGbQX0gjVS6zZIL8REhjyAF/AQecPS5ukwKJ/VbvLCcH50MPyUzEAZhW3oUaATSw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1381.namprd10.prod.outlook.com (2603:10b6:903:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 14:35:48 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::74fd:df41:4c93:24a5%6]) with mapi id 15.20.5123.031; Mon, 4 Apr 2022
 14:35:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v7 29/70] mm/mmap: Move mmap_region() below do_munmap()
Thread-Topic: [PATCH v7 29/70] mm/mmap: Move mmap_region() below do_munmap()
Thread-Index: AQHYSDFEGamTc3Rhs0SLMh96vcrJeQ==
Date:   Mon, 4 Apr 2022 14:35:44 +0000
Message-ID: <20220404143501.2016403-30-Liam.Howlett@oracle.com>
References: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220404143501.2016403-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 37926ec4-9dd1-4bef-f0e6-08da1648693b
x-ms-traffictypediagnostic: CY4PR10MB1381:EE_
x-microsoft-antispam-prvs: <CY4PR10MB1381A5F608FEE04677A70F62FDE59@CY4PR10MB1381.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AtNMA4YZPrMTqBaKJvI41Avd6BMqhPXa7UqDYS/MywAeCb0j7euzrPmHdov5NHbHu4pcn0x9f1hLyRyfSPO64luA836bOzqfSbPc2aCy3X3zTIiaeay0X83rU+xX+7++EetK+5/8TSxWO0IMScb1aErwuBG9QK+F6xTAMJbsGatatTaO2iGS2jovOO2b2RZ6XPLJAmg95h45hfjLEES2tCIbk5tJWYKe3rQGFJa6Opuo43gRP9n4HoUJqooQsOtMPP8z7Veqx0Af4UjAYHyl5T3u8r8Cxg5Iil2TbdHM1HGqu/2i+MVdB1Y/78Aw1TPUa2T534pnRgxSaYR1GOXtdUi/COtN+h3yLKWivYuFJ3hlewc09M9TxqCPAj5JpUYksX1ff5webPnto0eNGE5eKonX9eq3hkOF9WslG1lDybBxK1noUt5ILe7tDUSNEwuOBBPwr3pfGDiEi/o+6TyFRlxo6fMZjTocvMA5vCvjj8u2r2xVoucJleEiZG05lTv7kcRtaf1JJar0CQlr0VnFDRNtDEXw8pfHFIGf1GIQTT8xC8ySTCyUE1EeCMAGT42Sj9f9XlRYeJMSGysjbvCUtXQ6ZGLvAiLMbPl2xTukrCy4DPIArQkOGvnXIbomGEblwaXwXPpxh67gPRJ2A+3Q/y8kC1Pa3h2NZJViCKs8QioJ3HEov+YG6SuDaGChSVLruCnc4E2ZTfBAz4jqUAxwmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(6506007)(6666004)(2906002)(66446008)(66946007)(110136005)(66556008)(66476007)(36756003)(8676002)(76116006)(91956017)(64756008)(6512007)(316002)(71200400001)(5660300002)(2616005)(38070700005)(38100700002)(30864003)(1076003)(83380400001)(186003)(508600001)(26005)(8936002)(86362001)(6486002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?qGUvBzqE8zV4OLF+o9eeu46gnh10boK4AMqXeSGv7nVpayyeqn97pkhQYK?=
 =?iso-8859-1?Q?eb0w4g4zQAyL+3x4Y7z4FrHBOHpUVypzTx7GSaMNSR3eTP/vk0gpR9XglT?=
 =?iso-8859-1?Q?QZDEtrcA4vW6jdFoRdB751Hf8jQrWhvT0sY5h2u7ReBHRwGGqQj2oDEARP?=
 =?iso-8859-1?Q?bMCLK2eDWQQYmQp0mjyXsYhzYVm203/RdjxhzET2I2myeDkf7wONi9IPBE?=
 =?iso-8859-1?Q?3oi7CtOKWyXCPqlSoBUEjlpkcVD2da9wIojOffeNLvM3n87hhbIMvcJE5t?=
 =?iso-8859-1?Q?yG+MGJUsSEoGzF/C35JeJ5lL/F+c7xkZPsqCTZ7BF0wvSh6IvH3pw4iQMT?=
 =?iso-8859-1?Q?/aPgN5Zt9PSAtZj+1OTuKR+TLRxkU1ExKoZ205n12g0vjBAXbJv5Sx3fkA?=
 =?iso-8859-1?Q?ZGFg1fJPRFL7rWe4U+1uFHUSxVOwOlZLgf82YNwZjFkCNHwkkSC8D8DjAF?=
 =?iso-8859-1?Q?CwpgCeZzeCZDTBZ9kpIY7V6S+If3RlDSDwFFMi2UhRB2Tq77W5G82ZqCSW?=
 =?iso-8859-1?Q?1r4IqQWcqzS+lyNqBJ8ibL2paCnX7lHqA3yeD0NRLowNlh4+z5fJhCfYWa?=
 =?iso-8859-1?Q?QF5lHhziF6M0RcTEuAXuDvCR8sIXSkxd+jKYyc8QAkhx3lpi7RaxyT0d12?=
 =?iso-8859-1?Q?oL1P/MAA1eoq9pWJ/D8/5YiMOOTDAFrhXqJ+Fgek7fvDzZok3bew7OqdFE?=
 =?iso-8859-1?Q?R3D3YyIcZqzm46D06krDnRo+7lkoMTwVGTecI7vQqneE9o7VCQRh1DUC6Z?=
 =?iso-8859-1?Q?Z3dL+A2XBFh9+Vh0ZBhyxuhHvek/IsZSDj2lTTLMs6TIkgn6edm686nZ50?=
 =?iso-8859-1?Q?LOw7WxS3vpDSwCbBCKnCz1RSSU5xl5DNQ2HQeotKaOKrW9BeG1iLeg9xQE?=
 =?iso-8859-1?Q?S784Johwma9EpxIhTZ/pt8DbI18szfs/cuvcBXM9hOop2wbsqIYZpGJjuC?=
 =?iso-8859-1?Q?WFgvVGEQbMvRT8Da1RXAVs/41LlJ3fLyu9n4DnszFwdBkHGEzNhLkG67lo?=
 =?iso-8859-1?Q?I37LtcGm5SlqiNKhbR2EV4fvn50EmBL1VbsXbWMLb1SDTGBhSJZCabde23?=
 =?iso-8859-1?Q?Bzj8eMjOUesg7X4GxIe9tKVOTMcPktloNkgDtqZ+gKgSqvBhLorlfexU5T?=
 =?iso-8859-1?Q?H+3Pocwt4Rvwyftsl4joe2NrqzQVUPBwF6J8MydTLf9CRR+H/EibfBt7n+?=
 =?iso-8859-1?Q?v9JsTRqsQlkjsnGFW/Ey7/m+HJXaCPELZb6vGp6k/4PLXFuF48kNTI202B?=
 =?iso-8859-1?Q?thxG+x4edmSVCSbNPqkAnvSIirzGc1ANbod6yGrQKhV0i0Qxu643zEV01p?=
 =?iso-8859-1?Q?yu0e30um0bnk4H5nWBZcNPFr7nmqV6IhgfsphwTjSvgnxtKUhCug0A43gi?=
 =?iso-8859-1?Q?blYRSSePqrNoIR1QKZCT5iEVi3o+wVueX+vH+aQBLxOXs+lvPjn8dZpttZ?=
 =?iso-8859-1?Q?EJ6IAZH+4SKT5y3FTvefYLhvMrPEEm8OU2B6EPw/YD+ZTBY6/9Y1RhFBRJ?=
 =?iso-8859-1?Q?ZnG2ztUrPt9mppk7UlyV92U9snlB/OZBCCspfGZhHTFrPfcSASJ41yPYHu?=
 =?iso-8859-1?Q?4KslWZnIA/F1Tk/+APOMNlJauIk4bJKF68YLxFiQ0zYeEh8Jek1ujz8gvE?=
 =?iso-8859-1?Q?iXsLzmGCirrt2Q4Xq6uqm5HELdZHUSCR4gq0CWOKfJQQT918POdJHZEdOW?=
 =?iso-8859-1?Q?2ZAbh1jc7aAPVT3VzYpqr+uhlY2JzxC/W9lmj6AdUONBTgyxcAJVD6ciz4?=
 =?iso-8859-1?Q?zVLGK1Vq7MDpraoAKv/S0PYc+M8dvCnh3HKQVHTsY5g6GmlYKx0ntqdm0n?=
 =?iso-8859-1?Q?VFPgHRtKCFkJAmcLvXc82d/kCQ7wq8c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37926ec4-9dd1-4bef-f0e6-08da1648693b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Apr 2022 14:35:44.6278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2ZxqF3rUX5yVOuzD2SaVti8pmafA91rX3ZRA9W8mlIb9G+obxjyswUbkfoJorSUIvBMqo2kyk+aYFN2PLHXoYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1381
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-04_05:2022-03-30,2022-04-04 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204040082
X-Proofpoint-GUID: 7kvVyzwYnXcnxvCqxr9pO9aBLgl4TidG
X-Proofpoint-ORIG-GUID: 7kvVyzwYnXcnxvCqxr9pO9aBLgl4TidG
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

Relocation of code for the next commit.  There should be no changes
here.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 460 +++++++++++++++++++++++++++---------------------------
 1 file changed, 230 insertions(+), 230 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 0466e4512e2d..5a72c9dc46a6 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1701,236 +1701,6 @@ static inline int accountable_mapping(struct file *=
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
-	struct vm_area_struct *prev, *next;
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
-		khugepaged_enter_vma_merge(vma, vm_flags);
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
-		/* If vm_flags changed after call_mmap(), we should try merge vma again
-		 * as we may succeed this time.
-		 */
-		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
-			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
-				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
-			if (next) {
-				/* ->mmap() can change vma->vm_file and fput the original file. So
-				 * fput the vma->vm_file here or we would add an extra fput for file
-				 * and cause general protection fault ultimately.
-				 */
-				fput(vma->vm_file);
-				vm_area_free(vma);
-				vma =3D prev;
-				/* Update vm_flags and possible addr to pick up the change. We don't
-				 * warn here if addr changed as the vma is not linked by vma_link().
-				 */
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
 /* unmapped_area() Find an area between the low_limit and the high_limit w=
ith
  * the correct alignment and offset, all from @info. Note: current->mm is =
used
  * for the search.
@@ -2769,6 +2539,236 @@ int do_munmap(struct mm_struct *mm, unsigned long s=
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
+	struct vm_area_struct *prev, *next;
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
+		khugepaged_enter_vma_merge(vma, vm_flags);
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
+		/* If vm_flags changed after call_mmap(), we should try merge vma again
+		 * as we may succeed this time.
+		 */
+		if (unlikely(vm_flags !=3D vma->vm_flags && prev)) {
+			next =3D vma_merge(mm, prev, vma->vm_start, vma->vm_end, vma->vm_flags,
+				NULL, vma->vm_file, vma->vm_pgoff, NULL, NULL_VM_UFFD_CTX, NULL);
+			if (next) {
+				/* ->mmap() can change vma->vm_file and fput the original file. So
+				 * fput the vma->vm_file here or we would add an extra fput for file
+				 * and cause general protection fault ultimately.
+				 */
+				fput(vma->vm_file);
+				vm_area_free(vma);
+				vma =3D prev;
+				/* Update vm_flags and possible addr to pick up the change. We don't
+				 * warn here if addr changed as the vma is not linked by vma_link().
+				 */
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
2.34.1
