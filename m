Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB95357733D
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 04:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbiGQCsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 22:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbiGQCrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 22:47:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D15D1A04D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 19:47:03 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26GJ8e8v009340;
        Sun, 17 Jul 2022 02:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=weTGUx7hkmDqPfaShdM/qrTkVdpnROiFLUqwy5TLfWY=;
 b=H/dzlNWPDuNsYo0TuPtIb8gi6vMautmFZplJ9uFAant9cTyiVjal3bVl0d/1pB/9Lx7x
 76z1cXGguy3+M7KUktwRkqlrtCtPQrY+xnFgtiB81sGhxZZTognx0ih0mgim0tSeGhIy
 1utvmGwvqnwGADPA0ur2yp6aZdjgrGx1aj3mU79rofgMeW3bECJLXiVV2v4Oxa12tY1T
 w11fIHC8zFF3S+FlxG3tGESHBlqJeGMWUEfAFk/Ggd+dOG1vR/pOLqEWErvLu8byD70+
 RRWlCEgPDxiR+NwpReCNxO3z0x4Dgr18Ru287hTClC0zSfQaX9cdhpUoFDYI/8CBWxEb tg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbkx0s0u6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:53 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26GMY38e005941;
        Sun, 17 Jul 2022 02:46:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1m9d80v-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 17 Jul 2022 02:46:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHWD979c/Dkz8f3j8f+DmNPuJ2sdbXTuBzkDrN7HKwPCPXwbE2l8TfZ9N5Rk4YqcERqE9LjOdBCnlEX/MRM+V7A1VN0CQ+Jf+IRKixHzQCfg5YmRF+eYhqMFsXlq8+9fGocza5WYPJt98QWWWy+Wv3YKbOEmx3Qeubh2obn2FFiT8t5xjgWGbzYmcoJ8WwRdnrqvC9h105JLY8CPeDnypcRjKdxOQlblQZjG8H1H8mYmQFZl8BbaSNnjhu3LJiGXC7yT8GYkc94aGqktAvU3UM4B4rsLa+2CJCcEiOHUYS56z/y/QZ4hX334e7mNWzrf5O+KutmXc8r//bjxgVGfQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weTGUx7hkmDqPfaShdM/qrTkVdpnROiFLUqwy5TLfWY=;
 b=d0S27vTqitle1l7qZGo6Fz5asRvmiRxuB/x7zol0sWNlAD9zJ4JdSyurf4zVi1UQCQ5ORfBOCgQdl+Bf2Uz0GsOvMOKH4hVgGly7wlSTjgLnUSpESCY7LCQcLO7Z+KFyBmHoCdMnPdajY5znQkZfi8L/hqOLVRpsHB/z6pf9IHFndkj+DDpv0ibVjylFDidCtVZHd+Ki5QGcounXztjNYZF27KpJcKm2f20AKXpcyZcj6sIZsP0Ovi9SeZH14T0Agd5Y3nlJT3kMfvY3ayJIovjTHOKZr643tb98XfAzIiNlj6+KZamAKH766YAJRfinTZgdzc9xqUXMJAPIX1jq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=weTGUx7hkmDqPfaShdM/qrTkVdpnROiFLUqwy5TLfWY=;
 b=I2BDtDEFKYFT1lEMktYYxKWwzzhfbRPxsrm5Zkt/Lb2m/HuCAdT4sKp0W+k8ySAjApai8aq+L8nlevGEZlf0h2Zl/hvjM9lzUALJlzWFyQ9SHQGDVjUZfJGnn1yufUdHHeKGoRi5u1ey0K7RSYQqkT5VHt+J5YiPRbplDeKm/Uw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM6PR10MB2908.namprd10.prod.outlook.com (2603:10b6:5:6e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Sun, 17 Jul
 2022 02:46:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::c4d1:edc3:7d21:7c68%6]) with mapi id 15.20.5438.020; Sun, 17 Jul 2022
 02:46:49 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>, Hugh Dickins <hughd@google.com>
Subject: [PATCH v11 25/69] mm: remove vmacache
Thread-Topic: [PATCH v11 25/69] mm: remove vmacache
Thread-Index: AQHYmYdzvruucL3mCkiTPfFKtZ3Akg==
Date:   Sun, 17 Jul 2022 02:46:45 +0000
Message-ID: <20220717024615.2106835-26-Liam.Howlett@oracle.com>
References: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220717024615.2106835-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea4c7f3c-8960-4d1c-6fdb-08da679e9927
x-ms-traffictypediagnostic: DM6PR10MB2908:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yHSqFo2S4m9f+ut3a9NKKeigJh3OokPl5/wdqyn/dsGPjGdxXt2QEImV58Uw/5MYFxQWuV9Hs0h+tBsv26m+IhSBHGocfRu1h84e30oqqhhzRsWFsMdRPDp6WRfFUCnEB3Hlp930LkPPBGmWlGjbxen5NBfqt/V521tk47kTC2bWN4l4meYlC5McjT8NorQOqOuZuixkzNaLAdWX9fAYYGghk/+efrjid7RK9DALth471b3QIgH+GZ3jPZWwC0y1WNHxraNPsBx/nbmqAdYCkh6147D0DPMIVVzcCZ56Pd7pgNjJ21mL1LXZPsbGymAGRsYvYiPEPmcfrVVv9UZdEnybuMxjlAGia6DmA1vbZZAu51E2rR3Jiw6YJsDIJc3pc0xL7XfQ5FahXMnvIquMjnnsRwszH2Om32VqkD/TM2/aeF/3mQ6iiw+qKR2jmr+1l5wRF17rzpD8sHx/jUT9E1wAsnq5I/D/UvQFYPZ4zHUlbDvavWHOcHVB2IefsEPXAMkdhx9XHQDLZlsQVuVFTbhBzQ9MYYLXzLocTTxCO4DL6kPiwUv218n3Qvwl0uSVbAEhvho0SyPDQLPFy8SDINRH69SzLXCdaFy8GwzDbpX1rl6dz/KF8lmw7D/TkFpsfgPxNpJleTR8v9glCC5Vf0i98YIEMN7sjklpdVP/6MzcFl1MrFPMLPog1f+ZSzqMIXi/KkrQLZZDf/wkVhhXI7EdmgwJ/BI3SoLlfROg1otwRPqL5lBskPDdXbMEfSAKFRgL3g4k1BqfQPmv/xCxBVdRlv+dkSbfKD3KaO3MshejNRBdHeyGnbtufsA29lq3wCXgT6AEGb9ked8acAQp732eNYfOMAyyGCiEThI2XIbc+7ab/GfcstUD3SXBeEzg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(39860400002)(376002)(396003)(136003)(366004)(5660300002)(122000001)(86362001)(38100700002)(38070700005)(6512007)(83380400001)(186003)(36756003)(1076003)(2616005)(6506007)(71200400001)(8676002)(110136005)(316002)(41300700001)(966005)(478600001)(26005)(6666004)(91956017)(6486002)(66446008)(64756008)(66556008)(30864003)(76116006)(66946007)(2906002)(44832011)(8936002)(66476007)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZPgW6JK71ADTfqBI2fcUnJsvy621svdQ4VaGSOpDcNnH+k7KgXkU6GkImG?=
 =?iso-8859-1?Q?RfvxE7Yw0LP4BwpQ4+CztK9rPGmWvFiEW8++nvKkBeQBzJMJwkQTOMBL5R?=
 =?iso-8859-1?Q?r/xn8CLT1wuO2fK/NsT1CdMsHKPrfnLgpg3JTki7thA+JUdoirYtTjpaHD?=
 =?iso-8859-1?Q?uUDmB0JJ+3hT4huXrDvjFY3Adk/K/DsMjbyCZFZbgIPl87uNo4fKGD1A2I?=
 =?iso-8859-1?Q?jLk6APl/x8/z5b/GFPnoy2g5MOOfsYcmwO0hZP72TZi4QX0AMUaPs/QvAd?=
 =?iso-8859-1?Q?PD0+woYxc3RPknSGxpltOmSOgxvPf3cvkCb0K5dlWbXnkPHALkAppOJZs4?=
 =?iso-8859-1?Q?KVzXr3ErsxjnuTKDZhvf0AhpJMkt9PgPcNO1t/uNbQW17ldsoCOyJNgEqn?=
 =?iso-8859-1?Q?EYSA7cKjeFmA2/ZERO/wyO73dTLmsvSUR7oo8gqVcpTvGvh5w7wz7vbsdo?=
 =?iso-8859-1?Q?3btGjgJJzAYguen3nXbnTN1FZrQmNQsRcx7PYAVr7G6J6BIIn6VU9X1aMK?=
 =?iso-8859-1?Q?bzoRj76XtEsD9RlATjh/qU8YCIiYW23AI25nujNYXA7jgDxh/cliqt+rvr?=
 =?iso-8859-1?Q?XdpSybhSATRBirR6Xnu64CfYX8LLYEnzGvBd1LhzqTlxC8VRRkXrYGuX1G?=
 =?iso-8859-1?Q?Or9V8o1DuMrGkpbY0E1i96wcvcDe8z47TmDmyBXbEBhVT+W/ba0XdvpwoH?=
 =?iso-8859-1?Q?2gL21KOOAKtkpL5GqcO43QU8W22W02n/P2xoIJHUJyPWm4ksxU5ZlZYJHv?=
 =?iso-8859-1?Q?zFqWnTufEkFNt2Djoh8bOfaMJhRpftEF6F4PLsJix+BKXrJCnoBBJ5/2D4?=
 =?iso-8859-1?Q?XXFlLUYNOZHnMal+ctkTf/nS2/M7xUS1DaNxbZwseAI+py78+Wm4CJWAcD?=
 =?iso-8859-1?Q?MCQwbVUjMEA70c1QMuagPE9enk9Lp55kbuOz3EPJq1BOjaM2z7ntIYuB9c?=
 =?iso-8859-1?Q?5Z/duUAMX1DdQLzsYAgaPoDpR+uMwuruYeVp2SvMyMUExVlfGeu4hbEsx2?=
 =?iso-8859-1?Q?WbI/qBAkl4EUsdlv6cQ6XNAzOew6hP4X5zF9szNZKsUe86389rBh/bzz2o?=
 =?iso-8859-1?Q?B6PvJ0FMWItL63O4LQIwILBNniHgWlwn+2yo4sNkBZqCjtIyD/+vGKJbPr?=
 =?iso-8859-1?Q?sT8VBLIFlsCWwIEr8YUEjDd3tHZ75MXH7qVf0FFM9vEx9C6WzKxOa/Tqub?=
 =?iso-8859-1?Q?nzDrSw29ehF59p5mi3Dohmfb/Q7bEgtiIAgHm+RjS5OIm/w6pU5S4Sq11R?=
 =?iso-8859-1?Q?gK4d7d4+D4scSILAKXatTkuViXMuDJ7ocMwT6LFXoHy3VXK8IZrpQ2/sWj?=
 =?iso-8859-1?Q?ec2KGCc1J57Jv06GZ+a6oBJzYDk6qlCzem5To5wmdGhX0AHlq9JQIq9gBU?=
 =?iso-8859-1?Q?8bej+22+ysa8uSjvATvBk/yMfikkNB24Po4Rqde/OUX1drFpMDOUgwv6a6?=
 =?iso-8859-1?Q?EOW9ZfZ6AXx5uiK57+Z7HIYurXpRkY/r/Fu1ruB7k0MMIW8iagWCzN0vzY?=
 =?iso-8859-1?Q?h/54BaKcOjGxsMApGknKpVJv5EgfYrq044tjDCpJDMkDtdnMCgVIQgmBp/?=
 =?iso-8859-1?Q?H2cDn4WqmSClaIA1XZVtr0V/3J+Xk/MfQfCuZt6YTxD5onKkKyhMGS6Bnw?=
 =?iso-8859-1?Q?Q7rARon0SDbfWhQYVY3qFFbX+waOBsNZGJvh+RXhMzy6zokr/2P47xqA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea4c7f3c-8960-4d1c-6fdb-08da679e9927
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2022 02:46:45.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aSmZSlt86ccsevu61HUqz2V2eKF7699QSfjZR5yvY0DJH+1m42sVwx7rFVClH6Cr3IHyavsbyH09fq/ZR/RnTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2908
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-17_01,2022-07-15_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207170010
X-Proofpoint-GUID: NISfRnABu-rxAOUxm0D8EqcAryc7arjx
X-Proofpoint-ORIG-GUID: NISfRnABu-rxAOUxm0D8EqcAryc7arjx
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

By using the maple tree and the maple tree state, the vmacache is no
longer beneficial and is complicating the VMA code.  Remove the vmacache
to reduce the work in keeping it up to date and code complexity.

Link: https://lkml.kernel.org/r/20220504011345.662299-10-Liam.Howlett@oracl=
e.com
Link: https://lkml.kernel.org/r/20220621204632.3370049-26-Liam.Howlett@orac=
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
 mm/mmap.c                     |  32 +---------
 mm/nommu.c                    |  37 ++---------
 mm/vmacache.c                 | 117 ----------------------------------
 mm/vmstat.c                   |   4 --
 17 files changed, 9 insertions(+), 268 deletions(-)
 delete mode 100644 include/linux/vmacache.h
 delete mode 100644 mm/vmacache.c

diff --git a/fs/exec.c b/fs/exec.c
index 0989fb8472a1..b97afa682ffe 100644
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
 	if (old_mm) {
 		mmap_read_unlock(old_mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index 2d04e3470d4c..616913bb1fa7 100644
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
index 8352689457a2..c7580a191449 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -470,7 +470,6 @@ struct mm_struct {
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
index c46f3a63b758..dc131048d46a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -859,7 +859,6 @@ struct task_struct {
 	struct mm_struct		*active_mm;
=20
 	/* Per-thread vma caching: */
-	struct vmacache			vmacache;
=20
 #ifdef SPLIT_RSS_COUNTING
 	struct task_rss_stat		rss_stat;
diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
index 404024486fa5..1ce8fadb2b1c 100644
--- a/include/linux/vm_event_item.h
+++ b/include/linux/vm_event_item.h
@@ -122,10 +122,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
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
index 9f2802eff361..4a9fce369f30 100644
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
@@ -1123,7 +1122,6 @@ static struct mm_struct *mm_init(struct mm_struct *mm=
, struct task_struct *p,
 	mm->mmap =3D NULL;
 	mt_init_flags(&mm->mm_mt, MM_MT_FLAGS);
 	mt_set_external_lock(&mm->mm_mt, &mm->mmap_lock);
-	mm->vmacache_seqnum =3D 0;
 	atomic_set(&mm->mm_users, 1);
 	atomic_set(&mm->mm_count, 1);
 	seqcount_init(&mm->write_protect_seq);
@@ -1578,9 +1576,6 @@ static int copy_mm(unsigned long clone_flags, struct =
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
index 05c3858cdf41..6b84d0e7c3ad 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -804,14 +804,6 @@ config DEBUG_VM
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
index 6f9ffa968a1a..298c9991ab75 100644
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
index f60333798d56..c70905ebeec7 100644
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
@@ -729,9 +728,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
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
@@ -977,8 +973,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
 		__vma_unlink_list(mm, next);
 		if (remove_next =3D=3D 2)
 			__vma_unlink_list(mm, next_next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
=20
 		if (file) {
 			__remove_shared_vm_struct(next, file, mapping);
@@ -2286,19 +2280,10 @@ struct vm_area_struct *find_vma_intersection(struct=
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
@@ -2312,19 +2297,10 @@ EXPORT_SYMBOL(find_vma_intersection);
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
@@ -2714,9 +2690,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
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
@@ -3096,7 +3069,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
 vm_area_struct *vma,
=20
 	vma_mas_remove(&unmap, mas);
=20
-	vmacache_invalidate(vma->vm_mm);
 	if (vma->anon_vma) {
 		anon_vma_interval_tree_post_update_vma(vma);
 		anon_vma_unlock_write(vma->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index b098c0251137..4ae252a785dc 100644
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
index 373d2730fcf2..da7e389cf33c 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1382,10 +1382,6 @@ const char * const vmstat_text[] =3D {
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
