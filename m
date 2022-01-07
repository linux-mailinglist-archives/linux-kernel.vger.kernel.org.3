Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF55487CB2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 20:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiAGTBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 14:01:14 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:40885 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiAGTBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 14:01:13 -0500
Received: by mail-oi1-f170.google.com with SMTP id t204so9443630oie.7;
        Fri, 07 Jan 2022 11:01:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=M9Ewz3je/UPVYnHWZBwxIw8fSnK7ld3cFu23OJRs32o=;
        b=QSaiHZcUjaBlieoGO4ml/wWDA+vMLHMr1IjWVXohsvog7agq7DAsdQ9enlnOatOTr4
         rc7S/torPYNqCv7cOI4aoTVd6/PwhvzNrU06C7p+UUlxIryJp5C2jC5dVpVySHSdjZxT
         KlbqjYlwqzj57oRGQzAAfD9j4NMZAC/pv6THl04Omrb5OxklmR5+KxUKcGUVIYU29Qgj
         uSYUA1UaVTib58btL9+uMT5j0NS6pIVtlc1c63OfgLjoAbPshDiC/ype0evbCVLROarC
         TlTTMat8KlMVUx0eh7hzagSXVFgA2D5Q8lUw9Jo0o2VbebK2s/qBJohPcTFMrB6srYR2
         OD3Q==
X-Gm-Message-State: AOAM530eoln2lOrLfRhkfYCitqP610cMiw+5Zp163gRiNXiEepox2zyi
        xo/UOVwVJDoBrFUyzLPl6A==
X-Google-Smtp-Source: ABdhPJxquTndMbNj9kp8gfIWlQVYbrUBHSB+Weu7q94ndIncJ7r49i9m0gMX0OQlKB+LamGTAe7UxA==
X-Received: by 2002:a05:6808:13ce:: with SMTP id d14mr10955251oiw.62.1641582073051;
        Fri, 07 Jan 2022 11:01:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id be30sm1117011oib.50.2022.01.07.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 11:01:12 -0800 (PST)
Received: (nullmailer pid 3702049 invoked by uid 1000);
        Fri, 07 Jan 2022 19:01:11 -0000
From:   Rob Herring <robh@kernel.org>
To:     Roger Lu <roger.lu@mediatek.com>
Cc:     HenryC Chen <HenryC.Chen@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Charles Yang <Charles.Yang@mediatek.com>,
        linux-pm@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Angus Lin <Angus.Lin@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>
In-Reply-To: <20220107095200.4389-2-roger.lu@mediatek.com>
References: <20220107095200.4389-1-roger.lu@mediatek.com> <20220107095200.4389-2-roger.lu@mediatek.com>
Subject: Re: [PATCH v21 1/8] dt-bindings: soc: mediatek: add mtk svs dt-bindings
Date:   Fri, 07 Jan 2022 13:01:11 -0600
Message-Id: <1641582071.084026.3702048.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Jan 2022 17:51:53 +0800, Roger Lu wrote:
> Document the binding for enabling mtk svs on MediaTek SoC.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/soc/mediatek/mtk-svs.yaml        | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml: properties:nvmem-cells: {'minItems': 1, 'maxItems': 2, 'description': 'Phandle to the calibration data provided by a nvmem device.', 'items': [{'description': 'SVS efuse for SVS controller'}, {'description': 'Thermal efuse for SVS controller'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/soc/mediatek/mtk-svs.yaml: ignoring, error in schema: properties: nvmem-cells
Documentation/devicetree/bindings/soc/mediatek/mtk-svs.example.dt.yaml:0:0: /example-0/soc/svs@1100b000: failed to match any schema with compatible: ['mediatek,mt8183-svs']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1576508

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

