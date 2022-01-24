Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E8D498416
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 17:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243411AbiAXQB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 11:01:28 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:41726 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243296AbiAXQBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 11:01:17 -0500
Received: by mail-ot1-f50.google.com with SMTP id b12-20020a9d754c000000b0059eb935359eso6545074otl.8;
        Mon, 24 Jan 2022 08:01:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=4oDy0h+Kn1sS1/A4tfxNkpnbvwT3eD0GbpthjgEWnmw=;
        b=DHYopP3v0AUi6WBKGoEZMBQbOh3pJ0WSOP4TKU6Opzb/BdwH6PYe0C8QHOxj9bkxcj
         IClELCC7gV84Rijyxl/dJRwwGAiJLitYVdnpeSQu6e00x0j8IKsHAHA+tik90cuIr9lm
         uYpSZfRbRpnsRzBSJ/KIvnaKH/h1Ub4nGB/a/xyOgxFqdvEZZaHYx9GPT6TsOizcd0Z4
         J8cnIiZjB0VFyhQUS2G6SpiCsu8PA23+tddhq9avMAQX7jf75s0ODvxorjJAsZZ4wcIP
         +k49tIFVlj55FDMi/snySiT7UV9XgeS/xFPY8YVyVMqp/RoxKxIQslmkzkNgn+2Ra0CO
         nO6Q==
X-Gm-Message-State: AOAM5301YnqAZfZ5nHHdI9Y2i9jDKHL/J3Qv35c/bysQXAWkNVvVSGP2
        +vD1qB9OGHMsJK2Gox2oxg==
X-Google-Smtp-Source: ABdhPJwRM5ALOhU/Vs9GjW7lmhl/9UMYuTfoILSHm228ySaR1KNsxNhbTvaDMWCOm/oq3fu6Ovy/Qw==
X-Received: by 2002:a9d:4b08:: with SMTP id q8mr6966159otf.181.1643040076418;
        Mon, 24 Jan 2022 08:01:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id i13sm5353082otl.46.2022.01.24.08.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 08:01:15 -0800 (PST)
Received: (nullmailer pid 3901529 invoked by uid 1000);
        Mon, 24 Jan 2022 16:01:12 -0000
From:   Rob Herring <robh@kernel.org>
To:     Caleb Connolly <caleb@connolly.tech>
Cc:     Henrik Rydberg <rydberg@bitmath.org>, linux-kernel@vger.kernel.org,
        Colin Cross <ccross@android.com>, linux-input@vger.kernel.org,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        Alexander Martinz <amartinz@shiftphones.com>,
        David Airlie <airlied@linux.ie>,
        Harigovindan P <harigovi@codeaurora.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Anton Vorontsov <anton@enomsg.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Tony Luck <tony.luck@intel.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
In-Reply-To: <20220123173650.290349-2-caleb@connolly.tech>
References: <20220123173650.290349-1-caleb@connolly.tech> <20220123173650.290349-2-caleb@connolly.tech>
Subject: Re: [PATCH 1/6] dt-bindings: input: touchscreen: add bindings for focaltech,fts
Date:   Mon, 24 Jan 2022 10:01:12 -0600
Message-Id: <1643040072.587317.3901528.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Jan 2022 17:37:27 +0000, Caleb Connolly wrote:
> Add devicetree bindings for the Focaltech FTS touchscreen drivers.
> 
> Signed-off-by: Caleb Connolly <caleb@connolly.tech>
> ---
>  .../input/touchscreen/focaltech,fts.yaml      | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.example.dts:21.9-14 syntax error
FATAL ERROR: Unable to parse input tree
make[1]: *** [scripts/Makefile.lib:378: Documentation/devicetree/bindings/input/touchscreen/focaltech,fts.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1398: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1583161

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

