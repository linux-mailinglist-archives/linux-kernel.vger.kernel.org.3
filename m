Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD80A585ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 14:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiGaMKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 08:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbiGaMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 08:10:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8EF11A38
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659269406; x=1690805406;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=G2Co5FT6Ojezv64+HgEAuiYmiJ132GbxejP4ODVVqhk=;
  b=l3rSB4xhROvrye5FZZdiq5upMRN6lqnMMpJf3tU78EmZ8zcnMdZ84SAi
   XVlus9fiFVAvK50U0NHvd9hbsfZ4kWj139sfYAVwIox3r4564b43mYTFw
   LSIHkNLwNbEkI8pc9jowOqrQ6rHz/5ljCjyqwXDLKbeu1XJolSrkY5Mth
   8GanDfxghEoAZDcBB5BCv7jjhb522j5XDQxSiQ/6MPGSo2YUo9urKHERz
   z9ckSvTtLdF3xJUcQZqQk0GSqny/1NrxweNRZoOf2R/M252PCF/5WttUV
   ULKmLnG5lcxt3C3WkRSNev1M1CAWn/XRxeh3KrthODecef47OqRRr9lRj
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="268756619"
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="268756619"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2022 05:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="691190791"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2022 05:10:05 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:10:05 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 31 Jul 2022 05:10:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 31 Jul 2022 05:10:04 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Sun, 31 Jul 2022 05:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ut8932xN4Z0j/nNYzRhTb1DSGJOxhiR6HCIzXo6W4X7ICcis4t5paoQgcbPFAO014X5W8mMgY4b10jiogjvLx27IIfLexFQAbAGlp3FgTZRD+cgmzRFCDX3HGir9BGu5G6KzttrViLe+kT/s020KyMnh2A0RlcjRKPnbK7nJ4kO1nY1S9tR2utX6xf52wJ8sd07KjdeFsgx+u4H07EDzvfpxB9CMDnCrqOYcjmVzlOK+i7wWvNBXAKqu3oetesVP3I7M4IG13bN/LNS5xfmbUOi9SNZReQ46wXATeleBvTHUCPEuyz5CUC/EsL7arnh0J21nfP745HirsU7ymcQt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfYzFzYToIjphNBF4cPp0QHbsHvBFD/jJ0QYiHiBx4w=;
 b=kj/W2VYdMDK9epuC2glHIMdi8LA3t3VNYUtBbH3f8X50vsd4EIEYeIxap+Sb+6SjUpEHvsRg4lOHnCNJ3ZDfVhue4KCD05a2tfeW4TKaghYiFDWa3lVj+rnun5jwI8Ofo5GOglkcvoE/Bd4WZGxOms0GAcLifhaP+oeTmfymdtUi1bjU3XoCWJC51LuaPr6omrl8u1D2yVhmtv9JjTY0QCGiRtprRMRKoOFoigA8FemUW8IeudV7GHGjr3nuMv5t8Thiy4GPa5o3ZpS048q8OpMX/qrUyAN5JDsS2p7V7LAHfAx5loc675P9KV/YSfXTy8KC508WZ0incfcGEnL0CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5658.namprd11.prod.outlook.com (2603:10b6:510:e2::23)
 by SA1PR11MB5828.namprd11.prod.outlook.com (2603:10b6:806:237::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Sun, 31 Jul
 2022 12:10:03 +0000
Received: from PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f]) by PH0PR11MB5658.namprd11.prod.outlook.com
 ([fe80::d17a:b363:bea8:d12f%8]) with mapi id 15.20.5482.015; Sun, 31 Jul 2022
 12:10:03 +0000
Message-ID: <22c382bb-77db-579f-2eb2-d5a8b49c5de1@intel.com>
Date:   Sun, 31 Jul 2022 20:10:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH v10 04/12] iommu: Add attach/detach_dev_pasid iommu
 interface
Content-Language: en-US
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        "Will Deacon" <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Vinod Koul" <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-5-baolu.lu@linux.intel.com>
From:   Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20220705050710.2887204-5-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0066.apcprd02.prod.outlook.com
 (2603:1096:4:54::30) To PH0PR11MB5658.namprd11.prod.outlook.com
 (2603:10b6:510:e2::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c6a9b31-05ea-415e-7c80-08da72ed991d
X-MS-TrafficTypeDiagnostic: SA1PR11MB5828:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kOB8f/1oe93TxNQNFfidZLqR08nfufNgssflFD6TXAiqaPWKHed6yoaaLmuXTt4BdVLHF6PMazhi46Vtvj0tOEG1iWU0oFJvXbV65exjameCp7OmChsT5u8jRssEHCbdDWA+Kk78ISS62Tc+yqljTzqj4A/b84B53jjD99+uHxBueadYkcL/9KBv6j97Q7Yp8Dk2UqJiafi9E719g8ZkKOxYuWuzyi13vlML6TcBN2QLGYa9K7Tsr51odWOhS/EwT//L6maZ/EfD9fjXO1Ap2+kwwSmauTIi2Xt8Y4qRMwJAnV/h7bPsNG3MJ0U6XAHGZylUVuATqezVX0ZRA/lVEt3SBuz8DVkOhNbkq9vtUTQWDjJz9tlc3p4a/5hAMqzamX/UpIGL5CGqrMNlyaKK2xWBq9rxdrcmTzeyK62LVbTT03ZoXcD9AbAun4/roXxOl3aIq7oeCALILXmoe69KlWQSHNxJzeCvmTGCX498W2GY2ZW9oXpwku2NMgdlzL+hAckdZen4gIOf4HuSp8SDEVIGFvxwY41pn92ls0G7mS6DzD0vzgjGOpCPd7nU/GY5ZQGXVgXarBgYRXfw+Payetbsy3KcB5NzhVvoTZUvNuE7e1u10mKoxJy8qnsvEKqKi6j4zCil8dUxQOH5FF6ytKeiUK6F6Nrw1JYHwTNqobrV8EiZsaGf8MXsDULz4ueqAe4nSOYOAfAbb0wOvfITmvm2EFlGWH5FyeZp0AMhmbqbrd+5GX6oZLvK0fPVnDwz+IpAnVcCZ0vsJ8twFr+zcj6/+Hk32uR7Xafhg46ArXlBQzvcr8PcfR8NT8lGG6Iw9Ju5xraaLfxU5+2Wx2ObeITmXHusai09Qsyrp/6Ixis=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5658.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(346002)(376002)(38100700002)(921005)(6486002)(478600001)(186003)(2616005)(82960400001)(6512007)(41300700001)(83380400001)(6506007)(26005)(53546011)(31696002)(66556008)(86362001)(31686004)(2906002)(36756003)(7416002)(66476007)(8936002)(8676002)(66946007)(54906003)(4326008)(316002)(5660300002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHpSUzhBaFlsc3RsemZWOU1VWGJrNXd4YU52QXFENEU3NElHaXQ3aWFOVjUr?=
 =?utf-8?B?YTRySkFzZjJHb2tTdHNLN0Z2VUVmUk1QUFNkQU9nbTBwMUttU1Bsb1ZTMXR1?=
 =?utf-8?B?bS91Slg5Ti9rTHVxdURDaERrZnc0NW5HYkx0UXdQamcwbk02Zjd3SUQ1V0Mz?=
 =?utf-8?B?Z3hQU1pDQnFBclNsb3dudGhRUHI5WFJHSnc1VEZHWHBVTFB1dkhyVmMyeVRl?=
 =?utf-8?B?YzVnKzBKY2p0ZGM1RThiZy85RHY3bSt2WGdEeTMxSmFpSXYvM2JhbzdlRG1P?=
 =?utf-8?B?RlM1Z2N4QW0rRHc4MlBZbWVtMEdDVGR2MS8va3FSRFFBbWZOQXg1SVZ6WlJk?=
 =?utf-8?B?TGFWRFlGZC9ZMXd0YlFuRlRNRUd4UDZhWDhZUmt4ek5uQ1RpcUVqUWwwbGxF?=
 =?utf-8?B?L1JPbGlzWlZJaEErUHQvWHR5Z1Z2YkdPbkNrV0h4NG1VUjUyUmNidFpIM25i?=
 =?utf-8?B?SWQ3ZDE5SW5iV1V3RVg2ZUNBcnFONXM0Rlp0TkpXYTlWNmlFeHdwZDZoNGZv?=
 =?utf-8?B?Qm9BenUyWGl3YWtnZ3VUaitsUnVaWGZ0MHlEdGl2TDdJS2ViNzd6SGlyd29P?=
 =?utf-8?B?RXI4b1pyWDI3UFd4ZWtpUzZLTFRud2Z6dmhTNWU3UWVqQjdDYzhITTdsUDNs?=
 =?utf-8?B?UEs2RUtWMWpHWGV2S0pjVTNlR3FUa1BudTZnaFVkUEZmYm9MUlpWQy9SUzZE?=
 =?utf-8?B?UmM5Z0dEZnBrL1krTGJEM3Q4QjZVay81UXM1QnY0dUtZYmNVRkZUUmxZYmJJ?=
 =?utf-8?B?V29vMkJxWVRpZUx1ck4zTDQwZEk1V1R2K2t5U0NKdWFVZ3dFVUF2RjBEUVpx?=
 =?utf-8?B?Z0xxOHFiNDBFSjAwcE1ValZxdUtuSUxGVVRUUlhNWkFxUDRMUGJ6cEJlUEtX?=
 =?utf-8?B?a1VpcEZZekE0ekdVYzZvZTJuU2syRWp1Zi81R1h5cWdrc01odVJtQldueTlB?=
 =?utf-8?B?K3RHY1pWZXRpVm5yRmhhTWg2VVRwZ0RPNDR2SXBrV3JwNWdwa3puWGZtSVVW?=
 =?utf-8?B?cUg2emxOOHRYNjd0YWdWeFhneUQ0S1Q4UTh4M3JoU0hCWnlCM2VaRG9BQURk?=
 =?utf-8?B?cU9CVERWNm1iYkNIUDJuaWJhSlhjZzZEM0tVOUJKY2FDLzQ3NGNERmw4ay8x?=
 =?utf-8?B?blpkOVR6WGRXTTB0UGFLYzlhb1FqUWc0dWlDZXBhYU1lOGp4MlZCSnV1SkZV?=
 =?utf-8?B?QTJMNGJxbldUODFMMC9UcG9WbThVSmZ2bXVGVVQwSndQRUpvNmVmTzNtZlBk?=
 =?utf-8?B?TGNmU0FnN1VzTG1iOXBIVVZWdU5XSjYxSk5ycFJVK1dVckJlaURVQWlnaTVR?=
 =?utf-8?B?WkVBZ1FGRlVJUHhJSExGUHNaKzEzNG1VQm5vNzg5Z0dSMytQakpBWUVaalBW?=
 =?utf-8?B?ZU4wTVg0YUJybGw0UjVHTlVSNWx2TUVsZlNQOXVvWVJkQ0M2SnVDUkFMQjJH?=
 =?utf-8?B?TlZ2alF6SDFuV3N1L1lDZnNVdis5SnRMaTYyT1RTVjIwN05VblRmaUtLT2Nk?=
 =?utf-8?B?TkdubTNzRmpJMHdQNnRjMG9GdThqSjl4WndyQStGU2VESzJhWWd0OHYxYkxM?=
 =?utf-8?B?ZUtFWkVxS2F6N2p2RFJrNWxpckpjbDNHNUhpZnFxUUgzYVpsMHBPWTBDS3hK?=
 =?utf-8?B?a2M5c01WUGwzMmsyY2FuL2M3b05Ua016SXIvemZnQktLai9zdE9QQUhsaS83?=
 =?utf-8?B?ZGVaTms5SEpoYjlDVGs1cEd2RUdPRDdqUFBRWSt6VzZlVW5XeXZOZEdMQ1BI?=
 =?utf-8?B?SFhnVDJVRmNWMlYxN2ZwemZ1Z0s4cHl2cHhCYjFnSDZiRWpjbmlCQ0pKSUk0?=
 =?utf-8?B?ZDRIWnVsOUhpYXhYd21NRkFEZEhMbTgvR3NRRis1cjBCSHJ0Y0pvZnM1a2lR?=
 =?utf-8?B?NHhGVFF4VFNsYWFwV251Q0tqcmc3cW5MUlpkcnlSRjc3YVVNbXYvRzA0eHhn?=
 =?utf-8?B?VHo4VFhPVVRMRmxaVEQ4VFptUThtcGwyaTJDekhadGVPbTFUUnhqeDlDY2s3?=
 =?utf-8?B?ajhzbGJGcE4yMGswZWVWQ001eGdzYmE2ZlFhSkI2U0JzUUJyS3A1TGpydjIv?=
 =?utf-8?B?Y0JXZlZSY2p6dDNlNnAvZ21yNllkWFpmVVdwYjkxcnZGU1hzSlFOWWRLZGk1?=
 =?utf-8?Q?dSVU+uXJnzfawatPxAW/5xwGo?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c6a9b31-05ea-415e-7c80-08da72ed991d
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5658.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2022 12:10:03.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2l1CSk9eAc45i9bmBai8Ja5fyNzE4GJYh54ac8nEwuZSbuQUVzAJEczuiQhpVcGpUxV/eZCTrat0pFD6UpR8mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5828
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/5 13:07, Lu Baolu wrote:
> Attaching an IOMMU domain to a PASID of a device is a generic operation
> for modern IOMMU drivers which support PASID-granular DMA address
> translation. Currently visible usage scenarios include (but not limited):

s/visible/known/? "known" seems better. up to you. :-)

> 
>   - SVA (Shared Virtual Address)
>   - kernel DMA with PASID
>   - hardware-assist mediated device
> 
> This adds a pair of domain ops for this purpose and adds the interfaces
> for device drivers to attach/detach a domain to/from a {device, PASID}.
> Some buses, like PCI, route packets without considering the PASID value.
> Thus a DMA target address with PASID might be treated as P2P if the
> address falls into the MMIO BAR of other devices in the group. To make
> things simple, these interfaces only apply to devices belonging to the
> singleton groups, and the singleton is immutable in fabric (i.e. not
> affected by hotplug).
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>   include/linux/iommu.h | 21 ++++++++++++
>   drivers/iommu/iommu.c | 75 +++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 96 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f41eb2b3c7da..f2b5aa7efe43 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -262,6 +262,8 @@ struct iommu_ops {
>    * struct iommu_domain_ops - domain specific operations
>    * @attach_dev: attach an iommu domain to a device
>    * @detach_dev: detach an iommu domain from a device
> + * @set_dev_pasid: set an iommu domain to a pasid of device
> + * @block_dev_pasid: block pasid of device from using iommu domain
>    * @map: map a physically contiguous memory region to an iommu domain
>    * @map_pages: map a physically contiguous set of pages of the same size to
>    *             an iommu domain.
> @@ -282,6 +284,10 @@ struct iommu_ops {
>   struct iommu_domain_ops {
>   	int (*attach_dev)(struct iommu_domain *domain, struct device *dev);
>   	void (*detach_dev)(struct iommu_domain *domain, struct device *dev);
> +	int (*set_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> +			     ioasid_t pasid);
> +	void (*block_dev_pasid)(struct iommu_domain *domain, struct device *dev,
> +				ioasid_t pasid);
>   
>   	int (*map)(struct iommu_domain *domain, unsigned long iova,
>   		   phys_addr_t paddr, size_t size, int prot, gfp_t gfp);
> @@ -679,6 +685,10 @@ int iommu_group_claim_dma_owner(struct iommu_group *group, void *owner);
>   void iommu_group_release_dma_owner(struct iommu_group *group);
>   bool iommu_group_dma_owner_claimed(struct iommu_group *group);
>   
> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid);
> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			       ioasid_t pasid);
>   #else /* CONFIG_IOMMU_API */
>   
>   struct iommu_ops {};
> @@ -1052,6 +1062,17 @@ static inline bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   {
>   	return false;
>   }
> +
> +static inline int iommu_attach_device_pasid(struct iommu_domain *domain,
> +					    struct device *dev, ioasid_t pasid)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void iommu_detach_device_pasid(struct iommu_domain *domain,
> +					     struct device *dev, ioasid_t pasid)
> +{
> +}
>   #endif /* CONFIG_IOMMU_API */
>   
>   /**
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 74a0a3ec0907..be48b09371f4 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -39,6 +39,7 @@ struct iommu_group {
>   	struct kobject kobj;
>   	struct kobject *devices_kobj;
>   	struct list_head devices;
> +	struct xarray pasid_array;
>   	struct mutex mutex;
>   	void *iommu_data;
>   	void (*iommu_data_release)(void *iommu_data);
> @@ -660,6 +661,7 @@ struct iommu_group *iommu_group_alloc(void)
>   	mutex_init(&group->mutex);
>   	INIT_LIST_HEAD(&group->devices);
>   	INIT_LIST_HEAD(&group->entry);
> +	xa_init(&group->pasid_array);
>   
>   	ret = ida_alloc(&iommu_group_ida, GFP_KERNEL);
>   	if (ret < 0) {
> @@ -3271,3 +3273,76 @@ bool iommu_group_dma_owner_claimed(struct iommu_group *group)
>   	return user;
>   }
>   EXPORT_SYMBOL_GPL(iommu_group_dma_owner_claimed);
> +
> +static bool iommu_group_immutable_singleton(struct iommu_group *group,
> +					    struct device *dev)
> +{
> +	int count;
> +
> +	mutex_lock(&group->mutex);
> +	count = iommu_group_device_count(group);
> +	mutex_unlock(&group->mutex);
> +
> +	if (count != 1)
> +		return false;
> +
> +	/*
> +	 * The PCI device could be considered to be fully isolated if all
> +	 * devices on the path from the device to the host-PCI bridge are
> +	 * protected from peer-to-peer DMA by ACS.
> +	 */
> +	if (dev_is_pci(dev))
> +		return pci_acs_path_enabled(to_pci_dev(dev), NULL,
> +					    REQ_ACS_FLAGS);
> +
> +	/*
> +	 * Otherwise, the device came from DT/ACPI, assume it is static and
> +	 * then singleton can know from the device count in the group.
> +	 */
> +	return true;
> +}
> +
> +int iommu_attach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			      ioasid_t pasid)
> +{
> +	struct iommu_group *group;
> +	void *curr;
> +	int ret;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	group = iommu_group_get(dev);
> +	if (!group || !iommu_group_immutable_singleton(group, dev)) {
> +		iommu_group_put(group);
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(&group->mutex);
> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain, GFP_KERNEL);
> +	if (curr) {
> +		ret = xa_err(curr) ? : -EBUSY;
> +		goto out_unlock;
> +	}
> +	ret = domain->ops->set_dev_pasid(domain, dev, pasid);
> +	if (ret)
> +		xa_erase(&group->pasid_array, pasid);
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	iommu_group_put(group);
> +
> +	return ret;
> +}
> +
> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			       ioasid_t pasid)
> +{
> +	struct iommu_group *group = iommu_group_get(dev);
> +
> +	mutex_lock(&group->mutex);
> +	domain->ops->block_dev_pasid(domain, dev, pasid);
> +	xa_erase(&group->pasid_array, pasid);
> +	mutex_unlock(&group->mutex);
> +
> +	iommu_group_put(group);
> +}

-- 
Regards,
Yi Liu
