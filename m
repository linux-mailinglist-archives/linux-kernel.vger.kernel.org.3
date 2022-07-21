Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D8257D32A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiGUSTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbiGUSSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:18:55 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E948C74D
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:18:54 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIEm4Y025432;
        Thu, 21 Jul 2022 18:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=zrhAoquXqDnuqjTDDrnad7QTp0G6JFMJ0EmAzffxd5Y=;
 b=EUNhQqQKWqZphuQ7jirSnnaQEY0hcKfpB0e3+nwPQWvMleqTKCIwaPq2ezOCS3XMpNTP
 cqMsHGp28dDAvzk+hm8ev/K2l1djjCSbnhsOOtdP1EoTNJ1boUWjPGnxtKG81JjcHMdH
 ZBMLMZ7xYxpOb0FLEd2qyuXZmHmwhNrUdvxxHZ6p8hRYy9wgVHa3WPkHpEaVHgE7gGew
 Im8u/p+l1QjwJIKtKhkE79mLR4Rw0lyeYxq707FbBRZtCc6/pHN+Aj2Gy1QinOaPCf/h
 D+6KsOtYlRvafukjNL9NMmQ0kztHstvnCtBmTF85X7FMW6NQcz0f5t2tS74QT6CwuKp0 tA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtne0e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:31 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LGjMaq007889;
        Thu, 21 Jul 2022 18:18:30 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k5n75b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AyJKOa4qzX3zC8fgiPe8GsXRy1WCgc/gfZm2LpKH1NrNcmLFJ4xsfudMPBS4toAMvKpgmlbxV30OhwNaPWxWYXzLlF8Bml2RAl9EpkAzQHZlXIIGor26i6XYNprAuLXU5H14V8dBUrkWYi+/BFaPEBgIhqp0ea63Cyv6OlrhIByAN6iMnP2zRFVz/yDc03g8cNKGyquJbGCwWpjldVungH4gdo8JAB4FYKqiYombpMivRACTKrDi5zoPalhNMD6EK5hTqqO2f0G+gCGzvOMim2vrCRkipc2HzLfMfB32W9DN15mR6lzY/iaDUrBCnJnp4CIf6chnUDjerUyWM/Qpog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zrhAoquXqDnuqjTDDrnad7QTp0G6JFMJ0EmAzffxd5Y=;
 b=ZKHrYSuVHGIZfXFzv8lCvE3JtELEuOMePIytqxzGzUJ8iWgD5YBVGRtYr9fpQ/WPT+1FuEZ76pxkePsXXmmhj6GtjeBSzsIFpWWkuXkiVoJOXbAeciRDQQ5Vsg0DbFwZCernIkP0Z+iVAbZx2Xf44jXDdTvhtiVDRHRxhIvQ1tMgcPM2npBoCtfL0Flqus9ElnT+tA6M6FEbb1T5UzxWWvVASc4nDkaOHI5dIVSZBlwPOFRbdIyxq2PnHKH0DncDdgon1qtiJyTURs/qR2UatzoGuYrfIhv6e/thPmKAkuVEE5ZdlxxR70d6EtCYDH0GeMc+1P+LgIKfX27dsezjKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrhAoquXqDnuqjTDDrnad7QTp0G6JFMJ0EmAzffxd5Y=;
 b=krm4zocvCbr3ofkY0oEZZwvjfXnvAeVjNndoc98ToYkUQ2Ctwm3LUsiZ0og4fXSHGCHCPEmItETdorCZXAJ/C1TTfmcmpqOXv2Fn9rTjzjJK1FiSqIVVnsJhqK0lG+sdfYeULpAHN7pgPtOPucvASfR5yEZpSfzpPYXsvEgnZBI=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BY5PR10MB3986.namprd10.prod.outlook.com (2603:10b6:a03:1fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 18:18:26 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:26 +0000
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
Subject: [PATCH v10 7/8] crash: memory and cpu hotplug sysfs attributes
Date:   Thu, 21 Jul 2022 14:17:46 -0400
Message-Id: <20220721181747.1640-8-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220721181747.1640-1-eric.devolder@oracle.com>
References: <20220721181747.1640-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 28a34b22-f5b9-4bc1-fcfa-08da6b4567ad
X-MS-TrafficTypeDiagnostic: BY5PR10MB3986:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r9J9zeFV6fKohYPP/jgCJBbh+FfbqiQdw9eo13AVbbeGZXpo5WcCoAHOw/sOVmdTwUDEjQYVv6QhR/ds7tEITfw0OUx5rG6S7+LYpIkj5thY9/G0yBA4QIwVoT/rufSJNvHAJ5ZXz7sFGhlGtUdeJb67m0ne/t3Xhe9TUfCJ4z8WV/kv3hrk3mntD54Y/DvZCKhZKdNkBE6XGiMO46ES/zQnjiORY4YAnvrVYt0FWdR5akLECU/gJUAYXlNjFa3/U+6wLhN5kl0dcamgKB5P33OEOfT83BG6yAQpfBEVRLh85mtxDGoZYFKXApdaxunpdq2ICHKnmD5ZVTzrJ349YQwfttkJUVtJIl3/UizH6cyn3cipAasUCRt2FEtrlblh9/UAZxGOkDmJN90LHR4OlYdNZkddl7WUDGavSEFDuaNM6HW19BPJHY4s9gA/1I3wvRlOyHdWaPLEmzoLB6JP2yNyD84e6POo3+pOoq4mfPuTTn/ZfDp0Rqclncn2+4enIXZMOT7iK9qHvU3nwiM2hZHRwPq+d7xslTwwb2GDaP6teklJM6qI3Vg1U4zF4TO5smohMgDm6Fqlh/Oy2l1ZGSbZs6dkw8rW5e29jxad6CGivOn6t9hToC52XRs3quQ49f6U/Wc89hCC1XVV8erRg2ZLzLaEbrO79p4iw/fZPaSkrlLfPtqRw9MMCYyVRqthyvu7EwaN3QWiRwz+KRzuoZ8uOv3YI0iyNAjpG/SyeD3s5CocQZKhaUpaLMaLAqUGByZmmD4Dz575CsQ/NnfzkvU2ZUUUHJhCsJITq4S43gY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(396003)(376002)(366004)(346002)(6486002)(2906002)(6506007)(38100700002)(6666004)(38350700002)(66476007)(66946007)(52116002)(8676002)(86362001)(6512007)(66556008)(26005)(5660300002)(1076003)(107886003)(4326008)(8936002)(36756003)(83380400001)(316002)(186003)(478600001)(41300700001)(2616005)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/32Od0XFh7dv+tu08lWzPDeSi0Ipw6iP+b3yMiPrFUX5KfesTJ5h/cnAxJUa?=
 =?us-ascii?Q?x4hobSgO/mhpRcBIUNlzO7+SgygQxATaFNoh6swBt2y+Gr81e+4JtkihZbdd?=
 =?us-ascii?Q?9bPzDmuU0fspQbGDWdLl3CB7LJ9ZS+zP8uqSpVqf2zz0p6ulpzhJU0bRP68P?=
 =?us-ascii?Q?Gsj93SnZBNHyenQzDt3hVO3P4ds+lI3PXg2Ax+m1rqUzr79mk/O7XFPxl6Nr?=
 =?us-ascii?Q?edgOE4NafSYTfYag1bYARNo9tiY3ralrx5/W36PgNJQiOWURxtNTjcxrqfzf?=
 =?us-ascii?Q?+QFmn3tjnFpLw2Ao8a6ewcDWu+bqbGsJa2AKKH3AW61MWIM8w8NahoGs77Tr?=
 =?us-ascii?Q?YTYeIcy99I/geSObG4l9HzF8O06/RpEcK3dSWkifn35GuT4iF5gPTbv9Zyel?=
 =?us-ascii?Q?0L4Ido8c6K4mu5BeyndP1Gk8gSbrFae7VI45w6SIduAm1UaopzYcTQ/y3oSk?=
 =?us-ascii?Q?ZZfxFwE2ASYdCPyAvzJbmVB0PF7oDH2lAhVt+znhgGXP0gluEuxr5rjRfyx8?=
 =?us-ascii?Q?5U8SulKdjuijUiBPxKCvO6NcweLg5vxhdEIDjpJmb9GkcYFQx+by3UXgdWP9?=
 =?us-ascii?Q?i5wSermtmx5LVgJicdqOao1K6ylUmLjY6TRjwjXQ4DdXnQDrRCtP1sA/Gy1S?=
 =?us-ascii?Q?5++f5jFWXUhTMelH124r1CRmyUs37KP5YP9fpVVZW8FwK+xUgkeZRwqBXzhC?=
 =?us-ascii?Q?lzFS0Q75g6ZVh2m8H58qCAmBiK97G2x01aqgO9JzP/AevQ630hhtYJTCV9oU?=
 =?us-ascii?Q?mYj6MfSybBNt79ihGPB97I52/JTnZycVC131pDLbPDJEmlhMoxUm4/B6PMP5?=
 =?us-ascii?Q?QujMMRG0+i78eDkkrJLVdurSs2sRUQk9a9UjTmhV1+pOKCXYfNUrh2FDPYeG?=
 =?us-ascii?Q?i/mnyrtoCqbdTCx1ncBu51sXHA8TqMSIfnQSLXgVtsbUCG9lyZG+vcfvp1Ew?=
 =?us-ascii?Q?R5t+LnH1XDhIOSFB1FozxFKpMqxRdc4LVZ7RAE4xvRK6rRiCmUXn3XAhrThs?=
 =?us-ascii?Q?5RY/+ZSj+oHHEfARtHJYXH7aAgZl/pc037qBafUMHJiFhVVEGRa+tfsIw6pU?=
 =?us-ascii?Q?G5/c5DrvieWiSy5PXx9kICugNe2ARcXvis1lom6vZnKkMV+4VRD539QVHK73?=
 =?us-ascii?Q?OCQehx7Vz2sgl+yUk5twQ47xhcxas+aLHlrtg8ilAxzTHNggOCDE225LaFn3?=
 =?us-ascii?Q?JUIjr13UkcZ4YDC8Moxtviv9SYtHQMHnCKMpJg7DCWVJNAOsL5q4KsNhbF4f?=
 =?us-ascii?Q?sz7AiPWs0gMgeNp+F2iQG3oKgH5vfK2GN6saUQIQycFgmdBlh8kxXJzyhHWH?=
 =?us-ascii?Q?1+DImfbD0lfypyoaAZZsW+sLld1WVMe7vm27GUXd2etRfq2SqoYOZ83BdKMt?=
 =?us-ascii?Q?b/d+Sj02QUWld9LWC/xzVaxOa+/0N3jel/2Okk2qTT3rzvm5P3E9UyqOIx18?=
 =?us-ascii?Q?R1Wc3q/c+Z3h7d73C7zB2IWGy9TUeuOtGNw8wPXji7MiW0VkhWmux1iNV9t5?=
 =?us-ascii?Q?65hvBL4Df935HaV+6E8lRmXCh/X3W5c1fdJtUI58xdIJCyvTAOUan+3+wwzm?=
 =?us-ascii?Q?CUhLu6j2i32uafhudyLrY3DBuQTF00zB1P8nT3FjqW4IYtLRZzhU5jEvBnEi?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a34b22-f5b9-4bc1-fcfa-08da6b4567ad
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:26.5217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCwL8h+bivrfXOk4xFx2RfgdkKaFOhEeDIZ3pV+cwAWTfKYfC03Mb9cL/4GVW0ZjMfYw27zzbQv2e94nTRt6DgqrPIVwYjAt4BH+vXZ1JIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207210074
X-Proofpoint-GUID: TqhoZ-uPDHbiEAwpX5kUN-GZZqmzg540
X-Proofpoint-ORIG-GUID: TqhoZ-uPDHbiEAwpX5kUN-GZZqmzg540
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 .../admin-guide/mm/memory-hotplug.rst          |  8 ++++++++
 Documentation/core-api/cpu_hotplug.rst         | 18 ++++++++++++++++++
 drivers/base/cpu.c                             | 14 ++++++++++++++
 drivers/base/memory.c                          | 13 +++++++++++++
 include/linux/crash_core.h                     |  6 ++++++
 5 files changed, 59 insertions(+)

diff --git a/Documentation/admin-guide/mm/memory-hotplug.rst b/Documentation/admin-guide/mm/memory-hotplug.rst
index 0f56ecd8ac05..494d7a63c543 100644
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
index 4c98849577d4..bd470236d9a2 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -293,6 +293,17 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+#include <linux/crash_core.h>
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
index bc60c9cd3230..63c1754a52b6 100644
--- a/drivers/base/memory.c
+++ b/drivers/base/memory.c
@@ -483,6 +483,16 @@ static ssize_t auto_online_blocks_store(struct device *dev,
 
 static DEVICE_ATTR_RW(auto_online_blocks);
 
+#ifdef CONFIG_MEMORY_HOTPLUG
+#include <linux/crash_core.h>
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
 
diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index c9705b6872e7..3964e9924ea5 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -109,5 +109,11 @@ static inline void arch_crash_handle_hotplug_event(struct kimage *image,
 {
 }
 #endif
+#ifndef crash_hotplug_cpu_support
+static inline int crash_hotplug_cpu_support(void) { return 0; }
+#endif
+#ifndef crash_hotplug_memory_support
+static inline int crash_hotplug_memory_support(void) { return 0; }
+#endif
 
 #endif /* LINUX_CRASH_CORE_H */
-- 
2.31.1

