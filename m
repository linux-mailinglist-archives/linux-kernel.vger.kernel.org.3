Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BEF57ADA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 04:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239491AbiGTCR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 22:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236253AbiGTCRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:17:52 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE80546DB1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 19:17:51 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26K1Kttt002392;
        Wed, 20 Jul 2022 02:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RMXKgT8UrrngNlfhH2IbTL+hBs/nvSuEe50vU5dFwFA=;
 b=Ea+Ia5QPz9RbIo0eA8Mn3pxniVjjlIp5LdV09Uw3pIkVVEdVaaWn30ErsPzt8QmjR9N8
 2jbsgu1+FW8oKzSFGQOuHk618Q/xRHDcF04RrXI2SkW9JH00PEfaIDRcqTz7mc4tqdHW
 wL4ul8jZ912tyUidgh3nSWiPPSfBWNFaIcx1tFLTR6w4zWabplKs43XZ6d3BUB5NS3+J
 eJicFz3kHB5Xtz4YwJz0geVDlKFwkZglmzg0mcwXCQi0pJyNDLDTn59aE9gS8UDhpvVj
 sGhGx8M4jCK+B8yPKu6tfhAkx36jbngrsx8FDx/0i+D4low1tGvfuafwjJ1to8WAYZ9P gA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbn7a81ky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26K0rIv3002688;
        Wed, 20 Jul 2022 02:17:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1mbnukc-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jul 2022 02:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g2IQZqMYM23H3osNEte2OX1j7CYZUTtC9UxUEtGnTjN7cHCv2a4bbE5TkBwqWYhTtUgHR1W1jkaYcKWURGdM8qm3rr30Oymygjg3b98bmZMI6Z9joRkByJQ6oeOwGgrPUBqs/wkovVmztqnqbxuQTwmpdkinO6Bu/KFhY8o3eLyMTOHfPg2+mVSipQLtt4R9Hbjyznwd8lw1UuRt3iR2bK7oibs4qcR2WeliUXnFinpPiTf1CK6DJF68vcScIKiQMAIhGpQzb2LpXGdJb3qoxm+7OTYwCV8Qwmr2XppJoy5EfRLzWylDneVbzmK93rkK/i3464kh6yKjzEA6znmC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RMXKgT8UrrngNlfhH2IbTL+hBs/nvSuEe50vU5dFwFA=;
 b=hHHtnyzBY3/7XGlwJ8pRQeojMJtxmZEM2/SOwKEFLrU3kOIRjnTLueIQYnFIJQwyq2qfMdqaq2JJ8tJ96A1iaKlc8hfw/kscv2K++Mr/LYzLuYcNKR07yiSDgzRBBWkrboHAxdIfawXWShPYRd3yXKN8p1M6KIfQ9agKEoQ/dTWicgwsnM3bMFkYm4ir5eAD9a5SZKy9o33gvDzIMP6vC1FHLGZYP6tt1ri/DDD7IfDTLCbsm1PfkVkkQQpgyAOSSTvlTjs5PGj2nzGylf0IGBVvV2lv+eqNPWQYfMzbfqKvNEKrFuZsa/vDaGdWTAfY9nIn8xcklSTnxF/eAYnTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RMXKgT8UrrngNlfhH2IbTL+hBs/nvSuEe50vU5dFwFA=;
 b=dMOfOQQhXfS5WkB5+fB8ts3p5EoLhvXX5GHawZPjheq1PlWV2JNhrP9qtLHOKQoIlX8pe9f2CtG4+Izt83wkddQ2QT/AuQwecbLRjrbAHvBU0MVnS20+Qouh8PgAaYb9BH+jins0H9QWUircWdO3VzVNraNw9/Qwa8rNTUPFeko=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2889.namprd10.prod.outlook.com (2603:10b6:5:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Wed, 20 Jul
 2022 02:17:41 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.024; Wed, 20 Jul 2022
 02:17:40 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
CC:     Yu Zhao <yuzhao@google.com>
Subject: [PATCH v12 04/69] radix tree test suite: add allocation counts and
 size to kmem_cache
Thread-Topic: [PATCH v12 04/69] radix tree test suite: add allocation counts
 and size to kmem_cache
Thread-Index: AQHYm97jI3FMyKIsR06NVTRPmcw5Dg==
Date:   Wed, 20 Jul 2022 02:17:40 +0000
Message-ID: <20220720021727.17018-5-Liam.Howlett@oracle.com>
References: <20220720021727.17018-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220720021727.17018-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5b64905b-7bc9-4737-0d31-08da69f605f5
x-ms-traffictypediagnostic: DM6PR10MB2889:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oZe4TLC5F9mZgoTxUGuAna2K7RZf5/Wu5NCpK8f3gGfVq8LdTtlLjc2M7guoSppkSAmPLcthbt7XFmlSvjcbucPxGpUBjeaiJoOSz9cbRKbN9VJAbSBGMvJDJooiUrW+YYml9zKkkWJyysoSEPTD14DorwApgF66YtIuRSim6L2SrZWCSFzeaCbMSVzPxfZGab/Ud2VxbZhbFqsiEiP0Qcl5yix9K0a4L/Wc2BDinR+MSlM0ZXHoynUJff6cA7R/o05TZvlCYlU/Fy9tq+Sa/+bqoNq3Um/2Z+pu8ey9r7MMjvd+Tr0Gz8CE3I0SdZ4b5NHvE1L80k3ZmmeqCDs/u7cnE/XQ09fU6m1/iu6tpro3OFztCxGaR4/INeTy9Nl4sIVpMUjm8ap0YtzEshGZAW/ey3v47kDq2f2KZaLX0Bi7Z7cAvZ5F5LHpwYP/ELQ2M2AuOcd4EJNaLyc+VRfr0c8u0EvpBXgQG83yBui9oxMTfF0BKsQt/PH/628bQYSZeZFcsN7KvAfIMovZCETaQjNzqjYoPMNUcPHa5MxY64fqeWin3icv2d2U7NNgsuKMiFSK3mTtGo0q5OtHX5Ku1VyVrDT5gRs3xUVglHt7gnJ6p9w2aDRzgBCF+OLXClDYDqpcOO4krvS9z7XrSO0LUbR49Bq2f6s/DO77l1yc8/74Ts58aIeky3i6KOTBBCGOJJVecyZ9P4tFDjJas9j5EvS9+s8e7PefRu5+s6w62LN2qNpNd6CjZuK7/Y1A1sUajsQFy6G2vSyfPCkselMI410ooP+QwvPf7SaW9Aqo9FGQpjchuiApFkjElbAQuSC0HuEyLH5cevKsMHvk/s4XvsQvnI19alhBxHEOC/+2qi2ot03QcAcAqpt7ItwW6PZs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(376002)(396003)(366004)(39860400002)(8936002)(5660300002)(76116006)(44832011)(64756008)(66476007)(66446008)(66946007)(66556008)(8676002)(4326008)(2906002)(91956017)(122000001)(38100700002)(86362001)(38070700005)(6486002)(966005)(36756003)(71200400001)(478600001)(41300700001)(83380400001)(316002)(110136005)(186003)(6512007)(26005)(6506007)(2616005)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZsZn5v/w0sc431xOTeWHsC9K2tKGwJFFbMviBKoAV/GSdHgeDG023h5UDp?=
 =?iso-8859-1?Q?t8S9xwb/fK1nGrrykVNMXrfmgbf/qbT4EMXGx4S9UqwPc8y8+Dg3qAPSQW?=
 =?iso-8859-1?Q?qeiqs+YdODUE0fcNxqewb86aSO6besSfrIf9gOdRZm8nevMmgbQdUHciWV?=
 =?iso-8859-1?Q?FWeBUIURh0NchqZ7I680Wmo8yWHWtq5sZSMU25rSAgm+Ri1VzFz5w+eDWg?=
 =?iso-8859-1?Q?rPYHdpQgMB7oAFD/yXID3HWkjcIUGT4uEqOkfPTcS6cQ0uaXUFOvJK5OWc?=
 =?iso-8859-1?Q?e6ydGCowi7JO5GBy2jfpJJwrbzcOd5Rt0hwTMzIimJtn2MzNUnzpNtfU7O?=
 =?iso-8859-1?Q?bJ14ueHmvt0W9QUS1c7LGsAQlMCOWikC8Mfmsfqc6uBmJ/V+KC45kQ27zs?=
 =?iso-8859-1?Q?0WpzReflIY98OFU1hwzQWqKdB4jjuas1zIG77/kMpoeTsuX0OoLIfZhDJT?=
 =?iso-8859-1?Q?TrU4k+Y1A6kdHAdfAkzYdhubL/9gwY4GS3fXWzY6KeIrpFJoaJbwIdC6hL?=
 =?iso-8859-1?Q?waCmNtAobpgLknJK4w32SYrJ70loSzKSgAEUzmywzWDXqY4ALWyqm8h2Ox?=
 =?iso-8859-1?Q?CfPcLWX3LUwOM2OXbOiiLsluvYbCDJ7fDAe/etAq5CahmjcPjo3xffUiUk?=
 =?iso-8859-1?Q?5S67usTtBf9/LS0W9d52PeMOIrSC1wOkQAR8If/wTVfvAZ9I6aSabFrbBz?=
 =?iso-8859-1?Q?7VX/zb/pjKcnbCbK8Y8ZHRlMj4TjwxfZsDJsCGoRJTbHZByFozw9xPUeD6?=
 =?iso-8859-1?Q?qAagJX4B/g7jEl2Bde+c2aD05FZ/VkkeOfGCLjj2GhybnAbe+T2MNqh/mH?=
 =?iso-8859-1?Q?zLF9FrFyR+6F+sDwvXL6etkqFGxTzEsiv8W0P89m9EexNIT4loVs9ZpiL/?=
 =?iso-8859-1?Q?MT5QLJJkSY+8hwe4YJ0a4o6IGsN6VMZsZt+p2XvHZN4k4btkfIQsMS3Gts?=
 =?iso-8859-1?Q?w87aByX5ZmXdEgHFG/tq4S61xaIr4CRDJFcYsNNHFSI0pBTkbEB0/Twq9n?=
 =?iso-8859-1?Q?4TGekALq2obWXHRX1qhzPpXGd9c9oaQKA2Kt2Yqxxk1VhkDsvp0eZ5fLXz?=
 =?iso-8859-1?Q?WfMvIywgW7tysdhNpzdEq/07P7nNPx7whHoe+CmyMHjzyR/n+u7yaGqKpX?=
 =?iso-8859-1?Q?YIzvTEpxUM4ofFh4/WGxBbzNzo9LIYisGFC492RzM8/fwkBVEOuKX+wqRq?=
 =?iso-8859-1?Q?FlSJNgiC8vtwxv/0PsWwI3w0ikZqwYJRZTCIKJbmhV/b1qMx7zimI5TlTM?=
 =?iso-8859-1?Q?H5jcmvJt0iRfT5fSG8KHKRvbe1Yv05i4sf+Sdr8FWxMmNQIh45yC9N4iME?=
 =?iso-8859-1?Q?BRexpwTsPIwi7qlV2XkypIA8dnuovrYIlAbumANpSZ7Rkj76bHguuPiSGB?=
 =?iso-8859-1?Q?+01UdloIYOnZWyWNApda0L1hzq2cbwYck6u2xzp2N+Ql3/rJbRr3hC6XZu?=
 =?iso-8859-1?Q?hQ1w0ewGs+7XESloXPEgd2AyeeFeHdlUwPXg2gpeQp/qLNeBegj9ta5r62?=
 =?iso-8859-1?Q?MCOov/x/jtKHgNrgz4GxuFMaRRJzY56bSED5Yk/Iyv4R8Va0NGxrTATFg6?=
 =?iso-8859-1?Q?MP/onY6/trx8cPjGzW8ehDA20C+/2MjY8UyGL5CTZuUnOX5QnNqsWHkshr?=
 =?iso-8859-1?Q?624xz93+lkJ6mooEip5kTjHZXMYgO2nhXPU32fzEREHjfyzCOYWDSaxg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b64905b-7bc9-4737-0d31-08da69f605f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 02:17:40.3695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtF9I8HdpF6VtpLtnRHm0lxm/vISwyxkohKJK+sTDpqYPFex6otB1UalK0baGEkSZ+hdMf3FtgYrpI9C17Z+Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2889
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-19_10,2022-07-19_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207200008
X-Proofpoint-ORIG-GUID: TY_EAjTd_4GXtwFZ2GQjW1quFo0wsHDl
X-Proofpoint-GUID: TY_EAjTd_4GXtwFZ2GQjW1quFo0wsHDl
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

Add functions to get the number of allocations, and total allocations from
a kmem_cache.  Also add a function to get the allocated size and a way to
zero the total allocations.

Link: https://lkml.kernel.org/r/20220504010716.661115-6-Liam.Howlett@oracle=
.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-5-Liam.Howlett@oracl=
e.com
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
