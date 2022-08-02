Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9572F587721
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbiHBGgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 02:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiHBGgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 02:36:50 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84439DE84;
        Mon,  1 Aug 2022 23:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659422209; x=1690958209;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3/l+s6TbShCwF+6pJlSAf2vvflKS5hpUYHOK7cx181o=;
  b=PEIMj85X00zJb+cBe/zxa6ssTW7zVwNo5JDMOI49WsUwWlO456o98xzF
   ApsWusmBpdh+LKRJX9QPt7+U0PdJ1UG2j+2d1Q/iKhNHPRplkRTmRuQln
   VQoVT0J+lomB7LYTjRF64DftkYRQ2Kr7TaNc5WLi3D6C+JVy51jSG7HZO
   u3nKN+ku+td/IfzBLLKzJIi9C3625byYdsoA9jrI9rR9mB0Sxn6csB7nV
   7zg/A84xMw9F+2lZeXL79jP6XBvqIeaf3PN+botg7s/FghI9yH6DcCgtQ
   WF9LDtWFt1Z+jhD0cPs4R7R0yFpP2z1E5xO36/PB1QzfHgKSxTEmOQb4B
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="288091407"
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="288091407"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 23:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="661491100"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 01 Aug 2022 23:36:49 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 23:36:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 23:36:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 1 Aug 2022 23:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeprDJ1ufxRZcSNbEJfFQ6LySbdf5VY3lbth/YoV5JHgYJlt/4MJ06ZMetFBSbMjnagNY4lzYuMuScbAAWp9JaNJTZsiCEzbY1vXj68mDqp1C+LOn9akjIxFKnPHxRxRHC/8sezG3Geyor5EGgEmIcQV5GlWxiM40b8/Qznay2x1aH6PYVMkNUsUgKfdLomdpJtFHUcv8YakklIjRy0ydtCtv+QREZ9Z9jTu/wefpvorbA9qU+hTU4w3J+QWTAG9kvdSIyk57IdKCmaQfwEKL/g1U0YbaQpz2uAztU+M2I5pZ0v4su9YUgaLYSalC9Qc09MXWPLeiIh7Tx7pQjBtyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xi0Mg2Nm1OJwiF1uHZvSPdJG8N749hVLjj36jzTa1lU=;
 b=Vow2WZw6lRuHLHIIETTY8+/0neZJBn1fuZUeYmSD+ejV4vmmvoIMNofgwagd192bv8VouSSUC0pv4rf90TFAaJssupUNhHDKyF6BolGNUPkuEkIe+ImyY/n7WXSG3PQqjI3QMT3I+EZYgyPVwYhYuSCsdBoB4MKhAqbRKcgCN0oXumoBPxZiovF2ObxGOMsjMN16y8lSuMkGSzqN+Pt66JjGpL2rH6KXOsM49A+BwcCjD3yYKV1qterDuozf1tsESykBaRzn8vVjXhZgEGhvrXJ8PHDwtniN2cmnvv+2uWPQ8U7smgkh+XS3oe9gZtoelMA35EJyMS3ER6HHqo9SRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by BN6PR11MB1825.namprd11.prod.outlook.com (2603:10b6:404:104::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Tue, 2 Aug
 2022 06:36:08 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::552f:2392:56f8:ca32]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::552f:2392:56f8:ca32%3]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 06:36:08 +0000
Message-ID: <9d4e37e2-417e-7a2f-a187-5c7b680c6777@intel.com>
Date:   Tue, 2 Aug 2022 14:36:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [LKP] Re: [xfs] 016a23388c: stress-ng.xattr.ops_per_sec 58.4%
 improvement
Content-Language: en-US
To:     Dave Chinner <david@fromorbit.com>,
        kernel test robot <oliver.sang@intel.com>
CC:     Dave Chinner <dchinner@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, <lkp@lists.01.org>, <lkp@intel.com>
References: <Yti6PccitrglBtIj@xsang-OptiPlex-9020>
 <20220721220142.GW3861211@dread.disaster.area>
From:   "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20220721220142.GW3861211@dread.disaster.area>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0188.apcprd01.prod.exchangelabs.com
 (2603:1096:4:189::10) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59a7523b-0797-467e-e9fe-08da74514871
X-MS-TrafficTypeDiagnostic: BN6PR11MB1825:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9lLZp5cvLZKC6o4q5kcFtc0CcEPNSoWqP7GqZyXFV9l7Xq1If0dbEqpbdN49o0KG+W0S91kTZ1yEmb193wII7L+909qMVc+Fga49ZUDrUtCii7WVQm2SK7l/y+eDMpLdNkJcOiMAsFMYpD/3nqvjv9wqL7QUEW8ISzkLl7HJTRd49kk5zJfLK6mRuusjY8nSAZ8stWx9J6r2vSpMYQpMnHFCyBKy2rqSZb2B/mGyAPMYnCXYCWBWradr9tbyNXABud2An3m2DkCwLVv0yjkfYVNChZUpMTw4o1aiHG+lRvW3N7oZklyDAEqr7h3lingbaxX7gchKOpV3fT3dEgnmi4gOL3syIBZbxeBYmBvRaIW1l5zuvwyNMZC4iwwoR3RbEfZrcuPVNGppsHfr6obUm1nZ6hjEEwZwyh4DUd5iRz5VM0+w0bOF1drq2nuE1hQwj1+sWraUhWqSchxsHV0S349XPIPQBCRx592bZYRyl6MhlW6PmHdWo38qr8I6RM4URZYpOPA6YrTuuJqDmfIFIRbycHMbADabTlxn8wqX0g6Z/hvcmvTdZTa9t0UY+5FmmkdcXZ/n5uvclsb/810fym7VSuJcvyOCZidd7bEHgOBgGCuUwDP0jhRvPPyBwq+32BDyqhxmSihz2W9OUG8wpO3wzd1jl1Y2SP5hAvUUrq831PfRmMCPJcnwgA2QBGzVUINKVSNsmcpib4FekekJpwNP+/vI7V8N7Wbt6rDJbRgQGuuxjPi2PJMwkvYq8jY9xyDRkJLUckrhuTGfFtKkmPZioyIbaD4wl3cS5v+qIPfUDdFXVY1PrG1uT2ouiFB5eU0yCozEvXbq2qZdPbTP0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(376002)(396003)(366004)(2906002)(478600001)(66946007)(66556008)(8676002)(4326008)(5660300002)(66476007)(6486002)(6506007)(53546011)(8936002)(26005)(41300700001)(82960400001)(2616005)(6636002)(54906003)(86362001)(110136005)(107886003)(6666004)(83380400001)(38100700002)(6512007)(31686004)(316002)(31696002)(186003)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk15QnUzVnJmRExVNk5WSjhCVFFKNGhwTDUrbTZ6cFEweVJ5d3pKUU9ucTRr?=
 =?utf-8?B?QWQ1ZjFIM2kvVVI2MnMrOFRWa3U2WStIbnR0elZnWVEwSUFFSW1WSVV1c3Fu?=
 =?utf-8?B?NXQ0dHpDTlV3YVU1UHVPWU5uTit3b215K2FkNTBGTVNOUkc3anNLTlNVME44?=
 =?utf-8?B?MzNrN3ExcHRCQ1NCaGk0UlRGcnpheUxQdkx2NER1RDJGMHd4ZE9UL2tCODRj?=
 =?utf-8?B?R1hJN2YzM1JhcVdmdyt5d05PQVloUi9xT0hqeG5sRk85bHJHUXUxRVRxekdC?=
 =?utf-8?B?UzkyZlIrTmNzRGZrbVFwY1BUNlBTZkRPTHN5NEp3MS9qSGNKek5tY2FObWtM?=
 =?utf-8?B?Tkx0U2N6YmxZTFVkWWxMeEt4NndHc3pINVV5QitmVlM1dTN3N1VqbFZMNFVN?=
 =?utf-8?B?KzBzM0dRbWVYRWlqWG84blJOcldmR3dEcnB3Kzl6N0pGNXoycmxGakpCeHA5?=
 =?utf-8?B?RkhBMUhFblRoMitFNnkrRG1UVUxkOEhCTTMyNzZuUEQ5RkVDRmk3OGR0UnRv?=
 =?utf-8?B?ZHFON3J5ZnFNYk4ySHJrcWljbzAvS09HS2NrNG5WMnBHSjQzT295dlZab0dT?=
 =?utf-8?B?Y0VjRGVlRm0yUlQzd2dlNlA2T3NzTDdyeU1QNTlpWnBianRFNkZ3enR5elFX?=
 =?utf-8?B?ZkJFUUUwb2RjVDhvOVBjdS9NTW5sTjUxMTVYd0xWR3pTUDZJL2s3SU5XK1R4?=
 =?utf-8?B?UXNWRmVKZzhYS1lNTGUvb0dQNGJOU2hlNXdqQW4vOTVmU0ZtTkwzZzFaaElF?=
 =?utf-8?B?OWhZTzZ0alBtbTU5alZjUVA0NGxGM2FJblloWEd3cnc4UnEzQVpxa2NKbHBH?=
 =?utf-8?B?NFVKUlZ1VGkzSmdDVWhBeGJPRDNFZ2tBR3VRL2U5dldkUzQ1V2RiSktmWGRS?=
 =?utf-8?B?UEZsN3RaUnRJbXlUY0piWFNkTSt1TlBEN3A5OFp0TkhpYlBxVFFtU0pDNFZS?=
 =?utf-8?B?ZlZxMWxtV2psOFZxWWVsVFBjZGVrSlcyUkxVcEJrekxWVTJ5N1pVY2NNVWVS?=
 =?utf-8?B?Rm1LUVV1UENSdEdsQmJCZ0tDb2FvYmo0b3cvZDVGWmFkdXJrNTF1ZFhsWHZM?=
 =?utf-8?B?Q3J0bGlaeXRESk9BWEZRaG9ieElSNWtiUW16Qlp2MkNZM1B1a3BNZkZ0Yk82?=
 =?utf-8?B?bnRlOE1Vcm9UUnpoTnZyQ2s3Y0pHNUI4KzArS3J5OGthZ1psS3VmdzR5M1Zs?=
 =?utf-8?B?U0J5YTBIVmZwTG41UVNJbi9mMTV5bGVkOTljQ1FiYjhGTitONy9yQ3RmOVBk?=
 =?utf-8?B?dE1FY2FYNFFHTDM4TzQ0dzNaTStJY0V3ZjZnYld4SDhxdTA5SWJvZTUzUFNQ?=
 =?utf-8?B?empuYWpLTGhQZldDS3U5bWM1dXpMM2MxMUpCa3V4Y0dtT2crNUdxcGNPc0ti?=
 =?utf-8?B?NkcxTnZ1Q01iVEZ6QWo4ZWNKMGV4a1lkZXVXMEpFcWVDY2JYb0tBZXJVb2NK?=
 =?utf-8?B?Vk5wdjBDSlF1elJFemhvZmFnUTU5VjdlVjlHV0N4aWlvSEFZZjl5LzU2WWd5?=
 =?utf-8?B?bjd5TXZIQVkzaUtEWlFENXcwU1ZMSnFrSW4vNmd1UnZkRW9QOVg4Z0hEQTlC?=
 =?utf-8?B?UVRRbDVuc0cxRUtCd0ZNR0NNU0g0WHVNQUp6cG1pT1ZBZUcyUEtjVjMvcWlO?=
 =?utf-8?B?dExWZFNTeXhYZDBCNHNkSTJSdmRjdm5wdWJLVVBESFB5V04xKzMvTjE3T1pw?=
 =?utf-8?B?Y1hsRldobXVKY0JPd2lhZStMNGpDR3FTR2JYUUwzWmdBTGVJc2U3WlpZekNx?=
 =?utf-8?B?VzFuT0pKZjhiLytUZlAreVE0OCtwMEswb3d5emN5Q3ltU0pBUkltUElWdWVK?=
 =?utf-8?B?US9idUxJd29EczdFR1c0WmFvMzIrR3dIZmVFcVdaS2VRWTYzdVVHbmg2Tzho?=
 =?utf-8?B?NVg3dVRpRUM0WkhHeEhlNDgvMnVRVmhuWVNBL2ZDaVdZT1g0TEd1c1hJbDY2?=
 =?utf-8?B?R1ZCd2swSzIrOGEydWlvdXZNMm83Y1FVcTJxT1hvSFAvUUVlR0hWRENvNXY0?=
 =?utf-8?B?UjljWjI1Z3hFZ0Y3cUQ3YzZhcFZXeTJrelpPUFA1cXBQcXp6OWZvRmN3U004?=
 =?utf-8?B?Umg2ODRYdnc4T2dzVElsTnZncUlvYWNNekVMbjl0VERrRFZob0RpczRWdXRL?=
 =?utf-8?Q?8TB2ikTzaT8vx+pz82R48qK2X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a7523b-0797-467e-e9fe-08da74514871
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 06:36:08.5600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 11Dzg7ENTlf0AWYQH3CvLb8LeL/bPeQ6W3BYhRIrXh4lo8z0W2PBTTaXgXdfaw4Zgf21E/IKd6UTm8h8TAzY8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1825
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On 7/22/2022 6:01 AM, Dave Chinner wrote:
> A huge amount of spinlock contention in the xlog_commit_cil() path
> went away. The commit identified doesn't remove/change any
> spinlocks, it actually adds more overhead to the critical section of
> the above spinlock in preparation for removing said spinlocks.
> 
> That removal happens in the next commit in that series - c0fb4765c508 ("xfs:
> convert CIL to unordered per cpu lists") - so I'd be expecting a
> bisect to demonstrate that the spinlock contention goes away with
> the commit that removed the spinlocks (as it does in all the testing
> of this I've done over the past 2 years), not the commit this bisect
> identified. Hence I think the bisect went wrong somewhere...

We did some investigation and got:

commit:
  df7a4a2134b0a ("xfs: convert CIL busy extents to per-cpu")
  016a23388cdcb ("xfs: Add order IDs to log items in CIL")
  c0fb4765c5086 ("xfs: convert CIL to unordered per cpu lists")

df7a4a2134b0a201 016a23388cdcb2740deb1379dc4 c0fb4765c5086cfd00f1158f5f4
---------------- --------------------------- ---------------------------
         %stddev     %change         %stddev     %change         %stddev
             \          |                \          |                \
     62.07            +0.0%      62.09            -0.0%      62.06        stress-ng.time.elapsed_time
     62.07            +0.0%      62.09            -0.0%      62.06        stress-ng.time.elapsed_time.max
      2237            +0.0%       2237            +0.0%       2237        stress-ng.time.file_system_inputs
      1842 ±  4%     +16.9%       2152 ±  3%     +17.6%       2166        stress-ng.time.involuntary_context_switches
    551.00            -0.3%     549.10            -0.3%     549.40        stress-ng.time.major_page_faults
      6376            -1.1%       6305 ±  2%      +0.6%       6416        stress-ng.time.maximum_resident_set_size
      9704            -0.3%       9676            -0.1%       9691        stress-ng.time.minor_page_faults
      4096            +0.0%       4096            +0.0%       4096        stress-ng.time.page_size
    841.90            -2.4%     821.70            -2.4%     821.90        stress-ng.time.percent_of_cpu_this_job_got
    512.83            -3.4%     495.24            -3.6%     494.18        stress-ng.time.system_time
     10.05 ±  8%     +52.3%      15.30 ±  3%     +61.1%      16.19 ±  2%  stress-ng.time.user_time
      2325 ± 16%     +66.5%       3873 ±  7%     +70.3%       3962 ±  6%  stress-ng.time.voluntary_context_switches
      1544 ±  4%     +54.4%       2385           +63.9%       2531        stress-ng.xattr.ops

Yes. commit c0fb4765c5086 ("xfs: convert CIL to unordered per cpu lists")
could bring performance gain also. But the most performance gain (54.4%)
is from commit 016a23388cdcb ("xfs: Add order IDs to log items in CIL").


Based on commit 016a23388cdcb and add following change:

diff --git a/fs/xfs/xfs_log_cil.c b/fs/xfs/xfs_log_cil.c
index 6bc540898e3a..7c6c91a0a12d 100644
--- a/fs/xfs/xfs_log_cil.c
+++ b/fs/xfs/xfs_log_cil.c
@@ -659,9 +659,14 @@ xlog_cil_insert_items(
                        continue;
 
                lip->li_order_id = order;
-               if (!list_empty(&lip->li_cil))
-                       continue;
-               list_add_tail(&lip->li_cil, &cil->xc_cil);
+
+               /*
+                * Only move the item if it isn't already at the tail. This is
+                * to prevent a transient list_empty() state when reinserting
+                * an item that is already the only item in the CIL.
+                */
+               if (!list_is_last(&lip->li_cil, &cil->xc_cil))
+                       list_move_tail(&lip->li_cil, &cil->xc_cil);
        }

The performance will drop to the same level as commit df7a4a2134b0a
 ("xfs: convert CIL busy extents to per-cpu"):

commit: 
  016a23388cdcb2740deb1379dc408f21c84efb11
  a8bef09e7d8e65207c8403e030a0965db43ce3de

016a23388cdcb274 a8bef09e7d8e65207c8403e030a 
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
     62.06            -0.0%      62.05        stress-ng.time.elapsed_time
     62.06            -0.0%      62.05        stress-ng.time.elapsed_time.max
      2237            +0.0%       2237        stress-ng.time.file_system_inputs
      2226           -16.7%       1855 ±  4%  stress-ng.time.involuntary_context_switches
    549.00            +0.5%     551.67        stress-ng.time.major_page_faults
      6286            +0.1%       6292        stress-ng.time.maximum_resident_set_size
      9636            +0.1%       9641        stress-ng.time.minor_page_faults
      4096            +0.0%       4096        stress-ng.time.page_size
    823.00            +3.0%     847.33        stress-ng.time.percent_of_cpu_this_job_got
    496.02            +4.2%     516.61        stress-ng.time.system_time
     15.08           -38.1%       9.33 ±  4%  stress-ng.time.user_time
      4034 ±  3%     -43.0%       2299 ±  6%  stress-ng.time.voluntary_context_switches
      2368           -37.4%       1482 ±  4%  stress-ng.xattr.ops



Regards
Yin, Fengwei
