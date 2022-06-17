Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B5254FB60
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383160AbiFQQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383437AbiFQQs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:48:28 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA9913EA8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655484502; x=1687020502;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UPN+XZqMruRI2qkzBDBXCwoO88HI41NU8PWXn4+Ew/o=;
  b=btAdOr1VrqZ/9GdyxA9LojqNkCuMwNy+lWPyeJus/CJapIACCobC/LZE
   0GMkOyJ73WYHWmGKnq7QmMim4NKmJPhkgGDG3KLAbYH7kv2n3OOobfeXj
   Hiov5di36SRljyx2fZNqTA3BaLOpbYFk5f7fV5wwJCJiybly4KRKmKCqn
   vQ/PDhD4s+If7u7uGEnE8U6VNjLdjKbDcBe8mPMOBx4kvwUkrqIBraOq+
   D2ji5E/ugcGbSNMwV8vUqRjV6IUvyHfFH+3gNBziKhWxwOZY6bO1chsvl
   snnNm4FXkYxTDAfw4yKNuoqS7d9N0lO1O7c7hgcxYWLIdSO+4BwWUWhmx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259329886"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259329886"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 05:19:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="688275395"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jun 2022 05:19:30 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 05:19:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 05:19:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 05:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMpNFELUM+HSIu0FAF/dnjhiYCb+/ipXhpriIq4waF5KyVfH3FRkLuYHCs6SiDq7lHmS3kyxMMxTcqJt84j5HhkGTDKtENYbxt7n0V71Y5ozcNydW+YadMxOSrBrGIMqSANnGqIW4ejkwIlImLfvyga+FV8AJt+CFW/B7fAejMSSn83j9hI20v3DvwJNF+yGKn6DAYq007JCHfI7yZPM/PutNVgzi6T3z4EqC7XWOMtdqc0lLrVP/8uRsPzkNjEgmcJqwOVbOR96cT+R6u1e0GXdiAUOd23jWU6RzRv2YGt3Y4J/vPd14g4zUXhCQB+Q8kR6FOIR0H1bjCgECksONw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPN+XZqMruRI2qkzBDBXCwoO88HI41NU8PWXn4+Ew/o=;
 b=Ce7ti4LeOYhjwnXTCiVsgIp8lhKIDKp2Dfoz3Z7480nhGIwMCfZCVT0JyOLXdactkNN/ajSKjkopiQAmqO7IOVAtmhFBaBKcFDQaDwf+brkr1rDr0b0TrRkCIefonbgQguBH8NQsu3tvT2VwgTy5rQsK8rTeOJrMgghHwawxDOIYVnzzCW0zRAWq/p6JbovE7sgvB48aHHmUWyHTeFwn9+hhQwZS3YOYLE4hb5Nks5K2hE1fUDWhWo65txtLRFCb5WZjsQbip9x+TpEiHoEEmDPuMbFQlSq2KITKXTTeagRsugCBHJY7eNxL2zSHXizhtq2iAlsClGJEfKy4N5daYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB6375.namprd11.prod.outlook.com (2603:10b6:8:c9::21) by
 DM5PR11MB1561.namprd11.prod.outlook.com (2603:10b6:4:a::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Fri, 17 Jun 2022 12:19:29 +0000
Received: from DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::a879:23a2:1836:2691]) by DS0PR11MB6375.namprd11.prod.outlook.com
 ([fe80::a879:23a2:1836:2691%6]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 12:19:28 +0000
Message-ID: <a5624d0b-8259-3a5e-5a96-ef409b9c0843@intel.com>
Date:   Fri, 17 Jun 2022 14:19:19 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.9.1
Subject: Re: [PATCH 02/11] ASoC: Intel: skylake: skl-pcm: use
 pm_runtime_resume_and_get()
Content-Language: en-US
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>
CC:     <tiwai@suse.de>, <broonie@kernel.org>,
        =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>,
        Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
 <20220616220427.136036-3-pierre-louis.bossart@linux.intel.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
In-Reply-To: <20220616220427.136036-3-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5P194CA0019.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:203:8f::29) To DS0PR11MB6375.namprd11.prod.outlook.com
 (2603:10b6:8:c9::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e2c1223-e8f0-494f-eb21-08da505ba030
X-MS-TrafficTypeDiagnostic: DM5PR11MB1561:EE_
X-Microsoft-Antispam-PRVS: <DM5PR11MB156122D80CB9B656843640B9E3AF9@DM5PR11MB1561.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcXC6XQSVOUL4dvaQLuzuDYQTMSU/w+LzrS6oBrnxzP9Nhp8JFEscHalkiBhXJsiXHz/NjFdfhe05XRpzNBePJMcH+Ndi8zjh1+ESSqZBh2T0XPbBKleYyZggpcjh5nOcJo8qjEmRQ+vA5OUd456GdubWV/gj3zqXFSyOAMjDTeo/z7km6fWaQiMksUuIljPsh4H7Aj9ZnaRLLW8f+x2tnDaaVIhOnK/jAY2UGwOzUp97DBvTvfVuXOvnxbRBGkm3g0/2vz3q0FIAPjPgnnQJFWXCO804lly5HN2DznMXRzXDV3GMR57fQqYUYDtZu4fOk34ZqP6WEEFiwcU8Uk/NIJTfEniRw0R5vtcUoU9qC4PwH2xI1e20LlP3PIAqyPCRbcuUDL7y4XFITgYRZ6pgS1o07j4Oa3rE9AeBmGwUx7tMfzTDnWpANXSq5fHlJtzVIBtxidmSEUBxCNxLxvqut0HQOme58xpPO6gscuqNHV4e5ajx6yyQgNRmpnv4ifI497R6ajrhuHWugdsgsz1Q9ixS00OTna3n2Gd9dEdIHwZhGPI2n5rOPgSNPj6yehsB5xG1bJe8j7/Sb7SOMMab2DOGE7cJFTnRAPeYjnA3uGAE86M5ZZdsMr5QOOjS+omNeSV2M5IkdOpgUfOSv5Ep7AYApN4VVjlrbpKDWsJp+mYxAQa43KhBYzAR+2Cohy9nA7En1Niu6IHPb2ymab+ZXRgE3EaTmo3UnYR+uIfkSY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6375.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(31686004)(4326008)(186003)(38100700002)(66476007)(6486002)(36756003)(66556008)(44832011)(54906003)(86362001)(2616005)(2906002)(8676002)(66946007)(316002)(558084003)(31696002)(7416002)(82960400001)(53546011)(8936002)(6512007)(5660300002)(6506007)(26005)(6666004)(498600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJrZk5lNXdiRktlNkFRMHM0dkRtZERJbk1ncWtkZzM5YS96eWNlU01Ecjdh?=
 =?utf-8?B?Q1pqUkVlSlZLMzVvNUt3TWhFa1VKZjUwbEJmejVMMWIwNTRORzNCSmhIQ0pt?=
 =?utf-8?B?NnEyaEpIaVlPeVpUUXVDckN0aEFFRXdxTU5iSUJQVFRBM1lHUVBKU29FNlNo?=
 =?utf-8?B?NkMrK242MUMrZ3RRZ1VmRjcyTmk0ejBET0RCNFhCTFZScm5kbVIrODNONzhL?=
 =?utf-8?B?amh1aWQ1YTJ3WlBnc2xoZTJ1eFJ3M1llQWFCbjFLcWM3MktZVU05b01BVFVh?=
 =?utf-8?B?S3o3eWROV1RoRlhVN1l2QWs1VW9LZ2ZqUUUrY1M4clBNUTA2UWxYOFFRdWpD?=
 =?utf-8?B?STNvekdoSmtwOVZHbFlsUDE4b0dYb0tPSVg4TlYyVm94TCs3blFma2VjN2I3?=
 =?utf-8?B?dHltRmw0cnFDN3ZnUHQ4bHNpaGtxbnhURU5kT2lwNkxSaVVyeE50dUFmdXhr?=
 =?utf-8?B?WGxva0tQMTAySk5HTnJ2ODV0K2NUb0xJc3NsZUFIWFZxME5ETHJGY1QrU01p?=
 =?utf-8?B?Z3A3N1FXNysxbkF0L0UydjhVMmtiNUQ3WDAxWjg1NzB3M1pZbmhvTzdsemJM?=
 =?utf-8?B?ZGtralpZdVBadGlodVllWWtTU3RPSmVjYzNGWDA5VDdmNlN6T2luakxzWGRy?=
 =?utf-8?B?bXoxRks3aTFYL0w3WGNvMldCRHR1M0hCbTlMeXUzQW1TMm9Lb1hmOStZa083?=
 =?utf-8?B?RHlZK1BYSGhjS2VYc0pWS1Zob0ovTlRIL2VITHFOSUlsUDBtZFBLY2RsZU5F?=
 =?utf-8?B?OEU0VEMxZ2JKT0ptRkdseTM0OENieTFmZ2lITkl5blZReG00aW1IRWQ1RjIx?=
 =?utf-8?B?ZDZJL0gxRmw2MmhDckE5Mngyb0dBMG1HWjg2WkZtcERlV3VwcGVnREcwdm1l?=
 =?utf-8?B?UWQvWjg0UFF5dDh5cjh3MHAvclpsMW9uYzJNU1hBMERwTlZ1aHVQRERmZlNY?=
 =?utf-8?B?emU1VldLa2xRVTN0T3dCSDB3RGtpZS9neDFPWnlUZHdWZ2tFbDhwWWpBUGNB?=
 =?utf-8?B?b1NvVUV1TFg4ZEJhYk1hVTJ2K3N1Vnk3ZWhUc1NkQjBIZ2Q2Q01QWSs0S3cz?=
 =?utf-8?B?cnMybCtsSVAzZzByOWpZcmJTYmhTOUdYK1h3NHBjdUllai9kZ1ZiK1ZHVHdx?=
 =?utf-8?B?eGpyaGFpenRkVkF6Y0RabzhuV0tBamVhZE1TdTBxcnRzSFZvNGdFRjBnUVdN?=
 =?utf-8?B?Rm5FNFNwZm96T0p5U3diSUVnNytxellRSGYveW54MzJCakNUR291OHNPSG5W?=
 =?utf-8?B?SFBabHVCbWRPbWk3eGFZQm5Lc2p0Qlllc2FBZnMyNzd0Y05FU0ZRWC91ZDJZ?=
 =?utf-8?B?K2orazdJbkx3Mm9KVE9Dd2JqUU1RTEJjQ1hzb1VQRkdoanNmL2dqSk5ScGxN?=
 =?utf-8?B?b0tOT2s2T1daVnhhRmU5NHhuSDFxL090SVh1TlVXaUduTFp4NHlYVjd6dFZm?=
 =?utf-8?B?L2JCcURycnRUcHBGRTBaUUJ1akRMQjlxUklsSnp4UUFwL1ZJZmtRV1JhaEl6?=
 =?utf-8?B?UVlVR3VIZFc1T0NXMHJqMW1LWi9odlZ3ZW1UN1lIZGxxbjUyMFVjVnpXWTZr?=
 =?utf-8?B?U1puM21ha2Nja2l5aktMZHhZeTRxL1d4dzBvVysrRHR3RDVab0Q5SmVpcW5o?=
 =?utf-8?B?NlBxbE5kWGV2cFF1QmxDUmFvMjJsQ2tLRjBhazQvby9FL01aZVlobk5JMks5?=
 =?utf-8?B?YUU4WDlPaHAvQ0o1eWJnalFNR3JPL2dubjVScmt5ZlFNbEN0U2tqY1FVOVpj?=
 =?utf-8?B?Y3BuWjlmeFpBanl4cjBuY2FHQ2ZVYnhzQUhzci85bmQydGpNL3ROQm0ybWJp?=
 =?utf-8?B?OTNwTmt0T1BkNVVZQndua1NncjRVdHJNUVpPbVZtMWhVVU0rTUI2QTRaQTBL?=
 =?utf-8?B?dDh3MHVxaTdSR0hLYUdHZ256RlhteTU0emRCc250cU1GNnZpMTNib3RPdk1E?=
 =?utf-8?B?UldBOG91RWwwRmpNdmM4cFJOSlJHR20wdnlpdXM4ZklOWEtFdUlua3lMc1Fn?=
 =?utf-8?B?TzJRMkpuZ3RPZWpsYjFITXpSVjZISndDZ1NXZjB0K0hvUmxSTjhjZ2VOU2tB?=
 =?utf-8?B?eVNWeVpNRG4xa1dVc09YVmYraDFaUE9wbDZvcUFFSWNwbEpIb0hoOUxsTldE?=
 =?utf-8?B?UUxDN0NNam1hYjk5L2x0TlZWMStPTWFkM0xOS2JFYkpUK2w4ZEVTeVFXdEV6?=
 =?utf-8?B?eExsK0g3YVgraGllWXQwcTdWV0hRVGNYMjl4VmsrcEtiMzhuTVhUYUxjSy94?=
 =?utf-8?B?VldKRkhaL24zdHJQelBlS0ErTENvOEh0Z3VhdkUrNnU0cEpKMFpjTm5oN0VW?=
 =?utf-8?B?c3NPSDJscUdzYVBNTU1WNFJYM2tlSUdYeWpRc0RsbW1YeEo1bUlMUFNzK2Zr?=
 =?utf-8?Q?b+KZG6E/q1HdIL0M=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2c1223-e8f0-494f-eb21-08da505ba030
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6375.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2022 12:19:28.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WTSAYQUC7/+c6SMwS2Hs4zjYflqRI0ME5in9fLJmFunpUwr8sqO4awsmg8bR83/yAOzqpeIcieIm3KASvFrz2fgYxrn9mSJzU9ntO1VMRSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1561
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-17 12:04 AM, Pierre-Louis Bossart wrote:
> The current code does not check for errors and does not release the
> reference on errors.


Thanks for the fixes.

Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
