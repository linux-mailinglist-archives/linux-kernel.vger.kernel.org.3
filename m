Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A722561753
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbiF3KKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiF3KKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:10:03 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F8BE4474A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:10:01 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id fd6so25838051edb.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x6R57O4urDU2YjNPka2DlENCvQCcdTvXSj/0KHICFvk=;
        b=eKHSxJefHg0CoOL2feCoVC5QCjWK9UF6S0HKL9jJOuBW37cd3oXCW3nTgIzOVHssPj
         8PBatKJJnBYHF7qSohjVIoypeRZdXwDJXQxqxfrs2Gr10gGecbM7ok/vl+Qxfse/g72Q
         0BRoQZU1FJK6I/e0+N5/Lqi9TbcE3DjSuijZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x6R57O4urDU2YjNPka2DlENCvQCcdTvXSj/0KHICFvk=;
        b=oX3eLWiwB94ImzE+nYR76sHi7LA2f3+OELtido6epWidLnQQpkK10MChvobBUgb6un
         eQvMLcts3DQ+xkGkdxgrbhrwjGpYKP02G9W2xZtxXioBZLuAqs8T5cxpZFnhWRIFJ7Gv
         rA8p2MlYRtVkOokNsvqNH0qw79ERyzLZVSV8KreD6+dC+I9xU7NqR+NU3Wfu/x6Ou2+B
         /qf60nkTfEBANe31fpGNJIqEOEgaky8jtlx+R4MIvBvdrJGrvUq2fLIKZHK1GNZ6/KDw
         GOW9l/S56zx7rn46530esDgbvEk++eul0bYQ+J5NycgzPsEHLsCMWoXCcD8YnCxoUy4O
         qDOg==
X-Gm-Message-State: AJIora847rjWnbshxxERPKYUwU4KW8G2jrLzDAWP8cEAsmnNIGHG68YR
        eoz0gQSS/SHz5CktGrR1kPTIPXFBRo36qg==
X-Google-Smtp-Source: AGRyM1s57Tso0VPPeTN/5BjZ19cWWdP1rE0VdmfYtKSB4A4yhMw+PDOMywZW8+5MiwdKuvAraxT43w==
X-Received: by 2002:a05:6402:2743:b0:437:d467:4a57 with SMTP id z3-20020a056402274300b00437d4674a57mr10586294edd.235.1656583800074;
        Thu, 30 Jun 2022 03:10:00 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id q4-20020a1709064cc400b006fec4ee28d0sm8824131ejt.189.2022.06.30.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 03:09:59 -0700 (PDT)
Date:   Thu, 30 Jun 2022 12:09:57 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <20220630100957.GE482517@tom-ThinkPad-T14s-Gen-2i>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
 <167f09c1-795d-1471-20f7-9f4df29355ed@linaro.org>
 <20220630090232.GC482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1pD2U2ilXXXX+Q@valkosipuli.retiisi.eu>
 <20220630091613.GD482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1xzeqW2p4jVDzS@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1xzeqW2p4jVDzS@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

On Thu, Jun 30, 2022 at 12:50:05PM +0300, Sakari Ailus wrote:
> Hi Tommaso,
> 
> On Thu, Jun 30, 2022 at 11:16:13AM +0200, Tommaso Merciai wrote:
> > Hi Sakari,
> > 
> > On Thu, Jun 30, 2022 at 12:12:47PM +0300, Sakari Ailus wrote:
> > > On Thu, Jun 30, 2022 at 11:02:32AM +0200, Tommaso Merciai wrote:
> > > > On Thu, Jun 30, 2022 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> > > > > On 30/06/2022 09:45, Tommaso Merciai wrote:
> > > > > > Add documentation of device tree in YAML schema for the OV5693
> > > > > > CMOS image sensor from Omnivision
> > > > > > 
> > > > > > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > > > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > > > Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > > > 
> > > > > How Sakari's tag appeared here? There was no email from him.
> > > > 
> > > > Sakari made me some review on v2, but I think he forgot to add the mailing
> > > > list in cc. ( I suppose :) )
> > > > 
> > > > Let me know if I need to remove this.
> > > 
> > > You're only supposed to put these tags into patches if you get them in
> > > written form as part of the review, signalling acceptance of the patch in
> > > various forms. Just commenting a patch does not imply this.
> > > 
> > > Please also see Documentation/process/submitting-patches.rst for more
> > > information on how to use the tags.
> > 
> > Thanks for sharing this. My bad.
> > I remove your tags.
> 
> The patches themselves seem fine. I'd just drop the 4th patch or at least
> come up with a better name for ov5693_hwcfg() --- you're acquiring
> resources there, and that generally fits well for probe. The code is fine
> already.

Then we don't need v5 with your reviewed tags removed?

I think the patch4 is needed to add dts support properly.
Also this contains devm_clk_get_optional fix suggested by Jacopo and
support for ACPI-based platforms that specify the clock frequency by
using the "clock-frequency" property instead of specifying a clock
provider reference.

Some suggestion on the function name?

Thanks,
Tommaso

> 
> -- 
> Sakari Ailus

-- 
Tommaso Merciai
Embedded Linux Engineer
tommaso.merciai@amarulasolutions.com
__________________________________

Amarula Solutions SRL
Via Le Canevare 30, 31100 Treviso, Veneto, IT
T. +39 042 243 5310
info@amarulasolutions.com
www.amarulasolutions.com
