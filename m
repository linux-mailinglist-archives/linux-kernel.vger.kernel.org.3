Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F639475C53
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 16:54:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244221AbhLOPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 10:54:32 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:33281 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhLOPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 10:54:28 -0500
Received: by mail-oi1-f169.google.com with SMTP id q25so32363469oiw.0;
        Wed, 15 Dec 2021 07:54:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zB05uvrK2/mEzUciLS+bKWO3c1fIFvaHWmaH0UeNMm0=;
        b=L2OOvxRWlr5XcmMxkNZNAplyxrSJoAsx58LkWN2vWwBcSGqZ0QgKhZ/89hL2Njto9p
         GLReNoJKIDEsOMKL8972qqoavZZMMKLFflTnsiSLA06EobfukbYWz64tUgKWOntufY4x
         y/w4H0Nxy7qwxhhSn9WBwytwRz8CRqVX3Md1RRQqEWo3VmD8O/xmjVenM6WcFFJGew5R
         +3JlKDXGomxpIol4eRPD611pz/3DMeO81P68suJpq2+pSb7C5zk2b+PmENBZHGWASlW5
         Kg7dEP+EYTNgxZzYo5/9FvJQILbduWNvo1IrnDmYMOtga0Y/AODD41nfN0WrdAeHE25E
         E5Yg==
X-Gm-Message-State: AOAM5316ypkrVX0vARsoKivQ4d67cdwISfUV5Ge4qFl/b9yMR1pu8vjX
        45OjbzfZ3N2llgU17oMHgg==
X-Google-Smtp-Source: ABdhPJwt3PSmVOrPf+jSGTFmZdNW9R948zXLu1Xbxnf227I08Idq9IEqxexRuf6nOoZ0FYrn277B6Q==
X-Received: by 2002:aca:d606:: with SMTP id n6mr383859oig.76.1639583668114;
        Wed, 15 Dec 2021 07:54:28 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c9sm528923oog.43.2021.12.15.07.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 07:54:27 -0800 (PST)
Received: (nullmailer pid 1383662 invoked by uid 1000);
        Wed, 15 Dec 2021 15:54:26 -0000
Date:   Wed, 15 Dec 2021 09:54:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: accel: add ADXL367
Message-ID: <YboPssR4TaxBFkBq@robh.at.kernel.org>
References: <20211207094337.59300-1-cosmin.tanislav@analog.com>
 <20211207094337.59300-2-cosmin.tanislav@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207094337.59300-2-cosmin.tanislav@analog.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 11:43:36AM +0200, Cosmin Tanislav wrote:
> The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> 
> The ADXL367 does not alias input signals to achieve ultralow power
> consumption, it samples the full bandwidth of the sensor at all
> data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> with a resolution of 0.25mg/LSB on the +-2 g range.
> 
> In addition to its ultralow power consumption, the ADXL367
> has many features to enable true system level power reduction.
> It includes a deep multimode output FIFO, a built-in micropower
> temperature sensor, and an internal ADC for synchronous conversion
> of an additional analog input.
> 
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>
> ---
>  .../bindings/iio/accel/adi,adxl367.yaml       | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> new file mode 100644
> index 000000000000..b3c140dfbe2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/accel/adi,adxl367.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices ADXL367 3-Axis Digital Accelerometer
> +
> +maintainers:
> +  - Cosmin Tanislav <cosmin.tanislav@analog.com>
> +
> +description: |
> +  The ADXL367 is an ultralow power, 3-axis MEMS accelerometer.
> +
> +  The ADXL367 does not alias input signals by to achieve ultralow power
> +  consumption, it samples the full bandwidth of the sensor at all
> +  data rates. Measurement ranges of +-2g, +-4g, and +-8g are available,
> +  with a resolution of 0.25mg/LSB on the +-2 g range.
> +
> +  In addition to its ultralow power consumption, the ADXL367
> +  has many features to enable true system level power reduction.
> +  It includes a deep multimode output FIFO, a built-in micropower
> +  temperature sensor, and an internal ADC for synchronous conversion
> +  of an additional analog input.
> +    https://www.analog.com/en/products/adxl367.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adxl367
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  spi-max-frequency: true
> +
> +  vdd-supply: true
> +  vddio-supply: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adxl367@53 {
> +        compatible = "adi,adxl367";
> +        reg = <0x53>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +      };
> +    };
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    spi {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      adxl367@0 {

accelerometer@0

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +        compatible = "adi,adxl367";
> +        reg = <0>;
> +        spi-max-frequency = <1000000>;
> +        interrupt-parent = <&gpio>;
> +        interrupts = <25 IRQ_TYPE_EDGE_RISING>;
> +      };
> +    };
> -- 
> 2.34.1
> 
> 
