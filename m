Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5378553C11
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354997AbiFUUxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354576AbiFUUv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:51:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB3B2F654
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:50 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ5FQi011595;
        Tue, 21 Jun 2022 20:48:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Il+pVmNKez8lWDtkwAh6CDxw+TDqNOMFQEkkISsfdLU=;
 b=cm2+XR3ij4lIf6g4OU3Cy5WFV/0uPXL+ZPQrTA1u8uqqYyE48r0CYp109tncYeXI4726
 N7NzsxFHWZ4r0sVdrE5pBumILPKlviu+lRKwtPJJXioDc2xT9W0R8hYV0juQi9LzjZKc
 k9dGfXkv35ADyfpqvzVhag6Us0FHXrTbNFOsrKNKyoMj5CJSU7Q6SGQ/6hfUhjJW6Cdv
 eEX+Ex9W/1IHW1nr9eI4/VGdIuxCjyY1EccuMEVnspbH3RDv40lrklStPshU+Wrf3U/c
 tjeW57sJAwmmzx/8hR5cnqvykmkjpubKE70I5paSuFNa+aik+VDSlkA+7qrXVrrgSlKf ug== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs5a0eqbq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:37 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdwkW010169;
        Tue, 21 Jun 2022 20:48:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvv7n-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I59O6bb0ZHGcrOr+cxiaGqxWSkbAzupTKRJHRQXU2ewCa9yu2e6qAuVY6Z7a19y3O9Gyv/eRBxW3yLFQefGdxQYc0UCe+ualJUqfVcRkDYqxIKERzqxQMuZIVhlq/ZrSEVnH+qCH6K3nQonxCzEewka/41hyNpKLDZjETFrP+R0sC9VmfUDqsKKXPgfa4urnlJnHiXf2z4aJvjsOqiKvHXtgYPUgNN32UlADALa87biVpv/qn2wyDntijH4/u6WZJffqWyJ3rBSamX2R/2TSb2rSukUzRzxe/fw6HgFFtRkKOXb8zH1K4aLFQ9grVkIZ7WjdaObeDkm1VmCcP7aEgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Il+pVmNKez8lWDtkwAh6CDxw+TDqNOMFQEkkISsfdLU=;
 b=BStXhysDpOdwxTGiS9h/zFEZn4jjw5ElzCmNea8eLiM6X910UNxCMw3teGj9mo5BN8wylJsscqvOjxug6dgoFTRDheNtzeHuB4dEpgNzQyYKfeiRt9Y7rg6S11LZYlj/Dd3leL59luB0rMEbiFpySRiWd2gzyRNlFGcC7LNMBjlD+Mh8AJUlq/PTsrfJD6BVBQMneFotvwxmyRzf+rroOZyZ3ZluLx9gJWhxBdCxKiAfjPO+A9e1cTi6EejEhMPA9ogs7zh9RDjFFLIAAshcW0UPKQQVCJjbGluJsG2iL/2xkK3hhY7CibHyFPl2/bfU+/wI+Id/2ffQwgFqyJXO1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Il+pVmNKez8lWDtkwAh6CDxw+TDqNOMFQEkkISsfdLU=;
 b=z1Fx6c6O8+sjbZjDKLq4S+4OQvNZpVFukh0YTYOqXqp4MQu5ILp5w/QBAuA1YFuWMlYe9RowchREvXNMHjzfa31H/8QiowCVwMpbI2OXGBe75D2NJ+Nl4XA7CDmGIR46C/JjAvCOXPqwU8EhCHlQobCc9lON2mVRpJRvSu/nQqE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3869.namprd10.prod.outlook.com (2603:10b6:208:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 20:48:31 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:48:31 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 69/69] mm/mmap.c: pass in mapping to __vma_link_file()
Thread-Topic: [PATCH v10 69/69] mm/mmap.c: pass in mapping to
 __vma_link_file()
Thread-Index: AQHYhbAWxUY48YqHBEmt7gHRZkrXig==
Date:   Tue, 21 Jun 2022 20:47:14 +0000
Message-ID: <20220621204632.3370049-70-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3da969c2-3394-45c8-3e3d-08da53c766ff
x-ms-traffictypediagnostic: MN2PR10MB3869:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3869C5B058B100FBB0505BC8FDB39@MN2PR10MB3869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGhD1+9JH54K2GpI9CaoPYlTNoCPtmHvKXt/NrBgxmjhNC7Z04vbVR5Y96d4bMpDadtNP4FRh5EiyGlPbOZBKKvKx37GbXzwAgT+IgtOBQkBFs4TfMAuoOLhRZh8P23Ntvu6sc0+EvPOdWv8t+gmo3Ug717cD12xk7pJuAVaMNeai3G76uyDqiKEMolO8/UrqOwir7xDFiI7PPHZZzy5pO4gNo6xFvRumle88Qd4CXXLLrapUYfDKh1TgegY2ngtuIJ9ZmBjmIAzLyjnKHpqzM6Dk2ZslqIrCk0IzavJyeJH0J8EWTiQFqyW3ZG9JebCufpmYwkzetFH8gGhRXSC/ZiZK2hak9KnCbOp4wZN5U3bsD1h7gOEFe23GmThtV1RZ4fBje1w1IR9+VuncrN+49F416Mqe2GPAamWcMTl44F83BrXjcpV4h2Kl0zUTfRlVotexJqHWkfZeszMQgtOxKiuS/ASiaxmnTuvBzbIt4NH6alVpYMPOEy3vLT6aowwj+xZFQvOV46WN2ePhKOt7qjcDSbWsAc2nC3LYcIFy4TU8hOU8qwSQX5YdOifUWgc4CFAj7I0hdq7oQ/DrtDndoFtLOGBzp8hkg/evZ4E1V7k3WWsjSdy327GyFjFVVf/qz+TbOtFk6RzwhwnjZYwLmfsmyxcmxHRMPVPD2CwN4WM+T55hx+5YO7ONnvA/ABKizFaIFb1Tt2g+24+Jg3Rwk4rs30xbe5WGSZZYTZcy2BR9J10XEA972G+uokbITffcnGdL01REs3TdG/ew6dYsdUfUy2WyOmzuRk/rH6Y0aQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(26005)(6666004)(2616005)(966005)(91956017)(6512007)(6506007)(186003)(41300700001)(1076003)(122000001)(83380400001)(38100700002)(44832011)(86362001)(8676002)(66556008)(66476007)(38070700005)(5660300002)(316002)(2906002)(110136005)(66946007)(71200400001)(66446008)(6486002)(36756003)(478600001)(8936002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?+YhwNuGbR4WtZWCUlWcJkMr2ZQvO0Yi086gd5MBYbyZLmI7m01tObQ0ptK?=
 =?iso-8859-1?Q?RCwTu2Ugrv98hSgcb6+7qs2J6q10YVl3+mfK/damEzdNfkDKjLUbC6IjAz?=
 =?iso-8859-1?Q?Lx5L37pJ/Mj5cLaA+JsE9Sc1EabhASNPCJVfPTX4EyI65p7o//bFlZsLnc?=
 =?iso-8859-1?Q?shIGfSAJTcKHGbGHtLQ7/dQnJ6fm0v2eKg0HY+inloIBoBML5pKyb9LTf5?=
 =?iso-8859-1?Q?5SKL8LHlzvP+rwxmLjP8EsZP+fDtS1VXXxiLgJgeHpOxPmsdosQMopDQes?=
 =?iso-8859-1?Q?xDQanzmrrFZkPv9nCbAIMFO1QusIup3mH0bq3ic3yUsDxpOKas2lWJwUa8?=
 =?iso-8859-1?Q?G5QLLgFNgQvc2TMWpRqIYh5mgG0RSKA4W/juPK9Z22npMck4hZboBo6zer?=
 =?iso-8859-1?Q?ChrWqP3zYbmyAqiBBBMc1pGeFj3uJIdD0zkuYu7YMh/Rs38UgsihqolQEn?=
 =?iso-8859-1?Q?kSnbdoQOVEY7TiIU3mvCpooxEW5KqpNKWK1ZE/3fN+HAVzi5gdZpZLT5at?=
 =?iso-8859-1?Q?R8X8IPsKJ0np2E2MjMqcHSg9uZnfCsFocBDlOEWPsMEXKiCAXbHxUykGLN?=
 =?iso-8859-1?Q?ZkIepqjlrvsCtydLTMIAIK785kWfzuKAARFmI/AZ330tohAkCiGgzl7uv6?=
 =?iso-8859-1?Q?3+GidnpMOI/+nPx5WsGzgRwXRczadcTADxPazF29MB9lyHcvbjbizdta5v?=
 =?iso-8859-1?Q?RzwaUpkAcYMEi/PRpkuVulXSExx1jCud+retmB+z+iJMpTrqg4FL9QKPxF?=
 =?iso-8859-1?Q?N1awXNZxyZKLV5GhyAyFsqGIz/+R5rKZgqn4llUIqSxcM3AQ3gkqcXbIX2?=
 =?iso-8859-1?Q?nTNafNdNR0Xrh1TT8IZ1C+SFx2/Lu1k+dTxid/69AeVJ5+SfDXb4tm4UUG?=
 =?iso-8859-1?Q?3HPansJVKagUxPruV2OMxRPQ4JSZ85l+wikbqY0kU6NmG6SaW05OAmYnu4?=
 =?iso-8859-1?Q?fnpmoksL6QrSuv+31wO6Ibky1+0Nxynz0QbgyeCHgRK+HaWVOrif3/HTU4?=
 =?iso-8859-1?Q?+TnLjgt+TmYw9Qw+APbfaRoeKldovvCEzlRbgDkbfJV2c1pyhdh3MTtreE?=
 =?iso-8859-1?Q?E1LETV1iLTeQlRKV8O9x1QJgXpXtSsF8jERQT7iiK1S/kIJ1UjQMpD/1G2?=
 =?iso-8859-1?Q?m3PCHxl3cmNsvcWfFKBKiTcB1/bu0+RYF1TaF1Po56wRMrrOmhECD2yBKO?=
 =?iso-8859-1?Q?ihNBaHwtTHZbuw4LQMrPQTYez+hbcl5NHwLdrvwdfuG4XKZAPagQh4Ch2T?=
 =?iso-8859-1?Q?/1efpFStWr2ewXFIEU8Bh0zzh2/O/SXssFNcHRW+QCbpSTO99F+GBYZXtp?=
 =?iso-8859-1?Q?oNIio9SW8bgc8MKZmnKckouCcmFBaVbFiQA+P7FWzFkylDLr392YxVs/dm?=
 =?iso-8859-1?Q?KEyqD+qFSMCAgiL1H+4khGv+hBdVhmoNF7LdoLsJvtHg25rfrp6v1A2uH6?=
 =?iso-8859-1?Q?WHz2l41feMMehpxCI6Pw+p5UUUKsFIaK7uWcAurTrGTmJCpuKcMsUvgO4c?=
 =?iso-8859-1?Q?CAYCMCZxgexu/SvWc93p83gK59vfEPXn58Detnpktqp/Gw7+sH7BJf4hJq?=
 =?iso-8859-1?Q?v4MYfjeMhvryYrzrM5IMu+bkwMtIaFdlRypozqQrychDVuea0+uf7Xt0X6?=
 =?iso-8859-1?Q?IT2sv62bFNd4sb6+LoFl2l/j1a2gLT9TrYM1CaeIhRxD8qHcRbCHwwpqlP?=
 =?iso-8859-1?Q?ciBNEQa4QZOXLEMYnulLVmt/ocf7c+NBXjmljuOZ8L3gMJAFxMx+GS8G+m?=
 =?iso-8859-1?Q?tDn1ACnhscva6e6M04yn6Yjve9E00wA0NN4Q6YiuTlVZbl6ruGwDYMYRPh?=
 =?iso-8859-1?Q?PD0JuSyqJa8xz2rYDH5XFRfRv1+YL5w=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3da969c2-3394-45c8-3e3d-08da53c766ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:14.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3rqbD6EkPup7Cz9vRjwoq1wH/MlDrn6dmevYwe9NZf5fYsw1GBrx4lVx5yYkxiD8VZlV9SGsii5YwiZWm3jWQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: D7nSM0wePXlD3pmGiJ8Cc0Ae3dnRYsGK
X-Proofpoint-GUID: D7nSM0wePXlD3pmGiJ8Cc0Ae3dnRYsGK
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

__vma_link_file() resolves the mapping from the file, if there is one.
Pass through the mapping and check the vm_file externally since most
places already have the required information and check of vm_file.

Link: https://lkml.kernel.org/r/20220504011345.662299-54-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 33 ++++++++++++++-------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2a73467670e7..52192408e6a5 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -246,6 +246,7 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (brk < min_brk)
 		goto out;
=20
+
 	/*
 	 * Check against rlimit here. If this check is done later after the test
 	 * of oldbrk with newbrk then it can escape the test and let the data
@@ -322,7 +323,6 @@ SYSCALL_DEFINE1(brk, unsigned long, brk)
 	if (populate)
 		mm_populate(oldbrk, newbrk - oldbrk);
 	return brk;
-
 out:
 	mmap_write_unlock(mm);
 	return origbrk;
@@ -454,21 +454,15 @@ static unsigned long count_vma_pages_range(struct mm_=
struct *mm,
 	return nr_pages;
 }
=20
-static void __vma_link_file(struct vm_area_struct *vma)
+static void __vma_link_file(struct vm_area_struct *vma,
+			    struct address_space *mapping)
 {
-	struct file *file;
-
-	file =3D vma->vm_file;
-	if (file) {
-		struct address_space *mapping =3D file->f_mapping;
-
-		if (vma->vm_flags & VM_SHARED)
-			mapping_allow_writable(mapping);
+	if (vma->vm_flags & VM_SHARED)
+		mapping_allow_writable(mapping);
=20
-		flush_dcache_mmap_lock(mapping);
-		vma_interval_tree_insert(vma, &mapping->i_mmap);
-		flush_dcache_mmap_unlock(mapping);
-	}
+	flush_dcache_mmap_lock(mapping);
+	vma_interval_tree_insert(vma, &mapping->i_mmap);
+	flush_dcache_mmap_unlock(mapping);
 }
=20
 /*
@@ -535,10 +529,11 @@ static int vma_link(struct mm_struct *mm, struct vm_a=
rea_struct *vma)
 	}
=20
 	vma_mas_store(vma, &mas);
-	__vma_link_file(vma);
=20
-	if (mapping)
+	if (mapping) {
+		__vma_link_file(vma, mapping);
 		i_mmap_unlock_write(mapping);
+	}
=20
 	mm->map_count++;
 	validate_mm(mm);
@@ -782,14 +777,14 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned=
 long start,
 			uprobe_munmap(next, next->vm_start, next->vm_end);
=20
 		i_mmap_lock_write(mapping);
-		if (insert) {
+		if (insert && insert->vm_file) {
 			/*
 			 * Put into interval tree now, so instantiated pages
 			 * are visible to arm/parisc __flush_dcache_page
 			 * throughout; but we cannot insert into address
 			 * space until vma start or end is updated.
 			 */
-			__vma_link_file(insert);
+			__vma_link_file(insert, insert->vm_file->f_mapping);
 		}
 	}
=20
@@ -3054,7 +3049,6 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	struct mm_struct *mm =3D current->mm;
 	validate_mm_mt(mm);
=20
-
 	/*
 	 * Check against address space limits by the changed size
 	 * Note: This happens *after* clearing old mappings in some code paths.
@@ -3112,6 +3106,7 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 		goto mas_store_fail;
=20
 	mm->map_count++;
+
 out:
 	perf_event_mmap(vma);
 	mm->total_vm +=3D len >> PAGE_SHIFT;
--=20
2.35.1
