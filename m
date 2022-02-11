Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54414B1B9F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347040AbiBKBur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:50:47 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiBKBup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:50:45 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AF810FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:50:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644544245; x=1676080245;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uGQJms+kAmru7al4jWSiTpejL4wepWvwl9U1Ad2OEoU=;
  b=namqQ94gd54sCx2t1Q7bdbpmp+rIttsWmPcH+FqmOdGc8J/OyOGOQnCO
   VDw5iOCFgFGty9t3cJbCdCAt44e6l4OgO+lGN/EP2ehK0gtLbIxl8XDYG
   mJ9EzMLu39NoQGr43wJk5K/8aEeGUzCT+F+0kDM9/EZmFC2o2//XgxdaP
   Lqrz+0Hj9nSIerCm3tYJPYFNhRUUMC1y4ZESVnvTLUSwhEEzP0HB0CqNu
   kWdJStVphHrl7cW95jYp8ILyDY2xa5l1nrtTieHVCgAXg89bBrfGR49R0
   ABaa+8IyqXhGMIfxcM0EMhUbGklL/XMRu3s4t6IBIBLcNKlf6r6L7Fxc0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="249583556"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="249583556"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 17:50:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; 
   d="scan'208";a="633902803"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 10 Feb 2022 17:50:45 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 10 Feb 2022 17:50:44 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 10 Feb 2022 17:50:44 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 10 Feb 2022 17:50:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5hUBM95TsTHmUhjdywgb3PAn8p9JGQvIpoIa8GZhjZFAiR3RDgP718MrxzXeJtvvKGxh5lspuaAqT311yZPbmaApmewsZz4TWnaPzywF/SWRxU3Uao+gQGB0amYqJ41G2L2hbl0f0NO1rdvpHUVxqBQ0KdoexiTMjV6n6VLfcGINaunkDYhcsXfCQPa4DC3QvN8dguVNp0dZsB41oxxJtGkfeP3MCEs6lRLOAEUe/Hs0O3oYuE5d36pI0g7bm13wjeUzjJMlRvkqMU/LCboS3wFdZGyaAloyYiDPX5CAIpexr3c09wcs6ffw3ihrWe2GaqW1ifL/37XEGuUfzyV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vPnyXQzjljWdxFJVpDTODdg3YYZDPzsn1cKaq3gJ7EM=;
 b=ePl3ev8x646CjZJ2jK9pKiJwrTe3vQPE/PTOMQNoC6Uah6br0Y6maLVIOo22adAeoboAwp8ASVo7QgXBcKFJPcVEW8+l0eqYiiYezKXPOg4xaqjlZdNGJ844ua/+lvPOEE83ZcQgW6KedHkm0tL94f3U6WcivS2VXTVDfObhlcE1sg0/JbJ3seI8GZHC6gKislSRrddthiwO47afTdN2TbQnd/+k7jTkV73VxBHxJScB0s0RL0VA7p379KHqvsLcNxSUauoNDIweMYVulxmYgu9GGnSjSsqWap2kgpUmlMog8y3YZYW4V/ws81xzvC5C26fxoZNiLhyO7VwnbyuNNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by BN6PR11MB1714.namprd11.prod.outlook.com (2603:10b6:404:47::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Fri, 11 Feb
 2022 01:50:39 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::5c89:e3da:dfd5:ec7e]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::5c89:e3da:dfd5:ec7e%7]) with mapi id 15.20.4951.021; Fri, 11 Feb 2022
 01:50:39 +0000
Subject: Re: [RFC PATCH 3/5] firmware_loader: Split fw_sysfs support from
 fallback
To:     Luis Chamberlain <mcgrof@kernel.org>
CC:     <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <trix@redhat.com>,
        <lgoncalv@redhat.com>, <yilun.xu@intel.com>, <hao.wu@intel.com>,
        <matthew.gerlach@intel.com>, <basheer.ahmed.muddebihal@intel.com>,
        <tianfei.zhang@intel.com>
References: <20220203213053.360190-1-russell.h.weight@intel.com>
 <20220203213053.360190-4-russell.h.weight@intel.com>
 <YfxcbHuFjL3xem/0@bombadil.infradead.org>
From:   Russ Weight <russell.h.weight@intel.com>
Message-ID: <59cafc76-3ee6-cc87-713d-e627d012d45d@intel.com>
Date:   Thu, 10 Feb 2022 17:50:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.14.0
In-Reply-To: <YfxcbHuFjL3xem/0@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: CO2PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:102:1::16) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1930ea3-63ed-4c8d-cb97-08d9ed00e7b9
X-MS-TrafficTypeDiagnostic: BN6PR11MB1714:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <BN6PR11MB17147854A24CC03C5E3370A8C5309@BN6PR11MB1714.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ol6BYMKgIYlffMOqahTPTk/+IWxHulR55udN1BG5mmCAxTzRUomaGGG2XeGZ8EfN3ZRbmNJcv4FdtAqEM/N1Bd5p6WJB6LbqpJ7uBFCi6vllBjBk953ZXCIMbY6nW9sMkwRaVxqLEB0sK/Ou6TuOXMgZmln0vz40WD45Gt5SpQKxxkAvoXSYHwXt4faP5drR74kuZYS91CoYt+6IZsvFLtCuMJwYrq5VksVGXqN7JfSwHBQkpa4NKH7eC5dB27DgarESPPvkenmW8gMw+WBno31YoScnx6VtTNK4yTf5lnBEi0H4g0cQhTi8hvg4wzVA+Run306bYRuoTWTOttU991X1aqsTriM5QNa7H3wnbogpyLHhQUc7G9UDkY004EHRpI2znhlZIAiyEpLpnwdUOmRsplmmaVVR+Z3DYn2yTEoIdnGkyAF2MCjBfDyQy67kdRZ6XeKv5x1RcxENcE/OeGrF7wpYNx/cW2lfqMD0sIx+1HJjH0bA86AfduqRojs4PvTEQJdiC0qEhGZpY7+UHhUKHvPMXe7CvQx+q7ytRK/p4hkuwH7jAsKOrjvKl6CySWD0PH3b0doAIMRX/zzNEhpUWsZRiNRRjMXBltGkXdqOxYAuebwtqWCJJtArnmwjhV2DYcwi4mcqLf61+6Sv+xSB9zlGlZDtCgCjrMGC+OtegPYsgZGIW7YOyJ52rydveA2Iu0MbEqcGEKI1vvpf2Pr/kzYfSebHrB95NgEBjS1t89lvvjq2fzJbqbqTUu52
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38100700002)(31696002)(6666004)(8936002)(5660300002)(36756003)(31686004)(53546011)(6916009)(316002)(508600001)(6486002)(4326008)(66476007)(66556008)(8676002)(6512007)(186003)(107886003)(26005)(66946007)(83380400001)(6506007)(82960400001)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODFIRE42MUlrK1FSVWswYnpDMDRFVU9sWDF1VElURjNPSlJndHlFTTZtTEFE?=
 =?utf-8?B?UndoemV0Vnp1K2xEUXFkbS96M3VROEpYcExLV0hNOVFTWFlnd2ZHQitXRG9N?=
 =?utf-8?B?RTZUblFscVBxaGIwVUhMbGxGcUxmcmN6SjhIOHBDRVZxM3BKSXFtSlNWVWJR?=
 =?utf-8?B?ZmJRMGd1L3FPSlpmZWVaMVBKdXlsMmlLWnJkVlZlUFpGWGNtM0NMWEp1ZHJp?=
 =?utf-8?B?SFV3UTk0WXRVQWRGa2ZtUTRHdGZpQnRaaVVJVVBRNWlVbXVZOEhlakdjdjJi?=
 =?utf-8?B?UFBZSDF6R0xEWk1Jc2JIUEtmeVJDbENnL081bjUwbU1XanlreTg5eVNnSytt?=
 =?utf-8?B?RHFhUGdlcTJkT1QyejRMZ1M3d050U3RoQnpIZm4zdCtqRlhBNW1ucnVQWHV1?=
 =?utf-8?B?R3NXaWUwL0hrVDZEcjRyN3J3dWwyMGFxRTJDWUdxanJYUmI5ZEtYWDlZVzh3?=
 =?utf-8?B?Sm5qRWlWY2NOQXdMR1JXZy9wUHRub3Rza2kwOTM5Sy9DTVM2L0pucVRKVXVQ?=
 =?utf-8?B?NTF3U2pjaWViSzVLc1R2QldQNW9TRThSSnFEbzliZERZM1FXVUZGZ1Z1RWwz?=
 =?utf-8?B?ZndLSHBvNjRueHdxbWM2eWRROEJ6RjRVNURhNWF6N2NqazRxVzc4TUVFc0p3?=
 =?utf-8?B?VEdyTCtpdk1NbXlzelcxd3A2V1p0NHZlVlpiVGdta2M0S3dkekFLZEJUVEFQ?=
 =?utf-8?B?UDQydEg5MFNSbmZYM3lnSlNDZG9HUldTekJXT0kxUG9BTEp1RlVFRE0zOEdQ?=
 =?utf-8?B?WFhaMlhrem5kT056MzIyMDNuVlhuRU91QVJUWnFtWUQvbW1rZVl2bVhJTnZh?=
 =?utf-8?B?bVNyVDJZc3puMlVsS0FwNGRGRWFxaEl5TVU5TmVQem92cHpwU21qMHIrbjlu?=
 =?utf-8?B?UmdNOEgvVXR0dDNHTUxyOG9IMERCOUtLSUNGeU8wM3F0bmtoTzA2UnB1RmxY?=
 =?utf-8?B?RW44WEsrSEpTL2h1K0YwZjdTcncyRU1iSmFzaitUQlo1b1FXQUNBdUk1UndQ?=
 =?utf-8?B?eWlpWDkxR2pNUG9VRmJFMUJEMGE3UEJBOWFQMmg3TjdRUmoxWVJvR0JtNlMy?=
 =?utf-8?B?QVBZRkxvbFNhbnFvYjA1ZmV6SDkyK3BNeEhUWjhBcnViZkQrc1RySnNkZlBv?=
 =?utf-8?B?bkVKVG1FTm56QWxpaXRSZWhVekc0SEx1emdzaC9mbWM0bFhCclgvVnpubEln?=
 =?utf-8?B?RVR3UWh1VEdtTjViVzZnS0dBdkl3cjNZZytSdjdTU0txbWVxQUNWL1U3OGdT?=
 =?utf-8?B?cHVrdDdnZXdtWXA0bm12bWpNLzQwbktMMU5OUEZnS3ZvdFdCOS9rVVJOYTAw?=
 =?utf-8?B?dFdJclJxZnFXQ05tUGRkdm9BOUE5WnRKdjBKdzlNNEZidDlObldNTXVmamYv?=
 =?utf-8?B?d2NtakJxRTdTRlpjYW9NUlQ2aTBIUDUvbW9qbWZIa29jZE1QS0M4L3dZbVNI?=
 =?utf-8?B?RzIxZzR2dkRWNTkwQnNwWDhvSmxrWFk4SG1wTXNFeDgxNU1iTC9xQ0kwQkpU?=
 =?utf-8?B?M1pvdHJINlBpMFNOdFdIU1dmeGhHdzVvRVlhZG5Yb3VxbUdJK0ZWdExFNnA3?=
 =?utf-8?B?ajEvcU9uS3BJTURrTnhQZXlVM2Q2OG1zUkR0eW9xS3lCZU9XMWJzcjlxc2lB?=
 =?utf-8?B?K0lCSmFxKzEvcW1ramZwZmMweGpQTTMrYmcvTlJ6ZXVKWS91cG5TOUNRT2Fs?=
 =?utf-8?B?SGJ2aG1PUng1ajdoRURSTi9XR2VhSGxoMnlxVUtTQTR5TTZiK0VpenB2dG5B?=
 =?utf-8?B?a1VTcnlTY1BYR0VYckM0MlpnYzF5b1lHSXZMY2txU2tFazNST3puY1ROK3pw?=
 =?utf-8?B?TGVaemxyVU5uSjk0ajlLdGVaSVJNUFJvRU9TMHRpRzZ3TzdRaFEwTVVRMDEr?=
 =?utf-8?B?ZzR4K1NvK1RnMkM3emtqekJhOUpqTXNwQ0RENldQNHhEaW52bHh1TWFaYlk1?=
 =?utf-8?B?U2RxQndzVUZQRUdWYnRXZWNZb1JJTjVzQ2R6UTM4RnhtR1BEYmdlcFVDNEIx?=
 =?utf-8?B?NkxtTC84R0cwdjZ6Mm8ycGVnS1NveEptMkFJQTNQclZ4UmMzUkJhaDMwWEZH?=
 =?utf-8?B?ckxaZzc3SGVNTGpZenN5YmJTWkhDcW5VbGxIbjVuTFJkVDc4RHkwa2FTUW5n?=
 =?utf-8?B?dmRXRHQ5R2NyL3BseG5IUEpCNnZqRy9KU2lIVW9QR0NxZG8zeTAvc2dFUFZV?=
 =?utf-8?B?V2hkcDdwS2oxeXZiVFVKWHV1bGJFWTR2dnY3b2pVYnc0aTY0cDNoU0FhZktk?=
 =?utf-8?B?akFaV0duMUsybTZWTWE5QktTa1d3PT0=?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1930ea3-63ed-4c8d-cb97-08d9ed00e7b9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 01:50:39.5788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xT+2R0uMKSFrajPIlugHIHmJxHi0UwP7wRBBVV3by2Ev4y/ACi5OR6TjhKKGdbwYuU6IkUkg6rQ6Ofzb6JOKRsI3CRVe87bpJ1387qx6ejo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1714
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



On 2/3/22 2:51 PM, Luis Chamberlain wrote:
> On Thu, Feb 03, 2022 at 02:30:50PM -0700, Russ Weight wrote:
>> In preparation for sharing the "loading" and "data" sysfs nodes with the
>> new firmware upload support, split out sysfs functionality from fallback.c
>> and fallback.h into fw_sysfs.c and fw_sysfs.h. This includes the firmware
>> class driver code that is associated with the sysfs files and the
>> fw_fallback_config support for the timeout sysfs node.
>>
>> CONFIG_FW_LOADER_SYSFS is created and is selected by
>> CONFIG_FW_LOADER_USER_HELPER in order to include fw_sysfs.o in
>> firmware_class-objs.
>>
>> This is mostly just a code reorganization. There are a few symbols that
>> change in scope, and these can be identified by looking at the header
>> file changes. A few white-space warnings from checkpatch are also
>> addressed in this patch.
>>
>> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
>> ---
>>  drivers/base/firmware_loader/Kconfig    |   4 +
>>  drivers/base/firmware_loader/Makefile   |   1 +
>>  drivers/base/firmware_loader/fallback.c | 430 ------------------------
>>  drivers/base/firmware_loader/fallback.h |  46 +--
>>  drivers/base/firmware_loader/fw_sysfs.c | 413 +++++++++++++++++++++++
>>  drivers/base/firmware_loader/fw_sysfs.h |  94 ++++++
> Nit: please just use sysfs.[ch]. The directory already implies its for
> firmware.
Sure. I'm assuming the same comment would apply to fw_upload.[ch]
int he following patch, so I'll remove fw_ for those as well.

- Russ
>
>   Luis

