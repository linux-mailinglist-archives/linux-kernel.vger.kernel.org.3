Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA02577377
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbiGQCu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiGQCtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:49:24 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C59C20F48
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:38 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8oqw009632;
        Sun, 17 Jul 2022 02:47:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UnwojIyjlGOiqaAr6LG/+ckPWfBzL7RuclvHq/lcJDA=;
 b=KvU03LkFQ3qw6bnOijnAyHn/+Oe7ALCI/ITQ0ZP+N8xXJO6W4Ry4jrCIO9MbGWIeM6Mm
 GzsaueoWbPulC1K2yjfR4H+8Q3lfamATXoN9/6+mDKqnr0g3fghkGG13AOZ/GrEBvfOe
 aALsskXcm65JZZPEqDXVPs9w5SpcqmoAl24OeAV7QuHMn4fCZ10T4nWtMWQG8exffSgT
 a1joWETxFVzp/vQ9r5ACYVVznUTdTTZxDjqlGAlCs9RxFK6kjIrCM1HsmXmpGCONQjS6
 jCh+mMO/0yuQFeeMdcxAJCT8JSnasbwXRTszEolCSNd3hUDxzZqNtTyDYo9lvap+MsBz 3Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0ync-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:31 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYISP036113;
        Sun, 17 Jul 2022 02:47:30 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp6a8-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:47:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKhX1dmGoA3/dKSZPXCDj8+cOy1cStXUxB/AUd7kaZTZAVDlM4Be0cohxq3RTiLdHtmowLgaf6vLsGlwr63KOzYYonpJ//BI0xtlbz9WYIgcj4G1YJGiHTEzB8BXMEDmTPpja94wpcZygPQFu/5/gRYhUGmlrBHNhpR1Ze9Cdpd84LRppQeWGIiWSBZgLUquSq3xd6S1N+2hW550KBo89BYw8JjRh5LrQN051jEA2BKYQ4C5X2cl3xjkmdmQuXQ1BE+M8U/3tndWL8snxYFt4KV5sDOVs8koLfNPz99xP7mm1OumUPWnmkXd00LGLmL1uJbjt/dUo8nYA7ehkW07EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnwojIyjlGOiqaAr6LG/+ckPWfBzL7RuclvHq/lcJDA=;
 b=BmXb9rmxv4Tc7rkyLDk6oa1kiPeOs+fAPusmaUdjMnbS3ERDUk3NHdn+aUzzy3RujGR+KjCA/qf2RQkcnA9fEBwYKt/1SEk0aCWeOJnJ+5sHFFsAgvw1RZfOGVSnPdT4rf+e0KVWzTGZY5YJwCPrSH/DH31KF+aucGC7w0vjQ8U0eioWfpnXwIrEnjPxO9wZ0eGsrKFjpJdfiqChSe6OuyONG84zIfnjeJWeiMMBDEXnU6QIgt87YklW3BQB7eA/OQq5TkDT191H3DoimkVW/kJFkP+QeqBgpzRshrfERrvBmBdiPYNyXXiy6s30yZWpqtxrrfCpItW0gyf8452qqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnwojIyjlGOiqaAr6LG/+ckPWfBzL7RuclvHq/lcJDA=;
 b=u3pb0v3pYHrp+ecWio0yIjSN0lqdgnHXaxGx6P6pyF5N5r32esWMjIhzPhexqnTx2EyyeLOXsTCyiU3Hsicoicxtm8brtNBTkE4X11SKh9yQ4Dfb5D/QPId98Ozcy/WlHgHFG4B69jCPFkYyVXjjelqQJLhN6+fgqxnJWVCCPWM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB2799.namprd10.prod.outlook.com (2603:10b6:805:d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Sun, 17 Jul
 2022 02:47:28 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:47:28 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 42/69] fs/proc/base: use maple tree iterators in place of
 linked list
Thread-Topic: [PATCH v11 42/69] fs/proc/base: use maple tree iterators in
 place of linked list
Thread-Index: AQHYmYd3ByD1f8O2EUyWmnQSFNNpJA==
Date:   Sun, 17 Jul 2022 02:46:51 +0000
Message-ID: <20220717024615.2106835-43-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 967dc351-5f6e-4fd4-258c-08da679eaff1
x-ms-traffictypediagnostic: SN6PR10MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jIZ6YJwmV42QKrBWOjnS8XBLupFdoQNG4P2DNCpXIdUjR44C8XFXq7YNlLEUrCyCQhjo+zgr8KjJOvuBBpsktvun1pgbVyLI2anS7tMExjvEu6KAY5uzNfO79I6ObD9JJGJkxcOwU9ng8j9KLTBvBC0o1a9b2KxtDW3mAMKqyQWjpDEJ6f/2K1lAGcTbF5yUHlH8WjJBNv3Ww9f33FJhwaMMtANNxUNPMBF1VNH2YsVfsKNZqIf5xcFJ8kWTWqzwrjU76FP02PhU+ukPIXBN63KoBrSb+T1mWxeC5CKvg/rcI33m7UGm8qdeZIODvdOfzycra6OqoegJVRMY3ZIXgTVK4nCI1ruwHDH/G2k5Hcmw1PyvGRe/UnbLIzV6PcZAklmCtyZ2G+QudCFDYvBsfIfhK55sk86TMZXeUFOwfXAYLffz27EM7qTrchZQWFkw8XUBf2452WGxHRljMsad/1aEGjNEjzT4+iIySgobRjKMdnRW7ZVGoL3EG9dIeYjWc4Mm16j8XAqF+hRwUVFRDlSAyv6f/9b/OCsd+cVhypjJcuw07ffigyALrxWBjn4Q2FXnetrUDN6r8+zBPXF+uqn8Uu/NwGbFbHfy4XpSGnIqF6vbanvuW/6Fdo+vXQBOLaPu2vKA1SqmW1Lm2KCLU5TobwCQggvePXN6HYyuh7K5YYdKYsMTT10zEpnGphNVWl7lojuM0nYj7O5ngEy5DJURkAQW0LcelK1CJp3/5KqEauK2sFq966Dc2/hDw665dTN/18+dZsxADlJpmgG+k4QEaVM/Mi8jbHw1wxjUNSf4WZSt1M4vLkQu5CyRg+mIF1DzcN1F1yrelbbG6uZJbciJZpLNZLOYySKhAWqw2k8j9Oji8TjJHQXFyXUuYsmj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(346002)(396003)(136003)(366004)(83380400001)(66446008)(66556008)(64756008)(66946007)(8676002)(122000001)(1076003)(2616005)(66476007)(186003)(38100700002)(91956017)(38070700005)(478600001)(6486002)(8936002)(5660300002)(44832011)(26005)(6666004)(41300700001)(6512007)(71200400001)(966005)(6506007)(316002)(110136005)(36756003)(2906002)(76116006)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iWRwYOPfE7k4TmX2RtiwVxAqE/GevsWa5yt+9OMvwHPcysUzeVO4TDmTQp?=
 =?iso-8859-1?Q?r9mW6kUmH+WeJ/cTETgpUhGMOQoZRvntO8rMUSCGkNndN0Cb3KJ1YJW38+?=
 =?iso-8859-1?Q?1Rko/PYMZ/KEoGa4CuhotbunHsfLeTak31FGVgZ9W0osGxppX9qvjLfxw+?=
 =?iso-8859-1?Q?FDkrjNud/PZBMW0oLBgQggJCdfvvihySdthDns4ueKFR7r/JNEYAO9Drv8?=
 =?iso-8859-1?Q?G/c8nESgz0zJvaXCjSxI6U7NZRCByxWlazDpIBAmRrHR07plwS8dIKL7hI?=
 =?iso-8859-1?Q?7f5lZIjZjE1Ya0T6lgB+GheU/V7NseokfnHRP4J/YX+51fIJhA9FxVr9aP?=
 =?iso-8859-1?Q?5utfYwqyurCuSWtPvfWFIuif68Sr/tdoFXAWCO/UFexdfVv9ZXVMxskFF0?=
 =?iso-8859-1?Q?OP/GmZizA3JjkRfM6Y04jVWl92KcMHH2YK3DG8lOaTxlXJxSuSe09lIUsd?=
 =?iso-8859-1?Q?pWyd4CSNkl3HzAtha4oNlJ6QhGs/6aoylrpIm4yVCShaoMRxucHMgKCBKZ?=
 =?iso-8859-1?Q?FQafg2WF2xGFdT1G8RK/+8B0Z1gMserj7nhfkK071rAg2GnbmeZTvpXVUx?=
 =?iso-8859-1?Q?yyEvzy/Y8zJ8F0qo8vIwQKv6+3bvOaG0CdtwdYjZidaGuiMtYsvJMnna81?=
 =?iso-8859-1?Q?c5oMWpS5XpqZLOJhWF9UtWx+ZKDGZz4yWOOk57WqRaZdGBI4T8Fx1V0uie?=
 =?iso-8859-1?Q?J09pNbBm7fWC85MPQxcQAUoxl7R5ITvSp4y8YxDaoGJYzAA/lPVOhVdra0?=
 =?iso-8859-1?Q?AdGFF5oTiAPjFK7h+cmsmLSj5OSfC4wCeLjslaTMU2ylexD5dN6cLMNiAq?=
 =?iso-8859-1?Q?qtIVLfieac7GAVKjr6B+cpaLqZ4fxd/XaKkx+LNPGwK//pZRLiEh/PVHt7?=
 =?iso-8859-1?Q?gXRA/ovkCBV4DhfmxXtG6FhnUeFXPv4ZjHkJOOrCP2FsHli+j9tE/FtCDY?=
 =?iso-8859-1?Q?7s6ZknAFHaWBkaxvTHCFU9ZTk9izdLq105NL12w8zf/ZvnYg7LNY7LEB0E?=
 =?iso-8859-1?Q?8+4ozDFY/XMAY3nnt5f5C7miiN2LR8xotCtv7lsDrJzR/SbMSoRx6zdqmL?=
 =?iso-8859-1?Q?XYEpxmvL/neFGy4RRNh11QmAfdAZpo78dSndZ+dnhgDyrbhpcmQtXTxDU6?=
 =?iso-8859-1?Q?INYwNQogpgwSwy4FEwy6S9CX8/IlQLY3oeBYsFTJWdMOEfBqEU9SkcTdF/?=
 =?iso-8859-1?Q?zJk2uiICLeBwrC8RJTlrYOiSR9VcDccPJDldZq1Ee5tzFG455A75atmk1L?=
 =?iso-8859-1?Q?pNwSp9PuF4aAQOGSYXUwZN9Ml8IozubzV0hB20O+C+u3fPfSwsmMcGeQEu?=
 =?iso-8859-1?Q?VYbmEkZEHYNOj/dlzYYjLCJ9Vjew2hpcGAcGk41/4AjPq4fbGF/SQDm5fU?=
 =?iso-8859-1?Q?Ra9pJOfF/hQnRjLwLsiSN6mIo4yWgicrWCf7ngvaB1KzqBFawEgg9WiKR8?=
 =?iso-8859-1?Q?c4D4FX8M8RC24xQOrBqYoNXBhH0pzjyAlrvSussBfnNfzZBrPDTDpatupU?=
 =?iso-8859-1?Q?km40fH/4sUppBz+lGcTlMbXCMLyd7erGh4hpzWKVbEDPVT+xr2iC3scY+f?=
 =?iso-8859-1?Q?dTN+y0Zd+eBOA+qNP7n9Aa89lutZGM8CmmHLpyoGh2n8LohtQYgLwD5hUz?=
 =?iso-8859-1?Q?ihbM5iWBirDZsv9GumwL4LXUvX6rMmtNS9W46Bwloy1khr52TQVnbgXg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 967dc351-5f6e-4fd4-258c-08da679eaff1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:51.3025
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gjWqPRSbAhe9OYHXmpD1UUIgzbfh1WyQh7FtsQWwJ9zU5P3XB18XX4JSlM7OYZ2jlcA/5HyschQsCv6wU05oUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: deCbw8nOfWoNp2_CmqWkdhMZTjmABlXi
X-Proofpoint-ORIG-GUID: deCbw8nOfWoNp2_CmqWkdhMZTjmABlXi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Link: https://lkml.kernel.org/r/20220504011345.662299-27-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-43-Liam.Howlett@orac=
le.com
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
 fs/proc/base.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 8dfa36a99c74..617816168748 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2322,6 +2322,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	GENRADIX(struct map_files_info) fa;
 	struct map_files_info *p;
 	int ret;
+	MA_STATE(mas, NULL, 0, 0);
=20
 	genradix_init(&fa);
=20
@@ -2349,6 +2350,7 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	}
=20
 	nr_files =3D 0;
+	mas.tree =3D &mm->mm_mt;
=20
 	/*
 	 * We need two passes here:
@@ -2360,7 +2362,8 @@ proc_map_files_readdir(struct file *file, struct dir_=
context *ctx)
 	 * routine might require mmap_lock taken in might_fault().
 	 */
=20
-	for (vma =3D mm->mmap, pos =3D 2; vma; vma =3D vma->vm_next) {
+	pos =3D 2;
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!vma->vm_file)
 			continue;
 		if (++pos <=3D ctx->pos)
--=20
2.35.1
