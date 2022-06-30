Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EBC5615FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 11:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbiF3JRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiF3JR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:17:27 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8034433BC
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:16:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e40so25706906eda.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 02:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jxh9+8wGKifer/pkVBwkWFz/cUObqSEK4gTsvDCOLoQ=;
        b=mtiJ96LmLCRmWOanbe4ljk3xT3YdaBPutJSnlnWsxIYdNS9uCVN/HAHRCmp0acxDWV
         rRNbdX9q9ZTX2WKIGY62cj2PCkJ3HDA44PxEcjzLDxS6iafRpTUiVmalPY3vA677ko7n
         61aO/2oFVlXmsx844VQlHLW80YR1GOupEAi4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jxh9+8wGKifer/pkVBwkWFz/cUObqSEK4gTsvDCOLoQ=;
        b=PBzqphbGYttWcJpJ7creyvzjoSMcI2O6H6e0ncH0sP1NuVJLVx0llB515gslcKW04w
         FmuzTcp4uu0GeZaay9dvAVcvJGEUzt7YgFCRkkYn7t2jEHjG2l58ne4YGzG/0oxmNtCR
         p14a8DLWbmyW8eHQsI2pVEIFOPE9f6CjiY9Q1QdIENsIODbq0kVmaCcrwsX/WMRsQdy2
         082039u4Pk0IUUNzlbhbw704nmh8dMSFKS5LC33gWe33BgMIcQpihPA2i6joP+0ytmIa
         Q1xkgu2pE82nsy6dUUqY6SAC4YLl6KFh8g/1cwkxiEFQU/83hzxyqfrVz2TNcjc2En3I
         0kMw==
X-Gm-Message-State: AJIora9MtMT+p9w6qG7d6xAEWw9R2fImPCm14AoVRj7aC2vKmc+1xdEK
        bmNZK7VZWhOL8fYwmq4DU9pigQ==
X-Google-Smtp-Source: AGRyM1tftLZ2XSVsXGwKY1tVp8BzpGnUHbWht4UDCihn1aRATfSGrqPAHKl0L1tGrObwQOnOD1W32A==
X-Received: by 2002:a05:6402:4306:b0:435:a1c9:4272 with SMTP id m6-20020a056402430600b00435a1c94272mr10263737edc.205.1656580576250;
        Thu, 30 Jun 2022 02:16:16 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i (net-188-217-58-216.cust.vodafonedsl.it. [188.217.58.216])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906940a00b006fe8bf56f53sm8947680ejx.43.2022.06.30.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 02:16:15 -0700 (PDT)
Date:   Thu, 30 Jun 2022 11:16:13 +0200
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
To:     Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linuxfancy@googlegroups.com, linux-amarula@amarulasolutions.com,
        quentin.schulz@theobroma-systems.com,
        Daniel Scally <djrscally@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] media: dt-bindings: ov5693: document YAML binding
Message-ID: <20220630091613.GD482517@tom-ThinkPad-T14s-Gen-2i>
References: <20220630074525.481790-1-tommaso.merciai@amarulasolutions.com>
 <20220630074525.481790-6-tommaso.merciai@amarulasolutions.com>
 <167f09c1-795d-1471-20f7-9f4df29355ed@linaro.org>
 <20220630090232.GC482517@tom-ThinkPad-T14s-Gen-2i>
 <Yr1pD2U2ilXXXX+Q@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yr1pD2U2ilXXXX+Q@valkosipuli.retiisi.eu>
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

On Thu, Jun 30, 2022 at 12:12:47PM +0300, Sakari Ailus wrote:
> On Thu, Jun 30, 2022 at 11:02:32AM +0200, Tommaso Merciai wrote:
> > On Thu, Jun 30, 2022 at 10:07:19AM +0200, Krzysztof Kozlowski wrote:
> > > On 30/06/2022 09:45, Tommaso Merciai wrote:
> > > > Add documentation of device tree in YAML schema for the OV5693
> > > > CMOS image sensor from Omnivision
> > > > 
> > > > Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > Reviewed-by: Sakari Ailus <sakari.ailus@iki.fi>
> > > 
> > > How Sakari's tag appeared here? There was no email from him.
> > 
> > Sakari made me some review on v2, but I think he forgot to add the mailing
> > list in cc. ( I suppose :) )
> > 
> > Let me know if I need to remove this.
> 
> You're only supposed to put these tags into patches if you get them in
> written form as part of the review, signalling acceptance of the patch in
> various forms. Just commenting a patch does not imply this.
> 
> Please also see Documentation/process/submitting-patches.rst for more
> information on how to use the tags.

Thanks for sharing this. My bad.
I remove your tags.

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
