Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA31553BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 22:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354495AbiFUUsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 16:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354349AbiFUUr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 16:47:58 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27A42EA0B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 13:47:31 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25LJ4NhB004714;
        Tue, 21 Jun 2022 20:47:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=sP+3kfNf3aYe4mtX+DsnBwXKBWiECjX/bw0G20QpNAA=;
 b=oxE+TGCcfgEcHYrfWT0vcDxyfEdEyum1MFb56h+eEyyjLJgJfNBW8mL8aWy58AgglwgV
 tw76Q9uBQveQ/QA3wljv9SSCehlJfmWOA90hpf1tMns/azvjxgekzzLv36TVsGSrCu5C
 2uVgJqDfDgXny+B8c0t9mwpiHmn0hID+4p44YKWF4q9VBFDgIpNtXsyYNDfETNlYsjpJ
 UOW2BMVOKhTOmZ8o6k5S+GCLAauGYdl8EjaqGuPuwFi1SfBjRbzzXoZKo+rsRqO3xDD8
 P1U4EaTLAsGoV60y3Gw3qGREmtXjjB8uAc2Fax5rq3yM73dgAK5DxAN6eGObFviAnJzc GQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gs54cpnw4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25LKeUgs027828;
        Tue, 21 Jun 2022 20:47:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gth8wsp36-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jun 2022 20:47:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4ajoHYB0p+zUF3mtUWsFrleGR4mxCjYV/Yt0Du8w23RNgvRUzbs37LkiOlivWXu4dlMsNUycVzzeH2eDUaiD9mZgfYtMZzdqRsOnnetR50q9Fzw1/1i81RFG3Hryix3VAhATrOlMUNi3lgZTtl9qiUvTbcph2SSTvJbVbBkaYydb7iWTC9QAw0ucuGjcUYdP/qsWxwkGe9u5wzuYnslu2+wIIYJR9etFm5Qg7PX6Lkx2oL/BXr37LON35cbmfj48Vo4tSgIJ2nEY59rniWZfgYMlxmWo8Lf9+WmBihXAP9JA+AwMJKkLARCbP7nRflaPGtA9NErpGZmUwd8+vAdtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sP+3kfNf3aYe4mtX+DsnBwXKBWiECjX/bw0G20QpNAA=;
 b=Dx49a/wh303DQWmsG7zN6+tonr4XFWr07R/OlababgKmsCUCnlqVhLup+P4xK6CrzIsleCqkFJjl2QUvbyr91gu/qQk6yayv11e3T5+nnkUrgrL+/uT1x2qpA8CLgeulvojd2wrPDAwh4NhVhmGEgGlWvOf3WHyRNjJ8wMoImiqcFbBVAXAUxTEgS1yp53tsy7CHn1Qd6lzh6poINhZ6VSCUrchWdqutvjCExplUlZAC6GGm0i0lPM/e0EOyqv9f4s4JnQ93d+3Guu/leQX+6V44kWEPBZsTxgSEqf1DGt2JqxBYVGjrV9e2JMIA0rzFsYjw4YTTuMSADMzzemv0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sP+3kfNf3aYe4mtX+DsnBwXKBWiECjX/bw0G20QpNAA=;
 b=ntd5zjSYyQdRdV7SHP88TM5ql+Hrwl8UeV0X+3cRLXkH96AV+zYpnDr3gRkJ86GxgqbiTUA0SXFGwoUHMNvXdZ9Ag2PuT5ynEe1slO7Pl2hL5+xIBQYhS0w4L5wkp8KH6DU803VBaFx5ITXNxyIZlR+IoyNKdp7MOn0Su1JSdzU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SN6PR10MB3085.namprd10.prod.outlook.com (2603:10b6:805:da::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Tue, 21 Jun
 2022 20:47:11 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::f59a:175d:d24:949c%7]) with mapi id 15.20.5353.022; Tue, 21 Jun 2022
 20:47:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "damon @ lists . linux . dev" <damon@lists.linux.dev>,
        SeongJae Park <sj@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v10 25/69] mm: remove vmacache
Thread-Topic: [PATCH v10 25/69] mm: remove vmacache
Thread-Index: AQHYhbANpDBvJLe+FU+4yDvWg1uMyA==
Date:   Tue, 21 Jun 2022 20:46:59 +0000
Message-ID: <20220621204632.3370049-26-Liam.Howlett@oracle.com>
References: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
In-Reply-To: <20220621204632.3370049-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72aaba8d-ec14-4e1a-fb21-08da53c736e0
x-ms-traffictypediagnostic: SN6PR10MB3085:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30858AAD5E1B28B7AF3494DDFDB39@SN6PR10MB3085.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXKPSgta9oGhLf8jdJQ1PYWorJdp4W/BEMPFtN3IMDfkyQMX06T39f5vdXBYk5j1kyNKOLQGwo3bEKzdH2jYmKjvIDSgpK8V7rPh6Ukjcvj8UJBJU2um/V6sp1J5lUSsK1PoO4r4atmwd9Nryw20r3Y0ZywNu7p5WeZtSiQCwOH2BMpXfEDQDxP8kFUzZU1ItETXdKfNQgtu7Y1HFxFfVa9YXwGPWU7X203V4x8yuXDSuoQqXIY8vb//AWEnvyXw/XxcfnOM3X91w62HuBn8uuUdYVPkEE/XwekTyA+a3BKXHYuW+6gaBZQw0DUdKF+onLT5gqZSOskm6la05yXHrsqi8ss5VWsnhvcn/Q/PTmWSy+rVFJxDsSiM/cKSFzAaVA4lm7z8Yopchz8w1E70J2GWksUQJEsKlyb5rYj3Q1zmBAM118HdhRMph5nMtP8x8d2qPdZPTghkurvkvg665tLF/8uQUa+hw5zEpCR9icy7thqS0kAS60M8fWvTZ9LwBbxAq6uwJjOu2ZxrYbfPLjAxocLpB4aWaF9JP1zUeThMzNt1Tkr1urwigx5xfSOxm+n1O0AH27b6Ozloc94tPtMkut2nIwwkTny0bZz2qGHM3FMnVNGeVRxh2YLlaJDo965GAOYpx1iBsccnrB6VpGAh5LTSnuyBcpWdJxWIcgnqfUJRXqDavtHt1sV7Vgk3Ly1B7a0h1+QRUmqzi07jgyDHczyF2oAJ1UxxH5aBWDplrfMo/qvE6fmmZC8lMi6ONWzQPGvJ6SKhNGA4WmAFtxSdO6C+DESNwqZPqzl2dbI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(376002)(39860400002)(346002)(136003)(2616005)(66446008)(6486002)(76116006)(66556008)(966005)(36756003)(64756008)(83380400001)(478600001)(66476007)(1076003)(71200400001)(316002)(186003)(44832011)(5660300002)(8676002)(66946007)(6506007)(2906002)(30864003)(41300700001)(26005)(6666004)(86362001)(91956017)(6512007)(38070700005)(38100700002)(122000001)(110136005)(8936002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oCkAFQWKFs8HWFkcbv0s9RKFBgnXiUmVknBdKdWsvG/KlnOsexA/BxjPgR?=
 =?iso-8859-1?Q?ay5Xr+WSCs0uqXI3JP5vB7VM2A2CQ9GrF4tN7pdKwy5a3sZHlMiy03K4yT?=
 =?iso-8859-1?Q?fIne7ZyR4TYJApnBneP9GNoxQkPrGWQ5z+LY8DJDwQ1YSyhZY9zMt27M9/?=
 =?iso-8859-1?Q?Ov7iwavoVbitwqdQoVhiTZuhgbPuvDURH/aOlfZ+/r0yTFHZbry4AZzLPx?=
 =?iso-8859-1?Q?L1vxintEyvjAIzPqNNxt0uOtw9EgTk9wqKHRnx3QeTKI/0IoNMM+2FdhO5?=
 =?iso-8859-1?Q?y0vO8LMfXpSo9pvcgJ2JoQOyrQf0kFywcZReIn544swfS3wVUg0BoSPvHs?=
 =?iso-8859-1?Q?wnDCz6ecxXJLXDGSMJ8TTJkRlnuRvvNZwLcTWSWuWV4JPXZ8tBegMxybBd?=
 =?iso-8859-1?Q?9ur0bt1P81JSRcv35qn6gkxtbdU6e3UZ9CjramEsISWq4PPTxwoTTDFUCk?=
 =?iso-8859-1?Q?lVM7+ZRVwZmdhVIut1es+aeqTEW5nkaEA0J0wTAga512wOz1/W7Rh9j8jY?=
 =?iso-8859-1?Q?Tts20exiTWJyFX6Amri91dvsyDPLgmK2F6Ybhjrl5/7/ooXFWITzkuWdmP?=
 =?iso-8859-1?Q?xqHWLsWPkNNjZB3IW41/6KRtzMEYqT8nvP0/k1lt3DzU/4CIl+5V0h3QVD?=
 =?iso-8859-1?Q?eOBYCBJPvgcUoPKESQ/A1B6nnTPPIigKVBGF+bPOrABp4scqX3app5mXJA?=
 =?iso-8859-1?Q?SdqTtXlGiAzkFj9ApuK3gFyl7NGrV8jLfclr4VI6AoBUrnFaBinXuqYWMv?=
 =?iso-8859-1?Q?tYanrb9XvurtDheGcU+u6PxxG8cluNaWeOMtzdROeZe9q6IGDPv485d4O8?=
 =?iso-8859-1?Q?/aKypurxL+ddT/Nmzcj00KPqtnU6vaZuPZYsaoOWkwyn2e1VL62/D6i6UB?=
 =?iso-8859-1?Q?WvLpBiH8frZMFugdKEyZY3k4LYJgmtAImMljJiD8FCm/WJRbggKmx9k+y/?=
 =?iso-8859-1?Q?qeuQoBNqWGCpyXh67JoBendkihsx018Sv5BzuJWA61bKiyTeqg7HJm9zxu?=
 =?iso-8859-1?Q?psoOHqpudq6p539rWiYLCGePuUJtF9Rb49j+bl7+YosEv4CwqjBJ2veduG?=
 =?iso-8859-1?Q?qXBZIoaQ8Cn18hslbkMyHx1wWHjIvNE5OpVJ+hlTwN2LYd9MYXfK+LoCiN?=
 =?iso-8859-1?Q?Uq1Aane0Mw10H/5Zl3xQUGyFaq8F6S8O5DNDL2tpLnO9EIPb51wjr7dUKD?=
 =?iso-8859-1?Q?ZMVy1Sc1Va0MwB7vGKa6YlbYkgMy5L3mugyz8zP7204KeaSN8rC4kVIPq1?=
 =?iso-8859-1?Q?UBWbv9hkdpuneI2U2kZsNiM32854MxXspAglefz7HUMgVY5Rb/p3R7g4pa?=
 =?iso-8859-1?Q?TN3iak3U4zCReuwW2cObTObO8TNNMoyvLCwFRjCdx2pUq/y00q8kqw2Rcj?=
 =?iso-8859-1?Q?ldpvyyRB9kYp7BdwbBDz5u6EWk5N+6tZx4gocpOMqBw7YaerLFSXgtIIdX?=
 =?iso-8859-1?Q?8XFCSuM5zH1u6WnTz3f4qY8NeCW6YnVpgzqpWgaviTDkmFW7GKd4984DQO?=
 =?iso-8859-1?Q?fIuRh5PhFzyFLXATmceMIpO3Hnc4C3YrpyHgv/7dtxCRAcSVxf5b9hVFB4?=
 =?iso-8859-1?Q?G7WPpMyfkpHOdRH57JtemMTqCHWdo8Kz76Jdp+/5grPwabw8MliKq37Ak9?=
 =?iso-8859-1?Q?6o4w/ZdUjT/1IYYzN9rES6b4wcNVCZ3b6z6j93yGt7GlnuVonNh1oLpqEF?=
 =?iso-8859-1?Q?rcnv73R50ZKnEIq6GQ6Z2CceLX3co8OAfC1w0Tkn//f+ixcOyp6wn0iefJ?=
 =?iso-8859-1?Q?ionTgOsF16DwL7DoZMGKnV1XkjyK2toIl9Or6Pu0FbeND3NJ9qVmVAKlbG?=
 =?iso-8859-1?Q?VJmQMiWsjErSVgtCOZfunXAZhY+bsok=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72aaba8d-ec14-4e1a-fb21-08da53c736e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2022 20:46:59.3321
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWUhcrO6tx5J6MyudL7R5uHInO3wLVemnAPraKUq2mbphFmfKZdNjqqKjqQv77p5Xdk4zBq2WoDMFnWvd5xYTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3085
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-06-21_09:2022-06-21,2022-06-21 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206210087
X-Proofpoint-GUID: f1_61Qw2jCBLruHz9gTw30BioTS4_aPA
X-Proofpoint-ORIG-GUID: f1_61Qw2jCBLruHz9gTw30BioTS4_aPA
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

Link: https://lkml.kernel.org/r/20220504011345.662299-10-Liam.Howlett@oracl=
e.com
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
index 1fa9a9d1b584..070468f521dd 100644
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
index db420a1e93c7..a653b259c321 100644
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
index d6549a74e73e..d87b18b49a3a 100644
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
@@ -724,9 +723,6 @@ inline int vma_expand(struct ma_state *mas, struct vm_a=
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
@@ -966,8 +962,6 @@ int __vma_adjust(struct vm_area_struct *vma, unsigned l=
ong start,
=20
 	if (remove_next) {
 		__vma_unlink_list(mm, next);
-		/* Kill the cache */
-		vmacache_invalidate(mm);
 		if (file)
 			__remove_shared_vm_struct(next, file, mapping);
 	} else if (insert) {
@@ -2265,19 +2259,10 @@ struct vm_area_struct *find_vma_intersection(struct=
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
@@ -2291,19 +2276,10 @@ EXPORT_SYMBOL(find_vma_intersection);
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
@@ -2693,9 +2669,6 @@ detach_vmas_to_be_unmapped(struct mm_struct *mm, stru=
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
@@ -3075,7 +3048,6 @@ static int do_brk_munmap(struct ma_state *mas, struct=
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
