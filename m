Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCC15A2DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344923AbiHZRjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344797AbiHZRi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:38:56 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7145E1901
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:38:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGR0CI011386;
        Fri, 26 Aug 2022 17:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=gf3LTSfUVQWThDTHLnop4gvpogicO05cZePqIdhqHe8=;
 b=nO27jhMQ3s+QCCWRtviaULMnTm+Fxa0KwQFxZEWooxxtRd4n/dPDfl4IdpS8HNYzlQ0F
 n39JwFzAKng14dniP5pFBNuNod5jF2KzSZW90RxQTe9rP7wpR2gfuq+YNvutQl7Zwv0Y
 hqBzrw+UmF0Jhyd8nUbZ/t3DIuzNAXxm49ZKpF6Ttpz375m0J6frexOUwrrM/GAVGNG0
 K3D1XU1rmdCDXRJs98sTTN40SMIylMhglM6vopGmcG0TDhRtpxom3LJ5oJAP9F3OlIhD
 Bov2RTGX2BeOfAGD84jC+utLloElGexJrBY7XZneC5BmqglknxhvOfinnnBe5R7RrKl3 WQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j55nygjay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGt86a018909;
        Fri, 26 Aug 2022 17:37:27 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n59c88p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diMm6SdSeKlBzxVzz2RcxhuaWib3Y4TqACTQ8tDpTyYjwqDcwEQCp7zllvcX9MUQ//vW+CqdLq0PIHsJ1CjJqlo8nXI8tR3JjVnVUQj/wSIh5LEuP7McGr6DRqwDSmkxtpA5E2pTFuCs/F1jX+zJVOMKrYjaa177xEUM7kcS+ec6atcim3W0LTqAaxAl9M5WJqyZhUZBEbMPmQxHiH8TymW9U8DLymoXI74ssOqGFEEsvNQRhQ427iMelwz15C+1MZ/sO7henYTFXRVgtQJt/kzYhLj9KTqm8SPSgdVpg400pJL4dPNzxsu7RRMq2JNK/15RBip6WKBQda4Eaoe+8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gf3LTSfUVQWThDTHLnop4gvpogicO05cZePqIdhqHe8=;
 b=OU4MdHIOIV77mfrcYfNooYmmkVflvgvJy64u0Szk9y+FZ6oI7J/hgRro2g13bp3a6iqdoELZj/Kjv9q4Uzci8NbZpUbtftGepADM/VeryC6NsXfpsk6bICfUoLPwyeDH982Lk5Gy3R36hMsApVaZappHBjryLYwcoLogKQ+VlnZvYx45zKeIpwMKvilZ2+7KWTF+uiKfcmik1sMvNeBfK4107atJVJBtu2RZk36W1V1L3SzpMdeu6yRaGFRBJqMxPrg1/yHuwOF4m6MD1pkcfxOtY4nBaL3EXjvRMuS+7paZHC8BM0Vp2eqJPvf6ZJjl9grmBHPC/iUz6Stpn//k2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gf3LTSfUVQWThDTHLnop4gvpogicO05cZePqIdhqHe8=;
 b=z292ihlU+9VRJuIL14G7wQe7EeHaIhRtNdcbCeNn9tnDLXO0f/hBUKAlMWXRNDQHBHjcXpWZauVhdog71qAwaghytFJkdbLVjzUvj/uValmeGh6Fi3ip+FzXxljuVWq7iSlKJQ2wqoPLPR9vo4bWPdjKnv/mJ8JCofoJfxDYeEw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by MN2PR10MB3518.namprd10.prod.outlook.com (2603:10b6:208:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 17:37:24 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:37:24 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v11 6/7] crash: memory and cpu hotplug sysfs attributes
Date:   Fri, 26 Aug 2022 13:37:03 -0400
Message-Id: <20220826173704.1895-7-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220826173704.1895-1-eric.devolder@oracle.com>
References: <20220826173704.1895-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::17) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 315ba0ad-eb12-4653-82d1-08da8789a347
X-MS-TrafficTypeDiagnostic: MN2PR10MB3518:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gr4TXHnogcTJSqcfID4G3WSjPB4mvikVX33qb7jYeJGpzrsWlGIYa13QBifZiFlSSOJBuVfdt63CMutqZV49ZKXXl93Q9ON7wCeNru3oDkMJBM0fJGX2c57fYNLjMWijRMRjxGpuAtAW9oTrxFK+R26FsJ5tGhN/yNczqucW1CdBgZ0LjLEE1veqWZI/PxgPIDoffP+UJegY8XYQMaG1vlzvPK0ky5ZeCEN6ca+pZNQ51SgHvQ/nlcQ+2/azg1j+PBf6XAd/yoe4CcQjnuO79GeShX7DA9P0fzIyJANLFQi3Kv+57tlqbMtpEj4qtPWt80qKr9798kpCnn2ElEdqoKBT9m4wNY84KKUWYug7WObhM4JelbhMba4uWNu6Y32LAiZNcVcf8fQg+Z79XHtuC4baTHEm845eZubtVKx71npBacJtzuYtODr/VbwVfdsaNeK0XCnI00kEfIeavQ7zeJESqgRGy5ooUVhYXd9Qv4cH7P23b00JpAk+ve8bmzoyHR1epLvBbaWhBbrr90SC9HRaGKhI5zSy46JSrcSvM1BrSgEy9EO9L6xhHsS6cM7YWMlSUKxI7/LSBFAbyOZpPBVKroZSvZZIWQkx0NS5Y8CiCMVNJyXMU+iEUK/Elv1pGSQ3s4M4VjnMB+31aDf/vstZf73M+x8joVusI5dWh7lzeBJnil/We1tfxn+y2HjIi3eDYjK9odI0SJZi6HMP0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(346002)(396003)(39860400002)(376002)(2616005)(83380400001)(186003)(1076003)(66476007)(107886003)(316002)(66556008)(478600001)(66946007)(5660300002)(6506007)(26005)(6666004)(6512007)(41300700001)(4326008)(8676002)(6486002)(36756003)(38100700002)(7416002)(2906002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Et0sPOUV2nr7DgYrhDZnP8abzsddJm1Ati7ps4sxEr5vxoDSLJatpex5euW6?=
 =?us-ascii?Q?eCuehHXalEDSLnfU+9eb8Toh4vkZWYWxMJ866M9WQQ8TIGoUKOmi5UmBDo50?=
 =?us-ascii?Q?dMdOSP4nGz0sHHgfIHhb8EC4CrWe2b0vKJM0jOD3ZL1EkGSTYcPyVLMCGwdl?=
 =?us-ascii?Q?3/1aYenBAemcR4ImpX/N0XEKBOzozLT8xT4wtuZ8t9c8AiSivOIa54R9Jeke?=
 =?us-ascii?Q?xKagtVUn6is4PxYksXRX2WddXQob27oDAVdiLI6Wv9GEqhZGJsDiGVGmFKc1?=
 =?us-ascii?Q?rPE6tYq91hlebqSCeM03qqWFRnyTktjVwoooBXYiiX4a+dz3MtSssVx1e7Wl?=
 =?us-ascii?Q?CuhAY+2pYbR2uBHjwrWYza4YAIemWNrCs8hiRsg+FuNlW2Wb9iF085dc6Utx?=
 =?us-ascii?Q?tUiFBM2p93zNSuaxNVHMVA/6jKi5icU4QwEtsjyObQW53iB6ohEa2TKlOPJg?=
 =?us-ascii?Q?D48Kq4v2f3kM4JVGrmbOXznGXlJDziJXNMe7nl+HZcc3xJBok8R8QtVNGXib?=
 =?us-ascii?Q?G1Ijnk3pN3F2z5B88Oea6+opzoA4D2lCYm3gJCzGcseFJC6nzE7YYLrAyFXe?=
 =?us-ascii?Q?kNnZKslME5IHUyDua+5aiQenk2IjcnYR4luTw7nOUsbcMYLotfwNBSCzLQIA?=
 =?us-ascii?Q?rYpOhWRHsk42G4a+n3PfRsu1dTVOKaqEAvaT72I+LX7XAuuldb/DEYDVK26n?=
 =?us-ascii?Q?onW3Wj//erOxcTAyFfuH8QlyORwHbBMODw1r6DofIQvE/vbrI/tpdq2dI1zF?=
 =?us-ascii?Q?t5Slanjclbc9p+HeC+lC8DkWU9hS5yXktMWF0mW66/9nVH/huPTTCQvxh5v5?=
 =?us-ascii?Q?jIG6gL0u3rJ3sMHryvFncpRRQf6lkAGIS4To7JxEd5rXQwg7ANm3FZ4lpWoO?=
 =?us-ascii?Q?rGDjWcnkn0axt7TQvQWU3lnPOqPU4PM7BT2/7+2gIn8FBIZOTwDknI6JLe0L?=
 =?us-ascii?Q?l0o/Xne55jQN+Kd38p9STcgLpJgjUtFyLSUj2lBFzJoluDDlkWfV5N19uReM?=
 =?us-ascii?Q?Vvdmj5kD1jr8mKlJ+XCA3+Jk8PH3RfECh31A1/1V15l2MPFHaOGoLWtbGnOv?=
 =?us-ascii?Q?HfLT6I+e9fcdjvf343jkn+iJ/Et9wHnvPGU1l/fH1gogAh7EGM6wUyauXIaN?=
 =?us-ascii?Q?4zviRLCI/l3QIe0cithmhH9ZLRey/G7m/YOXW1TMkzusSTCG3+ZsxOr7Qmny?=
 =?us-ascii?Q?mmwD7Q7NVE5whUM6iNjIU05Di51e8I5yOjCuNcV43vKwoGFfwVdBS8VfnNZi?=
 =?us-ascii?Q?qe9gQN8BFaLdQduwLj23qOf4x+f3tEpMd66UFuJhf61zgPgl7rmzfhaW5DOK?=
 =?us-ascii?Q?dSBkRPBfmj5G5n4FZtjdeRHJfFOzNx5y5oLmPgEAX3LYNVbwOhQQFE4FvcxZ?=
 =?us-ascii?Q?uwbvsES5Qhhxz7F/1TeI52eAnhqMezlGw+U9x37O9Sh63cCtoBrJERhe7Vmm?=
 =?us-ascii?Q?902dkCHN4mEVe5c42yuiDcaCtD53alQGb46YUMzma4k8xtlzrn2KhzkspJIG?=
 =?us-ascii?Q?HTxn0yCu4il7/sbOTv+sKqlOA207zCBLP3/Jx6abSDOEzIa90UcjuljpPQtS?=
 =?us-ascii?Q?NBmvEd8BUrZavt7Utpq+SjAy4zAxBf7L36/e1T11ZS5XTuexWwPDmwOxcdav?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 315ba0ad-eb12-4653-82d1-08da8789a347
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:37:24.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eElJEDwHAqG+PucO8xsMFy/i6SeDqpXL7PGpY08T4il/1x91w16u8w1x2WLyL7SkPA/fwhdxjSk4Eln83QJZV0srBHgRlSWjP8I84BRwIi4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3518
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260070
X-Proofpoint-ORIG-GUID: 4c8ku_kJ7dkRN3-hGwGKMSDIrATcO8E0
X-Proofpoint-GUID: 4c8ku_kJ7dkRN3-hGwGKMSDIrATcO8E0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This introduces the crash_hotplug attribute for memory and CPUs
for use by userspace.  This change directly facilitates the udev
rule for managing userspace re-loading of the crash kernel upon
hot un/plug changes.

For memory, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/memory directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/memory/memory81
  looking at device '/devices/system/memory/memory81':
    KERNEL=="memory81"
    SUBSYSTEM=="memory"
    DRIVER==""
    ATTR{online}=="1"
    ATTR{phys_device}=="0"
    ATTR{phys_index}=="00000051"
    ATTR{removable}=="1"
    ATTR{state}=="online"
    ATTR{valid_zones}=="Movable"

  looking at parent device '/devices/system/memory':
    KERNELS=="memory"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{auto_online_blocks}=="offline"
    ATTRS{block_size_bytes}=="8000000"
    ATTRS{crash_hotplug}=="1"

For CPUs, this changeset introduces the crash_hotplug attribute
to the /sys/devices/system/cpu directory. For example:

 # udevadm info --attribute-walk /sys/devices/system/cpu/cpu0
  looking at device '/devices/system/cpu/cpu0':
    KERNEL=="cpu0"
    SUBSYSTEM=="cpu"
    DRIVER=="processor"
    ATTR{crash_notes}=="277c38600"
    ATTR{crash_notes_size}=="368"
    ATTR{online}=="1"

  looking at parent device '/devices/system/cpu':
    KERNELS=="cpu"
    SUBSYSTEMS==""
    DRIVERS==""
    ATTRS{crash_hotplug}=="1"
    ATTRS{isolated}==""
    ATTRS{kernel_max}=="8191"
    ATTRS{nohz_full}=="  (null)"
    ATTRS{offline}=="4-7"
    ATTRS{online}=="0-3"
    ATTRS{possible}=="0-7"
    ATTRS{present}=="0-3"

With these sysfs attributes in place, it is possible to efficiently
instruct the udev rule to skip crash kernel reloading.

For example, the following is the proposed udev rule change for RHEL
system 98-kexec.rules (as the first lines of the rule file):

 # The kernel handles updates to crash elfcorehdr for cpu and memory changes
 SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
 SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

When examined in the context of 98-kexec.rules, the above change
tests if crash_hotplug is set, and if so, it skips the userspace
initiated unload-then-reload of the crash kernel.

Cpu and memory checks are separated in accordance with
CONFIG_HOTPLUG_CPU and CONFIG_MEMORY_HOTPLUG kernel config options.
If an architecture supports, for example, memory hotplug but not
CPU hotplug, then the /sys/devices/system/memory/crash_hotplug
attribute file is present, but the /sys/devices/system/cpu/crash_hotplug
attribute file will NOT be present. Thus the udev rule will skip
userspace processing of memory hot un/plug events, but the udev
rule will fail for CPU events, thus allowing userspace to process
cpu hot un/plug events (ie the unload-then-reload of the kdump
capture kernel).

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/kexec.h                          |  8 ++++++++
 5 files changed, 61 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index a3c9e8ad8fa0..15fd1751a63c 100644
--- a/Documentation/admin-guide/mm/memory-hotplug.rst
+++ b/Documentation/admin-guide/mm/memory-hotplug.rst
@@ -293,6 +293,14 @@ The following files are currently defined:
 		       Availability depends on the CONFIG_ARCH_MEMORY_PROBE
 		       kernel configuration option.
 ``uevent``	       read-write: generic udev file for device subsystems.
+``crash_hotplug``      read-only: when changes to the system memory map
+		       occur due to hot un/plug of memory, this file contains
+		       '1' if the kernel updates the kdump capture kernel memory
+		       map itself (via elfcorehdr), or '0' if userspace must update
+		       the kdump capture kernel memory map.
+
+		       Availability depends on the CONFIG_MEMORY_HOTPLUG kernel
+		       configuration option.
 ====================== =========================================================
 
 .. note::
diff --git a/Documentation/core-api/cpu_hotplug.rst b/Documentation/core-api/cpu_hotplug.rst
index c6f4ba2fb32d..13e33d098645 100644
--- a/Documentation/core-api/cpu_hotplug.rst
+++ b/Documentation/core-api/cpu_hotplug.rst
@@ -750,6 +750,24 @@ will receive all events. A script like::
 
 can process the event further.
 
+When changes to the CPUs in the system occur, the sysfs file
+/sys/devices/system/cpu/crash_hotplug contains '1' if the kernel
+updates the kdump capture kernel list of CPUs itself (via elfcorehdr),
+or '0' if userspace must update the kdump capture kernel list of CPUs.
+
+The availability depends on the CONFIG_HOTPLUG_CPU kernel configuration
+option.
+
+To skip userspace processing of CPU hot un/plug events for kdump
+(ie the unload-then-reload to obtain a current list of CPUs), this sysfs
+file can be used in a udev rule as follows:
+
+ SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
+
+For a cpu hot un/plug event, if the architecture supports kernel updates
+of the elfcorehdr (which contains the list of CPUs), then the rule skips
+the unload-then-reload of the kdump capture kernel.
+
 Kernel Inline Documentations Reference
 ======================================
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 4c98849577d4..fedbf87f9d13 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				     struct device_attribute *attr,
+				     char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_cpu_support());
+}
+static DEVICE_ATTR_ADMIN_RO(crash_hotplug);
+#endif
+
 static void cpu_device_release(struct device *dev)
 {
 	/*
@@ -469,6 +480,9 @@ static struct attribute *cpu_root_attrs[] = {
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
 #endif
+#ifdef CONFIG_HOTPLUG_CPU
+	&dev_attr_crash_hotplug.attr,
+#endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
 #endif
diff --git a/drivers/base/memory.c b/drivers/base/memory.c
index bc60c9cd3230..b754918c3dac 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -483,6 +483,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/kexec.h>
+static ssize_t crash_hotplug_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", crash_hotplug_memory_support());
+}
+static DEVICE_ATTR_RO(crash_hotplug);
+#endif
+
 /*
  * Some architectures will have custom drivers to do this, and
  * will not need to do it from userspace.  The fake hot-add code
@@ -887,6 +897,9 @@ static struct attribute *memory_root_attrs[] = {
 
 	&dev_attr_block_size_bytes.attr,
 	&dev_attr_auto_online_blocks.attr,
+#ifdef CONFIG_MEMORY_HOTPLUG
+	&dev_attr_crash_hotplug.attr,
+#endif
 	NULL
 };
 
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 9597b41136ec..a48577a36fb8 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -529,6 +529,14 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image,
 }
 #endif
 
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
-- 
2.31.1

