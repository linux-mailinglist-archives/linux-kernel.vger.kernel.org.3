Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8C489DD5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237718AbiAJQtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:49:04 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:43992 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237707AbiAJQtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:49:03 -0500
Received: by mail-oo1-f54.google.com with SMTP id z20-20020a4a3054000000b002dbfaf0b568so3698992ooz.10;
        Mon, 10 Jan 2022 08:49:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=UE8yD5Ct/F6dHlrHLAV9VNma1gP2lMc+7CQcqBSce8s=;
        b=3Dy13qjlJ345E0CJorSgZChrd79+LrcrEHqQFt67/ViERIDxm7zggJJ9CGlp6+9J5M
         LKWTJfKsJmUIiWMM8ruMgx1xh9D23qFHF+MRYpkXtT1GyL70dRjIsvPjkrQku16mCqfx
         ie85B2P8c4ezv5w8Vi0j7eBduefTWdStI++OuKdsz5IfkHNY75kkzOECpw5Hk1GWwOyz
         uDgCQTyV/wP7wPp0kzxUvQXYZHeucG3R56UHDWwGgQH3Zonjy4laIJWaqsxvG0xxZHk5
         6v0XpGBUmShGpHhp0JU2hNfAlsc5QkAYikVD9zmXLygDTrfZbAwBx2s5mLwhX15TLFHo
         nhgA==
X-Gm-Message-State: AOAM533tlSUFNf/W8GFras+GA2wowePA0832bgJekYV8cj5lJw3w707Q
        az+I9XCR/pAE1ReKZirfaA==
X-Google-Smtp-Source: ABdhPJyAQKG9qcTs+ZJVuMZ/jvEd8orfRKAYQTVMvMNX+7d4dfJqitUbb9xMHJqKbaljkyvpyqBEgQ==
X-Received: by 2002:a4a:51c5:: with SMTP id s188mr441999ooa.44.1641833342522;
        Mon, 10 Jan 2022 08:49:02 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v23sm1585676otn.42.2022.01.10.08.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 08:49:01 -0800 (PST)
Received: (nullmailer pid 1067454 invoked by uid 1000);
        Mon, 10 Jan 2022 16:48:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Leilk Liu <leilk.liu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org
In-Reply-To: <20220110053744.30323-1-leilk.liu@mediatek.com>
References: <20220110053744.30323-1-leilk.liu@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Convert spi-mt65xx & spi-slave-mt27xx to json-schema
Date:   Mon, 10 Jan 2022 10:48:59 -0600
Message-Id: <1641833339.690847.1067453.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 13:37:43 +0800, Leilk Liu wrote:
> Convert Mediatek ARM SOC's SPI Master & Slave controller binding
> to json-schema format.
> 
> Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
> ---
>  .../bindings/spi/mediatek,spi-mt65xx.yaml     | 96 +++++++++++++++++++
>  .../spi/mediatek,spi-slave-mt27xx.yaml        | 69 +++++++++++++
>  .../devicetree/bindings/spi/spi-mt65xx.txt    | 68 -------------
>  .../bindings/spi/spi-slave-mt27xx.txt         | 33 -------
>  4 files changed, 165 insertions(+), 101 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-mt65xx.txt
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-slave-mt27xx.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml: properties:compatible:oneOf: [{'const': 'mediatek,mt2712-spi-slave'}, {'const': 'mediatek,mt8195-spi-slave'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.yaml: ignoring, error in schema: properties: compatible: oneOf
Documentation/devicetree/bindings/spi/mediatek,spi-slave-mt27xx.example.dt.yaml:0:0: /example-0/spi@10013000: failed to match any schema with compatible: ['mediatek,mt2712-spi-slave']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1577767

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

