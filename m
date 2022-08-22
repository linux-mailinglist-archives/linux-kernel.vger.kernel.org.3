Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554BA59C278
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 17:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236200AbiHVPRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 11:17:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbiHVPPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 11:15:46 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E03C3F1CC
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 08:10:37 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27MF6aK3003931;
        Mon, 22 Aug 2022 15:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=nu6AjycPlkiA1bJBzo28ryDiRm/CBOQ7S/evRH4go7s=;
 b=C5iUlw1Htdlok1IuaJhRYF/GbB91v19NvltDMwm1DN6yDGDRr4oAOEyXMmwspqQJhGJd
 +TSU8VeSbPW9PjIkcRCUCPqUTIS03FHt2vLckgjzJ/TAuP5a18GQ1SgNo+sqcjDdeWxu
 2JcGB+JVljylghP/BRKMmuFQcxDRaNKVcUOszC5a1IGmqnttno4NJu+hRzjpb/wGT/xG
 fPoMJLziCsHpB86PlRC+b+Ydh/ENbv13H4kp3m6Wa2cz6p5S7OP5LPcXGm9ta4o513FO
 nIVhmaHyVoRrqSpBCHOLpFvbhHGrbmr/h07R1XK9PEETwND+hCwWEVXSoEixZFzFkb8F ug== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4c5680md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:10:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27ME4MJ8035319;
        Mon, 22 Aug 2022 15:05:13 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2042.outbound.protection.outlook.com [104.47.74.42])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j3mq1ty17-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Aug 2022 15:05:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bz/EOVZrmLurnombTFnzA317UcdiYyNXyQ0/euFbLJMUKXo0B1d100+g7VXNb8zSLuUgXD2ZTxeWt7Bo26OArrRqF8eE2YdSDwEJqj6/k3/wxjsqX+M6KY3a5WiGk7IycQQSH0vU23ouQeWVS//RVwnKL4DnI/Xz+t8rdOc9OLp4RvUPdrQ8Am9UyvZwPuaL2HbByPzL8Z2uRjcIxkXMOQy6qNJEUeA0XTYgZRt5dikE/dfQqAfnF0PTP20eAuS6SWOiK8C6LIqB/t8ERR+e6dEZqo16xTj/5izDJwNnv/AjSDvQ5nPLhTyUxrzrpzw67AYxuE7btrxdLMv7ruXkBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nu6AjycPlkiA1bJBzo28ryDiRm/CBOQ7S/evRH4go7s=;
 b=S9a0D2IYZsW0N97QCGNpXp9oNvG6eCY1bydyYzlJfLfw934gBotBf6Cd5GYiu3lhKzXtls9fXEPQf3qnrV5jmnAjyhOza2EfJNBBA5UohmpqNkxERoCCuFKdg2iBeD9HEDQ9u87OvS1ruXSL7fyX1750sjAUhsAvddHRreGR6csaoiXXfAMyi9ujbyg69ItzEIwqnP04KUQMSN1CWYpfh0YuVHFAEnk/I0DFydaEltjf91B/07MtJGSRb4EzAKtJMT1C1+TCOetkHafzJCMxYjgg31R71GK1sF6FiDc6tEIGfiZaxVooOHtBuA43HoyQmjkAZMmuoF1Ll7IpZpn1eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nu6AjycPlkiA1bJBzo28ryDiRm/CBOQ7S/evRH4go7s=;
 b=SdIGvp3tPq58cSAfpwtVdlzsmJx7fbU056OrFtybTT6SYnvfmdwKUVVTcdUN3s2xXf5BXTf3GjC26KLWsT4qWMQz0D/nEf6leh4Y6SPIs6W+GztaWZP2uU2R659c9YkGJ/tR6uWz9UD0c+/5IprjX8g7E0EpSHDKzVYetpc5yjU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6063.namprd10.prod.outlook.com (2603:10b6:8:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 15:05:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::3d34:ebb5:d9df:98b3%5]) with mapi id 15.20.5546.023; Mon, 22 Aug 2022
 15:05:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH v13 25/70] mm: remove vmacache
Thread-Topic: [PATCH v13 25/70] mm: remove vmacache
Thread-Index: AQHYtjiTEAWSkUMzIkWBuj3SkHuNCg==
Date:   Mon, 22 Aug 2022 15:05:11 +0000
Message-ID: <20220822150128.1562046-26-Liam.Howlett@oracle.com>
References: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220822150128.1562046-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed733869-fc4d-4fb5-0682-08da844fb5b9
x-ms-traffictypediagnostic: DM4PR10MB6063:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o7iGYGAnnrS1CEy+V+8lOBxwnn7iJSLW3MIqh/J+fVWKoZ832p2h/79NuSTV4XyBw/iPUovH32R7HLmq1TKepKfYTuoDku0OUEKBEXHUBhIyROOJVoAsuQ5NDjxmAAIwBN+nXrbsJYV5qCySc26+yn9Wiixm8xnUoc8+ieZMoRWp1H3JHsEpA+NRdKntGTu+OJ1lP50jtJiZ4vf745+UWO6bOV9fwP+xfs9W73saTvW6WCe8/2HF/IXhdV3A9Wq/d+c0leU/2DhwlQUcOkPM/ZgdeXPevfv3Zpxy9aXBs/xIl+2uBGAEwuAHvU/b0gEA++wGsE70HgSTNQxJPx8X3RnpNH8iNLTlfukz5dLck5muVDB6Wx67CHpTMos+iFgN9OESygM6ye8VOWfUOJy7jyb10JT50Jm4oaamjEAbumf29l7vN/+JujUf+BGimx0jqiWUdnakJ+sueJQrULek1kHX9AwFdzDJ4TZyLbsmK5bR+jo9NfJ2g1unERcs0Di5v5LUkyJ44d997GFJNCEomQCzt8aUNepN5AmWjjejctWHOKvm94Dh6ntL0K9svGwgSAhMxE8EP5WdkDjUt0WCPFDLhmM/65BZq88iBE2+ENO73zZqbwS7qlcgjHLPxSjssZfAcNouTqmVYEurXl3NLWR2h9LvYWbOAiudKlo967xucWIVoJVueA+N2upomj5SUN8lieYYUYtlAJKyGK3w2V/yDCHNkmDa8W12zx93sISB94Jgp07oHkZwM1Pwu6U3Hl8u7/9i6ADVJVJ3RrpLOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(396003)(136003)(346002)(86362001)(38070700005)(38100700002)(122000001)(41300700001)(5660300002)(44832011)(30864003)(8936002)(110136005)(54906003)(316002)(6486002)(66946007)(66556008)(8676002)(71200400001)(64756008)(66446008)(66476007)(91956017)(76116006)(36756003)(1076003)(2616005)(186003)(2906002)(83380400001)(6506007)(4326008)(478600001)(26005)(6512007)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?r+8+YfJKRI4cTWs2Mq2XceEyDpx25eOGhnoolzmxZAHZtLAa9eesRRAl9z?=
 =?iso-8859-1?Q?3xlRZcB9CZDlp70/RV1l7g8Gtgr8Fe9FO/UCFdjIwNBWg01gXKXRk0CA4+?=
 =?iso-8859-1?Q?HuMA5i7EpqkfOftU2OYsDiSN5v0tOXhZTg7ng2mN8POk7TudbSsVBzdyHu?=
 =?iso-8859-1?Q?Q9lgYr2yV9fR2fynWW+t49VfFKunBpFZDbNN2+yTtv13SA4lLCqcVbtW3C?=
 =?iso-8859-1?Q?/HLCNWd4lq9lQAPCZFfjGCI/qjdf6Ppl4zVbJVFcF2eM56ge3BRFtmrBab?=
 =?iso-8859-1?Q?cuTZ7fgyfEU/zY0+yheFEwGzwZu9omv02adFQppdsoF9pgMyIKZKiaT/Gi?=
 =?iso-8859-1?Q?JxGVVvdWsO54umMFO7huv6wVXBAUX9vTb0sFZGWA55G5wWwxC+ZEDHZCSn?=
 =?iso-8859-1?Q?y65y0cCLDuzBb2RZ0AHze1NgSiOeJqJq3d2zQ0mNal19j5k171QrjUJ+mq?=
 =?iso-8859-1?Q?nztcFUaemvarw6hE4V0c9VlgMkKeSJcGNCocTtlgwRfcIRCfoY4ni4mFYE?=
 =?iso-8859-1?Q?63YSMSfZVrmmyXDjbYoOYJXS4xCL3SU6rqukQte53XfoFL1sP2hyua+APu?=
 =?iso-8859-1?Q?bTXKv0TdMdCn+loRq4y85TZPZ2X8qo0eqD1dQEPHo3VnYulf5dhZX3FQnm?=
 =?iso-8859-1?Q?F5DYT2XbUKH+teMc9rqO7GPcbufth4oSPVRkrtNbf+/+ZO/NI/TDHAMiFM?=
 =?iso-8859-1?Q?brXaERFyb1reEblxH47fMxCW3HeqooERSv0Lr7Zzi8o3koWjzB0l9/ytc1?=
 =?iso-8859-1?Q?JuUONvpMdFWO769srDQMwC5yMN+bQb1R4e2EK/M7jU6VCUichPNPaIu7Bl?=
 =?iso-8859-1?Q?wz4kGP1KcIO6E39muvw2eK9RU6zFd87Zd0cww8EiT0dU8GoqpPaQ94qYzN?=
 =?iso-8859-1?Q?PZkO1GN6EG05+ZExcNNwVtkS4HqR8bt/I0rv7Cf5LltdLGdp4D2ZyOyjZ2?=
 =?iso-8859-1?Q?54Vu2VsH4mTirsNrt/VDIV6V2rltOoce7q46xoVTRl5rS5VpY3fPtdqZ/v?=
 =?iso-8859-1?Q?2ROiJvNqoIwiUoBxy6vj03pKwyqvKWBP9wXMJ5tsFBW2NPSkbXufln3jcY?=
 =?iso-8859-1?Q?hI4lQqee8UoNjdEhsj5H6pgQHxXvsOfLTsRVA9COaFSisuEoks2mG0v7/g?=
 =?iso-8859-1?Q?hOBbXi4e4JzNV1RVOvBdE3GHJH04T0B0U8I04pbAu2oWuokjofdBd9EGgX?=
 =?iso-8859-1?Q?MSxQ8Z44yhJxrJt1G1IcRMZBnKGTOu1aE59cEnjHxo7kba+QWdRSasKgKk?=
 =?iso-8859-1?Q?FKMcyNGvcLvUH4NXW1vYW+pXRsvlSnI6yCvVwVpt0C0AQ/otCHI01Gyy/D?=
 =?iso-8859-1?Q?8xm1UgO8FLWH9dP0YNi2AKsMLS32hnAFhmRN0r55EuHoeE9nJhn/MLFNSK?=
 =?iso-8859-1?Q?YRTB/lEIw0VbNiijhtdcN2hUyd60jNwGKzA9qS0fNgRis+XF6sg4xmLoEO?=
 =?iso-8859-1?Q?sjnyf09D6RNzjnbmaP/KplqC1uQXwxOWmnFQPdgB79rCfX5Bp6ThvlZmbq?=
 =?iso-8859-1?Q?AmNimGtTAAtYEHRnz41FiNvA6yz2y7PhDb4DYifkFLfopfhwMAXuduhHSt?=
 =?iso-8859-1?Q?bK7XhjAL6TH5X2xPHA0w1LYNLCLAokxpKFJeVaGLdy6g2z0g06cNBpds4v?=
 =?iso-8859-1?Q?Yem00GUwDRilASSpU1XuvczHJ7078+X1lVlrq5p+SzRWM6qx380pnMFA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed733869-fc4d-4fb5-0682-08da844fb5b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 15:05:11.2274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zb965c8eTLFxy/cSWYKjwsgp3UnO0h1NJ3UXTIqus3oAtvVREixiO4PjjA5/LxfTlJ+8WQFjRiP8OLkoxHk2eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6063
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-22_09,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208220065
X-Proofpoint-ORIG-GUID: nInloAh5Bv6Y7lY2x0Lnq20GFIZac_LE
X-Proofpoint-GUID: nInloAh5Bv6Y7lY2x0Lnq20GFIZac_LE
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
index 9a564f836403..8083fa85a348 100644
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
index ed45c6fafd94..90e8333ed336 100644
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
index c109167a669c..ec72fa79681a 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1390,10 +1390,6 @@ const char * const vmstat_text[] =3D {
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
