Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52C155CF01
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbiF0N7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 09:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiF0N7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 09:59:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A867B49A;
        Mon, 27 Jun 2022 06:59:48 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id t21so9134808pfq.1;
        Mon, 27 Jun 2022 06:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WaB9LDb/1ugCm0MZi0f1VmnmxGApQh/5MPfqBXxkKlE=;
        b=K8g1mBwKNs6ee06SCu4rI40VR8Ot6UQEkWVxeGKYeSkE7TNuZ7vXXUMJgVC6n/7LSB
         XXmxl0t6x8AINPAvqrAz7tBK+PHLWXHhPCJV5VK00/jGcGqYaCGd/qqfy+cfQsWF/HMU
         S6o1tNYd6vOAWhmuiv+5VP5o2lNthqdBsuDP4stREd8FHbarsKm7SUEmNL7SDdRp7C7r
         XPPWGFwj+dO5IW/5lFq9gi72COOmk4GpAKsJ36TU5NORjPVJ9dL45kgcGaNbLL6B5Hau
         Bi+0hEt2lCpaLWWfuCladJJLtbraVaf58AkZKSiM38e1BEeBc70j8rV36bVtAGQKZR+7
         bSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WaB9LDb/1ugCm0MZi0f1VmnmxGApQh/5MPfqBXxkKlE=;
        b=foOG5axpaWUG6Ll7IYGTcT+YzxN+neB39Z3YCp4XaGMifn7Uj8bR6oKg4K7ZMaFZCF
         AATnilKpp+zmOthlFsry8TMgkNnS3b4o6daEoArIYJDvoBJ6mMRJYxCtNUpRZDgyKftZ
         4p6rg2GLb1CarJhsuLIvWBsC2mVTuCI4sybMLPo9euzq2Gc6lJujAfsi5qJ5QpJlMyQB
         ixGXpkRHKLETM1NbymPdwTM9QjgYh8c9/KdjuVdvYedUcv4EywxhDrxttsmzXdnUjSNw
         eFdovuF6jTNJI0xjPk7/8sTxaU+KGlz07PikBUSc4dODSQuW6modjMI0PxyLMCu9S+CD
         4rpg==
X-Gm-Message-State: AJIora8sIzBVfiZ/G+2be2URzCG4fsN5vnUXHDKg6BFH0TnUT1YH8oES
        4oYrxtxW5WL/44uoSuMbBtyuzTIaGBU=
X-Google-Smtp-Source: AGRyM1vGRfm7ps7k0HmHiQSxD7aIYodqJ/+aHLX6xuSY2rELiC4AXQ7iNs7refvsS3zT4wPMCJwkPg==
X-Received: by 2002:a63:698a:0:b0:40c:4714:2425 with SMTP id e132-20020a63698a000000b0040c47142425mr12455886pgc.548.1656338387909;
        Mon, 27 Jun 2022 06:59:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p22-20020a1709027ed600b0016a0fe1a1fbsm7275275plb.220.2022.06.27.06.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 06:59:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5e7390c3-8f86-e2a0-83af-ef1f9e6bc100@roeck-us.net>
Date:   Mon, 27 Jun 2022 06:59:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v11 1/3] usb: typec: tcpci: move tcpci.h to
 include/linux/usb/
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20220627044331.2180641-1-xji@analogixsemi.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20220627044331.2180641-1-xji@analogixsemi.com>
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

On 6/26/22 21:43, Xin Ji wrote:
> USB PD controllers which consisting of a microcontroller (acting as the TCPM)
> and a port controller (TCPC) - may require that the driver for the PD
> controller accesses directly also the on-chip port controller in some cases.
> 
> Move tcpci.h to include/linux/usb/ is convenience access TCPC registers.
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> 
> ---
> V9 -> V10: Rebase on the latest code
> V8 -> V9 : Add more commit message
> V7 -> V8 : Fix Guanter's comment, remove unnecessary explain
> ---
>   drivers/usb/typec/tcpm/tcpci.c                        | 3 +--
>   drivers/usb/typec/tcpm/tcpci_maxim.c                  | 3 +--
>   drivers/usb/typec/tcpm/tcpci_mt6360.c                 | 3 +--
>   drivers/usb/typec/tcpm/tcpci_rt1711h.c                | 2 +-
>   {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h | 1 +
>   5 files changed, 5 insertions(+), 7 deletions(-)
>   rename {drivers/usb/typec/tcpm => include/linux/usb}/tcpci.h (99%)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci.c b/drivers/usb/typec/tcpm/tcpci.c
> index f33e08eb7670..812784702d53 100644
> --- a/drivers/usb/typec/tcpm/tcpci.c
> +++ b/drivers/usb/typec/tcpm/tcpci.c
> @@ -13,11 +13,10 @@
>   #include <linux/property.h>
>   #include <linux/regmap.h>
>   #include <linux/usb/pd.h>
> +#include <linux/usb/tcpci.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/usb/typec.h>
>   
> -#include "tcpci.h"
> -
>   #define	PD_RETRY_COUNT_DEFAULT			3
>   #define	PD_RETRY_COUNT_3_0_OR_HIGHER		2
>   #define	AUTO_DISCHARGE_DEFAULT_THRESHOLD_MV	3500
> diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.c b/drivers/usb/typec/tcpm/tcpci_maxim.c
> index df2505570f07..4b6705f3d7b7 100644
> --- a/drivers/usb/typec/tcpm/tcpci_maxim.c
> +++ b/drivers/usb/typec/tcpm/tcpci_maxim.c
> @@ -11,11 +11,10 @@
>   #include <linux/module.h>
>   #include <linux/regmap.h>
>   #include <linux/usb/pd.h>
> +#include <linux/usb/tcpci.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/usb/typec.h>
>   
> -#include "tcpci.h"
> -
>   #define PD_ACTIVITY_TIMEOUT_MS				10000
>   
>   #define TCPC_VENDOR_ALERT				0x80
> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> index 8a952eaf9016..1b7c31278ebb 100644
> --- a/drivers/usb/typec/tcpm/tcpci_mt6360.c
> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> @@ -11,10 +11,9 @@
>   #include <linux/of.h>
>   #include <linux/platform_device.h>
>   #include <linux/regmap.h>
> +#include <linux/usb/tcpci.h>
>   #include <linux/usb/tcpm.h>
>   
> -#include "tcpci.h"
> -
>   #define MT6360_REG_PHYCTRL1	0x80
>   #define MT6360_REG_PHYCTRL3	0x82
>   #define MT6360_REG_PHYCTRL7	0x86
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index b56a0880a044..3291ca4948da 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -10,9 +10,9 @@
>   #include <linux/i2c.h>
>   #include <linux/interrupt.h>
>   #include <linux/gpio/consumer.h>
> +#include <linux/usb/tcpci.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/regmap.h>
> -#include "tcpci.h"
>   
>   #define RT1711H_VID		0x29CF
>   #define RT1711H_PID		0x1711
> diff --git a/drivers/usb/typec/tcpm/tcpci.h b/include/linux/usb/tcpci.h
> similarity index 99%
> rename from drivers/usb/typec/tcpm/tcpci.h
> rename to include/linux/usb/tcpci.h
> index b2edd45f13c6..20c0bedb8ec8 100644
> --- a/drivers/usb/typec/tcpm/tcpci.h
> +++ b/include/linux/usb/tcpci.h
> @@ -9,6 +9,7 @@
>   #define __LINUX_USB_TCPCI_H
>   
>   #include <linux/usb/typec.h>
> +#include <linux/usb/tcpm.h>
>   
>   #define TCPC_VENDOR_ID			0x0
>   #define TCPC_PRODUCT_ID			0x2

