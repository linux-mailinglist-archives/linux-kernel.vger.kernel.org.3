Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B9D571274
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 08:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbiGLGsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 02:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiGLGsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 02:48:51 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAAC15A22
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 23:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657608530; x=1689144530;
  h=message-id:date:subject:references:to:cc:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/hb8RGw0ZEAxanNaaRq/+lLKAECdSgOnVJr9qKiKUY0=;
  b=k0O2M/MsCgIwEEOGYNiP7qyNea3Cdg1tVmN/wf5yjgIdVkls26jHBnY1
   8+DibhcEbkRiALBTTvQitj9OGxRh/WbBo+c00yS0yLjHjG0P584sc5EyI
   fc8XsedHPXFt18+CTGK/XG26oQzxkYGy4hAyP0ojxi/ug5l0+qCb7VsrP
   +HlWOFbSa1jtIfgysqdsxod5KOvbvNjk1HuixLq8XQK8o/4FZBQaO1iNy
   LVtaOSzGETjodJOOD6QFnn/nd9WRyC9M3AQvL5K8NgU/+A4qOh1Go1lxw
   QrterAeD5ML8J1GFYalfEgsTnnkOQa1YaTTLT9WAmpytwXaGSuvC3mz9O
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283608927"
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="283608927"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 23:48:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,265,1650956400"; 
   d="scan'208";a="570077930"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 11 Jul 2022 23:48:49 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 11 Jul 2022 23:48:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 11 Jul 2022 23:48:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 11 Jul 2022 23:48:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iABmW6dod82jhKFcoqFv0Pl1H82z/Lz9KkeH0O8hyY9Chi8Y63BMdylocJH2lZi+/0UOvo8uoSOGZgGsIsDlzysoosCC6HlICHcHvFKd/L8sg9Rjs3CTHwQpN6hpOV+CQbmsDn/QUDk7WdI3vMZ9SLiVnaOG5Tx8yn7M/k4sw/L/ufFpUsr8CEjsN8Ys8EHpQmD0i46961M8PKhpTjskrpk/vlReI0DPqGvbP84ZtEx5GDAjI4MUC9IcWRUVpSFTXR0fCtA9r3zeKUq6rHpHbDa8+eT4ce73b6uw6BY6pQ0DcBt6tKl5zfXm0NHnrRFXCwbm8BKdAsJdHUD5kaGdTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smU/9bQZ36sZbelyZlzvcsvkMZpwjN9bYK3X55/V0bU=;
 b=WaDHHVJIXemeciTw2LUw5VUo1NJCAwKuVqSOuLX1CpZOS9wMQ0gSNkgdy3A3kUXhTYGkXVSPlQIT09G03ebiNH4XWmFj6pvZhJUAhrZ7q8MO7NSPxtLDxlt1NIS5v81ygAVEhvt+AqE0q+VoTOaOhAgsbCYt9JXHCnbAI7pqHEdTByi0Y3M1MS30UBZsfIUIVRfOwvw7sPWtWLVN0qELyUrMxMZqGkQR/c6O3DvRiO/rqB9TBChReEsuwfM0Jhq+acCRvqlIms2A4qqREOg1H5PqU5N2wscoPTVQKTGIymZxwKKR9DtAgI80YWn0HV5aqPExFf9A/0bvXNACXfz1CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5933.namprd11.prod.outlook.com (2603:10b6:303:16a::15)
 by BN6PR11MB1681.namprd11.prod.outlook.com (2603:10b6:404:3d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Tue, 12 Jul
 2022 06:48:47 +0000
Received: from MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4]) by MW4PR11MB5933.namprd11.prod.outlook.com
 ([fe80::71d0:716c:7d6d:94c4%3]) with mapi id 15.20.5417.026; Tue, 12 Jul 2022
 06:48:47 +0000
Message-ID: <b87fa3ae-e9f7-9dc9-4aa3-cdd65535fd8f@intel.com>
Date:   Tue, 12 Jul 2022 14:48:36 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: [agd5f:drm-next 414/419]
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c: clk_mgr.h is included
 more than once.
References: <202207101039.vIExRWIC-lkp@intel.com>
Content-Language: en-US
To:     Roman Li <roman.li@amd.com>
CC:     <kbuild-all@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>
From:   kernel test robot <yujie.liu@intel.com>
In-Reply-To: <202207101039.vIExRWIC-lkp@intel.com>
X-Forwarded-Message-Id: <202207101039.vIExRWIC-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0221.apcprd06.prod.outlook.com
 (2603:1096:4:68::29) To MW4PR11MB5933.namprd11.prod.outlook.com
 (2603:10b6:303:16a::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 734768f9-398c-4cd2-f243-08da63d291e7
X-MS-TrafficTypeDiagnostic: BN6PR11MB1681:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: urhD9/+lbjFMQTR+A7D5QaEmVy7meIHd+EYitYyGZwtH6QBOUCvrpaB22uoz/KDK7zwTWeKxEVcnLPuJ90aHfcIwdyCK95wum5s7O7ZwMe8uOOlUkhj9Jh/pldkuzQWhWXoVqvVZzTaYpzlBy9lNFbedtQOUIGY+C5xySkmKaLlMcvCgG00j/oP5xKi24ZjZxUPQQzUNv0Di2cFG0lHNP/zmzX01O9EVYrrJLy+LBE+jcPgdQU723bSgYHkR1WFqX005cDZ3fNvVIt0zkrT0E/fe9sGy327D+Dmh9Z2cUAnFeRxwTZw0mGOWn9OeFGLxFe27eSSSd4BKUC9zsUYnIzBY7pwT3GYY/EhBFmzRmetax3Oy0VRwHjIqSWbhU22Ufd+pHD+ulX3SnHWw+YUPRwALTy9r3rZjUNyiKo6Xv/cA8uF+hEP0UfueETekgZvey9jtdI87juiFDvKUCj60SfA2Rbdf7L5XLQYAt66+CxGYuhz/piV/FwfatIQU/t8Psv/+fhqCJmdtjWP+MJl2uqs6KFLEGSJMQy/rMp1gPaqHxcbyE1pmwo14obqV3guKPXVrbchNxY257ZqDyhlpbFiyXwT29eBDHDRUqFRiGRHI++9UraTxb9iw3n9PXmrKoB1H40bCuHCsL0Nzod3vJ0m03X+56tnpeUV5Z0hUtL1U8oJPE+nQRI+gaNAmTY10WXUhn82j7tXC9T02cSHHP57akI193ZbV2iA/l+SRb9jEJuCA+9k/gnfuM8Gvu9ZGyyq7c0mxWuqLXf4jRfy7jVhQ++LMKC8/PSw0CMCms1RSVV6hyIaqXeVw3+DyNjuiCf6PENT9JzVGfOXI9t5T16vTD3Zww7G2WRoMdorqinghihJKS2SnA8gMWKFhqDWX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5933.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(39860400002)(366004)(2906002)(6486002)(966005)(4744005)(6506007)(186003)(83380400001)(31686004)(36756003)(478600001)(31696002)(4326008)(86362001)(5660300002)(8936002)(26005)(8676002)(66556008)(66476007)(38100700002)(6916009)(54906003)(2616005)(82960400001)(41300700001)(6666004)(316002)(6512007)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RmZCczM3dFpNSDlKRDBqM2hJaFZBaTZWaEtrVmdBbU9aTHZHZDZybXh2M0FV?=
 =?utf-8?B?RkRJN3dnYUtyajEvcFpFT3NDdlJpRWU2NEhsMjNTamRla2IxK0RqRWVlS096?=
 =?utf-8?B?QkpSSVI3eHA2N2NScnREMjNyT0draWlhYUcwQjN3UmM0QnBCU0Q2V3p0NGMr?=
 =?utf-8?B?Wmd0aTlsUGU1TW0raC9nY0V0UzRkQ3JRRjQ2aHI5OFI3M0U1dTJPN1FPenpq?=
 =?utf-8?B?MFZxVHB2ZTE2dUFRT0s3cFB1bDZFaHdGSVpmUFc3UHNHZjk4UjNieEJQZFAw?=
 =?utf-8?B?RCs2SVljZGdJbDJsYVFZb05JVThqVXJsWmtIc0NCUEZ2RURTajRNbjg2d3BD?=
 =?utf-8?B?S3hIL1MvWHZ1MFUvZnVQaHVmbFZ3dXFBcjQ0YzUrUkVFV0pBMWtoK3BSeHlF?=
 =?utf-8?B?clZ3MTlJOWdYak0vaGFqYXJOMWxIRWZXRlpXRElkRklSTEx5ZFpQazlkVnJC?=
 =?utf-8?B?TzhRVkVPYUNFMmkyQVNPTnF5YU9Ga3NvTFhZN1V0N3lNdGpnQlNNanVrZG9l?=
 =?utf-8?B?bnlSdGJvSXV6M002Ujc4VTlsNkJBcllVSmNiNVFmZmRJeGkvaUY2QWVzNmhR?=
 =?utf-8?B?cDdFbHA2cnFZcEZXSzcxcW5QQ2R2RHBrc3hQeUpDdTBzYlF2dlZLQWtua0dv?=
 =?utf-8?B?RGZXcGdpT04zWWMxTTRkTUdnYWxXbzFFTlZuUkd4N29RdjdQM3NKeVpIWGpL?=
 =?utf-8?B?Yk1XMXdtMUpCeU5rN1JXckdUSlNXSXBHTXB4OVQ3Rjh1WnF6dVBkT1lab2Rr?=
 =?utf-8?B?M2xzU3dMK0U1VkdxOHc5elNSdXRJMzZZc1k0Vzl3NlVxeEpXdFBFWWd5R3FS?=
 =?utf-8?B?THZLRmJuSnNuekVPOUJiSTFMdkpXVDlEQ2Q5RjI2VlE4ckNFcFpVVWJZTU0y?=
 =?utf-8?B?dVBEeHVpTDUrdi82cHlKMk5md1JOWWtzUEtaVTFLTit5N0FpZVYwRmJmdDgw?=
 =?utf-8?B?QWk4dWg0VWs1alRFR3U1WXMyMUlWbkJ2THBUWTlybEFReTBiTStDQmowSVlR?=
 =?utf-8?B?aVVhRlRUOENnRm9CdVRnbDVRMWJSSHVoaCtSeFV4akVVZzhoMDcvRkZsUnV2?=
 =?utf-8?B?WERjemh2bDcvdnQycFdFRmV0OE5yajd2eVlLV0tzVFBmMG82THNldXdLVTFX?=
 =?utf-8?B?TDBjWnQvbGN4cG5VR3QvR0E3bWtFVVNxSnFCdllSeGVxQ05DK3VHeDVOS2hx?=
 =?utf-8?B?eWkvTmpsTmxaWlp1TDBETFR2VGtsTXhvWGJmM3d3QkpncDFQQXJiVms5dlNI?=
 =?utf-8?B?RC9XSHdXRS9RZWRCNFpYUkU0WkxYb2Erdm9rWVFOMVhqbFo2MzhoM3p0L3Vt?=
 =?utf-8?B?cElFcFBFTmlaNnB6UzBJQVM5eVlMSWExblhOK2Y1SFlEWEh4cHVxUW9TeUpI?=
 =?utf-8?B?UE9BUnZ1dWpzcjZsZVhBQWtUaGVidmo0elFHSUFKaHhJbUxzZkdXcS8wN3ZQ?=
 =?utf-8?B?aE5tRit6L2ZSeE82RmRERitCTklRdk9XYnFTVG9tSXlZMFViSU5qYzVaeDhX?=
 =?utf-8?B?WmR1NU52bzdEVElrbnBiUjRETlBHdUJoOGRVK1ovSHVsa2J0aDc0a0lLQzN6?=
 =?utf-8?B?cDIvd2NJQzRGclVOcmkwZytjMzFXekdCVGZZamxaZzlOdHZJUTE4cHdoakti?=
 =?utf-8?B?M1dqdTI0U2x6VGptSVdsUTZkWXM3VVlNRXZ0TzRwMUY2clFyVy9CUFlQS2ht?=
 =?utf-8?B?ckozMmFKSmZHcFFMeDl4elI3OWprQVJQQm1xemRBSnRaV1FPSTFnMm1oeWJE?=
 =?utf-8?B?TDkxZVQ3VmVQQ1ZnTEMyanA2YUxmTWk1UWxPb1JLT1NPWnVxdCtHSjdOUnZo?=
 =?utf-8?B?OHJNL3RpYlNhbUVpUlZ5eXFlT3JlcmV3b2N4b2daQVh4bitkRG1NZkFNcWph?=
 =?utf-8?B?cFZkdjVQS2pvYUcxa3c0VWpudzA5cndxUVVyK2RqSElscnlodmpFZXhINmhQ?=
 =?utf-8?B?Um1BeFRMM1pla1VUdDYrV1hrR2RVYTRCeEpmVElIaDJ2OVBCNWRab1NYQXB2?=
 =?utf-8?B?TjlzazcvRmpudHZYUENDV0lFdXUrWnVMY0FxQlQ2WUkrSm9rbDJWQUQ1Vk53?=
 =?utf-8?B?ME9DNTBRNCtjZitSeVpiRU54NWMzaGFDdVVtbTJWY2h4bWovTTF1bkwzeUl6?=
 =?utf-8?Q?u6xttvi2d6HSM6PvQ3MDmUP6h?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 734768f9-398c-4cd2-f243-08da63d291e7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5933.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2022 06:48:47.1976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xIBcVO2m97OHU4SHz/GB1FNE4ioh9UwZ3stFBzCfkLzE+IooqnXE9TFixt2xDYwaReJrFwhZwc2yH/UftstoCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1681
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   e35cc9020f7b4540f5fbbff9fbe08808aab9addc
commit: 0629e353943a6d88b73ff6d4e9b3182f45de65e4 [414/419] drm/amd/display: Add DCN314 DC resources
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <yujie.liu@intel.com>


includecheck warnings: (new ones prefixed by >>)
 >> drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c: clk_mgr.h is included more than once.
--
 >> drivers/gpu/drm/amd/display/dc/dcn314/dcn314_optc.c: dcn314_optc.h is included more than once.
--
 >> drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c: dcn31/dcn31_dio_link_encoder.h is included more than once.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
