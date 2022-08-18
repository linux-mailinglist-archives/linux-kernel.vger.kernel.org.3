Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FA559806D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 10:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243457AbiHRIzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 04:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiHRIzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 04:55:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2091.outbound.protection.outlook.com [40.107.20.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E60B07E7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 01:55:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BeLYaV94jmVM3sJWUk5I5OeyzHhFA5bPvx0efD297s8CjqQvLPrsxFw3tdtE9tT5EZ/CiFi+3YC8Fm3bQjz7X8YPG/isX3Kp1qxR/4yn8jWb44STveqUrHYOZN/M1IcIP04zgEeoZ5x73kM2psFLIhcho4oida1WAvcoK/cZy4D8i0OzsnbbAyd5e8rwmssdg4Wc40VQ1mGvg1AsFj2AbHFUmAKZ0o8oKP7YajdZ9FZ1zXyN3ROMoFoq9j3tggye4A8J+rCyaX/yK4Eu5e5RtvJ1Qfl5lJirLDHoxxiytaUceoLQqEWk+6yPyPCJijcHkVcPgvw54IrhjUNcRbkUxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uNFYomDdppnL/6V0eqpjY/FxKCElxBWEPre6/BSe1k=;
 b=D768es1XO2loo/GZn/1E+wDCMXckx0wvqGAqc+dNpgM7WHWfxv7JQUdbznA7ITh31SD2CXEk7oNS35ZAiO7gErMCaLn8uaUS3in8msAjBG/efvm+kwRz0/OwQ+vSwNk79hKxosTPrhr8/3/UsKOMtBPq8jXpwPScX+yofgLOHUM3et0XMR9wrZH+K76bIpvKHQzO4e/HM6EDud6ybGqpkjxYSmVTJfyjjEMWO4tdyklOON1ipOa1blPH+tknk8ZRaFnCIm7J07u9QF6mspika7/Fr2oJDK3UTKNi17NZVm/AAeBYoFotKeLNEFYcL4DtDSeMTeORcnJFvZXWCkOWJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uNFYomDdppnL/6V0eqpjY/FxKCElxBWEPre6/BSe1k=;
 b=PiebNePLu8G2lroEsb7FYKit8SbfHziEaoFHEH2enwCjtbps9qh2eVBtK5DSBcowBz4A0SjvjxVXZ3J7d9cIxoAsOVUXOFzU9by8Rxfk1lcaJg0vF7rzj7iv5T5NZ3sBkfso80ZoKSej/9JAD339RQ128nDspL9jCyG8T9GPKUA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:34a::22)
 by AM6PR10MB3109.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.22; Thu, 18 Aug
 2022 08:55:31 +0000
Received: from DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84cd:fa2:ffc0:456e]) by DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::84cd:fa2:ffc0:456e%9]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 08:55:31 +0000
Message-ID: <54a68cad-f15d-bef2-8627-3d3bfb6f030d@prevas.dk>
Date:   Thu, 18 Aug 2022 10:55:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 7/9] mm/compaction: Get rid of RT ifdeffery
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Terrell <terrelln@fb.com>, linux-mm@kvack.org
References: <20220817162703.728679-1-bigeasy@linutronix.de>
 <20220817162703.728679-8-bigeasy@linutronix.de>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <20220817162703.728679-8-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:34a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 082080c4-6b2c-4c1c-bdcb-08da80f767c2
X-MS-TrafficTypeDiagnostic: AM6PR10MB3109:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msfUnS4ePLqHarTgKBwyr1OK37/3AGDk8umCr4Haa7CJjuwZpgMQ/v4Ss8d+zx1q1u0kDsuHAa/shwKy1u3MbJB6yaS9TgBhA1gou4gThZbvMzrVR95k1UaTxBEhtzcEAlcbipfYzG+S4EvZKmT7V/SnN8iBGtKSGIy1zUPEWrI37STkdzRVUtcKMSI0Wu56sTIbbPEF4FgctVxZN0ZqSywvdsc9qxbUFJhaxkG/exkB+bLb9EoC3Rb7+giuAKdq6z0/1rieWvNIFwv66Dh4C9rzBEE/Qu5cUYngheRw5uMLvPC3xHMgzElp3ixjaBJAn5NvWLRLdDj/J4kZ8UJBApc21ZXEBc5QrOrCJTZGrEcW5zpsPcuPzTnYfDMJ0WXhbpNBSuE86SRk2SlUohjtzXiEmTe0yBy6/2FVrjv0KaRB1LFI2evTbSIeHuG+mxRDTlVWs4Fn9x9sTjsYqu1wUWVJ1fBvtah66NMF3PUaUinsUqG6WspenZWCFVZaVT0hwXrXND92zNF8/iXorG4JAmcpMHCDAb2jnuQSH46buWSFkqrvMbO6awItSQ2mp0CoL4pyIXVYcVj3FpyqkaaxVjVTuaEofGOmdCAX5avGC+gWd9GsJN82rSsZQWq/y8K7gpzCzThyGHYgHMd8EhufXZbCkeDPq889VAsBicbAeoZiR8YJXLd7eSlOlGH3Hs5f0r9ym+Dlwb6ZIYKt3z2AM2R1RSdP3r6rIRx9DWzQVPVfSMX3F8OAZngELUtjebnx1/746zmwGQO2qcosmMSidJKMWKxChWKBSWPneX0gW3BYhuP86ztO0XYTRWVwr78oFMdxFmX6gvojHBg1sNOnVs6xH2x4jERqDpDZ69hF5Uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(136003)(396003)(366004)(39850400004)(6512007)(6666004)(36756003)(41300700001)(38100700002)(86362001)(316002)(44832011)(6506007)(2906002)(31696002)(31686004)(54906003)(38350700002)(66556008)(5660300002)(6486002)(7416002)(4326008)(8676002)(66946007)(478600001)(186003)(8976002)(8936002)(66476007)(2616005)(52116002)(26005)(26583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OERJc0xXRXhFVmowd1VockZOMkNZUVI3VW85Tm03cHpvN1RaZC90SHlpK0ZP?=
 =?utf-8?B?cmFvaDNESUFxeGJRamxZSGZ4ZG9DZE1ETk9iYkNobThGYThqR29oNEpib2t6?=
 =?utf-8?B?ejAveVpFbldzZkxnWHlESWt2RHVmRWlJcWZOcW9KODYzWHFmVG5jSllnNjNU?=
 =?utf-8?B?bWx5dmtrbzY0bnE0aGpOdmY3UkJMNldKeDBUOWk1ZFZYUDR0ZHA3UllaYVRy?=
 =?utf-8?B?TUNIZVFDOEZnTkVHTEtiSzkwTmVSeUg5aEVMU092cGFoVzZISWlvZnljZ3pK?=
 =?utf-8?B?alJOZEw0VlhCMWp0VkdNVWxVOFZrSVR1QUlKRDg5ZVM1M1g1dU5OM2djcE1Z?=
 =?utf-8?B?T3pWZURtT2FzWmp5cHZuY3NLdHo4U2V3UXNpcXVzT0pDbElsaU5TNngzdXJY?=
 =?utf-8?B?QjdZMVM0L3hCb0pCVW5uNFdoWnlRTGNheWdtSExQQ1g4cEVXTEFidG9hR2ZY?=
 =?utf-8?B?K1QxQTRYZFJKcTk4MFl5TThiNG9BTittKzQrREN4dW43SXVKY2NEWThCOUl6?=
 =?utf-8?B?MlVIZHZIVWJydENiNGp5cm1nTW80KzhDTld0Y25oWVFmaG9CVS9lTWJ1dmZB?=
 =?utf-8?B?VXFSVTlzSFVxN2NFMkNhZWpEMHJQTDRGbGhUSmE3bWZtYWxGb0w1SGx5UDc0?=
 =?utf-8?B?cHBiNkd2RnhhbkY1TUxMQkJBeUp1NkZPSkVEVExieEhISHE4ZzF0NWpxSWc0?=
 =?utf-8?B?aEpJd3c3bnJNa0JOYklCVzQwWEFmUko3OXp1VmNuSXZ2dWVFMnB0ZkNBeWts?=
 =?utf-8?B?TGJSeWVreUI2cFB1UXJsNmJVZkl3cUZOVXpSUldXMUpvS2Mvdy9wVlB2bzVB?=
 =?utf-8?B?SmVhemFlZElkTHc0cm9YZ1VUWllDaUJZS0gxTUpxbXhHYjRHMGlJTlBhY1lV?=
 =?utf-8?B?R3VoaDl2aHJtdEJiOC9OY2k4d2N5Z09HQlpVN2gzemZmZTFnVTlVMEZQS3RS?=
 =?utf-8?B?ZjlGVC9Gd1RxWlhtZW1mcldoUG00WVVOZlVCZG9zTVQ3ME9aWklSMjh5NmNr?=
 =?utf-8?B?ckdCVmV2Q1JBRlM4clRjY1ZyK05LN2NQK3ZpV1NMZHRKai8xM08zNjBZb0dz?=
 =?utf-8?B?ZU42WnVuWDFremJmVFNMVi9EbVYzcmZNajl2bFNWL0M0SDJSSnpEZThidUZB?=
 =?utf-8?B?RUhCN1ZOWklGZCtvUEV5bXdudVp4RUdRTjhCUlhQWFNvRkpwaERYbXR0WGpo?=
 =?utf-8?B?Y3c1Q0hGZldtT2ErRlJmNTkwNUc3L2JuNCs1aTI4am5HaXV0WVJuM0lQSnU5?=
 =?utf-8?B?OHJKOVRwVUYxN3dGYnNVMW1wU2RKNDFJRmswRXdxL2hZbWFwRjNxYmVRNkRj?=
 =?utf-8?B?OEN1TkkyWUxlL2dkVmFsdWlPajcrUjk3cGRSVzlPSHZML3hIcDlmSHNHZVBh?=
 =?utf-8?B?c05CblFNczFyejlRbG13TU02T1R1ZnBPYXhWenZQOWYwSktTaFhwUFdYQU96?=
 =?utf-8?B?UVVSeVp6c0x2cVNEcVp0QzBWcGl4QWZ5Z1BiQ3ErVEFuV01VTzlibTdMbTlr?=
 =?utf-8?B?Y0VpYVBCaE9QRDZ0NXpncVRFSkJ6WjBDb3YwNmxnb3FyNHlxOGNQaHJQSFlJ?=
 =?utf-8?B?YUlnRnBpcnY5YWhaWlVweGd3eE92b0FmeGNkSDJnRENVYnlaZ2wzWWZ5ajNH?=
 =?utf-8?B?ODhGcmlKaktTTWp5b1lXcE1XdVJwQ2xxWkJ5QXR0UXh6VDZIRVpyYXBPRm5B?=
 =?utf-8?B?N3Zlb3RNOExEZERmU1dkRFlaNlMwQjZiT0tCSzlMVDhXeTdoZ0ZRc09TQmRW?=
 =?utf-8?B?TS8zaHkvMFZFOEFZcHFQVEQ5TFNaN3FOZmxKbnI1Q3JZY2ZkY2lUN2taZUxi?=
 =?utf-8?B?Y0YxRE1pVytTeHB3ZTVnN25tUlRHRUdVeENva2s4RWdKcFlHbFhxV1YwTyt6?=
 =?utf-8?B?MFNDMlBJWjNsOVVCN1gyb1hoSUdVR0M3QVVXOGtOazhqZm44cGxlZnVSMWY2?=
 =?utf-8?B?bnZ2eWZMQUZUR1Q0akdzUmQ1NkdwTTRTVmZyOGdPNVdhdkdMSHRabkVpN25t?=
 =?utf-8?B?MGozU21JeW4xVlNSelozNUNGaWV2cXNQVnpOVDVMcmt2UEcyQmpmalNidFkz?=
 =?utf-8?B?NjY4UjVmeU9RZGpTbmxqT25ieUxhNm9EVnlCci9kS2RjbEhxRkV4c2FUVVZG?=
 =?utf-8?B?QllnaTJNb0NRL3dMQ2U1aWJpV1JYUEM0dER4MzZLdFVDcXhRT2Z5K04rREFF?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 082080c4-6b2c-4c1c-bdcb-08da80f767c2
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB5266.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 08:55:31.4483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sIMFZfmh/IM8Rd1DDMuOqo6EE7nx/n5Ow547fw434ZCMgCcNcM0+k7Y6pgPb2+l8xicTyGspJHMO7LUtO8ak6j4cVV3qB46GEN/OGdlt5UM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB3109
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/08/2022 18.27, Sebastian Andrzej Siewior wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Move the RT dependency for the initial value of
> sysctl_compact_unevictable_allowed into Kconfig.
> 
>  
> +config COMPACT_UNEVICTABLE_DEFAULT
> +	int
> +	default 0 if PREEMPT_RT
> +	default 1
> +
>  #
>  # support for free page reporting
>  config PAGE_REPORTING
> diff --git a/mm/compaction.c b/mm/compaction.c
> index 640fa76228dd9..10561cb1aaad9 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -1727,11 +1727,7 @@ typedef enum {
>   * Allow userspace to control policy on scanning the unevictable LRU for
>   * compactable pages.
>   */
> -#ifdef CONFIG_PREEMPT_RT
> -int sysctl_compact_unevictable_allowed __read_mostly = 0;
> -#else
> -int sysctl_compact_unevictable_allowed __read_mostly = 1;
> -#endif
> +int sysctl_compact_unevictable_allowed __read_mostly = CONFIG_COMPACT_UNEVICTABLE_DEFAULT;

Why introduce a Kconfig symbol for this, and not just spell the
initializer "IS_ENABLED(CONFIG_PREEMPT_RT) ? 0 : 1" or simply
"!IS_ENABLED(CONFIG_PREEMPT_RT)"?

And if you do keep it in Kconfig, shouldn't the symbol be "depends on
COMPACTION" so it doesn't needlessly appear in .config when
!CONFIG_COMPACTION.

Rasmus
