Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292894B0D2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 13:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbiBJMF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 07:05:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241393AbiBJMF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 07:05:26 -0500
Received: from ssl.serverraum.org (ssl.serverraum.org [176.9.125.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFBA10B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 04:05:27 -0800 (PST)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id EC8822223A;
        Thu, 10 Feb 2022 13:05:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1644494725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GokQuS+suI7AFN8u7SGXFvEJz7aki0KJ68Y/NTbDdeA=;
        b=f25C19yRv3k+t8BbJBx+qqCKdrKwAaHf4qgcgO0Hu2jfGZLbhPEekAgTYLfFmMUrJvcwfA
        GrcyU0c9LAXQT5KgI+GF/Ja8FypMyb2FL1psBkc6VPEhKWe7iCe+xXxg0rCFiey7HOd2F0
        KQWd4Q7NPOZJi43WvbA7JimyUL18+W8=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Feb 2022 13:05:24 +0100
From:   Michael Walle <michael@walle.cc>
To:     Kavyasree.Kotagiri@microchip.com
Cc:     Manohar.Puri@microchip.com, UNGLinuxDriver@microchip.com,
        alexandre.belloni@bootlin.com, arnd@arndb.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Nicolas.Ferre@microchip.com,
        olof@lixom.net, robh+dt@kernel.org, soc@kernel.org
Subject: Re: [PATCH v4] ARM: dts: add DT for lan966 SoC and 2-port board
 pcb8291
In-Reply-To: <CO1PR11MB4865E913D083C1D80D4E1F80922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220209111318.21112-1-kavyasree.kotagiri@microchip.com>
 <20220209184600.1230365-1-michael@walle.cc>
 <CO1PR11MB486534A2987684CC7402CE06922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
 <97bcfa4417d5f8c41cc6aa1e411c8747@walle.cc>
 <CO1PR11MB4865E913D083C1D80D4E1F80922F9@CO1PR11MB4865.namprd11.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.12
Message-ID: <b98f40575f88a0bbf205d628f73cccac@walle.cc>
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

Am 2022-02-10 12:52, schrieb Kavyasree.Kotagiri@microchip.com:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know 
>> the
>> content is safe
>> 
>> Am 2022-02-10 10:40, schrieb Kavyasree.Kotagiri@microchip.com:
>> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know
>> >> the
>> >> content is safe
>> 
>> >> > +     clocks {
>> >> [..]
>> >> > +
>> >> > +             nic_clk: nic_clk {
>> >>
>> >> What does nic_clk stand for? If I had to guess, it
>> >> has something to do with network. But..
>> >>
>> > NIC clock is the clock used by AXI, AHB fabric and APB bridges which
>> > connects all the peripherals.
>> > It is named so because the AXI fabric is based on NIC400 IP from ARM
>> 
>> Ok, thanks for clarification.
>> 
>> 
>> >> > +             watchdog: watchdog@e0090000 {
>> >> > +                     compatible = "snps,dw-wdt";
>> >> > +                     reg = <0xe0090000 0x1000>;
>> >> > +                     interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>> >> > +                     clocks = <&nic_clk>;
>> >>
>> >> Btw. can we disable all nodes by default and enable them
>> >> in the board dts files?
>> > I would like to have only board specific nodes enabled in dts files
>> > and rest of them in dtsi file
>> 
>> And how do you know which ones are board specific? E.g. I would like
>> to add our board which is also based on the lan9668. Maybe I don't
>> want a watchdog (or whatever node). Of course I could use
>> 
>> &watchdog {
>>    status = "disabled";
>> };
>> 
>> But IMHO opt-in is better. At least thats what we are doing for
>> the layerscape over on arm64.
>> 
> Basically, I am disabling only the nodes which have pinctrl settings
> in dtsi file
> and enable in dts to make sure there are no conflicts on pins on the 
> board.

Thats not what I'm asking. I would like to see *optional* nodes
disabled by default. Whether the watchdog is optional might be
debatable, but what about the usb controller and the qspi
controller? They don't have shared pins AFAIK, so according
to your rule, they will be enabled by default and each board
which doesn't have anything connected on these pins would have
to disabled it.

Please keep in mind that this .dtsi will also be used by boards
not manufactured by microchip.

-michael
