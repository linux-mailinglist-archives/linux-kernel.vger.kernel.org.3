Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C3577339
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbiGQCra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbiGQCq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:46:56 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C5A193F8
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:46:55 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8fka009603;
        Sun, 17 Jul 2022 02:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=vq8RH40TsT9FQipIUvGj8/ajFSJ9oSCPJkoNaK7jglQ=;
 b=lIw6VGiebJv4rxPvQ75dkUHEQH3/gQyuh5TlrXkbecUqJO0DI+pQ7OjLl1riPpC+vU3f
 eVuevZbI+j6uvHiUwP1irN9qmtKjhZdIjuogosxtO5SbeXy+OjDniK824RoGf0/J6MSC
 FPHHtpLpcWzGoyyyiYmjJ/PZkPGxNDq9z4C4+Qta+TGy3ZIG5nYZFYkKFa+eMDDOod8I
 dpSsTIKj6Md3sEIMPDdIH42feVNfBoPVRexOh5Km/g49YrIuDBnNU+NdN9+5u6Xvqhgi
 ZO035pRyd8YIvdit4GiidOC7+XXJK9SI4vKVdMsTXZPyKzlwUR6yGVpox3sRj62iU1vF tw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkrc0yn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMYImW036151;
        Sun, 17 Jul 2022 02:46:45 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2104.outbound.protection.outlook.com [104.47.58.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1ejp63m-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVttVjv2zopl+Y7EELjJqrd919MStda3rtS9P47K/O0/NaIwgob84Dbf4loy7uGZrXAd6jpYM4yyIQTgPwkB2WbqjcQs1CpJhCEBlydj+PQ65ruy0JQKHGcuS/rg6rAe/yeOohy0zMlU1qFHUu3liHECiTLrPMnd3M0jjRNmaNUk43Snpm9c+uJJl8M4+jPd8tXOgHXNW0/I8slGAx0E0qHCvfrz2GoOEcD1eClBI+dRbO4ZYrtQ1/q1iwpopm1fmMWf/SQD5Vi4K8GrABO7Wjecxt0Kt/Tnud97sM9MmJLgBovGWCiW4RuMUHHJ2FiuvDxW9PKSWInjVLMasmvDBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq8RH40TsT9FQipIUvGj8/ajFSJ9oSCPJkoNaK7jglQ=;
 b=jBIw86E8UfprEkMnsssD8oa8pB06K5kIAJ+D8mPoGusUG9GudinDOJYmV6H4uC/PUVp6UdHXPKjVX6h74H+ZW8A+8+yrUDeBq5ucVLvME/DrYNuhidgiauA+X8kdzAeQOV0xBmuXFBobWpr7b2a8fuOlWKd6pq1foxtgcFEK6rF3j0kx71nYQKj+EodGlcKT/LgTrgJHqrBDt09kpZ0GWN9wWVgOYXRH9a37ihvoYdeJEVo7xDK6+lutLCMJVEVoYLvwFz1GX73XVibIwqpqkhzxcs1NxycyzkCjby28xA8226ZuITOAg4rA3zJNbLBk0LKHgFkkzmWuATqLTAVg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq8RH40TsT9FQipIUvGj8/ajFSJ9oSCPJkoNaK7jglQ=;
 b=g0RlacVJkjYtMOWOS4W3JMhXKFs6VgAGnkLnE3AWYnhcJJAtUtnyxpdJWqwWlKbNk5FuGATTM2E/8PSvO+cZ4Py0QwVOcXUCL1KYkqol9Nzj7XWiteWk01s/XzzIHZXaHoil2Rkt3m2Yn0A0zq+uMeX+uXG+YmhIYjDRHo8JBhQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:43 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:43 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 14/69] kernel/fork: use maple tree for dup_mmap() during
 forking
Thread-Topic: [PATCH v11 14/69] kernel/fork: use maple tree for dup_mmap()
 during forking
Thread-Index: AQHYmYdxJocTMfjFnU+bq7zgcKwyFA==
Date:   Sun, 17 Jul 2022 02:46:41 +0000
Message-ID: <20220717024615.2106835-15-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ab3d3e4-62e7-4670-6f56-08da679e958a
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DP3jKjokseCxAl5zqFXLmU7lOER3r/Ca62LXjuQXs6cwVnoy2Gth08JjQH8X6C7w0JruMb5V3bD8RdhkZaBSY3IVZP32TWAcTfIMP3xv5iui065uwtr4nwN0ziFHLqm1pRszdhp1vL181gUphDfYJMc0M0VlLljLiP06mWcueJa6fLYezMyKOKv7gwBHN5UC0w6M9ENy6tQ8slWVU79nq7L5BifkjQ93a66eCxoct6c4fq2eIDD5UGY4CaKKDpnms6TqfL90mcfSVZc/39o5YsjYKVrP6tagLZJ5GdF8KpKpLGxqpgNp8G43S3zaB/WfUL5l6c7Sml9sMbiRv7uM60Q5IRzWpwh8acUBkRXHVAjP/PM55XF4krTQvjMDPEhrMo+tUJ8V44LUr84aXeUzqFI5t4YuXurtwat9HjYdzJ1QlGq67GyS/KuQYNMa3vpNu6RKay63fsOEN2x7HDCn9WrvcchpsCi7gt7eabaA4X4Por18NqkYnCCoP9qHytLrr1ChXLWnaKZ9utaKK5PYe3XJqY+VBT6aki8bxKketFDqeBwmGMPK2qvQdbIxnCKd/Hsilr6zULT3o2WvOCZmn2Ju/a40b7NVeN9SbKSkNjBma43ChKGMdKthhEsy3OUiIizQPFgalFnF6ng5dnpZnYoyDwt4zo/Z6CzEsvkYlLkX3AlXIqmgm0hFOr5T9tdDRMu/O+bQw/65tBQCPNm7dNFaBWjN+tCjKgFgD087r3Riz8BItmszQGfRyvajgGffnRnPySYGxCu2imJKbQgajHcutuxfHnP31GmnmvRbBGr6S2sjBb0LVvJlAzW+1P7B/hA8lGysnB01BIxd5mNm3BY4XQkqojVFc9Q8FpQ0DfnGfxrUwf5KJaWmPkrgP6zluV8JqjkZ66780f7CSEYsiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?dzs1HbWMSxrp7Osw4VxgXcm4lfXIB5qFzLRTiqqVAD0xNIbQziKHBCyPk8?=
 =?iso-8859-1?Q?abnurRdeBBSnG3cn+f3t2QBHzZSTOFoOizwx8f+gh/MWe8UTCfFedOyZNT?=
 =?iso-8859-1?Q?1lcxkIpY3hZuLiUSsEhcxHk3mYqUwA54tDdSPhqG2dO0CRxLlt/p8lgHl4?=
 =?iso-8859-1?Q?WBQmT4cZ9vLP8+FXCe59uhQcvgHrp9AiBv/QyCDgUoHH+UichnJlwRp9cB?=
 =?iso-8859-1?Q?DMsr018HBGaH8DoGeFk4F/Hd2tm1iVw/qFANueHy2wrJYdspOKKK2erUqA?=
 =?iso-8859-1?Q?HDWV1lZhl5wk6QL//LUzJ3TjBNDF55oxFWGDjxprNLp/aOkVpHlhg0KZqv?=
 =?iso-8859-1?Q?s8x691ANd6MQJgfqnTpQWEaoFrLaa3cCuRF83+CnDUOglJKF4ZC2hh/I0r?=
 =?iso-8859-1?Q?m7XpjTMUbpqv34EpwuBY4YZit0Ggwwuyq9O2SsUw5gB5l/3NSmIYf5D+fQ?=
 =?iso-8859-1?Q?ylyMjVy1uwFwYHyP9RYkQ+g2pj+UI0OCDCEOw6GvfGszldO2aZhhYefx1/?=
 =?iso-8859-1?Q?8u98gv4IZowgpZDWr9DUs5W9XosNbCRk1yh91w+eGoOaDKAXjiWUU8Py/E?=
 =?iso-8859-1?Q?IkUJKjn9SbbCmQbVjiGhonPBCAmMOCXknjLzkC/5oesgfRF6Gz1rQw48Uo?=
 =?iso-8859-1?Q?3c5r1Hf0VNIOXcEh0PU1kM+m2kWuihU+DRAQ0p+aLQOdfubARB0eL0HqDx?=
 =?iso-8859-1?Q?ZbFmX3WJ46nmchemKc0lzqbXeVX5wcm1C/jrcBgULUuOzhf3VMDoYAEsTR?=
 =?iso-8859-1?Q?ahPX509k2D8LRxXX9DQhA2ro61B5vK8bnNK0Hd8+f7zHXtHLNdzG/HiD8i?=
 =?iso-8859-1?Q?sFVbeakxh1qq/PygBSFRNmgDyep/72Y8D8+ivO1A7NgEMjpIF67iQwZVdi?=
 =?iso-8859-1?Q?pRWuOg+6HNsqb7aSd0ytBcEcWCOFqCnYUejoJgopxqABUHzTtq+4iCyNug?=
 =?iso-8859-1?Q?bTDDu5u272hHXkcxxcYlNcIHHlZmiggi3wC8W6eXgHi7pcio1/vEYpcyz4?=
 =?iso-8859-1?Q?BxWCibRTc8FbT7METJjNP2PBUD3eyzv4jpoaEr/9tVe/TZ78+3Y6w65E5M?=
 =?iso-8859-1?Q?Q0S/vojFFAghM22mHnou7l0s2TaWEc3NnqYSFJY3Y2vLU9srq50oZxMJZg?=
 =?iso-8859-1?Q?zOTHZNHU/JmsL4OLGGpRFFtB3QoAnp3Y8sVXweeyeMRghiow6YM2SeuW3c?=
 =?iso-8859-1?Q?yV3AksWaZdlEztpkjDyxCJP9M1AMGqyrX5Qh54aDpQFcx5bVDU09E1jriN?=
 =?iso-8859-1?Q?vzOUOkdKq3OoNPqz5x0LT222FoQ0Z6EIF89vbXmJXkROb2FN0JIrSgd5ot?=
 =?iso-8859-1?Q?847DcXjvSX9F/mVTH195+VTDGw4sf3VzTiIMxM4HoxwRWAfVN4SR1NR40a?=
 =?iso-8859-1?Q?k6qgCFk8ApOtCbFBj8lW2qQoZgCcUBpWi7a2lLTSOh+n8LdhMHxDyvar5u?=
 =?iso-8859-1?Q?e/mRjf1uUxbE/3b1BOjBJRpXFxpRkY5tEfwwFkAHw/FvgymPgCyxhBDtVM?=
 =?iso-8859-1?Q?tPRXpectjDsCHHj7veMvMj7famvWKjF5FXt4eh5nybgpE98PNOE68bL+wU?=
 =?iso-8859-1?Q?SyWnHgW4+Y5CoSLfhd3XmnIgRg8SdlYhyGlUMVvPaDOZjB2uBlUKadXPLs?=
 =?iso-8859-1?Q?rgHdS7OXa29s6wclabCTcVkaLW5HAuZJ76TzytfLGGJq0dhPMSf6eCzA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab3d3e4-62e7-4670-6f56-08da679e958a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:41.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvSM9WKfQVoZOWjJ+17npajZT2UO8IwUdACCYrwA2va853vSLnG0Zv9SaO/TgkQXY4TnRbf/dcnSGVURQbdxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: i56D8crtJluG5__5i6jWbPMts1VYPxbw
X-Proofpoint-ORIG-GUID: i56D8crtJluG5__5i6jWbPMts1VYPxbw
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

Link: https://lkml.kernel.org/r/20220504010716.661115-16-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-15-Liam.Howlett@orac=
le.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/mm.h |  2 --
 kernel/fork.c      | 10 ++++++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index dee609fe5c1f..60045508a518 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2613,8 +2613,6 @@ extern bool arch_has_descending_max_zone_pfns(void);
 /* nommu.c */
 extern atomic_long_t mmap_pages_allocated;
 extern int nommu_shrink_inode_mappings(struct inode *, size_t, size_t);
-/* mmap.c */
-void vma_mas_store(struct vm_area_struct *vma, struct ma_state *mas);
=20
 /* interval_tree.c */
 void vma_interval_tree_insert(struct vm_area_struct *node,
diff --git a/kernel/fork.c b/kernel/fork.c
index 1840da0732f6..f575a3bead0e 100644
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
--=20
2.35.1
