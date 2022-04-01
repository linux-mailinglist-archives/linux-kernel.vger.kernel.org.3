Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250164EF9EC
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351220AbiDASfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 14:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351062AbiDASf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 14:35:26 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209011B48E7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 11:33:35 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 231Frbce014677;
        Fri, 1 Apr 2022 18:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=s7wgRYCFehxRXCkES8zHePoLMhIqzCVY6yvM82PrGgY=;
 b=TKNUbQ4ZpnC9sUt8B/j2aZvMFkPPz5NxJM8WqNPcVVMBER06ED73/3VEZlUN8HnxQZlO
 W9MpPJjIS4bYzQM6zSLsLxFEUvlXublq29nO5rEACw+Yw4hTLqcf/fMGopHgDbVO9euy
 Ud3oIyxQesgeXfymONYYKV6dxFQK1k2BtG0fm5A6MtMG1rT6v89ZLC5OmdByjdzO2arL
 VB0WQeaWkf1fRi+PJgka3SyNAjQ4Aco5F8sPOnVbhzMBaqd3bpSaa8L3m/Q9jRm2nOPp
 Ryb5ZelezDwXtDU/t9pOOYyepdOQMzd1FHCmmTPpghSrPMSZ3E10ZtV4ePIje68x21ji IQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1s8cycjf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:31:00 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 231IBROb012146;
        Fri, 1 Apr 2022 18:30:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s9690bx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 01 Apr 2022 18:30:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eiw3PzGn4NFaWWeDVaL0VyEzq/cwbXvG/sm56TT8HIYoHK3SIKiloYsCSyXv9/J215JlXLIEYgDkP5a8VeMb4L5qpL7wrT1Y4DF11rJNGmnpbITt05R3Lk+z0kkftfzHAc38JrefkM5V0cExXRkxwQBlp6ULOWHLlDGC73M8zFVOKIX5gmav5GcdivbwjEez5FRXkXHe8Ag7V7LdXQoeTlS+FWu7D2hgqvJeHFAqy7HgZTLZzn/StlDBSJlm+zD05np+0ztzUCGWSlMkwOFlaZkckT0c0U0qXFUo4947EIC8XJs2hSwobb9lxPKikLOPr79vW5jtZvJDlH2ppdGF9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7wgRYCFehxRXCkES8zHePoLMhIqzCVY6yvM82PrGgY=;
 b=Gc0ioyToYnU+FX5Qs9nl8i/U5j4CK86O9kHNquwEy2z8UB0lAQhB7W/0FJhriN7wmoNZ8bwACh1JuqvLZpHpKwK3xdeeOZak8PcMxH2Nn/XteVJnSmAJD9h2/FYaOPp3ZpMweNiLGqX6nZfnoOrO9mT8lhqhVhXAj3KKasMe4ESxkyVP50eHKKxQQ3bOQhvXJK/KA0X2eJ3emv/Jy3gTM1QeDQsBjXentvv+zBH30PKI7uEXy882hbTpLrPQgC9xlsthZlsyYcA4lWbNeVtdWHvV9oSbVMd+EWbbagPvQxtB+EvqDOvC4p0Oq5iWsWmxahWs5WHECGq75NEdEr6TDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7wgRYCFehxRXCkES8zHePoLMhIqzCVY6yvM82PrGgY=;
 b=YJitE6vlTlTAlVc0mw1Fashs9p1v2EWjB/pPYPw824D4zdEI1A9QafIai1uxIZB9iOGuSRdTQoKpHnllxZLoPdclwHGap26wTqfFmdWOf50Bwvh3BB4j+J2mKnFWSJYIrUMQzR7BZ0WPVCZpPekX21KX6lr1cCLLwn0/6xotgK8=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BN0PR10MB5502.namprd10.prod.outlook.com (2603:10b6:408:149::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 18:30:57 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::3188:fe86:1d6f:53ac%9]) with mapi id 15.20.5123.018; Fri, 1 Apr 2022
 18:30:57 +0000
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
Subject: [PATCH v6 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Fri,  1 Apr 2022 14:30:32 -0400
Message-Id: <20220401183040.1624-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0042.namprd07.prod.outlook.com
 (2603:10b6:803:2d::16) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef8c3efd-3c60-447e-f4da-08da140dc30c
X-MS-TrafficTypeDiagnostic: BN0PR10MB5502:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5502975DD207F7BA0A80EF3297E09@BN0PR10MB5502.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gO652yXCzqzhJNipu9sBKu8//bOblXpzCMw4fb0dngnRtuD37djjw9U6wTv8dGa4m9f1n8jTUE8GTckhgchzi0+Q92t+Mw9IGZnt2RVttaW2z7umRWY9Cr+m0Xxonyp7WB0ZxL91u2Fv/x+YaqJ5mTxgViuaNowsZn0XXkA2ZDAZJNHsMqRXIhiHfWdokA5qAnhILPdGO0jNW0Z3tHZ8vZaRyDrHqdbt99V7ObyPA1vnn0m12pCcyzootziYELkuzvkFFEZ80AJ/adH9SECvDsJkzVObs3cgJy+ZbboiaeCy97nEKySSIoIbvPDrkSfULjs+qOodiyFRUiOEyylYSBEoEy3zJxMA2K3Qkp2V5AcZzKQHIxt4mVZivl0wzKWneIxZfQIwurXe9JjbmMPi2+PxNO5aBObohk107jjEhq7+49DN5MNZscE++GVlNu5Qys8YBJndFwL+N/W64HF8eM86DQZ6NgdwtipkLw6O4IZdjbbX014ckHe5BCuLKUzv5etfJ/KAA8O866geUTEAqEWFOvduFYjSGI18Q2+6JtCAhyov0o9ioFi1tiR6A0ir17oG/rCdg3eMMu6p1E2BY4Ib4uO/1nRmgQU/ZTtx+xtcR6yJiZRzNe70bbHcUDe0JBh39S3Dq2Cst+wdgBv2Z25GsV2+OVmOCgotAtNRnrThgcWY5sTwJvyc5FiUfKsppzi1xtuY0r3UzhkOx48mv3JhB/fbgAY+VszT3ZhXyWiBNg/twtghnZUh186m+xqM7otdRfMZq5XEtFn0czmrRQTHvf4k0s0vXq/HgvekFKXF6fArLz78KNYDSUo5BqP4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6666004)(2906002)(6506007)(6512007)(7416002)(107886003)(26005)(2616005)(36756003)(508600001)(52116002)(1076003)(6486002)(966005)(186003)(5660300002)(4326008)(66946007)(86362001)(66476007)(66556008)(8676002)(83380400001)(38350700002)(8936002)(38100700002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i/0xPbeZyh3IrTtOSf1+Acpwf+ne8Wvs3nN6ahIi3LdXctRnOMpiat7+opZ+?=
 =?us-ascii?Q?BlOm+pqLIOt8lg0ny8eKS6cZpPpZdjVBgPVXeOELn5Z8tPXpmQVyfZ2nkdfA?=
 =?us-ascii?Q?ZXnNuA8gw8qDKRwHGsYyYyOUgDvxjwRQrS7cOtpTPDaDo9cSefCp5x7bJXGZ?=
 =?us-ascii?Q?XQ3KKS53BC7oKWal8bkZICcBfpKA9imUCsTgMcRPn1W2gA5EgRyVoebcnWLR?=
 =?us-ascii?Q?+Bu2SY406nO343gQpzUezeW/OSS1KD/mJheCnQUI64NtcdPyFyccjSJHD4n6?=
 =?us-ascii?Q?ySac2ZnNhJukbQtPLi5fnfRn/xo+MMOB7nIyNZ75dq5zVspjrrnw/05k4c1V?=
 =?us-ascii?Q?syPRk8rBJ8e7bCzXB6ucpmERQFz3rkrBa16lMO2Raf2HvIBKKq3VxJugLTC7?=
 =?us-ascii?Q?kz48nHdq5ml5LZxUk+RJo/mrb5RSZbgxXnJUZhdLupXX8Bk46YzKV01hBcZ2?=
 =?us-ascii?Q?LjW6cf/AKX3nQyvCl6EihLuCGpDLLQ/XbQztG1ezzkFXyUJSvQGY/E3XlkJL?=
 =?us-ascii?Q?N7ZhSvapoWT/SXHjEQxWT9Xo4P28RHX41ydfNzhbyy1yPyIFYNwNHKHsmQbc?=
 =?us-ascii?Q?OBIvnitf4WYYUhMJ0Y7Hiqy7MlIf7NHop5vo4e4PfCdfFIAGxs8RRr5u9DR3?=
 =?us-ascii?Q?/fhRtLHVnQ2GAL+KhF519iTs3cd0Ah8j3VszMMG3H2d09bEuHCJi29dDPvsI?=
 =?us-ascii?Q?sDIkxuwsnl3GUNf7/Vr/XbHqSh+bDGuHvT9YXReczXsI/Dr/FH5+BQdQwkMj?=
 =?us-ascii?Q?TuxSWPuFNM2SK0kZssc/S/FiQB4fSWP1Wm+Wbd3J0q5RH2oSbjbfdMDnOU3X?=
 =?us-ascii?Q?SRmqZ/jnSvHlba+B6avUsYYrl/qehhdRJiU2C/GK7D8MMk8peIbsNSrH2VkV?=
 =?us-ascii?Q?6YIKJPhfXVx5rfhQr+AyudjcOVI0fASA1B864PwthiWryWwPCQbu9a8+NKIa?=
 =?us-ascii?Q?GiAQs2rZIdhu9xQe1CUx11zqWDxFveylQAefS3nzuWtw9YcQv8upCiEATici?=
 =?us-ascii?Q?ss+cehDTZ4nh95klAp2djaPFJtXeTGLeP09XXlJ0FXEZ9Odh4g4KBf/oehYO?=
 =?us-ascii?Q?eec/ttiNlLrBNgqyEpcN9IUSFN3sVkkAyz/lnRe9w+jtCrKDnjmwH/TxoDIv?=
 =?us-ascii?Q?yoLX1DI8LtBhfriQGcgx663eIeahzoWeQHqeSShXoln6sZAUM9QIoxLNwwMM?=
 =?us-ascii?Q?elOqOts6IMpwcNt7n4AFLhotNuPa4jbsv8YP0SiVOl/vEynuJVtYjxaO3vga?=
 =?us-ascii?Q?QZzB6zqajpl5lAka+hX5s6GOJbXiI1Dfnd2dz091Q4AO34ccZ9lmB8T7zQor?=
 =?us-ascii?Q?cYmUgT9HbZJPEwtaA95VWSufa2sy0fvGkf3j/yCjL6ELE97fLMU+b42hbmXW?=
 =?us-ascii?Q?8oLpugvJuwJN6qiEZ30dRmS1Cj9da3Xue5sscfwT68ZE0URn6KzPatj624yV?=
 =?us-ascii?Q?+xb7tIuuIzpoaY+mdoXsooAK7v3jHp5OALP3ibUuW1upzbKctmH4bdkSCp2n?=
 =?us-ascii?Q?XDT9kIcKYvu11sRIZCcThDpM94li8+yxzZkk5b8wfM5roL9ic1GMbae9gHxA?=
 =?us-ascii?Q?wG8O70oqcZXzyvxU+oyHhvP7QtQLdOEWEW0uMevzsXj3De/lFoLgo4JpF1e1?=
 =?us-ascii?Q?k3B5QHdQAeWqWrHT26xMePYCOpeLhkXaTVO7eqDAlwcOtcJeUufAqdlN4cPI?=
 =?us-ascii?Q?MwaKsAygY0rBHycIktl+QSStvBbP2LFo97sHJ8nWJINYuhk18gUt5Euoo/TO?=
 =?us-ascii?Q?3wOG9n3y26NF+yxwEGTU+UwMmPi4RZ8=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef8c3efd-3c60-447e-f4da-08da140dc30c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 18:30:56.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZCS92JRC+kX+oA0qOiox0Ve13BYAQT1AAnZ6NlDe4ArPQo/auyO7pCvxnmRUzkBmzFL1yh1V5IYd0jflWzU8FKs+M8XRyWIQyRzDbaaa9zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5502
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-01_05:2022-03-30,2022-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010087
X-Proofpoint-GUID: mnH-GubByPkj2p1cpZuzD_8NBssXd73k
X-Proofpoint-ORIG-GUID: mnH-GubByPkj2p1cpZuzD_8NBssXd73k
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
   to be skipped within this rule file.

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
v6: 1apr202
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


Eric DeVolder (8):
  x86/crash: fix minor typo/bug in debug message
  x86/crash: Introduce new options to support cpu and memory hotplug
  crash: prototype change for crash_prepare_elf64_headers
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  x86/crash: Add x86 crash hotplug support for kexec_file_load
  x86/crash: Add x86 crash hotplug support for kexec_load

 arch/arm64/kernel/machine_kexec_file.c |   6 +-
 arch/powerpc/kexec/file_load_64.c      |   2 +-
 arch/x86/Kconfig                       |  26 +++++
 arch/x86/kernel/crash.c                | 147 ++++++++++++++++++++++++-
 include/linux/kexec.h                  |  21 +++-
 kernel/crash_core.c                    | 118 ++++++++++++++++++++
 kernel/kexec_file.c                    |  15 ++-
 7 files changed, 325 insertions(+), 10 deletions(-)

-- 
2.27.0

