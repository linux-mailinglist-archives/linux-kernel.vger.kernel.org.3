Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D95875258C7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 01:54:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359670AbiELXy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 19:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359678AbiELXyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 19:54:12 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABF7289BE4;
        Thu, 12 May 2022 16:54:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id i10so11706627lfg.13;
        Thu, 12 May 2022 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=37RmwmhetMLvFkUyyZurfNorX4wG33rhqZukIX/qsiU=;
        b=EUZY7FPLyS7TjeYz+IPq2u12F2zw0Ll8ANgdRwDBKYQ2WeQVk5WBloVPPxhlt+UNwl
         zDK9r8QXjBm+Rj4QvwL4S7er5nFV6r0WYlLQ2PM9Y17wCV8feAQiS+iQyL55KnJAuXCO
         qfK9GFHhyKHCoHiQumXm8FcN9ZHaDT6Lpfz6aBzYoX5+f9aBZjYFIKk7KLyKLyc90sX/
         hfLczokeXBKvWnJVCE7nA0RJGlfA/gLewsbyRybyaLcbDLkmT8uX0mYsHj7XcJce80Be
         kuDAg4UTjqkkMYnspWscCvBzbByYjXOowuXtwP82qQ0bhv5uczRm7qLFdB8B/3d1zhP5
         BA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=37RmwmhetMLvFkUyyZurfNorX4wG33rhqZukIX/qsiU=;
        b=yNRQ12/v0ZPEqiiw7FgVtJdb2XxpZcx/TnMsRnv8nDlP1p1FtdQpEKEO6w10vcyNR4
         BfipRzc9/FOuMrmhRTfGUKh3okximaGQ8SrS6nPk97sa1cOQwf1OtozNx+p9oIG6XUeC
         vOLYq69EeT4DjDYqA+Ry4U14AjAc3KuTEIluNRnZGZ5pWyPAzwgf0HeCeeYYL0zcemu3
         E7+iPzuh4HBNFYlKyde6JT4Nqerlr0XfK87f4U1DGGmTBd4qnqfUQf+f8bKYpARjWl3q
         WiIK8+oOIdB0vTW6pDBQ+OpHdXL1zWFs/pCTgPTAYkgrU/kJa3rIFzAeIzDiwkQQYhSn
         aoiA==
X-Gm-Message-State: AOAM533kHyAe0zbPDWCBObg83rjZiA+pAt1hMInzZ/+I/Sc10vaLrqNy
        XQE+GHLapsVXeAuhYERFnLI=
X-Google-Smtp-Source: ABdhPJxl5WFutJe/hQmVHTHau5aGyCXCWmrCg9K/M5Vwj9gKNn3Zy+uLXi32B0pi7RSrZwnH4bO/RA==
X-Received: by 2002:a05:6512:2296:b0:473:cf55:5acd with SMTP id f22-20020a056512229600b00473cf555acdmr1480365lfu.255.1652399650435;
        Thu, 12 May 2022 16:54:10 -0700 (PDT)
Received: from [192.168.2.145] (109-252-137-244.dynamic.spd-mgts.ru. [109.252.137.244])
        by smtp.googlemail.com with ESMTPSA id r13-20020a2eb60d000000b0024f3d1daea8sm158279ljn.48.2022.05.12.16.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 16:54:09 -0700 (PDT)
Message-ID: <a5929558-d09a-cb67-cba9-1dcfb5e43525@gmail.com>
Date:   Fri, 13 May 2022 02:54:08 +0300
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
> +static int ltrf216a_init(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct ltrf216a_data *data = iio_priv(indio_dev);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, LTRF216A_MAIN_CTRL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading LTRF216A_MAIN_CTRL\n");
> +		return ret;
> +	}
> +
> +	/* enable sensor */
> +	ret |= FIELD_PREP(LTRF216A_ALS_ENABLE_MASK, 1);
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing LTRF216A_MAIN_CTRL\n");
> +		return ret;
> +	}

Couldn't you write "1" directly without reading?

What about doing SW reset?
