Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 378F4465A03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353880AbhLAXyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:54:02 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:42609 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236017AbhLAXyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:54:00 -0500
Received: by mail-oi1-f182.google.com with SMTP id n66so51963138oia.9;
        Wed, 01 Dec 2021 15:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0IBjqdZEeeg77iPYkDZoFpBZRuuv2qtLrZudT3FLe2I=;
        b=s60KTOy3D9+3BDrClxJtjWWFNfZj/szpwcq0nGC5UgAf7Vtgp4LLLbJX2V3l++A2Yk
         YTZWxRiwV/li9q8mkl1ETI9MSc3PM169/V1wwmTLNWsUeLvs4vv1bkPLaKpbyf6ASCeg
         6egP2aOiJML6sf08fU0+NWOmQVFO9hztn6w0SgfSf0MGKwUCWYEI5t/YUNJ5o0rqpgc4
         JY06/wYI/POQTFX0lAtaaUGN0EgPCl79ZwYPPyet3tpD5ehXWyDGKEMWKmM7szPyeGpq
         bb68fLpO/pgmnYIW1phwwPcmYeLtFUtFe3y0J3BWa7Rw19QBg5+uUhBBKJ09dcN9DSx2
         uogw==
X-Gm-Message-State: AOAM530w0uU7qV1KQpR83GEGKdgM9FJwvLEmCliK7X1iLkA4M/kBOt90
        VeNJGhnC3fxTvM/1xXtuvA==
X-Google-Smtp-Source: ABdhPJwn2VLKRH8+XzlklXlXHqPfdqGlRUdJfpAK+ZeM72wicy129S30tZtgMgot+gs2OS7mx1lWPg==
X-Received: by 2002:a54:4019:: with SMTP id x25mr1569020oie.116.1638402639199;
        Wed, 01 Dec 2021 15:50:39 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bh12sm648367oib.25.2021.12.01.15.50.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:50:38 -0800 (PST)
Received: (nullmailer pid 3242597 invoked by uid 1000);
        Wed, 01 Dec 2021 23:50:37 -0000
Date:   Wed, 1 Dec 2021 17:50:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Agneli <poczt@protonmail.ch>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 03/20] ASoC: dt-bindings: tegra20-i2s: Document new
 nvidia,fixed-parent-rate property
Message-ID: <YagKTc61evfbvhk4@robh.at.kernel.org>
References: <20211126161807.15776-1-digetx@gmail.com>
 <20211126161807.15776-4-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126161807.15776-4-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 19:17:50 +0300, Dmitry Osipenko wrote:
> Document new nvidia,fixed-parent-rate property which instructs that this
> board wants parent clock to stay at a fixed rate. It allows to prevent
> conflicts between audio components that share same parent PLL. For
> instance, this property allows to have HDMI audio, speaker and headphones
> in the system playing audio simultaneously, which is a common pattern for
> consumer devices.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra20-i2s.yaml      | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
