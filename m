Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646B8569AA6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbiGGGot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiGGGop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:44:45 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 369DE2AE26
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657176285; x=1688712285;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xrFhtSlAb78gMRjZfFuKpzMzPXKcNIYaY8ONrr2eKKg=;
  b=T2FZR5SXfyxmQ1ZKXwkHtDhcMOaoy3ER5FifLigz1yPhfZNMik14gL/0
   kFCy23djuLD66lr/INs/fWIzJEcrdBfuELro8sQMOBA1ru39YptFpw8o9
   NUuF66QBO65fWubwcJIKSDwdj5ZNakP33hX6fnMxDUdyDs+XAcFy94LTu
   8aaQTrVyfdMwCw4W0kaTkgM6a4mLa74v1mHzF9DS4V5LX7qIrXVDXKPLb
   BsRpdeRSljEjFx0qX3Pg6Yi7vKE8NhsSN720aBog2SDFjxXSZ4T62JunL
   Pmyc4klohaMOT8twrwklgxgxl99zKVVBlfXh0FTnlThAsvw5fm669oEWg
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="309503180"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="309503180"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 23:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="543706164"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2022 23:44:43 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 6 Jul 2022 23:44:43 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 6 Jul 2022 23:44:43 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 6 Jul 2022 23:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtDnBQEV8x2Mq+JHkffkYYv36yFU1n9kgnK/C9ypQKbBve/WX99SBB21ybxzBSm9oj4e/CcjCYCpsU3N3vaew/QOKT3UrfSiAylnHXm1efZIGb1HEIok2im5aucBjDpC+sFJpeYyNqx/mP1upFkiK4FdWOYcTogcrqbsm00GPoiVqtvwjE6XQHKxLmzoXGyvJZX39EaAt+zBRCvnwSPefiLMfJXGhxuAzTUsYQFqmO3tcRH4Uyv5PtVgQlPOyq/z9+DcQdz7n6A2UEPYCYWuYKLhIto1nQ3zREOIcOsv5yHA+ywMC6MjIHnLEVa7dOWfgxPVZRgcAaHA1BmVMf6sZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIQtd+zbBQ7xkenu6ln+4wmZRENDtSqtb2wYCucRARA=;
 b=P8AzQkDFw2Dh9hl89lG/OfRTanzUGdo0Li5Pk49LfX3pFXGUa46ktb7dnffVUVt9gr1+DUHcT5fSnWvT1prW9TIeV0Wz0LbE7wg9BH31dhqbfNT/4DVIv/k+N5uvf40AdGOiGeZ/owKpzwz+ZTKYvXFf3KN7aCmqeWBUV6ck5bGHKWsdkWqFTLIoVMSw9FdCnmuk+nRLpBGNpOk3BAekxm81arflE6zi/u8BI2MJjBPalL/fx7jHajc9xpigL7/STxqeDdUqEQZA9rArrv6ccRC5sPMp4r8cn477VxkZpbw6l8c7uyKisYUEfKmO2PcxgeEaZ/j8b/uccpIKpns3Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Thu, 7 Jul
 2022 06:44:41 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 06:44:41 +0000
Message-ID: <c7b2b110-808b-c91f-7fe0-5d48f1f00dd9@intel.com>
Date:   Thu, 7 Jul 2022 14:44:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: [arm-integrator:kernel-in-vmalloc-v5.19-rc1 21/35]
 arch/hexagon/include/asm/page.h: asm/mem-layout.h is included more than once.
References: <202207061920.z89bMMgl-lkp@intel.com>
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202207061920.z89bMMgl-lkp@intel.com>
X-Forwarded-Message-Id: <202207061920.z89bMMgl-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0053.apcprd02.prod.outlook.com
 (2603:1096:4:54::17) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 543a3fe0-755c-4759-a017-08da5fe42bbf
X-MS-TrafficTypeDiagnostic: MW3PR11MB4620:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vyQIwKwQtIDwONSR9D6IL69nTqoqIYWpKkKkziIi5VwG1LUqxtk8JrOCAUGwGWL0MjLDIEGkNlU4TTDPIcmGEy2C3GMrH9+MXcmWkFtUBH6aOEF2xbsx5TGKRrzdkNiAB6Fw629tWVZjgMG8hDORAj4aTKRTnYLuL7rLeLleSdhcMhfJ06ANWfUwUKlLOXvo9a5OYJku5sk0Wj61ehrtDYMxdgEzMYTSZwR1YIR3dwbPSWHP0qnSIKPDz8wc1P0Z+3gJEqJ6H/l2E+aVde5OH4q4bidr0vkEqlZxMf9yAz61wnbGcMoKL+Wiue3ZixabiPn55Jtr9CSmY2peu+oOQMLhbMoXpPk+TKBCIThBAk06dBruvF2fn4HavYfZecicFkoFkq/d6PeFfYsItTIOhZW7ZrU2O2yZlHLaqvqb3HuBIsdX9jjonm8r77SWMN8BSr0HhKM9pUmrpL7Q1Y+TcwbxFcTsdzblReyTF7hgp4f/xsdBaTpDCsklpiQvIVTsUwBq2OMhraDaus6Bkkt2he8pm73VAzTOV2avmBkrvI4oqBARriOqywoyXQfxhmt6X2QLS9TPyoy8TUdAnDguxKvxPWuhdGHlZd36WLqBUmASyn2VFGoqMwIrQBWQ5IY3jYjEfhGfg9T/tOg3taj1dg272xhQ/nCgu8Yb5owMIrVc2p+Xw+4AWC0g1cP52CgqWpVAiJTiohgYzP8meQ+Kmw+NIiL8XWgbkGgQ5awpE0wBhvQyrBhyDvUFfo+6Q8muRxT8nRmZZ3OHJG3QNbU3O36iX0Fq/OQpJ8nJemi/E2hOU2XaETglxHOijOXei2P8bfzRu3koKnQ5wa9LlStezrKEjWabSp785ae7w6eSJpMl/Mr9yXU/Ne/y9FmOmN91OSkJiIHXrhz0PwE6+S4vokQrf1cuvmGmxn4UXx08CIuKhbFdN427HLK2dzNNBfV2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(346002)(39860400002)(376002)(136003)(6916009)(31686004)(8936002)(186003)(66556008)(4326008)(8676002)(478600001)(66476007)(66946007)(26005)(2616005)(6512007)(6506007)(83380400001)(36756003)(86362001)(38100700002)(6666004)(966005)(2906002)(4001150100001)(41300700001)(316002)(6486002)(31696002)(82960400001)(5660300002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWp4K0ZUbGcyOFNNUnlnT2NFbzMwK25NSEoxVU0rZlh0TXRweG1OcU5OMkZt?=
 =?utf-8?B?cURFZU8rYmk1N1c1b1RwUXF3cG1zRjUxT252Y2J5azRQWWFmTkNKNEJOeStj?=
 =?utf-8?B?QXJqcVhsM1l4bUpXblBoRnJialN3a3MyUXpEN0t3emUzWE13VXJaQU1aWi8z?=
 =?utf-8?B?VlRzS3dvSU5PbGU3TXYxWi95MFkvQ2RrSXAvNmxtUm42RUtIdHovWkhuRkQ0?=
 =?utf-8?B?SUdXMS9uakdHNnRMQTZWZUNvVHlPQ0h5VVV0L1VUV0tMZVJaZkhmWDl2Z1ov?=
 =?utf-8?B?OXFKbEE3a0Flc2N0YklXY1VQUUgyc1l6V3I4cWhhcXVIQ3RHOGFkVHdXeUF0?=
 =?utf-8?B?L0E2ekYrT3pGbFV6MnFubkZrMk1DRVAwdFRkNUM4ZmNSeGRNdFNYVjl2ZFR1?=
 =?utf-8?B?elFscFJtakhpZE41YjA0bmxUeGZIaXdIckZRTzllakxjUUVWaWlCUEVnZ2FR?=
 =?utf-8?B?RllXQkthV1hJSHhmZHdNTnBKZ1FIMzk2NWduV2ZIU1l4ZmNoUXdzelR3MVpD?=
 =?utf-8?B?SkVIQnRKSXZ1YnB1MTlybFM3SXlnWTAxM1ErVXlvcVpyQWNTRGRQNHMrZFpC?=
 =?utf-8?B?UE9LZlpZSG95elNnVnh4WkVYZ3ZGNG1kQ0V6dGJPRXRGK2JNemo0NlhnR2l6?=
 =?utf-8?B?dnU2SkszbGkvUXhlaTgxeGZGN3pScTVSQnFHNmh0cWlIQjhQc0NiN2N3N05E?=
 =?utf-8?B?STdEYmVCcGRVZUlHeDc5U2FjVCtyR1NiN0VCQk9BOGV6YjZpZjh6bFBiYjBG?=
 =?utf-8?B?S3Z0M05Yb2IxVEJJaFl6OGFscWlienQwRjFWR09hUi9nRnBYTnM1QUdkc3I0?=
 =?utf-8?B?VkdhZzhFZThRcENrM1VBam92dFBJSFNWTzd1dHFzaDRYYzJrOXdCRS9BZitH?=
 =?utf-8?B?MENzWmlIUkZpMHpoaGo2THFNVk8yS2p3U3JudVFZZ2hrUW5sNlZIMWRxTXJO?=
 =?utf-8?B?K2xCcklwWjQ2cnRldk1NdjB5V21yZDJFTmF5bzhRdnRoSUtGSG5wQ0VYajVn?=
 =?utf-8?B?Tkh0UmFMWFZ4cnRnZWdSRStPWGhkdXVtMkVDUHZqVmo3UVBjQWszSUFScFZx?=
 =?utf-8?B?ekk1Uk1CajBIME5OeDBXbVlPcVlrZERJVFZ3eFAwWkdKU3RBMG9zZkt6Ym1D?=
 =?utf-8?B?QzN4V1pLVi92SmlHUGFReXhNa1Y5aUpaQTRoaTk3RXRLS0psMExyK0JFdzMr?=
 =?utf-8?B?eWE4Y0N2akw0SlpZSGJncW9SS3BteDhpd1RQUUFKV1JVNHM0WHJISjhnZFFS?=
 =?utf-8?B?SnRJWnZmYWszMThDVkFjUDNvcFR1cytrd3pIYjRTVVFYR2tOVHBITDVUYmRG?=
 =?utf-8?B?a09vRmo1bk01OUJ3S2lrTE9EOGtCZlpCNFNpaUFlT3J4azI2amlNY0t4VWxF?=
 =?utf-8?B?YWhJYXJORExwejg5L29PUTBMc3dRWkpvdkxqSTNKMVhwZ2Rma2Y5M016RzdC?=
 =?utf-8?B?ai81cjZIMEE3WlI0SnRIcGc2aXpMMUI4cmFhQ1lPejhaYXhxT3FpVU03YjBH?=
 =?utf-8?B?QlpBbU51NjRUbHRvanREYnlTQVBJY2VFclhLL0R3U3FTRng1OUExaGYzc3F0?=
 =?utf-8?B?Q3FMWEtnNDJPT0M0UVlXSnFRTHJxcTdqUUZpSTdHNE1VSXBLNHMwZFhPdjhJ?=
 =?utf-8?B?ZytIZFJOWUF1aXJ4QU84NDROeVNvclNkSHdodVRyQWNhYTdpSnBRWVdYeTN5?=
 =?utf-8?B?aEg5Z05QUzNKY0NFdG52NmE4T2FhTWVvemhyRDl2ZGc5ZU9PSXhjRkV6bjRU?=
 =?utf-8?B?amV1RHVrZG1QcFdMTnU3WTZMN2JhNTNESjlvb3hJT2k0TVJSN3VKeS9PbEE5?=
 =?utf-8?B?V2xXVXpvWmx0NldoWis2YzBIQW85R1Byb1JDdkd4cm5VWE5TUWhES1RQOWdT?=
 =?utf-8?B?YThxSTNnRVJVOXY5aWVSMWorczdibWhTcUlKTk1ibnY4VEVJb1dGbm81MG9j?=
 =?utf-8?B?NVJTZ0VHUGl2OUZENVExa1Y0UTZKbitjOWc0STJUV1N0L1VSRTJMNkpxTkZh?=
 =?utf-8?B?Yllxang3Y1R5Z3JUbkh2aXdKWTB1aldVSC92aXdkTzExWEE2ZTBNUU15dWVk?=
 =?utf-8?B?SFNWVCtQTU44cVdlVytpTXBmZU1hdTVzWnhaaU9LMW9hZnd5d3J4QWR2bUV6?=
 =?utf-8?Q?kBcOMh8KWy/If6TmfIf9fRl2a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 543a3fe0-755c-4759-a017-08da5fe42bbf
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 06:44:41.8444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUApKgYjOjSpVE8OEAS9pmt7/ofguawNA76iaIxhZzvJskBaYiftFeqO+oBbP3a/2ydxC+R9qatHw8ny0Vrj7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.19-rc1
head:   144435741b0a6f31403d3084103678da3b4f9d11
commit: 5f1754f29aba0e4910d757ab7c318abc9d22b66b [21/35] Hexagon: Make virt_to_pfn() a static inline
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> arch/hexagon/include/asm/page.h: asm/mem-layout.h is included more than once.

5f1754f29aba0 (Linus Walleij     2022-06-02 09:45:31 +0200   81) /* Needed for PAGE_OFFSET used in the macro right below */
5f1754f29aba0 (Linus Walleij     2022-06-02 09:45:31 +0200  @82) #include <asm/mem-layout.h>
5f1754f29aba0 (Linus Walleij     2022-06-02 09:45:31 +0200   83)
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500   84) /*
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500   85)  * We need a __pa and a __va routine for kernel space.
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500   86)  * MIPS says they're only used during mem_init.
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500   87)  * also, check if we need a PHYS_OFFSET.
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500   88)  */
8f5a0b9dffeb3 (Richard Kuo       2013-03-22 16:05:40 -0500   89) #define __pa(x) ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
8f5a0b9dffeb3 (Richard Kuo       2013-03-22 16:05:40 -0500   90) #define __va(x) ((void *)((unsigned long)(x) - PHYS_OFFSET + PAGE_OFFSET))
...
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500  146) #define kern_addr_valid(addr)   (1)
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500  147)
8f5a0b9dffeb3 (Richard Kuo       2013-03-22 16:05:40 -0500 @148) #include <asm/mem-layout.h>
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500  149) #include <asm-generic/memory_model.h>
a7e79840991ea (Richard Kuo       2011-10-31 18:53:38 -0500  150) /* XXX Todo: implement assembly-optimized version of getorder. */

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
