Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D2D59D016
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239389AbiHWEdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239289AbiHWEd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:33:27 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2049.outbound.protection.outlook.com [40.92.98.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B9112ACE;
        Mon, 22 Aug 2022 21:33:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCul0Q2T/kJgiqZmZ6dxJqcGJkpdR+OW9w5kb0LEw03jDg2qrAZyzeQQv6LYU7RgnZ2Pib+gpr9VNj9wNK0AREdHWLPO81rcMrLhLiyNZ4Cs5jbvvhvcphikbPp0vQLYeibKWt+TQhZn+sD89usT/3x3sJxc8ztGNbbxmTDsd27M1ciIz0X8W7cFgC0b7RYFDwuI+r10Mnp+h5JGcyR1vT0QubfwrcPn+cgtQZ3N1pD5eMwnqYhwJLJ5QMFn4Mv7wJcODW8E9SGQ9vKJh0llvqUUv2kj8kWp2UZFJI1QYs8HqkdBkXHHKpg95K5ZmaDX4LPPz64wdhSEld9Uy/w1fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIPek2nsz/ImkZpDJDiPkkMCtAtaU8fbdxO+MFrMR0s=;
 b=d9Eeo0ywRLUqXXWEJr319uYcVK1AKjkyETGBl2OBh/O/uVjTYhK9EtSzhQJTyKrwiWfRWyrRTMKP8zgS/MCmElc1fSTaA5sPcYSoXwUEYN7ZjdICj7t540/nF6fDx4pAPpJuZQbIK2R5BTUFcJmXgBzmoebtsNpiX8jQjIuW5CJL5xAQZxC9FtR6/oHNLh3eGtUcwlk1sBmty1vuhedDhY7ulKAyQF7pEtYLoI+PSDAHUrZrBq0QfCXtjvJf8Wj7TTW7dvF+VUtBVLrbdoZ9TEsXB43evvkHwcnV6doht6qETJkDt/7+d4j/d+Otnln+5Y5xpRd+V3L1RV5ho8CT0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIPek2nsz/ImkZpDJDiPkkMCtAtaU8fbdxO+MFrMR0s=;
 b=Atau+hjfCQkurmunu2XoFbj4X/K4+6X1q9q58Z/hak5FcOfqFXPt6kHORBl2fcAV2SO8caKUcpC1kjuwELIlzWyfUUB28tBQjT0c70rAXaF+QmiR+8F7OWj/eW7mHobEtTJzZUz1BoP0Wym4t/H0FOYRVNIjTqcUkHSoF3ImvxhF7vnTvykObBRmD1Vx3Q31W39X0tJmGexgsZtqGBEvPllVU9oJkA7hfvMdb9Np2exQnvkuAgbXy81P6o32VxiNeTxFRlOyDDBBOkutGE+bZWevpZ1O6TGULJbR5zO4tJF5QYDqcCAty/JU6uk7QhVLELDIEgpFCHevf/xMi3S86g==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by OS3P286MB2565.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.19; Tue, 23 Aug
 2022 04:33:22 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 04:33:22 +0000
Message-ID: <TYWP286MB2601932308C37E9ABC224FB0B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 23 Aug 2022 12:33:16 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: Bug: Re: [PATCH v3] ACPI: Split out processor thermal register
 from ACPI PSS
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jeremy Linton <jeremy.linton@arm.com>, Len Brown <lenb@kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        Punit Agrawal <punit.agrawal@bytedance.com>,
        Riwen Lu <luriwen@kylinos.cn>
References: <TYWP286MB2601965DDE4D251807F70415B1AF9@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <6e61d429-9020-53f3-458e-bb265d47b8f4@arm.com>
 <TYWP286MB26016A8EF8040BE37DE9A27BB1719@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
 <CAJZ5v0gx+eY-wOHmVip4VTCwjco=_yeSX5t76q39dUKyB7vBiw@mail.gmail.com>
 <TYWP286MB2601BBED3F396FD334CE3266B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
From:   Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <TYWP286MB2601BBED3F396FD334CE3266B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [itS8Ikkm9vYvndn9lvF4oCMIdYU7a+YMLR0rN3pqnWk=]
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <4c94b8c9-c387-3c90-7c41-cb96d2dfbad3@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66661dbc-71c4-40cc-bc99-08da84c09c4d
X-MS-TrafficTypeDiagnostic: OS3P286MB2565:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZolpKk/eU8Ac1/B51tAg63VTsc/mZhq+o2myCDpR23jM2WNnG/nrwHtJ+NtKjn36N+PRthspbxf+XyK4E+TFvwJLRPBwBv2cyYYEmjmPYj+zNi59EEbKOTuGqBnl8mt8rK5AQLNKICVs4bPJqU2Ed7/INeUl+e4SkybVLQVkD43PmJKAYcHERBUkOvCdArEt3D6VVvmpjT1lI4K9f+YQkHPEe0CoD1BAHXbyUQiQOEqZQlzIYcPizUb40TUI1Hg1lXRX1rkc9NQa9dOmQiCICaZmxGxVd5jqljQKXphGKYMZXWqQZ77JJaAy/PcIt8qx958Sl1GP5CpHnComnSIQiQ5DlTc9C6suj4RciOi4sa7qMapzr3YYodBf+sAWU9Ad2bOoDQE7rrAjX0z+kDb+J6QOJ3Byp2koWCOmzNXW8w5mH0kZGlWf+nw3WResprgPjoHRFMl77Yc6qeGbOWIymrwp5MiL1JgpRBoI9L8DJ3JSn4RADhvFfY3M2WaWJNKMoDK2m+XYhcSGBoO4ViBCTG6crq3rStJKhXjBLuLQzRuTNpQVOuCupAn1x+WeWsSQA11ga2mLYGMwy+vKFlvPnMilQdUHFXBfl8I9mUPuAnuBqvbUfXcdLCmxJ1cUftsqyvvpNyEEB61QCtwYewc1WluyZh92N5KeCVtZCcQeqTQofM01n6nUiRyeA/bm8tiL
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJUZkh5UE5QSVNMVEIxZmZUNURyNng3MHoxS2kvUCtRek5WdEI4NXNNQWlF?=
 =?utf-8?B?ZG9kQzJocWcxazF5TGpJdDl4K0ZqN21VODc4cVlNclRHUTA4cGNXOGU5bHkx?=
 =?utf-8?B?V1IvNksyMnd6SnA2NlJnckZ3Wk1JS29BNkViOW9qSGNVWXIwdEhhLzc2SFdr?=
 =?utf-8?B?cjRrOXF6Zzg4b3Z4UklhdmpVOG81SDJIMjluemlhU0g3NEUxVWlSbkhERytU?=
 =?utf-8?B?cVdEUTdvT1R2ejlsZWYwT1lVYllnVXNxckxpREorL3hNdzZnbDN1VmJzKzhH?=
 =?utf-8?B?WVR1RXFhdDMwNUFNQkxyOGg4WkxTK3JMeWZHTUxFajlhMEdnVEZmUVJuVEp5?=
 =?utf-8?B?ZVkybFVJelk1aHNCdCtmU3dKMmUyVU1heFhCK0twckZ4TUdMYitYQ1JzeWs5?=
 =?utf-8?B?WGx4ejIrcmJEVXl3cjlnVUx0N0JjVDBLd2lsa3A3b3VGenFadWlKd2J6VzY3?=
 =?utf-8?B?OHJodnBGeitiQWNDQmZFQU5GYThJQzcyR1l0dXNHMUJkTDBZVXRZRnFZbDBi?=
 =?utf-8?B?QmRaWVBwQzBHbmlUNEN3UkFqcWJncHVibWFiaFBrTXREbVo2WWNyVTh1SzZ1?=
 =?utf-8?B?d0VHeG1BcFptYTdOSUwwZURFM3NtcmNYM3htaDdsUUxQODBQOU5oNjlrd1M4?=
 =?utf-8?B?ZXlHQUZ6bnZJUmNWQXdOUjBZNm94WVZlcVg3cDFlUmN4U2JmR2REZzJaNkd3?=
 =?utf-8?B?UmdPb3BuWjhzRGtrTXkrdS8zYXNPQ0cxV1ZSQTUwNFBueTRiVGRjN29OL0VG?=
 =?utf-8?B?R2g0cWV5WndHVytyQTJKZkhpUkF1QmhnSmdpazY2R1M0MU5VQkw3VkV5cE5s?=
 =?utf-8?B?K0FFZ0MxeUhsZTB2bUNBSURnNXpLVXdlU1UyWmV5UjRzMStvNEpzVzlRUStm?=
 =?utf-8?B?V2hHb3RuWm90bnptSmFZQ3RBRC8vUHI2VVpZMzBUS1R1QTdib1Q3cFN1dnpL?=
 =?utf-8?B?aHJTOUhsZTYxUHFQVkRpVEYwZ3Q5MDB2Um1WZDkrbkszY2JuSXo0NkhmbnI2?=
 =?utf-8?B?QTlUNXkyaHRKMW9vd3pqSHI3YjlLZHEyTmkyTkFmSDlhT09lMHFta3ZOcis2?=
 =?utf-8?B?OHFpemVIUlJtamY2QmlqaXYwUG85UlNGRThJUCtPZjRMM0dTMHIzNDlTMzAx?=
 =?utf-8?B?UlhZZkt0cDVTNWloUTlKeG5CMnQ1WHdEK1Zwd1dHbHFVd0JJaUtSVnRKdG1u?=
 =?utf-8?B?RnZ2T09pVFV1QUFvc2FUTnVBNFdXemVrZkU5a2UwRzVMMHJMYW8xeUdUNkdl?=
 =?utf-8?B?V0JJWE5ISWRCTXJ5UnFKZFdWQXZnMXhjVUt5bi9CSmI2WmVaMHFSY21STDlz?=
 =?utf-8?B?U1JSQUFPVmhTWUp2U0dwcmpEbDlxRDBIZnRpclhwQ1VMbzYxV3pVbVh5Uity?=
 =?utf-8?B?aU5ZVWk2RkxVY0NXNTZtdXZCR2pFRk0xTHlOWHROTVdTcDhrK3FVcFJQcURx?=
 =?utf-8?B?R3B5M2hEUkltbUFWUDBWMDVaL1RwdGVjc25QQStNY1J0V0xpaEtXZVEyK3hS?=
 =?utf-8?B?Q0VVWXU1ZDN1M1J4dEVERFJJWmtoU1lubmY3dnAxeXJ0K3U5WXVGcEtIT0kr?=
 =?utf-8?B?eWpyeUpPWU4ydXAyYWNuSDdicjlWcHQ5Y20rbDcxTmdxejkwbUh0OWJ1aUdD?=
 =?utf-8?B?MDFKVnJ6cnFOSFdVMFRaUzZ1VFdsWTJYZlphcXNzd243TmNFdEJYVkRmUUl4?=
 =?utf-8?B?dGZmTDRybVFnUUdOYkQ2RjZKVlZ6SDMreDlldVY5QVpXNjJVS2dXWUVRPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 66661dbc-71c4-40cc-bc99-08da84c09c4d
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 04:33:21.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB2565
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/23 09:15, Riwen Lu 写道:
> 在 2022/8/22 20:25, Rafael J. Wysocki 写道:
>> On Mon, Aug 22, 2022 at 10:19 AM Riwen Lu <luriwen@hotmail.com> wrote:
>>>
>>> 在 2022/8/19 04:23, Jeremy Linton 写道:
>>>> Hi,
>>>>
>>>> On 6/16/22 21:51, Riwen Lu wrote:
>>>>> From: Riwen Lu <luriwen@kylinos.cn>
>>>>>
>>>>> Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
>>>>> driver"), moves processor thermal registration to 
>>>>> acpi_pss_perf_init(),
>>>>> which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
>>>>>
>>>>> As ARM64 supports P-states using CPPC, it should be possible to also
>>>>> support processor passive cooling even if PSS is not enabled. Split
>>>>> out the processor thermal cooling register from ACPI PSS to support
>>>>> this, and move it into a separate function in processor_thermal.c.
>>>>
>>>> It appears this commit 7fdc74da940d ACPI: processor: Split out thermal
>>>> initialization from ACPI PSS
>>>>
>>>> Is causing the following:
>>>>      41.341659] ------------[ cut here ]------------
>>>> [   41.346280] freq_qos_remove_request() called for unknown object
>>>> [   41.352251] WARNING: CPU: 3 PID: 1089 at kernel/power/qos.c:597
>>>> freq_qos_remove_request+0xa4/0xc4
>>>> [   41.361152] Modules linked in: nf_nat_tftp nft_objref
>>>> nf_conntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
>>>> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
>>>> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
>>>> nf_tables nfnetlink qrtr bnep sunrpc vfat fat btsdio brcmfmac hci_uart
>>>> btqca cfg80211 bs
>>>> [   41.413245] CPU: 3 PID: 1089 Comm: rmmod Not tainted 
>>>> 6.0.0-rc1MINI+ #237
>>>> [   41.419951] Hardware name: Raspberry Pi Foundation Raspberry Pi 4
>>>> Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 07/18/2022
>>>> [   41.430990] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
>>>> BTYPE=--)
>>>> [   41.437955] pc : freq_qos_remove_request+0xa4/0xc4
>>>> [   41.442752] lr : freq_qos_remove_request+0xa4/0xc4
>>>> [   41.447550] sp : ffff80000a4bbb60
>>>> [   41.450862] x29: ffff80000a4bbb60 x28: ffff07858798a1c0 x27:
>>>> 0000000000000000
>>>> [   41.458012] x26: 0000000000000000 x25: ffffdf6ade80f850 x24:
>>>> ffff07858b07d200
>>>> [   41.465158] x23: ffffdf6ade812cb0 x22: ffff07858b07d000 x21:
>>>> ffffdf6ade80f850
>>>> [   41.472303] x20: ffffdf6ade26b998 x19: ffff0785809ba5a8 x18:
>>>> ffffffffffffffff
>>>> [   41.479447] x17: 0000000000000000 x16: ffffdf6adcc25320 x15:
>>>> 0000000000000006
>>>> [   41.486592] x14: 0000000000000000 x13: 7463656a626f206e x12:
>>>> 776f6e6b6e752072
>>>> [   41.493736] x11: 00000000ffffdfff x10: ffffdf6ade8fd520 x9 :
>>>> ffffdf6adcae53ac
>>>> [   41.500881] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 :
>>>> 0000000000000001
>>>> [   41.508026] x5 : 0000000000000000 x4 : ffff07863b7ac450 x3 :
>>>> ffff07863b7b8bb0
>>>> [   41.515170] x2 : 0000000000000001 x1 : ffff281b5d54f000 x0 :
>>>> 0000000000000033
>>>> [   41.522315] Call trace:
>>>> [   41.524759]  freq_qos_remove_request+0xa4/0xc4
>>>> [   41.529210]  acpi_thermal_cpufreq_exit+0x90/0xb0
>>>> [   41.533834]  acpi_processor_notifier+0x74/0x90
>>>> [   41.538281]  blocking_notifier_call_chain+0x78/0xb0
>>>> [   41.543161]  cpufreq_policy_free+0x154/0x1e0
>>>> [   41.547438]  cpufreq_remove_dev+0xc0/0x10c
>>>> [   41.551538]  subsys_interface_unregister+0xf0/0xfc
>>>> [   41.556335]  cpufreq_unregister_driver+0x54/0x120
>>>> [   41.561043]  cppc_cpufreq_exit+0x28/0xd2c [cppc_cpufreq]
>>>> [   41.566370]  __do_sys_delete_module.constprop.0+0x150/0x2bc
>>>> [   41.571947]  __arm64_sys_delete_module+0x20/0x30
>>>> [   41.576567]  invoke_syscall+0x50/0x120
>>>> [   41.580318]  el0_svc_common.constprop.0+0x4c/0xf4
>>>> [   41.585023]  do_el0_svc+0x38/0x4c
>>>> [   41.588338]  el0_svc+0x34/0xdc
>>>> [   41.591394]  el0t_64_sync_handler+0x11c/0x150
>>>> [   41.595752]  el0t_64_sync+0x190/0x194
>>>> [   41.599416] ---[ end trace 0000000000000000 ]---
>>>>
>>>> When the cppc_cpufreq driver is rmmod'ed from a running machine that 
>>>> has
>>>> both CPPC and a thermal zone. I reverted and bisected it, and in both
>>>> cases the splat above goes away.
>>>
>>> Did you enable the option ACPI_CPU_FREQ_PSS ? When I reverted the commit
>>> 7fdc74da940d and enable ACPI_CPU_FREQ_PSS, the warning above also 
>>> appears.
>>
>> AFAICS, this option is enabled automatically on all architectures
>> other than ARM64 when the ACPI processor driver is enabled, so I'm not
>> sure what you mean.
> 
> I mean the commit 7fdc74da940d is not the real cause of the warning 
> reported by Jeremy Linton. And Jeremy Linton‘s hardware is Raspberry Pi 
> 4, arm platform.
> 
> I've debugged it in arm64 machine that has both CPPC and a thermal zone: 
> If the processor thermal registered, and rmmod the cppc_cpufreq driver, 
> the warning Jeremy Linton reported appears. Otherwise, there is no warning.
> 
> I'll continue to debug why it cause warnings.
> 
> Thanks.

Hi,
     I've figured out why it happens.

     In func acpi_thermal_cpufreq_exit, it get struct acpi_processor *pr 
through policy->cpu, then the qos of it would be removed multi times if 
the policy has related to multi cpus.
     It seems commit a1bb46c36ce3 ("ACPI: processor: Add QoS requests 
for all CPUs") forgot to change the code from policy->cpu to each cpu.

Apply the diff below, the warning disappears.
diff --git a/drivers/acpi/processor_thermal.c 
b/drivers/acpi/processor_thermal.c
index db6ac540e924..e534fd49a67e 100644
--- a/drivers/acpi/processor_thermal.c
+++ b/drivers/acpi/processor_thermal.c
@@ -151,7 +151,7 @@ void acpi_thermal_cpufreq_exit(struct cpufreq_policy 
*policy)
         unsigned int cpu;

         for_each_cpu(cpu, policy->related_cpus) {
-               struct acpi_processor *pr = per_cpu(processors, 
policy->cpu);
+               struct acpi_processor *pr = per_cpu(processors, cpu);

                 if (pr)
                         freq_qos_remove_request(&pr->thermal_req);

Thanks.

