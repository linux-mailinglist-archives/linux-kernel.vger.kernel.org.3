Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B05D5ABD76
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 08:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232361AbiICGds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 02:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbiICGdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 02:33:45 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123FCB8A6B;
        Fri,  2 Sep 2022 23:33:42 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2836XNKd121916;
        Sat, 3 Sep 2022 01:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1662186803;
        bh=iy9m2WEQapJ1s07ZhqWqH9Zf7PEYO2GbJZN7f+sclms=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=PS08YBgLTlFTQBJQvo+SeRDyHQbEzKUHIjdhqt273DcF+wUovlvrpdpWIBjSyzwu+
         TfqnUVD1J79pf+4Stu/KX99OHa5PuGS0bHl30KgwhAeJjrf6S862a0NevSD3JXrPQx
         ORuK6P+7Emwedju5wc120cGiPTuxNYufjFXdrrys=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2836XNkw008154
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 3 Sep 2022 01:33:23 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Sat, 3 Sep
 2022 01:33:23 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Sat, 3 Sep 2022 01:33:23 -0500
Received: from [10.250.234.106] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2836XJMf029034;
        Sat, 3 Sep 2022 01:33:20 -0500
Message-ID: <8c6a9a5f-b3a9-8e63-a6d8-ed6d70cf09c7@ti.com>
Date:   Sat, 3 Sep 2022 12:03:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: add k3-j721e-beagleboneai64
Content-Language: en-US
To:     Robert Nelson <robertcnelson@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew Fustini <drew@beagleboard.org>
References: <20220822230304.2284952-1-robertcnelson@gmail.com>
 <20220822230304.2284952-2-robertcnelson@gmail.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20220822230304.2284952-2-robertcnelson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/08/22 4:33 am, Robert Nelson wrote:
> +	main_i2c2_pins_default: main_i2c2_pins_default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x208, PIN_INPUT_PULLUP, 4) /* (W5) MCAN0_RX.I2C2_SCL */
> +			J721E_IOPAD(0x20c, PIN_INPUT_PULLUP, 4) /* (W6) MCAN0_TX.I2C2_SDA */
> +			J721E_IOPAD(0x138, PIN_INPUT, 7) /* (AE25) PRG0_PRU1_GPO14.GPIO0_77 */
> +			J721E_IOPAD(0x13c, PIN_INPUT, 7) /* (AF29) PRG0_PRU1_GPO15.GPIO0_78 */
> +		>;
> +	};
> +
> +	main_i2c3_pins_default: main-i2c3-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x270, PIN_INPUT_PULLUP, 4) /* (T26) MMC2_CLK.I2C3_SCL */
> +			J721E_IOPAD(0x274, PIN_INPUT_PULLUP, 4) /* (T25) MMC2_CMD.I2C3_SDA */
> +		>;
> +	};
> +
> +	main_i2c4_pins_default: main_i2c4_pins_default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x1e0, PIN_INPUT_PULLUP, 2) /* (Y5) SPI1_D0.I2C4_SCL */
> +			J721E_IOPAD(0x1dc, PIN_INPUT_PULLUP, 2) /* (Y1) SPI1_CLK.I2C4_SDA */
> +			J721E_IOPAD(0x30, PIN_INPUT, 7) /* (AF24) PRG1_PRU0_GPO11.GPIO0_12 */
> +			J721E_IOPAD(0x34, PIN_INPUT, 7) /* (AJ24) PRG1_PRU0_GPO12.GPIO0_13 */
> +		>;
> +	};
> +
> +	main_i2c5_pins_default: main-i2c5-pins-default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x150, PIN_INPUT_PULLUP, 2) /* (Y26) PRG0_MDIO0_MDIO.I2C5_SCL */
> +			J721E_IOPAD(0x154, PIN_INPUT_PULLUP, 2) /* (AA27) PRG0_MDIO0_MDC.I2C5_SDA */
> +		>;
> +	};
> +
> +	main_i2c6_pins_default: main_i2c6_pins_default {
> +		pinctrl-single,pins = <
> +			J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) SPI0_D1.I2C6_SCL */
> +			J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */
> +			J721E_IOPAD(0x74, PIN_INPUT, 7) /* (AC21) PRG1_PRU1_GPO7.GPIO0_28 */
> +			J721E_IOPAD(0xa4, PIN_INPUT, 7) /* (AH22) PRG1_PRU1_GPO19.GPIO0_40 */
> +		>;
> +	};
> +

Please address following warnings with make dtbs W=12

+arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts: /bus@100000/pinctrl@11c000/main_i2c2_pins_default: Character '_' not recommended in node name
+arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts: /bus@100000/pinctrl@11c000/main_i2c4_pins_default: Character '_' not recommended in node name
+arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts: /bus@100000/pinctrl@11c000/main_i2c6_pins_default: Character '_' not recommended in node name

