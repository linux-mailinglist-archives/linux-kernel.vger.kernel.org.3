Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0849A5258F7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359733AbiEMAa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiEMAax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:30:53 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C551C908;
        Thu, 12 May 2022 17:30:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id s27so8493630ljd.2;
        Thu, 12 May 2022 17:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SzGS5R2H9cN6gNSLBdrOmn5OBr2vHPyOwx7M3pjsPxc=;
        b=KlwwhtF+eJ3KZtgfwlGWZ84vrXWIaLRvgLrHA5/JU+fPUFgF9K88EqxDUyZORZuTn9
         TpjKU8VT4kju5pqG9ZlN3zy5zHiSL57j3cA9fqv2b8xsr8MdaM2j2iOUb5O/iBCY6Gso
         +MAd9Htm6NFMiqvX9WyG24x2x9bVAsvIB7zntPnErCEXpo1LzsvxKdn4zEc79KJYSh4D
         XjejRJdJHNbAkrNmTK8PVp8ZYk6NfOEoibq2jJMLkwAQzEMtnp5JKDEljRAKVyh+Rf+C
         rw0Ji5QEFxLym2jtAHxgUskoT2SZD/FwJ4JlDs+gNfYNjqOh/zZXrS3RHH2gHqtXAKHh
         fIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SzGS5R2H9cN6gNSLBdrOmn5OBr2vHPyOwx7M3pjsPxc=;
        b=bO7vvTGHAjR+xSU9GR67H7oIjUh45ZghX6SQUWq7+tUrw6bAe/DUgLCQEkftKkkL0S
         M6EaAn6lwpFpbQOrlHAEnC4IMkW46vXJdX3QIbdunRl69A2C5K7dKPyYejv2zr7QUGBF
         pS56UCwIUe1bTPV1gMM7/WimrhVEq2lgA6WU73knOjb3xZHoJDYqDST6dcnfA9A7KBLr
         g2mQTZTs59as/50297Mm1IiiGmof8zxz+6VH3PGDmhBP8ysI2IUSGmYgIvTzl9rQLogu
         5cwCnrDUtLsCp85MojoTGF5Z/IbPpSTUfJUdcDAJW7kFBcJxqOTLkQ0KUDZUnPcRjGSP
         Jt8A==
X-Gm-Message-State: AOAM532Nof7TrNq9I2NVrAzmyi2KnG2WGx8ExgITEG60kqKmY+OSgTHd
        RuzMqOhjnQbauMekgoYwoGE=
X-Google-Smtp-Source: ABdhPJy7i3II8nI1gMlg6UuXxR1LPphNrAFLLLxipx/LhjAb2J5fuchAyEO2OQoFCgajCroQNmmvyg==
X-Received: by 2002:a2e:bd83:0:b0:24e:fe7b:7235 with SMTP id o3-20020a2ebd83000000b0024efe7b7235mr1536181ljq.409.1652401851065;
        Thu, 12 May 2022 17:30:51 -0700 (PDT)
Received: from [192.168.2.145] (109-252-137-244.dynamic.spd-mgts.ru. [109.252.137.244])
        by smtp.googlemail.com with ESMTPSA id w26-20020ac2599a000000b004726284fe8csm144642lfn.133.2022.05.12.17.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 May 2022 17:30:50 -0700 (PDT)
Message-ID: <a54012e3-291b-42e8-752a-9abc9a88ad6c@gmail.com>
Date:   Fri, 13 May 2022 03:30:49 +0300
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
> +static int ltrf216a_set_int_time(struct ltrf216a_data *data, int itime)
> +{
> +	int i, ret, index = -1;
> +	u8 reg_val;
> +
> +	for (i = 0; i < ARRAY_SIZE(ltrf216a_int_time_available); i++) {
> +		if (ltrf216a_int_time_available[i][1] == itime) {
> +			index = i;
> +			break;
> +		}
> +	}
> +
> +	if (index < 0)
> +		return -EINVAL;
> +
> +	reg_val = ltrf216a_int_time_reg[index][1];
> +	data->int_time_fac = ltrf216a_int_time_reg[index][0];
> +
> +	ret = i2c_smbus_write_byte_data(data->client, LTRF216A_ALS_MEAS_RES, reg_val);
> +	if (ret < 0)
> +		return ret;

Should the data->int_time_fac be updated only if I2C write was successful?

I'm not sure what reading of LTRF216A_CLEAR_DATA reg does, but if it
clears the measured data, then shouldn't the data be cleared after
changing the config?

> +	data->int_time = itime;
> +
> +	return 0;
> +}

