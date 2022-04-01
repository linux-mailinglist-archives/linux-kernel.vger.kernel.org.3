Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF924EE8B4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343602AbiDAHCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236804AbiDAHCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:02:20 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C164DF6F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 00:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648796427; x=1680332427;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f/4QLzXT0CbdEWwrtYAd/2HwzIiLQ2uUVbByaCumNYM=;
  b=YAFqzJz4PZ91jR07g7nDg6xigCAor1vlnhZ1veMsJYy3zBMsuoYhmvMM
   Y+3uPUHY+3NP/yjC8NNvAmWYF+JvXnb6gVnoGFW0J8y3+uCDcADJHfes7
   MVqpnUilEvpIQhozJ472AN3ip1YiUTYJfqMnqEgOe1kyuRFj8fOpcO7q8
   DgsUCgOZ8TtZObXm+GN7/ZKnNqNzX8Q5SVzYXK6MKZPOGb8vmzDzpdO9N
   9igJn76vg5J+U1ppiDVwM53uqbuhyvF4x86NvRgfyYYYk4Fnsr+i29K3S
   tLj1SaE8mkqy21KP6T2Nf3MS5JoxMav0VnUod3Wixnp8S076KepNk6Ybu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="240649974"
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="240649974"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 00:00:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,226,1643702400"; 
   d="scan'208";a="586743879"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 01 Apr 2022 00:00:23 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 00:00:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Apr 2022 00:00:22 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Apr 2022 00:00:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jNNTpVnbIvRzQHD6FyS/Ml8MinJzvRcGwhnlO7l1ZFG7GXhAj00r+fl1v6R22I53depd3bHvFhvSIZqr8slKLGW4Bbmc6IzMxo9qJbT8HjS0m2NvqVesJbRRELjb5H52zBXI2RO0i5uApT+UzSTkRx5/R3LglJR2fnB6eHVCkwnuu+89Woa6FHy7so2XmrMnJpp+bbZNNC09fg6iiiW2esjtORTeREYj+gSwvM1/Ixz+Ne0B9paeVG78GQXFIPw7oLOmKYGhSY/RTs7mXfncqE6ksaj+gj14Q/EtNJtuwYNLlo9HzDo+G2sdSVXnndIUmYb9+lEbsC/wA1jJdhweJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxQIQGJ26omoIBBEZLUcnA0hqNAqyM96Q+PFXmPXMNA=;
 b=ZprIHagIrb3btTrUNp8qGOygEJckMdY8tyKT/AzIS6XWFLkdV2xRVaAWHhk1HbC8jIswVkVa0BjhLzlxNkF9AilyljSXq1ynKSSR/1fxLXXJtywjV3eNuNPBqdz2oAASsc9eFaZf9igIq4De2KKsLOurYKCFo29RuSLrtUCEIagmt0x488d/T3GflCOu7igcvclOuu2MFjZ3VgpBWjCOJNSv1qZ1QVHrfqtFMbN96sFbzbg7SbRFFMoh6cD2qCZwJWmtao5PpfdpQc33auh+ROk+r/+jGZVxWlZzBeePAZmydL7eFumbqE6uG66iip4lqrR93nVKLZLkBHGr4Ye0vQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 (2603:10b6:301:51::10) by SN6PR11MB3056.namprd11.prod.outlook.com
 (2603:10b6:805:d4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.23; Fri, 1 Apr
 2022 07:00:21 +0000
Received: from MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::ccac:dd6b:b12e:477c]) by MWHPR1101MB2157.namprd11.prod.outlook.com
 ([fe80::ccac:dd6b:b12e:477c%12]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 07:00:20 +0000
Message-ID: <c69ee5e5-213f-389c-9d22-69addddf2aca@intel.com>
Date:   Fri, 1 Apr 2022 09:00:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.7.0
Subject: Re: [PATCH 1/3] ASoC: Intel: catpt: remove check of list iterator
 against head past the loop body
Content-Language: en-US
To:     Jakob Koschel <jakobkoschel@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        "Mark Brown" <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Yang Yingliang" <yangyingliang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        "Cristiano Giuffrida" <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
References: <20220331215003.882143-1-jakobkoschel@gmail.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220331215003.882143-1-jakobkoschel@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR07CA0063.eurprd07.prod.outlook.com
 (2603:10a6:6:2a::25) To MWHPR1101MB2157.namprd11.prod.outlook.com
 (2603:10b6:301:51::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab60889d-99b7-443d-5752-08da13ad4948
X-MS-TrafficTypeDiagnostic: SN6PR11MB3056:EE_
X-Microsoft-Antispam-PRVS: <SN6PR11MB30565F619D599B125CEE7A07E3E09@SN6PR11MB3056.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XWMqDNelnqspVioN/INYhtCTWvECJ7+EMWf/TCKzf18zSXgyFKY99JqyEq9atZyy7dQjHz41k01vkC+EY0Ezdq0OrMMMwTpJulmS/ufpDdTCZzRCuqI1DYt6VDPKch+WioTySmp5UF/rPlMfSV94BrXD24ZLVx4XlAJD1vTAt+sQkUsT8LAZUQ89tbNtuBTw28D6WLnY1zOD0Xj+8csj8GZQyFS0FW5hQQ4tBZqH+sTNdvam0X2A6zrTG3EC6k8s3HTpkA/XbCcWnzdfBCGUiw31Sno6wHlfxHUE8D367IsfBGxlk7zZY/mqeYC5ARl+yn/+RxQqdhJtb3qWYMipYPQizOCiyytZv5YdwowU2HbIiVgY1OOyxWj+9K9vm/Z/2gOyIIVOGshTQSL6YcQvEFIHPnAcOxkG8TS9WOcvQOTaffy0sjdIj1j029O+2V5JrnG69c7lVhv4V0bepHihS4nfwkRB9ePEO6OM3pLBy/RRjSUZcXT/J9CUtArsELgRDT09mtU82sx3RL4XJ3RpQkNfrq//n6SR0KUYfVLbEMWDjHg9cBDbB+Uo33FpxQRcQsYrZz0bHkWcMM7KrBnrMhd5tUrCJRzhUgItHvpiftDgSoTEvh8h941F5fpgXIBFa0yFBbN2wjHd44BLxgRST6bBzvJwSTRRXuj0TSpzQDGqnTYXtHtd0MO2CCWMAfkxBqKkircXpSD548T2yKL7sIzkIXU+sJrvyTix6/1hMRag2Pxqlf83tdibEcPT1xhQhCJZjTaz4LS6WDDaJqbct4u2qFSRquu6vENlmk7jXKff4NdrIBr9Wqz+NMvdAqoFU4dCRh0DsEBkO8jDLgtFXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2157.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(26005)(2616005)(36756003)(6666004)(2906002)(6512007)(31686004)(186003)(53546011)(6506007)(6916009)(966005)(38100700002)(82960400001)(6486002)(8936002)(7416002)(54906003)(508600001)(66476007)(8676002)(86362001)(44832011)(5660300002)(66556008)(4326008)(31696002)(66946007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU0vdkpEUFY2dTJCcXluOERHUklyYXNjT1NXR3hMYzcvbVBJbmRkMm9scWlH?=
 =?utf-8?B?ODJ1eGRmSVlJdU1oN3d0TEVyeitmMlBOemJWYldwM212UFhOc29HZExLNHQ2?=
 =?utf-8?B?bXJpV1F0bzN5WWJYOFB0N0xWeGw4WlVFUW5CRko3WlcxV0RQb1pDT0tBTnMv?=
 =?utf-8?B?eDNhMklUS0FvWW8rU25keVFvdjlVK1ZFYU91ZnlSYVJxdUFiVEhJVTQ5QW9L?=
 =?utf-8?B?Rmx2dkVpZHZ6bTNlQWpOS0IvQWRETHJvUzNiSFQxQWFEVGNZeXpzcm5YL24z?=
 =?utf-8?B?STJzSXRLQUR4dy83VUp3QndmMS9BbTJuZlpXS0NyVDVHV1huYkZCd25jWG1s?=
 =?utf-8?B?MkhNL1djajkxQktQU1Z2YUhHeWExS3pGNlhPZUtxMVk5Slg4VEZobkUySDR0?=
 =?utf-8?B?dktuYWFLMHFGZ01sMkI4WkVBSzBiTWErVFRhaE5XeDRrdU5sR29RNHR2NGNy?=
 =?utf-8?B?STFrdVVlQUJFZUkvUWV5VGhNNU9tR2xOMzY2OTR1dVkrK28vdm9oUHJXL21N?=
 =?utf-8?B?TWx5SFdwZ0g1Z0tmZHJEdDFZcFVNVVhHS242Z3I5MVZDUXV2bE5UT3c0YTMz?=
 =?utf-8?B?ejVBU1RkV2U0Vzd1TmNtM3ZaSmJRWFZsOGEva1FjclVTK0Y1cnlIRWQ1dEk3?=
 =?utf-8?B?WStDVm5YTEE5d3p4YnA5bUcvSGNrNFAwWEdISjlJTnhKZ1JsVUhZMndWTkZH?=
 =?utf-8?B?MG5seUlyWXlzNFdhTGNkUkR3bUR2SW1TVE83cm5GVTByUjl3TGJvbElhV2dI?=
 =?utf-8?B?VFl0N3k2TGFkU3pYRVB0azNuOERibWZ3R09TTlBzZDVQeU91Uy94YXkza0JV?=
 =?utf-8?B?QzE0eGQzRFJGZ3dranBwa1pZd29SRTlZSHMrVEVWRWlNNXVvZEYwcGdPM2xS?=
 =?utf-8?B?VCtlUnpVZkdWdG4xa0IwZm5FZHdvUkp6SXA4Zm9JRzc1cUUreStLa01STGF2?=
 =?utf-8?B?dlY3TnhhSnVVRHJhTXVYdG1WTmwvMElrQmVFejdua1l3MTBqYW45dy9xakZm?=
 =?utf-8?B?TzJ1NFpsOFVQck9NTGgySE5LTjdOWXVqSTFTdTdTdGZlZytiVzgvU1FKdWRZ?=
 =?utf-8?B?dXNiek96MGFUZE52SjVlMGdRVk9FNW9FVnRWYnlaTWNvSjNXU1B5QzFXWDg4?=
 =?utf-8?B?YzFOMWdDVXhBMEdtRTFTN3ZDQWoyekx1ZjdCTTYzQ1F6R2lzWEE2K1BTeUk5?=
 =?utf-8?B?azBrWjJQNDBFYW5ZSGdIOEdWNzB0UHpHcmlIZjU4VG16cGM2RTF3YmJ0OXMz?=
 =?utf-8?B?am4vWktHS29HQkFZN2Z3S0t0M2F3TzdSdDNwcnhESDNMN2tobStHb1RrWjZt?=
 =?utf-8?B?VGJkNzdVbWZBRitqNUpHUlZnc05DYzA4R1BXejVtVHZjdERoNmU2ZmpBN05R?=
 =?utf-8?B?Vmx6Qlc5L2NlYnJ2bXNhRXpHZldlMUM1RUNUSFducWNZdlpRTHBJSXlUWklH?=
 =?utf-8?B?Q3h1ZWlsS1FQNUlQS1ZUak00OEh3dXVCQlRxTGE3cWQ3V2hXL0g2OFRzVFU0?=
 =?utf-8?B?S3BmZE1aaENwTUpmUlo5L2lCZVJQdnlINTd3aVc1YldNdmNZQTVzUnBjdTdr?=
 =?utf-8?B?L3Jjd0I5bTBhZUM5RHdRYUtiUkduT3hCT0YvUFRnR2szblVEQStLaTVCeDNp?=
 =?utf-8?B?WStuOS92cjA0aElGOWx4SW1MY3J5VDBIdzVGYm1NNzBvdkF5anEyaUFxU1hp?=
 =?utf-8?B?TW55SHk4M3d1alZ1U2l3RkcvdndIdVR4aUs5YnpkL0hla2liK0RTOXAwN2JE?=
 =?utf-8?B?aEhCd1RJWnpXeWFCL3JqWi9lQ2ZVUG1NT1BVNnd5dktvNFIvSFFpZDJ3bmV6?=
 =?utf-8?B?cjAweHNaMldBcjBPNkc5SllqMjJqVTFyOGM3SWJvcTBuOFdVM1RocmhLZ0Yy?=
 =?utf-8?B?WmJkVzFkenBCWVV0c0k2Y3lqTTRPSnlwOU5yQkdVLzdDUzlEVnU5OURSN2Qr?=
 =?utf-8?B?VVN3amFYcy9mWGpFU2VoNlM3eFczWnNLL1dMaUFmMWVyVllGNjZZYVBtUmk4?=
 =?utf-8?B?TDRLK2ZjU2I4ejAvOVhITUdhTmFrazBhY1NLV2hPQm9FbTBBRzdSMnFzRXNR?=
 =?utf-8?B?Z3JpVnJ3R3FxeEtsOUhsbitWSnV0ZXg2b0lwUHp2c21VN0U3K0xVSGdncXpK?=
 =?utf-8?B?dEtRNnF6ck15YjVlYkFndGdERnFWNGVnWWpoQW5VL05FUFVOV0FZbWtMTkpj?=
 =?utf-8?B?OUxyZkpCYzRqeTFlQi9Mdk11bFpab0tqbFRGZUdQMTNXMzJTaW5Sc0tUVE5S?=
 =?utf-8?B?UFJ6MERPRmFNc3ZTRlhVZ3BnTENCallwYVdlanBBNXJmaEJKTjgrc21pNlRO?=
 =?utf-8?B?citGSkV4K205UDZjempNYThsOTd2dnB0aTRRMDZGdzRublE4bWVkZkRSSzJT?=
 =?utf-8?Q?m1+1p3HC42ZCXlCM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ab60889d-99b7-443d-5752-08da13ad4948
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2157.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 07:00:20.8593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jFZ4Izea/v/b5tNL+ty1y+sYPd3H7uauCejPRgRScjXvxY1atF//sQvUAEpmmIXCdKgz9zCMAKJsZyBAyI13Lucy8wyhvMV/QWRSMJhn54k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3056
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-31 11:50 PM, Jakob Koschel wrote:
> When list_for_each_entry() completes the iteration over the whole list
> without breaking the loop, the iterator value will be a bogus pointer
> computed based on the head element.
> 
> While it is safe to use the pointer to determine if it was computed
> based on the head element, either with list_entry_is_head() or
> &pos->member == head, using the iterator variable after the loop should
> be avoided.
> 
> In preparation to limiting the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to point to the found element [1].
> 
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>

Thank you for taking time and updating catpt-driver along the way.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>

> ---
>   sound/soc/intel/catpt/pcm.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/intel/catpt/pcm.c b/sound/soc/intel/catpt/pcm.c
> index a26000cd5ceb..b103b2d4026e 100644
> --- a/sound/soc/intel/catpt/pcm.c
> +++ b/sound/soc/intel/catpt/pcm.c
> @@ -330,7 +330,8 @@ static int catpt_dai_apply_usettings(struct snd_soc_dai *dai,
>   				     struct catpt_stream_runtime *stream)
>   {
>   	struct snd_soc_component *component = dai->component;
> -	struct snd_kcontrol *pos;
> +	struct snd_kcontrol *pos = NULL;
> +	struct snd_kcontrol *iter;
>   	struct catpt_dev *cdev = dev_get_drvdata(dai->dev);
>   	const char *name;
>   	int ret;
> @@ -354,12 +355,14 @@ static int catpt_dai_apply_usettings(struct snd_soc_dai *dai,
>   		return 0;
>   	}
>   
> -	list_for_each_entry(pos, &component->card->snd_card->controls, list) {
> -		if (pos->private_data == component &&
> -		    !strncmp(name, pos->id.name, sizeof(pos->id.name)))
> +	list_for_each_entry(iter, &component->card->snd_card->controls, list) {
> +		if (iter->private_data == component &&
> +		    !strncmp(name, iter->id.name, sizeof(iter->id.name))) {
> +			pos = iter;
>   			break;
> +		}
>   	}
> -	if (list_entry_is_head(pos, &component->card->snd_card->controls, list))
> +	if (!pos)
>   		return -ENOENT;
>   
>   	if (stream->template->type != CATPT_STRM_TYPE_LOOPBACK)
> 
> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
