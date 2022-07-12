Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C073457222D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 20:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiGLSGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 14:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiGLSGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 14:06:42 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878DCAE553;
        Tue, 12 Jul 2022 11:06:36 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id a20so5321208ilk.9;
        Tue, 12 Jul 2022 11:06:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YtzP7I40RQyEUjKbXHB73J4wJHJ46s1Pzo+UKJfysDc=;
        b=50V9cYcO9thGrAX5MUBBL5TTQfHJW20x4pvbSIrcJuQfwnWNPJEpl14/9aPDo1/yNH
         4nu6rTI2EyeJk3jO+SDn+NrbA0pS2m29ieOCzhxbNDqlTObzXDx7o2ulVu8P1aFJjHpU
         NDQ3WW1dhOnE1Z1Syd5Ic5zylwS0sgrg72aPSdCpa51E+5yKhLsJ2WFUFwi7SjDK8doE
         i82jl4mb+F0Y1MpvOIt9iy3rk8S5Z90ZCka6SkiinzuRSKaUFA35qQDVnMORLX9tE5eL
         w1UxstMGv7J1uUJcnEf4HH+jaNtVCdEROYRs/ZBtnNRWaSSVjN/RlP5Q+wrv2DjLMXjB
         n12Q==
X-Gm-Message-State: AJIora8x8LhOYdYYjyDvV15wjZaOWO5O0xEwEmg4hJAX2z6unW1+gLWG
        k9NIYlD7VVNHX011LAruNA==
X-Google-Smtp-Source: AGRyM1uQj9XqR1H/j1xEWpea/Q+tQa2PKHOSbgCLwSEg/z123utZodWxiVGVv4vw8BKVxtlj/J0DYg==
X-Received: by 2002:a05:6e02:154d:b0:2dc:6324:e1be with SMTP id j13-20020a056e02154d00b002dc6324e1bemr11287953ilu.47.1657649195773;
        Tue, 12 Jul 2022 11:06:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id cq7-20020a056638478700b0033f21999e6csm4389983jab.90.2022.07.12.11.06.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 11:06:35 -0700 (PDT)
Received: (nullmailer pid 2112717 invoked by uid 1000);
        Tue, 12 Jul 2022 18:06:32 -0000
Date:   Tue, 12 Jul 2022 12:06:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie, msp@baylibre.com, granquet@baylibre.com,
        jitao.shi@mediatek.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        liangxu.xu@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v13 01/10] dt-bindings: mediatek,dp: Add Display Port
 binding
Message-ID: <20220712180632.GH1823936-robh@kernel.org>
References: <20220701062808.18596-1-rex-bc.chen@mediatek.com>
 <20220701062808.18596-2-rex-bc.chen@mediatek.com>
 <20220701202914.GA1457156-robh@kernel.org>
 <d8b6f7d9b79608c9a533042f714869219ad067be.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8b6f7d9b79608c9a533042f714869219ad067be.camel@mediatek.com>
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

On Tue, Jul 05, 2022 at 05:40:27PM +0800, Rex-BC Chen wrote:
> On Fri, 2022-07-01 at 14:29 -0600, Rob Herring wrote:
> > On Fri, Jul 01, 2022 at 02:27:59PM +0800, Bo-Chen Chen wrote:
> > > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > > 
> > > This controller is present on several mediatek hardware. Currently
> > > mt8195 and mt8395 have this controller without a functional
> > > difference,
> > > so only one compatible field is added.
> > > 
> > > The controller can have two forms, as a normal display port and as
> > > an
> > > embedded display port.
> > 
> > I'm sure you answered this before, but I'll keep asking until the 
> > information is contained within this patch. Otherwise, I won't
> > remember. 
> > Is there a h/w difference in the 2 blocks? Different registers? Why 
> > can't you just look at what the output is connected to?
> > 
> 
> Hello Rob,
> 
> Thanks for your review.
> Yes, it's two different hw for edp and dp and they have different
> registers base address.

Multiple instances *always* have different base addresses. That's not a 
difference.

I probably asked before on what the difference is between edp and dp 
variants if anything? If the blocks have some difference then, different 
compatibles makes sense. But you need to explain the difference or I'll 
just be asking again...

Rob
