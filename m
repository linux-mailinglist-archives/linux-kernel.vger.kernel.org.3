Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13AFF47970D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:25:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbhLQWZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:25:13 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:40601 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLQWZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:25:12 -0500
Received: by mail-oi1-f181.google.com with SMTP id bk14so5700210oib.7;
        Fri, 17 Dec 2021 14:25:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=U9aFf023EtS7bYXuPYeb5jcWZtC9rXcMEmjg022T/GI=;
        b=st01DachqKh06PMLpYVqq1ksp5D/FZnrI/7UWro1F0pB7KxMOp9yGkX3WNrTU9Yait
         9QPQ8UCPVIKDtvuyYvLHcqHl1lhtVScocPvHfdD+VXXq4TrRVKA4A9MaMBAZ7vHuw87t
         Xp5xE7niL5Qf2FnnEhTYBr/Fcg21tZOPT+MuEArFnLgS7/tK1SMub4c3b+i7IQBf/N9J
         LGSaceKv3/sUL13j5eq0QgEUjIs2l2Lx2ip/8IH9ec5WsE1dDteZyh/5xDSC39ayrduR
         h9Bhk9zNjinKBcgGk7vuUTzcPw8BUU5PC9AG0ArpP4q80EFa0yWKGOuzyGxd0N5WzBtL
         w4nA==
X-Gm-Message-State: AOAM53101E9xSAChkF5q+dpJVPptPAvJii4beS1UqMT5i0wL219GI4L9
        YnX2xYt4JtjCqJh97dCo5Q==
X-Google-Smtp-Source: ABdhPJwLzRcCLzNUvJFhPi5MNnKwuPTUbgZzGPSNDn7nPA1/EtvNX7X/MV8AtNV28hgMlRxOVmyVvA==
X-Received: by 2002:a05:6808:124d:: with SMTP id o13mr3929342oiv.91.1639779911700;
        Fri, 17 Dec 2021 14:25:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e4sm1897343oiy.12.2021.12.17.14.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 14:25:10 -0800 (PST)
Received: (nullmailer pid 3686969 invoked by uid 1000);
        Fri, 17 Dec 2021 22:25:06 -0000
From:   Rob Herring <robh@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        CK Hu <ck.hu@mediatek.com>, Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>
In-Reply-To: <20211217150854.2081-3-granquet@baylibre.com>
References: <20211217150854.2081-1-granquet@baylibre.com> <20211217150854.2081-3-granquet@baylibre.com>
Subject: Re: [PATCH v7 2/8] dt-bindings: mediatek,dp: Add Display Port binding
Date:   Fri, 17 Dec 2021 16:25:06 -0600
Message-Id: <1639779906.584489.3686968.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Dec 2021 16:08:48 +0100, Guillaume Ranquet wrote:
> From: Markus Schneider-Pargmann <msp@baylibre.com>
> 
> This controller is present on several mediatek hardware. Currently
> mt8195 and mt8395 have this controller without a functional difference,
> so only one compatible field is added.
> 
> The controller can have two forms, as a normal display port and as an
> embedded display port.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../display/mediatek/mediatek,dp.yaml         | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dts:20:18: fatal error: dt-bindings/power/mt8195-power.h: No such file or directory
   20 |         #include <dt-bindings/power/mt8195-power.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/display/mediatek/mediatek,dp.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1570103

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

