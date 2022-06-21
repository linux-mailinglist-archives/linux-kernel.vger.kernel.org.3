Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF5553C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354846AbiFUUvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354699AbiFUUs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:48:29 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396F62CC85
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:48:08 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ29qC004726;
        Tue, 21 Jun 2022 20:47:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=asDtzWvs+8VrsXbuz1Ozy1CYPYjR8HpAdMb/72rslsU=;
 b=aQ2IrIYpG3OxlbRYVE1vzbE587Jo+bwlyLsLk1hQAanRGqODLF0dN0AhBY5AYlfP7gEX
 CJB7KBgpd7gvHp29bDL2bcjFe/0UuO7BYxCAecmPl82qZw0wVAmW3Utl8Xnh+LlXmq0/
 NYYyaFC+CrJybqi0h9EuZ6VZcGnSIMJjgzcwNRS6RC8JLPTSCyP0UROB0PARMWvxakvv
 1jqUtzMZ8Jb1UTB7MNRxjpSsMSgQZKjT3zYW+quO+4bInmUmpO35o7o1wdmXMCH/V8JA
 UWM+jdU4StYpBpbIeSCR7ElUmSGGEJSdS6D5odCIN0Ic861Pjep2xvT+ZFLEcWuQXIGs zg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeiYJ001682;
        Tue, 21 Jun 2022 20:47:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gtf5cutt1-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD4/xys1SWUjdZTlvZhfROW5M3/7U4FctlqK8aWmJ5mFZVrKY8Kn6rz+iZpqf3o1RbGKPOVHn2du6Utza6uBe+vFPHoTTI33iajsyS/ztrXQoRMAh+7IwI1LpbrHP6Fb+W/cbARmATr+4u2KygqcDDs6Vh5gjisXQo48gtDjve4TkDkppn16wgHc7WmVWVl7x3kumtse+PHYA9S1ceLgmBd8UvTzmtfYbqyy1b3zTqKRsxo7OchnAsI4E6DAmPpar171RcfmC56WiSsTjgHusBnS26tBIs7BQsKmPHwO1XRLeJ04MHIasABhAXUk+Ah+UEXiExWOtnKBTMT0sG2i9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asDtzWvs+8VrsXbuz1Ozy1CYPYjR8HpAdMb/72rslsU=;
 b=VKKvPH2eiZNCn0fDAu6AN9i5A/yqW0A8SbL0d5zbEai/cnyvNDhqTNZNwd2HEiwlncv7NGJoF+GtcKuAxSYENUak6cNkmxaVVpgl7PR0uVM+JXkF4TJJgjA8jcRXGLgyOfdJIXdvHMy8N7RS9o0LkbqauScfaqbcTKuZRfSBQ4pG+0p9fjx1vfS1I3/9OVYk1NvX4g1jLB6ANej6dju+XZyY/glQGyX6gEssMw8D+Dt1maS3uuGIqHa8l2yT4rU8NWKvVXyLSDpQ1aO3fyliARpzdqAr64Cbkoqc2Mtp+OX2nMYe5zE8rLO3ddFUZKKFmT/yU2IH9m1qTlOa2NCnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asDtzWvs+8VrsXbuz1Ozy1CYPYjR8HpAdMb/72rslsU=;
 b=geyVYW+i8+OoPRJmzH5o0IQh0o9wfKPWfU0tQp0rDUlwzPVF683hH0fLxD/NDJmzo6gCcC0+0WPx83BN/t2IBFd8w3d+sKtW/1ILJa4wecA9uBOw7+2A65BIyPk/1q6SJa8EEnnau+Db1OSMI7xRXquBRAJDPf44kIijCL/v97o=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5392.namprd10.prod.outlook.com (2603:10b6:5:297::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 20:47:51 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:51 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 47/69] perf: use VMA iterator
Thread-Topic: [PATCH v10 47/69] perf: use VMA iterator
Thread-Index: AQHYhbASIwvDkFPSvkSIH99aJD49fA==
Date:   Tue, 21 Jun 2022 20:47:08 +0000
Message-ID: <20220621204632.3370049-48-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29cb73ce-604b-4ce0-24fb-08da53c74f09
x-ms-traffictypediagnostic: DS7PR10MB5392:EE_
x-microsoft-antispam-prvs: <DS7PR10MB53922954EE6CF64F15A98943FDB39@DS7PR10MB5392.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MAEJzE0YLNzcHU9lyjOHGCZYjozlbBlIuDJumL2HLgbeREKYf6n7ytzVtL+mQyiNc2kGkKWhfNV/OaamRBy5TKIrbLFEDyZHpNHQHcqA1LoXGWoV79cbetyiue1s3y4t1xddVqwf2l83d2nckOba8poQoKW+I/h2ZkSt025VjWcMV5pogpBcSc+7s5U3Zyd7V49NrmlX4k3Af09s0G1DTY50gCknmx0Z9IS10HAHdh8nkD87ntQYOsRfXUfWOGurgRje4u4qTlld4thRDNK/kzJlOuazbVILyzISSzKlX3UCAVOiMpp6MTQfprsiid52Mg6yMsG6qNC2D/JrzNM3NOfYi5h6y4Uiv9hHVK03HZzr63KRJJEBqU9JmaZJ3VQSH3HSiZWlnprY7t+bZKX2+qFfalyEXBmmawTRfv6LInsj5GdMARiYwAI5Fsbz0IQoegM81kYmEB5JzJIIwj/FKI4PvlIskeDVyNY11cDQ/DOzZr57rh1WXo9Pw33cQ/wiO2Poh1n2CeoDzh+EeTEuCj0qGMZn77lZdr2e3xx25bx6j+jM5sLM+djYPVDCHNOdqVrJk3WmlcT6xVkKhSUgWUs/DncSuHnBU9YZRIHT9k4743L0B/p4aAdXxx9C7paP4sqkkbZJTnE3bGLyzPdMGT05qIOwmX0QUikPIDk6SnZHYBp9l2yDQR/18vr2nXpnQBr1HMZKXeALHkQlSe6MvhatYmznx/+nNjSBlFzItaeCY4MQnhvlPHBr3nB+uX/XVTFYlAOF1WZlA7ALD8eKsx7k3J4DBzmmMBhXYbxiitE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(396003)(366004)(376002)(346002)(136003)(41300700001)(6486002)(38070700005)(2616005)(186003)(86362001)(26005)(6512007)(38100700002)(122000001)(36756003)(1076003)(83380400001)(316002)(66446008)(66946007)(2906002)(64756008)(44832011)(6666004)(6506007)(8936002)(66556008)(76116006)(66476007)(966005)(478600001)(8676002)(91956017)(71200400001)(110136005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?SumJ/LN+78bU0RyF4P0mQBNCzpiI5SjTJWj3sPs+6cngDFZVDFd2W/97kh?=
 =?iso-8859-1?Q?5baQnq8lgEB1OLJppi/8T+e6R+dF68XTEkaz//san6aIGX+GPFMZQiA9FL?=
 =?iso-8859-1?Q?xWQeO22rrc7oVPi+1MgTi5OEE9dPDt4nmSXIAYCNICWB+noRzqAcNJbWFW?=
 =?iso-8859-1?Q?g0AQ84gebu8/ZAF36Bk5+vEL+JgnIra+AaHILnZpAk5xqiQX3yOJHRkJXu?=
 =?iso-8859-1?Q?N/qsFj46MewHvfxii71Ls0Akd8L4yycID4XhZS2PjKCUzECE4ADJE2snHI?=
 =?iso-8859-1?Q?+E5EGUkBDgQqlTZuSLkx4PK3uLGdYrhGaiJrMbiKYNC3w+2osjoPQoHab/?=
 =?iso-8859-1?Q?otMLi3ZXRbcbJMEe8pxdTzKKJkFMovcrgoRLrnU7trcfgy+6BFxyKfZmXf?=
 =?iso-8859-1?Q?EJj1+yROLF+lJ7dMLHg76adWqKfEYi601TnTaaqfWDlC05Vs2uzFaPWPqw?=
 =?iso-8859-1?Q?MqLvIQzK/YGJhwQ6plrDe25pgKI/fh18QrFjvVMH3RC/cF1Q2+l7sukq0h?=
 =?iso-8859-1?Q?+7gi3msj5Ca7RHIUFp3biP793PKCwEkPD0ZAZ7ApMdVB533DRluyZcOxfA?=
 =?iso-8859-1?Q?xsPLYwF8SOulO9C92N0SH1p9g8IX+/uZp/sBDZLOARcw8ZWxgzjfVg3JYd?=
 =?iso-8859-1?Q?HnyyjZAfJkTkzZ1RtnzrFEaWyRhwxKkm7cu5rtwi6/y7pLdFa+1mn59j8X?=
 =?iso-8859-1?Q?YTL8oQ3dzJJg6j9FZKMAsXvETdzQ28djMUTZue2C3EQKOLR4SbDTBaqDKT?=
 =?iso-8859-1?Q?Diuf00u0DobxkoaTD5hmooTAnYAb45IaRfcaN6qb1l5M0z11myOERxHkq8?=
 =?iso-8859-1?Q?0pG+XgYpstYhxuR9GdUOI1Dzwvx/912AUGPrB3tH7mehNm+GzTcckkH0Pa?=
 =?iso-8859-1?Q?x65ISoIBQbFrswNfNnF4gy0vAOqAoCdlCdgCKADj9bznIBIP/x45ij035u?=
 =?iso-8859-1?Q?/IwzN6nyRMYjuJ7U0GPV1y8NCtdsP7l4Ipk36x8G/ZAEUVqyGwmUU0j03f?=
 =?iso-8859-1?Q?fOoO60dkeoJybm47089UQU0V321xBgKyZ9fuGDHSwCyCDHlj73IPkPOOqd?=
 =?iso-8859-1?Q?BFDQZNOZjfYqZwBCMGT5ZrnsZwdjw4EEWHxqHH4h1UJGBxIjVJ0GD+UMR1?=
 =?iso-8859-1?Q?LV4qJEn55kkvaRnX2gDahyxSavEI6X8hXGVz8YyAcnkiRfVqiWli4znWm9?=
 =?iso-8859-1?Q?NlXrpP+dCJQWRCawQGIdlJa8Oy71kfLVu7z7lpDe9i/Gl5LA39+1TRCvlu?=
 =?iso-8859-1?Q?C9o6O2m0ROHoAGpx3gA86GvFwzHMdKZPmHlvua9WzuXE9ofjsfv+FbaqbY?=
 =?iso-8859-1?Q?+zjGJwdNyOHqfFGLiW+8JT5vpiVZjbo01dEC449tCj4FCUO3IhN8S5fdTw?=
 =?iso-8859-1?Q?gHo2CiezqSuv+yWEgyUTxqy+myQ6dB2jJ1pU980NAvdf7QI+6fNUHhYIr5?=
 =?iso-8859-1?Q?e37mydEf8uIN7uJ4Q8zUwsDnI+LD9B+bfIntb+3Hw38luMatyA/amZ1SzE?=
 =?iso-8859-1?Q?dJ+kP1nKHpEJvkyjypRd5ymUWj6HdJOiMcn6j8LOuKJkkf+9TL1J5nFXuE?=
 =?iso-8859-1?Q?HS8WRvF8GFVtK0ALunJp4R93L/vFaY4jSFhI3GBgfJRYAQs0O0kEpUt/uA?=
 =?iso-8859-1?Q?im9nPyukcZcL1+HnzrcM2ehSgO+DTFLsEDhT0/CQAvJ48th2yEqH/dUoz+?=
 =?iso-8859-1?Q?0p2Nuwm+mYeJSmBy2VmMg68j6VJiLtf7yBngYhuLZr0O6ncg4dU168LJQa?=
 =?iso-8859-1?Q?Zij4yZPMaYRAk8+81p9SclZvKoX9B/xv9pamn2F92T4AJZvnW1iWpPFwoE?=
 =?iso-8859-1?Q?mjvybIOCbP421e1Ffjl7n/dCcaTl+Zo=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29cb73ce-604b-4ce0-24fb-08da53c74f09
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:47:08.4722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DkU6wiOSpoNPwrPzuyVXXFvQnPwAaHhyPC37QifRZZUORQf3CBIIiwFt58FtuHiDj4+dfaSaATZkLIQ7zgWEQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5392
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: DZo_gZuhqJhkSk_7nQhgudvaEwRdG1rm
X-Proofpoint-ORIG-GUID: DZo_gZuhqJhkSk_7nQhgudvaEwRdG1rm
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

The VMA iterator is faster than the linked list and removing the linked
list will shrink the vm_area_struct.

Link: https://lkml.kernel.org/r/20220504011345.662299-32-Liam.Howlett@oracl=
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
 kernel/events/core.c    | 3 ++-
 kernel/events/uprobes.c | 9 ++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 80782cddb1da..61ad10862c21 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10210,8 +10210,9 @@ static void perf_addr_filter_apply(struct perf_addr=
_filter *filter,
 				   struct perf_addr_filter_range *fr)
 {
 	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!vma->vm_file)
 			continue;
=20
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 2eaa327f8158..401bc2d24ce0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -349,9 +349,10 @@ static bool valid_ref_ctr_vma(struct uprobe *uprobe,
 static struct vm_area_struct *
 find_ref_ctr_vma(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *tmp;
=20
-	for (tmp =3D mm->mmap; tmp; tmp =3D tmp->vm_next)
+	for_each_vma(vmi, tmp)
 		if (valid_ref_ctr_vma(uprobe, tmp))
 			return tmp;
=20
@@ -1231,11 +1232,12 @@ int uprobe_apply(struct inode *inode, loff_t offset=
,
=20
 static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
 	int err =3D 0;
=20
 	mmap_read_lock(mm);
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		unsigned long vaddr;
 		loff_t offset;
=20
@@ -1983,9 +1985,10 @@ bool uprobe_deny_signal(void)
=20
 static void mmf_recalc_uprobes(struct mm_struct *mm)
 {
+	VMA_ITERATOR(vmi, mm, 0);
 	struct vm_area_struct *vma;
=20
-	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next) {
+	for_each_vma(vmi, vma) {
 		if (!valid_vma(vma, false))
 			continue;
 		/*
--=20
2.35.1
