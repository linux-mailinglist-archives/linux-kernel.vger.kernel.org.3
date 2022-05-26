Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2B9534CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbiEZKJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiEZKJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:09:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78201C9ECA
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653559753; x=1685095753;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2hROc7deKMY35sFq7Cqd3n/fc8Ule0yq6pfOQzTQMqs=;
  b=VvHY0vthMgcvbc0AD2Whk+af4RmvGV4S/tPPRCBNwEJzLFRj8a3RMqvh
   do16NTGpUNSRiYmFFwoHdVHB47FmfbglCjceXm2rbMvvstr6wY9WmubRv
   vEQtajVBuSPjNf15MJOKLFYQh2+Zi1rjBeA+vSopLR/uf8Dkk5A52GL9Q
   pp5dQnVbNZuQQJQDSmAT7uGNyKVdu+bJeOe1KJd+kIQgmBOMQ09jeNyvH
   sML+IVFuL86+uofPkbpUgl1on4ylMugFxufuLpasuqw2WirIS0QMB6vzH
   JU/J6j8MKqubFdP+TNVgWcbwtfZINSuhnxaNS/g6ISH+CbBTF94ua9vpa
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="256172896"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="256172896"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 03:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="602970735"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP; 26 May 2022 03:09:12 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 26 May 2022 03:09:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 26 May 2022 03:09:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 26 May 2022 03:09:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XHMVHmcE4y6JTm3Yb05m8mQYL9B5ShKMe/GLV0P3qWMVWn1hbJnG1iTHB07w4rje+Tofb1JkzIoEwWtaIsNus5pfLTCFbIxpMP5H3K3vxM2eqtE5cgIxjE1FU1E3jDGEq42Hxv5MzX/vs3n1cad+AEwoiRtmb21pdbosbeYo+sh/OPjShf36I12uGnEERMeajMB2zYizFMyMfmouJMVcwuWBGKM8dCNl6wGWlPRg19pifCdJI1nN4f+1TiZiPBPWa0F/y9222SiSusp0R4AN5fCdoF0gCWi+xvFhtDvBare4xw17XFbPkMJjAaO8ufzMBwUWTrX/DZxxGCH+cJkPQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3+zLOD8kGgQeJMjf1khsEh9WgICSdOLLtANqXFmjbw=;
 b=CTmbPpJKdCpMb3zW3kLUbez3IitT2y/DXWB12meL2Sqk0VBzRDQmalmebza7glUiTN/I6NWFVcb6bUsaC3B85cJLYpA7ytTrPc7FnnQoHrofMx5gCeNuJG/F/oJPgVRI96R0RHNXSJgTbxNmYfLK71XsUezQXQ+QC9z+ngUyt6U1lWcpThFkeEnVYmfl7dcJ/5X3yddc1A8IjGOJVKRWsyssFYluZFI6mCOS13dafbiMA0MlA5Uft2ZdSpgMpahpov2jNUpr+jER1QNleAGZ/tOFUtlIFDaxnaw8UdZ4WinbDJR6MacNJ5uMDu6+rsLO+Tx2dCgzNRSJodZGx+WwHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM6PR11MB4010.namprd11.prod.outlook.com (2603:10b6:5:194::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.13; Thu, 26 May 2022 10:09:10 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::7910:3e1e:c6db:8b41]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::7910:3e1e:c6db:8b41%5]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 10:09:10 +0000
Message-ID: <f0b25e5f-5493-d4e2-5bc4-f90d47966c38@intel.com>
Date:   Thu, 26 May 2022 12:08:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 0/2] bitops: __fls adjustments
Content-Language: en-US
To:     =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Vineet Gupta <vgupta@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
CC:     <linux-snps-arc@lists.infradead.org>,
        <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>
References: <20220525144844.1571705-1-amadeuszx.slawinski@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220525144844.1571705-1-amadeuszx.slawinski@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P192CA0082.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::23) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4326d692-ddbd-446b-3cab-08da3effc710
X-MS-TrafficTypeDiagnostic: DM6PR11MB4010:EE_
X-Microsoft-Antispam-PRVS: <DM6PR11MB4010A41D0EBC14AF207348DAE3D99@DM6PR11MB4010.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yczsWK8ROKals3nKMvF9MXNWkduPMnMNZDwMTzt5IKqrEITgDQMLLx8oq091c50R+FgXzmf/hK222V8GcJK6gcNpzojg3Q/xYXhEbTNDzZLBGVYnzxnArQiBc7dtoC4VkEfQX5DIvNHkWPNPjYgQLfv8d2xYRkxqxh0XWya3xGgLMkWWZ4ukdt8z9C6KNm4xC3cOKBCmAKFFU3UI0tQa1o3MvaR6GNhlB/9AhJ+a0ft2DFACjNFgAWeZTnGGpWAau31SCZmBHKHyrPa2VUlrJxFgjIAlvLmZbvvRIWWJW7I2GOUx2MECyVpMeU5DSdBtKBmcSkKMkAZuqRKLYzyzlyIypI7d4MmK27HMAOpm2FdqxF7CE4SkbecZxtPDHtsA1iZ+OdAjwNnu3m8H0iPHUALybN5ats4559hcNqdRzjrAo7V5H5F4w57kllmBR9v2qVvY6uYUTAPf6ejUgjeeTk917aTUEDfE5Jw4dhCkYJqZbGjEzqlFXd5qOZjcukszGPVaYhA7KWra8mh0O6VRS5me17tgCIdHB64hHIsWYdlnTyRddccrfI5u6McHJNl2mUOmaDPhQ/vyTIptJ6UhvaSIWKgTLlkU1Y9eVvePtyK9UoI0CYbL92Tp4KyE0PZYsAKX3f5GJlRwmZWZAsQhtRh8fQZldBCu/9KABtgCrBQgPCZJQbOgQi9lARh3/YjqWTKfgm7f/heght4ohsWmTEHMvOcBFNvUfUI+5ofuFco=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(44832011)(4744005)(8936002)(2616005)(66946007)(66476007)(508600001)(2906002)(6486002)(86362001)(6512007)(26005)(5660300002)(31696002)(316002)(53546011)(6666004)(6506007)(82960400001)(38100700002)(8676002)(110136005)(4326008)(36756003)(66556008)(31686004)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Si9LalBuT1l1UUtvaWVKV2JDVUtacEk0dUpQbGxLUjRyajJoSXA5cGtMN1NE?=
 =?utf-8?B?NDk2aFY0Z0U3aGV2SU1hdDR3Vk9LWDd3MStNSVFQczBSQ1hweFoyTThqYWwy?=
 =?utf-8?B?WVJjUERkTDdzaENTa0U1dEtvWHg5N2FNUHcrUjZXSkRDVzRhd1crekhtMEJv?=
 =?utf-8?B?TERWWC9zd294dS9QMWhWdUlSUVpZajlWbWZxM0tDU1paNkhSR2lzN2diUGRP?=
 =?utf-8?B?OWcyS3pMOGl4UGc4OWhrL0d5TmxPYkFzQnRIbjRpcGxiWU8zclFlRTJJM3Bo?=
 =?utf-8?B?Wkh3Y0VnTFlXZVZrbFEyRkdrNTN3bUluUXdxT0NXNG81aDd0TElkM21jL0Ix?=
 =?utf-8?B?SklrcmdrQ1YzQjNpMlp6Tmx6bE1qclUwbzVEb1N4eWdvRlhvUWNhQ05RRm5X?=
 =?utf-8?B?U0lJbVdjYUVRZlV4SVVLSVV0M1lGcklodW1sK2VLZ2lPVUpveXpYZFBpaHE3?=
 =?utf-8?B?YW5yOTFqMWN3RmcyUXZiNXo3cW5SYUFibDlVcHZ0eUxaT0ZadENWSWVEeWpl?=
 =?utf-8?B?L0xyNmZPdTB3V0Z5bXVHRlllTzJsT0tPV1YzanhKVFpiQjVxWEhDYUE4ODM5?=
 =?utf-8?B?a2RmbUx6aUZZL0FLSDhZLzhrSVd3RFdZdjBwL2kzelFtWWE4Y3kwTW5IZXdZ?=
 =?utf-8?B?OUt5VVlSc2t0NlM4VGhEMmdCTjRjb3p2Rm5oUXpvdUlmUWdVNGJNUS82VDBV?=
 =?utf-8?B?YU8yL2JjOUxDcXJZVUZDR1lzc21zbnpTeVg2RGd3NVE1QnZxNXR6MWlMTmFt?=
 =?utf-8?B?Z0llM1pSVkUzck0zUVN6cVduOGl5Mlh5RkdIV2liRDJNaDQ0ZDA2UEhOWmFh?=
 =?utf-8?B?UzZZbzVyQVhLZDU0Y2grN3c4WEc5MlB3NC9TUCtqWTgxcVRNT0szVXllVnVZ?=
 =?utf-8?B?cWdnTE41VDRvV245SlpwWGZySVdXbE95aFBPWDU5K3pwaklWZHh5aHNiQkk3?=
 =?utf-8?B?TFpiZWNVT2ZNRFY3MUhNVzBWZHVWUzB6ZUlhWVFPNXJKM2NHMHNsM1IxQWpQ?=
 =?utf-8?B?MUV5RGJtZkZYenBLNHBteWdtNVVVazVWRkRxT3R0TGlJOTU1Rm5JdTZHNGFm?=
 =?utf-8?B?ZEw2eE1HTDg0ZEdDVTZxTkJzWjN6dGp0Z1pzZWxkK2ZmVzA2bEVxRGpvcDR5?=
 =?utf-8?B?ZEZLNlNZSDJPUVY0QjJFbndXaDNQVkNqV1dDbytyS0wxRFZHeVdKeTVzOXdY?=
 =?utf-8?B?M05YTWdkeDMyc1ZZU1h0WnJHMGVTbHQ3eFVxb2NFVXFydVJ1N1hUU2h1ZXlM?=
 =?utf-8?B?UWpkZWx0Z0xjVitKMUdHMCtxalo2bzFFWklmcFpBb25LTm4yMHIydVlteklG?=
 =?utf-8?B?N0hwanNwWmo2b3UyTlRxRzhuSis1SmJxakd5Tm1vVzRpa3hVeHZkTkcrVThl?=
 =?utf-8?B?UE5aTk9YcStSdng3azNXcEVYaGxkRkJpZzRXcm1ZTHlaWHRmS0pIMWkrUVBz?=
 =?utf-8?B?YjY1U3libmlPV09PSXAzM3kweE13ZWwvMHhVVHZsOGRnOUxpL1dBdkVPSWNq?=
 =?utf-8?B?ampKZkNaSEd2QmNxa3lIanFXUS8zNjdBZjVSNzBZWTByMTRjeE9ydStRamRp?=
 =?utf-8?B?TGpFVTg5S3dMdW9VL3E2aVVROXlicWlBMGcvUmM2d3E1L2Z0K0ltRUJtdk0y?=
 =?utf-8?B?OUdpaTNoclZQRHZnd3lxbk5XZTZUTm01b0FHY2xBS1lmZWc2MUM0VlJwOE40?=
 =?utf-8?B?V09RUzlPdGNFQldhMnBwaTB0Sk1yV2RXZU1UVXNQaEE0aU1hUmx5Unk0NXQ5?=
 =?utf-8?B?dEJMTGxEUmI4Y2NBbjZ0WFRERlJ6Sjl3cmdrdkxxSXNWR1I5NHhHNDMzVkxW?=
 =?utf-8?B?ZGdDZXFYb0Q0eGJFcTh6UjA5aC9vV29PanV2Yi9XMjROU1pNRmRGODhjN2gr?=
 =?utf-8?B?THdrMTE0dWdOTjFNMTE4eDJhRG50WWlZcGQ1Yjh4dUwrWDF6aEo5dnlqRnhH?=
 =?utf-8?B?eW9hcHZxb25YYjUyNUdRQjQxM09SZUp5Z1NvQjJDL3FqbnlSNmovUnBIUmc1?=
 =?utf-8?B?UXAwbU5POGZTMXRBSGlvT2RpK2VUQ3dJQk9lN3ZMeCtjQ3cwN2oxc1Z5NXJT?=
 =?utf-8?B?MzVaVVRXd2psTmFES1BWeitrYzZjWG55YU9QMGg2R0Q3cDBRMWpySStFWXVZ?=
 =?utf-8?B?cm1kUUxHTzZsc1h1M3Rudmx2cGllS3N1OEcyOUhsbnB6clpTN1FrVUZrUVZr?=
 =?utf-8?B?ZnBidURET0dQVkNlOG1ZdlIxRDdrRk5HRlNpeTZGaFdONmY1Qm5iOThBSkQx?=
 =?utf-8?B?dGpYRFlqZFFYUWRjRVdqTk9yeEtWR0Q0ekYwdGJBVXN3ZTlKWWJaNG1sWkRE?=
 =?utf-8?B?VjRja3czTGJPd1R5UE8yY1ZNRlcxdFZsV01mZXVNcmwvcTJVeHRyUUcwZ1h0?=
 =?utf-8?Q?J5FcWKrbEekD05nk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4326d692-ddbd-446b-3cab-08da3effc710
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2022 10:09:10.4597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +aRf0ezsH+G1RyS9h75S6+0oosxA40EouG4qykA/UQ0qy98183p6xWrKuqD8g8EGpse2Hs5TwJPMkVGvINSSjCiZDnUQOglcpHfVtFEVzFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4010
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-05-25 4:48 PM, Amadeusz Sławiński wrote:
> Apparently on few architectures __fls is defined incorrectly. Fix this
> by adjusting declarations to asm-generic ones.
> 
> As far as I can tell there should be no functional changes, but I don't
> have devices to test it, so it was only compile tested.
> 
> Amadeusz Sławiński (2):
>    ARC: bitops: Change __fls to return unsigned long
>    m68k: bitops: Change __fls to return and accept unsigned long
> 
>   arch/arc/include/asm/bitops.h  | 2 +-
>   arch/m68k/include/asm/bitops.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Thanks for the fixes Amadeo!

I wonder if there are more places like this to address..
Not tested but I do not see any issues with the code so:

Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>


Regards,
Czarek
