Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC152419E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 02:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349725AbiELAkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 20:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiELAkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 20:40:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A6227B62;
        Wed, 11 May 2022 17:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=VPmFxMFfmvVw5yiFsxLNXQm15IP1H299vGKa55VJwbI=; b=kOTQ3TBmqwKkErYBCRGSHezqOM
        CHsRC8aiA0+RS7doj4IbMGal84S1oM6URBpRwRhWjvS5+zbH3qesJjRKTFvZ85bArWT8fkIBq5/b5
        eeAkzzk/RgjmGd4tPWb1rQ9w8OQY4hVmCXYpIOFhTeBOpP1m5W011YiRP//XTR/l9XuQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nowrw-002ND2-Qh; Thu, 12 May 2022 02:39:52 +0200
Date:   Thu, 12 May 2022 02:39:52 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "kostap@marvell.com" <kostap@marvell.com>,
        "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <YnxXWIloDzfg8bh0@lunn.ch>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220511161003.GE10145@plvision.eu>
 <YnviMOtXX+us+IA4@lunn.ch>
 <c781f7eb-86f2-16c4-1380-b08b974900ff@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c781f7eb-86f2-16c4-1380-b08b974900ff@alliedtelesis.co.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:59:37PM +0000, Chris Packham wrote:
> 
> On 12/05/22 04:20, Andrew Lunn wrote:
> > On Wed, May 11, 2022 at 07:10:03PM +0300, Vadym Kochan wrote:
> >> Hi Chris,
> >>
> >>> arch/arm64/boot/dts/marvell/Makefile          |   1 +
> >>> .../boot/dts/marvell/armada-98dx2530.dtsi     | 310 ++++++++++++++++++
> >>> arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  90 +++++
> >>> 3 files changed, 401 insertions(+)
> >> Marvell is going to start the upstreaming of AC5X boards support,
> That's good news. I'm probably the customer that's been nagging the 
> Marvell support team. But I'm also impatient hence I started working on 
> this series. The pinctrl and mvneta changes have already been accepted.
> >>   we have also patches with similar .dts(i) files
> >> but with different naming:
> >>
> >>      ac5.dtsi
> >>      ac5_rd.dts
> >>      ac5_db.dts
> >>      ac5x_db.dts
> >>
> >> What do you think about to use these naming scheme ?
> 
> Personally I thought they'd be rejected upstream as being too vague and 
> generic.

Agreed.

> I'm not against changing if there is a consensus. On another thread the 
> idea of armada-98dx25xx/armada-98dx35xx was mentioned. That might be a 
> reasonable compromise (although technically there's no difference in the 
> CPU block between the 25xx and 35xx).

Until we find there is a difference. Marvell, can you confirm that the
switch really is the only difference?

This might also come down to ID registers. The DT could be enough to
find the ID of the device, the rest is then done in the drivers, not
DT.

> > However, now that i come to look in arch/arm64/boot/dts/marvell, i
> > think most of the current filenames proposed don't match the current names.
> >
> > armada-98dx2530.dtsi fits the current pattern.
> >
> > However, Chris's board files should probably be
> >
> > armada-98dx2530-rd.dts
> >
> > and the other files should be
> >
> > armada-98dx2530-db.dts
> >
> > armada-98dx2530-x-db.dts
> >
> > What does the x in x_db mean? Does that refer to the board or the SoC?
> 
> The x is from AC5X so we'd actually have armada-98dx25xx-db.dts and 
> armada-98dx35xx-db.dts. My board would be called armada-98dx35xx-rd.dts 
> or perhaps armada-98dx3550-rd.dts.

armada-98dx25xx and armada-98dx35xx does help with the naming.  So it
probably is worth having armada-98dx35xx which simply includes
armada-98d25xx.

	Andrew
