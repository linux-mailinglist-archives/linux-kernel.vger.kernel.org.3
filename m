Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16BD94D3E99
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239085AbiCJBPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:15:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233367AbiCJBPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:15:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200951216A7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646874850; x=1678410850;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oMw8nPanez/VeDDtrmrZcAbN96hxfq7pTqcP6MBnvCM=;
  b=i08SWbyjmKqW5YW0a0fPMEgeGbHZYXx3H5PrJbqrBAMZEFhXfo7smEZX
   rDJ8TCKm5Mw3cHdkV4DZOcBUJ3rFDcSBfPsYtHE6AtWkNzebMr8OL6u2A
   IV++Y1igB8olBzjYl2xhkizLaXt0GTW438jLzeK/W+v76qYG3w9u+7vew
   uKyzk7TpKx5cHHI9/k57NxRwivoVnxVOBoH4aBgQZaHD+53mH9L0HB5ca
   d5CZT0rwN3iIK4c9Z9J0909O88hmyyZie5YQWT27c1OsKnxqS3jg6gpDk
   trfDCZQ6KhbNDW9LcCSkdkJpPGol7US/XBHXHnz+riKeiPSHjNrDij6DK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="279864490"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="279864490"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 17:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="712168354"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2022 17:14:07 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 17:14:07 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 17:14:07 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 17:14:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDM21pZrPrKuMuSeHBlqnV26KM8ONqqVfQhPkK8hBS8dGAd4UiGtlTif6qQNjYNmoJi+qVJqRbkf8SdwVx9GQDwCoCSPvRFHmdiU+7Tmz0gT+k4QS6+Kq9LT4+ZLvK34gABKgdVAC99zXzsoiw4/p+CVMC3NASqMHVQXdz+C6Ggg9zfwcvTIuL+UQBJueq3upu0eZB8yH/FxH7lUl01Tcy+9vS702fA0seBIS35KsQWtdmL2C2xXui1xAfWePrqRE+9f0zoz/g3toGVU3wo/iGlwJCK7h5RcHq2+uMvDfofZLV+yclr4fddiYGXwjYVg5DqgdXxk+KdLIYq1jt1N2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhbAQ09Ulg/SCYcv511JqZK2n884OSsSqnoV/qPw43Y=;
 b=H6G5LHN0lPQ2Z7URDyIYhFSE5Kt/tU+XggQX8NsGLzRDD2+5amXZ1neWLT7g/EGw6VGy7LVndfCCFH0VkmDKPfgAk+KwCtSRMTPWqNvfs6CI3jfmq/Kp0m5UoOMLAd/UA1alYck2HMp4CrGGcm4x2aLINo0lmQeEce7l2uedvkieZ/1laObZncy+5/7HOuKZfdWlZYiPVhWNSjxCOQ7aOux3NleWiwBnHTLSjKxsIP9wKbf07WuZHMptsBCBQlsTiIfFwzGGjOzzpB5sxAhnaBSQJqxY3NT5Twj15KglRpyBNY8xdYykaZr4QRpF7eGMFovvDEuCJ8ibUgEd2oHfmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 DM5PR11MB1338.namprd11.prod.outlook.com (2603:10b6:3:b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.17; Thu, 10 Mar 2022 01:14:04 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 01:14:04 +0000
Message-ID: <c9998ec7-bf40-e4dc-2842-c211412ad702@intel.com>
Date:   Wed, 9 Mar 2022 17:14:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [Intel-gfx] [PATCH v10 5/5] mei: gsc: retrieve the firmware
 version
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Tomas Winkler" <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220308163654.942820-1-alexander.usyskin@intel.com>
 <20220308163654.942820-6-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220308163654.942820-6-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:5::31) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3575fe69-3710-4b7f-f238-08da02334494
X-MS-TrafficTypeDiagnostic: DM5PR11MB1338:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM5PR11MB1338417671021398033B6D23F40B9@DM5PR11MB1338.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7jsFFb85IE8GBloy+Vuhf30hAJPm3vMcjoU1ijudHE1Qw/AYYIOTDFFnAIgAAmyjO+/W6ALAH+0LxG9IZlNS4VLQzhHtj92J7x/rktUyJ+acGiS2CIky895vT9wHfKemPOAXSJJue4AHN5FVEg9vzu9risulmyECN4tpRhddrxaNWGLGmXbrQi+QSwFvZ7HW5ha9o/9WjKkLfLdK7+3WdHceDrV/TalwI4+STDzfggou8v9JIurn+zf3K4Ry5nbBOIwYhzSN7c0FbW2b2MOS1HoFq77h666ze6KDf7U5Fqz5B9vYylSn7sSUz6s7eMC7Wlxz6/BNoZjcdk+TAZuJTjnTOZWejNGkm+qxsTRKJfHGH3nZ7FU5cJa85s2JVQIJRI4PoiXWcyXKndSQhPCYxSNeplTLBFI+zXQj5skTZ0dOuRySEn34zU8+TQBny96kzC+SVrK9SIDSUpHCV7UOKRmt9e0HKibKZfmqu4HYwIQIZ8coU373HFdVDTjSeO0YqxlLmg5CrsXrI4eUvDazPLDJWfn8d6iKnNsXL2op9mzPp0ST2BI/CvOm0kvI6xTbVdt97BgVRGUT8BnUQ/TxD5N1J/TD8H+6FtTTlQ6QCe5Bon0MkrvR6QLHsAcUNspQt4pOmFoq/iL2GpSu9gBxcbNSO8bhRBm9inyzr1xmiuJQc/Ak08bIOtLFT2z+IrCo60jKVetuCmeZYoY8U0JWqhqajyrbmVtOUNk84ZM/78Qzp0sAGXfZRjF6O1qAJwE
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(4326008)(26005)(8676002)(66476007)(66556008)(5660300002)(36756003)(8936002)(110136005)(38100700002)(54906003)(31686004)(316002)(83380400001)(186003)(31696002)(86362001)(508600001)(6486002)(82960400001)(6512007)(6506007)(6666004)(53546011)(2616005)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJxRVdLMnJXUzJOOE1WeXN3VUFQUUorN0cyOEhsTEc3UEc3UDFJWmRMdU1k?=
 =?utf-8?B?SGFaeEtTZXEweEhkVFMyL2JOQzk3TnVjNjErWEFzR1Byc1FkZi9WZ0wwVGxY?=
 =?utf-8?B?aWE4UXpja3phemNCN1RwM0k1SERxSUQ2VTlRR0NZOFBKN1I3ZWdXaGoxSXJx?=
 =?utf-8?B?Tmp5dW44R3lVRnJ2a1RJa0lzemw5c0tmL3NTS0Vqdk1nRW1qOGIxQ3BENnBp?=
 =?utf-8?B?a2NEQUZlVnZPYkkwc0l3YkZNblltVjhYVkc4RzFFSVNPcjczb2xJcWprM3Bq?=
 =?utf-8?B?Vjd1ajhrUThiVlIyVjFYdVFkQWpJdUNWc1RSNE5zWFJ4TEIvekRGT04wNFdZ?=
 =?utf-8?B?dDdBMk9KQ3lUcmlJY2RXYTZSOHpRc01uOXdSMm1FWnlwY0ptejJ1YzYzYTJy?=
 =?utf-8?B?RkIwS3haZXdNQzJaUk5TOFJSVEJqalRsMEJpUDE0SFlnaWxVWjZ6Z2tialAx?=
 =?utf-8?B?blpCb0tCU3ZZc0x3TjA3eklxUE8rbFdBOXlQN3prd0ZoNlI1aGxHUE8vOVJo?=
 =?utf-8?B?TnB4eTQ5MTM5VjBMS2hUYmk4R29jR1I3MFMxd1ZlOG9tNEdmU1NLcVpPOHZr?=
 =?utf-8?B?OFNmWW9SSTVOTFFCK0FXak1SUFZuZm9zREJLaUFIaDljUmQwNG1kTUdOdkdD?=
 =?utf-8?B?aUZKMG90cFFoYWQ3N1dRNE9QTDdiSUg2aGNZY0ZwKzJYaGUrME5xMDNXNmtU?=
 =?utf-8?B?TmpPRTlYeTlnbTVYTmxVUmRSU0lHbjhGNS81dmVIMGtHYmRwOHl6NEhsaVhz?=
 =?utf-8?B?UEtyZGJFM3c2NzIwaFpmMjBCbE5nYnJkNXZVQnliaFlhdTl0d2FuT1krZTVX?=
 =?utf-8?B?bkxwYzYvYXF0dm0vZlduWmJ2RHdIZ3R1NlNBQ3ZNcjZycXNDeTN6L3RlQXIx?=
 =?utf-8?B?OTdpbEdWMWRxVXZuSnFVNEY1Vm91blFzd3lPMzRiVWtyRERKc1ZZT1BVWkZY?=
 =?utf-8?B?TEVnZGptdHlQWUsybnZuRFVzWHM3dUN1WUxpTk1IRVpQUHRPVUgrZW8wdW1q?=
 =?utf-8?B?MEVITE1yUVA5bWE1ZHkvWDI5RWtlZDR1akkyTHB6Ynd0ZUJxR1RZeU1aOEZn?=
 =?utf-8?B?eDl6SzY5RnFkeG1RdU15WWY1OW1vdE54WHVXSktMMzdBTlhYNXJuakRiUjBI?=
 =?utf-8?B?ZFN4Y0ZYMStMM3B5VEJxeWFsclRtakpNYXppMFFpakE2NDVlamdtY1FkaXpv?=
 =?utf-8?B?c2V6UGVTSDE3ZnNROFd6OEoxdFdFei9rR2NrOWQ2OGpTa2NuQ0tkVEh1Z3Ra?=
 =?utf-8?B?OFl5Mm8xTmMvNEVZbGFPK2o0YTl2YkQ3Z3N0bGV2SUlyV1JWSHlCV2ZNUWk3?=
 =?utf-8?B?Vjl0K2Rza1R1azQ1bWVodHoyNWhRN0tZVWk3NEpVU3A1SmdTcHhsdm1CTzZn?=
 =?utf-8?B?eW5UM202TkQybWdoVXZ2RnlXaTRyd1E3VkpkeTJSUllwcFlReDkvdkNVb3p0?=
 =?utf-8?B?R09PQWpzVWpLVjYzaStaSEUzSjdXTW5OZVE1ZW94NGlEZjlCb0xvb3N3Q2Fr?=
 =?utf-8?B?Z0dTN1VZUkhNL3MxbWdHOW5xTFBnTVpCTmdlTHJGajQvL083cVROWTVDSFBO?=
 =?utf-8?B?MEk0bmRET3pLRU96U0VWWnhTczczSlhnbkt1VllaTXdEb2VxUlo3eW9sdEI4?=
 =?utf-8?B?cXpLYlZGRnF5bjFmdnAwalRDNUtRTGVFeHA3U3M3MStEeWRhMWJUakhlZXJt?=
 =?utf-8?B?OXJ1WEQzZUd5UnNwZk9OOTVwRFZkdDcrR0NFS0RodFZVQzJtcG1ZdFdDTU41?=
 =?utf-8?B?SkZSVGdpeERzakh0dUxYQU9iWklKd3U4RGlkcVZ2ZjVBMVZIU3hwVzk0dms3?=
 =?utf-8?B?dWdlbHlRMWErM3VYek9tQVVYOUJNNU5WVkthTnZTYzVwSHFtOE5qSGlvV0VJ?=
 =?utf-8?B?NVJOMXRaQkNLZTlqM2RaLzViMVFCUU1rM1QwTnZzSGxKNklHWGJBZlByOG9a?=
 =?utf-8?B?aUxSWjlOMlQrMnpzNm9ZQmdZZ3NrNmhRQ24rMEh3TW9oODVJdlZGWEpGV0NV?=
 =?utf-8?B?T3hGQ09CZkt5aEJiTmpKRnp5R0Z6d3hHNHYzcmhmRGVzaDBhOFFETlRjaksy?=
 =?utf-8?B?MldtV0kvVnlzS05EK1k2WHBUc0tQYkFHOWVuVTZvdlVHWXBaQnV2SWcwUjdP?=
 =?utf-8?B?ZHY3Y3RCaUNybEFEaUtrVWh4RmpTSWpiU1k0cmZpU3pvL2ZCd00vTEx4b1gx?=
 =?utf-8?B?NGJSRll2STE5aXF6REFMeURtZzBVMmVJQXZmOHNQekVvREhWZlBVQlBteFBN?=
 =?utf-8?B?YnFVdlFLUExtQkdFaEtJYXJDUFV3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3575fe69-3710-4b7f-f238-08da02334494
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 01:14:04.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bM5BzHIeQxqJ4oEWk7BmmaaK8sv1aT3r2hwxrLwI2tSep/ZYLCCWIo1wJbDfgbjnWjYoAizTk27Q2YO+PV8t1x87NhJ/l6O01+IAqsBXyCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1338
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/2022 8:36 AM, Alexander Usyskin wrote:
> Add a hook to retrieve the firmware version of the
> GSC devices to bus-fixup.
> GSC has a different MKHI clients GUIDs but the same message structure
> to retrieve the firmware version as MEI so mei_fwver() can be reused.
>
> CC: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>   drivers/misc/mei/bus-fixup.c | 25 +++++++++++++++++++++++++
>   drivers/misc/mei/hw-me.c     |  2 ++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
> index 67844089db21..59506ba6fc48 100644
> --- a/drivers/misc/mei/bus-fixup.c
> +++ b/drivers/misc/mei/bus-fixup.c
> @@ -30,6 +30,12 @@ static const uuid_le mei_nfc_info_guid = MEI_UUID_NFC_INFO;
>   #define MEI_UUID_MKHIF_FIX UUID_LE(0x55213584, 0x9a29, 0x4916, \
>   			0xba, 0xdf, 0xf, 0xb7, 0xed, 0x68, 0x2a, 0xeb)
>   
> +#define MEI_UUID_IGSC_MKHI UUID_LE(0xE2C2AFA2, 0x3817, 0x4D19, \
> +			0x9D, 0x95, 0x06, 0xB1, 0x6B, 0x58, 0x8A, 0x5D)
> +
> +#define MEI_UUID_IGSC_MKHI_FIX UUID_LE(0x46E0C1FB, 0xA546, 0x414F, \
> +			0x91, 0x70, 0xB7, 0xF4, 0x6D, 0x57, 0xB4, 0xAD)
> +

These matches what the HW is reporting as sub-devices got gscfi and gsc 
respectively. I think we could use a comment to make which matches what 
clearer, but anyway:

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

>   #define MEI_UUID_HDCP UUID_LE(0xB638AB7E, 0x94E2, 0x4EA2, \
>   			      0xA5, 0x52, 0xD1, 0xC5, 0x4B, 0x62, 0x7F, 0x04)
>   
> @@ -241,6 +247,23 @@ static void mei_mkhi_fix(struct mei_cl_device *cldev)
>   	mei_cldev_disable(cldev);
>   }
>   
> +static void mei_gsc_mkhi_ver(struct mei_cl_device *cldev)
> +{
> +	int ret;
> +
> +	/* No need to enable the client if nothing is needed from it */
> +	if (!cldev->bus->fw_f_fw_ver_supported)
> +		return;
> +
> +	ret = mei_cldev_enable(cldev);
> +	if (ret)
> +		return;
> +
> +	ret = mei_fwver(cldev);
> +	if (ret < 0)
> +		dev_err(&cldev->dev, "FW version command failed %d\n", ret);
> +	mei_cldev_disable(cldev);
> +}
>   /**
>    * mei_wd - wd client on the bus, change protocol version
>    *   as the API has changed.
> @@ -492,6 +515,8 @@ static struct mei_fixup {
>   	MEI_FIXUP(MEI_UUID_NFC_HCI, mei_nfc),
>   	MEI_FIXUP(MEI_UUID_WD, mei_wd),
>   	MEI_FIXUP(MEI_UUID_MKHIF_FIX, mei_mkhi_fix),
> +	MEI_FIXUP(MEI_UUID_IGSC_MKHI, mei_gsc_mkhi_ver),
> +	MEI_FIXUP(MEI_UUID_IGSC_MKHI_FIX, mei_gsc_mkhi_ver),
>   	MEI_FIXUP(MEI_UUID_HDCP, whitelist),
>   	MEI_FIXUP(MEI_UUID_ANY, vt_support),
>   	MEI_FIXUP(MEI_UUID_PAVP, whitelist),
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index 9748d14849a1..7e77328142ff 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -1577,12 +1577,14 @@ static const struct mei_cfg mei_me_pch15_sps_cfg = {
>   static const struct mei_cfg mei_me_gsc_cfg = {
>   	MEI_CFG_TYPE_GSC,
>   	MEI_CFG_PCH8_HFS,
> +	MEI_CFG_FW_VER_SUPP,
>   };
>   
>   /* Graphics System Controller Firmware Interface */
>   static const struct mei_cfg mei_me_gscfi_cfg = {
>   	MEI_CFG_TYPE_GSCFI,
>   	MEI_CFG_PCH8_HFS,
> +	MEI_CFG_FW_VER_SUPP,
>   };
>   
>   /*

