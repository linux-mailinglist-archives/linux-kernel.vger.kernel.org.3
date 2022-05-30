Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2143953752A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiE3HGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 03:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbiE3HGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:06:11 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F828719DB;
        Mon, 30 May 2022 00:06:10 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5F0901C0B8A; Mon, 30 May 2022 09:06:09 +0200 (CEST)
Date:   Mon, 30 May 2022 09:06:08 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arm64: dts: qcom: sdm845: Enable user LEDs on DB845c
Message-ID: <20220530070608.GB1363@bug>
References: <20220505022706.1692554-1-bjorn.andersson@linaro.org>
 <20220505022706.1692554-3-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505022706.1692554-3-bjorn.andersson@linaro.org>
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

> The DB845c has 4 "user LEDs", the last one is already supported as it's
> just wired to a gpio. Now that the LPG binding is in place we can wire
> up the other 3 LEDs as well.


> +&pmi8998_lpg {
> +	status = "okay";
> +
> +	qcom,power-source = <1>;
> +
> +	led@3 {
> +		reg = <3>;
> +		color = <LED_COLOR_ID_GREEN>;
> +		function = LED_FUNCTION_HEARTBEAT;
> +		function-enumerator = <3>;
> +
> +		linux,default-trigger = "heartbeat";
> +		default-state = "on";
> +	};
> +
> +	led@4 {
> +		reg = <4>;
> +		color = <LED_COLOR_ID_GREEN>;
> +		function = LED_FUNCTION_INDICATOR;
> +		function-enumerator = <2>;
> +	};
> +
> +	led@5 {
> +		reg = <5>;
> +		color = <LED_COLOR_ID_GREEN>;
> +		function = LED_FUNCTION_INDICATOR;
> +		function-enumerator = <1>;
> +	};

Do the LEDs have some kind of markings? Marking them as "indicator" is not too useful.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
