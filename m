Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A775A9BB9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234643AbiIAPbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234282AbiIAPaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:30:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F98459BC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662046244; x=1693582244;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gjy97YchO0MbvvMmA8r5ZK6q8Ieam6EQSqDLVxkVfdw=;
  b=Met2wbZfaSQEPt0oMhpI4V552CVKtZCvnAxloo4eamVBu5YiKA6r1+bz
   +u8nACyzlhlHDW6ZORKmZ65JN2ch7xqANWcVw5eOhfzM81h13QFMLzpVK
   M31g1rQbwZJ6tfhQSeh8zXChjJhw6BvGrNTAPja/V6UR/17Q3v/Zs4Vif
   I3+wkq2JRS7qIK0wI8hARLTVZHMxeW2MncCxR+aevzKqdm6cWLGkz49jn
   /7eO536CBeptf2maIxyz/kwsT9Yf3inAx4T6wnzJ9LlJ9kOuAITTFFtAn
   DH2XPwB4TJVDzpZ+u/8wp3LjeDcIcBAx3P2eJfyI7BmnyC7+Hk1RHQDY2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="282727998"
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="282727998"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 08:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,281,1654585200"; 
   d="scan'208";a="608588396"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 01 Sep 2022 08:30:43 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 1 Sep 2022 08:30:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 1 Sep 2022 08:30:43 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 1 Sep 2022 08:30:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IZZ4hUMzXYUbzv6LxefaB+MN9dy3KqD825fC97F4vfcVXxyRfY1lHYIpoJQ6Fi+cQ7PJYLwfJq1RFXce+JIIvKCNON6tYqQ4XiKJ0IYVY70P6InJsmbQAOSxmBz+qj+P85kzOFlul/XL4oibfXoZ/oilNmzAEVfT+zt6nKFDi4mHW6Q1tDFq8ocPi9Ykabv2jc50I13eLr30w0BRFWQj+MQvBumwle6nxxTxuhTdKLTnXV5PA3Jr/P1qy6m8+Ptt9v0S2sP4HQ1LUbqePodrZelZjoBJsOpVdNZKfLyJwbLTPy06Yrs6ReWvYjui+tvhD/Mt0ACCXW2IBpKJiSU66g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=elPm+x64Mfaoe4MwgzNLsU2MpaQbd0KcDTIxWFITFxU=;
 b=e83kXStHpyDoSVWeuSaJi5H2lhzJ6i/D1CyqTcqQH7ZKG0Sesn1KmEEywj+wTAMRhEpl50kmWQKQgfF0OA/2EIdOJ4I+hlLkl6DpFymoLmD3pOTPfoOz5e5zYAKfHkKlV4AVYHQZxhe/ptihKO2JyaCqPdgMYpVxctDo3Po9SP3kbI8FdwWpSLrshujlzaMUWlOHSn3hkWn1pzOrT87ODoJHcI4PlVwR0NdXl4Y4ZeY5DLK+sdOa6KqUTFIE6r979641JJRMtQtovlGbTg86PxUCfwtqLTFOVktQ5WnmgWlqXyu0w+0AxQeteC9eQ42pzzOZfYRzayy/de9l49dPgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB5488.namprd11.prod.outlook.com (2603:10b6:5:39d::5) by
 DM5PR1101MB2156.namprd11.prod.outlook.com (2603:10b6:4:51::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.19; Thu, 1 Sep 2022 15:30:41 +0000
Received: from DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1]) by DM4PR11MB5488.namprd11.prod.outlook.com
 ([fe80::1977:59e7:5a28:24e1%9]) with mapi id 15.20.5588.012; Thu, 1 Sep 2022
 15:30:41 +0000
Message-ID: <08097517-6547-a275-345d-b95cce7cd743@intel.com>
Date:   Thu, 1 Sep 2022 08:30:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [Intel-gfx] [PATCH v7 02/15] mei: add kdoc for struct
 mei_aux_device
Content-Language: en-US
To:     Tomas Winkler <tomas.winkler@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
CC:     <intel-gfx@lists.freedesktop.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        <linux-kernel@vger.kernel.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>
References: <20220806122636.43068-1-tomas.winkler@intel.com>
 <20220806122636.43068-3-tomas.winkler@intel.com>
From:   "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <20220806122636.43068-3-tomas.winkler@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0140.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::25) To DM4PR11MB5488.namprd11.prod.outlook.com
 (2603:10b6:5:39d::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0613a3df-9ece-4d43-37b0-08da8c2eed87
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2156:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: INxPXSMo1TrsbCKFaiTZmX256dMrYo8r/xmlV4teOE1wB63Z6/wttY3rSlc58SJAxIViMgATHP7rYSxmDfxxEmKWwB+w6ZGKR6ryEdrfikEiWgEOdhPxDvvzyZPvYy9jHH5v8l3YFMiSGJmotSQ4Trcg6FpsYvu5vN7pLL12cIjFcJc/mZdzHsjL+cUypr2otOYgXoWtZMAt7OCDVThisMAUnmEisURE4hVyIx7J7zR3nJvZ+A7jYnDzQh0A+nmGb67epAztrH441iQP0nhaNBVIHJPzav72b3urXfXbezFOTpgZkHzJAPjMcoNJ81jpyRSeISPl6FAzbgeDHHL4Yu2NdCUEaP3lFe+UwZ2/Gv9xiJ8yg2yeMKQqFfJzSE+tLsdQlC4jqQGZdDwAXAS5KJOUFXzB1NzxYBHAZjjJLPUK88pAEoqnNWvWrwfTetpJLAqHkPbz5vRDIgBeF8WOISXlv7LoGMwvOiT/Xv276hSdJB/VITRftuOoEuK8EkSA/FKRp07rf/49kv/04hyrOFUtqQ1eVttahc7OGPkL4dFfGyRf7mVFEvLbY6s8mG3HFaGo3Qntzst/GGeYqNnrT95oqsyimazDocWH4FGc+GOV87JgKJ5cs5HXMsq74Kq/KH7FhzQDwmTcl2qhcRLKBSr2bXHkFtFYmRTVDCKueKPimTC3bGzNd8W+R3gzVZ+/cCHWCAqb3SXxQ4N3PXIVet57GFsxX8RQ9aPPyFIGjreVzppaFaFG9Lp/RQrR67/WbzWCwTe0oYPeanoMEtGm2iv8b0KPo//Akn8NVBNvi2c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5488.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(346002)(396003)(316002)(31686004)(186003)(54906003)(66946007)(31696002)(66556008)(110136005)(4326008)(66476007)(6486002)(82960400001)(478600001)(5660300002)(86362001)(41300700001)(8936002)(36756003)(53546011)(107886003)(2616005)(26005)(6666004)(38100700002)(8676002)(2906002)(6506007)(6512007)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnhPUzEvaHFkTFlmTlBoQXJkbjRxZ0h4NWxLMFlydXdxME1US0xOMDNTTTAw?=
 =?utf-8?B?bmRpTTZFQkQzTFQ0VnlOa1ZTVmo3S01LdUQ1ZmE1eGo5OFJIWFZtcWMvZDEz?=
 =?utf-8?B?YytlRFNYUGtaVWFabGdwa2FpaDF5bU4wSUp5ZXZleTFjZklwK1RaaUduTHln?=
 =?utf-8?B?N0MvU0NhelVVWHdPeFZWMVRGOFdWZ2J6VzdKVUNSeUxQOCtPdFlkRTVQYzcw?=
 =?utf-8?B?NWRCYzE4endYMjhSWEtSTStDUWMyRS9ZNG1YT3h2OTZkRXJMNlcvL0R0T3pO?=
 =?utf-8?B?eE9Sbi83MVc5WGNWSlo5blJoeEVPY1o4QzgvMmdWa2dXYmlKY0RYY1RtcTdu?=
 =?utf-8?B?TENDVVpSbnZxRUt0czlIREI0YmY0cnRDSmdkamowc3VPdDdtYWlFaGpVNUIw?=
 =?utf-8?B?eWdhQzVySWJOUDVBcXhsdWZBSlRnSTVNcWlwWDZJRW5GMHo0Z1hDODV4SGlT?=
 =?utf-8?B?Y29wSUVKOStETjJ2QUNoNEZoVHNkRGdCY1haYk90OTNIa2hJcnZyVmo0dDNU?=
 =?utf-8?B?L2U1LzNoOGdlcjNiRkROOE5PbXMyWmhvUkdWRllKN0hBVFk5Z2E1cFQvdnlv?=
 =?utf-8?B?dXJ4dEZqQUtmdjl0YURaK1huMHdmUHpsZDlpYzlDWkFraElKU3lVdTQ0WVFX?=
 =?utf-8?B?WWg5MVNqc0VocWxySFNMUWlnNkxMNjRUNlpNSHZEM0lqV1Q1a2pWQkRXOEJQ?=
 =?utf-8?B?ODNhWHhwM0t0dnVVZVdDUjhCbmh2c2Nka3lrdklTd1NMVThtSmZQY2Q1dm10?=
 =?utf-8?B?MGJqc0U3a25hVXYrUW5wWkNKd1ZMK2hrUnp2Z05idDVSanhvQ083M1VmczRZ?=
 =?utf-8?B?QVd1RjY5WlNxMU1KTkhjVG9qdjgvZVJmS3h5QjVJWUVld1hXWGFRU2pFTWhG?=
 =?utf-8?B?TjNuNll4NzIyRHhDYlpjZ1hHbXJHdEM2ZURHaEYwc1NOQUtzSjc0bmgrZEo1?=
 =?utf-8?B?WXVDQ0htbUlYN2VoOTh0RHVrVEpPOGpUMUkxWk9WRFRML0FxTGE4QUhkWkFi?=
 =?utf-8?B?ZVhkRVZaVGRGTFI4aFdaeFlhU1JDbU8va2hDcE9vVGJheFFDN3N6WDR2dlJy?=
 =?utf-8?B?cUloQ3cxS3E4ejU4MVZ5L1lORmRWZHdyZzJvQ3gvQUc3aGZFVGcrMUp1WUxm?=
 =?utf-8?B?dFlSYzB0ZjRmN21DanZzTVN5bmhXUHdGcWVPdmpTczVlMUVwTWNGV0RQVFpt?=
 =?utf-8?B?Qnh5aWZkOHloYnhqblBMQ0RRbmZueGZ2d1pkUFJaTUJKSHJXVURvYU9pemxO?=
 =?utf-8?B?K3Ezc2pYSTY2blJMbVpMb1gvYWlhaTN6TVJKY1NUcmxkbm9nNCtKenJPYkJG?=
 =?utf-8?B?aklPd1FsMUp1dDMrclVlSHV5c2x1V2dJdlByMkU2b3VTc01DTHUyVjNiK1Nk?=
 =?utf-8?B?OGdicHQ5U0ZNb2t1SitNUm5LVXRwcS8zUFczUkNmRXBGdytHSStqdjIxWStB?=
 =?utf-8?B?TDR5cVQ4ZHkvemFNTnFEd2h6WUU0bHlQd3h6cDFpY2tGaE4rOHlJUjU0eTB6?=
 =?utf-8?B?dlVUSWVBeFJwZURza1dPN05uampwMG94N29odVpBcTBGZFJsY0RVUW1pNWdp?=
 =?utf-8?B?bWw2K2UxMGJiS0J0U2NQS002dnVGUTV5ZXNZcWRHZkh4bmh4aFNxeTZ0dWR1?=
 =?utf-8?B?ZC9kSkNPTlh1dmU5S0JSOGtjZVFBb081RzVmMFRVK3FQRTFQL2tkQnRZTkxN?=
 =?utf-8?B?T2d2MFNDdVhTZU9NdVpMSHBsaVlCNTN4cGp1SzhnQkNkT2lHWWtvWmU5U2xB?=
 =?utf-8?B?c2tva0w5SEp2ei9hNmV0bzQvMjNUNjhRQnN3dzh4NXZXY0dFT282empwWWh2?=
 =?utf-8?B?U1JSV1gxdTRHdllxVktXazZ0MkFhNE5uK21oODFNbkdHSUVLNWQvMnJueTVM?=
 =?utf-8?B?ZnR4K2h4dXZLZm9sZmRWTllXdDFUOTc1bzZXN2ppN3BwMWw5bFI4SEJNZG1J?=
 =?utf-8?B?Mk5nS2tVdXB1ajRFTDcrd1ZTa1VCWnhlQ0tSMWx6U2pjeVphMTVnWmJYSTYv?=
 =?utf-8?B?V1d0NXZveTgxaG8wZkQrVDhXbEcrMk1wUVlGYzZuTXhmVXZDU1dSN0NiQUly?=
 =?utf-8?B?WXR5L1FtUDY2L1FyQVpBR0kwaFNsQlc3R2tOWDQxeFZVT29xa0pUaUdINi8y?=
 =?utf-8?B?TmJGUWNQNldNRkhINzREbVVpai9QMXhucDhEU2JpR3dWVzZZbU80azMvRSsv?=
 =?utf-8?B?OUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0613a3df-9ece-4d43-37b0-08da8c2eed87
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5488.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 15:30:41.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V75HT4ByEmSkXgy2yNT/R0fshcXlbxyBghHGEqI+hj2Lkz66BMTFVjGSKyLoQHit4CcWmwwoK14XXyLXKp+KVXix0co1ZH7xh8F1JqmR7Dw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2156
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/6/2022 5:26 AM, Tomas Winkler wrote:
> struct mei_aux_device is an interface structure
> requires proper documenation.
>
> Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>

Reviewed-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>

Daniele

> ---
>   include/linux/mei_aux.h | 6 ++++++
>   1 file changed, 6 insertions(+)
>
> diff --git a/include/linux/mei_aux.h b/include/linux/mei_aux.h
> index 587f25128848..a0cb587006d5 100644
> --- a/include/linux/mei_aux.h
> +++ b/include/linux/mei_aux.h
> @@ -7,6 +7,12 @@
>   
>   #include <linux/auxiliary_bus.h>
>   
> +/**
> + * struct mei_aux_device - mei auxiliary device
> + * @aux_dev: - auxiliary device object
> + * @irq: interrupt driving the mei auxiliary device
> + * @bar: mmio resource bar reserved to mei auxiliary device
> + */
>   struct mei_aux_device {
>   	struct auxiliary_device aux_dev;
>   	int irq;

