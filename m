Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4375B4C8CE0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbiCANpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:45:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231383AbiCANpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:45:06 -0500
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-eopbgr40045.outbound.protection.outlook.com [40.107.4.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467DF9EBBB;
        Tue,  1 Mar 2022 05:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+W0Fjjry/IQpl1QskifPJDHveND2Tc4oFJBC7J0ODDlWHxpHSiH8JHdTML7m1SzEJ6oi5t/D95s/W6Zdx9GSZW2ganibNgxLohwMcX6RtUTU/Bb0I7sOzx4fe+51mDvKyLskmeHtpucitv+OUgfDKiWWoLZ5ncYNdLbb0tM+DndC0ClIbMOJA1wDM+h6LLHvPoFRQUJ1+apvf6oLMKZLbhcysVf0EvcyHOqFB2zUR2GeB5xJkhJKx6eCN6UjlHw22CFOrjvsy8kqDKTMve9pLaYqNlDXggEKJtkbeu1ta595BjVd/65g+1CwONPqfGbQ9PQa0Y1G7Bn1Kgr3AUAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z62eI7u7zD/tah5JR21UxJAQ3BkbDrsXI+ubKjg/yb8=;
 b=Ia5XWLQA6QEI7Bz+EMLCyhqNCtbvwOGEUVV3K88MA3sdUBjJHetf3svPOaixb3ZBVRYboynKrxOuYVUQnIInv748JUGZtui286fis1rw7eMMUsOjFQykyM3u7NLZ/BahevFpDnGpDLipRo3GP0HTbeIIf0Q/1lCV59kcATXISfoq7OQDHgx6t222cN9URuwFDHFoP96Ow9vlT1mM+ZDE46HjZDTKO1N2s95f8c+fHooN/yFUc7A55hSpAsavIKK1EL6bcINOZR/6C8WlS2RfQ391rC6EQCzG7kxE+feQyOFPA4WX3hA41gKpMOs9XEII0/H/EM6nbcdu+Irrh7WX8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z62eI7u7zD/tah5JR21UxJAQ3BkbDrsXI+ubKjg/yb8=;
 b=Zbn6aySDFkb6pISjB2wvpUstG7FLUZzepBXsmr0JCkpYhCGdbrkABuMFqPqGHefAIYsTFPXyOY81gFA15WHtQWnRSfl3yRsM8tni8de21ZjSczsA9zSTYOx+5bhVAGixzrSIbgJXeCX77R18o9i+Q97dY5RaP5O+FMUXd0wODJQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com (2603:10a6:3:e1::23)
 by AM4PR08MB2643.eurprd08.prod.outlook.com (2603:10a6:205:5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Tue, 1 Mar
 2022 13:44:23 +0000
Received: from HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049]) by HE1PR0802MB2426.eurprd08.prod.outlook.com
 ([fe80::f9ee:a333:b115:5049%4]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 13:44:23 +0000
Message-ID: <bdf30b12-da0e-8505-2179-c8914185a169@wolfvision.net>
Date:   Tue, 1 Mar 2022 14:44:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
 <20220227153016.950473-6-pgwipeout@gmail.com>
 <fdacf3eb-7892-c767-ae85-1672f85684dc@wolfvision.net>
 <CAMdYzYoEEY6-kGVDeWj9AoA98BL5hxnc_4CnUPiuStUnSrFXLA@mail.gmail.com>
 <56f8b74d-d9a1-7c6b-67f2-29586956670d@wolfvision.net>
 <CAMdYzYpiNZ1ofzWmjf-3ew1F3RMHngz_Lo72Nu56AnirZSmRPw@mail.gmail.com>
From:   Michael Riesch <michael.riesch@wolfvision.net>
In-Reply-To: <CAMdYzYpiNZ1ofzWmjf-3ew1F3RMHngz_Lo72Nu56AnirZSmRPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0066.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::17) To HE1PR0802MB2426.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12219d3f-e2ea-416c-5a96-08d9fb8997df
X-MS-TrafficTypeDiagnostic: AM4PR08MB2643:EE_
X-Microsoft-Antispam-PRVS: <AM4PR08MB2643B307B1A334C5663F1658F2029@AM4PR08MB2643.eurprd08.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bPy59At65IIoS0ugXO5eNSfVficO7R5WlaOl7HGn5b93MWgXcBzgNEuTxz+/gFRjmGDqAOJ/6ez54oy+LW1H16aGqbCcPtxE+OAnlUl6UbQeu+73XXQA3LuamjKRkD5n/xZRHp2wLYB7MVdehnwM3fLSwghcl7Gq+wjc/RDVEbLXptWkBFH+mCbDoqwZvU7bvhvDCWrmyhewh8GX9bSmbKzjkczhWDanavweB9MG8rUVqAybzYAYfPXAg76MwO9Hh2KNza8dgH+c6Vmo14uhLFa0yECfXXmdCXLwsKXhqEBiMyYO4b7b5OSI6/QkLoU6v03s4u6cOqEAOynpd0VB9mIZ2kPrGB9xvfcE9fiCkiLaMuNVGr2BI461uAjXbzO6M7jjrnB8lv6zg3IwIWOKI568klPxZWNfRb/17FWbuonVyDDHcxuoKKOk9d2jLYvH4MvoXR1QPzqwzgx/+X8QVT02uxxgiAT9mkugXZVgx94qzxovzzko/NMx19PeooWfkacGovRq8PUxzmLqXIMxKVaKTb7LCiTSw0iNhJcf3usTtY7CRx5xwikoRNh9o6pWDP/+dccG6PEuZHI7brks6nfhaKcqYNyfH6fSqnc8xTAuIzDNS9fLwq/YUoSngdYleO96kTKQXfK559N5QI8iFWLs7CgDbIpxAqOevwqxPhJyWsHHuxxJTW+Sp7XQfJdNqkAaqAEdlaq8XMUl1VUPYZ1cluGMS88Aq2Ac/qj2/Dbf+l8Le4mvjY14tIUIgidT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0802MB2426.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(2616005)(31686004)(54906003)(52116002)(53546011)(6506007)(6916009)(44832011)(31696002)(86362001)(38100700002)(6486002)(8936002)(5660300002)(66946007)(6512007)(316002)(36756003)(66476007)(66556008)(4326008)(8676002)(186003)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U21ISnY1eEdPZzZFbExOaDhoeHJuWERPZDNKdStVZGxDazhRc0cwL01XdFZk?=
 =?utf-8?B?NERDMENiRGQvcDF3cGp5Vm9UYzdFeVRwaktXM2VzUjBzUWV6QlVESzFkbkZF?=
 =?utf-8?B?VnNNaHRmZmVVOXVvaGxrTUsvUnBMSUVWbkMycTFtNWRCY1Z3ZklJWUFtTUdB?=
 =?utf-8?B?N0VScFpESHBjYUxwQ0pETFR1Q3JheHk1TmFRSEdJM2l6NzZEdGVEWlYzbThV?=
 =?utf-8?B?bDVnOFFLSnhlSHBRV0RKRUNFSnJxeklSUE01WDhMdnlWeFg0ZFJNbWtjcWpa?=
 =?utf-8?B?NHRCN3dJSWpnSmxNTGl2OVBsWHc5dS9aQmRGOTkraEVpMFZHQnlzZlVTMHF1?=
 =?utf-8?B?Tjg5N092L0E1Z2xvTGFCRFZMeDV0bFRNMzdZNWhyOHFRZ25vbG92Nlh3UzRs?=
 =?utf-8?B?T2ZINmxyTGw2TWxFWFRta3BCK2JPM0M2bGlXcmRmT2cxT1JqZXU5YTVUMEtN?=
 =?utf-8?B?cEkwa1A4MUl5TVpERE83TloxaU55WExuRzVpWjgrTk5xY2dTQnFEZTNqUERV?=
 =?utf-8?B?L3BMWndaWnYzSmF1QWxQRTNGU0kyZFRIZWs5bktqSE5xVk9BZDlXeVNSck1R?=
 =?utf-8?B?VGpJK0NxbDQ0MTUyYjdwSlFCQUdkUlJjWEp5UEVrR0NzY3lTU3c4MWNmdkhC?=
 =?utf-8?B?L0p3VFJZM0xrNUlHME01aEFycWppWEoxTW5CVzA3bW1sNS82ck0rOFh4T001?=
 =?utf-8?B?NzNXbXhiZTd0RFA2TUlpdE5ObWhxU2ViODFVdWZPQTFMbXdLS0xTcGc2Z0tl?=
 =?utf-8?B?WElLOWpxQU5JMDBiMXJHRlpBUXIvV2JWcEJqNGoyWmZDUmdDK1dsYVZTL1cz?=
 =?utf-8?B?OVJOTEJFV2I1SG9jV0JYVzVFOTFPL0ZpMU9KemRkNWdpNWNMTk5oVlBDNVRN?=
 =?utf-8?B?QnJ2bktSNmxKYm9FYUh1WGNvYXFWdEcxUlZRYmV6VHp0bnRKSGpieGNaSlNY?=
 =?utf-8?B?a3dxOE1EZVJtRE81V0VWRCtVd1B1SElMbGwwTElwc21YcytNcDF0cUhSOWZL?=
 =?utf-8?B?dEtuUjZGbWhYUUdhRTY0Ylh1RDdQUFlTckxwczBONGZMN3YxTjh1MWN0K0Er?=
 =?utf-8?B?NW5yTHpxSUs4WkM4QlE1eFVTU2phRW5mYjV2cStsQ3RuekdNQmRZYllZbnVN?=
 =?utf-8?B?QnBmblljM0dQOWhSRWttS3BUcmRvYjgzZVJRNWpoMnhoMnQycDZIZ0VEYnFD?=
 =?utf-8?B?VDFRNmxjUlAvY1YzaGd4b0VCWVF1dFhscVNrVzlZNFpTSEwxa1JJdk01cytv?=
 =?utf-8?B?bEZMSE5IdmF4dk9ZNUxwbDNjNkFZME5tTUx6eUNyWEUwY0NxSEhWTzlDT25P?=
 =?utf-8?B?MEU3RDU5NjZwWCtVRTdSa1U3ekY4Tm83cjV1d3pEWHBtWUdxVFBzdSt3bzI1?=
 =?utf-8?B?UzJDSDl2OEJZL1BqbS8vb0xwcGxYbW9ndGIyMmVGL2N2Sm5NYkoyOEVjUlhI?=
 =?utf-8?B?dGh1Nmk3Q1I4U2c1WkE2cDVUenFZd2xpYVdQSk0zT2V3OTZDU1gxdWQvdTJJ?=
 =?utf-8?B?NmlzTWc4VHlZa1ZiUXZrbkZzVkFuZW9JZE5jVWtDa1F0U2ZlSHJyVGZ2T3gx?=
 =?utf-8?B?VTB3dHRkSzN1cDZnQkJWR1ByWEtOZ2k4TmhzY3JkbXM5M0gvaDN4N1RtNkVY?=
 =?utf-8?B?NkNQTE9EeXh6WGQ2eTJGL1JOczQwWkVkeFRabjVMOEZXVVdKOFhPVVMrVklv?=
 =?utf-8?B?bi94RVViSjZXWnByR2J2U09pcEJ5N3FmQk91MjlkRlhVWmpxSnNMYVVZcHRV?=
 =?utf-8?B?U0FkSm5SNUsyczRRWkRoWWpZS0JrR2gzaFB5U2ViQkpXUVRzUjc1Nk5uUVo3?=
 =?utf-8?B?QTNnZEJlUzVKRWxzKzdKQ1NqOWVrVXZpT0poZElvMXM5NXpyV2dZTTFHRlNF?=
 =?utf-8?B?V0s1dEhSYUpnRUk4U2JhT1hlcnJFTy8wd1d1bEM2UzBhVkRrUW1KcEVoM1FN?=
 =?utf-8?B?dUo4QzV2NHF1S2dVMTBGVzRkSWIvSnZjais5YVArSmtSTm9hMEtvS0Y4LzBx?=
 =?utf-8?B?VGY0eU1BMkViRFJBbW4wL29pVkNQRnF1OU52NnE5UGJsS09VUmdUSHJYNTg4?=
 =?utf-8?B?bk81amZzRWVTNEJiUUw5SU5PekJ2YzJTdTRyRFAxTEhNcElSSmdBQ2R6QjZn?=
 =?utf-8?B?anRNTEhsNlA1U3Z0R0gva2YyUXRNL1FVdmgxamlmek4ycnBsMUNmYXVrUkNr?=
 =?utf-8?B?cmYzYS9rd3dtOGlqeFlTdjhJdUdJY2RSZE1GZ0VrNUFNUzNWcmJIYVVYWFQy?=
 =?utf-8?B?TGREWjJZbDhNdS83LzREcWJ0WWlzNTFUME9RK3JoaStxRWY4cEN1bFBTdWNQ?=
 =?utf-8?B?V1pXRFJLRXFzcEJaKzNtb20zTExLOUcyWVV2OG1UUkJzMm9RQ0xWNXJvMG9q?=
 =?utf-8?Q?SwNgNI5MzpvfgYwY=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 12219d3f-e2ea-416c-5a96-08d9fb8997df
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0802MB2426.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 13:44:22.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5yjkiOm28evpA+BPKBZQcviWiU8HjA8tuFfjpUwnaXuKGU+xiXm6pvnLRT0TpFx4Oc0LwUKeE+Cnr0te2b8V5AHx7pGI2ycw4CzY2+i3OU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2643
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 2/28/22 15:10, Peter Geis wrote:
> On Mon, Feb 28, 2022 at 8:37 AM Michael Riesch
> <michael.riesch@wolfvision.net> wrote:
>>
>> Hi Peter,
>>
>> On 2/28/22 1:57 PM, Peter Geis wrote:
>>> [...]
>>>>> +
>>>>> +&usb_host0_xhci {
>>>>> +     phys = <&usb2phy0_otg>;
>>>>> +     phy-names = "usb2-phy";
>>>>> +     extcon = <&usb2phy0>;
>>>>
>>>> I wonder what the correct place for this extcon property is. You defined
>>>> it on SoC (RK3566) level, in my patch for the RK3568 EVB1 it is added on
>>>> board level. Is this common to all RK356x variants?
>>>
>>> Yes, the usb2phy is always available as an extcon unless you make a
>>> device that doesn't have usb2 capability.
>>> In that case you'd have to override the device anyways.
>>> If we want to turn on default role otg here, we'd need this defined
>>> here as well or things break.
>>
>> OK, so it seems to me that the extcon could or should enter the
>> rk356x.dtsi (and can be removed from the rk3566.dtsi and the
>> rk3568-evb1-v10.dts in this series). Is that correct?
> 
> Apologies it seems I just missed this.
> Yes, this could get moved to the base dtsi.
> I'd prefer to do it as part of the next series supporting otg, as I've
> only been doing OTG development on the rk3566 and would prefer it be
> fully tested.

Thanks for the clarification, that'll be fine for me.

Best regards,
Michael

> However if Johan prefers I can send another revision accomplishing this now.
> 
>>
>> Best regards,
>> Michael
>>
>>> [...]
