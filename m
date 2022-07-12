Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB35157289F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 23:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiGLV22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 17:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGLV20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 17:28:26 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FFFD0E2F;
        Tue, 12 Jul 2022 14:28:25 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id e5so9176479iof.2;
        Tue, 12 Jul 2022 14:28:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6TLPAajBQT6bOULK9fb/tFfHBaPsFyW7O0ai+7s0acY=;
        b=2ffeUMEThBHAn/wnhhVjbdDDoe1vU0yNen4aKvHUWZiOkbFDt948KryvCjNw6KAjE2
         0HAo7AsvjszfCZK41TVRpJwtZMKA2zdJ2gFuyvAStMnN1kIviTipQobQC0bipv+oZjcb
         n7fd3q3j3UEN34L7KR23wFctaK32ho732V0/5fEcy474ukkZJ3RkfYw0y3kUV/c0HKol
         OJjj3tKXPnHpJ14ruoOevTFcG9spVuAukryzc4lu2ocBObdPphxAdRHtMOinOi6skUH6
         JpkDFuUwsMs2CzahwerwMiriA+oCY8GQ1LjexpPqNc+3edHRq6jU0RQG/oRTqd1SAhPg
         NEHg==
X-Gm-Message-State: AJIora+2sH2oK9O6HPCvHSzujiz1f9dTkHJ4UpjX3741uIXuySiiBu1f
        LFWHymBdtSuWVvN/0gx31g==
X-Google-Smtp-Source: AGRyM1uSjAx2XnP+cp6DLP9rPk/b8JA0eEn3XWf/CdbWstFant9WzCWB22BaU4SzBJi67t3gJWDR9w==
X-Received: by 2002:a02:84a7:0:b0:33f:4292:cf with SMTP id f36-20020a0284a7000000b0033f429200cfmr46679jai.319.1657661305105;
        Tue, 12 Jul 2022 14:28:25 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j12-20020a056e02014c00b002dc1b615588sm4186648ilr.36.2022.07.12.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 14:28:24 -0700 (PDT)
Received: (nullmailer pid 2392608 invoked by uid 1000);
        Tue, 12 Jul 2022 21:28:22 -0000
Date:   Tue, 12 Jul 2022 15:28:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] [RFT] dt-bindings: leds: Add
 cznic,turris1x-leds.yaml binding
Message-ID: <20220712212822.GQ1823936-robh@kernel.org>
References: <20220705000448.14337-1-pali@kernel.org>
 <20220705155929.25565-1-pali@kernel.org>
 <20220706131507.353f0bed@thinkpad>
 <20220706111912.hz2mx4dc35lgq6l5@pali>
 <20220706172732.6228d180@thinkpad>
 <25b43586-eeb3-4b7b-7362-2d599aa89cf0@linaro.org>
 <20220708160528.ysy4lzxfpwobfiwr@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220708160528.ysy4lzxfpwobfiwr@pali>
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

On Fri, Jul 08, 2022 at 06:05:28PM +0200, Pali Rohár wrote:
> On Wednesday 06 July 2022 17:36:43 Krzysztof Kozlowski wrote:
> > On 06/07/2022 17:27, Marek Behún wrote:
> > > On Wed, 6 Jul 2022 13:19:12 +0200
> > > Pali Rohár <pali@kernel.org> wrote:
> > > 
> > >> On Wednesday 06 July 2022 13:15:07 Marek Behún wrote:
> > >>> On Tue,  5 Jul 2022 17:59:28 +0200
> > >>> Pali Rohár <pali@kernel.org> wrote:
> > >>>   
> > >>>> +examples:
> > >>>> +  - |
> > >>>> +    #include <dt-bindings/leds/common.h>
> > >>>> +
> > >>>> +    cpld@3,0 {  
> > >>>
> > >>> The generic node name should be just "bus". That it is a CPLD
> > >>> implementation should come from compatible string.  
> > >>
> > >> Sorry, I do not understand why "bus". Why other memory chips are named
> > >> e.g. "nand" or "nor" and not "bus" too?
> > > 
> > > As far as I understand this is because that is the preferred name for
> > > busses and this is a bus, since there is also the simple-bus compatible.
> > > 
> > >> By this logic should not be _every_ node called just "bus"? Hm... and 
> > >> are names needed at all then?
> > > 
> > > :-)
> > > 
> > > The schema
> > >   https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/simple-bus.yaml
> > > allows for different names (soc|axi|ahb|*-bus) to avoid warnings on
> > > existing old dts files.
> > > 
> > > The preferred way is to not have the implementation in nodename,
> > > similar to how we use 'switch' instead of 'mv88e6xxx', or
> > > 'ethernet-phy' instead of 'mv88e151x', or 'led-controller', ...
> > 
> > Thanks Marek for detailed explanation.
> > The cases above rather trigger my comments and this one here, after
> > Pali's explanation, do not fit them. pld is a generic class of a device,
> > so it is okay here. cpld probably as well (although one could argue that
> > it is a subset of pld, so the generic name is pld, but then one would
> > say fpga also should be called pld). For me it does not have to be bus,
> > just don't want mv88e6xxx or any other vendor/model names. Therefore
> > cpld is fine.
> 
> Exactly. cpld, fpga, nor, nand, soc... all of them are not real buses.

I guess you could (and we do) have 'cpld' and 'fpga' as devices where 
the OS can reprogram them and such. But if the implementation is fixed 
with no implementation specific controls, I don't think naming how it's 
implemented adds too much. If there's nothing else to identify the 
device though, having 'cpld' in there does have some value I guess.

Same could be argued for soc too perhaps, but that's in the list largely 
to avoid a bunch of s/soc/bus/ on dts files.
 
> simple-bus here is just name invented by device tree and without which
> existing kernel drivers refuse to work.

Everything is just names invented by DT.

simple-bus means 'a bus containing MMIO devices without any bus 
configuration'. You want to add a clock to it?, then no longer a 
simple-bus. Based on that definition, the kernel can enumerate child 
devices without platform specific help. 

Just use 'cpld-bus' and lets move on with our lives.

Rob
