Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C372E50840F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 10:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376946AbiDTIyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 04:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376828AbiDTIyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 04:54:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52231CFD5;
        Wed, 20 Apr 2022 01:51:32 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KjvVC3YPyz688Ky;
        Wed, 20 Apr 2022 16:49:07 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:51:29 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Apr
 2022 09:51:28 +0100
Date:   Wed, 20 Apr 2022 09:51:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Message-ID: <20220420095127.000059d4@Huawei.com>
In-Reply-To: <20220419154555.24191-4-ddrokosov@sberdevices.ru>
References: <20220419154555.24191-1-ddrokosov@sberdevices.ru>
        <20220419154555.24191-4-ddrokosov@sberdevices.ru>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2022 15:45:58 +0000
Rokosov Dmitry Dmitrievich <DDRokosov@sberdevices.ru> wrote:

> Introduce devicetree binding json-schema for MSA311 tri-axial,
> low-g accelerometer driver.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
Hi Dmitry and welcome to IIO.

Sign off generally matches the From: of the email.
Makes it easier for scripts to check than having different name forms.

> ---
>  .../bindings/iio/accel/memsensing,msa311.yaml      | 64 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> new file mode 100644
> index 00000000..3e4660f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/iio/accel/memsensing,msa311.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: MEMSensing digital 3-Axis accelerometer
> +
> +maintainers:
> +  - Dmitry Rokosov <ddrokosov@sberdevices.ru>
> +
> +description: |
> +  MSA311 is a tri-axial, low-g accelerometer with I2C digital output for
> +  sensitivity consumer applications. It has dynamical user selectable full
> +  scales range of +-2g/+-4g/+-8g/+-16g and allows acceleration measurements
> +  with output data rates from 1Hz to 1000Hz.
> +  Datasheet can be found at following URL
> +  https://cdn-shop.adafruit.com/product-files/5309/MSA311-V1.1-ENG.pdf
> +
> +properties:
> +  compatible:
> +    const: memsensing,msa311
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C registers address
> +
> +  interrupts:
> +    maxItems: 1
> +    description: optional I2C int pin can be freely mapped to specific func
> +
> +  interrupt-names:
> +    const: irq

For a single IRQ giving it a name isn't that useful so I would drop this.


> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>

Why have this?

> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        msa311: msa311@62 {
Generic naming required.
           accelerometer@62 {

> +            compatible = "memsensing,msa311";
> +            reg = <0x62>;
> +            interrupt-parent = <&gpio_intc>;
> +            interrupts = <29 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-names = "irq";
> +            status = "okay";

We don't often have status in the examples. 


Otherwise looks good to me.

Thanks,

Jonathan

> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c75be17..4227914 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12482,6 +12482,7 @@ MEMSENSING MICROSYSTEMS MSA311 ACCELEROMETER DRIVER
>  M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/accel/memsensing,msa311.yaml
>  F:	drivers/iio/accel/msa311.c
>  
>  MEN A21 WATCHDOG DRIVER

