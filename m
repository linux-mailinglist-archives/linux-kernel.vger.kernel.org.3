Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 967255909B3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 02:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbiHLA4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 20:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiHLA4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 20:56:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CBB9AFE7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 17:56:16 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q16so18536809pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 17:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc;
        bh=4tM10fzN8O9NGMymRYpYKK+6dgSWKL31dP1iscggUuM=;
        b=qDGyWHAVohAWH43cmQ7Ex2iLjlWnFhWB3gw7UN/lHvMDHc54VyGs7bkGnHD/FAk2bO
         0YAS1FNu9oXVtOP+yxqoFUFTOYCDNsfm6BWeCrW6LCY2eUmFGY0wy7wdBaXogbYtY04L
         RRocHQva12/tHRmJWzBkjovJxvsz3FVmqiO/kskEJoIrUf+re+VXTb6EHorHB4wl8WSU
         h1aZUkQ8nNG/vgjqTsayoMdczqtLY+uiF7O77zsjxWgPy/4J0uyC+pQ2lHhd00NdRXiq
         wC/2GPrufGn84Mo7YwGwa7pRKNQSQW/+wQ6t8UsuChex/O4z5qmNT+UGpkP8qRCNgtAH
         mGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc;
        bh=4tM10fzN8O9NGMymRYpYKK+6dgSWKL31dP1iscggUuM=;
        b=J8OiQo5Gy1FXkwsJJ47OZlHDgoQ2gJWeef+S4cRMDBrSV0co3S+H1bY4lFanCbinzO
         B5wpkPPE6dUBu9AgdHXmO2ogk7o18DDWDy2ht9AuUCYDMnLDsSeoUzyb9/LUp0liP8az
         zBCEo850W89qjPoGnvheMqGBXbwN5nhVE1ncE11fWWFN1fHWJmtDZsM2F5lUZioEj+ak
         t+bcLnF94Yk8t8GqMqaaTx9eFA8B3uKPEdzLdb1hRaDqNm4RarwxWJA5G5Y4HDdsWUZe
         7jT5/LsAFy03LntxokqA8c5DG8myDzgXhGWIZfIYPdddbc5PEJlNW044GXE+rgEEj3uG
         cC0w==
X-Gm-Message-State: ACgBeo219RC6hOsVc2NQwqpzpajuyi1N2jVhtMhxH91oyZxeFjagJFMG
        uGcX29x8XoyNnhFtKDhlg1k=
X-Google-Smtp-Source: AA6agR4g5Um5S4DkE5wmpr5pLgsRKSJozlV0CcV8hWKUUEzbLsWjza571Xe7TcDvSQjQ3liC0UHNeQ==
X-Received: by 2002:a63:1751:0:b0:41c:daad:4ad5 with SMTP id 17-20020a631751000000b0041cdaad4ad5mr1246237pgx.226.1660265775616;
        Thu, 11 Aug 2022 17:56:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i14-20020a654d0e000000b0041d043200fdsm341277pgt.28.2022.08.11.17.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 17:56:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <baa22854-1286-5f63-c537-a6d3d5c12f76@roeck-us.net>
Date:   Thu, 11 Aug 2022 17:56:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1] driver core: Don't probe devices after
 bus_type.match() probe deferral
Content-Language: en-US
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
References: <20220811190747.797081-1-isaacmanjarres@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220811190747.797081-1-isaacmanjarres@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/22 12:07, Isaac J. Manjarres wrote:
> Both __device_attach_driver() and __driver_attach() check the return
> code of the bus_type.match() function to see if the device needs to be
> added to the deferred probe list. After adding the device to the list,
> the logic attempts to bind the device to the driver anyway, as if the
> device had matched with the driver, which is not correct.
> 
> If __device_attach_driver() detects that the device in question is not
> ready to match with a driver on the bus, then it doesn't make sense for
> the device to attempt to bind with the current driver or continue
> attempting to match with any of the other drivers on the bus. So, update
> the logic in __device_attach_driver() to reflect this.
> 
> If __driver_attach() detects that a driver tried to match with a device
> that is not ready to match yet, then the driver should not attempt to bind
> with the device. However, the driver can still attempt to match and bind
> with other devices on the bus, as drivers can be bound to multiple
> devices. So, update the logic in __driver_attach() to reflect this.
> 
> Fixes: 656b8035b0ee ("ARM: 8524/1: driver cohandle -EPROBE_DEFER from bus_type.match()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/base/dd.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> 
> Guenter,
> 
> Thanks for testing this patch out. Can you please add your "Tested-by"?
> 
> --Isaac
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index 70f79fc71539..90b31fb141a5 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -881,6 +881,11 @@ static int __device_attach_driver(struct device_driver *drv, void *_data)
>   		dev_dbg(dev, "Device match requests probe deferral\n");
>   		dev->can_match = true;
>   		driver_deferred_probe_add(dev);
> +		/*
> +		 * Device can't match with a driver right now, so don't attempt
> +		 * to match or bind with other drivers on the bus.
> +		 */
> +		return ret;
>   	} else if (ret < 0) {
>   		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
>   		return ret;
> @@ -1120,6 +1125,11 @@ static int __driver_attach(struct device *dev, void *data)
>   		dev_dbg(dev, "Device match requests probe deferral\n");
>   		dev->can_match = true;
>   		driver_deferred_probe_add(dev);
> +		/*
> +		 * Driver could not match with device, but may match with
> +		 * another device on the bus.
> +		 */
> +		return 0;
>   	} else if (ret < 0) {
>   		dev_dbg(dev, "Bus failed to match device: %d\n", ret);
>   		return ret;

