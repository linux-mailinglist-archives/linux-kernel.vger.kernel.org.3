Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED0054C9C6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352372AbiFON3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245504AbiFON2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:28:52 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01B513CC9;
        Wed, 15 Jun 2022 06:28:50 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8196E1C0BC8; Wed, 15 Jun 2022 15:28:49 +0200 (CEST)
Date:   Wed, 15 Jun 2022 15:28:41 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     David Wang <David_Wang6097@jabil.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        edward_chen@jabil.com, ben_pai@jabil.com
Subject: Re: [PATCH 1/3] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Message-ID: <20220615132841.GC1429@bug>
References: <20220531011100.882643-1-David_Wang6097@jabil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531011100.882643-1-David_Wang6097@jabil.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The initial introduction of the jabil server with AST2600 BMC SoC.


> +		led-0 {
> +			label = "identify";
> +			color = <LED_COLOR_ID_BLUE>;
> +			function = LED_FUNCTION_INDICATOR;
> +			retain-state-shutdown;
> +			gpios = <&gpio0 ASPEED_GPIO(B, 7) GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led-1 {
> +			label = "status_amber";
> +			label = "status_green";
> +			label = "status_susack";
> +		led-4 {
> +			label = "power-amber";
> +			label = "fan1-fault";

Please take a look at LED documentation and try to come up with something more in line
with existing conventions. Also please cc linux-leds list.

Best regards,
										Pavel
