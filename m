Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862D650ED82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 02:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240041AbiDZAW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 20:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiDZAW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 20:22:26 -0400
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A5A124D87;
        Mon, 25 Apr 2022 17:19:18 -0700 (PDT)
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-e93bbb54f9so5133077fac.12;
        Mon, 25 Apr 2022 17:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5qSfY3Lg9ZldVtbZbBmTt420KpgY28iF9xeamtFe6D4=;
        b=KGNzuzXKACse77jNU1S+5XiB48Zong/O/ke5o3oy2DnkhLl2Ey+ZntcFi9EW2+XTj3
         xr0wjqYwGU6rh6mzgVw+FX1ZbQvqwaqSYmTR05G+hpL0rketeUIPhQG1LycRwBjRBOyQ
         bCSKn8z9A8+SplA6Wav3Esj2XHmBlk9p5piqm7h/2SND6CoR0K73//0G3hvy7kQ100vF
         skkZsg+0Oohxxzx2V1TxRiloIsVZE6IkKqJ1KVnwVWikVQfbWKPrG85OEHg87Pb2XfVN
         O3NkE4irkAop8kdKt3iJnvlA+N0N80QTw89EnvbHjtrMPX+qQTkfq99hvFiozM7BeX9W
         LJhQ==
X-Gm-Message-State: AOAM532bJcSGb5b2UXNrTRTSgibgPlTExqa9V8iFzFa6FvT3ExCxXwmu
        7ryrPMhVBaBXxesAM7XsEg==
X-Google-Smtp-Source: ABdhPJweApfZtyPtWsPxNCUtls8rEOJ+zuFQRt41W/mpBVsBtio9nxJ8NUEwHd9tElqIGdDtnw7Iqw==
X-Received: by 2002:a05:6870:b3a2:b0:e9:f22:5819 with SMTP id w34-20020a056870b3a200b000e90f225819mr6294788oap.293.1650932358167;
        Mon, 25 Apr 2022 17:19:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p17-20020a4a3651000000b0035d9b838f21sm4970654ooe.10.2022.04.25.17.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 17:19:17 -0700 (PDT)
Received: (nullmailer pid 597729 invoked by uid 1000);
        Tue, 26 Apr 2022 00:19:16 -0000
Date:   Mon, 25 Apr 2022 19:19:16 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang3@nuvoton.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ychuang570808@gmail.com, sboyd@kernel.org, krzk+dt@kernel.org,
        arnd@arndb.de, olof@lixom.net, will@kernel.org, soc@kernel.org,
        cfli0@nuvoton.com
Subject: Re: [PATCH v3 5/5] dt-bindings: arm: Add initial bindings for
 Nuvoton Platform
Message-ID: <Ymc6hK0Z/t3IKF3z@robh.at.kernel.org>
References: <20220418082738.11301-1-ychuang3@nuvoton.com>
 <20220418082738.11301-6-ychuang3@nuvoton.com>
 <fd9316a6-7df6-e1fa-50dc-ff50934afb5c@linaro.org>
 <caf4867f-7f71-9262-f190-463325eb13ab@nuvoton.com>
 <4e9eaede-2208-bd73-35ae-89e128562653@linaro.org>
 <80994f4b-136f-7669-4674-0c9826e88248@nuvoton.com>
 <43cb61ac-461f-e6ff-b495-44f8befde79f@linaro.org>
 <257d878e-8455-2770-7868-c9445b0eabba@nuvoton.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <257d878e-8455-2770-7868-c9445b0eabba@nuvoton.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 04:13:20PM +0800, Jacky Huang wrote:
> 
> 
> On 2022/4/21 下午 04:05, Krzysztof Kozlowski wrote:
> > On 21/04/2022 10:04, Jacky Huang wrote:
> > > 
> > > On 2022/4/21 下午 02:56, Krzysztof Kozlowski wrote:
> > > > On 21/04/2022 08:39, Jacky Huang wrote:
> > > > > On 2022/4/18 下午 08:11, Krzysztof Kozlowski wrote:
> > > > > > On 18/04/2022 10:27, Jacky Huang wrote:
> > > > > > > +properties:
> > > > > > > +  $nodename:
> > > > > > > +    const: '/'
> > > > > > > +  compatible:
> > > > > > > +    items:
> > > > > > > +      - enum:
> > > > > > > +          - nuvoton,ma35d1
> > > > > > > +          - nuvoton,ma35d1-evb
> > > > > > > +          - nuvoton,ma35d1-iot
> > > > > > > +          - nuvoton,ma35d1-som512
> > > > > > > +          - nuvoton,ma35d1-som1g
> > > > > > This does not match your DTS and does not look reasonable (SoC
> > > > > > compatible should not be part of this enum). Check some other board
> > > > > > bindings for examples.
> > > > > > 
> > > > > > 
> > > > > > Best regards,
> > > > > > Krzysztof
> > > > > I would like to modify it as follows:
> > > > > 
> > > > > description: |
> > > > >      Boards with an ARMv8 based Nuvoton SoC shall have the following
> > > > >      properties.
> > > > > 
> > > > > properties:
> > > > >      $nodename:
> > > > >        const: '/'
> > > > >      compatible:
> > > > >        oneOf:
> > > > > 
> > > > >          - description: MA35D1 evaluation board
> > > > >            items:
> > > > >              - const: nuvoton,ma35d1-evb
> > > > >              - const: nuvoton,ma35d1
> > > > > 
> > > > >          - description: MA35D1 IoT board
> > > > >            items:
> > > > >              - const: nuvoton,ma35d1-iot
> > > > Instead just enum with all board compatibles.
> > > How about to modify it as the follows:
> > > 
> > >     compatible:
> > >       oneOf:
> > > 
> > >         - description: MA35D1 evaluation board
> > >           items:
> > >             - enum:
> > >                 - nuvoton,ma35d1-evb
> > >             - const: nuvoton,ma35d1
> > > 
> > >         - description: MA35D1 IoT board
> > >           items:
> > >             - enum:
> > >                 - nuvoton,ma35d1-iot
> > >             - const: nuvoton,ma35d1
> > > 
> > >         - description: MA35D1 SOM board
> > >           items:
> > >             - enum:
> > >                 - nuvoton,ma35d1-som512
> > >                 - nuvoton,ma35d1-som1g
> > >             - const: nuvoton,ma35d1
> > > 
> > It's still almost the same. All boards together. You can add a comment
> > next to the compatible if you want some user-friendly name.
> > 
> > 
> > Best regards,
> > Krzysztof
> 
> OK, I got it. Like this,
> 
>   compatible:
>     oneOf:
> 
>       - description: MA35D1 based boards
>         items:
>           - enum:
>               - nuvoton,ma35d1-evb
>               - nuvoton,ma35d1-iot

>               - nuvoton,ma35d1-som512
>               - nuvoton,ma35d1-som1g

The memory node distinguishes how much memory. Is the board different 
for the SoM? If not, combine these to 1.

>           - const: nuvoton,ma35d1
> 
> Sincerely,
> Jacky Huang
> 
> 
> 
