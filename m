Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AADA473604
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242946AbhLMUfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:35:45 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42657 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238005AbhLMUfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:35:44 -0500
Received: by mail-oi1-f181.google.com with SMTP id n66so24717457oia.9;
        Mon, 13 Dec 2021 12:35:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AxSFGAofOwMIAYDCCLSObSduTWGbW1+gxYdw/nwgbn8=;
        b=Zm2wkuFAN+iiV7YbHL8bYE/GpsM7TI5+ULW0djpeMs4k6f7j4nREF5d5zx53I56KiH
         m+vfk1SoVklkeVYJUmdO60sCxI7easqKevvgLuTONe5lHwKwDsKboFtcVSlVJ1QjxtAu
         gvJXqDMp/0Dod9YYRyP+VndlxzHiP/zFnv7YqU/p8W2h81SiptRsnehYkwPnBuAZvE2M
         r1oVda1ogq8W+ET9V9JurDPhlupPx1AaQFMiIkT1JsvdTnNMjvCxGKg+Nts92PrPy3+Y
         ETXaIlX73oAjUAD/Yf/Pb8BYntboTonNcC4s6DttWz5yvvO06pzfvsZBM0k3/9++m6U+
         Ipng==
X-Gm-Message-State: AOAM530aZuiTxW0b0kBrqqucMroTHoJYjTzT8+Pyrf6MyvqQXzavnMsY
        nG9z61k52TAGAyLOZ2qkkseEk5Rgkw==
X-Google-Smtp-Source: ABdhPJw7qa4AuHZj7EbN/+1qNf7EXChlDMQ/Ktbo40SMyKH7L4Hvz/la/8EklTYV0aHyX/NY6RRJLA==
X-Received: by 2002:a05:6808:1311:: with SMTP id y17mr843858oiv.32.1639427743733;
        Mon, 13 Dec 2021 12:35:43 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a16sm2338828otj.79.2021.12.13.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:35:43 -0800 (PST)
Received: (nullmailer pid 1526832 invoked by uid 1000);
        Mon, 13 Dec 2021 20:35:42 -0000
Date:   Mon, 13 Dec 2021 14:35:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ariel D'Alessandro <ariel.dalessandro@collabora.com>
Cc:     perex@perex.cz, festevam@gmail.com, michael@amarulasolutions.com,
        Xiubo.Lee@gmail.com, devicetree@vger.kernel.org,
        bcousson@baylibre.com, broonie@kernel.org,
        kuninori.morimoto.gx@renesas.com, lgirdwood@gmail.com,
        shengjiu.wang@gmail.com, tiwai@suse.com,
        linuxppc-dev@lists.ozlabs.org, tony@atomide.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, nicoleotsuka@gmail.com,
        robh+dt@kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: sound: Rename tlv320aic31xx-micbias as
 tlv320aic31xx
Message-ID: <YbeunvMNmyDxGrLb@robh.at.kernel.org>
References: <20211203134930.128703-1-ariel.dalessandro@collabora.com>
 <20211203134930.128703-2-ariel.dalessandro@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211203134930.128703-2-ariel.dalessandro@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 10:49:27 -0300, Ariel D'Alessandro wrote:
> Let's use a more generic name, so other definitions for tlv320aic31xx
> can be included.
> 
> Signed-off-by: Ariel D'Alessandro <ariel.dalessandro@collabora.com>
> ---
>  .../devicetree/bindings/sound/tlv320aic31xx.txt          | 2 +-
>  arch/arm/boot/dts/am43x-epos-evm.dts                     | 2 +-
>  include/dt-bindings/sound/tlv320aic31xx-micbias.h        | 9 ---------
>  include/dt-bindings/sound/tlv320aic31xx.h                | 9 +++++++++
>  sound/soc/codecs/tlv320aic31xx.c                         | 2 +-
>  5 files changed, 12 insertions(+), 12 deletions(-)
>  delete mode 100644 include/dt-bindings/sound/tlv320aic31xx-micbias.h
>  create mode 100644 include/dt-bindings/sound/tlv320aic31xx.h
> 

Acked-by: Rob Herring <robh@kernel.org>
