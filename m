Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF859F570
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 10:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiHXIj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHXIjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 04:39:25 -0400
Received: from smtpout1.mo528.mail-out.ovh.net (smtpout1.mo528.mail-out.ovh.net [46.105.34.251])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D1D67CAE;
        Wed, 24 Aug 2022 01:39:22 -0700 (PDT)
Received: from pro2.mail.ovh.net (unknown [10.109.138.102])
        by mo528.mail-out.ovh.net (Postfix) with ESMTPS id A0B49122094DA;
        Wed, 24 Aug 2022 10:39:20 +0200 (CEST)
Received: from [192.168.1.41] (88.161.25.233) by DAG1EX1.emp2.local
 (172.16.2.1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Wed, 24 Aug
 2022 10:39:20 +0200
Message-ID: <0663c616-97c8-444c-f390-275fae402453@traphandler.com>
Date:   Wed, 24 Aug 2022 10:39:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RESEND PATCH v6 2/3] leds: Add driver for the TLC5925 LED
 controller
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>
CC:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220722081146.47262-1-jjhiblot@traphandler.com>
 <20220722081146.47262-3-jjhiblot@traphandler.com>
 <CAHp75Vdu-EJRRxkK7+TfuE=zEDkJye1QCXSB+cDLrqxuykJjkA@mail.gmail.com>
 <5ba34982-52c7-e41a-fba8-d88d93529e47@traphandler.com>
 <20220804210412.GA30210@duo.ucw.cz>
From:   Jean-Jacques Hiblot <jjhiblot@traphandler.com>
In-Reply-To: <20220804210412.GA30210@duo.ucw.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [88.161.25.233]
X-ClientProxiedBy: DAG2EX1.emp2.local (172.16.2.11) To DAG1EX1.emp2.local
 (172.16.2.1)
X-Ovh-Tracer-Id: 16408865246057806299
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejuddgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgihesthekredttdefjeenucfhrhhomheplfgvrghnqdflrggtqhhuvghsucfjihgslhhothcuoehjjhhhihgslhhothesthhrrghphhgrnhgulhgvrhdrtghomheqnecuggftrfgrthhtvghrnhepvdehueeuffduudelieefvedttdefgeeuueduteetgeethfevudetgedviefgtdeknecuffhomhgrihhnpehtihdrtghomhenucfkpheptddrtddrtddrtddpkeekrdduiedurddvhedrvdeffeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhrohdvrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepjhhjhhhisghlohhtsehtrhgrphhhrghnughlvghrrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehvdek
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/08/2022 23:04, Pavel Machek wrote:
> On Thu 2022-08-04 22:23:00, Jean-Jacques Hiblot wrote:
>> On 31/07/2022 21:28, Andy Shevchenko wrote:
>>> On Fri, Jul 22, 2022 at 10:14 AM Jean-Jacques Hiblot
>>> <jjhiblot@traphandler.com> wrote:
>>>> The TLC5925 is a 16-channels constant-current LED sink driver.
>>>> It is controlled via SPI but doesn't offer a register-based interface.
>>>> Instead it contains a shift register and latches that convert the
>>>> serial input into a parallel output.
>>>>
>>>> Datasheet: https://www.ti.com/lit/ds/symlink/tlc5925.pdf
>>>> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
>>>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>>> Sorry for my slowpokeness, but I just realized that this driver may
>>> not be needed. What is the difference to existing gpio-74x164?
>> It might work. However it might not be as practical and efficient as the
>> dedicated LED driver.
>>
>> I'll give a try.
> It is certainly preffered solution. If you decide to re-submit the
> driver anyway, please mention that we already have GPIO driver for
> compatible chip, and explain why this is superior.

Hi all,

sorry for the delay. I tried with the  74x164 gpio driver and it works 
as expected.

The only drawbacks are:

- as-is the 74x164 gpio driver supports only one output-enable gpio. 
However in practice I don't think multiple OE GPIOs will ever be used.

- with this approach, every time a LED status is changed the whole 
register has to be sent on the SPI bus. In other words, changes cannot 
be coalesced.


I don't know if this is enough to make a dedicated TLC5925 driver 
desirable in the kernel.

JJ

>
> Thanks,
> 								Pavel
>
