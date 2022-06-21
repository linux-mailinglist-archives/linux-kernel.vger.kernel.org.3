Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22257553C09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354693AbiFUUyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354885AbiFUUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:51:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4312FE43
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:56 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJHFMM012606;
        Tue, 21 Jun 2022 20:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=tbDOzUiDaNSGpLZO+gIClTGGJo5bsfj661OsuBSx7Zc=;
 b=Jy70p34hfxp7nW2MIwrpL0XOyPmPwVSv9dVKszju6u9ZB3ILQWEzcl+FaJnQd+6BQIp/
 h1tTdQELY3x2XoogRFBVhAWhxynbBvkGQ8XxVx83Zp2oTJ9hCvIeqB9GIb9DYyyovI3l
 MhwALHSxKYXsIwk6BuTDzb5aytmkfs8vaJ3tznn/OTKZ/Kmt+RpJiPiuWyz8uiLg9bM1
 k+xF8Eyx+Kph02XNB9WYbdzdMoT4zcPFaEflCVmheGFlj7Nk5CJ9T8jHxIp9hkOZ0jxF
 OJluhOuiWH1RY8YxtTFdtTeSh2tG+936jMRRU/ATcJp9dTc2WdaiHrn4zzbaUWYVZWkl iQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs6kf6kkc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:46 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdwkT010169;
        Tue, 21 Jun 2022 20:48:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvv7n-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7UAuz0MleWPKyiMNZQZa39eO3VMjoeNvafymI9zQ6zm7YPrjnog3O3RiD27yo16KYzUGEdHwrwXivaZNvmOOwGajiO3tuSPUW31YyyK12bKrQQXni77g1C0mCFG1/X+pZatG0Ikqnh7rcZxLZRrNzPSnt7g8yU//CDbvSi8SQOm0I4SiBuVO9zkzhC+UCVV5QVTOhKSkaaoL83KGNK2M9pVmQdJZHFRKAjx4OgUyf/a+eDVClnmByp9e9Vvsi6k08+VtWR85T9vdxU4GFEBbHcqbrBin9WZ9LCneMJbFdZB0g6hOlE+BwLNAfl+3T6wKie3mGAe36qBLAAYMLN9CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tbDOzUiDaNSGpLZO+gIClTGGJo5bsfj661OsuBSx7Zc=;
 b=bHn4Lnyzd1Ynu/DwNAP482DwTvvS3j6chqpf36wpKDgM/YgNz19KgXMumqEpf+k3UOlr2zzD2d3eQKBBjCT0v9TaMm9mHT0BNq8F+rwlE4+cbOhiEaeDb4Bb/Z7c5DdUZkM1T15l0en7aabB5OX+fQeTe9zzwvGg6nMFEP2drZ0RnWSFQ4zl57dc1mprY8zpesG1z133p6mi7Wf6Fgl4T4pGIRMmLZt8SJflvZTwvHmO6UiWM9zTUMEEbPGzFYOw4NDmzarLgXHGzleztMIZDlJro5ojgyjsodVW/QcIxp9TvjnzgbrrzH7fz2SiDND94yYFDZCqfFkYtJ/SRqzirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tbDOzUiDaNSGpLZO+gIClTGGJo5bsfj661OsuBSx7Zc=;
 b=ZwnOTrcToeydVGO+jzA1hQWZPhFpFhPO8vh2l2boJeg8HOaOwcklrJT0UoWBkOYH5c4SNX0RAZXkWBSM/l5v6DQ+KBaCyT6Bouqa+ighwThMz9VOM/flz1qGiQ64RvpT2u1LT/haoiGzm46dY9IHp+tCVC4pSGpIEPTsNE6fGpA=
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
Subject: [PATCH v10 68/69] mm/mmap: drop range_has_overlap() function
Thread-Topic: [PATCH v10 68/69] mm/mmap: drop range_has_overlap() function
Thread-Index: AQHYhbAWuXAUjaJmkECqTvbxhyfcKg==
Date:   Tue, 21 Jun 2022 20:47:14 +0000
Message-ID: <20220621204632.3370049-69-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 100fc710-bf76-4880-441f-08da53c766a2
x-ms-traffictypediagnostic: MN2PR10MB3869:EE_
x-microsoft-antispam-prvs: <MN2PR10MB3869A2AA74C8D5BE4FBE2A80FDB39@MN2PR10MB3869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /nmmpMVijypDpTdqvqjH4BoJXX1QjJzVye5sVLMXVWPKiikUdysiwZTw3gjW+UK/Ug4R5pMohOV8Opgel78U2Zko9fNzvNhrIABhaIr5jhd2kEMJQ+Flfvyfgk3sVGRxu2Cb9fDpDdTysUFT42hqrpGJmmTWu57/P447RxpT05snEsi2mUiLRZcKnRxCz03hjk+F3i2vQVYgEFJK+KROUaD2srCSYVnsN8iZjEaDvTtsHkNcIq4LgGy7wE7XwMG6vrMrQ2DqVtXHZCygwKQtLV3vCCE+sX5pg+lSLQpUd5yHlzZ63pH2tKY/uGEyzBfkQ3V/copo458SdHxwla/LW9oHs2JGw4Bdw/EX2quN+aOXUUdQ9bYTuQU75eOq6ZXBxJLVUtk8+t+FA2Qf1Or96vSI7U6+zILPU6d+nTLTtdPzCyLBPOw2oyMG9XfT9JY5ifafyH39tIWK9qPwV3lex7VrtYkEcL0c3nM276vLEveit+SSjTzKVMvlBtSlgDzF4wwQMEpMrAm9YjuFfqY+NDEkcvvweU3kWojNP88dGDbgAqQXpRO0D+f299XcZkZosOde42yKZBkjL3G/kuzZhSWu6IQb2lK7R9IBaVR+vONxHC3Pm944gf1Bx45kznasA+oz8dEQyToTCfOkZBNIk1XjQSTpfSJYXd0fMGW1l/f+E8WL/YCJpm86ZqwW8vLgdeRkXhWGex1yGKj0f51bpbqOUBiGyjX+O3b/3202w24Es5StO9vaB1Yrc89uq+9M69L0rQhPpdb5dkcE7Hlh4d34UuyAmToiTP9hBG3vWHo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(26005)(6666004)(2616005)(966005)(91956017)(6512007)(6506007)(186003)(41300700001)(1076003)(122000001)(83380400001)(38100700002)(44832011)(86362001)(8676002)(66556008)(66476007)(38070700005)(5660300002)(316002)(2906002)(110136005)(66946007)(71200400001)(66446008)(6486002)(36756003)(478600001)(8936002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4eMXH2UOPubKk8Kxcq/XC1eASKBgouzItRrf2tm/iNkkksIkYXhLiVsNjt?=
 =?iso-8859-1?Q?rJmv08rfSRFsB5oM4mEExsqjdYOP72cijjT4S9MSWXooMrLrZV0eYJZBfa?=
 =?iso-8859-1?Q?uTfzMwUUiSsbXa+y9a3H2oCcR+DdO6b2KgTjRxt1E8SQo1ejwEk+Tlp4qZ?=
 =?iso-8859-1?Q?Za7yejKvY86/jT8t6K5OQtlVtYNd9yigCapdowQ2WzNY3P+vKqWTc2oy6i?=
 =?iso-8859-1?Q?rqKoMtJo0O+AAQ2opd3InEgh/a1TRpipJbrUxg2tJPY+4BuY+mygeAoajK?=
 =?iso-8859-1?Q?o40VojHODzfChOAGra1uG2/SzhvtCuKRmQCQxqknepcSEIsZLVswe6Cw2n?=
 =?iso-8859-1?Q?ByeuFGwYjvcrqihWZ+Wfjzg8KLKXrbr2YIzUpeeOYvRNAAwuKgxhAJSpIa?=
 =?iso-8859-1?Q?AjpNIKC/bnQLwOMZlfGdHs3do8RdIgN1faK4MqHEJNiSGBqxlfSnjIfbu1?=
 =?iso-8859-1?Q?T4GzlBPsMyUDzfYLHsiMVRz3yz4W9vwMyyZ2zL9Qqyg3s9Ea9wSuKaY/BJ?=
 =?iso-8859-1?Q?iJb32LW7L7pM79NSbvzoNPLhDBi1TJV1MpUAP6bcBnjuAJmAe/8U2OyQYo?=
 =?iso-8859-1?Q?gnSr+gj30uinwqisIeOkaLvKSFQ+/7kSTyDBRTbsHWWPMSKiYzp0J9Bc9w?=
 =?iso-8859-1?Q?mvle403wF2tQxOSTm7KfX4C5vwDRxyjt7dMiYtXGjpRKV9f8//5Giba45j?=
 =?iso-8859-1?Q?kddPxgEceh9R3GrDd315RDkQK2twEQvsjDFrXG2hAqbsM+lTQW1b6NGBi4?=
 =?iso-8859-1?Q?ZJHc914elk4Yab9U5HZlC3mkGHpHwQ8QpZBLccrC0dPDrDjHv4lFJy9k9r?=
 =?iso-8859-1?Q?3L4txAGc2rL1jXRLYZ/tQpSeo2G49mi4Of7e7e+wKUi4McP3S8v3IiEywV?=
 =?iso-8859-1?Q?31iHhXtzyteMag+XKFEh03Fu72O2izlI9RayBAwHH97WNj0ypdlrtGZW6B?=
 =?iso-8859-1?Q?+z3TjpKFSsqikHH10tEX3Axm5b5fPuqJ5grx+Wu6U+wAfLfulgQ2K6XFON?=
 =?iso-8859-1?Q?FoefiO2rtVxL5aW18Ph7L+FpV4TUx4P3auukJ7c7fqWxfHDC41gz6/1eLs?=
 =?iso-8859-1?Q?C5TQy0HUAXloTZ13tFcNtcNukh5X9+uMd3J6LQG5VzejYUxr3EM1OWNzsZ?=
 =?iso-8859-1?Q?oXtYcPBBEgOs/I7otRWaKoYI+yRCj1IQaOI5jQMLNc2LlqcG9OcvNgXtTg?=
 =?iso-8859-1?Q?n0/T5OzMXBGCdCfYK7RaEAUN1hGggKOCEHmwQEGO2rARmHsqBH8srTkeJO?=
 =?iso-8859-1?Q?dDuOjyZB6ZoWjVZcHrOb72asTmENfBNioNs1V1FH1xhzFCvrMk3+dVi/84?=
 =?iso-8859-1?Q?shdazdwkLALTn5GytTlWKkAj9AjiqFjXwZlbsZxPlWcHmKsWzWEkMU7J2G?=
 =?iso-8859-1?Q?hL8xtUE4j83hBRBkYwcqSKI+DFlpm+zMIMfPlh8rZZUoWdvnUE9G7SwoBd?=
 =?iso-8859-1?Q?uLfbwZ18CEdov4D58pt33KRiVh9NTgRm43doZG3P3BB4O14sJtN7l7bTBE?=
 =?iso-8859-1?Q?UKGb3NbsaLCH0ezMdQmpFoigt511QRDSX7OPsJyMIOSnMMVcWf/XTxQ9rU?=
 =?iso-8859-1?Q?R6picV4ZmmpDrvkUYLjiXcSaM2j/cnodyRj7HpBWt9ELI9SECYRuaCiq3P?=
 =?iso-8859-1?Q?6sr19SaqIiYvPo5ujcSDEfPPoYsjoQLsa93w9h1rqc21HeMGK1qnjuFqoM?=
 =?iso-8859-1?Q?NDi+F59O42m0EWJDP5bO+eUQt5evSG8UuirYT/WLeuR8CKy43cRYUfyxeA?=
 =?iso-8859-1?Q?Vkm0eveuytB8NGg38dEMxYQ6VzGQRenhAZIhnF7InOkn4JsjbjlIiXuioT?=
 =?iso-8859-1?Q?ThQeTqXAT2ed+mGukJ67iKozTak0tY0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100fc710-bf76-4880-441f-08da53c766a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:14.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XvSvVzVRvi7GVRmp5TNrtecqux7S6GwcO2VrAQXEyyF2kxAhGmUOoqk+UdkAYWG2RFqMg2QH+bhSknWYpjIoMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-ORIG-GUID: LFrBc2HtaboVNbyTKB2jQi2gXdncosCK
X-Proofpoint-GUID: LFrBc2HtaboVNbyTKB2jQi2gXdncosCK
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

Since there is no longer a linked list, the range_has_overlap() function
is identical to the find_vma_intersection() function.

Link: https://lkml.kernel.org/r/20220504011345.662299-53-Liam.Howlett@oracl=
e.com
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/mmap.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 507efa222b8a..2a73467670e7 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -437,30 +437,6 @@ anon_vma_interval_tree_post_update_vma(struct vm_area_=
struct *vma)
 		anon_vma_interval_tree_insert(avc, &avc->anon_vma->rb_root);
 }
=20
-/*
- * range_has_overlap() - Check the @start - @end range for overlapping VMA=
s and
- * sets up a pointer to the previous VMA
- * @mm: the mm struct
- * @start: the start address of the range
- * @end: the end address of the range
- * @pprev: the pointer to the pointer of the previous VMA
- *
- * Returns: True if there is an overlapping VMA, false otherwise
- */
-static inline
-bool range_has_overlap(struct mm_struct *mm, unsigned long start,
-		       unsigned long end, struct vm_area_struct **pprev)
-{
-	struct vm_area_struct *existing;
-
-	MA_STATE(mas, &mm->mm_mt, start, start);
-	rcu_read_lock();
-	existing =3D mas_find(&mas, end - 1);
-	*pprev =3D mas_prev(&mas, 0);
-	rcu_read_unlock();
-	return existing ? true : false;
-}
-
 static unsigned long count_vma_pages_range(struct mm_struct *mm,
 		unsigned long addr, unsigned long end)
 {
@@ -3287,9 +3263,7 @@ void exit_mmap(struct mm_struct *mm)
  */
 int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	struct vm_area_struct *prev;
-
-	if (range_has_overlap(mm, vma->vm_start, vma->vm_end, &prev))
+	if (find_vma_intersection(mm, vma->vm_start, vma->vm_end))
 		return -ENOMEM;
=20
 	if ((vma->vm_flags & VM_ACCOUNT) &&
--=20
2.35.1
