Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A65150851C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 11:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377288AbiDTJlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 05:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353200AbiDTJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 05:41:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7F421811
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 02:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650447544; x=1681983544;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WaDXMpWIpoHY9cM17X0jl7A9FzyMWa7FwbQUV+wI8yI=;
  b=ODVBPaC0g9P7oBmhXwEEbFEJvFIQDGRAalcWjDpgqcoA6yz2+5VulWjl
   Y388zgyplytRYuBm6Hvj2gBnZgGCuFd98iFxSanLpQZNDqJVmwBfQoUUM
   GK6KrvfZlill8IPCwcDRH/YW8tO1SmAvx6xk8x0/WnmwsWbqsIWUsp6nb
   Csx7lwW4r4TuC1zsaTw5zCrSED5a+gKihZr5RSP2J4xnnUyw9/555strn
   4RUS2VE3MgcTIDe8cXcc5gg5rmQeEKMWEuXUeggwEtfaEDxNNG4jWSmuS
   8W9iDPrFx0Kwx8LM7BJ5LanJzlWDGKS87Tb4/yZ4dqImUTUZJzoFKsD88
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="261589926"
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="261589926"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 02:39:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,275,1643702400"; 
   d="scan'208";a="863412925"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga005.fm.intel.com with ESMTP; 20 Apr 2022 02:39:04 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 02:39:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 20 Apr 2022 02:39:04 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 20 Apr 2022 02:39:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd6yAQ52Ptkq357GV0vkYtGvPwNiDE3UDI+YWjnHzU1ypr4AMtLAhYcxrT/pJhJATvAZ9cRlJxovmIRq3NhN+Y+QkPzH0qVKNuOUGb8WQvxKfLwAjixhJgz6PZwyr3GjWt7glIf2S2LcxuhrSQi0D/WYrHPkJWoNUQPSXonkb8T04VYEw0Oohtbewxr/hl70TvWF1Ct/tFIUeRkm9P1cnDrmIH+C3SCwcDZvuQwHrLJGEpprVPx73zNJ6+tQ+qiA4pRzthtyb9nK7vAnHuEnnQoJz/z/+DWKTws2hAOo8JIpCAzs5sTgh46qiec9x2n70re0JHn2haCWFmVQ8ipSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+rt4smU5J2DB7NPDPmsIa12Bt0PTL7ONQBod5cKWoc=;
 b=Bg8anPQ5d4nNB3Bk54N9NqpnsM2+vRbteOiCsmVoHpBd9rOMLFy6YuHpzIrYhH5W64mdiv9kV3WxxodHWJgfoT27MXgzqSuuOIbdYA3DE7yb8T8Kj4bXXsfleIk1+dDsHFECjTzbdI7LNR4LFiZuBAbALb7hvXYRrBJOXPC61hy/HIzh0jrn2GmMBvCvIyM8xIJQdgLRuRJ1oN0HB5ey5wjViY9Vs+e8IqGH0d+tnnlb0D8w0pbffC65LyxHyiR0XnfvkAou+da+byZ6kdmAdZElg/WLT85hbs+Ioc8mEeIqX/VvzEIp4t1wrfnIAiy2p62nJxPXVGKgs+dTe3mF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by DM6PR11MB4043.namprd11.prod.outlook.com (2603:10b6:5:199::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.25; Wed, 20 Apr
 2022 09:39:02 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94%7]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 09:39:02 +0000
Message-ID: <72b361de-9b73-ba42-9c65-427b9faa1838@intel.com>
Date:   Wed, 20 Apr 2022 17:38:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: [djwong-xfs:vectorized-scrub 213/396] fs/xfs/scrub/tempfile.c:
 xfs_swapext.h is included more than once.
References: <202204181219.06eeZ4QW-lkp@intel.com>
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     <kbuild-all@lists.01.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202204181219.06eeZ4QW-lkp@intel.com>
X-Forwarded-Message-Id: <202204181219.06eeZ4QW-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0044.apcprd04.prod.outlook.com
 (2603:1096:202:14::12) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee92baf2-434a-4d47-bbad-08da22b19a5d
X-MS-TrafficTypeDiagnostic: DM6PR11MB4043:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB40432B80894B9FE943EE602EFBF59@DM6PR11MB4043.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SRXbsm5UMMV475t/nnhKetjo9yXTPyry7q0Az5LQ2G6mLkv5zH/JodgmbxhBsuy9WiIwUFvAntTDYR6H2N7TE9IY0ZMDDLB4jO4gFL5HKLGvpT4zXxKNX5Pk+ddTKSZL/y5wJrBemDGqdwcunsvX8mDGqQHNubVhuU2YssTHXtIiH7l97SM5/nllNiBu6yXs/1h7upJEUt1YRsmM+PSe3aPPpOQdrJczAf/S1yBuwrbgt/3RvLScggW3QtMc22vtXMoQQozlFycoZn7hkso0yj/sljYrqIqHcvgUt0fzPhbwOpfUJGCGlLDeYR0BoL5Cz/mGp2CVzeINKNvT5Who813bQtwFZXpHUfHKv3A0W424Hs1jyurr672RksHm9XuR17UUYjkb2yGAVyxBjU6FY+kMMX201bJvNs1k8uJwASPGqu3RxxiUHQ5nscwsqG5LcRNjteTzDZKSkn2LTBqRA2OVt2ozw0IF4yIYJ5eXOwtx8o90LxDkuT1wwoxsVQ9s/AENiRXyVmwQ+YuXMkzaQmm2/8xC2P/isfqjQ/K9bUMIsRc7SXnAvLyMNX/HU7i6b/kZJU743Rh2Wd8V6CZ8OaEYSm99XqhSPKuQoHIuXQL3I5xXAnUoS40zdmItJteyjFuQnLFbtsJAHFk2WWL/pXe5bD5YMHX1LezbRnqOeQ5eOO6nury6ffc5CS2OmrB0Ri4OQR7Cf7E1axd/QQ6TOMoymX1pwj2YRdwMqLzlbqIpr0ZBhEFQmeZTyoVczNGrhi3d8M4HJVoSbG6Ua8iEcKiJi/kncPhj0Fk6T8Gb/QifcwfSiccdwtO7JLwKWEwuT/EmvnOuRFbO/+hEKLhkfRzPqOcaGdF3XGYUywA05gs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(2906002)(26005)(6512007)(54906003)(8936002)(6916009)(66476007)(186003)(66556008)(66946007)(6506007)(83380400001)(8676002)(4326008)(966005)(6666004)(31686004)(4744005)(508600001)(36756003)(38100700002)(86362001)(31696002)(82960400001)(2616005)(5660300002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlNtQXNoNUtEUGJBaDVybU9HTVBXS1RDbDNOV0NEdW1DTWk2QlY4SHIyeW5q?=
 =?utf-8?B?Y3hTZnQzRWJ4MGVQWlIyLzdZcWRybnlpM05JNjBtNGMxaXVGQmVvNFlKKzhE?=
 =?utf-8?B?cWNTSmRtLzBFVmtNRHVLV2x2bzg1cytKQjFUdDB0cENaL1BZQjFLbnphY1hi?=
 =?utf-8?B?dUdMZ0sxRktpbWZyU1lGOXl6RFBiTFRzMU5zRzUxNUhGTHYrTm1RZ2hhbzYw?=
 =?utf-8?B?NFRDOFhyL3U1RE83THNJRTE0cnZWbDhBcjRPR21yaHBieVRMUnlSQTg5UUNn?=
 =?utf-8?B?UXRuWVorMVlFZ3dNSjQ5NmNzS0hkN0NtOHVxSDVwOHlmYXlPWkNsSitGTk5Q?=
 =?utf-8?B?RUJZd0UwWFJ2a0hDRUpLblBWQ0V0bWVFOTBVMnI0QVZSQ3BrS3lmL2FMRWxn?=
 =?utf-8?B?QWl5Q1dtYktIcTdTc3gxdlVFVElDKzNwR2F1YVlQREZkTlkwbHA0OGhzTjRF?=
 =?utf-8?B?ZVpWQ21CM25KMzJaT3RVMnZKRkdnTjhmSUd5bkdvRjE3bjREMUJFZi9mOENp?=
 =?utf-8?B?U1o0OWxQS29QeE5US1NPWk82WFdpcjJUNyt6VHpFUFA3NlRhc1k5YzhXUmJz?=
 =?utf-8?B?T1RXZFlCSWRMWVFzdU4zak1BSXJDRE84Sm0zZ0xCYkt1c0tXaVM1ME5KdmRh?=
 =?utf-8?B?SVRiSHR6bHNpZkdKYnduS1lOQVJwbTBrcFluVGJTWE9uT1lnOG5hVFZYRWph?=
 =?utf-8?B?QVVBR1JDOVVrUUxMbnBicG52MHg2d3ltckZVeThvNGNhczNvU2dRZjFWUUVy?=
 =?utf-8?B?VzhJWnVja2lkR0ZQYUZYcHlwM0ZRKzNYODFwU2taK043R0ZaQ3ZUUGp1U2xH?=
 =?utf-8?B?Y0NsbGtzNkJEZmNJNHhoWHd4dDEwTXFnaWxqQnMxcWVYQXhsU0pQK3NLZjd3?=
 =?utf-8?B?Ryt0UVpBOVJYVUNCc0p6NCtFNTlabUFFemkvVjcwZDlxTjNWQXdwdlJpOVk4?=
 =?utf-8?B?dnVXM2RpLzRMRVh3MFB1RUtUejBLMGhQQnpYZUV1WFFITlBaUUhXN1dtSDdl?=
 =?utf-8?B?R0YrcTdQb0RRdy9yZGI1aS9PNzVDMXU3eDlkemx3ckMycVVzM2xMVnJzQTFG?=
 =?utf-8?B?ZmpOL3JCQ2lKWW5YODRDZnBmMDN4cXNsZTdCSlNFNTEycnFJRzRpV2xxcC9p?=
 =?utf-8?B?SndQWmdiODM5RnZDZUhOamRhVGdNUHhwLzg3a1RXdlZzQ2FVb3ZWaVdnNm9y?=
 =?utf-8?B?RkZYYXNWSHlNVjlMKzgwdmdNM2FibWhiMTB3Y0ZXOXNSYTd1YjJHMk9vOFp4?=
 =?utf-8?B?VVhUeXBxYVRRakVWbWkwYVF0T0p4V3RuVW16SkFQcWhsMmsrbXFNRmlPVUlV?=
 =?utf-8?B?dkIyYWc2Ri9pcXBkaUx0THZUUnFNR0ZxYWZMVEpiV20wWTN0QzJ3MEdqV2E0?=
 =?utf-8?B?cTZRbDNmVFNnRGI5MSs2SmovV21XOGlsdlk0THBTVmtmZHcyMUF0NVhXQm9X?=
 =?utf-8?B?ZGZzKzEwUGZ0ekt4M0hXanFxSXJHY1phTzBuMm9MQkxldTdHUU9QcUJ4QW5L?=
 =?utf-8?B?VEZocWIwazV5b3NhaFhhVllPdk1QbVRZSElSR0hPVDBqOGpBaWoxR1RyV29t?=
 =?utf-8?B?ZXpkQTNLYStRWTNpbUlOb3dTSGJFZ0ZLRzNxa1ZNdGpMQUpwNVNsQ3QrcURp?=
 =?utf-8?B?WUhjVXVoTm9HSzMxL1R2R0tQWWx3d0V2eWV3MlBjL3N0c3BTeEFud3hvdmdl?=
 =?utf-8?B?WmJUYXdQUEdmY1o3NU1EMHNMajM4NnJuTWc0b0VsaGlQVmJtN0lrL2ptTm1u?=
 =?utf-8?B?L2ROVUE2MnZycml5ZUgydTZLMjg5MDhiczZlRHdiTGZRcDVVUXVFNEdaREc0?=
 =?utf-8?B?TlFxNlZORVhuT0FPZ1pWbUFwcU8va3E4T2V5aVNnWEljVlRlMVJQU1JZS2k1?=
 =?utf-8?B?Mk9yYXFXRTNTb0laK1JTdXF2MmI0bVMyY01aeUhJcDFUU2RJMDZWWEN1dHJu?=
 =?utf-8?B?LzFwSGhaY3lZbnBuT1J4ZFhvcEdWekVDekVpd1FZN0VPaCt2UEtyTmR2bEUz?=
 =?utf-8?B?YThIVlJiR3lHTjR3Ni95VmE1WUN3dlZxRk51V2ZTVUQ2OCtEVCtRUmdpaDUz?=
 =?utf-8?B?VmpRMWEvaitzUzRwb09kRGpBdmRrbElGcHJpcUlkYVZnL1hCTGFvWFdIZnlG?=
 =?utf-8?B?M3c1bHF5M1hqM01ZQWRBZFF4LzNySlBRVm5pMDlnYnVSZ1RSUXR6aSsxeG9H?=
 =?utf-8?B?TmJiQU1ZNTRWZnR5Q294M3NSZDhaYTdiM2dXWkprN1N2ZjAzeTBGZWZYVGJB?=
 =?utf-8?B?c0UwMTdwVHFSWTJlbVY1cjNTOHZ2NUJEMXpTR2llYXlhYnFhNzdHT3VvSVo5?=
 =?utf-8?B?cFdiNFV6TmZtMjg0NGU4bTZvZmo0cXhGQ1NSTFBVaEhXU3NCZlVJUEFQa2s5?=
 =?utf-8?Q?So7j0+bJZkir2t3Q=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee92baf2-434a-4d47-bbad-08da22b19a5d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 09:39:02.3795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wr260M7qq+QtMvs5JmVFH5RC21K9G4IviCQM2guhxta+T+jRYtsj8rQ8vwGurtajFgAbeecv7kT7UyHz5NQkRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4043
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git vectorized-scrub
head:   bd756ef7af68274b79308166ee64949d288be861
commit: 6afd53176c5009c110bef144253a84294ab77272 [213/396] xfs: repair extended attributes
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> fs/xfs/scrub/tempfile.c: xfs_swapext.h is included more than once.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
