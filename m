Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD75496758
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 22:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbiAUVeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 16:34:15 -0500
Received: from mail-db8eur05on2087.outbound.protection.outlook.com ([40.107.20.87]:14177
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230226AbiAUVeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 16:34:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL5hZFRGqNGzOik55mw5hLEpMMaTrD3SJ4hzf3miCvchlw4fr6rBC9hrOVp2o+wDubBFvqdn5wqZ8Q95aV6vt28f3JQhFYH1cXfu+Z92rMKo8nZyjOSKJyFULtnd8VlX7Rnk1LLnt7aMlw6x4lQeOGElb5LYtdReVypqJqL4f/wHup/jbvUdyIwKjMhQh9hxTpd6GijxPlHJQdIFCMd20sDSfStZi2MeYcXvq/SsR5qAXXoS62yxSCkiwi5TmR0uZDeqeVIEiVjSb1y6Sj7u4+U1tLvcgyh0P0Mc2brkkIJF7F8eRLqcQMNrEj2HqMNy0xANq0Vs5k8/59GSpiSmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr1BrPnmoOj4s0Y8lhz7xT71bNPSHG4CLwi1heHDHqo=;
 b=ahV6/t6zLjl4MzpneoXn9s0lNcJtpsaEMuf1mjZWQmMuKbSLd0WwrJ8YOAYr1kPsNiLJTkVYtrh1qtGam9AKVeRmyQDJkQULujXbwmJg5eY66auxNRif3Bok2wNQpWVA/px1WgbmfZILhriEgS84SGKb7EyKz/YkEzW5lPUrnCAyefb9Xr66XsYzAC8tYeqXFdqMTDi7kZjShP5YZUxZBVb20YwyqcoFAcnv6hr1I0ELLQrrbSLkv2Tn6Xgek1V3bLDYduyyFlc74ozA9fKP0wyoUTfaUe9On91NjUZ28/IhWPkx8CFlUdWCa7Mm5V6e7qBqJthEwoPdS4CK58QPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gr1BrPnmoOj4s0Y8lhz7xT71bNPSHG4CLwi1heHDHqo=;
 b=i0ivAiNPcdjdpcEh6wOH+99smnFaav8G+3koaAF4jFWdRqxQvW7r4gtwzwZmTemr3xG/JsRiSNGtRBW5zyyxW5Mts1EGYcJVyJXZEh4xEYl88w5ea52HVB1vdWA8iKxRcFNgITKt5A+gBXD8vHeA7l3ls9KlmdAkUFTKHDpKWIGP2EX8dpuGf4By8pOBr6e+n/jDgjmoMP4+NyuD/0G39smmn5mOsGz5c5s53o5LWaqYsyIfZP+GPAG9jgx/twyPrPF0jepe6Pg18i/5BekGwYJBcRjn6GVzqyGczVBl9WKZJyrNlxLTorKIuqroHimzOdZYNiOPzyCF+FiR/pAnQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PR2PR03MB5195.eurprd03.prod.outlook.com (2603:10a6:101:20::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Fri, 21 Jan
 2022 21:34:08 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%5]) with mapi id 15.20.4909.011; Fri, 21 Jan 2022
 21:34:08 +0000
Subject: Re: [PATCH v3 2/3] dt-bindings: pwm: Document clk based PWM
 controller
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20220120161442.140800-1-nikita@trvn.ru>
 <20220120161442.140800-3-nikita@trvn.ru>
 <CAJKOXPc249vbZZwjXxfg+mEgqQe0P8uhf1GTg8Db9sBeMY3+tA@mail.gmail.com>
From:   Sean Anderson <sean.anderson@seco.com>
Message-ID: <1d9b1db0-981d-f77a-063a-69c8a4d53343@seco.com>
Date:   Fri, 21 Jan 2022 16:34:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAJKOXPc249vbZZwjXxfg+mEgqQe0P8uhf1GTg8Db9sBeMY3+tA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR02CA0096.namprd02.prod.outlook.com
 (2603:10b6:208:51::37) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8cac6701-3aa2-40cb-2bb9-08d9dd25c19e
X-MS-TrafficTypeDiagnostic: PR2PR03MB5195:EE_
X-Microsoft-Antispam-PRVS: <PR2PR03MB51957E819058A4C69030B801965B9@PR2PR03MB5195.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o94PJ7RPA6WsDbEi/DbJoEaxEO3MNk7p55sk7mMZnVeJ8XUlH8D1oHAavh+OfQcG5Dju7cTPGvjPejg6PL+ijjkOo0pHTNo9LEpxR4Te593FFvNXHpWnNOfzRx/n1X851HGO/snqoDryHfkRTU75hLyahcWJe9VTTOwWwzqlJg2pO9etFgrdCCUGiY9+GlEe8njPb1eqFkjDib+cPNEksCeW79oP5leZ1qiqmylecCu4AB/hu7vp2Db46VfRZgmzg1/5OV/HVuj7zmH89Mz0JNMOcggm3zi3d6nUvgh7rcL4MuIYlM5Q2zjDRoH5l/UgG/yLEicWUzvW/8UWZG+sBM55zbn7DQlz45ui+mgAm8H0rKywBIfd3Sna/iq759Ga3We5OZN0oOaVZvHOg+yBpP3ssmkgom1ZHWrHmsUAPp2J9d0Poo5XicMbayU4c+nLSTPdKg/yHkr+wvMcWSRE0mJm7d5O4wLk3Cmm9jz9YxCLvHBiTu+vC1gNFmi7p05Pm+1M7soGUm6pxGqPwnoJ9RRT7cyzCLRHIlHJf5raskg1ZOVp1fNakuLKEWnqeleOwiaJUAWx9eXceZKI4mDrnx0KDhZhEP1osJAN8crPiqN9dVGoSn+FggcbSzb6VTGmzZGRv0BxmmiSrE4q8FJK1wMsOOP69+c8LeB6Zvfo3l5yJeV3fMbldSOxdNeLz5Vta54RgvoG1E902vKLw9NdDRajncZfx/K7+US9+LUFagl8wwwKgOaSU4JafwVirwIYbHVznMGm75MwQTDgXDfzVBTij9hbQ/MMt0bK/brapNR/dEpBgIqyqSTWbp1f91OjNdN99v8WwTCJr4R+aaQNu8lnW49OcTSImTdh2AIDXwY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(110136005)(8936002)(26005)(2616005)(6512007)(8676002)(86362001)(186003)(31686004)(2906002)(83380400001)(31696002)(316002)(6486002)(38350700002)(38100700002)(4326008)(7416002)(66556008)(66476007)(36756003)(66946007)(6666004)(966005)(52116002)(508600001)(5660300002)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVZ6ZVh0SzVaM3pwRmZWV1pqT1R2ZWJHVWVYU2xtSmZ4STIrQkcrQmFLTFZ0?=
 =?utf-8?B?MVdwaGU5MFc5aVkvbllMb2pTV052WGhzSldRZlFreHNDYTV4eGZIRjlmMjJH?=
 =?utf-8?B?cGNaU2MyNTZkU2RHKzcxOGRzVHpYblRlbElnY0x1L0R2ZEdKWEhuV1pUaXZS?=
 =?utf-8?B?ZWl6Q2xuVVUxUlFGZFVHYXVGVHdvS1dibXVDQlovT1RHaVJ1S1ZMUmRVbkFK?=
 =?utf-8?B?dnBPU2JkWkRERzA4NTExUVdSekdiTEhPMzN5Qmx4anEyMWNGNWh0OXJZK2F6?=
 =?utf-8?B?MnNFS3VYNVRIRFM4OThBSE1tQklEWkJ6ZzM1VlJXblRlVE54cGpSSTVqWWF1?=
 =?utf-8?B?VFM0cjRUQ1IvZE8vbFd0blRkVnlOaVR6TzU2aUZIZVlRdmg1WVAzOTg2MFNC?=
 =?utf-8?B?TmJwQ215ejBpQURyczE3Sk1kb0RXd0JnanphTnFkZFZyS1lsNWkyMDNIRklP?=
 =?utf-8?B?V0NjNGprSG5QN0FhN090SkNoQzVrWkdFNUNGcGg5K04xak9oUVYxWHFmNUlm?=
 =?utf-8?B?ejNydHk0TjQ1YnhwZWxMell3T1NDREdxcnZhWTZFRGdMNE9HWXhVamZWY21i?=
 =?utf-8?B?dkowRTFiSU5JUmc1aERLL05PMklEYXdkdEpEVThPZEJIOEQyZjVpSmZYTTg1?=
 =?utf-8?B?c3p4Q3hLOFV0K2RoVm1RWE5rNU9JdXF0NEdtSXZjKzkxd3JDS0JPRFNEVlZp?=
 =?utf-8?B?cjhIdWlISnNkSk5hMWloSDJqT2J2N1VNc3JmR0N4WHlNbGVQdkJTM1RCOWYv?=
 =?utf-8?B?c1VlRGdJek8rbW8yWTdvSWZrOG1RekVrTEhEbDZ1NGNqVFRhTzJab0lXZllw?=
 =?utf-8?B?cmZxUStudk84WWptSE5RREdSYUx3ZlJFYi91SXg0VWk5bWJQdlhpYjVyeUdh?=
 =?utf-8?B?cllNQzJLUzMwd2lza2k2dlZ2SDJzMUdZTjMwRXplRkMxaWwvVDFuV2RLNnNO?=
 =?utf-8?B?ODZubnBjOW5KandnMmxtVGRETkg3Y1ViRlkwMm9BMFM0cGkxTVNmMk9qb2M3?=
 =?utf-8?B?em5GbFVib1ZyaDRKdHBBL1Fyd1ZtMGNRbkJGNHRLbmVjcFB4VUp4T3N2ajda?=
 =?utf-8?B?cFZrMGVxeDBJR2hnRTdVM3kvZmFENzJVazBwNjN4ZzhBSU84d25yajNYaUVQ?=
 =?utf-8?B?a3RCWmNvd0J1Tkh2MXVoSmJ4b3ZHSGNEVy96QTRSK2tmSTVZWkpHQVZ2NVFE?=
 =?utf-8?B?ZkFpckRZTE9ocFRSOGZ2dDJGYzB3clNWVGpsM2EySzVEVXAwTEhsNVF6cncx?=
 =?utf-8?B?UkhGa1dJc0E0ZGdaeFdxMnN2MFhvcS81UXBkcDZMNEtTR0p3RWtTeURaSmZT?=
 =?utf-8?B?WUpRb0Y3THpDU25CZWFrVWgrd2RmNzdlZFRpT0ZSL29ua3BYYVc4VThFdms2?=
 =?utf-8?B?WXpRUkZTampnYlEvVExkVFgvUEhQS3VSMmJjaE1iSEhzRjFzU1hnYktPWTlr?=
 =?utf-8?B?QU9ZMXRKbXNTblY0dmliL0NhWVBTdjA5WC9oSFBQbm5URUZQeVU2V3ZJSHd0?=
 =?utf-8?B?Q0owNWh5U0FFYnorUEJRQXFvUmNnOHFRdE1FaWR4N29adVJyMXZSWWh1U3ZS?=
 =?utf-8?B?alYvSUpuU1lxUlRScm5ibDYrV0tXdU42UmtlVDBMWFgvbzZjUDl5TzFXUm9D?=
 =?utf-8?B?VFppMlpaMXFNZUJNVGRCeENZdCtaV05ZQklkSkNYMHhsYWcxNlA2TGJIVnRp?=
 =?utf-8?B?MEhEbUhCeW5KaW1UMCtWMFpJT1NhRDVrbWdoRHk5SjBBMUJKYTB5NDdwUFda?=
 =?utf-8?B?MjlEK09wYS91N3U1SlFJejkvVk5RRWxJRGpSTExaM0F5bVdIU2ExTWhNVnNR?=
 =?utf-8?B?UWdsOElvSDdJR1NoRS8zMlFCUFRRalBlMGtnNUJ3K0lIdExaZWYzTnIrbGZJ?=
 =?utf-8?B?Vk9WZll1U01mYUdqZy9XNWc1SlVNVGduczB2V3NSU2xsS3hCZys2RUU5SDZY?=
 =?utf-8?B?ZysrN0hiNG9FMzd1Zm1JYjNnNGZHMjlNTmg2RTNtNEhtTlc3czdFNXc5ellX?=
 =?utf-8?B?MGYzLzJ5YXVZdlFUYllJU2Z3cFowWmcwZFlJTEp3QkllZktCeG9zYUVjaFJD?=
 =?utf-8?B?Slloc1VUZmdvbGV0T3JyYk5TMU5MZzJtMFMvV3dsQWZ5bFBPcjFVeEdhM2Vy?=
 =?utf-8?B?ekQyUXJvbFdndU9rNDlvbklVWjY5dnc0Qm40RDRlSmc3UWc4a0REeDdLUCsv?=
 =?utf-8?Q?1x7zQahFPbUJBRKc95UmBTU=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cac6701-3aa2-40cb-2bb9-08d9dd25c19e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 21:34:08.4032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGI/xHc+85gMcXrsjdJ5RmH8Y9v3xFUoRknzwSFc1pBvf2f0Fcr8MdTQ9s9ApIAfOQjcf/LSICsKYvX98pj/bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/22 2:34 AM, Krzysztof Kozlowski wrote:
> On Thu, 20 Jan 2022 at 17:15, Nikita Travkin <nikita@trvn.ru> wrote:
>>
>> Add YAML devicetree binding for clk based PWM controller
>>
>> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
>> --
>> Changes in v2:
>>  - fix the file name.
>> ---
>>  .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
>>  1 file changed, 45 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/clk-pwm.yaml b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>> new file mode 100644
>> index 000000000000..4fb2c1baaad4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pwm/clk-pwm.yaml
>> @@ -0,0 +1,45 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/pwm/clk-pwm.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Clock based PWM controller
>> +
>> +maintainers:
>> +  - Nikita Travkin <nikita@trvn.ru>
>> +
>> +description: |
>> +  Some systems have clocks that can be exposed to external devices.
>> +  (e.g. by muxing them to GPIO pins)
>> +  It's often possible to control duty-cycle of such clocks which makes them
>> +  suitable for generating PWM signal.
>> +
>> +allOf:
>> +  - $ref: pwm.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    const: clk-pwm
>> +
>> +  clocks:
>> +    description: Clock used to generate the signal.
>> +    maxItems: 1
>> +
>> +  "#pwm-cells":
>> +    const: 2
>> +
>> +unevaluatedProperties: false
>> +
>> +required:
>> +  - clocks
>> +
>> +examples:
>> +  - |
>> +    pwm-flash {
> 
> Node names should be generic (see devicetree specification), so just "pwm".

And then what will you do if you have two clock-based pwms?

--Sean
