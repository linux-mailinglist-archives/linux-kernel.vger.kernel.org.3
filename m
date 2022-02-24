Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ABF4C3884
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 23:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiBXWL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 17:11:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbiBXWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 17:11:26 -0500
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F27128D3B5;
        Thu, 24 Feb 2022 14:10:56 -0800 (PST)
Received: by mail-oi1-f176.google.com with SMTP id j2so5322487oie.7;
        Thu, 24 Feb 2022 14:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7jPRav2CBDz3bnsE92/TjinGeDQiDfreC+VSHQD3Hp4=;
        b=yGMUXrRivbpk5ms8Ulrem9amcPgeZDiSn96i96QJwLxI1dASGbrm9Rc6o6OVVZmS4c
         sYv/UuNDCYh6xObGILiuxomo/HSBu+lxEkOdJ1W526gP/1ToqCFY9GjUHaO+HIsiibgW
         xcX08ycOyj96pVCf+qvntvIRHhx2/TAuFgAU3GsT+q7+SzagDuSHifKbl7BJtCBCVUGl
         fic7xgkSiwmm/vDqguqRHad9nVbjyy6fe/TXdSUL1MlqLcusUk8iBLGfXFXvqg0ueiX5
         +BgWuMDyNZ9EiLYf1ijmNvG48OYbGK5QEJNfsMD8Nwp/A5uV8jwl+9d/0jCM0ImjHzPN
         iByA==
X-Gm-Message-State: AOAM530KxSMxYKh2WgVDJI5RkojBKjH9hq1KM6xuq/rRuV2y/RzBzqq4
        uwSwVxUER1+nG8k1Dvb8Hg==
X-Google-Smtp-Source: ABdhPJznW56jFcCUmuEQYwGk6nU6rHrA/vbhYqbxHRVKPXvFamDlaVIiItC6QsjgrLyazIV5oHQaxw==
X-Received: by 2002:a05:6808:bc9:b0:2d7:3078:d98d with SMTP id o9-20020a0568080bc900b002d73078d98dmr127686oik.196.1645740654999;
        Thu, 24 Feb 2022 14:10:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bl26-20020a056808309a00b002d4f48e3799sm464399oib.12.2022.02.24.14.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 14:10:53 -0800 (PST)
Received: (nullmailer pid 3679049 invoked by uid 1000);
        Thu, 24 Feb 2022 22:10:53 -0000
Date:   Thu, 24 Feb 2022 16:10:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Fitzgerald <rf@opensource.cirrus.com>
Cc:     broonie@kernel.org, kuninori.morimoto.gx@renesas.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH V2 1/2] ASoC: dt-bindings: audio-graph-port: Add
 dai-tdm-slot-width-map
Message-ID: <YhgCbKzfPXEVauwW@robh.at.kernel.org>
References: <20220217134835.282389-1-rf@opensource.cirrus.com>
 <20220217134835.282389-2-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217134835.282389-2-rf@opensource.cirrus.com>
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

On Thu, Feb 17, 2022 at 01:48:34PM +0000, Richard Fitzgerald wrote:
> Some audio hardware cannot support a fixed slot width or a slot width
> equal to the sample width in all cases. This is usually due either to
> limitations of the audio serial port or system clocking restrictions.
> 
> This property allows setting a mapping of sample widths and the
> corresponding tdm slot widths.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> ---
>  .../devicetree/bindings/sound/audio-graph-port.yaml        | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> index 476dcb49ece6..420adad49382 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> @@ -71,4 +71,11 @@ patternProperties:
>          description: CPU to Codec rate channels.
>          $ref: /schemas/types.yaml#/definitions/uint32
>  
> +      dai-tdm-slot-width-map:
> +        description: Mapping of sample widths to slot widths. For hardware that
> +          cannot support a fixed slot width or a slot width equal to sample

A variable slot width sounds like a feature, not a limitation.

> +          width. An array containing one or more pairs of values. Each pair
> +          of values is a sample_width and the corresponding slot_width.

That sounds like a matrix, not an array. N entries of 2 cells each. 

> +        $ref: /schemas/types.yaml#/definitions/uint32-array
> +

I'd think there are some constraints on the values? Slots should be at 
least 8 bits, right? A max of 2x32 bits or is there more 
than stereo within a slot? In any case, it's for sure no where near 2^32 
max.

Is there a need for specifying where in the slot the data is?

Rob
