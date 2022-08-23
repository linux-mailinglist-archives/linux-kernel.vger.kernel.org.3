Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3312259CDAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 03:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239248AbiHWBQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 21:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239041AbiHWBQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 21:16:09 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2073.outbound.protection.outlook.com [40.92.98.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CDDE57E20;
        Mon, 22 Aug 2022 18:16:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNMPD2xnNMSdsy88fCNoc4HVQeLELHGiUa50pNRvAXW4soBgQ/U/BgN+ksTvySG71tbBYQ3JcCXC+MK2J3FdEDLCC3sUnBKiALQv74FFzEJPgeiYnPI/vo721HTvLE+9qyXWX/NtKPLTTsRUEgoCb5RSD8WISEZLA0ye2M+nSVlgA0N29BjrxVJvS72IE0dnSn+3+ckxp9l1KecUDPYt27ZVEqOBP3ZmfUjvQupro11hMNSkkTKjWHSl4LOln1sDgPWyOU+14PPiHJzPjPZdzPCqaUTmyAWwMsPiROZkMwHAff6Knzz/aTmk0tvt4xT0nEdqVgix+/V5UtUwHGjdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOXNdVlwGa9ySUhb+/DMpjf1zb0cX1a20zFmHQf6/Do=;
 b=ocPJ/1r29/KXU7QlPCgrnPCjEpFulYAGejvXTLz1TWscOBvpvZjJibZfWjTJFHFeRROk2WFYJikpBcSO9mQKHlLYoXGAPG+XZMtCUE9ZAh/wk0pRSYk/HHUZ+ptJd31B0oDFzGZFvECNjvxtT3f9+IAQ1X5Wn227uSmHT5AUStu3acfDC+hP5FW4xgIsUmjGS4Mgtf9cYAMzL27E4zWEVaadEfsutKgnSJ6QMAflUF7ijbQ/qqODHznknsAhq9klTFzwAKle61b5Q6wRMLg6E5aE7kzYCIiWgQPtJOXSq0yIIp6d8kPrr4LlnSYh6AawgDezJQ/fCF4FKE+Yowk61Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wOXNdVlwGa9ySUhb+/DMpjf1zb0cX1a20zFmHQf6/Do=;
 b=cgl74bCA+ZRs/bHB50wP/AvgzU1+iBB/Vepmb/cmBhI33VOdeQnG9P/i6j5x8rvGf+ooc1wxAw5g3KiPe5ttn1FbNuSPyZyE1jkj+a/uhF820JdUfy6QuKvs/jYDcqhX4K3oITzod7rUCY/HTkZFBgpGL9cT2OY8hO3S/YZ9n79FsS8sdcx3Soom6PCPtThQhnvs17wu9MmX5AQsRm/PomF8wWd2C9I5MvLs0SG98/pVJPHAstTtl6Wt04YgO+DOiOenR9pjWq0VL22oCbOoeHTaYlimjOQ9y+APyWRtcopLmY2irEB8DfGuiucNFp3c20lBDcGZGfNmmzQx37uegQ==
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
 by OS3P286MB1239.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:120::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Tue, 23 Aug
 2022 01:16:04 +0000
Received: from TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2]) by TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
 ([fe80::45d6:a31c:aef3:a3e2%4]) with mapi id 15.20.5546.023; Tue, 23 Aug 2022
 01:16:04 +0000
Message-ID: <TYWP286MB2601BBED3F396FD334CE3266B1709@TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM>
Date:   Tue, 23 Aug 2022 09:15:58 +0800
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
From:   Riwen Lu <luriwen@hotmail.com>
In-Reply-To: <CAJZ5v0gx+eY-wOHmVip4VTCwjco=_yeSX5t76q39dUKyB7vBiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN:  [ZXyg7FEA+JFjYcs4TAxypbDHF8dH2mAAt66fYSVq9v4=]
X-ClientProxiedBy: SGXP274CA0015.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::27)
 To TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:248::14)
X-Microsoft-Original-Message-ID: <05904d26-e6ae-f627-f703-7db9b56b1139@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6629821d-3d6d-4d92-a02f-08da84a50c4f
X-MS-TrafficTypeDiagnostic: OS3P286MB1239:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+U1iDFejOlmtm7TcfV6vLgLCkQf7/nMVG16n0gi00dPo9l6n3sMUa1paauI12hKuEU7aV9NR+sjtOVbBlmp7blo0te5uHii26ldC6mmKsZ4ZF+3IPVKQV1HzREmk6TdMVUa3/vqw7r33DVpH+MMV1FO2kPI6nRIpDjbeezG/n1/gOYJKJKg0cXiMhyG25w1TzmWwVr1X4hFK1X0pr5fRB95d/rcNplwLdZnz8JU6u8Hi6bs04Yx3147/VpheksJEqQjlbDjIrJx5H6nwlCCN3Vm/SE8l8Fl/OcH8liMaPQrhfS5vtxeMJqiM2Q33+XJAA0cyhrezzw+9sfPX7w7bdWvveKFVtRvLkUahaUjnzPIqNaKXLC+5uBfqlkX0ASd/ypF2v8j+phvKF+g8i30ryL84NndNQSExUOqFIoon9mKUCKZklhvOwYelDcJOzds3MwqqUvES3XiMI0DssEkzsE6k4MFboM+jc8FBqx2e9KGD99rH/NIvKxf6Z9Wav80jiRa6XxYFa+FT1p2I0VGO+2QfJhBHxpYqoN1g0Rw0zNjFBqqzxkWAYIuJ6uWqX+oZz4ttgT0rWHnoHTU7PdwnwP2XO4eIn8/Hi5vVqrDjz68ZxRPbZ2p3sLW22vnQ1uWvi+tRF5plKSOk/VvLO1zx5x11PUAsmavrP53cbznauHglE9AXJKda1jmjNsVCn6e
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVc0bnpuOW43cy9JdTV6Y2NmZkd6NmcxR3l1OTNuZFl5NU5aOUpkSHp2S1dI?=
 =?utf-8?B?MWF0b3FiV3FvT0VNbzJEWCswZXVPaVB4RnVLeHVwSEo1VEZmWW41NVRPSWRy?=
 =?utf-8?B?WFNxdjl4UTRxTFdJVjdPSkc5aEJROUJ1ZDZuL0RrUGt5ODBiN2RmOGU2YmpN?=
 =?utf-8?B?U3RTdjk0RHhCMFlNWVFCNzVONjFqRzJ2UVFSOTVRSmRVREgrRFFRcVVFc1R6?=
 =?utf-8?B?aHF0bnN6blhuUXZhMXRJTC80ZDJ0cnlnYUl2MzJ6VUdPRS8zaWQwRi9HSUVB?=
 =?utf-8?B?VWZtTGJHQTVVMUNFMUFJMDZ6R1RrQjBLUjJPZnZjemlvdGV5RTQ0c0tpMGR5?=
 =?utf-8?B?dnEraFA4RW01dVNrQ1A5bGhCQUNmbmY4R1I2aTBUdldINkFCcUgvOUIrRlZQ?=
 =?utf-8?B?dmFhVzVYRnJxNnRNME5icTR3ckVtN1NvSzM2WnZiNWRRVTBnbnlUSHJwWkl0?=
 =?utf-8?B?ditVVzA3V0hVOXFNL1IvQWMzbUdyWDZveG9udGhwb0xLRkpKajlDWHh0RTA4?=
 =?utf-8?B?QzB5ZkxQRDVMU0tnbTVCM0tMSVBDSXhZNzlaN1lCV2diS3M4ODBKUUdRcmkr?=
 =?utf-8?B?emYyT1h4dlZWUDNPb3VpWk96U3ZKdEdPU3RVVVUrVFl0cUZGQXNETVFPaWtM?=
 =?utf-8?B?dXJRelFLZGE1S0RlVC9SMjZZZDlNWTI3Mkllcno2MUdUZTd4ZXBmWnRLOHRm?=
 =?utf-8?B?eVR1aDVZOU5NcnJCSFFlV0pGaExxTzJRcHVKV3hqc2ZOVjdqRndhaDhXQm1J?=
 =?utf-8?B?bE1zNzlqbW9lSnhLK3dGOU1meWdmd1ZvL0JNRXBUQmpqQ0xyeERvK1NSV2hk?=
 =?utf-8?B?dTczY0pzT3ZQbjQxZVRLaUZTeE1OOWZ5TEppTExPbXBFaTVFcGluZ01BcDdQ?=
 =?utf-8?B?OUVyeXRRUDBiTm9CbW50Ui9LRVpIZUg5ZjE4VTJaWENWallCRkg0VUl5SGM1?=
 =?utf-8?B?VjJpMGdvQUdVSUs1RlpqRUlZSytCSTN2bk5qWFplOGJEN2Q0WGd4ZVovMndX?=
 =?utf-8?B?RzFEMm01ZHRvMEdrRlh4Y1ZWcU4vQUg1YU9UV0RyRW1XU1Y1bXBkZElwSHgr?=
 =?utf-8?B?NHV1ZzFQeTZWamFNS0MxK0RhemI3UnNXNHYzeG9UV1A0RlFLZnNRTnBXQjk2?=
 =?utf-8?B?aUNyMHBtT2RueEpmclV1ci9DQlFuYVlUaFpneEt6SnBFTnlxNlZPd245T29u?=
 =?utf-8?B?Ylc4UFJiSXhuMnAxZjNVQVNuS3phNUd6YktOdWNHMkwrZnVZSE1iNFd3UEJM?=
 =?utf-8?B?T1k1NHk5U3MwRm5GTmxqY3JSYWN1WUpHeFlzU1BWQmplZG5XcmRoaHVWVmtp?=
 =?utf-8?B?MHJYdWd6RDRZRUFYeWpIL0VTMHpOdmpuVmhTKzBSK0dTVDNrMU5wRUpReVd4?=
 =?utf-8?B?VmFUQ1VsWEcwWUo2bUw4RnFCYVQxVUZvYmNMSWVvMkxYaWNMVTJudjJWajd6?=
 =?utf-8?B?RHRNTzlKNXdaYTJrNmRPRmQyRWxRY1NxYzlRTHRhVFBtTmd0M0RWaVdjQmF2?=
 =?utf-8?B?c250MThScS9menNxUmh4bDVOc1k5S3Y5dE9PditwS25hQno1YmxYUXB5dWkw?=
 =?utf-8?B?VkhZa3gxa3VmUUZBb0diNzJCaVBRVUN3bkpQMWUvdUd1dGEwdHBTMEhaakM2?=
 =?utf-8?B?QUorQlRhM2RZSXJpZjYxeWhvT2l1RlA5bWMyVzR1U2R2U2h5cXpjS0FTUmhT?=
 =?utf-8?B?WmVtMi8zcEZZeXRCRzNmNjRjZ2JXbGtyVkVlSUp0d0J6Nk5FWHpLSExRPT0=?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6629821d-3d6d-4d92-a02f-08da84a50c4f
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2601.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 01:16:04.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB1239
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/8/22 20:25, Rafael J. Wysocki 写道:
> On Mon, Aug 22, 2022 at 10:19 AM Riwen Lu <luriwen@hotmail.com> wrote:
>>
>> 在 2022/8/19 04:23, Jeremy Linton 写道:
>>> Hi,
>>>
>>> On 6/16/22 21:51, Riwen Lu wrote:
>>>> From: Riwen Lu <luriwen@kylinos.cn>
>>>>
>>>> Commit 239708a3af44 ("ACPI: Split out ACPI PSS from ACPI Processor
>>>> driver"), moves processor thermal registration to acpi_pss_perf_init(),
>>>> which doesn't get executed if ACPI_CPU_FREQ_PSS is not enabled.
>>>>
>>>> As ARM64 supports P-states using CPPC, it should be possible to also
>>>> support processor passive cooling even if PSS is not enabled. Split
>>>> out the processor thermal cooling register from ACPI PSS to support
>>>> this, and move it into a separate function in processor_thermal.c.
>>>
>>> It appears this commit 7fdc74da940d ACPI: processor: Split out thermal
>>> initialization from ACPI PSS
>>>
>>> Is causing the following:
>>>      41.341659] ------------[ cut here ]------------
>>> [   41.346280] freq_qos_remove_request() called for unknown object
>>> [   41.352251] WARNING: CPU: 3 PID: 1089 at kernel/power/qos.c:597
>>> freq_qos_remove_request+0xa4/0xc4
>>> [   41.361152] Modules linked in: nf_nat_tftp nft_objref
>>> nf_conntrack_tftp nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
>>> nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
>>> nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
>>> nf_tables nfnetlink qrtr bnep sunrpc vfat fat btsdio brcmfmac hci_uart
>>> btqca cfg80211 bs
>>> [   41.413245] CPU: 3 PID: 1089 Comm: rmmod Not tainted 6.0.0-rc1MINI+ #237
>>> [   41.419951] Hardware name: Raspberry Pi Foundation Raspberry Pi 4
>>> Model B/Raspberry Pi 4 Model B, BIOS EDK2-DEV 07/18/2022
>>> [   41.430990] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS
>>> BTYPE=--)
>>> [   41.437955] pc : freq_qos_remove_request+0xa4/0xc4
>>> [   41.442752] lr : freq_qos_remove_request+0xa4/0xc4
>>> [   41.447550] sp : ffff80000a4bbb60
>>> [   41.450862] x29: ffff80000a4bbb60 x28: ffff07858798a1c0 x27:
>>> 0000000000000000
>>> [   41.458012] x26: 0000000000000000 x25: ffffdf6ade80f850 x24:
>>> ffff07858b07d200
>>> [   41.465158] x23: ffffdf6ade812cb0 x22: ffff07858b07d000 x21:
>>> ffffdf6ade80f850
>>> [   41.472303] x20: ffffdf6ade26b998 x19: ffff0785809ba5a8 x18:
>>> ffffffffffffffff
>>> [   41.479447] x17: 0000000000000000 x16: ffffdf6adcc25320 x15:
>>> 0000000000000006
>>> [   41.486592] x14: 0000000000000000 x13: 7463656a626f206e x12:
>>> 776f6e6b6e752072
>>> [   41.493736] x11: 00000000ffffdfff x10: ffffdf6ade8fd520 x9 :
>>> ffffdf6adcae53ac
>>> [   41.500881] x8 : 000000000002ffe8 x7 : c0000000ffffdfff x6 :
>>> 0000000000000001
>>> [   41.508026] x5 : 0000000000000000 x4 : ffff07863b7ac450 x3 :
>>> ffff07863b7b8bb0
>>> [   41.515170] x2 : 0000000000000001 x1 : ffff281b5d54f000 x0 :
>>> 0000000000000033
>>> [   41.522315] Call trace:
>>> [   41.524759]  freq_qos_remove_request+0xa4/0xc4
>>> [   41.529210]  acpi_thermal_cpufreq_exit+0x90/0xb0
>>> [   41.533834]  acpi_processor_notifier+0x74/0x90
>>> [   41.538281]  blocking_notifier_call_chain+0x78/0xb0
>>> [   41.543161]  cpufreq_policy_free+0x154/0x1e0
>>> [   41.547438]  cpufreq_remove_dev+0xc0/0x10c
>>> [   41.551538]  subsys_interface_unregister+0xf0/0xfc
>>> [   41.556335]  cpufreq_unregister_driver+0x54/0x120
>>> [   41.561043]  cppc_cpufreq_exit+0x28/0xd2c [cppc_cpufreq]
>>> [   41.566370]  __do_sys_delete_module.constprop.0+0x150/0x2bc
>>> [   41.571947]  __arm64_sys_delete_module+0x20/0x30
>>> [   41.576567]  invoke_syscall+0x50/0x120
>>> [   41.580318]  el0_svc_common.constprop.0+0x4c/0xf4
>>> [   41.585023]  do_el0_svc+0x38/0x4c
>>> [   41.588338]  el0_svc+0x34/0xdc
>>> [   41.591394]  el0t_64_sync_handler+0x11c/0x150
>>> [   41.595752]  el0t_64_sync+0x190/0x194
>>> [   41.599416] ---[ end trace 0000000000000000 ]---
>>>
>>> When the cppc_cpufreq driver is rmmod'ed from a running machine that has
>>> both CPPC and a thermal zone. I reverted and bisected it, and in both
>>> cases the splat above goes away.
>>
>> Did you enable the option ACPI_CPU_FREQ_PSS ? When I reverted the commit
>> 7fdc74da940d and enable ACPI_CPU_FREQ_PSS, the warning above also appears.
> 
> AFAICS, this option is enabled automatically on all architectures
> other than ARM64 when the ACPI processor driver is enabled, so I'm not
> sure what you mean.

I mean the commit 7fdc74da940d is not the real cause of the warning 
reported by Jeremy Linton. And Jeremy Linton‘s hardware is Raspberry Pi 
4, arm platform.

I've debugged it in arm64 machine that has both CPPC and a thermal zone: 
If the processor thermal registered, and rmmod the cppc_cpufreq driver, 
the warning Jeremy Linton reported appears. Otherwise, there is no warning.

I'll continue to debug why it cause warnings.

Thanks.
