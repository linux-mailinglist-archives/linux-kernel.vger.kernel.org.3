Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06810561DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 16:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236726AbiF3ONe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 10:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237187AbiF3OMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 10:12:45 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA2987340
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:56:40 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id fw3so11531413ejc.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 06:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hbTllh8Hsezn8N/bSAVjKclbkJcfmumwQZWStnTA5EM=;
        b=pA+k5wfjGgv1yttATQlfksT7W3A37yqYO2cUpUQIXl/yeu+ygqLLHbVm8lHc3el+VX
         nD1tGHWRiT4d0Zzby7GTaqbdX02q/tbHEF7MV0+/2tIN65nWvu/zKKv6oYw1cj7Nfh79
         5fg/T10emX6kF1MRnyqieJXTfcopwwvTuwHio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hbTllh8Hsezn8N/bSAVjKclbkJcfmumwQZWStnTA5EM=;
        b=2nM72XCJ8U/FgURYJQ2Svog7AyUU1ZOHHlyAnR706x89elWPjnF6NP4vSCr63jNmvs
         z+zuXEBSR4ulJ4+QFoLbsRq5l+MYPlBwYegGejNDdt0vvpje68cPhTJiTQamlCMRXA5p
         Tt19120RUKUvKNyr8xe7w/G9+oW1FYz8A3ulfCVVarfgHLM6sSD2f/bHLvm54PIwBaam
         KOdyVYvXQIoy/Mg0xdCfG6TM/1Ulc5i8UJEjLRvXwIbW9bjFKsMx1d5IaMMAgGeJzUSJ
         Eyln85WUIIkt7eUPkumPCa+bt2oElyn7MU8qT7Wk+OFO24OeIDYxt9JmvADAaavntjyu
         ADAA==
X-Gm-Message-State: AJIora9Qt3xOAat339EwrzII/fqFDGvkOvzw00mRt8JUzNec/0RKaxtc
        ZGTQ9jlQL9bLc7tGjosc1Pc2mg==
X-Google-Smtp-Source: AGRyM1u0GTwaMdAxYJXz25bQFuezOCi+k87jFjSK5LaFxVCXp8RMPSJ98Nm6Z9x8E21UlTI2Dc44xg==
X-Received: by 2002:a17:906:7386:b0:715:7024:3df7 with SMTP id f6-20020a170906738600b0071570243df7mr9132047ejl.543.1656597398783;
        Thu, 30 Jun 2022 06:56:38 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id sd23-20020a170906ce3700b00711c7cca428sm9180367ejb.155.2022.06.30.06.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 06:56:38 -0700 (PDT)
Date:   Thu, 30 Jun 2022 15:56:36 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <20220630135636.GA592928@tom-ThinkPad-T14s-Gen-2i>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
 <167f09c1-795d-1471-20f7-9f4df29355ed@linaro.org>
 <20220630090232.GC482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1pD2U2ilXXXX+Q@valkosipuli.retiisi.eu>
 <20220630091613.GD482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1xzeqW2p4jVDzS@valkosipuli.retiisi.eu>
 <20220630100957.GE482517@tom-ThinkPad-T14s-Gen-2i>
 <3fcbbea3-6c1e-723b-cc20-9a2454d2ad50@gmail.com>
 <Yr2HIPr7kIxbwSWB@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr2HIPr7kIxbwSWB@valkosipuli.retiisi.eu>
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

On Thu, Jun 30, 2022 at 02:21:04PM +0300, Sakari Ailus wrote:
> On Thu, Jun 30, 2022 at 11:15:40AM +0100, Daniel Scally wrote:
> > Hello
> > 
> > On 30/06/2022 11:09, Tommaso Merciai wrote:
> > > Hi Sakari,
> > >
> > > On Thu, Jun 30, 2022 at 12:50:05PM +0300, Sakari Ailus wrote:
> > >> Hi Tommaso,
> > >>
> > >> On Thu, Jun 30, 2022 at 11:16:13AM +0200, Tommaso Merciai wrote:
> > >>> Hi Sakari,
> > >>>
> > >>> On Thu, Jun 30, 2022 at 12:12:47PM +0300, Sakari Ailus wrote:
> > >>>> On Thu, Jun 30, 2022 at 11:02:32AM +0200, Tommaso Merciai wrote:
> > >>>>> On Thu, Jun 30, 2022 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> > >>>>>> On 30/06/2022 09:45, Tommaso Merciai wrote:
> > >>>>>>> Add documentation of device tree in YAML schema for the OV5693
> > >>>>>>> CMOS image sensor from Omnivision
> > >>>>>>>
> > >>>>>>> Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > >>>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >>>>>>> Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
> > >>>>>> How Sakari's tag appeared here? There was no email from him.
> > >>>>> Sakari made me some review on v2, but I think he forgot to add the mailing
> > >>>>> list in cc. ( I suppose :) )
> > >>>>>
> > >>>>> Let me know if I need to remove this.
> > >>>> You're only supposed to put these tags into patches if you get them in
> > >>>> written form as part of the review, signalling acceptance of the patch in
> > >>>> various forms. Just commenting a patch does not imply this.
> > >>>>
> > >>>> Please also see Documentation/process/submitting-patches.rst for more
> > >>>> information on how to use the tags.
> > >>> Thanks for sharing this. My bad.
> > >>> I remove your tags.
> > >> The patches themselves seem fine. I'd just drop the 4th patch or at least
> > >> come up with a better name for ov5693_hwcfg() --- you're acquiring
> > >> resources there, and that generally fits well for probe. The code is fine
> > >> already.
> > > Then we don't need v5 with your reviewed tags removed?
> > >
> > > I think the patch4 is needed to add dts support properly.
> > > Also this contains devm_clk_get_optional fix suggested by Jacopo and
> > > support for ACPI-based platforms that specify the clock frequency by
> > > using the "clock-frequency" property instead of specifying a clock
> > > provider reference.
> > 
> > 
> > I agree patch 4 in some form is needed - I didn't do the clock handling
> > particularly well in this driver, and though it's ostensibly an ACPI
> > driver it wouldn't actually work with a "normal" ACPI, but just with the
> > cio2-bridge-repaired style. So the changes to the clock handling logic
> > are welcome and needed I think. whether it needs to go into a separate
> > function I don't particularly mind either way.
> 
> Yes, the clock handling needs to be changed. But I'd keep it in probe.

Fixed in v5, as you suggest.
Thanks all for your time.

Regards,
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
