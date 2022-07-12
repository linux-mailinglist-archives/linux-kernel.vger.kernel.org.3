Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A0257131F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 09:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbiGLHat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 03:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiGLHar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 03:30:47 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974929823A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:30:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id o12so6278950ljc.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 00:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:cc:references
         :content-language:subject:in-reply-to:content-transfer-encoding;
        bh=qmRz58rYeDna1qtqaoOsFlhahAOJ+94hc1U+kQmwe5E=;
        b=cA+53h04uNghyN4MQf7ppUicBUaCPXrYx9t63fOUE7RW6mE5LYqITh+lyftcxfZBT8
         fNPleQhN6defLI9sKIJGlfIjaLnguMOeg8mJ2GLT76JG1YrtZBPms7SqafiT+0onp3Ut
         xa+wVF84ft1CBYHTVdv9VogMpszgw9Y7/J5sUrpkUZBN6QwAA8+GOPq4awE3W2w88RRg
         Lm9Y2KuOr58tLUa5MBzEdqkRx1KsiBdAGCWaAfKQv2Bq4uOweXGpc38rBkrj4Yhqqsi6
         OH518LmTy17Pr2ggzY/DrevUausJXGZbdnVBdKx19qfpIckFH13+eizLohlB2X6VzyLB
         SbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :cc:references:content-language:subject:in-reply-to
         :content-transfer-encoding;
        bh=qmRz58rYeDna1qtqaoOsFlhahAOJ+94hc1U+kQmwe5E=;
        b=4Uk+H7FgSewrKvS0//ZjbN2CR6PvPyT3aNAWY4X46TO3mhWUDk0PvOkbjj3Dx+efhd
         oon5qFAx91dCb+W9hgzoDNAPZYF03PSh6Cwt7vLjF4g6JzACLwQmFnFhrGDGRKezmwbv
         NB9AM6K1yfPjF5FDS43lQoukk07ZUQXhrrs5pmBjXlRzdsKFuwBS0thToA4RAda56d0k
         sufzIXai+Yh1BUXrdue1Z9xPBkErVjUpjOq1j+hzHBMkflRtW0Wb0JGAuH9H72Xy8a4C
         UlfbnPxOwglEi7rHPXw73zyJYfkBze5RC/CEc87K/eFubq84nCRqW8c8ORdWlepKXXLr
         G3rg==
X-Gm-Message-State: AJIora+kGkEyVlxl2oHsRrJepef+GPerSQK3DyrItd0JEJP2zwUie7KK
        HSSBZnvFSXStz0WOiFgcvuA3iMasl1w=
X-Google-Smtp-Source: AGRyM1vTs88Wo7iUOmefxppuvhOteutKvvs8bgg2c5bDejPrYtdgTz/HcPDMwESq6teC950fg2xTHA==
X-Received: by 2002:a2e:3603:0:b0:25d:8072:55cd with SMTP id d3-20020a2e3603000000b0025d807255cdmr345442lja.489.1657611042798;
        Tue, 12 Jul 2022 00:30:42 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16ee:fa00::5? (dc73szyyyyyyyyyyyyyct-3.rev.dnainternet.fi. [2001:14ba:16ee:fa00::5])
        by smtp.gmail.com with ESMTPSA id f14-20020a05651c02ce00b0025d754ba5f4sm617583ljo.99.2022.07.12.00.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 00:30:42 -0700 (PDT)
Message-ID: <c03fd83f-97b3-1837-b7fd-5f3f28c4b557@gmail.com>
Date:   Tue, 12 Jul 2022 10:30:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Matti Vaittinen <mazziesaccount@gmail.com>
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
References: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
 <20220705122244.472894-4-Naresh.Solanki@9elements.com>
Content-Language: en-US
Subject: Re: [PATCH 3/5] regulator: max597x: Add support for max597x regulator
In-Reply-To: <20220705122244.472894-4-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/5/22 15:22, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> max597x is hot swap controller.
> This regulator driver controls the same & also configures fault
> protection features supported by the chip.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>

I like the way the IRQ helpers have been used here. It'd be cool to hear 
how the rest of the system you're dealing with utilize the WARN level 
events :)

> +static int max597x_set_ocp(struct regulator_dev *rdev, int lim_uA,
> +			   int severity, bool enable)
> +{
> +	int ret, val, reg;
> +	unsigned int vthst, vthfst;
> +
> +	struct max597x_regulator *data = rdev_get_drvdata(rdev);
> +	int rdev_id = rdev_get_id(rdev);
> +	/*
> +	 * MAX5970 doesn't has enable control for ocp.
> +	 * If limit is specified but enable is not set then hold the value in
> +	 * variable & later use it when ocp needs to be enabled.
> +	 */

Is this a possible scenario? I think that if a non zero limit is given 
in a "regulator-oc-protection-microamp"-property, then the protection 
should always be enabled. Am I overlooking something?

> +	if (lim_uA != 0 && lim_uA != data->lim_uA)
> +		data->lim_uA = lim_uA;
> +
> +	if (severity != REGULATOR_SEVERITY_PROT)
> +		return -EINVAL;
> +
> +	if (enable) {
> +
> +		/* Calc Vtrip threshold in uV. */
> +		vthst =
> +		    div_u64(mul_u32_u32(data->shunt_micro_ohms, data->lim_uA),
> +			    1000000);
> +
> +		/*
> +		 * As recommended in datasheed, add 20% margin to avoid
> +		 * spurious event & passive component tolerance.
> +		 */
> +		vthst = div_u64(mul_u32_u32(vthst, 120), 100);
> +
> +		/* Calc fast Vtrip threshold in uV */
> +		vthfst = vthst * (MAX5970_FAST2SLOW_RATIO / 100);
> +
> +		if (vthfst > data->irng) {
> +			dev_err(&rdev->dev, "Current limit out of range\n");
> +			return -EINVAL;
> +		}
> +		/* Fast trip threshold to be programmed */
> +		val = div_u64(mul_u32_u32(0xFF, vthfst), data->irng);
> +	} else
> +		/*
> +		 * Since there is no option to disable ocp, set limit to max
> +		 * value
> +		 */
> +		val = 0xFF;
> +
> +	reg = MAX5970_REG_DAC_FAST(rdev_id);
> +	ret = regmap_write(rdev->regmap, reg, val);
> +
> +	return ret;
> +}
> +

> +static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
> +			       unsigned long *dev_mask)
> +{
> +	struct regulator_err_state *stat;
> +	struct max597x_regulator *d = (struct max597x_regulator *)rid->data;
> +	int val, ret, i;
> + > +	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT0, &val);
> +	if (ret)
> +		return REGULATOR_FAILED_RETRY;

This "read_clear" smells like a race-by-design to me...

> +
> +	*dev_mask = 0;
> +	for (i = 0; i < d->num_switches; i++) {
> +		stat = &rid->states[i];
> +		stat->notifs = 0;
> +		stat->errors = 0;
> +	}
> +
> +	for (i = 0; i < d->num_switches; i++) {
> +		stat = &rid->states[i];
> +
> +		if (val & UV_STATUS_CRIT(i)) {
> +			*dev_mask |= 1 << i;
> +			stat->notifs |= REGULATOR_EVENT_UNDER_VOLTAGE;
> +			stat->errors |= REGULATOR_ERROR_UNDER_VOLTAGE;
> +		} else if (val & UV_STATUS_WARN(i)) {
> +			*dev_mask |= 1 << i;
> +			stat->notifs |= REGULATOR_EVENT_UNDER_VOLTAGE_WARN;
> +			stat->errors |= REGULATOR_ERROR_UNDER_VOLTAGE_WARN;
> +		}
> +	}
> +
> +	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT1, &val);
> +	if (ret)
> +		return REGULATOR_FAILED_RETRY;

... and same here...

> +
> +	for (i = 0; i < d->num_switches; i++) {
> +		stat = &rid->states[i];
> +
> +		if (val & OV_STATUS_CRIT(i)) {
> +			*dev_mask |= 1 << i;
> +			stat->notifs |= REGULATOR_EVENT_REGULATION_OUT;
> +			stat->errors |= REGULATOR_ERROR_REGULATION_OUT;
> +		} else if (val & OV_STATUS_WARN(i)) {
> +			*dev_mask |= 1 << i;
> +			stat->notifs |= REGULATOR_EVENT_OVER_VOLTAGE_WARN;
> +			stat->errors |= REGULATOR_ERROR_OVER_VOLTAGE_WARN;
> +		}
> +	}
> +
> +	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT2, &val);
> +	if (ret)
> +		return REGULATOR_FAILED_RETRY;
> +

... and here. I wonder if the reason for "clearing" would be worth 
commenting?

> +	for (i = 0; i < d->num_switches; i++) {
> +		stat = &rid->states[i];
> +
> +		if (val & OC_STATUS_WARN(i)) {
> +			*dev_mask |= 1 << i;
> +			stat->notifs |= REGULATOR_EVENT_OVER_CURRENT_WARN;
> +			stat->errors |= REGULATOR_ERROR_OVER_CURRENT_WARN;
> +		}
> +	}
> +
> +	ret = regmap_read(d->regmap, MAX5970_REG_STATUS0, &val);
> +	if (ret)
> +		return REGULATOR_FAILED_RETRY;
> +
> +	for (i = 0; i < d->num_switches; i++) {
> +		stat = &rid->states[i];
> +
> +		if ((val & MAX5970_CB_IFAULTF(i))
> +		    || (val & MAX5970_CB_IFAULTS(i))) {
> +			*dev_mask |= 1 << i;
> +			stat->notifs |=
> +			    REGULATOR_EVENT_OVER_CURRENT |
> +			    REGULATOR_EVENT_DISABLE;
> +			stat->errors |=
> +			    REGULATOR_ERROR_OVER_CURRENT | REGULATOR_ERROR_FAIL;
> +
> +			/* Clear the sub-IRQ status */
> +			regulator_disable_regmap(stat->rdev);
> +		}
> +	}
> +	return 0;
> +}
> +

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

Discuss - Estimate - Plan - Report and finally accomplish this:
void do_work(int time) __attribute__ ((const));

