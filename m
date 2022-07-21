Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E15D57CDA1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiGUO2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiGUO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:28:41 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F8481B2D;
        Thu, 21 Jul 2022 07:28:40 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gq7so1788470pjb.1;
        Thu, 21 Jul 2022 07:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OfcldsUYcrOEyIt2CLImgPg5DvswWpgg66XsCaqPrOU=;
        b=BdGgRiU2u06go9lOoa4UL9FGbgOqkBa3Murk2hDohnWrYk0/t+9zylUNrTbq8otAO+
         HwDFdceVCL2WbzsUSshaR3BY4CeQrkMvaOBuboYh9jh8I5RRdsRgTE8YvWT/fPN3R6+M
         C3OChpVo3fitN8wZ8etszjerJ7dckSbaNDtcf2zQCkmHylzp80kndK2QsXGDlC1jyKJg
         AG+MzMuYKXiqITnIJ6IRbcJhiz/gkj4bX6lgT3AclWXMbLAS3YezIkJmXjQiQOPa++cO
         S/U2ncvcxpJyvZ3jQBfEB4BY/1rlWQy0A34YyxZtwpymyvN/bCZQaeimi0z749dhZ/C/
         tAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OfcldsUYcrOEyIt2CLImgPg5DvswWpgg66XsCaqPrOU=;
        b=fCuQQ26tSpg4qvoZgs+SmP4sru3FItFQK3L5D6rbqnIIek2PJiAPEEUKthZkJT9NPZ
         8VFmiv191vd/eFTXBrce7RyCtUgJNnP8xr6Jj7VOaiqacPjhBwskqiP/q4dQJF+gB2gl
         ZrTsVK2KUdAoc8kGgKK+MwhrP4i+VJQvQjmJf5VnXmxvGnIWUbfg4B2IhtFmhzDBGxrF
         u+ncoq02omDSXBPQ9fB/+Z3GzccBZo6kpMQlFUxtsKDTr9z/EVHvxEc1CRqI0XIVSVl5
         qCndWO+6f7VT4o2AEkm6nZgUxUT3GyJYlZiEW6yhM4wHMSQhUz6rik7NiBqvySVeeGv7
         D+9Q==
X-Gm-Message-State: AJIora9+yNVN17EFKQ+81XoaclaCfoEoW0lDwuEsgRmxRYSXwIcwq2AY
        SrReAbZ/b5EElUMKZapWb4ZblxE6paL0dw==
X-Google-Smtp-Source: AGRyM1vPJfRySFOgRa+GTX0iM4ghXVTP2cdzllDRWEGiyMeBm9pHRQvGi4EDBOHMgQ0eZBX3CN4dZg==
X-Received: by 2002:a17:902:a516:b0:16c:ef6f:fec7 with SMTP id s22-20020a170902a51600b0016cef6ffec7mr21377569plq.140.1658413719898;
        Thu, 21 Jul 2022 07:28:39 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s4-20020a170903200400b0016c67a3b7d0sm1733039pla.61.2022.07.21.07.28.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:28:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0675b483-9d51-30bc-a51d-9b9f2a0acb51@roeck-us.net>
Date:   Thu, 21 Jul 2022 07:28:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2 3/6] usb: typec: tcpci_rt1711h: Add regulator support
 when source vbus
Content-Language: en-US
To:     Gene Chen <gene.chen.richtek@gmail.com>,
        heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, gene_chen@richtek.com,
        cy_huang@richtek.com
References: <20220721061144.35139-1-gene.chen.richtek@gmail.com>
 <20220721061144.35139-4-gene.chen.richtek@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220721061144.35139-4-gene.chen.richtek@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/22 23:11, Gene Chen wrote:
> From: Gene Chen <gene_chen@richtek.com>
> 
> Add regulator support when source vbus
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>   drivers/usb/typec/tcpm/tcpci_rt1711h.c | 28 ++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 3309ceace2b2..52c9594e531d 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -10,6 +10,7 @@
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/regulator/consumer.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/regmap.h>
>   #include "tcpci.h"
> @@ -40,6 +41,8 @@ struct rt1711h_chip {
>   	struct tcpci_data data;
>   	struct tcpci *tcpci;
>   	struct device *dev;
> +	struct regulator *vbus;
> +	bool src_en;
>   };
>   
>   static int rt1711h_read16(struct rt1711h_chip *chip, unsigned int reg, u16 *val)
> @@ -103,6 +106,26 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>   
>   	/* dcSRC.DRP : 33% */
>   	return rt1711h_write16(chip, RT1711H_RTCTRL16, 330);
> +
> +}
> +
> +static int rt1711h_set_vbus(struct tcpci *tcpci, struct tcpci_data *tdata,
> +			    bool src, bool snk)
> +{
> +	struct rt1711h_chip *chip = tdata_to_rt1711h(tdata);
> +	int ret;
> +
> +	if (chip->src_en == src)
> +		return 1;
> +
> +	if (src)
> +		ret = regulator_enable(chip->vbus);
> +	else
> +		ret = regulator_disable(chip->vbus);
> +
> +	if (!ret)
> +		chip->src_en = src;
> +	return ret ? ret : 1;

Are you sure this is what you want ? Returning 1 bypasses the code setting
the vbus registers in tcpci.c. If that is on purpose it might make sense
to explain it.

>   }
>   
>   static int rt1711h_set_vconn(struct tcpci *tcpci, struct tcpci_data *tdata,
> @@ -246,7 +269,12 @@ static int rt1711h_probe(struct i2c_client *client,
>   	if (ret < 0)
>   		return ret;
>   
> +	chip->vbus = devm_regulator_get(&client->dev, "vbus");
> +	if (IS_ERR(chip->vbus))
> +		return PTR_ERR(chip->vbus);
> +

This makes regulator support mandatory, which so far was not the case.
That warrants an explanation why it is not a problem for existing users.

Thanks,
Guenter

>   	chip->data.init = rt1711h_init;
> +	chip->data.set_vbus = rt1711h_set_vbus;
>   	chip->data.set_vconn = rt1711h_set_vconn;
>   	chip->data.start_drp_toggling = rt1711h_start_drp_toggling;
>   	chip->tcpci = tcpci_register_port(chip->dev, &chip->data);

