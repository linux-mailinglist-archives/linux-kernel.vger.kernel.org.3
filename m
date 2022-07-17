Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6DD7577349
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiGQCsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbiGQCrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:05 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5193619C0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:02 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ9Jhq024541;
        Sun, 17 Jul 2022 02:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=UJCqr8UbhteOZ1kFS14oPOnk0O0kqSiBFntCl80kuxI=;
 b=H9FtO1qCXtzbfp4H6qnSQVys4b/Fg1nF0rgShMkt2ADLcEHOdWA2hrsFZlX6U+1bLD+M
 UMQot11LCsV04hiH/3MZq6tl3m4AydYKUKVuUFadeR61zOFr80fwhG4xshZ4L0IfkD8D
 t+e8pkatg4clx2q82XpR9e+sos2z2G1r59a18CNCEvu48Y83Qmkjj0bQHjEjq21WJ/zW
 eXnE8V9M2VZoyrW1i+eXQuRaNJXCD9x9u3ve9AESY/JaJDE9YRyBnOTqnIqtgoma37Cg
 F4i5OdvwVTYWnLjOxKInlHpemKygTTFuPvcN5mRwc5C9CwDvZOlIy8uECLvAdyp4r4QK xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvt8xde-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:54 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY38f005941;
        Sun, 17 Jul 2022 02:46:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d80v-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxRZG+/ICKGLTxaSRVBlYRX643jDxnf01qNUDudbUzG3suAld1caoRGlQekmUSJG9exBnjOi1tj3Tg0Pcj6Xvk06YP4FbMf1+3vr1dBTyjPDf+XqR30lh+4jEvBs+2Z0QuEqkVlu9G1k5aPJoUC9bErpEXTY4yMF34ZF14K2qDL/fxRJUj06G+S7qdstEf+1Bbm8TY18zu++vQhiMPRM4UKqIWzKjVWclvkU6EbyS36J6lcLm48GUcTvwTXnI+3vVbdMn8zvNh4+XOcmfdMWy0mF2/lSqQjtHmPrS7g1bJFxNuGFh1s0JZ9QEn9Lh5orDDANdZc4KZdI6yLXS/9TxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJCqr8UbhteOZ1kFS14oPOnk0O0kqSiBFntCl80kuxI=;
 b=ByyRd/EoNgrq8Z2UCFet35xPABGkxYfrGiomJd4gOraarDpu7wceOY/m/RHOQNIRSdKUcbKflFS9w9ZO5LNiIna/DAyKtIA/JFaaf/PlWYX29OGWf+ZDP9W49pTQgmYQwksdr1kT1Hhty7HjYl6C6zp1WMwoMqj5wRrdIE7Db30k6xwQIKnvyaZnMYCjIpmcLoyjxPD7cP7AWiYRNRfDw0SPkpVGTejtslroiRaEQ7AQrkr73anTxNfqqx6zWF9LgCdkbRGvQ6KnQDCRgmTlzVazu5kdAtnie4DNuwtTgxu7AOtl8NZ8vXg+XnVHHuZMuHfSLBXjgK0FaWi/u+JhJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJCqr8UbhteOZ1kFS14oPOnk0O0kqSiBFntCl80kuxI=;
 b=SeshgJMXf5t4EA3zdERfIvmTt1DO69JUTH3Ks+m2LXGkJGXfLPUqQ2ZqK8CuXVmyB1Rgu/wPBXgqx7qnTcg7r8y6L1F9gNkwi4haF1PJY0GW6LPIOrMUv7RuEtDZd51GGawq316YzD/wZx4lRS4AeQ9pNlc+ZI8jdVANsGzXY1k=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:50 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:50 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 26/69] mm: convert vma_lookup() to use mtree_load()
Thread-Topic: [PATCH v11 26/69] mm: convert vma_lookup() to use mtree_load()
Thread-Index: AQHYmYd02Ulf+3OxjEqJPvyktcOr0Q==
Date:   Sun, 17 Jul 2022 02:46:45 +0000
Message-ID: <20220717024615.2106835-27-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6f86060-c9ed-445b-65fe-08da679e99c2
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rFlbz9tfv4D2NrTdD7uPvBs96Drh+4fa0PFukgs7wzekXf8HgRgUJ7DAxdZhqxgWFx+sJHExZypwp6KK4LdVT6VGagO+DGT3HHujGpp0f9Gss0UFqRggW8cUXCnCcQefs+/wgvhlyVqV0Ns97/z1MqzXvsuVCv/LTuOLBlDfZyOlU+IjnfuTWgBKM0XUWDvfB/lnqLLisrdm6rQxrwVn5IRr1S/2Z+wRzKHDQsGesjAXpUy6pfjyPF73WcZXfwiqSV48O/2ih6FtzVwJg5DMSzAE1nK5eRA9DT2/i48W897fak1IPxz5hIc8vuvs17BkUPrSVk5CSmIZSdw2rnpDgp4Gpch/oQASu0oOpOl+iXG0xsXiRrXdgpxbDpsQjUFsHj8f0WjQ+Bwf6QkWUgCAhApB/6utdkMs2UCRMw+6aEAKr1uNCovcoGSl6ZlVrG1F6xe2aneB/Auwlvl2cDO3GPEjSQtjJQ+jBz9UMLzNe/sb27Af79oZIVLTaIPNfZROXDv1RdhV6LVz2PFUCOG+BrnFr77Pl0bPs+XLBZ7VJBtEOpPNrpTAMeVkMQIE1qjSzw/eZC+NTBI8Dc6ZwjNnDSVBQpjBzqeO9HQJ1f1Cmg5L0Q3tmBp3eAyqoofjNYn63uZoKuAYK9J2qX8WvXucCi6zkDBS+0RXQTSUXkhmJxVkvtcIpNQq/kSR1s5swjYGEHadNHWOB74/0nKCueoqt3/PZ5+Vua0mNp8o6piOx+tsYu/wPRtJawk0HhlLec31fSaetMcV/VSZI87VZ6W3LTmHyyb0nrUZGJKoyq3QFxiTCm+Zbkj4cUXZtDxU7hudaQP7gTDIXh+KnC7GZzAUI98p4YjfRbXnWLslA0AZsY5DEM4qapTmJTlDj+dh5p6I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?eFInsmvzQqcrKxT/dmu1bs8Z+E4IP9Et3ns5mvBy8XctZUIkyxmBXLGQn7?=
 =?iso-8859-1?Q?fSC5QP1h122wcs14e6GrsUxnaKyR13xKO4UNK3EqrotcIfAswpX4aeuej8?=
 =?iso-8859-1?Q?TiGZE/0+Gd5DTKtzW+2ef/TwaHHJVz2sxfhDZXfKYIQiNQ74jkPdmxVmC8?=
 =?iso-8859-1?Q?wVnU09VUeZNr1ZZ4pMGl7PE8VzM2w5V2ytAceakR8DK4/DvVMZ4FxqNtt/?=
 =?iso-8859-1?Q?nmWGUFOKaiVb1A4ODqM+hsG7NIatBSDBsNvremXgWIjxQgKJyZJzZ0Zlg1?=
 =?iso-8859-1?Q?0/hhVV0M10BITuUb8QDP81dzfnAFNL9oKSmwI4oAIxMtsQU/Z3KDZiEFcO?=
 =?iso-8859-1?Q?yiTIC8INr8vOPXTEvUnZkFbUPSxUKcXWKjQ9W4mW6Nv/ddzURgyd77tiVh?=
 =?iso-8859-1?Q?ey0I6ugcl5RxFyrFUu8BJdGejygd4a56iydLNzxDRmeDnu8tYovOYSj5Si?=
 =?iso-8859-1?Q?2+7OXWiq77EWR93d0bAAsLwbD+kOzlWTlJqbTvOJpoPSfyLPvjglkOsACf?=
 =?iso-8859-1?Q?skW2pyZLPz1sEJ662Qu0Uyg79vydXFvnAGp1Hze8WLnaJi/96d4M2PZrjj?=
 =?iso-8859-1?Q?xrz1MB049MHah7pLcIXgoC6gdDfzlVLeRrin3tJfxEReCXpZFlr3ut3rFU?=
 =?iso-8859-1?Q?TgcMf1Madx/x15k0HISBjgNAd1EsQcwIWkQT8XXbMLN1WSD/D1GyjcyqQL?=
 =?iso-8859-1?Q?sekR9U/uXrJbD2faWSdBgcPG5JYxUnTCmzUDlCseuckTJvxO1cH7zFWzbT?=
 =?iso-8859-1?Q?5oAS2qjEneiJWqogMAuYKWZbW2fFeT3Z48xWMUQ7vZpkK046pqyV+q6/T8?=
 =?iso-8859-1?Q?DgEcIKmGF47m7bhRgCQmi5zPhOxcwDpcZzd6hpnuzy3xg1bvsE515R0qUW?=
 =?iso-8859-1?Q?LREh2c90M1AzdHnyRl6IgQkLtHLh6wTMJsVrP+/ZCJzXhafIGnAHHlF0Ii?=
 =?iso-8859-1?Q?EteEPQQi/dhl8eOY6PdswbVcJd0GMuekptRqZoAZBxSDbYZZHjsIbe5MqO?=
 =?iso-8859-1?Q?UOTPuphfrL0zLNuZfcKKlK9lydXBsjgW64X+3LB3ysDGNEWk8tAR74F/sD?=
 =?iso-8859-1?Q?n2WPn3xpJL9kYZaDdBYDbpkFikisITzhEiZb6D6rbYbu/gLf5zsypHc5XT?=
 =?iso-8859-1?Q?HHJtYLSGhE/jmM7NAfg4Ysj0epTAEIyn6whmW4i8l0STt9iFGbIzeZlNXf?=
 =?iso-8859-1?Q?70UwCugEB1qXrli1BOPB3OZ2ANZo2D8tnMACgBLcBM/ofJQEpQ9Lo5IGB5?=
 =?iso-8859-1?Q?YBfnvdA+vZaNO3FD+quMuwWOv8kiKkLgU/aWGO7kVBdqE36KdJyvFVcNCD?=
 =?iso-8859-1?Q?OXz8G0LseyUAhhrVfwnBZ1CGWxg6CL9sSzykPW1UEwgs/KwhvRuVgaM19q?=
 =?iso-8859-1?Q?4i8X4x7KstGNHWBfgX9kzcMk38J55JNK41MWaSuggKxHfA+je0R/MFpFp6?=
 =?iso-8859-1?Q?KAa9A/BSeYUvMpZmABun0SGz5pxXFHgTewovUU70rpGuPtQ17y8CAb5pPG?=
 =?iso-8859-1?Q?JXFTK8u9Va7Z8/AFMutA9tVqPXS+YdanWeXDAjx5s+Em/sRpKQFJvO+DJE?=
 =?iso-8859-1?Q?AilNofXcpSYoF9m/HDDpDXb9wbxOxWI4fs/qJys8t0JZLDmUwuosby6rYH?=
 =?iso-8859-1?Q?TfOI0S93Hp/5dDjBWKkE/CiRRla00T9rG4V+Cp5oCAEBsJjhUc21s5jA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f86060-c9ed-445b-65fe-08da679e99c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:45.3966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVonsQxCwE82wZ2vnaY83M/VaFImO7YPlBnh95qEb40u+ICrhqxgYsexBBIckcFaFzho4FEXeWxLaiUoWd5haw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: CgDzLMu_o3IHkxl6xaAiBpA1tap4gVbK
X-Proofpoint-ORIG-GUID: CgDzLMu_o3IHkxl6xaAiBpA1tap4gVbK
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

Unlike the rbtree, the Maple Tree will return a NULL if there's nothing at
a particular address.

Since the previous commit dropped the vmacache, it is now possible to
consult the tree directly.

Link: https://lkml.kernel.org/r/20220504011345.662299-11-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-27-Liam.Howlett@orac=
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
 include/linux/mm.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 55b4b53895e8..a250fd86fde9 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2809,12 +2809,7 @@ struct vm_area_struct *find_vma_intersection(struct =
mm_struct *mm,
 static inline
 struct vm_area_struct *vma_lookup(struct mm_struct *mm, unsigned long addr=
)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, addr);
-
-	if (vma && addr < vma->vm_start)
-		vma =3D NULL;
-
-	return vma;
+	return mtree_load(&mm->mm_mt, addr);
 }
=20
 static inline unsigned long vm_start_gap(struct vm_area_struct *vma)
--=20
2.35.1
