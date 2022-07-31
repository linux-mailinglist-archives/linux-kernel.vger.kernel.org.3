Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E57F1585EB8
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 13:55:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiGaLzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 07:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiGaLzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 07:55:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23E42BF5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 04:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659268514; x=1690804514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h8zg5pS1nHj5znS78vcXPxcKQo+hVqbg9n9bjCJVN3k=;
  b=YoNhOlwOrNoyKtc+nyi5btN5u3mOJXfDcbOnRRO2SwBhWuh+NadE5Zr+
   KDLB0LDYJaNlWAS2ETzz1Q7e/0ENiIGxCVQZ00kGsmCWe1FNtBCa50Ckc
   IpfYWLUlRx6ZKEFct8dkRHGFh5lCM+tdO7KJGeQd0fEAaYqp0BOG16+8Q
   c87IrzXwYK0PdyRAp8T1vFUiDYsR3FiJMOTB/ofyEXDCuHaxqEKITGsOq
   rG/1XTuOvmv+y1fLZxWTlbGFoS6Kl/DJEcW9kNfdxRIcCjz/wW2X6S1fX
   J0xqY8Zr5fC4PeLyYs6zk13JLXxelQ7/LjbtTZ66EssdEev5zbcGibDxl
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="272032801"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="272032801"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 04:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="728176979"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 31 Jul 2022 04:55:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 04:55:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 04:55:14 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 04:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jjwL0AXAtHtQHPG44CsSFTTO1hoz1TMqrMHe5QEdGlwXaIGJ0RVcKxQ1+cBsa5qzxhhqAF5Udeh1beALwpbIC0XtBJtbE/owGQsZdgE55MER9klD/8hGwwI56XNO3B7OuXct815OK8VmzmkIgOxMbJrNbEHAZRTY5PAa5zxDIQ0DIrONvkRaj/d4VpecOYXfOZN+A1RoMxk7NbZE03pTl3FNVLfmmeMqgMy8V/2JAOzrvRAc9Xe9RJI2YSlLBqGEOs++EPIbiggKjMPMQyZ4C99y2OL3e9HxegihLhG4cqQXeiycrUgDAcdA9M28Q+NU8qx67PBSRRl9IL61KCaXPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N01goy1GKl7T7yb92/qlo0dQBvewhcRplZm1l3QK6mE=;
 b=GG/lwbGQ0thIygK9LpTMogjpbbK97ZfM4I7BXwLTbwrMaXllMRCkrLCbZxw+1jTRcRqiE/etgTEX8BWpicphPlpxG8rL1QBwTdaTs/dw/w6qlJEfsuKW6lYWBPxuSQur6+R7vapEPwEZYwFnj6woUxuB81lX/Dq+qIuDFYyOJRwcHY+fdzDBMkjdKclEOf2ST05ImBSWNRIqA/Vbgyqk/y8ihOexOiD7au/boLgqCSYcXwjTG+cT8Np+refSGnQiEFxgm2/jKbA4cCddQ7Ig9aIAnT+ULniOuSM8ZyGWgYllq2rTjzfDDFy4cGt6RD3bURm6/NrXgTcv6ON0uKq3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by BYAPR11MB3174.namprd11.prod.outlook.com (2603:10b6:a03:76::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Sun, 31 Jul
 2022 11:55:12 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 11:55:11 +0000
Message-ID: <17aefaaa-ef95-016e-e028-f8091829a508@intel.com>
Date:   Sun, 31 Jul 2022 19:55:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 02/12] iommu: Add max_pasids field in struct dev_iommu
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
 <20220705050710.2887204-3-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR03CA0102.apcprd03.prod.outlook.com
 (2603:1096:4:7c::30) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 090a663f-d358-4a34-66d3-08da72eb85da
X-MS-TrafficTypeDiagnostic: BYAPR11MB3174:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fFg8fWcdrofiOPEPsORizHrClq4iY2T5NlBwWqk3olQ7kl5hRP0ZmXaiA9DZOtt/7ZZGfEVB8LaVvD7eabEzwjuGnPghQGLinWkh3x89QwqR18cMvNfmD/cvJwnyWtTwzOpUTZMg1CVuNLyJ+tO/G4H9q7+K4FCHXz5IASGHVex5Zi5cOsQKxi+AbssmOOGaS9KS19wt5V71wRfbfxKJI0TxswcVWRtlBcpGZjtBsKXl/RGTUKoqqTrUnnP/xA2URbLbVdoUOE2wQfhY1+ejMsmcopWDaiBf7HUycJNJk2A0Yy964xz+myxD2h438jwPMZXNvPpGRbVVjGCtNau/nePW3BfRFa+PMS2hXoZolhhOhGWDIx9fjtx8vdyFe9ly4Z8RXP5mmRKNLcFuo1TVySoHYIhFQG9IE+iIjs41ODWq1Qf3VqdaZXZMC01JBa5848b3AlbLp9LIgGxuBU8kINFn5RfGQkuWTyG9eSv8ZX1/X0IPgX75koKAccC97n9AbJVq1oqxe0xzuaQZWobnn4t1HpJpMHFhroFuSnXgKAjI8COugAOyOgt4P4ZTVOO9rtK86IJSMYOi7YffaHZ2Uq4OiuQeq31H68uXSq4QyU32sfxlhHraswCQt1FV/ETVL7cCkMyONSz08JB2XjfgSHoEXbHjlJMcz8eHilRx3op/zaAZmTrAuzHZXq9RsKOU7cawURzXRgp4YWnpBZ6Ec8i2zNcFKa8957/MRwxN+dN5IYJxTR+qqmhPHGGMQaNfDVKskYEwgBJu/HnHYpZtJ0KsNRxCzWvCTGhgBmUvoxGncLYPRLWd024l3FgMIF1EgIt5+qorJTC2hR9X9HuKeVpFxxAnyW3rmZXvz1vCd0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(366004)(396003)(376002)(136003)(39860400002)(8936002)(6486002)(66476007)(7416002)(36756003)(478600001)(41300700001)(38100700002)(2906002)(66946007)(110136005)(316002)(54906003)(31686004)(66556008)(6506007)(921005)(2616005)(53546011)(4326008)(31696002)(5660300002)(86362001)(82960400001)(186003)(8676002)(26005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3RKaXNJcHIweW53NDc5SU5TM2FVWTRUN3NVNzV1czBJNUpneW1MTjkrYXRz?=
 =?utf-8?B?cjdFVnkzakJyUHF0cDVkMHByZGZrNFRmd2JwWmc4RkZLd29ERHdSOEUxRmQ4?=
 =?utf-8?B?b1c4TUFzRnJRWlo4ZjEwRCtxM1djQU5rM0N5QWdkNTc3V0ZnM3dMdXZ6bERn?=
 =?utf-8?B?MUpSS2ZnSXgraWM0ZHY2RjJocTZBdUdib0p5YU5PemRzcUdSTUQ4YnBCUUU3?=
 =?utf-8?B?MmdyT2FuWnV3R1hRS1FYbHlDNHFhTUlMSWJjNytUdGVvWkVYbVV4Tm9KTVBl?=
 =?utf-8?B?Z0ExeDMzZGhEM0dqUHFBUEV6SkZLYm5ST0kxa3lSWDJFTzZlMFdzMllqRWk4?=
 =?utf-8?B?TEovUEVBVEFnMjF2bENDNnYzSk5XS2hvRmtNdVZjYi90LzZyNTdWdHVmZUth?=
 =?utf-8?B?a2tVdHlpNWFoWkttT01GY3I5K0haTGdWQlVjTi9RMWpXUXVCYTYxRTZBUk9v?=
 =?utf-8?B?d0k2K2xHMnBXQjg2WS91NWk4NzV5VXFEZHU5UzNLaXdzNGJCV0pRMTVEOE1a?=
 =?utf-8?B?S2VEN1g2a1RJbTlacC9YbHU5VWFhM1JPREQ4TnNDeDRDTVBOcGI3VVQ4bXZq?=
 =?utf-8?B?VnlLaS9QMTl6Ui9SU0xDYnJkV1N2a3F4WnFaRVBITnhkaEhRaGNaM3BVK1dn?=
 =?utf-8?B?djVxR2o0aFZwMDNpaGhoaEJUSXNEL20ydk5GanBNblhaRFdEM1RrclhnVmU1?=
 =?utf-8?B?cHpNWGdaUHNyakZLcU1WS1NNdjNMS0RSREYrUTFBMVEyVUdtOExxWnVLNThG?=
 =?utf-8?B?N0U1RytvZ05UMyt0UFZqaDlPd283c1pXZlk3WURta01HcnZhMmlCNklvU0du?=
 =?utf-8?B?L3JWL2NWeXJVTzRFU3haZXNIYmp1VER2UXh3ck9TbGlPajJFb0tMSjFSMjYx?=
 =?utf-8?B?YlZjcThzTjgrYVdEOVdUcGg5bjh5OTFoYWFXZlBjcDAvMkZYTVI0QkYrbUkr?=
 =?utf-8?B?MUpnYWVxYnhscTFnQ2QzU2FSbmJ4Wk9WQk4vZ0Z2SlJaQXpUbjIrYm16WVMy?=
 =?utf-8?B?QjhXdXdjdmZQTXh0ZWdHT2FpNlo1ZVR6ZUI2WXZQNkM3U0Q4dVplOVMzNlhn?=
 =?utf-8?B?eGdYRFdTSFdDS3hmcXNzd1J2LyszQ0JIREU1R0JFOFprZFA5U1hKOHBCTGF4?=
 =?utf-8?B?MzVRRHVKaWQ5TUNYY3V2eGV4SEplNk8yQmlhMGQ3VVBsL0d5Y01JMklNZDFi?=
 =?utf-8?B?TEIvQVVBWW9ZOXhvV0VuZ2dETnIyTk1NeHE5T1loQzdKVjlYKzFOU3Z2YS9p?=
 =?utf-8?B?alZsMHZZemlIMFRuV0p1WlczWVpwNnN4enFqS3dRc2pGZndTb3RpQXd1Nllv?=
 =?utf-8?B?akhhM2VRSUZQV3lpQXdHSVFxNStzTDFTN0RKa1l2K1Z4VENZd0k5cHovSGpa?=
 =?utf-8?B?SmxqWGIwaDIybVMxNHduL1RsdDZ4M2gxU1lVK3M4Y2NRcHhLZ3grVnRuUHRO?=
 =?utf-8?B?Q2xaRVdjVjVPUVkrRklpUDFRSWJId0h3TGlHbURCWHN3WmhxZGJkYnB4SU9S?=
 =?utf-8?B?WExIRjQvcmhBUmYzS28vaGlTWWwzOUcvV1JZRjJjOHg2NmZtbVlzQnMvbnlD?=
 =?utf-8?B?bjhJVzlOaDlUTW9hNklHQ1BZM0tZeHFyWDRYRml6blNEazA1L0NQVEVlVU5X?=
 =?utf-8?B?aGVYa2pZRkx3eWpJWUIxZUV6RHBDeU1iMHZhNzRvRGJDSjErdkp6M0tUNXdK?=
 =?utf-8?B?V240NDZIWEEvMFR1V0x5WTN5ckw0RXlQTmZtT0hEYWdtSkJVMVJqeDVOaklE?=
 =?utf-8?B?ZjJaODdnaFBJT1FJUFUrU0FjSVl0TmZ3RUVzUFlOUmJPWnU5dXdsOWhMbkx5?=
 =?utf-8?B?MU9tejVqcnJNamR4bzZKZlFIejBkcXZ5NDBFcjNEUDErUW5rbTZvVUZlQStX?=
 =?utf-8?B?UjhHaXhEblR4TURIbmFQTkpNOEpFSWZvQ1F4eURNOXdrTWNjazBRbFBwdTlm?=
 =?utf-8?B?YW1hRlNIS0FOZSt6L0VWd0x1ZVRzbWRFa3pjTmRuR3Q2TFN5YmdQdjAvakVm?=
 =?utf-8?B?YjNua3BUeWFHSS9PTW9jN0FmaDJDOTVhK0NsK3NyWEpTVUd3QzVWYWZSejNH?=
 =?utf-8?B?MmFLUVplcCsyeXNUSmRrTHBMMC9EakpibFIrNVZPWmpYcktJV0MrRGEybUhw?=
 =?utf-8?Q?RpXd4XWxwdQ20q8v4gkG1FOtm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 090a663f-d358-4a34-66d3-08da72eb85da
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 11:55:11.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWLKBiXCv1ZidOVPP5FqKozVeRwTjFnyIPx5PWDFfaywtpzD/xHb1PjWNw+WLvximLpvtdYlqglEUXLZQYS1jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3174
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 13:07, Lu Baolu wrote:
> Use this field to save the number of PASIDs that a device is able to
> consume. It is a generic attribute of a device and lifting it into the
> per-device dev_iommu struct could help to avoid the boilerplate code
> in various IOMMU drivers.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/iommu.h |  2 ++
>   drivers/iommu/iommu.c | 20 ++++++++++++++++++++
>   2 files changed, 22 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 03fbb1b71536..418a1914a041 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -364,6 +364,7 @@ struct iommu_fault_param {
>    * @fwspec:	 IOMMU fwspec data
>    * @iommu_dev:	 IOMMU device this device is linked to
>    * @priv:	 IOMMU Driver private data
> + * @max_pasids:  number of PASIDs this device can consume
>    *
>    * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>    *	struct iommu_group	*iommu_group;
> @@ -375,6 +376,7 @@ struct dev_iommu {
>   	struct iommu_fwspec		*fwspec;
>   	struct iommu_device		*iommu_dev;
>   	void				*priv;
> +	u32				max_pasids;
>   };
>   
>   int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index cdc86c39954e..0cb0750f61e8 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -20,6 +20,7 @@
>   #include <linux/idr.h>
>   #include <linux/err.h>
>   #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>   #include <linux/bitops.h>
>   #include <linux/property.h>
>   #include <linux/fsl/mc.h>
> @@ -218,6 +219,24 @@ static void dev_iommu_free(struct device *dev)
>   	kfree(param);
>   }
>   
> +static u32 dev_iommu_get_max_pasids(struct device *dev)
> +{
> +	u32 max_pasids = 0, bits = 0;
> +	int ret;
> +
> +	if (dev_is_pci(dev)) {
> +		ret = pci_max_pasids(to_pci_dev(dev));
> +		if (ret > 0)
> +			max_pasids = ret;
> +	} else {
> +		ret = device_property_read_u32(dev, "pasid-num-bits", &bits);
> +		if (!ret)
> +			max_pasids = 1UL << bits;
> +	}
> +
> +	return min_t(u32, max_pasids, dev->iommu->iommu_dev->max_pasids);
> +}
> +
>   static int __iommu_probe_device(struct device *dev, struct list_head *group_list)
>   {
>   	const struct iommu_ops *ops = dev->bus->iommu_ops;
> @@ -243,6 +262,7 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>   	}
>   
>   	dev->iommu->iommu_dev = iommu_dev;
> +	dev->iommu->max_pasids = dev_iommu_get_max_pasids(dev);
>   
>   	group = iommu_group_get_for_dev(dev);
>   	if (IS_ERR(group)) {

-- 
Regards,
Yi Liu
