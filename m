Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019195AF4E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 21:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbiIFTvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 15:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiIFTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 15:49:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99431EE29
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 12:49:29 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 286Icnph010465;
        Tue, 6 Sep 2022 19:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=n3mBPMPW8eMGnXc+mRF+nQPKaQ3aG+7EZlOSGpPlInY=;
 b=FmfimkKKfJSmvWvnPKhqtA1ykSUmwabfgbikn8+5G1QI2R82OaN8Y8Ik27vWdVzs+ptq
 i8VrqFUKvGZZ3fTlyTMne+/AvlLIZDvhXn1sfcNDfaWt540pgt0mv09tZKIXrCr2mm6n
 gXEbd4ahMT62J6K74Q2z9nhIqGrV0gUdMP2dmzILVQffll4MEmOWRPLo7zAhZhMmWmMJ
 9EmgzvFaD/2KjgHo0WLtJspor1GnAik1dS8euBZk22EI6WtDatfITirt7bRArRrcFiIe
 hQY2bb5bjmj6pCy56/4gSEAt79BryHgUmGJf/bydHgdXTwlhGb711loNc28nVzV1r/ow Tw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jbxhspxbe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:07 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 286JN9wj027549;
        Tue, 6 Sep 2022 19:49:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jbwc9kvwt-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Sep 2022 19:49:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mcrgIs5TnMe+GcnliL7Rm6QFKGCz/QbOp1U9f2jkpX9CQgtue07bHPTupI6BScN/DkWK1u8rLu5ZW8rBnDGpv1RvE8UmGSPsThacmsfXFz7SHN4tXgWtBvspWpaFwBw6kh9Vo/xFd57J0UAd9T94I3fIiR+t14AdAdTf9ir/FfZQS+/neTTJ6KfCfIX38SQgx0pz5Mg/tIyySOn/Bb+Sy9yS7ZcPYDsMGdDazyEmfzkIjAaj9d4q3yduD4aCfbrZnSMxfzR5H5+IxwXZ4FuTR/1vIVkc6YJNjsn4BxRfBvwtg66TlGcuw/np0V6ETibYzQ0LOl8OVEAbkTXHHkJSNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3mBPMPW8eMGnXc+mRF+nQPKaQ3aG+7EZlOSGpPlInY=;
 b=Z/Q7ikALaIO8Mf3RMr9OHA5TE+1K43GShxbvbQXSLgZ79qVDuUIPpLr3T1bg0Nfd+87r9R2S7dBsDahTewxo7z2yHmM+NlditE3lD+OjipLKB9ZCsbA4TVVxXaVGk13NfCqxT/wcvPWNvo/HrBydoFd2R5PXvtOhMO2M8+lagNB+BEGmMHldYOInWIlpLP7bAw7aSrlfCFz+xlH04mV8kLuER+E1fPUEUKjdDTk7q5dmqQxphcc6N/VN3JtKjhUemyupr9e5g1HxWxlbvwFgI5At6VUUvUdfEDAtYAoXYxCruhgtCklaOsb8cKtqYrw/JFlOZu+TtRWHAlpVBObMKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3mBPMPW8eMGnXc+mRF+nQPKaQ3aG+7EZlOSGpPlInY=;
 b=ec6bIBkKzCKjaX7I2RD6P9/mb1wkyn8hCFZKXEhnCxLUQ3yejkAFU1W6ahHAR7pQi1deBFWvmFcSVM7mWBvj9VNpP1HA7T3botChAPMSD+tCKsQ5MVhj7ICnASLUW/UyviCnPHtb6ftOZWZCzx0Ui491XgAij059R0/TNBu/TyQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB4670.namprd10.prod.outlook.com (2603:10b6:a03:2dc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 19:48:59 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 19:48:59 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v14 25/70] mm: remove vmacache
Thread-Topic: [PATCH v14 25/70] mm: remove vmacache
Thread-Index: AQHYwimwQdXGPP/Th0WBkSl5x1oK4A==
Date:   Tue, 6 Sep 2022 19:48:51 +0000
Message-ID: <20220906194824.2110408-26-Liam.Howlett@oracle.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 704e40b2-e557-491a-89e1-08da9040d797
x-ms-traffictypediagnostic: SJ0PR10MB4670:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /xnseAczZbeFiEnYbxo+x4Zv975uQM06IqFbTfpHh++kxq7tKUaLona4rCVqXLjCJ5YCEejVtxwNGnpSP3d6MfCgwRIjN8tNJSg+/TCffqXyiDFPvRZRiUqiVFx1GiVpHH4T3PwIFlfPXKohBeCOsMNw14lDrso/x02DdA83DPAcZSeDoJa4Vr30HbcRzo6xYB4tcd7mvtLhtjV5ueBfjMdLpmRYZFlMz18btvF5E65aPK8gemlPEuPRTXxICpV852Exi+R0w+v8cCQl56Ftn1D7h32nq2vgz5ricvThKFma2Ln+RlP8IKW7ZcctOVcWMWKh2HDa6hjuwG6sgj7SrsG1q/6+AAUCh2dMNbh1TVvRjHqHdQf7mpMm2QeWRjQAZRvXK7Q10aWW5UkRxonrv92lm/0y0mBYazc3rBjVPtKRdLYihCsqUkr2COISaD7YC+SBak01nn/7uYDr1wAOPUIIhiJwYhmS5EMM0jjSaQwPVNXc7jBza8/RsNGrXLqKiOPbYiQqOvjZ3tMo7b5NQeKCU/QZt+EC4kHq2EKt4vbh+xTp1vu3B8zoxhiKajuVTWXmAfdIpMyzAXLGR4uAdbYDTivmcTvkwwtSq04EYVU+TK8iuABQ0r1bUBRK4c2wNDLU/Tc6NikWf4Q9merbXOKYmUD/Rc8sPD3gTOLxinLxxhATQCS6FKvkrPB55T8sZ4UzO16EtHWhace+cjrbux/f9zSTScTXUWkM9JKmj0pWz3YBJW+WrhBYO6riD1PcC+nvOmDyr78Q60N/eW8cbw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(376002)(346002)(396003)(136003)(6486002)(83380400001)(6512007)(2906002)(26005)(6506007)(66446008)(186003)(122000001)(1076003)(4326008)(66556008)(66476007)(2616005)(76116006)(64756008)(66946007)(8676002)(91956017)(478600001)(36756003)(44832011)(8936002)(54906003)(316002)(86362001)(41300700001)(5660300002)(38070700005)(110136005)(30864003)(71200400001)(6666004)(38100700002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gqqANq3ezjmJcDfY6rd12bz2ZUC29/q8l8eKtfZ+KKXnxrpyH/leXXSrD5?=
 =?iso-8859-1?Q?B9e5N16xWFvxuNR3XqeJFgLjVqbX6NPDHmRPAGVeFs6mV7MjTFqnbR4yPl?=
 =?iso-8859-1?Q?1rPIx4epnXDdSvqJqN9bOzRc6jwMM6/c491aOLXPUk6DYi4C1NbPWsd+JY?=
 =?iso-8859-1?Q?t6RoDPreMN3tRdNxEPzzIROnc46SkA/YHE6y/DoXWQhGaYXCYTyzTX9hjw?=
 =?iso-8859-1?Q?ktF0ceIrCuE/7VX6u3u+gdFbSLZybvH7TYOMDFRsux4X1HaYURLx9+yMRa?=
 =?iso-8859-1?Q?d0wlb34yFB9NwOlCwAtef/wTUn+kXLFSqB/kBZPno2DdLg1aQQPSDW0lh3?=
 =?iso-8859-1?Q?jcon5mMKULtGmVV3Rhf8SdlxFIklohs2BNCmnHyEZddUYc7BLMXIRc9hOo?=
 =?iso-8859-1?Q?kI5s+CPXC8nEehUpjUsiCO8wt+Z0yjKxajsONioWBxOQDYjeW5wRSlBIq0?=
 =?iso-8859-1?Q?9R25OPO0ZrS0Z7i01i8iSSoGB306IXz0gmLKTQonmJI2DLoiYcL+zUnNI2?=
 =?iso-8859-1?Q?2yzSNWXURs/+aGjmjzZjHS2KWSykAfpSNYL+OPXnHxzGvDE7fQPEnhs3Vi?=
 =?iso-8859-1?Q?SJfVPlmxlSQNjJTPifNd6zTsjqJI6D75e2ZbyZKQdGRC0pR2aQslTlRB4/?=
 =?iso-8859-1?Q?v07Kn1IlRjCb/TAAPx1kCBMasjlknUoR8G0rpp6lAzJmUp09oEKAvqblHw?=
 =?iso-8859-1?Q?XYOdQTZSBdi7l9Xqo6g94mYYRIAPHiZ2bTusuT2VJuMCX4cfe2c5HjDeSN?=
 =?iso-8859-1?Q?wh8j/udmg1mi3J5N4qInD4czB5qk7cJOCa9b7xdGu16sCEqWOH3SPHFRbr?=
 =?iso-8859-1?Q?o8UpKNx192iQ/AbBYbyDTUoF2YtK22MADcqXJTe+7THlM+/rJiGv0nmSKD?=
 =?iso-8859-1?Q?WyuYUDijuIisDnULcYRFyeGwpHGKMI5P73dYWTHX98UCaDqTG79YeRkSCV?=
 =?iso-8859-1?Q?14AnK1xyNbO3I19NuwOmZR6QRSTwc9PgVQVsZ/aHR6YBeiQSvyv4e4b2c5?=
 =?iso-8859-1?Q?Tt9T8UvT3Ndj9X8kTHym5qIXtGy5xHNEE7CUgHM8XfbPvM8cvEAYbneUmA?=
 =?iso-8859-1?Q?xaPutpmUsIjl8/zplYcBSWhgc46y6jm/KI7SqqCmIg7Xmav269bT2JuEl4?=
 =?iso-8859-1?Q?4GE4ucjkx8guhpZyY1T86sHwFwEAh+ZE7f6xBklG+q9M3PZDjfi039Jqmv?=
 =?iso-8859-1?Q?cyPyzfGOqYaTu7FjkMPQHkgRxl/h0g9OFlYOzwFqRq5M8rTqj9XkRVFFZk?=
 =?iso-8859-1?Q?hQ+ptWadVUlo365Q603/v/+yvdzRjIRRx4NCgTaYeVTpx8MdQWaOTe7O8e?=
 =?iso-8859-1?Q?ukANtTlJ/PrC7kWtIaabex+XRiPuwXkNwvuHzVuzEjWy/IG89OkV6vWJhC?=
 =?iso-8859-1?Q?CRnb6djI5xMAWn9OduJ0UOlOL3SwYPCOrtZhe3awZLWDsnkVEtOhvbnj4/?=
 =?iso-8859-1?Q?6u759d8GU+hh9oG/d38OQtlAq7JWC37EDCQwcUbV9FTQyvoFfMYTojetsM?=
 =?iso-8859-1?Q?o+451dry6Kddoy9Av1wT+PN4HXh+MCY45wWXc9/asxbHzCnOo3o0AWXFAe?=
 =?iso-8859-1?Q?oH986Lx8CVQd72f1J0y9gNZ60FSubD+NH98s+SF2h/JInBDKco3aFslUu0?=
 =?iso-8859-1?Q?PEUiLXE8pzh02AClYSgeznkHzigfc4CgkzDTARQz/7uXzo26PFYkhFHg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 704e40b2-e557-491a-89e1-08da9040d797
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 19:48:51.5535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XWksMCKH3s3GSXbbTwnItf30wxLfKiijm4yKhyU5yiGvt8YnpJkZ6kQc405imR/et4zPnoOWaOfxnFx6t40bgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4670
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_09,2022-09-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209060091
X-Proofpoint-GUID: RAON_EJCPn8MeSOoU_Z55qojWc08CNEr
X-Proofpoint-ORIG-GUID: RAON_EJCPn8MeSOoU_Z55qojWc08CNEr
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

By using the maple tree and the maple tree state, the vmacache is no
longer beneficial and is complicating the VMA code.  Remove the vmacache
to reduce the work in keeping it up to date and code complexity.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 fs/exec.c                     |   3 -
 fs/proc/task_mmu.c            |   1 -
 include/linux/mm_types.h      |   1 -
 include/linux/mm_types_task.h |  12 ----
 include/linux/sched.h         |   1 -
 include/linux/vm_event_item.h |   4 --
 include/linux/vmacache.h      |  28 --------
 include/linux/vmstat.h        |   6 --
 kernel/debug/debug_core.c     |  12 ----
 kernel/fork.c                 |   5 --
 lib/Kconfig.debug             |   8 ---
 mm/Makefile                   |   2 +-
 mm/debug.c                    |   4 +-
 mm/mmap.c                     |  31 +--------
 mm/nommu.c                    |  37 ++---------
 mm/vmacache.c                 | 117 ----------------------------------
 mm/vmstat.c                   |   4 --
 17 files changed, 9 insertions(+), 267 deletions(-)
 delete mode 100644 include/linux/vmacache.h
 delete mode 100644 mm/vmacache.c

diff --git a/fs/exec.c b/fs/exec.c
index 5fd98ca569ff..55879fb1ce46 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -28,7 +28,6 @@
 #include <linux/file.h>
 #include <linux/fdtable.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
 #include <linux/swap.h>
@@ -1027,8 +1026,6 @@ static int exec_mmap(struct mm_struct *mm)
 	activate_mm(active_mm, mm);
 	if (IS_ENABLED(CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM))
 		local_irq_enable();
-	tsk->mm->vmacache_seqnum =3D 0;
-	vmacache_flush(tsk);
 	task_unlock(tsk);
 	lru_gen_use_mm(mm);
=20
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index db2f3a2946a0..9f70bc1c2766 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/pagewalk.h>
-#include <linux/vmacache.h>
 #include <linux/mm_inline.h>
 #include <linux/hugetlb.h>
 #include <linux/huge_mm.h>
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index b9ae6ab41444..534fdd419bfd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -477,7 +477,6 @@ struct mm_struct {
 	struct {
 		struct vm_area_struct *mmap;		/* list of VMAs */
 		struct maple_tree mm_mt;
-		u64 vmacache_seqnum;                   /* per-thread vmacache */
 #ifdef CONFIG_MMU
 		unsigned long (*get_unmapped_area) (struct file *filp,
 				unsigned long addr, unsigned long len,
diff --git a/include/linux/mm_types_task.h b/include/linux/mm_types_task.h
index c1bc6731125c..0bb4b6da9993 100644
--- a/include/linux/mm_types_task.h
+++ b/include/linux/mm_types_task.h
@@ -24,18 +24,6 @@
 		IS_ENABLED(CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK))
 #define ALLOC_SPLIT_PTLOCKS	(SPINLOCK_SIZE > BITS_PER_LONG/8)
=20
-/*
- * The per task VMA cache array:
- */
-#define VMACACHE_BITS 2
-#define VMACACHE_SIZE (1U << VMACACHE_BITS)
-#define VMACACHE_MASK (VMACACHE_SIZE - 1)
-
-struct vmacache {
-	u64 seqnum;
-	struct vm_area_struct *vmas[VMACACHE_SIZE];
-};
-
 /*
  * When updating this, please also update struct resident_page_types[] in
  * kernel/fork.c
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a2dcfb91df03..fbac3c19fe35 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -861,7 +861,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
=20
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
=20
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index f3fc36cd2276..3518dba1e02f 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -129,10 +129,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
 		NR_TLB_LOCAL_FLUSH_ALL,
 		NR_TLB_LOCAL_FLUSH_ONE,
 #endif /* CONFIG_DEBUG_TLBFLUSH */
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-		VMACACHE_FIND_CALLS,
-		VMACACHE_FIND_HITS,
-#endif
 #ifdef CONFIG_SWAP
 		SWAP_RA,
 		SWAP_RA_HIT,
diff --git a/include/linux/vmacache.h b/include/linux/vmacache.h
deleted file mode 100644
index 6fce268a4588..000000000000
--- a/include/linux/vmacache.h
+++ /dev/null
@@ -1,28 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __LINUX_VMACACHE_H
-#define __LINUX_VMACACHE_H
-
-#include <linux/sched.h>
-#include <linux/mm.h>
-
-static inline void vmacache_flush(struct task_struct *tsk)
-{
-	memset(tsk->vmacache.vmas, 0, sizeof(tsk->vmacache.vmas));
-}
-
-extern void vmacache_update(unsigned long addr, struct vm_area_struct *new=
vma);
-extern struct vm_area_struct *vmacache_find(struct mm_struct *mm,
-						    unsigned long addr);
-
-#ifndef CONFIG_MMU
-extern struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-						  unsigned long start,
-						  unsigned long end);
-#endif
-
-static inline void vmacache_invalidate(struct mm_struct *mm)
-{
-	mm->vmacache_seqnum++;
-}
-
-#endif /* __LINUX_VMACACHE_H */
diff --git a/include/linux/vmstat.h b/include/linux/vmstat.h
index bfe38869498d..19cf5b6892ce 100644
--- a/include/linux/vmstat.h
+++ b/include/linux/vmstat.h
@@ -125,12 +125,6 @@ static inline void vm_events_fold_cpu(int cpu)
 #define count_vm_tlb_events(x, y) do { (void)(y); } while (0)
 #endif
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-#define count_vm_vmacache_event(x) count_vm_event(x)
-#else
-#define count_vm_vmacache_event(x) do {} while (0)
-#endif
-
 #define __count_zid_vm_events(item, zid, delta) \
 	__count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
=20
diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 7beceb447211..d5e9ccde3ab8 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -50,7 +50,6 @@
 #include <linux/pid.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
-#include <linux/vmacache.h>
 #include <linux/rcupdate.h>
 #include <linux/irq.h>
 #include <linux/security.h>
@@ -283,17 +282,6 @@ static void kgdb_flush_swbreak_addr(unsigned long addr=
)
 	if (!CACHE_FLUSH_IS_SAFE)
 		return;
=20
-	if (current->mm) {
-		int i;
-
-		for (i =3D 0; i < VMACACHE_SIZE; i++) {
-			if (!current->vmacache.vmas[i])
-				continue;
-			flush_cache_range(current->vmacache.vmas[i],
-					  addr, addr + BREAK_INSTR_SIZE);
-		}
-	}
-
 	/* Force flush instruction cache if it was outside the mm */
 	flush_icache_range(addr, addr + BREAK_INSTR_SIZE);
 }
diff --git a/kernel/fork.c b/kernel/fork.c
index 5f81c009bb20..430f63cd7a37 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -43,7 +43,6 @@
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/vmacache.h>
 #include <linux/nsproxy.h>
 #include <linux/capability.h>
 #include <linux/cpu.h>
@@ -1128,7 +1127,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
-	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	seqcount_init(&mm->write_protect_seq);
@@ -1585,9 +1583,6 @@ static int copy_mm(unsigned long clone_flags, struct =
task_struct *tsk)
 	if (!oldmm)
 		return 0;
=20
-	/* initialize the new vmacache entries */
-	vmacache_flush(tsk);
-
 	if (clone_flags & CLONE_VM) {
 		mmget(oldmm);
 		mm =3D oldmm;
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 3e9be2473163..758311d955bc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -812,14 +812,6 @@ config DEBUG_VM
=20
 	  If unsure, say N.
=20
-config DEBUG_VM_VMACACHE
-	bool "Debug VMA caching"
-	depends on DEBUG_VM
-	help
-	  Enable this to turn on VMA caching debug information. Doing so
-	  can cause significant overhead, so only enable it in non-production
-	  environments.
-
 config DEBUG_VM_MAPLE_TREE
 	bool "Debug VM maple trees"
 	depends on DEBUG_VM
diff --git a/mm/Makefile b/mm/Makefile
index 488f604e77e0..a731d1decbb1 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -52,7 +52,7 @@ obj-y			:=3D filemap.o mempool.o oom_kill.o fadvise.o \
 			   readahead.o swap.o truncate.o vmscan.o shmem.o \
 			   util.o mmzone.o vmstat.o backing-dev.o \
 			   mm_init.o percpu.o slab_common.o \
-			   compaction.o vmacache.o \
+			   compaction.o \
 			   interval_tree.o list_lru.o workingset.o \
 			   debug.o gup.o mmap_lock.o $(mmu-y)
=20
diff --git a/mm/debug.c b/mm/debug.c
index bef329bf28f0..2d625ca0e326 100644
--- a/mm/debug.c
+++ b/mm/debug.c
@@ -155,7 +155,7 @@ EXPORT_SYMBOL(dump_vma);
=20
 void dump_mm(const struct mm_struct *mm)
 {
-	pr_emerg("mm %px mmap %px seqnum %llu task_size %lu\n"
+	pr_emerg("mm %px mmap %px task_size %lu\n"
 #ifdef CONFIG_MMU
 		"get_unmapped_area %px\n"
 #endif
@@ -183,7 +183,7 @@ void dump_mm(const struct mm_struct *mm)
 		"tlb_flush_pending %d\n"
 		"def_flags: %#lx(%pGv)\n",
=20
-		mm, mm->mmap, (long long) mm->vmacache_seqnum, mm->task_size,
+		mm, mm->mmap, mm->task_size,
 #ifdef CONFIG_MMU
 		mm->get_unmapped_area,
 #endif
diff --git a/mm/mmap.c b/mm/mmap.c
index 7a1adc916957..7872642e8993 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -14,7 +14,6 @@
 #include <linux/backing-dev.h>
 #include <linux/mm.h>
 #include <linux/mm_inline.h>
-#include <linux/vmacache.h>
 #include <linux/shm.h>
 #include <linux/mman.h>
 #include <linux/pagemap.h>
@@ -680,9 +679,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
rea_struct *vma,
 		/* Remove from mm linked list - also updates highest_vm_end */
 		__vma_unlink_list(mm, next);
=20
-		/* Kill the cache */
-		vmacache_invalidate(mm);
-
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
=20
@@ -923,8 +919,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		__vma_unlink_list(mm, next);
 		if (remove_next =3D=3D 2)
 			__vma_unlink_list(mm, next_next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
=20
 		if (file) {
 			__remove_shared_vm_struct(next, file, mapping);
@@ -2233,19 +2227,10 @@ struct vm_area_struct *find_vma_intersection(struct=
 mm_struct *mm,
 					     unsigned long start_addr,
 					     unsigned long end_addr)
 {
-	struct vm_area_struct *vma;
 	unsigned long index =3D start_addr;
=20
 	mmap_assert_locked(mm);
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, start_addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mt_find(&mm->mm_mt, &index, end_addr - 1);
-	if (vma)
-		vmacache_update(start_addr, vma);
-	return vma;
+	return mt_find(&mm->mm_mt, &index, end_addr - 1);
 }
 EXPORT_SYMBOL(find_vma_intersection);
=20
@@ -2259,19 +2244,10 @@ EXPORT_SYMBOL(find_vma_intersection);
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	unsigned long index =3D addr;
=20
 	mmap_assert_locked(mm);
-	/* Check the cache first. */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mt_find(&mm->mm_mt, &index, ULONG_MAX);
-	if (vma)
-		vmacache_update(addr, vma);
-	return vma;
+	return mt_find(&mm->mm_mt, &index, ULONG_MAX);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -2660,9 +2636,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
ct ma_state *mas,
 		mm->highest_vm_end =3D prev ? vm_end_gap(prev) : 0;
 	tail_vma->vm_next =3D NULL;
=20
-	/* Kill the cache */
-	vmacache_invalidate(mm);
-
 	/*
 	 * Do not downgrade mmap_lock if we are next to VM_GROWSDOWN or
 	 * VM_GROWSUP VMA. Such VMAs can change their size under
diff --git a/mm/nommu.c b/mm/nommu.c
index 2702790d05d3..265a444a2cc2 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -19,7 +19,6 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
-#include <linux/vmacache.h>
 #include <linux/mman.h>
 #include <linux/swap.h>
 #include <linux/file.h>
@@ -598,23 +597,12 @@ static void add_vma_to_mm(struct mm_struct *mm, struc=
t vm_area_struct *vma)
  */
 static void delete_vma_from_mm(struct vm_area_struct *vma)
 {
-	int i;
-	struct address_space *mapping;
-	struct mm_struct *mm =3D vma->vm_mm;
-	struct task_struct *curr =3D current;
 	MA_STATE(mas, &vma->vm_mm->mm_mt, 0, 0);
=20
-	mm->map_count--;
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		/* if the vma is cached, invalidate the entire cache */
-		if (curr->vmacache.vmas[i] =3D=3D vma) {
-			vmacache_invalidate(mm);
-			break;
-		}
-	}
-
+	vma->vm_mm->map_count--;
 	/* remove the VMA from the mapping */
 	if (vma->vm_file) {
+		struct address_space *mapping;
 		mapping =3D vma->vm_file->f_mapping;
=20
 		i_mmap_lock_write(mapping);
@@ -626,7 +614,7 @@ static void delete_vma_from_mm(struct vm_area_struct *v=
ma)
=20
 	/* remove from the MM's tree and list */
 	vma_mas_remove(vma, &mas);
-	__vma_unlink_list(mm, vma);
+	__vma_unlink_list(vma->vm_mm, vma);
 }
=20
 /*
@@ -659,20 +647,9 @@ EXPORT_SYMBOL(find_vma_intersection);
  */
 struct vm_area_struct *find_vma(struct mm_struct *mm, unsigned long addr)
 {
-	struct vm_area_struct *vma;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find(mm, addr);
-	if (likely(vma))
-		return vma;
-
-	vma =3D mas_walk(&mas);
-
-	if (vma)
-		vmacache_update(addr, vma);
-
-	return vma;
+	return mas_walk(&mas);
 }
 EXPORT_SYMBOL(find_vma);
=20
@@ -706,11 +683,6 @@ static struct vm_area_struct *find_vma_exact(struct mm=
_struct *mm,
 	unsigned long end =3D addr + len;
 	MA_STATE(mas, &mm->mm_mt, addr, addr);
=20
-	/* check the cache first */
-	vma =3D vmacache_find_exact(mm, addr, end);
-	if (vma)
-		return vma;
-
 	vma =3D mas_walk(&mas);
 	if (!vma)
 		return NULL;
@@ -719,7 +691,6 @@ static struct vm_area_struct *find_vma_exact(struct mm_=
struct *mm,
 	if (vma->vm_end !=3D end)
 		return NULL;
=20
-	vmacache_update(addr, vma);
 	return vma;
 }
=20
diff --git a/mm/vmacache.c b/mm/vmacache.c
deleted file mode 100644
index 01a6e6688ec1..000000000000
--- a/mm/vmacache.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2014 Davidlohr Bueso.
- */
-#include <linux/sched/signal.h>
-#include <linux/sched/task.h>
-#include <linux/mm.h>
-#include <linux/vmacache.h>
-
-/*
- * Hash based on the pmd of addr if configured with MMU, which provides a =
good
- * hit rate for workloads with spatial locality.  Otherwise, use pages.
- */
-#ifdef CONFIG_MMU
-#define VMACACHE_SHIFT	PMD_SHIFT
-#else
-#define VMACACHE_SHIFT	PAGE_SHIFT
-#endif
-#define VMACACHE_HASH(addr) ((addr >> VMACACHE_SHIFT) & VMACACHE_MASK)
-
-/*
- * This task may be accessing a foreign mm via (for example)
- * get_user_pages()->find_vma().  The vmacache is task-local and this
- * task's vmacache pertains to a different mm (ie, its own).  There is
- * nothing we can do here.
- *
- * Also handle the case where a kernel thread has adopted this mm via
- * kthread_use_mm(). That kernel thread's vmacache is not applicable to th=
is mm.
- */
-static inline bool vmacache_valid_mm(struct mm_struct *mm)
-{
-	return current->mm =3D=3D mm && !(current->flags & PF_KTHREAD);
-}
-
-void vmacache_update(unsigned long addr, struct vm_area_struct *newvma)
-{
-	if (vmacache_valid_mm(newvma->vm_mm))
-		current->vmacache.vmas[VMACACHE_HASH(addr)] =3D newvma;
-}
-
-static bool vmacache_valid(struct mm_struct *mm)
-{
-	struct task_struct *curr;
-
-	if (!vmacache_valid_mm(mm))
-		return false;
-
-	curr =3D current;
-	if (mm->vmacache_seqnum !=3D curr->vmacache.seqnum) {
-		/*
-		 * First attempt will always be invalid, initialize
-		 * the new cache for this task here.
-		 */
-		curr->vmacache.seqnum =3D mm->vmacache_seqnum;
-		vmacache_flush(curr);
-		return false;
-	}
-	return true;
-}
-
-struct vm_area_struct *vmacache_find(struct mm_struct *mm, unsigned long a=
ddr)
-{
-	int idx =3D VMACACHE_HASH(addr);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma) {
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-			if (WARN_ON_ONCE(vma->vm_mm !=3D mm))
-				break;
-#endif
-			if (vma->vm_start <=3D addr && vma->vm_end > addr) {
-				count_vm_vmacache_event(VMACACHE_FIND_HITS);
-				return vma;
-			}
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-
-#ifndef CONFIG_MMU
-struct vm_area_struct *vmacache_find_exact(struct mm_struct *mm,
-					   unsigned long start,
-					   unsigned long end)
-{
-	int idx =3D VMACACHE_HASH(start);
-	int i;
-
-	count_vm_vmacache_event(VMACACHE_FIND_CALLS);
-
-	if (!vmacache_valid(mm))
-		return NULL;
-
-	for (i =3D 0; i < VMACACHE_SIZE; i++) {
-		struct vm_area_struct *vma =3D current->vmacache.vmas[idx];
-
-		if (vma && vma->vm_start =3D=3D start && vma->vm_end =3D=3D end) {
-			count_vm_vmacache_event(VMACACHE_FIND_HITS);
-			return vma;
-		}
-		if (++idx =3D=3D VMACACHE_SIZE)
-			idx =3D 0;
-	}
-
-	return NULL;
-}
-#endif
diff --git a/mm/vmstat.c b/mm/vmstat.c
index 779f1ea6e8ea..bd8040f25c27 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1389,10 +1389,6 @@ const char * const vmstat_text[] =3D {
 	"nr_tlb_local_flush_one",
 #endif /* CONFIG_DEBUG_TLBFLUSH */
=20
-#ifdef CONFIG_DEBUG_VM_VMACACHE
-	"vmacache_find_calls",
-	"vmacache_find_hits",
-#endif
 #ifdef CONFIG_SWAP
 	"swap_ra",
 	"swap_ra_hit",
--=20
2.35.1
