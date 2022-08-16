Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7BA595552
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiHPIbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiHPIaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:30:25 -0400
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B7232045;
        Mon, 15 Aug 2022 22:51:47 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id b96so12167187edf.0;
        Mon, 15 Aug 2022 22:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=1ih+voLW+z6C3I6dHpxHJWJWHtWsfqymODQS01+snEQ=;
        b=jqCw4c+ZUkAxsXm/a/9uAbggdb7J26pLNQTLhOiGKgKR0AAS7rYPYn3H92fLe/3wQv
         SX2l7F4ervNC/JFVtrpQ1YD46icvnUaBGf7yxJ6OGKKhVCUov2K/07vMwJqfqrUUAXn/
         +gfghcW7qJEg+Yz6kgiop3n3fQKcW3gVnaDBDO3MFMdh3G1lbtqmU11eC4AbVHRaSs7c
         d9wUvLxhbVpuBgAz7MSmHGc28Ne+trJ03xKtuRESVSWCsCzyRb8rDRNA/v1/2IJ9yz3f
         5B4cdAWJ0QX6T7OKf+haZ/iIkQbwekNY6JTZgI/S3SXLbDK7D44qlGuy1us4v+IeosJH
         PSTg==
X-Gm-Message-State: ACgBeo0qyXdtfmM3FOs+KzNPa5pLYbye81K6/l44CCeSE4yjN9+vh5SJ
        KvME64PczGJQ0jApjD/8JTZ2B/XzrIU=
X-Google-Smtp-Source: AA6agR7u1/TsaZ9tkBYkoBI/0txZJv80w+vrjmw9Jdz2f/g1MTrWM6q27PsQ06UF3EEydThAd1yOCg==
X-Received: by 2002:a05:6402:2751:b0:443:d90a:43d4 with SMTP id z17-20020a056402275100b00443d90a43d4mr5588490edd.368.1660629105474;
        Mon, 15 Aug 2022 22:51:45 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id u19-20020a05640207d300b0043bb8023caesm7836006edy.62.2022.08.15.22.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 22:51:45 -0700 (PDT)
Message-ID: <237679cc-1b1a-ac8d-f277-a75cf582a62a@kernel.org>
Date:   Tue, 16 Aug 2022 07:51:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH] serial: icom: Fix some indentation
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-serial@vger.kernel.org
References: <037fc7510ff88945e3f0a5756de4cfd135c59849.1660565015.git.christophe.jaillet@wanadoo.fr>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <037fc7510ff88945e3f0a5756de4cfd135c59849.1660565015.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 08. 22, 14:05, Christophe JAILLET wrote:
> checkpatch and smatch report some code alignment issues.
> 
> So remove some unneeded leading spaces to fix the warnings.
> 
> While at it remove some {} around a single statement and convert some
> spaces into a tab.

Looks good, but maintainers don't like the "While at it" part :D.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/tty/serial/icom.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
> index 45df29947fe8..3ac81622c4fb 100644
> --- a/drivers/tty/serial/icom.c
> +++ b/drivers/tty/serial/icom.c
> @@ -1727,10 +1727,10 @@ static int icom_probe(struct pci_dev *dev,
>   
>   	retval = pci_request_regions(dev, "icom");
>   	if (retval) {
> -		 dev_err(&dev->dev, "pci_request_regions FAILED\n");
> -		 pci_disable_device(dev);
> -		 return retval;
> -	 }
> +		dev_err(&dev->dev, "pci_request_regions FAILED\n");
> +		pci_disable_device(dev);
> +		return retval;
> +	}
>   
>   	pci_set_master(dev);
>   
> @@ -1754,9 +1754,9 @@ static int icom_probe(struct pci_dev *dev,
>   
>   	retval = icom_alloc_adapter(&icom_adapter);
>   	if (retval) {
> -		 dev_err(&dev->dev, "icom_alloc_adapter FAILED\n");
> -		 retval = -EIO;
> -		 goto probe_exit0;
> +		dev_err(&dev->dev, "icom_alloc_adapter FAILED\n");
> +		retval = -EIO;
> +		goto probe_exit0;
>   	}
>   
>   	icom_adapter->base_addr_pci = pci_resource_start(dev, 0);
> @@ -1778,11 +1778,10 @@ static int icom_probe(struct pci_dev *dev,
>   		goto probe_exit1;
>   	}
>   
> -	 /* save off irq and request irq line */
> -	 retval = request_irq(dev->irq, icom_interrupt, IRQF_SHARED, ICOM_DRIVER_NAME, (void *)icom_adapter);
> -	 if (retval) {
> -		  goto probe_exit2;
> -	 }
> +	/* save off irq and request irq line */
> +	retval = request_irq(dev->irq, icom_interrupt, IRQF_SHARED, ICOM_DRIVER_NAME, (void *)icom_adapter);
> +	if (retval)
> +		goto probe_exit2;
>   
>   	retval = icom_load_ports(icom_adapter);
>   
> @@ -1798,11 +1797,11 @@ static int icom_probe(struct pci_dev *dev,
>   			icom_port->uart_port.fifosize = 16;
>   			icom_port->uart_port.ops = &icom_ops;
>   			icom_port->uart_port.line =
> -		        icom_port->port + icom_adapter->index * 4;
> +			icom_port->port + icom_adapter->index * 4;
>   			if (uart_add_one_port (&icom_uart_driver, &icom_port->uart_port)) {
>   				icom_port->status = ICOM_PORT_OFF;
>   				dev_err(&dev->dev, "Device add failed\n");
> -			 } else
> +			} else
>   				dev_info(&dev->dev, "Device added\n");
>   		}
>   	}

-- 
js
suse labs

