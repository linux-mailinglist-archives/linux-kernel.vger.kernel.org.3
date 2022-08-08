Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F9258C759
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 13:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242682AbiHHLMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiHHLMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 07:12:31 -0400
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC9955B8;
        Mon,  8 Aug 2022 04:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
        t=1659957146; bh=UWohm+6mP1TOMfTF4FwgB5DFTznGL1J1NvMu49uc/og=;
        h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
        b=djVar0/XKcNC3oeWSe7Xci7HnArn7LXTAmr93YEir7jxW7aF6UP9sVux0Nn1Cs9pg
         EERa7EOmJv2OtWZ8zXSslgTZGg4TO1xnUac/BoQHzf2JtYMYdPbyv4lXvUONrmYzae
         VZOcAFDsf5/ZfXFbzDyfS8dhiFDgINhcdV87inLo=
Date:   Mon, 8 Aug 2022 13:12:25 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add initial support for
 Pine64 PinePhone Pro
Message-ID: <20220808111225.pslgct22eltiakiv@core>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        martijn@brixit.nl, ayufan@ayufan.eu, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20220805234411.303055-1-tom@tom-fitzhenry.me.uk>
 <20220805234411.303055-4-tom@tom-fitzhenry.me.uk>
 <6461a695-171a-b160-5406-b8ac31c5ba0e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6461a695-171a-b160-5406-b8ac31c5ba0e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Aug 08, 2022 at 09:35:55AM +0300, Krzysztof Kozlowski wrote:
> On 06/08/2022 01:44, Tom Fitzhenry wrote:
> 
> [...]
>
> > +
> > +	/* Power tree */
> > +	/* Root power source */
> > +	vcc_sysin: vcc-sysin {
> 
> regulator-vcc-sysin

Interestingly, most DTS files in rockchip/ use a -regulator
suffix and none use regulator- prefix. And this is inconsistent
across the larger DTS tree, because outside of rockchip/ most
DTS use a prefix.

Checked by grep -R 'regulator.*{' | grep -v state-me

regards,
	o.

> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_sysin";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> > +
> > +	/* Main 3.3v supply */
> > +	vcc3v3_sys: wifi_bat: vcc3v3-sys {
> 
> regulator-.....
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc3v3_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		vin-supply = <&vcc_sysin>;
> > +	};
> > +
> > +	vcca1v8_s3: vcc1v8-s3 {
> 
> regulator-.....
> 
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcca1v8_s3";
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		vin-supply = <&vcc3v3_sys>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +	};
> > +};
> > +
> Best regards,
> Krzysztof
