Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E11149D50A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:11:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbiAZWLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:11:01 -0500
Received: from mail-ot1-f51.google.com ([209.85.210.51]:39702 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiAZWK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:10:57 -0500
Received: by mail-ot1-f51.google.com with SMTP id c3-20020a9d6c83000000b00590b9c8819aso689339otr.6;
        Wed, 26 Jan 2022 14:10:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ErA2xJGyfWSYJZEIE4ymjWq+FHZjiaQLmgdO3g2KNUc=;
        b=nNkfgUjnFJpXvcgvN4xBa4ZJNjcekXkuZiXAi19Tsa3/uc7HQQGVUVk2TFS+ycDGyo
         8pHReW14/iq+Shww4peZfxxJcSyYM9gpO+AMvKs7HUPCJIu1MgwDHmj6SjqE1Xh/ztpO
         JAusvhMZfC6AI7g3U8o00eeHNYkOllGGOtWaA11Fj4oS8UJstoYjC6y4YZXGEIza0gP2
         /Og092SYMG+x8J8sbztHb8Hg302wviO7W7ga3v7enH+CmmRJA1L2j0Yk16J2/xNYu21Q
         ClUaogwkIvmq6XjEJNTg6qqJMllpXGGmeka3V29YAzZz11z1M77iKskUB+PPaospICrA
         4LeA==
X-Gm-Message-State: AOAM532OxMOyEBam7Nv9NSneggEZaKgEPVaEihQgW3FhfjRX0OQoeQ2Y
        v7WhFW4XwLjUg9C7k9giNiw7br9xgA==
X-Google-Smtp-Source: ABdhPJxTBZ7c6Wq5DHgltU/Q1WMSaZYDKppblBxy9TQyb8u7AQ+3YgLWJ4jobGbI7xEs0woA2CBcMg==
X-Received: by 2002:a9d:4c0f:: with SMTP id l15mr538154otf.104.1643235056485;
        Wed, 26 Jan 2022 14:10:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b8sm6704762otk.36.2022.01.26.14.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:10:55 -0800 (PST)
Received: (nullmailer pid 1535098 invoked by uid 1000);
        Wed, 26 Jan 2022 22:10:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Fengping Yu <fengping.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, Fabien Parent <fparent@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-mediatek@lists.infradead.org, linux-input@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220126153519.3637496-2-mkorpershoek@baylibre.com>
References: <20220126153519.3637496-1-mkorpershoek@baylibre.com> <20220126153519.3637496-2-mkorpershoek@baylibre.com>
Subject: Re: [PATCH v19 1/3] dt-bindings: input: Add bindings for Mediatek matrix keypad
Date:   Wed, 26 Jan 2022 16:10:52 -0600
Message-Id: <1643235052.864878.1535097.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 16:35:17 +0100, Mattijs Korpershoek wrote:
> From: "fengping.yu" <fengping.yu@mediatek.com>
> 
> This patch add devicetree bindings for Mediatek matrix keypad driver.
> 
> Signed-off-by: fengping.yu <fengping.yu@mediatek.com>
> Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  .../input/mediatek,mt6779-keypad.yaml         | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml:28:13: [warning] wrong indentation: expected 14 but found 12 (indentation)
./Documentation/devicetree/bindings/input/mediatek,mt6779-keypad.yaml:43:8: [warning] wrong indentation: expected 6 but found 7 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1584526

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

