Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EF1476282
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 21:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhLOUBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 15:01:06 -0500
Received: from mail-oi1-f171.google.com ([209.85.167.171]:41689 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbhLOUBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 15:01:05 -0500
Received: by mail-oi1-f171.google.com with SMTP id u74so33164189oie.8;
        Wed, 15 Dec 2021 12:01:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l+xFFfLKiEhkrb+S6WEQGs0sRTxxdeIwUbUb4lHfegA=;
        b=IjtChSY3QrUXmsGoBEoBhSJf9Hlf2jhSRr8VO+S8T4hrjtakky2+1IvDO8SHYL4/8O
         zCqHECv3aRryJkKuttXi3OnpgYE1GjNxWlJkhWczWEJZFDC77mlmpXlK18BIgjvvrQzV
         9FRCheNbX/fMmxZTQ2XCQrORf/MmKthWBzxudd5o2/1yq4H8OvhouoiaEc7yqGEzQHQV
         xdTFqyFLentoaDJXs63+hT5+dhyqphltCwF8NoWjRYrXD/S+d3KgM5A8enDEGf8Nl1Fy
         yUcv/j39SFB7Pyq5jETKF+qOUSGjOwylPJWW+sfA1hzN3Nt2D3rBfhsUQyzf8+fv099S
         GiYA==
X-Gm-Message-State: AOAM532PJPZVWglpNbTBQrhjw5iXTDw8yYPVwwGCm0QrL8rglSvU3PQg
        Ix5ihxIbyuLKOB2izwTGqA==
X-Google-Smtp-Source: ABdhPJxU2SELg23Wszu5aa+Iw/ImO+xlHwegqhlZfMXLPwQKMl+VsUMi/yrDwMV249upMHcpSYQ0hA==
X-Received: by 2002:aca:2b02:: with SMTP id i2mr1350825oik.140.1639598464509;
        Wed, 15 Dec 2021 12:01:04 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e4sm531117oiy.12.2021.12.15.12.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 12:01:03 -0800 (PST)
Received: (nullmailer pid 1740176 invoked by uid 1000);
        Wed, 15 Dec 2021 20:01:02 -0000
Date:   Wed, 15 Dec 2021 14:01:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        ~okias/devicetree@lists.sr.ht, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2] dt-bindings: sound: nvidia,tegra-audio: Convert
 multiple txt bindings to yaml
Message-ID: <YbpJflKptK3f0EqZ@robh.at.kernel.org>
References: <20211211224946.79875-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211224946.79875-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2021 23:49:44 +0100, David Heidelberg wrote:
> Convert Tegra audio complex with the
>   * ALC5632
>   * MAX98090
>   * RT5640
>   * RT5677
>   * SGTL5000
>   * TrimSlice
>   * WM8753
>   * WM8903
>   * WM9712
> codec to the YAML format.
> 
> Additional changes:
>  - added missing HPOUTL to the WM9712 codec.
>  - extended rt5677 codec with multiple pins
> 
> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - converted from one big schema into the common properties and then references to it
>  - few additional changes mentioned in commit message
>  .../sound/nvidia,tegra-audio-alc5632.txt      |  48 --------
>  .../sound/nvidia,tegra-audio-alc5632.yaml     |  74 +++++++++++++
>  .../sound/nvidia,tegra-audio-common.yaml      |  83 ++++++++++++++
>  .../sound/nvidia,tegra-audio-max98090.txt     |  53 ---------
>  .../sound/nvidia,tegra-audio-max98090.yaml    |  97 +++++++++++++++++
>  .../sound/nvidia,tegra-audio-rt5640.txt       |  52 ---------
>  .../sound/nvidia,tegra-audio-rt5640.yaml      |  85 +++++++++++++++
>  .../sound/nvidia,tegra-audio-rt5677.txt       |  67 ------------
>  .../sound/nvidia,tegra-audio-rt5677.yaml      | 103 ++++++++++++++++++
>  .../sound/nvidia,tegra-audio-sgtl5000.txt     |  42 -------
>  .../sound/nvidia,tegra-audio-sgtl5000.yaml    |  67 ++++++++++++
>  .../sound/nvidia,tegra-audio-trimslice.txt    |  21 ----
>  .../sound/nvidia,tegra-audio-trimslice.yaml   |  33 ++++++
>  .../sound/nvidia,tegra-audio-wm8753.txt       |  40 -------
>  .../sound/nvidia,tegra-audio-wm8753.yaml      |  79 ++++++++++++++
>  .../sound/nvidia,tegra-audio-wm8903.txt       |  62 -----------
>  .../sound/nvidia,tegra-audio-wm8903.yaml      |  93 ++++++++++++++++
>  .../sound/nvidia,tegra-audio-wm9712.txt       |  60 ----------
>  .../sound/nvidia,tegra-audio-wm9712.yaml      |  76 +++++++++++++
>  19 files changed, 790 insertions(+), 445 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
