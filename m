Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043B058AEE1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 19:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238719AbiHER3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbiHER3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 13:29:42 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2066.outbound.protection.outlook.com [40.107.102.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46422183BE;
        Fri,  5 Aug 2022 10:29:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S26jVAF3EtSspLjSmzn8QrbQQ+x2tK3pIsZuCUbTPBg3C6H6GBUb+dqDPuTne98rw1wMkyyWDO1yMEOnfU6CEYZ+KDF+aueJHWIabnthuxJkG/7ShAfr1Z1Xjh1T2mH2dHYzGWorbU/2eCEibs58vIC45bdFoPlhuFUPLjozTxQOsFk7qER1GPlKxBoez+CjoCYGPwcLCbBis+YOW3ZGEKQtPjbckPhw+T3RtL9Y+Kviv4NpOlJYjxvsjmGDhYZRrQlOT/doq+30iQQnQELtZRepsumOb3qmoDQrr7fsbSuHc5kX04vcrlYQY/klxQy61jomKxD+hWEz5czYg9akNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw3pLmbOG2xdCTz3gDkLexOPsWMWnmGxKNUBQwIqxvY=;
 b=Z5S94Yyh/mPccRyCKVeMP8VALWo67WUxgdALabj8Hc6ti+mldZjDsNfNq5IvYYI+lEUE3LTTm8THrUZsFhBI8OPla/rOWz841bRe0KO0lDYMnUQ6MByOgObFxEiDs7c0poXTNF6lEHjeKNi8V3qtoYcOOLffA9O0d2444WchczMWb3T7loygzb9ajrshHi7lZ6AZu4GcPZu10TPb/0UoiwWJABluZTowniRDNihXfl/g2i8OMa3flK3dZ5rbZMnPipxRRC0h/dwkXsEcLFzVCh7blkWCMpLRUxh+X+1MZlypfTWDEge+F5d21ThSXrIpXT1FU6zsSehWzCOt3zxrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nw3pLmbOG2xdCTz3gDkLexOPsWMWnmGxKNUBQwIqxvY=;
 b=oJW+S+S654YLsRXM9Vzjr0tIKCumB5im90MdaSy/BdamMGKytT/0izIrqgrVRigWw1PgEoyBVPyZgBjB+LoKzy62zlx87SRUnLUfsYlAI5yWabD4BHLm3D3MIp1q/l2uzOlYA5mS5uL+u6CM4bAO8TVoNNnBov1XxUXk0P8fFuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MW2PR12MB4681.namprd12.prod.outlook.com (2603:10b6:302:12::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:29:37 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::4489:9a98:ef82:6c67%3]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 17:29:36 +0000
Message-ID: <f253a352-caf3-49fb-17d3-0265b472d4c6@amd.com>
Date:   Fri, 5 Aug 2022 12:29:34 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] rtc: rtc-cmos: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-rtc@vger.kernel.org,
        Linux PM <linux-pm@vger.kernel.org>
References: <4771532.31r3eYUQgx@kreacher>
From:   "Limonciello, Mario" <mario.limonciello@amd.com>
In-Reply-To: <4771532.31r3eYUQgx@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0005.namprd05.prod.outlook.com (2603:10b6:610::18)
 To MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aa752a1-510a-45ab-5a15-08da770811b8
X-MS-TrafficTypeDiagnostic: MW2PR12MB4681:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4JR4N+wy5jK4EyI1PmP1WopqT3IhYt4ZaqrGBC22Jn8W75/r0z+PXvrVbzcI5tF+9SZmV2GXdgilJB2A5HUfX8DT6IQ8O8E+Ot1ixoJtyN5yM/+McUmRfQFNFmTqWlQsKRhK2KgNIs8lNGQ5Or/EYQ6F0oB4+Vjw3sxd02eewk7iMl9lUU8HvwVpNDL9EvE+R7IQrabY4VBg9ECIHz8L28dDw3mjgO1Nge5NRnngEUQFCqz5XYqjW65Sj4y9ai6i45o+IUD6uKx/jBKhnqbHWNLnWmFGpVhYlhTwQMzcLIn3nvR5/95WMqPuTL74gOIWai8yrGMA+5Y2VgX9YzTvZeg2YahklBDtM5ai6AZmqp7gN9xdbmLErh5VBGqFlY1+F7NwhipfvjlKZiv40bYArqpaFJVi5nrRBDjQmnj8d9Yz9oejl/DIpYHEA1VyPKwpJZdzQRqRE0454fKkvOR7cVMGaWx1MCaFL2TW0/v6KRxM5INuBRoJOS3OVLBS4n82wa5PlcwegxdthbN+jCNS33sLw1LQHe4LkGCNiBrLV31tp1UesumvWuECABXN7Dgg6SCpsWT1RFuFpl0Tw0cjdXz/aqUd5G2Ywe0R9B9ArTGK5scGcT+7usHcsmxmZYCOO6ri7t+bD2zkjaUnrmkgl9MCBEYWl4GRys4mJURDoXdj4s2qaeMsA74plQSEODGKm42PqHJkU0eFnPuAq3C2zRmGDaGTSGwAbsuhCnKV7nxTJI5RtcvwtxjH22s/iSYf9tAEJq8pUV8ZdgLHvfXmpsxZ25hVHoakAbXvv1R0nmQh4rkVN21jH5lZhFjXr1jgHpLdAJh1jMeO67JnlYF5ulGy5Vg1FlTBjgSymYXEgnZWfa65kGJ2UCDEVPUBvbx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(346002)(366004)(376002)(38100700002)(31696002)(53546011)(86362001)(6506007)(2906002)(316002)(36756003)(31686004)(41300700001)(8936002)(26005)(54906003)(6486002)(6512007)(83380400001)(84970400001)(8676002)(66476007)(66556008)(66946007)(110136005)(478600001)(2616005)(186003)(4326008)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGQvSzNQRUxpR2ZIZjg5TUF5RjI3ZVRhRzhCV2dmS3FReE9nQmdIRllHd1Z6?=
 =?utf-8?B?SnlSYTZETzROZWJiREVGeXJpbVg5MTJ1V3JvT3BINXNSZ3M5TWpLRWVuNDFB?=
 =?utf-8?B?aE9MV3owbWRvOUsyWFJ4V0dUcE8wY21tWGQxeFBxbFhzMDJPQTdCd3ZrZjhm?=
 =?utf-8?B?eEsxTFRHeDNvOS8yanMrNk83cGxNMnplb1lSZkdJUHY0UWFHbmFlangrMWhh?=
 =?utf-8?B?YXJWQ2VDN2JnMW1OdTdTY01NeURBa3NJdEZXQzV1MkdnRjVLTDN1ZWEvbEp1?=
 =?utf-8?B?d2FrcGwrR0h5RXpaZHhMYTdQZlhNK1dPWW8xcHVtelNUVk9oMlJVaExKWHV3?=
 =?utf-8?B?WmZzaDJCdDVsMUsrMDRLZmxhdHFiekRSVm9rRnNlS3o5OTlFQVdQMXZTZEQ5?=
 =?utf-8?B?d25lOWZuTEhXYWRSNkcxNFgxQjRmWis2Q1B6amNDaDArazFIM1g3bTJnc3U5?=
 =?utf-8?B?RUhidys0ZU8rRTZtZVZiSzhyYndEZkNGdmlsMXVLSGw5cWRhSm9uOC82blQw?=
 =?utf-8?B?MXFBdE1JbGprbWU1UnpWeXdpTUN4MzRIMmF4TkxQK0hDK3pUT0pHNDR4TFNt?=
 =?utf-8?B?dldwalYwbTNMYzR3WjlReE9pVXIzZnYrdWdHRm4vOEFpZGFJbkZkSVlESGZ6?=
 =?utf-8?B?YUFwcE9DMGhPdW9pZUxtd2xiVGJFeUFkNmlDbE9JUStYc2dxWXU1L1RORUFn?=
 =?utf-8?B?SlZNVkNPVHFaVUhiM2RSWkFiL3NYOUIrRVVqSWtjRk0rSTcwYlUzbjlzaW52?=
 =?utf-8?B?NkZXZHlwcGRibWhIQlN3N2plZjI3TkJ1SUFvVFRlTGFvR0pkckFnNmk2NFZi?=
 =?utf-8?B?d3dyZXRaRTlmaTlabW8vQnovVFVadDd5ZnB4bHoxQ01UMlFtakFoMkVoVEgx?=
 =?utf-8?B?eW5TdFplK0ROclZ1WUVYTFJVenpmallDdUE5QW5DR1ZpMVlVaWo0LzArdlJz?=
 =?utf-8?B?Vm5zZlhDNmliQ240QXkyT3ZFTGphWnNOdUpldHc5UXdPekNsTDBIb2o3L2N6?=
 =?utf-8?B?TGtzdmUyYVo0UHB0T3BjVzFjcEdOVHk2RDZ1WUM1d0F5SHlvR2lCOEFhWVpT?=
 =?utf-8?B?ZjlhNHZXUnJVSTRMQW5uc0NjN2UraElvWUZ0ZWhUMk5JN3VxZGZLWmsySVcy?=
 =?utf-8?B?VVQybjc1UmZ4aEhEamk5UzZxWDZpRG01OXlZWXJ6NjRTSkU1ZXVmaTNnVzFj?=
 =?utf-8?B?d2pWbHFYRXlqQ0RNMkxteVFLRVVBckJyWVFFaFJjdDZKWHIyTDFyMEpQUkVE?=
 =?utf-8?B?MTI1dGlaMmZhL2lxK3U1eS9hcUh0MFQrRVlQMzJEeU5HNXRZelNSQUUrdEhZ?=
 =?utf-8?B?aVg0eW9HMm45RkpZZUE5dFhETWZqcVoxNnFnSk5XdGhSdzRjeitHM1g5RGRQ?=
 =?utf-8?B?UGJoeitkU1h1enp1TjBIU2tNL0g1L2pFdU5mWmVRT2tpdkp1Q2t5YjNTblJu?=
 =?utf-8?B?N1dYQVI4SFc2enlySk1ZVFI2dlVFNm5uMWRyUlNYVkt2N0h0UWNUU2dqTmVW?=
 =?utf-8?B?M3dIcWtUNjk1THZ1azhkNUlRb2J0bWJaOHFHRWNjYmhvTDdod3I2bWtoT2Fk?=
 =?utf-8?B?UmNHaEVmdFA4SDN0UUJqbFVSa2E4cUFkQm9uVFhBY3pnWEJhbFNzd2t3alRM?=
 =?utf-8?B?WEpEZHBwNU9rcFd5OVVvZXJkWmFXV0lSTmxKRklOcG5MaE9DRjIrRGs0UG9h?=
 =?utf-8?B?L1dFTkRtMWJDeEpNRW5Ga0lyYVU0anV6Y2o2WFExZjJ0alNPZFRiZ0NWUWJD?=
 =?utf-8?B?bzlUaGZPSnVEaW1IcEVxVXBEZkxTblpJZlhVTzZPSGVJZ2NCcFBGR0JXcU5L?=
 =?utf-8?B?NXlWS2pncitrMWxneFdOenorRnJyc2lDVmVNYTROdTl3TDZrNm9PL3NOU1Bq?=
 =?utf-8?B?S0tmQ0JFRjYxejNqVVZEQytucjRQVXJKU0RGdzNCTC91UjRWTEtHNytMMjFQ?=
 =?utf-8?B?YVZraDlHT2JseWN6SUY1Ym9sMC9aRzlZVnZmYkVkQkJ1SzRxV2ZlMVhhZGJ1?=
 =?utf-8?B?b09vMVArdXh3SnBvNXRraHNKdDhYSjJWMXJqaVh1RHlOVHBpMjJEc2dVYkI4?=
 =?utf-8?B?R2lRVm8zVk5tS29yQkdhTjBod3lDdUVUVVlBTmhZWENJdzdhekVpSE5FS0Zw?=
 =?utf-8?Q?rOExe6gKQv6ikKOGsn6kRckoI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa752a1-510a-45ab-5a15-08da770811b8
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:29:36.8178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: scISQqz7jl82EZUbmTw8NvV5Bj/UzSBGwiu2ezM8U60d871Md+PIxYvAc/jCTqqppKLcxOIIQ4S3aj9VGY9W7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB4681
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/5/2022 12:27, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
> use low-power S0 idle on the given platform than S3 (provided that
> the latter is supported) and it doesn't preclude using either of
> them (which of them will be used depends on the choices made by user
> space).
> 
> For this reason, there is no benefit from checking that flag in
> use_acpi_alarm_quirks().
> 
> First off, it cannot be a bug to do S3 with use_acpi_alarm set,
> because S3 can be used on systems with ACPI_FADT_LOW_POWER_S0 and it
> must work if really supported, so the ACPI_FADT_LOW_POWER_S0 check is
> not needed to protect the S3-capable systems from failing.
> 
> Second, suspend-to-idle can be carried out on a system with
> ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
> use_acpi_alarm is needed to handle that case correctly, it should be
> set regardless of the ACPI_FADT_LOW_POWER_S0 value.
> 
> Accodringly, drop the ACPI_FADT_LOW_POWER_S0 check from

s/Accodringly/ ccordingly/

> use_acpi_alarm_quirks().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/rtc/rtc-cmos.c |    3 ---
>   1 file changed, 3 deletions(-)
> 
> Index: linux-pm/drivers/rtc/rtc-cmos.c
> ===================================================================
> --- linux-pm.orig/drivers/rtc/rtc-cmos.c
> +++ linux-pm/drivers/rtc/rtc-cmos.c
> @@ -1260,9 +1260,6 @@ static void use_acpi_alarm_quirks(void)
>   	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
>   		return;
>   
> -	if (!(acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0))
> -		return;
> -
>   	if (!is_hpet_enabled())
>   		return;
>   
> 
> 
> 

