Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCDB5AC4CD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiIDOcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 10:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIDOcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 10:32:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181BC2C665;
        Sun,  4 Sep 2022 07:32:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F87960F9E;
        Sun,  4 Sep 2022 14:32:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B3FC433C1;
        Sun,  4 Sep 2022 14:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662301932;
        bh=zecYjNOJMFzf6chPFOavcPltZeHhWAcT7iKzflDi3as=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cqmotRHwjE3NiFW7FVxhsJKKA+HvpQGzORN6ZGMS1yawFNBx/LyVKRRhO91HzSlay
         Y7B5jJ/h4J2La2SZ3l6iwqJL5o21Q4sgKoTWmxdqU4Aw8MBePxFsxXyDmh8ABijQJ8
         cOaNvsf4Za6oPzy4zL8xa6VbFdoiIoHbw2SRGnA+s94mwlPzn/0ZASFL+Tca1YZrGz
         +sI8zQCOYKAIB1lQA6Rei9SlVphegZNJIYnL/5zuR3+18zvS+RmjB7v3Zhe84fhhgL
         WiyTT6siagTthsMR7TaoqIfrHnxMaM5qay25KO4tXjNiOqNwa6SZmR7fysvImf920X
         gqbvVyaF6YXOQ==
Date:   Sun, 4 Sep 2022 14:58:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: iio: adc: ti,tsc2046: add
 vref-supply property
Message-ID: <20220904145803.0a4f208f@jic23-huawei>
In-Reply-To: <20220904100203.3614502-1-o.rempel@pengutronix.de>
References: <20220904100203.3614502-1-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  4 Sep 2022 12:02:01 +0200
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> Add property for the voltage reference supply.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Series applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if they can find anything we missed.

I'm not generally keen on seeing quite so many versions in such a short period of
time. Not too bad in this particular case as the patches were small, but it doesn't
provide time for others to respond and can lead to reviewer fatigue!

Anyhow, it worked out this time so not a big problem.

Thanks,

Jonathan

> ---
>  Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> index 601d69971d84a..7faf12b1598b9 100644
> --- a/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/ti,tsc2046.yaml
> @@ -25,6 +25,9 @@ properties:
>  
>    spi-max-frequency: true
>  
> +  vref-supply:
> +    description: Optional supply of the reference voltage
> +
>    "#io-channel-cells":
>      const: 1
>  

