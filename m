Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF815734C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235989AbiGMK50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235895AbiGMK5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:57:25 -0400
X-Greylist: delayed 14977 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 13 Jul 2022 03:57:23 PDT
Received: from 16.mo561.mail-out.ovh.net (16.mo561.mail-out.ovh.net [188.165.56.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A1BFF5B2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:57:23 -0700 (PDT)
Received: from player755.ha.ovh.net (unknown [10.109.156.29])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 71A3B243A6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:51:10 +0000 (UTC)
Received: from RCM-web6.webmail.mail.ovh.net (ip-194-187-74-233.konfederacka.maverick.com.pl [194.187.74.233])
        (Authenticated sender: rafal@milecki.pl)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id 137262CA9DA91;
        Wed, 13 Jul 2022 10:50:56 +0000 (UTC)
MIME-Version: 1.0
Date:   Wed, 13 Jul 2022 12:50:55 +0200
From:   =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
To:     William Zhang <william.zhang@broadcom.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] dt-bindings: arm64: bcmbca: Merge BCM4908 into
 BCMBCA
In-Reply-To: <6efb1cfe-6129-276a-eeb3-44147304d211@broadcom.com>
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-2-william.zhang@broadcom.com>
 <ca8c3003-1bcb-6658-592c-566609fd7bd2@linaro.org>
 <94b0ab39-279d-d3c2-98a4-054c10ad041c@broadcom.com>
 <c40f20c7-59ee-99f4-9a11-e928b41eda9f@linaro.org>
 <6efb1cfe-6129-276a-eeb3-44147304d211@broadcom.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e4356c5e89492eb690e3dc863ba281bd@milecki.pl>
X-Sender: rafal@milecki.pl
X-Originating-IP: 194.187.74.233
X-Webmail-UserID: rafal@milecki.pl
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11789860877335440347
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudejjedgfedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihitgfgsehtjehjtddtredvnecuhfhrohhmpeftrghfrghlpgfoihhlvggtkhhiuceorhgrfhgrlhesmhhilhgvtghkihdrphhlqeenucggtffrrghtthgvrhhnpeegvdffjeelvdeggeetheegveejieetgeeiiefggeelveejffehieekhfduueelhfenucfkpheptddrtddrtddrtddpudelgedrudekjedrjeegrddvfeefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejheehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheprhgrfhgrlhesmhhilhgvtghkihdrphhlpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedu
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-13 02:57, William Zhang wrote:
> On 7/12/22 11:18, Krzysztof Kozlowski wrote:
>> On 12/07/2022 19:37, William Zhang wrote:
>>>>> +      - description: BCM4908 Family based boards
>>>>> +        items:
>>>>> +          - enum:
>>>>> +              # BCM4908 SoC based boards
>>>>> +              - brcm,bcm94908
>>>>> +              - asus,gt-ac5300
>>>>> +              - netgear,raxe500
>>>>> +              # BCM4906 SoC based boards
>>>>> +              - brcm,bcm94906
>>>>> +              - netgear,r8000p
>>>>> +              - tplink,archer-c2300-v1
>>>>> +          - enum:
>>>>> +              - brcm,bcm4908
>>>>> +              - brcm,bcm4906
>>>>> +              - brcm,bcm49408
>>>> 
>>>> This is wrong.  brcm,bcm94908 followed by brcm,bcm4906 does not look
>>>> like valid list of compatibles.
>>>> 
>>> For 4908 board variant, it will need to be followed by 4908 chip. 
>>> Sorry
>>> for the basic question but is there any requirement to enforce this 
>>> kind
>>> of rule?  I would assume dts writer know what he/she is doing and 
>>> select
>>> the right combination.
>> 
>> The entire point of DT schema is to validate DTS. Combination like 
>> above
>> prevents that goal.
>> 
>> Best regards,
>> Krzysztof
> Understand the DT schema purpose. But items property allows multiple
> enums in the list which gives a lot of flexibility but make it hard to
> validate. I am not familiar with DT schema, is there any directive to
> specify one enum value depending on another so dts validation tool can
> report error if combination is wrong?
> 
> This is our preferred format of all bcmbca compatible string
> especially when we could have more than 10 chip variants for the same
> chip family and we really want to work on the chip family id.  We will
> make sure they are in the right combination in our own patch and patch
> from other contributors. Would this work? If not, I will probably have
> to revert the change of 4908(maybe append brcm,bcmbca as this chip
> belongs to the same bca group) and use "enum board variant", "const
> main chip id", "brcm,bca" for all other chips as our secondary choice.

I'm not sure why I didn't even receive 1/3 and half of discussion
e-mails.

You can't just put all strings into a single bag and allow mixing them
in any combos. Please check how it's properly handled in the current
existing binding:
Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml

Above binding enforces that non-matching compatible strings are not used
together.
