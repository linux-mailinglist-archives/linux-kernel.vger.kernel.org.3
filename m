Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA93246840D
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354197AbhLDKc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:32:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343896AbhLDKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:32:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4CBC061751;
        Sat,  4 Dec 2021 02:29:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 398D960BFE;
        Sat,  4 Dec 2021 10:29:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE1CC341C4;
        Sat,  4 Dec 2021 10:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638613740;
        bh=zie+iNzyGc5QjUZyAraGpX3z1Dpe6EUlKoCCVJGtokA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eR+otevqZjQGxhdJ06uJjevrnOxBlTXIiPC0FWHtQ2i4J5Ne5KO+H/5nnhLqU2d4n
         ZHoH0fmRq5yFOfbfXs4TMtfz9xdOn41IqSgGkr4gxiFJJNvR0n+H2c37Byx77A5+EO
         +fUZiIzD0eNaQkpskaTMqvYCwnPgF2ByPhf5aBEaV1WpafgdmSyIYkmOstgvnab6So
         eJTAusGF/TF/apFjeLZRkQc6SsrjlHD7p2q2Sw+e9m/R8INshzSe2PXJUDjbgA+hhX
         4ywqmxZJegvZJ8eNit3K/7+eEYRW7F4fHu+7majMbSqlIvmps1apLdtizzbVCgle2t
         +8SmDj1HlJcDA==
Date:   Sat, 4 Dec 2021 11:28:54 +0100
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm/arm64: dts: Add MV88E6393X to CN9130-CRB
 device tree
Message-ID: <20211204112854.2f4aa818@thinkpad>
In-Reply-To: <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
References: <20211018011211.3836590-1-chris.packham@alliedtelesis.co.nz>
        <20211018011211.3836590-3-chris.packham@alliedtelesis.co.nz>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

some nitpicks here,

> +
> +	sfp: sfp {
> +		compatible = "sff,sfp";
> +		i2c-bus = <&cp0_i2c1>;
> +		mod-def0-gpios = <&expander0 3 GPIO_ACTIVE_LOW>;
> +		los-gpio = <&expander0 15 GPIO_ACTIVE_HIGH>;
> +		tx-disable-gpio = <&expander0 2 GPIO_ACTIVE_HIGH>;
> +		tx-fault-gpio = <&cp0_gpio1 24 GPIO_ACTIVE_HIGH>;

maximum-power-milliwatt = <3000>; AFAIK

...

> +			port@9 {
> +				reg = <9>;
> +				label = "p9";
> +				phy-mode = "10gbase-r";
> +				sfp = <&sfp>;
> +				managed = "in-band-status";
> +			};
> +
> +			port@10 {

port@a (hexadecimal in node name)

> +				reg = <10>;
> +				label = "cpu";
> +				ethernet = <&cp0_eth0>;

Marek
