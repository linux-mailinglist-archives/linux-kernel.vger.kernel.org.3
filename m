Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A429465955
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343789AbhLAWiS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:38:18 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:42620 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234078AbhLAWiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:38:17 -0500
Received: by mail-oi1-f177.google.com with SMTP id n66so51646977oia.9;
        Wed, 01 Dec 2021 14:34:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1cxGpGuXFYT7z9IMgpvEZhppfpCtenqGacj+Q88IAEE=;
        b=sUypr9TB0Jp8sc1pFUgFpcZtMJ69f7wAJhexT8hRcgtf3WE1gYSeADvko0OMx8PFIP
         aaD6d4xB/tuFzjKziBVJBKSTYuhpYUUb02y7XJJs+f+OEujNhLEPg2sV5HHwuybnMaDb
         fUubQIJJAlX4fofA3JgWKbCbC8Rv43RTExAAoIZ5o5MJg93MDbjodAv2w7trc8HA4L41
         tLgwTmYinZDBievkockb0bK8r6QVGW3hfGurDVR0mazAGYY0F82UFnT/vKs3RVd7jXJ5
         09FNaxQb9Q5rNzKin5mg8yft2OdeZR1V6o77HgChLXy8FSgbQ0VkjO0A0yiiYe+Hkkud
         VCXQ==
X-Gm-Message-State: AOAM532hpl0kHWF+q0fAwiuQdCIy9lyb9LrKdRcxTfsx9UHWOd4ndI1Z
        e1Wn0cLsndJ3HFnsPJQ2bjdOt9YV8g==
X-Google-Smtp-Source: ABdhPJzYVbv04PWEmrUTCr7W5O/7iNRMV3i5k8Bm9QEVICIoEC+6CgArt/iFDuAT12MH7ix6AtarcQ==
X-Received: by 2002:aca:d608:: with SMTP id n8mr1145835oig.89.1638398095643;
        Wed, 01 Dec 2021 14:34:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bf17sm655019oib.27.2021.12.01.14.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:34:55 -0800 (PST)
Received: (nullmailer pid 2914345 invoked by uid 1000);
        Wed, 01 Dec 2021 22:34:54 -0000
Date:   Wed, 1 Dec 2021 16:34:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        fabrice.gasnier@foss.st.com, alain.volmat@foss.st.com,
        alsa-devel@alsa-project.org, amelie.delaunay@foss.st.com,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        devicetree@vger.kernel.org, arnaud.pouliquen@foss.st.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: stm32: i2s: add
 audio-graph-card port
Message-ID: <Yaf4jiZIp8+ndaXs@robh.at.kernel.org>
References: <20211125144053.774-1-olivier.moysan@foss.st.com>
 <20211125144053.774-2-olivier.moysan@foss.st.com>
 <1637875562.357461.2858318.nullmailer@robh.at.kernel.org>
 <237f56b3-0597-2526-a182-f1fbdd327338@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <237f56b3-0597-2526-a182-f1fbdd327338@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 11:25:27AM +0100, Olivier MOYSAN wrote:
> Hi Rob,
> 
> On 11/25/21 10:26 PM, Rob Herring wrote:
> > On Thu, 25 Nov 2021 15:40:50 +0100, Olivier Moysan wrote:
> > > The STM2 I2S DAI can be connected via the audio-graph-card.
> > > Add port entry into the bindings.
> > > 
> > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > ---
> > >   Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > 
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> > 
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> > 
> > Full log is available here: https://patchwork.ozlabs.org/patch/1559750
> > 
> > 
> > audio-controller@4000b000: 'port' does not match any of the regexes: '^port@[0-9]', 'pinctrl-[0-9]+'
> > 	arch/arm/boot/dts/stm32mp157a-dk1.dt.yaml
> > 	arch/arm/boot/dts/stm32mp157c-dk2.dt.yaml
> > 
> 
> This warning is not a new one.
> 
> The i2s2 node in stm32mp15xx-dkx.dtsi would require the following binding:
> port:
> 	$ref: audio-graph-port.yaml#
> 	unevaluatedProperties: false
> 
> However the spi binding requires to introduce a unit address:
> patternProperties:
>   '^port@[0-9]':
>     $ref: audio-graph-port.yaml#
>     unevaluatedProperties: false
> 
> The warning can be removed by re-ordering the bindings patches in the serie,
> as "additionalProperties: true" makes the check more tolerant on extra
> properties.

That's never right.

> The patch "ASoC: dt-bindings: stm32: i2s: add audio-graph-card port" can
> even be merely dropped.
> So, I suggest to resend the serie without audio-graph-card patch.

Only if you aren't using audio-graph-card.

> 
> Does it sound too permissive to you ?

I think perhaps you need to combine the schemas into 1. Or you need to 
restructure your dtsi files such that you only add spi specific 
properties when spi mode is enabled and only add i2s specific properties 
when i2s mode is enabled. Or use the /delete-property/ directive.

Rob
