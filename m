Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001934BB4B0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiBRI6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:58:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbiBRI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:58:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C383B1D329;
        Fri, 18 Feb 2022 00:58:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58087B82588;
        Fri, 18 Feb 2022 08:58:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26404C340E9;
        Fri, 18 Feb 2022 08:58:25 +0000 (UTC)
Message-ID: <b6d17e50-7ab5-2056-f355-587fa2108047@xs4all.nl>
Date:   Fri, 18 Feb 2022 09:58:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 2/2] media: cec: seco: add newlines in debug messages
Content-Language: en-US
To:     ektor5 <ek5.chimenti@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linuxfancy@googlegroups.com
References: <20220215181313.264698-1-ek5.chimenti@gmail.com>
 <20220215181313.264698-3-ek5.chimenti@gmail.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220215181313.264698-3-ek5.chimenti@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2022 19:13, ektor5 wrote:
> From: Ettore Chimenti <ek5.chimenti@gmail.com>
> 
> Newlines were missing in almost all regular and debug printk.

Thank you. I'll take this patch, so no need to repost this one in a v3.

Regards,

	Hans

> 
> Signed-off-by: Ettore Chimenti <ek5.chimenti@gmail.com>
> ---
>  drivers/media/cec/platform/seco/seco-cec.c | 54 +++++++++++-----------
>  1 file changed, 27 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/media/cec/platform/seco/seco-cec.c b/drivers/media/cec/platform/seco/seco-cec.c
> index ae138cc253fd..78856a55e637 100644
> --- a/drivers/media/cec/platform/seco/seco-cec.c
> +++ b/drivers/media/cec/platform/seco/seco-cec.c
> @@ -129,7 +129,7 @@ static int secocec_adap_enable(struct cec_adapter *adap, bool enable)
>  		if (status)
>  			goto err;
>  
> -		dev_dbg(dev, "Device enabled");
> +		dev_dbg(dev, "Device enabled\n");
>  	} else {
>  		/* Clear the status register */
>  		status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
> @@ -141,7 +141,7 @@ static int secocec_adap_enable(struct cec_adapter *adap, bool enable)
>  				  ~SECOCEC_ENABLE_REG_1_CEC &
>  				  ~SECOCEC_ENABLE_REG_1_IR);
>  
> -		dev_dbg(dev, "Device disabled");
> +		dev_dbg(dev, "Device disabled\n");
>  	}
>  
>  	return 0;
> @@ -264,12 +264,12 @@ static void secocec_rx_done(struct cec_adapter *adap, u16 status_val)
>  
>  	if (status_val & SECOCEC_STATUS_RX_OVERFLOW_MASK) {
>  		/* NOTE: Untested, it also might not be necessary */
> -		dev_warn(dev, "Received more than 16 bytes. Discarding");
> +		dev_warn(dev, "Received more than 16 bytes. Discarding\n");
>  		flag_overflow = true;
>  	}
>  
>  	if (status_val & SECOCEC_STATUS_RX_ERROR_MASK) {
> -		dev_warn(dev, "Message received with errors. Discarding");
> +		dev_warn(dev, "Message received with errors. Discarding\n");
>  		status = -EIO;
>  		goto rxerr;
>  	}
> @@ -390,12 +390,12 @@ static int secocec_ir_probe(void *priv)
>  	if (status != 0)
>  		goto err;
>  
> -	dev_dbg(dev, "IR enabled");
> +	dev_dbg(dev, "IR enabled\n");
>  
>  	status = devm_rc_register_device(dev, cec->ir);
>  
>  	if (status) {
> -		dev_err(dev, "Failed to prepare input device");
> +		dev_err(dev, "Failed to prepare input device\n");
>  		cec->ir = NULL;
>  		goto err;
>  	}
> @@ -408,7 +408,7 @@ static int secocec_ir_probe(void *priv)
>  	smb_wr16(SECOCEC_ENABLE_REG_1,
>  		 val & ~SECOCEC_ENABLE_REG_1_IR);
>  
> -	dev_dbg(dev, "IR disabled");
> +	dev_dbg(dev, "IR disabled\n");
>  	return status;
>  }
>  
> @@ -431,13 +431,13 @@ static int secocec_ir_rx(struct secocec_data *priv)
>  
>  	rc_keydown(cec->ir, RC_PROTO_RC5, RC_SCANCODE_RC5(addr, key), toggle);
>  
> -	dev_dbg(dev, "IR key pressed: 0x%02x addr 0x%02x toggle 0x%02x", key,
> +	dev_dbg(dev, "IR key pressed: 0x%02x addr 0x%02x toggle 0x%02x\n", key,
>  		addr, toggle);
>  
>  	return 0;
>  
>  err:
> -	dev_err(dev, "IR Receive message failed (%d)", status);
> +	dev_err(dev, "IR Receive message failed (%d)\n", status);
>  	return -EIO;
>  }
>  #else
> @@ -497,7 +497,7 @@ static irqreturn_t secocec_irq_handler(int irq, void *priv)
>  	return IRQ_HANDLED;
>  
>  err:
> -	dev_err_once(dev, "IRQ: R/W SMBus operation failed (%d)", status);
> +	dev_err_once(dev, "IRQ: R/W SMBus operation failed %d\n", status);
>  
>  	/*  Reset status register */
>  	val = SECOCEC_STATUS_REG_1_CEC | SECOCEC_STATUS_REG_1_IR;
> @@ -553,16 +553,16 @@ static int secocec_acpi_probe(struct secocec_data *sdev)
>  
>  	gpio = devm_gpiod_get(dev, NULL, GPIOF_IN);
>  	if (IS_ERR(gpio)) {
> -		dev_err(dev, "Cannot request interrupt gpio");
> +		dev_err(dev, "Cannot request interrupt gpio\n");
>  		return PTR_ERR(gpio);
>  	}
>  
>  	irq = gpiod_to_irq(gpio);
>  	if (irq < 0) {
> -		dev_err(dev, "Cannot find valid irq");
> +		dev_err(dev, "Cannot find valid irq\n");
>  		return -ENODEV;
>  	}
> -	dev_dbg(dev, "irq-gpio is bound to IRQ %d", irq);
> +	dev_dbg(dev, "irq-gpio is bound to IRQ %d\n", irq);
>  
>  	sdev->irq = irq;
>  
> @@ -590,7 +590,7 @@ static int secocec_probe(struct platform_device *pdev)
>  
>  	/* Request SMBus regions */
>  	if (!request_muxed_region(BRA_SMB_BASE_ADDR, 7, "CEC00001")) {
> -		dev_err(dev, "Request memory region failed");
> +		dev_err(dev, "Request memory region failed\n");
>  		return -ENXIO;
>  	}
>  
> @@ -598,14 +598,14 @@ static int secocec_probe(struct platform_device *pdev)
>  	secocec->dev = dev;
>  
>  	if (!has_acpi_companion(dev)) {
> -		dev_dbg(dev, "Cannot find any ACPI companion");
> +		dev_dbg(dev, "Cannot find any ACPI companion\n");
>  		ret = -ENODEV;
>  		goto err;
>  	}
>  
>  	ret = secocec_acpi_probe(secocec);
>  	if (ret) {
> -		dev_err(dev, "Cannot assign gpio to IRQ");
> +		dev_err(dev, "Cannot assign gpio to IRQ\n");
>  		ret = -ENODEV;
>  		goto err;
>  	}
> @@ -613,11 +613,11 @@ static int secocec_probe(struct platform_device *pdev)
>  	/* Firmware version check */
>  	ret = smb_rd16(SECOCEC_VERSION, &val);
>  	if (ret) {
> -		dev_err(dev, "Cannot check fw version");
> +		dev_err(dev, "Cannot check fw version\n");
>  		goto err;
>  	}
>  	if (val < SECOCEC_LATEST_FW) {
> -		dev_err(dev, "CEC Firmware not supported (v.%04x). Use ver > v.%04x",
> +		dev_err(dev, "CEC Firmware not supported (v.%04x). Use ver > v.%04x\n",
>  			val, SECOCEC_LATEST_FW);
>  		ret = -EINVAL;
>  		goto err;
> @@ -631,7 +631,7 @@ static int secocec_probe(struct platform_device *pdev)
>  					dev_name(&pdev->dev), secocec);
>  
>  	if (ret) {
> -		dev_err(dev, "Cannot request IRQ %d", secocec->irq);
> +		dev_err(dev, "Cannot request IRQ %d\n", secocec->irq);
>  		ret = -EIO;
>  		goto err;
>  	}
> @@ -666,7 +666,7 @@ static int secocec_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, secocec);
>  
> -	dev_dbg(dev, "Device registered");
> +	dev_dbg(dev, "Device registered\n");
>  
>  	return ret;
>  
> @@ -691,14 +691,14 @@ static int secocec_remove(struct platform_device *pdev)
>  
>  		smb_wr16(SECOCEC_ENABLE_REG_1, val & ~SECOCEC_ENABLE_REG_1_IR);
>  
> -		dev_dbg(&pdev->dev, "IR disabled");
> +		dev_dbg(&pdev->dev, "IR disabled\n");
>  	}
>  	cec_notifier_cec_adap_unregister(secocec->notifier, secocec->cec_adap);
>  	cec_unregister_adapter(secocec->cec_adap);
>  
>  	release_region(BRA_SMB_BASE_ADDR, 7);
>  
> -	dev_dbg(&pdev->dev, "CEC device removed");
> +	dev_dbg(&pdev->dev, "CEC device removed\n");
>  
>  	return 0;
>  }
> @@ -709,7 +709,7 @@ static int secocec_suspend(struct device *dev)
>  	int status;
>  	u16 val;
>  
> -	dev_dbg(dev, "Device going to suspend, disabling");
> +	dev_dbg(dev, "Device going to suspend, disabling\n");
>  
>  	/* Clear the status register */
>  	status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
> @@ -733,7 +733,7 @@ static int secocec_suspend(struct device *dev)
>  	return 0;
>  
>  err:
> -	dev_err(dev, "Suspend failed (err: %d)", status);
> +	dev_err(dev, "Suspend failed: %d\n", status);
>  	return status;
>  }
>  
> @@ -742,7 +742,7 @@ static int secocec_resume(struct device *dev)
>  	int status;
>  	u16 val;
>  
> -	dev_dbg(dev, "Resuming device from suspend");
> +	dev_dbg(dev, "Resuming device from suspend\n");
>  
>  	/* Clear the status register */
>  	status = smb_rd16(SECOCEC_STATUS_REG_1, &val);
> @@ -762,12 +762,12 @@ static int secocec_resume(struct device *dev)
>  	if (status)
>  		goto err;
>  
> -	dev_dbg(dev, "Device resumed from suspend");
> +	dev_dbg(dev, "Device resumed from suspend\n");
>  
>  	return 0;
>  
>  err:
> -	dev_err(dev, "Resume failed (err: %d)", status);
> +	dev_err(dev, "Resume failed: %d\n", status);
>  	return status;
>  }
>  

