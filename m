Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F7A48E893
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240573AbiANKvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiANKvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:51:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBBBC061574;
        Fri, 14 Jan 2022 02:51:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0555561EDC;
        Fri, 14 Jan 2022 10:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D30C36AEA;
        Fri, 14 Jan 2022 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642157463;
        bh=bwrKb5nAY1yxA7hO1VfpRRfXBzaaN35Y7HZsuMZ/sQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AroH/H9LPZJM5aRxed34qf1Wxr4EkTk9guDLhEoBlZWeTLfpwb4Vbw266zUyaf1UG
         iAaAgZU01LvZnWwimunky3+Z2UFB1OiVtLkrTW9pJiDC7F/eMJXZCPz210Q55U+ftv
         qLwPa6zLtdy+67nABXZ631xy0e8itMSmn2/nW9toG7FSDsuGSaE3q7frpa8Vt5xg9z
         BATbOHb+iSz08HU3nySD8uw6HxURgTAoJU5n3ucfTOASa0PdlJXd/qSyrK5CE/cks1
         WWN6AOP4Xy+XHBLUsyCAtBLknQ8BaLBd77/43tQmniFddyyJNXITf+uhiX2bt5dVXw
         KVJppvIThR4wQ==
Received: by pali.im (Postfix)
        id DF3EC7D1; Fri, 14 Jan 2022 11:51:00 +0100 (CET)
Date:   Fri, 14 Jan 2022 11:51:00 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Vladimir Vid <vladimir.vid@sartura.hr>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v7 0/6] serial: mvebu-uart: Support for higher baudrates
Message-ID: <20220114105100.im6gmkt6fjl2aiwl@pali>
References: <20210930095838.28145-1-pali@kernel.org>
 <20211103214209.azo2z3z4gy7aj5hu@pali>
 <87ee6bm9hn.fsf@BL-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ee6bm9hn.fsf@BL-laptop>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Stephen!

On Friday 17 December 2021 18:23:00 Gregory CLEMENT wrote:
> Hello Pali,
> 
> > On Thursday 30 September 2021 11:58:32 Pali Rohár wrote:
> >> This patch series add support for baudrates higher than 230400 on
> >> Marvell Armada 37xx boards.
> >
> > Stephen, Gregory, are there any issues with this patch series?
> 
> I am not found of these changes but let's apply it as I didn't take time
> to do a better review.
> 
> However I can't apply the dt part if the driver is not merged.

Stephen, are there any issues with driver (non-DT) part changes in this
patch series? If not, could you please merge them? This patch series is
here on the list since September without any request for change...

We would really like to see support for higher baudrates for Armada 3720
platforms in mainline kernel.

> Gregory
> 
> > If not, could you take them?
> >
> >> Changes in v7:
> >> * fixed lint errors in yaml binding file
> >> 
> >> Changes in v6:
> >> * fixed yaml binding file and dts files
> >> 
> >> Changes in v5:
> >> * fixed yaml binding file
> >> 
> >> Changes in v4:
> >> * converted armada3700-uart-clock documentation to YAML
> >> * split documentation changes into two commits:
> >>   - first which adds clock documentation
> >>   - second which updates UART documentation
> >> 
> >> Changes in v3:
> >> v3 is rebased on top of Linus master branch and all already applied patches
> >> were dropped. There are no changes in patches itself since v2.
> >> 
> >> Pali Rohár (6):
> >>   math64: New DIV_U64_ROUND_CLOSEST helper
> >>   serial: mvebu-uart: implement UART clock driver for configuring UART
> >>     base clock
> >>   dt-bindings: mvebu-uart: document DT bindings for
> >>     marvell,armada-3700-uart-clock
> >>   dt-bindings: mvebu-uart: update information about UART clock
> >>   arm64: dts: marvell: armada-37xx: add device node for UART clock and
> >>     use it
> >>   serial: mvebu-uart: implement support for baudrates higher than 230400
> >> 
> >>  .../clock/marvell,armada-3700-uart-clock.yaml |  59 ++
> >>  .../devicetree/bindings/serial/mvebu-uart.txt |   9 +-
> >>  arch/arm64/boot/dts/marvell/armada-37xx.dtsi  |  14 +-
> >>  drivers/tty/serial/Kconfig                    |   1 +
> >>  drivers/tty/serial/mvebu-uart.c               | 592 +++++++++++++++++-
> >>  include/linux/math64.h                        |  13 +
> >>  6 files changed, 667 insertions(+), 21 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/marvell,armada-3700-uart-clock.yaml
> >> 
> >> -- 
> >> 2.20.1
> >> 
> 
> -- 
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
