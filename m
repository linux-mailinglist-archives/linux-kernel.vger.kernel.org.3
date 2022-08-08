Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009E758C6FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 12:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242318AbiHHK4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 06:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242684AbiHHKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 06:55:43 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [5.144.164.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7628621B7;
        Mon,  8 Aug 2022 03:55:41 -0700 (PDT)
Received: from [192.168.1.101] (abxh187.neoplus.adsl.tpnet.pl [83.9.1.187])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 9B3483F6F1;
        Mon,  8 Aug 2022 12:55:37 +0200 (CEST)
Message-ID: <3515103e-8663-1df9-a184-a383cc0d6aa9@somainline.org>
Date:   Mon, 8 Aug 2022 12:55:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] ARM: dts: qcom: ipq8064: add v2 dtsi variant
Content-Language: en-US
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220718161826.4943-1-ansuelsmth@gmail.com>
 <62efbb68.170a0220.88a00.8207@mx.google.com>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <62efbb68.170a0220.88a00.8207@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7.08.2022 15:00, Christian Marangi wrote:
> On Mon, Jul 18, 2022 at 06:18:24PM +0200, Christian Marangi wrote:
>> Add ipq8064-v2.0 dtsi variant that differ from original ipq8064 SoC for
>> some additional pcie, sata and usb configuration values, additional
>> reserved memory and serial output.
>>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> 
> Any news for this?Unless Qualcomm naming was different back then, you should simply merge
all of these changes into ipq8064.dtsi, as v1 is often the pre-production,
internal chip revision and only the last one (or the last and second-last)
are shipped in production devices.

Konrad
> 
>> ---
>>  .../boot/dts/qcom-ipq8064-v2.0-smb208.dtsi    | 37 ++++++++++
>>  arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi      | 69 +++++++++++++++++++
>>  2 files changed, 106 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
>>  create mode 100644 arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
>>
>> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
>> new file mode 100644
>> index 000000000000..0442580b22de
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0-smb208.dtsi
>> @@ -0,0 +1,37 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "qcom-ipq8064-v2.0.dtsi"
>> +
>> +&rpm {
>> +	smb208_regulators: regulators {
>> +		compatible = "qcom,rpm-smb208-regulators";
>> +
>> +		smb208_s1a: s1a {
>> +			regulator-min-microvolt = <1050000>;
>> +			regulator-max-microvolt = <1150000>;
>> +
>> +			qcom,switch-mode-frequency = <1200000>;
>> +		};
>> +
>> +		smb208_s1b: s1b {
>> +			regulator-min-microvolt = <1050000>;
>> +			regulator-max-microvolt = <1150000>;
>> +
>> +			qcom,switch-mode-frequency = <1200000>;
>> +		};
>> +
>> +		smb208_s2a: s2a {
>> +			regulator-min-microvolt = < 800000>;
>> +			regulator-max-microvolt = <1250000>;
>> +
>> +			qcom,switch-mode-frequency = <1200000>;
>> +		};
>> +
>> +		smb208_s2b: s2b {
>> +			regulator-min-microvolt = < 800000>;
>> +			regulator-max-microvolt = <1250000>;
>> +
>> +			qcom,switch-mode-frequency = <1200000>;
>> +		};
>> +	};
>> +};
>> diff --git a/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
>> new file mode 100644
>> index 000000000000..2f117d576daf
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/qcom-ipq8064-v2.0.dtsi
>> @@ -0,0 +1,69 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +#include "qcom-ipq8064.dtsi"
>> +
>> +/ {
>> +	model = "Qualcomm Technologies, Inc. IPQ8064-v2.0";
>> +
>> +	aliases {
>> +		serial0 = &gsbi4_serial;
>> +	};
>> +
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	reserved-memory {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
>> +
>> +		rsvd@41200000 {
>> +			reg = <0x41200000 0x300000>;
>> +			no-map;
>> +		};
>> +	};
>> +};
>> +
>> +&gsbi4 {
>> +	qcom,mode = <GSBI_PROT_I2C_UART>;
>> +	status = "okay";
>> +
>> +	serial@16340000 {
>> +		status = "okay";
>> +	};
>> +	/*
>> +	 * The i2c device on gsbi4 should not be enabled.
>> +	 * On ipq806x designs gsbi4 i2c is meant for exclusive
>> +	 * RPM usage. Turning this on in kernel manifests as
>> +	 * i2c failure for the RPM.
>> +	 */
>> +};
>> +
>> +&pcie0 {
>> +	compatible = "qcom,pcie-ipq8064-v2";
>> +};
>> +
>> +&pcie1 {
>> +	compatible = "qcom,pcie-ipq8064-v2";
>> +};
>> +
>> +&pcie2 {
>> +	compatible = "qcom,pcie-ipq8064-v2";
>> +};
>> +
>> +&sata {
>> +	ports-implemented = <0x1>;
>> +};
>> +
>> +&ss_phy_0 {
>> +	qcom,rx-eq = <2>;
>> +	qcom,tx-deamp_3_5db = <32>;
>> +	qcom,mpll = <5>;
>> +};
>> +
>> +&ss_phy_1 {
>> +	qcom,rx-eq = <2>;
>> +	qcom,tx-deamp_3_5db = <32>;
>> +	qcom,mpll = <5>;
>> +};
>> -- 
>> 2.36.1
>>
> 
