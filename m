Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52F2C553BCB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354317AbiFUUrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353351AbiFUUrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:08 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3CF24BFD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:07 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ4Nh1004714;
        Tue, 21 Jun 2022 20:46:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=YgnffpLD4P8ZQwPGv3ixKk0p1PmNuK2riv602O9HyXg=;
 b=sWLVW+kVcnEojP0l/UFIjfTCjpitmXlZmnRfBvwFAf5jkZ0RNzHKpsCaNQrqMz/pbEHO
 j5lfJ9E6nkdTiE4ICt2Y9x2U/FWRVOYhwoFUc3pr79oc7Y0eLGQNFGvqZcC3e0BFLM6N
 WJlxeUCmgBpbxvqPtekV4BE9OYUhKg7p/R4dBoBx/LyU7qNe8uD+eBjUoP5z0+HCl5Ax
 zUdFrQCEVwro/TzlV80buJdY5p+HCxI1drqylVHzXN41orBaOQIFN5Ij3IetmI9Fj57h
 a4RGWI4x3IKaUBlvpwrvmn9hXZrt3EnHxwTOV9T/dU5uw2oJXi/NYArDHwQJgzGvFrWZ yw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeaMa010747;
        Tue, 21 Jun 2022 20:46:51 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtg3vkghq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mPpfWk66JMQFvSeb1OfQlKtENZ3ZwJLsWcjSdKtkygYCmo08+SzJnPavPzYInmxD1Wgubu7/R9TgeZ6OZK3VoOGm63Vqh9fMaxgz2JJiObwtstJtCxUwzmIRrZ+4MTKZysjLnqTab8fBP7cJBPYSeTA+KoTWukVcKIErs5DzX97qUOgu/Akc/zcxiJoJTQpmCSdyIlP8UnZ/Dw1OIcLy3mZgNLNXY8J+wQgA6iXUQSXBrPpbwB3ppm4KmI9jypbMKR6RY+/v/8nkmnwWapeVcZVXVbbq1j32b0br3ZCHCjMxOoR/ZLSxm7hRp830xba/5pZN73iedZg6O3UWF/Q7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YgnffpLD4P8ZQwPGv3ixKk0p1PmNuK2riv602O9HyXg=;
 b=a7+ak4VgD51RryJxpo3ewf7TdkmfSW42WVvuMtArXOnoWQjWO5r5JkZzdziPs1NUZ9GrNdoFWJHQ15B1chYOVk7etTwkR588QiipnvtKp2NI1P+8Aj+YUCHvB/wYRKk8OqOJWeRps96TW11SNgVi7hZfGhOk6yi5wQUYeNxfmoQq5mqX3LnAoSd9L4XL2lLOCGND79DNiRaRI2rj55ICLXY6PqsnO0YlnZOWo/2SaRB4fv5+j7qjb64EDVY5A5zz6xFFEBxlRYuZyuHnauvhDZc3RhwnekJcc8iAzDYIMPsUkPF5L/34iwxBzxbrAcn6534CI4T2WVHZMP/HnTrJuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YgnffpLD4P8ZQwPGv3ixKk0p1PmNuK2riv602O9HyXg=;
 b=tkdKNUKWaiOfS58ek7hjUbPVg9sY6clp1ge230zMs9ELnRnT3QuV8ey347Qy3v1qXcZYjSkFrJyIewNPK6P04zcBS/ALJSOYZ9DDrfuTZDnV8MKbi2OY1Eav16XaFWvZ+kKDhYZiYOuqAs2o5WvEG2yrj/n2m/nYPIsLxSayR0g=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BL0PR10MB3074.namprd10.prod.outlook.com (2603:10b6:208:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:46:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:46:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 04/69] radix tree test suite: add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v10 04/69] radix tree test suite: add allocation counts
 and size to kmem_cache
Thread-Index: AQHYhbAHzwnliNv4TE+m9PI0j6qQgg==
Date:   Tue, 21 Jun 2022 20:46:48 +0000
Message-ID: <20220621204632.3370049-5-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2913e104-3ea7-4322-792f-08da53c72a3b
x-ms-traffictypediagnostic: BL0PR10MB3074:EE_
x-microsoft-antispam-prvs: <BL0PR10MB307480ADAFDA3FA048592371FDB39@BL0PR10MB3074.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09Z8K8W9s74QgZYlr13h4Ec/OeJcyiSfhBdELhTHn8cezP08ZjQPZBMwT1kGYnE6IYpQmWKfjy8CNxB1wqT7jucBlKd1s3n9czy1mPWJ8jlaJnU7Y5RVjwwXY2pY8CxRWkTb1R3s6DHctkzybQzgU0/xxH57viz7S01ZyLicjfGiWr2SBudOFomhc9swmHyMJiMdGmefOKH6S5EASCHXrhQvhornvy3othScCtjIDErGI8eqFdT6kZ9dLZa3UsunhhzwSmfnOzDcQ4ca9pv70i5jpnUBqc3JVbyclyPx9naPkphCJdF7aMKl5Fmc1XjkGq823dyseDy3vaan3T+0fEbDgrfz3uZ/CRPXpRXsSV/mi9ewxfam5ZXr4rXPzd/gU5SwDfrmwd1asO/USmJYfBV/+u6uF35LQpWSh+x5D6R66Rq5uycm9pHTdRBGP/UJFzQRYgEdPx+Jd0LZAVZQC3qkqRIEi3Czvb4b3rb5QEC5jfRkuLDh1ECYfNT1JT+OIjvdZHAwHg+hOnZ3psPgKHHsnI0xPcnRjN0sJ+LgZrpG0PgcBTzi0rawfVQYvTZERXzzqey6az1DxUnUlbpJf6PV/DtcQ3ch0LlhiYvd0TsrMlplpkznRKtulRsRwQ12r2aVGZY56Xd2Xkcr23G0JFuP0JdAo2F6QFjCMvhFCJ8gJeHg5wcYm/owJJyMZU0Jz9uHeyK+OMmZp9XRhk5WvXNzhZY7ZrrwHBB/b+pIJjH79gtvkW8Me6z4rbfKWSV0QKxRhSRkxyIh9Cr1jZ5ewU41wMLmly0O4HXLNo5LEdM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(366004)(376002)(346002)(2616005)(186003)(6506007)(71200400001)(26005)(66476007)(8676002)(38070700005)(1076003)(41300700001)(86362001)(83380400001)(36756003)(2906002)(122000001)(6512007)(966005)(66946007)(478600001)(110136005)(76116006)(8936002)(38100700002)(66556008)(64756008)(44832011)(91956017)(316002)(6486002)(66446008)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?59B3+EGiZdleiRuCTHE90S2nlbqAmqdbQZnVDsRPJNYqAWiXUFKamsimuH?=
 =?iso-8859-1?Q?zQZIAiuMkmtb4Isa5IoDlW5PvqAISdXn6GIRYbPR9MCkC0mpwaj4Iif2qK?=
 =?iso-8859-1?Q?MdOoy4Fpue7kzcxcVjmmfVhLNeDahSZONB6CdkD984DGKdpuTpmWOHt3jq?=
 =?iso-8859-1?Q?1UrRVIEIM6X05lAMRxt81hVBnYS0UI1gqj9h53Gm/2O+OB0ZnFCriGs67Q?=
 =?iso-8859-1?Q?G7Ii2HxwVHr7QMZj5AQWumii2FfVwzyAqABXk93FuJjZAGQVwps5zjHgRK?=
 =?iso-8859-1?Q?1LgC3nLOS1o5urzdesJjDHjLw4G332zCyUNRlK0G+CMPCI397Pu4fWT3x4?=
 =?iso-8859-1?Q?z3nQJ5fssAzuT6z/Pyz3zPU6I/7GbbDnGD6x4Mr2tAY0wIG80sPrTMJtBS?=
 =?iso-8859-1?Q?NKdD4pAbUKXrhaw5jkCysg3OL78kRxDUanrQ55p87Io7SD4SZCsKjk+ccg?=
 =?iso-8859-1?Q?yDcj2DqGEhzdaWxx2Z5mCoTXMBXs/nk0VHWR+k57eZh+HwoyEJxc2HOmKh?=
 =?iso-8859-1?Q?xi1So1LxcsL48pup7mEdZbP8LSCwUDGB7kTIVU2Ca8PTUrKYarTtNmijRG?=
 =?iso-8859-1?Q?qIJmY8NtPM8JAvePdvqiJwXxonwCrHj9Kv+ciW44kTxL5hekG1L7XNIKJ6?=
 =?iso-8859-1?Q?JddqegBJiQntHQZYptpcDtgtHBNn+VhyE5w1vdGeiqcDz1oDKqB9O8ZSMR?=
 =?iso-8859-1?Q?2yPGdoKrxoAGPseFJco53sH7V41JvE7k06tjn0P5yxa43HptMWnEsNUcWs?=
 =?iso-8859-1?Q?m/pRkn4SyIJUT5dRdKGyMKdQg66/0YAZwK1/VleUlXMW89SMMBl8oa3Vvt?=
 =?iso-8859-1?Q?Y0g+buX1gi5p8YVk5zYDaixWLIZbsWyUNU66eWEjn3lnCRbrSz/+vy2Np3?=
 =?iso-8859-1?Q?oSDvSisk7Agmzr5hQb9+CN+vN/Gu5UpGOQulzKrwpf0Pd/HAUuHw1rZrwx?=
 =?iso-8859-1?Q?mkDdHqk+2MHNoW+Zpy81RZIhhW/Ag+jg+nteH6s2KYzPqILWmkA/OCieyo?=
 =?iso-8859-1?Q?oIsQvhWOdlIJEFQ3RJ8DrDP22ueVc5J3cWl7GYOWmoTZjsq9eNEwkwsdPb?=
 =?iso-8859-1?Q?qBFFGOsNMr3uuK3hnme3DsoYcv5krdw6BzQKlmUNwmpZgp8tgwANI7ymNK?=
 =?iso-8859-1?Q?43Y7NEp0UipLEOGxhvUX4a4n9PunDDv/z3VivGA1xGt31yuUpseAcjc7Uo?=
 =?iso-8859-1?Q?j9MomDovg5g9VicpaW64+mqoulEFz6hPu6ljjXcFsApjBAIsgAHWWhx1nw?=
 =?iso-8859-1?Q?djQV9OK30vqGHWXAeFQAFXuYukUtPrFyal6eLsL6xtQO6lsxVjSnxOQrM6?=
 =?iso-8859-1?Q?xlI0pPRY3tLiISZdHtZNdQZwnOvXizaNWIRi+dGnY56SMBHkErEUn9OpZr?=
 =?iso-8859-1?Q?H7mOEdFcKtehVC7m/s+NCkXRhq2B0dF+SO+chhXaVAeUueg5lft2uEOOzT?=
 =?iso-8859-1?Q?7OMsGpa6rN6A5QoH4ITRIQUPHEAjE9Gw5aNg4gNz85TEDYTPzgAr/XyQqj?=
 =?iso-8859-1?Q?QwEm+X/uvucuJ/TlSfIVQ/Ah32cTWpqA2vr0Q2t5RkwJvFI6PlZ+UZPwYz?=
 =?iso-8859-1?Q?/IOqfXOgFwPDG4aEUn3+wzLcf+EyJ3PLMfrcCBg7mMDqSMokLqp8ttFebC?=
 =?iso-8859-1?Q?3S5ovJwzW483oIzSDzNwly1EXbuRF/JvKhBAmbTEtGM2Y+fkFZgAo39YXY?=
 =?iso-8859-1?Q?gvbVbvz9kIJRDQgZ992adupI9DFPXzKAUUmj6rEj3LB9q64LSjKGRR+Qfb?=
 =?iso-8859-1?Q?juePE6bFwYHux4qI11ik+0+zpgyRQiwgyNHuT33AlIzS5jdgY3dgVcaHVm?=
 =?iso-8859-1?Q?DIMHuMvYR2ghQeLbJfBccwV1JiitnWs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2913e104-3ea7-4322-792f-08da53c72a3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:48.7704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XroM5KnFGJG7pnZr8V87EIeYPFdej/IhKOZPKymSapQf97lqs4AFfztvgNLw2QC9zMIMa6lT5Z3p6ctDqfUZjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR10MB3074
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: O0Fx84I64akh9mmrXgehl4YKi7P6tf2k
X-Proofpoint-ORIG-GUID: O0Fx84I64akh9mmrXgehl4YKi7P6tf2k
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

Add functions to get the number of allocations, and total allocations from
a kmem_cache.  Also add a function to get the allocated size and a way to
zero the total allocations.

Link: https://lkml.kernel.org/r/20220504010716.661115-6-Liam.Howlett@oracle=
.com
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
 tools/testing/radix-tree/linux.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/radix-tree/linux.c b/tools/testing/radix-tree/li=
nux.c
index 277aa8b70abc..f20529ae4dbe 100644
--- a/tools/testing/radix-tree/linux.c
+++ b/tools/testing/radix-tree/linux.c
@@ -24,6 +24,8 @@ struct kmem_cache {
 	void *objs;
 	void (*ctor)(void *);
 	unsigned int non_kernel;
+	unsigned long nr_allocated;
+	unsigned long nr_tallocated;
 };
=20
 void kmem_cache_set_non_kernel(struct kmem_cache *cachep, unsigned int val=
)
@@ -31,9 +33,28 @@ void kmem_cache_set_non_kernel(struct kmem_cache *cachep=
, unsigned int val)
 	cachep->non_kernel =3D val;
 }
=20
+unsigned long kmem_cache_get_alloc(struct kmem_cache *cachep)
+{
+	return cachep->size * cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_allocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_allocated;
+}
+
+unsigned long kmem_cache_nr_tallocated(struct kmem_cache *cachep)
+{
+	return cachep->nr_tallocated;
+}
+
+void kmem_cache_zero_nr_tallocated(struct kmem_cache *cachep)
+{
+	cachep->nr_tallocated =3D 0;
+}
+
 void *kmem_cache_alloc_lru(struct kmem_cache *cachep, struct list_lru *lru=
,
 		int gfp)
-
 {
 	void *p;
=20
@@ -64,7 +85,9 @@ void *kmem_cache_alloc_lru(struct kmem_cache *cachep, str=
uct list_lru *lru,
 			memset(p, 0, cachep->size);
 	}
=20
+	uatomic_inc(&cachep->nr_allocated);
 	uatomic_inc(&nr_allocated);
+	uatomic_inc(&cachep->nr_tallocated);
 	if (kmalloc_verbose)
 		printf("Allocating %p from slab\n", p);
 	return p;
@@ -74,6 +97,7 @@ void kmem_cache_free(struct kmem_cache *cachep, void *obj=
p)
 {
 	assert(objp);
 	uatomic_dec(&nr_allocated);
+	uatomic_dec(&cachep->nr_allocated);
 	if (kmalloc_verbose)
 		printf("Freeing %p to slab\n", objp);
 	pthread_mutex_lock(&cachep->lock);
@@ -99,6 +123,8 @@ kmem_cache_create(const char *name, unsigned int size, u=
nsigned int align,
 	ret->size =3D size;
 	ret->align =3D align;
 	ret->nr_objs =3D 0;
+	ret->nr_allocated =3D 0;
+	ret->nr_tallocated =3D 0;
 	ret->objs =3D NULL;
 	ret->ctor =3D ctor;
 	ret->non_kernel =3D 0;
--=20
2.35.1
