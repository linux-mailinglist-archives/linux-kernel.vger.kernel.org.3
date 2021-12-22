Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2837747D7D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 20:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345277AbhLVThR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 14:37:17 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]:41812 "EHLO
        mail-qt1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhLVThQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 14:37:16 -0500
Received: by mail-qt1-f171.google.com with SMTP id v22so2907558qtx.8;
        Wed, 22 Dec 2021 11:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ms1GIPZs1ev5xEZpY6o8FR181sPVC1wSUgdaLlJTuns=;
        b=TbKK+9JOr9o2/nmLkb7Q16j1Fvg7Df48OJaD0xdYog+PywW3t5nRFQPMLbRbpCCcAQ
         3qvKy3dVGAMQY7hhIDQ9TaQWybRngk2+NM27taQ4SSRz40dIofTk2qhWCwLgkWdBzkeZ
         gyvI4/tPd63GtNHYsPhaEzPL1aKaTh8X6DorwaY9r/MrY5lgswF/QaUY2h0uVheTX8Az
         wVqDWid9D8lqijrQ3ZH8026CizrfuAyuIuxs3VtbByDVV5e5uFgmJ9GCUWg4nrVThuJr
         Rmriir1S/uKHKr3xLMKZmK2AX3PCtm8/bsIpRZ7hxcADmRFv7CzP6uNX7SJYBEQ7n3gp
         qr8w==
X-Gm-Message-State: AOAM531yo8/HG7aGJXq0/GhAuw5+6gOo6PBQlNmXIjwz+5+hp/b2Sg3L
        WPLO5qB4FjF5zzP3pqul+w==
X-Google-Smtp-Source: ABdhPJwrLYiMPJ95THVOxGleq3xFEWYS0SX9m4H7pLPhWxL+hwnKGMoLI6mBWWxqwPKqeakTQYf+EQ==
X-Received: by 2002:a05:622a:15ca:: with SMTP id d10mr3365524qty.81.1640201835775;
        Wed, 22 Dec 2021 11:37:15 -0800 (PST)
Received: from robh.at.kernel.org ([24.55.105.145])
        by smtp.gmail.com with ESMTPSA id az16sm2868691qkb.124.2021.12.22.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 11:37:15 -0800 (PST)
Received: (nullmailer pid 2575737 invoked by uid 1000);
        Wed, 22 Dec 2021 19:37:13 -0000
Date:   Wed, 22 Dec 2021 15:37:13 -0400
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com,
        thierry.reding@gmail.com, perex@perex.cz, jonathanh@nvidia.com,
        digetx@gmail.com, mkumard@nvidia.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: sound: tegra: Update HDA resets
Message-ID: <YcN+aYRXKK7HRmqz@robh.at.kernel.org>
References: <1640147751-4777-1-git-send-email-spujar@nvidia.com>
 <1640147751-4777-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1640147751-4777-3-git-send-email-spujar@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 10:05:50AM +0530, Sameer Pujar wrote:
> Tegra194 HDA has only two resets unlike the previous generations of
> Tegra SoCs. Hence update the reset list accordingly.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml       | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> index b55775e..70dbdff5 100644
> --- a/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> +++ b/Documentation/devicetree/bindings/sound/nvidia,tegra30-hda.yaml
> @@ -50,13 +50,18 @@ properties:
>        - const: hda2codec_2x
>  
>    resets:
> +    minItems: 2
>      maxItems: 3
>  
>    reset-names:

Just add 'minItems: 2' here instead.

> -    items:
> -      - const: hda
> -      - const: hda2hdmi
> -      - const: hda2codec_2x
> +    oneOf:
> +      - items:
> +          - const: hda
> +          - const: hda2hdmi
> +          - const: hda2codec_2x
> +      - items:
> +          - const: hda
> +          - const: hda2hdmi
>  
>    power-domains:
>      maxItems: 1
> -- 
> 2.7.4
> 
> 
