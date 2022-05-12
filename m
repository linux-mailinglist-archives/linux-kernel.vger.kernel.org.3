Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EED8B52588E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359585AbiELXlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356155AbiELXl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:41:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E36355238;
        Thu, 12 May 2022 16:41:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 4so8343053ljw.11;
        Thu, 12 May 2022 16:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=G9cI8oakPHDWuYiFFBljDMZOYZw1Mkbjku3GoliHgFc=;
        b=B1CWBB64xhJMs/rCx2iqfL051WBSe6GmObrHiL6dcQS4u1h2Qbg/ERH9H4HRimJgDg
         b0hSi2MG4MAjmJ/kCWp3CwdIgUc3HSawGHNIugpWO7R0u/C1NbkrksHdO/D0f1iWCNYd
         n1UBNCZXvxNK3rr0MoaztpnEvhJrloJxdyzjF/LwGdx6rC3iaVGBjixqpAUFf1iCL7Xa
         12X3eew/mY8/ZrjP+Zoo2XIG4zCF7gIKYtgivbk7HzLnpKAkBKJiYtOwkNrhMJ0PqcIL
         UuLxxLlXEKfCEQgmQHbCNPkIKBj84nYfrGV3j2TxoxDrsCTuhg/deS1oyRZNfx256FHn
         wb4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G9cI8oakPHDWuYiFFBljDMZOYZw1Mkbjku3GoliHgFc=;
        b=MC8Y1rwyg+TzbHpVIcUgszW4RbV8aBTix3z8i+J3PjupcjcNg1bOTKrc1a+QLwk6hp
         rN9fQOsyrvFrQ7el8pdqM50WmvuJEc0mxMx7khb4nD1cBFD0zQF5HLD/UF35h2rKJR+y
         3zrH3mrp7CX8W26nHs06dPxbdZUYC/uqt0d47ZKlSh0WeacZmP5Lrc7w3ntGdydgW39t
         zynohZdwz2gHhPjcvLoML9ORzoqcKB2WmbzJvv6RfAJ4ntrN3g6J5Dcu90h7MuDUcmpX
         6ReluERcNKfIatMXTO+IT+Zf2yx0sPK+VUL8dbEKDDMN8N5v9FGfSC0WdEBPWR0wjh6P
         l2Pw==
X-Gm-Message-State: AOAM532L9JtIbXZm+ufl+r81ocm08uBtEQrYwixsl4TL4aHzPyBlrYAo
        rzsJ+cCZ7pTjvhPngR+cRaA=
X-Google-Smtp-Source: ABdhPJwaQgFD0cDr5u0ciJIbXgKaZTOsbiK0ek+aumlxU+KPyzV5SgDLiKuo8X2jVB9AGFXrWuo9yw==
X-Received: by 2002:a05:651c:160b:b0:24d:a0fa:26cc with SMTP id f11-20020a05651c160b00b0024da0fa26ccmr1449169ljq.150.1652398884840;
        Thu, 12 May 2022 16:41:24 -0700 (PDT)
Received: from [192.168.2.145] (109-252-137-244.dynamic.spd-mgts.ru. [109.252.137.244])
        by smtp.googlemail.com with ESMTPSA id g10-20020ac2538a000000b0047255d2111asm134998lfh.73.2022.05.12.16.41.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:41:24 -0700 (PDT)
Message-ID: <7a681440-a9bf-d63f-f090-efc96a7b3efe@gmail.com>
Date:   Fri, 13 May 2022 02:41:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 3/3] iio: light: Add support for ltrf216a sensor
Content-Language: en-US
To:     Shreeya Patel <shreeya.patel@collabora.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, Zhigang.Shi@liteon.com,
        krisman@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        alvaro.soliverez@collabora.com
References: <20220511094024.175994-1-shreeya.patel@collabora.com>
 <20220511094024.175994-4-shreeya.patel@collabora.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20220511094024.175994-4-shreeya.patel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

11.05.2022 12:40, Shreeya Patel пишет:
> +static int ltrf216a_probe(struct i2c_client *client)
> +{
> +	struct ltrf216a_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);
> +	data->client = client;
> +
> +	mutex_init(&data->mutex);
> +
> +	indio_dev->info = &ltrf216a_info;
> +	indio_dev->name = LTRF216A_DRV_NAME;
> +	indio_dev->channels = ltrf216a_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ltrf216a_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = ltrf216a_init(indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "ltrf216a chip init failed\n");

Is it possible to enable sensor only when measurement is made for more
power savings? Light sensor shouldn't consume much power, but nevertheless.

You'll need to add msleep(power_on_delay + resolution_rate_delay) after
enabling sensor and before reading the measurement to wait until
measurement is made by h/w.
