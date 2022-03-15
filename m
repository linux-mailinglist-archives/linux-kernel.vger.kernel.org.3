Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3194A4D9D80
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349160AbiCOOaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiCOOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:30:16 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1457344779;
        Tue, 15 Mar 2022 07:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=GxMzfNRQtZ04+lHo/O1UCEwaB2Ydbfpf2yzGh5HPxHc=; b=olC8YY+DSx6sXmlZVmrtQDGF50
        04E3CKz3W/4CMUH8fsWmF8Mu0+RcSMZEzzPIkruCbYjw5rkXzg0lzMSycIvLuXicr9N9VEON67G9l
        lxmB3rRgBHTIH85AAh/Vjr9VDBs+sZLs3TteZ/CveoanmoAm0TA4/npRKzTXwCXWz8Xg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nU8AM-00AyZC-FB; Tue, 15 Mar 2022 15:28:50 +0100
Date:   Tue, 15 Mar 2022 15:28:50 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 7/8] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <YjCiot+PSv3ZRS4J@lunn.ch>
References: <20220314213143.2404162-1-chris.packham@alliedtelesis.co.nz>
 <20220314213143.2404162-8-chris.packham@alliedtelesis.co.nz>
 <Yi/cyUJ6oIs96UW2@lunn.ch>
 <7b78853e-71ec-7c57-4cac-5cd6303f3b13@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b78853e-71ec-7c57-4cac-5cd6303f3b13@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15, 2022 at 02:11:56AM +0000, Chris Packham wrote:
> 
> On 15/03/22 13:24, Andrew Lunn wrote:
> >> diff --git a/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi b/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
> >> new file mode 100644
> >> index 000000000000..ebe464b9ebd2
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/marvell/armada-98dx2530.dtsi
> >> @@ -0,0 +1,343 @@
> >> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >> +/*
> >> + * Device Tree For AC5.
> >> + *
> >> + * Copyright (C) 2021 Marvell
> >> + *
> >> + */
> >> +
> >> +/dts-v1/;
> >> +	memory@0 {
> >> +		device_type = "memory";
> >> +		reg = <0x2 0x00000000 0x0 0x40000000>;
> >> +		// linux,usable-memory = <0x2 0x00000000 0x0 0x80000000>;
> >> +	};
> > Is the memory part of the SoC, or is it on the board? Normally it is
> > on the board, so should be in the .dts file. But Apple M1 etc...

> I also wasn't sure about linux,usable-memory. It's commented out so it's 
> obviously doing nothing but should it? No other in-tree dts files have it.

Hi Chris

I've no idea what it means. Maybe search the SDK and see if they have
some code and what it does. But i would drop it.

     Andrew
