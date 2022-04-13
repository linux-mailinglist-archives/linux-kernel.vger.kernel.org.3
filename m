Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B4B4FF26E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbiDMIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiDMIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:46:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00125006C
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649839441; x=1681375441;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MOhC2EROjl8CR1Hex+gbkLjRXMTWPc1bAZh57j/B1kg=;
  b=FY+K6fUJdIaQRDMAaLv2DIpBxkeb7n89qZxrE8WxE/+f5F5ah+XR3M4D
   yJfw6100U2opYvqYTStcreuguTgxNBE7miWrK/aUgY8kAWLX0Ij3E9p2F
   JThsiOE5VDYhUeKrrPrh0znweSBEcH3xyh2eeiOEs+CuM0GHccabcRY06
   frFI8KqvDlZMZXRrBXJvFLFaP8Rg8lXD8ToCXx4K7Xda90PvDf/Pm0q9r
   isBJV+/8Es/IYp55l8v5KO8q5tR3ka+V6brFVZMBTlinfGvfFTtkQ68V/
   Ksp240eVIMIfIRnSy3+sEaCEIf8n/a0ItjrLPxtY7a6wpfFZu/TpEtMm9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="262052549"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="262052549"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 01:44:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="645084786"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2022 01:44:00 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 13 Apr 2022 01:44:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 13 Apr 2022 01:44:00 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 13 Apr 2022 01:43:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UwB7RUYOozYagDVRZxlu0276ycrA3BInJyyprNosci5aABhl/eRhBja9kFuWQJKXjzue2ZFbbWOb/bWF3kG0yqPWEhlurQKzEG7JtUGkTbY+yiQ3QepiEFTcl2ST4GKUEUBO8tsGph3gz76eZA4ZppfxDHiF/I1SzE8MnE0Nza3Ib+pXCWj9ODj5XXEwYQugwDqCHLfLhDOJwhPy5jaRE4WTOnn8EBLKWC8FWtrdVIhFfxcg9s3JCRyDM4dIVP3Pbjf5tMmZmAgzWoBVVw2HrILsTtVviKdNMFcwymhsR92U82zeNJozP0GyOR5UTtHsv1RRonvp3saI5JbG/GEOKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRLK5LgeevbCa7rPe0SF9aAtZ1gI+GuRXiyfJWcdqOg=;
 b=KeY08OFJLU16dLN6rTxkmhZkvrunxMRiRqy4UdIakHhDJMi0ndJM3fctfdXhH4EqRfyUW73CT0cwJI24QnAPNf55/Y5735lID77ojuGOYb2YWIISeNaznx1qGxOBtnfujtnwEc1n+aHEqB4iH81eZTisIteku8AcWGeAMw/7F7rzRP0ikj8u1PaDCNRgk/tvWG0scg63WhVB+WLzZv+manlVEUQ03P7L1P84ZcTbgL47sJKzuLtWXngLQ1dxlpidHDw/5qgOF9Lcq4h/Z7rfptVg2C4gYgDW9E/8h1i+UOOOvPZohm5mj67N60Z1uLK07YOkwSm0YOfRyGBzsyEvBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by SN6PR11MB2653.namprd11.prod.outlook.com (2603:10b6:805:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Wed, 13 Apr
 2022 08:43:57 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::90bc:9408:541e:5b94%7]) with mapi id 15.20.5164.018; Wed, 13 Apr 2022
 08:43:57 +0000
Message-ID: <5f198292-247a-e3bd-f3b2-0052d318fc20@intel.com>
Date:   Wed, 13 Apr 2022 16:43:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.0
Subject: [tip:perf/core 3/10] arch/x86/events/amd/core.c:722:3: warning: Value
 stored to 'hwc' is never read [clang-analyzer-deadcode.DeadStores]
References: <202204110431.SBvb4g5G-lkp@intel.com>
Content-Language: en-US
To:     Stephane Eranian <eranian@google.com>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202204110431.SBvb4g5G-lkp@intel.com>
X-Forwarded-Message-Id: <202204110431.SBvb4g5G-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2P15301CA0017.APCP153.PROD.OUTLOOK.COM
 (2603:1096:202:1::27) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45b69582-5ffb-40d3-4424-08da1d29bf70
X-MS-TrafficTypeDiagnostic: SN6PR11MB2653:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR11MB2653C7E96F054E2C01AF8B5EFBEC9@SN6PR11MB2653.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgO6H2NCZIurMpRQstade7Jdaj6uzlyIZ5mZn/KxRHndfJvd8x5z0SXvnnKqkolRR82qhlgAi+cMSXBis0v33CCT8Jvp54yMUym6vqrOY+hb2+1rRxTH7QNJRRY/sdDF81PeqKPy4eaM3gcFMh5TW6xhEkM5+QwVoHD+uCshPf8wmrfIGwwdJTqAlBNOZ/c5n7EMWkFZMHt6/EP5JniwEmL+jXYE4/3ghtPK3C6OUGL0dtheJ68YI7BUK6/fxreMxg4p3hVRZ6lDvnhpTNPSSCAJy25lm16jLUcig6vmB4aU0K4zJojBsktRQHlMHNj83ibo4/OgMk7hDBIumv5EqFKIL0BgFEbzaVhzaCcXT3z0sm1n6DhhQd/CttOIUFD1PORCHNEXNj9AqceDJZnJdNvKVH69iYXcaFN9W/m7zPGob1K2r11GCb3xoBwIpjBDCUvHNyHC4tB2np6BXoJhQ3qrxJSjjHzErWN4lYwMkynwdUGYCpDeO/RhRmm7CI6Lrou3BN8rlp557ZWoBrEoEzZNuDfxBRnyvO3eRgpr0pvRdl7aSPWyPTGG11+SfAzPPch8S3SX1JTzXRC6o0/NATYFS9XIEaVYl721ixeNhwcbg2cbORQgNrY7UZl0aVOkUASSwtPGDkzCY7EFBKj0USRKUx3o2q2omGhqLA7219BQdVoOgkBYt1ePgep/I0i19yymd3OMuh6y4C5otomz/doDvaRnneDwrrStZEyzireIpj1nfZZ/Q/Li8jfvd6ldSU8AWfz/IFlYwozFqGf7Z7E8kMwciit4B/pF8SYIiJa/3VQL+uKzlXvh6E+xtSOKNrEYJRyvwGMcqd+8d59QXucUgeT7urjbafygvOQWTyU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(8936002)(316002)(38100700002)(66946007)(66556008)(6916009)(82960400001)(31696002)(8676002)(4326008)(54906003)(5660300002)(6666004)(6512007)(86362001)(6506007)(966005)(26005)(2616005)(6486002)(508600001)(83380400001)(31686004)(2906002)(36756003)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VENVNEN2enZOdmJWQmEzS292eVgrL0YzekFLN1hCMldzVlBrdzhWL2dhZXFW?=
 =?utf-8?B?STlFMlB2Wlg2Rm5KWkhWdTFIYjRWK3REaHp3OS9ubWR4QmhvV3NOM0I4Ukk2?=
 =?utf-8?B?YzhiZnFmTndEYllkZXQ4bEozUWlHVlNnZHdOekdvRjZQWXJZYnFzV0RiTGFJ?=
 =?utf-8?B?WE90TklzOUVyeTdudzdhZmhhYno3eG5DLzJmc1d0Vno0eEw0MEQ3T2hYZURz?=
 =?utf-8?B?WVE2NXNtcG9aTHhoendaN1FOZTgxM1U1WTRoMjc2bFJwS3pYb0p6cXR6bFdM?=
 =?utf-8?B?K1I5K3drV1hRcVdEMnA0SjFHNGhVZjVSbnlQWUtPQUUrSFoybWxhcWY4bXNO?=
 =?utf-8?B?VklISkJSNWkzeEd3LzR4LzFjTEh3Y012eENpSUFRQzdjK3lENWc1MnFSNG9i?=
 =?utf-8?B?di9lTmloNG9ub1V4MzZGTkh5akdRRlpRTjFJQm8rY1NWMGFiQzF3aXM4SUJt?=
 =?utf-8?B?dzJjbHYxajdQU1BjRXorRzJ5N1JYZUdncEJveHNoSGJONjNTRGNLMVlGUWxo?=
 =?utf-8?B?QUt5QU01MzJXTTVRaFpJQ3gwenZ4YnA0cUViT3ZmcUdVYTgzU3ltL3VpMnJD?=
 =?utf-8?B?eDNBRndTVzlKa3N6QnBidWhqNEFYaUMzSERLZmRRNFZHeUJIS0sxSmtHMHUr?=
 =?utf-8?B?UDVxa2Q3Ymp0bUVYZFJtU0g1UDhsdjVaMmdqMllFbnJlaS85NW9xR3hwb0dS?=
 =?utf-8?B?Y3AxVWRzRTVWaENqaFE0am1yUFREY0FBanV0WlN3RVV5UFk4eGE4UkdiZGE0?=
 =?utf-8?B?ay9pWkVDZjhJbUtrYlFURGpoQm8wZ3J3N205ZHdCZUQxYit5c0o3aEU5Rkto?=
 =?utf-8?B?MEp2UmVsMzB4UkJzRGdwYmJmS3ZnTmFVQXRKbEpvRXUrZFFOcnZMeTZVa3hM?=
 =?utf-8?B?bmxGM3hyejdDQWR0Qll3VFVXT0VHdkR2Z3I2VHVRMXlOTS8va05PbTBBMVZl?=
 =?utf-8?B?SVJSYXM2UzgrZUhodWl2NGh6Z2RpYjNoOVorTGd0MlZ5eGNzSktwREJCdjNo?=
 =?utf-8?B?NUFaZVQvRW95cENCdStIMDZEN3hxTyswQ3l6TFRUYlc4bUtMMitYeFl0aHZa?=
 =?utf-8?B?Rlhqa0xycnQrcUlwN29DeVh1ekd4RlNPS3JDcUg2NjlmcC93RDIrMDV0S01R?=
 =?utf-8?B?dUVxRDZScWNHVW5QS2R0eTRPOHlPVnphd2RJR2ppbm00ZTFoR1laUW9md1pj?=
 =?utf-8?B?Tk5HbzFBUHV1SDF1ZWQ2Z0gzQXlKQXZIZEF6V2xQRmg2N2JEdnVFNmhkNU9s?=
 =?utf-8?B?emYxdDlKenFsS05YM3ZzT0RTOXhtdzFhbGc5K0hlUDEvbjRjS3VENVgvQUdz?=
 =?utf-8?B?NE9vSmRrTTltSFFROS9kN3pnMHhXV0s4azlZbXhsY3k3ZXEvR2dWMTdlSmhw?=
 =?utf-8?B?cDJDeDVHSGVveG9xUUJJcG0yUWVpODJra1hnaTVQcVBkcmR6d0ZsbmFyWS9h?=
 =?utf-8?B?TmYrUDNjbjdCdU9kNUg5SUlXZUg5TWF2SjlPUU1nL2lkcTZmbUo1eU5sR3ZC?=
 =?utf-8?B?SDBCdFlvamdONmNmNlBaWlcrWldXeCs2RFBORHQ4enhLNHBTdEpJc1hxR0dP?=
 =?utf-8?B?YWtGeUtEM2xDWUVMOFZZMWFCd2wweUovSHBpNVhyeUF0OXFKdllsam53RmYw?=
 =?utf-8?B?aUJuNXloaWY0WFVUVnRGcnZxNlBRSXlFMUQ2aXgrSVFXSXFOcjZ2Q3lYTkk4?=
 =?utf-8?B?K2hDU3VjMDYwN2Z3YUJCSzM3dGxvckQxWlVJZm9GUUlvSU9PMkxlQXlsSEVq?=
 =?utf-8?B?QW5zM3NEazhCYUN4V1FDSVErOUEzOVRFV0Q4aC80aGtvOEVtSTk3Y1R0NEJa?=
 =?utf-8?B?STZ4WGJrU2x1MWtGcDlRNWxHcDRjQkVWMEZlK1BoUW9tRnA1bmJueFcxdkxj?=
 =?utf-8?B?ZXFvZXNmS3YrbFNHMDZML3dIWW5wUFZyRWVobFFHMk45c2RtVzhHSlhhS09K?=
 =?utf-8?B?WFdSek1LUytRcllkQklmbytUbU9FTHVJZVBXM2o5akxzNEozNEZPUDBmdVVH?=
 =?utf-8?B?MlU2RmZ1UFZhUi9BMFVwRkg0MVQxTTRPNUUzZG5ZV0loZ2JoVnNadEV3Y1Qw?=
 =?utf-8?B?SEVCUUhCZHpTdXBWcnRRNUhoL21LNi9HS3A3akxTemxyV2VKUllFd01HZDBG?=
 =?utf-8?B?VkpMY0RxSjBvWHNUVUNOaGFIempSNDhXK3gxTk5rMlFyL1IyS25ybG5jSFJw?=
 =?utf-8?B?WERNVXpQUC9welhDN2FXekFySGhHdHhhV1lyWm84VzVTRDZWaWtKWjhOZlpY?=
 =?utf-8?B?a2lNK1gvM2E5eEZyY0trR2VqTEt5dTlLRHdsaVdCVklWSWtWN1BQVEUrMmVB?=
 =?utf-8?B?dGtaQk1FZExUMldORHlIQkpuemtub05oVnc2aC9VRmtZVk40bWhnZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b69582-5ffb-40d3-4424-08da1d29bf70
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 08:43:57.2922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02yMpmBOqCZNA2PTD/aOyrCUO0Qn40kbHlevAb2ylLeoHKH79wh+rZAdnPutU7BgGqHrkNmV3+g+VKZWlI1qbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2653
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
head:   7bebfe9dd802b80abff5a43e00ab68d98893a22c
commit: ada543459cab7f653dcacdaba4011a8bb19c627c [3/10] perf/x86/amd: Add AMD Fam19h Branch Sampling support
config: x86_64-randconfig-c007 (https://download.01.org/0day-ci/archive/20220411/202204110431.SBvb4g5G-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c29a51b3a257908aebc01cd7c4655665db317d66)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=ada543459cab7f653dcacdaba4011a8bb19c627c
         git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
         git fetch --no-tags tip perf/core
         git checkout ada543459cab7f653dcacdaba4011a8bb19c627c
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> arch/x86/events/amd/core.c:722:3: warning: Value stored to 'hwc' is never read [clang-analyzer-deadcode.DeadStores]
                    hwc = &cpuc->events[idx]->hw;
                    ^     ~~~~~~~~~~~~~~~~~~~~~~

vim +/hwc +722 arch/x86/events/amd/core.c

ada543459cab7f Stephane Eranian 2022-03-22  712
ada543459cab7f Stephane Eranian 2022-03-22  713  static void amd_pmu_enable_all(int added)
ada543459cab7f Stephane Eranian 2022-03-22  714  {
ada543459cab7f Stephane Eranian 2022-03-22  715  	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
ada543459cab7f Stephane Eranian 2022-03-22  716  	struct hw_perf_event *hwc;
ada543459cab7f Stephane Eranian 2022-03-22  717  	int idx;
ada543459cab7f Stephane Eranian 2022-03-22  718
ada543459cab7f Stephane Eranian 2022-03-22  719  	amd_brs_enable_all();
ada543459cab7f Stephane Eranian 2022-03-22  720
ada543459cab7f Stephane Eranian 2022-03-22  721  	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
ada543459cab7f Stephane Eranian 2022-03-22 @722  		hwc = &cpuc->events[idx]->hw;
ada543459cab7f Stephane Eranian 2022-03-22  723
ada543459cab7f Stephane Eranian 2022-03-22  724  		/* only activate events which are marked as active */
ada543459cab7f Stephane Eranian 2022-03-22  725  		if (!test_bit(idx, cpuc->active_mask))
ada543459cab7f Stephane Eranian 2022-03-22  726  			continue;
ada543459cab7f Stephane Eranian 2022-03-22  727
ada543459cab7f Stephane Eranian 2022-03-22  728  		amd_pmu_enable_event(cpuc->events[idx]);
ada543459cab7f Stephane Eranian 2022-03-22  729  	}
ada543459cab7f Stephane Eranian 2022-03-22  730  }
ada543459cab7f Stephane Eranian 2022-03-22  731

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
