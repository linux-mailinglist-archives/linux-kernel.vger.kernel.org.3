Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8675B59C223
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbiHVPHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236118AbiHVPFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:05:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE5B3AE6D
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:05:37 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MEpmTD016597;
        Mon, 22 Aug 2022 15:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=2SV7qWZl4M768Yeyn8gb0BkprvF4Ffrw9xK87SyHrNA=;
 b=UzCD/bUKT3/lEoZ0DcrTeBG6B+sEtLAi3+j7KZU+lzYDmMSZYsEn/68+NQZgZU0mF73X
 hcj1MdyNrdexRnlJZKc8V1baAg53al20knWCfedxqDUJg9nXy2jxBVWGqIVO+X7i/7vS
 YCwWeGA1iiH2Xz0Teewdon0CCBSA6LKXX36JXNImCjl6xz8Ez/zwJTN+nUgu4kULEpjK
 eHtxfOb8Hp4apxJM9kn58KfwvL+n8qgfbVzSZnqGkG0GvmomFitHUJMVDWmtLFfZRrZY
 +CMUxxGRonDPxzCEtFFD4u8caT2M8Oe4irEcRobhNyo3nMq7B4hZaPOIF3B/VhmWg5I5 dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4bx681ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:29 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4OfI026762;
        Mon, 22 Aug 2022 15:05:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mm8bcxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dz+Q1pJflrF7CK77YBMhftMFgXEMae21QUm9iofk6n8Kl1AZYPtIrLrsOlVU0DPxnlNDvtNmMcR/MS5IzNq8ec+tu3Cx79miVXw5wUGmkRUH58+LjD3y3WAoXcc5xf1LhMYd2ehbOttemrcvAzp4Krw8MUzDG3CQr/A2l7YDI+TOEgI0xoujERuF8PXpU9JU2WePbGphemXU1DmRyis93r//ToPwDZ8ZdpGT1a5DM5rifvWcV2BwqjBkOfGJlYZtXwa8N8q9s78RCURHGNXOAfH70Qpsvebr8QrPVtOnquVazWn7JjazeS45jIoUtxJD0j5APqysxpkkbJ2/9mAz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SV7qWZl4M768Yeyn8gb0BkprvF4Ffrw9xK87SyHrNA=;
 b=erkmQxBgOSvunD/PNExnwuYonvDTIuuB3ICyd4PZk3YHdcG3WTmkqDBP3HnLs3xlKUSu8GFNBbrs6XYoQ3HD7xkefH3LHbmUqYac9a+eTX0qsuJ2S8G0xi0G02VshSbmcmQenXtB0Dq0tyjwcqg2QRc5bJzrwqyiWkKBgwVSIaZsd738ZSYZwO03g1YiWFFEbpaxPPuq+g3YzHM8CVNazo1Y4UApu6Jyxvtzreks+k8Yiwev+Ge9rLMYkeuF5uTLUIeDebG0wqKSI+26BTLLHHaUpoof619YH3Jj4tYMsUlvM+hMsGWVgvwhcTu8zIcxY5CV/Xx6gDPYWk2Vx93VvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SV7qWZl4M768Yeyn8gb0BkprvF4Ffrw9xK87SyHrNA=;
 b=psce+bcMT6ObgCawtRCglaAfDCkAg2OhlwharaVQ4nJ+SgSQBMhvFsqqra5G3ZGIuQcnaNE1wPlFi4ES5Qihj15vqMbFKB4pAqyptxK/rwVJrjke8mGTKmHT6pXzv3isYnx76LiYndwxA4NYxsx6dG7Peq3XQY5ovhLkzKaG5/I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Mon, 22 Aug
 2022 15:05:27 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:27 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 32/70] parisc: remove mmap linked list from cache handling
Thread-Topic: [PATCH v13 32/70] parisc: remove mmap linked list from cache
 handling
Thread-Index: AQHYtjicdJ5BBMMjNEmE3qNlE89bzg==
Date:   Mon, 22 Aug 2022 15:05:27 +0000
Message-ID: <20220822150128.1562046-33-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48b21f9e-6abf-45ed-b668-08da844fbf76
x-ms-traffictypediagnostic: CH0PR10MB5260:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fYEMbGa8iT9mIG1KJ0Okux4a7lchqQyaETytLCiCPZ641MQE67gQTWphN0xu7e+AkTtYWKPmTSkttTcPpOfLraA0U8vhF8/3rYs83w+BtyTV65EPb7yqFqq/mFzDyeqGIr7GOFj/UCG2mKBv1kQbICQ2J6g06SnF4qCZg5FJEhCBnbgA6rNKtgM1LLH4TRq675lma7/viYhuQ75IJZP4PU/71gUAiVyqhMLQH5SAlSCEe9VjED9tJrRxP5MSCSKFx0EqnVUdbGVevbyypp6bNbbkKcNsbX8Dx2s06o3QXkWEgs9u2y54Vf6YqSkB6cl2j7/E/kp9g1ROSpKqy1a+41YJrOn1/vrYfVp5PbzhvjKLBIV+/ajlUZbOE0oVF1QqYfYQud/j+n9+xlz4kkV8ej3Yua/WyZWkszjxL9nJNgbTpL0sNRXwvrAsvCkBp5LhIZAqGDUswR8RS7bkJigeDuxVsh73F7cOrJA+7cK3/ygN3cBNkRmOG888oIv0xARpa8g1F7GtH/3fpOA01StUrzd7UaQ01y2vsoL4sOIJsRqjEuGxzMUflOUmgUHMOKJNVwesi/IIn9nM/DflRD5i7bWoaDia7P8HKbnssQbUeMu7rx9XpWaBQpChkmAdtJsccrk0ozUF3xwaApLVslQmK1iqs2Pc2KTKxNUfGoPC1RN6llx0VaSQ6lXeitrW0OclSV/LnHNaUXPmYP1twKTgoST86pLqyP6P0W3q5vatyU9EnKLxAeRvGXZRJNiZl1iUwamdHcXlK7p7oBJdDyMsbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(2906002)(86362001)(6506007)(1076003)(2616005)(6512007)(38100700002)(186003)(122000001)(83380400001)(38070700005)(54906003)(110136005)(8936002)(36756003)(71200400001)(316002)(6486002)(478600001)(91956017)(76116006)(4326008)(64756008)(66446008)(66476007)(66556008)(66946007)(8676002)(44832011)(5660300002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?RljxpKTlm9zeTfr3Fk0o84VdBj9gUzQwlQh2EmZJAnOpdkyVq1EDV4QadF?=
 =?iso-8859-1?Q?VtkPfAr+dDLFopRSm+SZ5oLm0EehBIQ8zRq+pPK6SsZkR3zl0eCB8pYSrF?=
 =?iso-8859-1?Q?d3el5VmyybLcfx0TiHs2jvZwU1ATojYGZj/qdD6z11ZOgYVeX1YIPgwraN?=
 =?iso-8859-1?Q?8c3Voj/Plj6NIcFPg9CqzXC3NvKG83qVr504ZtbGqYNjnxil+P+DtjJtib?=
 =?iso-8859-1?Q?G2DCmbWFGHjBhoQFexwZylEJbAhS/DVm5X1jMOUJIoxc3J+qi03EQuOR3V?=
 =?iso-8859-1?Q?W3T9KZCfm4BrRldSFjKVl/c3iRvOt4Z9CJ+Gp7WOaQypFJsXvqOFILB4GI?=
 =?iso-8859-1?Q?ELcJJ9W9uyBMMG5OBjuVMla4CU4n1DJspYUB1cM24y4SODrXIn9+8DQ0Ee?=
 =?iso-8859-1?Q?X0SBaDFo3i/jqEDdStHiSfkIwrPEBn+J1y8CarYALQZpyNG4v3ZbA4xteu?=
 =?iso-8859-1?Q?u13nu25+CPFovYwFf/BmL9FI1OPWMfQGr7qvjOGNLyOFidISFwYfw770Xt?=
 =?iso-8859-1?Q?KedgwJZgsCspKcMDTFnrBaB8EMcp5bXEOroWCrlkEex0Ze7+Tm2ZJMhkEQ?=
 =?iso-8859-1?Q?fhs5iyWf5gHpY5LAwvKJZaaVyDgPhKmZDolm7S4rzLn2rDzTWeJ3OeSX6f?=
 =?iso-8859-1?Q?LbH30iTar06b5ooLQlCTggpnYrY0v38tx3U+3+QfJWA9+lRbLGHonguekA?=
 =?iso-8859-1?Q?/Zz78XJ7RZZabelnkJskjnd+S/ydmGiI5c12C47a1+BDqBokK04Hy5QmR6?=
 =?iso-8859-1?Q?0ta2SZrSBNEOqr/sJsrgMRxQseZ3F6amH5sUnJYtjCnk7VxxBQQt6ayLzT?=
 =?iso-8859-1?Q?HRoFBK+yYVEwy7dvxwdHT0ku7dcAVieBrqQyyJmnZnV3fVO7yBQcAZXnid?=
 =?iso-8859-1?Q?YGawgFpa923Cb18YzrCOoCcFqMPRnwIGsHKv6sh5yLDYm4GnRllTOJ6nlh?=
 =?iso-8859-1?Q?FSIoqYIx8xL/ySSXAhhTTqgqevq4zNSTzy/+nd6MU/JqBhu2z7KKdEO+dz?=
 =?iso-8859-1?Q?xVZbnlrESuDdeBckxT0ClDyrAWvr8Ta4GGVUCJeXqjKIPo7y52371w9ssd?=
 =?iso-8859-1?Q?qhrrHdBBLsWx5rbpItJ+JaVpCIcGWKZI1DnW/UCXYOQRvlW8Y4XQ9oQr17?=
 =?iso-8859-1?Q?KA4KC6HMc/tc77fun1yahFpUGCulpP6J7j5j83C9JuuKIThWy4SvoSAFZa?=
 =?iso-8859-1?Q?OgLcw9Gcv2o5hC6AfBduKgKpCcgsn+uefHt+HpHBQA5+xmWfCRd94ScTEI?=
 =?iso-8859-1?Q?5HXNiUeu4CJv+ngszqu0jhtF0JvJkkbsSeWn+XxmzdlUtrtrXe6uhQjPFc?=
 =?iso-8859-1?Q?Wt0OJn8idIy46/mKfg7cBqBF2PRsYW89th1E6QNDS1ftgvlpx+IAg3r5wn?=
 =?iso-8859-1?Q?hOFnRGhdPH6GVbGAWW8s2A3x6LOrBKRnQxBZB7ljrr7KvLxb/Isjry5t5x?=
 =?iso-8859-1?Q?mjkrFFaODwJ07HxpfrmtEZhdqzadgDupLx+1sS6Ju4WbqSJKvgDldvFtIm?=
 =?iso-8859-1?Q?F9oncfFYoWDz7yWbBsofmssopHFsHeU025gUV8i72uO28cXOb/Ab1J192g?=
 =?iso-8859-1?Q?cgU34+cffg7gyTTlmDapRoTphOmpn8RH41IZuwFDCyIy3b6NjZZPICkixx?=
 =?iso-8859-1?Q?NvRQqYbouztKeNU4mGIqEym5WSKz32dO7Lnamd1+Y/zhzxxXh3JVqkJw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b21f9e-6abf-45ed-b668-08da844fbf76
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:27.5545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 984NWaC9kbeO7OuZGtpbKbVywwLeNuRYBoQI9SFZUlPeo/3bpUEhPl519tlldtlaTNBec0uIQw/9IXz0Ecjl/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: 4hxgovXgwvRaMlphBeECa17B62umjLnU
X-Proofpoint-GUID: 4hxgovXgwvRaMlphBeECa17B62umjLnU
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

Use the VMA iterator instead.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 arch/parisc/kernel/cache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/kernel/cache.c b/arch/parisc/kernel/cache.c
index 3feb7694e0ca..1d3b8bc8a623 100644
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@ -657,15 +657,20 @@ static inline unsigned long mm_total_size(struct mm_s=
truct *mm)
 {
 	struct vm_area_struct *vma;
 	unsigned long usize =3D 0;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma && usize < parisc_cache_flush_threshold; vma =
=3D vma->vm_next)
+	for_each_vma(vmi, vma) {
+		if (usize >=3D parisc_cache_flush_threshold)
+			break;
 		usize +=3D vma->vm_end - vma->vm_start;
+	}
 	return usize;
 }
=20
 void flush_cache_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Flushing the whole cache on each cpu takes forever on
@@ -685,7 +690,7 @@ void flush_cache_mm(struct mm_struct *mm)
 	}
=20
 	/* Flush mm */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+	for_each_vma(vmi, vma)
 		flush_cache_pages(vma, vma->vm_start, vma->vm_end);
 }
=20
--=20
2.35.1
