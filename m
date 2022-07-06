Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3C568EB4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:11:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbiGFQLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiGFQLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:11:14 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344E237E3;
        Wed,  6 Jul 2022 09:11:13 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id b1so3836850ilf.8;
        Wed, 06 Jul 2022 09:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xqvCFaRmeZZtgaYKxSb/zDtrg0BtbPrZr498xClMHoA=;
        b=smYGCgckHEI2Xbbkl8cZcxfpvhBSzQQ7X9b/43khfNLiLz4Xsyt5AP24iFpJXteKSr
         BKG2KwSNyt7VUd7XwH4HvVy8D+H6ba6awJME6qMY8P6vHuVmqm1VesbBm1wxkLkRwURt
         e+iNEVbGgZXlyLr7HyJ+sgRcm3u8D9hmOBMDWx/lFEKhkmIJOYG0EoSIr23W0k3Fxj8+
         hWwaZBz1ztv8jUANLws0oCB1Tz36q3c+N2D2PG5CfiG+OMWT49r32ogjRCKN+HFIem6k
         EODdQTpQYMUnfLlZFL4PRDi8lGTuzU3XD2WZpdZeKB+rWevjGR7OKmFxBZc9gzBaO/iM
         r+AQ==
X-Gm-Message-State: AJIora+hrq3xky3He3HrTGwzJgA2lEbAJ6pfDFjvycWYh1VJguLAMDen
        xnbW50rh6AVzHsuNHXR2Rg==
X-Google-Smtp-Source: AGRyM1v8pCXB40SvhaQJFc1zm1w3F8CrTtVMAwVoNHW1OCBQIOXWP1i4ozkxVqIm7YI18B7NPIxp6A==
X-Received: by 2002:a92:cd8f:0:b0:2d9:5d44:6a53 with SMTP id r15-20020a92cd8f000000b002d95d446a53mr24555148ilb.226.1657123872876;
        Wed, 06 Jul 2022 09:11:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q25-20020a05663810d900b0032e1a07228asm16164339jad.26.2022.07.06.09.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 09:11:12 -0700 (PDT)
Received: (nullmailer pid 136692 invoked by uid 1000);
        Wed, 06 Jul 2022 16:11:10 -0000
Date:   Wed, 6 Jul 2022 10:11:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Han Xu <han.xu@nxp.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Bough Chen <haibo.chen@nxp.com>, ashish.kumar@nxp.com,
        yogeshgaur.83@gmail.com, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, singh.kuldeep87k@gmail.com,
        tudor.ambarus@microchip.com, p.yadav@ti.com,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        festevam@gmail.com, dl-linux-imx <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 07/11] dt-bindings: spi: spi-nxp-fspi: add a new property
 nxp,fspi-dll-slvdly
Message-ID: <20220706161110.GA123915-robh@kernel.org>
References: <VI1PR04MB40167A70FBE772DF91047A4190819@VI1PR04MB4016.eurprd04.prod.outlook.com>
 <59d360ef-5374-c7a7-2995-854ab3715b25@linaro.org>
 <DU2PR04MB87747C9A8F18D8300461D6B197819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <f33ad190-f5c7-d9fa-088b-5538ab1f4d59@linaro.org>
 <DU2PR04MB877492F346BAA10B2AA7428497819@DU2PR04MB8774.eurprd04.prod.outlook.com>
 <62f113a0cdb0d58bf04ab0b274912eb7@walle.cc>
 <be521f90-97ce-c61d-d7d6-8f2bde24d824@linaro.org>
 <20220705145226.tarpvub6bh67tj63@umbrella>
 <0bd271e9-8d9b-7388-2d9b-65cc39a54f8c@linaro.org>
 <20220705155031.zk36jsq4q2ac2ow4@umbrella>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705155031.zk36jsq4q2ac2ow4@umbrella>
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

On Tue, Jul 05, 2022 at 10:50:31AM -0500, Han Xu wrote:
> On 22/07/05 05:38PM, Krzysztof Kozlowski wrote:
> > On 05/07/2022 16:52, Han Xu wrote:
> > > On 22/07/05 04:12PM, Krzysztof Kozlowski wrote:
> > >> On 05/07/2022 16:06, Michael Walle wrote:
> > >>>
> > >>>>>
> > >>>>> I think you could use here clock cycles or clock phase, but then it 
> > >>>>> has to be obvious
> > >>>>> it is that unit.
> > >>>>
> > >>>> Hi Krzysztof,
> > >>>>
> > >>>> Let me clarify it, in the document a term "delay cell" was used to
> > >>>> descript this register bit. Each delay cell equals "1/32 clock phase",
> > >>>> so the unit of delay cell is clock phase. The value user need set in
> > >>>> DT just number to define how many delay cells needed.
> > >>>
> > >>> Then should the unit be "-degrees" and the possible range 0-180?
> > >>
> > >> Thanks. We don't have it documented currently, but the unit seems
> > >> reasonable.
> > > 
> > > IMO, use the unit "-degrees" makes it more complicate. Personaly I would
> > > calculate how many clock cycle delay needed, such as 1/4 clock cycle or half
> > > clock cycle. Using degree brings extra calculation.
> > 
> > And what if the next device uses a bit different divider? Like 1/16?
> > This is why we have standard units so people won't push register values
> > into the bindings.
> > 
> > > 
> > > The granularity of the clock phase change is 1/32 of 180 degree, but the range
> > > 0-180 make people feel it can be set in any degree in range.
> > 
> > Yes, because that's how the bindings are being written - allowing any
> > reasonable value, not register-specific value, to be used because it is
> > the most flexible, hardware-independent and allows further customization
> > of bindings (e.g. new devices). Embedding device programming model into
> > the bindings contradicts it.
> > 
> > Second, nothing stops you from narrowing the acceptable values with an
> > enum. This still allows extension. Your 1/32 does not.
> > 
> > > 
> > > If I describe all details of the relation between "nxp,fspi-dll-slvdly" and
> > > "delay cell" in patch v2, do you think it's clear for users?

What's a cell?

> > 
> > 1/32 could be a nice unit, but degrees is better. Just like uV is better
> > than 1/32 of V. Like 1 us is better than 1/32 of ms.
> > 
> > Do you see  in the bindings many other values like time, potential,
> > current or power described in 1/32 units?
> 
> That make sense. I will use degree as the unit and round to register proper
> value in driver as Michael suggested. Thanks for all comments.

I'm still wondering what this is delaying? From what to what? We already 
have numerous common delay properties for SPI. If one of those doesn't 
work, then should this be a new common property? And if common, I think 
time units is better to use than degrees.

If this is vendor specific, then I'd just use the register value. 
There's not much point in using common units unless it is a common 
property.

Rob
