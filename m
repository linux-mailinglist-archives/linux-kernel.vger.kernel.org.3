Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E505AB97F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 22:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiIBUh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 16:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIBUhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 16:37:23 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C113F8F7C;
        Fri,  2 Sep 2022 13:37:23 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-11e7e0a63e2so7626045fac.4;
        Fri, 02 Sep 2022 13:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=D5I2FegB0/865hyvFadrtO3KVuPLcvZSOcVWjIZiMYE=;
        b=jxmloLFLIaPDLsr+I0lHc5hCBCWUvs481Gci+St/O7eEXvwloIHfh9vcTjuNYUM+MS
         GU6rcNa9rn5jEFTBKVMC3QXtOeHKxrfrsI3I6JeE87arTf8UVfrsPPD8nShDS29N++u3
         07RvTcuoRJ5rH4zYjZEtQ/419Qs7Uu6tdEHe4YEyDbXsphXcfGDy9wKOvMLkgomvpaa1
         2V9Fc8Dh3mfp8aFYnMOUgn1mvBDrPRafVEUWr+chHApi3T1XN8FWyNLLkE5kxQSQlmn7
         hyoOTETSX4b30i5by9GcXbJk+2hnTivCC3H2MEOjCTW/7oiTE+laRReUgITshhphcZEr
         o2SA==
X-Gm-Message-State: ACgBeo2n1xjYvS42eeWG8otASlhAM2nL9Ht0otODZYv/aSX3qyyd9qju
        R16zGcPT/6iypV5X7X2AEM/YB/RvQA==
X-Google-Smtp-Source: AA6agR74vMjIV6E6x7glZrZm9SKfzRvLDhnq5sddCSsKFOxouv32JrJa1HCse/8QJkatK6iljKePLQ==
X-Received: by 2002:a05:6870:d7a5:b0:11d:a0b:f62b with SMTP id bd37-20020a056870d7a500b0011d0a0bf62bmr3000832oab.190.1662151042314;
        Fri, 02 Sep 2022 13:37:22 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e28-20020a544f1c000000b003436fa2c23bsm1408427oiy.7.2022.09.02.13.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:37:21 -0700 (PDT)
Received: (nullmailer pid 372769 invoked by uid 1000);
        Fri, 02 Sep 2022 20:37:21 -0000
Date:   Fri, 2 Sep 2022 15:37:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] dt-bindings: reset: syscon-reboot: Add priority
 property
Message-ID: <20220902203721.GA356619-robh@kernel.org>
References: <20220820102925.29476-1-pali@kernel.org>
 <20220822124728.GA3641041-robh@kernel.org>
 <20220822135050.o4a4bw3dqkmhtjgb@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220822135050.o4a4bw3dqkmhtjgb@pali>
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

On Mon, Aug 22, 2022 at 03:50:50PM +0200, Pali Rohár wrote:
> On Monday 22 August 2022 07:47:28 Rob Herring wrote:
> > On Sat, Aug 20, 2022 at 12:29:23PM +0200, Pali Rohár wrote:
> > > This new optional priority property allows to specify custom priority level
> > > of reset device. Default level was always 192.
> > 
> > Why do we need/want this? What problem does it solve?
> 
> See patch 3/3.
> 
> > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > ---
> > >  .../devicetree/bindings/power/reset/syscon-reboot.yaml        | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > > index da2509724812..d905133aab27 100644
> > > --- a/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > > +++ b/Documentation/devicetree/bindings/power/reset/syscon-reboot.yaml
> > > @@ -42,6 +42,10 @@ properties:
> > >      $ref: /schemas/types.yaml#/definitions/uint32
> > >      description: The reset value written to the reboot register (32 bit access).
> > >  
> > > +  priority:
> > 
> > A bit too generic for the name.
> > 
> > > +    $ref: /schemas/types.yaml#/definitions/sint32
> > > +    description: Priority level of this syscon reset device. Default 192.
> > 
> > default: 192
> > 
> > 
> > Though I'm not really sure about the whole concept of this in DT. Where 
> > does 192 come from?
> 
> Implicitly from the current implementation and how it is used.

Implementation of what? u-boot? BSD? robOS?

> > Presumably if we have more than 1 reset device, then 
> > 'priority' is needed in multiple places. So you need a common schema 
> > defining the property (as property types should be defined exactly 
> > once) which this schema can reference.
> > 
> > Rob
> 
> Sorry, I do not understand.

So just keep sending new versions instead?

syscon-reboot is not the only binding for a system reset device, right? 
So those others reset devices will need 'priority' too. For a given 
property, there should only be one schema definition defining the type 
for the property. Otherwise, there might be conflicts. So you need a 
common schema doing that. And here you would just have 'priority: true' 
or possibly some binding specific constraints.

Rob
