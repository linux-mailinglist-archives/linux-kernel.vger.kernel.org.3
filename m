Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E05465A00
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353877AbhLAXxh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:53:37 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:33546 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbhLAXxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:53:31 -0500
Received: by mail-ot1-f41.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso37701955otf.0;
        Wed, 01 Dec 2021 15:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AAKdEKP97Ls7n7IAvtp5z2iqSUT8MEQ6F41F7W+0AQ4=;
        b=MaV2bxuxLjlaKEptfG/mkI0t2j1P67rfodY+onRyAwG1ThGZEZuym1unrtUMwHqg1C
         HCIjSyfqXY8UOBCSrgkvUf0BEBRgFDWWwXYl9ZNKkMPYRq1vCjKAiyVQKq8VV0HvcfQc
         9m4HBzYcJ/T+ceDinKLs+kshn8deRSkowd9u71w7VdP3iCnWkCLkTmM3q3RKUBO9DcbB
         PIDMROcUHluGxADipQo2Yy4e6ci91JXSDC+eLxtlDGD/D8HgMmBQnnHK2xNvjOPvSlJw
         tME91FxcOxqBX1+o3ajvXJ4uGGXZ0uc0bU8Lf2Vspl7sXBVJ8v2WcKpmFDr8Gq1V6ZSg
         bFyg==
X-Gm-Message-State: AOAM53087H1fBl+U7jS+h7SQZNOv4Qr+jOFHJKGAFm4WfEgonBXsvQ+i
        xcZRTnHuNipGqSkg/KHIzw==
X-Google-Smtp-Source: ABdhPJwFGco+ndtzGH+H4l80NmfjEg0wHDCC2Paa28Apu7hnxPttflAx+Rqn/6LnLcW4bvBsRHXMjQ==
X-Received: by 2002:a9d:24c3:: with SMTP id z61mr8751119ota.100.1638402609383;
        Wed, 01 Dec 2021 15:50:09 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e14sm603686oow.3.2021.12.01.15.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:50:08 -0800 (PST)
Received: (nullmailer pid 3241728 invoked by uid 1000);
        Wed, 01 Dec 2021 23:50:07 -0000
Date:   Wed, 1 Dec 2021 17:50:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     linux-tegra@vger.kernel.org, alsa-devel@alsa-project.org,
        Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Agneli <poczt@protonmail.ch>, Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v2 02/20] ASoC: dt-bindings: tegra20-i2s: Convert to
 schema
Message-ID: <YagKL2mSy0miICW0@robh.at.kernel.org>
References: <20211126161807.15776-1-digetx@gmail.com>
 <20211126161807.15776-3-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126161807.15776-3-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2021 19:17:49 +0300, Dmitry Osipenko wrote:
> Convert NVIDIA Tegra20 I2S binding to schema.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/sound/nvidia,tegra20-i2s.txt     | 30 --------
>  .../bindings/sound/nvidia,tegra20-i2s.yaml    | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-i2s.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
