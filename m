Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9E58924A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238170AbiHCS37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 14:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236751AbiHCS35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 14:29:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7461F5A175
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 11:29:52 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id m8so22494856edd.9
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 11:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oA6nNFqtAx3x5LsiqpTHLf6wHToLYzY4zhs6wkSQF94=;
        b=IypyMFSvUUDb3PAPYmqoU3Wkk7X2fWIhSBfvG5jIvQinuZlmeTgRHeumtg7FRDIIoL
         DhL8pY+9yVeOgAo9uQ5Fbx9B+LuX/1gh/dDUzwK2IQzmWOUq8b1nk8tn5KvZCLyZcWHh
         zZG8quFv4NfTj94XDMzUtyGBCrOvuuvGBMeexMEBnBBYUMMg3XTGsOTFXYPaNCZnVOvh
         1DDufM+r6yNCFoHJ4UGElPMfd1a8/5WBtn6njSuSoo41aF1YOPo8bCLZBWmScM+3kIBW
         VL0lQL3hCFNXTObnWCvvyFM1Gs5TW2hJ5QYpIZVVhmu0EFYcoPnbQBlmHUQhbXv2Zo0n
         1JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oA6nNFqtAx3x5LsiqpTHLf6wHToLYzY4zhs6wkSQF94=;
        b=qqeYa8SeFnHFkBIKE7Jz6bKPOkN/pXQKTBRjhi1BXkzqXJ3CbvubEY7nptt7uWNlnE
         bcz3p9pyv02TwC7rYQ5Cw8wdSFOMehRfnS3C7XgVBr+5M9KtkYhpdidEQ89s5upcOQWf
         hGW7dfLEcdYTlSeA3v2ztxjkXmRco58wfFFleDZLAmmiNl8JAaBLlPy11MWN21qAofs9
         S/iuzU3EQZ+lCIi7Vnnmsy0vjc9yYbrfgbuVJmExUa8pcGWKA1N+bW1EGZsVwS/mrPet
         cMq9zbbwQWtNohxpZe5FdK5bg6+QZrpDCIIz/53mm+q6VHWktzn9KjmLybrng7sfXNH6
         qAXw==
X-Gm-Message-State: ACgBeo1peQs9JTnEEd1tIRDoHu0L/CZeabl+gvvPWD9XcqVw9wq8yanp
        J4DYgUNWe0SuMJ5oxk+elhcB0LO8djVB8Z5GVyHu+Q==
X-Google-Smtp-Source: AA6agR4EcHyXPdpWatp4j51d3xayGtGdDP+Dg+Ts3yOBOxNea2vH1uz6+/hIXQUfrYTYAZ/AJMkjcIbnbAigRDbJbuQ=
X-Received: by 2002:a05:6402:2691:b0:43d:ba10:854b with SMTP id
 w17-20020a056402269100b0043dba10854bmr13607335edd.158.1659551391085; Wed, 03
 Aug 2022 11:29:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220727164251.385683-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220727164251.385683-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 3 Aug 2022 20:29:39 +0200
Message-ID: <CACRpkdbNr1Ja23wj99NmExG=w8_C66cT1HcmtAuwVhAbrGrEnQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: fairchild,74hc595: use spi-peripheral-props.yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 6:43 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Instead of listing directly properties typical for SPI peripherals,
> reference the spi-peripheral-props.yaml schema.  This allows using all
> properties typical for SPI-connected devices, even these which device
> bindings author did not tried yet.
>
> Remove the spi-* properties which now come via spi-peripheral-props.yaml
> schema, except for the cases when device schema adds some constraints
> like maximum frequency.
>
> While changing additionalProperties->unevaluatedProperties, put it in
> typical place, just before example DTS.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
