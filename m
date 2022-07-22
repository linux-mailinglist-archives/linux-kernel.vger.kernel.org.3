Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF0557DF71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbiGVKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 06:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbiGVKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 06:12:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9134974784
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:12:08 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h9so5881663wrm.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 03:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qxv2ZhAI5MpFdkuiCRvtOt/8KqoKWgf/252g6XKRWx8=;
        b=oJx0GRmFxA6+ajzy2KolNsEFTF1kyeoaTAQaRIzv5/SWIy0DM5VqveWvKM/STHymUF
         KKY88AZp0hIAYLfwsJmu3GJFWC+OMpla0TjqeSftOs/3df1Jq9De7Q2t8jPtSJFJ52+m
         JLylmGZF4WiPErIgDfrHfe/5lwAWk/jrf3YaIAyERe0oCkm3xCSCq5+WcBxZtRxaI03+
         ZZDhW8KjvSgA5PBCzDWnEb6R/rO+xJEmlOfsCzHXWSgCrVBgUSd9lcyGyApvRLCw30vL
         vVziejAq4SrPkpQJEpAxoNZIBeZ1UTe1JaemfLhDCfIJ2Fhhe05zkXLq5K3P5tQ8jObN
         Tqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qxv2ZhAI5MpFdkuiCRvtOt/8KqoKWgf/252g6XKRWx8=;
        b=7dSjlOyV+k90TG256uEInKmU353oO+40cmOFCiNf37wS/Tv0pU5eAbB0t9JDExA6vt
         YGhBRQjBjL7Cs3ICaRO52YNrCRR9+nx25NNxtbr8ZuogK4igcvYHQBaVHxXK23DZUFNC
         /mvWxxPnIaEqUwCEvGvseWQuEAB/dA42sYNRXqy0F6C71Ahjo3tVyDyDafqmsYFMe0lt
         vQjolzWTkp+V6Q3BGQyo0shprXxVxxIt3wPsYFDeLOS5H3rHxV6HVyPK0+EtHW9Wp/cQ
         lxbZ2HdEW6Vxe6/UZlAEAOfPW5RGgDcyPASV6ohUuu8h7OEiVW6QeElo7oOimmusKZaO
         zO1g==
X-Gm-Message-State: AJIora+arZVtTPmxS/X05PRtbp4UqAm/qxsI3zmiTY5RL/zghwe0iwgG
        dkxkK+OwF09y/wIo91YpVi8sTQ==
X-Google-Smtp-Source: AGRyM1t92A+Ond+L5Gp2qLwoiAC/AfSjImgpKsz47kk5lRbpk6gCGR7r9lSleY/Svw+/yIe1tqxtcQ==
X-Received: by 2002:a5d:67ca:0:b0:21e:5ba8:a067 with SMTP id n10-20020a5d67ca000000b0021e5ba8a067mr2011825wrw.650.1658484726796;
        Fri, 22 Jul 2022 03:12:06 -0700 (PDT)
Received: from [10.2.4.117] (lfbn-nic-1-76-188.w2-15.abo.wanadoo.fr. [2.15.166.188])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0021e50971147sm4084202wrl.44.2022.07.22.03.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 03:12:06 -0700 (PDT)
Message-ID: <b89db08e-3a06-5a8d-2c24-eb087ee3ca7e@baylibre.com>
Date:   Fri, 22 Jul 2022 12:12:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 08/14] regulator: drivers: Add TI TPS65219 PMIC
 regulators support
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.c, lee.jones@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220719091742.3221-1-jneanne@baylibre.com>
 <20220719091742.3221-9-jneanne@baylibre.com> <YtayikFdidxXXubS@sirena.org.uk>
From:   jerome Neanne <jneanne@baylibre.com>
In-Reply-To: <YtayikFdidxXXubS@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/07/2022 15:32, Mark Brown wrote:
> On Tue, Jul 19, 2022 at 11:17:36AM +0200, Jerome Neanne wrote:
>
>> @@ -0,0 +1,414 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * tps65219-regulator.c
>> + *
> Please make the entire comment a C++ one so things look more
> intentional.
>
>> +static int tps65219_pmic_set_voltage_sel(struct regulator_dev *dev,
>> +					 unsigned int selector)
>> +{
>> +	int ret;
>> +	struct tps65219 *tps = rdev_get_drvdata(dev);
>> +
>> +	/* Set the voltage based on vsel value */
>> +	ret = regmap_update_bits(tps->regmap, dev->desc->vsel_reg,
>> +				 dev->desc->vsel_mask, selector);
>> +	if (ret) {
>> +		dev_dbg(tps->dev, "%s failed for regulator %s: %d ",
>> +			__func__, dev->desc->name, ret);
>> +	}
>> +	return ret;
>> +}
> This should just be able to use the standard regmap helper, as should
> the enable and disable operations?
>
>> +static int tps65219_set_mode(struct regulator_dev *dev, unsigned int mode)
>> +{
>> +	struct tps65219 *tps = rdev_get_drvdata(dev);
>> +
>> +	switch (mode) {
>> +	case REGULATOR_MODE_NORMAL:
>> +		return regmap_set_bits(tps->regmap, TPS65219_REG_STBY_1_CONFIG,
>> +				       dev->desc->enable_mask);
>> +
>> +	case REGULATOR_MODE_STANDBY:
>> +		return regmap_clear_bits(tps->regmap,
>> +					 TPS65219_REG_STBY_1_CONFIG,
>> +					 dev->desc->enable_mask);
>> +	}
>> +
>> +	return -EINVAL;
> It'd be a little clearer to have that -EINVAL in a default statement.
>
>> +static irqreturn_t tps65219_regulator_irq_handler(int irq, void *data)
>> +{
>> +	struct tps65219_regulator_irq_data *irq_data = data;
>> +
>> +	if (irq_data->type->event_name[0] == '\0') {
>> +		/* This is the timeout interrupt */
>> +		dev_err(irq_data->dev, "System was put in shutdown during an active or standby transition.\n");
>> +		return IRQ_HANDLED;
>> +	}
>> +
>> +	dev_err(irq_data->dev, "Registered %s for %s\n",
>> +		irq_data->type->event_name, irq_data->type->regulator_name);
> This should be reporting the events through the notification API, see
> regulator_notifier_call_chain().  That will require a bit of refactoring
> of the way the driver is registering interrupts unfortunately, at the
> minute it doesn't have data joining them up with the
>
> I'd also reword that log message to be something more like "Error %s
> reported for %s" - at the minute it looks more like a probe message.
>
> Otherwise this looks good.
Thanks for your review.

Refactoring the code with regulator_notifier_call_chain, I realized that 
some of the events in TPS65219 are not listed as standard 
REGULATOR_EVENT in consumer.h

This is the case for below event list:
REGULATOR_EVENT_SCG (ShortCut to Gnd)

REGULATOR_EVENT_RV (Residual Voltage)

REGULATOR_EVENT_RV_SD (Residual Voltage ShutDown)

Should I add those events to the list of standard regulator events and 
assign a code? (if yes, any rule for the values?)
Would it fit with some other predefined standard macro defined 
elsewhere? (if yes, could you point me to the right location?)

> @@ -0,0 +1,414 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tps65219-regulator.c
> + *

Please make the entire comment a C++ one so things look more
intentional.

checkpatch is complaining about that:

---------------------------------------------------------------------
v5.19-rc6-PB-MSP1/0005-mfd-drivers-Add-TI-TPS65219-PMIC-support.patch
---------------------------------------------------------------------
WARNING: Improper SPDX comment style for 'drivers/mfd/tps65219.c', please use '//' instead
#91: FILE: drivers/mfd/tps65219.c:1:
+/* SPDX-License-Identifier: GPL-2.0

Let me know if I should ignore checkpatch recommendations here.

Regards,
Jerome

