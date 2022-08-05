Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A37558A61B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 08:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiHEGu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 02:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237056AbiHEGuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 02:50:24 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5AB657C
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 23:50:23 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id u1so2167009lfq.4
        for <linux-kernel@vger.kernel.org>; Thu, 04 Aug 2022 23:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=w//oEYkxKLZP7+M9mPB9IWKTzjoWEpUFVpft/ULSal0=;
        b=Ikd87Lm3WlRmINOS41DAZh53F0MJ83O2+7wDpG9bG6gMkRGuDoDMesGsgnVlIZ7IX2
         B+pHXQXxSN6S/JrpCAjADfkVnb5OEQeyUTbwbOrlKWGUTNNWylK8g9kIyzcvQTPisW8d
         W9GukQljLKZluHkFXviN1cAoHFyM2Ee+ebR8oHcv+tZio2a5gO2NZKcZfDWsZxp8EqXv
         tbXJX7QhQPBh5YtBv6ex897/GTQsP7JEXMYLSj1EzKTuKDb5J3GqDy1rEi98UE1aeOw+
         lDHjusDOi9ciy+uFUlS6iJtQxtvETQn6agWq+KyXcPlSeHWWq1XR+nosuFtBrS7ZjTJt
         5CPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=w//oEYkxKLZP7+M9mPB9IWKTzjoWEpUFVpft/ULSal0=;
        b=ZvvHlQD36psm2orW5wxzbBm4tgWhC4MQY1mEsQv0cISKVbtDzkEjytxvB72WKtr6GK
         uwph8r0xGGBQm9509qkP5uV8cBNHnDqAJGUcWc2REeHTn55gPp0yCAM5cCpPbF2rXzB0
         wOSzb/YNfikQA1luW8DbWqJDHmU5ndTtk9d/4DQsnYD7ykvSo6igOKqIodqVni/mvYAf
         SkFkXAUA+vDZzLtaw//PDw3gUgJP/mRDPs3HQ4glNrBDYm9J1IzCxeOSJp8++MDMiMfm
         MxMoxZ3nqB4csOGdALw0E0ObPqXf+tz9/a5Ai6aUal8/FJQdxIUq/iP6f3uaQkKOkdN0
         wR9w==
X-Gm-Message-State: ACgBeo0Dhrx+D2Ugqtxtdv+LY6tZrMa8iWyjo891JCtOUFg0AZM2O/lB
        BQ61sK2WvbRkdDqgs0qU4aC7ng==
X-Google-Smtp-Source: AA6agR5Ttd978HDJdAUrP25Vdcd2amJJ7sP1QJTjfCq7ciREYFeo2cj0L+0l3JS2RYk7nAqf1zmuCA==
X-Received: by 2002:a05:6512:3f89:b0:489:e611:5533 with SMTP id x9-20020a0565123f8900b00489e6115533mr1737782lfa.624.1659682221666;
        Thu, 04 Aug 2022 23:50:21 -0700 (PDT)
Received: from [192.168.1.6] ([77.222.167.48])
        by smtp.gmail.com with ESMTPSA id s17-20020a056512203100b0048b03b4b018sm360216lfs.283.2022.08.04.23.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 23:50:20 -0700 (PDT)
Message-ID: <fa9fca3b-4b8b-1a51-3e8b-45f1ae2e15df@linaro.org>
Date:   Fri, 5 Aug 2022 08:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 3/4] spi: microchip-core-qspi: Add support for
 microchip fpga qspi controllers
Content-Language: en-US
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Valentina.FernandezAlanis@microchip.com
References: <20220805053019.996484-1-nagasuresh.relli@microchip.com>
 <20220805053019.996484-4-nagasuresh.relli@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805053019.996484-4-nagasuresh.relli@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 07:30, Naga Sureshkumar Relli wrote:
> Add a driver for Microchip FPGA QSPI controllers. This driver also
> supports "hard" QSPI controllers on Polarfire SoC.
> 

Thank you for your patch. There is something to discuss/improve.

> +	ret = clk_prepare_enable(qspi->clk);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "failed to enable clock\n");
> +
> +	init_completion(&qspi->data_completion);
> +	mutex_init(&qspi->op_lock);
> +
> +	qspi->irq = platform_get_irq(pdev, 0);
> +	if (qspi->irq <= 0) {


< 0
Why did you change it to <=?

> +		ret = qspi->irq;
> +		goto out;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
> +			       IRQF_SHARED, pdev->name, qspi);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request_irq failed %d\n", ret);
> +		goto out;
> +	}
> +
> +	ctlr->bits_per_word_mask = SPI_BPW_MASK(8);
> +	ctlr->mem_ops = &mchp_coreqspi_mem_ops;
> +	ctlr->setup = mchp_coreqspi_setup_op;
> +	ctlr->mode_bits = SPI_CPOL | SPI_CPHA | SPI_RX_DUAL | SPI_RX_QUAD |
> +			  SPI_TX_DUAL | SPI_TX_QUAD;
> +	ctlr->dev.of_node = np;
> +
> +	ret = devm_spi_register_controller(&pdev->dev, ctlr);
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret,
> +			      "spi_register_controller failed\n");
> +		goto out;
> +	}
> +
> +	return 0;
> +
> +out:
> +	clk_disable_unprepare(qspi->clk);
> +
> +	return ret;
> +}
> +
> +static int mchp_coreqspi_remove(struct platform_device *pdev)
> +{
> +	struct mchp_coreqspi *qspi = platform_get_drvdata(pdev);
> +	u32 control = readl_relaxed(qspi->regs + REG_CONTROL);
> +
> +	mchp_coreqspi_disable_ints(qspi);
> +	control &= ~CONTROL_ENABLE;
> +	writel_relaxed(control, qspi->regs + REG_CONTROL);
> +	clk_disable_unprepare(qspi->clk);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mchp_coreqspi_of_match[] = {
> +	{ .compatible = "microchip,mpfs-qspi" },
> +	{ .compatible = "microchip,coreqspi-rtl-v2" },

This is not what the binding is saying.


Best regards,
Krzysztof
