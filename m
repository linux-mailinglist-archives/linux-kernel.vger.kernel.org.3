Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6FAD46A615
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 20:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348800AbhLFT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 14:57:26 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:33413 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348599AbhLFT5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 14:57:21 -0500
Received: by mail-ot1-f42.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso15157433otf.0;
        Mon, 06 Dec 2021 11:53:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=FEXfkV7DzfDOJwDiaMHFm7upzA8Sh7nLlaXOwLGj1BE=;
        b=VedFdf0VhLZWwtlF9+GyktKViRKs7uoBop5BDlwjKHvA5Exifb+tw+8EkBaoo59ead
         jhY6hStCWlIokNklvuowFHQzRMJKFUSUpbNtRBlpidCddwklO9ix361M1QXEOZIZ3doF
         Zurrrj1moiXGoyejG+eWgo8oc1bCwN3KcD9oG3EegxyfD76ZDO9Hz+Z6i5CUrlIfmr7q
         uQ+f+h4MyTSuEdNOFKbXQPKI9n4/0s7HNF4x7B8i1VHTj/kWXttYpF45SxzV5ZhRI0In
         NUgYg6YB3BQcOOk+jeFFIVsNxQ8lHrJeOMkT416qzF8LSrz1UUn6oQ+IUj4Kl519e12Y
         xNoA==
X-Gm-Message-State: AOAM533b36oi2syD1kzWBXZcLW8kG0ZNfsuVdajvCZU3b0wI07DbGhXr
        +dfuaRVkwPVBDsQJLXZOgXBTSzSuvQ==
X-Google-Smtp-Source: ABdhPJxqPcwZqRSvz/gvJxol+w0vc9LVGdjC/iJystk++DcVt34euIEQfUOhOsHSNlSNtMeenxx9rw==
X-Received: by 2002:a9d:67d5:: with SMTP id c21mr31326344otn.128.1638820432263;
        Mon, 06 Dec 2021 11:53:52 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e28sm2894339oiy.10.2021.12.06.11.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 11:53:51 -0800 (PST)
Received: (nullmailer pid 2482589 invoked by uid 1000);
        Mon, 06 Dec 2021 19:53:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mihail Chindris <mihail.chindris@analog.com>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        alexandru.ardelean@analog.com, broonie@kernel.org,
        Michael.Hennerich@analog.com, nuno.sa@analog.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jic23@kernel.org, dragos.bogdan@analog.com
In-Reply-To: <20211206163529.3528-1-mihail.chindris@analog.com>
References: <20211206163529.3528-1-mihail.chindris@analog.com>
Subject: Re: [RESEND, PATCH v6 1/2] dt-bindings: iio: dac: Add adi,ad3552r.yaml
Date:   Mon, 06 Dec 2021 13:53:49 -0600
Message-Id: <1638820429.528698.2482588.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Dec 2021 16:35:29 +0000, Mihail Chindris wrote:
> Add documentation for ad3552r
> 
> Signed-off-by: Mihail Chindris <mihail.chindris@analog.com>
> ---
>  .../bindings/iio/dac/adi,ad3552r.yaml         | 190 ++++++++++++++++++
>  1 file changed, 190 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml:64:11: [warning] wrong indentation: expected 8 but found 10 (indentation)
./Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml:102:9: [warning] wrong indentation: expected 10 but found 8 (indentation)
./Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml:104:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dts:21.17-27: Warning (reg_format): /example-0/ad3552r:reg: property has invalid length (4 bytes) (#address-cells == 1, #size-cells == 1)
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dts:24.25-35: Warning (reg_format): /example-0/ad3552r/channel@0:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dts:28.25-35: Warning (reg_format): /example-0/ad3552r/channel@1:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dts:19.17-36.13: Warning (unit_address_vs_reg): /example-0/ad3552r: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dt.yaml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dt.yaml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dt.yaml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dt.yaml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dt.yaml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dts:23.27-26.19: Warning (avoid_default_addr_size): /example-0/ad3552r/channel@0: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dts:23.27-26.19: Warning (avoid_default_addr_size): /example-0/ad3552r/channel@0: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dts:27.27-35.17: Warning (avoid_default_addr_size): /example-0/ad3552r/channel@1: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dts:27.27-35.17: Warning (avoid_default_addr_size): /example-0/ad3552r/channel@1: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/dac/adi,ad3552r.example.dt.yaml: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1564044

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

