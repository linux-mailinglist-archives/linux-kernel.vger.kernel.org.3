Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD0D4659FB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353883AbhLAXwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:52:30 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:45780 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344031AbhLAXwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:52:09 -0500
Received: by mail-ot1-f52.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso37574967otf.12;
        Wed, 01 Dec 2021 15:48:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fyGAOeBxtb/YjCFPCWVtQ1oMycSzDCqhNkiAf3lW5sQ=;
        b=LEaQqCz+Pegh++FRXT8sQi0fs0lSfzCJVP89GZQj2gPyYyGlQBR0kYtwiF5EaCHwWc
         GPhszCOgl9U6G9lwS0F24swFQKMWrlN9k9VgORjg6cQ7jMFB9Zhyl4TqoAyiyXzLimUk
         8O6PQCsxU6k2vN7yADS6A4y0XSPL0H1YdspZ+zf9yTYBwcFPAgCcyyi/fgbUNtX0z7Zp
         VnIrWzzHceykN828F8vgtFetxYv/5bZ6Guj8QfmutUX+cT7U1MtkHCLyKj46bUQl8uni
         39Rs81D+7RVdzIFfYkYRrDLJ5WTsWQt/WVC01ES5r80t7J2yrchAQZz+nAi5I9cvh1WX
         G5tA==
X-Gm-Message-State: AOAM532u5f/B/2YueFd4G4kDtcsa4PYmZFBLyJ7+L6qSi+dD1UswOLhV
        odhRs3eGrG7YjR87N+Ev6w==
X-Google-Smtp-Source: ABdhPJwBi/tdif29xfYoe8iVx4zcgBRkwLZVbOdrMx5Fmu2uZy2Kzg0shDNa0g5juvB2yC9OFPvevA==
X-Received: by 2002:a05:6830:3155:: with SMTP id c21mr8637036ots.7.1638402528023;
        Wed, 01 Dec 2021 15:48:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 109sm506737otv.30.2021.12.01.15.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:48:47 -0800 (PST)
Received: (nullmailer pid 3239358 invoked by uid 1000);
        Wed, 01 Dec 2021 23:48:46 -0000
Date:   Wed, 1 Dec 2021 17:48:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Agneli <poczt@protonmail.ch>, linux-tegra@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 01/20] ASoC: dt-bindings: Add binding for Tegra20
 S/PDIF
Message-ID: <YagJ3rKTmE3xSGg4@robh.at.kernel.org>
References: <20211126161807.15776-1-digetx@gmail.com>
 <20211126161807.15776-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126161807.15776-2-digetx@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 07:17:48PM +0300, Dmitry Osipenko wrote:
> Add device-tree binding for Tegra20 S/PDIF controller.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  .../bindings/sound/nvidia,tegra20-spdif.yaml  | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml
> new file mode 100644
> index 000000000000..00240205817d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra20-spdif.yaml
> @@ -0,0 +1,85 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/nvidia,tegra20-spdif.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NVIDIA Tegra20 S/PDIF Controller
> +
> +description: |
> +  The S/PDIF controller supports both input and output in serial audio
> +  digital interface format. The input controller can digitally recover
> +  a clock from the received stream. The S/PDIF controller is also used
> +  to generate the embedded audio for HDMI output channel.
> +
> +maintainers:
> +  - Thierry Reding <treding@nvidia.com>
> +  - Jon Hunter <jonathanh@nvidia.com>
> +
> +properties:
> +  compatible:
> +    const: nvidia,tegra20-spdif
> +
> +  reg:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: spdif_out
> +      - const: spdif_in

'spdif_' is redundant.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
