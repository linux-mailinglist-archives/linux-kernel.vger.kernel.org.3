Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411B850259D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350456AbiDOGdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbiDOGdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:33:47 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E6595AEC1;
        Thu, 14 Apr 2022 23:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650004280; x=1681540280;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rysp2VpWbNPLU3xX6SkFEk6QJuv8TD0rys6Zo3G8eUM=;
  b=m6BRy1eYWlCFC8S1OLAHmjSCjJaQXmUBdygl1Y8LSbjU1NAD2Ytmf2Ya
   6fDMg+hv3P3ctsW4Dz+fOhmoJzQsLfhwK6WyDHn28KYl/UmTlTC8iJTr8
   LfCefUcCRBJgZeEowNOW/GfxGWp1bV6Oj+6VTRqEFLQzRv5E6jHStT6xV
   l6pLHi5md0eEhu/DKDIIN43i956kdRGHrHNmiDfNvrfN0NIOHaTS9ogzK
   Fk3uxJuJWYEFuf7WYlDl/xDSCOOMp8ZawCU0szkCu9xatwLRZArUmgp4d
   umg4cqnK7703JPFJWItwfmed6p/tHQEcm2XUs8TrqabXrKLrLFkoPLOUX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="250403090"
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="250403090"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 23:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,261,1643702400"; 
   d="scan'208";a="661670101"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 14 Apr 2022 23:31:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 14 Apr 2022 23:31:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 14 Apr 2022 23:31:18 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 14 Apr 2022 23:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LU5e0r47Rl0sRHUqessA5YQ+pUSYCqISFmjK5mOPqC0Q2MiVh6ZW2O0yKCWa1mgcTZ8EPxKGAJNcSCMguYboUrjL/YIaj4Ty7L/CtTj7/S6Z1IgC9/fwZwt1sOUObFlg3rI6G88gjGyNrLg55WaE1LyEQERNAjqNFlfogQD9Af9redqsXRKuxde7FlyJ/yOnlixQdbCQxK7E3mWlY54aZ3ZWQa5FeOq0REqHXSA82uY2fI5GGuXY35FK+xF2MuQArLYdgNgLdzpCGwj9v062E64MlNmqB7z2+CAJNocHFD8BStAh8Ri/VFVp0xeOVQHuuH4BFLT1i5EIDFjvTHiMAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5lvWrBD/IckZk3dU9ntsrmajwX9omUYrKtYBcuKxQU=;
 b=f6rcMZ6lUm+5VYPbhV67QA3S3MTI9cgkOgL1fUnx/0bB5dkinu8+P9PjJr0AAPwHLwTKISRllkcSa7/L8JKThnHEAa26fG/jrzh291ABT1bzZSI4KQDnSaexdQbYyyIX0NCzcWn3ukGPoOJq2Tx7Rqmu6n8zqezyxeIIHr3kr2+LUwqq5odW62vAs19JSlJBh5FUNbdOGAyo2IUI88PGGceq3kIkHIxx8MDGmtxnIyrSvILNeIA802VO1pcfEVkN8ZZfbSz4wBJdc1xWGnC+zntczWhlyB+wVj35PTTxn2oIQ1SeEoyaaTUDh0dYfPrh6DnmHZVwRCDZVQtXHGky7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN6PR11MB3956.namprd11.prod.outlook.com (2603:10b6:405:77::10)
 by PH0PR11MB4853.namprd11.prod.outlook.com (2603:10b6:510:40::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 06:31:16 +0000
Received: from BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::34ba:1704:3bf3:6d94]) by BN6PR11MB3956.namprd11.prod.outlook.com
 ([fe80::34ba:1704:3bf3:6d94%4]) with mapi id 15.20.5164.018; Fri, 15 Apr 2022
 06:31:16 +0000
Message-ID: <b9f12710-25f4-3dff-4f9b-cfe0bc3097e2@intel.com>
Date:   Fri, 15 Apr 2022 14:31:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next RFC v2 3/8] sbitmap: make sure waitqueues are
 balanced
Content-Language: en-US
To:     Yu Kuai <yukuai3@huawei.com>, <axboe@kernel.dk>,
        <andriy.shevchenko@linux.intel.com>, <john.garry@huawei.com>,
        <ming.lei@redhat.com>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <yi.zhang@huawei.com>
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <20220408073916.1428590-4-yukuai3@huawei.com>
From:   "Li, Ming" <ming4.li@intel.com>
Organization: Intel
In-Reply-To: <20220408073916.1428590-4-yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2P15301CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::34) To BN6PR11MB3956.namprd11.prod.outlook.com
 (2603:10b6:405:77::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d3bcb1b-84ed-4c25-226c-08da1ea98b3b
X-MS-TrafficTypeDiagnostic: PH0PR11MB4853:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB485382FE141817BE74D315A3DDEE9@PH0PR11MB4853.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LF94XxOqdFZglpjKCsbDMMzAsHtMYhfBot3AJuxdwsLGzhrCpjcbLXgKPCc6756EU7klbswwxLHMn9mKhj4u8Pv8TRQDQ47KBC0ZEflYbtMA3UD8QwM+9m/oS3ycnJavDcPHSHgIk4fMXstl5BcpYL0NFxokMTwV7qLVrHvyMvsJV7kMJwl/runFtAnM7P0vpkh5FCdaKDOC3RvcHBuAxqI9A3nZIXeiTQ9kqOMzTWZISJgxPA3+UfAQPCar7Hp6U8nivOMk7c0IOXXPRGB42X0LPgdJKkRob4HVP2s7QRnoQpdzghku8ltVSxKeMa6TSbbA5eVbK4X7lpYc3lrPSP6hlgvBXvy+K50baVFggdjuUjcY3DsJbJeickBNUvC4giaRtrhcFTA0Avbv/OUADAugj9OcLYB1IGg89DSOxby8kQIDMoaYb3X3GnkhWpbyJHDazvuQSVXDKkSv2xipvzMrttzKDCUoNER6Tn+U1pCSvFbdOMeeH2GvYOYkbbBvb15bbxCiki+vEi4Pfqn9U7nRJqlKvuVHaE5OjaPGC1rhymQQqZjQExzo8LxNlJF0Z4/T/hE460rOLdtE9UJULAm0Oadfmwkcp+tIpXHvUzvDSfnZhDCyHpzr4fCflO9C+TRj+zq/GdXQcriLHOExfTS3bBR3XzsJnxZrhchp+w5mnBhDpnt8MjjKzH2CJ3228VCU2/YAx2s0NJRSMFsfOcY7kcwnHLriS6DOR9skkuo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB3956.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(36916002)(8676002)(66476007)(4326008)(66556008)(6512007)(86362001)(26005)(186003)(83380400001)(82960400001)(6506007)(2906002)(8936002)(2616005)(36756003)(316002)(6666004)(31686004)(66946007)(53546011)(6486002)(31696002)(508600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk9KbXR4WVNRMTh0MmxDOUlVTjRhZGxSOHRoaUY4RXRHSjRZR0JnZXFuLzhv?=
 =?utf-8?B?VzQwNjBCeG03d2NuRFUvT0NuUWNZUnhIYmJMZXFTSmVkZDliZHVmVkxpekRF?=
 =?utf-8?B?dlRVb3NDbE5udUMxOGdOcUpadXV1SUVDQkR4UXcvSGdvZGFubW40ODQ3TUFy?=
 =?utf-8?B?TkdsYnNyVm93MHhEbmUzMUlGV1pHZVVtZ1d3KzR4NmNVSWZJa01VSjduV0cy?=
 =?utf-8?B?YUpIU0JmRWlDM3JlNU1FQytZZ2FUNnlUZWxTdHB0bWFXcW9hTzZncWtOZWsy?=
 =?utf-8?B?emRMWjgybGdMYitrY1lzNktaUVhCbldWaFllcXNOOU5vYituSWhSMk5ZOVcw?=
 =?utf-8?B?U2dOQm9vZS9mdjU3c0pZa2FaY3JoNnZCaUUxZ2FHM2cydmVrQitFQnYyUVBh?=
 =?utf-8?B?dFMxMmExbkluK1E5VHhldGRHTFdSbzhydFBmcnpMSnRuNzRsUU5pakM3OWpJ?=
 =?utf-8?B?cnNKMjZkdzZRaWRPd0VXM0FpOHpTNnRIZVYveUVuNStrVGxKdEc3RDcvMGpC?=
 =?utf-8?B?Skcwc0d5US9qUjFnRU5NaitzVlpaTUVCOUVRV25NTU45U2FMc0hZSEhvTWpF?=
 =?utf-8?B?L1RsMDZOeEc0QWE4amdhVzA0N1ZJUStSaVJzTE9LUG1Yckx3QUtnRmdTbmxj?=
 =?utf-8?B?VVRrKzV2TnJqUzI3UWl4ZXFvV014Y1psdFBDd0paNWxYZ2RQbzNDTkhVVW5G?=
 =?utf-8?B?T1VmeG5Hamg4RFpCUzJ0aGdoU243S28vdnhUQ2grOHROMVJWdDhkMERPMXFp?=
 =?utf-8?B?YVRkZ08xbUFEb1FqRW1hcWVXSVdsSWI3VldvcWcxMnV5dmFlNXN4Vk4vRUlw?=
 =?utf-8?B?V2w2UnNkcFNUWG90cGtWL0FiTm9sak1nR21tVk4zWHpIaEJTbXFjaWMzWkNH?=
 =?utf-8?B?cWl2ZWxDZ2R6WGxVMlQrV2o3S3ZjRVVDbGVsQms3alRVZ3dpY01iV3YvK3pk?=
 =?utf-8?B?d1Y4TWpxa1FHcnVIU1lBd2NiNGs0dUl5V0Q4OTBxaGlEbW1kRkpNZjhIcHcr?=
 =?utf-8?B?czdabGJhSndlQk1LTzFiMDNVREEveGJGbzNFZnVVV0hXR1RqWWVnT2I1Z0VU?=
 =?utf-8?B?K1VLR0U4cmsxMmdOY3UvZnYydUkxREU5RXFUN0o2ZEJxd2Npa2Uwc1hZMXho?=
 =?utf-8?B?dUdNT3JYQ2RjSWZ0azY3bkF3SjE1dUdNcHR6SGhJSjc4dEpIMEdLMzZ0NEpY?=
 =?utf-8?B?TEVaRWhURFFpT2p5NDNXQ3ZzZTU0MkRWSlZtZXZoSWNmWDY3VnZWVFBINlZt?=
 =?utf-8?B?eDIreTh5QzJCVDBid3RRTENPV3NKWS9wTnVXT3VnSHc4azdoMmNvZXlHRXQw?=
 =?utf-8?B?S1BnNjZ3NXN4dmtNK2NjUEV4eUxBNXk3aWtVZGJOQ2pwZmticWVOU3lCM2Mr?=
 =?utf-8?B?b216S3pJZjBabGRlTytveG9vM3VOdXIvK281NEJrUnVqOGs0bkFhbTRTWldZ?=
 =?utf-8?B?T1R0bWVTemtwREFMQWtXVFEyYW9waDI1RXc0azFwbWtSQmVjQnBCMDVBWTBO?=
 =?utf-8?B?c3diWXIzenZXQnNaY2Q4enVTb1cyRUs4MjdHeUx6aUFMakdmRzBSamh0cEdP?=
 =?utf-8?B?cnNySjRsVkRSNXVGdzFmRG5EaXh2YkxOOGxIeWMyUWRtOVFRQjFQdHU3S3Rq?=
 =?utf-8?B?dmVKbGZpaWlrUHFiaFhRTm5sQW5EM2hqZmc1c1dReEhMUE9Kd1JiaFF4ZjJt?=
 =?utf-8?B?NzdnMVcyRDYraHdFNUxBVktDNjZrOVNlc1RZOXVwYXUzVTEzclVhSms4b1NJ?=
 =?utf-8?B?TGt3bW93QlIvNkxxSUhVWXpOM002dnd3YTI3aktvREhGSHEzZVlSQnBINmRj?=
 =?utf-8?B?U1VudEt5NXlxK3lVSVdkU0graWdkdUU5M1JldSt6elptNmlKWUNIWUJvNUJi?=
 =?utf-8?B?SjZsMGZOejZCZ1VlMmNzYlJrczNPN0czWG1TZFNxa0hmcldYdzJlM0crVk53?=
 =?utf-8?B?c2xZalVkaHR5ZDkvNDdkVWwxbUZhRFl4ZWwzZzc4czgrWDh3NHY2M1VpMDky?=
 =?utf-8?B?WnkzN1h5MmcxdEliOFB4akZ0WkhzR1pXWnVxTzJ5K2VzSDQramkrRS9Ea2RE?=
 =?utf-8?B?SUhVYS8yR1JadUFoSDlXd01iVUNBdm9OaFB4MGcwR3ZIeWhQYVM0RzZudlR2?=
 =?utf-8?B?S3dQMEVKbUVJQitwLzI4YkNkbFNvZW1KbUFiMjhOWkVQeEI2MWZld2JGRGd6?=
 =?utf-8?B?VDFuMVBvR0VnMys1UnN3c0hRQkNFTzFRU2pnWnp3NGZuZWYramw3RHJiMFls?=
 =?utf-8?B?Mlc5U0NwV1Z6UFpSeDJtQU1SUEY1RmMwL3lhOG8rWFJyMm4xTW92M2N6ZmZu?=
 =?utf-8?B?Tm5LRWZ5QnNOSG5HM3ZiM0RJbUxTM0xLbDVUS2R1TllyNTU4WnRqUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3bcb1b-84ed-4c25-226c-08da1ea98b3b
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB3956.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 06:31:16.3686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: johW4ybBewEuFXNpJSiSwjb9DVrXgVQqDNROFJk05ySPoCwYpLm5uC0nKGRywZDTC+23bNVO7NqZPhWFt6UZ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4853
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/2022 3:39 PM, Yu Kuai wrote:
> Currently, same waitqueue might be woken up continuously:
> 
> __sbq_wake_up		__sbq_wake_up
>  sbq_wake_ptr -> assume	0
> 			 sbq_wake_ptr -> 0
>  atomic_dec_return
> 			atomic_dec_return
>  atomic_cmpxchg -> succeed
> 			 atomic_cmpxchg -> failed
> 			  return true
> 
> 			__sbq_wake_up
> 			 sbq_wake_ptr
> 			  atomic_read(&sbq->wake_index) -> still 0
>  sbq_index_atomic_inc -> inc to 1
> 			  if (waitqueue_active(&ws->wait))
> 			   if (wake_index != atomic_read(&sbq->wake_index))
> 			    atomic_set -> reset from 1 to 0
>  wake_up_nr -> wake up first waitqueue
> 			    // continue to wake up in first waitqueue
> 
> What's worse, io hung is possible in theory because wake up might be
> missed. For example, 2 * wake_batch tags are put, while only wake_batch
> threads are worken:
> 
> __sbq_wake_up
>  atomic_cmpxchg -> reset wait_cnt
> 			__sbq_wake_up -> decrease wait_cnt
> 			...
> 			__sbq_wake_up -> wait_cnt is decreased to 0 again
> 			 atomic_cmpxchg
> 			 sbq_index_atomic_inc -> increase wake_index
> 			 wake_up_nr -> wake up and waitqueue might be empty
>  sbq_index_atomic_inc -> increase again, one waitqueue is skipped
>  wake_up_nr -> invalid wake up because old wakequeue might be empty
> 
> To fix the problem, refactor to make sure waitqueues will be woken up
> one by one, and also choose the next waitqueue by the number of threads
> that are waiting to keep waitqueues balanced.
Hi, do you think that updating wake_index before atomic_cmpxchg(ws->wait_cnt) also can solve these two problems?
like this:
__sbq_wake_up()
{
	....
	if (wait_cnt <= 0) {
		ret = atomic_cmpxchg(sbq->wake_index, old_wake_index, next_wake_index);
		if (ret == old_wake_index) {
			ret = atomic_cmpxchg(ws->wait_cnt, wait_cnt, wake_batch);
			if (ret == wait_cnt)
				wake_up_nr(ws->wait, wake_batch);
		}
	}
}

Your solution is picking the waitqueue with the largest waiters_cnt as the next one to be waked up, I think that waitqueue is possible to starve.
if lots of threads in a same waitqueue stop waiting before sbq wakes them up, it will cause the waiters_cnt of waitqueue is much less than others, looks like sbq_update_wake_index() would never pick this waitqueue. What do you think? is it possible?


> 
> Test cmd: nr_requests is 64, and queue_depth is 32
> [global]
> filename=/dev/sda
> ioengine=libaio
> direct=1
> allow_mounted_write=0
> group_reporting
> 
> [test]
> rw=randwrite
> bs=4k
> numjobs=512
> iodepth=2
> 
> Before this patch, waitqueues can be extremly unbalanced, for example:
> ws_active=484
> ws={
>         {.wait_cnt=8, .waiters_cnt=117},
>         {.wait_cnt=8, .waiters_cnt=59},
>         {.wait_cnt=8, .waiters_cnt=76},
>         {.wait_cnt=8, .waiters_cnt=0},
>         {.wait_cnt=5, .waiters_cnt=24},
>         {.wait_cnt=8, .waiters_cnt=12},
>         {.wait_cnt=8, .waiters_cnt=21},
>         {.wait_cnt=8, .waiters_cnt=175},
> }
> 
> With this patch, waitqueues is always balanced, for example:
> ws_active=477
> ws={
>         {.wait_cnt=8, .waiters_cnt=59},
>         {.wait_cnt=6, .waiters_cnt=62},
>         {.wait_cnt=8, .waiters_cnt=61},
>         {.wait_cnt=8, .waiters_cnt=60},
>         {.wait_cnt=8, .waiters_cnt=63},
>         {.wait_cnt=8, .waiters_cnt=56},
>         {.wait_cnt=8, .waiters_cnt=59},
>         {.wait_cnt=8, .waiters_cnt=57},
> }
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  lib/sbitmap.c | 81 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 42 insertions(+), 39 deletions(-)
> 
> diff --git a/lib/sbitmap.c b/lib/sbitmap.c
> index 393f2b71647a..176fba0252d7 100644
> --- a/lib/sbitmap.c
> +++ b/lib/sbitmap.c
> @@ -575,68 +575,71 @@ void sbitmap_queue_min_shallow_depth(struct sbitmap_queue *sbq,
>  }
>  EXPORT_SYMBOL_GPL(sbitmap_queue_min_shallow_depth);
>  
> -static struct sbq_wait_state *sbq_wake_ptr(struct sbitmap_queue *sbq)
> +/* always choose the 'ws' with the max waiters */
> +static void sbq_update_wake_index(struct sbitmap_queue *sbq,
> +				  int old_wake_index)
>  {
> -	int i, wake_index;
> +	int index, wake_index;
> +	int max_waiters = 0;
>  
> -	if (!atomic_read(&sbq->ws_active))
> -		return NULL;
> +	if (old_wake_index != atomic_read(&sbq->wake_index))
> +		return;
>  
> -	wake_index = atomic_read(&sbq->wake_index);
> -	for (i = 0; i < SBQ_WAIT_QUEUES; i++) {
> -		struct sbq_wait_state *ws = &sbq->ws[wake_index];
> +	for (wake_index = 0; wake_index < SBQ_WAIT_QUEUES; wake_index++) {
> +		struct sbq_wait_state *ws;
> +		int waiters;
>  
> -		if (waitqueue_active(&ws->wait)) {
> -			if (wake_index != atomic_read(&sbq->wake_index))
> -				atomic_set(&sbq->wake_index, wake_index);
> -			return ws;
> -		}
> +		if (wake_index == old_wake_index)
> +			continue;
>  
> -		wake_index = sbq_index_inc(wake_index);
> +		ws = &sbq->ws[wake_index];
> +		waiters = atomic_read(&ws->waiters_cnt);
> +		if (waiters > max_waiters) {
> +			max_waiters = waiters;
> +			index = wake_index;
> +		}
>  	}
>  
> -	return NULL;
> +	if (max_waiters)
> +		atomic_cmpxchg(&sbq->wake_index, old_wake_index, index);
>  }
>  
>  static bool __sbq_wake_up(struct sbitmap_queue *sbq)
>  {
>  	struct sbq_wait_state *ws;
>  	unsigned int wake_batch;
> -	int wait_cnt;
> +	int wait_cnt, wake_index;
>  
> -	ws = sbq_wake_ptr(sbq);
> -	if (!ws)
> +	if (!atomic_read(&sbq->ws_active))
>  		return false;
>  
> +	wake_index = atomic_read(&sbq->wake_index);
> +	ws = &sbq->ws[wake_index];
>  	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> -	if (wait_cnt <= 0) {
> -		int ret;
> -
> -		wake_batch = READ_ONCE(sbq->wake_batch);
> -
> -		/*
> -		 * Pairs with the memory barrier in sbitmap_queue_resize() to
> -		 * ensure that we see the batch size update before the wait
> -		 * count is reset.
> -		 */
> -		smp_mb__before_atomic();
> -
> +	if (wait_cnt > 0) {
> +		return false;
> +	} else if (wait_cnt < 0) {
>  		/*
> -		 * For concurrent callers of this, the one that failed the
> -		 * atomic_cmpxhcg() race should call this function again
> +		 * Concurrent callers should call this function again
>  		 * to wakeup a new batch on a different 'ws'.
>  		 */
> -		ret = atomic_cmpxchg(&ws->wait_cnt, wait_cnt, wake_batch);
> -		if (ret == wait_cnt) {
> -			sbq_index_atomic_inc(&sbq->wake_index);
> -			wake_up_nr(&ws->wait, wake_batch);
> -			return false;
> -		}
> -
> +		sbq_update_wake_index(sbq, wake_index);
>  		return true;
>  	}
>  
> -	return false;
> +	sbq_update_wake_index(sbq, wake_index);
> +	wake_batch = READ_ONCE(sbq->wake_batch);
> +
> +	/*
> +	 * Pairs with the memory barrier in sbitmap_queue_resize() to
> +	 * ensure that we see the batch size update before the wait
> +	 * count is reset.
> +	 */
> +	smp_mb__before_atomic();
> +	atomic_set(&ws->wait_cnt, wake_batch);
> +	wake_up_nr(&ws->wait, wake_batch);
> +
> +	return true;
>  }
>  
>  void sbitmap_queue_wake_up(struct sbitmap_queue *sbq)
