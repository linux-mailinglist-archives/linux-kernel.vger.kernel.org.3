Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927EB47317E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240668AbhLMQUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:20:22 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:36793 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbhLMQUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:20:20 -0500
Received: by mail-oi1-f180.google.com with SMTP id t23so23824468oiw.3;
        Mon, 13 Dec 2021 08:20:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=foaS9/vOGmhYrDCkHEJqFgk/W/i+ciDcl/qtukHfgIY=;
        b=h8aez/w3P5yVQ/8ztagafzHZ6DzdSq262zwkQjjCpHb2zDGz3nDWXuUMe/8zSu6vDM
         kiRPtDLTLS1gPQkotq24FZ6r/4dgIGSPIhnrKt+taL3c4zmZX3Gj35w7jiBP80ZrO1Y2
         Wlg5RJpahwd7XP+vJXDob8AVjbstC863yGOkJV3Kd/MvqfLSyUVmDp2ncPdkNas9Tq1f
         REAehm9zTL5o0MlXZ3Bam9JVR3SZ0LjoaHVaE6qIjCvJRTopsLfBGjNdDroULDKgb1QX
         7Lr/M86e1WOw6pBtvkFkZyroJeM6wgH9k006WOMdbjYGw9UgkscATOSMCESuR7K5v4LG
         Fjuw==
X-Gm-Message-State: AOAM530olF/5lkOXllKqVzSSRrLaVw0KWswgXpGbmlFUT8ar2N0RIYxs
        H4Tls+4x1/ExC9bXjKwl0Q==
X-Google-Smtp-Source: ABdhPJyDN/nVCzH/Lacl898CvGrp6Fm08qBT2t1XDTvVYyv5lr62LNUEQm3ml8u5t9lQTTAwB7W67A==
X-Received: by 2002:a05:6808:1315:: with SMTP id y21mr28148320oiv.103.1639412419736;
        Mon, 13 Dec 2021 08:20:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bl33sm2726932oib.47.2021.12.13.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:20:19 -0800 (PST)
Received: (nullmailer pid 1139468 invoked by uid 1000);
        Mon, 13 Dec 2021 16:20:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linus.walleij@linaro.org,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        lee.jones@linaro.org, devicetree@vger.kernel.org,
        masneyb@onstation.org, robh+dt@kernel.org, sboyd@kernel.org,
        linux-pwm@vger.kernel.org
In-Reply-To: <20211213150335.51888-2-nikita@trvn.ru>
References: <20211213150335.51888-1-nikita@trvn.ru> <20211213150335.51888-2-nikita@trvn.ru>
Subject: Re: [PATCH v2 1/2] dt-bindings: pwm: Document clk based PWM controller
Date:   Mon, 13 Dec 2021 10:20:15 -0600
Message-Id: <1639412415.394392.1139467.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Dec 2021 20:03:34 +0500, Nikita Travkin wrote:
> Add YAML devicetree binding for clk based PWM controller
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
> Changes in v2:
>  - Fix the file name.
> ---
>  .../devicetree/bindings/pwm/clk-pwm.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/clk-pwm.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/clk-pwm.example.dt.yaml: pwm-flash: $nodename:0: 'pwm-flash' does not match '^pwm(@.*|-[0-9a-f])*$'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pwm/clk-pwm.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1567356

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

