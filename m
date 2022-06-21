Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831BD553C24
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354605AbiFUUyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354584AbiFUUva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:51:30 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C7D2F66B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:52 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ1TEM009747;
        Tue, 21 Jun 2022 20:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=17iF/6SaNvYwMjyuuD1E7BCjD5uBK7Zh68R1Fl6oUIc=;
 b=vyD2kOtqfblLvYrE78p5WMjqjBiU0tPzjIErFhczUbiBLY8FGANOLz0flhAx/s3ustr0
 m2EQ2BZ8IDHSLRSRYDQ2voxI2BcwCtNulyg4UOZFiVKsUfAfWGyIHZOZgLkmhB4XHLS1
 ET5bUwXZrpV6rfFo4Da+g+5HPCx6FO/aJ76grKDTM0V8wWkQOzZ35RWK/1FX+pVCaerf
 InhD9a71N1LfVkKX64y2w17eXuJjvCuwpZrZQmKvxmWXcIK6PIKbE3U7n+bNqQFOQTAG
 cxzMI/cTAVt/65VwBOX3o1Rllp9aHnMqAYNoIL63sw7YNwE0AmUqcqcrC28uxi26poFS 0A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs78txpf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKdwkR010169;
        Tue, 21 Jun 2022 20:48:33 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gtkfuvv7n-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+F4gL81VgF3oGAfiLRDZg3yd0+lmroWMDrJ5y6zUAcGHHorHs3+ZFIEEN8QEHrr4K2Ydil/7CsgkafOdR6FaYJaNrJmKp4me2uxPR1wYbhnR/rhRaqt1jqBGVcfvzuvs/j54jAMCfuy0ys0Hjf/Q9bxH9d4Ngg/wsg/G6/9BqsJfOVFlUYigt+Ukedt8MkX+mJN0mKsLY/dupYLwHE33XqrbrJSHLmtm+CKuA8aSQRapQhkxoamRNvJVXJOMjj4yHMkIGbyDorE4kUci8fl2gwwluO53mKXJYhZFCuyKTYmq0F4+zj/5egNOMGSbudPYixESQMen239pRlY6JIm3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17iF/6SaNvYwMjyuuD1E7BCjD5uBK7Zh68R1Fl6oUIc=;
 b=mJDoTzOh0ENb0YKmAIE0l+Wkxgv4yGbF2WUJUvP1oR0rIaI5fsCRLmCugTSvD5WQl+a8cwbQbqG5K39+SdaBw0h4modUd+EvMSCmYzlgB36fR2+n3gLqVp5HHz1zj9UPjbgnJAPOomfv3iDZ/M/+wE36HC8AOCTgQwvQkM3+AfeKwOzkSNm7fYyDjuygs8btsZQfIRiqS/Z+GyrlrA/SFBnBR8oauJS/0QXCtkOOvQilSdQvos6R4bS3kX6kULHsJ+6KVUH6PY6I9e8Jm3Dftr3UJMpLf27vdq9qGjZg0kurifGeuPc4MxASNRfaUkPe0lTx5KRPK5Op7ZdSIIPFeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17iF/6SaNvYwMjyuuD1E7BCjD5uBK7Zh68R1Fl6oUIc=;
 b=ljV50zxz+irr0luIKjaNKy9kVUmY2G9THVLCC3XS228MiiFybDFsC09oxLl/9IkE3yHxUboVB7DGBkRs/PcIFWuUi4caBuqzSvzg6OXd7AttQfbjoyoeGzgO619Iods7eAsVoUYWl1QpQj/eiU8WNUnAOJBmkE9y59o0dFod3Og=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN2PR10MB3869.namprd10.prod.outlook.com (2603:10b6:208:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16; Tue, 21 Jun
 2022 20:48:29 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:48:29 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 65/69] nommu: remove uses of VMA linked list
Thread-Topic: [PATCH v10 65/69] nommu: remove uses of VMA linked list
Thread-Index: AQHYhbAVANQogcJhHkiPS2PerxU94A==
Date:   Tue, 21 Jun 2022 20:47:13 +0000
Message-ID: <20220621204632.3370049-66-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5f8bed3f-e788-4c43-b626-08da53c765ac
x-ms-traffictypediagnostic: MN2PR10MB3869:EE_
x-microsoft-antispam-prvs: <MN2PR10MB38692A264BB69FEBD589F258FDB39@MN2PR10MB3869.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B4YopM1cmi0ZjAd/DgY9RQrAdbg/S8CoP2iJg37ZQispagKH8s1v59/9cjUZeXJCnNREdLnQSidVLU6580qwUzhUoPyv840FiBZQaz9+2LgxKk2SO3RsIoOJwa1f/h970F4D7LVwolmSC/JR8vj32tQLOzPCQrOIxyByVX89XWA7Pm0ztuhrF4hn7fujWB5nV08o8kOkpfOsRSiPL7KVPG2N+6cJK7MwMEZzsAVUr29+UmEi/SzEvtQM0AGCCAyiiYTZCS7lHHlud0HWPD8yoTTUtdD8DIBo2+g0IEmCMmHCoeb604mOi0Rmzo0SzV6H/rTHUtGAOWGjNO1VR5C5MMzm9c8okxphVqKJ6VuAU9M+Gj2l3AEYxpyISTQi53yu0MtO+CDJp6IKhDGwiPLoFpATNzw8bTiTqN1wOJvv+9V8LeXeX4GsTQ+jTj8aScqw4cnAJlNBcJKFB38QD7ghVBHTsYIZIM1WF/O68N+U0yQOUU/7spnlrYf+7srUym3WJR4aRGDqwP7tWcwFg3+3co4yGLYzTv/qWIMXEHkZix39oFvpIjHTiKbCtoxioA0JsZDU5RCuIAvEG2A6kxnCSndIWzGmNroEj7eASi0ID95k4QuFXhNK5xQo2qaWmGM7a/PIDxisnt1uECZ7tOCWLQ9wSNkK1C6GbqYvWyWfB0+UKOsG0CHRTHNkw95ZTGXg18qywn41QPTCBm8Lb5LawpGnjXDV3EyQGSdGYP3UiCUBkugWbEpcqztZ1oBqdQqlZw/1X5VTxGm9YLdvzthWEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(366004)(396003)(26005)(6666004)(2616005)(966005)(91956017)(6512007)(6506007)(186003)(41300700001)(1076003)(122000001)(83380400001)(38100700002)(44832011)(86362001)(8676002)(66556008)(66476007)(38070700005)(5660300002)(316002)(2906002)(110136005)(66946007)(71200400001)(66446008)(6486002)(36756003)(478600001)(8936002)(64756008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eWNlFP+1pRF9fj2A0AU5l6nKrdwhmxVvAKh4K0cv8gHTuY/DyoIlHy1Abx?=
 =?iso-8859-1?Q?b1mQ3fe8XzhDXX/GqB6RN+EVpefIolYslJTSJVt95d2DMUHdWlnYnZJQpU?=
 =?iso-8859-1?Q?uQszU3X2jpEi7BvMqF9oSiCeXnYBxhMSDBLhQPbgQe5RpeGKTE/IWlBaPc?=
 =?iso-8859-1?Q?uxWRWyyhmpX3vIurr7vrIbPhJB7OTccUozGQvHkpSMkxgw+OHYuJwdoj/o?=
 =?iso-8859-1?Q?Ffdn+I36VcHsE8DRkkKR01Y6rASF21urLeRxViBkpLLdI/4t8DvX5S1JLj?=
 =?iso-8859-1?Q?aZXRMDDiqujyp4ehXG7D7cfNEWbA/znx9T4efrpwkEjhmPCQ4VUYatPE9P?=
 =?iso-8859-1?Q?ZHZSlTdVGNt9fdl5OaEOfFabStOj3y7rXkZlKcz9/RWDvqA4EDVQeqiw8h?=
 =?iso-8859-1?Q?50NaVbFlgNWJlpt2la1YgoZ07NDevyh9UAT4GVgZhiUWlhnFKBs6TBaFOb?=
 =?iso-8859-1?Q?NiHGYWdwpEjreihVcV2sD6pjLmv7/BiY86jdda/oJ9IFRhkdXtRF+uShZH?=
 =?iso-8859-1?Q?O+ilj2i1nETAyQWIBxUWx+ZGj6vT18R3sZL4x+pwuLZuogOFArmvfcrsj0?=
 =?iso-8859-1?Q?Ro59goVMvGMdsguY5XKg0+ZESDZM9bgfaBkQ6Cqd6sI181d9PSsaI/JZwM?=
 =?iso-8859-1?Q?yxaEloes8xRfpV9niJkb1jCj55WDQk7EzpR1qK055eH68wqeFZRiLusblq?=
 =?iso-8859-1?Q?BLyIRH8Etj9FuLUmmo7fT9k4uZQpnuIWBzS/THs5uV3+raGovFGakYwqIi?=
 =?iso-8859-1?Q?IDuJij7RN/WEkDzjnmuC5mdlo3wjunrhBxH84ZF0l6KGgVqz5mnDh7NEDq?=
 =?iso-8859-1?Q?D5K0vI0N11ta9SJ2xxYChRaPxwV5n8B95K0OYUvAlKbdEsKCuXVOv1/9iQ?=
 =?iso-8859-1?Q?+7obPtbnTREQMxte9u+qY0Tb9gLzgthJHbQKY6vBvv58KuBzTFJ9W5b3Ay?=
 =?iso-8859-1?Q?1pOx7xiQ460q5wqj0Ss/M6YwOQmeMHBVbRdUQwDZVd5cl8eZTp6lo53dnk?=
 =?iso-8859-1?Q?vgAxNr0QSv8giBWhbHu1nXApBjdm6UEnTuRsqPdeu+pFP0JHWPrt/v34s6?=
 =?iso-8859-1?Q?76FdCsxvGqWCovUHQKXc4PKKzEi5EvYAH/2LeJMuWBSWJW6ORRT1UPvznL?=
 =?iso-8859-1?Q?+VPadURVwG0TQbPXQvDXNgHufOPxTNE0bsF/Xf0Poko8DkjE+xEdJLelpJ?=
 =?iso-8859-1?Q?mL6zTzTWCbm6xyB3gZWU8k4ExGWClLYFCqHUlCWI7POQlXkqHTw+ayF1E0?=
 =?iso-8859-1?Q?4HzxaeIpiUEBzudUvKONijY3aoACp1eDm0hJ2v+Smc4tig1QTiJw0QxmC0?=
 =?iso-8859-1?Q?YhmgMbHX0l+itLUD6WLkA+0gQmFTsVfPcR+BAl5uuuH2T/Panryk8ro++J?=
 =?iso-8859-1?Q?1mQpwhT16xtznjd2CzMVtXoI5cLZYZOWkmzkeEDRRgaRHQzOqbTqUZFhSd?=
 =?iso-8859-1?Q?mG6U367tVAJpemDbi29vHlvneeht621OJUiIj/OPOJlQUq2NQtUI8plFvc?=
 =?iso-8859-1?Q?llHiDxBBgNRpllxBg8xPe0R86OLe411trKrzETS+ilMYMI5BOsKpUoAI9C?=
 =?iso-8859-1?Q?gKbLy5FXRffl3vc9E/dP22r1+XjRgumsc+JSLr2eB88MpQaXwS5UMCXn5b?=
 =?iso-8859-1?Q?2K01kao97XCE+ekIXLTh64v4hW1/qcTxZMLI+r1kBUGyL0h7HHSv2nQo/n?=
 =?iso-8859-1?Q?aeoLarQLVJ58dcI+VeqEJ8H90my4KeusNlnf/78mU3Q6veBcsTnSlBQ4+/?=
 =?iso-8859-1?Q?YTlIGDW5qn2umw5olXXbrYKBNYlO1nIDPqNcY9HIm2PEcv7CQszxIYPvWb?=
 =?iso-8859-1?Q?MKdJDcuRyviPxAMm7Yx6NVEDz3IfMrU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8bed3f-e788-4c43-b626-08da53c765ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:13.6124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VXSWmffw67ulAtA+0baYvqq+eUMepfSSXjwl996Z9TYGVoi+QOcQG4G7wjNBIezC9yBQ3e1wOx5SwoYJTLN1DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3869
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206210087
X-Proofpoint-GUID: NJbEnQ8JEJ8T4ToCcx83K70iJUBaK08-
X-Proofpoint-ORIG-GUID: NJbEnQ8JEJ8T4ToCcx83K70iJUBaK08-
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

Use the maple tree or VMA iterator instead.  This is faster and will allow
us to shrink the VMA.

Link: https://lkml.kernel.org/r/20220504011345.662299-50-Liam.Howlett@oracl=
e.com
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/nommu.c | 135 +++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 101 insertions(+), 34 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 4ae252a785dc..f6b187090d95 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -557,26 +557,14 @@ void vma_mas_remove(struct vm_area_struct *vma, struc=
t ma_state *mas)
 	mas_store_prealloc(mas, NULL);
 }
=20
-/*
- * add a VMA into a process's mm_struct in the appropriate place in the li=
st
- * and tree and add to the address space's page tree also if not an anonym=
ous
- * page
- * - should be called with mm->mmap_lock held writelocked
- */
-static void add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma=
)
+static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *=
mm)
 {
-	struct address_space *mapping;
-	struct vm_area_struct *prev;
-	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
-
-	BUG_ON(!vma->vm_region);
-
 	mm->map_count++;
 	vma->vm_mm =3D mm;
=20
 	/* add the VMA to the mapping */
 	if (vma->vm_file) {
-		mapping =3D vma->vm_file->f_mapping;
+		struct address_space *mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
 		flush_dcache_mmap_lock(mapping);
@@ -584,21 +572,52 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
 		flush_dcache_mmap_unlock(mapping);
 		i_mmap_unlock_write(mapping);
 	}
+}
=20
-	prev =3D mas_prev(&mas, 0);
-	mas_reset(&mas);
+/*
+ * mas_add_vma_to_mm() - Maple state variant of add_mas_to_mm().
+ * @mas: The maple state with preallocations.
+ * @mm: The mm_struct
+ * @vma: The vma to add
+ *
+ */
+static void mas_add_vma_to_mm(struct ma_state *mas, struct mm_struct *mm,
+			      struct vm_area_struct *vma)
+{
+	struct vm_area_struct *prev;
+
+	BUG_ON(!vma->vm_region);
+
+	setup_vma_to_mm(vma, mm);
+
+	prev =3D mas_prev(mas, 0);
+	mas_reset(mas);
 	/* add the VMA to the tree */
-	vma_mas_store(vma, &mas);
+	vma_mas_store(vma, mas);
 	__vma_link_list(mm, vma, prev);
 }
=20
 /*
- * delete a VMA from its owning mm_struct and address space
+ * add a VMA into a process's mm_struct in the appropriate place in the li=
st
+ * and tree and add to the address space's page tree also if not an anonym=
ous
+ * page
+ * - should be called with mm->mmap_lock held writelocked
  */
-static void delete_vma_from_mm(struct vm_area_struct *vma)
+static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
 {
-	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+	mas_add_vma_to_mm(&mas, mm, vma);
+	return 0;
+}
=20
+static void cleanup_vma_from_mm(struct vm_area_struct *vma)
+{
 	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
@@ -611,10 +630,25 @@ static void delete_vma_from_mm(struct vm_area_struct =
*vma)
 		flush_dcache_mmap_unlock(mapping);
 		i_mmap_unlock_write(mapping);
 	}
+}
+/*
+ * delete a VMA from its owning mm_struct and address space
+ */
+static int delete_vma_from_mm(struct vm_area_struct *vma)
+{
+	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
+
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+	cleanup_vma_from_mm(vma);
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
 	__vma_unlink_list(vma->vm_mm, vma);
+	return 0;
 }
=20
 /*
@@ -1024,6 +1058,7 @@ unsigned long do_mmap(struct file *file,
 	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	*populate =3D 0;
=20
@@ -1042,6 +1077,7 @@ unsigned long do_mmap(struct file *file,
 	 * now know into VMA flags */
 	vm_flags =3D determine_vm_flags(file, prot, flags, capabilities);
=20
+
 	/* we're going to need to record the mapping */
 	region =3D kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
 	if (!region)
@@ -1051,6 +1087,9 @@ unsigned long do_mmap(struct file *file,
 	if (!vma)
 		goto error_getting_vma;
=20
+	if (mas_preallocate(&mas, vma, GFP_KERNEL))
+		goto error_maple_preallocate;
+
 	region->vm_usage =3D 1;
 	region->vm_flags =3D vm_flags;
 	region->vm_pgoff =3D pgoff;
@@ -1191,7 +1230,7 @@ unsigned long do_mmap(struct file *file,
 	current->mm->total_vm +=3D len >> PAGE_SHIFT;
=20
 share:
-	add_vma_to_mm(current->mm, vma);
+	mas_add_vma_to_mm(&mas, current->mm, vma);
=20
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1217,6 +1256,7 @@ unsigned long do_mmap(struct file *file,
=20
 sharing_violation:
 	up_write(&nommu_region_sem);
+	mas_destroy(&mas);
 	pr_warn("Attempt to share mismatched mappings\n");
 	ret =3D -EINVAL;
 	goto error;
@@ -1233,6 +1273,14 @@ unsigned long do_mmap(struct file *file,
 			len, current->pid);
 	show_free_areas(0, NULL);
 	return -ENOMEM;
+
+error_maple_preallocate:
+	kmem_cache_free(vm_region_jar, region);
+	vm_area_free(vma);
+	pr_warn("Allocation of vma tree for process %d failed\n", current->pid);
+	show_free_areas(0, NULL);
+	return -ENOMEM;
+
 }
=20
 unsigned long ksys_mmap_pgoff(unsigned long addr, unsigned long len,
@@ -1298,6 +1346,7 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	struct vm_area_struct *new;
 	struct vm_region *region;
 	unsigned long npages;
+	MA_STATE(mas, &mm->mm_mt, vma->vm_start, vma->vm_end);
=20
 	/* we're only permitted to split anonymous regions (these should have
 	 * only a single usage on the region) */
@@ -1333,7 +1382,6 @@ int split_vma(struct mm_struct *mm, struct vm_area_st=
ruct *vma,
 	if (new->vm_ops && new->vm_ops->open)
 		new->vm_ops->open(new);
=20
-	delete_vma_from_mm(vma);
 	down_write(&nommu_region_sem);
 	delete_nommu_region(vma->vm_region);
 	if (new_below) {
@@ -1346,8 +1394,17 @@ int split_vma(struct mm_struct *mm, struct vm_area_s=
truct *vma,
 	add_nommu_region(vma->vm_region);
 	add_nommu_region(new->vm_region);
 	up_write(&nommu_region_sem);
-	add_vma_to_mm(mm, vma);
-	add_vma_to_mm(mm, new);
+	if (mas_preallocate(&mas, vma, GFP_KERNEL)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
+		return -ENOMEM;
+	}
+
+	setup_vma_to_mm(vma, mm);
+	setup_vma_to_mm(new, mm);
+	mas_set_range(&mas, vma->vm_start, vma->vm_end - 1);
+	mas_store(&mas, vma);
+	vma_mas_store(new, &mas);
 	return 0;
 }
=20
@@ -1363,12 +1420,14 @@ static int shrink_vma(struct mm_struct *mm,
=20
 	/* adjust the VMA's pointers, which may reposition it in the MM's tree
 	 * and list */
-	delete_vma_from_mm(vma);
+	if (delete_vma_from_mm(vma))
+		return -ENOMEM;
 	if (from > vma->vm_start)
 		vma->vm_end =3D from;
 	else
 		vma->vm_start =3D to;
-	add_vma_to_mm(mm, vma);
+	if (add_vma_to_mm(mm, vma))
+		return -ENOMEM;
=20
 	/* cut the backing region down to size */
 	region =3D vma->vm_region;
@@ -1396,9 +1455,10 @@ static int shrink_vma(struct mm_struct *mm,
  */
 int do_munmap(struct mm_struct *mm, unsigned long start, size_t len, struc=
t list_head *uf)
 {
+	MA_STATE(mas, &mm->mm_mt, start, start);
 	struct vm_area_struct *vma;
 	unsigned long end;
-	int ret;
+	int ret =3D 0;
=20
 	len =3D PAGE_ALIGN(len);
 	if (len =3D=3D 0)
@@ -1407,7 +1467,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 	end =3D start + len;
=20
 	/* find the first potentially overlapping VMA */
-	vma =3D find_vma(mm, start);
+	vma =3D mas_find(&mas, end - 1);
 	if (!vma) {
 		static int limit;
 		if (limit < 5) {
@@ -1426,7 +1486,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 				return -EINVAL;
 			if (end =3D=3D vma->vm_end)
 				goto erase_whole_vma;
-			vma =3D vma->vm_next;
+			vma =3D mas_next(&mas, end - 1);
 		} while (vma);
 		return -EINVAL;
 	} else {
@@ -1448,9 +1508,10 @@ int do_munmap(struct mm_struct *mm, unsigned long st=
art, size_t len, struct list
 	}
=20
 erase_whole_vma:
-	delete_vma_from_mm(vma);
+	if (delete_vma_from_mm(vma))
+		ret =3D -ENOMEM;
 	delete_vma(mm, vma);
-	return 0;
+	return ret;
 }
=20
 int vm_munmap(unsigned long addr, size_t len)
@@ -1475,6 +1536,7 @@ SYSCALL_DEFINE2(munmap, unsigned long, addr, size_t, =
len)
  */
 void exit_mmap(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
 	if (!mm)
@@ -1482,13 +1544,18 @@ void exit_mmap(struct mm_struct *mm)
=20
 	mm->total_vm =3D 0;
=20
-	while ((vma =3D mm->mmap)) {
-		mm->mmap =3D vma->vm_next;
-		delete_vma_from_mm(vma);
+	/*
+	 * Lock the mm to avoid assert complaining even though this is the only
+	 * user of the mm
+	 */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
+		cleanup_vma_from_mm(vma);
 		delete_vma(mm, vma);
 		cond_resched();
 	}
 	__mt_destroy(&mm->mm_mt);
+	mmap_write_unlock(mm);
 }
=20
 int vm_brk(unsigned long addr, unsigned long len)
--=20
2.35.1
