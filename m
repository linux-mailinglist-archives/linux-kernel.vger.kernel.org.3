Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEBA515E04
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381740AbiD3OJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242280AbiD3OJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:09:26 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEE76620E;
        Sat, 30 Apr 2022 07:06:04 -0700 (PDT)
Received: from wf0416.dip.tu-dresden.de ([141.76.181.160] helo=phil.dip.tu-dresden.de)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nknjS-0001Wl-MA; Sat, 30 Apr 2022 16:05:58 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, Caleb Connolly <kc@postmarketos.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        ~postmarketos/upstreaming@lists.sr.ht, martijn@brixit.nl
Subject: Re: (subset) [PATCH 0/4] rockchip: support configuring pins as input
Date:   Sat, 30 Apr 2022 16:05:52 +0200
Message-Id: <165132754299.647302.2972320978462383968.b4-ty@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220328005005.72492-1-kc@postmarketos.org>
References: <20220328005005.72492-1-kc@postmarketos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Mar 2022 01:50:01 +0100, Caleb Connolly wrote:
> Add support for configuring pins as input to the rockchip pinctrl
> driver. This is required for example for devices which use non-standard
> configurations for gpio interrupts, specifically for the light/proximity
> sensor on the RK3399 powered PinePhone Pro (which will be coming
> upstream in a future patch series).
> 
> Due to the complicated layout of the RK pinctrl/gpio drivers, some extra
> work is required to handle deferring the GPIO configuration. On RK3399
> the pinctrl driver always probes before the GPIO controller driver, so
> the PIN_CONFIG_OUTPUT and PIN_CONFIG_INPUT_ENABLE params both have to be
> deferred, this series also reworks the deferred pin handling to be
> generic and support any param rather than only the PIN_CONFIG_OUTPUT
> param.

Applied, thanks!

[4/4] arm64: dts: rockchip: rk3399: add an input enable pinconf
      commit: ec48c3e82ca36a66ae37ba8b1fdb9a7561dcab14

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
