Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0983E4B78AC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243898AbiBOUC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:02:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243885AbiBOUCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:02:21 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD5B716D5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:10 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id h11so15695560ilq.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=j6yzblNIh7GBPG01Iqlw4sEfSi9/BIdDaQd3RWTaPao=;
        b=wLsY14/W4+dT47aiEdJxYLYrG1moQi+LyMpakGCuEEkTG/szNSyqTzWOb/kEM9hbVv
         rHKxXud1iXQwGWOH2xo6mtd7yH9VfqaxdvL4WRabFIlIkw5XRxdoSnTSVESQhbxO3raX
         Lq+Qy5Yr8Ua6Rlo9CC3CrntI4f7hQ1qa59BKAayoeYakSUrI1VQjpDRAbvzvKmIE9Rhq
         HwMXTrU16r1+0sJ7DlzdFrckjWuSfvpeZ6654Xmr57U+rDk1cwhHIxLkMbB49GpaJZV+
         7wWY/6IxAzFHqo+PtCH5UsAjxUzvGvyKqGYuHUhHZOI/31SsDBkMProiNvkQehjFuf7n
         3b7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=j6yzblNIh7GBPG01Iqlw4sEfSi9/BIdDaQd3RWTaPao=;
        b=X7AhgGSJqCsIJaAhWSJm88PHWFFVIUYLh7/XAL+/0nco4cUZFtVGUHcb2NjvSS1z52
         wEtz0ZQHzbqxGehnFHk6S3G+vmB7J2dynYs+eLhhBWNpI65z765ygrmXuxbio2zH6lgf
         ULkLN+e53gH+oLeoVyUSiioH4ROFjTSUIdzIrhm+je5Nya4zBMIhRzWrzFVJqu4wZz0/
         8Ga802JfrQoKzhAV9ahv9XiJUpMK7eaeo9CieepPEbMkKdUybwEf5PeIfepbpJp+w9V3
         P8m+VLWwN8IUNKDTgFmRhlG5XizFF0RMObPltNPoBFVT+sOO7LtfaKzXnnwqyeYSCbDA
         OoEQ==
X-Gm-Message-State: AOAM530zTVvR2B7a7esBTg2a+cbwpTrbj8m+The/f4L4GLOynXKzjfnn
        wIPpdS2xNEXl7nHW5rqRv7M18A==
X-Google-Smtp-Source: ABdhPJxlroYJjMlgguP10JDfB6p5ksqbjWHGbNkTwJqoWzt+3Dm7B99SVyb5mZYHAP1zGpvkYA0kfQ==
X-Received: by 2002:a05:6e02:214d:: with SMTP id d13mr457198ilv.90.1644955329808;
        Tue, 15 Feb 2022 12:02:09 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id h1sm640190ioz.50.2022.02.15.12.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 12:02:09 -0800 (PST)
Message-ID: <06bc5515-b464-0185-1af7-4a12f0e690f9@linaro.org>
Date:   Tue, 15 Feb 2022 14:02:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 03/25] bus: mhi: Move host MHI code to "host" directory
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        mhi@lists.linux.dev
Cc:     quic_hemantk@quicinc.com, quic_bbhatt@quicinc.com,
        quic_jhugo@quicinc.com, vinod.koul@linaro.org,
        bjorn.andersson@linaro.org, dmitry.baryshkov@linaro.org,
        quic_vbadigan@quicinc.com, quic_cang@quicinc.com,
        quic_skananth@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hemant Kumar <hemantk@codeaurora.org>
References: <20220212182117.49438-1-manivannan.sadhasivam@linaro.org>
 <20220212182117.49438-4-manivannan.sadhasivam@linaro.org>
From:   Alex Elder <elder@linaro.org>
In-Reply-To: <20220212182117.49438-4-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/22 12:20 PM, Manivannan Sadhasivam wrote:
> In preparation of the endpoint MHI support, let's move the host MHI code
> to its own "host" directory and adjust the toplevel MHI Kconfig & Makefile.
> 
> While at it, let's also move the "pci_generic" driver to "host" directory
> as it is a host MHI controller driver.
> 
> Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

This is a pretty simple rename, and it looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   drivers/bus/Makefile                      |  2 +-
>   drivers/bus/mhi/Kconfig                   | 27 ++------------------
>   drivers/bus/mhi/Makefile                  |  8 ++----
>   drivers/bus/mhi/host/Kconfig              | 31 +++++++++++++++++++++++
>   drivers/bus/mhi/{core => host}/Makefile   |  4 ++-
>   drivers/bus/mhi/{core => host}/boot.c     |  0
>   drivers/bus/mhi/{core => host}/debugfs.c  |  0
>   drivers/bus/mhi/{core => host}/init.c     |  0
>   drivers/bus/mhi/{core => host}/internal.h |  0
>   drivers/bus/mhi/{core => host}/main.c     |  0
>   drivers/bus/mhi/{ => host}/pci_generic.c  |  0
>   drivers/bus/mhi/{core => host}/pm.c       |  0
>   12 files changed, 39 insertions(+), 33 deletions(-)
>   create mode 100644 drivers/bus/mhi/host/Kconfig
>   rename drivers/bus/mhi/{core => host}/Makefile (54%)
>   rename drivers/bus/mhi/{core => host}/boot.c (100%)
>   rename drivers/bus/mhi/{core => host}/debugfs.c (100%)
>   rename drivers/bus/mhi/{core => host}/init.c (100%)
>   rename drivers/bus/mhi/{core => host}/internal.h (100%)
>   rename drivers/bus/mhi/{core => host}/main.c (100%)
>   rename drivers/bus/mhi/{ => host}/pci_generic.c (100%)
>   rename drivers/bus/mhi/{core => host}/pm.c (100%)
> 
> diff --git a/drivers/bus/Makefile b/drivers/bus/Makefile
> index 52c2f35a26a9..16da51130d1a 100644
> --- a/drivers/bus/Makefile
> +++ b/drivers/bus/Makefile
> @@ -39,4 +39,4 @@ obj-$(CONFIG_VEXPRESS_CONFIG)	+= vexpress-config.o
>   obj-$(CONFIG_DA8XX_MSTPRI)	+= da8xx-mstpri.o
>   
>   # MHI
> -obj-$(CONFIG_MHI_BUS)		+= mhi/
> +obj-y				+= mhi/
> diff --git a/drivers/bus/mhi/Kconfig b/drivers/bus/mhi/Kconfig
> index da5cd0c9fc62..4748df7f9cd5 100644
> --- a/drivers/bus/mhi/Kconfig
> +++ b/drivers/bus/mhi/Kconfig
> @@ -2,30 +2,7 @@
>   #
>   # MHI bus
>   #
> -# Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
> +# Copyright (c) 2021, Linaro Ltd.
>   #
>   
> -config MHI_BUS
> -	tristate "Modem Host Interface (MHI) bus"
> -	help
> -	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
> -	  communication protocol used by the host processors to control
> -	  and communicate with modem devices over a high speed peripheral
> -	  bus or shared memory.
> -
> -config MHI_BUS_DEBUG
> -	bool "Debugfs support for the MHI bus"
> -	depends on MHI_BUS && DEBUG_FS
> -	help
> -	  Enable debugfs support for use with the MHI transport. Allows
> -	  reading and/or modifying some values within the MHI controller
> -	  for debug and test purposes.
> -
> -config MHI_BUS_PCI_GENERIC
> -	tristate "MHI PCI controller driver"
> -	depends on MHI_BUS
> -	depends on PCI
> -	help
> -	  This driver provides MHI PCI controller driver for devices such as
> -	  Qualcomm SDX55 based PCIe modems.
> -
> +source "drivers/bus/mhi/host/Kconfig"
> diff --git a/drivers/bus/mhi/Makefile b/drivers/bus/mhi/Makefile
> index 0a2d778d6fb4..5f5708a249f5 100644
> --- a/drivers/bus/mhi/Makefile
> +++ b/drivers/bus/mhi/Makefile
> @@ -1,6 +1,2 @@
> -# core layer
> -obj-y += core/
> -
> -obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
> -mhi_pci_generic-y += pci_generic.o
> -
> +# Host MHI stack
> +obj-y += host/
> diff --git a/drivers/bus/mhi/host/Kconfig b/drivers/bus/mhi/host/Kconfig
> new file mode 100644
> index 000000000000..da5cd0c9fc62
> --- /dev/null
> +++ b/drivers/bus/mhi/host/Kconfig
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# MHI bus
> +#
> +# Copyright (c) 2018-2020, The Linux Foundation. All rights reserved.
> +#
> +
> +config MHI_BUS
> +	tristate "Modem Host Interface (MHI) bus"
> +	help
> +	  Bus driver for MHI protocol. Modem Host Interface (MHI) is a
> +	  communication protocol used by the host processors to control
> +	  and communicate with modem devices over a high speed peripheral
> +	  bus or shared memory.
> +
> +config MHI_BUS_DEBUG
> +	bool "Debugfs support for the MHI bus"
> +	depends on MHI_BUS && DEBUG_FS
> +	help
> +	  Enable debugfs support for use with the MHI transport. Allows
> +	  reading and/or modifying some values within the MHI controller
> +	  for debug and test purposes.
> +
> +config MHI_BUS_PCI_GENERIC
> +	tristate "MHI PCI controller driver"
> +	depends on MHI_BUS
> +	depends on PCI
> +	help
> +	  This driver provides MHI PCI controller driver for devices such as
> +	  Qualcomm SDX55 based PCIe modems.
> +
> diff --git a/drivers/bus/mhi/core/Makefile b/drivers/bus/mhi/host/Makefile
> similarity index 54%
> rename from drivers/bus/mhi/core/Makefile
> rename to drivers/bus/mhi/host/Makefile
> index c3feb4130aa3..859c2f38451c 100644
> --- a/drivers/bus/mhi/core/Makefile
> +++ b/drivers/bus/mhi/host/Makefile
> @@ -1,4 +1,6 @@
>   obj-$(CONFIG_MHI_BUS) += mhi.o
> -
>   mhi-y := init.o main.o pm.o boot.o
>   mhi-$(CONFIG_MHI_BUS_DEBUG) += debugfs.o
> +
> +obj-$(CONFIG_MHI_BUS_PCI_GENERIC) += mhi_pci_generic.o
> +mhi_pci_generic-y += pci_generic.o
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/host/boot.c
> similarity index 100%
> rename from drivers/bus/mhi/core/boot.c
> rename to drivers/bus/mhi/host/boot.c
> diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/host/debugfs.c
> similarity index 100%
> rename from drivers/bus/mhi/core/debugfs.c
> rename to drivers/bus/mhi/host/debugfs.c
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/host/init.c
> similarity index 100%
> rename from drivers/bus/mhi/core/init.c
> rename to drivers/bus/mhi/host/init.c
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/host/internal.h
> similarity index 100%
> rename from drivers/bus/mhi/core/internal.h
> rename to drivers/bus/mhi/host/internal.h
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/host/main.c
> similarity index 100%
> rename from drivers/bus/mhi/core/main.c
> rename to drivers/bus/mhi/host/main.c
> diff --git a/drivers/bus/mhi/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> similarity index 100%
> rename from drivers/bus/mhi/pci_generic.c
> rename to drivers/bus/mhi/host/pci_generic.c
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/host/pm.c
> similarity index 100%
> rename from drivers/bus/mhi/core/pm.c
> rename to drivers/bus/mhi/host/pm.c

