Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B69D4FF7B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 15:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbiDMNhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 09:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbiDMNhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 09:37:07 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A15D40A31;
        Wed, 13 Apr 2022 06:34:46 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id n19-20020a9d7113000000b005cd9cff76c3so1190312otj.1;
        Wed, 13 Apr 2022 06:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=3y1tBH0uZHiWcDFM/FP1qr/+fsEsYbd599zXEVsCG6c=;
        b=AjaFty2yypILRWw4RiKgUHPUHSeds+4qRjdywvndYd4KuHTlQtuiOgY8ico7tUIvUu
         WQ5GhGh9VuX9Qtuhz9ytPL8VItSL/V2+j90xP6xhXlVW4ENW9iYqCUM2ytjKrjo+HP+D
         0/lUBXRBVs/bNByE0GK8pGpnutWbRS98cnSoH+Mk4rBCdrSN4YBu5imrK2O7GlJPA1Jl
         J7iORViT4Y6E9lDpBQm5bsS37JIPHoLQMg4eBaU1/ZaPyMc2Ji8EjXE8TmVOhYRvvD3Z
         uobat7z/jx6TWMCeoT2Z1m27kP6sd/d51xCCCkcZsXoV/o4cdFLqvSR5zMo7kM6YOoVr
         sOlA==
X-Gm-Message-State: AOAM53070MeYqu33SE+vxVvuzcl4rr7c0ZvgFBBDfRev2UKgfa9Sa2pa
        /FOyc1t88kaWNGY9tupJwA==
X-Google-Smtp-Source: ABdhPJw53nT25tjldjHfake5qVTorjpi6v6nDrY+wLnWDO2+imbSaw5Eo7N2GerPH4nRugMInKmh+w==
X-Received: by 2002:a05:6830:2081:b0:5ce:ae9:2711 with SMTP id y1-20020a056830208100b005ce0ae92711mr14712746otq.215.1649856885224;
        Wed, 13 Apr 2022 06:34:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y15-20020a056830208f00b005e6bf82e0b6sm6685084otq.46.2022.04.13.06.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 06:34:44 -0700 (PDT)
Received: (nullmailer pid 3093338 invoked by uid 1000);
        Wed, 13 Apr 2022 13:34:44 -0000
Date:   Wed, 13 Apr 2022 08:34:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Camel Guo <Camel.Guo@axis.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@axis.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add TMP401, TMP411 and TMP43x
Message-ID: <YlbRdCXnPPurC2wC@robh.at.kernel.org>
References: <20220412135232.1943677-1-camel.guo@axis.com>
 <20220412135232.1943677-2-camel.guo@axis.com>
 <YlXwyKkkC1VoPpjU@robh.at.kernel.org>
 <77167ffd-5674-9f6f-df51-3233e67fe9a7@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77167ffd-5674-9f6f-df51-3233e67fe9a7@axis.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 09:13:39AM +0000, Camel Guo wrote:
> On 4/12/22 23:36, Rob Herring wrote:
> > On Tue, Apr 12, 2022 at 03:52:31PM +0200, Camel Guo wrote:
> >> Document the TMP401, TMP411 and TMP43x device devicetree bindings
> >> 
> >> Signed-off-by: Camel Guo <camel.guo@axis.com>
> >> ---
> >> 
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - ti,tmp401
> >> +      - ti,tmp411
> >> +      - ti,tmp431
> >> +      - ti,tmp432
> >> +      - ti,tmp435
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> > 
> >> +  '#address-cells':
> >> +    const: 1
> >> +
> >> +  '#size-cells':
> >> +    const: 0
> > 
> > You don't have any child nodes and these are for child nodes with 'reg'.
> 
> Ack! I will fix it in v3.
> > 
> >> +
> >> +  ti,extended-range-enable:
> >> +    description:
> >> +      When set, this sensor measures over extended temperature range.
> >> +    type: boolean
> >> +
> >> +  ti,n-factor:
> > 
> > Funny, I just ran across this property today for tmp421...
> > 
> > Can the schema be shared?
> 
> Yes, this property is in ti,tmp421.yaml and ti,tmp464.yaml as well. But 
> I guess maybe it is better to separate tmp401 from them.
> 
> That is because the chips supported in ti,tmp421,yaml has three channels 
> and the chips supported in ti,tmp464.yaml has eight channels and this 
> property n-factor is for each channel/child node. But the chips 
> supported in ti,tmp401.yaml only has one channel. n-factor is for this 
> chip.

Okay, that makes sense to keep them separate.

> >> +    description:
> >> +      value to be used for converting remote channel measurements to
> >> +      temperature.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    items:
> >> +      minimum: 0
> >> +      maximum: 255
> > 
> > Isn't this property signed and should be -128 to -127? The code treats
> > the existing cases as signed. One schema is correct and one is like you
> > have it.
> 
> Ack! will fix it in v3
> 
> > 
> >> +
> >> +  ti,beta-compensation:
> >> +    description:
> >> +      value to select beta correction range.
> >> +    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    items:
> >> +      minimum: 0
> >> +      maximum: 15
> > 
> > Drop 'items'. It is not an array.
> 
> Not sure if I understand correctly. Do you means it should be like this? 
> If so, I guess ti,n-factor should also be changed like this. Am I right?
> 
>    ti,beta-compensation:
>     description:
>       value to select beta correction range.
>       $ref: /schemas/types.yaml#/definitions/uint32
>       minimum: 0
>       maximum: 15

Yes, except your indentation is off. As-is, it's all 'description'. It 
should be like this:

  ti,beta-compensation:
    description:
      value to select beta correction range.
    $ref: /schemas/types.yaml#/definitions/uint32
    minimum: 0
    maximum: 15

Rob
