Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18C5756E0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 23:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240820AbiGNV1I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 17:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240795AbiGNV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 17:27:06 -0400
Received: from smtp-out3.electric.net (smtp-out3.electric.net [208.70.128.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D62B6D9FF;
        Thu, 14 Jul 2022 14:27:05 -0700 (PDT)
Received: from 1oC6MM-00090K-WA by out3b.electric.net with emc1-ok (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1oC6MQ-00096c-U9; Thu, 14 Jul 2022 14:27:02 -0700
Received: by emcmailer; Thu, 14 Jul 2022 14:27:02 -0700
Received: from [66.210.251.27] (helo=mail.embeddedts.com)
        by out3b.electric.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <kris@embeddedTS.com>)
        id 1oC6MM-00090K-WA; Thu, 14 Jul 2022 14:26:59 -0700
Received: from tsdebian (97-120-89-198.ptld.qwest.net [97.120.89.198])
        by mail.embeddedts.com (Postfix) with ESMTPSA id 9134F4DC;
        Thu, 14 Jul 2022 14:26:57 -0700 (MST)
Message-ID: <1657833995.2979.1.camel@embeddedTS.com>
Subject: Re: [RFC PATCH v2] ARM: dts: Add TS-7553-V2 support
From:   Kris Bahnsen <kris@embeddedTS.com>
Reply-To: kris@embeddedTS.com
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Mark Featherston <mark@embeddedTS.com>
Date:   Thu, 14 Jul 2022 14:26:35 -0700
In-Reply-To: <55dccabb-41e9-dc45-f404-c333f5472e75@linaro.org>
References: <20220713221233.8486-1-kris@embeddedTS.com>
         <55dccabb-41e9-dc45-f404-c333f5472e75@linaro.org>
Organization: embeddedTS
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-IP: 66.210.251.27
X-Env-From: kris@embeddedTS.com
X-Proto: esmtps
X-Revdns: wsip-66-210-251-27.ph.ph.cox.net
X-HELO: mail.embeddedts.com
X-TLS:  TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256
X-Authenticated_ID: 
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embeddedTS.com; s=mailanyone20220121;h=Mime-Version:References:In-Reply-To:Date:To:From:Message-ID; bh=GseA+cRnj+YmYAVO5Y69v8C7WrdURv4BgtAoSd0DCpM=;b=hz/WBxV3h4iBrP9vWNGrG4x0jxMVhUxNOPwrX3h7o0QyBiR5HsXN/Bs9/wXVs/g8mZSku/B2FQ7BxxHy2HMleJ620RzIN3meKsr0OopL129w+iS8YtQlm1cZc9fM2omqRfbDAMVWcZ1C6Hmwar03v964/qcteuEuyFNbq0zmzg8GTgS6DERwcCqZT4FPbhy/DqTgizsF6wHXR0SKmWPgotdQCD3jt1mYnO96jx2evGcWAnpRBmUGD10KZe6zf7eo19jiK7ZA0S2DfgXKUjyi/+VjYEDAvL0nhW6RLJedYTc0BShVy6h6NLA1gj7Jad4uUFIkHfHwrVp5twI1FMw/dg==;
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-FM-Delivery-Delay: 15749372,23518412
X-PolicySMART: 13164782, 15749372, 26810492
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-07-14 at 10:34 +0200, Krzysztof Kozlowski wrote:
> On 14/07/2022 00:12, Kris Bahnsen wrote:
> > Add initial support of the i.MX6UL based TS-7553-V2 platform.
> 
> Use subject prefix matching the subsystem. git log --oneline --

Can you please elaborate? The subject prefix is "ARM: dts:", I'm not
sure what is missing. Should it be something like
"ARM: dts: imx6ul-ts7553v2:" in this case?

> 
> > 
> > Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>
> > ---
> > 
> > V1->V2: Implement changes recommended by Rob Herring and dtbs_check
> > 
> > RFC only, not yet ready to merge, more testing needed and we're working on
> > SPI LCD support for this platform.
> > 
> > Specifically, I have a few questions on some paradigms and dtbs_check output:
> > 
> > imx6ul-ts7553v2.dtb: /: i2c-gpio: {'compatible': ... \
> > 'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'], 'reg': [[12]]}}}} \
> > is not of type 'array'
> >   I'm not sure what this error is referring to as I've copied the example in
> >   invensense,mpu6050.yaml almost verbatim. Is this an issue with our patch
> >   or a false positive from dtbs_check?
> 
> You would need to paste entire error, maybe with checker flags -v.

Here is the verbose output. I'm not familiar enough yet with the schema and its
validation code to catch what is wrong and would appreciate any insight.

Check:  arch/arm/boot/dts/imx6ul-ts7553v2.dtb
/work/arch/arm/boot/dts/imx6ul-ts7553v2.dtb: /: i2c-gpio: {'compatible': ['i2c-gpio'], \
'#address-cells': [[1]], '#size-cells': [[0]], 'pinctrl-names': ['default'], \
'pinctrl-0': [[58]], 'sda-gpios': [[11, 5, 6]], 'scl-gpios': [[11, 4, 6]], \
'imu@68': {'compatible': ['invensense,mpu9250'], 'reg': [[104]], \
'interrupt-parent': [[55]], 'interrupts': [[1, 1]], 'i2c-gate': {'#address-cells': [[1]], \
'#size-cells': [[0]], 'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'], \
'reg': [[12]]}}}} is not of type 'array'

Failed validating 'type' in schema['patternProperties']['(?<!,nr)-gpios?$']:
    {'items': {'additionalItems': {'$ref': '#/definitions/cell'},
               'items': [{'oneOf': [{'maximum': 4294967295,
                                     'minimum': 1,
                                     'phandle': True,
                                     'type': 'integer'},
                                    {'const': 0, 'type': 'integer'}]}],
               'minItems': 1,
               'type': 'array'},
     'minItems': 1,
     'type': 'array'}

On instance['i2c-gpio']:
    {'#address-cells': [[1]],
     '#size-cells': [[0]],
     'compatible': ['i2c-gpio'],
     'imu@68': {'compatible': ['invensense,mpu9250'],
                'i2c-gate': {'#address-cells': [[1]],
                             '#size-cells': [[0]],
                             'magnetometer@c': {'compatible': ['asahi-kasei,ak8975'],
                                                'reg': [[12]]}},
                'interrupt-parent': [[55]],
                'interrupts': [[1, 1]],
                'reg': [[104]]},
     'pinctrl-0': [[58]],
     'pinctrl-names': ['default'],
     'scl-gpios': [[11, 4, 6]],
     'sda-gpios': [[11, 5, 6]]}
        From schema: /usr/local/lib/python3.9/dist-packages/dtschema/schemas/gpio/gpio-consumer.yaml

> 
> > 
> > 
> > imx6ul-ts7553v2.dtb: spi@2010000: spidev@1: 'compatible' is a required property
> >   Many of our devices have open-ended I2C and SPI ports that may or may not be
> >   used in customer applications. With "spidev" compatible string no longer
> >   supported, there is no easy way we know of to leave a placeholder or
> >   indication that the interface is present, usable, and either needs specific
> >   support enabled in kernel or userspace access via /dev/. We would love
> >   feedback on how to handle this situation when submitting platforms upstream.
> 
> No empty devices, especially for spidev in DTS. There is really no
> single need to add fake spidev... really, why? The customer cannot read
> hardware manual and cannot see the header on the board? You can give him
> a tutorial/howto guide, but don't embed dead or non-real code in DTS.

We ship devices as bootable out of the box. A number of our customers end up
attaching SPI devices that do not have existing kernel drivers and talk to them
from userspace without having to touch a kernel build. The loss of spidev
directly has increased support requests we receive on the matter.

> 
> > 
> > 
> > imx6ul-ts7553v2.dtb: wifi@0: compatible:0: 'microchip,wilc1000' was expected
> > imx6ul-ts7553v2.dtb: wifi@0: compatible: ['microchip,wilc3000'...] is too long
> > imx6ul-ts7553v2.dtb: wifi@0: 'chip_en-gpios' does not match any of the \
> > regexes: pinctrl-[0-9]+'
> >   As noted in the comments in the dts, the WILC1000 in-kernel driver doesn't
> >   support the BLE features of the WILC3000. We maintain an external module
> >   tree that lets us build Microchip's official driver with WILC3000 support.
> >   Would the extraneous compatible string and property be accepted upstream
> >   in light of this?
> 
> No. No undocumented comaptibles with some wrong properties. chip_en is
> clearly wrong, so it cannot go to DTS. Upstream driver or remove the node.

Unfortunate, but, understood.

> 
> > 
> > 
> >  Documentation/devicetree/bindings/arm/fsl.yaml |    1 +
> 
> This is a separate patch.

Makes sense.

> 
> >  arch/arm/boot/dts/Makefile                     |    1 +
> >  arch/arm/boot/dts/imx6ul-ts7553v2.dts          |  693 ++++++++++
> >  arch/arm/configs/ts7970_defconfig              | 1627 ++++++++++++++++++++++++
> >  arch/arm/configs/tsimx6ul_defconfig            |  967 ++++++++++++++
> 
> This as well (and won't be accepted - no new defconfigs).

The defconfigs being included were an oversight and absolutely sloppy on my
part. I sincerely apologize for that.

> 
> > 
> > +
> > +	leds {
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpio_leds>;
> > +		compatible = "gpio-leds";
> > +
> > +		green-led {
> 
> led-0
> 
> > +			label = "green-led";
> 
> Rather use color and function, then labels.

Fixed, thank you. I was unaware of this newer set of properties and I've
found where they are clearly spelled out.

> 
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > +
> > +		left {
> 
> This fails on dtbs_check. Generic node names, so "key-0" or "key-left"

For reference, as of commit b047602d579b4fb028128a525f056bbdc890e7f0, there
are no errors/warnings from dtbs_check or checkpatch.pl regarding node
names being "key-..." and the example in gpio-keys.yaml uses "up" "left" etc.

I've also changed the node name to just "keys" per devicetree specifications
doc.

> 
> > +	i2c_gpio: i2c-gpio {
> 
> Generic node name, so "i2c"

Understood.

Are there any guidelines/restrictions on label use/schema 
throughout a dts file? The devicetree-specification document only defines
valid characters for a label and I've been unable to find any other docs.

> 
> > +		compatible = "i2c-gpio";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_i2cgpio>;
> > +		sda-gpios = <&gpio5 5 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> > +		scl-gpios = <&gpio5 4 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		status = "okay";
> 
> Why do you add status? Isn't this a new node?

That was my mistake, Rob pointed it out in v1 and I forgot to remove it.

> 
> > +
> > +	pinctrl_i2cgpio: i2cgrpgpio {
> 
> Name not matching schema, as they must end with grp. Derive your board
> from something new, not ancient...
> > +
> > +	pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
> 
> Same.
> 
> > 
> > +
> > +	pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
> 
> No really...
> 

Thanks for pointing this out, I was unable to find any specific docs on the
pinctrl node name schema and dtbs_check gave no errors on it.

> > 
> > +};
> > diff --git a/arch/arm/configs/ts7970_defconfig b/arch/arm/configs/ts7970_defconfig
> > new file mode 100644
> > index 000000000000..a96831752449
> 
> Rest is not accepted as not explained/justified.
> 
> 
> Best regards,
> Krzysztof

Many thanks for the review. 
