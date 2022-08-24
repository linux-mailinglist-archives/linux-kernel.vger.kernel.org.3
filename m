Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D475E5A04E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 01:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiHXXz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 19:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbiHXXz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 19:55:56 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A03C146;
        Wed, 24 Aug 2022 16:55:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ER4Jj7+vk47JQ3Zlxzx3Ft+xiVkUkTkVIMF3ucuJyBH2zUUXvZbiC3qtGITuR22GD1FDQ6YZH9bozO4sNowebLHb9F/yYPUIyGr2YkHQLrMSMSuJ9BrkVfeXZ2j3+bdartPuCe+944t+j0j2nBQosCAAiyxGxxdkblqCALvbEGzxO6IVG+iyk9jWao99u50vXnjJGFZ5I8Ifld7yBCfLHbb6/AOfSrKjvsrPWuH31+FVn9CrRhGz/obiHmZHx5N6aTiRDIBpVy7ETDNGgY08qeh9wRh2q2c5LygOI4k6R42K+A3RLVGaUdrcimjzmIFtS5zouuuzUJojwwgpMKtPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RtTll57rKKpfTGEN56yDOJM17wGxY8c7ZOFrBaDCcME=;
 b=TnKcESYGmVkgtgr3iKgC5MMLSxxK6FSOeCA8Dwgs0fzEc+u1MQm0Zm62OT1c5HkaSXfAgS9OUsz8sTu84GEpu8WGRr7vF8bkUwMM/MSmb7BO5Mp330LVb8Rw86JYzuYpe9ThMa3bVJr1YxpHaAU4OwQ9B2tcF0Wb3J4xTPRMG5sMx0ZDoML/zuvy8I+3MgyuUwLnIzGO7KiTCat5ZX+gyF5I/ebRwjOsK7IJbKHQgD91VVfwgmxPA4Ye4xiwU46IK6D2OnYk5w9GV6d8061ZiYPgp/ME/wAdi7DkvywiupcFoS18XKiLA5nKaXYVipFZML7/d5cACTbRG957reth/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtTll57rKKpfTGEN56yDOJM17wGxY8c7ZOFrBaDCcME=;
 b=bEqxwhjZDqJoiEh6Jb9Dp0loDmk3lBOWZajXRNIYE+OEvtDZlOR/IGFGPlcsYDR+8adxNDi29UuXmsd4XhEHO2ueEDDF+jyJqOol6AwLAjvsOP/WLa/25meVMc8VTyWTK1qPcVdLJWWvSLznK7V8/iVIvHPWR8NET/b/SjOzC18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 24 Aug
 2022 23:55:53 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::e00a:1f8c:dcd1:afc3%5]) with mapi id 15.20.5546.022; Wed, 24 Aug 2022
 23:55:52 +0000
Message-ID: <0b70fc12-6217-147f-c663-a1035738cf7d@amd.com>
Date:   Wed, 24 Aug 2022 18:55:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] ATA: ACPI: Do not check ACPI_FADT_LOW_POWER_S0
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-ide@vger.kernel.org, Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <4426478.LvFx2qVVIh@kreacher>
 <9c479bb6-bb57-9b5a-2fa5-7b4d1b840245@opensource.wdc.com>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <9c479bb6-bb57-9b5a-2fa5-7b4d1b840245@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0010.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27dc11bc-340a-48d4-2191-08da862c2d89
X-MS-TrafficTypeDiagnostic: MN2PR12MB4405:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHNYlH2LhzqsGwm9XdS679lpKAa/9He22fJhdwfuxOElk2sWsRP3jSvdLaGaWFS9LHPNh4lhnBdDjISrTFRVkN/FhMfGhXw++ztnNjh7yC3TtO+jHqJFJJvpM8yx5jIKVbukJLZmWPHgZ4Af3wm1Lmq26JAN6BP5Odn8NQc7HcaFt40XTYn0FVKCCSbDSUmuIMDs3SwyT21HXp9iAjuPZfTP4PxFE/Z2sqGHojh0WR+zxEy0zJXVb3YISskyMTrTYe5ZkRdZZR8xo45zcwWp0x00TqHiXNgmCMMb2PUJ2Mhfyky+p13jlzkxrtw4p/sCiPUk56b3eUxFA+QTORHoCLthm70POhKFQekUSgmV4PT8J2RlM3KRXpNgENhXAq1JoPRkiJo9PzffQtQdG8MN1uVabUuQyrRImuy5xpMyuGvd4M8RkWibfNaaSEX9rbd/hwvQ0Sn+WfOkHklDqu7EQXO8rjsbgy2aFPRubkj7FycUbMuL4lSOnug2ua/1cb91n6hJldpMf4nv0PFeY3o+OM8k7enBPQVit/1l/8by6xZ4tpWO/OQ9kh8bp2lgapY6AzMSSkdeQ3k6YBxmYOiOpDt1Yat/8FQRI5oaTI8pWOs4Papk96RYhu5cljcqCROY3WFAoo2Fh3z5mvSdcEJFirACtb42rc/XPAnpLhg3ZSMDTofCwPhLbkVhKQlFciko6hoY8J9u97up1z5LdXhZOZynoG/NaWGcZ8AsP7J69RWZ2OxXp24jfFjTFkCEHb+bVhiystZKFJc2UgIbBwSxQnHNj/MiU5zgiLnGf5hSi2uR2M33Rh9TFGyUszSqsbeaaE+9I9SU6WRvUfGIm+MVTQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(66946007)(66476007)(38100700002)(8676002)(66556008)(110136005)(4326008)(84970400001)(31686004)(36756003)(31696002)(86362001)(2616005)(186003)(6512007)(26005)(6506007)(8936002)(41300700001)(5660300002)(478600001)(6486002)(54906003)(316002)(53546011)(83380400001)(2906002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bFF6WWJNKzZ3dS84UkhsSHB2MUdULzF2aThHdmNFNkkvYkIrdmdrdDFLbitJ?=
 =?utf-8?B?dnk0U2VCdmtVMmJTMEVuS1ZJd2l6U0h1Qnd2SXY3dHBXemFxVkMranE5Qzgr?=
 =?utf-8?B?Q20zNUt4djVQRXo5YVl0YUZhc2tVYVk3elRJTmpmcTIxSXBzUjdCU1JzMDZy?=
 =?utf-8?B?eTR4MkVSNUVDWFdWVklZOTBHMjFRSFJOdytoNDFvazNOS3RKVFQxdGNIZzNR?=
 =?utf-8?B?bVpZY0Y0Z1RHSXpYaDVlUGJPS0N5eTlFVjl0aWwvT21BNjl4K2FWdHhEaVlw?=
 =?utf-8?B?L0twVmJ0ZmdidGFJSHUyRjBvTkx5RzJtNlVwSnVJKzBtcjBUSmNtUU1oQjNa?=
 =?utf-8?B?WkxFOHFYU2ZUTUc2b21qNGhMaGROem1qejU2MUJHTHFwUnVOK1c3eTNWQ0Yr?=
 =?utf-8?B?dVBobDlrRFhjTEp0bjVrWDNrQVRtK1htUGFTMit3dE9BdDZQZGZuSXE1Yitz?=
 =?utf-8?B?V09JNi9yazROYkh2ckJDZjd5V0FTVy9MRkhEZDJzVzJzK3ZDUFVkbERvL2hj?=
 =?utf-8?B?Z2NJSjQ1OWMzd3lScUhyL2NNc3huOTl4K1EwMUtXQU4xR1F4N2pjcGZ3a1Fw?=
 =?utf-8?B?VnJYbHN5M0lCWDNkaGZ4ZE9mTytiR0JURHBqRWVwd0Jha2R5d09GMW1OeFd6?=
 =?utf-8?B?a1VUdWxoNjF2bko0Nys4cUJPWWdrRGhEUHR2YWFZTVhja25IMENJUU1sVGd0?=
 =?utf-8?B?bmFuZEMyQ2RnTnhJZERJcVZaalZCU2UweURaU1RKQWtqRkNJNTZ2ZWs4bzVi?=
 =?utf-8?B?T3BOMTExNitZdGVodUlLMC9ONG5EZzlWeVg1bit2SzJicVBOWDEvSGFLeWd5?=
 =?utf-8?B?d1lmSk1tSlpNUVgwd1QwWll6c29EcUl3WUpsdi9pd3FISWVkdHBhT1dtbTJM?=
 =?utf-8?B?WDZaR3pJNk90emczNVIyMzIvVm84TDhjUE9MVGY4WTQxRVJMV0ZEZnhKTEpG?=
 =?utf-8?B?TkVpWmVMYmhNdW50a3VBQ0Y3ODhTNDVUU2RQRE1vUHhsekFNZEM2ZHFGc3NT?=
 =?utf-8?B?MmF1TVdYUE1nLzQxVElPS3QxRDZueXZ3YlU0YzhNNEFxSC92UFZEOEhPSW85?=
 =?utf-8?B?REU4QkRRL29PSXZVU09lOGNleU5pUUtYK2hWMHFTK3J5emh3UGxtcnRHWTAy?=
 =?utf-8?B?U1YvRDd0L2hnNHFXSGRaaDZUZnpkU3IzUU9lSWFhSWsxV0E2RktQbUU0bTdY?=
 =?utf-8?B?Ym9FNEFDTkZjZjFhZWpVRGxKMjYxbzZxbzRqcWNCVnBuM0dHQlZuL3h6RFM5?=
 =?utf-8?B?MVlYUFVvdjZrTElrRVFBZHlNMXpCVVVCNHRzT0c5bDI1VXNUblBVejZiMGc4?=
 =?utf-8?B?Z1Nha3ZaV2gxUEpCMUhQRFNZS2pjUGg5QXFZRXp1dlQvd2ViVjNxeUZZUFZG?=
 =?utf-8?B?L2ZPTXZMb0d4UmRtMWlvTE5yTkgwTWptMjZpYmUycUVIR1FqYzBRRjEvQnBv?=
 =?utf-8?B?TDN4VWdkeWMyV1JHVWNFcmE4WStmeDVtcFkzRENJMzRHbHN1QjFldTlxeDBS?=
 =?utf-8?B?NHJ4VWtWZVhqZVR6cmt4MzdtQm9udEhmdzdra1JsSVF2ZjBsam52TTJFeVBa?=
 =?utf-8?B?Ti9FN0RmVzJTMU5Nc0RBMWxpdzVjcG9nNlNCbHRBdWNmSVU2M3p4WjdKVlJn?=
 =?utf-8?B?WVpJdWZEYVVqN012b3NTam9zbjM0bHlocXE3S1p5TzhWMEZySldoVEtYV05n?=
 =?utf-8?B?Wlg5VFA1a3Arb0YvbHBQUkxITTl2Q1BMbGozaFhDNkJNRmtCUzNRNnlaUnF1?=
 =?utf-8?B?RDlKK0Z1ZGgzV2FsblE5TkdYNUdrS005bFBzMHpLUmJSRm9zRjRvQzQ5R0tP?=
 =?utf-8?B?cC9PemRiQXNDWXpDclJ4ZkhpOExvTDlWZGdjbkNZZDhSVnQ0c3Q3ZTlUME1T?=
 =?utf-8?B?Yjg0YW1yOGhVbEdKSGYxTGQrc0psYTF3SnB4U1d0OEQrOFozYVlzZ1p0eG91?=
 =?utf-8?B?WFpiQktWbmE5VkxDazlxNGdLcE9VdDMwditnMVgzTGluS3pVMGxhUHkwcGFX?=
 =?utf-8?B?cVNxQ25QNDF1ZFE3VnZlZFdDdmxYT1l1NGhzaHE5d0phZFJhT1ZxNDI4N29n?=
 =?utf-8?B?NWl3dHNFRzl2Y0ZGbGJ5aU1JTHZGRTNCa2tOWGpSREN1VEJMM0Q0WUZQY3gw?=
 =?utf-8?Q?IpjHuq61hJPotlNkumw0LntyG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27dc11bc-340a-48d4-2191-08da862c2d89
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 23:55:52.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOw1NvAbh8Y1XKQbpSnedT0SflWKC6ou7ALfDT28BdFlx8+g868yk+c6hcKeyimrCzx5sBgiXjKwNkBclkUOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/22 18:54, Damien Le Moal wrote:
> On 2022/08/24 10:29, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The patch title should be "ata: ahci: ..."
> 
>>
>> The ACPI_FADT_LOW_POWER_S0 flag merely means that it is better to
>> use low-power S0 idle on the given platform than S3 (provided that
>> the latter is supported) and it doesn't preclude using either of
>> them (which of them will be used depends on the choices made by user
>> space).
>>
>> For this reason, there is no benefit from checking that flag in
>> ahci_update_initial_lpm_policy().
>>
>> First off, it cannot be a bug to do S3 with policy set to either
>> ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER, because S3 can be
>> used on systems with ACPI_FADT_LOW_POWER_S0 set and it must work if
>> really supported, so the ACPI_FADT_LOW_POWER_S0 check is not needed to
>> protect the S3-capable systems from failing.
>>
>> Second, suspend-to-idle can be carried out on a system with
>> ACPI_FADT_LOW_POWER_S0 unset and it is expected to work, so if setting
>> policy to either ATA_LPM_MIN_POWER_WITH_PARTIAL or ATA_LPM_MIN_POWER is
>> needed to handle that case correctly, it should be done regardless of
>> the ACPI_FADT_LOW_POWER_S0 value.
>>
>> Accordingly, drop the ACPI_FADT_LOW_POWER_S0 check from
>> ahci_update_initial_lpm_policy().
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>   drivers/ata/ahci.c |    3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> Index: linux-pm/drivers/ata/ahci.c
>> ===================================================================
>> --- linux-pm.orig/drivers/ata/ahci.c
>> +++ linux-pm/drivers/ata/ahci.c
>> @@ -1610,8 +1610,7 @@ static void ahci_update_initial_lpm_poli
>>   	}
>>   
>>   #ifdef CONFIG_ACPI
>> -	if (policy > ATA_LPM_MED_POWER &&
>> -	    (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0)) {
>> +	if (policy > ATA_LPM_MED_POWER) {

If making this change, perhaps the #ifdef CONFIG_ACPI can drop too.

>>   		if (hpriv->cap & HOST_CAP_PART)
>>   			policy = ATA_LPM_MIN_POWER_WITH_PARTIAL;
>>   		else if (hpriv->cap & HOST_CAP_SSC)
>>
>>
>>
> 
> 

