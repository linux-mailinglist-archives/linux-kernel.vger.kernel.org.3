Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9220C59747C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241112AbiHQQuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241264AbiHQQul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:50:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01798E0E9;
        Wed, 17 Aug 2022 09:50:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A782B81DE6;
        Wed, 17 Aug 2022 16:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13106C433C1;
        Wed, 17 Aug 2022 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660755038;
        bh=JEwEfjCb4C4SzZR1lAEd7D4zPmnRVNB2thOmFV8XBrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qU55I0OqTyKR5BqgGKxxsETiTzhw2IOV8EWdjSp6daCz5JeGYmvegWGkgtkqoivm5
         twiPQ1EW6t+t6SVUojuXt78ZzTp3l5y/xt7DJG66MILbs/ApHsS5a1/sR3CTZ6xn6W
         LPU8XxFo4LfLBxj3TX4SkwMjDBRybtjDsZw5W0XS8lRRUAx/2g+YAr6dY934SKofJv
         J0vAyVb+tdZIpqtnsnP1Yun7VR7v9kn84ZHZbdnZmVgMSZdLD6ogsOCZgP2ArMbBI5
         6WoOt7eKLdOmgjpjoxGYZZc426vpl4bs3MRrHoeTeg0xqSGPJdpoXwM311ZnF1OO+Z
         OtidPMttBVUDg==
Received: by pali.im (Postfix)
        id 14D54739; Wed, 17 Aug 2022 18:50:35 +0200 (CEST)
Date:   Wed, 17 Aug 2022 18:50:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/10] ARM: dts: mvebu: Add definitions for PCIe
 legacy INTx interrupts
Message-ID: <20220817165034.ymmha6swsi5iju27@pali>
References: <20220712164108.30262-1-kabel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220712164108.30262-1-kabel@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello! What is state of these patches? I see no response for more than month.

On Tuesday 12 July 2022 18:40:58 Marek Behún wrote:
> As suggested by Gregory [1] (although he suggested it only for armada
> 380), add definitions for PCIe legacy INTx interrupts into every DTS
> file used by the pci-mvebu.c controller driver.
> 
> It was tested on 88F6820 (A385) and 88F6281 (Kirkwood) SoCs.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/87wnhxjxlq.fsf@BL-laptop/
> 
> Changes since v1:
> - dropped armada-385 patch, which was already applied
> - added commit messages
> 
> Pali Rohár (10):
>   ARM: dts: kirkwood: Add definitions for PCIe legacy INTx interrupts
>   ARM: dts: dove: Add definitions for PCIe legacy INTx interrupts
>   ARM: dts: armada-370.dtsi: Add definitions for PCIe legacy INTx
>     interrupts
>   ARM: dts: armada-xp-98dx3236.dtsi: Add definitions for PCIe legacy
>     INTx interrupts
>   ARM: dts: armada-xp-mv78230.dtsi: Add definitions for PCIe legacy INTx
>     interrupts
>   ARM: dts: armada-xp-mv78260.dtsi: Add definitions for PCIe legacy INTx
>     interrupts
>   ARM: dts: armada-xp-mv78460.dtsi: Add definitions for PCIe legacy INTx
>     interrupts
>   ARM: dts: armada-375.dtsi: Add definitions for PCIe legacy INTx
>     interrupts
>   ARM: dts: armada-380.dtsi: Add definitions for PCIe legacy INTx
>     interrupts
>   ARM: dts: armada-39x.dtsi: Add definitions for PCIe legacy INTx
>     interrupts
> 
>  arch/arm/boot/dts/armada-370.dtsi         |  28 ++++-
>  arch/arm/boot/dts/armada-375.dtsi         |  28 ++++-
>  arch/arm/boot/dts/armada-380.dtsi         |  42 ++++++-
>  arch/arm/boot/dts/armada-39x.dtsi         |  56 +++++++--
>  arch/arm/boot/dts/armada-xp-98dx3236.dtsi |  14 ++-
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi  |  70 +++++++++--
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi  | 126 ++++++++++++++++---
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi  | 140 ++++++++++++++++++----
>  arch/arm/boot/dts/dove.dtsi               |  28 ++++-
>  arch/arm/boot/dts/kirkwood-6192.dtsi      |  14 ++-
>  arch/arm/boot/dts/kirkwood-6281.dtsi      |  14 ++-
>  arch/arm/boot/dts/kirkwood-6282.dtsi      |  28 ++++-
>  arch/arm/boot/dts/kirkwood-98dx4122.dtsi  |  14 ++-
>  13 files changed, 516 insertions(+), 86 deletions(-)
> 
> -- 
> 2.35.1
> 
