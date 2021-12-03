Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D60468090
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383493AbhLCXhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:37:51 -0500
Received: from mail-oi1-f179.google.com ([209.85.167.179]:39453 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383460AbhLCXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:37:47 -0500
Received: by mail-oi1-f179.google.com with SMTP id bf8so8817170oib.6;
        Fri, 03 Dec 2021 15:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZUn8FQjnjR741tg20DRe7x9CBP4T6IYKxGJddf96ELA=;
        b=bahHkcjGCTGScl2PChNQXZiOIHCaooNteHlLJR4/0//WOmEI3p9/jBg3C8N3+jsUqQ
         YyxLDOi5vkt58Y95xH0BPJ9UkNIlH+9K4wKWn5JUkgZl9zQG/iGx9XOtiyshrzcr3umd
         kVEflZ5KWWRs5YYcRAFDscmZ6JZ879fuWgLGhJCb0rfRyrcmEhddb6MNN3wuroUqQGMX
         xMFSarKog8NegfnkiKSCcaJlST4J1kOSkWSY+q1uRqDgDXOTZietYY4mXzxvyOdoFyor
         FA/0cBvC0pz1oRF3UWlXfinbbfhvXho5QYlfQss01/3UubkdiuEVQMbrWBwDrhykrhCB
         po8Q==
X-Gm-Message-State: AOAM531afPDP4iMuAu4tujrqlUm1o1eBijr3ihk2lRPxRrXy3BnerrDw
        dsdkhWzIw4QCYFREBslqLA==
X-Google-Smtp-Source: ABdhPJy74AGa4UHO7hdrd29dN3VU/Loo392gOIOQymkwJy/3MH/KDPcfhRkKc17lGn8+nkOjPntwIA==
X-Received: by 2002:a05:6808:2392:: with SMTP id bp18mr12443295oib.89.1638574461990;
        Fri, 03 Dec 2021 15:34:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d8sm1093713oiw.24.2021.12.03.15.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:34:21 -0800 (PST)
Received: (nullmailer pid 1043007 invoked by uid 1000);
        Fri, 03 Dec 2021 23:34:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Cc:     alsa-devel@alsa-project.org,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        bjorn.andersson@linaro.org, judyhsiao@chromium.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, bgoswami@codeaurora.org,
        agross@kernel.org, plai@codeaurora.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>,
        perex@perex.cz, devicetree@vger.kernel.org, lgirdwood@gmail.com,
        linux-arm-msm@vger.kernel.org, swboyd@chromium.org,
        rohitkr@codeaurora.org, robh+dt@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org
In-Reply-To: <1638547658-22032-10-git-send-email-srivasam@codeaurora.com>
References: <1638547658-22032-1-git-send-email-srivasam@codeaurora.com> <1638547658-22032-10-git-send-email-srivasam@codeaurora.com>
Subject: Re: [PATCH v8 09/10] ASoC: dt-bindings: Add SC7280 lpass cpu bindings
Date:   Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.248037.1043006.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 21:37:37 +0530, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
> Add bindings for sc7280 lpass cpu driver which supports
> audio over i2s based speaker, soundwire based headset, msm dmics
> and HDMI Port.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  | 70 +++++++++++++++++++---
>  1 file changed, 62 insertions(+), 8 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg: [[0, 1658351616, 0, 425984], [0, 1659895808, 0, 167936]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: reg-names: ['lpass-hdmiif', 'lpass-lpaif'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: interrupts: [[0, 160, 1], [0, 268, 1]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: interrupt-names: ['lpass-irq-lpaif', 'lpass-irq-hdmi'] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.example.dt.yaml: lpass@62d80000: iommus: [[4294967295, 4128, 0], [4294967295, 4146, 0]] is too short
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,lpass-cpu.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1563323

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

