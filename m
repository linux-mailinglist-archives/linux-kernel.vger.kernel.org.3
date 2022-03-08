Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56D244D1BF7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 16:42:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347897AbiCHPnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 10:43:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347914AbiCHPm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 10:42:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECBA4ECE6;
        Tue,  8 Mar 2022 07:41:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71B7761634;
        Tue,  8 Mar 2022 15:41:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7874C36AE5;
        Tue,  8 Mar 2022 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646754118;
        bh=IJYNSkeZzZvARIFNzClc6iv4vyFy9TuVd96STVQrAc4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bm+x/GjOx85LIu2RsmI8eD6BacmUmy2IeZ/v4U7lkimNfFW1DflOi89b9c6z5Av15
         frYoVE5CG2O1LwtOafmjpk4gOdDYLA80+xHGf+DGksMbUeUk2ykcQD6DwlnPXAY9Iq
         a73Zquer2mg6mXIMKFAmmAikKLBkkIWoQEfF57gJGVPr6UV4iekgWxaouKHoeyqgWu
         NvBegG6ioNb9UfX3kTvW+e1LP47YFmwSJJ7Ri5BGwVQR04pTp3SzjRWzsWNhI64M4l
         Pp5+UnKCgx51wN2geLqPePnrgs24Iy6FVtdPfmZqX27ehtWCwdi2ga/4pB3zoNzjt5
         KCc/wIPuGVOqQ==
Received: by mail-ej1-f45.google.com with SMTP id d10so40100018eje.10;
        Tue, 08 Mar 2022 07:41:58 -0800 (PST)
X-Gm-Message-State: AOAM533hWbhkqgppb/PgflHvYOfckBKJcZoY4ZG2D0q0Bl5bdX1FTgAF
        omjBUxz42+uC6Kh3jQ16fILmSLxbHmRRm6CsfQ==
X-Google-Smtp-Source: ABdhPJxIb3+WG03kGop4Io4gfFAc4/Ov9H50ShSKZhOdDQ2GQ1CJZOL38O1ivv3AfFwgX8OYYXMPlSWSqiGkJm8v1OI=
X-Received: by 2002:a17:907:298f:b0:6da:b3da:19e with SMTP id
 eu15-20020a170907298f00b006dab3da019emr13793817ejc.423.1646754117106; Tue, 08
 Mar 2022 07:41:57 -0800 (PST)
MIME-Version: 1.0
References: <20220307085053.1636475-1-vincent.whitchurch@axis.com> <20220307085053.1636475-2-vincent.whitchurch@axis.com>
In-Reply-To: <20220307085053.1636475-2-vincent.whitchurch@axis.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 8 Mar 2022 09:41:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKBDOu+63YrDCX51-zoTPu1utiPxXYmihL9kMvrpD3ctA@mail.gmail.com>
Message-ID: <CAL_JsqKBDOu+63YrDCX51-zoTPu1utiPxXYmihL9kMvrpD3ctA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: samsung: Add ARTPEC-8 UART
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        kernel <kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 2:51 AM Vincent Whitchurch
<vincent.whitchurch@axis.com> wrote:
>
> Add a compatible for the UART on the ARTPEC-8 SoC.

Yes, the diff says that already. Perhaps some explanation why you are
adding another vendor SoC to Samsung UART and how the h/w is
different. I can only guess based on having just gone thru this with
Apple.

>
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  Documentation/devicetree/bindings/serial/samsung_uart.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.yaml b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> index 6aceba4a5f79..6f11f2c92f64 100644
> --- a/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> +++ b/Documentation/devicetree/bindings/serial/samsung_uart.yaml
> @@ -20,6 +20,7 @@ properties:
>      items:
>        - enum:
>            - apple,s5l-uart
> +          - axis,artpec8-uart
>            - samsung,s3c2410-uart
>            - samsung,s3c2412-uart
>            - samsung,s3c2440-uart
> --
> 2.34.1
>
