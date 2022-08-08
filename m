Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28E5758CF33
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244406AbiHHUdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244396AbiHHUdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:33:39 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA28A1ADAA;
        Mon,  8 Aug 2022 13:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=y0imL6IC5NO5SCS0xTAMm+Oe4ZYghZ7bwK/Q7XSJbXI=; b=Fr
        HtMXtf2E/4vJLxwYWM9ljPVsn3HGJvIw4tKnkc7dpn8WJmPorNyHDu1qLyVtw2WpwYffB9REN5jVF
        96RF+kOZmDOUlCj2zYXO955eAIkZmKNkQnrea4RKfCZOL1kA84I9CHDqEThAzUzgaE7Vk+fojn8in
        hTBXObYkC8NCvA4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1oL9RK-00ClRp-84; Mon, 08 Aug 2022 22:33:30 +0200
Date:   Mon, 8 Aug 2022 22:33:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <YvFzGhBRPTXgdCd8@lunn.ch>
References: <20220713125644.3117-1-pali@kernel.org>
 <20220808202456.lpwvhq22edb56ptf@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220808202456.lpwvhq22edb56ptf@pali>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 08, 2022 at 10:24:56PM +0200, Pali Rohár wrote:
> PING?

It is too late for the merge window.

> > diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > index 5ce55bdbb995..02ae1e153288 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > @@ -13,7 +13,7 @@
> >  
> >  / {
> >  	model = "Marvell Armada 3720 SoC";
> > -	compatible = "marvell,armada3720", "marvell,armada3710";
> > +	compatible = "marvell,armada3720", "marvell,armada3700";

Does it make sense to have a compatible here? The board .dts should
provide it. And if the board does not provide it, we probably want the
board to not boot because it does not have a compatible.

   Andrew
