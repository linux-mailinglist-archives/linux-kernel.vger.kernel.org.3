Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861C4B9E46
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiBQLDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:03:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239497AbiBQLDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:03:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E64897B8D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:01:25 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id bg21-20020a05600c3c9500b0035283e7a012so3782178wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 03:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QXC2GiLyRlkqPnLb5RTTqLhrVnBmNGVL+2tFHU8g1sI=;
        b=CtUdkgz2hg93fo3XUEKwndi79ezxDuyHljn03vTtZrEXhCgOIIegtqY8XTc8yN48Pz
         VIitZ95P+D9FHuit6ONJBVLLpHzqILZ19XOnVFgbJ6+7YT79pOwqRa9kC/iF6+ojhuJG
         /Wy8nrw/nYjUKUvr9oPVWdBiTv7hU4M1FtcUBxP/+PGJMZSVwcV1lJKebYNCLhzj2fdG
         axNpEkmz1RwlxzA9YIP2NhHZk2+GnIMVr1Q9VqaNlo9Q/83IwuOAx1eE3cuvULYt69Y6
         cz2SrSfdpbDaGYENK6PHTFxc+dz5dipVW3urJ4tvt8/q14yQYLlUfrnpWZDTq6B+Y6ZY
         bBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QXC2GiLyRlkqPnLb5RTTqLhrVnBmNGVL+2tFHU8g1sI=;
        b=JEWirl3xVz/SmSdQSJutTfOY1l92MZA+5VVOK3mg1YrIjeYXw//OffHIYL2SW9SIyX
         ML4Sp8V1V073VPGvRRaluwfaOsKrdxt6jIoLDZ91UaXig9Y6yzV8X2jXBYHMba86uk2R
         fgUYTelya5zxdRYHMIOKAV3a/qiJ2SKtvaVLOi033Ts6rDvstqL17wKpZ4ho0sut7RVW
         hb5+cZLWS3p4wbjIO2wCmibwLDYwVS9RIBUvxEmGP4v9A6LjN3xGt2Od0sLdoEtZDxXe
         UC9hgCfbIZEX7dewhD0PMPH9XS1nJfu9vSwOMIqLuVyqJR+M5MjfFfcPMk7m7RCQUcNw
         sFMw==
X-Gm-Message-State: AOAM533m4I4aE2FS/16FPXR5jUme/hCUR0ScNtEPBgn6PIBRX/nnI96U
        Xg9+igZBox6QevtHSRW6TD/6dA==
X-Google-Smtp-Source: ABdhPJwo6VBJNlSl7oeCrwIVAZva1FiIsBkDn9KyEqH3zZAZH3PrJSWbG1QTWYEUSOT0J0m0fv0Hng==
X-Received: by 2002:a05:600c:224a:b0:37b:b620:77cf with SMTP id a10-20020a05600c224a00b0037bb62077cfmr5546414wmm.5.1645095683659;
        Thu, 17 Feb 2022 03:01:23 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id m22sm968413wmq.35.2022.02.17.03.01.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 03:01:23 -0800 (PST)
Message-ID: <1bd281d8-a576-26dc-79c3-b1a72a4a9691@linaro.org>
Date:   Thu, 17 Feb 2022 11:01:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] nvmem: core: Fix a conflict between MTD and NVMEM
 on wp-gpios property
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, chenshumin86@sina.com
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
 <20220131095755.8981-4-christophe.kerello@foss.st.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20220131095755.8981-4-christophe.kerello@foss.st.com>
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



On 31/01/2022 09:57, Christophe Kerello wrote:
> Wp-gpios property can be used on NVMEM nodes and the same property can
> be also used on MTD NAND nodes. In case of the wp-gpios property is
> defined at NAND level node, the GPIO management is done at NAND driver
> level. Write protect is disabled when the driver is probed or resumed
> and is enabled when the driver is released or suspended.
> 
> When no partitions are defined in the NAND DT node, then the NAND DT node
> will be passed to NVMEM framework. If wp-gpios property is defined in
> this node, the GPIO resource is taken twice and the NAND controller
> driver fails to probe.
> 
> It would be possible to set config->wp_gpio at MTD level before calling
> nvmem_register function but NVMEM framework will toggle this GPIO on
> each write when this GPIO should only be controlled at NAND level driver
> to ensure that the Write Protect has not been enabled.
> 
> A way to fix this conflict is to add a new boolean flag in nvmem_config
> named skip_wp_gpio. In case skip_wp_gpio is set, the GPIO resource will
> be managed by the provider.
> 
> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> ---
> Changes in v2:
>   - rework the proposal done to fix a conflict between MTD and NVMEM on
>     wp-gpios property.
> 
>   drivers/nvmem/core.c           | 2 +-
>   include/linux/nvmem-provider.h | 4 +++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> index 23a38dcf0fc4..cb40dca6a51d 100644
> --- a/drivers/nvmem/core.c
> +++ b/drivers/nvmem/core.c
> @@ -771,7 +771,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>   
>   	if (config->wp_gpio)
>   		nvmem->wp_gpio = config->wp_gpio;
> -	else
> +	else if (!config->skip_wp_gpio)
>   		nvmem->wp_gpio = gpiod_get_optional(config->dev, "wp",
>   						    GPIOD_OUT_HIGH);
>   	if (IS_ERR(nvmem->wp_gpio)) {
> diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
> index 98efb7b5660d..4b480023c265 100644
> --- a/include/linux/nvmem-provider.h
> +++ b/include/linux/nvmem-provider.h
> @@ -70,7 +70,8 @@ struct nvmem_keepout {
>    * @word_size:	Minimum read/write access granularity.
>    * @stride:	Minimum read/write access stride.
>    * @priv:	User context passed to read/write callbacks.
> - * @wp-gpio:   Write protect pin
> + * @wp-gpio:	Write protect pin
> + * @skip_wp_gpio: Write Protect pin is managed by the provider.

Can we rename this to ingore_wp as suggested by Miquel.

--srini

>    *
>    * Note: A default "nvmem<id>" name will be assigned to the device if
>    * no name is specified in its configuration. In such case "<id>" is
> @@ -92,6 +93,7 @@ struct nvmem_config {
>   	enum nvmem_type		type;
>   	bool			read_only;
>   	bool			root_only;
> +	bool			skip_wp_gpio;
>   	struct device_node	*of_node;
>   	bool			no_of_node;
>   	nvmem_reg_read_t	reg_read;
