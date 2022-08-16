Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BCD596313
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 21:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiHPTY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 15:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237119AbiHPTYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 15:24:22 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF7A6FA30
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:24:20 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id a4so2041982wrq.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Sz8NNXwmI1EFfI2ysv73Yy1lOgv2a7RKnB5GY8gYwyA=;
        b=v5Wq2TkCKJiji9wCUF2Og9fTe+WAKKIVnXpv6pmV69UDPXK/3jjiSwLZXS7rx/VfMV
         HAlrWZpoEeUaShnaKamj3WVmo3UlZ8hZtIvOoXdAa5KPCkom8Z3cMFhFUkmBgW968cgS
         aBkZtFa9Sc1dybQXYEg5/3Ba5sLZykMJon+ZwehL21O2uXYPv5CkhLb7OvEWDiKGdhmO
         mYC/YwjhESSeNAV7myqJPTEk1atQ5BmqVktEgYBNPE3gh6IFFYYjupO9LHQ1SfJqD8Lf
         fesOvFwb/2NnrwbKYPyk6cN+uadTvGGICYA9KKECIb+YoSTWR0TXCX88Alk1atyaKWce
         urJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Sz8NNXwmI1EFfI2ysv73Yy1lOgv2a7RKnB5GY8gYwyA=;
        b=pm3SyG+Wv0rGKJykThBb04/0YqXEBZCCntqAEJqtCNICu5B+LLreAyUi2BRM7b2FbH
         d32ALKndmSeri2uk4VNY7+jDFb9dzz+DOdw2+eNIOVa3rhCKtxXMTh+mW4FAZncKAPpi
         jDarfPzAI3G/EBPRtkSW1pVu+lJnGaLyhALhS1+5olhFUvXtF+iA9Fjuo7bdUI5PhFUc
         RKXmHWgPPKRihmvX6LWkqozl3r4b7+OSaOg4AH1n3tjeVgxSsqVK5nz7mZXzRuaAA5NN
         cwLBdLMJOVmx8s58j8itHheOpzPxT3esnaGy5dMxPv0YgDTZQQYS0OEcK+tOJy1BkHpl
         CLVQ==
X-Gm-Message-State: ACgBeo11eb7NKDEYReZbCOxiDBE1NmMTM+/+s/wTP7iUMa5hZ3Ywolv9
        uYgjTYomP75B/h3BTjpLAkq77g==
X-Google-Smtp-Source: AA6agR4aEp+iW0YMEf5emiZyDEPlFnJbsXIRLMLmehN5Xx6i+1e+VtrBCslwlFSQBGiuC8RrtaKjkg==
X-Received: by 2002:adf:fe44:0:b0:225:325:13f6 with SMTP id m4-20020adffe44000000b00225032513f6mr6744226wrs.234.1660677858735;
        Tue, 16 Aug 2022 12:24:18 -0700 (PDT)
Received: from [192.168.0.12] (cpc76482-cwma10-2-0-cust629.7-3.cable.virginm.net. [86.14.22.118])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d69c3000000b00225232154d7sm240559wrw.110.2022.08.16.12.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Aug 2022 12:24:18 -0700 (PDT)
Message-ID: <0ee98af7-d6df-fb3d-b1f4-42d3482bc7a9@linaro.org>
Date:   Tue, 16 Aug 2022 20:24:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v4 1/2] power: supply: add Qualcomm PMI8998 SMB2 Charger
 driver
Content-Language: en-US
To:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
        phone-devel@vger.kernel.org
References: <20220706194125.1861256-1-caleb.connolly@linaro.org>
 <20220706194125.1861256-2-caleb.connolly@linaro.org>
From:   Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20220706194125.1861256-2-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2022 20:41, Caleb Connolly wrote:
> Add a driver for the SMB2 charger block found in the Qualcomm PMI8998
> and PM660.

I noticed an issue in this revision which was the root-cause of the OnePlus 6 charging incredibly 
slowly. Other SDM845 phones feature a secondary charger IC, usually the smb1135 (iirc) which was 
able to work normally, hiding the issue, however the OnePlus 6 does not. See below.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Changes since v1:
>   * Renamed from qcom_smb2 to qcom_pmi8998_charger
> ---
>   drivers/power/supply/Kconfig                |    9 +
>   drivers/power/supply/Makefile               |    1 +
>   drivers/power/supply/qcom_pmi8998_charger.c | 1044 +++++++++++++++++++
>   3 files changed, 1054 insertions(+)
>   create mode 100644 drivers/power/supply/qcom_pmi8998_charger.c
> 
> diff --git a/drivers/power/supply/Makefile b/drivers/power/supply/Makefile
> index 7f02f36aea55..a39e3eda6dbd 100644

[snip]

> +
> +/* Init sequence derived from vendor downstream driver */
> +static const struct smb2_register smb2_init_seq[] = {
> +	{ .addr = AICL_RERUN_TIME_CFG, .mask = AICL_RERUN_TIME_MASK, .val = 0 },
> +	/*
> +	 * By default configure us as an upstream facing port
> +	 * FIXME: for OTG we should set UFP_EN_CMD_BIT and DFP_EN_CMD_BIT both to 0
> +	 */
> +	{ .addr = TYPE_C_INTRPT_ENB_SOFTWARE_CTRL,
> +	  .mask = TYPEC_POWER_ROLE_CMD_MASK | VCONN_EN_SRC_BIT |
> +		  VCONN_EN_VALUE_BIT,
> +	  .val = VCONN_EN_SRC_BIT | UFP_EN_CMD_BIT },
> +	/*
> +	 * disable Type-C factory mode and stay in Attached.SRC state when VCONN
> +	 * over-current happens
> +	 */
> +	{ .addr = TYPE_C_CFG,
> +	  .mask = FACTORY_MODE_DETECTION_EN_BIT | VCONN_OC_CFG_BIT,
> +	  .val = 0 },
> +	/* Configure VBUS for software control */
> +	{ .addr = OTG_CFG, .mask = OTG_EN_SRC_CFG_BIT, .val = 0 },
> +	{ .addr = FG_UPDATE_CFG_2_SEL,
> +	  .mask = SOC_LT_CHG_RECHARGE_THRESH_SEL_BIT |
> +		  VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT,
> +	  .val = VBT_LT_CHG_RECHARGE_THRESH_SEL_BIT },
> +	/* Enable charging */
> +	{ .addr = USBIN_OPTIONS_1_CFG, .mask = HVDCP_EN_BIT, .val = 0 },
> +	{ .addr = CHARGING_ENABLE_CMD,
> +	  .mask = CHARGING_ENABLE_CMD_BIT,
> +	  .val = CHARGING_ENABLE_CMD_BIT },
> +	/* Allow overriding the current limit */
> +	// { .addr = USBIN_LOAD_CFG,
> +	//   .mask = ICL_OVERRIDE_AFTER_APSD_BIT,
> +	//   .val = ICL_OVERRIDE_AFTER_APSD_BIT },
> +	{ .addr = CHGR_CFG2,
> +	  .mask = CHG_EN_SRC_BIT | CHG_EN_POLARITY_BIT |
> +		  PRETOFAST_TRANSITION_CFG_BIT | BAT_OV_ECC_BIT | I_TERM_BIT |
> +		  AUTO_RECHG_BIT | EN_ANALOG_DROP_IN_VBATT_BIT |
> +		  CHARGER_INHIBIT_BIT,
> +	  .val = 0 },
> +	/*
> +	 * No clue what this does
> +	 */
> +	{ .addr = STAT_CFG,
> +	  .mask = STAT_SW_OVERRIDE_CFG_BIT,
> +	  .val = STAT_SW_OVERRIDE_CFG_BIT },
> +	/*
> +	 * Set the default SDP charger type to a 500ma USB 2.0 port
> +	 */
> +	{ .addr = USBIN_ICL_OPTIONS,
> +	  .mask = USB51_MODE_BIT | USBIN_MODE_CHG_BIT,
> +	  .val = USB51_MODE_BIT },
> +	/*
> +	 * Disable watchdog
> +	 */
> +	{ .addr = SNARL_BARK_BITE_WD_CFG, .mask = 0xff, .val = 0 },
> +	{ .addr = WD_CFG,
> +	  .mask = WATCHDOG_TRIGGER_AFP_EN_BIT | WDOG_TIMER_EN_ON_PLUGIN_BIT |
> +		  BARK_WDOG_INT_EN_BIT,
> +	  .val = 0 },
> +	/* OnePlus init stuff from "op_set_collapse_fet" */
> +	{ .addr = USBIN_5V_AICL_THRESHOLD_CFG,
> +	  .mask = USBIN_5V_AICL_THRESHOLD_CFG_MASK,
> +	  .val = 0x3 },
> +	{ .addr = USBIN_CONT_AICL_THRESHOLD_CFG,
> +	  .mask = USBIN_CONT_AICL_THRESHOLD_CFG_MASK,
> +	  .val = 0x3 },
> +	/* Yay undocumented register values! */
> +	{ .addr = USBIN_LOAD_CFG, .mask = BIT(0) | BIT(1), .val = 0x3 },
> +	/* Enable Automatic Input Current Limit, this will slowly ramp up the current
> +	 * When connected to a wall charger, and automatically stop when it detects
> +	 * the charger current limit (voltage drop?) or it reaches the programmed limit.
> +	 */
> +	{ .addr = USBIN_AICL_OPTIONS_CFG,
> +	  .mask = USBIN_AICL_START_AT_MAX_BIT | USBIN_AICL_ADC_EN_BIT |
> +		  USBIN_AICL_EN_BIT | SUSPEND_ON_COLLAPSE_USBIN_BIT |
> +		  USBIN_HV_COLLAPSE_RESPONSE_BIT |
> +		  USBIN_LV_COLLAPSE_RESPONSE_BIT,
> +	  .val = USBIN_HV_COLLAPSE_RESPONSE_BIT |
> +		 USBIN_LV_COLLAPSE_RESPONSE_BIT | USBIN_AICL_EN_BIT },
> +	/*
> +	 * Set pre charge current to default, the OnePlus 6 bootloader
> +	 * sets this very conservatively.
> +	 * NOTE: seems to be reset to zero again anyway after boot
> +	 */
> +	{ .addr = PRE_CHARGE_CURRENT_CFG,
> +	  .mask = PRE_CHARGE_CURRENT_SETTING_MASK,
> +	  .val = 500000 / 25000 },
> +	/*
> +	 * Set "fast charge current" to the default 2A, the OnePlus 6 also
> +	 * sets this very conservatively.
> +	 * NOTE: seems to be reset to zero again anyway after boot
> +	 */
> +	{ .addr = FAST_CHARGE_CURRENT_CFG,
> +	  .mask = FAST_CHARGE_CURRENT_SETTING_MASK,
> +	  .addr = 1950000 / 25000 },

The .addr is set here twice, meaning the fast charge current register is not configured properly and 
thus left at conservative bootloader values - or set to zero, I'm not sure how the compiler handles 
this.

Will be fixed in the next revision.
> +};
> +
> +static int smb2_init_hw(struct smb2_chip *chip)
> +{
> +	int rc, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(smb2_init_seq); i++) {
> +		dev_dbg(chip->dev, "%d: Writing 0x%02x to 0x%02x\n", i,
> +			smb2_init_seq[i].val, smb2_init_seq[i].addr);
> +		rc = regmap_update_bits(chip->regmap,
> +					chip->base + smb2_init_seq[i].addr,
> +					smb2_init_seq[i].mask,
> +					smb2_init_seq[i].val);
> +		if (rc < 0)
> +			return dev_err_probe(
> +				chip->dev, rc,
> +				"%s: Failed to write 0x%02x to 0x%02x\n",
> +				__func__, smb2_init_seq[i].val,
> +				smb2_init_seq[i].addr);
> +	}
> +
> +	return 0;
> +}
> +
> +struct smb2_irqs {
> +	const char *name;
> +	irqreturn_t (*handler)(int irq, void *data);
> +};
> +
> +static const struct smb2_irqs irqs[] = {
> +	{ .name = "bat-ov", .handler = smb2_handle_batt_overvoltage },
> +	{ .name = "usb-plugin", .handler = smb2_handle_usb_plugin },
> +	{ .name = "usbin-icl-change", .handler = smb2_handle_usb_icl_change },
> +	{ .name = "wdog-bark", .handler = smb2_handle_wdog_bark },
> +};
> +
> +static int smb2_probe(struct platform_device *pdev)
> +{
> +	struct power_supply_config supply_config = {};
> +	struct smb2_chip *chip;
> +	int rc, i, irq;
> +
> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> +	if (!chip)
> +		return -ENOMEM;
> +
> +	chip->dev = &pdev->dev;
> +	chip->name = pdev->name;
> +
> +	chip->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (!chip->regmap) {
> +		return dev_err_probe(chip->dev, -ENODEV,
> +				     "failed to locate the regmap\n");
> +	}
> +
> +	rc = device_property_read_u32(chip->dev, "reg", &chip->base);
> +	if (rc < 0) {
> +		return dev_err_probe(chip->dev, rc,
> +				     "Couldn't read base address\n");
> +	}
> +
> +	chip->usb_in_v_chan = devm_iio_channel_get(chip->dev, "usbin_v");
> +	if (IS_ERR(chip->usb_in_v_chan))
> +		return dev_err_probe(
> +			chip->dev, PTR_ERR(chip->usb_in_v_chan),
> +			"Couldn't get usbin_v IIO channel from RRADC\n");
> +
> +	chip->usb_in_i_chan = devm_iio_channel_get(chip->dev, "usbin_i");
> +	if (IS_ERR(chip->usb_in_i_chan)) {
> +		return dev_err_probe(
> +			chip->dev, PTR_ERR(chip->usb_in_i_chan),
> +			"Couldn't get usbin_i IIO channel from RRADC\n");
> +	}
> +
> +	rc = smb2_init_hw(chip);
> +	if (rc < 0)
> +		return rc;
> +
> +	supply_config.drv_data = chip;
> +	supply_config.of_node = pdev->dev.of_node;
> +
> +	chip->chg_psy = devm_power_supply_register(chip->dev, &smb2_psy_desc,
> +						   &supply_config);
> +	if (IS_ERR(chip->chg_psy))
> +		return dev_err_probe(chip->dev, PTR_ERR(chip->chg_psy),
> +				     "failed to register power supply\n");
> +
> +	rc = power_supply_get_battery_info(chip->chg_psy, &chip->batt_info);
> +	if (rc)
> +		return dev_err_probe(chip->dev, rc,
> +				     "Failed to get battery info\n");
> +
> +	rc = devm_delayed_work_autocancel(chip->dev, &chip->status_change_work,
> +					  smb2_status_change_work);
> +	if (rc)
> +		return dev_err_probe(
> +			chip->dev, rc,
> +			"Failed to initialise status change work\n");
> +
> +	rc = (chip->batt_info->voltage_max_design_uv - 3487500) / 7500 + 1;
> +	rc = regmap_update_bits(chip->regmap, chip->base + FLOAT_VOLTAGE_CFG,
> +				FLOAT_VOLTAGE_SETTING_MASK, rc);
> +	if (rc < 0)
> +		return dev_err_probe(chip->dev, rc, "Couldn't set vbat max\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(irqs); i++) {
> +		irq = of_irq_get_byname(pdev->dev.of_node, irqs[i].name);
> +		if (irq < 0)
> +			return dev_err_probe(chip->dev, irq,
> +					     "Couldn't get irq %s byname\n",
> +					     irqs[i].name);
> +		rc = devm_request_threaded_irq(chip->dev, irq, NULL,
> +					       irqs[i].handler, IRQF_ONESHOT,
> +					       irqs[i].name, chip);
> +		if (rc < 0)
> +			return dev_err_probe(chip->dev, irq,
> +					     "Couldn't request irq %s\n",
> +					     irqs[i].name);
> +	}
> +
> +	platform_set_drvdata(pdev, chip);
> +
> +	/* Initialise charger state */
> +	schedule_delayed_work(&chip->status_change_work, 0);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id smb2_match_id_table[] = {
> +	{ .compatible = "qcom,pmi8998-charger" },
> +	{ .compatible = "qcom,pm660-charger" },
> +	{ /* sentinal */ }
> +};
> +MODULE_DEVICE_TABLE(of, smb2_match_id_table);
> +
> +static struct platform_driver qcom_spmi_smb2 = {
> +	.probe = smb2_probe,
> +	.driver = {
> +			.name = "qcom-pmi8998-charger",
> +			.of_match_table = smb2_match_id_table,
> +		},
> +};
> +
> +module_platform_driver(qcom_spmi_smb2);
> +
> +MODULE_AUTHOR("Caleb Connolly <caleb.connolly@linaro.org>");
> +MODULE_DESCRIPTION("Qualcomm SMB2 Charger Driver");
> +MODULE_LICENSE("GPL");

-- 
Kind Regards,
Caleb (they/he)
