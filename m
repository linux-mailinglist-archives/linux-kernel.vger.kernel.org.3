Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED44534303
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 20:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343600AbiEYSdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 14:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236476AbiEYSdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 14:33:06 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3332B0D36;
        Wed, 25 May 2022 11:33:03 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id C98E15FD08;
        Wed, 25 May 2022 21:33:01 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1653503581;
        bh=tvWh1ibvCJsyGIVQLT1gENhgJ+AQlRqgCyy8xsbnb1A=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=SOhR+T1n5P/4AtlMfTu4x8p53WqEqh0DVuYZm9g4Or4kj/XLp/s9t5kf26XvGsdt6
         vd4/Z08nMNdUcmZF/2/SsgE4csUNpSWq4GCVZHH0gVSna+fmfdibBb29y4FTexVwJB
         1y2SP17MYLee2aTNYtXX3SmHjnLLALCBv9EiDl/Wk9dkK85EUSlkD0ev+VH91NF2Oq
         +qAK5FC3RJOQWgpt8SOLXINPiHC6aFwtPQ3ekf3J1SODB+dozKfRqDTHWKLC7mCmqO
         BRlpUfaFX2Wn9ZE59Yh0i+xObyjSw8uB0Mc7gYp2oopgGFkZV+aMhr41EsBJcRVlqS
         eSGqBEg1cHLWQ==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed, 25 May 2022 21:33:01 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
CC:     "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] dt-bindings: iio: accel: add dt-binding schema for
 msa311 accel driver
Thread-Topic: [PATCH v2 3/3] dt-bindings: iio: accel: add dt-binding schema
 for msa311 accel driver
Thread-Index: AQHYcGNsHieJqKs6FU67Uad334M2Aq0vuKGA
Date:   Wed, 25 May 2022 18:32:45 +0000
Message-ID: <20220525183255.lc7hmmcfj47yrxc3@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220525181532.6805-1-ddrokosov@sberdevices.ru>
 <20220525181532.6805-4-ddrokosov@sberdevices.ru>
In-Reply-To: <20220525181532.6805-4-ddrokosov@sberdevices.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F17E0A41BA3844FBDBE49EB9ACAC5FF@sberdevices.ru>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/05/25 08:39:00 #19569940
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan and Rob,

I didn't change two places which you mentioned in the v1 review, please
find my comments below.

On Wed, May 25, 2022 at 06:15:33PM +0000, Dmitry Rokosov wrote:

> +  interrupt-names:
> +    const: irq
I stay interrupt-names node here, because otherwise dt_binding_check
command shows such a warning:

=3D=3D=3D=3D
  CHECK   Documentation/devicetree/bindings/iio/accel/memsensing,msa311.exa=
mple.dt.yaml
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.ya=
ml: accelerometer@62: 'interrupt-names' does not match any of the regexes: =
'pinctrl-[0-9]+'
=3D=3D=3D=3D

I can't delete this node from the example as well, because it's required fo=
r
msa311 dts i2c irq declaration.

Please help me to resolve this problem properly if possible. If we can
ignore such warning I'll delete interrupt-names in the next patchset's
version.

> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
Properties #address-cells and #size-cells are still located in the
schema example, because otherwise dt_binding_check raises the below=20
warnings if we delete these properties:

=3D=3D=3D=3D=3D
  DTC     Documentation/devicetree/bindings/iio/accel/memsensing,msa311.exa=
mple.dt.yaml
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:2=
7.17-30: Warning (reg_format): /example-0/i2c/accelerometer@62:reg: propert=
y has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D=
 1)
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.ya=
ml: Warning (pci_device_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.ya=
ml: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.ya=
ml: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:2=
4.13-32.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #address-ce=
lls for I2C bus
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:2=
4.13-32.11: Warning (i2c_bus_bridge): /example-0/i2c: incorrect #size-cells=
 for I2C bus
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.ya=
ml: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.ya=
ml: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.ya=
ml: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:2=
5.30-31.15: Warning (avoid_default_addr_size): /example-0/i2c/accelerometer=
@62: Relying on default #address-cells value
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dts:2=
5.30-31.15: Warning (avoid_default_addr_size): /example-0/i2c/accelerometer=
@62: Relying on default #size-cells value
Documentation/devicetree/bindings/iio/accel/memsensing,msa311.example.dt.ya=
ml: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_de=
fault_addr_size'
=3D=3D=3D=3D=3D

What is best way to resolve such issues without providing #address-cells
and #size-cells values?

--=20
Thank you,
Dmitry=
