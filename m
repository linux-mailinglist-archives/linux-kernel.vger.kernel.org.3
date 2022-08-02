Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84082587AA3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 12:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiHBKZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 06:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiHBKZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 06:25:55 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AA722B3D
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 03:25:53 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id s14so15138504ljh.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 03:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AEY4MLBFWszSDlFsX1O9mcXZWaX+6Dl1GV/cQTUc6HA=;
        b=s1rzN/Sw9Y5GQfYgd0LeTVIqavax9eZL4k200QKPrMdOce0zokiBu7Z1BPc57YByi/
         JeiS155uaIOKsiWqPJQCYGZ47qIFTM/xg1F5JMqu7ct7HE4pyrhC2gZoL6AKqu3GgBp3
         nK53+xstKYZzXp3nSQygsWHXr27ihC02zWPGlvqpaI/a2hgcyHdthFq/GzrTWGVByU6Z
         MXOlU2XcO7XfcEyh053uCNmL8viS7nALBDxXRUpajjk8PnAf/C/WlcWqxRDGS4IizmHP
         ygONNvMJ4NaLSu+0UskdMcDn7wSs5aQacNoKbWfn25tubnykRsDKOId9LlCchgvOpQhW
         LHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AEY4MLBFWszSDlFsX1O9mcXZWaX+6Dl1GV/cQTUc6HA=;
        b=bxTVMWnxF2gxSngn6JHd7q1iClhICg8PFNesuR7oCAAIHOo6aJmzxtcRWFEuIQntkL
         /TluLDQupvtsaRpN5TVZfvVrryVQPg7jTjFtvykK3FvIoibvoav0UoQ+effZaBIMUnaO
         bsTssOa1iPn+gtONwb/lJN0M2XABCzj7Kgj/fTUa9mCNLV0O8U4Q9d247vd8zSGJVEN9
         t4Em9EOupHjAzt/Za1/DtkV1aYYfvPWzfrPBGpLcCZCyTjQEMh3doGylgOQYSCP6Uvac
         xXkanrNiGF+Ee5iYyvTBKv/64XW7KEOhpKb6BxxzZfCNY9V2hk+BrpaK3OMHHA5O3J6+
         Zn1A==
X-Gm-Message-State: AJIora97ea2RFaXX/MmiZSRhzBgCq+TpZnuaPcCAfC29fW8naAwgDJnY
        AVRIeKV4rutd7Ky91WbhmeECrQ==
X-Google-Smtp-Source: AGRyM1s5CzxCKbjkEvHfj9GdL48adB9sjMvugzyxSe5CMJRaBgbhu6zBHXCFiFTQkPxAQr581W3tRQ==
X-Received: by 2002:a2e:bd0a:0:b0:25d:d2a3:7366 with SMTP id n10-20020a2ebd0a000000b0025dd2a37366mr6341676ljq.35.1659435951667;
        Tue, 02 Aug 2022 03:25:51 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id c22-20020a056512239600b0048af7e58c9dsm800641lfv.278.2022.08.02.03.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 03:25:51 -0700 (PDT)
Message-ID: <08b60fe9-6e89-b10e-dcfa-5a0d53912676@linaro.org>
Date:   Tue, 2 Aug 2022 12:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 2/3] spi: microchip-core-qspi: Add support for
 microchip fpga qspi controllers
Content-Language: en-US
To:     Naga Sureshkumar Relli <nagasuresh.relli@microchip.com>,
        broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor.dooley@microchip.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
 <20220802070518.855951-3-nagasuresh.relli@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220802070518.855951-3-nagasuresh.relli@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/2022 09:05, Naga Sureshkumar Relli wrote:
> +
> +	qspi->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(qspi->clk)) {
> +		dev_err(&pdev->dev, "clock not found.\n");

Same comments as v1.

> +		ret = PTR_ERR(qspi->clk);
> +		goto remove_master;
> +	}
> +
> +	ret = clk_prepare_enable(qspi->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable clock\n");
> +		goto remove_master;
> +	}
> +
> +	init_completion(&qspi->data_completion);
> +	mutex_init(&qspi->op_lock);
> +
> +	qspi->irq = platform_get_irq(pdev, 0);
> +	if (qspi->irq <= 0) {
> +		ret = qspi->irq;
> +		goto clk_dis_all;
> +	}
> +
> +	ret = devm_request_irq(&pdev->dev, qspi->irq, mchp_coreqspi_isr,
> +			       IRQF_SHARED, pdev->name, qspi);
> +	if (ret) {
> +		dev_err(&pdev->dev, "request_irq failed %d\n", ret);
> +		goto clk_dis_all;
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
> +		dev_err(&pdev->dev, "spi_register_controller failed\n");
> +		goto clk_dis_all;
> +	}
> +
> +	return 0;
> +
> +clk_dis_all:
> +	clk_disable_unprepare(qspi->clk);
> +remove_master:
> +	spi_controller_put(ctlr);
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
> +/*
> + * Platform driver data structure

Same comments as v1.

> + */
> +static const struct of_device_id mchp_coreqspi_of_match[] = {
> +	{ .compatible = "microchip,mpfs-qspi" },
> +	{ .compatible = "microchip,coreqspi-rtl-v2" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, mchp_coreqspi_of_match);
> +
Best regards,
Krzysztof
