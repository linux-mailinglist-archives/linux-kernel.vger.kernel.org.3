Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94CB34D0E90
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 05:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243109AbiCHEQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 23:16:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbiCHEQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 23:16:18 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300082.outbound.protection.outlook.com [40.107.130.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE733A734;
        Mon,  7 Mar 2022 20:15:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkcxE5/BL0zEuPCy+HpUH4+NqLAEGxvAVKMQU7uusaXVVISmrZuCO+ssMd9P1Nb5EN6kJwlpY5ICfwyT02wHjkleEVbL5FK+HTzXdd+IW9FmSmujxCYnqzHnCXGFVgyaJi44Lk9rCxpHpT38tewYZ231Jg33phNl02Ee+ZCh0IgmbAKodTE8x0EfaLk9k/hpfYw8jPuETDObCC+wCgjQ7dyZ/9XazLArqVh3oThTE518aRuQ5jeFL9K/4yG/RPpODcp1yvbx0PBJD6vs43L1Dgf52uNRmgVnFvb4kCyJBooCQo+nU/WLSYMep1tXza3Tax5Gs/hqx+SCMO38KgS8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/ypwnTnFAqgqc/0/aBUdl8rRJ7b5M6a/UhKag5p5O8=;
 b=ZPXipZzwVuv4biD8vXh6kCTQann0Zf6epQCNBU+CsCzS62cYLcObTr3AuSjyy0VuevjzUCd7QEuuhcCY4eLMQUPsvIx8nDxXToYgq/Sqhaiml/eimbjHKFzMCoJIcczalGZPh8c5+XiNxPUJ72uu8QeR1z1vf8rLa772EGpzb5d3CNZucXwTzBkfALY0CaRPe3o+Ul7QRO1Hcha5GpXoyWagHjvP7LoAofrXyqPJchyqemu2TfOtZ9vSOFsLAGecPAtCWMqlT7Tp1XvpXEjbcwWQkpMc5yUqC9/LMsSaz2y44XYClhEJO5G5keAeiVqTzpEr2u6YQt3GJM4SsQfKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=nuvoton.onmicrosoft.com; s=selector2-nuvoton-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/ypwnTnFAqgqc/0/aBUdl8rRJ7b5M6a/UhKag5p5O8=;
 b=sfayvf2pdT94puCfh7pqfBkEAxuNj+DLGXDYPzaL58FTi/FG/71G4HVNd5iAjBkKzOKNCFvQIq2IXAVSws9mTros0rE5z4C3swK3yUhZQIb5BYRD8Sjr6QEnzVul1X/xFmJWYFaUoTLKmt1tmExegqPvdGfCY3olJ0Eqyhvbb7U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com (2603:1096:203:b1::19)
 by TY2PR03MB3536.apcprd03.prod.outlook.com (2603:1096:404:39::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.8; Tue, 8 Mar
 2022 04:15:18 +0000
Received: from HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e]) by HK0PR03MB4833.apcprd03.prod.outlook.com
 ([fe80::39bb:b24a:15ed:811e%3]) with mapi id 15.20.5061.018; Tue, 8 Mar 2022
 04:15:18 +0000
Message-ID: <27bfea4c-40b7-9434-8078-317c1b087be1@nuvoton.com>
Date:   Tue, 8 Mar 2022 12:15:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH 1/3] dt-bindings: clock: add binding for MA35D1 clock
 controller
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, arnd@arndb.de,
        olof@lixom.net
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220307091923.9909-1-ychuang3@nuvoton.com>
 <20220307091923.9909-2-ychuang3@nuvoton.com>
 <81e8d2cb-c935-fb83-4a29-5ec9dfce16e8@kernel.org>
From:   MS10 YCHuang3 <ychuang3@nuvoton.com>
In-Reply-To: <81e8d2cb-c935-fb83-4a29-5ec9dfce16e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0103.apcprd02.prod.outlook.com
 (2603:1096:4:92::19) To HK0PR03MB4833.apcprd03.prod.outlook.com
 (2603:1096:203:b1::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ade63d82-bed4-4f91-1885-08da00ba412e
X-MS-TrafficTypeDiagnostic: TY2PR03MB3536:EE_
X-Microsoft-Antispam-PRVS: <TY2PR03MB3536FB827633BB82A5BA1B5F9E099@TY2PR03MB3536.apcprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PJTcHv/AKPW13UDj99FGogrGVti4MZQYpdeph9XMXDm64Y6WddI9C6YEMcwgY0EtlJ8Y0AdgI5RfRUEVaULaVL0GyH8OvfKz781Xx79oK/QlFoJCkgExWv7Ym9l6NcDCneRhTNDMuj2/c0KQMk5ZdHusCa2K8De9lPD6ThQmdxKqFB4YeYXidMiTZvxuqU7EFUsY1TsnD2TfCR3130sY+nBK4dlZFUylUgpUc3KNzaRU4XfDSfX7JGU3/e4Tk33YGH3/lXcrA3YdluKnBj1VEgVu67rE+l4JxcpkrIyiwIahK8RzUjV7f/lIDy5AzSL75+CvYTZKOo/o/so/zERXlRbbMxFPNwDhr01SuyEJPqsL3ulF+VsYEC876yiZKsEBQs6paLUgrg9m/dy8sWyaeR+OjDB3qJwn1NB9b/Kg2WkZXecIF594846DdJ89byyqcvl2zNKXcSVK8yt/EOiPZo8gPH71YhzYqqZ5erCy+PhFCW5BWG7floO8isVMbaZgy/vd9vXjdFs2s39zpMsQJIS3U+8FutiXnxjmbm1/8H/JkwsqAOX9xLNG/Uep0n8s5aOijRSywEywLjVVLQRBBNbCMwvPaTvsKGzFVwPpQyRe7l7BbTqyU+yaPZ38iXXVK5ZUD6KEYyVfFnJijylS5fxiJfxLqaxEs6au3v4yCjOIPKR+9Oge3o2mLHneRBnIvKSsVYWeAscRsBnCUHwDjryJw1zvQdygUBpyXr/Fu6YJ6YEYGDzr2D0Ob3Qkji4tI3YQlKr5WdVNLRLvU0ZSSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR03MB4833.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66476007)(8676002)(4326008)(66556008)(66946007)(316002)(31696002)(508600001)(2616005)(186003)(26005)(83380400001)(86362001)(6512007)(6666004)(53546011)(52116002)(6506007)(38350700002)(38100700002)(36756003)(5660300002)(2906002)(7416002)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ei9XWVFMam1pYThRRktNd1RsdEtvdlBHcll4Z045OTgyQTlkVkMvU0VXbk9j?=
 =?utf-8?B?SkFuY3Y2ODNkZzBCaVhod3F5R2p3TW1TSVNTZ2xsSFRoaXhTZVNuZ1R2dDY0?=
 =?utf-8?B?d2FQVTRXZlpjQ2U4R2VDR1QyN3NzMzBGM2lYbFB1SW1HYjhNZTUrQ09aU2Nn?=
 =?utf-8?B?TWU1NzB6eCtQQlZGeGVKOXpQaVYwT1BwTGNOQkFvTU8vUDRQZGdxU0wrVkFZ?=
 =?utf-8?B?TjltL1VuQVpZclFFSUNhaSt4Z1pmL09saytPVDNSSHpZbGl2aTRQS24remYx?=
 =?utf-8?B?RmZkYXNvSVBYTEtDaERyU1pObkYzWTJTZnRzdHZHcVVnOS9idXRFSE1vQlh2?=
 =?utf-8?B?WThMVS9YNXI3eklIOUo4cjQycmxpd2RJWlNIb2hJTmdWZEhlcDU3aE5yZnM3?=
 =?utf-8?B?RkVUZ0hCckJpOWlkYUovRDkzSVpJa2VCTW5DV2ZydFRIR29ja1Vwb3JpUWR3?=
 =?utf-8?B?QlRoNVEyc1krbUVnVVpvZ3hGcktGRlFrSjFNVUMwQXFJakt2bVVnK1l1YWp0?=
 =?utf-8?B?ZlFRakJkRDhFWS9IeEFnSFRBbVcydURuTmVvM2trTXFrWWk3T3lTV0JKVTlF?=
 =?utf-8?B?ZXZQNU1MNnZ5c1FaRVQvZFBiclNsUzB5SXlVZjJnUEhSalhjaExrc2JBd3I2?=
 =?utf-8?B?ZS9icE1WRjNXZWttWVUvQnJacnptaXZidEN6Q2xlYzNTUmRPYW9ObUM5WWJv?=
 =?utf-8?B?NlZkSmh2RU1Kdy9oQ1ZBWU5mMnMxeXI2dHQ1bXdFRzlyVlJOL3NLRmtTZTBl?=
 =?utf-8?B?bkZYSXNxaG5PaG51RzU4WUJ4N1Mzc1p0ZVFpWHJpQ2pubUNnbnJVM2NJYUlj?=
 =?utf-8?B?a2wyRnFDUEFPN1JzZ3FhbHA0U0FlcDRjN05XRG85Q0dkdU1nUytqRndCVGs2?=
 =?utf-8?B?NzIrbnVMc043YXBlVlJ3WkxrNG50bFdzZVR6N0RQZ3JpQVdSUGZTMElQb01t?=
 =?utf-8?B?UFNEZVZYOEFjR1hMVEp6eHNBbGQxWXhKMFIvUUdLeUNlUHpmQmd2S3RpSmNk?=
 =?utf-8?B?dWF0VDJHSnE4RUlNRUExVkR5b1VtbE5kSHdvcmYwZi84a1V4K1VCcEdic25X?=
 =?utf-8?B?a2hna2d0ZlhPeFdyRE5na2VXMjVVanVuZURraC9jTjNPd3JUaVJPRlN3elVm?=
 =?utf-8?B?YkZYV2JhL3pxcnVrUDhWTkFsd2xkRERHVndtaFJxWG1YYXo5YjNCU0tsQ1la?=
 =?utf-8?B?eHdjbFV2OGthanRNa2FubnJvd1dYUTBCQkcrbDZPcDNPRStHT01EUXdaaXl3?=
 =?utf-8?B?a1hmQlBpVXNYS0RxcUxuZ2JwaUxXUC9jalZaZDNsbGRyL2prWGpuaFgxMCtH?=
 =?utf-8?B?REcwNmI1d1JwY0ZZelhBamk4UXZtNXVhZTU4RGhZc1RJRUNFOE1JcW9mMzdX?=
 =?utf-8?B?THlVMmtWVmxENkFEeGlzWFozTEVRUUJjVUpvUVBVK3I3eXZmVEw5OVRvZWJL?=
 =?utf-8?B?ViszdHBnSkFueEZyV0NhOHloR1RUQU4vckpHQ1dGNThhcnFMQmhHYzBDM01Y?=
 =?utf-8?B?TkRadDlvZHVYbkdOcDRiQW02VTZiWHZGQ3AvZnNpNTZXajFkc0l5ektQUGNh?=
 =?utf-8?B?Vm9vV0FxUWYydndxYXJUcUxXdklyVDZGcEg1Z0E1bTRDVlZjQWw1ZkVjM3RK?=
 =?utf-8?B?aHA2eEZpNjNvL1F3aXBFdHJXbVdaL3Y3ZUw1RU83VjJYYlRDeUY0R3MvUkdO?=
 =?utf-8?B?R1pEUUc1MWxoT1daOGtubmRkNWoxVjhrRFNKVG83SVBjK2RLUUhkNnJsM29J?=
 =?utf-8?B?OU0vOW5ueGlVWUd5andWQ0hoK3EzcVYxTFpTN0ZIbXJTNFR2aGxQRU0zRWt5?=
 =?utf-8?B?ZWdGZ3Z4aXdvcEZ2dGJkeEQvbGFsdElXSWczOWM5QmNhSkhWaG9XZFdBS1Vq?=
 =?utf-8?B?cU9mUTNkc3FOZzhYcTNKK3A3enJncDlOK252QjdDMDhDYnVxY1FKTUkvVzhH?=
 =?utf-8?B?TnIvTDZxUGEvK29pd2hGRzBpb1Q5cmFpTEZBOElqdGg2NHBaTUZKNUpWS1Zh?=
 =?utf-8?B?WUZiSXYwRzZBPT0=?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade63d82-bed4-4f91-1885-08da00ba412e
X-MS-Exchange-CrossTenant-AuthSource: HK0PR03MB4833.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 04:15:18.5053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skq8tuQZ4KpfyKHdV5JGcxFQyZpay7b0jMn0Asyfa2aq2pgmHcH1uw276dekuLRP3+wQNjjtHwb8dyoY6SORDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR03MB3536
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/3/7 =E4=B8=8B=E5=8D=88 06:21, Krzysztof Kozlowski wrote:
> On 07/03/2022 10:19, Jacky Huang wrote:
>> Add the dt-bindings header for Nuvoton MA35D1, that gets shared
>> between the clock controller and clock references in the dts.
>>
>> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
>> ---
>>   .../dt-bindings/clock/nuvoton,ma35d1-clk.h    | 262 ++++++++++++++++++
>>   1 file changed, 262 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>>
>> diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt=
-bindings/clock/nuvoton,ma35d1-clk.h
>> new file mode 100644
>> index 000000000000..3634e5edcac5
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
>> @@ -0,0 +1,262 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
>> +/*
>> + * Copyright (c) 2022 Nuvoton Technology Corporation.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_MA35D1_CLK_H
> Please use header guard matching more parts of path, so:
> __DT_BINDINGS_CLOCK_ NUVOTON_MA35D1_CLK_H
>
>
>> +#define __DT_BINDINGS_MA35D1_CLK_H
>> +
> (...)
>
>> ________________________________
>> ________________________________
>>   The privileged confidential information contained in this email is int=
ended for use only by the addressees as indicated by the original sender of=
 this email. If you are not the addressee indicated in this email or are no=
t responsible for delivery of the email to such a person, please kindly rep=
ly to the sender indicating this fact and delete all copies of it from your=
 computer and network server immediately. Your cooperation is highly apprec=
iated. It is advised that any unauthorized use of confidential information =
of Nuvoton is strictly prohibited; and any information in this email irrele=
vant to the official business of Nuvoton shall be deemed as neither given n=
or endorsed by Nuvoton.
> Since I was not intended recipient, I am going to NAK it and delete all
> copies.
>
> NAK. Cannot be included in Linux kernel.
>
> Deleted from my computer, but I cannot delete it from network servers.
> There are just too many of them...
>
> Best regards,
> Krzysztof


Dear Sir,

I didn't notice the additional message in the email, it was my mistake.

The problem with the mail server is still unresolved, and there may
still be additional messages in this reply.

We will fix it and re-send a clean patch series.

Thanks for your reminding.


Best Regards,

Jacky


________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.
