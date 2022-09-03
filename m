Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13805ABEFD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 14:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiICMcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 08:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiICMcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 08:32:50 -0400
X-Greylist: delayed 551 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Sep 2022 05:32:49 PDT
Received: from relay04.th.seeweb.it (relay04.th.seeweb.it [5.144.164.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659BF5EDC1;
        Sat,  3 Sep 2022 05:32:49 -0700 (PDT)
Received: from [192.168.1.101] (afbd23.neoplus.adsl.tpnet.pl [95.49.29.23])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 0BA371F676;
        Sat,  3 Sep 2022 14:32:46 +0200 (CEST)
Message-ID: <fc63d761-18bd-7898-f24f-103fc8164679@somainline.org>
Date:   Sat, 3 Sep 2022 14:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 14/14] arm64: dts: qcom: sm4250: Add support for
 oneplus-billie2
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Iskren Chernev <iskren.chernev@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
References: <20220901072414.1923075-1-iskren.chernev@gmail.com>
 <20220901072414.1923075-15-iskren.chernev@gmail.com>
 <ccd72f2b-911e-c4fd-7bbc-ce21e5a34c68@linaro.org>
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
In-Reply-To: <ccd72f2b-911e-c4fd-7bbc-ce21e5a34c68@linaro.org>
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



On 1.09.2022 18:20, Krzysztof Kozlowski wrote:
> On 01/09/2022 10:24, Iskren Chernev wrote:
>> Add initial support for OnePlus Nord N100, based on SM4250. Currently
>> working:
>> - boots
>> - usb
>> - buildin flash storage (UFS)
>> - SD card reader
>>
>> Signed-off-by: Iskren Chernev <iskren.chernev@gmail.com>
>> ---
>>  .../boot/dts/qcom/sm4250-oneplus-billie2.dts  | 240 ++++++++++++++++++
>>  1 file changed, 240 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>>
>> diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> new file mode 100644
>> index 000000000000..c1cf0288aa5f
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
>> @@ -0,0 +1,240 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2021, Iskren Chernev <iskren.chernev@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "sm4250.dtsi"
>> +
>> +/ {
>> +	model = "OnePlus Nord N100";
>> +	compatible = "oneplus,billie2", "qcom,sm4250";
>> +
>> +	/* required for bootloader to select correct board */
>> +	qcom,msm-id = <0x1a1 0x10000 0x1bc 0x10000>;
>> +	qcom,board-id = <0x1000b 0x00>;
>> +
>> +	aliases {
>> +	};
>> +
>> +	chosen {
>> +		bootargs = "earlycon=tty0 console=tty0 clk_ignore_unused pd_ignore_unused";
> 
> No bootargs. They are not suitable for wide-use.
Agreed, the problem here is probably the framebuffer dying after our clock controllers probe.
One can solve that by adding the relevant clocks/PDs under the framebuffer node like I did
in sm8[123]50 Xperia DTs.

Konrad
