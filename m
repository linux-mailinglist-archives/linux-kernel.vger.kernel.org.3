Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2C3573AF9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 18:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiGMQPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236207AbiGMQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 12:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B94650046;
        Wed, 13 Jul 2022 09:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3CB61B13;
        Wed, 13 Jul 2022 16:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F714C341C0;
        Wed, 13 Jul 2022 16:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657728896;
        bh=gQk38Tovd/97VewdZYhK8DXuDAR70xdR3qj+gN5TMgI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QcH0BYnPExpm1LS39IcYTOWfPoGQDLY/XvzXyaDrIE/SzvAh5dCB5YlBvT4H1mX8q
         ScvN6XEYtq6z7Q3Y7ZXnaB7gxKNUelkWZ3/Dm+++oSxTdU3nyhNNDpH2Odp58Rw0u2
         6HXeKb0i0j2jjS6FpSxBE8L4MWFAyYnnjy7nySUVg0C597PL4/6u+qH5dCm+iRSsuV
         JXcLqIW2OCxNmF8XlvfR7x9ingo/AgR6OOAdCiaabfExl7LHvy9QYm+h3NFeifto1b
         Dr/RmoTBG+vCMbYFn0ANtk84KvtwxaZcBT9sLsWtxlBA5EcTWJ/8kF46DaNdAY5rOM
         kXoicS1/TPpDw==
Date:   Wed, 13 Jul 2022 17:24:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dt-bindings: iio: adc: stmpe: Remove node name
 requirement
Message-ID: <20220713172443.00ab80b2@jic23-huawei>
In-Reply-To: <20220712163345.445811-5-francesco.dolcini@toradex.com>
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
        <20220712163345.445811-5-francesco.dolcini@toradex.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 18:33:44 +0200
Francesco Dolcini <francesco.dolcini@toradex.com> wrote:

> STMPE driver does not require a specific node name anymore, only the
> compatible is checked, update binding according to this.
> 
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
I'm assuming this will go through mfd (or at least some tree that isn't
IIO :)  Shout if I should pick this up in the IIO tree.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> index 9049c699152f..333744a2159c 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stmpe-adc.yaml
> @@ -13,8 +13,7 @@ description:
>    This ADC forms part of an ST microelectronics STMPE multifunction device .
>    The ADC is shared with the STMPE touchscreen. As a result some ADC related
>    settings are specified in the parent node.
> -  The node name myst be stmpe_adc and should be a child node of the stmpe node
> -  to which it belongs.
> +  The node should be a child node of the stmpe node to which it belongs.
>  
>  properties:
>    compatible:

