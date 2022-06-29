Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06591560BB2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 23:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiF2V0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 17:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiF2V0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 17:26:02 -0400
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64331D323;
        Wed, 29 Jun 2022 14:26:01 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id p13so11183052ilq.0;
        Wed, 29 Jun 2022 14:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAnlbGwaJ9TyuQs7iWeZBAejDnwxdU93bNzpne1ImGI=;
        b=IgjNy2Zga4vDDf7qOZFDF1Dcoh6WAXr9ry+/yBHINDuhz5nMJoa/aPAtOfJQO1R19U
         IzQuH2UeQioxQyLivEW8zE9jXWuvRInJ6Q3SquNp3ThntFIeU/IosJ1ZG9foqXFtd4Jg
         swtyqXFOvoy/VCefUUgI1IDIWczdayEa8RAXXp6e5hGB93y6kCLMBLaoSCUm7Jd8RInW
         Iw976kJmzllMZ7jZV9Mujx8ey5wVJlgKvMFTYnJMekuFu0H/SMLSCSsTQGmzHlbJBxcu
         MbcyTLFRCfndpfJYayNQnz/avOO5uMhpFUkiEBxVf67jqdduf+vvL9buqxVEGqNzAJn2
         buCg==
X-Gm-Message-State: AJIora+GZkHNQGPktE/Zl1QVv7jOT4oezAdXybU8ybOixtrN824ek7go
        3zlCLCz0IPoYlKBtTLN0ZWtFY53g+Q==
X-Google-Smtp-Source: AGRyM1uGnG/FqvK7s4eQ1jjuMvP1A15YdewxNxXJDzr+xSEfqGJY54KWk2BtpcyvzmVd7hKKmbJofg==
X-Received: by 2002:a05:6e02:1214:b0:2da:705c:5f03 with SMTP id a20-20020a056e02121400b002da705c5f03mr3048170ilq.318.1656537961129;
        Wed, 29 Jun 2022 14:26:01 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id e24-20020a5d85d8000000b006694bc50b82sm8293589ios.35.2022.06.29.14.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 14:26:00 -0700 (PDT)
Received: (nullmailer pid 858117 invoked by uid 1000);
        Wed, 29 Jun 2022 21:25:59 -0000
Date:   Wed, 29 Jun 2022 15:25:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Vabhav Sharma <vabhav.sharma@nxp.com>
Cc:     Horia Geanta <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Silvano Di Ninno <silvano.dininno@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>
Subject: Re: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy
 delay property
Message-ID: <20220629212559.GA843061-robh@kernel.org>
References: <20220530180924.1792399-1-vabhav.sharma@nxp.com>
 <20220530180924.1792399-2-vabhav.sharma@nxp.com>
 <20220605212114.GA3528129-robh@kernel.org>
 <AS1PR04MB9358BCBEBDC7EBAC6E5DD6A9F3AC9@AS1PR04MB9358.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR04MB9358BCBEBDC7EBAC6E5DD6A9F3AC9@AS1PR04MB9358.eurprd04.prod.outlook.com>
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

On Thu, Jun 16, 2022 at 05:49:30PM +0000, Vabhav Sharma wrote:
> Hello Rob,
> 
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, June 6, 2022 2:51 AM
> > To: Vabhav Sharma <vabhav.sharma@nxp.com>
> > Cc: Horia Geanta <horia.geanta@nxp.com>; Gaurav Jain
> > <gaurav.jain@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>;
> > herbert@gondor.apana.org.au; davem@davemloft.net;
> > shawnguo@kernel.org; linux-crypto@vger.kernel.org; linux-
> > kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; Silvano Di
> > Ninno <silvano.dininno@nxp.com>; Varun Sethi <V.Sethi@nxp.com>
> > Subject: [EXT] Re: [PATCH 1/3] dt-bindings: crypto: fsl: add entropy delay
> > property
> > 
> > Caution: EXT Email
> > 
> > On Mon, May 30, 2022 at 11:39:22PM +0530, Vabhav Sharma wrote:
> > > Add entropy delay property which defines the length (in system clocks)
> > > of each Entropy sample taken for TRNG configuration.
> > >
> > > Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> > > Reviewed-by: Horia Geanta <horia.geanta@nxp.com>
> > > Reviewed-by: Varun Sethi <v.sethi@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/crypto/fsl-sec4.txt | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > > b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > > index 8f359f473ada..1477294eda38 100644
> > > --- a/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > > +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4.txt
> > > @@ -62,6 +62,12 @@ PROPERTIES
> > >        Definition: A standard property. Define the 'ERA' of the SEC
> > >            device.
> > >
> > > +   - entropy-delay
> > > +      Usage: optional
> > > +      Value type: <u32>
> > > +      Definition: A property which specifies the length (in system clocks)
> > > +          of each Entropy sample taken.
> > > +
> > 
> > Seems like this could be common, but should be a time value (with unit
> > suffix) rather than clocks. If not common, then needs a vendor prefix.
> > Is this time to read a value or time between values produced? Not really clear
> > from the description.
> CAAM TRNG Configuration includes 16-bit field entropy-delay. This field specifies how long the oscillator is given to freely oscillate and generate a single bit of entropy.
> It is specified as number of system clock cycles and this u32 type field already exist in the caam driver code with default value of 3200. However, on some platform this value can vary and support is added to read the value from device tree in order to override default value, Hope this helps to clarify.

So that is how often a sample can be read? Or what happens if you read a 
sample too quick (in less than this delay time)?

Look at other h/w and drivers see if something common makes sense here.

Rob
