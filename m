Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846484D3E0C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiCJAZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbiCJAZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:25:26 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA129E38AF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646871866; x=1678407866;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wsrK9GYCVwtlOcuu4xWvWwfiFFLyTDWXHf83gnlrajc=;
  b=INLYWjIhF+l4bZRCFzyFw67W4EZDZSQRWE0fNHvnBgZty8QieMFLW2P6
   FtXFyKR1b87qGL06pIW2RkqdgOYefz/Z+4RSfDEJgSCdQLz1wtVbUtulh
   Ug9zUS1rFY0zHH5h+gRDeSjgI69+iJyRYtbr3T4kehYDYu1dZyIiIKW41
   hd8OmfOtmTij/1XIbb+8wfzdq4UqkzupIeM/qLq8OoGT/EHDM8iOE1h91
   Iv2INEyp+LuOq795+OQLQW5sdwqjTQiIFPucYrAfqIjMvEoq1eCsNqlTL
   OLGOvUfkDTZl0k399kphP46FKMZN8/6CsXNwL9B2Uj2octCPuBkv0BmM3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="252691805"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="252691805"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:24:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="578595369"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga001.jf.intel.com with ESMTP; 09 Mar 2022 16:24:07 -0800
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 16:24:06 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 16:24:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 16:24:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFxZvE/nsoK6dwzm4Hxg487T+4vlMXJ094zwIdTlBa0JG5BzImV04B3rhXnamj/8xagcgiRQnN/IbM2VIAxkIugNxmkrs0SwY2fmO2RdjLslDrRNUYBBT7hiyfMO0cfdrYrp4B7IO97kcZ9a3/OfO+kIzFgqBRpiv+5z1tQGvZTIvPcByfsMhUXSBJRBdErjozFaH4S/zSzr3toD1lsBqLr0mwEA6zjV9vwCUf/+Wq1uR3ZDGt3QD/JFi5RvFstKITfgU16eQIOGKRJwd1APLMZwxjyFr8Bmvt/vqxQyxKFviYJzMLqQKUhKk2bDFbmyONyY0SpHQN0ndQeZyjmXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0nZdv9BaldH2CD/LmdP9Jv18J0w84pMDWkpjOn0+3I=;
 b=j3wpEzkC8TLpAy6+GO/k5noPtBTXGfp34fihrm1I+IoLC/CRqK3xml1sGMIIh55VfYGVJTsq6Gldd/QB5oc/6IW3EsIUws7eaK2NQqFaTCivh3SGANLvwRXikxj9noXNt1LZ3LRGMsVnSGm6f58WIJIuCUVLY33oyMQpMrOhW3PLMoo4mlmCVc4wE17rs10fdWU0vFLrr055To2WhWCwy6Q1T567fmleu/qEWIXFrC0qCUP8iKTsrflNlZgbAHopmzSeTmMCMFMvQPfk0kijBy3MPl/OiQYYp7Bc+l4Q4Gv+L0vi7if0cC1nHf4hopU/unaF6QfCBc6gsS4NfnE4kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 BYAPR11MB3176.namprd11.prod.outlook.com (2603:10b6:a03:1c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.19; Thu, 10 Mar 2022 00:24:03 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::3c4e:eb25:76ff:a869%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 00:24:03 +0000
Message-ID: <4e722cac-bc1f-41f7-878c-2ee5d9f6b5d6@intel.com>
Date:   Wed, 9 Mar 2022 16:24:00 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [Intel-gfx] [PATCH v10 2/5] mei: add support for graphics system
 controller (gsc) devices
Content-Language: en-US
To:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
CC:     <linux-kernel@vger.kernel.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        <intel-gfx@lists.freedesktop.org>
References: <20220308163654.942820-1-alexander.usyskin@intel.com>
 <20220308163654.942820-3-alexander.usyskin@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220308163654.942820-3-alexander.usyskin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0PR07CA0028.namprd07.prod.outlook.com
 (2603:10b6:510:5::33) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25903769-b734-47a9-7a7c-08da022c47e6
X-MS-TrafficTypeDiagnostic: BYAPR11MB3176:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BYAPR11MB3176650A95ABB8405EE332ECF40B9@BYAPR11MB3176.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gGr4D4inOUQWCJbRlFvS53ja1bsEANflRwPJio75TP2f/pE75fKQzcCrqIc19tCr1YFiciYsWUxhyBjGF69G1VqOGAuco1m/0NVKttLXaS5Vv94vCaXdj2gncv0A2xXlhXiccL/1MNHvdIiLhiPOpsq5lX9e58BZrFT7nos4y3JeqTgnVpCBnqQs5ZRvPYVrx/Y69lRcKa2/aFjGjpd7cBsZgYiK6OT+x60OZ5tcz9tg1yhGFUw/lFtVddlGcBNhrPbP+9eWxMx/n8bTd3U5UaQ1mypodN6CWSfwbT++vxSp0b6skBNTDvNMoU8ZS7ub0DTZMDdtrhYprNlnMQSPw/DQXtjOArvTdRdbT5+uJ0Clc75OfXs3m/3Mu+wSR48Nx/3eWI74qtWPVZJt/pqGEjYwfBBCQws2srvercc0CLO3kANoNeZKE63XZjhniBHv5lFbqGX61knkvUFM5lvj+f0+GCA1QRpe5rdmJCGhHwYwamJGquor4kF5cPH1oF7CNXYEvVubsmNZh7mVMQmko9ZGcwakbpLtbVsflGI2sglm5bnaWp8Uo8/p76QfOWHkT8fJI7nGR9DlssCZrFqQQ3D6gPXi8/LTjcT1kfrX65tYUIAGrPmfPCh0KUa9Xu+/Uz0fueaZ3PQBBI3IcMDiBEzBOvx7G/PefLe8vof55tPgnGOgTeG8J2AcDGAR7S/0PXXsw2j7l0NdggOIsTYmp9RDBwnCHNhVPEhX99q6h7LJ3fTxTHoaNDuyoz0D++/k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2906002)(86362001)(31686004)(82960400001)(83380400001)(66556008)(8676002)(66946007)(66476007)(4326008)(5660300002)(110136005)(54906003)(316002)(26005)(2616005)(186003)(6486002)(508600001)(38100700002)(30864003)(8936002)(31696002)(6506007)(6512007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlDOFp1WU5QeHlQT29SVXV2c1hCNkhjWlNnQ0RuSld1UzRzUk5jVGMycnY1?=
 =?utf-8?B?VWgyaHk5NWR1MzYzS05JenhOMThwMnhXVjNrZVVDcEdlaUZGdVFNZG9QOG93?=
 =?utf-8?B?T0Z1TS9JbzRaV1p5NTlpQTdGcURkaE4rUjVtRWFNdURjelFPZkk0QTdvbDN3?=
 =?utf-8?B?ZERZMmhjVXVENGtBMXByenNTSXZOWURheWpYT2Y0dWNVM2cvV000N0lROHZ0?=
 =?utf-8?B?ZkdsclZvcURIdG9qTWVqelpZcGw3MXhEc0huQTNMOWxxbS9LblFnaGtHNlho?=
 =?utf-8?B?UGgwbVI4Ti8xQVQxQWhxOTliZ2VHTVZlY3lsLzBwV21XVnJ0Wi9ueHRZbGd0?=
 =?utf-8?B?bzFMOUpRdVlKd2JTUGFmbnJxNnZwWDJ5S1dmUG1UUTRCeWdJRFRybGtteGtY?=
 =?utf-8?B?UmViQXJhWTBnZjRkd1VYeUlLOGIwMlQwRDZIMm1TemM2UnI0RHFVRnZNaUN4?=
 =?utf-8?B?NDRybjR6WUVUOC8xWFVaWWFSTmx6SmJhQTlmYk9qd0xtZW9TTkZNc2xObnRH?=
 =?utf-8?B?TmFDZmFwNGtmM3FsYkJUWWJMT2FpOUJBc1dNOGQxbElIUytaRzZ5bWlpNHdG?=
 =?utf-8?B?T0ZaeitkZnhLUC9NaXo4S2ZQOFpGU3RTeDE2T2xTeWlpQmZ3cW5LME15M1dY?=
 =?utf-8?B?UEJyUkd0YzZmLzFnUlBFVTJLRERuZlZDY1pudEphdFZQR3pwZEp1NEhRVjda?=
 =?utf-8?B?OEplemF2cklCTmo1NUVKV0xQbnMzelJIQkVxTXkxTHpoTzMwNW9GNVkraXF0?=
 =?utf-8?B?VnE2NHFpclovOVd4ZU5BOU9yTG1Mc1M0aEcxK1cxMXZKVEhyWmptQTkzMVBt?=
 =?utf-8?B?NzMybnBZeWt3eUpsaERDKzBLaThhU1BMLzk0WmRSWkliVUs5YldXcWttVlVT?=
 =?utf-8?B?VE0yemJ3Zzc1RlBPS1duUVFDdmVzc09FSngvSzUwaWF4TnpiM1ZXaWF6ZjEx?=
 =?utf-8?B?OEpjbzA5Mmt5QmNpaW1Ra0U0UkJ6WlpnVWc4R0Q0L1A5cGZhU1d4bVVUTDcz?=
 =?utf-8?B?U2xFUTVsVUlGdU92eFJTRS8xcnFqckpuNXhZT3RhOFFYUWowdlQ5WHFwaisx?=
 =?utf-8?B?L2xid1JyUFp5bjE5VllsSzgxWS96RG9obGtEM3NpanEwRVpvT1R4QklLZU96?=
 =?utf-8?B?TUVxWXVFUGd5M1Vlc3VUVFpTYXVMVFlJVm9kYmF3em1qUGI4QjRrQkxEQXBY?=
 =?utf-8?B?aTArekhtY0w0bm9kZk54SGcyeHE5RldHbDROZmJDL1ZNQVloODkweXFjMVVN?=
 =?utf-8?B?STN6emR2cktJdE9PcG9SVTk0ZTY4S3UvQmV3dFZiOXlnYTkvd2JBZHBGeVMz?=
 =?utf-8?B?cmJNQlNteGZSSFR0RitFQ3AxMW5xakROSlRISmZkLzA5NWZqOFZuaWpyQUFx?=
 =?utf-8?B?RDBEMEZ6ZnpLbG5uS1E1MFFIQ1A3dUFEcGoxZ1RPdjkyaktndmliRHFaTGow?=
 =?utf-8?B?eFM1T0QwYkl3U3llNWU5ZGVKR0dUbUZBWG45S0FML2JGOXpWQk9LZWtUeXNW?=
 =?utf-8?B?L1c4V1hmMU1NeFdBZmJOemJROGlvZFJrTklRd0FtM2dSUk9oQVN5SlRPNkZI?=
 =?utf-8?B?a2FNWkdnc1QwUHc2WmtSaGo4OC9xQkJEOG8xWnJ1SjBvU2ttZmN1ZHE4ZTgy?=
 =?utf-8?B?a3VxK3JEZEtiS2EwaUdNcXUzUGtSWjR4eTBHa1kwRENsYnd2MkQzWGRQeHhy?=
 =?utf-8?B?QUU0QVA4dzd5ZlM5cHVlUmdMdlNibFBQM2kyYVZPbmFFY0pGSTVwYmJlVjRr?=
 =?utf-8?B?TVpNckJVWGJudzBhdDFVVVFReCtlTkJXS295Y0pXWlg2T2pBczh0NkUzRHhu?=
 =?utf-8?B?YkdRVjFFdGlobm9rNVFMRDZjT1MzNmRIcmRJdXhFcm1CSnZzb2tFWHR0bzBt?=
 =?utf-8?B?a1l5ZUI2di83NTlqblJJYWRrVlVsK1llTURmbEQzYU5ma0Y4c0c4WUJNSlhH?=
 =?utf-8?B?SWRxN3lRUEw2NUc2anlVRlJnOFFPYURFYytGbFJFZzl0R3JzcjBRaUFOa1RL?=
 =?utf-8?B?LzltYnFMZm1WNk1kRDNHTHVFM1BEblltSVg3UTBkenhoa2VrUzFIOFMyNld0?=
 =?utf-8?B?MUxYbTU4cEhYRUsxWHh1bGhmelQvL0tFYzNlUWZzWTVjQ1pVb0xYZUtyZHlN?=
 =?utf-8?B?SE9WcFVLYTFOd2pTaGR2TlNJdjNNVVp5dWN0TFphYjgxRnYrWXRGUGdmbEN1?=
 =?utf-8?B?enAyUlJWbFE3T2w3RkFlZ1UxNUZmOXVZbXdmTmFxZ3doZnBPdFdJMGRsWTND?=
 =?utf-8?B?a24yL0tyZlc1a0hQbFQ2RVlqb1hnPT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 25903769-b734-47a9-7a7c-08da022c47e6
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 00:24:03.5856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZR7Ka9HGOYHd/VMtbl5YvvonnpR5u22Iom0MP8Yh6JKj13LZJcEKwyQMYNKjUKQoPlCh/N7+DqNerW+alwA3loJOplU7A2j/5MW+qZXtHU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3176
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/8/2022 8:36 AM, Alexander Usyskin wrote:
> From: Tomas Winkler <tomas.winkler@intel.com>
>
> GSC is a graphics system controller, based on CSE, it provides
> a chassis controller for graphics discrete cards, as well as it
> supports media protection on selected devices.
>
> mei_gsc binds to a auxiliary devices exposed by Intel discrete
> driver i915.
>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>   drivers/misc/mei/Kconfig  |  14 +++
>   drivers/misc/mei/Makefile |   3 +
>   drivers/misc/mei/gsc-me.c | 186 ++++++++++++++++++++++++++++++++++++++
>   drivers/misc/mei/hw-me.c  |  27 +++++-
>   drivers/misc/mei/hw-me.h  |   2 +
>   5 files changed, 230 insertions(+), 2 deletions(-)
>   create mode 100644 drivers/misc/mei/gsc-me.c
>
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
> index 0e0bcd0da852..d21486d69df2 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -46,6 +46,20 @@ config INTEL_MEI_TXE
>   	  Supported SoCs:
>   	  Intel Bay Trail
>   
> +config INTEL_MEI_GSC

On platforms with a GSC, INTEL_MEI_PXP depends on INTEL_MEI_GSC. Are you 
planning to add that dependency once the HECI1/PXP interface is exposed, 
or are you expecting i915 to check for both?

> +	tristate "Intel MEI GSC embedded device"
> +	depends on INTEL_MEI
> +	depends on INTEL_MEI_ME
> +	depends on X86 && PCI
> +	depends on DRM_I915
> +	help
> +	  Intel auxiliary driver for GSC devices embedded in Intel graphics devices.
> +
> +	  An MEI device here called GSC can be embedded in an
> +	  Intel graphics devices, to support a range of chassis
> +	  tasks such as graphics card firmware update and security
> +	  tasks.
> +
>   source "drivers/misc/mei/hdcp/Kconfig"
>   source "drivers/misc/mei/pxp/Kconfig"
>   
> diff --git a/drivers/misc/mei/Makefile b/drivers/misc/mei/Makefile
> index d8e5165917f2..fb740d754900 100644
> --- a/drivers/misc/mei/Makefile
> +++ b/drivers/misc/mei/Makefile
> @@ -18,6 +18,9 @@ obj-$(CONFIG_INTEL_MEI_ME) += mei-me.o
>   mei-me-objs := pci-me.o
>   mei-me-objs += hw-me.o
>   
> +obj-$(CONFIG_INTEL_MEI_GSC) += mei-gsc.o
> +mei-gsc-objs := gsc-me.o
> +
>   obj-$(CONFIG_INTEL_MEI_TXE) += mei-txe.o
>   mei-txe-objs := pci-txe.o
>   mei-txe-objs += hw-txe.o
> diff --git a/drivers/misc/mei/gsc-me.c b/drivers/misc/mei/gsc-me.c
> new file mode 100644
> index 000000000000..0afae70e0609
> --- /dev/null
> +++ b/drivers/misc/mei/gsc-me.c
> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright(c) 2019-2022, Intel Corporation. All rights reserved.
> + *
> + * Intel Management Engine Interface (Intel MEI) Linux driver
> + */
> +
> +#include <linux/module.h>
> +#include <linux/mei_aux.h>
> +#include <linux/device.h>
> +#include <linux/irqreturn.h>
> +#include <linux/jiffies.h>
> +#include <linux/ktime.h>
> +#include <linux/delay.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "mei_dev.h"
> +#include "hw-me.h"
> +#include "hw-me-regs.h"
> +
> +#include "mei-trace.h"
> +
> +#define MEI_GSC_RPM_TIMEOUT 500

MEI_ME_RPM_TIMEOUT already exists in hw-me.h with the same value. If 
you're not expecting them to diverge, we could just re-use the existing 
one. Not a blocker.

> +
> +static int mei_gsc_read_hfs(const struct mei_device *dev, int where, u32 *val)
> +{
> +	struct mei_me_hw *hw = to_me_hw(dev);
> +
> +	*val = ioread32(hw->mem_addr + where + 0xC00);
> +
> +	return 0;
> +}
> +
> +static int mei_gsc_probe(struct auxiliary_device *aux_dev,
> +			 const struct auxiliary_device_id *aux_dev_id)
> +{
> +	struct mei_aux_device *adev = auxiliary_dev_to_mei_aux_dev(aux_dev);
> +	struct mei_device *dev;

might be worth renaming this variable to mei_dev, to avoid confusion 
with "device" below. Not a blocker.

> +	struct mei_me_hw *hw;
> +	struct device *device;
> +	const struct mei_cfg *cfg;
> +	int ret;
> +
> +	cfg = mei_me_get_cfg(aux_dev_id->driver_data);
> +	if (!cfg)
> +		return -ENODEV;
> +
> +	device = &aux_dev->dev;
> +
> +	dev = mei_me_dev_init(device, cfg);
> +	if (IS_ERR(dev)) {
> +		ret = PTR_ERR(dev);
> +		goto err;
> +	}
> +
> +	hw = to_me_hw(dev);
> +	hw->mem_addr = devm_ioremap_resource(device, &adev->bar);
> +	if (IS_ERR(hw->mem_addr)) {
> +		dev_err(device, "mmio not mapped\n");
> +		ret = PTR_ERR(hw->mem_addr);
> +		goto err;
> +	}
> +
> +	hw->irq = adev->irq;
> +	hw->read_fws = mei_gsc_read_hfs;
> +
> +	dev_set_drvdata(&aux_dev->dev, dev);

you have a device = &aux_dev->dev earlier, so you can just use device here.

> +
> +	ret = devm_request_threaded_irq(device, hw->irq,
> +					mei_me_irq_quick_handler,
> +					mei_me_irq_thread_handler,
> +					IRQF_ONESHOT, KBUILD_MODNAME, dev);

If I'm understanding this correctly, you're tying the irq to the device 
allocated by i915, so if the probe fails below or the mei_gsc module is 
unloaded the irq is going to stick around. Probably better to clean it 
up explicitly, in case we get a spurious interrupt from the HW and i915 
propagates it (although that's a very unlikely scenario).

> +	if (ret) {
> +		dev_err(device, "irq register failed %d\n", ret);
> +		goto err;
> +	}
> +
> +	pm_runtime_get_noresume(device);
> +	pm_runtime_set_active(device);
> +	pm_runtime_enable(device);
> +
> +	if (mei_start(dev)) {
> +		dev_err(device, "init hw failure.\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	pm_runtime_set_autosuspend_delay(device, MEI_GSC_RPM_TIMEOUT);
> +	pm_runtime_use_autosuspend(device);
> +
> +	ret = mei_register(dev, device);
> +	if (ret)
> +		goto register_err;
> +
> +	pm_runtime_put_noidle(device);
> +	return 0;
> +
> +register_err:
> +	mei_stop(dev);
> +
> +err:
> +	dev_err(device, "probe failed: %d\n", ret);
> +	dev_set_drvdata(&aux_dev->dev, NULL);

can use device here as well instead of &aux_dev->dev

> +	return ret;
> +}
> +
> +static void mei_gsc_remove(struct auxiliary_device *aux_dev)
> +{
> +	struct mei_device *dev;
> +
> +	dev = dev_get_drvdata(&aux_dev->dev);
> +	if (!dev)
> +		return;
> +
> +	mei_stop(dev);
> +
> +	mei_deregister(dev);
> +
> +	pm_runtime_disable(&aux_dev->dev);
> +}
> +
> +static int __maybe_unused mei_gsc_pm_suspend(struct device *device)
> +{
> +	struct mei_device *dev = dev_get_drvdata(device);
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	mei_stop(dev);
> +
> +	mei_disable_interrupts(dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused mei_gsc_pm_resume(struct device *device)
> +{
> +	struct mei_device *dev = dev_get_drvdata(device);
> +	int err;
> +
> +	if (!dev)
> +		return -ENODEV;
> +
> +	err = mei_restart(dev);

Might be worth adding a comment to explain that the interrupts are 
enabled by the mei_restart and that's why we don't have a 
mei_interrupts_enable call to match the disable we have in the suspend.

Daniele

> +	if (err)
> +		return err;
> +
> +	/* Start timer if stopped in suspend */
> +	schedule_delayed_work(&dev->timer_work, HZ);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mei_gsc_pm_ops, mei_gsc_pm_suspend, mei_gsc_pm_resume);
> +
> +static const struct auxiliary_device_id mei_gsc_id_table[] = {
> +	{
> +		.name = "i915.mei-gsc",
> +		.driver_data = MEI_ME_GSC_CFG,
> +
> +	},
> +	{
> +		.name = "i915.mei-gscfi",
> +		.driver_data = MEI_ME_GSCFI_CFG,
> +	},
> +	{
> +		/* sentinel */
> +	}
> +};
> +MODULE_DEVICE_TABLE(auxiliary, mei_gsc_id_table);
> +
> +static struct auxiliary_driver mei_gsc_driver = {
> +	.probe	= mei_gsc_probe,
> +	.remove = mei_gsc_remove,
> +	.driver = {
> +		/* auxiliary_driver_register() sets .name to be the modname */
> +		.pm = &mei_gsc_pm_ops,
> +	},
> +	.id_table = mei_gsc_id_table
> +};
> +module_auxiliary_driver(mei_gsc_driver);
> +
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_ALIAS("auxiliary:i915.mei-gsc");
> +MODULE_ALIAS("auxiliary:i915.mei-gscfi");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/misc/mei/hw-me.c b/drivers/misc/mei/hw-me.c
> index d3a6c0728645..9748d14849a1 100644
> --- a/drivers/misc/mei/hw-me.c
> +++ b/drivers/misc/mei/hw-me.c
> @@ -1226,6 +1226,7 @@ irqreturn_t mei_me_irq_quick_handler(int irq, void *dev_id)
>   	me_intr_disable(dev, hcsr);
>   	return IRQ_WAKE_THREAD;
>   }
> +EXPORT_SYMBOL_GPL(mei_me_irq_quick_handler);
>   
>   /**
>    * mei_me_irq_thread_handler - function called after ISR to handle the interrupt
> @@ -1320,6 +1321,7 @@ irqreturn_t mei_me_irq_thread_handler(int irq, void *dev_id)
>   	mutex_unlock(&dev->device_lock);
>   	return IRQ_HANDLED;
>   }
> +EXPORT_SYMBOL_GPL(mei_me_irq_thread_handler);
>   
>   static const struct mei_hw_ops mei_me_hw_ops = {
>   
> @@ -1433,6 +1435,12 @@ static bool mei_me_fw_type_sps(const struct pci_dev *pdev)
>   #define MEI_CFG_KIND_ITOUCH                     \
>   	.kind = "itouch"
>   
> +#define MEI_CFG_TYPE_GSC                        \
> +	.kind = "gsc"
> +
> +#define MEI_CFG_TYPE_GSCFI                      \
> +	.kind = "gscfi"
> +
>   #define MEI_CFG_FW_SPS                          \
>   	.quirk_probe = mei_me_fw_type_sps
>   
> @@ -1565,6 +1573,18 @@ static const struct mei_cfg mei_me_pch15_sps_cfg = {
>   	MEI_CFG_FW_SPS,
>   };
>   
> +/* Graphics System Controller */
> +static const struct mei_cfg mei_me_gsc_cfg = {
> +	MEI_CFG_TYPE_GSC,
> +	MEI_CFG_PCH8_HFS,
> +};
> +
> +/* Graphics System Controller Firmware Interface */
> +static const struct mei_cfg mei_me_gscfi_cfg = {
> +	MEI_CFG_TYPE_GSCFI,
> +	MEI_CFG_PCH8_HFS,
> +};
> +
>   /*
>    * mei_cfg_list - A list of platform platform specific configurations.
>    * Note: has to be synchronized with  enum mei_cfg_idx.
> @@ -1585,6 +1605,8 @@ static const struct mei_cfg *const mei_cfg_list[] = {
>   	[MEI_ME_PCH12_SPS_ITOUCH_CFG] = &mei_me_pch12_itouch_sps_cfg,
>   	[MEI_ME_PCH15_CFG] = &mei_me_pch15_cfg,
>   	[MEI_ME_PCH15_SPS_CFG] = &mei_me_pch15_sps_cfg,
> +	[MEI_ME_GSC_CFG] = &mei_me_gsc_cfg,
> +	[MEI_ME_GSCFI_CFG] = &mei_me_gscfi_cfg,
>   };
>   
>   const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
> @@ -1595,7 +1617,8 @@ const struct mei_cfg *mei_me_get_cfg(kernel_ulong_t idx)
>   		return NULL;
>   
>   	return mei_cfg_list[idx];
> -};
> +}
> +EXPORT_SYMBOL_GPL(mei_me_get_cfg);
>   
>   /**
>    * mei_me_dev_init - allocates and initializes the mei device structure
> @@ -1630,4 +1653,4 @@ struct mei_device *mei_me_dev_init(struct device *parent,
>   
>   	return dev;
>   }
> -
> +EXPORT_SYMBOL_GPL(mei_me_dev_init);
> diff --git a/drivers/misc/mei/hw-me.h b/drivers/misc/mei/hw-me.h
> index 00a7132ac7a2..a071c645e905 100644
> --- a/drivers/misc/mei/hw-me.h
> +++ b/drivers/misc/mei/hw-me.h
> @@ -112,6 +112,8 @@ enum mei_cfg_idx {
>   	MEI_ME_PCH12_SPS_ITOUCH_CFG,
>   	MEI_ME_PCH15_CFG,
>   	MEI_ME_PCH15_SPS_CFG,
> +	MEI_ME_GSC_CFG,
> +	MEI_ME_GSCFI_CFG,
>   	MEI_ME_NUM_CFG,
>   };
>   

