Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA7C4DCDE0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237586AbiCQSt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237584AbiCQSt0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:49:26 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A264C11BE52;
        Thu, 17 Mar 2022 11:48:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: adalessandro)
        with ESMTPSA id ABF301F45A25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647542886;
        bh=0WzZgN9aj0s8HEM+nPIbGUukn4MTB8wYqvpInAw1fPY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N7TCbvr7Xn1NBsfZdq5HFid3scc3xT6XYCe80AU9aFufOzzv5jFqfCPumrdJedHmb
         AVdzMfFYrR64U8BRyKzhAICQSO2TYQaFDyR1MbtHBE9RBxaL5C52+Q5yccbYmi/iBS
         M+0vYNRJonT0VJpJFR9lEp+l1lTLDSIEgovl4QFcuBiQMqu+GmnJhoypmm5ZI/Wr8w
         IM0GP0iCzWyeFRcAdktirYF7fHhcuzYwOy1+dMUB+bV4jBlrJY2I56o4YZJlgnx3Y4
         hTQhgxW9U30DTtqNcAlJp+lS+QRjygHO/80E+xJse+1btt2BeUvoqzmqbvFgirMlm7
         58oLeFJuq3s6Q==
Message-ID: <d748d03d-4e9c-50a5-6c9e-089ec44a2540@collabora.com>
Date:   Thu, 17 Mar 2022 15:47:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH v2 2/2] arm64: dts: imx8mn-bsh-smm-s2pro: Add
 tlv320aic31xx audio card node
Content-Language: en-US
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <20220210134049.32576-1-ariel.dalessandro@collabora.com>
 <20220210134049.32576-2-ariel.dalessandro@collabora.com>
 <CAOMZO5DuB4d1243H46d1=heiNiz+pQVkjrGU+zV_r3GFKRTZfQ@mail.gmail.com>
From:   Ariel D'Alessandro <ariel.dalessandro@collabora.com>
In-Reply-To: <CAOMZO5DuB4d1243H46d1=heiNiz+pQVkjrGU+zV_r3GFKRTZfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fabio,

On 3/10/22 09:29, Fabio Estevam wrote:
> Hi Ariel,
> 
> On Thu, Feb 10, 2022 at 10:41 AM Ariel D'Alessandro
> <ariel.dalessandro@collabora.com> wrote:
> 
>> +&i2c2 {
>> +       clock-frequency = <400000>;
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_i2c2>;
>> +       status = "okay";
>> +
>> +       codec: tlv320dac3101@18 {
>> +               #sound-dai-cells = <0>;
>> +               compatible = "ti,tlv320dac3101";
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&pinctrl_dac_rst>;
>> +               reg = <0x18>;
>> +
>> +               ai31xx-micbias-vg = <MICBIAS_AVDDV>;
>> +
>> +               HPVDD-supply = <&buck4_reg>;
>> +               SPRVDD-supply = <&vdd_input>;
>> +               SPLVDD-supply = <&vdd_input>;
>> +               AVDD-supply = <&buck4_reg>;
>> +               IOVDD-supply = <&buck4_reg>;
>> +               DVDD-supply = <&buck5_reg>;
>> +               reset-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
>> +
>> +               clocks = <&clk IMX8MN_CLK_SAI3_ROOT>;
>> +               clock-names = "mclk";
> 
> The clocks and clock-names properties are not documented in the codec bindings.
> 
> Also, the driver does not use call clk_get() on this mclk clock.
> 
> You should drop the clocks and clock-names properties.

The sound card driver is calling clk_get() on the codec's clock. See
sound/soc/fsl/fsl-asoc-card.c:

    /* Get the MCLK rate only, and leave it controlled by CODEC drivers */
    if (codec_dev) {
        struct clk *codec_clk = clk_get(codec_dev, NULL);

        if (!IS_ERR(codec_clk)) {
            priv->codec_priv.mclk_freq = clk_get_rate(codec_clk);
            clk_put(codec_clk);
        }
    }

Regards,
Ariel
