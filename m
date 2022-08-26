Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35305A2DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 19:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344838AbiHZRiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 13:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344796AbiHZRiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 13:38:01 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4190E0FEA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 10:37:57 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGkWLA026688;
        Fri, 26 Aug 2022 17:37:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=jh4VPJQd/hIn7vA9KMJ1wQ0IGz3JFbML2PGnLthVuPc=;
 b=s48y6sstPBFIgcmNGGmF2vMcEP+kT0kt7shNUX/DXwDzUqjxqPjPAuPDGI/o1hf4gOtt
 HyKXGW0d2b4QMwQraV26HqtPF2L2xe7zcfkzI1ipjNkZyKy8ILEtAO19l6p6UtI5JclP
 40nm+q222ucUNlezhx6KwOyu/ijA1+7SoBqC+6ni/bRmKOGiRLybbjLrrIgpFKATqC0j
 IiwPb/xi5W2B7rWbO3PDhsgg5xK+LWaYn9ISfLWe1irnC5HjN1z6Sn1TjihO49ByMkwK
 mTSW3tH+UerT5oY0z+aomchBlFbZE1YCaqXyNcHQ6s1KXBXrZ9K7cm8P8ijb3MDEe61g qg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j5aww7p2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:12 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGoHib004772;
        Fri, 26 Aug 2022 17:37:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n7ddkf8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 17:37:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnGGSKD0PhbIN0s1jorh6B1i/u8G47g6q/tIQsWJKrKihBh2B5bARxmHssFuVBzU+3qHn6x2jA58e3NJ+hQA0rYa6Zl/b/u2QRvbANa2tU7qsdEeYNi2BPGyQ/EZ+MfeD8e4ZFnjKzn5ps3oxTbKIUHy/M2gKPnQPEK1A0KA7H8Vl3GoSEijfJPgqa5eE3ICoZoPGT+3GKbK+kPMmntXwzgFhISsAAJNAfQ3daoIYa/FQgoxk8/4R1bXTAt0dE7GjEKO2Fig8ViAOWQaBLo3INgXFy2Zi7ZuKkTBBQkOb7eawQtiScKADOU/72LB4XxaMMDOMCvxhKuyXOHgTRIggA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jh4VPJQd/hIn7vA9KMJ1wQ0IGz3JFbML2PGnLthVuPc=;
 b=aAQl+FpxaTxxDHPL7pvj3f1k5KJrXg+FkCLyFKzyspQd+1dM6N8L4xdJnzhVvSqQtLqvyAYlJ+e5dwknnwkdW8+2Rt/BCttRZjjBqsTB4Mpdv0epQDKOWtvmQc0wxEzgtTrlC/LGXY0pyRmjBkCGjXixD5JTQ/XPkJ5WBY2XKvk80UJTEGte0EgGsnVeoW0zm07igIR7JmbRm11FwVrrWiUMS7nb5WMGTJmdE3oOqGig7b1Y7RmNM8rNKHH4XeH0D3dVfhtI4wbm0YWSdaVgSGWOTLyoYwz1SBaHtfT2Mh1GxWW/vU0W8MRxBK1PrM7lQm0aDmzJEoKJ4RnCSX5GSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jh4VPJQd/hIn7vA9KMJ1wQ0IGz3JFbML2PGnLthVuPc=;
 b=mpaCrtOCU5qKh/SowLpvau7HFye8SlFN5fsKlVyTpIput3s6WYqQrXnm1QVHXQ/rM7UwJlPvh5nTYrjC8YdSDFXSfD/sjaLzcoQodXmY7FfCQWUg3MASFD7PmmIGMS0ypGOd94NWJo2pZ/v8wXDDP1RGSH9GEZw5UfSRbQodjaw=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by BYAPR10MB2549.namprd10.prod.outlook.com (2603:10b6:a02:b8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.21; Fri, 26 Aug
 2022 17:37:09 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::4d5c:c5e9:7d20:43c2%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 17:37:08 +0000
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
Subject: [PATCH v11 0/7] crash: Kernel handling of CPU and memory hot un/plug
Date:   Fri, 26 Aug 2022 13:36:57 -0400
Message-Id: <20220826173704.1895-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0152.namprd03.prod.outlook.com
 (2603:10b6:a03:338::7) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a56c46a9-ef59-409c-ccf6-08da878999c1
X-MS-TrafficTypeDiagnostic: BYAPR10MB2549:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VjdRkrcKFaoGjjElXMKob4Ou9kmZVJh/18R6hmxxhbttoxrdZXO1U4CXYklU2Aa5mxdxNCVxSHIjUhpSIpYe4FKPqdIbRv3Fk8g0F+t0TAuK5QVUOWhwR8dRwrOPmaNO0wkWcQUFPBicjXJ1DHaM3iAFZTZ835oLoj7LLwfIIYMqZWPnqECeyRKHWEmpzYlwe93D68+58dTBGAPpeWFipEXhKGC7LRp/h/5uORmKEH1ljCT7TdjX/kSwDN4XvyEKbIKgVN2Pc4O6YocWPr04rRcPGuUd3j84Cf6jn92zGai/1Sm9rQ4bwFcTwEh/fCJJN7z5G88hu6h9IujygfSz3+8s+KmtoY/PrI75AOR43oWP47k5xHTbCcEdhVHDUYxZMquc15mMovfpNfCOORwd+N3ooUBFUunY0jszIkEZFscNC58skm4Sr5Hlw30Nx2LW4sV3+FMcKeSOVepAGVVBJLQiVdnXJUSejr7RgJ0pRxIGdAK9id6PyLJRCxRTZtMqrrtdf4MFs2c6X/J520Ilf+lZn9W29DfliMfLCeTtY9xrDMipRET6L7EG/utPRIOXa6MClmOYrShI0+fSYUqbdh4HaxdGmJlszrBTDFBERsG4HGqQpuNrm1HxpOTb8rJgPJnypxai7AB1k2fghBNiSoLNKb4vJ6s9D+VguBBwso8B2R2J+gPZ/VJH6sOpHfqlsJTZhKSbUXeWnbN72csF2Cx9x2D9oAmoDJ7PZFafrgw1TrIuv/DahpVlImQYkHNVmdZ8JHvvEHUN+/uS6EydcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(136003)(396003)(39860400002)(346002)(186003)(26005)(66556008)(66946007)(36756003)(1076003)(66476007)(7416002)(83380400001)(4326008)(316002)(8676002)(8936002)(30864003)(478600001)(6486002)(2906002)(966005)(6506007)(6512007)(41300700001)(5660300002)(38100700002)(6666004)(2616005)(107886003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1d5JApsoPwFw+/hjUSktmIohwD5MzQL+EH3MuWsRnW/bQ23io3+S7lbC4GmR?=
 =?us-ascii?Q?o854S87+O9xTWUrzr6sMbwdwp2XOi0n+yQqTVrmnXmUEZdEVrB8ND8oSLLyg?=
 =?us-ascii?Q?VAIbZaBEZUBe1sTNKKQH+JCzQjqRu94w8gE83b00t/so8QHE+K6iE8Qgyz6J?=
 =?us-ascii?Q?wkpwvWs2lGp1j1oLscgBmjwQNHbMyD1FwWI0BsYGVC54Twi0XrS3tRk4aniH?=
 =?us-ascii?Q?4GSllmPyCSDXYPVgEAxzjDbz7rG+gkW3VfZ9+0iSgZOnUEScxYNIHaQoBK6A?=
 =?us-ascii?Q?59GgeN4EbAbpiZn/v8yH1yIFqZTgocIBp2Gz632MBP2I4fb4lf2bA0S54a+9?=
 =?us-ascii?Q?+pSlt+RfUZ+LI4e9YUvQSuixar3W1IzCZM8R/I/0u7LatCFzTygxqm/yBg8m?=
 =?us-ascii?Q?ptDEls7ke3dhWyI1x02Tx2z8dsaqP2T44kcQdrhcX8Hzqe5BIQ+UBDc5VkFZ?=
 =?us-ascii?Q?by/CK2DrqXMu0OQWFsAukvdjbjHVyWe0MokCEHfz8tdCpU6FKX3h4VN9U2Sa?=
 =?us-ascii?Q?8fCnZxZ4E4FHJpX6mmPZ97eHoQiSKw2d/zkxlclqFXqRnD/FuREKuboVECDB?=
 =?us-ascii?Q?AFsmURVWs1TQCuNHSecc4uCCoGyTnMynIcZK29vb8NJabSwbK6qSCTGxb8IU?=
 =?us-ascii?Q?oang503AAaN5Pbg5gIp2rpQFn87QCPL5f27MIq7V9AzWZ2sw/1EqYS0XhSQ9?=
 =?us-ascii?Q?aUsOW7zebfzWX3W1ithzuL6NdSC3zdnJd42+VxL2qOK9tQ5QJfhMCd9LTOlo?=
 =?us-ascii?Q?pWtfi0IqvgG59J4h21JF7ffWCryC+0hHD8EFzbJ58L6MloBgx6kfazU7p+iF?=
 =?us-ascii?Q?LNWUy1h9JdmihUwimEVFt5bLZcG0SxNCuKm0cVabTveYgEvnIcz0ljZ15+Zs?=
 =?us-ascii?Q?apjvTWO8ydqPYbZBTscvPULeBjU+3n94TwD9YhU8/14rwvBOyK2JwDhj7EHu?=
 =?us-ascii?Q?56g2GooduhoXVHFAusazBA5F90xqfZIm0PJWVsN1+CPmrP67v800Yds4L/o7?=
 =?us-ascii?Q?vjsyvAPId9o7Vm/ZjubT+7ZvtgiQ5AyQxEC4EJ58UCHkQqVod+Y+TInY0iSp?=
 =?us-ascii?Q?qiTgoI56NvjHQ/XUIA9dfsRoYNKG9+Ip56cKyHfVOaFy72cMLII3n63kAYgv?=
 =?us-ascii?Q?fCkByQVq0SgiYzL8ZKH8u48NbsK/WURhPkndDEefvMGHvGNF4IwiiE0CN9to?=
 =?us-ascii?Q?qaCbuvAXbcfekP/uODEoMa8DkdecN2sF0v2zjJiYFwTJrKDdN/Z/R+h4ErlM?=
 =?us-ascii?Q?gMa89kuJ3sNnX82spX5NSI9e8yNb8+LbJBx9azSjEVT0TV+BD+s41RNhvkje?=
 =?us-ascii?Q?s8plYGLMJ2iGev9StA28pGS0OQtICk1a64pChvkxuIhIedQQmI+fL1YoRWDJ?=
 =?us-ascii?Q?GXKebMuffrjMeorRYxmo0cxhroGLstrx4V5x4C7R7t5rHNtj1jesgTekobQi?=
 =?us-ascii?Q?yCeIX2zg+bBh6SX1PTu6ujMMAoMK/vl9L7zBwJyqNRlJrQOFn/EcO5NTDtS/?=
 =?us-ascii?Q?1cvopH0dYNf88zq34lS/du9wJRF/C/5THF3NzA7HTQJAGt0skhA8Av/x9CkB?=
 =?us-ascii?Q?t8vTNI6zbvN6Vm4eVWO9h30qa+ATabmZx1gAYO6O0jPW32WRFITUw0NHO/xV?=
 =?us-ascii?Q?8g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56c46a9-ef59-409c-ccf6-08da878999c1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 17:37:08.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xu5/zDRfkhEUixxe75LH7wuJHPwhciAJ9ySemfsO1pww9npaQyGdRvqHgRTLI0maRtFF1yKsAZW6to8axZHCfOqgxJN3igIdvB3740gOYco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2549
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260070
X-Proofpoint-GUID: Xo6u28gQMykk2lN9bPiRynTY-iRQJWgg
X-Proofpoint-ORIG-GUID: Xo6u28gQMykk2lN9bPiRynTY-iRQJWgg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the kdump service is loaded, if a CPU or memory is hot
un/plugged, the crash elfcorehdr, which describes the CPUs
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

 - Prevent udev from updating kdump crash kernel on hot un/plug changes.
   Add the following as the first lines to the udev rule file
   /usr/lib/udev/rules.d/98-kexec.rules:

   # The kernel handles updates to crash elfcorehdr for cpu and memory changes
   SUBSYSTEM=="cpu", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"
   SUBSYSTEM=="memory", ATTRS{crash_hotplug}=="1", GOTO="kdump_reload_end"

   These lines will cause cpu and memory hot un/plug events to be
   skipped within this rule file, if the kernel has these changes
   enabled.

 - Change to the kexec_file_load for loading the kdump kernel:
   Eg. on RHEL: in /usr/bin/kdumpctl, change to:
    standard_kexec_args="-p -d -s"
   which adds the -s to select kexec_file_load syscall.

This patchset supports kexec_load with a modified kexec userspace
utility, and a working changeset to the kexec userspace utility
is provided here (and to use, the above change to standard_kexec_args
would be, for example, to append --hotplug instead of -s).

  diff --git a/kexec/arch/i386/crashdump-x86.c b/kexec/arch/i386/crashdump-x86.c
  index 9826f6d..4ed395a 100644
  --- a/kexec/arch/i386/crashdump-x86.c
  +++ b/kexec/arch/i386/crashdump-x86.c
  @@ -48,6 +48,7 @@
   #include <x86/x86-linux.h>
   
   extern struct arch_options_t arch_options;
  +extern int do_hotplug;
   
   static int get_kernel_page_offset(struct kexec_info *UNUSED(info),
   				  struct crash_elf_info *elf_info)
  @@ -975,6 +976,14 @@ int load_crashdump_segments(struct kexec_info *info, char* mod_cmdline,
   	} else {
   		memsz = bufsz;
   	}
  +
  +	/* If hotplug support enabled, use larger size to accomodate changes */
  +	if (do_hotplug) {
  +		long int nr_cpus = get_nr_cpus();
  +		memsz = (nr_cpus + CRASH_MAX_MEMORY_RANGES) * sizeof(Elf64_Phdr);
  +	}
  +
  +    info->elfcorehdr =
   	elfcorehdr = add_buffer(info, tmp, bufsz, memsz, align, min_base,
   							max_addr, -1);
   	dbgprintf("Created elf header segment at 0x%lx\n", elfcorehdr);
  diff --git a/kexec/crashdump-elf.c b/kexec/crashdump-elf.c
  index b8bb686..5e29f7a 100644
  --- a/kexec/crashdump-elf.c
  +++ b/kexec/crashdump-elf.c
  @@ -43,11 +43,7 @@ int FUNC(struct kexec_info *info,
   	int (*get_note_info)(int cpu, uint64_t *addr, uint64_t *len);
   	long int count_cpu;
   
  -	if (xen_present())
  -		nr_cpus = xen_get_nr_phys_cpus();
  -	else
  -		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
  -
  +	nr_cpus = get_nr_cpus();
   	if (nr_cpus < 0) {
   		return -1;
   	}
  diff --git a/kexec/crashdump.h b/kexec/crashdump.h
  index 18bd691..28d3278 100644
  --- a/kexec/crashdump.h
  +++ b/kexec/crashdump.h
  @@ -57,7 +57,6 @@ unsigned long phys_to_virt(struct crash_elf_info *elf_info,
   			   unsigned long long paddr);
   
   unsigned long xen_architecture(struct crash_elf_info *elf_info);
  -int xen_get_nr_phys_cpus(void);
   int xen_get_note(int cpu, uint64_t *addr, uint64_t *len);
   int xen_get_crashkernel_region(uint64_t *start, uint64_t *end);
   
  diff --git a/kexec/kexec-xen.h b/kexec/kexec-xen.h
  index 70fb576..f54a2dd 100644
  --- a/kexec/kexec-xen.h
  +++ b/kexec/kexec-xen.h
  @@ -83,5 +83,6 @@ extern int __xc_interface_close(xc_interface *xch);
   #endif
   
   int xen_get_kexec_range(int range, uint64_t *start, uint64_t *end);
  +int xen_get_nr_phys_cpus(void);
   
   #endif /* KEXEC_XEN_H */
  diff --git a/kexec/kexec.c b/kexec/kexec.c
  index 829a6ea..3668b73 100644
  --- a/kexec/kexec.c
  +++ b/kexec/kexec.c
  @@ -58,6 +58,7 @@
   
   unsigned long long mem_min = 0;
   unsigned long long mem_max = ULONG_MAX;
  +int do_hotplug = 0;
   static unsigned long kexec_flags = 0;
   /* Flags for kexec file (fd) based syscall */
   static unsigned long kexec_file_flags = 0;
  @@ -489,6 +490,17 @@ static int add_backup_segments(struct kexec_info *info,
   	return 0;
   }
   
  +long int get_nr_cpus(void)
  +{
  +    long int nr_cpus;
  +
  +	if (xen_present())
  +		nr_cpus = xen_get_nr_phys_cpus();
  +	else
  +		nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
  +    return nr_cpus;
  +}
  +
   static char *slurp_fd(int fd, const char *filename, off_t size, off_t *nread)
   {
   	char *buf;
  @@ -672,6 +684,14 @@ static void update_purgatory(struct kexec_info *info)
   		if (info->segment[i].mem == (void *)info->rhdr.rel_addr) {
   			continue;
   		}
  +
  +		/* Don't include elfcorehdr in the checksum, if hotplug
  +		 * support enabled.
  +		 */
  +		if (do_hotplug && (info->segment[i].mem == (void *)info->elfcorehdr)) {
  +			continue;
  +		}
  +
   		sha256_update(&ctx, info->segment[i].buf,
   			      info->segment[i].bufsz);
   		nullsz = info->segment[i].memsz - info->segment[i].bufsz;
  @@ -1565,6 +1585,9 @@ int main(int argc, char *argv[])
   		case OPT_PRINT_CKR_SIZE:
   			print_crashkernel_region_size();
   			return 0;
  +		case OPT_HOTPLUG:
  +			do_hotplug = 1;
  +			break;
   		default:
   			break;
   		}
  diff --git a/kexec/kexec.h b/kexec/kexec.h
  index 0f97a97..b0428cc 100644
  --- a/kexec/kexec.h
  +++ b/kexec/kexec.h
  @@ -169,6 +169,7 @@ struct kexec_info {
   	int command_line_len;
   
   	int skip_checks;
  +	unsigned long elfcorehdr;
   };
   
   struct arch_map_entry {
  @@ -231,7 +232,8 @@ extern int file_types;
   #define OPT_PRINT_CKR_SIZE	262
   #define OPT_LOAD_LIVE_UPDATE	263
   #define OPT_EXEC_LIVE_UPDATE	264
  -#define OPT_MAX			265
  +#define OPT_HOTPLUG		265
  +#define OPT_MAX		266
   #define KEXEC_OPTIONS \
   	{ "help",		0, 0, OPT_HELP }, \
   	{ "version",		0, 0, OPT_VERSION }, \
  @@ -258,6 +260,7 @@ extern int file_types;
   	{ "debug",		0, 0, OPT_DEBUG }, \
   	{ "status",		0, 0, OPT_STATUS }, \
   	{ "print-ckr-size",     0, 0, OPT_PRINT_CKR_SIZE }, \
  +	{ "hotplug",		0, 0, OPT_HOTPLUG }, \
   
   #define KEXEC_OPT_STR "h?vdfixyluet:pscaS"
   
  @@ -290,6 +293,8 @@ extern unsigned long add_buffer_phys_virt(struct kexec_info *info,
   	int buf_end, int phys);
   extern void arch_reuse_initrd(void);
   
  +extern long int get_nr_cpus(void);
  +
   extern int ifdown(void);
   
   extern char purgatory[];

Regards,
eric
---
v11: 26aug2022
 - Rebased onto 6.0-rc2
 - Redid the rework of __weak to use asm/kexec.h, per Baoquan
 - Reworked some comments and minor items, per Baoquan

v10: 21jul2022
 https://lkml.org/lkml/2022/7/21/1007
 - Rebased to 5.19.0-rc7
 - Per Sourabh, corrected build issue with arch_un/map_crash_pages()
   for architectures not supporting this feature.
 - Per David Hildebrand, removed the WARN_ONCE() altogether.
 - Per David Hansen, converted to use of kmap_local_page().
 - Per Baoquan He, replaced use of __weak with the kexec technique.

v9: 13jun2022
 https://lkml.org/lkml/2022/6/13/3382
 - Rebased to 5.18.0
 - Per Sourabh, moved crash_prepare_elf64_headers() into common
   crash_core.c to avoid compile issues with kexec_load only path.
 - Per David Hildebrand, replaced mutex_trylock() with mutex_lock().
 - Changed the __weak arch_crash_handle_hotplug_event() to utilize
   WARN_ONCE() instead of WARN(). Fix some formatting issues.
 - Per Sourabh, introduced sysfs attribute crash_hotplug for memory
   and CPUs; for use by userspace (udev) to determine if the kernel
   performs crash hot un/plug support.
 - Per Sourabh, moved the code detecting the elfcorehdr segment from
   arch/x86 into crash_core:handle_hotplug_event() so both kexec_load
   and kexec_file_load can benefit.
 - Updated userspace kexec-tools kexec utility to reflect change to
   using CRASH_MAX_MEMORY_RANGES and get_nr_cpus().
 - Updated the new proposed udev rules to reflect using the sysfs
   attributes crash_hotplug.

v8: 5may2022
 https://lkml.org/lkml/2022/5/5/1133
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
  crash: move crash_prepare_elf64_headers
  crash: prototype change for crash_prepare_elf64_headers
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: Add x86 crash hotplug support

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 ++
 arch/arm64/kernel/machine_kexec_file.c        |   6 +-
 arch/powerpc/kexec/file_load_64.c             |   2 +-
 arch/riscv/kernel/elf_kexec.c                 |   7 +-
 arch/x86/Kconfig                              |  11 +
 arch/x86/include/asm/kexec.h                  |  20 ++
 arch/x86/kernel/crash.c                       | 104 +++++++-
 drivers/base/cpu.c                            |  14 +
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |   8 +
 include/linux/kexec.h                         |  41 ++-
 kernel/crash_core.c                           | 249 ++++++++++++++++++
 kernel/kexec_file.c                           | 105 +-------
 14 files changed, 497 insertions(+), 109 deletions(-)

-- 
2.31.1

