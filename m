Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1442B584A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 05:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiG2DNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 23:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiG2DNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 23:13:45 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E07C18E
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 20:13:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id D35695C015E;
        Thu, 28 Jul 2022 23:13:42 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 28 Jul 2022 23:13:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659064422; x=1659150822; bh=jmTWaMJZZp
        aHx/eRfunc9ygBCF1SRQEFNuZIY6+FOFY=; b=dfaSW5nvtDsxvb56KmVIpJaoRR
        useKali9k/3zqjPVVSqfKz6r4rUSimIV6dbbpvedOtNLaBW5bJH2NU2V8O2PcrXO
        zyTB5k+rja91KYDpsfPd2qyg1XZQgyBvIxqTy5Y73RPDr16JfRRQLlo5fvdAIWkd
        /7ClLfjC84o1bMxnoIw8MMUIQMpm+bXatCBFKtFLmDPaOaSVonB55a9RF8nfA6ha
        qFZDFwk7LAfj9S9z3e56n3CO3yN2g4cPABVmeNcBt89ChjGQmcD1XHsDF5MTLuwA
        mVsI4LGkT4TP26/hkWek/MpLse8bBTKerSlFB3b2o1KOSClIA+vMqSh4t3Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1659064422; x=1659150822; bh=jmTWaMJZZpaHx/eRfunc9ygBCF1S
        RQEFNuZIY6+FOFY=; b=F/WdDtXIGQ44bvckNeMNE+SyZuVqW95jYqFoAzPzvcFx
        tuOfOlqrU3ViMNVqXxJN+UWJ1v9yLDwpKxId0aBEQOLpRAFqtrC1HXQWour0gIfz
        CkrS2piNViC0lpco7dsd/ubWdatz2jnQJFvG2gp4+uJX8JNHRXnqa+sZBv43bYV3
        Ik2KzX5inDOROHOfY9WhrckkXBa4PabqxnrIFvHR4aHpL18fHC/C5awjjtQyILib
        7NV6/fE6eduBhfmYOsf5bKa7XdHjf51Z7C6bqm6Nk5bdj0Ak4IfDLAVB4GyWrHlI
        C6k6koNZX10siLw4vDemcEfj8Ls6x96rMieyWhHOXw==
X-ME-Sender: <xms:ZlDjYn_eXxWETc7UI7n5OMhsZ8y2EJI7CwqmfSyh593HofxfRdxLBQ>
    <xme:ZlDjYjvywcJv6TJvXxF7BRW05k_5FC4hxB6EXGXiwjDM6uDlFkttsoHFH_xc83h4y
    l8lwMkpEQg4JS5N6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdduiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpefhheehgfekuddutedthfevfeejtefftddvveekgefgheffgeekjeet
    vdeuveeuleenucffohhmrghinhepuggvvhhitggvthhrvggvrdhorhhgpdhgihhthhhusg
    drtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:ZlDjYlB9-Zt7eKWAw-Y-WirLKQFtBs7AwrRl2KZ02BvEJ5PLeaGEhg>
    <xmx:ZlDjYjenc7pY4RhIJhDxPesvzJveoZJf0Ws6UttDtipg92Qf9pEwvg>
    <xmx:ZlDjYsNgcWBFomzA0fHTlL5WvmrQxZ1mgrybf1XjEr6Zgqk3XGQIPw>
    <xmx:ZlDjYr0inz3-O1AtQxF9Z5UC_Zg5hJsJ_SdBSZYH5tHpjG0D40kaCw>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 82EA21700083; Thu, 28 Jul 2022 23:13:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <4c4462a6-e950-48cb-b9ba-822909a86867@www.fastmail.com>
In-Reply-To: <SEZPR06MB5269DFE2CF762B62846D315EF2999@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
 <20220516064900.30517-3-ryan_chen@aspeedtech.com>
 <5d863bc1-4f27-48b6-89ab-c3f02bc09057@www.fastmail.com>
 <SEZPR06MB5269DFE2CF762B62846D315EF2999@SEZPR06MB5269.apcprd06.prod.outlook.com>
Date:   Fri, 29 Jul 2022 12:43:22 +0930
From:   "Andrew Jeffery" <andrew@aj.id.au>
To:     "Ryan Chen" <ryan_chen@aspeedtech.com>,
        "Joel Stanley" <joel@jms.id.au>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>
Cc:     BMC-SW <BMC-SW@aspeedtech.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings for AST2600 i2C
 driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Jul 2022, at 12:33, Ryan Chen wrote:
> Hello Andrew,
>
>> -----Original Message-----
>> From: Andrew Jeffery <andrew@aj.id.au>
>> Sent: Friday, July 29, 2022 10:29 AM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Joel Stanley <joel@jms.id.au>;
>> Philipp Zabel <p.zabel@pengutronix.de>; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org;
>> openbmc@lists.ozlabs.org
>> Cc: BMC-SW <BMC-SW@aspeedtech.com>
>> Subject: Re: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings for AST2600
>> i2C driver
>> 
>> Hi Ryan,
>> 
>> On Mon, 16 May 2022, at 16:18, ryan_chen wrote:
>> > AST2600 support new register set for I2C controller, add bindings
>> > document to support driver of i2c new register mode controller
>> >
>> > Signed-off-by: ryan_chen <ryan_chen@aspeedtech.com>
>> > ---
>> >  .../bindings/i2c/aspeed,i2c-ast2600.ymal      | 78
>> +++++++++++++++++++
>> >  1 file changed, 78 insertions(+)
>> >  create mode 100644
>> > Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
>> >
>> > diff --git
>> > a/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
>> > b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
>> > new file mode 100644
>> > index 000000000000..7c75f5bac24f
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/i2c/aspeed,i2c-ast2600.ymal
>> > @@ -0,0 +1,78 @@
>> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
>> > +---
>> > +$id: http://devicetree.org/schemas/i2c/aspeed,i2c-ast2600.yaml#
>> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> > +
>> > +title: AST2600 I2C Controller on the AST26XX SoCs Device Tree
>> > +Bindings
>> > +
>> > +maintainers:
>> > +  - Ryan Chen <ryan_chen@aspeedtech.com>
>> > +
>> > +allOf:
>> > +  - $ref: /schemas/i2c/i2c-controller.yaml#
>> > +
>> > +properties:
>> > +  compatible:
>> > +    enum:
>> > +      - aspeed,ast2600-i2c
>> 
>> The original driver uses e.g. aspeed,ast2500-i2c-bus for the subordinate
>> controllers. While the register layout changes, I'd prefer we try to use the
>> existing compatibles rather than introducing a new set and causing some
>> confusion.
>> 
>> Further, what you're proposing here is effectively being used to select the
>> driver implementation, which isn't the purpose of the devicetree.
>> 
>> My preference would be to reuse the existing compatibles and instead select
>> the driver implementation via Kconfig. Or, if we can figure out some way to do
>> so, support both register interfaces in the one driver implementation and fall
>> back to the old register interface where the new one isn't available (I don't
>> think this is feasible though).
>> 
> Yes, that the reason go for another driver ast2600 to implement.
> Like others SOC driver implement different generation have diff driver 
> in Kconfig 
> and Makefile.
> Example :
> https://github.com/torvalds/linux/blob/master/drivers/i2c/busses/Makefile#L82-L84
>
>
>> > +
>> > +  reg:
>> > +    minItems: 1
>> > +    items:
>> > +      - description: address offset and range of bus
>> > +      - description: address offset and range of bus buffer
>> > +
>> > +  interrupts:
>> > +    maxItems: 1
>> > +
>> > +  clocks:
>> > +    maxItems: 1
>> > +    description:
>> > +      root clock of bus, should reference the APB
>> > +      clock in the second cell
>> > +
>> > +  resets:
>> > +    maxItems: 1
>> > +
>> > +  bus-frequency:
>> > +    minimum: 500
>> > +    maximum: 2000000
>> > +    default: 100000
>> > +    description: frequency of the bus clock in Hz defaults to 100 kHz
>> > when not
>> > +      specified
>> > +
>> > +  multi-master:
>> > +    type: boolean
>> > +    description:
>> > +      states that there is another master active on this bus
>> > +
>> > +required:
>> > +  - reg
>> > +  - compatible
>> > +  - clocks
>> > +  - resets
>> > +
>> > +unevaluatedProperties: false
>> > +
>> > +examples:
>> > +  - |
>> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> > +    #include <dt-bindings/clock/ast2600-clock.h>
>> > +
>> > +    i2c_gr: i2c-global-regs@0 {
>> > +      compatible = "aspeed,ast2600-i2c-global", "syscon";
>> > +      reg = <0x0 0x20>;
>> > +      resets = <&syscon ASPEED_RESET_I2C>;
>> > +    };
>> > +
>> > +    i2c0: i2c-bus@80 {
>> > +      #address-cells = <1>;
>> > +      #size-cells = <0>;
>> > +      #interrupt-cells = <1>;
>> > +      compatible = "aspeed,ast2600-i2c-bus";
>> 
>> This isn't quite right with respect to your binding description above :)
> Yes, the compatible need to be " aspeed,ast2600-i2c" is that your point ?

Yes, but only if we agree that we should have different compatibles for 
the different drivers. I'm not convinced about that yet.

I think it's enough to have different Kconfig symbols, and select the 
old driver in aspeed_g4_defconfig, and the new driver in 
aspeed_g5_defconfig. Won't that gives us the right outcome without
requiring a new set of compatibles?

Andrew
