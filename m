Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4235B1197
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 02:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIHAvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 20:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbiIHAve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 20:51:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD97AB056
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 17:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662598293; x=1694134293;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=x9URXo2roCMnKwScsXKiTrqZO5uDVIO88xHOrbvXPzU=;
  b=FLqcjoA5P50HnQ/EHSnLNzJFsstJSVMSW3lVmE2EF/ygR7Qwjzo/9WtG
   t5KVCYjrIAeyafPG1m8G4c41kGAI0ccVlnoeGBDOtd53rukOLyrAOLSHe
   zxZs94ZR0IyXHReFyBsPtvXwfHP26bsugCHVF+a+u4gUgQGMeMYn8jit6
   5+Dma0e0E+ptJIvqqLwCiiN3hIFYJt5P1WmGg1T2jPIiCW0vXAK/uzHc7
   kgAr9Qka6oMpSdhs/rWEulf7vazHpN17m76BMIBjP5mX5E7LrMMlwVbL2
   qjO3Pq/QICxD9rIq0MhxZLffX4KACyWGo6JmNa7ytcoLUsWnhkckQBlkI
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="323221839"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="323221839"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 17:51:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="676447481"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2022 17:51:33 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 17:51:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 17:51:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 17:51:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcXBKYpmHv9B4EcRVfYwbCGVTkWUoDP8bydgvyIm5VlY+pnM8dFHNRBfXYoXUWafgw7IprhZUOFm+3au02U8aWKAZyKEQGh9VTzK8ek2H+sj2KP9MQkea1HaCHIvwnK18I8MF9QnxIBahfWnBYpcwc74UkjNXB/okjwRDfru6lWD39+oBWsPqZ7uUHaENglPA9rbmQ8agCLFr3hFhHLHq+yUWIXVX64rRk8PW44cw2Y6U+45Lz8X50CQTlR/s6TKptSivVhDKHoP5iNfW4ImTYQCdCUR8S8KPGOtXTspOwAW3mzBHLGLqPyvl7bAXhgwBUM14YVCt3A2p9Nx0A5AxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAnPnJi4iwPy80b1YZGWqyf1FhbVw5U1SBar5ZeTs1g=;
 b=U9ntUjdskVSY/0ZVpcZprEdv6+Yk9B0swZEG7HglkacooAfRCUHwgJemfvhTkmMBKpOb2n7LcyAamrfHAPXMh2QjJsUHdo3dwwSqgVVEdzkct3Xr0MDPjHLdzX5ogif3qlpz5AxoySB0SJdE6bgGLg4Jlfntvis/1tmTkrBpMfIKG0Ru7l/ddvH62QqtcN9K72uGVGDYPimYomdMo3aYDMlw+EuL17NUAX7hce7KgF+V6XWmw8w7RHQJJNUgCdxgGK4nLNHrrQGpUO9rGrDAo3mSYJlbFuJdRiouOm/IDCheR3Pw0h3tR9+4K+Y0l7iD8BJ1QIPRrM8yxD0nodQnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 SA0PR11MB4717.namprd11.prod.outlook.com (2603:10b6:806:9f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Thu, 8 Sep 2022 00:51:31 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.017; Thu, 8 Sep 2022
 00:51:31 +0000
Message-ID: <bc7518c8-eb89-f90b-ee99-f6082b180e2a@intel.com>
Date:   Wed, 7 Sep 2022 17:51:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v9 10/16] mei: mkhi: add memory ready command
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        <intel-gfx@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        "Alexander Usyskin" <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220907215113.1596567-1-tomas.winkler@intel.com>
 <20220907215113.1596567-11-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220907215113.1596567-11-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0003.namprd10.prod.outlook.com
 (2603:10b6:a03:255::8) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf8e115-9c55-4fe8-ac9e-08da91344516
X-MS-TrafficTypeDiagnostic: SA0PR11MB4717:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pFf36sm/nkQQIgrMdII2qmU0glKXHTWmivJIarYajcuCWhcwdl5vlALLOOQYA5TtDIGugcnPon4JxoMm6KnKbPDLpodLOE5yUnmxOuZZpJpwY0rUh8LownDDDE2YuIPN09j/D5VYQZBekIkygqhzoZXdwU1LSAwV3aO6EDpShbl4eGT7V8PYLWEZR6HxgV9sGrJaaDFe4ag+B5hv0xm6AlGOhUNPXq5kGf/11U0Z9iVSJrLIsPlhDpeoLiDRV7h4wks6xMog1hU3y8FH7SLc5hzmZ2bgF4pLbcqcxNYf8DKGRQxAAZ6iKmk6zmHnEOZRQituDxByg2BL+KEntmMxEXpyFRyqKAvxqK30K4GQ3lgeT+hrDMkDx8oO3JJx0nh6T9mpSjCQpjnMPvR7dQLZRkESz36Wgj+ss/7mCRYynLrdtGn83nrlpGrV+nrcI5Q6+IHpkp752CAvbvlvdXKaIWQzI62hreV/EHiITZZ0tvUH8eovusaUclxGfJkP7RRaVj4gH8PVcYHelRxUk21lUeyL98za5On9YqJnv9Y1o4y5qh52UQZOuH05ijMCOxgx5aWxn9BzCPs6J8fofyIAVDBiy3hx1d6SqOLouSRHiBdqxi8waWdHb3FmbmndI2EQWKK45M7SgLUleDLORXQw04wgxmsIeaoX8zSZM5kywTu7cz/T4twTNLKQQc/sB19bD5uDkVhjxG+h/HZDtwDMQ6EcLdI8N4KWLdF7me4IJoqmb2N6TsEuHgrQvKGPK05ogKRKkgevvQz329PvS9xDjCGFX3byuQptYXVH6FOq94=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(346002)(366004)(376002)(39860400002)(396003)(41300700001)(8936002)(2616005)(26005)(6512007)(53546011)(2906002)(6666004)(5660300002)(31696002)(6506007)(38100700002)(82960400001)(186003)(66476007)(66556008)(66946007)(8676002)(4326008)(86362001)(478600001)(110136005)(54906003)(31686004)(6486002)(316002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVNuSEFGRUNHQkdTcHZJN0t6SFVPV21JTklXSkhEaW9Ed2N2TVJCenhZZnBJ?=
 =?utf-8?B?WVE4bDdBeHd6SUtFU2lLNmRrcXpqbG1vK2tiNHB3N244TkZ0M0VGaXY5bGVv?=
 =?utf-8?B?dXNUeCtBWTc1c1JIbXM1ek5Pa0lFZVlmT1VPdGFjektGUVBWQ0c4b0E4U0pQ?=
 =?utf-8?B?VjNYazZOWE44WEVDaWVMVkxDditveXZyUlZ4T0xndVRSNWs3TlpmZzlBZDRW?=
 =?utf-8?B?NFBhcTlramhMOG9PTjgwaERQNVIzbWF3Y3lXbm1lcm13clhzVnZHd3Y3TURM?=
 =?utf-8?B?bHAvSzlsdE9uOVJMZncyV3JUUEV6UGlRZUNRMWh6UDBvVWY5anBOSmNiWU5W?=
 =?utf-8?B?ZE9pVUhvUlRGSXlFdHFzaHowVjEydlBkYjNRWFZMRFdrZlpnd0VraGtiTkRW?=
 =?utf-8?B?UUs5VUxBRit5UjhvZXlqZXFNMFFWOUp4em8rNzdkN215TWhzZnh3N2N6Zk9E?=
 =?utf-8?B?dlptZWxFTng2VVdqWkppSzRyUXJ1c2xKSktQSHRmOFVvZjl2WVFITHA4RVkz?=
 =?utf-8?B?WXpIVDI2S2lpU0c5L0tTa3REM2sxcUNITklRV2o5c09GMWI1eFRYYzlZUEY1?=
 =?utf-8?B?cTByR0xvV1F4cDNjb1daeDNpVGJrc01vb1RjZS9UUXpXelIwcTVYV3pCQU4z?=
 =?utf-8?B?U05GZW9MYVlOaEJDRHRPM0xOVktmRitTVlU4Ukh4TFZKZzQ2MlduOXE4Q0RO?=
 =?utf-8?B?YXpzQktHYjdrdG1SNXRkSkcyT3A0blA0YXIxd0c2aXVyR2oyZmFOYXhaaUtM?=
 =?utf-8?B?dUlHUEVmVENLUTRMTGdHK0Myc2FoWTRVNm1DblRXbVpPcTlkTlFHWWh4SE5a?=
 =?utf-8?B?VEFEUURyelNZNUsyay9GWVNhdCs1TDdFRm04TEtpMmsyS1hwZmNtQnZvMGYw?=
 =?utf-8?B?ZmZ6YThid3Jqc2kxMlhuYXFCVG9UQk9Cbmpuc1VtZTFNRkRQVm50TElOUW1y?=
 =?utf-8?B?K2orSERIbzc1V01NZFpmRk90M2hHak8vTzZ2cEFsU3dHeHB4Z0cxMHh5a3RY?=
 =?utf-8?B?aElmQlpUMjlwMGJaSkJSQnFPNXI1UVpsZ0wvUzYyVmwyc244MitVVERrWjJz?=
 =?utf-8?B?WmNNOHpoOEhWNDlUY2RBaGJwdFlXRmZpQ3hpd3R3U2FERzVBUjhRN0JwRkF1?=
 =?utf-8?B?OWRhdU1RcFc3WVVMN3V1amVhaWFMcEVMTWhGdHlwM2QzeXVqUFBGTzAxMFNB?=
 =?utf-8?B?VTBzbjRvYk1WNlAwOG5YOVZpV3BFVDVlMWZrVkw1dFNJUEVYM0hhMWxPanpH?=
 =?utf-8?B?bmJkZFpBR0p2aWNXMi9NdUpibVkyS1d3TGxzeEoxL3kraTlzekpNTTVlUlQr?=
 =?utf-8?B?K3BEYlpQbnpQUkNONWk0REQ4R2ZSOVRFdUdqWlpGUnNhNlJWUS8vVjRJUXFR?=
 =?utf-8?B?NmxpY2poWkRlU2VPM1hYN21sU2hVOWlXVVVmVzVZRE5hbEZrYWFacVJkdlVz?=
 =?utf-8?B?OEhoaVpraWVNU2Z0RmVaeHgzQXhkeDRRcTZQanJhRURDWG9RczI4OFpSd2FG?=
 =?utf-8?B?cUIzODdtZDRWNzAwM3FlN0dSdVhFRGhPOWxycndGRmR2clJRTUVyUCszb2sv?=
 =?utf-8?B?SXBjUUxoUHZLMmEwbGtERmxadVUwM3M3VU1oZGxOc1kyZmlVMjA0aDFpdzR0?=
 =?utf-8?B?NmR3OTBwMUhQOFVIMlN5cElxM1p4MVRzbldiM1NsaWRBRG9FM1V4aWlzTzdY?=
 =?utf-8?B?TlRhOE1MOWZsWEZoc21JSUk3N0lzbHVzd3UzYkZKY0h6UEltN2gvb2FBVEtX?=
 =?utf-8?B?aGc1QzgwK0ttS3lZZ3VBOGtUaW9HQThhVHpxbkM4KzZsamJ6eThtSVVyQm1t?=
 =?utf-8?B?bCtDdHhkRlVVS29jVmFsYVJPdUJuVmVidUJyalFkUHRMeTNMT1BkT1FsVmdR?=
 =?utf-8?B?cXYreGRUREdnT3l1cnFHNEJMa0Z0RG1qd2RBaVF2TjF1U1NLeEdIcjNRQUZO?=
 =?utf-8?B?MDBNZFJzd0lCWlpQeTBvelFJbStRSXlzQkpwcUhhZ2NkeHdXdXlrM2U4ZCtq?=
 =?utf-8?B?NVIxZ2cyYjB4ZG1CcU1xSHNaS0tuYmhJTEkrZmxCRGR1dGJxVHFFV0ZzN2Uz?=
 =?utf-8?B?TjRPUVk1OVl2Y1ZjR0pwNlpVN2tOUzl3Zm1EVTg1M2FGeGhvNnRhUlBVOE94?=
 =?utf-8?B?R3BpN0hXcXd5Mnhkd3VmaWxjMVo3VUgxemREcDBXcnk0NTY4WVd4UEVZczJG?=
 =?utf-8?Q?XZqomjGuxmaWeuYOa4M59A0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf8e115-9c55-4fe8-ac9e-08da91344516
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 00:51:31.1206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lgX8sszdH2K4D+/I1mYj39FW3E6X13VK4mIQBmID+Yr8nc0KhNT/EKMNxNRJg8jWHX+9vxNFmM9liUg0F98yXyx9vUSeRdDBmM8sdfQdvys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2022 2:51 PM, Tomas Winkler wrote:
> Add GSC memory ready command.
> The command indicates to the firmware that extend operation
> memory was setup and the firmware may enter PXP mode.
>
> CC: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
> V9: Fix duplicated defines caused by wrong --amend
>
>   drivers/misc/mei/mkhi.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/drivers/misc/mei/mkhi.h b/drivers/misc/mei/mkhi.h
> index c3fa3c5d5cb6..1473ea489666 100644
> --- a/drivers/misc/mei/mkhi.h
> +++ b/drivers/misc/mei/mkhi.h
> @@ -16,6 +16,13 @@
>   #define MKHI_GEN_GROUP_ID 0xFF
>   #define MKHI_GEN_GET_FW_VERSION_CMD 0x2
>   
> +#define MKHI_GROUP_ID_GFX              0x30
> +#define MKHI_GFX_RESET_WARN_CMD_REQ    0x0
> +#define MKHI_GFX_MEMORY_READY_CMD_REQ  0x1
> +
> +/* Allow transition to PXP mode without approval */
> +#define MKHI_GFX_MEM_READY_PXP_ALLOWED  0x1
> +
>   struct mkhi_rule_id {
>   	__le16 rule_type;
>   	u8 feature_id;
> @@ -40,4 +47,9 @@ struct mkhi_msg {
>   	u8 data[];
>   } __packed;
>   
> +struct mkhi_gfx_mem_ready {
> +	struct mkhi_msg_hdr hdr;
> +	u32    flags;
> +} __packed;
> +
>   #endif /* _MEI_MKHI_H_ */

