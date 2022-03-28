Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E694E8C51
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 04:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiC1CvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 22:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237686AbiC1CvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 22:51:06 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B4443AF7;
        Sun, 27 Mar 2022 19:49:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D6E141F42E8E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648435765;
        bh=WBy+NdgrMIzJ3AKUedzuJEhPjlvydZ03Twj00zAxYz4=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=U3HkSb6POVvUJbAp6jHygGoEOaVyoi8l0Klzz5SmXmhTVofrR1p1nTiR+uWW5jdqX
         UN1KUGIcImPUaXDtH2vuW52wos7Og6P7mKML3/LZ/qCU5TTOOQut7je/MyJ2uIFUHD
         /7yLlGkpB3nOgw96VAIRUmok/5+jzodHVky0vKDI4X0e12zlBvIahqpgAFKL33ibpN
         v5jXh3msmHzjAqTIa4+7gRLRjNRmG7YGV6QwmiJrSE+jZN+/PRYrw09zdD+7V5ZF6h
         WPCikNH/4djTYKBlbTAlaoH2olFO8fW/T99NL973+iDEDG6OwVickaV+KHI715hBMA
         EcWrj3LAdcEQg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>, lars@metafoo.de,
        robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
Subject: Re: [PATCH 2/3] dt-bindings: Document ltrf216a light sensor bindings
Organization: Collabora
References: <20220325103014.6597-1-shreeya.patel@collabora.com>
        <20220325103014.6597-3-shreeya.patel@collabora.com>
        <20220327145511.2d36dd10@jic23-huawei>
Date:   Sun, 27 Mar 2022 22:49:20 -0400
In-Reply-To: <20220327145511.2d36dd10@jic23-huawei> (Jonathan Cameron's
        message of "Sun, 27 Mar 2022 14:55:11 +0100")
Message-ID: <87czi6ssen.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Cameron <jic23@kernel.org> writes:

> On Fri, 25 Mar 2022 16:00:13 +0530
> Shreeya Patel <shreeya.patel@collabora.com> wrote:
>
>> Add devicetree bindings for ltrf216a ambient light sensor
>> 
>> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> Hi Shreeya,
>
> As we are making this Zhigang Shi's problem to maintain, I'm 
> looking for an ack.  Bit mean otherwise :)

Alternatively, Shreeya could take over the maintainership of this
schema, since she wrote it. :)

>
> Except for the deprecated part this could just have gone in
> trivial-bindings.yaml.
>
> I guess you don't need it for your existing board, but best
> practice would probably include ensuring whatever supplies
> the device needs are here so that platforms that don't enable
> them by default can turn them on.
>
> Also, there is an interrupt according to the datasheet linked
> from patch 3 and that should definitely be in the binding
> even if the driver isn't using it.
>
> Jonathan
>
>
>> ---
>>  .../bindings/iio/light/liteon,ltrf216a.yaml   | 42 +++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
>> 
>> diff --git a/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
>> new file mode 100644
>> index 000000000000..275d86a0353a
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/light/liteon,ltrf216a.yaml
>> @@ -0,0 +1,42 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/iio/light/liteon,ltrf216a.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: LTRF216A Ambient Light Sensor
>> +
>> +maintainers:
>> +  - Zhigang Shi <Zhigang.Shi@liteon.com>
>> +
>> +description: |
>> +  Ambient sensing with an i2c interface.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - liteon,ltrf216a
>> +      - ltr,ltrf216a
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c {
>> +
>> +        #address-cells = <1>;
>> +        #size-cells = <0>;
>> +
>> +        light-sensor@53 {
>> +                compatible = "ltr,ltrf216a";
>> +                reg = <0x53>;
>> +        };
>> +    };
>> +...
>

-- 
Gabriel Krisman Bertazi
