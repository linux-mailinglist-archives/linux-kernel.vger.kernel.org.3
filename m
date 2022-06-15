Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DA954BF94
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 04:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345651AbiFOCLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 22:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345575AbiFOCL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 22:11:28 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E2327FD9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 19:11:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25F0SmuK025870;
        Wed, 15 Jun 2022 02:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=sefoVSp5hvTja2V+rn1eEXD2zKbSenYaV+zKtfg18ws=;
 b=MlaRRpVCYaQHw3uuSBq7eEj4h6SNCFGb5ZRGqeOmVTPINxweXxxHhvPxNPRAgFHZH5vk
 TIcXeFQOtpN70oouNhvAhlL+n+RHdbOJbdi6iVadrVdf/+yQgF2iVVI+M3Qh7F6F5CcP
 66FPZj5+wff5EqxSMWWrStZcFT+BoKMFOknstN59JW6Zr0LuUHz7e6mDk+thZ+pMO6uy
 gZiUgFqFkiWbjzrm/FIW58qsPCWpVmqchqFXcKgREF2liQJm/CwTX+Rh1oP+ylGrMsa5
 0MproPkHdHHmmU9uUjAnX/97QP2t6Ld1RIIetCN1d6z4FfVNJ3gZngkXWzp1fBuw3J89 5w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmhu2qen6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25F29wWo003813;
        Wed, 15 Jun 2022 02:11:16 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3gpr25a1f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jun 2022 02:11:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PToEbiOSnffh3zlsO1ZltOiG2AMn46wtn+XqHm0qqnkHPDo/z0jCiX0/StFsKBMSNf6R0R4d5spoBTaJ9MffWCQsbec/3hdmB1OgVuhw+O7YUGJDFyS0GTt2tWuRL/p/b646fZgm8QraLcqVI41V9Ib/4mr9un5HV6gJMgMjjJEpNflOl2qBMfL5XM4etTIxYFepXggBFzuceezPvIr8QwloUpsmvEnvZoWxcaUgdgn1MW3BuI+2mmyw7Gj7L5SgY43jSq5wKgkqSSKR9QQnV1nprZeEWTPIekfEOmWauuZa2QiYhF7UHdGwCIvP5y+nhFZ9c6VRq+pmv8JgGadaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sefoVSp5hvTja2V+rn1eEXD2zKbSenYaV+zKtfg18ws=;
 b=g7V4I76DHbrof6AyDwC6DnDILt6aqFjw2NJmfEZmqt/t6iS55fOMvymfWVRgdAAHHBxCqMQjihXm/pd46uRGfY1J434SH6zAG1NyOSj36hpt2uLwtRCo/D3116KVMVBdm3DIps6lDoyWKX0OqduZVcm3ynjPlbx2BtAhBCzCc90LB226nbLro9L72DSGK8R5+GOj0dLFaut1B1bZFVP9PBbhRL351LLme5OfqDuW3ZG5KH6ex8vkEkev5ILddLvoHv+iUv5teWWRzpWNbnRCAxvuBV8IWo+FvrFY3ZTMIk+hlNh86k2cbKAcJ3IuyxfdNCAfmW1UFCagolPkV4HgNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sefoVSp5hvTja2V+rn1eEXD2zKbSenYaV+zKtfg18ws=;
 b=ZeGI0GFh3AIOCcwrO4IPTyQzdM3QUPtUEKPTrIYb2HsVhR71upnZC+9+ht7ZSQH9DlxORaqcU74GP4HtpS1nnEYzeFd9Kfr3BkAALAeuZCwgAjxZfDu2Dp2zQza54MQ/EVBWdjWBlIZUF/mt+iUiDN5QNLlPxog+bl4mcnH9M2I=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CH2PR10MB3800.namprd10.prod.outlook.com (2603:10b6:610:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Wed, 15 Jun
 2022 02:11:13 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::e9bd:ba52:c1c2:11e0%9]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 02:11:12 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     tj@kernel.org, gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/4] kernfs: make ->attr.open RCU protected.
Date:   Wed, 15 Jun 2022 12:10:55 +1000
Message-Id: <20220615021059.862643-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SY4P282CA0003.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:a0::13) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5874de77-5fdb-4931-2bd0-08da4e745205
X-MS-TrafficTypeDiagnostic: CH2PR10MB3800:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB38005644DD3F965D307FF03EB0AD9@CH2PR10MB3800.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dOYLmlR7u6QOVslcvG7p4TLnS/+RpZ0efrc5Hlrqrj2EglSuDLidu16Rvx1NAC19bkn54Nz8OJWVGXc83ZxHbML1rkVLXSPLs8tzzTamK89nRG8rNiaJw9xfSp7/MGvuvYn3JOlRwA/PYYg7UMrg6U8PHENrfJNGKfD6JuQIJBPZKSh4f/zxYDLK/r13MBxDIbUzDIzq2a/tawXGtYrfhcxDUeeK+5RNTOXbOoyxV17K+9IiwwC7OzWQEySSDcfBt8bjTkqZ4aUSyZizoc4QMVzndIr0TW/YBVPaz9zFloOE7g4SdA4EwUv4nNFGjJUkNMKQ7Z+iykOqdKc08suVLz82dL3H+EEj5PpKtvykuNIgA158lNxC7Q7p9xx0x0LnOySyT0xoW+uf4Hn/8Sw7gZ/fVW0u4nfl1vw708+RdtSuajkCvUn+2tGkDsVPCOF/7RirBUR/1g7ctQk6dYknBZb0Tfd67Qm6Qm30sTUElExoQRI68BMmwu2nAhLhlGazNzTHKFJM1lfD6dn8poioFjqIM+ThF1Xvwlj8v3FRtSf7I4TjAAvxxLqoHn6Tc65DGP3kfgLcOoZRfmVlrPvIsi3z+ZI74ycxGXZD6eQUL9IFhUxxRtBr1UMoA3Hh4blylGLth6S2H2Q78J4WoWUcoVqQ9NZENCaL6A+IekonC4bBxvUGRFrcWJmxS8p82O5Swvtc9UK0B+533ip7RgOpyaVd1OHrE2htwQ4hQ1/AGJzq2fEsFwxqPRkpWuWCEXAecxpnCH0df1/tZpZcVPwFP/+dPUwDODgQzmL7SH41XtKHnqDB0bRBgnXUxCFGfHE4rr0l7pHdW2AiKqzp6QnImizOTyk7tc5tmtZCR/VvlbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(6666004)(86362001)(38100700002)(966005)(5660300002)(1076003)(508600001)(2616005)(38350700002)(8936002)(6486002)(4326008)(8676002)(66946007)(66476007)(316002)(66556008)(83380400001)(26005)(36756003)(2906002)(52116002)(103116003)(186003)(6506007)(6512007)(87590200002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kk3llf0cRGb9y7y56NTWRAdDTQ5Oy/jJj87SdtlltDFz7rXqAFcQs40bYK6M?=
 =?us-ascii?Q?chHppDHcnYywm3LT1nkZcsHB2PWgEwtemUtSld3dGowKDRM3Ctu5xMmSBlTQ?=
 =?us-ascii?Q?17G3jdW6Zpz92MCfdds4X0jQ9nKL54PD/cLGaFFi11dwgoWkEf6cShh3HQzj?=
 =?us-ascii?Q?P0X3BTbZBV6ysc66Lh4folahOxL+IBt8odyxTW1Yoi3aq4Zzc4A5QfSU3SS7?=
 =?us-ascii?Q?APvnLRFGaXHDyqzSt2jBN3IJvLvL/X5jJA8sMJ3Fpls3H1b310p1497yOZI9?=
 =?us-ascii?Q?2WVq10wks6IIV6kl2MK9I+Vv20elw0LyzzpdMujUNR0jnF3JYQzmCgq3Vg/k?=
 =?us-ascii?Q?4eiW5hdTdDxnvR70FXyXhka3eJ+Eq55ZNEkf1Z3gMBA9g9LZvuvNGsaups1T?=
 =?us-ascii?Q?7D4nIz8PU0scViE4ZXmZbXgAZzaHS6pKNLzjWAmBB/N7gaQPkJgedx/Su4lN?=
 =?us-ascii?Q?prAoP4gyIcmjPPLUUHWbY9khb+aIPPGGwGMiGQnl7S1XATeOiKG5D3tYv5Mj?=
 =?us-ascii?Q?KO6tTz0ivAss5EWXIbYz/IQfMWYEUuimZglbw8yBcYdu4IkCqj06N3ulOGt2?=
 =?us-ascii?Q?54qodjoh8Wrj7kpsX5IbYC4KahgCOTaQISQM1M0IIQ28ghxKixob/PYDdL7G?=
 =?us-ascii?Q?R7nsBqMzFG4bdQtsoniFHC/aMcadpp9FnP9XHSbzBVCIYO89C+uNKciP9Ze/?=
 =?us-ascii?Q?Kh9IhDPAlxjcJ8zT1euYRimL6U2kJ6ODBc/VpqRB7pLsP5yy9boHg+9oqMU5?=
 =?us-ascii?Q?bbw5VYLVeaRZAN0jx8t2llV2POl9NvHiHs8PHb4jvwwwUXDR2k2R1WfmF+Ci?=
 =?us-ascii?Q?7aiwOhOxge3T13wyzzqZ/vhFU/nT7DTh8ItppZ2d16dyL+Ws/qBKkV6cjTfK?=
 =?us-ascii?Q?ONkUWBm8FEehscctaOkG6+5gDMvNPbOohQhMhz0wjomOhvo+tVX8MFe5LVnK?=
 =?us-ascii?Q?IOKceo9mqeSa8le5vGbmBB4F8Aepr7ccXypDjZk/hRyDG3ncr1naxVUSPkPr?=
 =?us-ascii?Q?8V2KXNWX1823UYtZNGuJrn1cQwzo9LFG3HVd4TxFmca7Qgq4mLB3+183j/9o?=
 =?us-ascii?Q?o+HePGL5zePhIX+fj2XXuxzEPNbLWQbTh15UFQ+/Pf8vK83GESvY8W1gigrp?=
 =?us-ascii?Q?QeQ24nAr0ZAY+CgM/HwegCKp/HWyfXw5SQpOfAdVr983vV8Sfkdp7NvaYYiT?=
 =?us-ascii?Q?Dfo91gv5I4D/oAZOx8mh9o+Zumt9KCjrScehsftXISoPJC8B8OT8Rwm6BQjF?=
 =?us-ascii?Q?tvPklsWqlUqDLdpeIY/Ws+ykP79IO5BG2q5xj9kYErmGFalHSBOBZdmDboEh?=
 =?us-ascii?Q?zkj/WtAB/b99n4srizTjQmNAOK4v0PDa7sCLM2quvFZp/6JybnPL/gykAW0J?=
 =?us-ascii?Q?+PS4hqm89e97VQt2kLzy/D+MwTJQszzgCkZa4HGZbT0asB3PkkTic5MEKbI0?=
 =?us-ascii?Q?N0vehemGwCnp7O2u7B8CCpZOv1InXJGqeKXxFoXFxm7qCHM2rWq9b8SGzpnT?=
 =?us-ascii?Q?rahlPtqg1Vzbw5LV0L2AnNVX8e48s4RlQ1l4B/dQ8Q1j7EumYxsLdSIYDTnm?=
 =?us-ascii?Q?v+RgPwglHA5LrnkKL1ae/bg/PyEQluWAn7OEJ12q7DP86+4Kv/C1QhONQgK+?=
 =?us-ascii?Q?8iC6MU6HrKpmKfWqcF3yUZyKCHeePgg7IysUWOqLQIkEUhAPgIgsW8/0Q8zc?=
 =?us-ascii?Q?Xra+DfQzDNyuH67H6H+VX2p/QNljYb6xuNjivpm920JhpZ1ZMZQARxN6+imW?=
 =?us-ascii?Q?Cq3xPJELmSgqhVFF7Q7n7pyO5x834h4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5874de77-5fdb-4931-2bd0-08da4e745205
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 02:11:12.7777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcF6rjSxIvgBySDDOBXRXuRrTNVHc1a1oxuoE8f6SiE8/QeOXH9cEZcQoLAH9XGyuZaAbunUieZOXVmGYOqE6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB3800
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-15_01:2022-06-13,2022-06-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2206150004
X-Proofpoint-GUID: N04tFN86-nudHS4Fxd90edmrWGXouRmf
X-Proofpoint-ORIG-GUID: N04tFN86-nudHS4Fxd90edmrWGXouRmf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patches in this version of the patch set are as follows:

PATCH-1: Make kernfs_open_node->attr.open RCU protected.

PATCH-2: Change kernfs_notify_list to llist.

PATCH-3: Introduce interface to access kernfs_open_file_mutex.

PATCH-4: Replace global kernfs_open_file_mutex with hashed mutexes.

Changes since v6:
 - Use rcu_dereference_protected for ->attr.open dereferencing under
   kernfs_open_file_mutex

Changes since v5:
 - Use 2 helpers for ->attr.open dereferencing

Changes since v4:
 - Rebase on tag next-20220610
 - Use one helper for all ->attr.open dereferencing.

Changes since v3:
 - Rebase on tag next-20220601
 - Rename RCU access related helpers and update their description
 - Address errors reported by kernel test robot
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2,3,4)

Changes since v2:
 - Rebase on tag next-20220510
 - Remove PATCH-1 of v2 because it is present in tag next-20220510
 - Include Acked-by tags from Tejun for the acked patches (PATCH-2 and PATCH-3)


Cover letter for v2:
--------------------------------------------------------------------------

I have not yet received any feedback about v1 of this patchset [2] but
in the meantime an old version of first patch from [3] has been integrated in
linux-next. Functionally first patch in both [2] and [3] are identical.
It's just that [2] has renamed one of the functions to better reflect the fact
that we are no longer using reference counting for kernfs_open_node.

In this version, I have just modified first patch of v1 so that we use the
modified function name as done in [2] and avoid those parts that are already
present in linux-next now. The remaining 4 patches (PATCH-2 to PATCH-5) are
identical in both v1 and v2 albeit v2 has been rebased on tag next-20220503.

Changes since v1:
 - Rebase on tag next-20220503

[2]: https://lore.kernel.org/lkml/20220428055431.3826852-1-imran.f.khan@oracle.com/
[3]: https://lore.kernel.org/lkml/20220324103040.584491-1-imran.f.khan@oracle.com/

Original cover letter
-------------------------------------------------------

This patchset contains subset of patches (after addressing review comments)
discussed at [1]. Since [1] is replacing multiple global locks and since
each of these locks can be removed independently, it was decided that we
should make these changes in parts i.e first get one set of optimizations
integrated and then work on top of those further.

The patches in this change set introduce following changes:

PATCH-1: Remove reference counting for kernfs_open_node.

PATCH-2: Make kernfs_open_node->attr.open RCU protected.

PATCH-3: Change kernfs_notify_list to llist.

PATCH-4: Introduce interface to access kernfs_open_file_mutex.

PATCH-5: Replace global kernfs_open_file_mutex with hashed mutexes.

[1] https://lore.kernel.org/lkml/YmLfxHcekrr89IFl@slm.duckdns.org/

----------------------------------------------------------------

Imran Khan (4):
  kernfs: make ->attr.open RCU protected.
  kernfs: Change kernfs_notify_list to llist.
  kernfs: Introduce interface to access global kernfs_open_file_mutex.
  kernfs: Replace global kernfs_open_file_mutex with hashed mutexes.

 fs/kernfs/file.c            | 249 ++++++++++++++++++++++--------------
 fs/kernfs/kernfs-internal.h |   4 +
 fs/kernfs/mount.c           |  19 +++
 include/linux/kernfs.h      |  61 ++++++++-
 4 files changed, 235 insertions(+), 98 deletions(-)


base-commit: 6d0c806803170f120f8cb97b321de7bd89d3a791
-- 
2.30.2

