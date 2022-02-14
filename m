Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B474B5DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 23:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231964AbiBNWm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 17:42:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiBNWmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 17:42:55 -0500
Received: from hs01.dk-develop.de (hs01.dk-develop.de [IPv6:2a02:c207:3002:6234::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC215DB21;
        Mon, 14 Feb 2022 14:42:46 -0800 (PST)
Date:   Mon, 14 Feb 2022 23:42:38 +0100
From:   Danilo Krummrich <danilokrummrich@dk-develop.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, linus.walleij@linaro.org
Subject: Re: [PATCH 2/2] input: ps2-gpio: enforce and document open drain
Message-ID: <Ygra3pOhcE18nXRj@pollux>
References: <20220211233137.99624-1-danilokrummrich@dk-develop.de>
 <20220211233137.99624-3-danilokrummrich@dk-develop.de>
 <ce5ccbbc-0419-ae3d-5ab1-f8985cb7e792@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce5ccbbc-0419-ae3d-5ab1-f8985cb7e792@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 10:50:21PM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2022 00:31, Danilo Krummrich wrote:
> > The PS/2 bus defines the data and clock line be open drain, therefore
> > document this in the dt-binding and enforce the particular flag in the
> > driver.
> > 
> > Without enforcing to flag at least the clock gpio as open drain we run
> > into the following warning:
> > 
> > WARNING: CPU: 1 PID: 40 at drivers/gpio/gpiolib.c:3175 gpiochip_enable_irq+0x54/0x90
> > 
> > gpiochip_enable_irq() warns on a GPIO being configured as output and
> > using IRQ without being flagged as open drain.
> > 
> > Signed-off-by: Danilo Krummrich <danilokrummrich@dk-develop.de>
> > ---
> >  .../devicetree/bindings/serio/ps2-gpio.yaml        | 14 ++++++++++----
> >  drivers/input/serio/ps2-gpio.c                     |  9 +++++++--
> >  2 files changed, 17 insertions(+), 6 deletions(-)
> > 
> 
> Bindings as separate patch, please.
Are you fine with adding this additional documentation directly to the patch
converting the binding to a json-schema or do you prefer it to be a separate
patch?
> 
> Best regards,
> Krzysztof

- Danilo
