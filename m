Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA112553C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354686AbiFUUt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354547AbiFUUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:21 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FAD112D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:59 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJDCAd011597;
        Tue, 21 Jun 2022 20:47:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=3/bHEDj1Te9izQ2FghrPpvWfBSMdJdZblbRacL2SaDc=;
 b=JfyIA5kELPW5dZ5QZJmIJqjB+U+IuGLagvLXMN2gGKcftsdsQSpC8XOtoxh4x4V0ziG3
 6Bbn9xdcAoKFG4Y1fLXeIoWjpUp81Ysq5Z3UGVla1IuXNltqMwRLH3ytNVApYkcX2C/J
 VFQymYUnrAWysfcu1FzW2tty/mnbV3MWvipgq8hr4H8go4pgPKd61jRHEOWdLfiebF69
 rM8PdBAGHmBYi/W5lRIDSl6Q1dosLWGt4s6HrRZhycyN6hMpyl5NERCjbdfJ9Wm7NErV
 sVXwmdT1apjMpOhflKOtT9yyjC8SBl+qhRtmbhx1edYBn6gv4x+Xa1wiGQeee6rh4HlI wg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eq9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:47 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUhq027847;
        Tue, 21 Jun 2022 20:47:46 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wspfd-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jhh53jN8t8F4cXwQVE8gp3yr4T8hoJ5ZJy+f8nKOHq7x2aEBgzWWvVicjsk0hg90Pjb13+gByfVRpMkCFBCQIG1M1bLqFTp/Mmb+HaFPGztEJ26XzMlEHhCtbEoei7ganLP1f5k9u5Swm/osM0eHYQWN91rK6jBksFcz0ri+LU9bObMjw34aGisPjWTyJfUZ4RONrTFsLwk3i2wKEHrT7LjDKQBmsu4A1R9shKTd06CVOkfGQm72voLQlcACuTxfbGhAbj2OjiGkDnPhfEapXoNCp++u6Qk6qtjBln9NRvqpzanM7AVjc5dzKvqUlnaZc2AhFgbc3sVvYbjxJpc5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/bHEDj1Te9izQ2FghrPpvWfBSMdJdZblbRacL2SaDc=;
 b=FxjB4xCLYXB9F1ruOTehmBn7BwtvIKjc4fvAMU/1rijKBoS5xAolLDGOyLKESnpDrkLImVLqxe1RKaSgEE9IXUFqeJC7jVkqvny5D3BtLQcCJEpWfcq91gBtHl2qk9n9k5WQYc+W7ilST5Q6Of0kz23b06/0PXq0f7gzW45IKU+kaQAtkTXaILcOYTD1V/uugZMHtgv0usUmSJnFH8t5Ac75N323UPcf2Rhpuq988N8sTbwkQlHTAGIZ6msXyOlTaxUo9L9VbpoEflrzDP/puMwOV8Qvnvd1utohTIUbam53bx8EX7zcShVDDUKaDZGARRu9ds0H3hZdnBH8XGNWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/bHEDj1Te9izQ2FghrPpvWfBSMdJdZblbRacL2SaDc=;
 b=ds5U9n0+p5pweLN8T7NaHqsKv//pmQWke538TDOKsIwBcsAxLz1sNErom1uFgJiWpBxOqiidXvDWyf01yz/x9teOK5q2gOcF0vk8K0FLZUyKqebf+RV/8j1OXaMvKmSXBVJFzPuC1UuBKcA9bxQPBAWXUkDM1/A5qbxCpC6Ta+w=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB4025.namprd10.prod.outlook.com (2603:10b6:5:1fe::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:44 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:44 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 31/69] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH v10 31/69] arm64: Change elfcore for_each_mte_vma() to
 use VMA iterator
Thread-Index: AQHYhbAP4NW6HATntUeU4CI2B+Raiw==
Date:   Tue, 21 Jun 2022 20:47:02 +0000
Message-ID: <20220621204632.3370049-32-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c35eb93-4413-4848-cfdf-08da53c74a90
x-ms-traffictypediagnostic: DM6PR10MB4025:EE_
x-microsoft-antispam-prvs: <DM6PR10MB40259C314C1B6DE381BB454EFDB39@DM6PR10MB4025.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lc+lMw4J73EJCMfor7mty1L6ocT0yfMhfc1ngUC/TsThJvRRbMHSECnjw15AS6iuvBUHvcgN+lTZ3CzJXDGJe9a5HY8Wuho4wN5KT17Ixccsxq7XIraIAGox5NmKP51/VvZAA6vqAX4xY/JurWXOerdHK9xzK4OOyyNEulDwNbLNu8ypDslBVTTLOCF1DUqTd7sxfbC3TtV0zSRqsQfixwwsEAsB3S/RjxiDXd6S4k7iT7xZc1x8OPh3ijjWGBeP+Yh7tlg4gp7W8bdRrQqb9mg9nVGntk188pggXwooVcri8J4pPAvYcfn/PSHvTxkAefQl08Y0a3YI+q59gFnAuZhTnNb3KoLmA6fZsv9SOWRcsusgMaf+q9YcKWkcqXK0lhb/gBXT7l3sW/y7pFHaaVNAsqLr0HWgqN/FHCsGWqztaIhT+AC9hnRGTn/1Hy3B88vzaQkYair9COX3aAvxTo9Ko5fhwamsutGstkO++SSnMG1Nhp5FiTSUrFuvlm4iuDfcE3f/qwgNETUhucZyTa2ZlNWZsVt6UqR3ci83FsOBKuiXvgv2gPYtstbTHiqgoMRCYwCZV4VZYcI+AVHwcIqXoHmDjG8JxguzmkxeDAyT6WTDbDlOf2xgYWlsWIR9+vByld+BVnsCQpfm/8KITOXgRn2m5mOpdbrmqrozvxe3eAcO5BvKbDsQyKM4MSKDDcSCfAThudwDetls3v6Uxvqnl0GkCfYn6eHJMQ0ZaAtaeig8w+WU0PspQPh54A6+JjCjRvvugcdytP8ROAZtRMMWX3lo7qEZEgd64qSKTDCuAnpCVzqzGrc97WvVVPZh2E8CUbeZ/UJyeuyVsmLApA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(346002)(366004)(376002)(396003)(6512007)(41300700001)(478600001)(122000001)(6486002)(966005)(110136005)(36756003)(8936002)(71200400001)(8676002)(26005)(6666004)(6506007)(83380400001)(2906002)(66446008)(316002)(86362001)(2616005)(91956017)(1076003)(66476007)(66556008)(5660300002)(38070700005)(64756008)(66946007)(44832011)(76116006)(186003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A8ixfbDBOxISMgw/GD5Lw4v6D77wWoO3DGToZHopKuqtpvRwnmOIhwuG5c?=
 =?iso-8859-1?Q?io+NiUBP3otdGWSyWJtzIB/rtCH3lkeAVOy6gVUZrWooQxZu6aS0fRsJJ0?=
 =?iso-8859-1?Q?FpqUNTSOPlq2POdaIiy+3+IcEvNEDPeKTFj1p7CbFNlSeeh9bIx+GZCdJV?=
 =?iso-8859-1?Q?wunthL3rCMeS36YxpaRWPfL7u2KIxb/AWh8etm4cSsppFHy/ZvV3TIKYwR?=
 =?iso-8859-1?Q?JXVue0fYSUWatBdxVWgYk27rZ8tPrcdtzqHzKj8DheHHeVjhTtB8LCSd99?=
 =?iso-8859-1?Q?+MKNAYFmvr3pWJCok74M+rFSVIDhnJ+nPArSk7JYc2pwsOs4znTGIklXYI?=
 =?iso-8859-1?Q?Dcls10iUwU+GDAMZlyNo2PosgQgweuurt+LDnh2IBPJ1epd0YcboGTDtU3?=
 =?iso-8859-1?Q?9JInA5Nhiw6cwzNSCy/mw59wdKQbGaoLXjMxbvTMq0FT98KN6JSfRsdTAz?=
 =?iso-8859-1?Q?eHFCeQ82Ih3w7Xcf5s/1uJli2Dk9Mcp+VLYDgR5PAvyt2Wkjpl4fcTee+5?=
 =?iso-8859-1?Q?vv4R/9adPQvfcToqsMoM53vDZ6o1Q2w0Qha5Eo37nHnZJwucasZC7t31Hh?=
 =?iso-8859-1?Q?vxklKuV9ickIgDbQuzlwQWR49rECFqmN/xsDW9/f5ugdd7Pyifw260nkFE?=
 =?iso-8859-1?Q?3uoaOPe9KSoKQ/JEjwdmMEtUMVpOe2xIV3YDpdgk2jXVIsMXNeJGzrx9TN?=
 =?iso-8859-1?Q?vtkshXh6EDjWKgvtT3A3leUxDddfdjf5X3tIe623oN7hM8bIPA6oD8hOsM?=
 =?iso-8859-1?Q?FAciKqC6x+J5x16OE8tlOkaR+DRY55MVM7Ruceqsga2APnfutDYSxRlvrM?=
 =?iso-8859-1?Q?rMe1SyG8iOvEnKrKyPR9G47U44/WCzpt+G6Y8ANmM/4ZRDH76AlwL4QFA/?=
 =?iso-8859-1?Q?WBbk5sGbGP6HncYxmCleTBTGqlIThlbWL/kvSWZu1UGSzO8WN63MN+N+Jf?=
 =?iso-8859-1?Q?8YCoEY862u5ZMWrO9w77/zYhMA81dUSDM5W5Vzve5czbu/AvFcrl1wDjjd?=
 =?iso-8859-1?Q?OZDtDpe5qupodPLbbsVIi5x5m5eTnv7TSZbxHfE8XZxmY1Lo82VSvIrm2o?=
 =?iso-8859-1?Q?b6J3Gti3g9PB2XlsQE/uKILZHD1zlcEbMdOSldMf0fYFmbRfIXVDPRdZYx?=
 =?iso-8859-1?Q?//MEDAfLBntcRf6amDHWW5nrooWoxO14QRsBtR8+98PeIJJmOeblfmxXrl?=
 =?iso-8859-1?Q?Rr2mWxKJlM4Yt4OiyGjZZwy3p1ptS2EQumLbZlfg9x/17t0SfLoeUZh0ss?=
 =?iso-8859-1?Q?TZu2T/0EeYLLrdp4TXPkRUXkLihuw6gWcYpHLoh0PwZHpkJby8NTJ2X3uT?=
 =?iso-8859-1?Q?WHprJetPA5arwhRmL+VWAVickbNZGbjeVVCt7HkhojuxCjVGkHBOtgsSmn?=
 =?iso-8859-1?Q?yyBnZQCgmCCGhRkJOMAsB2AOL0l/e/fPzlvBt8f0WBwfGJ3MSbF9zmOo9B?=
 =?iso-8859-1?Q?qwVDMnahZpffeS/YousNyEprfnNm2EueCYgnMB27cZZt2BZvpN7/FJjX1q?=
 =?iso-8859-1?Q?r4G8bWRQydvpQHvPd6+w+yRjayzdzIbXtQA1rXKox9ZKJiOqctomkbF3Xc?=
 =?iso-8859-1?Q?oHNj3y9TFhx8N4V0in4RHuikhqO6K84QhufQOOCi2YgQC3MDkzkN3z5T+L?=
 =?iso-8859-1?Q?7YeEMiRARRqiUaCMkrxQNsxDw8Z2PP1cFBbx2TuiMgMwmJirwmZ9AnJ9D3?=
 =?iso-8859-1?Q?KCyOsdHFVCRJb36cURTQNpm93Ri4R2dh08oGUUC2zMYFuPDCwtZrm72mGz?=
 =?iso-8859-1?Q?YfIp4YmF5XxO5J5izhmqn1IykMyUDBq7Ivx95h9TF8302y8fLExyYPm7Lr?=
 =?iso-8859-1?Q?PRBY0Ulvasm4aWrjRUPlUowanhjl1OM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c35eb93-4413-4848-cfdf-08da53c74a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:02.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tckmrvij29h/u2nzKKxCDo6qQmV/RIyNBmpVEQrkE465JFijJ6NHsfJd/wEuuX4tCqMpBu9XqkxFiUodsc8t9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=878 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: J1o2j_GqfH9t9XW87dgfuqna1PoByS2T
X-Proofpoint-GUID: J1o2j_GqfH9t9XW87dgfuqna1PoByS2T
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

Rework for_each_mte_vma() to use a VMA iterator instead of an explicit
linked-list.

Link: https://lkml.kernel.org/r/20220504011345.662299-16-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20220218023650.672072-1-Liam.Howlett@oracle=
.com
Signed-off-by: Will Deacon <will@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/arm64/kernel/elfcore.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 98d67444a5b6..27ef7ad3ffd2 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,9 +8,9 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
=20
-#define for_each_mte_vma(tsk, vma)					\
+#define for_each_mte_vma(vmi, vma)					\
 	if (system_supports_mte())					\
-		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
+		for_each_vma(vmi, vma)					\
 			if (vma->vm_flags & VM_MTE)
=20
 static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
@@ -81,8 +81,9 @@ Elf_Half elf_core_extra_phdrs(void)
 {
 	struct vm_area_struct *vma;
 	int vma_count =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		vma_count++;
=20
 	return vma_count;
@@ -91,8 +92,9 @@ Elf_Half elf_core_extra_phdrs(void)
 int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset=
)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		struct elf_phdr phdr;
=20
 		phdr.p_type =3D PT_AARCH64_MEMTAG_MTE;
@@ -116,8 +118,9 @@ size_t elf_core_extra_data_size(void)
 {
 	struct vm_area_struct *vma;
 	size_t data_size =3D 0;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(vmi, vma)
 		data_size +=3D mte_vma_tag_dump_size(vma);
=20
 	return data_size;
@@ -126,8 +129,9 @@ size_t elf_core_extra_data_size(void)
 int elf_core_write_extra_data(struct coredump_params *cprm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, current->mm, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(vmi, vma) {
 		if (vma->vm_flags & VM_DONTDUMP)
 			continue;
=20
--=20
2.35.1
