Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4083D5B2BBC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 03:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiIIBgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 21:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIIBgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 21:36:52 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 277A91079FA;
        Thu,  8 Sep 2022 18:36:47 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1278a61bd57so332183fac.7;
        Thu, 08 Sep 2022 18:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=X/EZDtBCJrUGRIamC4teU2YJMrak7hI+I7Ky8llWW9E=;
        b=EPeHvNpiflSA2NJUm1qXeASxNHRjKLaBqu1qlpW0B2OIjvvB4d0jyrvVs1l38V2lNs
         b6CqvWK3fjPV3oRM11WgtP4/f7ia5msjZaa7V9jwuwT8XpUI2OYY+Hec3lb0/pf43GLk
         65OeBmSW9edvj0oT81geJZShLDJLgo9WigXrT06rnAAZw/rNyfZ0jq5IIfpdO9aHSh+y
         Ldd4xFTp5bQ6X52qrbhw2m1h8YlzRRfFbGstbP8uFDSnP23DRTUhEGBUPGcjV8ERIsco
         Lh8Vej/fxQgTpkom/YJESp6ab8GDqoSihDBnrQuqudUdb5WXq8FsScVkEH9Z4jIILpHG
         szrg==
X-Gm-Message-State: ACgBeo06TMAaJYuy1+DrgopZE7YUvRB8h7orDvLCph9EA+9nhmC1W59l
        ry8gDgV61z/phO92ASPHeg==
X-Google-Smtp-Source: AA6agR747AZv98h49vbs6uS03Dihe0xwNcWZz/GVQQY2NnEyKrNRx72F0ULZHX8xIhmFf3LxBp3kkw==
X-Received: by 2002:a05:6870:b68f:b0:10b:ba83:92d4 with SMTP id cy15-20020a056870b68f00b0010bba8392d4mr3446141oab.130.1662687406373;
        Thu, 08 Sep 2022 18:36:46 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t8-20020a0568301e2800b00636e6dea5e5sm359254otr.23.2022.09.08.18.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 18:36:45 -0700 (PDT)
Received: (nullmailer pid 3734979 invoked by uid 1000);
        Fri, 09 Sep 2022 01:36:44 -0000
Date:   Thu, 8 Sep 2022 20:36:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sergiu.Moga@microchip.com
Cc:     krzysztof.kozlowski@linaro.org, lee@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Nicolas.Ferre@microchip.com,
        alexandre.belloni@bootlin.com, Claudiu.Beznea@microchip.com,
        richard.genoud@gmail.com, radu_nicolae.pirea@upb.ro,
        gregkh@linuxfoundation.org, broonie@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, jirislaby@kernel.org,
        admin@hifiphile.com, Kavyasree.Kotagiri@microchip.com,
        Tudor.Ambarus@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 06/13] dt-bindings: serial: atmel,at91-usart: Add
 SAM9260 compatibles to SAM9x60
Message-ID: <20220909013644.GA3731620-robh@kernel.org>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-7-sergiu.moga@microchip.com>
 <9aa29d74-b1fc-d00e-dee4-57f277a366ab@linaro.org>
 <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c30cc112-0fb8-01e6-1bb8-eed7db0b9049@microchip.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 03:15:44PM +0000, Sergiu.Moga@microchip.com wrote:
> On 08.09.2022 15:30, Krzysztof Kozlowski wrote:
> > On 06/09/2022 15:55, Sergiu Moga wrote:
> >> Add the AT91SAM9260 serial compatibles to the list of SAM9X60 compatibles
> >> in order to highlight the incremental characteristics of the SAM9X60
> >> serial IP.
> >>
> >> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> >> ---
> >>
> >>
> >> v1 -> v2:
> >> - Nothing, this patch was not here before
> >>
> >>
> >>   Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml | 2 ++
> >>   1 file changed, 2 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >> index b25535b7a4d2..4d80006963c7 100644
> >> --- a/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >> +++ b/Documentation/devicetree/bindings/serial/atmel,at91-usart.yaml
> >> @@ -26,6 +26,8 @@ properties:
> >>         - items:
> >>             - const: microchip,sam9x60-dbgu
> >>             - const: microchip,sam9x60-usart
> >> +          - const: atmel,at91sam9260-dbgu
> >> +          - const: atmel,at91sam9260-usart
> > 
> > This is weird. You say in commit msg to "highlight the incremental
> > characteristics" but you basically change here existing compatibles.
> 
> 
> Does "show that they are incremental IP's" sound better then?
> 
> 
> > This is not enum, but a list.
> > 
> 
> 
> What do you mean by this? I know it is a list, I specified so in the 
> commit message.

You are saying that compatible must be exactly the 4 strings above in 
the order listed. You need another entry with another 'items' list.

Rob
