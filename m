Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF0551C871
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384593AbiEESvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384126AbiEESut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:50:49 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EFE1C4
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:47:09 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245GGqE5024988;
        Thu, 5 May 2022 18:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=yy7PKzYVgNa7MjsBjm3JiGxOHlRNaIxXJBNX97ewUMU=;
 b=fOPWu73FmQHqMKAZ3KUJkBk+7kR/u31m9v9hA1gsB8BRmd+lpFUr4vaPFcP9klswshu6
 PymnF0CimHD7AR7hiNgZbZEssay6LYFFptD8HIfr/oUG4/KXQItqIQpDrVo1M/qwZS9u
 SU9/8EyC2K92Dyr5LbgWlWp/fDVh+qwpChlkcwNnZqXLWEWExwXV2umw/rKpCQ43WZOE
 g8dD4nssSE5eAA8gX8vuqkRJ3X2dkLS1czNv5cEAtKLhbuf4c2YW2rk9P/lZIPj/BjMd
 rHUaYi60e7Xm+1cmcZewufupM7ILZjsGiEms1roYRUXoB1mLmZIJpiHcPISiONd+Cyrl bA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fruw2m7wm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 245IjOTR009659;
        Thu, 5 May 2022 18:46:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fs1a7dvyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 May 2022 18:46:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISzmJoweZCrSfozpRCIAvvAxIXG1KNVLbxmnBecZ56gz0wZzLL1dxqftzZ9kDNImNUHHZr3K+gPvc07y3LYoCPtaHOTq4trULNOWTDjuEymxFtRxRC0XNa/q+FFujir+QHW/NDkWpeZStJZUL0gc4FXEJbShZB70l5GRI8KaNJ10sCVyDLRqNNSy4c7fq8LCEeT4hAqeKqeEL3Ox/Oy4HQ16gF4ju+y4/E2Ilu5KQD3pdW5xrUjQ7FZnFPFkoe751qev3wxYueZs+mijJ3z8ERxkAlzkMkE6jJJXogoHU8PZcISUTcTxSZqNYkuimdwE/09X3fQxXWlgOyTGO6WzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy7PKzYVgNa7MjsBjm3JiGxOHlRNaIxXJBNX97ewUMU=;
 b=kUym0H2/tZJ1qNJBSbdjAj38Yd6RP26ugt+98azPEBby7BOGD/bhPfCBtcYPP23SFWN0EcV+LVO8+31pfR2aKxc7hvjnRR1rAvBbcFh8P6/lWw51LQAzqcNCE7g1eDQhlJoeEgEtvY2YXbQM6Uc4sQBfYP1pkvZ6+N44hm7jkHnBCvRkMbDDJ6q7J6Beq50Karc6fUo1iT4vnM+LtnBXhLlL7tyw0EU31nz/Gzh3jTxV8O2v8BRZSMhTMpc2YH7sJLDo+UtH8YNUmA+Ubl6ILrZIz2Vw3MGjDVEv9BMkcB8B8QfQ4B9BqJJVqHZ6PuQgB7SBWhQoKToZHI1MUnJkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy7PKzYVgNa7MjsBjm3JiGxOHlRNaIxXJBNX97ewUMU=;
 b=bn5UdheEYH1OXeL63vjI2yIcOy+qrsK/oU/yW81eQfzqSYTAHc4W6jEdNWmqDcloeyIozTPY5MNP+rBsFIFcC5Bot0nTU4vSqetRwBWiEb/J51bpVuV0cOG0UNShElGnt2rk6O3+we2RWwQ2+A9mZJOF8Nrqf0Z7c/RZ5lIR+Qs=
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com (2603:10b6:a03:2da::19)
 by BN6PR10MB1875.namprd10.prod.outlook.com (2603:10b6:404:105::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 18:46:24 +0000
Received: from SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00]) by SJ0PR10MB4542.namprd10.prod.outlook.com
 ([fe80::2cad:be53:725f:ba00%3]) with mapi id 15.20.5206.027; Thu, 5 May 2022
 18:46:24 +0000
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
Subject: [PATCH v8 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Thu,  5 May 2022 14:45:56 -0400
Message-Id: <20220505184603.1548-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR10CA0014.namprd10.prod.outlook.com
 (2603:10b6:806:a7::19) To SJ0PR10MB4542.namprd10.prod.outlook.com
 (2603:10b6:a03:2da::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 532dea5d-e072-48d1-f380-08da2ec78dc2
X-MS-TrafficTypeDiagnostic: BN6PR10MB1875:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB1875D528F32FE60DFB1FFE7897C29@BN6PR10MB1875.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JWrxFxS1i5cwKYVH14egZawRp7DfDaYLPrFt5A52mxLwD6RUFir/cUkQMr2tFGhVy4WVBlhV9b8XKfvZKTjxW3g+WL1biiaFTOrsuFY5UMIbhr0iIPGdGamZGqkoW5lCOb4DgWsQA/Viu/wUXsbbbQOb+xwHVH4hnQyJVgVHqRYwOJpCfoHMYpLRTz+lNCK+a9IyHr2ziQgXcLpm3jZv3hZr29i4YtTLtMciggqVP21za2O1Ns2GpEv0OLhNBJZ71Kzkr1CcuCl2700lHZ60QqUNbzae9ytg0OIm6rngJkU6OmwqVsasMswioNY1UTPPnlmbC9DfFhjYnOM39gktTSjiGwogxyoxXg87slxRS/THH3Q12VmG1koSgx4oc1q5loQw48MXFs0BLU4kWjwF5299BOKA+fhnlRheW3UvK1IZR7Uptt8PSByCa89iVLh4CUcmAPvIPvOAn3FmbE/FASOLcr7zj92eIGEZ6De0p53Tkoj++hsepCAX34QUXqVtz7gHqHa/tvtqDi6hMUo2pCT/sp8rwwFYaii/QIPyRheywtZuzOdY+cZWa0jcVkGdw4w0UVsUMbCMjpiAGcA61wzqb475AVrd2LxLR173tuBMBMXUWNS/lKSXYfkPrN+/fXD95zXf+7qYoxQoudq1XreezCOqboHUYcxvClLa0/cK1Yl74iIqERe9v+OCjRdhoqvuP2c8uVIJ8m0PD95TATCaYgvJpuue7EVanfJThW5qHuBKU9GtAgNmBeztbjbWtt8Hqc5ahsb7KOW448gHuedbxQ668pPj+xhDVnYLB8WgLymIlYMX30nj5MxObLD5mCHwf20Ag+q0mhjOhM0Nsg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4542.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(52116002)(83380400001)(26005)(66946007)(4326008)(66556008)(66476007)(6506007)(8676002)(5660300002)(6666004)(86362001)(2906002)(38100700002)(316002)(7416002)(36756003)(38350700002)(8936002)(186003)(2616005)(1076003)(508600001)(966005)(6486002)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DMDGUsEwQ4bXIlSubZWTa2gCMl7QbBwgJ+Zotu2BWUmEK9O2xxaw+6JiAOsD?=
 =?us-ascii?Q?I6YLNmpqAvDCis8800IQcHjs7c3wuuPYSnTkFQ/cGqnBYzBccfw96Qyv0MoL?=
 =?us-ascii?Q?HVolgceEuhChOSJOuwEOzmZvFuBttu7B4nQsuL7D8Tlj0kJq60fbnGHGN+qG?=
 =?us-ascii?Q?bjRT8qiWc7oskqYwSLFkN2BYkUi5M0SLCcO4WY5RXaF/0NYxFiA2Mrt8WlC+?=
 =?us-ascii?Q?0N5+uxpQIXTOBKJ9wsZVsEWJ0DBUjkj7KIs1dIFEdYX+SJ1/7Gx8Igl8uBiX?=
 =?us-ascii?Q?0mfAY8iJrs7gOD4em892BNvGVD67xIQq3okvAKDd/qBezl1zNSlsit9A+ga2?=
 =?us-ascii?Q?7uMKVSU3ucUSDkbzwnfj8l57y01fnEZENsi6MrsDDHmv1EApzwCX9g2yc5jG?=
 =?us-ascii?Q?OXNPECmeYxoF+nij5eyjf9lNSDqk46zFHYyEJgdu4CnonC0yc+wYVvyrDy5H?=
 =?us-ascii?Q?0j80etD6QaUYKTRu1AW1gt/jhwxBDZzXKMdZoMebkzsZraWFO6cTfbp0TMuZ?=
 =?us-ascii?Q?lT3L6IF9GrAUnyKnkTWGZR/QeHIKhh48KItyqltLqYN/EJ43wSIFDb5lC5y8?=
 =?us-ascii?Q?h3QxcLRcbsy1W33Fc2IZwRPBzXahvE1MjFHGnYfoZn7Sn1hm47FB6x5bS67Q?=
 =?us-ascii?Q?FEy0DdE7Q4jTY651e71ZNI4G5oMVMhfP91ZpPJimVTU3IGt/IaCrK1FQRhFE?=
 =?us-ascii?Q?qi9dMinPvsN8m9LxUtZRMFUYUT7w3MXBwz/rHCQXGQP2lXcAqGuk80+KmUOp?=
 =?us-ascii?Q?MR7Zt3IXxKyWsbqWaQw/KK0nv2TnVDDMo6dB7odA5wDlbEPqDEleDa8CPdnC?=
 =?us-ascii?Q?sph6e7AkSLy2ShAsGVWSygX/4L4eNo4QG5EU/PAAgfmGFh+/V4qbFSfNaP/A?=
 =?us-ascii?Q?qkn/S3DbFS53Qy16VZqehNYn1uQZjBIojGzcJHK7OK0AB5RNwGATC6DTOZyC?=
 =?us-ascii?Q?oK/RLsAZ5O5l43j315HZJlTzEEli1nkZ4GF9HvAOuEQNY+tvvrwsYWr7xxVG?=
 =?us-ascii?Q?pQa1WC7n0LedPHEsMO0I7twHepLdkVrpRd8X/f9uScprz+DM5VYKTktHigyY?=
 =?us-ascii?Q?7+c2IY/WrAtseX3CauWO6q0SNy2Iw5UnEWRApaJKmTB/FTDTMYakxjM6Td4K?=
 =?us-ascii?Q?3Jla+MRtfvIFrA95qtw52JeWebmatmr6yQDyE6LxOKP44DUrmXuYx/IiqJgV?=
 =?us-ascii?Q?wpyOof6AQxtVefunpiCSHhN3t2/3G/QiX0xlRWUK6KndyMZXFnwRxGTXENL/?=
 =?us-ascii?Q?zPxARYYHVLgj9LOeIyl0Fucx2zaZxnTwMnPnX/UtZOwAhOxxRB65kIW2KpQT?=
 =?us-ascii?Q?EPst7xvIawUbrEfYqYKqCdpM2KLXP9OqtxNSel/ef0VueofSEK7b38XTxcvZ?=
 =?us-ascii?Q?X6Hicop9L0JOWElnPLeZ9PqIvx/37NtMNl8ahSRTIDsgWoFZN1eSaxQWzsb8?=
 =?us-ascii?Q?ENJAWtUo9o35XHiiWwyy4KEXPG2+y3lpxb1wnwhU/J6C0TFIReKCUpM6VMH/?=
 =?us-ascii?Q?a64GfqUcEHwzMIuA86rcyl3RB/3GUMSVefLzXgezW/z5lJJ2Z4A5VqyhV9Xp?=
 =?us-ascii?Q?LVLBicaiIJWs8+M61JcIYECscYRCUoVyNyW62jH2CdngEGD5Wetfz522ohtt?=
 =?us-ascii?Q?CBpDfelyyOd2rwce29BuJQ9puq8hFlCKydmGjhSMGZj2E14ijvvcRHkWFWid?=
 =?us-ascii?Q?nnHOtTi+IBiEg4gPp1UYB1BPTZ+lYV359EYqi9+zOJjWydQYlKcCEngO5Kxo?=
 =?us-ascii?Q?8OCUdbB1wxNGl9XYtv+95A9dQ+pcgCY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 532dea5d-e072-48d1-f380-08da2ec78dc2
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4542.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 18:46:24.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MiGRHdP5gyC6Rgxa5hwXbPpgbSh+DLJ7qwYQLBomSsi42bTUUGmtwhWB93GtDCcWgBYsETiShEDKGCVdx4NimaKFeuQZNGcSP0Yes912Td0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1875
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-05_08:2022-05-05,2022-05-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205050126
X-Proofpoint-GUID: 8nRBuK2b6PULsxLCOPzNKAw8Zj2bsRiT
X-Proofpoint-ORIG-GUID: 8nRBuK2b6PULsxLCOPzNKAw8Zj2bsRiT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr (for x86), which describes the CPUs
and memory in the system, must also be updated, else the resulting
vmcore is inaccurate (eg. missing either CPU context or memory
regions).

The current solution utilizes udev to initiate an unload-then-reload
of the kdump image (e. kernel, initrd, boot_params, puratory and
elfcorehdr) by the userspace kexec utility. In previous posts I have
outlined the significant performance problems related to offloading
this activity to userspace.

This patchset introduces a generic crash hot un/plug handler that
registers with the CPU and memory notifiers. Upon CPU or memory
changes, this generic handler is invoked and performs important
housekeeping, for example obtaining the appropriate lock, and then
invokes an architecture specific handler to do the appropriate
updates.

In the case of x86_64, the arch specific handler generates a new
elfcorehdr, and overwrites the old one in memory. No involvement
with userspace needed.

To realize the benefits/test this patchset, one must make a couple
of minor changes to userspace:

 - Disable the udev rule for updating kdump on hot un/plug changes.
   Add the following as the first two lines to the udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

# For x86_64, the kernel handles updates to crash elfcorehdr
CONST{arch}=="x86-64", GOTO="kdump_reload_end"

   These two lines will cause cpu and memory hot un/plug events
   to be skipped within this rule file, for x86_64.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This patchset supports kexec_load with a modified kexec userspace
utility, and a working changeset to the kexec userspace utility
is provided here (and to use, the above change to standard_kexec_args
would be, for example, to append --hotplug-size=131072 instead of -s).

 diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
 index 9826f6d..06adb7e 100644
 --- a/kexec/arch/i386/crashdump-x86.c
 +++ b/kexec/arch/i386/crashdump-x86.c
 @@ -48,6 +48,7 @@
  #include <x86/x86-linux.h>
  
  extern struct arch_options_t arch_options;
 +extern unsigned long long hotplug_size;
  
  static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
  				  struct crash_elf_info *elf_info)
 @@ -975,6 +976,13 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
  	} else {
  		memsz = bufsz;
  	}
 +
 +    /* If hotplug support enabled, use that size */
 +    if (hotplug_size) {
 +        memsz = hotplug_size;
 +    }
 +
 +    info->elfcorehdr =
  	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
  							max_addr, -1);
  	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
 diff --git a/kexec/kexec.c b/kexec/kexec.c
 index f63b36b..9569d9a 100644
 --- a/kexec/kexec.c
 +++ b/kexec/kexec.c
 @@ -58,6 +58,7 @@
  
  unsigned long long mem_min = 0;
  unsigned long long mem_max = ULONG_MAX;
 +unsigned long long hotplug_size = 0;
  static unsigned long kexec_flags = 0;
  /* Flags for kexec file (fd) based syscall */
  static unsigned long kexec_file_flags = 0;
 @@ -672,6 +673,12 @@ static void update_purgatory(struct kexec_info *info)
  		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
  			continue;
  		}
 +        /* Don't include elfcorehdr in the checksum, if hotplug
 +         * support enabled.
 +         */
 +        if (hotplug_size && (info->segment[i].mem == (void *)info->elfcorehdr)) {
 +			continue;
 +		}
  		sha256_update(&ctx, info->segment[i].buf,
  			      info->segment[i].bufsz);
  		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
 @@ -1504,6 +1511,17 @@ int main(int argc, char *argv[])
  		case OPT_PRINT_CKR_SIZE:
  			print_crashkernel_region_size();
  			return 0;
 +		case OPT_HOTPLUG_SIZE:
 +            /* Reserved the specified size for hotplug growth */
 +			hotplug_size = strtoul(optarg, &endptr, 0);
 +			if (*endptr) {
 +				fprintf(stderr,
 +					"Bad option value in --hotplug-size=%s\n",
 +					optarg);
 +				usage();
 +				return 1;
 +			}
 +			break;
  		default:
  			break;
  		}
 diff --git a/kexec/kexec.h b/kexec/kexec.h
 index 595dd68..b30dda4 100644
 --- a/kexec/kexec.h
 +++ b/kexec/kexec.h
 @@ -169,6 +169,7 @@ struct kexec_info {
  	int command_line_len;
  
  	int skip_checks;
 +    unsigned long elfcorehdr;
   };
  
  struct arch_map_entry {
 @@ -231,7 +232,8 @@ extern int file_types;
  #define OPT_PRINT_CKR_SIZE	262
  #define OPT_LOAD_LIVE_UPDATE	263
  #define OPT_EXEC_LIVE_UPDATE	264
 -#define OPT_MAX			265
 +#define OPT_HOTPLUG_SIZE	265
 +#define OPT_MAX			266
  #define KEXEC_OPTIONS \
  	{ "help",		0, 0, OPT_HELP }, \
  	{ "version",		0, 0, OPT_VERSION }, \
 @@ -258,6 +260,7 @@ extern int file_types;
  	{ "debug",		0, 0, OPT_DEBUG }, \
  	{ "status",		0, 0, OPT_STATUS }, \
  	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
 +	{ "hotplug-size",     2, 0, OPT_HOTPLUG_SIZE }, \
  
  #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
 

Regards,
eric
---
v8: 5may2022
 - Per Borislav Petkov, eliminated CONFIG_CRASH_HOTPLUG in favor
   of CONFIG_HOTPLUG_CPU || CONFIG_MEMORY_HOTPLUG, ie a new define
   is not needed. Also use of IS_ENABLED() rather than #ifdef's.
   Renamed crash_hotplug_handler() to handle_hotplug_event().
   And other corrections.
 - Per Baoquan, minimized the parameters to the arch_crash_
   handle_hotplug_event() to hp_action and cpu.
 - Introduce KEXEC_CRASH_HP_INVALID_CPU definition, per Baoquan.
 - Per Sourabh Jain, renamed and repurposed CRASH_HOTPLUG_ELFCOREHDR_SZ
   to CONFIG_CRASH_MAX_MEMORY_RANGES, mirroring kexec-tools change
   by David Hildebrand. Folded this patch into the x86
   kexec_file_load support patch.

v7: 13apr2022
 https://lkml.org/lkml/2022/4/13/850
 - Resolved parameter usage to crash_hotplug_handler(), per Baoquan.

v6: 1apr2022
 https://lkml.org/lkml/2022/4/1/1203
 - Reword commit messages and some comment cleanup per Baoquan.
 - Changed elf_index to elfcorehdr_index for clarity.
 - Minor code changes per Baoquan.

v5: 3mar2022
 https://lkml.org/lkml/2022/3/3/674
 - Reworded description of CRASH_HOTPLUG_ELFCOREHDR_SZ, per
   David Hildenbrand.
 - Refactored slightly a few patches per Baoquan recommendation.

v4: 9feb2022
 https://lkml.org/lkml/2022/2/9/1406
 - Refactored patches per Baoquan suggestsions.
 - A few corrections, per Baoquan.

v3: 10jan2022
 https://lkml.org/lkml/2022/1/10/1212
 - Rebasing per Baoquan He request.
 - Changed memory notifier per David Hildenbrand.
 - Providing example kexec userspace change in cover letter.

RFC v2: 7dec2021
 https://lkml.org/lkml/2021/12/7/1088
 - Acting upon Baoquan He suggestion of removing elfcorehdr from
   the purgatory list of segments, removed purgatory code from
   patchset, and it is signficiantly simpler now.

RFC v1: 18nov2021
 https://lkml.org/lkml/2021/11/18/845
 - working patchset demonstrating kernel handling of hotplug
   updates to x86 elfcorehdr for kexec_file_load

RFC: 14dec2020
 https://lkml.org/lkml/2020/12/14/532
 - proposed concept of allowing kernel to handle hotplug update
   of elfcorehdr
---


Eric DeVolder (7):
  x86/crash: fix minor typo/bug in debug message
  crash: prototype change for crash_prepare_elf64_headers
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  x86/crash: Add x86 crash hotplug support for kexec_file_load
  x86/crash: Add x86 crash hotplug support for kexec_load

 arch/arm64/kernel/machine_kexec_file.c |   6 +-
 arch/powerpc/kexec/file_load_64.c      |   2 +-
 arch/x86/Kconfig                       |  11 ++
 arch/x86/kernel/crash.c                | 146 ++++++++++++++++++++++++-
 include/linux/crash_core.h             |  10 ++
 include/linux/kexec.h                  |  10 +-
 kernel/crash_core.c                    | 102 +++++++++++++++++
 kernel/kexec_file.c                    |  15 ++-
 8 files changed, 292 insertions(+), 10 deletions(-)

-- 
2.27.0

