Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3541B49E416
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242146AbiA0ODN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:03:13 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:43989 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbiA0ODK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:03:10 -0500
Received: by mail-ot1-f46.google.com with SMTP id j38-20020a9d1926000000b0059fa6de6c71so2611800ota.10;
        Thu, 27 Jan 2022 06:03:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nGqKAVozOn7icaKYITMo1ImX9DZEs2FfFmM8RWbY00w=;
        b=DmFPOiadNZ1ER9qAucpN+S7LczrQRUUPZ6V5Mco21VUPcOmkgUstcNu65aH8eWWaeO
         PSC35uc7sBqIOk9yGpXWOK3Yq31YRoIKNv0pkHPFhJyksghS/vXK+QckMg2juwDa6wvc
         5Fd+Mkf3SI5G6BloWtxWsO5cGFr1eIfE6s5eEgFeLJzQ5okD8wtjqM+EwbIgEp1U/h/E
         +YGEVS4cokJCYse5iQlm1Z1ppSnwNDWStlgrV1+etvfOC3s7iGMyOzyNJ0vqpjl9WDo/
         NlsRA4tQrk6pipa0RGtLJtXJHbeGh9vQ36ksNIcN1g/3UqJb03qFqq6q64EFZ0+2ZO62
         KC/Q==
X-Gm-Message-State: AOAM533MU7hQZsLgYNn9jeIEmhvRfqC0L1so8DWCOTUXjjc8DlPRDRhH
        yG8jVFTWCyavVKW49JJX31sq3prewg==
X-Google-Smtp-Source: ABdhPJxzUuTwBszF3Lg08WmG5YnfL6szBIhS8BUAQhafTGghz3Ge7GhLBQkPe6spEuXN3Zzy+6LlbA==
X-Received: by 2002:a9d:24a1:: with SMTP id z30mr2186536ota.242.1643292190055;
        Thu, 27 Jan 2022 06:03:10 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g34sm4240519ooi.48.2022.01.27.06.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 06:03:08 -0800 (PST)
Received: (nullmailer pid 3149361 invoked by uid 1000);
        Thu, 27 Jan 2022 14:03:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220127085930.15637-1-chunfeng.yun@mediatek.com>
References: <20220127085930.15637-1-chunfeng.yun@mediatek.com>
Subject: Re: [PATCH v3] dt-bindings: nvmem: convert mtk-efuse.txt to YAML schema
Date:   Thu, 27 Jan 2022 08:03:05 -0600
Message-Id: <1643292185.232142.3149360.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jan 2022 16:59:30 +0800, Chunfeng Yun wrote:
> Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v3: add reviewed-by Rob
> 
> v2:
>   1. remove description of subnodes which is covered by nvmem.yaml suggested by Rob
>   2. change the example which is commoner than mt8173's
> ---
>  .../bindings/nvmem/mediatek,efuse.yaml        | 86 +++++++++++++++++++
>  .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ----------
>  2 files changed, 86 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
>  delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/nvmem/mediatek,efuse.example.dts:25.43-28.15: Warning (unique_unit_address_if_enabled): /example-0/efuse@11c10000/usb3-tx-imp@184: duplicate unit-address (also used in node /example-0/efuse@11c10000/usb3-rx-imp@184)
Documentation/devicetree/bindings/nvmem/mediatek,efuse.example.dts:37.45-40.15: Warning (unique_unit_address_if_enabled): /example-0/efuse@11c10000/usb3-tx-imp@186: duplicate unit-address (also used in node /example-0/efuse@11c10000/usb3-rx-imp@186)
Documentation/devicetree/bindings/nvmem/mediatek,efuse.example.dts:49.42-52.15: Warning (unique_unit_address_if_enabled): /example-0/efuse@11c10000/usb2-intr-p0@188: duplicate unit-address (also used in node /example-0/efuse@11c10000/usb2-intr-p1@188)

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1584864

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

