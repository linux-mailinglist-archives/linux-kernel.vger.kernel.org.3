Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D13D49F3B8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242629AbiA1Gf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:35:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:38837 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231443AbiA1Gfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643351754; x=1674887754;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XJiOeGNV9xAHYT9ZbL1NGojStHmJ4c6CX5pwjWrQIi4=;
  b=KS1QHAtGRGLoxTdEVDNdcec2xR5IlnyuSu5f6KOCy8sFCPl5BdlhEF2J
   v9ETQ7WaHoYVhsHWjEuKyMrtLLTyUNbtrj2tpkbV75DkYIcnGQdSGeXpJ
   SuR2MmP9uDG8dDaw/ULvSHQBzHRbXB1AiB6bEZAyBZSaeDFbkIp6nnlki
   6ZQ8gP/JChyGV+DiweJDRvSQ6pKjjrWCNqWXYV06Ggdo+A+yW0Rd1/Jtu
   fRxzO6J/VwcyhKkG6z9Vi9PfZPxQmADASR/F9HkbpsQAFf2r/dLkV2Qt1
   1EeJsHF6mg5PkE+CesxQltW+IOQwk1jlc4K3W8wMrLyCjl0rV7PZZM9Bx
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="230635901"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230635901"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 22:35:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="696986891"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2022 22:35:54 -0800
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 22:35:54 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 27 Jan 2022 22:35:53 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 27 Jan 2022 22:35:53 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 27 Jan 2022 22:35:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0V/autr6TGuNbSC05x+OGXqGfODBBYhh4d5dS4nbOTwLTy12Bd1D79K+hQS0bVVAoVn3dQ0sGpCERsE2BTTlTMv1XmcLzTbe6tJhdq1RSDXGlqb8deHFwOIAC8ajQjEz6a0tdjGPqG6ejq86jcgx1vn/J/E18rQXRa0Y6CpiOXhTjSiJ+DkVXsXqNvAcOHBMTKWI9J0L+m0+gNW52GXaTZa9EwEiI+XuFpeRxlIqD+Kp+0K4h3vMuUOMrR3mDvQbQFTVbcgh6756v7v2UJMDGHidtT7od41htuznEB1O8vTvkiT/RaPgGS6xIFTy4Yy8ry2JNkuHkiMRjbGlcI06A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtOYY7cASLFnXVkkrxOHBqVwqFo4n+fOgTvBwuXzAxg=;
 b=JKFhL7/D7cspT+QpODt7jG5mCj7XNOFrVpKuv/2YJ2yz3CMX1nvtOKMxfvm8LuvsTMwXzgFk5u5UGlTLnCSyJ0MkxHTfGrqh2jLfomhBMEZXa3cTdYX6YifadhGU4zMcY6itMqyx1WgnO1qbj7PSR/6g9iOHcZ2WQ+1VMBa5w3A/jCm931dD1kuWVFKsgSQ9uWPXcXly5QGYD5FSi0yzLw/fpTuoa29GRTe6jWdl55o+KEU3SpgUOoo9CqJfQ9Tv9ew+KWb9Mxd7+diIIM9O+d7PwZP8RjtLeLVT+MvT6UV12xJg/8fuC4ruFvS7FKubUqJ4qoRxdRdpScrXdsnAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com (2603:10b6:a03:304::12)
 by PH0PR11MB4949.namprd11.prod.outlook.com (2603:10b6:510:31::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Fri, 28 Jan
 2022 06:35:50 +0000
Received: from SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d]) by SJ0PR11MB5598.namprd11.prod.outlook.com
 ([fe80::c4a2:d11d:cb7b:dc8d%6]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 06:35:50 +0000
Message-ID: <2987043c-b844-fd37-ff63-e8d2dfc48b93@intel.com>
Date:   Fri, 28 Jan 2022 14:35:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.1
Subject: drivers/gpu/drm/vc4/vc4_crtc.c:671:34: warning: Value stored to
 'mode' during its initialization is never read
 [clang-analyzer-deadcode.DeadStores]
References: <202201272128.DIJ3q9rg-lkp@intel.com>
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>
CC:     <llvm@lists.linux.dev>, <kbuild-all@lists.01.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202201272128.DIJ3q9rg-lkp@intel.com>
X-Forwarded-Message-Id: <202201272128.DIJ3q9rg-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0151.apcprd06.prod.outlook.com
 (2603:1096:1:1f::29) To SJ0PR11MB5598.namprd11.prod.outlook.com
 (2603:10b6:a03:304::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9830622-791e-4e36-d0de-08d9e2286cf6
X-MS-TrafficTypeDiagnostic: PH0PR11MB4949:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB4949CEBD9C6A824CC71A1EEEFB229@PH0PR11MB4949.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RhEFs3LmkPx5siA50dcztqJ5EbNUFcnnBSvJzRjc7LP7cjHmOBek5wk1f8/etZMxzlvSraouvf5W8AqntZUUBRP91N4Y/AvM4mfJ0BnBahfrlIekZO/FaujetKNQcAS/H0m0YEjNH/mh19JVw//UyMEavWLnoIDbjvSz45fRhI0KSxtCOrteMPBgy2UbNKAB3xwlIDlGml/sj+dyqvcCgHiBBiI6cpVNXuOZzwbcNdMrmn1Gx8YBmre6hv29LUwOmVTtxGYPXCHIU3YXcqa82vE4kKY9I4IU/W25C5k1u9xk+dhbewXnvx4GKLd87vwtvWVLHKbRgl9WcEPaIb79NmdxGtDcE5z+DU1W6i+ZovZBpKslRg/AdovnOEh8nMgPSja9ZpGEzU6QwY86pnX3s/483mZj1m2Uf4jKaP7bDXzG+9Of/Mmjnin9ojRJ8Mu8rSSD5jCpOggCOJF9yvMFRLUduwMSqICq1RrCMaT6q0ZRZqq59Sdbi1WJZDQ8jJGVInmoPNiXCop0L6Rwh7FyVvZHOqRjvUH1kpcsCacfZQRZ/c4/S+QKGor4b3snhZULb4UjnMzkZgtkMRT+6SN8Hga+PodgrLsZpq1RH+iVsWgF4QX0C0S7iuSvcs4f1f0VWL+f4Xf2wtc+RHRrrZMUpDS4yBbQbNA7WDJRJOQ6T0cxhx3880947e8q2zYiGcGqyXg0jk7iM78c/urjsZmQIXd2bPFqlpKA7/IA9QUEGNSjjwpGFYyCoDWUSBLksbPFQRARyxLKOKTxGalWEH9E22Ln8MGSHO/cEshyu9a//niQw6qXqrGCPgThZobuJGKu6zlS3z2hlmvJliloIQwIqbAYkfrJGkFKuiY8JqRXq6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5598.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(31696002)(86362001)(82960400001)(66946007)(66556008)(66476007)(8936002)(8676002)(4326008)(316002)(6916009)(54906003)(2906002)(4001150100001)(5660300002)(83380400001)(186003)(6666004)(6506007)(6486002)(966005)(508600001)(2616005)(26005)(6512007)(31686004)(36756003)(45980500001)(43740500002)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TS9tbUJIUUcwUGpJOXUyS1B4b0tVK0tTQjVPWGtITFNITlhsWFprQ0xjeXpX?=
 =?utf-8?B?bDlSdzQ5aHFiQWdET0MrUTBpVnpLK0VZT2J2UnhydldmZU1FbjVPVHVtemky?=
 =?utf-8?B?YktVUUVWcCsrdkgzS1hFVGdGTWlFNnl6bHRPSzlPaDBZVFRqWUFZZjdod01J?=
 =?utf-8?B?VmtqZktZV25UNHQ3em03ZFE2Z1pyYkZCUEN0ZGUvUlh6emhCY2Frc0JVVm1p?=
 =?utf-8?B?WUVqa2htTXlDNHhLdW1jcmlZL2pqVzBjTlRYSHBJVkN6eXlwNFNRMnRkNGR5?=
 =?utf-8?B?bmYyWFdSQVVGK2ExVHMzcXRMSU5Hc3hrK1dYMHN6dkozTjFPaGhlRndjMmRK?=
 =?utf-8?B?cjVWL3QrZDNHelpZeWtFdnZXUlpwZ2Z3b05sa3JxUEhoVTloMlFVYitvUjZ2?=
 =?utf-8?B?MkJjenJ1ZnlZdnA0Sm1RUTIydUtTUnVFZnhFMWp5eVRPbngwWHNTV25Wang1?=
 =?utf-8?B?QmlCeHVlSGFiaFpPV1NIT0NjZHBVaUZnNzgvMjdSV2VJczgzNmRETXpld04z?=
 =?utf-8?B?K1pVTldlYXQyUDFkSlBZcnBuNkxlT2svdFVEZ09iY2tpZjRKRlJmNlNNLzlm?=
 =?utf-8?B?RmRCd3hVVVpNWDEvZVNvVDJKckxNL0wyK24yQnkvb3JKMlMrK08xZktCd3A3?=
 =?utf-8?B?NlZSSWZzTU44UmZJbmhEcjA4eDJHR3dFT002MWFCOVZpOE84QXVpUU5hVU9N?=
 =?utf-8?B?ZEVDNnlxS2NBVzhMSC9nRTAxTmptSjA1aE1zTS9wMWk4UzEvQ3pIMXU5a2tW?=
 =?utf-8?B?dmlMUEhCb0dxVkdCZmNZZkZjQ3h4WWtBRXYza3ZFNzFqUHBVbzMxNjJxUHgy?=
 =?utf-8?B?TmNjU3VvQlJnVUtRV0NSRzJaREo4TFRlbUhCajhVWkxwaWhVVDhUSm1BWUc1?=
 =?utf-8?B?bGFvdytpUkVydXpMb1QyeXlyN0JqZUxtQzVBT3ZqdjVzeEw4RmkzaEtHMGp4?=
 =?utf-8?B?SFZ5VU1HaE0zdE1ZWFFSZVR6R1B5TFBoOXBENlo4cmxMMFdiTzVIdHBXc0pa?=
 =?utf-8?B?NnYyTHRlcm1oSnplbkNVK2NmNFVNbEJ6aGV5MDN4bWxrUmcxc21tanRnSkxS?=
 =?utf-8?B?MkdaV1NWbVhFc1U1N2x3Q0ZBWW52OGVzQzZBU0hmYlNKSVVzbVBsYnh3MFJ0?=
 =?utf-8?B?UXBJVXloczE5MU05aXhuanZNRlNYUCtzZVNaYWRSZXcxUHVRSlRxKzhXR012?=
 =?utf-8?B?cCtKNUxlMmV4U3ZCMmJTcTcxUHhBbEJGbC9uQUlIQ0pKNGZLR0RNU21kbDRW?=
 =?utf-8?B?cVA0WGdRQ0dmcmt1QjZaUHdDaVkzNUI1bmdlVndISXNvT01YYjg5VGFVOTQ2?=
 =?utf-8?B?NjEwVVhDVitmd3NsRDdsMUtMdWc2dUlsZEZMSndjRlg4YWVqS1p1UlF0c3kz?=
 =?utf-8?B?K250MmRocG44YjFkYU1ZbnhraUg5TitpZEZxbUtCS0RxL2RTZ3lQZ0JDaEtO?=
 =?utf-8?B?aG1ycFNNYWhMK0piMUJYMkVWSXpzZUhxN1RFOFRJYWlYdmNqMnJuL2hNVDNW?=
 =?utf-8?B?dDJEOUY4bStEZ1lTZVRhMEprTGFRQVVqT1o5cGFucm1GRWVXWU51VU5jQXQv?=
 =?utf-8?B?QWE4bjdIazNaWDluZEhCQUIzR3R5OVpYM25MeGR2V0F3MEdCOVRPV2NLcmI1?=
 =?utf-8?B?UnBkak50VFBYcFdRNWpQVDFlOFdIN1JRdXVKQUFVQlRPNjlSMVQwUzhCN0Rm?=
 =?utf-8?B?Q1crK0UzTFFJNlVTODJkQ0NZbFJNU2VEdFllTXluRjhRNDRzVk83c3JsajNQ?=
 =?utf-8?B?T2FjV3ZMa3ZrVWMxYS9XR1I1c2x2QW1XV3JJWjMveTFhSE1jMTJ3SThldk9Y?=
 =?utf-8?B?dXlUSGtqdXhDaEtEd3JsWmZ2eHViQXJhTGFkSVA2MDNPNFU4ZENHOEF1QkIy?=
 =?utf-8?B?aU40eXBBTkJVSEFkbmpRZTk2ZWxMd0xDTnM3T21Ta0ZRYnpSR3BhZjZiTlBQ?=
 =?utf-8?B?emFpb0kxVHI2d1FWUzZQa0ZRbGhRM2hGV3cxbXNpYVRvUnBMNEh6WVJMeUNF?=
 =?utf-8?B?V2l0akR2aGtpSEg1NkNVSVBwb2syc1dRdFpYZmlZSG43SzdVcXdiM0ZzaTgr?=
 =?utf-8?B?U0FUU3dnS1NzRVI1RjZDbGxDMUphL1dWVGhBM0cxQkdDRGM0OVhLSXZtVnB4?=
 =?utf-8?B?QTBtQ3VxYUxsdDJtT3QzS2tVa1B2NEhGc2hkYmlXbkE1VEdvcFRybExOMUZl?=
 =?utf-8?Q?N9scxo/ptzQkkhAMyTyKqJ8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9830622-791e-4e36-d0de-08d9e2286cf6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5598.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 06:35:50.8863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TL6hjx9i6IDmZ3/WPrt+TwuOAizVa3bWv5M0QcsTo6d9+gvGUdb7fN6g4Fg6kPuZX0Jq+zX8+WLaQE2fwx4CRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4949
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0280e3c58f92b2fe0e8fbbdf8d386449168de4a8
commit: 16e101051f329f5f3f2dd810f3687d166580aa3a drm/vc4: Increase the core clock based on HVS load
date:   3 months ago
config: arm-randconfig-c002-20220125 (https://download.01.org/0day-ci/archive/20220127/202201272128.DIJ3q9rg-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 997e128e2a78f5a5434fc75997441ae1ee76f8a4)
reproduce (this is a W=1 build):
         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
         chmod +x ~/bin/make.cross
         # install arm cross compiling tool for clang build
         # apt-get install binutils-arm-linux-gnueabi
         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=16e101051f329f5f3f2dd810f3687d166580aa3a
         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
         git fetch --no-tags linus master
         git checkout 16e101051f329f5f3f2dd810f3687d166580aa3a
         # save the config file to linux build tree
         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm clang-analyzer

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <yujie.liu@intel.com>


clang-analyzer warnings: (new ones prefixed by >>)

 >> drivers/gpu/drm/vc4/vc4_crtc.c:671:34: warning: Value stored to 'mode' during its initialization is never read [clang-analyzer-deadcode.DeadStores]
                    const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
                                                   ^~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/mode +671 drivers/gpu/drm/vc4/vc4_crtc.c

666e73587f90f4 Boris Brezillon 2018-12-06  653
c8b75bca92cbf0 Eric Anholt     2015-03-02  654  static int vc4_crtc_atomic_check(struct drm_crtc *crtc,
29b77ad7b9ca8c Maxime Ripard   2020-10-28  655  				 struct drm_atomic_state *state)
c8b75bca92cbf0 Eric Anholt     2015-03-02  656  {
29b77ad7b9ca8c Maxime Ripard   2020-10-28  657  	struct drm_crtc_state *crtc_state = drm_atomic_get_new_crtc_state(state,
29b77ad7b9ca8c Maxime Ripard   2020-10-28  658  									  crtc);
29b77ad7b9ca8c Maxime Ripard   2020-10-28  659  	struct vc4_crtc_state *vc4_state = to_vc4_crtc_state(crtc_state);
008095e065a85a Boris Brezillon 2018-07-03  660  	struct drm_connector *conn;
008095e065a85a Boris Brezillon 2018-07-03  661  	struct drm_connector_state *conn_state;
16e101051f329f Maxime Ripard   2021-10-25  662  	struct drm_encoder *encoder;
008095e065a85a Boris Brezillon 2018-07-03  663  	int ret, i;
c8b75bca92cbf0 Eric Anholt     2015-03-02  664
ee6965c864e3f5 Maxime Ripard   2020-12-15  665  	ret = vc4_hvs_atomic_check(crtc, state);
d8dbf44f13b911 Eric Anholt     2015-12-28  666  	if (ret)
d8dbf44f13b911 Eric Anholt     2015-12-28  667  		return ret;
c8b75bca92cbf0 Eric Anholt     2015-03-02  668
16e101051f329f Maxime Ripard   2021-10-25  669  	encoder = vc4_get_crtc_encoder(crtc, crtc_state);
16e101051f329f Maxime Ripard   2021-10-25  670  	if (encoder) {
16e101051f329f Maxime Ripard   2021-10-25 @671  		const struct drm_display_mode *mode = &crtc_state->adjusted_mode;
16e101051f329f Maxime Ripard   2021-10-25  672  		struct vc4_encoder *vc4_encoder = to_vc4_encoder(encoder);
16e101051f329f Maxime Ripard   2021-10-25  673
16e101051f329f Maxime Ripard   2021-10-25 @674  		mode = &crtc_state->adjusted_mode;
16e101051f329f Maxime Ripard   2021-10-25  675  		if (vc4_encoder->type == VC4_ENCODER_TYPE_HDMI0) {
16e101051f329f Maxime Ripard   2021-10-25  676  			vc4_state->hvs_load = max(mode->clock * mode->hdisplay / mode->htotal + 1000,
16e101051f329f Maxime Ripard   2021-10-25  677  						  mode->clock * 9 / 10) * 1000;
16e101051f329f Maxime Ripard   2021-10-25  678  		} else {
16e101051f329f Maxime Ripard   2021-10-25  679  			vc4_state->hvs_load = mode->clock * 1000;
16e101051f329f Maxime Ripard   2021-10-25  680  		}
16e101051f329f Maxime Ripard   2021-10-25  681  	}
16e101051f329f Maxime Ripard   2021-10-25  682
d74252bb8f0e38 Maxime Ripard   2020-11-02  683  	for_each_new_connector_in_state(state, conn, conn_state,
29b77ad7b9ca8c Maxime Ripard   2020-10-28  684  					i) {
008095e065a85a Boris Brezillon 2018-07-03  685  		if (conn_state->crtc != crtc)
008095e065a85a Boris Brezillon 2018-07-03  686  			continue;
008095e065a85a Boris Brezillon 2018-07-03  687
666e73587f90f4 Boris Brezillon 2018-12-06  688  		vc4_state->margins.left = conn_state->tv.margins.left;
666e73587f90f4 Boris Brezillon 2018-12-06  689  		vc4_state->margins.right = conn_state->tv.margins.right;
666e73587f90f4 Boris Brezillon 2018-12-06  690  		vc4_state->margins.top = conn_state->tv.margins.top;
666e73587f90f4 Boris Brezillon 2018-12-06  691  		vc4_state->margins.bottom = conn_state->tv.margins.bottom;
008095e065a85a Boris Brezillon 2018-07-03  692  		break;
008095e065a85a Boris Brezillon 2018-07-03  693  	}
008095e065a85a Boris Brezillon 2018-07-03  694
c8b75bca92cbf0 Eric Anholt     2015-03-02  695  	return 0;
c8b75bca92cbf0 Eric Anholt     2015-03-02  696  }
c8b75bca92cbf0 Eric Anholt     2015-03-02  697

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
