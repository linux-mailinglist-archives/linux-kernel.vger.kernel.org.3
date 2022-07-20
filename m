Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED2457ADA5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238881AbiGTCSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237609AbiGTCSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:18:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33E7558DB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:18:00 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1lw0A003839;
        Wed, 20 Jul 2022 02:17:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=jKKC1l1afGoEblTBUmPW0FIKqOql5Q+Bhh7Xpn1mvtw=;
 b=Q90hbSgv1xxpUiUWbtrRb6sA14Sv/yBLMgiyZuCaaTCaxToGNpu17wzWF+Q8NVQoFid5
 8jeG8vIr9tdjCHRygXoqtr8o5S4HC/dDhUU1roZIy1/7u3t1uYp3JDweL0ZaFiB3kh/s
 XE9errTY5fUx4Vj5WB/iZ4EA9fRrzP39p4LubY1XdYg7C+dbIt/x26DSkVmQ5Cv/OhMK
 s+ipxJhSaCaIqYVIa2yHlkjId69Ithb2LdZ0nwJuxH2JpmfyN1Ts7tolC604dku8z1dn
 NU5opEAbOQBCIjbuBaCQDhmKKivx0AQ57XwE2Cjxr4nR6mOWGI+V6gwVnBZBRSEBj+H7 sg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbmxs83k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:54 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26JNHLL2022321;
        Wed, 20 Jul 2022 02:17:54 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1hseann-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHRFVgMJa2zlXClLyXjgz0IfpG2mRv0ZOB0cFM69VNJ6Rkc6H0qo6s82E0784Gn4GSRNR2yi7KXEuaRt1UlPYskt56q0F8WPbPOB658AclahrkuLyiOG6naPZKV7j6J3hXO+it/AhCFUenl2nmTMH/s4JD/a4H6MVIPwNtp+pqkxsiC0MVUerjbwwn23Jdu1h1MMm4AxhJ9n3iWxDahDWidniXw5jNsqrSE1Z2JuxsAXG+LmC9SgCZ+R+hZqlTNps7DT7qT4PRkMHd8k1OR8D6tLBEgqzBwBplBmIUBhuaNdGgqqmMES4+lsQGLktcjVF2tOWBxtCMkdEYXVYdQC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jKKC1l1afGoEblTBUmPW0FIKqOql5Q+Bhh7Xpn1mvtw=;
 b=YjFHWRztyoHUA1QqfCrguCoUKdpZqYnHsTynvpFLANmilYHgMlVGUTrgI7bpcvfmuE/p6Lr1XvIWOR3eKKTMDBm3/ntfLUFPGGVyVScHMlpAq+UJLI7qHcKIoiuCf+OMeR1X0AjY25EnJxoiK4KhAzVso+Yatpjf4gtBHta8cZRK3PZh8WbzokSVnkIftin1l3CdNO6Z8msJB/Z4XiKvQIGQ5q2Pbzdk2HfP9FdyQY42Fs6xAzA5e6DE4RtWBEiVr+89QEH7Rbu5sP/mYSqjxTTL9v85lKClxJwna5reyjdIDp9A8QRVzDvQjIybARu4XXRQZvg+QaHFucAcJFk3Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jKKC1l1afGoEblTBUmPW0FIKqOql5Q+Bhh7Xpn1mvtw=;
 b=OQYvwnmmZX7tGRKv7keVSnyQ9YuWcAZqtgHQVUtjabv3wv1/yw3WNHCyRBx1upFL1vxHDHS7pXhZNMn7+Gm5Z1w1wg4T3hj09WZ6smOiF84RzhZadd9poIfpZMmC2/g7cDruwntPJJRwrZwcYX6EqFs1Yd1QTeazAW2LhRVVPhc=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA1PR10MB6243.namprd10.prod.outlook.com (2603:10b6:208:3a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 20 Jul
 2022 02:17:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 15/69] damon: convert __damon_va_three_regions to use the
 VMA iterator
Thread-Topic: [PATCH v12 15/69] damon: convert __damon_va_three_regions to use
 the VMA iterator
Thread-Index: AQHYm97npTngzNdCRUamejVdhcDZ/A==
Date:   Wed, 20 Jul 2022 02:17:48 +0000
Message-ID: <20220720021727.17018-16-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85099c23-32f1-4169-0299-08da69f60c05
x-ms-traffictypediagnostic: IA1PR10MB6243:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oszZTQtIy9rOZtlejX2jQvIqJQ+5LDPvd8w0byE4KQaylZ2wRbLC5BhgkMDKjuOPuTEfNjGoAszITlZfKCscG1kW8he9y52j2y25v6fbb1VH5u6P6KkGsnAebOPsYYFyGgy1IP5tjBpAJK2nne1POj7sVIqidgZHYjMmZl70gqTlIWRnU49jpLFMGNctowSp9TebzP6T/+JUoGCPKMmCqR3NutPZYRFXIpBJpWMIjPdl9e/OYST9Fq6UfjznP0I3WzwP9Gwr01c7rt2FJl1xWDuajiCv3/CosJCFyOPUU4+cG0/hN0ikw5zUcO8C9OVkDMIk5nIvJusmUm+OyGKXmcyTZ+fdPzTUn8mizMrchpJ6Km8s1TBH210dCfHKnUYx0zqgJohQ+Hb+0ba6f9zbY7gcG4jJqQRqLp3lqT0Y73ioozLTHhEOONLPi0bkeQQwsnjB2wJZwo2UyQiomL+JpiZeAvU9ExX777cUcOpQ9HqxzA9Rli+CVfwX9BFb97yOTKSnIM7Mza+fXFpSYnIiy91iv6VznsaxQVQuZsXdKljXJqTOkafFjOrysIL8JkEFf+21+qn6hxGXGmr/sTu7/nkwlEZF8WB65n60nXsFlf0ZSaSciRbTZMtulTVEJTjSO9VHXxBeSfaozRBeXv5FNnpkUYcHMNjHhPEqspnGMB2XhhaAyWYvqRRemKRJeNt5ARm8QaY4OOmllzDmELIl/a0GuGMsTTCxvBrtNmQ97mSQok7YFAKCQ2v1eKnsT2PLj8o0VIU4yYhL7YVBrKuW0uCQIjQDHlVa8qYAPnNHimh3hjGlgnvm6tbylUCouGx3wXvKjTEtbDzkmz5Wy+SX+BRqyO36OrTNhvmQbZaV9Ioc0by59KPjJQx7AXDPhI+W
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(366004)(136003)(346002)(2906002)(26005)(1076003)(6486002)(91956017)(8676002)(71200400001)(86362001)(8936002)(5660300002)(38100700002)(83380400001)(66476007)(6512007)(36756003)(122000001)(966005)(38070700005)(316002)(478600001)(44832011)(4326008)(64756008)(66946007)(76116006)(186003)(6666004)(66556008)(110136005)(66446008)(6506007)(41300700001)(2616005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9o5cSj56i/jB3sXUHfUWDBb7F/W2ESk8/28/V9+9OpvKP/GDDUplZ6lEAp?=
 =?iso-8859-1?Q?EKS36/OTiwLLQp2NWUEARWGcOkaqtxstOCBQVm8/FNr5em6x2+tWjbpOcQ?=
 =?iso-8859-1?Q?F802uLk6vGCy1yif8oZx79mFsIQvxl8q8B262xB6c3wupBPQYwnP5vx7M6?=
 =?iso-8859-1?Q?Y4wFS9ner4bbdIIjkWxJ1NwQoRf5cmGTEJ5P5ICvUYoEZXMT8GYE8zXK8e?=
 =?iso-8859-1?Q?2yBnOl+KWl4UQPiuVBex08F8qbL8PaBSVNivfel5JRryOA6qYgvKxnT5ml?=
 =?iso-8859-1?Q?+pFeuNt19PjdhBXXrh5gtAx1q4GmIa4QkaNA5o2Dni5kknHn1PcoPplp2p?=
 =?iso-8859-1?Q?89Mt8bCfTrFARDuA+g1QApw4z0FvrFrzUYiZuExEdQ0/hqCsvMWUM78Kgm?=
 =?iso-8859-1?Q?k9yckXGuk08XmSzdKNElOaMXsgQrKdWrgNhpS9b/iS466T/v1kHm6VWB7y?=
 =?iso-8859-1?Q?E/BDofDknDigslU/hlJGAhFOqZzBgTsGKYlvUxd+5chvuRe3pPj1pD8whK?=
 =?iso-8859-1?Q?OnaBHNQthNptW0/zxdBG8OJFpA5l9F+fJjxraShis+petEyVh3S4gGWhmp?=
 =?iso-8859-1?Q?T0DIDKWamQ6r+bCVyGO4rAvWl52NN3/1BVj9Y0CFzsmZ7tf3mt/T6OQ0d1?=
 =?iso-8859-1?Q?7BM6ERkFAuQ8pwtdvUfJ8QugimnYS0BI71JjE5+1MUu8c/eidrkwhv3Lku?=
 =?iso-8859-1?Q?MZJO471zZhct26CnuXmFsqJnsz+jqnba5DI6S3h+TiesiVBqHcdzt4YJwJ?=
 =?iso-8859-1?Q?WqhQVRflYIsXKDyuO2NFeYd3aU5cmwYAqleZ9zT+nRNA3hfSZ41eiRB/Ye?=
 =?iso-8859-1?Q?Zd1baqHhsdArw9bh3RrqXRkBKdmMmsAECah+y/mbk7vRo1AySs9E33QV0X?=
 =?iso-8859-1?Q?0R7+SLAkRVrw815ngA6SBJXvB6SG0PUDGJKqsJg1qr78/3JKHv4BUYO7Wi?=
 =?iso-8859-1?Q?YHFTBMCfmPqA1BTsi6ugb/dlWeMsrTxdKD7BGitJvYlqFzgLDCB2QOXx1X?=
 =?iso-8859-1?Q?OFLodq4nVVyrpbooPmON7SURNJA4f6QYQZ7bkMAeNSwE3IOuMIW1P/bq1c?=
 =?iso-8859-1?Q?uWQ2mvbXwc71FJ3kxcOiGdYY9dhTDnmB1V9fTqxSKh4vAwTYPSAOAYFXNT?=
 =?iso-8859-1?Q?I1SMWDU1xJEUUDKdiKYpSMMYPbkTSRBaCVlDaKDoThVbA7I46V5w6cfSpt?=
 =?iso-8859-1?Q?MQSkMfb6/ElJ5uZ/SEkf1R6o7+xFjGMG/iYc9ROayw0pSl2P+9/pXmhXnN?=
 =?iso-8859-1?Q?q0bpfxkj8vvHC4RJIo1+5lFuAhrZNB6ZUbR1d6qwkN8bkv/R7x09LBar8X?=
 =?iso-8859-1?Q?/5LmTpLKmRKceHnj/XEHlVqiNLllrEBNfQ4/1SGTDRaCzBFOAq+TZMCmQd?=
 =?iso-8859-1?Q?Ai07EffAbJ9ssxYG2KkVBbEMqggRoQ+yVeLTnoeJyegjx6MzxAeKXR3kpV?=
 =?iso-8859-1?Q?Sv2GG/SL9DQGJe1SeWASKSseacXteFfRhSI7ype5qMN0v7VaDpssAi1du/?=
 =?iso-8859-1?Q?cXFkGEEK9XIa94Hm9Jvg2R3OQDNJ0KhGU6l+I0fLlNR4AbTAM+TfyixRAV?=
 =?iso-8859-1?Q?UxpPqY5jmFCDCy2HnfHShVZ4QpA+po7O46cfv9Qu5ZZRKvCLKrZA4vdwlj?=
 =?iso-8859-1?Q?PQWaJe5a09PbygoVC6SKG5zQPqKOsZhjKKBD3+RvUmWZ4KXCL6X+PoBg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85099c23-32f1-4169-0299-08da69f60c05
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:48.4937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UX6CL22yRgFXsnhxNy684Pjlv9hP4ixxZ9rIGc3j4oNA5zzSBt/dc1Uvh6c/N6YLO6T3q0y16H7bMnDPCI9XSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6243
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 phishscore=0 mlxlogscore=939 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-GUID: 7gQ4jz_pJMOaJJgnvV5UjC-4Ye1x4tS7
X-Proofpoint-ORIG-GUID: 7gQ4jz_pJMOaJJgnvV5UjC-4Ye1x4tS7
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

This rather specialised walk can use the VMA iterator.  If this proves to
be too slow, we can write a custom routine to find the two largest gaps,
but it will be somewhat complicated, so let's see if we need it first.

Update the kunit test case to use the maple tree.  This also fixes an
issue with the kunit testcase not adding the last VMA to the list.

Link: https://lkml.kernel.org/r/20220504011215.661968-1-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-16-Liam.Howlett@orac=
le.com
Fixes: 17ccae8bb5c9 (mm/damon: add kunit tests)
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/damon/vaddr-test.h | 36 ++++++++++-------------------
 mm/damon/vaddr.c      | 53 ++++++++++++++++++++++---------------------
 2 files changed, 39 insertions(+), 50 deletions(-)

diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index d4f55f349100..bce37c487540 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -14,33 +14,19 @@
=20
 #include <kunit/test.h>
=20
-static void __link_vmas(struct vm_area_struct *vmas, ssize_t nr_vmas)
+static void __link_vmas(struct maple_tree *mt, struct vm_area_struct *vmas=
,
+			ssize_t nr_vmas)
 {
-	int i, j;
-	unsigned long largest_gap, gap;
+	int i;
+	MA_STATE(mas, mt, 0, 0);
=20
 	if (!nr_vmas)
 		return;
=20
-	for (i =3D 0; i < nr_vmas - 1; i++) {
-		vmas[i].vm_next =3D &vmas[i + 1];
-
-		vmas[i].vm_rb.rb_left =3D NULL;
-		vmas[i].vm_rb.rb_right =3D &vmas[i + 1].vm_rb;
-
-		largest_gap =3D 0;
-		for (j =3D i; j < nr_vmas; j++) {
-			if (j =3D=3D 0)
-				continue;
-			gap =3D vmas[j].vm_start - vmas[j - 1].vm_end;
-			if (gap > largest_gap)
-				largest_gap =3D gap;
-		}
-		vmas[i].rb_subtree_gap =3D largest_gap;
-	}
-	vmas[i].vm_next =3D NULL;
-	vmas[i].vm_rb.rb_right =3D NULL;
-	vmas[i].rb_subtree_gap =3D 0;
+	mas_lock(&mas);
+	for (i =3D 0; i < nr_vmas; i++)
+		vma_mas_store(&vmas[i], &mas);
+	mas_unlock(&mas);
 }
=20
 /*
@@ -72,6 +58,7 @@ static void __link_vmas(struct vm_area_struct *vmas, ssiz=
e_t nr_vmas)
  */
 static void damon_test_three_regions_in_vmas(struct kunit *test)
 {
+	static struct mm_struct mm;
 	struct damon_addr_range regions[3] =3D {0,};
 	/* 10-20-25, 200-210-220, 300-305, 307-330 */
 	struct vm_area_struct vmas[] =3D {
@@ -83,9 +70,10 @@ static void damon_test_three_regions_in_vmas(struct kuni=
t *test)
 		(struct vm_area_struct) {.vm_start =3D 307, .vm_end =3D 330},
 	};
=20
-	__link_vmas(vmas, 6);
+	mt_init_flags(&mm.mm_mt, MM_MT_FLAGS);
+	__link_vmas(&mm.mm_mt, vmas, ARRAY_SIZE(vmas));
=20
-	__damon_va_three_regions(&vmas[0], regions);
+	__damon_va_three_regions(&mm, regions);
=20
 	KUNIT_EXPECT_EQ(test, 10ul, regions[0].start);
 	KUNIT_EXPECT_EQ(test, 25ul, regions[0].end);
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 3c7b9d6dca95..d24148a8149f 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -113,37 +113,38 @@ static unsigned long sz_range(struct damon_addr_range=
 *r)
  *
  * Returns 0 if success, or negative error code otherwise.
  */
-static int __damon_va_three_regions(struct vm_area_struct *vma,
+static int __damon_va_three_regions(struct mm_struct *mm,
 				       struct damon_addr_range regions[3])
 {
-	struct damon_addr_range gap =3D {0}, first_gap =3D {0}, second_gap =3D {0=
};
-	struct vm_area_struct *last_vma =3D NULL;
-	unsigned long start =3D 0;
-	struct rb_root rbroot;
-
-	/* Find two biggest gaps so that first_gap > second_gap > others */
-	for (; vma; vma =3D vma->vm_next) {
-		if (!last_vma) {
-			start =3D vma->vm_start;
-			goto next;
-		}
+	struct damon_addr_range first_gap =3D {0}, second_gap =3D {0};
+	VMA_ITERATOR(vmi, mm, 0);
+	struct vm_area_struct *vma, *prev =3D NULL;
+	unsigned long start;
=20
-		if (vma->rb_subtree_gap <=3D sz_range(&second_gap)) {
-			rbroot.rb_node =3D &vma->vm_rb;
-			vma =3D rb_entry(rb_last(&rbroot),
-					struct vm_area_struct, vm_rb);
+	/*
+	 * Find the two biggest gaps so that first_gap > second_gap > others.
+	 * If this is too slow, it can be optimised to examine the maple
+	 * tree gaps.
+	 */
+	for_each_vma(vmi, vma) {
+		unsigned long gap;
+
+		if (!prev) {
+			start =3D vma->vm_start;
 			goto next;
 		}
-
-		gap.start =3D last_vma->vm_end;
-		gap.end =3D vma->vm_start;
-		if (sz_range(&gap) > sz_range(&second_gap)) {
-			swap(gap, second_gap);
-			if (sz_range(&second_gap) > sz_range(&first_gap))
-				swap(second_gap, first_gap);
+		gap =3D vma->vm_start - prev->vm_end;
+
+		if (gap > sz_range(&first_gap)) {
+			second_gap =3D first_gap;
+			first_gap.start =3D prev->vm_end;
+			first_gap.end =3D vma->vm_start;
+		} else if (gap > sz_range(&second_gap)) {
+			second_gap.start =3D prev->vm_end;
+			second_gap.end =3D vma->vm_start;
 		}
 next:
-		last_vma =3D vma;
+		prev =3D vma;
 	}
=20
 	if (!sz_range(&second_gap) || !sz_range(&first_gap))
@@ -159,7 +160,7 @@ static int __damon_va_three_regions(struct vm_area_stru=
ct *vma,
 	regions[1].start =3D ALIGN(first_gap.end, DAMON_MIN_REGION);
 	regions[1].end =3D ALIGN(second_gap.start, DAMON_MIN_REGION);
 	regions[2].start =3D ALIGN(second_gap.end, DAMON_MIN_REGION);
-	regions[2].end =3D ALIGN(last_vma->vm_end, DAMON_MIN_REGION);
+	regions[2].end =3D ALIGN(prev->vm_end, DAMON_MIN_REGION);
=20
 	return 0;
 }
@@ -180,7 +181,7 @@ static int damon_va_three_regions(struct damon_target *=
t,
 		return -EINVAL;
=20
 	mmap_read_lock(mm);
-	rc =3D __damon_va_three_regions(mm->mmap, regions);
+	rc =3D __damon_va_three_regions(mm, regions);
 	mmap_read_unlock(mm);
=20
 	mmput(mm);
--=20
2.35.1
