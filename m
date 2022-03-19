Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D584DE7A3
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 12:38:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242815AbiCSLjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 07:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiCSLjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 07:39:39 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AE586E16;
        Sat, 19 Mar 2022 04:38:17 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 094082223B;
        Sat, 19 Mar 2022 12:38:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1647689895;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zmfB9xFrYldmqq1FLPQ4/Iztnp51kdC7eGjZLGK9R9I=;
        b=nK72s+a+CriFy2uCBz7cVC/oV2dJ7STsg5K6+FvOMXhbU9OHAvyFezhKJEonlNukjIE/At
        iOXENIVw/Ky8/ukxJLQk4qnF9236PXkZDjyKrMEr+u4yWjrEg/Q+8XVa+s9iLb4n4DtONH
        11Plc7zM79jDmEgGlak5dmfX2BOKI3A=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 19 Mar 2022 12:38:14 +0100
From:   Michael Walle <michael@walle.cc>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Paul Burton <paulburton@kernel.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Antoine Tenart <atenart@kernel.org>,
        Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        UNGLinuxDriver@microchip.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org
Subject: Re: [PATCH v2 7/8] ARM: dts: lan9662-pcb8291: fix pinctrl node name
In-Reply-To: <cf2a6d1a-bf98-e382-2623-e44e5979ca29@gmail.com>
References: <20220318202547.1650687-1-michael@walle.cc>
 <20220318202547.1650687-8-michael@walle.cc>
 <cf2a6d1a-bf98-e382-2623-e44e5979ca29@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <e7467fe3a8dae5f5af84d595a0c4ab16@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am 2022-03-19 09:24, schrieb Sergei Shtylyov:
> Hello!
> 
> On 3/18/22 11:25 PM, Michael Walle wrote:
> 
>> The pinctrl device tree binding will be converted to YAML format. All
>> the pin nodes should end with "-pins". Fix them.
> 
>    It does end with "pins" already, right?

It ends with "_pins". Please note the underscore.

>> Fixes: 290deaa10c50 ("ARM: dts: add DT for lan966 SoC and 2-port board 
>> pcb8291")
>> Signed-off-by: Michael Walle <michael@walle.cc>
>> ---
>>  arch/arm/boot/dts/lan966x-pcb8291.dts | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/arm/boot/dts/lan966x-pcb8291.dts 
>> b/arch/arm/boot/dts/lan966x-pcb8291.dts
>> index 3281af90ac6d..3c7e3a7d6f14 100644
>> --- a/arch/arm/boot/dts/lan966x-pcb8291.dts
>> +++ b/arch/arm/boot/dts/lan966x-pcb8291.dts
>> @@ -35,7 +35,7 @@ fc3_b_pins: fcb3-spi-pins {
>>  		function = "fc3_b";
>>  	};
>> 
>> -	can0_b_pins:  can0_b_pins {
>> +	can0_b_pins:  can0-b-pins {
> 
>    Mhm, I can't even see what is changed here... :-/

The name of the node, s/_/-/

-michael
