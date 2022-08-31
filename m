Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728205A79E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 11:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiHaJOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 05:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiHaJOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 05:14:42 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130117.outbound.protection.outlook.com [40.107.13.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E43DB942F;
        Wed, 31 Aug 2022 02:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cI/e5A+JCu4rXS/FqJLakfkXFEInrfs3AzMo/ncIBkIAitFuMzGQHp2/zyX2eCmUDWEIngdO/X9UUqYX2NHDC21XiAlgNBX4Xzi7BrbUohMkrek2JXwwH4JU/2V89ROMdm5cWOxNIS+mL3sHRcKtLYV7JtMEytrqou3p7M+0gy2EBAlxNFCoZKoa265ejGt4p5yJPhp2KSv7leZocTJcIMnxq4rs6ALIYVoicULh6UJTacJWCgSc+a48R646HgzTF6A/57kLWXKV0opQW5eqeYCQVpSw49ir7CKtuSlum2rHJVRbJh5O+kgrkuBoxsPuMRBLDjPggQi+7txtKg0wiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J799jLSRGHR/EwdRVTzMIgnuPrn4ePnQecbCRwy91pE=;
 b=VaTLMUKn8VfECWCwFE9wgPMm8H4Ig1Lb74ttq9N513SPzfTOZaNCQgpPDh4CkKRMwOlLx3EPPa67MAelbfVRZWjagGu0ujipf/m0evLCKKagINYUKGsmY7fDkOdTcGs1kEedjUoYkL0PSShybar+D+vyklbpjLJ4h1knwE+ZMGlU0XkUdi0DFbPGoAc6x3bT++zGdr6cwYPLznMh5oKInLq/ow8weIgeqE6ZXVsDc9vwmhh7ok3Xo7fdBfh0laokRb8nqmqaUtoIXT30bhFLqUabMjREHPkAcBLnm0Kjsuyl8ywX9CINoNtpcUn5FftahcOPrrZpmqgZTMjFmSgGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J799jLSRGHR/EwdRVTzMIgnuPrn4ePnQecbCRwy91pE=;
 b=ayKIZahyIz2JzVcbm2jzNjb/Wid9NLxucGKG9r16ZVMxU5um1BqALbKrBh6RcMbul1DIqVdaEq30Zh5SA3PMUJ/dEAeFrWbJ/PKZSy2qL+pTAMCrEmT/nzs7Oh683IrQF+p9FAHOx07517hF7R5p6M5H23RN8IkdbDkpn1P79TQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from VI1PR0701MB3005.eurprd07.prod.outlook.com
 (2603:10a6:800:87::19) by VI1PR07MB4192.eurprd07.prod.outlook.com
 (2603:10a6:802:5b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 09:14:38 +0000
Received: from VI1PR0701MB3005.eurprd07.prod.outlook.com
 ([fe80::f995:7441:9ef4:f78f]) by VI1PR0701MB3005.eurprd07.prod.outlook.com
 ([fe80::f995:7441:9ef4:f78f%8]) with mapi id 15.20.5588.011; Wed, 31 Aug 2022
 09:14:38 +0000
Message-ID: <fd5e6961-5809-a125-f909-3cfdff90ef35@nokia.com>
Date:   Wed, 31 Aug 2022 11:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: linux-next: build failure after merge of the arm tree
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Russell King <linux@armlinux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "kernelci.org bot" <bot@kernelci.org>
References: <20220831191055.16f85948@canb.auug.org.au>
From:   Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
In-Reply-To: <20220831191055.16f85948@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1PR0402CA0027.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::16) To VI1PR0701MB3005.eurprd07.prod.outlook.com
 (2603:10a6:800:87::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d74face-5f4a-41b9-73fa-08da8b313acc
X-MS-TrafficTypeDiagnostic: VI1PR07MB4192:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K8ijsIpk/kCvWyFtclpVAQM3FOLJCuVzk75vCcuBVsaZT9yQLV7dlrVwMYcqAiovVSVgwnvl/5ZJUmtjifeqA501vpjzlkv0bigJpt4vYNURfekMhdOfwVJVvA9WtuQo2hZrkKLwHw8AlDcbg/c1RcF/U3nWaU4elD6FJC+nuUn7CZr7D8VWTJMV7IsHvKKorL6q1O8HD2BUd+1BRCLwCom7ogG0O5fLm/b4OGacOoKX7nxOfrCmBeLpSTtUVJV9xDA+nJpESjTG+IY+OEd/LhwqC6GHAoCjhrhX3E/Kk+Zsazh5R6oLkWtuyIyHgXt4tBXy/H+hMU9zTwwRZdADZtgVNPkGIowXD93AvI2cpVK6XV4zjEFlYDi4UbWQgXs1UuwFf89rtiv1W/8Wfp7fXoCZSbPGWvpHfoee+CqGaP8eB0u5L2dR0N6bbZSUlyXjNnyeJrtiwv6fHp63ROh7qD2Gq7mjkzzvvyonJcrtpzmhoRqlrgv9GSnfIyHeVGa1K0Q9QaGLP7QLr0Yip+Y1eTRc2kF1Mm9AT0ZMUesCsjNDMIW/DjZPEBs516iY0x81Zt9NDKyBKcu4ezBXamuM/ale96nKl7qMFjV772zqwzCGcnaJ0ZnVbkdoZc0rnVy2+tTNX1rO88mo97dDfY9nr+QbNC686gXHVFwfUbvyLRh6Ll+k4QpYLG3arudL6Dq99r2JtIwq8E5LmdhfAwLYTXu9Kk9lNlQqgHFJwB/LVWIKQh822ww+Ue30haHGbvQBcc8F8gAc3slQ5tVndESUEePgbmXGYAMzYmjHFg3l7IQjrd3a2j7CO2YwC9xyrbGHcRwO7h7i58d0eRjNK//cI2WBBlhK+TgEi/WUql+FkWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0701MB3005.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(82960400001)(66946007)(316002)(4326008)(54906003)(66556008)(26005)(110136005)(478600001)(6512007)(53546011)(6486002)(6506007)(6666004)(55236004)(2616005)(86362001)(8676002)(31696002)(41300700001)(66476007)(38100700002)(31686004)(4744005)(8936002)(2906002)(83380400001)(36756003)(186003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MC9DTEJhQjRXcElLVlR5S28rb1VHV21tYmxaUXZOMU9JeXRna3Ntait6c3pI?=
 =?utf-8?B?Q1JIWkJoTm93YlRGTWhiWlcwZ2dkQ3IzOHo2K21vbmgyYzliQXpSYXVBRzlX?=
 =?utf-8?B?UE1FN2JjNFlCMThOVzdjNVJveTNyRWRXT1c5OTJxQWY4OFV0ZlUrSzVvUVho?=
 =?utf-8?B?ellOWVNUTWtjQ29iUVFIS0ZsQXprS3NPZU9tMHQvams1RHhhUWdHSVBsd3hh?=
 =?utf-8?B?WW83TCt1QXlIdEZVbjRjWTlWWWNsNUxYMVpTUkdzRzE5UXV0Q1NWVWhLQm12?=
 =?utf-8?B?SHUwMVFYV0VqNTM0WWFpY3cwaVVZSmIrN3h4Ty9PWmRPL0FxN1l4enkycUNx?=
 =?utf-8?B?S0ZRTzNnSTdIRGNJVWIrQjlrRFhsYWJtb0luUktUNHc0c3ZkSFFFckhDSDlJ?=
 =?utf-8?B?RVVkN0laTXU2U01MK044QU1PWHJMZVF1ODdLOHV0Q1VMc1Fva3NwQTdPSmwz?=
 =?utf-8?B?dWRjU01MdzZHczhKT2JWQXM3NktBUzFHc0xBU2ZhTmtwc2lmVVM4eWFMWHZN?=
 =?utf-8?B?ZFBrbmxvZ1VoN25tanNsbXQ5V3BocWx4cXVPb0dUYm9pUjN3cTAwa2Z3N3dt?=
 =?utf-8?B?d2dHa3BQdmZQWjM4WTl5WGl2ZE9SR05jRXRya3p4WE93aGNGbDdtbnh3SWM3?=
 =?utf-8?B?SVpCK0toejBtd0JCQ0ZTa0xrZzZIODV3TG5qdzJyVzBxTmsrblJxaWhXYm9F?=
 =?utf-8?B?ZjV4c0xUNkVnU0NKWHFuUDl6bzExUUs1SFB1S1U5K2F1bTRSVUlYNG9PWWtO?=
 =?utf-8?B?SVZpMjVoWm5HL3A3dnNJMncvNE43VTlYTXYvVjM3YTVDdW9KcEVVZVBQMS9l?=
 =?utf-8?B?K0U0cVZvbEpEaVgzZUxPVUR1c1lwZGp2Z1RGZHNQRXU0NTNEVmxjQWF5cFRP?=
 =?utf-8?B?VHZLRFREbnNRS2VpTVIzQ0VMYU1LZU9xb1JBeEN5TnpIV2thYk9CdmQ1YTEz?=
 =?utf-8?B?M2NkR3IwNTcxbDAyc3RNaDB4aEkzazMzM01KMXBRNjJkOUdycVFReDdBMlpC?=
 =?utf-8?B?aXd2MTF3aWFDNFhHRTRBeU9xMjlJeWhlZk52WDQwTHlpaXRFR0ZhSWpjdHBo?=
 =?utf-8?B?SDdRR2ZKRlRKN2I0WWNaL3p4SmdreWNmYnI5RWJiMG9IZ3F5T0lCaEEzTVZI?=
 =?utf-8?B?c2JSTC9POU1rNVh5a0dLYnJlQ3FrYk5lZ0RwRzQxTmV0RGNPUXUyUUg3azB6?=
 =?utf-8?B?VG5TNkx0RXhBQUVrMms1UUtuTWUrVENTQkw4eDJncjF6WHc1MVhiajZkbFpQ?=
 =?utf-8?B?NnlWMFZyVTZkbTdnaWhoelA5d3FlTk5NV2phWklvbFhUQVRKMTJ3NW5zNEdX?=
 =?utf-8?B?dmFUNDRiYjg4dlpvSGJTYWhTNlVlcnhUa0xsZDNZTkVvRmFNUUVrVFQzRGlL?=
 =?utf-8?B?V2c2cnZiRlc2RlFzajNXNVIwWFdTTERWc0R5ekVnMDJQb011VGtvVEFhaXpo?=
 =?utf-8?B?WWtOZmlwYjNCNWwyVHNaWFVUekUrNmI1Zmd0SzdoL1BVUUxieGdOYWpRd3ho?=
 =?utf-8?B?cjY0QnNsamtXSHBzenlPRFdkY0ZOSGtlL0ZqVGwwK1BkdGgzUFhaaXlldUUw?=
 =?utf-8?B?aFdMOUUzR0pkSDNMUS93OEQyQUNtdVJUVk5pNk1hRG1LbEJsdFhIVVJCazBT?=
 =?utf-8?B?K3dtOFpic3RIdG5qQ1hnQm93Z2w4cXFaSzd4Q0lPRDc2WDQvNnZ4UkEvcGFn?=
 =?utf-8?B?NEVYMmI4RzFsdkljQ0YyM015K25tUDBGL2NUZ0pZVDhpYmdzUm9IOHptcGQw?=
 =?utf-8?B?ZTJCbThxQlhzci8yWTJ2QXo3Q0hRRVh3MVNRZ2NYSjBzOHZGUXJrZlJSZ3BX?=
 =?utf-8?B?NW9BY05JK3VoNGkrSG83Q3REYWxYWVl1aURBdjV4cVI0YzRoSlhXa0hDM3hM?=
 =?utf-8?B?V0JNOXE2NytEbk5WL2o1OGp6VitNMDlsc3lrekhPeVNDSUJLZ0RidExvSzdF?=
 =?utf-8?B?MmJQL2QwUmxkQVhTRVllblh3RjgzWlJxbStLOWF3L3F6eFUxQXhsTzFyK2V6?=
 =?utf-8?B?RFpiYWY4MmlKd3pZOE1kSTdmbElLZ2k1Z3AzcG9BNzZ6OG5WeFlSeUZ2Lytj?=
 =?utf-8?B?dmlzeXJ1eDhaUjhqZ2JaZmlkUjBBQUVpUlBtUW9Pc24zenlIQlp4MjB3WmpI?=
 =?utf-8?B?c2ljRjIwTFIvdFBsRS9FdjlXRlFNQTlMcmV3UWVNUVB3aGE1MUdsUGhLVDVs?=
 =?utf-8?Q?LMjHwD1gBS8wyPGOKOWrZsyGZs+KK+1xjf/Fitti1nu7?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB4192
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,FORGED_SPF_HELO,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31.08.2022 11:10, Stephen Rothwell wrote:
> After merging the arm tree, today's linux-next build (quite a few
> including arm allnoconfig clang-16, arm allnoconfig gcc-10) failed
> like this:
> 
> ld.lld: error: undefined symbol: phys_initrd_start
>    or
> init.c:(.init.text+0xd4): undefined reference to `phys_initrd_start'
> 
> Caused by commit
> 
>   b35b2736b43d ("ARM: 9230/1: Support initrd with address in boot alias region")

my apologies for that, I missed to test with CONFIG_BLK_DEV_INITRD=n

I've seen Russell dropping patch already, hopefully update will
soon follow.

Regards,

Matija
