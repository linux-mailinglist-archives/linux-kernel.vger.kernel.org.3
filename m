Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DAB58D168
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 02:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244691AbiHIAgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 20:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiHIAg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 20:36:29 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F34C12AB3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 17:36:27 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 086515C0003;
        Mon,  8 Aug 2022 20:36:25 -0400 (EDT)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Mon, 08 Aug 2022 20:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1660005385; x=1660091785; bh=zg8D05det1
        7wHTcb1SQBJ3QqJGHDqgu5vFpaar6HYxg=; b=kHmVmqK+mbKwLRwLUD31etUwad
        7t7bdNYlFth+90f6jokU/Dwkk8d2OpXixJ0L4T07exT2bBuRjb5eNl/PF1N0mbsb
        F0wz7850K2Xp4+tMd8XxUYK5itbs//3OI1qObAP8MUwcPe5trKVKS5tILE2iI8Om
        Mmmg6nClEuJBHPCddo7XUg/Sf1U77SCyD94HtGe+wOAIFvM7j5uJHONzqyU5CLNB
        yUSImXIKeiYOzd54ow9iuLkEfB3W4cxdYMrXZsd79CmdOg9OhT43MWUVzfDYltLk
        aPmynAktSYaFoFfbzPH9yltZr0urmV29G+EOzfXwG9h8Ojuj/1ynwfWiUzhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660005385; x=1660091785; bh=zg8D05det17wHTcb1SQBJ3QqJGHD
        qgu5vFpaar6HYxg=; b=SllE8aS4h2z9MxtoeAolX2GrOP8mOJu9k3Joa0F0axa4
        E9dIyZSiMJI6DZVOHZuOkqTF5ADybN6kxMMcF4sXne7sNg5MnHdx822jX2ny+LSY
        YgegNddAskWa3SlD/STYB51J3MzuVtKqoHjPburHAfnc8XoqO8ddaXCDOCU4YPt9
        zkjKsfJ0sBp9f4QBj6D5xltsxCQhDTQYeyzjQl1FraeDIC/68x54KTzxRwIFvsvm
        hE3klqEfsWRDxRjLGwp2E5vJqbP4G6T5KW7vsJOUOcn12zPuom1xz/dVvWkppoEx
        rdMU7FIZow7f2UK2K/yk8nvuYJ4BrQov4XappP5GDA==
X-ME-Sender: <xms:B6zxYuA27BcCXmQTkSEuf2mrsoI0NPBiOJud8u5LHS4t__jK8kWwiA>
    <xme:B6zxYoi5VofS3XlBN4-F_8vBU05Yg3cVWhd7V7ddUvMg9IA0oPotMq3uSA2cauvxd
    k95GqRJSQjNn5TgJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefledgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ughrvgifucflvghffhgvrhihfdcuoegrnhgurhgvfiesrghjrdhiugdrrghuqeenucggtf
    frrghtthgvrhhnpeekvdekjeekgfejudffteetgeejkeetteduvedtffdtledutdfhheev
    feetkeeiteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrnhgurhgvfiesrghjrdhiugdrrghu
X-ME-Proxy: <xmx:B6zxYhmHXXuBsboX2cRurVAuaiOkb_HBam5SVfx0Tblsv6akdQvagw>
    <xmx:B6zxYsxnIgwSXFqx0aLFgK1aO-RQrlS-oEvRn188GuFTB8MPJmxtkg>
    <xmx:B6zxYjQ-O-iio_KERf8Ul5otTiwh9xSv1nJvflduAn3OjIkDYGEMQg>
    <xmx:CazxYkIPI5XJ1Yl36JGA7ZG6m-RedNAn8CEXNM0rN-Dg-7Z-B1gi7w>
Feedback-ID: idfb84289:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id D26901700082; Mon,  8 Aug 2022 20:36:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-758-ge0d20a54e1-fm-20220729.001-ge0d20a54
Mime-Version: 1.0
Message-Id: <cd11b517-ae6c-4a67-9f43-74825812b00b@www.fastmail.com>
In-Reply-To: <SEZPR06MB52695BDBE90ECE00DB2D9684F29D9@SEZPR06MB5269.apcprd06.prod.outlook.com>
References: <20220516064900.30517-1-ryan_chen@aspeedtech.com>
 <20220516064900.30517-3-ryan_chen@aspeedtech.com>
 <5d863bc1-4f27-48b6-89ab-c3f02bc09057@www.fastmail.com>
 <SEZPR06MB5269DFE2CF762B62846D315EF2999@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <4c4462a6-e950-48cb-b9ba-822909a86867@www.fastmail.com>
 <SEZPR06MB52695BDBE90ECE00DB2D9684F29D9@SEZPR06MB5269.apcprd06.prod.outlook.com>
Date:   Tue, 09 Aug 2022 10:04:37 +0930
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 2 Aug 2022, at 18:34, Ryan Chen wrote:
> Hello,
>
>> -----Original Message-----
>> From: Andrew Jeffery <andrew@aj.id.au>
>> Sent: Friday, July 29, 2022 11:13 AM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Joel Stanley <joel@jms.id.au>;
>> Philipp Zabel <p.zabel@pengutronix.de>; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org;
>> openbmc@lists.ozlabs.org
>> Cc: BMC-SW <BMC-SW@aspeedtech.com>
>> Subject: Re: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings for AST2600
>> i2C driver
>> 
>> 
>> 
>> On Fri, 29 Jul 2022, at 12:33, Ryan Chen wrote:
>> > Hello Andrew,
>> >
>> >> -----Original Message-----
>> >> From: Andrew Jeffery <andrew@aj.id.au>
>> >> Sent: Friday, July 29, 2022 10:29 AM
>> >> To: Ryan Chen <ryan_chen@aspeedtech.com>; Joel Stanley
>> >> <joel@jms.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
>> >> linux-arm-kernel@lists.infradead.org;
>> >> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org;
>> >> openbmc@lists.ozlabs.org
>> >> Cc: BMC-SW <BMC-SW@aspeedtech.com>
>> >> Subject: Re: [PATCH v3 2/3] dt-bindings: i2c-ast2600: Add bindings
>> >> for AST2600 i2C driver
>> >>
>> >> Hi Ryan,
>> >>
>> >> On Mon, 16 May 2022, at 16:18, ryan_chen wrote:
>> >> > +    i2c0: i2c-bus@80 {
>> >> > +      #address-cells = <1>;
>> >> > +      #size-cells = <0>;
>> >> > +      #interrupt-cells = <1>;
>> >> > +      compatible = "aspeed,ast2600-i2c-bus";
>> >>
>> >> This isn't quite right with respect to your binding description above
>> >> :)
>> > Yes, the compatible need to be " aspeed,ast2600-i2c" is that your point ?
>> 
>> Yes, but only if we agree that we should have different compatibles for the
>> different drivers. I'm not convinced about that yet.
>> 
>> I think it's enough to have different Kconfig symbols, and select the old driver
>> in aspeed_g4_defconfig, and the new driver in aspeed_g5_defconfig. Won't
>> that gives us the right outcome without requiring a new set of compatibles?
>> 
> The new driver in aspeed_g5_defconfig.

Right, behind a new Kconfig option.

> And different compatible string 
> claim will
> Load the new or legacy driver,

I don't think we need this. It's enough to enable the new driver in the 
defconfig (and possibly disable the config option for the old driver).

> it should ok like the different 
> generation SOC. Have 
> different design.
> Am I right?

We have SoC-specific compatibles already, so the new driver can just 
bind on the compatibles for the SoC revisions that have the new 
register interface. The old driver just binds to the device in the SoCs 
that have the old register interface.

There's an overlap in support between the two drivers, but for people 
who care about which implementation they use they can choose to exclude 
that driver from their kernel config.

None of this requires more compatibles be added.

Does that help?

Andrew
