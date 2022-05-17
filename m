Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D8E52A7BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350827AbiEQQTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350825AbiEQQTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:19:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAE83A5FC
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652804340; x=1684340340;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IuMkq9Ly0sIgsmHUHF552qOv7ZPO3TrbCViCGgenYmo=;
  b=UF5uMbUV0rRwZ2yatSK8dBYHqK+NZbHu6qJqOl4K9xzuV0drLW8po9i5
   jYLGpC1RPREU2nXeWCB7+djcoFI1YDCJs09Suzved6fD0nAgTXxjeLRA1
   gXTZsrStrRkBj5u90GoPsgjfUYVyu7i71jVrEXu1I1HYRb/TZFztBD9Gv
   d0uUDYUTF3J1PscbgI7ECCgPHtjesDMZ4R921L/5rhI/QOjs/t758S361
   IEjvrqQ6A6z+ZL+I57xviUE6VXF6RtCFjxUC+n4I9wxJCP1BjRVsKzlr0
   9pnOiKBtdZ/6H94NS/8UgWJilhq/4MlSAm9f5DCg49DUUQG7hoYpYuw5B
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="251748967"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="251748967"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 09:19:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="713917615"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 17 May 2022 09:19:00 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 09:18:59 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 17 May 2022 09:18:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 17 May 2022 09:18:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9J5Ckq/A9Cf+TdwbFA1A/Yg1z/sxbSASXFhf28MOBIFZtzxVqPRhUbhjzfmslxfZdipTVrIB9xgTWWzbdvx/M1DrEj1FaIBcfXW7zZZ7+Bkyw74TmFq+SBte4/9EiWFSJ10WUhuG+QDYavOkFdApcbnrGB7Tf+AaULIgQmp+9d4E7SRVOh5pSN0N3gQKA9+UlZ+NzLrR/ieXNLxj6ASyBlHUPY0pJ6UO6ZnX1xmSFcYV6oPIbi7HBzTEJjp0ItuoItlnFeBaHNr3Dx0NaZItN1waml5GuGgqL8wNr8Ca1fAAKdi03RuAB3+95qOTTvXSfqpGulwpy7M9wbHvAh7bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m1xjh66iCQg1wibHuzRqK2vJFSIPApgjqdlMstRv0rw=;
 b=eReBCFVKG+PytXZAEv4sgmF3DBQCvKbNYsPoim87XIA4akGeKuIwkxMUucxw0TmhSEugj2SitxBZA8Skr0XKacTEIFH26fjdiAELORIkxuHdONiaMoMMNQ6J9gs9YQmlAtQr8D41DRAw/o2i2z0U3I+LgcjOQ2tBcRAahfY6VZpWc+woLFf+BDFCaJ0hdFr93cqSvi960TkHK/Jd2ycjNNW0pOI9Mx22+4YkXrnjyNwFYRoo2AWW1+YKjY3+Cv26y4yqKIRcxP9xAL7OsiDd9oL/b2HxLuKHLj/XN79Rmh1lqb5rctvH6vkFdz6eZ1hpCVGoCldSJ1dnBx7lpDQvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5744.namprd11.prod.outlook.com (2603:10b6:408:166::16)
 by CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 16:18:58 +0000
Received: from BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525]) by BN0PR11MB5744.namprd11.prod.outlook.com
 ([fe80::5459:7151:e684:6525%2]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 16:18:58 +0000
Message-ID: <7f1c23cd-486d-9bbd-2bcc-c2db0fa1e5c2@intel.com>
Date:   Tue, 17 May 2022 09:18:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.0
Subject: Re: [PATCH v4 07/21] x86/resctrl: Create mba_sc configuration in the
 rdt_domain
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
        <tan.shaopeng@fujitsu.com>, Jamie Iles <quic_jiles@quicinc.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Xin Hao" <xhao@linux.alibaba.com>, <xingxin.hx@openanolis.org>,
        <baolin.wang@linux.alibaba.com>
References: <20220412124419.30689-1-james.morse@arm.com>
 <20220412124419.30689-8-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20220412124419.30689-8-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::30) To BN0PR11MB5744.namprd11.prod.outlook.com
 (2603:10b6:408:166::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0d24228-43be-4f1f-45db-08da3820f204
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CO1PR11MB478762DF8C8629EF8B5ACFC3F8CE9@CO1PR11MB4787.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 668Sed+14dFhx+k/8X3Uo43JJt+9yq6f3Yzh03lg6sliNPoaC1cXkIwdexjkFQbLA73Shvf6IFu9EbwM8OoRSAwL6DWlTDPtacRf9TvjpE/vR2y9CuIqAvqJ6A4P/m8levOwGVxNJ+UvMZuMnWVnLxeAYAvgIiRvp88qpcZ21TFjciX9hIdH1ZjkEK3IC69yiRuVQiZYUfDENSbFlA3Z85I9fALZdUVDumJM8HvugQxloxNHLKLT7fOfQrjmnPcZoJa6eYJcTMBuGi/cdWjl7HvfTbxQRsO2WxP5QdjMcc/6ZhXtU7Voh10PMWA/HJMLc4Sm82PTKsVvxIWRiS8tjsZtr32G7OKgyaWJwAD59BID6fbLSaNH8Z2/C4ueRZkWRoRbqr5QCx7E1S2mZWjeFpekBWUfQsA58t+4/Wmhs6Gi2rZ184zCB8/Kg1rEvf/yVvcVf6M/WtYh+xxcJT1sepVOu+rCscO64abL4eRlgbafp7M9QiT3xLpHtI69yZQI63KOwuCE14s9AWqlzQcSJHuKg89jfC0jV5DYpTCogttPz/kDnFPEFFK7+vLRXkAfcqnxiT8+oRI9WUHDVpsRGei9S0CEgF6GXLU7SrmcpT0c7IBsrjPEhqkUMIXKt68+qpndJHWy1Gaw6+HgAFu9Ue1106RVXMRbhJuso6bitdOuvW23Tkzzeq4j3fV7nrz2VTGwPfGW9gpbFA08ax3/f63nVRIH1tc6yYyu10SaDMw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(83380400001)(5660300002)(54906003)(66476007)(316002)(66556008)(4326008)(53546011)(8936002)(44832011)(31696002)(86362001)(66946007)(2616005)(6512007)(2906002)(7416002)(6506007)(26005)(6666004)(8676002)(82960400001)(186003)(38100700002)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THZMcGZ1b3cxMEl1c3V1M2NvVVVtcFpFMm81NkFmaWtxM21yK1k5YWFiSExx?=
 =?utf-8?B?Nlp3ZVpjc3VZMVJTbDdXaXBXZExtbmJUWWUySXNweWU5YkhrS20wMklMR2kv?=
 =?utf-8?B?OUp5cnJEdWZtMWNWTGd1NW9HSlVnZzAzOS92Nkxtdng2eHJpVVNWM3J5MHUy?=
 =?utf-8?B?bGE5MmNqK053UDNvYnFsbVVOUDI5Z3N5YXgxSVFIOTlkTHJ1eWl5MWxvSUZC?=
 =?utf-8?B?c3NoU2Z6MFJGSlZmbjJRakk0L08yVEpMU1JYS2xXWUtTRVNKc0hiY29nRVVK?=
 =?utf-8?B?MjdFTUZaYlQxdGd1d3hHcnRtRVdacXFRUjM4UkU0QThLZWN3Y3JISmJFMGhz?=
 =?utf-8?B?N0RnNGVzdUtYaFBRL0d2VHo3Z2FxcFh6UlpqNFFXSGZ3WnRoWHZBNXhmakFO?=
 =?utf-8?B?amE3WmV4NlNsdVJaQUNiT0RuN2t3VWFhRTN1bVNCUUgrd1VoNEFENWloRjIy?=
 =?utf-8?B?M1BPSDV5U1NIcVo4cVVOUjFHZ2w1Y2lpQU5xbWZlZXB6eVYwd0VUUXBoaUcz?=
 =?utf-8?B?UGpYdHVxemgwSURZQlF4RDhCSDhnRGFVWjZNS3o5bzlUYUxld2d3dmV0WnhF?=
 =?utf-8?B?MEQvbmhuU1p0Y0oybFg2bGlTb3ByNlAyR09iM1BrS1hBM1NJZnhVLzIwSkhm?=
 =?utf-8?B?WlBkUXQwQ3FiRk5qaW1XQll0eFZVY21oSXBpdWtzek9leUQ0Q1d1RHNPYlpS?=
 =?utf-8?B?ZnphS25WUWFFeUhYV3FpLzkxM0ZzZGhQZWJLSTRkVEx5VWVtai9mVDFCOHV0?=
 =?utf-8?B?L0hOclY3YWd5VkNGN3FCdzJBWHNJbkY5aFliKzlGUC90YkpQKzhnYUoxWUJw?=
 =?utf-8?B?bHZUVGwwalNwcTVXbDZOZlZuYUw3YUU0ZnoxcDNOd09ISkpSTWRPOTBmZFBa?=
 =?utf-8?B?YmZBYW9yWlpRZitIZlljdUpLOVUvdkp6a293WWljclFrNllEYjBBWHdrc0FT?=
 =?utf-8?B?c3k3bG0yM2lZcUs1VXdWdkhURURzb1kzTlpUUVdtQXozSTdaakl5bDVWU09p?=
 =?utf-8?B?WitWWkZHeDNnblhRYXRwU0tPYUxHeHA0NUFMdFNRZExIOXdUbmw4SWloTWdl?=
 =?utf-8?B?Q0J5eUVNc0ZET3RxQjF3MWRTRS94Sk5ZVW5XMlpwQTlMdERMR3l4MUVSVldv?=
 =?utf-8?B?dlJlK1N1ZWVSSkw5OGx5SHdZN0xmUFJXQzB5YTJCRDJrRENsTU5yNnV2SjRZ?=
 =?utf-8?B?a201VGNXeTVuMDJRaXV3cTZwVnkraEhLZHg5UERkaWZSUjZpcHRFOGJqQ1R1?=
 =?utf-8?B?bHJ4cWtpT0dZcVNiUmNFV1c2OTBzbkhxU3ZqajFna2JTVlhlZldTQTRuc3Jq?=
 =?utf-8?B?N1NzNG81OHA1YWNPWjZZR0czcGpIZENGZ2FEY2tUcy9QaXE0VXFvRERTN2s4?=
 =?utf-8?B?a1VqWXVBakkxVGtFKzBvQmpnME5xNDdTTmh4ODU3TUZxTDIrZzlKT3JsMTE5?=
 =?utf-8?B?Z0RRUXlheHovODlUQWd0VTdpUGxEZnBTWnM1ZFZkVmJPN2Uxd2t3R0Vrc1Iv?=
 =?utf-8?B?aWhZdWJwNUNHR3luZmhveVBoamJXRmUzTGYyZHN5OHo4Vkhsd000bkJqemRa?=
 =?utf-8?B?MlhvS1cvT3RCeUg0ZDhUWWFZZ1FZSG5vN0FEdzBLcEx6VkxZK2lwb2JLOUFp?=
 =?utf-8?B?VVUvMVdrNjdVZnloZ1NSZFZrQnBTQXdSMmJyNjNoZ084TlkxNTNXaTM4bHBt?=
 =?utf-8?B?Yi9MdXQ5UjE3U3RWWkJLak1jK2dzSlQvZ0l2Y3RuWWR5UWlSRm1QdnFha2RT?=
 =?utf-8?B?VmViU01kVTJBVmllRFZPa0lvNjZWejNqTGIxa2NRSklWSjNwR3R6Q3g2aUo0?=
 =?utf-8?B?c1k3WWp4b2F1Zi90TFhvaDFKZ3dETVFoNHdsRkFGNG4xZy9iTUJuVUJOUk4y?=
 =?utf-8?B?TWpaaG95Z2c1dlhYOHJQSU9jYm5IZW9lUXR1K2c5WWRYSmtFTWlnMVNWcm5J?=
 =?utf-8?B?YkRQT1FjOXlNM21wdzZTUDVVM0swRi8wTTBKUVByZGVtalZBdHZmeEVPQnZo?=
 =?utf-8?B?MWlpdko4UW1VS3ZmTW5ZTVJ5QTF5cGE5UDdyNmRhc3FsT3kwZGVmemV2L1Q0?=
 =?utf-8?B?VE1pbjg4L2V3SVZ0YmxEK1ZOMU1OMllNZnJjQ2hWMDN2YXNsNDNUcHh3azhr?=
 =?utf-8?B?ZVhzb3VBMmhSTCtkZHlkbzRYb0NzQSt3bHdQQXJGeHE2bEVRekMzSFI1bEZD?=
 =?utf-8?B?YmdSYUJ3dS91TUZJR0Z1WnIzYnRQbEhEczlmOHBaYlVrTzdJci9LSUVNWkxk?=
 =?utf-8?B?SGE1eFpQa3I3OWUyU0hJMVNhdnV2Ulk1dmpJRGZWS0xidkRtT2l3UHVVUyt3?=
 =?utf-8?B?UWV1MXYwV0JqMHM0RE9pWjdNYmVOZ2dUamxXT2Q4Vlh0a0JhQ2xSeXJzb01a?=
 =?utf-8?Q?OTmfXlBoADV+rOKE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d24228-43be-4f1f-45db-08da3820f204
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 16:18:57.9492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/V0BjrxbmbL+/l7uBa3m9aMIiffr8Hs5kXQIEN9nx3jDYKizukgRPjTNzcEfECluyBte3jECYfc8DC65sa5b1TObuNnDE6TVpzg50IKNGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4787
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 4/12/2022 5:44 AM, James Morse wrote:

...

> @@ -3263,6 +3295,7 @@ void resctrl_offline_domain(struct rdt_resource *r, struct rdt_domain *d)
>  		cancel_delayed_work(&d->cqm_limbo);
>  	}
>  
> +	mba_sc_domain_destroy(r, d);
>  	domain_destroy_mon_state(d);
>  }

It is not clear to me how rdt_domain->mbps_val will be released via the above call.

After patch 3/21 and the hunk below resctrl_online_domain() would look like:

resctrl_online_domain() {
	
	int err;

	lockdep_assert_held(&rdtgroup_mutex);

	if (is_mbm_enabled() && r->rid == RDT_RESOURCE_MBA) {
		err = mba_sc_domain_allocate(r, d);
		if (err)
			return err;
	}
	
	if (!r->mon_capable)
		return 0;

	...
}
	
If I understand the above correctly, if MBM is enabled then all domains
of resource RDT_RESOURCE_MBA will have rdt_domain->mbps_val allocated via
resctrl_online_domain().

RDT_RESOURCE_MBA is not mon_capable, so at the time its domains go
offline, the freeing of rdt_domain->mbps_val will be skipped because	
after patch 5/21 resctrl_offline_domain() would look like below so
I do not see how the hunk added above will ever end up cleaning up
allocated memory:

resctrl_offline_domain() {

	lockdep_assert_held(&rdtgroup_mutex);

	if (!r->mon_capable) /* RDT_RESOURCE_MBA is not mon_capable */
		return 0;

	...

	
	mba_sc_domain_destroy(r, d); /* Not reached for rdt_domains of RDT_RESOURCE_MBA */
	domain_destroy_mon_state(d);
}

>  
> @@ -3302,12 +3335,20 @@ int resctrl_online_domain(struct rdt_resource *r, struct rdt_domain *d)
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> +	if (is_mbm_enabled() && r->rid == RDT_RESOURCE_MBA) {

This introduces only half of the checks that are later replaced in
patch 10 "x86/resctrl: Abstract and use supports_mba_mbps()". Could the
full check be used here for that patch to be cleaner or perhaps patch 10
could be moved to be before this patch?

> +		err = mba_sc_domain_allocate(r, d);
> +		if (err)
> +			return err;
> +	}
> +
>  	if (!r->mon_capable)
>  		return 0;
>  
>  	err = domain_setup_mon_state(r, d);
> -	if (err)
> +	if (err) {
> +		mba_sc_domain_destroy(r, d);
>  		return err;
> +	}

Cleaning up after the error is reasonable but this allocation would only
ever happen if the resource is RDT_RESOURCE_MBA and it is not mon_capable.
Something would thus have gone really wrong if this cleanup is necessary.
Considering that only mon_capable resources are initialized at this point,
why not just exit right after calling mba_sc_domain_allocate()?


>  
>  	if (is_mbm_enabled()) {
>  		INIT_DELAYED_WORK(&d->mbm_over, mbm_handle_overflow);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 5d283bdd6162..46ab9fb5562e 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -15,6 +15,9 @@ int proc_resctrl_show(struct seq_file *m,
>  
>  #endif
>  
> +/* max value for struct rdt_domain's mbps_val */
> +#define MBA_MAX_MBPS   U32_MAX
> +
>  /**
>   * enum resctrl_conf_type - The type of configuration.
>   * @CDP_NONE:	No prioritisation, both code and data are controlled or monitored.
> @@ -53,6 +56,9 @@ struct resctrl_staged_config {
>   * @cqm_work_cpu:	worker CPU for CQM h/w counters
>   * @plr:		pseudo-locked region (if any) associated with domain
>   * @staged_config:	parsed configuration to be applied
> + * @mbps_val:		When mba_sc is enabled, this holds the array of user
> + * 			specified control values for mba_sc in MBps, indexed
> + *			by closid
>   */
>  struct rdt_domain {
>  	struct list_head		list;
> @@ -67,6 +73,7 @@ struct rdt_domain {
>  	int				cqm_work_cpu;
>  	struct pseudo_lock_region	*plr;
>  	struct resctrl_staged_config	staged_config[CDP_NUM_TYPES];
> +	u32				*mbps_val;
>  };
>  
>  /**

Reinette
