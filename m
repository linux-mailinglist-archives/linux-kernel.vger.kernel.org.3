Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A0259EDA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 22:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbiHWUoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 16:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbiHWUnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 16:43:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000EFBE1A;
        Tue, 23 Aug 2022 13:37:11 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id bq23so12211077lfb.7;
        Tue, 23 Aug 2022 13:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=vQcH+/y/P9B/2raRe9zmku2I7NczMFWSxzuMB3mZnb4=;
        b=T/mirrj8pjK6zMDCBKV8LRH/dVG3aygy1DACRYAJzIFcxOKX3eKTW6CGZMb/zsbzcb
         qbTzq5QYOZ1XrmRsQ8F4Kam7tleixaMDSwFu5UrIHgWf1ZLIW48Mw3XDHKU1ThUS4TBG
         RxkRUASZhAR//q0YwhMy1OmUMrVqHaAnvYMfFdhx8xFD0DvZt4sKGQmDT5M/8XTlX8Yy
         +ZU/Zi3vA9dJvKocUfL/Wby5GcWGpgCLZvDQ22xa/Em2obQs39g+zazsmYmqMk7UQ/26
         L1u8fCUcbUx52d+aNK1k/Pe72Exw69Y7+sqOulpaRp895lFQfLQ5rEJJmqVISHk87FBb
         hSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=vQcH+/y/P9B/2raRe9zmku2I7NczMFWSxzuMB3mZnb4=;
        b=58DB/kFMX+kh/B/7gCikqI0k1zqcjGNOK6TWX7Imkvno8qOj/iiMyqdnQ+YRNQmnMH
         wBL8j+f7WmL3sGlv3MLD6dZmiECX7EtUv9XAigrEPtDrgjqpc0b0Tf65q35trmljFk68
         jmkpVMIRQMsaLgfR80TrAKi7txDPrUZxg3OP9HdWTCMHxepvHftPkQZR4A499F1iRqKJ
         p4Hh1IaP9WL99v/UP9ZeUiXMNjEvvJIodVbH+sgPeQ/EQdPmU3t0+Ts9yzGvn6UbjpUT
         l5JdZyZgYnffu5leRiRN4b0nNUepHeZ3LX3grM392BfkrlWn1bR03XPrKogXx5GlUAM+
         Pd6Q==
X-Gm-Message-State: ACgBeo25sPeWRhSRpN6DdWY1Ck1zWDaJ6gBQAuxihiHXcaCVzamxwgpq
        k27wjxkfxIQu6io4rpOwHSWs8rTvbkVWBw==
X-Google-Smtp-Source: AA6agR40SLee4SjM1i2uq9+pfjMNU9jwlzbyfW16sjS4b3hxN9Ef4RUrzOg25a5D5kdASCLRpFgCVQ==
X-Received: by 2002:a05:6512:b01:b0:48b:a065:2a8b with SMTP id w1-20020a0565120b0100b0048ba0652a8bmr8664045lfu.401.1661287030347;
        Tue, 23 Aug 2022 13:37:10 -0700 (PDT)
Received: from mobilestation (ip1.ibrae.ac.ru. [91.238.191.1])
        by smtp.gmail.com with ESMTPSA id j17-20020ac253b1000000b00491203d6cc9sm257441lfh.131.2022.08.23.13.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 13:37:09 -0700 (PDT)
Date:   Tue, 23 Aug 2022 23:37:07 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: dt-bindings: snps,dw-apb-ssi: drop ref from
 reg-io-width
Message-ID: <20220823203707.jd4orvadad2yri3q@mobilestation>
References: <20220823100937.386880-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823100937.386880-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 01:09:37PM +0300, Krzysztof Kozlowski wrote:
> reg-io-width is a standard property, so no need for defining its type
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

The patch has already been merged in, anyway thanks for the fix.
Acked-by: Serge Semin <fancer.lancer@gmail.com>

-Sergey

> ---
>  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> index 37c3c272407d..d33b72fabc5d 100644
> --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
> @@ -104,7 +104,6 @@ properties:
>      const: spi
>  
>    reg-io-width:
> -    $ref: /schemas/types.yaml#/definitions/uint32
>      description: I/O register width (in bytes) implemented by this device
>      default: 4
>      enum: [ 2, 4 ]
> -- 
> 2.34.1
> 
