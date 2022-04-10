Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822484FAE45
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 16:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239395AbiDJOgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 10:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiDJOgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 10:36:17 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9101AD5C
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 07:34:04 -0700 (PDT)
Received: from [IPv6:2a02:a03f:eaf9:8401:af3b:b3fa:fe8b:2fa0] (unknown [IPv6:2a02:a03f:eaf9:8401:af3b:b3fa:fe8b:2fa0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 1EB232C4D0A;
        Sun, 10 Apr 2022 16:34:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1649601242;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Pce3l0zcwsTkdWqwpwwdngjdSNwyjOaDkb7uabbF/s0=;
        b=loe5+DVUFerHboZhovizrI0Xn9cvNo9rVpI+xwDSUEloPV3K1wHiuTbmyO9LXAenBGw5Dr
        Non/1rNtjM+1xGYjGZgu7g8jRWZP+PjO+lHop0ZacBP7muIWWowgZCnok5dL6r2RzwxlJB
        iC9OIymp6Jy1aZ3HQnltFoYU6CVrJXiQjOzL94AG3kgBE/yDTq5rSoIWPNCv1NeaggHj2d
        VVWX9DBY4tPJy0ITmPvf4JxVIJBPHjB8ts7IGTtF3U43dy4uD/KvarQxQeLF2B6XaRFpLB
        XnDIZM0nC8qbs9bjJkpdog1kgQhHRiKJiKpgAFVX18tOvNKY2+hspjpAJGESdA==
Message-ID: <59e410997a35a511e34febfe923b1345a95afe00.camel@svanheule.net>
Subject: Re: [PATCH v1 1/6] dt-bindings: gpio: realtek-otto: Add rtl9300
 compatible
From:   Sander Vanheule <sander@svanheule.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Date:   Sun, 10 Apr 2022 16:34:01 +0200
In-Reply-To: <edfc1f7c-3083-7f0d-dc18-e9ab36c2dc9a@linaro.org>
References: <cover.1649533972.git.sander@svanheule.net>
         <7dfad6c63cea64ccd84907f1cf9f7c9c6d1ce3e9.1649533972.git.sander@svanheule.net>
         <edfc1f7c-3083-7f0d-dc18-e9ab36c2dc9a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof, 

On Sun, 2022-04-10 at 16:16 +0200, Krzysztof Kozlowski wrote:
> On 09/04/2022 21:55, Sander Vanheule wrote:
> > Add the "realtek,rlt9300-gpio", "realtek,otto-gpio" compatible for GPIO
> > nodes on the RTL930x SoC series. This SoC requires an extra register
> > range, defining the interrupt CPU mapping registers.
> > 
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> >  .../bindings/gpio/realtek,otto-gpio.yaml      | 33 +++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
> > b/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
> > index 100f20cebd76..3c511e9af377 100644
> > --- a/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
> > +++ b/Documentation/devicetree/bindings/gpio/realtek,otto-gpio.yaml
> > @@ -28,10 +28,10 @@ properties:
> >        - enum:
> >            - realtek,rtl8380-gpio
> >            - realtek,rtl8390-gpio
> > +          - realtek,rtl9300-gpio
> >        - const: realtek,otto-gpio
> >  
> > -  reg:
> > -    maxItems: 1
> > +  reg: true
> >  
> >    "#gpio-cells":
> >      const: 2
> > @@ -50,6 +50,23 @@ properties:
> >    interrupts:
> >      maxItems: 1
> >  
> > +if:
> 
> You could put it under allOf:, so if you ever need to extend it, you
> don't mess with the indentation, but it's fine as it is.
> 
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks for the review. I'll probably need to send a v2 of the series, so I'll update the
indentation too. The commit messages have a typo ('rlt9300' and 'rlt9310') that needs to
be fixed anyway.

Best,
Sander

