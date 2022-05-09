Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955C051F836
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbiEIJda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237550AbiEII65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:58:57 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767B85591
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 01:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652086504; x=1683622504;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hzBckINf98LVeugVNyA7nqD38cJhvXwOwhOt/TRbFLQ=;
  b=VAHRpYyGbJYgc9CNnjBh9KJnKlX0pvr/T1tnZVe5RtHjq4y0hQ9Cqqax
   /9NSzNRfhVB9qCJFrfHALGRSDyna5Quxiao60v70P1dL/PBfscPZc+0PI
   08CO6qa//cSqhcJlumbr6Wrn5ZolPwkKDxWjUKnIZFWqKNeXbWwrtqPjh
   9I8ipJpmveLK3QN3MbRHW4VLgSg4S1ZwYL2GBg4QYYLr9GS9E9V3M/HEo
   gO+z+6H1qMPqs2wo6swjzEejRpqtlFHM1+pxVEHdtA8Y6AEa0x19+9RKL
   5nAvyD3vwjWr2UCd0l2JzFnIh6Yq+XcTfIfMztUCw6Kncm6Th0WZwEt3D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="355415277"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="355415277"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 01:54:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="696326705"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga004.jf.intel.com with ESMTP; 09 May 2022 01:54:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 9 May 2022 01:54:39 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 9 May 2022 01:54:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 9 May 2022 01:54:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6pGFKXAcRRWWallv4c46Mmjl3V5PjC9UgdSbbw/RKTzlkjs2sbHTnWOVkqF0kgLBdOGS2+QVypiA+XzjftY9UrKJ/OfJFyFPHMmuhxWGYgZndlQe7loeQ8GscZGJgY2etefmDmZzoCvOSEbaMw6DyyStqMJYvryfzz9lxsS9Ui/B01yIbH/x9bjTQCsBSjFPhy57MP0be4FKpYvSOW4m7grEHjXDvQlW0xkA9fxmuhue8GDbzjoezdYWcOJ7zfpngCE1GFPDIBRUs3dUNuz3/y3LGzJJKkxjr93yN2jF1xe5Kv6kQSoNgkiCXA3SSlX+r9cPkZbtlwo61xvxiOs2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXDPYxix8UmqUD0QgvyheVVOFk1S3cFw2y5yMQ+MJRA=;
 b=UpvJbA31+YwA4CFaKGly+JNTrTLF8vPFE1LWUMojYrYhd+HB+iKKzI8PT7uniDq+YnRnUIfkvYn8aMtn0H6bA/JvsfOiH5Jqs9667VGzhrXe8nC/v9bWAHqdsWOLFZXA1BcZoW9OFt3ZYtYIPjpTIxSeB9jr5JO4ov74Zf6Douk+7xlxVP4B4kycCSNWClWNZ8+yUNhq/kwSCUHBVdLA7AXfRFckDAE5m0Zmn/0bytKVgc05Us68d9SbMiCj0+1ngpvXT/dmkuxjvynV8CpcGTf1qwDEbZU8wW6FLg7rzns1dQSCYqlod2uZK7w/ibm8efdQ7qXmZPWqKGlPIV8bgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by SN6PR11MB2621.namprd11.prod.outlook.com (2603:10b6:805:59::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 08:54:36 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::91fc:35fb:9ebc:81ec%5]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 08:54:36 +0000
Message-ID: <0a725ef2-0f2a-f096-c8ae-af1d95b97479@intel.com>
Date:   Mon, 9 May 2022 16:54:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: drivers/staging/iio/cdc/ad7746.c:244:24: warning: The statement 'if
 (chip->capdac_set!=chan->channel) chip->capdac_set=chan->channel' is
 logically equivalent to 'chip->capdac_set=chan->channel'.
 [duplicateConditionalAssign]
References: <202205020654.2NsUk8eO-lkp@intel.com>
Content-Language: en-US
To:     Lucas Stankus <lucas.p.stankus@gmail.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202205020654.2NsUk8eO-lkp@intel.com>
X-Forwarded-Message-Id: <202205020654.2NsUk8eO-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HKAPR04CA0006.apcprd04.prod.outlook.com
 (2603:1096:203:d0::16) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b732771e-5e8a-42b4-7499-08da31998b2a
X-MS-TrafficTypeDiagnostic: SN6PR11MB2621:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB26219B75FBF88E7F51C39644FBC69@SN6PR11MB2621.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tkU4COVzqPrVdNUdrZ/CQaqE2PY7/iTAarrDWBHtYW49rsxlIvD7RnaNFouWRnZxmxaqU0aPuEYqdFtzGHckP5oZxzZFJdPWRwEZUse6XqIggx5DTKQwXEeeY1ahFroPeixDSrNtpbWnsl0PA0ho3SAzYrehtRQCildlU+FCPG7xM+NVt1wiC5UuR07BoLrcgdcc9qPpp8qz/gRSHJQ5pVPWGlNgW2RnTbEhVVQDuX8Vvcb9oEenaVpn2svGUKXeKPLUYU7LV8R36gjPuq+4dS8rMTK9FNsuIctLwEWgbQUyo31ZxbC3GbMlCIG/5Td4jSkCoobMRYJ+XfIHZ4y9mKv+6UzKraEFclTG10vXNJ34ITN6zWETckWs/CvQZNWdG0hU41GGy8paJn2YsHrFc+RBJCUlvk+7RKRhGx4G5QEPOcggTUjsQYgC2v+NnxaXyMZ3ehqXrZSsmc+zxbtQN++EweyLMbO04DohjNnaHR0/jiKI3sLaSyx7ehO8rFtltyYrwc4DnNb98pXtVAbZDQDZq3VeAcheOlXEyXQqCsWuEUkoSnOWM8w9Niyci60IFKO2ZWIZtdcyYBdXxS1bOf2CPi5X+8YCX8oK/sNsHk7GUJ2OiRw2EiEwUUxvCj+7JvGYJ6MbQsrIMfAmSBXs5Uhuwjar9qQba4CWcZ6oP657Whz+WCl+twapPxO6Uo0+GAQDiOzljm/PO7Z86FVR0Kk7hZ83kTe0kmklfFaC6apbuqsLnbkx8jG11jhbdHanNcTyUxelooemN4becJFWQboY5K/mi5F+XVkKlsvmwpeQc3K1VuoM+pdwooAafA6CF6t7pIhwGHgT7D14RoKAnzI3z8GTvF0boadalF85v5Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(2616005)(86362001)(36756003)(4001150100001)(5660300002)(83380400001)(8936002)(31686004)(6506007)(66556008)(82960400001)(6486002)(66476007)(26005)(508600001)(6512007)(6666004)(316002)(66946007)(66574015)(966005)(54906003)(31696002)(4326008)(8676002)(6916009)(2906002)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVN2Z1QwOStyb2t5VmZrUXEzZVBUOUxzSWxEdVJ2SzVhYlQ5d09hcTk0em9l?=
 =?utf-8?B?Y083S3dRY2Rsc1lSZWVhcVpFckl1U2pESXV6YmcxSTZ5Z0UzblRkWHlWWWxp?=
 =?utf-8?B?ejFlVnVxNm5GWGhVZVd1NCsrOTBXaUZYQi94MGJsVHhhN2crejNZaktXbGRo?=
 =?utf-8?B?aE1ILzd1UUVjekV6OGNJc0xkZDkxTTluTURtbXdSUU42dUt4ZHNjZU9QbXAy?=
 =?utf-8?B?NFV5K211Y05WZGpSQ1VJUVdMNmVHVDV3Y0o2QnY3Y2FSRzNHTjVhcWI4R3hx?=
 =?utf-8?B?NVVpaUMwcHB4UkpMUUJpMVlmTndZZldDSU12dWd2T3VXRW5HalYxYXZCTEVQ?=
 =?utf-8?B?ODV0M1RDclZtNGgzWGszK29YOVVKL2tQZDVUMXlTRVB1Qys0aWRWelJvVU01?=
 =?utf-8?B?OVBzUzFFbTRDYTIwNUVnb014NDVMeGprdGNXM0hRZVFLd3I3eVl2bGt6Smti?=
 =?utf-8?B?VC9LVEpYSzNuZXFvTUFWWjRLb1Z1SU1CNnIwVVJLbitOQk1QK2NWY0hQNnU1?=
 =?utf-8?B?aXdjL3loT1NmZmZkd3BUZ1FFZDBzNllnOFJsS1dEODV4RXQ3eEtFaUpwek5a?=
 =?utf-8?B?NWc2emQrMWxhS0VtaFM2R0IwRlB4SWdCendLSXZlRCtHMExiQU5rcjQ4L0JE?=
 =?utf-8?B?ekpTVXJlRmVNU1R3dE04Y2xwVkkrZWs4T0Era2F0bTUvQTNpVXhJTURyQ3NM?=
 =?utf-8?B?aDZ6TWhGQU5xQ3g3eUdGQXRiMEd0Sk11RXU3L1hkNVNBUTRXdlhtUHdmeEd4?=
 =?utf-8?B?UmVhSXBrdnMvd0p2dUtjOG8vMUE1cFdzSW9zN0ZlOVZUV3MrVW4zQlppNTdV?=
 =?utf-8?B?bTMwOHJCdE0zL1EzR0FNdnpKYk5JTU5GRUVPUTNMd05ETHJFaFQxUWZvOFlx?=
 =?utf-8?B?Y2pOVTdVQVlaYzAraVd4VkticWYrWjhpL3dkZnFvdFV5bHdDSWtuNlg4ckJp?=
 =?utf-8?B?YXVrMEJXNVE1RTdyZmUwOGIvMFhkQUExcmVjQXZocEpUYjkzVk1VYm8rVGpT?=
 =?utf-8?B?TzJMYlhDbVhSdFRaWHR6ZFIyT3BTVUxlVHpyK1VYaVNpNGIyUnliZWtXRHRh?=
 =?utf-8?B?SHBFSktrRHY0Nit5cmE4L1RVai9jTS9ESURQQmxNZTBPbDZGbDJkSE5Fb2lX?=
 =?utf-8?B?aDlRZFE3SVorcDFlUGhOU1dabzRYeENUc3B5YUNWeksvL2h6M095QjU0SENB?=
 =?utf-8?B?Tmp1bEtIdUQrY0hVaytrc0dIaW9oWG5FSnNVa0Y0cmNxSkxSeWxaTUtvL05o?=
 =?utf-8?B?cWtRY1ZaWFVYR1MvVDdiOFd3aWFrYnBnQzZvYXJicmtiUWU2Q3l6UjNlQWcr?=
 =?utf-8?B?K2xNWVhJeExCYksrZk1KOWtrY05FQTZMeEdIazAyZDIrMnhCUmM5eDhKK3Vl?=
 =?utf-8?B?TUgrNGk0aWhBZmVPTHhJNVlZTEpoTDVicnNSNTV1UW5DNGtrTks5cnFZZVBZ?=
 =?utf-8?B?d1JSd09RK1BCQ0hqZjNWYk1sQ3I4T3gvZ2NEVllubFVoSEdESWZKbWUyckth?=
 =?utf-8?B?T0Y5Y1NIZGFYNkF6V1ArQTdNMW9xSGhwUUZoS212akgrODBTUjFhcGxPNWpj?=
 =?utf-8?B?NFFhNGhVVnNSRU5ZQ3dVNlZrMFFZRDMrQjVXcmpLejZ2cXltMkVSRXliMUZj?=
 =?utf-8?B?UFJ6WEtTMFNXRkhMYVZtZVlwTTJpYmoxSlVzV1RnMkl2TTJIWWZpRURPQW5B?=
 =?utf-8?B?Z1NmTERMaGtMSWEvdUNjK0ZJS3doWUZCYWwrNGxNTXVDMG1EREwrL1ExYllN?=
 =?utf-8?B?N3FLdDN2bWZ6VmVxU3plaHEyMFJwSHRkQUtUVUFWeURzcjRld0Vmd2VCVExQ?=
 =?utf-8?B?L3B3SlpJamUzNEM4T1p4ZG5KWUh6Qm0rU2NKVGhQNUdwdUJHazdwTGZoSzZF?=
 =?utf-8?B?QWZyQXNWY2FvaVRDTmNOcHRLNVhvUThScEVRZ1hkVVlQdnYrMlkydVl0VUIv?=
 =?utf-8?B?TFpKT3JVdmJwOEhhdTR0anRRU2lsWFJzUy8xUjJBM1NqOWd4TnFZMHVLdndl?=
 =?utf-8?B?bzZQNE5GY0RRRVM3QjJwSE9SQWdxYnpXRGJPckhnTUZ0S3d5c3doNk5IazU1?=
 =?utf-8?B?d3ZuMFE2dExZQytnK1h5Zmx6MFpWWjBZZ1NhWFlVcCtJL3BDVlZNL0ZaY1Ns?=
 =?utf-8?B?M1p0WU5kQnNVSis3NGVLb2JYb0ViM2lqZ0ZndlB4MU05R1JFM0RmVzk1MmFn?=
 =?utf-8?B?RndKRnhCeXdzMG5WamorWUplOFNrSDN1cGw2T1QraVBwNzl5bjFWUjBESEw2?=
 =?utf-8?B?aWI0VnRTbXh6bU9Qc242c0ZYZkxkQXc0OTVlVTBsUVNGakY1QjRiTzNVVWhm?=
 =?utf-8?B?T3hnU2Iyb3FDSVFiSjRTOWpnWmlvU3NhUU9Lb0NzQnVaeDFzaGQwQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b732771e-5e8a-42b4-7499-08da31998b2a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 08:54:36.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3qu/vwMZINl25ru1PUefs+YP5OtFAUVjfuq0hcIuCFPQ6fX1Svb/bC62W0PAmz36gsveSuO6Kj5euHnQSDFwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2621
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   672c0c5173427e6b3e2a9bbb7be51ceeec78093a
commit: 6a7e4b04df3f4fb91a1516671a2610a0ac9f0c69 staging: iio: cdc: ad7746: extract capac setup to own function
date:   11 months ago
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (cppcheck warning):
         # apt-get install cppcheck
         git checkout 6a7e4b04df3f4fb91a1516671a2610a0ac9f0c69
         cppcheck --quiet --enable=style,performance,portability --template=gcc FILE

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not be real problems)

 >> drivers/staging/iio/cdc/ad7746.c:244:24: warning: The statement 'if (chip->capdac_set!=chan->channel) chip->capdac_set=chan->channel' is logically equivalent to 'chip->capdac_set=chan->channel'. [duplicateConditionalAssign]
      if (chip->capdac_set != chan->channel) {
                           ^

vim +244 drivers/staging/iio/cdc/ad7746.c

6a7e4b04df3f4f drivers/staging/iio/cdc/ad7746.c Lucas Stankus     2021-05-23  224
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  225  static int ad7746_select_channel(struct iio_dev *indio_dev,
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  226  				 struct iio_chan_spec const *chan)
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  227  {
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  228  	struct ad7746_chip_info *chip = iio_priv(indio_dev);
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  229  	u8 vt_setup, cap_setup;
afcd0b22e35e0b drivers/staging/iio/cdc/ad7746.c Hernán Gonzalez   2018-04-13  230  	int ret, delay, idx;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  231
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  232  	switch (chan->type) {
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  233  	case IIO_CAPACITANCE:
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  234  		cap_setup = (chan->address & 0xFF) | AD7746_CAPSETUP_CAPEN;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  235  		vt_setup = chip->vt_setup & ~AD7746_VTSETUP_VTEN;
579d542534c96c drivers/staging/iio/cdc/ad7746.c Eva Rachel Retuya 2016-10-28  236  		idx = (chip->config & AD7746_CONF_CAPFS_MASK) >>
579d542534c96c drivers/staging/iio/cdc/ad7746.c Eva Rachel Retuya 2016-10-28  237  			AD7746_CONF_CAPFS_SHIFT;
579d542534c96c drivers/staging/iio/cdc/ad7746.c Eva Rachel Retuya 2016-10-28  238  		delay = ad7746_cap_filter_rate_table[idx][1];
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  239
6a7e4b04df3f4f drivers/staging/iio/cdc/ad7746.c Lucas Stankus     2021-05-23  240  		ret = ad7746_set_capdac(chip, chan->channel);
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  241  		if (ret < 0)
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  242  			return ret;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  243
6a7e4b04df3f4f drivers/staging/iio/cdc/ad7746.c Lucas Stankus     2021-05-23 @244  		if (chip->capdac_set != chan->channel) {
6a7e4b04df3f4f drivers/staging/iio/cdc/ad7746.c Lucas Stankus     2021-05-23  245
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  246  			chip->capdac_set = chan->channel;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  247  		}
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  248  		break;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  249  	case IIO_VOLTAGE:
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  250  	case IIO_TEMP:
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  251  		vt_setup = (chan->address & 0xFF) | AD7746_VTSETUP_VTEN;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  252  		cap_setup = chip->cap_setup & ~AD7746_CAPSETUP_CAPEN;
579d542534c96c drivers/staging/iio/cdc/ad7746.c Eva Rachel Retuya 2016-10-28  253  		idx = (chip->config & AD7746_CONF_VTFS_MASK) >>
579d542534c96c drivers/staging/iio/cdc/ad7746.c Eva Rachel Retuya 2016-10-28  254  			AD7746_CONF_VTFS_SHIFT;
579d542534c96c drivers/staging/iio/cdc/ad7746.c Eva Rachel Retuya 2016-10-28  255  		delay = ad7746_cap_filter_rate_table[idx][1];
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  256  		break;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  257  	default:
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  258  		return -EINVAL;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  259  	}
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  260
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  261  	if (chip->cap_setup != cap_setup) {
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  262  		ret = i2c_smbus_write_byte_data(chip->client,
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  263  						AD7746_REG_CAP_SETUP,
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  264  						cap_setup);
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  265  		if (ret < 0)
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  266  			return ret;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  267
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  268  		chip->cap_setup = cap_setup;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  269  	}
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  270
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  271  	if (chip->vt_setup != vt_setup) {
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  272  		ret = i2c_smbus_write_byte_data(chip->client,
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  273  						AD7746_REG_VT_SETUP,
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  274  						vt_setup);
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  275  		if (ret < 0)
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  276  			return ret;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  277
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  278  		chip->vt_setup = vt_setup;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  279  	}
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  280
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  281  	return delay;
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  282  }
83e416f458d532 drivers/staging/iio/adc/ad7746.c Michael Hennerich 2011-09-21  283

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
