Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14C4CDFB9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiCDVYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCDVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:24:51 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A77B5EBD8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:24:03 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id 9so8850737pll.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 13:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0/gI0rQqdFAbRjNwHFPVJ4i6AznAGpkDeOuSwoRZAto=;
        b=dW6sniIDfe4ZwFk7pH6asyZbMfHUDkzWKEaqD8k09+XRZxqGVgvxvwowBaBBa8GvSB
         LnIHuXeBP/MKBb2IurRBYrLkjNiDDW9kZzPMXsmeLPCaYAg2Za7l9w1TJzZSI2ILROCa
         Bq/xEX+B3iF9Vgn8acNFkeBDRtPua299o+IvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0/gI0rQqdFAbRjNwHFPVJ4i6AznAGpkDeOuSwoRZAto=;
        b=kI21blpnHlSJ4AHKaDnVvn+Ry7VS0nquc/ofIn8SVxHsyVJp4WR6PI3iKRNIvpnOyD
         t8UQR09B039KgtvpPYm/CoOV3dj6WG5NWAwmyluRDTvUh4OKvWdlwTDh/u5uBmnmUItK
         cqi/yKwrbSwjkqKX0TslFd4sLBdWjZ8FJYvxBO9fdDVRDTgThtDDLRukf+opa4YrJK1a
         gcAqfXRoegnsji045XwYk7Y0BveXbEjddJ3vorQ2yauuW7sl7Z7qbQjYGnyA6rbVNvuq
         yy+rtdT1HK3lzt8Or+hNf8Pnx6CC6EBp1yF7x5l8qlHYB3uLfiJB/GHHw1axidVElv0c
         PTZg==
X-Gm-Message-State: AOAM5307sIn5b2RY8JSGTp9xPo3Utds+VPWSsD2YubGIqdR9FLnYTtaC
        uIAvOvSAODoBUlLFXKSd2HZ/IQ==
X-Google-Smtp-Source: ABdhPJzeXYM5JVp1IZEistkWdlM9E10Rt6/gCbVwnsqXjdM071vp3edsel14904JddV43vI5XN1yYQ==
X-Received: by 2002:a17:902:b784:b0:151:a28a:9445 with SMTP id e4-20020a170902b78400b00151a28a9445mr512967pls.82.1646429042669;
        Fri, 04 Mar 2022 13:24:02 -0800 (PST)
Received: from google.com ([2620:15c:202:201:2947:8460:2ca7:c348])
        by smtp.gmail.com with ESMTPSA id g10-20020a056a000b8a00b004de9129eb80sm7612495pfj.85.2022.03.04.13.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:24:02 -0800 (PST)
Date:   Fri, 4 Mar 2022 13:23:59 -0800
From:   Brian Norris <briannorris@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Lin Huang <hl@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        Derek Basehore <dbasehore@chromium.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH v2 01/15] dt-bindings: devfreq: rk3399_dmc: Convert to
 YAML
Message-ID: <YiKDb6q5k4NHpyVn@google.com>
References: <20220127230727.3369358-1-briannorris@chromium.org>
 <20220127150615.v2.1.I875ab8f28c5155a7d2f103316191954d4b07ac13@changeid>
 <YgQhXb/0BM0OFy/6@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgQhXb/0BM0OFy/6@robh.at.kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 02:17:33PM -0600, Rob Herring wrote:
> On Thu, Jan 27, 2022 at 03:07:12PM -0800, Brian Norris wrote:
> > I want to add, deprecate, and bugfix some properties, as well as add the
> > first users. This is easier with a proper schema.
> > 
> > The transformation is mostly straightforward, plus a few notable tweaks:
> > 
> >  * Renamed rockchip,dram_speed_bin to rockchip,ddr3_speed_bin. The
> >    driver code and the example matched, but the description was
> >    different. I went with the implementation.

...

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.yaml
> > @@ -0,0 +1,293 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/devfreq/rk3399_dmc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Rockchip rk3399 DMC (Dynamic Memory Controller) device
> > +
> > +maintainers:
> > +  - Brian Norris <briannorris@chromium.org>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - rockchip,rk3399-dmc
> > +
> > +  devfreq-events:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    minItems: 1
> 
> What's the max?
> 
> If this is just phandles (no arg cells), then you need:
> 
> items:
>   maxItems: 1
> 
> IOW, fully describe the number of entries and cells for each entry.

We only need 1, with no args. Will add |maxItems|.

> > +    description:
> > +      Node to get DDR loading. Refer to
> > +      Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt.
> > +
> > +  clocks:
> > +    maxItems: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: dmc_clk
> > +
> > +  operating-points-v2: true
> > +
> > +  center-supply:
> > +    description:
> > +      DMC regulator supply.
> > +
> > +  rockchip,pmu:
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +    description:
> > +      Phandle to the syscon managing the "PMU general register files".
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +    description:
> > +      The CPU interrupt number. It should be a DCF interrupt. When DDR DVFS
> > +      finishes, a DCF interrupt is triggered.
> > +
> > +  rockchip,ddr3_speed_bin:
> 
> Since you are changing this, s/_/-/

I'm only including this because the driver already supports the
rockchip,ddr3_speed_bin spelling. But I'm also deprecating it (because
it's not really needed) and removing it later in the series. I'd rather
not change the spelling again in the middle, when it doesn't really have
any net effect.

I can add some clarifying notes in the commit message, about impending
deprecations, so this makes a little more sense as a standalone commit.

Or if it's somehow better, I can just drop the to-be-deprecated
properties right now in the .yaml conversion? As it happens, I've seen
at least one (probably more) other YAML conversion that made breaking
changes at the same time...

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      For values, reference include/dt-bindings/clock/rk3399-ddr.h. Selects the
> > +      DDR3 cl-trp-trcd type. It must be set according to "Speed Bin" in DDR3
> > +      datasheet; DO NOT use a smaller "Speed Bin" than specified for the DDR3
> > +      being used.

Brian
