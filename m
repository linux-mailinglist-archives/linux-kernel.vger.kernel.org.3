Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B66E2525306
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 18:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356706AbiELQve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 12:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356452AbiELQvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 12:51:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ADA3CA51;
        Thu, 12 May 2022 09:51:30 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Kzd4b4TCPz67M49;
        Fri, 13 May 2022 00:47:59 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 12 May 2022 18:51:28 +0200
Received: from localhost (10.81.210.133) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 17:51:27 +0100
Date:   Thu, 12 May 2022 17:51:25 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Eddie James <eajames@linux.ibm.com>
CC:     <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <lars@metafoo.de>, <jic23@kernel.org>, <miltonm@us.ibm.com>,
        David Barksdale <dbarksdale@uplogix.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: humidity: Add si7020 bindings
Message-ID: <20220512175125.00001a5a@Huawei.com>
In-Reply-To: <20220512162020.33450-2-eajames@linux.ibm.com>
References: <20220512162020.33450-1-eajames@linux.ibm.com>
        <20220512162020.33450-2-eajames@linux.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.210.133]
X-ClientProxiedBy: lhreml720-chm.china.huawei.com (10.201.108.71) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 May 2022 11:20:19 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> Document the si7020 bindings with a new "silabs,skip-reset" property.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/iio/humidity/silabs,si7020.yaml  | 47 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  |  2 -
>  2 files changed, 47 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> new file mode 100644
> index 000000000000..9bee010f8d56
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/humidity/silabs,si7020.yaml
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/humidity/silabs,si7020.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SI7020 humidity + temperature sensor
> +
> +maintainers:
> +  - David Barksdale <dbarksdale@uplogix.com>

At least cc David if you are going to commit him to maintaining this binding :)
+CC David at that address.

> +
> +description: |
> +   The Silicon Labs Si7013/20/21 Relative Humidity and Temperature Sensors
> +   are i2c devices which have an identical programming interface for
> +   measuring relative humidity and temperature.
> +
> +properties:
> +  compatible:
> +    const: silabs,si7020
> +
> +  reg:
> +    maxItems: 1
> +
> +  siliabs,skip-reset:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Disables resetting of the device during probe
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c0 {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      si7021-a20@40 {
> +        silabs,skip-reset;
> +        compatible = "silabs,si7020";
> +        reg = <0x40>;
> +      };
> +    };
> +...
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
> index e5295faef52f..47a00b478867 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -317,8 +317,6 @@ properties:
>            - sensortek,stk8ba50
>              # SGX Sensortech VZ89X Sensors
>            - sgx,vz89x
> -            # Relative Humidity and Temperature Sensors
> -          - silabs,si7020
>              # Skyworks SKY81452: Six-Channel White LED Driver with Touch Panel Bias Supply
>            - skyworks,sky81452
>              # Socionext SynQuacer TPM MMIO module

