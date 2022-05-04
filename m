Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0348519328
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 03:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245019AbiEDBL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 21:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244972AbiEDBLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 21:11:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D7843494
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 18:08:03 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 243KsJaY018676;
        Wed, 4 May 2022 01:07:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8QKs2gSYzPPBgxZK5xrK7lu1dnVZ2IBu7Fw4Vk03jlo=;
 b=XPnueJezGLYy8eJ/GxE6AGWGflrk6LJWLEXE86j+lD7o2fmMGoC0LzA5qun1WblukZhG
 p61PdlLl/qYGTShQ+RC4AU7xJU0O1tAVHMpOzjT8ITGr4/DTESkt7jCflUX0UADJokBI
 FpiBJWgTfZPmebRYa/R4V881bG7tI3rinxdhbvEeYLCSAw0uajGVWguST7Hw4P6CVAWT
 EOEtTn7J7EwYtyqaoNfER/4oWWYYY+71siDbHnQ0PShZ1d2JAXoL+aGXA4JEX2MdUbot
 zhL1cuPFFdGhuGBEzqD998vG6ZHiK9XVoZgy2JJnpS9RVtHiFMQHwKDzmxqKQVDyZWdY 6Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frwnt74av-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:56 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 24416SvI039119;
        Wed, 4 May 2022 01:07:56 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fruj2wdr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 04 May 2022 01:07:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hfYYFfkMiVj1xckv4QcHSpGLYn1sQ2rI89w/LOJm+Kn7gsZkx/X2S5A7cMc0KL1EqiNGbVSMqwEtNj9MN0flwB9TsNIyWKT9fAaRUHdCiibrEiShuOAX1+41PlHfYTWesnbjPZUnsiWuZ5iIWM6yYqHmCLqQfY475XaBmZ5iOSIuPKpyBWCyjAFPPFNSBReWlej31/V2ZZCKNxOnoCZDTglRvt42W0ebpQqgCzNCkjPULxGHaKMSnke9xJxdcuc9niNwOUElVgubCVt4wyzxYHM/8odGAymlqIRySHTFiFfB+B2MCchmHZ8l0ACyH40YFGjp7If1Wkwi2V/OwktVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QKs2gSYzPPBgxZK5xrK7lu1dnVZ2IBu7Fw4Vk03jlo=;
 b=er4HznssWlpNZ491mVFGN34mJMlAECNy3ymM4tOJnEYYJQ9+0cnynI73lHyULU6UVJc6WCSy+rKfwAy6sTbcN9dZdMbj4TIjcUSne4vbY5pRkw4tSP/SKBKghvVHRFuPJKpLFQ0qGqo5Rodgenq4TKKIYDoz+c/S3EHbXXd6UNfuBfYFplyW5Px+7tt5+DJGNm4RlQeRixyd/D3Ccnawf8MQFAVryYaUUprdALT9A/6ddcb9JcLt7my7uC6vnxcV8RhcjUz9r15dgE8VNzxrFMrlaFchLzU28KA+l3KRZaBx1bb/MFXhn8e38qOPbmcN2cvTrRc95nvPsx7A0km1Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QKs2gSYzPPBgxZK5xrK7lu1dnVZ2IBu7Fw4Vk03jlo=;
 b=c1nmeBiALEn+NBFHQwSgbip/NfvEYQkJJES6FUya7g7Uqxu59YSnri36bSR8V6KrQw9sr+UOCir0Z3gNZnllIpUM1Te9x0ArRIVUnRvcR3LjzmCTcoaM+hpvNFeL8rCOoSN4k2U5RImYDYM+ScJW5yAchYG0rOkp4QorbatHuGE=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH2PR10MB4214.namprd10.prod.outlook.com (2603:10b6:610:a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 01:07:54 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::318c:d02:2280:c2c%7]) with mapi id 15.20.5206.024; Wed, 4 May 2022
 01:07:53 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v9 09/69] mm: add VMA iterator
Thread-Topic: [PATCH v9 09/69] mm: add VMA iterator
Thread-Index: AQHYX1Nh9+xuVY+kykGmvwBuYAS2JA==
Date:   Wed, 4 May 2022 01:07:52 +0000
Message-ID: <20220504010716.661115-11-Liam.Howlett@oracle.com>
References: <20220504010716.661115-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220504010716.661115-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21b494c9-6165-4d57-21dd-08da2d6a8483
x-ms-traffictypediagnostic: CH2PR10MB4214:EE_
x-microsoft-antispam-prvs: <CH2PR10MB421407DD6295611A0932C0E6FDC39@CH2PR10MB4214.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ie+4b1OJHtR92OLrWSjhRMgAplTNiEewTFswvnp7Lgcje0BTUhsP1KjvICQMMIc+sccyFneTNA9fnAm+d3gRkB+RZzLzPlxRMb5VsjgkX5uv7PNXSuPHBoagx6Nj1BffEuLhbWxC1wwMn7wXZLGIffFPQLGEzUkncQ/Q50996LZKp2TGlQJBZ7obVqv0m89f2OzGAqhfWgVPvNRmwteV8BfmmS/BlzUD8ZTU5jB3J74Bhqd+8RwitvOY92E8kiENzRpLOqYVPr5br1kksaHm6/P+kwHhgkt4fWzbmSHyEECHzwH6J1za99+tHNJNMeV57TThiTjOxI7S4UHHJhprouGwLeDWBGOUt1/eRjtjTrUykFPyUHVkf4VOAJAhFtG14SRrHq7BhiiG0VW+NbfJaQpzqJJvbFmeLmWvu1XcUw7h0tQZGCTCwDNrpaIKx0oSGQYYWR6VtuSEUp4crsIaiWtbZQlbtqvCdKMF1mO36EAZuBipdksMxDUN2haeSKo48IN0TMU1t6iLRQuZXQ0aoHfcn2afNk79AYq8v+7PnMvasxwCWH3uDJBafukETJym9hzxi0t1BV8xp5ItzkM29POOvkhyJ5eZVSXOJpvS3K0gH73z1ho3cBMbQ81fnb4LUEg0C/RUpDl6mxbFuu1Ze+Y4iI9ue483agwJPo8tvBaIB7fT9Y+SBOoM/WjJEADUCaOIoM7YlfP39ImRkcKckg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(64756008)(66946007)(66556008)(66476007)(8676002)(76116006)(83380400001)(2616005)(110136005)(186003)(1076003)(316002)(6512007)(86362001)(26005)(2906002)(6506007)(71200400001)(36756003)(5660300002)(44832011)(38100700002)(508600001)(8936002)(38070700005)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SOc2DDju1Kt05JQl+Q8EqWMXex1gv4lqFKr3ERsfARUOPOo+pRjnlRhA1y?=
 =?iso-8859-1?Q?iSHeFNZmCIVPl3mu6NNh8ya7lDAfyJWgVux1s00OHb3OyaTzuj13Q7xTDh?=
 =?iso-8859-1?Q?y6Tm8VyKJhrKYKtfMGG8CsqIL45KpxOD5bjOyOZQ7/LSRoyjZ6twV/XSpw?=
 =?iso-8859-1?Q?810I/e3sJMbldrqGRi941YsLUXl1iylXz6dC4yt2e4QgEGR8+sMBuTeqFH?=
 =?iso-8859-1?Q?Uhc2r8OXsULkdRcG6c2LGgwmrX1OcklCOMLEaSvrNV1Vzo5whmcRhgDtke?=
 =?iso-8859-1?Q?ejHc0tWRxlPpKZjwFa7hijifZrZPmcjaYpwVfb+y0NGyjJ0ALKLM+nHydD?=
 =?iso-8859-1?Q?7K/+PNld1KJZTLLvSEqCAr7C22gPSNZygw0ELE/k/gFAtt51C5JgLregTz?=
 =?iso-8859-1?Q?/sRKtkhJVm/lEsEJchy1bMRtksxeFc8DzUSoJjJLGprtifDyjpFBSBVym+?=
 =?iso-8859-1?Q?T8CGDjxPS2opTtmmp4UOFVhvnG085gBeg/+K6dKbsbU0iyfEV2f7ELFUHa?=
 =?iso-8859-1?Q?f9cxvuU/twvmKSxRf6oZ3obkCHBZtI32tpqtdToV11te4YI4Mz6CYjwpeH?=
 =?iso-8859-1?Q?V5oO8NqKqsIa6oimj4q3v9tjRxpnByG4KrfGdxXqNaMMZLKYpuPWenuLIz?=
 =?iso-8859-1?Q?VsN0k+gsAu6koN6yAhgo4HCBU1/NgFRGLvWW5uJ+gkI4HN2SMZtjYt7Nrl?=
 =?iso-8859-1?Q?MZpNmOVBVW065hGIw8JzBZM6JgRYYc8O22G84OHjnIlbusScMwPxM3o1gM?=
 =?iso-8859-1?Q?hsoIeuOcI2CqJV5HI9A4scxYEPGR41vG4AXyYPt9tEdcjmqlfzxpz+urZh?=
 =?iso-8859-1?Q?wWO7vGq7FzPH58g/wBl8lbUfwgKwhHtSoiS5Qvj2w0O4rx3H9Dqm/QVgOi?=
 =?iso-8859-1?Q?JQZhdbgjMdpRRsKCbsARyfQIxFespeZ2qP9X0lNEOD6qE82PLN1VdTjfNv?=
 =?iso-8859-1?Q?7+ECLAZFvAjFbJEgZVnrYlHFEUwCkCiyoPxu0uxd6sySFu+xIAfFiCZb3R?=
 =?iso-8859-1?Q?tPllJC/fndQg+CBwLt1BViu5il+LxI2MhYO0GbjVQ+JhVYhaDsmoM5dQpq?=
 =?iso-8859-1?Q?LbTouRQ6PXW0IGjy7vKejNLyQvyGznyLturkw15U0TFesL1iWtmDU0z5IR?=
 =?iso-8859-1?Q?v1nEXB4qQ7aZQdrjzoM9oCs0TwFjtZ7j51aQff42Xv5xLuOYOXnGODhIcw?=
 =?iso-8859-1?Q?2PpL41PPv4zUNKhv0JqwkrvahseTOwFcxXMtLI4g2i9WAcW0gY8czC4Krp?=
 =?iso-8859-1?Q?m0MIRyCThcfsFlf45k2Wk74DmuR9NVdJyYFOkfnD6MbSoCF/V/wmdMDLlO?=
 =?iso-8859-1?Q?SkyBy2+7C/P97ei7LXknrHvjy94NRZFAZVSAyctxFd0/4fHjPWM1HHy9dr?=
 =?iso-8859-1?Q?T/mz81zBkR+DBWfLRL3T5nbJukQGhcaCumWR5VUddLT2urw5TwEUTFDpAn?=
 =?iso-8859-1?Q?E+zEumCHLs8UZRObosFaVkkQhzB7BfWkSz8z8d5AC0uwv7uJFPu3CuaGbC?=
 =?iso-8859-1?Q?gn2Rt7/0ItD/TmcZaBPEDOMikyYbLbYM1eBSPq9NFiSqsnaNnPsXELjegi?=
 =?iso-8859-1?Q?/T8rSkZa6N/LN9o3+q+ToqvyEEOlF8uf1yfd4Ka3+hLyH4z0bYXH+uqPdO?=
 =?iso-8859-1?Q?MIymgXUuxxH+iTwf2sCPo/ADwuJhDblQN4E3K12TNc/pRJHfVjH7LNief+?=
 =?iso-8859-1?Q?OWk3UAYXSpbMhXhLbaNCaosrWS5dqaTj+dzN4asVfl0vgJKk4MZMdKXmij?=
 =?iso-8859-1?Q?Q5atnr8geVgEPQiyYkgWLan8z0tm94rSmY22jMeWbI8VCFIwg7qR3YXTBf?=
 =?iso-8859-1?Q?VdZGUkM47WL930MdhuptlVdrRczlRCk=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b494c9-6165-4d57-21dd-08da2d6a8483
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2022 01:07:52.6660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: touNDLrbreA1reNj1mF6Hwj8tjHZr9mUKg8iIw6NxIkhS7xi5jobUhnQSscAi9lEEAhjHCYM0lZfCiEuQVd5Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4214
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-03_10:2022-05-02,2022-05-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205040005
X-Proofpoint-ORIG-GUID: FlbEeyBNCcCBwOQVlWWe9Xqjv9QNrOao
X-Proofpoint-GUID: FlbEeyBNCcCBwOQVlWWe9Xqjv9QNrOao
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

This thin layer of abstraction over the maple tree state is for iterating
over VMAs.  You can go forwards, go backwards or ask where the iterator
is.  Rename the existing vma_next() to __vma_next() -- it will be removed
by the end of this series.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h       | 31 +++++++++++++++++++++++++++++++
 include/linux/mm_types.h | 21 +++++++++++++++++++++
 mm/mmap.c                | 10 +++++-----
 3 files changed, 57 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d42dc897a913..9d9b0d96433a 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -658,6 +658,37 @@ static inline bool vma_is_accessible(struct vm_area_st=
ruct *vma)
 	return vma->vm_flags & VM_ACCESS_FLAGS;
 }
=20
+static inline
+struct vm_area_struct *vma_find(struct vma_iterator *vmi, unsigned long ma=
x)
+{
+	return mas_find(&vmi->mas, max);
+}
+
+static inline struct vm_area_struct *vma_next(struct vma_iterator *vmi)
+{
+	/*
+	 * Uses vma_find() to get the first VMA when the iterator starts.
+	 * Calling mas_next() could skip the first entry.
+	 */
+	return vma_find(vmi, ULONG_MAX);
+}
+
+static inline struct vm_area_struct *vma_prev(struct vma_iterator *vmi)
+{
+	return mas_prev(&vmi->mas, 0);
+}
+
+static inline unsigned long vma_iter_addr(struct vma_iterator *vmi)
+{
+	return vmi->mas.index;
+}
+
+#define for_each_vma(vmi, vma)		while ((vma =3D vma_next(&(vmi))) !=3D NUL=
L)
+
+/* The MM code likes to work with exclusive end addresses */
+#define for_each_vma_range(vmi, vma, end)				\
+	while ((vma =3D vma_find(&(vmi), (end) - 1)) !=3D NULL)
+
 #ifdef CONFIG_SHMEM
 /*
  * The vma_is_shmem is not inline because it is used only by slow
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 645715a4a89d..e3c7855fc622 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -691,6 +691,27 @@ static inline cpumask_t *mm_cpumask(struct mm_struct *=
mm)
 	return (struct cpumask *)&mm->cpu_bitmap;
 }
=20
+struct vma_iterator {
+	struct ma_state mas;
+};
+
+#define VMA_ITERATOR(name, mm, addr) 					\
+	struct vma_iterator name =3D {					\
+		.mas =3D {						\
+			.tree =3D &mm->mm_mt,				\
+			.index =3D addr,					\
+			.node =3D MAS_START,				\
+		},							\
+	}
+
+static inline void vma_iter_init(struct vma_iterator *vmi,
+		struct mm_struct *mm, unsigned long addr)
+{
+	vmi->mas.tree =3D &mm->mm_mt;
+	vmi->mas.index =3D addr;
+	vmi->mas.node =3D MAS_START;
+}
+
 struct mmu_gather;
 extern void tlb_gather_mmu(struct mmu_gather *tlb, struct mm_struct *mm);
 extern void tlb_gather_mmu_fullmm(struct mmu_gather *tlb, struct mm_struct=
 *mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index e777da0132f6..7e01bab46416 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -632,7 +632,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
 }
=20
 /*
- * vma_next() - Get the next VMA.
+ * __vma_next() - Get the next VMA.
  * @mm: The mm_struct.
  * @vma: The current vma.
  *
@@ -640,7 +640,7 @@ static int find_vma_links(struct mm_struct *mm, unsigne=
d long addr,
  *
  * Returns: The next VMA after @vma.
  */
-static inline struct vm_area_struct *vma_next(struct mm_struct *mm,
+static inline struct vm_area_struct *__vma_next(struct mm_struct *mm,
 					 struct vm_area_struct *vma)
 {
 	if (!vma)
@@ -1333,7 +1333,7 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm=
,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
=20
-	next =3D vma_next(mm, prev);
+	next =3D __vma_next(mm, prev);
 	area =3D next;
 	if (area && area->vm_end =3D=3D end)		/* cases 6, 7, 8 */
 		next =3D next->vm_next;
@@ -2856,7 +2856,7 @@ static void unmap_region(struct mm_struct *mm,
 		struct vm_area_struct *vma, struct vm_area_struct *prev,
 		unsigned long start, unsigned long end)
 {
-	struct vm_area_struct *next =3D vma_next(mm, prev);
+	struct vm_area_struct *next =3D __vma_next(mm, prev);
 	struct mmu_gather tlb;
=20
 	lru_add_drain();
@@ -3061,7 +3061,7 @@ int __do_munmap(struct mm_struct *mm, unsigned long s=
tart, size_t len,
 		if (error)
 			goto split_failed;
 	}
-	vma =3D vma_next(mm, prev);
+	vma =3D __vma_next(mm, prev);
=20
 	if (unlikely(uf)) {
 		/*
--=20
2.35.1
