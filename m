Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33021524182
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349657AbiELA2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349655AbiELA2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:28:37 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD221AEC69;
        Wed, 11 May 2022 17:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JQQpXDILRhi5lJijLn3ENVGB5zi9S0zGMEw13K7gPKk=; b=blQpV2LjsgKnCKs0TW01z5Mbf0
        oosEGMaHooVxuB5o+XTXzqenvcUp+3IdvMLDGqHM5zTxXIA22z2i07aMFUJ73a/ZLp9jjjMvalBk9
        ErAfLohHDRErOuVrWafejakN50eHMlryhbzlq9dGx72qjBDr/g8VzFy7Bo50GhShJZrs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nowfw-002N8s-Ru; Thu, 12 May 2022 02:27:28 +0200
Date:   Thu, 12 May 2022 02:27:28 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: marvell: Document the AC5/AC5X
 compatibles
Message-ID: <YnxUcB2e+Y9gtwI7@lunn.ch>
References: <20220510231002.1160798-1-chris.packham@alliedtelesis.co.nz>
 <20220510231002.1160798-2-chris.packham@alliedtelesis.co.nz>
 <YnvsInrh03BVh7lN@lunn.ch>
 <608a7d9d-9238-281a-8770-aa20feb7e6be@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608a7d9d-9238-281a-8770-aa20feb7e6be@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 11:14:25PM +0000, Chris Packham wrote:
> 
> On 12/05/22 05:02, Andrew Lunn wrote:
> > On Wed, May 11, 2022 at 11:10:00AM +1200, Chris Packham wrote:
> >> Describe the compatible properties for the Marvell Alleycat5/5X switches
> >> with integrated CPUs.
> >>
> >> Alleycat5:
> >> * 98DX2538: 24x1G + 2x10G + 2x10G Stack
> >> * 98DX2535: 24x1G + 4x1G Stack
> >> * 98DX2532: 8x1G + 2x10G + 2x1G Stack
> >> * 98DX2531: 8x1G + 4x1G Stack
> >> * 98DX2528: 24x1G + 2x10G + 2x10G Stack
> >> * 98DX2525: 24x1G + 4x1G Stack
> >> * 98DX2522: 8x1G + 2x10G + 2x1G Stack
> >> * 98DX2521: 8x1G + 4x1G Stack
> >> * 98DX2518: 24x1G + 2x10G + 2x10G Stack
> >> * 98DX2515: 24x1G + 4x1G Stack
> >> * 98DX2512: 8x1G + 2x10G + 2x1G Stack
> >> * 98DX2511: 8x1G + 4x1G Stack
> >>
> >> Alleycat5X:
> >> * 98DX3500: 24x1G + 6x25G
> >> * 98DX3501: 16x1G + 6x10G
> >> * 98DX3510: 48x1G + 6x25G
> >> * 98DX3520: 24x2.5G + 6x25G
> >> * 98DX3530: 48x2.5G + 6x25G
> >> * 98DX3540: 12x5G/6x10G + 6x25G
> >> * 98DX3550: 24x5G/12x10G + 6x25G
> > Hi Chris
> >
> > When looking at this list, is it just the switch which changes, and
> > everything else in the package stays the same?
> 
> CPU wise I've been told everything is identical. The differences are all 
> in the switch side.

O.K. That helps a lot with this description.

> > armada-98DX2538.dtsi which extends armada-98DX25xx.dtsi
> 
> There wouldn't be anything to add in 98DX2538 (at least not until we 
> have a proper switchdev driver).

Does the switch/SoC have ID registers? For mv88e6xxx, the switch is
identified by its ID registers, so we don't have switch specific
compatible value in DT. Hopefully it is the same here. All we need to
say is that there is a switch in the main .dtsi file, and the .dts
file would then indicate which ports are actually used.

   Andrew
