Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15165A5636
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiH2Vbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiH2Vb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:31:27 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE7399B5E;
        Mon, 29 Aug 2022 14:30:39 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id q81so7713221iod.9;
        Mon, 29 Aug 2022 14:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ZzLF3Zpb2/6xSumnVVpMWDck1aMiBeVtZex1RW6P1FI=;
        b=mmkgecyQE1OTUA7TBoutytmXccFptEA8GgRHydXKbCjhJ9/4LEJHA2yYgXFLZ3vDvr
         t6t7xGbEV5IUrxMsmBwWfqagADcjaWjmxpMH8fa1CujXCi/SJ/wv//bUGFC9nlLmoKAk
         iTESS9NS/78WtZmxaGLpkgYtn78DYo9u4FLRfF3nQJpu9Y0WToxNRNEOplLNV736bnKU
         QUOutt3PJ89MkCoK85UrCpSQln1c7UsZwVrD2pextscsD+s9rfClPpiu5qoXRw6vk5E/
         OD5NvxMbTqgM4GbKaJd/CSNgoL1qOHVoO4Wt6yueZtCCQDGWicvYrtw6jDrkvx0jvbea
         K0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ZzLF3Zpb2/6xSumnVVpMWDck1aMiBeVtZex1RW6P1FI=;
        b=lDtVammyDC8zOUVBYG/qMxSy8sknuYrxQhXRXioFLymo6khCZWeiWUbWBiX2mlfPuS
         F4ICkJcsG/7csa8dQxivoBRHVSQnDYn0P/Mm0Xq/RNuCnK/IOamqd7lGhxDM2GBEIgHc
         rKBovFOqP38DoYcCleP3zHtpi6hNOkIpyRscQ6cjWaN0ufaQ19F/bbridEFO3G1EZbpN
         WyuQtwBvt7G/jCktQcchz85R9LYx6FJf9o4HfYDrKh4YkBXh+rRoWFqnhUSkQsBAei1j
         wEyElqMeLfmYuhHRyJ02I96Wn5AOdvKSEL8dJ1BIBBHVpaW8UfyCf/CsABBHoxJh6KEk
         ulIg==
X-Gm-Message-State: ACgBeo0tq2Nc+jun0wDu9EhzUYeM1+nR8xgYgZnuF8OlVce8IAo9akbp
        9MnrXlHyE3+aV5392U6rlXo=
X-Google-Smtp-Source: AA6agR4A46YqPYgmjacBLOtKx0hpt07rHl9E8iNpwSKM7/zuZLvPzv1bo8ejDH+Cl7gKH6/N09cOXQ==
X-Received: by 2002:a05:6638:1485:b0:348:b986:6e62 with SMTP id j5-20020a056638148500b00348b9866e62mr11001575jak.236.1661808591586;
        Mon, 29 Aug 2022 14:29:51 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:1485:e42c:9c81:f760? ([2600:1700:2442:6db0:1485:e42c:9c81:f760])
        by smtp.gmail.com with ESMTPSA id i189-20020a6bb8c6000000b0068acff8cfe7sm5582926iof.44.2022.08.29.14.29.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 14:29:51 -0700 (PDT)
Message-ID: <8c436553-e35c-4e46-1407-24184fd113ba@gmail.com>
Date:   Mon, 29 Aug 2022 16:29:50 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH -next 3/4] spi: mockup: Add runtime device tree overlay
 interface
Content-Language: en-US
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20220826144341.532265-1-weiyongjun1@huawei.com>
 <20220826144341.532265-4-weiyongjun1@huawei.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220826144341.532265-4-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

comment inline below, plus adding to cc: and to: list

On 8/26/22 09:43, Wei Yongjun wrote:
> Add a runtime device tree overlay interface for device need dts file.
> With it its possible to use device tree overlays without having to use
> a per-platform overlay manager.

Why is an overlay needed?  The documentation in patch 4 shows providing
a dtb as an argument to the qemu-system-x86_64 command, which should be
sufficient to supply the appropriate dtb.

-Frank

> 
> Add a new device by command:
> $ cat test.dtbo > /sys/class/spi_master/spi0/overlay_fdto
> 
> Remove the device by command:
> $ echo remove > /sys/class/spi_master/spi0/overlay_fdto
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/spi/Kconfig      |  2 ++
>  drivers/spi/spi-mockup.c | 48 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index e0f0fa2746ad..4b7c84ddb367 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -1161,6 +1161,8 @@ config SPI_TLE62X0
>  config SPI_MOCKUP
>  	tristate "SPI controller Testing Driver"
>  	depends on OF
> +	select OF_EARLY_FLATTREE
> +	select OF_RESOLVE
>  	select BPF_EVENTS
>  	help
>  	  This enables SPI controller testing driver, which provides a way to
> diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
> index 7a93b194ee53..404ad821bf6a 100644
> --- a/drivers/spi/spi-mockup.c
> +++ b/drivers/spi/spi-mockup.c
> @@ -21,6 +21,9 @@
>  struct mockup_spi {
>  	struct mutex lock;
>  	struct spi_device *devs[MOCKUP_CHIPSELECT_MAX];
> +
> +	void *fdto;
> +	int ovcs_id;
>  };
>  
>  static struct spi_master *to_spi_master(struct device *dev)
> @@ -145,9 +148,53 @@ delete_device_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_WO(delete_device);
>  
> +static ssize_t
> +overlay_fdto_store(struct device *dev, struct device_attribute *attr,
> +		   const char *buf, size_t count)
> +{
> +	struct spi_master *master = to_spi_master(dev);
> +	struct mockup_spi *mock = spi_master_get_devdata(master);
> +	int ret;
> +
> +	mutex_lock(&mock->lock);
> +
> +	if (strncmp(buf, "remove\n", count) == 0) {
> +		if (mock->ovcs_id < 0) {
> +			ret = -ENOENT;
> +			goto out_unlock;
> +		}
> +		of_overlay_remove(&mock->ovcs_id);
> +		kfree(mock->fdto);
> +		mock->ovcs_id = -1;
> +		mock->fdto = NULL;
> +	} else {
> +		if (mock->ovcs_id >= 0) {
> +			ret = -EINVAL;
> +			goto out_unlock;
> +		}
> +		mock->fdto = kmemdup(buf, count, GFP_KERNEL);
> +		if (!mock->fdto) {
> +			ret = -ENOMEM;
> +			goto out_unlock;
> +		}
> +		ret = of_overlay_fdt_apply(mock->fdto, count, &mock->ovcs_id);
> +		if (ret < 0)
> +			goto out_unlock;
> +	}
> +
> +	mutex_unlock(&mock->lock);
> +	return count;
> +
> +out_unlock:
> +	mutex_unlock(&mock->lock);
> +	return ret;
> +}
> +static DEVICE_ATTR_WO(overlay_fdto);
> +
>  static struct attribute *spi_mockup_attrs[] = {
>  	&dev_attr_new_device.attr,
>  	&dev_attr_delete_device.attr,
> +	&dev_attr_overlay_fdto.attr,
>  	NULL
>  };
>  ATTRIBUTE_GROUPS(spi_mockup);
> @@ -227,6 +274,7 @@ static int spi_mockup_probe(struct platform_device *pdev)
>  
>  	mock = spi_master_get_devdata(master);
>  	mutex_init(&mock->lock);
> +	mock->ovcs_id = -1;
>  
>  	ret = spi_register_master(master);
>  	if (ret) {

