Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408414FCFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:37:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242057AbiDLGjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350238AbiDLGhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:37:51 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46B51570D
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649745273; x=1681281273;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7M3kKUs72tG046yRZ9OLvVwPmVXypLhxX0AzfBgWmEs=;
  b=gqzUWwT3dFf3q0OFwwkuO4S0RR6loAKK1mW5pw5Vk11wrxxrswMph+/r
   eF7lqfI9cwHsEar2haAbJnsEd/Vx7EeWnUIInwN0ffgU1UIIBMui3/mdk
   z5WksbOY5k1Tjsis7oqJ/uyI/4VTSx5ZzDTCVbhr7tJw1F4UIr9sqN+mG
   qjzcqD0qJok4KdXZNRnhKuRFf7kI3LM8WTmlcGDvHwV7jzQKxG96IImpF
   Vdrx+LP8NDHW3yQJwN+JQIB7bSjHnb4bQHEDJel10nn/MQVTZfxZ3y5fg
   Bba6e+uJvPqrk64kg6Ze5FvhQpv22MOxaJUw9NgfrGxuAMfpsohP3XXBX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244172869"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="244172869"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:34:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="644585773"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2022 23:34:29 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Apr 2022 23:34:28 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Apr 2022 23:34:28 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Apr 2022 23:34:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A44WTcGu5BX6dINkvABXEdpLvjOZ6TeaPtgaHy3I5Z2ch5bXhaRe8RmgwIdCrZ4cXn3ooJWNB5flWL9Zsu/HIJk6XHKTA1NE90oR5C0iSctXtn3x8Nf8GKi4XPIOxbr1hnx3JDN5SBzRUIaCr7Cepxwf3yGcuDJMSyfBRWcmIwjPFF/M6UkfsPuHEDHu/aU4yx4g71fplIFk1HO8f4jho7W1jm5nYG7F53vhMNcCPreiLbR8nu7hOqwd3SNEalA5azN0IwLyEFDRQPXoxS4zAQtfiCYrwNzEhsrlsiBC6tMB59oMp4IsCo5gsjWQAZ2Bg5jgsLQFpCFx4jygEtjmEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aU82L1XEIfnAj8DC2y4mb2kWClWBlvtm8pTLB32tG1g=;
 b=h9KKBG1SQwB5NHZnkYda98gkVpDI+fElxsTj3sG0Tg2aNWKoLAR3ERQRMvO9O/pmH4ZzlvBDqIjZao8gg6bUQrnponY44RbPPm5RjsNr1aCYWv3obkfCp6xIUQJQXzB+7ND3UkTec2XKFStGk/xODs6EfGjgy6OY9KUpVVQiYsu8DUQ6VOIEMgMPLyexyyro1Cdkord3if5XvNu8ibTkbb0G8sXUQpFAjK+Lf+0375OpZ2rJU2r7eZC2Mzzq8WSilM9qRQvG5vNFO9hkfA27V2uvZM13qLMG6APvTxqO+y7L451JSRn8KwXxI2t+k52FC35B9X3KPZmJ2o9KvSjORA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by MN2PR11MB4397.namprd11.prod.outlook.com (2603:10b6:208:190::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Tue, 12 Apr
 2022 06:34:26 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::71d2:84f6:64e1:4024]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::71d2:84f6:64e1:4024%6]) with mapi id 15.20.5144.030; Tue, 12 Apr 2022
 06:34:26 +0000
Message-ID: <e8d8d08c-8327-b0ad-6bdd-ef10cd34e212@intel.com>
Date:   Tue, 12 Apr 2022 14:34:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH RFC v3 02/12] iommu: Add a flag to indicate immutable
 singleton group
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220410102443.294128-1-baolu.lu@linux.intel.com>
 <20220410102443.294128-3-baolu.lu@linux.intel.com>
 <BN9PR11MB527679E5CE0516B2786F57518CED9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <7c70a136-6871-b48c-8e46-852bb1b62958@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HK2PR02CA0184.apcprd02.prod.outlook.com
 (2603:1096:201:21::20) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd3e1351-0e05-4d98-7cc7-08da1c4e7d3a
X-MS-TrafficTypeDiagnostic: MN2PR11MB4397:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MN2PR11MB439783ACC95BC6DB5B317B12C3ED9@MN2PR11MB4397.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /OntLA+MRjjb4+iQ54GCmbzaqkT3V1EjBE/jX9LrFNImMmsoXvizKmH48NcoLBTy/IypVQxdPpDqu0nSOq0HFB87QRy24rzGS4zeDU/HLp+G4AcFJrjJAwyT2X1rTSCLC3LXdYJFSbrCsz4XbeRIChzfivpCq6n652Xje6op6lur3hptcnoyvvOflc6wjo2DnkCZ8JAn43cH1ywRQxwsOLRaJ5MlBJtayQFocNKVs6RXY4MLLgVAoOyruTZK5VJ2FRKzUglmvvbLw9L7ePUTj4s6CFPurBaLGkTc5l0OndbGZ4FBdx0AckD/s9vASQya9N5reN23mEWKk190jHgzoEw7jMODpggZuNf14NKqAwjWioHzV38gZmkiKEiFA5T4lFVJ6VOTZm7JSL6Ej42iO11NDZKA1UkfmNoV+TAEr4irwvb8RoPFhGlDvap81cRNgC7e7tSx4ACpGSImjAnX+WXHXIzVJxJuF9zIA9MJBau2OI0JLV2a6RvBjtmNsUTMnWzhpXs0hLaRm8d8V6QIJKY+aCfFY0MrXGAKRqAjEbCcJL4fObUwOf84/u+yrZawsZbtPtsz6sEtHloVyg39KIkjtrv+NKvgRQ5JA/UZua1I33m+r0Dl0DiY8vUGXiqXquIUa+ZQ0fgKEfXxdlEkkcrsdVZxrDgLQK9jOtUmzwvodJ/vRhKI+48kW0vWX3hpYVOXiUWYBfmAAMg49VQ4CRC1nMTdLjimf5vyNfTVX3aGfIUfoUGs+Y9luussvF/99ZNRPLyFoJFuJT2C/flKJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(36756003)(508600001)(86362001)(6486002)(8676002)(66556008)(66476007)(316002)(6506007)(6512007)(6666004)(83380400001)(66946007)(8936002)(2616005)(31686004)(26005)(7416002)(5660300002)(2906002)(186003)(82960400001)(921005)(4326008)(54906003)(31696002)(110136005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmFSZk1uQm9wWnVnNFVpQXlIMDFpTnM3THhSazEvalVsMllZd1dxY3lsMW04?=
 =?utf-8?B?c1VGNDV6WmhhR3hDbjVIWTZMejhyNzBKUU1YNTdHelhtbmY2UThyQ0dFYjJG?=
 =?utf-8?B?bkwyYll2Nit3aWNzOGJrVXExSzcxZjlCMVNIQjRLRlk4RHhqUkFiR0hvd2dN?=
 =?utf-8?B?L3E5R3BPcXBmd29Qb0lVS2NkTHc1NWhTTDFVVjBmcHFpcjFGOExYb1pWajdH?=
 =?utf-8?B?YkR5RUFPM0FmQ2VXQUFQaFlpWFhhOXFGTWhvck5XWDh5SGQyQVVxbEhvRUpv?=
 =?utf-8?B?NmMxQ24xa2FFRXBtQzk5OEZlbElpRHo4a1NKbi96Qk82Nis4eHRrYVQwN096?=
 =?utf-8?B?WjRxWCtkUXY0TGtEdVBzb3I5SmhuanZkWFZSZUgzdXViQjA2cE5EbkcvbERE?=
 =?utf-8?B?V2h6K0oxcUk2aVBCR2U0QVpObVpyR2lic3hENXNhTzE4YzFyYzdBMTZLY2Jk?=
 =?utf-8?B?RHFyYXFMeDZ1bXNIQTVwR1JuNmxITFl0QXJxaTdZNFVrcG8zZGs0QXdxL2VZ?=
 =?utf-8?B?OHZ5SE1PUzNqcmQzQkJaNStrYVNFNGFSL1F0NWl2ZnZhaXdkQkw0Q0tKRXhE?=
 =?utf-8?B?czlYQ0JRQ2JzaEVMSmlJL3hGendQNUhTaWRXVUJHNHpTRjk5TmRXd0VGYkN2?=
 =?utf-8?B?WnZqK3pzT1lxL1pYTWk4OG5OZExKUWxNYVpValc0U2dUNXNOWDY5MlVsc2cr?=
 =?utf-8?B?VVRXQ3Y1U2N5VVhROEk1M3RZTUJ3d291S1I4VjM3dFdURGJsSnNwejVlRzhJ?=
 =?utf-8?B?WkVmZXlNcXNTYUxsTHBEVGVud2JCWExNRTRRL09kaWJNczJWeUcxTjJTVUsx?=
 =?utf-8?B?THk0V1QzRThFa3VJWTF4SHhtelJVSnR4TVFNa2h0U01jNU9zMEIzZUpvVVFm?=
 =?utf-8?B?dnZ4ajFXRmluSHVvZWIxMjEvUTBGODAxNnFRWndmeWtLOWUzQWFpeU55Tld4?=
 =?utf-8?B?ZTN2UmNCaTBpZWFLSjFxWWFDa1pac0tWMmdsNXh1Nm5aWi9nN0c4K0llNG9M?=
 =?utf-8?B?bENWUHUvSUpBa3g3N2M3SXI0SnhzNkp2WE53OGkzZTgvTWVjWWFxb09RMnFU?=
 =?utf-8?B?M3BDVGhaSitqVHZzRjQyYkZvT29MYUcxRTZpLzFOeHZhblRielRlUlIxcFh3?=
 =?utf-8?B?ekhYaTFtTEdlazZmNnJ0and2QnVEL3NUaEgxTG1WRHVURUhmSHdVWTFZZzRv?=
 =?utf-8?B?NXhTSkt2TXBmRHRFR01sU2I5QVRzd0k3VHBNWVpIK0xITHR6MkV2Rm9XQ21p?=
 =?utf-8?B?Z1lYejY1c3ZaMnQvVXlYM01FS2JleWtoSnlkc2F3azJsWUVHSDRNL3dLNGV1?=
 =?utf-8?B?b09acXlYMUFidWZDb0dkY3VHcTZUNlZpWEt3WXptR1hYRVdBZFkzeENjOFE1?=
 =?utf-8?B?cVFzSkpKVHg3TEVMRmxBVTRSYjQ3bmtPL0ZqUWZWZnB4QnIwaU5Bc0xJaTVq?=
 =?utf-8?B?RHdENW5jc3pxMTNJQW9VQ2kzKzZMNGlNS1pUL2dzTmN6Ny9CY3pOQVpKR1NU?=
 =?utf-8?B?UVQzay9IMnlOT1ZpeFIySnI1RFByT1E5RXJXWnd6a0l1eElzWndDZHA1RHNj?=
 =?utf-8?B?QTdjc1k2YjF6bUJvUllZSmxEK0tuTlhvNW16QUZCMDVSSlU3REpGZEhGcktZ?=
 =?utf-8?B?NlBNRndIZS9VZEJablN3eUZQWlZvRGpRdkpBanR2TEtrTndvaUxXV0xnSG9x?=
 =?utf-8?B?MFkrSjJaUWNJYnExSE1tSmFuT2VMaHdkNmVscWNZbGpQeFJGTkJOZU5RRGps?=
 =?utf-8?B?NlJGSXRwOVluYWtzYStHaDFDeTdTaDFYNkF1b25qK2NxTnJXbjlzc1pZelQz?=
 =?utf-8?B?Zjh0WW9lY2JwL3RYdkx4OXZoK2hrdjNhd0lzZWJyWk12YXlZd1ZNUE9aTW9j?=
 =?utf-8?B?WjZ5c0U3VjhjMzFna0gyZjZ6aVVoVXExYXJsckt1eGJsd1gzL25ucGxVSGFU?=
 =?utf-8?B?NjJSbGlhWXBLU0doNUtXOUhOeDJmYVdNampjTlUxZU8xclFWQy91eFFvd2pL?=
 =?utf-8?B?WEIybloyWVdyTDBINEwzOVFMK1VNOUwwcFU5KzN3UnRETTZEV3lvQUdleGVX?=
 =?utf-8?B?OTJaWTFBTi84Z2JXWmt6S3FGRHpwalV4QzFHS21ybEtnMUtSdXpkaVcrZzAv?=
 =?utf-8?B?dm0wV1dEcG85ZDZsblRhNXlTVjUvL0R3SE1xdDBmZlZhWU80Y2pjaHJSL1gz?=
 =?utf-8?B?VmVOYnBQQUE0RklUcERtMXJIK2R4Q3JTR1llWlVnVlVjc3prNDhjRElLL3Z1?=
 =?utf-8?B?SnZyZ05PUGpSbWdJamRMWXNwNWllL3hKVjJsZ0RCcDBJcmhBZzFyZEFpSUw4?=
 =?utf-8?B?dWpqMi8vRGp3bGg2RWZoTm13UElkY1pRNGwvOFV4dEQvSDFXSFFSU0gwNkRV?=
 =?utf-8?Q?MuWL522UkHGZhh64=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3e1351-0e05-4d98-7cc7-08da1c4e7d3a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2022 06:34:26.3326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: THX5n9FKp6D0y2kW0AD7k8bxHKHDpJLpEeBT2zLt5vUNmd35y0M68ZoLzxceW7WMGq8XTh/EXLtHa8N8dZmHsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4397
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolu,

On 2022/4/12 13:08, Lu Baolu wrote:
> Hi Kevin,
> 
> Thanks for your time.
> 
> On 2022/4/12 11:15, Tian, Kevin wrote:
>>> From: Lu Baolu <baolu.lu@linux.intel.com>
>>> Sent: Sunday, April 10, 2022 6:25 PM
>>>
>>> Some features require that a single device must be immutably isolated,
>>> even when hot plug is supported.
>>
>> This reads confusing, as hotplug cannot be allowed in a singleton group.
>> What you actually meant suppose to be:
>>
>> "Enabling certain device features require the device in a singleton iommu
>> group which is immutable in fabric i.e. not affected by hotplug"
> 
> Yours is better. Thank you.
> 
>>
>>> For example, the SVA bind()/unbind()
>>> interfaces require that the device exists in a singleton group. If we
>>> have a singleton group that doesn't have ACS (or similar technologies)
>>> and someone hotplugs in another device on a bridge, then our SVA is
>>> completely broken and we get data corruption.
>>
>> this needs the background that PASID doesn't join PCI packet routing
>> thus the dma address (CPU VA) may hit a p2p range.
> 
> Sure.
> 
>>
>>>
>>> This adds a flag in the iommu_group struct to indicate an immutable
>>> singleton group, and uses standard PCI bus topology, isolation features,
>>> and DMA alias quirks to set the flag. If the device came from DT, assume
>>> it is static and then the singleton attribute can know from the device
>>> count in the group.
>>
>> where does the assumption come from?
> 
> Hotplug is the only factor that can dynamically affect the
> characteristics of IOMMU group singleton as far as I can see. If a
> device node was created from the DT, it could be treated as static,
> hence we can judge the singleton in iommu probe phase during boot.

not sure if hotplug is the only factor. Is it possible that admin modifies
the ACS configuration on the bridge?

>>
>>>
>>> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
>>> Suggested-by: Kevin Tian <kevin.tian@intel.com>
>>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>>> ---
>>>   drivers/iommu/iommu.c | 67 ++++++++++++++++++++++++++++++++++++----
>>> ---
>>>   1 file changed, 57 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>>> index 0c42ece25854..56ffbf5fdc18 100644
>>> --- a/drivers/iommu/iommu.c
>>> +++ b/drivers/iommu/iommu.c
>>> @@ -48,6 +48,7 @@ struct iommu_group {
>>>       struct list_head entry;
>>>       unsigned int owner_cnt;
>>>       void *owner;
>>> +    bool immutable_singleton;
>>
>> Just call it 'singleton' with a comment to explain it must be immutable?
> 
> I was just trying to distinguish "singleton" and "immutable singleton".
> A group is singleton if it only contains a single device in the device
> list, while a group is immutable singleton only if the fabric doesn't
> allow to change the state.
> 
>>
>>>   };
>>>
>>>   struct group_device {
>>> @@ -74,6 +75,16 @@ static const char * const
>>> iommu_group_resv_type_string[] = {
>>>   #define IOMMU_CMD_LINE_DMA_API        BIT(0)
>>>   #define IOMMU_CMD_LINE_STRICT        BIT(1)
>>>
>>> +/*
>>> + * To consider a PCI device isolated, we require ACS to support Source
>>> + * Validation, Request Redirection, Completer Redirection, and Upstream
>>> + * Forwarding.  This effectively means that devices cannot spoof their
>>> + * requester ID, requests and completions cannot be redirected, and all
>>> + * transactions are forwarded upstream, even as it passes through a
>>> + * bridge where the target device is downstream.
>>> + */
>>> +#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR |
>>> PCI_ACS_UF)
>>> +
>>>   static int iommu_alloc_default_domain(struct iommu_group *group,
>>>                         struct device *dev);
>>>   static struct iommu_domain *__iommu_domain_alloc(struct bus_type *bus,
>>> @@ -89,6 +100,7 @@ static int
>>> iommu_create_device_direct_mappings(struct iommu_group *group,
>>>   static struct iommu_group *iommu_group_get_for_dev(struct device *dev);
>>>   static ssize_t iommu_group_store_type(struct iommu_group *group,
>>>                         const char *buf, size_t count);
>>> +static int iommu_group_device_count(struct iommu_group *group);
>>>
>>>   #define IOMMU_GROUP_ATTR(_name, _mode, _show, _store)
>>>     \
>>>   struct iommu_group_attribute iommu_group_attr_##_name =        \
>>> @@ -844,6 +856,37 @@ static bool iommu_is_attach_deferred(struct device
>>> *dev)
>>>       return false;
>>>   }
>>>
>>> +static int has_pci_alias(struct pci_dev *pdev, u16 alias, void *opaque)
>>> +{
>>> +    return -EEXIST;
>>> +}
>>> +
>>> +static bool pci_immutably_isolated(struct pci_dev *pdev)
>>> +{
>>> +    /* Skip the bridges. */
>>> +    if (pci_is_bridge(pdev))
>>> +        return false;
>>> +
>>> +    /*
>>> +     * The device could be considered to be fully isolated if
>>> +     * all devices on the path from the parent to the host-PCI
>>> +     * bridge are protected from peer-to-peer DMA by ACS.
>>> +     */
>>> +    if (!pci_is_root_bus(pdev->bus) &&
>>> +        !pci_acs_path_enabled(pdev->bus->self, NULL, REQ_ACS_FLAGS))
>>> +        return false;
>>> +
>>> +    /* Multi-function devices should have ACS enabled. */
>>> +    if (pdev->multifunction && !pci_acs_enabled(pdev, REQ_ACS_FLAGS))
>>> +        return false;
>>
>> Looks my earlier comment was lost, i.e. you can just use
>> pci_acs_path_enabled(pdev) to cover above two checks.
> 
> If a device is directly connected to the root bridge and it is not an
> MFD, do we still need ACS on it? The Intel idxd device seems to be such
> a device. I had a quick check with lspci, it has no ACS support.
> 
> I probably missed anything.

seems not necessary per my knowledge.

> 
>>
>>> +
>>> +    /* Filter out devices which has any alias device. */
>>> +    if (pci_for_each_dma_alias(pdev, has_pci_alias, NULL))
>>> +        return false;
>>> +
>>> +    return true;
>>> +}
>>> +
>>>   /**
>>>    * iommu_group_add_device - add a device to an iommu group
>>>    * @group: the group into which to add the device (reference should be 
>>> held)
>>> @@ -898,6 +941,20 @@ int iommu_group_add_device(struct iommu_group
>>> *group, struct device *dev)
>>>       list_add_tail(&device->list, &group->devices);
>>>       if (group->domain  && !iommu_is_attach_deferred(dev))
>>>           ret = __iommu_attach_device(group->domain, dev);
>>> +
>>> +    /*
>>> +     * Use standard PCI bus topology, isolation features, and DMA
>>> +     * alias quirks to set the immutable singleton attribute. If
>>> +     * the device came from DT, assume it is static and then
>>> +     * singleton can know from the device count in the group.
>>> +     */
>>> +    if (dev_is_pci(dev))
>>> +        group->immutable_singleton =
>>> +                pci_immutably_isolated(to_pci_dev(dev));
>>> +    else if (is_of_node(dev_fwnode(dev)))
>>> +        group->immutable_singleton =
>>> +                (iommu_group_device_count(group) == 1);
>>> +
>>>       mutex_unlock(&group->mutex);
>>>       if (ret)
>>>           goto err_put_group;
>>> @@ -1290,16 +1347,6 @@ EXPORT_SYMBOL_GPL(iommu_group_id);
>>>   static struct iommu_group *get_pci_alias_group(struct pci_dev *pdev,
>>>                              unsigned long *devfns);
>>>
>>> -/*
>>> - * To consider a PCI device isolated, we require ACS to support Source
>>> - * Validation, Request Redirection, Completer Redirection, and Upstream
>>> - * Forwarding.  This effectively means that devices cannot spoof their
>>> - * requester ID, requests and completions cannot be redirected, and all
>>> - * transactions are forwarded upstream, even as it passes through a
>>> - * bridge where the target device is downstream.
>>> - */
>>> -#define REQ_ACS_FLAGS   (PCI_ACS_SV | PCI_ACS_RR | PCI_ACS_CR |
>>> PCI_ACS_UF)
>>> -
>>>   /*
>>>    * For multifunction devices which are not isolated from each other, find
>>>    * all the other non-isolated functions and look for existing groups.  
>>> For
>>> -- 
>>> 2.25.1
>>
> 
> Best regards,
> baolu

-- 
Regards,
Yi Liu
