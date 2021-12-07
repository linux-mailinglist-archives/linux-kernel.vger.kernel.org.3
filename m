Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE91F46BF27
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbhLGPXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:23:12 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:26372 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbhLGPXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:23:09 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638890379; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=OffRXYVqA0fHWMHhvj+JrTlza66+wlOh5c7WlOlrA7A=; b=aPYGS+/muzCLN3czNMqI7/8RwQUQkKz9mUoIGYocp+K90frLLGoyi+nlMSwFBG7NsYKHZ7+e
 n5AZZpbtHpUbHsBkzJYZW4L+700/y3C16d/MOciYL2af7LyS+9f2XPlcW1A+L64IKz8fiVq8
 hrUI7jQG6hXVCyzza5eGxkzJt4g=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 61af7b8b4fca5da46d01dbb5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Dec 2021 15:19:39
 GMT
Sender: srivasam=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 195C7C43617; Tue,  7 Dec 2021 15:19:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.0
Received: from [10.242.143.72] (unknown [202.46.23.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: srivasam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 60C21C4338F;
        Tue,  7 Dec 2021 15:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 60C21C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
Subject: Re: [PATCH v4 5/5] pinctrl: qcom: Add SC7280 lpass pin configuration
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivasa Rao Mandadapu <srivasam@codeaurora.com>
Cc:     agross@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, plai@codeaurora.org, bgoswami@codeaurora.org,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org, Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org,
        Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1638531140-25899-1-git-send-email-srivasam@codeaurora.com>
 <1638531140-25899-6-git-send-email-srivasam@codeaurora.com>
 <Ya45YKsdloY8l8do@builder.lan>
From:   Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
Organization: Qualcomm India Private Limited.
Message-ID: <7846a98f-618b-97f7-ce56-ad6597015619@codeaurora.org>
Date:   Tue, 7 Dec 2021 20:49:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ya45YKsdloY8l8do@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/6/2021 9:55 PM, Bjorn Andersson wrote:
Thanks for your time Bjorn!!
> On Fri 03 Dec 05:32 CST 2021, Srinivasa Rao Mandadapu wrote:
>
>> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>>
>> Add pin control support for SC7280 LPASS LPI.
>>
>> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
>> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>
>> ---
>>   drivers/pinctrl/qcom/Kconfig                    |   8 ++
>>   drivers/pinctrl/qcom/Makefile                   |   1 +
>>   drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c | 169 ++++++++++++++++++++++++
>>   3 files changed, 178 insertions(+)
>>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>>
>> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
>> index e750e10..37fe868 100644
>> --- a/drivers/pinctrl/qcom/Kconfig
>> +++ b/drivers/pinctrl/qcom/Kconfig
>> @@ -328,4 +328,12 @@ config PINCTRL_SM8250_LPASS_LPI
>>   	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>>   	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
>>   
>> +config PINCTRL_SC7280_LPASS_LPI
>> +	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
> You misspelled SC7280 here.
Okay. will address it.
>
>> +	depends on PINCTRL_LPASS_LPI
>> +	help
>> +	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
>> +	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
>> +	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
>> +
>>   endif
>> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
>> index 8bc877e..6c3ddaf 100644
>> --- a/drivers/pinctrl/qcom/Makefile
>> +++ b/drivers/pinctrl/qcom/Makefile
>> @@ -38,3 +38,4 @@ obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
>>   obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
>>   obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
>>   obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
>> +obj-$(CONFIG_PINCTRL_SC7280_LPASS_LPI) += pinctrl-sc7280-lpass-lpi.o
> Please keep these entries sorted alphabetically, same with Kconfig.
Okay. will address it.
>
> Regards,
> Bjorn
>
>> diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> new file mode 100644
>> index 0000000..94bec15
>> --- /dev/null
>> +++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
>> @@ -0,0 +1,169 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
>> + * ALSA SoC platform-machine driver for QTi LPASS
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/gpio/driver.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "pinctrl-lpass-lpi.h"
>> +
>> +enum lpass_lpi_functions {
>> +	LPI_MUX_dmic1_clk,
>> +	LPI_MUX_dmic1_data,
>> +	LPI_MUX_dmic2_clk,
>> +	LPI_MUX_dmic2_data,
>> +	LPI_MUX_dmic3_clk,
>> +	LPI_MUX_dmic3_data,
>> +	LPI_MUX_i2s1_clk,
>> +	LPI_MUX_i2s1_data,
>> +	LPI_MUX_i2s1_ws,
>> +	LPI_MUX_i2s2_clk,
>> +	LPI_MUX_i2s2_data,
>> +	LPI_MUX_i2s2_ws,
>> +	LPI_MUX_qua_mi2s_data,
>> +	LPI_MUX_qua_mi2s_sclk,
>> +	LPI_MUX_qua_mi2s_ws,
>> +	LPI_MUX_swr_rx_clk,
>> +	LPI_MUX_swr_rx_data,
>> +	LPI_MUX_swr_tx_clk,
>> +	LPI_MUX_swr_tx_data,
>> +	LPI_MUX_wsa_swr_clk,
>> +	LPI_MUX_wsa_swr_data,
>> +	LPI_MUX_gpio,
>> +	LPI_MUX__,
>> +};
>> +
>> +static const unsigned int gpio0_pins[] = { 0 };
>> +static const unsigned int gpio1_pins[] = { 1 };
>> +static const unsigned int gpio2_pins[] = { 2 };
>> +static const unsigned int gpio3_pins[] = { 3 };
>> +static const unsigned int gpio4_pins[] = { 4 };
>> +static const unsigned int gpio5_pins[] = { 5 };
>> +static const unsigned int gpio6_pins[] = { 6 };
>> +static const unsigned int gpio7_pins[] = { 7 };
>> +static const unsigned int gpio8_pins[] = { 8 };
>> +static const unsigned int gpio9_pins[] = { 9 };
>> +static const unsigned int gpio10_pins[] = { 10 };
>> +static const unsigned int gpio11_pins[] = { 11 };
>> +static const unsigned int gpio12_pins[] = { 12 };
>> +static const unsigned int gpio13_pins[] = { 13 };
>> +static const unsigned int gpio14_pins[] = { 14 };
>> +
>> +/* sc7280 variant specific data */
>> +static const struct pinctrl_pin_desc sc7280_lpi_pins[] = {
>> +	PINCTRL_PIN(0, "gpio0"),
>> +	PINCTRL_PIN(1, "gpio1"),
>> +	PINCTRL_PIN(2, "gpio2"),
>> +	PINCTRL_PIN(3, "gpio3"),
>> +	PINCTRL_PIN(4, "gpio4"),
>> +	PINCTRL_PIN(5, "gpio5"),
>> +	PINCTRL_PIN(6, "gpio6"),
>> +	PINCTRL_PIN(7, "gpio7"),
>> +	PINCTRL_PIN(8, "gpio8"),
>> +	PINCTRL_PIN(9, "gpio9"),
>> +	PINCTRL_PIN(10, "gpio10"),
>> +	PINCTRL_PIN(11, "gpio11"),
>> +	PINCTRL_PIN(12, "gpio12"),
>> +	PINCTRL_PIN(13, "gpio13"),
>> +	PINCTRL_PIN(14, "gpio14"),
>> +};
>> +
>> +static const char * const swr_tx_clk_groups[] = { "gpio0" };
>> +static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio14" };
>> +static const char * const swr_rx_clk_groups[] = { "gpio3" };
>> +static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
>> +static const char * const dmic1_clk_groups[] = { "gpio6" };
>> +static const char * const dmic1_data_groups[] = { "gpio7" };
>> +static const char * const dmic2_clk_groups[] = { "gpio8" };
>> +static const char * const dmic2_data_groups[] = { "gpio9" };
>> +static const char * const i2s2_clk_groups[] = { "gpio10" };
>> +static const char * const i2s2_ws_groups[] = { "gpio11" };
>> +static const char * const dmic3_clk_groups[] = { "gpio12" };
>> +static const char * const dmic3_data_groups[] = { "gpio13" };
>> +static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
>> +static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
>> +static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4" };
>> +static const char * const i2s1_clk_groups[] = { "gpio6" };
>> +static const char * const i2s1_ws_groups[] = { "gpio7" };
>> +static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
>> +static const char * const wsa_swr_clk_groups[] = { "gpio10" };
>> +static const char * const wsa_swr_data_groups[] = { "gpio11" };
>> +static const char * const i2s2_data_groups[] = { "gpio12", "gpio13" };
>> +
>> +static const struct lpi_pingroup sc7280_groups[] = {
>> +	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
>> +	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
>> +	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
>> +	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
>> +	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
>> +	LPI_PINGROUP(5, 12, swr_rx_data, _, _, _),
>> +	LPI_PINGROUP(6, NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
>> +	LPI_PINGROUP(7, NO_SLEW, dmic1_data, i2s1_ws, _, _),
>> +	LPI_PINGROUP(8, NO_SLEW, dmic2_clk, i2s1_data, _, _),
>> +	LPI_PINGROUP(9, NO_SLEW, dmic2_data, i2s1_data, _, _),
>> +	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
>> +	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
>> +	LPI_PINGROUP(12, NO_SLEW, dmic3_clk, i2s2_data, _, _),
>> +	LPI_PINGROUP(13, NO_SLEW, dmic3_data, i2s2_data, _, _),
>> +	LPI_PINGROUP(14, 6, swr_tx_data, _, _, _),
>> +};
>> +
>> +static const struct lpi_function sc7280_functions[] = {
>> +	LPI_FUNCTION(dmic1_clk),
>> +	LPI_FUNCTION(dmic1_data),
>> +	LPI_FUNCTION(dmic2_clk),
>> +	LPI_FUNCTION(dmic2_data),
>> +	LPI_FUNCTION(dmic3_clk),
>> +	LPI_FUNCTION(dmic3_data),
>> +	LPI_FUNCTION(i2s1_clk),
>> +	LPI_FUNCTION(i2s1_data),
>> +	LPI_FUNCTION(i2s1_ws),
>> +	LPI_FUNCTION(i2s2_clk),
>> +	LPI_FUNCTION(i2s2_data),
>> +	LPI_FUNCTION(i2s2_ws),
>> +	LPI_FUNCTION(qua_mi2s_data),
>> +	LPI_FUNCTION(qua_mi2s_sclk),
>> +	LPI_FUNCTION(qua_mi2s_ws),
>> +	LPI_FUNCTION(swr_rx_clk),
>> +	LPI_FUNCTION(swr_rx_data),
>> +	LPI_FUNCTION(swr_tx_clk),
>> +	LPI_FUNCTION(swr_tx_data),
>> +	LPI_FUNCTION(wsa_swr_clk),
>> +	LPI_FUNCTION(wsa_swr_data),
>> +};
>> +
>> +static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
>> +	.pins = sc7280_lpi_pins,
>> +	.npins = ARRAY_SIZE(sc7280_lpi_pins),
>> +	.groups = sc7280_groups,
>> +	.ngroups = ARRAY_SIZE(sc7280_groups),
>> +	.functions = sc7280_functions,
>> +	.nfunctions = ARRAY_SIZE(sc7280_functions),
>> +};
>> +
>> +static const struct of_device_id lpi_pinctrl_of_match[] = {
>> +	{
>> +	       .compatible = "qcom,sc7280-lpass-lpi-pinctrl",
>> +	       .data = &sc7280_lpi_data,
>> +	},
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
>> +
>> +static struct platform_driver lpi_pinctrl_driver = {
>> +	.driver = {
>> +		   .name = "qcom-sc7280-lpass-lpi-pinctrl",
>> +		   .of_match_table = lpi_pinctrl_of_match,
>> +	},
>> +	.probe = lpi_pinctrl_probe,
>> +	.remove = lpi_pinctrl_remove,
>> +};
>> +
>> +module_platform_driver(lpi_pinctrl_driver);
>> +MODULE_DESCRIPTION("QTI SC7280 LPI GPIO pin control driver");
>> +MODULE_LICENSE("GPL");
>> +
>> -- 
>> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
>> is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
>>
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

