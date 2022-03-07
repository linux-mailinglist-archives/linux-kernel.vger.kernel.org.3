Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8FF34D0916
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 21:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbiCGU5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 15:57:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239402AbiCGU5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 15:57:10 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CD433E95;
        Mon,  7 Mar 2022 12:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646686575; x=1678222575;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=65ds+OkJW0qBAc4u3KZtn8jt7NgPxkLOLJOKDOE6hVU=;
  b=gN/pHsfkL/ttXdGf/sLug7ikNj998vByJhAgMnYpZSNHft3RFbOThwix
   X3z366dyM7a1uOGfsduaZc8Z0cFdgIgm4oyfQjGqhgl3D46mi1hweIkSb
   fHWfwcSjh0tFvjdfqIq73qeOEN/2grQ0aCwzwR7G12yrlsBG8Apm184DQ
   98MdTrDzW+RttfPUvpoGQQ7PANiUu7JkTdtT8FPt2WaUEJSJAuHoVqOD4
   PfOAEOd5qisz8lHVfxCbBkjmon/ab2MH8rHdzXUtP9doQIJ9bcZokzhkW
   OrwJM1VT/5TrAfRhZKvySFRbiV339nlD7/g1wDDy+ydOejVr16WvpXS5i
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="234456791"
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="234456791"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2022 12:56:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,163,1643702400"; 
   d="scan'208";a="512829866"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga006.jf.intel.com with ESMTP; 07 Mar 2022 12:56:15 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 12:56:14 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 12:56:14 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Mon, 7 Mar 2022 12:56:14 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Mon, 7 Mar 2022 12:56:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aTbRA9XMaeNSfXOrLbmtxDWLVnBFR/mjBrPRVFsGdBH4NcnIv17yaJLcxSUD6bJgVkptsntoYolkb3b9Z1NNAQ+ajB/nJse5gM+a2BFqxmsOArPwscfrVh8lDLFdYs5Ztz7h8lCejtNAo8JSeZ4PHoO1csRj/nuRoGz1XL3TcBdHEaq0VXBHMhakGykzZ5iZzphBLRpt434OUIoYbqsDTGCU5w0+tt18lo3YgD6Scr+wlHy1PRe9oCWw1ZRK9Q0ozTwp8/rQlh2pnpLkOU0evDaeynJmruud8jMre3Grb5n5QzT6RxJc/eFgnDz62FBwUJxXcHgf4fvwzxPEO6NgoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybdKkd5t7Kd3eJqnpGWk4m+tHD/9sPNFmiq/DZEDmZU=;
 b=WktfyjNA4CgqXQPgdBBklmMR2TzsZezpvqdXPzjF03AMWHnAPpoqiVGlrG0zNXqQJbmies3CiL4xi5Hm5FJSIBDUUc2RwyYVjxZmIzBY9GK+k/qfIBoOWWsXiUDgXa5M9x0wbNTUlzfyFPOI6yG93GHlvkE9lOZkGi2ggvLa1JP97enWhmjdKp9Mt7mCfZAdWFe+I+9+77b+oyIDC3y2Em+PZJs02yx0GFcKp+9XzYRodJbg4K1T1oLmcCZccN1UYZVOd4uBJ5EYFS9LfB6EhRLW20iVQoVdBYYOf2vD0WU+jxxYTHCn+F6XlN9YfXB6uc4d0hlxuBqlEvoqRgwkag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3768.namprd11.prod.outlook.com (2603:10b6:a03:fa::20)
 by CY4PR11MB1959.namprd11.prod.outlook.com (2603:10b6:903:122::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.20; Mon, 7 Mar
 2022 20:56:12 +0000
Received: from BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee]) by BYAPR11MB3768.namprd11.prod.outlook.com
 ([fe80::dc03:366a:dae3:aee%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 20:56:12 +0000
Message-ID: <eab8177d-eb73-ec64-ec1f-4f2a51be8aee@intel.com>
Date:   Mon, 7 Mar 2022 12:56:08 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [RFC 08/10] platform/x86/intel/ifs: Add IFS sysfs interface
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
 <20220301195457.21152-9-jithu.joseph@intel.com>
 <188492dc80c017375da76d444347b1d00c2031f6.camel@intel.com>
 <7b9c788e-21dc-eedc-a1b4-9c6877fa48fe@intel.com>
 <CAPcyv4h=qPFrP+mRqaZhkh5ZmYjuQawsqvf+-R036ZJVKBNK4Q@mail.gmail.com>
 <33d0e764-86d9-8504-17fa-14b31c87de4e@intel.com>
 <CAPcyv4g5bq9+u0iLjhpeJw8bkbCREUw60H2z_KfDz4hHCrKdFQ@mail.gmail.com>
 <7c620f8a-189e-5ac4-30fe-1fa14ba799ea@intel.com>
 <CAPcyv4iUuZ0aAWckWvwbxJJgt5tDJRpeonfE4DegWS6KPtJq8A@mail.gmail.com>
From:   "Joseph, Jithu" <jithu.joseph@intel.com>
In-Reply-To: <CAPcyv4iUuZ0aAWckWvwbxJJgt5tDJRpeonfE4DegWS6KPtJq8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0219.namprd03.prod.outlook.com
 (2603:10b6:303:b9::14) To BYAPR11MB3768.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2991fbcb-aaa4-4ace-465f-08da007ce978
X-MS-TrafficTypeDiagnostic: CY4PR11MB1959:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
X-Microsoft-Antispam-PRVS: <CY4PR11MB1959BE1A0FF049BB2173A29480089@CY4PR11MB1959.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Rn/CT0a73YdjhvmfJ0zYuGuLHnWh/ReP9MLP1iK1Zv3MzuN6qm19qvrH0xwFqaSvLnzDULO6goCZwKPLBbegKJGnSg1viSt3A6trqhowT87FDA/uaj06k/wlxK9rbKsE3DqVwK1q1yUHH3oJqQUh3m8mdIlj/A9LhpkG109cISprduiiIVi+rNSg3STE070NvnIHtYMXwDQAh0nRnQBbTZTK70SsAUbBMiNxOVS3l78GgXIrCA0iMavaZNPAkJ7bZol9l6UOCCL6c9H63Rg0HNLIlVnaih8PYHCEXtI2KwpR23UV8dPbgDSvJN4nLF8nziBmaL80g3zTkNMJKrIOQctLvXhm/fghCoqXdM6UtxwqlCRkUVACgsczZqzWNWVQxjfzzlzUAo3PF5pxknIxMgusTAh+AeIvFLaATLOt402ew5zovf0bHvEXXWKbjldWvdG1fQ/S+1K9elIUdYS9XHeyxNUDelqw8RqwiAS7HS4Z4waQ6xdP6IxMjt9L2pAyQNacno4m/HbDtUFsSaFeGpCM4vWuGLWxEeQdhhaFer9QxqUaJDkhm1IU38PbfsW/HZrRafFYV/QQEBsZn/nF/1cauuvTlHvqh26bAY+FoXbSspdcxV1pNTaESaSEiVGCo85hAHgGoBIHpZEVSPhA5KJAoLqn08UwKPz1xRo7BnoXQg6qOkPqfd9JLkZ/qaGExpv0z+Umxf1X8Qd/gN2KWXay7di04FMwd/e8e2oC10Wi3wn66Um9YSWertddnSm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3768.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(2906002)(2616005)(37006003)(7416002)(26005)(5660300002)(186003)(83380400001)(86362001)(508600001)(31696002)(36756003)(66476007)(4744005)(6636002)(6862004)(316002)(54906003)(6512007)(66946007)(66556008)(8936002)(6486002)(8676002)(31686004)(38100700002)(6506007)(53546011)(6666004)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXZQMzVZMzR3THdBTU9vck9Za0ttdkk1ZFB4eHVYNXdKUFBlZ0NVU2VvYzJi?=
 =?utf-8?B?OCtRcndHTW1uUTBaNXdkVXRvSVRVbDVHYm5TLzdkNW5RR0tPQWkvL2JueERo?=
 =?utf-8?B?aXRuUVVVS21oU3pyanU4YlpabEg1TUl6TUUyNGtMd2pDU2ltUENiUVNzR0g4?=
 =?utf-8?B?VkFWZEZJRHNQSjNJUVpiRkdoQlNmc0xKR05HNnpuQjIzSE5YYWx4YWNEQjE3?=
 =?utf-8?B?djhXRk5Sd2xIc3FhVW9FSDhqRDd1MUQ3NE9UeGpnendlMGFEY1hOWEVOMGFh?=
 =?utf-8?B?SXdEaStHZjZmaXJYWG9wRXprTXc3T1AydEUxVWowdXJLVVJxMVVLcFIxWXRy?=
 =?utf-8?B?MGROMkxZWHo0b3ZQbVhyRkZQVFFrdDFXUGFOaU1DbzUycVZiaS9BSXgrZVMy?=
 =?utf-8?B?cVNQbWJhaW9zMWFxZ3Q0SVd1QmNGWTJtQnVMbVVjbVpmSDFBZGtsdjh6NEwr?=
 =?utf-8?B?YjZZS0FOT3JPZ1ZmUU1ycnZRajYrd25wVTQ4aVZadFdnbCtiN0wvd1BlM2Nn?=
 =?utf-8?B?S202OUk2OTNWUkYvRjI2ZkRPNkFhbmo5TEdIVVErMUxUNXBkVXhjVWprREho?=
 =?utf-8?B?TGhVKzJ3NGpadWRRSG83ZnpacjVtR1VGVjUvUHpTUzJlakVHaTBESVdWOGIv?=
 =?utf-8?B?YUwrUGJjRENnWDFOYW5FQkRXMi83bTM3SGNXUllTbk1tQ0cxclM4T2xpKzRw?=
 =?utf-8?B?ME1YZWhoR0RDZU5EUTJuaVVkS2FISEZYaXN2a25RYmNXNU1SQTZHdWdBYXgr?=
 =?utf-8?B?MVlOZ2VDR1RZYURzWmMxdzVFa21hMlV6QmwxM0p5VWhnK0JWUlc5R3ZIUDNj?=
 =?utf-8?B?UUNJTWlTK1pOd1lRRGFhZ29NZGhzQ3U5dFg0bVYwNlFmZkd3anhVS0Qvd2s5?=
 =?utf-8?B?cWl4MGorNmhEclhzRjZPSGdXemtRNHRCQmpRTzROY3BIQnFPWlQ0RzFLYXJM?=
 =?utf-8?B?SVFLYk9jbWRiVlRubkNPcVkzQTUza1ArR3FZTm94eG9DS0c4RWNseWlwckpY?=
 =?utf-8?B?SUg0cmZLbnAvQWFzRmVpZkxkTkgvSHpqeEZqcG1leTZnVXZ1czRaOGhzaVMy?=
 =?utf-8?B?UEJEOVhVZkpuZEl0Z0kvTTN0WkdIanRTcTd5SlI5V096N29YYzh0ejBSUFVx?=
 =?utf-8?B?NG5OVGtHVnk4SGRMNUpUM2JDQmFzd1RFemU2cnhJUC9qWnYrZ2YrdVRZTDI2?=
 =?utf-8?B?MXBlMnNiNTF3c05vaVg2NWM4bDlsemhIbkc4blVTS1pHdkVWZFY0WlRjTFZQ?=
 =?utf-8?B?dmM3NnMzMVE2OC9xNTZmcDJsTEhCSWxPcDBNQnhMakFxVjZIZ3huSlcySzhi?=
 =?utf-8?B?NGJDekxVU0x5NlA0ZGg0SGVDSHF2N3FEby9nMTdGbm9MVTViYmtNNEV3NkJV?=
 =?utf-8?B?VmtLV3pXaFgwUitSaG4rS0hWeUVwMk1GSDhKSlREZDhEaEc3dzZzTTlIOGFJ?=
 =?utf-8?B?dUZtQm14a044VVlWNkhFSWJDWUgwZTJyRHpDNng1eElNdzR6R2xhNGJWRENt?=
 =?utf-8?B?Mk1KNGY4UlJPbEV5S05HVUdkNnN0NWdhYjFpVGZMN2F6cVVtSVBkbXNURlRH?=
 =?utf-8?B?MWhFQkkwa1pFZlRnQno5UVBBNEFUUzZpK2RCYkUrRlRxUnVna3hETE93MWhn?=
 =?utf-8?B?UjlORmptZWxxaXZoSHNXaVRsbThva0VEVGhMU21sWjU3aUN5d0NibWlCdlF6?=
 =?utf-8?B?ejMzck5OMWVnUDB4MjhzcktYalpxUlJaUUgrZFhabjc0YjlYUUlYNE5XQ0VH?=
 =?utf-8?B?R0J6c0VmM1NJZFVBRVZKQXowSUp5dmhLenZWOGxaN1Rib2wwMUZlcWlubnVn?=
 =?utf-8?B?Mi9ENHhBNDY4ZElJVUxMdlpld1MyVisrNGdYa05LUXZrZms5N1h1Y05hK1pu?=
 =?utf-8?B?N0FTQ0tTM3cvVFdqckFGY3FGcjNkTlFkNWpYdWFnVjlQeUlrYW0xWG1Tb1VS?=
 =?utf-8?B?S3JlZXRNYVRnY1NnYUpqbDczSERrek9TdmNHTGRWUXB3M2ZIQXpDRWo3WS84?=
 =?utf-8?B?TnVxdXRrcm43YXBFMnhwaWFJZ0c4TDcvMExDbFFuK0NNaEJVb3R5SE9nbS9U?=
 =?utf-8?B?aURDMGgrWU9VaGpiMHhYdCtPdHNRSGNpd0xLaEljNWphZVJoTWhEbndHSVlV?=
 =?utf-8?B?T1JvMVBFdTZTMHU0c2ZpSWhqNWJhN2FQYmxFUDEyK0RjRW5lZnIrRWhlQUVa?=
 =?utf-8?Q?A4lBqaDrQ33WRaekrjuCv1s=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2991fbcb-aaa4-4ace-465f-08da007ce978
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3768.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 20:56:12.1920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ukiGRtEVP9DpLju4NqvJKzzkbKWRgJ/61AG5w8I5EBYuHN5yyKhKBxvOAgxu6jBgv/Cnk9RYt3DTc6Cl9nucZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1959
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/2022 12:25 PM, Dan Williams wrote:

> 
> I am speaking of the state of the case where 2 threads are doing
> run_test and polling for results. Unless you can guarantee that run2
> does not start before the results of run1 have been collected then
> they are lost in that scenario. No amount of kernel locking can
> resolve that race to collect previous result which would not be a
> problem in the first place if there was an atomic way to log test
> results.


Yes "status" shows the status of the latest run. You cannot get the status of the previous run.

Also some context on test frequency: Hardware has  strict rate limiting of tests.
Every core can be tested only once in every 30 minutes. So it is pointless to test at high frequency.
