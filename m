Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F52C57D32B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbiGUSS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUSSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:18:51 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B338C744
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:18:49 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26LIEnos025443;
        Thu, 21 Jul 2022 18:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=hrRMFI6FZ5Xfu68TDnZsnWtGysGnZbIKHXKtkBhBTko=;
 b=WBBmdZ0IyEuAmQk3fBvfe2qCi0W+FBJruIQnEve1LBAnpaAw2RmefWP2UBuGH60izsc/
 kchHwrxN1UuHCVNT1DiysaSIVGzTzleXcukSWwC1H5LElxiOlzjy1K38uFgvtuPG+I0i
 jMeEbm0+/8sNoBF7aJhIiVd9USX15/mnnTiYBaK58g/Y2TKnZJEX/tr/3ZMt7Cde9RhI
 1ob3FbNoS3PxVt1gx+TZUVXtC7RQr6zonIMLgBiePUUAv672AumD7wmCSKp3C9BOBilf
 1YBFjRFzoLbiVq3NIh3a9qepgOXYu3lOB/FTjhF3Y+HJSZjWURxH9pej8uvr5u/VsVsK 5Q== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3hbnvtndyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:14 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 26LH23f6039182;
        Thu, 21 Jul 2022 18:18:13 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3hc1k70xdh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Jul 2022 18:18:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlznJbGD8zq/nmSXcfQt4ze4sXry5n6Y/stnghaufWZ9QN+dXCrZzTjenlNboh6oWDvVDnX1mnJ0qkJm2RrAgKdZC0r+APqGwUDqJGRAHuSzfbSl6FJE7+OMlsdjpEvrihekKvyfwO/dK9wRcr47IsgvQp5NsoyMwE5yPFre6vlkyvNA4adVbgbvtrhbdZueBVaz3XkahHtjoblNYeFRV7HEcbU/EW4NUT0IDlsWQzd3epcDVWkhztGBFFafs1b5LQ2m2gfbAl5q85FCSKxSlxpk3relK0WLu+FqIsjscw1wHEhn+nTeEoiCybas0krpqKcJPMw7IyjubLqJE7J6ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrRMFI6FZ5Xfu68TDnZsnWtGysGnZbIKHXKtkBhBTko=;
 b=XKbyQ2vtfsHI6mLyLdct68wBrrKhxW2drv5KuaFYcZMemETrFSFBccwEIrhcgpN7lrbOHf5VwmazVnMSk9LXD0ff9I/pUzf1+sJP7OnTbhYqaJSN6GRmdzB7iHxa6tvse/Hy46DI5gBZ+gzKWyDVG+HTcm1Tx0YA/uyiZrGzYUsiO75k+Qw9vO+ISh7/E0VirZcacgHHkkp5QmhKvvQeobPyKQpFj5M3kbZ9S4tK9bxuLww8Lf+/NFHNH/SRT4Ack6tifv7Z7h5aDlp4MtIedNFjvfqQ5l7alWeo1I9Cgz9crrYzSuSrhks6myV8UnWNCGvQlB+ZPhzS2wfPrwWxow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrRMFI6FZ5Xfu68TDnZsnWtGysGnZbIKHXKtkBhBTko=;
 b=fiUKnGww8qFWMP8TIMunVKCEn1KoicXVE+88jdfAZVV8FDvaiHWm3ckgmpnKAPLO8XRjzEePJtiJXSe3Ete0WeknkmOy1nEPH/fYXAWZj94Jff4fbE5Ly+qYG5ZKql6wQP4hlmcF6XOITwwLjV+nuLnuT2Qd16S7Un8QbyB16yA=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by CH0PR10MB4890.namprd10.prod.outlook.com (2603:10b6:610:c9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15; Thu, 21 Jul
 2022 18:18:09 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::747b:31f7:db5e:9e0d%3]) with mapi id 15.20.5458.019; Thu, 21 Jul 2022
 18:18:08 +0000
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
Subject: [PATCH v10 0/8] crash: Kernel handling of CPU and memory hot un/plug
Date:   Thu, 21 Jul 2022 14:17:39 -0400
Message-Id: <20220721181747.1640-1-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR03CA0189.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::14) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a798911-7d32-41e8-661d-08da6b455d1e
X-MS-TrafficTypeDiagnostic: CH0PR10MB4890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /c1FNDHrss5O2uaEu+5WmUmNdH2PCVdMU7xHO8Gn3RnqpmZBa6a0EmtmiqEHRmllWyae0dnk4eC25mN1vgvqPy0E5DKhfjZvJ/y1URSFg7OFg83dbh5iwoI4vNcvKEE6cd5YLl6giTydi2gzrTVQZmEQp7kaIYmTD1IjmF73Sr3lLJdA6B+WKMx+S+YHFQQM1xVyRt6WDggNz+NQjx2nUW4Wa9fGky588ZDJIJvlylAPzKHCvzN275I6trECDzvOJDnHerSlEGVbmpXHtwiK0/QCxdnIZWhKq7dV2bcE0e88bahnQMBtjsQ/JmA2+n1C+OSnKBeglp566/iPokWBB2lPqAPbJc3RNBQI2uzR09on6zTBqAltNc4lwrWXFchwMxmwy4k/Qx/ObmJClzg6xWuSQG/T/JXrtavXwy3szSVo9MPcbHfnXThc1NtV/S2sk2oDmODsEpHp5fwnsxipNLQQ5m8hGoJDme03ZrgBvHkRo2FIKlsh8Nsq3d38RSrGjA/WsjqNsy6A0vxrwUTASTmHNrlc8J4jJQHScin6CKg2m7Yn8y5BFL3EXD5UMQrTuWz2kYyTQf1okp1IbX3q8tmoIGFzo/+YV0Pm1cLsH2oDEjtw4MsMH9+m+Vbwl/heOQXv2Hd0kNyvJNH29tfUEpHmgXcAY6cp2Hau9wBTlVHA9QaFq/aSQXirWQ0Ef7wOJ4Jfr196vLxD7XQYaym2bebejgoxAnYHtg7C8iCo0iEG6js/5vQahADjTuBrO9Mmsws85ZfscjiTpczItBW1tEWTnZQN2Yo8sYio2JuQ4pVq/KHQLQ1xUa0o5kgyQBzXShvjgP3ZxHwvcu6Et7JGvZl+y2VschrgPFB8SpQF0ZOpvkZPp8XD3Qgt3VB4N7ZP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(396003)(376002)(39860400002)(346002)(38350700002)(6512007)(316002)(8676002)(38100700002)(66556008)(66476007)(66946007)(4326008)(6486002)(41300700001)(1076003)(2906002)(30864003)(52116002)(86362001)(478600001)(6666004)(83380400001)(7416002)(107886003)(186003)(8936002)(26005)(6506007)(966005)(5660300002)(2616005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E6Q0HwIFyTpDTNk0iOyNGV331B8e1mdA5D3DLR4FP5yJlRNr3Sm7COtMFAXz?=
 =?us-ascii?Q?iUUsLagSn1Y3PJKIMQh6ekxgwNr0FeD7QT28Lov2nn4g2Xxf0zAZzOWp8hlH?=
 =?us-ascii?Q?tYn+BACDv/yar3Epq8Fta71+cHIjwZvNnx5jcICobPvqINpWYKsEO8moy/Jp?=
 =?us-ascii?Q?i/nzk1AoCsWjAVZWZaalg7zie5k7h9bN6kA9ZJhdCiL8eKbrrO6L9XbQVM/x?=
 =?us-ascii?Q?5u8cYgiPo3Wn/FuzUhtz2GEVUxnvDxHzKwiAxC1M8tUJpPmFdOvikP357NL7?=
 =?us-ascii?Q?mI+j1Eujd6fWDYsnw801w6F2E97yLcGUIQB39Y6Nd7LyeOM+7hJb5tyvnfrq?=
 =?us-ascii?Q?OJwFFOplqrSvPKZtxwfP1MAL5C00A3r+wqqLp2jQ/8JkfKIKxjNw/iQM+Fk0?=
 =?us-ascii?Q?F3lotc7RwCD9zZQVDYzfavKvQTZCoXaUK9qV/HZP334PAyT/mN2T36h8329G?=
 =?us-ascii?Q?2Vd8lXGI7XHOPDlAXi77G+/pgw6NB9666Pz6SlcQsZlG7SkcwqZvYzuW+zSu?=
 =?us-ascii?Q?oobMBryjn9CzO3faXFr0QWLyONpnXQOJieMs34MdLnMMhKsf897d/GEhLlAO?=
 =?us-ascii?Q?NksQCM1urIVuw6607qqlDEzrFwFJAIG0XQF+WQga5b78WhXIZesFtEYOF4jX?=
 =?us-ascii?Q?hEweQO1DZqUpnAZjoOBstwraxi5d49GSZkwnT0kimwzNEo7DW2SeG14qK5YU?=
 =?us-ascii?Q?vxBHK4/US/cQmq+Wxcc1B7HNjnjco3fa7WrpUPhsd5LvukX1BjFCSM+8Tl/h?=
 =?us-ascii?Q?Agd7tZJp1yDpycIWfCSZGx08NkWk5+g2XsHrlSM/ANWs5cSS+lKnf62HVKTu?=
 =?us-ascii?Q?fu+FelMGf17+b2CXFlxu96rMAUYlxSlj3eCYfv51sSOxRxi+v/ZIxnSocvbx?=
 =?us-ascii?Q?Ryj2bqqzPsspH/94jjbJchZq6lEocImOiqfsVOiJLw2jfINUnsAZNkj0t30N?=
 =?us-ascii?Q?hHTuWoScAxBDtMaBIOdTxEIGCd/t9gu2z3XGxgJoJ8Xk0315lNcAe6Q9gUbA?=
 =?us-ascii?Q?uvI9FTzOJ+QeeQKIslD2M1IWBByo9eYs6n4mU2DsEJKbtj3gkRLvLXLjArwY?=
 =?us-ascii?Q?WS6NAuBZF3LZ8xgoLbr/bR+un8yCS5DMmU0TqKxsmZ7tAgo/JuAOPEFGIT6c?=
 =?us-ascii?Q?gwsF1scUTImKWLqVVzRfU1BTrVnI6RmYhsFSjtG8fhuGN7xrDydkfBsQhe1w?=
 =?us-ascii?Q?dzpSZWCZQ6pbSr1HE6WoB2c/fiMSSl7kaAqKTupETX25IDfxiBtER6LGix+j?=
 =?us-ascii?Q?bo6OeunsK8EjVqgpuebhNpyM1Uya8OwVJ4j0hM4mvEnO/4/jmTfsWl+efSRM?=
 =?us-ascii?Q?V4/Tt6JcI5P6LkjwdBbWaS633leBd0VAozUH5XU6NoJTGHk/Ss4mD7C6MJAV?=
 =?us-ascii?Q?38QvDkLIfXTU2qvA2//JUp8KJXl00v+gJ4LXNUvORdhRNPB4iS4nOootvywQ?=
 =?us-ascii?Q?r5Qe9pIIDEF7B6Tnudz6/2JLXAPyZMWfleI7eheZruIFVQG8yAjDHzh993Y9?=
 =?us-ascii?Q?hvTVib5XpgzSDSHgYYABDguzCtWkk14pF8OKy4f+3AvyO36DzTcWSn3zu0eG?=
 =?us-ascii?Q?3dMKC56sWsTFI4TK4EfaZrEpRIHWG9iLDfv3Zh3HzosctPVccVY+o6w6i+hD?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a798911-7d32-41e8-661d-08da6b455d1e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 18:18:08.8503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BG9eikrNRlco26s8bDdXgflpJ2lbLwFczJdxlk/my3QOBNIHlb8bfsD9NCcjlm4XazW7n2VntycEaKeG+Y3xmYIDb3kIziSL+NrRM+2wt8w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-21_25,2022-07-21_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207210074
X-Proofpoint-GUID: h1cXBW-WOjVHM4sgOUebmp5UJI3FrJ2Z
X-Proofpoint-ORIG-GUID: h1cXBW-WOjVHM4sgOUebmp5UJI3FrJ2Z
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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
v10: 21jul2022
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

Eric DeVolder (8):
  crash: introduce arch/*/asm/crash.h
  crash: move crash_prepare_elf64_headers
  crash: prototype change for crash_prepare_elf64_headers
  crash: add generic infrastructure for crash hotplug support
  kexec: exclude elfcorehdr from the segment digest
  kexec: exclude hot remove cpu from elfcorehdr notes
  crash: memory and cpu hotplug sysfs attributes
  x86/crash: Add x86 crash hotplug support

 .../admin-guide/mm/memory-hotplug.rst         |   8 +
 Documentation/core-api/cpu_hotplug.rst        |  18 ++
 arch/arm/include/asm/crash.h                  |   5 +
 arch/arm64/include/asm/crash.h                |   5 +
 arch/arm64/kernel/machine_kexec_file.c        |   6 +-
 arch/ia64/include/asm/crash.h                 |   5 +
 arch/m68k/include/asm/crash.h                 |   5 +
 arch/mips/include/asm/crash.h                 |   5 +
 arch/parisc/include/asm/crash.h               |   5 +
 arch/powerpc/include/asm/crash.h              |   5 +
 arch/powerpc/kexec/file_load_64.c             |   2 +-
 arch/riscv/include/asm/crash.h                |   5 +
 arch/s390/include/asm/crash.h                 |   5 +
 arch/sh/include/asm/crash.h                   |   5 +
 arch/x86/Kconfig                              |  11 +
 arch/x86/include/asm/crash.h                  |  20 ++
 arch/x86/kernel/crash.c                       | 117 ++++++++-
 drivers/base/cpu.c                            |  14 ++
 drivers/base/memory.c                         |  13 +
 include/linux/crash_core.h                    |  32 +++
 include/linux/kexec.h                         |  14 +-
 kernel/crash_core.c                           | 233 ++++++++++++++++++
 kernel/kexec_file.c                           | 105 +-------
 23 files changed, 537 insertions(+), 106 deletions(-)
 create mode 100644 arch/arm/include/asm/crash.h
 create mode 100644 arch/arm64/include/asm/crash.h
 create mode 100644 arch/ia64/include/asm/crash.h
 create mode 100644 arch/m68k/include/asm/crash.h
 create mode 100644 arch/mips/include/asm/crash.h
 create mode 100644 arch/parisc/include/asm/crash.h
 create mode 100644 arch/powerpc/include/asm/crash.h
 create mode 100644 arch/riscv/include/asm/crash.h
 create mode 100644 arch/s390/include/asm/crash.h
 create mode 100644 arch/sh/include/asm/crash.h

-- 
2.31.1

