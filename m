Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6B0517446
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242733AbiEBQcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241610AbiEBQco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:32:44 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB9F3BF4A;
        Mon,  2 May 2022 09:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651508954; x=1683044954;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UOcg1NHCDlQfVEaEg73B85Y9CkNIZzv7kShywDNrzPQ=;
  b=jCpJ5M2kfWDpJApGbVe1KHfV9WblQJm5D0WenVqrJ6NU1OWtzE3ZpX0K
   RVGr3sidHGlcjDA3RkknEqkiH8Aolya7gRt2slBKYVEfFSnjFIV9Wkmjh
   oAC7vqeTHt71Lj+PiWShSPm8gj3H9jR5lJx0XTjxHnfY7om0sSGw6bKVE
   hYWJfaLJMWlRUR5F/Qw9D5o5Xjvi6tEmJSiAJMXHfEwhGpbpETiK+h2vl
   maAYFgwCWVcloF8qbmlnImM68/2JMsoQ3FEKVJbUKEcsQRbx5cKer/Odf
   jCCvjSLqRCKP7kmasnTn9r8bM73iT8MtK0RGydjrEbDLMUz6/ROaH/7I9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="353687915"
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="353687915"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 09:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,192,1647327600"; 
   d="scan'208";a="546495916"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga002.jf.intel.com with ESMTP; 02 May 2022 09:28:56 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 2 May 2022 09:28:56 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 2 May 2022 09:28:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 2 May 2022 09:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzPC/l4+/6m99dI6IGZotut3aSb077Ri9SrNlq0yRhA0CsS1VLv2xSzewRcQNi61m7mJbcw5i/K0/GmTWNAjqjDGRiJpxBaIRtEldbWghpWXveGzjHersj2Fo9rs7tNFJ/NS8aA7WjTcZxw90lhlH5Ry+LqTaEhTxKAk4K8PoNrvvqMrRulA/SxB/1g7flW2NwsLdskdf1x4etHDCg8982Vi/NF0yWyvdZxtuqixxpsx3UMxR6SYdks5LdPIIob+UC4BqlR01yXV4oipRn9ghnw409S+txakdaoRVNscCAjVugkso+RXm9xkJYyuH8iU9QnWuNnA3yXQBY82vwKNkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hwix7p4bd8gknfM/kFhFDTBo8hk/sVTnjCxiJHp+/Jk=;
 b=hmJ6FZe+yUI072EmAdAyrk3/HQwYw3UNdnyAMMyPfkptmOIjKwl4xxi9g/xF2ymkSvjmaMKGcmgOqq2sPJ4siswKJ2W4Fz9XYwK0GwEbpV6BJ0IQFeHmemsQm5qMmZF61xChu98Y3n/COXLHbw6hb71PSPArFKGOWGqXBC9jrePD74TQ1r2KY+R43x/YYeUQ/bkRRDcvCEcF6na1xh29EKtomDdxd1jPRipyLTMEzlVLpzhiTIS69BI7gF6eGUp3Lh19Plz7W/czU9uiy0XIKwuIjQm0wpobCaxxGpghWeb9rXO0k9h36BnFD9PDSN+xQ0RCj37Dm0s3/x+5IcEWKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM5PR11MB1899.namprd11.prod.outlook.com (2603:10b6:3:10b::14)
 by PH0PR11MB4776.namprd11.prod.outlook.com (2603:10b6:510:30::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Mon, 2 May
 2022 16:28:54 +0000
Received: from DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397]) by DM5PR11MB1899.namprd11.prod.outlook.com
 ([fe80::b9cb:2e5f:f3ef:f397%6]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 16:28:54 +0000
Message-ID: <7a6906b8-6ff4-c44c-000d-5f7110d19df5@intel.com>
Date:   Mon, 2 May 2022 09:28:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.8.1
Subject: Re: [PATCH] firmware_loader: describe 'module' parameter of
 firmware_upload_register()
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>, <linux-doc@vger.kernel.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20220502051456.30741-1-bagasdotme@gmail.com>
From:   Russ Weight <russell.h.weight@intel.com>
In-Reply-To: <20220502051456.30741-1-bagasdotme@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0003.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::8) To DM5PR11MB1899.namprd11.prod.outlook.com
 (2603:10b6:3:10b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a4f5cb-c41d-46f1-6172-08da2c58d941
X-MS-TrafficTypeDiagnostic: PH0PR11MB4776:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB4776A6559304B6A0375E5188C5C19@PH0PR11MB4776.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XwJbAdpjN5PzXly5SceT+USriB/uKeSZ/z9lji6gKDPsxgTUgAmUmqZYoof9R3srKtW7YWDwPWutOBciGBWk8ISbbyNm5XckNvSkQC6S2bLDJP9D/9Mfh5fWI9L8oR79vA3bmeipg/ToQiKNEfoqe6EOhsx6zzsHQFTp4HEokOrBt6YJG8GcIttLlG48CJfi8OAHq/p5l7rLVYMUEZf176w3Zj6mrkngne51W8c3klaeaxDaOYyvffEJMwVVpimkhpHZjhCfQwR0q6JVYqY+0HAQmSBtAZ5Y3RsILCW82mZxS3+guXAfWOmVKVcQw4HN+2F7Vt1C2YksCjJYJK2a6NWWeWsL4OpTEveQwbFt1tgCzq8KW2yefXm5uguOuRcdH92UCFHqbhMUIhcQ9V+KVFwp5IbPVEdrUrSusJTPN217AEUY/5jv6EXlATRx67ozf04gtdHc8D4nOlbXJoAugXZcwDhOHopJfx/tR367Kx9bnTjeSL/eiygdLUy9GvDeg7Fwiak1NvNV1gsttGC3cbH8cd+qdysqYRdw8nj4d/02D1EdgsptWvyxp2RzU5YufBJagvIQuC8r6rFG1+/7T4X7sf93aRTMZjSiu92g6jqJXuRhE/Wf7Cahp8oN9AiAZfQAYQovdzn+v4Kr/KkqvfV8FanooiWOLxZk+/KVyu5OfWawt3nV3StQgr4vlpj/33UMs+WwRCMDA4o9DLUB/7ocOjdhD/J7NFNDwyvwlhv4Bi5MTy4W+f/nuE+4t3kHMn2cNCml5wM4oxzevQqylOKowacnUBxu1kyCMUhvsTmTcLxpaL3tB3S8dGurpTJj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR11MB1899.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(31696002)(6666004)(53546011)(966005)(5660300002)(6506007)(508600001)(8936002)(6486002)(186003)(38100700002)(86362001)(82960400001)(36756003)(2616005)(316002)(8676002)(66476007)(66556008)(54906003)(4326008)(2906002)(31686004)(6512007)(66946007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0FHKzdESkEzU0lFSEVvb0ppeDFlSlhVTm5pTXpSRTVNa2t5NDdFNXlzdm9P?=
 =?utf-8?B?UjVmdGxNWmozbUFtK2FOZXpTV2R6ZU5UVFEyRUdHcERlYVV3bWd3QXc0Q2JQ?=
 =?utf-8?B?Snc1Q3NvWWlIRUY2RWEzQk5pSXE2b2pESk1IT2ZFV3RMeUthVC9ldmgxWitI?=
 =?utf-8?B?ZUdOUG1jWlVaNENSTnFVcW9SNFR5Zm1lSlIweVVEM1phbUYzRTZ0VnV1a1VQ?=
 =?utf-8?B?eUlzNVlHTzQ5ckNwVlc4Tit4eG5jWUNDdUVRempES3hPRGNEYnBobEUrM3J1?=
 =?utf-8?B?Q0hGNkNjeXRIaHVkZyt3ZmNRVHY3MjkyZHc2Tzh4U21xWjBtVzRSS3gvcm9G?=
 =?utf-8?B?OGVZUTM2WHZ2S2V6VmJqSWgvNFRQSjBtMXNDYmpsdFFqRTRoSXBFekhMUnZ1?=
 =?utf-8?B?WjEyMExYTmtUbDdzazQrb1MxUWRzR3pFNDgySHZwQlZ2cmc4SW1hUHI0YlBC?=
 =?utf-8?B?STFFcjJyM1RrditBcC9MQlBNdVZiMzBkS3FPU09FZEJoc0kzbm9ZZjFqRFpO?=
 =?utf-8?B?S1c2VkVyTGFjVVdLQ2FHa2hmYXhEMUhzNnN3K0tYWjhxY0dqWVdKTHUvcUxY?=
 =?utf-8?B?YjhDajd5THNvaTU5MXg4dnJzenIwc2dFdzdDU0w2WHRXaE1mazZOVjFsb0lN?=
 =?utf-8?B?SVIvVXlKdTQzZGNXbllDUkNVRUs0OFV6Zm45OXFMQ3FiVm9uV2V2M3g5eG1k?=
 =?utf-8?B?d21WbVhMdVRRU0hIV0FJZ0VVWS85ekdBTC9lYkUyaDRVRHQ3eTJoOGhhMjdV?=
 =?utf-8?B?RVNkcjlXQ1lDWVE3bFdVRmdMT3hjUmZMak1wM3hxaWhlWXZ2S3hYc09YZTA5?=
 =?utf-8?B?Q2FaRjFvRDFWUlJhSGJCZXc4c3g4amFncjVKcHh0UUVtSVYwMUEzVm5Gc2R1?=
 =?utf-8?B?ZTlxSlQ4RUtoWWJ2ZXB5TmpkYzA2dDBTZGl6MnRaZ0w4elFaaVJCQ3NtN2k4?=
 =?utf-8?B?M1dFT1piUWI3b2RlRHFtTHZtNnRITzV1dmJGNmladWJDdzRReFhLckFWYTg1?=
 =?utf-8?B?UjRldmZROURMUDIxakRPNlJmQzU5cmtRN1UwZ0RmQXUvQ3Y0Z0FlRnZIbU1o?=
 =?utf-8?B?UGx2WVoxeHVaNjRmTmFrRXVpeHQ5RUtiRXdOU1dSS3VielpURlhkT1ZWVHR5?=
 =?utf-8?B?eDJaU3BaL25zT1JvVTdaeVpyNEJ2eUZlWVVYRDFJTjZEMEFLemdWOU9hQmd4?=
 =?utf-8?B?OEhFZDRic1NKL2hUZnRxaHNLYXNEODYzNndGVzFPejM3U0NxaENqQklWekhL?=
 =?utf-8?B?VE9ybkJCdTI0OWJKb2dXdk1pbjUzTFU1c0VQMFFpR0ZORjJjdC9zbU9Ebm5B?=
 =?utf-8?B?ZUdYOE1kWFpvUHBGdG5JeGJUZU9RUHVqV25rWVZMWmRQbkVqaE5KWTdiUXVp?=
 =?utf-8?B?S1NscFdiQlhHZEZpK3Q4ejJYeEN4UHJyb3RCNTNVSG93QnhCQmtjclNOWEs0?=
 =?utf-8?B?d3JpMnJjWDQ2TGdFWXR3Q1lUOU1uaWd5TGtqaG56N2NlcEE1Qm5sUkpjRXZO?=
 =?utf-8?B?Z0J5M2VkSFpWdkFaSFdwR0xpQjZFV0cyaUdLcitMM2JsUTFBbzdYZ284NUNL?=
 =?utf-8?B?Y2h3cGVDQ3BCbVdrY2xwR3p6dTBKR0Y1U2ZnUWFEWUdySFBRVzdtZWdkZUJJ?=
 =?utf-8?B?azdodE1aLzJLMEEyWlJuNWRRdTAwRC82QU1xWjlzcXgvbVFKU1I2VkhpUzU5?=
 =?utf-8?B?czg0akNzeWYvRTNvc2RUVEQwNlA2REJkNUJnZVdBeSsxUCtTeWRLdG13Mi9w?=
 =?utf-8?B?elZpcUF5Tkc4RzNjQUFxVXdkNXlCMVZlMmtwdkdudkpISVhyNEhGbUxvMDdl?=
 =?utf-8?B?djZ6ZHpBbzVLOEQ3cWJNbS9QLzdaaEV3R1M2SDJKNlZQaXNzTGNMb2pOSlQ4?=
 =?utf-8?B?SGwwNzB1TUROTzI5bnJOYTBmaXBDb2U0RkJGdFBzMnBlTGtCOWtrK2xNVVRO?=
 =?utf-8?B?ek51WEljVVNWZnVYQmV2YzkwY281VnZibUZ6WVJlcWJiK0lrY0Jlb0wxbFV0?=
 =?utf-8?B?RFl1V3FKbEljeDZMZ3k5RGt1L3BnMU96dTlUUWZVcVR6aFBoZkVnaDA3Y0hq?=
 =?utf-8?B?S3NqRXM3andLb0Q2WW9ObjU5SHJxNExnM1R1WFUzaVhZeVIxYUp6VVZsYTZt?=
 =?utf-8?B?c3dwUFhzYWxid0ZHb2xXZXVPcy9JUFBlaWhZT1BRLzdOVThhdEJSVmZFYVJ1?=
 =?utf-8?B?TWs2K0grNG00ZVFjV2o5eVY5eUxCUE93d0kvRGJlNWNESVpYdTc0NTMzQXo5?=
 =?utf-8?B?ODRJcWtvVTQwWHpNanlOVHpZb0hXaDU5V2dTTXJkZVJFZ3RRVUMxRERQb3Y2?=
 =?utf-8?B?cUozZ3FaTjMzL0ZlU0dINS9GVXZVYW8yOHBUQmlodkxKN0NJWG92TzVHeTN3?=
 =?utf-8?Q?Y6LnMgdbgnRAP0vk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a4f5cb-c41d-46f1-6172-08da2c58d941
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1899.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 16:28:54.2062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AJyW00wNrMXTEEjPOZJYgdGUzcwqLxtuJ319hMpGWgq8EPRsihEiIss75OI/dW5CV3zXd+g0d3BHUhVxksL2hduu2536inETb8tyGJL8aqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4776
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/22 22:14, Bagas Sanjaya wrote:
> Stephen Rothwell reported kernel-doc warning:
>
> drivers/base/firmware_loader/sysfs_upload.c:285: warning: Function parameter or member 'module' not described in 'firmware_upload_register'
>
> Fix the warning by describing the 'module' parameter.
>
> Fixes: 97730bbb242cde ("firmware_loader: Add firmware-upload support")
> Link: https://lore.kernel.org/linux-next/20220502083658.266d55f8@canb.auug.org.au/
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Russ Weight <russell.h.weight@intel.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Linux Next Mailing List <linux-next@vger.kernel.org>

Reviewed-by: Russ Weight <russell.h.weight@intel.com>

> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  This patch is based on driver-core-next tree.
>
>  drivers/base/firmware_loader/sysfs_upload.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/base/firmware_loader/sysfs_upload.c b/drivers/base/firmware_loader/sysfs_upload.c
> index 8cdcf3516c7e94..87044d52322aa2 100644
> --- a/drivers/base/firmware_loader/sysfs_upload.c
> +++ b/drivers/base/firmware_loader/sysfs_upload.c
> @@ -266,6 +266,7 @@ int fw_upload_start(struct fw_sysfs *fw_sysfs)
>  
>  /**
>   * firmware_upload_register() - register for the firmware upload sysfs API
> + * @module: kernel module of this device
>   * @parent: parent device instantiating firmware upload
>   * @name: firmware name to be associated with this device
>   * @ops: pointer to structure of firmware upload ops
>
> base-commit: f8ae07f4b8bfde0f33761e1a1aaee45a4e85e9d6

