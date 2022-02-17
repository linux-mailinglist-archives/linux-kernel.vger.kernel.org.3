Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE924BADE7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiBQX45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:56:57 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBQX44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:56:56 -0500
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2146F45ADA;
        Thu, 17 Feb 2022 15:56:41 -0800 (PST)
Received: by mail-il1-f177.google.com with SMTP id t9so948955ilf.13;
        Thu, 17 Feb 2022 15:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vADKNGJMZ3WvnhwsSTViLOVm49gkP1dC5MYlKD5ocGA=;
        b=ESwvWLJT5/ZJyoaPpmZPnCRrgQtpBgkX1IM9/WLI/ZmLk4WYxsC4lqsS3Xru1RlHK+
         ht0wxrq83Tvj0Uj7FZY/Ar3zQ0OYlgM0Ak70mEvmxcpXTl3B1DYEczWnmDw0vEyspM5T
         NG1qm4BUcdxe/DbC1V22jO8CQlucIQ7GXYzA9MYyON874n3oEMVk7u1WwiZePH4gY8YE
         p590CNc3Ri5YCr2urLzQY/bs+hCkGTzf2+FK+LxQkwYSk7RpnLxG7QSFqPafeGPjEZue
         FCevUJwU88IhWQn3ExLP6j77AnVr9/d+/8ue22kPeAPSbRWNuXjwC5Sq/GHJ7QAXII1s
         8ofw==
X-Gm-Message-State: AOAM532CLiT/Vc0KKuUhbsh4tYsIvAcsx5MKjvAbtWB3OYU3qFZu0FBK
        q0sVjX+ayp8lzykYCW3r+k9Nm4MZzQ==
X-Google-Smtp-Source: ABdhPJz2uhw/0396q6HkbPxCRaaVXMhQ3cEVjBUY6URBMOBH2FQe7OFi+g7J2NVfqN4QAfxCKdbozQ==
X-Received: by 2002:a05:6602:1541:b0:614:d42b:2c86 with SMTP id h1-20020a056602154100b00614d42b2c86mr3567242iow.145.1645140529859;
        Thu, 17 Feb 2022 15:28:49 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g9sm2804683ile.41.2022.02.17.15.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 15:28:49 -0800 (PST)
Received: (nullmailer pid 3971311 invoked by uid 1000);
        Thu, 17 Feb 2022 23:28:47 -0000
Date:   Thu, 17 Feb 2022 17:28:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>
Cc:     kavyasree.kotagiri@microchip.com, nicolas.ferre@microchip.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        alexandre.belloni@bootlin.com, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, herbert@gondor.apana.org.au,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        krzysztof.kozlowski@canonical.com
Subject: Re: [PACTH v4 2/3] dt-bindings: crypto: Convert Atmel TDES to yaml
Message-ID: <Yg7aL+0RjEi+bdMl@robh.at.kernel.org>
References: <20220211093922.456634-1-tudor.ambarus@microchip.com>
 <20220211093922.456634-3-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211093922.456634-3-tudor.ambarus@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Feb 2022 11:39:21 +0200, Tudor Ambarus wrote:
> Convert Atmel TDES documentation to yaml format. With the conversion the
> clock and clock-names properties are made mandatory. The driver returns
> -EINVAL if "tdes_clk" is not found, reflect that in the bindings and make
> the clock and clock-names properties mandatory. Update the example to
> better describe how one should define the dt node.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../crypto/atmel,at91sam9g46-tdes.yaml        | 64 +++++++++++++++++++
>  .../bindings/crypto/atmel-crypto.txt          | 23 -------
>  2 files changed, 64 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/atmel,at91sam9g46-tdes.yaml
> 

Applied, thanks!
