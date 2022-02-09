Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5D54AF8BF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiBIRsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbiBIRsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:48:46 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8A3C05CB88;
        Wed,  9 Feb 2022 09:48:49 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso3340639ooi.1;
        Wed, 09 Feb 2022 09:48:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9Q2I/VP+XFwXy/Za9m82QJTmUqxQOQNrGnI8flFPCzE=;
        b=XG5AIE+bpgmkBq4s9jP6uDrqIzghOy2TUAc63+GE/Xyimg/eypqRdscLKOg3NkV2i7
         s6tYlf0AAI/v9qyKBHmtE2qjU2OaMulYd8DbHiw2zGFXp9KpAkGsdfjf6eLXAS0SKdrD
         ja6GTEkQhrcKKon6rrvPbafI318sPUGYgLDxepCq1STuKJW7M1f4RiUpRGoVQwzTM5iv
         Jd16d5nB2yRN3oPZyw9HQ50dfq5v0ltnk79+EfPo9PbZAEmr7gcs9PJQz0tw729XdIXr
         /qE8T2zKaOXeftJDLkwP6BlHx6oZegAOaWBnowImR4KVaAXU/+pQbtRr6WUwyZ5bngog
         s9hg==
X-Gm-Message-State: AOAM532TLxFfuaXxcCxLGg0pWjs6N26+OSRDaUg4Qv/vBixLzh26xwUQ
        8tJW9Jp0HwnzPpjjP5Dt0Q==
X-Google-Smtp-Source: ABdhPJxLVUkyLr5K9Jth1KPAM7TMJsJ9wGQtyn4evi3+a6WwLPinzkeFbOB9l+rfCrvEzu15f2MLgg==
X-Received: by 2002:a05:6870:6296:: with SMTP id s22mr1124414oan.338.1644428928376;
        Wed, 09 Feb 2022 09:48:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r41sm6103687oap.2.2022.02.09.09.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:48:47 -0800 (PST)
Received: (nullmailer pid 581562 invoked by uid 1000);
        Wed, 09 Feb 2022 17:48:46 -0000
Date:   Wed, 9 Feb 2022 11:48:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Michael Riesch <michael.riesch@wolfvision.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, Peter Geis <pgwipeout@gmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, Liang Chen <cl@rock-chips.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Alex Bee <knaerzche@gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: gpu: mali-bifrost: describe clocks
 for the rk356x gpu
Message-ID: <YgP+ftqvBcpLg6im@robh.at.kernel.org>
References: <20220209085110.3588035-1-michael.riesch@wolfvision.net>
 <1644420908.380944.391811.nullmailer@robh.at.kernel.org>
 <01b78d95-fdf3-060a-831d-dae2abbc7109@wolfvision.net>
 <3297396.uCXnvZdJcx@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3297396.uCXnvZdJcx@diego>
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

On Wed, Feb 09, 2022 at 05:28:05PM +0100, Heiko Stübner wrote:
> Hi Michael,
> 
> Am Mittwoch, 9. Februar 2022, 16:46:28 CET schrieb Michael Riesch:
> > Hi Rob,
> > 
> > On 2/9/22 16:35, Rob Herring wrote:
> > > On Wed, 09 Feb 2022 09:51:06 +0100, Michael Riesch wrote:
> > >> From: Alex Bee <knaerzche@gmail.com>
> > >>
> > >> The Bifrost GPU in Rockchip RK356x SoCs has a core and a bus clock.
> > >> Reflect this in the SoC specific part of the binding.
> > >>
> > >> Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > >> [move the changes to the SoC section]
> > >> Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
> > >> ---
> > >>  .../devicetree/bindings/gpu/arm,mali-bifrost.yaml | 15 +++++++++++++++
> > >>  1 file changed, 15 insertions(+)
> > >>
> > > 
> > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > 
> > > yamllint warnings/errors:
> > > ./Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml:173:12: [warning] wrong indentation: expected 12 but found 11 (indentation)
> > 
> > D'oh! Sorry for the stupid mistake, I found that yamllint was indeed
> > missing.
> > 
> > Lines 173 and 174 need an extra space. In the case that a v6 is required
> > I'll fix this. But of course I wouldn't say no if this could be fixed
> > when the patch is applied :-)
> 
> My guess is, Rob's bot filters out the easy wrongs, so I'm not sure if he
> actually looks at these in person.

I do because there are sometimes false positives. It's not a free 
testing service. (Well, it might be free beer for you, but that's 
because I'm buying. :) ) For just indentation I will still review them 
(eventually).

> So doing a v6 might actually be better for a Review :-)

Resending just moves you to the back of the line (usually). 

Rob
