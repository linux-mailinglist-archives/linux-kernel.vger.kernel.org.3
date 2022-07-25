Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4606B57FB2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbiGYIUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbiGYIUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:20:20 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF362BDE;
        Mon, 25 Jul 2022 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658737214; x=1690273214;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FQJneutkHFxCXbOae8x8Ck7xhRv723DBQcNEE6QxEWo=;
  b=hf3KSEW9otfjoRjkS0WH0HCV0UuZZXTUWVJaX8Lz5guaQfir+Ha9s7Nm
   LWZq0wOrPUtoJwlnYy6KDs0ORc7BVW6Dx4rG7wxXcMdFvLH/qkd3qFPJ8
   Gwgj0NjlAv/L1hFo5pL2Izal7RjQ9lyptQTy977cYrPNJ8C/pHL/2y0lG
   jNQbjE7tTrn5svq9hzcqlY1PsUAhDQ63SzpHyNQxQtt3tBum7Xo2z6q2o
   uQpKZmZruSyq/xjXgbtOZzWqYvgw2Uq1pfrVWVps4WmnJ+zWvuA21YSxA
   MV5iOTpOdPYy0Fa934XmBziqDZWcioSMcwBdY6AEem2ATAsIb9ut7LZet
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="274506809"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="xz'?scan'208";a="274506809"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 01:20:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="xz'?scan'208";a="632274219"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga001.jf.intel.com with ESMTP; 25 Jul 2022 01:20:12 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 01:20:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 01:20:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 25 Jul 2022 01:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/JU7VTHhllXwS5Lu915b0dR5v7jlTGWvqrvl51ZfbAcVZZWx+cFEHJUFjjDyHfq/MzOsNYA0ieTigwXx+hKtggUTBn0EGdu9O3htnipnx2NTyRRFq40zNyT8aQf+zoITWzNX0HmqmcKVpj5ZlBFbBwPQNjiGYauHAsRAlEGjvOIED6RVQAjIG6XRgY65/zYXS+VcxCqUFckJsyjDGNdG+hUUQBIDsNFV6LnE24dbbZkN2AbC5+viCj8qD2dk9244Px3mOfMxlMyY1on0ko26KQj58On+plk9GpCW3+YfCWF9kRv9tHSPsHkA905+XabzyFZZ8YXoWMl9BKDNv3UHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p2R1VBpskL05WM8e9aPjrxC46Hh63LiUkq3jd98idXw=;
 b=Pkam4etNUGKEA3eKFGXjh3lT0Lzmde8a3wjdzpF8RcRMlyiYNQOFuB9Gk8s0Eo7dewbU6c1H93Cp5NGKO+NLTmv3X7fvpP1QkyToQZiLBkBUu5hD0pVgYfqBsWi8sqbs0zLm97d/0vE9jWq10UOmC3q5rve5BxSPETxyIGwRAVNBEvz6L5Kg96zPXOz2snhlefgmU3BnY06bxVyUGdzfau72YlKS0ypK+6LPV83Fi6no3UUvzz880vQexFPZkN5+YaWyGONOoxPsBscpcbOa8COugp+D9l+KEfbmZodon0ZLskJkCSR38YwBc/Btw2GCCRLQqW/mCOuO0r9SpY/tqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
 by BY5PR11MB4242.namprd11.prod.outlook.com (2603:10b6:a03:1c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Mon, 25 Jul
 2022 08:19:59 +0000
Received: from SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c]) by SJ1PR11MB6297.namprd11.prod.outlook.com
 ([fe80::35b8:ff0a:4f99:419c%6]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 08:19:59 +0000
Date:   Mon, 25 Jul 2022 16:19:50 +0800
From:   kernel test robot <oliver.sang@intel.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     LKML <linux-kernel@vger.kernel.org>, <rcu@vger.kernel.org>,
        <lkp@lists.01.org>, <lkp@intel.com>
Subject: [printk]  6e72f137fd:
 WARNING:at_kernel/rcu/tasks.h:#rcu_tasks_verify_self_tests
Message-ID: <Yt5SJuG8YuoG0XaJ@xsang-OptiPlex-9020>
Content-Type: multipart/mixed; boundary="V++dxUXzRYNSLmrA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR06CA0192.apcprd06.prod.outlook.com (2603:1096:4:1::24)
 To SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e77599cb-26d5-46b7-202a-08da6e167695
X-MS-TrafficTypeDiagnostic: BY5PR11MB4242:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5JT1sduRPpeSQ8rhC8HHMUC0Az9UiG4R9/jMEeo6Nwk+UHxb9wSnWLnfIb95fkoE/MmBxL/ZlxdKBuR7kHpNm/ZVCjkrUQKe7cgFBkcYbcqQZ1LdXtTT4oqCDFg2eMphnmAUNzDb/pQ879VN2gKdF/0v0YzSpoSGay4+p4w0WrETUhpiTtkH8vSkJvO1AhVBDJ6M9mdHAwqunD6YQpPwMsDksdj/YsQh+KwE/L0gSCzweDr0WFN8SAOVh7we5ZNTBBtMMaj7sJPQpg9KJ/tcQjwdCzuFbJ8YclyIsjfzdXcnsNpYSgDuPk7TaSlIDqTccN0X86AsxYm4vcGTx/qMVpcOiejWFqO4EB0wQRnSLKye+kL+9ihng8OS8B3Zp5NVD98lcICgDmWk5azvOUkpf2OpThIflCiV92eXDNm3HcF+UZHiH6xc78HjBzoVmhxvN65Huus6RF8V89EIhItF82I44mHYTHif8ryePg/HCIoaXnyRILG23xOkRs0Ui3SEVYOp9g3t6ITKwdr6DLhslGe000Rwe5PZM4SeECxwXlbKAvuRsebUe1C/rpxHIz8yi/HKseNjrdQVkxUYgh1I5/lJBAsn2Y9RObpEurycRRo1du3AjAPk24RSh+SBuYVk81kFHHIjXUGi8rtOXC6/jXjebHJr77RJ7cOLnHOUvbsmAobfu0hsLIsw68g046TArTyAUQ3ddNBR5ilX0FeThaQQ6Lk3B5Isj4705d0b8XYITcK+O9upmrsLOUqOJP721mvLZkvCi2DQs8fJZNk97BFVjLR4zQdLhxU6urD+J0l8jq0dmfnJkb71OMDXvNxRppjwUrHIrSI2ajgRkkNf19Y7/cqew3hn5++xJzZ19SESuospsBHniEO1wm+eSivw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6297.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(39860400002)(396003)(366004)(136003)(376002)(186003)(107886003)(83380400001)(4326008)(66946007)(66476007)(66556008)(8676002)(45080400002)(6512007)(9686003)(6506007)(6916009)(41300700001)(6666004)(26005)(2906002)(86362001)(38100700002)(33716001)(8936002)(44144004)(5660300002)(316002)(82960400001)(235185007)(6486002)(30864003)(478600001)(966005)(2700100001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W59DQFEai2YmrNvrwFKG+FA6QSfRVQSHIBZNcnr2Qm+hK2JqxmIZttz/MWd6?=
 =?us-ascii?Q?TmnxIHeo2MIHBtkih5Qn6lHxD8v9MYKU7Vk+fsIB6kvyQGIvwBvdztfxAuLs?=
 =?us-ascii?Q?HZo9rTHGBkyIwiKEDjMj2ZI9kpvK1sxGvoxTsCtrNg/tut0z3FG0GNxTtVft?=
 =?us-ascii?Q?ca24RVYQDDCvpGNyrDSwZSt5i2Fvc1Dx1limLihiobQkBZhiPF67gqfFxAot?=
 =?us-ascii?Q?uT/wZE75RS3Y3SE19vyB4oeq+AUF0TnV03FWDJ5KfUbJcx5vZj2yDJcRBjKN?=
 =?us-ascii?Q?hGBDzAWw0uIhjm2NJ0MOlgrK5b+5TdEe5t5I1L9ZbGf5Fd1bg8j+SDi9TjnQ?=
 =?us-ascii?Q?KEQneT5f+EhAdN/TlqOpkFLC9yVOS4pIE9X1J0GWAgLW4DGrfUm+Q5y4PRMi?=
 =?us-ascii?Q?ShByAEK3tswl78JtkCSMmMDZ88dCgfmGn+lD4+ETB0Vcnut0lnwxBC+RFdIo?=
 =?us-ascii?Q?l9DX5F5CVctkwui0hFaYR+F3U5Wfx3ALqlb5NN3EwHhCCPOoec2xV1VNzu+m?=
 =?us-ascii?Q?38PojiEV+pwvICIhq5qryu8u7AGkwcDWN4m6s2cY+o589ruQOUiX1AZ56nvu?=
 =?us-ascii?Q?9WsIGDU4//P0KZnmEK9spqE3z665CHR7Py9LnMUXTR++0+jK/QpRPnBMc+Kz?=
 =?us-ascii?Q?cnn9aSC5x43FQc+JY6pncoSI2Yg0vCVx5uZgvoBlVsaVeVNp3ipZggu/YgLD?=
 =?us-ascii?Q?45AyNp3XMlthI9bcs745JWBv9yJi33V/+mjxjWDCiOfnJJQ5LoKXtI4b14C7?=
 =?us-ascii?Q?vJtIL/ToGxo8G2CrHPMwzVCSA87mjMdumnOIhsNDf8X/atxAd4mnZ5mORFHu?=
 =?us-ascii?Q?AGQbWMiGQocCo3k1P9kxxjueVJI1yJzJqalumt4olcFRGsC9wS89/dnkevvv?=
 =?us-ascii?Q?T1yauA75LdW2D1nlTMrgpSs4MWklvVTmT70vZX2cz4achpOrQKMkFjhY2ExQ?=
 =?us-ascii?Q?TNzdlydSfLPbcuawWcvndRnx4QS7iNHrptPKDtQkZan7GyQxzrwn9l3GqO8/?=
 =?us-ascii?Q?D5g3CiCfdnrjq4PIL+xEdOjl4IZ/i0F675rQ9ZXyB0nZeLA88hZngP5Ru9T+?=
 =?us-ascii?Q?/xCLNiDlvt5YI/BwxgjhCk8SrZLm+z2BltwA+4EOXc0uLZYnN+RH3WSkh72d?=
 =?us-ascii?Q?OlnbTSVAWJz+EwC2jF2JZc6KVgYV0Mc/4QlQ28R2Yxk4osoCeWi6bh/0CgQJ?=
 =?us-ascii?Q?JrYVjxC4EQw0KOz/ozablHQer65/jONCKYUkdE0ME/TlU5vkTn4YiPNUsp0E?=
 =?us-ascii?Q?a4vyajB3kThvSmGYxFUv+sxLRpAfCpuZyxoNYzw/FJPcCqIurYYG1MPGyUvF?=
 =?us-ascii?Q?G6Y1C6aVsPJFEXJHkbui1tNYwc+R0CvN+WY9N/dAUK+XbZ8mIpjIerN4WnWQ?=
 =?us-ascii?Q?54+JxnKBgaRDwXj5/1LE6VT0FHWSTZyu5sDaUBOkiXbYlpwJRmYn3VASk15+?=
 =?us-ascii?Q?Ez/e8OFKRXX2d02P99YMGzuKYE6l8RyZo6H/9WA9aiFZLpXaHsO4OPXEdmL8?=
 =?us-ascii?Q?Rc2icpVzTjgw15eDEr8C9w3QZAnD4gE4dQ6fbOVznPPIqhjuBiNqzGSIdKyX?=
 =?us-ascii?Q?N0b7EGv1I6xot+c0l2Whg1W+ofnYU5DJG1THolSygTm8FENprZOiFb6T+9aH?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e77599cb-26d5-46b7-202a-08da6e167695
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6297.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 08:19:59.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNAGhOjjiYlVqDSxy14e8/pf5tOYeZYLVdOtMBtKNmyxQBXj1lQkypsxw1irwafyGpSRV/qgRO8Gj+EK0kWgSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4242
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        UPPERCASE_50_75 autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--V++dxUXzRYNSLmrA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline



Greeting,

FYI, we noticed the following commit (built with clang-15):

commit: 6e72f137fdd27b79014ed848d16f03e6d239f2a2 ("printk: Bring back the RT bits.")
https://git.kernel.org/cgit/linux/kernel/git/rt/linux-rt-devel.git linux-5.19.y-rt-rebase

in testcase: boot

on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):


+------------------------------------------------------------+------------+------------+
|                                                            | 29202da893 | 6e72f137fd |
+------------------------------------------------------------+------------+------------+
| WARNING:at_kernel/rcu/tasks.h:#rcu_tasks_verify_self_tests | 0          | 29         |
| RIP:rcu_tasks_verify_self_tests                            | 0          | 29         |
+------------------------------------------------------------+------------+------------+


If you fix the issue, kindly add following tag
Reported-by: kernel test robot <oliver.sang@intel.com>


[   27.647276][    T1] ------------[ cut here ]------------
[ 27.647279][ T1] WARNING: CPU: 0 PID: 1 at kernel/rcu/tasks.h:1751 rcu_tasks_verify_self_tests (update.c:?) 
[   33.067924][    T1] Modules linked in:
[   33.068393][    T1] CPU: 0 PID: 1 Comm: swapper Not tainted 5.19.0-rc7-00020-g6e72f137fdd2 #1
[   33.069378][    T1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.0-debian-1.16.0-4 04/01/2014
[ 33.070541][ T1] RIP: 0010:rcu_tasks_verify_self_tests (update.c:?) 
[ 33.071289][ T1] Code: 48 c7 c7 40 6e e6 82 e8 5f a7 5c 01 41 bc ff ff ff ff 45 31 ed 49 83 ff 03 0f 85 72 ff ff ff eb 08 31 c0 41 f6 c5 01 75 07 90 <0f> 0b 90 44 89 e0 5b 41 5c 41 5d 41 5e 41 5f 5d 31 c9 31 ff 31 f6
All code
========
   0:	48 c7 c7 40 6e e6 82 	mov    $0xffffffff82e66e40,%rdi
   7:	e8 5f a7 5c 01       	callq  0x15ca76b
   c:	41 bc ff ff ff ff    	mov    $0xffffffff,%r12d
  12:	45 31 ed             	xor    %r13d,%r13d
  15:	49 83 ff 03          	cmp    $0x3,%r15
  19:	0f 85 72 ff ff ff    	jne    0xffffffffffffff91
  1f:	eb 08                	jmp    0x29
  21:	31 c0                	xor    %eax,%eax
  23:	41 f6 c5 01          	test   $0x1,%r13b
  27:	75 07                	jne    0x30
  29:	90                   	nop
  2a:*	0f 0b                	ud2    		<-- trapping instruction
  2c:	90                   	nop
  2d:	44 89 e0             	mov    %r12d,%eax
  30:	5b                   	pop    %rbx
  31:	41 5c                	pop    %r12
  33:	41 5d                	pop    %r13
  35:	41 5e                	pop    %r14
  37:	41 5f                	pop    %r15
  39:	5d                   	pop    %rbp
  3a:	31 c9                	xor    %ecx,%ecx
  3c:	31 ff                	xor    %edi,%edi
  3e:	31 f6                	xor    %esi,%esi

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2    
   2:	90                   	nop
   3:	44 89 e0             	mov    %r12d,%eax
   6:	5b                   	pop    %rbx
   7:	41 5c                	pop    %r12
   9:	41 5d                	pop    %r13
   b:	41 5e                	pop    %r14
   d:	41 5f                	pop    %r15
   f:	5d                   	pop    %rbp
  10:	31 c9                	xor    %ecx,%ecx
  12:	31 ff                	xor    %edi,%edi
  14:	31 f6                	xor    %esi,%esi
[   33.073563][    T1] RSP: 0018:ffffc9000001fcd8 EFLAGS: 00010246
[   33.074245][    T1] RAX: 0000000000000000 RBX: ffffffff83abf550 RCX: 0000000000000000
[   33.075150][    T1] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff83abf538
[   33.076037][    T1] RBP: ffffffff83abf558 R08: 0000000000000000 R09: 0000000000000000
[   33.076940][    T1] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000ffffffff
[   33.077853][    T1] R13: 0000000000000000 R14: dffffc0000000000 R15: 0000000000000004
[   33.078765][    T1] FS:  0000000000000000(0000) GS:ffffffff834a7000(0000) knlGS:0000000000000000
[   33.079757][    T1] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.080510][    T1] CR2: 00007f3be6c0c3f8 CR3: 0000000003436000 CR4: 00000000000006b0
[   33.081426][    T1] Call Trace:
[   33.081813][    T1]  <TASK>
[ 33.082156][ T1] ? rcu_barrier_tasks_trace (update.c:?) 
[ 33.082774][ T1] do_one_initcall (??:?) 
[ 33.083315][ T1] ? rcu_barrier_tasks_trace (update.c:?) 
[ 33.083973][ T1] do_initcall_level (main.c:?) 
[ 33.084555][ T1] do_initcalls (main.c:?) 
[ 33.085071][ T1] kernel_init_freeable (main.c:?) 
[ 33.085650][ T1] ? rest_init (main.c:?) 
[ 33.086155][ T1] kernel_init (main.c:?) 
[ 33.086646][ T1] ? rest_init (main.c:?) 
[ 33.087148][ T1] ret_from_fork (??:?) 
[   33.087667][    T1]  </TASK>
[   33.088031][    T1] irq event stamp: 1004249
[ 33.088546][ T1] hardirqs last enabled at (1004257): __up_console_sem (printk.c:?) 
[ 33.089635][ T1] hardirqs last disabled at (1004264): __up_console_sem (printk.c:?) 
[ 33.090721][ T1] softirqs last enabled at (1003820): __do_softirq (??:?) 
[ 33.091807][ T1] softirqs last disabled at (1003811): irq_exit_rcu (??:?) 
[   33.092871][    T1] ---[ end trace 0000000000000000 ]---
[ 33.093909][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.094018][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.094390][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.094448][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.099418][ T1] random: get_random_bytes called from key_alloc+0x640/0xc80 with crng_init=0 
[ 33.099531][ T1] random: get_random_bytes called from key_alloc+0x640/0xc80 with crng_init=0 
[ 33.099718][ T1] random: get_random_bytes called from key_alloc+0x640/0xc80 with crng_init=0 
[ 33.099822][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.100034][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.106418][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.107373][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.112298][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.112703][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.112749][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.119141][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.119231][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.119309][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.119356][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.125525][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.125976][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.132017][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.132071][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.132467][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.135632][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.135871][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.136243][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.136294][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.136678][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.136706][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.136899][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.137087][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.137499][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.137918][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.147747][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.147983][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.150315][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.150361][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.150410][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.150951][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.155449][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.155482][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.155507][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.155535][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.155881][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.156109][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.156302][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.156730][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.156782][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.157150][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.157346][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.157532][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.157598][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.157961][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.169202][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.169420][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.169448][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.175762][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.175935][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.176069][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.176203][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.176337][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.176469][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.176618][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.176753][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.176886][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.177018][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.177151][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.177275][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.177424][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.177588][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.177961][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.178055][ T2] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.178390][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.178578][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.178895][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.179108][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.179299][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 
[ 33.179358][ T1] random: get_random_u32 called from new_slab+0x1ce/0x3c0 with crng_init=0 


To reproduce:

        # build kernel
	cd linux
	cp config-5.19.0-rc7-00020-g6e72f137fdd2 .config
	make HOSTCC=clang-15 CC=clang-15 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
	make HOSTCC=clang-15 CC=clang-15 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
	cd <mod-install-dir>
	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz


        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email

        # if come across any failure that blocks the test,
        # please remove ~/.lkp and /lkp dir to run from a clean state.



-- 
0-DAY CI Kernel Test Service
https://01.org/lkp



--V++dxUXzRYNSLmrA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment;
	filename="config-5.19.0-rc7-00020-g6e72f137fdd2"

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86_64 5.19.0-rc7 Kernel Configuration
#
CONFIG_CC_VERSION_TEXT="clang version 15.0.0 (git://gitmirror/llvm_project 12fbd2d377e396ad61bce56d71c98a1eb1bebfa9)"
CONFIG_GCC_VERSION=0
CONFIG_CC_IS_CLANG=y
CONFIG_CLANG_VERSION=150000
CONFIG_AS_IS_LLVM=y
CONFIG_AS_VERSION=150000
CONFIG_LD_VERSION=0
CONFIG_LD_IS_LLD=y
CONFIG_LLD_VERSION=150000
CONFIG_CC_CAN_LINK=y
CONFIG_CC_CAN_LINK_STATIC=y
CONFIG_CC_HAS_ASM_GOTO=y
CONFIG_CC_HAS_ASM_GOTO_OUTPUT=y
CONFIG_TOOLS_SUPPORT_RELR=y
CONFIG_CC_HAS_ASM_INLINE=y
CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=y
CONFIG_PAHOLE_VERSION=123
CONFIG_CONSTRUCTORS=y
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_TABLE_SORT=y
CONFIG_THREAD_INFO_IN_TASK=y

#
# General setup
#
CONFIG_BROKEN_ON_SMP=y
CONFIG_INIT_ENV_ARG_LIMIT=32
# CONFIG_COMPILE_TEST is not set
# CONFIG_WERROR is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_BUILD_SALT=""
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_BZIP2=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_HAVE_KERNEL_ZSTD=y
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
CONFIG_KERNEL_LZ4=y
# CONFIG_KERNEL_ZSTD is not set
CONFIG_DEFAULT_INIT=""
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_WATCH_QUEUE is not set
# CONFIG_CROSS_MEMORY_ATTACH is not set
# CONFIG_USELIB is not set
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=y
CONFIG_ARCH_CLOCKSOURCE_INIT=y
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
CONFIG_GENERIC_CMOS_UPDATE=y
CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=y
CONFIG_POSIX_CPU_TIMERS_TASK_WORK=y

#
# Timers subsystem
#
CONFIG_HZ_PERIODIC=y
# CONFIG_NO_HZ_IDLE is not set
CONFIG_NO_HZ=y
# CONFIG_HIGH_RES_TIMERS is not set
CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=100
# end of Timers subsystem

CONFIG_BPF=y
CONFIG_HAVE_EBPF_JIT=y
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y

#
# BPF subsystem
#
# CONFIG_BPF_SYSCALL is not set
# CONFIG_BPF_JIT is not set
# end of BPF subsystem

CONFIG_PREEMPT_VOLUNTARY_BUILD=y
# CONFIG_PREEMPT_NONE is not set
CONFIG_PREEMPT_VOLUNTARY=y
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=y
# CONFIG_PREEMPT_DYNAMIC is not set

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=y
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set
CONFIG_PSI=y
CONFIG_PSI_DEFAULT_DISABLED=y
# end of CPU/Task time and stats accounting

#
# RCU Subsystem
#
CONFIG_TINY_RCU=y
CONFIG_RCU_EXPERT=y
CONFIG_SRCU=y
CONFIG_TINY_SRCU=y
CONFIG_TASKS_RCU_GENERIC=y
CONFIG_FORCE_TASKS_RCU=y
CONFIG_TASKS_RCU=y
CONFIG_FORCE_TASKS_RUDE_RCU=y
CONFIG_TASKS_RUDE_RCU=y
CONFIG_FORCE_TASKS_TRACE_RCU=y
CONFIG_TASKS_TRACE_RCU=y
CONFIG_RCU_NEED_SEGCBLIST=y
CONFIG_TASKS_TRACE_RCU_READ_MB=y
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=20
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
# CONFIG_PRINTK_INDEX is not set
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y

#
# Scheduler features
#
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
CONFIG_CC_HAS_INT128=y
CONFIG_CC_IMPLICIT_FALLTHROUGH="-Wimplicit-fallthrough"
CONFIG_GCC12_NO_ARRAY_BOUNDS=y
CONFIG_ARCH_SUPPORTS_INT128=y
CONFIG_CGROUPS=y
# CONFIG_MEMCG is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CGROUP_SCHED is not set
CONFIG_CGROUP_PIDS=y
CONFIG_CGROUP_RDMA=y
CONFIG_CGROUP_FREEZER=y
# CONFIG_CGROUP_DEVICE is not set
CONFIG_CGROUP_CPUACCT=y
CONFIG_CGROUP_PERF=y
CONFIG_CGROUP_MISC=y
# CONFIG_CGROUP_DEBUG is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_TIME_NS=y
# CONFIG_IPC_NS is not set
# CONFIG_USER_NS is not set
# CONFIG_PID_NS is not set
CONFIG_NET_NS=y
# CONFIG_CHECKPOINT_RESTORE is not set
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
# CONFIG_RD_LZMA is not set
# CONFIG_RD_XZ is not set
CONFIG_RD_LZO=y
# CONFIG_RD_LZ4 is not set
# CONFIG_RD_ZSTD is not set
CONFIG_BOOT_CONFIG=y
# CONFIG_BOOT_CONFIG_EMBED is not set
# CONFIG_INITRAMFS_PRESERVE_MTIME is not set
# CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE is not set
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_LD_ORPHAN_WARN=y
CONFIG_SYSCTL=y
CONFIG_SYSCTL_EXCEPTION_TRACE=y
CONFIG_HAVE_PCSPKR_PLATFORM=y
CONFIG_EXPERT=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=y
CONFIG_POSIX_TIMERS=y
CONFIG_PRINTK=y
CONFIG_BUG=y
# CONFIG_PCSPKR_PLATFORM is not set
# CONFIG_BASE_FULL is not set
CONFIG_FUTEX=y
CONFIG_FUTEX_PI=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_IO_URING=y
# CONFIG_ADVISE_SYSCALLS is not set
# CONFIG_MEMBARRIER is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_KALLSYMS_BASE_RELATIVE=y
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
# CONFIG_KCMP is not set
# CONFIG_RSEQ is not set
CONFIG_EMBEDDED=y
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y
CONFIG_PC104=y

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=y
CONFIG_DEBUG_PERF_USE_VMALLOC=y
# end of Kernel Performance Events And Counters

CONFIG_PROFILING=y
CONFIG_TRACEPOINTS=y
# end of General setup

CONFIG_64BIT=y
CONFIG_X86_64=y
CONFIG_X86=y
CONFIG_INSTRUCTION_DECODER=y
CONFIG_OUTPUT_FORMAT="elf64-x86-64"
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_MMU=y
CONFIG_ARCH_MMAP_RND_BITS_MIN=28
CONFIG_ARCH_MMAP_RND_BITS_MAX=32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
CONFIG_GENERIC_ISA_DMA=y
CONFIG_GENERIC_BUG=y
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
CONFIG_ARCH_MAY_HAVE_PC_FDC=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HAS_CPU_RELAX=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_NR_GPIO=1024
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_AUDIT_ARCH=y
CONFIG_KASAN_SHADOW_OFFSET=0xdffffc0000000000
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_PGTABLE_LEVELS=4
CONFIG_CC_HAS_SANE_STACKPROTECTOR=y

#
# Processor type and features
#
# CONFIG_SMP is not set
CONFIG_X86_FEATURE_NAMES=y
# CONFIG_X86_X2APIC is not set
CONFIG_X86_MPPARSE=y
CONFIG_GOLDFISH=y
CONFIG_X86_CPU_RESCTRL=y
# CONFIG_X86_EXTENDED_PLATFORM is not set
# CONFIG_X86_INTEL_LPSS is not set
# CONFIG_X86_AMD_PLATFORM_DEVICE is not set
# CONFIG_IOSF_MBI is not set
# CONFIG_SCHED_OMIT_FRAME_POINTER is not set
CONFIG_HYPERVISOR_GUEST=y
CONFIG_PARAVIRT=y
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_X86_HV_CALLBACK_VECTOR=y
# CONFIG_XEN is not set
CONFIG_KVM_GUEST=y
CONFIG_ARCH_CPUIDLE_HALTPOLL=y
# CONFIG_PVH is not set
# CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
CONFIG_PARAVIRT_CLOCK=y
# CONFIG_JAILHOUSE_GUEST is not set
CONFIG_ACRN_GUEST=y
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=y
CONFIG_X86_INTERNODE_CACHE_SHIFT=6
CONFIG_X86_L1_CACHE_SHIFT=6
CONFIG_X86_TSC=y
CONFIG_X86_CMPXCHG64=y
CONFIG_X86_CMOV=y
CONFIG_X86_MINIMUM_CPU_FAMILY=64
CONFIG_X86_DEBUGCTLMSR=y
CONFIG_IA32_FEAT_CTL=y
CONFIG_X86_VMX_FEATURE_NAMES=y
# CONFIG_PROCESSOR_SELECT is not set
CONFIG_CPU_SUP_INTEL=y
CONFIG_CPU_SUP_AMD=y
CONFIG_CPU_SUP_HYGON=y
CONFIG_CPU_SUP_CENTAUR=y
CONFIG_CPU_SUP_ZHAOXIN=y
CONFIG_HPET_TIMER=y
CONFIG_HPET_EMULATE_RTC=y
CONFIG_DMI=y
# CONFIG_GART_IOMMU is not set
CONFIG_BOOT_VESA_SUPPORT=y
CONFIG_NR_CPUS_RANGE_BEGIN=1
CONFIG_NR_CPUS_RANGE_END=1
CONFIG_NR_CPUS_DEFAULT=1
CONFIG_NR_CPUS=1
CONFIG_UP_LATE_INIT=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_X86_IO_APIC=y
# CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
# CONFIG_X86_MCE is not set

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=y
CONFIG_PERF_EVENTS_INTEL_RAPL=y
CONFIG_PERF_EVENTS_INTEL_CSTATE=y
# CONFIG_PERF_EVENTS_AMD_POWER is not set
# CONFIG_PERF_EVENTS_AMD_UNCORE is not set
# CONFIG_PERF_EVENTS_AMD_BRS is not set
# end of Performance monitoring

# CONFIG_X86_16BIT is not set
CONFIG_X86_VSYSCALL_EMULATION=y
CONFIG_X86_IOPL_IOPERM=y
CONFIG_MICROCODE=y
CONFIG_MICROCODE_INTEL=y
# CONFIG_MICROCODE_AMD is not set
# CONFIG_MICROCODE_LATE_LOADING is not set
CONFIG_X86_MSR=y
CONFIG_X86_CPUID=m
# CONFIG_X86_5LEVEL is not set
CONFIG_X86_DIRECT_GBPAGES=y
CONFIG_X86_CPA_STATISTICS=y
# CONFIG_AMD_MEM_ENCRYPT is not set
CONFIG_ARCH_SPARSEMEM_ENABLE=y
CONFIG_ARCH_SPARSEMEM_DEFAULT=y
CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
# CONFIG_X86_PMEM_LEGACY is not set
# CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
CONFIG_MTRR=y
# CONFIG_MTRR_SANITIZER is not set
# CONFIG_X86_PAT is not set
CONFIG_ARCH_RANDOM=y
CONFIG_X86_UMIP=y
CONFIG_CC_HAS_IBT=y
CONFIG_X86_KERNEL_IBT=y
# CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS is not set
CONFIG_X86_INTEL_TSX_MODE_OFF=y
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
# CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
# CONFIG_X86_SGX is not set
# CONFIG_EFI is not set
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=y
# CONFIG_HZ_1000 is not set
CONFIG_HZ=300
CONFIG_KEXEC=y
CONFIG_KEXEC_FILE=y
CONFIG_ARCH_HAS_KEXEC_PURGATORY=y
CONFIG_KEXEC_SIG=y
# CONFIG_KEXEC_SIG_FORCE is not set
CONFIG_CRASH_DUMP=y
CONFIG_PHYSICAL_START=0x1000000
# CONFIG_RELOCATABLE is not set
CONFIG_PHYSICAL_ALIGN=0x200000
CONFIG_LEGACY_VSYSCALL_XONLY=y
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=y
CONFIG_STRICT_SIGALTSTACK_SIZE=y
CONFIG_HAVE_LIVEPATCH=y
# end of Processor type and features

CONFIG_CC_HAS_SLS=y
CONFIG_CC_HAS_RETURN_THUNK=y
# CONFIG_SPECULATION_MITIGATIONS is not set
CONFIG_ARCH_HAS_ADD_PAGES=y
CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y

#
# Power management and ACPI options
#
# CONFIG_SUSPEND is not set
# CONFIG_HIBERNATION is not set
# CONFIG_PM is not set
CONFIG_ARCH_SUPPORTS_ACPI=y
CONFIG_ACPI=y
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=y
# CONFIG_ACPI_FPDT is not set
CONFIG_ACPI_LPIT=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
# CONFIG_ACPI_EC_DEBUGFS is not set
CONFIG_ACPI_AC=y
CONFIG_ACPI_BATTERY=y
CONFIG_ACPI_BUTTON=y
# CONFIG_ACPI_VIDEO is not set
CONFIG_ACPI_FAN=y
# CONFIG_ACPI_DOCK is not set
CONFIG_ACPI_CPU_FREQ_PSS=y
CONFIG_ACPI_PROCESSOR_CSTATE=y
CONFIG_ACPI_PROCESSOR_IDLE=y
CONFIG_ACPI_PROCESSOR=y
# CONFIG_ACPI_IPMI is not set
# CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
CONFIG_ACPI_THERMAL=y
CONFIG_ACPI_CUSTOM_DSDT_FILE=""
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
CONFIG_ACPI_TABLE_UPGRADE=y
# CONFIG_ACPI_DEBUG is not set
# CONFIG_ACPI_PCI_SLOT is not set
# CONFIG_ACPI_CONTAINER is not set
CONFIG_ACPI_HOTPLUG_IOAPIC=y
# CONFIG_ACPI_SBS is not set
# CONFIG_ACPI_HED is not set
# CONFIG_ACPI_CUSTOM_METHOD is not set
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
# CONFIG_ACPI_NFIT is not set
CONFIG_HAVE_ACPI_APEI=y
CONFIG_HAVE_ACPI_APEI_NMI=y
# CONFIG_ACPI_APEI is not set
# CONFIG_ACPI_DPTF is not set
# CONFIG_ACPI_CONFIGFS is not set
# CONFIG_ACPI_PFRUT is not set
# CONFIG_PMIC_OPREGION is not set
CONFIG_X86_PM_TIMER=y

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_ATTR_SET=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
CONFIG_CPU_FREQ_GOV_POWERSAVE=y
CONFIG_CPU_FREQ_GOV_USERSPACE=y
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
# CONFIG_X86_INTEL_PSTATE is not set
# CONFIG_X86_PCC_CPUFREQ is not set
# CONFIG_X86_AMD_PSTATE is not set
# CONFIG_X86_ACPI_CPUFREQ is not set
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=m

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=m
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y
CONFIG_CPU_IDLE_GOV_TEO=y
# CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
CONFIG_HALTPOLL_CPUIDLE=y
# end of CPU Idle

CONFIG_INTEL_IDLE=y
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=y
CONFIG_PCI_MMCONFIG=y
CONFIG_MMCONF_FAM10H=y
# CONFIG_PCI_CNB20LE_QUIRK is not set
CONFIG_ISA_BUS=y
CONFIG_ISA_DMA_API=y
CONFIG_AMD_NB=y
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
# CONFIG_IA32_EMULATION is not set
# end of Binary Emulations

CONFIG_HAVE_KVM=y
# CONFIG_VIRTUALIZATION is not set
CONFIG_AS_AVX512=y
CONFIG_AS_SHA1_NI=y
CONFIG_AS_SHA256_NI=y
CONFIG_AS_TPAUSE=y

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=y
CONFIG_KEXEC_CORE=y
CONFIG_GENERIC_ENTRY=y
CONFIG_KPROBES=y
# CONFIG_JUMP_LABEL is not set
# CONFIG_STATIC_CALL_SELFTEST is not set
CONFIG_OPTPROBES=y
CONFIG_KPROBES_ON_FTRACE=y
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_KRETPROBES=y
CONFIG_KRETPROBE_ON_RETHOOK=y
CONFIG_HAVE_IOREMAP_PROT=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_KPROBES_ON_FTRACE=y
CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=y
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
CONFIG_HAVE_NMI=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
CONFIG_ARCH_HAS_SET_MEMORY=y
CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
CONFIG_ARCH_WANTS_NO_INSTR=y
CONFIG_HAVE_ASM_MODVERSIONS=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_RSEQ=y
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
CONFIG_HAVE_HW_BREAKPOINT=y
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
CONFIG_HAVE_USER_RETURN_NOTIFIER=y
CONFIG_HAVE_PERF_EVENTS_NMI=y
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
CONFIG_MMU_GATHER_TABLE_FREE=y
CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=y
CONFIG_HAVE_CMPXCHG_LOCAL=y
CONFIG_HAVE_CMPXCHG_DOUBLE=y
CONFIG_HAVE_ARCH_SECCOMP=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_SECCOMP=y
CONFIG_SECCOMP_FILTER=y
# CONFIG_SECCOMP_CACHE_DEBUG is not set
CONFIG_HAVE_ARCH_STACKLEAK=y
CONFIG_HAVE_STACKPROTECTOR=y
# CONFIG_STACKPROTECTOR is not set
CONFIG_ARCH_SUPPORTS_LTO_CLANG=y
CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=y
CONFIG_LTO_NONE=y
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOVE_PUD=y
CONFIG_HAVE_MOVE_PMD=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
CONFIG_HAVE_ARCH_HUGE_VMAP=y
CONFIG_HAVE_ARCH_HUGE_VMALLOC=y
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
CONFIG_HAVE_ARCH_SOFT_DIRTY=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_RELA=y
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
CONFIG_HAVE_EXIT_THREAD=y
CONFIG_ARCH_MMAP_RND_BITS=28
CONFIG_PAGE_SIZE_LESS_THAN_64KB=y
CONFIG_PAGE_SIZE_LESS_THAN_256KB=y
CONFIG_HAVE_OBJTOOL=y
CONFIG_HAVE_JUMP_LABEL_HACK=y
CONFIG_HAVE_NOINSTR_HACK=y
CONFIG_HAVE_NOINSTR_VALIDATION=y
CONFIG_HAVE_UACCESS_VALIDATION=y
CONFIG_HAVE_STACK_VALIDATION=y
CONFIG_HAVE_RELIABLE_STACKTRACE=y
CONFIG_ISA_BUS_API=y
CONFIG_COMPAT_32BIT_TIME=y
CONFIG_ARCH_SUPPORTS_RT=y
CONFIG_HAVE_ARCH_VMAP_STACK=y
CONFIG_VMAP_STACK=y
CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=y
# CONFIG_RANDOMIZE_KSTACK_OFFSET is not set
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
CONFIG_STRICT_KERNEL_RWX=y
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
CONFIG_STRICT_MODULE_RWX=y
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
# CONFIG_LOCK_EVENT_COUNTS is not set
CONFIG_ARCH_HAS_MEM_ENCRYPT=y
CONFIG_HAVE_STATIC_CALL=y
CONFIG_HAVE_STATIC_CALL_INLINE=y
CONFIG_HAVE_PREEMPT_DYNAMIC=y
CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=y
CONFIG_ARCH_WANT_LD_ORPHAN_WARN=y
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=y
CONFIG_ARCH_HAS_ELFCORE_COMPAT=y
CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=y
CONFIG_DYNAMIC_SIGFRAME=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
# end of GCOV-based kernel profiling

CONFIG_HAVE_GCC_PLUGINS=y
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=1
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
CONFIG_MODULE_FORCE_UNLOAD=y
# CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
CONFIG_MODULE_COMPRESS_NONE=y
# CONFIG_MODULE_COMPRESS_GZIP is not set
# CONFIG_MODULE_COMPRESS_XZ is not set
# CONFIG_MODULE_COMPRESS_ZSTD is not set
# CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
CONFIG_MODPROBE_PATH="/sbin/modprobe"
CONFIG_TRIM_UNUSED_KSYMS=y
CONFIG_UNUSED_KSYMS_WHITELIST=""
CONFIG_MODULES_TREE_LOOKUP=y
CONFIG_BLOCK=y
CONFIG_BLOCK_LEGACY_AUTOLOAD=y
CONFIG_BLK_DEV_BSG_COMMON=y
CONFIG_BLK_ICQ=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_BLK_DEV_INTEGRITY=y
CONFIG_BLK_DEV_INTEGRITY_T10=m
CONFIG_BLK_DEV_ZONED=y
# CONFIG_BLK_WBT is not set
CONFIG_BLK_DEBUG_FS=y
CONFIG_BLK_DEBUG_FS_ZONED=y
# CONFIG_BLK_SED_OPAL is not set
# CONFIG_BLK_INLINE_ENCRYPTION is not set

#
# Partition Types
#
# CONFIG_PARTITION_ADVANCED is not set
CONFIG_MSDOS_PARTITION=y
CONFIG_EFI_PARTITION=y
# end of Partition Types

CONFIG_BLK_MQ_PCI=y
CONFIG_BLK_MQ_VIRTIO=y
CONFIG_BLOCK_HOLDER_DEPRECATED=y
CONFIG_BLK_MQ_STACKING=y

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=y
# CONFIG_MQ_IOSCHED_KYBER is not set
CONFIG_IOSCHED_BFQ=m
# end of IO Schedulers

CONFIG_ASN1=y
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
CONFIG_FREEZER=y

#
# Executable file formats
#
CONFIG_BINFMT_ELF=y
CONFIG_ELFCORE=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_BINFMT_MISC is not set
# CONFIG_COREDUMP is not set
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SWAP=y
# CONFIG_ZSWAP is not set
CONFIG_ZSMALLOC=y
CONFIG_ZSMALLOC_STAT=y

#
# SLAB allocator options
#
# CONFIG_SLAB is not set
CONFIG_SLUB=y
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=y
CONFIG_SLAB_FREELIST_RANDOM=y
# CONFIG_SLAB_FREELIST_HARDENED is not set
# CONFIG_SLUB_STATS is not set
# end of SLAB allocator options

# CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
# CONFIG_COMPAT_BRK is not set
CONFIG_SPARSEMEM=y
CONFIG_SPARSEMEM_EXTREME=y
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
CONFIG_SPARSEMEM_VMEMMAP=y
CONFIG_HAVE_FAST_GUP=y
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
# CONFIG_MEMORY_HOTPLUG is not set
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
CONFIG_COMPACTION=y
# CONFIG_PAGE_REPORTING is not set
CONFIG_MIGRATION=y
CONFIG_ARCH_ENABLE_THP_MIGRATION=y
CONFIG_PHYS_ADDR_T_64BIT=y
CONFIG_VIRT_TO_BUS=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
CONFIG_ARCH_WANTS_THP_SWAP=y
CONFIG_TRANSPARENT_HUGEPAGE=y
CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
# CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
CONFIG_THP_SWAP=y
CONFIG_READ_ONLY_THP_FOR_FS=y
CONFIG_NEED_PER_CPU_KM=y
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
CONFIG_HAVE_SETUP_PER_CPU_AREA=y
# CONFIG_CMA is not set
CONFIG_GENERIC_EARLY_IOREMAP=y
CONFIG_PAGE_IDLE_FLAG=y
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=y
CONFIG_ARCH_HAS_VM_GET_PAGE_PROT=y
CONFIG_ARCH_HAS_PTE_DEVMAP=y
CONFIG_ARCH_HAS_ZONE_DMA_SET=y
CONFIG_ZONE_DMA=y
CONFIG_ZONE_DMA32=y
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_PERCPU_STATS=y
# CONFIG_GUP_TEST is not set
CONFIG_ARCH_HAS_PTE_SPECIAL=y
# CONFIG_USERFAULTFD is not set

#
# Data Access Monitoring
#
CONFIG_DAMON=y
# CONFIG_DAMON_VADDR is not set
CONFIG_DAMON_PADDR=y
CONFIG_DAMON_SYSFS=y
# CONFIG_DAMON_RECLAIM is not set
# end of Data Access Monitoring
# end of Memory Management options

CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
CONFIG_UNIX_SCM=y
CONFIG_AF_UNIX_OOB=y
# CONFIG_UNIX_DIAG is not set
# CONFIG_TLS is not set
# CONFIG_XFRM_USER is not set
# CONFIG_NET_KEY is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
# CONFIG_IP_PNP_BOOTP is not set
# CONFIG_IP_PNP_RARP is not set
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_INET_RAW_DIAG is not set
# CONFIG_INET_DIAG_DESTROY is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_IPV6_SEG6_LWTUNNEL is not set
# CONFIG_IPV6_SEG6_HMAC is not set
# CONFIG_IPV6_RPL_LWTUNNEL is not set
# CONFIG_IPV6_IOAM6_LWTUNNEL is not set
# CONFIG_NETLABEL is not set
# CONFIG_MPTCP is not set
# CONFIG_NETWORK_SECMARK is not set
CONFIG_NET_PTP_CLASSIFY=y
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_BPFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
# CONFIG_NET_DSA is not set
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
CONFIG_DNS_RESOLVER=m
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_NET_NSH is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
# CONFIG_NET_L3_MASTER_DEV is not set
# CONFIG_QRTR is not set
# CONFIG_NET_NCSI is not set
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_NET_DROP_MONITOR is not set
# end of Network testing
# end of Networking options

# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
# CONFIG_AF_KCM is not set
# CONFIG_MCTP is not set
CONFIG_WIRELESS=y
# CONFIG_CFG80211 is not set

#
# CFG80211 needs to be enabled for MAC80211
#
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_RFKILL is not set
CONFIG_NET_9P=y
CONFIG_NET_9P_FD=y
CONFIG_NET_9P_VIRTIO=y
# CONFIG_NET_9P_DEBUG is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_PSAMPLE is not set
# CONFIG_NET_IFE is not set
# CONFIG_LWTUNNEL is not set
CONFIG_DST_CACHE=y
CONFIG_GRO_CELLS=y
CONFIG_FAILOVER=m
CONFIG_ETHTOOL_NETLINK=y

#
# Device Drivers
#
CONFIG_HAVE_EISA=y
CONFIG_EISA=y
# CONFIG_EISA_VLB_PRIMING is not set
CONFIG_EISA_PCI_EISA=y
CONFIG_EISA_VIRTUAL_ROOT=y
CONFIG_EISA_NAMES=y
CONFIG_HAVE_PCI=y
CONFIG_PCI=y
CONFIG_PCI_DOMAINS=y
# CONFIG_PCIEPORTBUS is not set
CONFIG_PCIEASPM=y
CONFIG_PCIEASPM_DEFAULT=y
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
# CONFIG_PCIE_PTM is not set
# CONFIG_PCI_MSI is not set
CONFIG_PCI_QUIRKS=y
# CONFIG_PCI_DEBUG is not set
# CONFIG_PCI_STUB is not set
CONFIG_PCI_LOCKLESS_CONFIG=y
# CONFIG_PCI_IOV is not set
# CONFIG_PCI_PRI is not set
# CONFIG_PCI_PASID is not set
CONFIG_PCI_LABEL=y
# CONFIG_PCIE_BUS_TUNE_OFF is not set
CONFIG_PCIE_BUS_DEFAULT=y
# CONFIG_PCIE_BUS_SAFE is not set
# CONFIG_PCIE_BUS_PERFORMANCE is not set
# CONFIG_PCIE_BUS_PEER2PEER is not set
CONFIG_VGA_ARB=y
CONFIG_VGA_ARB_MAX_GPUS=16
# CONFIG_HOTPLUG_PCI is not set

#
# PCI controller drivers
#

#
# DesignWare PCI Core Support
#
# end of DesignWare PCI Core Support

#
# Mobiveil PCIe Core Support
#
# end of Mobiveil PCIe Core Support

#
# Cadence PCIe controllers support
#
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
# CONFIG_PCI_ENDPOINT is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
# CONFIG_PCI_SW_SWITCHTEC is not set
# end of PCI switch controller drivers

# CONFIG_CXL_BUS is not set
CONFIG_PCCARD=y
CONFIG_PCMCIA=m
# CONFIG_PCMCIA_LOAD_CIS is not set
CONFIG_CARDBUS=y

#
# PC-card bridges
#
# CONFIG_YENTA is not set
# CONFIG_PD6729 is not set
# CONFIG_I82092 is not set
# CONFIG_RAPIDIO is not set

#
# Generic Driver Options
#
CONFIG_AUXILIARY_BUS=y
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=y
# CONFIG_DEVTMPFS_MOUNT is not set
CONFIG_DEVTMPFS_SAFE=y
# CONFIG_STANDALONE is not set
# CONFIG_PREVENT_FIRMWARE_BUILD is not set

#
# Firmware loader
#
CONFIG_FW_LOADER=m
CONFIG_FW_LOADER_PAGED_BUF=y
CONFIG_FW_LOADER_SYSFS=y
CONFIG_EXTRA_FIRMWARE=""
CONFIG_FW_LOADER_USER_HELPER=y
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_FW_LOADER_COMPRESS=y
CONFIG_FW_LOADER_COMPRESS_XZ=y
CONFIG_FW_LOADER_COMPRESS_ZSTD=y
# CONFIG_FW_UPLOAD is not set
# end of Firmware loader

# CONFIG_ALLOW_DEV_COREDUMP is not set
# CONFIG_DEBUG_DRIVER is not set
CONFIG_DEBUG_DEVRES=y
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_GENERIC_CPU_AUTOPROBE=y
CONFIG_GENERIC_CPU_VULNERABILITIES=y
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=m
CONFIG_REGMAP_W1=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
CONFIG_DMA_FENCE_TRACE=y
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MHI_BUS=y
CONFIG_MHI_BUS_DEBUG=y
# CONFIG_MHI_BUS_PCI_GENERIC is not set
CONFIG_MHI_BUS_EP=m
# end of Bus devices

# CONFIG_CONNECTOR is not set

#
# Firmware Drivers
#

#
# ARM System Control and Management Interface Protocol
#
# end of ARM System Control and Management Interface Protocol

CONFIG_EDD=y
CONFIG_EDD_OFF=y
CONFIG_FIRMWARE_MEMMAP=y
CONFIG_DMIID=y
# CONFIG_DMI_SYSFS is not set
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
CONFIG_FW_CFG_SYSFS=y
CONFIG_FW_CFG_SYSFS_CMDLINE=y
CONFIG_SYSFB=y
# CONFIG_SYSFB_SIMPLEFB is not set
CONFIG_CS_DSP=m
CONFIG_GOOGLE_FIRMWARE=y
# CONFIG_GOOGLE_SMI is not set
# CONFIG_GOOGLE_COREBOOT_TABLE is not set
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

# CONFIG_GNSS is not set
CONFIG_MTD=m
# CONFIG_MTD_TESTS is not set

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=m
CONFIG_MTD_CMDLINE_PARTS=m
CONFIG_MTD_REDBOOT_PARTS=m
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=m
# CONFIG_MTD_BLOCK is not set
CONFIG_MTD_BLOCK_RO=m

#
# Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
#
CONFIG_FTL=m
CONFIG_NFTL=m
# CONFIG_NFTL_RW is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
CONFIG_SSFDC=m
CONFIG_SM_FTL=m
CONFIG_MTD_OOPS=m
# CONFIG_MTD_SWAP is not set
# CONFIG_MTD_PARTITIONED_MASTER is not set

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=m
CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=m
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=y
CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
CONFIG_MTD_CFI_INTELEXT=m
CONFIG_MTD_CFI_AMDSTD=m
# CONFIG_MTD_CFI_STAA is not set
CONFIG_MTD_CFI_UTIL=m
CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=m
CONFIG_MTD_ABSENT=m
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=y
CONFIG_MTD_PHYSMAP=m
# CONFIG_MTD_PHYSMAP_COMPAT is not set
# CONFIG_MTD_PHYSMAP_GPIO_ADDR is not set
CONFIG_MTD_SBC_GXX=m
# CONFIG_MTD_AMD76XROM is not set
CONFIG_MTD_ICHXROM=m
# CONFIG_MTD_ESB2ROM is not set
# CONFIG_MTD_CK804XROM is not set
# CONFIG_MTD_SCB2_FLASH is not set
# CONFIG_MTD_NETtel is not set
# CONFIG_MTD_L440GX is not set
# CONFIG_MTD_PCI is not set
CONFIG_MTD_PCMCIA=m
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
# CONFIG_MTD_PLATRAM is not set
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
# CONFIG_MTD_PMC551 is not set
CONFIG_MTD_SLRAM=m
# CONFIG_MTD_PHRAM is not set
# CONFIG_MTD_MTDRAM is not set
CONFIG_MTD_BLOCK2MTD=m

#
# Disk-On-Chip Device Drivers
#
# CONFIG_MTD_DOCG3 is not set
# end of Self-contained MTD device drivers

#
# NAND
#
CONFIG_MTD_NAND_CORE=m
# CONFIG_MTD_ONENAND is not set
CONFIG_MTD_RAW_NAND=m

#
# Raw/parallel NAND flash controllers
#
# CONFIG_MTD_NAND_DENALI_PCI is not set
# CONFIG_MTD_NAND_CAFE is not set
CONFIG_MTD_NAND_MXIC=m
CONFIG_MTD_NAND_GPIO=m
CONFIG_MTD_NAND_PLATFORM=m
CONFIG_MTD_NAND_ARASAN=m

#
# Misc
#
CONFIG_MTD_NAND_NANDSIM=m
# CONFIG_MTD_NAND_RICOH is not set
CONFIG_MTD_NAND_DISKONCHIP=m
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED=y
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=0
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_HIGH is not set
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=y

#
# ECC engine support
#
CONFIG_MTD_NAND_ECC=y
CONFIG_MTD_NAND_ECC_SW_HAMMING=y
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=y
CONFIG_MTD_NAND_ECC_SW_BCH=y
# CONFIG_MTD_NAND_ECC_MXIC is not set
# end of ECC engine support
# end of NAND

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=m
CONFIG_MTD_QINFO_PROBE=m
# end of LPDDR & LPDDR2 PCM memory drivers

# CONFIG_MTD_UBI is not set
CONFIG_MTD_HYPERBUS=m
# CONFIG_OF is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
# CONFIG_PARPORT_SERIAL is not set
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_PC_SUPERIO=y
# CONFIG_PARPORT_PC_PCMCIA is not set
CONFIG_PARPORT_AX88796=m
CONFIG_PARPORT_1284=y
CONFIG_PARPORT_NOT_PC=y
CONFIG_PNP=y
CONFIG_PNP_DEBUG_MESSAGES=y

#
# Protocols
#
CONFIG_PNPACPI=y
CONFIG_BLK_DEV=y
CONFIG_BLK_DEV_NULL_BLK=y
CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=y
# CONFIG_BLK_DEV_FD is not set
CONFIG_CDROM=m
# CONFIG_PARIDE is not set
# CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
CONFIG_ZRAM=y
# CONFIG_ZRAM_DEF_COMP_LZORLE is not set
# CONFIG_ZRAM_DEF_COMP_ZSTD is not set
# CONFIG_ZRAM_DEF_COMP_LZO is not set
CONFIG_ZRAM_DEF_COMP_842=y
CONFIG_ZRAM_DEF_COMP="842"
CONFIG_ZRAM_WRITEBACK=y
CONFIG_ZRAM_MEMORY_TRACKING=y
# CONFIG_BLK_DEV_LOOP is not set
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
# CONFIG_BLK_DEV_SX8 is not set
# CONFIG_BLK_DEV_RAM is not set
CONFIG_CDROM_PKTCDVD=m
CONFIG_CDROM_PKTCDVD_BUFFERS=8
CONFIG_CDROM_PKTCDVD_WCACHE=y
# CONFIG_ATA_OVER_ETH is not set
CONFIG_VIRTIO_BLK=y
# CONFIG_BLK_DEV_RBD is not set

#
# NVME Support
#
CONFIG_NVME_CORE=m
# CONFIG_BLK_DEV_NVME is not set
# CONFIG_NVME_MULTIPATH is not set
CONFIG_NVME_VERBOSE_ERRORS=y
CONFIG_NVME_HWMON=y
CONFIG_NVME_FABRICS=m
# CONFIG_NVME_FC is not set
# CONFIG_NVME_TCP is not set
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_PASSTHRU=y
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_FC=m
# CONFIG_NVME_TARGET_TCP is not set
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=m
CONFIG_AD525X_DPOT=m
CONFIG_AD525X_DPOT_I2C=m
CONFIG_DUMMY_IRQ=y
# CONFIG_IBM_ASM is not set
# CONFIG_PHANTOM is not set
# CONFIG_TIFM_CORE is not set
CONFIG_ICS932S401=m
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_HP_ILO is not set
# CONFIG_APDS9802ALS is not set
CONFIG_ISL29003=m
CONFIG_ISL29020=m
CONFIG_SENSORS_TSL2550=m
CONFIG_SENSORS_BH1770=m
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
CONFIG_DS1682=m
# CONFIG_SRAM is not set
# CONFIG_DW_XDATA_PCIE is not set
# CONFIG_PCI_ENDPOINT_TEST is not set
CONFIG_XILINX_SDFEC=m
CONFIG_C2PORT=y
CONFIG_C2PORT_DURAMAR_2150=y

#
# EEPROM support
#
CONFIG_EEPROM_AT24=m
CONFIG_EEPROM_LEGACY=m
CONFIG_EEPROM_MAX6875=m
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_IDT_89HPESX is not set
# CONFIG_EEPROM_EE1004 is not set
# end of EEPROM support

# CONFIG_CB710_CORE is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=m

#
# Altera FPGA firmware download module (requires I2C)
#
# CONFIG_ALTERA_STAPL is not set
# CONFIG_INTEL_MEI is not set
# CONFIG_INTEL_MEI_ME is not set
# CONFIG_INTEL_MEI_TXE is not set
# CONFIG_VMWARE_VMCI is not set
# CONFIG_GENWQE is not set
# CONFIG_ECHO is not set
# CONFIG_MISC_ALCOR_PCI is not set
# CONFIG_MISC_RTSX_PCI is not set
# CONFIG_HABANA_AI is not set
CONFIG_UACCE=y
CONFIG_PVPANIC=y
# CONFIG_PVPANIC_MMIO is not set
# CONFIG_PVPANIC_PCI is not set
# end of Misc devices

#
# SCSI device support
#
CONFIG_SCSI_MOD=m
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI_COMMON=y
CONFIG_SCSI=m
CONFIG_SCSI_DMA=y
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=m
CONFIG_CHR_DEV_ST=m
CONFIG_BLK_DEV_SR=m
CONFIG_CHR_DEV_SG=m
CONFIG_BLK_DEV_BSG=y
CONFIG_CHR_DEV_SCH=m
# CONFIG_SCSI_CONSTANTS is not set
CONFIG_SCSI_LOGGING=y
CONFIG_SCSI_SCAN_ASYNC=y

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
CONFIG_SCSI_SRP_ATTRS=m
# end of SCSI Transports

# CONFIG_SCSI_LOWLEVEL is not set
# CONFIG_SCSI_DH is not set
# end of SCSI device support

# CONFIG_ATA is not set
CONFIG_MD=y
CONFIG_BLK_DEV_MD=m
CONFIG_MD_LINEAR=m
CONFIG_MD_RAID0=m
CONFIG_MD_RAID1=m
CONFIG_MD_RAID10=m
CONFIG_MD_RAID456=m
CONFIG_MD_MULTIPATH=m
# CONFIG_MD_FAULTY is not set
CONFIG_BCACHE=y
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BCACHE_ASYNC_REGISTRATION=y
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=m
# CONFIG_DM_DEBUG is not set
CONFIG_DM_BUFIO=m
CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING=y
# CONFIG_DM_DEBUG_BLOCK_STACK_TRACING is not set
CONFIG_DM_BIO_PRISON=m
CONFIG_DM_PERSISTENT_DATA=m
# CONFIG_DM_UNSTRIPED is not set
CONFIG_DM_CRYPT=m
CONFIG_DM_SNAPSHOT=m
CONFIG_DM_THIN_PROVISIONING=m
CONFIG_DM_CACHE=m
# CONFIG_DM_CACHE_SMQ is not set
CONFIG_DM_WRITECACHE=m
CONFIG_DM_EBS=m
# CONFIG_DM_ERA is not set
CONFIG_DM_CLONE=m
CONFIG_DM_MIRROR=m
# CONFIG_DM_LOG_USERSPACE is not set
CONFIG_DM_RAID=m
CONFIG_DM_ZERO=m
CONFIG_DM_MULTIPATH=m
# CONFIG_DM_MULTIPATH_QL is not set
CONFIG_DM_MULTIPATH_ST=m
# CONFIG_DM_MULTIPATH_HST is not set
CONFIG_DM_MULTIPATH_IOA=m
CONFIG_DM_DELAY=m
CONFIG_DM_DUST=m
# CONFIG_DM_UEVENT is not set
# CONFIG_DM_FLAKEY is not set
CONFIG_DM_VERITY=m
# CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
# CONFIG_DM_VERITY_FEC is not set
# CONFIG_DM_SWITCH is not set
# CONFIG_DM_LOG_WRITES is not set
CONFIG_DM_INTEGRITY=m
# CONFIG_DM_ZONED is not set
CONFIG_TARGET_CORE=y
CONFIG_TCM_IBLOCK=m
CONFIG_TCM_FILEIO=y
CONFIG_TCM_PSCSI=m
# CONFIG_TCM_USER2 is not set
# CONFIG_LOOPBACK_TARGET is not set
# CONFIG_ISCSI_TARGET is not set
# CONFIG_FUSION is not set

#
# IEEE 1394 (FireWire) support
#
# CONFIG_FIREWIRE is not set
# CONFIG_FIREWIRE_NOSY is not set
# end of IEEE 1394 (FireWire) support

# CONFIG_MACINTOSH_DRIVERS is not set
CONFIG_NETDEVICES=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_WIREGUARD is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_FC is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_GENEVE is not set
# CONFIG_BAREUDP is not set
# CONFIG_GTP is not set
# CONFIG_MACSEC is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
CONFIG_VIRTIO_NET=m
# CONFIG_NLMON is not set
# CONFIG_MHI_NET is not set
# CONFIG_ARCNET is not set
CONFIG_ETHERNET=y
CONFIG_NET_VENDOR_3COM=y
# CONFIG_EL3 is not set
# CONFIG_PCMCIA_3C574 is not set
# CONFIG_PCMCIA_3C589 is not set
# CONFIG_VORTEX is not set
# CONFIG_TYPHOON is not set
CONFIG_NET_VENDOR_ADAPTEC=y
# CONFIG_ADAPTEC_STARFIRE is not set
CONFIG_NET_VENDOR_AGERE=y
# CONFIG_ET131X is not set
CONFIG_NET_VENDOR_ALACRITECH=y
# CONFIG_SLICOSS is not set
CONFIG_NET_VENDOR_ALTEON=y
# CONFIG_ACENIC is not set
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_AMAZON=y
# CONFIG_NET_VENDOR_AMD is not set
CONFIG_NET_VENDOR_AQUANTIA=y
# CONFIG_AQTION is not set
CONFIG_NET_VENDOR_ARC=y
CONFIG_NET_VENDOR_ASIX=y
CONFIG_NET_VENDOR_ATHEROS=y
# CONFIG_ATL2 is not set
# CONFIG_ATL1 is not set
# CONFIG_ATL1E is not set
# CONFIG_ATL1C is not set
# CONFIG_ALX is not set
# CONFIG_CX_ECAT is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_BNX2 is not set
# CONFIG_CNIC is not set
# CONFIG_TIGON3 is not set
# CONFIG_BNX2X is not set
# CONFIG_SYSTEMPORT is not set
# CONFIG_BNXT is not set
CONFIG_NET_VENDOR_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_CAVIUM=y
# CONFIG_THUNDER_NIC_PF is not set
# CONFIG_THUNDER_NIC_VF is not set
# CONFIG_THUNDER_NIC_BGX is not set
# CONFIG_THUNDER_NIC_RGX is not set
# CONFIG_CAVIUM_PTP is not set
# CONFIG_LIQUIDIO is not set
CONFIG_NET_VENDOR_CHELSIO=y
# CONFIG_CHELSIO_T1 is not set
# CONFIG_CHELSIO_T3 is not set
# CONFIG_CHELSIO_T4 is not set
# CONFIG_CHELSIO_T4VF is not set
CONFIG_NET_VENDOR_CIRRUS=y
CONFIG_NET_VENDOR_CISCO=y
# CONFIG_ENIC is not set
CONFIG_NET_VENDOR_CORTINA=y
CONFIG_NET_VENDOR_DAVICOM=y
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_DEC=y
# CONFIG_NET_TULIP is not set
CONFIG_NET_VENDOR_DLINK=y
# CONFIG_DL2K is not set
# CONFIG_SUNDANCE is not set
CONFIG_NET_VENDOR_EMULEX=y
# CONFIG_BE2NET is not set
CONFIG_NET_VENDOR_ENGLEDER=y
# CONFIG_TSNEP is not set
CONFIG_NET_VENDOR_EZCHIP=y
CONFIG_NET_VENDOR_FUJITSU=y
# CONFIG_PCMCIA_FMVJ18X is not set
CONFIG_NET_VENDOR_FUNGIBLE=y
CONFIG_NET_VENDOR_GOOGLE=y
CONFIG_NET_VENDOR_HUAWEI=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_INTEL=y
# CONFIG_E100 is not set
CONFIG_E1000=y
# CONFIG_E1000E is not set
# CONFIG_IGB is not set
# CONFIG_IGBVF is not set
# CONFIG_IXGB is not set
# CONFIG_IXGBE is not set
# CONFIG_I40E is not set
# CONFIG_IGC is not set
# CONFIG_JME is not set
CONFIG_NET_VENDOR_LITEX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
# CONFIG_SKGE is not set
# CONFIG_SKY2 is not set
# CONFIG_OCTEON_EP is not set
CONFIG_NET_VENDOR_MELLANOX=y
# CONFIG_MLX4_EN is not set
# CONFIG_MLX5_CORE is not set
# CONFIG_MLXSW_CORE is not set
# CONFIG_MLXFW is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8851_MLL is not set
# CONFIG_KSZ884X_PCI is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_LAN743X is not set
CONFIG_NET_VENDOR_MICROSEMI=y
CONFIG_NET_VENDOR_MICROSOFT=y
CONFIG_NET_VENDOR_MYRI=y
# CONFIG_MYRI10GE is not set
# CONFIG_FEALNX is not set
CONFIG_NET_VENDOR_NI=y
# CONFIG_NI_XGE_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_NATSEMI=y
# CONFIG_NATSEMI is not set
# CONFIG_NS83820 is not set
CONFIG_NET_VENDOR_NETERION=y
# CONFIG_S2IO is not set
# CONFIG_VXGE is not set
CONFIG_NET_VENDOR_NETRONOME=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_PCMCIA_AXNET is not set
# CONFIG_NE2K_PCI is not set
# CONFIG_PCMCIA_PCNET is not set
CONFIG_NET_VENDOR_NVIDIA=y
# CONFIG_FORCEDETH is not set
CONFIG_NET_VENDOR_OKI=y
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_PACKET_ENGINES=y
# CONFIG_HAMACHI is not set
# CONFIG_YELLOWFIN is not set
CONFIG_NET_VENDOR_PENSANDO=y
# CONFIG_IONIC is not set
CONFIG_NET_VENDOR_QLOGIC=y
# CONFIG_QLA3XXX is not set
# CONFIG_QLCNIC is not set
# CONFIG_NETXEN_NIC is not set
# CONFIG_QED is not set
CONFIG_NET_VENDOR_BROCADE=y
# CONFIG_BNA is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCOM_EMAC is not set
# CONFIG_RMNET is not set
CONFIG_NET_VENDOR_RDC=y
# CONFIG_R6040 is not set
CONFIG_NET_VENDOR_REALTEK=y
# CONFIG_ATP is not set
# CONFIG_8139CP is not set
# CONFIG_8139TOO is not set
# CONFIG_R8169 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SILAN=y
# CONFIG_SC92031 is not set
CONFIG_NET_VENDOR_SIS=y
# CONFIG_SIS900 is not set
# CONFIG_SIS190 is not set
CONFIG_NET_VENDOR_SOLARFLARE=y
# CONFIG_SFC is not set
# CONFIG_SFC_FALCON is not set
# CONFIG_SFC_SIENA is not set
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_PCMCIA_SMC91C92 is not set
# CONFIG_EPIC100 is not set
# CONFIG_SMSC911X is not set
# CONFIG_SMSC9420 is not set
CONFIG_NET_VENDOR_SOCIONEXT=y
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SUN=y
# CONFIG_HAPPYMEAL is not set
# CONFIG_SUNGEM is not set
# CONFIG_CASSINI is not set
# CONFIG_NIU is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_DWC_XLGMAC is not set
CONFIG_NET_VENDOR_TEHUTI=y
# CONFIG_TEHUTI is not set
CONFIG_NET_VENDOR_TI=y
# CONFIG_TI_CPSW_PHY_SEL is not set
# CONFIG_TLAN is not set
CONFIG_NET_VENDOR_VERTEXCOM=y
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_NET_VENDOR_XILINX=y
# CONFIG_XILINX_EMACLITE is not set
# CONFIG_XILINX_AXI_EMAC is not set
# CONFIG_XILINX_LL_TEMAC is not set
CONFIG_NET_VENDOR_XIRCOM=y
# CONFIG_PCMCIA_XIRC2PS is not set
# CONFIG_FDDI is not set
# CONFIG_HIPPI is not set
# CONFIG_NET_SB1000 is not set
# CONFIG_PHYLIB is not set
# CONFIG_MDIO_DEVICE is not set

#
# PCS device drivers
#
# end of PCS device drivers

# CONFIG_PLIP is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set

#
# Host-side USB support is needed for USB Network Adapter support
#
CONFIG_WLAN=y
CONFIG_WLAN_VENDOR_ADMTEK=y
CONFIG_WLAN_VENDOR_ATH=y
# CONFIG_ATH_DEBUG is not set
# CONFIG_ATH5K_PCI is not set
CONFIG_WLAN_VENDOR_ATMEL=y
CONFIG_WLAN_VENDOR_BROADCOM=y
CONFIG_WLAN_VENDOR_CISCO=y
CONFIG_WLAN_VENDOR_INTEL=y
CONFIG_WLAN_VENDOR_INTERSIL=y
# CONFIG_HOSTAP is not set
CONFIG_WLAN_VENDOR_MARVELL=y
CONFIG_WLAN_VENDOR_MEDIATEK=y
CONFIG_WLAN_VENDOR_MICROCHIP=y
CONFIG_WLAN_VENDOR_PURELIFI=y
CONFIG_WLAN_VENDOR_RALINK=y
CONFIG_WLAN_VENDOR_REALTEK=y
CONFIG_WLAN_VENDOR_RSI=y
CONFIG_WLAN_VENDOR_SILABS=y
CONFIG_WLAN_VENDOR_ST=y
CONFIG_WLAN_VENDOR_TI=y
CONFIG_WLAN_VENDOR_ZYDAS=y
CONFIG_WLAN_VENDOR_QUANTENNA=y
# CONFIG_PCMCIA_RAYCS is not set
# CONFIG_WAN is not set

#
# Wireless WAN
#
# CONFIG_WWAN is not set
# end of Wireless WAN

# CONFIG_VMXNET3 is not set
# CONFIG_FUJITSU_ES is not set
# CONFIG_NETDEVSIM is not set
CONFIG_NET_FAILOVER=m
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=m
CONFIG_INPUT_FF_MEMLESS=m
CONFIG_INPUT_SPARSEKMAP=m
# CONFIG_INPUT_MATRIXKMAP is not set
CONFIG_INPUT_VIVALDIFMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=m
# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m
CONFIG_INPUT_EVDEV=m
CONFIG_INPUT_EVBUG=m

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1050 is not set
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_DLINK_DIR685 is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_GPIO is not set
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
# CONFIG_KEYBOARD_SAMSUNG is not set
# CONFIG_KEYBOARD_GOLDFISH_EVENTS is not set
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_MTK_PMIC is not set
# CONFIG_KEYBOARD_CYPRESS_SF is not set
# CONFIG_INPUT_MOUSE is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_AD7879=m
# CONFIG_TOUCHSCREEN_AD7879_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=m
# CONFIG_TOUCHSCREEN_ATMEL_MXT_T37 is not set
CONFIG_TOUCHSCREEN_AUO_PIXCIR=m
CONFIG_TOUCHSCREEN_BU21013=m
CONFIG_TOUCHSCREEN_BU21029=m
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
CONFIG_TOUCHSCREEN_CY8CTMA140=m
CONFIG_TOUCHSCREEN_CY8CTMG110=m
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
CONFIG_TOUCHSCREEN_DYNAPRO=m
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
CONFIG_TOUCHSCREEN_EETI=m
# CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
CONFIG_TOUCHSCREEN_EXC3000=m
CONFIG_TOUCHSCREEN_FUJITSU=m
CONFIG_TOUCHSCREEN_GOODIX=m
CONFIG_TOUCHSCREEN_HIDEEP=m
CONFIG_TOUCHSCREEN_HYCON_HY46XX=m
CONFIG_TOUCHSCREEN_ILI210X=m
# CONFIG_TOUCHSCREEN_ILITEK is not set
# CONFIG_TOUCHSCREEN_S6SY761 is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
CONFIG_TOUCHSCREEN_EKTF2127=m
CONFIG_TOUCHSCREEN_ELAN=m
CONFIG_TOUCHSCREEN_ELO=m
CONFIG_TOUCHSCREEN_WACOM_W8001=m
CONFIG_TOUCHSCREEN_WACOM_I2C=m
# CONFIG_TOUCHSCREEN_MAX11801 is not set
CONFIG_TOUCHSCREEN_MCS5000=m
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
CONFIG_TOUCHSCREEN_MSG2638=m
CONFIG_TOUCHSCREEN_MTOUCH=m
CONFIG_TOUCHSCREEN_IMAGIS=m
# CONFIG_TOUCHSCREEN_INEXIO is not set
CONFIG_TOUCHSCREEN_MK712=m
CONFIG_TOUCHSCREEN_PENMOUNT=m
CONFIG_TOUCHSCREEN_EDT_FT5X06=m
CONFIG_TOUCHSCREEN_TOUCHRIGHT=m
CONFIG_TOUCHSCREEN_TOUCHWIN=m
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=m
CONFIG_TOUCHSCREEN_PIXCIR=m
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_WM97XX is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
CONFIG_TOUCHSCREEN_MC13783=m
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
CONFIG_TOUCHSCREEN_TSC_SERIO=m
CONFIG_TOUCHSCREEN_TSC200X_CORE=m
CONFIG_TOUCHSCREEN_TSC2004=m
CONFIG_TOUCHSCREEN_TSC2007=m
CONFIG_TOUCHSCREEN_RM_TS=m
# CONFIG_TOUCHSCREEN_SILEAD is not set
CONFIG_TOUCHSCREEN_SIS_I2C=m
CONFIG_TOUCHSCREEN_ST1232=m
CONFIG_TOUCHSCREEN_STMFTS=m
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
CONFIG_TOUCHSCREEN_ZET6223=m
CONFIG_TOUCHSCREEN_ZFORCE=m
CONFIG_TOUCHSCREEN_ROHM_BU21023=m
# CONFIG_TOUCHSCREEN_IQS5XX is not set
# CONFIG_TOUCHSCREEN_ZINITIX is not set
CONFIG_INPUT_MISC=y
CONFIG_INPUT_88PM80X_ONKEY=m
CONFIG_INPUT_AD714X=m
CONFIG_INPUT_AD714X_I2C=m
CONFIG_INPUT_ATC260X_ONKEY=m
CONFIG_INPUT_BMA150=m
CONFIG_INPUT_E3X0_BUTTON=m
# CONFIG_INPUT_MC13783_PWRBUTTON is not set
CONFIG_INPUT_MMA8450=m
CONFIG_INPUT_APANEL=m
CONFIG_INPUT_GPIO_BEEPER=m
# CONFIG_INPUT_GPIO_DECODER is not set
CONFIG_INPUT_GPIO_VIBRA=m
# CONFIG_INPUT_ATLAS_BTNS is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
CONFIG_INPUT_KXTJ9=m
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
CONFIG_INPUT_REGULATOR_HAPTIC=m
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF50633_PMU is not set
CONFIG_INPUT_PCF8574=m
CONFIG_INPUT_PWM_BEEPER=m
CONFIG_INPUT_PWM_VIBRA=m
CONFIG_INPUT_GPIO_ROTARY_ENCODER=m
CONFIG_INPUT_DA7280_HAPTICS=m
# CONFIG_INPUT_DA9063_ONKEY is not set
CONFIG_INPUT_ADXL34X=m
CONFIG_INPUT_ADXL34X_I2C=m
# CONFIG_INPUT_IQS269A is not set
CONFIG_INPUT_IQS626A=m
CONFIG_INPUT_IQS7222=m
CONFIG_INPUT_CMA3000=m
# CONFIG_INPUT_CMA3000_I2C is not set
# CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
CONFIG_INPUT_DRV2667_HAPTICS=m
CONFIG_INPUT_RAVE_SP_PWRBUTTON=m
# CONFIG_RMI4_CORE is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
# CONFIG_SERIO_CT82C710 is not set
# CONFIG_SERIO_PARKBD is not set
# CONFIG_SERIO_PCIPS2 is not set
CONFIG_SERIO_LIBPS2=y
CONFIG_SERIO_RAW=y
CONFIG_SERIO_ALTERA_PS2=y
CONFIG_SERIO_PS2MULT=y
CONFIG_SERIO_ARC_PS2=m
CONFIG_SERIO_GPIO_PS2=y
CONFIG_USERIO=y
CONFIG_GAMEPORT=y
CONFIG_GAMEPORT_NS558=m
# CONFIG_GAMEPORT_L4 is not set
# CONFIG_GAMEPORT_EMU10K1 is not set
# CONFIG_GAMEPORT_FM801 is not set
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=y
# CONFIG_VT is not set
CONFIG_UNIX98_PTYS=y
# CONFIG_LEGACY_PTYS is not set
# CONFIG_LDISC_AUTOLOAD is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
CONFIG_SERIAL_8250_PNP=y
CONFIG_SERIAL_8250_16550A_VARIANTS=y
# CONFIG_SERIAL_8250_FINTEK is not set
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_PCI=y
CONFIG_SERIAL_8250_EXAR=y
CONFIG_SERIAL_8250_CS=m
CONFIG_SERIAL_8250_MEN_MCB=m
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
CONFIG_SERIAL_8250_DWLIB=y
CONFIG_SERIAL_8250_DW=m
# CONFIG_SERIAL_8250_RT288X is not set
CONFIG_SERIAL_8250_LPSS=y
CONFIG_SERIAL_8250_MID=y
CONFIG_SERIAL_8250_PERICOM=y

#
# Non-8250 serial port support
#
CONFIG_SERIAL_UARTLITE=y
# CONFIG_SERIAL_UARTLITE_CONSOLE is not set
CONFIG_SERIAL_UARTLITE_NR_UARTS=1
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
# CONFIG_SERIAL_JSM is not set
# CONFIG_SERIAL_LANTIQ is not set
# CONFIG_SERIAL_SCCNXP is not set
CONFIG_SERIAL_SC16IS7XX=m
# CONFIG_SERIAL_SC16IS7XX_I2C is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
CONFIG_SERIAL_ALTERA_UART=y
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=115200
CONFIG_SERIAL_ALTERA_UART_CONSOLE=y
CONFIG_SERIAL_ARC=m
CONFIG_SERIAL_ARC_NR_PORTS=1
# CONFIG_SERIAL_RP2 is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_FSL_LINFLEXUART is not set
# CONFIG_SERIAL_MEN_Z135 is not set
# CONFIG_SERIAL_SPRD is not set
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=y
CONFIG_SERIAL_NONSTANDARD=y
# CONFIG_MOXA_INTELLIO is not set
# CONFIG_MOXA_SMARTIO is not set
# CONFIG_SYNCLINK_GT is not set
CONFIG_N_HDLC=y
CONFIG_GOLDFISH_TTY=m
# CONFIG_N_GSM is not set
# CONFIG_NOZOMI is not set
CONFIG_NULL_TTY=m
CONFIG_HVC_DRIVER=y
CONFIG_RPMSG_TTY=y
CONFIG_SERIAL_DEV_BUS=m
CONFIG_TTY_PRINTK=y
CONFIG_TTY_PRINTK_LEVEL=6
CONFIG_PRINTER=m
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=m
CONFIG_VIRTIO_CONSOLE=y
CONFIG_IPMI_HANDLER=y
CONFIG_IPMI_DMI_DECODE=y
CONFIG_IPMI_PLAT_DATA=y
CONFIG_IPMI_PANIC_EVENT=y
CONFIG_IPMI_PANIC_STRING=y
CONFIG_IPMI_DEVICE_INTERFACE=m
# CONFIG_IPMI_SI is not set
CONFIG_IPMI_SSIF=m
CONFIG_IPMI_IPMB=m
CONFIG_IPMI_WATCHDOG=y
CONFIG_IPMI_POWEROFF=m
# CONFIG_IPMB_DEVICE_INTERFACE is not set
CONFIG_HW_RANDOM=m
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_INTEL=m
# CONFIG_HW_RANDOM_AMD is not set
CONFIG_HW_RANDOM_BA431=m
CONFIG_HW_RANDOM_VIA=m
CONFIG_HW_RANDOM_VIRTIO=m
CONFIG_HW_RANDOM_XIPHERA=m
# CONFIG_APPLICOM is not set

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=m
CONFIG_CARDMAN_4000=m
CONFIG_CARDMAN_4040=m
CONFIG_SCR24X=m
# CONFIG_IPWIRELESS is not set
# end of PCMCIA character devices

CONFIG_MWAVE=y
CONFIG_DEVMEM=y
CONFIG_NVRAM=m
CONFIG_DEVPORT=y
# CONFIG_HPET is not set
CONFIG_HANGCHECK_TIMER=y
# CONFIG_TCG_TPM is not set
CONFIG_TELCLOCK=m
# CONFIG_XILLYBUS is not set
CONFIG_RANDOM_TRUST_CPU=y
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set
# end of Character devices

#
# I2C support
#
CONFIG_I2C=m
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
# CONFIG_I2C_CHARDEV is not set
CONFIG_I2C_MUX=m

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_MUX_GPIO=m
# CONFIG_I2C_MUX_LTC4306 is not set
CONFIG_I2C_MUX_PCA9541=m
CONFIG_I2C_MUX_PCA954x=m
CONFIG_I2C_MUX_REG=m
CONFIG_I2C_MUX_MLXCPLD=m
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_SMBUS=m
CONFIG_I2C_ALGOBIT=m
CONFIG_I2C_ALGOPCA=m

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
# CONFIG_I2C_ALI1535 is not set
# CONFIG_I2C_ALI1563 is not set
# CONFIG_I2C_ALI15X3 is not set
# CONFIG_I2C_AMD756 is not set
# CONFIG_I2C_AMD8111 is not set
# CONFIG_I2C_AMD_MP2 is not set
# CONFIG_I2C_I801 is not set
# CONFIG_I2C_ISCH is not set
# CONFIG_I2C_ISMT is not set
# CONFIG_I2C_PIIX4 is not set
# CONFIG_I2C_NFORCE2 is not set
# CONFIG_I2C_NVIDIA_GPU is not set
# CONFIG_I2C_SIS5595 is not set
# CONFIG_I2C_SIS630 is not set
# CONFIG_I2C_SIS96X is not set
# CONFIG_I2C_VIA is not set
# CONFIG_I2C_VIAPRO is not set

#
# ACPI drivers
#
# CONFIG_I2C_SCMI is not set

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=m
CONFIG_I2C_DESIGNWARE_CORE=m
# CONFIG_I2C_DESIGNWARE_SLAVE is not set
CONFIG_I2C_DESIGNWARE_PLATFORM=m
# CONFIG_I2C_DESIGNWARE_AMDPSP is not set
# CONFIG_I2C_DESIGNWARE_PCI is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_GPIO=m
CONFIG_I2C_GPIO_FAULT_INJECTOR=y
# CONFIG_I2C_KEMPLD is not set
# CONFIG_I2C_OCORES is not set
CONFIG_I2C_PCA_PLATFORM=m
# CONFIG_I2C_SIMTEC is not set
CONFIG_I2C_XILINX=m

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_PARPORT is not set
CONFIG_I2C_TAOS_EVM=m

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=m
CONFIG_I2C_VIRTIO=m
# end of I2C Hardware Bus support

# CONFIG_I2C_STUB is not set
CONFIG_I2C_SLAVE=y
CONFIG_I2C_SLAVE_EEPROM=m
# CONFIG_I2C_SLAVE_TESTUNIT is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=m
CONFIG_CDNS_I3C_MASTER=m
CONFIG_DW_I3C_MASTER=m
# CONFIG_SVC_I3C_MASTER is not set
CONFIG_MIPI_I3C_HCI=m
# CONFIG_SPI is not set
# CONFIG_SPMI is not set
CONFIG_HSI=m
CONFIG_HSI_BOARDINFO=y

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=m
CONFIG_PPS=y
# CONFIG_PPS_DEBUG is not set
# CONFIG_NTP_PPS is not set

#
# PPS clients support
#
# CONFIG_PPS_CLIENT_KTIMER is not set
CONFIG_PPS_CLIENT_LDISC=m
CONFIG_PPS_CLIENT_PARPORT=m
CONFIG_PPS_CLIENT_GPIO=m

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=y
CONFIG_PTP_1588_CLOCK_OPTIONAL=y

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PTP_1588_CLOCK_KVM=y
# CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
# CONFIG_PTP_1588_CLOCK_IDTCM is not set
# CONFIG_PTP_1588_CLOCK_VMW is not set
# CONFIG_PTP_1588_CLOCK_OCP is not set
# end of PTP clock support

CONFIG_PINCTRL=y
CONFIG_PINMUX=y
CONFIG_PINCONF=y
CONFIG_GENERIC_PINCONF=y
CONFIG_DEBUG_PINCTRL=y
# CONFIG_PINCTRL_AMD is not set
CONFIG_PINCTRL_DA9062=m
# CONFIG_PINCTRL_MCP23S08 is not set
CONFIG_PINCTRL_MADERA=m
CONFIG_PINCTRL_CS47L15=y
CONFIG_PINCTRL_CS47L35=y
CONFIG_PINCTRL_CS47L85=y
CONFIG_PINCTRL_CS47L90=y

#
# Intel pinctrl drivers
#
# CONFIG_PINCTRL_BAYTRAIL is not set
# CONFIG_PINCTRL_CHERRYVIEW is not set
# CONFIG_PINCTRL_LYNXPOINT is not set
# CONFIG_PINCTRL_ALDERLAKE is not set
# CONFIG_PINCTRL_BROXTON is not set
# CONFIG_PINCTRL_CANNONLAKE is not set
# CONFIG_PINCTRL_CEDARFORK is not set
# CONFIG_PINCTRL_DENVERTON is not set
# CONFIG_PINCTRL_ELKHARTLAKE is not set
# CONFIG_PINCTRL_EMMITSBURG is not set
# CONFIG_PINCTRL_GEMINILAKE is not set
# CONFIG_PINCTRL_ICELAKE is not set
# CONFIG_PINCTRL_JASPERLAKE is not set
# CONFIG_PINCTRL_LAKEFIELD is not set
# CONFIG_PINCTRL_LEWISBURG is not set
# CONFIG_PINCTRL_SUNRISEPOINT is not set
# CONFIG_PINCTRL_TIGERLAKE is not set
# end of Intel pinctrl drivers

#
# Renesas pinctrl drivers
#
# end of Renesas pinctrl drivers

CONFIG_GPIOLIB=y
CONFIG_GPIOLIB_FASTPATH_LIMIT=512
CONFIG_GPIO_ACPI=y
CONFIG_GPIOLIB_IRQCHIP=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y
CONFIG_GPIO_CDEV=y
# CONFIG_GPIO_CDEV_V1 is not set
CONFIG_GPIO_MAX730X=m

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_AMDPT is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EXAR is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
CONFIG_GPIO_MB86S7X=y
# CONFIG_GPIO_MENZ127 is not set
# CONFIG_GPIO_VX855 is not set
# CONFIG_GPIO_AMD_FCH is not set
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_104_DIO_48E=y
# CONFIG_GPIO_104_IDIO_16 is not set
CONFIG_GPIO_104_IDI_48=m
CONFIG_GPIO_F7188X=m
# CONFIG_GPIO_GPIO_MM is not set
CONFIG_GPIO_IT87=y
CONFIG_GPIO_SCH311X=m
# CONFIG_GPIO_WINBOND is not set
CONFIG_GPIO_WS16C48=m
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
CONFIG_GPIO_MAX7300=m
# CONFIG_GPIO_MAX732X is not set
CONFIG_GPIO_PCA953X=m
# CONFIG_GPIO_PCA953X_IRQ is not set
CONFIG_GPIO_PCA9570=m
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_TPIC2810 is not set
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_KEMPLD=m
# CONFIG_GPIO_MADERA is not set
CONFIG_GPIO_TPS65086=m
CONFIG_GPIO_TPS65912=m
CONFIG_GPIO_TQMX86=m
# CONFIG_GPIO_WM8994 is not set
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
# CONFIG_GPIO_AMD8111 is not set
# CONFIG_GPIO_BT8XX is not set
# CONFIG_GPIO_ML_IOH is not set
# CONFIG_GPIO_PCI_IDIO_16 is not set
# CONFIG_GPIO_PCIE_IDIO_24 is not set
# CONFIG_GPIO_RDC321X is not set
# end of PCI GPIO expanders

#
# Virtual GPIO drivers
#
CONFIG_GPIO_AGGREGATOR=y
# CONFIG_GPIO_MOCKUP is not set
CONFIG_GPIO_VIRTIO=y
# CONFIG_GPIO_SIM is not set
# end of Virtual GPIO drivers

CONFIG_W1=y

#
# 1-wire Bus Masters
#
# CONFIG_W1_MASTER_MATROX is not set
CONFIG_W1_MASTER_DS2482=m
# CONFIG_W1_MASTER_DS1WM is not set
CONFIG_W1_MASTER_GPIO=y
# CONFIG_W1_MASTER_SGI is not set
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=y
CONFIG_W1_SLAVE_SMEM=m
# CONFIG_W1_SLAVE_DS2405 is not set
CONFIG_W1_SLAVE_DS2408=m
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=m
# CONFIG_W1_SLAVE_DS2406 is not set
CONFIG_W1_SLAVE_DS2423=y
CONFIG_W1_SLAVE_DS2805=m
CONFIG_W1_SLAVE_DS2430=m
# CONFIG_W1_SLAVE_DS2431 is not set
CONFIG_W1_SLAVE_DS2433=y
CONFIG_W1_SLAVE_DS2433_CRC=y
# CONFIG_W1_SLAVE_DS2438 is not set
# CONFIG_W1_SLAVE_DS250X is not set
# CONFIG_W1_SLAVE_DS2780 is not set
CONFIG_W1_SLAVE_DS2781=y
CONFIG_W1_SLAVE_DS28E04=m
CONFIG_W1_SLAVE_DS28E17=m
# end of 1-wire Slaves

CONFIG_POWER_RESET=y
CONFIG_POWER_RESET_ATC260X=m
CONFIG_POWER_RESET_MT6323=y
# CONFIG_POWER_RESET_RESTART is not set
# CONFIG_POWER_RESET_TPS65086 is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_POWER_SUPPLY_HWMON is not set
CONFIG_PDA_POWER=y
CONFIG_IP5XXX_POWER=m
# CONFIG_TEST_POWER is not set
CONFIG_CHARGER_ADP5061=m
CONFIG_BATTERY_CW2015=m
CONFIG_BATTERY_DS2760=y
# CONFIG_BATTERY_DS2780 is not set
CONFIG_BATTERY_DS2781=y
CONFIG_BATTERY_DS2782=m
# CONFIG_BATTERY_SAMSUNG_SDI is not set
CONFIG_BATTERY_SBS=m
CONFIG_CHARGER_SBS=m
CONFIG_MANAGER_SBS=m
CONFIG_BATTERY_BQ27XXX=m
CONFIG_BATTERY_BQ27XXX_I2C=m
CONFIG_BATTERY_BQ27XXX_HDQ=m
CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM=y
# CONFIG_BATTERY_DA9150 is not set
# CONFIG_BATTERY_MAX17040 is not set
CONFIG_BATTERY_MAX17042=m
CONFIG_BATTERY_MAX1721X=y
CONFIG_CHARGER_PCF50633=m
CONFIG_CHARGER_MAX8903=m
CONFIG_CHARGER_LP8727=m
CONFIG_CHARGER_GPIO=m
CONFIG_CHARGER_MANAGER=y
# CONFIG_CHARGER_LT3651 is not set
# CONFIG_CHARGER_LTC4162L is not set
# CONFIG_CHARGER_MAX14577 is not set
CONFIG_CHARGER_MAX77976=m
CONFIG_CHARGER_MT6360=m
CONFIG_CHARGER_BQ2415X=m
CONFIG_CHARGER_BQ24190=m
CONFIG_CHARGER_BQ24257=m
CONFIG_CHARGER_BQ24735=m
# CONFIG_CHARGER_BQ2515X is not set
CONFIG_CHARGER_BQ25890=m
CONFIG_CHARGER_BQ25980=m
CONFIG_CHARGER_BQ256XX=m
CONFIG_CHARGER_SMB347=m
CONFIG_BATTERY_GAUGE_LTC2941=m
CONFIG_BATTERY_GOLDFISH=m
CONFIG_BATTERY_RT5033=m
CONFIG_CHARGER_RT9455=m
CONFIG_CHARGER_BD99954=m
CONFIG_BATTERY_UG3105=m
CONFIG_HWMON=y
CONFIG_HWMON_VID=y
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=y
# CONFIG_SENSORS_ABITUGURU3 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
CONFIG_SENSORS_ADM1021=m
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
CONFIG_SENSORS_ADM1029=m
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM1177 is not set
CONFIG_SENSORS_ADM9240=m
CONFIG_SENSORS_ADT7X10=m
CONFIG_SENSORS_ADT7410=m
# CONFIG_SENSORS_ADT7411 is not set
CONFIG_SENSORS_ADT7462=m
CONFIG_SENSORS_ADT7470=m
# CONFIG_SENSORS_ADT7475 is not set
CONFIG_SENSORS_AHT10=m
CONFIG_SENSORS_AS370=y
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_AXI_FAN_CONTROL is not set
# CONFIG_SENSORS_K8TEMP is not set
# CONFIG_SENSORS_K10TEMP is not set
# CONFIG_SENSORS_FAM15H_POWER is not set
CONFIG_SENSORS_APPLESMC=m
CONFIG_SENSORS_ASB100=m
CONFIG_SENSORS_ASPEED=y
CONFIG_SENSORS_ATXP1=m
CONFIG_SENSORS_CORSAIR_CPRO=m
CONFIG_SENSORS_CORSAIR_PSU=m
CONFIG_SENSORS_DS620=m
# CONFIG_SENSORS_DS1621 is not set
CONFIG_SENSORS_DELL_SMM=y
# CONFIG_I8K is not set
# CONFIG_SENSORS_I5K_AMB is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
CONFIG_SENSORS_F75375S=m
CONFIG_SENSORS_MC13783_ADC=m
CONFIG_SENSORS_FSCHMD=m
CONFIG_SENSORS_FTSTEUTATES=m
CONFIG_SENSORS_GL518SM=m
CONFIG_SENSORS_GL520SM=m
CONFIG_SENSORS_G760A=m
CONFIG_SENSORS_G762=m
CONFIG_SENSORS_HIH6130=m
# CONFIG_SENSORS_IBMAEM is not set
# CONFIG_SENSORS_IBMPEX is not set
# CONFIG_SENSORS_I5500 is not set
CONFIG_SENSORS_CORETEMP=y
CONFIG_SENSORS_IT87=y
CONFIG_SENSORS_JC42=m
CONFIG_SENSORS_POWR1220=m
CONFIG_SENSORS_LINEAGE=m
CONFIG_SENSORS_LTC2945=m
CONFIG_SENSORS_LTC2947=m
CONFIG_SENSORS_LTC2947_I2C=m
CONFIG_SENSORS_LTC2990=m
CONFIG_SENSORS_LTC2992=m
# CONFIG_SENSORS_LTC4151 is not set
CONFIG_SENSORS_LTC4215=m
CONFIG_SENSORS_LTC4222=m
CONFIG_SENSORS_LTC4245=m
CONFIG_SENSORS_LTC4260=m
CONFIG_SENSORS_LTC4261=m
# CONFIG_SENSORS_MAX127 is not set
CONFIG_SENSORS_MAX16065=m
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
CONFIG_SENSORS_MAX197=m
# CONFIG_SENSORS_MAX31730 is not set
CONFIG_SENSORS_MAX6620=m
CONFIG_SENSORS_MAX6621=m
CONFIG_SENSORS_MAX6639=m
# CONFIG_SENSORS_MAX6642 is not set
CONFIG_SENSORS_MAX6650=m
CONFIG_SENSORS_MAX6697=m
CONFIG_SENSORS_MAX31790=m
CONFIG_SENSORS_MCP3021=m
# CONFIG_SENSORS_TC654 is not set
CONFIG_SENSORS_TPS23861=m
CONFIG_SENSORS_MENF21BMC_HWMON=m
CONFIG_SENSORS_MR75203=m
CONFIG_SENSORS_LM63=m
# CONFIG_SENSORS_LM73 is not set
CONFIG_SENSORS_LM75=m
CONFIG_SENSORS_LM77=m
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
CONFIG_SENSORS_LM87=m
# CONFIG_SENSORS_LM90 is not set
CONFIG_SENSORS_LM92=m
CONFIG_SENSORS_LM93=m
CONFIG_SENSORS_LM95234=m
CONFIG_SENSORS_LM95241=m
CONFIG_SENSORS_LM95245=m
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NCT6683=y
CONFIG_SENSORS_NCT6775_CORE=m
# CONFIG_SENSORS_NCT6775 is not set
CONFIG_SENSORS_NCT6775_I2C=m
CONFIG_SENSORS_NCT7802=m
# CONFIG_SENSORS_NCT7904 is not set
CONFIG_SENSORS_NPCM7XX=m
CONFIG_SENSORS_PCF8591=m
# CONFIG_SENSORS_PECI_CPUTEMP is not set
CONFIG_SENSORS_PECI_DIMMTEMP=m
CONFIG_SENSORS_PECI=m
# CONFIG_PMBUS is not set
# CONFIG_SENSORS_SBTSI is not set
CONFIG_SENSORS_SBRMI=m
CONFIG_SENSORS_SHT15=y
CONFIG_SENSORS_SHT21=m
# CONFIG_SENSORS_SHT3x is not set
# CONFIG_SENSORS_SHT4x is not set
CONFIG_SENSORS_SHTC1=m
# CONFIG_SENSORS_SIS5595 is not set
CONFIG_SENSORS_SY7636A=m
CONFIG_SENSORS_DME1737=m
CONFIG_SENSORS_EMC1403=m
CONFIG_SENSORS_EMC2103=m
CONFIG_SENSORS_EMC6W201=m
# CONFIG_SENSORS_SMSC47M1 is not set
CONFIG_SENSORS_SMSC47M192=m
CONFIG_SENSORS_SMSC47B397=y
CONFIG_SENSORS_SCH56XX_COMMON=y
CONFIG_SENSORS_SCH5627=y
# CONFIG_SENSORS_SCH5636 is not set
CONFIG_SENSORS_STTS751=m
CONFIG_SENSORS_SMM665=m
CONFIG_SENSORS_ADC128D818=m
CONFIG_SENSORS_ADS7828=m
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
# CONFIG_SENSORS_INA2XX is not set
# CONFIG_SENSORS_INA238 is not set
# CONFIG_SENSORS_INA3221 is not set
CONFIG_SENSORS_TC74=m
# CONFIG_SENSORS_THMC50 is not set
CONFIG_SENSORS_TMP102=m
CONFIG_SENSORS_TMP103=m
CONFIG_SENSORS_TMP108=m
# CONFIG_SENSORS_TMP401 is not set
CONFIG_SENSORS_TMP421=m
CONFIG_SENSORS_TMP464=m
# CONFIG_SENSORS_TMP513 is not set
CONFIG_SENSORS_VIA_CPUTEMP=m
# CONFIG_SENSORS_VIA686A is not set
CONFIG_SENSORS_VT1211=y
# CONFIG_SENSORS_VT8231 is not set
CONFIG_SENSORS_W83773G=m
# CONFIG_SENSORS_W83781D is not set
CONFIG_SENSORS_W83791D=m
# CONFIG_SENSORS_W83792D is not set
CONFIG_SENSORS_W83793=m
# CONFIG_SENSORS_W83795 is not set
CONFIG_SENSORS_W83L785TS=m
# CONFIG_SENSORS_W83L786NG is not set
CONFIG_SENSORS_W83627HF=m
CONFIG_SENSORS_W83627EHF=y

#
# ACPI drivers
#
# CONFIG_SENSORS_ACPI_POWER is not set
# CONFIG_SENSORS_ATK0110 is not set
# CONFIG_SENSORS_ASUS_EC is not set
CONFIG_THERMAL=y
# CONFIG_THERMAL_NETLINK is not set
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_WRITABLE_TRIPS=y
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
CONFIG_THERMAL_GOV_USER_SPACE=y
# CONFIG_DEVFREQ_THERMAL is not set
# CONFIG_THERMAL_EMULATION is not set

#
# Intel thermal drivers
#
# CONFIG_INTEL_POWERCLAMP is not set
CONFIG_X86_THERMAL_VECTOR=y
CONFIG_X86_PKG_TEMP_THERMAL=m
# CONFIG_INTEL_SOC_DTS_THERMAL is not set

#
# ACPI INT340X thermal drivers
#
# CONFIG_INT340X_THERMAL is not set
# end of ACPI INT340X thermal drivers

# CONFIG_INTEL_PCH_THERMAL is not set
# CONFIG_INTEL_TCC_COOLING is not set
# CONFIG_INTEL_MENLOW is not set
# CONFIG_INTEL_HFI_THERMAL is not set
# end of Intel thermal drivers

CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
CONFIG_WATCHDOG_NOWAYOUT=y
# CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED is not set
CONFIG_WATCHDOG_OPEN_TIMEOUT=0
CONFIG_WATCHDOG_SYSFS=y
# CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set

#
# Watchdog Pretimeout Governors
#
# CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=m
CONFIG_DA9062_WATCHDOG=m
CONFIG_MENF21BMC_WATCHDOG=m
CONFIG_MENZ069_WATCHDOG=m
# CONFIG_WDAT_WDT is not set
CONFIG_XILINX_WATCHDOG=m
# CONFIG_ZIIRAVE_WATCHDOG is not set
CONFIG_RAVE_SP_WATCHDOG=m
CONFIG_CADENCE_WATCHDOG=y
CONFIG_DW_WATCHDOG=y
CONFIG_MAX63XX_WATCHDOG=y
# CONFIG_ACQUIRE_WDT is not set
# CONFIG_ADVANTECH_WDT is not set
# CONFIG_ALIM1535_WDT is not set
# CONFIG_ALIM7101_WDT is not set
CONFIG_EBC_C384_WDT=m
# CONFIG_F71808E_WDT is not set
# CONFIG_SP5100_TCO is not set
CONFIG_SBC_FITPC2_WATCHDOG=y
# CONFIG_EUROTECH_WDT is not set
CONFIG_IB700_WDT=m
CONFIG_IBMASR=y
CONFIG_WAFER_WDT=m
# CONFIG_I6300ESB_WDT is not set
# CONFIG_IE6XX_WDT is not set
# CONFIG_ITCO_WDT is not set
CONFIG_IT8712F_WDT=y
CONFIG_IT87_WDT=y
# CONFIG_HP_WATCHDOG is not set
# CONFIG_KEMPLD_WDT is not set
CONFIG_SC1200_WDT=m
CONFIG_PC87413_WDT=y
# CONFIG_NV_TCO is not set
CONFIG_60XX_WDT=y
CONFIG_CPU5_WDT=y
CONFIG_SMSC_SCH311X_WDT=y
CONFIG_SMSC37B787_WDT=y
CONFIG_TQMX86_WDT=y
# CONFIG_VIA_WDT is not set
CONFIG_W83627HF_WDT=m
# CONFIG_W83877F_WDT is not set
# CONFIG_W83977F_WDT is not set
# CONFIG_MACHZ_WDT is not set
CONFIG_SBC_EPX_C3_WATCHDOG=m
# CONFIG_NI903X_WDT is not set
# CONFIG_NIC7018_WDT is not set
# CONFIG_MEN_A21_WDT is not set

#
# PCI-based Watchdog Cards
#
# CONFIG_PCIPCWATCHDOG is not set
# CONFIG_WDTPCI is not set
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB=m
CONFIG_SSB_SPROM=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_PCIHOST=y
CONFIG_SSB_PCMCIAHOST_POSSIBLE=y
CONFIG_SSB_PCMCIAHOST=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
# CONFIG_SSB_DRIVER_PCICORE is not set
CONFIG_SSB_DRIVER_GPIO=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_BCMA_HOST_PCI=y
CONFIG_BCMA_HOST_SOC=y
CONFIG_BCMA_DRIVER_PCI=y
CONFIG_BCMA_SFLASH=y
# CONFIG_BCMA_DRIVER_GMAC_CMN is not set
# CONFIG_BCMA_DRIVER_GPIO is not set
CONFIG_BCMA_DEBUG=y

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_BD9571MWV is not set
# CONFIG_MFD_AXP20X_I2C is not set
CONFIG_MFD_MADERA=m
CONFIG_MFD_MADERA_I2C=m
CONFIG_MFD_CS47L15=y
CONFIG_MFD_CS47L35=y
CONFIG_MFD_CS47L85=y
CONFIG_MFD_CS47L90=y
# CONFIG_MFD_CS47L92 is not set
CONFIG_MFD_DA9062=m
# CONFIG_MFD_DA9063 is not set
CONFIG_MFD_DA9150=m
CONFIG_MFD_MC13XXX=m
CONFIG_MFD_MC13XXX_I2C=m
CONFIG_MFD_MP2629=m
# CONFIG_HTC_PASIC3 is not set
# CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
# CONFIG_LPC_ICH is not set
# CONFIG_LPC_SCH is not set
# CONFIG_MFD_INTEL_LPSS_ACPI is not set
# CONFIG_MFD_INTEL_LPSS_PCI is not set
# CONFIG_MFD_IQS62X is not set
# CONFIG_MFD_JANZ_CMODIO is not set
CONFIG_MFD_KEMPLD=y
CONFIG_MFD_88PM800=m
# CONFIG_MFD_88PM805 is not set
CONFIG_MFD_MAX14577=m
# CONFIG_MFD_MAX77693 is not set
CONFIG_MFD_MAX8907=m
CONFIG_MFD_MT6360=m
CONFIG_MFD_MT6397=y
CONFIG_MFD_MENF21BMC=m
# CONFIG_MFD_RETU is not set
CONFIG_MFD_PCF50633=m
CONFIG_PCF50633_ADC=m
# CONFIG_PCF50633_GPIO is not set
# CONFIG_UCB1400_CORE is not set
# CONFIG_MFD_RDC321X is not set
# CONFIG_MFD_RT4831 is not set
# CONFIG_MFD_RT5033 is not set
CONFIG_MFD_SI476X_CORE=m
CONFIG_MFD_SIMPLE_MFD_I2C=m
CONFIG_MFD_SM501=m
CONFIG_MFD_SM501_GPIO=y
# CONFIG_MFD_SKY81452 is not set
CONFIG_MFD_SYSCON=y
CONFIG_MFD_TI_AM335X_TSCADC=y
# CONFIG_MFD_LP3943 is not set
CONFIG_MFD_TI_LMU=m
CONFIG_TPS6105X=m
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65086=m
# CONFIG_MFD_TI_LP873X is not set
CONFIG_MFD_TPS65912=m
CONFIG_MFD_TPS65912_I2C=m
CONFIG_MFD_WL1273_CORE=m
CONFIG_MFD_LM3533=m
CONFIG_MFD_TQMX86=m
# CONFIG_MFD_VX855 is not set
# CONFIG_MFD_ARIZONA_I2C is not set
CONFIG_MFD_WM8994=m
# CONFIG_MFD_WCD934X is not set
CONFIG_MFD_ATC260X=m
CONFIG_MFD_ATC260X_I2C=m
CONFIG_RAVE_SP_CORE=m
# end of Multifunction device drivers

CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
CONFIG_REGULATOR_VIRTUAL_CONSUMER=y
CONFIG_REGULATOR_USERSPACE_CONSUMER=y
CONFIG_REGULATOR_88PG86X=m
# CONFIG_REGULATOR_88PM800 is not set
CONFIG_REGULATOR_ACT8865=m
CONFIG_REGULATOR_AD5398=m
CONFIG_REGULATOR_ARIZONA_LDO1=m
CONFIG_REGULATOR_ARIZONA_MICSUPP=m
CONFIG_REGULATOR_ATC260X=m
CONFIG_REGULATOR_DA9062=m
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
CONFIG_REGULATOR_FAN53555=m
CONFIG_REGULATOR_GPIO=m
CONFIG_REGULATOR_ISL9305=m
# CONFIG_REGULATOR_ISL6271A is not set
CONFIG_REGULATOR_LM363X=m
CONFIG_REGULATOR_LP3971=m
CONFIG_REGULATOR_LP3972=m
CONFIG_REGULATOR_LP872X=m
# CONFIG_REGULATOR_LP8755 is not set
CONFIG_REGULATOR_LTC3589=m
CONFIG_REGULATOR_LTC3676=m
# CONFIG_REGULATOR_MAX14577 is not set
# CONFIG_REGULATOR_MAX1586 is not set
CONFIG_REGULATOR_MAX8649=m
# CONFIG_REGULATOR_MAX8660 is not set
CONFIG_REGULATOR_MAX8893=m
# CONFIG_REGULATOR_MAX8907 is not set
CONFIG_REGULATOR_MAX8952=m
# CONFIG_REGULATOR_MAX20086 is not set
CONFIG_REGULATOR_MAX77826=m
CONFIG_REGULATOR_MC13XXX_CORE=m
CONFIG_REGULATOR_MC13783=m
CONFIG_REGULATOR_MC13892=m
CONFIG_REGULATOR_MP8859=m
CONFIG_REGULATOR_MT6311=m
CONFIG_REGULATOR_MT6323=m
CONFIG_REGULATOR_MT6358=y
CONFIG_REGULATOR_MT6359=y
CONFIG_REGULATOR_MT6360=m
CONFIG_REGULATOR_MT6397=y
CONFIG_REGULATOR_PCA9450=m
CONFIG_REGULATOR_PCF50633=m
CONFIG_REGULATOR_PV88060=m
# CONFIG_REGULATOR_PV88080 is not set
CONFIG_REGULATOR_PV88090=m
CONFIG_REGULATOR_PWM=m
# CONFIG_REGULATOR_RT4801 is not set
CONFIG_REGULATOR_RT5190A=m
# CONFIG_REGULATOR_RT5759 is not set
CONFIG_REGULATOR_RT6160=m
CONFIG_REGULATOR_RT6245=m
CONFIG_REGULATOR_RTQ2134=m
CONFIG_REGULATOR_RTMV20=m
CONFIG_REGULATOR_RTQ6752=m
CONFIG_REGULATOR_SLG51000=m
# CONFIG_REGULATOR_SY7636A is not set
CONFIG_REGULATOR_TPS51632=m
CONFIG_REGULATOR_TPS6105X=m
CONFIG_REGULATOR_TPS62360=m
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
# CONFIG_REGULATOR_TPS65086 is not set
CONFIG_REGULATOR_TPS65132=m
# CONFIG_REGULATOR_TPS65912 is not set
CONFIG_REGULATOR_WM8994=m
CONFIG_RC_CORE=m
# CONFIG_LIRC is not set
CONFIG_RC_MAP=m
# CONFIG_RC_DECODERS is not set
# CONFIG_RC_DEVICES is not set
CONFIG_CEC_CORE=m

#
# CEC support
#
# CONFIG_MEDIA_CEC_RC is not set
# CONFIG_MEDIA_CEC_SUPPORT is not set
# end of CEC support

CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_SUPPORT_FILTER=y
# CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set

#
# Media device types
#
# CONFIG_MEDIA_CAMERA_SUPPORT is not set
# CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
# CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
CONFIG_MEDIA_RADIO_SUPPORT=y
# CONFIG_MEDIA_SDR_SUPPORT is not set
CONFIG_MEDIA_PLATFORM_SUPPORT=y
# CONFIG_MEDIA_TEST_SUPPORT is not set
# end of Media device types

CONFIG_VIDEO_DEV=m
CONFIG_MEDIA_CONTROLLER=y

#
# Video4Linux options
#
CONFIG_VIDEO_V4L2_I2C=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y
CONFIG_VIDEO_ADV_DEBUG=y
CONFIG_VIDEO_FIXED_MINOR_RANGES=y
CONFIG_V4L2_FLASH_LED_CLASS=m
CONFIG_V4L2_FWNODE=m
CONFIG_V4L2_ASYNC=m
# end of Video4Linux options

#
# Media controller options
#
# end of Media controller options

#
# Media drivers
#

#
# Drivers filtered as selected at 'Filter media drivers'
#

#
# Media drivers
#
# CONFIG_MEDIA_PCI_SUPPORT is not set
# CONFIG_RADIO_ADAPTERS is not set
CONFIG_MEDIA_PLATFORM_DRIVERS=y
# CONFIG_V4L_PLATFORM_DRIVERS is not set
# CONFIG_V4L_MEM2MEM_DRIVERS is not set

#
# Allegro DVT media platform drivers
#

#
# Amlogic media platform drivers
#

#
# Amphion drivers
#

#
# Aspeed media platform drivers
#

#
# Atmel media platform drivers
#

#
# Cadence media platform drivers
#
# CONFIG_VIDEO_CADENCE_CSI2RX is not set
CONFIG_VIDEO_CADENCE_CSI2TX=m

#
# Chips&Media media platform drivers
#

#
# Intel media platform drivers
#

#
# Marvell media platform drivers
#

#
# Mediatek media platform drivers
#

#
# NVidia media platform drivers
#

#
# NXP media platform drivers
#

#
# Qualcomm media platform drivers
#

#
# Renesas media platform drivers
#

#
# Rockchip media platform drivers
#

#
# Samsung media platform drivers
#

#
# STMicroelectronics media platform drivers
#

#
# Sunxi media platform drivers
#

#
# Texas Instruments drivers
#

#
# VIA media platform drivers
#

#
# Xilinx media platform drivers
#
CONFIG_VIDEOBUF2_CORE=m
CONFIG_VIDEOBUF2_V4L2=m
CONFIG_VIDEOBUF2_MEMOPS=m
CONFIG_VIDEOBUF2_VMALLOC=m
# end of Media drivers

#
# Media ancillary drivers
#
CONFIG_MEDIA_ATTACH=y
# CONFIG_VIDEO_IR_I2C is not set

#
# Audio decoders, processors and mixers
#
# CONFIG_VIDEO_CS3308 is not set
CONFIG_VIDEO_CS5345=m
# CONFIG_VIDEO_CS53L32A is not set
CONFIG_VIDEO_MSP3400=m
CONFIG_VIDEO_SONY_BTF_MPX=m
CONFIG_VIDEO_TDA1997X=m
# CONFIG_VIDEO_TDA7432 is not set
# CONFIG_VIDEO_TDA9840 is not set
# CONFIG_VIDEO_TEA6415C is not set
# CONFIG_VIDEO_TEA6420 is not set
CONFIG_VIDEO_TLV320AIC23B=m
# CONFIG_VIDEO_TVAUDIO is not set
CONFIG_VIDEO_UDA1342=m
CONFIG_VIDEO_VP27SMPX=m
CONFIG_VIDEO_WM8739=m
# CONFIG_VIDEO_WM8775 is not set
# end of Audio decoders, processors and mixers

#
# RDS decoders
#
# CONFIG_VIDEO_SAA6588 is not set
# end of RDS decoders

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=m
CONFIG_VIDEO_ADV7183=m
CONFIG_VIDEO_ADV7604=m
CONFIG_VIDEO_ADV7604_CEC=y
CONFIG_VIDEO_ADV7842=m
# CONFIG_VIDEO_ADV7842_CEC is not set
CONFIG_VIDEO_BT819=m
CONFIG_VIDEO_BT856=m
CONFIG_VIDEO_BT866=m
CONFIG_VIDEO_KS0127=m
CONFIG_VIDEO_ML86V7667=m
CONFIG_VIDEO_SAA7110=m
CONFIG_VIDEO_SAA711X=m
CONFIG_VIDEO_TC358743=m
CONFIG_VIDEO_TC358743_CEC=y
CONFIG_VIDEO_TVP514X=m
# CONFIG_VIDEO_TVP5150 is not set
CONFIG_VIDEO_TVP7002=m
# CONFIG_VIDEO_TW2804 is not set
# CONFIG_VIDEO_TW9903 is not set
CONFIG_VIDEO_TW9906=m
CONFIG_VIDEO_TW9910=m
# CONFIG_VIDEO_VPX3220 is not set

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=m
# CONFIG_VIDEO_CX25840 is not set
# end of Video decoders

#
# Video encoders
#
# CONFIG_VIDEO_AD9389B is not set
CONFIG_VIDEO_ADV7170=m
CONFIG_VIDEO_ADV7175=m
CONFIG_VIDEO_ADV7343=m
CONFIG_VIDEO_ADV7393=m
CONFIG_VIDEO_ADV7511=m
# CONFIG_VIDEO_ADV7511_CEC is not set
# CONFIG_VIDEO_AK881X is not set
CONFIG_VIDEO_SAA7127=m
# CONFIG_VIDEO_SAA7185 is not set
CONFIG_VIDEO_THS8200=m
# end of Video encoders

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=m
# CONFIG_VIDEO_UPD64083 is not set
# end of Video improvement chips

#
# Audio/Video compression chips
#
# CONFIG_VIDEO_SAA6752HS is not set
# end of Audio/Video compression chips

#
# SDR tuner chips
#
# end of SDR tuner chips

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_I2C=m
# CONFIG_VIDEO_M52790 is not set
CONFIG_VIDEO_ST_MIPID02=m
CONFIG_VIDEO_THS7303=m
# end of Miscellaneous helper chips

CONFIG_MEDIA_TUNER=m

#
# Customize TV tuners
#
# CONFIG_MEDIA_TUNER_E4000 is not set
CONFIG_MEDIA_TUNER_FC0011=m
# CONFIG_MEDIA_TUNER_FC0012 is not set
CONFIG_MEDIA_TUNER_FC0013=m
CONFIG_MEDIA_TUNER_FC2580=m
CONFIG_MEDIA_TUNER_IT913X=m
CONFIG_MEDIA_TUNER_M88RS6000T=m
# CONFIG_MEDIA_TUNER_MAX2165 is not set
# CONFIG_MEDIA_TUNER_MC44S803 is not set
CONFIG_MEDIA_TUNER_MT2060=m
# CONFIG_MEDIA_TUNER_MT2063 is not set
CONFIG_MEDIA_TUNER_MT20XX=m
CONFIG_MEDIA_TUNER_MT2131=m
CONFIG_MEDIA_TUNER_MT2266=m
CONFIG_MEDIA_TUNER_MXL301RF=m
# CONFIG_MEDIA_TUNER_MXL5005S is not set
CONFIG_MEDIA_TUNER_MXL5007T=m
# CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
CONFIG_MEDIA_TUNER_QM1D1C0042=m
# CONFIG_MEDIA_TUNER_QT1010 is not set
CONFIG_MEDIA_TUNER_R820T=m
CONFIG_MEDIA_TUNER_SI2157=m
CONFIG_MEDIA_TUNER_SIMPLE=m
CONFIG_MEDIA_TUNER_TDA18212=m
CONFIG_MEDIA_TUNER_TDA18218=m
CONFIG_MEDIA_TUNER_TDA18250=m
CONFIG_MEDIA_TUNER_TDA18271=m
CONFIG_MEDIA_TUNER_TDA827X=m
CONFIG_MEDIA_TUNER_TDA8290=m
CONFIG_MEDIA_TUNER_TDA9887=m
# CONFIG_MEDIA_TUNER_TEA5761 is not set
CONFIG_MEDIA_TUNER_TEA5767=m
# CONFIG_MEDIA_TUNER_TUA9001 is not set
# CONFIG_MEDIA_TUNER_XC2028 is not set
# CONFIG_MEDIA_TUNER_XC4000 is not set
# CONFIG_MEDIA_TUNER_XC5000 is not set
# end of Customize TV tuners
# end of Media ancillary drivers

#
# Graphics support
#
# CONFIG_AGP is not set
# CONFIG_VGA_SWITCHEROO is not set
# CONFIG_DRM is not set
CONFIG_DRM_DEBUG_MODESET_LOCK=y

#
# ARM devices
#
# end of ARM devices

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=y
CONFIG_FB_NOTIFY=y
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
CONFIG_FB_DEFERRED_IO=y
CONFIG_FB_HECUBA=y
CONFIG_FB_BACKLIGHT=m
CONFIG_FB_MODE_HELPERS=y
CONFIG_FB_TILEBLITTING=y

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
CONFIG_FB_VESA=y
CONFIG_FB_N411=y
CONFIG_FB_HGA=y
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
CONFIG_FB_IBM_GXT4500=m
# CONFIG_FB_GOLDFISH is not set
CONFIG_FB_VIRTUAL=m
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_SIMPLE=y
CONFIG_FB_SSD1307=m
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=y
CONFIG_LCD_PLATFORM=m
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_KTD253=y
# CONFIG_BACKLIGHT_LM3533 is not set
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_APPLE is not set
CONFIG_BACKLIGHT_QCOM_WLED=m
# CONFIG_BACKLIGHT_SAHARA is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_PCF50633 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
CONFIG_BACKLIGHT_LM3639=m
CONFIG_BACKLIGHT_LP855X=m
CONFIG_BACKLIGHT_GPIO=m
# CONFIG_BACKLIGHT_LV5207LP is not set
CONFIG_BACKLIGHT_BD6107=m
CONFIG_BACKLIGHT_ARCXCNN=m
# CONFIG_BACKLIGHT_RAVE_SP is not set
# end of Backlight & LCD device support

CONFIG_HDMI=y
CONFIG_LOGO=y
# CONFIG_LOGO_LINUX_MONO is not set
# CONFIG_LOGO_LINUX_VGA16 is not set
CONFIG_LOGO_LINUX_CLUT224=y
# end of Graphics support

CONFIG_SOUND=m
CONFIG_SND=m
CONFIG_SND_TIMER=m
CONFIG_SND_PCM=m
CONFIG_SND_DMAENGINE_PCM=m
CONFIG_SND_HWDEP=m
CONFIG_SND_SEQ_DEVICE=m
CONFIG_SND_COMPRESS_OFFLOAD=m
CONFIG_SND_JACK=y
CONFIG_SND_JACK_INPUT_DEV=y
# CONFIG_SND_OSSEMUL is not set
# CONFIG_SND_PCM_TIMER is not set
CONFIG_SND_DYNAMIC_MINORS=y
CONFIG_SND_MAX_CARDS=32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
CONFIG_SND_VERBOSE_PRINTK=y
# CONFIG_SND_DEBUG is not set
CONFIG_SND_VMASTER=y
CONFIG_SND_DMA_SGBUF=y
CONFIG_SND_SEQUENCER=m
# CONFIG_SND_SEQ_DUMMY is not set
CONFIG_SND_VX_LIB=m
CONFIG_SND_AC97_CODEC=m
# CONFIG_SND_DRIVERS is not set
CONFIG_SND_PCI=y
# CONFIG_SND_AD1889 is not set
# CONFIG_SND_ALS300 is not set
# CONFIG_SND_ALS4000 is not set
# CONFIG_SND_ALI5451 is not set
# CONFIG_SND_ASIHPI is not set
# CONFIG_SND_ATIIXP is not set
# CONFIG_SND_ATIIXP_MODEM is not set
# CONFIG_SND_AU8810 is not set
# CONFIG_SND_AU8820 is not set
# CONFIG_SND_AU8830 is not set
# CONFIG_SND_AW2 is not set
# CONFIG_SND_AZT3328 is not set
# CONFIG_SND_BT87X is not set
# CONFIG_SND_CA0106 is not set
# CONFIG_SND_CMIPCI is not set
# CONFIG_SND_OXYGEN is not set
# CONFIG_SND_CS4281 is not set
# CONFIG_SND_CS46XX is not set
# CONFIG_SND_CTXFI is not set
# CONFIG_SND_DARLA20 is not set
# CONFIG_SND_GINA20 is not set
# CONFIG_SND_LAYLA20 is not set
# CONFIG_SND_DARLA24 is not set
# CONFIG_SND_GINA24 is not set
# CONFIG_SND_LAYLA24 is not set
# CONFIG_SND_MONA is not set
# CONFIG_SND_MIA is not set
# CONFIG_SND_ECHO3G is not set
# CONFIG_SND_INDIGO is not set
# CONFIG_SND_INDIGOIO is not set
# CONFIG_SND_INDIGODJ is not set
# CONFIG_SND_INDIGOIOX is not set
# CONFIG_SND_INDIGODJX is not set
# CONFIG_SND_EMU10K1 is not set
# CONFIG_SND_EMU10K1X is not set
# CONFIG_SND_ENS1370 is not set
# CONFIG_SND_ENS1371 is not set
# CONFIG_SND_ES1938 is not set
# CONFIG_SND_ES1968 is not set
# CONFIG_SND_FM801 is not set
# CONFIG_SND_HDSP is not set
# CONFIG_SND_HDSPM is not set
# CONFIG_SND_ICE1712 is not set
# CONFIG_SND_ICE1724 is not set
# CONFIG_SND_INTEL8X0 is not set
# CONFIG_SND_INTEL8X0M is not set
# CONFIG_SND_KORG1212 is not set
# CONFIG_SND_LOLA is not set
# CONFIG_SND_LX6464ES is not set
# CONFIG_SND_MAESTRO3 is not set
# CONFIG_SND_MIXART is not set
# CONFIG_SND_NM256 is not set
# CONFIG_SND_PCXHR is not set
# CONFIG_SND_RIPTIDE is not set
# CONFIG_SND_RME32 is not set
# CONFIG_SND_RME96 is not set
# CONFIG_SND_RME9652 is not set
# CONFIG_SND_SE6X is not set
# CONFIG_SND_SONICVIBES is not set
# CONFIG_SND_TRIDENT is not set
# CONFIG_SND_VIA82XX is not set
# CONFIG_SND_VIA82XX_MODEM is not set
# CONFIG_SND_VIRTUOSO is not set
# CONFIG_SND_VX222 is not set
# CONFIG_SND_YMFPCI is not set

#
# HD-Audio
#
# CONFIG_SND_HDA_INTEL is not set
# end of HD-Audio

CONFIG_SND_HDA_PREALLOC_SIZE=0
CONFIG_SND_PCMCIA=y
CONFIG_SND_VXPOCKET=m
CONFIG_SND_PDAUDIOCF=m
CONFIG_SND_SOC=m
CONFIG_SND_SOC_AC97_BUS=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
CONFIG_SND_SOC_COMPRESS=y
CONFIG_SND_SOC_ADI=m
# CONFIG_SND_SOC_ADI_AXI_I2S is not set
# CONFIG_SND_SOC_ADI_AXI_SPDIF is not set
# CONFIG_SND_SOC_AMD_ACP is not set
# CONFIG_SND_SOC_AMD_ACP3x is not set
# CONFIG_SND_SOC_AMD_RENOIR is not set
# CONFIG_SND_SOC_AMD_ACP5x is not set
# CONFIG_SND_SOC_AMD_ACP6x is not set
# CONFIG_SND_AMD_ACP_CONFIG is not set
# CONFIG_SND_SOC_AMD_ACP_COMMON is not set
CONFIG_SND_ATMEL_SOC=m
# CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
CONFIG_SND_SOC_FSL_ASRC=m
CONFIG_SND_SOC_FSL_SAI=m
# CONFIG_SND_SOC_FSL_MQS is not set
CONFIG_SND_SOC_FSL_AUDMIX=m
CONFIG_SND_SOC_FSL_SSI=m
CONFIG_SND_SOC_FSL_SPDIF=m
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
CONFIG_SND_SOC_FSL_EASRC=m
# CONFIG_SND_SOC_FSL_XCVR is not set
# CONFIG_SND_SOC_FSL_RPMSG is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=m
CONFIG_SND_SOC_IMG=y
CONFIG_SND_SOC_IMG_I2S_IN=m
CONFIG_SND_SOC_IMG_I2S_OUT=m
# CONFIG_SND_SOC_IMG_PARALLEL_OUT is not set
CONFIG_SND_SOC_IMG_SPDIF_IN=m
CONFIG_SND_SOC_IMG_SPDIF_OUT=m
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=m
# CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
# CONFIG_SND_SOC_INTEL_AVS is not set
# CONFIG_SND_SOC_INTEL_MACH is not set
CONFIG_SND_SOC_MTK_BTCVSD=m
CONFIG_SND_SOC_SOF_TOPLEVEL=y
# CONFIG_SND_SOC_SOF_PCI is not set
# CONFIG_SND_SOC_SOF_ACPI is not set
# CONFIG_SND_SOC_SOF_AMD_TOPLEVEL is not set
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=y

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=m
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=m
# CONFIG_SND_SOC_XILINX_SPDIF is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=m

#
# CODEC drivers
#
CONFIG_SND_SOC_WM_ADSP=m
CONFIG_SND_SOC_AC97_CODEC=m
CONFIG_SND_SOC_ADAU_UTILS=m
CONFIG_SND_SOC_ADAU1372=m
CONFIG_SND_SOC_ADAU1372_I2C=m
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_ADAU1761_I2C is not set
CONFIG_SND_SOC_ADAU7002=m
CONFIG_SND_SOC_ADAU7118=m
# CONFIG_SND_SOC_ADAU7118_HW is not set
CONFIG_SND_SOC_ADAU7118_I2C=m
CONFIG_SND_SOC_AK4118=m
CONFIG_SND_SOC_AK4375=m
CONFIG_SND_SOC_AK4458=m
CONFIG_SND_SOC_AK4554=m
CONFIG_SND_SOC_AK4613=m
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
CONFIG_SND_SOC_AK5558=m
CONFIG_SND_SOC_ALC5623=m
# CONFIG_SND_SOC_AW8738 is not set
CONFIG_SND_SOC_BD28623=m
CONFIG_SND_SOC_BT_SCO=m
CONFIG_SND_SOC_CS35L32=m
CONFIG_SND_SOC_CS35L33=m
CONFIG_SND_SOC_CS35L34=m
CONFIG_SND_SOC_CS35L35=m
# CONFIG_SND_SOC_CS35L36 is not set
CONFIG_SND_SOC_CS35L41_LIB=m
CONFIG_SND_SOC_CS35L41=m
CONFIG_SND_SOC_CS35L41_I2C=m
# CONFIG_SND_SOC_CS35L45_I2C is not set
CONFIG_SND_SOC_CS42L42=m
CONFIG_SND_SOC_CS42L51=m
CONFIG_SND_SOC_CS42L51_I2C=m
# CONFIG_SND_SOC_CS42L52 is not set
CONFIG_SND_SOC_CS42L56=m
CONFIG_SND_SOC_CS42L73=m
CONFIG_SND_SOC_CS4234=m
CONFIG_SND_SOC_CS4265=m
CONFIG_SND_SOC_CS4270=m
# CONFIG_SND_SOC_CS4271_I2C is not set
CONFIG_SND_SOC_CS42XX8=m
CONFIG_SND_SOC_CS42XX8_I2C=m
CONFIG_SND_SOC_CS43130=m
CONFIG_SND_SOC_CS4341=m
CONFIG_SND_SOC_CS4349=m
CONFIG_SND_SOC_CS53L30=m
CONFIG_SND_SOC_CX2072X=m
CONFIG_SND_SOC_DA7213=m
CONFIG_SND_SOC_DMIC=m
# CONFIG_SND_SOC_ES7134 is not set
CONFIG_SND_SOC_ES7241=m
# CONFIG_SND_SOC_ES8316 is not set
CONFIG_SND_SOC_ES8328=m
CONFIG_SND_SOC_ES8328_I2C=m
CONFIG_SND_SOC_GTM601=m
CONFIG_SND_SOC_ICS43432=m
CONFIG_SND_SOC_INNO_RK3036=m
# CONFIG_SND_SOC_MAX98088 is not set
# CONFIG_SND_SOC_MAX98357A is not set
# CONFIG_SND_SOC_MAX98504 is not set
# CONFIG_SND_SOC_MAX9867 is not set
CONFIG_SND_SOC_MAX98927=m
# CONFIG_SND_SOC_MAX98520 is not set
# CONFIG_SND_SOC_MAX98373_I2C is not set
# CONFIG_SND_SOC_MAX98390 is not set
CONFIG_SND_SOC_MAX98396=m
CONFIG_SND_SOC_MAX9860=m
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=m
CONFIG_SND_SOC_PCM1681=m
# CONFIG_SND_SOC_PCM1789_I2C is not set
# CONFIG_SND_SOC_PCM179X_I2C is not set
# CONFIG_SND_SOC_PCM186X_I2C is not set
CONFIG_SND_SOC_PCM3060=m
CONFIG_SND_SOC_PCM3060_I2C=m
# CONFIG_SND_SOC_PCM3168A_I2C is not set
# CONFIG_SND_SOC_PCM5102A is not set
CONFIG_SND_SOC_PCM512x=m
CONFIG_SND_SOC_PCM512x_I2C=m
CONFIG_SND_SOC_RK3328=m
CONFIG_SND_SOC_RL6231=m
# CONFIG_SND_SOC_RT5616 is not set
# CONFIG_SND_SOC_RT5631 is not set
CONFIG_SND_SOC_RT5640=m
CONFIG_SND_SOC_RT5659=m
CONFIG_SND_SOC_RT9120=m
CONFIG_SND_SOC_SGTL5000=m
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=m
CONFIG_SND_SOC_SIMPLE_MUX=m
CONFIG_SND_SOC_SPDIF=m
# CONFIG_SND_SOC_SSM2305 is not set
CONFIG_SND_SOC_SSM2518=m
# CONFIG_SND_SOC_SSM2602_I2C is not set
CONFIG_SND_SOC_SSM4567=m
CONFIG_SND_SOC_STA32X=m
# CONFIG_SND_SOC_STA350 is not set
CONFIG_SND_SOC_STI_SAS=m
CONFIG_SND_SOC_TAS2552=m
CONFIG_SND_SOC_TAS2562=m
# CONFIG_SND_SOC_TAS2764 is not set
# CONFIG_SND_SOC_TAS2770 is not set
CONFIG_SND_SOC_TAS5086=m
CONFIG_SND_SOC_TAS571X=m
# CONFIG_SND_SOC_TAS5720 is not set
CONFIG_SND_SOC_TAS5805M=m
CONFIG_SND_SOC_TAS6424=m
# CONFIG_SND_SOC_TDA7419 is not set
CONFIG_SND_SOC_TFA9879=m
CONFIG_SND_SOC_TFA989X=m
CONFIG_SND_SOC_TLV320ADC3XXX=m
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
CONFIG_SND_SOC_TLV320AIC31XX=m
# CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
CONFIG_SND_SOC_TLV320AIC3X=m
CONFIG_SND_SOC_TLV320AIC3X_I2C=m
CONFIG_SND_SOC_TLV320ADCX140=m
CONFIG_SND_SOC_TS3A227E=m
CONFIG_SND_SOC_TSCS42XX=m
CONFIG_SND_SOC_TSCS454=m
# CONFIG_SND_SOC_UDA1334 is not set
# CONFIG_SND_SOC_WCD9335 is not set
CONFIG_SND_SOC_WM8510=m
CONFIG_SND_SOC_WM8523=m
# CONFIG_SND_SOC_WM8524 is not set
CONFIG_SND_SOC_WM8580=m
CONFIG_SND_SOC_WM8711=m
# CONFIG_SND_SOC_WM8728 is not set
CONFIG_SND_SOC_WM8731=m
CONFIG_SND_SOC_WM8731_I2C=m
# CONFIG_SND_SOC_WM8737 is not set
CONFIG_SND_SOC_WM8741=m
CONFIG_SND_SOC_WM8750=m
# CONFIG_SND_SOC_WM8753 is not set
CONFIG_SND_SOC_WM8776=m
CONFIG_SND_SOC_WM8782=m
CONFIG_SND_SOC_WM8804=m
CONFIG_SND_SOC_WM8804_I2C=m
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8904 is not set
# CONFIG_SND_SOC_WM8940 is not set
# CONFIG_SND_SOC_WM8960 is not set
CONFIG_SND_SOC_WM8962=m
CONFIG_SND_SOC_WM8974=m
CONFIG_SND_SOC_WM8978=m
CONFIG_SND_SOC_WM8985=m
CONFIG_SND_SOC_MAX9759=m
CONFIG_SND_SOC_MT6351=m
CONFIG_SND_SOC_MT6358=m
CONFIG_SND_SOC_MT6660=m
CONFIG_SND_SOC_NAU8315=m
CONFIG_SND_SOC_NAU8540=m
CONFIG_SND_SOC_NAU8810=m
# CONFIG_SND_SOC_NAU8821 is not set
# CONFIG_SND_SOC_NAU8822 is not set
# CONFIG_SND_SOC_NAU8824 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
# CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
# CONFIG_SND_SOC_LPASS_VA_MACRO is not set
# CONFIG_SND_SOC_LPASS_RX_MACRO is not set
# CONFIG_SND_SOC_LPASS_TX_MACRO is not set
# end of CODEC drivers

# CONFIG_SND_SIMPLE_CARD is not set
# CONFIG_SND_X86 is not set
# CONFIG_SND_VIRTIO is not set
CONFIG_AC97_BUS=m

#
# HID support
#
CONFIG_HID=m
# CONFIG_HID_BATTERY_STRENGTH is not set
CONFIG_HIDRAW=y
CONFIG_UHID=m
CONFIG_HID_GENERIC=m

#
# Special HID drivers
#
# CONFIG_HID_A4TECH is not set
CONFIG_HID_ACRUX=m
# CONFIG_HID_ACRUX_FF is not set
CONFIG_HID_APPLE=m
CONFIG_HID_AUREAL=m
CONFIG_HID_BELKIN=m
CONFIG_HID_CHERRY=m
CONFIG_HID_COUGAR=m
CONFIG_HID_MACALLY=m
CONFIG_HID_CMEDIA=m
CONFIG_HID_CYPRESS=m
CONFIG_HID_DRAGONRISE=m
CONFIG_DRAGONRISE_FF=y
# CONFIG_HID_EMS_FF is not set
CONFIG_HID_ELECOM=m
CONFIG_HID_EZKEY=m
CONFIG_HID_GEMBIRD=m
# CONFIG_HID_GFRM is not set
# CONFIG_HID_GLORIOUS is not set
# CONFIG_HID_VIVALDI is not set
CONFIG_HID_KEYTOUCH=m
CONFIG_HID_KYE=m
CONFIG_HID_WALTOP=m
CONFIG_HID_VIEWSONIC=m
# CONFIG_HID_XIAOMI is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_ITE is not set
CONFIG_HID_JABRA=m
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=m
CONFIG_HID_LCPOWER=m
CONFIG_HID_LED=m
CONFIG_HID_LENOVO=m
CONFIG_HID_MAGICMOUSE=m
CONFIG_HID_MALTRON=m
CONFIG_HID_MAYFLASH=m
CONFIG_HID_REDRAGON=m
CONFIG_HID_MICROSOFT=m
# CONFIG_HID_MONTEREY is not set
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NINTENDO is not set
# CONFIG_HID_NTI is not set
# CONFIG_HID_ORTEK is not set
CONFIG_HID_PANTHERLORD=m
CONFIG_PANTHERLORD_FF=y
CONFIG_HID_PETALYNX=m
CONFIG_HID_PICOLCD=m
# CONFIG_HID_PICOLCD_FB is not set
CONFIG_HID_PICOLCD_BACKLIGHT=y
# CONFIG_HID_PICOLCD_LCD is not set
CONFIG_HID_PICOLCD_LEDS=y
# CONFIG_HID_PICOLCD_CIR is not set
CONFIG_HID_PLANTRONICS=m
CONFIG_HID_PLAYSTATION=m
CONFIG_PLAYSTATION_FF=y
CONFIG_HID_RAZER=m
CONFIG_HID_PRIMAX=m
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SEMITEK is not set
CONFIG_HID_SPEEDLINK=m
CONFIG_HID_STEAM=m
# CONFIG_HID_STEELSERIES is not set
CONFIG_HID_SUNPLUS=m
# CONFIG_HID_RMI is not set
CONFIG_HID_GREENASIA=m
# CONFIG_GREENASIA_FF is not set
CONFIG_HID_SMARTJOYPLUS=m
# CONFIG_SMARTJOYPLUS_FF is not set
# CONFIG_HID_TIVO is not set
CONFIG_HID_TOPSEED=m
CONFIG_HID_THINGM=m
CONFIG_HID_UDRAW_PS3=m
CONFIG_HID_WIIMOTE=m
CONFIG_HID_XINMO=m
# CONFIG_HID_ZEROPLUS is not set
CONFIG_HID_ZYDACRON=m
CONFIG_HID_SENSOR_HUB=m
CONFIG_HID_SENSOR_CUSTOM_SENSOR=m
CONFIG_HID_ALPS=m
# end of Special HID drivers

#
# I2C HID support
#
# CONFIG_I2C_HID_ACPI is not set
# end of I2C HID support

#
# Intel ISH HID support
#
# CONFIG_INTEL_ISH_HID is not set
# end of Intel ISH HID support

#
# AMD SFH HID Support
#
# CONFIG_AMD_SFH_HID is not set
# end of AMD SFH HID Support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_CONN_GPIO is not set
CONFIG_USB_ARCH_HAS_HCD=y
# CONFIG_USB is not set
CONFIG_USB_PCI=y

#
# USB port drivers
#

#
# USB Physical Layer drivers
#
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_USB_GPIO_VBUS is not set
# end of USB Physical Layer drivers

# CONFIG_USB_GADGET is not set
# CONFIG_TYPEC is not set
# CONFIG_USB_ROLE_SWITCH is not set
CONFIG_MMC=y
# CONFIG_MMC_BLOCK is not set
CONFIG_SDIO_UART=y
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=m
# CONFIG_MMC_SDHCI_PCI is not set
# CONFIG_MMC_SDHCI_ACPI is not set
CONFIG_MMC_SDHCI_PLTFM=m
# CONFIG_MMC_SDHCI_F_SDH30 is not set
# CONFIG_MMC_WBSD is not set
# CONFIG_MMC_TIFM_SD is not set
# CONFIG_MMC_SDRICOH_CS is not set
# CONFIG_MMC_CB710 is not set
# CONFIG_MMC_VIA_SDMMC is not set
CONFIG_MMC_USDHI6ROL0=y
CONFIG_MMC_CQHCI=y
# CONFIG_MMC_HSQ is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_MMC_MTK is not set
CONFIG_MMC_SDHCI_XENON=m
CONFIG_SCSI_UFSHCD=m
CONFIG_SCSI_UFS_BSG=y
# CONFIG_SCSI_UFS_HPB is not set
# CONFIG_SCSI_UFS_FAULT_INJECTION is not set
CONFIG_SCSI_UFS_HWMON=y
# CONFIG_SCSI_UFSHCD_PCI is not set
# CONFIG_SCSI_UFSHCD_PLATFORM is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=m
CONFIG_LEDS_CLASS_MULTICOLOR=m
# CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set

#
# LED drivers
#
CONFIG_LEDS_APU=m
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3532 is not set
CONFIG_LEDS_LM3533=m
CONFIG_LEDS_LM3642=m
CONFIG_LEDS_MT6323=y
CONFIG_LEDS_PCA9532=m
CONFIG_LEDS_PCA9532_GPIO=y
CONFIG_LEDS_GPIO=y
CONFIG_LEDS_LP3944=m
# CONFIG_LEDS_LP3952 is not set
CONFIG_LEDS_LP50XX=m
# CONFIG_LEDS_CLEVO_MAIL is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_INTEL_SS4200 is not set
# CONFIG_LEDS_LT3593 is not set
CONFIG_LEDS_MC13783=m
CONFIG_LEDS_TCA6507=m
CONFIG_LEDS_TLC591XX=m
CONFIG_LEDS_LM355x=m
CONFIG_LEDS_MENF21BMC=m

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
CONFIG_LEDS_MLXCPLD=y
CONFIG_LEDS_MLXREG=m
# CONFIG_LEDS_USER is not set
# CONFIG_LEDS_NIC78BX is not set
CONFIG_LEDS_TI_LMU_COMMON=y
# CONFIG_LEDS_LM36274 is not set
# CONFIG_LEDS_TPS6105X is not set

#
# Flash and Torch LED drivers
#
# CONFIG_LEDS_AS3645A is not set
CONFIG_LEDS_LM3601X=m
CONFIG_LEDS_RT8515=m
CONFIG_LEDS_SGM3140=m

#
# RGB LED drivers
#
CONFIG_LEDS_PWM_MULTICOLOR=m

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set

#
# Simple LED drivers
#
CONFIG_ACCESSIBILITY=y

#
# Speakup console speech
#
# end of Speakup console speech

# CONFIG_INFINIBAND is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=y

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
CONFIG_RTC_INTF_DEV_UIE_EMUL=y
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_88PM80X is not set
CONFIG_RTC_DRV_ABB5ZES3=m
CONFIG_RTC_DRV_ABEOZ9=m
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
CONFIG_RTC_DRV_DS1374=m
# CONFIG_RTC_DRV_DS1374_WDT is not set
CONFIG_RTC_DRV_DS1672=m
CONFIG_RTC_DRV_MAX6900=m
# CONFIG_RTC_DRV_MAX8907 is not set
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
CONFIG_RTC_DRV_X1205=m
CONFIG_RTC_DRV_PCF8523=m
CONFIG_RTC_DRV_PCF85063=m
# CONFIG_RTC_DRV_PCF85363 is not set
CONFIG_RTC_DRV_PCF8563=m
# CONFIG_RTC_DRV_PCF8583 is not set
CONFIG_RTC_DRV_M41T80=m
CONFIG_RTC_DRV_M41T80_WDT=y
# CONFIG_RTC_DRV_BQ32K is not set
CONFIG_RTC_DRV_S35390A=m
CONFIG_RTC_DRV_FM3130=m
# CONFIG_RTC_DRV_RX8010 is not set
CONFIG_RTC_DRV_RX8581=m
CONFIG_RTC_DRV_RX8025=m
CONFIG_RTC_DRV_EM3027=m
CONFIG_RTC_DRV_RV3028=m
CONFIG_RTC_DRV_RV3032=m
CONFIG_RTC_DRV_RV8803=m
CONFIG_RTC_DRV_SD3078=m

#
# SPI RTC drivers
#
CONFIG_RTC_I2C_AND_SPI=m

#
# SPI and I2C RTC drivers
#
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
CONFIG_RTC_DRV_RV3029C2=m
CONFIG_RTC_DRV_RV3029_HWMON=y
CONFIG_RTC_DRV_RX6110=m

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=y
CONFIG_RTC_DRV_DS1286=y
CONFIG_RTC_DRV_DS1511=m
CONFIG_RTC_DRV_DS1553=y
CONFIG_RTC_DRV_DS1685_FAMILY=m
# CONFIG_RTC_DRV_DS1685 is not set
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
CONFIG_RTC_DRV_DS17485=y
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=m
CONFIG_RTC_DRV_DS2404=y
# CONFIG_RTC_DRV_DA9063 is not set
CONFIG_RTC_DRV_STK17TA8=m
# CONFIG_RTC_DRV_M48T86 is not set
CONFIG_RTC_DRV_M48T35=y
CONFIG_RTC_DRV_M48T59=y
CONFIG_RTC_DRV_MSM6242=y
CONFIG_RTC_DRV_BQ4802=y
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
CONFIG_RTC_DRV_PCF50633=m

#
# on-CPU RTC drivers
#
# CONFIG_RTC_DRV_FTRTC010 is not set
# CONFIG_RTC_DRV_MC13XXX is not set
# CONFIG_RTC_DRV_MT6397 is not set

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_GOLDFISH=y
# CONFIG_DMADEVICES is not set

#
# DMABUF options
#
# CONFIG_SYNC_FILE is not set
# CONFIG_UDMABUF is not set
# CONFIG_DMABUF_MOVE_NOTIFY is not set
# CONFIG_DMABUF_DEBUG is not set
# CONFIG_DMABUF_SELFTESTS is not set
# CONFIG_DMABUF_HEAPS is not set
# CONFIG_DMABUF_SYSFS_STATS is not set
# end of DMABUF options

CONFIG_AUXDISPLAY=y
CONFIG_CHARLCD=m
CONFIG_HD44780_COMMON=m
CONFIG_HD44780=m
CONFIG_KS0108=m
CONFIG_KS0108_PORT=0x378
CONFIG_KS0108_DELAY=2
CONFIG_CFAG12864B=m
CONFIG_CFAG12864B_RATE=20
# CONFIG_IMG_ASCII_LCD is not set
# CONFIG_HT16K33 is not set
CONFIG_LCD2S=m
CONFIG_PARPORT_PANEL=m
CONFIG_PANEL_PARPORT=0
CONFIG_PANEL_PROFILE=5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
CONFIG_CHARLCD_BL_OFF=y
# CONFIG_CHARLCD_BL_ON is not set
# CONFIG_CHARLCD_BL_FLASH is not set
CONFIG_PANEL=m
CONFIG_UIO=y
# CONFIG_UIO_CIF is not set
# CONFIG_UIO_PDRV_GENIRQ is not set
CONFIG_UIO_DMEM_GENIRQ=y
# CONFIG_UIO_AEC is not set
# CONFIG_UIO_SERCOS3 is not set
# CONFIG_UIO_PCI_GENERIC is not set
# CONFIG_UIO_NETX is not set
# CONFIG_UIO_PRUSS is not set
# CONFIG_UIO_MF624 is not set
CONFIG_VFIO=y
CONFIG_VFIO_IOMMU_TYPE1=y
CONFIG_VFIO_NOIOMMU=y
CONFIG_VFIO_PCI_MMAP=y
CONFIG_VFIO_PCI_INTX=y
# CONFIG_VFIO_PCI is not set
CONFIG_VFIO_MDEV=m
# CONFIG_VIRT_DRIVERS is not set
CONFIG_VIRTIO=y
CONFIG_VIRTIO_MENU=y
CONFIG_VIRTIO_HARDEN_NOTIFICATION=y
# CONFIG_VIRTIO_PCI is not set
CONFIG_VIRTIO_PMEM=m
# CONFIG_VIRTIO_BALLOON is not set
# CONFIG_VIRTIO_INPUT is not set
CONFIG_VIRTIO_MMIO=m
# CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES is not set
# CONFIG_VDPA is not set
# CONFIG_VHOST_MENU is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_HYPERV is not set
# end of Microsoft Hyper-V guest support

# CONFIG_GREYBUS is not set
CONFIG_COMEDI=m
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=20480
# CONFIG_COMEDI_MISC_DRIVERS is not set
CONFIG_COMEDI_ISA_DRIVERS=y
# CONFIG_COMEDI_PCL711 is not set
CONFIG_COMEDI_PCL724=m
# CONFIG_COMEDI_PCL726 is not set
CONFIG_COMEDI_PCL730=m
# CONFIG_COMEDI_PCL812 is not set
CONFIG_COMEDI_PCL816=m
CONFIG_COMEDI_PCL818=m
# CONFIG_COMEDI_PCM3724 is not set
CONFIG_COMEDI_AMPLC_DIO200_ISA=m
# CONFIG_COMEDI_AMPLC_PC236_ISA is not set
# CONFIG_COMEDI_AMPLC_PC263_ISA is not set
CONFIG_COMEDI_RTI800=m
CONFIG_COMEDI_RTI802=m
# CONFIG_COMEDI_DAC02 is not set
# CONFIG_COMEDI_DAS16M1 is not set
CONFIG_COMEDI_DAS08_ISA=m
CONFIG_COMEDI_DAS16=m
# CONFIG_COMEDI_DAS800 is not set
CONFIG_COMEDI_DAS1800=m
# CONFIG_COMEDI_DAS6402 is not set
CONFIG_COMEDI_DT2801=m
CONFIG_COMEDI_DT2811=m
CONFIG_COMEDI_DT2814=m
CONFIG_COMEDI_DT2815=m
CONFIG_COMEDI_DT2817=m
CONFIG_COMEDI_DT282X=m
CONFIG_COMEDI_DMM32AT=m
CONFIG_COMEDI_FL512=m
# CONFIG_COMEDI_AIO_AIO12_8 is not set
# CONFIG_COMEDI_AIO_IIRO_16 is not set
# CONFIG_COMEDI_II_PCI20KC is not set
# CONFIG_COMEDI_C6XDIGIO is not set
CONFIG_COMEDI_MPC624=m
# CONFIG_COMEDI_ADQ12B is not set
CONFIG_COMEDI_NI_AT_A2150=m
CONFIG_COMEDI_NI_AT_AO=m
CONFIG_COMEDI_NI_ATMIO=m
# CONFIG_COMEDI_NI_ATMIO16D is not set
CONFIG_COMEDI_NI_LABPC_ISA=m
# CONFIG_COMEDI_PCMAD is not set
CONFIG_COMEDI_PCMDA12=m
# CONFIG_COMEDI_PCMMIO is not set
CONFIG_COMEDI_PCMUIO=m
CONFIG_COMEDI_MULTIQ3=m
CONFIG_COMEDI_S526=m
# CONFIG_COMEDI_PCI_DRIVERS is not set
CONFIG_COMEDI_PCMCIA_DRIVERS=m
CONFIG_COMEDI_CB_DAS16_CS=m
CONFIG_COMEDI_DAS08_CS=m
CONFIG_COMEDI_NI_DAQ_700_CS=m
CONFIG_COMEDI_NI_DAQ_DIO24_CS=m
# CONFIG_COMEDI_NI_LABPC_CS is not set
CONFIG_COMEDI_NI_MIO_CS=m
CONFIG_COMEDI_QUATECH_DAQP_CS=m
CONFIG_COMEDI_8254=m
CONFIG_COMEDI_8255=m
CONFIG_COMEDI_8255_SA=m
CONFIG_COMEDI_KCOMEDILIB=m
CONFIG_COMEDI_AMPLC_DIO200=m
CONFIG_COMEDI_DAS08=m
CONFIG_COMEDI_ISADMA=m
CONFIG_COMEDI_NI_LABPC=m
CONFIG_COMEDI_NI_LABPC_ISADMA=m
CONFIG_COMEDI_NI_TIO=m
CONFIG_COMEDI_NI_ROUTING=m
# CONFIG_COMEDI_TESTS is not set
CONFIG_STAGING=y
# CONFIG_RTLLIB is not set
# CONFIG_RTS5208 is not set
# CONFIG_FB_SM750 is not set
# CONFIG_STAGING_MEDIA is not set
# CONFIG_KS7010 is not set
# CONFIG_FIELDBUS_DEV is not set
# CONFIG_QLGE is not set

#
# VME Device Drivers
#
# CONFIG_X86_PLATFORM_DEVICES is not set
CONFIG_PMC_ATOM=y
CONFIG_GOLDFISH_PIPE=y
CONFIG_CHROME_PLATFORMS=y
# CONFIG_CHROMEOS_ACPI is not set
CONFIG_CHROMEOS_LAPTOP=m
CONFIG_CHROMEOS_PSTORE=y
# CONFIG_CHROMEOS_TBMC is not set
# CONFIG_CROS_EC is not set
# CONFIG_CROS_KBD_LED_BACKLIGHT is not set
# CONFIG_MELLANOX_PLATFORM is not set
# CONFIG_SURFACE_PLATFORMS is not set
CONFIG_HAVE_CLK=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y
# CONFIG_COMMON_CLK_MAX9485 is not set
# CONFIG_COMMON_CLK_SI5341 is not set
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI544 is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
# CONFIG_COMMON_CLK_CS2000_CP is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_XILINX_VCU is not set
CONFIG_HWSPINLOCK=y

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=y
CONFIG_CLKBLD_I8253=y
# end of Clock Source drivers

CONFIG_MAILBOX=y
# CONFIG_PCC is not set
CONFIG_ALTERA_MBOX=m
CONFIG_IOMMU_API=y
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
CONFIG_IOMMU_DEFAULT_DMA_STRICT=y
# CONFIG_IOMMU_DEFAULT_DMA_LAZY is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
# CONFIG_AMD_IOMMU is not set
# CONFIG_VIRTIO_IOMMU is not set

#
# Remoteproc drivers
#
# CONFIG_REMOTEPROC is not set
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=y
# CONFIG_RPMSG_CHAR is not set
CONFIG_RPMSG_CTRL=y
CONFIG_RPMSG_NS=y
CONFIG_RPMSG_QCOM_GLINK=m
CONFIG_RPMSG_QCOM_GLINK_RPM=m
CONFIG_RPMSG_VIRTIO=y
# end of Rpmsg drivers

# CONFIG_SOUNDWIRE is not set

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Enable LiteX SoC Builder specific drivers
#
# end of Enable LiteX SoC Builder specific drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=y

#
# Xilinx SoC drivers
#
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=y

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=m
CONFIG_DEVFREQ_GOV_PERFORMANCE=m
CONFIG_DEVFREQ_GOV_POWERSAVE=y
CONFIG_DEVFREQ_GOV_USERSPACE=y
# CONFIG_DEVFREQ_GOV_PASSIVE is not set

#
# DEVFREQ Drivers
#
# CONFIG_PM_DEVFREQ_EVENT is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
CONFIG_EXTCON_FSA9480=m
CONFIG_EXTCON_GPIO=y
# CONFIG_EXTCON_INTEL_INT3496 is not set
CONFIG_EXTCON_MAX14577=m
CONFIG_EXTCON_MAX3355=y
CONFIG_EXTCON_PTN5150=m
CONFIG_EXTCON_RT8973A=m
CONFIG_EXTCON_SM5502=m
CONFIG_EXTCON_USB_GPIO=m
# CONFIG_EXTCON_USBC_TUSB320 is not set
CONFIG_MEMORY=y
# CONFIG_IIO is not set
# CONFIG_NTB is not set
# CONFIG_VME_BUS is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_DEBUG is not set
# CONFIG_PWM_DWC is not set
# CONFIG_PWM_LPSS_PCI is not set
# CONFIG_PWM_LPSS_PLATFORM is not set
CONFIG_PWM_PCA9685=m

#
# IRQ chip support
#
CONFIG_MADERA_IRQ=m
# end of IRQ chip support

CONFIG_IPACK_BUS=y
# CONFIG_BOARD_TPCI200 is not set
CONFIG_SERIAL_IPOCTAL=y
CONFIG_RESET_CONTROLLER=y
CONFIG_RESET_TI_SYSCON=m

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
# CONFIG_USB_LGM_PHY is not set
# CONFIG_PHY_CAN_TRANSCEIVER is not set

#
# PHY drivers for Broadcom platforms
#
CONFIG_BCM_KONA_USB2_PHY=m
# end of PHY drivers for Broadcom platforms

# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_INTEL_LGM_EMMC=y
# end of PHY Subsystem

# CONFIG_POWERCAP is not set
CONFIG_MCB=m
# CONFIG_MCB_PCI is not set
CONFIG_MCB_LPC=m

#
# Performance monitor support
#
# end of Performance monitor support

# CONFIG_RAS is not set
# CONFIG_USB4 is not set

#
# Android
#
CONFIG_ANDROID=y
CONFIG_ANDROID_BINDER_IPC=y
# CONFIG_ANDROID_BINDERFS is not set
CONFIG_ANDROID_BINDER_DEVICES="binder,hwbinder,vndbinder"
# CONFIG_ANDROID_BINDER_IPC_SELFTEST is not set
# end of Android

CONFIG_LIBNVDIMM=m
CONFIG_BLK_DEV_PMEM=m
CONFIG_ND_CLAIM=y
CONFIG_ND_BTT=m
CONFIG_BTT=y
CONFIG_DAX=m
CONFIG_DEV_DAX=m
CONFIG_NVMEM=y
CONFIG_NVMEM_SYSFS=y
CONFIG_RAVE_SP_EEPROM=m
CONFIG_NVMEM_RMEM=y

#
# HW tracing support
#
CONFIG_STM=y
# CONFIG_STM_PROTO_BASIC is not set
CONFIG_STM_PROTO_SYS_T=y
CONFIG_STM_DUMMY=m
CONFIG_STM_SOURCE_CONSOLE=m
CONFIG_STM_SOURCE_HEARTBEAT=m
CONFIG_STM_SOURCE_FTRACE=m
CONFIG_INTEL_TH=m
# CONFIG_INTEL_TH_PCI is not set
# CONFIG_INTEL_TH_ACPI is not set
CONFIG_INTEL_TH_GTH=m
CONFIG_INTEL_TH_STH=m
# CONFIG_INTEL_TH_MSU is not set
CONFIG_INTEL_TH_PTI=m
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

# CONFIG_FPGA is not set
CONFIG_TEE=m
CONFIG_PM_OPP=y
# CONFIG_SIOX is not set
CONFIG_SLIMBUS=m
CONFIG_SLIM_QCOM_CTRL=m
CONFIG_INTERCONNECT=y
CONFIG_COUNTER=m
# CONFIG_104_QUAD_8 is not set
CONFIG_INTERRUPT_CNT=m
# CONFIG_INTEL_QEP is not set
# CONFIG_MOST is not set
CONFIG_PECI=y
CONFIG_PECI_CPU=y
CONFIG_HTE=y
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
# CONFIG_VALIDATE_FS_PARSER is not set
CONFIG_FS_IOMAP=y
CONFIG_EXT2_FS=m
# CONFIG_EXT2_FS_XATTR is not set
# CONFIG_EXT3_FS is not set
# CONFIG_EXT4_FS is not set
CONFIG_REISERFS_FS=y
CONFIG_REISERFS_CHECK=y
# CONFIG_REISERFS_PROC_INFO is not set
CONFIG_REISERFS_FS_XATTR=y
CONFIG_REISERFS_FS_POSIX_ACL=y
CONFIG_REISERFS_FS_SECURITY=y
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_OCFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
# CONFIG_ZONEFS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
# CONFIG_EXPORTFS_BLOCK_OPS is not set
CONFIG_FILE_LOCKING=y
# CONFIG_FS_ENCRYPTION is not set
# CONFIG_FS_VERITY is not set
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
CONFIG_QUOTA=y
# CONFIG_QUOTA_NETLINK_INTERFACE is not set
CONFIG_PRINT_QUOTA_WARNING=y
CONFIG_QUOTA_DEBUG=y
CONFIG_QUOTA_TREE=y
CONFIG_QFMT_V1=m
CONFIG_QFMT_V2=y
CONFIG_QUOTACTL=y
CONFIG_AUTOFS4_FS=m
CONFIG_AUTOFS_FS=m
CONFIG_FUSE_FS=y
# CONFIG_CUSE is not set
CONFIG_VIRTIO_FS=m
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
CONFIG_NETFS_SUPPORT=m
# CONFIG_NETFS_STATS is not set
CONFIG_FSCACHE=m
# CONFIG_FSCACHE_STATS is not set
CONFIG_FSCACHE_DEBUG=y
# CONFIG_CACHEFILES is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=y
# CONFIG_JOLIET is not set
# CONFIG_ZISOFS is not set
# CONFIG_UDF_FS is not set
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/EXFAT/NT Filesystems
#
CONFIG_FAT_FS=y
# CONFIG_MSDOS_FS is not set
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_FAT_DEFAULT_UTF8 is not set
# CONFIG_EXFAT_FS is not set
# CONFIG_NTFS_FS is not set
CONFIG_NTFS3_FS=m
# CONFIG_NTFS3_64BIT_CLUSTER is not set
# CONFIG_NTFS3_LZX_XPRESS is not set
CONFIG_NTFS3_FS_POSIX_ACL=y
# end of DOS/FAT/EXFAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
# CONFIG_PROC_KCORE is not set
CONFIG_PROC_VMCORE=y
# CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
CONFIG_PROC_CHILDREN=y
CONFIG_PROC_PID_ARCH_STATUS=y
CONFIG_PROC_CPU_RESCTRL=y
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
# CONFIG_TMPFS_POSIX_ACL is not set
CONFIG_TMPFS_XATTR=y
# CONFIG_TMPFS_INODE64 is not set
# CONFIG_HUGETLBFS is not set
CONFIG_ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=y
CONFIG_MEMFD_CREATE=y
CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
CONFIG_CONFIGFS_FS=y
# end of Pseudo filesystems

# CONFIG_MISC_FILESYSTEMS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
CONFIG_NFS_V4=m
# CONFIG_NFS_SWAP is not set
# CONFIG_NFS_V4_1 is not set
# CONFIG_ROOT_NFS is not set
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=y
CONFIG_NFS_DISABLE_UDP_SUPPORT=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
CONFIG_SUNRPC_GSS=m
CONFIG_RPCSEC_GSS_KRB5=m
# CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
CONFIG_CIFS=m
CONFIG_CIFS_STATS2=y
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
# CONFIG_CIFS_UPCALL is not set
# CONFIG_CIFS_XATTR is not set
CONFIG_CIFS_DEBUG=y
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
# CONFIG_CIFS_DFS_UPCALL is not set
# CONFIG_CIFS_SWN_UPCALL is not set
# CONFIG_CIFS_FSCACHE is not set
# CONFIG_SMB_SERVER is not set
CONFIG_SMBFS_COMMON=m
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
# CONFIG_9P_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_737=m
CONFIG_NLS_CODEPAGE_775=y
CONFIG_NLS_CODEPAGE_850=y
CONFIG_NLS_CODEPAGE_852=y
CONFIG_NLS_CODEPAGE_855=y
CONFIG_NLS_CODEPAGE_857=m
CONFIG_NLS_CODEPAGE_860=y
CONFIG_NLS_CODEPAGE_861=m
CONFIG_NLS_CODEPAGE_862=y
# CONFIG_NLS_CODEPAGE_863 is not set
CONFIG_NLS_CODEPAGE_864=y
CONFIG_NLS_CODEPAGE_865=m
# CONFIG_NLS_CODEPAGE_866 is not set
CONFIG_NLS_CODEPAGE_869=m
CONFIG_NLS_CODEPAGE_936=y
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
CONFIG_NLS_CODEPAGE_874=m
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
CONFIG_NLS_CODEPAGE_1251=m
CONFIG_NLS_ASCII=m
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
CONFIG_NLS_ISO8859_3=m
CONFIG_NLS_ISO8859_4=y
CONFIG_NLS_ISO8859_5=y
CONFIG_NLS_ISO8859_6=y
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
CONFIG_NLS_ISO8859_13=y
# CONFIG_NLS_ISO8859_14 is not set
CONFIG_NLS_ISO8859_15=y
# CONFIG_NLS_KOI8_R is not set
CONFIG_NLS_KOI8_U=m
# CONFIG_NLS_MAC_ROMAN is not set
CONFIG_NLS_MAC_CELTIC=y
CONFIG_NLS_MAC_CENTEURO=m
CONFIG_NLS_MAC_CROATIAN=m
CONFIG_NLS_MAC_CYRILLIC=y
CONFIG_NLS_MAC_GAELIC=m
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set
# CONFIG_DLM is not set
CONFIG_UNICODE=y
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=y
# end of File systems

#
# Security options
#
CONFIG_KEYS=y
CONFIG_KEYS_REQUEST_CACHE=y
# CONFIG_PERSISTENT_KEYRINGS is not set
CONFIG_TRUSTED_KEYS=m
# CONFIG_TRUSTED_KEYS_TEE is not set

#
# No trust source selected!
#
# CONFIG_ENCRYPTED_KEYS is not set
# CONFIG_KEY_DH_OPERATIONS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=y
# CONFIG_SECURITYFS is not set
# CONFIG_SECURITY_NETWORK is not set
CONFIG_SECURITY_PATH=y
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
# CONFIG_HARDENED_USERCOPY is not set
CONFIG_FORTIFY_SOURCE=y
# CONFIG_STATIC_USERMODEHELPER is not set
# CONFIG_SECURITY_SMACK is not set
# CONFIG_SECURITY_TOMOYO is not set
# CONFIG_SECURITY_APPARMOR is not set
CONFIG_SECURITY_LOADPIN=y
# CONFIG_SECURITY_LOADPIN_ENFORCE is not set
CONFIG_SECURITY_YAMA=y
# CONFIG_SECURITY_SAFESETID is not set
# CONFIG_SECURITY_LOCKDOWN_LSM is not set
# CONFIG_SECURITY_LANDLOCK is not set
CONFIG_INTEGRITY=y
# CONFIG_INTEGRITY_SIGNATURE is not set
# CONFIG_IMA is not set
# CONFIG_EVM is not set
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_LSM="landlock,lockdown,yama,loadpin,safesetid,integrity,bpf"

#
# Kernel hardening options
#

#
# Memory initialization
#
CONFIG_CC_HAS_AUTO_VAR_INIT_PATTERN=y
CONFIG_CC_HAS_AUTO_VAR_INIT_ZERO=y
# CONFIG_INIT_STACK_NONE is not set
CONFIG_INIT_STACK_ALL_PATTERN=y
# CONFIG_INIT_STACK_ALL_ZERO is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=y
CONFIG_INIT_ON_FREE_DEFAULT_ON=y
CONFIG_CC_HAS_ZERO_CALL_USED_REGS=y
CONFIG_ZERO_CALL_USED_REGS=y
# end of Memory initialization

CONFIG_CC_HAS_RANDSTRUCT=y
CONFIG_RANDSTRUCT_NONE=y
# CONFIG_RANDSTRUCT_FULL is not set
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=y
CONFIG_ASYNC_CORE=m
CONFIG_ASYNC_MEMCPY=m
CONFIG_ASYNC_XOR=m
CONFIG_ASYNC_PQ=m
CONFIG_ASYNC_RAID6_RECOV=m
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_SKCIPHER=y
CONFIG_CRYPTO_SKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=y
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=y
CONFIG_CRYPTO_AKCIPHER2=y
CONFIG_CRYPTO_AKCIPHER=y
CONFIG_CRYPTO_KPP2=y
CONFIG_CRYPTO_KPP=y
CONFIG_CRYPTO_ACOMP2=y
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
CONFIG_CRYPTO_GF128MUL=m
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_NULL2=y
CONFIG_CRYPTO_CRYPTD=y
CONFIG_CRYPTO_AUTHENC=m
# CONFIG_CRYPTO_TEST is not set
CONFIG_CRYPTO_SIMD=y
CONFIG_CRYPTO_ENGINE=y

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=y
# CONFIG_CRYPTO_DH is not set
CONFIG_CRYPTO_ECC=y
CONFIG_CRYPTO_ECDH=y
CONFIG_CRYPTO_ECDSA=y
# CONFIG_CRYPTO_ECRDSA is not set
CONFIG_CRYPTO_SM2=y
CONFIG_CRYPTO_CURVE25519=m
# CONFIG_CRYPTO_CURVE25519_X86 is not set

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=m
CONFIG_CRYPTO_GCM=m
CONFIG_CRYPTO_CHACHA20POLY1305=m
CONFIG_CRYPTO_AEGIS128=m
# CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
# CONFIG_CRYPTO_SEQIV is not set
# CONFIG_CRYPTO_ECHAINIV is not set

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
CONFIG_CRYPTO_CFB=y
CONFIG_CRYPTO_CTR=m
CONFIG_CRYPTO_CTS=m
CONFIG_CRYPTO_ECB=y
CONFIG_CRYPTO_LRW=m
CONFIG_CRYPTO_OFB=m
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set
CONFIG_CRYPTO_KEYWRAP=m
CONFIG_CRYPTO_NHPOLY1305=y
CONFIG_CRYPTO_NHPOLY1305_SSE2=y
CONFIG_CRYPTO_NHPOLY1305_AVX2=m
CONFIG_CRYPTO_ADIANTUM=m
CONFIG_CRYPTO_ESSIV=m

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=m
CONFIG_CRYPTO_HMAC=y
# CONFIG_CRYPTO_XCBC is not set
CONFIG_CRYPTO_VMAC=y

#
# Digest
#
CONFIG_CRYPTO_CRC32C=m
CONFIG_CRYPTO_CRC32C_INTEL=y
# CONFIG_CRYPTO_CRC32 is not set
CONFIG_CRYPTO_CRC32_PCLMUL=m
CONFIG_CRYPTO_XXHASH=m
CONFIG_CRYPTO_BLAKE2B=y
CONFIG_CRYPTO_BLAKE2S=m
# CONFIG_CRYPTO_BLAKE2S_X86 is not set
CONFIG_CRYPTO_CRCT10DIF=y
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=m
CONFIG_CRYPTO_CRC64_ROCKSOFT=m
CONFIG_CRYPTO_GHASH=m
CONFIG_CRYPTO_POLY1305=m
CONFIG_CRYPTO_POLY1305_X86_64=m
CONFIG_CRYPTO_MD4=y
CONFIG_CRYPTO_MD5=y
CONFIG_CRYPTO_MICHAEL_MIC=y
CONFIG_CRYPTO_RMD160=y
CONFIG_CRYPTO_SHA1=y
CONFIG_CRYPTO_SHA1_SSSE3=y
CONFIG_CRYPTO_SHA256_SSSE3=m
CONFIG_CRYPTO_SHA512_SSSE3=y
CONFIG_CRYPTO_SHA256=y
CONFIG_CRYPTO_SHA512=y
CONFIG_CRYPTO_SHA3=m
CONFIG_CRYPTO_SM3=y
CONFIG_CRYPTO_SM3_GENERIC=y
CONFIG_CRYPTO_SM3_AVX_X86_64=m
# CONFIG_CRYPTO_STREEBOG is not set
CONFIG_CRYPTO_WP512=m
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=m

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_AES_TI is not set
# CONFIG_CRYPTO_AES_NI_INTEL is not set
# CONFIG_CRYPTO_BLOWFISH is not set
CONFIG_CRYPTO_BLOWFISH_COMMON=y
CONFIG_CRYPTO_BLOWFISH_X86_64=y
CONFIG_CRYPTO_CAMELLIA=m
# CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
# CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
CONFIG_CRYPTO_CAST_COMMON=y
CONFIG_CRYPTO_CAST5=m
# CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
CONFIG_CRYPTO_CAST6=y
CONFIG_CRYPTO_CAST6_AVX_X86_64=m
CONFIG_CRYPTO_DES=m
CONFIG_CRYPTO_DES3_EDE_X86_64=y
CONFIG_CRYPTO_FCRYPT=m
CONFIG_CRYPTO_CHACHA20=y
CONFIG_CRYPTO_CHACHA20_X86_64=m
CONFIG_CRYPTO_SERPENT=y
# CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
CONFIG_CRYPTO_SERPENT_AVX_X86_64=y
# CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
CONFIG_CRYPTO_SM4=y
# CONFIG_CRYPTO_SM4_GENERIC is not set
CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=y
CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=y
CONFIG_CRYPTO_TWOFISH=m
CONFIG_CRYPTO_TWOFISH_COMMON=y
CONFIG_CRYPTO_TWOFISH_X86_64=y
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=m
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=m

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=y
CONFIG_CRYPTO_LZO=m
CONFIG_CRYPTO_842=m
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set
CONFIG_CRYPTO_ZSTD=y

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=y
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=y
CONFIG_CRYPTO_JITTERENTROPY=y
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HASH_INFO=y
CONFIG_CRYPTO_HW=y
CONFIG_CRYPTO_DEV_PADLOCK=m
# CONFIG_CRYPTO_DEV_PADLOCK_AES is not set
# CONFIG_CRYPTO_DEV_PADLOCK_SHA is not set
CONFIG_CRYPTO_DEV_ATMEL_I2C=m
CONFIG_CRYPTO_DEV_ATMEL_ECC=m
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=m
# CONFIG_CRYPTO_DEV_CCP is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
# CONFIG_CRYPTO_DEV_QAT_C62X is not set
# CONFIG_CRYPTO_DEV_QAT_4XXX is not set
# CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
# CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
# CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
# CONFIG_CRYPTO_DEV_VIRTIO is not set
# CONFIG_CRYPTO_DEV_SAFEXCEL is not set
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=y
# CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG is not set
CONFIG_ASYMMETRIC_KEY_TYPE=y
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=y
CONFIG_X509_CERTIFICATE_PARSER=y
CONFIG_PKCS8_PRIVATE_KEY_PARSER=m
CONFIG_PKCS7_MESSAGE_PARSER=y
CONFIG_FIPS_SIGNATURE_SELFTEST=y

#
# Certificates for signature checking
#
# CONFIG_SYSTEM_TRUSTED_KEYRING is not set
# CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=y

#
# Library routines
#
CONFIG_RAID6_PQ=m
# CONFIG_RAID6_PQ_BENCHMARK is not set
CONFIG_LINEAR_RANGES=y
CONFIG_PACKING=y
CONFIG_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
# CONFIG_CORDIC is not set
CONFIG_PRIME_NUMBERS=m
CONFIG_RATIONAL=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IOMAP=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
CONFIG_ARCH_USE_SYM_ANNOTATIONS=y

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=y
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=y
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=m
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=y
# CONFIG_CRYPTO_LIB_CHACHA is not set
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=y
CONFIG_CRYPTO_LIB_CURVE25519=y
CONFIG_CRYPTO_LIB_DES=y
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=m
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=y
CONFIG_CRYPTO_LIB_POLY1305=m
# CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
CONFIG_CRYPTO_LIB_SHA256=y
# end of Crypto library routines

CONFIG_LIB_MEMNEQ=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
CONFIG_CRC_T10DIF=y
CONFIG_CRC64_ROCKSOFT=m
CONFIG_CRC_ITU_T=m
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
# CONFIG_CRC32_SLICEBY8 is not set
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
CONFIG_CRC32_BIT=y
CONFIG_CRC64=y
CONFIG_CRC4=y
CONFIG_CRC7=m
CONFIG_LIBCRC32C=m
CONFIG_CRC8=m
CONFIG_XXHASH=y
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=m
CONFIG_842_DECOMPRESS=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_LZO_COMPRESS=m
CONFIG_LZO_DECOMPRESS=y
CONFIG_ZSTD_COMPRESS=y
CONFIG_ZSTD_DECOMPRESS=y
CONFIG_XZ_DEC=m
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
# CONFIG_XZ_DEC_ARM is not set
CONFIG_XZ_DEC_ARMTHUMB=y
# CONFIG_XZ_DEC_SPARC is not set
# CONFIG_XZ_DEC_MICROLZMA is not set
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_REED_SOLOMON=m
CONFIG_REED_SOLOMON_DEC16=y
CONFIG_BCH=m
CONFIG_XARRAY_MULTI=y
CONFIG_ASSOCIATIVE_ARRAY=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_IOPORT_MAP=y
CONFIG_HAS_DMA=y
CONFIG_NEED_SG_DMA_LENGTH=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_DMA_ADDR_T_64BIT=y
CONFIG_SWIOTLB=y
# CONFIG_DMA_API_DEBUG is not set
CONFIG_DMA_MAP_BENCHMARK=y
CONFIG_SGL_ALLOC=y
CONFIG_CHECK_SIGNATURE=y
CONFIG_DQL=y
CONFIG_GLOB=y
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=y
CONFIG_CLZ_TAB=y
# CONFIG_IRQ_POLL is not set
CONFIG_MPILIB=y
CONFIG_OID_REGISTRY=y
CONFIG_HAVE_GENERIC_VDSO=y
CONFIG_GENERIC_GETTIMEOFDAY=y
CONFIG_GENERIC_VDSO_TIME_NS=y
CONFIG_SG_POOL=y
CONFIG_ARCH_HAS_PMEM_API=y
CONFIG_MEMREGION=y
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
CONFIG_ARCH_HAS_COPY_MC=y
CONFIG_ARCH_STACKWALK=y
CONFIG_STACKDEPOT=y
CONFIG_STACKDEPOT_ALWAYS_INIT=y
CONFIG_STACK_HASH_ORDER=20
CONFIG_REF_TRACKER=y
CONFIG_SBITMAP=y
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_PRINTK_CALLER=y
# CONFIG_STACKTRACE_BUILD_ID is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
CONFIG_CONSOLE_LOGLEVEL_QUIET=4
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
# CONFIG_DYNAMIC_DEBUG is not set
# CONFIG_DYNAMIC_DEBUG_CORE is not set
# CONFIG_SYMBOLIC_ERRNAME is not set
CONFIG_DEBUG_BUGVERBOSE=y
# end of printk and dmesg options

CONFIG_DEBUG_KERNEL=y
# CONFIG_DEBUG_MISC is not set

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_NONE is not set
# CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
CONFIG_DEBUG_INFO_DWARF5=y
CONFIG_DEBUG_INFO_REDUCED=y
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_PAHOLE_HAS_BTF_TAG=y
# CONFIG_GDB_SCRIPTS is not set
CONFIG_FRAME_WARN=8192
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=y
CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B=y
CONFIG_OBJTOOL=y
CONFIG_NOINSTR_VALIDATION=y
CONFIG_VMLINUX_MAP=y
CONFIG_DEBUG_FORCE_WEAK_PER_CPU=y
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_MAGIC_SYSRQ_SERIAL=y
CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
CONFIG_DEBUG_FS=y
CONFIG_DEBUG_FS_ALLOW_ALL=y
# CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
# CONFIG_DEBUG_FS_ALLOW_NONE is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
CONFIG_UBSAN=y
# CONFIG_UBSAN_TRAP is not set
CONFIG_CC_HAS_UBSAN_BOUNDS=y
CONFIG_CC_HAS_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_BOUNDS=y
CONFIG_UBSAN_ARRAY_BOUNDS=y
CONFIG_UBSAN_SHIFT=y
# CONFIG_UBSAN_BOOL is not set
# CONFIG_UBSAN_ENUM is not set
# CONFIG_UBSAN_ALIGNMENT is not set
CONFIG_UBSAN_SANITIZE_ALL=y
# CONFIG_TEST_UBSAN is not set
CONFIG_HAVE_ARCH_KCSAN=y
CONFIG_HAVE_KCSAN_COMPILER=y
# end of Generic Kernel Debugging Instruments

#
# Networking Debugging
#
CONFIG_NET_DEV_REFCNT_TRACKER=y
# CONFIG_NET_NS_REFCNT_TRACKER is not set
# CONFIG_DEBUG_NET is not set
# end of Networking Debugging

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
# CONFIG_DEBUG_PAGEALLOC is not set
CONFIG_SLUB_DEBUG=y
# CONFIG_SLUB_DEBUG_ON is not set
CONFIG_PAGE_OWNER=y
# CONFIG_PAGE_TABLE_CHECK is not set
# CONFIG_PAGE_POISONING is not set
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_ARCH_HAS_DEBUG_WX=y
# CONFIG_DEBUG_WX is not set
CONFIG_GENERIC_PTDUMP=y
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_SCHED_STACK_END_CHECK is not set
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=y
CONFIG_DEBUG_VM=y
# CONFIG_DEBUG_VM_VMACACHE is not set
CONFIG_DEBUG_VM_RB=y
# CONFIG_DEBUG_VM_PGFLAGS is not set
# CONFIG_DEBUG_VM_PGTABLE is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=y
CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=y
# CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP is not set
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
CONFIG_CC_HAS_KASAN_GENERIC=y
CONFIG_CC_HAS_KASAN_SW_TAGS=y
CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=y
CONFIG_KASAN=y
CONFIG_KASAN_GENERIC=y
# CONFIG_KASAN_OUTLINE is not set
CONFIG_KASAN_INLINE=y
# CONFIG_KASAN_STACK is not set
CONFIG_KASAN_VMALLOC=y
# CONFIG_KASAN_MODULE_TEST is not set
CONFIG_HAVE_ARCH_KFENCE=y
# CONFIG_KFENCE is not set
# end of Memory Debugging

CONFIG_DEBUG_SHIRQ=y

#
# Debug Oops, Lockups and Hangs
#
CONFIG_PANIC_ON_OOPS=y
CONFIG_PANIC_ON_OOPS_VALUE=1
CONFIG_PANIC_TIMEOUT=0
CONFIG_LOCKUP_DETECTOR=y
CONFIG_SOFTLOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
# CONFIG_HARDLOCKUP_DETECTOR is not set
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=480
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_WQ_WATCHDOG=y
# CONFIG_TEST_LOCKUP is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=y
CONFIG_SCHED_INFO=y
CONFIG_SCHEDSTATS=y
# end of Scheduler Debugging

CONFIG_DEBUG_TIMEKEEPING=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
# CONFIG_PROVE_RAW_LOCK_NESTING is not set
CONFIG_LOCK_STAT=y
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
CONFIG_DEBUG_RWSEMS=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y
CONFIG_LOCKDEP_BITS=15
CONFIG_LOCKDEP_CHAINS_BITS=16
CONFIG_LOCKDEP_STACK_TRACE_BITS=19
CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=14
CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=12
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
CONFIG_LOCK_TORTURE_TEST=m
# CONFIG_WW_MUTEX_SELFTEST is not set
# CONFIG_SCF_TORTURE_TEST is not set
CONFIG_CSD_LOCK_WAIT_DEBUG=y
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_TRACE_IRQFLAGS=y
CONFIG_TRACE_IRQFLAGS_NMI=y
CONFIG_DEBUG_IRQFLAGS=y
CONFIG_STACKTRACE=y
CONFIG_WARN_ALL_UNSEEDED_RANDOM=y
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

CONFIG_DEBUG_CREDENTIALS=y

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_LIST is not set
CONFIG_TORTURE_TEST=m
CONFIG_RCU_SCALE_TEST=m
CONFIG_RCU_TORTURE_TEST=m
# CONFIG_RCU_REF_SCALE_TEST is not set
# CONFIG_RCU_TRACE is not set
CONFIG_RCU_EQS_DEBUG=y
CONFIG_RCU_STRICT_GRACE_PERIOD=y
# end of RCU Debugging

CONFIG_DEBUG_WQ_FORCE_RR_CPU=y
CONFIG_LATENCYTOP=y
CONFIG_USER_STACKTRACE_SUPPORT=y
CONFIG_NOP_TRACER=y
CONFIG_HAVE_RETHOOK=y
CONFIG_RETHOOK=y
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_FENTRY=y
CONFIG_HAVE_OBJTOOL_MCOUNT=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=y
CONFIG_BUILDTIME_MCOUNT_SORT=y
CONFIG_TRACER_MAX_TRACE=y
CONFIG_TRACE_CLOCK=y
CONFIG_RING_BUFFER=y
CONFIG_EVENT_TRACING=y
CONFIG_CONTEXT_SWITCH_TRACER=y
CONFIG_RING_BUFFER_ALLOW_SWAP=y
CONFIG_PREEMPTIRQ_TRACEPOINTS=y
CONFIG_TRACING=y
CONFIG_GENERIC_TRACER=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
CONFIG_BOOTTIME_TRACING=y
CONFIG_FUNCTION_TRACER=y
CONFIG_FUNCTION_GRAPH_TRACER=y
CONFIG_DYNAMIC_FTRACE=y
CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
CONFIG_DYNAMIC_FTRACE_WITH_ARGS=y
# CONFIG_FPROBE is not set
CONFIG_FUNCTION_PROFILER=y
CONFIG_STACK_TRACER=y
CONFIG_IRQSOFF_TRACER=y
# CONFIG_SCHED_TRACER is not set
CONFIG_HWLAT_TRACER=y
CONFIG_OSNOISE_TRACER=y
CONFIG_TIMERLAT_TRACER=y
# CONFIG_MMIOTRACE is not set
# CONFIG_FTRACE_SYSCALLS is not set
CONFIG_TRACER_SNAPSHOT=y
CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=y
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
CONFIG_KPROBE_EVENTS=y
CONFIG_KPROBE_EVENTS_ON_NOTRACE=y
# CONFIG_UPROBE_EVENTS is not set
CONFIG_DYNAMIC_EVENTS=y
CONFIG_PROBE_EVENTS=y
CONFIG_FTRACE_MCOUNT_RECORD=y
CONFIG_FTRACE_MCOUNT_USE_OBJTOOL=y
CONFIG_TRACING_MAP=y
CONFIG_SYNTH_EVENTS=y
CONFIG_HIST_TRIGGERS=y
CONFIG_TRACE_EVENT_INJECT=y
# CONFIG_TRACEPOINT_BENCHMARK is not set
CONFIG_RING_BUFFER_BENCHMARK=y
CONFIG_TRACE_EVAL_MAP_FILE=y
# CONFIG_FTRACE_RECORD_RECURSION is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_FTRACE_SORT_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
CONFIG_HIST_TRIGGERS_DEBUG=y
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=y
CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=y
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
# CONFIG_STRICT_DEVMEM is not set

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=y
CONFIG_EARLY_PRINTK_USB=y
CONFIG_X86_VERBOSE_BOOTUP=y
CONFIG_EARLY_PRINTK=y
CONFIG_EARLY_PRINTK_DBGP=y
CONFIG_EARLY_PRINTK_USB_XDBC=y
CONFIG_DEBUG_TLBFLUSH=y
CONFIG_HAVE_MMIOTRACE_SUPPORT=y
# CONFIG_X86_DECODER_SELFTEST is not set
# CONFIG_IO_DELAY_0X80 is not set
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
CONFIG_IO_DELAY_NONE=y
# CONFIG_DEBUG_BOOT_PARAMS is not set
# CONFIG_CPA_DEBUG is not set
CONFIG_DEBUG_ENTRY=y
# CONFIG_DEBUG_NMI_SELFTEST is not set
CONFIG_X86_DEBUG_FPU=y
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=y
# CONFIG_UNWINDER_FRAME_POINTER is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
CONFIG_NOTIFIER_ERROR_INJECTION=y
# CONFIG_NETDEV_NOTIFIER_ERROR_INJECT is not set
CONFIG_FUNCTION_ERROR_INJECTION=y
CONFIG_FAULT_INJECTION=y
CONFIG_FAILSLAB=y
# CONFIG_FAIL_PAGE_ALLOC is not set
CONFIG_FAULT_INJECTION_USERCOPY=y
# CONFIG_FAIL_MAKE_REQUEST is not set
CONFIG_FAIL_IO_TIMEOUT=y
CONFIG_FAIL_FUTEX=y
# CONFIG_FAULT_INJECTION_DEBUG_FS is not set
CONFIG_ARCH_HAS_KCOV=y
CONFIG_CC_HAS_SANCOV_TRACE_PC=y
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=y
# CONFIG_LKDTM is not set
# CONFIG_TEST_MIN_HEAP is not set
# CONFIG_TEST_DIV64 is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_TEST_REF_TRACKER is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_STRING_SELFTEST is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_SCANF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_SIPHASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_BITOPS is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_TEST_FREE_PAGES is not set
# CONFIG_TEST_FPU is not set
# CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
CONFIG_ARCH_USE_MEMTEST=y
# CONFIG_MEMTEST is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking

--V++dxUXzRYNSLmrA
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: attachment; filename="job-script"

#!/bin/sh

export_top_env()
{
	export suite='boot'
	export testcase='boot'
	export category='functional'
	export timeout='10m'
	export job_origin='boot.yaml'
	export queue_cmdline_keys=
	export queue='int'
	export testbox='vm-snb'
	export tbox_group='vm-snb'
	export branch='rt-devel/linux-5.19.y-rt-rebase'
	export commit='6e72f137fdd27b79014ed848d16f03e6d239f2a2'
	export kconfig='x86_64-randconfig-a002-20220718'
	export nr_vm=160
	export submit_id='62dd0fa60b9a9318e64e48cd'
	export job_file='/lkp/jobs/scheduled/vm-meta-272/boot-1-yocto-x86_64-minimal-20190520.cgz-6e72f137fdd27b79014ed848d16f03e6d239f2a2-20220724-71910-1ua5uc8-0.yaml'
	export id='35712fc8f05fa28c1384eab22b218e4d532f2c30'
	export queuer_version='/lkp/xsang/.src-20220723-170131'
	export model='qemu-system-x86_64 -enable-kvm -cpu SandyBridge'
	export nr_cpu=2
	export memory='16G'
	export need_kconfig=\{\"KVM_GUEST\"\=\>\"y\"\}
	export ssh_base_port=23032
	export kernel_cmdline='vmalloc=256M initramfs_async=0 page_owner=on'
	export rootfs='yocto-x86_64-minimal-20190520.cgz'
	export compiler='clang-15'
	export enqueue_time='2022-07-24 17:23:50 +0800'
	export _id='62dd0fa60b9a9318e64e48cd'
	export _rt='/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a002-20220718/clang-15/6e72f137fdd27b79014ed848d16f03e6d239f2a2'
	export user='lkp'
	export LKP_SERVER='internal-lkp-server'
	export result_root='/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a002-20220718/clang-15/6e72f137fdd27b79014ed848d16f03e6d239f2a2/21'
	export scheduler_version='/lkp/lkp/.src-20220722-141741'
	export arch='x86_64'
	export max_uptime=600
	export initrd='/osimage/yocto/yocto-x86_64-minimal-20190520.cgz'
	export bootloader_append='root=/dev/ram0
RESULT_ROOT=/result/boot/1/vm-snb/yocto-x86_64-minimal-20190520.cgz/x86_64-randconfig-a002-20220718/clang-15/6e72f137fdd27b79014ed848d16f03e6d239f2a2/21
BOOT_IMAGE=/pkg/linux/x86_64-randconfig-a002-20220718/clang-15/6e72f137fdd27b79014ed848d16f03e6d239f2a2/vmlinuz-5.19.0-rc7-00020-g6e72f137fdd2
branch=rt-devel/linux-5.19.y-rt-rebase
job=/lkp/jobs/scheduled/vm-meta-272/boot-1-yocto-x86_64-minimal-20190520.cgz-6e72f137fdd27b79014ed848d16f03e6d239f2a2-20220724-71910-1ua5uc8-0.yaml
user=lkp
ARCH=x86_64
kconfig=x86_64-randconfig-a002-20220718
commit=6e72f137fdd27b79014ed848d16f03e6d239f2a2
vmalloc=256M initramfs_async=0 page_owner=on
max_uptime=600
LKP_SERVER=internal-lkp-server
selinux=0
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export modules_initrd='/pkg/linux/x86_64-randconfig-a002-20220718/clang-15/6e72f137fdd27b79014ed848d16f03e6d239f2a2/modules.cgz'
	export lkp_initrd='/osimage/user/lkp/lkp-x86_64.cgz'
	export site='lkp-wsx01'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export schedule_notify_address=
	export meta_host='vm-meta-272'
	export kernel='/pkg/linux/x86_64-randconfig-a002-20220718/clang-15/6e72f137fdd27b79014ed848d16f03e6d239f2a2/vmlinuz-5.19.0-rc7-00020-g6e72f137fdd2'
	export dequeue_time='2022-07-24 19:37:32 +0800'
	export job_initrd='/lkp/jobs/scheduled/vm-meta-272/boot-1-yocto-x86_64-minimal-20190520.cgz-6e72f137fdd27b79014ed848d16f03e6d239f2a2-20220724-71910-1ua5uc8-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-slabinfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper boot-meminfo
	run_monitor $LKP_SRC/monitors/one-shot/wrapper memmap
	run_monitor $LKP_SRC/monitors/no-stdout/wrapper boot-time
	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper heartbeat
	run_monitor $LKP_SRC/monitors/wrapper meminfo
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper sleep 1
}

extract_stats()
{
	export stats_part_begin=
	export stats_part_end=

	$LKP_SRC/stats/wrapper boot-slabinfo
	$LKP_SRC/stats/wrapper boot-meminfo
	$LKP_SRC/stats/wrapper memmap
	$LKP_SRC/stats/wrapper boot-memory
	$LKP_SRC/stats/wrapper boot-time
	$LKP_SRC/stats/wrapper kernel-size
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper sleep
	$LKP_SRC/stats/wrapper meminfo

	$LKP_SRC/stats/wrapper time sleep.time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper last_state
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper time
}

"$@"

--V++dxUXzRYNSLmrA
Content-Type: application/x-xz
Content-Disposition: attachment; filename="dmesg.xz"
Content-Transfer-Encoding: base64

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
zgABn8kDvpNSFG8cybHEZ/sCAAAAAARZWg==

--V++dxUXzRYNSLmrA--
