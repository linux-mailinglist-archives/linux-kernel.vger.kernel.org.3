Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1472954A234
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242497AbiFMWn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241380AbiFMWnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:43:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EBA31224
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:43:50 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DJdqfH014673;
        Mon, 13 Jun 2022 22:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=eldiZxD5iK/c5XtJJkV7T43bOH4j8yUJOeHQn9yX7IE=;
 b=wBUkhAmfaACoGKIA7T1D6xz8BAPT/yrAo+dpHneB0lVqXm0Hu6UcLzCu2S7LrKy0AaJz
 SwcMq7h4RGBK14F0Eir6QwW+DaLkaIEmFlKkLhZ4r0M/bwBBy7cs8zYC8BXFmXfbvDp2
 iaS1JVWNDpZpOvXAEbZvPNyjIXq8bvyzukQcbHGG2jARFdrKJqN4vAHedl77te4QBJPe
 XuQR50VcywVIWL9l+bX40O4/2wV+yhTMurWxJ9J6kpMOApl5cW6vpZYmipGgRwY6KJHE
 Q5YLVHeE4gHQG4jwG7CIyr0vYqlfiQbjTMY3FJsYpH7ipmMS/AfFmDBkYb/Q+eHcuYRC Kw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3gmkktcaf6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:25 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 25DMehqi014918;
        Mon, 13 Jun 2022 22:43:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3gpe88r47h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jun 2022 22:43:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNzcaLSjOtXEtdSXGbyK5HnFVI++8vkN11DPFqj2JCVGKwxW+BnNZdgvjXWy1Sk4DRhxm5zeOHRFReEV7W/zExwP4Ib6CF8x2oeT5ILufvTL751jEgNrsvPixv6taCK5BdP6lIxR9PrmJI0uBwpsVjchA0e/R6aR1FWoQzVHVi8mVlTmgak14IrirSnynJoiGAXQnljJejL0dPaYBk3Zs5zdoGHfXET2vqIKsAjAgejIRUsLTaAeIo9iCLC/eyHDdSgDCxeZTuizkyFTdEcffnBZ/bfeSZf/Q2u1IU395mk41h73Graoxkv6otazGPaLkzxAtyQPWwClUpfoBLzuPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eldiZxD5iK/c5XtJJkV7T43bOH4j8yUJOeHQn9yX7IE=;
 b=lq846ivK/YgyYFEdcYcIAfwj3EZ/62E214FkVgrxWn2am0IcuIqCTMAoV3BmjsdCLT3gt2ybfXc8tA+Eio8jkoiNReWdmMBxXpKkVlIjl9tkfF1khrZ4asT8lV+GqclKNgHvQCakOF1hIMy/Ao4/qkHqVgFjnkmDj30VK81GhzIL5yALlJZ3jfomwYIAcWmhxOE+Auqh/L/aGyaa0baLlRP24OXwql6nsNUc26Gh3bFrB1Uf8kE2KYLLGfcS4ehbvYGmdcx61hajtcIC5W1ZZxHHVDC00BxHRMCwSG4Me6uX1IcRDIaFP9mjB5VjuZgnb7KMeCUmPV3YVjvOo/5l4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eldiZxD5iK/c5XtJJkV7T43bOH4j8yUJOeHQn9yX7IE=;
 b=CQ11LUUUPmiF6VqZ24ZSePW8GxOd1jR9MSW7bbyPsylFo2bK7bO0TZODD15G1Xom7SbaCRlqEFB8f+y/8D2yNuHhN2YsMmZU59rmTe4ktbXcVg+OGz08azJq5tmfocK0MST1CUaBbuijO2cw3NDwgah4SB35Iu2snUcV36e/f0U=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by MN2PR10MB3824.namprd10.prod.outlook.com (2603:10b6:208:1b7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Mon, 13 Jun
 2022 22:43:13 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cca:c83a:81cc:18f%9]) with mapi id 15.20.5332.021; Mon, 13 Jun 2022
 22:43:13 +0000
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
Subject: [PATCH v9 5/7] kexec: exclude hot remove cpu from elfcorehdr notes
Date:   Mon, 13 Jun 2022 18:42:38 -0400
Message-Id: <20220613224240.79400-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220613224240.79400-1-eric.devolder@oracle.com>
References: <20220613224240.79400-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR15CA0041.namprd15.prod.outlook.com
 (2603:10b6:4:4b::27) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ca56f55-7b91-4fc8-7669-08da4d8e1953
X-MS-TrafficTypeDiagnostic: MN2PR10MB3824:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB38241EE950301827D4DEAF3797AB9@MN2PR10MB3824.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WmwOCdqKSqUDFntgG/Rtw3NB5WT0zoXE5+XSw/a/CP7HU++bdZ5Cj8kM9kL6e8KA0CdXfIizks4lza2Y2IaHRUk0QsQHndTHXcy9mSMx+oADfOo/gB2IltM7Eg/uivw+zo/WAOkADVlWdOvLcSrQF6CLkJ11MM8LDQViX+tSgzWabCY7spUclrexuhKb7EkfOSfGKD3Yfj9cCelfQEDC8zlZpXvHIMnNQkSmsD3L+glgUBU86SVkoFi6c4rPP1IsTeJoSbuM0t69JtWPxl5EzTlGTDp2OvO04Q5ZMT7qJ9tmbg4zAQQCi39WTATYuDwXTCiJnQ47Mpdg2I+HNSdYCgYZKSah95n/WWOuh8NVgB466aXUhpLvc2sia7GC8JVR7x44rTc/q/ke78n6dLFcq7nrsSF+enhjNpTUST7GrTuDBvbrobLE90qsQkv8N10MmOdEmvAt7T4LI3ETQ4lvGaIwFKlqlF0bXf36wLPWIcQBY62rEquQXOxk7yY8S1TBEH6q0SMJI5OdMmuLaFfn8sZLeA9rkTJx+mNweT1Z0sqzoWvSJAflWsVnKNxPwjn6UuwO4bwgvEGxaxQ6FPqWlgeC6IyEkEp5hIGVF/vQuLNRB9gjkizpbyCsjpSd0oOVIa+3wRlHBkJPdvDH1H/tv1Z9LHifiQKjT8aX3BDzU974ltM83jTT2XDyos2A93L8yUUXArA5L1VpdM943DRNKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(1076003)(83380400001)(186003)(107886003)(2616005)(38100700002)(38350700002)(36756003)(8936002)(7416002)(5660300002)(66556008)(2906002)(508600001)(66946007)(6486002)(6666004)(6512007)(26005)(6506007)(52116002)(4326008)(66476007)(86362001)(8676002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9nNUs+QHRE3S7ZLt63TTp4l2pYFe+buAFj6DYKlZtyh+FE1NLh6hhUF+ag/U?=
 =?us-ascii?Q?lKn0JxwMz/3lNjrMvob4YZRTS1Rzj7kgCGD0IrofMdysQr5uFsTpl+BCiC6a?=
 =?us-ascii?Q?qyzmbBWtZdA9iBelMETRPkI9fZm4tiZw9k2H9tCXT8AWFjAauhdSg0JtVRwP?=
 =?us-ascii?Q?sOW2m9pN0HwdY1dKKyzo5I5WYvOX0WMbpWzMJYFxaQ3Ptc9UYH1dNWsUUBN6?=
 =?us-ascii?Q?asdrAhp7b4Xndg+ZWZBEbO2eP+DehpSivOyZm8ZdbcDsWdoJFvxXEq5ksXPg?=
 =?us-ascii?Q?VSf9wrD+46hQJlhcC39TUxPmFnyeXoSzW3JgRLeiup6anGPS573aTiYv77ub?=
 =?us-ascii?Q?k7vFvkGwPYBT4TyOoTxj0w3u9tnFxwTk0iXhD8nDk3CTLbi5eQRE/U4WkVdx?=
 =?us-ascii?Q?LV5q/M5/6fORjWoBrHf/2jRz6HEcXfp+cEyLEO4/9nVZaQx8clZDoZrbTIek?=
 =?us-ascii?Q?gJMr94ZfMBdZ/BNeq+OUHtGIQEeZQGGcUK9SEuFTN6zAp/KryZVA08GLGfuj?=
 =?us-ascii?Q?1do2a6Z3tXPXv0weDHrxJ7a/p0L+Rlc+lKhP5M+Fs5JEbW302z8eZR2NPq98?=
 =?us-ascii?Q?1SfsfoYLpVRXy5T9yTNVtWdFoExonl2dRHCnWXz5SDKyb9Rh+wg61i0EY1rJ?=
 =?us-ascii?Q?Hq39V0TpwIclt/VdvtD1O9BPFwlXgfm1alxwu68pkgIS3LSkCtBQMvKZNJQ9?=
 =?us-ascii?Q?c2A9sOsMJYLAaGK+KPWmYp2db6AJmmT6jDUHfAXVSLG5cW6DK7srLm9ZyFGd?=
 =?us-ascii?Q?wGbv2BwmE33VDPlqK1FgtQdnJbiiceS4J6KPDLkigZuQ25+msoCXz2qhoP1y?=
 =?us-ascii?Q?DHjJ7a1AmosTt6rePHLkH73XHFn6w7s50nLDLAb4LRSn55gvFbScQGq8/c2R?=
 =?us-ascii?Q?fLW5bfZ/10XRsPQlwQL9yv/HKCWD+xGWKi+yhqSSgaMblEgPco4KsbkbSFY4?=
 =?us-ascii?Q?lG/TDIrBk2p6ePwA6aSvASN3XXI7tLLEnVyu7HU4tzu/3ukroNlI74wrJRj4?=
 =?us-ascii?Q?FRBksjRMQPQcUR8bSv+B3fAVhITQREfAyksjw1sxzGfjNit6rguoxGiZ/U7o?=
 =?us-ascii?Q?9NlS7xM+0pcHDW4XUEIQ+a2C0CRwuKGTnkLEKs5JFHBjWISX2QPvXQicZtX/?=
 =?us-ascii?Q?Jcz3ZKTDCjmmBkIQdfNhO0P1STyRjV/ph13k7wh92xNFXrcI2fVjPYQVXjsM?=
 =?us-ascii?Q?LoIAuHMa5qx+exz/stl6//D+y8L2aeWmV+QThf2/FiZxboNyNUm+CHsJ5024?=
 =?us-ascii?Q?rPkrpj3zEgA2wzWi7CqcVpetzEz/oY0l/oN37LZKAVvJ0VfSCrP4e2w8SCid?=
 =?us-ascii?Q?ubD3rTLpRYX4des7pJuppKU8W/1CWbd46ehU+ubAed10Nn11BxXI4ajQSw12?=
 =?us-ascii?Q?Sr6G2gVlFyO+zGHTqb1joywS8VQbppnIPl50ojvKalpN9y8X7i2QzQnLChmI?=
 =?us-ascii?Q?Iagq5ptOb8hCFDVzpxPkQLHfCvruAUXWOjsqXjQ7VR3fCeGcKCaBJsvwu7X6?=
 =?us-ascii?Q?bu4ri/xjouTozBhkbbrqPUZfG7Lh6GVW0QQwvomR5/zl/SHIrRue2UM+LlNW?=
 =?us-ascii?Q?bXODGnNqzkSHz8UL08R6vtx1ybu2Z44uZGGDVRsrfJY7lPbZ5Y1NnPiLDjSQ?=
 =?us-ascii?Q?5KER60zZSzmb9famk/wvmgkPzrmK//oWDBGUYuv6UBVAXuGrhdi4CSjeRqzx?=
 =?us-ascii?Q?45AXOvP2tYXD2ki7MIWpU2RhaCuglnLaOL00xuIny1w4MkZ2qCNXl64k1C0r?=
 =?us-ascii?Q?DGYGOkaEaXh2lsuuyqKTU8jqLOsPvKk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca56f55-7b91-4fc8-7669-08da4d8e1953
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:43:13.3659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gsF0vr46DbnA2CwtsgMOTqJRWy1m3KIwyCsPrFKmE3gkG6MX0voolhe1yWZz2EYkt/VYDAC2TFKDEpE1fehlMGQPjOKO7NqYDF77ojj9GF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3824
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.874
 definitions=2022-06-13_09:2022-06-13,2022-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2204290000
 definitions=main-2206130087
X-Proofpoint-GUID: Nh9CzpBbS7gl9ybmdFMu7syof4hQFDDH
X-Proofpoint-ORIG-GUID: Nh9CzpBbS7gl9ybmdFMu7syof4hQFDDH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to use of CPUHP_AP_ONLINE_DYN, upon CPU unplug, the CPU is
still in the for_each_present_cpu() list when within the
handle_hotplug_event(). Thus the CPU must be explicitly excluded
when building the new list of CPUs.

This change identifies in handle_hotplug_event() the CPU to be
excluded, and the check for excluding the CPU in
crash_prepare_elf64_headers().

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_core.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index 84eb10a4241f..47f667df1c0b 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -358,6 +358,11 @@ int crash_prepare_elf64_headers(struct kimage *image, struct crash_mem *mem,
 
 	/* Prepare one phdr of type PT_NOTE for each present CPU */
 	for_each_present_cpu(cpu) {
+#if defined(CONFIG_HOTPLUG_CPU) || defined(CONFIG_MEMORY_HOTPLUG)
+		/* Skip the soon-to-be offlined cpu */
+		if (image->hotplug_event && (cpu == image->offlinecpu))
+			continue;
+#endif
 		phdr->p_type = PT_NOTE;
 		notes_addr = per_cpu_ptr_to_phys(per_cpu_ptr(crash_notes, cpu));
 		phdr->p_offset = phdr->p_paddr = notes_addr;
@@ -650,6 +655,16 @@ static void handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
 		/* Flag to differentiate between normal load and hotplug */
 		image->hotplug_event = true;
 
+		/*
+		 * Due to use of CPUHP_AP_ONLINE_DYN, upon unplug and during
+		 * this callback, the CPU is still in the for_each_present_cpu()
+		 * list. Must explicitly look to exclude this CPU when building
+		 * new list.
+		 */
+		image->offlinecpu =
+			(hp_action == KEXEC_CRASH_HP_REMOVE_CPU) ?
+				cpu : KEXEC_CRASH_HP_INVALID_CPU;
+
 		/* Now invoke arch-specific update handler */
 		arch_crash_handle_hotplug_event(image, hp_action, cpu);
 
-- 
2.31.1

