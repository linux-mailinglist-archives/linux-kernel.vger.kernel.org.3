Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4215AF503
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbiIFTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiIFTuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:50:01 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD5C5FAE3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286IdbYx029984;
        Tue, 6 Sep 2022 19:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=B8vLfVMHYyq9eMWnxQSuV/JdLNr2sKQ59ECjk8k/jxg=;
 b=cF9Z0SJB39I3oWeDSd3vhASGKMwajfIWGQCZere6s4ZKIpNDANthfRGTBGHb0GBJsGQv
 wyjC2FF2PvSiYpJE5J9ZySG/I8atuI4HVAuwrSPr1E8iJ9yzGDfLIN3ejCd/nmPnSgSV
 z8laq0VjeFFpfeLoU6KB45+Zf2+0i2Y1/LQ0oil38LLLlNK/mRZejOOdbfZnCwSyB8q0
 arsEavbMRADdvBpCIAxrUiFSOE3rStMdFo7Gvw5MNQx6m5aOLREtCGxoEou11ghmjoWK
 OVaCz3m3Cg9wiShWe+wN8jZiU2wOrUW/dPXmWxYy3tCEg4ffSHW7xnVHguh3YksEGiz0 nQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbyftpvcv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:41 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286Je5WO039711;
        Tue, 6 Sep 2022 19:49:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9m7j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DHy5Yty+XNUCUei+XQiDIK86v74pZLMvTktMJM8dcJP7/4Puz5UitMqdFymJbHyunfP7hScZDorp2M+cH3ai9GDPf+2xofWIYptiW5P556AbFrPJwvWV4RKcw8MAyuuQmgFlre2d2fvJsT91R56On6lzueq2XTkn9mUdAETIfpR4LmUQUNyF31DgpMglqwTgxgcxigEYgZnoBjKvc380N6+sWG5vbq+Kdrw8AvZtOE6iCKwdj6ebDJINIVPxSVl8lX6kiSvMwe7eYy1tlz4+014xQ9oHvAni+1JgeU5SmDiIEwDXEdtAQgnzfG3qSgqj8cYgPrWiYG81QId9CFzpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8vLfVMHYyq9eMWnxQSuV/JdLNr2sKQ59ECjk8k/jxg=;
 b=gvIASdFIdAkiqitMO1LP6BWNZ5VD46nyQcyhoF0hDMJ8BLKK3sSUbWZbf2iV9X+1DvtI9clgDMloIhXYGhpLDcWAIJbqcT04VoIgWwc5rMyYHk/DYelR7S6w5sTibSzPwsAnfVcVNqRSzgu22BzXUO6YxbT2qJQX2VaDx43ygm+ImN6iodMRmmgvieQDJ7jKvtSL283HNJhqnMyoEXcAPA6cgtunqiv3pzCqSUyLfgqx/5Xu5JFfVjNeY64A6c50n0PXXJR9yZ9/IINtWhZbwIZN2BNRr/kWYwnwk+uZgh4+taGQxplbabxoUOAIYGrw0bq1jUTSBej6ldZgpcPi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8vLfVMHYyq9eMWnxQSuV/JdLNr2sKQ59ECjk8k/jxg=;
 b=ZANBp2h5uANJ6aJFTsmtZA17uqBGU798Do4xPcQs40sdkpw/F39MyegJ/vD7tWocdS46iTB9tmNyodRUyAKAnrauQ0v1kA9+65+lmOyFMtPnKjAteh4760MzcHr0tBHPp1ZucL3Tnas388AI06DuyQi5/QLpGSaqAEXjze2jSG0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5598.namprd10.prod.outlook.com (2603:10b6:a03:3d9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:49:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:49:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH v14 35/70] x86: remove vma linked list walks
Thread-Topic: [PATCH v14 35/70] x86: remove vma linked list walks
Thread-Index: AQHYwimypKb0MUGWG0K8mHUGpo+PcQ==
Date:   Tue, 6 Sep 2022 19:48:54 +0000
Message-ID: <20220906194824.2110408-36-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5dc4d55d-bd55-49e4-e06a-08da9040ee20
x-ms-traffictypediagnostic: SJ0PR10MB5598:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s36OAyknJCwktCJmM8qhocHdQXBeOgPdoEAoSzdKrbuckoa9G/xDcqOOCf8+7+IoQX1MHzmFa/onjp00NYNXgqnbQYwq6Ewnk5lPS7ox2QLcaU3mgpCMPk2ydpDm2f/fiVEWZEwrAE+wSo8FNQbZMVxrZxTca/4/lyK8W8fWXlyA8qcdarynBxiPnvvZAcyN7wsUyVOIJfTO3cwzAGqcESG+zZYNbPLQM0n1jPu74sNS4HpGPRhdjvCvu0NKN25UEzHgD1Xg+t/+Bwuz3qpMJ6i2RMhwVyS0THWgK5Z+8mmA3LNhI5sbk0w4Jj9qiRp+olviJtTE8lv1lJeuRkxu03ijX1dtHLpxwXxzM3fbzmZmHs0xMt9t2bOK/I0sm0z1ZLXFu1gL/9C0i6lBPOoPVSfl8qPZTSGjb4MyrbtIb2P7uC61dJdKAg6dNV4fSqWVYaVsJBn6cVcmW/4aLqEnT3KnmfNupUVPm/T1UcbLRd9XS+BY7gaQIMpU22q7J4k/07CxmpaeyG668ey8PRcFs44A9cDupHf9cDgAxJ6PcDzTUuJE5SViy+WnYMHPiHBuUKgI76LsD4TSXg8Ej1yggUdfecpQs2gLnaTU3ntwG5Ku3lsIkLLsY+pq7a212yuG4g2ML16OUyviLmC7nTCpABQ6aroFHCsX7aPWjDumWNVqPBsFK7912ScQORSwM4ODVFuWjOsnH3OaB0CoDNUqIGAv2JxzJ4qxHd06XKx5MKhJn6EjbHp2S2JPl8LK/AScfKshG7ivU82P0OKpyANJgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(396003)(136003)(376002)(366004)(64756008)(66556008)(41300700001)(91956017)(76116006)(66476007)(66446008)(66946007)(71200400001)(54906003)(110136005)(36756003)(316002)(6512007)(44832011)(8676002)(122000001)(2906002)(6486002)(4326008)(186003)(8936002)(5660300002)(478600001)(38070700005)(38100700002)(2616005)(86362001)(26005)(1076003)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?b0Sb5EFiCkpTcZa6sTWo/EAuKEV/z7q5K+ownc/gbDOl0hR1mWWD5q/MJB?=
 =?iso-8859-1?Q?/llYtDb/BlDm1xeavGDZGU3rgjnvb4Q2kxgbDhvX/iosKkKQU7lopnwfiJ?=
 =?iso-8859-1?Q?4SgTD1N1G5huE0SVap3rB+d+qm+my5gdlSjDdROjqxKQz7DN9J08T4QJYG?=
 =?iso-8859-1?Q?bm3X5QSb7koKDxEhRpbPluwMpjnCBt/WJ6dA3rgfHTqq4BB/Kx7nBv6HNO?=
 =?iso-8859-1?Q?WtrWniv6Lka6W6BaB6ic6o5OofMHvdCOTdF+GqfgBJ10Rkj1nOX+mKZz6k?=
 =?iso-8859-1?Q?x8VCOeK+QLKqtnB98Av+UIBmP8yhhf5WcwcO0OX1RJ+2o+UYhqJLNoHoyW?=
 =?iso-8859-1?Q?S04zAueRDGVMT0UBb3h6OsmN3AKbSXec4Jl8m+Bn2uIUkQnwfK4AzpvW4q?=
 =?iso-8859-1?Q?/03+fPxEyOrPkh09IBIeAWy+5s+too4Xi+8iDh/aBbb0ncvj4EMNSmpWY5?=
 =?iso-8859-1?Q?2Iy7QlKptbnDIq1LaZf0qk3Zu1uY4S1iUxUcS+NTbsu8vmRrjoxsUfXyfZ?=
 =?iso-8859-1?Q?sLR5GVRHCcINCq5nOvxebThKb78myl5dnkkhxtHgGc0o9xk8PNi807Ju/E?=
 =?iso-8859-1?Q?/8ifVESwkKi2DS4kAEv9GZITD74kY5Ck8pw66PlP8q3fWz6SHDoYt0Shut?=
 =?iso-8859-1?Q?uRTtdYtYodVS2FqK6nyRZkq/ExJaxQ57QfnAxxxJeJj3n72IQjdxaPTOLc?=
 =?iso-8859-1?Q?322CaRaZufv3AEmwvYtTy4ggIvpLF8YX0ZbIqLVqOn/pzYhb3H2lrPY7pk?=
 =?iso-8859-1?Q?FtUVv5aa6PwTwOVHPu8Sh1UqVwrOXWfU+fi/T+U8PH9rt6MFJZlHolF/md?=
 =?iso-8859-1?Q?CFDsPC6jLSRDfk7L7z+GsG0zqXSVbqROWKCWJET4A3BWtUZQw90nfxiMx4?=
 =?iso-8859-1?Q?dCitHLmJK/75XJ3pcDMnBcBgg04MPfqFdoYOjyLc1/pdMnhYMyCk4m8kYE?=
 =?iso-8859-1?Q?Ng+gormE65TixjAvAml6q1EhTwWJ1NKGN7FApM2ZWie9HAPgjaSN44lP2n?=
 =?iso-8859-1?Q?FNxP+SJ4Gs5x3qUB8KMr6rIS2U6Xb2aoaDuoF4oK6pWDc+SzddxofveJGR?=
 =?iso-8859-1?Q?uu50BHohx+qfi0Xg40gGPeIO27TWlJOxoKuPzQkreCAYmuZ45BRcrVXNVE?=
 =?iso-8859-1?Q?rBcHvyxWHZXKV0qYyEYw8RkGnNdg//8enSXa1zLE4LQLm66Nx9qG1BuWfp?=
 =?iso-8859-1?Q?d0BBXcLSbA5esZhzf7RqqohKufrQWqLZsulAOAByBZQb714m1GCAIR6IsY?=
 =?iso-8859-1?Q?sAfIy46xI1CAyOzw+WIQ1IT/iWzn+2nEQ6yBOUK3Mxd+Fb9cIbjgkRsTL8?=
 =?iso-8859-1?Q?cUTzmnOEOBwWEWrdSP6YhVV+/YatbcG790M8AyXmwX4MP4HG5LeRJSv7mp?=
 =?iso-8859-1?Q?xmlpiz1BVM5W77WLrLi5AhROIVbc5mZEE7xuFP5SS2YE8nyi1rxnGRciIt?=
 =?iso-8859-1?Q?Gs3Kk2G/YNL4+podG7L/v/uQlMZ2U+qFsT+QcJ2VuwSOfXOqLadLyrMgXA?=
 =?iso-8859-1?Q?iMwtDH8O38FqNg19wcL0QI5016tEjTJDsFMNVZiPplvkrnze8u7IG60+nS?=
 =?iso-8859-1?Q?oPnx1vEuSGdh3qtf2duTckF8gxo+5NhtKURk/6q8HZNReQ/N2XUvdeOVRX?=
 =?iso-8859-1?Q?bWuJx9POZjhGqoXLArKwHbQFBZne/G4PNxpwnt/Wj1z+r6AS9DzXBioA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc4d55d-bd55-49e4-e06a-08da9040ee20
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:54.7095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oeGmVoM+8Z40Le8IRvQXACcobzycbM8HR+IwaeojOEm95VkkS1hINo0sGqGhgrABEBtCiUZcKb+HokcNZAsa/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5598
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060091
X-Proofpoint-ORIG-GUID: BqVgPumVL1CtSbWWbkEQwR8ik72UoVzh
X-Proofpoint-GUID: BqVgPumVL1CtSbWWbkEQwR8ik72UoVzh
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
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 arch/x86/entry/vdso/vma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index 1000d457c332..6292b960037b 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -127,17 +127,17 @@ int vdso_join_timens(struct task_struct *task, struct=
 time_namespace *ns)
 {
 	struct mm_struct *mm =3D task->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_read_lock(mm);
-
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long size =3D vma->vm_end - vma->vm_start;
=20
 		if (vma_is_special_mapping(vma, &vvar_mapping))
 			zap_page_range(vma, vma->vm_start, size);
 	}
-
 	mmap_read_unlock(mm);
+
 	return 0;
 }
 #else
@@ -354,6 +354,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 {
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
 	mmap_write_lock(mm);
 	/*
@@ -363,7 +364,7 @@ int map_vdso_once(const struct vdso_image *image, unsig=
ned long addr)
 	 * We could search vma near context.vdso, but it's a slowpath,
 	 * so let's explicitly check all VMAs to be completely sure.
 	 */
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
 				vma_is_special_mapping(vma, &vvar_mapping)) {
 			mmap_write_unlock(mm);
--=20
2.35.1
