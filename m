Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D520E5AC51C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiIDPro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 11:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDPrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 11:47:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16C13719C;
        Sun,  4 Sep 2022 08:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E3B960FB2;
        Sun,  4 Sep 2022 15:47:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB50BC433C1;
        Sun,  4 Sep 2022 15:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662306460;
        bh=QxAvxhmC6ir/QFdZzQ1oKmEPPSLatuOJhN2AJgQ0x4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S6rJRymE9G9c6QLkozoVaXnGITy9BEaXDPZJ+/EdMUwxbB5No9Kbpj9gr+2aal/aA
         ZIRjUsUTZu45pFqNR6NjCGkqFls0qe3MswaKRv4KOXGSAiaNDP2TdVCnNM3TPPf+CH
         RbzmEZelRzn7ZGn4hQi4HOZpxrpUo5irk8Am4Vm8QcS6aSwwx07hOSxRSfw0gB7vc7
         72lhW5ZcuknbgeRzZru4crQauUK6fnGTL4++/2CaCufH6vcd3bJbwaQHcA97x5JM82
         svjjXFd36EoWqwoHEMG2xRkznpkoa5l7kgqutxdcJgMzL9HNxNnrCL9B9om/WDKTr2
         8ropNsPHnPhNQ==
Date:   Sun, 4 Sep 2022 16:13:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     George Mois <george.mois@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lucas.p.stankus@gmail.com>
Subject: Re: [PATCH v3 1/2] bindings: iio: accel: extend adxl313
 documentation file
Message-ID: <20220904161332.587e3a6f@jic23-huawei>
In-Reply-To: <20220831143538.65816-1-george.mois@analog.com>
References: <20220831143538.65816-1-george.mois@analog.com>
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

On Wed, 31 Aug 2022 17:35:37 +0300
George Mois <george.mois@analog.com> wrote:

> Extend the adi,adxl313.yaml file with information regrding the
> ADXL312 and ADXL314 devices.
> 
> Signed-off-by: George Mois <george.mois@analog.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content is fine, but dt-bindings patches have a particular patch
title format. Something like:

dt-bindings: iio: accel: adxl313: Add compatibles for adxl312 and adxl314

> ---
> no changes in v3.
>  .../devicetree/bindings/iio/accel/adi,adxl313.yaml     | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> index d6afc1b8c272..59d48ff1a16c 100644
> --- a/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl313.yaml
> @@ -4,20 +4,24 @@
>  $id: http://devicetree.org/schemas/iio/accel/adi,adxl313.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Analog Devices ADXL313 3-Axis Digital Accelerometer
> +title: Analog Devices ADXL312, ADXL313, and ADXL314 3-Axis Digital Accelerometers
>  
>  maintainers:
>    - Lucas Stankus <lucas.p.stankus@gmail.com>
>  
>  description: |
> -  Analog Devices ADXL313 3-Axis Digital Accelerometer that supports
> -  both I2C & SPI interfaces.
> +  Analog Devices ADXL312, ADXL313, and ADXL314 3-Axis Digital Accelerometer that
> +  support both I2C & SPI interfaces.
> +    https://www.analog.com/en/products/adxl312.html
>      https://www.analog.com/en/products/adxl313.html
> +    https://www.analog.com/en/products/adxl314.html
>  
>  properties:
>    compatible:
>      enum:
> +      - adi,adxl312
>        - adi,adxl313
> +      - adi,adxl314
>  
>    reg:
>      maxItems: 1

