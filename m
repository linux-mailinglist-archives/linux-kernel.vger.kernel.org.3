Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421AE56FDBF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 12:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiGKJ75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 05:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiGKJ6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 05:58:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0EB628F;
        Mon, 11 Jul 2022 02:27:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E25D61372;
        Mon, 11 Jul 2022 09:27:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4BCC341C0;
        Mon, 11 Jul 2022 09:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657531639;
        bh=+UJrGtjpka8nSRM77e2YQUJSg61eV0JzLk4848lxeJE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=MfE8LqQNYPDPYj35zNe/S4tOd01xxjfLIyzaJi0TUejoE4EsuDFhtQuhYbig7oEHI
         uaO9PTIEhDARQXEP264/pjRuz5Xz2r52a3fZ6Hl3USlAbj6hzIbEFaB4Nw/8yhPHNt
         qaoJCPhKHA3CZUJFqIBSDQFDYzQ2ewy7YNeU3YQRLqputkGAPL9rIeNfi6dSjCfspF
         ReG106sk7j5xfiu4zC5+jKCgGZ0AoI8XHM9ZQZ2V5DqGBjd+cZNHr0WiAXETrPSuct
         0B7pQPZrFa2u+Ix1IWCFdCLbX1uosdXsIudoa3+ogdeFI7WpJETnooOcLRQsB7T6XX
         uckVuce4+HYeg==
Message-ID: <e1d1b0d3-b6d3-db91-df9f-a06ef69d1834@kernel.org>
Date:   Mon, 11 Jul 2022 11:27:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 2/2] pwm: Add clock based PWM output driver
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, thierry.reding@gmail.com,
        lee.jones@linaro.org
Cc:     u.kleine-koenig@pengutronix.de, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20220711062330.4923-1-nikita@trvn.ru>
 <20220711062330.4923-3-nikita@trvn.ru>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220711062330.4923-3-nikita@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2022 08:23, Nikita Travkin wrote:
> Some systems have clocks exposed to external devices. If the clock
> controller supports duty-cycle configuration, such clocks can be used as
> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> similar way and an "opposite" driver already exists (clk-pwm). Add a
> driver that would enable pwm devices to be used via clk subsystem.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
> 

Also not correct patch.

Best regards,
Krzysztof
