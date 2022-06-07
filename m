Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D152153FE55
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243468AbiFGMIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243459AbiFGMIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:08:00 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FB685EC7;
        Tue,  7 Jun 2022 05:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4qZMNchScS18GtLOGLWv0/eb8j4kTognaJ3arI79b68=; b=4iwtUVJgmnOUhJuW7XtXYaN6SR
        oht4um1BEjLyql/PwMCPfHBPqs6EcY2JvSHlTmQntqq2/dG+vuMyidipSjq2PjXlJs3Hexbky86wB
        yiX45cR6qY3y0vGhaqBF3fwgfTcSDHhvbHp9Kfc/OCnQvgCV2AVoEEOOb+HiMVcIIkzk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nyXzf-005wiU-GQ; Tue, 07 Jun 2022 14:07:31 +0200
Date:   Tue, 7 Jun 2022 14:07:31 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     20220515233047.531979-3-chris.packham@alliedtelesis.co.nz
Cc:     robh+dt@kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        robert.marko@sartura.hr, vadym.kochan@plvision.eu,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <Yp8/g0m0xWiRmOq9@lunn.ch>
References: <20220515233047.531979-3-chris.packham@alliedtelesis.co.nz>
 <20220607114936.GA18404@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607114936.GA18404@plvision.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 02:49:36PM +0300, Vadym Kochan wrote:
> Hi All,
> 
> > arch/arm64/boot/dts/marvell/Makefile          |   1 +
> > .../boot/dts/marvell/armada-98dx25xx.dtsi     | 297 ++++++++++++++++++
> > .../boot/dts/marvell/armada-98dx35xx-rd.dts   | 101 ++++++
> > .../boot/dts/marvell/armada-98dx35xx.dtsi     |  13 +
> 
> There is a proposal from the Marvell to replace "armada-" prefix to "ac5-" in DTS naming as there
> is no much common with Armada SoC's.

O.K. We can do this. But i hope it is not Marvell being lazy.

I can also see an advantage of using armada-, since it makes it clear
we are talking about mainline device tree files, not Marvell vendor
device tree files. It is not given they will be compatible.

       Andrew
