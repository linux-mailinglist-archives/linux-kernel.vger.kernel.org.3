Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C165238D6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344639AbiEKQUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiEKQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:20:19 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F282B2380C0;
        Wed, 11 May 2022 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aseFt7/82bh+eNTadV1Va2IDS2pSGM2YAvjK7lzG6tw=; b=fv1SDPXQb+MbUfL3RUhuYJpHCb
        RkDCN5ntA1tJwJQYl8gcG9CqsdxjJgPPW/t7bD1aPC8nhkT1p/vIsJZnXMAaAv4RX5MKaCZrenJSb
        NsnrmBK+HFpMu99MODtQFCRYGCVIPtXX64dDqId8fSo+yBElDdRhGj641foxPWItttGo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1nop4C-002KYw-S2; Wed, 11 May 2022 18:20:00 +0200
Date:   Wed, 11 May 2022 18:20:00 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     catalin.marinas@arm.com, will@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, kostap@marvell.com,
        robert.marko@sartura.hr, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 1/2] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <YnviMOtXX+us+IA4@lunn.ch>
References: <20220504044624.951841-1-chris.packham@alliedtelesis.co.nz>
 <20220511161003.GE10145@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511161003.GE10145@plvision.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:10:03PM +0300, Vadym Kochan wrote:
> Hi Chris,
> 
> > arch/arm64/boot/dts/marvell/Makefile          |   1 +
> > .../boot/dts/marvell/armada-98dx2530.dtsi     | 310 ++++++++++++++++++
> > arch/arm64/boot/dts/marvell/rd-ac5x.dts       |  90 +++++
> > 3 files changed, 401 insertions(+)
> 
> Marvell is going to start the upstreaming of AC5X boards support, we have also patches with similar .dts(i) files
> but with different naming:
> 
>     ac5.dtsi
>     ac5_rd.dts
>     ac5_db.dts
>     ac5x_db.dts
> 
> What do you think about to use these naming scheme ?

Chris has done all the hard work, he gets to pick the naming. And get
his files merged first.

However, now that i come to look in arch/arm64/boot/dts/marvell, i
think most of the current filenames proposed don't match the current names.

armada-98dx2530.dtsi fits the current pattern.

However, Chris's board files should probably be

armada-98dx2530-rd.dts

and the other files should be

armada-98dx2530-db.dts

armada-98dx2530-x-db.dts

What does the x in x_db mean? Does that refer to the board or the SoC?

	Andrew
