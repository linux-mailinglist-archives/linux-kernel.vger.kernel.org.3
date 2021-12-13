Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6396C473601
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbhLMUfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:35:40 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:44935 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhLMUfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:35:32 -0500
Received: by mail-ot1-f41.google.com with SMTP id u18-20020a9d7212000000b00560cb1dc10bso18698731otj.11;
        Mon, 13 Dec 2021 12:35:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UjShsLmpN0SZM+m8SUUiNDWjd+SPX71KTwqzkwvysM0=;
        b=0t9YK6lZuanHzXySrhR+ntHk+RgsYp8Z7MmNfE23arkMOtwKaBlNcYyeqF6KivBYQa
         y+Dy3Y/xJvWkZNueQ0kScD6EEhhdymedREDQITXqKaq+bpE0l2NibkeHL0Bty35SgCQT
         qfxzq83ESmT1RTda4Eh3GQds1IoD9WVeNTbzrVg9YB1A4OreVA4UXORcMcd2nvuDxibX
         QLXnGFx2bWt0FnNaHxf0avKbWQuWkqXdjzhr+UHLmbdXZe/cBSZbjPGzGNfqIwwZjW7Y
         W9vyoNi+wiWT9EsUW75jbG2021wWy5XW2mRZZ3ft+BzTtrYDljY5JrM7CUjbc5cI4lXn
         3uyA==
X-Gm-Message-State: AOAM530lquzBj7WOLObH3xnBjiA/3caNir8kyH5P2LjkNPhXUVQ5DhVI
        31hmxJyWAqFmJaRiqxsJkQ==
X-Google-Smtp-Source: ABdhPJy3T03Lv6DYRee0EAteJwqi9P/4wzvwMoGsPqpWTMFq+yupuVXKZwoG097ja4/X7OvByWI01w==
X-Received: by 2002:a9d:6190:: with SMTP id g16mr742838otk.54.1639427731541;
        Mon, 13 Dec 2021 12:35:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p10sm2340679otp.53.2021.12.13.12.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:35:30 -0800 (PST)
Received: (nullmailer pid 1526504 invoked by uid 1000);
        Mon, 13 Dec 2021 20:35:29 -0000
Date:   Mon, 13 Dec 2021 14:35:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
        bcousson@baylibre.com, broonie@kernel.org, festevam@gmail.com,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        michael@amarulasolutions.com, nicoleotsuka@gmail.com,
        perex@perex.cz, shengjiu.wang@gmail.com, tiwai@suse.com,
        tony@atomide.com
Subject: Re: [PATCH 0/4] fsl-asoc-card: Add optional dt property for setting
 mclk-id
Message-ID: <YbeukcwXQueEquJZ@robh.at.kernel.org>
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 10:49:26AM -0300, Ariel D'Alessandro wrote:
> This is a follow up of patchset:
> 
>     [RFC patch 0/5] Support BCLK input clock in tlv320aic31xx

Link?

> Sound cards may allow using different main clock inputs. In the generic
> fsl-asoc-card driver, these values are hardcoded for each specific card
> configuration.
> 
> Let's make it more flexible, allowing setting mclk-id from the
> device-tree node.
> 
> Ariel D'Alessandro (4):
>   dt-bindings: sound: Rename tlv320aic31xx-micbias as tlv320aic31xx
>   dt-bindings: tlv320aic31xx: Define PLL clock inputs
>   ASoC: fsl-asoc-card: Add optional dt property for setting mclk-id

'mclk-id' is not documented.

>   ASoC: fsl-asoc-card: Remove BCLK default value for tlv320aic31xx card
> 
>  .../devicetree/bindings/sound/fsl-asoc-card.txt    |  1 +
>  .../devicetree/bindings/sound/tlv320aic31xx.txt    |  2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts               |  2 +-
>  include/dt-bindings/sound/tlv320aic31xx-micbias.h  |  9 ---------
>  include/dt-bindings/sound/tlv320aic31xx.h          | 14 ++++++++++++++
>  sound/soc/codecs/tlv320aic31xx.c                   |  2 +-
>  sound/soc/fsl/fsl-asoc-card.c                      |  7 ++++++-
>  7 files changed, 24 insertions(+), 13 deletions(-)
>  delete mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
>  create mode 100644 include/dt-bindings/sound/tlv320aic31xx.h
> 
> -- 
> 2.30.2
> 
> 
