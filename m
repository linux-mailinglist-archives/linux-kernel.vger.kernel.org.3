Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FE7585F10
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237252AbiGaM6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237306AbiGaM5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:57:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0C2DFFA
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659272225; x=1690808225;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LM0OaoFEZqWNyIaJfkA9msYckJx1TJXBGLe1VBf6wFw=;
  b=k9PxHOdJNp+MT4gKTRZ9oEbogyUJyaDiSSSHfg43Cy/SYvIP5IJHC7Ar
   pM7wsd4TBE7wgy7ATbOxlUMPqV+NnpPoEbGXVazEreap4Hrr5D9jSuj2t
   oL+Kr+/v2cRdvPhggSUzQ7hB176PF/31RJj6CR5b+0MF4BP6OuaqJBRYd
   a7VliTYTWb+Dk3mUAU0jvYtrLFylxXTRA6KnHoOCUrsfG9W+Upz9sWsiW
   5Hu1eu1PbD80o+mFzkDxltaGSkr9iNpCgOMAaNWnEgGCJGVlg3AWKs3hN
   3ie15eTi+OQjWODGfexIkAK0RH7rTpzEZpD0neKiToZQ3tCvfT0Jk6/or
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="314809673"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="314809673"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:57:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="634606331"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga001.jf.intel.com with ESMTP; 31 Jul 2022 05:57:04 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:57:04 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 05:57:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 05:57:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JZOMb83BWLQsGhObSFlqmZEF5SAVRAkA9BBbAZf/VHvu6IboVFfVuTZdibPMxijuLliZgu5g+bWZwAVXWEE4Owi0BVMmM3dCJRf31uuHPPscdan3NzGjknZKYaGrrjDPq58LGzSYYhPmFfYkVyNBGNNL1y47MZFx87OdHN+QZMwxJoFiWJ0nZqsQY1ZOpKn+l6U/kmry1bJ0CAiF9uKdWbob+Y4fyCfw7yNNiHSpIB+muy81+oYRHhxDgM5b0bj+VwtozlomxFlvuC3uoxx4FwaAA5NV+qEYqpHSpi7pyvBxK6mGg7xW23DwycmCglYpNl+74CMtjXJ6JiT9ANie5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIdAw2uQpjFS+2RP3Lnyqm5Ze0LW4/4ygcO5tpKYYsc=;
 b=VyVscpbWdBiZM0JxV8PaqLMsKE4mbpEWH6ESPP0SSs+hqND6NVVGmP8CzjpBT7y5zUpqp2ySz0abbucISpwoz1y3schrpIC+yYObNWtm3wwBuSzWDaFoAgzo21jX9tWHCWfOmonnQRQBxhclSn2RUHAPwCrr2uL8mqMJcMdEnDLxobb/Fwp9+vNy6Bxu9gosgMZAvpaL8EbiMuh5CsgL6kCH8XgxzSYvOVsbWRI1aqN+tjV7LQFmg86O00s626Q71I7Jjj3qZVhsS7r5x7cvylhaW2h1D5Ly3zo0TAhw1HNoaS8VvxQB6u+4UieDdqxvs/ZOWGdiSjGfMWEZQn3p4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by BN6PR11MB4163.namprd11.prod.outlook.com (2603:10b6:405:7f::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Sun, 31 Jul
 2022 12:57:01 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 12:57:01 +0000
Message-ID: <ac129729-0a5f-df09-76e1-13b5f8a143e2@intel.com>
Date:   Sun, 31 Jul 2022 20:55:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 08/12] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-9-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-9-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0108.apcprd03.prod.outlook.com
 (2603:1096:4:7c::36) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a7a232-ca86-4329-3748-08da72f428eb
X-MS-TrafficTypeDiagnostic: BN6PR11MB4163:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8HJWPPCqWnuG7x/wijuzzupZa8JkRcnl/SVxRfcBMA+mUQ64UqsEI2pHXPHe6xkd4jy6aWRnnb7GVpBYsmY3AG9bd+HjhL77s6KSmVBFyAYwiOiCOsaAZrjj7MH8piCqqxTrdiCmFhPa9e7a8yqPc/QSFsIkId6L95n5hnl11hzncEP6jBZ3nKUK2cXmaWO9WEE2DcoPCM7lJEVR4v/kZwAiie3CKk+szYIsx18bJaKgtom7usWQpBl0H0Z/c3AZRGItws2We8+v2IDwyxBLNIgq/CBRuqrRmbHP8PoMbyth6z14evdQEJeL+fkOa5GXtlMtABT4r+1byEfFEFspSiLG7Az8kUsSgH1R/8TvXTdsyNxyCjKskL4cZBALOgsB5Tw9eXwuL5g+97BA61wImqF5VcnAFEIERGscr/uqisCDQMixQAkfoKM2UDnHKkVeN920lmKcFNlMWQsw0ERY1rdaZtvFfc97C+d9N9ePk6vSQple1tTD21/4QRl/x87VL7gZNM1s+hXqfuLsX73YoCoS9HqovFQU42DM7gGIM+UaG7SE9XRREkeNYbdUyCC7up3VUiwaknotHmZNx5uge1y0tLILG+bYLHsNzpF/7iYm2Gh6GaxgA0rt2tAMAHXbEaS1KUBv2RhvlE1o/EkZLlS2CgMmM3ajR8AQ9KWJXrLx4ytqelvDipf2W5/JA0hecNZtEWtaPtpSUG7HePWfKf8bDI73Me3pa3bRqu4S01VuPlLwL2VbeWbZQrqK/y7mMcrN3zq/OXi3fyFJ+1Z9qeBL4B6czcM7Tz1816V5FtsnKjhXzqC7QlFHHNzco/ycDrxTmr9WxjP4ZchT9+jKBRIfRgY37qOyIam562dSLAM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(376002)(39860400002)(136003)(2616005)(186003)(83380400001)(110136005)(54906003)(6506007)(6512007)(53546011)(36756003)(30864003)(41300700001)(2906002)(921005)(38100700002)(82960400001)(31686004)(4326008)(31696002)(86362001)(8936002)(5660300002)(7416002)(8676002)(66476007)(316002)(66556008)(6486002)(478600001)(26005)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHl2dmpSRkwyM05oeVRDMUo5VHBCblVsOERmUndNZ0Y2U05zNlByU2p5R1Rp?=
 =?utf-8?B?eDZveXI0eEQzVklKZzlBZlZkNEJ5YTNKVDUzSzArdlRZQTlCVUV5UFhmcDNj?=
 =?utf-8?B?TzhYcm8zSnZzN0JWcEd2V2xlOUxTVkFRSWNnTGZuTEsyYUhCTEdVem1ORk85?=
 =?utf-8?B?WnladktxZUlaRmtOYzF0WjBuTnFpSlp5Z05TQjBsWUk1WjZabG9kQmFSK2Nk?=
 =?utf-8?B?d3lHaDJwV2EwRy9WcFhNRGhvZ2QxWHJWMnBGY2pXQldEMGNvSUt5TkRNVTly?=
 =?utf-8?B?R1VrZlJpNUI5dGRuWExLalQ5VURwOC9ZbGFYaUdKdzBDTHloSWJ4WERFTXUr?=
 =?utf-8?B?MTdPUkJWSEprb3l6am9UYzBGL0xKZjlxck9ZMkxwcXlwY0NaQ21KRG9Iayti?=
 =?utf-8?B?V3ZEUE9CZTI1R05BOUxUTWU0TFcyYVVKbEpZSUZTQ0FMbEZrVzJ5dnJGaTlr?=
 =?utf-8?B?b3pXZ0xZNVl2emlEUmxYcnJBVTZxVllUdkVtNTJjSmluOEtuMmI0R0ZwMGJH?=
 =?utf-8?B?VlE4QTNGMDhXU0p0ZngzVnhsekN2TVVWbVFqZ2Ftc1QxOVJ5djdlSEV0a05z?=
 =?utf-8?B?a0xnQm5qVG0yMDZzYmM4Q2xIZjR1aUwzc3NGVkZ6S3VDZit6YUxxWWtJcjlU?=
 =?utf-8?B?RTJDcWJUcjk4WUZySFo4SStiR3BKNGNyRDVrT0F3WVlsRGN6b0ZWRWNNR25M?=
 =?utf-8?B?bzUvRmE0bFZseUREdys2U1ozYVZYT0dDOEFZWVZlVENscmVRNEgyczk1SVgr?=
 =?utf-8?B?R0JIU0xaWlZadkRpOS96c2tKSXJ1RzV5T3hyVHRicHN6dFZZS3pVaG1JUy92?=
 =?utf-8?B?QzVsbmE4K0VTWk9Cc2E4SjIweGFRUUh6akZtWU5kcFVFbkVsZXhHNjZ3cHJB?=
 =?utf-8?B?UHhPTG1qcG5jdzVhQ05DRk1pR1ozZis0akxMdGg4UHIrOVlPeHRZekRQRER0?=
 =?utf-8?B?c0sxa2NVZEdzRlc4dnlxTC9zeER4UElnSllzd29BZU5ua3FLSDJydUhPL3BC?=
 =?utf-8?B?SHZXTS9qaXBiS0Z0UlBpU1R1SUV2Uzk1QWFxNmI4b3JsNW5ibllwTnJWOUZK?=
 =?utf-8?B?UEhDTkFqOUJheTV6SHVGajVQZ1NIa3RTVWVLQmk5Zk5wbkhQN3V1cHhSZUFP?=
 =?utf-8?B?M1RMbjZaL2F6NlVtcWJndjRCbTN1SFU2d0FUYVVBajIvRkJkODJLZnFYOW5B?=
 =?utf-8?B?Skt3L1FpeHJjT1V2cWZJNkxIbFZTM0dma3pYOHlERk5DR2EzaDVaN011TFBq?=
 =?utf-8?B?ZmVLYU45OGRzd2Z2bUdlWkI2ME9WQ3VjTEV4ODZoR0VmY3FGYUNlOG9iajJV?=
 =?utf-8?B?RlpqMithc2RWU0RrY1E1RDBwckpiK0VkbldoenlzaUxPVWkzQXo4bkRUS1Jh?=
 =?utf-8?B?RFlaR1BRcldNTDU3TFQzOGJySWFiMC9NdG9SVXlWYlNJcjRIK1hXV1RBaEVX?=
 =?utf-8?B?MWs4RnpsNXVraXQ2Wi80UnpjUkVzVk9CdnBXTTZLblN6WTIrT3gxNlFkYk8w?=
 =?utf-8?B?WUVWSXpLRGVhWjBCUWM3T3ljRnllam9JVHAveStsUDR0b1VsUklEb0xkWHZR?=
 =?utf-8?B?NjVYQ0o4eTZwVk1NYjE1MTNEd2pKLzVoRWlKb0REUzY2c0JsZ3FPdmtMc2xu?=
 =?utf-8?B?ZjRBS044bklPTWIrUEJDQ3piTjRibFNHWFVubTJCZ1k5U0ZqRU9PSWdlSCtj?=
 =?utf-8?B?cm9WaEFCeTVDVWhyUEZVQTNRR0FiVW5LdWo3aEh5bllMVmhtZVQ2Qldob3VS?=
 =?utf-8?B?Vk9mWmUrajR3RTQ0WXlWNGMyeGRDTVIyTHFxWnpVNGRFaDB5TzFBRmxwc040?=
 =?utf-8?B?RVplQ1ZsU0Q4aEU5YWtwV3M5WU05ejNkb3dvQ0ZMb09hbzFmdUROWTJkdDJr?=
 =?utf-8?B?SERSaGlDVXJFQzFvQzZXbHI1UUx5NC92SVJneitQNHhNLzVlcFRuQkg0RXdm?=
 =?utf-8?B?UVg1YnVNOWlKc3NuOGZmVC83Q21ycVE4VTk2SE04RDYrdmh3OVJIZXQzeHRn?=
 =?utf-8?B?NlV0RXpyR3RCNE8rem9GYUIrU2pBNVBidWp1ajhaNHRDS3RneUt0RWVSUFRS?=
 =?utf-8?B?OTVJNzUzd01xcFlRYlM0dEhlMHZUbzhaM0p2aVJWUXQ5cmhTNmVGazFUSlBr?=
 =?utf-8?Q?KUcKsnk1zNqBWelHCmxQAWYVW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a7a232-ca86-4329-3748-08da72f428eb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 12:57:01.1854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FYoxumXNubB07AVHDAPiYFThyZ46iPB4wRoHFqF3SpYkqzDTMih768kjFFD6bzcdvOC85zb0JM9C2ytQvjsi/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4163
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 13:07, Lu Baolu wrote:
> The existing iommu SVA interfaces are implemented by calling the SVA
> specific iommu ops provided by the IOMMU drivers. There's no need for
> any SVA specific ops in iommu_ops vector anymore as we can achieve
> this through the generic attach/detach_dev_pasid domain ops.
> 
> This refactors the IOMMU SVA interfaces implementation by using the
> set/block_pasid_dev ops and align them with the concept of the SVA
> iommu domain. Put the new SVA code in the sva related file in order
> to make it self-contained.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/iommu.h         |  67 +++++++++++--------
>   drivers/iommu/iommu-sva-lib.c |  98 ++++++++++++++++++++++++++++
>   drivers/iommu/iommu.c         | 119 ++++++++--------------------------
>   3 files changed, 165 insertions(+), 119 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 42f0418dc22c..f59b0ecd3995 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -39,7 +39,6 @@ struct device;
>   struct iommu_domain;
>   struct iommu_domain_ops;
>   struct notifier_block;
> -struct iommu_sva;
>   struct iommu_fault_event;
>   struct iommu_dma_cookie;
>   
> @@ -57,6 +56,14 @@ struct iommu_domain_geometry {
>   	bool force_aperture;       /* DMA only allowed in mappable range? */
>   };
>   
> +/**
> + * struct iommu_sva - handle to a device-mm bond
> + */
> +struct iommu_sva {
> +	struct device		*dev;
> +	refcount_t		users;
> +};
> +
>   /* Domain feature flags */
>   #define __IOMMU_DOMAIN_PAGING	(1U << 0)  /* Support for iommu_map/unmap */
>   #define __IOMMU_DOMAIN_DMA_API	(1U << 1)  /* Domain for use in DMA-API
> @@ -105,6 +112,7 @@ struct iommu_domain {
>   		};
>   		struct {	/* IOMMU_DOMAIN_SVA */
>   			struct mm_struct *mm;
> +			struct iommu_sva bond;
>   		};
>   	};
>   };
> @@ -638,13 +646,6 @@ struct iommu_fwspec {
>   /* ATS is supported */
>   #define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
>   
> -/**
> - * struct iommu_sva - handle to a device-mm bond
> - */
> -struct iommu_sva {
> -	struct device			*dev;
> -};
> -
>   int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>   		      const struct iommu_ops *ops);
>   void iommu_fwspec_free(struct device *dev);
> @@ -685,11 +686,6 @@ int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
>   int iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features f);
>   bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features f);
>   
> -struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> -					struct mm_struct *mm);
> -void iommu_sva_unbind_device(struct iommu_sva *handle);
> -u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> -
>   int iommu_device_use_default_domain(struct device *dev);
>   void iommu_device_unuse_default_domain(struct device *dev);
>   
> @@ -703,6 +699,8 @@ int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   			      ioasid_t pasid);
>   void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   			       ioasid_t pasid);
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid);
>   #else /* CONFIG_IOMMU_API */
>   
>   struct iommu_ops {};
> @@ -1033,21 +1031,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
>   	return -ENODEV;
>   }
>   
> -static inline struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> -{
> -	return NULL;
> -}
> -
> -static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> -{
> -}
> -
> -static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	return IOMMU_PASID_INVALID;
> -}
> -
>   static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>   {
>   	return NULL;
> @@ -1093,6 +1076,12 @@ static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
>   					     struct device *dev, ioasid_t pasid)
>   {
>   }
> +
> +static inline struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	return NULL;
> +}
>   #endif /* CONFIG_IOMMU_API */
>   
>   /**
> @@ -1118,4 +1107,26 @@ void iommu_debugfs_setup(void);
>   static inline void iommu_debugfs_setup(void) {}
>   #endif
>   
> +#ifdef CONFIG_IOMMU_SVA
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev,
> +					struct mm_struct *mm);
> +void iommu_sva_unbind_device(struct iommu_sva *handle);
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle);
> +#else
> +static inline struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	return NULL;
> +}
> +
> +static inline void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +}
> +
> +static inline u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	return IOMMU_PASID_INVALID;
> +}
> +#endif /* CONFIG_IOMMU_SVA */
> +
>   #endif /* __LINUX_IOMMU_H */
> diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
> index 106506143896..751366980232 100644
> --- a/drivers/iommu/iommu-sva-lib.c
> +++ b/drivers/iommu/iommu-sva-lib.c
> @@ -4,6 +4,7 @@
>    */
>   #include <linux/mutex.h>
>   #include <linux/sched/mm.h>
> +#include <linux/iommu.h>
>   
>   #include "iommu-sva-lib.h"
>   
> @@ -69,3 +70,100 @@ struct mm_struct *iommu_sva_find(ioasid_t pasid)
>   	return ioasid_find(&iommu_sva_pasid, pasid, __mmget_not_zero);
>   }
>   EXPORT_SYMBOL_GPL(iommu_sva_find);
> +
> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to mm_users
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken. Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	struct iommu_domain *domain;
> +	ioasid_t max_pasids;
> +	int ret = -EINVAL;
> +
> +	max_pasids = dev->iommu->max_pasids;
> +	if (!max_pasids)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/* Allocate mm->pasid if necessary. */
> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);

do we want to call mmgrab() before iomu_sva_alloc_pasid() to
avoid using mm without any reference? In your current code,
mmgrab() is called in iommu_sva_domain_alloc().

> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	/* Search for an existing domain. */
> +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> +	if (domain) {
> +		refcount_inc(&domain->bond.users);
> +		goto out_success;
> +	}
> +
> +	/* Allocate a new domain and set it on device pasid. */
> +	domain = iommu_sva_domain_alloc(dev, mm);
> +	if (!domain) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	ret = iommu_attach_device_pasid(domain, dev, mm->pasid);
> +	if (ret)
> +		goto out_free_domain;
> +	domain->bond.dev = dev;
> +	refcount_set(&domain->bond.users, 1);
> +
> +out_success:
> +	mutex_unlock(&iommu_sva_lock);
> +	return &domain->bond;
> +
> +out_free_domain:
> +	iommu_domain_free(domain);
> +out_unlock:
> +	mutex_unlock(&iommu_sva_lock);
> +
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> +
> +/**
> + * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> + * @handle: the handle returned by iommu_sva_bind_device()
> + *
> + * Put reference to a bond between device and address space. The device should
> + * not be issuing any more transaction for this PASID. All outstanding page
> + * requests for this PASID must have been flushed to the IOMMU.
> + */
> +void iommu_sva_unbind_device(struct iommu_sva *handle)
> +{
> +	struct device *dev = handle->dev;
> +	struct iommu_domain *domain =
> +			container_of(handle, struct iommu_domain, bond);
> +	ioasid_t pasid = iommu_sva_get_pasid(handle);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	if (refcount_dec_and_test(&domain->bond.users)) {
> +		iommu_detach_device_pasid(domain, dev, pasid);
> +		iommu_domain_free(domain);
> +	}
> +	mutex_unlock(&iommu_sva_lock);
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> +
> +u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> +{
> +	struct iommu_domain *domain =
> +			container_of(handle, struct iommu_domain, bond);
> +
> +	return domain->mm->pasid;
> +}
> +EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 10479c5e4d23..e1491eb3c7b6 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2789,97 +2789,6 @@ bool iommu_dev_feature_enabled(struct device *dev, enum iommu_dev_features feat)
>   }
>   EXPORT_SYMBOL_GPL(iommu_dev_feature_enabled);
>   
> -/**
> - * iommu_sva_bind_device() - Bind a process address space to a device
> - * @dev: the device
> - * @mm: the mm to bind, caller must hold a reference to it
> - *
> - * Create a bond between device and address space, allowing the device to access
> - * the mm using the returned PASID. If a bond already exists between @device and
> - * @mm, it is returned and an additional reference is taken. Caller must call
> - * iommu_sva_unbind_device() to release each reference.
> - *
> - * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> - * initialize the required SVA features.
> - *
> - * On error, returns an ERR_PTR value.
> - */
> -struct iommu_sva *
> -iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> -{
> -	struct iommu_group *group;
> -	struct iommu_sva *handle = ERR_PTR(-EINVAL);
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!ops->sva_bind)
> -		return ERR_PTR(-ENODEV);
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return ERR_PTR(-ENODEV);
> -
> -	/* Ensure device count and domain don't change while we're binding */
> -	mutex_lock(&group->mutex);
> -
> -	/*
> -	 * To keep things simple, SVA currently doesn't support IOMMU groups
> -	 * with more than one device. Existing SVA-capable systems are not
> -	 * affected by the problems that required IOMMU groups (lack of ACS
> -	 * isolation, device ID aliasing and other hardware issues).
> -	 */
> -	if (iommu_group_device_count(group) != 1)
> -		goto out_unlock;
> -
> -	handle = ops->sva_bind(dev, mm);
> -
> -out_unlock:
> -	mutex_unlock(&group->mutex);
> -	iommu_group_put(group);
> -
> -	return handle;
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_bind_device);
> -
> -/**
> - * iommu_sva_unbind_device() - Remove a bond created with iommu_sva_bind_device
> - * @handle: the handle returned by iommu_sva_bind_device()
> - *
> - * Put reference to a bond between device and address space. The device should
> - * not be issuing any more transaction for this PASID. All outstanding page
> - * requests for this PASID must have been flushed to the IOMMU.
> - */
> -void iommu_sva_unbind_device(struct iommu_sva *handle)
> -{
> -	struct iommu_group *group;
> -	struct device *dev = handle->dev;
> -	const struct iommu_ops *ops = dev_iommu_ops(dev);
> -
> -	if (!ops->sva_unbind)
> -		return;
> -
> -	group = iommu_group_get(dev);
> -	if (!group)
> -		return;
> -
> -	mutex_lock(&group->mutex);
> -	ops->sva_unbind(handle);
> -	mutex_unlock(&group->mutex);
> -
> -	iommu_group_put(group);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_unbind_device);
> -
> -u32 iommu_sva_get_pasid(struct iommu_sva *handle)
> -{
> -	const struct iommu_ops *ops = dev_iommu_ops(handle->dev);
> -
> -	if (!ops->sva_get_pasid)
> -		return IOMMU_PASID_INVALID;
> -
> -	return ops->sva_get_pasid(handle);
> -}
> -EXPORT_SYMBOL_GPL(iommu_sva_get_pasid);
> -
>   /*
>    * Changes the default domain of an iommu group that has *only* one device
>    *
> @@ -3366,3 +3275,31 @@ void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
>   
>   	iommu_group_put(group);
>   }
> +
> +/*
> + * This is a variant of iommu_get_domain_for_dev(). It returns the existing
> + * domain attached to pasid of a device. It's only for internal use of the
> + * IOMMU subsystem. The caller must take care to avoid any possible
> + * use-after-free case.
> + */
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	if (!pasid_valid(pasid))
> +		return NULL;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +	/*
> +	 * The xarray protects its internal state with RCU. Hence the domain
> +	 * obtained is either NULL or fully formed.
> +	 */
> +	domain = xa_load(&group->pasid_array, pasid);
> +	iommu_group_put(group);
> +
> +	return domain;
> +}

-- 
Regards,
Yi Liu
