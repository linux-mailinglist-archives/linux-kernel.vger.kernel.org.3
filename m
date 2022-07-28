Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25A22584598
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbiG1SNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 14:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiG1SNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 14:13:08 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB174DD2;
        Thu, 28 Jul 2022 11:13:07 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id b10so2526703pjq.5;
        Thu, 28 Jul 2022 11:13:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ml9FvlNd98T+yy3OyQJ/DVbtTG7BtOT4jhD/q7sEYls=;
        b=y2vTvH7hWOKDS8EBWePhGijwu+YMNK/fEaf3MOAstnW2MdZOPodAL09DPQYqmlBwEf
         oAKfnpb0uzPMIVN09/LThO182Iax3bB37Dba6s8kuxiZxpPLA0Nawk4opM7Ek2O/N7iH
         pP3LKsoG0rlPjODwhJcBFtj2pfyb+t9WxZnltU6m2mwGAItgQud7XcCu6W6kDBdkrj1D
         5rwR0tOpZ6GoiJuKWzkbkppxL8Hp7/rXxLAkVqh/ZZ+ESOZzJUXf2ZpydRT/gIFzvxRv
         E8VOHKraDPWBch+NdzbjzklQlKPdyI4Ui1xLnTUj0vda4eVTKVfByx7XPSjb3A1SIwdS
         QLkg==
X-Gm-Message-State: ACgBeo2wKFK9pRfHY5Ke7GAGLfWp33F9yFJBQyE0583ctgOaGW6Y6A0l
        V7bHxRMfYZZ5wrWN0MWG5ns=
X-Google-Smtp-Source: AA6agR7a1PG81qWhzTozjr1UAexm/B38BbE80CH6VE9U2yITenJ1L0cIeTGAZDkJkbWsGXeZxgcL+Q==
X-Received: by 2002:a17:902:ccc4:b0:16c:5766:51f9 with SMTP id z4-20020a170902ccc400b0016c576651f9mr89657ple.84.1659031986336;
        Thu, 28 Jul 2022 11:13:06 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:9520:2952:8318:8e3e? ([2620:15c:211:201:9520:2952:8318:8e3e])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902e14c00b0016be368fb30sm1557773pla.212.2022.07.28.11.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Jul 2022 11:13:04 -0700 (PDT)
Message-ID: <2caa16e0-81bb-7d6a-d727-89e2cd0b858d@acm.org>
Date:   Thu, 28 Jul 2022 11:13:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V2] scsi: ufs: Get boot device storage type from command
 line
Content-Language: en-US
To:     Chetan C R <quic_cchinnad@quicinc.com>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
References: <1659029442-19135-1-git-send-email-quic_cchinnad@quicinc.com>
 <1659029442-19135-2-git-send-email-quic_cchinnad@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1659029442-19135-2-git-send-email-quic_cchinnad@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/22 10:30, Chetan C R wrote:
> Get the boot device storage type by reading it from
> kernel command line arguments and export the same
> information to ufs modules.
> 
> Signed-off-by: Chetan C R <quic_cchinnad@quicinc.com>
> ---
>   drivers/ufs/host/Kconfig       | 10 ++++++++
>   drivers/ufs/host/Makefile      |  1 +
>   drivers/ufs/host/ufs-cmdline.c | 54 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 65 insertions(+)
>   create mode 100644 drivers/ufs/host/ufs-cmdline.c
> 
> diff --git a/drivers/ufs/host/Kconfig b/drivers/ufs/host/Kconfig
> index 8259022..02fe817 100644
> --- a/drivers/ufs/host/Kconfig
> +++ b/drivers/ufs/host/Kconfig
> @@ -68,6 +68,16 @@ config SCSI_UFS_QCOM
>   	  Select this if you have UFS controller on QCOM chipset.
>   	  If unsure, say N.
>   
> +config UFS_QCOM_CMDLINE
> +	bool "Get the boot device type from kernel command line for Qcom devices"
> +	default y if ARCH_QCOM
> +	help
> +	  This selects the support of getting the boot device storage type
> +	  from kernel command line arguments and export this information
> +	  to the Qcom UFS controller platform driver.
> +
> +	  If unsure, say N.
> +
>   config SCSI_UFS_MEDIATEK
>   	tristate "Mediatek specific hooks to UFS controller platform driver"
>   	depends on SCSI_UFSHCD_PLATFORM && ARCH_MEDIATEK
> diff --git a/drivers/ufs/host/Makefile b/drivers/ufs/host/Makefile
> index e4be542..a9463f1 100644
> --- a/drivers/ufs/host/Makefile
> +++ b/drivers/ufs/host/Makefile
> @@ -6,6 +6,7 @@ obj-$(CONFIG_SCSI_UFS_CDNS_PLATFORM) += cdns-pltfrm.o
>   obj-$(CONFIG_SCSI_UFS_QCOM) += ufs_qcom.o
>   ufs_qcom-y += ufs-qcom.o
>   ufs_qcom-$(CONFIG_SCSI_UFS_CRYPTO) += ufs-qcom-ice.o
> +obj-$(CONFIG_UFS_QCOM_CMDLINE)          += ufs-cmdline.o
>   obj-$(CONFIG_SCSI_UFS_EXYNOS) += ufs-exynos.o
>   obj-$(CONFIG_SCSI_UFSHCD_PCI) += ufshcd-pci.o
>   obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) += ufshcd-pltfrm.o
> diff --git a/drivers/ufs/host/ufs-cmdline.c b/drivers/ufs/host/ufs-cmdline.c
> new file mode 100644
> index 0000000..408755c
> --- /dev/null
> +++ b/drivers/ufs/host/ufs-cmdline.c
> @@ -0,0 +1,54 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2022, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/printk.h>
> +#include <linux/string.h>
> +
> +#ifdef CONFIG_BOOT_CONFIG
> +#include <linux/bootconfig.h>
> +#endif
> +
> +#define ANDROID_BOOT_DEV_MAX_V3    30
> +
> +static char android_boot_dev_v3[ANDROID_BOOT_DEV_MAX_V3];
> +static const char *android_boot_dev_v4;
> +
> +const char *get_storage_boot_device(void)
> +{
> +	if (android_boot_dev_v4 && strlen(android_boot_dev_v4))
> +		return android_boot_dev_v4;
> +
> +	else if (strlen(android_boot_dev_v3))
> +		return android_boot_dev_v3;
> +
> +	pr_err("Not able to get Bootconfig or Kernel command line param\n");
> +	return NULL;
> +};
> +EXPORT_SYMBOL_GPL(get_storage_boot_device);
> +
> +/* boot image header version 3 android boot device type */
> +static int __init get_android_boot_dev_v3(char *str)
> +{
> +	strscpy(android_boot_dev_v3, str, ANDROID_BOOT_DEV_MAX_V3);
> +	return 1;
> +}
> +__setup("androidboot.bootdevice=", get_android_boot_dev_v3);
> +
> +#ifdef CONFIG_BOOT_CONFIG
> +/* boot image header version 4 android boot device type */
> +static int __init get_android_boot_dev_v4(void)
> +{
> +	struct xbc_node *vnode = NULL;
> +
> +	android_boot_dev_v4 = xbc_find_value("androidboot.bootdevice", &vnode);
> +
> +	if (vnode && xbc_node_is_array(vnode))
> +		xbc_array_for_each_value(vnode, android_boot_dev_v4);
> +
> +	return 0;
> +}
> +fs_initcall(get_android_boot_dev_v4);
> +#endif

I see a similar problem with this patch as with the previous version of 
this patch: if CONFIG_SCSI_UFSHCD=m, __setup() will be an empty macro 
and hence the androidboot.bootdevice parameter won't be parsed.

Bart.
