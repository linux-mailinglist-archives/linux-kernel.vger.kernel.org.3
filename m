Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FB24EF9ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351262AbiDASfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351201AbiDASf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:35:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882501B4EB9
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:33:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231FivZ5017622;
        Fri, 1 Apr 2022 18:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=qKTk4kfcD986mViCk8iA/ul8C/H5q/WpbfB4Zx+xP6A=;
 b=eKbrAGzHJn7El+5Zhk5pcPC95Ynw0shcpl9lMAebBWr2gkIYWOp0CoUTg2HSKvs7DxVH
 o7rRK7mYf+HCmznjHz4ZUnE0k4zmlVa3Q9IEWREG1a7k/rD/yLsIslZoj3z81D+Jsiax
 EyJRWH9yfQTMG67D/RBNkB98p/6lDCermRqeFvyIHYFdSTcZuIwzA9wpE/S4jC7U6F1V
 36zRowlrq8B449+VjgXcC0JIqGecO6UqNqhRTMekviSQzrPzyAUeEcJdZdYsyj5N/sG5
 7AC1EKqOWwG9yT8D9hPT4cHoNCpgCAWZu9P59/zb7dzmLp+wlQn+NlW6iJMErV6kl7Xd 4Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1ucu00td-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:05 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IBOdw011926;
        Fri, 1 Apr 2022 18:31:04 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s9690dm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIWkMQtnL9qZDnUBfA8xAw3vETDZiRTtUd2LgmBR3WDQ8/bVWYW0V3CdetL/gGnJdhvUnlpLp4cNFV5ahIFM/tdoW5syPrgnmvlCtUQJmSPDf3Qt1/ysl1+n27LRol2PNYrMtDNnff16rWYb/A9pSOI0hI6JYgRXFoDI7Kx2DOzwDphUyqU1hHXQGzH8BUFiC8YrKhdKm5B6P0UAqQdzu1sOyL0fs+gHhTgChulYfOSt8HHOQ9bi2M9PYQj4tbiTzleMtCz7DS1AWj13EMOOVVeyEU1CYwUroiv5wAJBdAVJZG83MuP17AW2bQ9Ov/oSXf96UOPuah2thArTr6Uomg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKTk4kfcD986mViCk8iA/ul8C/H5q/WpbfB4Zx+xP6A=;
 b=UxYtCOQmOqT8R8re/hl3NkErBNgRT1gPDRvxb3OSMnq6GwqzojRVcalqM9hTLTM2cWXJ862IVd8NHj6fB+d/LmHHGWvyqUIPIweNEmRUYcY4/yNdVEbBVaZfXFr20Sq1mnJmh2xaHO6kytnDVK5jT4op9mO08EDpFc9ieY6Zv62PW5wnuMhAkOrYjIOZyE6UTPJWIy/kIpe3TLhq2dZ3O/6hZvh8Mr384/14eRAiKR2L0F5Oa0An45vtHAL+kdojqDez8RVMk6eidpfPaO6Otb/T/BNclk3EzhmlR/c/LM5b2CR3Z8J7o1E5JadK+K1b9j2NttU89GdZiWtuN+SaRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKTk4kfcD986mViCk8iA/ul8C/H5q/WpbfB4Zx+xP6A=;
 b=wuD2mYi3apLDIycvaK6Qf8bRswyAPNq2RC6E8CIeGjq1Nu6rXUW4r4iiNkpGTS+jIqcT6tpTsMlyZKhG6MZJiMjkD4aUMcoy+7GIkDNPgLxR/UQ+yLUiQ2vGxcb6mIg9lTOhTneiZIBAd0ws5RKslzqcx3drUczdmyd34XgX/HQ=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5502.namprd10.prod.outlook.com (2603:10b6:408:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 18:31:02 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:31:02 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com,
        eric.devolder@oracle.com
Subject: [PATCH v6 2/8] x86/crash: Introduce new options to support cpu and memory hotplug
Date:   Fri,  1 Apr 2022 14:30:34 -0400
Message-Id: <20220401183040.1624-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220401183040.1624-1-eric.devolder@oracle.com>
References: <20220401183040.1624-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eac7f04b-8d5c-4b78-2706-08da140dc64d
X-MS-TrafficTypeDiagnostic: BN0PR10MB5502:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5502360E6B482DD4D7A80A1897E09@BN0PR10MB5502.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P1rGhJpA8c5HrwGpDK1uwWmsZ9Rg0yJblYTZh5Mrxqgqjl9lr+PpyCVspFnmtbhA/Aj0lAOoXOwJO4HI+46PGz22uOj3dzkh+1GWqlqYxexnrFBQIYIuD1du/AwCyaa/1G6NVxRJKAr1MdIp8WE5gyDvY9edqOuWkfXewwabfL+bSyurvrsPWFiG1bZYzS7fWAaALvUjPpkf83OZGgF8CvpnrdifanbJEgg04+kczOfn1dzJykZR1Dt7w5m5YN3OFdrTUmi6SrbxsL/kzi2IJyL9PH/8WnddL4qTSw5KtpJT4vEAXeaQwPjVdk+ZHNWVsllRqV/kr3FGkJYrI8mY/MKoyVd5J42IwC9fSC4io1uMpES0LNpBvXAD3+uVJZuAAkUBRw+ysnBt2TAvYqZ6WrtbZmxShVanb3H3PVe49cjoSybzzLCqNNPxDOECXFp1Tk6piy8dWtNbrg+qtZvAn9coR49NugRB/4cGc+J6gCyWGik9LKwR6kGs+93z/KAsj9vLkl7rn4uAYMr1+nRGOvu5xC3S/4m1F+UWtX1epRfoC13+OY3JXstVaeK6ZPsriTKZZzFieiHkQMZISsdKG9aqIDUQ04fHI7PrXqe9GqB7zf89CVvMbZuYVhmML9VJnG++Q1MKifomL4JUlZ/VH/sIhUdpZOPeSfvoNZfEDFG/44rZcFd6NxyWnD7vhbV2offT57juJd8jsBd6llcQkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(6506007)(6512007)(7416002)(107886003)(26005)(2616005)(36756003)(508600001)(52116002)(1076003)(6486002)(186003)(5660300002)(4326008)(66946007)(86362001)(66476007)(66556008)(8676002)(83380400001)(38350700002)(8936002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FCBCi+Zj5XPoGrCzbSy88jen/QVzR3lpClRshDg21MjKrpRCM68e/g4//YUb?=
 =?us-ascii?Q?6lLpbDmg/AA3AohaI7V2e9ez4Dg0ZcYDyJ3neMcmmkAxB9etH8gDk5Vkzq0h?=
 =?us-ascii?Q?b77RzBlPgargsaxa62r/ejTaDr7/PfKk3i959s0NRR8266ADJV7E9aCSPvll?=
 =?us-ascii?Q?KgmR83YZXru1TPUZWX0dIhzzLC//v6zJDDE0paEef7rdQ6Cubv+/0LcgG7gL?=
 =?us-ascii?Q?IQEVm1ePANee7s3cYswWlo4yf0TCy3U++79uvVmp2xh8fER/p1VmN8+GbDp3?=
 =?us-ascii?Q?Licbs5kGKxhWlobRw/CxCMRYQ22ny2xtaMoJhPZTpuqx4JkspEQ4RR1XX9TC?=
 =?us-ascii?Q?slIg5dXp0YDBGx02QH7/ElE/t6AynZgQNvzXqGDBBtENbZRxXfFo0+Iahy+o?=
 =?us-ascii?Q?n6WLdDw+rbvM0EnHqLMMzgCojNYCisntYovathBWHnUudCjrWdwSrBzwDbA7?=
 =?us-ascii?Q?OWjSNYjyhGzfIm5nYtynfgTN25H6SOnSU6KTbTNYYgxK1V1DbL+D0fGHH2xw?=
 =?us-ascii?Q?uoeI11poXs6Q9AnoHejcH6rGY0NrPZhS8NNDiK+puOwMR6qkT56c5/53ZTT+?=
 =?us-ascii?Q?FDHB6CLDNBuuNOxZI69AHJ0CnqrkRUe2/matm+I3l05HMs/O02t4rDPqwERC?=
 =?us-ascii?Q?UB6Dp3bnuwOmpnQFLok0cQX9fO94U2DrzN/TrJHiXeFquPxOigBC+QMHYma0?=
 =?us-ascii?Q?EqPreZQTaOkb9yIs85+JprsAJX2YkGWWkiWlWxtbGSaPmOd6KqnqCK83OGsX?=
 =?us-ascii?Q?O2YKNKSIcaD/K/6u3fsOCN04xpBr2u/vVjxphYOFBCc0WEykasarkoi1U9pk?=
 =?us-ascii?Q?XSGyjINIetRqM0JBJwS8JJbNWPq/gz9FJ3oPwuyok4RnhzJF1eaaaGg+V8Wh?=
 =?us-ascii?Q?xulHRMAM6eHa0/1Lc63bPuCeC76hevXDdWDtnMA1fH5HohykWqMS4qMpquFz?=
 =?us-ascii?Q?CNSAcX+auMbE9DcQYwTztAIr2YmCvoOLOCFcaKRgGOn1Z8NLgsLoe3QSM48E?=
 =?us-ascii?Q?eMdQ0ieVdTPHR44oYyHDiQzzUOwY0GU+YEvEf2sMAJdt/8VTnUjo+xlR4eI4?=
 =?us-ascii?Q?gb5DmwOKYWSUsSPL+I70CTgRwE6ejE26MFYpnTyIlwKgFiCG8JGW15RDMoOu?=
 =?us-ascii?Q?+1KvhF0vS7DiLrBdRCOFgu0K9cye/YwM1NK0YLW8VEAOvjFBd7uT9ylsC+Pe?=
 =?us-ascii?Q?KKTkWmH71sTYQ9wPopAw2qcsX0410gWN3ahPQ7KbvKtDm47dXMHcLTfyRDZF?=
 =?us-ascii?Q?LtPB8sSwNNFknBSPwODZYpMzID3Gg/2XddNKPWkB6tnOnONANO8ln47W44uL?=
 =?us-ascii?Q?D+8i5Er4wclf/xQQarLReAMtuIExYpCKucf0HU9nLIS8+4RLWzJ4v6Sw6DOD?=
 =?us-ascii?Q?5SphF3dmfg4Z4yvitK+3FUsiGUdfc2Ta7PTnOxqG+PDqOjPzgcnZVJQNbBMR?=
 =?us-ascii?Q?ZDz/b7mXhJJtUnmdath9Y+CHRmvWd5KNtoC5ji9LdsYRJ2ldK2UjtEufnQcT?=
 =?us-ascii?Q?OnVgDkFvCMpIt4o1zWnMjoZ4kEDWcaPVzQoEAF1/KKg8E1ept8to7E1JOXfr?=
 =?us-ascii?Q?KN5y6MNpmQyut+afhVlTbnq0SMk71wUnWWs8zRDyWIB56wb+eYv1AU2y/q+4?=
 =?us-ascii?Q?bCMdb5hKYfsyVaDCEC3uObILcvUFeAm6RDS8rvsAxz/tIN1+MgPOBKgXIlde?=
 =?us-ascii?Q?GQ0ps4I2V+yGfY2VJsUN5B2w/hogQjEZ9Ya3iA9xm6MxtZcGjJiXD8CK9che?=
 =?us-ascii?Q?7FqpYQi1kfVyMhiQ6EzoVcKBhRcIUio=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac7f04b-8d5c-4b78-2706-08da140dc64d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:31:02.1827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zW9dEUdiZy5mVG3kz2+n7+r++tjQHmzHRns0LQAMR9eVV+xr3rumayoo2yRZa4/fxSJdPK6LtpWgSHlnXjeuUt8lKxkD5onuLrljYfrWoJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010087
X-Proofpoint-ORIG-GUID: QOGFiXD-OStS1LF3HX0HZnDgRx8B-I_8
X-Proofpoint-GUID: QOGFiXD-OStS1LF3HX0HZnDgRx8B-I_8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CRASH_HOTPLUG is to enable cpu and memory hotplug support of crash.

CRASH_HOTPLUG_ELFCOREHDR_SZ is used to specify the maximum size of
the elfcorehdr buffer/segment.

This is a preparation for later usage.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
---
 arch/x86/Kconfig | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 7340d9f01b62..8b51d3196b82 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2072,6 +2072,32 @@ config CRASH_DUMP
 	  (CONFIG_RELOCATABLE=y).
 	  For more details see Documentation/admin-guide/kdump/kdump.rst
 
+config CRASH_HOTPLUG
+	bool "kernel updates of crash elfcorehdr"
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG) && KEXEC_FILE
+	help
+	  Enable the kernel to update the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions) directly when hot plug/unplug
+	  of CPUs or memory. Otherwise userspace must monitor these hot
+	  plug/unplug change notifications via udev in order to
+	  unload-then-reload the crash kernel so that the list of CPUs and
+	  memory regions is kept up-to-date. Note that the udev CPU and
+	  memory change notifications still occur (however, userspace is not
+	  required to monitor for crash dump purposes).
+
+config CRASH_HOTPLUG_ELFCOREHDR_SZ
+	depends on CRASH_HOTPLUG
+	int
+	default 131072
+	help
+	  Specify the maximum size of the elfcorehdr buffer/segment.
+	  The 128KiB default is sized so that it can accommodate 2048
+	  Elf64_Phdr, where each Phdr represents either a CPU or a
+	  region of memory.
+	  For example, this size can accommodate a machine with up to 1024
+	  CPUs and up to 1024 memory regions, eg. as represented by the
+	  'System RAM' entries in /proc/iomem.
+
 config KEXEC_JUMP
 	bool "kexec jump"
 	depends on KEXEC && HIBERNATION
-- 
2.27.0

