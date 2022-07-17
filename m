Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F307E577379
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiGQCwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiGQCwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:52:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F725C5D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:48:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ9Jhs024541;
        Sun, 17 Jul 2022 02:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=46DvMK5GEP4d9GsmJC/9dg2qzjXnaZqUwxzUp3QEP0Q=;
 b=pgPbR/TX4b5Ayeq7o91bgqudYYdBKmrRT9OnIP0NugvVHHSi8isBOS0adWRMSdQRmVTC
 cGkjSxWGjunnTXWNulveSgCF09oPZldj9sHaXAaXT/tOK39pIWrDZVYHlZNE+6WLLtlo
 TtCZPKsRSzGel2XQJsfb3W52ojRc9Quh7kJcBo309b61ZfE4Qie08qIBf15ArdnXlwes
 7uHVsziMWMk5P7ppliEzuXSXHSKzhurtEWjMOfmFjYgFw3yfb9tpS0uHW2OpPEtrY2R5
 xDRA27wIuAdmi+Jw2jHaR3CN8t5vI0Cusmb208dgRZ8nW6PPE7Qbu3spkNkUaudVjvh/ jQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvt8xe4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY3KY005908;
        Sun, 17 Jul 2022 02:48:15 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d8cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:48:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXgsV2OtUI/iyrpnYz640WWtF1OOPUQrNlmqRrc9wmb9qjoNnUPw/BaRrStCacp5KlB91eBREOX7G5bjYuSwDkctLhbizmRgw+Jj8/89dOWVlKd/rivtilloXDYuZ+zyw8RGE9SMrO+mgJ02z1aImFOzoRbBySx9FDx/6srEW44xGhp305Q0jy3Cp4uYbrObPQ/btHSGQbTIoUDUfRGUNChwMQzHFpy3b7qnctg/wCrt1pZpR7/E8Sng5wr5aJio6wZwDPORJff9wtbVIPGhOdhQr+17wxMt6ftMLFlhwURMCDpx3+0dXMRdD/+PDBMDtHXoVLwEY/tTSRrKuTO8Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46DvMK5GEP4d9GsmJC/9dg2qzjXnaZqUwxzUp3QEP0Q=;
 b=lBcdq0/XEeJYeuC/t7QPBEHE0ivIXDleVglor2rTSdzBfbS9ZkybPrJL1BeeETc9AzHWeysx1gPSwOk8+aBFZdO/auO8zzd7yuE5Mbf6wHAwPh4V3whDci4TtmOP6mAtxrO+Zjhe0RJjysVmGXbndqwHR+fYwRKQhkUKA2iCYfdIMILo5cC+/9ef68YB2V2V/5qDBqS+t2bOFWmU0z05wK+LDjbzTEu8NffFYhRDaTDle33qqLANJ/mbcvX/4pjkpgslL8z4eH4Ng44qVMgv4SdMsT6rJe18zrMrzM/ciGctWD7TU4/dvsNhtRcJ4f0UllrlIIXx0oqKftxKcly5Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46DvMK5GEP4d9GsmJC/9dg2qzjXnaZqUwxzUp3QEP0Q=;
 b=m59V84Bzm+8zh83PqThHE9/Ixi/P1nrqsWWEWEBwrAo8wrZYjStywDHrom+NgruEsaSHbmB+DlmlWB1JMchvg2fMLacTH0xCFZiBmim406KfPCaJA4GGCB6zQjPPujI1dTKWPfSjYdXJreph2bf1a0KyV8CbhvIfZwre4J3BfUk=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4504.namprd10.prod.outlook.com (2603:10b6:510:42::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Sun, 17 Jul
 2022 02:48:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:48:04 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 61/69] mm/oom_kill: use maple tree iterators instead of
 vma linked list
Thread-Topic: [PATCH v11 61/69] mm/oom_kill: use maple tree iterators instead
 of vma linked list
Thread-Index: AQHYmYd6Z9nskjs6oUGFskyrQyNtaw==
Date:   Sun, 17 Jul 2022 02:46:57 +0000
Message-ID: <20220717024615.2106835-62-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7721a0a3-17d3-4928-2858-08da679ec59f
x-ms-traffictypediagnostic: PH0PR10MB4504:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8VAcxvluMzQ99aJNQ4WRo1Shck66tFE5jXDZy9u0g7ecs8x4LEq6424Gbm2UdkESMfhquasetR1eJREAQUKvSTuMqXGeWowwSKwhqROHYcbhKZm+UERt8fRi177hwErCrwEB7wMzE5UhNkWFNiKC0KMqaBU1x/YdjlLQafVFIy1yPYMjf4Rxarp5d5HH7iIsk/kGVP61llIkuz9s8IiE18e8GX17lHEtLmlNJ+st01o1uIk9CzbrY33PwV5wYXsppJ/tINuMBKP6kXRAWNF+UOP2DixRkpsiGYixt6wzuizz2OugEA8kPtlyhCvG0EjoorjSxRvLYPX+uuiDEAqEpyNu9fgLThUukS6LhhJAwsj4Ffafd/6K+hvUe395WyS5BOEoVyPLH8vYiR+b+wl23WfNME8kqR6dNwpFOvXEvJpmWnrW6B5uGjLw2L45F4JZMvvFiVrreFg79pemIv8dr1LcvhmJjcbchIHQEgg7Ae1ufQ8mkOhx8MAwJUGsp/OhtvLh7/xQMA/iADWWCEXF/n4+Y9tBmtX9XIbU6K0RLDtgi7drSSMIIi8GhYA8IEg4KaIOgrO3V67fNFkzxJhygHyVIniVM3ySSUjbXHoo1r/csgZNPWLNzDHbsvrFvO00x+Y5sBGlKg5MT5JPObiY9RecPIAtJGCIKEXORV3RIyvoucUDPod+CE5Z3//Gi5S5b0UUASkeFjLtb62J8XnEyJnTiBNa32BLkipQEjtSKIEdjNGkJeQv5P55HQxr6uLA1xGUQngx+SQYkzyhV6k2QTvYE9oplKLhm6xFW6rw3Rj4JCvLTk+W29tQ4l+IpYV6R3sNi3XnMToRxllU/UwwdNhM+kIYE2LkpWLw8L2vuxVFmDDUVX3RDtLESsulOqY4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(366004)(346002)(396003)(136003)(966005)(6486002)(83380400001)(1076003)(41300700001)(2906002)(38070700005)(44832011)(8936002)(6666004)(478600001)(5660300002)(110136005)(86362001)(2616005)(122000001)(6506007)(36756003)(26005)(6512007)(38100700002)(186003)(8676002)(316002)(64756008)(71200400001)(66446008)(91956017)(76116006)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?rIR9ueHbixzf+hUj45maRdjwrFhnyuxV/D2IJw5pfAQzyF1DoBXHsDH0wl?=
 =?iso-8859-1?Q?ZDOjN+voO97zIcJv3A9XrI9GGQxtJ9HRhEdSDJrKaeBzEDtihIt9DwvR2C?=
 =?iso-8859-1?Q?wk6fU5SFyaV1yODuPzW3jL5gJDO1rr+CzcM0+hWO3TH3a0You3zpdEU3ic?=
 =?iso-8859-1?Q?4ZzL6v8HdyyiorJrTVuBjfXKdWr1rF2wC/VYOXLRMp1fYdsuTlRYXJhcjJ?=
 =?iso-8859-1?Q?RiXTZWpJPToMx4o4ZQXY0MBWRiMibo5xvNHngwi+dj8dv0uD3NhdDaAGrz?=
 =?iso-8859-1?Q?Yxf4nJM4Q5N3kQCmnj62aFlrCUB8DzS3m0YYrNQGu9RytLa+V6/53ni8UL?=
 =?iso-8859-1?Q?JHFtKElF0CVvr+eBTkLaicoifRoDIt/6o27GViseUx819y2KxKHrslQ+8K?=
 =?iso-8859-1?Q?+x2vllCau+EZ4i9XJ4shnPQAaIovRCIV0C6cEEzU1MyzzkBCHW/V33yDV3?=
 =?iso-8859-1?Q?Prwah/mGBzNQtwjZAYqMJtenWDwIojZIUXSfrVd9tdsBDumvLm5wSuoeSB?=
 =?iso-8859-1?Q?sU+s3WumP+qdV9fTYuoBS4e1FjbTBiem60us/0Z/OjrgCo0l9fiQ8gzv4c?=
 =?iso-8859-1?Q?xm0cUjVc4gqMWyhnar0ejehW77rCo2dZONMrZOINLwUL+0FOwU0GueJL/9?=
 =?iso-8859-1?Q?ROTPTtQML6SiXsy3bfrXQlLtdtKygtRdNMmAuaRsLaf7S5E52huX+DIxac?=
 =?iso-8859-1?Q?CcLNwviS34EF58UmCRBcdnmIU6CNfdFWJaSwo5ansaYJhrnI2+38RojIse?=
 =?iso-8859-1?Q?HS6JvJX3P6gEr3VliY9Em53pU9LnBgcynHekwPzCuQN+GDeD6J46+jIKYY?=
 =?iso-8859-1?Q?HlSRxJwVpYRcpyBjg6JfqpAZg4Lc0Q8qiBT96vdJ+bUujaVe42eIXg5jj1?=
 =?iso-8859-1?Q?rE2rjo8G2KTqbPyA0EWNV4fgtKfXGh/+XA1McosNWK2HmYrI/XQ+ZAoTJt?=
 =?iso-8859-1?Q?o3fRUSyqqy8wF/4x+fsIEDK+uDvuL+uakKPCqBlQl5dCuzz4nY8nC5Fdxl?=
 =?iso-8859-1?Q?4zcRJCnF7GFAwDxDaFjZ6z4TlTuRERf3fPLRkqrUNNLbj7gDVvhJw5Ah5e?=
 =?iso-8859-1?Q?ZcKSsTSuMTgxvMromlcRQd6LRNeHYytwoiOrReNBZfVvKOlWOurDcVmnXb?=
 =?iso-8859-1?Q?KNFuTTFYC5ysXz3ZBvCGbTVUQeMmHJXt38kygAJeSfwZLVv/ullYvEZhHO?=
 =?iso-8859-1?Q?F7zbhNu9mMc7rLCekARSnsnqGTDiThrZiM8TkFO1RRZwlw87RFxPBZQwNV?=
 =?iso-8859-1?Q?PY/NKIJk2cxigwo5KOnVoxNReh7AOniigwsN1FXleDI5t4HjSvULnfS7yQ?=
 =?iso-8859-1?Q?WFpq4gOP9WtJiH8Xr+A5lrK2R331Xxx7V789S16tI0WVJyIzT9qUpOnFDj?=
 =?iso-8859-1?Q?S8pfXmSIYXtgCMXtrH9gLhGwa/PWqsgaRTyz8+J2whm7m0hEN6//wGWR4x?=
 =?iso-8859-1?Q?PFYXyA2sT4IJYTGBuBXKtPalM4PY4TyYsXN1fotsFb3OCV2WExUp97KP7b?=
 =?iso-8859-1?Q?TB2et40lXI9lIN9JevpV5flm3nP0CF/aU/Nqel+NhQeDapknbxI8gVTkdO?=
 =?iso-8859-1?Q?sBCqw0n51M6i7DQyfvXHDmVS/DvnU21RswVQEjQUE9GaTAcPno82FhP8BV?=
 =?iso-8859-1?Q?bNauVVMgJ5vt55/XQLRe+mXCNxoGZpkALK8Zuuyw2/eyitI4imrGAnMw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7721a0a3-17d3-4928-2858-08da679ec59f
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:57.0208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snw2hGDjerqyGRTqNJZaGmTd9a761Mmw8ST/JqnW0cRtzzGDtZeqGdX2oardOLGYqPubxN+UTp7yCb5fMZqKwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4504
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170011
X-Proofpoint-GUID: kpPar4D3JQ84NwJNNt-6sfaWGPfZ4YY8
X-Proofpoint-ORIG-GUID: kpPar4D3JQ84NwJNNt-6sfaWGPfZ4YY8
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

Link: https://lkml.kernel.org/r/20220504011345.662299-46-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-62-Liam.Howlett@orac=
le.com
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
 mm/oom_kill.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 3c6cf9e3cd66..3996301450e8 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -513,6 +513,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 {
 	struct vm_area_struct *vma;
 	bool ret =3D true;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	/*
 	 * Tell all users of get_user/copy_from_user etc... that the content
@@ -522,7 +523,7 @@ bool __oom_reap_task_mm(struct mm_struct *mm)
 	 */
 	set_bit(MMF_UNSTABLE, &mm->flags);
=20
-	for (vma =3D mm->mmap ; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma->vm_flags & (VM_HUGETLB|VM_PFNMAP))
 			continue;
=20
--=20
2.35.1
