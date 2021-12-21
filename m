Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C8147C609
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhLUSNB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 21 Dec 2021 13:13:01 -0500
Received: from aposti.net ([89.234.176.197]:40256 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241027AbhLUSNA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 13:13:00 -0500
Date:   Tue, 21 Dec 2021 18:12:50 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] dt-bindings: display: Add SPI peripheral schema to SPI
 based displays
To:     Rob Herring <robh@kernel.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Belisko <marek@goldelico.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <E99H4R.USZAFSZ7ENW71@crapouillou.net>
In-Reply-To: <20211221125209.1195932-1-robh@kernel.org>
References: <20211221125209.1195932-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le mar., déc. 21 2021 at 08:52:09 -0400, Rob Herring <robh@kernel.org> 
a écrit :
> With 'unevaluatedProperties' support enabled, several SPI based 
> display
> binding examples have warnings:
> 
> Documentation/devicetree/bindings/display/panel/samsung,ld9040.example.dt.yaml: 
> lcd@0: Unevaluated properties are not allowed ('#address-cells', 
> '#size-cells', 'spi-max-frequency', 'spi-cpol', 'spi-cpha' were 
> unexpected)
> Documentation/devicetree/bindings/display/panel/kingdisplay,kd035g6-54nt.example.dt.yaml: 
> panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 
> 'spi-3wire' were unexpected)
> Documentation/devicetree/bindings/display/panel/ilitek,ili9322.example.dt.yaml: 
> display@0: Unevaluated properties are not allowed ('reg' was 
> unexpected)
> Documentation/devicetree/bindings/display/panel/samsung,s6e63m0.example.dt.yaml: 
> display@0: Unevaluated properties are not allowed 
> ('spi-max-frequency' was unexpected)
> Documentation/devicetree/bindings/display/panel/abt,y030xx067a.example.dt.yaml: 
> panel@0: Unevaluated properties are not allowed ('spi-max-frequency' 
> was unexpected)
> Documentation/devicetree/bindings/display/panel/sony,acx565akm.example.dt.yaml: 
> panel@2: Unevaluated properties are not allowed ('spi-max-frequency', 
> 'reg' were unexpected)
> Documentation/devicetree/bindings/display/panel/tpo,td.example.dt.yaml: 
> panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 
> 'spi-cpol', 'spi-cpha' were unexpected)
> Documentation/devicetree/bindings/display/panel/lgphilips,lb035q02.example.dt.yaml: 
> panel@0: Unevaluated properties are not allowed ('reg', 
> 'spi-max-frequency', 'spi-cpol', 'spi-cpha' were unexpected)
> Documentation/devicetree/bindings/display/panel/innolux,ej030na.example.dt.yaml: 
> panel@0: Unevaluated properties are not allowed ('spi-max-frequency' 
> was unexpected)
> Documentation/devicetree/bindings/display/panel/sitronix,st7789v.example.dt.yaml: 
> panel@0: Unevaluated properties are not allowed ('spi-max-frequency', 
> 'spi-cpol', 'spi-cpha' were unexpected)
> 
> Fix all of these by adding a reference to spi-peripheral-props.yaml.
> With this, the description that the binding must follow
> spi-controller.yaml is both a bit out of date and redundant, so remove
> it.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul


